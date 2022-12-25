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
;T = dividend
;D = divisor
;Q = quotient = 0
;R = remainder = 0
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
; RT = T % 10^k     
; T' = (T-RT) / 10^k
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
        PUSH  BC          ;11  11 save registers used
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
        ;;test5.j(0) /*
        ;;test5.j(1)  * A small program in the miniJava language.
        ;;test5.j(2)  * Test comparisons
        ;;test5.j(3)  */
        ;;test5.j(4) class TestIf {
        ;;test5.j(5)   int zero = 0;
        LD    A,0
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test5.j(6)   int one = 1;
        LD    A,1
        LD    L,A
        LD    H,0
        LD    (05002H),HL
        ;;test5.j(7)   int three = 3;
        LD    A,3
        LD    L,A
        LD    H,0
        LD    (05004H),HL
        ;;test5.j(8)   int four = 4;
        LD    A,4
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;;test5.j(9)   int five = 5;
        LD    A,5
        LD    L,A
        LD    H,0
        LD    (05008H),HL
        ;;test5.j(10)   int twelve = 12;
        LD    A,12
        LD    L,A
        LD    H,0
        LD    (0500AH),HL
        ;;test5.j(11)   byte byteOne = 1;
        LD    A,1
        LD    (0500CH),A
        ;;test5.j(12)   byte byteSix = 262;
        LD    HL,262
        LD    A,L
        LD    (0500DH),A
        ;;test5.j(13)   write(133);
        LD    A,133
        CALL  writeA
        ;;test5.j(14)   if (4 == zero + twelve/(1+2)) write(132);
        LD    HL,(05000H)
        PUSH  HL
        LD    HL,(0500AH)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        POP   DE
        ADD   HL,DE
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NZ,L45
        LD    A,132
        CALL  writeA
        ;;test5.j(15)   if (four == 0 + 12/(one + 2)) write(131);
        LD    A,0
        PUSH  AF
        LD    A,12
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        EX    DE,HL
        CALL  div8_16
        POP   DE
        LD    D,0
        ADD   HL,DE
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
        JP    NZ,L56
        LD    A,131
        CALL  writeA
        ;;test5.j(16)   if (four == 0 + 12/(byteOne + 2)) write(130);
        LD    A,0
        PUSH  AF
        LD    A,12
        PUSH  AF
        LD    A,(0500CH)
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP   BC
        ADD   A,B
        LD    HL,(05006H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NZ,L68
        LD    A,130
        CALL  writeA
        ;;test5.j(17)   if (four == 0 + 12/(1 + 2)) write(129);
        LD    A,0
        PUSH  AF
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP   BC
        ADD   A,B
        LD    HL,(05006H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NZ,L80
        LD    A,129
        CALL  writeA
        ;;test5.j(18)   if (four == 0 + 12/(1 + 2)) write(128);
        LD    A,0
        PUSH  AF
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP   BC
        ADD   A,B
        LD    HL,(05006H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NZ,L93
        LD    A,128
        CALL  writeA
        ;;test5.j(19)   //stack level 2
        ;;test5.j(20)   if (5 >= twelve/(one+2)) write(127);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    A,5
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L103
        LD    A,127
        CALL  writeA
        ;;test5.j(21)   if (4 >= twelve/(one+2)) write(126);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L113
        LD    A,126
        CALL  writeA
        ;;test5.j(22)   if (4 <= twelve/(one+2)) write(125);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L123
        LD    A,125
        CALL  writeA
        ;;test5.j(23)   if (3 <= twelve/(one+2)) write(124);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L133
        LD    A,124
        CALL  writeA
        ;;test5.j(24)   if (5 > twelve/(one+2)) write(123);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    A,5
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L143
        LD    A,123
        CALL  writeA
        ;;test5.j(25)   if (2 < twelve/(one+2)) write(122);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    A,2
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L153
        LD    A,122
        CALL  writeA
        ;;test5.j(26)   if (3 != twelve/(one+2)) write(121);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L163
        LD    A,121
        CALL  writeA
        ;;test5.j(27)   if (4 == twelve/(one+2)) write(120);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NZ,L173
        LD    A,120
        CALL  writeA
        ;;test5.j(28)   if (5 >= 12/(1+2)) write(119);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,5
        JP    Z,$+5
        JP    C,L182
        LD    A,119
        CALL  writeA
        ;;test5.j(29)   if (4 >= 12/(1+2)) write(118);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,4
        JP    Z,$+5
        JP    C,L191
        LD    A,118
        CALL  writeA
        ;;test5.j(30)   if (4 <= 12/(1+2)) write(117);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,4
        JP    C,L200
        LD    A,117
        CALL  writeA
        ;;test5.j(31)   if (3 <= 12/(1+2)) write(116);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,3
        JP    C,L209
        LD    A,116
        CALL  writeA
        ;;test5.j(32)   if (5 > 12/(1+2)) write(115);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,5
        JP    NC,L218
        LD    A,115
        CALL  writeA
        ;;test5.j(33)   if (3 < 12/(1+2)) write(114);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,3
        JP    Z,L227
        LD    A,114
        CALL  writeA
        ;;test5.j(34)   if (3 != 12/(1+2)) write(113);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,3
        JP    Z,L236
        LD    A,113
        CALL  writeA
        ;;test5.j(35)   if (4 == 12/(1+2)) write(112);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,4
        JP    NZ,L245
        LD    A,112
        CALL  writeA
        ;;test5.j(36)   if (1+4 >= twelve/(one+2)) write(111);
        LD    A,1
        ADD   A,4
        PUSH AF
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L258
        LD    A,111
        CALL  writeA
        ;;test5.j(37)   if (1+3 >= twelve/(one+2)) write(110);
        LD    A,1
        ADD   A,3
        PUSH AF
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L271
        LD    A,110
        CALL  writeA
        ;;test5.j(38)   if (1+3 <= twelve/(one+2)) write(109);
        LD    A,1
        ADD   A,3
        PUSH AF
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L284
        LD    A,109
        CALL  writeA
        ;;test5.j(39)   if (1+2 <= twelve/(one+2)) write(108);
        LD    A,1
        ADD   A,2
        PUSH AF
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L297
        LD    A,108
        CALL  writeA
        ;;test5.j(40)   if (1+4 > twelve/(one+2)) write(107);
        LD    A,1
        ADD   A,4
        PUSH AF
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L310
        LD    A,107
        CALL  writeA
        ;;test5.j(41)   if (1+2 < twelve/(one+2)) write(106);
        LD    A,1
        ADD   A,2
        PUSH AF
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L323
        LD    A,106
        CALL  writeA
        ;;test5.j(42)   if (1+2 != twelve/(one+2)) write(105);
        LD    A,1
        ADD   A,2
        PUSH AF
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L336
        LD    A,105
        CALL  writeA
        ;;test5.j(43)   if (1+3 == twelve/(one+2)) write(104);
        LD    A,1
        ADD   A,3
        PUSH AF
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NZ,L349
        LD    A,104
        CALL  writeA
        ;;test5.j(44)   if (1+4 >= 12/(1+2)) write(103);
        LD    A,1
        ADD   A,4
        PUSH AF
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP   BC
        SUB   A,B
        JP    Z,$+5
        JP    C,L361
        LD    A,103
        CALL  writeA
        ;;test5.j(45)   if (1+3 >= 12/(1+2)) write(102);
        LD    A,1
        ADD   A,3
        PUSH AF
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP   BC
        SUB   A,B
        JP    Z,$+5
        JP    C,L373
        LD    A,102
        CALL  writeA
        ;;test5.j(46)   if (1+3 <= 12/(1+2)) write(101);
        LD    A,1
        ADD   A,3
        PUSH AF
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP   BC
        SUB   A,B
        JP    C,L385
        LD    A,101
        CALL  writeA
        ;;test5.j(47)   if (1+2 <= 12/(1+2)) write(100);
        LD    A,1
        ADD   A,2
        PUSH AF
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP   BC
        SUB   A,B
        JP    C,L397
        LD    A,100
        CALL  writeA
        ;;test5.j(48)   if (1+4 > 12/(1+2)) write(99);
        LD    A,1
        ADD   A,4
        PUSH AF
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP   BC
        SUB   A,B
        JP    NC,L409
        LD    A,99
        CALL  writeA
        ;;test5.j(49)   if (1+2 < 12/(1+2)) write(98);
        LD    A,1
        ADD   A,2
        PUSH AF
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP   BC
        SUB   A,B
        JP    Z,L421
        LD    A,98
        CALL  writeA
        ;;test5.j(50)   if (1+2 != 12/(1+2)) write(97);
        LD    A,1
        ADD   A,2
        PUSH AF
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP   BC
        SUB   A,B
        JP    Z,L433
        LD    A,97
        CALL  writeA
        ;;test5.j(51)   if (1+3 == 12/(1+2)) write(96);
        LD    A,1
        ADD   A,3
        PUSH AF
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP   BC
        SUB   A,B
        JP    NZ,L445
        LD    A,96
        CALL  writeA
        ;;test5.j(52)   if (twelve >= twelve/(one+2)) write(95);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    DE,(0500AH)
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L454
        LD    A,95
        CALL  writeA
        ;;test5.j(53)   if (four >= twelve/(one+2)) write(94);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L463
        LD    A,94
        CALL  writeA
        ;;test5.j(54)   if (three <= twelve/(one+2)) write(93);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
        JP    C,L472
        LD    A,93
        CALL  writeA
        ;;test5.j(55)   if (four <= twelve/(one+2)) write(92);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
        JP    C,L481
        LD    A,92
        CALL  writeA
        ;;test5.j(56)   if (twelve > twelve/(one+2)) write(91);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    DE,(0500AH)
        OR    A
        SBC   HL,DE
        JP    NC,L490
        LD    A,91
        CALL  writeA
        ;;test5.j(57)   if (three < twelve/(one+2)) write(90);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
        JP    Z,L499
        LD    A,90
        CALL  writeA
        ;;test5.j(58)   if (three != twelve/(one+2)) write(89);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
        JP    Z,L508
        LD    A,89
        CALL  writeA
        ;;test5.j(59)   if (four == twelve/(one+2)) write(88);
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
        JP    NZ,L517
        LD    A,88
        CALL  writeA
        ;;test5.j(60)   if (twelve >= 12/(1+2)) write(87);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(0500AH)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    C,L527
        LD    A,87
        CALL  writeA
        ;;test5.j(61)   if (four >= 12/(1+2)) write(86);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05006H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    C,L537
        LD    A,86
        CALL  writeA
        ;;test5.j(62)   if (three <= 12/(1+2)) write(85);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05004H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L547
        LD    A,85
        CALL  writeA
        ;;test5.j(63)   if (four <= 12/(1+2)) write(84);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05006H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L557
        LD    A,84
        CALL  writeA
        ;;test5.j(64)   if (twelve > 12/(1+2)) write(83);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(0500AH)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L567
        LD    A,83
        CALL  writeA
        ;;test5.j(65)   if (three < 12/(1+2)) write(82);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05004H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NC,L577
        LD    A,82
        CALL  writeA
        ;;test5.j(66)   if (three != 12/(1+2)) write(81);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05004H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L587
        LD    A,81
        CALL  writeA
        ;;test5.j(67)   if (four == 12/(1+2)) write(80);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05006H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NZ,L597
        LD    A,80
        CALL  writeA
        ;;test5.j(68)   if (one+four >= twelve/(one+2)) write(79);
        LD    HL,(05002H)
        LD    DE,(05006H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L609
        LD    A,79
        CALL  writeA
        ;;test5.j(69)   if (one+three >= twelve/(one+2)) write(78);
        LD    HL,(05002H)
        LD    DE,(05004H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L621
        LD    A,78
        CALL  writeA
        ;;test5.j(70)   if (one+three <= twelve/(one+2)) write(77);
        LD    HL,(05002H)
        LD    DE,(05004H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    C,L633
        LD    A,77
        CALL  writeA
        ;;test5.j(71)   if (one+one <= twelve/(one+2)) write(76);
        LD    HL,(05002H)
        LD    DE,(05002H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    C,L645
        LD    A,76
        CALL  writeA
        ;;test5.j(72)   if (one+four > twelve/(one+2)) write(75);
        LD    HL,(05002H)
        LD    DE,(05006H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    NC,L657
        LD    A,75
        CALL  writeA
        ;;test5.j(73)   if (one+one < twelve/(one+2)) write(74);
        LD    HL,(05002H)
        LD    DE,(05002H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,L669
        LD    A,74
        CALL  writeA
        ;;test5.j(74)   if (one+four  != twelve/(one+2)) write(73);
        LD    HL,(05002H)
        LD    DE,(05006H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,L681
        LD    A,73
        CALL  writeA
        ;;test5.j(75)   if (one+three == twelve/(one+2)) write(72);
        LD    HL,(05002H)
        LD    DE,(05004H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(0500AH)
        PUSH  HL
        LD    HL,(05002H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    NZ,L693
        LD    A,72
        CALL  writeA
        ;;test5.j(76)   if (one+four >= 12/(1+2)) write(71);
        LD    HL,(05002H)
        LD    DE,(05006H)
        ADD   HL,DE
        PUSH HL
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP  HL
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    C,L706
        LD    A,71
        CALL  writeA
        ;;test5.j(77)   if (one+three >= 12/(1+2)) write(70);
        LD    HL,(05002H)
        LD    DE,(05004H)
        ADD   HL,DE
        PUSH HL
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP  HL
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    C,L719
        LD    A,70
        CALL  writeA
        ;;test5.j(78)   if (one+three <= 12/(1+2)) write(69);
        LD    HL,(05002H)
        LD    DE,(05004H)
        ADD   HL,DE
        PUSH HL
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP  HL
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L732
        LD    A,69
        CALL  writeA
        ;;test5.j(79)   if (one+one <= 12/(1+2)) write(68);
        LD    HL,(05002H)
        LD    DE,(05002H)
        ADD   HL,DE
        PUSH HL
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP  HL
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L745
        LD    A,68
        CALL  writeA
        ;;test5.j(80)   if (one+four > 12/(1+2)) write(67);
        LD    HL,(05002H)
        LD    DE,(05006H)
        ADD   HL,DE
        PUSH HL
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP  HL
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L758
        LD    A,67
        CALL  writeA
        ;;test5.j(81)   if (one+one < 12/(1+2)) write(66);
        LD    HL,(05002H)
        LD    DE,(05002H)
        ADD   HL,DE
        PUSH HL
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP  HL
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NC,L771
        LD    A,66
        CALL  writeA
        ;;test5.j(82)   if (one+four  != 12/(1+2)) write(65);
        LD    HL,(05002H)
        LD    DE,(05006H)
        ADD   HL,DE
        PUSH HL
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP  HL
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L784
        LD    A,65
        CALL  writeA
        ;;test5.j(83)   if (one+three == 12/(1+2)) write(64);
        LD    HL,(05002H)
        LD    DE,(05004H)
        ADD   HL,DE
        PUSH HL
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        POP  HL
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NZ,L799
        LD    A,64
        CALL  writeA
        ;;test5.j(84)   //stack level 1
        ;;test5.j(85)   //integer-byte
        ;;test5.j(86)   if (four >= 4) write(63);
        LD    HL,(05006H)
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    C,L806
        LD    A,63
        CALL  writeA
        ;;test5.j(87)   if (four >= 12/(1+2)) write(62);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05006H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    C,L816
        LD    A,62
        CALL  writeA
        ;;test5.j(88)   if (five >= 4) write(61);
        LD    HL,(05008H)
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    C,L823
        LD    A,61
        CALL  writeA
        ;;test5.j(89)   if (five >= 12/(1+2)) write(60);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05008H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    C,L833
        LD    A,60
        CALL  writeA
        ;;test5.j(90)   if (four <= 4) write(59);
        LD    HL,(05006H)
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L840
        LD    A,59
        CALL  writeA
        ;;test5.j(91)   if (four <= 12/(1+2)) write(58);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05006H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L850
        LD    A,58
        CALL  writeA
        ;;test5.j(92)   if (three <= 4) write(57);
        LD    HL,(05004H)
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L857
        LD    A,57
        CALL  writeA
        ;;test5.j(93)   if (three <= 12/(1+2)) write(56);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05004H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L867
        LD    A,56
        CALL  writeA
        ;;test5.j(94)   if (five > 4) write(55);
        LD    HL,(05008H)
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L874
        LD    A,55
        CALL  writeA
        ;;test5.j(95)   if (five > 12/(1+2)) write(54);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05008H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L884
        LD    A,54
        CALL  writeA
        ;;test5.j(96)   if (three < 4) write(53);
        LD    HL,(05004H)
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NC,L891
        LD    A,53
        CALL  writeA
        ;;test5.j(97)   if (three < 12/(1+2)) write(52);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05004H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NC,L901
        LD    A,52
        CALL  writeA
        ;;test5.j(98)   if (three != 4) write(51);
        LD    HL,(05004H)
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L908
        LD    A,51
        CALL  writeA
        ;;test5.j(99)   if (three != 12/(1+2)) write(50);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05004H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L918
        LD    A,50
        CALL  writeA
        ;;test5.j(100)   if (four == 4) write(49);
        LD    HL,(05006H)
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NZ,L925
        LD    A,49
        CALL  writeA
        ;;test5.j(101)   if (four == 12/(1+2)) write(48);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        LD    HL,(05006H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NZ,L936
        LD    A,48
        CALL  writeA
        ;;test5.j(102)   //byte-integer
        ;;test5.j(103)   if (4 >= four) write(47);
        LD    HL,(05006H)
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L943
        LD    A,47
        CALL  writeA
        ;;test5.j(104)   if (4 >= twelve/(1+2)) write(46);
        LD    HL,(0500AH)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L953
        LD    A,46
        CALL  writeA
        ;;test5.j(105)   if (5 >= four) write(45);
        LD    HL,(05006H)
        LD    A,5
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L960
        LD    A,45
        CALL  writeA
        ;;test5.j(106)   if (5 >= twelve/(1+2)) write(44);
        LD    HL,(0500AH)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,5
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L970
        LD    A,44
        CALL  writeA
        ;;test5.j(107)   if (4 <= four) write(43);
        LD    HL,(05006H)
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L977
        LD    A,43
        CALL  writeA
        ;;test5.j(108)   if (4 <= twelve/(1+2)) write(42);
        LD    HL,(0500AH)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L987
        LD    A,42
        CALL  writeA
        ;;test5.j(109)   if (3 <= four) write(41);
        LD    HL,(05006H)
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L994
        LD    A,41
        CALL  writeA
        ;;test5.j(110)   if (3 <= twelve/(1+2)) write(40);
        LD    HL,(0500AH)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1004
        LD    A,40
        CALL  writeA
        ;;test5.j(111)   if (5 > four) write(39);
        LD    HL,(05006H)
        LD    A,5
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L1011
        LD    A,39
        CALL  writeA
        ;;test5.j(112)   if (5 > twelve/(1+2)) write(38);
        LD    HL,(0500AH)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,5
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L1021
        LD    A,38
        CALL  writeA
        ;;test5.j(113)   if (3 < four) write(37);
        LD    HL,(05006H)
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L1028
        LD    A,37
        CALL  writeA
        ;;test5.j(114)   if (3 < twelve/(1+2)) write(36);
        LD    HL,(0500AH)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L1038
        LD    A,36
        CALL  writeA
        ;;test5.j(115)   if (3 != four) write(35);
        LD    HL,(05006H)
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L1045
        LD    A,35
        CALL  writeA
        ;;test5.j(116)   if (3 != twelve/(1+2)) write(34);
        LD    HL,(0500AH)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L1055
        LD    A,34
        CALL  writeA
        ;;test5.j(117)   if (4 == four) write(33);
        LD    HL,(05006H)
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NZ,L1062
        LD    A,33
        CALL  writeA
        ;;test5.j(118)   if (4 == twelve/(1+2)) write(32);
        LD    HL,(0500AH)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NZ,L1073
        LD    A,32
        CALL  writeA
        ;;test5.j(119)   //integer-integer
        ;;test5.j(120)   if (400 >= 400) write(31);
        LD    HL,400
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    C,L1079
        LD    A,31
        CALL  writeA
        ;;test5.j(121)   if (400 >= 1200/(1+2)) write(30);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1088
        LD    A,30
        CALL  writeA
        ;;test5.j(122)   if (500 >= 400) write(29);
        LD    HL,500
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    C,L1094
        LD    A,29
        CALL  writeA
        ;;test5.j(123)   if (500 >= 1200/(1+2)) write(28);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,500
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1103
        LD    A,28
        CALL  writeA
        ;;test5.j(124)   if (400 <= 400) write(27);
        LD    HL,400
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1109
        LD    A,27
        CALL  writeA
        ;;test5.j(125)   if (400 <= 1200/(1+2)) write(26);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    C,L1118
        LD    A,26
        CALL  writeA
        ;;test5.j(126)   if (300 <= 400) write(25);
        LD    HL,300
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1124
        LD    A,25
        CALL  writeA
        ;;test5.j(127)   if (300 <= 1200/(1+2)) write(24);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,300
        OR    A
        SBC   HL,DE
        JP    C,L1133
        LD    A,24
        CALL  writeA
        ;;test5.j(128)   if (500 > 400) write(23);
        LD    HL,500
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    Z,L1139
        LD    A,23
        CALL  writeA
        ;;test5.j(129)   if (500 > 1200/(1+2)) write(22);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,500
        OR    A
        SBC   HL,DE
        JP    NC,L1148
        LD    A,22
        CALL  writeA
        ;;test5.j(130)   if (300 < 400) write(21);
        LD    HL,300
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    NC,L1154
        LD    A,21
        CALL  writeA
        ;;test5.j(131)   if (300 < 1200/(1+2)) write(20);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,300
        OR    A
        SBC   HL,DE
        JP    Z,L1163
        LD    A,20
        CALL  writeA
        ;;test5.j(132)   if (300 != 400) write(19);
        LD    HL,300
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    Z,L1169
        LD    A,19
        CALL  writeA
        ;;test5.j(133)   if (300 != 1200/(1+2)) write(18);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,300
        OR    A
        SBC   HL,DE
        JP    Z,L1178
        LD    A,18
        CALL  writeA
        ;;test5.j(134)   if (400 == 400) write(17);
        LD    HL,400
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    NZ,L1184
        LD    A,17
        CALL  writeA
        ;;test5.j(135)   if (400 == 1200/(1+2)) write(16);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    NZ,L1194
        LD    A,16
        CALL  writeA
        ;;test5.j(136)   //byte-byte
        ;;test5.j(137)   if (4 >= 4) write(15);
        LD    A,4
        SUB   A,4
        JP    C,L1200
        LD    A,15
        CALL  writeA
        ;;test5.j(138)   if (4 >= 12/(1+2)) write(14);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,4
        JP    Z,$+5
        JP    C,L1209
        LD    A,14
        CALL  writeA
        ;;test5.j(139)   if (5 >= 4) write(13);
        LD    A,5
        SUB   A,4
        JP    C,L1215
        LD    A,13
        CALL  writeA
        ;;test5.j(140)   if (5 >= 12/(1+2)) write(12);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,5
        JP    Z,$+5
        JP    C,L1224
        LD    A,12
        CALL  writeA
        ;;test5.j(141)   if (4 <= 4) write(11);
        LD    A,4
        SUB   A,4
        JP    Z,$+5
        JP    C,L1230
        LD    A,11
        CALL  writeA
        ;;test5.j(142)   if (4 <= 12/(1+2)) write(10);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,4
        JP    C,L1239
        LD    A,10
        CALL  writeA
        ;;test5.j(143)   if (3 <= 4) write(9);
        LD    A,3
        SUB   A,4
        JP    Z,$+5
        JP    C,L1245
        LD    A,9
        CALL  writeA
        ;;test5.j(144)   if (3 <= 12/(1+2)) write(8);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,3
        JP    C,L1254
        LD    A,8
        CALL  writeA
        ;;test5.j(145)   if (5 > 4) write(7);
        LD    A,5
        SUB   A,4
        JP    Z,L1260
        LD    A,7
        CALL  writeA
        ;;test5.j(146)   if (5 > 12/(1+2)) write(6);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,5
        JP    NC,L1269
        LD    A,6
        CALL  writeA
        ;;test5.j(147)   if (3 < 4) write(5);
        LD    A,3
        SUB   A,4
        JP    NC,L1275
        LD    A,5
        CALL  writeA
        ;;test5.j(148)   if (3 < 12/(1+2)) write(4);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,3
        JP    Z,L1284
        LD    A,4
        CALL  writeA
        ;;test5.j(149)   if (3 != 4) write(3);
        LD    A,3
        SUB   A,4
        JP    Z,L1290
        LD    A,3
        CALL  writeA
        ;;test5.j(150)   if (3 != 12/(1+2)) write(2);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,3
        JP    Z,L1299
        LD    A,2
        CALL  writeA
        ;;test5.j(151)   if (4 == 4) write(1);
        LD    A,4
        SUB   A,4
        JP    NZ,L1305
        LD    A,1
        CALL  writeA
        ;;test5.j(152)   if (4 == 12/(1+2)) write(0);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,4
        JP    NZ,L1314
        LD    A,0
        CALL  writeA
        ;;test5.j(153) }
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
