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
JP   C,L12
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
2000 : L0
2003 : L1
2006 : L2
2009 : L3
200F : L4
2012 : L5
2015 : L6
2020 : L10
2016 : L7
2019 : L8
2026 : L12
201C : L9
2023 : L11

Cross references:
   L2 = 2006 : 2024
  L12 = 2026 : 2010
