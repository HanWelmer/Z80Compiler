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
;sleepHL - Wait HL * 1 msec @ 18,432 MHz with no wait states
;  IN:  HL number of msec to wait
;  OUT: none
;  USES: 4 bytes on stack
;****************
sleepHL:
        PUSH  AF
sleep1:
        CALL  WAIT1M      ;Wait 1 msec
        DEC   HL
        LD    A,H
        OR    L
        JR    NZ,sleep1
        POP   AF
        RET
;****************
;sleepA - Wait A * 1 msec @ 18,432 MHz with no wait states
;  IN:  A number of msec to wait
;  OUT: none
;  USES: no stack
;****************
sleepA:
        CALL  WAIT1M      ;Wait 1 msec
        DEC   A
        JR    NZ,sleepA
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
        OR    L           ;2      4 (31+n*14)
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
        CALL  writeStr
        EX    (SP),HL     ;put return address onto stack and restore HL.
        RET
;****************
;writeLineStr
;Print via ASCI0 a zero terminated string, pointed to by HL, followed by a carriage return.
;  IN:  HL:address of zero terminated string to be printed.
;  OUT: none.
;  USES:HL (point to byte after zero terminated string)
;****************
writeLineStr:
        CALL  writeStr
        CALL  putCRLF
        RET
;****************
;writeStr
;Print via ASCI0 a zero terminated string, pointed to by HL.
;  IN:  HL:address of zero terminated string to be printed.
;  OUT: none.
;  USES:HL (point to byte after zero terminated string)
;****************
writeStr:
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
;writeLineHL
;write a 16 bit unsigned number to the output, followed by a carriage return
;  IN:  HL = 16 bit unsigned number
;  OUT: none
;  USES:HL
;****************
writeLineHL:
        CALL  writeHL
        CALL  putCRLF
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
        RET
;****************
;writeLineA
;write an 8-bit unsigned number to the output, followed by a carriage return
;  IN:  A = 8-bit unsigned number
;  OUT: none
;  USES:none
;****************
writeLineA:
        CALL  writeA
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
        ;;test15.j(0) /* Program to test bitwise operators and, or and xor. */
