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
;  USES:AF
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
;       C  = divisor
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
        ;;test2.j(8)     /*Possible operand types: 
L21:
        ;;test2.j(9)      * leftOperand:  constant, acc, var, stack16, stack8
L22:
        ;;test2.j(10)      * rightOperand: constant, acc, var, stack16, stack8
L23:
        ;;test2.j(11)      *Possible datatype combinations:
L24:
        ;;test2.j(12)      * integer - integer
L25:
        ;;test2.j(13)      * integer - byte
L26:
        ;;test2.j(14)      * byte - integer
L27:
        ;;test2.j(15)      * byte - byte
L28:
        ;;test2.j(16)     */
L29:
        ;;test2.j(17) 
L30:
        ;;test2.j(18)   /************************/
L31:
        ;;test2.j(19)   // stack16 - constant
L32:
        ;;test2.j(20)   // stack16 - acc
L33:
        ;;test2.j(21)   // stack16 - var
L34:
        ;;test2.j(22)   // stack16 - stack16
L35:
        ;;test2.j(23)   // stack16 - stack8
L36:
        ;;test2.j(24) 
L37:
        ;;test2.j(25)   /************************/
L38:
        ;;test2.j(26)   // stack8 - constant
L39:
        ;;test2.j(27)   // stack8 - acc
L40:
        ;;test2.j(28)   // stack8 - var
L41:
        ;;test2.j(29)   // stack8 - stack16
L42:
        ;;test2.j(30)   // stack8 - stack8
L43:
        ;;test2.j(31) 
L44:
        ;;test2.j(32)   /************************/
L45:
        ;;test2.j(33)   // var - stack8
L46:
        ;;test2.j(34)   // integer - integer
L47:
        ;;test2.j(35) 
L48:
        ;;test2.j(36)   // var - stack8
L49:
        ;;test2.j(37)   // integer - byte 
L50:
        ;;test2.j(38) 
L51:
        ;;test2.j(39)   // var - stack8
L52:
        ;;test2.j(40)   // byte - integer
L53:
        ;;test2.j(41) 
L54:
        ;;test2.j(42)   // var - stack8
L55:
        ;;test2.j(43)   // byte - byte
L56:
        ;;test2.j(44) 
L57:
        ;;test2.j(45)   /************************/
L58:
        ;;test2.j(46)   // var - stack16
L59:
        ;;test2.j(47)   // integer - integer
L60:
        ;;test2.j(48) 
L61:
        ;;test2.j(49)   // var - stack16
L62:
        ;;test2.j(50)   // integer - byte
L63:
        ;;test2.j(51) 
L64:
        ;;test2.j(52)   // var - stack16
L65:
        ;;test2.j(53)   // byte - integer
L66:
        ;;test2.j(54) 
L67:
        ;;test2.j(55)   // var - stack16
L68:
        ;;test2.j(56)   // byte - byte
L69:
        ;;test2.j(57) 
L70:
        ;;test2.j(58)   /************************/
L71:
        ;;test2.j(59)   // var - var
L72:
        ;;test2.j(60)   // integer - integer
L73:
        ;;test2.j(61)   write(159);
L74:
        LD    A,159
L75:
        CALL  writeA
L76:
        ;;test2.j(62)   write(158);
L77:
        LD    A,158
L78:
        CALL  writeA
L79:
        ;;test2.j(63)   if (i > i1) write(157);
L80:
        LD    HL,(05000H)
L81:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L82:
        JP    Z,L86
L83:
        LD    A,157
L84:
        CALL  writeA
L85:
        ;;test2.j(64)   if (i < i3) write(156);
L86:
        LD    HL,(05000H)
L87:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L88:
        JP    NC,L94
L89:
        LD    A,156
L90:
        CALL  writeA
L91:
        ;;test2.j(65)   // var - var
L92:
        ;;test2.j(66)   // integer - byte
L93:
        ;;test2.j(67)   if (i > i1) write(155);
L94:
        LD    HL,(05000H)
L95:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L96:
        JP    Z,L100
L97:
        LD    A,155
L98:
        CALL  writeA
L99:
        ;;test2.j(68)   if (i < i3) write(154);
L100:
        LD    HL,(05000H)
L101:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L102:
        JP    NC,L108
L103:
        LD    A,154
L104:
        CALL  writeA
L105:
        ;;test2.j(69)   // var - var
L106:
        ;;test2.j(70)   // byte - integer
L107:
        ;;test2.j(71)   if (b > i1) write(999); else write(153);
L108:
        LD    A,(05006H)
L109:
        LD    HL,(05002H)
L110:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L111:
        JP    Z,L115
L112:
        LD    HL,999
L113:
        CALL  writeHL
L114:
        JP    L118
L115:
        LD    A,153
L116:
        CALL  writeA
L117:
        ;;test2.j(72)   if (b < i3) write(152);
L118:
        LD    A,(05006H)
L119:
        LD    HL,(05004H)
L120:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L121:
        JP    NC,L127
L122:
        LD    A,152
L123:
        CALL  writeA
L124:
        ;;test2.j(73)   // var - var
L125:
        ;;test2.j(74)   // byte - byte
L126:
        ;;test2.j(75)   if (b > b1) write(151);
L127:
        LD    A,(05006H)
L128:
        LD    B,A
        LD    A,(05007H)
        SUB   A,B
L129:
        JP    Z,L133
L130:
        LD    A,151
L131:
        CALL  writeA
L132:
        ;;test2.j(76)   if (b < b3) write(150);
L133:
        LD    A,(05006H)
L134:
        LD    B,A
        LD    A,(05008H)
        SUB   A,B
L135:
        JP    NC,L143
L136:
        LD    A,150
L137:
        CALL  writeA
L138:
        ;;test2.j(77) 
L139:
        ;;test2.j(78)   /************************/
L140:
        ;;test2.j(79)   // var - acc
