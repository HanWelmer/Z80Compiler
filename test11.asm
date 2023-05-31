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
        LD    A,1
L4:
        LD    (05000H),A
L5:
        ;;test11.j(3)   byte b2 = 1;
L6:
        LD    A,1
L7:
        LD    (05001H),A
L8:
        ;;test11.j(4)   word i2 = 1;
L9:
        LD    A,1
L10:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L11:
        ;;test11.j(5)   word p = 1;
L12:
        LD    A,1
L13:
        LD    L,A
        LD    H,0
        LD    (05004H),HL
L14:
        ;;test11.j(6) 
L15:
        ;;test11.j(7)   write(0);
L16:
        LD    A,0
L17:
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
        LD    A,1
L23:
        LD    (05006H),A
L24:
        LD    A,(05006H)
L25:
        SUB   A,2
L26:
        JR    Z,$+5
        JP    C,L49
L27:
        JP    L30
L28:
        LD    HL,(05006H)
        INC   (HL)
L29:
        JP    L24
L30:
        ;;test11.j(12)     byte c = b1;
L31:
        LD    A,(05000H)
L32:
        LD    (05007H),A
L33:
        ;;test11.j(13)     write (c);
L34:
        LD    A,(05007H)
L35:
        CALL  writeA
L36:
        ;;test11.j(14)     b1++;
L37:
        LD    HL,(05000H)
        INC   (HL)
L38:
        ;;test11.j(15)   }
L39:
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
        LD    A,3
L50:
        LD    (05006H),A
L51:
        LD    A,(05006H)
L52:
        ADD   A,100
L53:
        SUB   A,103
L54:
        JP    NZ,L62
L55:
        JP    L58
L56:
        LD    HL,(05006H)
        INC   (HL)
L57:
        JP    L51
L58:
        LD    A,(05006H)
L59:
        CALL  writeA
L60:
        JP    L56
L61:
        ;;test11.j(25)   for (byte b = 4; 105 != b+100; b++) { write (b); }
L62:
        LD    A,4
L63:
        LD    (05006H),A
L64:
        LD    A,(05006H)
L65:
        ADD   A,100
L66:
        SUB   A,105
L67:
        JP    Z,L75
L68:
        JP    L71
L69:
        LD    HL,(05006H)
        INC   (HL)
L70:
        JP    L64
L71:
        LD    A,(05006H)
L72:
        CALL  writeA
L73:
        JP    L69
L74:
        ;;test11.j(26)   b2=5;
L75:
        LD    A,5
L76:
        LD    (05001H),A
L77:
        ;;test11.j(27)   for (byte b = 32; 134 > b+100; b++) { write (b2); b2++; }
L78:
        LD    A,32
L79:
        LD    (05006H),A
L80:
        LD    A,(05006H)
L81:
        ADD   A,100
L82:
        SUB   A,134
L83:
        JP    NC,L92
L84:
        JP    L87
L85:
        LD    HL,(05006H)
        INC   (HL)
L86:
        JP    L80
L87:
        LD    A,(05001H)
L88:
        CALL  writeA
L89:
        LD    HL,(05001H)
        INC   (HL)
L90:
        JP    L85
L91:
        ;;test11.j(28)   for (byte b = 34; 135 >= b+100; b++) { write (b2); b2++; }
L92:
        LD    A,34
L93:
        LD    (05006H),A
L94:
        LD    A,(05006H)
L95:
        ADD   A,100
L96:
        SUB   A,135
L97:
        JR    Z,$+5
        JP    C,L106
L98:
        JP    L101
L99:
        LD    HL,(05006H)
        INC   (HL)
L100:
        JP    L94
L101:
        LD    A,(05001H)
L102:
        CALL  writeA
L103:
        LD    HL,(05001H)
        INC   (HL)
L104:
        JP    L99
L105:
        ;;test11.j(29)   for (byte b = 28; 126 <  b+100; b--) { write (b2); b2++; }
L106:
        LD    A,28
