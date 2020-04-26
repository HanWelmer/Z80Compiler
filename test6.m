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
 95 :acc16+ constant 1
 96 ://  write(2 + i);     // 12
 97 :call writeAcc16
 98 :acc8= constant 2
 99 :acc8ToAcc16
100 :acc16+ variable 2
101 ://  b = 3;
102 :call writeAcc16
103 :acc8= constant 3
104 :acc8=> variable 0
105 ://  write(i + b);     // 13
106 :acc16= variable 2
107 :acc16+ variable 0
108 ://  b++; //4
109 :call writeAcc16
110 :incr8 variable 0
111 ://  write(b + i);     // 14
112 :acc8= variable 0
113 :acc8ToAcc16
114 :acc16+ variable 2
115 ://
116 ://  int j = i + 5;    // 15
117 :call writeAcc16
118 :acc16= variable 2
119 :acc16+ constant 5
120 :acc16=> variable 4
121 ://  write(j);
122 ://  j = 6 + i;        // 16
123 :acc16= variable 4
124 :call writeAcc16
125 :acc8= constant 6
126 :acc8ToAcc16
127 :acc16+ variable 2
128 :acc16=> variable 4
129 ://  write(j);
130 ://  j = 7;
131 :acc16= variable 4
132 :call writeAcc16
133 :acc8= constant 7
134 :acc8ToAcc16
135 :acc16=> variable 4
136 ://  j = i + j;        // 17
137 :acc16= variable 2
138 :acc16+ variable 4
139 :acc16=> variable 4
140 ://  write(j);
141 ://
142 ://  /*************************/
143 ://  /* Dual term subtraction */
144 ://  /*************************/
145 ://  b = 33;
146 :acc16= variable 4
147 :call writeAcc16
148 :acc8= constant 33
149 :acc8=> variable 0
150 ://  c = 12;
151 :acc8= constant 12
152 :acc8=> variable 1
153 ://  write(19 - 1);    // 18
154 :acc8= constant 19
155 :acc8- constant 1
156 ://  write(b - 14);    // 19
157 :call writeAcc8
158 :acc8= variable 0
159 :acc8- constant 14
160 ://  write(53 - b);    // 20
161 :call writeAcc8
162 :acc8= constant 53
163 :acc8- variable 0
164 ://  write(b - c);     // 21
165 :call writeAcc8
166 :acc8= variable 0
167 :acc8- variable 1
168 ://
169 ://  c = 24 - 2;
170 :call writeAcc8
171 :acc8= constant 24
172 :acc8- constant 2
173 :acc8=> variable 1
174 ://  write(c);         // 22
175 ://  c = b - 10;
176 :acc8= variable 1
177 :call writeAcc8
178 :acc8= variable 0
179 :acc8- constant 10
180 :acc8=> variable 1
181 ://  write(c);         // 23
182 ://  c = 57 - b;
183 :acc8= variable 1
184 :call writeAcc8
185 :acc8= constant 57
186 :acc8- variable 0
187 :acc8=> variable 1
188 ://  write(c);         // 24
189 ://  c = 8;
190 :acc8= variable 1
191 :call writeAcc8
192 :acc8= constant 8
193 :acc8=> variable 1
194 ://  c = b - c;
195 :acc8= variable 0
196 :acc8- variable 1
197 :acc8=> variable 1
198 ://  write(c);         // 25
199 ://
200 ://  i = 40;
201 :acc8= variable 1
202 :call writeAcc8
203 :acc8= constant 40
204 :acc8ToAcc16
205 :acc16=> variable 2
206 ://  write(i - 14);    // 26
207 :acc16= variable 2
208 :acc16- constant 14
209 ://  write(67 - i);    // 27
210 :call writeAcc16
211 :acc8= constant 67
212 :acc8ToAcc16
213 :acc16- variable 2
214 ://  b = 12;
215 :call writeAcc16
216 :acc8= constant 12
217 :acc8=> variable 0
218 ://  write(i - b);     // 28
219 :acc16= variable 2
220 :acc16- variable 0
221 ://  b = 69;
222 :call writeAcc16
223 :acc8= constant 69
224 :acc8=> variable 0
225 ://  write(b - i);     // 29
226 :acc8= variable 0
227 :acc8ToAcc16
228 :acc16- variable 2
229 ://
230 ://  j = i - 10;
231 :call writeAcc16
232 :acc16= variable 2
233 :acc16- constant 10
234 :acc16=> variable 4
235 ://  write(j);         // 30
236 ://  j = 71 - i;
237 :acc16= variable 4
238 :call writeAcc16
239 :acc8= constant 71
240 :acc8ToAcc16
241 :acc16- variable 2
242 :acc16=> variable 4
243 ://  write(j);         // 31
244 ://  j = 8;
245 :acc16= variable 4
246 :call writeAcc16
247 :acc8= constant 8
248 :acc8ToAcc16
249 :acc16=> variable 4
250 ://  j = i - j;
251 :acc16= variable 2
252 :acc16- variable 4
253 :acc16=> variable 4
254 ://  write(j);         // 32
255 ://  
256 ://  /****************************/
257 ://  /* Dual term multiplication */
258 ://  /****************************/
259 ://  write(3 * 11);    // 33
260 :acc16= variable 4
261 :call writeAcc16
262 :acc8= constant 3
263 :acc8* constant 11
264 ://  b = 17;
265 :call writeAcc8
266 :acc8= constant 17
267 :acc8=> variable 0
268 ://  write(b * 2);     // 34
269 :acc8= variable 0
270 :acc8* constant 2
271 ://  b = 7;
272 :call writeAcc8
273 :acc8= constant 7
274 :acc8=> variable 0
275 ://  write(5 * b);     // 35
276 :acc8= constant 5
277 :acc8* variable 0
278 ://  b = 2;
279 :call writeAcc8
280 :acc8= constant 2
281 :acc8=> variable 0
282 ://  c = 18;
283 :acc8= constant 18
284 :acc8=> variable 1
285 ://  write(b * c);     // 36
286 :acc8= variable 0
287 :acc8* variable 1
288 ://  
289 ://  c = 37 * 1;
290 :call writeAcc8
291 :acc8= constant 37
292 :acc8* constant 1
293 :acc8=> variable 1
294 ://  write(c);         // 37
295 ://  b = 2;
296 :acc8= variable 1
297 :call writeAcc8
298 :acc8= constant 2
299 :acc8=> variable 0
300 ://  c = b * 19;
301 :acc8= variable 0
302 :acc8* constant 19
303 :acc8=> variable 1
304 ://  write(c);         // 38
305 ://  b = 3;
306 :acc8= variable 1
307 :call writeAcc8
308 :acc8= constant 3
309 :acc8=> variable 0
310 ://  c = 13 * b;
311 :acc8= constant 13
312 :acc8* variable 0
313 :acc8=> variable 1
314 ://  write(c);         // 39
315 ://  b = 5;
316 :acc8= variable 1
317 :call writeAcc8
318 :acc8= constant 5
319 :acc8=> variable 0
320 ://  c = 8;
321 :acc8= constant 8
322 :acc8=> variable 1
323 ://  c = b * c;
324 :acc8= variable 0
325 :acc8* variable 1
326 :acc8=> variable 1
327 ://  write(c);         // 40
328 ://
329 ://  /**********************/
330 ://  /* Dual term division */
331 ://  /**********************/
332 ://  write(123 / 3);   // 41
333 :acc8= variable 1
334 :call writeAcc8
335 :acc8= constant 123
336 :acc8/ constant 3
337 ://  b = 126;
338 :call writeAcc8
339 :acc8= constant 126
340 :acc8=> variable 0
341 ://  write(b / 3);     // 42
342 :acc8= variable 0
343 :acc8/ constant 3
344 ://  b = 3;
345 :call writeAcc8
346 :acc8= constant 3
347 :acc8=> variable 0
348 ://  write(129 / b);   // 43
349 :acc8= constant 129
350 :acc8/ variable 0
351 ://  b = 132;
352 :call writeAcc8
353 :acc8= constant 132
354 :acc8=> variable 0
355 ://  c = 3;
356 :acc8= constant 3
357 :acc8=> variable 1
358 ://  write(b / c);     // 44
359 :acc8= variable 0
360 :acc8/ variable 1
361 ://  
362 ://  c = 135 / 3;
363 :call writeAcc8
364 :acc8= constant 135
365 :acc8/ constant 3
366 :acc8=> variable 1
367 ://  write(c);         // 45
368 ://  b = 138;
369 :acc8= variable 1
370 :call writeAcc8
371 :acc8= constant 138
372 :acc8=> variable 0
373 ://  c = b / 3;
374 :acc8= variable 0
375 :acc8/ constant 3
376 :acc8=> variable 1
377 ://  write(c);         // 46
378 ://  b = 3;
379 :acc8= variable 1
380 :call writeAcc8
381 :acc8= constant 3
382 :acc8=> variable 0
383 ://  c = 141 / b;
384 :acc8= constant 141
385 :acc8/ variable 0
386 :acc8=> variable 1
387 ://  write(c);         // 47
388 ://  b = 144;
389 :acc8= variable 1
390 :call writeAcc8
391 :acc8= constant 144
392 :acc8=> variable 0
393 ://  c = 3;
394 :acc8= constant 3
395 :acc8=> variable 1
396 ://  c = b / c;
397 :acc8= variable 0
398 :acc8/ variable 1
399 :acc8=> variable 1
400 ://  write(c);         // 48
401 ://
402 ://  /*************************/
403 ://  /* possible loss of data */
404 ://  /*************************/
405 ://  b = 507;
406 :acc8= variable 1
407 :call writeAcc8
408 :acc16= constant 507
409 :acc16ToAcc8
410 :acc8=> variable 0
411 ://  write(b);         // 251
412 ://  i = 508;
413 :acc8= variable 0
414 :call writeAcc8
415 :acc16= constant 508
416 :acc16=> variable 2
417 ://  b = i;
418 :acc16= variable 2
419 :acc16ToAcc8
420 :acc8=> variable 0
421 ://  write(b);         // 252
422 ://
423 ://  b = b - 505;
424 :acc8= variable 0
425 :call writeAcc8
426 :acc8= variable 0
427 :acc8ToAcc16
428 :acc16- constant 505
429 :acc16ToAcc8
430 :acc8=> variable 0
431 ://  write(b);         // 252 - 505 = -253
432 ://  i = i + 5;
433 :acc8= variable 0
434 :call writeAcc8
435 :acc16= variable 2
436 :acc16+ constant 5
437 :acc16=> variable 2
438 ://  b = b - i;
439 :acc8= variable 0
440 :acc8ToAcc16
441 :acc16- variable 2
442 :acc16ToAcc8
443 :acc8=> variable 0
444 ://  write(b);         // -233 - 11 = -254
445 ://  
446 ://  b = 255;
447 :acc8= variable 0
448 :call writeAcc8
449 :acc8= constant 255
450 :acc8=> variable 0
451 ://  write(b);         // 255
452 ://  //LD    A,255
453 ://  //LD    (04001H),A
454 ://  //LD    A,(04001H)
455 ://  //CALL  writeA
456 ://  //OK
457 ://
458 ://  /**********************/
459 ://  /* Single term 16-bit */
460 ://  /**********************/
461 ://  i = 256;
462 :acc8= variable 0
463 :call writeAcc8
464 :acc16= constant 256
465 :acc16=> variable 2
466 ://  write(i);         // 256
467 ://  //LD    HL,256
468 ://  //LD    (04006H),HL
469 ://  //LD    HL,(04006H)
470 ://  //CALL  writeHL
471 ://  //OK
472 ://
473 ://  write(1000);      // 1000
474 :acc16= variable 2
475 :call writeAcc16
476 ://  j = 1001;
477 :acc16= constant 1000
478 :call writeAcc16
479 :acc16= constant 1001
480 :acc16=> variable 4
481 ://  write(j);         // 1001
482 ://
483 ://  /************************/
484 ://  /* Dual term addition   */
485 ://  /************************/
486 ://  write(1000 + 2);  // 1002
487 :acc16= variable 4
488 :call writeAcc16
489 :acc16= constant 1000
490 :acc16+ constant 2
491 ://  write(3 + 1000);  // 1003
492 :call writeAcc16
493 :acc8= constant 3
494 :acc8ToAcc16
495 :acc16+ constant 1000
496 ://  write(500 + 504); // 1004
497 :call writeAcc16
498 :acc16= constant 500
499 :acc16+ constant 504
500 ://  i = 1000 + 5;
501 :call writeAcc16
502 :acc16= constant 1000
503 :acc16+ constant 5
504 :acc16=> variable 2
505 ://  write(i);         // 1005
506 ://  i = 6 + 1000;
507 :acc16= variable 2
508 :call writeAcc16
509 :acc8= constant 6
510 :acc8ToAcc16
511 :acc16+ constant 1000
512 :acc16=> variable 2
513 ://  write(i);         // 1006
514 ://  i = 500 + 507;
515 :acc16= variable 2
516 :call writeAcc16
517 :acc16= constant 500
518 :acc16+ constant 507
519 :acc16=> variable 2
520 ://  write(i);         // 1007
521 ://  
522 ://  j = 1000;
523 :acc16= variable 2
524 :call writeAcc16
525 :acc16= constant 1000
526 :acc16=> variable 4
527 ://  b = 10;
528 :acc8= constant 10
529 :acc8=> variable 0
530 ://  i = 514;
531 :acc16= constant 514
532 :acc16=> variable 2
533 ://  write(j + 8);     // 1008
534 :acc16= variable 4
535 :acc16+ constant 8
536 ://  write(9 + j);     // 1009
537 :call writeAcc16
538 :acc8= constant 9
539 :acc8ToAcc16
540 :acc16+ variable 4
541 ://  write(j + b);     // 1010
542 :call writeAcc16
543 :acc16= variable 4
544 :acc16+ variable 0
545 ://  b++;
546 :call writeAcc16
547 :incr8 variable 0
548 ://  write(b + j);     // 1011
549 :acc8= variable 0
550 :acc8ToAcc16
551 :acc16+ variable 4
552 ://  j = 500;
553 :call writeAcc16
554 :acc16= constant 500
555 :acc16=> variable 4
556 ://  write(j + 512);   // 1012
557 :acc16= variable 4
558 :acc16+ constant 512
559 ://  write(513 + j);   // 1013
560 :call writeAcc16
561 :acc16= constant 513
562 :acc16+ variable 4
563 ://  write(i + j);     // 1014
564 :call writeAcc16
565 :acc16= variable 2
566 :acc16+ variable 4
567 ://  
568 ://  j = 1000;
569 :call writeAcc16
570 :acc16= constant 1000
571 :acc16=> variable 4
572 ://  b = 17;
573 :acc8= constant 17
574 :acc8=> variable 0
575 ://  i = j + 15;
576 :acc16= variable 4
577 :acc16+ constant 15
578 :acc16=> variable 2
579 ://  write(i);         // 1015
580 ://  i = 16 + j;
581 :acc16= variable 2
582 :call writeAcc16
583 :acc8= constant 16
584 :acc8ToAcc16
585 :acc16+ variable 4
586 :acc16=> variable 2
587 ://  write(i);         // 1016
588 ://  i = j + b;
589 :acc16= variable 2
590 :call writeAcc16
591 :acc16= variable 4
592 :acc16+ variable 0
593 :acc16=> variable 2
594 ://  write(i);         // 1017
595 ://  b++;
596 :acc16= variable 2
597 :call writeAcc16
598 :incr8 variable 0
599 ://  i = b + j;
600 :acc8= variable 0
601 :acc8ToAcc16
602 :acc16+ variable 4
603 :acc16=> variable 2
604 ://  write(i);         // 1018
605 ://  j = 500;
606 :acc16= variable 2
607 :call writeAcc16
608 :acc16= constant 500
609 :acc16=> variable 4
610 ://  i = j + 519;
611 :acc16= variable 4
612 :acc16+ constant 519
613 :acc16=> variable 2
614 ://  write(i);         // 1019
615 ://  i = 520 + j;
616 :acc16= variable 2
617 :call writeAcc16
618 :acc16= constant 520
619 :acc16+ variable 4
620 :acc16=> variable 2
621 ://  write(i);         // 1020
622 ://  i = 521;
623 :acc16= variable 2
624 :call writeAcc16
625 :acc16= constant 521
626 :acc16=> variable 2
627 ://  i = i + j;
628 :acc16= variable 2
629 :acc16+ variable 4
630 :acc16=> variable 2
631 ://  write(i);         // 1021
632 ://  
633 ://  /*************************/
634 ://  /* Dual term subtraction */
635 ://  /*************************/
636 ://  write(1024 - 2);  // 1022
637 :acc16= variable 2
638 :call writeAcc16
639 :acc16= constant 1024
640 :acc16- constant 2
641 ://  write(1523 - 500);// 1023
642 :call writeAcc16
643 :acc16= constant 1523
644 :acc16- constant 500
645 ://  i = 1030 - 6;
646 :call writeAcc16
647 :acc16= constant 1030
648 :acc16- constant 6
649 :acc16=> variable 2
650 ://  write(i);         // 1024
651 ://  i = 1525 - 500;
652 :acc16= variable 2
653 :call writeAcc16
654 :acc16= constant 1525
655 :acc16- constant 500
656 :acc16=> variable 2
657 ://  write(i);         // 1025
658 ://  
659 ://  j = 1040;
660 :acc16= variable 2
661 :call writeAcc16
662 :acc16= constant 1040
663 :acc16=> variable 4
664 ://  b = 13;
665 :acc8= constant 13
666 :acc8=> variable 0
667 ://  i = 3030;
668 :acc16= constant 3030
669 :acc16=> variable 2
670 ://  write(j - 14);    // 1026
671 :acc16= variable 4
672 :acc16- constant 14
673 ://  write(j - b);     // 1027
674 :call writeAcc16
675 :acc16= variable 4
676 :acc16- variable 0
677 ://  j = 2000;
678 :call writeAcc16
679 :acc16= constant 2000
680 :acc16=> variable 4
681 ://  write(j - 972);   // 1028
682 :acc16= variable 4
683 :acc16- constant 972
684 ://  write(3029 - j);  // 1029
685 :call writeAcc16
686 :acc16= constant 3029
687 :acc16- variable 4
688 ://  write(i - j);     // 1030
689 :call writeAcc16
690 :acc16= variable 2
691 :acc16- variable 4
692 ://  
693 ://  j = 1050;
694 :call writeAcc16
695 :acc16= constant 1050
696 :acc16=> variable 4
697 ://  b = 18;
698 :acc8= constant 18
699 :acc8=> variable 0
700 ://  i = j - 19;
701 :acc16= variable 4
702 :acc16- constant 19
703 :acc16=> variable 2
704 ://  write(i);         // 1031
705 ://  i = j - b;
706 :acc16= variable 2
707 :call writeAcc16
708 :acc16= variable 4
709 :acc16- variable 0
710 :acc16=> variable 2
711 ://  write(i);         // 1032
712 ://  j = 2000;
713 :acc16= variable 2
714 :call writeAcc16
715 :acc16= constant 2000
716 :acc16=> variable 4
717 ://  i = j - 967;
718 :acc16= variable 4
719 :acc16- constant 967
720 :acc16=> variable 2
721 ://  write(i);         // 1033
722 ://  i = 3034 - j;
723 :acc16= variable 2
724 :call writeAcc16
725 :acc16= constant 3034
726 :acc16- variable 4
727 :acc16=> variable 2
728 ://  write(i);         // 1034
729 ://  i = 3035;
730 :acc16= variable 2
731 :call writeAcc16
732 :acc16= constant 3035
733 :acc16=> variable 2
734 ://  i = i - j;
735 :acc16= variable 2
736 :acc16- variable 4
737 :acc16=> variable 2
738 ://  write(i);         // 1035
739 ://  
740 ://  /****************************/
741 ://  /* Dual term multiplication */
742 ://  /****************************/
743 ://  write(518 * 2);   // 1036
744 :acc16= variable 2
745 :call writeAcc16
746 :acc16= constant 518
747 :acc16* constant 2
748 ://  write(1 * 1037);  // 1037
749 :call writeAcc16
750 :acc8= constant 1
751 :acc8ToAcc16
752 :acc16* constant 1037
753 ://  write(500 * 504 - 54354); // 1038 = 55392 - 54354
754 :call writeAcc16
755 :acc16= constant 500
756 :acc16* constant 504
757 :acc16- constant 54354
758 ://
759 ://  i = 1039 * 1;
760 :call writeAcc16
761 :acc16= constant 1039
762 :acc16* constant 1
763 :acc16=> variable 2
764 ://  write(i);         // 1039
765 ://  i = 2 * 520;
766 :acc16= variable 2
767 :call writeAcc16
768 :acc8= constant 2
769 :acc8ToAcc16
770 :acc16* constant 520
771 :acc16=> variable 2
772 ://  write(i);         // 1040
773 ://
774 ://  i = 1041;
775 :acc16= variable 2
776 :call writeAcc16
777 :acc16= constant 1041
778 :acc16=> variable 2
779 ://  write(i * 1);     // 1041
780 :acc16= variable 2
781 :acc16* constant 1
782 ://  i = 521;
783 :call writeAcc16
784 :acc16= constant 521
785 :acc16=> variable 2
786 ://  write(2 * i);     // 1042
787 :acc8= constant 2
788 :acc8ToAcc16
789 :acc16* variable 2
790 ://
791 ://  i = 1043;
792 :call writeAcc16
793 :acc16= constant 1043
794 :acc16=> variable 2
795 ://  i = i * 1;
796 :acc16= variable 2
797 :acc16* constant 1
798 :acc16=> variable 2
799 ://  write(i);         // 1043
800 ://  i = 522;
801 :acc16= variable 2
802 :call writeAcc16
803 :acc16= constant 522
804 :acc16=> variable 2
805 ://  i = 2 * i;
806 :acc8= constant 2
807 :acc8ToAcc16
808 :acc16* variable 2
809 :acc16=> variable 2
810 ://  write(i);         // 1044
811 ://
812 ://  i = 500 * 504 - 54347; // 1045 = 55392 - 54347
813 :acc16= variable 2
814 :call writeAcc16
815 :acc16= constant 500
816 :acc16* constant 504
817 :acc16- constant 54347
818 :acc16=> variable 2
819 ://  write(i);         // 1045
820 ://  i = 500;
821 :acc16= variable 2
822 :call writeAcc16
823 :acc16= constant 500
824 :acc16=> variable 2
825 ://  i = i * 504 - 54346;
826 :acc16= variable 2
827 :acc16* constant 504
828 :acc16- constant 54346
829 :acc16=> variable 2
830 ://  write(i);         // 1046
831 ://  i = 504;
832 :acc16= variable 2
833 :call writeAcc16
834 :acc16= constant 504
835 :acc16=> variable 2
836 ://  i = 500 * i - 54345;
837 :acc16= constant 500
838 :acc16* variable 2
839 :acc16- constant 54345
840 :acc16=> variable 2
841 ://  write(i);         // 1047
842 ://  
843 ://  /************/
844 ://  /* Overflow */
845 ://  /************/
846 ://  write(300 * 301); // 90.300 % 65536 = 24.764
847 :acc16= variable 2
848 :call writeAcc16
849 :acc16= constant 300
850 :acc16* constant 301
851 ://  i = 300 * 302;
852 :call writeAcc16
853 :acc16= constant 300
854 :acc16* constant 302
855 :acc16=> variable 2
856 ://  write(i);         // 90.600 % 65536 = 25.064
857 ://
858 ://}
859 :acc16= variable 2
860 :call writeAcc16
861 :stop