L141:
        ;;test2.j(80)   // integer - integer
L142:
        ;;test2.j(81)   write(149);
L143:
        LD    A,149
L144:
        CALL  writeA
L145:
        ;;test2.j(82)   write(148);
L146:
        LD    A,148
L147:
        CALL  writeA
L148:
        ;;test2.j(83)   if (i > 1000+0) write(147);
L149:
        LD    HL,1000
L150:
        LD    DE,0
        ADD   HL,DE
L151:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L152:
        JP    NC,L156
L153:
        LD    A,147
L154:
        CALL  writeA
L155:
        ;;test2.j(84)   if (i < 3000+0) write(146);
L156:
        LD    HL,3000
L157:
        LD    DE,0
        ADD   HL,DE
L158:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L159:
        JP    Z,L165
L160:
        LD    A,146
L161:
        CALL  writeA
L162:
        ;;test2.j(85)   // var - acc
L163:
        ;;test2.j(86)   // integer - byte
L164:
        ;;test2.j(87)   if (i > 1000+0) write(145);
L165:
        LD    HL,1000
L166:
        LD    DE,0
        ADD   HL,DE
L167:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L168:
        JP    NC,L172
L169:
        LD    A,145
L170:
        CALL  writeA
L171:
        ;;test2.j(88)   if (i < 3000+0) write(144);
L172:
        LD    HL,3000
L173:
        LD    DE,0
        ADD   HL,DE
L174:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L175:
        JP    Z,L181
L176:
        LD    A,144
L177:
        CALL  writeA
L178:
        ;;test2.j(89)   // var - acc
L179:
        ;;test2.j(90)   // byte - integer
L180:
        ;;test2.j(91)   if (b > 1000+0) write(999); else write(143);
L181:
        LD    HL,1000
L182:
        LD    DE,0
        ADD   HL,DE
L183:
        LD    A,(05006H)
L184:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L185:
        JP    Z,L189
L186:
        LD    HL,999
L187:
        CALL  writeHL
L188:
        JP    L192
L189:
        LD    A,143
L190:
        CALL  writeA
L191:
        ;;test2.j(92)   if (b < 1000+0) write(142);
L192:
        LD    HL,1000
L193:
        LD    DE,0
        ADD   HL,DE
L194:
        LD    A,(05006H)
L195:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L196:
        JP    NC,L202
L197:
        LD    A,142
L198:
        CALL  writeA
L199:
        ;;test2.j(93)   // var - acc
L200:
        ;;test2.j(94)   // byte - byte
L201:
        ;;test2.j(95)   if (b > 10+0) write(141);
L202:
        LD    A,10
L203:
        ADD   A,0
L204:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L205:
        JP    NC,L209
L206:
        LD    A,141
L207:
        CALL  writeA
L208:
        ;;test2.j(96)   if (b < 30+0) write(140);
L209:
        LD    A,30
L210:
        ADD   A,0
L211:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L212:
        JP    Z,L220
L213:
        LD    A,140
L214:
        CALL  writeA
L215:
        ;;test2.j(97) 
L216:
        ;;test2.j(98)   /************************/
L217:
        ;;test2.j(99)   // var - constant
L218:
        ;;test2.j(100)   // integer - integer
L219:
        ;;test2.j(101)   write(139);
L220:
        LD    A,139
L221:
        CALL  writeA
L222:
        ;;test2.j(102)   write(138);
L223:
        LD    A,138
L224:
        CALL  writeA
L225:
        ;;test2.j(103)   if (i > 1000) write(137);
L226:
        LD    HL,(05000H)
L227:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L228:
        JP    Z,L232
L229:
        LD    A,137
L230:
        CALL  writeA
L231:
        ;;test2.j(104)   if (i < 3000) write(136);
L232:
        LD    HL,(05000H)
L233:
        LD    DE,3000
        OR    A
        SBC   HL,DE
L234:
        JP    NC,L240
L235:
        LD    A,136
L236:
        CALL  writeA
L237:
        ;;test2.j(105)   // var - constant
L238:
        ;;test2.j(106)   // integer - byte
L239:
        ;;test2.j(107)   if (i > 1000) write(135);
L240:
        LD    HL,(05000H)
L241:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L242:
        JP    Z,L246
L243:
        LD    A,135
L244:
        CALL  writeA
L245:
        ;;test2.j(108)   if (i < 3000) write(134);
L246:
        LD    HL,(05000H)
L247:
        LD    DE,3000
        OR    A
        SBC   HL,DE
L248:
        JP    NC,L254
L249:
        LD    A,134
L250:
        CALL  writeA
L251:
        ;;test2.j(109)   // var - constant
L252:
        ;;test2.j(110)   // byte - integer
L253:
        ;;test2.j(111)   if (b > 1000) write(999); else write(133);
L254:
        LD    A,(05006H)
L255:
        LD    HL,1000
L256:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L257:
        JP    Z,L261
L258:
        LD    HL,999
L259:
        CALL  writeHL
L260:
        JP    L264
L261:
        LD    A,133
L262:
        CALL  writeA
L263:
        ;;test2.j(112)   if (b < 1000) write(132);
L264:
        LD    A,(05006H)
L265:
        LD    HL,1000
L266:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L267:
        JP    NC,L273
L268:
        LD    A,132
L269:
        CALL  writeA
L270:
        ;;test2.j(113)   // var - constant
L271:
        ;;test2.j(114)   // byte - byte
L272:
        ;;test2.j(115)   if (b > 10) write(131);
L273:
        LD    A,(05006H)
L274:
        SUB   A,10
L275:
        JP    Z,L279
L276:
        LD    A,131
L277:
        CALL  writeA
L278:
        ;;test2.j(116)   if (b < 30) write(130);
L279:
        LD    A,(05006H)
L280:
        SUB   A,30
