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
        ;;test5.j(5)   word zero = 0;
L6:
        ;acc8= constant 0
        LD    A,0
L7:
        ;acc8=> variable 0
        LD    L,A
        LD    H,0
        LD    (05000H),HL
L8:
        ;;test5.j(6)   word one = 1;
L9:
        ;acc8= constant 1
        LD    A,1
L10:
        ;acc8=> variable 2
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L11:
        ;;test5.j(7)   word three = 3;
L12:
        ;acc8= constant 3
        LD    A,3
L13:
        ;acc8=> variable 4
        LD    L,A
        LD    H,0
        LD    (05004H),HL
L14:
        ;;test5.j(8)   word four = 4;
L15:
        ;acc8= constant 4
        LD    A,4
L16:
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L17:
        ;;test5.j(9)   word five = 5;
L18:
        ;acc8= constant 5
        LD    A,5
L19:
        ;acc8=> variable 8
        LD    L,A
        LD    H,0
        LD    (05008H),HL
L20:
        ;;test5.j(10)   word twelve = 12;
L21:
        ;acc8= constant 12
        LD    A,12
L22:
        ;acc8=> variable 10
        LD    L,A
        LD    H,0
        LD    (0500AH),HL
L23:
        ;;test5.j(11)   byte byteOne = 1;
L24:
        ;acc8= constant 1
        LD    A,1
L25:
        ;acc8=> variable 12
        LD    (0500CH),A
L26:
        ;;test5.j(12)   byte byteSix = 262;
L27:
        ;acc16= constant 262
        LD    HL,262
L28:
        ;acc16=> variable 13
        LD    A,L
        LD    (0500DH),A
L29:
        ;;test5.j(13) 
L30:
        ;;test5.j(14)   //stack level 1
L31:
        ;;test5.j(15)   //byte-byte
L32:
        ;;test5.j(16)   if (4 == 12/(1+2)) write(0);
L33:
        ;acc8= constant 12
        LD    A,12
L34:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L35:
        ;acc8+ constant 2
        ADD   A,2
L36:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L37:
        ;acc8Comp constant 4
        SUB   A,4
L38:
        ;brne 42
        JP    NZ,L42
L39:
        ;acc8= constant 0
        LD    A,0
L40:
        ;call writeAcc8
        CALL  writeA
L41:
        ;;test5.j(17)   if (4 == 4) write(1);
L42:
        ;acc8= constant 4
        LD    A,4
L43:
        ;acc8Comp constant 4
        SUB   A,4
L44:
        ;brne 48
        JP    NZ,L48
L45:
        ;acc8= constant 1
        LD    A,1
L46:
        ;call writeAcc8
        CALL  writeA
L47:
        ;;test5.j(18)   if (3 != 12/(1+2)) write(2);
L48:
        ;acc8= constant 12
        LD    A,12
L49:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L50:
        ;acc8+ constant 2
        ADD   A,2
L51:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L52:
        ;acc8Comp constant 3
        SUB   A,3
L53:
        ;breq 57
        JP    Z,L57
L54:
        ;acc8= constant 2
        LD    A,2
L55:
        ;call writeAcc8
        CALL  writeA
L56:
        ;;test5.j(19)   if (3 != 4) write(3);
L57:
        ;acc8= constant 3
        LD    A,3
L58:
        ;acc8Comp constant 4
        SUB   A,4
L59:
        ;breq 63
        JP    Z,L63
L60:
        ;acc8= constant 3
        LD    A,3
L61:
        ;call writeAcc8
        CALL  writeA
L62:
        ;;test5.j(20)   if (3 < 12/(1+2)) write(4);
L63:
        ;acc8= constant 12
        LD    A,12
L64:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L65:
        ;acc8+ constant 2
        ADD   A,2
L66:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L67:
        ;acc8Comp constant 3
        SUB   A,3
L68:
        ;brle 72
        JP    Z,L72
L69:
        ;acc8= constant 4
        LD    A,4
L70:
        ;call writeAcc8
        CALL  writeA
L71:
        ;;test5.j(21)   if (3 < 4) write(5);
L72:
        ;acc8= constant 3
        LD    A,3
L73:
        ;acc8Comp constant 4
        SUB   A,4
L74:
        ;brge 78
        JP    NC,L78
L75:
        ;acc8= constant 5
        LD    A,5
L76:
        ;call writeAcc8
        CALL  writeA
L77:
        ;;test5.j(22)   if (5 > 12/(1+2)) write(6);
L78:
        ;acc8= constant 12
        LD    A,12
L79:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L80:
        ;acc8+ constant 2
        ADD   A,2
L81:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L82:
        ;acc8Comp constant 5
        SUB   A,5
L83:
        ;brge 87
        JP    NC,L87
L84:
        ;acc8= constant 6
        LD    A,6
L85:
        ;call writeAcc8
        CALL  writeA
L86:
        ;;test5.j(23)   if (5 > 4) write(7);
L87:
        ;acc8= constant 5
        LD    A,5
L88:
        ;acc8Comp constant 4
        SUB   A,4
L89:
        ;brle 93
        JP    Z,L93
L90:
        ;acc8= constant 7
        LD    A,7
L91:
        ;call writeAcc8
        CALL  writeA
L92:
        ;;test5.j(24)   if (3 <= 12/(1+2)) write(8);
L93:
        ;acc8= constant 12
        LD    A,12
L94:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L95:
        ;acc8+ constant 2
        ADD   A,2
L96:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L97:
        ;acc8Comp constant 3
        SUB   A,3
L98:
        ;brlt 102
        JP    C,L102
L99:
        ;acc8= constant 8
        LD    A,8
L100:
        ;call writeAcc8
        CALL  writeA
L101:
        ;;test5.j(25)   if (3 <= 4) write(9);
L102:
        ;acc8= constant 3
        LD    A,3
L103:
        ;acc8Comp constant 4
        SUB   A,4
L104:
        ;brgt 108
        JR    Z,$+5
        JP    C,L108
L105:
        ;acc8= constant 9
        LD    A,9
L106:
        ;call writeAcc8
        CALL  writeA
L107:
        ;;test5.j(26)   if (4 <= 12/(1+2)) write(10);
L108:
        ;acc8= constant 12
        LD    A,12
L109:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L110:
        ;acc8+ constant 2
        ADD   A,2
L111:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L112:
        ;acc8Comp constant 4
        SUB   A,4
L113:
        ;brlt 117
        JP    C,L117
L114:
        ;acc8= constant 10
        LD    A,10
L115:
        ;call writeAcc8
        CALL  writeA
L116:
        ;;test5.j(27)   if (4 <= 4) write(11);
L117:
        ;acc8= constant 4
        LD    A,4
L118:
        ;acc8Comp constant 4
        SUB   A,4
L119:
        ;brgt 123
        JR    Z,$+5
        JP    C,L123
L120:
        ;acc8= constant 11
        LD    A,11
L121:
        ;call writeAcc8
        CALL  writeA
L122:
        ;;test5.j(28)   if (5 >= 12/(1+2)) write(12);
L123:
        ;acc8= constant 12
        LD    A,12
L124:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L125:
        ;acc8+ constant 2
        ADD   A,2
L126:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L127:
        ;acc8Comp constant 5
        SUB   A,5
L128:
        ;brgt 132
        JR    Z,$+5
        JP    C,L132
L129:
        ;acc8= constant 12
        LD    A,12
L130:
        ;call writeAcc8
        CALL  writeA
L131:
        ;;test5.j(29)   if (5 >= 4) write(13);
L132:
        ;acc8= constant 5
        LD    A,5
L133:
        ;acc8Comp constant 4
        SUB   A,4
L134:
        ;brlt 138
        JP    C,L138
L135:
        ;acc8= constant 13
        LD    A,13
L136:
        ;call writeAcc8
        CALL  writeA
L137:
        ;;test5.j(30)   if (4 >= 12/(1+2)) write(14);
L138:
        ;acc8= constant 12
        LD    A,12
L139:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L140:
        ;acc8+ constant 2
        ADD   A,2
L141:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L142:
        ;acc8Comp constant 4
        SUB   A,4
L143:
        ;brgt 147
        JR    Z,$+5
        JP    C,L147
L144:
        ;acc8= constant 14
        LD    A,14
L145:
        ;call writeAcc8
        CALL  writeA
L146:
        ;;test5.j(31)   if (4 >= 4) write(15);
L147:
        ;acc8= constant 4
        LD    A,4
L148:
        ;acc8Comp constant 4
        SUB   A,4
L149:
        ;brlt 155
        JP    C,L155
L150:
        ;acc8= constant 15
        LD    A,15
L151:
        ;call writeAcc8
        CALL  writeA
L152:
        ;;test5.j(32)   //stack level 1
L153:
        ;;test5.j(33)   //byte-integer
L154:
        ;;test5.j(34)   if (4 == twelve/(1+2)) write(16);
L155:
        ;acc16= variable 10
        LD    HL,(0500AH)
L156:
        ;acc8= constant 1
        LD    A,1
L157:
        ;acc8+ constant 2
        ADD   A,2
L158:
        ;acc16/ acc8
        CALL  div16_8
