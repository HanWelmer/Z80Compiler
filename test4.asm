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
L0:;{Program to test division}
     ;BEGIN
     ;  WRITE(0 / 1);
        LD   HL,0
        LD   DE,1
        CALL div16
        PUSH HL
        CALL write
L4:;  WRITE(1 * 1);
        LD   HL,1
        LD   DE,1
        CALL mul16
        PUSH HL
        CALL write
L8:;  WRITE(4 / 2);
        LD   HL,4
        LD   DE,2
        CALL div16
        PUSH HL
        CALL write
L12:;  WRITE(9 / 3);
        LD   HL,9
        LD   DE,3
        CALL div16
        PUSH HL
        CALL write
L16:;  WRITE(8 / 2);
        LD   HL,8
        LD   DE,2
        CALL div16
        PUSH HL
        CALL write
L20:;  WRITE(5 / 1);
        LD   HL,5
        LD   DE,1
        CALL div16
        PUSH HL
        CALL write
L24:;  WRITE((3 * 8) / 4);
        LD   HL,3
        LD   DE,8
        CALL mul16
        LD   DE,4
        CALL div16
        PUSH HL
        CALL write
L29:;  WRITE((7 * 7) / 7);
        LD   HL,7
        LD   DE,7
        CALL mul16
        LD   DE,7
        CALL div16
        PUSH HL
        CALL write
L34:;  WRITE((4 * 5 * 2) / 5);
        LD   HL,4
        LD   DE,5
        CALL mul16
        LD   DE,2
        CALL mul16
        LD   DE,5
        CALL div16
        PUSH HL
        CALL write
L40:;  WRITE((7 * 7 + 5) / 6);
        LD   HL,7
        LD   DE,7
        CALL mul16
        LD   DE,5
        ADD  HL,DE
        LD   DE,6
        CALL div16
        PUSH HL
        CALL write
L46:;  WRITE((4 * 5) / 2);
        LD   HL,4
        LD   DE,5
        CALL mul16
        LD   DE,2
        CALL div16
        PUSH HL
        CALL write
L51:;END.
        JP   0x0171

Labels:
20DB : main
211F : L21
211C : L20
2126 : L23
2125 : L22
212C : L25
2129 : L24
2138 : L27
2132 : L26
213C : L29
2139 : L28
20BA : div16_2
20AC : div16_1
20D2 : div16_4
20CF : div16_3
2003 : write
2040 : putStr0
213F : L30
214B : L32
2145 : L31
214F : L34
214C : L33
2158 : L36
2152 : L35
2164 : L38
215E : L37
2165 : L39
202A : putMsg
204B : putChar1
2088 : div16
200C : putHexHL
216B : L41
201A : putHexA1
2168 : L40
2175 : L43
2171 : L42
217C : L45
217B : L44
2182 : L47
217F : L46
2011 : putHexA
218E : L49
2188 : L48
2030 : putCRLF
2057 : mul16
20DB : L0
20DE : L1
204A : putChar
20E4 : L2
218F : L50
203D : putStr
20E5 : L3
2000 : start
20E8 : L4
20EB : L5
2192 : L51
20F1 : L6
20FE : L10
20F2 : L7
20F5 : L8
2102 : L12
20F8 : L9
20FF : L11
210B : L14
2105 : L13
210F : L16
210C : L15
2118 : L18
2112 : L17
2119 : L19

Cross references:
 putHexA = 2011 : 200D
   div16 = 2088 : 20E1 20FB 2108 2115 2122 2135 2148 2161 2178 218B
putHexHL = 200C : 2005
 putChar = 204A : 2025 2033 2038 2040
  putStr = 203D : 202B
  putMsg = 202A : 208E
putHexA1 = 201A : 2016
    main = 20DB : 2000
 putCRLF = 2030 : 2008
   write = 2003 : 20E5 20F2 20FF 210C 2119 2126 2139 214C 2165 217C 218F
   mul16 = 2057 : 20EE 212F 2142 2155 215B 216E 2185