L281:
        JP    NC,L289
L282:
        LD    A,130
L283:
        CALL  writeA
L284:
        ;;test2.j(117) 
L285:
        ;;test2.j(118)   /************************/
L286:
        ;;test2.j(119)   // acc - stack8
L287:
        ;;test2.j(120)   // integer - integer
L288:
        ;;test2.j(121)   write(129);
L289:
        LD    A,129
L290:
        CALL  writeA
L291:
        ;;test2.j(122)   write(128);
L292:
        LD    A,128
L293:
        CALL  writeA
L294:
        ;;test2.j(123)   write(127);
L295:
        LD    A,127
L296:
        CALL  writeA
L297:
        ;;test2.j(124)   write(126);
L298:
        LD    A,126
L299:
        CALL  writeA
L300:
        ;;test2.j(125)   // acc - stack8
L301:
        ;;test2.j(126)   // integer - byte
L302:
        ;;test2.j(127)   write(125);
L303:
        LD    A,125
L304:
        CALL  writeA
L305:
        ;;test2.j(128)   write(124);
L306:
        LD    A,124
L307:
        CALL  writeA
L308:
        ;;test2.j(129)   // acc - stack8
L309:
        ;;test2.j(130)   // byte - integer
L310:
        ;;test2.j(131)   write(123);
L311:
        LD    A,123
L312:
        CALL  writeA
L313:
        ;;test2.j(132)   write(122);
L314:
        LD    A,122
L315:
        CALL  writeA
L316:
        ;;test2.j(133)   // acc - stack8
L317:
        ;;test2.j(134)   // byte - byte
L318:
        ;;test2.j(135)   write(121);
L319:
        LD    A,121
L320:
        CALL  writeA
L321:
        ;;test2.j(136)   write(120);
L322:
        LD    A,120
L323:
        CALL  writeA
L324:
        ;;test2.j(137) 
L325:
        ;;test2.j(138)   /************************/
L326:
        ;;test2.j(139)   // acc - stack16
L327:
        ;;test2.j(140)   // integer - integer
L328:
        ;;test2.j(141)   write(119);
L329:
        LD    A,119
L330:
        CALL  writeA
L331:
        ;;test2.j(142)   write(118);
L332:
        LD    A,118
L333:
        CALL  writeA
L334:
        ;;test2.j(143)   write(117);
L335:
        LD    A,117
L336:
        CALL  writeA
L337:
        ;;test2.j(144)   write(116);
L338:
        LD    A,116
L339:
        CALL  writeA
L340:
        ;;test2.j(145)   // acc - stack16
L341:
        ;;test2.j(146)   // integer - byte
L342:
        ;;test2.j(147)   write(115);
L343:
        LD    A,115
L344:
        CALL  writeA
L345:
        ;;test2.j(148)   write(114);
L346:
        LD    A,114
L347:
        CALL  writeA
L348:
        ;;test2.j(149)   // acc - stack16
L349:
        ;;test2.j(150)   // byte - integer
L350:
        ;;test2.j(151)   write(113);
L351:
        LD    A,113
L352:
        CALL  writeA
L353:
        ;;test2.j(152)   write(112);
L354:
        LD    A,112
L355:
        CALL  writeA
L356:
        ;;test2.j(153)   // acc - stack16
L357:
        ;;test2.j(154)   // byte - byte
L358:
        ;;test2.j(155)   write(111);
L359:
        LD    A,111
L360:
        CALL  writeA
L361:
        ;;test2.j(156)   write(110);
L362:
        LD    A,110
L363:
        CALL  writeA
L364:
        ;;test2.j(157) 
L365:
        ;;test2.j(158)   /************************/
L366:
        ;;test2.j(159)   // acc - var
L367:
        ;;test2.j(160)   // integer - integer
L368:
        ;;test2.j(161)   write(109);
L369:
        LD    A,109
L370:
        CALL  writeA
L371:
        ;;test2.j(162)   write(108);
L372:
        LD    A,108
L373:
        CALL  writeA
L374:
        ;;test2.j(163)   if (3000+0 > i) write(107);
L375:
        LD    HL,3000
L376:
        LD    DE,0
        ADD   HL,DE
L377:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L378:
        JP    Z,L382
L379:
        LD    A,107
L380:
        CALL  writeA
L381:
        ;;test2.j(164)   if (1000+0 < i) write(106);
L382:
        LD    HL,1000
L383:
        LD    DE,0
        ADD   HL,DE
L384:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L385:
        JP    NC,L391
L386:
        LD    A,106
L387:
        CALL  writeA
L388:
        ;;test2.j(165)   // acc - var
L389:
        ;;test2.j(166)   // integer - byte
L390:
        ;;test2.j(167)   if (3000+0 > b) write(105);
L391:
        LD    HL,3000
L392:
        LD    DE,0
        ADD   HL,DE
L393:
        LD    A,(05006H)
L394:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L395:
        JP    Z,L399
L396:
        LD    A,105
L397:
        CALL  writeA
L398:
        ;;test2.j(168)   if (1000+0 < b) write(999); else write(104);
L399:
        LD    HL,1000
L400:
        LD    DE,0
        ADD   HL,DE
L401:
        LD    A,(05006H)
L402:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L403:
        JP    NC,L407
L404:
        LD    HL,999
L405:
        CALL  writeHL
L406:
        JP    L412
L407:
        LD    A,104
L408:
        CALL  writeA
L409:
        ;;test2.j(169)   // acc - var
L410:
        ;;test2.j(170)   // byte - integer
L411:
        ;;test2.j(171)   if (30+0 > i) write(999); else write(103);
L412:
        LD    A,30
L413:
        ADD   A,0
L414:
        LD    HL,(05000H)
L415:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L416:
        JP    Z,L420
L417:
        LD    HL,999
L418:
        CALL  writeHL
L419:
        JP    L423