L159:
        ;acc8= constant 4
        LD    A,4
L160:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L161:
        ;brne 165
        JP    NZ,L165
L162:
        ;acc8= constant 16
        LD    A,16
L163:
        ;call writeAcc8
        CALL  writeA
L164:
        ;;test5.j(35)   if (4 == four) write(17);
L165:
        ;acc16= variable 6
        LD    HL,(05006H)
L166:
        ;acc8= constant 4
        LD    A,4
L167:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L168:
        ;brne 172
        JP    NZ,L172
L169:
        ;acc8= constant 17
        LD    A,17
L170:
        ;call writeAcc8
        CALL  writeA
L171:
        ;;test5.j(36)   if (3 != twelve/(1+2)) write(18);
L172:
        ;acc16= variable 10
        LD    HL,(0500AH)
L173:
        ;acc8= constant 1
        LD    A,1
L174:
        ;acc8+ constant 2
        ADD   A,2
L175:
        ;acc16/ acc8
        CALL  div16_8
L176:
        ;acc8= constant 3
        LD    A,3
L177:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L178:
        ;breq 182
        JP    Z,L182
L179:
        ;acc8= constant 18
        LD    A,18
L180:
        ;call writeAcc8
        CALL  writeA
L181:
        ;;test5.j(37)   if (3 != four) write(19);
L182:
        ;acc16= variable 6
        LD    HL,(05006H)
L183:
        ;acc8= constant 3
        LD    A,3
L184:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L185:
        ;breq 189
        JP    Z,L189
L186:
        ;acc8= constant 19
        LD    A,19
L187:
        ;call writeAcc8
        CALL  writeA
L188:
        ;;test5.j(38)   if (3 < twelve/(1+2)) write(20);
L189:
        ;acc16= variable 10
        LD    HL,(0500AH)
L190:
        ;acc8= constant 1
        LD    A,1
L191:
        ;acc8+ constant 2
        ADD   A,2
L192:
        ;acc16/ acc8
        CALL  div16_8
L193:
        ;acc8= constant 3
        LD    A,3
L194:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L195:
        ;brge 199
        JP    NC,L199
L196:
        ;acc8= constant 20
        LD    A,20
L197:
        ;call writeAcc8
        CALL  writeA
L198:
        ;;test5.j(39)   if (3 < four) write(21);
L199:
        ;acc16= variable 6
        LD    HL,(05006H)
L200:
        ;acc8= constant 3
        LD    A,3
L201:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L202:
        ;brge 206
        JP    NC,L206
L203:
        ;acc8= constant 21
        LD    A,21
L204:
        ;call writeAcc8
        CALL  writeA
L205:
        ;;test5.j(40)   if (5 > twelve/(1+2)) write(22);
L206:
        ;acc16= variable 10
        LD    HL,(0500AH)
L207:
        ;acc8= constant 1
        LD    A,1
L208:
        ;acc8+ constant 2
        ADD   A,2
L209:
        ;acc16/ acc8
        CALL  div16_8
L210:
        ;acc8= constant 5
        LD    A,5
L211:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L212:
        ;brle 216
        JP    Z,L216
L213:
        ;acc8= constant 22
        LD    A,22
L214:
        ;call writeAcc8
        CALL  writeA
L215:
        ;;test5.j(41)   if (5 > four) write(23);
L216:
        ;acc16= variable 6
        LD    HL,(05006H)
L217:
        ;acc8= constant 5
        LD    A,5
L218:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L219:
        ;brle 223
        JP    Z,L223
L220:
        ;acc8= constant 23
        LD    A,23
L221:
        ;call writeAcc8
        CALL  writeA
L222:
        ;;test5.j(42)   if (3 <= twelve/(1+2)) write(24);
L223:
        ;acc16= variable 10
        LD    HL,(0500AH)
L224:
        ;acc8= constant 1
        LD    A,1
L225:
        ;acc8+ constant 2
        ADD   A,2
L226:
        ;acc16/ acc8
        CALL  div16_8
L227:
        ;acc8= constant 3
        LD    A,3
L228:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L229:
        ;brgt 233
        JR    Z,$+5
        JP    C,L233
L230:
        ;acc8= constant 24
        LD    A,24
L231:
        ;call writeAcc8
        CALL  writeA
L232:
        ;;test5.j(43)   if (3 <= four) write(25);
L233:
        ;acc16= variable 6
        LD    HL,(05006H)
L234:
        ;acc8= constant 3
        LD    A,3
L235:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L236:
        ;brgt 240
        JR    Z,$+5
        JP    C,L240
L237:
        ;acc8= constant 25
        LD    A,25
L238:
        ;call writeAcc8
        CALL  writeA
L239:
        ;;test5.j(44)   if (4 <= twelve/(1+2)) write(26);
L240:
        ;acc16= variable 10
        LD    HL,(0500AH)
L241:
        ;acc8= constant 1
        LD    A,1
L242:
        ;acc8+ constant 2
        ADD   A,2
L243:
        ;acc16/ acc8
        CALL  div16_8
L244:
        ;acc8= constant 4
        LD    A,4
L245:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L246:
        ;brgt 250
        JR    Z,$+5
        JP    C,L250
L247:
        ;acc8= constant 26
        LD    A,26
L248:
        ;call writeAcc8
        CALL  writeA
L249:
        ;;test5.j(45)   if (4 <= four) write(27);
L250:
        ;acc16= variable 6
        LD    HL,(05006H)
L251:
        ;acc8= constant 4
        LD    A,4
L252:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L253:
        ;brgt 257
        JR    Z,$+5
        JP    C,L257
L254:
        ;acc8= constant 27
        LD    A,27
L255:
        ;call writeAcc8
        CALL  writeA
L256:
        ;;test5.j(46)   if (5 >= twelve/(1+2)) write(28);
L257:
        ;acc16= variable 10
        LD    HL,(0500AH)
L258:
        ;acc8= constant 1
        LD    A,1
L259:
        ;acc8+ constant 2
        ADD   A,2
L260:
        ;acc16/ acc8
        CALL  div16_8
L261:
        ;acc8= constant 5
        LD    A,5
L262:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L263:
        ;brlt 267
        JP    C,L267
L264:
        ;acc8= constant 28
        LD    A,28
L265:
        ;call writeAcc8
        CALL  writeA
L266:
        ;;test5.j(47)   if (5 >= four) write(29);
L267:
        ;acc16= variable 6
        LD    HL,(05006H)
L268:
        ;acc8= constant 5
        LD    A,5
L269:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L270:
        ;brlt 274
        JP    C,L274
L271:
        ;acc8= constant 29
        LD    A,29
L272:
        ;call writeAcc8
        CALL  writeA
L273:
        ;;test5.j(48)   if (4 >= twelve/(1+2)) write(30);
L274:
        ;acc16= variable 10
        LD    HL,(0500AH)
L275:
        ;acc8= constant 1
        LD    A,1
L276:
        ;acc8+ constant 2
        ADD   A,2
L277:
        ;acc16/ acc8
        CALL  div16_8
L278:
        ;acc8= constant 4
        LD    A,4
L279:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L280:
        ;brlt 284
        JP    C,L284
L281:
        ;acc8= constant 30
        LD    A,30
L282:
        ;call writeAcc8
        CALL  writeA
L283:
        ;;test5.j(49)   if (4 >= four) write(31);
L284:
        ;acc16= variable 6
        LD    HL,(05006H)
L285:
        ;acc8= constant 4
        LD    A,4
L286:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L287:
        ;brlt 293
        JP    C,L293
L288:
        ;acc8= constant 31
        LD    A,31
L289:
        ;call writeAcc8
        CALL  writeA
L290:
        ;;test5.j(50)   //stack level 1
L291:
        ;;test5.j(51)   //integer-byte
L292:
        ;;test5.j(52)   if (four == 12/(1+2)) write(32);
L293:
        ;acc8= constant 12
        LD    A,12
L294:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L295:
        ;acc8+ constant 2
        ADD   A,2
L296:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L297:
        ;acc16= variable 6
        LD    HL,(05006H)
L298:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L299:
        ;brne 303
        JP    NZ,L303
L300:
        ;acc8= constant 32
        LD    A,32
L301:
        ;call writeAcc8
        CALL  writeA
L302:
        ;;test5.j(53)   if (four == 4) write(33);
L303:
        ;acc16= variable 6
        LD    HL,(05006H)
L304:
        ;acc8= constant 4
        LD    A,4
L305:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L306:
        ;brne 310
        JP    NZ,L310
L307:
        ;acc8= constant 33
        LD    A,33
L308:
        ;call writeAcc8
        CALL  writeA
L309:
        ;;test5.j(54)   if (three != 12/(1+2)) write(34);
L310:
        ;acc8= constant 12
        LD    A,12
L311:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L312:
        ;acc8+ constant 2
        ADD   A,2
L313:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L314:
        ;acc16= variable 4
        LD    HL,(05004H)
L315:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L316:
        ;breq 320
        JP    Z,L320
L317:
        ;acc8= constant 34
        LD    A,34
L318:
        ;call writeAcc8
        CALL  writeA
