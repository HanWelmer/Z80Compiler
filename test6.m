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
 10 ://  /*********************/
 11 ://  /* Single term 8-bit */
 12 ://  /*********************/
 13 ://  byte b = 1;
 14 :acc8= constant 0
 15 :call writeAcc8
 16 :acc8= constant 1
 17 :acc8=> variable 0
 18 ://  byte c = 4;
 19 :acc8= constant 4
 20 :acc8=> variable 1
 21 ://  write(b);         // 1
 22 ://  //LD    A,1
 23 ://  //LD    (04000H),A
 24 ://  //LD    A,(04000H)
 25 ://  //CALL  writeA
 26 ://  //OK
 27 ://
 28 ://  /************************/
 29 ://  /* Dual term addition   */
 30 ://  /************************/
 31 ://  write(0 + 2);     // 2
 32 :acc8= variable 0
 33 :call writeAcc8
 34 :acc8= constant 0
 35 :acc8+ constant 2
 36 ://  write(b + 2);     // 3
 37 :call writeAcc8
 38 :acc8= variable 0
 39 :acc8+ constant 2
 40 ://  write(3 + b);     // 4
 41 :call writeAcc8
 42 :acc8= constant 3
 43 :acc8+ variable 0
 44 ://  write(b + c);     // 5
 45 :call writeAcc8
 46 :acc8= variable 0
 47 :acc8+ variable 1
 48 ://
 49 ://  c = 4 + 2;
 50 :call writeAcc8
 51 :acc8= constant 4
 52 :acc8+ constant 2
 53 :acc8=> variable 1
 54 ://  write(c);         // 6
 55 ://  c = b + 6;
 56 :acc8= variable 1
 57 :call writeAcc8
 58 :acc8= variable 0
 59 :acc8+ constant 6
 60 :acc8=> variable 1
 61 ://  write(c);         // 7
 62 ://  c = 7 + b;
 63 :acc8= variable 1
 64 :call writeAcc8
 65 :acc8= constant 7
 66 :acc8+ variable 0
 67 :acc8=> variable 1
 68 ://  write(c);         // 8
 69 ://  c = b + c;
 70 :acc8= variable 1
 71 :call writeAcc8
 72 :acc8= variable 0
 73 :acc8+ variable 1
 74 :acc8=> variable 1
 75 ://  write(c);         // 9
 76 ://
 77 ://
 78 ://  int i = 10;
 79 :acc8= variable 1
 80 :call writeAcc8
 81 :acc8= constant 10
 82 :acc8ToAcc16
 83 :acc16=> variable 2
 84 ://  write(i);         // 10
 85 ://  //LD    A,10
 86 ://  //LD    L,A
 87 ://  //LD    H,0
 88 ://  //LD    (04004H),HL
 89 ://  //OK
 90 ://  
 91 ://  write(i + 1);     // 11
 92 :acc16= variable 2
 93 :call writeAcc16
 94 :acc16= variable 2
 95 :acc8= constant 1
 96 :acc16+ acc8
 97 ://  write(2 + i);     // 12
 98 :call writeAcc16
 99 :acc8= constant 2
