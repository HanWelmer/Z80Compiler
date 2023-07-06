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
        ;;test6.j(5)   println(0);         // 0
L6:
        LD    A,0
L7:
        CALL  writeLineA
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
        ;;test6.j(15)   println(b);         // 1
L22:
        LD    A,(05000H)
L23:
        CALL  writeLineA
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
        ;;test6.j(25)   println(0 + 2);     // 2
L34:
        LD    A,0
L35:
        ADD   A,2
L36:
        CALL  writeLineA
L37:
        ;;test6.j(26)   println(b + 2);     // 3
L38:
        LD    A,(05000H)
L39:
        ADD   A,2
L40:
        CALL  writeLineA
L41:
        ;;test6.j(27)   println(3 + b);     // 4
L42:
        LD    A,3
L43:
        LD    B,A
        LD    A,(05000H)
        ADD   A,B
L44:
        CALL  writeLineA
L45:
        ;;test6.j(28)   println(b + c);     // 5
L46:
        LD    A,(05000H)
L47:
        LD    B,A
        LD    A,(05001H)
        ADD   A,B
L48:
        CALL  writeLineA
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
        ;;test6.j(31)   println(c);         // 6
L55:
        LD    A,(05001H)
L56:
        CALL  writeLineA
L57:
        ;;test6.j(32)   c = b + 6;
L58:
        LD    A,(05000H)
L59:
        ADD   A,6
L60:
        LD    (05001H),A
L61:
        ;;test6.j(33)   println(c);         // 7
L62:
        LD    A,(05001H)
L63:
        CALL  writeLineA
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
        ;;test6.j(35)   println(c);         // 8
L69:
        LD    A,(05001H)
L70:
        CALL  writeLineA
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
        ;;test6.j(37)   println(c);         // 9
L76:
        LD    A,(05001H)
L77:
        CALL  writeLineA
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
        ;;test6.j(41)   println(i);         // 10
L84:
        LD    HL,(05002H)
L85:
        CALL  writeLineHL
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
        ;;test6.j(48)   println(i + 1);     // 11
L93:
        LD    HL,(05002H)
L94:
        LD    DE,1
        ADD   HL,DE
L95:
        CALL  writeLineHL
L96:
        ;;test6.j(49)   println(2 + i);     // 12
L97:
        LD    A,2
L98:
        LD    L,A
        LD    H,0
L99:
        LD    DE,(05002H)
        ADD   HL,DE
L100:
        CALL  writeLineHL
L101:
        ;;test6.j(50)   b = 3;
L102:
        LD    A,3
L103:
        LD    (05000H),A
L104:
        ;;test6.j(51)   println(i + b);     // 13
L105:
        LD    HL,(05002H)
L106:
        LD    DE,(05000H)
        ADD   HL,DE
L107:
        CALL  writeLineHL
L108:
        ;;test6.j(52)   b++; //4
L109:
        LD    HL,(05000H)
        INC   (HL)
L110:
        ;;test6.j(53)   println(b + i);     // 14
L111:
        LD    A,(05000H)
L112:
        LD    L,A
        LD    H,0
L113:
        LD    DE,(05002H)
        ADD   HL,DE
L114:
        CALL  writeLineHL
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
        ;;test6.j(56)   println(j);
L121:
        LD    HL,(05004H)
L122:
        CALL  writeLineHL
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
        ;;test6.j(58)   println(j);
L129:
        LD    HL,(05004H)
L130:
        CALL  writeLineHL
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
        ;;test6.j(61)   println(j);
L139:
        LD    HL,(05004H)
L140:
        CALL  writeLineHL
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
        ;;test6.j(68)   println(19 - 1);    // 18
L152:
        LD    A,19
L153:
        SUB   A,1
L154:
        CALL  writeLineA
L155:
        ;;test6.j(69)   println(b - 14);    // 19
L156:
        LD    A,(05000H)
L157:
        SUB   A,14
L158:
        CALL  writeLineA
L159:
        ;;test6.j(70)   println(53 - b);    // 20
L160:
        LD    A,53
L161:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L162:
        CALL  writeLineA
L163:
        ;;test6.j(71)   println(b - c);     // 21
L164:
        LD    A,(05000H)
L165:
        LD    B,A
        LD    A,(05001H)
        SUB   A,B
L166:
        CALL  writeLineA
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
        ;;test6.j(74)   println(c);         // 22
L173:
        LD    A,(05001H)