L107:
        LD    (05006H),A
L108:
        LD    A,(05006H)
L109:
        ADD   A,100
L110:
        SUB   A,126
L111:
        JP    Z,L120
L112:
        JP    L115
L113:
        LD    HL,(05006H)
        DEC   (HL)
L114:
        JP    L108
L115:
        LD    A,(05001H)
L116:
        CALL  writeA
L117:
        LD    HL,(05001H)
        INC   (HL)
L118:
        JP    L113
L119:
        ;;test11.j(30)   for (byte b = 26; 125 <= b+100; b--) { write (b2); b2++; }
L120:
        LD    A,26
L121:
        LD    (05006H),A
L122:
        LD    A,(05006H)
L123:
        ADD   A,100
L124:
        SUB   A,125
L125:
        JP    C,L135
L126:
        JP    L129
L127:
        LD    HL,(05006H)
        DEC   (HL)
L128:
        JP    L122
L129:
        LD    A,(05001H)
L130:
        CALL  writeA
L131:
        LD    HL,(05001H)
        INC   (HL)
L132:
        JP    L127
L133:
        ;;test11.j(31)   // byte - integer
L134:
        ;;test11.j(32)   for(word i = 24; 24  == i+0; i--) { write (b2); b2++; }
L135:
        LD    A,24
L136:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L137:
        LD    HL,(05006H)
L138:
        LD    DE,0
        ADD   HL,DE
L139:
        LD    A,24
L140:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L141:
        JP    NZ,L150
L142:
        JP    L145
L143:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L144:
        JP    L137
L145:
        LD    A,(05001H)
L146:
        CALL  writeA
L147:
        LD    HL,(05001H)
        INC   (HL)
L148:
        JP    L143
L149:
        ;;test11.j(33)   for(word i = 23; 120 != i+100; i--) { write (b2); b2++; }
L150:
        LD    A,23
L151:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L152:
        LD    HL,(05006H)
L153:
        LD    DE,100
        ADD   HL,DE
L154:
        LD    A,120
L155:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L156:
        JP    Z,L165
L157:
        JP    L160
L158:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L159:
        JP    L152
L160:
        LD    A,(05001H)
L161:
        CALL  writeA
L162:
        LD    HL,(05001H)
        INC   (HL)
L163:
        JP    L158
L164:
        ;;test11.j(34)   for(word i = 20; 122 > i+100; i++) { write (b2); b2++; }
L165:
        LD    A,20
L166:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L167:
        LD    HL,(05006H)
L168:
        LD    DE,100
        ADD   HL,DE
L169:
        LD    A,122
L170:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L171:
        JP    Z,L180
L172:
        JP    L175
L173:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L174:
        JP    L167
L175:
        LD    A,(05001H)
L176:
        CALL  writeA
L177:
        LD    HL,(05001H)
        INC   (HL)
L178:
        JP    L173
L179:
        ;;test11.j(35)   for(word i = 22; 123 >= i+100; i++) { write (b2); b2++; }
L180:
        LD    A,22
L181:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L182:
        LD    HL,(05006H)
L183:
        LD    DE,100
        ADD   HL,DE
L184:
        LD    A,123
L185:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L186:
        JP    C,L195
L187:
        JP    L190
L188:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L189:
        JP    L182
L190:
        LD    A,(05001H)
L191:
        CALL  writeA
L192:
        LD    HL,(05001H)
        INC   (HL)
L193:
        JP    L188
L194:
        ;;test11.j(36)   for(word i = 16; 114 <  i+100; i--) { write (b2); b2++; }
L195:
        LD    A,16
L196:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L197:
        LD    HL,(05006H)
L198:
        LD    DE,100
        ADD   HL,DE
L199:
        LD    A,114
L200:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L201:
        JP    NC,L210
L202:
        JP    L205
L203:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L204:
        JP    L197
L205:
        LD    A,(05001H)
L206:
        CALL  writeA
L207:
        LD    HL,(05001H)
        INC   (HL)
