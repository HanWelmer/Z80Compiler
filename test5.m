  0 ;test5.p(0) /*
  1 ;test5.p(1)  * A small program in the miniJava language.
  2 ;test5.p(2)  * Test comparisons
  3 ;test5.p(3)  */
  4 ;test5.p(4) class TestIf {
  5 ;test5.p(5)   int three = 3;
  6 acc8= constant 3
  7 acc8ToAcc16
  8 acc16=> variable 0
  9 ;test5.p(6)   int four = 4;
 10 acc8= constant 4
 11 acc8ToAcc16
 12 acc16=> variable 2
 13 ;test5.p(7)   int five = 5;
 14 acc8= constant 5
 15 acc8ToAcc16
 16 acc16=> variable 4
 17 ;test5.p(8)   int twelve = 12;
 18 acc8= constant 12
 19 acc8ToAcc16
 20 acc16=> variable 6
 21 ;test5.p(9)   //byte-integer
 22 ;test5.p(10)   /*
 23 ;test5.p(11)   if (4 >= four) write(63);
 24 ;test5.p(12)   if (4 >= (twelve/(1+2))) write(62);
 25 ;test5.p(13)   if (5 >= four) write(61);
 26 ;test5.p(14)   if (5 >= (twelve/(1+2))) write(60);
 27 ;test5.p(15)   if (4 <= four) write(59);
 28 ;test5.p(16)   if (4 <= (twelve/(1+2))) write(58);
 29 ;test5.p(17)   if (3 <= four) write(57);
 30 ;test5.p(18)   if (3 <= (twelve/(1+2))) write(56);
 31 ;test5.p(19)   if (5 > four) write(55);
 32 ;test5.p(20)   if (5 > (twelve/(1+2))) write(54);
 33 ;test5.p(21)   if (3 < four) write(53);
 34 ;test5.p(22)   if (3 < (twelve/(1+2))) write(52);
 35 ;test5.p(23)   if (3 != four) write(51);
 36 ;test5.p(24)   if (3 != (twelve/(1+2))) write(50);
 37 ;test5.p(25)   */
 38 ;test5.p(26)   if (4 == four) write(49);
 39 acc8= constant 4
 40 acc16= variable 2
 41 acc8CompareAcc16
 42 brne 46
 43 acc8= constant 49
 44 call writeAcc8
 45 ;test5.p(27)   if (4 == (twelve/(1+2))) write(48);
 46 acc8= constant 4
 47 acc16= variable 6
 48 <acc8= constant 1
 49 acc8+ constant 2
 50 acc16/ acc8
 51 comacc16 unstack
 52 brne 57
 53 acc8= constant 48
 54 call writeAcc8
 55 ;test5.p(28)   //integer-byte
 56 ;test5.p(29)   if (four >= 4) write(47);
 57 acc16= variable 2
 58 acc8= constant 4
 59 acc16CompareAcc8
 60 brlt 64
 61 acc8= constant 47
 62 call writeAcc8
 63 ;test5.p(30)   if (four >= (12/(1+2))) write(46);
 64 acc16= variable 2
 65 acc8= constant 12
 66 <acc8= constant 1
 67 acc8+ constant 2
 68 /acc8 unstack
 69 acc16CompareAcc8
 70 brlt 74
 71 acc8= constant 46
 72 call writeAcc8
 73 ;test5.p(31)   if (five >= 4) write(45);
 74 acc16= variable 4
 75 acc8= constant 4
 76 acc16CompareAcc8
 77 brlt 81
 78 acc8= constant 45
 79 call writeAcc8
 80 ;test5.p(32)   if (five >= (12/(1+2))) write(44);
 81 acc16= variable 4
 82 acc8= constant 12
 83 <acc8= constant 1
 84 acc8+ constant 2
 85 /acc8 unstack
 86 acc16CompareAcc8
 87 brlt 91
 88 acc8= constant 44
 89 call writeAcc8
 90 ;test5.p(33)   if (four <= 4) write(43);
 91 acc16= variable 2
 92 acc8= constant 4
 93 acc16CompareAcc8
 94 brgt 98
 95 acc8= constant 43
 96 call writeAcc8
 97 ;test5.p(34)   if (four <= (12/(1+2))) write(42);
 98 acc16= variable 2
 99 acc8= constant 12
100 <acc8= constant 1
101 acc8+ constant 2
102 /acc8 unstack
103 acc16CompareAcc8
104 brgt 108
105 acc8= constant 42
106 call writeAcc8
107 ;test5.p(35)   if (three <= 4) write(41);
108 acc16= variable 0
109 acc8= constant 4
110 acc16CompareAcc8
111 brgt 115
112 acc8= constant 41
113 call writeAcc8
114 ;test5.p(36)   if (three <= (12/(1+2))) write(40);
115 acc16= variable 0
116 acc8= constant 12
117 <acc8= constant 1
118 acc8+ constant 2
119 /acc8 unstack
120 acc16CompareAcc8
121 brgt 125
122 acc8= constant 40
123 call writeAcc8
124 ;test5.p(37)   if (five > 4) write(39);
125 acc16= variable 4
126 acc8= constant 4
127 acc16CompareAcc8
128 brle 132
129 acc8= constant 39
130 call writeAcc8
131 ;test5.p(38)   if (five > (12/(1+2))) write(38);
132 acc16= variable 4
133 acc8= constant 12
134 <acc8= constant 1
135 acc8+ constant 2
136 /acc8 unstack
137 acc16CompareAcc8
138 brle 142
139 acc8= constant 38
140 call writeAcc8
141 ;test5.p(39)   if (three < 4) write(37);
142 acc16= variable 0
143 acc8= constant 4
144 acc16CompareAcc8
145 brge 149
146 acc8= constant 37
147 call writeAcc8
148 ;test5.p(40)   if (three < (12/(1+2))) write(36);
149 acc16= variable 0
150 acc8= constant 12
151 <acc8= constant 1
152 acc8+ constant 2
153 /acc8 unstack
154 acc16CompareAcc8
155 brge 159
156 acc8= constant 36
157 call writeAcc8
158 ;test5.p(41)   if (three != 4) write(35);
159 acc16= variable 0
160 acc8= constant 4
161 acc16CompareAcc8
162 breq 166
163 acc8= constant 35
164 call writeAcc8
165 ;test5.p(42)   if (three != (12/(1+2))) write(34);
166 acc16= variable 0
167 acc8= constant 12
168 <acc8= constant 1
169 acc8+ constant 2
170 /acc8 unstack
171 acc16CompareAcc8
172 breq 176
173 acc8= constant 34
174 call writeAcc8
175 ;test5.p(43)   if (four == 4) write(33);
176 acc16= variable 2
177 acc8= constant 4
178 acc16CompareAcc8
179 brne 183
180 acc8= constant 33
181 call writeAcc8
182 ;test5.p(44)   if (four == (12/(1+2))) write(32);
183 acc16= variable 2
184 acc8= constant 12
185 <acc8= constant 1
186 acc8+ constant 2
187 /acc8 unstack
188 acc16CompareAcc8
189 brne 194
190 acc8= constant 32
191 call writeAcc8
192 ;test5.p(45)   //integer-integer
193 ;test5.p(46)   if (400 >= 400) write(31);
194 acc16= constant 400
195 accom16 constant 400
196 brlt 200
197 acc8= constant 31
198 call writeAcc8
199 ;test5.p(47)   if (400 >= (1200/(1+2))) write(30);
200 acc16= constant 400
201 <acc16= constant 1200
202 acc8= constant 1
203 acc8+ constant 2
204 acc16/ acc8
205 comacc16 unstack
206 brgt 210
207 acc8= constant 30
208 call writeAcc8
209 ;test5.p(48)   if (500 >= 400) write(29);
210 acc16= constant 500
211 accom16 constant 400
212 brlt 216
213 acc8= constant 29
214 call writeAcc8
215 ;test5.p(49)   if (500 >= (1200/(1+2))) write(28);
216 acc16= constant 500
217 <acc16= constant 1200
218 acc8= constant 1
219 acc8+ constant 2
220 acc16/ acc8
221 comacc16 unstack
222 brgt 226
223 acc8= constant 28
224 call writeAcc8
225 ;test5.p(50)   if (400 <= 400) write(27);
226 acc16= constant 400
227 accom16 constant 400
228 brgt 232
229 acc8= constant 27
230 call writeAcc8
231 ;test5.p(51)   if (400 <= (1200/(1+2))) write(26);
232 acc16= constant 400
233 <acc16= constant 1200
234 acc8= constant 1
235 acc8+ constant 2
236 acc16/ acc8
237 comacc16 unstack
238 brlt 242
239 acc8= constant 26
240 call writeAcc8
241 ;test5.p(52)   if (300 <= 400) write(25);
242 acc16= constant 300
243 accom16 constant 400
244 brgt 248
245 acc8= constant 25
246 call writeAcc8
247 ;test5.p(53)   if (300 <= (1200/(1+2))) write(24);
248 acc16= constant 300
249 <acc16= constant 1200
250 acc8= constant 1
251 acc8+ constant 2
252 acc16/ acc8
253 comacc16 unstack
254 brlt 258
255 acc8= constant 24
256 call writeAcc8
257 ;test5.p(54)   if (500 > 400) write(23);
258 acc16= constant 500
259 accom16 constant 400
260 brle 264
261 acc8= constant 23
262 call writeAcc8
263 ;test5.p(55)   if (500 > (1200/(1+2))) write(22);
264 acc16= constant 500
265 <acc16= constant 1200
266 acc8= constant 1
267 acc8+ constant 2
268 acc16/ acc8
269 comacc16 unstack
270 brge 274
271 acc8= constant 22
272 call writeAcc8
273 ;test5.p(56)   if (300 < 400) write(21);
274 acc16= constant 300
275 accom16 constant 400
276 brge 280
277 acc8= constant 21
278 call writeAcc8
279 ;test5.p(57)   if (300 < (1200/(1+2))) write(20);
280 acc16= constant 300
281 <acc16= constant 1200
282 acc8= constant 1
283 acc8+ constant 2
284 acc16/ acc8
285 comacc16 unstack
286 brle 290
287 acc8= constant 20
288 call writeAcc8
289 ;test5.p(58)   if (300 != 400) write(19);
290 acc16= constant 300
291 accom16 constant 400
292 breq 296
293 acc8= constant 19
294 call writeAcc8
295 ;test5.p(59)   if (300 != (1200/(1+2))) write(18);
296 acc16= constant 300
297 <acc16= constant 1200
298 acc8= constant 1
299 acc8+ constant 2
300 acc16/ acc8
301 comacc16 unstack
302 breq 306
303 acc8= constant 18
304 call writeAcc8
305 ;test5.p(60)   if (400 == 400) write(17);
306 acc16= constant 400
307 accom16 constant 400
308 brne 312
309 acc8= constant 17
310 call writeAcc8
311 ;test5.p(61)   if (400 == (1200/(1+2))) write(16);
312 acc16= constant 400
313 <acc16= constant 1200
314 acc8= constant 1
315 acc8+ constant 2
316 acc16/ acc8
317 comacc16 unstack
318 brne 323
319 acc8= constant 16
320 call writeAcc8
321 ;test5.p(62)   //byte-byte
322 ;test5.p(63)   if (4 >= 4) write(15);
323 acc8= constant 4
324 accom8 constant 4
325 brlt 329
326 acc8= constant 15
327 call writeAcc8
328 ;test5.p(64)   if (4 >= (12/(1+2))) write(14);
329 acc8= constant 4
330 <acc8= constant 12
331 <acc8= constant 1
332 acc8+ constant 2
333 /acc8 unstack
334 comacc8 unstack
335 brgt 339
336 acc8= constant 14
337 call writeAcc8
338 ;test5.p(65)   if (5 >= 4) write(13);
339 acc8= constant 5
340 accom8 constant 4
341 brlt 345
342 acc8= constant 13
343 call writeAcc8
344 ;test5.p(66)   if (5 >= (12/(1+2))) write(12);
345 acc8= constant 5
346 <acc8= constant 12
347 <acc8= constant 1
348 acc8+ constant 2
349 /acc8 unstack
350 comacc8 unstack
351 brgt 355
352 acc8= constant 12
353 call writeAcc8
354 ;test5.p(67)   if (4 <= 4) write(11);
355 acc8= constant 4
356 accom8 constant 4
357 brgt 361
358 acc8= constant 11
359 call writeAcc8
360 ;test5.p(68)   if (4 <= (12/(1+2))) write(10);
361 acc8= constant 4
362 <acc8= constant 12
363 <acc8= constant 1
364 acc8+ constant 2
365 /acc8 unstack
366 comacc8 unstack
367 brlt 371
368 acc8= constant 10
369 call writeAcc8
370 ;test5.p(69)   if (3 <= 4) write(9);
371 acc8= constant 3
372 accom8 constant 4
373 brgt 377
374 acc8= constant 9
375 call writeAcc8
376 ;test5.p(70)   if (3 <= (12/(1+2))) write(8);
377 acc8= constant 3
378 <acc8= constant 12
379 <acc8= constant 1
380 acc8+ constant 2
381 /acc8 unstack
382 comacc8 unstack
383 brlt 387
384 acc8= constant 8
385 call writeAcc8
386 ;test5.p(71)   if (5 > 4) write(7);
387 acc8= constant 5
388 accom8 constant 4
389 brle 393
390 acc8= constant 7
391 call writeAcc8
392 ;test5.p(72)   if (5 > (12/(1+2))) write(6);
393 acc8= constant 5
394 <acc8= constant 12
395 <acc8= constant 1
396 acc8+ constant 2
397 /acc8 unstack
398 comacc8 unstack
399 brge 403
400 acc8= constant 6
401 call writeAcc8
402 ;test5.p(73)   if (3 < 4) write(5);
403 acc8= constant 3
404 accom8 constant 4
405 brge 409
406 acc8= constant 5
407 call writeAcc8
408 ;test5.p(74)   if (3 < (12/(1+2))) write(4);
409 acc8= constant 3
410 <acc8= constant 12
411 <acc8= constant 1
412 acc8+ constant 2
413 /acc8 unstack
414 comacc8 unstack
415 brle 419
416 acc8= constant 4
417 call writeAcc8
418 ;test5.p(75)   if (3 != 4) write(3);
419 acc8= constant 3
420 accom8 constant 4
421 breq 425
422 acc8= constant 3
423 call writeAcc8
424 ;test5.p(76)   if (3 != (12/(1+2))) write(2);
425 acc8= constant 3
426 <acc8= constant 12
427 <acc8= constant 1
428 acc8+ constant 2
429 /acc8 unstack
430 comacc8 unstack
431 breq 435
432 acc8= constant 2
433 call writeAcc8
434 ;test5.p(77)   if (4 == 4) write(1);
435 acc8= constant 4
436 accom8 constant 4
437 brne 441
438 acc8= constant 1
439 call writeAcc8
440 ;test5.p(78)   if (4 == (12/(1+2))) write(0);
441 acc8= constant 4
442 <acc8= constant 12
443 <acc8= constant 1
444 acc8+ constant 2
445 /acc8 unstack
446 comacc8 unstack
447 brne 451
448 acc8= constant 0
449 call writeAcc8
450 ;test5.p(79) }
451 stop
