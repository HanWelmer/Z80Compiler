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
        ;;test10.j(0) /* Program to test generated Z80 assembler code */
        ;;test10.j(1) class TestDo {
        ;;test10.j(2)   int i = 12;
        LD    A,12
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(3)   int p = 12;
        LD    A,12
        LD    L,A
        LD    H,0
        LD    (05002H),HL
        ;;test10.j(4)   byte b = 24;
        LD    A,24
        LD    (05004H),A
        ;;test10.j(5) 
        ;;test10.j(6)   /************************/
        ;;test10.j(7)   // stack8 - constant
        ;;test10.j(8)   // stack8 - acc
        ;;test10.j(9)   // stack8 - var
        ;;test10.j(10)   // stack8 - stack8
        ;;test10.j(11)   // stack8 - stack16
        ;;test10.j(12)   //TODO
        ;;test10.j(13) 
        ;;test10.j(14)   /************************/
        ;;test10.j(15)   // stack16 - constant
        ;;test10.j(16)   // stack16 - acc
        ;;test10.j(17)   // stack16 - var
        ;;test10.j(18)   // stack16 - stack8
        ;;test10.j(19)   // stack16 - stack16
        ;;test10.j(20)   //TODO
        ;;test10.j(21) 
        ;;test10.j(22)   /************************/
        ;;test10.j(23)   // var - stack16
        ;;test10.j(24)   // byte - byte
        ;;test10.j(25)   // byte - integer
        ;;test10.j(26)   // integer - byte
        ;;test10.j(27)   // integer - integer
        ;;test10.j(28)   //TODO
        ;;test10.j(29) 
        ;;test10.j(30)   /************************/
        ;;test10.j(31)   // var - stack8
        ;;test10.j(32)   // byte - byte
        ;;test10.j(33)   // byte - integer
        ;;test10.j(34)   // integer - byte
        ;;test10.j(35)   // integer - integer
        ;;test10.j(36)   //TODO
        ;;test10.j(37) 
        ;;test10.j(38)   /************************/
        ;;test10.j(39)   // var - var
        ;;test10.j(40)   // byte - byte
        ;;test10.j(41)   b=112;
        LD    A,112
        LD    (05004H),A
        ;;test10.j(42)   byte b2 = 111;
        LD    A,111
        LD    (05005H),A
        ;;test10.j(43)   do { write (b); b--; } while (b2 <= b);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    A,(05005H)
        LD    B,A
        LD    A,(05004H)
        SUB   A,B
        JP    Z,L54
        ;;test10.j(44)   // byte - integer
        ;;test10.j(45)   i=110;
        LD    A,110
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(46)   b2 = 109;
        LD    A,109
        LD    (05005H),A
        ;;test10.j(47)   do { write (i); i--; } while (b2 <= i);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    A,(05005H)
        LD    HL,(05000H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L68
        ;;test10.j(48)   // integer - byte
        ;;test10.j(49)   b=108;
        LD    A,108
        LD    (05004H),A
        ;;test10.j(50)   i=107;
        LD    A,107
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(51)   do { write (b); b--; } while (i <= b);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    HL,(05000H)
        LD    A,(05004H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L83
        ;;test10.j(52)   // integer - integer
        ;;test10.j(53)   i=106;
        LD    A,106
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(54)   int i2 = 105;
        LD    A,105
        LD    L,A
        LD    H,0
        LD    (05006H),HL
        ;;test10.j(55)   do { write (i); i--; } while (i2 <= i);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05006H)
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
        JP    Z,L98
        ;;test10.j(56) 
        ;;test10.j(57)   /************************/
        ;;test10.j(58)   // var - acc
        ;;test10.j(59)   // byte - byte
        ;;test10.j(60)   i=104;
        LD    A,104
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(61)   b=104;
        LD    A,104
        LD    (05004H),A
        ;;test10.j(62)   do { write (i); i--; b++; } while (b <= 105+0);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05004H)
        INC   (HL)
        LD    A,105
        ADD   A,0
        LD    B,A
        LD    A,(05004H)
        SUB   A,B
        JP    NC,L115
        ;;test10.j(63)   // byte - integer
        ;;test10.j(64)   //not relevant
        ;;test10.j(65)   i=103;
        LD    A,103
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(66)   b=102;
        LD    A,102
        LD    (05004H),A
        ;;test10.j(67)   do { write (b); b--; i=i-2; } while (b <= i+0);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    HL,(05000H)
        LD    DE,2
        OR    A
        SBC   HL,DE
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        LD    A,(05004H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L132
        ;;test10.j(68)   // integer - byte
        ;;test10.j(69)   i=100;
        LD    A,100
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(70)   do { write (b); b--; i++; } while (i <= 101+0);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        LD    A,101
        ADD   A,0
        LD    HL,(05000H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L148
        ;;test10.j(71)   // integer - integer
        ;;test10.j(72)   i=1098;
        LD    HL,1098
        LD    (05000H),HL
        ;;test10.j(73)   do { write (b); b--; i++; } while (i <= 1099+0);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        LD    HL,1099
        LD    DE,0
        ADD   HL,DE
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
        JP    NC,L162
        ;;test10.j(74) 
        ;;test10.j(75)   /************************/
        ;;test10.j(76)   // var - constant
        ;;test10.j(77)   // byte - byte
        ;;test10.j(78)   i=96;
        LD    A,96
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(79)   b=96;
        LD    A,96
        LD    (05004H),A
        ;;test10.j(80)   do { write (i); i--; b++; } while (b <= 97);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05004H)
        INC   (HL)
        LD    A,(05004H)
        SUB   A,97
        JP    Z,L181
        ;;test10.j(81)   // byte - integer
        ;;test10.j(82)   //not relevant
        ;;test10.j(83)   write(94);
        LD    A,94
        CALL  writeA
        ;;test10.j(84)   write(93);
        LD    A,93
        CALL  writeA
        ;;test10.j(85)   // integer - byte
        ;;test10.j(86)   i=92;
        LD    A,92
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(87)   b=92;
        LD    A,92
        LD    (05004H),A
        ;;test10.j(88)   do { write (b); b--; i++; } while (i <= 93);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    A,93
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L204
        ;;test10.j(89)   // integer - integer
        ;;test10.j(90)   i=1090;
        LD    HL,1090
        LD    (05000H),HL
        ;;test10.j(91)   do { write (b); b--; i++; } while (i <= 1091);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,1091
        OR    A
        SBC   HL,DE
        JP    Z,L217
        ;;test10.j(92) 
        ;;test10.j(93)   /************************/
        ;;test10.j(94)   // acc - stack8
        ;;test10.j(95)   // byte - byte
        ;;test10.j(96)   //TODO
        ;;test10.j(97)   write(88);
        LD    A,88
        CALL  writeA
        ;;test10.j(98)   write(87);
        LD    A,87
        CALL  writeA
        ;;test10.j(99)   // byte - integer
        ;;test10.j(100)   //TODO
        ;;test10.j(101)   write(86);
        LD    A,86
        CALL  writeA
        ;;test10.j(102)   write(85);
        LD    A,85
        CALL  writeA
        ;;test10.j(103)   // integer - byte
        ;;test10.j(104)   //TODO
        ;;test10.j(105)   write(84);
        LD    A,84
        CALL  writeA
        ;;test10.j(106)   write(83);
        LD    A,83
        CALL  writeA
        ;;test10.j(107)   // integer - integer
        ;;test10.j(108)   //TODO
        ;;test10.j(109)   write(82);
        LD    A,82
        CALL  writeA
        ;;test10.j(110)   write(81);
        LD    A,81
        CALL  writeA
        ;;test10.j(111) 
        ;;test10.j(112)   /************************/
        ;;test10.j(113)   // acc - stack16
        ;;test10.j(114)   // byte - byte
        ;;test10.j(115)   //TODO
        ;;test10.j(116)   write(80);
        LD    A,80
        CALL  writeA
        ;;test10.j(117)   write(79);
        LD    A,79
        CALL  writeA
        ;;test10.j(118)   // byte - integer
        ;;test10.j(119)   //TODO
        ;;test10.j(120)   write(78);
        LD    A,78
        CALL  writeA
        ;;test10.j(121)   write(77);
        LD    A,77
        CALL  writeA
        ;;test10.j(122)   // integer - byte
        ;;test10.j(123)   //TODO
        ;;test10.j(124)   write(76);
        LD    A,76
        CALL  writeA
        ;;test10.j(125)   write(75);
        LD    A,75
        CALL  writeA
        ;;test10.j(126)   // integer - integer
        ;;test10.j(127)   //TODO
        ;;test10.j(128)   write(74);
        LD    A,74
        CALL  writeA
        ;;test10.j(129)   write(73);
        LD    A,73
        CALL  writeA
        ;;test10.j(130) 
        ;;test10.j(131)   /************************/
        ;;test10.j(132)   // acc - var
        ;;test10.j(133)   // byte - byte
        ;;test10.j(134)   b=72;
        LD    A,72
        LD    (05004H),A
        ;;test10.j(135)   do { write (b); b--; } while (71+0 <= b);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    A,71
        ADD   A,0
        LD    B,A
        LD    A,(05004H)
        SUB   A,B
        JP    Z,L302
        ;;test10.j(136)   // byte - integer
        ;;test10.j(137)   i=70;
        LD    A,70
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(138)   do { write (i); i--; } while (69+0 <= i);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    A,69
        ADD   A,0
        LD    HL,(05000H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L314
        ;;test10.j(139)   // integer - byte
        ;;test10.j(140)   i=67;
        LD    A,67
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(141)   b=68;
        LD    A,68
        LD    (05004H),A
        ;;test10.j(142)   do { write (b); b--; } while (i+0 <= b);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        LD    A,(05004H)
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L330
        ;;test10.j(143)   // integer - integer
        ;;test10.j(144)   i=1066;
        LD    HL,1066
        LD    (05000H),HL
        ;;test10.j(145)   do { write (b); b--; i--; } while (1000+65 <= i);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,1000
        LD    DE,65
        ADD   HL,DE
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
        JP    Z,L343
        ;;test10.j(146) 
        ;;test10.j(147)   /************************/
        ;;test10.j(148)   // acc - acc
        ;;test10.j(149)   // byte - byte
        ;;test10.j(150)   b=64;
        LD    A,64
        LD    (05004H),A
        ;;test10.j(151)   do { write (b); b--; } while (63+0 <= b+0);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    A,63
        ADD   A,0
        PUSH AF
        LD    A,(05004H)
        ADD   A,0
        POP   BC
        SUB   A,B
        JP    NC,L359
        ;;test10.j(152)   // byte - integer
        ;;test10.j(153)   i=62;
        LD    A,62
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(154)   do { write (i); i--; } while (61+0 <= i+0);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
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
        JP    Z,L374
        ;;test10.j(155)   // integer - byte
        ;;test10.j(156)   i=59;
        LD    A,59
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(157)   b=60;
        LD    A,60
        LD    (05004H),A
        ;;test10.j(158)   do { write (b); b--; } while (i+0 <= b+0);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        PUSH HL
        LD    A,(05004H)
        ADD   A,0
        POP  HL
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L393
        ;;test10.j(159)   // integer - integer
        ;;test10.j(160)   i=1058;
        LD    HL,1058
        LD    (05000H),HL
        ;;test10.j(161)   do { write (b); b--; i--; } while (1000+57 <= i+0);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
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
        JP    NC,L409
        ;;test10.j(162) 
        ;;test10.j(163)   /************************/
        ;;test10.j(164)   // acc - constant
        ;;test10.j(165)   // byte - byte
        ;;test10.j(166)   i=56;
        LD    A,56
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(167)   b=56;
        LD    A,56
        LD    (05004H),A
        ;;test10.j(168)   do { write (i); i--; b++; } while (b+0 <= 57);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05004H)
        INC   (HL)
        LD    A,(05004H)
        ADD   A,0
        SUB   A,57
        JP    Z,L431
        ;;test10.j(169)   // byte - integer
        ;;test10.j(170)   //not relevant
        ;;test10.j(171)   // integer - byte
        ;;test10.j(172)   i=54;
        LD    A,54
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(173)   b=54;
        LD    A,54
        LD    (05004H),A
        ;;test10.j(174)   do { write (b); b--; i++; } while (i+0 <= 55);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        LD    A,55
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        JP    Z,L449
        ;;test10.j(175)   i=1052;
        LD    HL,1052
        LD    (05000H),HL
        ;;test10.j(176)   // integer - integer
        ;;test10.j(177)   do { write (b); b--; i++; } while (i+0 <= 1053);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        LD    DE,1053
        OR    A
        SBC   HL,DE
        JP    Z,L463
        ;;test10.j(178) 
        ;;test10.j(179)   /************************/
        ;;test10.j(180)   // constant - stack8
        ;;test10.j(181)   // byte - byte
        ;;test10.j(182)   //TODO
        ;;test10.j(183)   write(50);
        LD    A,50
        CALL  writeA
        ;;test10.j(184)   // constant - stack8
        ;;test10.j(185)   // byte - integer
        ;;test10.j(186)   //TODO
        ;;test10.j(187)   write(49);
        LD    A,49
        CALL  writeA
        ;;test10.j(188)   // constant - stack8
        ;;test10.j(189)   // integer - byte
        ;;test10.j(190)   //TODO
        ;;test10.j(191)   write(48);
        LD    A,48
        CALL  writeA
        ;;test10.j(192)   // constant - stack88
        ;;test10.j(193)   // integer - integer
        ;;test10.j(194)   //TODO
        ;;test10.j(195)   write(47);
        LD    A,47
        CALL  writeA
        ;;test10.j(196) 
        ;;test10.j(197)   /************************/
        ;;test10.j(198)   // constant - stack16
        ;;test10.j(199)   // byte - byte
        ;;test10.j(200)   //TODO
        ;;test10.j(201)   write(46);
        LD    A,46
        CALL  writeA
        ;;test10.j(202)   // constant - stack16
        ;;test10.j(203)   // byte - integer
        ;;test10.j(204)   //TODO
        ;;test10.j(205)   write(45);
        LD    A,45
        CALL  writeA
        ;;test10.j(206)   // constant - stack16
        ;;test10.j(207)   // integer - byte
        ;;test10.j(208)   //TODO
        ;;test10.j(209)   write(44);
        LD    A,44
        CALL  writeA
        ;;test10.j(210)   // constant - stack16
        ;;test10.j(211)   // integer - integer
        ;;test10.j(212)   //TODO
        ;;test10.j(213)   write(43);
        LD    A,43
        CALL  writeA
        ;;test10.j(214) 
        ;;test10.j(215)   /************************/
        ;;test10.j(216)   // constant - var
        ;;test10.j(217)   // byte - byte
        ;;test10.j(218)   b=42;
        LD    A,42
        LD    (05004H),A
        ;;test10.j(219)   do { write (b); b--; } while (41 <= b);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    A,(05004H)
        SUB   A,41
        JP    NC,L531
        ;;test10.j(220) 
        ;;test10.j(221)   // constant - var
        ;;test10.j(222)   // byte - integer
        ;;test10.j(223)   i=40;
        LD    A,40
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(224)   do { write (i); i--; } while (39 <= i);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    A,39
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L544
        ;;test10.j(225) 
        ;;test10.j(226)   // constant - var
        ;;test10.j(227)   // integer - byte
        ;;test10.j(228)   // not relevant
        ;;test10.j(229) 
        ;;test10.j(230)   // constant - var
        ;;test10.j(231)   // integer - integer
        ;;test10.j(232)   i=1038;
        LD    HL,1038
        LD    (05000H),HL
        ;;test10.j(233)   b=38;
        LD    A,38
        LD    (05004H),A
        ;;test10.j(234)   do { write (b); b--; i--; } while (1037 <= i);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,1037
        OR    A
        SBC   HL,DE
        JP    NC,L565
        ;;test10.j(235) 
        ;;test10.j(236)   /************************/
        ;;test10.j(237)   // constant - acc
        ;;test10.j(238)   // byte - byte
        ;;test10.j(239)   b=36;
        LD    A,36
        LD    (05004H),A
        ;;test10.j(240)   do { write (b); b--; } while (135 == b+100);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    A,(05004H)
        ADD   A,100
        SUB   A,135
        JP    Z,L580
        ;;test10.j(241)   do { write (b); b--; } while (132 != b+100);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    A,(05004H)
        ADD   A,100
        SUB   A,132
        JP    NZ,L588
        ;;test10.j(242)   p=32;
        LD    A,32
        LD    L,A
        LD    H,0
        LD    (05002H),HL
        ;;test10.j(243)   do { write (p); p--; b++; } while (134 > b+100);
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
        LD    HL,(05004H)
        INC   (HL)
        LD    A,(05004H)
        ADD   A,100
        SUB   A,134
        JP    C,L599
        ;;test10.j(244)   do { write (p); p--; b++; } while (135 >= b+100);
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
        LD    HL,(05004H)
        INC   (HL)
        LD    A,(05004H)
        ADD   A,100
        SUB   A,135
        JP    Z,L608
        ;;test10.j(245)   b=28;
        LD    A,28
        LD    (05004H),A
        ;;test10.j(246)   do { write (b); b--; } while (126 <  b+100);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    A,(05004H)
        ADD   A,100
        SUB   A,126
        JP    Z,$+5
        JP    C,L620
        ;;test10.j(247)   do { write (b); b--; } while (125 <= b+100);
        LD    A,(05004H)
        CALL  writeA
        LD    HL,(05004H)
        DEC   (HL)
        LD    A,(05004H)
        ADD   A,100
        SUB   A,125
        JP    NC,L628
        ;;test10.j(248)   // constant - acc
        ;;test10.j(249)   // byte - integer
        ;;test10.j(250)   i=24;
        LD    A,24
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(251)   b=23;
        LD    A,23
        LD    (05004H),A
        ;;test10.j(252)   do { write (i); i--; } while (23 == i+0);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,0
        ADD   HL,DE
        LD    A,23
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L644
        ;;test10.j(253)   do { write (i); i--; } while (120 != i+100);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,100
        ADD   HL,DE
        LD    A,120
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NZ,L653
        ;;test10.j(254)   p=20;
        LD    A,20
        LD    L,A
        LD    H,0
        LD    (05002H),HL
        ;;test10.j(255)   do { write (p); p--; i++; } while (122 > i+100);
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,100
        ADD   HL,DE
        LD    A,122
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L665
        ;;test10.j(256)   do { write (p); p--; i++; } while (123 >= i+100);
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,100
        ADD   HL,DE
        LD    A,123
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    NC,L675
        ;;test10.j(257)   i=16;
        LD    A,16
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(258)   do { write (i); i--; } while (114 <  i+100);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,100
        ADD   HL,DE
        LD    A,114
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    C,L688
        ;;test10.j(259)   do { write (i); i--; } while (113 <= i+100);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,100
        ADD   HL,DE
        LD    A,113
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        JP    Z,L697
        ;;test10.j(260)   // constant - acc
        ;;test10.j(261)   // integer - byte
        ;;test10.j(262)   // not relevant
        ;;test10.j(263) 
        ;;test10.j(264)   // constant - acc
        ;;test10.j(265)   // integer - integer
        ;;test10.j(266)   i=12;
        LD    A,12
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(267)   do { write (i); i--; } while (1011 == i+1000);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1011
        OR    A
        SBC   HL,DE
        JP    Z,L715
        ;;test10.j(268)   //i=10
        ;;test10.j(269)   do { write (i); i--; } while (1008 != i+1000);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1008
        OR    A
        SBC   HL,DE
        JP    NZ,L724
        ;;test10.j(270)   //i=8
        ;;test10.j(271)   p=8;
        LD    A,8
        LD    L,A
        LD    H,0
        LD    (05002H),HL
        ;;test10.j(272)   do { write (p); p--; i++; } while (1010 > i+1000);
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1010
        OR    A
        SBC   HL,DE
        JP    C,L736
        ;;test10.j(273)   //i=10; p=6
        ;;test10.j(274)   do { write (p); p--; i++; } while (1011 >= i+1000);
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,(05002H)
        DEC   HL
        LD    (05002H),HL
        LD    HL,(05000H)
        INC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1011
        OR    A
        SBC   HL,DE
        JP    Z,L746
        ;;test10.j(275)   i=4;
        LD    A,4
        LD    L,A
        LD    H,0
        LD    (05000H),HL
        ;;test10.j(276)   do { write (i); i--; } while (1002 <  i+1000);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1002
        OR    A
        SBC   HL,DE
        JP    Z,$+5
        JP    C,L758
        ;;test10.j(277)   //i=2;
        ;;test10.j(278)   do { write (i); i--; } while (1001 <= i+1000);
        LD    HL,(05000H)
        CALL  writeHL
        LD    HL,(05000H)
        DEC   HL
        LD    (05000H),HL
        LD    HL,(05000H)
        LD    DE,1000
        ADD   HL,DE
        LD    DE,1001
        OR    A
        SBC   HL,DE
        JP    NC,L767
        ;;test10.j(279) 
        ;;test10.j(280)   /************************/
        ;;test10.j(281)   // constant - constant
        ;;test10.j(282)   // not relevant
        ;;test10.j(283)   write(0);
        LD    A,0
        CALL  writeA
        ;;test10.j(284) }
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
