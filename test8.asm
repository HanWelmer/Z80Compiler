TOS     equ 0FD00H        ;User stack grows before user global data.
CNTLA0  equ 000H          ;144 ASCI0 Control Register A.
STAT0   equ 004H          ;147 ASCI0 Status register.
TDR0    equ 006H          ;148 ASCI0 Transmit Data Register.
RDR0    equ 008H          ;149 ASCI0 Receive Data Register.
ERROR   equ 3             ;CNTLA0->OVRN,FE,PE,BRK error flags.
TDRE    equ 1             ;STAT0->Tx data register empty bit.
OVERRUN equ 6             ;STAT0->OVERRUN bit.
RDRF    equ 7             ;STAT0->Rx data register full bit.
        .ORG  02000H      ;lowest external RAM address.
start:
        LD    SP,TOS
        JP    main
;****************
;WAIT - Wait DE * 1 msec @ 18,432 MHz with no wait states
;  IN:  DE number of msec to wait
;  OUT: none
;  USES: 4 bytes on stack
;****************
WAIT:
        PUSH  DE
        PUSH  AF
WAIT1:
        CALL  WAIT1M      ;Wait 1 msec
        DEC   DE
        LD    A,D
        OR    A,E
        JR    NZ,WAIT1
        POP   AF
        POP   DE
        RET
;****************
;WAIT1M
;wait 1 msec at 18,432 MHz with no wait states
;The routine requires 56+n*22 states, so that with n=834
;28  clock cycles remain left.
;****************
WAIT1M:
        PUSH  HL          ;5      11 (11)
                          ;       3 opcode
                          ;       3 mem write
                          ;       1 inc SP
                          ;       3 mem write
                          ;       1 inc SP
        PUSH  AF          ;5      11 (22)
                          ;       3 opcode
                          ;       3 mem write
                          ;       1 inc SP
                          ;       3 mem write
                          ;       1 inc SP
        LD    HL, 834     ;3      9 (31)
                          ;       3 opcode
                          ;       3 mem read
                          ;       3 mem read
WAIT1M2:
        DEC   HL          ;2      4 (31+n*4)
                          ;       3 opcode
                          ;       1 execute
        LD    A,H         ;2      6 (31+n*10)
                          ;       3 opcode
                          ;       3 execute
        OR    A,L         ;2      4 (31+n*14)
                          ;       3 opcode
                          ;       1 execute
        JR    NZ,WAIT1M2  ;4      8 (31+n*22) if NZ
                          ;       3 opcode
                          ;       3 mem read
                          ;       1 execute
                          ;       1 execute
                          ;2      6 (29+n*22) if not NZ
                          ;       3 opcode
                          ;       3 mem read
        POP   AF          ;3      9 (38+n*22)
                          ;       3 opcode
                          ;       3 mem read
                          ;       3 mem read
        POP   HL          ;3      9 (47+n*22)
                          ;       3 opcode
                          ;       3 mem read
                          ;       3 mem read
        RET               ;3      9 (56+n*22)
                          ;       3 opcode
                          ;       3 mem read
                          ;       3 mem read
;****************
;getChar
;Check if an input character from ASCI0 is available.
;  IN:  none
;  OUT: F: ZERO flag set if no character is available.
;          ZERO flag reset if a character is available.
;       A : character from ASCI0, if available.
;  USES:AF
;****************
getChar:
        IN0   A,(STAT0)   ;read ASCI0 status
        BIT   OVERRUN,A   ;check if ASCIO OVERRUN bit is set
        JR    NZ,getChar1 ;-yes: reset error flags
        BIT   RDRF,A      ;check if ASCIO RDRF bit is set
        RET   Z           ;-no: return without a character
        IN0   A,(RDR0)    ;-yes:read ASCIO Rx data register
        RET
getChar1:
        IN0   A,(CNTLA0)  ;read ASCI0 control register
        RES   ERROR,A     ;reset OVRN,FE,PE,BRK flags
        OUT0  (CNTLA0),A  ;write back to ASCI0 CTRL
        XOR   A
        RET               ;return without a character
;****************
;putMsg
;Print via ASCI0 a zero terminated string, starting at the return address on the stack.
;  IN:  none.
;  OUT: none.
;  USES:none.
;****************
putMsg:
        EX    (SP),HL     ;save HL and load return address into HL.
        CALL  putStr
        EX    (SP),HL     ;put return address onto stack and restore HL.
        RET
;****************
;putStr
;Print via ASCI0 a zero terminated string, pointed to by HL.
;  IN:  HL:address of zero terminated string to be printed.
;  OUT: none.
;  USES:HL (point to byte after zero terminated string)
;****************
putStr:
        PUSH  AF          ;save registers
