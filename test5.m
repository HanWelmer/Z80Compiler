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
 22 ;test5.p(10)   if (4 >= four) write(63);
 23 acc8= constant 4
 24 acc16= variable 2
 25 acc8CompareAcc16
 26 brlt 30
 27 acc8= constant 63
 28 call writeAcc8
 29 ;test5.p(11)   if (4 >= (twelve/(1+2))) write(62);
 30 acc8= constant 4
 31 acc16= variable 6
 32 <acc8= constant 1
 33 acc8+ constant 2
 34 acc16/ acc8
 35 revAcc16Comp unstack
 36 brgt 40
 37 acc8= constant 62
 38 call writeAcc8
 39 ;test5.p(12)   if (5 >= four) write(61);
 40 acc8= constant 5
 41 acc16= variable 2
 42 acc8CompareAcc16
 43 brlt 47
 44 acc8= constant 61
 45 call writeAcc8
 46 ;test5.p(13)   if (5 >= (twelve/(1+2))) write(60);
 47 acc8= constant 5
 48 acc16= variable 6
 49 <acc8= constant 1
 50 acc8+ constant 2
 51 acc16/ acc8
 52 revAcc16Comp unstack
 53 brgt 57
 54 acc8= constant 60
 55 call writeAcc8
 56 ;test5.p(14)   if (4 <= four) write(59);
 57 acc8= constant 4
 58 acc16= variable 2
 59 acc8CompareAcc16
 60 brgt 64
 61 acc8= constant 59
 62 call writeAcc8
 63 ;test5.p(15)   if (4 <= (twelve/(1+2))) write(58);
 64 acc8= constant 4
 65 acc16= variable 6
 66 <acc8= constant 1
 67 acc8+ constant 2
 68 acc16/ acc8
 69 revAcc16Comp unstack
 70 brlt 74
 71 acc8= constant 58
 72 call writeAcc8
 73 ;test5.p(16)   if (3 <= four) write(57);
 74 acc8= constant 3
 75 acc16= variable 2
 76 acc8CompareAcc16
 77 brgt 81
 78 acc8= constant 57
 79 call writeAcc8
 80 ;test5.p(17)   if (3 <= (twelve/(1+2))) write(56);
 81 acc8= constant 3
 82 acc16= variable 6
 83 <acc8= constant 1
 84 acc8+ constant 2
 85 acc16/ acc8
 86 revAcc16Comp unstack
 87 brlt 91
 88 acc8= constant 56
 89 call writeAcc8
 90 ;test5.p(18)   if (5 > four) write(55);
 91 acc8= constant 5
 92 acc16= variable 2
 93 acc8CompareAcc16
 94 brle 98
 95 acc8= constant 55
 96 call writeAcc8
 97 ;test5.p(19)   if (5 > (twelve/(1+2))) write(54);
 98 acc8= constant 5
 99 acc16= variable 6