L174:
        CALL  writeLineA
L175:
        ;;test6.j(75)   c = b - 10;
L176:
        LD    A,(05000H)
L177:
        SUB   A,10
L178:
        LD    (05001H),A
L179:
        ;;test6.j(76)   println(c);         // 23
L180:
        LD    A,(05001H)
L181:
        CALL  writeLineA
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
        ;;test6.j(78)   println(c);         // 24
L187:
        LD    A,(05001H)
L188:
        CALL  writeLineA
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
        ;;test6.j(81)   println(c);         // 25
L197:
        LD    A,(05001H)
L198:
        CALL  writeLineA
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
        ;;test6.j(84)   println(i - 14);    // 26
L204:
        LD    HL,(05002H)
L205:
        LD    DE,14
        OR    A
        SBC   HL,DE
L206:
        CALL  writeLineHL
L207:
        ;;test6.j(85)   println(67 - i);    // 27
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
        CALL  writeLineHL
L212:
        ;;test6.j(86)   b = 12;
L213:
        LD    A,12
L214:
        LD    (05000H),A
L215:
        ;;test6.j(87)   println(i - b);     // 28
L216:
        LD    HL,(05002H)
L217:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L218:
        CALL  writeLineHL
L219:
        ;;test6.j(88)   b = 69;
L220:
        LD    A,69
L221:
        LD    (05000H),A
L222:
        ;;test6.j(89)   println(b - i);     // 29
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
        CALL  writeLineHL
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
        ;;test6.j(92)   println(j);         // 30
L233:
        LD    HL,(05004H)
L234:
        CALL  writeLineHL
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
        ;;test6.j(94)   println(j);         // 31
L241:
        LD    HL,(05004H)
L242:
        CALL  writeLineHL
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
        ;;test6.j(97)   println(j);         // 32
L251:
        LD    HL,(05004H)
L252:
        CALL  writeLineHL
L253:
        ;;test6.j(98)   
L254:
        ;;test6.j(99)   /****************************/
L255:
        ;;test6.j(100)   /* Dual term multiplication */
L256:
        ;;test6.j(101)   /****************************/
L257:
        ;;test6.j(102)   println(3 * 11);    // 33
L258:
        LD    A,3
L259:
        LD    B,A
        LD    C,11
        MLT   BC
        LD    A,C
L260:
        CALL  writeLineA
L261:
        ;;test6.j(103)   b = 17;
L262:
        LD    A,17
L263:
        LD    (05000H),A
L264:
        ;;test6.j(104)   println(b * 2);     // 34
L265:
        LD    A,(05000H)
L266:
        LD    B,A
        LD    C,2
        MLT   BC
        LD    A,C
L267:
        CALL  writeLineA
L268:
        ;;test6.j(105)   b = 7;
L269:
        LD    A,7
L270:
        LD    (05000H),A
L271:
        ;;test6.j(106)   println(5 * b);     // 35
L272:
        LD    A,5
L273:
        LD    B,A
        LD    A,(05000H)
        LD    C,A
        MLT   BC
        LD    A,C
L274:
        CALL  writeLineA
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
        ;;test6.j(109)   println(b * c);     // 36
L282:
        LD    A,(05000H)
L283:
        LD    B,A
        LD    A,(05001H)
        LD    C,A
        MLT   BC
        LD    A,C
L284:
        CALL  writeLineA
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
        ;;test6.j(112)   println(c);         // 37
L291:
        LD    A,(05001H)
L292:
        CALL  writeLineA
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
        ;;test6.j(115)   println(c);         // 38
L301:
        LD    A,(05001H)
L302:
        CALL  writeLineA
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
        ;;test6.j(118)   println(c);         // 39
L311:
        LD    A,(05001H)
L312:
        CALL  writeLineA
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
        ;;test6.j(122)   println(c);         // 40
L324:
        LD    A,(05001H)
L325:
        CALL  writeLineA
L326:
        ;;test6.j(123) 
L327:
        ;;test6.j(124)   /**********************/
L328:
        ;;test6.j(125)   /* Dual term division */
L329:
        ;;test6.j(126)   /**********************/
L330:
        ;;test6.j(127)   println(123 / 3);   // 41
L331:
        LD    A,123
L332:
        LD    C,3
        CALL  div8
L333:
        CALL  writeLineA
L334:
        ;;test6.j(128)   b = 126;
L335:
        LD    A,126