100 :acc8ToAcc16
101 :acc16+ variable 2
102 ://  b = 3;
103 :call writeAcc16
104 :acc8= constant 3
105 :acc8=> variable 0
106 ://  write(i + b);     // 13
107 :acc16= variable 2
108 :acc8= variable 0
109 :acc16+ acc8
110 ://  b++; //4
111 :call writeAcc16
112 :incr8 variable 0
113 ://  write(b + i);     // 14
114 :acc8= variable 0
115 :acc8ToAcc16
116 :acc16+ variable 2
117 ://
118 ://  int j = i + 5;    // 15
119 :call writeAcc16
120 :acc16= variable 2
121 :acc8= constant 5
122 :acc16+ acc8
123 :acc16=> variable 4
124 ://  write(j);
125 ://  j = 6 + i;        // 16
126 :acc16= variable 4
127 :call writeAcc16
128 :acc8= constant 6
129 :acc8ToAcc16
130 :acc16+ variable 2
131 :acc16=> variable 4
132 ://  write(j);
133 ://  j = 7;
134 :acc16= variable 4
135 :call writeAcc16
136 :acc8= constant 7
137 :acc8ToAcc16
138 :acc16=> variable 4
139 ://  j = i + j;        // 17
140 :acc16= variable 2
141 :acc16+ variable 4
142 :acc16=> variable 4
143 ://  write(j);
144 ://
145 ://  /*************************/
146 ://  /* Dual term subtraction */
147 ://  /*************************/
148 ://  b = 33;
149 :acc16= variable 4
150 :call writeAcc16
151 :acc8= constant 33
152 :acc8=> variable 0
153 ://  c = 12;
154 :acc8= constant 12
155 :acc8=> variable 1
156 ://  write(19 - 1);    // 18
157 :acc8= constant 19
158 :acc8- constant 1
159 ://  write(b - 14);    // 19
160 :call writeAcc8
161 :acc8= variable 0
162 :acc8- constant 14
163 ://  write(53 - b);    // 20
164 :call writeAcc8
165 :acc8= constant 53
166 :acc8- variable 0
167 ://  write(b - c);     // 21
168 :call writeAcc8
169 :acc8= variable 0
170 :acc8- variable 1
171 ://
172 ://  c = 24 - 2;
173 :call writeAcc8
174 :acc8= constant 24
175 :acc8- constant 2
176 :acc8=> variable 1
177 ://  write(c);         // 22
178 ://  c = b - 10;
179 :acc8= variable 1
180 :call writeAcc8
181 :acc8= variable 0
182 :acc8- constant 10
183 :acc8=> variable 1
184 ://  write(c);         // 23
185 ://  c = 57 - b;
186 :acc8= variable 1
187 :call writeAcc8
188 :acc8= constant 57
189 :acc8- variable 0
190 :acc8=> variable 1
191 ://  write(c);         // 24
192 ://  c = 8;
193 :acc8= variable 1
194 :call writeAcc8
195 :acc8= constant 8
196 :acc8=> variable 1
197 ://  c = b - c;
198 :acc8= variable 0
199 :acc8- variable 1
200 :acc8=> variable 1
201 ://  write(c);         // 25
202 ://
203 ://  i = 40;
204 :acc8= variable 1
205 :call writeAcc8
206 :acc8= constant 40
207 :acc8ToAcc16
208 :acc16=> variable 2
209 ://  write(i - 14);    // 26
210 :acc16= variable 2
211 :acc8= constant 14
212 :acc16- acc8
213 ://  write(67 - i);    // 27
214 :call writeAcc16
215 :acc8= constant 67
216 :acc8ToAcc16
217 :acc16- variable 2
218 ://  b = 12;
219 :call writeAcc16
220 :acc8= constant 12
221 :acc8=> variable 0
222 ://  write(i - b);     // 28
223 :acc16= variable 2
224 :acc8= variable 0
225 :acc16- acc8
226 ://  b = 69;
227 :call writeAcc16
228 :acc8= constant 69
229 :acc8=> variable 0
230 ://  write(b - i);     // 29
231 :acc8= variable 0
232 :acc8ToAcc16
233 :acc16- variable 2
234 ://
235 ://  j = i - 10;
236 :call writeAcc16
237 :acc16= variable 2
238 :acc8= constant 10
239 :acc16- acc8
240 :acc16=> variable 4
241 ://  write(j);         // 30
242 ://  j = 71 - i;
243 :acc16= variable 4
244 :call writeAcc16
245 :acc8= constant 71
246 :acc8ToAcc16
247 :acc16- variable 2
248 :acc16=> variable 4
249 ://  write(j);         // 31
250 ://  j = 8;
251 :acc16= variable 4
252 :call writeAcc16
253 :acc8= constant 8
254 :acc8ToAcc16
255 :acc16=> variable 4
256 ://  j = i - j;
257 :acc16= variable 2
258 :acc16- variable 4
259 :acc16=> variable 4
260 ://  write(j);         // 32
261 ://  
262 ://  /****************************/
263 ://  /* Dual term multiplication */
264 ://  /****************************/
265 ://  write(3 * 11);    // 33
266 :acc16= variable 4
267 :call writeAcc16
268 :acc8= constant 3
269 :acc8* constant 11
270 ://  b = 17;
271 :call writeAcc8
272 :acc8= constant 17
273 :acc8=> variable 0
274 ://  write(b * 2);     // 34
275 :acc8= variable 0
276 :acc8* constant 2
277 ://  b = 7;
278 :call writeAcc8
279 :acc8= constant 7
280 :acc8=> variable 0
281 ://  write(5 * b);     // 35
282 :acc8= constant 5
283 :acc8* variable 0
284 ://  b = 2;
285 :call writeAcc8
286 :acc8= constant 2
287 :acc8=> variable 0
288 ://  c = 18;
289 :acc8= constant 18
290 :acc8=> variable 1
291 ://  write(b * c);     // 36
292 :acc8= variable 0
293 :acc8* variable 1
294 ://  
295 ://  c = 37 * 1;
296 :call writeAcc8
297 :acc8= constant 37
298 :acc8* constant 1
299 :acc8=> variable 1
300 ://  write(c);         // 37
301 ://  b = 2;
302 :acc8= variable 1
303 :call writeAcc8
304 :acc8= constant 2
305 :acc8=> variable 0
306 ://  c = b * 19;
307 :acc8= variable 0
308 :acc8* constant 19
309 :acc8=> variable 1
310 ://  write(c);         // 38
311 ://  b = 3;
312 :acc8= variable 1
313 :call writeAcc8
314 :acc8= constant 3
315 :acc8=> variable 0
316 ://  c = 13 * b;
317 :acc8= constant 13
318 :acc8* variable 0
319 :acc8=> variable 1
320 ://  write(c);         // 39
321 ://  b = 5;
322 :acc8= variable 1
323 :call writeAcc8
324 :acc8= constant 5
325 :acc8=> variable 0
326 ://  c = 8;
327 :acc8= constant 8
328 :acc8=> variable 1
329 ://  c = b * c;
330 :acc8= variable 0
331 :acc8* variable 1
332 :acc8=> variable 1
333 ://  write(c);         // 40
334 ://
335 ://  /**********************/
336 ://  /* Dual term division */
337 ://  /**********************/
338 ://  write(123 / 3);   // 41
339 :acc8= variable 1
340 :call writeAcc8
341 :acc8= constant 123
342 :acc8/ constant 3
343 ://  b = 126;
344 :call writeAcc8
345 :acc8= constant 126
346 :acc8=> variable 0
347 ://  write(b / 3);     // 42
348 :acc8= variable 0
349 :acc8/ constant 3
350 ://  b = 3;
351 :call writeAcc8
352 :acc8= constant 3
353 :acc8=> variable 0
354 ://  write(129 / b);   // 43
355 :acc8= constant 129
356 :acc8/ variable 0
357 ://  b = 132;
358 :call writeAcc8
359 :acc8= constant 132
360 :acc8=> variable 0
361 ://  c = 3;
362 :acc8= constant 3
363 :acc8=> variable 1
364 ://  write(b / c);     // 44
365 :acc8= variable 0
366 :acc8/ variable 1
367 ://  
368 ://  c = 135 / 3;
369 :call writeAcc8
370 :acc8= constant 135
371 :acc8/ constant 3
372 :acc8=> variable 1
373 ://  write(c);         // 45
374 ://  b = 138;
375 :acc8= variable 1
376 :call writeAcc8
377 :acc8= constant 138
378 :acc8=> variable 0
379 ://  c = b / 3;
380 :acc8= variable 0
381 :acc8/ constant 3
382 :acc8=> variable 1
383 ://  write(c);         // 46
384 ://  b = 3;
385 :acc8= variable 1
386 :call writeAcc8
387 :acc8= constant 3
388 :acc8=> variable 0
389 ://  c = 141 / b;
390 :acc8= constant 141
391 :acc8/ variable 0
392 :acc8=> variable 1
393 ://  write(c);         // 47
394 ://  b = 144;
395 :acc8= variable 1
396 :call writeAcc8
397 :acc8= constant 144
398 :acc8=> variable 0
399 ://  c = 3;
400 :acc8= constant 3
401 :acc8=> variable 1
402 ://  c = b / c;
403 :acc8= variable 0
404 :acc8/ variable 1
405 :acc8=> variable 1
406 ://  write(c);         // 48
407 ://
408 ://  /**********************/
409 ://  /* Single term read   */
410 ://  /**********************/
411 ://  write(read);      // 49
412 :acc8= variable 1
413 :call writeAcc8
414 :call read
415 ://  b = read;
416 :call writeAcc16
417 :call read
418 :acc16ToAcc8
419 :acc8=> variable 0
420 ://  write(b);         // 50
421 ://
422 ://  /**********************/
423 ://  /* Dual term read     */
424 ://  /**********************/
425 ://  write(read + 1);  // 50 + 1 = 51
426 :acc8= variable 0
427 :call writeAcc8
428 :call read
429 :acc8= constant 1
430 :acc16+ acc8
431 ://  write(2 + read);  // 2 + 50 = 52
432 :call writeAcc16
433 :acc8= constant 2
434 :call read
435 :<acc8ToAcc16
436 :acc16+ unstack
437 ://  write(read - 2);  // 55 - 2 = 53
438 :call writeAcc16
439 :call read
440 :acc8= constant 2
441 :acc16- acc8
442 ://  write(109 - read);  // 109 - 55 = 54
443 :call writeAcc16
444 :acc8= constant 109
445 :call read
446 :<acc8ToAcc16
447 :acc16- unstack
448 ://  write(read * 1);  // 55 * 1 = 55
449 :call writeAcc16
450 :call read
451 :acc8= constant 1
452 :acc16* acc8
453 ://  write(2 * read);  // 2 * 55 = 110
454 :call writeAcc16
455 :acc8= constant 2
456 :call read
457 :<acc8ToAcc16
458 :acc16* unstack
459 ://  write(read / 2);  // 110 / 2 = 55
460 :call writeAcc16
461 :call read
462 :acc8= constant 2
463 :acc16/ acc8
464 ://  write(12 / read);  // 12 / 3 = 4
465 :call writeAcc16
466 :acc8= constant 12
467 :call read
468 :<acc8ToAcc16
469 :acc16/ unstack
470 ://
471 ://  /*************************/
472 ://  /* possible loss of data */
473 ://  /*************************/
474 ://  b = 507;
475 :call writeAcc16
476 :acc16= constant 507
477 :acc16ToAcc8
478 :acc8=> variable 0
479 ://  write(b);         // 251
480 ://  i = 508;
481 :acc8= variable 0
482 :call writeAcc8
483 :acc16= constant 508
484 :acc16=> variable 2
485 ://  b = i;
486 :acc16= variable 2
487 :acc16ToAcc8
488 :acc8=> variable 0
489 ://  write(b);         // 252
490 ://
491 ://  b = b - 505;
492 :acc8= variable 0
493 :call writeAcc8
494 :acc8= variable 0
495 :acc8ToAcc16
496 :acc16- constant 505
497 :acc16ToAcc8
498 :acc8=> variable 0
499 ://  write(b);         // 252 - 505 = -253
500 ://  i = i + 5;
501 :acc8= variable 0
502 :call writeAcc8
503 :acc16= variable 2
504 :acc8= constant 5
505 :acc16+ acc8
506 :acc16=> variable 2
507 ://  b = b - i;
508 :acc8= variable 0
509 :acc8ToAcc16
510 :acc16- variable 2
511 :acc16ToAcc8
512 :acc8=> variable 0
513 ://  write(b);         // -233 - 11 = -254
514 ://  
515 ://  b = 255;
516 :acc8= variable 0
517 :call writeAcc8
518 :acc8= constant 255
519 :acc8=> variable 0
520 ://  write(b);         // 255
521 ://  //LD    A,255
522 ://  //LD    (04001H),A
523 ://  //LD    A,(04001H)
524 ://  //CALL  writeA
525 ://  //OK
526 ://
527 ://  /**********************/
528 ://  /* Single term 16-bit */
529 ://  /**********************/
530 ://  i = 256;
531 :acc8= variable 0
532 :call writeAcc8
533 :acc16= constant 256
534 :acc16=> variable 2
535 ://  write(i);         // 256
536 ://  //LD    HL,256
537 ://  //LD    (04006H),HL
538 ://  //LD    HL,(04006H)
539 ://  //CALL  writeHL
540 ://  //OK
541 ://
542 ://  write(1000);      // 1000
543 :acc16= variable 2
544 :call writeAcc16
545 ://  j = 1001;
546 :acc16= constant 1000
547 :call writeAcc16
548 :acc16= constant 1001
549 :acc16=> variable 4
550 ://  write(j);         // 1001
551 ://
552 ://  /************************/
553 ://  /* Dual term addition   */
554 ://  /************************/
555 ://  write(1000 + 2);  // 1002
556 :acc16= variable 4
557 :call writeAcc16
558 :acc16= constant 1000
559 :acc8= constant 2
560 :acc16+ acc8
561 ://  write(3 + 1000);  // 1003
562 :call writeAcc16
563 :acc8= constant 3
564 :acc8ToAcc16
565 :acc16+ constant 1000
566 ://  write(500 + 504); // 1004
567 :call writeAcc16
568 :acc16= constant 500
569 :acc16+ constant 504
570 ://  i = 1000 + 5;
571 :call writeAcc16
572 :acc16= constant 1000
573 :acc8= constant 5
574 :acc16+ acc8
575 :acc16=> variable 2
576 ://  write(i);         // 1005
577 ://  i = 6 + 1000;
578 :acc16= variable 2
579 :call writeAcc16
580 :acc8= constant 6
581 :acc8ToAcc16
582 :acc16+ constant 1000
583 :acc16=> variable 2
584 ://  write(i);         // 1006
585 ://  i = 500 + 507;
586 :acc16= variable 2
587 :call writeAcc16
588 :acc16= constant 500
589 :acc16+ constant 507
590 :acc16=> variable 2
591 ://  write(i);         // 1007
592 ://  
593 ://  j = 1000;
594 :acc16= variable 2
595 :call writeAcc16
596 :acc16= constant 1000
597 :acc16=> variable 4
598 ://  b = 10;
599 :acc8= constant 10
600 :acc8=> variable 0
601 ://  i = 514;
602 :acc16= constant 514
603 :acc16=> variable 2
604 ://  write(j + 8);     // 1008
605 :acc16= variable 4
606 :acc8= constant 8
607 :acc16+ acc8
608 ://  write(9 + j);     // 1009
609 :call writeAcc16
610 :acc8= constant 9
611 :acc8ToAcc16
612 :acc16+ variable 4
613 ://  write(j + b);     // 1010
614 :call writeAcc16
615 :acc16= variable 4
616 :acc8= variable 0
617 :acc16+ acc8
618 ://  b++;
619 :call writeAcc16
620 :incr8 variable 0
621 ://  write(b + j);     // 1011
622 :acc8= variable 0
623 :acc8ToAcc16
624 :acc16+ variable 4
625 ://  j = 500;
626 :call writeAcc16
627 :acc16= constant 500
628 :acc16=> variable 4
629 ://  write(j + 512);   // 1012
630 :acc16= variable 4
631 :acc16+ constant 512
632 ://  write(513 + j);   // 1013
633 :call writeAcc16
634 :acc16= constant 513
635 :acc16+ variable 4
636 ://  write(i + j);     // 1014
637 :call writeAcc16
638 :acc16= variable 2
639 :acc16+ variable 4
640 ://  
641 ://  j = 1000;
642 :call writeAcc16
643 :acc16= constant 1000
644 :acc16=> variable 4
645 ://  b = 17;
646 :acc8= constant 17
647 :acc8=> variable 0
648 ://  i = j + 15;
649 :acc16= variable 4
650 :acc8= constant 15
651 :acc16+ acc8
652 :acc16=> variable 2
653 ://  write(i);         // 1015
654 ://  i = 16 + j;
655 :acc16= variable 2
656 :call writeAcc16
657 :acc8= constant 16
658 :acc8ToAcc16
659 :acc16+ variable 4
660 :acc16=> variable 2
661 ://  write(i);         // 1016
662 ://  i = j + b;
663 :acc16= variable 2
664 :call writeAcc16
665 :acc16= variable 4
666 :acc8= variable 0
667 :acc16+ acc8
668 :acc16=> variable 2
669 ://  write(i);         // 1017
670 ://  b++;
671 :acc16= variable 2
672 :call writeAcc16
673 :incr8 variable 0
674 ://  i = b + j;
675 :acc8= variable 0
676 :acc8ToAcc16
677 :acc16+ variable 4
678 :acc16=> variable 2
679 ://  write(i);         // 1018
680 ://  j = 500;
681 :acc16= variable 2
682 :call writeAcc16
683 :acc16= constant 500
684 :acc16=> variable 4
685 ://  i = j + 519;
686 :acc16= variable 4
687 :acc16+ constant 519
688 :acc16=> variable 2
689 ://  write(i);         // 1019
690 ://  i = 520 + j;
691 :acc16= variable 2
692 :call writeAcc16
693 :acc16= constant 520
694 :acc16+ variable 4
695 :acc16=> variable 2
696 ://  write(i);         // 1020
697 ://  i = 521;
698 :acc16= variable 2
699 :call writeAcc16
700 :acc16= constant 521
701 :acc16=> variable 2
702 ://  i = i + j;
703 :acc16= variable 2
704 :acc16+ variable 4
705 :acc16=> variable 2
706 ://  write(i);         // 1021
707 ://  
708 ://  /*************************/
709 ://  /* Dual term subtraction */
710 ://  /*************************/
711 ://  write(1024 - 2);  // 1022
712 :acc16= variable 2
713 :call writeAcc16
714 :acc16= constant 1024
715 :acc8= constant 2
716 :acc16- acc8
717 ://  write(1523 - 500);// 1023
718 :call writeAcc16
719 :acc16= constant 1523
720 :acc16- constant 500
721 ://  i = 1030 - 6;
722 :call writeAcc16
723 :acc16= constant 1030
724 :acc8= constant 6
725 :acc16- acc8
726 :acc16=> variable 2
727 ://  write(i);         // 1024
728 ://  i = 1525 - 500;
729 :acc16= variable 2
730 :call writeAcc16
731 :acc16= constant 1525
732 :acc16- constant 500
733 :acc16=> variable 2
734 ://  write(i);         // 1025
735 ://  
736 ://  j = 1040;
737 :acc16= variable 2
738 :call writeAcc16
739 :acc16= constant 1040
740 :acc16=> variable 4
741 ://  b = 13;
742 :acc8= constant 13
743 :acc8=> variable 0
744 ://  i = 3030;
745 :acc16= constant 3030
746 :acc16=> variable 2
747 ://  write(j - 14);    // 1026
748 :acc16= variable 4
749 :acc8= constant 14
750 :acc16- acc8
751 ://  write(j - b);     // 1027
752 :call writeAcc16
753 :acc16= variable 4
754 :acc8= variable 0
755 :acc16- acc8
756 ://  j = 2000;
757 :call writeAcc16
758 :acc16= constant 2000
759 :acc16=> variable 4
760 ://  write(j - 972);   // 1028
761 :acc16= variable 4
762 :acc16- constant 972
763 ://  write(3029 - j);  // 1029
764 :call writeAcc16
765 :acc16= constant 3029
766 :acc16- variable 4
767 ://  write(i - j);     // 1030
768 :call writeAcc16
769 :acc16= variable 2
770 :acc16- variable 4
771 ://  
772 ://  j = 1050;
773 :call writeAcc16
774 :acc16= constant 1050
775 :acc16=> variable 4
776 ://  b = 18;
777 :acc8= constant 18
778 :acc8=> variable 0
779 ://  i = j - 19;
780 :acc16= variable 4
781 :acc8= constant 19
782 :acc16- acc8
783 :acc16=> variable 2
784 ://  write(i);         // 1031
785 ://  i = j - b;
786 :acc16= variable 2
787 :call writeAcc16
788 :acc16= variable 4
789 :acc8= variable 0
790 :acc16- acc8
791 :acc16=> variable 2
792 ://  write(i);         // 1032
793 ://  j = 2000;
794 :acc16= variable 2
795 :call writeAcc16
796 :acc16= constant 2000
797 :acc16=> variable 4
798 ://  i = j - 967;
799 :acc16= variable 4
800 :acc16- constant 967
801 :acc16=> variable 2
802 ://  write(i);         // 1033
803 ://  i = 3034 - j;
804 :acc16= variable 2
805 :call writeAcc16
806 :acc16= constant 3034
807 :acc16- variable 4
808 :acc16=> variable 2
809 ://  write(i);         // 1034
810 ://  i = 3035;
811 :acc16= variable 2
812 :call writeAcc16
813 :acc16= constant 3035
814 :acc16=> variable 2
815 ://  i = i - j;
816 :acc16= variable 2
817 :acc16- variable 4
818 :acc16=> variable 2
819 ://  write(i);         // 1035
820 ://  
821 ://  /****************************/
822 ://  /* Dual term multiplication */
823 ://  /****************************/
824 ://  write(518 * 2);   // 1036
825 :acc16= variable 2
826 :call writeAcc16
827 :acc16= constant 518
828 :acc8= constant 2
829 :acc16* acc8
830 ://  write(1 * 1037);  // 1037
831 :call writeAcc16
832 :acc8= constant 1
833 :acc8ToAcc16
834 :acc16* constant 1037
835 ://  write(500 * 504 - 54354); // 1038 = 55392 - 54354
836 :call writeAcc16
837 :acc16= constant 500
838 :acc16* constant 504
839 :acc16- constant 54354
840 ://
841 ://  i = 1039 * 1;
842 :call writeAcc16
843 :acc16= constant 1039
844 :acc8= constant 1
845 :acc16* acc8
846 :acc16=> variable 2
847 ://  write(i);         // 1039
848 ://  i = 2 * 520;
849 :acc16= variable 2
850 :call writeAcc16
851 :acc8= constant 2
852 :acc8ToAcc16
853 :acc16* constant 520
854 :acc16=> variable 2
855 ://  write(i);         // 1040
856 ://
857 ://  i = 1041;
858 :acc16= variable 2
859 :call writeAcc16
860 :acc16= constant 1041
861 :acc16=> variable 2
862 ://  write(i * 1);     // 1041
863 :acc16= variable 2
864 :acc8= constant 1
865 :acc16* acc8
866 ://  i = 521;
867 :call writeAcc16
868 :acc16= constant 521
869 :acc16=> variable 2
870 ://  write(2 * i);     // 1042
871 :acc8= constant 2
872 :acc8ToAcc16
873 :acc16* variable 2
874 ://
875 ://  i = 1043;
876 :call writeAcc16
877 :acc16= constant 1043
878 :acc16=> variable 2
879 ://  i = i * 1;
880 :acc16= variable 2
881 :acc8= constant 1
882 :acc16* acc8
883 :acc16=> variable 2
884 ://  write(i);         // 1043
885 ://  i = 522;
886 :acc16= variable 2
887 :call writeAcc16
888 :acc16= constant 522
889 :acc16=> variable 2
890 ://  i = 2 * i;
891 :acc8= constant 2
892 :acc8ToAcc16
893 :acc16* variable 2
894 :acc16=> variable 2
895 ://  write(i);         // 1044
896 ://
897 ://  i = 500 * 504 - 54347; // 1045 = 55392 - 54347
898 :acc16= variable 2
899 :call writeAcc16
900 :acc16= constant 500
901 :acc16* constant 504
902 :acc16- constant 54347
903 :acc16=> variable 2
904 ://  write(i);         // 1045
905 ://  i = 500;
906 :acc16= variable 2
907 :call writeAcc16
908 :acc16= constant 500
909 :acc16=> variable 2
910 ://  i = i * 504 - 54346;
911 :acc16= variable 2
912 :acc16* constant 504
913 :acc16- constant 54346
914 :acc16=> variable 2
915 ://  write(i);         // 1046
916 ://  i = 504;
917 :acc16= variable 2
918 :call writeAcc16
919 :acc16= constant 504
920 :acc16=> variable 2
921 ://  i = 500 * i - 54345;
922 :acc16= constant 500
923 :acc16* variable 2
924 :acc16- constant 54345
925 :acc16=> variable 2
926 ://  write(i);         // 1047
927 ://  /************/
928 ://  /* Overflow */
929 ://  /************/
930 ://  write(300 * 301); // 90.300 % 65536 = 24.764
931 :acc16= variable 2
932 :call writeAcc16
933 :acc16= constant 300
934 :acc16* constant 301
935 ://  i = 300 * 302;
936 :call writeAcc16
937 :acc16= constant 300
938 :acc16* constant 302
939 :acc16=> variable 2
940 ://  write(i);         // 90.600 % 65536 = 25.064
941 ://
942 ://}
943 :acc16= variable 2
944 :call writeAcc16
945 :stop