putStr1:
        LD    A,(HL)      ;get next character
        INC   HL
        OR    A,A         ;is it zer0?
        JR    Z,putStr2   ;yes ->return
        CALL  putChar     ;no->put it to ASCI0
        JR    putStr1
putStr2:
        POP   AF
        RET
;****************
;putSpace
;Send a space character to ASCI0
;  IN:  none.
;  OUT: none.
;  USES:AF
;****************
putSpace:
        LD    A,' '       ;load space and continue with putChar.
;****************
;putChar
;Send one character to ASCI0.
;  IN:  A = character
;  OUT: none.
;  USES:none.
;****************
putChar:
        PUSH  AF          ;send the character via ASCI0
putChar1:
        IN0   A,(STAT0)   ;read ASCI0 status register
        BIT   TDRE,A      ;wait until TDRE <> 0
        JR    Z,putChar1
        POP   AF          ;restore AF registers
        OUT0  (TDR0),A    ;write character to ASCI0
        RET
;****************
;putCRLF
;Send CR and LF to ASCI0
;  IN:  none.
;  OUT: none.
;  USES:none.
;****************
putCRLF:
        PUSH  AF
        LD    A,'\r'       ;print carriage return
        CALL  putChar
        LD    A,'\n'       ;print line feed
        CALL  putChar
        POP   AF
        RET
;****************
;putErase
;Erase the latest character at ASCI0
;  IN:  none.
;  OUT: none.
;  USES:AF
;****************
putErase:
        LD    A,'\b'       ;print backspace
        CALL  putChar
        CALL  putSpace    ;print space (erase character)
        LD    A,'\b'      ;print backspace
        JR    putChar
;****************
;putBell
;Send a Bell character to ASCI0
;  IN:  none.
;  OUT: none.
;  USES:AF
;****************
putBell:
        LD    A,07        ;ring the bell at ASCI0
        JR    putChar
;****************
;putHexHL
;Print HL register pair as 4 hex digits
;  IN:  HL = word to be printed.
;  OUT: none.
;  USES:none.
;****************
putHexHL:
        PUSH  AF          ;save used registers
        LD    A,H         ;print H as 2 hex digits
        CALL  putHexA
        LD    A,L         ;print L as 2 hex digits
        CALL  putHexA
        POP   AF          ;restore used registers
        RET
;****************
;putHexA
;Print A register as 2 hex digits
;  IN:  A = byte to be printed
;  OUT: none.
;  USES:none.
;****************
putHexA:
        PUSH  AF          ;save input
        RRA               ;shift upper nibble to the right
        RRA
        RRA
        RRA
        CALL  putHexA1    ;print upper nibble
        POP   AF          ;restore input & print lower nibble
putHexA1:
        PUSH  AF          ;save input
        AND   A,00FH      ;mask lower nibble
        ADD   A,'0'       ;convert to hex digit
        CP    A,'9'+1
        JR    C,putHexA2
        ADD   A,07
putHexA2:
        CALL  putChar
        POP   AF          ;restore input
        RET               ;and return
;****************
;mul16
;16 by 16 bit unsigned multiplication with 16 bit result.
;  IN:  HL = operand 1
;       DE = operand 2
;  OUT: HL = HL * DE low part
;  USES:DE
;  Size   25 bytes
;  Time  160 cycles
;****************
mul16:
        ;HL = HL * DE
        ;        H  L
        ;        D  E
        ;    --------*
        ;          EL
        ;       EH  0
        ;       DL  0
        ; -----------+
        ;        R  S
        ;S = ELlow
        ;R = ELhigh+EHlow+DLlow
        PUSH  BC          ;11  11 save BC
        LD    B,H         ; 4  15 copy HL to BC
        LD    C,L         ; 4  19
        LD    H,E         ; 4  23 HL contains EL
        MLT   HL          ;17  40
        PUSH  HL          ;11  51
        LD    H,E         ; 4  55 HL contains EH aka EB
        LD    L,B         ; 4  59
        MLT   HL          ;17  76
        LD    B,L         ; 4  80 save EHlow in B
        LD    H,D         ; 4  84 HL contains DL aka DC
        LD    L,C         ; 4  88
        MLT   HL          ;17 105
        LD    D,L         ; 4 109 DLlow into DE
        LD    E,0         ; 6 115
        POP   HL          ; 9 124 add EL+DElow
        ADD   HL,DE       ; 7 131
        LD    D,B         ; 4 135 add EL+DElow+EHlow
        ADD   HL,DE       ; 7 142
        POP   BC          ; 9 151 restore BC
        RET               ; 9 160