L336:
        LD    (05000H),A
L337:
        ;;test6.j(129)   println(b / 3);     // 42
L338:
        LD    A,(05000H)
L339:
        LD    C,3
        CALL  div8
L340:
        CALL  writeLineA
L341:
        ;;test6.j(130)   b = 3;
L342:
        LD    A,3
L343:
        LD    (05000H),A
L344:
        ;;test6.j(131)   println(129 / b);   // 43
L345:
        LD    A,129
L346:
        LD    B,A
        LD    A,(05000H)
        LD    C,A
        LD    A,B
        CALL  div8
L347:
        CALL  writeLineA
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
        ;;test6.j(134)   println(b / c);     // 44
L355:
        LD    A,(05000H)
L356:
        LD    B,A
        LD    A,(05001H)
        LD    C,A
        LD    A,B
        CALL  div8
L357:
        CALL  writeLineA
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
        ;;test6.j(137)   println(c);         // 45
L364:
        LD    A,(05001H)
L365:
        CALL  writeLineA
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
        ;;test6.j(140)   println(c);         // 46
L374:
        LD    A,(05001H)
L375:
        CALL  writeLineA
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
        ;;test6.j(143)   println(c);         // 47
L384:
        LD    A,(05001H)
L385:
        CALL  writeLineA
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
        ;;test6.j(147)   println(c);         // 48
L397:
        LD    A,(05001H)
L398:
        CALL  writeLineA
L399:
        ;;test6.j(148) 
L400:
        ;;test6.j(149)   /*************************/
L401:
        ;;test6.j(150)   /* possible loss of data */
L402:
        ;;test6.j(151)   /*************************/
L403:
        ;;test6.j(152)   println("Nu komen 251 en 252");
L404:
        LD    HL,891
L405:
        CALL  writeLineStr
L406:
        ;;test6.j(153)   b = 507;
L407:
        LD    HL,507
L408:
        LD    A,L
        LD    (05000H),A
L409:
        ;;test6.j(154)   println(b);         // 251
L410:
        LD    A,(05000H)
L411:
        CALL  writeLineA
L412:
        ;;test6.j(155)   i = 508;
L413:
        LD    HL,508
L414:
        LD    (05002H),HL
L415:
        ;;test6.j(156)   b = i;
L416:
        LD    HL,(05002H)
L417:
        LD    A,L
        LD    (05000H),A
L418:
        ;;test6.j(157)   println(b);         // 252
L419:
        LD    A,(05000H)
L420:
        CALL  writeLineA
L421:
        ;;test6.j(158) 
L422:
        ;;test6.j(159)   println("Nu komen -253 en -254");
L423:
        LD    HL,892
L424:
        CALL  writeLineStr
L425:
        ;;test6.j(160)   b = b - 505;
L426:
        LD    A,(05000H)
L427:
        LD    L,A
        LD    H,0
L428:
        LD    DE,505
        OR    A
        SBC   HL,DE
L429:
        LD    A,L
        LD    (05000H),A
L430:
        ;;test6.j(161)   println(b);         // 252 - 505 = -253
L431:
        LD    A,(05000H)
L432:
        CALL  writeLineA
L433:
        ;;test6.j(162)   i = i + 5;
L434:
        LD    HL,(05002H)
L435:
        LD    DE,5
        ADD   HL,DE
L436:
        LD    (05002H),HL
L437:
        ;;test6.j(163)   b = b - i;
L438:
        LD    A,(05000H)
L439:
        LD    L,A
        LD    H,0
L440:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L441:
        LD    A,L
        LD    (05000H),A
L442:
        ;;test6.j(164)   println(b);         // -233 - 11 = -254
L443:
        LD    A,(05000H)
L444:
        CALL  writeLineA
L445:
        ;;test6.j(165)   
L446:
        ;;test6.j(166)   println("Nu komen 255 en 256");
L447:
        LD    HL,893
L448:
        CALL  writeLineStr
L449:
        ;;test6.j(167)   b = 255;
L450:
        LD    A,255
L451:
        LD    (05000H),A
L452:
        ;;test6.j(168)   println(b);         // 255
L453:
        LD    A,(05000H)
L454:
        CALL  writeLineA
L455:
        ;;test6.j(169)   //LD    A,255
L456:
        ;;test6.j(170)   //LD    (04001H),A
L457:
        ;;test6.j(171)   //LD    A,(04001H)
L458:
        ;;test6.j(172)   //CALL  writeA
