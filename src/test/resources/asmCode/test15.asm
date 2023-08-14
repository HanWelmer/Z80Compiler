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
        OR    A,L
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
        XOR   A,A
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
        OR    A,A         ;16* 4= 64 493   if (R >= D) {
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
        XOR   A,A         ; 4 25 clear upper 8 bits of AHL
div16_82:
        ADD   HL,HL       ;16*7=112 137 advance dividend (HL) into selected bits (A)
        RL    A           ;16*7=112 249
        CP    A,C         ;16*4= 64 313 check if divisor (E) <= selected digits (A)
        JR    C,div16_83  ;16*8=128 441 16*6=96 409 if not, advance without subtraction
        SUB   A,C         ;             16*4=64 473 subtract the divisor
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
        XOR   A,A         ; 4 42 A = R = remainder = 0
div8_1:
        SLA   E           ;8*7=56  98            T[E] = T[E] * 2 (remember MSB in carry)
        RL    A           ;8*7=56 154            R[A] = R[A] * 2 + carry
        SLA   D           ;8*7=56 210            Q[D] = Q[D] * 2
        CP    A,C         ;8*4=32 242            if (R[A] - D[C] >= 0) {
        JR    C,div8_2    ;8*8=64 306 8*6=48 290
        SUB   A,C         ;           8*4=32 322   R[A] = R[A] - D[C];
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
        OR    A,A         ;  4 12
        JR    Z,div8_161  ;  6 18  8  20
        XOR   A,A         ;  4 22           R = T;
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
        CP    A,'\r'      ;return if char == Carriage Return
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
        OR    A,L
        JR    NZ,writeHL1
        INC   B           ;write a single digit 0
        JR    writeHL3
writeHL1:
        LD    A,10        ;divide HL by 10
        CALL  div16_8
        PUSH  AF          ;put remainder on stack
        INC   B
        LD    A,H         ;is quotient 0?
        OR    A,L
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
        ;;test15.j(5)   // Possible data types: byte, word.
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
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
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
        ;;test15.j(29)   //constant byte/constant word
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
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
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
        ;;test15.j(33)   //constant word/constant byte
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
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
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
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
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
        ;;test15.j(48)   //constant byte/acc word
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
        ;;test15.j(52)   //constant word/acc byte
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
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
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
        ;;test15.j(67)   //constant byte/var word
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
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
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
        ;;test15.j(71)   //constant word/var byte
L414:
        ;;test15.j(72)   if (0x1234 & b1 == 0x0014) println (34); else println (999);
L415:
        LD    HL,4660
L416:
        LD    B,A
        LD    A,(05000H)
        AND   A,L
        LD    L,A
        LD    A,B
        LD    H,0
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
        LD    B,A
        LD    A,(05000H)
        OR    A,L
        LD    L,A
        LD    A,B
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
        LD    B,A
        LD    A,(05000H)
        XOR   A,L
        LD    L,A
        LD    A,B
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
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
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
        ;;test15.j(86)   //constant byte/final var word
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
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
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
        ;;test15.j(90)   //constant word/final var byte
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
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
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
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
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
        ;;test15.j(105)   //acc byte/constant word
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
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
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
        ;;test15.j(109)   //acc word/constant byte
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
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
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
        ;;test15.j(121)   if (0x1000 + 0x0234 & 0x0100 + 0x022C == 0x0224) println (64); else println (999);
L766:
        LD    HL,4096
L767:
        LD    DE,564
        ADD   HL,DE
L768:
        PUSH  HL
        LD    HL,256
L769:
        LD    DE,556
        ADD   HL,DE
L770:
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
L771:
        LD    DE,548
        OR    A
        SBC   HL,DE
L772:
        JP    NZ,L776
L773:
        LD    A,64
L774:
        CALL  writeLineA
L775:
        JP    L779
L776:
        LD    HL,999
L777:
        CALL  writeLineHL
L778:
        ;;test15.j(122)   if (0x1000 + 0x0234 | 0x0100 + 0x022C == 0x133C) println (65); else println (999);
L779:
        LD    HL,4096
L780:
        LD    DE,564
        ADD   HL,DE
L781:
        PUSH  HL
        LD    HL,256
L782:
        LD    DE,556
        ADD   HL,DE
L783:
        POP   DE
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L784:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L785:
        JP    NZ,L789
L786:
        LD    A,65
L787:
        CALL  writeLineA
L788:
        JP    L792
L789:
        LD    HL,999
L790:
        CALL  writeLineHL
L791:
        ;;test15.j(123)   if (0x1000 + 0x0234 ^ 0x0100 + 0x022C == 0x1118) println (66); else println (999);
L792:
        LD    HL,4096
L793:
        LD    DE,564
        ADD   HL,DE
L794:
        PUSH  HL
        LD    HL,256
L795:
        LD    DE,556
        ADD   HL,DE
L796:
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
L797:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L798:
        JP    NZ,L802
L799:
        LD    A,66
L800:
        CALL  writeLineA
L801:
        JP    L806
L802:
        LD    HL,999
L803:
        CALL  writeLineHL
L804:
        ;;test15.j(124)   //acc byte/acc word
L805:
        ;;test15.j(125)   if (0x10 + 0x0C & 0x1000 + 0x0234 == 0x0014) println (67); else println (999);
L806:
        LD    A,16
L807:
        ADD   A,12
L808:
        LD    HL,4096
L809:
        LD    DE,564
        ADD   HL,DE
L810:
        AND   A,L
        LD    L,A
        LD    H,0
L811:
        LD    A,20
L812:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L813:
        JP    NZ,L817
L814:
        LD    A,67
L815:
        CALL  writeLineA
L816:
        JP    L820
L817:
        LD    HL,999
L818:
        CALL  writeLineHL
L819:
        ;;test15.j(126)   if (0x10 + 0x0C | 0x1000 + 0x0234 == 0x123C) println (68); else println (999);
L820:
        LD    A,16
L821:
        ADD   A,12
L822:
        LD    HL,4096
L823:
        LD    DE,564
        ADD   HL,DE
L824:
        OR    A,L
        LD    L,A
L825:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L826:
        JP    NZ,L830
L827:
        LD    A,68
L828:
        CALL  writeLineA
L829:
        JP    L833
L830:
        LD    HL,999
L831:
        CALL  writeLineHL
L832:
        ;;test15.j(127)   if (0x10 + 0x0C ^ 0x1000 + 0x0234 == 0x1228) println (69); else println (999);
L833:
        LD    A,16
L834:
        ADD   A,12
L835:
        LD    HL,4096
L836:
        LD    DE,564
        ADD   HL,DE
L837:
        XOR   A,L
        LD    L,A
L838:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L839:
        JP    NZ,L843
L840:
        LD    A,69
L841:
        CALL  writeLineA
L842:
        JP    L847
L843:
        LD    HL,999
L844:
        CALL  writeLineHL
L845:
        ;;test15.j(128)   //acc word/acc byte
L846:
        ;;test15.j(129)   if (0x1000 + 0x0234 & 0x10 + 0x0C == 0x0014) println (70); else println (999);
L847:
        LD    HL,4096
L848:
        LD    DE,564
        ADD   HL,DE
L849:
        LD    A,16
L850:
        ADD   A,12
L851:
        AND   A,L
        LD    L,A
        LD    H,0
L852:
        LD    A,20
L853:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L854:
        JP    NZ,L858
L855:
        LD    A,70
L856:
        CALL  writeLineA
L857:
        JP    L861
L858:
        LD    HL,999
L859:
        CALL  writeLineHL
L860:
        ;;test15.j(130)   if (0x1000 + 0x0234 | 0x10 + 0x0C == 0x123C) println (71); else println (999);
L861:
        LD    HL,4096
L862:
        LD    DE,564
        ADD   HL,DE
L863:
        LD    A,16
L864:
        ADD   A,12
L865:
        OR    A,L
        LD    L,A
L866:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L867:
        JP    NZ,L871
L868:
        LD    A,71
L869:
        CALL  writeLineA
L870:
        JP    L874
L871:
        LD    HL,999
L872:
        CALL  writeLineHL
L873:
        ;;test15.j(131)   if (0x1000 + 0x0234 ^ 0x10 + 0x0C == 0x1228) println (72); else println (999);
L874:
        LD    HL,4096
L875:
        LD    DE,564
        ADD   HL,DE
L876:
        LD    A,16
L877:
        ADD   A,12
L878:
        XOR   A,L
        LD    L,A
L879:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L880:
        JP    NZ,L884
L881:
        LD    A,72
L882:
        CALL  writeLineA
L883:
        JP    L891
L884:
        LD    HL,999
L885:
        CALL  writeLineHL
L886:
        ;;test15.j(132) 
L887:
        ;;test15.j(133)   //acc/var
L888:
        ;;test15.j(134)   //*******
L889:
        ;;test15.j(135)   //acc byte/var byte
L890:
        ;;test15.j(136)   if (0x04 + 0x03 & b1 == 0x04) println (73); else println (999);
L891:
        LD    A,4
L892:
        ADD   A,3
L893:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L894:
        SUB   A,4
L895:
        JP    NZ,L899
L896:
        LD    A,73
L897:
        CALL  writeLineA
L898:
        JP    L902
L899:
        LD    HL,999
L900:
        CALL  writeLineHL
L901:
        ;;test15.j(137)   if (0x04 + 0x03 | b1 == 0x1F) println (74); else println (999);
L902:
        LD    A,4
L903:
        ADD   A,3
L904:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L905:
        SUB   A,31
L906:
        JP    NZ,L910
L907:
        LD    A,74
L908:
        CALL  writeLineA
L909:
        JP    L913
L910:
        LD    HL,999
L911:
        CALL  writeLineHL
L912:
        ;;test15.j(138)   if (0x04 + 0x03 ^ b1 == 0x1B) println (75); else println (999);
L913:
        LD    A,4
L914:
        ADD   A,3
L915:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L916:
        SUB   A,27
L917:
        JP    NZ,L921
L918:
        LD    A,75
L919:
        CALL  writeLineA
L920:
        JP    L925
L921:
        LD    HL,999
L922:
        CALL  writeLineHL
L923:
        ;;test15.j(139)   //acc word/var word
L924:
        ;;test15.j(140)   if (0x1000 + 0x0234 & w1 == 0x0224) println (76); else println (999);
L925:
        LD    HL,4096
L926:
        LD    DE,564
        ADD   HL,DE
L927:
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
L928:
        LD    DE,548
        OR    A
        SBC   HL,DE
L929:
        JP    NZ,L933
L930:
        LD    A,76
L931:
        CALL  writeLineA
L932:
        JP    L936
L933:
        LD    HL,999
L934:
        CALL  writeLineHL
L935:
        ;;test15.j(141)   if (0x1000 + 0x0234 | w1 == 0x133C) println (77); else println (999);
L936:
        LD    HL,4096
L937:
        LD    DE,564
        ADD   HL,DE
L938:
        LD    DE,(05002H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L939:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L940:
        JP    NZ,L944
L941:
        LD    A,77
L942:
        CALL  writeLineA
L943:
        JP    L947
L944:
        LD    HL,999
L945:
        CALL  writeLineHL
L946:
        ;;test15.j(142)   if (0x1000 + 0x0234 ^ w1 == 0x1118) println (78); else println (999);
L947:
        LD    HL,4096
L948:
        LD    DE,564
        ADD   HL,DE
L949:
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
L950:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L951:
        JP    NZ,L955
L952:
        LD    A,78
L953:
        CALL  writeLineA
L954:
        JP    L959
L955:
        LD    HL,999
L956:
        CALL  writeLineHL
L957:
        ;;test15.j(143)   //acc byte/var word
L958:
        ;;test15.j(144)   if (0x10 + 0x0C & w2 == 0x0014) println (79); else println (999);
L959:
        LD    A,16
L960:
        ADD   A,12
L961:
        LD    L,A
        LD    H,0
L962:
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
L963:
        LD    A,20
L964:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L965:
        JP    NZ,L969
L966:
        LD    A,79
L967:
        CALL  writeLineA
L968:
        JP    L972
L969:
        LD    HL,999
L970:
        CALL  writeLineHL
L971:
        ;;test15.j(145)   if (0x10 + 0x0C | w2 == 0x123C) println (80); else println (999);
L972:
        LD    A,16
L973:
        ADD   A,12
L974:
        LD    L,A
        LD    H,0
L975:
        LD    DE,(05004H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L976:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L977:
        JP    NZ,L981
L978:
        LD    A,80
L979:
        CALL  writeLineA
L980:
        JP    L984
L981:
        LD    HL,999
L982:
        CALL  writeLineHL
L983:
        ;;test15.j(146)   if (0x10 + 0x0C ^ w2 == 0x1228) println (81); else println (999);
L984:
        LD    A,16
L985:
        ADD   A,12
L986:
        LD    L,A
        LD    H,0
L987:
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
L988:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L989:
        JP    NZ,L993
L990:
        LD    A,81
L991:
        CALL  writeLineA
L992:
        JP    L997
L993:
        LD    HL,999
L994:
        CALL  writeLineHL
L995:
        ;;test15.j(147)   //acc word/var byte
L996:
        ;;test15.j(148)   if (0x1000 + 0x0234 & b1 == 0x0014) println (82); else println (999);
L997:
        LD    HL,4096
L998:
        LD    DE,564
        ADD   HL,DE
L999:
        LD    B,A
        LD    A,(05000H)
        AND   A,L
        LD    L,A
        LD    A,B
        LD    H,0
L1000:
        LD    A,20
L1001:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1002:
        JP    NZ,L1006
L1003:
        LD    A,82
L1004:
        CALL  writeLineA
L1005:
        JP    L1009
L1006:
        LD    HL,999
L1007:
        CALL  writeLineHL
L1008:
        ;;test15.j(149)   if (0x1000 + 0x0234 | b1 == 0x123C) println (83); else println (999);
L1009:
        LD    HL,4096
L1010:
        LD    DE,564
        ADD   HL,DE
L1011:
        LD    B,A
        LD    A,(05000H)
        OR    A,L
        LD    L,A
        LD    A,B
L1012:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1013:
        JP    NZ,L1017
L1014:
        LD    A,83
L1015:
        CALL  writeLineA
L1016:
        JP    L1020
L1017:
        LD    HL,999
L1018:
        CALL  writeLineHL
L1019:
        ;;test15.j(150)   if (0x1000 + 0x0234 ^ b1 == 0x1228) println (84); else println (999);
L1020:
        LD    HL,4096
L1021:
        LD    DE,564
        ADD   HL,DE
L1022:
        LD    B,A
        LD    A,(05000H)
        XOR   A,L
        LD    L,A
        LD    A,B
L1023:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1024:
        JP    NZ,L1028
L1025:
        LD    A,84
L1026:
        CALL  writeLineA
L1027:
        JP    L1035
L1028:
        LD    HL,999
L1029:
        CALL  writeLineHL
L1030:
        ;;test15.j(151) 
L1031:
        ;;test15.j(152)   //acc/final var
L1032:
        ;;test15.j(153)   //*************
L1033:
        ;;test15.j(154)   //acc byte/final var byte
L1034:
        ;;test15.j(155)   if (0x04 + 0x03 & fb1 == 0x04) println (85); else println (999);
L1035:
        LD    A,4
L1036:
        ADD   A,3
L1037:
        AND   A,28
L1038:
        SUB   A,4
L1039:
        JP    NZ,L1043
L1040:
        LD    A,85
L1041:
        CALL  writeLineA
L1042:
        JP    L1046
L1043:
        LD    HL,999
L1044:
        CALL  writeLineHL
L1045:
        ;;test15.j(156)   if (0x04 + 0x03 | fb1 == 0x1F) println (86); else println (999);
L1046:
        LD    A,4
L1047:
        ADD   A,3
L1048:
        OR    A,28
L1049:
        SUB   A,31
L1050:
        JP    NZ,L1054
L1051:
        LD    A,86
L1052:
        CALL  writeLineA
L1053:
        JP    L1057
L1054:
        LD    HL,999
L1055:
        CALL  writeLineHL
L1056:
        ;;test15.j(157)   if (0x04 + 0x03 ^ fb1 == 0x1B) println (87); else println (999);
L1057:
        LD    A,4
L1058:
        ADD   A,3
L1059:
        XOR   A,28
L1060:
        SUB   A,27
L1061:
        JP    NZ,L1065
L1062:
        LD    A,87
L1063:
        CALL  writeLineA
L1064:
        JP    L1069
L1065:
        LD    HL,999
L1066:
        CALL  writeLineHL
L1067:
        ;;test15.j(158)   //acc word/final var word
L1068:
        ;;test15.j(159)   if (0x1000 + 0x0234 & fw1 == 0x0224) println (88); else println (999);
L1069:
        LD    HL,4096
L1070:
        LD    DE,564
        ADD   HL,DE
L1071:
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
L1072:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1073:
        JP    NZ,L1077
L1074:
        LD    A,88
L1075:
        CALL  writeLineA
L1076:
        JP    L1080
L1077:
        LD    HL,999
L1078:
        CALL  writeLineHL
L1079:
        ;;test15.j(160)   if (0x1000 + 0x0234 | fw1 == 0x133C) println (89); else println (999);
L1080:
        LD    HL,4096
L1081:
        LD    DE,564
        ADD   HL,DE
L1082:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1083:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1084:
        JP    NZ,L1088
L1085:
        LD    A,89
L1086:
        CALL  writeLineA
L1087:
        JP    L1091
L1088:
        LD    HL,999
L1089:
        CALL  writeLineHL
L1090:
        ;;test15.j(161)   if (0x1000 + 0x0234 ^ fw1 == 0x1118) println (90); else println (999);
L1091:
        LD    HL,4096
L1092:
        LD    DE,564
        ADD   HL,DE
L1093:
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
L1094:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1095:
        JP    NZ,L1099
L1096:
        LD    A,90
L1097:
        CALL  writeLineA
L1098:
        JP    L1103
L1099:
        LD    HL,999
L1100:
        CALL  writeLineHL
L1101:
        ;;test15.j(162)   //acc byte/final var word
L1102:
        ;;test15.j(163)   if (0x10 + 0x0C & fw2 == 0x0014) println (91); else println (999);
L1103:
        LD    A,16
L1104:
        ADD   A,12
L1105:
        LD    L,A
        LD    H,0
L1106:
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
L1107:
        LD    A,20
L1108:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1109:
        JP    NZ,L1113
L1110:
        LD    A,91
L1111:
        CALL  writeLineA
L1112:
        JP    L1116
L1113:
        LD    HL,999
L1114:
        CALL  writeLineHL
L1115:
        ;;test15.j(164)   if (0x10 + 0x0C | fw2 == 0x123C) println (92); else println (999);
L1116:
        LD    A,16
L1117:
        ADD   A,12
L1118:
        LD    L,A
        LD    H,0
L1119:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1120:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1121:
        JP    NZ,L1125
L1122:
        LD    A,92
L1123:
        CALL  writeLineA
L1124:
        JP    L1128
L1125:
        LD    HL,999
L1126:
        CALL  writeLineHL
L1127:
        ;;test15.j(165)   if (0x10 + 0x0C ^ fw2 == 0x1228) println (93); else println (999);
L1128:
        LD    A,16
L1129:
        ADD   A,12
L1130:
        LD    L,A
        LD    H,0
L1131:
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
L1132:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1133:
        JP    NZ,L1137
L1134:
        LD    A,93
L1135:
        CALL  writeLineA
L1136:
        JP    L1141
L1137:
        LD    HL,999
L1138:
        CALL  writeLineHL
L1139:
        ;;test15.j(166)   //acc word/final var byte
L1140:
        ;;test15.j(167)   if (0x1000 + 0x0234 & fb1 == 0x0014) println (94); else println (999);
L1141:
        LD    HL,4096
L1142:
        LD    DE,564
        ADD   HL,DE
L1143:
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
L1144:
        LD    A,20
L1145:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1146:
        JP    NZ,L1150
L1147:
        LD    A,94
L1148:
        CALL  writeLineA
L1149:
        JP    L1153
L1150:
        LD    HL,999
L1151:
        CALL  writeLineHL
L1152:
        ;;test15.j(168)   if (0x1000 + 0x0234 | fb1 == 0x123C) println (95); else println (999);
L1153:
        LD    HL,4096
L1154:
        LD    DE,564
        ADD   HL,DE
L1155:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1156:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1157:
        JP    NZ,L1161
L1158:
        LD    A,95
L1159:
        CALL  writeLineA
L1160:
        JP    L1164
L1161:
        LD    HL,999
L1162:
        CALL  writeLineHL
L1163:
        ;;test15.j(169)   if (0x1000 + 0x0234 ^ fb1 == 0x1228) println (96); else println (999);
L1164:
        LD    HL,4096
L1165:
        LD    DE,564
        ADD   HL,DE
L1166:
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
L1167:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1168:
        JP    NZ,L1172
L1169:
        LD    A,96
L1170:
        CALL  writeLineA
L1171:
        JP    L1179
L1172:
        LD    HL,999
L1173:
        CALL  writeLineHL
L1174:
        ;;test15.j(170) 
L1175:
        ;;test15.j(171)   //var/constant
L1176:
        ;;test15.j(172)   //************
L1177:
        ;;test15.j(173)   //var byte/constant byte
L1178:
        ;;test15.j(174)   if (b2 & 0x1C == 0x04) println (97); else println (999);
L1179:
        LD    A,(05001H)
L1180:
        AND   A,28
L1181:
        SUB   A,4
L1182:
        JP    NZ,L1186
L1183:
        LD    A,97
L1184:
        CALL  writeLineA
L1185:
        JP    L1189
L1186:
        LD    HL,999
L1187:
        CALL  writeLineHL
L1188:
        ;;test15.j(175)   if (b2 | 0x1C == 0x1F) println (98); else println (999);
L1189:
        LD    A,(05001H)
L1190:
        OR    A,28
L1191:
        SUB   A,31
L1192:
        JP    NZ,L1196
L1193:
        LD    A,98
L1194:
        CALL  writeLineA
L1195:
        JP    L1199
L1196:
        LD    HL,999
L1197:
        CALL  writeLineHL
L1198:
        ;;test15.j(176)   if (b2 ^ 0x1C == 0x1B) println (99); else println (999);
L1199:
        LD    A,(05001H)
L1200:
        XOR   A,28
L1201:
        SUB   A,27
L1202:
        JP    NZ,L1206
L1203:
        LD    A,99
L1204:
        CALL  writeLineA
L1205:
        JP    L1210
L1206:
        LD    HL,999
L1207:
        CALL  writeLineHL
L1208:
        ;;test15.j(177)   //var word/constant word
L1209:
        ;;test15.j(178)   if (w2 & 0x032C == 0x0224) println (100); else println (999);
L1210:
        LD    HL,(05004H)
L1211:
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
L1212:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1213:
        JP    NZ,L1217
L1214:
        LD    A,100
L1215:
        CALL  writeLineA
L1216:
        JP    L1220
L1217:
        LD    HL,999
L1218:
        CALL  writeLineHL
L1219:
        ;;test15.j(179)   if (w2 | 0x032C == 0x133C) println (101); else println (999);
L1220:
        LD    HL,(05004H)
L1221:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1222:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1223:
        JP    NZ,L1227
L1224:
        LD    A,101
L1225:
        CALL  writeLineA
L1226:
        JP    L1230
L1227:
        LD    HL,999
L1228:
        CALL  writeLineHL
L1229:
        ;;test15.j(180)   if (w2 ^ 0x032C == 0x1118) println (102); else println (999);
L1230:
        LD    HL,(05004H)
L1231:
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
L1232:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1233:
        JP    NZ,L1237
L1234:
        LD    A,102
L1235:
        CALL  writeLineA
L1236:
        JP    L1241
L1237:
        LD    HL,999
L1238:
        CALL  writeLineHL
L1239:
        ;;test15.j(181)   //var byte/constant word
L1240:
        ;;test15.j(182)   if (b1 & 0x1234 == 0x0014) println (103); else println (999);
L1241:
        LD    A,(05000H)
L1242:
        LD    L,A
        LD    H,0
L1243:
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
L1244:
        LD    A,20
L1245:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1246:
        JP    NZ,L1250
L1247:
        LD    A,103
L1248:
        CALL  writeLineA
L1249:
        JP    L1253
L1250:
        LD    HL,999
L1251:
        CALL  writeLineHL
L1252:
        ;;test15.j(183)   if (b1 | 0x1234 == 0x123C) println (104); else println (999);
L1253:
        LD    A,(05000H)
L1254:
        LD    L,A
        LD    H,0
L1255:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1256:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1257:
        JP    NZ,L1261
L1258:
        LD    A,104
L1259:
        CALL  writeLineA
L1260:
        JP    L1264
L1261:
        LD    HL,999
L1262:
        CALL  writeLineHL
L1263:
        ;;test15.j(184)   if (b1 ^ 0x1234 == 0x1228) println (105); else println (999);
L1264:
        LD    A,(05000H)
L1265:
        LD    L,A
        LD    H,0
L1266:
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
L1267:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1268:
        JP    NZ,L1272
L1269:
        LD    A,105
L1270:
        CALL  writeLineA
L1271:
        JP    L1276
L1272:
        LD    HL,999
L1273:
        CALL  writeLineHL
L1274:
        ;;test15.j(185)   //var word/constant byte
L1275:
        ;;test15.j(186)   if (w2 & 0x1C == 0x0014) println (106); else println (999);
L1276:
        LD    HL,(05004H)
L1277:
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
L1278:
        LD    A,20
L1279:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1280:
        JP    NZ,L1284
L1281:
        LD    A,106
L1282:
        CALL  writeLineA
L1283:
        JP    L1287
L1284:
        LD    HL,999
L1285:
        CALL  writeLineHL
L1286:
        ;;test15.j(187)   if (w2 | 0x1C == 0x123C) println (107); else println (999);
L1287:
        LD    HL,(05004H)
L1288:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1289:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1290:
        JP    NZ,L1294
L1291:
        LD    A,107
L1292:
        CALL  writeLineA
L1293:
        JP    L1297
L1294:
        LD    HL,999
L1295:
        CALL  writeLineHL
L1296:
        ;;test15.j(188)   if (w2 ^ 0x1C == 0x1228) println (108); else println (999);
L1297:
        LD    HL,(05004H)
L1298:
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
L1299:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1300:
        JP    NZ,L1304
L1301:
        LD    A,108
L1302:
        CALL  writeLineA
L1303:
        JP    L1311
L1304:
        LD    HL,999
L1305:
        CALL  writeLineHL
L1306:
        ;;test15.j(189) 
L1307:
        ;;test15.j(190)   //var/acc
L1308:
        ;;test15.j(191)   //*******
L1309:
        ;;test15.j(192)   //var byte/acc byte
L1310:
        ;;test15.j(193)   if (b2 & (0x10 + 0x0C) == 0x04) println (109); else println (999);
L1311:
        LD    A,(05001H)
L1312:
        PUSH  AF
        LD    A,16
L1313:
        ADD   A,12
L1314:
        POP   BC
        AND   A,B
L1315:
        SUB   A,4
L1316:
        JP    NZ,L1320
L1317:
        LD    A,109
L1318:
        CALL  writeLineA
L1319:
        JP    L1323
L1320:
        LD    HL,999
L1321:
        CALL  writeLineHL
L1322:
        ;;test15.j(194)   if (b2 | (0x10 + 0x0C) == 0x1F) println (110); else println (999);
L1323:
        LD    A,(05001H)
L1324:
        PUSH  AF
        LD    A,16
L1325:
        ADD   A,12
L1326:
        POP   BC
        OR    A,B
L1327:
        SUB   A,31
L1328:
        JP    NZ,L1332
L1329:
        LD    A,110
L1330:
        CALL  writeLineA
L1331:
        JP    L1335
L1332:
        LD    HL,999
L1333:
        CALL  writeLineHL
L1334:
        ;;test15.j(195)   if (b2 ^ (0x10 + 0x0C) == 0x1B) println (111); else println (999);
L1335:
        LD    A,(05001H)
L1336:
        PUSH  AF
        LD    A,16
L1337:
        ADD   A,12
L1338:
        POP   BC
        XOR   A,B
L1339:
        SUB   A,27
L1340:
        JP    NZ,L1344
L1341:
        LD    A,111
L1342:
        CALL  writeLineA
L1343:
        JP    L1348
L1344:
        LD    HL,999
L1345:
        CALL  writeLineHL
L1346:
        ;;test15.j(196)   //var word/acc word
L1347:
        ;;test15.j(197)   if (w2 & 0x0100 + 0x022C == 0x0224) println (112); else println (999);
L1348:
        LD    HL,(05004H)
L1349:
        PUSH  HL
        LD    HL,256
L1350:
        LD    DE,556
        ADD   HL,DE
L1351:
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
L1352:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1353:
        JP    NZ,L1357
L1354:
        LD    A,112
L1355:
        CALL  writeLineA
L1356:
        JP    L1360
L1357:
        LD    HL,999
L1358:
        CALL  writeLineHL
L1359:
        ;;test15.j(198)   if (w2 | 0x0100 + 0x022C == 0x133C) println (113); else println (999);
L1360:
        LD    HL,(05004H)
L1361:
        PUSH  HL
        LD    HL,256
L1362:
        LD    DE,556
        ADD   HL,DE
L1363:
        POP   DE
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1364:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1365:
        JP    NZ,L1369
L1366:
        LD    A,113
L1367:
        CALL  writeLineA
L1368:
        JP    L1372
L1369:
        LD    HL,999
L1370:
        CALL  writeLineHL
L1371:
        ;;test15.j(199)   if (w2 ^ 0x0100 + 0x022C == 0x1118) println (114); else println (999);
L1372:
        LD    HL,(05004H)
L1373:
        PUSH  HL
        LD    HL,256
L1374:
        LD    DE,556
        ADD   HL,DE
L1375:
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
L1376:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1377:
        JP    NZ,L1381
L1378:
        LD    A,114
L1379:
        CALL  writeLineA
L1380:
        JP    L1385
L1381:
        LD    HL,999
L1382:
        CALL  writeLineHL
L1383:
        ;;test15.j(200)   //var byte/acc word
L1384:
        ;;test15.j(201)   if (b1 & 0x1000 + 0x0234 == 0x0014) println (115); else println (999);
L1385:
        LD    A,(05000H)
L1386:
        LD    HL,4096
L1387:
        LD    DE,564
        ADD   HL,DE
L1388:
        AND   A,L
        LD    L,A
        LD    H,0
L1389:
        LD    A,20
L1390:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1391:
        JP    NZ,L1395
L1392:
        LD    A,115
L1393:
        CALL  writeLineA
L1394:
        JP    L1398
L1395:
        LD    HL,999
L1396:
        CALL  writeLineHL
L1397:
        ;;test15.j(202)   if (b1 | 0x1000 + 0x0234 == 0x123C) println (116); else println (999);
L1398:
        LD    A,(05000H)
L1399:
        LD    HL,4096
L1400:
        LD    DE,564
        ADD   HL,DE
L1401:
        OR    A,L
        LD    L,A
L1402:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1403:
        JP    NZ,L1407
L1404:
        LD    A,116
L1405:
        CALL  writeLineA
L1406:
        JP    L1410
L1407:
        LD    HL,999
L1408:
        CALL  writeLineHL
L1409:
        ;;test15.j(203)   if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (117); else println (999);
L1410:
        LD    A,(05000H)
L1411:
        LD    HL,4096
L1412:
        LD    DE,564
        ADD   HL,DE
L1413:
        XOR   A,L
        LD    L,A
L1414:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1415:
        JP    NZ,L1419
L1416:
        LD    A,117
L1417:
        CALL  writeLineA
L1418:
        JP    L1423
L1419:
        LD    HL,999
L1420:
        CALL  writeLineHL
L1421:
        ;;test15.j(204)   //var word/acc byte
L1422:
        ;;test15.j(205)   if (w2 & 0x10 + 0x0C == 0x0014) println (118); else println (999);
L1423:
        LD    HL,(05004H)
L1424:
        LD    A,16
L1425:
        ADD   A,12
L1426:
        AND   A,L
        LD    L,A
        LD    H,0
L1427:
        LD    A,20
L1428:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1429:
        JP    NZ,L1433
L1430:
        LD    A,118
L1431:
        CALL  writeLineA
L1432:
        JP    L1436
L1433:
        LD    HL,999
L1434:
        CALL  writeLineHL
L1435:
        ;;test15.j(206)   if (w2 | 0x10 + 0x0C == 0x123C) println (119); else println (999);
L1436:
        LD    HL,(05004H)
L1437:
        LD    A,16
L1438:
        ADD   A,12
L1439:
        OR    A,L
        LD    L,A
L1440:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1441:
        JP    NZ,L1445
L1442:
        LD    A,119
L1443:
        CALL  writeLineA
L1444:
        JP    L1448
L1445:
        LD    HL,999
L1446:
        CALL  writeLineHL
L1447:
        ;;test15.j(207)   if (w2 ^ 0x10 + 0x0C == 0x1228) println (120); else println (999);
L1448:
        LD    HL,(05004H)
L1449:
        LD    A,16
L1450:
        ADD   A,12
L1451:
        XOR   A,L
        LD    L,A
L1452:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1453:
        JP    NZ,L1457
L1454:
        LD    A,120
L1455:
        CALL  writeLineA
L1456:
        JP    L1464
L1457:
        LD    HL,999
L1458:
        CALL  writeLineHL
L1459:
        ;;test15.j(208) 
L1460:
        ;;test15.j(209)   //var/var
L1461:
        ;;test15.j(210)   //*******
L1462:
        ;;test15.j(211)   //var byte/var byte
L1463:
        ;;test15.j(212)   if (b2 & b1 == 0x04) println (121); else println (999);
L1464:
        LD    A,(05001H)
L1465:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L1466:
        SUB   A,4
L1467:
        JP    NZ,L1471
L1468:
        LD    A,121
L1469:
        CALL  writeLineA
L1470:
        JP    L1474
L1471:
        LD    HL,999
L1472:
        CALL  writeLineHL
L1473:
        ;;test15.j(213)   if (b2 | b1 == 0x1F) println (122); else println (999);
L1474:
        LD    A,(05001H)
L1475:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L1476:
        SUB   A,31
L1477:
        JP    NZ,L1481
L1478:
        LD    A,122
L1479:
        CALL  writeLineA
L1480:
        JP    L1484
L1481:
        LD    HL,999
L1482:
        CALL  writeLineHL
L1483:
        ;;test15.j(214)   if (b2 ^ b1 == 0x1B) println (123); else println (999);
L1484:
        LD    A,(05001H)
L1485:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L1486:
        SUB   A,27
L1487:
        JP    NZ,L1491
L1488:
        LD    A,123
L1489:
        CALL  writeLineA
L1490:
        JP    L1495
L1491:
        LD    HL,999
L1492:
        CALL  writeLineHL
L1493:
        ;;test15.j(215)   //var word/var word
L1494:
        ;;test15.j(216)   if (w2 & w1 == 0x0224) println (124); else println (999);
L1495:
        LD    HL,(05004H)
L1496:
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
L1497:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1498:
        JP    NZ,L1502
L1499:
        LD    A,124
L1500:
        CALL  writeLineA
L1501:
        JP    L1505
L1502:
        LD    HL,999
L1503:
        CALL  writeLineHL
L1504:
        ;;test15.j(217)   if (w2 | w1 == 0x133C) println (125); else println (999);
L1505:
        LD    HL,(05004H)
L1506:
        LD    DE,(05002H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1507:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1508:
        JP    NZ,L1512
L1509:
        LD    A,125
L1510:
        CALL  writeLineA
L1511:
        JP    L1515
L1512:
        LD    HL,999
L1513:
        CALL  writeLineHL
L1514:
        ;;test15.j(218)   if (w2 ^ w1 == 0x1118) println (126); else println (999);
L1515:
        LD    HL,(05004H)
L1516:
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
L1517:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1518:
        JP    NZ,L1522
L1519:
        LD    A,126
L1520:
        CALL  writeLineA
L1521:
        JP    L1526
L1522:
        LD    HL,999
L1523:
        CALL  writeLineHL
L1524:
        ;;test15.j(219)   //var byte/var word
L1525:
        ;;test15.j(220)   if (b1 & w2 == 0x0014) println (127); else println (999);
L1526:
        LD    A,(05000H)
L1527:
        LD    L,A
        LD    H,0
L1528:
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
L1529:
        LD    A,20
L1530:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1531:
        JP    NZ,L1535
L1532:
        LD    A,127
L1533:
        CALL  writeLineA
L1534:
        JP    L1538
L1535:
        LD    HL,999
L1536:
        CALL  writeLineHL
L1537:
        ;;test15.j(221)   if (b1 | w2 == 0x123C) println (128); else println (999);
L1538:
        LD    A,(05000H)
L1539:
        LD    L,A
        LD    H,0
L1540:
        LD    DE,(05004H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1541:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1542:
        JP    NZ,L1546
L1543:
        LD    A,128
L1544:
        CALL  writeLineA
L1545:
        JP    L1549
L1546:
        LD    HL,999
L1547:
        CALL  writeLineHL
L1548:
        ;;test15.j(222)   if (b1 ^ w2 == 0x1228) println (129); else println (999);
L1549:
        LD    A,(05000H)
L1550:
        LD    L,A
        LD    H,0
L1551:
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
L1552:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1553:
        JP    NZ,L1557
L1554:
        LD    A,129
L1555:
        CALL  writeLineA
L1556:
        JP    L1561
L1557:
        LD    HL,999
L1558:
        CALL  writeLineHL
L1559:
        ;;test15.j(223)   //var word/var byte
L1560:
        ;;test15.j(224)   if (w2 & b1 == 0x0014) println (130); else println (999);
L1561:
        LD    HL,(05004H)
L1562:
        LD    B,A
        LD    A,(05000H)
        AND   A,L
        LD    L,A
        LD    A,B
        LD    H,0
L1563:
        LD    A,20
L1564:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1565:
        JP    NZ,L1569
L1566:
        LD    A,130
L1567:
        CALL  writeLineA
L1568:
        JP    L1572
L1569:
        LD    HL,999
L1570:
        CALL  writeLineHL
L1571:
        ;;test15.j(225)   if (w2 | b1 == 0x123C) println (131); else println (999);
L1572:
        LD    HL,(05004H)
L1573:
        LD    B,A
        LD    A,(05000H)
        OR    A,L
        LD    L,A
        LD    A,B
L1574:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1575:
        JP    NZ,L1579
L1576:
        LD    A,131
L1577:
        CALL  writeLineA
L1578:
        JP    L1582
L1579:
        LD    HL,999
L1580:
        CALL  writeLineHL
L1581:
        ;;test15.j(226)   if (w2 ^ b1 == 0x1228) println (132); else println (999);
L1582:
        LD    HL,(05004H)
L1583:
        LD    B,A
        LD    A,(05000H)
        XOR   A,L
        LD    L,A
        LD    A,B
L1584:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1585:
        JP    NZ,L1589
L1586:
        LD    A,132
L1587:
        CALL  writeLineA
L1588:
        JP    L1596
L1589:
        LD    HL,999
L1590:
        CALL  writeLineHL
L1591:
        ;;test15.j(227) 
L1592:
        ;;test15.j(228)   //var/final var
L1593:
        ;;test15.j(229)   //*************
L1594:
        ;;test15.j(230)   //var byte/final var byte
L1595:
        ;;test15.j(231)   if (b2 & fb1 == 0x04) println (133); else println (999);
L1596:
        LD    A,(05001H)
L1597:
        AND   A,28
L1598:
        SUB   A,4
L1599:
        JP    NZ,L1603
L1600:
        LD    A,133
L1601:
        CALL  writeLineA
L1602:
        JP    L1606
L1603:
        LD    HL,999
L1604:
        CALL  writeLineHL
L1605:
        ;;test15.j(232)   if (b2 | fb1 == 0x1F) println (134); else println (999);
L1606:
        LD    A,(05001H)
L1607:
        OR    A,28
L1608:
        SUB   A,31
L1609:
        JP    NZ,L1613
L1610:
        LD    A,134
L1611:
        CALL  writeLineA
L1612:
        JP    L1616
L1613:
        LD    HL,999
L1614:
        CALL  writeLineHL
L1615:
        ;;test15.j(233)   if (b2 ^ fb1 == 0x1B) println (135); else println (999);
L1616:
        LD    A,(05001H)
L1617:
        XOR   A,28
L1618:
        SUB   A,27
L1619:
        JP    NZ,L1623
L1620:
        LD    A,135
L1621:
        CALL  writeLineA
L1622:
        JP    L1627
L1623:
        LD    HL,999
L1624:
        CALL  writeLineHL
L1625:
        ;;test15.j(234)   //var word/final var word
L1626:
        ;;test15.j(235)   if (w2 & fw1 == 0x0224) println (136); else println (999);
L1627:
        LD    HL,(05004H)
L1628:
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
L1629:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1630:
        JP    NZ,L1634
L1631:
        LD    A,136
L1632:
        CALL  writeLineA
L1633:
        JP    L1637
L1634:
        LD    HL,999
L1635:
        CALL  writeLineHL
L1636:
        ;;test15.j(236)   if (w2 | fw1 == 0x133C) println (137); else println (999);
L1637:
        LD    HL,(05004H)
L1638:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1639:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1640:
        JP    NZ,L1644
L1641:
        LD    A,137
L1642:
        CALL  writeLineA
L1643:
        JP    L1647
L1644:
        LD    HL,999
L1645:
        CALL  writeLineHL
L1646:
        ;;test15.j(237)   if (w2 ^ fw1 == 0x1118) println (138); else println (999);
L1647:
        LD    HL,(05004H)
L1648:
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
L1649:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1650:
        JP    NZ,L1654
L1651:
        LD    A,138
L1652:
        CALL  writeLineA
L1653:
        JP    L1658
L1654:
        LD    HL,999
L1655:
        CALL  writeLineHL
L1656:
        ;;test15.j(238)   //var byte/final var word
L1657:
        ;;test15.j(239)   if (b1 & fw2 == 0x0014) println (139); else println (999);
L1658:
        LD    A,(05000H)
L1659:
        LD    L,A
        LD    H,0
L1660:
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
L1661:
        LD    A,20
L1662:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1663:
        JP    NZ,L1667
L1664:
        LD    A,139
L1665:
        CALL  writeLineA
L1666:
        JP    L1670
L1667:
        LD    HL,999
L1668:
        CALL  writeLineHL
L1669:
        ;;test15.j(240)   if (b1 | fw2 == 0x123C) println (140); else println (999);
L1670:
        LD    A,(05000H)
L1671:
        LD    L,A
        LD    H,0
L1672:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1673:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1674:
        JP    NZ,L1678
L1675:
        LD    A,140
L1676:
        CALL  writeLineA
L1677:
        JP    L1681
L1678:
        LD    HL,999
L1679:
        CALL  writeLineHL
L1680:
        ;;test15.j(241)   if (b1 ^ fw2 == 0x1228) println (141); else println (999);
L1681:
        LD    A,(05000H)
L1682:
        LD    L,A
        LD    H,0
L1683:
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
L1684:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1685:
        JP    NZ,L1689
L1686:
        LD    A,141
L1687:
        CALL  writeLineA
L1688:
        JP    L1693
L1689:
        LD    HL,999
L1690:
        CALL  writeLineHL
L1691:
        ;;test15.j(242)   //var word/final var byte
L1692:
        ;;test15.j(243)   if (w2 & fb1 == 0x0014) println (142); else println (999);
L1693:
        LD    HL,(05004H)
L1694:
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
L1695:
        LD    A,20
L1696:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1697:
        JP    NZ,L1701
L1698:
        LD    A,142
L1699:
        CALL  writeLineA
L1700:
        JP    L1704
L1701:
        LD    HL,999
L1702:
        CALL  writeLineHL
L1703:
        ;;test15.j(244)   if (w2 | fb1 == 0x123C) println (143); else println (999);
L1704:
        LD    HL,(05004H)
L1705:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1706:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1707:
        JP    NZ,L1711
L1708:
        LD    A,143
L1709:
        CALL  writeLineA
L1710:
        JP    L1714
L1711:
        LD    HL,999
L1712:
        CALL  writeLineHL
L1713:
        ;;test15.j(245)   if (w2 ^ fb1 == 0x1228) println (144); else println (999);
L1714:
        LD    HL,(05004H)
L1715:
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
L1716:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1717:
        JP    NZ,L1721
L1718:
        LD    A,144
L1719:
        CALL  writeLineA
L1720:
        JP    L1728
L1721:
        LD    HL,999
L1722:
        CALL  writeLineHL
L1723:
        ;;test15.j(246) 
L1724:
        ;;test15.j(247)   //final var/constant
L1725:
        ;;test15.j(248)   //******************
L1726:
        ;;test15.j(249)   //final var byte/constant byte
L1727:
        ;;test15.j(250)   if (b2 & 0x1C == 0x04) println (145); else println (999);
L1728:
        LD    A,(05001H)
L1729:
        AND   A,28
L1730:
        SUB   A,4
L1731:
        JP    NZ,L1735
L1732:
        LD    A,145
L1733:
        CALL  writeLineA
L1734:
        JP    L1738
L1735:
        LD    HL,999
L1736:
        CALL  writeLineHL
L1737:
        ;;test15.j(251)   if (b2 | 0x1C == 0x1F) println (146); else println (999);
L1738:
        LD    A,(05001H)
L1739:
        OR    A,28
L1740:
        SUB   A,31
L1741:
        JP    NZ,L1745
L1742:
        LD    A,146
L1743:
        CALL  writeLineA
L1744:
        JP    L1748
L1745:
        LD    HL,999
L1746:
        CALL  writeLineHL
L1747:
        ;;test15.j(252)   if (b2 ^ 0x1C == 0x1B) println (147); else println (999);
L1748:
        LD    A,(05001H)
L1749:
        XOR   A,28
L1750:
        SUB   A,27
L1751:
        JP    NZ,L1755
L1752:
        LD    A,147
L1753:
        CALL  writeLineA
L1754:
        JP    L1759
L1755:
        LD    HL,999
L1756:
        CALL  writeLineHL
L1757:
        ;;test15.j(253)   //final var word/constant word
L1758:
        ;;test15.j(254)   if (w2 & 0x032C == 0x0224) println (148); else println (999);
L1759:
        LD    HL,(05004H)
L1760:
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
L1761:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1762:
        JP    NZ,L1766
L1763:
        LD    A,148
L1764:
        CALL  writeLineA
L1765:
        JP    L1769
L1766:
        LD    HL,999
L1767:
        CALL  writeLineHL
L1768:
        ;;test15.j(255)   if (w2 | 0x032C == 0x133C) println (149); else println (999);
L1769:
        LD    HL,(05004H)
L1770:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1771:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1772:
        JP    NZ,L1776
L1773:
        LD    A,149
L1774:
        CALL  writeLineA
L1775:
        JP    L1779
L1776:
        LD    HL,999
L1777:
        CALL  writeLineHL
L1778:
        ;;test15.j(256)   if (w2 ^ 0x032C == 0x1118) println (150); else println (999);
L1779:
        LD    HL,(05004H)
L1780:
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
L1781:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1782:
        JP    NZ,L1786
L1783:
        LD    A,150
L1784:
        CALL  writeLineA
L1785:
        JP    L1790
L1786:
        LD    HL,999
L1787:
        CALL  writeLineHL
L1788:
        ;;test15.j(257)   //final var byte/constant word
L1789:
        ;;test15.j(258)   if (b1 & 0x1234 == 0x0014) println (151); else println (999);
L1790:
        LD    A,(05000H)
L1791:
        LD    L,A
        LD    H,0
L1792:
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
L1793:
        LD    A,20
L1794:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1795:
        JP    NZ,L1799
L1796:
        LD    A,151
L1797:
        CALL  writeLineA
L1798:
        JP    L1802
L1799:
        LD    HL,999
L1800:
        CALL  writeLineHL
L1801:
        ;;test15.j(259)   if (b1 | 0x1234 == 0x123C) println (152); else println (999);
L1802:
        LD    A,(05000H)
L1803:
        LD    L,A
        LD    H,0
L1804:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1805:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1806:
        JP    NZ,L1810
L1807:
        LD    A,152
L1808:
        CALL  writeLineA
L1809:
        JP    L1813
L1810:
        LD    HL,999
L1811:
        CALL  writeLineHL
L1812:
        ;;test15.j(260)   if (b1 ^ 0x1234 == 0x1228) println (153); else println (999);
L1813:
        LD    A,(05000H)
L1814:
        LD    L,A
        LD    H,0
L1815:
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
L1816:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1817:
        JP    NZ,L1821
L1818:
        LD    A,153
L1819:
        CALL  writeLineA
L1820:
        JP    L1825
L1821:
        LD    HL,999
L1822:
        CALL  writeLineHL
L1823:
        ;;test15.j(261)   //final var word/constant byte
L1824:
        ;;test15.j(262)   if (w2 & 0x1C == 0x0014) println (154); else println (999);
L1825:
        LD    HL,(05004H)
L1826:
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
L1827:
        LD    A,20
L1828:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1829:
        JP    NZ,L1833
L1830:
        LD    A,154
L1831:
        CALL  writeLineA
L1832:
        JP    L1836
L1833:
        LD    HL,999
L1834:
        CALL  writeLineHL
L1835:
        ;;test15.j(263)   if (w2 | 0x1C == 0x123C) println (155); else println (999);
L1836:
        LD    HL,(05004H)
L1837:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1838:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1839:
        JP    NZ,L1843
L1840:
        LD    A,155
L1841:
        CALL  writeLineA
L1842:
        JP    L1846
L1843:
        LD    HL,999
L1844:
        CALL  writeLineHL
L1845:
        ;;test15.j(264)   if (w2 ^ 0x1C == 0x1228) println (156); else println (999);
L1846:
        LD    HL,(05004H)
L1847:
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
L1848:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1849:
        JP    NZ,L1853
L1850:
        LD    A,156
L1851:
        CALL  writeLineA
L1852:
        JP    L1860
L1853:
        LD    HL,999
L1854:
        CALL  writeLineHL
L1855:
        ;;test15.j(265) 
L1856:
        ;;test15.j(266)   //final var/acc
L1857:
        ;;test15.j(267)   //*************
L1858:
        ;;test15.j(268)   //final var byte/acc byte
L1859:
        ;;test15.j(269)   if (b2 & (0x10 + 0x0C) == 0x04) println (157); else println (999);
L1860:
        LD    A,(05001H)
L1861:
        PUSH  AF
        LD    A,16
L1862:
        ADD   A,12
L1863:
        POP   BC
        AND   A,B
L1864:
        SUB   A,4
L1865:
        JP    NZ,L1869
L1866:
        LD    A,157
L1867:
        CALL  writeLineA
L1868:
        JP    L1872
L1869:
        LD    HL,999
L1870:
        CALL  writeLineHL
L1871:
        ;;test15.j(270)   if (b2 | (0x10 + 0x0C) == 0x1F) println (158); else println (999);
L1872:
        LD    A,(05001H)
L1873:
        PUSH  AF
        LD    A,16
L1874:
        ADD   A,12
L1875:
        POP   BC
        OR    A,B
L1876:
        SUB   A,31
L1877:
        JP    NZ,L1881
L1878:
        LD    A,158
L1879:
        CALL  writeLineA
L1880:
        JP    L1884
L1881:
        LD    HL,999
L1882:
        CALL  writeLineHL
L1883:
        ;;test15.j(271)   if (b2 ^ (0x10 + 0x0C) == 0x1B) println (159); else println (999);
L1884:
        LD    A,(05001H)
L1885:
        PUSH  AF
        LD    A,16
L1886:
        ADD   A,12
L1887:
        POP   BC
        XOR   A,B
L1888:
        SUB   A,27
L1889:
        JP    NZ,L1893
L1890:
        LD    A,159
L1891:
        CALL  writeLineA
L1892:
        JP    L1897
L1893:
        LD    HL,999
L1894:
        CALL  writeLineHL
L1895:
        ;;test15.j(272)   //final var word/acc word
L1896:
        ;;test15.j(273)   if (w2 & 0x0100 + 0x022C == 0x0224) println (160); else println (999);
L1897:
        LD    HL,(05004H)
L1898:
        PUSH  HL
        LD    HL,256
L1899:
        LD    DE,556
        ADD   HL,DE
L1900:
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
L1901:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1902:
        JP    NZ,L1906
L1903:
        LD    A,160
L1904:
        CALL  writeLineA
L1905:
        JP    L1909
L1906:
        LD    HL,999
L1907:
        CALL  writeLineHL
L1908:
        ;;test15.j(274)   if (w2 | 0x0100 + 0x022C == 0x133C) println (161); else println (999);
L1909:
        LD    HL,(05004H)
L1910:
        PUSH  HL
        LD    HL,256
L1911:
        LD    DE,556
        ADD   HL,DE
L1912:
        POP   DE
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1913:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1914:
        JP    NZ,L1918
L1915:
        LD    A,161
L1916:
        CALL  writeLineA
L1917:
        JP    L1921
L1918:
        LD    HL,999
L1919:
        CALL  writeLineHL
L1920:
        ;;test15.j(275)   if (w2 ^ 0x0100 + 0x022C == 0x1118) println (162); else println (999);
L1921:
        LD    HL,(05004H)
L1922:
        PUSH  HL
        LD    HL,256
L1923:
        LD    DE,556
        ADD   HL,DE
L1924:
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
L1925:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1926:
        JP    NZ,L1930
L1927:
        LD    A,162
L1928:
        CALL  writeLineA
L1929:
        JP    L1934
L1930:
        LD    HL,999
L1931:
        CALL  writeLineHL
L1932:
        ;;test15.j(276)   //final var byte/acc word
L1933:
        ;;test15.j(277)   if (b1 & 0x1000 + 0x0234 == 0x0014) println (163); else println (999);
L1934:
        LD    A,(05000H)
L1935:
        LD    HL,4096
L1936:
        LD    DE,564
        ADD   HL,DE
L1937:
        AND   A,L
        LD    L,A
        LD    H,0
L1938:
        LD    A,20
L1939:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1940:
        JP    NZ,L1944
L1941:
        LD    A,163
L1942:
        CALL  writeLineA
L1943:
        JP    L1947
L1944:
        LD    HL,999
L1945:
        CALL  writeLineHL
L1946:
        ;;test15.j(278)   if (b1 | 0x1000 + 0x0234 == 0x123C) println (164); else println (999);
L1947:
        LD    A,(05000H)
L1948:
        LD    HL,4096
L1949:
        LD    DE,564
        ADD   HL,DE
L1950:
        OR    A,L
        LD    L,A
L1951:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1952:
        JP    NZ,L1956
L1953:
        LD    A,164
L1954:
        CALL  writeLineA
L1955:
        JP    L1959
L1956:
        LD    HL,999
L1957:
        CALL  writeLineHL
L1958:
        ;;test15.j(279)   if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (165); else println (999);
L1959:
        LD    A,(05000H)
L1960:
        LD    HL,4096
L1961:
        LD    DE,564
        ADD   HL,DE
L1962:
        XOR   A,L
        LD    L,A
L1963:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1964:
        JP    NZ,L1968
L1965:
        LD    A,165
L1966:
        CALL  writeLineA
L1967:
        JP    L1972
L1968:
        LD    HL,999
L1969:
        CALL  writeLineHL
L1970:
        ;;test15.j(280)   //final var word/acc byte
L1971:
        ;;test15.j(281)   if (w2 & 0x10 + 0x0C == 0x0014) println (166); else println (999);
L1972:
        LD    HL,(05004H)
L1973:
        LD    A,16
L1974:
        ADD   A,12
L1975:
        AND   A,L
        LD    L,A
        LD    H,0
L1976:
        LD    A,20
L1977:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1978:
        JP    NZ,L1982
L1979:
        LD    A,166
L1980:
        CALL  writeLineA
L1981:
        JP    L1985
L1982:
        LD    HL,999
L1983:
        CALL  writeLineHL
L1984:
        ;;test15.j(282)   if (w2 | 0x10 + 0x0C == 0x123C) println (167); else println (999);
L1985:
        LD    HL,(05004H)
L1986:
        LD    A,16
L1987:
        ADD   A,12
L1988:
        OR    A,L
        LD    L,A
L1989:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1990:
        JP    NZ,L1994
L1991:
        LD    A,167
L1992:
        CALL  writeLineA
L1993:
        JP    L1997
L1994:
        LD    HL,999
L1995:
        CALL  writeLineHL
L1996:
        ;;test15.j(283)   if (w2 ^ 0x10 + 0x0C == 0x1228) println (168); else println (999);
L1997:
        LD    HL,(05004H)
L1998:
        LD    A,16
L1999:
        ADD   A,12
L2000:
        XOR   A,L
        LD    L,A
L2001:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2002:
        JP    NZ,L2006
L2003:
        LD    A,168
L2004:
        CALL  writeLineA
L2005:
        JP    L2013
L2006:
        LD    HL,999
L2007:
        CALL  writeLineHL
L2008:
        ;;test15.j(284) 
L2009:
        ;;test15.j(285)   //final var/var
L2010:
        ;;test15.j(286)   //*************
L2011:
        ;;test15.j(287)   //final var byte/var byte
L2012:
        ;;test15.j(288)   if (b2 & b1 == 0x04) println (169); else println (999);
L2013:
        LD    A,(05001H)
L2014:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L2015:
        SUB   A,4
L2016:
        JP    NZ,L2020
L2017:
        LD    A,169
L2018:
        CALL  writeLineA
L2019:
        JP    L2023
L2020:
        LD    HL,999
L2021:
        CALL  writeLineHL
L2022:
        ;;test15.j(289)   if (b2 | b1 == 0x1F) println (170); else println (999);
L2023:
        LD    A,(05001H)
L2024:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L2025:
        SUB   A,31
L2026:
        JP    NZ,L2030
L2027:
        LD    A,170
L2028:
        CALL  writeLineA
L2029:
        JP    L2033
L2030:
        LD    HL,999
L2031:
        CALL  writeLineHL
L2032:
        ;;test15.j(290)   if (b2 ^ b1 == 0x1B) println (171); else println (999);
L2033:
        LD    A,(05001H)
L2034:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L2035:
        SUB   A,27
L2036:
        JP    NZ,L2040
L2037:
        LD    A,171
L2038:
        CALL  writeLineA
L2039:
        JP    L2044
L2040:
        LD    HL,999
L2041:
        CALL  writeLineHL
L2042:
        ;;test15.j(291)   //final var word/var word
L2043:
        ;;test15.j(292)   if (w2 & w1 == 0x0224) println (172); else println (999);
L2044:
        LD    HL,(05004H)
L2045:
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
L2046:
        LD    DE,548
        OR    A
        SBC   HL,DE
L2047:
        JP    NZ,L2051
L2048:
        LD    A,172
L2049:
        CALL  writeLineA
L2050:
        JP    L2054
L2051:
        LD    HL,999
L2052:
        CALL  writeLineHL
L2053:
        ;;test15.j(293)   if (w2 | w1 == 0x133C) println (173); else println (999);
L2054:
        LD    HL,(05004H)
L2055:
        LD    DE,(05002H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2056:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L2057:
        JP    NZ,L2061
L2058:
        LD    A,173
L2059:
        CALL  writeLineA
L2060:
        JP    L2064
L2061:
        LD    HL,999
L2062:
        CALL  writeLineHL
L2063:
        ;;test15.j(294)   if (w2 ^ w1 == 0x1118) println (174); else println (999);
L2064:
        LD    HL,(05004H)
L2065:
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
L2066:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L2067:
        JP    NZ,L2071
L2068:
        LD    A,174
L2069:
        CALL  writeLineA
L2070:
        JP    L2075
L2071:
        LD    HL,999
L2072:
        CALL  writeLineHL
L2073:
        ;;test15.j(295)   //final var byte/var word
L2074:
        ;;test15.j(296)   if (b1 & w2 == 0x0014) println (175); else println (999);
L2075:
        LD    A,(05000H)
L2076:
        LD    L,A
        LD    H,0
L2077:
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
L2078:
        LD    A,20
L2079:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2080:
        JP    NZ,L2084
L2081:
        LD    A,175
L2082:
        CALL  writeLineA
L2083:
        JP    L2087
L2084:
        LD    HL,999
L2085:
        CALL  writeLineHL
L2086:
        ;;test15.j(297)   if (b1 | w2 == 0x123C) println (176); else println (999);
L2087:
        LD    A,(05000H)
L2088:
        LD    L,A
        LD    H,0
L2089:
        LD    DE,(05004H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2090:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2091:
        JP    NZ,L2095
L2092:
        LD    A,176
L2093:
        CALL  writeLineA
L2094:
        JP    L2098
L2095:
        LD    HL,999
L2096:
        CALL  writeLineHL
L2097:
        ;;test15.j(298)   if (b1 ^ w2 == 0x1228) println (177); else println (999);
L2098:
        LD    A,(05000H)
L2099:
        LD    L,A
        LD    H,0
L2100:
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
L2101:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2102:
        JP    NZ,L2106
L2103:
        LD    A,177
L2104:
        CALL  writeLineA
L2105:
        JP    L2110
L2106:
        LD    HL,999
L2107:
        CALL  writeLineHL
L2108:
        ;;test15.j(299)   //final var word/var byte
L2109:
        ;;test15.j(300)   if (w2 & b1 == 0x0014) println (178); else println (999);
L2110:
        LD    HL,(05004H)
L2111:
        LD    B,A
        LD    A,(05000H)
        AND   A,L
        LD    L,A
        LD    A,B
        LD    H,0
L2112:
        LD    A,20
L2113:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2114:
        JP    NZ,L2118
L2115:
        LD    A,178
L2116:
        CALL  writeLineA
L2117:
        JP    L2121
L2118:
        LD    HL,999
L2119:
        CALL  writeLineHL
L2120:
        ;;test15.j(301)   if (w2 | b1 == 0x123C) println (179); else println (999);
L2121:
        LD    HL,(05004H)
L2122:
        LD    B,A
        LD    A,(05000H)
        OR    A,L
        LD    L,A
        LD    A,B
L2123:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2124:
        JP    NZ,L2128
L2125:
        LD    A,179
L2126:
        CALL  writeLineA
L2127:
        JP    L2131
L2128:
        LD    HL,999
L2129:
        CALL  writeLineHL
L2130:
        ;;test15.j(302)   if (w2 ^ b1 == 0x1228) println (180); else println (999);
L2131:
        LD    HL,(05004H)
L2132:
        LD    B,A
        LD    A,(05000H)
        XOR   A,L
        LD    L,A
        LD    A,B
L2133:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2134:
        JP    NZ,L2138
L2135:
        LD    A,180
L2136:
        CALL  writeLineA
L2137:
        JP    L2145
L2138:
        LD    HL,999
L2139:
        CALL  writeLineHL
L2140:
        ;;test15.j(303) 
L2141:
        ;;test15.j(304)   //final var/final var
L2142:
        ;;test15.j(305)   //*******************
L2143:
        ;;test15.j(306)   //final var byte/final var byte
L2144:
        ;;test15.j(307)   if (fb2 & fb1 == 0x04) println (181); else println (999);
L2145:
        LD    A,7
L2146:
        AND   A,28
L2147:
        SUB   A,4
L2148:
        JP    NZ,L2152
L2149:
        LD    A,181
L2150:
        CALL  writeLineA
L2151:
        JP    L2155
L2152:
        LD    HL,999
L2153:
        CALL  writeLineHL
L2154:
        ;;test15.j(308)   if (fb2 | fb1 == 0x1F) println (182); else println (999);
L2155:
        LD    A,7
L2156:
        OR    A,28
L2157:
        SUB   A,31
L2158:
        JP    NZ,L2162
L2159:
        LD    A,182
L2160:
        CALL  writeLineA
L2161:
        JP    L2165
L2162:
        LD    HL,999
L2163:
        CALL  writeLineHL
L2164:
        ;;test15.j(309)   if (fb2 ^ fb1 == 0x1B) println (183); else println (999);
L2165:
        LD    A,7
L2166:
        XOR   A,28
L2167:
        SUB   A,27
L2168:
        JP    NZ,L2172
L2169:
        LD    A,183
L2170:
        CALL  writeLineA
L2171:
        JP    L2176
L2172:
        LD    HL,999
L2173:
        CALL  writeLineHL
L2174:
        ;;test15.j(310)   //final var word/final var word
L2175:
        ;;test15.j(311)   if (fw2 & fw1 == 0x0224) println (184); else println (999);
L2176:
        LD    HL,4660
L2177:
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
L2178:
        LD    DE,548
        OR    A
        SBC   HL,DE
L2179:
        JP    NZ,L2183
L2180:
        LD    A,184
L2181:
        CALL  writeLineA
L2182:
        JP    L2186
L2183:
        LD    HL,999
L2184:
        CALL  writeLineHL
L2185:
        ;;test15.j(312)   if (fw2 | fw1 == 0x133C) println (185); else println (999);
L2186:
        LD    HL,4660
L2187:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2188:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L2189:
        JP    NZ,L2193
L2190:
        LD    A,185
L2191:
        CALL  writeLineA
L2192:
        JP    L2196
L2193:
        LD    HL,999
L2194:
        CALL  writeLineHL
L2195:
        ;;test15.j(313)   if (fw2 ^ fw1 == 0x1118) println (186); else println (999);
L2196:
        LD    HL,4660
L2197:
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
L2198:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L2199:
        JP    NZ,L2203
L2200:
        LD    A,186
L2201:
        CALL  writeLineA
L2202:
        JP    L2207
L2203:
        LD    HL,999
L2204:
        CALL  writeLineHL
L2205:
        ;;test15.j(314)   //final var byte/final var word
L2206:
        ;;test15.j(315)   if (fb1 & fw2 == 0x0014) println (187); else println (999);
L2207:
        LD    A,28
L2208:
        LD    L,A
        LD    H,0
L2209:
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
L2210:
        LD    A,20
L2211:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2212:
        JP    NZ,L2216
L2213:
        LD    A,187
L2214:
        CALL  writeLineA
L2215:
        JP    L2219
L2216:
        LD    HL,999
L2217:
        CALL  writeLineHL
L2218:
        ;;test15.j(316)   if (fb1 | fw2 == 0x123C) println (188); else println (999);
L2219:
        LD    A,28
L2220:
        LD    L,A
        LD    H,0
L2221:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2222:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2223:
        JP    NZ,L2227
L2224:
        LD    A,188
L2225:
        CALL  writeLineA
L2226:
        JP    L2230
L2227:
        LD    HL,999
L2228:
        CALL  writeLineHL
L2229:
        ;;test15.j(317)   if (fb1 ^ fw2 == 0x1228) println (189); else println (999);
L2230:
        LD    A,28
L2231:
        LD    L,A
        LD    H,0
L2232:
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
L2233:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2234:
        JP    NZ,L2238
L2235:
        LD    A,189
L2236:
        CALL  writeLineA
L2237:
        JP    L2242
L2238:
        LD    HL,999
L2239:
        CALL  writeLineHL
L2240:
        ;;test15.j(318)   //final var word/final var byte
L2241:
        ;;test15.j(319)   if (fw2 & fb1 == 0x0014) println (190); else println (999);
L2242:
        LD    HL,4660
L2243:
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
L2244:
        LD    A,20
L2245:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2246:
        JP    NZ,L2250
L2247:
        LD    A,190
L2248:
        CALL  writeLineA
L2249:
        JP    L2253
L2250:
        LD    HL,999
L2251:
        CALL  writeLineHL
L2252:
        ;;test15.j(320)   if (fw2 | fb1 == 0x123C) println (191); else println (999);
L2253:
        LD    HL,4660
L2254:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2255:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2256:
        JP    NZ,L2260
L2257:
        LD    A,191
L2258:
        CALL  writeLineA
L2259:
        JP    L2263
L2260:
        LD    HL,999
L2261:
        CALL  writeLineHL
L2262:
        ;;test15.j(321)   if (fw2 ^ fb1 == 0x1228) println (192); else println (999);
L2263:
        LD    HL,4660
L2264:
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
L2265:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2266:
        JP    NZ,L2270
L2267:
        LD    A,192
L2268:
        CALL  writeLineA
L2269:
        JP    L2274
L2270:
        LD    HL,999
L2271:
        CALL  writeLineHL
L2272:
        ;;test15.j(322) 
L2273:
        ;;test15.j(323)   println("Klaar");
L2274:
        LD    HL,2278
L2275:
        CALL  writeLineStr
L2276:
        ;;test15.j(324) }
L2277:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L2278:
        .ASCIZ  "Klaar"
