  0 :///* Program to test branch instructions */
  1 ://class TestBranches {
  2 ://  write(9);
  3 ://  int a = 1;
  4 :acc8= constant 9
  5 :call writeAcc8
  6 :acc8= constant 1
  7 :acc8ToAcc16
  8 :acc16=> variable 0
  9 ://  if (a == 1) write(8);
 10 :acc16= variable 0
 11 :accom16 constant 1
 12 :brne 16
 13 ://  if (a != 0) write(7);
 14 :acc8= constant 8
 15 :call writeAcc8
 16 :acc16= variable 0
 17 :accom16 constant 0
 18 :breq 22
 19 ://  if (a > 0) write(6);
 20 :acc8= constant 7
 21 :call writeAcc8
 22 :acc16= variable 0
 23 :accom16 constant 0
 24 :brle 28
 25 ://  if (a >= 0) write(5);
 26 :acc8= constant 6
 27 :call writeAcc8
 28 :acc16= variable 0
 29 :accom16 constant 0
 30 :brlt 34
 31 ://  if (a >= 1) write(4);
 32 :acc8= constant 5
 33 :call writeAcc8
 34 :acc16= variable 0
 35 :accom16 constant 1
 36 :brlt 40
 37 ://  if (a < 2) write(3);
 38 :acc8= constant 4
 39 :call writeAcc8
 40 :acc16= variable 0
 41 :accom16 constant 2
 42 :brge 46
 43 ://  if (a <= 2) write(2);
 44 :acc8= constant 3
 45 :call writeAcc8
 46 :acc16= variable 0
 47 :accom16 constant 2
 48 :brgt 52
 49 ://  if (a <= 1) write(1);
 50 :acc8= constant 2
 51 :call writeAcc8
 52 :acc16= variable 0
 53 :accom16 constant 1
 54 :brgt 58
 55 ://  write(0);
 56 :acc8= constant 1
 57 :call writeAcc8
 58 ://}
 59 :acc8= constant 0
 60 :call writeAcc8
 61 :stop