;****************
;mul16_10
;multiply a 16 bit unsigned number by 10 with a 16 bit result.
;  IN:  HL = operand
;  OUT: HL = HL * 10; low part
;  USES:Flags
;  Size   9 bytes
;  Time   65 cycles
;****************
mul16_10:
        PUSH  DE          ;11 11
        LD    D,H         ; 4 15
        LD    E,L         ; 4 19
        ADD   HL,HL       ; 7 26 times 2
        ADD   HL,HL       ; 7 33 times 4
        ADD   HL,DE       ; 7 40 times 5
        ADD   HL,HL       ; 7 47 times 10
        POP   DE          ; 9 56
        RET               ; 9 65
;****************
;mul16_8
;16 by 8 bit unsigned multiplication with 16 bit result.
;  IN:  HL = operand 1
;        A = operand 2
;  OUT: HL = HL * A low part
;  USES:AF
;  Size   .. bytes
;  Time  ... cycles
;****************
mul16_8:
        ;HL = HL * A
        ;        H  L
        ;           A
        ;    --------*
        ;          AL
        ;       AH  0
        ; -----------+
        ;        R  S
        ;S = ALlow
        ;R = ALhigh+AHlow
        PUSH  BC          ;11  11 save BC
        LD    B,H         ; 4  15
        LD    C,A         ; 4  19
        LD    H,A         ; 4  23
        MLT   HL          ;17  40 HL = AL
        MLT   BC          ;17  57 BC = AH
        LD    A,H         ; 4  61 A = S = ALhigh+AHlow
        ADD   A,C         ; 4  65
        LD    H,A         ; 4  69
        POP   BC          ; 9  78 | 289 restore BC
        RET               ; 9  87 | 307
;****************
;mul1632
;16 by 16 bit unsigned multiplication with 32 bit result.
;  IN:  HL = operand 1
;       DE = operand 2
;  OUT: HL = HL * DE low part
;       DE = HL * DE high part
;  USES:-
;  Size 49 bytes
;  Time between 303 en 307 cycles
;****************
mul1632:
        ;HL = HL * DE
        ;        H  L
        ;        D  E
        ;    --------*
        ;          EL
        ;       EH  0
        ;       DL  0
        ;    DH  0  0
        ; -----------+
        ;  P  Q  R  S
        ;S = ELlow
        ;R = ELhigh+EHlow+DLlow
        ;Q = DHlow+EHhigh+DLhigh
        ;P = DHhigh
        PUSH  AF          ;11  11 save AF
        PUSH  BC          ;11  22 save BC
        LD    B,H         ; 4  26
        LD    C,L         ; 4  30
        LD    H,D         ; 4  34 HL contains DH aka DB
        LD    L,B         ; 4  38
        MLT   HL          ;17  55
        PUSH  HL          ;11  66
        LD    H,D         ; 4  70 HL contains DL aka DC
        LD    L,C         ; 4  74
        MLT   HL          ;17  91
        PUSH  HL          ;11 102
        LD    H,E         ; 4 106 HL contains EH aka EB
        LD    L,B         ; 4 110
        MLT   HL          ;17 127
        PUSH  HL          ;11 138
        LD    H,E         ; 4 142 HL contains EL aka EC
        LD    L,C         ; 4 146
        MLT   HL          ;17 163
        POP   DE          ; 9 172 calculate RS=EL+EH0
        LD    B,0         ; 6 178
        LD    C,D         ; 4 182 ..C=EHhigh
        LD    D,E         ; 4 186 ..D=EHlow
        LD    E,0         ; 6 192
        ADD   HL,DE       ; 7 199
        JR    NC,mul16321 ; 8 207 | 6 205 add carry to PQ
        INC   BC          ;         4 209
mul16321:
        POP   DE          ; 9 209 | 211 calculate RS=EL+EH0+DL0
        LD    A,D         ; 4 220 | 222 ..A=DLhigh
        LD    D,E         ; 4 224 | 226 ..D=DLlow
        ADD   HL,DE       ; 7 231 | 233
        JR    NC,mul16322 ; 8 239 | 6 239 add carry to PQ
        INC   BC          ;         4 243
mul16322:
                          ;HL=RS=EL+EH0+DL0
                          ;C=EHhigh
                          ;A=DLhigh
                          ;E=0
        EX    DE,HL       ; 3 242 | 246
        LD    H,L         ; 4 246 | 250 ..E was 0, so H=L=0
        LD    L,A         ; 4 250 | 254 ..HL=DLhigh
        ADD   HL,BC       ; 7 257 | 261 PQ=EHhigh+DLhigh+DH
        POP   BC          ; 9 266 | 270
        ADD   HL,BC       ; 7 273 | 277
        EX    DE,HL       ; 3 276 | 280
                          ;D=P=DHhigh
                          ;E=Q=DHlow+EHhigh+DLhigh
                          ;H=R=ELhigh+EHlow+DLlow
                          ;L=S=ELlow
        POP   BC          ; 9 285 | 289 restore BC
        POP   AF          ; 9 294 | 298 restore AF
        RET               ; 9 303 | 307
