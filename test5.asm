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
        LD    A,0
L7:
        LD    L,A
        LD    H,0
        LD    (05000H),HL
L8:
        ;;test5.j(6)   word one = 1;
L9:
        LD    A,1
L10:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L11:
        ;;test5.j(7)   word three = 3;
L12:
        LD    A,3
L13:
        LD    L,A
        LD    H,0
        LD    (05004H),HL
L14:
        ;;test5.j(8)   word four = 4;
L15:
        LD    A,4
L16:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L17:
        ;;test5.j(9)   word five = 5;
L18:
        LD    A,5
L19:
        LD    L,A
        LD    H,0
        LD    (05008H),HL
L20:
        ;;test5.j(10)   word twelve = 12;
L21:
        LD    A,12
L22:
        LD    L,A
        LD    H,0
        LD    (0500AH),HL
L23:
        ;;test5.j(11)   byte byteOne = 1;
L24:
        LD    A,1
L25:
        LD    (0500CH),A
L26:
        ;;test5.j(12)   byte byteSix = 262;
L27:
        LD    HL,262
L28:
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
        LD    A,12
L34:
        PUSH  AF
        LD    A,1
L35:
        ADD   A,2
L36:
        LD    C,A
        POP   AF
        CALL  div8
L37:
        SUB   A,4
L38:
        JP    NZ,L42
L39:
        LD    A,0
L40:
        CALL  writeA
L41:
        ;;test5.j(17)   if (4 == 4) write(1);
L42:
        LD    A,4
L43:
        SUB   A,4
L44:
        JP    NZ,L48
L45:
        LD    A,1
L46:
        CALL  writeA
L47:
        ;;test5.j(18)   if (3 != 12/(1+2)) write(2);
L48:
        LD    A,12
L49:
        PUSH  AF
        LD    A,1
L50:
        ADD   A,2
L51:
        LD    C,A
        POP   AF
        CALL  div8
L52:
        SUB   A,3
L53:
        JP    Z,L57
L54:
        LD    A,2
L55:
        CALL  writeA
L56:
        ;;test5.j(19)   if (3 != 4) write(3);
L57:
        LD    A,3
L58:
        SUB   A,4
L59:
        JP    Z,L63
L60:
        LD    A,3
L61:
        CALL  writeA
L62:
        ;;test5.j(20)   if (3 < 12/(1+2)) write(4);
L63:
        LD    A,12
L64:
        PUSH  AF
        LD    A,1
L65:
        ADD   A,2
L66:
        LD    C,A
        POP   AF
        CALL  div8
L67:
        SUB   A,3
L68:
        JP    Z,L72
L69:
        LD    A,4
L70:
        CALL  writeA
L71:
        ;;test5.j(21)   if (3 < 4) write(5);
L72:
        LD    A,3
L73:
        SUB   A,4
L74:
        JP    NC,L78
L75:
        LD    A,5
L76:
        CALL  writeA
L77:
        ;;test5.j(22)   if (5 > 12/(1+2)) write(6);
L78:
        LD    A,12
L79:
        PUSH  AF
        LD    A,1
L80:
        ADD   A,2
L81:
        LD    C,A
        POP   AF
        CALL  div8
L82:
        SUB   A,5
L83:
        JP    NC,L87
L84:
        LD    A,6
L85:
        CALL  writeA
L86:
        ;;test5.j(23)   if (5 > 4) write(7);
L87:
        LD    A,5
L88:
        SUB   A,4
L89:
        JP    Z,L93
L90:
        LD    A,7
L91:
        CALL  writeA
L92:
        ;;test5.j(24)   if (3 <= 12/(1+2)) write(8);
L93:
        LD    A,12
L94:
        PUSH  AF
        LD    A,1
L95:
        ADD   A,2
L96:
        LD    C,A
        POP   AF
        CALL  div8
L97:
        SUB   A,3
L98:
        JP    C,L102
L99:
        LD    A,8
L100:
        CALL  writeA
L101:
        ;;test5.j(25)   if (3 <= 4) write(9);
L102:
        LD    A,3
L103:
        SUB   A,4
L104:
        JR    Z,$+5
        JP    C,L108
L105:
        LD    A,9
L106:
        CALL  writeA
L107:
        ;;test5.j(26)   if (4 <= 12/(1+2)) write(10);
L108:
        LD    A,12
L109:
        PUSH  AF
        LD    A,1
L110:
        ADD   A,2
L111:
        LD    C,A
        POP   AF
        CALL  div8
L112:
        SUB   A,4
L113:
        JP    C,L117
L114:
        LD    A,10
L115:
        CALL  writeA
L116:
        ;;test5.j(27)   if (4 <= 4) write(11);
L117:
        LD    A,4
L118:
        SUB   A,4
L119:
        JR    Z,$+5
        JP    C,L123
L120:
        LD    A,11
L121:
        CALL  writeA
L122:
        ;;test5.j(28)   if (5 >= 12/(1+2)) write(12);
L123:
        LD    A,12
L124:
        PUSH  AF
        LD    A,1
L125:
        ADD   A,2
L126:
        LD    C,A
        POP   AF
        CALL  div8
L127:
        SUB   A,5
L128:
        JR    Z,$+5
        JP    C,L132
L129:
        LD    A,12
L130:
        CALL  writeA
L131:
        ;;test5.j(29)   if (5 >= 4) write(13);
L132:
        LD    A,5
L133:
        SUB   A,4
L134:
        JP    C,L138
L135:
        LD    A,13
L136:
        CALL  writeA
L137:
        ;;test5.j(30)   if (4 >= 12/(1+2)) write(14);
L138:
        LD    A,12
L139:
        PUSH  AF
        LD    A,1
L140:
        ADD   A,2
L141:
        LD    C,A
        POP   AF
        CALL  div8
L142:
        SUB   A,4
L143:
        JR    Z,$+5
        JP    C,L147
L144:
        LD    A,14
L145:
        CALL  writeA
L146:
        ;;test5.j(31)   if (4 >= 4) write(15);
L147:
        LD    A,4
L148:
        SUB   A,4
L149:
        JP    C,L155
L150:
        LD    A,15
L151:
        CALL  writeA
L152:
        ;;test5.j(32)   //stack level 1
L153:
        ;;test5.j(33)   //byte-integer
L154:
        ;;test5.j(34)   if (4 == twelve/(1+2)) write(16);
L155:
        LD    HL,(0500AH)
L156:
        LD    A,1
L157:
        ADD   A,2
L158:
        CALL  div16_8
L159:
        LD    A,4
L160:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L161:
        JP    NZ,L165
L162:
        LD    A,16
L163:
        CALL  writeA
L164:
        ;;test5.j(35)   if (4 == four) write(17);
L165:
        LD    HL,(05006H)
L166:
        LD    A,4
L167:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L168:
        JP    NZ,L172
L169:
        LD    A,17
L170:
        CALL  writeA
L171:
        ;;test5.j(36)   if (3 != twelve/(1+2)) write(18);
L172:
        LD    HL,(0500AH)
L173:
        LD    A,1
L174:
        ADD   A,2
L175:
        CALL  div16_8
L176:
        LD    A,3
L177:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L178:
        JP    Z,L182
L179:
        LD    A,18
L180:
        CALL  writeA
L181:
        ;;test5.j(37)   if (3 != four) write(19);
L182:
        LD    HL,(05006H)
L183:
        LD    A,3
L184:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L185:
        JP    Z,L189
L186:
        LD    A,19
L187:
        CALL  writeA
