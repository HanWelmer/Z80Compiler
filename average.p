{A small program in the P-language}
VAR sum, count, number;
BEGIN
  sum := 0; {sum}
  count := 0; {number of items}
  number := READ; {read a new number}
  WRITE (number;
  WHILE number <> 0 {not end of file} DO
  BEGIN
    sum := sum + number; {sum of numbers read}
    count := count + 1; {number of numbers read}
    number := READ;
    WRITE (number);
  END;
  WRITE (count);
  WRITE (sum);
  IF count <> 0 THEN
    WRITE (sum / count); {average}
END.
