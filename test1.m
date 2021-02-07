  0 ;test1.p(0) /* Program to test generated Z80 assembler code */
  1 ;test1.p(1) class TestWhile {
  2 ;test1.p(2)   write(15);
  3 acc8= constant 15
  4 call writeAcc8
  5 ;test1.p(3)   for(byte i = 0; i<1; i = i + 1) {
  6 acc8= constant 0
  7 acc8=> variable 0
  8 acc8= variable 0
  9 accom8 constant 1
 10 brge 22
 11 br 16
 12 acc8= variable 0
 13 acc8+ constant 1
 14 acc8=> variable 0
 15 br 8
 16 ;test1.p(4)     write(14);
 17 acc8= constant 14
 18 call writeAcc8
 19 ;test1.p(5)   }
 20 br 12
 21 ;test1.p(6)   int b = 13;
 22 acc8= constant 13
 23 acc8ToAcc16
 24 acc16=> variable 0
 25 ;test1.p(7)   write(b);
 26 acc16= variable 0
 27 call writeAcc16
 28 ;test1.p(8)   //start a new scope
 29 ;test1.p(9)   byte p = 12;
 30 acc8= constant 12
 31 acc8=> variable 2
 32 ;test1.p(10)   while (p > 11) {
 33 acc8= variable 2
 34 accom8 constant 11
 35 brle 51
 36 ;test1.p(11)     int test = 1;
 37 acc8= constant 1
 38 acc8ToAcc16
 39 acc16=> variable 3
 40 ;test1.p(12)     write(p);
 41 acc8= variable 2
 42 call writeAcc8
 43 ;test1.p(13)     p = p - 1;
 44 acc8= variable 2
 45 acc8- constant 1
 46 acc8=> variable 2
 47 ;test1.p(14)   }
 48 ;test1.p(15)   //start a new scope
 49 ;test1.p(16)   while (p > 9) {
 50 br 33
 51 acc8= variable 2
 52 accom8 constant 9
 53 brle 68
 54 ;test1.p(17)     int test = 2;
 55 acc8= constant 2
 56 acc8ToAcc16
 57 acc16=> variable 3
 58 ;test1.p(18)     write(p);
 59 acc8= variable 2
 60 call writeAcc8
 61 ;test1.p(19)     p = p - 1;
 62 acc8= variable 2
 63 acc8- constant 1
 64 acc8=> variable 2
 65 ;test1.p(20)   }
 66 ;test1.p(21)   byte a = 9;
 67 br 51
 68 acc8= constant 9
 69 acc8=> variable 3
 70 ;test1.p(22)   while (a >= 7) {
 71 acc8= variable 3
 72 accom8 constant 7
 73 brlt 84
 74 ;test1.p(23)     write(a);
 75 acc8= variable 3
 76 call writeAcc8
 77 ;test1.p(24)     a = a - 1;
 78 acc8= variable 3
 79 acc8- constant 1
 80 acc8=> variable 3
 81 ;test1.p(25)   }
 82 ;test1.p(26)   do {
 83 br 71
 84 ;test1.p(27)     int test = 1;
 85 acc8= constant 1
 86 acc8ToAcc16
 87 acc16=> variable 4
 88 ;test1.p(28)     write(a);
 89 acc8= variable 3
 90 call writeAcc8
 91 ;test1.p(29)     a = a - 1;
 92 acc8= variable 3
 93 acc8- constant 1
 94 acc8=> variable 3
 95 ;test1.p(30)   } while (a > 5);
 96 acc8= variable 3
 97 accom16 constant 5
 98 brge 84
 99 ;test1.p(31)   for(byte i = 3; i<=4; i++) {
100 acc8= constant 3
101 acc8=> variable 4
102 acc8= variable 4
103 accom8 constant 4
104 brgt 120
105 br 108
106 incr8 variable 4
107 br 102
108 ;test1.p(32)     int test = 1;
109 acc8= constant 1
110 acc8ToAcc16
111 acc16=> variable 5
112 ;test1.p(33)     write(a);
113 acc8= variable 3
114 call writeAcc8
115 ;test1.p(34)     a--;
116 decr8 variable 3
117 ;test1.p(35)   }
118 br 106
119 ;test1.p(36)   for(int i = 3; i!=0; i--) {
120 acc8= constant 3
121 acc8ToAcc16
122 acc16=> variable 4
123 acc16= variable 4
124 accom16 constant 0
125 breq 141
126 br 129
127 decr16 variable 4
128 br 123
129 ;test1.p(37)     int test = 1;
130 acc8= constant 1
131 acc8ToAcc16
132 acc16=> variable 6
133 ;test1.p(38)     write(i);
134 acc16= variable 4
135 call writeAcc16
136 ;test1.p(39)     a--;
137 decr8 variable 3
138 ;test1.p(40)   }
139 br 127
140 ;test1.p(41)   write(a);
141 acc8= variable 3
142 call writeAcc8
143 ;test1.p(42) }
144 stop
