  0 :///*
  1 :// * A small program in the miniJava language.
  2 :// * Test 8-bit and 16-bit expressions.
  3 :// */
  4 ://class Test8And16BitExpressions {
  5 ://  write(0);         // 0
  6 ://  //LD    A,0
  7 ://  //CALL  writeA
  8 ://  //OK
  9 ://
 10 ://  byte b = 1;
 11 :acc8= constant 0
 12 :call writeAcc8
 13 :acc8= constant 1
 14 :acc8=> variable 0
 15 ://  byte c = 4;
 16 :acc8= constant 4
 17 :acc8=> variable 1
 18 ://  write(b);         // 1
 19 ://  //LD    A,1
 20 ://  //LD    (04000H),A
 21 ://  //LD    A,(04000H)
 22 ://  //CALL  writeA
 23 ://  //OK
 24 ://
 25 ://  write(0 + 2);     // 2
 26 :acc8= variable 0
 27 :call writeAcc8
 28 :acc8= constant 0
 29 :acc8+ constant 2
 30 ://  write(b + 2);     // 3
 31 :call writeAcc8
 32 :acc8= variable 0
 33 :acc8+ constant 2
 34 ://  write(3 + b);     // 4
 35 :call writeAcc8
 36 :acc8= constant 3
 37 :acc8+ variable 0
 38 ://  write(b + c);     // 5
 39 :call writeAcc8
 40 :acc8= variable 0
 41 :acc8+ variable 1
 42 ://
 43 ://  c = 4 + 2;
 44 :call writeAcc8
 45 :acc8= constant 4
 46 :acc8+ constant 2
 47 :acc8=> variable 1
 48 ://  write(c);         // 6
 49 ://  c = b + 6;
 50 :acc8= variable 1
 51 :call writeAcc8
 52 :acc8= variable 0
 53 :acc8+ constant 6
 54 :acc8=> variable 1
 55 ://  write(c);         // 7
 56 ://  c = 7 + b;
 57 :acc8= variable 1
 58 :call writeAcc8
 59 :acc8= constant 7
 60 :acc8+ variable 0
 61 :acc8=> variable 1
 62 ://  write(c);         // 8
 63 ://  c = b + c;
 64 :acc8= variable 1
 65 :call writeAcc8
 66 :acc8= variable 0
 67 :acc8+ variable 1
 68 :acc8=> variable 1
 69 ://  write(c);         // 9
 70 ://
 71 ://
 72 ://  int i = 10;
 73 :acc8= variable 1
 74 :call writeAcc8
 75 :acc8= constant 10
 76 :acc8ToAcc16
 77 :acc16=> variable 2
 78 ://  write(i);         // 10
 79 ://  //LD    A,10
 80 ://  //LD    L,A
 81 ://  //LD    H,0
 82 ://  //LD    (04004H),HL
 83 ://  //OK
 84 ://  
 85 ://  write(i + 1);     // 11
 86 :acc16= variable 2
 87 :call writeAcc16
 88 :acc16= variable 2
 89 :acc8= constant 1
 90 :acc16+ acc8
 91 ://  write(2 + i);     // 12
 92 :call writeAcc16
 93 :acc8= constant 2
 94 :acc8ToAcc16
 95 :acc16+ variable 2
 96 ://  b = 3;
 97 :call writeAcc16
 98 :acc8= constant 3
 99 :acc8=> variable 0
