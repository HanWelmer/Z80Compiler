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
        LD    A,''
        CALL  putChar
        LD    A,'
'
        CALL  putChar
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
        JR    C,putHexA2
        ADD   A,07
putHexA2:
        CALL  putChar
        POP   AF
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
main:
L0:;{Program to test multiplication}
     ;VAR A;
     ;BEGIN
     ;  WRITE(1 * 0);
        LD   HL,1
        LD   DE,0
        CALL mul16
        PUSH HL
        CALL write
L4:;  WRITE(1 * 1);
        LD   HL,1
        LD   DE,1
        CALL mul16
        PUSH HL
        CALL write
L8:;  WRITE(2 * 1);
        LD   HL,2
        LD   DE,1
        CALL mul16
        PUSH HL
        CALL write
L12:;  WRITE(1 * 3);
        LD   HL,1
        LD   DE,3
        CALL mul16
        PUSH HL
        CALL write
L16:;  A := 2 * 2;
        LD   HL,2
        LD   DE,2
        CALL mul16
        LD   (0x4000),HL
L19:;  WRITE(A);
        LD   HL,(0x4000)
        PUSH HL
        CALL write
L22:;  A := 1;
        LD   HL,1
        LD   (0x4000),HL
L24:;  WRITE(A * 5);
        LD   HL,(0x4000)
        LD   DE,5
        CALL mul16
        PUSH HL
        CALL write
L28:;  A := 2;
        LD   HL,2
        LD   (0x4000),HL
L30:;  WRITE(3 * A);
        LD   HL,3
        LD   DE,(0x4000)
        CALL mul16
        PUSH HL
        CALL write
L34:;  WRITE(2 * 9 * 9); {162 = 0xA2}
        LD   HL,2
        LD   DE,9
        CALL mul16
        LD   DE,9
        CALL mul16
        PUSH HL
        CALL write
L39:;  WRITE(9 * 9 * 9); {729 = 0x2D9}
        LD   HL,9
        LD   DE,9
        CALL mul16
        LD   DE,9
        CALL mul16
        PUSH HL
        CALL write
L44:;  WRITE(9 * 9 * 9 * 9); {6561 = 0x19A1}
        LD   HL,9
        LD   DE,9
        CALL mul16
        LD   DE,9
        CALL mul16
        LD   DE,9
        CALL mul16
        PUSH HL
        CALL write
L50:;  WRITE(9 * 9 * 9 * 9 * 9); {59049 = 0xE6A9}
        LD   HL,9
        LD   DE,9
        CALL mul16
        LD   DE,9
        CALL mul16
        LD   DE,9
        CALL mul16
        LD   DE,9
        CALL mul16
        PUSH HL
        CALL write
L57:;END.
        JP   0x0171

Labels:
206F : main
20B3 : L21
20B2 : L20
20B9 : L23
20B6 : L22
20BF : L25
20BC : L24
20C6 : L27
20C5 : L26
20CC : L29
20C9 : L28
2003 : write
20CF : L30
20D9 : L32
20D2 : L31
20DD : L34
20DA : L33
20E6 : L36
20E0 : L35
20ED : L38
20EC : L37
20F0 : L39
2032 : putChar1
2013 : putHexHL
202C : putHexA2
20F9 : L41
2021 : putHexA1
20F3 : L40
2100 : L43
20FF : L42
2106 : L45
2103 : L44
2112 : L47
210C : L46
2018 : putHexA
2119 : L49
2118 : L48
203E : mul16
206F : L0
2072 : L1
2031 : putChar
2078 : L2
211C : L50
2079 : L3
2000 : start
207C : L4
2125 : L52
207F : L5
211F : L51
2085 : L6
2092 : L10
2131 : L54
2086 : L7
212B : L53
2089 : L8
2096 : L12
2138 : L56
208C : L9
2093 : L11
2137 : L55
209F : L14
2099 : L13
213B : L57
20A3 : L16
20A0 : L15
20AC : L18
20A6 : L17
20AF : L19

Cross references:
 putHexA = 2018 : 2015
putHexHL = 2013 : 2006
 putChar = 2031 : 200B 2010 202D
putHexA1 = 2021 : 201E
    main = 206F : 2001
   write = 2003 : 207A 2087 2094 20A1 20B4 20C7 20DB 20EE 2101 211A 2139
   mul16 = 203E : 2076 2083 2090 209D 20AA 20C3 20D7 20E4 20EA 20F7 20FD 210A 2110 2116 2123 2129 212F 2135
