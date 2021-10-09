  0 ;test8.p(0) /*
  1 ;test8.p(1)  * A small program in the miniJava language.
  2 ;test8.p(2)  * Test 8-bit and 16-bit expressions.
  3 ;test8.p(3)  */
  4 ;test8.p(4) class Test8And16BitExpressions {
  5 ;test8.p(5)   /*************************/
  6 ;test8.p(6)   /* reverse subtract byte */
  7 ;test8.p(7)   /*************************/
  8 ;test8.p(8)   write(10 - 3*3);         // 1
  9 acc8= constant 10
 10 <acc8= constant 3
 11 acc8* constant 3
 12 -acc8 unstack8
 13 call writeAcc8
 14 ;test8.p(9)   byte b = 11;
 15 acc8= constant 11
 16 acc8=> variable 0
 17 ;test8.p(10)   write(b - 3*3);          // 2
 18 acc8= variable 0
 19 <acc8= constant 3
 20 acc8* constant 3
 21 -acc8 unstack8
 22 call writeAcc8
 23 ;test8.p(11)   byte c = 3;
 24 acc8= constant 3
 25 acc8=> variable 1
 26 ;test8.p(12)   byte d = 3;
 27 acc8= constant 3
 28 acc8=> variable 2
 29 ;test8.p(13)   write(12 - c*d);         // 3
 30 acc8= constant 12
 31 <acc8= variable 1
 32 acc8* variable 2
 33 -acc8 unstack8
 34 call writeAcc8
 35 ;test8.p(14)   b = 13;
 36 acc8= constant 13
 37 acc8=> variable 0
 38 ;test8.p(15)   write(b - c*d);          // 4
 39 acc8= variable 0
 40 <acc8= variable 1
 41 acc8* variable 2
 42 -acc8 unstack8
 43 call writeAcc8
 44 ;test8.p(16) 
 45 ;test8.p(17)   /*************************/
 46 ;test8.p(18)   /* reverse subtract int  */
 47 ;test8.p(19)   /*************************/
 48 ;test8.p(20)   write(1005 - 1000*1);    // 5
 49 acc16= constant 1005
 50 <acc16= constant 1000
 51 acc16* constant 1
 52 -acc16 unstack16
 53 call writeAcc16
 54 ;test8.p(21)   int i = 1006;
 55 acc16= constant 1006
 56 acc16=> variable 3
 57 ;test8.p(22)   write(i - 1000*1);       // 6
 58 acc16= variable 3
 59 <acc16= constant 1000
 60 acc16* constant 1
 61 -acc16 unstack16
 62 call writeAcc16
 63 ;test8.p(23)   int j = 1000;
 64 acc16= constant 1000
 65 acc16=> variable 5
 66 ;test8.p(24)   int k = 1;
 67 acc8= constant 1
 68 acc8ToAcc16
 69 acc16=> variable 7
 70 ;test8.p(25)   write(1007 - j*k);       // 7
 71 acc16= constant 1007
 72 <acc16= variable 5
 73 acc16* variable 7
 74 -acc16 unstack16
 75 call writeAcc16
 76 ;test8.p(26)   i = 1008;
 77 acc16= constant 1008
 78 acc16=> variable 3
 79 ;test8.p(27)   write(i - j*k);          // 8
 80 acc16= variable 3
 81 <acc16= variable 5
 82 acc16* variable 7
 83 -acc16 unstack16
 84 call writeAcc16
 85 ;test8.p(28) 
 86 ;test8.p(29)   /***********************/
 87 ;test8.p(30)   /* reverse divide byte */
 88 ;test8.p(31)   /***********************/
 89 ;test8.p(32)   write(36 / (4*1));     // 9
 90 acc8= constant 36
 91 <acc8= constant 4
 92 acc8* constant 1
 93 /acc8 unstack8
 94 call writeAcc8
 95 ;test8.p(33)   b = 40;
 96 acc8= constant 40
 97 acc8=> variable 0
 98 ;test8.p(34)   write(b / (4*1));      // 10
 99 acc8= variable 0
100 <acc8= constant 4
101 acc8* constant 1
102 /acc8 unstack8
103 call writeAcc8
104 ;test8.p(35)   c = 4;
105 acc8= constant 4
106 acc8=> variable 1
107 ;test8.p(36)   d = 1;
108 acc8= constant 1
109 acc8=> variable 2
110 ;test8.p(37)   write(44 / (c*d));     // 11
111 acc8= constant 44
112 <acc8= variable 1
113 acc8* variable 2
114 /acc8 unstack8
115 call writeAcc8
116 ;test8.p(38)   b = 48;
117 acc8= constant 48
118 acc8=> variable 0
119 ;test8.p(39)   write(b / (c*d));      // 12
120 acc8= variable 0
121 <acc8= variable 1
122 acc8* variable 2
123 /acc8 unstack8
124 call writeAcc8
125 ;test8.p(40) 
126 ;test8.p(41)   /***********************/
127 ;test8.p(42)   /* reverse divide int  */
128 ;test8.p(43)   /***********************/
129 ;test8.p(44)   write(3900 / (300*1)); // 13
130 acc16= constant 3900
131 <acc16= constant 300
132 acc16* constant 1
133 /acc16 unstack16
134 call writeAcc16
135 ;test8.p(45)   i = 4200;
136 acc16= constant 4200
137 acc16=> variable 3
138 ;test8.p(46)   write(i / (300*1));    // 14
139 acc16= variable 3
140 <acc16= constant 300
141 acc16* constant 1
142 /acc16 unstack16
143 call writeAcc16
144 ;test8.p(47)   j = 300;
145 acc16= constant 300
146 acc16=> variable 5
147 ;test8.p(48)   k = 1;
148 acc8= constant 1
149 acc8ToAcc16
150 acc16=> variable 7
151 ;test8.p(49)   write(4500 / (j*k));   // 15
152 acc16= constant 4500
153 <acc16= variable 5
154 acc16* variable 7
155 /acc16 unstack16
156 call writeAcc16
157 ;test8.p(50)   i = 4800;
158 acc16= constant 4800
159 acc16=> variable 3
160 ;test8.p(51)   write(i / (j*k));      // 16
161 acc16= variable 3
162 <acc16= variable 5
163 acc16* variable 7
164 /acc16 unstack16
165 call writeAcc16
166 ;test8.p(52) 
167 ;test8.p(53)   /**************************/
168 ;test8.p(54)   /* reverse subtract mixed */
169 ;test8.p(55)   /**************************/
170 ;test8.p(56)   i = 21;
171 acc8= constant 21
172 acc8ToAcc16
173 acc16=> variable 3
174 ;test8.p(57)   c = 4;
175 acc8= constant 4
176 acc8=> variable 1
177 ;test8.p(58)   d = 1;
178 acc8= constant 1
179 acc8=> variable 2
180 ;test8.p(59)   write(i - c*d);           // 17
181 acc16= variable 3
182 acc8= variable 1
183 acc8* variable 2
184 acc16- acc8
185 call writeAcc16
186 ;test8.p(60)   b = 22;
187 acc8= constant 22
188 acc8=> variable 0
189 ;test8.p(61)   j = 4;
190 acc8= constant 4
191 acc8ToAcc16
192 acc16=> variable 5
193 ;test8.p(62)   k = 1;
194 acc8= constant 1
195 acc8ToAcc16
196 acc16=> variable 7
197 ;test8.p(63)   write(b - j*k);           // 18
198 acc8= variable 0
199 acc16= variable 5
200 acc16* variable 7
201 -acc16 acc8
202 call writeAcc16
203 ;test8.p(64) 
204 ;test8.p(65)   /**************************/
205 ;test8.p(66)   /* reverse divide mixed   */
206 ;test8.p(67)   /**************************/
207 ;test8.p(68) 
208 ;test8.p(69)   /**************************/
209 ;test8.p(70)   /* forward divide mixed   */
210 ;test8.p(71)   /**************************/
211 ;test8.p(72)   i = 19;
212 acc8= constant 19
213 acc8ToAcc16
214 acc16=> variable 3
215 ;test8.p(73)   write(i / (1+0));         // 19
216 acc16= variable 3
217 acc8= constant 1
218 acc8+ constant 0
219 acc16/ acc8
220 call writeAcc16
221 ;test8.p(74)   
222 ;test8.p(75)   write(i + 1);             // 20
223 acc16= variable 3
224 acc16+ constant 1
225 call writeAcc16
226 ;test8.p(76)   write(2 + i);             // 21
227 acc8= constant 2
228 acc8ToAcc16
229 acc16+ variable 3
230 call writeAcc16
231 ;test8.p(77) }
232 stop
