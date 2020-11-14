  0 :///* Program to test division */
  1 ://class TestMultiplyDivide {
  2 ://  write(11);
  3 :acc8= constant 11
  4 :call writeAcc8
  5 ://  write((4 * 5) / 2);
  6 :acc8= constant 4
  7 :acc8* constant 5
  8 :acc8/ constant 2
  9 :call writeAcc8
 10 ://  write((7 * 7 + 5) / 6);
 11 :acc8= constant 7
 12 :acc8* constant 7
 13 :acc8+ constant 5
 14 :acc8/ constant 6
 15 :call writeAcc8
 16 ://  write((4 * 5 * 2) / 5);
 17 :acc8= constant 4
 18 :acc8* constant 5
 19 :acc8* constant 2
 20 :acc8/ constant 5
 21 :call writeAcc8
 22 ://  write((7 * 7) / 7);
 23 :acc8= constant 7
 24 :acc8* constant 7
 25 :acc8/ constant 7
 26 :call writeAcc8
 27 ://  write((3 * 8) / 4);
 28 :acc8= constant 3
 29 :acc8* constant 8
 30 :acc8/ constant 4
 31 :call writeAcc8
 32 ://  write(5 / 1);
 33 :acc8= constant 5
 34 :acc8/ constant 1
 35 :call writeAcc8
 36 ://  write(8 / 2);
 37 :acc8= constant 8
 38 :acc8/ constant 2
 39 :call writeAcc8
 40 ://  write(9 / 3);
 41 :acc8= constant 9
 42 :acc8/ constant 3
 43 :call writeAcc8
 44 ://  write(4 / 2);
 45 :acc8= constant 4
 46 :acc8/ constant 2
 47 :call writeAcc8
 48 ://  write(1 * 1);
 49 :acc8= constant 1
 50 :acc8* constant 1
 51 :call writeAcc8
 52 ://  write(0 * 1);
 53 :acc8= constant 0
 54 :acc8* constant 1
 55 :call writeAcc8
 56 ://}
 57 :stop