L188:
        ;;test5.j(38)   if (3 < twelve/(1+2)) write(20);
L189:
        LD    HL,(0500AH)
L190:
        LD    A,1
L191:
        ADD   A,2
L192:
        CALL  div16_8
L193:
        LD    A,3
L194:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L195:
        JP    NC,L199
L196:
        LD    A,20
L197:
        CALL  writeA
L198:
        ;;test5.j(39)   if (3 < four) write(21);
L199:
        LD    HL,(05006H)
L200:
        LD    A,3
L201:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L202:
        JP    NC,L206
L203:
        LD    A,21
L204:
        CALL  writeA
L205:
        ;;test5.j(40)   if (5 > twelve/(1+2)) write(22);
L206:
        LD    HL,(0500AH)
L207:
        LD    A,1
L208:
        ADD   A,2
L209:
        CALL  div16_8
L210:
        LD    A,5
L211:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L212:
        JP    Z,L216
L213:
        LD    A,22
L214:
        CALL  writeA
L215:
        ;;test5.j(41)   if (5 > four) write(23);
L216:
        LD    HL,(05006H)
L217:
        LD    A,5
L218:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L219:
        JP    Z,L223
L220:
        LD    A,23
L221:
        CALL  writeA
L222:
        ;;test5.j(42)   if (3 <= twelve/(1+2)) write(24);
L223:
        LD    HL,(0500AH)
L224:
        LD    A,1
L225:
        ADD   A,2
L226:
        CALL  div16_8
L227:
        LD    A,3
L228:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L229:
        JR    Z,$+5
        JP    C,L233
L230:
        LD    A,24
L231:
        CALL  writeA
L232:
        ;;test5.j(43)   if (3 <= four) write(25);
L233:
        LD    HL,(05006H)
L234:
        LD    A,3
L235:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L236:
        JR    Z,$+5
        JP    C,L240
L237:
        LD    A,25
L238:
        CALL  writeA
L239:
        ;;test5.j(44)   if (4 <= twelve/(1+2)) write(26);
L240:
        LD    HL,(0500AH)
L241:
        LD    A,1
L242:
        ADD   A,2
L243:
        CALL  div16_8
L244:
        LD    A,4
L245:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L246:
        JR    Z,$+5
        JP    C,L250
L247:
        LD    A,26
L248:
        CALL  writeA
L249:
        ;;test5.j(45)   if (4 <= four) write(27);
L250:
        LD    HL,(05006H)
L251:
        LD    A,4
L252:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L253:
        JR    Z,$+5
        JP    C,L257
L254:
        LD    A,27
L255:
        CALL  writeA
L256:
        ;;test5.j(46)   if (5 >= twelve/(1+2)) write(28);
L257:
        LD    HL,(0500AH)
L258:
        LD    A,1
L259:
        ADD   A,2
L260:
        CALL  div16_8
L261:
        LD    A,5
L262:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L263:
        JP    C,L267
L264:
        LD    A,28
L265:
        CALL  writeA
L266:
        ;;test5.j(47)   if (5 >= four) write(29);
L267:
        LD    HL,(05006H)
L268:
        LD    A,5
L269:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L270:
        JP    C,L274
L271:
        LD    A,29
L272:
        CALL  writeA
L273:
        ;;test5.j(48)   if (4 >= twelve/(1+2)) write(30);
L274:
        LD    HL,(0500AH)
L275:
        LD    A,1
L276:
        ADD   A,2
L277:
        CALL  div16_8
L278:
        LD    A,4
L279:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L280:
        JP    C,L284
L281:
        LD    A,30
L282:
        CALL  writeA
L283:
        ;;test5.j(49)   if (4 >= four) write(31);
L284:
        LD    HL,(05006H)
L285:
        LD    A,4
L286:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L287:
        JP    C,L293
L288:
        LD    A,31
L289:
        CALL  writeA
L290:
        ;;test5.j(50)   //stack level 1
L291:
        ;;test5.j(51)   //integer-byte
L292:
        ;;test5.j(52)   if (four == 12/(1+2)) write(32);
L293:
        LD    A,12
L294:
        PUSH  AF
        LD    A,1
L295:
        ADD   A,2
L296:
        LD    C,A
        POP   AF
        CALL  div8
L297:
        LD    HL,(05006H)
L298:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L299:
        JP    NZ,L303
L300:
        LD    A,32
L301:
        CALL  writeA
L302:
        ;;test5.j(53)   if (four == 4) write(33);
L303:
        LD    HL,(05006H)
L304:
        LD    A,4
L305:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L306:
        JP    NZ,L310
L307:
        LD    A,33
L308:
        CALL  writeA
L309:
        ;;test5.j(54)   if (three != 12/(1+2)) write(34);
L310:
        LD    A,12
L311:
        PUSH  AF
        LD    A,1
L312:
        ADD   A,2
L313:
        LD    C,A
        POP   AF
        CALL  div8
L314:
        LD    HL,(05004H)
L315:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L316:
        JP    Z,L320
L317:
        LD    A,34
L318:
        CALL  writeA
L319:
        ;;test5.j(55)   if (three != 4) write(35);
L320:
        LD    HL,(05004H)
L321:
        LD    A,4
L322:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L323:
        JP    Z,L327
L324:
        LD    A,35
L325:
        CALL  writeA
L326:
        ;;test5.j(56)   if (three < 12/(1+2)) write(36);
L327:
        LD    A,12
L328:
        PUSH  AF
        LD    A,1
L329:
        ADD   A,2
L330:
        LD    C,A
        POP   AF
        CALL  div8
L331:
        LD    HL,(05004H)
L332:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L333:
        JP    NC,L337
L334:
        LD    A,36
L335:
        CALL  writeA
L336:
        ;;test5.j(57)   if (three < 4) write(37);
L337:
        LD    HL,(05004H)
L338:
        LD    A,4
L339:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L340:
        JP    NC,L344
L341:
        LD    A,37
L342:
        CALL  writeA
L343:
        ;;test5.j(58)   if (five > 12/(1+2)) write(38);
L344:
        LD    A,12
L345:
        PUSH  AF
        LD    A,1
L346:
        ADD   A,2
L347:
        LD    C,A
        POP   AF
        CALL  div8
L348:
        LD    HL,(05008H)
L349:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L350:
        JP    Z,L354
L351:
        LD    A,38
L352:
        CALL  writeA
L353:
        ;;test5.j(59)   if (five > 4) write(39);
L354:
        LD    HL,(05008H)
L355:
        LD    A,4
L356:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L357:
        JP    Z,L361
L358:
        LD    A,39
L359:
        CALL  writeA
L360:
        ;;test5.j(60)   if (three <= 12/(1+2)) write(40);
L361:
        LD    A,12
L362:
        PUSH  AF
        LD    A,1
L363:
        ADD   A,2
L364:
        LD    C,A
        POP   AF
        CALL  div8
L365:
        LD    HL,(05004H)
L366:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L367:
        JR    Z,$+5
        JP    C,L371
L368:
        LD    A,40
L369:
        CALL  writeA
L370:
        ;;test5.j(61)   if (three <= 4) write(41);
L371:
        LD    HL,(05004H)
L372:
        LD    A,4
L373:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L374:
        JR    Z,$+5
        JP    C,L378
L375:
        LD    A,41
L376:
        CALL  writeA
L377:
        ;;test5.j(62)   if (four <= 12/(1+2)) write(42);
L378:
        LD    A,12
L379:
        PUSH  AF
        LD    A,1
