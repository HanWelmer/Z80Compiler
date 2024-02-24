   0 call 35
   1 stop
   2 ;test5.j(0) /*
   3 ;test5.j(1)  * A small program in the miniJava language.
   4 ;test5.j(2)  * Test comparison
   5 ;test5.j(3)  */
   6 ;test5.j(4) class TestComparison {
   7 class TestComparison []
   8 ;test5.j(5)   private static word zero = 0;
   9 acc8= constant 0
  10 acc8=> variable 0
  11 ;test5.j(6)   private static word one = 1;
  12 acc8= constant 1
  13 acc8=> variable 2
  14 ;test5.j(7)   private static word three = 3;
  15 acc8= constant 3
  16 acc8=> variable 4
  17 ;test5.j(8)   private static word four = 4;
  18 acc8= constant 4
  19 acc8=> variable 6
  20 ;test5.j(9)   private static word five = 5;
  21 acc8= constant 5
  22 acc8=> variable 8
  23 ;test5.j(10)   private static word twelve = 12;
  24 acc8= constant 12
  25 acc8=> variable 10
  26 ;test5.j(11)   private static byte byteOne = 1;
  27 acc8= constant 1
  28 acc8=> variable 12
  29 ;test5.j(12)   private static byte byteSix = 262;
  30 acc16= constant 262
  31 acc16=> variable 13
  32 ;test5.j(13)   private static byte b;
  33 ;test5.j(14)   
  34 ;test5.j(15)   public static void main() {
  35 method main [public, static] void
  36 ;test5.j(16)     //stack level 1
  37 ;test5.j(17)     //byte-byte
  38 ;test5.j(18)     if (4 == 12/(1+2)) println(0);
  39 acc8= constant 12
  40 <acc8= constant 1
  41 acc8+ constant 2
  42 /acc8 unstack8
  43 acc8Comp constant 4
  44 brne 48
  45 acc8= constant 0
  46 call writeLineAcc8
  47 ;test5.j(19)     if (4 == 4) println(1);
  48 acc8= constant 4
  49 acc8Comp constant 4
  50 brne 54
  51 acc8= constant 1
  52 call writeLineAcc8
  53 ;test5.j(20)     if (3 != 12/(1+2)) println(2);
  54 acc8= constant 12
  55 <acc8= constant 1
  56 acc8+ constant 2
  57 /acc8 unstack8
  58 acc8Comp constant 3
  59 breq 63
  60 acc8= constant 2
  61 call writeLineAcc8
  62 ;test5.j(21)     if (3 != 4) println(3);
  63 acc8= constant 3
  64 acc8Comp constant 4
  65 breq 69
  66 acc8= constant 3
  67 call writeLineAcc8
  68 ;test5.j(22)     if (3 < 12/(1+2)) println(4);
  69 acc8= constant 12
  70 <acc8= constant 1
  71 acc8+ constant 2
  72 /acc8 unstack8
  73 acc8Comp constant 3
  74 brle 78
  75 acc8= constant 4
  76 call writeLineAcc8
  77 ;test5.j(23)     if (3 < 4) println(5);
  78 acc8= constant 3
  79 acc8Comp constant 4
  80 brge 84
  81 acc8= constant 5
  82 call writeLineAcc8
  83 ;test5.j(24)     if (5 > 12/(1+2)) println(6);
  84 acc8= constant 12
  85 <acc8= constant 1
  86 acc8+ constant 2
  87 /acc8 unstack8
  88 acc8Comp constant 5
  89 brge 93
  90 acc8= constant 6
  91 call writeLineAcc8
  92 ;test5.j(25)     if (5 > 4) println(7);
  93 acc8= constant 5
  94 acc8Comp constant 4
  95 brle 99
  96 acc8= constant 7
  97 call writeLineAcc8
  98 ;test5.j(26)     if (3 <= 12/(1+2)) println(8);
  99 acc8= constant 12
 100 <acc8= constant 1
 101 acc8+ constant 2
 102 /acc8 unstack8
 103 acc8Comp constant 3
 104 brlt 108
 105 acc8= constant 8
 106 call writeLineAcc8
 107 ;test5.j(27)     if (3 <= 4) println(9);
 108 acc8= constant 3
 109 acc8Comp constant 4
 110 brgt 114
 111 acc8= constant 9
 112 call writeLineAcc8
 113 ;test5.j(28)     if (4 <= 12/(1+2)) println(10);
 114 acc8= constant 12
 115 <acc8= constant 1
 116 acc8+ constant 2
 117 /acc8 unstack8
 118 acc8Comp constant 4
 119 brlt 123
 120 acc8= constant 10
 121 call writeLineAcc8
 122 ;test5.j(29)     if (4 <= 4) println(11);
 123 acc8= constant 4
 124 acc8Comp constant 4
 125 brgt 129
 126 acc8= constant 11
 127 call writeLineAcc8
 128 ;test5.j(30)     if (5 >= 12/(1+2)) println(12);
 129 acc8= constant 12
 130 <acc8= constant 1
 131 acc8+ constant 2
 132 /acc8 unstack8
 133 acc8Comp constant 5
 134 brgt 138
 135 acc8= constant 12
 136 call writeLineAcc8
 137 ;test5.j(31)     if (5 >= 4) println(13);
 138 acc8= constant 5
 139 acc8Comp constant 4
 140 brlt 144
 141 acc8= constant 13
 142 call writeLineAcc8
 143 ;test5.j(32)     if (4 >= 12/(1+2)) println(14);
 144 acc8= constant 12
 145 <acc8= constant 1
 146 acc8+ constant 2
 147 /acc8 unstack8
 148 acc8Comp constant 4
 149 brgt 153
 150 acc8= constant 14
 151 call writeLineAcc8
 152 ;test5.j(33)     if (4 >= 4) println(15);
 153 acc8= constant 4
 154 acc8Comp constant 4
 155 brlt 161
 156 acc8= constant 15
 157 call writeLineAcc8
 158 ;test5.j(34)     //stack level 1
 159 ;test5.j(35)     //byte-integer
 160 ;test5.j(36)     if (4 == twelve/(1+2)) println(16);
 161 acc16= variable 10
 162 acc8= constant 1
 163 acc8+ constant 2
 164 acc16/ acc8
 165 acc8= constant 4
 166 acc8CompareAcc16
 167 brne 171
 168 acc8= constant 16
 169 call writeLineAcc8
 170 ;test5.j(37)     if (4 == four) println(17);
 171 acc16= variable 6
 172 acc8= constant 4
 173 acc8CompareAcc16
 174 brne 178
 175 acc8= constant 17
 176 call writeLineAcc8
 177 ;test5.j(38)     if (3 != twelve/(1+2)) println(18);
 178 acc16= variable 10
 179 acc8= constant 1
 180 acc8+ constant 2
 181 acc16/ acc8
 182 acc8= constant 3
 183 acc8CompareAcc16
 184 breq 188
 185 acc8= constant 18
 186 call writeLineAcc8
 187 ;test5.j(39)     if (3 != four) println(19);
 188 acc16= variable 6
 189 acc8= constant 3
 190 acc8CompareAcc16
 191 breq 195
 192 acc8= constant 19
 193 call writeLineAcc8
 194 ;test5.j(40)     if (3 < twelve/(1+2)) println(20);
 195 acc16= variable 10
 196 acc8= constant 1
 197 acc8+ constant 2
 198 acc16/ acc8
 199 acc8= constant 3
 200 acc8CompareAcc16
 201 brge 205
 202 acc8= constant 20
 203 call writeLineAcc8
 204 ;test5.j(41)     if (3 < four) println(21);
 205 acc16= variable 6
 206 acc8= constant 3
 207 acc8CompareAcc16
 208 brge 212
 209 acc8= constant 21
 210 call writeLineAcc8
 211 ;test5.j(42)     if (5 > twelve/(1+2)) println(22);
 212 acc16= variable 10
 213 acc8= constant 1
 214 acc8+ constant 2
 215 acc16/ acc8
 216 acc8= constant 5
 217 acc8CompareAcc16
 218 brle 222
 219 acc8= constant 22
 220 call writeLineAcc8
 221 ;test5.j(43)     if (5 > four) println(23);
 222 acc16= variable 6
 223 acc8= constant 5
 224 acc8CompareAcc16
 225 brle 229
 226 acc8= constant 23
 227 call writeLineAcc8
 228 ;test5.j(44)     if (3 <= twelve/(1+2)) println(24);
 229 acc16= variable 10
 230 acc8= constant 1
 231 acc8+ constant 2
 232 acc16/ acc8
 233 acc8= constant 3
 234 acc8CompareAcc16
 235 brgt 239
 236 acc8= constant 24
 237 call writeLineAcc8
 238 ;test5.j(45)     if (3 <= four) println(25);
 239 acc16= variable 6
 240 acc8= constant 3
 241 acc8CompareAcc16
 242 brgt 246
 243 acc8= constant 25
 244 call writeLineAcc8
 245 ;test5.j(46)     if (4 <= twelve/(1+2)) println(26);
 246 acc16= variable 10
 247 acc8= constant 1
 248 acc8+ constant 2
 249 acc16/ acc8
 250 acc8= constant 4
 251 acc8CompareAcc16
 252 brgt 256
 253 acc8= constant 26
 254 call writeLineAcc8
 255 ;test5.j(47)     if (4 <= four) println(27);
 256 acc16= variable 6
 257 acc8= constant 4
 258 acc8CompareAcc16
 259 brgt 263
 260 acc8= constant 27
 261 call writeLineAcc8
 262 ;test5.j(48)     if (5 >= twelve/(1+2)) println(28);
 263 acc16= variable 10
 264 acc8= constant 1
 265 acc8+ constant 2
 266 acc16/ acc8
 267 acc8= constant 5
 268 acc8CompareAcc16
 269 brlt 273
 270 acc8= constant 28
 271 call writeLineAcc8
 272 ;test5.j(49)     if (5 >= four) println(29);
 273 acc16= variable 6
 274 acc8= constant 5
 275 acc8CompareAcc16
 276 brlt 280
 277 acc8= constant 29
 278 call writeLineAcc8
 279 ;test5.j(50)     if (4 >= twelve/(1+2)) println(30);
 280 acc16= variable 10
 281 acc8= constant 1
 282 acc8+ constant 2
 283 acc16/ acc8
 284 acc8= constant 4
 285 acc8CompareAcc16
 286 brlt 290
 287 acc8= constant 30
 288 call writeLineAcc8
 289 ;test5.j(51)     if (4 >= four) println(31);
 290 acc16= variable 6
 291 acc8= constant 4
 292 acc8CompareAcc16
 293 brlt 299
 294 acc8= constant 31
 295 call writeLineAcc8
 296 ;test5.j(52)     //stack level 1
 297 ;test5.j(53)     //integer-byte
 298 ;test5.j(54)     if (four == 12/(1+2)) println(32);
 299 acc8= constant 12
 300 <acc8= constant 1
 301 acc8+ constant 2
 302 /acc8 unstack8
 303 acc16= variable 6
 304 acc16CompareAcc8
 305 brne 309
 306 acc8= constant 32
 307 call writeLineAcc8
 308 ;test5.j(55)     if (four == 4) println(33);
 309 acc16= variable 6
 310 acc8= constant 4
 311 acc16CompareAcc8
 312 brne 316
 313 acc8= constant 33
 314 call writeLineAcc8
 315 ;test5.j(56)     if (three != 12/(1+2)) println(34);
 316 acc8= constant 12
 317 <acc8= constant 1
 318 acc8+ constant 2
 319 /acc8 unstack8
 320 acc16= variable 4
 321 acc16CompareAcc8
 322 breq 326
 323 acc8= constant 34
 324 call writeLineAcc8
 325 ;test5.j(57)     if (three != 4) println(35);
 326 acc16= variable 4
 327 acc8= constant 4
 328 acc16CompareAcc8
 329 breq 333
 330 acc8= constant 35
 331 call writeLineAcc8
 332 ;test5.j(58)     if (three < 12/(1+2)) println(36);
 333 acc8= constant 12
 334 <acc8= constant 1
 335 acc8+ constant 2
 336 /acc8 unstack8
 337 acc16= variable 4
 338 acc16CompareAcc8
 339 brge 343
 340 acc8= constant 36
 341 call writeLineAcc8
 342 ;test5.j(59)     if (three < 4) println(37);
 343 acc16= variable 4
 344 acc8= constant 4
 345 acc16CompareAcc8
 346 brge 350
 347 acc8= constant 37
 348 call writeLineAcc8
 349 ;test5.j(60)     if (five > 12/(1+2)) println(38);
 350 acc8= constant 12
 351 <acc8= constant 1
 352 acc8+ constant 2
 353 /acc8 unstack8
 354 acc16= variable 8
 355 acc16CompareAcc8
 356 brle 360
 357 acc8= constant 38
 358 call writeLineAcc8
 359 ;test5.j(61)     if (five > 4) println(39);
 360 acc16= variable 8
 361 acc8= constant 4
 362 acc16CompareAcc8
 363 brle 367
 364 acc8= constant 39
 365 call writeLineAcc8
 366 ;test5.j(62)     if (three <= 12/(1+2)) println(40);
 367 acc8= constant 12
 368 <acc8= constant 1
 369 acc8+ constant 2
 370 /acc8 unstack8
 371 acc16= variable 4
 372 acc16CompareAcc8
 373 brgt 377
 374 acc8= constant 40
 375 call writeLineAcc8
 376 ;test5.j(63)     if (three <= 4) println(41);
 377 acc16= variable 4
 378 acc8= constant 4
 379 acc16CompareAcc8
 380 brgt 384
 381 acc8= constant 41
 382 call writeLineAcc8
 383 ;test5.j(64)     if (four <= 12/(1+2)) println(42);
 384 acc8= constant 12
 385 <acc8= constant 1
 386 acc8+ constant 2
 387 /acc8 unstack8
 388 acc16= variable 6
 389 acc16CompareAcc8
 390 brgt 394
 391 acc8= constant 42
 392 call writeLineAcc8
 393 ;test5.j(65)     if (four <= 4) println(43);
 394 acc16= variable 6
 395 acc8= constant 4
 396 acc16CompareAcc8
 397 brgt 401
 398 acc8= constant 43
 399 call writeLineAcc8
 400 ;test5.j(66)     if (five >= 12/(1+2)) println(44);
 401 acc8= constant 12
 402 <acc8= constant 1
 403 acc8+ constant 2
 404 /acc8 unstack8
 405 acc16= variable 8
 406 acc16CompareAcc8
 407 brlt 411
 408 acc8= constant 44
 409 call writeLineAcc8
 410 ;test5.j(67)     if (five >= 4) println(45);
 411 acc16= variable 8
 412 acc8= constant 4
 413 acc16CompareAcc8
 414 brlt 418
 415 acc8= constant 45
 416 call writeLineAcc8
 417 ;test5.j(68)     if (four >= 12/(1+2)) println(46);
 418 acc8= constant 12
 419 <acc8= constant 1
 420 acc8+ constant 2
 421 /acc8 unstack8
 422 acc16= variable 6
 423 acc16CompareAcc8
 424 brlt 428
 425 acc8= constant 46
 426 call writeLineAcc8
 427 ;test5.j(69)     if (four >= 4) println(47);
 428 acc16= variable 6
 429 acc8= constant 4
 430 acc16CompareAcc8
 431 brlt 437
 432 acc8= constant 47
 433 call writeLineAcc8
 434 ;test5.j(70)     //stack level 1
 435 ;test5.j(71)     //integer-integer
 436 ;test5.j(72)     if (400 == 1200/(1+2)) println(48);
 437 acc16= constant 1200
 438 acc8= constant 1
 439 acc8+ constant 2
 440 acc16/ acc8
 441 acc16Comp constant 400
 442 brne 446
 443 acc8= constant 48
 444 call writeLineAcc8
 445 ;test5.j(73)     if (400 == 400) println(49);
 446 acc16= constant 400
 447 acc16Comp constant 400
 448 brne 452
 449 acc8= constant 49
 450 call writeLineAcc8
 451 ;test5.j(74)     if (300 != 1200/(1+2)) println(50);
 452 acc16= constant 1200
 453 acc8= constant 1
 454 acc8+ constant 2
 455 acc16/ acc8
 456 acc16Comp constant 300
 457 breq 461
 458 acc8= constant 50
 459 call writeLineAcc8
 460 ;test5.j(75)     if (300 != 400) println(51);
 461 acc16= constant 300
 462 acc16Comp constant 400
 463 breq 467
 464 acc8= constant 51
 465 call writeLineAcc8
 466 ;test5.j(76)     if (300 < 1200/(1+2)) println(52);
 467 acc16= constant 1200
 468 acc8= constant 1
 469 acc8+ constant 2
 470 acc16/ acc8
 471 acc16Comp constant 300
 472 brle 476
 473 acc8= constant 52
 474 call writeLineAcc8
 475 ;test5.j(77)     if (300 < 400) println(53);
 476 acc16= constant 300
 477 acc16Comp constant 400
 478 brge 482
 479 acc8= constant 53
 480 call writeLineAcc8
 481 ;test5.j(78)     if (500 > 1200/(1+2)) println(54);
 482 acc16= constant 1200
 483 acc8= constant 1
 484 acc8+ constant 2
 485 acc16/ acc8
 486 acc16Comp constant 500
 487 brge 491
 488 acc8= constant 54
 489 call writeLineAcc8
 490 ;test5.j(79)     if (500 > 400) println(55);
 491 acc16= constant 500
 492 acc16Comp constant 400
 493 brle 497
 494 acc8= constant 55
 495 call writeLineAcc8
 496 ;test5.j(80)     if (300 <= 1200/(1+2)) println(56);
 497 acc16= constant 1200
 498 acc8= constant 1
 499 acc8+ constant 2
 500 acc16/ acc8
 501 acc16Comp constant 300
 502 brlt 506
 503 acc8= constant 56
 504 call writeLineAcc8
 505 ;test5.j(81)     if (300 <= 400) println(57);
 506 acc16= constant 300
 507 acc16Comp constant 400
 508 brgt 512
 509 acc8= constant 57
 510 call writeLineAcc8
 511 ;test5.j(82)     if (400 <= 1200/(1+2)) println(58);
 512 acc16= constant 1200
 513 acc8= constant 1
 514 acc8+ constant 2
 515 acc16/ acc8
 516 acc16Comp constant 400
 517 brlt 521
 518 acc8= constant 58
 519 call writeLineAcc8
 520 ;test5.j(83)     if (400 <= 400) println(59);
 521 acc16= constant 400
 522 acc16Comp constant 400
 523 brgt 527
 524 acc8= constant 59
 525 call writeLineAcc8
 526 ;test5.j(84)     if (500 >= 1200/(1+2)) println(60);
 527 acc16= constant 1200
 528 acc8= constant 1
 529 acc8+ constant 2
 530 acc16/ acc8
 531 acc16Comp constant 500
 532 brgt 536
 533 acc8= constant 60
 534 call writeLineAcc8
 535 ;test5.j(85)     if (500 >= 400) println(61);
 536 acc16= constant 500
 537 acc16Comp constant 400
 538 brlt 542
 539 acc8= constant 61
 540 call writeLineAcc8
 541 ;test5.j(86)     if (400 >= 1200/(1+2)) println(62);
 542 acc16= constant 1200
 543 acc8= constant 1
 544 acc8+ constant 2
 545 acc16/ acc8
 546 acc16Comp constant 400
 547 brgt 551
 548 acc8= constant 62
 549 call writeLineAcc8
 550 ;test5.j(87)     if (400 >= 400) println(63);
 551 acc16= constant 400
 552 acc16Comp constant 400
 553 brlt 559
 554 acc8= constant 63
 555 call writeLineAcc8
 556 ;test5.j(88)   
 557 ;test5.j(89)     //stack level 2
 558 ;test5.j(90)     if (one+three == 12/(1+2)) println(64);
 559 acc16= variable 2
 560 acc16+ variable 4
 561 <acc16
 562 acc8= constant 12
 563 <acc8= constant 1
 564 acc8+ constant 2
 565 /acc8 unstack8
 566 acc16= unstack16
 567 acc16CompareAcc8
 568 brne 572
 569 acc8= constant 64
 570 call writeLineAcc8
 571 ;test5.j(91)     if (one+four  != 12/(1+2)) println(65);
 572 acc16= variable 2
 573 acc16+ variable 6
 574 <acc16
 575 acc8= constant 12
 576 <acc8= constant 1
 577 acc8+ constant 2
 578 /acc8 unstack8
 579 acc16= unstack16
 580 acc16CompareAcc8
 581 breq 585
 582 acc8= constant 65
 583 call writeLineAcc8
 584 ;test5.j(92)     if (one+one < 12/(1+2)) println(66);
 585 acc16= variable 2
 586 acc16+ variable 2
 587 <acc16
 588 acc8= constant 12
 589 <acc8= constant 1
 590 acc8+ constant 2
 591 /acc8 unstack8
 592 acc16= unstack16
 593 acc16CompareAcc8
 594 brge 598
 595 acc8= constant 66
 596 call writeLineAcc8
 597 ;test5.j(93)     if (one+four > 12/(1+2)) println(67);
 598 acc16= variable 2
 599 acc16+ variable 6
 600 <acc16
 601 acc8= constant 12
 602 <acc8= constant 1
 603 acc8+ constant 2
 604 /acc8 unstack8
 605 acc16= unstack16
 606 acc16CompareAcc8
 607 brle 611
 608 acc8= constant 67
 609 call writeLineAcc8
 610 ;test5.j(94)     if (one+one <= 12/(1+2)) println(68);
 611 acc16= variable 2
 612 acc16+ variable 2
 613 <acc16
 614 acc8= constant 12
 615 <acc8= constant 1
 616 acc8+ constant 2
 617 /acc8 unstack8
 618 acc16= unstack16
 619 acc16CompareAcc8
 620 brgt 624
 621 acc8= constant 68
 622 call writeLineAcc8
 623 ;test5.j(95)     if (one+three <= 12/(1+2)) println(69);
 624 acc16= variable 2
 625 acc16+ variable 4
 626 <acc16
 627 acc8= constant 12
 628 <acc8= constant 1
 629 acc8+ constant 2
 630 /acc8 unstack8
 631 acc16= unstack16
 632 acc16CompareAcc8
 633 brgt 637
 634 acc8= constant 69
 635 call writeLineAcc8
 636 ;test5.j(96)     if (one+three >= 12/(1+2)) println(70);
 637 acc16= variable 2
 638 acc16+ variable 4
 639 <acc16
 640 acc8= constant 12
 641 <acc8= constant 1
 642 acc8+ constant 2
 643 /acc8 unstack8
 644 acc16= unstack16
 645 acc16CompareAcc8
 646 brlt 650
 647 acc8= constant 70
 648 call writeLineAcc8
 649 ;test5.j(97)     if (one+four >= 12/(1+2)) println(71);
 650 acc16= variable 2
 651 acc16+ variable 6
 652 <acc16
 653 acc8= constant 12
 654 <acc8= constant 1
 655 acc8+ constant 2
 656 /acc8 unstack8
 657 acc16= unstack16
 658 acc16CompareAcc8
 659 brlt 663
 660 acc8= constant 71
 661 call writeLineAcc8
 662 ;test5.j(98)     if (one+three == twelve/(one+2)) println(72);
 663 acc16= variable 2
 664 acc16+ variable 4
 665 <acc16
 666 acc16= variable 10
 667 <acc16= variable 2
 668 acc16+ constant 2
 669 /acc16 unstack16
 670 revAcc16Comp unstack16
 671 brne 675
 672 acc8= constant 72
 673 call writeLineAcc8
 674 ;test5.j(99)     if (one+four  != twelve/(one+2)) println(73);
 675 acc16= variable 2
 676 acc16+ variable 6
 677 <acc16
 678 acc16= variable 10
 679 <acc16= variable 2
 680 acc16+ constant 2
 681 /acc16 unstack16
 682 revAcc16Comp unstack16
 683 breq 687
 684 acc8= constant 73
 685 call writeLineAcc8
 686 ;test5.j(100)     if (one+one < twelve/(one+2)) println(74);
 687 acc16= variable 2
 688 acc16+ variable 2
 689 <acc16
 690 acc16= variable 10
 691 <acc16= variable 2
 692 acc16+ constant 2
 693 /acc16 unstack16
 694 revAcc16Comp unstack16
 695 brle 699
 696 acc8= constant 74
 697 call writeLineAcc8
 698 ;test5.j(101)     if (one+four > twelve/(one+2)) println(75);
 699 acc16= variable 2
 700 acc16+ variable 6
 701 <acc16
 702 acc16= variable 10
 703 <acc16= variable 2
 704 acc16+ constant 2
 705 /acc16 unstack16
 706 revAcc16Comp unstack16
 707 brge 711
 708 acc8= constant 75
 709 call writeLineAcc8
 710 ;test5.j(102)     if (one+one <= twelve/(one+2)) println(76);
 711 acc16= variable 2
 712 acc16+ variable 2
 713 <acc16
 714 acc16= variable 10
 715 <acc16= variable 2
 716 acc16+ constant 2
 717 /acc16 unstack16
 718 revAcc16Comp unstack16
 719 brlt 723
 720 acc8= constant 76
 721 call writeLineAcc8
 722 ;test5.j(103)     if (one+three <= twelve/(one+2)) println(77);
 723 acc16= variable 2
 724 acc16+ variable 4
 725 <acc16
 726 acc16= variable 10
 727 <acc16= variable 2
 728 acc16+ constant 2
 729 /acc16 unstack16
 730 revAcc16Comp unstack16
 731 brlt 735
 732 acc8= constant 77
 733 call writeLineAcc8
 734 ;test5.j(104)     if (one+three >= twelve/(one+2)) println(78);
 735 acc16= variable 2
 736 acc16+ variable 4
 737 <acc16
 738 acc16= variable 10
 739 <acc16= variable 2
 740 acc16+ constant 2
 741 /acc16 unstack16
 742 revAcc16Comp unstack16
 743 brgt 747
 744 acc8= constant 78
 745 call writeLineAcc8
 746 ;test5.j(105)     if (one+four >= twelve/(one+2)) println(79);
 747 acc16= variable 2
 748 acc16+ variable 6
 749 <acc16
 750 acc16= variable 10
 751 <acc16= variable 2
 752 acc16+ constant 2
 753 /acc16 unstack16
 754 revAcc16Comp unstack16
 755 brgt 759
 756 acc8= constant 79
 757 call writeLineAcc8
 758 ;test5.j(106)     if (four == 12/(1+2)) println(80);
 759 acc8= constant 12
 760 <acc8= constant 1
 761 acc8+ constant 2
 762 /acc8 unstack8
 763 acc16= variable 6
 764 acc16CompareAcc8
 765 brne 769
 766 acc8= constant 80
 767 call writeLineAcc8
 768 ;test5.j(107)     if (three != 12/(1+2)) println(81);
 769 acc8= constant 12
 770 <acc8= constant 1
 771 acc8+ constant 2
 772 /acc8 unstack8
 773 acc16= variable 4
 774 acc16CompareAcc8
 775 breq 779
 776 acc8= constant 81
 777 call writeLineAcc8
 778 ;test5.j(108)     if (three < 12/(1+2)) println(82);
 779 acc8= constant 12
 780 <acc8= constant 1
 781 acc8+ constant 2
 782 /acc8 unstack8
 783 acc16= variable 4
 784 acc16CompareAcc8
 785 brge 789
 786 acc8= constant 82
 787 call writeLineAcc8
 788 ;test5.j(109)     if (twelve > 12/(1+2)) println(83);
 789 acc8= constant 12
 790 <acc8= constant 1
 791 acc8+ constant 2
 792 /acc8 unstack8
 793 acc16= variable 10
 794 acc16CompareAcc8
 795 brle 799
 796 acc8= constant 83
 797 call writeLineAcc8
 798 ;test5.j(110)     if (four <= 12/(1+2)) println(84);
 799 acc8= constant 12
 800 <acc8= constant 1
 801 acc8+ constant 2
 802 /acc8 unstack8
 803 acc16= variable 6
 804 acc16CompareAcc8
 805 brgt 809
 806 acc8= constant 84
 807 call writeLineAcc8
 808 ;test5.j(111)     if (three <= 12/(1+2)) println(85);
 809 acc8= constant 12
 810 <acc8= constant 1
 811 acc8+ constant 2
 812 /acc8 unstack8
 813 acc16= variable 4
 814 acc16CompareAcc8
 815 brgt 819
 816 acc8= constant 85
 817 call writeLineAcc8
 818 ;test5.j(112)     if (four >= 12/(1+2)) println(86);
 819 acc8= constant 12
 820 <acc8= constant 1
 821 acc8+ constant 2
 822 /acc8 unstack8
 823 acc16= variable 6
 824 acc16CompareAcc8
 825 brlt 829
 826 acc8= constant 86
 827 call writeLineAcc8
 828 ;test5.j(113)     if (twelve >= 12/(1+2)) println(87);
 829 acc8= constant 12
 830 <acc8= constant 1
 831 acc8+ constant 2
 832 /acc8 unstack8
 833 acc16= variable 10
 834 acc16CompareAcc8
 835 brlt 839
 836 acc8= constant 87
 837 call writeLineAcc8
 838 ;test5.j(114)     if (four == twelve/(one+2)) println(88);
 839 acc16= variable 10
 840 <acc16= variable 2
 841 acc16+ constant 2
 842 /acc16 unstack16
 843 acc16Comp variable 6
 844 brne 848
 845 acc8= constant 88
 846 call writeLineAcc8
 847 ;test5.j(115)     if (three != twelve/(one+2)) println(89);
 848 acc16= variable 10
 849 <acc16= variable 2
 850 acc16+ constant 2
 851 /acc16 unstack16
 852 acc16Comp variable 4
 853 breq 857
 854 acc8= constant 89
 855 call writeLineAcc8
 856 ;test5.j(116)     if (three < twelve/(one+2)) println(90);
 857 acc16= variable 10
 858 <acc16= variable 2
 859 acc16+ constant 2
 860 /acc16 unstack16
 861 acc16Comp variable 4
 862 brle 866
 863 acc8= constant 90
 864 call writeLineAcc8
 865 ;test5.j(117)     if (twelve > twelve/(one+2)) println(91);
 866 acc16= variable 10
 867 <acc16= variable 2
 868 acc16+ constant 2
 869 /acc16 unstack16
 870 acc16Comp variable 10
 871 brge 875
 872 acc8= constant 91
 873 call writeLineAcc8
 874 ;test5.j(118)     if (four <= twelve/(one+2)) println(92);
 875 acc16= variable 10
 876 <acc16= variable 2
 877 acc16+ constant 2
 878 /acc16 unstack16
 879 acc16Comp variable 6
 880 brlt 884
 881 acc8= constant 92
 882 call writeLineAcc8
 883 ;test5.j(119)     if (three <= twelve/(one+2)) println(93);
 884 acc16= variable 10
 885 <acc16= variable 2
 886 acc16+ constant 2
 887 /acc16 unstack16
 888 acc16Comp variable 4
 889 brlt 893
 890 acc8= constant 93
 891 call writeLineAcc8
 892 ;test5.j(120)     if (four >= twelve/(one+2)) println(94);
 893 acc16= variable 10
 894 <acc16= variable 2
 895 acc16+ constant 2
 896 /acc16 unstack16
 897 acc16Comp variable 6
 898 brgt 902
 899 acc8= constant 94
 900 call writeLineAcc8
 901 ;test5.j(121)     if (twelve >= twelve/(one+2)) println(95);
 902 acc16= variable 10
 903 <acc16= variable 2
 904 acc16+ constant 2
 905 /acc16 unstack16
 906 acc16Comp variable 10
 907 brgt 911
 908 acc8= constant 95
 909 call writeLineAcc8
 910 ;test5.j(122)     if (1+3 == 12/(1+2)) println(96);
 911 acc8= constant 1
 912 acc8+ constant 3
 913 <acc8
 914 acc8= constant 12
 915 <acc8= constant 1
 916 acc8+ constant 2
 917 /acc8 unstack8
 918 revAcc8Comp unstack8
 919 brne 923
 920 acc8= constant 96
 921 call writeLineAcc8
 922 ;test5.j(123)     if (1+2 != 12/(1+2)) println(97);
 923 acc8= constant 1
 924 acc8+ constant 2
 925 <acc8
 926 acc8= constant 12
 927 <acc8= constant 1
 928 acc8+ constant 2
 929 /acc8 unstack8
 930 revAcc8Comp unstack8
 931 breq 935
 932 acc8= constant 97
 933 call writeLineAcc8
 934 ;test5.j(124)     if (1+2 < 12/(1+2)) println(98);
 935 acc8= constant 1
 936 acc8+ constant 2
 937 <acc8
 938 acc8= constant 12
 939 <acc8= constant 1
 940 acc8+ constant 2
 941 /acc8 unstack8
 942 revAcc8Comp unstack8
 943 brle 947
 944 acc8= constant 98
 945 call writeLineAcc8
 946 ;test5.j(125)     if (1+4 > 12/(1+2)) println(99);
 947 acc8= constant 1
 948 acc8+ constant 4
 949 <acc8
 950 acc8= constant 12
 951 <acc8= constant 1
 952 acc8+ constant 2
 953 /acc8 unstack8
 954 revAcc8Comp unstack8
 955 brge 959
 956 acc8= constant 99
 957 call writeLineAcc8
 958 ;test5.j(126)     if (1+2 <= 12/(1+2)) println(100);
 959 acc8= constant 1
 960 acc8+ constant 2
 961 <acc8
 962 acc8= constant 12
 963 <acc8= constant 1
 964 acc8+ constant 2
 965 /acc8 unstack8
 966 revAcc8Comp unstack8
 967 brlt 971
 968 acc8= constant 100
 969 call writeLineAcc8
 970 ;test5.j(127)     if (1+3 <= 12/(1+2)) println(101);
 971 acc8= constant 1
 972 acc8+ constant 3
 973 <acc8
 974 acc8= constant 12
 975 <acc8= constant 1
 976 acc8+ constant 2
 977 /acc8 unstack8
 978 revAcc8Comp unstack8
 979 brlt 983
 980 acc8= constant 101
 981 call writeLineAcc8
 982 ;test5.j(128)     if (1+3 >= 12/(1+2)) println(102);
 983 acc8= constant 1
 984 acc8+ constant 3
 985 <acc8
 986 acc8= constant 12
 987 <acc8= constant 1
 988 acc8+ constant 2
 989 /acc8 unstack8
 990 revAcc8Comp unstack8
 991 brgt 995
 992 acc8= constant 102
 993 call writeLineAcc8
 994 ;test5.j(129)     if (1+4 >= 12/(1+2)) println(103);
 995 acc8= constant 1
 996 acc8+ constant 4
 997 <acc8
 998 acc8= constant 12
 999 <acc8= constant 1
1000 acc8+ constant 2
1001 /acc8 unstack8
1002 revAcc8Comp unstack8
1003 brgt 1007
1004 acc8= constant 103
1005 call writeLineAcc8
1006 ;test5.j(130)     if (1+3 == twelve/(one+2)) println(104);
1007 acc8= constant 1
1008 acc8+ constant 3
1009 <acc8
1010 acc16= variable 10
1011 <acc16= variable 2
1012 acc16+ constant 2
1013 /acc16 unstack16
1014 acc8= unstack8
1015 acc8CompareAcc16
1016 brne 1020
1017 acc8= constant 104
1018 call writeLineAcc8
1019 ;test5.j(131)     if (1+2 != twelve/(one+2)) println(105);
1020 acc8= constant 1
1021 acc8+ constant 2
1022 <acc8
1023 acc16= variable 10
1024 <acc16= variable 2
1025 acc16+ constant 2
1026 /acc16 unstack16
1027 acc8= unstack8
1028 acc8CompareAcc16
1029 breq 1033
1030 acc8= constant 105
1031 call writeLineAcc8
1032 ;test5.j(132)     if (1+2 < twelve/(one+2)) println(106);
1033 acc8= constant 1
1034 acc8+ constant 2
1035 <acc8
1036 acc16= variable 10
1037 <acc16= variable 2
1038 acc16+ constant 2
1039 /acc16 unstack16
1040 acc8= unstack8
1041 acc8CompareAcc16
1042 brge 1046
1043 acc8= constant 106
1044 call writeLineAcc8
1045 ;test5.j(133)     if (1+4 > twelve/(one+2)) println(107);
1046 acc8= constant 1
1047 acc8+ constant 4
1048 <acc8
1049 acc16= variable 10
1050 <acc16= variable 2
1051 acc16+ constant 2
1052 /acc16 unstack16
1053 acc8= unstack8
1054 acc8CompareAcc16
1055 brle 1059
1056 acc8= constant 107
1057 call writeLineAcc8
1058 ;test5.j(134)     if (1+2 <= twelve/(one+2)) println(108);
1059 acc8= constant 1
1060 acc8+ constant 2
1061 <acc8
1062 acc16= variable 10
1063 <acc16= variable 2
1064 acc16+ constant 2
1065 /acc16 unstack16
1066 acc8= unstack8
1067 acc8CompareAcc16
1068 brgt 1072
1069 acc8= constant 108
1070 call writeLineAcc8
1071 ;test5.j(135)     if (1+3 <= twelve/(one+2)) println(109);
1072 acc8= constant 1
1073 acc8+ constant 3
1074 <acc8
1075 acc16= variable 10
1076 <acc16= variable 2
1077 acc16+ constant 2
1078 /acc16 unstack16
1079 acc8= unstack8
1080 acc8CompareAcc16
1081 brgt 1085
1082 acc8= constant 109
1083 call writeLineAcc8
1084 ;test5.j(136)     if (1+3 >= twelve/(one+2)) println(110);
1085 acc8= constant 1
1086 acc8+ constant 3
1087 <acc8
1088 acc16= variable 10
1089 <acc16= variable 2
1090 acc16+ constant 2
1091 /acc16 unstack16
1092 acc8= unstack8
1093 acc8CompareAcc16
1094 brlt 1098
1095 acc8= constant 110
1096 call writeLineAcc8
1097 ;test5.j(137)     if (1+4 >= twelve/(one+2)) println(111);
1098 acc8= constant 1
1099 acc8+ constant 4
1100 <acc8
1101 acc16= variable 10
1102 <acc16= variable 2
1103 acc16+ constant 2
1104 /acc16 unstack16
1105 acc8= unstack8
1106 acc8CompareAcc16
1107 brlt 1111
1108 acc8= constant 111
1109 call writeLineAcc8
1110 ;test5.j(138)     if (4 == 12/(1+2)) println(112);
1111 acc8= constant 12
1112 <acc8= constant 1
1113 acc8+ constant 2
1114 /acc8 unstack8
1115 acc8Comp constant 4
1116 brne 1120
1117 acc8= constant 112
1118 call writeLineAcc8
1119 ;test5.j(139)     if (3 != 12/(1+2)) println(113);
1120 acc8= constant 12
1121 <acc8= constant 1
1122 acc8+ constant 2
1123 /acc8 unstack8
1124 acc8Comp constant 3
1125 breq 1129
1126 acc8= constant 113
1127 call writeLineAcc8
1128 ;test5.j(140)     if (3 < 12/(1+2)) println(114);
1129 acc8= constant 12
1130 <acc8= constant 1
1131 acc8+ constant 2
1132 /acc8 unstack8
1133 acc8Comp constant 3
1134 brle 1138
1135 acc8= constant 114
1136 call writeLineAcc8
1137 ;test5.j(141)     if (5 > 12/(1+2)) println(115);
1138 acc8= constant 12
1139 <acc8= constant 1
1140 acc8+ constant 2
1141 /acc8 unstack8
1142 acc8Comp constant 5
1143 brge 1147
1144 acc8= constant 115
1145 call writeLineAcc8
1146 ;test5.j(142)     if (3 <= 12/(1+2)) println(116);
1147 acc8= constant 12
1148 <acc8= constant 1
1149 acc8+ constant 2
1150 /acc8 unstack8
1151 acc8Comp constant 3
1152 brlt 1156
1153 acc8= constant 116
1154 call writeLineAcc8
1155 ;test5.j(143)     if (4 <= 12/(1+2)) println(117);
1156 acc8= constant 12
1157 <acc8= constant 1
1158 acc8+ constant 2
1159 /acc8 unstack8
1160 acc8Comp constant 4
1161 brlt 1165
1162 acc8= constant 117
1163 call writeLineAcc8
1164 ;test5.j(144)     if (4 >= 12/(1+2)) println(118);
1165 acc8= constant 12
1166 <acc8= constant 1
1167 acc8+ constant 2
1168 /acc8 unstack8
1169 acc8Comp constant 4
1170 brgt 1174
1171 acc8= constant 118
1172 call writeLineAcc8
1173 ;test5.j(145)     if (5 >= 12/(1+2)) println(119);
1174 acc8= constant 12
1175 <acc8= constant 1
1176 acc8+ constant 2
1177 /acc8 unstack8
1178 acc8Comp constant 5
1179 brgt 1183
1180 acc8= constant 119
1181 call writeLineAcc8
1182 ;test5.j(146)     if (4 == twelve/(one+2)) println(120);
1183 acc16= variable 10
1184 <acc16= variable 2
1185 acc16+ constant 2
1186 /acc16 unstack16
1187 acc8= constant 4
1188 acc8CompareAcc16
1189 brne 1193
1190 acc8= constant 120
1191 call writeLineAcc8
1192 ;test5.j(147)     if (3 != twelve/(one+2)) println(121);
1193 acc16= variable 10
1194 <acc16= variable 2
1195 acc16+ constant 2
1196 /acc16 unstack16
1197 acc8= constant 3
1198 acc8CompareAcc16
1199 breq 1203
1200 acc8= constant 121
1201 call writeLineAcc8
1202 ;test5.j(148)     if (2 < twelve/(one+2)) println(122);
1203 acc16= variable 10
1204 <acc16= variable 2
1205 acc16+ constant 2
1206 /acc16 unstack16
1207 acc8= constant 2
1208 acc8CompareAcc16
1209 brge 1213
1210 acc8= constant 122
1211 call writeLineAcc8
1212 ;test5.j(149)     if (5 > twelve/(one+2)) println(123);
1213 acc16= variable 10
1214 <acc16= variable 2
1215 acc16+ constant 2
1216 /acc16 unstack16
1217 acc8= constant 5
1218 acc8CompareAcc16
1219 brle 1223
1220 acc8= constant 123
1221 call writeLineAcc8
1222 ;test5.j(150)     if (3 <= twelve/(one+2)) println(124);
1223 acc16= variable 10
1224 <acc16= variable 2
1225 acc16+ constant 2
1226 /acc16 unstack16
1227 acc8= constant 3
1228 acc8CompareAcc16
1229 brgt 1233
1230 acc8= constant 124
1231 call writeLineAcc8
1232 ;test5.j(151)     if (4 <= twelve/(one+2)) println(125);
1233 acc16= variable 10
1234 <acc16= variable 2
1235 acc16+ constant 2
1236 /acc16 unstack16
1237 acc8= constant 4
1238 acc8CompareAcc16
1239 brgt 1243
1240 acc8= constant 125
1241 call writeLineAcc8
1242 ;test5.j(152)     if (4 >= twelve/(one+2)) println(126);
1243 acc16= variable 10
1244 <acc16= variable 2
1245 acc16+ constant 2
1246 /acc16 unstack16
1247 acc8= constant 4
1248 acc8CompareAcc16
1249 brlt 1253
1250 acc8= constant 126
1251 call writeLineAcc8
1252 ;test5.j(153)     if (5 >= twelve/(one+2)) println(127);
1253 acc16= variable 10
1254 <acc16= variable 2
1255 acc16+ constant 2
1256 /acc16 unstack16
1257 acc8= constant 5
1258 acc8CompareAcc16
1259 brlt 1263
1260 acc8= constant 127
1261 call writeLineAcc8
1262 ;test5.j(154)     if (four == 0 + 12/(1 + 2)) println(128);
1263 acc8= constant 0
1264 <acc8= constant 12
1265 <acc8= constant 1
1266 acc8+ constant 2
1267 /acc8 unstack8
1268 acc8+ unstack8
1269 acc16= variable 6
1270 acc16CompareAcc8
1271 brne 1275
1272 acc8= constant 128
1273 call writeLineAcc8
1274 ;test5.j(155)     if (four == 0 + 12/(1 + 2)) println(129);
1275 acc8= constant 0
1276 <acc8= constant 12
1277 <acc8= constant 1
1278 acc8+ constant 2
1279 /acc8 unstack8
1280 acc8+ unstack8
1281 acc16= variable 6
1282 acc16CompareAcc8
1283 brne 1287
1284 acc8= constant 129
1285 call writeLineAcc8
1286 ;test5.j(156)     if (four == 0 + 12/(byteOne + 2)) println(130);
1287 acc8= constant 0
1288 <acc8= constant 12
1289 <acc8= variable 12
1290 acc8+ constant 2
1291 /acc8 unstack8
1292 acc8+ unstack8
1293 acc16= variable 6
1294 acc16CompareAcc8
1295 brne 1299
1296 acc8= constant 130
1297 call writeLineAcc8
1298 ;test5.j(157)     if (four == 0 + 12/(one + 2)) println(131);
1299 acc8= constant 0
1300 <acc8= constant 12
1301 acc16= variable 2
1302 acc16+ constant 2
1303 /acc16 acc8
1304 acc16+ unstack8
1305 acc16Comp variable 6
1306 brne 1310
1307 acc8= constant 131
1308 call writeLineAcc8
1309 ;test5.j(158)     if (4 == zero + twelve/(1+2)) println(132);
1310 acc16= variable 0
1311 <acc16= variable 10
1312 acc8= constant 1
1313 acc8+ constant 2
1314 acc16/ acc8
1315 acc16+ unstack16
1316 acc8= constant 4
1317 acc8CompareAcc16
1318 brne 1325
1319 acc8= constant 132
1320 call writeLineAcc8
1321 ;test5.j(159)   
1322 ;test5.j(160)     /************************/
1323 ;test5.j(161)     // global variable b used within if scope
1324 ;test5.j(162)     b = 133;
1325 acc8= constant 133
1326 acc8=> variable 14
1327 ;test5.j(163)     if (b>132) {
1328 acc8= variable 14
1329 acc8Comp constant 132
1330 brle 1347
1331 ;test5.j(164)       word j = 1001;
1332 acc16= constant 1001
1333 acc16=> variable 15
1334 ;test5.j(165)       byte c = b;
1335 acc8= variable 14
1336 acc8=> variable 17
1337 ;test5.j(166)       byte d = c;
1338 acc8= variable 17
1339 acc8=> variable 18
1340 ;test5.j(167)       b--;
1341 decr8 variable 14
1342 ;test5.j(168)       println (c);
1343 acc8= variable 17
1344 call writeLineAcc8
1345 ;test5.j(169)     } else {
1346 br 1354
1347 ;test5.j(170)       println(999);
1348 acc16= constant 999
1349 call writeLineAcc16
1350 ;test5.j(171)     }
1351 ;test5.j(172)   
1352 ;test5.j(173)     /************************/
1353 ;test5.j(174)     println (134);
1354 acc8= constant 134
1355 call writeLineAcc8
1356 ;test5.j(175)     println("Klaar");
1357 acc16= constant 1362
1358 writeLineString
1359 return
1360 ;test5.j(176)   }
1361 ;test5.j(177) }
1362 stringConstant 0 = "Klaar"
