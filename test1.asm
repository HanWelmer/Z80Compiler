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
        ;;test1.j(0) /* Program to test generated Z80 assembler code */
        ;;test1.j(1) class TestWhile {
        ;;test1.j(2)   byte b = 115;
        ;acc8= constant 115
        LD    A,115
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(3)   
        ;;test1.j(4)   /************************/
        ;;test1.j(5)   // global variable within while scope
        ;;test1.j(6)   write (b);
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(7)   b--;
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;;test1.j(8)   while (b>112) {
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8Comp constant 112
        SUB   A,112
        ;brle 35
        JP    Z,L35
        ;;test1.j(9)     int j = 1001;
        ;acc16= constant 1001
        LD    HL,1001
        ;acc16=> variable 1
        LD    (05001H),HL
        ;;test1.j(10)     byte c = b;
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8=> variable 3
        LD    (05003H),A
        ;;test1.j(11)     byte d = c;
        ;acc8= variable 3
        LD    A,(05003H)
        ;acc8=> variable 4
        LD    (05004H),A
        ;;test1.j(12)     b--;
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;;test1.j(13)     write (c);
        ;acc8= variable 3
        LD    A,(05003H)
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(14)   }
        ;br 14
        JP    L14
        ;;test1.j(15) 
        ;;test1.j(16)   int i = 110;
        ;acc8= constant 110
        LD    A,110
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(17)   int i2 = 105;
        ;acc8= constant 105
        LD    A,105
        ;acc8=> variable 3
        LD    L,A
        LD    H,0
        LD    (05003H),HL
        ;;test1.j(18)   int p = 12;
        ;acc8= constant 12
        LD    A,12
        ;acc8=> variable 5
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        ;;test1.j(19)   byte b2 = 111;
        ;acc8= constant 111
        LD    A,111
        ;acc8=> variable 7
        LD    (05007H),A
        ;;test1.j(20) 
        ;;test1.j(21)   /************************/
        ;;test1.j(22)   // stack8 - constant
        ;;test1.j(23)   // stack8 - acc
        ;;test1.j(24)   // stack8 - var
        ;;test1.j(25)   // stack8 - stack8
        ;;test1.j(26)   // stack8 - stack16
        ;;test1.j(27)   //TODO
        ;;test1.j(28) 
        ;;test1.j(29)   /************************/
        ;;test1.j(30)   // stack16 - constant
        ;;test1.j(31)   // stack16 - acc
        ;;test1.j(32)   // stack16 - var
        ;;test1.j(33)   // stack16 - stack8
        ;;test1.j(34)   // stack16 - stack16
        ;;test1.j(35)   //TODO
        ;;test1.j(36) 
        ;;test1.j(37)   /************************/
        ;;test1.j(38)   // var - stack16
        ;;test1.j(39)   // byte - byte
        ;;test1.j(40)   // byte - integer
        ;;test1.j(41)   // integer - byte
        ;;test1.j(42)   // integer - integer
        ;;test1.j(43)   //TODO
        ;;test1.j(44) 
        ;;test1.j(45)   /************************/
        ;;test1.j(46)   // var - stack8
        ;;test1.j(47)   // byte - byte
        ;;test1.j(48)   // byte - integer
        ;;test1.j(49)   // integer - byte
        ;;test1.j(50)   // integer - integer
        ;;test1.j(51)   //TODO
        ;;test1.j(52) 
        ;;test1.j(53)   /************************/
        ;;test1.j(54)   // var - var
        ;;test1.j(55)   // byte - byte
        ;;test1.j(56)   while (b2 <= b) { write (b); b--; }
        ;acc8= variable 7
        LD    A,(05007H)
        ;acc8Comp variable 0
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
        ;brgt 92
        JP    Z,$+5
        JP    C,L92
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;br 83
        JP    L83
        ;;test1.j(57)   // byte - integer
        ;;test1.j(58)   b2 = 109;
        ;acc8= constant 109
        LD    A,109
        ;acc8=> variable 7
        LD    (05007H),A
        ;;test1.j(59)   while (b2 <= i) { write (i); i--; }
        ;acc8= variable 7
        LD    A,(05007H)
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 105
        JP    Z,$+5
        JP    C,L105
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 95
        JP    L95
        ;;test1.j(60)   // integer - byte
        ;;test1.j(61)   b=108;
        ;acc8= constant 108
        LD    A,108
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(62)   i=107;
        ;acc8= constant 107
        LD    A,107
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(63)   while (i <= b) { write (b); b--; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 121
        JP    Z,$+5
        JP    C,L121
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;br 111
        JP    L111
        ;;test1.j(64)   // integer - integer
        ;;test1.j(65)   i=106;
        ;acc8= constant 106
        LD    A,106
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(66)   while (i2 <= i) { write (i); i--; }
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16Comp variable 1
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
        ;brgt 136
        JP    Z,$+5
        JP    C,L136
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 124
        JP    L124
        ;;test1.j(67) 
        ;;test1.j(68)   /************************/
        ;;test1.j(69)   // var - acc
        ;;test1.j(70)   // byte - byte
        ;;test1.j(71)   i=104;
        ;acc8= constant 104
        LD    A,104
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(72)   b=104;
        ;acc8= constant 104
        LD    A,104
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(73)   while (b <= 105+0) { write (i); i--; b++; }
        ;acc8= constant 105
        LD    A,105
        ;acc8+ constant 0
        ADD   A,0
        ;acc8Comp variable 0
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
        ;brlt 153
        JP    C,L153
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;incr8 variable 0
        LD    HL,(05000H)
        INC   (HL)
        ;br 142
        JP    L142
        ;;test1.j(74)   // byte - integer
        ;;test1.j(75)   i=103;
        ;acc8= constant 103
        LD    A,103
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(76)   b=102;
        ;acc8= constant 102
        LD    A,102
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(77)   while (b <= i+0) { write (b); b--; i=i-2; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 173
        JP    Z,$+5
        JP    C,L173
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16- constant 2
        LD    DE,2
        OR    A
        SBC   HL,DE
        ;acc16=> variable 1
        LD    (05001H),HL
        ;br 159
        JP    L159
        ;;test1.j(78)   // integer - byte
        ;;test1.j(79)   i=100;
        ;acc8= constant 100
        LD    A,100
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(80)   while (i <= 101+0) { write (b); b--; i++; }
        ;acc8= constant 101
        LD    A,101
        ;acc8+ constant 0
        ADD   A,0
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 188
        JP    Z,$+5
        JP    C,L188
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;incr16 variable 1
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
        ;br 176
        JP    L176
        ;;test1.j(81)   // integer - integer
        ;;test1.j(82)   i=1098;
        ;acc16= constant 1098
        LD    HL,1098
        ;acc16=> variable 1
        LD    (05001H),HL
        ;;test1.j(83)   while (i <= 1099+0) { write (b); b--; i++; }
        ;acc16= constant 1099
        LD    HL,1099
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;acc16Comp variable 1
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
        ;brlt 205
        JP    C,L205
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;incr16 variable 1
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
        ;br 191
        JP    L191
        ;;test1.j(84) 
        ;;test1.j(85)   /************************/
        ;;test1.j(86)   // var - constant
        ;;test1.j(87)   // byte - byte
        ;;test1.j(88)   i=96;
        ;acc8= constant 96
        LD    A,96
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(89)   b=96;
        ;acc8= constant 96
        LD    A,96
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(90)   while (b <= 97) { write (i); i--; b++; }
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8Comp constant 97
        SUB   A,97
        ;brgt 222
        JP    Z,$+5
        JP    C,L222
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;incr8 variable 0
        LD    HL,(05000H)
        INC   (HL)
        ;br 211
        JP    L211
        ;;test1.j(91)   // byte - integer
        ;;test1.j(92)   //not relevant
        ;;test1.j(93)   write(94);
        ;acc8= constant 94
        LD    A,94
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(94)   write(93);
        ;acc8= constant 93
        LD    A,93
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(95)   // integer - byte
        ;;test1.j(96)   i=92;
        ;acc8= constant 92
        LD    A,92
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(97)   b=92;
        ;acc8= constant 92
        LD    A,92
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(98)   while (i <= 93) { write (b); b--; i++; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc8= constant 93
        LD    A,93
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 246
        JP    Z,$+5
        JP    C,L246
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;incr16 variable 1
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
        ;br 235
        JP    L235
        ;;test1.j(99)   // integer - integer
        ;;test1.j(100)   i=1090;
        ;acc16= constant 1090
        LD    HL,1090
        ;acc16=> variable 1
        LD    (05001H),HL
        ;;test1.j(101)   while (i <= 1091) { write (b); b--; i++; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16Comp constant 1091
        LD    DE,1091
        OR    A
        SBC   HL,DE
        ;brgt 263
        JP    Z,$+5
        JP    C,L263
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;incr16 variable 1
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
        ;br 249
        JP    L249
        ;;test1.j(102) 
        ;;test1.j(103)   /************************/
        ;;test1.j(104)   // acc - stack8
        ;;test1.j(105)   // byte - byte
        ;;test1.j(106)   //TODO
        ;;test1.j(107)   write(88);
        ;acc8= constant 88
        LD    A,88
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(108)   write(87);
        ;acc8= constant 87
        LD    A,87
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(109)   // byte - integer
        ;;test1.j(110)   //TODO
        ;;test1.j(111)   write(86);
        ;acc8= constant 86
        LD    A,86
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(112)   write(85);
        ;acc8= constant 85
        LD    A,85
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(113)   // integer - byte
        ;;test1.j(114)   //TODO
        ;;test1.j(115)   write(84);
        ;acc8= constant 84
        LD    A,84
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(116)   write(83);
        ;acc8= constant 83
        LD    A,83
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(117)   // integer - integer
        ;;test1.j(118)   //TODO
        ;;test1.j(119)   write(82);
        ;acc8= constant 82
        LD    A,82
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(120)   write(81);
        ;acc8= constant 81
        LD    A,81
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(121) 
        ;;test1.j(122)   /************************/
        ;;test1.j(123)   // acc - stack16
        ;;test1.j(124)   // byte - byte
        ;;test1.j(125)   //TODO
        ;;test1.j(126)   write(80);
        ;acc8= constant 80
        LD    A,80
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(127)   write(79);
        ;acc8= constant 79
        LD    A,79
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(128)   // byte - integer
        ;;test1.j(129)   //TODO
        ;;test1.j(130)   write(78);
        ;acc8= constant 78
        LD    A,78
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(131)   write(77);
        ;acc8= constant 77
        LD    A,77
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(132)   // integer - byte
        ;;test1.j(133)   //TODO
        ;;test1.j(134)   write(76);
        ;acc8= constant 76
        LD    A,76
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(135)   write(75);
        ;acc8= constant 75
        LD    A,75
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(136)   // integer - integer
        ;;test1.j(137)   //TODO
        ;;test1.j(138)   write(74);
        ;acc8= constant 74
        LD    A,74
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(139)   write(73);
        ;acc8= constant 73
        LD    A,73
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(140) 
        ;;test1.j(141)   /************************/
        ;;test1.j(142)   // acc - var
        ;;test1.j(143)   // byte - byte
        ;;test1.j(144)   b=72;
        ;acc8= constant 72
        LD    A,72
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(145)   while (71+0 <= b) { write (b); b--; }
        ;acc8= constant 71
        LD    A,71
        ;acc8+ constant 0
        ADD   A,0
        ;acc8Comp variable 0
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
        ;brgt 345
        JP    Z,$+5
        JP    C,L345
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;br 335
        JP    L335
        ;;test1.j(146)   // byte - integer
        ;;test1.j(147)   i=70;
        ;acc8= constant 70
        LD    A,70
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(148)   while (69+0 <= i) { write (i); i--; }
        ;acc8= constant 69
        LD    A,69
        ;acc8+ constant 0
        ADD   A,0
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 359
        JP    Z,$+5
        JP    C,L359
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 348
        JP    L348
        ;;test1.j(149)   // integer - byte
        ;;test1.j(150)   i=67;
        ;acc8= constant 67
        LD    A,67
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(151)   b=68;
        ;acc8= constant 68
        LD    A,68
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(152)   while (i+0 <= b) { write (b); b--; } 
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 376
        JP    Z,$+5
        JP    C,L376
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;br 365
        JP    L365
        ;;test1.j(153)   // integer - integer
        ;;test1.j(154)   i=1066;
        ;acc16= constant 1066
        LD    HL,1066
        ;acc16=> variable 1
        LD    (05001H),HL
        ;;test1.j(155)   while (1000+65 <= i) { write (b); b--; i--; }
        ;acc16= constant 1000
        LD    HL,1000
        ;acc16+ constant 65
        LD    DE,65
        ADD   HL,DE
        ;acc16Comp variable 1
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
        ;brgt 393
        JP    Z,$+5
        JP    C,L393
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 379
        JP    L379
        ;;test1.j(156) 
        ;;test1.j(157)   /************************/
        ;;test1.j(158)   // acc - acc
        ;;test1.j(159)   // byte - byte
        ;;test1.j(160)   b=64;
        ;acc8= constant 64
        LD    A,64
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(161)   while (63+0 <= b+0) { write (b); b--; }
        ;acc8= constant 63
        LD    A,63
        ;acc8+ constant 0
        ADD   A,0
        ;<acc8
        PUSH AF
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8+ constant 0
        ADD   A,0
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
        ;brlt 409
        JP    C,L409
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;br 396
        JP    L396
        ;;test1.j(162)   // byte - integer
        ;;test1.j(163)   i=62;
        ;acc8= constant 62
        LD    A,62
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(164)   while (61+0 <= i+0) { write (i); i--; }
        ;acc8= constant 61
        LD    A,61
        ;acc8+ constant 0
        ADD   A,0
        ;<acc8
        PUSH AF
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;acc8= unstack8
        POP  AF
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 426
        JP    Z,$+5
        JP    C,L426
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 412
        JP    L412
        ;;test1.j(165)   // integer - byte
        ;;test1.j(166)   i=59;
        ;acc8= constant 59
        LD    A,59
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(167)   b=60;
        ;acc8= constant 60
        LD    A,60
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(168)   while (i+0 <= b+0) { write (b); b--; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8+ constant 0
        ADD   A,0
        ;acc16= unstack16
        POP  HL
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 446
        JP    Z,$+5
        JP    C,L446
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;br 432
        JP    L432
        ;;test1.j(169)   // integer - integer
        ;;test1.j(170)   i=1058;
        ;acc16= constant 1058
        LD    HL,1058
        ;acc16=> variable 1
        LD    (05001H),HL
        ;;test1.j(171)   while (1000+57 <= i+0) { write (b); b--; i--; }
        ;acc16= constant 1000
        LD    HL,1000
        ;acc16+ constant 57
        LD    DE,57
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
        ;brlt 466
        JP    C,L466
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 449
        JP    L449
        ;;test1.j(172) 
        ;;test1.j(173)   /************************/
        ;;test1.j(174)   // acc - constant
        ;;test1.j(175)   // byte - byte
        ;;test1.j(176)   i=56;
        ;acc8= constant 56
        LD    A,56
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(177)   b=56;
        ;acc8= constant 56
        LD    A,56
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(178)   while (b+0 <= 57) { write (i); i--; b++; }
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8+ constant 0
        ADD   A,0
        ;acc8Comp constant 57
        SUB   A,57
        ;brgt 485
        JP    Z,$+5
        JP    C,L485
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;incr8 variable 0
        LD    HL,(05000H)
        INC   (HL)
        ;br 472
        JP    L472
        ;;test1.j(179)   // byte - integer
        ;;test1.j(180)   //not relevant
        ;;test1.j(181)   // integer - byte
        ;;test1.j(182)   i=54;
        ;acc8= constant 54
        LD    A,54
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(183)   b=54;
        ;acc8= constant 54
        LD    A,54
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(184)   while (i+0 <= 55) { write (b); b--; i++; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;acc8= constant 55
        LD    A,55
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 502
        JP    Z,$+5
        JP    C,L502
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;incr16 variable 1
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
        ;br 491
        JP    L491
        ;;test1.j(185)   i=1052;
        ;acc16= constant 1052
        LD    HL,1052
        ;acc16=> variable 1
        LD    (05001H),HL
        ;;test1.j(186)   // integer - integer
        ;;test1.j(187)   while (i+0 <= 1053) { write (b); b--; i++; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;acc16Comp constant 1053
        LD    DE,1053
        OR    A
        SBC   HL,DE
        ;brgt 521
        JP    Z,$+5
        JP    C,L521
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;incr16 variable 1
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
        ;br 506
        JP    L506
        ;;test1.j(188) 
        ;;test1.j(189)   /************************/
        ;;test1.j(190)   // constant - stack8
        ;;test1.j(191)   // byte - byte
        ;;test1.j(192)   //TODO
        ;;test1.j(193)   write(50);
        ;acc8= constant 50
        LD    A,50
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(194)   // constant - stack8
        ;;test1.j(195)   // byte - integer
        ;;test1.j(196)   //TODO
        ;;test1.j(197)   write(49);
        ;acc8= constant 49
        LD    A,49
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(198)   // constant - stack8
        ;;test1.j(199)   // integer - byte
        ;;test1.j(200)   //TODO
        ;;test1.j(201)   write(48);
        ;acc8= constant 48
        LD    A,48
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(202)   // constant - stack88
        ;;test1.j(203)   // integer - integer
        ;;test1.j(204)   //TODO
        ;;test1.j(205)   write(47);
        ;acc8= constant 47
        LD    A,47
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(206) 
        ;;test1.j(207)   /************************/
        ;;test1.j(208)   // constant - stack16
        ;;test1.j(209)   // byte - byte
        ;;test1.j(210)   //TODO
        ;;test1.j(211)   write(46);
        ;acc8= constant 46
        LD    A,46
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(212)   // constant - stack16
        ;;test1.j(213)   // byte - integer
        ;;test1.j(214)   //TODO
        ;;test1.j(215)   write(45);
        ;acc8= constant 45
        LD    A,45
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(216)   // constant - stack16
        ;;test1.j(217)   // integer - byte
        ;;test1.j(218)   //TODO
        ;;test1.j(219)   write(44);
        ;acc8= constant 44
        LD    A,44
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(220)   // constant - stack16
        ;;test1.j(221)   // integer - integer
        ;;test1.j(222)   //TODO
        ;;test1.j(223)   write(43);
        ;acc8= constant 43
        LD    A,43
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(224) 
        ;;test1.j(225)   /************************/
        ;;test1.j(226)   // constant - var
        ;;test1.j(227)   // byte - byte
        ;;test1.j(228)   b=42;
        ;acc8= constant 42
        LD    A,42
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(229)   while (41 <= b) { write (b); b--; }
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8Comp constant 41
        SUB   A,41
        ;brlt 586
        JP    C,L586
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;br 575
        JP    L575
        ;;test1.j(230) 
        ;;test1.j(231)   // constant - var
        ;;test1.j(232)   // byte - integer
        ;;test1.j(233)   i=40;
        ;acc8= constant 40
        LD    A,40
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(234)   while (39 <= i) { write (i); i--; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc8= constant 39
        LD    A,39
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 605
        JP    Z,$+5
        JP    C,L605
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 589
        JP    L589
        ;;test1.j(235) 
        ;;test1.j(236)   // constant - var
        ;;test1.j(237)   // integer - byte
        ;;test1.j(238)   // not relevant
        ;;test1.j(239) 
        ;;test1.j(240)   // constant - var
        ;;test1.j(241)   // integer - integer
        ;;test1.j(242)   i=1038;
        ;acc16= constant 1038
        LD    HL,1038
        ;acc16=> variable 1
        LD    (05001H),HL
        ;;test1.j(243)   b=38;
        ;acc8= constant 38
        LD    A,38
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(244)   while (1037 <= i) { write (b); b--; i--; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16Comp constant 1037
        LD    DE,1037
        OR    A
        SBC   HL,DE
        ;brlt 624
        JP    C,L624
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 611
        JP    L611
        ;;test1.j(245) 
        ;;test1.j(246)   /************************/
        ;;test1.j(247)   // constant - acc
        ;;test1.j(248)   // byte - byte
        ;;test1.j(249)   b=36;
        ;acc8= constant 36
        LD    A,36
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(250)   while (135 == b+100) { write (b); b--; }
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8+ constant 100
        ADD   A,100
        ;acc8Comp constant 135
        SUB   A,135
        ;brne 636
        JP    NZ,L636
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;br 627
        JP    L627
        ;;test1.j(251)   while (132 != b+100) { write (b); b--; }
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8+ constant 100
        ADD   A,100
        ;acc8Comp constant 132
        SUB   A,132
        ;breq 645
        JP    Z,L645
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;br 636
        JP    L636
        ;;test1.j(252)   p=32;
        ;acc8= constant 32
        LD    A,32
        ;acc8=> variable 5
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        ;;test1.j(253)   while (134 > b+100) { write (p); p--; b++; }
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8+ constant 100
        ADD   A,100
        ;acc8Comp constant 134
        SUB   A,134
        ;brge 658
        JP    NC,L658
        ;acc16= variable 5
        LD    HL,(05005H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 5
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        ;incr8 variable 0
        LD    HL,(05000H)
        INC   (HL)
        ;br 648
        JP    L648
        ;;test1.j(254)   while (135 >= b+100) { write (p); p--; b++; }
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8+ constant 100
        ADD   A,100
        ;acc8Comp constant 135
        SUB   A,135
        ;brgt 668
        JP    Z,$+5
        JP    C,L668
        ;acc16= variable 5
        LD    HL,(05005H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 5
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        ;incr8 variable 0
        LD    HL,(05000H)
        INC   (HL)
        ;br 658
        JP    L658
        ;;test1.j(255)   b=28;
        ;acc8= constant 28
        LD    A,28
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(256)   while (126 <  b+100) { write (b); b--; }
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8+ constant 100
        ADD   A,100
        ;acc8Comp constant 126
        SUB   A,126
        ;brle 680
        JP    Z,L680
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;br 671
        JP    L671
        ;;test1.j(257)   while (125 <= b+100) { write (b); b--; }
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8+ constant 100
        ADD   A,100
        ;acc8Comp constant 125
        SUB   A,125
        ;brlt 691
        JP    C,L691
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;br 680
        JP    L680
        ;;test1.j(258)   // constant - acc
        ;;test1.j(259)   // byte - integer
        ;;test1.j(260)   i=24;
        ;acc8= constant 24
        LD    A,24
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(261)   b=23;
        ;acc8= constant 23
        LD    A,23
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test1.j(262)   while (23 == i+0) { write (i); i--; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;acc8= constant 23
        LD    A,23
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brne 707
        JP    NZ,L707
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 697
        JP    L697
        ;;test1.j(263)   while (120 != i+100) { write (i); i--; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 100
        LD    DE,100
        ADD   HL,DE
        ;acc8= constant 120
        LD    A,120
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;breq 717
        JP    Z,L717
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 707
        JP    L707
        ;;test1.j(264)   p=20;
        ;acc8= constant 20
        LD    A,20
        ;acc8=> variable 5
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        ;;test1.j(265)   while (122 > i+100) { write (p); p--; i++; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 100
        LD    DE,100
        ADD   HL,DE
        ;acc8= constant 122
        LD    A,122
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brle 731
        JP    Z,L731
        ;acc16= variable 5
        LD    HL,(05005H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 5
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        ;incr16 variable 1
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
        ;br 720
        JP    L720
        ;;test1.j(266)   while (123 >= i+100) { write (p); p--; i++; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 100
        LD    DE,100
        ADD   HL,DE
        ;acc8= constant 123
        LD    A,123
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brlt 742
        JP    C,L742
        ;acc16= variable 5
        LD    HL,(05005H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 5
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        ;incr16 variable 1
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
        ;br 731
        JP    L731
        ;;test1.j(267)   i=16;
        ;acc8= constant 16
        LD    A,16
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(268)   while (114 <  i+100) { write (i); i--; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 100
        LD    DE,100
        ADD   HL,DE
        ;acc8= constant 114
        LD    A,114
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brge 755
        JP    NC,L755
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 745
        JP    L745
        ;;test1.j(269)   while (113 <= i+100) { write (i); i--; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 100
        LD    DE,100
        ADD   HL,DE
        ;acc8= constant 113
        LD    A,113
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 771
        JP    Z,$+5
        JP    C,L771
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 755
        JP    L755
        ;;test1.j(270)   // constant - acc
        ;;test1.j(271)   // integer - byte
        ;;test1.j(272)   // not relevant
        ;;test1.j(273) 
        ;;test1.j(274)   // constant - acc
        ;;test1.j(275)   // integer - integer
        ;;test1.j(276)   i=12;
        ;acc8= constant 12
        LD    A,12
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(277)   while (1011 == i+1000) { write (i); i--; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
        ;acc16Comp constant 1011
        LD    DE,1011
        OR    A
        SBC   HL,DE
        ;brne 784
        JP    NZ,L784
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 774
        JP    L774
        ;;test1.j(278)   //i=10
        ;;test1.j(279)   while (1008 != i+1000) { write (i); i--; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
        ;acc16Comp constant 1008
        LD    DE,1008
        OR    A
        SBC   HL,DE
        ;breq 794
        JP    Z,L794
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 784
        JP    L784
        ;;test1.j(280)   //i=8
        ;;test1.j(281)   p=8;
        ;acc8= constant 8
        LD    A,8
        ;acc8=> variable 5
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        ;;test1.j(282)   while (1010 > i+1000) { write (p); p--; i++; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
        ;acc16Comp constant 1010
        LD    DE,1010
        OR    A
        SBC   HL,DE
        ;brge 808
        JP    NC,L808
        ;acc16= variable 5
        LD    HL,(05005H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 5
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        ;incr16 variable 1
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
        ;br 797
        JP    L797
        ;;test1.j(283)   //i=10; p=6
        ;;test1.j(284)   while (1011 >= i+1000) { write (p); p--; i++; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
        ;acc16Comp constant 1011
        LD    DE,1011
        OR    A
        SBC   HL,DE
        ;brgt 818
        JP    Z,$+5
        JP    C,L818
        ;acc16= variable 5
        LD    HL,(05005H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 5
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        ;incr16 variable 1
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
        ;br 808
        JP    L808
        ;;test1.j(285)   i=4;
        ;acc8= constant 4
        LD    A,4
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test1.j(286)   while (1002 <  i+1000) { write (i); i--; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
        ;acc16Comp constant 1002
        LD    DE,1002
        OR    A
        SBC   HL,DE
        ;brle 831
        JP    Z,L831
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 821
        JP    L821
        ;;test1.j(287)   //i=2;
        ;;test1.j(288)   while (1001 <= i+1000) { write (i); i--; }
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
        ;acc16Comp constant 1001
        LD    DE,1001
        OR    A
        SBC   HL,DE
        ;brlt 844
        JP    C,L844
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 831
        JP    L831
        ;;test1.j(289) 
        ;;test1.j(290)   /************************/
        ;;test1.j(291)   // constant - constant
        ;;test1.j(292)   // not relevant
        ;;test1.j(293)   write(0);
        ;acc8= constant 0
        LD    A,0
        ;call writeAcc8
        CALL  writeA
        ;;test1.j(294) }
        ;stop
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