L319:
        ;;test5.j(55)   if (three != 4) write(35);
L320:
        ;acc16= variable 4
        LD    HL,(05004H)
L321:
        ;acc8= constant 4
        LD    A,4
L322:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L323:
        ;breq 327
        JP    Z,L327
L324:
        ;acc8= constant 35
        LD    A,35
L325:
        ;call writeAcc8
        CALL  writeA
L326:
        ;;test5.j(56)   if (three < 12/(1+2)) write(36);
L327:
        ;acc8= constant 12
        LD    A,12
L328:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L329:
        ;acc8+ constant 2
        ADD   A,2
L330:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L331:
        ;acc16= variable 4
        LD    HL,(05004H)
L332:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L333:
        ;brge 337
        JP    NC,L337
L334:
        ;acc8= constant 36
        LD    A,36
L335:
        ;call writeAcc8
        CALL  writeA
L336:
        ;;test5.j(57)   if (three < 4) write(37);
L337:
        ;acc16= variable 4
        LD    HL,(05004H)
L338:
        ;acc8= constant 4
        LD    A,4
L339:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L340:
        ;brge 344
        JP    NC,L344
L341:
        ;acc8= constant 37
        LD    A,37
L342:
        ;call writeAcc8
        CALL  writeA
L343:
        ;;test5.j(58)   if (five > 12/(1+2)) write(38);
L344:
        ;acc8= constant 12
        LD    A,12
L345:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L346:
        ;acc8+ constant 2
        ADD   A,2
L347:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L348:
        ;acc16= variable 8
        LD    HL,(05008H)
L349:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L350:
        ;brle 354
        JP    Z,L354
L351:
        ;acc8= constant 38
        LD    A,38
L352:
        ;call writeAcc8
        CALL  writeA
L353:
        ;;test5.j(59)   if (five > 4) write(39);
L354:
        ;acc16= variable 8
        LD    HL,(05008H)
L355:
        ;acc8= constant 4
        LD    A,4
L356:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L357:
        ;brle 361
        JP    Z,L361
L358:
        ;acc8= constant 39
        LD    A,39
L359:
        ;call writeAcc8
        CALL  writeA
L360:
        ;;test5.j(60)   if (three <= 12/(1+2)) write(40);
L361:
        ;acc8= constant 12
        LD    A,12
L362:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L363:
        ;acc8+ constant 2
        ADD   A,2
L364:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L365:
        ;acc16= variable 4
        LD    HL,(05004H)
L366:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L367:
        ;brgt 371
        JR    Z,$+5
        JP    C,L371
L368:
        ;acc8= constant 40
        LD    A,40
L369:
        ;call writeAcc8
        CALL  writeA
L370:
        ;;test5.j(61)   if (three <= 4) write(41);
L371:
        ;acc16= variable 4
        LD    HL,(05004H)
L372:
        ;acc8= constant 4
        LD    A,4
L373:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L374:
        ;brgt 378
        JR    Z,$+5
        JP    C,L378
L375:
        ;acc8= constant 41
        LD    A,41
L376:
        ;call writeAcc8
        CALL  writeA
L377:
        ;;test5.j(62)   if (four <= 12/(1+2)) write(42);
L378:
        ;acc8= constant 12
        LD    A,12
L379:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L380:
        ;acc8+ constant 2
        ADD   A,2
L381:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L382:
        ;acc16= variable 6
        LD    HL,(05006H)
L383:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L384:
        ;brgt 388
        JR    Z,$+5
        JP    C,L388
L385:
        ;acc8= constant 42
        LD    A,42
L386:
        ;call writeAcc8
        CALL  writeA
L387:
        ;;test5.j(63)   if (four <= 4) write(43);
L388:
        ;acc16= variable 6
        LD    HL,(05006H)
L389:
        ;acc8= constant 4
        LD    A,4
L390:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L391:
        ;brgt 395
        JR    Z,$+5
        JP    C,L395
L392:
        ;acc8= constant 43
        LD    A,43
L393:
        ;call writeAcc8
        CALL  writeA
L394:
        ;;test5.j(64)   if (five >= 12/(1+2)) write(44);
L395:
        ;acc8= constant 12
        LD    A,12
L396:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L397:
        ;acc8+ constant 2
        ADD   A,2
L398:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L399:
        ;acc16= variable 8
        LD    HL,(05008H)
L400:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L401:
        ;brlt 405
        JP    C,L405
L402:
        ;acc8= constant 44
        LD    A,44
L403:
        ;call writeAcc8
        CALL  writeA
L404:
        ;;test5.j(65)   if (five >= 4) write(45);
L405:
        ;acc16= variable 8
        LD    HL,(05008H)
L406:
        ;acc8= constant 4
        LD    A,4
L407:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L408:
        ;brlt 412
        JP    C,L412
L409:
        ;acc8= constant 45
        LD    A,45
L410:
        ;call writeAcc8
        CALL  writeA
L411:
        ;;test5.j(66)   if (four >= 12/(1+2)) write(46);
L412:
        ;acc8= constant 12
        LD    A,12
L413:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L414:
        ;acc8+ constant 2
        ADD   A,2
L415:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L416:
        ;acc16= variable 6
        LD    HL,(05006H)
L417:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L418:
        ;brlt 422
        JP    C,L422
L419:
        ;acc8= constant 46
        LD    A,46
L420:
        ;call writeAcc8
        CALL  writeA
L421:
        ;;test5.j(67)   if (four >= 4) write(47);
L422:
        ;acc16= variable 6
        LD    HL,(05006H)
L423:
        ;acc8= constant 4
        LD    A,4
L424:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L425:
        ;brlt 431
        JP    C,L431
L426:
        ;acc8= constant 47
        LD    A,47
L427:
        ;call writeAcc8
        CALL  writeA
L428:
        ;;test5.j(68)   //stack level 1
L429:
        ;;test5.j(69)   //integer-integer
L430:
        ;;test5.j(70)   if (400 == 1200/(1+2)) write(48);
L431:
        ;acc16= constant 1200
        LD    HL,1200
L432:
        ;acc8= constant 1
        LD    A,1
L433:
        ;acc8+ constant 2
        ADD   A,2
L434:
        ;acc16/ acc8
        CALL  div16_8
L435:
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
L436:
        ;brne 440
        JP    NZ,L440
L437:
        ;acc8= constant 48
        LD    A,48
L438:
        ;call writeAcc8
        CALL  writeA
L439:
        ;;test5.j(71)   if (400 == 400) write(49);
L440:
        ;acc16= constant 400
        LD    HL,400
L441:
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
L442:
        ;brne 446
        JP    NZ,L446
L443:
        ;acc8= constant 49
        LD    A,49
L444:
        ;call writeAcc8
        CALL  writeA
L445:
        ;;test5.j(72)   if (300 != 1200/(1+2)) write(50);
L446:
        ;acc16= constant 1200
        LD    HL,1200
L447:
        ;acc8= constant 1
        LD    A,1
L448:
        ;acc8+ constant 2
        ADD   A,2
L449:
        ;acc16/ acc8
        CALL  div16_8
L450:
        ;acc16Comp constant 300
        LD    DE,300
        OR    A
        SBC   HL,DE
L451:
        ;breq 455
        JP    Z,L455
L452:
        ;acc8= constant 50
        LD    A,50
L453:
        ;call writeAcc8
        CALL  writeA
L454:
        ;;test5.j(73)   if (300 != 400) write(51);
L455:
        ;acc16= constant 300
        LD    HL,300
L456:
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
L457:
        ;breq 461
        JP    Z,L461
L458:
        ;acc8= constant 51
        LD    A,51
L459:
        ;call writeAcc8
        CALL  writeA
L460:
        ;;test5.j(74)   if (300 < 1200/(1+2)) write(52);
L461:
        ;acc16= constant 1200
        LD    HL,1200
L462:
        ;acc8= constant 1
        LD    A,1
L463:
        ;acc8+ constant 2
        ADD   A,2
L464:
        ;acc16/ acc8
        CALL  div16_8
L465:
        ;acc16Comp constant 300
        LD    DE,300
        OR    A
        SBC   HL,DE
L466:
        ;brle 470
        JP    Z,L470
L467:
        ;acc8= constant 52
        LD    A,52
L468:
        ;call writeAcc8
        CALL  writeA
L469:
        ;;test5.j(75)   if (300 < 400) write(53);
L470:
        ;acc16= constant 300
        LD    HL,300
L471:
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
L472:
        ;brge 476
        JP    NC,L476
L473:
        ;acc8= constant 53
        LD    A,53
L474:
        ;call writeAcc8
        CALL  writeA
L475:
        ;;test5.j(76)   if (500 > 1200/(1+2)) write(54);
L476:
        ;acc16= constant 1200
        LD    HL,1200
L477:
        ;acc8= constant 1
        LD    A,1
L478:
        ;acc8+ constant 2
        ADD   A,2
L479:
        ;acc16/ acc8
        CALL  div16_8
L480:
        ;acc16Comp constant 500
        LD    DE,500
        OR    A
        SBC   HL,DE
L481:
        ;brge 485
        JP    NC,L485