L420:
        LD    A,103
L421:
        CALL  writeA
L422:
        ;;test2.j(172)   if (10+0 < i) write(102);
L423:
        LD    A,10
L424:
        ADD   A,0
L425:
        LD    HL,(05000H)
L426:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L427:
        JP    NC,L433
L428:
        LD    A,102
L429:
        CALL  writeA
L430:
        ;;test2.j(173)   // acc - var
L431:
        ;;test2.j(174)   // byte - byte
L432:
        ;;test2.j(175)   if (30+0 > b) write(101);
L433:
        LD    A,30
L434:
        ADD   A,0
L435:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L436:
        JP    Z,L440
L437:
        LD    A,101
L438:
        CALL  writeA
L439:
        ;;test2.j(176)   if (10+0 < b) write(100);
L440:
        LD    A,10
L441:
        ADD   A,0
L442:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L443:
        JP    NC,L451
L444:
        LD    A,100
L445:
        CALL  writeA
L446:
        ;;test2.j(177) 
L447:
        ;;test2.j(178)   /************************/
L448:
        ;;test2.j(179)   // acc - acc
L449:
        ;;test2.j(180)   // integer - integer
L450:
        ;;test2.j(181)   write(99);
L451:
        LD    A,99
L452:
        CALL  writeA
L453:
        ;;test2.j(182)   write(98);
L454:
        LD    A,98
L455:
        CALL  writeA
L456:
        ;;test2.j(183)   if (3000+0 > 2000+0) write(97);
L457:
        LD    HL,3000
L458:
        LD    DE,0
        ADD   HL,DE
L459:
        PUSH HL
L460:
        LD    HL,2000
L461:
        LD    DE,0
        ADD   HL,DE
L462:
        POP   DE
        OR    A
        SBC   HL,DE
L463:
        JP    NC,L467
L464:
        LD    A,97
L465:
        CALL  writeA
L466:
        ;;test2.j(184)   if (1000+0 < 2000+0) write(96);
L467:
        LD    HL,1000
L468:
        LD    DE,0
        ADD   HL,DE
L469:
        PUSH HL
L470:
        LD    HL,2000
L471:
        LD    DE,0
        ADD   HL,DE
L472:
        POP   DE
        OR    A
        SBC   HL,DE
L473:
        JP    Z,L479
L474:
        LD    A,96
L475:
        CALL  writeA
L476:
        ;;test2.j(185)   // acc - acc
L477:
        ;;test2.j(186)   // integer - byte
L478:
        ;;test2.j(187)   if (3000+0 > 20+0) write(95);
L479:
        LD    HL,3000
L480:
        LD    DE,0
        ADD   HL,DE
L481:
        PUSH HL
L482:
        LD    A,20
L483:
        ADD   A,0
L484:
        POP  HL
L485:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L486:
        JP    Z,L490
L487:
        LD    A,95
L488:
        CALL  writeA
L489:
        ;;test2.j(188)   if (1000+0 < 20+0) write(999); else write(94);
L490:
        LD    HL,1000
L491:
        LD    DE,0
        ADD   HL,DE
L492:
        PUSH HL
L493:
        LD    A,20
L494:
        ADD   A,0
L495:
        POP  HL
L496:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L497:
        JP    NC,L501
L498:
        LD    HL,999
L499:
        CALL  writeHL
L500:
        JP    L506
L501:
        LD    A,94
L502:
        CALL  writeA
L503:
        ;;test2.j(189)   // acc - acc
L504:
        ;;test2.j(190)   // byte - integer
L505:
        ;;test2.j(191)   if (30+0 > 2000+0) write(999); else write(93);
L506:
        LD    A,30
L507:
        ADD   A,0
L508:
        PUSH AF
L509:
        LD    HL,2000
L510:
        LD    DE,0
        ADD   HL,DE
L511:
        POP  AF
L512:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L513:
        JP    Z,L517
L514:
        LD    HL,999
L515:
        CALL  writeHL
L516:
        JP    L520
L517:
        LD    A,93
L518:
        CALL  writeA
L519:
        ;;test2.j(192)   if (10+0 < 2000+0) write(92);
L520:
        LD    A,10
L521:
        ADD   A,0
L522:
        PUSH AF
L523:
        LD    HL,2000
L524:
        LD    DE,0
        ADD   HL,DE
L525:
        POP  AF
L526:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L527:
        JP    NC,L533
L528:
        LD    A,92
L529:
        CALL  writeA
L530:
        ;;test2.j(193)   // acc - acc
L531:
        ;;test2.j(194)   // byte - byte
L532:
        ;;test2.j(195)   if (30+0 > 20+0) write(91);
L533:
        LD    A,30
L534:
        ADD   A,0
L535:
        PUSH AF
L536:
        LD    A,20
L537:
        ADD   A,0
L538:
        POP   BC
        SUB   A,B
L539:
        JP    NC,L543
L540:
        LD    A,91
L541:
        CALL  writeA
L542:
        ;;test2.j(196)   if (10+0 < 20+0) write(90);
L543:
        LD    A,10
L544:
        ADD   A,0
L545:
        PUSH AF
L546:
        LD    A,20
L547:
        ADD   A,0
L548:
        POP   BC
        SUB   A,B
L549:
        JP    Z,L557
L550:
        LD    A,90
L551:
        CALL  writeA
L552:
        ;;test2.j(197) 
L553:
        ;;test2.j(198)   /************************/
L554:
        ;;test2.j(199)   // acc - constant
L555:
        ;;test2.j(200)   // integer - integer
L556:
        ;;test2.j(201)   write(89);
L557:
        LD    A,89
L558:
        CALL  writeA
L559:
        ;;test2.j(202)   write(88);
L560:
        LD    A,88
L561:
        CALL  writeA
L562:
        ;;test2.j(203)   if (3000+0 > 2000) write(87);
