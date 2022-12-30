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
;  USES:AF
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
        ;;test5.j(0) /*
L1:
        ;;test5.j(1)  * A small program in the miniJava language.
L2:
        ;;test5.j(2)  * Test comparisons
L3:
        ;;test5.j(3)  */
L4:
        ;;test5.j(4) class TestIf {
L5:
        ;;test5.j(5)   write (134);
L6:
        LD    A,134
L7:
        CALL  writeA
L8:
        ;;test5.j(6)   /************************/
L9:
        ;;test5.j(7)   // global variable within if scope
L10:
        ;;test5.j(8)   byte b = 133;
L11:
        LD    A,133
L12:
        LD    (05000H),A
L13:
        ;;test5.j(9)   if (b>132) {
L14:
        LD    A,(05000H)
L15:
        SUB   A,132
L16:
        JP    Z,L34
L17:
        ;;test5.j(10)     word j = 1001;
L18:
        LD    HL,1001
L19:
        LD    (05001H),HL
L20:
        ;;test5.j(11)     byte c = b;
L21:
        LD    A,(05000H)
L22:
        LD    (05003H),A
L23:
        ;;test5.j(12)     byte d = c;
L24:
        LD    A,(05003H)
L25:
        LD    (05004H),A
L26:
        ;;test5.j(13)     b--;
L27:
        LD    HL,(05000H)
        DEC   (HL)
L28:
        ;;test5.j(14)     write (c);
L29:
        LD    A,(05003H)
L30:
        CALL  writeA
L31:
        ;;test5.j(15)   } else {
L32:
        JP    L39
L33:
        ;;test5.j(16)     write(0);
L34:
        LD    A,0
L35:
        CALL  writeA
L36:
        ;;test5.j(17)   }
L37:
        ;;test5.j(18)   /************************/
L38:
        ;;test5.j(19)   word zero = 0;
L39:
        LD    A,0
L40:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L41:
        ;;test5.j(20)   word one = 1;
L42:
        LD    A,1
L43:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L44:
        ;;test5.j(21)   word three = 3;
L45:
        LD    A,3
L46:
        LD    L,A
        LD    H,0
        LD    (05005H),HL
L47:
        ;;test5.j(22)   word four = 4;
L48:
        LD    A,4
L49:
        LD    L,A
        LD    H,0
        LD    (05007H),HL
L50:
        ;;test5.j(23)   word five = 5;
L51:
        LD    A,5
L52:
        LD    L,A
        LD    H,0
        LD    (05009H),HL
L53:
        ;;test5.j(24)   word twelve = 12;
L54:
        LD    A,12
L55:
        LD    L,A
        LD    H,0
        LD    (0500BH),HL
L56:
        ;;test5.j(25)   byte byteOne = 1;
L57:
        LD    A,1
L58:
        LD    (0500DH),A
L59:
        ;;test5.j(26)   byte byteSix = 262;
L60:
        LD    HL,262
L61:
        LD    A,L
        LD    (0500EH),A
L62:
        ;;test5.j(27)   if (4 == zero + twelve/(1+2)) write(132);
L63:
        LD    HL,(05001H)
L64:
        PUSH  HL
        LD    HL,(0500BH)
L65:
        LD    A,1
L66:
        ADD   A,2
L67:
        CALL  div16_8
L68:
        POP   DE
        ADD   HL,DE
L69:
        LD    A,4
L70:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L71:
        JP    NZ,L75
L72:
        LD    A,132
L73:
        CALL  writeA
L74:
        ;;test5.j(28)   if (four == 0 + 12/(one + 2)) write(131);
L75:
        LD    A,0
L76:
        PUSH  AF
        LD    A,12
L77:
        LD    HL,(05003H)
L78:
        LD    DE,2
        ADD   HL,DE
L79:
        EX    DE,HL
        CALL  div8_16
L80:
        POP   DE
        LD    D,0
        ADD   HL,DE
L81:
        LD    DE,(05007H)
        OR    A
        SBC   HL,DE
L82:
        JP    NZ,L86
L83:
        LD    A,131
L84:
        CALL  writeA
L85:
        ;;test5.j(29)   if (four == 0 + 12/(byteOne + 2)) write(130);
L86:
        LD    A,0
L87:
        PUSH  AF
        LD    A,12
L88:
        PUSH  AF
        LD    A,(0500DH)
L89:
        ADD   A,2
L90:
        LD    C,A
        POP   AF
        CALL  div8
L91:
        POP   BC
        ADD   A,B
L92:
        LD    HL,(05007H)
L93:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L94:
        JP    NZ,L98
L95:
        LD    A,130
L96:
        CALL  writeA
L97:
        ;;test5.j(30)   if (four == 0 + 12/(1 + 2)) write(129);
L98:
        LD    A,0
L99:
        PUSH  AF
        LD    A,12
L100:
        PUSH  AF
        LD    A,1
L101:
        ADD   A,2
L102:
        LD    C,A
        POP   AF
        CALL  div8
L103:
        POP   BC
        ADD   A,B
L104:
        LD    HL,(05007H)
L105:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L106:
        JP    NZ,L110
L107:
        LD    A,129
L108:
        CALL  writeA
L109:
        ;;test5.j(31)   if (four == 0 + 12/(1 + 2)) write(128);
L110:
        LD    A,0
L111:
        PUSH  AF
        LD    A,12
L112:
        PUSH  AF
        LD    A,1
L113:
        ADD   A,2
L114:
        LD    C,A
        POP   AF
        CALL  div8
L115:
        POP   BC
        ADD   A,B
L116:
        LD    HL,(05007H)
L117:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L118:
        JP    NZ,L123
L119:
        LD    A,128
L120:
        CALL  writeA
L121:
        ;;test5.j(32)   //stack level 2
L122:
        ;;test5.j(33)   if (5 >= twelve/(one+2)) write(127);
L123:
        LD    HL,(0500BH)
L124:
        PUSH  HL
        LD    HL,(05003H)
L125:
        LD    DE,2
        ADD   HL,DE
L126:
        POP   DE
        EX    DE,HL
        CALL  div16
L127:
        LD    A,5
L128:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L129:
        JP    C,L133
L130:
        LD    A,127
L131:
        CALL  writeA
L132:
        ;;test5.j(34)   if (4 >= twelve/(one+2)) write(126);
L133:
        LD    HL,(0500BH)
L134:
        PUSH  HL
        LD    HL,(05003H)
L135:
        LD    DE,2
        ADD   HL,DE
L136:
        POP   DE
        EX    DE,HL
        CALL  div16
L137:
        LD    A,4
L138:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L139:
        JP    C,L143
L140:
        LD    A,126
L141:
        CALL  writeA
L142:
        ;;test5.j(35)   if (4 <= twelve/(one+2)) write(125);
L143:
        LD    HL,(0500BH)
L144:
        PUSH  HL
        LD    HL,(05003H)
L145:
        LD    DE,2
        ADD   HL,DE
L146:
        POP   DE
        EX    DE,HL
        CALL  div16
L147:
        LD    A,4
L148:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L149:
        JR    Z,$+5
        JP    C,L153
L150:
        LD    A,125
L151:
        CALL  writeA
L152:
        ;;test5.j(36)   if (3 <= twelve/(one+2)) write(124);
L153:
        LD    HL,(0500BH)
L154:
        PUSH  HL
        LD    HL,(05003H)
L155:
        LD    DE,2
        ADD   HL,DE
L156:
        POP   DE
        EX    DE,HL
        CALL  div16
L157:
        LD    A,3
L158:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L159:
        JR    Z,$+5
        JP    C,L163
L160:
        LD    A,124
L161:
        CALL  writeA
L162:
        ;;test5.j(37)   if (5 > twelve/(one+2)) write(123);
L163:
        LD    HL,(0500BH)
L164:
        PUSH  HL
        LD    HL,(05003H)
L165:
        LD    DE,2
        ADD   HL,DE
L166:
        POP   DE
        EX    DE,HL
        CALL  div16
L167:
        LD    A,5
L168:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L169:
        JP    Z,L173
L170:
        LD    A,123
L171:
        CALL  writeA
L172:
        ;;test5.j(38)   if (2 < twelve/(one+2)) write(122);
L173:
        LD    HL,(0500BH)
L174:
        PUSH  HL
        LD    HL,(05003H)
L175:
        LD    DE,2
        ADD   HL,DE
L176:
        POP   DE
        EX    DE,HL
        CALL  div16
L177:
        LD    A,2
L178:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L179:
        JP    NC,L183
L180:
        LD    A,122
L181:
        CALL  writeA
L182:
        ;;test5.j(39)   if (3 != twelve/(one+2)) write(121);
L183:
        LD    HL,(0500BH)
L184:
        PUSH  HL
        LD    HL,(05003H)
L185:
        LD    DE,2
        ADD   HL,DE
L186:
        POP   DE
        EX    DE,HL
        CALL  div16
L187:
        LD    A,3
L188:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L189:
        JP    Z,L193
L190:
        LD    A,121
L191:
        CALL  writeA
L192:
        ;;test5.j(40)   if (4 == twelve/(one+2)) write(120);
L193:
        LD    HL,(0500BH)
L194:
        PUSH  HL
        LD    HL,(05003H)
L195:
        LD    DE,2
        ADD   HL,DE
L196:
        POP   DE
        EX    DE,HL
        CALL  div16
L197:
        LD    A,4
L198:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L199:
        JP    NZ,L203
L200:
        LD    A,120
L201:
        CALL  writeA
L202:
        ;;test5.j(41)   if (5 >= 12/(1+2)) write(119);
L203:
        LD    A,12
L204:
        PUSH  AF
        LD    A,1
L205:
        ADD   A,2
L206:
        LD    C,A
        POP   AF
        CALL  div8
L207:
        SUB   A,5
L208:
        JR    Z,$+5
        JP    C,L212
L209:
        LD    A,119
L210:
        CALL  writeA
L211:
        ;;test5.j(42)   if (4 >= 12/(1+2)) write(118);
L212:
        LD    A,12
L213:
        PUSH  AF
        LD    A,1
L214:
        ADD   A,2
L215:
        LD    C,A
        POP   AF
        CALL  div8
L216:
        SUB   A,4
L217:
        JR    Z,$+5
        JP    C,L221
L218:
        LD    A,118
L219:
        CALL  writeA
L220:
        ;;test5.j(43)   if (4 <= 12/(1+2)) write(117);
L221:
        LD    A,12
L222:
        PUSH  AF
        LD    A,1
L223:
        ADD   A,2
L224:
        LD    C,A
        POP   AF
        CALL  div8
L225:
        SUB   A,4
L226:
        JP    C,L230
L227:
        LD    A,117
L228:
        CALL  writeA
L229:
        ;;test5.j(44)   if (3 <= 12/(1+2)) write(116);
L230:
        LD    A,12
L231:
        PUSH  AF
        LD    A,1
L232:
        ADD   A,2
L233:
        LD    C,A
        POP   AF
        CALL  div8
L234:
        SUB   A,3
L235:
        JP    C,L239
L236:
        LD    A,116
L237:
        CALL  writeA
L238:
        ;;test5.j(45)   if (5 > 12/(1+2)) write(115);
L239:
        LD    A,12
L240:
        PUSH  AF
        LD    A,1
L241:
        ADD   A,2
L242:
        LD    C,A
        POP   AF
        CALL  div8
L243:
        SUB   A,5
L244:
        JP    NC,L248
L245:
        LD    A,115
L246:
        CALL  writeA
L247:
        ;;test5.j(46)   if (3 < 12/(1+2)) write(114);
L248:
        LD    A,12
L249:
        PUSH  AF
        LD    A,1
L250:
        ADD   A,2
L251:
        LD    C,A
        POP   AF
        CALL  div8
L252:
        SUB   A,3
L253:
        JP    Z,L257
L254:
        LD    A,114
L255:
        CALL  writeA
L256:
        ;;test5.j(47)   if (3 != 12/(1+2)) write(113);
L257:
        LD    A,12
L258:
        PUSH  AF
        LD    A,1
L259:
        ADD   A,2
L260:
        LD    C,A
        POP   AF
        CALL  div8
L261:
        SUB   A,3
L262:
        JP    Z,L266
L263:
        LD    A,113
L264:
        CALL  writeA
L265:
        ;;test5.j(48)   if (4 == 12/(1+2)) write(112);
L266:
        LD    A,12
L267:
        PUSH  AF
        LD    A,1
L268:
        ADD   A,2
L269:
        LD    C,A
        POP   AF
        CALL  div8
L270:
        SUB   A,4
L271:
        JP    NZ,L275
L272:
        LD    A,112
L273:
        CALL  writeA
L274:
        ;;test5.j(49)   if (1+4 >= twelve/(one+2)) write(111);
L275:
        LD    A,1
L276:
        ADD   A,4
L277:
        PUSH AF
L278:
        LD    HL,(0500BH)
L279:
        PUSH  HL
        LD    HL,(05003H)
L280:
        LD    DE,2
        ADD   HL,DE
L281:
        POP   DE
        EX    DE,HL
        CALL  div16
L282:
        POP  AF
L283:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L284:
        JP    C,L288
L285:
        LD    A,111
L286:
        CALL  writeA
L287:
        ;;test5.j(50)   if (1+3 >= twelve/(one+2)) write(110);
L288:
        LD    A,1
L289:
        ADD   A,3
L290:
        PUSH AF
L291:
        LD    HL,(0500BH)
L292:
        PUSH  HL
        LD    HL,(05003H)
L293:
        LD    DE,2
        ADD   HL,DE
L294:
        POP   DE
        EX    DE,HL
        CALL  div16
L295:
        POP  AF
L296:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L297:
        JP    C,L301
L298:
        LD    A,110
L299:
        CALL  writeA
L300:
        ;;test5.j(51)   if (1+3 <= twelve/(one+2)) write(109);
L301:
        LD    A,1
L302:
        ADD   A,3
L303:
        PUSH AF
L304:
        LD    HL,(0500BH)
L305:
        PUSH  HL
        LD    HL,(05003H)
L306:
        LD    DE,2
        ADD   HL,DE
L307:
        POP   DE
        EX    DE,HL
        CALL  div16
L308:
        POP  AF
L309:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L310:
        JR    Z,$+5
        JP    C,L314
L311:
        LD    A,109
L312:
        CALL  writeA
L313:
        ;;test5.j(52)   if (1+2 <= twelve/(one+2)) write(108);
L314:
        LD    A,1
L315:
        ADD   A,2
L316:
        PUSH AF
L317:
        LD    HL,(0500BH)
L318:
        PUSH  HL
        LD    HL,(05003H)
L319:
        LD    DE,2
        ADD   HL,DE
L320:
        POP   DE
        EX    DE,HL
        CALL  div16
L321:
        POP  AF
L322:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L323:
        JR    Z,$+5
        JP    C,L327
L324:
        LD    A,108
L325:
        CALL  writeA
L326:
        ;;test5.j(53)   if (1+4 > twelve/(one+2)) write(107);
L327:
        LD    A,1
L328:
        ADD   A,4
L329:
        PUSH AF
L330:
        LD    HL,(0500BH)
L331:
        PUSH  HL
        LD    HL,(05003H)
L332:
        LD    DE,2
        ADD   HL,DE
L333:
        POP   DE
        EX    DE,HL
        CALL  div16
L334:
        POP  AF
L335:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L336:
        JP    Z,L340
L337:
        LD    A,107
L338:
        CALL  writeA
L339:
        ;;test5.j(54)   if (1+2 < twelve/(one+2)) write(106);
L340:
        LD    A,1
L341:
        ADD   A,2
L342:
        PUSH AF
L343:
        LD    HL,(0500BH)
L344:
        PUSH  HL
        LD    HL,(05003H)
L345:
        LD    DE,2
        ADD   HL,DE
L346:
        POP   DE
        EX    DE,HL
        CALL  div16
L347:
        POP  AF
L348:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L349:
        JP    NC,L353
L350:
        LD    A,106
L351:
        CALL  writeA
L352:
        ;;test5.j(55)   if (1+2 != twelve/(one+2)) write(105);
L353:
        LD    A,1
L354:
        ADD   A,2
L355:
        PUSH AF
L356:
        LD    HL,(0500BH)
L357:
        PUSH  HL
        LD    HL,(05003H)
L358:
        LD    DE,2
        ADD   HL,DE
L359:
        POP   DE
        EX    DE,HL
        CALL  div16
L360:
        POP  AF
L361:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L362:
        JP    Z,L366
L363:
        LD    A,105
L364:
        CALL  writeA
L365:
        ;;test5.j(56)   if (1+3 == twelve/(one+2)) write(104);
L366:
        LD    A,1
L367:
        ADD   A,3
L368:
        PUSH AF
L369:
        LD    HL,(0500BH)
L370:
        PUSH  HL
        LD    HL,(05003H)
L371:
        LD    DE,2
        ADD   HL,DE
L372:
        POP   DE
        EX    DE,HL
        CALL  div16
L373:
        POP  AF
L374:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L375:
        JP    NZ,L379
L376:
        LD    A,104
L377:
        CALL  writeA
L378:
        ;;test5.j(57)   if (1+4 >= 12/(1+2)) write(103);
L379:
        LD    A,1
L380:
        ADD   A,4
L381:
        PUSH AF
L382:
        LD    A,12
L383:
        PUSH  AF
        LD    A,1
L384:
        ADD   A,2
L385:
        LD    C,A
        POP   AF
        CALL  div8
L386:
        POP   BC
        SUB   A,B
L387:
        JR    Z,$+5
        JP    C,L391
L388:
        LD    A,103
L389:
        CALL  writeA
L390:
        ;;test5.j(58)   if (1+3 >= 12/(1+2)) write(102);
L391:
        LD    A,1
L392:
        ADD   A,3
L393:
        PUSH AF
L394:
        LD    A,12
L395:
        PUSH  AF
        LD    A,1
L396:
        ADD   A,2
L397:
        LD    C,A
        POP   AF
        CALL  div8
L398:
        POP   BC
        SUB   A,B
L399:
        JR    Z,$+5
        JP    C,L403
L400:
        LD    A,102
L401:
        CALL  writeA
L402:
        ;;test5.j(59)   if (1+3 <= 12/(1+2)) write(101);
L403:
        LD    A,1
L404:
        ADD   A,3
L405:
        PUSH AF
L406:
        LD    A,12
L407:
        PUSH  AF
        LD    A,1
L408:
        ADD   A,2
L409:
        LD    C,A
        POP   AF
        CALL  div8
L410:
        POP   BC
        SUB   A,B
L411:
        JP    C,L415
L412:
        LD    A,101
L413:
        CALL  writeA
L414:
        ;;test5.j(60)   if (1+2 <= 12/(1+2)) write(100);
L415:
        LD    A,1
L416:
        ADD   A,2
L417:
        PUSH AF
L418:
        LD    A,12
L419:
        PUSH  AF
        LD    A,1
L420:
        ADD   A,2
L421:
        LD    C,A
        POP   AF
        CALL  div8
L422:
        POP   BC
        SUB   A,B
L423:
        JP    C,L427
L424:
        LD    A,100
L425:
        CALL  writeA
L426:
        ;;test5.j(61)   if (1+4 > 12/(1+2)) write(99);
L427:
        LD    A,1
L428:
        ADD   A,4
L429:
        PUSH AF
L430:
        LD    A,12
L431:
        PUSH  AF
        LD    A,1
L432:
        ADD   A,2
L433:
        LD    C,A
        POP   AF
        CALL  div8
L434:
        POP   BC
        SUB   A,B
L435:
        JP    NC,L439
L436:
        LD    A,99
L437:
        CALL  writeA
L438:
        ;;test5.j(62)   if (1+2 < 12/(1+2)) write(98);
L439:
        LD    A,1
L440:
        ADD   A,2
L441:
        PUSH AF
L442:
        LD    A,12
L443:
        PUSH  AF
        LD    A,1
L444:
        ADD   A,2
L445:
        LD    C,A
        POP   AF
        CALL  div8
L446:
        POP   BC
        SUB   A,B
L447:
        JP    Z,L451
L448:
        LD    A,98
L449:
        CALL  writeA
L450:
        ;;test5.j(63)   if (1+2 != 12/(1+2)) write(97);
L451:
        LD    A,1
L452:
        ADD   A,2
L453:
        PUSH AF
L454:
        LD    A,12
L455:
        PUSH  AF
        LD    A,1
L456:
        ADD   A,2
L457:
        LD    C,A
        POP   AF
        CALL  div8
L458:
        POP   BC
        SUB   A,B
L459:
        JP    Z,L463
L460:
        LD    A,97
L461:
        CALL  writeA
L462:
        ;;test5.j(64)   if (1+3 == 12/(1+2)) write(96);
L463:
        LD    A,1
L464:
        ADD   A,3
L465:
        PUSH AF
L466:
        LD    A,12
L467:
        PUSH  AF
        LD    A,1
L468:
        ADD   A,2
L469:
        LD    C,A
        POP   AF
        CALL  div8
L470:
        POP   BC
        SUB   A,B
L471:
        JP    NZ,L475
L472:
        LD    A,96
L473:
        CALL  writeA
L474:
        ;;test5.j(65)   if (twelve >= twelve/(one+2)) write(95);
L475:
        LD    HL,(0500BH)
L476:
        PUSH  HL
        LD    HL,(05003H)
L477:
        LD    DE,2
        ADD   HL,DE
L478:
        POP   DE
        EX    DE,HL
        CALL  div16
L479:
        LD    DE,(0500BH)
        OR    A
        SBC   HL,DE
L480:
        JR    Z,$+5
        JP    C,L484
L481:
        LD    A,95
L482:
        CALL  writeA
L483:
        ;;test5.j(66)   if (four >= twelve/(one+2)) write(94);
L484:
        LD    HL,(0500BH)
L485:
        PUSH  HL
        LD    HL,(05003H)
L486:
        LD    DE,2
        ADD   HL,DE
L487:
        POP   DE
        EX    DE,HL
        CALL  div16
L488:
        LD    DE,(05007H)
        OR    A
        SBC   HL,DE
L489:
        JR    Z,$+5
        JP    C,L493
L490:
        LD    A,94
L491:
        CALL  writeA
L492:
        ;;test5.j(67)   if (three <= twelve/(one+2)) write(93);
L493:
        LD    HL,(0500BH)
L494:
        PUSH  HL
        LD    HL,(05003H)
L495:
        LD    DE,2
        ADD   HL,DE
L496:
        POP   DE
        EX    DE,HL
        CALL  div16
L497:
        LD    DE,(05005H)
        OR    A
        SBC   HL,DE
L498:
        JP    C,L502
L499:
        LD    A,93
L500:
        CALL  writeA
L501:
        ;;test5.j(68)   if (four <= twelve/(one+2)) write(92);
L502:
        LD    HL,(0500BH)
L503:
        PUSH  HL
        LD    HL,(05003H)
L504:
        LD    DE,2
        ADD   HL,DE
L505:
        POP   DE
        EX    DE,HL
        CALL  div16
L506:
        LD    DE,(05007H)
        OR    A
        SBC   HL,DE
L507:
        JP    C,L511
L508:
        LD    A,92
L509:
        CALL  writeA
L510:
        ;;test5.j(69)   if (twelve > twelve/(one+2)) write(91);
L511:
        LD    HL,(0500BH)
L512:
        PUSH  HL
        LD    HL,(05003H)
L513:
        LD    DE,2
        ADD   HL,DE
L514:
        POP   DE
        EX    DE,HL
        CALL  div16
L515:
        LD    DE,(0500BH)
        OR    A
        SBC   HL,DE
L516:
        JP    NC,L520
L517:
        LD    A,91
L518:
        CALL  writeA
L519:
        ;;test5.j(70)   if (three < twelve/(one+2)) write(90);
L520:
        LD    HL,(0500BH)
L521:
        PUSH  HL
        LD    HL,(05003H)
L522:
        LD    DE,2
        ADD   HL,DE
L523:
        POP   DE
        EX    DE,HL
        CALL  div16
L524:
        LD    DE,(05005H)
        OR    A
        SBC   HL,DE
L525:
        JP    Z,L529
L526:
        LD    A,90
L527:
        CALL  writeA
L528:
        ;;test5.j(71)   if (three != twelve/(one+2)) write(89);
L529:
        LD    HL,(0500BH)
L530:
        PUSH  HL
        LD    HL,(05003H)
L531:
        LD    DE,2
        ADD   HL,DE
L532:
        POP   DE
        EX    DE,HL
        CALL  div16
L533:
        LD    DE,(05005H)
        OR    A
        SBC   HL,DE
L534:
        JP    Z,L538
L535:
        LD    A,89
L536:
        CALL  writeA
L537:
        ;;test5.j(72)   if (four == twelve/(one+2)) write(88);
L538:
        LD    HL,(0500BH)
L539:
        PUSH  HL
        LD    HL,(05003H)
L540:
        LD    DE,2
        ADD   HL,DE
L541:
        POP   DE
        EX    DE,HL
        CALL  div16
L542:
        LD    DE,(05007H)
        OR    A
        SBC   HL,DE
L543:
        JP    NZ,L547
L544:
        LD    A,88
L545:
        CALL  writeA
L546:
        ;;test5.j(73)   if (twelve >= 12/(1+2)) write(87);
L547:
        LD    A,12
L548:
        PUSH  AF
        LD    A,1
L549:
        ADD   A,2
L550:
        LD    C,A
        POP   AF
        CALL  div8
L551:
        LD    HL,(0500BH)
L552:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L553:
        JP    C,L557
L554:
        LD    A,87
L555:
        CALL  writeA
L556:
        ;;test5.j(74)   if (four >= 12/(1+2)) write(86);
L557:
        LD    A,12
L558:
        PUSH  AF
        LD    A,1
L559:
        ADD   A,2
L560:
        LD    C,A
        POP   AF
        CALL  div8
L561:
        LD    HL,(05007H)
L562:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L563:
        JP    C,L567
L564:
        LD    A,86
L565:
        CALL  writeA
L566:
        ;;test5.j(75)   if (three <= 12/(1+2)) write(85);
L567:
        LD    A,12
L568:
        PUSH  AF
        LD    A,1
L569:
        ADD   A,2
L570:
        LD    C,A
        POP   AF
        CALL  div8
L571:
        LD    HL,(05005H)
L572:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L573:
        JR    Z,$+5
        JP    C,L577
L574:
        LD    A,85
L575:
        CALL  writeA
L576:
        ;;test5.j(76)   if (four <= 12/(1+2)) write(84);
L577:
        LD    A,12
L578:
        PUSH  AF
        LD    A,1
L579:
        ADD   A,2
L580:
        LD    C,A
        POP   AF
        CALL  div8
L581:
        LD    HL,(05007H)
L582:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L583:
        JR    Z,$+5
        JP    C,L587
L584:
        LD    A,84
L585:
        CALL  writeA
L586:
        ;;test5.j(77)   if (twelve > 12/(1+2)) write(83);
L587:
        LD    A,12
L588:
        PUSH  AF
        LD    A,1
L589:
        ADD   A,2
L590:
        LD    C,A
        POP   AF
        CALL  div8
L591:
        LD    HL,(0500BH)
L592:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L593:
        JP    Z,L597
L594:
        LD    A,83
L595:
        CALL  writeA
L596:
        ;;test5.j(78)   if (three < 12/(1+2)) write(82);
L597:
        LD    A,12
L598:
        PUSH  AF
        LD    A,1
L599:
        ADD   A,2
L600:
        LD    C,A
        POP   AF
        CALL  div8
L601:
        LD    HL,(05005H)
L602:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L603:
        JP    NC,L607
L604:
        LD    A,82
L605:
        CALL  writeA
L606:
        ;;test5.j(79)   if (three != 12/(1+2)) write(81);
L607:
        LD    A,12
L608:
        PUSH  AF
        LD    A,1
L609:
        ADD   A,2
L610:
        LD    C,A
        POP   AF
        CALL  div8
L611:
        LD    HL,(05005H)
L612:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L613:
        JP    Z,L617
L614:
        LD    A,81
L615:
        CALL  writeA
L616:
        ;;test5.j(80)   if (four == 12/(1+2)) write(80);
L617:
        LD    A,12
L618:
        PUSH  AF
        LD    A,1
L619:
        ADD   A,2
L620:
        LD    C,A
        POP   AF
        CALL  div8
L621:
        LD    HL,(05007H)
L622:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L623:
        JP    NZ,L627
L624:
        LD    A,80
L625:
        CALL  writeA
L626:
        ;;test5.j(81)   if (one+four >= twelve/(one+2)) write(79);
L627:
        LD    HL,(05003H)
L628:
        LD    DE,(05007H)
        ADD   HL,DE
L629:
        PUSH HL
L630:
        LD    HL,(0500BH)
L631:
        PUSH  HL
        LD    HL,(05003H)
L632:
        LD    DE,2
        ADD   HL,DE
L633:
        POP   DE
        EX    DE,HL
        CALL  div16
L634:
        POP   DE
        OR    A
        SBC   HL,DE
L635:
        JR    Z,$+5
        JP    C,L639
L636:
        LD    A,79
L637:
        CALL  writeA
L638:
        ;;test5.j(82)   if (one+three >= twelve/(one+2)) write(78);
L639:
        LD    HL,(05003H)
L640:
        LD    DE,(05005H)
        ADD   HL,DE
L641:
        PUSH HL
L642:
        LD    HL,(0500BH)
L643:
        PUSH  HL
        LD    HL,(05003H)
L644:
        LD    DE,2
        ADD   HL,DE
L645:
        POP   DE
        EX    DE,HL
        CALL  div16
L646:
        POP   DE
        OR    A
        SBC   HL,DE
L647:
        JR    Z,$+5
        JP    C,L651
L648:
        LD    A,78
L649:
        CALL  writeA
L650:
        ;;test5.j(83)   if (one+three <= twelve/(one+2)) write(77);
L651:
        LD    HL,(05003H)
L652:
        LD    DE,(05005H)
        ADD   HL,DE
L653:
        PUSH HL
L654:
        LD    HL,(0500BH)
L655:
        PUSH  HL
        LD    HL,(05003H)
L656:
        LD    DE,2
        ADD   HL,DE
L657:
        POP   DE
        EX    DE,HL
        CALL  div16
L658:
        POP   DE
        OR    A
        SBC   HL,DE
L659:
        JP    C,L663
L660:
        LD    A,77
L661:
        CALL  writeA
L662:
        ;;test5.j(84)   if (one+one <= twelve/(one+2)) write(76);
L663:
        LD    HL,(05003H)
L664:
        LD    DE,(05003H)
        ADD   HL,DE
L665:
        PUSH HL
L666:
        LD    HL,(0500BH)
L667:
        PUSH  HL
        LD    HL,(05003H)
L668:
        LD    DE,2
        ADD   HL,DE
L669:
        POP   DE
        EX    DE,HL
        CALL  div16
L670:
        POP   DE
        OR    A
        SBC   HL,DE
L671:
        JP    C,L675
L672:
        LD    A,76
L673:
        CALL  writeA
L674:
        ;;test5.j(85)   if (one+four > twelve/(one+2)) write(75);
L675:
        LD    HL,(05003H)
L676:
        LD    DE,(05007H)
        ADD   HL,DE
L677:
        PUSH HL
L678:
        LD    HL,(0500BH)
L679:
        PUSH  HL
        LD    HL,(05003H)
L680:
        LD    DE,2
        ADD   HL,DE
L681:
        POP   DE
        EX    DE,HL
        CALL  div16
L682:
        POP   DE
        OR    A
        SBC   HL,DE
L683:
        JP    NC,L687
L684:
        LD    A,75
L685:
        CALL  writeA
L686:
        ;;test5.j(86)   if (one+one < twelve/(one+2)) write(74);
L687:
        LD    HL,(05003H)
L688:
        LD    DE,(05003H)
        ADD   HL,DE
L689:
        PUSH HL
L690:
        LD    HL,(0500BH)
L691:
        PUSH  HL
        LD    HL,(05003H)
L692:
        LD    DE,2
        ADD   HL,DE
L693:
        POP   DE
        EX    DE,HL
        CALL  div16
L694:
        POP   DE
        OR    A
        SBC   HL,DE
L695:
        JP    Z,L699
L696:
        LD    A,74
L697:
        CALL  writeA
L698:
        ;;test5.j(87)   if (one+four  != twelve/(one+2)) write(73);
L699:
        LD    HL,(05003H)
L700:
        LD    DE,(05007H)
        ADD   HL,DE
L701:
        PUSH HL
L702:
        LD    HL,(0500BH)
L703:
        PUSH  HL
        LD    HL,(05003H)
L704:
        LD    DE,2
        ADD   HL,DE
L705:
        POP   DE
        EX    DE,HL
        CALL  div16
L706:
        POP   DE
        OR    A
        SBC   HL,DE
L707:
        JP    Z,L711
L708:
        LD    A,73
L709:
        CALL  writeA
L710:
        ;;test5.j(88)   if (one+three == twelve/(one+2)) write(72);
L711:
        LD    HL,(05003H)
L712:
        LD    DE,(05005H)
        ADD   HL,DE
L713:
        PUSH HL
L714:
        LD    HL,(0500BH)
L715:
        PUSH  HL
        LD    HL,(05003H)
L716:
        LD    DE,2
        ADD   HL,DE
L717:
        POP   DE
        EX    DE,HL
        CALL  div16
L718:
        POP   DE
        OR    A
        SBC   HL,DE
L719:
        JP    NZ,L723
L720:
        LD    A,72
L721:
        CALL  writeA
L722:
        ;;test5.j(89)   if (one+four >= 12/(1+2)) write(71);
L723:
        LD    HL,(05003H)
L724:
        LD    DE,(05007H)
        ADD   HL,DE
L725:
        PUSH HL
L726:
        LD    A,12
L727:
        PUSH  AF
        LD    A,1
L728:
        ADD   A,2
L729:
        LD    C,A
        POP   AF
        CALL  div8
L730:
        POP  HL
L731:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L732:
        JP    C,L736
L733:
        LD    A,71
L734:
        CALL  writeA
L735:
        ;;test5.j(90)   if (one+three >= 12/(1+2)) write(70);
L736:
        LD    HL,(05003H)
L737:
        LD    DE,(05005H)
        ADD   HL,DE
L738:
        PUSH HL
L739:
        LD    A,12
L740:
        PUSH  AF
        LD    A,1
L741:
        ADD   A,2
L742:
        LD    C,A
        POP   AF
        CALL  div8
L743:
        POP  HL
L744:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L745:
        JP    C,L749
L746:
        LD    A,70
L747:
        CALL  writeA
L748:
        ;;test5.j(91)   if (one+three <= 12/(1+2)) write(69);
L749:
        LD    HL,(05003H)
L750:
        LD    DE,(05005H)
        ADD   HL,DE
L751:
        PUSH HL
L752:
        LD    A,12
L753:
        PUSH  AF
        LD    A,1
L754:
        ADD   A,2
L755:
        LD    C,A
        POP   AF
        CALL  div8
L756:
        POP  HL
L757:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L758:
        JR    Z,$+5
        JP    C,L762
L759:
        LD    A,69
L760:
        CALL  writeA
L761:
        ;;test5.j(92)   if (one+one <= 12/(1+2)) write(68);
L762:
        LD    HL,(05003H)
L763:
        LD    DE,(05003H)
        ADD   HL,DE
L764:
        PUSH HL
L765:
        LD    A,12
L766:
        PUSH  AF
        LD    A,1
L767:
        ADD   A,2
L768:
        LD    C,A
        POP   AF
        CALL  div8
L769:
        POP  HL
L770:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L771:
        JR    Z,$+5
        JP    C,L775
L772:
        LD    A,68
L773:
        CALL  writeA
L774:
        ;;test5.j(93)   if (one+four > 12/(1+2)) write(67);
L775:
        LD    HL,(05003H)
L776:
        LD    DE,(05007H)
        ADD   HL,DE
L777:
        PUSH HL
L778:
        LD    A,12
L779:
        PUSH  AF
        LD    A,1
L780:
        ADD   A,2
L781:
        LD    C,A
        POP   AF
        CALL  div8
L782:
        POP  HL
L783:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L784:
        JP    Z,L788
L785:
        LD    A,67
L786:
        CALL  writeA
L787:
        ;;test5.j(94)   if (one+one < 12/(1+2)) write(66);
L788:
        LD    HL,(05003H)
L789:
        LD    DE,(05003H)
        ADD   HL,DE
L790:
        PUSH HL
L791:
        LD    A,12
L792:
        PUSH  AF
        LD    A,1
L793:
        ADD   A,2
L794:
        LD    C,A
        POP   AF
        CALL  div8
L795:
        POP  HL
L796:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L797:
        JP    NC,L801
L798:
        LD    A,66
L799:
        CALL  writeA
L800:
        ;;test5.j(95)   if (one+four  != 12/(1+2)) write(65);
L801:
        LD    HL,(05003H)
L802:
        LD    DE,(05007H)
        ADD   HL,DE
L803:
        PUSH HL
L804:
        LD    A,12
L805:
        PUSH  AF
        LD    A,1
L806:
        ADD   A,2
L807:
        LD    C,A
        POP   AF
        CALL  div8
L808:
        POP  HL
L809:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L810:
        JP    Z,L814
L811:
        LD    A,65
L812:
        CALL  writeA
L813:
        ;;test5.j(96)   if (one+three == 12/(1+2)) write(64);
L814:
        LD    HL,(05003H)
L815:
        LD    DE,(05005H)
        ADD   HL,DE
L816:
        PUSH HL
L817:
        LD    A,12
L818:
        PUSH  AF
        LD    A,1
L819:
        ADD   A,2
L820:
        LD    C,A
        POP   AF
        CALL  div8
L821:
        POP  HL
L822:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L823:
        JP    NZ,L829
L824:
        LD    A,64
L825:
        CALL  writeA
L826:
        ;;test5.j(97)   //stack level 1
L827:
        ;;test5.j(98)   //integer-byte
L828:
        ;;test5.j(99)   if (four >= 4) write(63);
L829:
        LD    HL,(05007H)
L830:
        LD    A,4
L831:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L832:
        JP    C,L836
L833:
        LD    A,63
L834:
        CALL  writeA
L835:
        ;;test5.j(100)   if (four >= 12/(1+2)) write(62);
L836:
        LD    A,12
L837:
        PUSH  AF
        LD    A,1
L838:
        ADD   A,2
L839:
        LD    C,A
        POP   AF
        CALL  div8
L840:
        LD    HL,(05007H)
L841:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L842:
        JP    C,L846
L843:
        LD    A,62
L844:
        CALL  writeA
L845:
        ;;test5.j(101)   if (five >= 4) write(61);
L846:
        LD    HL,(05009H)
L847:
        LD    A,4
L848:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L849:
        JP    C,L853
L850:
        LD    A,61
L851:
        CALL  writeA
L852:
        ;;test5.j(102)   if (five >= 12/(1+2)) write(60);
L853:
        LD    A,12
L854:
        PUSH  AF
        LD    A,1
L855:
        ADD   A,2
L856:
        LD    C,A
        POP   AF
        CALL  div8
L857:
        LD    HL,(05009H)
L858:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L859:
        JP    C,L863
L860:
        LD    A,60
L861:
        CALL  writeA
L862:
        ;;test5.j(103)   if (four <= 4) write(59);
L863:
        LD    HL,(05007H)
L864:
        LD    A,4
L865:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L866:
        JR    Z,$+5
        JP    C,L870
L867:
        LD    A,59
L868:
        CALL  writeA
L869:
        ;;test5.j(104)   if (four <= 12/(1+2)) write(58);
L870:
        LD    A,12
L871:
        PUSH  AF
        LD    A,1
L872:
        ADD   A,2
L873:
        LD    C,A
        POP   AF
        CALL  div8
L874:
        LD    HL,(05007H)
L875:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L876:
        JR    Z,$+5
        JP    C,L880
L877:
        LD    A,58
L878:
        CALL  writeA
L879:
        ;;test5.j(105)   if (three <= 4) write(57);
L880:
        LD    HL,(05005H)
L881:
        LD    A,4
L882:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L883:
        JR    Z,$+5
        JP    C,L887
L884:
        LD    A,57
L885:
        CALL  writeA
L886:
        ;;test5.j(106)   if (three <= 12/(1+2)) write(56);
L887:
        LD    A,12
L888:
        PUSH  AF
        LD    A,1
L889:
        ADD   A,2
L890:
        LD    C,A
        POP   AF
        CALL  div8
L891:
        LD    HL,(05005H)
L892:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L893:
        JR    Z,$+5
        JP    C,L897
L894:
        LD    A,56
L895:
        CALL  writeA
L896:
        ;;test5.j(107)   if (five > 4) write(55);
L897:
        LD    HL,(05009H)
L898:
        LD    A,4
L899:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L900:
        JP    Z,L904
L901:
        LD    A,55
L902:
        CALL  writeA
L903:
        ;;test5.j(108)   if (five > 12/(1+2)) write(54);
L904:
        LD    A,12
L905:
        PUSH  AF
        LD    A,1
L906:
        ADD   A,2
L907:
        LD    C,A
        POP   AF
        CALL  div8
L908:
        LD    HL,(05009H)
L909:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L910:
        JP    Z,L914
L911:
        LD    A,54
L912:
        CALL  writeA
L913:
        ;;test5.j(109)   if (three < 4) write(53);
L914:
        LD    HL,(05005H)
L915:
        LD    A,4
L916:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L917:
        JP    NC,L921
L918:
        LD    A,53
L919:
        CALL  writeA
L920:
        ;;test5.j(110)   if (three < 12/(1+2)) write(52);
L921:
        LD    A,12
L922:
        PUSH  AF
        LD    A,1
L923:
        ADD   A,2
L924:
        LD    C,A
        POP   AF
        CALL  div8
L925:
        LD    HL,(05005H)
L926:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L927:
        JP    NC,L931
L928:
        LD    A,52
L929:
        CALL  writeA
L930:
        ;;test5.j(111)   if (three != 4) write(51);
L931:
        LD    HL,(05005H)
L932:
        LD    A,4
L933:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L934:
        JP    Z,L938
L935:
        LD    A,51
L936:
        CALL  writeA
L937:
        ;;test5.j(112)   if (three != 12/(1+2)) write(50);
L938:
        LD    A,12
L939:
        PUSH  AF
        LD    A,1
L940:
        ADD   A,2
L941:
        LD    C,A
        POP   AF
        CALL  div8
L942:
        LD    HL,(05005H)
L943:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L944:
        JP    Z,L948
L945:
        LD    A,50
L946:
        CALL  writeA
L947:
        ;;test5.j(113)   if (four == 4) write(49);
L948:
        LD    HL,(05007H)
L949:
        LD    A,4
L950:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L951:
        JP    NZ,L955
L952:
        LD    A,49
L953:
        CALL  writeA
L954:
        ;;test5.j(114)   if (four == 12/(1+2)) write(48);
L955:
        LD    A,12
L956:
        PUSH  AF
        LD    A,1
L957:
        ADD   A,2
L958:
        LD    C,A
        POP   AF
        CALL  div8
L959:
        LD    HL,(05007H)
L960:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L961:
        JP    NZ,L966
L962:
        LD    A,48
L963:
        CALL  writeA
L964:
        ;;test5.j(115)   //byte-integer
L965:
        ;;test5.j(116)   if (4 >= four) write(47);
L966:
        LD    HL,(05007H)
L967:
        LD    A,4
L968:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L969:
        JP    C,L973
L970:
        LD    A,47
L971:
        CALL  writeA
L972:
        ;;test5.j(117)   if (4 >= twelve/(1+2)) write(46);
L973:
        LD    HL,(0500BH)
L974:
        LD    A,1
L975:
        ADD   A,2
L976:
        CALL  div16_8
L977:
        LD    A,4
L978:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L979:
        JP    C,L983
L980:
        LD    A,46
L981:
        CALL  writeA
L982:
        ;;test5.j(118)   if (5 >= four) write(45);
L983:
        LD    HL,(05007H)
L984:
        LD    A,5
L985:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L986:
        JP    C,L990
L987:
        LD    A,45
L988:
        CALL  writeA
L989:
        ;;test5.j(119)   if (5 >= twelve/(1+2)) write(44);
L990:
        LD    HL,(0500BH)
L991:
        LD    A,1
L992:
        ADD   A,2
L993:
        CALL  div16_8
L994:
        LD    A,5
L995:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L996:
        JP    C,L1000
L997:
        LD    A,44
L998:
        CALL  writeA
L999:
        ;;test5.j(120)   if (4 <= four) write(43);
L1000:
        LD    HL,(05007H)
L1001:
        LD    A,4
L1002:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1003:
        JR    Z,$+5
        JP    C,L1007
L1004:
        LD    A,43
L1005:
        CALL  writeA
L1006:
        ;;test5.j(121)   if (4 <= twelve/(1+2)) write(42);
L1007:
        LD    HL,(0500BH)
L1008:
        LD    A,1
L1009:
        ADD   A,2
L1010:
        CALL  div16_8
L1011:
        LD    A,4
L1012:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1013:
        JR    Z,$+5
        JP    C,L1017
L1014:
        LD    A,42
L1015:
        CALL  writeA
L1016:
        ;;test5.j(122)   if (3 <= four) write(41);
L1017:
        LD    HL,(05007H)
L1018:
        LD    A,3
L1019:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1020:
        JR    Z,$+5
        JP    C,L1024
L1021:
        LD    A,41
L1022:
        CALL  writeA
L1023:
        ;;test5.j(123)   if (3 <= twelve/(1+2)) write(40);
L1024:
        LD    HL,(0500BH)
L1025:
        LD    A,1
L1026:
        ADD   A,2
L1027:
        CALL  div16_8
L1028:
        LD    A,3
L1029:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1030:
        JR    Z,$+5
        JP    C,L1034
L1031:
        LD    A,40
L1032:
        CALL  writeA
L1033:
        ;;test5.j(124)   if (5 > four) write(39);
L1034:
        LD    HL,(05007H)
L1035:
        LD    A,5
L1036:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1037:
        JP    Z,L1041
L1038:
        LD    A,39
L1039:
        CALL  writeA
L1040:
        ;;test5.j(125)   if (5 > twelve/(1+2)) write(38);
L1041:
        LD    HL,(0500BH)
L1042:
        LD    A,1
L1043:
        ADD   A,2
L1044:
        CALL  div16_8
L1045:
        LD    A,5
L1046:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1047:
        JP    Z,L1051
L1048:
        LD    A,38
L1049:
        CALL  writeA
L1050:
        ;;test5.j(126)   if (3 < four) write(37);
L1051:
        LD    HL,(05007H)
L1052:
        LD    A,3
L1053:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1054:
        JP    NC,L1058
L1055:
        LD    A,37
L1056:
        CALL  writeA
L1057:
        ;;test5.j(127)   if (3 < twelve/(1+2)) write(36);
L1058:
        LD    HL,(0500BH)
L1059:
        LD    A,1
L1060:
        ADD   A,2
L1061:
        CALL  div16_8
L1062:
        LD    A,3
L1063:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1064:
        JP    NC,L1068
L1065:
        LD    A,36
L1066:
        CALL  writeA
L1067:
        ;;test5.j(128)   if (3 != four) write(35);
L1068:
        LD    HL,(05007H)
L1069:
        LD    A,3
L1070:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1071:
        JP    Z,L1075
L1072:
        LD    A,35
L1073:
        CALL  writeA
L1074:
        ;;test5.j(129)   if (3 != twelve/(1+2)) write(34);
L1075:
        LD    HL,(0500BH)
L1076:
        LD    A,1
L1077:
        ADD   A,2
L1078:
        CALL  div16_8
L1079:
        LD    A,3
L1080:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1081:
        JP    Z,L1085
L1082:
        LD    A,34
L1083:
        CALL  writeA
L1084:
        ;;test5.j(130)   if (4 == four) write(33);
L1085:
        LD    HL,(05007H)
L1086:
        LD    A,4
L1087:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1088:
        JP    NZ,L1092
L1089:
        LD    A,33
L1090:
        CALL  writeA
L1091:
        ;;test5.j(131)   if (4 == twelve/(1+2)) write(32);
L1092:
        LD    HL,(0500BH)
L1093:
        LD    A,1
L1094:
        ADD   A,2
L1095:
        CALL  div16_8
L1096:
        LD    A,4
L1097:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1098:
        JP    NZ,L1103
L1099:
        LD    A,32
L1100:
        CALL  writeA
L1101:
        ;;test5.j(132)   //integer-integer
L1102:
        ;;test5.j(133)   if (400 >= 400) write(31);
L1103:
        LD    HL,400
L1104:
        LD    DE,400
        OR    A
        SBC   HL,DE
L1105:
        JP    C,L1109
L1106:
        LD    A,31
L1107:
        CALL  writeA
L1108:
        ;;test5.j(134)   if (400 >= 1200/(1+2)) write(30);
L1109:
        LD    HL,1200
L1110:
        LD    A,1
L1111:
        ADD   A,2
L1112:
        CALL  div16_8
L1113:
        LD    DE,400
        OR    A
        SBC   HL,DE
L1114:
        JR    Z,$+5
        JP    C,L1118
L1115:
        LD    A,30
L1116:
        CALL  writeA
L1117:
        ;;test5.j(135)   if (500 >= 400) write(29);
L1118:
        LD    HL,500
L1119:
        LD    DE,400
        OR    A
        SBC   HL,DE
L1120:
        JP    C,L1124
L1121:
        LD    A,29
L1122:
        CALL  writeA
L1123:
        ;;test5.j(136)   if (500 >= 1200/(1+2)) write(28);
L1124:
        LD    HL,1200
L1125:
        LD    A,1
L1126:
        ADD   A,2
L1127:
        CALL  div16_8
L1128:
        LD    DE,500
        OR    A
        SBC   HL,DE
L1129:
        JR    Z,$+5
        JP    C,L1133
L1130:
        LD    A,28
L1131:
        CALL  writeA
L1132:
        ;;test5.j(137)   if (400 <= 400) write(27);
L1133:
        LD    HL,400
L1134:
        LD    DE,400
        OR    A
        SBC   HL,DE
L1135:
        JR    Z,$+5
        JP    C,L1139
L1136:
        LD    A,27
L1137:
        CALL  writeA
L1138:
        ;;test5.j(138)   if (400 <= 1200/(1+2)) write(26);
L1139:
        LD    HL,1200
L1140:
        LD    A,1
L1141:
        ADD   A,2
L1142:
        CALL  div16_8
L1143:
        LD    DE,400
        OR    A
        SBC   HL,DE
L1144:
        JP    C,L1148
L1145:
        LD    A,26
L1146:
        CALL  writeA
L1147:
        ;;test5.j(139)   if (300 <= 400) write(25);
L1148:
        LD    HL,300
L1149:
        LD    DE,400
        OR    A
        SBC   HL,DE
L1150:
        JR    Z,$+5
        JP    C,L1154
L1151:
        LD    A,25
L1152:
        CALL  writeA
L1153:
        ;;test5.j(140)   if (300 <= 1200/(1+2)) write(24);
L1154:
        LD    HL,1200
L1155:
        LD    A,1
L1156:
        ADD   A,2
L1157:
        CALL  div16_8
L1158:
        LD    DE,300
        OR    A
        SBC   HL,DE
L1159:
        JP    C,L1163
L1160:
        LD    A,24
L1161:
        CALL  writeA
L1162:
        ;;test5.j(141)   if (500 > 400) write(23);
L1163:
        LD    HL,500
L1164:
        LD    DE,400
        OR    A
        SBC   HL,DE
L1165:
        JP    Z,L1169
L1166:
        LD    A,23
L1167:
        CALL  writeA
L1168:
        ;;test5.j(142)   if (500 > 1200/(1+2)) write(22);
L1169:
        LD    HL,1200
L1170:
        LD    A,1
L1171:
        ADD   A,2
L1172:
        CALL  div16_8
L1173:
        LD    DE,500
        OR    A
        SBC   HL,DE
L1174:
        JP    NC,L1178
L1175:
        LD    A,22
L1176:
        CALL  writeA
L1177:
        ;;test5.j(143)   if (300 < 400) write(21);
L1178:
        LD    HL,300
L1179:
        LD    DE,400
        OR    A
        SBC   HL,DE
L1180:
        JP    NC,L1184
L1181:
        LD    A,21
L1182:
        CALL  writeA
L1183:
        ;;test5.j(144)   if (300 < 1200/(1+2)) write(20);
L1184:
        LD    HL,1200
L1185:
        LD    A,1
L1186:
        ADD   A,2
L1187:
        CALL  div16_8
L1188:
        LD    DE,300
        OR    A
        SBC   HL,DE
L1189:
        JP    Z,L1193
L1190:
        LD    A,20
L1191:
        CALL  writeA
L1192:
        ;;test5.j(145)   if (300 != 400) write(19);
L1193:
        LD    HL,300
L1194:
        LD    DE,400
        OR    A
        SBC   HL,DE
L1195:
        JP    Z,L1199
L1196:
        LD    A,19
L1197:
        CALL  writeA
L1198:
        ;;test5.j(146)   if (300 != 1200/(1+2)) write(18);
L1199:
        LD    HL,1200
L1200:
        LD    A,1
L1201:
        ADD   A,2
L1202:
        CALL  div16_8
L1203:
        LD    DE,300
        OR    A
        SBC   HL,DE
L1204:
        JP    Z,L1208
L1205:
        LD    A,18
L1206:
        CALL  writeA
L1207:
        ;;test5.j(147)   if (400 == 400) write(17);
L1208:
        LD    HL,400
L1209:
        LD    DE,400
        OR    A
        SBC   HL,DE
L1210:
        JP    NZ,L1214
L1211:
        LD    A,17
L1212:
        CALL  writeA
L1213:
        ;;test5.j(148)   if (400 == 1200/(1+2)) write(16);
L1214:
        LD    HL,1200
L1215:
        LD    A,1
L1216:
        ADD   A,2
L1217:
        CALL  div16_8
L1218:
        LD    DE,400
        OR    A
        SBC   HL,DE
L1219:
        JP    NZ,L1224
L1220:
        LD    A,16
L1221:
        CALL  writeA
L1222:
        ;;test5.j(149)   //byte-byte
L1223:
        ;;test5.j(150)   if (4 >= 4) write(15);
L1224:
        LD    A,4
L1225:
        SUB   A,4
L1226:
        JP    C,L1230
L1227:
        LD    A,15
L1228:
        CALL  writeA
L1229:
        ;;test5.j(151)   if (4 >= 12/(1+2)) write(14);
L1230:
        LD    A,12
L1231:
        PUSH  AF
        LD    A,1
L1232:
        ADD   A,2
L1233:
        LD    C,A
        POP   AF
        CALL  div8
L1234:
        SUB   A,4
L1235:
        JR    Z,$+5
        JP    C,L1239
L1236:
        LD    A,14
L1237:
        CALL  writeA
L1238:
        ;;test5.j(152)   if (5 >= 4) write(13);
L1239:
        LD    A,5
L1240:
        SUB   A,4
L1241:
        JP    C,L1245
L1242:
        LD    A,13
L1243:
        CALL  writeA
L1244:
        ;;test5.j(153)   if (5 >= 12/(1+2)) write(12);
L1245:
        LD    A,12
L1246:
        PUSH  AF
        LD    A,1
L1247:
        ADD   A,2
L1248:
        LD    C,A
        POP   AF
        CALL  div8
L1249:
        SUB   A,5
L1250:
        JR    Z,$+5
        JP    C,L1254
L1251:
        LD    A,12
L1252:
        CALL  writeA
L1253:
        ;;test5.j(154)   if (4 <= 4) write(11);
L1254:
        LD    A,4
L1255:
        SUB   A,4
L1256:
        JR    Z,$+5
        JP    C,L1260
L1257:
        LD    A,11
L1258:
        CALL  writeA
L1259:
        ;;test5.j(155)   if (4 <= 12/(1+2)) write(10);
L1260:
        LD    A,12
L1261:
        PUSH  AF
        LD    A,1
L1262:
        ADD   A,2
L1263:
        LD    C,A
        POP   AF
        CALL  div8
L1264:
        SUB   A,4
L1265:
        JP    C,L1269
L1266:
        LD    A,10
L1267:
        CALL  writeA
L1268:
        ;;test5.j(156)   if (3 <= 4) write(9);
L1269:
        LD    A,3
L1270:
        SUB   A,4
L1271:
        JR    Z,$+5
        JP    C,L1275
L1272:
        LD    A,9
L1273:
        CALL  writeA
L1274:
        ;;test5.j(157)   if (3 <= 12/(1+2)) write(8);
L1275:
        LD    A,12
L1276:
        PUSH  AF
        LD    A,1
L1277:
        ADD   A,2
L1278:
        LD    C,A
        POP   AF
        CALL  div8
L1279:
        SUB   A,3
L1280:
        JP    C,L1284
L1281:
        LD    A,8
L1282:
        CALL  writeA
L1283:
        ;;test5.j(158)   if (5 > 4) write(7);
L1284:
        LD    A,5
L1285:
        SUB   A,4
L1286:
        JP    Z,L1290
L1287:
        LD    A,7
L1288:
        CALL  writeA
L1289:
        ;;test5.j(159)   if (5 > 12/(1+2)) write(6);
L1290:
        LD    A,12
L1291:
        PUSH  AF
        LD    A,1
L1292:
        ADD   A,2
L1293:
        LD    C,A
        POP   AF
        CALL  div8
L1294:
        SUB   A,5
L1295:
        JP    NC,L1299
L1296:
        LD    A,6
L1297:
        CALL  writeA
L1298:
        ;;test5.j(160)   if (3 < 4) write(5);
L1299:
        LD    A,3
L1300:
        SUB   A,4
L1301:
        JP    NC,L1305
L1302:
        LD    A,5
L1303:
        CALL  writeA
L1304:
        ;;test5.j(161)   if (3 < 12/(1+2)) write(4);
L1305:
        LD    A,12
L1306:
        PUSH  AF
        LD    A,1
L1307:
        ADD   A,2
L1308:
        LD    C,A
        POP   AF
        CALL  div8
L1309:
        SUB   A,3
L1310:
        JP    Z,L1314
L1311:
        LD    A,4
L1312:
        CALL  writeA
L1313:
        ;;test5.j(162)   if (3 != 4) write(3);
L1314:
        LD    A,3
L1315:
        SUB   A,4
L1316:
        JP    Z,L1320
L1317:
        LD    A,3
L1318:
        CALL  writeA
L1319:
        ;;test5.j(163)   if (3 != 12/(1+2)) write(2);
L1320:
        LD    A,12
L1321:
        PUSH  AF
        LD    A,1
L1322:
        ADD   A,2
L1323:
        LD    C,A
        POP   AF
        CALL  div8
L1324:
        SUB   A,3
L1325:
        JP    Z,L1329
L1326:
        LD    A,2
L1327:
        CALL  writeA
L1328:
        ;;test5.j(164)   if (4 == 4) write(1);
L1329:
        LD    A,4
L1330:
        SUB   A,4
L1331:
        JP    NZ,L1335
L1332:
        LD    A,1
L1333:
        CALL  writeA
L1334:
        ;;test5.j(165)   if (4 == 12/(1+2)) write(0);
L1335:
        LD    A,12
L1336:
        PUSH  AF
        LD    A,1
L1337:
        ADD   A,2
L1338:
        LD    C,A
        POP   AF
        CALL  div8
L1339:
        SUB   A,4
L1340:
        JP    NZ,L1344
L1341:
        LD    A,0
L1342:
        CALL  writeA
L1343:
        ;;test5.j(166) }
L1344:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