L482:
        ;acc8= constant 54
        LD    A,54
L483:
        ;call writeAcc8
        CALL  writeA
L484:
        ;;test5.j(77)   if (500 > 400) write(55);
L485:
        ;acc16= constant 500
        LD    HL,500
L486:
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
L487:
        ;brle 491
        JP    Z,L491
L488:
        ;acc8= constant 55
        LD    A,55
L489:
        ;call writeAcc8
        CALL  writeA
L490:
        ;;test5.j(78)   if (300 <= 1200/(1+2)) write(56);
L491:
        ;acc16= constant 1200
        LD    HL,1200
L492:
        ;acc8= constant 1
        LD    A,1
L493:
        ;acc8+ constant 2
        ADD   A,2
L494:
        ;acc16/ acc8
        CALL  div16_8
L495:
        ;acc16Comp constant 300
        LD    DE,300
        OR    A
        SBC   HL,DE
L496:
        ;brlt 500
        JP    C,L500
L497:
        ;acc8= constant 56
        LD    A,56
L498:
        ;call writeAcc8
        CALL  writeA
L499:
        ;;test5.j(79)   if (300 <= 400) write(57);
L500:
        ;acc16= constant 300
        LD    HL,300
L501:
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
L502:
        ;brgt 506
        JR    Z,$+5
        JP    C,L506
L503:
        ;acc8= constant 57
        LD    A,57
L504:
        ;call writeAcc8
        CALL  writeA
L505:
        ;;test5.j(80)   if (400 <= 1200/(1+2)) write(58);
L506:
        ;acc16= constant 1200
        LD    HL,1200
L507:
        ;acc8= constant 1
        LD    A,1
L508:
        ;acc8+ constant 2
        ADD   A,2
L509:
        ;acc16/ acc8
        CALL  div16_8
L510:
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
L511:
        ;brlt 515
        JP    C,L515
L512:
        ;acc8= constant 58
        LD    A,58
L513:
        ;call writeAcc8
        CALL  writeA
L514:
        ;;test5.j(81)   if (400 <= 400) write(59);
L515:
        ;acc16= constant 400
        LD    HL,400
L516:
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
L517:
        ;brgt 521
        JR    Z,$+5
        JP    C,L521
L518:
        ;acc8= constant 59
        LD    A,59
L519:
        ;call writeAcc8
        CALL  writeA
L520:
        ;;test5.j(82)   if (500 >= 1200/(1+2)) write(60);
L521:
        ;acc16= constant 1200
        LD    HL,1200
L522:
        ;acc8= constant 1
        LD    A,1
L523:
        ;acc8+ constant 2
        ADD   A,2
L524:
        ;acc16/ acc8
        CALL  div16_8
L525:
        ;acc16Comp constant 500
        LD    DE,500
        OR    A
        SBC   HL,DE
L526:
        ;brgt 530
        JR    Z,$+5
        JP    C,L530
L527:
        ;acc8= constant 60
        LD    A,60
L528:
        ;call writeAcc8
        CALL  writeA
L529:
        ;;test5.j(83)   if (500 >= 400) write(61);
L530:
        ;acc16= constant 500
        LD    HL,500
L531:
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
L532:
        ;brlt 536
        JP    C,L536
L533:
        ;acc8= constant 61
        LD    A,61
L534:
        ;call writeAcc8
        CALL  writeA
L535:
        ;;test5.j(84)   if (400 >= 1200/(1+2)) write(62);
L536:
        ;acc16= constant 1200
        LD    HL,1200
L537:
        ;acc8= constant 1
        LD    A,1
L538:
        ;acc8+ constant 2
        ADD   A,2
L539:
        ;acc16/ acc8
        CALL  div16_8
L540:
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
L541:
        ;brgt 545
        JR    Z,$+5
        JP    C,L545
L542:
        ;acc8= constant 62
        LD    A,62
L543:
        ;call writeAcc8
        CALL  writeA
L544:
        ;;test5.j(85)   if (400 >= 400) write(63);
L545:
        ;acc16= constant 400
        LD    HL,400
L546:
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
L547:
        ;brlt 553
        JP    C,L553
L548:
        ;acc8= constant 63
        LD    A,63
L549:
        ;call writeAcc8
        CALL  writeA
L550:
        ;;test5.j(86) 
L551:
        ;;test5.j(87)   //stack level 2
L552:
        ;;test5.j(88)   if (one+three == 12/(1+2)) write(64);
L553:
        ;acc16= variable 2
        LD    HL,(05002H)
L554:
        ;acc16+ variable 4
        LD    DE,(05004H)
        ADD   HL,DE
L555:
        ;<acc16
        PUSH HL
L556:
        ;acc8= constant 12
        LD    A,12
L557:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L558:
        ;acc8+ constant 2
        ADD   A,2
L559:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L560:
        ;acc16= unstack16
        POP  HL
L561:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L562:
        ;brne 566
        JP    NZ,L566
L563:
        ;acc8= constant 64
        LD    A,64
L564:
        ;call writeAcc8
        CALL  writeA
L565:
        ;;test5.j(89)   if (one+four  != 12/(1+2)) write(65);
L566:
        ;acc16= variable 2
        LD    HL,(05002H)
L567:
        ;acc16+ variable 6
        LD    DE,(05006H)
        ADD   HL,DE
L568:
        ;<acc16
        PUSH HL
L569:
        ;acc8= constant 12
        LD    A,12
L570:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L571:
        ;acc8+ constant 2
        ADD   A,2
L572:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L573:
        ;acc16= unstack16
        POP  HL
L574:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L575:
        ;breq 579
        JP    Z,L579
L576:
        ;acc8= constant 65
        LD    A,65
L577:
        ;call writeAcc8
        CALL  writeA
L578:
        ;;test5.j(90)   if (one+one < 12/(1+2)) write(66);
L579:
        ;acc16= variable 2
        LD    HL,(05002H)
L580:
        ;acc16+ variable 2
        LD    DE,(05002H)
        ADD   HL,DE
L581:
        ;<acc16
        PUSH HL
L582:
        ;acc8= constant 12
        LD    A,12
L583:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L584:
        ;acc8+ constant 2
        ADD   A,2
L585:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L586:
        ;acc16= unstack16
        POP  HL
L587:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L588:
        ;brge 592
        JP    NC,L592
L589:
        ;acc8= constant 66
        LD    A,66
L590:
        ;call writeAcc8
        CALL  writeA
L591:
        ;;test5.j(91)   if (one+four > 12/(1+2)) write(67);
L592:
        ;acc16= variable 2
        LD    HL,(05002H)
L593:
        ;acc16+ variable 6
        LD    DE,(05006H)
        ADD   HL,DE
L594:
        ;<acc16
        PUSH HL
L595:
        ;acc8= constant 12
        LD    A,12
L596:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L597:
        ;acc8+ constant 2
        ADD   A,2
L598:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L599:
        ;acc16= unstack16
        POP  HL
L600:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L601:
        ;brle 605
        JP    Z,L605
L602:
        ;acc8= constant 67
        LD    A,67
L603:
        ;call writeAcc8
        CALL  writeA
L604:
        ;;test5.j(92)   if (one+one <= 12/(1+2)) write(68);
L605:
        ;acc16= variable 2
        LD    HL,(05002H)
L606:
        ;acc16+ variable 2
        LD    DE,(05002H)
        ADD   HL,DE
L607:
        ;<acc16
        PUSH HL
L608:
        ;acc8= constant 12
        LD    A,12
L609:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L610:
        ;acc8+ constant 2
        ADD   A,2
L611:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L612:
        ;acc16= unstack16
        POP  HL
L613:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L614:
        ;brgt 618
        JR    Z,$+5
        JP    C,L618
L615:
        ;acc8= constant 68
        LD    A,68
L616:
        ;call writeAcc8
        CALL  writeA
L617:
        ;;test5.j(93)   if (one+three <= 12/(1+2)) write(69);
L618:
        ;acc16= variable 2
        LD    HL,(05002H)
L619:
        ;acc16+ variable 4
        LD    DE,(05004H)
        ADD   HL,DE
L620:
        ;<acc16
        PUSH HL
L621:
        ;acc8= constant 12
        LD    A,12
L622:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L623:
        ;acc8+ constant 2
        ADD   A,2
L624:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L625:
        ;acc16= unstack16
        POP  HL
L626:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L627:
        ;brgt 631
        JR    Z,$+5
        JP    C,L631
L628:
        ;acc8= constant 69
        LD    A,69
L629:
        ;call writeAcc8
        CALL  writeA
L630:
        ;;test5.j(94)   if (one+three >= 12/(1+2)) write(70);
L631:
        ;acc16= variable 2
        LD    HL,(05002H)
L632:
        ;acc16+ variable 4
        LD    DE,(05004H)
        ADD   HL,DE
L633:
        ;<acc16
        PUSH HL
L634:
        ;acc8= constant 12
        LD    A,12
L635:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L636:
        ;acc8+ constant 2
        ADD   A,2
L637:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L638:
        ;acc16= unstack16
        POP  HL
L639:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L640:
        ;brlt 644
        JP    C,L644