L380:
        ADD   A,2
L381:
        LD    C,A
        POP   AF
        CALL  div8
L382:
        LD    HL,(05006H)
L383:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L384:
        JR    Z,$+5
        JP    C,L388
L385:
        LD    A,42
L386:
        CALL  writeA
L387:
        ;;test5.j(63)   if (four <= 4) write(43);
L388:
        LD    HL,(05006H)
L389:
        LD    A,4
L390:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L391:
        JR    Z,$+5
        JP    C,L395
L392:
        LD    A,43
L393:
        CALL  writeA
L394:
        ;;test5.j(64)   if (five >= 12/(1+2)) write(44);
L395:
        LD    A,12
L396:
        PUSH  AF
        LD    A,1
L397:
        ADD   A,2
L398:
        LD    C,A
        POP   AF
        CALL  div8
L399:
        LD    HL,(05008H)
L400:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L401:
        JP    C,L405
L402:
        LD    A,44
L403:
        CALL  writeA
L404:
        ;;test5.j(65)   if (five >= 4) write(45);
L405:
        LD    HL,(05008H)
L406:
        LD    A,4
L407:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L408:
        JP    C,L412
L409:
        LD    A,45
L410:
        CALL  writeA
L411:
        ;;test5.j(66)   if (four >= 12/(1+2)) write(46);
L412:
        LD    A,12
L413:
        PUSH  AF
        LD    A,1
L414:
        ADD   A,2
L415:
        LD    C,A
        POP   AF
        CALL  div8
L416:
        LD    HL,(05006H)
L417:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L418:
        JP    C,L422
L419:
        LD    A,46
L420:
        CALL  writeA
L421:
        ;;test5.j(67)   if (four >= 4) write(47);
L422:
        LD    HL,(05006H)
L423:
        LD    A,4
L424:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L425:
        JP    C,L431
L426:
        LD    A,47
L427:
        CALL  writeA
L428:
        ;;test5.j(68)   //stack level 1
L429:
        ;;test5.j(69)   //integer-integer
L430:
        ;;test5.j(70)   if (400 == 1200/(1+2)) write(48);
L431:
        LD    HL,1200
L432:
        LD    A,1
L433:
        ADD   A,2
L434:
        CALL  div16_8
L435:
        LD    DE,400
        OR    A
        SBC   HL,DE
L436:
        JP    NZ,L440
L437:
        LD    A,48
L438:
        CALL  writeA
L439:
        ;;test5.j(71)   if (400 == 400) write(49);
L440:
        LD    HL,400
L441:
        LD    DE,400
        OR    A
        SBC   HL,DE
L442:
        JP    NZ,L446
L443:
        LD    A,49
L444:
        CALL  writeA
L445:
        ;;test5.j(72)   if (300 != 1200/(1+2)) write(50);
L446:
        LD    HL,1200
L447:
        LD    A,1
L448:
        ADD   A,2
L449:
        CALL  div16_8
L450:
        LD    DE,300
        OR    A
        SBC   HL,DE
L451:
        JP    Z,L455
L452:
        LD    A,50
L453:
        CALL  writeA
L454:
        ;;test5.j(73)   if (300 != 400) write(51);
L455:
        LD    HL,300
L456:
        LD    DE,400
        OR    A
        SBC   HL,DE
L457:
        JP    Z,L461
L458:
        LD    A,51
L459:
        CALL  writeA
L460:
        ;;test5.j(74)   if (300 < 1200/(1+2)) write(52);
L461:
        LD    HL,1200
L462:
        LD    A,1
L463:
        ADD   A,2
L464:
        CALL  div16_8
L465:
        LD    DE,300
        OR    A
        SBC   HL,DE
L466:
        JP    Z,L470
L467:
        LD    A,52
L468:
        CALL  writeA
L469:
        ;;test5.j(75)   if (300 < 400) write(53);
L470:
        LD    HL,300
L471:
        LD    DE,400
        OR    A
        SBC   HL,DE
L472:
        JP    NC,L476
L473:
        LD    A,53
L474:
        CALL  writeA
L475:
        ;;test5.j(76)   if (500 > 1200/(1+2)) write(54);
L476:
        LD    HL,1200
L477:
        LD    A,1
L478:
        ADD   A,2
L479:
        CALL  div16_8
L480:
        LD    DE,500
        OR    A
        SBC   HL,DE
L481:
        JP    NC,L485
L482:
        LD    A,54
L483:
        CALL  writeA
L484:
        ;;test5.j(77)   if (500 > 400) write(55);
L485:
        LD    HL,500
L486:
        LD    DE,400
        OR    A
        SBC   HL,DE
L487:
        JP    Z,L491
L488:
        LD    A,55
L489:
        CALL  writeA
L490:
        ;;test5.j(78)   if (300 <= 1200/(1+2)) write(56);
L491:
        LD    HL,1200
L492:
        LD    A,1
L493:
        ADD   A,2
L494:
        CALL  div16_8
L495:
        LD    DE,300
        OR    A
        SBC   HL,DE
L496:
        JP    C,L500
L497:
        LD    A,56
L498:
        CALL  writeA
L499:
        ;;test5.j(79)   if (300 <= 400) write(57);
L500:
        LD    HL,300
L501:
        LD    DE,400
        OR    A
        SBC   HL,DE
L502:
        JR    Z,$+5
        JP    C,L506
L503:
        LD    A,57
L504:
        CALL  writeA
L505:
        ;;test5.j(80)   if (400 <= 1200/(1+2)) write(58);
L506:
        LD    HL,1200
L507:
        LD    A,1
L508:
        ADD   A,2
L509:
        CALL  div16_8
L510:
        LD    DE,400
        OR    A
        SBC   HL,DE
L511:
        JP    C,L515
L512:
        LD    A,58
L513:
        CALL  writeA
L514:
        ;;test5.j(81)   if (400 <= 400) write(59);
L515:
        LD    HL,400
L516:
        LD    DE,400
        OR    A
        SBC   HL,DE
L517:
        JR    Z,$+5
        JP    C,L521
L518:
        LD    A,59
L519:
        CALL  writeA
L520:
        ;;test5.j(82)   if (500 >= 1200/(1+2)) write(60);
L521:
        LD    HL,1200
L522:
        LD    A,1
L523:
        ADD   A,2
L524:
        CALL  div16_8
L525:
        LD    DE,500
        OR    A
        SBC   HL,DE
L526:
        JR    Z,$+5
        JP    C,L530
L527:
        LD    A,60
L528:
        CALL  writeA
L529:
        ;;test5.j(83)   if (500 >= 400) write(61);
L530:
        LD    HL,500
L531:
        LD    DE,400
        OR    A
        SBC   HL,DE
L532:
        JP    C,L536
L533:
        LD    A,61
L534:
        CALL  writeA
L535:
        ;;test5.j(84)   if (400 >= 1200/(1+2)) write(62);
L536:
        LD    HL,1200
L537:
        LD    A,1
L538:
        ADD   A,2
L539:
        CALL  div16_8
L540:
        LD    DE,400
        OR    A
        SBC   HL,DE
L541:
        JR    Z,$+5
        JP    C,L545
L542:
        LD    A,62
L543:
        CALL  writeA
L544:
        ;;test5.j(85)   if (400 >= 400) write(63);
L545:
        LD    HL,400
L546:
        LD    DE,400
        OR    A
        SBC   HL,DE
L547:
        JP    C,L553
L548:
        LD    A,63
L549:
        CALL  writeA
L550:
        ;;test5.j(86) 