100 ://  write(i + b);     // 13
101 :acc16= variable 2
102 :acc8= variable 0
103 :acc16+ acc8
104 ://  b++; //4
105 :call writeAcc16
106 :incr8 variable 0
107 ://  write(b + i);     // 14
108 :acc8= variable 0
109 :acc8ToAcc16
110 :acc16+ variable 2
111 ://
112 ://  int j = i + 5;    // 15
113 :call writeAcc16
114 :acc16= variable 2
115 :acc8= constant 5
116 :acc16+ acc8
117 :acc16=> variable 4
118 ://  write(j);
119 ://  j = 6 + i;        // 16
120 :acc16= variable 4
121 :call writeAcc16
122 :acc8= constant 6
123 :acc8ToAcc16
124 :acc16+ variable 2
125 :acc16=> variable 4
126 ://  write(j);
127 ://  j = 7;
128 :acc16= variable 4
129 :call writeAcc16
130 :acc8= constant 7
131 :acc8ToAcc16
132 :acc16=> variable 4
133 ://  j = i + j;        // 17
134 :acc16= variable 2
135 :acc16+ variable 4
136 :acc16=> variable 4
137 ://  write(j);
138 ://
139 ://  b = 255;
140 :acc16= variable 4
141 :call writeAcc16
142 :acc8= constant 255
143 :acc8=> variable 0
144 ://  write(b);         // 255
145 ://  //LD    A,255
146 ://  //LD    (04001H),A
147 ://  //LD    A,(04001H)
148 ://  //CALL  writeA
149 ://  //OK
150 ://
151 ://  i = 256;
152 :acc8= variable 0
153 :call writeAcc8
154 :acc16= constant 256
155 :acc16=> variable 2
156 ://  write(i);         // 256
157 ://  //LD    HL,256
158 ://  //LD    (04006H),HL
159 ://  //LD    HL,(04006H)
160 ://  //CALL  writeHL
161 ://  //OK
162 ://
163 ://  write(1000);      // 1000
164 :acc16= variable 2
165 :call writeAcc16
166 ://  j = 1001;
167 :acc16= constant 1000
168 :call writeAcc16
169 :acc16= constant 1001
170 :acc16=> variable 4
171 ://  write(j);         // 1001
172 ://
173 ://  write(1000 + 2);  // 1002
174 :acc16= variable 4
175 :call writeAcc16
176 :acc16= constant 1000
177 :acc8= constant 2
178 :acc16+ acc8
179 ://  write(3 + 1000);  // 1003
180 :call writeAcc16
181 :acc8= constant 3
182 :acc8ToAcc16
183 :acc16+ constant 1000
184 ://  write(500 + 504); // 1004
185 :call writeAcc16
186 :acc16= constant 500
187 :acc16+ constant 504
188 ://  i = 1000 + 5;
189 :call writeAcc16
190 :acc16= constant 1000
191 :acc8= constant 5
192 :acc16+ acc8
193 :acc16=> variable 2
194 ://  write(i);         // 1005
195 ://  i = 6 + 1000;
196 :acc16= variable 2
197 :call writeAcc16
198 :acc8= constant 6
199 :acc8ToAcc16
200 :acc16+ constant 1000
201 :acc16=> variable 2
202 ://  write(i);         // 1006
203 ://  i = 500 + 507;
204 :acc16= variable 2
205 :call writeAcc16
206 :acc16= constant 500
207 :acc16+ constant 507
208 :acc16=> variable 2
209 ://  write(i);         // 1007
210 ://  
211 ://  j = 1000;
212 :acc16= variable 2
213 :call writeAcc16
214 :acc16= constant 1000
215 :acc16=> variable 4
216 ://  b = 10;
217 :acc8= constant 10
218 :acc8=> variable 0
219 ://  i = 514;
220 :acc16= constant 514
221 :acc16=> variable 2
222 ://  write(j + 8);     // 1008
223 :acc16= variable 4
224 :acc8= constant 8
225 :acc16+ acc8
226 ://  write(9 + j);     // 1009
227 :call writeAcc16
228 :acc8= constant 9
229 :acc8ToAcc16
230 :acc16+ variable 4
231 ://  write(j + b);     // 1010
232 :call writeAcc16
233 :acc16= variable 4
234 :acc8= variable 0
235 :acc16+ acc8
236 ://  b++;
237 :call writeAcc16
238 :incr8 variable 0
239 ://  write(b + j);     // 1011
240 :acc8= variable 0
241 :acc8ToAcc16
242 :acc16+ variable 4
243 ://  j = 500;
244 :call writeAcc16
245 :acc16= constant 500
246 :acc16=> variable 4
247 ://  write(j + 512);   // 1012
248 :acc16= variable 4
249 :acc16+ constant 512
250 ://  write(513 + j);   // 1013
251 :call writeAcc16
252 :acc16= constant 513
253 :acc16+ variable 4
254 ://  write(i + j);     // 1014
255 :call writeAcc16
256 :acc16= variable 2
257 :acc16+ variable 4
258 ://  
259 ://  j = 1000;
260 :call writeAcc16
261 :acc16= constant 1000
262 :acc16=> variable 4
263 ://  b = 17;
264 :acc8= constant 17
265 :acc8=> variable 0
266 ://  i = j + 15;
267 :acc16= variable 4
268 :acc8= constant 15
269 :acc16+ acc8
270 :acc16=> variable 2
271 ://  write(i);         // 1015
272 ://  i = 16 + j;
273 :acc16= variable 2
274 :call writeAcc16
275 :acc8= constant 16
276 :acc8ToAcc16
277 :acc16+ variable 4
278 :acc16=> variable 2
279 ://  write(i);         // 1016
280 ://  i = j + b;
281 :acc16= variable 2
282 :call writeAcc16
283 :acc16= variable 4
284 :acc8= variable 0
285 :acc16+ acc8
286 :acc16=> variable 2
287 ://  write(i);         // 1017
288 ://  b++;
289 :acc16= variable 2
290 :call writeAcc16
291 :incr8 variable 0
292 ://  i = b + j;
293 :acc8= variable 0
294 :acc8ToAcc16
295 :acc16+ variable 4
296 :acc16=> variable 2
297 ://  write(i);         // 1018
298 ://  j = 500;
299 :acc16= variable 2
300 :call writeAcc16
301 :acc16= constant 500
302 :acc16=> variable 4
303 ://  i = j + 519;
304 :acc16= variable 4
305 :acc16+ constant 519
306 :acc16=> variable 2
307 ://  write(i);         // 1019
308 ://  i = 520 + j;
309 :acc16= variable 2
310 :call writeAcc16
311 :acc16= constant 520
312 :acc16+ variable 4
313 :acc16=> variable 2
314 ://  write(i);         // 1020
315 ://  i = 521;
316 :acc16= variable 2
317 :call writeAcc16
318 :acc16= constant 521
319 :acc16=> variable 2
320 ://  i = i + j;
321 :acc16= variable 2
322 :acc16+ variable 4
323 :acc16=> variable 2
324 ://  write(i);         // 1021
325 ://}
326 :acc16= variable 2
327 :call writeAcc16
328 :stop