L459:
        ;;test6.j(173)   //OK
L460:
        ;;test6.j(174) 
L461:
        ;;test6.j(175)   /**********************/
L462:
        ;;test6.j(176)   /* Single term 16-bit */
L463:
        ;;test6.j(177)   /**********************/
L464:
        ;;test6.j(178)   i = 256;
L465:
        LD    HL,256
L466:
        LD    (05002H),HL
L467:
        ;;test6.j(179)   println(i);         // 256
L468:
        LD    HL,(05002H)
L469:
        CALL  writeLineHL
L470:
        ;;test6.j(180)   //LD    HL,256
L471:
        ;;test6.j(181)   //LD    (04006H),HL
L472:
        ;;test6.j(182)   //LD    HL,(04006H)
L473:
        ;;test6.j(183)   //CALL  writeHL
L474:
        ;;test6.j(184)   //OK
L475:
        ;;test6.j(185) 
L476:
        ;;test6.j(186)   println("Nu komen 1000..1047");
L477:
        LD    HL,894
L478:
        CALL  writeLineStr
L479:
        ;;test6.j(187)   println(1000);      // 1000
L480:
        LD    HL,1000
L481:
        CALL  writeLineHL
L482:
        ;;test6.j(188)   j = 1001;
L483:
        LD    HL,1001
L484:
        LD    (05004H),HL
L485:
        ;;test6.j(189)   println(j);         // 1001
L486:
        LD    HL,(05004H)
L487:
        CALL  writeLineHL
L488:
        ;;test6.j(190) 
L489:
        ;;test6.j(191)   /************************/
L490:
        ;;test6.j(192)   /* Dual term addition   */
L491:
        ;;test6.j(193)   /************************/
L492:
        ;;test6.j(194)   println(1000 + 2);  // 1002
L493:
        LD    HL,1000
L494:
        LD    DE,2
        ADD   HL,DE
L495:
        CALL  writeLineHL
L496:
        ;;test6.j(195)   println(3 + 1000);  // 1003
L497:
        LD    A,3
L498:
        LD    L,A
        LD    H,0
L499:
        LD    DE,1000
        ADD   HL,DE
L500:
        CALL  writeLineHL
L501:
        ;;test6.j(196)   println(500 + 504); // 1004
L502:
        LD    HL,500
L503:
        LD    DE,504
        ADD   HL,DE
L504:
        CALL  writeLineHL
L505:
        ;;test6.j(197)   i = 1000 + 5;
L506:
        LD    HL,1000
L507:
        LD    DE,5
        ADD   HL,DE
L508:
        LD    (05002H),HL
L509:
        ;;test6.j(198)   println(i);         // 1005
L510:
        LD    HL,(05002H)
L511:
        CALL  writeLineHL
L512:
        ;;test6.j(199)   i = 6 + 1000;
L513:
        LD    A,6
L514:
        LD    L,A
        LD    H,0
L515:
        LD    DE,1000
        ADD   HL,DE
L516:
        LD    (05002H),HL
L517:
        ;;test6.j(200)   println(i);         // 1006
L518:
        LD    HL,(05002H)
L519:
        CALL  writeLineHL
L520:
        ;;test6.j(201)   i = 500 + 507;
L521:
        LD    HL,500
L522:
        LD    DE,507
        ADD   HL,DE
L523:
        LD    (05002H),HL
L524:
        ;;test6.j(202)   println(i);         // 1007
L525:
        LD    HL,(05002H)
L526:
        CALL  writeLineHL
L527:
        ;;test6.j(203)   
L528:
        ;;test6.j(204)   j = 1000;
L529:
        LD    HL,1000
L530:
        LD    (05004H),HL
L531:
        ;;test6.j(205)   b = 10;
L532:
        LD    A,10
L533:
        LD    (05000H),A
L534:
        ;;test6.j(206)   i = 514;
L535:
        LD    HL,514
L536:
        LD    (05002H),HL
L537:
        ;;test6.j(207)   println(j + 8);     // 1008
L538:
        LD    HL,(05004H)
L539:
        LD    DE,8
        ADD   HL,DE
L540:
        CALL  writeLineHL
L541:
        ;;test6.j(208)   println(9 + j);     // 1009
L542:
        LD    A,9
L543:
        LD    L,A
        LD    H,0
L544:
        LD    DE,(05004H)
        ADD   HL,DE
L545:
        CALL  writeLineHL
