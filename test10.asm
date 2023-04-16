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
        ;;test10.j(2)   byte b = 115;
L3:
        LD    A,115
L4:
        LD    (05000H),A
L5:
        ;;test10.j(3)   
L6:
        ;;test10.j(4)   /************************/
L7:
        ;;test10.j(5)   // global variable within do scope
L8:
        ;;test10.j(6)   write (b);
L9:
        LD    A,(05000H)
L10:
        CALL  writeA
L11:
        ;;test10.j(7)   b--;
L12:
        LD    HL,(05000H)
        DEC   (HL)
L13:
        ;;test10.j(8)   do {
L14:
        ;;test10.j(9)     word j = 1001;
L15:
        LD    HL,1001
L16:
        LD    (05001H),HL
L17:
        ;;test10.j(10)     byte c = b;
L18:
        LD    A,(05000H)
L19:
        LD    (05003H),A
L20:
        ;;test10.j(11)     byte d = c;
L21:
        LD    A,(05003H)
L22:
        LD    (05004H),A
L23:
        ;;test10.j(12)     b--;
L24:
        LD    HL,(05000H)
        DEC   (HL)
L25:
        ;;test10.j(13)     write (c);
L26:
        LD    A,(05003H)
L27:
        CALL  writeA
L28:
        ;;test10.j(14)   } while (b>112);
L29:
        LD    A,(05000H)
L30:
        SUB   A,112
L31:
        JR    Z,$+5
        JP    C,L14
L32:
        ;;test10.j(15) 
L33:
        ;;test10.j(16)   word i = 12;
L34:
        LD    A,12
L35:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L36:
        ;;test10.j(17)   word p = 12;
L37:
        LD    A,12
L38:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L39:
        ;;test10.j(18)   b = 24;
L40:
        LD    A,24
L41:
        LD    (05000H),A
L42:
        ;;test10.j(19) 
L43:
        ;;test10.j(20)   /************************/
L44:
        ;;test10.j(21)   // stack8 - constant
L45:
        ;;test10.j(22)   // stack8 - acc
L46:
        ;;test10.j(23)   // stack8 - var
L47:
        ;;test10.j(24)   // stack8 - stack8
L48:
        ;;test10.j(25)   // stack8 - stack16
L49:
        ;;test10.j(26)   //TODO
L50:
        ;;test10.j(27) 
L51:
        ;;test10.j(28)   /************************/
L52:
        ;;test10.j(29)   // stack16 - constant
L53:
        ;;test10.j(30)   // stack16 - acc
L54:
        ;;test10.j(31)   // stack16 - var
L55:
        ;;test10.j(32)   // stack16 - stack8
L56:
        ;;test10.j(33)   // stack16 - stack16
L57:
        ;;test10.j(34)   //TODO
L58:
        ;;test10.j(35) 
L59:
        ;;test10.j(36)   /************************/
L60:
        ;;test10.j(37)   // var - stack16
L61:
        ;;test10.j(38)   // byte - byte
L62:
        ;;test10.j(39)   // byte - integer
L63:
        ;;test10.j(40)   // integer - byte
L64:
        ;;test10.j(41)   // integer - integer
L65:
        ;;test10.j(42)   //TODO
L66:
        ;;test10.j(43) 
L67:
        ;;test10.j(44)   /************************/
L68:
        ;;test10.j(45)   // var - stack8
L69:
        ;;test10.j(46)   // byte - byte
L70:
        ;;test10.j(47)   // byte - integer
L71:
        ;;test10.j(48)   // integer - byte
L72:
        ;;test10.j(49)   // integer - integer
L73:
        ;;test10.j(50)   //TODO
L74:
        ;;test10.j(51) 
L75:
        ;;test10.j(52)   /************************/
L76:
        ;;test10.j(53)   // var - var
L77:
        ;;test10.j(54)   // byte - byte
L78:
        ;;test10.j(55)   b=112;
L79:
        LD    A,112
L80:
        LD    (05000H),A
L81:
        ;;test10.j(56)   byte b2 = 111;
L82:
        LD    A,111
L83:
        LD    (05005H),A
L84:
        ;;test10.j(57)   do { write (b); b--; } while (b2 <= b);
L85:
        LD    A,(05000H)
L86:
        CALL  writeA
L87:
        LD    HL,(05000H)
        DEC   (HL)
L88:
        LD    A,(05005H)
L89:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L90:
        JP    Z,L85
L91:
        ;;test10.j(58)   // byte - integer
L92:
        ;;test10.j(59)   i=110;
L93:
        LD    A,110
L94:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L95:
        ;;test10.j(60)   b2 = 109;
