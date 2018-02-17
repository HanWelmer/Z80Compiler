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
L0:;{Program to test generated Z80 assembler code}
     ;VAR A;
     ;BEGIN
     ;  A := 1;
        LD   HL,1
        LD   (0x4000),HL
L2:;  WHILE A < 9 DO
        LD   HL,(0x4000)
L3:;  BEGIN
        LD   DE,9
        OR   A
        SBC  HL,DE
        JP   NC,L12
L5:;    WRITE(A);
        LD   HL,(0x4000)
        PUSH HL
        CALL write
L8:;    A := A + 1;
        LD   HL,(0x4000)
        LD   DE,1
        ADD  HL,DE
        LD   (0x4000),HL
L11:;  END;
        JP   L2
L12:;END.
        JP   0x0171

Labels:
204B : putChar1
2088 : div16
200C : putHexHL
201A : putHexA1
20DB : main
2011 : putHexA
20BA : div16_2
20AC : div16_1
20D2 : div16_4
2030 : putCRLF
20CF : div16_3
2003 : write
2057 : mul16
20DB : L0
2040 : putStr0
20DE : L1
204A : putChar
20E1 : L2
203D : putStr
20E4 : L3
2000 : start
20EA : L4
20ED : L5
20F0 : L6
20FB : L10
20F1 : L7
20F4 : L8
2101 : L12
20F7 : L9
20FE : L11
202A : putMsg

Cross references:
 putHexA = 2011 : 200D
putHexHL = 200C : 2005
 putChar = 204A : 2025 2033 2038 2040
      L2 = 20E1 : 20FE
  putStr = 203D : 202B
  putMsg = 202A : 208E
putHexA1 = 201A : 2016
    main = 20DB : 2000
 putCRLF = 2030 : 2008
     L12 = 2101 : 20EA
   write = 2003 : 20F1
