  0 ;test5.p(0) /*
  1 ;test5.p(1)  * A small program in the miniJava language.
  2 ;test5.p(2)  * Test comparisons
  3 ;test5.p(3)  */
  4 ;test5.p(4) class TestIf {
  5 ;test5.p(5)   //integer-integer
  6 ;test5.p(6)   if (400 >= 400) write(31);
  7 acc16= constant 400
  8 accom16 constant 400
  9 brlt 13
 10 acc8= constant 31
 11 call writeAcc8
 12 ;test5.p(7)   if (400 >= (1200/(1+2))) write(30);
 13 acc16= constant 400
 14 <acc16= constant 1200
 15 acc8= constant 1
 16 acc8+ constant 2
 17 acc16/ acc8
 18 comacc16 unstack
 19 brlt 23
 20 acc8= constant 30
 21 call writeAcc8
 22 ;test5.p(8)   if (500 >= 400) write(29);
 23 acc16= constant 500
 24 accom16 constant 400
 25 brlt 29
 26 acc8= constant 29
 27 call writeAcc8
 28 ;test5.p(9)   if (500 >= (1200/(1+2))) write(28);
 29 acc16= constant 500
 30 <acc16= constant 1200
 31 acc8= constant 1
 32 acc8+ constant 2
 33 acc16/ acc8
 34 comacc16 unstack
 35 brlt 39
 36 acc8= constant 28
 37 call writeAcc8
 38 ;test5.p(10)   if (400 <= 400) write(27);
 39 acc16= constant 400
 40 accom16 constant 400
 41 brgt 45
 42 acc8= constant 27
 43 call writeAcc8
 44 ;test5.p(11)   if (400 <= (1200/(1+2))) write(26);
 45 acc16= constant 400
 46 <acc16= constant 1200
 47 acc8= constant 1
 48 acc8+ constant 2
 49 acc16/ acc8
 50 comacc16 unstack
 51 brgt 55
 52 acc8= constant 26
 53 call writeAcc8
 54 ;test5.p(12)   if (300 <= 400) write(25);
 55 acc16= constant 300
 56 accom16 constant 400
 57 brgt 61
 58 acc8= constant 25
 59 call writeAcc8
 60 ;test5.p(13)   if (300 <= (1200/(1+2))) write(24);
 61 acc16= constant 300
 62 <acc16= constant 1200
 63 acc8= constant 1
 64 acc8+ constant 2
 65 acc16/ acc8
 66 comacc16 unstack
 67 brgt 71
 68 acc8= constant 24
 69 call writeAcc8
 70 ;test5.p(14)   if (500 > 400) write(23);
 71 acc16= constant 500
 72 accom16 constant 400
 73 brle 77
 74 acc8= constant 23
 75 call writeAcc8
 76 ;test5.p(15)   if (500 > (1200/(1+2))) write(22);
 77 acc16= constant 500
 78 <acc16= constant 1200
 79 acc8= constant 1
 80 acc8+ constant 2
 81 acc16/ acc8
 82 comacc16 unstack
 83 brle 87
 84 acc8= constant 22
 85 call writeAcc8
 86 ;test5.p(16)   if (300 < 400) write(21);
 87 acc16= constant 300
 88 accom16 constant 400
 89 brge 93
 90 acc8= constant 21
 91 call writeAcc8
 92 ;test5.p(17)   if (300 < (1200/(1+2))) write(20);
 93 acc16= constant 300
 94 <acc16= constant 1200
 95 acc8= constant 1
 96 acc8+ constant 2
 97 acc16/ acc8
 98 comacc16 unstack
 99 brge 103
100 acc8= constant 20
101 call writeAcc8
102 ;test5.p(18)   if (300 != 400) write(19);
103 acc16= constant 300
104 accom16 constant 400
105 breq 109
106 acc8= constant 19
107 call writeAcc8
108 ;test5.p(19)   if (300 != (1200/(1+2))) write(18);
109 acc16= constant 300
110 <acc16= constant 1200
111 acc8= constant 1
112 acc8+ constant 2
113 acc16/ acc8
114 comacc16 unstack
115 breq 119
116 acc8= constant 18
117 call writeAcc8
118 ;test5.p(20)   if (400 == 400) write(17);
119 acc16= constant 400
120 accom16 constant 400
121 brne 125
122 acc8= constant 17
123 call writeAcc8
124 ;test5.p(21)   if (400 == (1200/(1+2))) write(16);
125 acc16= constant 400
126 <acc16= constant 1200
127 acc8= constant 1
128 acc8+ constant 2
129 acc16/ acc8
130 comacc16 unstack
131 brne 136
132 acc8= constant 16
133 call writeAcc8
134 ;test5.p(22)   //byte-byte
135 ;test5.p(23)   if (4 >= 4) write(15);
136 acc8= constant 4
137 accom8 constant 4
138 brlt 142
139 acc8= constant 15
140 call writeAcc8
141 ;test5.p(24)   if (4 >= (12/(1+2))) write(14);
142 acc8= constant 4
143 <acc8= constant 12
144 <acc8= constant 1
145 acc8+ constant 2
146 /acc8 unstack
147 comacc8 unstack
148 brlt 152
149 acc8= constant 14
150 call writeAcc8
151 ;test5.p(25)   if (5 >= 4) write(13);
152 acc8= constant 5
153 accom8 constant 4
154 brlt 158
155 acc8= constant 13
156 call writeAcc8
157 ;test5.p(26)   if (5 >= (12/(1+2))) write(12);
158 acc8= constant 5
159 <acc8= constant 12
160 <acc8= constant 1
161 acc8+ constant 2
162 /acc8 unstack
163 comacc8 unstack
164 brlt 168
165 acc8= constant 12
166 call writeAcc8
167 ;test5.p(27)   if (4 <= 4) write(11);
168 acc8= constant 4
169 accom8 constant 4
170 brgt 174
171 acc8= constant 11
172 call writeAcc8
173 ;test5.p(28)   if (4 <= (12/(1+2))) write(10);
174 acc8= constant 4
175 <acc8= constant 12
176 <acc8= constant 1
177 acc8+ constant 2
178 /acc8 unstack
179 comacc8 unstack
180 brgt 184
181 acc8= constant 10
182 call writeAcc8
183 ;test5.p(29)   if (3 <= 4) write(9);
184 acc8= constant 3
185 accom8 constant 4
186 brgt 190
187 acc8= constant 9
188 call writeAcc8
189 ;test5.p(30)   if (3 <= (12/(1+2))) write(8);
190 acc8= constant 3
191 <acc8= constant 12
192 <acc8= constant 1
193 acc8+ constant 2
194 /acc8 unstack
195 comacc8 unstack
196 brgt 200
197 acc8= constant 8
198 call writeAcc8
199 ;test5.p(31)   if (5 > 4) write(7);
200 acc8= constant 5
201 accom8 constant 4
202 brle 206
203 acc8= constant 7
204 call writeAcc8
205 ;test5.p(32)   if (5 > (12/(1+2))) write(6);
206 acc8= constant 5
207 <acc8= constant 12
208 <acc8= constant 1
209 acc8+ constant 2
210 /acc8 unstack
211 comacc8 unstack
212 brle 216
213 acc8= constant 6
214 call writeAcc8
215 ;test5.p(33)   if (3 < 4) write(5);
216 acc8= constant 3
217 accom8 constant 4
218 brge 222
219 acc8= constant 5
220 call writeAcc8
221 ;test5.p(34)   if (3 < (12/(1+2))) write(4);
222 acc8= constant 3
223 <acc8= constant 12
224 <acc8= constant 1
225 acc8+ constant 2
226 /acc8 unstack
227 comacc8 unstack
228 brge 232
229 acc8= constant 4
230 call writeAcc8
231 ;test5.p(35)   if (3 != 4) write(3);
232 acc8= constant 3
233 accom8 constant 4
234 breq 238
235 acc8= constant 3
236 call writeAcc8
237 ;test5.p(36)   if (3 != (12/(1+2))) write(2);
238 acc8= constant 3
239 <acc8= constant 12
240 <acc8= constant 1
241 acc8+ constant 2
242 /acc8 unstack
243 comacc8 unstack
244 breq 248
245 acc8= constant 2
246 call writeAcc8
247 ;test5.p(37)   if (4 == 4) write(1);
248 acc8= constant 4
249 accom8 constant 4
250 brne 254
251 acc8= constant 1
252 call writeAcc8
253 ;test5.p(38)   if (4 == (12/(1+2))) write(0);
254 acc8= constant 4
255 <acc8= constant 12
256 <acc8= constant 1
257 acc8+ constant 2
258 /acc8 unstack
259 comacc8 unstack
260 brne 264
261 acc8= constant 0
262 call writeAcc8
263 ;test5.p(39) }
264 stop
