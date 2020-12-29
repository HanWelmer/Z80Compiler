  0 ;test3.p(0) /* Program to test multiplication */
  1 ;test3.p(1) class TestMuliply {
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
 26 accom16 constant 9
 27 brne 31
 28 acc8= constant 11
 29 call writeAcc8
 30 br 34
 31 acc8= constant 0
 32 call writeAcc8
 33 ;test3.p(10)   if (729 * 9 == 6561) write (10); else write (0);
 34 acc16= constant 729
 35 acc16* constant 9
 36 accom16 constant 6561
 37 brne 41
 38 acc8= constant 10
 39 call writeAcc8
 40 br 44
 41 acc8= constant 0
 42 call writeAcc8
 43 ;test3.p(11)   if (729 == 729) write (9); else write (0);
 44 acc16= constant 729
 45 accom16 constant 729
 46 brne 50
 47 acc8= constant 9
 48 call writeAcc8
 49 br 53
 50 acc8= constant 0
 51 call writeAcc8
 52 ;test3.p(12)   if (2 * 9 * 9 == 162) write (8); else write (0);
 53 acc8= constant 2
 54 acc8* constant 9
 55 acc8* constant 9
 56 accom8 constant 162
 57 brne 61
 58 acc8= constant 8
 59 call writeAcc8
 60 br 64
 61 acc8= constant 0
 62 call writeAcc8
 63 ;test3.p(13)   if (7 * 5 == 35) write (7); else write (0);
 64 acc8= constant 7
 65 acc8* constant 5
 66 accom8 constant 35
 67 brne 71
 68 acc8= constant 7
 69 call writeAcc8
 70 br 74
 71 acc8= constant 0
 72 call writeAcc8
 73 ;test3.p(14)   a = 2;
 74 acc8= constant 2
 75 acc8ToAcc16
 76 acc16=> variable 0
 77 ;test3.p(15)   write(3 * a);
 78 acc8= constant 3
 79 acc8ToAcc16
 80 acc16* variable 0
 81 call writeAcc16
 82 ;test3.p(16)   a = 1;
 83 acc8= constant 1
 84 acc8ToAcc16
 85 acc16=> variable 0
 86 ;test3.p(17)   write(a * 5);
 87 acc16= variable 0
 88 acc16* constant 5
 89 call writeAcc16
 90 ;test3.p(18)   a = 2 * 2;
 91 acc8= constant 2
 92 acc8* constant 2
 93 acc8ToAcc16
 94 acc16=> variable 0
 95 ;test3.p(19)   write(a);
 96 acc16= variable 0
 97 call writeAcc16
 98 ;test3.p(20)   write(1 * 3);
 99 acc8= constant 1
100 acc8* constant 3
101 call writeAcc8
102 ;test3.p(21)   write(2 * 1);
103 acc8= constant 2
104 acc8* constant 1
105 call writeAcc8
106 ;test3.p(22)   write(1 * 1);
107 acc8= constant 1
108 acc8* constant 1
109 call writeAcc8
110 ;test3.p(23)   write(1 * 0);
111 acc8= constant 1
112 acc8* constant 0
113 call writeAcc8
114 ;test3.p(24) }
115 stop
