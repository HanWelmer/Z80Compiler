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
        ;;test2.j(0) /* Program to test branch instructions */
        ;;test2.j(1) class TestBranches {
        ;;test2.j(2)   int i = 2000;
        LD    HL,2000
        LD    (05000H),HL
        ;;test2.j(3)   int i1 = 1000;
        LD    HL,1000
        LD    (05002H),HL
        ;;test2.j(4)   int i3 = 3000;
        LD    HL,3000
        LD    (05004H),HL
        ;;test2.j(5)   byte b = 20;
        LD    A,20
        LD    (05006H),A
        ;;test2.j(6)   byte b1 = 10;
        LD    A,10
        LD    (05007H),A
        ;;test2.j(7)   byte b3 = 30;
        LD    A,30
        LD    (05008H),A
        ;;test2.j(8)     /*Possible operand types: 
        ;;test2.j(9)      * leftOperand:  constant, acc, var, stack16, stack8
        ;;test2.j(10)      * rightOperand: constant, acc, var, stack16, stack8
        ;;test2.j(11)      *Possible datatype combinations:
        ;;test2.j(12)      * integer - integer
        ;;test2.j(13)      * integer - byte
        ;;test2.j(14)      * byte - integer
        ;;test2.j(15)      * byte - byte
        ;;test2.j(16)     */
        ;;test2.j(17) 
        ;;test2.j(18)   /************************/
        ;;test2.j(19)   // stack16 - constant
        ;;test2.j(20)   // stack16 - acc
        ;;test2.j(21)   // stack16 - var
        ;;test2.j(22)   // stack16 - stack16
        ;;test2.j(23)   // stack16 - stack8
        ;;test2.j(24) 
        ;;test2.j(25)   /************************/
        ;;test2.j(26)   // stack8 - constant
        ;;test2.j(27)   // stack8 - acc
        ;;test2.j(28)   // stack8 - var
        ;;test2.j(29)   // stack8 - stack16
        ;;test2.j(30)   // stack8 - stack8
        ;;test2.j(31) 
        ;;test2.j(32)   /************************/
        ;;test2.j(33)   // var - stack8
        ;;test2.j(34)   // integer - integer
        ;;test2.j(35) 
        ;;test2.j(36)   // var - stack8
        ;;test2.j(37)   // integer - byte 
        ;;test2.j(38) 
        ;;test2.j(39)   // var - stack8
        ;;test2.j(40)   // byte - integer
        ;;test2.j(41) 
        ;;test2.j(42)   // var - stack8
        ;;test2.j(43)   // byte - byte
        ;;test2.j(44) 
        ;;test2.j(45)   /************************/
        ;;test2.j(46)   // var - stack16
        ;;test2.j(47)   // integer - integer
        ;;test2.j(48) 
        ;;test2.j(49)   // var - stack16
        ;;test2.j(50)   // integer - byte
        ;;test2.j(51) 
        ;;test2.j(52)   // var - stack16
        ;;test2.j(53)   // byte - integer
        ;;test2.j(54) 
        ;;test2.j(55)   // var - stack16
        ;;test2.j(56)   // byte - byte
        ;;test2.j(57) 
        ;;test2.j(58)   /************************/
        ;;test2.j(59)   // var - var
        ;;test2.j(60)   // integer - integer
        ;;test2.j(61)   write(159);
        LD    A,159
        CALL  writeA
        ;;test2.j(62)   write(158);
        LD    A,158
        CALL  writeA
        ;;test2.j(63)   if (i > i1) write(157);
        LD    HL,(05000H)
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
        JP    Z,L86
        LD    A,157
        CALL  writeA
        ;;test2.j(64)   if (i < i3) write(156);
        LD    HL,(05000H)
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
        JP    NC,L94
        LD    A,156
        CALL  writeA
        ;;test2.j(65)   // var - var
        ;;test2.j(66)   // integer - byte
        ;;test2.j(67)   if (i > i1) write(155);
        LD    HL,(05000H)
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
        JP    Z,L100
        LD    A,155
        CALL  writeA
        ;;test2.j(68)   if (i < i3) write(154);
        LD    HL,(05000H)
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
        JP    NC,L108
        LD    A,154
        CALL  writeA
        ;;test2.j(69)   // var - var
        ;;test2.j(70)   // byte - integer
        ;;test2.j(71)   if (b > i1) write(999); else write(153);
        LD    A,(05006H)
        LD    HL,(05002H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L115
        LD    HL,999
        CALL  writeHL
        JP    L118
        LD    A,153
        CALL  writeA
        ;;test2.j(72)   if (b < i3) write(152);
        LD    A,(05006H)
        LD    HL,(05004H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L127
        LD    A,152
        CALL  writeA
        ;;test2.j(73)   // var - var
        ;;test2.j(74)   // byte - byte
        ;;test2.j(75)   if (b > b1) write(151);
        LD    A,(05006H)
        LD    B,A
        LD    A,(05007H)
        SUB   A,B
        JP    Z,L133
        LD    A,151
        CALL  writeA
        ;;test2.j(76)   if (b < b3) write(150);
        LD    A,(05006H)
        LD    B,A
        LD    A,(05008H)
        SUB   A,B
        JP    NC,L143
        LD    A,150
        CALL  writeA
        ;;test2.j(77) 
        ;;test2.j(78)   /************************/
        ;;test2.j(79)   // var - acc
        ;;test2.j(80)   // integer - integer
        ;;test2.j(81)   write(149);
        LD    A,149
        CALL  writeA
        ;;test2.j(82)   write(148);
        LD    A,148
        CALL  writeA
        ;;test2.j(83)   if (i > 1000+0) write(147);
        LD    HL,(05000H)
        PUSH HL
        LD    HL,1000
        LD    DE,0
        ADD   HL,DE
        POP   DE
        OR    A
        SBC   HL,DE
        JP    NC,L158
        LD    A,147
        CALL  writeA
        ;;test2.j(84)   if (i < 3000+0) write(146);
        LD    HL,(05000H)
        PUSH HL
        LD    HL,3000
        LD    DE,0
        ADD   HL,DE
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,L169
        LD    A,146
        CALL  writeA
        ;;test2.j(85)   // var - acc
        ;;test2.j(86)   // integer - byte
        ;;test2.j(87)   if (i > 1000+0) write(145);
        LD    HL,(05000H)
        PUSH HL
        LD    HL,1000
        LD    DE,0
        ADD   HL,DE
        POP   DE
        OR    A
        SBC   HL,DE
        JP    NC,L178
        LD    A,145
        CALL  writeA
        ;;test2.j(88)   if (i < 3000+0) write(144);
        LD    HL,(05000H)
        PUSH HL
        LD    HL,3000
        LD    DE,0
        ADD   HL,DE
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,L189
        LD    A,144
        CALL  writeA
        ;;test2.j(89)   // var - acc
        ;;test2.j(90)   // byte - integer
        ;;test2.j(91)   if (b > 1000+0) write(999); else write(143);
        LD    A,(05006H)
        PUSH AF
        LD    HL,1000
        LD    DE,0
        ADD   HL,DE
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L199
        LD    HL,999
        CALL  writeHL
        JP    L202
        LD    A,143
        CALL  writeA
        ;;test2.j(92)   if (b < 1000+0) write(142);
        LD    A,(05006H)
        PUSH AF
        LD    HL,1000
        LD    DE,0
        ADD   HL,DE
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L214
        LD    A,142
        CALL  writeA
        ;;test2.j(93)   // var - acc
        ;;test2.j(94)   // byte - byte
        ;;test2.j(95)   if (b > 10+0) write(141);
        LD    A,(05006H)
        PUSH AF
        LD    A,10
        ADD   A,0
        POP   BC
        SUB   A,B
        JP    NC,L223
        LD    A,141
        CALL  writeA
        ;;test2.j(96)   if (b < 30+0) write(140);
        LD    A,(05006H)
        PUSH AF
        LD    A,30
        ADD   A,0
        POP   BC
        SUB   A,B
        JP    Z,L236
        LD    A,140
        CALL  writeA
        ;;test2.j(97) 
        ;;test2.j(98)   /************************/
        ;;test2.j(99)   // var - constant
        ;;test2.j(100)   // integer - integer
        ;;test2.j(101)   write(139);
        LD    A,139
        CALL  writeA
        ;;test2.j(102)   write(138);
        LD    A,138
        CALL  writeA
        ;;test2.j(103)   if (i > 1000) write(137);
        LD    HL,(05000H)
        LD    DE,1000
        OR    A
        SBC   HL,DE
        JP    Z,L248
        LD    A,137
        CALL  writeA
        ;;test2.j(104)   if (i < 3000) write(136);
        LD    HL,(05000H)
        LD    DE,3000
        OR    A
        SBC   HL,DE
        JP    NC,L256
        LD    A,136
        CALL  writeA
        ;;test2.j(105)   // var - constant
        ;;test2.j(106)   // integer - byte
        ;;test2.j(107)   if (i > 1000) write(135);
        LD    HL,(05000H)
        LD    DE,1000
        OR    A
        SBC   HL,DE
        JP    Z,L262
        LD    A,135
        CALL  writeA
        ;;test2.j(108)   if (i < 3000) write(134);
        LD    HL,(05000H)
        LD    DE,3000
        OR    A
        SBC   HL,DE
        JP    NC,L270
        LD    A,134
        CALL  writeA
        ;;test2.j(109)   // var - constant
        ;;test2.j(110)   // byte - integer
        ;;test2.j(111)   if (b > 1000) write(999); else write(133);
        LD    A,(05006H)
        LD    HL,1000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L277
        LD    HL,999
        CALL  writeHL
        JP    L280
        LD    A,133
        CALL  writeA
        ;;test2.j(112)   if (b < 1000) write(132);
        LD    A,(05006H)
        LD    HL,1000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L289
        LD    A,132
        CALL  writeA
        ;;test2.j(113)   // var - constant
        ;;test2.j(114)   // byte - byte
        ;;test2.j(115)   if (b > 10) write(131);
        LD    A,(05006H)
        SUB   A,10
        JP    Z,L295
        LD    A,131
        CALL  writeA
        ;;test2.j(116)   if (b < 30) write(130);
        LD    A,(05006H)
        SUB   A,30
        JP    NC,L305
        LD    A,130
        CALL  writeA
        ;;test2.j(117) 
        ;;test2.j(118)   /************************/
        ;;test2.j(119)   // acc - stack8
        ;;test2.j(120)   // integer - integer
        ;;test2.j(121)   write(129);
        LD    A,129
        CALL  writeA
        ;;test2.j(122)   write(128);
        LD    A,128
        CALL  writeA
        ;;test2.j(123)   write(127);
        LD    A,127
        CALL  writeA
        ;;test2.j(124)   write(126);
        LD    A,126
        CALL  writeA
        ;;test2.j(125)   // acc - stack8
        ;;test2.j(126)   // integer - byte
        ;;test2.j(127)   write(125);
        LD    A,125
        CALL  writeA
        ;;test2.j(128)   write(124);
        LD    A,124
        CALL  writeA
        ;;test2.j(129)   // acc - stack8
        ;;test2.j(130)   // byte - integer
        ;;test2.j(131)   write(123);
        LD    A,123
        CALL  writeA
        ;;test2.j(132)   write(122);
        LD    A,122
        CALL  writeA
        ;;test2.j(133)   // acc - stack8
        ;;test2.j(134)   // byte - byte
        ;;test2.j(135)   write(121);
        LD    A,121
        CALL  writeA
        ;;test2.j(136)   write(120);
        LD    A,120
        CALL  writeA
        ;;test2.j(137) 
        ;;test2.j(138)   /************************/
        ;;test2.j(139)   // acc - stack16
        ;;test2.j(140)   // integer - integer
        ;;test2.j(141)   write(119);
        LD    A,119
        CALL  writeA
        ;;test2.j(142)   write(118);
        LD    A,118
        CALL  writeA
        ;;test2.j(143)   write(117);
        LD    A,117
        CALL  writeA
        ;;test2.j(144)   write(116);
        LD    A,116
        CALL  writeA
        ;;test2.j(145)   // acc - stack16
        ;;test2.j(146)   // integer - byte
        ;;test2.j(147)   write(115);
        LD    A,115
        CALL  writeA
        ;;test2.j(148)   write(114);
        LD    A,114
        CALL  writeA
        ;;test2.j(149)   // acc - stack16
        ;;test2.j(150)   // byte - integer
        ;;test2.j(151)   write(113);
        LD    A,113
        CALL  writeA
        ;;test2.j(152)   write(112);
        LD    A,112
        CALL  writeA
        ;;test2.j(153)   // acc - stack16
        ;;test2.j(154)   // byte - byte
        ;;test2.j(155)   write(111);
        LD    A,111
        CALL  writeA
        ;;test2.j(156)   write(110);
        LD    A,110
        CALL  writeA
        ;;test2.j(157) 
        ;;test2.j(158)   /************************/
        ;;test2.j(159)   // acc - var
        ;;test2.j(160)   // integer - integer
        ;;test2.j(161)   write(109);
        LD    A,109
        CALL  writeA
        ;;test2.j(162)   write(108);
        LD    A,108
        CALL  writeA
        ;;test2.j(163)   if (3000+0 > i) write(107);
        LD    HL,3000
        LD    DE,0
        ADD   HL,DE
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
        JP    Z,L398
        LD    A,107
        CALL  writeA
        ;;test2.j(164)   if (1000+0 < i) write(106);
        LD    HL,1000
        LD    DE,0
        ADD   HL,DE
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
        JP    NC,L407
        LD    A,106
        CALL  writeA
        ;;test2.j(165)   // acc - var
        ;;test2.j(166)   // integer - byte
        ;;test2.j(167)   if (3000+0 > b) write(105);
        LD    HL,3000
        LD    DE,0
        ADD   HL,DE
        LD    A,(05006H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L415
        LD    A,105
        CALL  writeA
        ;;test2.j(168)   if (1000+0 < b) write(999); else write(104);
        LD    HL,1000
        LD    DE,0
        ADD   HL,DE
        LD    A,(05006H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NC,L423
        LD    HL,999
        CALL  writeHL
        JP    L428
        LD    A,104
        CALL  writeA
        ;;test2.j(169)   // acc - var
        ;;test2.j(170)   // byte - integer
        ;;test2.j(171)   if (30+0 > i) write(999); else write(103);
        LD    A,30
        ADD   A,0
        LD    HL,(05000H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L436
        LD    HL,999
        CALL  writeHL
        JP    L439
        LD    A,103
        CALL  writeA
        ;;test2.j(172)   if (10+0 < i) write(102);
        LD    A,10
        ADD   A,0
        LD    HL,(05000H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L449
        LD    A,102
        CALL  writeA
        ;;test2.j(173)   // acc - var
        ;;test2.j(174)   // byte - byte
        ;;test2.j(175)   if (30+0 > b) write(101);
        LD    A,30
        ADD   A,0
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
        JP    Z,L456
        LD    A,101
        CALL  writeA
        ;;test2.j(176)   if (10+0 < b) write(100);
        LD    A,10
        ADD   A,0
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
        JP    NC,L467
        LD    A,100
        CALL  writeA
        ;;test2.j(177) 
        ;;test2.j(178)   /************************/
        ;;test2.j(179)   // acc - acc
        ;;test2.j(180)   // integer - integer
        ;;test2.j(181)   write(99);
        LD    A,99
        CALL  writeA
        ;;test2.j(182)   write(98);
        LD    A,98
        CALL  writeA
        ;;test2.j(183)   if (3000+0 > 2000+0) write(97);
        LD    HL,3000
        LD    DE,0
        ADD   HL,DE
        PUSH HL
        LD    HL,2000
        LD    DE,0
        ADD   HL,DE
        POP   DE
        OR    A
        SBC   HL,DE
        JP    NC,L483
        LD    A,97
        CALL  writeA
        ;;test2.j(184)   if (1000+0 < 2000+0) write(96);
        LD    HL,1000
        LD    DE,0
        ADD   HL,DE
        PUSH HL
        LD    HL,2000
        LD    DE,0
        ADD   HL,DE
        POP   DE
        OR    A
        SBC   HL,DE
        JP    Z,L495
        LD    A,96
        CALL  writeA
        ;;test2.j(185)   // acc - acc
        ;;test2.j(186)   // integer - byte
        ;;test2.j(187)   if (3000+0 > 20+0) write(95);
        LD    HL,3000
        LD    DE,0
        ADD   HL,DE
        PUSH HL
        LD    A,20
        ADD   A,0
        POP  HL
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L506
        LD    A,95
        CALL  writeA
        ;;test2.j(188)   if (1000+0 < 20+0) write(999); else write(94);
        LD    HL,1000
        LD    DE,0
        ADD   HL,DE
        PUSH HL
        LD    A,20
        ADD   A,0
        POP  HL
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NC,L517
        LD    HL,999
        CALL  writeHL
        JP    L522
        LD    A,94
        CALL  writeA
        ;;test2.j(189)   // acc - acc
        ;;test2.j(190)   // byte - integer
        ;;test2.j(191)   if (30+0 > 2000+0) write(999); else write(93);
        LD    A,30
        ADD   A,0
        PUSH AF
        LD    HL,2000
        LD    DE,0
        ADD   HL,DE
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L533
        LD    HL,999
        CALL  writeHL
        JP    L536
        LD    A,93
        CALL  writeA
        ;;test2.j(192)   if (10+0 < 2000+0) write(92);
        LD    A,10
        ADD   A,0
        PUSH AF
        LD    HL,2000
        LD    DE,0
        ADD   HL,DE
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L549
        LD    A,92
        CALL  writeA
        ;;test2.j(193)   // acc - acc
        ;;test2.j(194)   // byte - byte
        ;;test2.j(195)   if (30+0 > 20+0) write(91);
        LD    A,30
        ADD   A,0
        PUSH AF
        LD    A,20
        ADD   A,0
        POP   BC
        SUB   A,B
        JP    NC,L559
        LD    A,91
        CALL  writeA
        ;;test2.j(196)   if (10+0 < 20+0) write(90);
        LD    A,10
        ADD   A,0
        PUSH AF
        LD    A,20
        ADD   A,0
        POP   BC
        SUB   A,B
        JP    Z,L573
        LD    A,90
        CALL  writeA
        ;;test2.j(197) 
        ;;test2.j(198)   /************************/
        ;;test2.j(199)   // acc - constant
        ;;test2.j(200)   // integer - integer
        ;;test2.j(201)   write(89);
        LD    A,89
        CALL  writeA
        ;;test2.j(202)   write(88);
        LD    A,88
        CALL  writeA
        ;;test2.j(203)   if (3000+0 > 2000) write(87);
        LD    HL,3000
        LD    DE,0
        ADD   HL,DE
        LD    DE,2000
        OR    A
        SBC   HL,DE
        JP    Z,L586
        LD    A,87
        CALL  writeA
        ;;test2.j(204)   if (1000+0 < 2000) write(86);
        LD    HL,1000
        LD    DE,0
        ADD   HL,DE
        LD    DE,2000
        OR    A
        SBC   HL,DE
        JP    NC,L595
        LD    A,86
        CALL  writeA
        ;;test2.j(205)   // acc - constant
        ;;test2.j(206)   // integer - byte
        ;;test2.j(207)   if (3000+0 > 20) write(85);
        LD    HL,3000
        LD    DE,0
        ADD   HL,DE
        LD    A,20
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L603
        LD    A,85
        CALL  writeA
        ;;test2.j(208)   if (1000+0 < 20) write(999); else write(84);
        LD    HL,1000
        LD    DE,0
        ADD   HL,DE
        LD    A,20
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NC,L611
        LD    HL,999
        CALL  writeHL
        JP    L616
        LD    A,84
        CALL  writeA
        ;;test2.j(209)   // acc - constant
        ;;test2.j(210)   // byte - integer
        ;;test2.j(211)   if (30+0 > 2000) write(999); else write(83);
        LD    A,30
        ADD   A,0
        LD    HL,2000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L624
        LD    HL,999
        CALL  writeHL
        JP    L627
        LD    A,83
        CALL  writeA
        ;;test2.j(212)   if (10+0 < 2000) write(82);
        LD    A,10
        ADD   A,0
        LD    HL,2000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L637
        LD    A,82
        CALL  writeA
        ;;test2.j(213)   // acc - constant
        ;;test2.j(214)   // byte - byte
        ;;test2.j(215)   if (30+0 > 20) write(81);
        LD    A,30
        ADD   A,0
        SUB   A,20
        JP    Z,L644
        LD    A,81
        CALL  writeA
        ;;test2.j(216)   if (10+0 < 20) write(80);
        LD    A,10
        ADD   A,0
        SUB   A,20
        JP    NC,L655
        LD    A,80
        CALL  writeA
        ;;test2.j(217) 
        ;;test2.j(218)   /************************/
        ;;test2.j(219)   // constant - stack8
        ;;test2.j(220)   // byte - byte
        ;;test2.j(221)   write(79);
        LD    A,79
        CALL  writeA
        ;;test2.j(222)   write(78);
        LD    A,78
        CALL  writeA
        ;;test2.j(223)   write(77);
        LD    A,77
        CALL  writeA
        ;;test2.j(224)   write(76);
        LD    A,76
        CALL  writeA
        ;;test2.j(225)   // constant - stack8
        ;;test2.j(226)   // byte - integer
        ;;test2.j(227)   write(75);
        LD    A,75
        CALL  writeA
        ;;test2.j(228)   write(74);
        LD    A,74
        CALL  writeA
        ;;test2.j(229)   // constant - stack8
        ;;test2.j(230)   // integer - byte
        ;;test2.j(231)   write(73);
        LD    A,73
        CALL  writeA
        ;;test2.j(232)   write(72);
        LD    A,72
        CALL  writeA
        ;;test2.j(233)   // constant - stack8
        ;;test2.j(234)   // integer - integer
        ;;test2.j(235)   write(71);
        LD    A,71
        CALL  writeA
        ;;test2.j(236)   write(70);
        LD    A,70
        CALL  writeA
        ;;test2.j(237) 
        ;;test2.j(238) 
        ;;test2.j(239)   /************************/
        ;;test2.j(240)   // constant - stack16
        ;;test2.j(241)   // byte - byte
        ;;test2.j(242)   write(69);
        LD    A,69
        CALL  writeA
        ;;test2.j(243)   write(68);
        LD    A,68
        CALL  writeA
        ;;test2.j(244)   write(67);
        LD    A,67
        CALL  writeA
        ;;test2.j(245)   write(66);
        LD    A,66
        CALL  writeA
        ;;test2.j(246)   // constant - stack16
        ;;test2.j(247)   // byte - integer
        ;;test2.j(248)   write(65);
        LD    A,65
        CALL  writeA
        ;;test2.j(249)   write(64);
        LD    A,64
        CALL  writeA
        ;;test2.j(250)   // constant - stack16
        ;;test2.j(251)   // integer - byte
        ;;test2.j(252)   write(63);
        LD    A,63
        CALL  writeA
        ;;test2.j(253)   write(62);
        LD    A,62
        CALL  writeA
        ;;test2.j(254)   // constant - stack16
        ;;test2.j(255)   // integer - integer
        ;;test2.j(256)   write(61);
        LD    A,61
        CALL  writeA
        ;;test2.j(257)   write(60);
        LD    A,60
        CALL  writeA
        ;;test2.j(258) 
        ;;test2.j(259) 
        ;;test2.j(260)   /************************/
        ;;test2.j(261)   // constant - var
        ;;test2.j(262)   // byte - byte
        ;;test2.j(263)   write(59);
        LD    A,59
        CALL  writeA
        ;;test2.j(264)   write(58);
        LD    A,58
        CALL  writeA
        ;;test2.j(265)   if (30 > b) write(57);
        LD    A,(05006H)
        SUB   A,30
        JP    NC,L749
        LD    A,57
        CALL  writeA
        ;;test2.j(266)   if (10 < b) write(56);
        LD    A,(05006H)
        SUB   A,10
        JP    Z,L757
        LD    A,56
        CALL  writeA
        ;;test2.j(267)   // constant - var
        ;;test2.j(268)   // byte - integer
        ;;test2.j(269)   if (30 > i) write(999); else write(55);
        LD    HL,(05000H)
        LD    A,30
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L764
        LD    HL,999
        CALL  writeHL
        JP    L767
        LD    A,55
        CALL  writeA
        ;;test2.j(270)   if (10 < i) write(54);
        LD    HL,(05000H)
        LD    A,10
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L776
        LD    A,54
        CALL  writeA
        ;;test2.j(271)   // constant - var
        ;;test2.j(272)   // integer - byte
        ;;test2.j(273)   if (3000 > b) write(53);
        LD    A,(05006H)
        LD    HL,3000
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L783
        LD    A,53
        CALL  writeA
        ;;test2.j(274)   if (1000 < b) write(999); else write(52);
        LD    A,(05006H)
        LD    HL,1000
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NC,L790
        LD    HL,999
        CALL  writeHL
        JP    L795
        LD    A,52
        CALL  writeA
        ;;test2.j(275)   // constant - var
        ;;test2.j(276)   // integer - integer
        ;;test2.j(277)   if (3000 > i) write(51);
        LD    HL,(05000H)
        LD    DE,3000
        OR    A
        SBC   HL,DE
        JP    NC,L801
        LD    A,51
        CALL  writeA
        ;;test2.j(278)   if (1000 < i) write(50);
        LD    HL,(05000H)
        LD    DE,1000
        OR    A
        SBC   HL,DE
        JP    Z,L811
        LD    A,50
        CALL  writeA
        ;;test2.j(279) 
        ;;test2.j(280)   /************************/
        ;;test2.j(281)   // constant - acc
        ;;test2.j(282)   // byte - byte
        ;;test2.j(283)   write(49);
        LD    A,49
        CALL  writeA
        ;;test2.j(284)   write(48);
        LD    A,48
        CALL  writeA
        ;;test2.j(285)   if (1 > 0+0) write(47);
        LD    A,0
        ADD   A,0
        SUB   A,1
        JP    NC,L824
        LD    A,47
        CALL  writeA
        ;;test2.j(286)   if (1 < 2+0) write(46);
        LD    A,2
        ADD   A,0
        SUB   A,1
        JP    Z,L833
        LD    A,46
        CALL  writeA
        ;;test2.j(287)   // constant - acc
        ;;test2.j(288)   // byte - integer
        ;;test2.j(289)   if (1 > 1000+0) write(999); else write(45);
        LD    HL,1000
        LD    DE,0
        ADD   HL,DE
        LD    A,1
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L841
        LD    HL,999
        CALL  writeHL
        JP    L844
        LD    A,45
        CALL  writeA
        ;;test2.j(290)   if (1 < 1000+0) write(44);
        LD    HL,1000
        LD    DE,0
        ADD   HL,DE
        LD    A,1
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L854
        LD    A,44
        CALL  writeA
        ;;test2.j(291)   // constant - acc
        ;;test2.j(292)   // integer - byte
        ;;test2.j(293)   if (1000 > 0+0) write(43);
        LD    A,0
        ADD   A,0
        LD    HL,1000
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L862
        LD    A,43
        CALL  writeA
        ;;test2.j(294)   if (1000 < 0+0) write(999); else write(42);
        LD    A,0
        ADD   A,0
        LD    HL,1000
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NC,L870
        LD    HL,999
        CALL  writeHL
        JP    L875
        LD    A,42
        CALL  writeA
        ;;test2.j(295)   // constant - acc
        ;;test2.j(296)   // integer - integer
        ;;test2.j(297)   if (2000 > 1000+0) write(41);
        LD    HL,1000
        LD    DE,0
        ADD   HL,DE
        LD    DE,2000
        OR    A
        SBC   HL,DE
        JP    NC,L882
        LD    A,41
        CALL  writeA
        ;;test2.j(298)   if (1000 < 2000+0) write(40);
        LD    HL,2000
        LD    DE,0
        ADD   HL,DE
        LD    DE,1000
        OR    A
        SBC   HL,DE
        JP    Z,L893
        LD    A,40
        CALL  writeA
        ;;test2.j(299) 
        ;;test2.j(300)   /************************/
        ;;test2.j(301)   // constant - constant
        ;;test2.j(302)   // byte - byte
        ;;test2.j(303)   write(39);
        LD    A,39
        CALL  writeA
        ;;test2.j(304)   if (1 == 1) write(38);
        LD    A,1
        SUB   A,1
        JP    NZ,L902
        LD    A,38
        CALL  writeA
        ;;test2.j(305)   if (1 != 0) write(37);
        LD    A,1
        SUB   A,0
        JP    Z,L908
        LD    A,37
        CALL  writeA
        ;;test2.j(306)   if (1 > 0) write(36);
        LD    A,1
        SUB   A,0
        JP    Z,L914
        LD    A,36
        CALL  writeA
        ;;test2.j(307)   if (1 >= 0) write(35);
        LD    A,1
        SUB   A,0
        JP    C,L920
        LD    A,35
        CALL  writeA
        ;;test2.j(308)   if (1 >= 1) write(34);
        LD    A,1
        SUB   A,1
        JP    C,L926
        LD    A,34
        CALL  writeA
        ;;test2.j(309)   if (1 < 2) write(33);
        LD    A,1
        SUB   A,2
        JP    NC,L932
        LD    A,33
        CALL  writeA
        ;;test2.j(310)   if (1 <= 2) write(32);
        LD    A,1
        SUB   A,2
        JP    Z,$+5
        JP    C,L938
        LD    A,32
        CALL  writeA
        ;;test2.j(311)   if (1 <= 1) write(31);
        LD    A,1
        SUB   A,1
        JP    Z,$+5
        JP    C,L944
        LD    A,31
        CALL  writeA
        ;;test2.j(312)   write(30);
        LD    A,30
        CALL  writeA
        ;;test2.j(313)   // constant - constant
        ;;test2.j(314)   // byte - integer
        ;;test2.j(315)   write(29);
        LD    A,29
        CALL  writeA
        ;;test2.j(316)   if (1 == 1000) write(999); else write(28);
        LD    A,1
        LD    HL,1000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NZ,L959
        LD    HL,999
        CALL  writeHL
        JP    L962
        LD    A,28
        CALL  writeA
        ;;test2.j(317)   if (1 != 1000) write(27);
        LD    A,1
        LD    HL,1000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L969
        LD    A,27
        CALL  writeA
        ;;test2.j(318)   if (1 > 1000) write(999); else write(26);
        LD    A,1
        LD    HL,1000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L976
        LD    HL,999
        CALL  writeHL
        JP    L979
        LD    A,26
        CALL  writeA
        ;;test2.j(319)   if (1 >= 1000) write(999); write(25);
        LD    A,1
        LD    HL,1000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L985
        LD    HL,999
        CALL  writeHL
        LD    A,25
        CALL  writeA
        ;;test2.j(320)   if (1 >= 1000) write(999); write(24);
        LD    A,1
        LD    HL,1000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L994
        LD    HL,999
        CALL  writeHL
        LD    A,24
        CALL  writeA
        ;;test2.j(321)   if (1 < 2000) write(23);
        LD    A,1
        LD    HL,2000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L1004
        LD    A,23
        CALL  writeA
        ;;test2.j(322)   if (1 <= 2000) write(22);
        LD    A,1
        LD    HL,2000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1011
        LD    A,22
        CALL  writeA
        ;;test2.j(323)   if (1 <= 1000) write(21);
        LD    A,1
        LD    HL,1000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1018
        LD    A,21
        CALL  writeA
        ;;test2.j(324)   write(20);
        LD    A,20
        CALL  writeA
        ;;test2.j(325)   // constant - constant
        ;;test2.j(326)   // integer - byte
        ;;test2.j(327)   write(19);
        LD    A,19
        CALL  writeA
        ;;test2.j(328)   if (1000 == 1) { write(999); } else { write(18); }
        LD    HL,1000
        LD    A,1
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    NZ,L1033
        LD    HL,999
        CALL  writeHL
        JP    L1036
        LD    A,18
        CALL  writeA
        ;;test2.j(329)   if (1000 != 0) write(17);
        LD    HL,1000
        LD    A,0
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L1043
        LD    A,17
        CALL  writeA
        ;;test2.j(330)   if (1000 > 0) write(16);
        LD    HL,1000
        LD    A,0
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L1050
        LD    A,16
        CALL  writeA
        ;;test2.j(331)   if (1000 >= 0) write(15);
        LD    HL,1000
        LD    A,0
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    C,L1057
        LD    A,15
        CALL  writeA
        ;;test2.j(332)   if (1000 >= 1) write(14);
        LD    HL,1000
        LD    A,1
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    C,L1064
        LD    A,14
        CALL  writeA
        ;;test2.j(333)   if (1 < 2000) write(13);
        LD    A,1
        LD    HL,2000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L1071
        LD    A,13
        CALL  writeA
        ;;test2.j(334)   if (1 <= 2000) write(12);
        LD    A,1
        LD    HL,2000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1078
        LD    A,12
        CALL  writeA
        ;;test2.j(335)   if (1 <= 1000) write(11);
        LD    A,1
        LD    HL,1000
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1085
        LD    A,11
        CALL  writeA
        ;;test2.j(336)   write(10);
        LD    A,10
        CALL  writeA
        ;;test2.j(337)   // constant - constant
        ;;test2.j(338)   // integer - integer
        ;;test2.j(339)   write(9);
        LD    A,9
        CALL  writeA
        ;;test2.j(340)   if (1000 == 1000) write(8);
        LD    HL,1000
        LD    DE,1000
        OR    A
        SBC   HL,DE
        JP    NZ,L1099
        LD    A,8
        CALL  writeA
        ;;test2.j(341)   if (1000 != 2000) write(7);
        LD    HL,1000
        LD    DE,2000
        OR    A
        SBC   HL,DE
        JP    Z,L1105
        LD    A,7
        CALL  writeA
        ;;test2.j(342)   if (2000 > 1000) write(6);
        LD    HL,2000
        LD    DE,1000
        OR    A
        SBC   HL,DE
        JP    Z,L1111
        LD    A,6
        CALL  writeA
        ;;test2.j(343)   if (2000 >= 1000) write(5);
        LD    HL,2000
        LD    DE,1000
        OR    A
        SBC   HL,DE
        JP    C,L1117
        LD    A,5
        CALL  writeA
        ;;test2.j(344)   if (1000 >= 1000) write(4);
        LD    HL,1000
        LD    DE,1000
        OR    A
        SBC   HL,DE
        JP    C,L1123
        LD    A,4
        CALL  writeA
        ;;test2.j(345)   if (1000 < 2000) write(3);
        LD    HL,1000
        LD    DE,2000
        OR    A
        SBC   HL,DE
        JP    NC,L1129
        LD    A,3
        CALL  writeA
        ;;test2.j(346)   if (1000 <= 2000) write(2);
        LD    HL,1000
        LD    DE,2000
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1135
        LD    A,2
        CALL  writeA
        ;;test2.j(347)   if (1000 <= 1000) write(1);
        LD    HL,1000
        LD    DE,1000
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L1142
        LD    A,1
        CALL  writeA
        ;;test2.j(348) 
        ;;test2.j(349)   write(0);
        LD    A,0
        CALL  writeA
        ;;test2.j(350) }
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