L551:
        ;;test5.j(87)   //stack level 2
L552:
        ;;test5.j(88)   if (one+three == 12/(1+2)) write(64);
L553:
        LD    HL,(05002H)
L554:
        LD    DE,(05004H)
        ADD   HL,DE
L555:
        PUSH HL
L556:
        LD    A,12
L557:
        PUSH  AF
        LD    A,1
L558:
        ADD   A,2
L559:
        LD    C,A
        POP   AF
        CALL  div8
L560:
        POP  HL
L561:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L562:
        JP    NZ,L566
L563:
        LD    A,64
L564:
        CALL  writeA
L565:
        ;;test5.j(89)   if (one+four  != 12/(1+2)) write(65);
L566:
        LD    HL,(05002H)
L567:
        LD    DE,(05006H)
        ADD   HL,DE
L568:
        PUSH HL
L569:
        LD    A,12
L570:
        PUSH  AF
        LD    A,1
L571:
        ADD   A,2
L572:
        LD    C,A
        POP   AF
        CALL  div8
L573:
        POP  HL
L574:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L575:
        JP    Z,L579
L576:
        LD    A,65
L577:
        CALL  writeA
L578:
        ;;test5.j(90)   if (one+one < 12/(1+2)) write(66);
L579:
        LD    HL,(05002H)
L580:
        LD    DE,(05002H)
        ADD   HL,DE
L581:
        PUSH HL
L582:
        LD    A,12
L583:
        PUSH  AF
        LD    A,1
L584:
        ADD   A,2
L585:
        LD    C,A
        POP   AF
        CALL  div8
L586:
        POP  HL
L587:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L588:
        JP    NC,L592
L589:
        LD    A,66
L590:
        CALL  writeA
L591:
        ;;test5.j(91)   if (one+four > 12/(1+2)) write(67);
L592:
        LD    HL,(05002H)
L593:
        LD    DE,(05006H)
        ADD   HL,DE
L594:
        PUSH HL
L595:
        LD    A,12
L596:
        PUSH  AF
        LD    A,1
L597:
        ADD   A,2
L598:
        LD    C,A
        POP   AF
        CALL  div8
L599:
        POP  HL
L600:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L601:
        JP    Z,L605
L602:
        LD    A,67
L603:
        CALL  writeA
L604:
        ;;test5.j(92)   if (one+one <= 12/(1+2)) write(68);
L605:
        LD    HL,(05002H)
L606:
        LD    DE,(05002H)
        ADD   HL,DE
L607:
        PUSH HL
L608:
        LD    A,12
L609:
        PUSH  AF
        LD    A,1
L610:
        ADD   A,2
L611:
        LD    C,A
        POP   AF
        CALL  div8
L612:
        POP  HL
L613:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L614:
        JR    Z,$+5
        JP    C,L618
L615:
        LD    A,68
L616:
        CALL  writeA
L617:
        ;;test5.j(93)   if (one+three <= 12/(1+2)) write(69);
L618:
        LD    HL,(05002H)
L619:
        LD    DE,(05004H)
        ADD   HL,DE
L620:
        PUSH HL
L621:
        LD    A,12
L622:
        PUSH  AF
        LD    A,1
L623:
        ADD   A,2
L624:
        LD    C,A
        POP   AF
        CALL  div8
L625:
        POP  HL
L626:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L627:
        JR    Z,$+5
        JP    C,L631
L628:
        LD    A,69
L629:
        CALL  writeA
L630:
        ;;test5.j(94)   if (one+three >= 12/(1+2)) write(70);
L631:
        LD    HL,(05002H)
L632:
        LD    DE,(05004H)
        ADD   HL,DE
L633:
        PUSH HL
L634:
        LD    A,12
L635:
        PUSH  AF
        LD    A,1
L636:
        ADD   A,2
L637:
        LD    C,A
        POP   AF
        CALL  div8
L638:
        POP  HL
L639:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L640:
        JP    C,L644
L641:
        LD    A,70
L642:
        CALL  writeA
L643:
        ;;test5.j(95)   if (one+four >= 12/(1+2)) write(71);
L644:
        LD    HL,(05002H)
L645:
        LD    DE,(05006H)
        ADD   HL,DE
L646:
        PUSH HL
L647:
        LD    A,12
L648:
        PUSH  AF
        LD    A,1
L649:
        ADD   A,2
L650:
        LD    C,A
        POP   AF
        CALL  div8
L651:
        POP  HL
L652:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L653:
        JP    C,L657
L654:
        LD    A,71
L655:
        CALL  writeA
L656:
        ;;test5.j(96)   if (one+three == twelve/(one+2)) write(72);
L657:
        LD    HL,(05002H)
L658:
        LD    DE,(05004H)
        ADD   HL,DE
L659:
        PUSH HL
L660:
        LD    HL,(0500AH)
L661:
        PUSH  HL
        LD    HL,(05002H)
L662:
        LD    DE,2
        ADD   HL,DE
L663:
        POP   DE
        EX    DE,HL
        CALL  div16
L664:
        POP   DE
        OR    A
        SBC   HL,DE
L665:
        JP    NZ,L669
L666:
        LD    A,72
L667:
        CALL  writeA
L668:
        ;;test5.j(97)   if (one+four  != twelve/(one+2)) write(73);
L669:
        LD    HL,(05002H)
L670:
        LD    DE,(05006H)
        ADD   HL,DE
L671:
        PUSH HL
L672:
        LD    HL,(0500AH)
L673:
        PUSH  HL
        LD    HL,(05002H)
L674:
        LD    DE,2
        ADD   HL,DE
L675:
        POP   DE
        EX    DE,HL
        CALL  div16
L676:
        POP   DE
        OR    A
        SBC   HL,DE
L677:
        JP    Z,L681
L678:
        LD    A,73
L679:
        CALL  writeA
L680:
        ;;test5.j(98)   if (one+one < twelve/(one+2)) write(74);
L681:
        LD    HL,(05002H)
L682:
        LD    DE,(05002H)
        ADD   HL,DE
L683:
        PUSH HL
L684:
        LD    HL,(0500AH)
L685:
        PUSH  HL
        LD    HL,(05002H)
L686:
        LD    DE,2
        ADD   HL,DE
L687:
        POP   DE
        EX    DE,HL
        CALL  div16
L688:
        POP   DE
        OR    A
        SBC   HL,DE
L689:
        JP    Z,L693
L690:
        LD    A,74
L691:
        CALL  writeA
L692:
        ;;test5.j(99)   if (one+four > twelve/(one+2)) write(75);
L693:
        LD    HL,(05002H)
L694:
        LD    DE,(05006H)
        ADD   HL,DE
L695:
        PUSH HL
L696:
        LD    HL,(0500AH)
L697:
        PUSH  HL
        LD    HL,(05002H)
L698:
        LD    DE,2
        ADD   HL,DE
L699:
        POP   DE
        EX    DE,HL
        CALL  div16
L700:
        POP   DE
        OR    A
        SBC   HL,DE
L701:
        JP    NC,L705
L702:
        LD    A,75
L703:
        CALL  writeA
L704:
        ;;test5.j(100)   if (one+one <= twelve/(one+2)) write(76);
L705:
        LD    HL,(05002H)
L706:
        LD    DE,(05002H)
        ADD   HL,DE
L707:
        PUSH HL
L708:
        LD    HL,(0500AH)
L709:
        PUSH  HL
        LD    HL,(05002H)
L710:
        LD    DE,2
        ADD   HL,DE
