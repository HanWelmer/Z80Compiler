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
        ;;test5.j(5)   write (134);
        ;acc8= constant 134
        LD    A,134
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(6)   /************************/
        ;;test5.j(7)   // global variable within if scope
        ;;test5.j(8)   byte b = 133;
        ;acc8= constant 133
        LD    A,133
        ;acc8=> variable 0
        LD    (05000H),A
        ;;test5.j(9)   if (b>132) {
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8Comp constant 132
        SUB   A,132
        ;brle 34
        JP    Z,L34
        ;;test5.j(10)     int j = 1001;
        ;acc16= constant 1001
        LD    HL,1001
        ;acc16=> variable 1
        LD    (05001H),HL
        ;;test5.j(11)     byte c = b;
        ;acc8= variable 0
        LD    A,(05000H)
        ;acc8=> variable 3
        LD    (05003H),A
        ;;test5.j(12)     byte d = c;
        ;acc8= variable 3
        LD    A,(05003H)
        ;acc8=> variable 4
        LD    (05004H),A
        ;;test5.j(13)     b--;
        ;decr8 variable 0
        LD    HL,(05000H)
        DEC   (HL)
        ;;test5.j(14)     write (c);
        ;acc8= variable 3
        LD    A,(05003H)
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(15)   } else {
        ;br 39
        JP    L39
        ;;test5.j(16)     write(0);
        ;acc8= constant 0
        LD    A,0
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(17)   }
        ;;test5.j(18)   /************************/
        ;;test5.j(19)   int zero = 0;
        ;acc8= constant 0
        LD    A,0
        ;acc8=> variable 1
        LD    L,A
        LD    H,0
        LD    (05001H),HL
        ;;test5.j(20)   int one = 1;
        ;acc8= constant 1
        LD    A,1
        ;acc8=> variable 3
        LD    L,A
        LD    H,0
        LD    (05003H),HL
        ;;test5.j(21)   int three = 3;
        ;acc8= constant 3
        LD    A,3
        ;acc8=> variable 5
        LD    L,A
        LD    H,0
        LD    (05005H),HL
        ;;test5.j(22)   int four = 4;
        ;acc8= constant 4
        LD    A,4
        ;acc8=> variable 7
        LD    L,A
        LD    H,0
        LD    (05007H),HL
        ;;test5.j(23)   int five = 5;
        ;acc8= constant 5
        LD    A,5
        ;acc8=> variable 9
        LD    L,A
        LD    H,0
        LD    (05009H),HL
        ;;test5.j(24)   int twelve = 12;
        ;acc8= constant 12
        LD    A,12
        ;acc8=> variable 11
        LD    L,A
        LD    H,0
        LD    (0500BH),HL
        ;;test5.j(25)   byte byteOne = 1;
        ;acc8= constant 1
        LD    A,1
        ;acc8=> variable 13
        LD    (0500DH),A
        ;;test5.j(26)   byte byteSix = 262;
        ;acc16= constant 262
        LD    HL,262
        ;acc16=> variable 14
        LD    A,L
        LD    (0500EH),A
        ;;test5.j(27)   if (4 == zero + twelve/(1+2)) write(132);
        ;acc16= variable 1
        LD    HL,(05001H)
        ;<acc16= variable 11
        PUSH  HL
        LD    HL,(0500BH)
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc16+ unstack16
        POP   DE
        ADD   HL,DE
        ;acc8= constant 4
        LD    A,4
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brne 75
        JP    NZ,L75
        ;acc8= constant 132
        LD    A,132
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(28)   if (four == 0 + 12/(one + 2)) write(131);
        ;acc8= constant 0
        LD    A,0
        ;<acc8= constant 12
        PUSH  AF
        LD    A,12
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 acc8
        EX    DE,HL
        CALL  div8_16
        ;acc16+ unstack8
        POP   DE
        LD    D,0
        ADD   HL,DE
        ;acc16Comp variable 7
        LD    DE,(05007H)
        OR    A
        SBC   HL,DE
        ;brne 86
        JP    NZ,L86
        ;acc8= constant 131
        LD    A,131
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(29)   if (four == 0 + 12/(byteOne + 2)) write(130);
        ;acc8= constant 0
        LD    A,0
        ;<acc8= constant 12
        PUSH  AF
        LD    A,12
        ;<acc8= variable 13
        PUSH  AF
        LD    A,(0500DH)
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8+ unstack8
        POP   BC
        ADD   A,B
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brne 98
        JP    NZ,L98
        ;acc8= constant 130
        LD    A,130
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(30)   if (four == 0 + 12/(1 + 2)) write(129);
        ;acc8= constant 0
        LD    A,0
        ;<acc8= constant 12
        PUSH  AF
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8+ unstack8
        POP   BC
        ADD   A,B
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brne 110
        JP    NZ,L110
        ;acc8= constant 129
        LD    A,129
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(31)   if (four == 0 + 12/(1 + 2)) write(128);
        ;acc8= constant 0
        LD    A,0
        ;<acc8= constant 12
        PUSH  AF
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8+ unstack8
        POP   BC
        ADD   A,B
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brne 123
        JP    NZ,L123
        ;acc8= constant 128
        LD    A,128
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(32)   //stack level 2
        ;;test5.j(33)   if (5 >= twelve/(one+2)) write(127);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= constant 5
        LD    A,5
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brlt 133
        JP    C,L133
        ;acc8= constant 127
        LD    A,127
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(34)   if (4 >= twelve/(one+2)) write(126);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= constant 4
        LD    A,4
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brlt 143
        JP    C,L143
        ;acc8= constant 126
        LD    A,126
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(35)   if (4 <= twelve/(one+2)) write(125);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= constant 4
        LD    A,4
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 153
        JP    Z,$+5
        JP    C,L153
        ;acc8= constant 125
        LD    A,125
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(36)   if (3 <= twelve/(one+2)) write(124);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= constant 3
        LD    A,3
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 163
        JP    Z,$+5
        JP    C,L163
        ;acc8= constant 124
        LD    A,124
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(37)   if (5 > twelve/(one+2)) write(123);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= constant 5
        LD    A,5
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brle 173
        JP    Z,L173
        ;acc8= constant 123
        LD    A,123
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(38)   if (2 < twelve/(one+2)) write(122);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= constant 2
        LD    A,2
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brge 183
        JP    NC,L183
        ;acc8= constant 122
        LD    A,122
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(39)   if (3 != twelve/(one+2)) write(121);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= constant 3
        LD    A,3
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;breq 193
        JP    Z,L193
        ;acc8= constant 121
        LD    A,121
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(40)   if (4 == twelve/(one+2)) write(120);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= constant 4
        LD    A,4
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brne 203
        JP    NZ,L203
        ;acc8= constant 120
        LD    A,120
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(41)   if (5 >= 12/(1+2)) write(119);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 5
        SUB   A,5
        ;brgt 212
        JP    Z,$+5
        JP    C,L212
        ;acc8= constant 119
        LD    A,119
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(42)   if (4 >= 12/(1+2)) write(118);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 4
        SUB   A,4
        ;brgt 221
        JP    Z,$+5
        JP    C,L221
        ;acc8= constant 118
        LD    A,118
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(43)   if (4 <= 12/(1+2)) write(117);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 4
        SUB   A,4
        ;brlt 230
        JP    C,L230
        ;acc8= constant 117
        LD    A,117
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(44)   if (3 <= 12/(1+2)) write(116);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 3
        SUB   A,3
        ;brlt 239
        JP    C,L239
        ;acc8= constant 116
        LD    A,116
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(45)   if (5 > 12/(1+2)) write(115);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 5
        SUB   A,5
        ;brge 248
        JP    NC,L248
        ;acc8= constant 115
        LD    A,115
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(46)   if (3 < 12/(1+2)) write(114);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 3
        SUB   A,3
        ;brle 257
        JP    Z,L257
        ;acc8= constant 114
        LD    A,114
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(47)   if (3 != 12/(1+2)) write(113);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 3
        SUB   A,3
        ;breq 266
        JP    Z,L266
        ;acc8= constant 113
        LD    A,113
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(48)   if (4 == 12/(1+2)) write(112);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 4
        SUB   A,4
        ;brne 275
        JP    NZ,L275
        ;acc8= constant 112
        LD    A,112
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(49)   if (1+4 >= twelve/(one+2)) write(111);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 4
        ADD   A,4
        ;<acc8
        PUSH AF
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= unstack8
        POP  AF
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brlt 288
        JP    C,L288
        ;acc8= constant 111
        LD    A,111
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(50)   if (1+3 >= twelve/(one+2)) write(110);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 3
        ADD   A,3
        ;<acc8
        PUSH AF
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= unstack8
        POP  AF
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brlt 301
        JP    C,L301
        ;acc8= constant 110
        LD    A,110
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(51)   if (1+3 <= twelve/(one+2)) write(109);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 3
        ADD   A,3
        ;<acc8
        PUSH AF
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= unstack8
        POP  AF
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 314
        JP    Z,$+5
        JP    C,L314
        ;acc8= constant 109
        LD    A,109
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(52)   if (1+2 <= twelve/(one+2)) write(108);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;<acc8
        PUSH AF
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= unstack8
        POP  AF
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 327
        JP    Z,$+5
        JP    C,L327
        ;acc8= constant 108
        LD    A,108
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(53)   if (1+4 > twelve/(one+2)) write(107);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 4
        ADD   A,4
        ;<acc8
        PUSH AF
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= unstack8
        POP  AF
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brle 340
        JP    Z,L340
        ;acc8= constant 107
        LD    A,107
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(54)   if (1+2 < twelve/(one+2)) write(106);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;<acc8
        PUSH AF
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= unstack8
        POP  AF
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brge 353
        JP    NC,L353
        ;acc8= constant 106
        LD    A,106
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(55)   if (1+2 != twelve/(one+2)) write(105);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;<acc8
        PUSH AF
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= unstack8
        POP  AF
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;breq 366
        JP    Z,L366
        ;acc8= constant 105
        LD    A,105
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(56)   if (1+3 == twelve/(one+2)) write(104);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 3
        ADD   A,3
        ;<acc8
        PUSH AF
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc8= unstack8
        POP  AF
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brne 379
        JP    NZ,L379
        ;acc8= constant 104
        LD    A,104
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(57)   if (1+4 >= 12/(1+2)) write(103);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 4
        ADD   A,4
        ;<acc8
        PUSH AF
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
        ;brgt 391
        JP    Z,$+5
        JP    C,L391
        ;acc8= constant 103
        LD    A,103
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(58)   if (1+3 >= 12/(1+2)) write(102);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 3
        ADD   A,3
        ;<acc8
        PUSH AF
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
        ;brgt 403
        JP    Z,$+5
        JP    C,L403
        ;acc8= constant 102
        LD    A,102
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(59)   if (1+3 <= 12/(1+2)) write(101);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 3
        ADD   A,3
        ;<acc8
        PUSH AF
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
        ;brlt 415
        JP    C,L415
        ;acc8= constant 101
        LD    A,101
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(60)   if (1+2 <= 12/(1+2)) write(100);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;<acc8
        PUSH AF
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
        ;brlt 427
        JP    C,L427
        ;acc8= constant 100
        LD    A,100
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(61)   if (1+4 > 12/(1+2)) write(99);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 4
        ADD   A,4
        ;<acc8
        PUSH AF
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
        ;brge 439
        JP    NC,L439
        ;acc8= constant 99
        LD    A,99
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(62)   if (1+2 < 12/(1+2)) write(98);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;<acc8
        PUSH AF
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
        ;brle 451
        JP    Z,L451
        ;acc8= constant 98
        LD    A,98
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(63)   if (1+2 != 12/(1+2)) write(97);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;<acc8
        PUSH AF
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
        ;breq 463
        JP    Z,L463
        ;acc8= constant 97
        LD    A,97
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(64)   if (1+3 == 12/(1+2)) write(96);
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 3
        ADD   A,3
        ;<acc8
        PUSH AF
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;revAcc8Comp unstack8
        POP   BC
        SUB   A,B
        ;brne 475
        JP    NZ,L475
        ;acc8= constant 96
        LD    A,96
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(65)   if (twelve >= twelve/(one+2)) write(95);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc16Comp variable 11
        LD    DE,(0500BH)
        OR    A
        SBC   HL,DE
        ;brgt 484
        JP    Z,$+5
        JP    C,L484
        ;acc8= constant 95
        LD    A,95
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(66)   if (four >= twelve/(one+2)) write(94);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc16Comp variable 7
        LD    DE,(05007H)
        OR    A
        SBC   HL,DE
        ;brgt 493
        JP    Z,$+5
        JP    C,L493
        ;acc8= constant 94
        LD    A,94
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(67)   if (three <= twelve/(one+2)) write(93);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc16Comp variable 5
        LD    DE,(05005H)
        OR    A
        SBC   HL,DE
        ;brlt 502
        JP    C,L502
        ;acc8= constant 93
        LD    A,93
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(68)   if (four <= twelve/(one+2)) write(92);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc16Comp variable 7
        LD    DE,(05007H)
        OR    A
        SBC   HL,DE
        ;brlt 511
        JP    C,L511
        ;acc8= constant 92
        LD    A,92
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(69)   if (twelve > twelve/(one+2)) write(91);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc16Comp variable 11
        LD    DE,(0500BH)
        OR    A
        SBC   HL,DE
        ;brge 520
        JP    NC,L520
        ;acc8= constant 91
        LD    A,91
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(70)   if (three < twelve/(one+2)) write(90);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc16Comp variable 5
        LD    DE,(05005H)
        OR    A
        SBC   HL,DE
        ;brle 529
        JP    Z,L529
        ;acc8= constant 90
        LD    A,90
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(71)   if (three != twelve/(one+2)) write(89);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc16Comp variable 5
        LD    DE,(05005H)
        OR    A
        SBC   HL,DE
        ;breq 538
        JP    Z,L538
        ;acc8= constant 89
        LD    A,89
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(72)   if (four == twelve/(one+2)) write(88);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;acc16Comp variable 7
        LD    DE,(05007H)
        OR    A
        SBC   HL,DE
        ;brne 547
        JP    NZ,L547
        ;acc8= constant 88
        LD    A,88
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(73)   if (twelve >= 12/(1+2)) write(87);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brlt 557
        JP    C,L557
        ;acc8= constant 87
        LD    A,87
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(74)   if (four >= 12/(1+2)) write(86);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brlt 567
        JP    C,L567
        ;acc8= constant 86
        LD    A,86
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(75)   if (three <= 12/(1+2)) write(85);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 5
        LD    HL,(05005H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 577
        JP    Z,$+5
        JP    C,L577
        ;acc8= constant 85
        LD    A,85
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(76)   if (four <= 12/(1+2)) write(84);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 587
        JP    Z,$+5
        JP    C,L587
        ;acc8= constant 84
        LD    A,84
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(77)   if (twelve > 12/(1+2)) write(83);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brle 597
        JP    Z,L597
        ;acc8= constant 83
        LD    A,83
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(78)   if (three < 12/(1+2)) write(82);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 5
        LD    HL,(05005H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brge 607
        JP    NC,L607
        ;acc8= constant 82
        LD    A,82
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(79)   if (three != 12/(1+2)) write(81);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 5
        LD    HL,(05005H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;breq 617
        JP    Z,L617
        ;acc8= constant 81
        LD    A,81
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(80)   if (four == 12/(1+2)) write(80);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brne 627
        JP    NZ,L627
        ;acc8= constant 80
        LD    A,80
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(81)   if (one+four >= twelve/(one+2)) write(79);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 7
        LD    DE,(05007H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
        ;brgt 639
        JP    Z,$+5
        JP    C,L639
        ;acc8= constant 79
        LD    A,79
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(82)   if (one+three >= twelve/(one+2)) write(78);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 5
        LD    DE,(05005H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
        ;brgt 651
        JP    Z,$+5
        JP    C,L651
        ;acc8= constant 78
        LD    A,78
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(83)   if (one+three <= twelve/(one+2)) write(77);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 5
        LD    DE,(05005H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
        ;brlt 663
        JP    C,L663
        ;acc8= constant 77
        LD    A,77
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(84)   if (one+one <= twelve/(one+2)) write(76);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 3
        LD    DE,(05003H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
        ;brlt 675
        JP    C,L675
        ;acc8= constant 76
        LD    A,76
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(85)   if (one+four > twelve/(one+2)) write(75);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 7
        LD    DE,(05007H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
        ;brge 687
        JP    NC,L687
        ;acc8= constant 75
        LD    A,75
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(86)   if (one+one < twelve/(one+2)) write(74);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 3
        LD    DE,(05003H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
        ;brle 699
        JP    Z,L699
        ;acc8= constant 74
        LD    A,74
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(87)   if (one+four  != twelve/(one+2)) write(73);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 7
        LD    DE,(05007H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
        ;breq 711
        JP    Z,L711
        ;acc8= constant 73
        LD    A,73
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(88)   if (one+three == twelve/(one+2)) write(72);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 5
        LD    DE,(05005H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;<acc16= variable 3
        PUSH  HL
        LD    HL,(05003H)
        ;acc16+ constant 2
        LD    DE,2
        ADD   HL,DE
        ;/acc16 unstack16
        POP   DE
        EX    DE,HL
        CALL  div16
        ;revAcc16Comp unstack16
        POP   DE
        OR    A
        SBC   HL,DE
        ;brne 723
        JP    NZ,L723
        ;acc8= constant 72
        LD    A,72
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(89)   if (one+four >= 12/(1+2)) write(71);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 7
        LD    DE,(05007H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= unstack16
        POP  HL
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brlt 736
        JP    C,L736
        ;acc8= constant 71
        LD    A,71
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(90)   if (one+three >= 12/(1+2)) write(70);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 5
        LD    DE,(05005H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= unstack16
        POP  HL
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brlt 749
        JP    C,L749
        ;acc8= constant 70
        LD    A,70
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(91)   if (one+three <= 12/(1+2)) write(69);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 5
        LD    DE,(05005H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= unstack16
        POP  HL
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 762
        JP    Z,$+5
        JP    C,L762
        ;acc8= constant 69
        LD    A,69
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(92)   if (one+one <= 12/(1+2)) write(68);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 3
        LD    DE,(05003H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= unstack16
        POP  HL
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 775
        JP    Z,$+5
        JP    C,L775
        ;acc8= constant 68
        LD    A,68
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(93)   if (one+four > 12/(1+2)) write(67);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 7
        LD    DE,(05007H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= unstack16
        POP  HL
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brle 788
        JP    Z,L788
        ;acc8= constant 67
        LD    A,67
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(94)   if (one+one < 12/(1+2)) write(66);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 3
        LD    DE,(05003H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= unstack16
        POP  HL
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brge 801
        JP    NC,L801
        ;acc8= constant 66
        LD    A,66
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(95)   if (one+four  != 12/(1+2)) write(65);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 7
        LD    DE,(05007H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= unstack16
        POP  HL
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;breq 814
        JP    Z,L814
        ;acc8= constant 65
        LD    A,65
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(96)   if (one+three == 12/(1+2)) write(64);
        ;acc16= variable 3
        LD    HL,(05003H)
        ;acc16+ variable 5
        LD    DE,(05005H)
        ADD   HL,DE
        ;<acc16
        PUSH HL
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= unstack16
        POP  HL
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brne 829
        JP    NZ,L829
        ;acc8= constant 64
        LD    A,64
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(97)   //stack level 1
        ;;test5.j(98)   //integer-byte
        ;;test5.j(99)   if (four >= 4) write(63);
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc8= constant 4
        LD    A,4
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brlt 836
        JP    C,L836
        ;acc8= constant 63
        LD    A,63
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(100)   if (four >= 12/(1+2)) write(62);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brlt 846
        JP    C,L846
        ;acc8= constant 62
        LD    A,62
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(101)   if (five >= 4) write(61);
        ;acc16= variable 9
        LD    HL,(05009H)
        ;acc8= constant 4
        LD    A,4
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brlt 853
        JP    C,L853
        ;acc8= constant 61
        LD    A,61
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(102)   if (five >= 12/(1+2)) write(60);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 9
        LD    HL,(05009H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brlt 863
        JP    C,L863
        ;acc8= constant 60
        LD    A,60
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(103)   if (four <= 4) write(59);
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc8= constant 4
        LD    A,4
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 870
        JP    Z,$+5
        JP    C,L870
        ;acc8= constant 59
        LD    A,59
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(104)   if (four <= 12/(1+2)) write(58);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 880
        JP    Z,$+5
        JP    C,L880
        ;acc8= constant 58
        LD    A,58
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(105)   if (three <= 4) write(57);
        ;acc16= variable 5
        LD    HL,(05005H)
        ;acc8= constant 4
        LD    A,4
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 887
        JP    Z,$+5
        JP    C,L887
        ;acc8= constant 57
        LD    A,57
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(106)   if (three <= 12/(1+2)) write(56);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 5
        LD    HL,(05005H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brgt 897
        JP    Z,$+5
        JP    C,L897
        ;acc8= constant 56
        LD    A,56
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(107)   if (five > 4) write(55);
        ;acc16= variable 9
        LD    HL,(05009H)
        ;acc8= constant 4
        LD    A,4
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brle 904
        JP    Z,L904
        ;acc8= constant 55
        LD    A,55
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(108)   if (five > 12/(1+2)) write(54);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 9
        LD    HL,(05009H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brle 914
        JP    Z,L914
        ;acc8= constant 54
        LD    A,54
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(109)   if (three < 4) write(53);
        ;acc16= variable 5
        LD    HL,(05005H)
        ;acc8= constant 4
        LD    A,4
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brge 921
        JP    NC,L921
        ;acc8= constant 53
        LD    A,53
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(110)   if (three < 12/(1+2)) write(52);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 5
        LD    HL,(05005H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brge 931
        JP    NC,L931
        ;acc8= constant 52
        LD    A,52
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(111)   if (three != 4) write(51);
        ;acc16= variable 5
        LD    HL,(05005H)
        ;acc8= constant 4
        LD    A,4
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;breq 938
        JP    Z,L938
        ;acc8= constant 51
        LD    A,51
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(112)   if (three != 12/(1+2)) write(50);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 5
        LD    HL,(05005H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;breq 948
        JP    Z,L948
        ;acc8= constant 50
        LD    A,50
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(113)   if (four == 4) write(49);
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc8= constant 4
        LD    A,4
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brne 955
        JP    NZ,L955
        ;acc8= constant 49
        LD    A,49
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(114)   if (four == 12/(1+2)) write(48);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc16CompareAcc8
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
        ;brne 966
        JP    NZ,L966
        ;acc8= constant 48
        LD    A,48
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(115)   //byte-integer
        ;;test5.j(116)   if (4 >= four) write(47);
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc8= constant 4
        LD    A,4
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brlt 973
        JP    C,L973
        ;acc8= constant 47
        LD    A,47
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(117)   if (4 >= twelve/(1+2)) write(46);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc8= constant 4
        LD    A,4
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brlt 983
        JP    C,L983
        ;acc8= constant 46
        LD    A,46
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(118)   if (5 >= four) write(45);
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc8= constant 5
        LD    A,5
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brlt 990
        JP    C,L990
        ;acc8= constant 45
        LD    A,45
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(119)   if (5 >= twelve/(1+2)) write(44);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc8= constant 5
        LD    A,5
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brlt 1000
        JP    C,L1000
        ;acc8= constant 44
        LD    A,44
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(120)   if (4 <= four) write(43);
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc8= constant 4
        LD    A,4
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 1007
        JP    Z,$+5
        JP    C,L1007
        ;acc8= constant 43
        LD    A,43
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(121)   if (4 <= twelve/(1+2)) write(42);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc8= constant 4
        LD    A,4
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 1017
        JP    Z,$+5
        JP    C,L1017
        ;acc8= constant 42
        LD    A,42
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(122)   if (3 <= four) write(41);
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc8= constant 3
        LD    A,3
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 1024
        JP    Z,$+5
        JP    C,L1024
        ;acc8= constant 41
        LD    A,41
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(123)   if (3 <= twelve/(1+2)) write(40);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc8= constant 3
        LD    A,3
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brgt 1034
        JP    Z,$+5
        JP    C,L1034
        ;acc8= constant 40
        LD    A,40
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(124)   if (5 > four) write(39);
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc8= constant 5
        LD    A,5
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brle 1041
        JP    Z,L1041
        ;acc8= constant 39
        LD    A,39
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(125)   if (5 > twelve/(1+2)) write(38);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc8= constant 5
        LD    A,5
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brle 1051
        JP    Z,L1051
        ;acc8= constant 38
        LD    A,38
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(126)   if (3 < four) write(37);
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc8= constant 3
        LD    A,3
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brge 1058
        JP    NC,L1058
        ;acc8= constant 37
        LD    A,37
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(127)   if (3 < twelve/(1+2)) write(36);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc8= constant 3
        LD    A,3
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brge 1068
        JP    NC,L1068
        ;acc8= constant 36
        LD    A,36
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(128)   if (3 != four) write(35);
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc8= constant 3
        LD    A,3
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;breq 1075
        JP    Z,L1075
        ;acc8= constant 35
        LD    A,35
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(129)   if (3 != twelve/(1+2)) write(34);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc8= constant 3
        LD    A,3
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;breq 1085
        JP    Z,L1085
        ;acc8= constant 34
        LD    A,34
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(130)   if (4 == four) write(33);
        ;acc16= variable 7
        LD    HL,(05007H)
        ;acc8= constant 4
        LD    A,4
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brne 1092
        JP    NZ,L1092
        ;acc8= constant 33
        LD    A,33
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(131)   if (4 == twelve/(1+2)) write(32);
        ;acc16= variable 11
        LD    HL,(0500BH)
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc8= constant 4
        LD    A,4
        ;acc8CompareAcc16
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        ;brne 1103
        JP    NZ,L1103
        ;acc8= constant 32
        LD    A,32
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(132)   //integer-integer
        ;;test5.j(133)   if (400 >= 400) write(31);
        ;acc16= constant 400
        LD    HL,400
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
        ;brlt 1109
        JP    C,L1109
        ;acc8= constant 31
        LD    A,31
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(134)   if (400 >= 1200/(1+2)) write(30);
        ;acc16= constant 1200
        LD    HL,1200
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
        ;brgt 1118
        JP    Z,$+5
        JP    C,L1118
        ;acc8= constant 30
        LD    A,30
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(135)   if (500 >= 400) write(29);
        ;acc16= constant 500
        LD    HL,500
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
        ;brlt 1124
        JP    C,L1124
        ;acc8= constant 29
        LD    A,29
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(136)   if (500 >= 1200/(1+2)) write(28);
        ;acc16= constant 1200
        LD    HL,1200
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc16Comp constant 500
        LD    DE,500
        OR    A
        SBC   HL,DE
        ;brgt 1133
        JP    Z,$+5
        JP    C,L1133
        ;acc8= constant 28
        LD    A,28
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(137)   if (400 <= 400) write(27);
        ;acc16= constant 400
        LD    HL,400
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
        ;brgt 1139
        JP    Z,$+5
        JP    C,L1139
        ;acc8= constant 27
        LD    A,27
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(138)   if (400 <= 1200/(1+2)) write(26);
        ;acc16= constant 1200
        LD    HL,1200
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
        ;brlt 1148
        JP    C,L1148
        ;acc8= constant 26
        LD    A,26
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(139)   if (300 <= 400) write(25);
        ;acc16= constant 300
        LD    HL,300
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
        ;brgt 1154
        JP    Z,$+5
        JP    C,L1154
        ;acc8= constant 25
        LD    A,25
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(140)   if (300 <= 1200/(1+2)) write(24);
        ;acc16= constant 1200
        LD    HL,1200
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc16Comp constant 300
        LD    DE,300
        OR    A
        SBC   HL,DE
        ;brlt 1163
        JP    C,L1163
        ;acc8= constant 24
        LD    A,24
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(141)   if (500 > 400) write(23);
        ;acc16= constant 500
        LD    HL,500
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
        ;brle 1169
        JP    Z,L1169
        ;acc8= constant 23
        LD    A,23
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(142)   if (500 > 1200/(1+2)) write(22);
        ;acc16= constant 1200
        LD    HL,1200
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc16Comp constant 500
        LD    DE,500
        OR    A
        SBC   HL,DE
        ;brge 1178
        JP    NC,L1178
        ;acc8= constant 22
        LD    A,22
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(143)   if (300 < 400) write(21);
        ;acc16= constant 300
        LD    HL,300
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
        ;brge 1184
        JP    NC,L1184
        ;acc8= constant 21
        LD    A,21
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(144)   if (300 < 1200/(1+2)) write(20);
        ;acc16= constant 1200
        LD    HL,1200
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc16Comp constant 300
        LD    DE,300
        OR    A
        SBC   HL,DE
        ;brle 1193
        JP    Z,L1193
        ;acc8= constant 20
        LD    A,20
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(145)   if (300 != 400) write(19);
        ;acc16= constant 300
        LD    HL,300
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
        ;breq 1199
        JP    Z,L1199
        ;acc8= constant 19
        LD    A,19
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(146)   if (300 != 1200/(1+2)) write(18);
        ;acc16= constant 1200
        LD    HL,1200
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc16Comp constant 300
        LD    DE,300
        OR    A
        SBC   HL,DE
        ;breq 1208
        JP    Z,L1208
        ;acc8= constant 18
        LD    A,18
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(147)   if (400 == 400) write(17);
        ;acc16= constant 400
        LD    HL,400
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
        ;brne 1214
        JP    NZ,L1214
        ;acc8= constant 17
        LD    A,17
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(148)   if (400 == 1200/(1+2)) write(16);
        ;acc16= constant 1200
        LD    HL,1200
        ;acc8= constant 1
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;acc16/ acc8
        CALL  div16_8
        ;acc16Comp constant 400
        LD    DE,400
        OR    A
        SBC   HL,DE
        ;brne 1224
        JP    NZ,L1224
        ;acc8= constant 16
        LD    A,16
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(149)   //byte-byte
        ;;test5.j(150)   if (4 >= 4) write(15);
        ;acc8= constant 4
        LD    A,4
        ;acc8Comp constant 4
        SUB   A,4
        ;brlt 1230
        JP    C,L1230
        ;acc8= constant 15
        LD    A,15
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(151)   if (4 >= 12/(1+2)) write(14);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 4
        SUB   A,4
        ;brgt 1239
        JP    Z,$+5
        JP    C,L1239
        ;acc8= constant 14
        LD    A,14
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(152)   if (5 >= 4) write(13);
        ;acc8= constant 5
        LD    A,5
        ;acc8Comp constant 4
        SUB   A,4
        ;brlt 1245
        JP    C,L1245
        ;acc8= constant 13
        LD    A,13
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(153)   if (5 >= 12/(1+2)) write(12);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 5
        SUB   A,5
        ;brgt 1254
        JP    Z,$+5
        JP    C,L1254
        ;acc8= constant 12
        LD    A,12
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(154)   if (4 <= 4) write(11);
        ;acc8= constant 4
        LD    A,4
        ;acc8Comp constant 4
        SUB   A,4
        ;brgt 1260
        JP    Z,$+5
        JP    C,L1260
        ;acc8= constant 11
        LD    A,11
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(155)   if (4 <= 12/(1+2)) write(10);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 4
        SUB   A,4
        ;brlt 1269
        JP    C,L1269
        ;acc8= constant 10
        LD    A,10
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(156)   if (3 <= 4) write(9);
        ;acc8= constant 3
        LD    A,3
        ;acc8Comp constant 4
        SUB   A,4
        ;brgt 1275
        JP    Z,$+5
        JP    C,L1275
        ;acc8= constant 9
        LD    A,9
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(157)   if (3 <= 12/(1+2)) write(8);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 3
        SUB   A,3
        ;brlt 1284
        JP    C,L1284
        ;acc8= constant 8
        LD    A,8
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(158)   if (5 > 4) write(7);
        ;acc8= constant 5
        LD    A,5
        ;acc8Comp constant 4
        SUB   A,4
        ;brle 1290
        JP    Z,L1290
        ;acc8= constant 7
        LD    A,7
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(159)   if (5 > 12/(1+2)) write(6);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 5
        SUB   A,5
        ;brge 1299
        JP    NC,L1299
        ;acc8= constant 6
        LD    A,6
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(160)   if (3 < 4) write(5);
        ;acc8= constant 3
        LD    A,3
        ;acc8Comp constant 4
        SUB   A,4
        ;brge 1305
        JP    NC,L1305
        ;acc8= constant 5
        LD    A,5
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(161)   if (3 < 12/(1+2)) write(4);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 3
        SUB   A,3
        ;brle 1314
        JP    Z,L1314
        ;acc8= constant 4
        LD    A,4
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(162)   if (3 != 4) write(3);
        ;acc8= constant 3
        LD    A,3
        ;acc8Comp constant 4
        SUB   A,4
        ;breq 1320
        JP    Z,L1320
        ;acc8= constant 3
        LD    A,3
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(163)   if (3 != 12/(1+2)) write(2);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 3
        SUB   A,3
        ;breq 1329
        JP    Z,L1329
        ;acc8= constant 2
        LD    A,2
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(164)   if (4 == 4) write(1);
        ;acc8= constant 4
        LD    A,4
        ;acc8Comp constant 4
        SUB   A,4
        ;brne 1335
        JP    NZ,L1335
        ;acc8= constant 1
        LD    A,1
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(165)   if (4 == 12/(1+2)) write(0);
        ;acc8= constant 12
        LD    A,12
        ;<acc8= constant 1
        PUSH  AF
        LD    A,1
        ;acc8+ constant 2
        ADD   A,2
        ;/acc8 unstack8
        LD    C,A
        POP   AF
        CALL  div8
        ;acc8Comp constant 4
        SUB   A,4
        ;brne 1344
        JP    NZ,L1344
        ;acc8= constant 0
        LD    A,0
        ;call writeAcc8
        CALL  writeA
        ;;test5.j(166) }
        ;stop
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
