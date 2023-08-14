{Print prime numbers less than 100}
VAR T, {test result; 1 if prime, 0 if not}
    P, {prime to be tested}
    D, {divisor}
    M; {max prime to be tested}
BEGIN
  M := (9+1)*(9+1); {max = 100}
  WRITE(1);
  WRITE(2);
  P := 3;
  WHILE P<M DO
  BEGIN
    D := 2;
    T := 1;
    WHILE D + D <= P DO
    BEGIN
      IF P / D * D = P
      THEN T := 0;
      D := D + 1;
    END;
    IF T = 1
    THEN WRITE(P);
    P := P + 1;
  END
END.
