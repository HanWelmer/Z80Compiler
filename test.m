  0 ;test.p(0) /*
  1 ;test.p(1)  * A small program in the miniJava language.
  2 ;test.p(2)  * Test comparisons
  3 ;test.p(3)  */
  4 ;test.p(4) class TestIf {
  5 ;test.p(5)   write(16);
  6 acc8= constant 16
  7 call writeAcc8
  8 ;test.p(6)   if (4 >= 4) write(15);
  9 acc8= constant 4
 10 accom8 constant 4
 11 brlt 15
 12 acc8= constant 15
 13 call writeAcc8
 14 ;test.p(7)   if (4 >= (12/(1+2))) write(14);
 15 acc8= constant 4
 16 <acc8= constant 12
 17 <acc8= constant 1
 18 acc8+ constant 2
 19 /acc8 unstack
 20 comacc8 unstack
 21 brgt 25
 22 acc8= constant 14
 23 call writeAcc8
 24 ;test.p(8)   if (5 >= 4) write(13);
 25 acc8= constant 5
 26 accom8 constant 4
 27 brlt 31
 28 acc8= constant 13
 29 call writeAcc8
 30 ;test.p(9)   if (5 >= (12/(1+2))) write(12);
 31 acc8= constant 5
 32 <acc8= constant 12
 33 <acc8= constant 1
 34 acc8+ constant 2
 35 /acc8 unstack
 36 comacc8 unstack
 37 brgt 41
 38 acc8= constant 12
 39 call writeAcc8
 40 ;test.p(10)   if (4 <= 4) write(11);
 41 acc8= constant 4
 42 accom8 constant 4
 43 brgt 47
 44 acc8= constant 11
 45 call writeAcc8
 46 ;test.p(11)   if (4 <= (12/(1+2))) write(10);
 47 acc8= constant 4
 48 <acc8= constant 12
 49 <acc8= constant 1
 50 acc8+ constant 2
 51 /acc8 unstack
 52 comacc8 unstack
 53 brlt 57
 54 acc8= constant 10
 55 call writeAcc8
 56 ;test.p(12)   if (3 <= 4) write(9);
 57 acc8= constant 3
 58 accom8 constant 4
 59 brgt 63
 60 acc8= constant 9
 61 call writeAcc8
 62 ;test.p(13)   if (3 <= (12/(1+2))) write(8);
 63 acc8= constant 3
 64 <acc8= constant 12
 65 <acc8= constant 1
 66 acc8+ constant 2
 67 /acc8 unstack
 68 comacc8 unstack
 69 brlt 73
 70 acc8= constant 8
 71 call writeAcc8
 72 ;test.p(14)   if (5 > 4) write(7);
 73 acc8= constant 5
 74 accom8 constant 4
 75 brle 79
 76 acc8= constant 7
 77 call writeAcc8
 78 ;test.p(15)   if (5 > (12/(1+2))) write(6);
 79 acc8= constant 5
 80 <acc8= constant 12
 81 <acc8= constant 1
 82 acc8+ constant 2
 83 /acc8 unstack
 84 comacc8 unstack
 85 brge 89
 86 acc8= constant 6
 87 call writeAcc8
 88 ;test.p(16)   if (3 < 4) write(5);
 89 acc8= constant 3
 90 accom8 constant 4
 91 brge 95
 92 acc8= constant 5
 93 call writeAcc8
 94 ;test.p(17)   if (3 < (12/(1+2))) write(4);
 95 acc8= constant 3
 96 <acc8= constant 12
 97 <acc8= constant 1
 98 acc8+ constant 2
 99 /acc8 unstack
100 comacc8 unstack
101 brle 105
102 acc8= constant 4
103 call writeAcc8
104 ;test.p(18)   if (3 != 4) write(3);
105 acc8= constant 3
106 accom8 constant 4
107 breq 111
108 acc8= constant 3
109 call writeAcc8
110 ;test.p(19)   if (3 != (12/(1+2))) write(2);
111 acc8= constant 3
112 <acc8= constant 12
113 <acc8= constant 1
114 acc8+ constant 2
115 /acc8 unstack
116 comacc8 unstack
117 breq 121
118 acc8= constant 2
119 call writeAcc8
120 ;test.p(20)   if (4 == 4) write(1);
121 acc8= constant 4
122 accom8 constant 4
123 brne 127
124 acc8= constant 1
125 call writeAcc8
126 ;test.p(21)   if (4 == (12/(1+2))) write(0);
127 acc8= constant 4
128 <acc8= constant 12
129 <acc8= constant 1
130 acc8+ constant 2
131 /acc8 unstack
132 comacc8 unstack
133 brne 137
134 acc8= constant 0
135 call writeAcc8
136 ;test.p(22) }
137 stop
