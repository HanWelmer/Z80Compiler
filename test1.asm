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
        ;;test1.j(0) /* Program to test generated Z80 assembler code */
L1:
        ;;test1.j(1) class TestWhile {
L2:
        ;;test1.j(2)   byte b = 0;
L3:
        LD    A,0
L4:
        LD    (05000H),A
L5:
        ;;test1.j(3)   byte b2 = 32;
L6:
        LD    A,32
L7:
        LD    (05001H),A
L8:
        ;;test1.j(4)   word i = 110;
L9:
        LD    A,110
L10:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L11:
        ;;test1.j(5)   word i2 = 105;
L12:
        LD    A,105
L13:
        LD    L,A
        LD    H,0
        LD    (05004H),HL
L14:
        ;;test1.j(6)   word p = 12;
L15:
        LD    A,12
L16:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L17:
        ;;test1.j(7)   
L18:
        ;;test1.j(8)   /*Possible operand types: 
L19:
        ;;test1.j(9)    * constant, acc, var, stack8, stack16
L20:
        ;;test1.j(10)    *Possible datatype combinations:
L21:
        ;;test1.j(11)    * byte - byte
L22:
        ;;test1.j(12)    * byte - integer
L23:
        ;;test1.j(13)    * integer - byte
L24:
        ;;test1.j(14)    * integer - integer
L25:
        ;;test1.j(15)   */
L26:
        ;;test1.j(16) 
L27:
        ;;test1.j(17)   println(0);
L28:
        LD    A,0
L29:
        CALL  writeLineA
L30:
        ;;test1.j(18) 
L31:
        ;;test1.j(19)   /************************/
L32:
        ;;test1.j(20)   // global variable within while scope
L33:
        ;;test1.j(21)   b++;
L34:
        LD    HL,(05000H)
        INC   (HL)
L35:
        ;;test1.j(22)   println (b);
L36:
        LD    A,(05000H)
L37:
        CALL  writeLineA
L38:
        ;;test1.j(23)   while (b < 2) {
L39:
        LD    A,(05000H)
L40:
        SUB   A,2
L41:
        JP    NC,L67
L42:
        ;;test1.j(24)     b++;
L43:
        LD    HL,(05000H)
        INC   (HL)
L44:
        ;;test1.j(25)     word j = 1001;
L45:
        LD    HL,1001
L46:
        LD    (05008H),HL
L47:
        ;;test1.j(26)     byte c = b;
L48:
        LD    A,(05000H)
L49:
        LD    (0500AH),A
L50:
        ;;test1.j(27)     byte d = c;
L51:
        LD    A,(0500AH)
L52:
        LD    (0500BH),A
L53:
        ;;test1.j(28)     println (c);
L54:
        LD    A,(0500AH)
L55:
        CALL  writeLineA
L56:
        ;;test1.j(29)   }
L57:
        JP    L39
L58:
        ;;test1.j(30) 
L59:
        ;;test1.j(31)   /************************/
L60:
        ;;test1.j(32)   // constant - constant
L61:
        ;;test1.j(33)   // not relevant
L62:
        ;;test1.j(34) 
L63:
        ;;test1.j(35)   /************************/
L64:
        ;;test1.j(36)   // constant - acc
L65:
        ;;test1.j(37)   // byte - byte
L66:
        ;;test1.j(38)   b = 3;
L67:
        LD    A,3
L68:
        LD    (05000H),A
L69:
        ;;test1.j(39)   while (3 == b+0) { println (b); b++; }
L70:
        LD    A,(05000H)
L71:
        ADD   A,0
L72:
        SUB   A,3
L73:
        JP    NZ,L79
L74:
        LD    A,(05000H)
L75:
        CALL  writeLineA
L76:
        LD    HL,(05000H)
        INC   (HL)
L77:
        JP    L70
L78:
        ;;test1.j(40)   while (4 != b+0) { println (b); b++; }
L79:
        LD    A,(05000H)
L80:
        ADD   A,0
L81:
        SUB   A,4
L82:
        JP    Z,L88
L83:
        LD    A,(05000H)
L84:
        CALL  writeLineA
L85:
        LD    HL,(05000H)
        INC   (HL)
L86:
        JP    L79
L87:
        ;;test1.j(41)   while (6 > b+0) { println (b); b++; }
L88:
        LD    A,(05000H)
L89:
        ADD   A,0
L90:
        SUB   A,6
L91:
        JP    NC,L97
L92:
        LD    A,(05000H)
L93:
        CALL  writeLineA
L94:
        LD    HL,(05000H)
        INC   (HL)
L95:
        JP    L88
L96:
        ;;test1.j(42)   while (7 >= b+0) { println (b); b++; }
L97:
        LD    A,(05000H)
L98:
        ADD   A,0
L99:
        SUB   A,7
L100:
        JR    Z,$+5
        JP    C,L106
L101:
        LD    A,(05000H)
L102:
        CALL  writeLineA
L103:
        LD    HL,(05000H)
        INC   (HL)
L104:
        JP    L97
L105:
        ;;test1.j(43)   p=8;
L106:
        LD    A,8
L107:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L108:
        ;;test1.j(44)   while (6 <  b+0) { println (p); p++; b--; }
L109:
        LD    A,(05000H)
L110:
        ADD   A,0
L111:
        SUB   A,6
L112:
        JP    Z,L119
L113:
        LD    HL,(05006H)
L114:
        CALL  writeLineHL
L115:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L116:
        LD    HL,(05000H)
        DEC   (HL)
L117:
        JP    L109
L118:
        ;;test1.j(45)   while (5 <= b+0) { println (p); p++; b--; }
L119:
        LD    A,(05000H)
L120:
        ADD   A,0
L121:
        SUB   A,5
L122:
        JP    C,L132
L123:
        LD    HL,(05006H)
L124:
        CALL  writeLineHL
L125:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L126:
        LD    HL,(05000H)
        DEC   (HL)
L127:
        JP    L119
L128:
        ;;test1.j(46)   
L129:
        ;;test1.j(47)   // constant - acc
L130:
        ;;test1.j(48)   // byte - integer
L131:
        ;;test1.j(49)   i=12;
L132:
        LD    A,12
L133:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L134:
        ;;test1.j(50)   while (12 == i+0) { println (i); i++; }
L135:
        LD    HL,(05002H)
L136:
        LD    DE,0
        ADD   HL,DE
L137:
        LD    A,12
L138:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L139:
        JP    NZ,L145
L140:
        LD    HL,(05002H)
L141:
        CALL  writeLineHL
L142:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L143:
        JP    L135
L144:
        ;;test1.j(51)   while (15 != i+0) { println (i); i++; }
L145:
        LD    HL,(05002H)
L146:
        LD    DE,0
        ADD   HL,DE
L147:
        LD    A,15
L148:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L149:
        JP    Z,L155
L150:
        LD    HL,(05002H)
L151:
        CALL  writeLineHL
L152:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L153:
        JP    L145
L154:
        ;;test1.j(52)   while (17 > i+0) { println (i); i++; }
L155:
        LD    HL,(05002H)
L156:
        LD    DE,0
        ADD   HL,DE
L157:
        LD    A,17
L158:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L159:
        JP    Z,L165
L160:
        LD    HL,(05002H)
L161:
        CALL  writeLineHL
L162:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L163:
        JP    L155
L164:
        ;;test1.j(53)   while (18 >= i+0) { println (i); i++; }
L165:
        LD    HL,(05002H)
L166:
        LD    DE,0
        ADD   HL,DE
L167:
        LD    A,18
L168:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L169:
        JP    C,L175
L170:
        LD    HL,(05002H)
L171:
        CALL  writeLineHL
L172:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L173:
        JP    L165
L174:
        ;;test1.j(54)   p=i;
L175:
        LD    HL,(05002H)
L176:
        LD    (05006H),HL
L177:
        ;;test1.j(55)   while (17 <  i+0) { println (p); i--; p++; }
L178:
        LD    HL,(05002H)
L179:
        LD    DE,0
        ADD   HL,DE
L180:
        LD    A,17
L181:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L182:
        JP    NC,L189
L183:
        LD    HL,(05006H)
L184:
        CALL  writeLineHL
L185:
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
L186:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L187:
        JP    L178
L188:
        ;;test1.j(56)   while (16 <= i+0) { println (p); i--; p++; }
L189:
        LD    HL,(05002H)
L190:
        LD    DE,0
        ADD   HL,DE
L191:
        LD    A,16
L192:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L193:
        JR    Z,$+5
        JP    C,L207
L194:
        LD    HL,(05006H)
L195:
        CALL  writeLineHL
L196:
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
L197:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L198:
        JP    L189
L199:
        ;;test1.j(57) 
L200:
        ;;test1.j(58)   // constant - acc
L201:
        ;;test1.j(59)   // integer - byte
L202:
        ;;test1.j(60)   // not relevant
L203:
        ;;test1.j(61) 
L204:
        ;;test1.j(62)   // constant - acc
L205:
        ;;test1.j(63)   // integer - integer
L206:
        ;;test1.j(64)   i=23;
L207:
        LD    A,23
L208:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L209:
        ;;test1.j(65)   while (23 == i+0) { println (i); i++; }
L210:
        LD    HL,(05002H)
L211:
        LD    DE,0
        ADD   HL,DE
L212:
        LD    A,23
L213:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L214:
        JP    NZ,L220
L215:
        LD    HL,(05002H)
L216:
        CALL  writeLineHL
L217:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L218:
        JP    L210
L219:
        ;;test1.j(66)   while (26 != i+0) { println (i); i++; }
L220:
        LD    HL,(05002H)
L221:
        LD    DE,0
        ADD   HL,DE
L222:
        LD    A,26
L223:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L224:
        JP    Z,L230
L225:
        LD    HL,(05002H)
L226:
        CALL  writeLineHL
L227:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L228:
        JP    L220
L229:
        ;;test1.j(67)   while (28 > i+0) { println (i); i++; }
L230:
        LD    HL,(05002H)
L231:
        LD    DE,0
        ADD   HL,DE
L232:
        LD    A,28
L233:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L234:
        JP    Z,L240
L235:
        LD    HL,(05002H)
L236:
        CALL  writeLineHL
L237:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L238:
        JP    L230
L239:
        ;;test1.j(68)   while (29 >= i+0) { println (i); i++; }
L240:
        LD    HL,(05002H)
L241:
        LD    DE,0
        ADD   HL,DE
L242:
        LD    A,29
L243:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L244:
        JP    C,L250
L245:
        LD    HL,(05002H)
L246:
        CALL  writeLineHL
L247:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L248:
        JP    L240
L249:
        ;;test1.j(69)   p=i;
L250:
        LD    HL,(05002H)
L251:
        LD    (05006H),HL
L252:
        ;;test1.j(70)   while (28 <  i+0) { println (p); p++; i--; }
L253:
        LD    HL,(05002H)
L254:
        LD    DE,0
        ADD   HL,DE
L255:
        LD    A,28
L256:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L257:
        JP    NC,L264
L258:
        LD    HL,(05006H)
L259:
        CALL  writeLineHL
L260:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L261:
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
L262:
        JP    L253
L263:
        ;;test1.j(71)   while (27 <= i+0) { println (p); p++; i--; }
L264:
        LD    HL,(05002H)
L265:
        LD    DE,0
        ADD   HL,DE
L266:
        LD    A,27
L267:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L268:
        JR    Z,$+5
        JP    C,L279
L269:
        LD    HL,(05006H)
L270:
        CALL  writeLineHL
L271:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L272:
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
L273:
        JP    L264
L274:
        ;;test1.j(72) 
L275:
        ;;test1.j(73)   /************************/
L276:
        ;;test1.j(74)   // constant - var
L277:
        ;;test1.j(75)   // byte - byte
L278:
        ;;test1.j(76)   b=35;
L279:
        LD    A,35
L280:
        LD    (05000H),A
L281:
        ;;test1.j(77)   while (33 <= b) { println (p); p++; b--; }
L282:
        LD    A,(05000H)
L283:
        SUB   A,33
L284:
        JP    C,L293
L285:
        LD    HL,(05006H)
L286:
        CALL  writeLineHL
L287:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L288:
        LD    HL,(05000H)
        DEC   (HL)
L289:
        JP    L282
L290:
        ;;test1.j(78)   // constant - var
L291:
        ;;test1.j(79)   // byte - integer
L292:
        ;;test1.j(80)   i=37;
L293:
        LD    A,37
L294:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L295:
        ;;test1.j(81)   while (36 <= i) { println (p); p++; i--; }
L296:
        LD    HL,(05002H)
L297:
        LD    A,36
L298:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L299:
        JR    Z,$+5
        JP    C,L312
L300:
        LD    HL,(05006H)
L301:
        CALL  writeLineHL
L302:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L303:
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
L304:
        JP    L296
L305:
        ;;test1.j(82)   // constant - var
L306:
        ;;test1.j(83)   // integer - byte
L307:
        ;;test1.j(84)   // not relevant
L308:
        ;;test1.j(85) 
L309:
        ;;test1.j(86)   // constant - var
L310:
        ;;test1.j(87)   // integer - integer
L311:
        ;;test1.j(88)   while (34 <= i) { println (p); p++; i--; }
L312:
        LD    HL,(05002H)
L313:
        LD    A,34
L314:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L315:
        JR    Z,$+5
        JP    C,L358
L316:
        LD    HL,(05006H)
L317:
        CALL  writeLineHL
L318:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L319:
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
L320:
        JP    L312
L321:
        ;;test1.j(89) 
L322:
        ;;test1.j(90)   /************************/
L323:
        ;;test1.j(91)   // stack8 - constant
L324:
        ;;test1.j(92)   // stack8 - acc
L325:
        ;;test1.j(93)   // stack8 - var
L326:
        ;;test1.j(94)   // stack8 - stack8
L327:
        ;;test1.j(95)   // stack8 - stack16
L328:
        ;;test1.j(96)   //TODO
L329:
        ;;test1.j(97) 
L330:
        ;;test1.j(98)   /************************/
L331:
        ;;test1.j(99)   // stack16 - constant
L332:
        ;;test1.j(100)   // stack16 - acc
L333:
        ;;test1.j(101)   // stack16 - var
L334:
        ;;test1.j(102)   // stack16 - stack8
L335:
        ;;test1.j(103)   // stack16 - stack16
L336:
        ;;test1.j(104)   //TODO
L337:
        ;;test1.j(105) 
L338:
        ;;test1.j(106)   /************************/
L339:
        ;;test1.j(107)   // var - stack16
L340:
        ;;test1.j(108)   // byte - byte
L341:
        ;;test1.j(109)   // byte - integer
L342:
        ;;test1.j(110)   // integer - byte
L343:
        ;;test1.j(111)   // integer - integer
L344:
        ;;test1.j(112)   //TODO
L345:
        ;;test1.j(113) 
L346:
        ;;test1.j(114)   /************************/
L347:
        ;;test1.j(115)   // var - stack8
L348:
        ;;test1.j(116)   // byte - byte
L349:
        ;;test1.j(117)   // byte - integer
L350:
        ;;test1.j(118)   // integer - byte
L351:
        ;;test1.j(119)   // integer - integer
L352:
        ;;test1.j(120)   //TODO
L353:
        ;;test1.j(121) 
L354:
        ;;test1.j(122)   /************************/
L355:
        ;;test1.j(123)   // var - var
L356:
        ;;test1.j(124)   // byte - byte
L357:
        ;;test1.j(125)   b=33;
L358:
        LD    A,33
L359:
        LD    (05000H),A
L360:
        ;;test1.j(126)   while (b2 <= b) { println (p); p++; b--; }
L361:
        LD    A,(05001H)
L362:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L363:
        JR    Z,$+5
        JP    C,L371
L364:
        LD    HL,(05006H)
L365:
        CALL  writeLineHL
L366:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L367:
        LD    HL,(05000H)
        DEC   (HL)
L368:
        JP    L361
L369:
        ;;test1.j(127)   // byte - integer
L370:
        ;;test1.j(128)   i = 33;
L371:
        LD    A,33
L372:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L373:
        ;;test1.j(129)   while (b2 <= i) { println (p); p++; i--; }
L374:
        LD    A,(05001H)
L375:
        LD    HL,(05002H)
L376:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L377:
        JR    Z,$+5
        JP    C,L385
L378:
        LD    HL,(05006H)
L379:
        CALL  writeLineHL
L380:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L381:
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
L382:
        JP    L374
L383:
        ;;test1.j(130)   // integer - byte
L384:
        ;;test1.j(131)   b=33;
L385:
        LD    A,33
L386:
        LD    (05000H),A
L387:
        ;;test1.j(132)   i=b2;
L388:
        LD    A,(05001H)
L389:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L390:
        ;;test1.j(133)   while (i <= b) { println (p); p++; b--; }
L391:
        LD    HL,(05002H)
L392:
        LD    A,(05000H)
L393:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L394:
        JR    Z,$+5
        JP    C,L402
L395:
        LD    HL,(05006H)
L396:
        CALL  writeLineHL
L397:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L398:
        LD    HL,(05000H)
        DEC   (HL)
L399:
        JP    L391
L400:
        ;;test1.j(134)   // integer - integer
L401:
        ;;test1.j(135)   i=33;
L402:
        LD    A,33
L403:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L404:
        ;;test1.j(136)   i2=b2;
L405:
        LD    A,(05001H)
L406:
        LD    L,A
        LD    H,0
        LD    (05004H),HL
L407:
        ;;test1.j(137)   while (i2 <= i) { println (p); p++; i--; }
L408:
        LD    HL,(05004H)
L409:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L410:
        JR    Z,$+5
        JP    C,L421
L411:
        LD    HL,(05006H)
L412:
        CALL  writeLineHL
L413:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L414:
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
L415:
        JP    L408
L416:
        ;;test1.j(138) 
L417:
        ;;test1.j(139)   /************************/
L418:
        ;;test1.j(140)   // var - acc
L419:
        ;;test1.j(141)   // byte - byte
L420:
        ;;test1.j(142)   b=49;
L421:
        LD    A,49
L422:
        LD    (05000H),A
L423:
        ;;test1.j(143)   while (b <= 50+0) { println (b); b++; }
L424:
        LD    A,50
L425:
        ADD   A,0
L426:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L427:
        JP    C,L434
L428:
        LD    A,(05000H)
L429:
        CALL  writeLineA
L430:
        LD    HL,(05000H)
        INC   (HL)
L431:
        JP    L424
L432:
        ;;test1.j(144)   // byte - integer
L433:
        ;;test1.j(145)   i=52;
L434:
        LD    A,52
L435:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L436:
        ;;test1.j(146)   while (b <= i+0) { println (b); b++; }
L437:
        LD    HL,(05002H)
L438:
        LD    DE,0
        ADD   HL,DE
L439:
        LD    A,(05000H)
L440:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L441:
        JR    Z,$+5
        JP    C,L448
L442:
        LD    A,(05000H)
L443:
        CALL  writeLineA
L444:
        LD    HL,(05000H)
        INC   (HL)
L445:
        JP    L437
L446:
        ;;test1.j(147)   // integer - byte
L447:
        ;;test1.j(148)   i=b;
L448:
        LD    A,(05000H)
L449:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L450:
        ;;test1.j(149)   while (i <= 54+0) { println (i); i++; }
L451:
        LD    A,54
L452:
        ADD   A,0
L453:
        LD    HL,(05002H)
L454:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L455:
        JR    Z,$+5
        JP    C,L462
L456:
        LD    HL,(05002H)
L457:
        CALL  writeLineHL
L458:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L459:
        JP    L451
L460:
        ;;test1.j(150)   // integer - integer
L461:
        ;;test1.j(151)   b=i;
L462:
        LD    HL,(05002H)
L463:
        LD    A,L
        LD    (05000H),A
L464:
        ;;test1.j(152)   i=1098;
L465:
        LD    HL,1098
L466:
        LD    (05002H),HL
L467:
        ;;test1.j(153)   while (i <= 1099+0) { println (b); b++; i++; }
L468:
        LD    HL,1099
L469:
        LD    DE,0
        ADD   HL,DE
L470:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L471:
        JP    C,L482
L472:
        LD    A,(05000H)
L473:
        CALL  writeLineA
L474:
        LD    HL,(05000H)
        INC   (HL)
L475:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L476:
        JP    L468
L477:
        ;;test1.j(154) 
L478:
        ;;test1.j(155)   /************************/
L479:
        ;;test1.j(156)   // var - constant
L480:
        ;;test1.j(157)   // byte - byte
L481:
        ;;test1.j(158)   while (b <= 58) { println (b); b++; }
L482:
        LD    A,(05000H)
L483:
        SUB   A,58
L484:
        JR    Z,$+5
        JP    C,L494
L485:
        LD    A,(05000H)
L486:
        CALL  writeLineA
L487:
        LD    HL,(05000H)
        INC   (HL)
L488:
        JP    L482
L489:
        ;;test1.j(159)   // byte - integer
L490:
        ;;test1.j(160)   //not relevant
L491:
        ;;test1.j(161) 
L492:
        ;;test1.j(162)   // integer - byte
L493:
        ;;test1.j(163)   i=b;
L494:
        LD    A,(05000H)
L495:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L496:
        ;;test1.j(164)   while (i <= 60) { println (i); i++; }
L497:
        LD    HL,(05002H)
L498:
        LD    A,60
L499:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L500:
        JR    Z,$+5
        JP    C,L507
L501:
        LD    HL,(05002H)
L502:
        CALL  writeLineHL
L503:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L504:
        JP    L497
L505:
        ;;test1.j(165)   // integer - integer
L506:
        ;;test1.j(166)   i2=1090;
L507:
        LD    HL,1090
L508:
        LD    (05004H),HL
L509:
        ;;test1.j(167)   while (i2 <= 1091) { println (i); i++; i2++; }
L510:
        LD    HL,(05004H)
L511:
        LD    DE,1091
        OR    A
        SBC   HL,DE
L512:
        JR    Z,$+5
        JP    C,L524
L513:
        LD    HL,(05002H)
L514:
        CALL  writeLineHL
L515:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L516:
        LD    HL,(05004H)
        INC   HL
        LD    (05004H),HL
L517:
        JP    L510
L518:
        ;;test1.j(168) 
L519:
        ;;test1.j(169)   /************************/
L520:
        ;;test1.j(170)   // acc - stack8
L521:
        ;;test1.j(171)   // byte - byte
L522:
        ;;test1.j(172)   //TODO
L523:
        ;;test1.j(173)   println(63);
L524:
        LD    A,63
L525:
        CALL  writeLineA
L526:
        ;;test1.j(174)   println(64);
L527:
        LD    A,64
L528:
        CALL  writeLineA
L529:
        ;;test1.j(175)   // byte - integer
L530:
        ;;test1.j(176)   //TODO
L531:
        ;;test1.j(177)   println(65);
L532:
        LD    A,65
L533:
        CALL  writeLineA
L534:
        ;;test1.j(178)   println(66);
L535:
        LD    A,66
L536:
        CALL  writeLineA
L537:
        ;;test1.j(179)   // integer - byte
L538:
        ;;test1.j(180)   //TODO
L539:
        ;;test1.j(181)   println(67);
L540:
        LD    A,67
L541:
        CALL  writeLineA
L542:
        ;;test1.j(182)   println(68);
L543:
        LD    A,68
L544:
        CALL  writeLineA
L545:
        ;;test1.j(183)   // integer - integer
L546:
        ;;test1.j(184)   //TODO
L547:
        ;;test1.j(185)   println(69);
L548:
        LD    A,69
L549:
        CALL  writeLineA
L550:
        ;;test1.j(186)   println(70);
L551:
        LD    A,70
L552:
        CALL  writeLineA
L553:
        ;;test1.j(187) 
L554:
        ;;test1.j(188)   /************************/
L555:
        ;;test1.j(189)   // acc - stack16
L556:
        ;;test1.j(190)   // byte - byte
L557:
        ;;test1.j(191)   //TODO
L558:
        ;;test1.j(192)   println(71);
L559:
        LD    A,71
L560:
        CALL  writeLineA
L561:
        ;;test1.j(193)   println(72);
L562:
        LD    A,72
L563:
        CALL  writeLineA
L564:
        ;;test1.j(194)   // byte - integer
L565:
        ;;test1.j(195)   //TODO
L566:
        ;;test1.j(196)   println(73);
L567:
        LD    A,73
L568:
        CALL  writeLineA
L569:
        ;;test1.j(197)   println(74);
L570:
        LD    A,74
L571:
        CALL  writeLineA
L572:
        ;;test1.j(198)   // integer - byte
L573:
        ;;test1.j(199)   //TODO
L574:
        ;;test1.j(200)   println(75);
L575:
        LD    A,75
L576:
        CALL  writeLineA
L577:
        ;;test1.j(201)   println(76);
L578:
        LD    A,76
L579:
        CALL  writeLineA
L580:
        ;;test1.j(202)   // integer - integer
L581:
        ;;test1.j(203)   //TODO
L582:
        ;;test1.j(204)   println(77);
L583:
        LD    A,77
L584:
        CALL  writeLineA
L585:
        ;;test1.j(205)   println(78);
L586:
        LD    A,78
L587:
        CALL  writeLineA
L588:
        ;;test1.j(206) 
L589:
        ;;test1.j(207)   /************************/
L590:
        ;;test1.j(208)   // acc - var
L591:
        ;;test1.j(209)   // byte - byte
L592:
        ;;test1.j(210)   b=79;
L593:
        LD    A,79
L594:
        LD    (05000H),A
L595:
        ;;test1.j(211)   b2=79;
L596:
        LD    A,79
L597:
        LD    (05001H),A
L598:
        ;;test1.j(212)   while (78+0 <= b2) { println (b); b++; b2--; }
L599:
        LD    A,78
L600:
        ADD   A,0
L601:
        LD    B,A
        LD    A,(05001H)
        SUB   A,B
L602:
        JR    Z,$+5
        JP    C,L610
L603:
        LD    A,(05000H)
L604:
        CALL  writeLineA
L605:
        LD    HL,(05000H)
        INC   (HL)
L606:
        LD    HL,(05001H)
        DEC   (HL)
L607:
        JP    L599
L608:
        ;;test1.j(213)   // byte - integer
L609:
        ;;test1.j(214)   i=79;
L610:
        LD    A,79
L611:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L612:
        ;;test1.j(215)   while (78+0 <= i) { println (b); b++; i--; }
L613:
        LD    A,78
L614:
        ADD   A,0
L615:
        LD    HL,(05002H)
L616:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L617:
        JR    Z,$+5
        JP    C,L625
L618:
        LD    A,(05000H)
L619:
        CALL  writeLineA
L620:
        LD    HL,(05000H)
        INC   (HL)
L621:
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
L622:
        JP    L613
L623:
        ;;test1.j(216)   // integer - byte
L624:
        ;;test1.j(217)   i=78;
L625:
        LD    A,78
L626:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L627:
        ;;test1.j(218)   b2=79;
L628:
        LD    A,79
L629:
        LD    (05001H),A
L630:
        ;;test1.j(219)   while (i+0 <= b2) { println (b); b++; b2--; } 
L631:
        LD    HL,(05002H)
L632:
        LD    DE,0
        ADD   HL,DE
L633:
        LD    A,(05001H)
L634:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L635:
        JR    Z,$+5
        JP    C,L643
L636:
        LD    A,(05000H)
L637:
        CALL  writeLineA
L638:
        LD    HL,(05000H)
        INC   (HL)
L639:
        LD    HL,(05001H)
        DEC   (HL)
L640:
        JP    L631
L641:
        ;;test1.j(220)   // integer - integer
L642:
        ;;test1.j(221)   i=1066;
L643:
        LD    HL,1066
L644:
        LD    (05002H),HL
L645:
        ;;test1.j(222)   while (1000+65 <= i) { println (b); b++; i--; }
L646:
        LD    HL,1000
L647:
        LD    DE,65
        ADD   HL,DE
L648:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L649:
        JR    Z,$+5
        JP    C,L660
L650:
        LD    A,(05000H)
L651:
        CALL  writeLineA
L652:
        LD    HL,(05000H)
        INC   (HL)
L653:
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
L654:
        JP    L646
L655:
        ;;test1.j(223) 
L656:
        ;;test1.j(224)   /************************/
L657:
        ;;test1.j(225)   // acc - acc
L658:
        ;;test1.j(226)   // byte - byte
L659:
        ;;test1.j(227)   b=87;
L660:
        LD    A,87
L661:
        LD    (05000H),A
L662:
        ;;test1.j(228)   b2=64;
L663:
        LD    A,64
L664:
        LD    (05001H),A
L665:
        ;;test1.j(229)   while (63+0 <= b2+0) { println (b); b++; b2--; }
L666:
        LD    A,63
L667:
        ADD   A,0
L668:
        PUSH AF
L669:
        LD    A,(05001H)
L670:
        ADD   A,0
L671:
        POP   BC
        SUB   A,B
L672:
        JP    C,L680
L673:
        LD    A,(05000H)
L674:
        CALL  writeLineA
L675:
        LD    HL,(05000H)
        INC   (HL)
L676:
        LD    HL,(05001H)
        DEC   (HL)
L677:
        JP    L666
L678:
        ;;test1.j(230)   // byte - integer
L679:
        ;;test1.j(231)   i=62;
L680:
        LD    A,62
L681:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L682:
        ;;test1.j(232)   while (61+0 <= i+0) { println (b); b++; i--; }
L683:
        LD    A,61
L684:
        ADD   A,0
L685:
        PUSH AF
L686:
        LD    HL,(05002H)
L687:
        LD    DE,0
        ADD   HL,DE
L688:
        POP  AF
L689:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L690:
        JR    Z,$+5
        JP    C,L698
L691:
        LD    A,(05000H)
L692:
        CALL  writeLineA
L693:
        LD    HL,(05000H)
        INC   (HL)
L694:
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
L695:
        JP    L683
L696:
        ;;test1.j(233)   // integer - byte
L697:
        ;;test1.j(234)   i=59;
L698:
        LD    A,59
L699:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L700:
        ;;test1.j(235)   b2=60;
L701:
        LD    A,60
L702:
        LD    (05001H),A
L703:
        ;;test1.j(236)   while (i+0 <= b2+0) { println (b); b++; b2--; }
L704:
        LD    HL,(05002H)
L705:
        LD    DE,0
        ADD   HL,DE
L706:
        PUSH HL
L707:
        LD    A,(05001H)
L708:
        ADD   A,0
L709:
        POP  HL
L710:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L711:
        JR    Z,$+5
        JP    C,L719
L712:
        LD    A,(05000H)
L713:
        CALL  writeLineA
L714:
        LD    HL,(05000H)
        INC   (HL)
L715:
        LD    HL,(05001H)
        DEC   (HL)
L716:
        JP    L704
L717:
        ;;test1.j(237)   // integer - integer
L718:
        ;;test1.j(238)   i=1058;
L719:
        LD    HL,1058
L720:
        LD    (05002H),HL
L721:
        ;;test1.j(239)   while (1000+57 <= i+0) { println (b); b++; i--; }
L722:
        LD    HL,1000
L723:
        LD    DE,57
        ADD   HL,DE
L724:
        PUSH HL
L725:
        LD    HL,(05002H)
L726:
        LD    DE,0
        ADD   HL,DE
L727:
        POP   DE
        OR    A
        SBC   HL,DE
L728:
        JP    C,L739
L729:
        LD    A,(05000H)
L730:
        CALL  writeLineA
L731:
        LD    HL,(05000H)
        INC   (HL)
L732:
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
L733:
        JP    L722
L734:
        ;;test1.j(240) 
L735:
        ;;test1.j(241)   /************************/
L736:
        ;;test1.j(242)   // acc - constant
L737:
        ;;test1.j(243)   // byte - byte
L738:
        ;;test1.j(244)   while (b+0 <= 96) { println (b); b++; }
L739:
        LD    A,(05000H)
L740:
        ADD   A,0
L741:
        SUB   A,96
L742:
        JR    Z,$+5
        JP    C,L751
L743:
        LD    A,(05000H)
L744:
        CALL  writeLineA
L745:
        LD    HL,(05000H)
        INC   (HL)
L746:
        JP    L739
L747:
        ;;test1.j(245)   // byte - integer
L748:
        ;;test1.j(246)   //not relevant
L749:
        ;;test1.j(247)   // integer - byte
L750:
        ;;test1.j(248)   i=b;
L751:
        LD    A,(05000H)
L752:
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L753:
        ;;test1.j(249)   while (i+0 <= 98) { println (i); i++; }
L754:
        LD    HL,(05002H)
L755:
        LD    DE,0
        ADD   HL,DE
L756:
        LD    A,98
L757:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L758:
        JR    Z,$+5
        JP    C,L764
L759:
        LD    HL,(05002H)
L760:
        CALL  writeLineHL
L761:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L762:
        JP    L754
L763:
        ;;test1.j(250)   b=i;
L764:
        LD    HL,(05002H)
L765:
        LD    A,L
        LD    (05000H),A
L766:
        ;;test1.j(251)   i=1052;
L767:
        LD    HL,1052
L768:
        LD    (05002H),HL
L769:
        ;;test1.j(252)   // integer - integer
L770:
        ;;test1.j(253)   while (i+0 <= 1053) { println (b); b++; i++; }
L771:
        LD    HL,(05002H)
L772:
        LD    DE,0
        ADD   HL,DE
L773:
        LD    DE,1053
        OR    A
        SBC   HL,DE
L774:
        JR    Z,$+5
        JP    C,L786
L775:
        LD    A,(05000H)
L776:
        CALL  writeLineA
L777:
        LD    HL,(05000H)
        INC   (HL)
L778:
        LD    HL,(05002H)
        INC   HL
        LD    (05002H),HL
L779:
        JP    L771
L780:
        ;;test1.j(254) 
L781:
        ;;test1.j(255)   /************************/
L782:
        ;;test1.j(256)   // constant - stack8
L783:
        ;;test1.j(257)   // byte - byte
L784:
        ;;test1.j(258)   //TODO
L785:
        ;;test1.j(259)   println(101);
L786:
        LD    A,101
L787:
        CALL  writeLineA
L788:
        ;;test1.j(260)   println(102);
L789:
        LD    A,102
L790:
        CALL  writeLineA
L791:
        ;;test1.j(261)   // constant - stack8
L792:
        ;;test1.j(262)   // byte - integer
L793:
        ;;test1.j(263)   //TODO
L794:
        ;;test1.j(264)   println(103);
L795:
        LD    A,103
L796:
        CALL  writeLineA
L797:
        ;;test1.j(265)   println(104);
L798:
        LD    A,104
L799:
        CALL  writeLineA
L800:
        ;;test1.j(266)   // constant - stack8
L801:
        ;;test1.j(267)   // integer - byte
L802:
        ;;test1.j(268)   //TODO
L803:
        ;;test1.j(269)   println(105);
L804:
        LD    A,105
L805:
        CALL  writeLineA
L806:
        ;;test1.j(270)   println(106);
L807:
        LD    A,106
L808:
        CALL  writeLineA
L809:
        ;;test1.j(271)   // constant - stack88
L810:
        ;;test1.j(272)   // integer - integer
L811:
        ;;test1.j(273)   //TODO
L812:
        ;;test1.j(274)   println(107);
L813:
        LD    A,107
L814:
        CALL  writeLineA
L815:
        ;;test1.j(275)   println(108);
L816:
        LD    A,108
L817:
        CALL  writeLineA
L818:
        ;;test1.j(276) 
L819:
        ;;test1.j(277)   /************************/
L820:
        ;;test1.j(278)   // constant - stack16
L821:
        ;;test1.j(279)   // byte - byte
L822:
        ;;test1.j(280)   //TODO
L823:
        ;;test1.j(281)   println(109);
L824:
        LD    A,109
L825:
        CALL  writeLineA
L826:
        ;;test1.j(282)   println(110);
L827:
        LD    A,110
L828:
        CALL  writeLineA
L829:
        ;;test1.j(283)   // constant - stack16
L830:
        ;;test1.j(284)   // byte - integer
L831:
        ;;test1.j(285)   //TODO
L832:
        ;;test1.j(286)   println(111);
L833:
        LD    A,111
L834:
        CALL  writeLineA
L835:
        ;;test1.j(287)   println(112);
L836:
        LD    A,112
L837:
        CALL  writeLineA
L838:
        ;;test1.j(288)   // constant - stack16
L839:
        ;;test1.j(289)   // integer - byte
L840:
        ;;test1.j(290)   //TODO
L841:
        ;;test1.j(291)   println(113);
L842:
        LD    A,113
L843:
        CALL  writeLineA
L844:
        ;;test1.j(292)   println(114);
L845:
        LD    A,114
L846:
        CALL  writeLineA
L847:
        ;;test1.j(293)   // constant - stack16
L848:
        ;;test1.j(294)   // integer - integer
L849:
        ;;test1.j(295)   //TODO
L850:
        ;;test1.j(296)   println(115);
L851:
        LD    A,115
L852:
        CALL  writeLineA
L853:
        ;;test1.j(297)   println(116);
L854:
        LD    A,116
L855:
        CALL  writeLineA
L856:
        ;;test1.j(298) 
L857:
        ;;test1.j(299)   println("Klaar");
L858:
        LD    HL,862
L859:
        CALL  writeLineStr
L860:
        ;;test1.j(300) }
L861:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L862:
        .ASCIZ  "Klaar"