L96:
        LD    A,109
L97:
        LD    (05005H),A
L98:
        ;;test10.j(61)   do { write (i); i--; } while (b2 <= i);
L99:
        LD    HL,(05001H)
L100:
        CALL  writeHL
L101:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L102:
        LD    A,(05005H)
L103:
        LD    HL,(05001H)
L104:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L105:
        JP    Z,L99
L106:
        ;;test10.j(62)   // integer - byte
L107:
        ;;test10.j(63)   b=108;
L108:
        LD    A,108
L109:
        LD    (05000H),A
L110:
        ;;test10.j(64)   i=107;
L111:
        LD    A,107
L112:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L113:
        ;;test10.j(65)   do { write (b); b--; } while (i <= b);
L114:
        LD    A,(05000H)
L115:
        CALL  writeA
L116:
        LD    HL,(05000H)
        DEC   (HL)
L117:
        LD    HL,(05001H)
L118:
        LD    A,(05000H)
L119:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L120:
        JP    Z,L114
L121:
        ;;test10.j(66)   // integer - integer
L122:
        ;;test10.j(67)   i=106;
L123:
        LD    A,106
L124:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L125:
        ;;test10.j(68)   word i2 = 105;
L126:
        LD    A,105
L127:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L128:
        ;;test10.j(69)   do { write (i); i--; } while (i2 <= i);
L129:
        LD    HL,(05001H)
L130:
        CALL  writeHL
L131:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L132:
        LD    HL,(05006H)
L133:
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
L134:
        JP    Z,L129
L135:
        ;;test10.j(70) 
L136:
        ;;test10.j(71)   /************************/
L137:
        ;;test10.j(72)   // var - acc
L138:
        ;;test10.j(73)   // byte - byte
L139:
        ;;test10.j(74)   i=104;
L140:
        LD    A,104
L141:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L142:
        ;;test10.j(75)   b=104;
L143:
        LD    A,104
L144:
        LD    (05000H),A
L145:
        ;;test10.j(76)   do { write (i); i--; b++; } while (b <= 105+0);
L146:
        LD    HL,(05001H)
L147:
        CALL  writeHL
L148:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L149:
        LD    HL,(05000H)
        INC   (HL)
L150:
        LD    A,105
L151:
        ADD   A,0
L152:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L153:
        JP    NC,L146
L154:
        ;;test10.j(77)   // byte - integer
L155:
        ;;test10.j(78)   //not relevant
L156:
        ;;test10.j(79)   i=103;
L157:
        LD    A,103
L158:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L159:
        ;;test10.j(80)   b=102;
L160:
        LD    A,102
L161:
        LD    (05000H),A
L162:
        ;;test10.j(81)   do { write (b); b--; i=i-2; } while (b <= i+0);
L163:
        LD    A,(05000H)
L164:
        CALL  writeA
L165:
        LD    HL,(05000H)
        DEC   (HL)
L166:
        LD    HL,(05001H)
L167:
        LD    DE,2
        OR    A
        SBC   HL,DE
L168:
        LD    (05001H),HL
L169:
        LD    HL,(05001H)
L170:
        LD    DE,0
        ADD   HL,DE
L171:
        LD    A,(05000H)
L172:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L173:
        JP    Z,L163
L174:
        ;;test10.j(82)   // integer - byte
L175:
        ;;test10.j(83)   i=100;
L176:
        LD    A,100
L177:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L178:
        ;;test10.j(84)   do { write (b); b--; i++; } while (i <= 101+0);
L179:
        LD    A,(05000H)
L180:
        CALL  writeA
L181:
        LD    HL,(05000H)
        DEC   (HL)
L182:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L183:
        LD    A,101
L184:
        ADD   A,0
L185:
        LD    HL,(05001H)
L186:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L187:
        JP    Z,L179
L188:
        ;;test10.j(85)   // integer - integer
L189:
        ;;test10.j(86)   i=1098;
L190:
        LD    HL,1098
L191:
        LD    (05001H),HL
L192:
        ;;test10.j(87)   do { write (b); b--; i++; } while (i <= 1099+0);
L193:
        LD    A,(05000H)
L194:
        CALL  writeA
L195:
        LD    HL,(05000H)
        DEC   (HL)
L196:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L197:
        LD    HL,1099
L198:
        LD    DE,0
        ADD   HL,DE
L199:
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
L200:
        JP    NC,L193
L201:
        ;;test10.j(88) 
L202:
        ;;test10.j(89)   /************************/
L203:
        ;;test10.j(90)   // var - constant
L204:
        ;;test10.j(91)   // byte - byte
