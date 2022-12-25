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
        ;;test1.j(2)   int i = 110;
        LD    A,110
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(3)   int i2 = 105;
        LD    A,105
        LD    L,A
        LD    H,0
        LD    (05002H),HL
        ;;test1.j(4)   int p = 12;
        LD    A,12
        LD    L,A
        LD    H,0
        LD    (05004H),HL
        ;;test1.j(5)   byte b = 112;
        LD    A,112
        LD    (05006H),A
        ;;test1.j(6)   byte b2 = 111;
        LD    A,111
        LD    (05007H),A
        ;;test1.j(7) 
        ;;test1.j(8)   /************************/
        ;;test1.j(9)   // stack8 - constant
        ;;test1.j(10)   // stack8 - acc
        ;;test1.j(11)   // stack8 - var
        ;;test1.j(12)   // stack8 - stack8
        ;;test1.j(13)   // stack8 - stack16
        ;;test1.j(14)   //TODO
        ;;test1.j(15) 
        ;;test1.j(16)   /************************/
        ;;test1.j(17)   // stack16 - constant
        ;;test1.j(18)   // stack16 - acc
        ;;test1.j(19)   // stack16 - var
        ;;test1.j(20)   // stack16 - stack8
        ;;test1.j(21)   // stack16 - stack16
        ;;test1.j(22)   //TODO
        ;;test1.j(23) 
        ;;test1.j(24)   /************************/
        ;;test1.j(25)   // var - stack16
        ;;test1.j(26)   // byte - byte
        ;;test1.j(27)   // byte - integer
        ;;test1.j(28)   // integer - byte
        ;;test1.j(29)   // integer - integer
        ;;test1.j(30)   //TODO
        ;;test1.j(31) 
        ;;test1.j(32)   /************************/
        ;;test1.j(33)   // var - stack8
        ;;test1.j(34)   // byte - byte
        ;;test1.j(35)   // byte - integer
        ;;test1.j(36)   // integer - byte
        ;;test1.j(37)   // integer - integer
        ;;test1.j(38)   //TODO
        ;;test1.j(39) 
        ;;test1.j(40)   /************************/
        ;;test1.j(41)   // var - var
        ;;test1.j(42)   // byte - byte
        ;;test1.j(43)   while (b2 <= b) { write (b); b--; }
        LD    A,(05007H)
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
        JP    Z,$+5
        JP    C,L63
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        JP    L54
        ;;test1.j(44)   // byte - integer
        ;;test1.j(45)   b2 = 109;
        LD    A,109
        LD    (05007H),A
        ;;test1.j(46)   while (b2 <= i) { write (i); i--; }
        LD    A,(05007H)
        LD    HL,(05000H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L76
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L66
        ;;test1.j(47)   // integer - byte
        ;;test1.j(48)   b=108;
        LD    A,108
        LD    (05006H),A
        ;;test1.j(49)   i=107;
        LD    A,107
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(50)   while (i <= b) { write (b); b--; }
        LD    HL,(05000H)
        LD    A,(05006H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L92
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        JP    L82
        ;;test1.j(51)   // integer - integer
        ;;test1.j(52)   i=106;
        LD    A,106
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(53)   while (i2 <= i) { write (i); i--; }
        LD    HL,(05002H)
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L107
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L95
        ;;test1.j(54) 
        ;;test1.j(55)   /************************/
        ;;test1.j(56)   // var - acc
        ;;test1.j(57)   // byte - byte
        ;;test1.j(58)   i=104;
        LD    A,104
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(59)   b=104;
        LD    A,104
        LD    (05006H),A
        ;;test1.j(60)   while (b <= 105+0) { write (i); i--; b++; }
        LD    A,105
        ADD   A,0
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
        JP    C,L124
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05006H)
        INC   (HL)
        JP    L113
        ;;test1.j(61)   // byte - integer
        ;;test1.j(62)   i=103;
        LD    A,103
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(63)   b=102;
        LD    A,102
        LD    (05006H),A
        ;;test1.j(64)   while (b <= i+0) { write (b); b--; i=i-2; }
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        LD    A,(05006H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L144
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        LD    HL,(05000H)
        LD    DE,2
        OR    A
        SBC   HL,DE
        LD    (05000H),HL
        JP    L130
        ;;test1.j(65)   // integer - byte
        ;;test1.j(66)   i=100;
        LD    A,100
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(67)   while (i <= 101+0) { write (b); b--; i++; }
        LD    A,101
        ADD   A,0
        LD    HL,(05000H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L159
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        JP    L147
        ;;test1.j(68)   // integer - integer
        ;;test1.j(69)   i=1098;
        LD    HL,1098
        LD    (05000H),HL
        ;;test1.j(70)   while (i <= 1099+0) { write (b); b--; i++; }
        LD    HL,1099
        LD    DE,0
        ADD   HL,DE
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
        JP    C,L176
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        JP    L162
        ;;test1.j(71) 
        ;;test1.j(72)   /************************/
        ;;test1.j(73)   // var - constant
        ;;test1.j(74)   // byte - byte
        ;;test1.j(75)   i=96;
        LD    A,96
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(76)   b=96;
        LD    A,96
        LD    (05006H),A
        ;;test1.j(77)   while (b <= 97) { write (i); i--; b++; }
        LD    A,(05006H)
        SUB   A,97
        JP    Z,$+5
        JP    C,L193
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05006H)
        INC   (HL)
        JP    L182
        ;;test1.j(78)   // byte - integer
        ;;test1.j(79)   //not relevant
        ;;test1.j(80)   write(94);
        LD    A,94
        CALL  writeA
        ;;test1.j(81)   write(93);
        LD    A,93
        CALL  writeA
        ;;test1.j(82)   // integer - byte
        ;;test1.j(83)   i=92;
        LD    A,92
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(84)   b=92;
        LD    A,92
        LD    (05006H),A
        ;;test1.j(85)   while (i <= 93) { write (b); b--; i++; }
        LD    HL,(05000H)
        LD    A,93
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L217
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        JP    L206
        ;;test1.j(86)   // integer - integer
        ;;test1.j(87)   i=1090;
        LD    HL,1090
        LD    (05000H),HL
        ;;test1.j(88)   while (i <= 1091) { write (b); b--; i++; }
        LD    HL,(05000H)
        LD    DE,1091
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L234
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        JP    L220
        ;;test1.j(89) 
        ;;test1.j(90)   /************************/
        ;;test1.j(91)   // acc - stack8
        ;;test1.j(92)   // byte - byte
        ;;test1.j(93)   //TODO
        ;;test1.j(94)   write(88);
        LD    A,88
        CALL  writeA
        ;;test1.j(95)   write(87);
        LD    A,87
        CALL  writeA
        ;;test1.j(96)   // byte - integer
        ;;test1.j(97)   //TODO
        ;;test1.j(98)   write(86);
        LD    A,86
        CALL  writeA
        ;;test1.j(99)   write(85);
        LD    A,85
        CALL  writeA
        ;;test1.j(100)   // integer - byte
        ;;test1.j(101)   //TODO
        ;;test1.j(102)   write(84);
        LD    A,84
        CALL  writeA
        ;;test1.j(103)   write(83);
        LD    A,83
        CALL  writeA
        ;;test1.j(104)   // integer - integer
        ;;test1.j(105)   //TODO
        ;;test1.j(106)   write(82);
        LD    A,82
        CALL  writeA
        ;;test1.j(107)   write(81);
        LD    A,81
        CALL  writeA
        ;;test1.j(108) 
        ;;test1.j(109)   /************************/
        ;;test1.j(110)   // acc - stack16
        ;;test1.j(111)   // byte - byte
        ;;test1.j(112)   //TODO
        ;;test1.j(113)   write(80);
        LD    A,80
        CALL  writeA
        ;;test1.j(114)   write(79);
        LD    A,79
        CALL  writeA
        ;;test1.j(115)   // byte - integer
        ;;test1.j(116)   //TODO
        ;;test1.j(117)   write(78);
        LD    A,78
        CALL  writeA
        ;;test1.j(118)   write(77);
        LD    A,77
        CALL  writeA
        ;;test1.j(119)   // integer - byte
        ;;test1.j(120)   //TODO
        ;;test1.j(121)   write(76);
        LD    A,76
        CALL  writeA
        ;;test1.j(122)   write(75);
        LD    A,75
        CALL  writeA
        ;;test1.j(123)   // integer - integer
        ;;test1.j(124)   //TODO
        ;;test1.j(125)   write(74);
        LD    A,74
        CALL  writeA
        ;;test1.j(126)   write(73);
        LD    A,73
        CALL  writeA
        ;;test1.j(127) 
        ;;test1.j(128)   /************************/
        ;;test1.j(129)   // acc - var
        ;;test1.j(130)   // byte - byte
        ;;test1.j(131)   b=72;
        LD    A,72
        LD    (05006H),A
        ;;test1.j(132)   while (71+0 <= b) { write (b); b--; }
        LD    A,71
        ADD   A,0
        LD    B,A
        LD    A,(05006H)
        SUB   A,B
        JP    Z,$+5
        JP    C,L316
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        JP    L306
        ;;test1.j(133)   // byte - integer
        ;;test1.j(134)   i=70;
        LD    A,70
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(135)   while (69+0 <= i) { write (i); i--; }
        LD    A,69
        ADD   A,0
        LD    HL,(05000H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L330
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L319
        ;;test1.j(136)   // integer - byte
        ;;test1.j(137)   i=67;
        LD    A,67
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(138)   b=68;
        LD    A,68
        LD    (05006H),A
        ;;test1.j(139)   while (i+0 <= b) { write (b); b--; } 
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        LD    A,(05006H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L347
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        JP    L336
        ;;test1.j(140)   // integer - integer
        ;;test1.j(141)   i=1066;
        LD    HL,1066
        LD    (05000H),HL
        ;;test1.j(142)   while (1000+65 <= i) { write (b); b--; i--; }
        LD    HL,1000
        LD    DE,65
        ADD   HL,DE
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L364
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L350
        ;;test1.j(143) 
        ;;test1.j(144)   /************************/
        ;;test1.j(145)   // acc - acc
        ;;test1.j(146)   // byte - byte
        ;;test1.j(147)   b=64;
        LD    A,64
        LD    (05006H),A
        ;;test1.j(148)   while (63+0 <= b+0) { write (b); b--; }
        LD    A,63
        ADD   A,0
        PUSH AF
        LD    A,(05006H)
        ADD   A,0
        POP   BC
        SUB   A,B
        JP    C,L380
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        JP    L367
        ;;test1.j(149)   // byte - integer
        ;;test1.j(150)   i=62;
        LD    A,62
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(151)   while (61+0 <= i+0) { write (i); i--; }
        LD    A,61
        ADD   A,0
        PUSH AF
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        POP  AF
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L397
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L383
        ;;test1.j(152)   // integer - byte
        ;;test1.j(153)   i=59;
        LD    A,59
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(154)   b=60;
        LD    A,60
        LD    (05006H),A
        ;;test1.j(155)   while (i+0 <= b+0) { write (b); b--; }
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        PUSH HL
        LD    A,(05006H)
        ADD   A,0
        POP  HL
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L417
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        JP    L403
        ;;test1.j(156)   // integer - integer
        ;;test1.j(157)   i=1058;
        LD    HL,1058
        LD    (05000H),HL
        ;;test1.j(158)   while (1000+57 <= i+0) { write (b); b--; i--; }
        LD    HL,1000
        LD    DE,57
        ADD   HL,DE
        PUSH HL
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        POP   DE
        OR    A
        SBC   HL,DE
        JP    C,L437
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L420
        ;;test1.j(159) 
        ;;test1.j(160)   /************************/
        ;;test1.j(161)   // acc - constant
        ;;test1.j(162)   // byte - byte
        ;;test1.j(163)   i=56;
        LD    A,56
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(164)   b=56;
        LD    A,56
        LD    (05006H),A
        ;;test1.j(165)   while (b+0 <= 57) { write (i); i--; b++; }
        LD    A,(05006H)
        ADD   A,0
        SUB   A,57
        JP    Z,$+5
        JP    C,L456
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05006H)
        INC   (HL)
        JP    L443
        ;;test1.j(166)   // byte - integer
        ;;test1.j(167)   //not relevant
        ;;test1.j(168)   // integer - byte
        ;;test1.j(169)   i=54;
        LD    A,54
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(170)   b=54;
        LD    A,54
        LD    (05006H),A
        ;;test1.j(171)   while (i+0 <= 55) { write (b); b--; i++; }
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        LD    A,55
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L473
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        JP    L462
        ;;test1.j(172)   i=1052;
        LD    HL,1052
        LD    (05000H),HL
        ;;test1.j(173)   // integer - integer
        ;;test1.j(174)   while (i+0 <= 1053) { write (b); b--; i++; }
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        LD    DE,1053
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L492
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        JP    L477
        ;;test1.j(175) 
        ;;test1.j(176)   /************************/
        ;;test1.j(177)   // constant - stack8
        ;;test1.j(178)   // byte - byte
        ;;test1.j(179)   //TODO
        ;;test1.j(180)   write(50);
        LD    A,50
        CALL  writeA
        ;;test1.j(181)   // constant - stack8
        ;;test1.j(182)   // byte - integer
        ;;test1.j(183)   //TODO
        ;;test1.j(184)   write(49);
        LD    A,49
        CALL  writeA
        ;;test1.j(185)   // constant - stack8
        ;;test1.j(186)   // integer - byte
        ;;test1.j(187)   //TODO
        ;;test1.j(188)   write(48);
        LD    A,48
        CALL  writeA
        ;;test1.j(189)   // constant - stack88
        ;;test1.j(190)   // integer - integer
        ;;test1.j(191)   //TODO
        ;;test1.j(192)   write(47);
        LD    A,47
        CALL  writeA
        ;;test1.j(193) 
        ;;test1.j(194)   /************************/
        ;;test1.j(195)   // constant - stack16
        ;;test1.j(196)   // byte - byte
        ;;test1.j(197)   //TODO
        ;;test1.j(198)   write(46);
        LD    A,46
        CALL  writeA
        ;;test1.j(199)   // constant - stack16
        ;;test1.j(200)   // byte - integer
        ;;test1.j(201)   //TODO
        ;;test1.j(202)   write(45);
        LD    A,45
        CALL  writeA
        ;;test1.j(203)   // constant - stack16
        ;;test1.j(204)   // integer - byte
        ;;test1.j(205)   //TODO
        ;;test1.j(206)   write(44);
        LD    A,44
        CALL  writeA
        ;;test1.j(207)   // constant - stack16
        ;;test1.j(208)   // integer - integer
        ;;test1.j(209)   //TODO
        ;;test1.j(210)   write(43);
        LD    A,43
        CALL  writeA
        ;;test1.j(211) 
        ;;test1.j(212)   /************************/
        ;;test1.j(213)   // constant - var
        ;;test1.j(214)   // byte - byte
        ;;test1.j(215)   b=42;
        LD    A,42
        LD    (05006H),A
        ;;test1.j(216)   while (41 <= b) { write (b); b--; }
        LD    A,(05006H)
        SUB   A,41
        JP    C,L557
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        JP    L546
        ;;test1.j(217) 
        ;;test1.j(218)   // constant - var
        ;;test1.j(219)   // byte - integer
        ;;test1.j(220)   i=40;
        LD    A,40
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(221)   while (39 <= i) { write (i); i--; }
        LD    HL,(05000H)
        LD    A,39
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L576
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L560
        ;;test1.j(222) 
        ;;test1.j(223)   // constant - var
        ;;test1.j(224)   // integer - byte
        ;;test1.j(225)   // not relevant
        ;;test1.j(226) 
        ;;test1.j(227)   // constant - var
        ;;test1.j(228)   // integer - integer
        ;;test1.j(229)   i=1038;
        LD    HL,1038
        LD    (05000H),HL
        ;;test1.j(230)   b=38;
        LD    A,38
        LD    (05006H),A
        ;;test1.j(231)   while (1037 <= i) { write (b); b--; i--; }
        LD    HL,(05000H)
        LD    DE,1037
        OR    A
        SBC   HL,DE
        JP    C,L595
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L582
        ;;test1.j(232) 
        ;;test1.j(233)   /************************/
        ;;test1.j(234)   // constant - acc
        ;;test1.j(235)   // byte - byte
        ;;test1.j(236)   b=36;
        LD    A,36
        LD    (05006H),A
        ;;test1.j(237)   while (135 == b+100) { write (b); b--; }
        LD    A,(05006H)
        ADD   A,100
        SUB   A,135
        JP    NZ,L607
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        JP    L598
        ;;test1.j(238)   while (132 != b+100) { write (b); b--; }
        LD    A,(05006H)
        ADD   A,100
        SUB   A,132
        JP    Z,L616
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        JP    L607
        ;;test1.j(239)   p=32;
        LD    A,32
        LD    L,A
        LD    H,0
        LD    (05004H),HL
        ;;test1.j(240)   while (134 > b+100) { write (p); p--; b++; }
        LD    A,(05006H)
        ADD   A,100
        SUB   A,134
        JP    NC,L629
        LD    HL,(05004H)
        CALL  writeHL
        LD    HL,(05004H)
        DEC   HL
        LD    (05004H),HL
        LD    HL,(05006H)
        INC   (HL)
        JP    L619
        ;;test1.j(241)   while (135 >= b+100) { write (p); p--; b++; }
        LD    A,(05006H)
        ADD   A,100
        SUB   A,135
        JP    Z,$+5
        JP    C,L639
        LD    HL,(05004H)
        CALL  writeHL
        LD    HL,(05004H)
        DEC   HL
        LD    (05004H),HL
        LD    HL,(05006H)
        INC   (HL)
        JP    L629
        ;;test1.j(242)   b=28;
        LD    A,28
        LD    (05006H),A
        ;;test1.j(243)   while (126 <  b+100) { write (b); b--; }
        LD    A,(05006H)
        ADD   A,100
        SUB   A,126
        JP    Z,L651
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        JP    L642
        ;;test1.j(244)   while (125 <= b+100) { write (b); b--; }
        LD    A,(05006H)
        ADD   A,100
        SUB   A,125
        JP    C,L662
        LD    A,(05006H)
        CALL  writeA
        LD    HL,(05006H)
        DEC   (HL)
        JP    L651
        ;;test1.j(245)   // constant - acc
        ;;test1.j(246)   // byte - integer
        ;;test1.j(247)   i=24;
        LD    A,24
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(248)   b=23;
        LD    A,23
        LD    (05006H),A
        ;;test1.j(249)   while (23 == i+0) { write (i); i--; }
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        LD    A,23
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NZ,L678
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L668
        ;;test1.j(250)   while (120 != i+100) { write (i); i--; }
        LD    HL,(05000H)
        LD    DE,100
        ADD   HL,DE
        LD    A,120
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L688
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L678
        ;;test1.j(251)   p=20;
        LD    A,20
        LD    L,A
        LD    H,0
        LD    (05004H),HL
        ;;test1.j(252)   while (122 > i+100) { write (p); p--; i++; }
        LD    HL,(05000H)
        LD    DE,100
        ADD   HL,DE
        LD    A,122
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L702
        LD    HL,(05004H)
        CALL  writeHL
        LD    HL,(05004H)
        DEC   HL
        LD    (05004H),HL
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        JP    L691
        ;;test1.j(253)   while (123 >= i+100) { write (p); p--; i++; }
        LD    HL,(05000H)
        LD    DE,100
        ADD   HL,DE
        LD    A,123
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L713
        LD    HL,(05004H)
        CALL  writeHL
        LD    HL,(05004H)
        DEC   HL
        LD    (05004H),HL
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        JP    L702
        ;;test1.j(254)   i=16;
        LD    A,16
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(255)   while (114 <  i+100) { write (i); i--; }
        LD    HL,(05000H)
        LD    DE,100
        ADD   HL,DE
        LD    A,114
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L726
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L716
        ;;test1.j(256)   while (113 <= i+100) { write (i); i--; }
        LD    HL,(05000H)
        LD    DE,100
        ADD   HL,DE
        LD    A,113
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L742
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L726
        ;;test1.j(257)   // constant - acc
        ;;test1.j(258)   // integer - byte
        ;;test1.j(259)   // not relevant
        ;;test1.j(260) 
        ;;test1.j(261)   // constant - acc
        ;;test1.j(262)   // integer - integer
        ;;test1.j(263)   i=12;
        LD    A,12
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(264)   while (1011 == i+1000) { write (i); i--; }
        LD    HL,(05000H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1011
        OR    A
        SBC   HL,DE
        JP    NZ,L755
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L745
        ;;test1.j(265)   //i=10
        ;;test1.j(266)   while (1008 != i+1000) { write (i); i--; }
        LD    HL,(05000H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1008
        OR    A
        SBC   HL,DE
        JP    Z,L765
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L755
        ;;test1.j(267)   //i=8
        ;;test1.j(268)   p=8;
        LD    A,8
        LD    L,A
        LD    H,0
        LD    (05004H),HL
        ;;test1.j(269)   while (1010 > i+1000) { write (p); p--; i++; }
        LD    HL,(05000H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1010
        OR    A
        SBC   HL,DE
        JP    NC,L779
        LD    HL,(05004H)
        CALL  writeHL
        LD    HL,(05004H)
        DEC   HL
        LD    (05004H),HL
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        JP    L768
        ;;test1.j(270)   //i=10; p=6
        ;;test1.j(271)   while (1011 >= i+1000) { write (p); p--; i++; }
        LD    HL,(05000H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1011
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L789
        LD    HL,(05004H)
        CALL  writeHL
        LD    HL,(05004H)
        DEC   HL
        LD    (05004H),HL
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        JP    L779
        ;;test1.j(272)   i=4;
        LD    A,4
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test1.j(273)   while (1002 <  i+1000) { write (i); i--; }
        LD    HL,(05000H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1002
        OR    A
        SBC   HL,DE
        JP    Z,L802
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L792
        ;;test1.j(274)   //i=2;
        ;;test1.j(275)   while (1001 <= i+1000) { write (i); i--; }
        LD    HL,(05000H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1001
        OR    A
        SBC   HL,DE
        JP    C,L815
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        JP    L802
        ;;test1.j(276) 
        ;;test1.j(277)   /************************/
        ;;test1.j(278)   // constant - constant
        ;;test1.j(279)   // not relevant
        ;;test1.j(280)   write(0);
        LD    A,0
        CALL  writeA
        ;;test1.j(281) }
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
