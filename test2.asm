start:
        JP   main
;****************
;write
;write a 16 bit unsigned number to the output
;Input: TOS   = return address
;       TOS+2 = 16 bit unsigned number
;Output:none
;Uses:  HL, AF
;voorlopige code: schrijft getal als 4 hex digits.
;****************
write:
        POP  HL
        EX   (SP),HL
        CALL putHexHL
        CALL  putCRLF
        RET
;****************
;putHexHL
;Print HL register pair as 4 hex digits
;  IN:  HL = word to be printed.
;  OUT: none.
;  USES:AF
;****************
putHexHL:
        LD   A,H
        CALL putHexA
        LD   A,L
        ;fall through to routine putHexA
;****************
;putHexA
;Print A register as 2 hex digits
;  IN:  A = byte to be printed
;  OUT: none.
;  USES:none.
;****************
putHexA:
        PUSH  AF
        RRA
        RRA
        RRA
        RRA
        CALL  putHexA1
        POP   AF
putHexA1:
        PUSH  AF
        AND   A,0x0F
        ADD   A,'0'
        CP    A,'9'+1
        JR    C,$+4
        ADD   A,07
        CALL  putChar
        POP   AF
        RET
;****************
;putMsg
;Print a string, following the return address and zero terminated, via ASCI0.
;  IN:  none.
;  OUT: none.
;  USES:none.
;****************
putMsg:
        EX      (SP),HL     ;save HL and load return address into HL.
        CALL    putStr
        EX      (SP),HL     ;put return address onto stack and restore HL.
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
        LD    A,''
        CALL  putChar
        LD    A,'
'
        CALL  putChar
        POP   AF
        RET
;****************
;putStr
;Print a string, pointed to by HL and zero terminated, via ASCI0.
;  IN:  HL:address of zero terminated string to be printed.
;  OUT: none.
;  USES:HL:points to byte after zero terminated string.
;****************
putStr:
        PUSH  AF            ;save registers
        JR    $+5
putStr0:
        CALL  putChar
        LD    A,(HL)        ;get next character
        INC   HL
        OR    A,A           ;is it zer0?
        JR    NZ,putStr0    ;no ->put it to ASCI0
        POP   AF            ;yes->return
        RET
;****************
;putChar
;Send one character to ASCI0.
;  IN:  A = character
;  OUT: none.
;  USES:AF
;****************
putChar:
        PUSH  AF                ;save the character to be send
putChar1:
        IN0   A,(STAT0)         ;read ASCI0 status register
        BIT   TDRE,A            ;wait until TDRE <> 0
        JR    Z,putChar1
        POP   AF                ;restore character to be send
        OUT0  (TDR0),A          ;write character to ASCI0
        RET
;****************
;mul16
;16 bit unsigned multiplication
;Input: HL
;       DE
;Output HL = HL * DE low part
;       DE = HL * DE high part
;Uses   -
;****************
mul16:
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
        PUSH    BC      ;save BC
        LD      B,H
        LD      C,L
        LD      H,D     ;DH aka DB
        LD      L,B
        MLT     HL
        PUSH    HL
        LD      H,D     ;DL aka DC
        LD      L,C
        MLT     HL
        PUSH    HL
        LD      H,E     ;EH aka EB
        LD      L,B
        MLT     HL
        PUSH    HL
        LD      H,E     ;EL aka EC
        LD      L,C
        MLT     HL
        POP     DE      ;RS=EL+EH0
        LD      B,0
        LD      C,D     ;..C=EHhigh
        LD      D,E     ;..D=EHlow
        LD      E,0
        ADD     HL,DE
        JR      NC,$+3  ;add carry to PQ
        INC     BC
        POP     DE      ;RS=EL+EH0+DL0
        LD      A,D     ;..A=DLhigh
        LD      D,E     ;..D=DLlow
        ADD     HL,DE
        JR      NC,$+3  ;add carry to PQ
        INC     BC
        ;HL=RS=EL+EH0+DL0
        ;C=EHhigh
        ;A=DLhigh
        ;E=0
        EX      DE,HL
        LD      H,L     ;..E was 0, so H=L=0
        LD      L,A     ;..HL=DLhigh
        ADD     HL,BC   ;PQ=EHhigh+DLhigh+DH
        POP     BC
        ADD     HL,BC
        EX      DE,HL
        ;D=P=DHhigh
        ;E=Q=DHlow+EHhigh+DLhigh
        ;H=R=ELhigh+EHlow+DLlow
        ;L=S=ELlow
        POP     BC      ;restore BC
        RET
;****************
;div16
;16 bit unsigned division
;Input: HL = dividend
;       DE = divisor
;Output HL = quotient
;       DE = remainder
;Uses   -
;****************
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
;for (i=8; i>0; i--) {
;  T = T * 2 (remember MSB in carry)
;  R = R * 2 + carry
;  Q = Q * 2
;  if (R >= D) {
;    R = R - D;
;    Q++;
;  }
;}
;return Q,R (in HL,DE)
div16:
        PUSH    AF
        LD      A,D
        OR      E
        JR      NZ,div16_1
        POP     AF
        CALL    putMsg
        .ASCIZ  "
