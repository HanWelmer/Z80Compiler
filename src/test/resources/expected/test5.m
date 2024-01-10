   0 ;test5.j(0) /*
   1 ;test5.j(1)  * A small program in the miniJava language.
   2 ;test5.j(2)  * Test comparison
   3 ;test5.j(3)  */
   4 ;test5.j(4) class TestComparison {
   5 ;test5.j(5)   private static word zero = 0;
   6 acc8= constant 0
   7 acc8=> variable 0
   8 ;test5.j(6)   private static word one = 1;
   9 acc8= constant 1
  10 acc8=> variable 2
  11 ;test5.j(7)   private static word three = 3;
  12 acc8= constant 3
  13 acc8=> variable 4
  14 ;test5.j(8)   private static word four = 4;
  15 acc8= constant 4
  16 acc8=> variable 6
  17 ;test5.j(9)   private static word five = 5;
  18 acc8= constant 5
  19 acc8=> variable 8
  20 ;test5.j(10)   private static word twelve = 12;
  21 acc8= constant 12
  22 acc8=> variable 10
  23 ;test5.j(11)   private static byte byteOne = 1;
  24 acc8= constant 1
  25 acc8=> variable 12
  26 ;test5.j(12)   private static byte byteSix = 262;
  27 acc16= constant 262
  28 acc16=> variable 13
  29 ;test5.j(13)   private static byte b;
  30 ;test5.j(14)   
  31 ;test5.j(15)   public static void main() {
  32 ;test5.j(16)     //stack level 1
  33 ;test5.j(17)     //byte-byte
  34 ;test5.j(18)     if (4 == 12/(1+2)) println(0);
  35 acc8= constant 12
  36 <acc8= constant 1
  37 acc8+ constant 2
  38 /acc8 unstack8
  39 acc8Comp constant 4
  40 brne 44
  41 acc8= constant 0
  42 call writeLineAcc8
  43 ;test5.j(19)     if (4 == 4) println(1);
  44 acc8= constant 4
  45 acc8Comp constant 4
  46 brne 50
  47 acc8= constant 1
  48 call writeLineAcc8
  49 ;test5.j(20)     if (3 != 12/(1+2)) println(2);
  50 acc8= constant 12
  51 <acc8= constant 1
  52 acc8+ constant 2
  53 /acc8 unstack8
  54 acc8Comp constant 3
  55 breq 59
  56 acc8= constant 2
  57 call writeLineAcc8
  58 ;test5.j(21)     if (3 != 4) println(3);
  59 acc8= constant 3
  60 acc8Comp constant 4
  61 breq 65
  62 acc8= constant 3
  63 call writeLineAcc8
  64 ;test5.j(22)     if (3 < 12/(1+2)) println(4);
  65 acc8= constant 12
  66 <acc8= constant 1
  67 acc8+ constant 2
  68 /acc8 unstack8
  69 acc8Comp constant 3
  70 brle 74
  71 acc8= constant 4
  72 call writeLineAcc8
  73 ;test5.j(23)     if (3 < 4) println(5);
  74 acc8= constant 3
  75 acc8Comp constant 4
  76 brge 80
  77 acc8= constant 5
  78 call writeLineAcc8
  79 ;test5.j(24)     if (5 > 12/(1+2)) println(6);
  80 acc8= constant 12
  81 <acc8= constant 1
  82 acc8+ constant 2
  83 /acc8 unstack8
  84 acc8Comp constant 5
  85 brge 89
  86 acc8= constant 6
  87 call writeLineAcc8
  88 ;test5.j(25)     if (5 > 4) println(7);
  89 acc8= constant 5
  90 acc8Comp constant 4
  91 brle 95
  92 acc8= constant 7
  93 call writeLineAcc8
  94 ;test5.j(26)     if (3 <= 12/(1+2)) println(8);
  95 acc8= constant 12
  96 <acc8= constant 1
  97 acc8+ constant 2
  98 /acc8 unstack8
  99 acc8Comp constant 3
 100 brlt 104
 101 acc8= constant 8
 102 call writeLineAcc8
 103 ;test5.j(27)     if (3 <= 4) println(9);
 104 acc8= constant 3
 105 acc8Comp constant 4
 106 brgt 110
 107 acc8= constant 9
 108 call writeLineAcc8
 109 ;test5.j(28)     if (4 <= 12/(1+2)) println(10);
 110 acc8= constant 12
 111 <acc8= constant 1
 112 acc8+ constant 2
 113 /acc8 unstack8
 114 acc8Comp constant 4
 115 brlt 119
 116 acc8= constant 10
 117 call writeLineAcc8
 118 ;test5.j(29)     if (4 <= 4) println(11);
 119 acc8= constant 4
 120 acc8Comp constant 4
 121 brgt 125
 122 acc8= constant 11
 123 call writeLineAcc8
 124 ;test5.j(30)     if (5 >= 12/(1+2)) println(12);
 125 acc8= constant 12
 126 <acc8= constant 1
 127 acc8+ constant 2
 128 /acc8 unstack8
 129 acc8Comp constant 5
 130 brgt 134
 131 acc8= constant 12
 132 call writeLineAcc8
 133 ;test5.j(31)     if (5 >= 4) println(13);
 134 acc8= constant 5
 135 acc8Comp constant 4
 136 brlt 140
 137 acc8= constant 13
 138 call writeLineAcc8
 139 ;test5.j(32)     if (4 >= 12/(1+2)) println(14);
 140 acc8= constant 12
 141 <acc8= constant 1
 142 acc8+ constant 2
 143 /acc8 unstack8
 144 acc8Comp constant 4
 145 brgt 149
 146 acc8= constant 14
 147 call writeLineAcc8
 148 ;test5.j(33)     if (4 >= 4) println(15);
 149 acc8= constant 4
 150 acc8Comp constant 4
 151 brlt 157
 152 acc8= constant 15
 153 call writeLineAcc8
 154 ;test5.j(34)     //stack level 1
 155 ;test5.j(35)     //byte-integer
 156 ;test5.j(36)     if (4 == twelve/(1+2)) println(16);
 157 acc16= variable 10
 158 acc8= constant 1
 159 acc8+ constant 2
 160 acc16/ acc8
 161 acc8= constant 4
 162 acc8CompareAcc16
 163 brne 167
 164 acc8= constant 16
 165 call writeLineAcc8
 166 ;test5.j(37)     if (4 == four) println(17);
 167 acc16= variable 6
 168 acc8= constant 4
 169 acc8CompareAcc16
 170 brne 174
 171 acc8= constant 17
 172 call writeLineAcc8
 173 ;test5.j(38)     if (3 != twelve/(1+2)) println(18);
 174 acc16= variable 10
 175 acc8= constant 1
 176 acc8+ constant 2
 177 acc16/ acc8
 178 acc8= constant 3
 179 acc8CompareAcc16
 180 breq 184
 181 acc8= constant 18
 182 call writeLineAcc8
 183 ;test5.j(39)     if (3 != four) println(19);
 184 acc16= variable 6
 185 acc8= constant 3
 186 acc8CompareAcc16
 187 breq 191
 188 acc8= constant 19
 189 call writeLineAcc8
 190 ;test5.j(40)     if (3 < twelve/(1+2)) println(20);
 191 acc16= variable 10
 192 acc8= constant 1
 193 acc8+ constant 2
 194 acc16/ acc8
 195 acc8= constant 3
 196 acc8CompareAcc16
 197 brge 201
 198 acc8= constant 20
 199 call writeLineAcc8
 200 ;test5.j(41)     if (3 < four) println(21);
 201 acc16= variable 6
 202 acc8= constant 3
 203 acc8CompareAcc16
 204 brge 208
 205 acc8= constant 21
 206 call writeLineAcc8
 207 ;test5.j(42)     if (5 > twelve/(1+2)) println(22);
 208 acc16= variable 10
 209 acc8= constant 1
 210 acc8+ constant 2
 211 acc16/ acc8
 212 acc8= constant 5
 213 acc8CompareAcc16
 214 brle 218
 215 acc8= constant 22
 216 call writeLineAcc8
 217 ;test5.j(43)     if (5 > four) println(23);
 218 acc16= variable 6
 219 acc8= constant 5
 220 acc8CompareAcc16
 221 brle 225
 222 acc8= constant 23
 223 call writeLineAcc8
 224 ;test5.j(44)     if (3 <= twelve/(1+2)) println(24);
 225 acc16= variable 10
 226 acc8= constant 1
 227 acc8+ constant 2
 228 acc16/ acc8
 229 acc8= constant 3
 230 acc8CompareAcc16
 231 brgt 235
 232 acc8= constant 24
 233 call writeLineAcc8
 234 ;test5.j(45)     if (3 <= four) println(25);
 235 acc16= variable 6
 236 acc8= constant 3
 237 acc8CompareAcc16
 238 brgt 242
 239 acc8= constant 25
 240 call writeLineAcc8
 241 ;test5.j(46)     if (4 <= twelve/(1+2)) println(26);
 242 acc16= variable 10
 243 acc8= constant 1
 244 acc8+ constant 2
 245 acc16/ acc8
 246 acc8= constant 4
 247 acc8CompareAcc16
 248 brgt 252
 249 acc8= constant 26
 250 call writeLineAcc8
 251 ;test5.j(47)     if (4 <= four) println(27);
 252 acc16= variable 6
 253 acc8= constant 4
 254 acc8CompareAcc16
 255 brgt 259
 256 acc8= constant 27
 257 call writeLineAcc8
 258 ;test5.j(48)     if (5 >= twelve/(1+2)) println(28);
 259 acc16= variable 10
 260 acc8= constant 1
 261 acc8+ constant 2
 262 acc16/ acc8
 263 acc8= constant 5
 264 acc8CompareAcc16
 265 brlt 269
 266 acc8= constant 28
 267 call writeLineAcc8
 268 ;test5.j(49)     if (5 >= four) println(29);
 269 acc16= variable 6
 270 acc8= constant 5
 271 acc8CompareAcc16
 272 brlt 276
 273 acc8= constant 29
 274 call writeLineAcc8
 275 ;test5.j(50)     if (4 >= twelve/(1+2)) println(30);
 276 acc16= variable 10
 277 acc8= constant 1
 278 acc8+ constant 2
 279 acc16/ acc8
 280 acc8= constant 4
 281 acc8CompareAcc16
 282 brlt 286
 283 acc8= constant 30
 284 call writeLineAcc8
 285 ;test5.j(51)     if (4 >= four) println(31);
 286 acc16= variable 6
 287 acc8= constant 4
 288 acc8CompareAcc16
 289 brlt 295
 290 acc8= constant 31
 291 call writeLineAcc8
 292 ;test5.j(52)     //stack level 1
 293 ;test5.j(53)     //integer-byte
 294 ;test5.j(54)     if (four == 12/(1+2)) println(32);
 295 acc8= constant 12
 296 <acc8= constant 1
 297 acc8+ constant 2
 298 /acc8 unstack8
 299 acc16= variable 6
 300 acc16CompareAcc8
 301 brne 305
 302 acc8= constant 32
 303 call writeLineAcc8
 304 ;test5.j(55)     if (four == 4) println(33);
 305 acc16= variable 6
 306 acc8= constant 4
 307 acc16CompareAcc8
 308 brne 312
 309 acc8= constant 33
 310 call writeLineAcc8
 311 ;test5.j(56)     if (three != 12/(1+2)) println(34);
 312 acc8= constant 12
 313 <acc8= constant 1
 314 acc8+ constant 2
 315 /acc8 unstack8
 316 acc16= variable 4
 317 acc16CompareAcc8
 318 breq 322
 319 acc8= constant 34
 320 call writeLineAcc8
 321 ;test5.j(57)     if (three != 4) println(35);
 322 acc16= variable 4
 323 acc8= constant 4
 324 acc16CompareAcc8
 325 breq 329
 326 acc8= constant 35
 327 call writeLineAcc8
 328 ;test5.j(58)     if (three < 12/(1+2)) println(36);
 329 acc8= constant 12
 330 <acc8= constant 1
 331 acc8+ constant 2
 332 /acc8 unstack8
 333 acc16= variable 4
 334 acc16CompareAcc8
 335 brge 339
 336 acc8= constant 36
 337 call writeLineAcc8
 338 ;test5.j(59)     if (three < 4) println(37);
 339 acc16= variable 4
 340 acc8= constant 4
 341 acc16CompareAcc8
 342 brge 346
 343 acc8= constant 37
 344 call writeLineAcc8
 345 ;test5.j(60)     if (five > 12/(1+2)) println(38);
 346 acc8= constant 12
 347 <acc8= constant 1
 348 acc8+ constant 2
 349 /acc8 unstack8
 350 acc16= variable 8
 351 acc16CompareAcc8
 352 brle 356
 353 acc8= constant 38
 354 call writeLineAcc8
 355 ;test5.j(61)     if (five > 4) println(39);
 356 acc16= variable 8
 357 acc8= constant 4
 358 acc16CompareAcc8
 359 brle 363
 360 acc8= constant 39
 361 call writeLineAcc8
 362 ;test5.j(62)     if (three <= 12/(1+2)) println(40);
 363 acc8= constant 12
 364 <acc8= constant 1
 365 acc8+ constant 2
 366 /acc8 unstack8
 367 acc16= variable 4
 368 acc16CompareAcc8
 369 brgt 373
 370 acc8= constant 40
 371 call writeLineAcc8
 372 ;test5.j(63)     if (three <= 4) println(41);
 373 acc16= variable 4
 374 acc8= constant 4
 375 acc16CompareAcc8
 376 brgt 380
 377 acc8= constant 41
 378 call writeLineAcc8
 379 ;test5.j(64)     if (four <= 12/(1+2)) println(42);
 380 acc8= constant 12
 381 <acc8= constant 1
 382 acc8+ constant 2
 383 /acc8 unstack8
 384 acc16= variable 6
 385 acc16CompareAcc8
 386 brgt 390
 387 acc8= constant 42
 388 call writeLineAcc8
 389 ;test5.j(65)     if (four <= 4) println(43);
 390 acc16= variable 6
 391 acc8= constant 4
 392 acc16CompareAcc8
 393 brgt 397
 394 acc8= constant 43
 395 call writeLineAcc8
 396 ;test5.j(66)     if (five >= 12/(1+2)) println(44);
 397 acc8= constant 12
 398 <acc8= constant 1
 399 acc8+ constant 2
 400 /acc8 unstack8
 401 acc16= variable 8
 402 acc16CompareAcc8
 403 brlt 407
 404 acc8= constant 44
 405 call writeLineAcc8
 406 ;test5.j(67)     if (five >= 4) println(45);
 407 acc16= variable 8
 408 acc8= constant 4
 409 acc16CompareAcc8
 410 brlt 414
 411 acc8= constant 45
 412 call writeLineAcc8
 413 ;test5.j(68)     if (four >= 12/(1+2)) println(46);
 414 acc8= constant 12
 415 <acc8= constant 1
 416 acc8+ constant 2
 417 /acc8 unstack8
 418 acc16= variable 6
 419 acc16CompareAcc8
 420 brlt 424
 421 acc8= constant 46
 422 call writeLineAcc8
 423 ;test5.j(69)     if (four >= 4) println(47);
 424 acc16= variable 6
 425 acc8= constant 4
 426 acc16CompareAcc8
 427 brlt 433
 428 acc8= constant 47
 429 call writeLineAcc8
 430 ;test5.j(70)     //stack level 1
 431 ;test5.j(71)     //integer-integer
 432 ;test5.j(72)     if (400 == 1200/(1+2)) println(48);
 433 acc16= constant 1200
 434 acc8= constant 1
 435 acc8+ constant 2
 436 acc16/ acc8
 437 acc16Comp constant 400
 438 brne 442
 439 acc8= constant 48
 440 call writeLineAcc8
 441 ;test5.j(73)     if (400 == 400) println(49);
 442 acc16= constant 400
 443 acc16Comp constant 400
 444 brne 448
 445 acc8= constant 49
 446 call writeLineAcc8
 447 ;test5.j(74)     if (300 != 1200/(1+2)) println(50);
 448 acc16= constant 1200
 449 acc8= constant 1
 450 acc8+ constant 2
 451 acc16/ acc8
 452 acc16Comp constant 300
 453 breq 457
 454 acc8= constant 50
 455 call writeLineAcc8
 456 ;test5.j(75)     if (300 != 400) println(51);
 457 acc16= constant 300
 458 acc16Comp constant 400
 459 breq 463
 460 acc8= constant 51
 461 call writeLineAcc8
 462 ;test5.j(76)     if (300 < 1200/(1+2)) println(52);
 463 acc16= constant 1200
 464 acc8= constant 1
 465 acc8+ constant 2
 466 acc16/ acc8
 467 acc16Comp constant 300
 468 brle 472
 469 acc8= constant 52
 470 call writeLineAcc8
 471 ;test5.j(77)     if (300 < 400) println(53);
 472 acc16= constant 300
 473 acc16Comp constant 400
 474 brge 478
 475 acc8= constant 53
 476 call writeLineAcc8
 477 ;test5.j(78)     if (500 > 1200/(1+2)) println(54);
 478 acc16= constant 1200
 479 acc8= constant 1
 480 acc8+ constant 2
 481 acc16/ acc8
 482 acc16Comp constant 500
 483 brge 487
 484 acc8= constant 54
 485 call writeLineAcc8
 486 ;test5.j(79)     if (500 > 400) println(55);
 487 acc16= constant 500
 488 acc16Comp constant 400
 489 brle 493
 490 acc8= constant 55
 491 call writeLineAcc8
 492 ;test5.j(80)     if (300 <= 1200/(1+2)) println(56);
 493 acc16= constant 1200
 494 acc8= constant 1
 495 acc8+ constant 2
 496 acc16/ acc8
 497 acc16Comp constant 300
 498 brlt 502
 499 acc8= constant 56
 500 call writeLineAcc8
 501 ;test5.j(81)     if (300 <= 400) println(57);
 502 acc16= constant 300
 503 acc16Comp constant 400
 504 brgt 508
 505 acc8= constant 57
 506 call writeLineAcc8
 507 ;test5.j(82)     if (400 <= 1200/(1+2)) println(58);
 508 acc16= constant 1200
 509 acc8= constant 1
 510 acc8+ constant 2
 511 acc16/ acc8
 512 acc16Comp constant 400
 513 brlt 517
 514 acc8= constant 58
 515 call writeLineAcc8
 516 ;test5.j(83)     if (400 <= 400) println(59);
 517 acc16= constant 400
 518 acc16Comp constant 400
 519 brgt 523
 520 acc8= constant 59
 521 call writeLineAcc8
 522 ;test5.j(84)     if (500 >= 1200/(1+2)) println(60);
 523 acc16= constant 1200
 524 acc8= constant 1
 525 acc8+ constant 2
 526 acc16/ acc8
 527 acc16Comp constant 500
 528 brgt 532
 529 acc8= constant 60
 530 call writeLineAcc8
 531 ;test5.j(85)     if (500 >= 400) println(61);
 532 acc16= constant 500
 533 acc16Comp constant 400
 534 brlt 538
 535 acc8= constant 61
 536 call writeLineAcc8
 537 ;test5.j(86)     if (400 >= 1200/(1+2)) println(62);
 538 acc16= constant 1200
 539 acc8= constant 1
 540 acc8+ constant 2
 541 acc16/ acc8
 542 acc16Comp constant 400
 543 brgt 547
 544 acc8= constant 62
 545 call writeLineAcc8
 546 ;test5.j(87)     if (400 >= 400) println(63);
 547 acc16= constant 400
 548 acc16Comp constant 400
 549 brlt 555
 550 acc8= constant 63
 551 call writeLineAcc8
 552 ;test5.j(88)   
 553 ;test5.j(89)     //stack level 2
 554 ;test5.j(90)     if (one+three == 12/(1+2)) println(64);
 555 acc16= variable 2
 556 acc16+ variable 4
 557 <acc16
 558 acc8= constant 12
 559 <acc8= constant 1
 560 acc8+ constant 2
 561 /acc8 unstack8
 562 acc16= unstack16
 563 acc16CompareAcc8
 564 brne 568
 565 acc8= constant 64
 566 call writeLineAcc8
 567 ;test5.j(91)     if (one+four  != 12/(1+2)) println(65);
 568 acc16= variable 2
 569 acc16+ variable 6
 570 <acc16
 571 acc8= constant 12
 572 <acc8= constant 1
 573 acc8+ constant 2
 574 /acc8 unstack8
 575 acc16= unstack16
 576 acc16CompareAcc8
 577 breq 581
 578 acc8= constant 65
 579 call writeLineAcc8
 580 ;test5.j(92)     if (one+one < 12/(1+2)) println(66);
 581 acc16= variable 2
 582 acc16+ variable 2
 583 <acc16
 584 acc8= constant 12
 585 <acc8= constant 1
 586 acc8+ constant 2
 587 /acc8 unstack8
 588 acc16= unstack16
 589 acc16CompareAcc8
 590 brge 594
 591 acc8= constant 66
 592 call writeLineAcc8
 593 ;test5.j(93)     if (one+four > 12/(1+2)) println(67);
 594 acc16= variable 2
 595 acc16+ variable 6
 596 <acc16
 597 acc8= constant 12
 598 <acc8= constant 1
 599 acc8+ constant 2
 600 /acc8 unstack8
 601 acc16= unstack16
 602 acc16CompareAcc8
 603 brle 607
 604 acc8= constant 67
 605 call writeLineAcc8
 606 ;test5.j(94)     if (one+one <= 12/(1+2)) println(68);
 607 acc16= variable 2
 608 acc16+ variable 2
 609 <acc16
 610 acc8= constant 12
 611 <acc8= constant 1
 612 acc8+ constant 2
 613 /acc8 unstack8
 614 acc16= unstack16
 615 acc16CompareAcc8
 616 brgt 620
 617 acc8= constant 68
 618 call writeLineAcc8
 619 ;test5.j(95)     if (one+three <= 12/(1+2)) println(69);
 620 acc16= variable 2
 621 acc16+ variable 4
 622 <acc16
 623 acc8= constant 12
 624 <acc8= constant 1
 625 acc8+ constant 2
 626 /acc8 unstack8
 627 acc16= unstack16
 628 acc16CompareAcc8
 629 brgt 633
 630 acc8= constant 69
 631 call writeLineAcc8
 632 ;test5.j(96)     if (one+three >= 12/(1+2)) println(70);
 633 acc16= variable 2
 634 acc16+ variable 4
 635 <acc16
 636 acc8= constant 12
 637 <acc8= constant 1
 638 acc8+ constant 2
 639 /acc8 unstack8
 640 acc16= unstack16
 641 acc16CompareAcc8
 642 brlt 646
 643 acc8= constant 70
 644 call writeLineAcc8
 645 ;test5.j(97)     if (one+four >= 12/(1+2)) println(71);
 646 acc16= variable 2
 647 acc16+ variable 6
 648 <acc16
 649 acc8= constant 12
 650 <acc8= constant 1
 651 acc8+ constant 2
 652 /acc8 unstack8
 653 acc16= unstack16
 654 acc16CompareAcc8
 655 brlt 659
 656 acc8= constant 71
 657 call writeLineAcc8
 658 ;test5.j(98)     if (one+three == twelve/(one+2)) println(72);
 659 acc16= variable 2
 660 acc16+ variable 4
 661 <acc16
 662 acc16= variable 10
 663 <acc16= variable 2
 664 acc16+ constant 2
 665 /acc16 unstack16
 666 revAcc16Comp unstack16
 667 brne 671
 668 acc8= constant 72
 669 call writeLineAcc8
 670 ;test5.j(99)     if (one+four  != twelve/(one+2)) println(73);
 671 acc16= variable 2
 672 acc16+ variable 6
 673 <acc16
 674 acc16= variable 10
 675 <acc16= variable 2
 676 acc16+ constant 2
 677 /acc16 unstack16
 678 revAcc16Comp unstack16
 679 breq 683
 680 acc8= constant 73
 681 call writeLineAcc8
 682 ;test5.j(100)     if (one+one < twelve/(one+2)) println(74);
 683 acc16= variable 2
 684 acc16+ variable 2
 685 <acc16
 686 acc16= variable 10
 687 <acc16= variable 2
 688 acc16+ constant 2
 689 /acc16 unstack16
 690 revAcc16Comp unstack16
 691 brle 695
 692 acc8= constant 74
 693 call writeLineAcc8
 694 ;test5.j(101)     if (one+four > twelve/(one+2)) println(75);
 695 acc16= variable 2
 696 acc16+ variable 6
 697 <acc16
 698 acc16= variable 10
 699 <acc16= variable 2
 700 acc16+ constant 2
 701 /acc16 unstack16
 702 revAcc16Comp unstack16
 703 brge 707
 704 acc8= constant 75
 705 call writeLineAcc8
 706 ;test5.j(102)     if (one+one <= twelve/(one+2)) println(76);
 707 acc16= variable 2
 708 acc16+ variable 2
 709 <acc16
 710 acc16= variable 10
 711 <acc16= variable 2
 712 acc16+ constant 2
 713 /acc16 unstack16
 714 revAcc16Comp unstack16
 715 brlt 719
 716 acc8= constant 76
 717 call writeLineAcc8
 718 ;test5.j(103)     if (one+three <= twelve/(one+2)) println(77);
 719 acc16= variable 2
 720 acc16+ variable 4
 721 <acc16
 722 acc16= variable 10
 723 <acc16= variable 2
 724 acc16+ constant 2
 725 /acc16 unstack16
 726 revAcc16Comp unstack16
 727 brlt 731
 728 acc8= constant 77
 729 call writeLineAcc8
 730 ;test5.j(104)     if (one+three >= twelve/(one+2)) println(78);
 731 acc16= variable 2
 732 acc16+ variable 4
 733 <acc16
 734 acc16= variable 10
 735 <acc16= variable 2
 736 acc16+ constant 2
 737 /acc16 unstack16
 738 revAcc16Comp unstack16
 739 brgt 743
 740 acc8= constant 78
 741 call writeLineAcc8
 742 ;test5.j(105)     if (one+four >= twelve/(one+2)) println(79);
 743 acc16= variable 2
 744 acc16+ variable 6
 745 <acc16
 746 acc16= variable 10
 747 <acc16= variable 2
 748 acc16+ constant 2
 749 /acc16 unstack16
 750 revAcc16Comp unstack16
 751 brgt 755
 752 acc8= constant 79
 753 call writeLineAcc8
 754 ;test5.j(106)     if (four == 12/(1+2)) println(80);
 755 acc8= constant 12
 756 <acc8= constant 1
 757 acc8+ constant 2
 758 /acc8 unstack8
 759 acc16= variable 6
 760 acc16CompareAcc8
 761 brne 765
 762 acc8= constant 80
 763 call writeLineAcc8
 764 ;test5.j(107)     if (three != 12/(1+2)) println(81);
 765 acc8= constant 12
 766 <acc8= constant 1
 767 acc8+ constant 2
 768 /acc8 unstack8
 769 acc16= variable 4
 770 acc16CompareAcc8
 771 breq 775
 772 acc8= constant 81
 773 call writeLineAcc8
 774 ;test5.j(108)     if (three < 12/(1+2)) println(82);
 775 acc8= constant 12
 776 <acc8= constant 1
 777 acc8+ constant 2
 778 /acc8 unstack8
 779 acc16= variable 4
 780 acc16CompareAcc8
 781 brge 785
 782 acc8= constant 82
 783 call writeLineAcc8
 784 ;test5.j(109)     if (twelve > 12/(1+2)) println(83);
 785 acc8= constant 12
 786 <acc8= constant 1
 787 acc8+ constant 2
 788 /acc8 unstack8
 789 acc16= variable 10
 790 acc16CompareAcc8
 791 brle 795
 792 acc8= constant 83
 793 call writeLineAcc8
 794 ;test5.j(110)     if (four <= 12/(1+2)) println(84);
 795 acc8= constant 12
 796 <acc8= constant 1
 797 acc8+ constant 2
 798 /acc8 unstack8
 799 acc16= variable 6
 800 acc16CompareAcc8
 801 brgt 805
 802 acc8= constant 84
 803 call writeLineAcc8
 804 ;test5.j(111)     if (three <= 12/(1+2)) println(85);
 805 acc8= constant 12
 806 <acc8= constant 1
 807 acc8+ constant 2
 808 /acc8 unstack8
 809 acc16= variable 4
 810 acc16CompareAcc8
 811 brgt 815
 812 acc8= constant 85
 813 call writeLineAcc8
 814 ;test5.j(112)     if (four >= 12/(1+2)) println(86);
 815 acc8= constant 12
 816 <acc8= constant 1
 817 acc8+ constant 2
 818 /acc8 unstack8
 819 acc16= variable 6
 820 acc16CompareAcc8
 821 brlt 825
 822 acc8= constant 86
 823 call writeLineAcc8
 824 ;test5.j(113)     if (twelve >= 12/(1+2)) println(87);
 825 acc8= constant 12
 826 <acc8= constant 1
 827 acc8+ constant 2
 828 /acc8 unstack8
 829 acc16= variable 10
 830 acc16CompareAcc8
 831 brlt 835
 832 acc8= constant 87
 833 call writeLineAcc8
 834 ;test5.j(114)     if (four == twelve/(one+2)) println(88);
 835 acc16= variable 10
 836 <acc16= variable 2
 837 acc16+ constant 2
 838 /acc16 unstack16
 839 acc16Comp variable 6
 840 brne 844
 841 acc8= constant 88
 842 call writeLineAcc8
 843 ;test5.j(115)     if (three != twelve/(one+2)) println(89);
 844 acc16= variable 10
 845 <acc16= variable 2
 846 acc16+ constant 2
 847 /acc16 unstack16
 848 acc16Comp variable 4
 849 breq 853
 850 acc8= constant 89
 851 call writeLineAcc8
 852 ;test5.j(116)     if (three < twelve/(one+2)) println(90);
 853 acc16= variable 10
 854 <acc16= variable 2
 855 acc16+ constant 2
 856 /acc16 unstack16
 857 acc16Comp variable 4
 858 brle 862
 859 acc8= constant 90
 860 call writeLineAcc8
 861 ;test5.j(117)     if (twelve > twelve/(one+2)) println(91);
 862 acc16= variable 10
 863 <acc16= variable 2
 864 acc16+ constant 2
 865 /acc16 unstack16
 866 acc16Comp variable 10
 867 brge 871
 868 acc8= constant 91
 869 call writeLineAcc8
 870 ;test5.j(118)     if (four <= twelve/(one+2)) println(92);
 871 acc16= variable 10
 872 <acc16= variable 2
 873 acc16+ constant 2
 874 /acc16 unstack16
 875 acc16Comp variable 6
 876 brlt 880
 877 acc8= constant 92
 878 call writeLineAcc8
 879 ;test5.j(119)     if (three <= twelve/(one+2)) println(93);
 880 acc16= variable 10
 881 <acc16= variable 2
 882 acc16+ constant 2
 883 /acc16 unstack16
 884 acc16Comp variable 4
 885 brlt 889
 886 acc8= constant 93
 887 call writeLineAcc8
 888 ;test5.j(120)     if (four >= twelve/(one+2)) println(94);
 889 acc16= variable 10
 890 <acc16= variable 2
 891 acc16+ constant 2
 892 /acc16 unstack16
 893 acc16Comp variable 6
 894 brgt 898
 895 acc8= constant 94
 896 call writeLineAcc8
 897 ;test5.j(121)     if (twelve >= twelve/(one+2)) println(95);
 898 acc16= variable 10
 899 <acc16= variable 2
 900 acc16+ constant 2
 901 /acc16 unstack16
 902 acc16Comp variable 10
 903 brgt 907
 904 acc8= constant 95
 905 call writeLineAcc8
 906 ;test5.j(122)     if (1+3 == 12/(1+2)) println(96);
 907 acc8= constant 1
 908 acc8+ constant 3
 909 <acc8
 910 acc8= constant 12
 911 <acc8= constant 1
 912 acc8+ constant 2
 913 /acc8 unstack8
 914 revAcc8Comp unstack8
 915 brne 919
 916 acc8= constant 96
 917 call writeLineAcc8
 918 ;test5.j(123)     if (1+2 != 12/(1+2)) println(97);
 919 acc8= constant 1
 920 acc8+ constant 2
 921 <acc8
 922 acc8= constant 12
 923 <acc8= constant 1
 924 acc8+ constant 2
 925 /acc8 unstack8
 926 revAcc8Comp unstack8
 927 breq 931
 928 acc8= constant 97
 929 call writeLineAcc8
 930 ;test5.j(124)     if (1+2 < 12/(1+2)) println(98);
 931 acc8= constant 1
 932 acc8+ constant 2
 933 <acc8
 934 acc8= constant 12
 935 <acc8= constant 1
 936 acc8+ constant 2
 937 /acc8 unstack8
 938 revAcc8Comp unstack8
 939 brle 943
 940 acc8= constant 98
 941 call writeLineAcc8
 942 ;test5.j(125)     if (1+4 > 12/(1+2)) println(99);
 943 acc8= constant 1
 944 acc8+ constant 4
 945 <acc8
 946 acc8= constant 12
 947 <acc8= constant 1
 948 acc8+ constant 2
 949 /acc8 unstack8
 950 revAcc8Comp unstack8
 951 brge 955
 952 acc8= constant 99
 953 call writeLineAcc8
 954 ;test5.j(126)     if (1+2 <= 12/(1+2)) println(100);
 955 acc8= constant 1
 956 acc8+ constant 2
 957 <acc8
 958 acc8= constant 12
 959 <acc8= constant 1
 960 acc8+ constant 2
 961 /acc8 unstack8
 962 revAcc8Comp unstack8
 963 brlt 967
 964 acc8= constant 100
 965 call writeLineAcc8
 966 ;test5.j(127)     if (1+3 <= 12/(1+2)) println(101);
 967 acc8= constant 1
 968 acc8+ constant 3
 969 <acc8
 970 acc8= constant 12
 971 <acc8= constant 1
 972 acc8+ constant 2
 973 /acc8 unstack8
 974 revAcc8Comp unstack8
 975 brlt 979
 976 acc8= constant 101
 977 call writeLineAcc8
 978 ;test5.j(128)     if (1+3 >= 12/(1+2)) println(102);
 979 acc8= constant 1
 980 acc8+ constant 3
 981 <acc8
 982 acc8= constant 12
 983 <acc8= constant 1
 984 acc8+ constant 2
 985 /acc8 unstack8
 986 revAcc8Comp unstack8
 987 brgt 991
 988 acc8= constant 102
 989 call writeLineAcc8
 990 ;test5.j(129)     if (1+4 >= 12/(1+2)) println(103);
 991 acc8= constant 1
 992 acc8+ constant 4
 993 <acc8
 994 acc8= constant 12
 995 <acc8= constant 1
 996 acc8+ constant 2
 997 /acc8 unstack8
 998 revAcc8Comp unstack8
 999 brgt 1003
1000 acc8= constant 103
1001 call writeLineAcc8
1002 ;test5.j(130)     if (1+3 == twelve/(one+2)) println(104);
1003 acc8= constant 1
1004 acc8+ constant 3
1005 <acc8
1006 acc16= variable 10
1007 <acc16= variable 2
1008 acc16+ constant 2
1009 /acc16 unstack16
1010 acc8= unstack8
1011 acc8CompareAcc16
1012 brne 1016
1013 acc8= constant 104
1014 call writeLineAcc8
1015 ;test5.j(131)     if (1+2 != twelve/(one+2)) println(105);
1016 acc8= constant 1
1017 acc8+ constant 2
1018 <acc8
1019 acc16= variable 10
1020 <acc16= variable 2
1021 acc16+ constant 2
1022 /acc16 unstack16
1023 acc8= unstack8
1024 acc8CompareAcc16
1025 breq 1029
1026 acc8= constant 105
1027 call writeLineAcc8
1028 ;test5.j(132)     if (1+2 < twelve/(one+2)) println(106);
1029 acc8= constant 1
1030 acc8+ constant 2
1031 <acc8
1032 acc16= variable 10
1033 <acc16= variable 2
1034 acc16+ constant 2
1035 /acc16 unstack16
1036 acc8= unstack8
1037 acc8CompareAcc16
1038 brge 1042
1039 acc8= constant 106
1040 call writeLineAcc8
1041 ;test5.j(133)     if (1+4 > twelve/(one+2)) println(107);
1042 acc8= constant 1
1043 acc8+ constant 4
1044 <acc8
1045 acc16= variable 10
1046 <acc16= variable 2
1047 acc16+ constant 2
1048 /acc16 unstack16
1049 acc8= unstack8
1050 acc8CompareAcc16
1051 brle 1055
1052 acc8= constant 107
1053 call writeLineAcc8
1054 ;test5.j(134)     if (1+2 <= twelve/(one+2)) println(108);
1055 acc8= constant 1
1056 acc8+ constant 2
1057 <acc8
1058 acc16= variable 10
1059 <acc16= variable 2
1060 acc16+ constant 2
1061 /acc16 unstack16
1062 acc8= unstack8
1063 acc8CompareAcc16
1064 brgt 1068
1065 acc8= constant 108
1066 call writeLineAcc8
1067 ;test5.j(135)     if (1+3 <= twelve/(one+2)) println(109);
1068 acc8= constant 1
1069 acc8+ constant 3
1070 <acc8
1071 acc16= variable 10
1072 <acc16= variable 2
1073 acc16+ constant 2
1074 /acc16 unstack16
1075 acc8= unstack8
1076 acc8CompareAcc16
1077 brgt 1081
1078 acc8= constant 109
1079 call writeLineAcc8
1080 ;test5.j(136)     if (1+3 >= twelve/(one+2)) println(110);
1081 acc8= constant 1
1082 acc8+ constant 3
1083 <acc8
1084 acc16= variable 10
1085 <acc16= variable 2
1086 acc16+ constant 2
1087 /acc16 unstack16
1088 acc8= unstack8
1089 acc8CompareAcc16
1090 brlt 1094
1091 acc8= constant 110
1092 call writeLineAcc8
1093 ;test5.j(137)     if (1+4 >= twelve/(one+2)) println(111);
1094 acc8= constant 1
1095 acc8+ constant 4
1096 <acc8
1097 acc16= variable 10
1098 <acc16= variable 2
1099 acc16+ constant 2
1100 /acc16 unstack16
1101 acc8= unstack8
1102 acc8CompareAcc16
1103 brlt 1107
1104 acc8= constant 111
1105 call writeLineAcc8
1106 ;test5.j(138)     if (4 == 12/(1+2)) println(112);
1107 acc8= constant 12
1108 <acc8= constant 1
1109 acc8+ constant 2
1110 /acc8 unstack8
1111 acc8Comp constant 4
1112 brne 1116
1113 acc8= constant 112
1114 call writeLineAcc8
1115 ;test5.j(139)     if (3 != 12/(1+2)) println(113);
1116 acc8= constant 12
1117 <acc8= constant 1
1118 acc8+ constant 2
1119 /acc8 unstack8
1120 acc8Comp constant 3
1121 breq 1125
1122 acc8= constant 113
1123 call writeLineAcc8
1124 ;test5.j(140)     if (3 < 12/(1+2)) println(114);
1125 acc8= constant 12
1126 <acc8= constant 1
1127 acc8+ constant 2
1128 /acc8 unstack8
1129 acc8Comp constant 3
1130 brle 1134
1131 acc8= constant 114
1132 call writeLineAcc8
1133 ;test5.j(141)     if (5 > 12/(1+2)) println(115);
1134 acc8= constant 12
1135 <acc8= constant 1
1136 acc8+ constant 2
1137 /acc8 unstack8
1138 acc8Comp constant 5
1139 brge 1143
1140 acc8= constant 115
1141 call writeLineAcc8
1142 ;test5.j(142)     if (3 <= 12/(1+2)) println(116);
1143 acc8= constant 12
1144 <acc8= constant 1
1145 acc8+ constant 2
1146 /acc8 unstack8
1147 acc8Comp constant 3
1148 brlt 1152
1149 acc8= constant 116
1150 call writeLineAcc8
1151 ;test5.j(143)     if (4 <= 12/(1+2)) println(117);
1152 acc8= constant 12
1153 <acc8= constant 1
1154 acc8+ constant 2
1155 /acc8 unstack8
1156 acc8Comp constant 4
1157 brlt 1161
1158 acc8= constant 117
1159 call writeLineAcc8
1160 ;test5.j(144)     if (4 >= 12/(1+2)) println(118);
1161 acc8= constant 12
1162 <acc8= constant 1
1163 acc8+ constant 2
1164 /acc8 unstack8
1165 acc8Comp constant 4
1166 brgt 1170
1167 acc8= constant 118
1168 call writeLineAcc8
1169 ;test5.j(145)     if (5 >= 12/(1+2)) println(119);
1170 acc8= constant 12
1171 <acc8= constant 1
1172 acc8+ constant 2
1173 /acc8 unstack8
1174 acc8Comp constant 5
1175 brgt 1179
1176 acc8= constant 119
1177 call writeLineAcc8
1178 ;test5.j(146)     if (4 == twelve/(one+2)) println(120);
1179 acc16= variable 10
1180 <acc16= variable 2
1181 acc16+ constant 2
1182 /acc16 unstack16
1183 acc8= constant 4
1184 acc8CompareAcc16
1185 brne 1189
1186 acc8= constant 120
1187 call writeLineAcc8
1188 ;test5.j(147)     if (3 != twelve/(one+2)) println(121);
1189 acc16= variable 10
1190 <acc16= variable 2
1191 acc16+ constant 2
1192 /acc16 unstack16
1193 acc8= constant 3
1194 acc8CompareAcc16
1195 breq 1199
1196 acc8= constant 121
1197 call writeLineAcc8
1198 ;test5.j(148)     if (2 < twelve/(one+2)) println(122);
1199 acc16= variable 10
1200 <acc16= variable 2
1201 acc16+ constant 2
1202 /acc16 unstack16
1203 acc8= constant 2
1204 acc8CompareAcc16
1205 brge 1209
1206 acc8= constant 122
1207 call writeLineAcc8
1208 ;test5.j(149)     if (5 > twelve/(one+2)) println(123);
1209 acc16= variable 10
1210 <acc16= variable 2
1211 acc16+ constant 2
1212 /acc16 unstack16
1213 acc8= constant 5
1214 acc8CompareAcc16
1215 brle 1219
1216 acc8= constant 123
1217 call writeLineAcc8
1218 ;test5.j(150)     if (3 <= twelve/(one+2)) println(124);
1219 acc16= variable 10
1220 <acc16= variable 2
1221 acc16+ constant 2
1222 /acc16 unstack16
1223 acc8= constant 3
1224 acc8CompareAcc16
1225 brgt 1229
1226 acc8= constant 124
1227 call writeLineAcc8
1228 ;test5.j(151)     if (4 <= twelve/(one+2)) println(125);
1229 acc16= variable 10
1230 <acc16= variable 2
1231 acc16+ constant 2
1232 /acc16 unstack16
1233 acc8= constant 4
1234 acc8CompareAcc16
1235 brgt 1239
1236 acc8= constant 125
1237 call writeLineAcc8
1238 ;test5.j(152)     if (4 >= twelve/(one+2)) println(126);
1239 acc16= variable 10
1240 <acc16= variable 2
1241 acc16+ constant 2
1242 /acc16 unstack16
1243 acc8= constant 4
1244 acc8CompareAcc16
1245 brlt 1249
1246 acc8= constant 126
1247 call writeLineAcc8
1248 ;test5.j(153)     if (5 >= twelve/(one+2)) println(127);
1249 acc16= variable 10
1250 <acc16= variable 2
1251 acc16+ constant 2
1252 /acc16 unstack16
1253 acc8= constant 5
1254 acc8CompareAcc16
1255 brlt 1259
1256 acc8= constant 127
1257 call writeLineAcc8
1258 ;test5.j(154)     if (four == 0 + 12/(1 + 2)) println(128);
1259 acc8= constant 0
1260 <acc8= constant 12
1261 <acc8= constant 1
1262 acc8+ constant 2
1263 /acc8 unstack8
1264 acc8+ unstack8
1265 acc16= variable 6
1266 acc16CompareAcc8
1267 brne 1271
1268 acc8= constant 128
1269 call writeLineAcc8
1270 ;test5.j(155)     if (four == 0 + 12/(1 + 2)) println(129);
1271 acc8= constant 0
1272 <acc8= constant 12
1273 <acc8= constant 1
1274 acc8+ constant 2
1275 /acc8 unstack8
1276 acc8+ unstack8
1277 acc16= variable 6
1278 acc16CompareAcc8
1279 brne 1283
1280 acc8= constant 129
1281 call writeLineAcc8
1282 ;test5.j(156)     if (four == 0 + 12/(byteOne + 2)) println(130);
1283 acc8= constant 0
1284 <acc8= constant 12
1285 <acc8= variable 12
1286 acc8+ constant 2
1287 /acc8 unstack8
1288 acc8+ unstack8
1289 acc16= variable 6
1290 acc16CompareAcc8
1291 brne 1295
1292 acc8= constant 130
1293 call writeLineAcc8
1294 ;test5.j(157)     if (four == 0 + 12/(one + 2)) println(131);
1295 acc8= constant 0
1296 <acc8= constant 12
1297 acc16= variable 2
1298 acc16+ constant 2
1299 /acc16 acc8
1300 acc16+ unstack8
1301 acc16Comp variable 6
1302 brne 1306
1303 acc8= constant 131
1304 call writeLineAcc8
1305 ;test5.j(158)     if (4 == zero + twelve/(1+2)) println(132);
1306 acc16= variable 0
1307 <acc16= variable 10
1308 acc8= constant 1
1309 acc8+ constant 2
1310 acc16/ acc8
1311 acc16+ unstack16
1312 acc8= constant 4
1313 acc8CompareAcc16
1314 brne 1321
1315 acc8= constant 132
1316 call writeLineAcc8
1317 ;test5.j(159)   
1318 ;test5.j(160)     /************************/
1319 ;test5.j(161)     // global variable b used within if scope
1320 ;test5.j(162)     b = 133;
1321 acc8= constant 133
1322 acc8=> variable 14
1323 ;test5.j(163)     if (b>132) {
1324 acc8= variable 14
1325 acc8Comp constant 132
1326 brle 1344
1327 ;test5.j(164)       word j = 1001;
1328 acc16= constant 1001
1329 acc16=> variable 15
1330 ;test5.j(165)       byte c = b;
1331 acc8= variable 14
1332 acc8=> variable 17
1333 ;test5.j(166)       byte d = c;
1334 acc8= variable 17
1335 acc8=> variable 18
1336 ;test5.j(167)       b--;
1337 decr8 variable 14
1338 ;test5.j(168)       println (c);
1339 acc8= variable 17
1340 call writeLineAcc8
1341 ;test5.j(169)     } else {
1342 br 1350
1343 ;test5.j(170)       println(999);
1344 acc16= constant 999
1345 call writeLineAcc16
1346 ;test5.j(171)     }
1347 ;test5.j(172)   
1348 ;test5.j(173)     /************************/
1349 ;test5.j(174)     println (134);
1350 acc8= constant 134
1351 call writeLineAcc8
1352 ;test5.j(175)     println("Klaar");
1353 acc16= constant 1359
1354 writeLineString
1355 ;test5.j(176)   }
1356 ;test5.j(177) }
1357 ;test5.j(178) //comment after final }.
1358 stop
1359 stringConstant 0 = "Klaar"
