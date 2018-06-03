{A small program in the P-language}
VAR S, N, T;
BEGIN
  S := 0; {sum}
  N := 0; {number of items}
  T := READ; {read a digit}
  WRITE (T);
  WHILE T <> 0 {not end of file} DO
  BEGIN
    S := S + T; {sum of numbers read}
    N := N + 1; {number of numbers read}
    T := READ;
    WRITE (T);
  END;
  WRITE (N);
  WRITE (S);
  IF N <> 0 THEN
    WRITE (S / N); {average}
END.
