  0 :///* Program to test division */
  1 ://class TestMultiplyDivide {
  2 ://  write(11);
  3 ://  write((4 * 5) / 2);
  4 :acc8= constant 11
  5 :call writeAcc8
  6 :acc8= constant 4
  7 :acc8* constant 5
  8 :acc8/ constant 2
  9 ://  write((7 * 7 + 5) / 6);
 10 :call writeAcc8
 11 :acc8= constant 7
 12 :acc8* constant 7
 13 :acc8+ constant 5
 14 :acc8/ constant 6
 15 ://  write((4 * 5 * 2) / 5);
 16 :call writeAcc8
 17 :acc8= constant 4
 18 :acc8* constant 5
 19 :acc8* constant 2
 20 :acc8/ constant 5
 21 ://  write((7 * 7) / 7);
 22 :call writeAcc8
 23 :acc8= constant 7
 24 :acc8* constant 7
 25 :acc8/ constant 7
 26 ://  write((3 * 8) / 4);
 27 :call writeAcc8
 28 :acc8= constant 3
 29 :acc8* constant 8
 30 :acc8/ constant 4
 31 ://  write(5 / 1);
 32 :call writeAcc8
 33 :acc8= constant 5
 34 :acc8/ constant 1
 35 ://  write(8 / 2);
 36 :call writeAcc8
 37 :acc8= constant 8
 38 :acc8/ constant 2
 39 ://  write(9 / 3);
 40 :call writeAcc8
 41 :acc8= constant 9
 42 :acc8/ constant 3
 43 ://  write(4 / 2);
 44 :call writeAcc8
 45 :acc8= constant 4
 46 :acc8/ constant 2
 47 ://  write(1 * 1);
 48 :call writeAcc8
 49 :acc8= constant 1
 50 :acc8* constant 1
 51 ://  write(0 * 1);
 52 :call writeAcc8
 53 :acc8= constant 0
 54 :acc8* constant 1
 55 ://}
 56 :call writeAcc8
 57 :stop