L563:
        LD    HL,3000
L564:
        LD    DE,0
        ADD   HL,DE
L565:
        LD    DE,2000
        OR    A
        SBC   HL,DE
L566:
        JP    Z,L570
L567:
        LD    A,87
L568:
        CALL  writeA
L569:
        ;;test2.j(204)   if (1000+0 < 2000) write(86);
L570:
        LD    HL,1000
L571:
        LD    DE,0
        ADD   HL,DE
L572:
        LD    DE,2000
        OR    A
        SBC   HL,DE
L573:
        JP    NC,L579
L574:
        LD    A,86
L575:
        CALL  writeA
L576:
        ;;test2.j(205)   // acc - constant
L577:
        ;;test2.j(206)   // integer - byte
L578:
        ;;test2.j(207)   if (3000+0 > 20) write(85);
L579:
        LD    HL,3000
L580:
        LD    DE,0
        ADD   HL,DE
L581:
        LD    A,20
L582:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L583:
        JP    Z,L587
L584:
        LD    A,85
L585:
        CALL  writeA
L586:
        ;;test2.j(208)   if (1000+0 < 20) write(999); else write(84);
L587:
        LD    HL,1000
L588:
        LD    DE,0
        ADD   HL,DE
L589:
        LD    A,20
L590:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L591:
        JP    NC,L595
L592:
        LD    HL,999
L593:
        CALL  writeHL
L594:
        JP    L600
L595:
        LD    A,84
L596:
        CALL  writeA
L597:
        ;;test2.j(209)   // acc - constant
L598:
        ;;test2.j(210)   // byte - integer
L599:
        ;;test2.j(211)   if (30+0 > 2000) write(999); else write(83);
L600:
        LD    A,30
L601:
        ADD   A,0
L602:
        LD    HL,2000
L603:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L604:
        JP    Z,L608
L605:
        LD    HL,999
L606:
        CALL  writeHL
L607:
        JP    L611
L608:
        LD    A,83
L609:
        CALL  writeA
L610:
        ;;test2.j(212)   if (10+0 < 2000) write(82);
L611:
        LD    A,10
L612:
        ADD   A,0
L613:
        LD    HL,2000
L614:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L615:
        JP    NC,L621
L616:
        LD    A,82
L617:
        CALL  writeA
L618:
        ;;test2.j(213)   // acc - constant
L619:
        ;;test2.j(214)   // byte - byte
L620:
        ;;test2.j(215)   if (30+0 > 20) write(81);
L621:
        LD    A,30
L622:
        ADD   A,0
L623:
        SUB   A,20
L624:
        JP    Z,L628
L625:
        LD    A,81
L626:
        CALL  writeA
L627:
        ;;test2.j(216)   if (10+0 < 20) write(80);
L628:
        LD    A,10
L629:
        ADD   A,0
L630:
        SUB   A,20
L631:
        JP    NC,L639
L632:
        LD    A,80
L633:
        CALL  writeA
L634:
        ;;test2.j(217) 
L635:
        ;;test2.j(218)   /************************/
L636:
        ;;test2.j(219)   // constant - stack8
L637:
        ;;test2.j(220)   // byte - byte
L638:
        ;;test2.j(221)   write(79);
L639:
        LD    A,79
L640:
        CALL  writeA
L641:
        ;;test2.j(222)   write(78);
L642:
        LD    A,78
L643:
        CALL  writeA
L644:
        ;;test2.j(223)   write(77);
L645:
        LD    A,77
L646:
        CALL  writeA
L647:
        ;;test2.j(224)   write(76);
L648:
        LD    A,76
L649:
        CALL  writeA
L650:
        ;;test2.j(225)   // constant - stack8
L651:
        ;;test2.j(226)   // byte - integer
L652:
        ;;test2.j(227)   write(75);
L653:
        LD    A,75
L654:
        CALL  writeA
L655:
        ;;test2.j(228)   write(74);
L656:
        LD    A,74
L657:
        CALL  writeA
L658:
        ;;test2.j(229)   // constant - stack8
L659:
        ;;test2.j(230)   // integer - byte
L660:
        ;;test2.j(231)   write(73);
L661:
        LD    A,73
L662:
        CALL  writeA
L663:
        ;;test2.j(232)   write(72);
L664:
        LD    A,72
L665:
        CALL  writeA
L666:
        ;;test2.j(233)   // constant - stack8
L667:
        ;;test2.j(234)   // integer - integer
L668:
        ;;test2.j(235)   write(71);
L669:
        LD    A,71
L670:
        CALL  writeA
L671:
        ;;test2.j(236)   write(70);
L672:
        LD    A,70
L673:
        CALL  writeA
L674:
        ;;test2.j(237) 
L675:
        ;;test2.j(238) 
L676:
        ;;test2.j(239)   /************************/
L677:
        ;;test2.j(240)   // constant - stack16
L678:
        ;;test2.j(241)   // byte - byte
L679:
        ;;test2.j(242)   write(69);
L680:
        LD    A,69
L681:
        CALL  writeA
L682:
        ;;test2.j(243)   write(68);
L683:
        LD    A,68
L684:
        CALL  writeA
L685:
        ;;test2.j(244)   write(67);
L686:
        LD    A,67
L687:
        CALL  writeA
L688:
        ;;test2.j(245)   write(66);
L689:
        LD    A,66
L690:
        CALL  writeA
L691:
        ;;test2.j(246)   // constant - stack16
L692:
        ;;test2.j(247)   // byte - integer
L693:
        ;;test2.j(248)   write(65);
L694:
        LD    A,65
L695:
        CALL  writeA
L696:
        ;;test2.j(249)   write(64);
L697:
        LD    A,64
L698:
        CALL  writeA
L699:
        ;;test2.j(250)   // constant - stack16
L700:
        ;;test2.j(251)   // integer - byte
