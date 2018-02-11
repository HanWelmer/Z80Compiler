L000:;{Program to test generated Z80 assembler code}
     ;VAR A;
     ;BEGIN
     ;  A := 1;
LD   HL,1
LD   (0x4000),HL
L002:;  WHILE A < 9 DO
LD   HL,(0x4000)
L003:;  BEGIN
LD   DE,9
OR   A
SBC  HL,DE
JP   C,L12
L005:;    WRITE(A);
LD   HL,(0x4000)
PUSH HL
CALL write
L008:;    A := A + 1;
LD   HL,(0x4000)
LD   DE,1
ADD  HL,DE
LD   (0x4000),HL
L011:;  END;
JP   L2
L012:;END.
JP   0x0171
