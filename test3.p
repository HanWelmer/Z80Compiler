{Program to test multiplication}
VAR A;
BEGIN
  WRITE(1 * 0);
  WRITE(1 * 1);
  WRITE(2 * 1);
  WRITE(1 * 3);
  A := 2 * 2;
  WRITE(A);
  A := 1;
  WRITE(A * 5);
  A := 2;
  WRITE(3 * A);
  WRITE(2 * 9 * 9); {162 = 0xA2}
  WRITE(9 * 9 * 9); {729 = 0x2D9}
  WRITE(9 * 9 * 9 * 9); {6561 = 0x19A1}
  WRITE(9 * 9 * 9 * 9 * 9); {59049 = 0xE6A9}
END.
