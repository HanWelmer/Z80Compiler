{Program to test some compiler constructs}
VAR A, B, C, D;
BEGIN
  A := 1;
{  A := READ;
  B := A;
  B := 2 + 1;
  B := 1 + A;
  B := 1 + READ;
  B := A + 1;
  B := A + A;
  B := A + READ;
  B := READ + 1;
  B := READ + A;
  B := READ + READ;
  B := 9 - 1;
  B := 9 - A;
  B := 9 - READ;
  B := A - 1;
  B := A - A;
  B := A - READ;
  B := READ - 1;
}
  WRITE(A);
  B := READ - A;
  WRITE(B);
  B := READ - READ;
  WRITE(B);
  C := A * READ * (B + 2 * (B + 3 * (B + 4 * (B + 5 * (B + 6 * (B + 7 * (B + 8 * (B + 9 * (B + 0 * (B + READ))))))))));
  WRITE(C);
END.