L546:
        ;;test6.j(209)   println(j + b);     // 1010
L547:
        LD    HL,(05004H)
L548:
        LD    DE,(05000H)
        ADD   HL,DE
L549:
        CALL  writeLineHL
L550:
        ;;test6.j(210)   b++;
L551:
        LD    HL,(05000H)
        INC   (HL)
L552:
        ;;test6.j(211)   println(b + j);     // 1011
L553:
        LD    A,(05000H)
L554:
        LD    L,A
        LD    H,0
L555:
        LD    DE,(05004H)
        ADD   HL,DE
L556:
        CALL  writeLineHL
L557:
        ;;test6.j(212)   j = 500;
L558:
        LD    HL,500
L559:
        LD    (05004H),HL
L560:
        ;;test6.j(213)   println(j + 512);   // 1012
L561:
        LD    HL,(05004H)
L562:
        LD    DE,512
        ADD   HL,DE
L563:
        CALL  writeLineHL
L564:
        ;;test6.j(214)   println(513 + j);   // 1013
L565:
        LD    HL,513
L566:
        LD    DE,(05004H)
        ADD   HL,DE
L567:
        CALL  writeLineHL
L568:
        ;;test6.j(215)   println(i + j);     // 1014
L569:
        LD    HL,(05002H)
L570:
        LD    DE,(05004H)
        ADD   HL,DE
L571:
        CALL  writeLineHL
L572:
        ;;test6.j(216)   
L573:
        ;;test6.j(217)   j = 1000;
L574:
        LD    HL,1000
L575:
        LD    (05004H),HL
L576:
        ;;test6.j(218)   b = 17;
L577:
        LD    A,17
L578:
        LD    (05000H),A
L579:
        ;;test6.j(219)   i = j + 15;
L580:
        LD    HL,(05004H)
L581:
        LD    DE,15
        ADD   HL,DE
L582:
        LD    (05002H),HL
L583:
        ;;test6.j(220)   println(i);         // 1015
L584:
        LD    HL,(05002H)
L585:
        CALL  writeLineHL
L586:
        ;;test6.j(221)   i = 16 + j;
L587:
        LD    A,16
L588:
        LD    L,A
        LD    H,0
L589:
        LD    DE,(05004H)
        ADD   HL,DE
L590:
        LD    (05002H),HL
L591:
        ;;test6.j(222)   println(i);         // 1016
L592:
        LD    HL,(05002H)
L593:
        CALL  writeLineHL
L594:
        ;;test6.j(223)   i = j + b;
L595:
        LD    HL,(05004H)
L596:
        LD    DE,(05000H)
        ADD   HL,DE
L597:
        LD    (05002H),HL
L598:
        ;;test6.j(224)   println(i);         // 1017
L599:
        LD    HL,(05002H)
L600:
        CALL  writeLineHL
L601:
        ;;test6.j(225)   b++;
L602:
        LD    HL,(05000H)
        INC   (HL)
L603:
        ;;test6.j(226)   i = b + j;
L604:
        LD    A,(05000H)
L605:
        LD    L,A
        LD    H,0
L606:
        LD    DE,(05004H)
        ADD   HL,DE
L607:
        LD    (05002H),HL
L608:
        ;;test6.j(227)   println(i);         // 1018
L609:
        LD    HL,(05002H)
L610:
        CALL  writeLineHL
L611:
        ;;test6.j(228)   j = 500;
L612:
        LD    HL,500
L613:
        LD    (05004H),HL
L614:
        ;;test6.j(229)   i = j + 519;
L615:
        LD    HL,(05004H)
L616:
        LD    DE,519
        ADD   HL,DE
L617:
        LD    (05002H),HL
L618:
        ;;test6.j(230)   println(i);         // 1019
L619:
        LD    HL,(05002H)
L620:
        CALL  writeLineHL
L621:
        ;;test6.j(231)   i = 520 + j;
L622:
        LD    HL,520
L623:
        LD    DE,(05004H)
        ADD   HL,DE
L624:
        LD    (05002H),HL
L625:
        ;;test6.j(232)   println(i);         // 1020
L626:
        LD    HL,(05002H)
L627:
        CALL  writeLineHL
L628:
        ;;test6.j(233)   i = 521;
L629:
        LD    HL,521
L630:
        LD    (05002H),HL
L631:
        ;;test6.j(234)   i = i + j;
L632:
        LD    HL,(05002H)
