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
        ;;test10.j(0) /* Program to test generated Z80 assembler code */
L1:
        ;;test10.j(1) class TestDo {
L2:
        ;;test10.j(2)   byte b = 1;
L3:
        LD    A,1
L4:
        LD    (05000H),A
L5:
        ;;test10.j(3)   word i = 12;
L6:
        LD    A,12
L7:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L8:
        ;;test10.j(4)   word p = 12;
L9:
        LD    A,12
L10:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L11:
        ;;test10.j(5) 
L12:
        ;;test10.j(6)   write(0);
L13:
        LD    A,0
L14:
        CALL  writeA
L15:
        ;;test10.j(7) 
L16:
        ;;test10.j(8)   /************************/
L17:
        ;;test10.j(9)   // global variable within do scope
L18:
        ;;test10.j(10)   write (b);
L19:
        LD    A,(05000H)
L20:
        CALL  writeA
L21:
        ;;test10.j(11)   b++;
L22:
        LD    HL,(05000H)
        INC   (HL)
L23:
        ;;test10.j(12)   do {
L24:
        ;;test10.j(13)     word j = 1001;
L25:
        LD    HL,1001
L26:
        LD    (05005H),HL
L27:
        ;;test10.j(14)     byte c = b;
L28:
        LD    A,(05000H)
L29:
        LD    (05007H),A
L30:
        ;;test10.j(15)     byte d = c;
L31:
        LD    A,(05007H)
L32:
        LD    (05008H),A
L33:
        ;;test10.j(16)     b++;
L34:
        LD    HL,(05000H)
        INC   (HL)
L35:
        ;;test10.j(17)     write (c);
L36:
        LD    A,(05007H)
L37:
        CALL  writeA
L38:
        ;;test10.j(18)   } while (b<2);
L39:
        LD    A,(05000H)
L40:
        SUB   A,2
L41:
        JP    C,L24
L42:
        ;;test10.j(19) 
L43:
        ;;test10.j(20)   /************************/
L44:
        ;;test10.j(21)   // constant - constant
L45:
        ;;test10.j(22)   // not relevant
L46:
        ;;test10.j(23) 
L47:
        ;;test10.j(24)   /************************/
L48:
        ;;test10.j(25)   // constant - acc
L49:
        ;;test10.j(26)   // byte - byte
L50:
        ;;test10.j(27)   do { write (b); b++; } while (103 == b+100);
L51:
        LD    A,(05000H)
L52:
        CALL  writeA
L53:
        LD    HL,(05000H)
        INC   (HL)
L54:
        LD    A,(05000H)
L55:
        ADD   A,100
L56:
        SUB   A,103
L57:
        JP    Z,L51
L58:
        ;;test10.j(28)   do { write (b); b++; } while (106 != b+100);
L59:
        LD    A,(05000H)
L60:
        CALL  writeA
L61:
        LD    HL,(05000H)
        INC   (HL)
L62:
        LD    A,(05000H)
L63:
        ADD   A,100
L64:
        SUB   A,106
L65:
        JP    NZ,L59
L66:
        ;;test10.j(29)   do { write (b); b++; } while (108 >  b+100);
L67:
        LD    A,(05000H)
L68:
        CALL  writeA
L69:
        LD    HL,(05000H)
        INC   (HL)
L70:
        LD    A,(05000H)
L71:
        ADD   A,100
L72:
        SUB   A,108
L73:
        JP    C,L67
L74:
        ;;test10.j(30)   do { write (b); b++; } while (109 >= b+100);
L75:
        LD    A,(05000H)
L76:
        CALL  writeA
L77:
        LD    HL,(05000H)
        INC   (HL)
L78:
        LD    A,(05000H)
L79:
        ADD   A,100
L80:
        SUB   A,109
L81:
        JP    Z,L75
L82:
        ;;test10.j(31)   p=10;
L83:
        LD    A,10
L84:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L85:
        ;;test10.j(32)   do { write (p); p++; b--; } while (108 <  b+100);
L86:
        LD    HL,(05003H)
L87:
        CALL  writeHL
L88:
        LD    HL,(05003H)
        INC   HL
        LD    (05003H),HL
L89:
        LD    HL,(05000H)
        DEC   (HL)
L90:
        LD    A,(05000H)
L91:
        ADD   A,100
L92:
        SUB   A,108
L93:
        JR    Z,$+5
        JP    C,L86
L94:
        ;;test10.j(33)   do { write (p); p++; b--; } while (107 <= b+100);
L95:
        LD    HL,(05003H)
L96:
        CALL  writeHL
L97:
        LD    HL,(05003H)
        INC   HL
        LD    (05003H),HL
L98:
        LD    HL,(05000H)
        DEC   (HL)
L99:
        LD    A,(05000H)
L100:
        ADD   A,100
L101:
        SUB   A,107
L102:
        JP    NC,L95
L103:
        ;;test10.j(34) 
L104:
        ;;test10.j(35)   // constant - acc
L105:
        ;;test10.j(36)   // byte - integer
L106:
        ;;test10.j(37)   i=14;
L107:
        LD    A,14
L108:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L109:
        ;;test10.j(38)   do { write (i); i++; } while (15 == i+0);
L110:
        LD    HL,(05001H)
L111:
        CALL  writeHL
L112:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L113:
        LD    HL,(05001H)
L114:
        LD    DE,0
        ADD   HL,DE
L115:
        LD    A,15
L116:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L117:
        JP    Z,L110
L118:
        ;;test10.j(39)   do { write (i); i++; } while (18 != i+0);
L119:
        LD    HL,(05001H)
L120:
        CALL  writeHL
L121:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L122:
        LD    HL,(05001H)
L123:
        LD    DE,0
        ADD   HL,DE
L124:
        LD    A,18
L125:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L126:
        JP    NZ,L119
L127:
        ;;test10.j(40)   do { write (i); i++; } while (20 >  i+0);
L128:
        LD    HL,(05001H)
L129:
        CALL  writeHL
L130:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L131:
        LD    HL,(05001H)
L132:
        LD    DE,0
        ADD   HL,DE
L133:
        LD    A,20
L134:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L135:
        JR    Z,$+5
        JP    C,L128
L136:
        ;;test10.j(41)   do { write (i); i++; } while (21 >= i+0);
L137:
        LD    HL,(05001H)
L138:
        CALL  writeHL
L139:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L140:
        LD    HL,(05001H)
L141:
        LD    DE,0
        ADD   HL,DE
L142:
        LD    A,21
L143:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L144:
        JP    NC,L137
L145:
        ;;test10.j(42)   p=22;
L146:
        LD    A,22
L147:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L148:
        ;;test10.j(43)   do { write (p); p++; i--; } while (20 <  i+0);
L149:
        LD    HL,(05003H)
L150:
        CALL  writeHL
L151:
        LD    HL,(05003H)
        INC   HL
        LD    (05003H),HL
L152:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L153:
        LD    HL,(05001H)
L154:
        LD    DE,0
        ADD   HL,DE
L155:
        LD    A,20
L156:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L157:
        JP    C,L149
L158:
        ;;test10.j(44)   do { write (p); p++; i--; } while (19 <= i+0);
L159:
        LD    HL,(05003H)
L160:
        CALL  writeHL
L161:
        LD    HL,(05003H)
        INC   HL
        LD    (05003H),HL
L162:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L163:
        LD    HL,(05001H)
L164:
        LD    DE,0
        ADD   HL,DE
L165:
        LD    A,19
L166:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L167:
        JP    Z,L159
L168:
        ;;test10.j(45) 
L169:
        ;;test10.j(46)   // constant - acc
L170:
        ;;test10.j(47)   // integer - byte
L171:
        ;;test10.j(48)   // not relevant
L172:
        ;;test10.j(49) 
L173:
        ;;test10.j(50)   // constant - acc
L174:
        ;;test10.j(51)   // integer - integer
L175:
        ;;test10.j(52)   i=p;
L176:
        LD    HL,(05003H)
L177:
        LD    (05001H),HL
L178:
        ;;test10.j(53)   do { write (i); i++; } while (1027 == i+1000);
L179:
        LD    HL,(05001H)
L180:
        CALL  writeHL
L181:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L182:
        LD    HL,(05001H)
L183:
        LD    DE,1000
        ADD   HL,DE
L184:
        LD    DE,1027
        OR    A
        SBC   HL,DE
L185:
        JP    Z,L179
L186:
        ;;test10.j(54)   do { write (i); i++; } while (1029 != i+1000);
L187:
        LD    HL,(05001H)
L188:
        CALL  writeHL
L189:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L190:
        LD    HL,(05001H)
L191:
        LD    DE,1000
        ADD   HL,DE
L192:
        LD    DE,1029
        OR    A
        SBC   HL,DE
L193:
        JP    NZ,L187
L194:
        ;;test10.j(55)   do { write (i); i++; } while (1031 >  i+1000);
L195:
        LD    HL,(05001H)
L196:
        CALL  writeHL
L197:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L198:
        LD    HL,(05001H)
L199:
        LD    DE,1000
        ADD   HL,DE
L200:
        LD    DE,1031
        OR    A
        SBC   HL,DE
L201:
        JP    C,L195
L202:
        ;;test10.j(56)   do { write (i); i++; } while (1032 >= i+1000);
L203:
        LD    HL,(05001H)
L204:
        CALL  writeHL
L205:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L206:
        LD    HL,(05001H)
L207:
        LD    DE,1000
        ADD   HL,DE
L208:
        LD    DE,1032
        OR    A
        SBC   HL,DE
L209:
        JP    Z,L203
L210:
        ;;test10.j(57)   p=i;
L211:
        LD    HL,(05001H)
L212:
        LD    (05003H),HL
L213:
        ;;test10.j(58)   do { write (p); p++; i--; } while (1031 <  i+1000);
L214:
        LD    HL,(05003H)
L215:
        CALL  writeHL
L216:
        LD    HL,(05003H)
        INC   HL
        LD    (05003H),HL
L217:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L218:
        LD    HL,(05001H)
L219:
        LD    DE,1000
        ADD   HL,DE
L220:
        LD    DE,1031
        OR    A
        SBC   HL,DE
L221:
        JR    Z,$+5
        JP    C,L214
L222:
        ;;test10.j(59)   do { write (p); p++; i--; } while (1030 <= i+1000);
L223:
        LD    HL,(05003H)
L224:
        CALL  writeHL
L225:
        LD    HL,(05003H)
        INC   HL
        LD    (05003H),HL
L226:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L227:
        LD    HL,(05001H)
L228:
        LD    DE,1000
        ADD   HL,DE
L229:
        LD    DE,1030
        OR    A
        SBC   HL,DE
L230:
        JP    NC,L223
L231:
        ;;test10.j(60) 
L232:
        ;;test10.j(61)   /************************/
L233:
        ;;test10.j(62)   // constant - var
L234:
        ;;test10.j(63)   // byte - byte
L235:
        ;;test10.j(64)   b=37;
L236:
        LD    A,37
L237:
        LD    (05000H),A
L238:
        ;;test10.j(65)   do { write (b); b++; } while (38 >= b);
L239:
        LD    A,(05000H)
L240:
        CALL  writeA
L241:
        LD    HL,(05000H)
        INC   (HL)
L242:
        LD    A,(05000H)
L243:
        SUB   A,38
L244:
        JP    Z,L239
L245:
        ;;test10.j(66)   // byte - integer
L246:
        ;;test10.j(67)   i=39;
L247:
        LD    A,39
L248:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L249:
        ;;test10.j(68)   do { write (i); i++; } while (40 >= i);
L250:
        LD    HL,(05001H)
L251:
        CALL  writeHL
L252:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L253:
        LD    HL,(05001H)
L254:
        LD    A,40
L255:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L256:
        JP    NC,L250
L257:
        ;;test10.j(69)   // integer - byte
L258:
        ;;test10.j(70)   // not relevant
L259:
        ;;test10.j(71)   // integer - integer
L260:
        ;;test10.j(72)   i=1038;
L261:
        LD    HL,1038
L262:
        LD    (05001H),HL
L263:
        ;;test10.j(73)   b=41;
L264:
        LD    A,41
L265:
        LD    (05000H),A
L266:
        ;;test10.j(74)   do { write (b); b++; i--; } while (1037 <= i);
L267:
        LD    A,(05000H)
L268:
        CALL  writeA
L269:
        LD    HL,(05000H)
        INC   (HL)
L270:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L271:
        LD    HL,(05001H)
L272:
        LD    DE,1037
        OR    A
        SBC   HL,DE
L273:
        JP    NC,L267
L274:
        ;;test10.j(75) 
L275:
        ;;test10.j(76)   /************************/
L276:
        ;;test10.j(77)   // constant - stack8
L277:
        ;;test10.j(78)   // byte - byte
L278:
        ;;test10.j(79)   //TODO
L279:
        ;;test10.j(80)   write(43);
L280:
        LD    A,43
L281:
        CALL  writeA
L282:
        ;;test10.j(81)   // constant - stack8
L283:
        ;;test10.j(82)   // byte - integer
L284:
        ;;test10.j(83)   //TODO
L285:
        ;;test10.j(84)   write(44);
L286:
        LD    A,44
L287:
        CALL  writeA
L288:
        ;;test10.j(85)   // constant - stack8
L289:
        ;;test10.j(86)   // integer - byte
L290:
        ;;test10.j(87)   //TODO
L291:
        ;;test10.j(88)   write(45);
L292:
        LD    A,45
L293:
        CALL  writeA
L294:
        ;;test10.j(89)   // constant - stack88
L295:
        ;;test10.j(90)   // integer - integer
L296:
        ;;test10.j(91)   //TODO
L297:
        ;;test10.j(92)   write(46);
L298:
        LD    A,46
L299:
        CALL  writeA
L300:
        ;;test10.j(93) 
L301:
        ;;test10.j(94)   /************************/
L302:
        ;;test10.j(95)   // constant - stack16
L303:
        ;;test10.j(96)   // byte - byte
L304:
        ;;test10.j(97)   //TODO
L305:
        ;;test10.j(98)   write(47);
L306:
        LD    A,47
L307:
        CALL  writeA
L308:
        ;;test10.j(99)   // constant - stack16
L309:
        ;;test10.j(100)   // byte - integer
L310:
        ;;test10.j(101)   //TODO
L311:
        ;;test10.j(102)   write(48);
L312:
        LD    A,48
L313:
        CALL  writeA
L314:
        ;;test10.j(103)   // constant - stack16
L315:
        ;;test10.j(104)   // integer - byte
L316:
        ;;test10.j(105)   //TODO
L317:
        ;;test10.j(106)   write(49);
L318:
        LD    A,49
L319:
        CALL  writeA
L320:
        ;;test10.j(107)   // constant - stack16
L321:
        ;;test10.j(108)   // integer - integer
L322:
        ;;test10.j(109)   //TODO
L323:
        ;;test10.j(110)   write(50);
L324:
        LD    A,50
L325:
        CALL  writeA
L326:
        ;;test10.j(111) 
L327:
        ;;test10.j(112)   /************************/
L328:
        ;;test10.j(113)   // acc - constant
L329:
        ;;test10.j(114)   // byte - byte
L330:
        ;;test10.j(115)   b=51;
L331:
        LD    A,51
L332:
        LD    (05000H),A
L333:
        ;;test10.j(116)   do { write (b); b++; } while (b+0 <= 52);
L334:
        LD    A,(05000H)
L335:
        CALL  writeA
L336:
        LD    HL,(05000H)
        INC   (HL)
L337:
        LD    A,(05000H)
L338:
        ADD   A,0
L339:
        SUB   A,52
L340:
        JP    Z,L334
L341:
        ;;test10.j(117)   // byte - integer
L342:
        ;;test10.j(118)   //not relevant
L343:
        ;;test10.j(119)   // integer - byte
L344:
        ;;test10.j(120)   i=53;
L345:
        LD    A,53
L346:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L347:
        ;;test10.j(121)   do { write (i); i++; } while (i+0 <= 54);
L348:
        LD    HL,(05001H)
L349:
        CALL  writeHL
L350:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L351:
        LD    HL,(05001H)
L352:
        LD    DE,0
        ADD   HL,DE
L353:
        LD    A,54
L354:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L355:
        JP    Z,L348
L356:
        ;;test10.j(122) 
L357:
        ;;test10.j(123)   b=55;
L358:
        LD    A,55
L359:
        LD    (05000H),A
L360:
        ;;test10.j(124)   i=1055;
L361:
        LD    HL,1055
L362:
        LD    (05001H),HL
L363:
        ;;test10.j(125)   // integer - integer
L364:
        ;;test10.j(126)   do { write (b); b++; i++; } while (i+0 <= 1056);
L365:
        LD    A,(05000H)
L366:
        CALL  writeA
L367:
        LD    HL,(05000H)
        INC   (HL)
L368:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L369:
        LD    HL,(05001H)
L370:
        LD    DE,0
        ADD   HL,DE
L371:
        LD    DE,1056
        OR    A
        SBC   HL,DE
L372:
        JP    Z,L365
L373:
        ;;test10.j(127) 
L374:
        ;;test10.j(128)   /************************/
L375:
        ;;test10.j(129)   // acc - acc
L376:
        ;;test10.j(130)   // byte - byte
L377:
        ;;test10.j(131)   b=57;
L378:
        LD    A,57
L379:
        LD    (05000H),A
L380:
        ;;test10.j(132)   do { write (b); b++; } while (b+0 <= 58+0);
L381:
        LD    A,(05000H)
L382:
        CALL  writeA
L383:
        LD    HL,(05000H)
        INC   (HL)
L384:
        LD    A,(05000H)
L385:
        ADD   A,0
L386:
        PUSH AF
L387:
        LD    A,58
L388:
        ADD   A,0
L389:
        POP   BC
        SUB   A,B
L390:
        JP    NC,L381
L391:
        ;;test10.j(133)   // byte - integer
L392:
        ;;test10.j(134)   i=61;
L393:
        LD    A,61
L394:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L395:
        ;;test10.j(135)   do { write (b); b++; i--; } while (60+0 <= i+0);
L396:
        LD    A,(05000H)
L397:
        CALL  writeA
L398:
        LD    HL,(05000H)
        INC   (HL)
L399:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L400:
        LD    A,60
L401:
        ADD   A,0
L402:
        PUSH AF
L403:
        LD    HL,(05001H)
L404:
        LD    DE,0
        ADD   HL,DE
L405:
        POP  AF
L406:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L407:
        JP    Z,L396
L408:
        ;;test10.j(136)   // integer - byte
L409:
        ;;test10.j(137)   i=61;
L410:
        LD    A,61
L411:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L412:
        ;;test10.j(138)   b=62;
L413:
        LD    A,62
L414:
        LD    (05000H),A
L415:
        ;;test10.j(139)   do { write (i); i++; } while (i+0 <= b+0);
L416:
        LD    HL,(05001H)
L417:
        CALL  writeHL
L418:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L419:
        LD    HL,(05001H)
L420:
        LD    DE,0
        ADD   HL,DE
L421:
        PUSH HL
L422:
        LD    A,(05000H)
L423:
        ADD   A,0
L424:
        POP  HL
L425:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L426:
        JP    Z,L416
L427:
        ;;test10.j(140)   // integer - integer
L428:
        ;;test10.j(141)   b=63;
L429:
        LD    A,63
L430:
        LD    (05000H),A
L431:
        ;;test10.j(142)   i=1063;
L432:
        LD    HL,1063
L433:
        LD    (05001H),HL
L434:
        ;;test10.j(143)   do { write (b); b++; i--; } while (1000+62 <= i+0);
L435:
        LD    A,(05000H)
L436:
        CALL  writeA
L437:
        LD    HL,(05000H)
        INC   (HL)
L438:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L439:
        LD    HL,1000
L440:
        LD    DE,62
        ADD   HL,DE
L441:
        PUSH HL
L442:
        LD    HL,(05001H)
L443:
        LD    DE,0
        ADD   HL,DE
L444:
        POP   DE
        OR    A
        SBC   HL,DE
L445:
        JP    NC,L435
L446:
        ;;test10.j(144) 
L447:
        ;;test10.j(145)   /************************/
L448:
        ;;test10.j(146)   // acc - var
L449:
        ;;test10.j(147)   // byte - byte
L450:
        ;;test10.j(148)   b=65;
L451:
        LD    A,65
L452:
        LD    (05000H),A
L453:
        ;;test10.j(149)   i=65;
L454:
        LD    A,65
L455:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L456:
        ;;test10.j(150)   do { write (i); i++; b--; } while (64+0 <= b);
L457:
        LD    HL,(05001H)
L458:
        CALL  writeHL
L459:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L460:
        LD    HL,(05000H)
        DEC   (HL)
L461:
        LD    A,64
L462:
        ADD   A,0
L463:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L464:
        JP    Z,L457
L465:
        ;;test10.j(151)   // byte - integer
L466:
        ;;test10.j(152)   b=67;
L467:
        LD    A,67
L468:
        LD    (05000H),A
L469:
        ;;test10.j(153)   i=67;
L470:
        LD    A,67
L471:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L472:
        ;;test10.j(154)   do { write (b); b++; i--; } while (66+0 <= i);
L473:
        LD    A,(05000H)
L474:
        CALL  writeA
L475:
        LD    HL,(05000H)
        INC   (HL)
L476:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L477:
        LD    A,66
L478:
        ADD   A,0
L479:
        LD    HL,(05001H)
L480:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L481:
        JP    Z,L473
L482:
        ;;test10.j(155)   // integer - byte
L483:
        ;;test10.j(156)   i=69;
L484:
        LD    A,69
L485:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L486:
        ;;test10.j(157)   b=69;
L487:
        LD    A,69
L488:
        LD    (05000H),A
L489:
        ;;test10.j(158)   do { write (i); i++; b--; } while (1000+68 <= b);
L490:
        LD    HL,(05001H)
L491:
        CALL  writeHL
L492:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L493:
        LD    HL,(05000H)
        DEC   (HL)
L494:
        LD    HL,1000
L495:
        LD    DE,68
        ADD   HL,DE
L496:
        LD    A,(05000H)
L497:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L498:
        JP    Z,L490
L499:
        ;;test10.j(159)   // integer - integer
L500:
        ;;test10.j(160)   i=1071;
L501:
        LD    HL,1071
L502:
        LD    (05001H),HL
L503:
        ;;test10.j(161)   b=70;
L504:
        LD    A,70
L505:
        LD    (05000H),A
L506:
        ;;test10.j(162)   do { write (b); b++; i--; } while (1000+70 <= i);
L507:
        LD    A,(05000H)
L508:
        CALL  writeA
L509:
        LD    HL,(05000H)
        INC   (HL)
L510:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L511:
        LD    HL,1000
L512:
        LD    DE,70
        ADD   HL,DE
L513:
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
L514:
        JP    Z,L507
L515:
        ;;test10.j(163) 
L516:
        ;;test10.j(164)   /************************/
L517:
        ;;test10.j(165)   // acc - stack16
L518:
        ;;test10.j(166)   // byte - byte
L519:
        ;;test10.j(167)   //TODO
L520:
        ;;test10.j(168)   write(72);
L521:
        LD    A,72
L522:
        CALL  writeA
L523:
        ;;test10.j(169)   write(73);
L524:
        LD    A,73
L525:
        CALL  writeA
L526:
        ;;test10.j(170)   // byte - integer
L527:
        ;;test10.j(171)   //TODO
L528:
        ;;test10.j(172)   write(74);
L529:
        LD    A,74
L530:
        CALL  writeA
L531:
        ;;test10.j(173)   write(75);
L532:
        LD    A,75
L533:
        CALL  writeA
L534:
        ;;test10.j(174)   // integer - byte
L535:
        ;;test10.j(175)   //TODO
L536:
        ;;test10.j(176)   write(76);
L537:
        LD    A,76
L538:
        CALL  writeA
L539:
        ;;test10.j(177)   write(77);
L540:
        LD    A,77
L541:
        CALL  writeA
L542:
        ;;test10.j(178)   // integer - integer
L543:
        ;;test10.j(179)   //TODO
L544:
        ;;test10.j(180)   write(78);
L545:
        LD    A,78
L546:
        CALL  writeA
L547:
        ;;test10.j(181)   write(79);
L548:
        LD    A,79
L549:
        CALL  writeA
L550:
        ;;test10.j(182) 
L551:
        ;;test10.j(183)   /************************/
L552:
        ;;test10.j(184)   // acc - stack8
L553:
        ;;test10.j(185)   // byte - byte
L554:
        ;;test10.j(186)   //TODO
L555:
        ;;test10.j(187)   write(80);
L556:
        LD    A,80
L557:
        CALL  writeA
L558:
        ;;test10.j(188)   write(81);
L559:
        LD    A,81
L560:
        CALL  writeA
L561:
        ;;test10.j(189)   // byte - integer
L562:
        ;;test10.j(190)   //TODO
L563:
        ;;test10.j(191)   write(82);
L564:
        LD    A,82
L565:
        CALL  writeA
L566:
        ;;test10.j(192)   write(83);
L567:
        LD    A,83
L568:
        CALL  writeA
L569:
        ;;test10.j(193)   // integer - byte
L570:
        ;;test10.j(194)   //TODO
L571:
        ;;test10.j(195)   write(84);
L572:
        LD    A,84
L573:
        CALL  writeA
L574:
        ;;test10.j(196)   write(85);
L575:
        LD    A,85
L576:
        CALL  writeA
L577:
        ;;test10.j(197)   // integer - integer
L578:
        ;;test10.j(198)   //TODO
L579:
        ;;test10.j(199)   write(86);
L580:
        LD    A,86
L581:
        CALL  writeA
L582:
        ;;test10.j(200)   write(87);
L583:
        LD    A,87
L584:
        CALL  writeA
L585:
        ;;test10.j(201) 
L586:
        ;;test10.j(202)   /************************/
L587:
        ;;test10.j(203)   // var - constant
L588:
        ;;test10.j(204)   // byte - byte
L589:
        ;;test10.j(205)   b=88;
L590:
        LD    A,88
L591:
        LD    (05000H),A
L592:
        ;;test10.j(206)   do { write (b); b++; } while (b <= 89);
L593:
        LD    A,(05000H)
L594:
        CALL  writeA
L595:
        LD    HL,(05000H)
        INC   (HL)
L596:
        LD    A,(05000H)
L597:
        SUB   A,89
L598:
        JP    Z,L593
L599:
        ;;test10.j(207)   // byte - integer
L600:
        ;;test10.j(208)   //not relevant
L601:
        ;;test10.j(209)   write(90);
L602:
        LD    A,90
L603:
        CALL  writeA
L604:
        ;;test10.j(210)   write(91);
L605:
        LD    A,91
L606:
        CALL  writeA
L607:
        ;;test10.j(211)   // integer - byte
L608:
        ;;test10.j(212)   i=92;
L609:
        LD    A,92
L610:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L611:
        ;;test10.j(213)   do { write (i); i++; } while (i <= 93);
L612:
        LD    HL,(05001H)
L613:
        CALL  writeHL
L614:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L615:
        LD    HL,(05001H)
L616:
        LD    A,93
L617:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L618:
        JP    Z,L612
L619:
        ;;test10.j(214)   // integer - integer
L620:
        ;;test10.j(215)   i=1094;
L621:
        LD    HL,1094
L622:
        LD    (05001H),HL
L623:
        ;;test10.j(216)   b=94;
L624:
        LD    A,94
L625:
        LD    (05000H),A
L626:
        ;;test10.j(217)   do { write (b); b++; i++; } while (i <= 1095  );
L627:
        LD    A,(05000H)
L628:
        CALL  writeA
L629:
        LD    HL,(05000H)
        INC   (HL)
L630:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L631:
        LD    HL,(05001H)
L632:
        LD    DE,1095
        OR    A
        SBC   HL,DE
L633:
        JP    Z,L627
L634:
        ;;test10.j(218) 
L635:
        ;;test10.j(219)   /************************/
L636:
        ;;test10.j(220)   // var - acc
L637:
        ;;test10.j(221)   // byte - byte
L638:
        ;;test10.j(222)   do { write (b); b++; } while (b <= 97+0);
L639:
        LD    A,(05000H)
L640:
        CALL  writeA
L641:
        LD    HL,(05000H)
        INC   (HL)
L642:
        LD    A,97
L643:
        ADD   A,0
L644:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L645:
        JP    NC,L639
L646:
        ;;test10.j(223)   // byte - integer
L647:
        ;;test10.j(224)   //not relevant
L648:
        ;;test10.j(225)   i=99;
L649:
        LD    A,99
L650:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L651:
        ;;test10.j(226)   do { write (b); b++; } while (b <= i+0);
L652:
        LD    A,(05000H)
L653:
        CALL  writeA
L654:
        LD    HL,(05000H)
        INC   (HL)
L655:
        LD    HL,(05001H)
L656:
        LD    DE,0
        ADD   HL,DE
L657:
        LD    A,(05000H)
L658:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L659:
        JP    Z,L652
L660:
        ;;test10.j(227)   // integer - byte
L661:
        ;;test10.j(228)   i=100;
L662:
        LD    A,100
L663:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L664:
        ;;test10.j(229)   do { write (i); i++; } while (i <= 101+0);
L665:
        LD    HL,(05001H)
L666:
        CALL  writeHL
L667:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L668:
        LD    A,101
L669:
        ADD   A,0
L670:
        LD    HL,(05001H)
L671:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L672:
        JP    Z,L665
L673:
        ;;test10.j(230)   // integer - integer
L674:
        ;;test10.j(231)   i=1102;
L675:
        LD    HL,1102
L676:
        LD    (05001H),HL
L677:
        ;;test10.j(232)   b=102;
L678:
        LD    A,102
L679:
        LD    (05000H),A
L680:
        ;;test10.j(233)   do { write (b); b++; i++; } while (i <= 1103+0);
L681:
        LD    A,(05000H)
L682:
        CALL  writeA
L683:
        LD    HL,(05000H)
        INC   (HL)
L684:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L685:
        LD    HL,1103
L686:
        LD    DE,0
        ADD   HL,DE
L687:
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
L688:
        JP    NC,L681
L689:
        ;;test10.j(234) 
L690:
        ;;test10.j(235)   /************************/
L691:
        ;;test10.j(236)   // var - var
L692:
        ;;test10.j(237)   // byte - byte
L693:
        ;;test10.j(238)   byte b2 = 105;
L694:
        LD    A,105
L695:
        LD    (05005H),A
L696:
        ;;test10.j(239)   do { write (b); b++; } while (b <= b2);
L697:
        LD    A,(05000H)
L698:
        CALL  writeA
L699:
        LD    HL,(05000H)
        INC   (HL)
L700:
        LD    A,(05000H)
L701:
        LD    B,A
        LD    A,(05005H)
        SUB   A,B
L702:
        JP    Z,L697
L703:
        ;;test10.j(240)   // byte - integer
L704:
        ;;test10.j(241)   i=107;
L705:
        LD    A,107
L706:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L707:
        ;;test10.j(242)   do { write (b); b++; } while (b <= i);
L708:
        LD    A,(05000H)
L709:
        CALL  writeA
L710:
        LD    HL,(05000H)
        INC   (HL)
L711:
        LD    A,(05000H)
L712:
        LD    HL,(05001H)
L713:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L714:
        JP    Z,L708
L715:
        ;;test10.j(243)   // integer - byte
L716:
        ;;test10.j(244)   i=b;
L717:
        LD    A,(05000H)
L718:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L719:
        ;;test10.j(245)   b=109;
L720:
        LD    A,109
L721:
        LD    (05000H),A
L722:
        ;;test10.j(246)   do { write (i); i++; } while (i <= b);
L723:
        LD    HL,(05001H)
L724:
        CALL  writeHL
L725:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L726:
        LD    HL,(05001H)
L727:
        LD    A,(05000H)
L728:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L729:
        JP    Z,L723
L730:
        ;;test10.j(247)   // integer - integer
L731:
        ;;test10.j(248)   word i2 = 111;
L732:
        LD    A,111
L733:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L734:
        ;;test10.j(249)   do { write (i); i++; } while (i <= i2);
L735:
        LD    HL,(05001H)
L736:
        CALL  writeHL
L737:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L738:
        LD    HL,(05001H)
L739:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L740:
        JP    Z,L735
L741:
        ;;test10.j(250) 
L742:
        ;;test10.j(251)   /************************/
L743:
        ;;test10.j(252)   // var - stack8
L744:
        ;;test10.j(253)   // byte - byte
L745:
        ;;test10.j(254)   // byte - integer
L746:
        ;;test10.j(255)   // integer - byte
L747:
        ;;test10.j(256)   // integer - integer
L748:
        ;;test10.j(257)   //TODO
L749:
        ;;test10.j(258) 
L750:
        ;;test10.j(259)   /************************/
L751:
        ;;test10.j(260)   // var - stack16
L752:
        ;;test10.j(261)   // byte - byte
L753:
        ;;test10.j(262)   // byte - integer
L754:
        ;;test10.j(263)   // integer - byte
L755:
        ;;test10.j(264)   // integer - integer
L756:
        ;;test10.j(265)   //TODO
L757:
        ;;test10.j(266) 
L758:
        ;;test10.j(267)   /************************/
L759:
        ;;test10.j(268)   // stack8 - constant
L760:
        ;;test10.j(269)   // stack8 - acc
L761:
        ;;test10.j(270)   // stack8 - var
L762:
        ;;test10.j(271)   // stack8 - stack8
L763:
        ;;test10.j(272)   // stack8 - stack16
L764:
        ;;test10.j(273)   //TODO
L765:
        ;;test10.j(274) 
L766:
        ;;test10.j(275)   /************************/
L767:
        ;;test10.j(276)   // stack16 - constant
L768:
        ;;test10.j(277)   // stack16 - acc
L769:
        ;;test10.j(278)   // stack16 - var
L770:
        ;;test10.j(279)   // stack16 - stack8
L771:
        ;;test10.j(280)   // stack16 - stack16
L772:
        ;;test10.j(281)   //TODO
L773:
        ;;test10.j(282) 
L774:
        ;;test10.j(283)   write("Klaar");
L775:
        LD    HL,779
L776:
        CALL  putStr
L777:
        ;;test10.j(284) }
L778:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L779:
        .ASCIZ  "Klaar"