L711:
        POP   DE
        EX    DE,HL
        CALL  div16
L712:
        POP   DE
        OR    A
        SBC   HL,DE
L713:
        JP    C,L717
L714:
        LD    A,76
L715:
        CALL  writeA
L716:
        ;;test5.j(101)   if (one+three <= twelve/(one+2)) write(77);
L717:
        LD    HL,(05002H)
L718:
        LD    DE,(05004H)
        ADD   HL,DE
L719:
        PUSH HL
L720:
        LD    HL,(0500AH)
L721:
        PUSH  HL
        LD    HL,(05002H)
L722:
        LD    DE,2
        ADD   HL,DE
L723:
        POP   DE
        EX    DE,HL
        CALL  div16
L724:
        POP   DE
        OR    A
        SBC   HL,DE
L725:
        JP    C,L729
L726:
        LD    A,77
L727:
        CALL  writeA
L728:
        ;;test5.j(102)   if (one+three >= twelve/(one+2)) write(78);
L729:
        LD    HL,(05002H)
L730:
        LD    DE,(05004H)
        ADD   HL,DE
L731:
        PUSH HL
L732:
        LD    HL,(0500AH)
L733:
        PUSH  HL
        LD    HL,(05002H)
L734:
        LD    DE,2
        ADD   HL,DE
L735:
        POP   DE
        EX    DE,HL
        CALL  div16
L736:
        POP   DE
        OR    A
        SBC   HL,DE
L737:
        JR    Z,$+5
        JP    C,L741
L738:
        LD    A,78
L739:
        CALL  writeA
L740:
        ;;test5.j(103)   if (one+four >= twelve/(one+2)) write(79);
L741:
        LD    HL,(05002H)
L742:
        LD    DE,(05006H)
        ADD   HL,DE
L743:
        PUSH HL
L744:
        LD    HL,(0500AH)
L745:
        PUSH  HL
        LD    HL,(05002H)
L746:
        LD    DE,2
        ADD   HL,DE
L747:
        POP   DE
        EX    DE,HL
        CALL  div16
L748:
        POP   DE
        OR    A
        SBC   HL,DE
L749:
        JR    Z,$+5
        JP    C,L753
L750:
        LD    A,79
L751:
        CALL  writeA
L752:
        ;;test5.j(104)   if (four == 12/(1+2)) write(80);
L753:
        LD    A,12
L754:
        PUSH  AF
        LD    A,1
L755:
        ADD   A,2
L756:
        LD    C,A
        POP   AF
        CALL  div8
L757:
        LD    HL,(05006H)
L758:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L759:
        JP    NZ,L763
L760:
        LD    A,80
L761:
        CALL  writeA
L762:
        ;;test5.j(105)   if (three != 12/(1+2)) write(81);
L763:
        LD    A,12
L764:
        PUSH  AF
        LD    A,1
L765:
        ADD   A,2
L766:
        LD    C,A
        POP   AF
        CALL  div8
L767:
        LD    HL,(05004H)
L768:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L769:
        JP    Z,L773
L770:
        LD    A,81
L771:
        CALL  writeA
L772:
        ;;test5.j(106)   if (three < 12/(1+2)) write(82);
L773:
        LD    A,12
L774:
        PUSH  AF
        LD    A,1
L775:
        ADD   A,2
L776:
        LD    C,A
        POP   AF
        CALL  div8
L777:
        LD    HL,(05004H)
L778:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L779:
        JP    NC,L783
L780:
        LD    A,82
L781:
        CALL  writeA
L782:
        ;;test5.j(107)   if (twelve > 12/(1+2)) write(83);
L783:
        LD    A,12
L784:
        PUSH  AF
        LD    A,1
L785:
        ADD   A,2
L786:
        LD    C,A
        POP   AF
        CALL  div8
L787:
        LD    HL,(0500AH)
L788:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L789:
        JP    Z,L793
L790:
        LD    A,83
L791:
        CALL  writeA
L792:
        ;;test5.j(108)   if (four <= 12/(1+2)) write(84);
L793:
        LD    A,12
L794:
        PUSH  AF
        LD    A,1
L795:
        ADD   A,2
L796:
        LD    C,A
        POP   AF
        CALL  div8
L797:
        LD    HL,(05006H)
L798:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L799:
        JR    Z,$+5
        JP    C,L803
L800:
        LD    A,84
L801:
        CALL  writeA
L802:
        ;;test5.j(109)   if (three <= 12/(1+2)) write(85);
L803:
        LD    A,12
L804:
        PUSH  AF
        LD    A,1
L805:
        ADD   A,2
L806:
        LD    C,A
        POP   AF
        CALL  div8
L807:
        LD    HL,(05004H)
L808:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L809:
        JR    Z,$+5
        JP    C,L813
L810:
        LD    A,85
L811:
        CALL  writeA
L812:
        ;;test5.j(110)   if (four >= 12/(1+2)) write(86);
L813:
        LD    A,12
L814:
        PUSH  AF
        LD    A,1
L815:
        ADD   A,2
L816:
        LD    C,A
        POP   AF
        CALL  div8
L817:
        LD    HL,(05006H)
L818:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L819:
        JP    C,L823
L820:
        LD    A,86
L821:
        CALL  writeA
L822:
        ;;test5.j(111)   if (twelve >= 12/(1+2)) write(87);
L823:
        LD    A,12
L824:
        PUSH  AF
        LD    A,1
L825:
        ADD   A,2
L826:
        LD    C,A
        POP   AF
        CALL  div8
L827:
        LD    HL,(0500AH)
L828:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L829:
        JP    C,L833
L830:
        LD    A,87
L831:
        CALL  writeA
L832:
        ;;test5.j(112)   if (four == twelve/(one+2)) write(88);
L833:
        LD    HL,(0500AH)
L834:
        PUSH  HL
        LD    HL,(05002H)
L835:
        LD    DE,2
        ADD   HL,DE
L836:
        POP   DE
        EX    DE,HL
        CALL  div16
L837:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L838:
        JP    NZ,L842
L839:
        LD    A,88
L840:
        CALL  writeA
L841:
        ;;test5.j(113)   if (three != twelve/(one+2)) write(89);
L842:
        LD    HL,(0500AH)
L843:
        PUSH  HL
        LD    HL,(05002H)
L844:
        LD    DE,2
        ADD   HL,DE
L845:
        POP   DE
        EX    DE,HL
        CALL  div16
L846:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L847:
        JP    Z,L851
L848:
        LD    A,89
L849:
        CALL  writeA
L850:
        ;;test5.j(114)   if (three < twelve/(one+2)) write(90);
L851:
        LD    HL,(0500AH)
L852:
        PUSH  HL
        LD    HL,(05002H)
L853:
        LD    DE,2
        ADD   HL,DE
L854:
        POP   DE
        EX    DE,HL
        CALL  div16
L855:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L856:
        JP    Z,L860
L857:
        LD    A,90
L858:
        CALL  writeA
L859:
        ;;test5.j(115)   if (twelve > twelve/(one+2)) write(91);
L860:
        LD    HL,(0500AH)
L861:
        PUSH  HL
        LD    HL,(05002H)
L862:
        LD    DE,2
        ADD   HL,DE
L863:
        POP   DE
        EX    DE,HL
        CALL  div16
L864:
        LD    DE,(0500AH)
        OR    A
        SBC   HL,DE
L865:
        JP    NC,L869
L866:
        LD    A,91
L867:
        CALL  writeA