L208:
        JP    L203
L209:
        ;;test11.j(37)   for(word i = 14; 113 <= i+100; i--) { write (b2); b2++; }
L210:
        LD    A,14
L211:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L212:
        LD    HL,(05006H)
L213:
        LD    DE,100
        ADD   HL,DE
L214:
        LD    A,113
L215:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L216:
        JR    Z,$+5
        JP    C,L228
L217:
        JP    L220
L218:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L219:
        JP    L212
L220:
        LD    A,(05001H)
L221:
        CALL  writeA
L222:
        LD    HL,(05001H)
        INC   (HL)
L223:
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
        LD    A,12
L229:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L230:
        LD    HL,(05006H)
L231:
        LD    DE,1000
        ADD   HL,DE
L232:
        LD    DE,1012
        OR    A
        SBC   HL,DE
L233:
        JP    NZ,L242
L234:
        JP    L237
L235:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L236:
        JP    L230
L237:
        LD    A,(05001H)
L238:
        CALL  writeA
L239:
        LD    HL,(05001H)
        INC   (HL)
L240:
        JP    L235
L241:
        ;;test11.j(42)   for(word i = 11; 1008 != i+1000; i--) { write (b2); b2++; }
L242:
        LD    A,11
L243:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L244:
        LD    HL,(05006H)
L245:
        LD    DE,1000
        ADD   HL,DE
L246:
        LD    DE,1008
        OR    A
        SBC   HL,DE
L247:
        JP    Z,L256
L248:
        JP    L251
L249:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L250:
        JP    L244
L251:
        LD    A,(05001H)
L252:
        CALL  writeA
L253:
        LD    HL,(05001H)
        INC   (HL)
L254:
        JP    L249
L255:
        ;;test11.j(43)   for(word i = 8; 1010 > i+1000; i++) { write (b2); b2++; }
L256:
        LD    A,8
L257:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L258:
        LD    HL,(05006H)
L259:
        LD    DE,1000
        ADD   HL,DE
L260:
        LD    DE,1010
        OR    A
        SBC   HL,DE
L261:
        JP    NC,L270
L262:
        JP    L265
L263:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L264:
        JP    L258
L265:
        LD    A,(05001H)
L266:
        CALL  writeA
L267:
        LD    HL,(05001H)
        INC   (HL)
L268:
        JP    L263
L269:
        ;;test11.j(44)   for(word i = 10; 1011 >= i+1000; i++) { write (b2); b2++; }
L270:
        LD    A,10
L271:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L272:
        LD    HL,(05006H)
L273:
        LD    DE,1000
        ADD   HL,DE
L274:
        LD    DE,1011
        OR    A
        SBC   HL,DE
L275:
        JR    Z,$+5
        JP    C,L284
L276:
        JP    L279
L277:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L278:
        JP    L272
L279:
        LD    A,(05001H)
L280:
        CALL  writeA
L281:
        LD    HL,(05001H)
        INC   (HL)
L282:
        JP    L277
L283:
        ;;test11.j(45)   for(word i = 4; 1002 <  i+1000; i--) { write (b2); b2++; }
L284:
        LD    A,4
L285:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L286:
        LD    HL,(05006H)
L287:
        LD    DE,1000
        ADD   HL,DE
L288:
        LD    DE,1002
        OR    A
        SBC   HL,DE
L289:
        JP    Z,L298
L290:
        JP    L293
L291:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L292:
        JP    L286
L293:
        LD    A,(05001H)
L294:
        CALL  writeA
L295:
        LD    HL,(05001H)
        INC   (HL)
L296:
        JP    L291
L297:
        ;;test11.j(46)   for(word i = 2; 1001 <= i+1000; i--) { write (b2); b2++; }
L298:
        LD    A,2
L299:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L300:
        LD    HL,(05006H)
L301:
        LD    DE,1000
        ADD   HL,DE
L302:
        LD    DE,1001
        OR    A
        SBC   HL,DE
L303:
        JP    C,L316
