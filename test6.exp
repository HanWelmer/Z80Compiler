  0 :///*
  1 :// * A small program in the miniJava language.
  2 :// * Test 8-bit and 16-bit expressions.
  3 :// */
  4 ://class Test8And16BitExpressions {
  5 ://  write(0);         // 0
  6 :acc8= constant 0
  7 :call writeAcc8
  8 ://  //LD    A,0
  9 ://  //CALL  writeA
 10 ://  //OK
 11 ://
 12 ://  /*********************/
 13 ://  /* Single term 8-bit */
 14 ://  /*********************/
 15 ://  byte b = 1;
 16 :acc8= constant 1
 17 :acc8=> variable 0
 18 ://  byte c = 4;
 19 :acc8= constant 4
 20 :acc8=> variable 1
 21 ://  write(b);         // 1
 22 :acc8= variable 0
 23 :call writeAcc8
 24 ://  //LD    A,1
 25 ://  //LD    (04000H),A
 26 ://  //LD    A,(04000H)
 27 ://  //CALL  writeA
 28 ://  //OK
 29 ://
 30 ://  /************************/
 31 ://  /* Dual term addition   */
 32 ://  /************************/
 33 ://  write(0 + 2);     // 2
 34 :acc8= constant 0
 35 :acc8+ constant 2
 36 :call writeAcc8
 37 ://  write(b + 2);     // 3
 38 :acc8= variable 0
 39 :acc8+ constant 2
 40 :call writeAcc8
 41 ://  write(3 + b);     // 4
 42 :acc8= constant 3
 43 :acc8+ variable 0
 44 :call writeAcc8
 45 ://  write(b + c);     // 5
 46 :acc8= variable 0
 47 :acc8+ variable 1
 48 :call writeAcc8
 49 ://
 50 ://  c = 4 + 2;
 51 :acc8= constant 4
 52 :acc8+ constant 2
 53 :acc8=> variable 1
 54 ://  write(c);         // 6
 55 :acc8= variable 1
 56 :call writeAcc8
 57 ://  c = b + 6;
 58 :acc8= variable 0
 59 :acc8+ constant 6
 60 :acc8=> variable 1
 61 ://  write(c);         // 7
 62 :acc8= variable 1
 63 :call writeAcc8
 64 ://  c = 7 + b;
 65 :acc8= constant 7
 66 :acc8+ variable 0
 67 :acc8=> variable 1
 68 ://  write(c);         // 8
 69 :acc8= variable 1
 70 :call writeAcc8
 71 ://  c = b + c;
 72 :acc8= variable 0
 73 :acc8+ variable 1
 74 :acc8=> variable 1
 75 ://  write(c);         // 9
 76 :acc8= variable 1
 77 :call writeAcc8
 78 ://
 79 ://
 80 ://  int i = 10;
 81 :acc8= constant 10
 82 :acc8ToAcc16
 83 :acc16=> variable 2
 84 ://  write(i);         // 10
 85 :acc16= variable 2
 86 :call writeAcc16
 87 ://  //LD    A,10
 88 ://  //LD    L,A
 89 ://  //LD    H,0
 90 ://  //LD    (04004H),HL
 91 ://  //OK
 92 ://  
 93 ://  write(i + 1);     // 11
 94 :acc16= variable 2
 95 :acc16+ constant 1
 96 :call writeAcc16
 97 ://  write(2 + i);     // 12
 98 :acc8= constant 2
 99 :acc8ToAcc16