L868:
        ;;test5.j(116)   if (four <= twelve/(one+2)) write(92);
L869:
        LD    HL,(0500AH)
L870:
        PUSH  HL
        LD    HL,(05002H)
L871:
        LD    DE,2
        ADD   HL,DE
L872:
        POP   DE
        EX    DE,HL
        CALL  div16
L873:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L874:
        JP    C,L878
L875:
        LD    A,92
L876:
        CALL  writeA
L877:
        ;;test5.j(117)   if (three <= twelve/(one+2)) write(93);
L878:
        LD    HL,(0500AH)
L879:
        PUSH  HL
        LD    HL,(05002H)
L880:
        LD    DE,2
        ADD   HL,DE
L881:
        POP   DE
        EX    DE,HL
        CALL  div16
L882:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L883:
        JP    C,L887
L884:
        LD    A,93
L885:
        CALL  writeA
L886:
        ;;test5.j(118)   if (four >= twelve/(one+2)) write(94);
L887:
        LD    HL,(0500AH)
L888:
        PUSH  HL
        LD    HL,(05002H)
L889:
        LD    DE,2
        ADD   HL,DE
L890:
        POP   DE
        EX    DE,HL
        CALL  div16
L891:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L892:
        JR    Z,$+5
        JP    C,L896
L893:
        LD    A,94
L894:
        CALL  writeA
L895:
        ;;test5.j(119)   if (twelve >= twelve/(one+2)) write(95);
L896:
        LD    HL,(0500AH)
L897:
        PUSH  HL
        LD    HL,(05002H)
L898:
        LD    DE,2
        ADD   HL,DE
L899:
        POP   DE
        EX    DE,HL
        CALL  div16
L900:
        LD    DE,(0500AH)
        OR    A
        SBC   HL,DE
L901:
        JR    Z,$+5
        JP    C,L905
L902:
        LD    A,95
L903:
        CALL  writeA
L904:
        ;;test5.j(120)   if (1+3 == 12/(1+2)) write(96);
L905:
        LD    A,1
L906:
        ADD   A,3
L907:
        PUSH AF
L908:
        LD    A,12
L909:
        PUSH  AF
        LD    A,1
L910:
        ADD   A,2
L911:
        LD    C,A
        POP   AF
        CALL  div8
L912:
        POP   BC
        SUB   A,B
L913:
        JP    NZ,L917
L914:
        LD    A,96
L915:
        CALL  writeA
L916:
        ;;test5.j(121)   if (1+2 != 12/(1+2)) write(97);
L917:
        LD    A,1
L918:
        ADD   A,2
L919:
        PUSH AF
L920:
        LD    A,12
L921:
        PUSH  AF
        LD    A,1
L922:
        ADD   A,2
L923:
        LD    C,A
        POP   AF
        CALL  div8
L924:
        POP   BC
        SUB   A,B
L925:
        JP    Z,L929
L926:
        LD    A,97
L927:
        CALL  writeA
L928:
        ;;test5.j(122)   if (1+2 < 12/(1+2)) write(98);
L929:
        LD    A,1
L930:
        ADD   A,2
L931:
        PUSH AF
L932:
        LD    A,12
L933:
        PUSH  AF
        LD    A,1
L934:
        ADD   A,2
L935:
        LD    C,A
        POP   AF
        CALL  div8
L936:
        POP   BC
        SUB   A,B
L937:
        JP    Z,L941
L938:
        LD    A,98
L939:
        CALL  writeA
L940:
        ;;test5.j(123)   if (1+4 > 12/(1+2)) write(99);
L941:
        LD    A,1
L942:
        ADD   A,4
L943:
        PUSH AF
L944:
        LD    A,12
L945:
        PUSH  AF
        LD    A,1
L946:
        ADD   A,2
L947:
        LD    C,A
        POP   AF
        CALL  div8
L948:
        POP   BC
        SUB   A,B
L949:
        JP    NC,L953
L950:
        LD    A,99
L951:
        CALL  writeA
L952:
        ;;test5.j(124)   if (1+2 <= 12/(1+2)) write(100);
L953:
        LD    A,1
L954:
        ADD   A,2
L955:
        PUSH AF
L956:
        LD    A,12
L957:
        PUSH  AF
        LD    A,1
L958:
        ADD   A,2
L959:
        LD    C,A
        POP   AF
        CALL  div8
L960:
        POP   BC
        SUB   A,B
L961:
        JP    C,L965
L962:
        LD    A,100
L963:
        CALL  writeA
L964:
        ;;test5.j(125)   if (1+3 <= 12/(1+2)) write(101);
L965:
        LD    A,1
L966:
        ADD   A,3
L967:
        PUSH AF
L968:
        LD    A,12
L969:
        PUSH  AF
        LD    A,1
L970:
        ADD   A,2
L971:
        LD    C,A
        POP   AF
        CALL  div8
L972:
        POP   BC
        SUB   A,B
L973:
        JP    C,L977
L974:
        LD    A,101
L975:
        CALL  writeA
L976:
        ;;test5.j(126)   if (1+3 >= 12/(1+2)) write(102);
L977:
        LD    A,1
L978:
        ADD   A,3
L979:
        PUSH AF
L980:
        LD    A,12
L981:
        PUSH  AF
        LD    A,1
L982:
        ADD   A,2
L983:
        LD    C,A
        POP   AF
        CALL  div8
L984:
        POP   BC
        SUB   A,B
L985:
        JR    Z,$+5
        JP    C,L989
L986:
        LD    A,102
L987:
        CALL  writeA
L988:
        ;;test5.j(127)   if (1+4 >= 12/(1+2)) write(103);
L989:
        LD    A,1
L990:
        ADD   A,4
L991:
        PUSH AF
L992:
        LD    A,12
L993:
        PUSH  AF
        LD    A,1
L994:
        ADD   A,2
L995:
        LD    C,A
        POP   AF
        CALL  div8
L996:
        POP   BC
        SUB   A,B
L997:
        JR    Z,$+5
        JP    C,L1001
L998:
        LD    A,103
L999:
        CALL  writeA
L1000:
        ;;test5.j(128)   if (1+3 == twelve/(one+2)) write(104);
L1001:
        LD    A,1
L1002:
        ADD   A,3
L1003:
        PUSH AF
L1004:
        LD    HL,(0500AH)
L1005:
        PUSH  HL
        LD    HL,(05002H)
L1006:
        LD    DE,2
        ADD   HL,DE
L1007:
        POP   DE
        EX    DE,HL
        CALL  div16
L1008:
        POP  AF
L1009:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1010:
        JP    NZ,L1014
L1011:
        LD    A,104
L1012:
        CALL  writeA
L1013:
        ;;test5.j(129)   if (1+2 != twelve/(one+2)) write(105);
L1014:
        LD    A,1
L1015:
        ADD   A,2
L1016:
        PUSH AF
L1017:
        LD    HL,(0500AH)
L1018:
        PUSH  HL
        LD    HL,(05002H)
L1019:
        LD    DE,2
        ADD   HL,DE
L1020:
        POP   DE
        EX    DE,HL
        CALL  div16
L1021:
        POP  AF
L1022:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1023:
        JP    Z,L1027
L1024:
        LD    A,105
L1025:
        CALL  writeA
L1026:
        ;;test5.j(130)   if (1+2 < twelve/(one+2)) write(106);
L1027:
        LD    A,1
L1028:
        ADD   A,2
L1029:
        PUSH AF
L1030:
        LD    HL,(0500AH)
L1031:
        PUSH  HL
        LD    HL,(05002H)
