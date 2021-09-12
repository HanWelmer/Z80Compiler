  0 ;test3.p(0) /* Program to test multiplication */
  1 ;test3.p(1) class TestMultiply {
  2 ;test3.p(2)   write(14);
  3 acc8= constant 14
  4 call writeAcc8
  5 ;test3.p(3)   int a = 14;
  6 acc8= constant 14
  7 acc8ToAcc16
  8 acc16=> variable 0
  9 ;test3.p(4)   a--;
 10 decr16 variable 0
 11 ;test3.p(5)   write(a);
 12 acc16= variable 0
 13 call writeAcc16
 14 ;test3.p(6)   a = 11;
 15 acc8= constant 11
 16 acc8ToAcc16
 17 acc16=> variable 0
 18 ;test3.p(7)   a++;
 19 incr16 variable 0
 20 ;test3.p(8)   write(a);
 21 acc16= variable 0
 22 call writeAcc16
 23 ;test3.p(9)   if (6561 / 729 == 9) write (11); else write (0);
 24 acc16= constant 6561
 25 acc16/ constant 729
 26 acc8= constant 9
 27 acc16CompareAcc8
 28 brne 32
 29 acc8= constant 11
 30 call writeAcc8
 31 br 35
 32 acc8= constant 0
 33 call writeAcc8
 34 ;test3.p(10)   if (729 * 9 == 6561) write (10); else write (0);
 35 acc16= constant 729
 36 acc16* constant 9
 37 acc16Comp constant 6561
 38 brne 42
 39 acc8= constant 10
 40 call writeAcc8
 41 br 45
 42 acc8= constant 0
 43 call writeAcc8
 44 ;test3.p(11)   if (729 == 729) write (9); else write (0);
 45 acc16= constant 729
 46 acc16Comp constant 729
 47 brne 51
 48 acc8= constant 9
 49 call writeAcc8
 50 br 54
 51 acc8= constant 0
 52 call writeAcc8
 53 ;test3.p(12)   if (2 * 9 * 9 == 162) write (8); else write (0);
 54 acc8= constant 2
 55 acc8* constant 9
 56 acc8* constant 9
 57 acc8Comp constant 162
 58 brne 62
 59 acc8= constant 8
 60 call writeAcc8
 61 br 65
 62 acc8= constant 0
 63 call writeAcc8
 64 ;test3.p(13)   if (7 * 5 == 35) write (7); else write (0);
 65 acc8= constant 7
 66 acc8* constant 5
 67 acc8Comp constant 35
 68 brne 72
 69 acc8= constant 7
 70 call writeAcc8
 71 br 75
 72 acc8= constant 0
 73 call writeAcc8
 74 ;test3.p(14)   a = 2;
 75 acc8= constant 2
 76 acc8ToAcc16
 77 acc16=> variable 0
 78 ;test3.p(15)   write(3 * a);
 79 acc8= constant 3
 80 acc8ToAcc16
 81 acc16* variable 0
 82 call writeAcc16
 83 ;test3.p(16)   a = 1;
 84 acc8= constant 1
 85 acc8ToAcc16
 86 acc16=> variable 0
 87 ;test3.p(17)   write(a * 5);
 88 acc16= variable 0
 89 acc16* constant 5
 90 call writeAcc16
 91 ;test3.p(18)   a = 2 * 2;
 92 acc8= constant 2
 93 acc8* constant 2
 94 acc8ToAcc16
 95 acc16=> variable 0
 96 ;test3.p(19)   write(a);
 97 acc16= variable 0
 98 call writeAcc16
 99 ;test3.p(20)   write(1 * 3);
100 acc8= constant 1
101 acc8* constant 3
102 call writeAcc8
103 ;test3.p(21)   write(2 * 1);
104 acc8= constant 2
105 acc8* constant 1
106 call writeAcc8
107 ;test3.p(22)   write(1 * 1);
108 acc8= constant 1
109 acc8* constant 1
110 call writeAcc8
111 ;test3.p(23)   write(1 * 0);
112 acc8= constant 1
113 acc8* constant 0
114 call writeAcc8
115 ;test3.p(24) }
116 stop
