  0 :///* Program to test multiplication */
  1 ://class TestMuliply {
  2 ://  write(14);
  3 ://  int a = 14;
  4 :acc8= constant 14
  5 :call writeAcc8
  6 :acc8= constant 14
  7 :acc8ToAcc16
  8 :acc16=> variable 0
  9 ://  a--;
 10 :decr16 variable 0
 11 ://  write(a);
 12 ://  a = 11;
 13 :acc16= variable 0
 14 :call writeAcc16
 15 :acc8= constant 11
 16 :acc8ToAcc16
 17 :acc16=> variable 0
 18 ://  a++;
 19 :incr16 variable 0
 20 ://  write(a);
 21 ://  if (6561 / 729 == 9) write (11); else write (0);
 22 :acc16= variable 0
 23 :call writeAcc16
 24 :acc16= constant 6561
 25 :acc16/ constant 729
 26 :<acc16= acc16
 27 :accom16 constant 9
 28 :brne 32
 29 :acc8= constant 11
 30 :call writeAcc8
 31 :br 35
 32 ://  if (729 * 9 == 6561) write (10); else write (0);
 33 :acc8= constant 0
 34 :call writeAcc8
 35 :acc16= constant 729
 36 :acc16* constant 9
 37 :<acc16= acc16
 38 :accom16 constant 6561
 39 :brne 43
 40 :acc8= constant 10
 41 :call writeAcc8
 42 :br 46
 43 ://  if (729 == 729) write (9); else write (0);
 44 :acc8= constant 0
 45 :call writeAcc8
 46 :acc16= constant 729
 47 :accom16 constant 729
 48 :brne 52
 49 :acc8= constant 9
 50 :call writeAcc8
 51 :br 55
 52 ://  if (2 * 9 * 9 == 162) write (8); else write (0);
 53 :acc8= constant 0
 54 :call writeAcc8
 55 :acc8= constant 2
 56 :acc8* constant 9
 57 :acc8* constant 9
 58 :<acc8= acc8
 59 :accom8 constant 162
 60 :brne 64
 61 :acc8= constant 8
 62 :call writeAcc8
 63 :br 67
 64 ://  if (7 * 5 == 35) write (7); else write (0);
 65 :acc8= constant 0
 66 :call writeAcc8
 67 :acc8= constant 7
 68 :acc8* constant 5
 69 :<acc8= acc8
 70 :accom8 constant 35
 71 :brne 75
 72 :acc8= constant 7
 73 :call writeAcc8
 74 :br 78
 75 ://  a = 2;
 76 :acc8= constant 0
 77 :call writeAcc8
 78 :acc8= constant 2
 79 :acc8ToAcc16
 80 :acc16=> variable 0
 81 ://  write(3 * a);
 82 :acc8= constant 3
 83 :acc8ToAcc16
 84 :acc16* variable 0
 85 ://  a = 1;
 86 :call writeAcc16
 87 :acc8= constant 1
 88 :acc8ToAcc16
 89 :acc16=> variable 0
 90 ://  write(a * 5);
 91 :acc16= variable 0
 92 :acc16* constant 5
 93 ://  a = 2 * 2;
 94 :call writeAcc16
 95 :acc8= constant 2
 96 :acc8* constant 2
 97 :acc8ToAcc16
 98 :acc16=> variable 0
 99 ://  write(a);
100 ://  write(1 * 3);
101 :acc16= variable 0
102 :call writeAcc16
103 :acc8= constant 1
104 :acc8* constant 3
105 ://  write(2 * 1);
106 :call writeAcc8
107 :acc8= constant 2
108 :acc8* constant 1
109 ://  write(1 * 1);
110 :call writeAcc8
111 :acc8= constant 1
112 :acc8* constant 1
113 ://  write(1 * 0);
114 :call writeAcc8
115 :acc8= constant 1
116 :acc8* constant 0
117 ://}
118 :call writeAcc8
119 :stop
