start:
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
        CALL  WAIT1M
        DEC   DE
        LD    A,D
        OR    A,E
        JR    NZ,$-6
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
        PUSH  HL
        PUSH    AF
        LD      HL, 834
        DEC     HL
        LD	A,H
        OR	A,L
        JR	NZ,WAIT1M2
        POP	AF
        POP	HL
        RET
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
        IN0   A,(STAT0)
        BIT   OVERRUN,A
        JR    NZ,$+9
        BIT   RDRF,A
        RET   Z
        IN0   A,(RDR0)
        RET
        IN0   A,(CNTLA0)
        RES   ERROR,A
        OUT0  (CNTLA0),A
        XOR   A
        RET
;****************
;putMsg
;Print via ASCI0 a zero terminated string, starting at the return address on the stack.
;  IN:  none.
;  OUT: none.
;  USES:none.
;****************
putMsg:
        EX    (SP),HL
        CALL  putStr
        EX    (SP),HL
        RET
;****************
;putStr
;Print via ASCI0 a zero terminated string, pointed to by HL.
;  IN:  HL:address of zero terminated string to be printed.
;  OUT: none.
;  USES:HL (point to byte after zero terminated string)
;****************
putStr:
        PUSH  AF
putStr1:
        LD    A,(HL)
        INC   HL
        OR    A,A
        JR    Z,putStr2
        CALL  putChar
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
        LD    A,' '
;****************
;putChar
;Send one character to ASCI0.
;  IN:  A = character
;  OUT: none.
;  USES:AF
;****************
putChar:
        PUSH  AF
putChar1:
        IN0   A,(STAT0)
        BIT   TDRE,A
        JR    Z,putChar1
        POP   AF
        OUT0  (TDR0),A
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
;putErase
;Erase the latest character at ASCI0
;  IN:  none.
;  OUT: none.
;  USES:AF
;****************
putErase:
        LD    A,'\b'
        CALL  putChar
        CALL  putSpace
        LD    A,'\b'
        JR    putChar
;****************
;putBell
;Send a Bell character to ASCI0
;  IN:  none.
;  OUT: none.
;  USES:AF
;****************
putBell:
        LD    A,07
        JR    putChar
;****************
;putHexHL
;Print HL register pair as 4 hex digits
;  IN:  HL = word to be printed.
;  OUT: none.
;  USES:none.
;****************
putHexHL:
        PUSH  AF
        LD    A,H
        CALL  putHexA
        LD    A,L
        CALL  putHexA
        POP   AF
        RET
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
        JR    C,putHexA2
        ADD   A,07
putHexA2:
        CALL  putChar
        POP   AF
        RET
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
        PUSH  BC
        LD    B,H
        LD    C,L
        LD    H,E
        MLT   HL
        PUSH  HL
        LD    H,E
        LD    L,B
        MLT   HL
        LD    B,L
        LD    H,D
        LD    L,C
        MLT   HL
        LD    D,L
        LD    E,0
        POP   HL
        ADD   HL,DE
        LD    D,B
        ADD   HL,DE
        POP   BC
        RET
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
        PUSH  AF
        PUSH  BC
        LD    B,H
        LD    C,L
        LD    H,D 
        LD    L,B
        MLT   HL
        PUSH  HL
        LD    H,D
        LD    L,C
        MLT   HL
        PUSH  HL
        LD    H,E
        LD    L,B
        MLT   HL
        PUSH  HL
        LD    H,E
        LD    L,C
        MLT   HL
        POP   DE
        LD    B,0
        LD    C,D
        LD    D,E
        LD    E,0
        ADD   HL,DE
        JR    NC,$+3
        INC   BC
        POP   DE
        LD    A,D
        LD    D,E
        ADD   HL,DE
        JR    NC,$+3
        INC   BC
        ;HL=RS=EL+EH0+DL0
        ;C=EHhigh
        ;A=DLhigh
        ;E=0
        EX    DE,HL
        LD    H,L
        LD    L,A
        ADD   HL,BC
        POP   BC
        ADD   HL,BC
        EX    DE,HL
        ;D=P=DHhigh
        ;E=Q=DHlow+EHhigh+DLhigh
        ;H=R=ELhigh+EHlow+DLlow
        ;L=S=ELlow
        POP   BC
        POP   AF
        RET
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
        PUSH  AF
        PUSH  BC
        LD    B,H
        LD    C,L
        LD    HL,0
        LD    A,16
