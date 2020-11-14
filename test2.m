  0 :///* Program to test branch instructions */
  1 ://class TestBranches {
  2 ://  write(9);
  3 :acc8= constant 9
  4 :call writeAcc8
  5 ://  int a = 1;
  6 :acc8= constant 1
  7 :acc8ToAcc16
  8 :acc16=> variable 0
  9 ://  if (a == 1) write(8);
 10 :acc16= variable 0
 11 :accom16 constant 1
 12 :brne 15
 13 :acc8= constant 8
 14 :call writeAcc8
 15 ://  if (a != 0) write(7);
 16 :acc16= variable 0
 17 :accom16 constant 0
 18 :breq 21
 19 :acc8= constant 7
 20 :call writeAcc8
 21 ://  if (a > 0) write(6);
 22 :acc16= variable 0
 23 :accom16 constant 0
 24 :brle 27
 25 :acc8= constant 6
 26 :call writeAcc8
 27 ://  if (a >= 0) write(5);
 28 :acc16= variable 0
 29 :accom16 constant 0
 30 :brlt 33
 31 :acc8= constant 5
 32 :call writeAcc8
 33 ://  if (a >= 1) write(4);
 34 :acc16= variable 0
 35 :accom16 constant 1
 36 :brlt 39
 37 :acc8= constant 4
 38 :call writeAcc8
 39 ://  if (a < 2) write(3);
 40 :acc16= variable 0
 41 :accom16 constant 2
 42 :brge 45
 43 :acc8= constant 3
 44 :call writeAcc8
 45 ://  if (a <= 2) write(2);
 46 :acc16= variable 0
 47 :accom16 constant 2
 48 :brgt 51
 49 :acc8= constant 2
 50 :call writeAcc8
 51 ://  if (a <= 1) write(1);
 52 :acc16= variable 0
 53 :accom16 constant 1
 54 :brgt 57
 55 :acc8= constant 1
 56 :call writeAcc8
 57 ://  write(0);
 58 :acc8= constant 0
 59 :call writeAcc8
 60 ://}
 61 :stop