100 <acc8= constant 1
101 acc8+ constant 2
102 acc16/ acc8
103 revAcc16Comp unstack
104 brge 108
105 acc8= constant 54
106 call writeAcc8
107 ;test5.p(20)   if (3 < four) write(53);
108 acc8= constant 3
109 acc16= variable 2
110 acc8CompareAcc16
111 brge 115
112 acc8= constant 53
113 call writeAcc8
114 ;test5.p(21)   if (3 < (twelve/(1+2))) write(52);
115 acc8= constant 3
116 acc16= variable 6
117 <acc8= constant 1
118 acc8+ constant 2
119 acc16/ acc8
120 revAcc16Comp unstack
121 brle 125
122 acc8= constant 52
123 call writeAcc8
124 ;test5.p(22)   if (3 != four) write(51);
125 acc8= constant 3
126 acc16= variable 2
127 acc8CompareAcc16
128 breq 132
129 acc8= constant 51
130 call writeAcc8
131 ;test5.p(23)   if (3 != (twelve/(1+2))) write(50);
132 acc8= constant 3
133 acc16= variable 6
134 <acc8= constant 1
135 acc8+ constant 2
136 acc16/ acc8
137 revAcc16Comp unstack
138 breq 142
139 acc8= constant 50
140 call writeAcc8
141 ;test5.p(24)   if (4 == four) write(49);
142 acc8= constant 4
143 acc16= variable 2
144 acc8CompareAcc16
145 brne 149
146 acc8= constant 49
147 call writeAcc8
148 ;test5.p(25)   if (4 == (twelve/(1+2))) write(48);
149 acc8= constant 4
150 acc16= variable 6
151 <acc8= constant 1
152 acc8+ constant 2
153 acc16/ acc8
154 revAcc16Comp unstack
155 brne 160
156 acc8= constant 48
157 call writeAcc8
158 ;test5.p(26)   //integer-byte
159 ;test5.p(27)   if (four >= 4) write(47);
160 acc16= variable 2
161 acc8= constant 4
162 acc16CompareAcc8
163 brlt 167
164 acc8= constant 47
165 call writeAcc8
166 ;test5.p(28)   if (four >= (12/(1+2))) write(46);
167 acc16= variable 2
168 acc8= constant 12
169 <acc8= constant 1
170 acc8+ constant 2
171 /acc8 unstack
172 acc16CompareAcc8
173 brlt 177
174 acc8= constant 46
175 call writeAcc8
176 ;test5.p(29)   if (five >= 4) write(45);
177 acc16= variable 4
178 acc8= constant 4
179 acc16CompareAcc8
180 brlt 184
181 acc8= constant 45
182 call writeAcc8
183 ;test5.p(30)   if (five >= (12/(1+2))) write(44);
184 acc16= variable 4
185 acc8= constant 12
186 <acc8= constant 1
187 acc8+ constant 2
188 /acc8 unstack
189 acc16CompareAcc8
190 brlt 194
191 acc8= constant 44
192 call writeAcc8
193 ;test5.p(31)   if (four <= 4) write(43);
194 acc16= variable 2
195 acc8= constant 4
196 acc16CompareAcc8
197 brgt 201
198 acc8= constant 43
199 call writeAcc8
200 ;test5.p(32)   if (four <= (12/(1+2))) write(42);
201 acc16= variable 2
202 acc8= constant 12
203 <acc8= constant 1
204 acc8+ constant 2
205 /acc8 unstack
206 acc16CompareAcc8
207 brgt 211
208 acc8= constant 42
209 call writeAcc8
210 ;test5.p(33)   if (three <= 4) write(41);
211 acc16= variable 0
212 acc8= constant 4
213 acc16CompareAcc8
214 brgt 218
215 acc8= constant 41
216 call writeAcc8
217 ;test5.p(34)   if (three <= (12/(1+2))) write(40);
218 acc16= variable 0
219 acc8= constant 12
220 <acc8= constant 1
221 acc8+ constant 2
222 /acc8 unstack
223 acc16CompareAcc8
224 brgt 228
225 acc8= constant 40
226 call writeAcc8
227 ;test5.p(35)   if (five > 4) write(39);
228 acc16= variable 4
229 acc8= constant 4
230 acc16CompareAcc8
231 brle 235
232 acc8= constant 39
233 call writeAcc8
234 ;test5.p(36)   if (five > (12/(1+2))) write(38);
235 acc16= variable 4
236 acc8= constant 12
237 <acc8= constant 1
238 acc8+ constant 2
239 /acc8 unstack
240 acc16CompareAcc8
241 brle 245
242 acc8= constant 38
243 call writeAcc8
244 ;test5.p(37)   if (three < 4) write(37);
245 acc16= variable 0
246 acc8= constant 4
247 acc16CompareAcc8
248 brge 252
249 acc8= constant 37
250 call writeAcc8
251 ;test5.p(38)   if (three < (12/(1+2))) write(36);
252 acc16= variable 0
253 acc8= constant 12
254 <acc8= constant 1
255 acc8+ constant 2
256 /acc8 unstack
257 acc16CompareAcc8
258 brge 262
259 acc8= constant 36
260 call writeAcc8
261 ;test5.p(39)   if (three != 4) write(35);
262 acc16= variable 0
263 acc8= constant 4
264 acc16CompareAcc8
265 breq 269
266 acc8= constant 35
267 call writeAcc8
268 ;test5.p(40)   if (three != (12/(1+2))) write(34);
269 acc16= variable 0
270 acc8= constant 12
271 <acc8= constant 1
272 acc8+ constant 2
273 /acc8 unstack
274 acc16CompareAcc8
275 breq 279
276 acc8= constant 34
277 call writeAcc8
278 ;test5.p(41)   if (four == 4) write(33);
279 acc16= variable 2
280 acc8= constant 4
281 acc16CompareAcc8
282 brne 286
283 acc8= constant 33
284 call writeAcc8
285 ;test5.p(42)   if (four == (12/(1+2))) write(32);
286 acc16= variable 2
287 acc8= constant 12
288 <acc8= constant 1
289 acc8+ constant 2
290 /acc8 unstack
291 acc16CompareAcc8
292 brne 297
293 acc8= constant 32
294 call writeAcc8
295 ;test5.p(43)   //integer-integer
296 ;test5.p(44)   if (400 >= 400) write(31);
297 acc16= constant 400
298 acc16Comp constant 400
299 brlt 303
300 acc8= constant 31
301 call writeAcc8
302 ;test5.p(45)   if (400 >= (1200/(1+2))) write(30);
303 acc16= constant 400
304 <acc16= constant 1200
305 acc8= constant 1
306 acc8+ constant 2
307 acc16/ acc8
308 revAcc16Comp unstack
309 brgt 313
310 acc8= constant 30
311 call writeAcc8
312 ;test5.p(46)   if (500 >= 400) write(29);
313 acc16= constant 500
314 acc16Comp constant 400
315 brlt 319
316 acc8= constant 29
317 call writeAcc8
318 ;test5.p(47)   if (500 >= (1200/(1+2))) write(28);
319 acc16= constant 500
320 <acc16= constant 1200
321 acc8= constant 1
322 acc8+ constant 2
323 acc16/ acc8
324 revAcc16Comp unstack
325 brgt 329
326 acc8= constant 28
327 call writeAcc8
328 ;test5.p(48)   if (400 <= 400) write(27);
329 acc16= constant 400
330 acc16Comp constant 400
331 brgt 335
332 acc8= constant 27
333 call writeAcc8
334 ;test5.p(49)   if (400 <= (1200/(1+2))) write(26);
335 acc16= constant 400
336 <acc16= constant 1200
337 acc8= constant 1
338 acc8+ constant 2
339 acc16/ acc8
340 revAcc16Comp unstack
341 brlt 345
342 acc8= constant 26
343 call writeAcc8
344 ;test5.p(50)   if (300 <= 400) write(25);
345 acc16= constant 300
346 acc16Comp constant 400
347 brgt 351
348 acc8= constant 25
349 call writeAcc8
350 ;test5.p(51)   if (300 <= (1200/(1+2))) write(24);
351 acc16= constant 300
352 <acc16= constant 1200
353 acc8= constant 1
354 acc8+ constant 2
355 acc16/ acc8
356 revAcc16Comp unstack
357 brlt 361
358 acc8= constant 24
359 call writeAcc8
360 ;test5.p(52)   if (500 > 400) write(23);
361 acc16= constant 500
362 acc16Comp constant 400
363 brle 367
364 acc8= constant 23
365 call writeAcc8
366 ;test5.p(53)   if (500 > (1200/(1+2))) write(22);
367 acc16= constant 500
368 <acc16= constant 1200
369 acc8= constant 1
370 acc8+ constant 2
371 acc16/ acc8
372 revAcc16Comp unstack
373 brge 377
374 acc8= constant 22
375 call writeAcc8
376 ;test5.p(54)   if (300 < 400) write(21);
377 acc16= constant 300
378 acc16Comp constant 400
379 brge 383
380 acc8= constant 21
381 call writeAcc8
382 ;test5.p(55)   if (300 < (1200/(1+2))) write(20);
383 acc16= constant 300
384 <acc16= constant 1200
385 acc8= constant 1
386 acc8+ constant 2
387 acc16/ acc8
388 revAcc16Comp unstack
389 brle 393
390 acc8= constant 20
391 call writeAcc8
392 ;test5.p(56)   if (300 != 400) write(19);
393 acc16= constant 300
394 acc16Comp constant 400
395 breq 399
396 acc8= constant 19
397 call writeAcc8
398 ;test5.p(57)   if (300 != (1200/(1+2))) write(18);
399 acc16= constant 300
400 <acc16= constant 1200
401 acc8= constant 1
402 acc8+ constant 2
403 acc16/ acc8
404 revAcc16Comp unstack
405 breq 409
406 acc8= constant 18
407 call writeAcc8
408 ;test5.p(58)   if (400 == 400) write(17);
409 acc16= constant 400
410 acc16Comp constant 400
411 brne 415
412 acc8= constant 17
413 call writeAcc8
414 ;test5.p(59)   if (400 == (1200/(1+2))) write(16);
415 acc16= constant 400
416 <acc16= constant 1200
417 acc8= constant 1
418 acc8+ constant 2
419 acc16/ acc8
420 revAcc16Comp unstack
421 brne 426
422 acc8= constant 16
423 call writeAcc8
424 ;test5.p(60)   //byte-byte
425 ;test5.p(61)   if (4 >= 4) write(15);
426 acc8= constant 4
427 acc8Comp constant 4
428 brlt 432
429 acc8= constant 15
430 call writeAcc8
431 ;test5.p(62)   if (4 >= (12/(1+2))) write(14);
432 acc8= constant 4
433 <acc8= constant 12
434 <acc8= constant 1
435 acc8+ constant 2
436 /acc8 unstack
437 revAcc8Comp unstack
438 brgt 442
439 acc8= constant 14
440 call writeAcc8
441 ;test5.p(63)   if (5 >= 4) write(13);
442 acc8= constant 5
443 acc8Comp constant 4
444 brlt 448
445 acc8= constant 13
446 call writeAcc8
447 ;test5.p(64)   if (5 >= (12/(1+2))) write(12);
448 acc8= constant 5
449 <acc8= constant 12
450 <acc8= constant 1
451 acc8+ constant 2
452 /acc8 unstack
453 revAcc8Comp unstack
454 brgt 458
455 acc8= constant 12
456 call writeAcc8
457 ;test5.p(65)   if (4 <= 4) write(11);
458 acc8= constant 4
459 acc8Comp constant 4
460 brgt 464
461 acc8= constant 11
462 call writeAcc8
463 ;test5.p(66)   if (4 <= (12/(1+2))) write(10);
464 acc8= constant 4
465 <acc8= constant 12
466 <acc8= constant 1
467 acc8+ constant 2
468 /acc8 unstack
469 revAcc8Comp unstack
470 brlt 474
471 acc8= constant 10
472 call writeAcc8
473 ;test5.p(67)   if (3 <= 4) write(9);
474 acc8= constant 3
475 acc8Comp constant 4
476 brgt 480
477 acc8= constant 9
478 call writeAcc8
479 ;test5.p(68)   if (3 <= (12/(1+2))) write(8);
480 acc8= constant 3
481 <acc8= constant 12
482 <acc8= constant 1
483 acc8+ constant 2
484 /acc8 unstack
485 revAcc8Comp unstack
486 brlt 490
487 acc8= constant 8
488 call writeAcc8
489 ;test5.p(69)   if (5 > 4) write(7);
490 acc8= constant 5
491 acc8Comp constant 4
492 brle 496
493 acc8= constant 7
494 call writeAcc8
495 ;test5.p(70)   if (5 > (12/(1+2))) write(6);
496 acc8= constant 5
497 <acc8= constant 12
498 <acc8= constant 1
499 acc8+ constant 2
500 /acc8 unstack
501 revAcc8Comp unstack
502 brge 506
503 acc8= constant 6
504 call writeAcc8
505 ;test5.p(71)   if (3 < 4) write(5);
506 acc8= constant 3
507 acc8Comp constant 4
508 brge 512
509 acc8= constant 5
510 call writeAcc8
511 ;test5.p(72)   if (3 < (12/(1+2))) write(4);
512 acc8= constant 3
513 <acc8= constant 12
514 <acc8= constant 1
515 acc8+ constant 2
516 /acc8 unstack
517 revAcc8Comp unstack
518 brle 522
519 acc8= constant 4
520 call writeAcc8
521 ;test5.p(73)   if (3 != 4) write(3);
522 acc8= constant 3
523 acc8Comp constant 4
524 breq 528
525 acc8= constant 3
526 call writeAcc8
527 ;test5.p(74)   if (3 != (12/(1+2))) write(2);
528 acc8= constant 3
529 <acc8= constant 12
530 <acc8= constant 1
531 acc8+ constant 2
532 /acc8 unstack
533 revAcc8Comp unstack
534 breq 538
535 acc8= constant 2
536 call writeAcc8
537 ;test5.p(75)   if (4 == 4) write(1);
538 acc8= constant 4
539 acc8Comp constant 4
540 brne 544
541 acc8= constant 1
542 call writeAcc8
543 ;test5.p(76)   if (4 == (12/(1+2))) write(0);
544 acc8= constant 4
545 <acc8= constant 12
546 <acc8= constant 1
547 acc8+ constant 2
548 /acc8 unstack
549 revAcc8Comp unstack
550 brne 554
551 acc8= constant 0
552 call writeAcc8
553 ;test5.p(77) }
554 stop
