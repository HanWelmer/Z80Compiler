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
        ;;test7.j(0) /*
L1:
        ;;test7.j(1)  * A small program in the miniJava language.
L2:
        ;;test7.j(2)  * Test 8-bit and 16-bit expressions.
L3:
        ;;test7.j(3)  */
L4:
        ;;test7.j(4) class Test8And16BitExpressions {
L5:
        ;;test7.j(5)   /**************************/
L6:
        ;;test7.j(6)   /* Single term read: byte */
L7:
        ;;test7.j(7)   /**************************/
L8:
        ;;test7.j(8)   write(1);          // 1
L9:
        LD    A,1
L10:
        CALL  writeA
L11:
        ;;test7.j(9) 
L12:
        ;;test7.j(10)   write("Type 2, 3, 4 etc");
L13:
        LD    HL,243
L14:
        CALL  putStr
L15:
        ;;test7.j(11)   write(read);       // 2
L16:
        CALL  read
L17:
        CALL  writeHL
L18:
        ;;test7.j(12)   byte b = read;
L19:
        CALL  read
L20:
        LD    A,L
        LD    (05000H),A
L21:
        ;;test7.j(13)   write(b);       // 3
L22:
        LD    A,(05000H)
L23:
        CALL  writeA
L24:
        ;;test7.j(14) 
L25:
        ;;test7.j(15)   /**********************************/
L26:
        ;;test7.j(16)   /* Dual term read: byte constants */
L27:
        ;;test7.j(17)   /**********************************/
L28:
        ;;test7.j(18)   write(read + 0);   // 4 + 0 = 4
L29:
        CALL  read
L30:
        LD    DE,0
        ADD   HL,DE
L31:
        CALL  writeHL
L32:
        ;;test7.j(19)   write(0 + read);   // 0 + 5 = 5
L33:
        LD    A,0
L34:
        CALL  read
L35:
        LD    E,A
        LD    D,0
        ADD   HL,DE
L36:
        CALL  writeHL
L37:
        ;;test7.j(20)   write(read - 0);   // 6 - 0 = 6
L38:
        CALL  read
L39:
        LD    DE,0
        OR    A
        SBC   HL,DE
L40:
        CALL  writeHL
L41:
        ;;test7.j(21)   write(14 - read);  // 14 - 7 = 7
L42:
        LD    A,14
L43:
        CALL  read
L44:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L45:
        CALL  writeHL
L46:
        ;;test7.j(22)   write(read * 1);   // 8 * 1 = 8
L47:
        CALL  read
L48:
        LD    DE,1
        CALL  mul16
L49:
        CALL  writeHL
L50:
        ;;test7.j(23)   write(1 * read);   // 1 * 9 = 9
L51:
        LD    A,1
L52:
        CALL  read
L53:
        CALL  mul16_8
L54:
        CALL  writeHL
L55:
        ;;test7.j(24)   write(read / 1);   // 10 / 1 = 10
L56:
        CALL  read
L57:
        LD    DE,1
        CALL  div16
L58:
        CALL  writeHL
L59:
        ;;test7.j(25)   write(121 / read); // 121 / 11 = 11
L60:
        LD    A,121
L61:
        CALL  read
L62:
        EX    DE,HL
        CALL  div8_16
L63:
        CALL  writeHL
L64:
        ;;test7.j(26)   
L65:
        ;;test7.j(27)   write("Type 1048 etc");
L66:
        LD    HL,244
L67:
        CALL  putStr
L68:
        ;;test7.j(28)   /**************************/
L69:
        ;;test7.j(29)   /* Single term read: word */
L70:
        ;;test7.j(30)   /**************************/
L71:
        ;;test7.j(31)   write(read);      // 1048
L72:
        CALL  read
L73:
        CALL  writeHL
L74:
        ;;test7.j(32)   word i = read;
L75:
        CALL  read
L76:
        LD    (05001H),HL
L77:
        ;;test7.j(33)   write(i);         // 1049
L78:
        LD    HL,(05001H)
L79:
        CALL  writeHL
L80:
        ;;test7.j(34) 
L81:
        ;;test7.j(35)   /**********************************/
L82:
        ;;test7.j(36)   /* Dual term read: word constants */
L83:
        ;;test7.j(37)   /**********************************/
L84:
        ;;test7.j(38)   write(read + 1000);   // 1050 + 1000 = 2050
L85:
        CALL  read
L86:
        LD    DE,1000
        ADD   HL,DE
L87:
        CALL  writeHL
L88:
        ;;test7.j(39)   write(1000 + read);   // 1000 + 1051 = 2051
L89:
        LD    HL,1000
L90:
        PUSH HL
L91:
        CALL  read
L92:
        POP   DE
        ADD   HL,DE
L93:
        CALL  writeHL
L94:
        ;;test7.j(40)   write(read - 1000);   // 1052 - 1000 =   52
L95:
        CALL  read
L96:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L97:
        CALL  writeHL
L98:
        ;;test7.j(41)   write(2106 - read);   // 2106 - 1053 = 1053
L99:
        LD    HL,2106
L100:
        PUSH HL
L101:
        CALL  read
L102:
        POP   DE
        EX    DE,HL
        OR    A
        SBC   HL,DE
L103:
        CALL  writeHL
L104:
        ;;test7.j(42)   write(read * 1000);   // 1054 * 1000 = 5254
L105:
        CALL  read
L106:
        LD    DE,1000
        CALL  mul16
L107:
        CALL  writeHL
L108:
        ;;test7.j(43)   write(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
L109:
        LD    HL,1000
L110:
        PUSH HL
L111:
        CALL  read
L112:
        POP   DE
        CALL  mul16
L113:
        CALL  writeHL
L114:
        ;;test7.j(44)   write(read / 1000);   // 1056 / 1000 = 1
L115:
        CALL  read
L116:
        LD    DE,1000
        CALL  div16
L117:
        CALL  writeHL
L118:
        ;;test7.j(45)   write(2114 / read);   // 2114 / 1057 = 2
L119:
        LD    HL,2114
L120:
        PUSH HL
L121:
        CALL  read
L122:
        POP   DE
        EX    DE,HL
        CALL  div16
L123:
        CALL  writeHL
L124:
        ;;test7.j(46)   
L125:
        ;;test7.j(47)   /****************************************/
L126:
        ;;test7.j(48)   /* Dual term read: word + byte variable */
L127:
        ;;test7.j(49)   /****************************************/
L128:
        ;;test7.j(50)   b = 0;
L129:
        LD    A,0
L130:
        LD    (05000H),A
L131:
        ;;test7.j(51)   write(read + b);   // 1058 + 0 = 1058
L132:
        CALL  read
L133:
        LD    DE,(05000H)
        ADD   HL,DE
L134:
        CALL  writeHL
L135:
        ;;test7.j(52)   write(b + read);   // 0 + 1059 = 1059
L136:
        LD    A,(05000H)
L137:
        CALL  read
L138:
        LD    E,A
        LD    D,0
        ADD   HL,DE
L139:
        CALL  writeHL
L140:
        ;;test7.j(53)   write(read - b);   // 1060 - 0 = 1060
L141:
        CALL  read
L142:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L143:
        CALL  writeHL
L144:
        ;;test7.j(54)   write(b - read);   // 0 - 1061 = -1061
L145:
        LD    A,(05000H)
L146:
        CALL  read
L147:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L148:
        CALL  writeHL
L149:
        ;;test7.j(55)   b = 1;
L150:
        LD    A,1
L151:
        LD    (05000H),A
L152:
        ;;test7.j(56)   write(read * b);   // 1062 * 1 = 1062
L153:
        CALL  read
L154:
        LD    DE,(05000H)
        CALL  mul16
L155:
        CALL  writeHL
L156:
        ;;test7.j(57)   write(b * read);   // 1 * 1063 = 1063
L157:
        LD    A,(05000H)
L158:
        CALL  read
L159:
        CALL  mul16_8
L160:
        CALL  writeHL
L161:
        ;;test7.j(58)   write(read / b);   // 1064 / 1 = 1064
L162:
        CALL  read
L163:
        LD    DE,(05000H)
        CALL  div16
L164:
        CALL  writeHL
L165:
        ;;test7.j(59)   b = 12;
L166:
        LD    A,12
L167:
        LD    (05000H),A
L168:
        ;;test7.j(60)   write("Type 3 etc");
L169:
        LD    HL,245
L170:
        CALL  putStr
L171:
        ;;test7.j(61)   write(3);
L172:
        LD    A,3
L173:
        CALL  writeA
L174:
        ;;test7.j(62)   write(b / read);   // 12 / 3 = 4
L175:
        LD    A,(05000H)
L176:
        CALL  read
L177:
        EX    DE,HL
        CALL  div8_16
L178:
        CALL  writeHL
L179:
        ;;test7.j(63)   
L180:
        ;;test7.j(64)   /****************************************/
L181:
        ;;test7.j(65)   /* Dual term read: word + word variable */
L182:
        ;;test7.j(66)   /****************************************/
L183:
        ;;test7.j(67)   i = 0;
L184:
        LD    A,0
L185:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L186:
        ;;test7.j(68)   write("Type 1066 etc");
L187:
        LD    HL,246
L188:
        CALL  putStr
L189:
        ;;test7.j(69)   write(read + i);   // 1066 + 0 = 1066
L190:
        CALL  read
L191:
        LD    DE,(05001H)
        ADD   HL,DE
L192:
        CALL  writeHL
L193:
        ;;test7.j(70)   write(i + read);   // 0 + 1067 = 1067
L194:
        LD    HL,(05001H)
L195:
        PUSH HL
L196:
        CALL  read
L197:
        POP   DE
        ADD   HL,DE
L198:
        CALL  writeHL
L199:
        ;;test7.j(71)   write(read - i);   // 1068 - 0 = 1068
L200:
        CALL  read
L201:
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
L202:
        CALL  writeHL
L203:
        ;;test7.j(72)   write(i - read);   // 0 - 1069 = -1069
L204:
        LD    HL,(05001H)
L205:
        PUSH HL
L206:
        CALL  read
L207:
        POP   DE
        EX    DE,HL
        OR    A
        SBC   HL,DE
L208:
        CALL  writeHL
L209:
        ;;test7.j(73)   i = 1;
L210:
        LD    A,1
L211:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L212:
        ;;test7.j(74)   write(read * i);   // 1070 * 1 = 1070
L213:
        CALL  read
L214:
        LD    DE,(05001H)
        CALL  mul16
L215:
        CALL  writeHL
L216:
        ;;test7.j(75)   write(i * read);   // 1 * 1071 = 1071
L217:
        LD    HL,(05001H)
L218:
        PUSH HL
L219:
        CALL  read
L220:
        POP   DE
        CALL  mul16
L221:
        CALL  writeHL
L222:
        ;;test7.j(76)   write(read / i);   // 1072 / 1 = 1072
L223:
        CALL  read
L224:
        LD    DE,(05001H)
        CALL  div16
L225:
        CALL  writeHL
L226:
        ;;test7.j(77)   i = 3219;
L227:
        LD    HL,3219
L228:
        LD    (05001H),HL
L229:
        ;;test7.j(78)   write("Type 3");
L230:
        LD    HL,247
L231:
        CALL  putStr
L232:
        ;;test7.j(79)   write(i / read);   // 3219 / 3 = 1073  
L233:
        LD    HL,(05001H)
L234:
        PUSH HL
L235:
        CALL  read
L236:
        POP   DE
        EX    DE,HL
        CALL  div16
L237:
        CALL  writeHL
L238:
        ;;test7.j(80)   write("Klaar");
L239:
        LD    HL,248
L240:
        CALL  putStr
L241:
        ;;test7.j(81) }
L242:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L243:
        .ASCIZ  "Type 2, 3, 4 etc"
L244:
        .ASCIZ  "Type 1048 etc"
L245:
        .ASCIZ  "Type 3 etc"
L246:
        .ASCIZ  "Type 1066 etc"
L247:
        .ASCIZ  "Type 3"
L248:
        .ASCIZ  "Klaar"