L701:
        ;;test2.j(252)   write(63);
L702:
        LD    A,63
L703:
        CALL  writeA
L704:
        ;;test2.j(253)   write(62);
L705:
        LD    A,62
L706:
        CALL  writeA
L707:
        ;;test2.j(254)   // constant - stack16
L708:
        ;;test2.j(255)   // integer - integer
L709:
        ;;test2.j(256)   write(61);
L710:
        LD    A,61
L711:
        CALL  writeA
L712:
        ;;test2.j(257)   write(60);
L713:
        LD    A,60
L714:
        CALL  writeA
L715:
        ;;test2.j(258) 
L716:
        ;;test2.j(259) 
L717:
        ;;test2.j(260)   /************************/
L718:
        ;;test2.j(261)   // constant - var
L719:
        ;;test2.j(262)   // byte - byte
L720:
        ;;test2.j(263)   write(59);
L721:
        LD    A,59
L722:
        CALL  writeA
L723:
        ;;test2.j(264)   write(58);
L724:
        LD    A,58
L725:
        CALL  writeA
L726:
        ;;test2.j(265)   if (30 > b) write(57);
L727:
        LD    A,(05006H)
L728:
        SUB   A,30
L729:
        JP    NC,L733
L730:
        LD    A,57
L731:
        CALL  writeA
L732:
        ;;test2.j(266)   if (10 < b) write(56);
L733:
        LD    A,(05006H)
L734:
        SUB   A,10
L735:
        JP    Z,L741
L736:
        LD    A,56
L737:
        CALL  writeA
L738:
        ;;test2.j(267)   // constant - var
L739:
        ;;test2.j(268)   // byte - integer
L740:
        ;;test2.j(269)   if (30 > i) write(999); else write(55);
L741:
        LD    HL,(05000H)
L742:
        LD    A,30
L743:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L744:
        JP    Z,L748
L745:
        LD    HL,999
L746:
        CALL  writeHL
L747:
        JP    L751
L748:
        LD    A,55
L749:
        CALL  writeA
L750:
        ;;test2.j(270)   if (10 < i) write(54);
L751:
        LD    HL,(05000H)
L752:
        LD    A,10
L753:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L754:
        JP    NC,L760
L755:
        LD    A,54
L756:
        CALL  writeA
L757:
        ;;test2.j(271)   // constant - var
L758:
        ;;test2.j(272)   // integer - byte
L759:
        ;;test2.j(273)   if (3000 > b) write(53);
L760:
        LD    A,(05006H)
L761:
        LD    HL,3000
L762:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L763:
        JP    Z,L767
L764:
        LD    A,53
L765:
        CALL  writeA
L766:
        ;;test2.j(274)   if (1000 < b) write(999); else write(52);
L767:
        LD    A,(05006H)
L768:
        LD    HL,1000
L769:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L770:
        JP    NC,L774
L771:
        LD    HL,999
L772:
        CALL  writeHL
L773:
        JP    L779
L774:
        LD    A,52
L775:
        CALL  writeA
L776:
        ;;test2.j(275)   // constant - var
L777:
        ;;test2.j(276)   // integer - integer
L778:
        ;;test2.j(277)   if (3000 > i) write(51);
L779:
        LD    HL,(05000H)
L780:
        LD    DE,3000
        OR    A
        SBC   HL,DE
L781:
        JP    NC,L785
L782:
        LD    A,51
L783:
        CALL  writeA
L784:
        ;;test2.j(278)   if (1000 < i) write(50);
L785:
        LD    HL,(05000H)
L786:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L787:
        JP    Z,L795
L788:
        LD    A,50
L789:
        CALL  writeA
L790:
        ;;test2.j(279) 
L791:
        ;;test2.j(280)   /************************/
L792:
        ;;test2.j(281)   // constant - acc
L793:
        ;;test2.j(282)   // byte - byte
L794:
        ;;test2.j(283)   write(49);
L795:
        LD    A,49
L796:
        CALL  writeA
L797:
        ;;test2.j(284)   write(48);
L798:
        LD    A,48
L799:
        CALL  writeA
L800:
        ;;test2.j(285)   if (1 > 0+0) write(47);
L801:
        LD    A,0
L802:
        ADD   A,0
L803:
        SUB   A,1
L804:
        JP    NC,L808
L805:
        LD    A,47
L806:
        CALL  writeA
L807:
        ;;test2.j(286)   if (1 < 2+0) write(46);
L808:
        LD    A,2
L809:
        ADD   A,0
L810:
        SUB   A,1
L811:
        JP    Z,L817
L812:
        LD    A,46
L813:
        CALL  writeA
L814:
        ;;test2.j(287)   // constant - acc
L815:
        ;;test2.j(288)   // byte - integer
L816:
        ;;test2.j(289)   if (1 > 1000+0) write(999); else write(45);
L817:
        LD    HL,1000
L818:
        LD    DE,0
        ADD   HL,DE
L819:
        LD    A,1
L820:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L821:
        JP    Z,L825
L822:
        LD    HL,999
L823:
        CALL  writeHL
L824:
        JP    L828
L825:
        LD    A,45
L826:
        CALL  writeA
L827:
        ;;test2.j(290)   if (1 < 1000+0) write(44);
L828:
        LD    HL,1000
L829:
        LD    DE,0
        ADD   HL,DE
L830:
        LD    A,1
L831:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L832:
        JP    NC,L838
L833:
        LD    A,44
L834:
        CALL  writeA
L835:
        ;;test2.j(291)   // constant - acc
L836:
        ;;test2.j(292)   // integer - byte
L837:
        ;;test2.j(293)   if (1000 > 0+0) write(43);
L838:
        LD    A,0
L839:
        ADD   A,0
L840:
        LD    HL,1000
L841:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L842:
        JP    Z,L846
L843:
        LD    A,43
L844:
        CALL  writeA
