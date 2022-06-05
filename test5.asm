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
        ;;test5.p(0) /*
        ;;test5.p(1)  * A small program in the miniJava language.
        ;;test5.p(2)  * Test comparisons
        ;;test5.p(3)  */
        ;;test5.p(4) class TestIf {
        ;;test5.p(5)   int one = 1;
        LD    A,1
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test5.p(6)   int three = 3;
        LD    A,3
        LD    L,A
        LD    H,0
        LD    (05002H),HL
        ;;test5.p(7)   int four = 4;
        LD    A,4
        LD    L,A
        LD    H,0
        LD    (05004H),HL
        ;;test5.p(8)   int five = 5;
        LD    A,5
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;;test5.p(9)   int twelve = 12;
        LD    A,12
        LD    L,A
        LD    H,0
        LD    (05008H),HL
        ;;test5.p(10)   write(128);
        LD    A,128
        CALL  writeA
        ;;test5.p(11)   //stack level 2
        ;;test5.p(12)   if (5 >= (twelve/(one+2))) write(127);
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    C,L35
        LD    A,127
        CALL  writeA
        ;;test5.p(13)   if (4 >= (twelve/(one+2))) write(126);
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    C,L45
        LD    A,126
        CALL  writeA
        ;;test5.p(14)   if (4 <= (twelve/(one+2))) write(125);
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    C,L55
        LD    A,125
        CALL  writeA
        ;;test5.p(15)   if (3 <= (twelve/(one+2))) write(124);
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    C,L65
        LD    A,124
        CALL  writeA
        ;;test5.p(16)   if (5 > (twelve/(one+2))) write(123);
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    Z,L75
        LD    A,123
        CALL  writeA
        ;;test5.p(17)   if (2 < (twelve/(one+2))) write(122);
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    NC,L85
        LD    A,122
        CALL  writeA
        ;;test5.p(18)   if (3 != (twelve/(one+2))) write(121);
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    Z,L95
        LD    A,121
        CALL  writeA
        ;;test5.p(19)   if (4 == (twelve/(one+2))) write(120);
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    NZ,L105
        LD    A,120
        CALL  writeA
        ;;test5.p(20)   if (5 >= (12/(1+2))) write(119);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,5
        JP    Z,$+5
        JP    C,L114
        LD    A,119
        CALL  writeA
        ;;test5.p(21)   if (4 >= (12/(1+2))) write(118);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,4
        JP    Z,$+5
        JP    C,L123
        LD    A,118
        CALL  writeA
        ;;test5.p(22)   if (4 <= (12/(1+2))) write(117);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,4
        JP    C,L132
        LD    A,117
        CALL  writeA
        ;;test5.p(23)   if (3 <= (12/(1+2))) write(116);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,3
        JP    C,L141
        LD    A,116
        CALL  writeA
        ;;test5.p(24)   if (5 > (12/(1+2))) write(115);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,5
        JP    NC,L150
        LD    A,115
        CALL  writeA
        ;;test5.p(25)   if (3 < (12/(1+2))) write(114);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,3
        JP    Z,L159
        LD    A,114
        CALL  writeA
        ;;test5.p(26)   if (3 != (12/(1+2))) write(113);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,3
        JP    Z,L168
        LD    A,113
        CALL  writeA
        ;;test5.p(27)   if (4 == (12/(1+2))) write(112);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,4
        JP    NZ,L177
        LD    A,112
        CALL  writeA
        ;;test5.p(28)   if (1+4 >= (twelve/(one+2))) write(111);
        LD    A,1
        ADD   A,4
        PUSH AF
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    C,L190
        LD    A,111
        CALL  writeA
        ;;test5.p(29)   if (1+3 >= (twelve/(one+2))) write(110);
        LD    A,1
        ADD   A,3
        PUSH AF
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    C,L203
        LD    A,110
        CALL  writeA
        ;;test5.p(30)   if (1+3 <= (twelve/(one+2))) write(109);
        LD    A,1
        ADD   A,3
        PUSH AF
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    C,L216
        LD    A,109
        CALL  writeA
        ;;test5.p(31)   if (1+2 <= (twelve/(one+2))) write(108);
        LD    A,1
        ADD   A,2
        PUSH AF
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    C,L229
        LD    A,108
        CALL  writeA
        ;;test5.p(32)   if (1+4 > (twelve/(one+2))) write(107);
        LD    A,1
        ADD   A,4
        PUSH AF
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    Z,L242
        LD    A,107
        CALL  writeA
        ;;test5.p(33)   if (1+2 < (twelve/(one+2))) write(106);
        LD    A,1
        ADD   A,2
        PUSH AF
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    NC,L255
        LD    A,106
        CALL  writeA
        ;;test5.p(34)   if (1+2 != (twelve/(one+2))) write(105);
        LD    A,1
        ADD   A,2
        PUSH AF
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    Z,L268
        LD    A,105
        CALL  writeA
        ;;test5.p(35)   if (1+3 == (twelve/(one+2))) write(104);
        LD    A,1
        ADD   A,3
        PUSH AF
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
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
        JP    NZ,L281
        LD    A,104
        CALL  writeA
        ;;test5.p(36)   if (1+4 >= (12/(1+2))) write(103);
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
        JP    C,L293
        LD    A,103
        CALL  writeA
        ;;test5.p(37)   if (1+3 >= (12/(1+2))) write(102);
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
        JP    C,L305
        LD    A,102
        CALL  writeA
        ;;test5.p(38)   if (1+3 <= (12/(1+2))) write(101);
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
        JP    C,L317
        LD    A,101
        CALL  writeA
        ;;test5.p(39)   if (1+2 <= (12/(1+2))) write(100);
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
        JP    C,L329
        LD    A,100
        CALL  writeA
        ;;test5.p(40)   if (1+4 > (12/(1+2))) write(99);
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
        JP    NC,L341
        LD    A,99
        CALL  writeA
        ;;test5.p(41)   if (1+2 < (12/(1+2))) write(98);
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
        JP    Z,L353
        LD    A,98
        CALL  writeA
        ;;test5.p(42)   if (1+2 != (12/(1+2))) write(97);
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
        JP    Z,L365
        LD    A,97
        CALL  writeA
        ;;test5.p(43)   if (1+3 == (12/(1+2))) write(96);
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
        JP    NZ,L377
        LD    A,96
        CALL  writeA
        ;;test5.p(44)   if (twelve >= (twelve/(one+2))) write(95);
        LD    HL,(05008H)
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L388
        LD    A,95
        CALL  writeA
        ;;test5.p(45)   if (four >= (twelve/(one+2))) write(94);
        LD    HL,(05004H)
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L399
        LD    A,94
        CALL  writeA
        ;;test5.p(46)   if (three <= (twelve/(one+2))) write(93);
        LD    HL,(05002H)
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    C,L410
        LD    A,93
        CALL  writeA
        ;;test5.p(47)   if (four <= (twelve/(one+2))) write(92);
        LD    HL,(05004H)
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    C,L421
        LD    A,92
        CALL  writeA
        ;;test5.p(48)   if (twelve > (twelve/(one+2))) write(91);
        LD    HL,(05008H)
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    NC,L432
        LD    A,91
        CALL  writeA
        ;;test5.p(49)   if (three < (twelve/(one+2))) write(90);
        LD    HL,(05002H)
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,L443
        LD    A,90
        CALL  writeA
        ;;test5.p(50)   if (three != (twelve/(one+2))) write(89);
        LD    HL,(05002H)
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,L454
        LD    A,89
        CALL  writeA
        ;;test5.p(51)   if (four == (twelve/(one+2))) write(88);
        LD    HL,(05004H)
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    NZ,L465
        LD    A,88
        CALL  writeA
        ;;test5.p(52)   if (twelve >= (12/(1+2))) write(87);
        LD    HL,(05008H)
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
        JP    C,L477
        LD    A,87
        CALL  writeA
        ;;test5.p(53)   if (four >= (12/(1+2))) write(86);
        LD    HL,(05004H)
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
        JP    C,L489
        LD    A,86
        CALL  writeA
        ;;test5.p(54)   if (three <= (12/(1+2))) write(85);
        LD    HL,(05002H)
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
        JP    C,L501
        LD    A,85
        CALL  writeA
        ;;test5.p(55)   if (four <= (12/(1+2))) write(84);
        LD    HL,(05004H)
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
        JP    C,L513
        LD    A,84
        CALL  writeA
        ;;test5.p(56)   if (twelve > (12/(1+2))) write(83);
        LD    HL,(05008H)
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
        JP    Z,L525
        LD    A,83
        CALL  writeA
        ;;test5.p(57)   if (three < (12/(1+2))) write(82);
        LD    HL,(05002H)
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
        JP    NC,L537
        LD    A,82
        CALL  writeA
        ;;test5.p(58)   if (three != (12/(1+2))) write(81);
        LD    HL,(05002H)
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
        JP    Z,L549
        LD    A,81
        CALL  writeA
        ;;test5.p(59)   if (four == (12/(1+2))) write(80);
        LD    HL,(05004H)
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
        JP    NZ,L561
        LD    A,80
        CALL  writeA
        ;;test5.p(60)   if (one+four >= (twelve/(one+2))) write(79);
        LD    HL,(05000H)
        LD    DE,(05004H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L573
        LD    A,79
        CALL  writeA
        ;;test5.p(61)   if (one+three >= (twelve/(one+2))) write(78);
        LD    HL,(05000H)
        LD    DE,(05002H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L585
        LD    A,78
        CALL  writeA
        ;;test5.p(62)   if (one+three <= (twelve/(one+2))) write(77);
        LD    HL,(05000H)
        LD    DE,(05002H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    C,L597
        LD    A,77
        CALL  writeA
        ;;test5.p(63)   if (one+one <= (twelve/(one+2))) write(76);
        LD    HL,(05000H)
        LD    DE,(05000H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    C,L609
        LD    A,76
        CALL  writeA
        ;;test5.p(64)   if (one+four > (twelve/(one+2))) write(75);
        LD    HL,(05000H)
        LD    DE,(05004H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    NC,L621
        LD    A,75
        CALL  writeA
        ;;test5.p(65)   if (one+one < (twelve/(one+2))) write(74);
        LD    HL,(05000H)
        LD    DE,(05000H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,L633
        LD    A,74
        CALL  writeA
        ;;test5.p(66)   if (one+four  != (twelve/(one+2))) write(73);
        LD    HL,(05000H)
        LD    DE,(05004H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,L645
        LD    A,73
        CALL  writeA
        ;;test5.p(67)   if (one+three == (twelve/(one+2))) write(72);
        LD    HL,(05000H)
        LD    DE,(05002H)
        ADD   HL,DE
        PUSH HL
        LD    HL,(05008H)
        PUSH  HL
        LD    HL,(05000H)
        LD    DE,2
        ADD   HL,DE
        POP   DE
        EX    DE,HL
        CALL  div16
        POP   DE
        OR    A
        SBC   HL,DE
        JP    NZ,L657
        LD    A,72
        CALL  writeA
        ;;test5.p(68)   if (one+four >= (12/(1+2))) write(71);
        LD    HL,(05000H)
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
        JP    C,L670
        LD    A,71
        CALL  writeA
        ;;test5.p(69)   if (one+three >= (12/(1+2))) write(70);
        LD    HL,(05000H)
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
        JP    C,L683
        LD    A,70
        CALL  writeA
        ;;test5.p(70)   if (one+three <= (12/(1+2))) write(69);
        LD    HL,(05000H)
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
        JP    C,L696
        LD    A,69
        CALL  writeA
        ;;test5.p(71)   if (one+one <= (12/(1+2))) write(68);
        LD    HL,(05000H)
        LD    DE,(05000H)
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
        JP    C,L709
        LD    A,68
        CALL  writeA
        ;;test5.p(72)   if (one+four > (12/(1+2))) write(67);
        LD    HL,(05000H)
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
        JP    Z,L722
        LD    A,67
        CALL  writeA
        ;;test5.p(73)   if (one+one < (12/(1+2))) write(66);
        LD    HL,(05000H)
        LD    DE,(05000H)
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
        JP    NC,L735
        LD    A,66
        CALL  writeA
        ;;test5.p(74)   if (one+four  != (12/(1+2))) write(65);
        LD    HL,(05000H)
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
        JP    Z,L748
        LD    A,65
        CALL  writeA
        ;;test5.p(75)   if (one+three == (12/(1+2))) write(64);
        LD    HL,(05000H)
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
        JP    NZ,L763
        LD    A,64
        CALL  writeA
        ;;test5.p(76)   //stack level 1
        ;;test5.p(77)   //integer-byte
        ;;test5.p(78)   if (four >= 4) write(63);
        LD    HL,(05004H)
        PUSH HL
        POP  HL
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    C,L772
        LD    A,63
        CALL  writeA
        ;;test5.p(79)   if (four >= (12/(1+2))) write(62);
        LD    HL,(05004H)
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
        JP    C,L784
        LD    A,62
        CALL  writeA
        ;;test5.p(80)   if (five >= 4) write(61);
        LD    HL,(05006H)
        PUSH HL
        POP  HL
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    C,L793
        LD    A,61
        CALL  writeA
        ;;test5.p(81)   if (five >= (12/(1+2))) write(60);
        LD    HL,(05006H)
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
        JP    C,L805
        LD    A,60
        CALL  writeA
        ;;test5.p(82)   if (four <= 4) write(59);
        LD    HL,(05004H)
        PUSH HL
        POP  HL
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L814
        LD    A,59
        CALL  writeA
        ;;test5.p(83)   if (four <= (12/(1+2))) write(58);
        LD    HL,(05004H)
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
        JP    C,L826
        LD    A,58
        CALL  writeA
        ;;test5.p(84)   if (three <= 4) write(57);
        LD    HL,(05002H)
        PUSH HL
        POP  HL
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L835
        LD    A,57
        CALL  writeA
        ;;test5.p(85)   if (three <= (12/(1+2))) write(56);
        LD    HL,(05002H)
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
        JP    C,L847
        LD    A,56
        CALL  writeA
        ;;test5.p(86)   if (five > 4) write(55);
        LD    HL,(05006H)
        PUSH HL
        POP  HL
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L856
        LD    A,55
        CALL  writeA
        ;;test5.p(87)   if (five > (12/(1+2))) write(54);
        LD    HL,(05006H)
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
        JP    Z,L868
        LD    A,54
        CALL  writeA
        ;;test5.p(88)   if (three < 4) write(53);
        LD    HL,(05002H)
        PUSH HL
        POP  HL
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NC,L877
        LD    A,53
        CALL  writeA
        ;;test5.p(89)   if (three < (12/(1+2))) write(52);
        LD    HL,(05002H)
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
        JP    NC,L889
        LD    A,52
        CALL  writeA
        ;;test5.p(90)   if (three != 4) write(51);
        LD    HL,(05002H)
        PUSH HL
        POP  HL
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L898
        LD    A,51
        CALL  writeA
        ;;test5.p(91)   if (three != (12/(1+2))) write(50);
        LD    HL,(05002H)
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
        JP    Z,L910
        LD    A,50
        CALL  writeA
        ;;test5.p(92)   if (four == 4) write(49);
        LD    HL,(05004H)
        PUSH HL
        POP  HL
        LD    A,4
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NZ,L919
        LD    A,49
        CALL  writeA
        ;;test5.p(93)   if (four == (12/(1+2))) write(48);
        LD    HL,(05004H)
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
        JP    NZ,L932
        LD    A,48
        CALL  writeA
        ;;test5.p(94)   //byte-integer
        ;;test5.p(95)   if (4 >= four) write(47);
        LD    HL,(05004H)
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L939
        LD    A,47
        CALL  writeA
        ;;test5.p(96)   if (4 >= (twelve/(1+2))) write(46);
        LD    HL,(05008H)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L949
        LD    A,46
        CALL  writeA
        ;;test5.p(97)   if (5 >= four) write(45);
        LD    HL,(05004H)
        LD    A,5
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L956
        LD    A,45
        CALL  writeA
        ;;test5.p(98)   if (5 >= (twelve/(1+2))) write(44);
        LD    HL,(05008H)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,5
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L966
        LD    A,44
        CALL  writeA
        ;;test5.p(99)   if (4 <= four) write(43);
        LD    HL,(05004H)
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L973
        LD    A,43
        CALL  writeA
        ;;test5.p(100)   if (4 <= (twelve/(1+2))) write(42);
        LD    HL,(05008H)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L983
        LD    A,42
        CALL  writeA
        ;;test5.p(101)   if (3 <= four) write(41);
        LD    HL,(05004H)
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L990
        LD    A,41
        CALL  writeA
        ;;test5.p(102)   if (3 <= (twelve/(1+2))) write(40);
        LD    HL,(05008H)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1000
        LD    A,40
        CALL  writeA
        ;;test5.p(103)   if (5 > four) write(39);
        LD    HL,(05004H)
        LD    A,5
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L1007
        LD    A,39
        CALL  writeA
        ;;test5.p(104)   if (5 > (twelve/(1+2))) write(38);
        LD    HL,(05008H)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,5
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L1017
        LD    A,38
        CALL  writeA
        ;;test5.p(105)   if (3 < four) write(37);
        LD    HL,(05004H)
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L1024
        LD    A,37
        CALL  writeA
        ;;test5.p(106)   if (3 < (twelve/(1+2))) write(36);
        LD    HL,(05008H)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L1034
        LD    A,36
        CALL  writeA
        ;;test5.p(107)   if (3 != four) write(35);
        LD    HL,(05004H)
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L1041
        LD    A,35
        CALL  writeA
        ;;test5.p(108)   if (3 != (twelve/(1+2))) write(34);
        LD    HL,(05008H)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,3
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L1051
        LD    A,34
        CALL  writeA
        ;;test5.p(109)   if (4 == four) write(33);
        LD    HL,(05004H)
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NZ,L1058
        LD    A,33
        CALL  writeA
        ;;test5.p(110)   if (4 == (twelve/(1+2))) write(32);
        LD    HL,(05008H)
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    A,4
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NZ,L1069
        LD    A,32
        CALL  writeA
        ;;test5.p(111)   //integer-integer
        ;;test5.p(112)   if (400 >= 400) write(31);
        LD    HL,400
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    C,L1075
        LD    A,31
        CALL  writeA
        ;;test5.p(113)   if (400 >= (1200/(1+2))) write(30);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1084
        LD    A,30
        CALL  writeA
        ;;test5.p(114)   if (500 >= 400) write(29);
        LD    HL,500
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    C,L1090
        LD    A,29
        CALL  writeA
        ;;test5.p(115)   if (500 >= (1200/(1+2))) write(28);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,500
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1099
        LD    A,28
        CALL  writeA
        ;;test5.p(116)   if (400 <= 400) write(27);
        LD    HL,400
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1105
        LD    A,27
        CALL  writeA
        ;;test5.p(117)   if (400 <= (1200/(1+2))) write(26);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    C,L1114
        LD    A,26
        CALL  writeA
        ;;test5.p(118)   if (300 <= 400) write(25);
        LD    HL,300
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1120
        LD    A,25
        CALL  writeA
        ;;test5.p(119)   if (300 <= (1200/(1+2))) write(24);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,300
        OR    A
        SBC   HL,DE
        JP    C,L1129
        LD    A,24
        CALL  writeA
        ;;test5.p(120)   if (500 > 400) write(23);
        LD    HL,500
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    Z,L1135
        LD    A,23
        CALL  writeA
        ;;test5.p(121)   if (500 > (1200/(1+2))) write(22);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,500
        OR    A
        SBC   HL,DE
        JP    NC,L1144
        LD    A,22
        CALL  writeA
        ;;test5.p(122)   if (300 < 400) write(21);
        LD    HL,300
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    NC,L1150
        LD    A,21
        CALL  writeA
        ;;test5.p(123)   if (300 < (1200/(1+2))) write(20);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,300
        OR    A
        SBC   HL,DE
        JP    Z,L1159
        LD    A,20
        CALL  writeA
        ;;test5.p(124)   if (300 != 400) write(19);
        LD    HL,300
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    Z,L1165
        LD    A,19
        CALL  writeA
        ;;test5.p(125)   if (300 != (1200/(1+2))) write(18);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,300
        OR    A
        SBC   HL,DE
        JP    Z,L1174
        LD    A,18
        CALL  writeA
        ;;test5.p(126)   if (400 == 400) write(17);
        LD    HL,400
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    NZ,L1180
        LD    A,17
        CALL  writeA
        ;;test5.p(127)   if (400 == (1200/(1+2))) write(16);
        LD    HL,1200
        LD    A,1
        ADD   A,2
        CALL  div16_8
        LD    DE,400
        OR    A
        SBC   HL,DE
        JP    NZ,L1190
        LD    A,16
        CALL  writeA
        ;;test5.p(128)   //byte-byte
        ;;test5.p(129)   if (4 >= 4) write(15);
        LD    A,4
        SUB   A,4
        JP    C,L1196
        LD    A,15
        CALL  writeA
        ;;test5.p(130)   if (4 >= (12/(1+2))) write(14);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,4
        JP    Z,$+5
        JP    C,L1205
        LD    A,14
        CALL  writeA
        ;;test5.p(131)   if (5 >= 4) write(13);
        LD    A,5
        SUB   A,4
        JP    C,L1211
        LD    A,13
        CALL  writeA
        ;;test5.p(132)   if (5 >= (12/(1+2))) write(12);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,5
        JP    Z,$+5
        JP    C,L1220
        LD    A,12
        CALL  writeA
        ;;test5.p(133)   if (4 <= 4) write(11);
        LD    A,4
        SUB   A,4
        JP    Z,$+5
        JP    C,L1226
        LD    A,11
        CALL  writeA
        ;;test5.p(134)   if (4 <= (12/(1+2))) write(10);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,4
        JP    C,L1235
        LD    A,10
        CALL  writeA
        ;;test5.p(135)   if (3 <= 4) write(9);
        LD    A,3
        SUB   A,4
        JP    Z,$+5
        JP    C,L1241
        LD    A,9
        CALL  writeA
        ;;test5.p(136)   if (3 <= (12/(1+2))) write(8);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,3
        JP    C,L1250
        LD    A,8
        CALL  writeA
        ;;test5.p(137)   if (5 > 4) write(7);
        LD    A,5
        SUB   A,4
        JP    Z,L1256
        LD    A,7
        CALL  writeA
        ;;test5.p(138)   if (5 > (12/(1+2))) write(6);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,5
        JP    NC,L1265
        LD    A,6
        CALL  writeA
        ;;test5.p(139)   if (3 < 4) write(5);
        LD    A,3
        SUB   A,4
        JP    NC,L1271
        LD    A,5
        CALL  writeA
        ;;test5.p(140)   if (3 < (12/(1+2))) write(4);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,3
        JP    Z,L1280
        LD    A,4
        CALL  writeA
        ;;test5.p(141)   if (3 != 4) write(3);
        LD    A,3
        SUB   A,4
        JP    Z,L1286
        LD    A,3
        CALL  writeA
        ;;test5.p(142)   if (3 != (12/(1+2))) write(2);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,3
        JP    Z,L1295
        LD    A,2
        CALL  writeA
        ;;test5.p(143)   if (4 == 4) write(1);
        LD    A,4
        SUB   A,4
        JP    NZ,L1301
        LD    A,1
        CALL  writeA
        ;;test5.p(144)   if (4 == (12/(1+2))) write(0);
        LD    A,12
        PUSH  AF
        LD    A,1
        ADD   A,2
        LD    C,A
        POP   AF
        CALL  div8
        SUB   A,4
        JP    NZ,L1310
        LD    A,0
        CALL  writeA
        ;;test5.p(145) }
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
