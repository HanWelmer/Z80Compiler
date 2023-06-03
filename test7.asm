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
        ;;test7.j(5)   println(0);
L6:
        LD    A,0
L7:
        CALL  writeA
L8:
        ;;test7.j(6) 
L9:
        ;;test7.j(7)   /**************************/
L10:
        ;;test7.j(8)   /* Single term read: byte */
L11:
        ;;test7.j(9)   /**************************/
L12:
        ;;test7.j(10)   println(1);          // 1
L13:
        LD    A,1
L14:
        CALL  writeA
L15:
        ;;test7.j(11) 
L16:
        ;;test7.j(12)   println("\nType 2, 3, 4 etc");
L17:
        LD    HL,286
L18:
        CALL  putStr
L19:
        ;;test7.j(13)   println(read);       // 2
L20:
        CALL  read
L21:
        CALL  writeHL
L22:
        ;;test7.j(14)   byte b = read;
L23:
        CALL  read
L24:
        LD    A,L
        LD    (05000H),A
L25:
        ;;test7.j(15)   println(b);       // 3
L26:
        LD    A,(05000H)
L27:
        CALL  writeA
L28:
        ;;test7.j(16) 
L29:
        ;;test7.j(17)   /**********************************/
L30:
        ;;test7.j(18)   /* Dual term read: byte constants */
L31:
        ;;test7.j(19)   /**********************************/
L32:
        ;;test7.j(20)   println(read + 0);   // 4 + 0 = 4
L33:
        CALL  read
L34:
        LD    DE,0
        ADD   HL,DE
L35:
        CALL  writeHL
L36:
        ;;test7.j(21)   println(0 + read);   // 0 + 5 = 5
L37:
        LD    A,0
L38:
        CALL  read
L39:
        LD    E,A
        LD    D,0
        ADD   HL,DE
L40:
        CALL  writeHL
L41:
        ;;test7.j(22)   println(read - 0);   // 6 - 0 = 6
L42:
        CALL  read
L43:
        LD    DE,0
        OR    A
        SBC   HL,DE
L44:
        CALL  writeHL
L45:
        ;;test7.j(23)   println(14 - read);  // 14 - 7 = 7
L46:
        LD    A,14
L47:
        CALL  read
L48:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L49:
        CALL  writeHL
L50:
        ;;test7.j(24)   println(read * 1);   // 8 * 1 = 8
L51:
        CALL  read
L52:
        LD    DE,1
        CALL  mul16
L53:
        CALL  writeHL
L54:
        ;;test7.j(25)   println(1 * read);   // 1 * 9 = 9
L55:
        LD    A,1
L56:
        CALL  read
L57:
        CALL  mul16_8
L58:
        CALL  writeHL
L59:
        ;;test7.j(26)   println(read / 1);   // 10 / 1 = 10
L60:
        CALL  read
L61:
        LD    DE,1
        CALL  div16
L62:
        CALL  writeHL
L63:
        ;;test7.j(27)   println(121 / read); // 121 / 11 = 11
L64:
        LD    A,121
L65:
        CALL  read
L66:
        EX    DE,HL
        CALL  div8_16
L67:
        CALL  writeHL
L68:
        ;;test7.j(28)   
L69:
        ;;test7.j(29)   println("\nType 1048 etc");
L70:
        LD    HL,287
L71:
        CALL  putStr
L72:
        ;;test7.j(30)   /**************************/
L73:
        ;;test7.j(31)   /* Single term read: word */
L74:
        ;;test7.j(32)   /**************************/
L75:
        ;;test7.j(33)   println(read);      // 1048
L76:
        CALL  read
L77:
        CALL  writeHL
L78:
        ;;test7.j(34)   word i = read;
L79:
        CALL  read
L80:
        LD    (05001H),HL
L81:
        ;;test7.j(35)   println(i);         // 1049
L82:
        LD    HL,(05001H)
L83:
        CALL  writeHL
L84:
        ;;test7.j(36) 
L85:
        ;;test7.j(37)   /**********************************/
L86:
        ;;test7.j(38)   /* Dual term read: word constants */
L87:
        ;;test7.j(39)   /**********************************/
L88:
        ;;test7.j(40)   println("\nType 1050 expect 2050");
L89:
        LD    HL,288
L90:
        CALL  putStr
L91:
        ;;test7.j(41)   println(read + 1000);   // 1050 + 1000 = 2050
L92:
        CALL  read
L93:
        LD    DE,1000
        ADD   HL,DE
L94:
        CALL  writeHL
L95:
        ;;test7.j(42)   println("\nType 1051 expect 2051");
L96:
        LD    HL,289
L97:
        CALL  putStr
L98:
        ;;test7.j(43)   println(1000 + read);   // 1000 + 1051 = 2051
L99:
        LD    HL,1000
L100:
        PUSH HL
L101:
        CALL  read
L102:
        POP   DE
        ADD   HL,DE
L103:
        CALL  writeHL
L104:
        ;;test7.j(44)   println("\nType 1052 expect 52");
