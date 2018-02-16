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
203E : main
207B : L21
2078 : L20
207F : L23
207C : L22
2088 : L25
2082 : L24
2090 : L27
208D : L26
2094 : L29
2091 : L28
2003 : write
2097 : L30
209B : L32
2098 : L31
20A4 : L34
209E : L33
20AA : L36
20A7 : L35
20AE : L38
20AB : L37
20B1 : L39
2032 : putChar1
2013 : putHexHL
202C : putHexA2
20B5 : L41
2021 : putHexA1
20B2 : L40
20BE : L43
20B8 : L42
20C4 : L45
20C1 : L44
20C8 : L47
20C5 : L46
2018 : putHexA
20CC : L49
20CB : L48
203E : L0
2041 : L1
2031 : putChar
2044 : L2
20CF : L50
2047 : L3
2000 : start
2048 : L4
20D8 : L52
204B : L5
20D2 : L51
204E : L6
205B : L10
20DE : L54
2054 : L7
20DB : L53
2057 : L8
2061 : L12
20E2 : L56
205A : L9
205E : L11
20DF : L55
2065 : L14
2062 : L13
206E : L16
2068 : L15
2074 : L18
2071 : L17
2075 : L19

Cross references:
 putHexA = 2018 : 2015
     L38 = 20AE : 20A5
     L29 = 2094 : 208B
putHexHL = 2013 : 2006
 putChar = 2031 : 200B 2010 202D
putHexA1 = 2021 : 201E
    main = 203E : 2001
     L20 = 2078 : 206F
     L56 = 20E2 : 20D9
   write = 2003 : 2049 205C 2063 2076 207D 2092 2099 20AC 20B3 20C6 20CD 20E0
     L11 = 205E : 2055
     L47 = 20C8 : 20BF
