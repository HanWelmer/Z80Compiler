  0 ;test1.p(0) /* Program to test generated Z80 assembler code */
  1 ;test1.p(1) class TestWhile {
  2 ;test1.p(2)   write(14);
  3 acc8= constant 14
  4 call writeAcc8
  5 ;test1.p(3)   int b = 13;
  6 acc8= constant 13
  7 acc8ToAcc16
  8 acc16=> variable 0
  9 ;test1.p(4)   write(b);
 10 acc16= variable 0
 11 call writeAcc16
 12 ;test1.p(5)   //start a new scope
 13 ;test1.p(6)   byte p = 12;
 14 acc8= constant 12
 15 acc8=> variable 2
 16 ;test1.p(7)   while (p > 11) {
 17 acc8= variable 2
 18 accom8 constant 11
 19 brle 35
 20 ;test1.p(8)     int test = 1;
 21 acc8= constant 1
 22 acc8ToAcc16
 23 acc16=> variable 3
 24 ;test1.p(9)     write(p);
 25 acc8= variable 2
 26 call writeAcc8
 27 ;test1.p(10)     p = p - 1;
 28 acc8= variable 2
 29 acc8- constant 1
 30 acc8=> variable 2
 31 ;test1.p(11)   }
 32 ;test1.p(12)   //start a new scope
 33 ;test1.p(13)   while (p > 9) {
 34 br 16
 35 acc8= variable 2
 36 accom8 constant 9
 37 brle 52
 38 ;test1.p(14)     int test = 2;
 39 acc8= constant 2
 40 acc8ToAcc16
 41 acc16=> variable 3
 42 ;test1.p(15)     write(p);
 43 acc8= variable 2
 44 call writeAcc8
 45 ;test1.p(16)     p = p - 1;
 46 acc8= variable 2
 47 acc8- constant 1
 48 acc8=> variable 2
 49 ;test1.p(17)   }
 50 ;test1.p(18)   byte a = 9;
 51 br 35
 52 acc8= constant 9
 53 acc8=> variable 3
 54 ;test1.p(19)   while (a >= 7) {
 55 acc8= variable 3
 56 accom8 constant 7
 57 brlt 68
 58 ;test1.p(20)     write(a);
 59 acc8= variable 3
 60 call writeAcc8
 61 ;test1.p(21)     a = a - 1;
 62 acc8= variable 3
 63 acc8- constant 1
 64 acc8=> variable 3
 65 ;test1.p(22)   }
 66 ;test1.p(23)   do {
 67 br 54
 68 ;test1.p(24)     int test = 1;
 69 acc8= constant 1
 70 acc8ToAcc16
 71 acc16=> variable 4
 72 ;test1.p(25)     write(a);
 73 acc8= variable 3
 74 call writeAcc8
 75 ;test1.p(26)     a = a - 1;
 76 acc8= variable 3
 77 acc8- constant 1
 78 acc8=> variable 3
 79 ;test1.p(27)   } while (a > 5);
 80 <acc8= variable 3
 81 accom16 constant 5
 82 brge 68
 83 ;test1.p(28)   for(byte i = 3; i<=4; i++) {
 84 acc8= constant 3
 85 acc8=> variable 4
 86 <acc8= variable 4
 87 accom8 constant 4
 88 brgt 104
 89 br 92
 90 incr8 variable 4
 91 br 86
 92 ;test1.p(29)     int test = 1;
 93 acc8= constant 1
 94 acc8ToAcc16
 95 acc16=> variable 5
 96 ;test1.p(30)     write(a);
 97 acc8= variable 3
 98 call writeAcc8
 99 ;test1.p(31)     a--;
100 decr8 variable 3
101 ;test1.p(32)   }
102 ;test1.p(33)   for(int i = 3; i!=0; i--) {
103 br 90
104 acc8= constant 3
105 acc8ToAcc16
106 acc16=> variable 4
107 <acc16= variable 4
108 accom16 constant 0
109 breq 125
110 br 113
111 decr16 variable 4
112 br 107
113 ;test1.p(34)     int test = 1;
114 acc8= constant 1
115 acc8ToAcc16
116 acc16=> variable 6
117 ;test1.p(35)     write(i);
118 acc16= variable 4
119 call writeAcc16
120 ;test1.p(36)     a--;
121 decr8 variable 3
122 ;test1.p(37)   }
123 ;test1.p(38)   write(a);
124 br 111
125 acc8= variable 3
126 call writeAcc8
127 ;test1.p(39) }
128 stop