L641:
        ;acc8= constant 70
        LD    A,70
L642:
        ;call writeAcc8
        CALL  writeA
L643:
        ;;test5.j(95)   if (one+four >= 12/(1+2)) write(71);
L644:
        ;acc16= variable 2
        LD    HL,(05002H)
L645:
        ;acc16+ variable 6
        LD    DE,(05006H)
        ADD   HL,DE
L646:
        ;<acc16
        PUSH HL
L647:
        ;acc8= constant 12
        LD    A,12
L648:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L649:
        ;acc8+ constant 2
        ADD   A,2
L650:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L651:
        ;acc16= unstack16
        POP  HL
L652:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L653:
        ;brlt 657
        JP    C,L657
L654:
        ;acc8= constant 71
        LD    A,71
L655:
        ;call writeAcc8
        CALL  writeA
L656:
        ;;test5.j(96)   if (one+three == twelve/(one+2)) write(72);
L657:
        ;acc16= variable 2
        LD    HL,(05002H)
L658:
        ;acc16+ variable 4
        LD    DE,(05004H)
        ADD   HL,DE
L659:
        ;<acc16
        PUSH HL
L660:
        ;acc16= variable 10
        LD    HL,(0500AH)
L661:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L662:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L663:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L664:
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
L665:
        ;brne 669
        JP    NZ,L669
L666:
        ;acc8= constant 72
        LD    A,72
L667:
        ;call writeAcc8
        CALL  writeA
L668:
        ;;test5.j(97)   if (one+four  != twelve/(one+2)) write(73);
L669:
        ;acc16= variable 2
        LD    HL,(05002H)
L670:
        ;acc16+ variable 6
        LD    DE,(05006H)
        ADD   HL,DE
L671:
        ;<acc16
        PUSH HL
L672:
        ;acc16= variable 10
        LD    HL,(0500AH)
L673:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L674:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L675:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L676:
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
L677:
        ;breq 681
        JP    Z,L681
L678:
        ;acc8= constant 73
        LD    A,73
L679:
        ;call writeAcc8
        CALL  writeA
L680:
        ;;test5.j(98)   if (one+one < twelve/(one+2)) write(74);
L681:
        ;acc16= variable 2
        LD    HL,(05002H)
L682:
        ;acc16+ variable 2
        LD    DE,(05002H)
        ADD   HL,DE
L683:
        ;<acc16
        PUSH HL
L684:
        ;acc16= variable 10
        LD    HL,(0500AH)
L685:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L686:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L687:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L688:
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
L689:
        ;brle 693
        JP    Z,L693
L690:
        ;acc8= constant 74
        LD    A,74
L691:
        ;call writeAcc8
        CALL  writeA
L692:
        ;;test5.j(99)   if (one+four > twelve/(one+2)) write(75);
L693:
        ;acc16= variable 2
        LD    HL,(05002H)
L694:
        ;acc16+ variable 6
        LD    DE,(05006H)
        ADD   HL,DE
L695:
        ;<acc16
        PUSH HL
L696:
        ;acc16= variable 10
        LD    HL,(0500AH)
L697:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L698:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L699:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L700:
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
L701:
        ;brge 705
        JP    NC,L705
L702:
        ;acc8= constant 75
        LD    A,75
L703:
        ;call writeAcc8
        CALL  writeA
L704:
        ;;test5.j(100)   if (one+one <= twelve/(one+2)) write(76);
L705:
        ;acc16= variable 2
        LD    HL,(05002H)
L706:
        ;acc16+ variable 2
        LD    DE,(05002H)
        ADD   HL,DE
L707:
        ;<acc16
        PUSH HL
L708:
        ;acc16= variable 10
        LD    HL,(0500AH)
L709:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L710:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L711:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L712:
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
L713:
        ;brlt 717
        JP    C,L717
L714:
        ;acc8= constant 76
        LD    A,76
L715:
        ;call writeAcc8
        CALL  writeA
L716:
        ;;test5.j(101)   if (one+three <= twelve/(one+2)) write(77);
L717:
        ;acc16= variable 2
        LD    HL,(05002H)
L718:
        ;acc16+ variable 4
        LD    DE,(05004H)
        ADD   HL,DE
L719:
        ;<acc16
        PUSH HL
L720:
        ;acc16= variable 10
        LD    HL,(0500AH)
L721:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L722:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L723:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L724:
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
L725:
        ;brlt 729
        JP    C,L729
L726:
        ;acc8= constant 77
        LD    A,77
L727:
        ;call writeAcc8
        CALL  writeA
L728:
        ;;test5.j(102)   if (one+three >= twelve/(one+2)) write(78);
L729:
        ;acc16= variable 2
        LD    HL,(05002H)
L730:
        ;acc16+ variable 4
        LD    DE,(05004H)
        ADD   HL,DE
L731:
        ;<acc16
        PUSH HL
L732:
        ;acc16= variable 10
        LD    HL,(0500AH)
L733:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L734:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L735:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L736:
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
L737:
        ;brgt 741
        JR    Z,$+5
        JP    C,L741
L738:
        ;acc8= constant 78
        LD    A,78
L739:
        ;call writeAcc8
        CALL  writeA
L740:
        ;;test5.j(103)   if (one+four >= twelve/(one+2)) write(79);
L741:
        ;acc16= variable 2
        LD    HL,(05002H)
L742:
        ;acc16+ variable 6
        LD    DE,(05006H)
        ADD   HL,DE
L743:
        ;<acc16
        PUSH HL
L744:
        ;acc16= variable 10
        LD    HL,(0500AH)
L745:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L746:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L747:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L748:
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
L749:
        ;brgt 753
        JR    Z,$+5
        JP    C,L753
L750:
        ;acc8= constant 79
        LD    A,79
L751:
        ;call writeAcc8
        CALL  writeA
L752:
        ;;test5.j(104)   if (four == 12/(1+2)) write(80);
L753:
        ;acc8= constant 12
        LD    A,12
L754:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L755:
        ;acc8+ constant 2
        ADD   A,2
L756:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L757:
        ;acc16= variable 6
        LD    HL,(05006H)
L758:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L759:
        ;brne 763
        JP    NZ,L763
L760:
        ;acc8= constant 80
        LD    A,80
L761:
        ;call writeAcc8
        CALL  writeA
L762:
        ;;test5.j(105)   if (three != 12/(1+2)) write(81);
L763:
        ;acc8= constant 12
        LD    A,12
L764:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L765:
        ;acc8+ constant 2
        ADD   A,2
L766:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L767:
        ;acc16= variable 4
        LD    HL,(05004H)
L768:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L769:
        ;breq 773
        JP    Z,L773
L770:
        ;acc8= constant 81
        LD    A,81
L771:
        ;call writeAcc8
        CALL  writeA
L772:
        ;;test5.j(106)   if (three < 12/(1+2)) write(82);
L773:
        ;acc8= constant 12
        LD    A,12
L774:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L775:
        ;acc8+ constant 2
        ADD   A,2
L776:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L777:
        ;acc16= variable 4
        LD    HL,(05004H)
L778:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L779:
        ;brge 783
        JP    NC,L783
L780:
        ;acc8= constant 82
        LD    A,82
L781:
        ;call writeAcc8
        CALL  writeA
L782:
        ;;test5.j(107)   if (twelve > 12/(1+2)) write(83);
L783:
        ;acc8= constant 12
        LD    A,12
L784:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L785:
        ;acc8+ constant 2
        ADD   A,2
L786:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L787:
        ;acc16= variable 10
        LD    HL,(0500AH)
L788:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L789:
        ;brle 793
        JP    Z,L793
L790:
        ;acc8= constant 83
        LD    A,83
L791:
        ;call writeAcc8
        CALL  writeA
L792:
        ;;test5.j(108)   if (four <= 12/(1+2)) write(84);
L793:
        ;acc8= constant 12
        LD    A,12
L794:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L795:
        ;acc8+ constant 2
        ADD   A,2
L796:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L797:
        ;acc16= variable 6
        LD    HL,(05006H)
L798:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L799:
        ;brgt 803
        JR    Z,$+5
        JP    C,L803
L800:
        ;acc8= constant 84
        LD    A,84
L801:
        ;call writeAcc8
        CALL  writeA
L802:
        ;;test5.j(109)   if (three <= 12/(1+2)) write(85);
L803:
        ;acc8= constant 12
        LD    A,12
L804:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L805:
        ;acc8+ constant 2
        ADD   A,2
L806:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L807:
        ;acc16= variable 4
        LD    HL,(05004H)
L808:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L809:
        ;brgt 813
        JR    Z,$+5
        JP    C,L813
L810:
        ;acc8= constant 85
        LD    A,85
L811:
        ;call writeAcc8
        CALL  writeA
L812:
        ;;test5.j(110)   if (four >= 12/(1+2)) write(86);
L813:
        ;acc8= constant 12
        LD    A,12
L814:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L815:
        ;acc8+ constant 2
        ADD   A,2
L816:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L817:
        ;acc16= variable 6
        LD    HL,(05006H)
L818:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L819:
        ;brlt 823
        JP    C,L823