L105:
        LD    HL,290
L106:
        CALL  putStr
L107:
        ;;test7.j(45)   println(read - 1000);   // 1052 - 1000 =   52
L108:
        CALL  read
L109:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L110:
        CALL  writeHL
L111:
        ;;test7.j(46)   println("\nType 1053 expect 1053");
L112:
        LD    HL,291
L113:
        CALL  putStr
L114:
        ;;test7.j(47)   println(2106 - read);   // 2106 - 1053 = 1053
L115:
        LD    HL,2106
L116:
        PUSH HL
L117:
        CALL  read
L118:
        POP   DE
        EX    DE,HL
        OR    A
        SBC   HL,DE
L119:
        CALL  writeHL
L120:
        ;;test7.j(48)   println("\nType 1054 expect 5254");
L121:
        LD    HL,292
L122:
        CALL  putStr
L123:
        ;;test7.j(49)   println(read * 1000);   // 1054 * 1000 = 5254
L124:
        CALL  read
L125:
        LD    DE,1000
        CALL  mul16
L126:
        CALL  writeHL
L127:
        ;;test7.j(50)   println("\nType 1055 expect 6424");
L128:
        LD    HL,293
L129:
        CALL  putStr
L130:
        ;;test7.j(51)   println(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
L131:
        LD    HL,1000
L132:
        PUSH HL
L133:
        CALL  read
L134:
        POP   DE
        CALL  mul16
L135:
        CALL  writeHL
L136:
        ;;test7.j(52)   println("\nType 1056 expect 1");
L137:
        LD    HL,294
L138:
        CALL  putStr
L139:
        ;;test7.j(53)   println(read / 1000);   // 1056 / 1000 = 1
L140:
        CALL  read
L141:
        LD    DE,1000
        CALL  div16
L142:
        CALL  writeHL
L143:
        ;;test7.j(54)   println("\nType 1057 expect 2");
L144:
        LD    HL,295
L145:
        CALL  putStr
L146:
        ;;test7.j(55)   println(2114 / read);   // 2114 / 1057 = 2
L147:
        LD    HL,2114
L148:
        PUSH HL
L149:
        CALL  read
L150:
        POP   DE
        EX    DE,HL
        CALL  div16
L151:
        CALL  writeHL
L152:
        ;;test7.j(56)   
L153:
        ;;test7.j(57)   /****************************************/
L154:
        ;;test7.j(58)   /* Dual term read: word + byte variable */
L155:
        ;;test7.j(59)   /****************************************/
L156:
        ;;test7.j(60)   println("\nType 1058 etc");
L157:
        LD    HL,296
L158:
        CALL  putStr
L159:
        ;;test7.j(61)   b = 0;
L160:
        LD    A,0
L161:
        LD    (05000H),A
L162:
        ;;test7.j(62)   println(read + b);   // 1058 + 0 = 1058
L163:
        CALL  read
L164:
        LD    DE,(05000H)
        ADD   HL,DE
L165:
        CALL  writeHL
L166:
        ;;test7.j(63)   println(b + read);   // 0 + 1059 = 1059
L167:
        LD    A,(05000H)
L168:
        CALL  read
L169:
        LD    E,A
        LD    D,0
        ADD   HL,DE
L170:
        CALL  writeHL
L171:
        ;;test7.j(64)   println(read - b);   // 1060 - 0 = 1060
L172:
        CALL  read
L173:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L174:
        CALL  writeHL
L175:
        ;;test7.j(65)   println("\nType 1061 expect -1061");
L176:
        LD    HL,297
L177:
        CALL  putStr
L178:
        ;;test7.j(66)   println(b - read);   // 0 - 1061 = -1061
L179:
        LD    A,(05000H)
L180:
        CALL  read
L181:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L182:
        CALL  writeHL
L183:
        ;;test7.j(67)   b = 1;
L184:
        LD    A,1
L185:
        LD    (05000H),A
L186:
        ;;test7.j(68)   println("\nType 1062 etc");
L187:
        LD    HL,298
L188:
        CALL  putStr
L189:
        ;;test7.j(69)   println(read * b);   // 1062 * 1 = 1062
L190:
        CALL  read
L191:
        LD    DE,(05000H)
        CALL  mul16
L192:
        CALL  writeHL
L193:
        ;;test7.j(70)   println(b * read);   // 1 * 1063 = 1063
L194:
        LD    A,(05000H)
L195:
        CALL  read
L196:
        CALL  mul16_8
L197:
        CALL  writeHL
L198:
        ;;test7.j(71)   println(read / b);   // 1064 / 1 = 1064
L199:
        CALL  read
L200:
        LD    DE,(05000H)
        CALL  div16
L201:
        CALL  writeHL
L202:
        ;;test7.j(72)   b = 12;
L203:
        LD    A,12
L204:
        LD    (05000H),A
L205:
        ;;test7.j(73)   println("\nType 3 expect 4");
L206:
        LD    HL,299
L207:
        CALL  putStr
L208:
        ;;test7.j(74)   println(3);
L209:
        LD    A,3
L210:
        CALL  writeA
L211:
        ;;test7.j(75)   println(b / read);   // 12 / 3 = 4
L212:
        LD    A,(05000H)
L213:
        CALL  read
L214:
        EX    DE,HL
        CALL  div8_16
L215:
        CALL  writeHL
L216:
        ;;test7.j(76)   
L217:
        ;;test7.j(77)   /****************************************/
L218:
        ;;test7.j(78)   /* Dual term read: word + word variable */
L219:
        ;;test7.j(79)   /****************************************/
L220:
        ;;test7.j(80)   i = 0;
L221:
        LD    A,0
L222:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L223:
        ;;test7.j(81)   println("\nType 1066 etc");
L224:
        LD    HL,300
L225:
        CALL  putStr
L226:
        ;;test7.j(82)   println(read + i);   // 1066 + 0 = 1066
L227:
        CALL  read
L228:
        LD    DE,(05001H)
        ADD   HL,DE
L229:
        CALL  writeHL
L230:
        ;;test7.j(83)   println(i + read);   // 0 + 1067 = 1067
L231:
        LD    HL,(05001H)
L232:
        PUSH HL
L233:
        CALL  read
L234:
        POP   DE
        ADD   HL,DE
L235:
        CALL  writeHL
L236:
        ;;test7.j(84)   println(read - i);   // 1068 - 0 = 1068
L237:
        CALL  read
L238:
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
L239:
        CALL  writeHL
L240:
        ;;test7.j(85)   println("\nType 1069 expect -1069");
L241:
        LD    HL,301
L242:
        CALL  putStr
L243:
        ;;test7.j(86)   println(i - read);   // 0 - 1069 = -1069
L244:
        LD    HL,(05001H)
L245:
        PUSH HL
L246:
        CALL  read
L247:
        POP   DE
        EX    DE,HL
        OR    A
        SBC   HL,DE
L248:
        CALL  writeHL
L249:
        ;;test7.j(87)   i = 1;
L250:
        LD    A,1
L251:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L252:
        ;;test7.j(88)   println("\nType 1070 etc");
L253:
        LD    HL,302
L254:
        CALL  putStr
L255:
        ;;test7.j(89)   println(read * i);   // 1070 * 1 = 1070
L256:
        CALL  read
L257:
        LD    DE,(05001H)
        CALL  mul16
L258:
        CALL  writeHL
L259:
        ;;test7.j(90)   println(i * read);   // 1 * 1071 = 1071
L260:
        LD    HL,(05001H)
L261:
        PUSH HL
L262:
        CALL  read
L263:
        POP   DE
        CALL  mul16
L264:
        CALL  writeHL
L265:
        ;;test7.j(91)   println(read / i);   // 1072 / 1 = 1072
L266:
        CALL  read
L267:
        LD    DE,(05001H)
        CALL  div16
L268:
        CALL  writeHL
L269:
        ;;test7.j(92)   i = 3219;
L270:
        LD    HL,3219
L271:
        LD    (05001H),HL
L272:
        ;;test7.j(93)   println("\nType 3 expect 1073");
L273:
        LD    HL,303
L274:
        CALL  putStr
L275:
        ;;test7.j(94)   println(i / read);   // 3219 / 3 = 1073  
L276:
        LD    HL,(05001H)
L277:
        PUSH HL
L278:
        CALL  read
L279:
        POP   DE
        EX    DE,HL
        CALL  div16
L280:
        CALL  writeHL
L281:
        ;;test7.j(95)   println("Klaar");
L282:
        LD    HL,304
L283:
        CALL  putStr
L284:
        ;;test7.j(96) }
L285:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L286:
        .ASCIZ  "\nType 2, 3, 4 etc"
L287:
        .ASCIZ  "\nType 1048 etc"
L288:
        .ASCIZ  "\nType 1050 expect 2050"
L289:
        .ASCIZ  "\nType 1051 expect 2051"
L290:
        .ASCIZ  "\nType 1052 expect 52"
L291:
        .ASCIZ  "\nType 1053 expect 1053"
L292:
        .ASCIZ  "\nType 1054 expect 5254"
L293:
        .ASCIZ  "\nType 1055 expect 6424"
L294:
        .ASCIZ  "\nType 1056 expect 1"
L295:
        .ASCIZ  "\nType 1057 expect 2"
L296:
        .ASCIZ  "\nType 1058 etc"
L297:
        .ASCIZ  "\nType 1061 expect -1061"
L298:
        .ASCIZ  "\nType 1062 etc"
L299:
        .ASCIZ  "\nType 3 expect 4"
L300:
        .ASCIZ  "\nType 1066 etc"
L301:
        .ASCIZ  "\nType 1069 expect -1069"
L302:
        .ASCIZ  "\nType 1070 etc"
L303:
        .ASCIZ  "\nType 3 expect 1073"
L304:
        .ASCIZ  "Klaar"
