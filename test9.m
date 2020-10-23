  0 :///* Program to test multiplication */
  1 ://class TestMuliply {
  2 ://  byte b = 9;
  3 :acc8= constant 9
  4 :acc8=> variable 0
  5 ://  int i = 6561;
  6 :acc16= constant 6561
  7 :acc16=> variable 1
  8 ://  if (i > b) write (9); else write (0);
  9 :acc16= variable 1
 10 :accom16 variable 0
 11 :brle 15
 12 :acc8= constant 9
 13 :call writeAcc8
 14 :br 18
 15 ://  if (b < i) write (8); else write (0);
 16 :acc8= constant 0
 17 :call writeAcc8
 18 :acc8= variable 0
 19 :acc8ToAcc16
 20 :accom16 variable 1
 21 :brge 25
 22 :acc8= constant 8
 23 :call writeAcc8
 24 :br 28
 25 ://  if (i > 3 * 3) write (7); else write (0);
 26 :acc8= constant 0
 27 :call writeAcc8
 28 :acc16= variable 1
 29 :acc8= constant 3
 30 :acc8* constant 3
 31 :accom16 acc8
 32 :brle 36
 33 :acc8= constant 7
 34 :call writeAcc8
 35 :br 39
 36 ://  if (b < 6561 * 1) write (6); else write (0);
 37 :acc8= constant 0
 38 :call writeAcc8
 39 :acc8= variable 0
 40 :acc16= constant 6561
 41 :acc16* constant 1
 42 :acc16CompareAcc8
 43 :brge 47
 44 :acc8= constant 6
 45 :call writeAcc8
 46 :br 50
 47 ://  if (6561 > 3 * 3) write (5); else write (0);
 48 :acc8= constant 0
 49 :call writeAcc8
 50 :acc16= constant 6561
 51 :acc8= constant 3
 52 :acc8* constant 3
 53 :accom16 acc8
 54 :brle 58
 55 :acc8= constant 5
 56 :call writeAcc8
 57 :br 61
 58 ://  if (3 * 3 < 6561) write (4); else write (0);
 59 :acc8= constant 0
 60 :call writeAcc8
 61 :acc8= constant 3
 62 :acc8* constant 3
 63 :<acc8= acc8
 64 :acc8ToAcc16
 65 :accom16 constant 6561
 66 :brge 70
 67 :acc8= constant 4
 68 :call writeAcc8
 69 :br 73
 70 ://  if (9 < 6561) write (3); else write (0);
 71 :acc8= constant 0
 72 :call writeAcc8
 73 :acc8= constant 9
 74 :acc8ToAcc16
 75 :accom16 constant 6561
 76 :brge 80
 77 :acc8= constant 3
 78 :call writeAcc8
 79 :br 83
 80 ://  if (6561 > 9) write (2); else write (0);
 81 :acc8= constant 0
 82 :call writeAcc8
 83 :acc16= constant 6561
 84 :accom16 constant 9
 85 :brle 89
 86 :acc8= constant 2
 87 :call writeAcc8
 88 :br 92
 89 ://  write(1);
 90 :acc8= constant 0
 91 :call writeAcc8
 92 ://  write(0);
 93 :acc8= constant 1
 94 :call writeAcc8
 95 ://}
 96 :acc8= constant 0
 97 :call writeAcc8
 98 :stop