L304:
        JP    L307
L305:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L306:
        JP    L300
L307:
        LD    A,(05001H)
L308:
        CALL  writeA
L309:
        LD    HL,(05001H)
        INC   (HL)
L310:
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
        LD    A,42
L317:
        LD    (05006H),A
L318:
        LD    A,(05006H)
L319:
        SUB   A,41
L320:
        JP    C,L330
L321:
        JP    L324
L322:
        LD    HL,(05006H)
        DEC   (HL)
L323:
        JP    L318
L324:
        LD    A,(05001H)
L325:
        CALL  writeA
L326:
        LD    HL,(05001H)
        INC   (HL)
L327:
        JP    L322
L328:
        ;;test11.j(52)   // byte - integer
L329:
        ;;test11.j(53)   for(word i = 40; 39 <= i; i--) { write (b2); b2++; }
L330:
        LD    A,40
L331:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L332:
        LD    HL,(05006H)
L333:
        LD    A,39
L334:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L335:
        JR    Z,$+5
        JP    C,L347
L336:
        JP    L339
L337:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L338:
        JP    L332
L339:
        LD    A,(05001H)
L340:
        CALL  writeA
L341:
        LD    HL,(05001H)
        INC   (HL)
L342:
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
        LD    HL,1038
L348:
        LD    (05006H),HL
L349:
        LD    HL,(05006H)
L350:
        LD    DE,1037
        OR    A
        SBC   HL,DE
L351:
        JP    C,L365
L352:
        JP    L355
L353:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L354:
        JP    L349
L355:
        LD    A,(05001H)
L356:
        CALL  writeA
L357:
        LD    HL,(05001H)
        INC   (HL)
L358:
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
        LD    A,43
L366:
        CALL  writeA
L367:
        ;;test11.j(64)   write(44);
L368:
        LD    A,44
L369:
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
        LD    A,45
L375:
        CALL  writeA
L376:
        ;;test11.j(69)   write(46);
L377:
        LD    A,46
L378:
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
        LD    A,47
L384:
        CALL  writeA
L385:
        ;;test11.j(74)   write(48);
L386:
        LD    A,48
L387:
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
        LD    A,49
L393:
        CALL  writeA
L394:
        ;;test11.j(79)   write(50);
L395:
        LD    A,50
L396:
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
        LD    A,51
L404:
        CALL  writeA
L405:
        ;;test11.j(86)   write(52);
L406:
        LD    A,52
L407:
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
        LD    A,53
L413:
        CALL  writeA
L414:
        ;;test11.j(91)   write(54);
L415:
        LD    A,54
L416:
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
        LD    A,55
L422:
        CALL  writeA
L423:
        ;;test11.j(96)   write(56);
L424:
        LD    A,56
L425:
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
        LD    A,57
L431:
        CALL  writeA
L432:
        ;;test11.j(101)   write(58);
L433:
        LD    A,58
L434:
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
        LD    A,59
L441:
        LD    (05001H),A
L442:
        ;;test11.j(107)   for (byte b = 56; b+0 <= 57; b++) { write (b2); b2++; }
L443:
        LD    A,56
L444:
        LD    (05006H),A
L445:
        LD    A,(05006H)
L446:
        ADD   A,0
L447:
        SUB   A,57
L448:
        JR    Z,$+5
        JP    C,L460
L449:
        JP    L452
L450:
        LD    HL,(05006H)
        INC   (HL)
L451:
        JP    L445
L452:
        LD    A,(05001H)
L453:
        CALL  writeA
L454:
        LD    HL,(05001H)
        INC   (HL)
L455:
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
        LD    A,54
L461:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L462:
        LD    HL,(05006H)
L463:
        LD    DE,0
        ADD   HL,DE
L464:
        LD    A,55
L465:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L466:
        JR    Z,$+5
        JP    C,L476
L467:
        JP    L470
L468:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L469:
        JP    L462
L470:
        LD    A,(05001H)
L471:
        CALL  writeA
