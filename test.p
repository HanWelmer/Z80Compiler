{Program to test some compiler constructs}
VAR A, B, C, D;
BEGIN
  WHILE A < 0 DO A = 1;
  WHILE A <= 0 DO A = 1;
  WHILE A = 0 DO A = 1;
  WHILE A >= 0 DO A = 1;
  WHILE A > 0 DO A = 1;
  WHILE A <> 0 DO A = 1;

  WHILE A = 0 DO BEGIN
    A = 1;
  END;

  WHILE A = 0 DO BEGIN
    A = 1;
    IF A=1 THEN BEGIN
      A = 2;
    END;
  END;

  WHILE A = 0 DO BEGIN
    IF A=1 THEN BEGIN
      A = 2;
    END;
    A = 1;
  END;

  WRITE(READ);

  A := READ;
  A := 2;
  B := 3;
  C := 4;
  D := 5;
  B := A;
  B := B;
  B := C;
  B := D;
 
  WRITE(1);
  WRITE(A);
  
  B := READ + READ;
  B := READ + 1;
  B := READ + A;
  B := 1 + READ;
  B := 2 + 1;
  B := 1 + A;
  B := A + READ;
  B := A + 1;
  C := A + B;

  B := READ - READ;
  B := READ - 1;
  B := READ - A;
  B := 1 - READ;
  B := 1 - 1;
  B := 3 - A;
  B := A - READ;
  B := A - 2;
  C := A - B;

  B := READ * READ;
  B := READ * 5;
  B := READ * A;
  B := 3 * READ;
  B := 3 * 5;
  B := 3 * A;
  B := A * READ;
  B := A * 5;
  C := A * B;
  
  C := A * (READ + READ);
  C := A * (READ + 1);
  C := A * (READ + B);
  C := A * (1 + READ);
  C := A * (1 + 2);
  C := A * (1 + B);
  C := A * (B + READ);
  C := A * (B + 2);
  D := A * (B + C);
  D := (A + B) * C;

  B := READ / READ;
  B := READ / 5;
  B := READ / A;
  B := 3 / READ;
  B := 3 / 5;
  B := 3 / A;
  B := A / READ;
  B := A / 5;
  C := A / B;
END.
