   0 ;test5.j(0) /*
   1 ;test5.j(1)  * A small program in the miniJava language.
   2 ;test5.j(2)  * Test comparison
   3 ;test5.j(3)  */
   4 ;test5.j(4) class TestComparison {
   5 class TestComparison []
   6 ;test5.j(5)   private static word zero = 0;
   7 acc8= constant 0
   8 acc8=> variable 0
   9 ;test5.j(6)   private static word one = 1;
  10 acc8= constant 1
  11 acc8=> variable 2
  12 ;test5.j(7)   private static word three = 3;
  13 acc8= constant 3
  14 acc8=> variable 4
  15 ;test5.j(8)   private static word four = 4;
  16 acc8= constant 4
  17 acc8=> variable 6
  18 ;test5.j(9)   private static word five = 5;
  19 acc8= constant 5
  20 acc8=> variable 8
  21 ;test5.j(10)   private static word twelve = 12;
  22 acc8= constant 12
  23 acc8=> variable 10
  24 ;test5.j(11)   private static byte byteOne = 1;
  25 acc8= constant 1
  26 acc8=> variable 12
  27 ;test5.j(12)   private static byte byteSix = 262;
  28 acc16= constant 262
  29 acc16=> variable 13
  30 ;test5.j(13)   private static byte b;
  31 ;test5.j(14)   
  32 ;test5.j(15)   public static void main() {
  33 method main [public, static] void
  34 ;test5.j(16)     //stack level 1
  35 ;test5.j(17)     //byte-byte
  36 ;test5.j(18)     if (4 == 12/(1+2)) println(0);
  37 acc8= constant 12
  38 <acc8= constant 1
  39 acc8+ constant 2
  40 /acc8 unstack8
  41 acc8Comp constant 4
  42 brne 46
  43 acc8= constant 0
  44 call writeLineAcc8
  45 ;test5.j(19)     if (4 == 4) println(1);
  46 acc8= constant 4
  47 acc8Comp constant 4
  48 brne 52
  49 acc8= constant 1
  50 call writeLineAcc8
  51 ;test5.j(20)     if (3 != 12/(1+2)) println(2);
  52 acc8= constant 12
  53 <acc8= constant 1
  54 acc8+ constant 2
  55 /acc8 unstack8
  56 acc8Comp constant 3
  57 breq 61
  58 acc8= constant 2
  59 call writeLineAcc8
  60 ;test5.j(21)     if (3 != 4) println(3);
  61 acc8= constant 3
  62 acc8Comp constant 4
  63 breq 67
  64 acc8= constant 3
  65 call writeLineAcc8
  66 ;test5.j(22)     if (3 < 12/(1+2)) println(4);
  67 acc8= constant 12
  68 <acc8= constant 1
  69 acc8+ constant 2
  70 /acc8 unstack8
  71 acc8Comp constant 3
  72 brle 76
  73 acc8= constant 4
  74 call writeLineAcc8
  75 ;test5.j(23)     if (3 < 4) println(5);
  76 acc8= constant 3
  77 acc8Comp constant 4
  78 brge 82
  79 acc8= constant 5
  80 call writeLineAcc8
  81 ;test5.j(24)     if (5 > 12/(1+2)) println(6);
  82 acc8= constant 12
  83 <acc8= constant 1
  84 acc8+ constant 2
  85 /acc8 unstack8
  86 acc8Comp constant 5
  87 brge 91
  88 acc8= constant 6
  89 call writeLineAcc8
  90 ;test5.j(25)     if (5 > 4) println(7);
  91 acc8= constant 5
  92 acc8Comp constant 4
  93 brle 97
  94 acc8= constant 7
  95 call writeLineAcc8
  96 ;test5.j(26)     if (3 <= 12/(1+2)) println(8);
  97 acc8= constant 12
  98 <acc8= constant 1
  99 acc8+ constant 2
 100 /acc8 unstack8
 101 acc8Comp constant 3
 102 brlt 106
 103 acc8= constant 8
 104 call writeLineAcc8
 105 ;test5.j(27)     if (3 <= 4) println(9);
 106 acc8= constant 3
 107 acc8Comp constant 4
 108 brgt 112
 109 acc8= constant 9
 110 call writeLineAcc8
 111 ;test5.j(28)     if (4 <= 12/(1+2)) println(10);
 112 acc8= constant 12
 113 <acc8= constant 1
 114 acc8+ constant 2
 115 /acc8 unstack8
 116 acc8Comp constant 4
 117 brlt 121
 118 acc8= constant 10
 119 call writeLineAcc8
 120 ;test5.j(29)     if (4 <= 4) println(11);
 121 acc8= constant 4
 122 acc8Comp constant 4
 123 brgt 127
 124 acc8= constant 11
 125 call writeLineAcc8
 126 ;test5.j(30)     if (5 >= 12/(1+2)) println(12);
 127 acc8= constant 12
 128 <acc8= constant 1
 129 acc8+ constant 2
 130 /acc8 unstack8
 131 acc8Comp constant 5
 132 brgt 136
 133 acc8= constant 12
 134 call writeLineAcc8
 135 ;test5.j(31)     if (5 >= 4) println(13);
 136 acc8= constant 5
 137 acc8Comp constant 4
 138 brlt 142
 139 acc8= constant 13
 140 call writeLineAcc8
 141 ;test5.j(32)     if (4 >= 12/(1+2)) println(14);
 142 acc8= constant 12
 143 <acc8= constant 1
 144 acc8+ constant 2
 145 /acc8 unstack8
 146 acc8Comp constant 4
 147 brgt 151
 148 acc8= constant 14
 149 call writeLineAcc8
 150 ;test5.j(33)     if (4 >= 4) println(15);
 151 acc8= constant 4
 152 acc8Comp constant 4
 153 brlt 159
 154 acc8= constant 15
 155 call writeLineAcc8
 156 ;test5.j(34)     //stack level 1
 157 ;test5.j(35)     //byte-integer
 158 ;test5.j(36)     if (4 == twelve/(1+2)) println(16);
 159 acc16= variable 10
 160 acc8= constant 1
 161 acc8+ constant 2
 162 acc16/ acc8
 163 acc8= constant 4
 164 acc8CompareAcc16
 165 brne 169
 166 acc8= constant 16
 167 call writeLineAcc8
 168 ;test5.j(37)     if (4 == four) println(17);
 169 acc16= variable 6
 170 acc8= constant 4
 171 acc8CompareAcc16
 172 brne 176
 173 acc8= constant 17
 174 call writeLineAcc8
 175 ;test5.j(38)     if (3 != twelve/(1+2)) println(18);
 176 acc16= variable 10
 177 acc8= constant 1
 178 acc8+ constant 2
 179 acc16/ acc8
 180 acc8= constant 3
 181 acc8CompareAcc16
 182 breq 186
 183 acc8= constant 18
 184 call writeLineAcc8
 185 ;test5.j(39)     if (3 != four) println(19);
 186 acc16= variable 6
 187 acc8= constant 3
 188 acc8CompareAcc16
 189 breq 193
 190 acc8= constant 19
 191 call writeLineAcc8
 192 ;test5.j(40)     if (3 < twelve/(1+2)) println(20);
 193 acc16= variable 10
 194 acc8= constant 1
 195 acc8+ constant 2
 196 acc16/ acc8
 197 acc8= constant 3
 198 acc8CompareAcc16
 199 brge 203
 200 acc8= constant 20
 201 call writeLineAcc8
 202 ;test5.j(41)     if (3 < four) println(21);
 203 acc16= variable 6
 204 acc8= constant 3
 205 acc8CompareAcc16
 206 brge 210
 207 acc8= constant 21
 208 call writeLineAcc8
 209 ;test5.j(42)     if (5 > twelve/(1+2)) println(22);
 210 acc16= variable 10
 211 acc8= constant 1
 212 acc8+ constant 2
 213 acc16/ acc8
 214 acc8= constant 5
 215 acc8CompareAcc16
 216 brle 220
 217 acc8= constant 22
 218 call writeLineAcc8
 219 ;test5.j(43)     if (5 > four) println(23);
 220 acc16= variable 6
 221 acc8= constant 5
 222 acc8CompareAcc16
 223 brle 227
 224 acc8= constant 23
 225 call writeLineAcc8
 226 ;test5.j(44)     if (3 <= twelve/(1+2)) println(24);
 227 acc16= variable 10
 228 acc8= constant 1
 229 acc8+ constant 2
 230 acc16/ acc8
 231 acc8= constant 3
 232 acc8CompareAcc16
 233 brgt 237
 234 acc8= constant 24
 235 call writeLineAcc8
 236 ;test5.j(45)     if (3 <= four) println(25);
 237 acc16= variable 6
 238 acc8= constant 3
 239 acc8CompareAcc16
 240 brgt 244
 241 acc8= constant 25
 242 call writeLineAcc8
 243 ;test5.j(46)     if (4 <= twelve/(1+2)) println(26);
 244 acc16= variable 10
 245 acc8= constant 1
 246 acc8+ constant 2
 247 acc16/ acc8
 248 acc8= constant 4
 249 acc8CompareAcc16
 250 brgt 254
 251 acc8= constant 26
 252 call writeLineAcc8
 253 ;test5.j(47)     if (4 <= four) println(27);
 254 acc16= variable 6
 255 acc8= constant 4
 256 acc8CompareAcc16
 257 brgt 261
 258 acc8= constant 27
 259 call writeLineAcc8
 260 ;test5.j(48)     if (5 >= twelve/(1+2)) println(28);
 261 acc16= variable 10
 262 acc8= constant 1
 263 acc8+ constant 2
 264 acc16/ acc8
 265 acc8= constant 5
 266 acc8CompareAcc16
 267 brlt 271
 268 acc8= constant 28
 269 call writeLineAcc8
 270 ;test5.j(49)     if (5 >= four) println(29);
 271 acc16= variable 6
 272 acc8= constant 5
 273 acc8CompareAcc16
 274 brlt 278
 275 acc8= constant 29
 276 call writeLineAcc8
 277 ;test5.j(50)     if (4 >= twelve/(1+2)) println(30);
 278 acc16= variable 10
 279 acc8= constant 1
 280 acc8+ constant 2
 281 acc16/ acc8
 282 acc8= constant 4
 283 acc8CompareAcc16
 284 brlt 288
 285 acc8= constant 30
 286 call writeLineAcc8
 287 ;test5.j(51)     if (4 >= four) println(31);
 288 acc16= variable 6
 289 acc8= constant 4
 290 acc8CompareAcc16
 291 brlt 297
 292 acc8= constant 31
 293 call writeLineAcc8
 294 ;test5.j(52)     //stack level 1
 295 ;test5.j(53)     //integer-byte
 296 ;test5.j(54)     if (four == 12/(1+2)) println(32);
 297 acc8= constant 12
 298 <acc8= constant 1
 299 acc8+ constant 2
 300 /acc8 unstack8
 301 acc16= variable 6
 302 acc16CompareAcc8
 303 brne 307
 304 acc8= constant 32
 305 call writeLineAcc8
 306 ;test5.j(55)     if (four == 4) println(33);
 307 acc16= variable 6
 308 acc8= constant 4
 309 acc16CompareAcc8
 310 brne 314
 311 acc8= constant 33
 312 call writeLineAcc8
 313 ;test5.j(56)     if (three != 12/(1+2)) println(34);
 314 acc8= constant 12
 315 <acc8= constant 1
 316 acc8+ constant 2
 317 /acc8 unstack8
 318 acc16= variable 4
 319 acc16CompareAcc8
 320 breq 324
 321 acc8= constant 34
 322 call writeLineAcc8
 323 ;test5.j(57)     if (three != 4) println(35);
 324 acc16= variable 4
 325 acc8= constant 4
 326 acc16CompareAcc8
 327 breq 331
 328 acc8= constant 35
 329 call writeLineAcc8
 330 ;test5.j(58)     if (three < 12/(1+2)) println(36);
 331 acc8= constant 12
 332 <acc8= constant 1
 333 acc8+ constant 2
 334 /acc8 unstack8
 335 acc16= variable 4
 336 acc16CompareAcc8
 337 brge 341
 338 acc8= constant 36
 339 call writeLineAcc8
 340 ;test5.j(59)     if (three < 4) println(37);
 341 acc16= variable 4
 342 acc8= constant 4
 343 acc16CompareAcc8
 344 brge 348
 345 acc8= constant 37
 346 call writeLineAcc8
 347 ;test5.j(60)     if (five > 12/(1+2)) println(38);
 348 acc8= constant 12
 349 <acc8= constant 1
 350 acc8+ constant 2
 351 /acc8 unstack8
 352 acc16= variable 8
 353 acc16CompareAcc8
 354 brle 358
 355 acc8= constant 38
 356 call writeLineAcc8
 357 ;test5.j(61)     if (five > 4) println(39);
 358 acc16= variable 8
 359 acc8= constant 4
 360 acc16CompareAcc8
 361 brle 365
 362 acc8= constant 39
 363 call writeLineAcc8
 364 ;test5.j(62)     if (three <= 12/(1+2)) println(40);
 365 acc8= constant 12
 366 <acc8= constant 1
 367 acc8+ constant 2
 368 /acc8 unstack8
 369 acc16= variable 4
 370 acc16CompareAcc8
 371 brgt 375
 372 acc8= constant 40
 373 call writeLineAcc8
 374 ;test5.j(63)     if (three <= 4) println(41);
 375 acc16= variable 4
 376 acc8= constant 4
 377 acc16CompareAcc8
 378 brgt 382
 379 acc8= constant 41
 380 call writeLineAcc8
 381 ;test5.j(64)     if (four <= 12/(1+2)) println(42);
 382 acc8= constant 12
 383 <acc8= constant 1
 384 acc8+ constant 2
 385 /acc8 unstack8
 386 acc16= variable 6
 387 acc16CompareAcc8
 388 brgt 392
 389 acc8= constant 42
 390 call writeLineAcc8
 391 ;test5.j(65)     if (four <= 4) println(43);
 392 acc16= variable 6
 393 acc8= constant 4
 394 acc16CompareAcc8
 395 brgt 399
 396 acc8= constant 43
 397 call writeLineAcc8
 398 ;test5.j(66)     if (five >= 12/(1+2)) println(44);
 399 acc8= constant 12
 400 <acc8= constant 1
 401 acc8+ constant 2
 402 /acc8 unstack8
 403 acc16= variable 8
 404 acc16CompareAcc8
 405 brlt 409
 406 acc8= constant 44
 407 call writeLineAcc8
 408 ;test5.j(67)     if (five >= 4) println(45);
 409 acc16= variable 8
 410 acc8= constant 4
 411 acc16CompareAcc8
 412 brlt 416
 413 acc8= constant 45
 414 call writeLineAcc8
 415 ;test5.j(68)     if (four >= 12/(1+2)) println(46);
 416 acc8= constant 12
 417 <acc8= constant 1
 418 acc8+ constant 2
 419 /acc8 unstack8
 420 acc16= variable 6
 421 acc16CompareAcc8
 422 brlt 426
 423 acc8= constant 46
 424 call writeLineAcc8
 425 ;test5.j(69)     if (four >= 4) println(47);
 426 acc16= variable 6
 427 acc8= constant 4
 428 acc16CompareAcc8
 429 brlt 435
 430 acc8= constant 47
 431 call writeLineAcc8
 432 ;test5.j(70)     //stack level 1
 433 ;test5.j(71)     //integer-integer
 434 ;test5.j(72)     if (400 == 1200/(1+2)) println(48);
 435 acc16= constant 1200
 436 acc8= constant 1
 437 acc8+ constant 2
 438 acc16/ acc8
 439 acc16Comp constant 400
 440 brne 444
 441 acc8= constant 48
 442 call writeLineAcc8
 443 ;test5.j(73)     if (400 == 400) println(49);
 444 acc16= constant 400
 445 acc16Comp constant 400
 446 brne 450
 447 acc8= constant 49
 448 call writeLineAcc8
 449 ;test5.j(74)     if (300 != 1200/(1+2)) println(50);
 450 acc16= constant 1200
 451 acc8= constant 1
 452 acc8+ constant 2
 453 acc16/ acc8
 454 acc16Comp constant 300
 455 breq 459
 456 acc8= constant 50
 457 call writeLineAcc8
 458 ;test5.j(75)     if (300 != 400) println(51);
 459 acc16= constant 300
 460 acc16Comp constant 400
 461 breq 465
 462 acc8= constant 51
 463 call writeLineAcc8
 464 ;test5.j(76)     if (300 < 1200/(1+2)) println(52);
 465 acc16= constant 1200
 466 acc8= constant 1
 467 acc8+ constant 2
 468 acc16/ acc8
 469 acc16Comp constant 300
 470 brle 474
 471 acc8= constant 52
 472 call writeLineAcc8
 473 ;test5.j(77)     if (300 < 400) println(53);
 474 acc16= constant 300
 475 acc16Comp constant 400
 476 brge 480
 477 acc8= constant 53
 478 call writeLineAcc8
 479 ;test5.j(78)     if (500 > 1200/(1+2)) println(54);
 480 acc16= constant 1200
 481 acc8= constant 1
 482 acc8+ constant 2
 483 acc16/ acc8
 484 acc16Comp constant 500
 485 brge 489
 486 acc8= constant 54
 487 call writeLineAcc8
 488 ;test5.j(79)     if (500 > 400) println(55);
 489 acc16= constant 500
 490 acc16Comp constant 400
 491 brle 495
 492 acc8= constant 55
 493 call writeLineAcc8
 494 ;test5.j(80)     if (300 <= 1200/(1+2)) println(56);
 495 acc16= constant 1200
 496 acc8= constant 1
 497 acc8+ constant 2
 498 acc16/ acc8
 499 acc16Comp constant 300
 500 brlt 504
 501 acc8= constant 56
 502 call writeLineAcc8
 503 ;test5.j(81)     if (300 <= 400) println(57);
 504 acc16= constant 300
 505 acc16Comp constant 400
 506 brgt 510
 507 acc8= constant 57
 508 call writeLineAcc8
 509 ;test5.j(82)     if (400 <= 1200/(1+2)) println(58);
 510 acc16= constant 1200
 511 acc8= constant 1
 512 acc8+ constant 2
 513 acc16/ acc8
 514 acc16Comp constant 400
 515 brlt 519
 516 acc8= constant 58
 517 call writeLineAcc8
 518 ;test5.j(83)     if (400 <= 400) println(59);
 519 acc16= constant 400
 520 acc16Comp constant 400
 521 brgt 525
 522 acc8= constant 59
 523 call writeLineAcc8
 524 ;test5.j(84)     if (500 >= 1200/(1+2)) println(60);
 525 acc16= constant 1200
 526 acc8= constant 1
 527 acc8+ constant 2
 528 acc16/ acc8
 529 acc16Comp constant 500
 530 brgt 534
 531 acc8= constant 60
 532 call writeLineAcc8
 533 ;test5.j(85)     if (500 >= 400) println(61);
 534 acc16= constant 500
 535 acc16Comp constant 400
 536 brlt 540
 537 acc8= constant 61
 538 call writeLineAcc8
 539 ;test5.j(86)     if (400 >= 1200/(1+2)) println(62);
 540 acc16= constant 1200
 541 acc8= constant 1
 542 acc8+ constant 2
 543 acc16/ acc8
 544 acc16Comp constant 400
 545 brgt 549
 546 acc8= constant 62
 547 call writeLineAcc8
 548 ;test5.j(87)     if (400 >= 400) println(63);
 549 acc16= constant 400
 550 acc16Comp constant 400
 551 brlt 557
 552 acc8= constant 63
 553 call writeLineAcc8
 554 ;test5.j(88)   
 555 ;test5.j(89)     //stack level 2
 556 ;test5.j(90)     if (one+three == 12/(1+2)) println(64);
 557 acc16= variable 2
 558 acc16+ variable 4
 559 <acc16
 560 acc8= constant 12
 561 <acc8= constant 1
 562 acc8+ constant 2
 563 /acc8 unstack8
 564 acc16= unstack16
 565 acc16CompareAcc8
 566 brne 570
 567 acc8= constant 64
 568 call writeLineAcc8
 569 ;test5.j(91)     if (one+four  != 12/(1+2)) println(65);
 570 acc16= variable 2
 571 acc16+ variable 6
 572 <acc16
 573 acc8= constant 12
 574 <acc8= constant 1
 575 acc8+ constant 2
 576 /acc8 unstack8
 577 acc16= unstack16
 578 acc16CompareAcc8
 579 breq 583
 580 acc8= constant 65
 581 call writeLineAcc8
 582 ;test5.j(92)     if (one+one < 12/(1+2)) println(66);
 583 acc16= variable 2
 584 acc16+ variable 2
 585 <acc16
 586 acc8= constant 12
 587 <acc8= constant 1
 588 acc8+ constant 2
 589 /acc8 unstack8
 590 acc16= unstack16
 591 acc16CompareAcc8
 592 brge 596
 593 acc8= constant 66
 594 call writeLineAcc8
 595 ;test5.j(93)     if (one+four > 12/(1+2)) println(67);
 596 acc16= variable 2
 597 acc16+ variable 6
 598 <acc16
 599 acc8= constant 12
 600 <acc8= constant 1
 601 acc8+ constant 2
 602 /acc8 unstack8
 603 acc16= unstack16
 604 acc16CompareAcc8
 605 brle 609
 606 acc8= constant 67
 607 call writeLineAcc8
 608 ;test5.j(94)     if (one+one <= 12/(1+2)) println(68);
 609 acc16= variable 2
 610 acc16+ variable 2
 611 <acc16
 612 acc8= constant 12
 613 <acc8= constant 1
 614 acc8+ constant 2
 615 /acc8 unstack8
 616 acc16= unstack16
 617 acc16CompareAcc8
 618 brgt 622
 619 acc8= constant 68
 620 call writeLineAcc8
 621 ;test5.j(95)     if (one+three <= 12/(1+2)) println(69);
 622 acc16= variable 2
 623 acc16+ variable 4
 624 <acc16
 625 acc8= constant 12
 626 <acc8= constant 1
 627 acc8+ constant 2
 628 /acc8 unstack8
 629 acc16= unstack16
 630 acc16CompareAcc8
 631 brgt 635
 632 acc8= constant 69
 633 call writeLineAcc8
 634 ;test5.j(96)     if (one+three >= 12/(1+2)) println(70);
 635 acc16= variable 2
 636 acc16+ variable 4
 637 <acc16
 638 acc8= constant 12
 639 <acc8= constant 1
 640 acc8+ constant 2
 641 /acc8 unstack8
 642 acc16= unstack16
 643 acc16CompareAcc8
 644 brlt 648
 645 acc8= constant 70
 646 call writeLineAcc8
 647 ;test5.j(97)     if (one+four >= 12/(1+2)) println(71);
 648 acc16= variable 2
 649 acc16+ variable 6
 650 <acc16
 651 acc8= constant 12
 652 <acc8= constant 1
 653 acc8+ constant 2
 654 /acc8 unstack8
 655 acc16= unstack16
 656 acc16CompareAcc8
 657 brlt 661
 658 acc8= constant 71
 659 call writeLineAcc8
 660 ;test5.j(98)     if (one+three == twelve/(one+2)) println(72);
 661 acc16= variable 2
 662 acc16+ variable 4
 663 <acc16
 664 acc16= variable 10
 665 <acc16= variable 2
 666 acc16+ constant 2
 667 /acc16 unstack16
 668 revAcc16Comp unstack16
 669 brne 673
 670 acc8= constant 72
 671 call writeLineAcc8
 672 ;test5.j(99)     if (one+four  != twelve/(one+2)) println(73);
 673 acc16= variable 2
 674 acc16+ variable 6
 675 <acc16
 676 acc16= variable 10
 677 <acc16= variable 2
 678 acc16+ constant 2
 679 /acc16 unstack16
 680 revAcc16Comp unstack16
 681 breq 685
 682 acc8= constant 73
 683 call writeLineAcc8
 684 ;test5.j(100)     if (one+one < twelve/(one+2)) println(74);
 685 acc16= variable 2
 686 acc16+ variable 2
 687 <acc16
 688 acc16= variable 10
 689 <acc16= variable 2
 690 acc16+ constant 2
 691 /acc16 unstack16
 692 revAcc16Comp unstack16
 693 brle 697
 694 acc8= constant 74
 695 call writeLineAcc8
 696 ;test5.j(101)     if (one+four > twelve/(one+2)) println(75);
 697 acc16= variable 2
 698 acc16+ variable 6
 699 <acc16
 700 acc16= variable 10
 701 <acc16= variable 2
 702 acc16+ constant 2
 703 /acc16 unstack16
 704 revAcc16Comp unstack16
 705 brge 709
 706 acc8= constant 75
 707 call writeLineAcc8
 708 ;test5.j(102)     if (one+one <= twelve/(one+2)) println(76);
 709 acc16= variable 2
 710 acc16+ variable 2
 711 <acc16
 712 acc16= variable 10
 713 <acc16= variable 2
 714 acc16+ constant 2
 715 /acc16 unstack16
 716 revAcc16Comp unstack16
 717 brlt 721
 718 acc8= constant 76
 719 call writeLineAcc8
 720 ;test5.j(103)     if (one+three <= twelve/(one+2)) println(77);
 721 acc16= variable 2
 722 acc16+ variable 4
 723 <acc16
 724 acc16= variable 10
 725 <acc16= variable 2
 726 acc16+ constant 2
 727 /acc16 unstack16
 728 revAcc16Comp unstack16
 729 brlt 733
 730 acc8= constant 77
 731 call writeLineAcc8
 732 ;test5.j(104)     if (one+three >= twelve/(one+2)) println(78);
 733 acc16= variable 2
 734 acc16+ variable 4
 735 <acc16
 736 acc16= variable 10
 737 <acc16= variable 2
 738 acc16+ constant 2
 739 /acc16 unstack16
 740 revAcc16Comp unstack16
 741 brgt 745
 742 acc8= constant 78
 743 call writeLineAcc8
 744 ;test5.j(105)     if (one+four >= twelve/(one+2)) println(79);
 745 acc16= variable 2
 746 acc16+ variable 6
 747 <acc16
 748 acc16= variable 10
 749 <acc16= variable 2
 750 acc16+ constant 2
 751 /acc16 unstack16
 752 revAcc16Comp unstack16
 753 brgt 757
 754 acc8= constant 79
 755 call writeLineAcc8
 756 ;test5.j(106)     if (four == 12/(1+2)) println(80);
 757 acc8= constant 12
 758 <acc8= constant 1
 759 acc8+ constant 2
 760 /acc8 unstack8
 761 acc16= variable 6
 762 acc16CompareAcc8
 763 brne 767
 764 acc8= constant 80
 765 call writeLineAcc8
 766 ;test5.j(107)     if (three != 12/(1+2)) println(81);
 767 acc8= constant 12
 768 <acc8= constant 1
 769 acc8+ constant 2
 770 /acc8 unstack8
 771 acc16= variable 4
 772 acc16CompareAcc8
 773 breq 777
 774 acc8= constant 81
 775 call writeLineAcc8
 776 ;test5.j(108)     if (three < 12/(1+2)) println(82);
 777 acc8= constant 12
 778 <acc8= constant 1
 779 acc8+ constant 2
 780 /acc8 unstack8
 781 acc16= variable 4
 782 acc16CompareAcc8
 783 brge 787
 784 acc8= constant 82
 785 call writeLineAcc8
 786 ;test5.j(109)     if (twelve > 12/(1+2)) println(83);
 787 acc8= constant 12
 788 <acc8= constant 1
 789 acc8+ constant 2
 790 /acc8 unstack8
 791 acc16= variable 10
 792 acc16CompareAcc8
 793 brle 797
 794 acc8= constant 83
 795 call writeLineAcc8
 796 ;test5.j(110)     if (four <= 12/(1+2)) println(84);
 797 acc8= constant 12
 798 <acc8= constant 1
 799 acc8+ constant 2
 800 /acc8 unstack8
 801 acc16= variable 6
 802 acc16CompareAcc8
 803 brgt 807
 804 acc8= constant 84
 805 call writeLineAcc8
 806 ;test5.j(111)     if (three <= 12/(1+2)) println(85);
 807 acc8= constant 12
 808 <acc8= constant 1
 809 acc8+ constant 2
 810 /acc8 unstack8
 811 acc16= variable 4
 812 acc16CompareAcc8
 813 brgt 817
 814 acc8= constant 85
 815 call writeLineAcc8
 816 ;test5.j(112)     if (four >= 12/(1+2)) println(86);
 817 acc8= constant 12
 818 <acc8= constant 1
 819 acc8+ constant 2
 820 /acc8 unstack8
 821 acc16= variable 6
 822 acc16CompareAcc8
 823 brlt 827
 824 acc8= constant 86
 825 call writeLineAcc8
 826 ;test5.j(113)     if (twelve >= 12/(1+2)) println(87);
 827 acc8= constant 12
 828 <acc8= constant 1
 829 acc8+ constant 2
 830 /acc8 unstack8
 831 acc16= variable 10
 832 acc16CompareAcc8
 833 brlt 837
 834 acc8= constant 87
 835 call writeLineAcc8
 836 ;test5.j(114)     if (four == twelve/(one+2)) println(88);
 837 acc16= variable 10
 838 <acc16= variable 2
 839 acc16+ constant 2
 840 /acc16 unstack16
 841 acc16Comp variable 6
 842 brne 846
 843 acc8= constant 88
 844 call writeLineAcc8
 845 ;test5.j(115)     if (three != twelve/(one+2)) println(89);
 846 acc16= variable 10
 847 <acc16= variable 2
 848 acc16+ constant 2
 849 /acc16 unstack16
 850 acc16Comp variable 4
 851 breq 855
 852 acc8= constant 89
 853 call writeLineAcc8
 854 ;test5.j(116)     if (three < twelve/(one+2)) println(90);
 855 acc16= variable 10
 856 <acc16= variable 2
 857 acc16+ constant 2
 858 /acc16 unstack16
 859 acc16Comp variable 4
 860 brle 864
 861 acc8= constant 90
 862 call writeLineAcc8
 863 ;test5.j(117)     if (twelve > twelve/(one+2)) println(91);
 864 acc16= variable 10
 865 <acc16= variable 2
 866 acc16+ constant 2
 867 /acc16 unstack16
 868 acc16Comp variable 10
 869 brge 873
 870 acc8= constant 91
 871 call writeLineAcc8
 872 ;test5.j(118)     if (four <= twelve/(one+2)) println(92);
 873 acc16= variable 10
 874 <acc16= variable 2
 875 acc16+ constant 2
 876 /acc16 unstack16
 877 acc16Comp variable 6
 878 brlt 882
 879 acc8= constant 92
 880 call writeLineAcc8
 881 ;test5.j(119)     if (three <= twelve/(one+2)) println(93);
 882 acc16= variable 10
 883 <acc16= variable 2
 884 acc16+ constant 2
 885 /acc16 unstack16
 886 acc16Comp variable 4
 887 brlt 891
 888 acc8= constant 93
 889 call writeLineAcc8
 890 ;test5.j(120)     if (four >= twelve/(one+2)) println(94);
 891 acc16= variable 10
 892 <acc16= variable 2
 893 acc16+ constant 2
 894 /acc16 unstack16
 895 acc16Comp variable 6
 896 brgt 900
 897 acc8= constant 94
 898 call writeLineAcc8
 899 ;test5.j(121)     if (twelve >= twelve/(one+2)) println(95);
 900 acc16= variable 10
 901 <acc16= variable 2
 902 acc16+ constant 2
 903 /acc16 unstack16
 904 acc16Comp variable 10
 905 brgt 909
 906 acc8= constant 95
 907 call writeLineAcc8
 908 ;test5.j(122)     if (1+3 == 12/(1+2)) println(96);
 909 acc8= constant 1
 910 acc8+ constant 3
 911 <acc8
 912 acc8= constant 12
 913 <acc8= constant 1
 914 acc8+ constant 2
 915 /acc8 unstack8
 916 revAcc8Comp unstack8
 917 brne 921
 918 acc8= constant 96
 919 call writeLineAcc8
 920 ;test5.j(123)     if (1+2 != 12/(1+2)) println(97);
 921 acc8= constant 1
 922 acc8+ constant 2
 923 <acc8
 924 acc8= constant 12
 925 <acc8= constant 1
 926 acc8+ constant 2
 927 /acc8 unstack8
 928 revAcc8Comp unstack8
 929 breq 933
 930 acc8= constant 97
 931 call writeLineAcc8
 932 ;test5.j(124)     if (1+2 < 12/(1+2)) println(98);
 933 acc8= constant 1
 934 acc8+ constant 2
 935 <acc8
 936 acc8= constant 12
 937 <acc8= constant 1
 938 acc8+ constant 2
 939 /acc8 unstack8
 940 revAcc8Comp unstack8
 941 brle 945
 942 acc8= constant 98
 943 call writeLineAcc8
 944 ;test5.j(125)     if (1+4 > 12/(1+2)) println(99);
 945 acc8= constant 1
 946 acc8+ constant 4
 947 <acc8
 948 acc8= constant 12
 949 <acc8= constant 1
 950 acc8+ constant 2
 951 /acc8 unstack8
 952 revAcc8Comp unstack8
 953 brge 957
 954 acc8= constant 99
 955 call writeLineAcc8
 956 ;test5.j(126)     if (1+2 <= 12/(1+2)) println(100);
 957 acc8= constant 1
 958 acc8+ constant 2
 959 <acc8
 960 acc8= constant 12
 961 <acc8= constant 1
 962 acc8+ constant 2
 963 /acc8 unstack8
 964 revAcc8Comp unstack8
 965 brlt 969
 966 acc8= constant 100
 967 call writeLineAcc8
 968 ;test5.j(127)     if (1+3 <= 12/(1+2)) println(101);
 969 acc8= constant 1
 970 acc8+ constant 3
 971 <acc8
 972 acc8= constant 12
 973 <acc8= constant 1
 974 acc8+ constant 2
 975 /acc8 unstack8
 976 revAcc8Comp unstack8
 977 brlt 981
 978 acc8= constant 101
 979 call writeLineAcc8
 980 ;test5.j(128)     if (1+3 >= 12/(1+2)) println(102);
 981 acc8= constant 1
 982 acc8+ constant 3
 983 <acc8
 984 acc8= constant 12
 985 <acc8= constant 1
 986 acc8+ constant 2
 987 /acc8 unstack8
 988 revAcc8Comp unstack8
 989 brgt 993
 990 acc8= constant 102
 991 call writeLineAcc8
 992 ;test5.j(129)     if (1+4 >= 12/(1+2)) println(103);
 993 acc8= constant 1
 994 acc8+ constant 4
 995 <acc8
 996 acc8= constant 12
 997 <acc8= constant 1
 998 acc8+ constant 2
 999 /acc8 unstack8
1000 revAcc8Comp unstack8
1001 brgt 1005
1002 acc8= constant 103
1003 call writeLineAcc8
1004 ;test5.j(130)     if (1+3 == twelve/(one+2)) println(104);
1005 acc8= constant 1
1006 acc8+ constant 3
1007 <acc8
1008 acc16= variable 10
1009 <acc16= variable 2
1010 acc16+ constant 2
1011 /acc16 unstack16
1012 acc8= unstack8
1013 acc8CompareAcc16
1014 brne 1018
1015 acc8= constant 104
1016 call writeLineAcc8
1017 ;test5.j(131)     if (1+2 != twelve/(one+2)) println(105);
1018 acc8= constant 1
1019 acc8+ constant 2
1020 <acc8
1021 acc16= variable 10
1022 <acc16= variable 2
1023 acc16+ constant 2
1024 /acc16 unstack16
1025 acc8= unstack8
1026 acc8CompareAcc16
1027 breq 1031
1028 acc8= constant 105
1029 call writeLineAcc8
1030 ;test5.j(132)     if (1+2 < twelve/(one+2)) println(106);
1031 acc8= constant 1
1032 acc8+ constant 2
1033 <acc8
1034 acc16= variable 10
1035 <acc16= variable 2
1036 acc16+ constant 2
1037 /acc16 unstack16
1038 acc8= unstack8
1039 acc8CompareAcc16
1040 brge 1044
1041 acc8= constant 106
1042 call writeLineAcc8
1043 ;test5.j(133)     if (1+4 > twelve/(one+2)) println(107);
1044 acc8= constant 1
1045 acc8+ constant 4
1046 <acc8
1047 acc16= variable 10
1048 <acc16= variable 2
1049 acc16+ constant 2
1050 /acc16 unstack16
1051 acc8= unstack8
1052 acc8CompareAcc16
1053 brle 1057
1054 acc8= constant 107
1055 call writeLineAcc8
1056 ;test5.j(134)     if (1+2 <= twelve/(one+2)) println(108);
1057 acc8= constant 1
1058 acc8+ constant 2
1059 <acc8
1060 acc16= variable 10
1061 <acc16= variable 2
1062 acc16+ constant 2
1063 /acc16 unstack16
1064 acc8= unstack8
1065 acc8CompareAcc16
1066 brgt 1070
1067 acc8= constant 108
1068 call writeLineAcc8
1069 ;test5.j(135)     if (1+3 <= twelve/(one+2)) println(109);
1070 acc8= constant 1
1071 acc8+ constant 3
1072 <acc8
1073 acc16= variable 10
1074 <acc16= variable 2
1075 acc16+ constant 2
1076 /acc16 unstack16
1077 acc8= unstack8
1078 acc8CompareAcc16
1079 brgt 1083
1080 acc8= constant 109
1081 call writeLineAcc8
1082 ;test5.j(136)     if (1+3 >= twelve/(one+2)) println(110);
1083 acc8= constant 1
1084 acc8+ constant 3
1085 <acc8
1086 acc16= variable 10
1087 <acc16= variable 2
1088 acc16+ constant 2
1089 /acc16 unstack16
1090 acc8= unstack8
1091 acc8CompareAcc16
1092 brlt 1096
1093 acc8= constant 110
1094 call writeLineAcc8
1095 ;test5.j(137)     if (1+4 >= twelve/(one+2)) println(111);
1096 acc8= constant 1
1097 acc8+ constant 4
1098 <acc8
1099 acc16= variable 10
1100 <acc16= variable 2
1101 acc16+ constant 2
1102 /acc16 unstack16
1103 acc8= unstack8
1104 acc8CompareAcc16
1105 brlt 1109
1106 acc8= constant 111
1107 call writeLineAcc8
1108 ;test5.j(138)     if (4 == 12/(1+2)) println(112);
1109 acc8= constant 12
1110 <acc8= constant 1
1111 acc8+ constant 2
1112 /acc8 unstack8
1113 acc8Comp constant 4
1114 brne 1118
1115 acc8= constant 112
1116 call writeLineAcc8
1117 ;test5.j(139)     if (3 != 12/(1+2)) println(113);
1118 acc8= constant 12
1119 <acc8= constant 1
1120 acc8+ constant 2
1121 /acc8 unstack8
1122 acc8Comp constant 3
1123 breq 1127
1124 acc8= constant 113
1125 call writeLineAcc8
1126 ;test5.j(140)     if (3 < 12/(1+2)) println(114);
1127 acc8= constant 12
1128 <acc8= constant 1
1129 acc8+ constant 2
1130 /acc8 unstack8
1131 acc8Comp constant 3
1132 brle 1136
1133 acc8= constant 114
1134 call writeLineAcc8
1135 ;test5.j(141)     if (5 > 12/(1+2)) println(115);
1136 acc8= constant 12
1137 <acc8= constant 1
1138 acc8+ constant 2
1139 /acc8 unstack8
1140 acc8Comp constant 5
1141 brge 1145
1142 acc8= constant 115
1143 call writeLineAcc8
1144 ;test5.j(142)     if (3 <= 12/(1+2)) println(116);
1145 acc8= constant 12
1146 <acc8= constant 1
1147 acc8+ constant 2
1148 /acc8 unstack8
1149 acc8Comp constant 3
1150 brlt 1154
1151 acc8= constant 116
1152 call writeLineAcc8
1153 ;test5.j(143)     if (4 <= 12/(1+2)) println(117);
1154 acc8= constant 12
1155 <acc8= constant 1
1156 acc8+ constant 2
1157 /acc8 unstack8
1158 acc8Comp constant 4
1159 brlt 1163
1160 acc8= constant 117
1161 call writeLineAcc8
1162 ;test5.j(144)     if (4 >= 12/(1+2)) println(118);
1163 acc8= constant 12
1164 <acc8= constant 1
1165 acc8+ constant 2
1166 /acc8 unstack8
1167 acc8Comp constant 4
1168 brgt 1172
1169 acc8= constant 118
1170 call writeLineAcc8
1171 ;test5.j(145)     if (5 >= 12/(1+2)) println(119);
1172 acc8= constant 12
1173 <acc8= constant 1
1174 acc8+ constant 2
1175 /acc8 unstack8
1176 acc8Comp constant 5
1177 brgt 1181
1178 acc8= constant 119
1179 call writeLineAcc8
1180 ;test5.j(146)     if (4 == twelve/(one+2)) println(120);
1181 acc16= variable 10
1182 <acc16= variable 2
1183 acc16+ constant 2
1184 /acc16 unstack16
1185 acc8= constant 4
1186 acc8CompareAcc16
1187 brne 1191
1188 acc8= constant 120
1189 call writeLineAcc8
1190 ;test5.j(147)     if (3 != twelve/(one+2)) println(121);
1191 acc16= variable 10
1192 <acc16= variable 2
1193 acc16+ constant 2
1194 /acc16 unstack16
1195 acc8= constant 3
1196 acc8CompareAcc16
1197 breq 1201
1198 acc8= constant 121
1199 call writeLineAcc8
1200 ;test5.j(148)     if (2 < twelve/(one+2)) println(122);
1201 acc16= variable 10
1202 <acc16= variable 2
1203 acc16+ constant 2
1204 /acc16 unstack16
1205 acc8= constant 2
1206 acc8CompareAcc16
1207 brge 1211
1208 acc8= constant 122
1209 call writeLineAcc8
1210 ;test5.j(149)     if (5 > twelve/(one+2)) println(123);
1211 acc16= variable 10
1212 <acc16= variable 2
1213 acc16+ constant 2
1214 /acc16 unstack16
1215 acc8= constant 5
1216 acc8CompareAcc16
1217 brle 1221
1218 acc8= constant 123
1219 call writeLineAcc8
1220 ;test5.j(150)     if (3 <= twelve/(one+2)) println(124);
1221 acc16= variable 10
1222 <acc16= variable 2
1223 acc16+ constant 2
1224 /acc16 unstack16
1225 acc8= constant 3
1226 acc8CompareAcc16
1227 brgt 1231
1228 acc8= constant 124
1229 call writeLineAcc8
1230 ;test5.j(151)     if (4 <= twelve/(one+2)) println(125);
1231 acc16= variable 10
1232 <acc16= variable 2
1233 acc16+ constant 2
1234 /acc16 unstack16
1235 acc8= constant 4
1236 acc8CompareAcc16
1237 brgt 1241
1238 acc8= constant 125
1239 call writeLineAcc8
1240 ;test5.j(152)     if (4 >= twelve/(one+2)) println(126);
1241 acc16= variable 10
1242 <acc16= variable 2
1243 acc16+ constant 2
1244 /acc16 unstack16
1245 acc8= constant 4
1246 acc8CompareAcc16
1247 brlt 1251
1248 acc8= constant 126
1249 call writeLineAcc8
1250 ;test5.j(153)     if (5 >= twelve/(one+2)) println(127);
1251 acc16= variable 10
1252 <acc16= variable 2
1253 acc16+ constant 2
1254 /acc16 unstack16
1255 acc8= constant 5
1256 acc8CompareAcc16
1257 brlt 1261
1258 acc8= constant 127
1259 call writeLineAcc8
1260 ;test5.j(154)     if (four == 0 + 12/(1 + 2)) println(128);
1261 acc8= constant 0
1262 <acc8= constant 12
1263 <acc8= constant 1
1264 acc8+ constant 2
1265 /acc8 unstack8
1266 acc8+ unstack8
1267 acc16= variable 6
1268 acc16CompareAcc8
1269 brne 1273
1270 acc8= constant 128
1271 call writeLineAcc8
1272 ;test5.j(155)     if (four == 0 + 12/(1 + 2)) println(129);
1273 acc8= constant 0
1274 <acc8= constant 12
1275 <acc8= constant 1
1276 acc8+ constant 2
1277 /acc8 unstack8
1278 acc8+ unstack8
1279 acc16= variable 6
1280 acc16CompareAcc8
1281 brne 1285
1282 acc8= constant 129
1283 call writeLineAcc8
1284 ;test5.j(156)     if (four == 0 + 12/(byteOne + 2)) println(130);
1285 acc8= constant 0
1286 <acc8= constant 12
1287 <acc8= variable 12
1288 acc8+ constant 2
1289 /acc8 unstack8
1290 acc8+ unstack8
1291 acc16= variable 6
1292 acc16CompareAcc8
1293 brne 1297
1294 acc8= constant 130
1295 call writeLineAcc8
1296 ;test5.j(157)     if (four == 0 + 12/(one + 2)) println(131);
1297 acc8= constant 0
1298 <acc8= constant 12
1299 acc16= variable 2
1300 acc16+ constant 2
1301 /acc16 acc8
1302 acc16+ unstack8
1303 acc16Comp variable 6
1304 brne 1308
1305 acc8= constant 131
1306 call writeLineAcc8
1307 ;test5.j(158)     if (4 == zero + twelve/(1+2)) println(132);
1308 acc16= variable 0
1309 <acc16= variable 10
1310 acc8= constant 1
1311 acc8+ constant 2
1312 acc16/ acc8
1313 acc16+ unstack16
1314 acc8= constant 4
1315 acc8CompareAcc16
1316 brne 1323
1317 acc8= constant 132
1318 call writeLineAcc8
1319 ;test5.j(159)   
1320 ;test5.j(160)     /************************/
1321 ;test5.j(161)     // global variable b used within if scope
1322 ;test5.j(162)     b = 133;
1323 acc8= constant 133
1324 acc8=> variable 14
1325 ;test5.j(163)     if (b>132) {
1326 acc8= variable 14
1327 acc8Comp constant 132
1328 brle 1346
1329 ;test5.j(164)       word j = 1001;
1330 acc16= constant 1001
1331 acc16=> variable 15
1332 ;test5.j(165)       byte c = b;
1333 acc8= variable 14
1334 acc8=> variable 17
1335 ;test5.j(166)       byte d = c;
1336 acc8= variable 17
1337 acc8=> variable 18
1338 ;test5.j(167)       b--;
1339 decr8 variable 14
1340 ;test5.j(168)       println (c);
1341 acc8= variable 17
1342 call writeLineAcc8
1343 ;test5.j(169)     } else {
1344 br 1352
1345 ;test5.j(170)       println(999);
1346 acc16= constant 999
1347 call writeLineAcc16
1348 ;test5.j(171)     }
1349 ;test5.j(172)   
1350 ;test5.j(173)     /************************/
1351 ;test5.j(174)     println (134);
1352 acc8= constant 134
1353 call writeLineAcc8
1354 ;test5.j(175)     println("Klaar");
1355 acc16= constant 1361
1356 writeLineString
1357 ;test5.j(176)   }
1358 ;test5.j(177) }
1359 ;test5.j(178) //comment after final }.
1360 stop
1361 stringConstant 0 = "Klaar"
