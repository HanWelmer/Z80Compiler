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
        ;;test11.j(0) /* Program to test generated Z80 assembler code */
L1:
        ;;test11.j(1) class TestFor {
L2:
        ;;test11.j(2)   byte b1 = 1;
L3:
        ;acc8= constant 1
        LD    A,1
L4:
        ;acc8=> variable 0
        LD    (05000H),A
L5:
        ;;test11.j(3)   byte b2 = 1;
L6:
        ;acc8= constant 1
        LD    A,1
L7:
        ;acc8=> variable 1
        LD    (05001H),A
L8:
        ;;test11.j(4)   word i2 = 1;
L9:
        ;acc8= constant 1
        LD    A,1
L10:
        ;acc8=> variable 2
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L11:
        ;;test11.j(5)   word p = 1;
L12:
        ;acc8= constant 1
        LD    A,1
L13:
        ;acc8=> variable 4
        LD    L,A
        LD    H,0
        LD    (05004H),HL
L14:
        ;;test11.j(6) 
L15:
        ;;test11.j(7)   write(0);
L16:
        ;acc8= constant 0
        LD    A,0
L17:
        ;call writeAcc8
        CALL  writeA
L18:
        ;;test11.j(8) 
L19:
        ;;test11.j(9)   /************************/
L20:
        ;;test11.j(10)   // global variable within for scope
L21:
        ;;test11.j(11)   for (byte b = 1; b <= 2; b++) {
L22:
        ;acc8= constant 1
        LD    A,1
L23:
        ;acc8=> variable 6
        LD    (05006H),A
L24:
        ;acc8= variable 6
        LD    A,(05006H)
L25:
        ;acc8Comp constant 2
        SUB   A,2
L26:
        ;brgt 49
        JR    Z,$+5
        JP    C,L49
L27:
        ;br 30
        JP    L30
L28:
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
L29:
        ;br 24
        JP    L24
L30:
        ;;test11.j(12)     byte c = b1;
L31:
        ;acc8= variable 0
        LD    A,(05000H)
L32:
        ;acc8=> variable 7
        LD    (05007H),A
L33:
        ;;test11.j(13)     write (c);
L34:
        ;acc8= variable 7
        LD    A,(05007H)
L35:
        ;call writeAcc8
        CALL  writeA
L36:
        ;;test11.j(14)     b1++;
L37:
        ;incr8 variable 0
        LD    HL,(05000H)
        INC   (HL)
L38:
        ;;test11.j(15)   }
L39:
        ;br 28
        JP    L28
L40:
        ;;test11.j(16) 
L41:
        ;;test11.j(17)   /************************/
L42:
        ;;test11.j(18)   // constant - constant
L43:
        ;;test11.j(19)   // not relevant
L44:
        ;;test11.j(20) 
L45:
        ;;test11.j(21)   /************************/
L46:
        ;;test11.j(22)   // constant - acc
L47:
        ;;test11.j(23)   // byte - byte
L48:
        ;;test11.j(24)   for (byte b = 3; 103 == b+100; b++) { write (b); }
L49:
        ;acc8= constant 3
        LD    A,3
L50:
        ;acc8=> variable 6
        LD    (05006H),A
L51:
        ;acc8= variable 6
        LD    A,(05006H)
L52:
        ;acc8+ constant 100
        ADD   A,100
L53:
        ;acc8Comp constant 103
        SUB   A,103
L54:
        ;brne 62
        JP    NZ,L62
L55:
        ;br 58
        JP    L58
L56:
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
L57:
        ;br 51
        JP    L51
L58:
        ;acc8= variable 6
        LD    A,(05006H)
L59:
        ;call writeAcc8
        CALL  writeA
L60:
        ;br 56
        JP    L56
L61:
        ;;test11.j(25)   for (byte b = 4; 105 != b+100; b++) { write (b); }
L62:
        ;acc8= constant 4
        LD    A,4
L63:
        ;acc8=> variable 6
        LD    (05006H),A
L64:
        ;acc8= variable 6
        LD    A,(05006H)
L65:
        ;acc8+ constant 100
        ADD   A,100
L66:
        ;acc8Comp constant 105
        SUB   A,105
L67:
        ;breq 75
        JP    Z,L75
L68:
        ;br 71
        JP    L71
L69:
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
L70:
        ;br 64
        JP    L64
L71:
        ;acc8= variable 6
        LD    A,(05006H)
L72:
        ;call writeAcc8
        CALL  writeA
L73:
        ;br 69
        JP    L69
L74:
        ;;test11.j(26)   b2=5;
L75:
        ;acc8= constant 5
        LD    A,5
L76:
        ;acc8=> variable 1
        LD    (05001H),A
L77:
        ;;test11.j(27)   for (byte b = 32; 134 > b+100; b++) { write (b2); b2++; }
L78:
        ;acc8= constant 32
        LD    A,32
L79:
        ;acc8=> variable 6
        LD    (05006H),A
L80:
        ;acc8= variable 6
        LD    A,(05006H)
L81:
        ;acc8+ constant 100
        ADD   A,100
L82:
        ;acc8Comp constant 134
        SUB   A,134
L83:
        ;brge 92
        JP    NC,L92
L84:
        ;br 87
        JP    L87
L85:
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
L86:
        ;br 80
        JP    L80
L87:
        ;acc8= variable 1
        LD    A,(05001H)
L88:
        ;call writeAcc8
        CALL  writeA
L89:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L90:
        ;br 85
        JP    L85
L91:
        ;;test11.j(28)   for (byte b = 34; 135 >= b+100; b++) { write (b2); b2++; }
L92:
        ;acc8= constant 34
        LD    A,34
L93:
        ;acc8=> variable 6
        LD    (05006H),A
L94:
        ;acc8= variable 6
        LD    A,(05006H)
L95:
        ;acc8+ constant 100
        ADD   A,100
L96:
        ;acc8Comp constant 135
        SUB   A,135
L97:
        ;brgt 106
        JR    Z,$+5
        JP    C,L106
L98:
        ;br 101
        JP    L101
L99:
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
L100:
        ;br 94
        JP    L94
L101:
        ;acc8= variable 1
        LD    A,(05001H)
L102:
        ;call writeAcc8
        CALL  writeA
L103:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L104:
        ;br 99
        JP    L99
L105:
        ;;test11.j(29)   for (byte b = 28; 126 <  b+100; b--) { write (b2); b2++; }
L106:
        ;acc8= constant 28
        LD    A,28
L107:
        ;acc8=> variable 6
        LD    (05006H),A
L108:
        ;acc8= variable 6
        LD    A,(05006H)
L109:
        ;acc8+ constant 100
        ADD   A,100
L110:
        ;acc8Comp constant 126
        SUB   A,126
L111:
        ;brle 120
        JP    Z,L120
L112:
        ;br 115
        JP    L115
L113:
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
L114:
        ;br 108
        JP    L108
L115:
        ;acc8= variable 1
        LD    A,(05001H)
L116:
        ;call writeAcc8
        CALL  writeA
L117:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L118:
        ;br 113
        JP    L113
L119:
        ;;test11.j(30)   for (byte b = 26; 125 <= b+100; b--) { write (b2); b2++; }
L120:
        ;acc8= constant 26
        LD    A,26
L121:
        ;acc8=> variable 6
        LD    (05006H),A
L122:
        ;acc8= variable 6
        LD    A,(05006H)
L123:
        ;acc8+ constant 100
        ADD   A,100
L124:
        ;acc8Comp constant 125
        SUB   A,125
L125:
        ;brlt 135
        JP    C,L135
L126:
        ;br 129
        JP    L129
L127:
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
L128:
        ;br 122
        JP    L122
L129:
        ;acc8= variable 1
        LD    A,(05001H)
L130:
        ;call writeAcc8
        CALL  writeA
L131:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L132:
        ;br 127
        JP    L127
L133:
        ;;test11.j(31)   // byte - integer
L134:
        ;;test11.j(32)   for(word i = 24; 24  == i+0; i--) { write (b2); b2++; }
L135:
        ;acc8= constant 24
        LD    A,24
L136:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L137:
        ;acc16= variable 6
        LD    HL,(05006H)
L138:
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
L139:
        ;acc8= constant 24
        LD    A,24
L140:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L141:
        ;brne 150
        JP    NZ,L150
L142:
        ;br 145
        JP    L145
L143:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L144:
        ;br 137
        JP    L137
L145:
        ;acc8= variable 1
        LD    A,(05001H)
L146:
        ;call writeAcc8
        CALL  writeA
L147:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L148:
        ;br 143
        JP    L143
L149:
        ;;test11.j(33)   for(word i = 23; 120 != i+100; i--) { write (b2); b2++; }
L150:
        ;acc8= constant 23
        LD    A,23
L151:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L152:
        ;acc16= variable 6
        LD    HL,(05006H)
L153:
        ;acc16+ constant 100
        LD    DE,100
        ADD   HL,DE
L154:
        ;acc8= constant 120
        LD    A,120
L155:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L156:
        ;breq 165
        JP    Z,L165
L157:
        ;br 160
        JP    L160
L158:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L159:
        ;br 152
        JP    L152
L160:
        ;acc8= variable 1
        LD    A,(05001H)
L161:
        ;call writeAcc8
        CALL  writeA
L162:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L163:
        ;br 158
        JP    L158
L164:
        ;;test11.j(34)   for(word i = 20; 122 > i+100; i++) { write (b2); b2++; }
L165:
        ;acc8= constant 20
        LD    A,20
L166:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L167:
        ;acc16= variable 6
        LD    HL,(05006H)
L168:
        ;acc16+ constant 100
        LD    DE,100
        ADD   HL,DE
L169:
        ;acc8= constant 122
        LD    A,122
L170:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L171:
        ;brle 180
        JP    Z,L180
L172:
        ;br 175
        JP    L175
L173:
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L174:
        ;br 167
        JP    L167
L175:
        ;acc8= variable 1
        LD    A,(05001H)
L176:
        ;call writeAcc8
        CALL  writeA
L177:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L178:
        ;br 173
        JP    L173
L179:
        ;;test11.j(35)   for(word i = 22; 123 >= i+100; i++) { write (b2); b2++; }
L180:
        ;acc8= constant 22
        LD    A,22
L181:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L182:
        ;acc16= variable 6
        LD    HL,(05006H)
L183:
        ;acc16+ constant 100
        LD    DE,100
        ADD   HL,DE
L184:
        ;acc8= constant 123
        LD    A,123
L185:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L186:
        ;brlt 195
        JP    C,L195
L187:
        ;br 190
        JP    L190
L188:
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L189:
        ;br 182
        JP    L182
L190:
        ;acc8= variable 1
        LD    A,(05001H)
L191:
        ;call writeAcc8
        CALL  writeA
L192:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L193:
        ;br 188
        JP    L188
L194:
        ;;test11.j(36)   for(word i = 16; 114 <  i+100; i--) { write (b2); b2++; }
L195:
        ;acc8= constant 16
        LD    A,16
L196:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L197:
        ;acc16= variable 6
        LD    HL,(05006H)
L198:
        ;acc16+ constant 100
        LD    DE,100
        ADD   HL,DE
L199:
        ;acc8= constant 114
        LD    A,114
L200:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L201:
        ;brge 210
        JP    NC,L210
L202:
        ;br 205
        JP    L205
L203:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L204:
        ;br 197
        JP    L197
L205:
        ;acc8= variable 1
        LD    A,(05001H)
L206:
        ;call writeAcc8
        CALL  writeA
L207:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L208:
        ;br 203
        JP    L203
L209:
        ;;test11.j(37)   for(word i = 14; 113 <= i+100; i--) { write (b2); b2++; }
L210:
        ;acc8= constant 14
        LD    A,14
L211:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L212:
        ;acc16= variable 6
        LD    HL,(05006H)
L213:
        ;acc16+ constant 100
        LD    DE,100
        ADD   HL,DE
L214:
        ;acc8= constant 113
        LD    A,113
L215:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L216:
        ;brgt 228
        JR    Z,$+5
        JP    C,L228
L217:
        ;br 220
        JP    L220
L218:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L219:
        ;br 212
        JP    L212
L220:
        ;acc8= variable 1
        LD    A,(05001H)
L221:
        ;call writeAcc8
        CALL  writeA
L222:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L223:
        ;br 218
        JP    L218
L224:
        ;;test11.j(38)   // integer - byte
L225:
        ;;test11.j(39)   // not relevant
L226:
        ;;test11.j(40)   // integer - integer
L227:
        ;;test11.j(41)   for(word i = 12; 1012 == i+1000; i--) { write (b2); b2++; }
L228:
        ;acc8= constant 12
        LD    A,12
L229:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L230:
        ;acc16= variable 6
        LD    HL,(05006H)
L231:
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
L232:
        ;acc16Comp constant 1012
        LD    DE,1012
        OR    A
        SBC   HL,DE
L233:
        ;brne 242
        JP    NZ,L242
L234:
        ;br 237
        JP    L237
L235:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L236:
        ;br 230
        JP    L230
L237:
        ;acc8= variable 1
        LD    A,(05001H)
L238:
        ;call writeAcc8
        CALL  writeA
L239:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L240:
        ;br 235
        JP    L235
L241:
        ;;test11.j(42)   for(word i = 11; 1008 != i+1000; i--) { write (b2); b2++; }
L242:
        ;acc8= constant 11
        LD    A,11
L243:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L244:
        ;acc16= variable 6
        LD    HL,(05006H)
L245:
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
L246:
        ;acc16Comp constant 1008
        LD    DE,1008
        OR    A
        SBC   HL,DE
L247:
        ;breq 256
        JP    Z,L256
L248:
        ;br 251
        JP    L251
L249:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L250:
        ;br 244
        JP    L244
L251:
        ;acc8= variable 1
        LD    A,(05001H)
L252:
        ;call writeAcc8
        CALL  writeA
L253:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L254:
        ;br 249
        JP    L249
L255:
        ;;test11.j(43)   for(word i = 8; 1010 > i+1000; i++) { write (b2); b2++; }
L256:
        ;acc8= constant 8
        LD    A,8
L257:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L258:
        ;acc16= variable 6
        LD    HL,(05006H)
L259:
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
L260:
        ;acc16Comp constant 1010
        LD    DE,1010
        OR    A
        SBC   HL,DE
L261:
        ;brge 270
        JP    NC,L270
L262:
        ;br 265
        JP    L265
L263:
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L264:
        ;br 258
        JP    L258
L265:
        ;acc8= variable 1
        LD    A,(05001H)
L266:
        ;call writeAcc8
        CALL  writeA
L267:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L268:
        ;br 263
        JP    L263
L269:
        ;;test11.j(44)   for(word i = 10; 1011 >= i+1000; i++) { write (b2); b2++; }
L270:
        ;acc8= constant 10
        LD    A,10
L271:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L272:
        ;acc16= variable 6
        LD    HL,(05006H)
L273:
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
L274:
        ;acc16Comp constant 1011
        LD    DE,1011
        OR    A
        SBC   HL,DE
L275:
        ;brgt 284
        JR    Z,$+5
        JP    C,L284
L276:
        ;br 279
        JP    L279
L277:
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L278:
        ;br 272
        JP    L272
L279:
        ;acc8= variable 1
        LD    A,(05001H)
L280:
        ;call writeAcc8
        CALL  writeA
L281:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L282:
        ;br 277
        JP    L277
L283:
        ;;test11.j(45)   for(word i = 4; 1002 <  i+1000; i--) { write (b2); b2++; }
L284:
        ;acc8= constant 4
        LD    A,4
L285:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L286:
        ;acc16= variable 6
        LD    HL,(05006H)
L287:
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
L288:
        ;acc16Comp constant 1002
        LD    DE,1002
        OR    A
        SBC   HL,DE
L289:
        ;brle 298
        JP    Z,L298
L290:
        ;br 293
        JP    L293
L291:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L292:
        ;br 286
        JP    L286
L293:
        ;acc8= variable 1
        LD    A,(05001H)
L294:
        ;call writeAcc8
        CALL  writeA
L295:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L296:
        ;br 291
        JP    L291
L297:
        ;;test11.j(46)   for(word i = 2; 1001 <= i+1000; i--) { write (b2); b2++; }
L298:
        ;acc8= constant 2
        LD    A,2
L299:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L300:
        ;acc16= variable 6
        LD    HL,(05006H)
L301:
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
L302:
        ;acc16Comp constant 1001
        LD    DE,1001
        OR    A
        SBC   HL,DE
L303:
        ;brlt 316
        JP    C,L316
L304:
        ;br 307
        JP    L307
L305:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L306:
        ;br 300
        JP    L300
L307:
        ;acc8= variable 1
        LD    A,(05001H)
L308:
        ;call writeAcc8
        CALL  writeA
L309:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L310:
        ;br 305
        JP    L305
L311:
        ;;test11.j(47) 
L312:
        ;;test11.j(48)   /************************/
L313:
        ;;test11.j(49)   // constant - var
L314:
        ;;test11.j(50)   // byte - byte
L315:
        ;;test11.j(51)   for (byte b = 42; 41 <= b; b--) { write (b2); b2++; }
L316:
        ;acc8= constant 42
        LD    A,42
L317:
        ;acc8=> variable 6
        LD    (05006H),A
L318:
        ;acc8= variable 6
        LD    A,(05006H)
L319:
        ;acc8Comp constant 41
        SUB   A,41
L320:
        ;brlt 330
        JP    C,L330
L321:
        ;br 324
        JP    L324
L322:
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
L323:
        ;br 318
        JP    L318
L324:
        ;acc8= variable 1
        LD    A,(05001H)
L325:
        ;call writeAcc8
        CALL  writeA
L326:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L327:
        ;br 322
        JP    L322
L328:
        ;;test11.j(52)   // byte - integer
L329:
        ;;test11.j(53)   for(word i = 40; 39 <= i; i--) { write (b2); b2++; }
L330:
        ;acc8= constant 40
        LD    A,40
L331:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L332:
        ;acc16= variable 6
        LD    HL,(05006H)
L333:
        ;acc8= constant 39
        LD    A,39
L334:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L335:
        ;brgt 347
        JR    Z,$+5
        JP    C,L347
L336:
        ;br 339
        JP    L339
L337:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L338:
        ;br 332
        JP    L332
L339:
        ;acc8= variable 1
        LD    A,(05001H)
L340:
        ;call writeAcc8
        CALL  writeA
L341:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L342:
        ;br 337
        JP    L337
L343:
        ;;test11.j(54)   // integer - byte
L344:
        ;;test11.j(55)   // not relevant
L345:
        ;;test11.j(56)   // integer - integer
L346:
        ;;test11.j(57)   for(word i = 1038; 1037 <= i; i--) { write (b2); b2++; }
L347:
        ;acc16= constant 1038
        LD    HL,1038
L348:
        ;acc16=> variable 6
        LD    (05006H),HL
L349:
        ;acc16= variable 6
        LD    HL,(05006H)
L350:
        ;acc16Comp constant 1037
        LD    DE,1037
        OR    A
        SBC   HL,DE
L351:
        ;brlt 365
        JP    C,L365
L352:
        ;br 355
        JP    L355
L353:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L354:
        ;br 349
        JP    L349
L355:
        ;acc8= variable 1
        LD    A,(05001H)
L356:
        ;call writeAcc8
        CALL  writeA
L357:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L358:
        ;br 353
        JP    L353
L359:
        ;;test11.j(58) 
L360:
        ;;test11.j(59)   /************************/
L361:
        ;;test11.j(60)   // constant - stack8
L362:
        ;;test11.j(61)   // byte - byte
L363:
        ;;test11.j(62)   //TODO
L364:
        ;;test11.j(63)   write(43);
L365:
        ;acc8= constant 43
        LD    A,43
L366:
        ;call writeAcc8
        CALL  writeA
L367:
        ;;test11.j(64)   write(44);
L368:
        ;acc8= constant 44
        LD    A,44
L369:
        ;call writeAcc8
        CALL  writeA
L370:
        ;;test11.j(65)   // constant - stack8
L371:
        ;;test11.j(66)   // byte - integer
L372:
        ;;test11.j(67)   //TODO
L373:
        ;;test11.j(68)   write(45);
L374:
        ;acc8= constant 45
        LD    A,45
L375:
        ;call writeAcc8
        CALL  writeA
L376:
        ;;test11.j(69)   write(46);
L377:
        ;acc8= constant 46
        LD    A,46
L378:
        ;call writeAcc8
        CALL  writeA
L379:
        ;;test11.j(70)   // constant - stack8
L380:
        ;;test11.j(71)   // integer - byte
L381:
        ;;test11.j(72)   //TODO
L382:
        ;;test11.j(73)   write(47);
L383:
        ;acc8= constant 47
        LD    A,47
L384:
        ;call writeAcc8
        CALL  writeA
L385:
        ;;test11.j(74)   write(48);
L386:
        ;acc8= constant 48
        LD    A,48
L387:
        ;call writeAcc8
        CALL  writeA
L388:
        ;;test11.j(75)   // constant - stack88
L389:
        ;;test11.j(76)   // integer - integer
L390:
        ;;test11.j(77)   //TODO
L391:
        ;;test11.j(78)   write(49);
L392:
        ;acc8= constant 49
        LD    A,49
L393:
        ;call writeAcc8
        CALL  writeA
L394:
        ;;test11.j(79)   write(50);
L395:
        ;acc8= constant 50
        LD    A,50
L396:
        ;call writeAcc8
        CALL  writeA
L397:
        ;;test11.j(80) 
L398:
        ;;test11.j(81)   /************************/
L399:
        ;;test11.j(82)   // constant - stack16
L400:
        ;;test11.j(83)   // byte - byte
L401:
        ;;test11.j(84)   //TODO
L402:
        ;;test11.j(85)   write(51);
L403:
        ;acc8= constant 51
        LD    A,51
L404:
        ;call writeAcc8
        CALL  writeA
L405:
        ;;test11.j(86)   write(52);
L406:
        ;acc8= constant 52
        LD    A,52
L407:
        ;call writeAcc8
        CALL  writeA
L408:
        ;;test11.j(87)   // constant - stack16
L409:
        ;;test11.j(88)   // byte - integer
L410:
        ;;test11.j(89)   //TODO
L411:
        ;;test11.j(90)   write(53);
L412:
        ;acc8= constant 53
        LD    A,53
L413:
        ;call writeAcc8
        CALL  writeA
L414:
        ;;test11.j(91)   write(54);
L415:
        ;acc8= constant 54
        LD    A,54
L416:
        ;call writeAcc8
        CALL  writeA
L417:
        ;;test11.j(92)   // constant - stack16
L418:
        ;;test11.j(93)   // integer - byte
L419:
        ;;test11.j(94)   //TODO
L420:
        ;;test11.j(95)   write(55);
L421:
        ;acc8= constant 55
        LD    A,55
L422:
        ;call writeAcc8
        CALL  writeA
L423:
        ;;test11.j(96)   write(56);
L424:
        ;acc8= constant 56
        LD    A,56
L425:
        ;call writeAcc8
        CALL  writeA
L426:
        ;;test11.j(97)   // constant - stack16
L427:
        ;;test11.j(98)   // integer - integer
L428:
        ;;test11.j(99)   //TODO
L429:
        ;;test11.j(100)   write(57);
L430:
        ;acc8= constant 57
        LD    A,57
L431:
        ;call writeAcc8
        CALL  writeA
L432:
        ;;test11.j(101)   write(58);
L433:
        ;acc8= constant 58
        LD    A,58
L434:
        ;call writeAcc8
        CALL  writeA
L435:
        ;;test11.j(102) 
L436:
        ;;test11.j(103)   /************************/
L437:
        ;;test11.j(104)   // acc - constant
L438:
        ;;test11.j(105)   // byte - byte
L439:
        ;;test11.j(106)   b2 = 59;
L440:
        ;acc8= constant 59
        LD    A,59
L441:
        ;acc8=> variable 1
        LD    (05001H),A
L442:
        ;;test11.j(107)   for (byte b = 56; b+0 <= 57; b++) { write (b2); b2++; }
L443:
        ;acc8= constant 56
        LD    A,56
L444:
        ;acc8=> variable 6
        LD    (05006H),A
L445:
        ;acc8= variable 6
        LD    A,(05006H)
L446:
        ;acc8+ constant 0
        ADD   A,0
L447:
        ;acc8Comp constant 57
        SUB   A,57
L448:
        ;brgt 460
        JR    Z,$+5
        JP    C,L460
L449:
        ;br 452
        JP    L452
L450:
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
L451:
        ;br 445
        JP    L445
L452:
        ;acc8= variable 1
        LD    A,(05001H)
L453:
        ;call writeAcc8
        CALL  writeA
L454:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L455:
        ;br 450
        JP    L450
L456:
        ;;test11.j(108)   // byte - integer
L457:
        ;;test11.j(109)   //not relevant
L458:
        ;;test11.j(110)   // integer - byte
L459:
        ;;test11.j(111)   for (word i = 54; i+0 <= 55; i++) { write (b2); b2++;}
L460:
        ;acc8= constant 54
        LD    A,54
L461:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L462:
        ;acc16= variable 6
        LD    HL,(05006H)
L463:
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
L464:
        ;acc8= constant 55
        LD    A,55
L465:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L466:
        ;brgt 476
        JR    Z,$+5
        JP    C,L476
L467:
        ;br 470
        JP    L470
L468:
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L469:
        ;br 462
        JP    L462
L470:
        ;acc8= variable 1
        LD    A,(05001H)
L471:
        ;call writeAcc8
        CALL  writeA
L472:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L473:
        ;br 468
        JP    L468
L474:
        ;;test11.j(112)   // integer - integer
L475:
        ;;test11.j(113)   for(word i = 1052; i+0 <= 1053; i++) { write (b2); b2++; }
L476:
        ;acc16= constant 1052
        LD    HL,1052
L477:
        ;acc16=> variable 6
        LD    (05006H),HL
L478:
        ;acc16= variable 6
        LD    HL,(05006H)
L479:
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
L480:
        ;acc16Comp constant 1053
        LD    DE,1053
        OR    A
        SBC   HL,DE
L481:
        ;brgt 494
        JR    Z,$+5
        JP    C,L494
L482:
        ;br 485
        JP    L485
L483:
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L484:
        ;br 478
        JP    L478
L485:
        ;acc8= variable 1
        LD    A,(05001H)
L486:
        ;call writeAcc8
        CALL  writeA
L487:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L488:
        ;br 483
        JP    L483
L489:
        ;;test11.j(114) 
L490:
        ;;test11.j(115)   /************************/
L491:
        ;;test11.j(116)   // acc - acc
L492:
        ;;test11.j(117)   // byte - byte
L493:
        ;;test11.j(118)   for (byte b = 64; 63+0 <= b+0; b--) { write (b2); b2++; }
L494:
        ;acc8= constant 64
        LD    A,64
L495:
        ;acc8=> variable 6
        LD    (05006H),A
L496:
        ;acc8= constant 63
        LD    A,63
L497:
        ;acc8+ constant 0
        ADD   A,0
L498:
        ;<acc8
        PUSH AF
L499:
        ;acc8= variable 6
        LD    A,(05006H)
L500:
        ;acc8+ constant 0
        ADD   A,0
L501:
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
L502:
        ;brlt 512
        JP    C,L512
L503:
        ;br 506
        JP    L506
L504:
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
L505:
        ;br 496
        JP    L496
L506:
        ;acc8= variable 1
        LD    A,(05001H)
L507:
        ;call writeAcc8
        CALL  writeA
L508:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L509:
        ;br 504
        JP    L504
L510:
        ;;test11.j(119)   // byte - integer
L511:
        ;;test11.j(120)   for(word i = 62; 61+0 <= i+0; i--) { write (b2); b2++; }
L512:
        ;acc8= constant 62
        LD    A,62
L513:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L514:
        ;acc8= constant 61
        LD    A,61
L515:
        ;acc8+ constant 0
        ADD   A,0
L516:
        ;<acc8
        PUSH AF
L517:
        ;acc16= variable 6
        LD    HL,(05006H)
L518:
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
L519:
        ;acc8= unstack8
        POP  AF
L520:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L521:
        ;brgt 531
        JR    Z,$+5
        JP    C,L531
L522:
        ;br 525
        JP    L525
L523:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L524:
        ;br 514
        JP    L514
L525:
        ;acc8= variable 1
        LD    A,(05001H)
L526:
        ;call writeAcc8
        CALL  writeA
L527:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L528:
        ;br 523
        JP    L523
L529:
        ;;test11.j(121)   // integer - byte
L530:
        ;;test11.j(122)   i2=59;
L531:
        ;acc8= constant 59
        LD    A,59
L532:
        ;acc8=> variable 2
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L533:
        ;;test11.j(123)   for (byte b = 60; i2+0 <= b+0; b--) { write (b2); b2++; }
L534:
        ;acc8= constant 60
        LD    A,60
L535:
        ;acc8=> variable 6
        LD    (05006H),A
L536:
        ;acc16= variable 2
        LD    HL,(05002H)
L537:
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
L538:
        ;<acc16
        PUSH HL
L539:
        ;acc8= variable 6
        LD    A,(05006H)
L540:
        ;acc8+ constant 0
        ADD   A,0
L541:
        ;acc16= unstack16
        POP  HL
L542:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L543:
        ;brgt 553
        JR    Z,$+5
        JP    C,L553
L544:
        ;br 547
        JP    L547
L545:
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
L546:
        ;br 536
        JP    L536
L547:
        ;acc8= variable 1
        LD    A,(05001H)
L548:
        ;call writeAcc8
        CALL  writeA
L549:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L550:
        ;br 545
        JP    L545
L551:
        ;;test11.j(124)   // integer - integer
L552:
        ;;test11.j(125)   for(word i = 1058; 1000+57 <= i+0; i--) { write (b2); b2++; }
L553:
        ;acc16= constant 1058
        LD    HL,1058
L554:
        ;acc16=> variable 6
        LD    (05006H),HL
L555:
        ;acc16= constant 1000
        LD    HL,1000
L556:
        ;acc16+ constant 57
        LD    DE,57
        ADD   HL,DE
L557:
        ;<acc16
        PUSH HL
L558:
        ;acc16= variable 6
        LD    HL,(05006H)
L559:
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
L560:
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
L561:
        ;brlt 574
        JP    C,L574
L562:
        ;br 565
        JP    L565
L563:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L564:
        ;br 555
        JP    L555
L565:
        ;acc8= variable 1
        LD    A,(05001H)
L566:
        ;call writeAcc8
        CALL  writeA
L567:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L568:
        ;br 563
        JP    L563
L569:
        ;;test11.j(126) 
L570:
        ;;test11.j(127)   /************************/
L571:
        ;;test11.j(128)   // acc - var
L572:
        ;;test11.j(129)   // byte - byte
L573:
        ;;test11.j(130)   for (byte b = 72; 71+0 <= b; b--) { write (b2); b2++; }
L574:
        ;acc8= constant 72
        LD    A,72
L575:
        ;acc8=> variable 6
        LD    (05006H),A
L576:
        ;acc8= constant 71
        LD    A,71
L577:
        ;acc8+ constant 0
        ADD   A,0
L578:
        ;acc8Comp variable 6
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L579:
        ;brgt 589
        JR    Z,$+5
        JP    C,L589
L580:
        ;br 583
        JP    L583
L581:
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
L582:
        ;br 576
        JP    L576
L583:
        ;acc8= variable 1
        LD    A,(05001H)
L584:
        ;call writeAcc8
        CALL  writeA
L585:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L586:
        ;br 581
        JP    L581
L587:
        ;;test11.j(131)   // byte - integer
L588:
        ;;test11.j(132)   for(word i = 70; 69+0 <= i; i--) { write (b2); b2++; }
L589:
        ;acc8= constant 70
        LD    A,70
L590:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L591:
        ;acc8= constant 69
        LD    A,69
L592:
        ;acc8+ constant 0
        ADD   A,0
L593:
        ;acc16= variable 6
        LD    HL,(05006H)
L594:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L595:
        ;brgt 605
        JR    Z,$+5
        JP    C,L605
L596:
        ;br 599
        JP    L599
L597:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L598:
        ;br 591
        JP    L591
L599:
        ;acc8= variable 1
        LD    A,(05001H)
L600:
        ;call writeAcc8
        CALL  writeA
L601:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L602:
        ;br 597
        JP    L597
L603:
        ;;test11.j(133)   // integer - byte
L604:
        ;;test11.j(134)   i2=67;
L605:
        ;acc8= constant 67
        LD    A,67
L606:
        ;acc8=> variable 2
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L607:
        ;;test11.j(135)   for (byte b = 68; i2+0 <= b; b--) { write (b2); b2++; }
L608:
        ;acc8= constant 68
        LD    A,68
L609:
        ;acc8=> variable 6
        LD    (05006H),A
L610:
        ;acc16= variable 2
        LD    HL,(05002H)
L611:
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
L612:
        ;acc8= variable 6
        LD    A,(05006H)
L613:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L614:
        ;brgt 624
        JR    Z,$+5
        JP    C,L624
L615:
        ;br 618
        JP    L618
L616:
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
L617:
        ;br 610
        JP    L610
L618:
        ;acc8= variable 1
        LD    A,(05001H)
L619:
        ;call writeAcc8
        CALL  writeA
L620:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L621:
        ;br 616
        JP    L616
L622:
        ;;test11.j(136)   // integer - integer
L623:
        ;;test11.j(137)   for(word i = 1066; 1000+65 <= i; i--) { write (b2); b2++; }
L624:
        ;acc16= constant 1066
        LD    HL,1066
L625:
        ;acc16=> variable 6
        LD    (05006H),HL
L626:
        ;acc16= constant 1000
        LD    HL,1000
L627:
        ;acc16+ constant 65
        LD    DE,65
        ADD   HL,DE
L628:
        ;acc16Comp variable 6
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L629:
        ;brgt 643
        JR    Z,$+5
        JP    C,L643
L630:
        ;br 633
        JP    L633
L631:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L632:
        ;br 626
        JP    L626
L633:
        ;acc8= variable 1
        LD    A,(05001H)
L634:
        ;call writeAcc8
        CALL  writeA
L635:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L636:
        ;br 631
        JP    L631
L637:
        ;;test11.j(138) 
L638:
        ;;test11.j(139)   /************************/
L639:
        ;;test11.j(140)   // acc - stack8
L640:
        ;;test11.j(141)   // byte - byte
L641:
        ;;test11.j(142)   //TODO
L642:
        ;;test11.j(143)   write(81);
L643:
        ;acc8= constant 81
        LD    A,81
L644:
        ;call writeAcc8
        CALL  writeA
L645:
        ;;test11.j(144)   write(82);
L646:
        ;acc8= constant 82
        LD    A,82
L647:
        ;call writeAcc8
        CALL  writeA
L648:
        ;;test11.j(145)   // byte - integer
L649:
        ;;test11.j(146)   //TODO
L650:
        ;;test11.j(147)   write(83);
L651:
        ;acc8= constant 83
        LD    A,83
L652:
        ;call writeAcc8
        CALL  writeA
L653:
        ;;test11.j(148)   write(84);
L654:
        ;acc8= constant 84
        LD    A,84
L655:
        ;call writeAcc8
        CALL  writeA
L656:
        ;;test11.j(149)   // integer - byte
L657:
        ;;test11.j(150)   //TODO
L658:
        ;;test11.j(151)   write(85);
L659:
        ;acc8= constant 85
        LD    A,85
L660:
        ;call writeAcc8
        CALL  writeA
L661:
        ;;test11.j(152)   write(86);
L662:
        ;acc8= constant 86
        LD    A,86
L663:
        ;call writeAcc8
        CALL  writeA
L664:
        ;;test11.j(153)   // integer - integer
L665:
        ;;test11.j(154)   //TODO
L666:
        ;;test11.j(155)   write(87);
L667:
        ;acc8= constant 87
        LD    A,87
L668:
        ;call writeAcc8
        CALL  writeA
L669:
        ;;test11.j(156)   write(88);
L670:
        ;acc8= constant 88
        LD    A,88
L671:
        ;call writeAcc8
        CALL  writeA
L672:
        ;;test11.j(157) 
L673:
        ;;test11.j(158)   /************************/
L674:
        ;;test11.j(159)   // acc - stack16
L675:
        ;;test11.j(160)   // byte - byte
L676:
        ;;test11.j(161)   //TODO
L677:
        ;;test11.j(162)   write(89);
L678:
        ;acc8= constant 89
        LD    A,89
L679:
        ;call writeAcc8
        CALL  writeA
L680:
        ;;test11.j(163)   write(90);
L681:
        ;acc8= constant 90
        LD    A,90
L682:
        ;call writeAcc8
        CALL  writeA
L683:
        ;;test11.j(164)   // byte - integer
L684:
        ;;test11.j(165)   //TODO
L685:
        ;;test11.j(166)   write(91);
L686:
        ;acc8= constant 91
        LD    A,91
L687:
        ;call writeAcc8
        CALL  writeA
L688:
        ;;test11.j(167)   write(92);
L689:
        ;acc8= constant 92
        LD    A,92
L690:
        ;call writeAcc8
        CALL  writeA
L691:
        ;;test11.j(168)   // integer - byte
L692:
        ;;test11.j(169)   //TODO
L693:
        ;;test11.j(170)   write(93);
L694:
        ;acc8= constant 93
        LD    A,93
L695:
        ;call writeAcc8
        CALL  writeA
L696:
        ;;test11.j(171)   write(94);
L697:
        ;acc8= constant 94
        LD    A,94
L698:
        ;call writeAcc8
        CALL  writeA
L699:
        ;;test11.j(172)   // integer - integer
L700:
        ;;test11.j(173)   //TODO
L701:
        ;;test11.j(174)   write(95);
L702:
        ;acc8= constant 95
        LD    A,95
L703:
        ;call writeAcc8
        CALL  writeA
L704:
        ;;test11.j(175)   write(96);
L705:
        ;acc8= constant 96
        LD    A,96
L706:
        ;call writeAcc8
        CALL  writeA
L707:
        ;;test11.j(176) 
L708:
        ;;test11.j(177)   /************************/
L709:
        ;;test11.j(178)   // var - constant
L710:
        ;;test11.j(179)   // byte - byte
L711:
        ;;test11.j(180)   b2=97;
L712:
        ;acc8= constant 97
        LD    A,97
L713:
        ;acc8=> variable 1
        LD    (05001H),A
L714:
        ;;test11.j(181)   for (byte b = 96; b <= 97; b++) { write (b2); b2++; }
L715:
        ;acc8= constant 96
        LD    A,96
L716:
        ;acc8=> variable 6
        LD    (05006H),A
L717:
        ;acc8= variable 6
        LD    A,(05006H)
L718:
        ;acc8Comp constant 97
        SUB   A,97
L719:
        ;brgt 731
        JR    Z,$+5
        JP    C,L731
L720:
        ;br 723
        JP    L723
L721:
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
L722:
        ;br 717
        JP    L717
L723:
        ;acc8= variable 1
        LD    A,(05001H)
L724:
        ;call writeAcc8
        CALL  writeA
L725:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L726:
        ;br 721
        JP    L721
L727:
        ;;test11.j(182)   // byte - integer
L728:
        ;;test11.j(183)   //not relevant
L729:
        ;;test11.j(184)   // integer - byte
L730:
        ;;test11.j(185)   for(word i = 92; i <= 93; i++) { write (b2); b2++; }
L731:
        ;acc8= constant 92
        LD    A,92
L732:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L733:
        ;acc16= variable 6
        LD    HL,(05006H)
L734:
        ;acc8= constant 93
        LD    A,93
L735:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L736:
        ;brgt 746
        JR    Z,$+5
        JP    C,L746
L737:
        ;br 740
        JP    L740
L738:
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L739:
        ;br 733
        JP    L733
L740:
        ;acc8= variable 1
        LD    A,(05001H)
L741:
        ;call writeAcc8
        CALL  writeA
L742:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L743:
        ;br 738
        JP    L738
L744:
        ;;test11.j(186)   // integer - integer
L745:
        ;;test11.j(187)   for(word i = 1090; i <= 1091; i++) { write (b2); b2++; }
L746:
        ;acc16= constant 1090
        LD    HL,1090
L747:
        ;acc16=> variable 6
        LD    (05006H),HL
L748:
        ;acc16= variable 6
        LD    HL,(05006H)
L749:
        ;acc16Comp constant 1091
        LD    DE,1091
        OR    A
        SBC   HL,DE
L750:
        ;brgt 763
        JR    Z,$+5
        JP    C,L763
L751:
        ;br 754
        JP    L754
L752:
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L753:
        ;br 748
        JP    L748
L754:
        ;acc8= variable 1
        LD    A,(05001H)
L755:
        ;call writeAcc8
        CALL  writeA
L756:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L757:
        ;br 752
        JP    L752
L758:
        ;;test11.j(188) 
L759:
        ;;test11.j(189)   /************************/
L760:
        ;;test11.j(190)   // var - acc
L761:
        ;;test11.j(191)   // byte - byte
L762:
        ;;test11.j(192)   for (byte b = 104; b <= 105+0; b++) { write (b2); b2++; }
L763:
        ;acc8= constant 104
        LD    A,104
L764:
        ;acc8=> variable 6
        LD    (05006H),A
L765:
        ;acc8= constant 105
        LD    A,105
L766:
        ;acc8+ constant 0
        ADD   A,0
L767:
        ;acc8Comp variable 6
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L768:
        ;brlt 778
        JP    C,L778
L769:
        ;br 772
        JP    L772
L770:
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
L771:
        ;br 765
        JP    L765
L772:
        ;acc8= variable 1
        LD    A,(05001H)
L773:
        ;call writeAcc8
        CALL  writeA
L774:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L775:
        ;br 770
        JP    L770
L776:
        ;;test11.j(193)   // byte - integer
L777:
        ;;test11.j(194)   i2=103;
L778:
        ;acc8= constant 103
        LD    A,103
L779:
        ;acc8=> variable 2
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L780:
        ;;test11.j(195)   for (byte b = 102; b <= i2+0; b++) { write (b2); b2++; }
L781:
        ;acc8= constant 102
        LD    A,102
L782:
        ;acc8=> variable 6
        LD    (05006H),A
L783:
        ;acc16= variable 2
        LD    HL,(05002H)
L784:
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
L785:
        ;acc8= variable 6
        LD    A,(05006H)
L786:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L787:
        ;brgt 797
        JR    Z,$+5
        JP    C,L797
L788:
        ;br 791
        JP    L791
L789:
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
L790:
        ;br 783
        JP    L783
L791:
        ;acc8= variable 1
        LD    A,(05001H)
L792:
        ;call writeAcc8
        CALL  writeA
L793:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L794:
        ;br 789
        JP    L789
L795:
        ;;test11.j(196)   // integer - byte
L796:
        ;;test11.j(197)   for(word i = 100; i <= 101+0; i++) { write (b2); b2++; }
L797:
        ;acc8= constant 100
        LD    A,100
L798:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L799:
        ;acc8= constant 101
        LD    A,101
L800:
        ;acc8+ constant 0
        ADD   A,0
L801:
        ;acc16= variable 6
        LD    HL,(05006H)
L802:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L803:
        ;brgt 813
        JR    Z,$+5
        JP    C,L813
L804:
        ;br 807
        JP    L807
L805:
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L806:
        ;br 799
        JP    L799
L807:
        ;acc8= variable 1
        LD    A,(05001H)
L808:
        ;call writeAcc8
        CALL  writeA
L809:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L810:
        ;br 805
        JP    L805
L811:
        ;;test11.j(198)   // integer - integer
L812:
        ;;test11.j(199)   for(word i = 1098; i <= 1099+0; i++) { write (b2); b2++; }
L813:
        ;acc16= constant 1098
        LD    HL,1098
L814:
        ;acc16=> variable 6
        LD    (05006H),HL
L815:
        ;acc16= constant 1099
        LD    HL,1099
L816:
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
L817:
        ;acc16Comp variable 6
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L818:
        ;brlt 831
        JP    C,L831
L819:
        ;br 822
        JP    L822
L820:
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L821:
        ;br 815
        JP    L815
L822:
        ;acc8= variable 1
        LD    A,(05001H)
L823:
        ;call writeAcc8
        CALL  writeA
L824:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L825:
        ;br 820
        JP    L820
L826:
        ;;test11.j(200) 
L827:
        ;;test11.j(201)   /************************/
L828:
        ;;test11.j(202)   // var - var
L829:
        ;;test11.j(203)   // byte - byte
L830:
        ;;test11.j(204)   for (byte b = 112; b2 <= b; b--) { write (b2); b2++; }
L831:
        ;acc8= constant 112
        LD    A,112
L832:
        ;acc8=> variable 6
        LD    (05006H),A
L833:
        ;acc8= variable 1
        LD    A,(05001H)
L834:
        ;acc8Comp variable 6
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L835:
        ;brgt 845
        JR    Z,$+5
        JP    C,L845
L836:
        ;br 839
        JP    L839
L837:
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
L838:
        ;br 833
        JP    L833
L839:
        ;acc8= variable 1
        LD    A,(05001H)
L840:
        ;call writeAcc8
        CALL  writeA
L841:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L842:
        ;br 837
        JP    L837
L843:
        ;;test11.j(205)   // byte - integer
L844:
        ;;test11.j(206)   for(word i = 116; b2 <= i; i--) { write (b2); b2++; }
L845:
        ;acc8= constant 116
        LD    A,116
L846:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L847:
        ;acc8= variable 1
        LD    A,(05001H)
L848:
        ;acc16= variable 6
        LD    HL,(05006H)
L849:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L850:
        ;brgt 860
        JR    Z,$+5
        JP    C,L860
L851:
        ;br 854
        JP    L854
L852:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L853:
        ;br 847
        JP    L847
L854:
        ;acc8= variable 1
        LD    A,(05001H)
L855:
        ;call writeAcc8
        CALL  writeA
L856:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L857:
        ;br 852
        JP    L852
L858:
        ;;test11.j(207)   // integer - byte
L859:
        ;;test11.j(208)   i2=b2;
L860:
        ;acc8= variable 1
        LD    A,(05001H)
L861:
        ;acc8=> variable 2
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L862:
        ;;test11.j(209)   for (byte b = 118; i2 <= b; b--) { write (b2); b2++; }
L863:
        ;acc8= constant 118
        LD    A,118
L864:
        ;acc8=> variable 6
        LD    (05006H),A
L865:
        ;acc16= variable 2
        LD    HL,(05002H)
L866:
        ;acc8= variable 6
        LD    A,(05006H)
L867:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L868:
        ;brgt 878
        JR    Z,$+5
        JP    C,L878
L869:
        ;br 872
        JP    L872
L870:
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
L871:
        ;br 865
        JP    L865
L872:
        ;acc8= variable 1
        LD    A,(05001H)
L873:
        ;call writeAcc8
        CALL  writeA
L874:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L875:
        ;br 870
        JP    L870
L876:
        ;;test11.j(210)   // integer - integer
L877:
        ;;test11.j(211)   i2=120;
L878:
        ;acc8= constant 120
        LD    A,120
L879:
        ;acc8=> variable 2
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L880:
        ;;test11.j(212)   for(word i = b2+4; i2 <= i; i--) { write (b2); b2++; }
L881:
        ;acc8= variable 1
        LD    A,(05001H)
L882:
        ;acc8+ constant 4
        ADD   A,4
L883:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L884:
        ;acc16= variable 2
        LD    HL,(05002H)
L885:
        ;acc16Comp variable 6
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L886:
        ;brgt 928
        JR    Z,$+5
        JP    C,L928
L887:
        ;br 890
        JP    L890
L888:
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L889:
        ;br 884
        JP    L884
L890:
        ;acc8= variable 1
        LD    A,(05001H)
L891:
        ;call writeAcc8
        CALL  writeA
L892:
        ;incr8 variable 1
        LD    HL,(05001H)
        INC   (HL)
L893:
        ;br 888
        JP    L888
L894:
        ;;test11.j(213) 
L895:
        ;;test11.j(214)   /************************/
L896:
        ;;test11.j(215)   // var - stack8
L897:
        ;;test11.j(216)   // byte - byte
L898:
        ;;test11.j(217)   // byte - integer
L899:
        ;;test11.j(218)   // integer - byte
L900:
        ;;test11.j(219)   // integer - integer
L901:
        ;;test11.j(220)   //TODO
L902:
        ;;test11.j(221) 
L903:
        ;;test11.j(222)   /************************/
L904:
        ;;test11.j(223)   // var - stack16
L905:
        ;;test11.j(224)   // byte - byte
L906:
        ;;test11.j(225)   // byte - integer
L907:
        ;;test11.j(226)   // integer - byte
L908:
        ;;test11.j(227)   // integer - integer
L909:
        ;;test11.j(228)   //TODO
L910:
        ;;test11.j(229) 
L911:
        ;;test11.j(230)   /************************/
L912:
        ;;test11.j(231)   // stack8 - constant
L913:
        ;;test11.j(232)   // stack8 - acc
L914:
        ;;test11.j(233)   // stack8 - var
L915:
        ;;test11.j(234)   // stack8 - stack8
L916:
        ;;test11.j(235)   // stack8 - stack16
L917:
        ;;test11.j(236)   //TODO
L918:
        ;;test11.j(237) 
L919:
        ;;test11.j(238)   /************************/
L920:
        ;;test11.j(239)   // stack16 - constant
L921:
        ;;test11.j(240)   // stack16 - acc
L922:
        ;;test11.j(241)   // stack16 - var
L923:
        ;;test11.j(242)   // stack16 - stack8
L924:
        ;;test11.j(243)   // stack16 - stack16
L925:
        ;;test11.j(244)   //TODO
L926:
        ;;test11.j(245) 
L927:
        ;;test11.j(246)   write("Klaar.");
L928:
        ;acc16= constant 932
        LD    HL,932
L929:
        ;writeString
        CALL  putStr
L930:
        ;;test11.j(247) }
L931:
        ;stop
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L932:
        .ASCIZ  "Klaar."