L472:
        LD    HL,(05001H)
        INC   (HL)
L473:
        JP    L468
L474:
        ;;test11.j(112)   // integer - integer
L475:
        ;;test11.j(113)   for(word i = 1052; i+0 <= 1053; i++) { write (b2); b2++; }
L476:
        LD    HL,1052
L477:
        LD    (05006H),HL
L478:
        LD    HL,(05006H)
L479:
        LD    DE,0
        ADD   HL,DE
L480:
        LD    DE,1053
        OR    A
        SBC   HL,DE
L481:
        JR    Z,$+5
        JP    C,L494
L482:
        JP    L485
L483:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L484:
        JP    L478
L485:
        LD    A,(05001H)
L486:
        CALL  writeA
L487:
        LD    HL,(05001H)
        INC   (HL)
L488:
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
        LD    A,64
L495:
        LD    (05006H),A
L496:
        LD    A,63
L497:
        ADD   A,0
L498:
        PUSH AF
L499:
        LD    A,(05006H)
L500:
        ADD   A,0
L501:
        POP   BC
        SUB   A,B
L502:
        JP    C,L512
L503:
        JP    L506
L504:
        LD    HL,(05006H)
        DEC   (HL)
L505:
        JP    L496
L506:
        LD    A,(05001H)
L507:
        CALL  writeA
L508:
        LD    HL,(05001H)
        INC   (HL)
L509:
        JP    L504
L510:
        ;;test11.j(119)   // byte - integer
L511:
        ;;test11.j(120)   for(word i = 62; 61+0 <= i+0; i--) { write (b2); b2++; }
L512:
        LD    A,62
L513:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L514:
        LD    A,61
L515:
        ADD   A,0
L516:
        PUSH AF
L517:
        LD    HL,(05006H)
L518:
        LD    DE,0
        ADD   HL,DE
L519:
        POP  AF
L520:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L521:
        JR    Z,$+5
        JP    C,L531
L522:
        JP    L525
L523:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L524:
        JP    L514
L525:
        LD    A,(05001H)
L526:
        CALL  writeA
L527:
        LD    HL,(05001H)
        INC   (HL)
L528:
        JP    L523
L529:
        ;;test11.j(121)   // integer - byte
L530:
        ;;test11.j(122)   i2=59;
L531:
        LD    A,59
L532:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L533:
        ;;test11.j(123)   for (byte b = 60; i2+0 <= b+0; b--) { write (b2); b2++; }
L534:
        LD    A,60
L535:
        LD    (05006H),A
L536:
        LD    HL,(05002H)
L537:
        LD    DE,0
        ADD   HL,DE
L538:
        PUSH HL
L539:
        LD    A,(05006H)
L540:
        ADD   A,0
L541:
        POP  HL
L542:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L543:
        JR    Z,$+5
        JP    C,L553
L544:
        JP    L547
L545:
        LD    HL,(05006H)
        DEC   (HL)
L546:
        JP    L536
L547:
        LD    A,(05001H)
L548:
        CALL  writeA
L549:
        LD    HL,(05001H)
        INC   (HL)
L550:
        JP    L545
L551:
        ;;test11.j(124)   // integer - integer
L552:
        ;;test11.j(125)   for(word i = 1058; 1000+57 <= i+0; i--) { write (b2); b2++; }
L553:
        LD    HL,1058
L554:
        LD    (05006H),HL
L555:
        LD    HL,1000
L556:
        LD    DE,57
        ADD   HL,DE
L557:
        PUSH HL
L558:
        LD    HL,(05006H)
L559:
        LD    DE,0
        ADD   HL,DE
L560:
        POP   DE
        OR    A
        SBC   HL,DE
L561:
        JP    C,L574
L562:
        JP    L565
L563:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L564:
        JP    L555
L565:
        LD    A,(05001H)
L566:
        CALL  writeA
L567:
        LD    HL,(05001H)
        INC   (HL)
L568:
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
        LD    A,72
