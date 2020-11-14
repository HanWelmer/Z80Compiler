  0 :///* Program to test multiplication */
  1 ://class TestMuliply {
  2 ://  write(14);
  3 :acc8= constant 14
  4 :call writeAcc8
  5 ://  int a = 14;
  6 :acc8= constant 14
  7 :acc8ToAcc16
  8 :acc16=> variable 0
  9 ://  a--;
 10 :decr16 variable 0
 11 ://  write(a);
 12 :acc16= variable 0
 13 :call writeAcc16
 14 ://  a = 11;
 15 :acc8= constant 11
 16 :acc8ToAcc16
 17 :acc16=> variable 0
 18 ://  a++;
 19 :incr16 variable 0
 20 ://  write(a);
 21 :acc16= variable 0
 22 :call writeAcc16
 23 ://  if (6561 / 729 == 9) write (11); else write (0);
 24 :acc16= constant 6561
 25 :acc16/ constant 729
 26 :<acc16= acc16
 27 :accom16 constant 9
 28 :brne 32
 29 :acc8= constant 11
 30 :call writeAcc8
 31 :br 34
 32 :acc8= constant 0
 33 :call writeAcc8
 34 ://  if (729 * 9 == 6561) write (10); else write (0);
 35 :acc16= constant 729
 36 :acc16* constant 9
 37 :<acc16= acc16
 38 :accom16 constant 6561
 39 :brne 43
 40 :acc8= constant 10
 41 :call writeAcc8
 42 :br 45
 43 :acc8= constant 0
 44 :call writeAcc8
 45 ://  if (729 == 729) write (9); else write (0);
 46 :acc16= constant 729
 47 :accom16 constant 729
 48 :brne 52
 49 :acc8= constant 9
 50 :call writeAcc8
 51 :br 54
 52 :acc8= constant 0
 53 :call writeAcc8
 54 ://  if (2 * 9 * 9 == 162) write (8); else write (0);
 55 :acc8= constant 2
 56 :acc8* constant 9
 57 :acc8* constant 9
 58 :<acc8= acc8
 59 :accom8 constant 162
 60 :brne 64
 61 :acc8= constant 8
 62 :call writeAcc8
 63 :br 66
 64 :acc8= constant 0
 65 :call writeAcc8
 66 ://  if (7 * 5 == 35) write (7); else write (0);
 67 :acc8= constant 7
 68 :acc8* constant 5
 69 :<acc8= acc8
 70 :accom8 constant 35
 71 :brne 75
 72 :acc8= constant 7
 73 :call writeAcc8
 74 :br 77
 75 :acc8= constant 0
 76 :call writeAcc8
 77 ://  a = 2;
 78 :acc8= constant 2
 79 :acc8ToAcc16
 80 :acc16=> variable 0
 81 ://  write(3 * a);
 82 :acc8= constant 3
 83 :acc8ToAcc16
 84 :acc16* variable 0
 85 :call writeAcc16
 86 ://  a = 1;
 87 :acc8= constant 1
 88 :acc8ToAcc16
 89 :acc16=> variable 0
 90 ://  write(a * 5);
 91 :acc16= variable 0
 92 :acc16* constant 5
 93 :call writeAcc16
 94 ://  a = 2 * 2;
 95 :acc8= constant 2
 96 :acc8* constant 2
 97 :acc8ToAcc16
 98 :acc16=> variable 0
 99 ://  write(a);
100 :acc16= variable 0
101 :call writeAcc16
102 ://  write(1 * 3);
103 :acc8= constant 1
104 :acc8* constant 3
105 :call writeAcc8
106 ://  write(2 * 1);
107 :acc8= constant 2
108 :acc8* constant 1
109 :call writeAcc8
110 ://  write(1 * 1);
111 :acc8= constant 1
112 :acc8* constant 1
113 :call writeAcc8
114 ://  write(1 * 0);
115 :acc8= constant 1
116 :acc8* constant 0
117 :call writeAcc8
118 ://}
119 :stop