L205:
        ;;test10.j(92)   i=96;
L206:
        LD    A,96
L207:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L208:
        ;;test10.j(93)   b=96;
L209:
        LD    A,96
L210:
        LD    (05000H),A
L211:
        ;;test10.j(94)   do { write (i); i--; b++; } while (b <= 97);
L212:
        LD    HL,(05001H)
L213:
        CALL  writeHL
L214:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L215:
        LD    HL,(05000H)
        INC   (HL)
L216:
        LD    A,(05000H)
L217:
        SUB   A,97
L218:
        JP    Z,L212
L219:
        ;;test10.j(95)   // byte - integer
L220:
        ;;test10.j(96)   //not relevant
L221:
        ;;test10.j(97)   write(94);
L222:
        LD    A,94
L223:
        CALL  writeA
L224:
        ;;test10.j(98)   write(93);
L225:
        LD    A,93
L226:
        CALL  writeA
L227:
        ;;test10.j(99)   // integer - byte
L228:
        ;;test10.j(100)   i=92;
L229:
        LD    A,92
L230:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L231:
        ;;test10.j(101)   b=92;
L232:
        LD    A,92
L233:
        LD    (05000H),A
L234:
        ;;test10.j(102)   do { write (b); b--; i++; } while (i <= 93);
L235:
        LD    A,(05000H)
L236:
        CALL  writeA
L237:
        LD    HL,(05000H)
        DEC   (HL)
L238:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L239:
        LD    HL,(05001H)
L240:
        LD    A,93
L241:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L242:
        JP    Z,L235
L243:
        ;;test10.j(103)   // integer - integer
L244:
        ;;test10.j(104)   i=1090;
L245:
        LD    HL,1090
L246:
        LD    (05001H),HL
L247:
        ;;test10.j(105)   do { write (b); b--; i++; } while (i <= 1091);
L248:
        LD    A,(05000H)
L249:
        CALL  writeA
L250:
        LD    HL,(05000H)
        DEC   (HL)
L251:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L252:
        LD    HL,(05001H)
L253:
        LD    DE,1091
        OR    A
        SBC   HL,DE
L254:
        JP    Z,L248
L255:
        ;;test10.j(106) 
L256:
        ;;test10.j(107)   /************************/
L257:
        ;;test10.j(108)   // acc - stack8
L258:
        ;;test10.j(109)   // byte - byte
L259:
        ;;test10.j(110)   //TODO
L260:
        ;;test10.j(111)   write(88);
L261:
        LD    A,88
L262:
        CALL  writeA
L263:
        ;;test10.j(112)   write(87);
L264:
        LD    A,87
L265:
        CALL  writeA
L266:
        ;;test10.j(113)   // byte - integer
L267:
        ;;test10.j(114)   //TODO
L268:
        ;;test10.j(115)   write(86);
L269:
        LD    A,86
L270:
        CALL  writeA
L271:
        ;;test10.j(116)   write(85);
L272:
        LD    A,85
L273:
        CALL  writeA
L274:
        ;;test10.j(117)   // integer - byte
L275:
        ;;test10.j(118)   //TODO
L276:
        ;;test10.j(119)   write(84);
L277:
        LD    A,84
L278:
        CALL  writeA
L279:
        ;;test10.j(120)   write(83);
L280:
        LD    A,83
L281:
        CALL  writeA
L282:
        ;;test10.j(121)   // integer - integer
L283:
        ;;test10.j(122)   //TODO
L284:
        ;;test10.j(123)   write(82);
L285:
        LD    A,82
L286:
        CALL  writeA
L287:
        ;;test10.j(124)   write(81);
L288:
        LD    A,81
L289:
        CALL  writeA
L290:
        ;;test10.j(125) 
L291:
        ;;test10.j(126)   /************************/
L292:
        ;;test10.j(127)   // acc - stack16
L293:
        ;;test10.j(128)   // byte - byte
L294:
        ;;test10.j(129)   //TODO
L295:
        ;;test10.j(130)   write(80);
L296:
        LD    A,80
L297:
        CALL  writeA
L298:
        ;;test10.j(131)   write(79);
L299:
        LD    A,79
L300:
        CALL  writeA
L301:
        ;;test10.j(132)   // byte - integer
L302:
        ;;test10.j(133)   //TODO
L303:
        ;;test10.j(134)   write(78);
L304:
        LD    A,78
L305:
        CALL  writeA
L306:
        ;;test10.j(135)   write(77);
L307:
        LD    A,77
L308:
        CALL  writeA
L309:
        ;;test10.j(136)   // integer - byte
L310:
        ;;test10.j(137)   //TODO
