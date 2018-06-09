{A small program in the P-language}
VAR sum, NUMBER_OF_NUMBERS, NUMBER, _Average;
BEGIN
  sum := 0; {sum}
  NUMBER_OF_NUMBERS := 0; {NUMBER of items}
  NUMBER := READ; {read a new NUMBER}
  WRITE (NUMBER;
  WHILE NUMBER <> 0 {not end of file} DO
  BEGIN
    sum := sum + NUMBER; {sum of NUMBERs read}
    NUMBER_OF_NUMBERS := NUMBER_OF_NUMBERS + 1; {NUMBER of NUMBERs read}
    NUMBER := READ;
    WRITE (NUMBER);
  END;
  WRITE (NUMBER_OF_NUMBERS);
  WRITE (sum);
  IF NUMBER_OF_NUMBERS <> 0 THEN
  BEGIN
    _Average := sum / NUMBER_OF_NUMBERS; {average}
    WRITE (_Average);
  END
END.