L633:
        LD    DE,(05004H)
        ADD   HL,DE
L634:
        LD    (05002H),HL
L635:
        ;;test6.j(235)   println(i);         // 1021
L636:
        LD    HL,(05002H)
L637:
        CALL  writeLineHL
L638:
        ;;test6.j(236)   
L639:
        ;;test6.j(237)   /*************************/
L640:
        ;;test6.j(238)   /* Dual term subtraction */
L641:
        ;;test6.j(239)   /*************************/
L642:
        ;;test6.j(240)   println(1024 - 2);  // 1022
L643:
        LD    HL,1024
L644:
        LD    DE,2
        OR    A
        SBC   HL,DE
L645:
        CALL  writeLineHL
L646:
        ;;test6.j(241)   println(1523 - 500);// 1023
L647:
        LD    HL,1523
L648:
        LD    DE,500
        OR    A
        SBC   HL,DE
L649:
        CALL  writeLineHL
L650:
        ;;test6.j(242)   i = 1030 - 6;
L651:
        LD    HL,1030
L652:
        LD    DE,6
        OR    A
        SBC   HL,DE
L653:
        LD    (05002H),HL
L654:
        ;;test6.j(243)   println(i);         // 1024
L655:
        LD    HL,(05002H)
L656:
        CALL  writeLineHL
L657:
        ;;test6.j(244)   i = 1525 - 500;
L658:
        LD    HL,1525
L659:
        LD    DE,500
        OR    A
        SBC   HL,DE
L660:
        LD    (05002H),HL
L661:
        ;;test6.j(245)   println(i);         // 1025
L662:
        LD    HL,(05002H)
L663:
        CALL  writeLineHL
L664:
        ;;test6.j(246)   
L665:
        ;;test6.j(247)   j = 1040;
L666:
        LD    HL,1040
L667:
        LD    (05004H),HL
L668:
        ;;test6.j(248)   b = 13;
L669:
        LD    A,13
L670:
        LD    (05000H),A
L671:
        ;;test6.j(249)   i = 3030;
L672:
        LD    HL,3030
L673:
        LD    (05002H),HL
L674:
        ;;test6.j(250)   println(j - 14);    // 1026
L675:
        LD    HL,(05004H)
L676:
        LD    DE,14
        OR    A
        SBC   HL,DE
L677:
        CALL  writeLineHL
L678:
        ;;test6.j(251)   println(j - b);     // 1027
L679:
        LD    HL,(05004H)
L680:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L681:
        CALL  writeLineHL
L682:
        ;;test6.j(252)   j = 2000;
L683:
        LD    HL,2000
L684:
        LD    (05004H),HL
L685:
        ;;test6.j(253)   println(j - 972);   // 1028
L686:
        LD    HL,(05004H)
L687:
        LD    DE,972
        OR    A
        SBC   HL,DE
L688:
        CALL  writeLineHL
L689:
        ;;test6.j(254)   println(3029 - j);  // 1029
L690:
        LD    HL,3029
L691:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L692:
        CALL  writeLineHL
L693:
        ;;test6.j(255)   println(i - j);     // 1030
L694:
        LD    HL,(05002H)
L695:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L696:
        CALL  writeLineHL
L697:
        ;;test6.j(256)   
L698:
        ;;test6.j(257)   j = 1050;
L699:
        LD    HL,1050
L700:
        LD    (05004H),HL
L701:
        ;;test6.j(258)   b = 18;
L702:
        LD    A,18
L703:
        LD    (05000H),A
L704:
        ;;test6.j(259)   i = j - 19;
L705:
        LD    HL,(05004H)
L706:
        LD    DE,19
        OR    A
        SBC   HL,DE
L707:
        LD    (05002H),HL
L708:
        ;;test6.j(260)   println(i);         // 1031
L709:
        LD    HL,(05002H)
L710:
        CALL  writeLineHL
L711:
        ;;test6.j(261)   i = j - b;
L712:
        LD    HL,(05004H)
L713:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L714:
        LD    (05002H),HL
L715:
        ;;test6.j(262)   println(i);         // 1032
L716:
        LD    HL,(05002H)
L717:
        CALL  writeLineHL
L718:
        ;;test6.j(263)   j = 2000;
L719:
        LD    HL,2000
L720:
        LD    (05004H),HL
L721:
        ;;test6.j(264)   i = j - 967;
L722:
        LD    HL,(05004H)