;****************
;mul16S
;16 by 16 bit slow unsigned multiplication with 32 bit result.
;  IN:  HL = operand 1
;       DE = operand 2
;  OUT: DE = HL * DE high part
;       HL = HL * DE low part
;  USES:none.
;  Size 26 bytes
;  Time between 726 en 998 cycles
;****************
mul16S:
        PUSH  AF          ;11  11 save AF
        PUSH  BC          ;11  22 save BC
        LD    B,H         ; 4  26
        LD    C,L         ; 4  30
        LD    HL,0        ; 9  39
        LD    A,16        ; 6  45
mul16S1:
        ADD   HL,HL       ;16*7=112 157
        RL    E           ;16*7=112 269
        RL    D           ;16*7=112 381
        JR    NC,mul16S2  ;16*8=128 509 16*6= 96 477
        ADD   HL,BC       ;             16*7=112 589
        JR    NC,mul16S2  ;             16*8=128 717 16*6=96 685
        INC   DE          ;             16*4= 64 781 16*4=64 749 This instruction (with the jump) is like an "ADC DE,0"
mul16S2:
        DEC   A           ;16*4=64    573 | 845 | 813
        JR    NZ,mul16S1  ;15*8+6=126 699 | 971 | 939
        POP   BC          ; 9         708 | 980 | 948 restore BC
        POP   AF          ; 9         717 | 989 | 957 restore AF
        RET               ; 9         726 | 998 | 966
;****************
;div16
;16 by 16 bit unsigned division.
;  IN:  HL = dividend
;       DE = divisor
;  OUT: HL = quotient
;       DE = remainder
;  USES:-
;  Size   32 bytes
;  Time   between 1073 en 1121 cycles
;pseudo code:
;T = AC = dividend
;D = DE = divisor
;Q = AC = quotient = 0
;R = HL = remainder = 0
;invariante betrekking:
; D/T\Q     
;   R       
; T = QD + R
; T <= 2^N  
;
; D/T'.RT\Q'      
;   R'             
; RT <= 2^N        
; 0<=k<=N          
; RT = T % 2^k     
; T' = (T-RT) / 2^k
; Q' = T' / D      
; R' = T' % D      
;
;for (i=16; i>0; i--) {
;  T = T * 2 (remember MSB in carry)
;  R = R * 2 + carry
;  Q = Q * 2
;  if (R >= D) {
;    R = R - D;
;    Q++;
;  }
;}
;return Q (in HL) and R (in DE)
;****************
div16:
        PUSH  AF          ;11  11 save registers used
        PUSH  BC          ;11  22
        LD    C,L         ; 4  26 T(AC) = teller from input (HL)
        LD    A,H         ; 4  30 D(DE) = deler from input  (DE)
        LD    HL,0        ; 9  39 R(HL) = restant; Q(AC) = quotient
        LD    B,16        ; 6  45 for (i=16; i>0; i--)
div16_1:
        SLA   C           ;16* 7=112 157   T = T * 2 (remember MSB in carry)
        RL    A           ;16* 7=112 269   Q = Q * 2
        ADC   HL,HL       ;16*10=160 429   R = R * 2 + carry
        OR    A           ;16* 4= 64 493   if (R >= D) {
        SBC   HL,DE       ;16*10=160 653
        JR    C,div16_2   ;16* 8=128 781 16*6= 96 749   R = R - D
        INC   C           ;              16*4= 64 813   Q++
        JR    div16_3     ;              16*8=128 941
div16_2:
        ADD   HL,DE       ;16* 7=112 893  (compensate comparison)
div16_3:
        DJNZ  div16_1     ;15*9+7=142 1035 | 1083 }
        EX    DE,HL       ; 3 1038 | 1086 swap remainder (HL) into DE
        LD    H,A         ; 4 1042 | 1090 move quotient (AC) into HL
        LD    L,C         ; 4 1046 | 1094
        POP   BC          ; 9 1055 | 1103
        POP   AF          ; 9 1064 | 1112
        RET               ; 9 1073 | 1121
;****************
;div16_8
;16 by 8 bit unsigned division.
;  IN:  HL = dividend
;       A  = divisor
;  OUT: HL = quotient
;       A  = remainder
;  USES:F(lags)
;  Size 18 bytes
;  Time between 601 en 697 cycles
;****************
div16_8:
        PUSH  BC          ;11 11 save registers used
        LD    B,16        ; 6 17 the length of the dividend (16 bits)
        LD    C,A         ; 4 21 move divisor to C
        XOR   A           ; 4 25 clear upper 8 bits of AHL