mul16S1:
        ADD   HL,HL
        RL    E
        RL    D
        JR    NC,mul16S2
        ADD   HL,BC
        JR    NC,mul16S2
        INC   DE
mul16S2:
        DEC   A
        JR    NZ,mul16S1
        POP   BC
        POP   AF
        RET
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
        PUSH  AF
        PUSH  BC
        LD    C,L
        LD    A,H
        LD    HL,0
        LD    B,16
div16_1:
        SLA   C
        RL    A
        ADC   HL,HL
        OR    A
        SBC   HL,DE
        JR    C,div16_2
        INC   C
        JR    div16_3
div16_2:
        ADD   HL,DE
div16_3:
        DJNZ  div16_1
        EX    DE,HL
        LD    H,A
        LD    L,C
        POP   BC
        POP   AF
        RET
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
        PUSH  BC
        LD    B,16
        LD    C,A
        XOR   A
div16_82:
        ADD   HL,HL
        RL    A
        CP    C 
        JR    C,div16_83
        SUB   C
        INC   L
div16_83:
        DJNZ  div16_82
        POP   BC
        RET
;****************
;read
;read a 16 bit unsigned number from the input
;  IN:  none
;  OUT: HL = 16 bit unsigned number
;  USES:-
;****************
read:
        PUSH  AF
        PUSH  DE
        LD    HL,0
        CALL  getChar
        JR    Z,$-3
        CP    ''
        JR    Z,$+17
        LD    DE,10
        CALL  mul16
        SUB   A,'0'
        ADD   A,L
        LD    L,A
        JR    NC,$-19
        INC   H
        JR    $-22
        POP   DE
        POP   AF
        RET
;****************
;write
;write a 16 bit unsigned number to the output
;  IN:  TOS   = return address
;       TOS+2 = 16 bit unsigned number
;  OUT: none
;  USES:HL
;****************
write:
        POP   HL
        EX    (SP),HL
        PUSH  BC
        PUSH  AF
        LD    B,0
        LD    A,H
        OR    L
        JR    NZ,$+5
        INC   B
        JR    $+14
        LD    A,10
        CALL  div16_8
        PUSH  AF
        INC   B
        LD    A,H
        OR    L
        JR    NZ,$-9
        POP   AF
        ADD   A,'0'
        CALL  putChar
        DJNZ  $-6
        POP   AF
        POP   BC
        RET
main:
L0:     ;{A small program in the P-language}
        ;VAR S, N, T;
        ;BEGIN
        ;  S := 0; {sum}
        LD    HL,0
        LD    (0x4000),HL
L2:     ;  N := 0; {number of items}
        LD    HL,0
        LD    (0x4002),HL
L4:     ;  T := READ; {read a digit}
        CALL  read
        LD    (0x4004),HL
L6:     ;  WHILE T <> 0 {not end of file} DO
        LD    HL,(0x4004)
L7:     ;  BEGIN
        LD    DE,0
        OR    A
        SBC   HL,DE
        JP    Z,L18
L9:     ;    S := S + T; {sum of numbers read}
        LD    HL,(0x4000)
        LD    DE,(0x4004)
        ADD   HL,DE
        LD    (0x4000),HL
L12:    ;    N := N + 1; {number of numbers read}
        LD    HL,(0x4002)
        LD    DE,1
        ADD   HL,DE
        LD    (0x4002),HL
L15:    ;    T := READ;
        CALL  read
        LD    (0x4004),HL
L17:    ;  END;
        JP    L6
L18:    ;  WRITE (N);
        LD    HL,(0x4002)
        PUSH  HL
        CALL  write
L21:    ;  WRITE (S);
        LD    HL,(0x4000)
        PUSH  HL
        CALL  write
L24:    ;  IF N <> 0 THEN
        LD    HL,(0x4002)
L25:    ;    WRITE (S / N); {average}
        LD    DE,0
        OR    A
        SBC   HL,DE
        JP    Z,L31
        LD    HL,(0x4000)
        LD    DE,(0x4002)
        CALL  div16
        PUSH  HL
        CALL  write
L31:    ;END.
        JP    0x0171      ;Jump to Zilog Z80183 Monitor.