L311:
        ;;test10.j(138)   write(76);
L312:
        LD    A,76
L313:
        CALL  writeA
L314:
        ;;test10.j(139)   write(75);
L315:
        LD    A,75
L316:
        CALL  writeA
L317:
        ;;test10.j(140)   // integer - integer
L318:
        ;;test10.j(141)   //TODO
L319:
        ;;test10.j(142)   write(74);
L320:
        LD    A,74
L321:
        CALL  writeA
L322:
        ;;test10.j(143)   write(73);
L323:
        LD    A,73
L324:
        CALL  writeA
L325:
        ;;test10.j(144) 
L326:
        ;;test10.j(145)   /************************/
L327:
        ;;test10.j(146)   // acc - var
L328:
        ;;test10.j(147)   // byte - byte
L329:
        ;;test10.j(148)   b=72;
L330:
        LD    A,72
L331:
        LD    (05000H),A
L332:
        ;;test10.j(149)   do { write (b); b--; } while (71+0 <= b);
L333:
        LD    A,(05000H)
L334:
        CALL  writeA
L335:
        LD    HL,(05000H)
        DEC   (HL)
L336:
        LD    A,71
L337:
        ADD   A,0
L338:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L339:
        JP    Z,L333
L340:
        ;;test10.j(150)   // byte - integer
L341:
        ;;test10.j(151)   i=70;
L342:
        LD    A,70
L343:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L344:
        ;;test10.j(152)   do { write (i); i--; } while (69+0 <= i);
L345:
        LD    HL,(05001H)
L346:
        CALL  writeHL
L347:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L348:
        LD    A,69
L349:
        ADD   A,0
L350:
        LD    HL,(05001H)
L351:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L352:
        JP    Z,L345
L353:
        ;;test10.j(153)   // integer - byte
L354:
        ;;test10.j(154)   i=67;
L355:
        LD    A,67
L356:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L357:
        ;;test10.j(155)   b=68;
L358:
        LD    A,68
L359:
        LD    (05000H),A
L360:
        ;;test10.j(156)   do { write (b); b--; } while (i+0 <= b);
L361:
        LD    A,(05000H)
L362:
        CALL  writeA
L363:
        LD    HL,(05000H)
        DEC   (HL)
L364:
        LD    HL,(05001H)
L365:
        LD    DE,0
        ADD   HL,DE
L366:
        LD    A,(05000H)
L367:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L368:
        JP    Z,L361
L369:
        ;;test10.j(157)   // integer - integer
L370:
        ;;test10.j(158)   i=1066;
L371:
        LD    HL,1066
L372:
        LD    (05001H),HL
L373:
        ;;test10.j(159)   do { write (b); b--; i--; } while (1000+65 <= i);
L374:
        LD    A,(05000H)
L375:
        CALL  writeA
L376:
        LD    HL,(05000H)
        DEC   (HL)
L377:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L378:
        LD    HL,1000
L379:
        LD    DE,65
        ADD   HL,DE
L380:
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
L381:
        JP    Z,L374
L382:
        ;;test10.j(160) 
L383:
        ;;test10.j(161)   /************************/
L384:
        ;;test10.j(162)   // acc - acc
L385:
        ;;test10.j(163)   // byte - byte
L386:
        ;;test10.j(164)   b=64;
L387:
        LD    A,64
L388:
        LD    (05000H),A
L389:
        ;;test10.j(165)   do { write (b); b--; } while (63+0 <= b+0);
L390:
        LD    A,(05000H)
L391:
        CALL  writeA
L392:
        LD    HL,(05000H)
        DEC   (HL)
L393:
        LD    A,63
L394:
        ADD   A,0
L395:
        PUSH AF
L396:
        LD    A,(05000H)
L397:
        ADD   A,0
L398:
        POP   BC
        SUB   A,B
L399:
        JP    NC,L390
L400:
        ;;test10.j(166)   // byte - integer
L401:
        ;;test10.j(167)   i=62;
L402:
        LD    A,62
L403:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L404:
        ;;test10.j(168)   do { write (i); i--; } while (61+0 <= i+0);
L405:
        LD    HL,(05001H)
L406:
        CALL  writeHL
L407:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L408:
        LD    A,61
L409:
        ADD   A,0
L410:
        PUSH AF
L411:
        LD    HL,(05001H)
L412:
        LD    DE,0
        ADD   HL,DE
L413:
        POP  AF
L414:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L415:
        JP    Z,L405
L416:
        ;;test10.j(169)   // integer - byte
L417:
        ;;test10.j(170)   i=59;
L418:
        LD    A,59