L820:
        ;acc8= constant 86
        LD    A,86
L821:
        ;call writeAcc8
        CALL  writeA
L822:
        ;;test5.j(111)   if (twelve >= 12/(1+2)) write(87);
L823:
        ;acc8= constant 12
        LD    A,12
L824:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L825:
        ;acc8+ constant 2
        ADD   A,2
L826:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L827:
        ;acc16= variable 10
        LD    HL,(0500AH)
L828:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L829:
        ;brlt 833
        JP    C,L833
L830:
        ;acc8= constant 87
        LD    A,87
L831:
        ;call writeAcc8
        CALL  writeA
L832:
        ;;test5.j(112)   if (four == twelve/(one+2)) write(88);
L833:
        ;acc16= variable 10
        LD    HL,(0500AH)
L834:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L835:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L836:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L837:
        ;acc16Comp variable 6
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L838:
        ;brne 842
        JP    NZ,L842
L839:
        ;acc8= constant 88
        LD    A,88
L840:
        ;call writeAcc8
        CALL  writeA
L841:
        ;;test5.j(113)   if (three != twelve/(one+2)) write(89);
L842:
        ;acc16= variable 10
        LD    HL,(0500AH)
L843:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L844:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L845:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L846:
        ;acc16Comp variable 4
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L847:
        ;breq 851
        JP    Z,L851
L848:
        ;acc8= constant 89
        LD    A,89
L849:
        ;call writeAcc8
        CALL  writeA
L850:
        ;;test5.j(114)   if (three < twelve/(one+2)) write(90);
L851:
        ;acc16= variable 10
        LD    HL,(0500AH)
L852:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L853:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L854:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L855:
        ;acc16Comp variable 4
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L856:
        ;brle 860
        JP    Z,L860
L857:
        ;acc8= constant 90
        LD    A,90
L858:
        ;call writeAcc8
        CALL  writeA
L859:
        ;;test5.j(115)   if (twelve > twelve/(one+2)) write(91);
L860:
        ;acc16= variable 10
        LD    HL,(0500AH)
L861:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L862:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L863:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L864:
        ;acc16Comp variable 10
        LD    DE,(0500AH)
        OR    A
        SBC   HL,DE
L865:
        ;brge 869
        JP    NC,L869
L866:
        ;acc8= constant 91
        LD    A,91
L867:
        ;call writeAcc8
        CALL  writeA
L868:
        ;;test5.j(116)   if (four <= twelve/(one+2)) write(92);
L869:
        ;acc16= variable 10
        LD    HL,(0500AH)
L870:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L871:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L872:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L873:
        ;acc16Comp variable 6
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L874:
        ;brlt 878
        JP    C,L878
L875:
        ;acc8= constant 92
        LD    A,92
L876:
        ;call writeAcc8
        CALL  writeA
L877:
        ;;test5.j(117)   if (three <= twelve/(one+2)) write(93);
L878:
        ;acc16= variable 10
        LD    HL,(0500AH)
L879:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L880:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L881:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L882:
        ;acc16Comp variable 4
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L883:
        ;brlt 887
        JP    C,L887
L884:
        ;acc8= constant 93
        LD    A,93
L885:
        ;call writeAcc8
        CALL  writeA
L886:
        ;;test5.j(118)   if (four >= twelve/(one+2)) write(94);
L887:
        ;acc16= variable 10
        LD    HL,(0500AH)
L888:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L889:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L890:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L891:
        ;acc16Comp variable 6
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L892:
        ;brgt 896
        JR    Z,$+5
        JP    C,L896
L893:
        ;acc8= constant 94
        LD    A,94
L894:
        ;call writeAcc8
        CALL  writeA
L895:
        ;;test5.j(119)   if (twelve >= twelve/(one+2)) write(95);
L896:
        ;acc16= variable 10
        LD    HL,(0500AH)
L897:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L898:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L899:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L900:
        ;acc16Comp variable 10
        LD    DE,(0500AH)
        OR    A
        SBC   HL,DE
L901:
        ;brgt 905
        JR    Z,$+5
        JP    C,L905
L902:
        ;acc8= constant 95
        LD    A,95
L903:
        ;call writeAcc8
        CALL  writeA
L904:
        ;;test5.j(120)   if (1+3 == 12/(1+2)) write(96);
L905:
        ;acc8= constant 1
        LD    A,1
L906:
        ;acc8+ constant 3
        ADD   A,3
L907:
        ;<acc8
        PUSH AF
L908:
        ;acc8= constant 12
        LD    A,12
L909:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L910:
        ;acc8+ constant 2
        ADD   A,2
L911:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L912:
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
L913:
        ;brne 917
        JP    NZ,L917
L914:
        ;acc8= constant 96
        LD    A,96
L915:
        ;call writeAcc8
        CALL  writeA
L916:
        ;;test5.j(121)   if (1+2 != 12/(1+2)) write(97);
L917:
        ;acc8= constant 1
        LD    A,1
L918:
        ;acc8+ constant 2
        ADD   A,2
L919:
        ;<acc8
        PUSH AF
L920:
        ;acc8= constant 12
        LD    A,12
L921:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L922:
        ;acc8+ constant 2
        ADD   A,2
L923:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L924:
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
L925:
        ;breq 929
        JP    Z,L929
L926:
        ;acc8= constant 97
        LD    A,97
L927:
        ;call writeAcc8
        CALL  writeA
L928:
        ;;test5.j(122)   if (1+2 < 12/(1+2)) write(98);
L929:
        ;acc8= constant 1
        LD    A,1
L930:
        ;acc8+ constant 2
        ADD   A,2
L931:
        ;<acc8
        PUSH AF
L932:
        ;acc8= constant 12
        LD    A,12
L933:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L934:
        ;acc8+ constant 2
        ADD   A,2
L935:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L936:
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
L937:
        ;brle 941
        JP    Z,L941
L938:
        ;acc8= constant 98
        LD    A,98
L939:
        ;call writeAcc8
        CALL  writeA
L940:
        ;;test5.j(123)   if (1+4 > 12/(1+2)) write(99);
L941:
        ;acc8= constant 1
        LD    A,1
L942:
        ;acc8+ constant 4
        ADD   A,4
L943:
        ;<acc8
        PUSH AF
L944:
        ;acc8= constant 12
        LD    A,12
L945:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L946:
        ;acc8+ constant 2
        ADD   A,2
L947:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L948:
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
L949:
        ;brge 953
        JP    NC,L953
L950:
        ;acc8= constant 99
        LD    A,99
L951:
        ;call writeAcc8
        CALL  writeA
L952:
        ;;test5.j(124)   if (1+2 <= 12/(1+2)) write(100);
L953:
        ;acc8= constant 1
        LD    A,1
L954:
        ;acc8+ constant 2
        ADD   A,2
L955:
        ;<acc8
        PUSH AF
L956:
        ;acc8= constant 12
        LD    A,12
L957:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L958:
        ;acc8+ constant 2
        ADD   A,2
L959:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L960:
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
L961:
        ;brlt 965
        JP    C,L965
L962:
        ;acc8= constant 100
        LD    A,100
L963:
        ;call writeAcc8
        CALL  writeA
L964:
        ;;test5.j(125)   if (1+3 <= 12/(1+2)) write(101);
L965:
        ;acc8= constant 1
        LD    A,1
L966:
        ;acc8+ constant 3
        ADD   A,3
L967:
        ;<acc8
        PUSH AF
L968:
        ;acc8= constant 12
        LD    A,12
L969:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L970:
        ;acc8+ constant 2
        ADD   A,2
L971:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L972:
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
L973:
        ;brlt 977
        JP    C,L977
L974:
        ;acc8= constant 101
        LD    A,101
L975:
        ;call writeAcc8
        CALL  writeA
L976:
        ;;test5.j(126)   if (1+3 >= 12/(1+2)) write(102);
L977:
        ;acc8= constant 1
        LD    A,1
L978:
        ;acc8+ constant 3
        ADD   A,3
L979:
        ;<acc8
        PUSH AF
L980:
        ;acc8= constant 12
        LD    A,12
L981:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L982:
        ;acc8+ constant 2
        ADD   A,2
L983:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L984:
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
L985:
        ;brgt 989
        JR    Z,$+5
        JP    C,L989
L986:
        ;acc8= constant 102
        LD    A,102
L987:
        ;call writeAcc8
        CALL  writeA
L988:
        ;;test5.j(127)   if (1+4 >= 12/(1+2)) write(103);
L989:
        ;acc8= constant 1
        LD    A,1
L990:
        ;acc8+ constant 4
        ADD   A,4
L991:
        ;<acc8
        PUSH AF
L992:
        ;acc8= constant 12
        LD    A,12
L993:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L994:
        ;acc8+ constant 2
        ADD   A,2
L995:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L996:
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
L997:
        ;brgt 1001
        JR    Z,$+5
        JP    C,L1001
L998:
        ;acc8= constant 103
        LD    A,103
L999:
        ;call writeAcc8
        CALL  writeA
L1000:
        ;;test5.j(128)   if (1+3 == twelve/(one+2)) write(104);
L1001:
        ;acc8= constant 1
        LD    A,1
