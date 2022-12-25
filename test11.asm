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
        ;;test11.j(2)   int i2 = 105;
        LD    A,105
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test11.j(3)   int p = 12;
        LD    A,12
        LD    L,A
        LD    H,0
        LD    (05002H),HL
        ;;test11.j(4)   byte b2 = 111;
        LD    A,111
        LD    (05004H),A
        ;;test11.j(5) 
        ;;test11.j(6)   /************************/
        ;;test11.j(7)   // stack8 - constant
        ;;test11.j(8)   // stack8 - acc
        ;;test11.j(9)   // stack8 - var
        ;;test11.j(10)   // stack8 - stack8
        ;;test11.j(11)   // stack8 - stack16
        ;;test11.j(12)   //TODO
        ;;test11.j(13) 
        ;;test11.j(14)   /************************/
        ;;test11.j(15)   // stack16 - constant
        ;;test11.j(16)   // stack16 - acc
        ;;test11.j(17)   // stack16 - var
        ;;test11.j(18)   // stack16 - stack8
        ;;test11.j(19)   // stack16 - stack16
        ;;test11.j(20)   //TODO
        ;;test11.j(21) 
        ;;test11.j(22)   /************************/
        ;;test11.j(23)   // var - stack16
        ;;test11.j(24)   // byte - byte
        ;;test11.j(25)   // byte - integer
        ;;test11.j(26)   // integer - byte
        ;;test11.j(27)   // integer - integer
        ;;test11.j(28)   //TODO
        ;;test11.j(29) 
        ;;test11.j(30)   /************************/
        ;;test11.j(31)   // var - stack8
        ;;test11.j(32)   // byte - byte
        ;;test11.j(33)   // byte - integer
        ;;test11.j(34)   // integer - byte
        ;;test11.j(35)   // integer - integer
        ;;test11.j(36)   //TODO
        ;;test11.j(37) 
        ;;test11.j(38)   /************************/
        ;;test11.j(39)   // var - var
        ;;test11.j(40)   // byte - byte
        ;;test11.j(41)   b2 = 111;
        LD    A,111
        LD    (05004H),A
        ;;test11.j(42)   for (byte b = 112; b2 <= b; b--) { write (b); }
        LD    A,112
        LD    (05005H),A
        LD    A,(05004H)
        LD    B,A
        LD    A,(05005H)
        SUB   A,B
        JP    Z,$+5
        JP    C,L64
        JP    L59
        LD    HL,(05005H)
        DEC   (HL)
        JP    L53
        LD    A,(05005H)
        CALL  writeA
        JP    L57
        ;;test11.j(43)   // byte - integer
        ;;test11.j(44)   b2 = 109;
        LD    A,109
        LD    (05004H),A
        ;;test11.j(45)   for(int i = 110; b2 <= i; i--) { write(i); }
        LD    A,110
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    A,(05004H)
        LD    HL,(05005H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L81
        JP    L76
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L69
        LD    HL,(05005H)
        CALL  writeHL
        JP    L74
        ;;test11.j(46)   // integer - byte
        ;;test11.j(47)   i2=107;
        LD    A,107
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test11.j(48)   for (byte b = 108; i2 <= b; b--) { write (b); }
        LD    A,108
        LD    (05005H),A
        LD    HL,(05000H)
        LD    A,(05005H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L98
        JP    L93
        LD    HL,(05005H)
        DEC   (HL)
        JP    L86
        LD    A,(05005H)
        CALL  writeA
        JP    L91
        ;;test11.j(49)   // integer - integer
        ;;test11.j(50)   i2=105;
        LD    A,105
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test11.j(51)   for(int i = 106; i2 <= i; i--) { write(i); }
        LD    A,106
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05000H)
        LD    DE,(05005H)
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L117
        JP    L109
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L103
        LD    HL,(05005H)
        CALL  writeHL
        JP    L107
        ;;test11.j(52) 
        ;;test11.j(53)   /************************/
        ;;test11.j(54)   // var - acc
        ;;test11.j(55)   // byte - byte
        ;;test11.j(56)   i2=104;
        LD    A,104
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test11.j(57)   for (byte b = 104; b <= 105+0; b++) { write (i2); i2--; }
        LD    A,104
        LD    (05005H),A
        LD    A,105
        ADD   A,0
        LD    B,A
        LD    A,(05005H)
        SUB   A,B
        JP    C,L135
        JP    L129
        LD    HL,(05005H)
        INC   (HL)
        JP    L122
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L127
        ;;test11.j(58)   // byte - integer
        ;;test11.j(59)   i2=103;
        LD    A,103
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test11.j(60)   for (byte b = 102; b <= i2+0; b--) { write (b); i2=i2-2; }
        LD    A,102
        LD    (05005H),A
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        LD    A,(05005H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L156
        JP    L148
        LD    HL,(05005H)
        DEC   (HL)
        JP    L140
        LD    A,(05005H)
        CALL  writeA
        LD    HL,(05000H)
        LD    DE,2
        OR    A
        SBC   HL,DE
        LD    (05000H),HL
        JP    L146
        ;;test11.j(61)   // integer - byte
        ;;test11.j(62)   b2=100;
        LD    A,100
        LD    (05004H),A
        ;;test11.j(63)   for(int i = 100; i <= 101+0; i++) { write(b2); b2--; }
        LD    A,100
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    A,101
        ADD   A,0
        LD    HL,(05005H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L175
        JP    L169
        LD    HL,(05005H)
        INC   HL
        LD    (05005H),HL
        JP    L161
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L167
        ;;test11.j(64)   // integer - integer
        ;;test11.j(65)   for(int i = 1098; i <= 1099+0; i++) { write(b2); b2--; }
        LD    HL,1098
        LD    (05005H),HL
        LD    HL,1099
        LD    DE,0
        ADD   HL,DE
        LD    DE,(05005H)
        OR    A
        SBC   HL,DE
        JP    C,L193
        JP    L184
        LD    HL,(05005H)
        INC   HL
        LD    (05005H),HL
        JP    L177
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L182
        ;;test11.j(66) 
        ;;test11.j(67)   /************************/
        ;;test11.j(68)   // var - constant
        ;;test11.j(69)   // byte - byte
        ;;test11.j(70)   i2=96;
        LD    A,96
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test11.j(71)   for (byte b = 96; b <= 97; b++) { write (i2); i2--; }
        LD    A,96
        LD    (05005H),A
        LD    A,(05005H)
        SUB   A,97
        JP    Z,$+5
        JP    C,L211
        JP    L204
        LD    HL,(05005H)
        INC   (HL)
        JP    L198
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L202
        ;;test11.j(72)   // byte - integer
        ;;test11.j(73)   //not relevant
        ;;test11.j(74)   write(94);
        LD    A,94
        CALL  writeA
        ;;test11.j(75)   write(93);
        LD    A,93
        CALL  writeA
        ;;test11.j(76)   // integer - byte
        ;;test11.j(77)   b2=92;
        LD    A,92
        LD    (05004H),A
        ;;test11.j(78)   for(int i = 92; i <= 93; i++) { write(b2); b2--; }
        LD    A,92
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    A,93
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L236
        JP    L230
        LD    HL,(05005H)
        INC   HL
        LD    (05005H),HL
        JP    L223
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L228
        ;;test11.j(79)   // integer - integer
        ;;test11.j(80)   for(int i = 1090; i <= 1091; i++) { write(b2); b2--; }
        LD    HL,1090
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,1091
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L254
        JP    L244
        LD    HL,(05005H)
        INC   HL
        LD    (05005H),HL
        JP    L238
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L242
        ;;test11.j(81) 
        ;;test11.j(82)   /************************/
        ;;test11.j(83)   // acc - stack8
        ;;test11.j(84)   // byte - byte
        ;;test11.j(85)   //TODO
        ;;test11.j(86)   write(88);
        LD    A,88
        CALL  writeA
        ;;test11.j(87)   write(87);
        LD    A,87
        CALL  writeA
        ;;test11.j(88)   // byte - integer
        ;;test11.j(89)   //TODO
        ;;test11.j(90)   write(86);
        LD    A,86
        CALL  writeA
        ;;test11.j(91)   write(85);
        LD    A,85
        CALL  writeA
        ;;test11.j(92)   // integer - byte
        ;;test11.j(93)   //TODO
        ;;test11.j(94)   write(84);
        LD    A,84
        CALL  writeA
        ;;test11.j(95)   write(83);
        LD    A,83
        CALL  writeA
        ;;test11.j(96)   // integer - integer
        ;;test11.j(97)   //TODO
        ;;test11.j(98)   write(82);
        LD    A,82
        CALL  writeA
        ;;test11.j(99)   write(81);
        LD    A,81
        CALL  writeA
        ;;test11.j(100) 
        ;;test11.j(101)   /************************/
        ;;test11.j(102)   // acc - stack16
        ;;test11.j(103)   // byte - byte
        ;;test11.j(104)   //TODO
        ;;test11.j(105)   write(80);
        LD    A,80
        CALL  writeA
        ;;test11.j(106)   write(79);
        LD    A,79
        CALL  writeA
        ;;test11.j(107)   // byte - integer
        ;;test11.j(108)   //TODO
        ;;test11.j(109)   write(78);
        LD    A,78
        CALL  writeA
        ;;test11.j(110)   write(77);
        LD    A,77
        CALL  writeA
        ;;test11.j(111)   // integer - byte
        ;;test11.j(112)   //TODO
        ;;test11.j(113)   write(76);
        LD    A,76
        CALL  writeA
        ;;test11.j(114)   write(75);
        LD    A,75
        CALL  writeA
        ;;test11.j(115)   // integer - integer
        ;;test11.j(116)   //TODO
        ;;test11.j(117)   write(74);
        LD    A,74
        CALL  writeA
        ;;test11.j(118)   write(73);
        LD    A,73
        CALL  writeA
        ;;test11.j(119) 
        ;;test11.j(120)   /************************/
        ;;test11.j(121)   // acc - var
        ;;test11.j(122)   // byte - byte
        ;;test11.j(123)   for (byte b = 72; 71+0 <= b; b--) { write (b); }
        LD    A,72
        LD    (05005H),A
        LD    A,71
        ADD   A,0
        LD    B,A
        LD    A,(05005H)
        SUB   A,B
        JP    Z,$+5
        JP    C,L337
        JP    L332
        LD    HL,(05005H)
        DEC   (HL)
        JP    L325
        LD    A,(05005H)
        CALL  writeA
        JP    L330
        ;;test11.j(124)   // byte - integer
        ;;test11.j(125)   for(int i = 70; 69+0 <= i; i--) { write(i); }
        LD    A,70
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    A,69
        ADD   A,0
        LD    HL,(05005H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L352
        JP    L347
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L339
        LD    HL,(05005H)
        CALL  writeHL
        JP    L345
        ;;test11.j(126)   // integer - byte
        ;;test11.j(127)   i2=67;
        LD    A,67
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test11.j(128)   for (byte b = 68; i2+0 <= b; b--) { write (b); }
        LD    A,68
        LD    (05005H),A
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        LD    A,(05005H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L370
        JP    L365
        LD    HL,(05005H)
        DEC   (HL)
        JP    L357
        LD    A,(05005H)
        CALL  writeA
        JP    L363
        ;;test11.j(129)   // integer - integer
        ;;test11.j(130)   b2 = 66;
        LD    A,66
        LD    (05004H),A
        ;;test11.j(131)   for(int i = 1066; 1000+65 <= i; i--) { write (b2); b2--; }
        LD    HL,1066
        LD    (05005H),HL
        LD    HL,1000
        LD    DE,65
        ADD   HL,DE
        LD    DE,(05005H)
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L391
        JP    L382
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L375
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L380
        ;;test11.j(132) 
        ;;test11.j(133)   /************************/
        ;;test11.j(134)   // acc - acc
        ;;test11.j(135)   // byte - byte
        ;;test11.j(136)   for (byte b = 64; 63+0 <= b+0; b--) { write (b); }
        LD    A,64
        LD    (05005H),A
        LD    A,63
        ADD   A,0
        PUSH AF
        LD    A,(05005H)
        ADD   A,0
        POP   BC
        SUB   A,B
        JP    C,L408
        JP    L403
        LD    HL,(05005H)
        DEC   (HL)
        JP    L393
        LD    A,(05005H)
        CALL  writeA
        JP    L401
        ;;test11.j(137)   // byte - integer
        ;;test11.j(138)   for(int i = 62; 61+0 <= i+0; i--) { write(i); }
        LD    A,62
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    A,61
        ADD   A,0
        PUSH AF
        LD    HL,(05005H)
        LD    DE,0
        ADD   HL,DE
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L426
        JP    L421
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L410
        LD    HL,(05005H)
        CALL  writeHL
        JP    L419
        ;;test11.j(139)   // integer - byte
        ;;test11.j(140)   i2=59;
        LD    A,59
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test11.j(141)   for (byte b = 60; i2+0 <= b+0; b--) { write (b); }
        LD    A,60
        LD    (05005H),A
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        PUSH HL
        LD    A,(05005H)
        ADD   A,0
        POP  HL
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L447
        JP    L442
        LD    HL,(05005H)
        DEC   (HL)
        JP    L431
        LD    A,(05005H)
        CALL  writeA
        JP    L440
        ;;test11.j(142)   // integer - integer
        ;;test11.j(143)   b2=58;
        LD    A,58
        LD    (05004H),A
        ;;test11.j(144)   for(int i = 1058; 1000+57 <= i+0; i--) { write(b2); b2--; }
        LD    HL,1058
        LD    (05005H),HL
        LD    HL,1000
        LD    DE,57
        ADD   HL,DE
        PUSH HL
        LD    HL,(05005H)
        LD    DE,0
        ADD   HL,DE
        POP   DE
        OR    A
        SBC   HL,DE
        JP    C,L471
        JP    L462
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L452
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L460
        ;;test11.j(145) 
        ;;test11.j(146)   /************************/
        ;;test11.j(147)   // acc - constant
        ;;test11.j(148)   // byte - byte
        ;;test11.j(149)   i2=56;
        LD    A,56
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test11.j(150)   for (byte b = 56; b+0 <= 57; b++) { write (i2); i2--; }
        LD    A,56
        LD    (05005H),A
        LD    A,(05005H)
        ADD   A,0
        SUB   A,57
        JP    Z,$+5
        JP    C,L491
        JP    L483
        LD    HL,(05005H)
        INC   (HL)
        JP    L476
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L481
        ;;test11.j(151)   // byte - integer
        ;;test11.j(152)   //not relevant
        ;;test11.j(153)   // integer - byte
        ;;test11.j(154)   b2=54;
        LD    A,54
        LD    (05004H),A
        ;;test11.j(155)   for (int i = 54; i+0 <= 55; i++) { write (b2); b2--;}
        LD    A,54
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,0
        ADD   HL,DE
        LD    A,55
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L510
        JP    L504
        LD    HL,(05005H)
        INC   HL
        LD    (05005H),HL
        JP    L496
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L502
        ;;test11.j(156)   // integer - integer
        ;;test11.j(157)   b2=52;
        LD    A,52
        LD    (05004H),A
        ;;test11.j(158)   for(int i = 1052; i+0 <= 1053; i++) { write(b2); b2--; }
        LD    HL,1052
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,0
        ADD   HL,DE
        LD    DE,1053
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L532
        JP    L522
        LD    HL,(05005H)
        INC   HL
        LD    (05005H),HL
        JP    L515
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L520
        ;;test11.j(159) 
        ;;test11.j(160)   /************************/
        ;;test11.j(161)   // constant - stack8
        ;;test11.j(162)   // byte - byte
        ;;test11.j(163)   //TODO
        ;;test11.j(164)   write(50);
        LD    A,50
        CALL  writeA
        ;;test11.j(165)   // constant - stack8
        ;;test11.j(166)   // byte - integer
        ;;test11.j(167)   //TODO
        ;;test11.j(168)   write(49);
        LD    A,49
        CALL  writeA
        ;;test11.j(169)   // constant - stack8
        ;;test11.j(170)   // integer - byte
        ;;test11.j(171)   //TODO
        ;;test11.j(172)   write(48);
        LD    A,48
        CALL  writeA
        ;;test11.j(173)   // constant - stack88
        ;;test11.j(174)   // integer - integer
        ;;test11.j(175)   //TODO
        ;;test11.j(176)   write(47);
        LD    A,47
        CALL  writeA
        ;;test11.j(177) 
        ;;test11.j(178)   /************************/
        ;;test11.j(179)   // constant - stack16
        ;;test11.j(180)   // byte - byte
        ;;test11.j(181)   //TODO
        ;;test11.j(182)   write(46);
        LD    A,46
        CALL  writeA
        ;;test11.j(183)   // constant - stack16
        ;;test11.j(184)   // byte - integer
        ;;test11.j(185)   //TODO
        ;;test11.j(186)   write(45);
        LD    A,45
        CALL  writeA
        ;;test11.j(187)   // constant - stack16
        ;;test11.j(188)   // integer - byte
        ;;test11.j(189)   //TODO
        ;;test11.j(190)   write(44);
        LD    A,44
        CALL  writeA
        ;;test11.j(191)   // constant - stack16
        ;;test11.j(192)   // integer - integer
        ;;test11.j(193)   //TODO
        ;;test11.j(194)   write(43);
        LD    A,43
        CALL  writeA
        ;;test11.j(195) 
        ;;test11.j(196)   /************************/
        ;;test11.j(197)   // constant - var
        ;;test11.j(198)   // byte - byte
        ;;test11.j(199)   for (byte b = 42; 41 <= b; b--) { write (b); }
        LD    A,42
        LD    (05005H),A
        LD    A,(05005H)
        SUB   A,41
        JP    C,L597
        JP    L591
        LD    HL,(05005H)
        DEC   (HL)
        JP    L585
        LD    A,(05005H)
        CALL  writeA
        JP    L589
        ;;test11.j(200)   // constant - var
        ;;test11.j(201)   // byte - integer
        ;;test11.j(202)   for(int i = 40; 39 <= i; i--) { write(i); }
        LD    A,40
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    A,39
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L615
        JP    L606
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L599
        LD    HL,(05005H)
        CALL  writeHL
        JP    L604
        ;;test11.j(203)   // constant - var
        ;;test11.j(204)   // integer - byte
        ;;test11.j(205)   // not relevant
        ;;test11.j(206)   // constant - var
        ;;test11.j(207)   // integer - integer
        ;;test11.j(208)   b2=38;
        LD    A,38
        LD    (05004H),A
        ;;test11.j(209)   for(int i = 1038; 1037 <= i; i--) { write(b2); b2--; }
        LD    HL,1038
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,1037
        OR    A
        SBC   HL,DE
        JP    C,L635
        JP    L626
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L620
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L624
        ;;test11.j(210) 
        ;;test11.j(211)   /************************/
        ;;test11.j(212)   // constant - acc
        ;;test11.j(213)   // byte - byte
        ;;test11.j(214)   for (byte b = 36; 136 == b+100; b--) { write (b); }
        LD    A,36
        LD    (05005H),A
        LD    A,(05005H)
        ADD   A,100
        SUB   A,136
        JP    NZ,L648
        JP    L644
        LD    HL,(05005H)
        DEC   (HL)
        JP    L637
        LD    A,(05005H)
        CALL  writeA
        JP    L642
        ;;test11.j(215)   for (byte b = 35; 132 != b+100; b--) { write (b); }
        LD    A,35
        LD    (05005H),A
        LD    A,(05005H)
        ADD   A,100
        SUB   A,132
        JP    Z,L661
        JP    L657
        LD    HL,(05005H)
        DEC   (HL)
        JP    L650
        LD    A,(05005H)
        CALL  writeA
        JP    L655
        ;;test11.j(216)   b2=32;
        LD    A,32
        LD    (05004H),A
        ;;test11.j(217)   for (byte b = 32; 134 > b+100; b++) { write (b2); b2--; }
        LD    A,32
        LD    (05005H),A
        LD    A,(05005H)
        ADD   A,100
        SUB   A,134
        JP    NC,L678
        JP    L673
        LD    HL,(05005H)
        INC   (HL)
        JP    L666
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L671
        ;;test11.j(218)   for (byte b = 34; 135 >= b+100; b++) { write (b2); b2--; }
        LD    A,34
        LD    (05005H),A
        LD    A,(05005H)
        ADD   A,100
        SUB   A,135
        JP    Z,$+5
        JP    C,L692
        JP    L687
        LD    HL,(05005H)
        INC   (HL)
        JP    L680
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L685
        ;;test11.j(219)   for (byte b = 28; 126 <  b+100; b--) { write (b); }
        LD    A,28
        LD    (05005H),A
        LD    A,(05005H)
        ADD   A,100
        SUB   A,126
        JP    Z,L705
        JP    L701
        LD    HL,(05005H)
        DEC   (HL)
        JP    L694
        LD    A,(05005H)
        CALL  writeA
        JP    L699
        ;;test11.j(220)   for (byte b = 26; 125 <= b+100; b--) { write (b); }
        LD    A,26
        LD    (05005H),A
        LD    A,(05005H)
        ADD   A,100
        SUB   A,125
        JP    C,L720
        JP    L714
        LD    HL,(05005H)
        DEC   (HL)
        JP    L707
        LD    A,(05005H)
        CALL  writeA
        JP    L712
        ;;test11.j(221)   // constant - acc
        ;;test11.j(222)   // byte - integer
        ;;test11.j(223)   for(int i = 24; 24 == i+0; i--) { write(i); }
        LD    A,24
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,0
        ADD   HL,DE
        LD    A,24
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NZ,L734
        JP    L730
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L722
        LD    HL,(05005H)
        CALL  writeHL
        JP    L728
        ;;test11.j(224)   for(int i = 23; 120 != i+100; i--) { write(i); }
        LD    A,23
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,100
        ADD   HL,DE
        LD    A,120
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L748
        JP    L744
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L736
        LD    HL,(05005H)
        CALL  writeHL
        JP    L742
        ;;test11.j(225)   b2=20;
        LD    A,20
        LD    (05004H),A
        ;;test11.j(226)   for(int i = 20; 122 > i+100; i++) { write (b2); b2--; }
        LD    A,20
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,100
        ADD   HL,DE
        LD    A,122
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L766
        JP    L761
        LD    HL,(05005H)
        INC   HL
        LD    (05005H),HL
        JP    L753
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L759
        ;;test11.j(227)   for(int i = 22; 123 >= i+100; i++) { write (b2); b2--; }
        LD    A,22
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,100
        ADD   HL,DE
        LD    A,123
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L781
        JP    L776
        LD    HL,(05005H)
        INC   HL
        LD    (05005H),HL
        JP    L768
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L774
        ;;test11.j(228)   for(int i = 16; 114 <  i+100; i--) { write(i); }
        LD    A,16
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,100
        ADD   HL,DE
        LD    A,114
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L795
        JP    L791
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L783
        LD    HL,(05005H)
        CALL  writeHL
        JP    L789
        ;;test11.j(229)   for(int i = 14; 113 <= i+100; i--) { write(i); }
        LD    A,14
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,100
        ADD   HL,DE
        LD    A,113
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L815
        JP    L805
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L797
        LD    HL,(05005H)
        CALL  writeHL
        JP    L803
        ;;test11.j(230)   // constant - acc
        ;;test11.j(231)   // integer - byte
        ;;test11.j(232)   // not relevant
        ;;test11.j(233) 
        ;;test11.j(234)   // constant - acc
        ;;test11.j(235)   // integer - integer
        ;;test11.j(236)   for(int i = 12; 1012 == i+1000; i--) { write(i); }
        LD    A,12
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1012
        OR    A
        SBC   HL,DE
        JP    NZ,L828
        JP    L824
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L817
        LD    HL,(05005H)
        CALL  writeHL
        JP    L822
        ;;test11.j(237)   for(int i = 11; 1008 != i+1000; i--) { write(i); }
        LD    A,11
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1008
        OR    A
        SBC   HL,DE
        JP    Z,L841
        JP    L837
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L830
        LD    HL,(05005H)
        CALL  writeHL
        JP    L835
        ;;test11.j(238)   b2=8;
        LD    A,8
        LD    (05004H),A
        ;;test11.j(239)   for(int i = 8; 1010 > i+1000; i++) { write (b2); b2--; }
        LD    A,8
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1010
        OR    A
        SBC   HL,DE
        JP    NC,L858
        JP    L853
        LD    HL,(05005H)
        INC   HL
        LD    (05005H),HL
        JP    L846
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L851
        ;;test11.j(240)   for(int i = 10; 1011 >= i+1000; i++) { write (b2); b2--; }
        LD    A,10
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1011
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L872
        JP    L867
        LD    HL,(05005H)
        INC   HL
        LD    (05005H),HL
        JP    L860
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        JP    L865
        ;;test11.j(241)   for(int i = 4; 1002 <  i+1000; i--) { write(i); }
        LD    A,4
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1002
        OR    A
        SBC   HL,DE
        JP    Z,L885
        JP    L881
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L874
        LD    HL,(05005H)
        CALL  writeHL
        JP    L879
        ;;test11.j(242)   for(int i = 2; 1001 <= i+1000; i--) { write(i); }
        LD    A,2
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        LD    HL,(05005H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1001
        OR    A
        SBC   HL,DE
        JP    C,L898
        JP    L894
        LD    HL,(05005H)
        DEC   HL
        LD    (05005H),HL
        JP    L887
        LD    HL,(05005H)
        CALL  writeHL
        JP    L892
        ;;test11.j(243)   write(0);
        LD    A,0
        CALL  writeA
        ;;test11.j(244) }
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