L419:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L420:
        ;;test10.j(171)   b=60;
L421:
        LD    A,60
L422:
        LD    (05000H),A
L423:
        ;;test10.j(172)   do { write (b); b--; } while (i+0 <= b+0);
L424:
        LD    A,(05000H)
L425:
        CALL  writeA
L426:
        LD    HL,(05000H)
        DEC   (HL)
L427:
        LD    HL,(05001H)
L428:
        LD    DE,0
        ADD   HL,DE
L429:
        PUSH HL
L430:
        LD    A,(05000H)
L431:
        ADD   A,0
L432:
        POP  HL
L433:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L434:
        JP    Z,L424
L435:
        ;;test10.j(173)   // integer - integer
L436:
        ;;test10.j(174)   i=1058;
L437:
        LD    HL,1058
L438:
        LD    (05001H),HL
L439:
        ;;test10.j(175)   do { write (b); b--; i--; } while (1000+57 <= i+0);
L440:
        LD    A,(05000H)
L441:
        CALL  writeA
L442:
        LD    HL,(05000H)
        DEC   (HL)
L443:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L444:
        LD    HL,1000
L445:
        LD    DE,57
        ADD   HL,DE
L446:
        PUSH HL
L447:
        LD    HL,(05001H)
L448:
        LD    DE,0
        ADD   HL,DE
L449:
        POP   DE
        OR    A
        SBC   HL,DE
L450:
        JP    NC,L440
L451:
        ;;test10.j(176) 
L452:
        ;;test10.j(177)   /************************/
L453:
        ;;test10.j(178)   // acc - constant
L454:
        ;;test10.j(179)   // byte - byte
L455:
        ;;test10.j(180)   i=56;
L456:
        LD    A,56
L457:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L458:
        ;;test10.j(181)   b=56;
L459:
        LD    A,56
L460:
        LD    (05000H),A
L461:
        ;;test10.j(182)   do { write (i); i--; b++; } while (b+0 <= 57);
L462:
        LD    HL,(05001H)
L463:
        CALL  writeHL
L464:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L465:
        LD    HL,(05000H)
        INC   (HL)
L466:
        LD    A,(05000H)
L467:
        ADD   A,0
L468:
        SUB   A,57
L469:
        JP    Z,L462
L470:
        ;;test10.j(183)   // byte - integer
L471:
        ;;test10.j(184)   //not relevant
L472:
        ;;test10.j(185)   // integer - byte
L473:
        ;;test10.j(186)   i=54;
L474:
        LD    A,54
L475:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L476:
        ;;test10.j(187)   b=54;
L477:
        LD    A,54
L478:
        LD    (05000H),A
L479:
        ;;test10.j(188)   do { write (b); b--; i++; } while (i+0 <= 55);
L480:
        LD    A,(05000H)
L481:
        CALL  writeA
L482:
        LD    HL,(05000H)
        DEC   (HL)
L483:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L484:
        LD    HL,(05001H)
L485:
        LD    DE,0
        ADD   HL,DE
L486:
        LD    A,55
L487:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L488:
        JP    Z,L480
L489:
        ;;test10.j(189)   i=1052;
L490:
        LD    HL,1052
L491:
        LD    (05001H),HL
L492:
        ;;test10.j(190)   // integer - integer
L493:
        ;;test10.j(191)   do { write (b); b--; i++; } while (i+0 <= 1053);
L494:
        LD    A,(05000H)
L495:
        CALL  writeA
L496:
        LD    HL,(05000H)
        DEC   (HL)
L497:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L498:
        LD    HL,(05001H)
L499:
        LD    DE,0
        ADD   HL,DE
L500:
        LD    DE,1053
        OR    A
        SBC   HL,DE
L501:
        JP    Z,L494
L502:
        ;;test10.j(192) 
L503:
        ;;test10.j(193)   /************************/
L504:
        ;;test10.j(194)   // constant - stack8
L505:
        ;;test10.j(195)   // byte - byte
L506:
        ;;test10.j(196)   //TODO
L507:
        ;;test10.j(197)   write(50);
L508:
        LD    A,50
L509:
        CALL  writeA
L510:
        ;;test10.j(198)   // constant - stack8
L511:
        ;;test10.j(199)   // byte - integer
L512:
        ;;test10.j(200)   //TODO
L513:
        ;;test10.j(201)   write(49);
L514:
        LD    A,49
L515:
        CALL  writeA
L516:
        ;;test10.j(202)   // constant - stack8
L517:
        ;;test10.j(203)   // integer - byte
L518:
        ;;test10.j(204)   //TODO