div16_82:
        ADD   HL,HL       ;16*7=112 137 advance dividend (HL) into selected bits (A)
        RL    A           ;16*7=112 249
        CP    C           ;16*4= 64 313 check if divisor (E) <= selected digits (A)
        JR    C,div16_83  ;16*8=128 441 16*6=96 409 if not, advance without subtraction
        SUB   C           ;             16*4=64 473 subtract the divisor
        INC   L           ;             16*4=64 537 and set the next digit of the quotient
div16_83:
        DJNZ  div16_82    ;15*9+7=142 583 679
        POP   BC          ;9 592 688
        RET               ;9 601 697
;****************
;div8
;8 by 8 bit unsigned division.
;  IN:  A = dividend
;       C = divisor
;  OUT: A = quotient
;       C = remainder
;  USES:F(lags)
;  Size 26 bytes
;  Time between 411 and 459 cycles
;****************
;pseudo code:
;T = dividend
;D = divisor
;Q = quotient = 0
;R = remainder = 0
;invariante betrekking:
; T = QD + R
; T <= 2^8  
;
; D/T'.RT\Q'      
;   R'             
; RT <= 2^8        
; 0<=k<=8          
; RT = T % 2^k     
; T' = (T-RT) / 2^k
; Q' = T' / D      
; R' = T' % D      
;
;for (i=8; i>0; i--) {
;  T = T * 2 (remember MSB in carry)
;  R = R * 2 + carry
;  Q = Q * 2
;  if (R >= D) {
;    R = R - D;
;    Q++;
;  }
;}
;return Q (in A) and R (in C)
;****************
;E = T = dividend
;C = D = divisor
;D = Q = quotient
;A = R = remainder
;****************
;  IN:  A = dividend
;       C  = divisor
div8:
        PUSH  DE          ;11 11 save registers used
        PUSH  BC          ;11 22 save registers used
        LD    B,8         ; 6 28 the length of the dividend (8 bits)
        LD    D,0         ; 6 34 D = Q = quotient = 0
        LD    E,A         ; 4 38 E = T = dividend
        XOR   A           ; 4 42 A = R = remainder = 0
div8_1:
        SLA   E           ;8*7=56  98            T[E] = T[E] * 2 (remember MSB in carry)
        RL    A           ;8*7=56 154            R[A] = R[A] * 2 + carry
        SLA   D           ;8*7=56 210            Q[D] = Q[D] * 2
        CP    C           ;8*4=32 242            if (R[A] - D[C] >= 0) {
        JR    C,div8_2    ;8*8=64 306 8*6=48 290
        SUB   C           ;           8*4=32 322   R[A] = R[A] - D[C];
        INC   D           ;           8*4=32 354   Q[D]++;
div8_2:           ;                      }
        DJNZ  div8_1      ;7*9+7=70 376 424      }
        POP   BC          ;9        385 433
        LD    C,A         ;4        389 437      return Remainder[A] in C
        LD    A,D         ;4        393 441      return Quotient[D] in A
        POP   DE          ;9        402 450
        RET               ;9        411 459
;****************
;div8_16
;8 by 16 bit unsigned division.
;  IN:  A = dividend
;       HL = divisor
;  OUT: A = quotient
;       C = remainder
;  USES:F(lags)
;  Size 13 bytes (plus dependency on div8)
;  Time 31 or between 436 and 484 cycles
;****************
;invariante betrekking:
; T = dividend
; D = divisor
; Q = quotient
; R = remainder
; T = QD + R
;pseudo code:
; if D >= 256 {
;   R = T
;   Q = 0
; } else {
;   R = T/D (using div8)
;   Q = T%D (using div8)
; }
;****************


div8_16:
        LD    C,A         ;  4  4         save dividend(A) in C
        LD    A,H         ;  4  8         if D >= 256 {
        OR    A           ;  4 12
        JR    Z,div8_161  ;  6 18  8  20
        XOR   A           ;  4 22           R = T;
        RET               ;  9 31           Q = 0;
div8_161:                     ;               } else {
        LD    A,C         ;        4  24    restore dividend into A
        LD    C,L         ;        4  28    load divisor (HL) into C
        CALL  div8        ; 16+411/16+459               R = T/D; Q = T%D;
        RET               ; 9  436/484    }
;****************
;read
;read a 16 bit unsigned number from the input
;  IN:  none
;  OUT: HL = 16 bit unsigned number
;  USES:-
;****************
read:
        PUSH  AF
        LD    HL,0        ;result = 0;