100 :acc16+ variable 2
101 :call writeAcc16
102 ://  b = 3;
103 :acc8= constant 3
104 :acc8=> variable 0
105 ://  write(i + b);     // 13
106 :acc16= variable 2
107 :acc16+ variable 0
108 :call writeAcc16
109 ://  b++; //4
110 :incr8 variable 0
111 ://  write(b + i);     // 14
112 :acc8= variable 0
113 :acc8ToAcc16
114 :acc16+ variable 2
115 :call writeAcc16
116 ://
117 ://  int j = i + 5;    // 15
118 :acc16= variable 2
119 :acc16+ constant 5
120 :acc16=> variable 4
121 ://  write(j);
122 :acc16= variable 4
123 :call writeAcc16
124 ://  j = 6 + i;        // 16
125 :acc8= constant 6
126 :acc8ToAcc16
127 :acc16+ variable 2
128 :acc16=> variable 4
129 ://  write(j);
130 :acc16= variable 4
131 :call writeAcc16
132 ://  j = 7;
133 :acc8= constant 7
134 :acc8ToAcc16
135 :acc16=> variable 4
136 ://  j = i + j;        // 17
137 :acc16= variable 2
138 :acc16+ variable 4
139 :acc16=> variable 4
140 ://  write(j);
141 :acc16= variable 4
142 :call writeAcc16
143 ://
144 ://  /*************************/
145 ://  /* Dual term subtraction */
146 ://  /*************************/
147 ://  b = 33;
148 :acc8= constant 33
149 :acc8=> variable 0
150 ://  c = 12;
151 :acc8= constant 12
152 :acc8=> variable 1
153 ://  write(19 - 1);    // 18
154 :acc8= constant 19
155 :acc8- constant 1
156 :call writeAcc8
157 ://  write(b - 14);    // 19
158 :acc8= variable 0
159 :acc8- constant 14
160 :call writeAcc8
161 ://  write(53 - b);    // 20
162 :acc8= constant 53
163 :acc8- variable 0
164 :call writeAcc8
165 ://  write(b - c);     // 21
166 :acc8= variable 0
167 :acc8- variable 1
168 :call writeAcc8
169 ://
170 ://  c = 24 - 2;
171 :acc8= constant 24
172 :acc8- constant 2
173 :acc8=> variable 1
174 ://  write(c);         // 22
175 :acc8= variable 1
176 :call writeAcc8
177 ://  c = b - 10;
178 :acc8= variable 0
179 :acc8- constant 10
180 :acc8=> variable 1
181 ://  write(c);         // 23
182 :acc8= variable 1
183 :call writeAcc8
184 ://  c = 57 - b;
185 :acc8= constant 57
186 :acc8- variable 0
187 :acc8=> variable 1
188 ://  write(c);         // 24
189 :acc8= variable 1
190 :call writeAcc8
191 ://  c = 8;
192 :acc8= constant 8
193 :acc8=> variable 1
194 ://  c = b - c;
195 :acc8= variable 0
196 :acc8- variable 1
197 :acc8=> variable 1
198 ://  write(c);         // 25
199 :acc8= variable 1
200 :call writeAcc8
201 ://
202 ://  i = 40;
203 :acc8= constant 40
204 :acc8ToAcc16
205 :acc16=> variable 2
206 ://  write(i - 14);    // 26
207 :acc16= variable 2
208 :acc16- constant 14
209 :call writeAcc16
210 ://  write(67 - i);    // 27
211 :acc8= constant 67
212 :acc8ToAcc16
213 :acc16- variable 2
214 :call writeAcc16
215 ://  b = 12;
216 :acc8= constant 12
217 :acc8=> variable 0
218 ://  write(i - b);     // 28
219 :acc16= variable 2
220 :acc16- variable 0
221 :call writeAcc16
222 ://  b = 69;
223 :acc8= constant 69
224 :acc8=> variable 0
225 ://  write(b - i);     // 29
226 :acc8= variable 0
227 :acc8ToAcc16
228 :acc16- variable 2
229 :call writeAcc16
230 ://
231 ://  j = i - 10;
232 :acc16= variable 2
233 :acc16- constant 10
234 :acc16=> variable 4
235 ://  write(j);         // 30
236 :acc16= variable 4
237 :call writeAcc16
238 ://  j = 71 - i;
239 :acc8= constant 71
240 :acc8ToAcc16
241 :acc16- variable 2
242 :acc16=> variable 4
243 ://  write(j);         // 31
244 :acc16= variable 4
245 :call writeAcc16
246 ://  j = 8;
247 :acc8= constant 8
248 :acc8ToAcc16
249 :acc16=> variable 4
250 ://  j = i - j;
251 :acc16= variable 2
252 :acc16- variable 4
253 :acc16=> variable 4
254 ://  write(j);         // 32
255 :acc16= variable 4
256 :call writeAcc16
257 ://  
258 ://  /****************************/
259 ://  /* Dual term multiplication */
260 ://  /****************************/
261 ://  write(3 * 11);    // 33
262 :acc8= constant 3
263 :acc8* constant 11
264 :call writeAcc8
265 ://  b = 17;
266 :acc8= constant 17
267 :acc8=> variable 0
268 ://  write(b * 2);     // 34
269 :acc8= variable 0
270 :acc8* constant 2
271 :call writeAcc8
272 ://  b = 7;
273 :acc8= constant 7
274 :acc8=> variable 0
275 ://  write(5 * b);     // 35
276 :acc8= constant 5
277 :acc8* variable 0
278 :call writeAcc8
279 ://  b = 2;
280 :acc8= constant 2
281 :acc8=> variable 0
282 ://  c = 18;
283 :acc8= constant 18
284 :acc8=> variable 1
285 ://  write(b * c);     // 36
286 :acc8= variable 0
287 :acc8* variable 1
288 :call writeAcc8
289 ://  
290 ://  c = 37 * 1;
291 :acc8= constant 37
292 :acc8* constant 1
293 :acc8=> variable 1
294 ://  write(c);         // 37
295 :acc8= variable 1
296 :call writeAcc8
297 ://  b = 2;
298 :acc8= constant 2
299 :acc8=> variable 0
300 ://  c = b * 19;
301 :acc8= variable 0
302 :acc8* constant 19
303 :acc8=> variable 1
304 ://  write(c);         // 38
305 :acc8= variable 1
306 :call writeAcc8
307 ://  b = 3;
308 :acc8= constant 3
309 :acc8=> variable 0
310 ://  c = 13 * b;
311 :acc8= constant 13
312 :acc8* variable 0
313 :acc8=> variable 1
314 ://  write(c);         // 39
315 :acc8= variable 1
316 :call writeAcc8
317 ://  b = 5;
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
328 :acc8= variable 1
329 :call writeAcc8
330 ://
331 ://  /**********************/
332 ://  /* Dual term division */
333 ://  /**********************/
334 ://  write(123 / 3);   // 41
335 :acc8= constant 123
336 :acc8/ constant 3
337 :call writeAcc8
338 ://  b = 126;
339 :acc8= constant 126
340 :acc8=> variable 0
341 ://  write(b / 3);     // 42
342 :acc8= variable 0
343 :acc8/ constant 3
344 :call writeAcc8
345 ://  b = 3;
346 :acc8= constant 3
347 :acc8=> variable 0
348 ://  write(129 / b);   // 43
349 :acc8= constant 129
350 :acc8/ variable 0
351 :call writeAcc8
352 ://  b = 132;
353 :acc8= constant 132
354 :acc8=> variable 0
355 ://  c = 3;
356 :acc8= constant 3
357 :acc8=> variable 1
358 ://  write(b / c);     // 44
359 :acc8= variable 0
360 :acc8/ variable 1
361 :call writeAcc8
362 ://  
363 ://  c = 135 / 3;
364 :acc8= constant 135
365 :acc8/ constant 3
366 :acc8=> variable 1
367 ://  write(c);         // 45
368 :acc8= variable 1
369 :call writeAcc8
370 ://  b = 138;
371 :acc8= constant 138
372 :acc8=> variable 0
373 ://  c = b / 3;
374 :acc8= variable 0
375 :acc8/ constant 3
376 :acc8=> variable 1
377 ://  write(c);         // 46
378 :acc8= variable 1
379 :call writeAcc8
380 ://  b = 3;
381 :acc8= constant 3
382 :acc8=> variable 0
383 ://  c = 141 / b;
384 :acc8= constant 141
385 :acc8/ variable 0
386 :acc8=> variable 1
387 ://  write(c);         // 47
388 :acc8= variable 1
389 :call writeAcc8
390 ://  b = 144;
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
401 :acc8= variable 1
402 :call writeAcc8
403 ://
404 ://  /*************************/
405 ://  /* possible loss of data */
406 ://  /*************************/
407 ://  b = 507;
408 :acc16= constant 507
409 :acc16ToAcc8
410 :acc8=> variable 0
411 ://  write(b);         // 251
412 :acc8= variable 0
413 :call writeAcc8
414 ://  i = 508;
415 :acc16= constant 508
416 :acc16=> variable 2
417 ://  b = i;
418 :acc16= variable 2
419 :acc16ToAcc8
420 :acc8=> variable 0
421 ://  write(b);         // 252
422 :acc8= variable 0
423 :call writeAcc8
424 ://
425 ://  b = b - 505;
426 :acc8= variable 0
427 :acc8ToAcc16
428 :acc16- constant 505
429 :acc16ToAcc8
430 :acc8=> variable 0
431 ://  write(b);         // 252 - 505 = -253
432 :acc8= variable 0
433 :call writeAcc8
434 ://  i = i + 5;
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
445 :acc8= variable 0
446 :call writeAcc8
447 ://  
448 ://  b = 255;
449 :acc8= constant 255
450 :acc8=> variable 0
451 ://  write(b);         // 255
452 :acc8= variable 0
453 :call writeAcc8
454 ://  //LD    A,255
455 ://  //LD    (04001H),A
456 ://  //LD    A,(04001H)
457 ://  //CALL  writeA
458 ://  //OK
459 ://
460 ://  /**********************/
461 ://  /* Single term 16-bit */
462 ://  /**********************/
463 ://  i = 256;
464 :acc16= constant 256
465 :acc16=> variable 2
466 ://  write(i);         // 256
467 :acc16= variable 2
468 :call writeAcc16
469 ://  //LD    HL,256
470 ://  //LD    (04006H),HL
471 ://  //LD    HL,(04006H)
472 ://  //CALL  writeHL
473 ://  //OK
474 ://
475 ://  write(1000);      // 1000
476 :acc16= constant 1000
477 :call writeAcc16
478 ://  j = 1001;
479 :acc16= constant 1001
480 :acc16=> variable 4
481 ://  write(j);         // 1001
482 :acc16= variable 4
483 :call writeAcc16
484 ://
485 ://  /************************/
486 ://  /* Dual term addition   */
487 ://  /************************/
488 ://  write(1000 + 2);  // 1002
489 :acc16= constant 1000
490 :acc16+ constant 2
491 :call writeAcc16
492 ://  write(3 + 1000);  // 1003
493 :acc8= constant 3
494 :acc8ToAcc16
495 :acc16+ constant 1000
496 :call writeAcc16
497 ://  write(500 + 504); // 1004
498 :acc16= constant 500
499 :acc16+ constant 504
500 :call writeAcc16
501 ://  i = 1000 + 5;
502 :acc16= constant 1000
503 :acc16+ constant 5
504 :acc16=> variable 2
505 ://  write(i);         // 1005
506 :acc16= variable 2
507 :call writeAcc16
508 ://  i = 6 + 1000;
509 :acc8= constant 6
510 :acc8ToAcc16
511 :acc16+ constant 1000
512 :acc16=> variable 2
513 ://  write(i);         // 1006
514 :acc16= variable 2
515 :call writeAcc16
516 ://  i = 500 + 507;
517 :acc16= constant 500
518 :acc16+ constant 507
519 :acc16=> variable 2
520 ://  write(i);         // 1007
521 :acc16= variable 2
522 :call writeAcc16
523 ://  
524 ://  j = 1000;
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
536 :call writeAcc16
537 ://  write(9 + j);     // 1009
538 :acc8= constant 9
539 :acc8ToAcc16
540 :acc16+ variable 4
541 :call writeAcc16
542 ://  write(j + b);     // 1010
543 :acc16= variable 4
544 :acc16+ variable 0
545 :call writeAcc16
546 ://  b++;
547 :incr8 variable 0
548 ://  write(b + j);     // 1011
549 :acc8= variable 0
550 :acc8ToAcc16
551 :acc16+ variable 4
552 :call writeAcc16
553 ://  j = 500;
554 :acc16= constant 500
555 :acc16=> variable 4
556 ://  write(j + 512);   // 1012
557 :acc16= variable 4
558 :acc16+ constant 512
559 :call writeAcc16
560 ://  write(513 + j);   // 1013
561 :acc16= constant 513
562 :acc16+ variable 4
563 :call writeAcc16
564 ://  write(i + j);     // 1014
565 :acc16= variable 2
566 :acc16+ variable 4
567 :call writeAcc16
568 ://  
569 ://  j = 1000;
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
580 :acc16= variable 2
581 :call writeAcc16
582 ://  i = 16 + j;
583 :acc8= constant 16
584 :acc8ToAcc16
585 :acc16+ variable 4
586 :acc16=> variable 2
587 ://  write(i);         // 1016
588 :acc16= variable 2
589 :call writeAcc16
590 ://  i = j + b;
591 :acc16= variable 4
592 :acc16+ variable 0
593 :acc16=> variable 2
594 ://  write(i);         // 1017
595 :acc16= variable 2
596 :call writeAcc16
597 ://  b++;
598 :incr8 variable 0
599 ://  i = b + j;
600 :acc8= variable 0
601 :acc8ToAcc16
602 :acc16+ variable 4
603 :acc16=> variable 2
604 ://  write(i);         // 1018
605 :acc16= variable 2
606 :call writeAcc16
607 ://  j = 500;
608 :acc16= constant 500
609 :acc16=> variable 4
610 ://  i = j + 519;
611 :acc16= variable 4
612 :acc16+ constant 519
613 :acc16=> variable 2
614 ://  write(i);         // 1019
615 :acc16= variable 2
616 :call writeAcc16
617 ://  i = 520 + j;
618 :acc16= constant 520
619 :acc16+ variable 4
620 :acc16=> variable 2
621 ://  write(i);         // 1020
622 :acc16= variable 2
623 :call writeAcc16
624 ://  i = 521;
625 :acc16= constant 521
626 :acc16=> variable 2
627 ://  i = i + j;
628 :acc16= variable 2
629 :acc16+ variable 4
630 :acc16=> variable 2
631 ://  write(i);         // 1021
632 :acc16= variable 2
633 :call writeAcc16
634 ://  
635 ://  /*************************/
636 ://  /* Dual term subtraction */
637 ://  /*************************/
638 ://  write(1024 - 2);  // 1022
639 :acc16= constant 1024
640 :acc16- constant 2
641 :call writeAcc16
642 ://  write(1523 - 500);// 1023
643 :acc16= constant 1523
644 :acc16- constant 500
645 :call writeAcc16
646 ://  i = 1030 - 6;
647 :acc16= constant 1030
648 :acc16- constant 6
649 :acc16=> variable 2
650 ://  write(i);         // 1024
651 :acc16= variable 2
652 :call writeAcc16
653 ://  i = 1525 - 500;
654 :acc16= constant 1525
655 :acc16- constant 500
656 :acc16=> variable 2
657 ://  write(i);         // 1025
658 :acc16= variable 2
659 :call writeAcc16
660 ://  
661 ://  j = 1040;
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
673 :call writeAcc16
674 ://  write(j - b);     // 1027
675 :acc16= variable 4
676 :acc16- variable 0
677 :call writeAcc16
678 ://  j = 2000;
679 :acc16= constant 2000
680 :acc16=> variable 4
681 ://  write(j - 972);   // 1028
682 :acc16= variable 4
683 :acc16- constant 972
684 :call writeAcc16
685 ://  write(3029 - j);  // 1029
686 :acc16= constant 3029
687 :acc16- variable 4
688 :call writeAcc16
689 ://  write(i - j);     // 1030
690 :acc16= variable 2
691 :acc16- variable 4
692 :call writeAcc16
693 ://  
694 ://  j = 1050;
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
705 :acc16= variable 2
706 :call writeAcc16
707 ://  i = j - b;
708 :acc16= variable 4
709 :acc16- variable 0
710 :acc16=> variable 2
711 ://  write(i);         // 1032
712 :acc16= variable 2
713 :call writeAcc16
714 ://  j = 2000;
715 :acc16= constant 2000
716 :acc16=> variable 4
717 ://  i = j - 967;
718 :acc16= variable 4
719 :acc16- constant 967
720 :acc16=> variable 2
721 ://  write(i);         // 1033
722 :acc16= variable 2
723 :call writeAcc16
724 ://  i = 3034 - j;
725 :acc16= constant 3034
726 :acc16- variable 4
727 :acc16=> variable 2
728 ://  write(i);         // 1034
729 :acc16= variable 2
730 :call writeAcc16
731 ://  i = 3035;
732 :acc16= constant 3035
733 :acc16=> variable 2
734 ://  i = i - j;
735 :acc16= variable 2
736 :acc16- variable 4
737 :acc16=> variable 2
738 ://  write(i);         // 1035
739 :acc16= variable 2
740 :call writeAcc16
741 ://  
742 ://  /****************************/
743 ://  /* Dual term multiplication */
744 ://  /****************************/
745 ://  write(518 * 2);   // 1036
746 :acc16= constant 518
747 :acc16* constant 2
748 :call writeAcc16
749 ://  write(1 * 1037);  // 1037
750 :acc8= constant 1
751 :acc8ToAcc16
752 :acc16* constant 1037
753 :call writeAcc16
754 ://  write(500 * 504 - 54354); // 1038 = 55392 - 54354
755 :acc16= constant 500
756 :acc16* constant 504
757 :acc16- constant 54354
758 :call writeAcc16
759 ://
760 ://  i = 1039 * 1;
761 :acc16= constant 1039
762 :acc16* constant 1
763 :acc16=> variable 2
764 ://  write(i);         // 1039
765 :acc16= variable 2
766 :call writeAcc16
767 ://  i = 2 * 520;
768 :acc8= constant 2
769 :acc8ToAcc16
770 :acc16* constant 520
771 :acc16=> variable 2
772 ://  write(i);         // 1040
773 :acc16= variable 2
774 :call writeAcc16
775 ://
776 ://  i = 1041;
777 :acc16= constant 1041
778 :acc16=> variable 2
779 ://  write(i * 1);     // 1041
780 :acc16= variable 2
781 :acc16* constant 1
782 :call writeAcc16
783 ://  i = 521;
784 :acc16= constant 521
785 :acc16=> variable 2
786 ://  write(2 * i);     // 1042
787 :acc8= constant 2
788 :acc8ToAcc16
789 :acc16* variable 2
790 :call writeAcc16
791 ://
792 ://  i = 1043;
793 :acc16= constant 1043
794 :acc16=> variable 2
795 ://  i = i * 1;
796 :acc16= variable 2
797 :acc16* constant 1
798 :acc16=> variable 2
799 ://  write(i);         // 1043
800 :acc16= variable 2
801 :call writeAcc16
802 ://  i = 522;
803 :acc16= constant 522
804 :acc16=> variable 2
805 ://  i = 2 * i;
806 :acc8= constant 2
807 :acc8ToAcc16
808 :acc16* variable 2
809 :acc16=> variable 2
810 ://  write(i);         // 1044
811 :acc16= variable 2
812 :call writeAcc16
813 ://
814 ://  i = 500 * 504 - 54347; // 1045 = 55392 - 54347
815 :acc16= constant 500
816 :acc16* constant 504
817 :acc16- constant 54347
818 :acc16=> variable 2
819 ://  write(i);         // 1045
820 :acc16= variable 2
821 :call writeAcc16
822 ://  i = 500;
823 :acc16= constant 500
824 :acc16=> variable 2
825 ://  i = i * 504 - 54346;
826 :acc16= variable 2
827 :acc16* constant 504
828 :acc16- constant 54346
829 :acc16=> variable 2
830 ://  write(i);         // 1046
831 :acc16= variable 2
832 :call writeAcc16
833 ://  i = 504;
834 :acc16= constant 504
835 :acc16=> variable 2
836 ://  i = 500 * i - 54345;
837 :acc16= constant 500
838 :acc16* variable 2
839 :acc16- constant 54345
840 :acc16=> variable 2
841 ://  write(i);         // 1047
842 :acc16= variable 2
843 :call writeAcc16
844 ://  
845 ://  /************/
846 ://  /* Overflow */
847 ://  /************/
848 ://  write(300 * 301); // 90.300 % 65536 = 24.764
849 :acc16= constant 300
850 :acc16* constant 301
851 :call writeAcc16
852 ://  i = 300 * 302;
853 :acc16= constant 300
854 :acc16* constant 302
855 :acc16=> variable 2
856 ://  write(i);         // 90.600 % 65536 = 25.064
857 :acc16= variable 2
858 :call writeAcc16
859 ://
860 ://}
861 :stop
