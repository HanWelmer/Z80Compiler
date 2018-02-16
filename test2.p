{Program to test branch instructions}
VAR A;
BEGIN
  A := 1;
  
  WRITE(1);
  IF A = 1 THEN WRITE(1);
 
  WRITE(2);
  IF A <> 0 THEN WRITE(2);
 
  WRITE(3);
  IF A <= 1 THEN WRITE(3);
 
  WRITE(4);
  IF A < 2 THEN WRITE(4);
 
  WRITE(5);
  IF A >= 1 THEN WRITE(5);
 
  WRITE(6);
  IF A > 0 THEN WRITE(6);

END.