L575:
        LD    (05006H),A
L576:
        LD    A,71
L577:
        ADD   A,0
L578:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L579:
        JR    Z,$+5
        JP    C,L589
L580:
        JP    L583
L581:
        LD    HL,(05006H)
        DEC   (HL)
L582:
        JP    L576
L583:
        LD    A,(05001H)
L584:
        CALL  writeA
L585:
        LD    HL,(05001H)
        INC   (HL)
L586:
        JP    L581
L587:
        ;;test11.j(131)   // byte - integer
L588:
        ;;test11.j(132)   for(word i = 70; 69+0 <= i; i--) { write (b2); b2++; }
L589:
        LD    A,70
L590:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L591:
        LD    A,69
L592:
        ADD   A,0
L593:
        LD    HL,(05006H)
L594:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L595:
        JR    Z,$+5
        JP    C,L605
L596:
        JP    L599
L597:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L598:
        JP    L591
L599:
        LD    A,(05001H)
L600:
        CALL  writeA
L601:
        LD    HL,(05001H)
        INC   (HL)
L602:
        JP    L597
L603:
        ;;test11.j(133)   // integer - byte
L604:
        ;;test11.j(134)   i2=67;
L605:
        LD    A,67
L606:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L607:
        ;;test11.j(135)   for (byte b = 68; i2+0 <= b; b--) { write (b2); b2++; }
L608:
        LD    A,68
L609:
        LD    (05006H),A
L610:
        LD    HL,(05002H)
L611:
        LD    DE,0
        ADD   HL,DE
L612:
        LD    A,(05006H)
L613:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L614:
        JR    Z,$+5
        JP    C,L624
L615:
        JP    L618
L616:
        LD    HL,(05006H)
        DEC   (HL)
L617:
        JP    L610
L618:
        LD    A,(05001H)
L619:
        CALL  writeA
L620:
        LD    HL,(05001H)
        INC   (HL)
L621:
        JP    L616
L622:
        ;;test11.j(136)   // integer - integer
L623:
        ;;test11.j(137)   for(word i = 1066; 1000+65 <= i; i--) { write (b2); b2++; }
L624:
        LD    HL,1066
L625:
        LD    (05006H),HL
L626:
        LD    HL,1000
L627:
        LD    DE,65
        ADD   HL,DE
L628:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L629:
        JR    Z,$+5
        JP    C,L643
L630:
        JP    L633
L631:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L632:
        JP    L626
L633:
        LD    A,(05001H)
L634:
        CALL  writeA
L635:
        LD    HL,(05001H)
        INC   (HL)
L636:
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
        LD    A,81
L644:
        CALL  writeA
L645:
        ;;test11.j(144)   write(82);
L646:
        LD    A,82
L647:
        CALL  writeA
L648:
        ;;test11.j(145)   // byte - integer
L649:
        ;;test11.j(146)   //TODO
L650:
        ;;test11.j(147)   write(83);
L651:
        LD    A,83
L652:
        CALL  writeA
L653:
        ;;test11.j(148)   write(84);
L654:
        LD    A,84
L655:
        CALL  writeA
L656:
        ;;test11.j(149)   // integer - byte
L657:
        ;;test11.j(150)   //TODO
L658:
        ;;test11.j(151)   write(85);
L659:
        LD    A,85
L660:
        CALL  writeA
L661:
        ;;test11.j(152)   write(86);
L662:
        LD    A,86
L663:
        CALL  writeA
L664:
        ;;test11.j(153)   // integer - integer
L665:
        ;;test11.j(154)   //TODO
L666:
        ;;test11.j(155)   write(87);
L667:
        LD    A,87
L668:
        CALL  writeA
L669:
        ;;test11.j(156)   write(88);
L670:
        LD    A,88
L671:
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
        LD    A,89
L679:
        CALL  writeA
L680:
        ;;test11.j(163)   write(90);
L681:
        LD    A,90
L682:
        CALL  writeA
L683:
        ;;test11.j(164)   // byte - integer