L519:
        ;;test10.j(205)   write(48);
L520:
        LD    A,48
L521:
        CALL  writeA
L522:
        ;;test10.j(206)   // constant - stack88
L523:
        ;;test10.j(207)   // integer - integer
L524:
        ;;test10.j(208)   //TODO
L525:
        ;;test10.j(209)   write(47);
L526:
        LD    A,47
L527:
        CALL  writeA
L528:
        ;;test10.j(210) 
L529:
        ;;test10.j(211)   /************************/
L530:
        ;;test10.j(212)   // constant - stack16
L531:
        ;;test10.j(213)   // byte - byte
L532:
        ;;test10.j(214)   //TODO
L533:
        ;;test10.j(215)   write(46);
L534:
        LD    A,46
L535:
        CALL  writeA
L536:
        ;;test10.j(216)   // constant - stack16
L537:
        ;;test10.j(217)   // byte - integer
L538:
        ;;test10.j(218)   //TODO
L539:
        ;;test10.j(219)   write(45);
L540:
        LD    A,45
L541:
        CALL  writeA
L542:
        ;;test10.j(220)   // constant - stack16
L543:
        ;;test10.j(221)   // integer - byte
L544:
        ;;test10.j(222)   //TODO
L545:
        ;;test10.j(223)   write(44);
L546:
        LD    A,44
L547:
        CALL  writeA
L548:
        ;;test10.j(224)   // constant - stack16
L549:
        ;;test10.j(225)   // integer - integer
L550:
        ;;test10.j(226)   //TODO
L551:
        ;;test10.j(227)   write(43);
L552:
        LD    A,43
L553:
        CALL  writeA
L554:
        ;;test10.j(228) 
L555:
        ;;test10.j(229)   /************************/
L556:
        ;;test10.j(230)   // constant - var
L557:
        ;;test10.j(231)   // byte - byte
L558:
        ;;test10.j(232)   b=42;
L559:
        LD    A,42
L560:
        LD    (05000H),A
L561:
        ;;test10.j(233)   do { write (b); b--; } while (41 <= b);
L562:
        LD    A,(05000H)
L563:
        CALL  writeA
L564:
        LD    HL,(05000H)
        DEC   (HL)
L565:
        LD    A,(05000H)
L566:
        SUB   A,41
L567:
        JP    NC,L562
L568:
        ;;test10.j(234) 
L569:
        ;;test10.j(235)   // constant - var
L570:
        ;;test10.j(236)   // byte - integer
L571:
        ;;test10.j(237)   i=40;
L572:
        LD    A,40
L573:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L574:
        ;;test10.j(238)   do { write (i); i--; } while (39 <= i);
L575:
        LD    HL,(05001H)
L576:
        CALL  writeHL
L577:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L578:
        LD    HL,(05001H)
L579:
        LD    A,39
L580:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L581:
        JP    Z,L575
L582:
        ;;test10.j(239) 
L583:
        ;;test10.j(240)   // constant - var
L584:
        ;;test10.j(241)   // integer - byte
L585:
        ;;test10.j(242)   // not relevant
L586:
        ;;test10.j(243) 
L587:
        ;;test10.j(244)   // constant - var
L588:
        ;;test10.j(245)   // integer - integer
L589:
        ;;test10.j(246)   i=1038;
L590:
        LD    HL,1038
L591:
        LD    (05001H),HL
L592:
        ;;test10.j(247)   b=38;
L593:
        LD    A,38
L594:
        LD    (05000H),A
L595:
        ;;test10.j(248)   do { write (b); b--; i--; } while (1037 <= i);
L596:
        LD    A,(05000H)
L597:
        CALL  writeA
L598:
        LD    HL,(05000H)
        DEC   (HL)
L599:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L600:
        LD    HL,(05001H)
L601:
        LD    DE,1037
        OR    A
        SBC   HL,DE
L602:
        JP    NC,L596
L603:
        ;;test10.j(249) 
L604:
        ;;test10.j(250)   /************************/
L605:
        ;;test10.j(251)   // constant - acc
L606:
        ;;test10.j(252)   // byte - byte
L607:
        ;;test10.j(253)   b=36;
L608:
        LD    A,36
L609:
        LD    (05000H),A
L610:
        ;;test10.j(254)   do { write (b); b--; } while (135 == b+100);
L611:
        LD    A,(05000H)
L612:
        CALL  writeA
L613:
        LD    HL,(05000H)
        DEC   (HL)
L614:
        LD    A,(05000H)
L615:
        ADD   A,100
L616:
        SUB   A,135
L617:
        JP    Z,L611
