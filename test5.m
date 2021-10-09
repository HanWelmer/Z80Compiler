  0 ;test5.p(0) /*
  1 ;test5.p(1)  * A small program in the miniJava language.
  2 ;test5.p(2)  * Test comparisons
  3 ;test5.p(3)  */
  4 ;test5.p(4) class TestIf {
  5 ;test5.p(5)   int one = 1;
  6 acc8= constant 1
  7 acc8ToAcc16
  8 acc16=> variable 0
  9 ;test5.p(6)   int three = 3;
 10 acc8= constant 3
 11 acc8ToAcc16
 12 acc16=> variable 2
 13 ;test5.p(7)   int four = 4;
 14 acc8= constant 4
 15 acc8ToAcc16
 16 acc16=> variable 4
 17 ;test5.p(8)   int five = 5;
 18 acc8= constant 5
 19 acc8ToAcc16
 20 acc16=> variable 6
 21 ;test5.p(9)   int twelve = 12;
 22 acc8= constant 12
 23 acc8ToAcc16
 24 acc16=> variable 8
 25 ;test5.p(10)   //stack level 2
 26 ;test5.p(11)   if (4 == (twelve/(1+2))) write(65);
 27 acc8= constant 4
 28 acc16= variable 8
 29 <acc8= constant 1
 30 acc8+ constant 2
 31 acc16/ acc8
 32 revAcc16Comp unstack8
 33 brne 37
 34 acc8= constant 65
 35 call writeAcc8
 36 ;test5.p(12)   if (four == (12/(one+2))) write(64);
 37 acc16= variable 4
 38 acc8= constant 12
 39 <acc16= variable 0
 40 acc16+ constant 2
 41 /acc16 acc8
 42 revAcc16Comp unstack16
 43 brne 48
 44 acc8= constant 64
 45 call writeAcc8
 46 ;test5.p(13)   //byte-integer
 47 ;test5.p(14)   if (4 >= four) write(63);
 48 acc8= constant 4
 49 acc16= variable 4
 50 acc8CompareAcc16
 51 brlt 55
 52 acc8= constant 63
 53 call writeAcc8
 54 ;test5.p(15)   if (4 >= (twelve/(1+2))) write(62);
 55 acc8= constant 4
 56 acc16= variable 8
 57 <acc8= constant 1
 58 acc8+ constant 2
 59 acc16/ acc8
 60 revAcc16Comp unstack8
 61 brgt 65
 62 acc8= constant 62
 63 call writeAcc8
 64 ;test5.p(16)   if (5 >= four) write(61);
 65 acc8= constant 5
 66 acc16= variable 4
 67 acc8CompareAcc16
 68 brlt 72
 69 acc8= constant 61
 70 call writeAcc8
 71 ;test5.p(17)   if (5 >= (twelve/(1+2))) write(60);
 72 acc8= constant 5
 73 acc16= variable 8
 74 <acc8= constant 1
 75 acc8+ constant 2
 76 acc16/ acc8
 77 revAcc16Comp unstack8
 78 brgt 82
 79 acc8= constant 60
 80 call writeAcc8
 81 ;test5.p(18)   if (4 <= four) write(59);
 82 acc8= constant 4
 83 acc16= variable 4
 84 acc8CompareAcc16
 85 brgt 89
 86 acc8= constant 59
 87 call writeAcc8
 88 ;test5.p(19)   if (4 <= (twelve/(1+2))) write(58);
 89 acc8= constant 4
 90 acc16= variable 8
 91 <acc8= constant 1
 92 acc8+ constant 2
 93 acc16/ acc8
 94 revAcc16Comp unstack8
 95 brlt 99
 96 acc8= constant 58
 97 call writeAcc8
 98 ;test5.p(20)   if (3 <= four) write(57);
 99 acc8= constant 3
100 acc16= variable 4
101 acc8CompareAcc16
102 brgt 106
103 acc8= constant 57
104 call writeAcc8
105 ;test5.p(21)   if (3 <= (twelve/(1+2))) write(56);
106 acc8= constant 3
107 acc16= variable 8
108 <acc8= constant 1
109 acc8+ constant 2
110 acc16/ acc8
111 revAcc16Comp unstack8
112 brlt 116
113 acc8= constant 56
114 call writeAcc8
115 ;test5.p(22)   if (5 > four) write(55);
116 acc8= constant 5
117 acc16= variable 4
118 acc8CompareAcc16
119 brle 123
120 acc8= constant 55
121 call writeAcc8
122 ;test5.p(23)   if (5 > (twelve/(1+2))) write(54);
123 acc8= constant 5
124 acc16= variable 8
125 <acc8= constant 1
126 acc8+ constant 2
127 acc16/ acc8
128 revAcc16Comp unstack8
129 brge 133
130 acc8= constant 54
131 call writeAcc8
132 ;test5.p(24)   if (3 < four) write(53);
133 acc8= constant 3
134 acc16= variable 4
135 acc8CompareAcc16
136 brge 140
137 acc8= constant 53
138 call writeAcc8
139 ;test5.p(25)   if (3 < (twelve/(1+2))) write(52);
140 acc8= constant 3
141 acc16= variable 8
142 <acc8= constant 1
143 acc8+ constant 2
144 acc16/ acc8
145 revAcc16Comp unstack8
146 brle 150
147 acc8= constant 52
148 call writeAcc8
149 ;test5.p(26)   if (3 != four) write(51);
150 acc8= constant 3
151 acc16= variable 4
152 acc8CompareAcc16
153 breq 157
154 acc8= constant 51
155 call writeAcc8
156 ;test5.p(27)   if (3 != (twelve/(1+2))) write(50);
157 acc8= constant 3
158 acc16= variable 8
159 <acc8= constant 1
160 acc8+ constant 2
161 acc16/ acc8
162 revAcc16Comp unstack8
163 breq 167
164 acc8= constant 50
165 call writeAcc8
166 ;test5.p(28)   if (4 == four) write(49);
167 acc8= constant 4
168 acc16= variable 4
169 acc8CompareAcc16
170 brne 174
171 acc8= constant 49
172 call writeAcc8
173 ;test5.p(29)   if (4 == (twelve/(1+2))) write(48);
174 acc8= constant 4
175 acc16= variable 8
176 <acc8= constant 1
177 acc8+ constant 2
178 acc16/ acc8
179 revAcc16Comp unstack8
180 brne 185
181 acc8= constant 48
182 call writeAcc8
183 ;test5.p(30)   //integer-byte
184 ;test5.p(31)   if (four >= 4) write(47);
185 acc16= variable 4
186 acc8= constant 4
187 acc16CompareAcc8
188 brlt 192
189 acc8= constant 47
190 call writeAcc8
191 ;test5.p(32)   if (four >= (12/(1+2))) write(46);
192 acc16= variable 4
193 acc8= constant 12
194 <acc8= constant 1
195 acc8+ constant 2
196 /acc8 unstack8
197 acc16CompareAcc8
198 brlt 202
199 acc8= constant 46
200 call writeAcc8
201 ;test5.p(33)   if (five >= 4) write(45);
202 acc16= variable 6
203 acc8= constant 4
204 acc16CompareAcc8
205 brlt 209
206 acc8= constant 45
207 call writeAcc8
208 ;test5.p(34)   if (five >= (12/(1+2))) write(44);
209 acc16= variable 6
210 acc8= constant 12
211 <acc8= constant 1
212 acc8+ constant 2
213 /acc8 unstack8
214 acc16CompareAcc8
215 brlt 219
216 acc8= constant 44
217 call writeAcc8
218 ;test5.p(35)   if (four <= 4) write(43);
219 acc16= variable 4
220 acc8= constant 4
221 acc16CompareAcc8
222 brgt 226
223 acc8= constant 43
224 call writeAcc8
225 ;test5.p(36)   if (four <= (12/(1+2))) write(42);
226 acc16= variable 4
227 acc8= constant 12
228 <acc8= constant 1
229 acc8+ constant 2
230 /acc8 unstack8
231 acc16CompareAcc8
232 brgt 236
233 acc8= constant 42
234 call writeAcc8
235 ;test5.p(37)   if (three <= 4) write(41);
236 acc16= variable 2
237 acc8= constant 4
238 acc16CompareAcc8
239 brgt 243
240 acc8= constant 41
241 call writeAcc8
242 ;test5.p(38)   if (three <= (12/(1+2))) write(40);
243 acc16= variable 2
244 acc8= constant 12
245 <acc8= constant 1
246 acc8+ constant 2
247 /acc8 unstack8
248 acc16CompareAcc8
249 brgt 253
250 acc8= constant 40
251 call writeAcc8
252 ;test5.p(39)   if (five > 4) write(39);
253 acc16= variable 6
254 acc8= constant 4
255 acc16CompareAcc8
256 brle 260
257 acc8= constant 39
258 call writeAcc8
259 ;test5.p(40)   if (five > (12/(1+2))) write(38);
260 acc16= variable 6
261 acc8= constant 12
262 <acc8= constant 1
263 acc8+ constant 2
264 /acc8 unstack8
265 acc16CompareAcc8
266 brle 270
267 acc8= constant 38
268 call writeAcc8
269 ;test5.p(41)   if (three < 4) write(37);
270 acc16= variable 2
271 acc8= constant 4
272 acc16CompareAcc8
273 brge 277
274 acc8= constant 37
275 call writeAcc8
276 ;test5.p(42)   if (three < (12/(1+2))) write(36);
277 acc16= variable 2
278 acc8= constant 12
279 <acc8= constant 1
280 acc8+ constant 2
281 /acc8 unstack8
282 acc16CompareAcc8
283 brge 287
284 acc8= constant 36
285 call writeAcc8
286 ;test5.p(43)   if (three != 4) write(35);
287 acc16= variable 2
288 acc8= constant 4
289 acc16CompareAcc8
290 breq 294
291 acc8= constant 35
292 call writeAcc8
293 ;test5.p(44)   if (three != (12/(1+2))) write(34);
294 acc16= variable 2
295 acc8= constant 12
296 <acc8= constant 1
297 acc8+ constant 2
298 /acc8 unstack8
299 acc16CompareAcc8
300 breq 304
301 acc8= constant 34
302 call writeAcc8
303 ;test5.p(45)   if (four == 4) write(33);
304 acc16= variable 4
305 acc8= constant 4
306 acc16CompareAcc8
307 brne 311
308 acc8= constant 33
309 call writeAcc8
310 ;test5.p(46)   if (four == (12/(1+2))) write(32);
311 acc16= variable 4
312 acc8= constant 12
313 <acc8= constant 1
314 acc8+ constant 2
315 /acc8 unstack8
316 acc16CompareAcc8
317 brne 322
318 acc8= constant 32
319 call writeAcc8
320 ;test5.p(47)   //integer-integer
321 ;test5.p(48)   if (400 >= 400) write(31);
322 acc16= constant 400
323 acc16Comp constant 400
324 brlt 328
325 acc8= constant 31
326 call writeAcc8
327 ;test5.p(49)   if (400 >= (1200/(1+2))) write(30);
328 acc16= constant 400
329 <acc16= constant 1200
330 acc8= constant 1
331 acc8+ constant 2
332 acc16/ acc8
333 revAcc16Comp unstack16
334 brgt 338
335 acc8= constant 30
336 call writeAcc8
337 ;test5.p(50)   if (500 >= 400) write(29);
338 acc16= constant 500
339 acc16Comp constant 400
340 brlt 344
341 acc8= constant 29
342 call writeAcc8
343 ;test5.p(51)   if (500 >= (1200/(1+2))) write(28);
344 acc16= constant 500
345 <acc16= constant 1200
346 acc8= constant 1
347 acc8+ constant 2
348 acc16/ acc8
349 revAcc16Comp unstack16
350 brgt 354
351 acc8= constant 28
352 call writeAcc8
353 ;test5.p(52)   if (400 <= 400) write(27);
354 acc16= constant 400
355 acc16Comp constant 400
356 brgt 360
357 acc8= constant 27
358 call writeAcc8
359 ;test5.p(53)   if (400 <= (1200/(1+2))) write(26);
360 acc16= constant 400
361 <acc16= constant 1200
362 acc8= constant 1
363 acc8+ constant 2
364 acc16/ acc8
365 revAcc16Comp unstack16
366 brlt 370
367 acc8= constant 26
368 call writeAcc8
369 ;test5.p(54)   if (300 <= 400) write(25);
370 acc16= constant 300
371 acc16Comp constant 400
372 brgt 376
373 acc8= constant 25
374 call writeAcc8
375 ;test5.p(55)   if (300 <= (1200/(1+2))) write(24);
376 acc16= constant 300
377 <acc16= constant 1200
378 acc8= constant 1
379 acc8+ constant 2
380 acc16/ acc8
381 revAcc16Comp unstack16
382 brlt 386
383 acc8= constant 24
384 call writeAcc8
385 ;test5.p(56)   if (500 > 400) write(23);
386 acc16= constant 500
387 acc16Comp constant 400
388 brle 392
389 acc8= constant 23
390 call writeAcc8
391 ;test5.p(57)   if (500 > (1200/(1+2))) write(22);
392 acc16= constant 500
393 <acc16= constant 1200
394 acc8= constant 1
395 acc8+ constant 2
396 acc16/ acc8
397 revAcc16Comp unstack16
398 brge 402
399 acc8= constant 22
400 call writeAcc8
401 ;test5.p(58)   if (300 < 400) write(21);
402 acc16= constant 300
403 acc16Comp constant 400
404 brge 408
405 acc8= constant 21
406 call writeAcc8
407 ;test5.p(59)   if (300 < (1200/(1+2))) write(20);
408 acc16= constant 300
409 <acc16= constant 1200
410 acc8= constant 1
411 acc8+ constant 2
412 acc16/ acc8
413 revAcc16Comp unstack16
414 brle 418
415 acc8= constant 20
416 call writeAcc8
417 ;test5.p(60)   if (300 != 400) write(19);
418 acc16= constant 300
419 acc16Comp constant 400
420 breq 424
421 acc8= constant 19
422 call writeAcc8
423 ;test5.p(61)   if (300 != (1200/(1+2))) write(18);
424 acc16= constant 300
425 <acc16= constant 1200
426 acc8= constant 1
427 acc8+ constant 2
428 acc16/ acc8
429 revAcc16Comp unstack16
430 breq 434
431 acc8= constant 18
432 call writeAcc8
433 ;test5.p(62)   if (400 == 400) write(17);
434 acc16= constant 400
435 acc16Comp constant 400
436 brne 440
437 acc8= constant 17
438 call writeAcc8
439 ;test5.p(63)   if (400 == (1200/(1+2))) write(16);
440 acc16= constant 400
441 <acc16= constant 1200
442 acc8= constant 1
443 acc8+ constant 2
444 acc16/ acc8
445 revAcc16Comp unstack16
446 brne 451
447 acc8= constant 16
448 call writeAcc8
449 ;test5.p(64)   //byte-byte
450 ;test5.p(65)   if (4 >= 4) write(15);
451 acc8= constant 4
452 acc8Comp constant 4
453 brlt 457
454 acc8= constant 15
455 call writeAcc8
456 ;test5.p(66)   if (4 >= (12/(1+2))) write(14);
457 acc8= constant 4
458 <acc8= constant 12
459 <acc8= constant 1
460 acc8+ constant 2
461 /acc8 unstack8
462 revAcc8Comp unstack8
463 brgt 467
464 acc8= constant 14
465 call writeAcc8
466 ;test5.p(67)   if (5 >= 4) write(13);
467 acc8= constant 5
468 acc8Comp constant 4
469 brlt 473
470 acc8= constant 13
471 call writeAcc8
472 ;test5.p(68)   if (5 >= (12/(1+2))) write(12);
473 acc8= constant 5
474 <acc8= constant 12
475 <acc8= constant 1
476 acc8+ constant 2
477 /acc8 unstack8
478 revAcc8Comp unstack8
479 brgt 483
480 acc8= constant 12
481 call writeAcc8
482 ;test5.p(69)   if (4 <= 4) write(11);
483 acc8= constant 4
484 acc8Comp constant 4
485 brgt 489
486 acc8= constant 11
487 call writeAcc8
488 ;test5.p(70)   if (4 <= (12/(1+2))) write(10);
489 acc8= constant 4
490 <acc8= constant 12
491 <acc8= constant 1
492 acc8+ constant 2
493 /acc8 unstack8
494 revAcc8Comp unstack8
495 brlt 499
496 acc8= constant 10
497 call writeAcc8
498 ;test5.p(71)   if (3 <= 4) write(9);
499 acc8= constant 3
500 acc8Comp constant 4
501 brgt 505
502 acc8= constant 9
503 call writeAcc8
504 ;test5.p(72)   if (3 <= (12/(1+2))) write(8);
505 acc8= constant 3
506 <acc8= constant 12
507 <acc8= constant 1
508 acc8+ constant 2
509 /acc8 unstack8
510 revAcc8Comp unstack8
511 brlt 515
512 acc8= constant 8
513 call writeAcc8
514 ;test5.p(73)   if (5 > 4) write(7);
515 acc8= constant 5
516 acc8Comp constant 4
517 brle 521
518 acc8= constant 7
519 call writeAcc8
520 ;test5.p(74)   if (5 > (12/(1+2))) write(6);
521 acc8= constant 5
522 <acc8= constant 12
523 <acc8= constant 1
524 acc8+ constant 2
525 /acc8 unstack8
526 revAcc8Comp unstack8
527 brge 531
528 acc8= constant 6
529 call writeAcc8
530 ;test5.p(75)   if (3 < 4) write(5);
531 acc8= constant 3
532 acc8Comp constant 4
533 brge 537
534 acc8= constant 5
535 call writeAcc8
536 ;test5.p(76)   if (3 < (12/(1+2))) write(4);
537 acc8= constant 3
538 <acc8= constant 12
539 <acc8= constant 1
540 acc8+ constant 2
541 /acc8 unstack8
542 revAcc8Comp unstack8
543 brle 547
544 acc8= constant 4
545 call writeAcc8
546 ;test5.p(77)   if (3 != 4) write(3);
547 acc8= constant 3
548 acc8Comp constant 4
549 breq 553
550 acc8= constant 3
551 call writeAcc8
552 ;test5.p(78)   if (3 != (12/(1+2))) write(2);
553 acc8= constant 3
554 <acc8= constant 12
555 <acc8= constant 1
556 acc8+ constant 2
557 /acc8 unstack8
558 revAcc8Comp unstack8
559 breq 563
560 acc8= constant 2
561 call writeAcc8
562 ;test5.p(79)   if (4 == 4) write(1);
563 acc8= constant 4
564 acc8Comp constant 4
565 brne 569
566 acc8= constant 1
567 call writeAcc8
568 ;test5.p(80)   if (4 == (12/(1+2))) write(0);
569 acc8= constant 4
570 <acc8= constant 12
571 <acc8= constant 1
572 acc8+ constant 2
573 /acc8 unstack8
574 revAcc8Comp unstack8
575 brne 579
576 acc8= constant 0
577 call writeAcc8
578 ;test5.p(81) }
579 stop