L1002:
        ;acc8+ constant 3
        ADD   A,3
L1003:
        ;<acc8
        PUSH AF
L1004:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1005:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1006:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1007:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1008:
        ;acc8= unstack8
        POP  AF
L1009:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1010:
        ;brne 1014
        JP    NZ,L1014
L1011:
        ;acc8= constant 104
        LD    A,104
L1012:
        ;call writeAcc8
        CALL  writeA
L1013:
        ;;test5.j(129)   if (1+2 != twelve/(one+2)) write(105);
L1014:
        ;acc8= constant 1
        LD    A,1
L1015:
        ;acc8+ constant 2
        ADD   A,2
L1016:
        ;<acc8
        PUSH AF
L1017:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1018:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1019:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1020:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1021:
        ;acc8= unstack8
        POP  AF
L1022:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1023:
        ;breq 1027
        JP    Z,L1027
L1024:
        ;acc8= constant 105
        LD    A,105
L1025:
        ;call writeAcc8
        CALL  writeA
L1026:
        ;;test5.j(130)   if (1+2 < twelve/(one+2)) write(106);
L1027:
        ;acc8= constant 1
        LD    A,1
L1028:
        ;acc8+ constant 2
        ADD   A,2
L1029:
        ;<acc8
        PUSH AF
L1030:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1031:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1032:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1033:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1034:
        ;acc8= unstack8
        POP  AF
L1035:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1036:
        ;brge 1040
        JP    NC,L1040
L1037:
        ;acc8= constant 106
        LD    A,106
L1038:
        ;call writeAcc8
        CALL  writeA
L1039:
        ;;test5.j(131)   if (1+4 > twelve/(one+2)) write(107);
L1040:
        ;acc8= constant 1
        LD    A,1
L1041:
        ;acc8+ constant 4
        ADD   A,4
L1042:
        ;<acc8
        PUSH AF
L1043:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1044:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1045:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1046:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1047:
        ;acc8= unstack8
        POP  AF
L1048:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1049:
        ;brle 1053
        JP    Z,L1053
L1050:
        ;acc8= constant 107
        LD    A,107
L1051:
        ;call writeAcc8
        CALL  writeA
L1052:
        ;;test5.j(132)   if (1+2 <= twelve/(one+2)) write(108);
L1053:
        ;acc8= constant 1
        LD    A,1
L1054:
        ;acc8+ constant 2
        ADD   A,2
L1055:
        ;<acc8
        PUSH AF
L1056:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1057:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1058:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1059:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1060:
        ;acc8= unstack8
        POP  AF
L1061:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1062:
        ;brgt 1066
        JR    Z,$+5
        JP    C,L1066
L1063:
        ;acc8= constant 108
        LD    A,108
L1064:
        ;call writeAcc8
        CALL  writeA
L1065:
        ;;test5.j(133)   if (1+3 <= twelve/(one+2)) write(109);
L1066:
        ;acc8= constant 1
        LD    A,1
L1067:
        ;acc8+ constant 3
        ADD   A,3
L1068:
        ;<acc8
        PUSH AF
L1069:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1070:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1071:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1072:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1073:
        ;acc8= unstack8
        POP  AF
L1074:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1075:
        ;brgt 1079
        JR    Z,$+5
        JP    C,L1079
L1076:
        ;acc8= constant 109
        LD    A,109
L1077:
        ;call writeAcc8
        CALL  writeA
L1078:
        ;;test5.j(134)   if (1+3 >= twelve/(one+2)) write(110);
L1079:
        ;acc8= constant 1
        LD    A,1
L1080:
        ;acc8+ constant 3
        ADD   A,3
L1081:
        ;<acc8
        PUSH AF
L1082:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1083:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1084:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1085:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1086:
        ;acc8= unstack8
        POP  AF
L1087:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1088:
        ;brlt 1092
        JP    C,L1092
L1089:
        ;acc8= constant 110
        LD    A,110
L1090:
        ;call writeAcc8
        CALL  writeA
L1091:
        ;;test5.j(135)   if (1+4 >= twelve/(one+2)) write(111);
L1092:
        ;acc8= constant 1
        LD    A,1
L1093:
        ;acc8+ constant 4
        ADD   A,4
L1094:
        ;<acc8
        PUSH AF
L1095:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1096:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1097:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1098:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1099:
        ;acc8= unstack8
        POP  AF
L1100:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1101:
        ;brlt 1105
        JP    C,L1105
L1102:
        ;acc8= constant 111
        LD    A,111
L1103:
        ;call writeAcc8
        CALL  writeA
L1104:
        ;;test5.j(136)   if (4 == 12/(1+2)) write(112);
L1105:
        ;acc8= constant 12
        LD    A,12
L1106:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L1107:
        ;acc8+ constant 2
        ADD   A,2
L1108:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L1109:
        ;acc8Comp constant 4
        SUB   A,4
L1110:
        ;brne 1114
        JP    NZ,L1114
L1111:
        ;acc8= constant 112
        LD    A,112
L1112:
        ;call writeAcc8
        CALL  writeA
L1113:
        ;;test5.j(137)   if (3 != 12/(1+2)) write(113);
L1114:
        ;acc8= constant 12
        LD    A,12
L1115:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L1116:
        ;acc8+ constant 2
        ADD   A,2
L1117:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L1118:
        ;acc8Comp constant 3
        SUB   A,3
L1119:
        ;breq 1123
        JP    Z,L1123
L1120:
        ;acc8= constant 113
        LD    A,113
L1121:
        ;call writeAcc8
        CALL  writeA
L1122:
        ;;test5.j(138)   if (3 < 12/(1+2)) write(114);
L1123:
        ;acc8= constant 12
        LD    A,12
L1124:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L1125:
        ;acc8+ constant 2
        ADD   A,2
L1126:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L1127:
        ;acc8Comp constant 3
        SUB   A,3
L1128:
        ;brle 1132
        JP    Z,L1132
L1129:
        ;acc8= constant 114
        LD    A,114
L1130:
        ;call writeAcc8
        CALL  writeA
L1131:
        ;;test5.j(139)   if (5 > 12/(1+2)) write(115);
L1132:
        ;acc8= constant 12
        LD    A,12
L1133:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L1134:
        ;acc8+ constant 2
        ADD   A,2
L1135:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L1136:
        ;acc8Comp constant 5
        SUB   A,5
L1137:
        ;brge 1141
        JP    NC,L1141
L1138:
        ;acc8= constant 115
        LD    A,115
L1139:
        ;call writeAcc8
        CALL  writeA
L1140:
        ;;test5.j(140)   if (3 <= 12/(1+2)) write(116);
L1141:
        ;acc8= constant 12
        LD    A,12
L1142:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L1143:
        ;acc8+ constant 2
        ADD   A,2
L1144:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L1145:
        ;acc8Comp constant 3
        SUB   A,3
L1146:
        ;brlt 1150
        JP    C,L1150
L1147:
        ;acc8= constant 116
        LD    A,116
L1148:
        ;call writeAcc8
        CALL  writeA
L1149:
        ;;test5.j(141)   if (4 <= 12/(1+2)) write(117);
L1150:
        ;acc8= constant 12
        LD    A,12
L1151:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L1152:
        ;acc8+ constant 2
        ADD   A,2
L1153:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L1154:
        ;acc8Comp constant 4
        SUB   A,4
L1155:
        ;brlt 1159
        JP    C,L1159
L1156:
        ;acc8= constant 117
        LD    A,117
L1157:
        ;call writeAcc8
        CALL  writeA
L1158:
        ;;test5.j(142)   if (4 >= 12/(1+2)) write(118);
L1159:
        ;acc8= constant 12
        LD    A,12
L1160:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L1161:
        ;acc8+ constant 2
        ADD   A,2
L1162:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L1163:
        ;acc8Comp constant 4
        SUB   A,4
L1164:
        ;brgt 1168
        JR    Z,$+5
        JP    C,L1168
L1165:
        ;acc8= constant 118
        LD    A,118
L1166:
        ;call writeAcc8
        CALL  writeA
L1167:
        ;;test5.j(143)   if (5 >= 12/(1+2)) write(119);
L1168:
        ;acc8= constant 12
        LD    A,12
L1169:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L1170:
        ;acc8+ constant 2
        ADD   A,2
L1171:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L1172:
        ;acc8Comp constant 5
        SUB   A,5
L1173:
        ;brgt 1177
        JR    Z,$+5
        JP    C,L1177
L1174:
        ;acc8= constant 119
        LD    A,119
L1175:
        ;call writeAcc8
        CALL  writeA
L1176:
        ;;test5.j(144)   if (4 == twelve/(one+2)) write(120);
L1177:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1178:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1179:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1180:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1181:
        ;acc8= constant 4
        LD    A,4
L1182:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1183:
        ;brne 1187
        JP    NZ,L1187
L1184:
        ;acc8= constant 120
        LD    A,120
L1185:
        ;call writeAcc8
        CALL  writeA
L1186:
        ;;test5.j(145)   if (3 != twelve/(one+2)) write(121);
L1187:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1188:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1189:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1190:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1191:
        ;acc8= constant 3
        LD    A,3