L618:
        ;;test10.j(255)   do { write (b); b--; } while (132 != b+100);
L619:
        LD    A,(05000H)
L620:
        CALL  writeA
L621:
        LD    HL,(05000H)
        DEC   (HL)
L622:
        LD    A,(05000H)
L623:
        ADD   A,100
L624:
        SUB   A,132
L625:
        JP    NZ,L619
L626:
        ;;test10.j(256)   p=32;
L627:
        LD    A,32
L628:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L629:
        ;;test10.j(257)   do { write (p); p--; b++; } while (134 > b+100);
L630:
        LD    HL,(05003H)
L631:
        CALL  writeHL
L632:
        LD    HL,(05003H)
        DEC   HL
        LD    (05003H),HL
L633:
        LD    HL,(05000H)
        INC   (HL)
L634:
        LD    A,(05000H)
L635:
        ADD   A,100
L636:
        SUB   A,134
L637:
        JP    C,L630
L638:
        ;;test10.j(258)   do { write (p); p--; b++; } while (135 >= b+100);
L639:
        LD    HL,(05003H)
L640:
        CALL  writeHL
L641:
        LD    HL,(05003H)
        DEC   HL
        LD    (05003H),HL
L642:
        LD    HL,(05000H)
        INC   (HL)
L643:
        LD    A,(05000H)
L644:
        ADD   A,100
L645:
        SUB   A,135
L646:
        JP    Z,L639
L647:
        ;;test10.j(259)   b=28;
L648:
        LD    A,28
L649:
        LD    (05000H),A
L650:
        ;;test10.j(260)   do { write (b); b--; } while (126 <  b+100);
L651:
        LD    A,(05000H)
L652:
        CALL  writeA
L653:
        LD    HL,(05000H)
        DEC   (HL)
L654:
        LD    A,(05000H)
L655:
        ADD   A,100
L656:
        SUB   A,126
L657:
        JR    Z,$+5
        JP    C,L651
L658:
        ;;test10.j(261)   do { write (b); b--; } while (125 <= b+100);
L659:
        LD    A,(05000H)
L660:
        CALL  writeA
L661:
        LD    HL,(05000H)
        DEC   (HL)
L662:
        LD    A,(05000H)
L663:
        ADD   A,100
L664:
        SUB   A,125
L665:
        JP    NC,L659
L666:
        ;;test10.j(262)   // constant - acc
L667:
        ;;test10.j(263)   // byte - integer
L668:
        ;;test10.j(264)   i=24;
L669:
        LD    A,24
L670:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L671:
        ;;test10.j(265)   b=23;
L672:
        LD    A,23
L673:
        LD    (05000H),A
L674:
        ;;test10.j(266)   do { write (i); i--; } while (23 == i+0);
L675:
        LD    HL,(05001H)
L676:
        CALL  writeHL
L677:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L678:
        LD    HL,(05001H)
L679:
        LD    DE,0
        ADD   HL,DE
L680:
        LD    A,23
L681:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L682:
        JP    Z,L675
L683:
        ;;test10.j(267)   do { write (i); i--; } while (120 != i+100);
L684:
        LD    HL,(05001H)
L685:
        CALL  writeHL
L686:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L687:
        LD    HL,(05001H)
L688:
        LD    DE,100
        ADD   HL,DE
L689:
        LD    A,120
L690:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L691:
        JP    NZ,L684
L692:
        ;;test10.j(268)   p=20;
L693:
        LD    A,20
L694:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L695:
        ;;test10.j(269)   do { write (p); p--; i++; } while (122 > i+100);
L696:
        LD    HL,(05003H)
L697:
        CALL  writeHL
L698:
        LD    HL,(05003H)
        DEC   HL
        LD    (05003H),HL
L699:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L700:
        LD    HL,(05001H)
L701:
        LD    DE,100
        ADD   HL,DE
L702:
        LD    A,122
L703:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L704:
        JR    Z,$+5
        JP    C,L696
L705:
        ;;test10.j(270)   do { write (p); p--; i++; } while (123 >= i+100);
L706:
        LD    HL,(05003H)
L707:
        CALL  writeHL
L708:
        LD    HL,(05003H)
        DEC   HL
        LD    (05003H),HL
L709:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L710:
        LD    HL,(05001H)
L711:
        LD    DE,100
        ADD   HL,DE
L712:
        LD    A,123
L713:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L714:
        JP    NC,L706
L715:
        ;;test10.j(271)   i=16;
L716:
        LD    A,16
L717:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L718:
        ;;test10.j(272)   do { write (i); i--; } while (114 <  i+100);
L719:
        LD    HL,(05001H)
