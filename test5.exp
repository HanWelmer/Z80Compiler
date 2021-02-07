  0 ;test5.p(0) /*
  1 ;test5.p(1)  * A small program in the miniJava language.
  2 ;test5.p(2)  * Test comparisons
  3 ;test5.p(3)  */
  4 ;test5.p(4) class TestComparison {
  5 ;test5.p(5)   if (5 > 12/(1+2)) write(19);   //19
  6 acc8= constant 5
  7 <acc8= constant 12
  8 <acc8= constant 1
  9 acc8+ constant 2
 10 /acc8 unstack
 11 accom8 unstack
 12 brge 16
 13 acc8= constant 19
 14 call writeAcc8
 15 ;test5.p(6)   if (4 >= 12/(1+2)) write(18);  //18
 16 acc8= constant 4
 17 <acc8= constant 12
 18 <acc8= constant 1
 19 acc8+ constant 2
 20 /acc8 unstack
 21 accom8 unstack
 22 brgt 26
 23 acc8= constant 18
 24 call writeAcc8
 25 ;test5.p(7)   if (1 != 12/(1+2)) write(17);  //17
 26 acc8= constant 1
 27 <acc8= constant 12
 28 <acc8= constant 1
 29 acc8+ constant 2
 30 /acc8 unstack
 31 accom8 unstack
 32 breq 36
 33 acc8= constant 17
 34 call writeAcc8
 35 ;test5.p(8)   if (4 == 12/(1+2)) write(16);   //16
 36 acc8= constant 4
 37 <acc8= constant 12
 38 <acc8= constant 1
 39 acc8+ constant 2
 40 /acc8 unstack
 41 accom8 unstack
 42 brne 46
 43 acc8= constant 16
 44 call writeAcc8
 45 ;test5.p(9)   if (4 <= 12/(1+2)) write(15);  //15
 46 acc8= constant 4
 47 <acc8= constant 12
 48 <acc8= constant 1
 49 acc8+ constant 2
 50 /acc8 unstack
 51 accom8 unstack
 52 brlt 56
 53 acc8= constant 15
 54 call writeAcc8
 55 ;test5.p(10)   if (1 < 12/(1+2)) write(14);   //14
 56 acc8= constant 1
 57 <acc8= constant 12
 58 <acc8= constant 1
 59 acc8+ constant 2
 60 /acc8 unstack
 61 accom8 unstack
 62 brle 66
 63 acc8= constant 14
 64 call writeAcc8
 65 ;test5.p(11)   if (1 <= 1) write(13);  //13
 66 acc8= constant 1
 67 accom8 constant 1
 68 brgt 72
 69 acc8= constant 13
 70 call writeAcc8
 71 ;test5.p(12)   if (0 <= 1) write(12);  //12
 72 acc8= constant 0
 73 accom8 constant 1
 74 brgt 78
 75 acc8= constant 12
 76 call writeAcc8
 77 ;test5.p(13)   if (0 < 1) write(11);   //11
 78 acc8= constant 0
 79 accom8 constant 1
 80 brge 84
 81 acc8= constant 11
 82 call writeAcc8
 83 ;test5.p(14)   if (1 >= 1) write(10);  //10
 84 acc8= constant 1
 85 accom8 constant 1
 86 brlt 90
 87 acc8= constant 10
 88 call writeAcc8
 89 ;test5.p(15)   if (1 >= 0) write(9);   //9
 90 acc8= constant 1
 91 accom8 constant 0
 92 brlt 96
 93 acc8= constant 9
 94 call writeAcc8
 95 ;test5.p(16)   if (1 > 0) write(8);    //8
 96 acc8= constant 1
 97 accom8 constant 0
 98 brle 102
 99 acc8= constant 8
100 call writeAcc8
101 ;test5.p(17)   if (1 != 1) { 
102 acc8= constant 1
103 accom8 constant 1
104 breq 111
105 ;test5.p(18)     write(0);
106 acc8= constant 0
107 call writeAcc8
108 ;test5.p(19)   } else { 
109 br 115
110 ;test5.p(20)     write (7);            //7
111 acc8= constant 7
112 call writeAcc8
113 ;test5.p(21)   }
114 ;test5.p(22)   if (1 != 0) { 
115 acc8= constant 1
116 accom8 constant 0
117 breq 124
118 ;test5.p(23)     write(6);             //6
119 acc8= constant 6
120 call writeAcc8
121 ;test5.p(24)   } else { 
122 br 128
123 ;test5.p(25)     write (0);
124 acc8= constant 0
125 call writeAcc8
126 ;test5.p(26)   }
127 ;test5.p(27)   if (1 != 0) write(5);   //5
128 acc8= constant 1
129 accom8 constant 0
130 breq 134
131 acc8= constant 5
132 call writeAcc8
133 ;test5.p(28)   if (1 == 0) { 
134 acc8= constant 1
135 accom8 constant 0
136 brne 143
137 ;test5.p(29)     write(0);
138 acc8= constant 0
139 call writeAcc8
140 ;test5.p(30)   } else { 
141 br 147
142 ;test5.p(31)     write (4);            //4
143 acc8= constant 4
144 call writeAcc8
145 ;test5.p(32)   }
146 ;test5.p(33)   if (1 == 1) { 
147 acc8= constant 1
148 accom8 constant 1
149 brne 156
150 ;test5.p(34)     write(3);             //3
151 acc8= constant 3
152 call writeAcc8
153 ;test5.p(35)   } else { 
154 br 160
155 ;test5.p(36)     write (0);
156 acc8= constant 0
157 call writeAcc8
158 ;test5.p(37)   }
159 ;test5.p(38)   if (1000 == 1000) write(2);  //2
160 acc16= constant 1000
161 accom16 constant 1000
162 brne 166
163 acc8= constant 2
164 call writeAcc8
165 ;test5.p(39)   if (1 == 1) write(1);   //1
166 acc8= constant 1
167 accom8 constant 1
168 brne 172
169 acc8= constant 1
170 call writeAcc8
171 ;test5.p(40)   write(0);               //0
172 acc8= constant 0
173 call writeAcc8
174 ;test5.p(41) }
175 stop
