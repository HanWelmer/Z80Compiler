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
  32 method main [publicLexeme, staticLexeme] voidLexeme
  33 ;test5.j(16)     //stack level 1
  34 ;test5.j(17)     //byte-byte
  35 ;test5.j(18)     if (4 == 12/(1+2)) println(0);
  36 acc8= constant 12
  37 <acc8= constant 1
  38 acc8+ constant 2
  39 /acc8 unstack8
  40 acc8Comp constant 4
  41 brne 45
  42 acc8= constant 0
  43 call writeLineAcc8
  44 ;test5.j(19)     if (4 == 4) println(1);
  45 acc8= constant 4
  46 acc8Comp constant 4
  47 brne 51
  48 acc8= constant 1
  49 call writeLineAcc8
  50 ;test5.j(20)     if (3 != 12/(1+2)) println(2);
  51 acc8= constant 12
  52 <acc8= constant 1
  53 acc8+ constant 2
  54 /acc8 unstack8
  55 acc8Comp constant 3
  56 breq 60
  57 acc8= constant 2
  58 call writeLineAcc8
  59 ;test5.j(21)     if (3 != 4) println(3);
  60 acc8= constant 3
  61 acc8Comp constant 4
  62 breq 66
  63 acc8= constant 3
  64 call writeLineAcc8
  65 ;test5.j(22)     if (3 < 12/(1+2)) println(4);
  66 acc8= constant 12
  67 <acc8= constant 1
  68 acc8+ constant 2
  69 /acc8 unstack8
  70 acc8Comp constant 3
  71 brle 75
  72 acc8= constant 4
  73 call writeLineAcc8
  74 ;test5.j(23)     if (3 < 4) println(5);
  75 acc8= constant 3
  76 acc8Comp constant 4
  77 brge 81
  78 acc8= constant 5
  79 call writeLineAcc8
  80 ;test5.j(24)     if (5 > 12/(1+2)) println(6);
  81 acc8= constant 12
  82 <acc8= constant 1
  83 acc8+ constant 2
  84 /acc8 unstack8
  85 acc8Comp constant 5
  86 brge 90
  87 acc8= constant 6
  88 call writeLineAcc8
  89 ;test5.j(25)     if (5 > 4) println(7);
  90 acc8= constant 5
  91 acc8Comp constant 4
  92 brle 96
  93 acc8= constant 7
  94 call writeLineAcc8
  95 ;test5.j(26)     if (3 <= 12/(1+2)) println(8);
  96 acc8= constant 12
  97 <acc8= constant 1
  98 acc8+ constant 2
  99 /acc8 unstack8
 100 acc8Comp constant 3
 101 brlt 105
 102 acc8= constant 8
 103 call writeLineAcc8
 104 ;test5.j(27)     if (3 <= 4) println(9);
 105 acc8= constant 3
 106 acc8Comp constant 4
 107 brgt 111
 108 acc8= constant 9
 109 call writeLineAcc8
 110 ;test5.j(28)     if (4 <= 12/(1+2)) println(10);
 111 acc8= constant 12
 112 <acc8= constant 1
 113 acc8+ constant 2
 114 /acc8 unstack8
 115 acc8Comp constant 4
 116 brlt 120
 117 acc8= constant 10
 118 call writeLineAcc8
 119 ;test5.j(29)     if (4 <= 4) println(11);
 120 acc8= constant 4
 121 acc8Comp constant 4
 122 brgt 126
 123 acc8= constant 11
 124 call writeLineAcc8
 125 ;test5.j(30)     if (5 >= 12/(1+2)) println(12);
 126 acc8= constant 12
 127 <acc8= constant 1
 128 acc8+ constant 2
 129 /acc8 unstack8
 130 acc8Comp constant 5
 131 brgt 135
 132 acc8= constant 12
 133 call writeLineAcc8
 134 ;test5.j(31)     if (5 >= 4) println(13);
 135 acc8= constant 5
 136 acc8Comp constant 4
 137 brlt 141
 138 acc8= constant 13
 139 call writeLineAcc8
 140 ;test5.j(32)     if (4 >= 12/(1+2)) println(14);
 141 acc8= constant 12
 142 <acc8= constant 1
 143 acc8+ constant 2
 144 /acc8 unstack8
 145 acc8Comp constant 4
 146 brgt 150
 147 acc8= constant 14
 148 call writeLineAcc8
 149 ;test5.j(33)     if (4 >= 4) println(15);
 150 acc8= constant 4
 151 acc8Comp constant 4
 152 brlt 158
 153 acc8= constant 15
 154 call writeLineAcc8
 155 ;test5.j(34)     //stack level 1
 156 ;test5.j(35)     //byte-integer
 157 ;test5.j(36)     if (4 == twelve/(1+2)) println(16);
 158 acc16= variable 10
 159 acc8= constant 1
 160 acc8+ constant 2
 161 acc16/ acc8
 162 acc8= constant 4
 163 acc8CompareAcc16
 164 brne 168
 165 acc8= constant 16
 166 call writeLineAcc8
 167 ;test5.j(37)     if (4 == four) println(17);
 168 acc16= variable 6
 169 acc8= constant 4
 170 acc8CompareAcc16
 171 brne 175
 172 acc8= constant 17
 173 call writeLineAcc8
 174 ;test5.j(38)     if (3 != twelve/(1+2)) println(18);
 175 acc16= variable 10
 176 acc8= constant 1
 177 acc8+ constant 2
 178 acc16/ acc8
 179 acc8= constant 3
 180 acc8CompareAcc16
 181 breq 185
 182 acc8= constant 18
 183 call writeLineAcc8
 184 ;test5.j(39)     if (3 != four) println(19);
 185 acc16= variable 6
 186 acc8= constant 3
 187 acc8CompareAcc16
 188 breq 192
 189 acc8= constant 19
 190 call writeLineAcc8
 191 ;test5.j(40)     if (3 < twelve/(1+2)) println(20);
 192 acc16= variable 10
 193 acc8= constant 1
 194 acc8+ constant 2
 195 acc16/ acc8
 196 acc8= constant 3
 197 acc8CompareAcc16
 198 brge 202
 199 acc8= constant 20
 200 call writeLineAcc8
 201 ;test5.j(41)     if (3 < four) println(21);
 202 acc16= variable 6
 203 acc8= constant 3
 204 acc8CompareAcc16
 205 brge 209
 206 acc8= constant 21
 207 call writeLineAcc8
 208 ;test5.j(42)     if (5 > twelve/(1+2)) println(22);
 209 acc16= variable 10
 210 acc8= constant 1
 211 acc8+ constant 2
 212 acc16/ acc8
 213 acc8= constant 5
 214 acc8CompareAcc16
 215 brle 219
 216 acc8= constant 22
 217 call writeLineAcc8
 218 ;test5.j(43)     if (5 > four) println(23);
 219 acc16= variable 6
 220 acc8= constant 5
 221 acc8CompareAcc16
 222 brle 226
 223 acc8= constant 23
 224 call writeLineAcc8
 225 ;test5.j(44)     if (3 <= twelve/(1+2)) println(24);
 226 acc16= variable 10
 227 acc8= constant 1
 228 acc8+ constant 2
 229 acc16/ acc8
 230 acc8= constant 3
 231 acc8CompareAcc16
 232 brgt 236
 233 acc8= constant 24
 234 call writeLineAcc8
 235 ;test5.j(45)     if (3 <= four) println(25);
 236 acc16= variable 6
 237 acc8= constant 3
 238 acc8CompareAcc16
 239 brgt 243
 240 acc8= constant 25
 241 call writeLineAcc8
 242 ;test5.j(46)     if (4 <= twelve/(1+2)) println(26);
 243 acc16= variable 10
 244 acc8= constant 1
 245 acc8+ constant 2
 246 acc16/ acc8
 247 acc8= constant 4
 248 acc8CompareAcc16
 249 brgt 253
 250 acc8= constant 26
 251 call writeLineAcc8
 252 ;test5.j(47)     if (4 <= four) println(27);
 253 acc16= variable 6
 254 acc8= constant 4
 255 acc8CompareAcc16
 256 brgt 260
 257 acc8= constant 27
 258 call writeLineAcc8
 259 ;test5.j(48)     if (5 >= twelve/(1+2)) println(28);
 260 acc16= variable 10
 261 acc8= constant 1
 262 acc8+ constant 2
 263 acc16/ acc8
 264 acc8= constant 5
 265 acc8CompareAcc16
 266 brlt 270
 267 acc8= constant 28
 268 call writeLineAcc8
 269 ;test5.j(49)     if (5 >= four) println(29);
 270 acc16= variable 6
 271 acc8= constant 5
 272 acc8CompareAcc16
 273 brlt 277
 274 acc8= constant 29
 275 call writeLineAcc8
 276 ;test5.j(50)     if (4 >= twelve/(1+2)) println(30);
 277 acc16= variable 10
 278 acc8= constant 1
 279 acc8+ constant 2
 280 acc16/ acc8
 281 acc8= constant 4
 282 acc8CompareAcc16
 283 brlt 287
 284 acc8= constant 30
 285 call writeLineAcc8
 286 ;test5.j(51)     if (4 >= four) println(31);
 287 acc16= variable 6
 288 acc8= constant 4
 289 acc8CompareAcc16
 290 brlt 296
 291 acc8= constant 31
 292 call writeLineAcc8
 293 ;test5.j(52)     //stack level 1
 294 ;test5.j(53)     //integer-byte
 295 ;test5.j(54)     if (four == 12/(1+2)) println(32);
 296 acc8= constant 12
 297 <acc8= constant 1
 298 acc8+ constant 2
 299 /acc8 unstack8
 300 acc16= variable 6
 301 acc16CompareAcc8
 302 brne 306
 303 acc8= constant 32
 304 call writeLineAcc8
 305 ;test5.j(55)     if (four == 4) println(33);
 306 acc16= variable 6
 307 acc8= constant 4
 308 acc16CompareAcc8
 309 brne 313
 310 acc8= constant 33
 311 call writeLineAcc8
 312 ;test5.j(56)     if (three != 12/(1+2)) println(34);
 313 acc8= constant 12
 314 <acc8= constant 1
 315 acc8+ constant 2
 316 /acc8 unstack8
 317 acc16= variable 4
 318 acc16CompareAcc8
 319 breq 323
 320 acc8= constant 34
 321 call writeLineAcc8
 322 ;test5.j(57)     if (three != 4) println(35);
 323 acc16= variable 4
 324 acc8= constant 4
 325 acc16CompareAcc8
 326 breq 330
 327 acc8= constant 35
 328 call writeLineAcc8
 329 ;test5.j(58)     if (three < 12/(1+2)) println(36);
 330 acc8= constant 12
 331 <acc8= constant 1
 332 acc8+ constant 2
 333 /acc8 unstack8
 334 acc16= variable 4
 335 acc16CompareAcc8
 336 brge 340
 337 acc8= constant 36
 338 call writeLineAcc8
 339 ;test5.j(59)     if (three < 4) println(37);
 340 acc16= variable 4
 341 acc8= constant 4
 342 acc16CompareAcc8
 343 brge 347
 344 acc8= constant 37
 345 call writeLineAcc8
 346 ;test5.j(60)     if (five > 12/(1+2)) println(38);
 347 acc8= constant 12
 348 <acc8= constant 1
 349 acc8+ constant 2
 350 /acc8 unstack8
 351 acc16= variable 8
 352 acc16CompareAcc8
 353 brle 357
 354 acc8= constant 38
 355 call writeLineAcc8
 356 ;test5.j(61)     if (five > 4) println(39);
 357 acc16= variable 8
 358 acc8= constant 4
 359 acc16CompareAcc8
 360 brle 364
 361 acc8= constant 39
 362 call writeLineAcc8
 363 ;test5.j(62)     if (three <= 12/(1+2)) println(40);
 364 acc8= constant 12
 365 <acc8= constant 1
 366 acc8+ constant 2
 367 /acc8 unstack8
 368 acc16= variable 4
 369 acc16CompareAcc8
 370 brgt 374
 371 acc8= constant 40
 372 call writeLineAcc8
 373 ;test5.j(63)     if (three <= 4) println(41);
 374 acc16= variable 4
 375 acc8= constant 4
 376 acc16CompareAcc8
 377 brgt 381
 378 acc8= constant 41
 379 call writeLineAcc8
 380 ;test5.j(64)     if (four <= 12/(1+2)) println(42);
 381 acc8= constant 12
 382 <acc8= constant 1
 383 acc8+ constant 2
 384 /acc8 unstack8
 385 acc16= variable 6
 386 acc16CompareAcc8
 387 brgt 391
 388 acc8= constant 42
 389 call writeLineAcc8
 390 ;test5.j(65)     if (four <= 4) println(43);
 391 acc16= variable 6
 392 acc8= constant 4
 393 acc16CompareAcc8
 394 brgt 398
 395 acc8= constant 43
 396 call writeLineAcc8
 397 ;test5.j(66)     if (five >= 12/(1+2)) println(44);
 398 acc8= constant 12
 399 <acc8= constant 1
 400 acc8+ constant 2
 401 /acc8 unstack8
 402 acc16= variable 8
 403 acc16CompareAcc8
 404 brlt 408
 405 acc8= constant 44
 406 call writeLineAcc8
 407 ;test5.j(67)     if (five >= 4) println(45);
 408 acc16= variable 8
 409 acc8= constant 4
 410 acc16CompareAcc8
 411 brlt 415
 412 acc8= constant 45
 413 call writeLineAcc8
 414 ;test5.j(68)     if (four >= 12/(1+2)) println(46);
 415 acc8= constant 12
 416 <acc8= constant 1
 417 acc8+ constant 2
 418 /acc8 unstack8
 419 acc16= variable 6
 420 acc16CompareAcc8
 421 brlt 425
 422 acc8= constant 46
 423 call writeLineAcc8
 424 ;test5.j(69)     if (four >= 4) println(47);
 425 acc16= variable 6
 426 acc8= constant 4
 427 acc16CompareAcc8
 428 brlt 434
 429 acc8= constant 47
 430 call writeLineAcc8
 431 ;test5.j(70)     //stack level 1
 432 ;test5.j(71)     //integer-integer
 433 ;test5.j(72)     if (400 == 1200/(1+2)) println(48);
 434 acc16= constant 1200
 435 acc8= constant 1
 436 acc8+ constant 2
 437 acc16/ acc8
 438 acc16Comp constant 400
 439 brne 443
 440 acc8= constant 48
 441 call writeLineAcc8
 442 ;test5.j(73)     if (400 == 400) println(49);
 443 acc16= constant 400
 444 acc16Comp constant 400
 445 brne 449
 446 acc8= constant 49
 447 call writeLineAcc8
 448 ;test5.j(74)     if (300 != 1200/(1+2)) println(50);
 449 acc16= constant 1200
 450 acc8= constant 1
 451 acc8+ constant 2
 452 acc16/ acc8
 453 acc16Comp constant 300
 454 breq 458
 455 acc8= constant 50
 456 call writeLineAcc8
 457 ;test5.j(75)     if (300 != 400) println(51);
 458 acc16= constant 300
 459 acc16Comp constant 400
 460 breq 464
 461 acc8= constant 51
 462 call writeLineAcc8
 463 ;test5.j(76)     if (300 < 1200/(1+2)) println(52);
 464 acc16= constant 1200
 465 acc8= constant 1
 466 acc8+ constant 2
 467 acc16/ acc8
 468 acc16Comp constant 300
 469 brle 473
 470 acc8= constant 52
 471 call writeLineAcc8
 472 ;test5.j(77)     if (300 < 400) println(53);
 473 acc16= constant 300
 474 acc16Comp constant 400
 475 brge 479
 476 acc8= constant 53
 477 call writeLineAcc8
 478 ;test5.j(78)     if (500 > 1200/(1+2)) println(54);
 479 acc16= constant 1200
 480 acc8= constant 1
 481 acc8+ constant 2
 482 acc16/ acc8
 483 acc16Comp constant 500
 484 brge 488
 485 acc8= constant 54
 486 call writeLineAcc8
 487 ;test5.j(79)     if (500 > 400) println(55);
 488 acc16= constant 500
 489 acc16Comp constant 400
 490 brle 494
 491 acc8= constant 55
 492 call writeLineAcc8
 493 ;test5.j(80)     if (300 <= 1200/(1+2)) println(56);
 494 acc16= constant 1200
 495 acc8= constant 1
 496 acc8+ constant 2
 497 acc16/ acc8
 498 acc16Comp constant 300
 499 brlt 503
 500 acc8= constant 56
 501 call writeLineAcc8
 502 ;test5.j(81)     if (300 <= 400) println(57);
 503 acc16= constant 300
 504 acc16Comp constant 400
 505 brgt 509
 506 acc8= constant 57
 507 call writeLineAcc8
 508 ;test5.j(82)     if (400 <= 1200/(1+2)) println(58);
 509 acc16= constant 1200
 510 acc8= constant 1
 511 acc8+ constant 2
 512 acc16/ acc8
 513 acc16Comp constant 400
 514 brlt 518
 515 acc8= constant 58
 516 call writeLineAcc8
 517 ;test5.j(83)     if (400 <= 400) println(59);
 518 acc16= constant 400
 519 acc16Comp constant 400
 520 brgt 524
 521 acc8= constant 59
 522 call writeLineAcc8
 523 ;test5.j(84)     if (500 >= 1200/(1+2)) println(60);
 524 acc16= constant 1200
 525 acc8= constant 1
 526 acc8+ constant 2
 527 acc16/ acc8
 528 acc16Comp constant 500
 529 brgt 533
 530 acc8= constant 60
 531 call writeLineAcc8
 532 ;test5.j(85)     if (500 >= 400) println(61);
 533 acc16= constant 500
 534 acc16Comp constant 400
 535 brlt 539
 536 acc8= constant 61
 537 call writeLineAcc8
 538 ;test5.j(86)     if (400 >= 1200/(1+2)) println(62);
 539 acc16= constant 1200
 540 acc8= constant 1
 541 acc8+ constant 2
 542 acc16/ acc8
 543 acc16Comp constant 400
 544 brgt 548
 545 acc8= constant 62
 546 call writeLineAcc8
 547 ;test5.j(87)     if (400 >= 400) println(63);
 548 acc16= constant 400
 549 acc16Comp constant 400
 550 brlt 556
 551 acc8= constant 63
 552 call writeLineAcc8
 553 ;test5.j(88)   
 554 ;test5.j(89)     //stack level 2
 555 ;test5.j(90)     if (one+three == 12/(1+2)) println(64);
 556 acc16= variable 2
 557 acc16+ variable 4
 558 <acc16
 559 acc8= constant 12
 560 <acc8= constant 1
 561 acc8+ constant 2
 562 /acc8 unstack8
 563 acc16= unstack16
 564 acc16CompareAcc8
 565 brne 569
 566 acc8= constant 64
 567 call writeLineAcc8
 568 ;test5.j(91)     if (one+four  != 12/(1+2)) println(65);
 569 acc16= variable 2
 570 acc16+ variable 6
 571 <acc16
 572 acc8= constant 12
 573 <acc8= constant 1
 574 acc8+ constant 2
 575 /acc8 unstack8
 576 acc16= unstack16
 577 acc16CompareAcc8
 578 breq 582
 579 acc8= constant 65
 580 call writeLineAcc8
 581 ;test5.j(92)     if (one+one < 12/(1+2)) println(66);
 582 acc16= variable 2
 583 acc16+ variable 2
 584 <acc16
 585 acc8= constant 12
 586 <acc8= constant 1
 587 acc8+ constant 2
 588 /acc8 unstack8
 589 acc16= unstack16
 590 acc16CompareAcc8
 591 brge 595
 592 acc8= constant 66
 593 call writeLineAcc8
 594 ;test5.j(93)     if (one+four > 12/(1+2)) println(67);
 595 acc16= variable 2
 596 acc16+ variable 6
 597 <acc16
 598 acc8= constant 12
 599 <acc8= constant 1
 600 acc8+ constant 2
 601 /acc8 unstack8
 602 acc16= unstack16
 603 acc16CompareAcc8
 604 brle 608
 605 acc8= constant 67
 606 call writeLineAcc8
 607 ;test5.j(94)     if (one+one <= 12/(1+2)) println(68);
 608 acc16= variable 2
 609 acc16+ variable 2
 610 <acc16
 611 acc8= constant 12
 612 <acc8= constant 1
 613 acc8+ constant 2
 614 /acc8 unstack8
 615 acc16= unstack16
 616 acc16CompareAcc8
 617 brgt 621
 618 acc8= constant 68
 619 call writeLineAcc8
 620 ;test5.j(95)     if (one+three <= 12/(1+2)) println(69);
 621 acc16= variable 2
 622 acc16+ variable 4
 623 <acc16
 624 acc8= constant 12
 625 <acc8= constant 1
 626 acc8+ constant 2
 627 /acc8 unstack8
 628 acc16= unstack16
 629 acc16CompareAcc8
 630 brgt 634
 631 acc8= constant 69
 632 call writeLineAcc8
 633 ;test5.j(96)     if (one+three >= 12/(1+2)) println(70);
 634 acc16= variable 2
 635 acc16+ variable 4
 636 <acc16
 637 acc8= constant 12
 638 <acc8= constant 1
 639 acc8+ constant 2
 640 /acc8 unstack8
 641 acc16= unstack16
 642 acc16CompareAcc8
 643 brlt 647
 644 acc8= constant 70
 645 call writeLineAcc8
 646 ;test5.j(97)     if (one+four >= 12/(1+2)) println(71);
 647 acc16= variable 2
 648 acc16+ variable 6
 649 <acc16
 650 acc8= constant 12
 651 <acc8= constant 1
 652 acc8+ constant 2
 653 /acc8 unstack8
 654 acc16= unstack16
 655 acc16CompareAcc8
 656 brlt 660
 657 acc8= constant 71
 658 call writeLineAcc8
 659 ;test5.j(98)     if (one+three == twelve/(one+2)) println(72);
 660 acc16= variable 2
 661 acc16+ variable 4
 662 <acc16
 663 acc16= variable 10
 664 <acc16= variable 2
 665 acc16+ constant 2
 666 /acc16 unstack16
 667 revAcc16Comp unstack16
 668 brne 672
 669 acc8= constant 72
 670 call writeLineAcc8
 671 ;test5.j(99)     if (one+four  != twelve/(one+2)) println(73);
 672 acc16= variable 2
 673 acc16+ variable 6
 674 <acc16
 675 acc16= variable 10
 676 <acc16= variable 2
 677 acc16+ constant 2
 678 /acc16 unstack16
 679 revAcc16Comp unstack16
 680 breq 684
 681 acc8= constant 73
 682 call writeLineAcc8
 683 ;test5.j(100)     if (one+one < twelve/(one+2)) println(74);
 684 acc16= variable 2
 685 acc16+ variable 2
 686 <acc16
 687 acc16= variable 10
 688 <acc16= variable 2
 689 acc16+ constant 2
 690 /acc16 unstack16
 691 revAcc16Comp unstack16
 692 brle 696
 693 acc8= constant 74
 694 call writeLineAcc8
 695 ;test5.j(101)     if (one+four > twelve/(one+2)) println(75);
 696 acc16= variable 2
 697 acc16+ variable 6
 698 <acc16
 699 acc16= variable 10
 700 <acc16= variable 2
 701 acc16+ constant 2
 702 /acc16 unstack16
 703 revAcc16Comp unstack16
 704 brge 708
 705 acc8= constant 75
 706 call writeLineAcc8
 707 ;test5.j(102)     if (one+one <= twelve/(one+2)) println(76);
 708 acc16= variable 2
 709 acc16+ variable 2
 710 <acc16
 711 acc16= variable 10
 712 <acc16= variable 2
 713 acc16+ constant 2
 714 /acc16 unstack16
 715 revAcc16Comp unstack16
 716 brlt 720
 717 acc8= constant 76
 718 call writeLineAcc8
 719 ;test5.j(103)     if (one+three <= twelve/(one+2)) println(77);
 720 acc16= variable 2
 721 acc16+ variable 4
 722 <acc16
 723 acc16= variable 10
 724 <acc16= variable 2
 725 acc16+ constant 2
 726 /acc16 unstack16
 727 revAcc16Comp unstack16
 728 brlt 732
 729 acc8= constant 77
 730 call writeLineAcc8
 731 ;test5.j(104)     if (one+three >= twelve/(one+2)) println(78);
 732 acc16= variable 2
 733 acc16+ variable 4
 734 <acc16
 735 acc16= variable 10
 736 <acc16= variable 2
 737 acc16+ constant 2
 738 /acc16 unstack16
 739 revAcc16Comp unstack16
 740 brgt 744
 741 acc8= constant 78
 742 call writeLineAcc8
 743 ;test5.j(105)     if (one+four >= twelve/(one+2)) println(79);
 744 acc16= variable 2
 745 acc16+ variable 6
 746 <acc16
 747 acc16= variable 10
 748 <acc16= variable 2
 749 acc16+ constant 2
 750 /acc16 unstack16
 751 revAcc16Comp unstack16
 752 brgt 756
 753 acc8= constant 79
 754 call writeLineAcc8
 755 ;test5.j(106)     if (four == 12/(1+2)) println(80);
 756 acc8= constant 12
 757 <acc8= constant 1
 758 acc8+ constant 2
 759 /acc8 unstack8
 760 acc16= variable 6
 761 acc16CompareAcc8
 762 brne 766
 763 acc8= constant 80
 764 call writeLineAcc8
 765 ;test5.j(107)     if (three != 12/(1+2)) println(81);
 766 acc8= constant 12
 767 <acc8= constant 1
 768 acc8+ constant 2
 769 /acc8 unstack8
 770 acc16= variable 4
 771 acc16CompareAcc8
 772 breq 776
 773 acc8= constant 81
 774 call writeLineAcc8
 775 ;test5.j(108)     if (three < 12/(1+2)) println(82);
 776 acc8= constant 12
 777 <acc8= constant 1
 778 acc8+ constant 2
 779 /acc8 unstack8
 780 acc16= variable 4
 781 acc16CompareAcc8
 782 brge 786
 783 acc8= constant 82
 784 call writeLineAcc8
 785 ;test5.j(109)     if (twelve > 12/(1+2)) println(83);
 786 acc8= constant 12
 787 <acc8= constant 1
 788 acc8+ constant 2
 789 /acc8 unstack8
 790 acc16= variable 10
 791 acc16CompareAcc8
 792 brle 796
 793 acc8= constant 83
 794 call writeLineAcc8
 795 ;test5.j(110)     if (four <= 12/(1+2)) println(84);
 796 acc8= constant 12
 797 <acc8= constant 1
 798 acc8+ constant 2
 799 /acc8 unstack8
 800 acc16= variable 6
 801 acc16CompareAcc8
 802 brgt 806
 803 acc8= constant 84
 804 call writeLineAcc8
 805 ;test5.j(111)     if (three <= 12/(1+2)) println(85);
 806 acc8= constant 12
 807 <acc8= constant 1
 808 acc8+ constant 2
 809 /acc8 unstack8
 810 acc16= variable 4
 811 acc16CompareAcc8
 812 brgt 816
 813 acc8= constant 85
 814 call writeLineAcc8
 815 ;test5.j(112)     if (four >= 12/(1+2)) println(86);
 816 acc8= constant 12
 817 <acc8= constant 1
 818 acc8+ constant 2
 819 /acc8 unstack8
 820 acc16= variable 6
 821 acc16CompareAcc8
 822 brlt 826
 823 acc8= constant 86
 824 call writeLineAcc8
 825 ;test5.j(113)     if (twelve >= 12/(1+2)) println(87);
 826 acc8= constant 12
 827 <acc8= constant 1
 828 acc8+ constant 2
 829 /acc8 unstack8
 830 acc16= variable 10
 831 acc16CompareAcc8
 832 brlt 836
 833 acc8= constant 87
 834 call writeLineAcc8
 835 ;test5.j(114)     if (four == twelve/(one+2)) println(88);
 836 acc16= variable 10
 837 <acc16= variable 2
 838 acc16+ constant 2
 839 /acc16 unstack16
 840 acc16Comp variable 6
 841 brne 845
 842 acc8= constant 88
 843 call writeLineAcc8
 844 ;test5.j(115)     if (three != twelve/(one+2)) println(89);
 845 acc16= variable 10
 846 <acc16= variable 2
 847 acc16+ constant 2
 848 /acc16 unstack16
 849 acc16Comp variable 4
 850 breq 854
 851 acc8= constant 89
 852 call writeLineAcc8
 853 ;test5.j(116)     if (three < twelve/(one+2)) println(90);
 854 acc16= variable 10
 855 <acc16= variable 2
 856 acc16+ constant 2
 857 /acc16 unstack16
 858 acc16Comp variable 4
 859 brle 863
 860 acc8= constant 90
 861 call writeLineAcc8
 862 ;test5.j(117)     if (twelve > twelve/(one+2)) println(91);
 863 acc16= variable 10
 864 <acc16= variable 2
 865 acc16+ constant 2
 866 /acc16 unstack16
 867 acc16Comp variable 10
 868 brge 872
 869 acc8= constant 91
 870 call writeLineAcc8
 871 ;test5.j(118)     if (four <= twelve/(one+2)) println(92);
 872 acc16= variable 10
 873 <acc16= variable 2
 874 acc16+ constant 2
 875 /acc16 unstack16
 876 acc16Comp variable 6
 877 brlt 881
 878 acc8= constant 92
 879 call writeLineAcc8
 880 ;test5.j(119)     if (three <= twelve/(one+2)) println(93);
 881 acc16= variable 10
 882 <acc16= variable 2
 883 acc16+ constant 2
 884 /acc16 unstack16
 885 acc16Comp variable 4
 886 brlt 890
 887 acc8= constant 93
 888 call writeLineAcc8
 889 ;test5.j(120)     if (four >= twelve/(one+2)) println(94);
 890 acc16= variable 10
 891 <acc16= variable 2
 892 acc16+ constant 2
 893 /acc16 unstack16
 894 acc16Comp variable 6
 895 brgt 899
 896 acc8= constant 94
 897 call writeLineAcc8
 898 ;test5.j(121)     if (twelve >= twelve/(one+2)) println(95);
 899 acc16= variable 10
 900 <acc16= variable 2
 901 acc16+ constant 2
 902 /acc16 unstack16
 903 acc16Comp variable 10
 904 brgt 908
 905 acc8= constant 95
 906 call writeLineAcc8
 907 ;test5.j(122)     if (1+3 == 12/(1+2)) println(96);
 908 acc8= constant 1
 909 acc8+ constant 3
 910 <acc8
 911 acc8= constant 12
 912 <acc8= constant 1
 913 acc8+ constant 2
 914 /acc8 unstack8
 915 revAcc8Comp unstack8
 916 brne 920
 917 acc8= constant 96
 918 call writeLineAcc8
 919 ;test5.j(123)     if (1+2 != 12/(1+2)) println(97);
 920 acc8= constant 1
 921 acc8+ constant 2
 922 <acc8
 923 acc8= constant 12
 924 <acc8= constant 1
 925 acc8+ constant 2
 926 /acc8 unstack8
 927 revAcc8Comp unstack8
 928 breq 932
 929 acc8= constant 97
 930 call writeLineAcc8
 931 ;test5.j(124)     if (1+2 < 12/(1+2)) println(98);
 932 acc8= constant 1
 933 acc8+ constant 2
 934 <acc8
 935 acc8= constant 12
 936 <acc8= constant 1
 937 acc8+ constant 2
 938 /acc8 unstack8
 939 revAcc8Comp unstack8
 940 brle 944
 941 acc8= constant 98
 942 call writeLineAcc8
 943 ;test5.j(125)     if (1+4 > 12/(1+2)) println(99);
 944 acc8= constant 1
 945 acc8+ constant 4
 946 <acc8
 947 acc8= constant 12
 948 <acc8= constant 1
 949 acc8+ constant 2
 950 /acc8 unstack8
 951 revAcc8Comp unstack8
 952 brge 956
 953 acc8= constant 99
 954 call writeLineAcc8
 955 ;test5.j(126)     if (1+2 <= 12/(1+2)) println(100);
 956 acc8= constant 1
 957 acc8+ constant 2
 958 <acc8
 959 acc8= constant 12
 960 <acc8= constant 1
 961 acc8+ constant 2
 962 /acc8 unstack8
 963 revAcc8Comp unstack8
 964 brlt 968
 965 acc8= constant 100
 966 call writeLineAcc8
 967 ;test5.j(127)     if (1+3 <= 12/(1+2)) println(101);
 968 acc8= constant 1
 969 acc8+ constant 3
 970 <acc8
 971 acc8= constant 12
 972 <acc8= constant 1
 973 acc8+ constant 2
 974 /acc8 unstack8
 975 revAcc8Comp unstack8
 976 brlt 980
 977 acc8= constant 101
 978 call writeLineAcc8
 979 ;test5.j(128)     if (1+3 >= 12/(1+2)) println(102);
 980 acc8= constant 1
 981 acc8+ constant 3
 982 <acc8
 983 acc8= constant 12
 984 <acc8= constant 1
 985 acc8+ constant 2
 986 /acc8 unstack8
 987 revAcc8Comp unstack8
 988 brgt 992
 989 acc8= constant 102
 990 call writeLineAcc8
 991 ;test5.j(129)     if (1+4 >= 12/(1+2)) println(103);
 992 acc8= constant 1
 993 acc8+ constant 4
 994 <acc8
 995 acc8= constant 12
 996 <acc8= constant 1
 997 acc8+ constant 2
 998 /acc8 unstack8
 999 revAcc8Comp unstack8