L684:
        ;;test11.j(165)   //TODO
L685:
        ;;test11.j(166)   write(91);
L686:
        LD    A,91
L687:
        CALL  writeA
L688:
        ;;test11.j(167)   write(92);
L689:
        LD    A,92
L690:
        CALL  writeA
L691:
        ;;test11.j(168)   // integer - byte
L692:
        ;;test11.j(169)   //TODO
L693:
        ;;test11.j(170)   write(93);
L694:
        LD    A,93
L695:
        CALL  writeA
L696:
        ;;test11.j(171)   write(94);
L697:
        LD    A,94
L698:
        CALL  writeA
L699:
        ;;test11.j(172)   // integer - integer
L700:
        ;;test11.j(173)   //TODO
L701:
        ;;test11.j(174)   write(95);
L702:
        LD    A,95
L703:
        CALL  writeA
L704:
        ;;test11.j(175)   write(96);
L705:
        LD    A,96
L706:
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
        LD    A,97
L713:
        LD    (05001H),A
L714:
        ;;test11.j(181)   for (byte b = 96; b <= 97; b++) { write (b2); b2++; }
L715:
        LD    A,96
L716:
        LD    (05006H),A
L717:
        LD    A,(05006H)
L718:
        SUB   A,97
L719:
        JR    Z,$+5
        JP    C,L731
L720:
        JP    L723
L721:
        LD    HL,(05006H)
        INC   (HL)
L722:
        JP    L717
L723:
        LD    A,(05001H)
L724:
        CALL  writeA
L725:
        LD    HL,(05001H)
        INC   (HL)
L726:
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
        LD    A,92
L732:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L733:
        LD    HL,(05006H)
L734:
        LD    A,93
L735:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L736:
        JR    Z,$+5
        JP    C,L746
L737:
        JP    L740
L738:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L739:
        JP    L733
L740:
        LD    A,(05001H)
L741:
        CALL  writeA
L742:
        LD    HL,(05001H)
        INC   (HL)
L743:
        JP    L738
L744:
        ;;test11.j(186)   // integer - integer
L745:
        ;;test11.j(187)   for(word i = 1090; i <= 1091; i++) { write (b2); b2++; }
L746:
        LD    HL,1090
L747:
        LD    (05006H),HL
L748:
        LD    HL,(05006H)
L749:
        LD    DE,1091
        OR    A
        SBC   HL,DE
L750:
        JR    Z,$+5
        JP    C,L763
L751:
        JP    L754
L752:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L753:
        JP    L748
L754:
        LD    A,(05001H)
L755:
        CALL  writeA
L756:
        LD    HL,(05001H)
        INC   (HL)
L757:
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
        LD    A,104
L764:
        LD    (05006H),A
L765:
        LD    A,105
L766:
        ADD   A,0
L767:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L768:
        JP    C,L778
L769:
        JP    L772
L770:
        LD    HL,(05006H)
        INC   (HL)
L771:
        JP    L765
L772:
        LD    A,(05001H)
L773:
        CALL  writeA
L774:
        LD    HL,(05001H)
        INC   (HL)
L775:
        JP    L770
L776:
        ;;test11.j(193)   // byte - integer
L777:
        ;;test11.j(194)   i2=103;
L778:
        LD    A,103
L779:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L780:
        ;;test11.j(195)   for (byte b = 102; b <= i2+0; b++) { write (b2); b2++; }
L781:
        LD    A,102
L782:
        LD    (05006H),A
L783:
        LD    HL,(05002H)
L784:
        LD    DE,0
        ADD   HL,DE
L785:
        LD    A,(05006H)
L786:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L787:
        JR    Z,$+5
        JP    C,L797
L788:
        JP    L791
L789:
        LD    HL,(05006H)
        INC   (HL)
L790:
        JP    L783
L791:
        LD    A,(05001H)
L792:
        CALL  writeA
L793:
        LD    HL,(05001H)
        INC   (HL)