L845:
        ;;test2.j(294)   if (1000 < 0+0) write(999); else write(42);
L846:
        LD    A,0
L847:
        ADD   A,0
L848:
        LD    HL,1000
L849:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L850:
        JP    NC,L854
L851:
        LD    HL,999
L852:
        CALL  writeHL
L853:
        JP    L859
L854:
        LD    A,42
L855:
        CALL  writeA
L856:
        ;;test2.j(295)   // constant - acc
L857:
        ;;test2.j(296)   // integer - integer
L858:
        ;;test2.j(297)   if (2000 > 1000+0) write(41);
L859:
        LD    HL,1000
L860:
        LD    DE,0
        ADD   HL,DE
L861:
        LD    DE,2000
        OR    A
        SBC   HL,DE
L862:
        JP    NC,L866
L863:
        LD    A,41
L864:
        CALL  writeA
L865:
        ;;test2.j(298)   if (1000 < 2000+0) write(40);
L866:
        LD    HL,2000
L867:
        LD    DE,0
        ADD   HL,DE
L868:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L869:
        JP    Z,L877
L870:
        LD    A,40
L871:
        CALL  writeA
L872:
        ;;test2.j(299) 
L873:
        ;;test2.j(300)   /************************/
L874:
        ;;test2.j(301)   // constant - constant
L875:
        ;;test2.j(302)   // byte - byte
L876:
        ;;test2.j(303)   write(39);
L877:
        LD    A,39
L878:
        CALL  writeA
L879:
        ;;test2.j(304)   if (1 == 1) write(38);
L880:
        LD    A,1
L881:
        SUB   A,1
L882:
        JP    NZ,L886
L883:
        LD    A,38
L884:
        CALL  writeA
L885:
        ;;test2.j(305)   if (1 != 0) write(37);
L886:
        LD    A,1
L887:
        SUB   A,0
L888:
        JP    Z,L892
L889:
        LD    A,37
L890:
        CALL  writeA
L891:
        ;;test2.j(306)   if (1 > 0) write(36);
L892:
        LD    A,1
L893:
        SUB   A,0
L894:
        JP    Z,L898
L895:
        LD    A,36
L896:
        CALL  writeA
L897:
        ;;test2.j(307)   if (1 >= 0) write(35);
L898:
        LD    A,1
L899:
        SUB   A,0
L900:
        JP    C,L904
L901:
        LD    A,35
L902:
        CALL  writeA
L903:
        ;;test2.j(308)   if (1 >= 1) write(34);
L904:
        LD    A,1
L905:
        SUB   A,1
L906:
        JP    C,L910
L907:
        LD    A,34
L908:
        CALL  writeA
L909:
        ;;test2.j(309)   if (1 < 2) write(33);
L910:
        LD    A,1
L911:
        SUB   A,2
L912:
        JP    NC,L916
L913:
        LD    A,33
L914:
        CALL  writeA
L915:
        ;;test2.j(310)   if (1 <= 2) write(32);
L916:
        LD    A,1
L917:
        SUB   A,2
L918:
        JR    Z,$+5
        JP    C,L922
L919:
        LD    A,32
L920:
        CALL  writeA
L921:
        ;;test2.j(311)   if (1 <= 1) write(31);
L922:
        LD    A,1
L923:
        SUB   A,1
L924:
        JR    Z,$+5
        JP    C,L928
L925:
        LD    A,31
L926:
        CALL  writeA
L927:
        ;;test2.j(312)   write(30);
L928:
        LD    A,30
L929:
        CALL  writeA
L930:
        ;;test2.j(313)   // constant - constant
L931:
        ;;test2.j(314)   // byte - integer
L932:
        ;;test2.j(315)   write(29);
L933:
        LD    A,29
L934:
        CALL  writeA
L935:
        ;;test2.j(316)   if (1 == 1000) write(999); else write(28);
L936:
        LD    A,1
L937:
        LD    HL,1000
L938:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L939:
        JP    NZ,L943
L940:
        LD    HL,999
L941:
        CALL  writeHL
L942:
        JP    L946
L943:
        LD    A,28
L944:
        CALL  writeA
L945:
        ;;test2.j(317)   if (1 != 1000) write(27);
L946:
        LD    A,1
L947:
        LD    HL,1000
L948:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L949:
        JP    Z,L953
L950:
        LD    A,27
L951:
        CALL  writeA
L952:
        ;;test2.j(318)   if (1 > 1000) write(999); else write(26);
L953:
        LD    A,1
L954:
        LD    HL,1000
L955:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L956:
        JP    Z,L960
L957:
        LD    HL,999
L958:
        CALL  writeHL
L959:
        JP    L963
L960:
        LD    A,26
L961:
        CALL  writeA
L962:
        ;;test2.j(319)   if (1 >= 1000) write(999); write(25);
L963:
        LD    A,1
L964:
        LD    HL,1000
L965:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L966:
        JP    C,L969
L967:
        LD    HL,999
L968:
        CALL  writeHL
L969:
        LD    A,25
L970:
        CALL  writeA
L971:
        ;;test2.j(320)   if (1 >= 1000) write(999); write(24);
L972:
        LD    A,1
L973:
        LD    HL,1000
L974:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L975:
        JP    C,L978
L976:
        LD    HL,999
L977:
        CALL  writeHL
L978:
        LD    A,24
L979:
        CALL  writeA
L980:
        ;;test2.j(321)   if (1 < 2000) write(23);
L981:
        LD    A,1
L982:
        LD    HL,2000
L983:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L984:
        JP    NC,L988
L985:
        LD    A,23
L986:
        CALL  writeA
L987:
        ;;test2.j(322)   if (1 <= 2000) write(22);
L988:
        LD    A,1
L989:
        LD    HL,2000
L990:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L991:
        JR    Z,$+5
        JP    C,L995