1000 brgt 1004
1001 acc8= constant 103
1002 call writeLineAcc8
1003 ;test5.j(130)     if (1+3 == twelve/(one+2)) println(104);
1004 acc8= constant 1
1005 acc8+ constant 3
1006 <acc8
1007 acc16= variable 10
1008 <acc16= variable 2
1009 acc16+ constant 2
1010 /acc16 unstack16
1011 acc8= unstack8
1012 acc8CompareAcc16
1013 brne 1017
1014 acc8= constant 104
1015 call writeLineAcc8
1016 ;test5.j(131)     if (1+2 != twelve/(one+2)) println(105);
1017 acc8= constant 1
1018 acc8+ constant 2
1019 <acc8
1020 acc16= variable 10
1021 <acc16= variable 2
1022 acc16+ constant 2
1023 /acc16 unstack16
1024 acc8= unstack8
1025 acc8CompareAcc16
1026 breq 1030
1027 acc8= constant 105
1028 call writeLineAcc8
1029 ;test5.j(132)     if (1+2 < twelve/(one+2)) println(106);
1030 acc8= constant 1
1031 acc8+ constant 2
1032 <acc8
1033 acc16= variable 10
1034 <acc16= variable 2
1035 acc16+ constant 2
1036 /acc16 unstack16
1037 acc8= unstack8
1038 acc8CompareAcc16
1039 brge 1043
1040 acc8= constant 106
1041 call writeLineAcc8
1042 ;test5.j(133)     if (1+4 > twelve/(one+2)) println(107);
1043 acc8= constant 1
1044 acc8+ constant 4
1045 <acc8
1046 acc16= variable 10
1047 <acc16= variable 2
1048 acc16+ constant 2
1049 /acc16 unstack16
1050 acc8= unstack8
1051 acc8CompareAcc16
1052 brle 1056
1053 acc8= constant 107
1054 call writeLineAcc8
1055 ;test5.j(134)     if (1+2 <= twelve/(one+2)) println(108);
1056 acc8= constant 1
1057 acc8+ constant 2
1058 <acc8
1059 acc16= variable 10
1060 <acc16= variable 2
1061 acc16+ constant 2
1062 /acc16 unstack16
1063 acc8= unstack8
1064 acc8CompareAcc16
1065 brgt 1069
1066 acc8= constant 108
1067 call writeLineAcc8
1068 ;test5.j(135)     if (1+3 <= twelve/(one+2)) println(109);
1069 acc8= constant 1
1070 acc8+ constant 3
1071 <acc8
1072 acc16= variable 10
1073 <acc16= variable 2
1074 acc16+ constant 2
1075 /acc16 unstack16
1076 acc8= unstack8
1077 acc8CompareAcc16
1078 brgt 1082
1079 acc8= constant 109
1080 call writeLineAcc8
1081 ;test5.j(136)     if (1+3 >= twelve/(one+2)) println(110);
1082 acc8= constant 1
1083 acc8+ constant 3
1084 <acc8
1085 acc16= variable 10
1086 <acc16= variable 2
1087 acc16+ constant 2
1088 /acc16 unstack16
1089 acc8= unstack8
1090 acc8CompareAcc16
1091 brlt 1095
1092 acc8= constant 110
1093 call writeLineAcc8
1094 ;test5.j(137)     if (1+4 >= twelve/(one+2)) println(111);
1095 acc8= constant 1
1096 acc8+ constant 4
1097 <acc8
1098 acc16= variable 10
1099 <acc16= variable 2
1100 acc16+ constant 2
1101 /acc16 unstack16
1102 acc8= unstack8
1103 acc8CompareAcc16
1104 brlt 1108
1105 acc8= constant 111
1106 call writeLineAcc8
1107 ;test5.j(138)     if (4 == 12/(1+2)) println(112);
1108 acc8= constant 12
1109 <acc8= constant 1
1110 acc8+ constant 2
1111 /acc8 unstack8
1112 acc8Comp constant 4
1113 brne 1117
1114 acc8= constant 112
1115 call writeLineAcc8
1116 ;test5.j(139)     if (3 != 12/(1+2)) println(113);
1117 acc8= constant 12
1118 <acc8= constant 1
1119 acc8+ constant 2
1120 /acc8 unstack8
1121 acc8Comp constant 3
1122 breq 1126
1123 acc8= constant 113
1124 call writeLineAcc8
1125 ;test5.j(140)     if (3 < 12/(1+2)) println(114);
1126 acc8= constant 12
1127 <acc8= constant 1
1128 acc8+ constant 2
1129 /acc8 unstack8
1130 acc8Comp constant 3
1131 brle 1135
1132 acc8= constant 114
1133 call writeLineAcc8
1134 ;test5.j(141)     if (5 > 12/(1+2)) println(115);
1135 acc8= constant 12
1136 <acc8= constant 1
1137 acc8+ constant 2
1138 /acc8 unstack8
1139 acc8Comp constant 5
1140 brge 1144
1141 acc8= constant 115
1142 call writeLineAcc8
1143 ;test5.j(142)     if (3 <= 12/(1+2)) println(116);
1144 acc8= constant 12
1145 <acc8= constant 1
1146 acc8+ constant 2
1147 /acc8 unstack8
1148 acc8Comp constant 3
1149 brlt 1153
1150 acc8= constant 116
1151 call writeLineAcc8
1152 ;test5.j(143)     if (4 <= 12/(1+2)) println(117);
1153 acc8= constant 12
1154 <acc8= constant 1
1155 acc8+ constant 2
1156 /acc8 unstack8
1157 acc8Comp constant 4
1158 brlt 1162
1159 acc8= constant 117
1160 call writeLineAcc8
1161 ;test5.j(144)     if (4 >= 12/(1+2)) println(118);
1162 acc8= constant 12
1163 <acc8= constant 1
1164 acc8+ constant 2
1165 /acc8 unstack8
1166 acc8Comp constant 4
1167 brgt 1171
1168 acc8= constant 118
1169 call writeLineAcc8
1170 ;test5.j(145)     if (5 >= 12/(1+2)) println(119);
1171 acc8= constant 12
1172 <acc8= constant 1
1173 acc8+ constant 2
1174 /acc8 unstack8
1175 acc8Comp constant 5
1176 brgt 1180
1177 acc8= constant 119
1178 call writeLineAcc8
1179 ;test5.j(146)     if (4 == twelve/(one+2)) println(120);
1180 acc16= variable 10
1181 <acc16= variable 2
1182 acc16+ constant 2
1183 /acc16 unstack16
1184 acc8= constant 4
1185 acc8CompareAcc16
1186 brne 1190
1187 acc8= constant 120
1188 call writeLineAcc8
1189 ;test5.j(147)     if (3 != twelve/(one+2)) println(121);
1190 acc16= variable 10
1191 <acc16= variable 2
1192 acc16+ constant 2
1193 /acc16 unstack16
1194 acc8= constant 3
1195 acc8CompareAcc16
1196 breq 1200
1197 acc8= constant 121
1198 call writeLineAcc8
1199 ;test5.j(148)     if (2 < twelve/(one+2)) println(122);
1200 acc16= variable 10
1201 <acc16= variable 2
1202 acc16+ constant 2
1203 /acc16 unstack16
1204 acc8= constant 2
1205 acc8CompareAcc16
1206 brge 1210
1207 acc8= constant 122
1208 call writeLineAcc8
1209 ;test5.j(149)     if (5 > twelve/(one+2)) println(123);
1210 acc16= variable 10
1211 <acc16= variable 2
1212 acc16+ constant 2
1213 /acc16 unstack16
1214 acc8= constant 5
1215 acc8CompareAcc16
1216 brle 1220
1217 acc8= constant 123
1218 call writeLineAcc8
1219 ;test5.j(150)     if (3 <= twelve/(one+2)) println(124);
1220 acc16= variable 10
1221 <acc16= variable 2
1222 acc16+ constant 2
1223 /acc16 unstack16
1224 acc8= constant 3
1225 acc8CompareAcc16
1226 brgt 1230
1227 acc8= constant 124
1228 call writeLineAcc8
1229 ;test5.j(151)     if (4 <= twelve/(one+2)) println(125);
1230 acc16= variable 10
1231 <acc16= variable 2
1232 acc16+ constant 2
1233 /acc16 unstack16
1234 acc8= constant 4
1235 acc8CompareAcc16
1236 brgt 1240
1237 acc8= constant 125
1238 call writeLineAcc8
1239 ;test5.j(152)     if (4 >= twelve/(one+2)) println(126);
1240 acc16= variable 10
1241 <acc16= variable 2
1242 acc16+ constant 2
1243 /acc16 unstack16
1244 acc8= constant 4
1245 acc8CompareAcc16
1246 brlt 1250
1247 acc8= constant 126
1248 call writeLineAcc8
1249 ;test5.j(153)     if (5 >= twelve/(one+2)) println(127);
1250 acc16= variable 10
1251 <acc16= variable 2
1252 acc16+ constant 2
1253 /acc16 unstack16
1254 acc8= constant 5
1255 acc8CompareAcc16
1256 brlt 1260
1257 acc8= constant 127
1258 call writeLineAcc8
1259 ;test5.j(154)     if (four == 0 + 12/(1 + 2)) println(128);
1260 acc8= constant 0
1261 <acc8= constant 12
1262 <acc8= constant 1
1263 acc8+ constant 2
1264 /acc8 unstack8
1265 acc8+ unstack8
1266 acc16= variable 6
1267 acc16CompareAcc8
1268 brne 1272
1269 acc8= constant 128
1270 call writeLineAcc8
1271 ;test5.j(155)     if (four == 0 + 12/(1 + 2)) println(129);
1272 acc8= constant 0
1273 <acc8= constant 12
1274 <acc8= constant 1
1275 acc8+ constant 2
1276 /acc8 unstack8
1277 acc8+ unstack8
1278 acc16= variable 6
1279 acc16CompareAcc8
1280 brne 1284
1281 acc8= constant 129
1282 call writeLineAcc8
1283 ;test5.j(156)     if (four == 0 + 12/(byteOne + 2)) println(130);
1284 acc8= constant 0
1285 <acc8= constant 12
1286 <acc8= variable 12
1287 acc8+ constant 2
1288 /acc8 unstack8
1289 acc8+ unstack8
1290 acc16= variable 6
1291 acc16CompareAcc8
1292 brne 1296
1293 acc8= constant 130
1294 call writeLineAcc8
1295 ;test5.j(157)     if (four == 0 + 12/(one + 2)) println(131);
1296 acc8= constant 0
1297 <acc8= constant 12
1298 acc16= variable 2
1299 acc16+ constant 2
1300 /acc16 acc8
1301 acc16+ unstack8
1302 acc16Comp variable 6
1303 brne 1307
1304 acc8= constant 131
1305 call writeLineAcc8
1306 ;test5.j(158)     if (4 == zero + twelve/(1+2)) println(132);
1307 acc16= variable 0
1308 <acc16= variable 10
1309 acc8= constant 1
1310 acc8+ constant 2
1311 acc16/ acc8
1312 acc16+ unstack16
1313 acc8= constant 4
1314 acc8CompareAcc16
1315 brne 1322
1316 acc8= constant 132
1317 call writeLineAcc8
1318 ;test5.j(159)   
1319 ;test5.j(160)     /************************/
1320 ;test5.j(161)     // global variable b used within if scope
1321 ;test5.j(162)     b = 133;
1322 acc8= constant 133
1323 acc8=> variable 14
1324 ;test5.j(163)     if (b>132) {
1325 acc8= variable 14
1326 acc8Comp constant 132
1327 brle 1345
1328 ;test5.j(164)       word j = 1001;
1329 acc16= constant 1001
1330 acc16=> variable 15
1331 ;test5.j(165)       byte c = b;
1332 acc8= variable 14
1333 acc8=> variable 17
1334 ;test5.j(166)       byte d = c;
1335 acc8= variable 17
1336 acc8=> variable 18
1337 ;test5.j(167)       b--;
1338 decr8 variable 14
1339 ;test5.j(168)       println (c);
1340 acc8= variable 17
1341 call writeLineAcc8
1342 ;test5.j(169)     } else {
1343 br 1351
1344 ;test5.j(170)       println(999);
1345 acc16= constant 999
1346 call writeLineAcc16
1347 ;test5.j(171)     }
1348 ;test5.j(172)   
1349 ;test5.j(173)     /************************/
1350 ;test5.j(174)     println (134);
1351 acc8= constant 134
1352 call writeLineAcc8
1353 ;test5.j(175)     println("Klaar");
1354 acc16= constant 1360
1355 writeLineString
1356 ;test5.j(176)   }
1357 ;test5.j(177) }
1358 ;test5.j(178) //comment after final }.
1359 stop
1360 stringConstant 0 = "Klaar"