L723:
        LD    DE,967
        OR    A
        SBC   HL,DE
L724:
        LD    (05002H),HL
L725:
        ;;test6.j(265)   println(i);         // 1033
L726:
        LD    HL,(05002H)
L727:
        CALL  writeLineHL
L728:
        ;;test6.j(266)   i = 3034 - j;
L729:
        LD    HL,3034
L730:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L731:
        LD    (05002H),HL
L732:
        ;;test6.j(267)   println(i);         // 1034
L733:
        LD    HL,(05002H)
L734:
        CALL  writeLineHL
L735:
        ;;test6.j(268)   i = 3035;
L736:
        LD    HL,3035
L737:
        LD    (05002H),HL
L738:
        ;;test6.j(269)   i = i - j;
L739:
        LD    HL,(05002H)
L740:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L741:
        LD    (05002H),HL
L742:
        ;;test6.j(270)   println(i);         // 1035
L743:
        LD    HL,(05002H)
L744:
        CALL  writeLineHL
L745:
        ;;test6.j(271)   
L746:
        ;;test6.j(272)   /****************************/
L747:
        ;;test6.j(273)   /* Dual term multiplication */
L748:
        ;;test6.j(274)   /****************************/
L749:
        ;;test6.j(275)   println(518 * 2);   // 1036
L750:
        LD    HL,518
L751:
        LD    DE,2
        CALL  mul16
L752:
        CALL  writeLineHL
L753:
        ;;test6.j(276)   println(1 * 1037);  // 1037
L754:
        LD    A,1
L755:
        LD    L,A
        LD    H,0
L756:
        LD    DE,1037
        CALL  mul16
L757:
        CALL  writeLineHL
L758:
        ;;test6.j(277)   println(500 * 504 - 54354); // 1038 = 55392 - 54354
L759:
        LD    HL,500
L760:
        LD    DE,504
        CALL  mul16
L761:
        LD    DE,54354
        OR    A
        SBC   HL,DE
L762:
        CALL  writeLineHL
L763:
        ;;test6.j(278) 
L764:
        ;;test6.j(279)   i = 1039 * 1;
L765:
        LD    HL,1039
L766:
        LD    DE,1
        CALL  mul16
L767:
        LD    (05002H),HL
L768:
        ;;test6.j(280)   println(i);         // 1039
L769:
        LD    HL,(05002H)
L770:
        CALL  writeLineHL
L771:
        ;;test6.j(281)   i = 2 * 520;
L772:
        LD    A,2
L773:
        LD    L,A
        LD    H,0
L774:
        LD    DE,520
        CALL  mul16
L775:
        LD    (05002H),HL
L776:
        ;;test6.j(282)   println(i);         // 1040
L777:
        LD    HL,(05002H)
L778:
        CALL  writeLineHL
L779:
        ;;test6.j(283) 
L780:
        ;;test6.j(284)   i = 1041;
L781:
        LD    HL,1041
L782:
        LD    (05002H),HL
L783:
        ;;test6.j(285)   println(i * 1);     // 1041
L784:
        LD    HL,(05002H)
L785:
        LD    DE,1
        CALL  mul16
L786:
        CALL  writeLineHL
L787:
        ;;test6.j(286)   i = 521;
L788:
        LD    HL,521
L789:
        LD    (05002H),HL
L790:
        ;;test6.j(287)   println(2 * i);     // 1042
L791:
        LD    A,2
L792:
        LD    L,A
        LD    H,0
L793:
        LD    DE,(05002H)
        CALL  mul16
L794:
        CALL  writeLineHL
L795:
        ;;test6.j(288) 
L796:
        ;;test6.j(289)   i = 1043;
L797:
        LD    HL,1043
L798:
        LD    (05002H),HL
L799:
        ;;test6.j(290)   i = i * 1;
L800:
        LD    HL,(05002H)
L801:
        LD    DE,1
        CALL  mul16
L802:
        LD    (05002H),HL
L803:
        ;;test6.j(291)   println(i);         // 1043
L804:
        LD    HL,(05002H)
L805:
        CALL  writeLineHL
L806:
        ;;test6.j(292)   i = 522;
L807:
        LD    HL,522
L808:
        LD    (05002H),HL
L809:
        ;;test6.j(293)   i = 2 * i;
L810:
        LD    A,2
L811:
        LD    L,A
        LD    H,0
L812:
        LD    DE,(05002H)
        CALL  mul16
