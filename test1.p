{Program to test generated Z80 assembler code}
VAR A;
BEGIN
  A := 1;
  WHILE A < 9 DO
  BEGIN
    WRITE(A);
    A := A + 1;
  END;
END.
