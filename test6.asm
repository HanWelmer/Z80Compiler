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
        ;;test6.j(0) /*
L1:
        ;;test6.j(1)  * A small program in the miniJava language.
L2:
        ;;test6.j(2)  * Test 8-bit and 16-bit expressions.
L3:
        ;;test6.j(3)  */
L4:
        ;;test6.j(4) class Test8And16BitExpressions {
L5:
        ;;test6.j(5)   write(0);         // 0
L6:
        LD    A,0
L7:
        CALL  writeA
L8:
        ;;test6.j(6)   //LD    A,0
L9:
        ;;test6.j(7)   //CALL  writeA
L10:
        ;;test6.j(8)   //OK
L11:
        ;;test6.j(9) 
L12:
        ;;test6.j(10)   /*********************/
L13:
        ;;test6.j(11)   /* Single term 8-bit */
L14:
        ;;test6.j(12)   /*********************/
L15:
        ;;test6.j(13)   byte b = 1;
L16:
        LD    A,1
L17:
        LD    (05000H),A
L18:
        ;;test6.j(14)   byte c = 4;
L19:
        LD    A,4
L20:
        LD    (05001H),A
L21:
        ;;test6.j(15)   write(b);         // 1
L22:
        LD    A,(05000H)
L23:
        CALL  writeA
L24:
        ;;test6.j(16)   //LD    A,1
L25:
        ;;test6.j(17)   //LD    (04000H),A
L26:
        ;;test6.j(18)   //LD    A,(04000H)
L27:
        ;;test6.j(19)   //CALL  writeA
L28:
        ;;test6.j(20)   //OK
L29:
        ;;test6.j(21) 
L30:
        ;;test6.j(22)   /************************/
L31:
        ;;test6.j(23)   /* Dual term addition   */
L32:
        ;;test6.j(24)   /************************/
L33:
        ;;test6.j(25)   write(0 + 2);     // 2
L34:
        LD    A,0
L35:
        ADD   A,2
L36:
        CALL  writeA
L37:
        ;;test6.j(26)   write(b + 2);     // 3
L38:
        LD    A,(05000H)
L39:
        ADD   A,2
L40:
        CALL  writeA
L41:
        ;;test6.j(27)   write(3 + b);     // 4
L42:
        LD    A,3
L43:
        LD    B,A
        LD    A,(05000H)
        ADD   A,B
L44:
        CALL  writeA
L45:
        ;;test6.j(28)   write(b + c);     // 5
L46:
        LD    A,(05000H)
L47:
        LD    B,A
        LD    A,(05001H)
        ADD   A,B
L48:
        CALL  writeA
L49:
        ;;test6.j(29) 
L50:
        ;;test6.j(30)   c = 4 + 2;
L51:
        LD    A,4
L52:
        ADD   A,2
L53:
        LD    (05001H),A
L54:
        ;;test6.j(31)   write(c);         // 6
L55:
        LD    A,(05001H)
L56:
        CALL  writeA
L57:
        ;;test6.j(32)   c = b + 6;
L58:
        LD    A,(05000H)
L59:
        ADD   A,6
L60:
        LD    (05001H),A
L61:
        ;;test6.j(33)   write(c);         // 7
L62:
        LD    A,(05001H)
L63:
        CALL  writeA
L64:
        ;;test6.j(34)   c = 7 + b;
L65:
        LD    A,7
L66:
        LD    B,A
        LD    A,(05000H)
        ADD   A,B
L67:
        LD    (05001H),A
L68:
        ;;test6.j(35)   write(c);         // 8
L69:
        LD    A,(05001H)
L70:
        CALL  writeA
L71:
        ;;test6.j(36)   c = b + c;
L72:
        LD    A,(05000H)
L73:
        LD    B,A
        LD    A,(05001H)
        ADD   A,B
L74:
        LD    (05001H),A
L75:
        ;;test6.j(37)   write(c);         // 9
L76:
        LD    A,(05001H)
L77:
        CALL  writeA
L78:
        ;;test6.j(38) 
L79:
        ;;test6.j(39) 
L80:
        ;;test6.j(40)   word i = 10;
L81:
        LD    A,10
L82:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L83:
        ;;test6.j(41)   write(i);         // 10
L84:
        LD    HL,(05002H)
L85:
        CALL  writeHL
L86:
        ;;test6.j(42)   //LD    A,10
L87:
        ;;test6.j(43)   //LD    L,A
L88:
        ;;test6.j(44)   //LD    H,0
L89:
        ;;test6.j(45)   //LD    (04004H),HL
L90:
        ;;test6.j(46)   //OK
L91:
        ;;test6.j(47)   
L92:
        ;;test6.j(48)   write(i + 1);     // 11
L93:
        LD    HL,(05002H)
L94:
        LD    DE,1
        ADD   HL,DE
L95:
        CALL  writeHL
L96:
        ;;test6.j(49)   write(2 + i);     // 12
L97:
        LD    A,2
L98:
        LD    L,A
        LD    H,0
L99:
        LD    DE,(05002H)
        ADD   HL,DE
L100:
        CALL  writeHL
L101:
        ;;test6.j(50)   b = 3;
L102:
        LD    A,3
L103:
        LD    (05000H),A
L104:
        ;;test6.j(51)   write(i + b);     // 13
L105:
        LD    HL,(05002H)
L106:
        LD    DE,(05000H)
        ADD   HL,DE
L107:
        CALL  writeHL
L108:
        ;;test6.j(52)   b++; //4
L109:
        LD    HL,(05000H)
        INC   (HL)
L110:
        ;;test6.j(53)   write(b + i);     // 14
L111:
        LD    A,(05000H)
L112:
        LD    L,A
        LD    H,0
L113:
        LD    DE,(05002H)
        ADD   HL,DE
L114:
        CALL  writeHL
L115:
        ;;test6.j(54) 
L116:
        ;;test6.j(55)   word j = i + 5;    // 15
L117:
        LD    HL,(05002H)
L118:
        LD    DE,5
        ADD   HL,DE
L119:
        LD    (05004H),HL
L120:
        ;;test6.j(56)   write(j);
L121:
        LD    HL,(05004H)
L122:
        CALL  writeHL
L123:
        ;;test6.j(57)   j = 6 + i;        // 16
L124:
        LD    A,6
L125:
        LD    L,A
        LD    H,0
L126:
        LD    DE,(05002H)
        ADD   HL,DE
L127:
        LD    (05004H),HL
L128:
        ;;test6.j(58)   write(j);
L129:
        LD    HL,(05004H)
L130:
        CALL  writeHL
L131:
        ;;test6.j(59)   j = 7;
L132:
        LD    A,7
L133:
        LD    L,A
        LD    H,0
        LD    (05004H),HL
L134:
        ;;test6.j(60)   j = i + j;        // 17
L135:
        LD    HL,(05002H)
L136:
        LD    DE,(05004H)
        ADD   HL,DE
L137:
        LD    (05004H),HL
L138:
        ;;test6.j(61)   write(j);
L139:
        LD    HL,(05004H)
L140:
        CALL  writeHL
L141:
        ;;test6.j(62) 
L142:
        ;;test6.j(63)   /*************************/
L143:
        ;;test6.j(64)   /* Dual term subtraction */
L144:
        ;;test6.j(65)   /*************************/
L145:
        ;;test6.j(66)   b = 33;
L146:
        LD    A,33
L147:
        LD    (05000H),A
L148:
        ;;test6.j(67)   c = 12;
L149:
        LD    A,12
L150:
        LD    (05001H),A
L151:
        ;;test6.j(68)   write(19 - 1);    // 18
L152:
        LD    A,19
L153:
        SUB   A,1
L154:
        CALL  writeA
L155:
        ;;test6.j(69)   write(b - 14);    // 19
L156:
        LD    A,(05000H)
L157:
        SUB   A,14
L158:
        CALL  writeA
L159:
        ;;test6.j(70)   write(53 - b);    // 20
L160:
        LD    A,53
L161:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L162:
        CALL  writeA
L163:
        ;;test6.j(71)   write(b - c);     // 21
L164:
        LD    A,(05000H)
L165:
        LD    B,A
        LD    A,(05001H)
        SUB   A,B
L166:
        CALL  writeA
L167:
        ;;test6.j(72) 
L168:
        ;;test6.j(73)   c = 24 - 2;
L169:
        LD    A,24
L170:
        SUB   A,2
L171:
        LD    (05001H),A
L172:
        ;;test6.j(74)   write(c);         // 22
L173:
        LD    A,(05001H)
L174:
        CALL  writeA
L175:
        ;;test6.j(75)   c = b - 10;
L176:
        LD    A,(05000H)
L177:
        SUB   A,10
L178:
        LD    (05001H),A
L179:
        ;;test6.j(76)   write(c);         // 23
L180:
        LD    A,(05001H)
L181:
        CALL  writeA
L182:
        ;;test6.j(77)   c = 57 - b;
L183:
        LD    A,57
L184:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L185:
        LD    (05001H),A
L186:
        ;;test6.j(78)   write(c);         // 24
L187:
        LD    A,(05001H)
L188:
        CALL  writeA
L189:
        ;;test6.j(79)   c = 8;
L190:
        LD    A,8
L191:
        LD    (05001H),A
L192:
        ;;test6.j(80)   c = b - c;
L193:
        LD    A,(05000H)
L194:
        LD    B,A
        LD    A,(05001H)
        SUB   A,B
L195:
        LD    (05001H),A
L196:
        ;;test6.j(81)   write(c);         // 25
L197:
        LD    A,(05001H)
L198:
        CALL  writeA
L199:
        ;;test6.j(82) 
L200:
        ;;test6.j(83)   i = 40;
L201:
        LD    A,40
L202:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L203:
        ;;test6.j(84)   write(i - 14);    // 26
L204:
        LD    HL,(05002H)
L205:
        LD    DE,14
        OR    A
        SBC   HL,DE
L206:
        CALL  writeHL
L207:
        ;;test6.j(85)   write(67 - i);    // 27
L208:
        LD    A,67
L209:
        LD    L,A
        LD    H,0
L210:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L211:
        CALL  writeHL
L212:
        ;;test6.j(86)   b = 12;
L213:
        LD    A,12
L214:
        LD    (05000H),A
L215:
        ;;test6.j(87)   write(i - b);     // 28
L216:
        LD    HL,(05002H)
L217:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L218:
        CALL  writeHL
L219:
        ;;test6.j(88)   b = 69;
L220:
        LD    A,69
L221:
        LD    (05000H),A
L222:
        ;;test6.j(89)   write(b - i);     // 29
L223:
        LD    A,(05000H)
L224:
        LD    L,A
        LD    H,0
L225:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L226:
        CALL  writeHL
L227:
        ;;test6.j(90) 
L228:
        ;;test6.j(91)   j = i - 10;
L229:
        LD    HL,(05002H)
L230:
        LD    DE,10
        OR    A
        SBC   HL,DE
L231:
        LD    (05004H),HL
L232:
        ;;test6.j(92)   write(j);         // 30
L233:
        LD    HL,(05004H)
L234:
        CALL  writeHL
L235:
        ;;test6.j(93)   j = 71 - i;
L236:
        LD    A,71
L237:
        LD    L,A
        LD    H,0
L238:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L239:
        LD    (05004H),HL
L240:
        ;;test6.j(94)   write(j);         // 31
L241:
        LD    HL,(05004H)
L242:
        CALL  writeHL
L243:
        ;;test6.j(95)   j = 8;
L244:
        LD    A,8
L245:
        LD    L,A
        LD    H,0
        LD    (05004H),HL
L246:
        ;;test6.j(96)   j = i - j;
L247:
        LD    HL,(05002H)
L248:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L249:
        LD    (05004H),HL
L250:
        ;;test6.j(97)   write(j);         // 32
L251:
        LD    HL,(05004H)
L252:
        CALL  writeHL
L253:
        ;;test6.j(98)   
L254:
        ;;test6.j(99)   /****************************/
L255:
        ;;test6.j(100)   /* Dual term multiplication */
L256:
        ;;test6.j(101)   /****************************/
L257:
        ;;test6.j(102)   write(3 * 11);    // 33
L258:
        LD    A,3
L259:
        LD    B,A
        LD    C,11
        MLT   BC
        LD    A,C
L260:
        CALL  writeA
L261:
        ;;test6.j(103)   b = 17;
L262:
        LD    A,17
L263:
        LD    (05000H),A
L264:
        ;;test6.j(104)   write(b * 2);     // 34
L265:
        LD    A,(05000H)
L266:
        LD    B,A
        LD    C,2
        MLT   BC
        LD    A,C
L267:
        CALL  writeA
L268:
        ;;test6.j(105)   b = 7;
L269:
        LD    A,7
L270:
        LD    (05000H),A
L271:
        ;;test6.j(106)   write(5 * b);     // 35
L272:
        LD    A,5
L273:
        LD    B,A
        LD    A,(05000H)
        LD    C,A
        MLT   BC
        LD    A,C
L274:
        CALL  writeA
L275:
        ;;test6.j(107)   b = 2;
L276:
        LD    A,2
L277:
        LD    (05000H),A
L278:
        ;;test6.j(108)   c = 18;
L279:
        LD    A,18
L280:
        LD    (05001H),A
L281:
        ;;test6.j(109)   write(b * c);     // 36
L282:
        LD    A,(05000H)
L283:
        LD    B,A
        LD    A,(05001H)
        LD    C,A
        MLT   BC
        LD    A,C
L284:
        CALL  writeA
L285:
        ;;test6.j(110)   
L286:
        ;;test6.j(111)   c = 37 * 1;
L287:
        LD    A,37
L288:
        LD    B,A
        LD    C,1
        MLT   BC
        LD    A,C
L289:
        LD    (05001H),A
L290:
        ;;test6.j(112)   write(c);         // 37
L291:
        LD    A,(05001H)
L292:
        CALL  writeA
L293:
        ;;test6.j(113)   b = 2;
L294:
        LD    A,2
L295:
        LD    (05000H),A
L296:
        ;;test6.j(114)   c = b * 19;
L297:
        LD    A,(05000H)
L298:
        LD    B,A
        LD    C,19
        MLT   BC
        LD    A,C
L299:
        LD    (05001H),A
L300:
        ;;test6.j(115)   write(c);         // 38
L301:
        LD    A,(05001H)
L302:
        CALL  writeA
L303:
        ;;test6.j(116)   b = 3;
L304:
        LD    A,3
L305:
        LD    (05000H),A
L306:
        ;;test6.j(117)   c = 13 * b;
L307:
        LD    A,13
L308:
        LD    B,A
        LD    A,(05000H)
        LD    C,A
        MLT   BC
        LD    A,C
L309:
        LD    (05001H),A
L310:
        ;;test6.j(118)   write(c);         // 39
L311:
        LD    A,(05001H)
L312:
        CALL  writeA
L313:
        ;;test6.j(119)   b = 5;
L314:
        LD    A,5
L315:
        LD    (05000H),A
L316:
        ;;test6.j(120)   c = 8;
L317:
        LD    A,8
L318:
        LD    (05001H),A
L319:
        ;;test6.j(121)   c = b * c;
L320:
        LD    A,(05000H)
L321:
        LD    B,A
        LD    A,(05001H)
        LD    C,A
        MLT   BC
        LD    A,C
L322:
        LD    (05001H),A
L323:
        ;;test6.j(122)   write(c);         // 40
L324:
        LD    A,(05001H)
L325:
        CALL  writeA
L326:
        ;;test6.j(123) 
L327:
        ;;test6.j(124)   /**********************/
L328:
        ;;test6.j(125)   /* Dual term division */
L329:
        ;;test6.j(126)   /**********************/
L330:
        ;;test6.j(127)   write(123 / 3);   // 41
L331:
        LD    A,123
L332:
        LD    C,3
        CALL  div8
L333:
        CALL  writeA
L334:
        ;;test6.j(128)   b = 126;
L335:
        LD    A,126
L336:
        LD    (05000H),A
L337:
        ;;test6.j(129)   write(b / 3);     // 42
L338:
        LD    A,(05000H)
L339:
        LD    C,3
        CALL  div8
L340:
        CALL  writeA
L341:
        ;;test6.j(130)   b = 3;
L342:
        LD    A,3
L343:
        LD    (05000H),A
L344:
        ;;test6.j(131)   write(129 / b);   // 43
L345:
        LD    A,129
L346:
        LD    B,A
        LD    A,(05000H)
        LD    C,A
        LD    A,B
        CALL  div8
L347:
        CALL  writeA
L348:
        ;;test6.j(132)   b = 132;
L349:
        LD    A,132
L350:
        LD    (05000H),A
L351:
        ;;test6.j(133)   c = 3;
L352:
        LD    A,3
L353:
        LD    (05001H),A
L354:
        ;;test6.j(134)   write(b / c);     // 44
L355:
        LD    A,(05000H)
L356:
        LD    B,A
        LD    A,(05001H)
        LD    C,A
        LD    A,B
        CALL  div8
L357:
        CALL  writeA
L358:
        ;;test6.j(135)   
L359:
        ;;test6.j(136)   c = 135 / 3;
L360:
        LD    A,135
L361:
        LD    C,3
        CALL  div8
L362:
        LD    (05001H),A
L363:
        ;;test6.j(137)   write(c);         // 45
L364:
        LD    A,(05001H)
L365:
        CALL  writeA
L366:
        ;;test6.j(138)   b = 138;
L367:
        LD    A,138
L368:
        LD    (05000H),A
L369:
        ;;test6.j(139)   c = b / 3;
L370:
        LD    A,(05000H)
L371:
        LD    C,3
        CALL  div8
L372:
        LD    (05001H),A
L373:
        ;;test6.j(140)   write(c);         // 46
L374:
        LD    A,(05001H)
L375:
        CALL  writeA
L376:
        ;;test6.j(141)   b = 3;
L377:
        LD    A,3
L378:
        LD    (05000H),A
L379:
        ;;test6.j(142)   c = 141 / b;
L380:
        LD    A,141
L381:
        LD    B,A
        LD    A,(05000H)
        LD    C,A
        LD    A,B
        CALL  div8
L382:
        LD    (05001H),A
L383:
        ;;test6.j(143)   write(c);         // 47
L384:
        LD    A,(05001H)
L385:
        CALL  writeA
L386:
        ;;test6.j(144)   b = 144;
L387:
        LD    A,144
L388:
        LD    (05000H),A
L389:
        ;;test6.j(145)   c = 3;
L390:
        LD    A,3
L391:
        LD    (05001H),A
L392:
        ;;test6.j(146)   c = b / c;
L393:
        LD    A,(05000H)
L394:
        LD    B,A
        LD    A,(05001H)
        LD    C,A
        LD    A,B
        CALL  div8
L395:
        LD    (05001H),A
L396:
        ;;test6.j(147)   write(c);         // 48
L397:
        LD    A,(05001H)
L398:
        CALL  writeA
L399:
        ;;test6.j(148) 
L400:
        ;;test6.j(149)   /*************************/
L401:
        ;;test6.j(150)   /* possible loss of data */
L402:
        ;;test6.j(151)   /*************************/
L403:
        ;;test6.j(152)   b = 507;
L404:
        LD    HL,507
L405:
        LD    A,L
        LD    (05000H),A
L406:
        ;;test6.j(153)   write(b);         // 251
L407:
        LD    A,(05000H)
L408:
        CALL  writeA
L409:
        ;;test6.j(154)   i = 508;
L410:
        LD    HL,508
L411:
        LD    (05002H),HL
L412:
        ;;test6.j(155)   b = i;
L413:
        LD    HL,(05002H)
L414:
        LD    A,L
        LD    (05000H),A
L415:
        ;;test6.j(156)   write(b);         // 252
L416:
        LD    A,(05000H)
L417:
        CALL  writeA
L418:
        ;;test6.j(157) 
L419:
        ;;test6.j(158)   b = b - 505;
L420:
        LD    A,(05000H)
L421:
        LD    L,A
        LD    H,0
L422:
        LD    DE,505
        OR    A
        SBC   HL,DE
L423:
        LD    A,L
        LD    (05000H),A
L424:
        ;;test6.j(159)   write(b);         // 252 - 505 = -253
L425:
        LD    A,(05000H)
L426:
        CALL  writeA
L427:
        ;;test6.j(160)   i = i + 5;
L428:
        LD    HL,(05002H)
L429:
        LD    DE,5
        ADD   HL,DE
L430:
        LD    (05002H),HL
L431:
        ;;test6.j(161)   b = b - i;
L432:
        LD    A,(05000H)
L433:
        LD    L,A
        LD    H,0
L434:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L435:
        LD    A,L
        LD    (05000H),A
L436:
        ;;test6.j(162)   write(b);         // -233 - 11 = -254
L437:
        LD    A,(05000H)
L438:
        CALL  writeA
L439:
        ;;test6.j(163)   
L440:
        ;;test6.j(164)   b = 255;
L441:
        LD    A,255
L442:
        LD    (05000H),A
L443:
        ;;test6.j(165)   write(b);         // 255
L444:
        LD    A,(05000H)
L445:
        CALL  writeA
L446:
        ;;test6.j(166)   //LD    A,255
L447:
        ;;test6.j(167)   //LD    (04001H),A
L448:
        ;;test6.j(168)   //LD    A,(04001H)
L449:
        ;;test6.j(169)   //CALL  writeA
L450:
        ;;test6.j(170)   //OK
L451:
        ;;test6.j(171) 
L452:
        ;;test6.j(172)   /**********************/
L453:
        ;;test6.j(173)   /* Single term 16-bit */
L454:
        ;;test6.j(174)   /**********************/
L455:
        ;;test6.j(175)   i = 256;
L456:
        LD    HL,256
L457:
        LD    (05002H),HL
L458:
        ;;test6.j(176)   write(i);         // 256
L459:
        LD    HL,(05002H)
L460:
        CALL  writeHL
L461:
        ;;test6.j(177)   //LD    HL,256
L462:
        ;;test6.j(178)   //LD    (04006H),HL
L463:
        ;;test6.j(179)   //LD    HL,(04006H)
L464:
        ;;test6.j(180)   //CALL  writeHL
L465:
        ;;test6.j(181)   //OK
L466:
        ;;test6.j(182) 
L467:
        ;;test6.j(183)   write(1000);      // 1000
L468:
        LD    HL,1000
L469:
        CALL  writeHL
L470:
        ;;test6.j(184)   j = 1001;
L471:
        LD    HL,1001
L472:
        LD    (05004H),HL
L473:
        ;;test6.j(185)   write(j);         // 1001
L474:
        LD    HL,(05004H)
L475:
        CALL  writeHL
L476:
        ;;test6.j(186) 
L477:
        ;;test6.j(187)   /************************/
L478:
        ;;test6.j(188)   /* Dual term addition   */
L479:
        ;;test6.j(189)   /************************/
L480:
        ;;test6.j(190)   write(1000 + 2);  // 1002
L481:
        LD    HL,1000
L482:
        LD    DE,2
        ADD   HL,DE
L483:
        CALL  writeHL
L484:
        ;;test6.j(191)   write(3 + 1000);  // 1003
L485:
        LD    A,3
L486:
        LD    L,A
        LD    H,0
L487:
        LD    DE,1000
        ADD   HL,DE
L488:
        CALL  writeHL
L489:
        ;;test6.j(192)   write(500 + 504); // 1004
L490:
        LD    HL,500
L491:
        LD    DE,504
        ADD   HL,DE
L492:
        CALL  writeHL
L493:
        ;;test6.j(193)   i = 1000 + 5;
L494:
        LD    HL,1000
L495:
        LD    DE,5
        ADD   HL,DE
L496:
        LD    (05002H),HL
L497:
        ;;test6.j(194)   write(i);         // 1005
L498:
        LD    HL,(05002H)
L499:
        CALL  writeHL
L500:
        ;;test6.j(195)   i = 6 + 1000;
L501:
        LD    A,6
L502:
        LD    L,A
        LD    H,0
L503:
        LD    DE,1000
        ADD   HL,DE
L504:
        LD    (05002H),HL
L505:
        ;;test6.j(196)   write(i);         // 1006
L506:
        LD    HL,(05002H)
L507:
        CALL  writeHL
L508:
        ;;test6.j(197)   i = 500 + 507;
L509:
        LD    HL,500
L510:
        LD    DE,507
        ADD   HL,DE
L511:
        LD    (05002H),HL
L512:
        ;;test6.j(198)   write(i);         // 1007
L513:
        LD    HL,(05002H)
L514:
        CALL  writeHL
L515:
        ;;test6.j(199)   
L516:
        ;;test6.j(200)   j = 1000;
L517:
        LD    HL,1000
L518:
        LD    (05004H),HL
L519:
        ;;test6.j(201)   b = 10;
L520:
        LD    A,10
L521:
        LD    (05000H),A
L522:
        ;;test6.j(202)   i = 514;
L523:
        LD    HL,514
L524:
        LD    (05002H),HL
L525:
        ;;test6.j(203)   write(j + 8);     // 1008
L526:
        LD    HL,(05004H)
L527:
        LD    DE,8
        ADD   HL,DE
L528:
        CALL  writeHL
L529:
        ;;test6.j(204)   write(9 + j);     // 1009
L530:
        LD    A,9
L531:
        LD    L,A
        LD    H,0
L532:
        LD    DE,(05004H)
        ADD   HL,DE
L533:
        CALL  writeHL
L534:
        ;;test6.j(205)   write(j + b);     // 1010
L535:
        LD    HL,(05004H)
L536:
        LD    DE,(05000H)
        ADD   HL,DE
L537:
        CALL  writeHL
L538:
        ;;test6.j(206)   b++;
L539:
        LD    HL,(05000H)
        INC   (HL)
L540:
        ;;test6.j(207)   write(b + j);     // 1011
L541:
        LD    A,(05000H)
L542:
        LD    L,A
        LD    H,0
L543:
        LD    DE,(05004H)
        ADD   HL,DE
L544:
        CALL  writeHL
L545:
        ;;test6.j(208)   j = 500;
L546:
        LD    HL,500
L547:
        LD    (05004H),HL
L548:
        ;;test6.j(209)   write(j + 512);   // 1012
L549:
        LD    HL,(05004H)
L550:
        LD    DE,512
        ADD   HL,DE
L551:
        CALL  writeHL
L552:
        ;;test6.j(210)   write(513 + j);   // 1013
L553:
        LD    HL,513
L554:
        LD    DE,(05004H)
        ADD   HL,DE
L555:
        CALL  writeHL
L556:
        ;;test6.j(211)   write(i + j);     // 1014
L557:
        LD    HL,(05002H)
L558:
        LD    DE,(05004H)
        ADD   HL,DE
L559:
        CALL  writeHL
L560:
        ;;test6.j(212)   
L561:
        ;;test6.j(213)   j = 1000;
L562:
        LD    HL,1000
L563:
        LD    (05004H),HL
L564:
        ;;test6.j(214)   b = 17;
L565:
        LD    A,17
L566:
        LD    (05000H),A
L567:
        ;;test6.j(215)   i = j + 15;
L568:
        LD    HL,(05004H)
L569:
        LD    DE,15
        ADD   HL,DE
L570:
        LD    (05002H),HL
L571:
        ;;test6.j(216)   write(i);         // 1015
L572:
        LD    HL,(05002H)
L573:
        CALL  writeHL
L574:
        ;;test6.j(217)   i = 16 + j;
L575:
        LD    A,16
L576:
        LD    L,A
        LD    H,0
L577:
        LD    DE,(05004H)
        ADD   HL,DE
L578:
        LD    (05002H),HL
L579:
        ;;test6.j(218)   write(i);         // 1016
L580:
        LD    HL,(05002H)
L581:
        CALL  writeHL
L582:
        ;;test6.j(219)   i = j + b;
L583:
        LD    HL,(05004H)
L584:
        LD    DE,(05000H)
        ADD   HL,DE
L585:
        LD    (05002H),HL
L586:
        ;;test6.j(220)   write(i);         // 1017
L587:
        LD    HL,(05002H)
L588:
        CALL  writeHL
L589:
        ;;test6.j(221)   b++;
L590:
        LD    HL,(05000H)
        INC   (HL)
L591:
        ;;test6.j(222)   i = b + j;
L592:
        LD    A,(05000H)
L593:
        LD    L,A
        LD    H,0
L594:
        LD    DE,(05004H)
        ADD   HL,DE
L595:
        LD    (05002H),HL
L596:
        ;;test6.j(223)   write(i);         // 1018
L597:
        LD    HL,(05002H)
L598:
        CALL  writeHL
L599:
        ;;test6.j(224)   j = 500;
L600:
        LD    HL,500
L601:
        LD    (05004H),HL
L602:
        ;;test6.j(225)   i = j + 519;
L603:
        LD    HL,(05004H)
L604:
        LD    DE,519
        ADD   HL,DE
L605:
        LD    (05002H),HL
L606:
        ;;test6.j(226)   write(i);         // 1019
L607:
        LD    HL,(05002H)
L608:
        CALL  writeHL
L609:
        ;;test6.j(227)   i = 520 + j;
L610:
        LD    HL,520
L611:
        LD    DE,(05004H)
        ADD   HL,DE
L612:
        LD    (05002H),HL
L613:
        ;;test6.j(228)   write(i);         // 1020
L614:
        LD    HL,(05002H)
L615:
        CALL  writeHL
L616:
        ;;test6.j(229)   i = 521;
L617:
        LD    HL,521
L618:
        LD    (05002H),HL
L619:
        ;;test6.j(230)   i = i + j;
L620:
        LD    HL,(05002H)
L621:
        LD    DE,(05004H)
        ADD   HL,DE
L622:
        LD    (05002H),HL
L623:
        ;;test6.j(231)   write(i);         // 1021
L624:
        LD    HL,(05002H)
L625:
        CALL  writeHL
L626:
        ;;test6.j(232)   
L627:
        ;;test6.j(233)   /*************************/
L628:
        ;;test6.j(234)   /* Dual term subtraction */
L629:
        ;;test6.j(235)   /*************************/
L630:
        ;;test6.j(236)   write(1024 - 2);  // 1022
L631:
        LD    HL,1024
L632:
        LD    DE,2
        OR    A
        SBC   HL,DE
L633:
        CALL  writeHL
L634:
        ;;test6.j(237)   write(1523 - 500);// 1023
L635:
        LD    HL,1523
L636:
        LD    DE,500
        OR    A
        SBC   HL,DE
L637:
        CALL  writeHL
L638:
        ;;test6.j(238)   i = 1030 - 6;
L639:
        LD    HL,1030
L640:
        LD    DE,6
        OR    A
        SBC   HL,DE
L641:
        LD    (05002H),HL
L642:
        ;;test6.j(239)   write(i);         // 1024
L643:
        LD    HL,(05002H)
L644:
        CALL  writeHL
L645:
        ;;test6.j(240)   i = 1525 - 500;
L646:
        LD    HL,1525
L647:
        LD    DE,500
        OR    A
        SBC   HL,DE
L648:
        LD    (05002H),HL
L649:
        ;;test6.j(241)   write(i);         // 1025
L650:
        LD    HL,(05002H)
L651:
        CALL  writeHL
L652:
        ;;test6.j(242)   
L653:
        ;;test6.j(243)   j = 1040;
L654:
        LD    HL,1040
L655:
        LD    (05004H),HL
L656:
        ;;test6.j(244)   b = 13;
L657:
        LD    A,13
L658:
        LD    (05000H),A
L659:
        ;;test6.j(245)   i = 3030;
L660:
        LD    HL,3030
L661:
        LD    (05002H),HL
L662:
        ;;test6.j(246)   write(j - 14);    // 1026
L663:
        LD    HL,(05004H)
L664:
        LD    DE,14
        OR    A
        SBC   HL,DE
L665:
        CALL  writeHL
L666:
        ;;test6.j(247)   write(j - b);     // 1027
L667:
        LD    HL,(05004H)
L668:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L669:
        CALL  writeHL
L670:
        ;;test6.j(248)   j = 2000;
L671:
        LD    HL,2000
L672:
        LD    (05004H),HL
L673:
        ;;test6.j(249)   write(j - 972);   // 1028
L674:
        LD    HL,(05004H)
L675:
        LD    DE,972
        OR    A
        SBC   HL,DE
L676:
        CALL  writeHL
L677:
        ;;test6.j(250)   write(3029 - j);  // 1029
L678:
        LD    HL,3029
L679:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L680:
        CALL  writeHL
L681:
        ;;test6.j(251)   write(i - j);     // 1030
L682:
        LD    HL,(05002H)
L683:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L684:
        CALL  writeHL
L685:
        ;;test6.j(252)   
L686:
        ;;test6.j(253)   j = 1050;
L687:
        LD    HL,1050
L688:
        LD    (05004H),HL
L689:
        ;;test6.j(254)   b = 18;
L690:
        LD    A,18
L691:
        LD    (05000H),A
L692:
        ;;test6.j(255)   i = j - 19;
L693:
        LD    HL,(05004H)
L694:
        LD    DE,19
        OR    A
        SBC   HL,DE
L695:
        LD    (05002H),HL
L696:
        ;;test6.j(256)   write(i);         // 1031
L697:
        LD    HL,(05002H)
L698:
        CALL  writeHL
L699:
        ;;test6.j(257)   i = j - b;
L700:
        LD    HL,(05004H)
L701:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L702:
        LD    (05002H),HL
L703:
        ;;test6.j(258)   write(i);         // 1032
L704:
        LD    HL,(05002H)
L705:
        CALL  writeHL
L706:
        ;;test6.j(259)   j = 2000;
L707:
        LD    HL,2000
L708:
        LD    (05004H),HL
L709:
        ;;test6.j(260)   i = j - 967;
L710:
        LD    HL,(05004H)
L711:
        LD    DE,967
        OR    A
        SBC   HL,DE
L712:
        LD    (05002H),HL
L713:
        ;;test6.j(261)   write(i);         // 1033
L714:
        LD    HL,(05002H)
L715:
        CALL  writeHL
L716:
        ;;test6.j(262)   i = 3034 - j;
L717:
        LD    HL,3034
L718:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L719:
        LD    (05002H),HL
L720:
        ;;test6.j(263)   write(i);         // 1034
L721:
        LD    HL,(05002H)
L722:
        CALL  writeHL
L723:
        ;;test6.j(264)   i = 3035;
L724:
        LD    HL,3035
L725:
        LD    (05002H),HL
L726:
        ;;test6.j(265)   i = i - j;
L727:
        LD    HL,(05002H)
L728:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L729:
        LD    (05002H),HL
L730:
        ;;test6.j(266)   write(i);         // 1035
L731:
        LD    HL,(05002H)
L732:
        CALL  writeHL
L733:
        ;;test6.j(267)   
L734:
        ;;test6.j(268)   /****************************/
L735:
        ;;test6.j(269)   /* Dual term multiplication */
L736:
        ;;test6.j(270)   /****************************/
L737:
        ;;test6.j(271)   write(518 * 2);   // 1036
L738:
        LD    HL,518
L739:
        LD    DE,2
        CALL  mul16
L740:
        CALL  writeHL
L741:
        ;;test6.j(272)   write(1 * 1037);  // 1037
L742:
        LD    A,1
L743:
        LD    L,A
        LD    H,0
L744:
        LD    DE,1037
        CALL  mul16
L745:
        CALL  writeHL
L746:
        ;;test6.j(273)   write(500 * 504 - 54354); // 1038 = 55392 - 54354
L747:
        LD    HL,500
L748:
        LD    DE,504
        CALL  mul16
L749:
        LD    DE,54354
        OR    A
        SBC   HL,DE
L750:
        CALL  writeHL
L751:
        ;;test6.j(274) 
L752:
        ;;test6.j(275)   i = 1039 * 1;
L753:
        LD    HL,1039
L754:
        LD    DE,1
        CALL  mul16
L755:
        LD    (05002H),HL
L756:
        ;;test6.j(276)   write(i);         // 1039
L757:
        LD    HL,(05002H)
L758:
        CALL  writeHL
L759:
        ;;test6.j(277)   i = 2 * 520;
L760:
        LD    A,2
L761:
        LD    L,A
        LD    H,0
L762:
        LD    DE,520
        CALL  mul16
L763:
        LD    (05002H),HL
L764:
        ;;test6.j(278)   write(i);         // 1040
L765:
        LD    HL,(05002H)
L766:
        CALL  writeHL
L767:
        ;;test6.j(279) 
L768:
        ;;test6.j(280)   i = 1041;
L769:
        LD    HL,1041
L770:
        LD    (05002H),HL
L771:
        ;;test6.j(281)   write(i * 1);     // 1041
L772:
        LD    HL,(05002H)
L773:
        LD    DE,1
        CALL  mul16
L774:
        CALL  writeHL
L775:
        ;;test6.j(282)   i = 521;
L776:
        LD    HL,521
L777:
        LD    (05002H),HL
L778:
        ;;test6.j(283)   write(2 * i);     // 1042
L779:
        LD    A,2
L780:
        LD    L,A
        LD    H,0
L781:
        LD    DE,(05002H)
        CALL  mul16
L782:
        CALL  writeHL
L783:
        ;;test6.j(284) 
L784:
        ;;test6.j(285)   i = 1043;
L785:
        LD    HL,1043
L786:
        LD    (05002H),HL
L787:
        ;;test6.j(286)   i = i * 1;
L788:
        LD    HL,(05002H)
L789:
        LD    DE,1
        CALL  mul16
L790:
        LD    (05002H),HL
L791:
        ;;test6.j(287)   write(i);         // 1043
L792:
        LD    HL,(05002H)
L793:
        CALL  writeHL
L794:
        ;;test6.j(288)   i = 522;
L795:
        LD    HL,522
L796:
        LD    (05002H),HL
L797:
        ;;test6.j(289)   i = 2 * i;
L798:
        LD    A,2
L799:
        LD    L,A
        LD    H,0
L800:
        LD    DE,(05002H)
        CALL  mul16
L801:
        LD    (05002H),HL
L802:
        ;;test6.j(290)   write(i);         // 1044
L803:
        LD    HL,(05002H)
L804:
        CALL  writeHL
L805:
        ;;test6.j(291) 
L806:
        ;;test6.j(292)   i = 500 * 504 - 54347; // 1045 = 55392 - 54347
L807:
        LD    HL,500
L808:
        LD    DE,504
        CALL  mul16
L809:
        LD    DE,54347
        OR    A
        SBC   HL,DE
L810:
        LD    (05002H),HL
L811:
        ;;test6.j(293)   write(i);         // 1045
L812:
        LD    HL,(05002H)
L813:
        CALL  writeHL
L814:
        ;;test6.j(294)   i = 500;
L815:
        LD    HL,500
L816:
        LD    (05002H),HL
L817:
        ;;test6.j(295)   i = i * 504 - 54346;
L818:
        LD    HL,(05002H)
L819:
        LD    DE,504
        CALL  mul16
L820:
        LD    DE,54346
        OR    A
        SBC   HL,DE
L821:
        LD    (05002H),HL
L822:
        ;;test6.j(296)   write(i);         // 1046
L823:
        LD    HL,(05002H)
L824:
        CALL  writeHL
L825:
        ;;test6.j(297)   i = 504;
L826:
        LD    HL,504
L827:
        LD    (05002H),HL
L828:
        ;;test6.j(298)   i = 500 * i - 54345;
L829:
        LD    HL,500
L830:
        LD    DE,(05002H)
        CALL  mul16
L831:
        LD    DE,54345
        OR    A
        SBC   HL,DE
L832:
        LD    (05002H),HL
L833:
        ;;test6.j(299)   write(i);         // 1047
L834:
        LD    HL,(05002H)
L835:
        CALL  writeHL
L836:
        ;;test6.j(300)   
L837:
        ;;test6.j(301)   /************/
L838:
        ;;test6.j(302)   /* Overflow */
L839:
        ;;test6.j(303)   /************/
L840:
        ;;test6.j(304)   write(300 * 301); // 90.300 % 65536 = 24.764
L841:
        LD    HL,300
L842:
        LD    DE,301
        CALL  mul16
L843:
        CALL  writeHL
L844:
        ;;test6.j(305)   i = 300 * 302;
L845:
        LD    HL,300
L846:
        LD    DE,302
        CALL  mul16
L847:
        LD    (05002H),HL
L848:
        ;;test6.j(306)   write(i);         // 90.600 % 65536 = 25.064
L849:
        LD    HL,(05002H)
L850:
        CALL  writeHL
L851:
        ;;test6.j(307) 
L852:
        ;;test6.j(308)   write("Klaar");
L853:
        LD    HL,857
L854:
        CALL  putStr
L855:
        ;;test6.j(309) }
L856:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L857:
        .ASCIZ  "Klaar"
