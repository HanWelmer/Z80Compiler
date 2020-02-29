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
L0:     ;/*
L1:     ; * A small program in the miniJava language.
L2:     ; * Test 8-bit and 16-bit expressions.
L3:     ; */
L4:     ;class Test8And16BitExpressions {
L5:     ;  write(0);         // 0
L6:     ;  //LD    A,0
L7:     ;  //CALL  writeA
L8:     ;  //OK
L9:     ;
L10:    ;  /*********************/
L11:    ;  /* Single term 8-bit */
L12:    ;  /*********************/
L13:    ;  byte b = 1;
        LD    A,0
        CALL  writeA
        LD    A,1
        LD    (05000H),A
L18:    ;  byte c = 4;
        LD    A,4
        LD    (05001H),A
L21:    ;  write(b);         // 1
L22:    ;  //LD    A,1
L23:    ;  //LD    (04000H),A
L24:    ;  //LD    A,(04000H)
L25:    ;  //CALL  writeA
L26:    ;  //OK
L27:    ;
L28:    ;  /************************/
L29:    ;  /* Dual term addition   */
L30:    ;  /************************/
L31:    ;  write(0 + 2);     // 2
        LD    A,(05000H)
        CALL  writeA
        LD    A,0
        ADD   A,2
L36:    ;  write(b + 2);     // 3
        CALL  writeA
        LD    A,(05000H)
        ADD   A,2
L40:    ;  write(3 + b);     // 4
        CALL  writeA
        LD    A,3
        LD    B,A
        LD    A,(05000H)
        ADD   A,B
L44:    ;  write(b + c);     // 5
        CALL  writeA
        LD    A,(05000H)
        LD    B,A
        LD    A,(05001H)
        ADD   A,B
L48:    ;
L49:    ;  c = 4 + 2;
        CALL  writeA
        LD    A,4
        ADD   A,2
        LD    (05001H),A
L54:    ;  write(c);         // 6
L55:    ;  c = b + 6;
        LD    A,(05001H)
        CALL  writeA
        LD    A,(05000H)
        ADD   A,6
        LD    (05001H),A
L61:    ;  write(c);         // 7
L62:    ;  c = 7 + b;
        LD    A,(05001H)
        CALL  writeA
        LD    A,7
        LD    B,A
        LD    A,(05000H)
        ADD   A,B
        LD    (05001H),A
L68:    ;  write(c);         // 8
L69:    ;  c = b + c;
        LD    A,(05001H)
        CALL  writeA
        LD    A,(05000H)
        LD    B,A
        LD    A,(05001H)
        ADD   A,B
        LD    (05001H),A
L75:    ;  write(c);         // 9
L76:    ;
L77:    ;
L78:    ;  int i = 10;
        LD    A,(05001H)
        CALL  writeA
        LD    A,10
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L84:    ;  write(i);         // 10
L85:    ;  //LD    A,10
L86:    ;  //LD    L,A
L87:    ;  //LD    H,0
L88:    ;  //LD    (04004H),HL
L89:    ;  //OK
L90:    ;  
L91:    ;  write(i + 1);     // 11
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,(05002H)
        LD    A,1
        LD    E,A
        LD    D,0
        ADD   HL,DE
L97:    ;  write(2 + i);     // 12
        CALL  writeHL
        LD    A,2
        LD    L,A
        LD    H,0
        LD    DE,(05002H)
        ADD   HL,DE
L102:   ;  b = 3;
        CALL  writeHL
        LD    A,3
        LD    (05000H),A
L106:   ;  write(i + b);     // 13
        LD    HL,(05002H)
        LD    A,(05000H)
        LD    E,A
        LD    D,0
        ADD   HL,DE
L110:   ;  b++; //4
        CALL  writeHL
        LD    HL,(05000H)
        INC   (HL)
L113:   ;  write(b + i);     // 14
        LD    A,(05000H)
        LD    L,A
        LD    H,0
        LD    DE,(05002H)
        ADD   HL,DE
L117:   ;
L118:   ;  int j = i + 5;    // 15
        CALL  writeHL
        LD    HL,(05002H)
        LD    A,5
        LD    E,A
        LD    D,0
        ADD   HL,DE
        LD    (05004H),HL
L124:   ;  write(j);
L125:   ;  j = 6 + i;        // 16
        LD    HL,(05004H)
        CALL  writeHL
        LD    A,6
        LD    L,A
        LD    H,0
        LD    DE,(05002H)
        ADD   HL,DE
        LD    (05004H),HL
L132:   ;  write(j);
L133:   ;  j = 7;
        LD    HL,(05004H)
        CALL  writeHL
        LD    A,7
        LD    L,A
        LD    H,0
        LD    (05004H),HL
L139:   ;  j = i + j;        // 17
        LD    HL,(05002H)
        LD    DE,(05004H)
        ADD   HL,DE
        LD    (05004H),HL
L143:   ;  write(j);
L144:   ;
L145:   ;  /*************************/
L146:   ;  /* Dual term subtraction */
L147:   ;  /*************************/
L148:   ;  b = 33;
        LD    HL,(05004H)
        CALL  writeHL
        LD    A,33
        LD    (05000H),A
L153:   ;  c = 12;
        LD    A,12
        LD    (05001H),A
L156:   ;  write(19 - 1);    // 18
        LD    A,19
        SUB   A,1
L159:   ;  write(b - 14);    // 19
        CALL  writeA
        LD    A,(05000H)
        SUB   A,14
L163:   ;  write(53 - b);    // 20
        CALL  writeA
        LD    A,53
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L167:   ;  write(b - c);     // 21
        CALL  writeA
        LD    A,(05000H)
        LD    B,A
        LD    A,(05001H)
        SUB   A,B
L171:   ;
L172:   ;  c = 24 - 2;
        CALL  writeA
        LD    A,24
        SUB   A,2
        LD    (05001H),A
L177:   ;  write(c);         // 22
L178:   ;  c = b - 10;
        LD    A,(05001H)
        CALL  writeA
        LD    A,(05000H)
        SUB   A,10
        LD    (05001H),A
L184:   ;  write(c);         // 23
L185:   ;  c = 57 - b;
        LD    A,(05001H)
        CALL  writeA
        LD    A,57
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
        LD    (05001H),A
L191:   ;  write(c);         // 24
L192:   ;  c = 8;
        LD    A,(05001H)
        CALL  writeA
        LD    A,8
        LD    (05001H),A
L197:   ;  c = b - c;
        LD    A,(05000H)
        LD    B,A
        LD    A,(05001H)
        SUB   A,B
        LD    (05001H),A
L201:   ;  write(c);         // 25
L202:   ;
L203:   ;  i = 40;
        LD    A,(05001H)
        CALL  writeA
        LD    A,40
        LD    L,A
        LD    H,0
        LD    (05002H),HL
L209:   ;  write(i - 14);    // 26
        LD    HL,(05002H)
        LD    A,14
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L213:   ;  write(67 - i);    // 27
        CALL  writeHL
        LD    A,67
        LD    L,A
        LD    H,0
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L218:   ;  b = 12;
        CALL  writeHL
        LD    A,12
        LD    (05000H),A
L222:   ;  write(i - b);     // 28
        LD    HL,(05002H)
        LD    A,(05000H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L226:   ;  b = 69;
        CALL  writeHL
        LD    A,69
        LD    (05000H),A
L230:   ;  write(b - i);     // 29
        LD    A,(05000H)
        LD    L,A
        LD    H,0
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L234:   ;
L235:   ;  j = i - 10;
        CALL  writeHL
        LD    HL,(05002H)
        LD    A,10
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        LD    (05004H),HL
L241:   ;  write(j);         // 30
L242:   ;  j = 71 - i;
        LD    HL,(05004H)
        CALL  writeHL
        LD    A,71
        LD    L,A
        LD    H,0
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
        LD    (05004H),HL
L249:   ;  write(j);         // 31
L250:   ;  j = 8;
        LD    HL,(05004H)
        CALL  writeHL
        LD    A,8
        LD    L,A
        LD    H,0
        LD    (05004H),HL
L256:   ;  j = i - j;
        LD    HL,(05002H)
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
        LD    (05004H),HL
L260:   ;  write(j);         // 32
L261:   ;  
L262:   ;  /****************************/
L263:   ;  /* Dual term multiplication */
L264:   ;  /****************************/
L265:   ;  write(3 * 11);    // 33
        LD    HL,(05004H)
        CALL  writeHL
        LD    A,3
        LD    B,A
        LD    C,11
        MLT   BC
        LD    A,C
L270:   ;  b = 17;
        CALL  writeA
        LD    A,17
        LD    (05000H),A
L274:   ;  write(b * 2);     // 34
        LD    A,(05000H)
        LD    B,A
        LD    C,2
        MLT   BC
        LD    A,C
L277:   ;  b = 7;
        CALL  writeA
        LD    A,7
        LD    (05000H),A
L281:   ;  write(5 * b);     // 35
        LD    A,5
        LD    B,A
        LD    A,(05000H)
        LD    C,A
        MLT   BC
        LD    A,C
L284:   ;  b = 2;
        CALL  writeA
        LD    A,2
        LD    (05000H),A
L288:   ;  c = 18;
        LD    A,18
        LD    (05001H),A
L291:   ;  write(b * c);     // 36
        LD    A,(05000H)
        LD    B,A
        LD    A,(05001H)
        LD    C,A
        MLT   BC
        LD    A,C
L294:   ;  
L295:   ;  c = 37 * 1;
        CALL  writeA
        LD    A,37
        LD    B,A
        LD    C,1
        MLT   BC
        LD    A,C
        LD    (05001H),A
L300:   ;  write(c);         // 37
L301:   ;  b = 2;
        LD    A,(05001H)
        CALL  writeA
        LD    A,2
        LD    (05000H),A
L306:   ;  c = b * 19;
        LD    A,(05000H)
        LD    B,A
        LD    C,19
        MLT   BC
        LD    A,C
        LD    (05001H),A
L310:   ;  write(c);         // 38
L311:   ;  b = 3;
        LD    A,(05001H)
        CALL  writeA
        LD    A,3
        LD    (05000H),A
L316:   ;  c = 13 * b;
        LD    A,13
        LD    B,A
        LD    A,(05000H)
        LD    C,A
        MLT   BC
        LD    A,C
        LD    (05001H),A
L320:   ;  write(c);         // 39
L321:   ;  b = 5;
        LD    A,(05001H)
        CALL  writeA
        LD    A,5
        LD    (05000H),A
L326:   ;  c = 8;
        LD    A,8
        LD    (05001H),A
L329:   ;  c = b * c;
        LD    A,(05000H)
        LD    B,A
        LD    A,(05001H)
        LD    C,A
        MLT   BC
        LD    A,C
        LD    (05001H),A
L333:   ;  write(c);         // 40
L334:   ;
L335:   ;  /**********************/
L336:   ;  /* Dual term division */
L337:   ;  /**********************/
L338:   ;  write(123 / 3);   // 41
        LD    A,(05001H)
        CALL  writeA
        LD    A,123
        LD    C,A
        LD    A,3
        CALL  div8
L343:   ;  b = 126;
        CALL  writeA
        LD    A,126
        LD    (05000H),A
L347:   ;  write(b / 3);     // 42
        LD    A,(05000H)
        LD    C,A
        LD    A,3
        CALL  div8
L350:   ;  b = 3;
        CALL  writeA
        LD    A,3
        LD    (05000H),A
L354:   ;  write(129 / b);   // 43
        LD    A,129
        LD    C,A
        LD    A,(05000H)
        CALL  div8
L357:   ;  b = 132;
        CALL  writeA
        LD    A,132
        LD    (05000H),A
L361:   ;  c = 3;
        LD    A,3
        LD    (05001H),A
L364:   ;  write(b / c);     // 44
        LD    A,(05000H)
        LD    C,A
        LD    A,(05001H)
        CALL  div8
L367:   ;  
L368:   ;  c = 135 / 3;
        CALL  writeA
        LD    A,135
        LD    C,A
        LD    A,3
        CALL  div8
        LD    (05001H),A
L373:   ;  write(c);         // 45
L374:   ;  b = 138;
        LD    A,(05001H)
        CALL  writeA
        LD    A,138
        LD    (05000H),A
L379:   ;  c = b / 3;
        LD    A,(05000H)
        LD    C,A
        LD    A,3
        CALL  div8
        LD    (05001H),A
L383:   ;  write(c);         // 46
L384:   ;  b = 3;
        LD    A,(05001H)
        CALL  writeA
        LD    A,3
        LD    (05000H),A
L389:   ;  c = 141 / b;
        LD    A,141
        LD    C,A
        LD    A,(05000H)
        CALL  div8
        LD    (05001H),A
L393:   ;  write(c);         // 47
L394:   ;  b = 144;
        LD    A,(05001H)
        CALL  writeA
        LD    A,144
        LD    (05000H),A
L399:   ;  c = 3;
        LD    A,3
        LD    (05001H),A
L402:   ;  c = b / c;
        LD    A,(05000H)
        LD    C,A
        LD    A,(05001H)
        CALL  div8
        LD    (05001H),A
L406:   ;  write(c);         // 48
L407:   ;
L408:   ;  /**********************/
L409:   ;  /* Single term read   */
L410:   ;  /**********************/
L411:   ;  write(read);      // 49
        LD    A,(05001H)
        CALL  writeA
        CALL  read
L415:   ;  b = read;
        CALL  writeHL
        CALL  read
        LD    A,L
        LD    (05000H),A
L420:   ;  write(b);         // 50
L421:   ;
L422:   ;  /**********************/
L423:   ;  /* Dual term read     */
L424:   ;  /**********************/
L425:   ;  write(read + 1);  // 50 + 1 = 51
        LD    A,(05000H)
        CALL  writeA
        CALL  read
        LD    A,1
        LD    E,A
        LD    D,0
        ADD   HL,DE
L431:   ;  write(2 + read);  // 2 + 50 = 52
        CALL  writeHL
        LD    A,2
        CALL  read
        PUSH  HL
        LD    L,A
        LD    H,0
        POP   DE
        ADD   HL,DE
L437:   ;  write(read - 2);  // 55 - 2 = 53
        CALL  writeHL
        CALL  read
        LD    A,2
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L442:   ;  write(109 - read);  // 109 - 55 = 54
        CALL  writeHL
        LD    A,109
        CALL  read
        PUSH  HL
        LD    L,A
        LD    H,0
        POP   DE
        OR    A
        SBC   HL,DE
L448:   ;  write(read * 1);  // 55 * 1 = 55
        CALL  writeHL
        CALL  read
        LD    A,1
        CALL  mul16_8
L453:   ;  write(2 * read);  // 2 * 55 = 110
        CALL  writeHL
        LD    A,2
        CALL  read
        PUSH  HL
        LD    L,A
        LD    H,0
        POP   DE
        CALL  mul16
L459:   ;  write(read / 2);  // 110 / 2 = 55
        CALL  writeHL
        CALL  read
        LD    A,2
        CALL  div16_8
L464:   ;  write(12 / read);  // 12 / 3 = 4
        CALL  writeHL
        LD    A,12
        CALL  read
        PUSH  HL
        LD    L,A
        LD    H,0
        POP   DE
        CALL  div16
L470:   ;
L471:   ;  /*************************/
L472:   ;  /* possible loss of data */
L473:   ;  /*************************/
L474:   ;  b = 507;
        CALL  writeHL
        LD    HL,507
        LD    A,L
        LD    (05000H),A
L479:   ;  write(b);         // 251
L480:   ;  i = 508;
        LD    A,(05000H)
        CALL  writeA
        LD    HL,508
        LD    (05002H),HL
L485:   ;  b = i;
        LD    HL,(05002H)
        LD    A,L
        LD    (05000H),A
L489:   ;  write(b);         // 252
L490:   ;
L491:   ;  b = b - 505;
        LD    A,(05000H)
        CALL  writeA
        LD    A,(05000H)
        LD    L,A
        LD    H,0
        LD    DE,505
        OR    A
        SBC   HL,DE
        LD    A,L
        LD    (05000H),A
L499:   ;  write(b);         // 252 - 505 = -253
L500:   ;  i = i + 5;
        LD    A,(05000H)
        CALL  writeA
        LD    HL,(05002H)
        LD    A,5
        LD    E,A
        LD    D,0
        ADD   HL,DE
        LD    (05002H),HL
L507:   ;  b = b - i;
        LD    A,(05000H)
        LD    L,A
        LD    H,0
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
        LD    A,L
        LD    (05000H),A
L513:   ;  write(b);         // -233 - 11 = -254
L514:   ;  
L515:   ;  b = 255;
        LD    A,(05000H)
        CALL  writeA
        LD    A,255
        LD    (05000H),A
L520:   ;  write(b);         // 255
L521:   ;  //LD    A,255
L522:   ;  //LD    (04001H),A
L523:   ;  //LD    A,(04001H)
L524:   ;  //CALL  writeA
L525:   ;  //OK
L526:   ;
L527:   ;  /**********************/
L528:   ;  /* Single term 16-bit */
L529:   ;  /**********************/
L530:   ;  i = 256;
        LD    A,(05000H)
        CALL  writeA
        LD    HL,256
        LD    (05002H),HL
L535:   ;  write(i);         // 256
L536:   ;  //LD    HL,256
L537:   ;  //LD    (04006H),HL
L538:   ;  //LD    HL,(04006H)
L539:   ;  //CALL  writeHL
L540:   ;  //OK
L541:   ;
L542:   ;  write(1000);      // 1000
        LD    HL,(05002H)
        CALL  writeHL
L545:   ;  j = 1001;
        LD    HL,1000
        CALL  writeHL
        LD    HL,1001
        LD    (05004H),HL
L550:   ;  write(j);         // 1001
L551:   ;
L552:   ;  /************************/
L553:   ;  /* Dual term addition   */
L554:   ;  /************************/
L555:   ;  write(1000 + 2);  // 1002
        LD    HL,(05004H)
        CALL  writeHL
        LD    HL,1000
        LD    A,2
        LD    E,A
        LD    D,0
        ADD   HL,DE
L561:   ;  write(3 + 1000);  // 1003
        CALL  writeHL
        LD    A,3
        LD    L,A
        LD    H,0
        LD    DE,1000
        ADD   HL,DE
L566:   ;  write(500 + 504); // 1004
        CALL  writeHL
        LD    HL,500
        LD    DE,504
        ADD   HL,DE
L570:   ;  i = 1000 + 5;
        CALL  writeHL
        LD    HL,1000
        LD    A,5
        LD    E,A
        LD    D,0
        ADD   HL,DE
        LD    (05002H),HL
L576:   ;  write(i);         // 1005
L577:   ;  i = 6 + 1000;
        LD    HL,(05002H)
        CALL  writeHL
        LD    A,6
        LD    L,A
        LD    H,0
        LD    DE,1000
        ADD   HL,DE
        LD    (05002H),HL
L584:   ;  write(i);         // 1006
L585:   ;  i = 500 + 507;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,500
        LD    DE,507
        ADD   HL,DE
        LD    (05002H),HL
L591:   ;  write(i);         // 1007
L592:   ;  
L593:   ;  j = 1000;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,1000
        LD    (05004H),HL
L598:   ;  b = 10;
        LD    A,10
        LD    (05000H),A
L601:   ;  i = 514;
        LD    HL,514
        LD    (05002H),HL
L604:   ;  write(j + 8);     // 1008
        LD    HL,(05004H)
        LD    A,8
        LD    E,A
        LD    D,0
        ADD   HL,DE
L608:   ;  write(9 + j);     // 1009
        CALL  writeHL
        LD    A,9
        LD    L,A
        LD    H,0
        LD    DE,(05004H)
        ADD   HL,DE
L613:   ;  write(j + b);     // 1010
        CALL  writeHL
        LD    HL,(05004H)
        LD    A,(05000H)
        LD    E,A
        LD    D,0
        ADD   HL,DE
L618:   ;  b++;
        CALL  writeHL
        LD    HL,(05000H)
        INC   (HL)
L621:   ;  write(b + j);     // 1011
        LD    A,(05000H)
        LD    L,A
        LD    H,0
        LD    DE,(05004H)
        ADD   HL,DE
L625:   ;  j = 500;
        CALL  writeHL
        LD    HL,500
        LD    (05004H),HL
L629:   ;  write(j + 512);   // 1012
        LD    HL,(05004H)
        LD    DE,512
        ADD   HL,DE
L632:   ;  write(513 + j);   // 1013
        CALL  writeHL
        LD    HL,513
        LD    DE,(05004H)
        ADD   HL,DE
L636:   ;  write(i + j);     // 1014
        CALL  writeHL
        LD    HL,(05002H)
        LD    DE,(05004H)
        ADD   HL,DE
L640:   ;  
L641:   ;  j = 1000;
        CALL  writeHL
        LD    HL,1000
        LD    (05004H),HL
L645:   ;  b = 17;
        LD    A,17
        LD    (05000H),A
L648:   ;  i = j + 15;
        LD    HL,(05004H)
        LD    A,15
        LD    E,A
        LD    D,0
        ADD   HL,DE
        LD    (05002H),HL
L653:   ;  write(i);         // 1015
L654:   ;  i = 16 + j;
        LD    HL,(05002H)
        CALL  writeHL
        LD    A,16
        LD    L,A
        LD    H,0
        LD    DE,(05004H)
        ADD   HL,DE
        LD    (05002H),HL
L661:   ;  write(i);         // 1016
L662:   ;  i = j + b;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,(05004H)
        LD    A,(05000H)
        LD    E,A
        LD    D,0
        ADD   HL,DE
        LD    (05002H),HL
L669:   ;  write(i);         // 1017
L670:   ;  b++;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,(05000H)
        INC   (HL)
L674:   ;  i = b + j;
        LD    A,(05000H)
        LD    L,A
        LD    H,0
        LD    DE,(05004H)
        ADD   HL,DE
        LD    (05002H),HL
L679:   ;  write(i);         // 1018
L680:   ;  j = 500;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,500
        LD    (05004H),HL
L685:   ;  i = j + 519;
        LD    HL,(05004H)
        LD    DE,519
        ADD   HL,DE
        LD    (05002H),HL
L689:   ;  write(i);         // 1019
L690:   ;  i = 520 + j;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,520
        LD    DE,(05004H)
        ADD   HL,DE
        LD    (05002H),HL
L696:   ;  write(i);         // 1020
L697:   ;  i = 521;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,521
        LD    (05002H),HL
L702:   ;  i = i + j;
        LD    HL,(05002H)
        LD    DE,(05004H)
        ADD   HL,DE
        LD    (05002H),HL
L706:   ;  write(i);         // 1021
L707:   ;  
L708:   ;  /*************************/
L709:   ;  /* Dual term subtraction */
L710:   ;  /*************************/
L711:   ;  write(1024 - 2);  // 1022
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,1024
        LD    A,2
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L717:   ;  write(1523 - 500);// 1023
        CALL  writeHL
        LD    HL,1523
        LD    DE,500
        OR    A
        SBC   HL,DE
L721:   ;  i = 1030 - 6;
        CALL  writeHL
        LD    HL,1030
        LD    A,6
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        LD    (05002H),HL
L727:   ;  write(i);         // 1024
L728:   ;  i = 1525 - 500;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,1525
        LD    DE,500
        OR    A
        SBC   HL,DE
        LD    (05002H),HL
L734:   ;  write(i);         // 1025
L735:   ;  
L736:   ;  j = 1040;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,1040
        LD    (05004H),HL
L741:   ;  b = 13;
        LD    A,13
        LD    (05000H),A
L744:   ;  i = 3030;
        LD    HL,3030
        LD    (05002H),HL
L747:   ;  write(j - 14);    // 1026
        LD    HL,(05004H)
        LD    A,14
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L751:   ;  write(j - b);     // 1027
        CALL  writeHL
        LD    HL,(05004H)
        LD    A,(05000H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L756:   ;  j = 2000;
        CALL  writeHL
        LD    HL,2000
        LD    (05004H),HL
L760:   ;  write(j - 972);   // 1028
        LD    HL,(05004H)
        LD    DE,972
        OR    A
        SBC   HL,DE
L763:   ;  write(3029 - j);  // 1029
        CALL  writeHL
        LD    HL,3029
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L767:   ;  write(i - j);     // 1030
        CALL  writeHL
        LD    HL,(05002H)
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L771:   ;  
L772:   ;  j = 1050;
        CALL  writeHL
        LD    HL,1050
        LD    (05004H),HL
L776:   ;  b = 18;
        LD    A,18
        LD    (05000H),A
L779:   ;  i = j - 19;
        LD    HL,(05004H)
        LD    A,19
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        LD    (05002H),HL
L784:   ;  write(i);         // 1031
L785:   ;  i = j - b;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,(05004H)
        LD    A,(05000H)
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
        LD    (05002H),HL
L792:   ;  write(i);         // 1032
L793:   ;  j = 2000;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,2000
        LD    (05004H),HL
L798:   ;  i = j - 967;
        LD    HL,(05004H)
        LD    DE,967
        OR    A
        SBC   HL,DE
        LD    (05002H),HL
L802:   ;  write(i);         // 1033
L803:   ;  i = 3034 - j;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,3034
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
        LD    (05002H),HL
L809:   ;  write(i);         // 1034
L810:   ;  i = 3035;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,3035
        LD    (05002H),HL
L815:   ;  i = i - j;
        LD    HL,(05002H)
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
        LD    (05002H),HL
L819:   ;  write(i);         // 1035
L820:   ;  
L821:   ;  /****************************/
L822:   ;  /* Dual term multiplication */
L823:   ;  /****************************/
L824:   ;  write(518 * 2);   // 1036
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,518
        LD    A,2
        CALL  mul16_8
L830:   ;  write(1 * 1037);  // 1037
        CALL  writeHL
        LD    A,1
        LD    L,A
        LD    H,0
        LD    DE,1037
        CALL  mul16
L835:   ;  write(500 * 504 - 54354); // 1038 = 55392 - 54354
        CALL  writeHL
        LD    HL,500
        LD    DE,504
        CALL  mul16
        LD    DE,54354
        OR    A
        SBC   HL,DE
L840:   ;
L841:   ;  i = 1039 * 1;
        CALL  writeHL
        LD    HL,1039
        LD    A,1
        CALL  mul16_8
        LD    (05002H),HL
L847:   ;  write(i);         // 1039
L848:   ;  i = 2 * 520;
        LD    HL,(05002H)
        CALL  writeHL
        LD    A,2
        LD    L,A
        LD    H,0
        LD    DE,520
        CALL  mul16
        LD    (05002H),HL
L855:   ;  write(i);         // 1040
L856:   ;
L857:   ;  i = 1041;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,1041
        LD    (05002H),HL
L862:   ;  write(i * 1);     // 1041
        LD    HL,(05002H)
        LD    A,1
        CALL  mul16_8
L866:   ;  i = 521;
        CALL  writeHL
        LD    HL,521
        LD    (05002H),HL
L870:   ;  write(2 * i);     // 1042
        LD    A,2
        LD    L,A
        LD    H,0
        LD    DE,(05002H)
        CALL  mul16
L874:   ;
L875:   ;  i = 1043;
        CALL  writeHL
        LD    HL,1043
        LD    (05002H),HL
L879:   ;  i = i * 1;
        LD    HL,(05002H)
        LD    A,1
        CALL  mul16_8
        LD    (05002H),HL
L884:   ;  write(i);         // 1043
L885:   ;  i = 522;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,522
        LD    (05002H),HL
L890:   ;  i = 2 * i;
        LD    A,2
        LD    L,A
        LD    H,0
        LD    DE,(05002H)
        CALL  mul16
        LD    (05002H),HL
L895:   ;  write(i);         // 1044
L896:   ;
L897:   ;  i = 500 * 504 - 54347; // 1045 = 55392 - 54347
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,500
        LD    DE,504
        CALL  mul16
        LD    DE,54347
        OR    A
        SBC   HL,DE
        LD    (05002H),HL
L904:   ;  write(i);         // 1045
L905:   ;  i = 500;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,500
        LD    (05002H),HL
L910:   ;  i = i * 504 - 54346;
        LD    HL,(05002H)
        LD    DE,504
        CALL  mul16
        LD    DE,54346
        OR    A
        SBC   HL,DE
        LD    (05002H),HL
L915:   ;  write(i);         // 1046
L916:   ;  i = 504;
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,504
        LD    (05002H),HL
L921:   ;  i = 500 * i - 54345;
        LD    HL,500
        LD    DE,(05002H)
        CALL  mul16
        LD    DE,54345
        OR    A
        SBC   HL,DE
        LD    (05002H),HL
L926:   ;  write(i);         // 1047
L927:   ;  /************/
L928:   ;  /* Overflow */
L929:   ;  /************/
L930:   ;  write(300 * 301); // 90.300 % 65536 = 24.764
        LD    HL,(05002H)
        CALL  writeHL
        LD    HL,300
        LD    DE,301
        CALL  mul16
L935:   ;  i = 300 * 302;
        CALL  writeHL
        LD    HL,300
        LD    DE,302
        CALL  mul16
        LD    (05002H),HL
L940:   ;  write(i);         // 90.600 % 65536 = 25.064
L941:   ;
L942:   ;}
        LD    HL,(05002H)
        CALL  writeHL
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
