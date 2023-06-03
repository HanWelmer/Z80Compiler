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
        ;;test2.j(0) /* Program to test branch instructions */
L1:
        ;;test2.j(1) class TestBranches {
L2:
        ;;test2.j(2)   word i = 2000;
L3:
        LD    HL,2000
L4:
        LD    (05000H),HL
L5:
        ;;test2.j(3)   word i1 = 1000;
L6:
        LD    HL,1000
L7:
        LD    (05002H),HL
L8:
        ;;test2.j(4)   word i3 = 3000;
L9:
        LD    HL,3000
L10:
        LD    (05004H),HL
L11:
        ;;test2.j(5)   byte b = 20;
L12:
        LD    A,20
L13:
        LD    (05006H),A
L14:
        ;;test2.j(6)   byte b1 = 10;
L15:
        LD    A,10
L16:
        LD    (05007H),A
L17:
        ;;test2.j(7)   byte b3 = 30;
L18:
        LD    A,30
L19:
        LD    (05008H),A
L20:
        ;;test2.j(8) 
L21:
        ;;test2.j(9)   /*Possible operand types: 
L22:
        ;;test2.j(10)    * constant, acc, var, stack8, stack16
L23:
        ;;test2.j(11)    *Possible datatype combinations:
L24:
        ;;test2.j(12)    * byte - byte
L25:
        ;;test2.j(13)    * byte - integer
L26:
        ;;test2.j(14)    * integer - byte
L27:
        ;;test2.j(15)    * integer - integer
L28:
        ;;test2.j(16)   */
L29:
        ;;test2.j(17) 
L30:
        ;;test2.j(18)   println(0);
L31:
        LD    A,0
L32:
        CALL  writeA
L33:
        ;;test2.j(19) 
L34:
        ;;test2.j(20)   /************************/
L35:
        ;;test2.j(21)   // constant - constant
L36:
        ;;test2.j(22)   // byte - byte
L37:
        ;;test2.j(23)   if (1 == 1) println(1); else println(999);
L38:
        LD    A,1
L39:
        SUB   A,1
L40:
        JP    NZ,L44
L41:
        LD    A,1
L42:
        CALL  writeA
L43:
        JP    L47
L44:
        LD    HL,999
L45:
        CALL  writeHL
L46:
        ;;test2.j(24)   if (1 != 0) println(2); else println(999);
L47:
        LD    A,1
L48:
        SUB   A,0
L49:
        JP    Z,L53
L50:
        LD    A,2
L51:
        CALL  writeA
L52:
        JP    L56
L53:
        LD    HL,999
L54:
        CALL  writeHL
L55:
        ;;test2.j(25)   if (1 >  0) println(3); else println(999);
L56:
        LD    A,1
L57:
        SUB   A,0
L58:
        JP    Z,L62
L59:
        LD    A,3
L60:
        CALL  writeA
L61:
        JP    L65
L62:
        LD    HL,999
L63:
        CALL  writeHL
L64:
        ;;test2.j(26)   if (1 >= 0) println(4); else println(999);
L65:
        LD    A,1
L66:
        SUB   A,0
L67:
        JP    C,L71
L68:
        LD    A,4
L69:
        CALL  writeA
L70:
        JP    L74
L71:
        LD    HL,999
L72:
        CALL  writeHL
L73:
        ;;test2.j(27)   if (1 >= 1) println(5); else println(999);
L74:
        LD    A,1
L75:
        SUB   A,1
L76:
        JP    C,L80
L77:
        LD    A,5
L78:
        CALL  writeA
L79:
        JP    L83
L80:
        LD    HL,999
L81:
        CALL  writeHL
L82:
        ;;test2.j(28)   if (1 <  2) println(6); else println(999);
L83:
        LD    A,1
L84:
        SUB   A,2
L85:
        JP    NC,L89
L86:
        LD    A,6
L87:
        CALL  writeA
L88:
        JP    L92
L89:
        LD    HL,999
L90:
        CALL  writeHL
L91:
        ;;test2.j(29)   if (1 <= 2) println(7); else println(999);
L92:
        LD    A,1
L93:
        SUB   A,2
L94:
        JR    Z,$+5
        JP    C,L98
L95:
        LD    A,7
L96:
        CALL  writeA
L97:
        JP    L101
L98:
        LD    HL,999
L99:
        CALL  writeHL
L100:
        ;;test2.j(30)   if (1 <= 1) println(8); else println(999);
L101:
        LD    A,1
L102:
        SUB   A,1
L103:
        JR    Z,$+5
        JP    C,L107
L104:
        LD    A,8
L105:
        CALL  writeA
L106:
        JP    L110
L107:
        LD    HL,999
L108:
        CALL  writeHL
L109:
        ;;test2.j(31)   println(9);
L110:
        LD    A,9
L111:
        CALL  writeA
L112:
        ;;test2.j(32) 
L113:
        ;;test2.j(33)   // constant - constant
L114:
        ;;test2.j(34)   // byte - integer
L115:
        ;;test2.j(35)   if (1 == 1000) println(999); else println(10);
L116:
        LD    A,1
L117:
        LD    HL,1000
L118:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L119:
        JP    NZ,L123
L120:
        LD    HL,999
L121:
        CALL  writeHL
L122:
        JP    L126
L123:
        LD    A,10
L124:
        CALL  writeA
L125:
        ;;test2.j(36)   if (1 != 1000) println(11);  else println(999);
L126:
        LD    A,1
L127:
        LD    HL,1000
L128:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L129:
        JP    Z,L133
L130:
        LD    A,11
L131:
        CALL  writeA
L132:
        JP    L136
L133:
        LD    HL,999
L134:
        CALL  writeHL
L135:
        ;;test2.j(37)   if (1 >  1000) println(999); else println(12);
L136:
        LD    A,1
L137:
        LD    HL,1000
L138:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L139:
        JP    Z,L143
L140:
        LD    HL,999
L141:
        CALL  writeHL
L142:
        JP    L146
L143:
        LD    A,12
L144:
        CALL  writeA
L145:
        ;;test2.j(38)   if (1 >= 1000) println(999); else println(13);
L146:
        LD    A,1
L147:
        LD    HL,1000
L148:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L149:
        JP    C,L153
L150:
        LD    HL,999
L151:
        CALL  writeHL
L152:
        JP    L156
L153:
        LD    A,13
L154:
        CALL  writeA
L155:
        ;;test2.j(39)   if (1 >= 1000) println(999); else println(14);
L156:
        LD    A,1
L157:
        LD    HL,1000
L158:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L159:
        JP    C,L163
L160:
        LD    HL,999
L161:
        CALL  writeHL
L162:
        JP    L166
L163:
        LD    A,14
L164:
        CALL  writeA
L165:
        ;;test2.j(40)   if (1 <  2000) println(15);  else println(999);
L166:
        LD    A,1
L167:
        LD    HL,2000
L168:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L169:
        JP    NC,L173
L170:
        LD    A,15
L171:
        CALL  writeA
L172:
        JP    L176
L173:
        LD    HL,999
L174:
        CALL  writeHL
L175:
        ;;test2.j(41)   if (1 <= 2000) println(16);  else println(999);
L176:
        LD    A,1
L177:
        LD    HL,2000
L178:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L179:
        JR    Z,$+5
        JP    C,L183
L180:
        LD    A,16
L181:
        CALL  writeA
L182:
        JP    L186
L183:
        LD    HL,999
L184:
        CALL  writeHL
L185:
        ;;test2.j(42)   if (1 <= 1000) println(17);  else println(999);
L186:
        LD    A,1
L187:
        LD    HL,1000
L188:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L189:
        JR    Z,$+5
        JP    C,L193
L190:
        LD    A,17
L191:
        CALL  writeA
L192:
        JP    L196
L193:
        LD    HL,999
L194:
        CALL  writeHL
L195:
        ;;test2.j(43)   println(18);
L196:
        LD    A,18
L197:
        CALL  writeA
L198:
        ;;test2.j(44)   println(19);
L199:
        LD    A,19
L200:
        CALL  writeA
L201:
        ;;test2.j(45) 
L202:
        ;;test2.j(46)   // constant - constant
L203:
        ;;test2.j(47)   // integer - byte
L204:
        ;;test2.j(48)   if (1000 == 1) println(999); else println(20);
L205:
        LD    HL,1000
L206:
        LD    A,1
L207:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L208:
        JP    NZ,L212
L209:
        LD    HL,999
L210:
        CALL  writeHL
L211:
        JP    L215
L212:
        LD    A,20
L213:
        CALL  writeA
L214:
        ;;test2.j(49)   if (1000 != 0) println(21);  else println(999);
L215:
        LD    HL,1000
L216:
        LD    A,0
L217:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L218:
        JP    Z,L222
L219:
        LD    A,21
L220:
        CALL  writeA
L221:
        JP    L225
L222:
        LD    HL,999
L223:
        CALL  writeHL
L224:
        ;;test2.j(50)   if (1000 >  0) println(22);  else println(999);
L225:
        LD    HL,1000
L226:
        LD    A,0
L227:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L228:
        JP    Z,L232
L229:
        LD    A,22
L230:
        CALL  writeA
L231:
        JP    L235
L232:
        LD    HL,999
L233:
        CALL  writeHL
L234:
        ;;test2.j(51)   if (1000 >= 0) println(23);  else println(999);
L235:
        LD    HL,1000
L236:
        LD    A,0
L237:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L238:
        JP    C,L242
L239:
        LD    A,23
L240:
        CALL  writeA
L241:
        JP    L245
L242:
        LD    HL,999
L243:
        CALL  writeHL
L244:
        ;;test2.j(52)   if (1000 >= 1) println(24);  else println(999);
L245:
        LD    HL,1000
L246:
        LD    A,1
L247:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L248:
        JP    C,L252
L249:
        LD    A,24
L250:
        CALL  writeA
L251:
        JP    L255
L252:
        LD    HL,999
L253:
        CALL  writeHL
L254:
        ;;test2.j(53)   if (1 <  2000) println(25);  else println(999);
L255:
        LD    A,1
L256:
        LD    HL,2000
L257:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L258:
        JP    NC,L262
L259:
        LD    A,25
L260:
        CALL  writeA
L261:
        JP    L265
L262:
        LD    HL,999
L263:
        CALL  writeHL
L264:
        ;;test2.j(54)   if (1 <= 2000) println(26);  else println(999);
L265:
        LD    A,1
L266:
        LD    HL,2000
L267:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L268:
        JR    Z,$+5
        JP    C,L272
L269:
        LD    A,26
L270:
        CALL  writeA
L271:
        JP    L275
L272:
        LD    HL,999
L273:
        CALL  writeHL
L274:
        ;;test2.j(55)   if (1 <= 1000) println(27);  else println(999);
L275:
        LD    A,1
L276:
        LD    HL,1000
L277:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L278:
        JR    Z,$+5
        JP    C,L282
L279:
        LD    A,27
L280:
        CALL  writeA
L281:
        JP    L285
L282:
        LD    HL,999
L283:
        CALL  writeHL
L284:
        ;;test2.j(56)   println(28);
L285:
        LD    A,28
L286:
        CALL  writeA
L287:
        ;;test2.j(57)   println(29);
L288:
        LD    A,29
L289:
        CALL  writeA
L290:
        ;;test2.j(58) 
L291:
        ;;test2.j(59)   // constant - constant
L292:
        ;;test2.j(60)   // integer - integer
L293:
        ;;test2.j(61)   if (1000 == 1000) println(30); else println(999);
L294:
        LD    HL,1000
L295:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L296:
        JP    NZ,L300
L297:
        LD    A,30
L298:
        CALL  writeA
L299:
        JP    L303
L300:
        LD    HL,999
L301:
        CALL  writeHL
L302:
        ;;test2.j(62)   if (1000 != 2000) println(31); else println(999);
L303:
        LD    HL,1000
L304:
        LD    DE,2000
        OR    A
        SBC   HL,DE
L305:
        JP    Z,L309
L306:
        LD    A,31
L307:
        CALL  writeA
L308:
        JP    L312
L309:
        LD    HL,999
L310:
        CALL  writeHL
L311:
        ;;test2.j(63)   if (2000 >  1000) println(32); else println(999);
L312:
        LD    HL,2000
L313:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L314:
        JP    Z,L318
L315:
        LD    A,32
L316:
        CALL  writeA
L317:
        JP    L321
L318:
        LD    HL,999
L319:
        CALL  writeHL
L320:
        ;;test2.j(64)   if (2000 >= 1000) println(33); else println(999);
L321:
        LD    HL,2000
L322:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L323:
        JP    C,L327
L324:
        LD    A,33
L325:
        CALL  writeA
L326:
        JP    L330
L327:
        LD    HL,999
L328:
        CALL  writeHL
L329:
        ;;test2.j(65)   if (1000 >= 1000) println(34); else println(999);
L330:
        LD    HL,1000
L331:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L332:
        JP    C,L336
L333:
        LD    A,34
L334:
        CALL  writeA
L335:
        JP    L339
L336:
        LD    HL,999
L337:
        CALL  writeHL
L338:
        ;;test2.j(66)   if (1000 <  2000) println(35); else println(999);
L339:
        LD    HL,1000
L340:
        LD    DE,2000
        OR    A
        SBC   HL,DE
L341:
        JP    NC,L345
L342:
        LD    A,35
L343:
        CALL  writeA
L344:
        JP    L348
L345:
        LD    HL,999
L346:
        CALL  writeHL
L347:
        ;;test2.j(67)   if (1000 <= 2000) println(36); else println(999);
L348:
        LD    HL,1000
L349:
        LD    DE,2000
        OR    A
        SBC   HL,DE
L350:
        JR    Z,$+5
        JP    C,L354
L351:
        LD    A,36
L352:
        CALL  writeA
L353:
        JP    L357
L354:
        LD    HL,999
L355:
        CALL  writeHL
L356:
        ;;test2.j(68)   if (1000 <= 1000) println(37); else println(999);
L357:
        LD    HL,1000
L358:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L359:
        JR    Z,$+5
        JP    C,L363
L360:
        LD    A,37
L361:
        CALL  writeA
L362:
        JP    L366
L363:
        LD    HL,999
L364:
        CALL  writeHL
L365:
        ;;test2.j(69)   println(38);
L366:
        LD    A,38
L367:
        CALL  writeA
L368:
        ;;test2.j(70)   println(39);
L369:
        LD    A,39
L370:
        CALL  writeA
L371:
        ;;test2.j(71) 
L372:
        ;;test2.j(72)   /************************/
L373:
        ;;test2.j(73)   // constant - acc
L374:
        ;;test2.j(74)   // byte - byte
L375:
        ;;test2.j(75)   if (1 > 0+0) println(40); else println(999);
L376:
        LD    A,0
L377:
        ADD   A,0
L378:
        SUB   A,1
L379:
        JP    NC,L383
L380:
        LD    A,40
L381:
        CALL  writeA
L382:
        JP    L386
L383:
        LD    HL,999
L384:
        CALL  writeHL
L385:
        ;;test2.j(76)   if (1 < 2+0) println(41); else println(999);
L386:
        LD    A,2
L387:
        ADD   A,0
L388:
        SUB   A,1
L389:
        JP    Z,L393
L390:
        LD    A,41
L391:
        CALL  writeA
L392:
        JP    L398
L393:
        LD    HL,999
L394:
        CALL  writeHL
L395:
        ;;test2.j(77)   // constant - acc
L396:
        ;;test2.j(78)   // byte - integer
L397:
        ;;test2.j(79)   if (1 > 1000+0) println(999); else println(42);
L398:
        LD    HL,1000
L399:
        LD    DE,0
        ADD   HL,DE
L400:
        LD    A,1
L401:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L402:
        JP    Z,L406
L403:
        LD    HL,999
L404:
        CALL  writeHL
L405:
        JP    L409
L406:
        LD    A,42
L407:
        CALL  writeA
L408:
        ;;test2.j(80)   if (1 < 1000+0) println(43);  else println(999);
L409:
        LD    HL,1000
L410:
        LD    DE,0
        ADD   HL,DE
L411:
        LD    A,1
L412:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L413:
        JP    NC,L417
L414:
        LD    A,43
L415:
        CALL  writeA
L416:
        JP    L422
L417:
        LD    HL,999
L418:
        CALL  writeHL
L419:
        ;;test2.j(81)   // constant - acc
L420:
        ;;test2.j(82)   // integer - byte
L421:
        ;;test2.j(83)   if (1000 > 0+0) println(44);  else println(999);
L422:
        LD    A,0
L423:
        ADD   A,0
L424:
        LD    HL,1000
L425:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L426:
        JP    Z,L430
L427:
        LD    A,44
L428:
        CALL  writeA
L429:
        JP    L433
L430:
        LD    HL,999
L431:
        CALL  writeHL
L432:
        ;;test2.j(84)   if (1000 < 0+0) println(999); else println(45);
L433:
        LD    A,0
L434:
        ADD   A,0
L435:
        LD    HL,1000
L436:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L437:
        JP    NC,L441
L438:
        LD    HL,999
L439:
        CALL  writeHL
L440:
        JP    L446
L441:
        LD    A,45
L442:
        CALL  writeA
L443:
        ;;test2.j(85)   // constant - acc
L444:
        ;;test2.j(86)   // integer - integer
L445:
        ;;test2.j(87)   if (2000 > 1000+0) println(46); else println(999);
L446:
        LD    HL,1000
L447:
        LD    DE,0
        ADD   HL,DE
L448:
        LD    DE,2000
        OR    A
        SBC   HL,DE
L449:
        JP    NC,L453
L450:
        LD    A,46
L451:
        CALL  writeA
L452:
        JP    L456
L453:
        LD    HL,999
L454:
        CALL  writeHL
L455:
        ;;test2.j(88)   if (1000 < 2000+0) println(47); else println(999);
L456:
        LD    HL,2000
L457:
        LD    DE,0
        ADD   HL,DE
L458:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L459:
        JP    Z,L463
L460:
        LD    A,47
L461:
        CALL  writeA
L462:
        JP    L466
L463:
        LD    HL,999
L464:
        CALL  writeHL
L465:
        ;;test2.j(89)   println(48);
L466:
        LD    A,48
L467:
        CALL  writeA
L468:
        ;;test2.j(90)   println(49);
L469:
        LD    A,49
L470:
        CALL  writeA
L471:
        ;;test2.j(91) 
L472:
        ;;test2.j(92)   /************************/
L473:
        ;;test2.j(93)   // constant - var
L474:
        ;;test2.j(94)   // byte - byte
L475:
        ;;test2.j(95)   if (30 > b) println(50); else println(999);
L476:
        LD    A,(05006H)
L477:
        SUB   A,30
L478:
        JP    NC,L482
L479:
        LD    A,50
L480:
        CALL  writeA
L481:
        JP    L485
L482:
        LD    HL,999
L483:
        CALL  writeHL
L484:
        ;;test2.j(96)   if (10 < b) println(51); else println(999);
L485:
        LD    A,(05006H)
L486:
        SUB   A,10
L487:
        JP    Z,L491
L488:
        LD    A,51
L489:
        CALL  writeA
L490:
        JP    L496
L491:
        LD    HL,999
L492:
        CALL  writeHL
L493:
        ;;test2.j(97)   // constant - var
L494:
        ;;test2.j(98)   // byte - integer
L495:
        ;;test2.j(99)   if (30 > i) println(999); else println(52);
L496:
        LD    HL,(05000H)
L497:
        LD    A,30
L498:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L499:
        JP    Z,L503
L500:
        LD    HL,999
L501:
        CALL  writeHL
L502:
        JP    L506
L503:
        LD    A,52
L504:
        CALL  writeA
L505:
        ;;test2.j(100)   if (10 < i) println(53); else println(999);
L506:
        LD    HL,(05000H)
L507:
        LD    A,10
L508:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L509:
        JP    NC,L513
L510:
        LD    A,53
L511:
        CALL  writeA
L512:
        JP    L518
L513:
        LD    HL,999
L514:
        CALL  writeHL
L515:
        ;;test2.j(101)   // constant - var
L516:
        ;;test2.j(102)   // integer - byte
L517:
        ;;test2.j(103)   if (3000 > b) println(54); else println(999);
L518:
        LD    A,(05006H)
L519:
        LD    HL,3000
L520:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L521:
        JP    Z,L525
L522:
        LD    A,54
L523:
        CALL  writeA
L524:
        JP    L528
L525:
        LD    HL,999
L526:
        CALL  writeHL
L527:
        ;;test2.j(104)   if (1000 < b) println(999); else println(55);
L528:
        LD    A,(05006H)
L529:
        LD    HL,1000
L530:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L531:
        JP    NC,L535
L532:
        LD    HL,999
L533:
        CALL  writeHL
L534:
        JP    L540
L535:
        LD    A,55
L536:
        CALL  writeA
L537:
        ;;test2.j(105)   // constant - var
L538:
        ;;test2.j(106)   // integer - integer
L539:
        ;;test2.j(107)   if (3000 > i) println(56); else println(999);
L540:
        LD    HL,(05000H)
L541:
        LD    DE,3000
        OR    A
        SBC   HL,DE
L542:
        JP    NC,L546
L543:
        LD    A,56
L544:
        CALL  writeA
L545:
        JP    L549
L546:
        LD    HL,999
L547:
        CALL  writeHL
L548:
        ;;test2.j(108)   if (1000 < i) println(57); else println(999);
L549:
        LD    HL,(05000H)
L550:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L551:
        JP    Z,L555
L552:
        LD    A,57
L553:
        CALL  writeA
L554:
        JP    L558
L555:
        LD    HL,999
L556:
        CALL  writeHL
L557:
        ;;test2.j(109)   println(58);
L558:
        LD    A,58
L559:
        CALL  writeA
L560:
        ;;test2.j(110)   println(59);
L561:
        LD    A,59
L562:
        CALL  writeA
L563:
        ;;test2.j(111) 
L564:
        ;;test2.j(112)   /************************/
L565:
        ;;test2.j(113)   // constant - stack8
L566:
        ;;test2.j(114)   // byte - byte
L567:
        ;;test2.j(115)   println(60);
L568:
        LD    A,60
L569:
        CALL  writeA
L570:
        ;;test2.j(116)   println(61);
L571:
        LD    A,61
L572:
        CALL  writeA
L573:
        ;;test2.j(117)   // constant - stack8
L574:
        ;;test2.j(118)   // byte - integer
L575:
        ;;test2.j(119)   println(62);
L576:
        LD    A,62
L577:
        CALL  writeA
L578:
        ;;test2.j(120)   println(63);
L579:
        LD    A,63
L580:
        CALL  writeA
L581:
        ;;test2.j(121)   // constant - stack8
L582:
        ;;test2.j(122)   // integer - byte
L583:
        ;;test2.j(123)   println(64);
L584:
        LD    A,64
L585:
        CALL  writeA
L586:
        ;;test2.j(124)   println(65);
L587:
        LD    A,65
L588:
        CALL  writeA
L589:
        ;;test2.j(125)   // constant - stack8
L590:
        ;;test2.j(126)   // integer - integer
L591:
        ;;test2.j(127)   println(66);
L592:
        LD    A,66
L593:
        CALL  writeA
L594:
        ;;test2.j(128)   println(67);
L595:
        LD    A,67
L596:
        CALL  writeA
L597:
        ;;test2.j(129)   println(68);
L598:
        LD    A,68
L599:
        CALL  writeA
L600:
        ;;test2.j(130)   println(69);
L601:
        LD    A,69
L602:
        CALL  writeA
L603:
        ;;test2.j(131) 
L604:
        ;;test2.j(132)   /************************/
L605:
        ;;test2.j(133)   // constant - stack16
L606:
        ;;test2.j(134)   // byte - byte
L607:
        ;;test2.j(135)   println(70);
L608:
        LD    A,70
L609:
        CALL  writeA
L610:
        ;;test2.j(136)   println(71);
L611:
        LD    A,71
L612:
        CALL  writeA
L613:
        ;;test2.j(137)   // constant - stack16
L614:
        ;;test2.j(138)   // byte - integer
L615:
        ;;test2.j(139)   println(72);
L616:
        LD    A,72
L617:
        CALL  writeA
L618:
        ;;test2.j(140)   println(73);
L619:
        LD    A,73
L620:
        CALL  writeA
L621:
        ;;test2.j(141)   // constant - stack16
L622:
        ;;test2.j(142)   // integer - byte
L623:
        ;;test2.j(143)   println(74);
L624:
        LD    A,74
L625:
        CALL  writeA
L626:
        ;;test2.j(144)   println(75);
L627:
        LD    A,75
L628:
        CALL  writeA
L629:
        ;;test2.j(145)   // constant - stack16
L630:
        ;;test2.j(146)   // integer - integer
L631:
        ;;test2.j(147)   println(76);
L632:
        LD    A,76
L633:
        CALL  writeA
L634:
        ;;test2.j(148)   println(77);
L635:
        LD    A,77
L636:
        CALL  writeA
L637:
        ;;test2.j(149)   println(78);
L638:
        LD    A,78
L639:
        CALL  writeA
L640:
        ;;test2.j(150)   println(79);
L641:
        LD    A,79
L642:
        CALL  writeA
L643:
        ;;test2.j(151) 
L644:
        ;;test2.j(152)   /************************/
L645:
        ;;test2.j(153)   // acc - constant
L646:
        ;;test2.j(154)   // byte - byte
L647:
        ;;test2.j(155)   if (30+0 > 20) println(80); else println(999);
L648:
        LD    A,30
L649:
        ADD   A,0
L650:
        SUB   A,20
L651:
        JP    Z,L655
L652:
        LD    A,80
L653:
        CALL  writeA
L654:
        JP    L658
L655:
        LD    HL,999
L656:
        CALL  writeHL
L657:
        ;;test2.j(156)   if (10+0 < 20) println(81); else println(999);
L658:
        LD    A,10
L659:
        ADD   A,0
L660:
        SUB   A,20
L661:
        JP    NC,L665
L662:
        LD    A,81
L663:
        CALL  writeA
L664:
        JP    L670
L665:
        LD    HL,999
L666:
        CALL  writeHL
L667:
        ;;test2.j(157)   // acc - constant
L668:
        ;;test2.j(158)   // byte - integer
L669:
        ;;test2.j(159)   if (30+0 > 2000) println(999); else println(82);
L670:
        LD    A,30
L671:
        ADD   A,0
L672:
        LD    HL,2000
L673:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L674:
        JP    Z,L678
L675:
        LD    HL,999
L676:
        CALL  writeHL
L677:
        JP    L681
L678:
        LD    A,82
L679:
        CALL  writeA
L680:
        ;;test2.j(160)   if (10+0 < 2000) println(83); else println(999);
L681:
        LD    A,10
L682:
        ADD   A,0
L683:
        LD    HL,2000
L684:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L685:
        JP    NC,L689
L686:
        LD    A,83
L687:
        CALL  writeA
L688:
        JP    L694
L689:
        LD    HL,999
L690:
        CALL  writeHL
L691:
        ;;test2.j(161)   // acc - constant
L692:
        ;;test2.j(162)   // integer - byte
L693:
        ;;test2.j(163)   if (3000+0 > 20) println(84); else println(999);
L694:
        LD    HL,3000
L695:
        LD    DE,0
        ADD   HL,DE
L696:
        LD    A,20
L697:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L698:
        JP    Z,L702
L699:
        LD    A,84
L700:
        CALL  writeA
L701:
        JP    L705
L702:
        LD    HL,999
L703:
        CALL  writeHL
L704:
        ;;test2.j(164)   if (1000+0 < 20) println(999); else println(85);
L705:
        LD    HL,1000
L706:
        LD    DE,0
        ADD   HL,DE
L707:
        LD    A,20
L708:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L709:
        JP    NC,L713
L710:
        LD    HL,999
L711:
        CALL  writeHL
L712:
        JP    L718
L713:
        LD    A,85
L714:
        CALL  writeA
L715:
        ;;test2.j(165)   // acc - constant
L716:
        ;;test2.j(166)   // integer - integer
L717:
        ;;test2.j(167)   if (3000+0 > 2000) println(86); else println(999);
L718:
        LD    HL,3000
L719:
        LD    DE,0
        ADD   HL,DE
L720:
        LD    DE,2000
        OR    A
        SBC   HL,DE
L721:
        JP    Z,L725
L722:
        LD    A,86
L723:
        CALL  writeA
L724:
        JP    L728
L725:
        LD    HL,999
L726:
        CALL  writeHL
L727:
        ;;test2.j(168)   if (1000+0 < 2000) println(87); else println(999);
L728:
        LD    HL,1000
L729:
        LD    DE,0
        ADD   HL,DE
L730:
        LD    DE,2000
        OR    A
        SBC   HL,DE
L731:
        JP    NC,L735
L732:
        LD    A,87
L733:
        CALL  writeA
L734:
        JP    L738
L735:
        LD    HL,999
L736:
        CALL  writeHL
L737:
        ;;test2.j(169)   println(88);
L738:
        LD    A,88
L739:
        CALL  writeA
L740:
        ;;test2.j(170)   println(89);
L741:
        LD    A,89
L742:
        CALL  writeA
L743:
        ;;test2.j(171) 
L744:
        ;;test2.j(172)   /************************/
L745:
        ;;test2.j(173)   // acc - acc
L746:
        ;;test2.j(174)   // byte - byte
L747:
        ;;test2.j(175)   if (30+0 > 20+0) println(90); else println(999);
L748:
        LD    A,30
L749:
        ADD   A,0
L750:
        PUSH AF
L751:
        LD    A,20
L752:
        ADD   A,0
L753:
        POP   BC
        SUB   A,B
L754:
        JP    NC,L758
L755:
        LD    A,90
L756:
        CALL  writeA
L757:
        JP    L761
L758:
        LD    HL,999
L759:
        CALL  writeHL
L760:
        ;;test2.j(176)   if (10+0 < 20+0) println(91); else println(999);
L761:
        LD    A,10
L762:
        ADD   A,0
L763:
        PUSH AF
L764:
        LD    A,20
L765:
        ADD   A,0
L766:
        POP   BC
        SUB   A,B
L767:
        JP    Z,L771
L768:
        LD    A,91
L769:
        CALL  writeA
L770:
        JP    L776
L771:
        LD    HL,999
L772:
        CALL  writeHL
L773:
        ;;test2.j(177)   // acc - acc
L774:
        ;;test2.j(178)   // byte - integer
L775:
        ;;test2.j(179)   if (30+0 > 2000+0) println(999); else println(92);
L776:
        LD    A,30
L777:
        ADD   A,0
L778:
        PUSH AF
L779:
        LD    HL,2000
L780:
        LD    DE,0
        ADD   HL,DE
L781:
        POP  AF
L782:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L783:
        JP    Z,L787
L784:
        LD    HL,999
L785:
        CALL  writeHL
L786:
        JP    L790
L787:
        LD    A,92
L788:
        CALL  writeA
L789:
        ;;test2.j(180)   if (10+0 < 2000+0) println(93); else println(999);
L790:
        LD    A,10
L791:
        ADD   A,0
L792:
        PUSH AF
L793:
        LD    HL,2000
L794:
        LD    DE,0
        ADD   HL,DE
L795:
        POP  AF
L796:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L797:
        JP    NC,L801
L798:
        LD    A,93
L799:
        CALL  writeA
L800:
        JP    L806
L801:
        LD    HL,999
L802:
        CALL  writeHL
L803:
        ;;test2.j(181)   // acc - acc
L804:
        ;;test2.j(182)   // integer - byte
L805:
        ;;test2.j(183)   if (3000+0 > 20+0) println(94); else println(999);
L806:
        LD    HL,3000
L807:
        LD    DE,0
        ADD   HL,DE
L808:
        PUSH HL
L809:
        LD    A,20
L810:
        ADD   A,0
L811:
        POP  HL
L812:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L813:
        JP    Z,L817
L814:
        LD    A,94
L815:
        CALL  writeA
L816:
        JP    L820
L817:
        LD    HL,999
L818:
        CALL  writeHL
L819:
        ;;test2.j(184)   if (1000+0 < 20+0) println(999); else println(95);
L820:
        LD    HL,1000
L821:
        LD    DE,0
        ADD   HL,DE
L822:
        PUSH HL
L823:
        LD    A,20
L824:
        ADD   A,0
L825:
        POP  HL
L826:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L827:
        JP    NC,L831
L828:
        LD    HL,999
L829:
        CALL  writeHL
L830:
        JP    L836
L831:
        LD    A,95
L832:
        CALL  writeA
L833:
        ;;test2.j(185)   // acc - acc
L834:
        ;;test2.j(186)   // integer - integer
L835:
        ;;test2.j(187)   if (3000+0 > 2000+0) println(96); else println(999);
L836:
        LD    HL,3000
L837:
        LD    DE,0
        ADD   HL,DE
L838:
        PUSH HL
L839:
        LD    HL,2000
L840:
        LD    DE,0
        ADD   HL,DE
L841:
        POP   DE
        OR    A
        SBC   HL,DE
L842:
        JP    NC,L846
L843:
        LD    A,96
L844:
        CALL  writeA
L845:
        JP    L849
L846:
        LD    HL,999
L847:
        CALL  writeHL
L848:
        ;;test2.j(188)   if (1000+0 < 2000+0) println(97); else println(999);
L849:
        LD    HL,1000
L850:
        LD    DE,0
        ADD   HL,DE
L851:
        PUSH HL
L852:
        LD    HL,2000
L853:
        LD    DE,0
        ADD   HL,DE
L854:
        POP   DE
        OR    A
        SBC   HL,DE
L855:
        JP    Z,L859
L856:
        LD    A,97
L857:
        CALL  writeA
L858:
        JP    L862
L859:
        LD    HL,999
L860:
        CALL  writeHL
L861:
        ;;test2.j(189)   println(98);
L862:
        LD    A,98
L863:
        CALL  writeA
L864:
        ;;test2.j(190)   println(99);
L865:
        LD    A,99
L866:
        CALL  writeA
L867:
        ;;test2.j(191) 
L868:
        ;;test2.j(192)   /************************/
L869:
        ;;test2.j(193)   // acc - var
L870:
        ;;test2.j(194)   // byte - byte
L871:
        ;;test2.j(195)   if (30+0 > b) println(100); else println(999);
L872:
        LD    A,30
L873:
        ADD   A,0
L874:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L875:
        JP    Z,L879
L876:
        LD    A,100
L877:
        CALL  writeA
L878:
        JP    L882
L879:
        LD    HL,999
L880:
        CALL  writeHL
L881:
        ;;test2.j(196)   if (10+0 < b) println(101); else println(999);
L882:
        LD    A,10
L883:
        ADD   A,0
L884:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L885:
        JP    NC,L889
L886:
        LD    A,101
L887:
        CALL  writeA
L888:
        JP    L894
L889:
        LD    HL,999
L890:
        CALL  writeHL
L891:
        ;;test2.j(197)   // acc - var
L892:
        ;;test2.j(198)   // byte - integer
L893:
        ;;test2.j(199)   if (30+0 > i) println(999); else println(102);
L894:
        LD    A,30
L895:
        ADD   A,0
L896:
        LD    HL,(05000H)
L897:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L898:
        JP    Z,L902
L899:
        LD    HL,999
L900:
        CALL  writeHL
L901:
        JP    L905
L902:
        LD    A,102
L903:
        CALL  writeA
L904:
        ;;test2.j(200)   if (10+0 < i) println(103); else println(999);
L905:
        LD    A,10
L906:
        ADD   A,0
L907:
        LD    HL,(05000H)
L908:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L909:
        JP    NC,L913
L910:
        LD    A,103
L911:
        CALL  writeA
L912:
        JP    L918
L913:
        LD    HL,999
L914:
        CALL  writeHL
L915:
        ;;test2.j(201)   // acc - var
L916:
        ;;test2.j(202)   // integer - byte
L917:
        ;;test2.j(203)   if (3000+0 > b) println(104); else println(999);
L918:
        LD    HL,3000
L919:
        LD    DE,0
        ADD   HL,DE
L920:
        LD    A,(05006H)
L921:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L922:
        JP    Z,L926
L923:
        LD    A,104
L924:
        CALL  writeA
L925:
        JP    L929
L926:
        LD    HL,999
L927:
        CALL  writeHL
L928:
        ;;test2.j(204)   if (1000+0 < b) println(999); else println(105);
L929:
        LD    HL,1000
L930:
        LD    DE,0
        ADD   HL,DE
L931:
        LD    A,(05006H)
L932:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L933:
        JP    NC,L937
L934:
        LD    HL,999
L935:
        CALL  writeHL
L936:
        JP    L942
L937:
        LD    A,105
L938:
        CALL  writeA
L939:
        ;;test2.j(205)   // acc - var
L940:
        ;;test2.j(206)   // integer - integer
L941:
        ;;test2.j(207)   if (3000+0 > i) println(106); else println(999);
L942:
        LD    HL,3000
L943:
        LD    DE,0
        ADD   HL,DE
L944:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L945:
        JP    Z,L949
L946:
        LD    A,106
L947:
        CALL  writeA
L948:
        JP    L952
L949:
        LD    HL,999
L950:
        CALL  writeHL
L951:
        ;;test2.j(208)   if (1000+0 < i) println(107); else println(999);
L952:
        LD    HL,1000
L953:
        LD    DE,0
        ADD   HL,DE
L954:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L955:
        JP    NC,L959
L956:
        LD    A,107
L957:
        CALL  writeA
L958:
        JP    L962
L959:
        LD    HL,999
L960:
        CALL  writeHL
L961:
        ;;test2.j(209)   println(108);
L962:
        LD    A,108
L963:
        CALL  writeA
L964:
        ;;test2.j(210)   println(109);
L965:
        LD    A,109
L966:
        CALL  writeA
L967:
        ;;test2.j(211) 
L968:
        ;;test2.j(212)   /************************/
L969:
        ;;test2.j(213)   // acc - stack8
L970:
        ;;test2.j(214)   // byte - byte
L971:
        ;;test2.j(215)   println(110);
L972:
        LD    A,110
L973:
        CALL  writeA
L974:
        ;;test2.j(216)   println(111);
L975:
        LD    A,111
L976:
        CALL  writeA
L977:
        ;;test2.j(217)   // acc - stack8
L978:
        ;;test2.j(218)   // byte - integer
L979:
        ;;test2.j(219)   println(112);
L980:
        LD    A,112
L981:
        CALL  writeA
L982:
        ;;test2.j(220)   println(113);
L983:
        LD    A,113
L984:
        CALL  writeA
L985:
        ;;test2.j(221)   // acc - stack8
L986:
        ;;test2.j(222)   // integer - byte
L987:
        ;;test2.j(223)   println(114);
L988:
        LD    A,114
L989:
        CALL  writeA
L990:
        ;;test2.j(224)   println(115);
L991:
        LD    A,115
L992:
        CALL  writeA
L993:
        ;;test2.j(225)   // acc - stack8
L994:
        ;;test2.j(226)   // integer - integer
L995:
        ;;test2.j(227)   println(116);
L996:
        LD    A,116
L997:
        CALL  writeA
L998:
        ;;test2.j(228)   println(117);
L999:
        LD    A,117
L1000:
        CALL  writeA
L1001:
        ;;test2.j(229)   println(118);
L1002:
        LD    A,118
L1003:
        CALL  writeA
L1004:
        ;;test2.j(230)   println(119);
L1005:
        LD    A,119
L1006:
        CALL  writeA
L1007:
        ;;test2.j(231) 
L1008:
        ;;test2.j(232)   /************************/
L1009:
        ;;test2.j(233)   // acc - stack16
L1010:
        ;;test2.j(234)   // byte - byte
L1011:
        ;;test2.j(235)   println(120);
L1012:
        LD    A,120
L1013:
        CALL  writeA
L1014:
        ;;test2.j(236)   println(121);
L1015:
        LD    A,121
L1016:
        CALL  writeA
L1017:
        ;;test2.j(237)   // acc - stack16
L1018:
        ;;test2.j(238)   // byte - integer
L1019:
        ;;test2.j(239)   println(122);
L1020:
        LD    A,122
L1021:
        CALL  writeA
L1022:
        ;;test2.j(240)   println(123);
L1023:
        LD    A,123
L1024:
        CALL  writeA
L1025:
        ;;test2.j(241)   // acc - stack16
L1026:
        ;;test2.j(242)   // integer - byte
L1027:
        ;;test2.j(243)   println(124);
L1028:
        LD    A,124
L1029:
        CALL  writeA
L1030:
        ;;test2.j(244)   println(125);
L1031:
        LD    A,125
L1032:
        CALL  writeA
L1033:
        ;;test2.j(245)   // acc - stack16
L1034:
        ;;test2.j(246)   // integer - integer
L1035:
        ;;test2.j(247)   println(126);
L1036:
        LD    A,126
L1037:
        CALL  writeA
L1038:
        ;;test2.j(248)   println(127);
L1039:
        LD    A,127
L1040:
        CALL  writeA
L1041:
        ;;test2.j(249)   println(128);
L1042:
        LD    A,128
L1043:
        CALL  writeA
L1044:
        ;;test2.j(250)   println(129);
L1045:
        LD    A,129
L1046:
        CALL  writeA
L1047:
        ;;test2.j(251) 
L1048:
        ;;test2.j(252)   /************************/
L1049:
        ;;test2.j(253)   // var - constant
L1050:
        ;;test2.j(254)   // byte - byte
L1051:
        ;;test2.j(255)   if (b > 10) println(130); else println(999);
L1052:
        LD    A,(05006H)
L1053:
        SUB   A,10
L1054:
        JP    Z,L1058
L1055:
        LD    A,130
L1056:
        CALL  writeA
L1057:
        JP    L1061
L1058:
        LD    HL,999
L1059:
        CALL  writeHL
L1060:
        ;;test2.j(256)   if (b < 30) println(131); else println(999);
L1061:
        LD    A,(05006H)
L1062:
        SUB   A,30
L1063:
        JP    NC,L1067
L1064:
        LD    A,131
L1065:
        CALL  writeA
L1066:
        JP    L1072
L1067:
        LD    HL,999
L1068:
        CALL  writeHL
L1069:
        ;;test2.j(257)   // var - constant
L1070:
        ;;test2.j(258)   // byte - integer
L1071:
        ;;test2.j(259)   if (b > 1000) println(999); else println(132);
L1072:
        LD    A,(05006H)
L1073:
        LD    HL,1000
L1074:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1075:
        JP    Z,L1079
L1076:
        LD    HL,999
L1077:
        CALL  writeHL
L1078:
        JP    L1082
L1079:
        LD    A,132
L1080:
        CALL  writeA
L1081:
        ;;test2.j(260)   if (b < 1000) println(133); else println(999);
L1082:
        LD    A,(05006H)
L1083:
        LD    HL,1000
L1084:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1085:
        JP    NC,L1089
L1086:
        LD    A,133
L1087:
        CALL  writeA
L1088:
        JP    L1094
L1089:
        LD    HL,999
L1090:
        CALL  writeHL
L1091:
        ;;test2.j(261)   // var - constant
L1092:
        ;;test2.j(262)   // integer - byte
L1093:
        ;;test2.j(263)   if (i > 1000) println(134); else println(999);
L1094:
        LD    HL,(05000H)
L1095:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L1096:
        JP    Z,L1100
L1097:
        LD    A,134
L1098:
        CALL  writeA
L1099:
        JP    L1103
L1100:
        LD    HL,999
L1101:
        CALL  writeHL
L1102:
        ;;test2.j(264)   if (i < 3000) println(135); else println(999);
L1103:
        LD    HL,(05000H)
L1104:
        LD    DE,3000
        OR    A
        SBC   HL,DE
L1105:
        JP    NC,L1109
L1106:
        LD    A,135
L1107:
        CALL  writeA
L1108:
        JP    L1114
L1109:
        LD    HL,999
L1110:
        CALL  writeHL
L1111:
        ;;test2.j(265)   // var - constant
L1112:
        ;;test2.j(266)   // integer - integer
L1113:
        ;;test2.j(267)   if (i > 1000) println(136); else println(999);
L1114:
        LD    HL,(05000H)
L1115:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L1116:
        JP    Z,L1120
L1117:
        LD    A,136
L1118:
        CALL  writeA
L1119:
        JP    L1123
L1120:
        LD    HL,999
L1121:
        CALL  writeHL
L1122:
        ;;test2.j(268)   if (i < 3000) println(137); else println(999);
L1123:
        LD    HL,(05000H)
L1124:
        LD    DE,3000
        OR    A
        SBC   HL,DE
L1125:
        JP    NC,L1129
L1126:
        LD    A,137
L1127:
        CALL  writeA
L1128:
        JP    L1132
L1129:
        LD    HL,999
L1130:
        CALL  writeHL
L1131:
        ;;test2.j(269)   println(138);
L1132:
        LD    A,138
L1133:
        CALL  writeA
L1134:
        ;;test2.j(270)   println(139);
L1135:
        LD    A,139
L1136:
        CALL  writeA
L1137:
        ;;test2.j(271) 
L1138:
        ;;test2.j(272)   /************************/
L1139:
        ;;test2.j(273)   // var - acc
L1140:
        ;;test2.j(274)   // byte - byte
L1141:
        ;;test2.j(275)   if (b > 10+0) println(140); else println(999);
L1142:
        LD    A,10
L1143:
        ADD   A,0
L1144:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L1145:
        JP    NC,L1149
L1146:
        LD    A,140
L1147:
        CALL  writeA
L1148:
        JP    L1152
L1149:
        LD    HL,999
L1150:
        CALL  writeHL
L1151:
        ;;test2.j(276)   if (b < 30+0) println(141); else println(999);
L1152:
        LD    A,30
L1153:
        ADD   A,0
L1154:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L1155:
        JP    Z,L1159
L1156:
        LD    A,141
L1157:
        CALL  writeA
L1158:
        JP    L1164
L1159:
        LD    HL,999
L1160:
        CALL  writeHL
L1161:
        ;;test2.j(277)   // var - acc
L1162:
        ;;test2.j(278)   // byte - integer
L1163:
        ;;test2.j(279)   if (b > 1000+0) println(999); else println(142);
L1164:
        LD    HL,1000
L1165:
        LD    DE,0
        ADD   HL,DE
L1166:
        LD    A,(05006H)
L1167:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1168:
        JP    Z,L1172
L1169:
        LD    HL,999
L1170:
        CALL  writeHL
L1171:
        JP    L1175
L1172:
        LD    A,142
L1173:
        CALL  writeA
L1174:
        ;;test2.j(280)   if (b < 1000+0) println(143); else println(999);
L1175:
        LD    HL,1000
L1176:
        LD    DE,0
        ADD   HL,DE
L1177:
        LD    A,(05006H)
L1178:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1179:
        JP    NC,L1183
L1180:
        LD    A,143
L1181:
        CALL  writeA
L1182:
        JP    L1188
L1183:
        LD    HL,999
L1184:
        CALL  writeHL
L1185:
        ;;test2.j(281)   // var - acc
L1186:
        ;;test2.j(282)   // integer - byte
L1187:
        ;;test2.j(283)   if (i > 1000+0) println(144); else println(999);
L1188:
        LD    HL,1000
L1189:
        LD    DE,0
        ADD   HL,DE
L1190:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L1191:
        JP    NC,L1195
L1192:
        LD    A,144
L1193:
        CALL  writeA
L1194:
        JP    L1198
L1195:
        LD    HL,999
L1196:
        CALL  writeHL
L1197:
        ;;test2.j(284)   if (i < 3000+0) println(145); else println(999);
L1198:
        LD    HL,3000
L1199:
        LD    DE,0
        ADD   HL,DE
L1200:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L1201:
        JP    Z,L1205
L1202:
        LD    A,145
L1203:
        CALL  writeA
L1204:
        JP    L1210
L1205:
        LD    HL,999
L1206:
        CALL  writeHL
L1207:
        ;;test2.j(285)   // var - acc
L1208:
        ;;test2.j(286)   // integer - integer
L1209:
        ;;test2.j(287)   if (i > 1000+0) println(146); else println(999);
L1210:
        LD    HL,1000
L1211:
        LD    DE,0
        ADD   HL,DE
L1212:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L1213:
        JP    NC,L1217
L1214:
        LD    A,146
L1215:
        CALL  writeA
L1216:
        JP    L1220
L1217:
        LD    HL,999
L1218:
        CALL  writeHL
L1219:
        ;;test2.j(288)   if (i < 3000+0) println(147); else println(999);
L1220:
        LD    HL,3000
L1221:
        LD    DE,0
        ADD   HL,DE
L1222:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L1223:
        JP    Z,L1227
L1224:
        LD    A,147
L1225:
        CALL  writeA
L1226:
        JP    L1230
L1227:
        LD    HL,999
L1228:
        CALL  writeHL
L1229:
        ;;test2.j(289)   println(148);
L1230:
        LD    A,148
L1231:
        CALL  writeA
L1232:
        ;;test2.j(290)   println(149);
L1233:
        LD    A,149
L1234:
        CALL  writeA
L1235:
        ;;test2.j(291) 
L1236:
        ;;test2.j(292)   /************************/
L1237:
        ;;test2.j(293)   // var - var
L1238:
        ;;test2.j(294)   // byte - byte
L1239:
        ;;test2.j(295)   if (b > b1) println(150);
L1240:
        LD    A,(05006H)
L1241:
        LD    B,A
        LD    A,(05007H)
        SUB   A,B
L1242:
        JP    Z,L1246
L1243:
        LD    A,150
L1244:
        CALL  writeA
L1245:
        ;;test2.j(296)   if (b < b3) println(151);
L1246:
        LD    A,(05006H)
L1247:
        LD    B,A
        LD    A,(05008H)
        SUB   A,B
L1248:
        JP    NC,L1254
L1249:
        LD    A,151
L1250:
        CALL  writeA
L1251:
        ;;test2.j(297)   // var - var
L1252:
        ;;test2.j(298)   // byte - integer
L1253:
        ;;test2.j(299)   if (b > i1) println(999); else println(152);
L1254:
        LD    A,(05006H)
L1255:
        LD    HL,(05002H)
L1256:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1257:
        JP    Z,L1261
L1258:
        LD    HL,999
L1259:
        CALL  writeHL
L1260:
        JP    L1264
L1261:
        LD    A,152
L1262:
        CALL  writeA
L1263:
        ;;test2.j(300)   if (b < i3) println(153);
L1264:
        LD    A,(05006H)
L1265:
        LD    HL,(05004H)
L1266:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1267:
        JP    NC,L1273
L1268:
        LD    A,153
L1269:
        CALL  writeA
L1270:
        ;;test2.j(301)   // var - var
L1271:
        ;;test2.j(302)   // integer - byte
L1272:
        ;;test2.j(303)   if (i > i1) println(154);
L1273:
        LD    HL,(05000H)
L1274:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L1275:
        JP    Z,L1279
L1276:
        LD    A,154
L1277:
        CALL  writeA
L1278:
        ;;test2.j(304)   if (i < i3) println(155);
L1279:
        LD    HL,(05000H)
L1280:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L1281:
        JP    NC,L1287
L1282:
        LD    A,155
L1283:
        CALL  writeA
L1284:
        ;;test2.j(305)   // var - var
L1285:
        ;;test2.j(306)   // integer - integer
L1286:
        ;;test2.j(307)   if (i > i1) println(156);
L1287:
        LD    HL,(05000H)
L1288:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L1289:
        JP    Z,L1293
L1290:
        LD    A,156
L1291:
        CALL  writeA
L1292:
        ;;test2.j(308)   if (i < i3) println(157);
L1293:
        LD    HL,(05000H)
L1294:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L1295:
        JP    NC,L1299
L1296:
        LD    A,157
L1297:
        CALL  writeA
L1298:
        ;;test2.j(309)   println(158);
L1299:
        LD    A,158
L1300:
        CALL  writeA
L1301:
        ;;test2.j(310)   println(159);
L1302:
        LD    A,159
L1303:
        CALL  writeA
L1304:
        ;;test2.j(311) 
L1305:
        ;;test2.j(312)   /************************/
L1306:
        ;;test2.j(313)   // var - stack8
L1307:
        ;;test2.j(314)   // byte - byte
L1308:
        ;;test2.j(315) 
L1309:
        ;;test2.j(316)   // var - stack8
L1310:
        ;;test2.j(317)   // byte - integer
L1311:
        ;;test2.j(318) 
L1312:
        ;;test2.j(319)   // var - stack8
L1313:
        ;;test2.j(320)   // integer - byte 
L1314:
        ;;test2.j(321) 
L1315:
        ;;test2.j(322)   // var - stack8
L1316:
        ;;test2.j(323)   // integer - integer
L1317:
        ;;test2.j(324) 
L1318:
        ;;test2.j(325)   /************************/
L1319:
        ;;test2.j(326)   // var - stack16
L1320:
        ;;test2.j(327)   // byte - byte
L1321:
        ;;test2.j(328) 
L1322:
        ;;test2.j(329)   // var - stack16
L1323:
        ;;test2.j(330)   // byte - integer
L1324:
        ;;test2.j(331) 
L1325:
        ;;test2.j(332)   // var - stack16
L1326:
        ;;test2.j(333)   // integer - byte
L1327:
        ;;test2.j(334) 
L1328:
        ;;test2.j(335)   // var - stack16
L1329:
        ;;test2.j(336)   // integer - integer
L1330:
        ;;test2.j(337) 
L1331:
        ;;test2.j(338)   /************************/
L1332:
        ;;test2.j(339)   // stack8 - constant
L1333:
        ;;test2.j(340)   // stack8 - acc
L1334:
        ;;test2.j(341)   // stack8 - var
L1335:
        ;;test2.j(342)   // stack8 - stack8
L1336:
        ;;test2.j(343)   // stack8 - stack16
L1337:
        ;;test2.j(344) 
L1338:
        ;;test2.j(345)   /************************/
L1339:
        ;;test2.j(346)   // stack16 - constant
L1340:
        ;;test2.j(347)   // stack16 - acc
L1341:
        ;;test2.j(348)   // stack16 - var
L1342:
        ;;test2.j(349)   // stack16 - stack8
L1343:
        ;;test2.j(350)   // stack16 - stack16
L1344:
        ;;test2.j(351) 
L1345:
        ;;test2.j(352)   println("Klaar");
L1346:
        LD    HL,1350
L1347:
        CALL  putStr
L1348:
        ;;test2.j(353) }
L1349:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L1350:
        .ASCIZ  "Klaar"