L794:
        JP    L789
L795:
        ;;test11.j(196)   // integer - byte
L796:
        ;;test11.j(197)   for(word i = 100; i <= 101+0; i++) { write (b2); b2++; }
L797:
        LD    A,100
L798:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L799:
        LD    A,101
L800:
        ADD   A,0
L801:
        LD    HL,(05006H)
L802:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L803:
        JR    Z,$+5
        JP    C,L813
L804:
        JP    L807
L805:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L806:
        JP    L799
L807:
        LD    A,(05001H)
L808:
        CALL  writeA
L809:
        LD    HL,(05001H)
        INC   (HL)
L810:
        JP    L805
L811:
        ;;test11.j(198)   // integer - integer
L812:
        ;;test11.j(199)   for(word i = 1098; i <= 1099+0; i++) { write (b2); b2++; }
L813:
        LD    HL,1098
L814:
        LD    (05006H),HL
L815:
        LD    HL,1099
L816:
        LD    DE,0
        ADD   HL,DE
L817:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L818:
        JP    C,L831
L819:
        JP    L822
L820:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L821:
        JP    L815
L822:
        LD    A,(05001H)
L823:
        CALL  writeA
L824:
        LD    HL,(05001H)
        INC   (HL)
L825:
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
        LD    A,112
L832:
        LD    (05006H),A
L833:
        LD    A,(05001H)
L834:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L835:
        JR    Z,$+5
        JP    C,L845
L836:
        JP    L839
L837:
        LD    HL,(05006H)
        DEC   (HL)
L838:
        JP    L833
L839:
        LD    A,(05001H)
L840:
        CALL  writeA
L841:
        LD    HL,(05001H)
        INC   (HL)
L842:
        JP    L837
L843:
        ;;test11.j(205)   // byte - integer
L844:
        ;;test11.j(206)   for(word i = 116; b2 <= i; i--) { write (b2); b2++; }
L845:
        LD    A,116
L846:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L847:
        LD    A,(05001H)
L848:
        LD    HL,(05006H)
L849:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L850:
        JR    Z,$+5
        JP    C,L860
L851:
        JP    L854
L852:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L853:
        JP    L847
L854:
        LD    A,(05001H)
L855:
        CALL  writeA
L856:
        LD    HL,(05001H)
        INC   (HL)
L857:
        JP    L852
L858:
        ;;test11.j(207)   // integer - byte
L859:
        ;;test11.j(208)   i2=b2;
L860:
        LD    A,(05001H)
L861:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L862:
        ;;test11.j(209)   for (byte b = 118; i2 <= b; b--) { write (b2); b2++; }
L863:
        LD    A,118
L864:
        LD    (05006H),A
L865:
        LD    HL,(05002H)
L866:
        LD    A,(05006H)
L867:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L868:
        JR    Z,$+5
        JP    C,L878
L869:
        JP    L872
L870:
        LD    HL,(05006H)
        DEC   (HL)
L871:
        JP    L865
L872:
        LD    A,(05001H)
L873:
        CALL  writeA
L874:
        LD    HL,(05001H)
        INC   (HL)
L875:
        JP    L870
L876:
        ;;test11.j(210)   // integer - integer
L877:
        ;;test11.j(211)   i2=120;
L878:
        LD    A,120
L879:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L880:
        ;;test11.j(212)   for(word i = b2+4; i2 <= i; i--) { write (b2); b2++; }
L881:
        LD    A,(05001H)
L882:
        ADD   A,4
L883:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L884:
        LD    HL,(05002H)
L885:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L886:
        JR    Z,$+5
        JP    C,L928
L887:
        JP    L890
L888:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L889:
        JP    L884
L890:
        LD    A,(05001H)
L891:
        CALL  writeA
L892:
        LD    HL,(05001H)
        INC   (HL)
L893:
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
        LD    HL,932
L929:
        CALL  putStr
L930:
        ;;test11.j(247) }
L931:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L932:
        .ASCIZ  "Klaar."
