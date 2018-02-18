start:
        JP    main
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
        POP   HL
        EX    (SP),HL
        CALL  putHexHL
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
        LD    A,H
        CALL  putHexA
        LD    A,L
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
        EX    (SP),HL     ;save HL and load return address into HL.
        CALL  putStr
        EX    (SP),HL     ;put return address onto stack and restore HL.
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
        LD    A,'\r'
        CALL  putChar
        LD    A,'\n'
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
        PUSH  AF          ;save registers
        JR    $+5
putStr0:
        CALL  putChar
        LD    A,(HL)      ;get next character
        INC   HL
        OR    A,A         ;is it zer0?
        JR    NZ,putStr0  ;no ->put it to ASCI0
        POP   AF          ;yes->return
        RET
;****************
;putChar
;Send one character to ASCI0.
;  IN:  A = character
;  OUT: none.
;  USES:AF
;****************
putChar:
        PUSH  AF          ;save the character to be send
putChar1:
        IN0   A,(STAT0)   ;read ASCI0 status register
        BIT   TDRE,A      ;wait until TDRE <> 0
        JR    Z,putChar1
        POP   AF          ;restore character to be send
        OUT0  (TDR0),A    ;write character to ASCI0
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
        PUSH  BC          ;save BC
        LD    B,H
        LD    C,L
        LD    H,D         ;DH aka DB
        LD    L,B
        MLT   HL
        PUSH  HL
        LD    H,D         ;DL aka DC
        LD    L,C
        MLT   HL
        PUSH  HL
        LD    H,E         ;EH aka EB
        LD    L,B
        MLT   HL
        PUSH  HL
        LD    H,E         ;EL aka EC
        LD    L,C
        MLT   HL
        POP   DE          ;RS=EL+EH0
        LD    B,0
        LD    C,D         ;..C=EHhigh
        LD    D,E         ;..D=EHlow
        LD    E,0
        ADD   HL,DE
        JR    NC,$+3      ;add carry to PQ
        INC   BC
        POP   DE          ;RS=EL+EH0+DL0
        LD    A,D         ;..A=DLhigh
        LD    D,E         ;..D=DLlow
        ADD   HL,DE
        JR    NC,$+3      ;add carry to PQ
        INC   BC
        ;HL=RS=EL+EH0+DL0
        ;C=EHhigh
        ;A=DLhigh
        ;E=0
        EX    DE,HL
        LD    H,L         ;..E was 0, so H=L=0
        LD    L,A         ;..HL=DLhigh
        ADD   HL,BC       ;PQ=EHhigh+DLhigh+DH
        POP   BC
        ADD   HL,BC
        EX    DE,HL
        ;D=P=DHhigh
        ;E=Q=DHlow+EHhigh+DLhigh
        ;H=R=ELhigh+EHlow+DLlow
        ;L=S=ELlow
        POP   BC          ;restore BC
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
        PUSH  AF
        LD    A,D
        OR    E
        JR    NZ,div16_1
        POP   AF
        CALL  putMsg
        .ASCIZ  "\b\r\nDivide by zero error.\r\n"
        JP    0           ;Jump to Zilog Z80183 Monitor and show register status.
div16_1:
        PUSH  BC
        PUSH  IY
        LD    C,L         ;T(AC) = teller from input (HL)
        LD    A,H         ;D(DE) = deler from input  (DE)
        LD    IY,0        ;Q(IY) = quotient
        LD    HL,0        ;R(HL) = restant
        LD    B,16        ;for (i=8; i>0; i--)
div16_2:
        SLA   C           ;  T = T * 2 (remember MSB in carry)
        RL    A
        RL    L           ;  R = R * 2 + carry
        RL    H
        ADD   IY,IY       ;  Q = Q * 2
        OR    A           ;  if (R >= D) {
        SBC   HL,DE
        JR    C,div16_3   ;    R = R - D
        INC   IY          ;    Q++
        DJNZ  div16_2     ;  }
        JR    div16_4
div16_3:
        ADD   HL,DE       ;compensate comparison
        DJNZ  div16_2     ;}
div16_4:
        PUSH  IY          ;copy IY (quotient) into DE
        POP   DE
        EX    DE,HL       ;swap DE and HL; HL = quotient; DE = rest
        POP   IY
        POP   BC
        POP   AF
        RET
main:
L0:     ;{Program to test multiplication}
        ;VAR A;
        ;BEGIN
        ;  WRITE(1 * 0);
        LD    HL,1
        LD    DE,0
        CALL  mul16
        PUSH  HL
        CALL  write
L4:     ;  WRITE(1 * 1);
        LD    HL,1
        LD    DE,1
        CALL  mul16
        PUSH  HL
        CALL  write
L8:     ;  WRITE(2 * 1);
        LD    HL,2
        LD    DE,1
        CALL  mul16
        PUSH  HL
        CALL  write
L12:    ;  WRITE(1 * 3);
        LD    HL,1
        LD    DE,3
        CALL  mul16
        PUSH  HL
        CALL  write
L16:    ;  A := 2 * 2;
        LD    HL,2
        LD    DE,2
        CALL  mul16
        LD    (0x4000),HL
L19:    ;  WRITE(A);
        LD    HL,(0x4000)
        PUSH  HL
        CALL  write
L22:    ;  A := 1;
        LD    HL,1
        LD    (0x4000),HL
L24:    ;  WRITE(A * 5);
        LD    HL,(0x4000)
        LD    DE,5
        CALL  mul16
        PUSH  HL
        CALL  write
L28:    ;  A := 2;
        LD    HL,2
        LD    (0x4000),HL
L30:    ;  WRITE(3 * A);
        LD    HL,3
        LD    DE,(0x4000)
        CALL  mul16
        PUSH  HL
        CALL  write
L34:    ;  WRITE(2 * 9 * 9); {162 = 0xA2}
        LD    HL,2
        LD    DE,9
        CALL  mul16
        LD    DE,9
        CALL  mul16
        PUSH  HL
        CALL  write
L39:    ;  WRITE(9 * 9 * 9); {729 = 0x2D9}
        LD    HL,9
        LD    DE,9
        CALL  mul16
        LD    DE,9
        CALL  mul16
        PUSH  HL
        CALL  write
L44:    ;  WRITE(9 * 9 * 9 * 9); {6561 = 0x19A1}
        LD    HL,9
        LD    DE,9
        CALL  mul16
        LD    DE,9
        CALL  mul16
        LD    DE,9
        CALL  mul16
        PUSH  HL
        CALL  write
L50:    ;  WRITE(9 * 9 * 9 * 9 * 9); {59049 = 0xE6A9}
        LD    HL,9
        LD    DE,9
        CALL  mul16
        LD    DE,9
        CALL  mul16
        LD    DE,9
        CALL  mul16
        LD    DE,9
        CALL  mul16
        PUSH  HL
        CALL  write
L57:    ;END.
        JP    0x0171      ;Jump to Zilog Z80183 Monitor.