L1:
        ;;test15.j(1) class TestBitwiseOperators {
L2:
        ;;test15.j(2)   println(0);
L3:
        LD    A,0
L4:
        CALL  writeLineA
L5:
        ;;test15.j(3)   
L6:
        ;;test15.j(4)   // Possible operand types: constant, acc, var, final var, stack8, stack16.
L7:
        ;;test15.j(5)   // Possible data types: byt, word.
L8:
        ;;test15.j(6) 
L9:
        ;;test15.j(7)   byte b1 = 0x1C;
L10:
        LD    A,28
L11:
        LD    (05000H),A
L12:
        ;;test15.j(8)   byte b2 = 0x07;
L13:
        LD    A,7
L14:
        LD    (05001H),A
L15:
        ;;test15.j(9)   word w1 = 0x032C;
L16:
        LD    HL,812
L17:
        LD    (05002H),HL
L18:
        ;;test15.j(10)   word w2 = 0x1234;
L19:
        LD    HL,4660
L20:
        LD    (05004H),HL
L21:
        ;;test15.j(11)   final byte fb1 = 0x1C;
L22:
        ;;test15.j(12)   final byte fb2 = 0x07;
L23:
        ;;test15.j(13)   final word fw1 = 0x032C;
L24:
        ;;test15.j(14)   final word fw2 = 0x1234;
L25:
        ;;test15.j(15) 
L26:
        ;;test15.j(16)   //constant/constant
L27:
        ;;test15.j(17)   //*****************
L28:
        ;;test15.j(18)   //constant byte/constant byte
L29:
        ;;test15.j(19)   if (0x07 & 0x1C == 0x04) println (1); else println (999); //0000.0111 & 0001.1100 = 0000.0100
L30:
        LD    A,7
L31:
        AND   A,28
L32:
        SUB   A,4
L33:
        JP    NZ,L37
L34:
        LD    A,1
L35:
        CALL  writeLineA
L36:
        JP    L40
L37:
        LD    HL,999
L38:
        CALL  writeLineHL
L39:
        ;;test15.j(20)   if (0x07 | 0x1C == 0x1F) println (2); else println (999); //0000.0111 | 0001.1100 = 0001.1111
L40:
        LD    A,7
L41:
        OR    A,28
L42:
        SUB   A,31
L43:
        JP    NZ,L47
L44:
        LD    A,2
L45:
        CALL  writeLineA
L46:
        JP    L50
L47:
        LD    HL,999
L48:
        CALL  writeLineHL
L49:
        ;;test15.j(21)   if (0x07 ^ 0x1C == 0x1B) println (3); else println (999); //0000.0111 ^ 0001.1100 = 0001.1011
L50:
        LD    A,7
L51:
        XOR   A,28
L52:
        SUB   A,27
L53:
        JP    NZ,L57
L54:
        LD    A,3
L55:
        CALL  writeLineA
L56:
        JP    L61
L57:
        LD    HL,999
L58:
        CALL  writeLineHL
L59:
        ;;test15.j(22)   //constant word/constant word
L60:
        ;;test15.j(23)   if (0x1234 & 0x032C == 0x0224) println (4); else println (999);
L61:
        LD    HL,4660
L62:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L63:
        LD    DE,548
        OR    A
        SBC   HL,DE
L64:
        JP    NZ,L68
L65:
        LD    A,4
L66:
        CALL  writeLineA
L67:
        JP    L72
L68:
        LD    HL,999
L69:
        CALL  writeLineHL
L70:
        ;;test15.j(24)   //0001.0010.0011.0100 & 0000.0011.0010.1100 = 0000.0010.0010.0100
L71:
        ;;test15.j(25)   if (0x1234 | 0x032C == 0x133C) println (5); else println (999);
L72:
        LD    HL,4660
L73:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L74:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L75:
        JP    NZ,L79
L76:
        LD    A,5
L77:
        CALL  writeLineA
L78:
        JP    L83
L79:
        LD    HL,999
L80:
        CALL  writeLineHL
L81:
        ;;test15.j(26)   //0001.0010.0011.0100 | 0000.0011.0010.1100 = 0001.0011.0011.1100
L82:
        ;;test15.j(27)   if (0x1234 ^ 0x032C == 0x1118) println (6); else println (999);
L83:
        LD    HL,4660
L84:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L85:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L86:
        JP    NZ,L90
L87:
        LD    A,6
L88:
        CALL  writeLineA
L89:
        JP    L95
L90:
        LD    HL,999
L91:
        CALL  writeLineHL
L92:
        ;;test15.j(28)   //0001.0010.0011.0100 ^ 0000.0011.0010.1100 = 0001.0001.0001.1000
L93:
        ;;test15.j(29)   //constant byt/constant word
L94:
        ;;test15.j(30)   if (0x1C & 0x1234 == 0x0014) println (7); else println (999); //0001.1100 & 0001.0010.0011.0100 = 0000.0000.0001.0100
L95:
        LD    A,28
L96:
        LD    L,A
        LD    H,0
L97:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L98:
        LD    A,20
L99:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L100:
        JP    NZ,L104
L101:
        LD    A,7
L102:
        CALL  writeLineA
L103:
        JP    L107
L104:
        LD    HL,999
L105:
        CALL  writeLineHL
L106:
        ;;test15.j(31)   if (0x1C | 0x1234 == 0x123C) println (8); else println (999); //0001.1100 | 0001.0010.0011.0100 = 0001.0010.0011.1100
L107:
        LD    A,28
L108:
        LD    L,A
        LD    H,0
L109:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L110:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L111:
        JP    NZ,L115
L112:
        LD    A,8
L113:
        CALL  writeLineA
L114:
        JP    L118
L115:
        LD    HL,999
L116:
        CALL  writeLineHL
L117:
        ;;test15.j(32)   if (0x1C ^ 0x1234 == 0x1228) println (9); else println (999); //0001.1100 ^ 0001.0010.0011.0100 = 0001.0010.0010.1000
L118:
        LD    A,28
L119:
        LD    L,A
        LD    H,0
L120:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L121:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L122:
        JP    NZ,L126
L123:
        LD    A,9
L124:
        CALL  writeLineA
L125:
        JP    L130
L126:
        LD    HL,999
L127:
        CALL  writeLineHL
L128:
        ;;test15.j(33)   //constant word/constant byt
L129:
        ;;test15.j(34)   if (0x1234 & 0x1C == 0x0014) println (10); else println (999); //0001.0010.0011.0100 & 0001.1100 = 0000.0000.0001.0100
L130:
        LD    HL,4660
L131:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L132:
        LD    A,20
L133:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L134:
        JP    NZ,L138
L135:
        LD    A,10
L136:
        CALL  writeLineA
L137:
        JP    L141
L138:
        LD    HL,999
L139:
        CALL  writeLineHL
L140:
        ;;test15.j(35)   if (0x1234 | 0x1C == 0x123C) println (11); else println (999); //0001.0010.0011.0100 | 0001.1100 = 0001.0010.0011.1100
L141:
        LD    HL,4660
L142:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L143:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L144:
        JP    NZ,L148
L145:
        LD    A,11
L146:
        CALL  writeLineA
L147:
        JP    L151
L148:
        LD    HL,999
L149:
        CALL  writeLineHL
L150:
        ;;test15.j(36)   if (0x1234 ^ 0x1C == 0x1228) println (12); else println (999); //0001.0010.0011.0100 ^ 0001.1100 = 0001.0010.0010.1000
L151:
        LD    HL,4660
L152:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L153:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L154:
        JP    NZ,L158
L155:
        LD    A,12
L156:
        CALL  writeLineA
L157:
        JP    L165
L158:
        LD    HL,999
L159:
        CALL  writeLineHL
L160:
        ;;test15.j(37) 
L161:
        ;;test15.j(38)   //constant/acc
L162:
        ;;test15.j(39)   //************
L163:
        ;;test15.j(40)   //constant byte/acc byte
L164:
        ;;test15.j(41)   if (0x07 & (0x10 + 0x0C) == 0x04) println (13); else println (999);
L165:
        LD    A,7
L166:
        PUSH  AF
        LD    A,16
L167:
        ADD   A,12
L168:
        POP   BC
        AND   A,B
L169:
        SUB   A,4
L170:
        JP    NZ,L174
L171:
        LD    A,13
L172:
        CALL  writeLineA
L173:
        JP    L177
L174:
        LD    HL,999
L175:
        CALL  writeLineHL
L176:
        ;;test15.j(42)   if (0x07 | (0x10 + 0x0C) == 0x1F) println (14); else println (999);
L177:
        LD    A,7
L178:
        PUSH  AF
        LD    A,16
L179:
        ADD   A,12
L180:
        POP   BC
        OR    A,B
L181:
        SUB   A,31
L182:
        JP    NZ,L186
L183:
        LD    A,14
L184:
        CALL  writeLineA
L185:
        JP    L189
L186:
        LD    HL,999
L187:
        CALL  writeLineHL
L188:
        ;;test15.j(43)   if (0x07 ^ (0x10 + 0x0C) == 0x1B) println (15); else println (999);
L189:
        LD    A,7
L190:
        PUSH  AF
        LD    A,16
L191:
        ADD   A,12
L192:
        POP   BC
        XOR   A,B
L193:
        SUB   A,27
L194:
        JP    NZ,L198
L195:
        LD    A,15
L196:
        CALL  writeLineA
L197:
        JP    L202
L198:
        LD    HL,999
L199:
        CALL  writeLineHL
L200:
        ;;test15.j(44)   //constant word/acc word
L201:
        ;;test15.j(45)   if (0x1234 & 0x0100 + 0x022C == 0x0224) println (16); else println (999);
L202:
        LD    HL,4660
L203:
        PUSH  HL
        LD    HL,256
L204:
        LD    DE,556
        ADD   HL,DE
L205:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L206:
        LD    DE,548
        OR    A
        SBC   HL,DE
L207:
        JP    NZ,L211
L208:
        LD    A,16
L209:
        CALL  writeLineA
L210:
        JP    L214
L211:
        LD    HL,999
L212:
        CALL  writeLineHL
L213:
        ;;test15.j(46)   if (0x1234 | 0x0100 + 0x022C == 0x133C) println (17); else println (999);
L214:
        LD    HL,4660
L215:
        PUSH  HL
        LD    HL,256
L216:
        LD    DE,556
        ADD   HL,DE
L217:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L218:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L219:
        JP    NZ,L223
L220:
        LD    A,17
L221:
        CALL  writeLineA
L222:
        JP    L226
L223:
        LD    HL,999
L224:
        CALL  writeLineHL
L225:
        ;;test15.j(47)   if (0x1234 ^ 0x0100 + 0x022C == 0x1118) println (18); else println (999);
L226:
        LD    HL,4660
L227:
        PUSH  HL
        LD    HL,256
L228:
        LD    DE,556
        ADD   HL,DE
L229:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L230:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L231:
        JP    NZ,L235
L232:
        LD    A,18
L233:
        CALL  writeLineA
L234:
        JP    L239
L235:
        LD    HL,999
L236:
        CALL  writeLineHL
L237:
        ;;test15.j(48)   //constant byt/acc word
L238:
        ;;test15.j(49)   if (0x1C & 0x1000 + 0x0234 == 0x0014) println (19); else println (999);
L239:
        LD    A,28
L240:
        LD    HL,4096
L241:
        LD    DE,564
        ADD   HL,DE
L242:
        AND   A,L
        LD    L,A
        LD    H,0
L243:
        LD    A,20
L244:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L245:
        JP    NZ,L249
L246:
        LD    A,19
L247:
        CALL  writeLineA
L248:
        JP    L252
L249:
        LD    HL,999
L250:
        CALL  writeLineHL
L251:
        ;;test15.j(50)   if (0x1C | 0x1000 + 0x0234 == 0x123C) println (20); else println (999);
L252:
        LD    A,28
L253:
        LD    HL,4096
L254:
        LD    DE,564
        ADD   HL,DE
L255:
        OR    A,L
        LD    L,A
L256:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L257:
        JP    NZ,L261
L258:
        LD    A,20
L259:
        CALL  writeLineA
L260:
        JP    L264
L261:
        LD    HL,999
L262:
        CALL  writeLineHL
L263:
        ;;test15.j(51)   if (0x1C ^ 0x1000 + 0x0234 == 0x1228) println (21); else println (999);
L264:
        LD    A,28
L265:
        LD    HL,4096
L266:
        LD    DE,564
        ADD   HL,DE
L267:
        XOR   A,L
        LD    L,A
L268:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L269:
        JP    NZ,L273
L270:
        LD    A,21
L271:
        CALL  writeLineA
L272:
        JP    L277
L273:
        LD    HL,999
L274:
        CALL  writeLineHL
L275:
        ;;test15.j(52)   //constant word/acc byt
L276:
        ;;test15.j(53)   if (0x1234 & 0x10 + 0x0C == 0x0014) println (22); else println (999);
L277:
        LD    HL,4660
L278:
        LD    A,16
L279:
        ADD   A,12
L280:
        AND   A,L
        LD    L,A
        LD    H,0
L281:
        LD    A,20
L282:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L283:
        JP    NZ,L287
L284:
        LD    A,22
L285:
        CALL  writeLineA
L286:
        JP    L290
L287:
        LD    HL,999
L288:
        CALL  writeLineHL
L289:
        ;;test15.j(54)   if (0x1234 | 0x10 + 0x0C == 0x123C) println (23); else println (999);
L290:
        LD    HL,4660
L291:
        LD    A,16
L292:
        ADD   A,12
L293:
        OR    A,L
        LD    L,A
L294:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L295:
        JP    NZ,L299
L296:
        LD    A,23
L297:
        CALL  writeLineA
L298:
        JP    L302
L299:
        LD    HL,999
L300:
        CALL  writeLineHL
L301:
        ;;test15.j(55)   if (0x1234 ^ 0x10 + 0x0C == 0x1228) println (24); else println (999);
L302:
        LD    HL,4660
L303:
        LD    A,16
L304:
        ADD   A,12
L305:
        XOR   A,L
        LD    L,A
L306:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L307:
        JP    NZ,L311
L308:
        LD    A,24
L309:
        CALL  writeLineA
L310:
        JP    L318
L311:
        LD    HL,999
L312:
        CALL  writeLineHL
L313:
        ;;test15.j(56) 
L314:
        ;;test15.j(57)   //constant/var
L315:
        ;;test15.j(58)   //*****************
L316:
        ;;test15.j(59)   //constant byte/var byte
L317:
        ;;test15.j(60)   if (0x07 & b1 == 0x04) println (25); else println (999);
L318:
        LD    A,7
L319:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L320:
        SUB   A,4
L321:
        JP    NZ,L325
L322:
        LD    A,25
L323:
        CALL  writeLineA
L324:
        JP    L328
L325:
        LD    HL,999
L326:
        CALL  writeLineHL
L327:
        ;;test15.j(61)   if (0x07 | b1 == 0x1F) println (26); else println (999);
L328:
        LD    A,7
L329:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L330:
        SUB   A,31
L331:
        JP    NZ,L335
L332:
        LD    A,26
L333:
        CALL  writeLineA
L334:
        JP    L338
L335:
        LD    HL,999
L336:
        CALL  writeLineHL
L337:
        ;;test15.j(62)   if (0x07 ^ b1 == 0x1B) println (27); else println (999);
L338:
        LD    A,7
L339:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L340:
        SUB   A,27
L341:
        JP    NZ,L345
L342:
        LD    A,27
L343:
        CALL  writeLineA
L344:
        JP    L349
L345:
        LD    HL,999
L346:
        CALL  writeLineHL
L347:
        ;;test15.j(63)   //constant word/var word
L348:
        ;;test15.j(64)   if (0x1234 & w1 == 0x0224) println (28); else println (999);
L349:
        LD    HL,4660
L350:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L351:
        LD    DE,548
        OR    A
        SBC   HL,DE
L352:
        JP    NZ,L356
L353:
        LD    A,28
L354:
        CALL  writeLineA
L355:
        JP    L359
L356:
        LD    HL,999
L357:
        CALL  writeLineHL
L358:
        ;;test15.j(65)   if (0x1234 | w1 == 0x133C) println (29); else println (999);
L359:
        LD    HL,4660
L360:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L361:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L362:
        JP    NZ,L366
L363:
        LD    A,29
L364:
        CALL  writeLineA
L365:
        JP    L369
L366:
        LD    HL,999
L367:
        CALL  writeLineHL
L368:
        ;;test15.j(66)   if (0x1234 ^ w1 == 0x1118) println (30); else println (999);
L369:
        LD    HL,4660
L370:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L371:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L372:
        JP    NZ,L376
L373:
        LD    A,30
L374:
        CALL  writeLineA
L375:
        JP    L380
L376:
        LD    HL,999
L377:
        CALL  writeLineHL
L378:
        ;;test15.j(67)   //constant byt/var word
L379:
        ;;test15.j(68)   if (0x1C & w2 == 0x0014) println (31); else println (999);
L380:
        LD    A,28
L381:
        LD    L,A
        LD    H,0
L382:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L383:
        LD    A,20
L384:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L385:
        JP    NZ,L389
L386:
        LD    A,31
L387:
        CALL  writeLineA
L388:
        JP    L392
L389:
        LD    HL,999
L390:
        CALL  writeLineHL
L391:
        ;;test15.j(69)   if (0x1C | w2 == 0x123C) println (32); else println (999);
L392:
        LD    A,28
L393:
        LD    L,A
        LD    H,0
L394:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L395:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L396:
        JP    NZ,L400
L397:
        LD    A,32
L398:
        CALL  writeLineA
L399:
        JP    L403
L400:
        LD    HL,999
L401:
        CALL  writeLineHL
L402:
        ;;test15.j(70)   if (0x1C ^ w2 == 0x1228) println (33); else println (999);
L403:
        LD    A,28
L404:
        LD    L,A
        LD    H,0
L405:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L406:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L407:
        JP    NZ,L411
L408:
        LD    A,33
L409:
        CALL  writeLineA
L410:
        JP    L415
L411:
        LD    HL,999
L412:
        CALL  writeLineHL
L413:
        ;;test15.j(71)   //constant word/var byt
L414:
        ;;test15.j(72)   if (0x1234 & b1 == 0x0014) println (34); else println (999);
L415:
        LD    HL,4660
L416:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L417:
        LD    A,20
L418:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L419:
        JP    NZ,L423
L420:
        LD    A,34
L421:
        CALL  writeLineA
L422:
        JP    L426
L423:
        LD    HL,999
L424:
        CALL  writeLineHL
L425:
        ;;test15.j(73)   if (0x1234 | b1 == 0x123C) println (35); else println (999);
L426:
        LD    HL,4660
L427:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L428:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L429:
        JP    NZ,L433
L430:
        LD    A,35
L431:
        CALL  writeLineA
L432:
        JP    L436
L433:
        LD    HL,999
L434:
        CALL  writeLineHL
L435:
        ;;test15.j(74)   if (0x1234 ^ b1 == 0x1228) println (36); else println (999);
L436:
        LD    HL,4660
L437:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L438:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L439:
        JP    NZ,L443
L440:
        LD    A,36
L441:
        CALL  writeLineA
L442:
        JP    L450
L443:
        LD    HL,999
L444:
        CALL  writeLineHL
L445:
        ;;test15.j(75) 
L446:
        ;;test15.j(76)   //constant/final var
L447:
        ;;test15.j(77)   //*****************
L448:
        ;;test15.j(78)   //constant byte/final var byte
L449:
        ;;test15.j(79)   if (0x07 & fb1 == 0x04) println (37); else println (999);
L450:
        LD    A,7
L451:
        AND   A,28
L452:
        SUB   A,4
L453:
        JP    NZ,L457
L454:
        LD    A,37
L455:
        CALL  writeLineA
L456:
        JP    L460
L457:
        LD    HL,999
L458:
        CALL  writeLineHL
L459:
        ;;test15.j(80)   if (0x07 | fb1 == 0x1F) println (38); else println (999);
L460:
        LD    A,7
L461:
        OR    A,28
L462:
        SUB   A,31
L463:
        JP    NZ,L467
L464:
        LD    A,38
L465:
        CALL  writeLineA
L466:
        JP    L470
L467:
        LD    HL,999
L468:
        CALL  writeLineHL
L469:
        ;;test15.j(81)   if (0x07 ^ fb1 == 0x1B) println (39); else println (999);
L470:
        LD    A,7
L471:
        XOR   A,28
L472:
        SUB   A,27
L473:
        JP    NZ,L477
L474:
        LD    A,39
L475:
        CALL  writeLineA
L476:
        JP    L481
L477:
        LD    HL,999
L478:
        CALL  writeLineHL
L479:
        ;;test15.j(82)   //constant word/final var word
L480:
        ;;test15.j(83)   if (0x1234 & fw1 == 0x0224) println (40); else println (999);
L481:
        LD    HL,4660
L482:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L483:
        LD    DE,548
        OR    A
        SBC   HL,DE
L484:
        JP    NZ,L488
L485:
        LD    A,40
L486:
        CALL  writeLineA
L487:
        JP    L491
L488:
        LD    HL,999
L489:
        CALL  writeLineHL
L490:
        ;;test15.j(84)   if (0x1234 | fw1 == 0x133C) println (41); else println (999);
L491:
        LD    HL,4660
L492:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L493:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L494:
        JP    NZ,L498
L495:
        LD    A,41
L496:
        CALL  writeLineA
L497:
        JP    L501
L498:
        LD    HL,999
L499:
        CALL  writeLineHL
L500:
        ;;test15.j(85)   if (0x1234 ^ fw1 == 0x1118) println (42); else println (999);
L501:
        LD    HL,4660
L502:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L503:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L504:
        JP    NZ,L508
L505:
        LD    A,42
L506:
        CALL  writeLineA
L507:
        JP    L512
L508:
        LD    HL,999
L509:
        CALL  writeLineHL
L510:
        ;;test15.j(86)   //constant byt/final var word
L511:
        ;;test15.j(87)   if (0x1C & fw2 == 0x0014) println (43); else println (999);
L512:
        LD    A,28
L513:
        LD    L,A
        LD    H,0
L514:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L515:
        LD    A,20
L516:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L517:
        JP    NZ,L521
L518:
        LD    A,43
L519:
        CALL  writeLineA
L520:
        JP    L524
L521:
        LD    HL,999
L522:
        CALL  writeLineHL
L523:
        ;;test15.j(88)   if (0x1C | fw2 == 0x123C) println (44); else println (999);
L524:
        LD    A,28
L525:
        LD    L,A
        LD    H,0
L526:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L527:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L528:
        JP    NZ,L532
L529:
        LD    A,44
L530:
        CALL  writeLineA
L531:
        JP    L535
L532:
        LD    HL,999
L533:
        CALL  writeLineHL
L534:
        ;;test15.j(89)   if (0x1C ^ fw2 == 0x1228) println (45); else println (999);
L535:
        LD    A,28
L536:
        LD    L,A
        LD    H,0
L537:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L538:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L539:
        JP    NZ,L543
L540:
        LD    A,45
L541:
        CALL  writeLineA
L542:
        JP    L547
L543:
        LD    HL,999
L544:
        CALL  writeLineHL
L545:
        ;;test15.j(90)   //constant word/final var byt
L546:
        ;;test15.j(91)   if (0x1234 & fb1 == 0x0014) println (46); else println (999);
L547:
        LD    HL,4660
L548:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L549:
        LD    A,20
L550:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L551:
        JP    NZ,L555
L552:
        LD    A,46
L553:
        CALL  writeLineA
L554:
        JP    L558
L555:
        LD    HL,999
L556:
        CALL  writeLineHL
L557:
        ;;test15.j(92)   if (0x1234 | fb1 == 0x123C) println (47); else println (999);
L558:
        LD    HL,4660
L559:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L560:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L561:
        JP    NZ,L565
L562:
        LD    A,47
L563:
        CALL  writeLineA
L564:
        JP    L568
L565:
        LD    HL,999
L566:
        CALL  writeLineHL
L567:
        ;;test15.j(93)   if (0x1234 ^ fb1 == 0x1228) println (48); else println (999);
L568:
        LD    HL,4660
L569:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L570:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L571:
        JP    NZ,L575
L572:
        LD    A,48
L573:
        CALL  writeLineA
L574:
        JP    L582
L575:
        LD    HL,999
L576:
        CALL  writeLineHL
L577:
        ;;test15.j(94) 
L578:
        ;;test15.j(95)   //acc/constant
L579:
        ;;test15.j(96)   //************
L580:
        ;;test15.j(97)   //acc byte/constant byte
L581:
        ;;test15.j(98)   if ((0x04 + 0x03) & 0x1C == 0x04) println (49); else println (999);
L582:
        LD    A,4
L583:
        ADD   A,3
L584:
        AND   A,28
L585:
        SUB   A,4
L586:
        JP    NZ,L590
L587:
        LD    A,49
L588:
        CALL  writeLineA
L589:
        JP    L593
L590:
        LD    HL,999
L591:
        CALL  writeLineHL
L592:
        ;;test15.j(99)   if ((0x04 + 0x03) | 0x1C == 0x1F) println (50); else println (999);
L593:
        LD    A,4
L594:
        ADD   A,3
L595:
        OR    A,28
L596:
        SUB   A,31
L597:
        JP    NZ,L601
L598:
        LD    A,50
L599:
        CALL  writeLineA
L600:
        JP    L604
L601:
        LD    HL,999
L602:
        CALL  writeLineHL
L603:
        ;;test15.j(100)   if ((0x04 + 0x03) ^ 0x1C == 0x1B) println (51); else println (999);
L604:
        LD    A,4
L605:
        ADD   A,3
L606:
        XOR   A,28
L607:
        SUB   A,27
L608:
        JP    NZ,L612
L609:
        LD    A,51
L610:
        CALL  writeLineA
L611:
        JP    L616
L612:
        LD    HL,999
L613:
        CALL  writeLineHL
L614:
        ;;test15.j(101)   //acc word/constant word
L615:
        ;;test15.j(102)   if (0x1000 + 0x0234 & 0x032C == 0x0224) println (52); else println (999);
L616:
        LD    HL,4096
L617:
        LD    DE,564
        ADD   HL,DE
L618:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L619:
        LD    DE,548
        OR    A
        SBC   HL,DE
L620:
        JP    NZ,L624
L621:
        LD    A,52
L622:
        CALL  writeLineA
L623:
        JP    L627
L624:
        LD    HL,999
L625:
        CALL  writeLineHL
L626:
        ;;test15.j(103)   if (0x1000 + 0x0234 | 0x032C == 0x133C) println (53); else println (999);
L627:
        LD    HL,4096
L628:
        LD    DE,564
        ADD   HL,DE
L629:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L630:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L631:
        JP    NZ,L635
L632:
        LD    A,53
L633:
        CALL  writeLineA
L634:
        JP    L638
L635:
        LD    HL,999
L636:
        CALL  writeLineHL
L637:
        ;;test15.j(104)   if (0x1000 + 0x0234 ^ 0x032C == 0x1118) println (54); else println (999);
L638:
        LD    HL,4096
L639:
        LD    DE,564
        ADD   HL,DE
L640:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L641:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L642:
        JP    NZ,L646
L643:
        LD    A,54
L644:
        CALL  writeLineA
L645:
        JP    L650
L646:
        LD    HL,999
L647:
        CALL  writeLineHL
L648:
        ;;test15.j(105)   //acc byt/constant word
L649:
        ;;test15.j(106)   if (0x10 + 0x0C & 0x1234 == 0x0014) println (55); else println (999);
L650:
        LD    A,16
L651:
        ADD   A,12
L652:
        LD    L,A
        LD    H,0
L653:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L654:
        LD    A,20
L655:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L656:
        JP    NZ,L660
L657:
        LD    A,55
L658:
        CALL  writeLineA
L659:
        JP    L663
L660:
        LD    HL,999
L661:
        CALL  writeLineHL
L662:
        ;;test15.j(107)   if (0x10 + 0x0C | 0x1234 == 0x123C) println (56); else println (999);
L663:
        LD    A,16
L664:
        ADD   A,12
L665:
        LD    L,A
        LD    H,0
L666:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L667:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L668:
        JP    NZ,L672
L669:
        LD    A,56
L670:
        CALL  writeLineA
L671:
        JP    L675
L672:
        LD    HL,999
L673:
        CALL  writeLineHL
L674:
        ;;test15.j(108)   if (0x10 + 0x0C ^ 0x1234 == 0x1228) println (57); else println (999);
L675:
        LD    A,16
L676:
        ADD   A,12
L677:
        LD    L,A
        LD    H,0
L678:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L679:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L680:
        JP    NZ,L684
L681:
        LD    A,57
L682:
        CALL  writeLineA
L683:
        JP    L688
L684:
        LD    HL,999
L685:
        CALL  writeLineHL
L686:
        ;;test15.j(109)   //acc word/constant byt
L687:
        ;;test15.j(110)   if (0x1000 + 0x0234 & 0x1C == 0x0014) println (58); else println (999);
L688:
        LD    HL,4096
L689:
        LD    DE,564
        ADD   HL,DE
L690:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L691:
        LD    A,20
L692:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L693:
        JP    NZ,L697
L694:
        LD    A,58
L695:
        CALL  writeLineA
L696:
        JP    L700
L697:
        LD    HL,999
L698:
        CALL  writeLineHL
L699:
        ;;test15.j(111)   if (0x1000 + 0x0234 | 0x1C == 0x123C) println (59); else println (999);
L700:
        LD    HL,4096
L701:
        LD    DE,564
        ADD   HL,DE
L702:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L703:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L704:
        JP    NZ,L708
L705:
        LD    A,59
L706:
        CALL  writeLineA
L707:
        JP    L711
L708:
        LD    HL,999
L709:
        CALL  writeLineHL
L710:
        ;;test15.j(112)   if (0x1000 + 0x0234 ^ 0x1C == 0x1228) println (60); else println (999);
L711:
        LD    HL,4096
L712:
        LD    DE,564
        ADD   HL,DE
L713:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L714:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L715:
        JP    NZ,L719
L716:
        LD    A,60
L717:
        CALL  writeLineA
L718:
        JP    L726
L719:
        LD    HL,999
L720:
        CALL  writeLineHL
L721:
        ;;test15.j(113) 
L722:
        ;;test15.j(114)   //acc/acc
L723:
        ;;test15.j(115)   //*******
L724:
        ;;test15.j(116)   //acc byte/acc byte
L725:
        ;;test15.j(117)   if (0x04 + 0x03 & 0x10 + 0x0C == 0x04) println (61); else println (999);
L726:
        LD    A,4
L727:
        ADD   A,3
L728:
        PUSH  AF
        LD    A,16
L729:
        ADD   A,12
L730:
        POP   BC
        AND   A,B
L731:
        SUB   A,4
L732:
        JP    NZ,L736
L733:
        LD    A,61
L734:
        CALL  writeLineA
L735:
        JP    L739
L736:
        LD    HL,999
L737:
        CALL  writeLineHL
L738:
        ;;test15.j(118)   if (0x04 + 0x03 | 0x10 + 0x0C == 0x1F) println (62); else println (999);
L739:
        LD    A,4
L740:
        ADD   A,3
L741:
        PUSH  AF
        LD    A,16
L742:
        ADD   A,12
L743:
        POP   BC
        OR    A,B
L744:
        SUB   A,31
L745:
        JP    NZ,L749
L746:
        LD    A,62
L747:
        CALL  writeLineA
L748:
        JP    L752
L749:
        LD    HL,999
L750:
        CALL  writeLineHL
L751:
        ;;test15.j(119)   if (0x04 + 0x03 ^ 0x10 + 0x0C == 0x1B) println (63); else println (999);
L752:
        LD    A,4
L753:
        ADD   A,3
L754:
        PUSH  AF
        LD    A,16
L755:
        ADD   A,12
L756:
        POP   BC
        XOR   A,B
L757:
        SUB   A,27
L758:
        JP    NZ,L762
L759:
        LD    A,63
L760:
        CALL  writeLineA
L761:
        JP    L766
L762:
        LD    HL,999
L763:
        CALL  writeLineHL
L764:
        ;;test15.j(120)   //acc word/acc word
L765:
        ;;test15.j(121)   if (0x1234 & 0x0100 + 0x022C == 0x0224) println (64); else println (999);
L766:
        LD    HL,4660
L767:
        PUSH  HL
        LD    HL,256
L768:
        LD    DE,556
        ADD   HL,DE
L769:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L770:
        LD    DE,548
        OR    A
        SBC   HL,DE
L771:
        JP    NZ,L775
L772:
        LD    A,64
L773:
        CALL  writeLineA
L774:
        JP    L778
L775:
        LD    HL,999
L776:
        CALL  writeLineHL
L777:
        ;;test15.j(122)   if (0x1234 | 0x0100 + 0x022C == 0x133C) println (65); else println (999);
L778:
        LD    HL,4660
L779:
        PUSH  HL
        LD    HL,256
L780:
        LD    DE,556
        ADD   HL,DE
L781:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L782:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L783:
        JP    NZ,L787
L784:
        LD    A,65
L785:
        CALL  writeLineA
L786:
        JP    L790
L787:
        LD    HL,999
L788:
        CALL  writeLineHL
L789:
        ;;test15.j(123)   if (0x1234 ^ 0x0100 + 0x022C == 0x1118) println (66); else println (999);
L790:
        LD    HL,4660
L791:
        PUSH  HL
        LD    HL,256
L792:
        LD    DE,556
        ADD   HL,DE
L793:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L794:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L795:
        JP    NZ,L799
L796:
        LD    A,66
L797:
        CALL  writeLineA
L798:
        JP    L803
L799:
        LD    HL,999
L800:
        CALL  writeLineHL
L801:
        ;;test15.j(124)   //acc byt/acc word
L802:
        ;;test15.j(125)   if (0x10 + 0x0C & 0x1000 + 0x0234 == 0x0014) println (67); else println (999);
L803:
        LD    A,16
L804:
        ADD   A,12
L805:
        LD    HL,4096
L806:
        LD    DE,564
        ADD   HL,DE
L807:
        AND   A,L
        LD    L,A
        LD    H,0
L808:
        LD    A,20
L809:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L810:
        JP    NZ,L814
L811:
        LD    A,67
L812:
        CALL  writeLineA
L813:
        JP    L817
L814:
        LD    HL,999
L815:
        CALL  writeLineHL
L816:
        ;;test15.j(126)   if (0x10 + 0x0C | 0x1000 + 0x0234 == 0x123C) println (68); else println (999);
L817:
        LD    A,16
L818:
        ADD   A,12
L819:
        LD    HL,4096
L820:
        LD    DE,564
        ADD   HL,DE
L821:
        OR    A,L
        LD    L,A
L822:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L823:
        JP    NZ,L827
L824:
        LD    A,68
L825:
        CALL  writeLineA
L826:
        JP    L830
L827:
        LD    HL,999
L828:
        CALL  writeLineHL
L829:
        ;;test15.j(127)   if (0x10 + 0x0C ^ 0x1000 + 0x0234 == 0x1228) println (69); else println (999);
L830:
        LD    A,16
L831:
        ADD   A,12
L832:
        LD    HL,4096
L833:
        LD    DE,564
        ADD   HL,DE
L834:
        XOR   A,L
        LD    L,A
L835:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L836:
        JP    NZ,L840
L837:
        LD    A,69
L838:
        CALL  writeLineA
L839:
        JP    L844
L840:
        LD    HL,999
L841:
        CALL  writeLineHL
L842:
        ;;test15.j(128)   //acc word/acc byt
L843:
        ;;test15.j(129)   if (0x1234 & 0x10 + 0x0C == 0x0014) println (70); else println (999);
L844:
        LD    HL,4660
L845:
        LD    A,16
L846:
        ADD   A,12
L847:
        AND   A,L
        LD    L,A
        LD    H,0
L848:
        LD    A,20
L849:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L850:
        JP    NZ,L854
L851:
        LD    A,70
L852:
        CALL  writeLineA
L853:
        JP    L857
L854:
        LD    HL,999
L855:
        CALL  writeLineHL
L856:
        ;;test15.j(130)   if (0x1234 | 0x10 + 0x0C == 0x123C) println (71); else println (999);
L857:
        LD    HL,4660
L858:
        LD    A,16
L859:
        ADD   A,12
L860:
        OR    A,L
        LD    L,A
L861:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L862:
        JP    NZ,L866
L863:
        LD    A,71
L864:
        CALL  writeLineA
L865:
        JP    L869
L866:
        LD    HL,999
L867:
        CALL  writeLineHL
L868:
        ;;test15.j(131)   if (0x1234 ^ 0x10 + 0x0C == 0x1228) println (72); else println (999);
L869:
        LD    HL,4660
L870:
        LD    A,16
L871:
        ADD   A,12
L872:
        XOR   A,L
        LD    L,A
L873:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L874:
        JP    NZ,L878
L875:
        LD    A,72
L876:
        CALL  writeLineA
L877:
        JP    L885
L878:
        LD    HL,999
L879:
        CALL  writeLineHL
L880:
        ;;test15.j(132) 
L881:
        ;;test15.j(133)   //acc/var
L882:
        ;;test15.j(134)   //*******
L883:
        ;;test15.j(135)   //acc byte/var byte
L884:
        ;;test15.j(136)   if (0x04 + 0x03 & b1 == 0x04) println (73); else println (999);
L885:
        LD    A,4
L886:
        ADD   A,3
L887:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L888:
        SUB   A,4
L889:
        JP    NZ,L893
L890:
        LD    A,73
L891:
        CALL  writeLineA
L892:
        JP    L896
L893:
        LD    HL,999
L894:
        CALL  writeLineHL
L895:
        ;;test15.j(137)   if (0x04 + 0x03 | b1 == 0x1F) println (74); else println (999);
L896:
        LD    A,4
L897:
        ADD   A,3
L898:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L899:
        SUB   A,31
L900:
        JP    NZ,L904
L901:
        LD    A,74
L902:
        CALL  writeLineA
L903:
        JP    L907
L904:
        LD    HL,999
L905:
        CALL  writeLineHL
L906:
        ;;test15.j(138)   if (0x04 + 0x03 ^ b1 == 0x1B) println (75); else println (999);
L907:
        LD    A,4
L908:
        ADD   A,3
L909:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L910:
        SUB   A,27
L911:
        JP    NZ,L915
L912:
        LD    A,75
L913:
        CALL  writeLineA
L914:
        JP    L919
L915:
        LD    HL,999
L916:
        CALL  writeLineHL
L917:
        ;;test15.j(139)   //acc word/var word
L918:
        ;;test15.j(140)   if (0x1000 + 0x0234 & w1 == 0x0224) println (76); else println (999);
L919:
        LD    HL,4096
L920:
        LD    DE,564
        ADD   HL,DE
L921:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L922:
        LD    DE,548
        OR    A
        SBC   HL,DE
L923:
        JP    NZ,L927
L924:
        LD    A,76
L925:
        CALL  writeLineA
L926:
        JP    L930
L927:
        LD    HL,999
L928:
        CALL  writeLineHL
L929:
        ;;test15.j(141)   if (0x1000 + 0x0234 | w1 == 0x133C) println (77); else println (999);
L930:
        LD    HL,4096
L931:
        LD    DE,564
        ADD   HL,DE
L932:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L933:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L934:
        JP    NZ,L938
L935:
        LD    A,77
L936:
        CALL  writeLineA
L937:
        JP    L941
L938:
        LD    HL,999
L939:
        CALL  writeLineHL
L940:
        ;;test15.j(142)   if (0x1000 + 0x0234 ^ w1 == 0x1118) println (78); else println (999);
L941:
        LD    HL,4096
L942:
        LD    DE,564
        ADD   HL,DE
L943:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L944:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L945:
        JP    NZ,L949
L946:
        LD    A,78
L947:
        CALL  writeLineA
L948:
        JP    L953
L949:
        LD    HL,999
L950:
        CALL  writeLineHL
L951:
        ;;test15.j(143)   //acc byt/var word
L952:
        ;;test15.j(144)   if (0x10 + 0x0C & w2 == 0x0014) println (79); else println (999);
L953:
        LD    A,16
L954:
        ADD   A,12
L955:
        LD    L,A
        LD    H,0
L956:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L957:
        LD    A,20
L958:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L959:
        JP    NZ,L963
L960:
        LD    A,79
L961:
        CALL  writeLineA
L962:
        JP    L966
L963:
        LD    HL,999
L964:
        CALL  writeLineHL
L965:
        ;;test15.j(145)   if (0x10 + 0x0C | w2 == 0x123C) println (80); else println (999);
L966:
        LD    A,16
L967:
        ADD   A,12
L968:
        LD    L,A
        LD    H,0
L969:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L970:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L971:
        JP    NZ,L975
L972:
        LD    A,80
L973:
        CALL  writeLineA
L974:
        JP    L978
L975:
        LD    HL,999
L976:
        CALL  writeLineHL
L977:
        ;;test15.j(146)   if (0x10 + 0x0C ^ w2 == 0x1228) println (81); else println (999);
L978:
        LD    A,16
L979:
        ADD   A,12
L980:
        LD    L,A
        LD    H,0
L981:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L982:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L983:
        JP    NZ,L987
L984:
        LD    A,81
L985:
        CALL  writeLineA
L986:
        JP    L991
L987:
        LD    HL,999
L988:
        CALL  writeLineHL
L989:
        ;;test15.j(147)   //acc word/var byt
L990:
        ;;test15.j(148)   if (0x1000 + 0x0234 & b1 == 0x0014) println (82); else println (999);
L991:
        LD    HL,4096
L992:
        LD    DE,564
        ADD   HL,DE
L993:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L994:
        LD    A,20
L995:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L996:
        JP    NZ,L1000
L997:
        LD    A,82
L998:
        CALL  writeLineA
L999:
        JP    L1003
L1000:
        LD    HL,999
L1001:
        CALL  writeLineHL
L1002:
        ;;test15.j(149)   if (0x1000 + 0x0234 | b1 == 0x123C) println (83); else println (999);
L1003:
        LD    HL,4096
L1004:
        LD    DE,564
        ADD   HL,DE
L1005:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1006:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1007:
        JP    NZ,L1011
L1008:
        LD    A,83
L1009:
        CALL  writeLineA
L1010:
        JP    L1014
L1011:
        LD    HL,999
L1012:
        CALL  writeLineHL
L1013:
        ;;test15.j(150)   if (0x1000 + 0x0234 ^ b1 == 0x1228) println (84); else println (999);
L1014:
        LD    HL,4096
L1015:
        LD    DE,564
        ADD   HL,DE
L1016:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1017:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1018:
        JP    NZ,L1022
L1019:
        LD    A,84
L1020:
        CALL  writeLineA
L1021:
        JP    L1029
L1022:
        LD    HL,999
L1023:
        CALL  writeLineHL
L1024:
        ;;test15.j(151) 
L1025:
        ;;test15.j(152)   //acc/final var
L1026:
        ;;test15.j(153)   //*************
L1027:
        ;;test15.j(154)   //acc byte/final var byte
L1028:
        ;;test15.j(155)   if (0x04 + 0x03 & fb1 == 0x04) println (85); else println (999);
L1029:
        LD    A,4
L1030:
        ADD   A,3
L1031:
        AND   A,28
L1032:
        SUB   A,4
L1033:
        JP    NZ,L1037
L1034:
        LD    A,85
L1035:
        CALL  writeLineA
L1036:
        JP    L1040
L1037:
        LD    HL,999
L1038:
        CALL  writeLineHL
L1039:
        ;;test15.j(156)   if (0x04 + 0x03 | fb1 == 0x1F) println (86); else println (999);
L1040:
        LD    A,4
L1041:
        ADD   A,3
L1042:
        OR    A,28
L1043:
        SUB   A,31
L1044:
        JP    NZ,L1048
L1045:
        LD    A,86
L1046:
        CALL  writeLineA
L1047:
        JP    L1051
L1048:
        LD    HL,999
L1049:
        CALL  writeLineHL
L1050:
        ;;test15.j(157)   if (0x04 + 0x03 ^ fb1 == 0x1B) println (87); else println (999);
L1051:
        LD    A,4
L1052:
        ADD   A,3
L1053:
        XOR   A,28
L1054:
        SUB   A,27
L1055:
        JP    NZ,L1059
L1056:
        LD    A,87
L1057:
        CALL  writeLineA
L1058:
        JP    L1063
L1059:
        LD    HL,999
L1060:
        CALL  writeLineHL
L1061:
        ;;test15.j(158)   //acc word/final var word
L1062:
        ;;test15.j(159)   if (0x1000 + 0x0234 & fw1 == 0x0224) println (88); else println (999);
L1063:
        LD    HL,4096
L1064:
        LD    DE,564
        ADD   HL,DE
L1065:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1066:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1067:
        JP    NZ,L1071
L1068:
        LD    A,88
L1069:
        CALL  writeLineA
L1070:
        JP    L1074
L1071:
        LD    HL,999
L1072:
        CALL  writeLineHL
L1073:
        ;;test15.j(160)   if (0x1000 + 0x0234 | fw1 == 0x133C) println (89); else println (999);
L1074:
        LD    HL,4096
L1075:
        LD    DE,564
        ADD   HL,DE
L1076:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1077:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1078:
        JP    NZ,L1082
L1079:
        LD    A,89
L1080:
        CALL  writeLineA
L1081:
        JP    L1085
L1082:
        LD    HL,999
L1083:
        CALL  writeLineHL
L1084:
        ;;test15.j(161)   if (0x1000 + 0x0234 ^ fw1 == 0x1118) println (90); else println (999);
L1085:
        LD    HL,4096
L1086:
        LD    DE,564
        ADD   HL,DE
L1087:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1088:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1089:
        JP    NZ,L1093
L1090:
        LD    A,90
L1091:
        CALL  writeLineA
L1092:
        JP    L1097
L1093:
        LD    HL,999
L1094:
        CALL  writeLineHL
L1095:
        ;;test15.j(162)   //acc byt/final var word
L1096:
        ;;test15.j(163)   if (0x10 + 0x0C & fw2 == 0x0014) println (91); else println (999);
L1097:
        LD    A,16
L1098:
        ADD   A,12
L1099:
        LD    L,A
        LD    H,0
L1100:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1101:
        LD    A,20
L1102:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1103:
        JP    NZ,L1107
L1104:
        LD    A,91
L1105:
        CALL  writeLineA
L1106:
        JP    L1110
L1107:
        LD    HL,999
L1108:
        CALL  writeLineHL
L1109:
        ;;test15.j(164)   if (0x10 + 0x0C | fw2 == 0x123C) println (92); else println (999);
L1110:
        LD    A,16
L1111:
        ADD   A,12
L1112:
        LD    L,A
        LD    H,0
L1113:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1114:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1115:
        JP    NZ,L1119
L1116:
        LD    A,92
L1117:
        CALL  writeLineA
L1118:
        JP    L1122
L1119:
        LD    HL,999
L1120:
        CALL  writeLineHL
L1121:
        ;;test15.j(165)   if (0x10 + 0x0C ^ fw2 == 0x1228) println (93); else println (999);
L1122:
        LD    A,16
L1123:
        ADD   A,12
L1124:
        LD    L,A
        LD    H,0
L1125:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1126:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1127:
        JP    NZ,L1131
L1128:
        LD    A,93
L1129:
        CALL  writeLineA
L1130:
        JP    L1135
L1131:
        LD    HL,999
L1132:
        CALL  writeLineHL
L1133:
        ;;test15.j(166)   //acc word/final var byt
L1134:
        ;;test15.j(167)   if (0x1000 + 0x0234 & fb1 == 0x0014) println (94); else println (999);
L1135:
        LD    HL,4096
L1136:
        LD    DE,564
        ADD   HL,DE
L1137:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1138:
        LD    A,20
L1139:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1140:
        JP    NZ,L1144
L1141:
        LD    A,94
L1142:
        CALL  writeLineA
L1143:
        JP    L1147
L1144:
        LD    HL,999
L1145:
        CALL  writeLineHL
L1146:
        ;;test15.j(168)   if (0x1000 + 0x0234 | fb1 == 0x123C) println (95); else println (999);
L1147:
        LD    HL,4096
L1148:
        LD    DE,564
        ADD   HL,DE
L1149:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1150:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1151:
        JP    NZ,L1155
L1152:
        LD    A,95
L1153:
        CALL  writeLineA
L1154:
        JP    L1158
L1155:
        LD    HL,999
L1156:
        CALL  writeLineHL
L1157:
        ;;test15.j(169)   if (0x1000 + 0x0234 ^ fb1 == 0x1228) println (96); else println (999);
L1158:
        LD    HL,4096
L1159:
        LD    DE,564
        ADD   HL,DE
L1160:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1161:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1162:
        JP    NZ,L1166
L1163:
        LD    A,96
L1164:
        CALL  writeLineA
L1165:
        JP    L1173
L1166:
        LD    HL,999
L1167:
        CALL  writeLineHL
L1168:
        ;;test15.j(170) 
L1169:
        ;;test15.j(171)   //var/constant
L1170:
        ;;test15.j(172)   //************
L1171:
        ;;test15.j(173)   //var byte/constant byte
L1172:
        ;;test15.j(174)   if (b2 & 0x1C == 0x04) println (97); else println (999);
L1173:
        LD    A,(05001H)
L1174:
        AND   A,28
L1175:
        SUB   A,4
L1176:
        JP    NZ,L1180
L1177:
        LD    A,97
L1178:
        CALL  writeLineA
L1179:
        JP    L1183
L1180:
        LD    HL,999
L1181:
        CALL  writeLineHL
L1182:
        ;;test15.j(175)   if (b2 | 0x1C == 0x1F) println (98); else println (999);
L1183:
        LD    A,(05001H)
L1184:
        OR    A,28
L1185:
        SUB   A,31
L1186:
        JP    NZ,L1190
L1187:
        LD    A,98
L1188:
        CALL  writeLineA
L1189:
        JP    L1193
L1190:
        LD    HL,999
L1191:
        CALL  writeLineHL
L1192:
        ;;test15.j(176)   if (b2 ^ 0x1C == 0x1B) println (99); else println (999);
L1193:
        LD    A,(05001H)
L1194:
        XOR   A,28
L1195:
        SUB   A,27
L1196:
        JP    NZ,L1200
L1197:
        LD    A,99
L1198:
        CALL  writeLineA
L1199:
        JP    L1204
L1200:
        LD    HL,999
L1201:
        CALL  writeLineHL
L1202:
        ;;test15.j(177)   //var word/constant word
L1203:
        ;;test15.j(178)   if (w2 & 0x032C == 0x0224) println (100); else println (999);
L1204:
        LD    HL,(05004H)
L1205:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1206:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1207:
        JP    NZ,L1211
L1208:
        LD    A,100
L1209:
        CALL  writeLineA
L1210:
        JP    L1214
L1211:
        LD    HL,999
L1212:
        CALL  writeLineHL
L1213:
        ;;test15.j(179)   if (w2 | 0x032C == 0x133C) println (101); else println (999);
L1214:
        LD    HL,(05004H)
L1215:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1216:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1217:
        JP    NZ,L1221
L1218:
        LD    A,101
L1219:
        CALL  writeLineA
L1220:
        JP    L1224
L1221:
        LD    HL,999
L1222:
        CALL  writeLineHL
L1223:
        ;;test15.j(180)   if (w2 ^ 0x032C == 0x1118) println (102); else println (999);
L1224:
        LD    HL,(05004H)
L1225:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1226:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1227:
        JP    NZ,L1231
L1228:
        LD    A,102
L1229:
        CALL  writeLineA
L1230:
        JP    L1235
L1231:
        LD    HL,999
L1232:
        CALL  writeLineHL
L1233:
        ;;test15.j(181)   //var byt/constant word
L1234:
        ;;test15.j(182)   if (b1 & 0x1234 == 0x0014) println (103); else println (999);
L1235:
        LD    A,(05000H)
L1236:
        LD    L,A
        LD    H,0
L1237:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1238:
        LD    A,20
L1239:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1240:
        JP    NZ,L1244
L1241:
        LD    A,103
L1242:
        CALL  writeLineA
L1243:
        JP    L1247
L1244:
        LD    HL,999
L1245:
        CALL  writeLineHL
L1246:
        ;;test15.j(183)   if (b1 | 0x1234 == 0x123C) println (104); else println (999);
L1247:
        LD    A,(05000H)
L1248:
        LD    L,A
        LD    H,0
L1249:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1250:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1251:
        JP    NZ,L1255
L1252:
        LD    A,104
L1253:
        CALL  writeLineA
L1254:
        JP    L1258
L1255:
        LD    HL,999
L1256:
        CALL  writeLineHL
L1257:
        ;;test15.j(184)   if (b1 ^ 0x1234 == 0x1228) println (105); else println (999);
L1258:
        LD    A,(05000H)
L1259:
        LD    L,A
        LD    H,0
L1260:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1261:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1262:
        JP    NZ,L1266
L1263:
        LD    A,105
L1264:
        CALL  writeLineA
L1265:
        JP    L1270
L1266:
        LD    HL,999
L1267:
        CALL  writeLineHL
L1268:
        ;;test15.j(185)   //var word/constant byt
L1269:
        ;;test15.j(186)   if (w2 & 0x1C == 0x0014) println (106); else println (999);
L1270:
        LD    HL,(05004H)
L1271:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1272:
        LD    A,20
L1273:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1274:
        JP    NZ,L1278
L1275:
        LD    A,106
L1276:
        CALL  writeLineA
L1277:
        JP    L1281
L1278:
        LD    HL,999
L1279:
        CALL  writeLineHL
L1280:
        ;;test15.j(187)   if (w2 | 0x1C == 0x123C) println (107); else println (999);
L1281:
        LD    HL,(05004H)
L1282:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1283:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1284:
        JP    NZ,L1288
L1285:
        LD    A,107
L1286:
        CALL  writeLineA
L1287:
        JP    L1291
L1288:
        LD    HL,999
L1289:
        CALL  writeLineHL
L1290:
        ;;test15.j(188)   if (w2 ^ 0x1C == 0x1228) println (108); else println (999);
L1291:
        LD    HL,(05004H)
L1292:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1293:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1294:
        JP    NZ,L1298
L1295:
        LD    A,108
L1296:
        CALL  writeLineA
L1297:
        JP    L1305
L1298:
        LD    HL,999
L1299:
        CALL  writeLineHL
L1300:
        ;;test15.j(189) 
L1301:
        ;;test15.j(190)   //var/acc
L1302:
        ;;test15.j(191)   //*******
L1303:
        ;;test15.j(192)   //var byte/acc byte
L1304:
        ;;test15.j(193)   if (b2 & (0x10 + 0x0C) == 0x04) println (109); else println (999);
L1305:
        LD    A,(05001H)
L1306:
        PUSH  AF
        LD    A,16
L1307:
        ADD   A,12
L1308:
        POP   BC
        AND   A,B
L1309:
        SUB   A,4
L1310:
        JP    NZ,L1314
L1311:
        LD    A,109
L1312:
        CALL  writeLineA
L1313:
        JP    L1317
L1314:
        LD    HL,999
L1315:
        CALL  writeLineHL
L1316:
        ;;test15.j(194)   if (b2 | (0x10 + 0x0C) == 0x1F) println (110); else println (999);
L1317:
        LD    A,(05001H)
L1318:
        PUSH  AF
        LD    A,16
L1319:
        ADD   A,12
L1320:
        POP   BC
        OR    A,B
L1321:
        SUB   A,31
L1322:
        JP    NZ,L1326
L1323:
        LD    A,110
L1324:
        CALL  writeLineA
L1325:
        JP    L1329
L1326:
        LD    HL,999
L1327:
        CALL  writeLineHL
L1328:
        ;;test15.j(195)   if (b2 ^ (0x10 + 0x0C) == 0x1B) println (111); else println (999);
L1329:
        LD    A,(05001H)
L1330:
        PUSH  AF
        LD    A,16
L1331:
        ADD   A,12
L1332:
        POP   BC
        XOR   A,B
L1333:
        SUB   A,27
L1334:
        JP    NZ,L1338
L1335:
        LD    A,111
L1336:
        CALL  writeLineA
L1337:
        JP    L1342
L1338:
        LD    HL,999
L1339:
        CALL  writeLineHL
L1340:
        ;;test15.j(196)   //var word/acc word
L1341:
        ;;test15.j(197)   if (w2 & 0x0100 + 0x022C == 0x0224) println (112); else println (999);
L1342:
        LD    HL,(05004H)
L1343:
        PUSH  HL
        LD    HL,256
L1344:
        LD    DE,556
        ADD   HL,DE
L1345:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1346:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1347:
        JP    NZ,L1351
L1348:
        LD    A,112
L1349:
        CALL  writeLineA
L1350:
        JP    L1354
L1351:
        LD    HL,999
L1352:
        CALL  writeLineHL
L1353:
        ;;test15.j(198)   if (w2 | 0x0100 + 0x022C == 0x133C) println (113); else println (999);
L1354:
        LD    HL,(05004H)
L1355:
        PUSH  HL
        LD    HL,256
L1356:
        LD    DE,556
        ADD   HL,DE
L1357:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1358:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1359:
        JP    NZ,L1363
L1360:
        LD    A,113
L1361:
        CALL  writeLineA
L1362:
        JP    L1366
L1363:
        LD    HL,999
L1364:
        CALL  writeLineHL
L1365:
        ;;test15.j(199)   if (w2 ^ 0x0100 + 0x022C == 0x1118) println (114); else println (999);
L1366:
        LD    HL,(05004H)
L1367:
        PUSH  HL
        LD    HL,256
L1368:
        LD    DE,556
        ADD   HL,DE
L1369:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1370:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1371:
        JP    NZ,L1375
L1372:
        LD    A,114
L1373:
        CALL  writeLineA
L1374:
        JP    L1379
L1375:
        LD    HL,999
L1376:
        CALL  writeLineHL
L1377:
        ;;test15.j(200)   //var byt/acc word
L1378:
        ;;test15.j(201)   if (b1 & 0x1000 + 0x0234 == 0x0014) println (115); else println (999);
L1379:
        LD    A,(05000H)
L1380:
        LD    HL,4096
L1381:
        LD    DE,564
        ADD   HL,DE
L1382:
        AND   A,L
        LD    L,A
        LD    H,0
L1383:
        LD    A,20
L1384:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1385:
        JP    NZ,L1389
L1386:
        LD    A,115
L1387:
        CALL  writeLineA
L1388:
        JP    L1392
L1389:
        LD    HL,999
L1390:
        CALL  writeLineHL
L1391:
        ;;test15.j(202)   if (b1 | 0x1000 + 0x0234 == 0x123C) println (116); else println (999);
L1392:
        LD    A,(05000H)
L1393:
        LD    HL,4096
L1394:
        LD    DE,564
        ADD   HL,DE
L1395:
        OR    A,L
        LD    L,A
L1396:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1397:
        JP    NZ,L1401
L1398:
        LD    A,116
L1399:
        CALL  writeLineA
L1400:
        JP    L1404
L1401:
        LD    HL,999
L1402:
        CALL  writeLineHL
L1403:
        ;;test15.j(203)   if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (117); else println (999);
L1404:
        LD    A,(05000H)
L1405:
        LD    HL,4096
L1406:
        LD    DE,564
        ADD   HL,DE
L1407:
        XOR   A,L
        LD    L,A
L1408:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1409:
        JP    NZ,L1413
L1410:
        LD    A,117
L1411:
        CALL  writeLineA
L1412:
        JP    L1417
L1413:
        LD    HL,999
L1414:
        CALL  writeLineHL
L1415:
        ;;test15.j(204)   //var word/acc byt
L1416:
        ;;test15.j(205)   if (w2 & 0x10 + 0x0C == 0x0014) println (118); else println (999);
L1417:
        LD    HL,(05004H)
L1418:
        LD    A,16
L1419:
        ADD   A,12
L1420:
        AND   A,L
        LD    L,A
        LD    H,0
L1421:
        LD    A,20
L1422:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1423:
        JP    NZ,L1427
L1424:
        LD    A,118
L1425:
        CALL  writeLineA
L1426:
        JP    L1430
L1427:
        LD    HL,999
L1428:
        CALL  writeLineHL
L1429:
        ;;test15.j(206)   if (w2 | 0x10 + 0x0C == 0x123C) println (119); else println (999);
L1430:
        LD    HL,(05004H)
L1431:
        LD    A,16
L1432:
        ADD   A,12
L1433:
        OR    A,L
        LD    L,A
L1434:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1435:
        JP    NZ,L1439
L1436:
        LD    A,119
L1437:
        CALL  writeLineA
L1438:
        JP    L1442
L1439:
        LD    HL,999
L1440:
        CALL  writeLineHL
L1441:
        ;;test15.j(207)   if (w2 ^ 0x10 + 0x0C == 0x1228) println (120); else println (999);
L1442:
        LD    HL,(05004H)
L1443:
        LD    A,16
L1444:
        ADD   A,12
L1445:
        XOR   A,L
        LD    L,A
L1446:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1447:
        JP    NZ,L1451
L1448:
        LD    A,120
L1449:
        CALL  writeLineA
L1450:
        JP    L1458
L1451:
        LD    HL,999
L1452:
        CALL  writeLineHL
L1453:
        ;;test15.j(208) 
L1454:
        ;;test15.j(209)   //var/var
L1455:
        ;;test15.j(210)   //*******
L1456:
        ;;test15.j(211)   //var byte/var byte
L1457:
        ;;test15.j(212)   if (b2 & b1 == 0x04) println (121); else println (999);
L1458:
        LD    A,(05001H)
L1459:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L1460:
        SUB   A,4
L1461:
        JP    NZ,L1465
L1462:
        LD    A,121
L1463:
        CALL  writeLineA
L1464:
        JP    L1468
L1465:
        LD    HL,999
L1466:
        CALL  writeLineHL
L1467:
        ;;test15.j(213)   if (b2 | b1 == 0x1F) println (122); else println (999);
L1468:
        LD    A,(05001H)
L1469:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L1470:
        SUB   A,31
L1471:
        JP    NZ,L1475
L1472:
        LD    A,122
L1473:
        CALL  writeLineA
L1474:
        JP    L1478
L1475:
        LD    HL,999
L1476:
        CALL  writeLineHL
L1477:
        ;;test15.j(214)   if (b2 ^ b1 == 0x1B) println (123); else println (999);
L1478:
        LD    A,(05001H)
L1479:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L1480:
        SUB   A,27
L1481:
        JP    NZ,L1485
L1482:
        LD    A,123
L1483:
        CALL  writeLineA
L1484:
        JP    L1489
L1485:
        LD    HL,999
L1486:
        CALL  writeLineHL
L1487:
        ;;test15.j(215)   //var word/var word
L1488:
        ;;test15.j(216)   if (w2 & w1 == 0x0224) println (124); else println (999);
L1489:
        LD    HL,(05004H)
L1490:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1491:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1492:
        JP    NZ,L1496
L1493:
        LD    A,124
L1494:
        CALL  writeLineA
L1495:
        JP    L1499
L1496:
        LD    HL,999
L1497:
        CALL  writeLineHL
L1498:
        ;;test15.j(217)   if (w2 | w1 == 0x133C) println (125); else println (999);
L1499:
        LD    HL,(05004H)
L1500:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1501:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1502:
        JP    NZ,L1506
L1503:
        LD    A,125
L1504:
        CALL  writeLineA
L1505:
        JP    L1509
L1506:
        LD    HL,999
L1507:
        CALL  writeLineHL
L1508:
        ;;test15.j(218)   if (w2 ^ w1 == 0x1118) println (126); else println (999);
L1509:
        LD    HL,(05004H)
L1510:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1511:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1512:
        JP    NZ,L1516
L1513:
        LD    A,126
L1514:
        CALL  writeLineA
L1515:
        JP    L1520
L1516:
        LD    HL,999
L1517:
        CALL  writeLineHL
L1518:
        ;;test15.j(219)   //var byt/var word
L1519:
        ;;test15.j(220)   if (b1 & w2 == 0x0014) println (127); else println (999);
L1520:
        LD    A,(05000H)
L1521:
        LD    L,A
        LD    H,0
L1522:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1523:
        LD    A,20
L1524:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1525:
        JP    NZ,L1529
L1526:
        LD    A,127
L1527:
        CALL  writeLineA
L1528:
        JP    L1532
L1529:
        LD    HL,999
L1530:
        CALL  writeLineHL
L1531:
        ;;test15.j(221)   if (b1 | w2 == 0x123C) println (128); else println (999);
L1532:
        LD    A,(05000H)
L1533:
        LD    L,A
        LD    H,0
L1534:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1535:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1536:
        JP    NZ,L1540
L1537:
        LD    A,128
L1538:
        CALL  writeLineA
L1539:
        JP    L1543
L1540:
        LD    HL,999
L1541:
        CALL  writeLineHL
L1542:
        ;;test15.j(222)   if (b1 ^ w2 == 0x1228) println (129); else println (999);
L1543:
        LD    A,(05000H)
L1544:
        LD    L,A
        LD    H,0
L1545:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1546:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1547:
        JP    NZ,L1551
L1548:
        LD    A,129
L1549:
        CALL  writeLineA
L1550:
        JP    L1555
L1551:
        LD    HL,999
L1552:
        CALL  writeLineHL
L1553:
        ;;test15.j(223)   //var word/var byt
L1554:
        ;;test15.j(224)   if (w2 & b1 == 0x0014) println (130); else println (999);
L1555:
        LD    HL,(05004H)
L1556:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1557:
        LD    A,20
L1558:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1559:
        JP    NZ,L1563
L1560:
        LD    A,130
L1561:
        CALL  writeLineA
L1562:
        JP    L1566
L1563:
        LD    HL,999
L1564:
        CALL  writeLineHL
L1565:
        ;;test15.j(225)   if (w2 | b1 == 0x123C) println (131); else println (999);
L1566:
        LD    HL,(05004H)
L1567:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1568:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1569:
        JP    NZ,L1573
L1570:
        LD    A,131
L1571:
        CALL  writeLineA
L1572:
        JP    L1576
L1573:
        LD    HL,999
L1574:
        CALL  writeLineHL
L1575:
        ;;test15.j(226)   if (w2 ^ b1 == 0x1228) println (132); else println (999);
L1576:
        LD    HL,(05004H)
L1577:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1578:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1579:
        JP    NZ,L1583
L1580:
        LD    A,132
L1581:
        CALL  writeLineA
L1582:
        JP    L1590
L1583:
        LD    HL,999
L1584:
        CALL  writeLineHL
L1585:
        ;;test15.j(227) 
L1586:
        ;;test15.j(228)   //var/final var
L1587:
        ;;test15.j(229)   //*************
L1588:
        ;;test15.j(230)   //var byte/final var byte
L1589:
        ;;test15.j(231)   if (b2 & fb1 == 0x04) println (133); else println (999);
L1590:
        LD    A,(05001H)
L1591:
        AND   A,28
L1592:
        SUB   A,4
L1593:
        JP    NZ,L1597
L1594:
        LD    A,133
L1595:
        CALL  writeLineA
L1596:
        JP    L1600
L1597:
        LD    HL,999
L1598:
        CALL  writeLineHL
L1599:
        ;;test15.j(232)   if (b2 | fb1 == 0x1F) println (134); else println (999);
L1600:
        LD    A,(05001H)
L1601:
        OR    A,28
L1602:
        SUB   A,31
L1603:
        JP    NZ,L1607
L1604:
        LD    A,134
L1605:
        CALL  writeLineA
L1606:
        JP    L1610
L1607:
        LD    HL,999
L1608:
        CALL  writeLineHL
L1609:
        ;;test15.j(233)   if (b2 ^ fb1 == 0x1B) println (135); else println (999);
L1610:
        LD    A,(05001H)
L1611:
        XOR   A,28
L1612:
        SUB   A,27
L1613:
        JP    NZ,L1617
L1614:
        LD    A,135
L1615:
        CALL  writeLineA
L1616:
        JP    L1621
L1617:
        LD    HL,999
L1618:
        CALL  writeLineHL
L1619:
        ;;test15.j(234)   //var word/final var word
L1620:
        ;;test15.j(235)   if (w2 & fw1 == 0x0224) println (136); else println (999);
L1621:
        LD    HL,(05004H)
L1622:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1623:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1624:
        JP    NZ,L1628
L1625:
        LD    A,136
L1626:
        CALL  writeLineA
L1627:
        JP    L1631
L1628:
        LD    HL,999
L1629:
        CALL  writeLineHL
L1630:
        ;;test15.j(236)   if (w2 | fw1 == 0x133C) println (137); else println (999);
L1631:
        LD    HL,(05004H)
L1632:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1633:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1634:
        JP    NZ,L1638
L1635:
        LD    A,137
L1636:
        CALL  writeLineA
L1637:
        JP    L1641
L1638:
        LD    HL,999
L1639:
        CALL  writeLineHL
L1640:
        ;;test15.j(237)   if (w2 ^ fw1 == 0x1118) println (138); else println (999);
L1641:
        LD    HL,(05004H)
L1642:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1643:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1644:
        JP    NZ,L1648
L1645:
        LD    A,138
L1646:
        CALL  writeLineA
L1647:
        JP    L1652
L1648:
        LD    HL,999
L1649:
        CALL  writeLineHL
L1650:
        ;;test15.j(238)   //var byt/final var word
L1651:
        ;;test15.j(239)   if (b1 & fw2 == 0x0014) println (139); else println (999);
L1652:
        LD    A,(05000H)
L1653:
        LD    L,A
        LD    H,0
L1654:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1655:
        LD    A,20
L1656:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1657:
        JP    NZ,L1661
L1658:
        LD    A,139
L1659:
        CALL  writeLineA
L1660:
        JP    L1664
L1661:
        LD    HL,999
L1662:
        CALL  writeLineHL
L1663:
        ;;test15.j(240)   if (b1 | fw2 == 0x123C) println (140); else println (999);
L1664:
        LD    A,(05000H)
L1665:
        LD    L,A
        LD    H,0
L1666:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1667:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1668:
        JP    NZ,L1672
L1669:
        LD    A,140
L1670:
        CALL  writeLineA
L1671:
        JP    L1675
L1672:
        LD    HL,999
L1673:
        CALL  writeLineHL
L1674:
        ;;test15.j(241)   if (b1 ^ fw2 == 0x1228) println (141); else println (999);
L1675:
        LD    A,(05000H)
L1676:
        LD    L,A
        LD    H,0
L1677:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1678:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1679:
        JP    NZ,L1683
L1680:
        LD    A,141
L1681:
        CALL  writeLineA
L1682:
        JP    L1687
L1683:
        LD    HL,999
L1684:
        CALL  writeLineHL
L1685:
        ;;test15.j(242)   //var word/final var byt
L1686:
        ;;test15.j(243)   if (w2 & fb1 == 0x0014) println (142); else println (999);
L1687:
        LD    HL,(05004H)
L1688:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1689:
        LD    A,20
L1690:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1691:
        JP    NZ,L1695
L1692:
        LD    A,142
L1693:
        CALL  writeLineA
L1694:
        JP    L1698
L1695:
        LD    HL,999
L1696:
        CALL  writeLineHL
L1697:
        ;;test15.j(244)   if (w2 | fb1 == 0x123C) println (143); else println (999);
L1698:
        LD    HL,(05004H)
L1699:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1700:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1701:
        JP    NZ,L1705
L1702:
        LD    A,143
L1703:
        CALL  writeLineA
L1704:
        JP    L1708
L1705:
        LD    HL,999
L1706:
        CALL  writeLineHL
L1707:
        ;;test15.j(245)   if (w2 ^ fb1 == 0x1228) println (144); else println (999);
L1708:
        LD    HL,(05004H)
L1709:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1710:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1711:
        JP    NZ,L1715
L1712:
        LD    A,144
L1713:
        CALL  writeLineA
L1714:
        JP    L1722
L1715:
        LD    HL,999
L1716:
        CALL  writeLineHL
L1717:
        ;;test15.j(246) 
L1718:
        ;;test15.j(247)   //final var/constant
L1719:
        ;;test15.j(248)   //******************
L1720:
        ;;test15.j(249)   //final var byte/constant byte
L1721:
        ;;test15.j(250)   if (b2 & 0x1C == 0x04) println (145); else println (999);
L1722:
        LD    A,(05001H)
L1723:
        AND   A,28
L1724:
        SUB   A,4
L1725:
        JP    NZ,L1729
L1726:
        LD    A,145
L1727:
        CALL  writeLineA
L1728:
        JP    L1732
L1729:
        LD    HL,999
L1730:
        CALL  writeLineHL
L1731:
        ;;test15.j(251)   if (b2 | 0x1C == 0x1F) println (146); else println (999);
L1732:
        LD    A,(05001H)
L1733:
        OR    A,28
L1734:
        SUB   A,31
L1735:
        JP    NZ,L1739
L1736:
        LD    A,146
L1737:
        CALL  writeLineA
L1738:
        JP    L1742
L1739:
        LD    HL,999
L1740:
        CALL  writeLineHL
L1741:
        ;;test15.j(252)   if (b2 ^ 0x1C == 0x1B) println (147); else println (999);
L1742:
        LD    A,(05001H)
L1743:
        XOR   A,28
L1744:
        SUB   A,27
L1745:
        JP    NZ,L1749
L1746:
        LD    A,147
L1747:
        CALL  writeLineA
L1748:
        JP    L1753
L1749:
        LD    HL,999
L1750:
        CALL  writeLineHL
L1751:
        ;;test15.j(253)   //final var word/constant word
L1752:
        ;;test15.j(254)   if (w2 & 0x032C == 0x0224) println (148); else println (999);
L1753:
        LD    HL,(05004H)
L1754:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1755:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1756:
        JP    NZ,L1760
L1757:
        LD    A,148
L1758:
        CALL  writeLineA
L1759:
        JP    L1763
L1760:
        LD    HL,999
L1761:
        CALL  writeLineHL
L1762:
        ;;test15.j(255)   if (w2 | 0x032C == 0x133C) println (149); else println (999);
L1763:
        LD    HL,(05004H)
L1764:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1765:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1766:
        JP    NZ,L1770
L1767:
        LD    A,149
L1768:
        CALL  writeLineA
L1769:
        JP    L1773
L1770:
        LD    HL,999
L1771:
        CALL  writeLineHL
L1772:
        ;;test15.j(256)   if (w2 ^ 0x032C == 0x1118) println (150); else println (999);
L1773:
        LD    HL,(05004H)
L1774:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1775:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1776:
        JP    NZ,L1780
L1777:
        LD    A,150
L1778:
        CALL  writeLineA
L1779:
        JP    L1784
L1780:
        LD    HL,999
L1781:
        CALL  writeLineHL
L1782:
        ;;test15.j(257)   //final var byt/constant word
L1783:
        ;;test15.j(258)   if (b1 & 0x1234 == 0x0014) println (151); else println (999);
L1784:
        LD    A,(05000H)
L1785:
        LD    L,A
        LD    H,0
L1786:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1787:
        LD    A,20
L1788:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1789:
        JP    NZ,L1793
L1790:
        LD    A,151
L1791:
        CALL  writeLineA
L1792:
        JP    L1796
L1793:
        LD    HL,999
L1794:
        CALL  writeLineHL
L1795:
        ;;test15.j(259)   if (b1 | 0x1234 == 0x123C) println (152); else println (999);
L1796:
        LD    A,(05000H)
L1797:
        LD    L,A
        LD    H,0
L1798:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1799:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1800:
        JP    NZ,L1804
L1801:
        LD    A,152
L1802:
        CALL  writeLineA
L1803:
        JP    L1807
L1804:
        LD    HL,999
L1805:
        CALL  writeLineHL
L1806:
        ;;test15.j(260)   if (b1 ^ 0x1234 == 0x1228) println (153); else println (999);
L1807:
        LD    A,(05000H)
L1808:
        LD    L,A
        LD    H,0
L1809:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1810:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1811:
        JP    NZ,L1815
L1812:
        LD    A,153
L1813:
        CALL  writeLineA
L1814:
        JP    L1819
L1815:
        LD    HL,999
L1816:
        CALL  writeLineHL
L1817:
        ;;test15.j(261)   //final var word/constant byt
L1818:
        ;;test15.j(262)   if (w2 & 0x1C == 0x0014) println (154); else println (999);
L1819:
        LD    HL,(05004H)
L1820:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1821:
        LD    A,20
L1822:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1823:
        JP    NZ,L1827
L1824:
        LD    A,154
L1825:
        CALL  writeLineA
L1826:
        JP    L1830
L1827:
        LD    HL,999
L1828:
        CALL  writeLineHL
L1829:
        ;;test15.j(263)   if (w2 | 0x1C == 0x123C) println (155); else println (999);
L1830:
        LD    HL,(05004H)
L1831:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1832:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1833:
        JP    NZ,L1837
L1834:
        LD    A,155
L1835:
        CALL  writeLineA
L1836:
        JP    L1840
L1837:
        LD    HL,999
L1838:
        CALL  writeLineHL
L1839:
        ;;test15.j(264)   if (w2 ^ 0x1C == 0x1228) println (156); else println (999);
L1840:
        LD    HL,(05004H)
L1841:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1842:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1843:
        JP    NZ,L1847
L1844:
        LD    A,156
L1845:
        CALL  writeLineA
L1846:
        JP    L1854
L1847:
        LD    HL,999
L1848:
        CALL  writeLineHL
L1849:
        ;;test15.j(265) 
L1850:
        ;;test15.j(266)   //final var/acc
L1851:
        ;;test15.j(267)   //*************
L1852:
        ;;test15.j(268)   //final var byte/acc byte
L1853:
        ;;test15.j(269)   if (b2 & (0x10 + 0x0C) == 0x04) println (157); else println (999);
L1854:
        LD    A,(05001H)
L1855:
        PUSH  AF
        LD    A,16
L1856:
        ADD   A,12
L1857:
        POP   BC
        AND   A,B
L1858:
        SUB   A,4
L1859:
        JP    NZ,L1863
L1860:
        LD    A,157
L1861:
        CALL  writeLineA
L1862:
        JP    L1866
L1863:
        LD    HL,999
L1864:
        CALL  writeLineHL
L1865:
        ;;test15.j(270)   if (b2 | (0x10 + 0x0C) == 0x1F) println (158); else println (999);
L1866:
        LD    A,(05001H)
L1867:
        PUSH  AF
        LD    A,16
L1868:
        ADD   A,12
L1869:
        POP   BC
        OR    A,B
L1870:
        SUB   A,31
L1871:
        JP    NZ,L1875
L1872:
        LD    A,158
L1873:
        CALL  writeLineA
L1874:
        JP    L1878
L1875:
        LD    HL,999
L1876:
        CALL  writeLineHL
L1877:
        ;;test15.j(271)   if (b2 ^ (0x10 + 0x0C) == 0x1B) println (159); else println (999);
L1878:
        LD    A,(05001H)
L1879:
        PUSH  AF
        LD    A,16
L1880:
        ADD   A,12
L1881:
        POP   BC
        XOR   A,B
L1882:
        SUB   A,27
L1883:
        JP    NZ,L1887
L1884:
        LD    A,159
L1885:
        CALL  writeLineA
L1886:
        JP    L1891
L1887:
        LD    HL,999
L1888:
        CALL  writeLineHL
L1889:
        ;;test15.j(272)   //final var word/acc word
L1890:
        ;;test15.j(273)   if (w2 & 0x0100 + 0x022C == 0x0224) println (160); else println (999);
L1891:
        LD    HL,(05004H)
L1892:
        PUSH  HL
        LD    HL,256
L1893:
        LD    DE,556
        ADD   HL,DE
L1894:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1895:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1896:
        JP    NZ,L1900
L1897:
        LD    A,160
L1898:
        CALL  writeLineA
L1899:
        JP    L1903
L1900:
        LD    HL,999
L1901:
        CALL  writeLineHL
L1902:
        ;;test15.j(274)   if (w2 | 0x0100 + 0x022C == 0x133C) println (161); else println (999);
L1903:
        LD    HL,(05004H)
L1904:
        PUSH  HL
        LD    HL,256
L1905:
        LD    DE,556
        ADD   HL,DE
L1906:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L1907:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1908:
        JP    NZ,L1912
L1909:
        LD    A,161
L1910:
        CALL  writeLineA
L1911:
        JP    L1915
L1912:
        LD    HL,999
L1913:
        CALL  writeLineHL
L1914:
        ;;test15.j(275)   if (w2 ^ 0x0100 + 0x022C == 0x1118) println (162); else println (999);
L1915:
        LD    HL,(05004H)
L1916:
        PUSH  HL
        LD    HL,256
L1917:
        LD    DE,556
        ADD   HL,DE
L1918:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1919:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1920:
        JP    NZ,L1924
L1921:
        LD    A,162
L1922:
        CALL  writeLineA
L1923:
        JP    L1928
L1924:
        LD    HL,999
L1925:
        CALL  writeLineHL
L1926:
        ;;test15.j(276)   //final var byt/acc word
L1927:
        ;;test15.j(277)   if (b1 & 0x1000 + 0x0234 == 0x0014) println (163); else println (999);
L1928:
        LD    A,(05000H)
L1929:
        LD    HL,4096
L1930:
        LD    DE,564
        ADD   HL,DE
L1931:
        AND   A,L
        LD    L,A
        LD    H,0
L1932:
        LD    A,20
L1933:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1934:
        JP    NZ,L1938
L1935:
        LD    A,163
L1936:
        CALL  writeLineA
L1937:
        JP    L1941
L1938:
        LD    HL,999
L1939:
        CALL  writeLineHL
L1940:
        ;;test15.j(278)   if (b1 | 0x1000 + 0x0234 == 0x123C) println (164); else println (999);
L1941:
        LD    A,(05000H)
L1942:
        LD    HL,4096
L1943:
        LD    DE,564
        ADD   HL,DE
L1944:
        OR    A,L
        LD    L,A
L1945:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1946:
        JP    NZ,L1950
L1947:
        LD    A,164
L1948:
        CALL  writeLineA
L1949:
        JP    L1953
L1950:
        LD    HL,999
L1951:
        CALL  writeLineHL
L1952:
        ;;test15.j(279)   if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (165); else println (999);
L1953:
        LD    A,(05000H)
L1954:
        LD    HL,4096
L1955:
        LD    DE,564
        ADD   HL,DE
L1956:
        XOR   A,L
        LD    L,A
L1957:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1958:
        JP    NZ,L1962
L1959:
        LD    A,165
L1960:
        CALL  writeLineA
L1961:
        JP    L1966
L1962:
        LD    HL,999
L1963:
        CALL  writeLineHL
L1964:
        ;;test15.j(280)   //final var word/acc byt
L1965:
        ;;test15.j(281)   if (w2 & 0x10 + 0x0C == 0x0014) println (166); else println (999);
L1966:
        LD    HL,(05004H)
L1967:
        LD    A,16
L1968:
        ADD   A,12
L1969:
        AND   A,L
        LD    L,A
        LD    H,0
L1970:
        LD    A,20
L1971:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1972:
        JP    NZ,L1976
L1973:
        LD    A,166
L1974:
        CALL  writeLineA
L1975:
        JP    L1979
L1976:
        LD    HL,999
L1977:
        CALL  writeLineHL
L1978:
        ;;test15.j(282)   if (w2 | 0x10 + 0x0C == 0x123C) println (167); else println (999);
L1979:
        LD    HL,(05004H)
L1980:
        LD    A,16
L1981:
        ADD   A,12
L1982:
        OR    A,L
        LD    L,A
L1983:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1984:
        JP    NZ,L1988
L1985:
        LD    A,167
L1986:
        CALL  writeLineA
L1987:
        JP    L1991
L1988:
        LD    HL,999
L1989:
        CALL  writeLineHL
L1990:
        ;;test15.j(283)   if (w2 ^ 0x10 + 0x0C == 0x1228) println (168); else println (999);
L1991:
        LD    HL,(05004H)
L1992:
        LD    A,16
L1993:
        ADD   A,12
L1994:
        XOR   A,L
        LD    L,A
L1995:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1996:
        JP    NZ,L2000
L1997:
        LD    A,168
L1998:
        CALL  writeLineA
L1999:
        JP    L2007
L2000:
        LD    HL,999
L2001:
        CALL  writeLineHL
L2002:
        ;;test15.j(284) 
L2003:
        ;;test15.j(285)   //final var/var
L2004:
        ;;test15.j(286)   //*************
L2005:
        ;;test15.j(287)   //final var byte/var byte
L2006:
        ;;test15.j(288)   if (b2 & b1 == 0x04) println (169); else println (999);
L2007:
        LD    A,(05001H)
L2008:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L2009:
        SUB   A,4
L2010:
        JP    NZ,L2014
L2011:
        LD    A,169
L2012:
        CALL  writeLineA
L2013:
        JP    L2017
L2014:
        LD    HL,999
L2015:
        CALL  writeLineHL
L2016:
        ;;test15.j(289)   if (b2 | b1 == 0x1F) println (170); else println (999);
L2017:
        LD    A,(05001H)
L2018:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L2019:
        SUB   A,31
L2020:
        JP    NZ,L2024
L2021:
        LD    A,170
L2022:
        CALL  writeLineA
L2023:
        JP    L2027
L2024:
        LD    HL,999
L2025:
        CALL  writeLineHL
L2026:
        ;;test15.j(290)   if (b2 ^ b1 == 0x1B) println (171); else println (999);
L2027:
        LD    A,(05001H)
L2028:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L2029:
        SUB   A,27
L2030:
        JP    NZ,L2034
L2031:
        LD    A,171
L2032:
        CALL  writeLineA
L2033:
        JP    L2038
L2034:
        LD    HL,999
L2035:
        CALL  writeLineHL
L2036:
        ;;test15.j(291)   //final var word/var word
L2037:
        ;;test15.j(292)   if (w2 & w1 == 0x0224) println (172); else println (999);
L2038:
        LD    HL,(05004H)
L2039:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2040:
        LD    DE,548
        OR    A
        SBC   HL,DE
L2041:
        JP    NZ,L2045
L2042:
        LD    A,172
L2043:
        CALL  writeLineA
L2044:
        JP    L2048
L2045:
        LD    HL,999
L2046:
        CALL  writeLineHL
L2047:
        ;;test15.j(293)   if (w2 | w1 == 0x133C) println (173); else println (999);
L2048:
        LD    HL,(05004H)
L2049:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L2050:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L2051:
        JP    NZ,L2055
L2052:
        LD    A,173
L2053:
        CALL  writeLineA
L2054:
        JP    L2058
L2055:
        LD    HL,999
L2056:
        CALL  writeLineHL
L2057:
        ;;test15.j(294)   if (w2 ^ w1 == 0x1118) println (174); else println (999);
L2058:
        LD    HL,(05004H)
L2059:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2060:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L2061:
        JP    NZ,L2065
L2062:
        LD    A,174
L2063:
        CALL  writeLineA
L2064:
        JP    L2069
L2065:
        LD    HL,999
L2066:
        CALL  writeLineHL
L2067:
        ;;test15.j(295)   //final var byt/var word
L2068:
        ;;test15.j(296)   if (b1 & w2 == 0x0014) println (175); else println (999);
L2069:
        LD    A,(05000H)
L2070:
        LD    L,A
        LD    H,0
L2071:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2072:
        LD    A,20
L2073:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2074:
        JP    NZ,L2078
L2075:
        LD    A,175
L2076:
        CALL  writeLineA
L2077:
        JP    L2081
L2078:
        LD    HL,999
L2079:
        CALL  writeLineHL
L2080:
        ;;test15.j(297)   if (b1 | w2 == 0x123C) println (176); else println (999);
L2081:
        LD    A,(05000H)
L2082:
        LD    L,A
        LD    H,0
L2083:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L2084:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2085:
        JP    NZ,L2089
L2086:
        LD    A,176
L2087:
        CALL  writeLineA
L2088:
        JP    L2092
L2089:
        LD    HL,999
L2090:
        CALL  writeLineHL
L2091:
        ;;test15.j(298)   if (b1 ^ w2 == 0x1228) println (177); else println (999);
L2092:
        LD    A,(05000H)
L2093:
        LD    L,A
        LD    H,0
L2094:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2095:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2096:
        JP    NZ,L2100
L2097:
        LD    A,177
L2098:
        CALL  writeLineA
L2099:
        JP    L2104
L2100:
        LD    HL,999
L2101:
        CALL  writeLineHL
L2102:
        ;;test15.j(299)   //final var word/var byt
L2103:
        ;;test15.j(300)   if (w2 & b1 == 0x0014) println (178); else println (999);
L2104:
        LD    HL,(05004H)
L2105:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2106:
        LD    A,20
L2107:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2108:
        JP    NZ,L2112
L2109:
        LD    A,178
L2110:
        CALL  writeLineA
L2111:
        JP    L2115
L2112:
        LD    HL,999
L2113:
        CALL  writeLineHL
L2114:
        ;;test15.j(301)   if (w2 | b1 == 0x123C) println (179); else println (999);
L2115:
        LD    HL,(05004H)
L2116:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L2117:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2118:
        JP    NZ,L2122
L2119:
        LD    A,179
L2120:
        CALL  writeLineA
L2121:
        JP    L2125
L2122:
        LD    HL,999
L2123:
        CALL  writeLineHL
L2124:
        ;;test15.j(302)   if (w2 ^ b1 == 0x1228) println (180); else println (999);
L2125:
        LD    HL,(05004H)
L2126:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2127:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2128:
        JP    NZ,L2132
L2129:
        LD    A,180
L2130:
        CALL  writeLineA
L2131:
        JP    L2139
L2132:
        LD    HL,999
L2133:
        CALL  writeLineHL
L2134:
        ;;test15.j(303) 
L2135:
        ;;test15.j(304)   //final var/final var
L2136:
        ;;test15.j(305)   //*******************
L2137:
        ;;test15.j(306)   //final var byte/final var byte
L2138:
        ;;test15.j(307)   if (fb2 & fb1 == 0x04) println (181); else println (999);
L2139:
        LD    A,7
L2140:
        AND   A,28
L2141:
        SUB   A,4
L2142:
        JP    NZ,L2146
L2143:
        LD    A,181
L2144:
        CALL  writeLineA
L2145:
        JP    L2149
L2146:
        LD    HL,999
L2147:
        CALL  writeLineHL
L2148:
        ;;test15.j(308)   if (fb2 | fb1 == 0x1F) println (182); else println (999);
L2149:
        LD    A,7
L2150:
        OR    A,28
L2151:
        SUB   A,31
L2152:
        JP    NZ,L2156
L2153:
        LD    A,182
L2154:
        CALL  writeLineA
L2155:
        JP    L2159
L2156:
        LD    HL,999
L2157:
        CALL  writeLineHL
L2158:
        ;;test15.j(309)   if (fb2 ^ fb1 == 0x1B) println (183); else println (999);
L2159:
        LD    A,7
L2160:
        XOR   A,28
L2161:
        SUB   A,27
L2162:
        JP    NZ,L2166
L2163:
        LD    A,183
L2164:
        CALL  writeLineA
L2165:
        JP    L2170
L2166:
        LD    HL,999
L2167:
        CALL  writeLineHL
L2168:
        ;;test15.j(310)   //final var word/final var word
L2169:
        ;;test15.j(311)   if (fw2 & fw1 == 0x0224) println (184); else println (999);
L2170:
        LD    HL,4660
L2171:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2172:
        LD    DE,548
        OR    A
        SBC   HL,DE
L2173:
        JP    NZ,L2177
L2174:
        LD    A,184
L2175:
        CALL  writeLineA
L2176:
        JP    L2180
L2177:
        LD    HL,999
L2178:
        CALL  writeLineHL
L2179:
        ;;test15.j(312)   if (fw2 | fw1 == 0x133C) println (185); else println (999);
L2180:
        LD    HL,4660
L2181:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L2182:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L2183:
        JP    NZ,L2187
L2184:
        LD    A,185
L2185:
        CALL  writeLineA
L2186:
        JP    L2190
L2187:
        LD    HL,999
L2188:
        CALL  writeLineHL
L2189:
        ;;test15.j(313)   if (fw2 ^ fw1 == 0x1118) println (186); else println (999);
L2190:
        LD    HL,4660
L2191:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2192:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L2193:
        JP    NZ,L2197
L2194:
        LD    A,186
L2195:
        CALL  writeLineA
L2196:
        JP    L2201
L2197:
        LD    HL,999
L2198:
        CALL  writeLineHL
L2199:
        ;;test15.j(314)   //final var byt/final var word
L2200:
        ;;test15.j(315)   if (fb1 & fw2 == 0x0014) println (187); else println (999);
L2201:
        LD    A,28
L2202:
        LD    L,A
        LD    H,0
L2203:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2204:
        LD    A,20
L2205:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2206:
        JP    NZ,L2210
L2207:
        LD    A,187
L2208:
        CALL  writeLineA
L2209:
        JP    L2213
L2210:
        LD    HL,999
L2211:
        CALL  writeLineHL
L2212:
        ;;test15.j(316)   if (fb1 | fw2 == 0x123C) println (188); else println (999);
L2213:
        LD    A,28
L2214:
        LD    L,A
        LD    H,0
L2215:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L2216:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2217:
        JP    NZ,L2221
L2218:
        LD    A,188
L2219:
        CALL  writeLineA
L2220:
        JP    L2224
L2221:
        LD    HL,999
L2222:
        CALL  writeLineHL
L2223:
        ;;test15.j(317)   if (fb1 ^ fw2 == 0x1228) println (189); else println (999);
L2224:
        LD    A,28
L2225:
        LD    L,A
        LD    H,0
L2226:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2227:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2228:
        JP    NZ,L2232
L2229:
        LD    A,189
L2230:
        CALL  writeLineA
L2231:
        JP    L2236
L2232:
        LD    HL,999
L2233:
        CALL  writeLineHL
L2234:
        ;;test15.j(318)   //final var word/final var byt
L2235:
        ;;test15.j(319)   if (fw2 & fb1 == 0x0014) println (190); else println (999);
L2236:
        LD    HL,4660
L2237:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2238:
        LD    A,20
L2239:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2240:
        JP    NZ,L2244
L2241:
        LD    A,190
L2242:
        CALL  writeLineA
L2243:
        JP    L2247
L2244:
        LD    HL,999
L2245:
        CALL  writeLineHL
L2246:
        ;;test15.j(320)   if (fw2 | fb1 == 0x123C) println (191); else println (999);
L2247:
        LD    HL,4660
L2248:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
        POP   BC
L2249:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2250:
        JP    NZ,L2254
L2251:
        LD    A,191
L2252:
        CALL  writeLineA
L2253:
        JP    L2257
L2254:
        LD    HL,999
L2255:
        CALL  writeLineHL
L2256:
        ;;test15.j(321)   if (fw2 ^ fb1 == 0x1228) println (192); else println (999);
L2257:
        LD    HL,4660
L2258:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2259:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2260:
        JP    NZ,L2264
L2261:
        LD    A,192
L2262:
        CALL  writeLineA
L2263:
        JP    L2268
L2264:
        LD    HL,999
L2265:
        CALL  writeLineHL
L2266:
        ;;test15.j(322) 
L2267:
        ;;test15.j(323)   println("Klaar");
L2268:
        LD    HL,2272
L2269:
        CALL  writeLineStr
L2270:
        ;;test15.j(324) }
L2271:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L2272:
        .ASCIZ  "Klaar"