L992:
        LD    A,22
L993:
        CALL  writeA
L994:
        ;;test2.j(323)   if (1 <= 1000) write(21);
L995:
        LD    A,1
L996:
        LD    HL,1000
L997:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L998:
        JR    Z,$+5
        JP    C,L1002
L999:
        LD    A,21
L1000:
        CALL  writeA
L1001:
        ;;test2.j(324)   write(20);
L1002:
        LD    A,20
L1003:
        CALL  writeA
L1004:
        ;;test2.j(325)   // constant - constant
L1005:
        ;;test2.j(326)   // integer - byte
L1006:
        ;;test2.j(327)   write(19);
L1007:
        LD    A,19
L1008:
        CALL  writeA
L1009:
        ;;test2.j(328)   if (1000 == 1) { write(999); } else { write(18); }
L1010:
        LD    HL,1000
L1011:
        LD    A,1
L1012:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1013:
        JP    NZ,L1017
L1014:
        LD    HL,999
L1015:
        CALL  writeHL
L1016:
        JP    L1020
L1017:
        LD    A,18
L1018:
        CALL  writeA
L1019:
        ;;test2.j(329)   if (1000 != 0) write(17);
L1020:
        LD    HL,1000
L1021:
        LD    A,0
L1022:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1023:
        JP    Z,L1027
L1024:
        LD    A,17
L1025:
        CALL  writeA
L1026:
        ;;test2.j(330)   if (1000 > 0) write(16);
L1027:
        LD    HL,1000
L1028:
        LD    A,0
L1029:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1030:
        JP    Z,L1034
L1031:
        LD    A,16
L1032:
        CALL  writeA
L1033:
        ;;test2.j(331)   if (1000 >= 0) write(15);
L1034:
        LD    HL,1000
L1035:
        LD    A,0
L1036:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1037:
        JP    C,L1041
L1038:
        LD    A,15
L1039:
        CALL  writeA
L1040:
        ;;test2.j(332)   if (1000 >= 1) write(14);
L1041:
        LD    HL,1000
L1042:
        LD    A,1
L1043:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1044:
        JP    C,L1048
L1045:
        LD    A,14
L1046:
        CALL  writeA
L1047:
        ;;test2.j(333)   if (1 < 2000) write(13);
L1048:
        LD    A,1
L1049:
        LD    HL,2000
L1050:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1051:
        JP    NC,L1055
L1052:
        LD    A,13
L1053:
        CALL  writeA
L1054:
        ;;test2.j(334)   if (1 <= 2000) write(12);
L1055:
        LD    A,1
L1056:
        LD    HL,2000
L1057:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1058:
        JR    Z,$+5
        JP    C,L1062
L1059:
        LD    A,12
L1060:
        CALL  writeA
L1061:
        ;;test2.j(335)   if (1 <= 1000) write(11);
L1062:
        LD    A,1
L1063:
        LD    HL,1000
L1064:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1065:
        JR    Z,$+5
        JP    C,L1069
L1066:
        LD    A,11
L1067:
        CALL  writeA
L1068:
        ;;test2.j(336)   write(10);
L1069:
        LD    A,10
L1070:
        CALL  writeA
L1071:
        ;;test2.j(337)   // constant - constant
L1072:
        ;;test2.j(338)   // integer - integer
L1073:
        ;;test2.j(339)   write(9);
L1074:
        LD    A,9
L1075:
        CALL  writeA
L1076:
        ;;test2.j(340)   if (1000 == 1000) write(8);
L1077:
        LD    HL,1000
L1078:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L1079:
        JP    NZ,L1083
L1080:
        LD    A,8
L1081:
        CALL  writeA
L1082:
        ;;test2.j(341)   if (1000 != 2000) write(7);
L1083:
        LD    HL,1000
L1084:
        LD    DE,2000
        OR    A
        SBC   HL,DE
L1085:
        JP    Z,L1089
L1086:
        LD    A,7
L1087:
        CALL  writeA
L1088:
        ;;test2.j(342)   if (2000 > 1000) write(6);
L1089:
        LD    HL,2000
L1090:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L1091:
        JP    Z,L1095
L1092:
        LD    A,6
L1093:
        CALL  writeA
L1094:
        ;;test2.j(343)   if (2000 >= 1000) write(5);
L1095:
        LD    HL,2000
L1096:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L1097:
        JP    C,L1101
L1098:
        LD    A,5
L1099:
        CALL  writeA
L1100:
        ;;test2.j(344)   if (1000 >= 1000) write(4);
L1101:
        LD    HL,1000
L1102:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L1103:
        JP    C,L1107
L1104:
        LD    A,4
L1105:
        CALL  writeA
L1106:
        ;;test2.j(345)   if (1000 < 2000) write(3);
L1107:
        LD    HL,1000
L1108:
        LD    DE,2000
        OR    A
        SBC   HL,DE
L1109:
        JP    NC,L1113
L1110:
        LD    A,3
L1111:
        CALL  writeA
L1112:
        ;;test2.j(346)   if (1000 <= 2000) write(2);
L1113:
        LD    HL,1000
L1114:
        LD    DE,2000
        OR    A
        SBC   HL,DE
L1115:
        JR    Z,$+5
        JP    C,L1119
L1116:
        LD    A,2
L1117:
        CALL  writeA
L1118:
        ;;test2.j(347)   if (1000 <= 1000) write(1);
L1119:
        LD    HL,1000
L1120:
        LD    DE,1000
        OR    A
        SBC   HL,DE
L1121:
        JR    Z,$+5
        JP    C,L1126
L1122:
        LD    A,1
L1123:
        CALL  writeA
L1124:
        ;;test2.j(348) 
L1125:
        ;;test2.j(349)   write(0);
L1126:
        LD    A,0
L1127:
        CALL  writeA
L1128:
        ;;test2.j(350) }
L1129:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