L813:
        LD    (05002H),HL
L814:
        ;;test6.j(294)   println(i);         // 1044
L815:
        LD    HL,(05002H)
L816:
        CALL  writeLineHL
L817:
        ;;test6.j(295) 
L818:
        ;;test6.j(296)   i = 500 * 504 - 54347; // 1045 = 55392 - 54347
L819:
        LD    HL,500
L820:
        LD    DE,504
        CALL  mul16
L821:
        LD    DE,54347
        OR    A
        SBC   HL,DE
L822:
        LD    (05002H),HL
L823:
        ;;test6.j(297)   println(i);         // 1045
L824:
        LD    HL,(05002H)
L825:
        CALL  writeLineHL
L826:
        ;;test6.j(298)   i = 500;
L827:
        LD    HL,500
L828:
        LD    (05002H),HL
L829:
        ;;test6.j(299)   i = i * 504 - 54346;
L830:
        LD    HL,(05002H)
L831:
        LD    DE,504
        CALL  mul16
L832:
        LD    DE,54346
        OR    A
        SBC   HL,DE
L833:
        LD    (05002H),HL
L834:
        ;;test6.j(300)   println(i);         // 1046
L835:
        LD    HL,(05002H)
L836:
        CALL  writeLineHL
L837:
        ;;test6.j(301)   i = 504;
L838:
        LD    HL,504
L839:
        LD    (05002H),HL
L840:
        ;;test6.j(302)   i = 500 * i - 54345;
L841:
        LD    HL,500
L842:
        LD    DE,(05002H)
        CALL  mul16
L843:
        LD    DE,54345
        OR    A
        SBC   HL,DE
L844:
        LD    (05002H),HL
L845:
        ;;test6.j(303)   println(i);         // 1047
L846:
        LD    HL,(05002H)
L847:
        CALL  writeLineHL
L848:
        ;;test6.j(304)   
L849:
        ;;test6.j(305)   /************/
L850:
        ;;test6.j(306)   /* Overflow */
L851:
        ;;test6.j(307)   /************/
L852:
        ;;test6.j(308)   println("Nu komen 24.764 en 25.064");
L853:
        LD    HL,895
L854:
        CALL  writeLineStr
L855:
        ;;test6.j(309)   println(300 * 301); // 90.300 % 65536 = 24.764
L856:
        LD    HL,300
L857:
        LD    DE,301
        CALL  mul16
L858:
        CALL  writeLineHL
L859:
        ;;test6.j(310)   i = 300 * 302;
L860:
        LD    HL,300
L861:
        LD    DE,302
        CALL  mul16
L862:
        LD    (05002H),HL
L863:
        ;;test6.j(311)   println(i);         // 90.600 % 65536 = 25.064
L864:
        LD    HL,(05002H)
L865:
        CALL  writeLineHL
L866:
        ;;test6.j(312) 
L867:
        ;;test6.j(313)   /***************************/
L868:
        ;;test6.j(314)   /* hex noatation constants */
L869:
        ;;test6.j(315)   /***************************/
L870:
        ;;test6.j(316)   println("hex notation constants");
L871:
        LD    HL,896
L872:
        CALL  writeLineStr
L873:
        ;;test6.j(317)   byte byteHex = 0x41;
L874:
        LD    A,65
L875:
        LD    (05006H),A
L876:
        ;;test6.j(318)   println(byteHex);
L877:
        LD    A,(05006H)
L878:
        CALL  writeLineA
L879:
        ;;test6.j(319)   word wordHex = 0x042A;
L880:
        LD    HL,1066
L881:
        LD    (05007H),HL
L882:
        ;;test6.j(320)   println(wordHex);
L883:
        LD    HL,(05007H)
L884:
        CALL  writeLineHL
L885:
        ;;test6.j(321) 
L886:
        ;;test6.j(322)   println("Klaar");
L887:
        LD    HL,897
L888:
        CALL  writeLineStr
L889:
        ;;test6.j(323) }
L890:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L891:
        .ASCIZ  "Nu komen 251 en 252"
L892:
        .ASCIZ  "Nu komen -253 en -254"
L893:
        .ASCIZ  "Nu komen 255 en 256"
L894:
        .ASCIZ  "Nu komen 1000..1047"
L895:
        .ASCIZ  "Nu komen 24.764 en 25.064"
L896:
        .ASCIZ  "hex notation constants"
L897:
        .ASCIZ  "Klaar"