Divide by zero error.
"
div16_1:
        PUSH    BC
        PUSH    IY
        LD      C,L     ;T(AC) = teller from input (HL)
        LD      A,H     ;D(DE) = deler from input  (DE)
        LD      IY,0    ;Q(IY) = quotient
        LD      HL,0    ;R(HL) = restant
        LD      B,16    ;for (i=8; i>0; i--)
div16_2:
        SLA     C       ;  T = T * 2 (remember MSB in carry)
        RL      A
        RL      L       ;  R = R * 2 + carry
        RL      H
        ADD     IY,IY   ;  Q = Q * 2
        OR      A       ;  if (R >= D) {
        SBC     HL,DE
        JR      C,div16_3 ;    R = R - D
        INC     IY      ;    Q++
        DJNZ    div16_2 ;  }
        JR      div16_4
div16_3:
        ADD     HL,DE   ;compensate comparison
        DJNZ    div16_2 ;}
div16_4:
        PUSH    IY      ;copy IY (quotient) into DE
        POP     DE
        EX      DE,HL   ;swap DE and HL; HL = quotient; DE = rest
        POP     IY
        POP     BC
        POP     AF
        RET
main:
L0:;{Program to test branch instructions}
     ;VAR A;
     ;BEGIN
     ;  A := 1;
        LD   HL,1
        LD   (0x4000),HL
L2:;  
     ;  WRITE(1);
        LD   HL,1
        PUSH HL
        CALL write
L5:;  IF A = 1 THEN WRITE(1);
        LD   HL,(0x4000)
        LD   DE,1
        OR   A
        SBC  HL,DE
        JP   NZ,L11
        LD   HL,1
        PUSH HL
        CALL write
L11:; 
     ;  WRITE(2);
        LD   HL,2
        PUSH HL
        CALL write
L14:;  IF A <> 0 THEN WRITE(2);
        LD   HL,(0x4000)
        LD   DE,0
        OR   A
        SBC  HL,DE
        JP   Z,L20
        LD   HL,2
        PUSH HL
        CALL write
L20:; 
     ;  WRITE(3);
        LD   HL,3
        PUSH HL
        CALL write
L23:;  IF A <= 1 THEN WRITE(3);
        LD   HL,(0x4000)
        LD   DE,1
        OR   A
        SBC  HL,DE
        JP   Z,$+5
        JP   C,L29
        LD   HL,3
        PUSH HL
        CALL write
L29:; 
     ;  WRITE(4);
        LD   HL,4
        PUSH HL
        CALL write
L32:;  IF A < 2 THEN WRITE(4);
        LD   HL,(0x4000)
        LD   DE,2
        OR   A
        SBC  HL,DE
        JP   NC,L38
        LD   HL,4
        PUSH HL
        CALL write
L38:; 
     ;  WRITE(5);
        LD   HL,5
        PUSH HL
        CALL write
L41:;  IF A >= 1 THEN WRITE(5);
        LD   HL,(0x4000)
        LD   DE,1
        OR   A
        SBC  HL,DE
        JP   C,L47
        LD   HL,5
        PUSH HL
        CALL write
L47:; 
     ;  WRITE(6);
        LD   HL,6
        PUSH HL
        CALL write
L50:;  IF A > 0 THEN WRITE(6);
        LD   HL,(0x4000)
        LD   DE,0
        OR   A
        SBC  HL,DE
        JP   Z,L56
        LD   HL,6
        PUSH HL
        CALL write
L56:;
     ;END.
        JP   0x0171

Labels:
20DB : main
2118 : L21
2115 : L20
211C : L23
2119 : L22
2125 : L25
211F : L24
212D : L27
212A : L26
2131 : L29
212E : L28
20BA : div16_2
20AC : div16_1
20D2 : div16_4
20CF : div16_3
2003 : write
2040 : putStr0
2134 : L30
2138 : L32
2135 : L31
2141 : L34
213B : L33
2147 : L36
2144 : L35
214B : L38
2148 : L37
214E : L39
202A : putMsg
204B : putChar1
2088 : div16
200C : putHexHL
2152 : L41
201A : putHexA1
214F : L40
215B : L43
2155 : L42
2161 : L45
215E : L44
2165 : L47
2162 : L46
2011 : putHexA
2169 : L49
2168 : L48
2030 : putCRLF
2057 : mul16
20DB : L0
20DE : L1
204A : putChar
20E1 : L2
216C : L50
203D : putStr
20E4 : L3
2000 : start
20E5 : L4
2175 : L52
20E8 : L5
216F : L51
20EB : L6
20F8 : L10
217B : L54
20F1 : L7
2178 : L53
20F4 : L8
20FE : L12
217F : L56
20F7 : L9
20FB : L11
217C : L55
2102 : L14
20FF : L13
210B : L16
2105 : L15
2111 : L18
210E : L17
2112 : L19

Cross references:
putHexHL = 200C : 2005
 putChar = 204A : 2025 2033 2038 2040
  putStr = 203D : 202B
putHexA1 = 201A : 2016
    main = 20DB : 2000
     L20 = 2115 : 210B
     L56 = 217F : 2175
     L11 = 20FB : 20F1
     L47 = 2165 : 215B
 putHexA = 2011 : 200D
     L38 = 214B : 2141
     L29 = 2131 : 2127
  putMsg = 202A : 208E
 putCRLF = 2030 : 2008
   write = 2003 : 20E5 20F8 20FF 2112 2119 212E 2135 2148 214F 2162 2169 217C
