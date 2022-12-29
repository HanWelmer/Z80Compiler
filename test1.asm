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
        ;;test1.j(0) /* Program to test generated Z80 assembler code */
L1:
        ;;test1.j(1) class TestWhile {
L2:
        ;;test1.j(2)   byte b = 115;
L3:
        LD    A,115
L4:
        LD    (05000H),A
L5:
        ;;test1.j(3)   
L6:
        ;;test1.j(4)   /************************/
L7:
        ;;test1.j(5)   // global variable within while scope
L8:
        ;;test1.j(6)   write (b);
L9:
        LD    A,(05000H)
L10:
        CALL  writeA
L11:
        ;;test1.j(7)   b--;
L12:
        LD    HL,(05000H)
        DEC   (HL)
L13:
        ;;test1.j(8)   while (b>112) {
L14:
        LD    A,(05000H)
L15:
        SUB   A,112
L16:
        JP    Z,L35
L17:
        ;;test1.j(9)     word j = 1001;
L18:
        LD    HL,1001
L19:
        LD    (05001H),HL
L20:
        ;;test1.j(10)     byte c = b;
L21:
        LD    A,(05000H)
L22:
        LD    (05003H),A
L23:
        ;;test1.j(11)     byte d = c;
L24:
        LD    A,(05003H)
L25:
        LD    (05004H),A
L26:
        ;;test1.j(12)     b--;
L27:
        LD    HL,(05000H)
        DEC   (HL)
L28:
        ;;test1.j(13)     write (c);
L29:
        LD    A,(05003H)
L30:
        CALL  writeA
L31:
        ;;test1.j(14)   }
L32:
        JP    L14
L33:
        ;;test1.j(15) 
L34:
        ;;test1.j(16)   word i = 110;
L35:
        LD    A,110
L36:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L37:
        ;;test1.j(17)   word i2 = 105;
L38:
        LD    A,105
L39:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L40:
        ;;test1.j(18)   word p = 12;
L41:
        LD    A,12
L42:
        LD    L,A
        LD    H,0
        LD    (05005H),HL
L43:
        ;;test1.j(19)   byte b2 = 111;
L44:
        LD    A,111
L45:
        LD    (05007H),A
L46:
        ;;test1.j(20) 
L47:
        ;;test1.j(21)   /************************/
L48:
        ;;test1.j(22)   // stack8 - constant
L49:
        ;;test1.j(23)   // stack8 - acc
L50:
        ;;test1.j(24)   // stack8 - var
L51:
        ;;test1.j(25)   // stack8 - stack8
L52:
        ;;test1.j(26)   // stack8 - stack16
L53:
        ;;test1.j(27)   //TODO
L54:
        ;;test1.j(28) 
L55:
        ;;test1.j(29)   /************************/
L56:
        ;;test1.j(30)   // stack16 - constant
L57:
        ;;test1.j(31)   // stack16 - acc
L58:
        ;;test1.j(32)   // stack16 - var
L59:
        ;;test1.j(33)   // stack16 - stack8
L60:
        ;;test1.j(34)   // stack16 - stack16
L61:
        ;;test1.j(35)   //TODO
L62:
        ;;test1.j(36) 
L63:
        ;;test1.j(37)   /************************/
L64:
        ;;test1.j(38)   // var - stack16
L65:
        ;;test1.j(39)   // byte - byte
L66:
        ;;test1.j(40)   // byte - integer
L67:
        ;;test1.j(41)   // integer - byte
L68:
        ;;test1.j(42)   // integer - integer
L69:
        ;;test1.j(43)   //TODO
L70:
        ;;test1.j(44) 
L71:
        ;;test1.j(45)   /************************/
L72:
        ;;test1.j(46)   // var - stack8
L73:
        ;;test1.j(47)   // byte - byte
L74:
        ;;test1.j(48)   // byte - integer
L75:
        ;;test1.j(49)   // integer - byte
L76:
        ;;test1.j(50)   // integer - integer
L77:
        ;;test1.j(51)   //TODO
L78:
        ;;test1.j(52) 
L79:
        ;;test1.j(53)   /************************/
L80:
        ;;test1.j(54)   // var - var
L81:
        ;;test1.j(55)   // byte - byte
L82:
        ;;test1.j(56)   while (b2 <= b) { write (b); b--; }
L83:
        LD    A,(05007H)
L84:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L85:
        JR    Z,$+5
        JP    C,L92
L86:
        LD    A,(05000H)
L87:
        CALL  writeA
L88:
        LD    HL,(05000H)
        DEC   (HL)
L89:
        JP    L83
L90:
        ;;test1.j(57)   // byte - integer
L91:
        ;;test1.j(58)   b2 = 109;
L92:
        LD    A,109
L93:
        LD    (05007H),A
L94:
        ;;test1.j(59)   while (b2 <= i) { write (i); i--; }
L95:
        LD    A,(05007H)
L96:
        LD    HL,(05001H)
L97:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L98:
        JR    Z,$+5
        JP    C,L105
L99:
        LD    HL,(05001H)
L100:
        CALL  writeHL
L101:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L102:
        JP    L95
L103:
        ;;test1.j(60)   // integer - byte
L104:
        ;;test1.j(61)   b=108;
L105:
        LD    A,108
L106:
        LD    (05000H),A
L107:
        ;;test1.j(62)   i=107;
L108:
        LD    A,107
L109:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L110:
        ;;test1.j(63)   while (i <= b) { write (b); b--; }
L111:
        LD    HL,(05001H)
L112:
        LD    A,(05000H)
L113:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L114:
        JR    Z,$+5
        JP    C,L121
L115:
        LD    A,(05000H)
L116:
        CALL  writeA
L117:
        LD    HL,(05000H)
        DEC   (HL)
L118:
        JP    L111
L119:
        ;;test1.j(64)   // integer - integer
L120:
        ;;test1.j(65)   i=106;
L121:
        LD    A,106
L122:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L123:
        ;;test1.j(66)   while (i2 <= i) { write (i); i--; }
L124:
        LD    HL,(05003H)
L125:
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
L126:
        JR    Z,$+5
        JP    C,L136
L127:
        LD    HL,(05001H)
L128:
        CALL  writeHL
L129:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L130:
        JP    L124
L131:
        ;;test1.j(67) 
L132:
        ;;test1.j(68)   /************************/
L133:
        ;;test1.j(69)   // var - acc
L134:
        ;;test1.j(70)   // byte - byte
L135:
        ;;test1.j(71)   i=104;
L136:
        LD    A,104
L137:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L138:
        ;;test1.j(72)   b=104;
L139:
        LD    A,104
L140:
        LD    (05000H),A
L141:
        ;;test1.j(73)   while (b <= 105+0) { write (i); i--; b++; }
L142:
        LD    A,105
L143:
        ADD   A,0
L144:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L145:
        JP    C,L153
L146:
        LD    HL,(05001H)
L147:
        CALL  writeHL
L148:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L149:
        LD    HL,(05000H)
        INC   (HL)
L150:
        JP    L142
L151:
        ;;test1.j(74)   // byte - integer
L152:
        ;;test1.j(75)   i=103;
L153:
        LD    A,103
L154:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L155:
        ;;test1.j(76)   b=102;
L156:
        LD    A,102
L157:
        LD    (05000H),A
L158:
        ;;test1.j(77)   while (b <= i+0) { write (b); b--; i=i-2; }
L159:
        LD    HL,(05001H)
L160:
        LD    DE,0
        ADD   HL,DE
L161:
        LD    A,(05000H)
L162:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L163:
        JR    Z,$+5
        JP    C,L173
L164:
        LD    A,(05000H)
L165:
        CALL  writeA
L166:
        LD    HL,(05000H)
        DEC   (HL)
L167:
        LD    HL,(05001H)
L168:
        LD    DE,2
        OR    A
        SBC   HL,DE
L169:
        LD    (05001H),HL
L170:
        JP    L159
L171:
        ;;test1.j(78)   // integer - byte
L172:
        ;;test1.j(79)   i=100;
L173:
        LD    A,100
L174:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L175:
        ;;test1.j(80)   while (i <= 101+0) { write (b); b--; i++; }
L176:
        LD    A,101
L177:
        ADD   A,0
L178:
        LD    HL,(05001H)
L179:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L180:
        JR    Z,$+5
        JP    C,L188
L181:
        LD    A,(05000H)
L182:
        CALL  writeA
L183:
        LD    HL,(05000H)
        DEC   (HL)
L184:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L185:
        JP    L176
L186:
        ;;test1.j(81)   // integer - integer
L187:
        ;;test1.j(82)   i=1098;
L188:
        LD    HL,1098
L189:
        LD    (05001H),HL
L190:
        ;;test1.j(83)   while (i <= 1099+0) { write (b); b--; i++; }
L191:
        LD    HL,1099
L192:
        LD    DE,0
        ADD   HL,DE
L193:
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
L194:
        JP    C,L205
L195:
        LD    A,(05000H)
L196:
        CALL  writeA
L197:
        LD    HL,(05000H)
        DEC   (HL)
L198:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L199:
        JP    L191
L200:
        ;;test1.j(84) 
L201:
        ;;test1.j(85)   /************************/
L202:
        ;;test1.j(86)   // var - constant
L203:
        ;;test1.j(87)   // byte - byte
L204:
        ;;test1.j(88)   i=96;
L205:
        LD    A,96
L206:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L207:
        ;;test1.j(89)   b=96;
L208:
        LD    A,96
L209:
        LD    (05000H),A
L210:
        ;;test1.j(90)   while (b <= 97) { write (i); i--; b++; }
L211:
        LD    A,(05000H)
L212:
        SUB   A,97
L213:
        JR    Z,$+5
        JP    C,L222
L214:
        LD    HL,(05001H)
L215:
        CALL  writeHL
L216:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L217:
        LD    HL,(05000H)
        INC   (HL)
L218:
        JP    L211
L219:
        ;;test1.j(91)   // byte - integer
L220:
        ;;test1.j(92)   //not relevant
L221:
        ;;test1.j(93)   write(94);
L222:
        LD    A,94
L223:
        CALL  writeA
L224:
        ;;test1.j(94)   write(93);
L225:
        LD    A,93
L226:
        CALL  writeA
L227:
        ;;test1.j(95)   // integer - byte
L228:
        ;;test1.j(96)   i=92;
L229:
        LD    A,92
L230:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L231:
        ;;test1.j(97)   b=92;
L232:
        LD    A,92
L233:
        LD    (05000H),A
L234:
        ;;test1.j(98)   while (i <= 93) { write (b); b--; i++; }
L235:
        LD    HL,(05001H)
L236:
        LD    A,93
L237:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L238:
        JR    Z,$+5
        JP    C,L246
L239:
        LD    A,(05000H)
L240:
        CALL  writeA
L241:
        LD    HL,(05000H)
        DEC   (HL)
L242:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L243:
        JP    L235
L244:
        ;;test1.j(99)   // integer - integer
L245:
        ;;test1.j(100)   i=1090;
L246:
        LD    HL,1090
L247:
        LD    (05001H),HL
L248:
        ;;test1.j(101)   while (i <= 1091) { write (b); b--; i++; }
L249:
        LD    HL,(05001H)
L250:
        LD    DE,1091
        OR    A
        SBC   HL,DE
L251:
        JR    Z,$+5
        JP    C,L263
L252:
        LD    A,(05000H)
L253:
        CALL  writeA
L254:
        LD    HL,(05000H)
        DEC   (HL)
L255:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L256:
        JP    L249
L257:
        ;;test1.j(102) 
L258:
        ;;test1.j(103)   /************************/
L259:
        ;;test1.j(104)   // acc - stack8
L260:
        ;;test1.j(105)   // byte - byte
L261:
        ;;test1.j(106)   //TODO
L262:
        ;;test1.j(107)   write(88);
L263:
        LD    A,88
L264:
        CALL  writeA
L265:
        ;;test1.j(108)   write(87);
L266:
        LD    A,87
L267:
        CALL  writeA
L268:
        ;;test1.j(109)   // byte - integer
L269:
        ;;test1.j(110)   //TODO
L270:
        ;;test1.j(111)   write(86);
L271:
        LD    A,86
L272:
        CALL  writeA
L273:
        ;;test1.j(112)   write(85);
L274:
        LD    A,85
L275:
        CALL  writeA
L276:
        ;;test1.j(113)   // integer - byte
L277:
        ;;test1.j(114)   //TODO
L278:
        ;;test1.j(115)   write(84);
L279:
        LD    A,84
L280:
        CALL  writeA
L281:
        ;;test1.j(116)   write(83);
L282:
        LD    A,83
L283:
        CALL  writeA
L284:
        ;;test1.j(117)   // integer - integer
L285:
        ;;test1.j(118)   //TODO
L286:
        ;;test1.j(119)   write(82);
L287:
        LD    A,82
L288:
        CALL  writeA
L289:
        ;;test1.j(120)   write(81);
L290:
        LD    A,81
L291:
        CALL  writeA
L292:
        ;;test1.j(121) 
L293:
        ;;test1.j(122)   /************************/
L294:
        ;;test1.j(123)   // acc - stack16
L295:
        ;;test1.j(124)   // byte - byte
L296:
        ;;test1.j(125)   //TODO
L297:
        ;;test1.j(126)   write(80);
L298:
        LD    A,80
L299:
        CALL  writeA
L300:
        ;;test1.j(127)   write(79);
L301:
        LD    A,79
L302:
        CALL  writeA
L303:
        ;;test1.j(128)   // byte - integer
L304:
        ;;test1.j(129)   //TODO
L305:
        ;;test1.j(130)   write(78);
L306:
        LD    A,78
L307:
        CALL  writeA
L308:
        ;;test1.j(131)   write(77);
L309:
        LD    A,77
L310:
        CALL  writeA
L311:
        ;;test1.j(132)   // integer - byte
L312:
        ;;test1.j(133)   //TODO
L313:
        ;;test1.j(134)   write(76);
L314:
        LD    A,76
L315:
        CALL  writeA
L316:
        ;;test1.j(135)   write(75);
L317:
        LD    A,75
L318:
        CALL  writeA
L319:
        ;;test1.j(136)   // integer - integer
L320:
        ;;test1.j(137)   //TODO
L321:
        ;;test1.j(138)   write(74);
L322:
        LD    A,74
L323:
        CALL  writeA
L324:
        ;;test1.j(139)   write(73);
L325:
        LD    A,73
L326:
        CALL  writeA
L327:
        ;;test1.j(140) 
L328:
        ;;test1.j(141)   /************************/
L329:
        ;;test1.j(142)   // acc - var
L330:
        ;;test1.j(143)   // byte - byte
L331:
        ;;test1.j(144)   b=72;
L332:
        LD    A,72
L333:
        LD    (05000H),A
L334:
        ;;test1.j(145)   while (71+0 <= b) { write (b); b--; }
L335:
        LD    A,71
L336:
        ADD   A,0
L337:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L338:
        JR    Z,$+5
        JP    C,L345
L339:
        LD    A,(05000H)
L340:
        CALL  writeA
L341:
        LD    HL,(05000H)
        DEC   (HL)
L342:
        JP    L335
L343:
        ;;test1.j(146)   // byte - integer
L344:
        ;;test1.j(147)   i=70;
L345:
        LD    A,70
L346:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L347:
        ;;test1.j(148)   while (69+0 <= i) { write (i); i--; }
L348:
        LD    A,69
L349:
        ADD   A,0
L350:
        LD    HL,(05001H)
L351:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L352:
        JR    Z,$+5
        JP    C,L359
L353:
        LD    HL,(05001H)
L354:
        CALL  writeHL
L355:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L356:
        JP    L348
L357:
        ;;test1.j(149)   // integer - byte
L358:
        ;;test1.j(150)   i=67;
L359:
        LD    A,67
L360:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L361:
        ;;test1.j(151)   b=68;
L362:
        LD    A,68
L363:
        LD    (05000H),A
L364:
        ;;test1.j(152)   while (i+0 <= b) { write (b); b--; } 
L365:
        LD    HL,(05001H)
L366:
        LD    DE,0
        ADD   HL,DE
L367:
        LD    A,(05000H)
L368:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L369:
        JR    Z,$+5
        JP    C,L376
L370:
        LD    A,(05000H)
L371:
        CALL  writeA
L372:
        LD    HL,(05000H)
        DEC   (HL)
L373:
        JP    L365
L374:
        ;;test1.j(153)   // integer - integer
L375:
        ;;test1.j(154)   i=1066;
L376:
        LD    HL,1066
L377:
        LD    (05001H),HL
L378:
        ;;test1.j(155)   while (1000+65 <= i) { write (b); b--; i--; }
L379:
        LD    HL,1000
L380:
        LD    DE,65
        ADD   HL,DE
L381:
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
L382:
        JR    Z,$+5
        JP    C,L393
L383:
        LD    A,(05000H)
L384:
        CALL  writeA
L385:
        LD    HL,(05000H)
        DEC   (HL)
L386:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L387:
        JP    L379
L388:
        ;;test1.j(156) 
L389:
        ;;test1.j(157)   /************************/
L390:
        ;;test1.j(158)   // acc - acc
L391:
        ;;test1.j(159)   // byte - byte
L392:
        ;;test1.j(160)   b=64;
L393:
        LD    A,64
L394:
        LD    (05000H),A
L395:
        ;;test1.j(161)   while (63+0 <= b+0) { write (b); b--; }
L396:
        LD    A,63
L397:
        ADD   A,0
L398:
        PUSH AF
L399:
        LD    A,(05000H)
L400:
        ADD   A,0
L401:
        POP   BC
        SUB   A,B
L402:
        JP    C,L409
L403:
        LD    A,(05000H)
L404:
        CALL  writeA
L405:
        LD    HL,(05000H)
        DEC   (HL)
L406:
        JP    L396
L407:
        ;;test1.j(162)   // byte - integer
L408:
        ;;test1.j(163)   i=62;
L409:
        LD    A,62
L410:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L411:
        ;;test1.j(164)   while (61+0 <= i+0) { write (i); i--; }
L412:
        LD    A,61
L413:
        ADD   A,0
L414:
        PUSH AF
L415:
        LD    HL,(05001H)
L416:
        LD    DE,0
        ADD   HL,DE
L417:
        POP  AF
L418:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L419:
        JR    Z,$+5
        JP    C,L426
L420:
        LD    HL,(05001H)
L421:
        CALL  writeHL
L422:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L423:
        JP    L412
L424:
        ;;test1.j(165)   // integer - byte
L425:
        ;;test1.j(166)   i=59;
L426:
        LD    A,59
L427:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L428:
        ;;test1.j(167)   b=60;
L429:
        LD    A,60
L430:
        LD    (05000H),A
L431:
        ;;test1.j(168)   while (i+0 <= b+0) { write (b); b--; }
L432:
        LD    HL,(05001H)
L433:
        LD    DE,0
        ADD   HL,DE
L434:
        PUSH HL
L435:
        LD    A,(05000H)
L436:
        ADD   A,0
L437:
        POP  HL
L438:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L439:
        JR    Z,$+5
        JP    C,L446
L440:
        LD    A,(05000H)
L441:
        CALL  writeA
L442:
        LD    HL,(05000H)
        DEC   (HL)
L443:
        JP    L432
L444:
        ;;test1.j(169)   // integer - integer
L445:
        ;;test1.j(170)   i=1058;
L446:
        LD    HL,1058
L447:
        LD    (05001H),HL
L448:
        ;;test1.j(171)   while (1000+57 <= i+0) { write (b); b--; i--; }
L449:
        LD    HL,1000
L450:
        LD    DE,57
        ADD   HL,DE
L451:
        PUSH HL
L452:
        LD    HL,(05001H)
L453:
        LD    DE,0
        ADD   HL,DE
L454:
        POP   DE
        OR    A
        SBC   HL,DE
L455:
        JP    C,L466
L456:
        LD    A,(05000H)
L457:
        CALL  writeA
L458:
        LD    HL,(05000H)
        DEC   (HL)
L459:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L460:
        JP    L449
L461:
        ;;test1.j(172) 
L462:
        ;;test1.j(173)   /************************/
L463:
        ;;test1.j(174)   // acc - constant
L464:
        ;;test1.j(175)   // byte - byte
L465:
        ;;test1.j(176)   i=56;
L466:
        LD    A,56
L467:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L468:
        ;;test1.j(177)   b=56;
L469:
        LD    A,56
L470:
        LD    (05000H),A
L471:
        ;;test1.j(178)   while (b+0 <= 57) { write (i); i--; b++; }
L472:
        LD    A,(05000H)
L473:
        ADD   A,0
L474:
        SUB   A,57
L475:
        JR    Z,$+5
        JP    C,L485
L476:
        LD    HL,(05001H)
L477:
        CALL  writeHL
L478:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L479:
        LD    HL,(05000H)
        INC   (HL)
L480:
        JP    L472
L481:
        ;;test1.j(179)   // byte - integer
L482:
        ;;test1.j(180)   //not relevant
L483:
        ;;test1.j(181)   // integer - byte
L484:
        ;;test1.j(182)   i=54;
L485:
        LD    A,54
L486:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L487:
        ;;test1.j(183)   b=54;
L488:
        LD    A,54
L489:
        LD    (05000H),A
L490:
        ;;test1.j(184)   while (i+0 <= 55) { write (b); b--; i++; }
L491:
        LD    HL,(05001H)
L492:
        LD    DE,0
        ADD   HL,DE
L493:
        LD    A,55
L494:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L495:
        JR    Z,$+5
        JP    C,L502
L496:
        LD    A,(05000H)
L497:
        CALL  writeA
L498:
        LD    HL,(05000H)
        DEC   (HL)
L499:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L500:
        JP    L491
L501:
        ;;test1.j(185)   i=1052;
L502:
        LD    HL,1052
L503:
        LD    (05001H),HL
L504:
        ;;test1.j(186)   // integer - integer
L505:
        ;;test1.j(187)   while (i+0 <= 1053) { write (b); b--; i++; }
L506:
        LD    HL,(05001H)
L507:
        LD    DE,0
        ADD   HL,DE
L508:
        LD    DE,1053
        OR    A
        SBC   HL,DE
L509:
        JR    Z,$+5
        JP    C,L521
L510:
        LD    A,(05000H)
L511:
        CALL  writeA
L512:
        LD    HL,(05000H)
        DEC   (HL)
L513:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L514:
        JP    L506
L515:
        ;;test1.j(188) 
L516:
        ;;test1.j(189)   /************************/
L517:
        ;;test1.j(190)   // constant - stack8
L518:
        ;;test1.j(191)   // byte - byte
L519:
        ;;test1.j(192)   //TODO
L520:
        ;;test1.j(193)   write(50);
L521:
        LD    A,50
L522:
        CALL  writeA
L523:
        ;;test1.j(194)   // constant - stack8
L524:
        ;;test1.j(195)   // byte - integer
L525:
        ;;test1.j(196)   //TODO
L526:
        ;;test1.j(197)   write(49);
L527:
        LD    A,49
L528:
        CALL  writeA
L529:
        ;;test1.j(198)   // constant - stack8
L530:
        ;;test1.j(199)   // integer - byte
L531:
        ;;test1.j(200)   //TODO
L532:
        ;;test1.j(201)   write(48);
L533:
        LD    A,48
L534:
        CALL  writeA
L535:
        ;;test1.j(202)   // constant - stack88
L536:
        ;;test1.j(203)   // integer - integer
L537:
        ;;test1.j(204)   //TODO
L538:
        ;;test1.j(205)   write(47);
L539:
        LD    A,47
L540:
        CALL  writeA
L541:
        ;;test1.j(206) 
L542:
        ;;test1.j(207)   /************************/
L543:
        ;;test1.j(208)   // constant - stack16
L544:
        ;;test1.j(209)   // byte - byte
L545:
        ;;test1.j(210)   //TODO
L546:
        ;;test1.j(211)   write(46);
L547:
        LD    A,46
L548:
        CALL  writeA
L549:
        ;;test1.j(212)   // constant - stack16
L550:
        ;;test1.j(213)   // byte - integer
L551:
        ;;test1.j(214)   //TODO
L552:
        ;;test1.j(215)   write(45);
L553:
        LD    A,45
L554:
        CALL  writeA
L555:
        ;;test1.j(216)   // constant - stack16
L556:
        ;;test1.j(217)   // integer - byte
L557:
        ;;test1.j(218)   //TODO
L558:
        ;;test1.j(219)   write(44);
L559:
        LD    A,44
L560:
        CALL  writeA
L561:
        ;;test1.j(220)   // constant - stack16
L562:
        ;;test1.j(221)   // integer - integer
L563:
        ;;test1.j(222)   //TODO
L564:
        ;;test1.j(223)   write(43);
L565:
        LD    A,43
L566:
        CALL  writeA
L567:
        ;;test1.j(224) 
L568:
        ;;test1.j(225)   /************************/
L569:
        ;;test1.j(226)   // constant - var
L570:
        ;;test1.j(227)   // byte - byte
L571:
        ;;test1.j(228)   b=42;
L572:
        LD    A,42
L573:
        LD    (05000H),A
L574:
        ;;test1.j(229)   while (41 <= b) { write (b); b--; }
L575:
        LD    A,(05000H)
L576:
        SUB   A,41
L577:
        JP    C,L586
L578:
        LD    A,(05000H)
L579:
        CALL  writeA
L580:
        LD    HL,(05000H)
        DEC   (HL)
L581:
        JP    L575
L582:
        ;;test1.j(230) 
L583:
        ;;test1.j(231)   // constant - var
L584:
        ;;test1.j(232)   // byte - integer
L585:
        ;;test1.j(233)   i=40;
L586:
        LD    A,40
L587:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L588:
        ;;test1.j(234)   while (39 <= i) { write (i); i--; }
L589:
        LD    HL,(05001H)
L590:
        LD    A,39
L591:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L592:
        JR    Z,$+5
        JP    C,L605
L593:
        LD    HL,(05001H)
L594:
        CALL  writeHL
L595:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L596:
        JP    L589
L597:
        ;;test1.j(235) 
L598:
        ;;test1.j(236)   // constant - var
L599:
        ;;test1.j(237)   // integer - byte
L600:
        ;;test1.j(238)   // not relevant
L601:
        ;;test1.j(239) 
L602:
        ;;test1.j(240)   // constant - var
L603:
        ;;test1.j(241)   // integer - integer
L604:
        ;;test1.j(242)   i=1038;
L605:
        LD    HL,1038
L606:
        LD    (05001H),HL
L607:
        ;;test1.j(243)   b=38;
L608:
        LD    A,38
L609:
        LD    (05000H),A
L610:
        ;;test1.j(244)   while (1037 <= i) { write (b); b--; i--; }
L611:
        LD    HL,(05001H)
L612:
        LD    DE,1037
        OR    A
        SBC   HL,DE
L613:
        JP    C,L624
L614:
        LD    A,(05000H)
L615:
        CALL  writeA
L616:
        LD    HL,(05000H)
        DEC   (HL)
L617:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L618:
        JP    L611
L619:
        ;;test1.j(245) 
L620:
        ;;test1.j(246)   /************************/
L621:
        ;;test1.j(247)   // constant - acc
L622:
        ;;test1.j(248)   // byte - byte
L623:
        ;;test1.j(249)   b=36;
L624:
        LD    A,36
L625:
        LD    (05000H),A
L626:
        ;;test1.j(250)   while (135 == b+100) { write (b); b--; }
L627:
        LD    A,(05000H)
L628:
        ADD   A,100
L629:
        SUB   A,135
L630:
        JP    NZ,L636
L631:
        LD    A,(05000H)
L632:
        CALL  writeA
L633:
        LD    HL,(05000H)
        DEC   (HL)
L634:
        JP    L627
L635:
        ;;test1.j(251)   while (132 != b+100) { write (b); b--; }
L636:
        LD    A,(05000H)
L637:
        ADD   A,100
L638:
        SUB   A,132
L639:
        JP    Z,L645
L640:
        LD    A,(05000H)
L641:
        CALL  writeA
L642:
        LD    HL,(05000H)
        DEC   (HL)
L643:
        JP    L636
L644:
        ;;test1.j(252)   p=32;
L645:
        LD    A,32
L646:
        LD    L,A
        LD    H,0
        LD    (05005H),HL
L647:
        ;;test1.j(253)   while (134 > b+100) { write (p); p--; b++; }
L648:
        LD    A,(05000H)
L649:
        ADD   A,100
L650:
        SUB   A,134
L651:
        JP    NC,L658
L652:
        LD    HL,(05005H)
L653:
        CALL  writeHL
L654:
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
L655:
        LD    HL,(05000H)
        INC   (HL)
L656:
        JP    L648
L657:
        ;;test1.j(254)   while (135 >= b+100) { write (p); p--; b++; }
L658:
        LD    A,(05000H)
L659:
        ADD   A,100
L660:
        SUB   A,135
L661:
        JR    Z,$+5
        JP    C,L668
L662:
        LD    HL,(05005H)
L663:
        CALL  writeHL
L664:
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
L665:
        LD    HL,(05000H)
        INC   (HL)
L666:
        JP    L658
L667:
        ;;test1.j(255)   b=28;
L668:
        LD    A,28
L669:
        LD    (05000H),A
L670:
        ;;test1.j(256)   while (126 <  b+100) { write (b); b--; }
L671:
        LD    A,(05000H)
L672:
        ADD   A,100
L673:
        SUB   A,126
L674:
        JP    Z,L680
L675:
        LD    A,(05000H)
L676:
        CALL  writeA
L677:
        LD    HL,(05000H)
        DEC   (HL)
L678:
        JP    L671
L679:
        ;;test1.j(257)   while (125 <= b+100) { write (b); b--; }
L680:
        LD    A,(05000H)
L681:
        ADD   A,100
L682:
        SUB   A,125
L683:
        JP    C,L691
L684:
        LD    A,(05000H)
L685:
        CALL  writeA
L686:
        LD    HL,(05000H)
        DEC   (HL)
L687:
        JP    L680
L688:
        ;;test1.j(258)   // constant - acc
L689:
        ;;test1.j(259)   // byte - integer
L690:
        ;;test1.j(260)   i=24;
L691:
        LD    A,24
L692:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L693:
        ;;test1.j(261)   b=23;
L694:
        LD    A,23
L695:
        LD    (05000H),A
L696:
        ;;test1.j(262)   while (23 == i+0) { write (i); i--; }
L697:
        LD    HL,(05001H)
L698:
        LD    DE,0
        ADD   HL,DE
L699:
        LD    A,23
L700:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L701:
        JP    NZ,L707
L702:
        LD    HL,(05001H)
L703:
        CALL  writeHL
L704:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L705:
        JP    L697
L706:
        ;;test1.j(263)   while (120 != i+100) { write (i); i--; }
L707:
        LD    HL,(05001H)
L708:
        LD    DE,100
        ADD   HL,DE
L709:
        LD    A,120
L710:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L711:
        JP    Z,L717
L712:
        LD    HL,(05001H)
L713:
        CALL  writeHL
L714:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L715:
        JP    L707
L716:
        ;;test1.j(264)   p=20;
L717:
        LD    A,20
L718:
        LD    L,A
        LD    H,0
        LD    (05005H),HL
L719:
        ;;test1.j(265)   while (122 > i+100) { write (p); p--; i++; }
L720:
        LD    HL,(05001H)
L721:
        LD    DE,100
        ADD   HL,DE
L722:
        LD    A,122
L723:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L724:
        JP    Z,L731
L725:
        LD    HL,(05005H)
L726:
        CALL  writeHL
L727:
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
L728:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L729:
        JP    L720
L730:
        ;;test1.j(266)   while (123 >= i+100) { write (p); p--; i++; }
L731:
        LD    HL,(05001H)
L732:
        LD    DE,100
        ADD   HL,DE
L733:
        LD    A,123
L734:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L735:
        JP    C,L742
L736:
        LD    HL,(05005H)
L737:
        CALL  writeHL
L738:
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
L739:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L740:
        JP    L731
L741:
        ;;test1.j(267)   i=16;
L742:
        LD    A,16
L743:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L744:
        ;;test1.j(268)   while (114 <  i+100) { write (i); i--; }
L745:
        LD    HL,(05001H)
L746:
        LD    DE,100
        ADD   HL,DE
L747:
        LD    A,114
L748:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L749:
        JP    NC,L755
L750:
        LD    HL,(05001H)
L751:
        CALL  writeHL
L752:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L753:
        JP    L745
L754:
        ;;test1.j(269)   while (113 <= i+100) { write (i); i--; }
L755:
        LD    HL,(05001H)
L756:
        LD    DE,100
        ADD   HL,DE
L757:
        LD    A,113
L758:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L759:
        JR    Z,$+5
        JP    C,L771
L760:
        LD    HL,(05001H)
L761:
        CALL  writeHL
L762:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L763:
        JP    L755
L764:
        ;;test1.j(270)   // constant - acc
L765:
        ;;test1.j(271)   // integer - byte
L766:
        ;;test1.j(272)   // not relevant
L767:
        ;;test1.j(273) 
L768:
        ;;test1.j(274)   // constant - acc
L769:
        ;;test1.j(275)   // integer - integer
L770:
        ;;test1.j(276)   i=12;
L771:
        LD    A,12
L772:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L773:
        ;;test1.j(277)   while (1011 == i+1000) { write (i); i--; }
L774:
        LD    HL,(05001H)
L775:
        LD    DE,1000
        ADD   HL,DE
L776:
        LD    DE,1011
        OR    A
        SBC   HL,DE
L777:
        JP    NZ,L784
L778:
        LD    HL,(05001H)
L779:
        CALL  writeHL
L780:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L781:
        JP    L774
L782:
        ;;test1.j(278)   //i=10
L783:
        ;;test1.j(279)   while (1008 != i+1000) { write (i); i--; }
L784:
        LD    HL,(05001H)
L785:
        LD    DE,1000
        ADD   HL,DE
L786:
        LD    DE,1008
        OR    A
        SBC   HL,DE
L787:
        JP    Z,L794
L788:
        LD    HL,(05001H)
L789:
        CALL  writeHL
L790:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L791:
        JP    L784
L792:
        ;;test1.j(280)   //i=8
L793:
        ;;test1.j(281)   p=8;
L794:
        LD    A,8
L795:
        LD    L,A
        LD    H,0
        LD    (05005H),HL
L796:
        ;;test1.j(282)   while (1010 > i+1000) { write (p); p--; i++; }
L797:
        LD    HL,(05001H)
L798:
        LD    DE,1000
        ADD   HL,DE
L799:
        LD    DE,1010
        OR    A
        SBC   HL,DE
L800:
        JP    NC,L808
L801:
        LD    HL,(05005H)
L802:
        CALL  writeHL
L803:
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
L804:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L805:
        JP    L797
L806:
        ;;test1.j(283)   //i=10; p=6
L807:
        ;;test1.j(284)   while (1011 >= i+1000) { write (p); p--; i++; }
L808:
        LD    HL,(05001H)
L809:
        LD    DE,1000
        ADD   HL,DE
L810:
        LD    DE,1011
        OR    A
        SBC   HL,DE
L811:
        JR    Z,$+5
        JP    C,L818
L812:
        LD    HL,(05005H)
L813:
        CALL  writeHL
L814:
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
L815:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L816:
        JP    L808
L817:
        ;;test1.j(285)   i=4;
L818:
        LD    A,4
L819:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L820:
        ;;test1.j(286)   while (1002 <  i+1000) { write (i); i--; }
L821:
        LD    HL,(05001H)
L822:
        LD    DE,1000
        ADD   HL,DE
L823:
        LD    DE,1002
        OR    A
        SBC   HL,DE
L824:
        JP    Z,L831
L825:
        LD    HL,(05001H)
L826:
        CALL  writeHL
L827:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L828:
        JP    L821
L829:
        ;;test1.j(287)   //i=2;
L830:
        ;;test1.j(288)   while (1001 <= i+1000) { write (i); i--; }
L831:
        LD    HL,(05001H)
L832:
        LD    DE,1000
        ADD   HL,DE
L833:
        LD    DE,1001
        OR    A
        SBC   HL,DE
L834:
        JP    C,L844
L835:
        LD    HL,(05001H)
L836:
        CALL  writeHL
L837:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L838:
        JP    L831
L839:
        ;;test1.j(289) 
L840:
        ;;test1.j(290)   /************************/
L841:
        ;;test1.j(291)   // constant - constant
L842:
        ;;test1.j(292)   // not relevant
L843:
        ;;test1.j(293)   write(0);
L844:
        LD    A,0
L845:
        CALL  writeA
L846:
        ;;test1.j(294) }
L847:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