L1032:
        LD    DE,2
        ADD   HL,DE
L1033:
        POP   DE
        EX    DE,HL
        CALL  div16
L1034:
        POP  AF
L1035:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1036:
        JP    NC,L1040
L1037:
        LD    A,106
L1038:
        CALL  writeA
L1039:
        ;;test5.j(131)   if (1+4 > twelve/(one+2)) write(107);
L1040:
        LD    A,1
L1041:
        ADD   A,4
L1042:
        PUSH AF
L1043:
        LD    HL,(0500AH)
L1044:
        PUSH  HL
        LD    HL,(05002H)
L1045:
        LD    DE,2
        ADD   HL,DE
L1046:
        POP   DE
        EX    DE,HL
        CALL  div16
L1047:
        POP  AF
L1048:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1049:
        JP    Z,L1053
L1050:
        LD    A,107
L1051:
        CALL  writeA
L1052:
        ;;test5.j(132)   if (1+2 <= twelve/(one+2)) write(108);
L1053:
        LD    A,1
L1054:
        ADD   A,2
L1055:
        PUSH AF
L1056:
        LD    HL,(0500AH)
L1057:
        PUSH  HL
        LD    HL,(05002H)
L1058:
        LD    DE,2
        ADD   HL,DE
L1059:
        POP   DE
        EX    DE,HL
        CALL  div16
L1060:
        POP  AF
L1061:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1062:
        JR    Z,$+5
        JP    C,L1066
L1063:
        LD    A,108
L1064:
        CALL  writeA
L1065:
        ;;test5.j(133)   if (1+3 <= twelve/(one+2)) write(109);
L1066:
        LD    A,1
L1067:
        ADD   A,3
L1068:
        PUSH AF
L1069:
        LD    HL,(0500AH)
L1070:
        PUSH  HL
        LD    HL,(05002H)
L1071:
        LD    DE,2
        ADD   HL,DE
L1072:
        POP   DE
        EX    DE,HL
        CALL  div16
L1073:
        POP  AF
L1074:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1075:
        JR    Z,$+5
        JP    C,L1079
L1076:
        LD    A,109
L1077:
        CALL  writeA
L1078:
        ;;test5.j(134)   if (1+3 >= twelve/(one+2)) write(110);
L1079:
        LD    A,1
L1080:
        ADD   A,3
L1081:
        PUSH AF
L1082:
        LD    HL,(0500AH)
L1083:
        PUSH  HL
        LD    HL,(05002H)
L1084:
        LD    DE,2
        ADD   HL,DE
L1085:
        POP   DE
        EX    DE,HL
        CALL  div16
L1086:
        POP  AF
L1087:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1088:
        JP    C,L1092
L1089:
        LD    A,110
L1090:
        CALL  writeA
L1091:
        ;;test5.j(135)   if (1+4 >= twelve/(one+2)) write(111);
L1092:
        LD    A,1
L1093:
        ADD   A,4
L1094:
        PUSH AF
L1095:
        LD    HL,(0500AH)
L1096:
        PUSH  HL
        LD    HL,(05002H)
L1097:
        LD    DE,2
        ADD   HL,DE
L1098:
        POP   DE
        EX    DE,HL
        CALL  div16
L1099:
        POP  AF
L1100:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1101:
        JP    C,L1105
L1102:
        LD    A,111
L1103:
        CALL  writeA
L1104:
        ;;test5.j(136)   if (4 == 12/(1+2)) write(112);
L1105:
        LD    A,12
L1106:
        PUSH  AF
        LD    A,1
L1107:
        ADD   A,2
L1108:
        LD    C,A
        POP   AF
        CALL  div8
L1109:
        SUB   A,4
L1110:
        JP    NZ,L1114
L1111:
        LD    A,112
L1112:
        CALL  writeA
L1113:
        ;;test5.j(137)   if (3 != 12/(1+2)) write(113);
L1114:
        LD    A,12
L1115:
        PUSH  AF
        LD    A,1
L1116:
        ADD   A,2
L1117:
        LD    C,A
        POP   AF
        CALL  div8
L1118:
        SUB   A,3
L1119:
        JP    Z,L1123
L1120:
        LD    A,113
L1121:
        CALL  writeA
L1122:
        ;;test5.j(138)   if (3 < 12/(1+2)) write(114);
L1123:
        LD    A,12
L1124:
        PUSH  AF
        LD    A,1
L1125:
        ADD   A,2
L1126:
        LD    C,A
        POP   AF
        CALL  div8
L1127:
        SUB   A,3
L1128:
        JP    Z,L1132
L1129:
        LD    A,114
L1130:
        CALL  writeA
L1131:
        ;;test5.j(139)   if (5 > 12/(1+2)) write(115);
L1132:
        LD    A,12
L1133:
        PUSH  AF
        LD    A,1
L1134:
        ADD   A,2
L1135:
        LD    C,A
        POP   AF
        CALL  div8
L1136:
        SUB   A,5
L1137:
        JP    NC,L1141
L1138:
        LD    A,115
L1139:
        CALL  writeA
L1140:
        ;;test5.j(140)   if (3 <= 12/(1+2)) write(116);
L1141:
        LD    A,12
L1142:
        PUSH  AF
        LD    A,1
L1143:
        ADD   A,2
L1144:
        LD    C,A
        POP   AF
        CALL  div8
L1145:
        SUB   A,3
L1146:
        JP    C,L1150
L1147:
        LD    A,116
L1148:
        CALL  writeA
L1149:
        ;;test5.j(141)   if (4 <= 12/(1+2)) write(117);
L1150:
        LD    A,12
L1151:
        PUSH  AF
        LD    A,1
L1152:
        ADD   A,2
L1153:
        LD    C,A
        POP   AF
        CALL  div8
L1154:
        SUB   A,4
L1155:
        JP    C,L1159
L1156:
        LD    A,117
L1157:
        CALL  writeA
L1158:
        ;;test5.j(142)   if (4 >= 12/(1+2)) write(118);
L1159:
        LD    A,12
L1160:
        PUSH  AF
        LD    A,1
L1161:
        ADD   A,2
L1162:
        LD    C,A
        POP   AF
        CALL  div8
L1163:
        SUB   A,4
L1164:
        JR    Z,$+5
        JP    C,L1168
L1165:
        LD    A,118
L1166:
        CALL  writeA
L1167:
        ;;test5.j(143)   if (5 >= 12/(1+2)) write(119);
L1168:
        LD    A,12
L1169:
        PUSH  AF
        LD    A,1
L1170:
        ADD   A,2
L1171:
        LD    C,A
        POP   AF
        CALL  div8
L1172:
        SUB   A,5
L1173:
        JR    Z,$+5
        JP    C,L1177
L1174:
        LD    A,119
L1175:
        CALL  writeA
L1176:
        ;;test5.j(144)   if (4 == twelve/(one+2)) write(120);
L1177:
        LD    HL,(0500AH)
L1178:
        PUSH  HL
        LD    HL,(05002H)
L1179:
        LD    DE,2
        ADD   HL,DE
L1180:
        POP   DE
        EX    DE,HL
        CALL  div16
L1181:
        LD    A,4
L1182:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1183:
        JP    NZ,L1187
L1184:
        LD    A,120
L1185:
        CALL  writeA
L1186:
        ;;test5.j(145)   if (3 != twelve/(one+2)) write(121);
L1187:
        LD    HL,(0500AH)
L1188:
        PUSH  HL
        LD    HL,(05002H)
