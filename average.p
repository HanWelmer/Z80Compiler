{A small program in the P-language}
VAR number, Sum, NUMBER_OF_NUMBERS, _Average;
BEGIN
  Sum := 0;
  NUMBER_OF_NUMBERS := 0;
  {read a new number and echo number to output}
  number := READ; 
  WRITE (number);
  WHILE number <> 0 {not end of file} DO
  BEGIN
    Sum := Sum + number;
    NUMBER_OF_NUMBERS := NUMBER_OF_NUMBERS + 1;
    {read a new number and echo number to output}
    number := READ;
    WRITE (number);
  END;
  WRITE (NUMBER_OF_NUMBERS);
  WRITE (Sum);
  IF NUMBER_OF_NUMBERS <> 0 THEN
  BEGIN
    _Average := Sum / NUMBER_OF_NUMBERS;
    WRITE (_Average);
  END
END.
