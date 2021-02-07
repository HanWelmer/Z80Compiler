  0 ;test5.p(0) /*
  1 ;test5.p(1)  * A small program in the miniJava language.
  2 ;test5.p(2)  * Test comparisons
  3 ;test5.p(3)  */
  4 ;test5.p(4) class TestComparison {
  5 ;test5.p(5)   if (12/(1+2) > 3) write(25);   //25
  6 acc8= constant 12
  7 <acc8= constant 1
  8 acc8+ constant 2
  9 /acc8 unstack
 10 accom8 constant 3
 11 brle 15
 12 acc8= constant 25
 13 call writeAcc8
 14 ;test5.p(6)   if (12/(1+2) >= 4) write(24);  //24
 15 acc8= constant 12
 16 <acc8= constant 1
 17 acc8+ constant 2
 18 /acc8 unstack
 19 accom8 constant 4
 20 brlt 24
 21 acc8= constant 24
 22 call writeAcc8
 23 ;test5.p(7)   if (12/(1+2) != 1) write(23);  //23
 24 acc8= constant 12
 25 <acc8= constant 1
 26 acc8+ constant 2
 27 /acc8 unstack
 28 accom8 constant 1
 29 breq 33
 30 acc8= constant 23
 31 call writeAcc8
 32 ;test5.p(8)   if (12/(1+2) == 4) write(22);  //22
 33 acc8= constant 12
 34 <acc8= constant 1
 35 acc8+ constant 2
 36 /acc8 unstack
 37 accom8 constant 4
 38 brne 42
 39 acc8= constant 22
 40 call writeAcc8
 41 ;test5.p(9)   if (12/(1+2) <= 4) write(21);  //21
 42 acc8= constant 12
 43 <acc8= constant 1
 44 acc8+ constant 2
 45 /acc8 unstack
 46 accom8 constant 4
 47 brgt 51
 48 acc8= constant 21
 49 call writeAcc8
 50 ;test5.p(10)   if (12/(1+2) < 5) write(20);   //20
 51 acc8= constant 12
 52 <acc8= constant 1
 53 acc8+ constant 2
 54 /acc8 unstack
 55 accom8 constant 5
 56 brge 61
 57 acc8= constant 20
 58 call writeAcc8
 59 ;test5.p(11) 
 60 ;test5.p(12)   if (5 > 12/(1+2)) write(19);   //19
 61 acc8= constant 5
 62 <acc8= constant 12
 63 <acc8= constant 1
 64 acc8+ constant 2
 65 /acc8 unstack
 66 accom8 unstack
 67 brge 71
 68 acc8= constant 19
 69 call writeAcc8
 70 ;test5.p(13)   if (4 >= 12/(1+2)) write(18);  //18
 71 acc8= constant 4
 72 <acc8= constant 12
 73 <acc8= constant 1
 74 acc8+ constant 2
 75 /acc8 unstack
 76 accom8 unstack
 77 brgt 81
 78 acc8= constant 18
 79 call writeAcc8
 80 ;test5.p(14)   if (1 != 12/(1+2)) write(17);  //17
 81 acc8= constant 1
 82 <acc8= constant 12
 83 <acc8= constant 1
 84 acc8+ constant 2
 85 /acc8 unstack
 86 accom8 unstack
 87 breq 91
 88 acc8= constant 17
 89 call writeAcc8
 90 ;test5.p(15)   if (4 == 12/(1+2)) write(16);  //16
 91 acc8= constant 4
 92 <acc8= constant 12
 93 <acc8= constant 1
 94 acc8+ constant 2
 95 /acc8 unstack
 96 accom8 unstack
 97 brne 101
 98 acc8= constant 16
 99 call writeAcc8
100 ;test5.p(16)   if (4 <= 12/(1+2)) write(15);  //15
101 acc8= constant 4
102 <acc8= constant 12
103 <acc8= constant 1
104 acc8+ constant 2
105 /acc8 unstack
106 accom8 unstack
107 brlt 111
108 acc8= constant 15
109 call writeAcc8
110 ;test5.p(17)   if (1 < 12/(1+2)) write(14);   //14
111 acc8= constant 1
112 <acc8= constant 12
113 <acc8= constant 1
114 acc8+ constant 2
115 /acc8 unstack
116 accom8 unstack
117 brle 122
118 acc8= constant 14
119 call writeAcc8
120 ;test5.p(18) 
121 ;test5.p(19)   if (1 <= 1) write(13);  //13
122 acc8= constant 1
123 accom8 constant 1
124 brgt 128
125 acc8= constant 13
126 call writeAcc8
127 ;test5.p(20)   if (0 <= 1) write(12);  //12
128 acc8= constant 0
129 accom8 constant 1
130 brgt 134
131 acc8= constant 12
132 call writeAcc8
133 ;test5.p(21)   if (0 < 1) write(11);   //11
134 acc8= constant 0
135 accom8 constant 1
136 brge 140
137 acc8= constant 11
138 call writeAcc8
139 ;test5.p(22)   if (1 >= 1) write(10);  //10
140 acc8= constant 1
141 accom8 constant 1
142 brlt 146
143 acc8= constant 10
144 call writeAcc8
145 ;test5.p(23)   if (1 >= 0) write(9);   //9
146 acc8= constant 1
147 accom8 constant 0
148 brlt 152
149 acc8= constant 9
150 call writeAcc8
151 ;test5.p(24)   if (1 > 0) write(8);    //8
152 acc8= constant 1
153 accom8 constant 0
154 brle 159
155 acc8= constant 8
156 call writeAcc8
157 ;test5.p(25) 
158 ;test5.p(26)   if (1 != 1) { 
159 acc8= constant 1
160 accom8 constant 1
161 breq 168
162 ;test5.p(27)     write(0);
163 acc8= constant 0
164 call writeAcc8
165 ;test5.p(28)   } else { 
166 br 172
167 ;test5.p(29)     write (7);            //7
168 acc8= constant 7
169 call writeAcc8
170 ;test5.p(30)   }
171 ;test5.p(31)   if (1 != 0) { 
172 acc8= constant 1
173 accom8 constant 0
174 breq 181
175 ;test5.p(32)     write(6);             //6
176 acc8= constant 6
177 call writeAcc8
178 ;test5.p(33)   } else { 
179 br 185
180 ;test5.p(34)     write (0);
181 acc8= constant 0
182 call writeAcc8
183 ;test5.p(35)   }
184 ;test5.p(36)   if (1 != 0) write(5);   //5
185 acc8= constant 1
186 accom8 constant 0
187 breq 192
188 acc8= constant 5
189 call writeAcc8
190 ;test5.p(37) 
191 ;test5.p(38)   if (1 == 0) { 
192 acc8= constant 1
193 accom8 constant 0
194 brne 201
195 ;test5.p(39)     write(0);
196 acc8= constant 0
197 call writeAcc8
198 ;test5.p(40)   } else { 
199 br 205
200 ;test5.p(41)     write (4);            //4
201 acc8= constant 4
202 call writeAcc8
203 ;test5.p(42)   }
204 ;test5.p(43)   if (1 == 1) { 
205 acc8= constant 1
206 accom8 constant 1
207 brne 214
208 ;test5.p(44)     write(3);             //3
209 acc8= constant 3
210 call writeAcc8
211 ;test5.p(45)   } else { 
212 br 218
213 ;test5.p(46)     write (0);
214 acc8= constant 0
215 call writeAcc8
216 ;test5.p(47)   }
217 ;test5.p(48)   if (1000 == 1000) write(2);  //2
218 acc16= constant 1000
219 accom16 constant 1000
220 brne 224
221 acc8= constant 2
222 call writeAcc8
223 ;test5.p(49)   if (1 == 1) write(1);   //1
224 acc8= constant 1
225 accom8 constant 1
226 brne 230
227 acc8= constant 1
228 call writeAcc8
229 ;test5.p(50)   write(0);               //0
230 acc8= constant 0
231 call writeAcc8
232 ;test5.p(51) }
233 stop