L1192:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1193:
        ;breq 1197
        JP    Z,L1197
L1194:
        ;acc8= constant 121
        LD    A,121
L1195:
        ;call writeAcc8
        CALL  writeA
L1196:
        ;;test5.j(146)   if (2 < twelve/(one+2)) write(122);
L1197:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1198:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1199:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1200:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1201:
        ;acc8= constant 2
        LD    A,2
L1202:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1203:
        ;brge 1207
        JP    NC,L1207
L1204:
        ;acc8= constant 122
        LD    A,122
L1205:
        ;call writeAcc8
        CALL  writeA
L1206:
        ;;test5.j(147)   if (5 > twelve/(one+2)) write(123);
L1207:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1208:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1209:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1210:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1211:
        ;acc8= constant 5
        LD    A,5
L1212:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1213:
        ;brle 1217
        JP    Z,L1217
L1214:
        ;acc8= constant 123
        LD    A,123
L1215:
        ;call writeAcc8
        CALL  writeA
L1216:
        ;;test5.j(148)   if (3 <= twelve/(one+2)) write(124);
L1217:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1218:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1219:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1220:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1221:
        ;acc8= constant 3
        LD    A,3
L1222:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1223:
        ;brgt 1227
        JR    Z,$+5
        JP    C,L1227
L1224:
        ;acc8= constant 124
        LD    A,124
L1225:
        ;call writeAcc8
        CALL  writeA
L1226:
        ;;test5.j(149)   if (4 <= twelve/(one+2)) write(125);
L1227:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1228:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1229:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1230:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1231:
        ;acc8= constant 4
        LD    A,4
L1232:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1233:
        ;brgt 1237
        JR    Z,$+5
        JP    C,L1237
L1234:
        ;acc8= constant 125
        LD    A,125
L1235:
        ;call writeAcc8
        CALL  writeA
L1236:
        ;;test5.j(150)   if (4 >= twelve/(one+2)) write(126);
L1237:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1238:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1239:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1240:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1241:
        ;acc8= constant 4
        LD    A,4
L1242:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1243:
        ;brlt 1247
        JP    C,L1247
L1244:
        ;acc8= constant 126
        LD    A,126
L1245:
        ;call writeAcc8
        CALL  writeA
L1246:
        ;;test5.j(151)   if (5 >= twelve/(one+2)) write(127);
L1247:
        ;acc16= variable 10
        LD    HL,(0500AH)
L1248:
        ;<acc16= variable 2
        PUSH  HL
        LD    HL,(05002H)
L1249:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1250:
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
L1251:
        ;acc8= constant 5
        LD    A,5
L1252:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1253:
        ;brlt 1257
        JP    C,L1257
L1254:
        ;acc8= constant 127
        LD    A,127
L1255:
        ;call writeAcc8
        CALL  writeA
L1256:
        ;;test5.j(152)   if (four == 0 + 12/(1 + 2)) write(128);
L1257:
        ;acc8= constant 0
        LD    A,0
L1258:
        ;<acc8= constant 12
        PUSH  AF
        LD    A,12
L1259:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L1260:
        ;acc8+ constant 2
        ADD   A,2
L1261:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L1262:
        ;acc8+ unstack8
        POP   BC
        ADD   A,B
L1263:
        ;acc16= variable 6
        LD    HL,(05006H)
L1264:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1265:
        ;brne 1269
        JP    NZ,L1269
L1266:
        ;acc8= constant 128
        LD    A,128
L1267:
        ;call writeAcc8
        CALL  writeA
L1268:
        ;;test5.j(153)   if (four == 0 + 12/(1 + 2)) write(129);
L1269:
        ;acc8= constant 0
        LD    A,0
L1270:
        ;<acc8= constant 12
        PUSH  AF
        LD    A,12
L1271:
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
L1272:
        ;acc8+ constant 2
        ADD   A,2
L1273:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L1274:
        ;acc8+ unstack8
        POP   BC
        ADD   A,B
L1275:
        ;acc16= variable 6
        LD    HL,(05006H)
L1276:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1277:
        ;brne 1281
        JP    NZ,L1281
L1278:
        ;acc8= constant 129
        LD    A,129
L1279:
        ;call writeAcc8
        CALL  writeA
L1280:
        ;;test5.j(154)   if (four == 0 + 12/(byteOne + 2)) write(130);
L1281:
        ;acc8= constant 0
        LD    A,0
L1282:
        ;<acc8= constant 12
        PUSH  AF
        LD    A,12
L1283:
        ;<acc8= variable 12
        PUSH  AF
        LD    A,(0500CH)
L1284:
        ;acc8+ constant 2
        ADD   A,2
L1285:
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
L1286:
        ;acc8+ unstack8
        POP   BC
        ADD   A,B
L1287:
        ;acc16= variable 6
        LD    HL,(05006H)
L1288:
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1289:
        ;brne 1293
        JP    NZ,L1293
L1290:
        ;acc8= constant 130
        LD    A,130
L1291:
        ;call writeAcc8
        CALL  writeA
L1292:
        ;;test5.j(155)   if (four == 0 + 12/(one + 2)) write(131);
L1293:
        ;acc8= constant 0
        LD    A,0
L1294:
        ;<acc8= constant 12
        PUSH  AF
        LD    A,12
L1295:
        ;acc16= variable 2
        LD    HL,(05002H)
L1296:
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
L1297:
        ;/acc16 acc8
        EX    DE,HL
        CALL  div8_16
L1298:
        ;acc16+ unstack8
        POP   DE
        LD    D,0
        ADD   HL,DE
L1299:
        ;acc16Comp variable 6
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L1300:
        ;brne 1304
        JP    NZ,L1304
L1301:
        ;acc8= constant 131
        LD    A,131
L1302:
        ;call writeAcc8
        CALL  writeA
L1303:
        ;;test5.j(156)   if (4 == zero + twelve/(1+2)) write(132);
L1304:
        ;acc16= variable 0
        LD    HL,(05000H)
L1305:
        ;<acc16= variable 10
        PUSH  HL
        LD    HL,(0500AH)
L1306:
        ;acc8= constant 1
        LD    A,1
L1307:
        ;acc8+ constant 2
        ADD   A,2
L1308:
        ;acc16/ acc8
        CALL  div16_8
L1309:
        ;acc16+ unstack16
        POP   DE
        ADD   HL,DE
L1310:
        ;acc8= constant 4
        LD    A,4
L1311:
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1312:
        ;brne 1319
        JP    NZ,L1319
L1313:
        ;acc8= constant 132
        LD    A,132
L1314:
        ;call writeAcc8
        CALL  writeA
L1315:
        ;;test5.j(157) 
L1316:
        ;;test5.j(158)   /************************/
L1317:
        ;;test5.j(159)   // global variable within if scope
L1318:
        ;;test5.j(160)   byte b = 133;
L1319:
        ;acc8= constant 133
        LD    A,133
L1320:
        ;acc8=> variable 14
        LD    (0500EH),A
L1321:
        ;;test5.j(161)   if (b>132) {
L1322:
        ;acc8= variable 14
        LD    A,(0500EH)
L1323:
        ;acc8Comp constant 132
        SUB   A,132
L1324:
        ;brle 1342
        JP    Z,L1342
L1325:
        ;;test5.j(162)     word j = 1001;
L1326:
        ;acc16= constant 1001
        LD    HL,1001
L1327:
        ;acc16=> variable 15
        LD    (0500FH),HL
L1328:
        ;;test5.j(163)     byte c = b;
L1329:
        ;acc8= variable 14
        LD    A,(0500EH)
L1330:
        ;acc8=> variable 17
        LD    (05011H),A
L1331:
        ;;test5.j(164)     byte d = c;
L1332:
        ;acc8= variable 17
        LD    A,(05011H)
L1333:
        ;acc8=> variable 18
        LD    (05012H),A
L1334:
        ;;test5.j(165)     b--;
L1335:
        ;decr8 variable 14
        LD    HL,(0500EH)
        DEC   (HL)
L1336:
        ;;test5.j(166)     write (c);
L1337:
        ;acc8= variable 17
        LD    A,(05011H)
L1338:
        ;call writeAcc8
        CALL  writeA
L1339:
        ;;test5.j(167)   } else {
L1340:
        ;br 1348
        JP    L1348
L1341:
        ;;test5.j(168)     write(999);
L1342:
        ;acc16= constant 999
        LD    HL,999
L1343:
        ;call writeAcc16
        CALL  writeHL
L1344:
        ;;test5.j(169)   }
L1345:
        ;;test5.j(170) 
L1346:
        ;;test5.j(171)   /************************/
L1347:
        ;;test5.j(172)   write (134);
L1348:
        ;acc8= constant 134
        LD    A,134
L1349:
        ;call writeAcc8
        CALL  writeA
L1350:
        ;;test5.j(173)   write("Klaar");
L1351:
        ;acc16= constant 1355
        LD    HL,1355
L1352:
        ;writeString
        CALL  putStr
L1353:
        ;;test5.j(174) }
L1354:
        ;stop
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L1355:
        .ASCIZ  "Klaar"