read1:
        CALL  getChar     ;check if a character is available.
        JR    Z,read1     ;-no: wait for it.
        CP    '\r'        ;return if char == Carriage Return
        JR    Z,read2
        CALL  mul16_10    ;result *= 10;
        SUB   A,'0'       ;digit = char - '0';
        ADD   A,L         ;result += digit;
        LD    L,A
        JR    NC,read1     ;get next character
        INC   H
        JR    read1        ;get next character
read2:
        POP   AF
        RET
;****************
;writeHL
;write a 16 bit unsigned number to the output
;  IN:  HL = 16 bit unsigned number
;  OUT: none
;  USES:HL
;****************
writeHL:
        PUSH  BC          ;save registers used
        PUSH  AF
        LD    B,0         ;number of digits on stack
        LD    A,H         ;is HL=0?
        OR    L
        JR    NZ,writeHL1
        INC   B           ;write a single digit 0
        JR    writeHL3
writeHL1:
        LD    A,10        ;divide HL by 10
        CALL  div16_8
        PUSH  AF          ;put remainder on stack
        INC   B
        LD    A,H         ;is quotient 0?
        OR    L
        JR    NZ,writeHL1
writeHL2:
        POP   AF          ;write digit
writeHL3:
        ADD   A,'0'
        CALL  putChar
        DJNZ  writeHL2
        POP   AF          ;restore registers used
        POP   BC
        CALL  putCRLF
        RET
;****************
;writeA
;write an 8-bit unsigned number to the output
;  IN:  A = 8-bit unsigned number
;  OUT: none
;  USES:none
;****************
writeA:
        PUSH  HL          ;save registers used
        LD    H,0
        LD    L,A
        CALL  writeHL
        POP   HL
        RET
main:
L0:
        ;;test8.j(0) /*
L1:
        ;;test8.j(1)  * A small program in the miniJava language.
L2:
        ;;test8.j(2)  * Test 8-bit and 16-bit expressions.
L3:
        ;;test8.j(3)  */