L720:
        CALL  writeHL
L721:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L722:
        LD    HL,(05001H)
L723:
        LD    DE,100
        ADD   HL,DE
L724:
        LD    A,114
L725:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L726:
        JP    C,L719
L727:
        ;;test10.j(273)   do { write (i); i--; } while (113 <= i+100);
L728:
        LD    HL,(05001H)
L729:
        CALL  writeHL
L730:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L731:
        LD    HL,(05001H)
L732:
        LD    DE,100
        ADD   HL,DE
L733:
        LD    A,113
L734:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L735:
        JP    Z,L728
L736:
        ;;test10.j(274)   // constant - acc
L737:
        ;;test10.j(275)   // integer - byte
L738:
        ;;test10.j(276)   // not relevant
L739:
        ;;test10.j(277) 
L740:
        ;;test10.j(278)   // constant - acc
L741:
        ;;test10.j(279)   // integer - integer
L742:
        ;;test10.j(280)   i=12;
L743:
        LD    A,12
L744:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L745:
        ;;test10.j(281)   do { write (i); i--; } while (1011 == i+1000);
L746:
        LD    HL,(05001H)
L747:
        CALL  writeHL
L748:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L749:
        LD    HL,(05001H)
L750:
        LD    DE,1000
        ADD   HL,DE
L751:
        LD    DE,1011
        OR    A
        SBC   HL,DE
L752:
        JP    Z,L746
L753:
        ;;test10.j(282)   //i=10
L754:
        ;;test10.j(283)   do { write (i); i--; } while (1008 != i+1000);
L755:
        LD    HL,(05001H)
L756:
        CALL  writeHL
L757:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L758:
        LD    HL,(05001H)
L759:
        LD    DE,1000
        ADD   HL,DE
L760:
        LD    DE,1008
        OR    A
        SBC   HL,DE
L761:
        JP    NZ,L755
L762:
        ;;test10.j(284)   //i=8
L763:
        ;;test10.j(285)   p=8;
L764:
        LD    A,8
L765:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L766:
        ;;test10.j(286)   do { write (p); p--; i++; } while (1010 > i+1000);
L767:
        LD    HL,(05003H)
L768:
        CALL  writeHL
L769:
        LD    HL,(05003H)
        DEC   HL
        LD    (05003H),HL
L770:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L771:
        LD    HL,(05001H)
L772:
        LD    DE,1000
        ADD   HL,DE
L773:
        LD    DE,1010
        OR    A
        SBC   HL,DE
L774:
        JP    C,L767
L775:
        ;;test10.j(287)   //i=10; p=6
L776:
        ;;test10.j(288)   do { write (p); p--; i++; } while (1011 >= i+1000);
L777:
        LD    HL,(05003H)
L778:
        CALL  writeHL
L779:
        LD    HL,(05003H)
        DEC   HL
        LD    (05003H),HL
L780:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L781:
        LD    HL,(05001H)
L782:
        LD    DE,1000
        ADD   HL,DE
L783:
        LD    DE,1011
        OR    A
        SBC   HL,DE
L784:
        JP    Z,L777
L785:
        ;;test10.j(289)   i=4;
L786:
        LD    A,4
L787:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L788:
        ;;test10.j(290)   do { write (i); i--; } while (1002 <  i+1000);
L789:
        LD    HL,(05001H)
L790:
        CALL  writeHL
L791:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L792:
        LD    HL,(05001H)
L793:
        LD    DE,1000
        ADD   HL,DE
L794:
        LD    DE,1002
        OR    A
        SBC   HL,DE
L795:
        JR    Z,$+5
        JP    C,L789
L796:
        ;;test10.j(291)   //i=2;
L797:
        ;;test10.j(292)   do { write (i); i--; } while (1001 <= i+1000);
L798:
        LD    HL,(05001H)
L799:
        CALL  writeHL
L800:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L801:
        LD    HL,(05001H)
L802:
        LD    DE,1000
        ADD   HL,DE
L803:
        LD    DE,1001
        OR    A
        SBC   HL,DE
L804:
        JP    NC,L798
L805:
        ;;test10.j(293) 
L806:
        ;;test10.j(294)   /************************/
L807:
        ;;test10.j(295)   // constant - constant
L808:
        ;;test10.j(296)   // not relevant
L809:
        ;;test10.j(297)   write(0);
L810:
        LD    A,0
L811:
        CALL  writeA
L812:
        ;;test10.j(298)   write("Klaar");
L813:
        LD    HL,817
L814:
        CALL  putStr
L815:
        ;;test10.j(299) }
L816:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L817:
        .ASCIZ  "Klaar"
