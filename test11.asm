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
        ;;test11.j(0) /* Program to test generated Z80 assembler code */
        ;;test11.j(1) class TestFor {
        ;;test11.j(2)   byte b1 = 115;
        ;acc8= constant 115
        LD    A,115
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test11.j(3)   
        ;;test11.j(4)   /************************/
        ;;test11.j(5)   // global variable within for scope
        ;;test11.j(6)   write (b1);
        ;acc8= variable 0
        LD    A,(05000H)
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(7)   b1--;
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;;test11.j(8)   do {
        ;;test11.j(9)     int j = 1001;
        ;acc16= constant 1001
        LD    HL,1001
        ;acc16=> variable 1
        LD    (05001H),HL
        ;;test11.j(10)     byte c = b1;
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8=> variable 3
        LD    (05003H),A
        ;;test11.j(11)     byte d = c;
        ;acc8= variable 3
        LD    A,(05003H)
        ;acc8=> variable 4
        LD    (05004H),A
        ;;test11.j(12)     b1--;
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;;test11.j(13)     write (c);
        ;acc8= variable 3
        LD    A,(05003H)
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(14)   } while (b1>112);
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8Comp constant 112
        SUB   A,112
        ;brgt 14
        JP    Z,$+5
        JP    C,L14
        ;;test11.j(15) 
        ;;test11.j(16)   /************************/
        ;;test11.j(17)   int i2 = 105;
        ;acc8= constant 105
        LD    A,105
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test11.j(18)   int p = 12;
        ;acc8= constant 12
        LD    A,12
        ;acc8=> variable 3
        LD    L,A
        LD    H,0
        LD    (05003H),HL
        ;;test11.j(19)   byte b2 = 111;
        ;acc8= constant 111
        LD    A,111
        ;acc8=> variable 5
        LD    (05005H),A
        ;;test11.j(20) 
        ;;test11.j(21)   /************************/
        ;;test11.j(22)   // stack8 - constant
        ;;test11.j(23)   // stack8 - acc
        ;;test11.j(24)   // stack8 - var
        ;;test11.j(25)   // stack8 - stack8
        ;;test11.j(26)   // stack8 - stack16
        ;;test11.j(27)   //TODO
        ;;test11.j(28) 
        ;;test11.j(29)   /************************/
        ;;test11.j(30)   // stack16 - constant
        ;;test11.j(31)   // stack16 - acc
        ;;test11.j(32)   // stack16 - var
        ;;test11.j(33)   // stack16 - stack8
        ;;test11.j(34)   // stack16 - stack16
        ;;test11.j(35)   //TODO
        ;;test11.j(36) 
        ;;test11.j(37)   /************************/
        ;;test11.j(38)   // var - stack16
        ;;test11.j(39)   // byte - byte
        ;;test11.j(40)   // byte - integer
        ;;test11.j(41)   // integer - byte
        ;;test11.j(42)   // integer - integer
        ;;test11.j(43)   //TODO
        ;;test11.j(44) 
        ;;test11.j(45)   /************************/
        ;;test11.j(46)   // var - stack8
        ;;test11.j(47)   // byte - byte
        ;;test11.j(48)   // byte - integer
        ;;test11.j(49)   // integer - byte
        ;;test11.j(50)   // integer - integer
        ;;test11.j(51)   //TODO
        ;;test11.j(52) 
        ;;test11.j(53)   /************************/
        ;;test11.j(54)   // var - var
        ;;test11.j(55)   // byte - byte
        ;;test11.j(56)   b2 = 111;
        ;acc8= constant 111
        LD    A,111
        ;acc8=> variable 5
        LD    (05005H),A
        ;;test11.j(57)   for (byte b = 112; b2 <= b; b--) { write (b); }
        ;acc8= constant 112
        LD    A,112
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc8= variable 5
        LD    A,(05005H)
        ;acc8Comp variable 6
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
        ;brgt 96
        JP    Z,$+5
        JP    C,L96
        ;br 91
        JP    L91
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
        ;br 85
        JP    L85
        ;acc8= variable 6
        LD    A,(05006H)
        ;call writeAcc8
        CALL  writeA
        ;br 89
        JP    L89
        ;;test11.j(58)   // byte - integer
        ;;test11.j(59)   b2 = 109;
        ;acc8= constant 109
        LD    A,109
        ;acc8=> variable 5
        LD    (05005H),A
        ;;test11.j(60)   for(int i = 110; b2 <= i; i--) { write(i); }
        ;acc8= constant 110
        LD    A,110
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc8= variable 5
        LD    A,(05005H)
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 113
        JP    Z,$+5
        JP    C,L113
        ;br 108
        JP    L108
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 101
        JP    L101
        ;acc16= variable 6
        LD    HL,(05006H)
        ;call writeAcc16
        CALL  writeHL
        ;br 106
        JP    L106
        ;;test11.j(61)   // integer - byte
        ;;test11.j(62)   i2=107;
        ;acc8= constant 107
        LD    A,107
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test11.j(63)   for (byte b = 108; i2 <= b; b--) { write (b); }
        ;acc8= constant 108
        LD    A,108
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc8= variable 6
        LD    A,(05006H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 130
        JP    Z,$+5
        JP    C,L130
        ;br 125
        JP    L125
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
        ;br 118
        JP    L118
        ;acc8= variable 6
        LD    A,(05006H)
        ;call writeAcc8
        CALL  writeA
        ;br 123
        JP    L123
        ;;test11.j(64)   // integer - integer
        ;;test11.j(65)   i2=105;
        ;acc8= constant 105
        LD    A,105
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test11.j(66)   for(int i = 106; i2 <= i; i--) { write(i); }
        ;acc8= constant 106
        LD    A,106
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16Comp variable 6
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
        ;brgt 149
        JP    Z,$+5
        JP    C,L149
        ;br 141
        JP    L141
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 135
        JP    L135
        ;acc16= variable 6
        LD    HL,(05006H)
        ;call writeAcc16
        CALL  writeHL
        ;br 139
        JP    L139
        ;;test11.j(67) 
        ;;test11.j(68)   /************************/
        ;;test11.j(69)   // var - acc
        ;;test11.j(70)   // byte - byte
        ;;test11.j(71)   i2=104;
        ;acc8= constant 104
        LD    A,104
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test11.j(72)   for (byte b = 104; b <= 105+0; b++) { write (i2); i2--; }
        ;acc8= constant 104
        LD    A,104
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc8= constant 105
        LD    A,105
        ;acc8+ constant 0
        ADD   A,0
        ;acc8Comp variable 6
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
        ;brlt 167
        JP    C,L167
        ;br 161
        JP    L161
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
        ;br 154
        JP    L154
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 159
        JP    L159
        ;;test11.j(73)   // byte - integer
        ;;test11.j(74)   i2=103;
        ;acc8= constant 103
        LD    A,103
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test11.j(75)   for (byte b = 102; b <= i2+0; b--) { write (b); i2=i2-2; }
        ;acc8= constant 102
        LD    A,102
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;acc8= variable 6
        LD    A,(05006H)
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 188
        JP    Z,$+5
        JP    C,L188
        ;br 180
        JP    L180
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
        ;br 172
        JP    L172
        ;acc8= variable 6
        LD    A,(05006H)
        ;call writeAcc8
        CALL  writeA
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16- constant 2
        LD    DE,2
        OR    A
        SBC   HL,DE
        ;acc16=> variable 1
        LD    (05001H),HL
        ;br 178
        JP    L178
        ;;test11.j(76)   // integer - byte
        ;;test11.j(77)   b2=100;
        ;acc8= constant 100
        LD    A,100
        ;acc8=> variable 5
        LD    (05005H),A
        ;;test11.j(78)   for(int i = 100; i <= 101+0; i++) { write(b2); b2--; }
        ;acc8= constant 100
        LD    A,100
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc8= constant 101
        LD    A,101
        ;acc8+ constant 0
        ADD   A,0
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 207
        JP    Z,$+5
        JP    C,L207
        ;br 201
        JP    L201
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
        ;br 193
        JP    L193
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 199
        JP    L199
        ;;test11.j(79)   // integer - integer
        ;;test11.j(80)   for(int i = 1098; i <= 1099+0; i++) { write(b2); b2--; }
        ;acc16= constant 1098
        LD    HL,1098
        ;acc16=> variable 6
        LD    (05006H),HL
        ;acc16= constant 1099
        LD    HL,1099
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;acc16Comp variable 6
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
        ;brlt 225
        JP    C,L225
        ;br 216
        JP    L216
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
        ;br 209
        JP    L209
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 214
        JP    L214
        ;;test11.j(81) 
        ;;test11.j(82)   /************************/
        ;;test11.j(83)   // var - constant
        ;;test11.j(84)   // byte - byte
        ;;test11.j(85)   i2=96;
        ;acc8= constant 96
        LD    A,96
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test11.j(86)   for (byte b = 96; b <= 97; b++) { write (i2); i2--; }
        ;acc8= constant 96
        LD    A,96
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc8= variable 6
        LD    A,(05006H)
        ;acc8Comp constant 97
        SUB   A,97
        ;brgt 243
        JP    Z,$+5
        JP    C,L243
        ;br 236
        JP    L236
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
        ;br 230
        JP    L230
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 234
        JP    L234
        ;;test11.j(87)   // byte - integer
        ;;test11.j(88)   //not relevant
        ;;test11.j(89)   write(94);
        ;acc8= constant 94
        LD    A,94
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(90)   write(93);
        ;acc8= constant 93
        LD    A,93
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(91)   // integer - byte
        ;;test11.j(92)   b2=92;
        ;acc8= constant 92
        LD    A,92
        ;acc8=> variable 5
        LD    (05005H),A
        ;;test11.j(93)   for(int i = 92; i <= 93; i++) { write(b2); b2--; }
        ;acc8= constant 92
        LD    A,92
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc8= constant 93
        LD    A,93
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 268
        JP    Z,$+5
        JP    C,L268
        ;br 262
        JP    L262
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
        ;br 255
        JP    L255
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 260
        JP    L260
        ;;test11.j(94)   // integer - integer
        ;;test11.j(95)   for(int i = 1090; i <= 1091; i++) { write(b2); b2--; }
        ;acc16= constant 1090
        LD    HL,1090
        ;acc16=> variable 6
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc16Comp constant 1091
        LD    DE,1091
        OR    A
        SBC   HL,DE
        ;brgt 286
        JP    Z,$+5
        JP    C,L286
        ;br 276
        JP    L276
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
        ;br 270
        JP    L270
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 274
        JP    L274
        ;;test11.j(96) 
        ;;test11.j(97)   /************************/
        ;;test11.j(98)   // acc - stack8
        ;;test11.j(99)   // byte - byte
        ;;test11.j(100)   //TODO
        ;;test11.j(101)   write(88);
        ;acc8= constant 88
        LD    A,88
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(102)   write(87);
        ;acc8= constant 87
        LD    A,87
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(103)   // byte - integer
        ;;test11.j(104)   //TODO
        ;;test11.j(105)   write(86);
        ;acc8= constant 86
        LD    A,86
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(106)   write(85);
        ;acc8= constant 85
        LD    A,85
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(107)   // integer - byte
        ;;test11.j(108)   //TODO
        ;;test11.j(109)   write(84);
        ;acc8= constant 84
        LD    A,84
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(110)   write(83);
        ;acc8= constant 83
        LD    A,83
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(111)   // integer - integer
        ;;test11.j(112)   //TODO
        ;;test11.j(113)   write(82);
        ;acc8= constant 82
        LD    A,82
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(114)   write(81);
        ;acc8= constant 81
        LD    A,81
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(115) 
        ;;test11.j(116)   /************************/
        ;;test11.j(117)   // acc - stack16
        ;;test11.j(118)   // byte - byte
        ;;test11.j(119)   //TODO
        ;;test11.j(120)   write(80);
        ;acc8= constant 80
        LD    A,80
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(121)   write(79);
        ;acc8= constant 79
        LD    A,79
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(122)   // byte - integer
        ;;test11.j(123)   //TODO
        ;;test11.j(124)   write(78);
        ;acc8= constant 78
        LD    A,78
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(125)   write(77);
        ;acc8= constant 77
        LD    A,77
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(126)   // integer - byte
        ;;test11.j(127)   //TODO
        ;;test11.j(128)   write(76);
        ;acc8= constant 76
        LD    A,76
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(129)   write(75);
        ;acc8= constant 75
        LD    A,75
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(130)   // integer - integer
        ;;test11.j(131)   //TODO
        ;;test11.j(132)   write(74);
        ;acc8= constant 74
        LD    A,74
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(133)   write(73);
        ;acc8= constant 73
        LD    A,73
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(134) 
        ;;test11.j(135)   /************************/
        ;;test11.j(136)   // acc - var
        ;;test11.j(137)   // byte - byte
        ;;test11.j(138)   for (byte b = 72; 71+0 <= b; b--) { write (b); }
        ;acc8= constant 72
        LD    A,72
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc8= constant 71
        LD    A,71
        ;acc8+ constant 0
        ADD   A,0
        ;acc8Comp variable 6
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
        ;brgt 369
        JP    Z,$+5
        JP    C,L369
        ;br 364
        JP    L364
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
        ;br 357
        JP    L357
        ;acc8= variable 6
        LD    A,(05006H)
        ;call writeAcc8
        CALL  writeA
        ;br 362
        JP    L362
        ;;test11.j(139)   // byte - integer
        ;;test11.j(140)   for(int i = 70; 69+0 <= i; i--) { write(i); }
        ;acc8= constant 70
        LD    A,70
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc8= constant 69
        LD    A,69
        ;acc8+ constant 0
        ADD   A,0
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 384
        JP    Z,$+5
        JP    C,L384
        ;br 379
        JP    L379
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 371
        JP    L371
        ;acc16= variable 6
        LD    HL,(05006H)
        ;call writeAcc16
        CALL  writeHL
        ;br 377
        JP    L377
        ;;test11.j(141)   // integer - byte
        ;;test11.j(142)   i2=67;
        ;acc8= constant 67
        LD    A,67
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test11.j(143)   for (byte b = 68; i2+0 <= b; b--) { write (b); }
        ;acc8= constant 68
        LD    A,68
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;acc8= variable 6
        LD    A,(05006H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 402
        JP    Z,$+5
        JP    C,L402
        ;br 397
        JP    L397
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
        ;br 389
        JP    L389
        ;acc8= variable 6
        LD    A,(05006H)
        ;call writeAcc8
        CALL  writeA
        ;br 395
        JP    L395
        ;;test11.j(144)   // integer - integer
        ;;test11.j(145)   b2 = 66;
        ;acc8= constant 66
        LD    A,66
        ;acc8=> variable 5
        LD    (05005H),A
        ;;test11.j(146)   for(int i = 1066; 1000+65 <= i; i--) { write (b2); b2--; }
        ;acc16= constant 1066
        LD    HL,1066
        ;acc16=> variable 6
        LD    (05006H),HL
        ;acc16= constant 1000
        LD    HL,1000
        ;acc16+ constant 65
        LD    DE,65
        ADD   HL,DE
        ;acc16Comp variable 6
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
        ;brgt 423
        JP    Z,$+5
        JP    C,L423
        ;br 414
        JP    L414
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 407
        JP    L407
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 412
        JP    L412
        ;;test11.j(147) 
        ;;test11.j(148)   /************************/
        ;;test11.j(149)   // acc - acc
        ;;test11.j(150)   // byte - byte
        ;;test11.j(151)   for (byte b = 64; 63+0 <= b+0; b--) { write (b); }
        ;acc8= constant 64
        LD    A,64
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc8= constant 63
        LD    A,63
        ;acc8+ constant 0
        ADD   A,0
        ;<acc8
        PUSH AF
        ;acc8= variable 6
        LD    A,(05006H)
        ;acc8+ constant 0
        ADD   A,0
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
        ;brlt 440
        JP    C,L440
        ;br 435
        JP    L435
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
        ;br 425
        JP    L425
        ;acc8= variable 6
        LD    A,(05006H)
        ;call writeAcc8
        CALL  writeA
        ;br 433
        JP    L433
        ;;test11.j(152)   // byte - integer
        ;;test11.j(153)   for(int i = 62; 61+0 <= i+0; i--) { write(i); }
        ;acc8= constant 62
        LD    A,62
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc8= constant 61
        LD    A,61
        ;acc8+ constant 0
        ADD   A,0
        ;<acc8
        PUSH AF
        ;acc16= variable 6
        LD    HL,(05006H)
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
        ;brgt 458
        JP    Z,$+5
        JP    C,L458
        ;br 453
        JP    L453
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 442
        JP    L442
        ;acc16= variable 6
        LD    HL,(05006H)
        ;call writeAcc16
        CALL  writeHL
        ;br 451
        JP    L451
        ;;test11.j(154)   // integer - byte
        ;;test11.j(155)   i2=59;
        ;acc8= constant 59
        LD    A,59
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test11.j(156)   for (byte b = 60; i2+0 <= b+0; b--) { write (b); }
        ;acc8= constant 60
        LD    A,60
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc16= variable 1
        LD    HL,(05001H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc8= variable 6
        LD    A,(05006H)
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
        ;brgt 479
        JP    Z,$+5
        JP    C,L479
        ;br 474
        JP    L474
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
        ;br 463
        JP    L463
        ;acc8= variable 6
        LD    A,(05006H)
        ;call writeAcc8
        CALL  writeA
        ;br 472
        JP    L472
        ;;test11.j(157)   // integer - integer
        ;;test11.j(158)   b2=58;
        ;acc8= constant 58
        LD    A,58
        ;acc8=> variable 5
        LD    (05005H),A
        ;;test11.j(159)   for(int i = 1058; 1000+57 <= i+0; i--) { write(b2); b2--; }
        ;acc16= constant 1058
        LD    HL,1058
        ;acc16=> variable 6
        LD    (05006H),HL
        ;acc16= constant 1000
        LD    HL,1000
        ;acc16+ constant 57
        LD    DE,57
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
        ;brlt 503
        JP    C,L503
        ;br 494
        JP    L494
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 484
        JP    L484
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 492
        JP    L492
        ;;test11.j(160) 
        ;;test11.j(161)   /************************/
        ;;test11.j(162)   // acc - constant
        ;;test11.j(163)   // byte - byte
        ;;test11.j(164)   i2=56;
        ;acc8= constant 56
        LD    A,56
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test11.j(165)   for (byte b = 56; b+0 <= 57; b++) { write (i2); i2--; }
        ;acc8= constant 56
        LD    A,56
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc8= variable 6
        LD    A,(05006H)
        ;acc8+ constant 0
        ADD   A,0
        ;acc8Comp constant 57
        SUB   A,57
        ;brgt 523
        JP    Z,$+5
        JP    C,L523
        ;br 515
        JP    L515
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
        ;br 508
        JP    L508
        ;acc16= variable 1
        LD    HL,(05001H)
        ;call writeAcc16
        CALL  writeHL
        ;decr16 variable 1
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
        ;br 513
        JP    L513
        ;;test11.j(166)   // byte - integer
        ;;test11.j(167)   //not relevant
        ;;test11.j(168)   // integer - byte
        ;;test11.j(169)   b2=54;
        ;acc8= constant 54
        LD    A,54
        ;acc8=> variable 5
        LD    (05005H),A
        ;;test11.j(170)   for (int i = 54; i+0 <= 55; i++) { write (b2); b2--;}
        ;acc8= constant 54
        LD    A,54
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
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
        ;brgt 542
        JP    Z,$+5
        JP    C,L542
        ;br 536
        JP    L536
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
        ;br 528
        JP    L528
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 534
        JP    L534
        ;;test11.j(171)   // integer - integer
        ;;test11.j(172)   b2=52;
        ;acc8= constant 52
        LD    A,52
        ;acc8=> variable 5
        LD    (05005H),A
        ;;test11.j(173)   for(int i = 1052; i+0 <= 1053; i++) { write(b2); b2--; }
        ;acc16= constant 1052
        LD    HL,1052
        ;acc16=> variable 6
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;acc16Comp constant 1053
        LD    DE,1053
        OR    A
        SBC   HL,DE
        ;brgt 564
        JP    Z,$+5
        JP    C,L564
        ;br 554
        JP    L554
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
        ;br 547
        JP    L547
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 552
        JP    L552
        ;;test11.j(174) 
        ;;test11.j(175)   /************************/
        ;;test11.j(176)   // constant - stack8
        ;;test11.j(177)   // byte - byte
        ;;test11.j(178)   //TODO
        ;;test11.j(179)   write(50);
        ;acc8= constant 50
        LD    A,50
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(180)   // constant - stack8
        ;;test11.j(181)   // byte - integer
        ;;test11.j(182)   //TODO
        ;;test11.j(183)   write(49);
        ;acc8= constant 49
        LD    A,49
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(184)   // constant - stack8
        ;;test11.j(185)   // integer - byte
        ;;test11.j(186)   //TODO
        ;;test11.j(187)   write(48);
        ;acc8= constant 48
        LD    A,48
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(188)   // constant - stack88
        ;;test11.j(189)   // integer - integer
        ;;test11.j(190)   //TODO
        ;;test11.j(191)   write(47);
        ;acc8= constant 47
        LD    A,47
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(192) 
        ;;test11.j(193)   /************************/
        ;;test11.j(194)   // constant - stack16
        ;;test11.j(195)   // byte - byte
        ;;test11.j(196)   //TODO
        ;;test11.j(197)   write(46);
        ;acc8= constant 46
        LD    A,46
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(198)   // constant - stack16
        ;;test11.j(199)   // byte - integer
        ;;test11.j(200)   //TODO
        ;;test11.j(201)   write(45);
        ;acc8= constant 45
        LD    A,45
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(202)   // constant - stack16
        ;;test11.j(203)   // integer - byte
        ;;test11.j(204)   //TODO
        ;;test11.j(205)   write(44);
        ;acc8= constant 44
        LD    A,44
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(206)   // constant - stack16
        ;;test11.j(207)   // integer - integer
        ;;test11.j(208)   //TODO
        ;;test11.j(209)   write(43);
        ;acc8= constant 43
        LD    A,43
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(210) 
        ;;test11.j(211)   /************************/
        ;;test11.j(212)   // constant - var
        ;;test11.j(213)   // byte - byte
        ;;test11.j(214)   for (byte b = 42; 41 <= b; b--) { write (b); }
        ;acc8= constant 42
        LD    A,42
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc8= variable 6
        LD    A,(05006H)
        ;acc8Comp constant 41
        SUB   A,41
        ;brlt 629
        JP    C,L629
        ;br 623
        JP    L623
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
        ;br 617
        JP    L617
        ;acc8= variable 6
        LD    A,(05006H)
        ;call writeAcc8
        CALL  writeA
        ;br 621
        JP    L621
        ;;test11.j(215)   // constant - var
        ;;test11.j(216)   // byte - integer
        ;;test11.j(217)   for(int i = 40; 39 <= i; i--) { write(i); }
        ;acc8= constant 40
        LD    A,40
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc8= constant 39
        LD    A,39
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 647
        JP    Z,$+5
        JP    C,L647
        ;br 638
        JP    L638
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 631
        JP    L631
        ;acc16= variable 6
        LD    HL,(05006H)
        ;call writeAcc16
        CALL  writeHL
        ;br 636
        JP    L636
        ;;test11.j(218)   // constant - var
        ;;test11.j(219)   // integer - byte
        ;;test11.j(220)   // not relevant
        ;;test11.j(221)   // constant - var
        ;;test11.j(222)   // integer - integer
        ;;test11.j(223)   b2=38;
        ;acc8= constant 38
        LD    A,38
        ;acc8=> variable 5
        LD    (05005H),A
        ;;test11.j(224)   for(int i = 1038; 1037 <= i; i--) { write(b2); b2--; }
        ;acc16= constant 1038
        LD    HL,1038
        ;acc16=> variable 6
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc16Comp constant 1037
        LD    DE,1037
        OR    A
        SBC   HL,DE
        ;brlt 667
        JP    C,L667
        ;br 658
        JP    L658
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 652
        JP    L652
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 656
        JP    L656
        ;;test11.j(225) 
        ;;test11.j(226)   /************************/
        ;;test11.j(227)   // constant - acc
        ;;test11.j(228)   // byte - byte
        ;;test11.j(229)   for (byte b = 36; 136 == b+100; b--) { write (b); }
        ;acc8= constant 36
        LD    A,36
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc8= variable 6
        LD    A,(05006H)
        ;acc8+ constant 100
        ADD   A,100
        ;acc8Comp constant 136
        SUB   A,136
        ;brne 680
        JP    NZ,L680
        ;br 676
        JP    L676
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
        ;br 669
        JP    L669
        ;acc8= variable 6
        LD    A,(05006H)
        ;call writeAcc8
        CALL  writeA
        ;br 674
        JP    L674
        ;;test11.j(230)   for (byte b = 35; 132 != b+100; b--) { write (b); }
        ;acc8= constant 35
        LD    A,35
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc8= variable 6
        LD    A,(05006H)
        ;acc8+ constant 100
        ADD   A,100
        ;acc8Comp constant 132
        SUB   A,132
        ;breq 693
        JP    Z,L693
        ;br 689
        JP    L689
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
        ;br 682
        JP    L682
        ;acc8= variable 6
        LD    A,(05006H)
        ;call writeAcc8
        CALL  writeA
        ;br 687
        JP    L687
        ;;test11.j(231)   b2=32;
        ;acc8= constant 32
        LD    A,32
        ;acc8=> variable 5
        LD    (05005H),A
        ;;test11.j(232)   for (byte b = 32; 134 > b+100; b++) { write (b2); b2--; }
        ;acc8= constant 32
        LD    A,32
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc8= variable 6
        LD    A,(05006H)
        ;acc8+ constant 100
        ADD   A,100
        ;acc8Comp constant 134
        SUB   A,134
        ;brge 710
        JP    NC,L710
        ;br 705
        JP    L705
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
        ;br 698
        JP    L698
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 703
        JP    L703
        ;;test11.j(233)   for (byte b = 34; 135 >= b+100; b++) { write (b2); b2--; }
        ;acc8= constant 34
        LD    A,34
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc8= variable 6
        LD    A,(05006H)
        ;acc8+ constant 100
        ADD   A,100
        ;acc8Comp constant 135
        SUB   A,135
        ;brgt 724
        JP    Z,$+5
        JP    C,L724
        ;br 719
        JP    L719
        ;incr8 variable 6
        LD    HL,(05006H)
        INC   (HL)
        ;br 712
        JP    L712
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 717
        JP    L717
        ;;test11.j(234)   for (byte b = 28; 126 <  b+100; b--) { write (b); }
        ;acc8= constant 28
        LD    A,28
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc8= variable 6
        LD    A,(05006H)
        ;acc8+ constant 100
        ADD   A,100
        ;acc8Comp constant 126
        SUB   A,126
        ;brle 737
        JP    Z,L737
        ;br 733
        JP    L733
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
        ;br 726
        JP    L726
        ;acc8= variable 6
        LD    A,(05006H)
        ;call writeAcc8
        CALL  writeA
        ;br 731
        JP    L731
        ;;test11.j(235)   for (byte b = 26; 125 <= b+100; b--) { write (b); }
        ;acc8= constant 26
        LD    A,26
        ;acc8=> variable 6
        LD    (05006H),A
        ;acc8= variable 6
        LD    A,(05006H)
        ;acc8+ constant 100
        ADD   A,100
        ;acc8Comp constant 125
        SUB   A,125
        ;brlt 752
        JP    C,L752
        ;br 746
        JP    L746
        ;decr8 variable 6
        LD    HL,(05006H)
        DEC   (HL)
        ;br 739
        JP    L739
        ;acc8= variable 6
        LD    A,(05006H)
        ;call writeAcc8
        CALL  writeA
        ;br 744
        JP    L744
        ;;test11.j(236)   // constant - acc
        ;;test11.j(237)   // byte - integer
        ;;test11.j(238)   for(int i = 24; 24 == i+0; i--) { write(i); }
        ;acc8= constant 24
        LD    A,24
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc16+ constant 0
        LD    DE,0
        ADD   HL,DE
        ;acc8= constant 24
        LD    A,24
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brne 766
        JP    NZ,L766
        ;br 762
        JP    L762
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 754
        JP    L754
        ;acc16= variable 6
        LD    HL,(05006H)
        ;call writeAcc16
        CALL  writeHL
        ;br 760
        JP    L760
        ;;test11.j(239)   for(int i = 23; 120 != i+100; i--) { write(i); }
        ;acc8= constant 23
        LD    A,23
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
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
        ;breq 780
        JP    Z,L780
        ;br 776
        JP    L776
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 768
        JP    L768
        ;acc16= variable 6
        LD    HL,(05006H)
        ;call writeAcc16
        CALL  writeHL
        ;br 774
        JP    L774
        ;;test11.j(240)   b2=20;
        ;acc8= constant 20
        LD    A,20
        ;acc8=> variable 5
        LD    (05005H),A
        ;;test11.j(241)   for(int i = 20; 122 > i+100; i++) { write (b2); b2--; }
        ;acc8= constant 20
        LD    A,20
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
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
        ;brle 798
        JP    Z,L798
        ;br 793
        JP    L793
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
        ;br 785
        JP    L785
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 791
        JP    L791
        ;;test11.j(242)   for(int i = 22; 123 >= i+100; i++) { write (b2); b2--; }
        ;acc8= constant 22
        LD    A,22
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
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
        ;brlt 813
        JP    C,L813
        ;br 808
        JP    L808
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
        ;br 800
        JP    L800
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 806
        JP    L806
        ;;test11.j(243)   for(int i = 16; 114 <  i+100; i--) { write(i); }
        ;acc8= constant 16
        LD    A,16
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
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
        ;brge 827
        JP    NC,L827
        ;br 823
        JP    L823
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 815
        JP    L815
        ;acc16= variable 6
        LD    HL,(05006H)
        ;call writeAcc16
        CALL  writeHL
        ;br 821
        JP    L821
        ;;test11.j(244)   for(int i = 14; 113 <= i+100; i--) { write(i); }
        ;acc8= constant 14
        LD    A,14
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
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
        ;brgt 847
        JP    Z,$+5
        JP    C,L847
        ;br 837
        JP    L837
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 829
        JP    L829
        ;acc16= variable 6
        LD    HL,(05006H)
        ;call writeAcc16
        CALL  writeHL
        ;br 835
        JP    L835
        ;;test11.j(245)   // constant - acc
        ;;test11.j(246)   // integer - byte
        ;;test11.j(247)   // not relevant
        ;;test11.j(248) 
        ;;test11.j(249)   // constant - acc
        ;;test11.j(250)   // integer - integer
        ;;test11.j(251)   for(int i = 12; 1012 == i+1000; i--) { write(i); }
        ;acc8= constant 12
        LD    A,12
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
        ;acc16Comp constant 1012
        LD    DE,1012
        OR    A
        SBC   HL,DE
        ;brne 860
        JP    NZ,L860
        ;br 856
        JP    L856
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 849
        JP    L849
        ;acc16= variable 6
        LD    HL,(05006H)
        ;call writeAcc16
        CALL  writeHL
        ;br 854
        JP    L854
        ;;test11.j(252)   for(int i = 11; 1008 != i+1000; i--) { write(i); }
        ;acc8= constant 11
        LD    A,11
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
        ;acc16Comp constant 1008
        LD    DE,1008
        OR    A
        SBC   HL,DE
        ;breq 873
        JP    Z,L873
        ;br 869
        JP    L869
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 862
        JP    L862
        ;acc16= variable 6
        LD    HL,(05006H)
        ;call writeAcc16
        CALL  writeHL
        ;br 867
        JP    L867
        ;;test11.j(253)   b2=8;
        ;acc8= constant 8
        LD    A,8
        ;acc8=> variable 5
        LD    (05005H),A
        ;;test11.j(254)   for(int i = 8; 1010 > i+1000; i++) { write (b2); b2--; }
        ;acc8= constant 8
        LD    A,8
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
        ;acc16Comp constant 1010
        LD    DE,1010
        OR    A
        SBC   HL,DE
        ;brge 890
        JP    NC,L890
        ;br 885
        JP    L885
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
        ;br 878
        JP    L878
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 883
        JP    L883
        ;;test11.j(255)   for(int i = 10; 1011 >= i+1000; i++) { write (b2); b2--; }
        ;acc8= constant 10
        LD    A,10
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
        ;acc16Comp constant 1011
        LD    DE,1011
        OR    A
        SBC   HL,DE
        ;brgt 904
        JP    Z,$+5
        JP    C,L904
        ;br 899
        JP    L899
        ;incr16 variable 6
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
        ;br 892
        JP    L892
        ;acc8= variable 5
        LD    A,(05005H)
        ;call writeAcc8
        CALL  writeA
        ;decr8 variable 5
        LD    HL,(05005H)
        DEC   (HL)
        ;br 897
        JP    L897
        ;;test11.j(256)   for(int i = 4; 1002 <  i+1000; i--) { write(i); }
        ;acc8= constant 4
        LD    A,4
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
        ;acc16Comp constant 1002
        LD    DE,1002
        OR    A
        SBC   HL,DE
        ;brle 917
        JP    Z,L917
        ;br 913
        JP    L913
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 906
        JP    L906
        ;acc16= variable 6
        LD    HL,(05006H)
        ;call writeAcc16
        CALL  writeHL
        ;br 911
        JP    L911
        ;;test11.j(257)   for(int i = 2; 1001 <= i+1000; i--) { write(i); }
        ;acc8= constant 2
        LD    A,2
        ;acc8=> variable 6
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;acc16= variable 6
        LD    HL,(05006H)
        ;acc16+ constant 1000
        LD    DE,1000
        ADD   HL,DE
        ;acc16Comp constant 1001
        LD    DE,1001
        OR    A
        SBC   HL,DE
        ;brlt 930
        JP    C,L930
        ;br 926
        JP    L926
        ;decr16 variable 6
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
        ;br 919
        JP    L919
        ;acc16= variable 6
        LD    HL,(05006H)
        ;call writeAcc16
        CALL  writeHL
        ;br 924
        JP    L924
        ;;test11.j(258)   write(0);
        ;acc8= constant 0
        LD    A,0
        ;call writeAcc8
        CALL  writeA
        ;;test11.j(259) }
        ;stop
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