L4:
        ;;test8.j(4) class Test8And16BitExpressions {
L5:
        ;;test8.j(5)   println(0);
L6:
        LD    A,0
L7:
        CALL  writeA
L8:
        ;;test8.j(6)   /*************************/
L9:
        ;;test8.j(7)   /* reverse subtract byte */
L10:
        ;;test8.j(8)   /*************************/
L11:
        ;;test8.j(9)   println(10 - 3*3);         // 1
L12:
        LD    A,10
L13:
        PUSH  AF
        LD    A,3
L14:
        LD    B,A
        LD    C,3
        MLT   BC
        LD    A,C
L15:
        POP   BC
        SUB   A,B
        NEG
L16:
        CALL  writeA
L17:
        ;;test8.j(10)   byte b = 11;
L18:
        LD    A,11
L19:
        LD    (05000H),A
L20:
        ;;test8.j(11)   println(b - 3*3);          // 2
L21:
        LD    A,(05000H)
L22:
        PUSH  AF
        LD    A,3
L23:
        LD    B,A
        LD    C,3
        MLT   BC
        LD    A,C
L24:
        POP   BC
        SUB   A,B
        NEG
L25:
        CALL  writeA
L26:
        ;;test8.j(12)   byte c = 3;
L27:
        LD    A,3
L28:
        LD    (05001H),A
L29:
        ;;test8.j(13)   byte d = 3;
L30:
        LD    A,3
L31:
        LD    (05002H),A
L32:
        ;;test8.j(14)   println(12 - c*d);         // 3
L33:
        LD    A,12
L34:
        PUSH  AF
        LD    A,(05001H)
L35:
        LD    B,A
        LD    A,(05002H)
        LD    C,A
        MLT   BC
        LD    A,C
L36:
        POP   BC
        SUB   A,B
        NEG
L37:
        CALL  writeA
L38:
        ;;test8.j(15)   b = 13;
L39:
        LD    A,13
L40:
        LD    (05000H),A
L41:
        ;;test8.j(16)   println(b - c*d);          // 4
L42:
        LD    A,(05000H)
L43:
        PUSH  AF
        LD    A,(05001H)
L44:
        LD    B,A
        LD    A,(05002H)
        LD    C,A
        MLT   BC
        LD    A,C
L45:
        POP   BC
        SUB   A,B
        NEG
L46:
        CALL  writeA
L47:
        ;;test8.j(17) 
L48:
        ;;test8.j(18)   /**************************/
L49:
        ;;test8.j(19)   /* reverse subtract word  */
L50:
        ;;test8.j(20)   /**************************/
L51:
        ;;test8.j(21)   println(1005 - 1000*1);    // 5
L52:
        LD    HL,1005
L53:
        PUSH  HL
        LD    HL,1000
L54:
        LD    DE,1
        CALL  mul16
L55:
        POP   DE
        EX    DE,HL
        OR    A
        SBC   HL,DE
L56:
        CALL  writeHL
L57:
        ;;test8.j(22)   word i = 1006;
L58:
        LD    HL,1006
L59:
        LD    (05003H),HL
L60:
        ;;test8.j(23)   println(i - 1000*1);       // 6
L61:
        LD    HL,(05003H)
L62:
        PUSH  HL
        LD    HL,1000
L63:
        LD    DE,1
        CALL  mul16
L64:
        POP   DE
        EX    DE,HL
        OR    A
        SBC   HL,DE
L65:
        CALL  writeHL
L66:
        ;;test8.j(24)   word j = 1000;
L67:
        LD    HL,1000
L68:
        LD    (05005H),HL
L69:
        ;;test8.j(25)   word k = 1;
L70:
        LD    A,1
L71:
        LD    L,A
        LD    H,0
        LD    (05007H),HL
L72:
        ;;test8.j(26)   println(1007 - j*k);       // 7
L73:
        LD    HL,1007
L74:
        PUSH  HL
        LD    HL,(05005H)
L75:
        LD    DE,(05007H)
        CALL  mul16
L76:
        POP   DE
        EX    DE,HL
        OR    A
        SBC   HL,DE
L77:
        CALL  writeHL
L78:
        ;;test8.j(27)   i = 1008;
L79:
        LD    HL,1008
L80:
        LD    (05003H),HL
L81:
        ;;test8.j(28)   println(i - j*k);          // 8
L82:
        LD    HL,(05003H)
L83:
        PUSH  HL
        LD    HL,(05005H)
L84:
        LD    DE,(05007H)
        CALL  mul16
L85:
        POP   DE
        EX    DE,HL
        OR    A
        SBC   HL,DE
L86:
        CALL  writeHL
L87:
        ;;test8.j(29) 
L88:
        ;;test8.j(30)   /***********************/
L89:
        ;;test8.j(31)   /* reverse divide byte */
L90:
        ;;test8.j(32)   /***********************/
L91:
        ;;test8.j(33)   println(36 / (4*1));     // 9
L92:
        LD    A,36
L93:
        PUSH  AF
        LD    A,4
L94:
        LD    B,A
        LD    C,1
        MLT   BC
        LD    A,C
L95:
        LD    C,A
        POP   AF
        CALL  div8
L96:
        CALL  writeA
L97:
        ;;test8.j(34)   b = 40;
L98:
        LD    A,40
L99:
        LD    (05000H),A
L100:
        ;;test8.j(35)   println(b / (4*1));      // 10
L101:
        LD    A,(05000H)
L102:
        PUSH  AF
        LD    A,4
L103:
        LD    B,A
        LD    C,1
        MLT   BC
        LD    A,C
L104:
        LD    C,A
        POP   AF
        CALL  div8
L105:
        CALL  writeA
L106:
        ;;test8.j(36)   c = 4;
L107:
        LD    A,4
L108:
        LD    (05001H),A
L109:
        ;;test8.j(37)   d = 1;
L110:
        LD    A,1
L111:
        LD    (05002H),A
L112:
        ;;test8.j(38)   println(44 / (c*d));     // 11
L113:
        LD    A,44
L114:
        PUSH  AF
        LD    A,(05001H)
L115:
        LD    B,A
        LD    A,(05002H)
        LD    C,A
        MLT   BC
        LD    A,C
L116:
        LD    C,A
        POP   AF
        CALL  div8
L117:
        CALL  writeA
L118:
        ;;test8.j(39)   b = 48;
L119:
        LD    A,48
L120:
        LD    (05000H),A
L121:
        ;;test8.j(40)   println(b / (c*d));      // 12
L122:
        LD    A,(05000H)
L123:
        PUSH  AF
        LD    A,(05001H)
L124:
        LD    B,A
        LD    A,(05002H)
        LD    C,A
        MLT   BC
        LD    A,C
L125:
        LD    C,A
        POP   AF
        CALL  div8
L126:
        CALL  writeA
L127:
        ;;test8.j(41) 
L128:
        ;;test8.j(42)   /************************/
L129:
        ;;test8.j(43)   /* reverse divide word  */
L130:
        ;;test8.j(44)   /************************/
L131:
        ;;test8.j(45)   println(3900 / (300*1)); // 13
L132:
        LD    HL,3900
L133:
        PUSH  HL
        LD    HL,300
L134:
        LD    DE,1
        CALL  mul16
L135:
        POP   DE
        EX    DE,HL
        CALL  div16
L136:
        CALL  writeHL
L137:
        ;;test8.j(46)   i = 4200;
L138:
        LD    HL,4200
L139:
        LD    (05003H),HL
L140:
        ;;test8.j(47)   println(i / (300*1));    // 14
L141:
        LD    HL,(05003H)
L142:
        PUSH  HL
        LD    HL,300
L143:
        LD    DE,1
        CALL  mul16
L144:
        POP   DE
        EX    DE,HL
        CALL  div16
L145:
        CALL  writeHL
L146:
        ;;test8.j(48)   j = 300;
L147:
        LD    HL,300
L148:
        LD    (05005H),HL
L149:
        ;;test8.j(49)   k = 1;
L150:
        LD    A,1
L151:
        LD    L,A
        LD    H,0
        LD    (05007H),HL
L152:
        ;;test8.j(50)   println(4500 / (j*k));   // 15
L153:
        LD    HL,4500
L154:
        PUSH  HL
        LD    HL,(05005H)
L155:
        LD    DE,(05007H)
        CALL  mul16
L156:
        POP   DE
        EX    DE,HL
        CALL  div16
L157:
        CALL  writeHL
L158:
        ;;test8.j(51)   i = 4800;
L159:
        LD    HL,4800
L160:
        LD    (05003H),HL
L161:
        ;;test8.j(52)   println(i / (j*k));      // 16
L162:
        LD    HL,(05003H)
L163:
        PUSH  HL
        LD    HL,(05005H)
L164:
        LD    DE,(05007H)
        CALL  mul16
L165:
        POP   DE
        EX    DE,HL
        CALL  div16
L166:
        CALL  writeHL
L167:
        ;;test8.j(53) 
L168:
        ;;test8.j(54)   /**************************/
L169:
        ;;test8.j(55)   /* reverse subtract mixed */
L170:
        ;;test8.j(56)   /**************************/
L171:
        ;;test8.j(57)   i = 21;
L172:
        LD    A,21
L173:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L174:
        ;;test8.j(58)   c = 4;
L175:
        LD    A,4
L176:
        LD    (05001H),A
L177:
        ;;test8.j(59)   d = 1;
L178:
        LD    A,1
L179:
        LD    (05002H),A
L180:
        ;;test8.j(60)   println(i - c*d);           // 17
L181:
        LD    HL,(05003H)
L182:
        LD    A,(05001H)
L183:
        LD    B,A
        LD    A,(05002H)
        LD    C,A
        MLT   BC
        LD    A,C
L184:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L185:
        CALL  writeHL
L186:
        ;;test8.j(61)   b = 22;
L187:
        LD    A,22
L188:
        LD    (05000H),A
L189:
        ;;test8.j(62)   j = 4;
L190:
        LD    A,4
L191:
        LD    L,A
        LD    H,0
        LD    (05005H),HL
L192:
        ;;test8.j(63)   k = 1;
L193:
        LD    A,1
L194:
        LD    L,A
        LD    H,0
        LD    (05007H),HL
L195:
        ;;test8.j(64)   println(b - j*k);           // 18
L196:
        LD    A,(05000H)
L197:
        LD    HL,(05005H)
L198:
        LD    DE,(05007H)
        CALL  mul16
L199:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L200:
        CALL  writeHL
L201:
        ;;test8.j(65) 
L202:
        ;;test8.j(66)   /**************************/
L203:
        ;;test8.j(67)   /* reverse divide mixed   */
L204:
        ;;test8.j(68)   /**************************/
L205:
        ;;test8.j(69) 
L206:
        ;;test8.j(70)   /**************************/
L207:
        ;;test8.j(71)   /* forward divide mixed   */
L208:
        ;;test8.j(72)   /**************************/
L209:
        ;;test8.j(73)   i = 19;
L210:
        LD    A,19
L211:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L212:
        ;;test8.j(74)   println(i / (1+0));         // 19
L213:
        LD    HL,(05003H)
L214:
        LD    A,1
L215:
        ADD   A,0
L216:
        CALL  div16_8
L217:
        CALL  writeHL
L218:
        ;;test8.j(75)   
L219:
        ;;test8.j(76)   println(i + 1);             // 20
L220:
        LD    HL,(05003H)
L221:
        LD    DE,1
        ADD   HL,DE
L222:
        CALL  writeHL
L223:
        ;;test8.j(77)   println(2 + i);             // 21
L224:
        LD    A,2
L225:
        LD    L,A
        LD    H,0
L226:
        LD    DE,(05003H)
        ADD   HL,DE
L227:
        CALL  writeHL
L228:
        ;;test8.j(78)   println("Klaar");
L229:
        LD    HL,233
L230:
        CALL  putStr
L231:
        ;;test8.j(79) }
L232:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L233:
        .ASCIZ  "Klaar"
