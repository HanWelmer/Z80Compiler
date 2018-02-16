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
2032 : putChar1
203E : L0
2013 : putHexHL
2041 : L1
2031 : putChar
2044 : L2
2047 : L3
2000 : start
202C : putHexA2
204D : L4
2021 : putHexA1
2050 : L5
203E : main
2053 : L6
205E : L10
2054 : L7
2057 : L8
2064 : L12
205A : L9
2061 : L11
2018 : putHexA
2003 : write

Cross references:
 putHexA = 2018 : 2015
putHexHL = 2013 : 2006
 putChar = 2031 : 200B 2010 202D
      L2 = 2044 : 2062
putHexA1 = 2021 : 201E
    main = 203E : 2001
     L12 = 2064 : 204E
   write = 2003 : 2055
