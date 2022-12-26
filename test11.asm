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
L0:
        ;;test11.j(0) /* Program to test generated Z80 assembler code */
L1:
        ;;test11.j(1) class TestFor {
L2:
        ;;test11.j(2)   byte b1 = 115;
L3:
        LD    A,115
L4:
        LD    (05000H),A
L5:
        ;;test11.j(3)   
L6:
        ;;test11.j(4)   /************************/
L7:
        ;;test11.j(5)   // global variable within for scope
L8:
        ;;test11.j(6)   write (b1);
L9:
        LD    A,(05000H)
L10:
        CALL  writeA
L11:
        ;;test11.j(7)   b1--;
L12:
        LD    HL,(05000H)
        DEC   (HL)
L13:
        ;;test11.j(8)   do {
L14:
        ;;test11.j(9)     int j = 1001;
L15:
        LD    HL,1001
L16:
        LD    (05001H),HL
L17:
        ;;test11.j(10)     byte c = b1;
L18:
        LD    A,(05000H)
L19:
        LD    (05003H),A
L20:
        ;;test11.j(11)     byte d = c;
L21:
        LD    A,(05003H)
L22:
        LD    (05004H),A
L23:
        ;;test11.j(12)     b1--;
L24:
        LD    HL,(05000H)
        DEC   (HL)
L25:
        ;;test11.j(13)     write (c);
L26:
        LD    A,(05003H)
L27:
        CALL  writeA
L28:
        ;;test11.j(14)   } while (b1>112);
L29:
        LD    A,(05000H)
L30:
        SUB   A,112
L31:
        JR    Z,$+5
        JP    C,L14
L32:
        ;;test11.j(15) 
L33:
        ;;test11.j(16)   /************************/
L34:
        ;;test11.j(17)   int i2 = 105;
L35:
        LD    A,105
L36:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L37:
        ;;test11.j(18)   int p = 12;
L38:
        LD    A,12
L39:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L40:
        ;;test11.j(19)   byte b2 = 111;
L41:
        LD    A,111
L42:
        LD    (05005H),A
L43:
        ;;test11.j(20) 
L44:
        ;;test11.j(21)   /************************/
L45:
        ;;test11.j(22)   // stack8 - constant
L46:
        ;;test11.j(23)   // stack8 - acc
L47:
        ;;test11.j(24)   // stack8 - var
L48:
        ;;test11.j(25)   // stack8 - stack8
L49:
        ;;test11.j(26)   // stack8 - stack16
L50:
        ;;test11.j(27)   //TODO
L51:
        ;;test11.j(28) 
L52:
        ;;test11.j(29)   /************************/
L53:
        ;;test11.j(30)   // stack16 - constant
L54:
        ;;test11.j(31)   // stack16 - acc
L55:
        ;;test11.j(32)   // stack16 - var
L56:
        ;;test11.j(33)   // stack16 - stack8
L57:
        ;;test11.j(34)   // stack16 - stack16
L58:
        ;;test11.j(35)   //TODO
L59:
        ;;test11.j(36) 
L60:
        ;;test11.j(37)   /************************/
L61:
        ;;test11.j(38)   // var - stack16
L62:
        ;;test11.j(39)   // byte - byte
L63:
        ;;test11.j(40)   // byte - integer
L64:
        ;;test11.j(41)   // integer - byte
L65:
        ;;test11.j(42)   // integer - integer
L66:
        ;;test11.j(43)   //TODO
L67:
        ;;test11.j(44) 
L68:
        ;;test11.j(45)   /************************/
L69:
        ;;test11.j(46)   // var - stack8
L70:
        ;;test11.j(47)   // byte - byte
L71:
        ;;test11.j(48)   // byte - integer
L72:
        ;;test11.j(49)   // integer - byte
L73:
        ;;test11.j(50)   // integer - integer
L74:
        ;;test11.j(51)   //TODO
L75:
        ;;test11.j(52) 
L76:
        ;;test11.j(53)   /************************/
L77:
        ;;test11.j(54)   // var - var
L78:
        ;;test11.j(55)   // byte - byte
L79:
        ;;test11.j(56)   b2 = 111;
L80:
        LD    A,111
L81:
        LD    (05005H),A
L82:
        ;;test11.j(57)   for (byte b = 112; b2 <= b; b--) { write (b); }
L83:
        LD    A,112
L84:
        LD    (05006H),A
L85:
        LD    A,(05005H)
L86:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L87:
        JR    Z,$+5
        JP    C,L96
L88:
        JP    L91
L89:
        LD    HL,(05006H)
        DEC   (HL)
L90:
        JP    L85
L91:
        LD    A,(05006H)
L92:
        CALL  writeA
L93:
        JP    L89
L94:
        ;;test11.j(58)   // byte - integer
L95:
        ;;test11.j(59)   b2 = 109;
L96:
        LD    A,109
L97:
        LD    (05005H),A
L98:
        ;;test11.j(60)   for(int i = 110; b2 <= i; i--) { write(i); }
L99:
        LD    A,110
L100:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L101:
        LD    A,(05005H)
L102:
        LD    HL,(05006H)
L103:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L104:
        JR    Z,$+5
        JP    C,L113
L105:
        JP    L108
L106:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L107:
        JP    L101
L108:
        LD    HL,(05006H)
L109:
        CALL  writeHL
L110:
        JP    L106
L111:
        ;;test11.j(61)   // integer - byte
L112:
        ;;test11.j(62)   i2=107;
L113:
        LD    A,107
L114:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L115:
        ;;test11.j(63)   for (byte b = 108; i2 <= b; b--) { write (b); }
L116:
        LD    A,108
L117:
        LD    (05006H),A
L118:
        LD    HL,(05001H)
L119:
        LD    A,(05006H)
L120:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L121:
        JR    Z,$+5
        JP    C,L130
L122:
        JP    L125
L123:
        LD    HL,(05006H)
        DEC   (HL)
L124:
        JP    L118
L125:
        LD    A,(05006H)
L126:
        CALL  writeA
L127:
        JP    L123
L128:
        ;;test11.j(64)   // integer - integer
L129:
        ;;test11.j(65)   i2=105;
L130:
        LD    A,105
L131:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L132:
        ;;test11.j(66)   for(int i = 106; i2 <= i; i--) { write(i); }
L133:
        LD    A,106
L134:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L135:
        LD    HL,(05001H)
L136:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L137:
        JR    Z,$+5
        JP    C,L149
L138:
        JP    L141
L139:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L140:
        JP    L135
L141:
        LD    HL,(05006H)
L142:
        CALL  writeHL
L143:
        JP    L139
L144:
        ;;test11.j(67) 
L145:
        ;;test11.j(68)   /************************/
L146:
        ;;test11.j(69)   // var - acc
L147:
        ;;test11.j(70)   // byte - byte
L148:
        ;;test11.j(71)   i2=104;
L149:
        LD    A,104
L150:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L151:
        ;;test11.j(72)   for (byte b = 104; b <= 105+0; b++) { write (i2); i2--; }
L152:
        LD    A,104
L153:
        LD    (05006H),A
L154:
        LD    A,105
L155:
        ADD   A,0
L156:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L157:
        JP    C,L167
L158:
        JP    L161
L159:
        LD    HL,(05006H)
        INC   (HL)
L160:
        JP    L154
L161:
        LD    HL,(05001H)
L162:
        CALL  writeHL
L163:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L164:
        JP    L159
L165:
        ;;test11.j(73)   // byte - integer
L166:
        ;;test11.j(74)   i2=103;
L167:
        LD    A,103
L168:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L169:
        ;;test11.j(75)   for (byte b = 102; b <= i2+0; b--) { write (b); i2=i2-2; }
L170:
        LD    A,102
L171:
        LD    (05006H),A
L172:
        LD    HL,(05001H)
L173:
        LD    DE,0
        ADD   HL,DE
L174:
        LD    A,(05006H)
L175:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L176:
        JR    Z,$+5
        JP    C,L188
L177:
        JP    L180
L178:
        LD    HL,(05006H)
        DEC   (HL)
L179:
        JP    L172
L180:
        LD    A,(05006H)
L181:
        CALL  writeA
L182:
        LD    HL,(05001H)
L183:
        LD    DE,2
        OR    A
        SBC   HL,DE
L184:
        LD    (05001H),HL
L185:
        JP    L178
L186:
        ;;test11.j(76)   // integer - byte
L187:
        ;;test11.j(77)   b2=100;
L188:
        LD    A,100
L189:
        LD    (05005H),A
L190:
        ;;test11.j(78)   for(int i = 100; i <= 101+0; i++) { write(b2); b2--; }
L191:
        LD    A,100
L192:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L193:
        LD    A,101
L194:
        ADD   A,0
L195:
        LD    HL,(05006H)
L196:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L197:
        JR    Z,$+5
        JP    C,L207
L198:
        JP    L201
L199:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L200:
        JP    L193
L201:
        LD    A,(05005H)
L202:
        CALL  writeA
L203:
        LD    HL,(05005H)
        DEC   (HL)
L204:
        JP    L199
L205:
        ;;test11.j(79)   // integer - integer
L206:
        ;;test11.j(80)   for(int i = 1098; i <= 1099+0; i++) { write(b2); b2--; }
L207:
        LD    HL,1098
L208:
        LD    (05006H),HL
L209:
        LD    HL,1099
L210:
        LD    DE,0
        ADD   HL,DE
L211:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L212:
        JP    C,L225
L213:
        JP    L216
L214:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L215:
        JP    L209
L216:
        LD    A,(05005H)
L217:
        CALL  writeA
L218:
        LD    HL,(05005H)
        DEC   (HL)
L219:
        JP    L214
L220:
        ;;test11.j(81) 
L221:
        ;;test11.j(82)   /************************/
L222:
        ;;test11.j(83)   // var - constant
L223:
        ;;test11.j(84)   // byte - byte
L224:
        ;;test11.j(85)   i2=96;
L225:
        LD    A,96
L226:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L227:
        ;;test11.j(86)   for (byte b = 96; b <= 97; b++) { write (i2); i2--; }
L228:
        LD    A,96
L229:
        LD    (05006H),A
L230:
        LD    A,(05006H)
L231:
        SUB   A,97
L232:
        JR    Z,$+5
        JP    C,L243
L233:
        JP    L236
L234:
        LD    HL,(05006H)
        INC   (HL)
L235:
        JP    L230
L236:
        LD    HL,(05001H)
L237:
        CALL  writeHL
L238:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L239:
        JP    L234
L240:
        ;;test11.j(87)   // byte - integer
L241:
        ;;test11.j(88)   //not relevant
L242:
        ;;test11.j(89)   write(94);
L243:
        LD    A,94
L244:
        CALL  writeA
L245:
        ;;test11.j(90)   write(93);
L246:
        LD    A,93
L247:
        CALL  writeA
L248:
        ;;test11.j(91)   // integer - byte
L249:
        ;;test11.j(92)   b2=92;
L250:
        LD    A,92
L251:
        LD    (05005H),A
L252:
        ;;test11.j(93)   for(int i = 92; i <= 93; i++) { write(b2); b2--; }
L253:
        LD    A,92
L254:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L255:
        LD    HL,(05006H)
L256:
        LD    A,93
L257:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L258:
        JR    Z,$+5
        JP    C,L268
L259:
        JP    L262
L260:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L261:
        JP    L255
L262:
        LD    A,(05005H)
L263:
        CALL  writeA
L264:
        LD    HL,(05005H)
        DEC   (HL)
L265:
        JP    L260
L266:
        ;;test11.j(94)   // integer - integer
L267:
        ;;test11.j(95)   for(int i = 1090; i <= 1091; i++) { write(b2); b2--; }
L268:
        LD    HL,1090
L269:
        LD    (05006H),HL
L270:
        LD    HL,(05006H)
L271:
        LD    DE,1091
        OR    A
        SBC   HL,DE
L272:
        JR    Z,$+5
        JP    C,L286
L273:
        JP    L276
L274:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L275:
        JP    L270
L276:
        LD    A,(05005H)
L277:
        CALL  writeA
L278:
        LD    HL,(05005H)
        DEC   (HL)
L279:
        JP    L274
L280:
        ;;test11.j(96) 
L281:
        ;;test11.j(97)   /************************/
L282:
        ;;test11.j(98)   // acc - stack8
L283:
        ;;test11.j(99)   // byte - byte
L284:
        ;;test11.j(100)   //TODO
L285:
        ;;test11.j(101)   write(88);
L286:
        LD    A,88
L287:
        CALL  writeA
L288:
        ;;test11.j(102)   write(87);
L289:
        LD    A,87
L290:
        CALL  writeA
L291:
        ;;test11.j(103)   // byte - integer
L292:
        ;;test11.j(104)   //TODO
L293:
        ;;test11.j(105)   write(86);
L294:
        LD    A,86
L295:
        CALL  writeA
L296:
        ;;test11.j(106)   write(85);
L297:
        LD    A,85
L298:
        CALL  writeA
L299:
        ;;test11.j(107)   // integer - byte
L300:
        ;;test11.j(108)   //TODO
L301:
        ;;test11.j(109)   write(84);
L302:
        LD    A,84
L303:
        CALL  writeA
L304:
        ;;test11.j(110)   write(83);
L305:
        LD    A,83
L306:
        CALL  writeA
L307:
        ;;test11.j(111)   // integer - integer
L308:
        ;;test11.j(112)   //TODO
L309:
        ;;test11.j(113)   write(82);
L310:
        LD    A,82
L311:
        CALL  writeA
L312:
        ;;test11.j(114)   write(81);
L313:
        LD    A,81
L314:
        CALL  writeA
L315:
        ;;test11.j(115) 
L316:
        ;;test11.j(116)   /************************/
L317:
        ;;test11.j(117)   // acc - stack16
L318:
        ;;test11.j(118)   // byte - byte
L319:
        ;;test11.j(119)   //TODO
L320:
        ;;test11.j(120)   write(80);
L321:
        LD    A,80
L322:
        CALL  writeA
L323:
        ;;test11.j(121)   write(79);
L324:
        LD    A,79
L325:
        CALL  writeA
L326:
        ;;test11.j(122)   // byte - integer
L327:
        ;;test11.j(123)   //TODO
L328:
        ;;test11.j(124)   write(78);
L329:
        LD    A,78
L330:
        CALL  writeA
L331:
        ;;test11.j(125)   write(77);
L332:
        LD    A,77
L333:
        CALL  writeA
L334:
        ;;test11.j(126)   // integer - byte
L335:
        ;;test11.j(127)   //TODO
L336:
        ;;test11.j(128)   write(76);
L337:
        LD    A,76
L338:
        CALL  writeA
L339:
        ;;test11.j(129)   write(75);
L340:
        LD    A,75
L341:
        CALL  writeA
L342:
        ;;test11.j(130)   // integer - integer
L343:
        ;;test11.j(131)   //TODO
L344:
        ;;test11.j(132)   write(74);
L345:
        LD    A,74
L346:
        CALL  writeA
L347:
        ;;test11.j(133)   write(73);
L348:
        LD    A,73
L349:
        CALL  writeA
L350:
        ;;test11.j(134) 
L351:
        ;;test11.j(135)   /************************/
L352:
        ;;test11.j(136)   // acc - var
L353:
        ;;test11.j(137)   // byte - byte
L354:
        ;;test11.j(138)   for (byte b = 72; 71+0 <= b; b--) { write (b); }
L355:
        LD    A,72
L356:
        LD    (05006H),A
L357:
        LD    A,71
L358:
        ADD   A,0
L359:
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
L360:
        JR    Z,$+5
        JP    C,L369
L361:
        JP    L364
L362:
        LD    HL,(05006H)
        DEC   (HL)
L363:
        JP    L357
L364:
        LD    A,(05006H)
L365:
        CALL  writeA
L366:
        JP    L362
L367:
        ;;test11.j(139)   // byte - integer
L368:
        ;;test11.j(140)   for(int i = 70; 69+0 <= i; i--) { write(i); }
L369:
        LD    A,70
L370:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L371:
        LD    A,69
L372:
        ADD   A,0
L373:
        LD    HL,(05006H)
L374:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L375:
        JR    Z,$+5
        JP    C,L384
L376:
        JP    L379
L377:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L378:
        JP    L371
L379:
        LD    HL,(05006H)
L380:
        CALL  writeHL
L381:
        JP    L377
L382:
        ;;test11.j(141)   // integer - byte
L383:
        ;;test11.j(142)   i2=67;
L384:
        LD    A,67
L385:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L386:
        ;;test11.j(143)   for (byte b = 68; i2+0 <= b; b--) { write (b); }
L387:
        LD    A,68
L388:
        LD    (05006H),A
L389:
        LD    HL,(05001H)
L390:
        LD    DE,0
        ADD   HL,DE
L391:
        LD    A,(05006H)
L392:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L393:
        JR    Z,$+5
        JP    C,L402
L394:
        JP    L397
L395:
        LD    HL,(05006H)
        DEC   (HL)
L396:
        JP    L389
L397:
        LD    A,(05006H)
L398:
        CALL  writeA
L399:
        JP    L395
L400:
        ;;test11.j(144)   // integer - integer
L401:
        ;;test11.j(145)   b2 = 66;
L402:
        LD    A,66
L403:
        LD    (05005H),A
L404:
        ;;test11.j(146)   for(int i = 1066; 1000+65 <= i; i--) { write (b2); b2--; }
L405:
        LD    HL,1066
L406:
        LD    (05006H),HL
L407:
        LD    HL,1000
L408:
        LD    DE,65
        ADD   HL,DE
L409:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L410:
        JR    Z,$+5
        JP    C,L423
L411:
        JP    L414
L412:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L413:
        JP    L407
L414:
        LD    A,(05005H)
L415:
        CALL  writeA
L416:
        LD    HL,(05005H)
        DEC   (HL)
L417:
        JP    L412
L418:
        ;;test11.j(147) 
L419:
        ;;test11.j(148)   /************************/
L420:
        ;;test11.j(149)   // acc - acc
L421:
        ;;test11.j(150)   // byte - byte
L422:
        ;;test11.j(151)   for (byte b = 64; 63+0 <= b+0; b--) { write (b); }
L423:
        LD    A,64
L424:
        LD    (05006H),A
L425:
        LD    A,63
L426:
        ADD   A,0
L427:
        PUSH AF
L428:
        LD    A,(05006H)
L429:
        ADD   A,0
L430:
        POP   BC
        SUB   A,B
L431:
        JP    C,L440
L432:
        JP    L435
L433:
        LD    HL,(05006H)
        DEC   (HL)
L434:
        JP    L425
L435:
        LD    A,(05006H)
L436:
        CALL  writeA
L437:
        JP    L433
L438:
        ;;test11.j(152)   // byte - integer
L439:
        ;;test11.j(153)   for(int i = 62; 61+0 <= i+0; i--) { write(i); }
L440:
        LD    A,62
L441:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L442:
        LD    A,61
L443:
        ADD   A,0
L444:
        PUSH AF
L445:
        LD    HL,(05006H)
L446:
        LD    DE,0
        ADD   HL,DE
L447:
        POP  AF
L448:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L449:
        JR    Z,$+5
        JP    C,L458
L450:
        JP    L453
L451:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L452:
        JP    L442
L453:
        LD    HL,(05006H)
L454:
        CALL  writeHL
L455:
        JP    L451
L456:
        ;;test11.j(154)   // integer - byte
L457:
        ;;test11.j(155)   i2=59;
L458:
        LD    A,59
L459:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L460:
        ;;test11.j(156)   for (byte b = 60; i2+0 <= b+0; b--) { write (b); }
L461:
        LD    A,60
L462:
        LD    (05006H),A
L463:
        LD    HL,(05001H)
L464:
        LD    DE,0
        ADD   HL,DE
L465:
        PUSH HL
L466:
        LD    A,(05006H)
L467:
        ADD   A,0
L468:
        POP  HL
L469:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L470:
        JR    Z,$+5
        JP    C,L479
L471:
        JP    L474
L472:
        LD    HL,(05006H)
        DEC   (HL)
L473:
        JP    L463
L474:
        LD    A,(05006H)
L475:
        CALL  writeA
L476:
        JP    L472
L477:
        ;;test11.j(157)   // integer - integer
L478:
        ;;test11.j(158)   b2=58;
L479:
        LD    A,58
L480:
        LD    (05005H),A
L481:
        ;;test11.j(159)   for(int i = 1058; 1000+57 <= i+0; i--) { write(b2); b2--; }
L482:
        LD    HL,1058
L483:
        LD    (05006H),HL
L484:
        LD    HL,1000
L485:
        LD    DE,57
        ADD   HL,DE
L486:
        PUSH HL
L487:
        LD    HL,(05006H)
L488:
        LD    DE,0
        ADD   HL,DE
L489:
        POP   DE
        OR    A
        SBC   HL,DE
L490:
        JP    C,L503
L491:
        JP    L494
L492:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L493:
        JP    L484
L494:
        LD    A,(05005H)
L495:
        CALL  writeA
L496:
        LD    HL,(05005H)
        DEC   (HL)
L497:
        JP    L492
L498:
        ;;test11.j(160) 
L499:
        ;;test11.j(161)   /************************/
L500:
        ;;test11.j(162)   // acc - constant
L501:
        ;;test11.j(163)   // byte - byte
L502:
        ;;test11.j(164)   i2=56;
L503:
        LD    A,56
L504:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L505:
        ;;test11.j(165)   for (byte b = 56; b+0 <= 57; b++) { write (i2); i2--; }
L506:
        LD    A,56
L507:
        LD    (05006H),A
L508:
        LD    A,(05006H)
L509:
        ADD   A,0
L510:
        SUB   A,57
L511:
        JR    Z,$+5
        JP    C,L523
L512:
        JP    L515
L513:
        LD    HL,(05006H)
        INC   (HL)
L514:
        JP    L508
L515:
        LD    HL,(05001H)
L516:
        CALL  writeHL
L517:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L518:
        JP    L513
L519:
        ;;test11.j(166)   // byte - integer
L520:
        ;;test11.j(167)   //not relevant
L521:
        ;;test11.j(168)   // integer - byte
L522:
        ;;test11.j(169)   b2=54;
L523:
        LD    A,54
L524:
        LD    (05005H),A
L525:
        ;;test11.j(170)   for (int i = 54; i+0 <= 55; i++) { write (b2); b2--;}
L526:
        LD    A,54
L527:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L528:
        LD    HL,(05006H)
L529:
        LD    DE,0
        ADD   HL,DE
L530:
        LD    A,55
L531:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L532:
        JR    Z,$+5
        JP    C,L542
L533:
        JP    L536
L534:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L535:
        JP    L528
L536:
        LD    A,(05005H)
L537:
        CALL  writeA
L538:
        LD    HL,(05005H)
        DEC   (HL)
L539:
        JP    L534
L540:
        ;;test11.j(171)   // integer - integer
L541:
        ;;test11.j(172)   b2=52;
L542:
        LD    A,52
L543:
        LD    (05005H),A
L544:
        ;;test11.j(173)   for(int i = 1052; i+0 <= 1053; i++) { write(b2); b2--; }
L545:
        LD    HL,1052
L546:
        LD    (05006H),HL
L547:
        LD    HL,(05006H)
L548:
        LD    DE,0
        ADD   HL,DE
L549:
        LD    DE,1053
        OR    A
        SBC   HL,DE
L550:
        JR    Z,$+5
        JP    C,L564
L551:
        JP    L554
L552:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L553:
        JP    L547
L554:
        LD    A,(05005H)
L555:
        CALL  writeA
L556:
        LD    HL,(05005H)
        DEC   (HL)
L557:
        JP    L552
L558:
        ;;test11.j(174) 
L559:
        ;;test11.j(175)   /************************/
L560:
        ;;test11.j(176)   // constant - stack8
L561:
        ;;test11.j(177)   // byte - byte
L562:
        ;;test11.j(178)   //TODO
L563:
        ;;test11.j(179)   write(50);
L564:
        LD    A,50
L565:
        CALL  writeA
L566:
        ;;test11.j(180)   // constant - stack8
L567:
        ;;test11.j(181)   // byte - integer
L568:
        ;;test11.j(182)   //TODO
L569:
        ;;test11.j(183)   write(49);
L570:
        LD    A,49
L571:
        CALL  writeA
L572:
        ;;test11.j(184)   // constant - stack8
L573:
        ;;test11.j(185)   // integer - byte
L574:
        ;;test11.j(186)   //TODO
L575:
        ;;test11.j(187)   write(48);
L576:
        LD    A,48
L577:
        CALL  writeA
L578:
        ;;test11.j(188)   // constant - stack88
L579:
        ;;test11.j(189)   // integer - integer
L580:
        ;;test11.j(190)   //TODO
L581:
        ;;test11.j(191)   write(47);
L582:
        LD    A,47
L583:
        CALL  writeA
L584:
        ;;test11.j(192) 
L585:
        ;;test11.j(193)   /************************/
L586:
        ;;test11.j(194)   // constant - stack16
L587:
        ;;test11.j(195)   // byte - byte
L588:
        ;;test11.j(196)   //TODO
L589:
        ;;test11.j(197)   write(46);
L590:
        LD    A,46
L591:
        CALL  writeA
L592:
        ;;test11.j(198)   // constant - stack16
L593:
        ;;test11.j(199)   // byte - integer
L594:
        ;;test11.j(200)   //TODO
L595:
        ;;test11.j(201)   write(45);
L596:
        LD    A,45
L597:
        CALL  writeA
L598:
        ;;test11.j(202)   // constant - stack16
L599:
        ;;test11.j(203)   // integer - byte
L600:
        ;;test11.j(204)   //TODO
L601:
        ;;test11.j(205)   write(44);
L602:
        LD    A,44
L603:
        CALL  writeA
L604:
        ;;test11.j(206)   // constant - stack16
L605:
        ;;test11.j(207)   // integer - integer
L606:
        ;;test11.j(208)   //TODO
L607:
        ;;test11.j(209)   write(43);
L608:
        LD    A,43
L609:
        CALL  writeA
L610:
        ;;test11.j(210) 
L611:
        ;;test11.j(211)   /************************/
L612:
        ;;test11.j(212)   // constant - var
L613:
        ;;test11.j(213)   // byte - byte
L614:
        ;;test11.j(214)   for (byte b = 42; 41 <= b; b--) { write (b); }
L615:
        LD    A,42
L616:
        LD    (05006H),A
L617:
        LD    A,(05006H)
L618:
        SUB   A,41
L619:
        JP    C,L629
L620:
        JP    L623
L621:
        LD    HL,(05006H)
        DEC   (HL)
L622:
        JP    L617
L623:
        LD    A,(05006H)
L624:
        CALL  writeA
L625:
        JP    L621
L626:
        ;;test11.j(215)   // constant - var
L627:
        ;;test11.j(216)   // byte - integer
L628:
        ;;test11.j(217)   for(int i = 40; 39 <= i; i--) { write(i); }
L629:
        LD    A,40
L630:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L631:
        LD    HL,(05006H)
L632:
        LD    A,39
L633:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L634:
        JR    Z,$+5
        JP    C,L647
L635:
        JP    L638
L636:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L637:
        JP    L631
L638:
        LD    HL,(05006H)
L639:
        CALL  writeHL
L640:
        JP    L636
L641:
        ;;test11.j(218)   // constant - var
L642:
        ;;test11.j(219)   // integer - byte
L643:
        ;;test11.j(220)   // not relevant
L644:
        ;;test11.j(221)   // constant - var
L645:
        ;;test11.j(222)   // integer - integer
L646:
        ;;test11.j(223)   b2=38;
L647:
        LD    A,38
L648:
        LD    (05005H),A
L649:
        ;;test11.j(224)   for(int i = 1038; 1037 <= i; i--) { write(b2); b2--; }
L650:
        LD    HL,1038
L651:
        LD    (05006H),HL
L652:
        LD    HL,(05006H)
L653:
        LD    DE,1037
        OR    A
        SBC   HL,DE
L654:
        JP    C,L667
L655:
        JP    L658
L656:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L657:
        JP    L652
L658:
        LD    A,(05005H)
L659:
        CALL  writeA
L660:
        LD    HL,(05005H)
        DEC   (HL)
L661:
        JP    L656
L662:
        ;;test11.j(225) 
L663:
        ;;test11.j(226)   /************************/
L664:
        ;;test11.j(227)   // constant - acc
L665:
        ;;test11.j(228)   // byte - byte
L666:
        ;;test11.j(229)   for (byte b = 36; 136 == b+100; b--) { write (b); }
L667:
        LD    A,36
L668:
        LD    (05006H),A
L669:
        LD    A,(05006H)
L670:
        ADD   A,100
L671:
        SUB   A,136
L672:
        JP    NZ,L680
L673:
        JP    L676
L674:
        LD    HL,(05006H)
        DEC   (HL)
L675:
        JP    L669
L676:
        LD    A,(05006H)
L677:
        CALL  writeA
L678:
        JP    L674
L679:
        ;;test11.j(230)   for (byte b = 35; 132 != b+100; b--) { write (b); }
L680:
        LD    A,35
L681:
        LD    (05006H),A
L682:
        LD    A,(05006H)
L683:
        ADD   A,100
L684:
        SUB   A,132
L685:
        JP    Z,L693
L686:
        JP    L689
L687:
        LD    HL,(05006H)
        DEC   (HL)
L688:
        JP    L682
L689:
        LD    A,(05006H)
L690:
        CALL  writeA
L691:
        JP    L687
L692:
        ;;test11.j(231)   b2=32;
L693:
        LD    A,32
L694:
        LD    (05005H),A
L695:
        ;;test11.j(232)   for (byte b = 32; 134 > b+100; b++) { write (b2); b2--; }
L696:
        LD    A,32
L697:
        LD    (05006H),A
L698:
        LD    A,(05006H)
L699:
        ADD   A,100
L700:
        SUB   A,134
L701:
        JP    NC,L710
L702:
        JP    L705
L703:
        LD    HL,(05006H)
        INC   (HL)
L704:
        JP    L698
L705:
        LD    A,(05005H)
L706:
        CALL  writeA
L707:
        LD    HL,(05005H)
        DEC   (HL)
L708:
        JP    L703
L709:
        ;;test11.j(233)   for (byte b = 34; 135 >= b+100; b++) { write (b2); b2--; }
L710:
        LD    A,34
L711:
        LD    (05006H),A
L712:
        LD    A,(05006H)
L713:
        ADD   A,100
L714:
        SUB   A,135
L715:
        JR    Z,$+5
        JP    C,L724
L716:
        JP    L719
L717:
        LD    HL,(05006H)
        INC   (HL)
L718:
        JP    L712
L719:
        LD    A,(05005H)
L720:
        CALL  writeA
L721:
        LD    HL,(05005H)
        DEC   (HL)
L722:
        JP    L717
L723:
        ;;test11.j(234)   for (byte b = 28; 126 <  b+100; b--) { write (b); }
L724:
        LD    A,28
L725:
        LD    (05006H),A
L726:
        LD    A,(05006H)
L727:
        ADD   A,100
L728:
        SUB   A,126
L729:
        JP    Z,L737
L730:
        JP    L733
L731:
        LD    HL,(05006H)
        DEC   (HL)
L732:
        JP    L726
L733:
        LD    A,(05006H)
L734:
        CALL  writeA
L735:
        JP    L731
L736:
        ;;test11.j(235)   for (byte b = 26; 125 <= b+100; b--) { write (b); }
L737:
        LD    A,26
L738:
        LD    (05006H),A
L739:
        LD    A,(05006H)
L740:
        ADD   A,100
L741:
        SUB   A,125
L742:
        JP    C,L752
L743:
        JP    L746
L744:
        LD    HL,(05006H)
        DEC   (HL)
L745:
        JP    L739
L746:
        LD    A,(05006H)
L747:
        CALL  writeA
L748:
        JP    L744
L749:
        ;;test11.j(236)   // constant - acc
L750:
        ;;test11.j(237)   // byte - integer
L751:
        ;;test11.j(238)   for(int i = 24; 24 == i+0; i--) { write(i); }
L752:
        LD    A,24
L753:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L754:
        LD    HL,(05006H)
L755:
        LD    DE,0
        ADD   HL,DE
L756:
        LD    A,24
L757:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L758:
        JP    NZ,L766
L759:
        JP    L762
L760:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L761:
        JP    L754
L762:
        LD    HL,(05006H)
L763:
        CALL  writeHL
L764:
        JP    L760
L765:
        ;;test11.j(239)   for(int i = 23; 120 != i+100; i--) { write(i); }
L766:
        LD    A,23
L767:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L768:
        LD    HL,(05006H)
L769:
        LD    DE,100
        ADD   HL,DE
L770:
        LD    A,120
L771:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L772:
        JP    Z,L780
L773:
        JP    L776
L774:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L775:
        JP    L768
L776:
        LD    HL,(05006H)
L777:
        CALL  writeHL
L778:
        JP    L774
L779:
        ;;test11.j(240)   b2=20;
L780:
        LD    A,20
L781:
        LD    (05005H),A
L782:
        ;;test11.j(241)   for(int i = 20; 122 > i+100; i++) { write (b2); b2--; }
L783:
        LD    A,20
L784:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L785:
        LD    HL,(05006H)
L786:
        LD    DE,100
        ADD   HL,DE
L787:
        LD    A,122
L788:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L789:
        JP    Z,L798
L790:
        JP    L793
L791:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L792:
        JP    L785
L793:
        LD    A,(05005H)
L794:
        CALL  writeA
L795:
        LD    HL,(05005H)
        DEC   (HL)
L796:
        JP    L791
L797:
        ;;test11.j(242)   for(int i = 22; 123 >= i+100; i++) { write (b2); b2--; }
L798:
        LD    A,22
L799:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L800:
        LD    HL,(05006H)
L801:
        LD    DE,100
        ADD   HL,DE
L802:
        LD    A,123
L803:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L804:
        JP    C,L813
L805:
        JP    L808
L806:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L807:
        JP    L800
L808:
        LD    A,(05005H)
L809:
        CALL  writeA
L810:
        LD    HL,(05005H)
        DEC   (HL)
L811:
        JP    L806
L812:
        ;;test11.j(243)   for(int i = 16; 114 <  i+100; i--) { write(i); }
L813:
        LD    A,16
L814:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L815:
        LD    HL,(05006H)
L816:
        LD    DE,100
        ADD   HL,DE
L817:
        LD    A,114
L818:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L819:
        JP    NC,L827
L820:
        JP    L823
L821:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L822:
        JP    L815
L823:
        LD    HL,(05006H)
L824:
        CALL  writeHL
L825:
        JP    L821
L826:
        ;;test11.j(244)   for(int i = 14; 113 <= i+100; i--) { write(i); }
L827:
        LD    A,14
L828:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L829:
        LD    HL,(05006H)
L830:
        LD    DE,100
        ADD   HL,DE
L831:
        LD    A,113
L832:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L833:
        JR    Z,$+5
        JP    C,L847
L834:
        JP    L837
L835:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L836:
        JP    L829
L837:
        LD    HL,(05006H)
L838:
        CALL  writeHL
L839:
        JP    L835
L840:
        ;;test11.j(245)   // constant - acc
L841:
        ;;test11.j(246)   // integer - byte
L842:
        ;;test11.j(247)   // not relevant
L843:
        ;;test11.j(248) 
L844:
        ;;test11.j(249)   // constant - acc
L845:
        ;;test11.j(250)   // integer - integer
L846:
        ;;test11.j(251)   for(int i = 12; 1012 == i+1000; i--) { write(i); }
L847:
        LD    A,12
L848:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L849:
        LD    HL,(05006H)
L850:
        LD    DE,1000
        ADD   HL,DE
L851:
        LD    DE,1012
        OR    A
        SBC   HL,DE
L852:
        JP    NZ,L860
L853:
        JP    L856
L854:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L855:
        JP    L849
L856:
        LD    HL,(05006H)
L857:
        CALL  writeHL
L858:
        JP    L854
L859:
        ;;test11.j(252)   for(int i = 11; 1008 != i+1000; i--) { write(i); }
L860:
        LD    A,11
L861:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L862:
        LD    HL,(05006H)
L863:
        LD    DE,1000
        ADD   HL,DE
L864:
        LD    DE,1008
        OR    A
        SBC   HL,DE
L865:
        JP    Z,L873
L866:
        JP    L869
L867:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L868:
        JP    L862
L869:
        LD    HL,(05006H)
L870:
        CALL  writeHL
L871:
        JP    L867
L872:
        ;;test11.j(253)   b2=8;
L873:
        LD    A,8
L874:
        LD    (05005H),A
L875:
        ;;test11.j(254)   for(int i = 8; 1010 > i+1000; i++) { write (b2); b2--; }
L876:
        LD    A,8
L877:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L878:
        LD    HL,(05006H)
L879:
        LD    DE,1000
        ADD   HL,DE
L880:
        LD    DE,1010
        OR    A
        SBC   HL,DE
L881:
        JP    NC,L890
L882:
        JP    L885
L883:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L884:
        JP    L878
L885:
        LD    A,(05005H)
L886:
        CALL  writeA
L887:
        LD    HL,(05005H)
        DEC   (HL)
L888:
        JP    L883
L889:
        ;;test11.j(255)   for(int i = 10; 1011 >= i+1000; i++) { write (b2); b2--; }
L890:
        LD    A,10
L891:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L892:
        LD    HL,(05006H)
L893:
        LD    DE,1000
        ADD   HL,DE
L894:
        LD    DE,1011
        OR    A
        SBC   HL,DE
L895:
        JR    Z,$+5
        JP    C,L904
L896:
        JP    L899
L897:
        LD    HL,(05006H)
        INC   HL
        LD    (05006H),HL
L898:
        JP    L892
L899:
        LD    A,(05005H)
L900:
        CALL  writeA
L901:
        LD    HL,(05005H)
        DEC   (HL)
L902:
        JP    L897
L903:
        ;;test11.j(256)   for(int i = 4; 1002 <  i+1000; i--) { write(i); }
L904:
        LD    A,4
L905:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L906:
        LD    HL,(05006H)
L907:
        LD    DE,1000
        ADD   HL,DE
L908:
        LD    DE,1002
        OR    A
        SBC   HL,DE
L909:
        JP    Z,L917
L910:
        JP    L913
L911:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L912:
        JP    L906
L913:
        LD    HL,(05006H)
L914:
        CALL  writeHL
L915:
        JP    L911
L916:
        ;;test11.j(257)   for(int i = 2; 1001 <= i+1000; i--) { write(i); }
L917:
        LD    A,2
L918:
        LD    L,A
        LD    H,0
        LD    (05006H),HL
L919:
        LD    HL,(05006H)
L920:
        LD    DE,1000
        ADD   HL,DE
L921:
        LD    DE,1001
        OR    A
        SBC   HL,DE
L922:
        JP    C,L930
L923:
        JP    L926
L924:
        LD    HL,(05006H)
        DEC   HL
        LD    (05006H),HL
L925:
        JP    L919
L926:
        LD    HL,(05006H)
L927:
        CALL  writeHL
L928:
        JP    L924
L929:
        ;;test11.j(258)   write(0);
L930:
        LD    A,0
L931:
        CALL  writeA
L932:
        ;;test11.j(259) }
L933:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