L1189:
        LD    DE,2
        ADD   HL,DE
L1190:
        POP   DE
        EX    DE,HL
        CALL  div16
L1191:
        LD    A,3
L1192:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1193:
        JP    Z,L1197
L1194:
        LD    A,121
L1195:
        CALL  writeA
L1196:
        ;;test5.j(146)   if (2 < twelve/(one+2)) write(122);
L1197:
        LD    HL,(0500AH)
L1198:
        PUSH  HL
        LD    HL,(05002H)
L1199:
        LD    DE,2
        ADD   HL,DE
L1200:
        POP   DE
        EX    DE,HL
        CALL  div16
L1201:
        LD    A,2
L1202:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1203:
        JP    NC,L1207
L1204:
        LD    A,122
L1205:
        CALL  writeA
L1206:
        ;;test5.j(147)   if (5 > twelve/(one+2)) write(123);
L1207:
        LD    HL,(0500AH)
L1208:
        PUSH  HL
        LD    HL,(05002H)
L1209:
        LD    DE,2
        ADD   HL,DE
L1210:
        POP   DE
        EX    DE,HL
        CALL  div16
L1211:
        LD    A,5
L1212:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1213:
        JP    Z,L1217
L1214:
        LD    A,123
L1215:
        CALL  writeA
L1216:
        ;;test5.j(148)   if (3 <= twelve/(one+2)) write(124);
L1217:
        LD    HL,(0500AH)
L1218:
        PUSH  HL
        LD    HL,(05002H)
L1219:
        LD    DE,2
        ADD   HL,DE
L1220:
        POP   DE
        EX    DE,HL
        CALL  div16
L1221:
        LD    A,3
L1222:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1223:
        JR    Z,$+5
        JP    C,L1227
L1224:
        LD    A,124
L1225:
        CALL  writeA
L1226:
        ;;test5.j(149)   if (4 <= twelve/(one+2)) write(125);
L1227:
        LD    HL,(0500AH)
L1228:
        PUSH  HL
        LD    HL,(05002H)
L1229:
        LD    DE,2
        ADD   HL,DE
L1230:
        POP   DE
        EX    DE,HL
        CALL  div16
L1231:
        LD    A,4
L1232:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1233:
        JR    Z,$+5
        JP    C,L1237
L1234:
        LD    A,125
L1235:
        CALL  writeA
L1236:
        ;;test5.j(150)   if (4 >= twelve/(one+2)) write(126);
L1237:
        LD    HL,(0500AH)
L1238:
        PUSH  HL
        LD    HL,(05002H)
L1239:
        LD    DE,2
        ADD   HL,DE
L1240:
        POP   DE
        EX    DE,HL
        CALL  div16
L1241:
        LD    A,4
L1242:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1243:
        JP    C,L1247
L1244:
        LD    A,126
L1245:
        CALL  writeA
L1246:
        ;;test5.j(151)   if (5 >= twelve/(one+2)) write(127);
L1247:
        LD    HL,(0500AH)
L1248:
        PUSH  HL
        LD    HL,(05002H)
L1249:
        LD    DE,2
        ADD   HL,DE
L1250:
        POP   DE
        EX    DE,HL
        CALL  div16
L1251:
        LD    A,5
L1252:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1253:
        JP    C,L1257
L1254:
        LD    A,127
L1255:
        CALL  writeA
L1256:
        ;;test5.j(152)   if (four == 0 + 12/(1 + 2)) write(128);
L1257:
        LD    A,0
L1258:
        PUSH  AF
        LD    A,12
L1259:
        PUSH  AF
        LD    A,1
L1260:
        ADD   A,2
L1261:
        LD    C,A
        POP   AF
        CALL  div8
L1262:
        POP   BC
        ADD   A,B
L1263:
        LD    HL,(05006H)
L1264:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1265:
        JP    NZ,L1269
L1266:
        LD    A,128
L1267:
        CALL  writeA
L1268:
        ;;test5.j(153)   if (four == 0 + 12/(1 + 2)) write(129);
L1269:
        LD    A,0
L1270:
        PUSH  AF
        LD    A,12
L1271:
        PUSH  AF
        LD    A,1
L1272:
        ADD   A,2
L1273:
        LD    C,A
        POP   AF
        CALL  div8
L1274:
        POP   BC
        ADD   A,B
L1275:
        LD    HL,(05006H)
L1276:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1277:
        JP    NZ,L1281
L1278:
        LD    A,129
L1279:
        CALL  writeA
L1280:
        ;;test5.j(154)   if (four == 0 + 12/(byteOne + 2)) write(130);
L1281:
        LD    A,0
L1282:
        PUSH  AF
        LD    A,12
L1283:
        PUSH  AF
        LD    A,(0500CH)
L1284:
        ADD   A,2
L1285:
        LD    C,A
        POP   AF
        CALL  div8
L1286:
        POP   BC
        ADD   A,B
L1287:
        LD    HL,(05006H)
L1288:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1289:
        JP    NZ,L1293
L1290:
        LD    A,130
L1291:
        CALL  writeA
L1292:
        ;;test5.j(155)   if (four == 0 + 12/(one + 2)) write(131);
L1293:
        LD    A,0
L1294:
        PUSH  AF
        LD    A,12
L1295:
        LD    HL,(05002H)
L1296:
        LD    DE,2
        ADD   HL,DE
L1297:
        EX    DE,HL
        CALL  div8_16
L1298:
        POP   DE
        LD    D,0
        ADD   HL,DE
L1299:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L1300:
        JP    NZ,L1304
L1301:
        LD    A,131
L1302:
        CALL  writeA
L1303:
        ;;test5.j(156)   if (4 == zero + twelve/(1+2)) write(132);
L1304:
        LD    HL,(05000H)
L1305:
        PUSH  HL
        LD    HL,(0500AH)
L1306:
        LD    A,1
L1307:
        ADD   A,2
L1308:
        CALL  div16_8
L1309:
        POP   DE
        ADD   HL,DE
L1310:
        LD    A,4
L1311:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1312:
        JP    NZ,L1319
L1313:
        LD    A,132
L1314:
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
        LD    A,133
L1320:
        LD    (0500EH),A
L1321:
        ;;test5.j(161)   if (b>132) {
L1322:
        LD    A,(0500EH)
L1323:
        SUB   A,132
L1324:
        JP    Z,L1342
L1325:
        ;;test5.j(162)     word j = 1001;
L1326:
        LD    HL,1001
L1327:
        LD    (0500FH),HL
L1328:
        ;;test5.j(163)     byte c = b;
L1329:
        LD    A,(0500EH)
L1330:
        LD    (05011H),A
L1331:
        ;;test5.j(164)     byte d = c;
L1332:
        LD    A,(05011H)
L1333:
        LD    (05012H),A
L1334:
        ;;test5.j(165)     b--;
L1335:
        LD    HL,(0500EH)
        DEC   (HL)
L1336:
        ;;test5.j(166)     write (c);
L1337:
        LD    A,(05011H)
L1338:
        CALL  writeA
L1339:
        ;;test5.j(167)   } else {
L1340:
        JP    L1348
L1341:
        ;;test5.j(168)     write(999);
L1342:
        LD    HL,999
L1343:
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
        LD    A,134
L1349:
        CALL  writeA
L1350:
        ;;test5.j(173)   write("Klaar");
L1351:
        LD    HL,1355
L1352:
        CALL  putStr
L1353:
        ;;test5.j(174) }
L1354:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L1355:
        .ASCIZ  "Klaar"
