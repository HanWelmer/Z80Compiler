  0 ;test5.p(0) /*
  1 ;test5.p(1)  * A small program in the miniJava language.
  2 ;test5.p(2)  * Test comparisons
  3 ;test5.p(3)  */
  4 ;test5.p(4) class TestIf {
  5 ;test5.p(5)   //integer
  6 ;test5.p(6)   /*
  7 ;test5.p(7)   write(32);
  8 ;test5.p(8)   if (400 >= 400) write(31);
  9 ;test5.p(9)   if (400 >= (1200/(1+2))) write(30);
 10 ;test5.p(10)   if (500 >= 400) write(29);
 11 ;test5.p(11)   if (500 >= (1200/(1+2))) write(28);
 12 ;test5.p(12)   if (400 <= 400) write(27);
 13 ;test5.p(13)   if (400 <= (1200/(1+2))) write(26);
 14 ;test5.p(14)   if (300 <= 400) write(25);
 15 ;test5.p(15)   if (300 <= (1200/(1+2))) write(24);
 16 ;test5.p(16)   if (500 > 400) write(23);
 17 ;test5.p(17)   if (500 > (1200/(1+2))) write(22);
 18 ;test5.p(18)   if (300 < 400) write(21);
 19 ;test5.p(19)   if (300 < (1200/(1+2))) write(20);
 20 ;test5.p(20)   if (300 != 400) write(19);
 21 ;test5.p(21)   if (300 != (1200/(1+2))) write(18);
 22 ;test5.p(22)   if (400 == 400) write(17);
 23 ;test5.p(23)   if (400 == (1200/(1+2))) write(16);
 24 ;test5.p(24)   */
 25 ;test5.p(25)   //byte
 26 ;test5.p(26)   if (4 >= 4) write(15);
 27 acc8= constant 4
 28 accom8 constant 4
 29 brlt 33
 30 acc8= constant 15
 31 call writeAcc8
 32 ;test5.p(27)   if (4 >= (12/(1+2))) write(14);
 33 acc8= constant 4
 34 <acc8= constant 12
 35 <acc8= constant 1
 36 acc8+ constant 2
 37 /acc8 unstack
 38 comacc8 unstack
 39 brlt 43
 40 acc8= constant 14
 41 call writeAcc8
 42 ;test5.p(28)   if (5 >= 4) write(13);
 43 acc8= constant 5
 44 accom8 constant 4
 45 brlt 49
 46 acc8= constant 13
 47 call writeAcc8
 48 ;test5.p(29)   if (5 >= (12/(1+2))) write(12);
 49 acc8= constant 5
 50 <acc8= constant 12
 51 <acc8= constant 1
 52 acc8+ constant 2
 53 /acc8 unstack
 54 comacc8 unstack
 55 brlt 59
 56 acc8= constant 12
 57 call writeAcc8
 58 ;test5.p(30)   if (4 <= 4) write(11);
 59 acc8= constant 4
 60 accom8 constant 4
 61 brgt 65
 62 acc8= constant 11
 63 call writeAcc8
 64 ;test5.p(31)   if (4 <= (12/(1+2))) write(10);
 65 acc8= constant 4
 66 <acc8= constant 12
 67 <acc8= constant 1
 68 acc8+ constant 2
 69 /acc8 unstack
 70 comacc8 unstack
 71 brgt 75
 72 acc8= constant 10
 73 call writeAcc8
 74 ;test5.p(32)   if (3 <= 4) write(9);
 75 acc8= constant 3
 76 accom8 constant 4
 77 brgt 81
 78 acc8= constant 9
 79 call writeAcc8
 80 ;test5.p(33)   if (3 <= (12/(1+2))) write(8);
 81 acc8= constant 3
 82 <acc8= constant 12
 83 <acc8= constant 1
 84 acc8+ constant 2
 85 /acc8 unstack
 86 comacc8 unstack
 87 brgt 91
 88 acc8= constant 8
 89 call writeAcc8
 90 ;test5.p(34)   if (5 > 4) write(7);
 91 acc8= constant 5
 92 accom8 constant 4
 93 brle 97
 94 acc8= constant 7
 95 call writeAcc8
 96 ;test5.p(35)   if (5 > (12/(1+2))) write(6);
 97 acc8= constant 5
 98 <acc8= constant 12
 99 <acc8= constant 1
100 acc8+ constant 2
101 /acc8 unstack
102 comacc8 unstack
103 brle 107
104 acc8= constant 6
105 call writeAcc8
106 ;test5.p(36)   if (3 < 4) write(5);
107 acc8= constant 3
108 accom8 constant 4
109 brge 113
110 acc8= constant 5
111 call writeAcc8
112 ;test5.p(37)   if (3 < (12/(1+2))) write(4);
113 acc8= constant 3
114 <acc8= constant 12
115 <acc8= constant 1
116 acc8+ constant 2
117 /acc8 unstack
118 comacc8 unstack
119 brge 123
120 acc8= constant 4
121 call writeAcc8
122 ;test5.p(38)   if (3 != 4) write(3);
123 acc8= constant 3
124 accom8 constant 4
125 breq 129
126 acc8= constant 3
127 call writeAcc8
128 ;test5.p(39)   if (3 != (12/(1+2))) write(2);
129 acc8= constant 3
130 <acc8= constant 12
131 <acc8= constant 1
132 acc8+ constant 2
133 /acc8 unstack
134 comacc8 unstack
135 breq 139
136 acc8= constant 2
137 call writeAcc8
138 ;test5.p(40)   if (4 == 4) write(1);
139 acc8= constant 4
140 accom8 constant 4
141 brne 145
142 acc8= constant 1
143 call writeAcc8
144 ;test5.p(41)   if (4 == (12/(1+2))) write(0);
145 acc8= constant 4
146 <acc8= constant 12
147 <acc8= constant 1
148 acc8+ constant 2
149 /acc8 unstack
150 comacc8 unstack
151 brne 155
152 acc8= constant 0
153 call writeAcc8
154 ;test5.p(42) }
155 stop
