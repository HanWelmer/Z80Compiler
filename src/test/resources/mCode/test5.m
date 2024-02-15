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
  32 ;test5.j(15)   static word j = 1001;
  33 acc16= constant 1001
  34 acc16=> variable 15
  35 ;test5.j(16)   static byte c = b;
  36 acc8= variable 14
  37 acc8=> variable 17
  38 ;test5.j(17)   static byte d = c;
  39 acc8= variable 17
  40 acc8=> variable 18
  41 ;test5.j(18)   
  42 ;test5.j(19)   public static void main() {
  43 method main [public, static] void
  44 ;test5.j(20)     //stack level 1
  45 ;test5.j(21)     //byte-byte
  46 ;test5.j(22)     if (4 == 12/(1+2)) println(0);
  47 acc8= constant 12
  48 <acc8= constant 1
  49 acc8+ constant 2
  50 /acc8 unstack8
  51 acc8Comp constant 4
  52 brne 56
  53 acc8= constant 0
  54 call writeLineAcc8
  55 ;test5.j(23)     if (4 == 4) println(1);
  56 acc8= constant 4
  57 acc8Comp constant 4
  58 brne 62
  59 acc8= constant 1
  60 call writeLineAcc8
  61 ;test5.j(24)     if (3 != 12/(1+2)) println(2);
  62 acc8= constant 12
  63 <acc8= constant 1
  64 acc8+ constant 2
  65 /acc8 unstack8
  66 acc8Comp constant 3
  67 breq 71
  68 acc8= constant 2
  69 call writeLineAcc8
  70 ;test5.j(25)     if (3 != 4) println(3);
  71 acc8= constant 3
  72 acc8Comp constant 4
  73 breq 77
  74 acc8= constant 3
  75 call writeLineAcc8
  76 ;test5.j(26)     if (3 < 12/(1+2)) println(4);
  77 acc8= constant 12
  78 <acc8= constant 1
  79 acc8+ constant 2
  80 /acc8 unstack8
  81 acc8Comp constant 3
  82 brle 86
  83 acc8= constant 4
  84 call writeLineAcc8
  85 ;test5.j(27)     if (3 < 4) println(5);
  86 acc8= constant 3
  87 acc8Comp constant 4
  88 brge 92
  89 acc8= constant 5
  90 call writeLineAcc8
  91 ;test5.j(28)     if (5 > 12/(1+2)) println(6);
  92 acc8= constant 12
  93 <acc8= constant 1
  94 acc8+ constant 2
  95 /acc8 unstack8
  96 acc8Comp constant 5
  97 brge 101
  98 acc8= constant 6
  99 call writeLineAcc8
 100 ;test5.j(29)     if (5 > 4) println(7);
 101 acc8= constant 5
 102 acc8Comp constant 4
 103 brle 107
 104 acc8= constant 7
 105 call writeLineAcc8
 106 ;test5.j(30)     if (3 <= 12/(1+2)) println(8);
 107 acc8= constant 12
 108 <acc8= constant 1
 109 acc8+ constant 2
 110 /acc8 unstack8
 111 acc8Comp constant 3
 112 brlt 116
 113 acc8= constant 8
 114 call writeLineAcc8
 115 ;test5.j(31)     if (3 <= 4) println(9);
 116 acc8= constant 3
 117 acc8Comp constant 4
 118 brgt 122
 119 acc8= constant 9
 120 call writeLineAcc8
 121 ;test5.j(32)     if (4 <= 12/(1+2)) println(10);
 122 acc8= constant 12
 123 <acc8= constant 1
 124 acc8+ constant 2
 125 /acc8 unstack8
 126 acc8Comp constant 4
 127 brlt 131
 128 acc8= constant 10
 129 call writeLineAcc8
 130 ;test5.j(33)     if (4 <= 4) println(11);
 131 acc8= constant 4
 132 acc8Comp constant 4
 133 brgt 137
 134 acc8= constant 11
 135 call writeLineAcc8
 136 ;test5.j(34)     if (5 >= 12/(1+2)) println(12);
 137 acc8= constant 12
 138 <acc8= constant 1
 139 acc8+ constant 2
 140 /acc8 unstack8
 141 acc8Comp constant 5
 142 brgt 146
 143 acc8= constant 12
 144 call writeLineAcc8
 145 ;test5.j(35)     if (5 >= 4) println(13);
 146 acc8= constant 5
 147 acc8Comp constant 4
 148 brlt 152
 149 acc8= constant 13
 150 call writeLineAcc8
 151 ;test5.j(36)     if (4 >= 12/(1+2)) println(14);
 152 acc8= constant 12
 153 <acc8= constant 1
 154 acc8+ constant 2
 155 /acc8 unstack8
 156 acc8Comp constant 4
 157 brgt 161
 158 acc8= constant 14
 159 call writeLineAcc8
 160 ;test5.j(37)     if (4 >= 4) println(15);
 161 acc8= constant 4
 162 acc8Comp constant 4
 163 brlt 169
 164 acc8= constant 15
 165 call writeLineAcc8
 166 ;test5.j(38)     //stack level 1
 167 ;test5.j(39)     //byte-integer
 168 ;test5.j(40)     if (4 == twelve/(1+2)) println(16);
 169 acc16= variable 10
 170 acc8= constant 1
 171 acc8+ constant 2
 172 acc16/ acc8
 173 acc8= constant 4
 174 acc8CompareAcc16
 175 brne 179
 176 acc8= constant 16
 177 call writeLineAcc8
 178 ;test5.j(41)     if (4 == four) println(17);
 179 acc16= variable 6
 180 acc8= constant 4
 181 acc8CompareAcc16
 182 brne 186
 183 acc8= constant 17
 184 call writeLineAcc8
 185 ;test5.j(42)     if (3 != twelve/(1+2)) println(18);
 186 acc16= variable 10
 187 acc8= constant 1
 188 acc8+ constant 2
 189 acc16/ acc8
 190 acc8= constant 3
 191 acc8CompareAcc16
 192 breq 196
 193 acc8= constant 18
 194 call writeLineAcc8
 195 ;test5.j(43)     if (3 != four) println(19);
 196 acc16= variable 6
 197 acc8= constant 3
 198 acc8CompareAcc16
 199 breq 203
 200 acc8= constant 19
 201 call writeLineAcc8
 202 ;test5.j(44)     if (3 < twelve/(1+2)) println(20);
 203 acc16= variable 10
 204 acc8= constant 1
 205 acc8+ constant 2
 206 acc16/ acc8
 207 acc8= constant 3
 208 acc8CompareAcc16
 209 brge 213
 210 acc8= constant 20
 211 call writeLineAcc8
 212 ;test5.j(45)     if (3 < four) println(21);
 213 acc16= variable 6
 214 acc8= constant 3
 215 acc8CompareAcc16
 216 brge 220
 217 acc8= constant 21
 218 call writeLineAcc8
 219 ;test5.j(46)     if (5 > twelve/(1+2)) println(22);
 220 acc16= variable 10
 221 acc8= constant 1
 222 acc8+ constant 2
 223 acc16/ acc8
 224 acc8= constant 5
 225 acc8CompareAcc16
 226 brle 230
 227 acc8= constant 22
 228 call writeLineAcc8
 229 ;test5.j(47)     if (5 > four) println(23);
 230 acc16= variable 6
 231 acc8= constant 5
 232 acc8CompareAcc16
 233 brle 237
 234 acc8= constant 23
 235 call writeLineAcc8
 236 ;test5.j(48)     if (3 <= twelve/(1+2)) println(24);
 237 acc16= variable 10
 238 acc8= constant 1
 239 acc8+ constant 2
 240 acc16/ acc8
 241 acc8= constant 3
 242 acc8CompareAcc16
 243 brgt 247
 244 acc8= constant 24
 245 call writeLineAcc8
 246 ;test5.j(49)     if (3 <= four) println(25);
 247 acc16= variable 6
 248 acc8= constant 3
 249 acc8CompareAcc16
 250 brgt 254
 251 acc8= constant 25
 252 call writeLineAcc8
 253 ;test5.j(50)     if (4 <= twelve/(1+2)) println(26);
 254 acc16= variable 10
 255 acc8= constant 1
 256 acc8+ constant 2
 257 acc16/ acc8
 258 acc8= constant 4
 259 acc8CompareAcc16
 260 brgt 264
 261 acc8= constant 26
 262 call writeLineAcc8
 263 ;test5.j(51)     if (4 <= four) println(27);
 264 acc16= variable 6
 265 acc8= constant 4
 266 acc8CompareAcc16
 267 brgt 271
 268 acc8= constant 27
 269 call writeLineAcc8
 270 ;test5.j(52)     if (5 >= twelve/(1+2)) println(28);
 271 acc16= variable 10
 272 acc8= constant 1
 273 acc8+ constant 2
 274 acc16/ acc8
 275 acc8= constant 5
 276 acc8CompareAcc16
 277 brlt 281
 278 acc8= constant 28
 279 call writeLineAcc8
 280 ;test5.j(53)     if (5 >= four) println(29);
 281 acc16= variable 6
 282 acc8= constant 5
 283 acc8CompareAcc16
 284 brlt 288
 285 acc8= constant 29
 286 call writeLineAcc8
 287 ;test5.j(54)     if (4 >= twelve/(1+2)) println(30);
 288 acc16= variable 10
 289 acc8= constant 1
 290 acc8+ constant 2
 291 acc16/ acc8
 292 acc8= constant 4
 293 acc8CompareAcc16
 294 brlt 298
 295 acc8= constant 30
 296 call writeLineAcc8
 297 ;test5.j(55)     if (4 >= four) println(31);
 298 acc16= variable 6
 299 acc8= constant 4
 300 acc8CompareAcc16
 301 brlt 307
 302 acc8= constant 31
 303 call writeLineAcc8
 304 ;test5.j(56)     //stack level 1
 305 ;test5.j(57)     //integer-byte
 306 ;test5.j(58)     if (four == 12/(1+2)) println(32);
 307 acc8= constant 12
 308 <acc8= constant 1
 309 acc8+ constant 2
 310 /acc8 unstack8
 311 acc16= variable 6
 312 acc16CompareAcc8
 313 brne 317
 314 acc8= constant 32
 315 call writeLineAcc8
 316 ;test5.j(59)     if (four == 4) println(33);
 317 acc16= variable 6
 318 acc8= constant 4
 319 acc16CompareAcc8
 320 brne 324
 321 acc8= constant 33
 322 call writeLineAcc8
 323 ;test5.j(60)     if (three != 12/(1+2)) println(34);
 324 acc8= constant 12
 325 <acc8= constant 1
 326 acc8+ constant 2
 327 /acc8 unstack8
 328 acc16= variable 4
 329 acc16CompareAcc8
 330 breq 334
 331 acc8= constant 34
 332 call writeLineAcc8
 333 ;test5.j(61)     if (three != 4) println(35);
 334 acc16= variable 4
 335 acc8= constant 4
 336 acc16CompareAcc8
 337 breq 341
 338 acc8= constant 35
 339 call writeLineAcc8
 340 ;test5.j(62)     if (three < 12/(1+2)) println(36);
 341 acc8= constant 12
 342 <acc8= constant 1
 343 acc8+ constant 2
 344 /acc8 unstack8
 345 acc16= variable 4
 346 acc16CompareAcc8
 347 brge 351
 348 acc8= constant 36
 349 call writeLineAcc8
 350 ;test5.j(63)     if (three < 4) println(37);
 351 acc16= variable 4
 352 acc8= constant 4
 353 acc16CompareAcc8
 354 brge 358
 355 acc8= constant 37
 356 call writeLineAcc8
 357 ;test5.j(64)     if (five > 12/(1+2)) println(38);
 358 acc8= constant 12
 359 <acc8= constant 1
 360 acc8+ constant 2
 361 /acc8 unstack8
 362 acc16= variable 8
 363 acc16CompareAcc8
 364 brle 368
 365 acc8= constant 38
 366 call writeLineAcc8
 367 ;test5.j(65)     if (five > 4) println(39);
 368 acc16= variable 8
 369 acc8= constant 4
 370 acc16CompareAcc8
 371 brle 375
 372 acc8= constant 39
 373 call writeLineAcc8
 374 ;test5.j(66)     if (three <= 12/(1+2)) println(40);
 375 acc8= constant 12
 376 <acc8= constant 1
 377 acc8+ constant 2
 378 /acc8 unstack8
 379 acc16= variable 4
 380 acc16CompareAcc8
 381 brgt 385
 382 acc8= constant 40
 383 call writeLineAcc8
 384 ;test5.j(67)     if (three <= 4) println(41);
 385 acc16= variable 4
 386 acc8= constant 4
 387 acc16CompareAcc8
 388 brgt 392
 389 acc8= constant 41
 390 call writeLineAcc8
 391 ;test5.j(68)     if (four <= 12/(1+2)) println(42);
 392 acc8= constant 12
 393 <acc8= constant 1
 394 acc8+ constant 2
 395 /acc8 unstack8
 396 acc16= variable 6
 397 acc16CompareAcc8
 398 brgt 402
 399 acc8= constant 42
 400 call writeLineAcc8
 401 ;test5.j(69)     if (four <= 4) println(43);
 402 acc16= variable 6
 403 acc8= constant 4
 404 acc16CompareAcc8
 405 brgt 409
 406 acc8= constant 43
 407 call writeLineAcc8
 408 ;test5.j(70)     if (five >= 12/(1+2)) println(44);
 409 acc8= constant 12
 410 <acc8= constant 1
 411 acc8+ constant 2
 412 /acc8 unstack8
 413 acc16= variable 8
 414 acc16CompareAcc8
 415 brlt 419
 416 acc8= constant 44
 417 call writeLineAcc8
 418 ;test5.j(71)     if (five >= 4) println(45);
 419 acc16= variable 8
 420 acc8= constant 4
 421 acc16CompareAcc8
 422 brlt 426
 423 acc8= constant 45
 424 call writeLineAcc8
 425 ;test5.j(72)     if (four >= 12/(1+2)) println(46);
 426 acc8= constant 12
 427 <acc8= constant 1
 428 acc8+ constant 2
 429 /acc8 unstack8
 430 acc16= variable 6
 431 acc16CompareAcc8
 432 brlt 436
 433 acc8= constant 46
 434 call writeLineAcc8
 435 ;test5.j(73)     if (four >= 4) println(47);
 436 acc16= variable 6
 437 acc8= constant 4
 438 acc16CompareAcc8
 439 brlt 445
 440 acc8= constant 47
 441 call writeLineAcc8
 442 ;test5.j(74)     //stack level 1
 443 ;test5.j(75)     //integer-integer
 444 ;test5.j(76)     if (400 == 1200/(1+2)) println(48);
 445 acc16= constant 1200
 446 acc8= constant 1
 447 acc8+ constant 2
 448 acc16/ acc8
 449 acc16Comp constant 400
 450 brne 454
 451 acc8= constant 48
 452 call writeLineAcc8
 453 ;test5.j(77)     if (400 == 400) println(49);
 454 acc16= constant 400
 455 acc16Comp constant 400
 456 brne 460
 457 acc8= constant 49
 458 call writeLineAcc8
 459 ;test5.j(78)     if (300 != 1200/(1+2)) println(50);
 460 acc16= constant 1200
 461 acc8= constant 1
 462 acc8+ constant 2
 463 acc16/ acc8
 464 acc16Comp constant 300
 465 breq 469
 466 acc8= constant 50
 467 call writeLineAcc8
 468 ;test5.j(79)     if (300 != 400) println(51);
 469 acc16= constant 300
 470 acc16Comp constant 400
 471 breq 475
 472 acc8= constant 51
 473 call writeLineAcc8
 474 ;test5.j(80)     if (300 < 1200/(1+2)) println(52);
 475 acc16= constant 1200
 476 acc8= constant 1
 477 acc8+ constant 2
 478 acc16/ acc8
 479 acc16Comp constant 300
 480 brle 484
 481 acc8= constant 52
 482 call writeLineAcc8
 483 ;test5.j(81)     if (300 < 400) println(53);
 484 acc16= constant 300
 485 acc16Comp constant 400
 486 brge 490
 487 acc8= constant 53
 488 call writeLineAcc8
 489 ;test5.j(82)     if (500 > 1200/(1+2)) println(54);
 490 acc16= constant 1200
 491 acc8= constant 1
 492 acc8+ constant 2
 493 acc16/ acc8
 494 acc16Comp constant 500
 495 brge 499
 496 acc8= constant 54
 497 call writeLineAcc8
 498 ;test5.j(83)     if (500 > 400) println(55);
 499 acc16= constant 500
 500 acc16Comp constant 400
 501 brle 505
 502 acc8= constant 55
 503 call writeLineAcc8
 504 ;test5.j(84)     if (300 <= 1200/(1+2)) println(56);
 505 acc16= constant 1200
 506 acc8= constant 1
 507 acc8+ constant 2
 508 acc16/ acc8
 509 acc16Comp constant 300
 510 brlt 514
 511 acc8= constant 56
 512 call writeLineAcc8
 513 ;test5.j(85)     if (300 <= 400) println(57);
 514 acc16= constant 300
 515 acc16Comp constant 400
 516 brgt 520
 517 acc8= constant 57
 518 call writeLineAcc8
 519 ;test5.j(86)     if (400 <= 1200/(1+2)) println(58);
 520 acc16= constant 1200
 521 acc8= constant 1
 522 acc8+ constant 2
 523 acc16/ acc8
 524 acc16Comp constant 400
 525 brlt 529
 526 acc8= constant 58
 527 call writeLineAcc8
 528 ;test5.j(87)     if (400 <= 400) println(59);
 529 acc16= constant 400
 530 acc16Comp constant 400
 531 brgt 535
 532 acc8= constant 59
 533 call writeLineAcc8
 534 ;test5.j(88)     if (500 >= 1200/(1+2)) println(60);
 535 acc16= constant 1200
 536 acc8= constant 1
 537 acc8+ constant 2
 538 acc16/ acc8
 539 acc16Comp constant 500
 540 brgt 544
 541 acc8= constant 60
 542 call writeLineAcc8
 543 ;test5.j(89)     if (500 >= 400) println(61);
 544 acc16= constant 500
 545 acc16Comp constant 400
 546 brlt 550
 547 acc8= constant 61
 548 call writeLineAcc8
 549 ;test5.j(90)     if (400 >= 1200/(1+2)) println(62);
 550 acc16= constant 1200
 551 acc8= constant 1
 552 acc8+ constant 2
 553 acc16/ acc8
 554 acc16Comp constant 400
 555 brgt 559
 556 acc8= constant 62
 557 call writeLineAcc8
 558 ;test5.j(91)     if (400 >= 400) println(63);
 559 acc16= constant 400
 560 acc16Comp constant 400
 561 brlt 567
 562 acc8= constant 63
 563 call writeLineAcc8
 564 ;test5.j(92)   
 565 ;test5.j(93)     //stack level 2
 566 ;test5.j(94)     if (one+three == 12/(1+2)) println(64);
 567 acc16= variable 2
 568 acc16+ variable 4
 569 <acc16
 570 acc8= constant 12
 571 <acc8= constant 1
 572 acc8+ constant 2
 573 /acc8 unstack8
 574 acc16= unstack16
 575 acc16CompareAcc8
 576 brne 580
 577 acc8= constant 64
 578 call writeLineAcc8
 579 ;test5.j(95)     if (one+four  != 12/(1+2)) println(65);
 580 acc16= variable 2
 581 acc16+ variable 6
 582 <acc16
 583 acc8= constant 12
 584 <acc8= constant 1
 585 acc8+ constant 2
 586 /acc8 unstack8
 587 acc16= unstack16
 588 acc16CompareAcc8
 589 breq 593
 590 acc8= constant 65
 591 call writeLineAcc8
 592 ;test5.j(96)     if (one+one < 12/(1+2)) println(66);
 593 acc16= variable 2
 594 acc16+ variable 2
 595 <acc16
 596 acc8= constant 12
 597 <acc8= constant 1
 598 acc8+ constant 2
 599 /acc8 unstack8
 600 acc16= unstack16
 601 acc16CompareAcc8
 602 brge 606
 603 acc8= constant 66
 604 call writeLineAcc8
 605 ;test5.j(97)     if (one+four > 12/(1+2)) println(67);
 606 acc16= variable 2
 607 acc16+ variable 6
 608 <acc16
 609 acc8= constant 12
 610 <acc8= constant 1
 611 acc8+ constant 2
 612 /acc8 unstack8
 613 acc16= unstack16
 614 acc16CompareAcc8
 615 brle 619
 616 acc8= constant 67
 617 call writeLineAcc8
 618 ;test5.j(98)     if (one+one <= 12/(1+2)) println(68);
 619 acc16= variable 2
 620 acc16+ variable 2
 621 <acc16
 622 acc8= constant 12
 623 <acc8= constant 1
 624 acc8+ constant 2
 625 /acc8 unstack8
 626 acc16= unstack16
 627 acc16CompareAcc8
 628 brgt 632
 629 acc8= constant 68
 630 call writeLineAcc8
 631 ;test5.j(99)     if (one+three <= 12/(1+2)) println(69);
 632 acc16= variable 2
 633 acc16+ variable 4
 634 <acc16
 635 acc8= constant 12
 636 <acc8= constant 1
 637 acc8+ constant 2
 638 /acc8 unstack8
 639 acc16= unstack16
 640 acc16CompareAcc8
 641 brgt 645
 642 acc8= constant 69
 643 call writeLineAcc8
 644 ;test5.j(100)     if (one+three >= 12/(1+2)) println(70);
 645 acc16= variable 2
 646 acc16+ variable 4
 647 <acc16
 648 acc8= constant 12
 649 <acc8= constant 1
 650 acc8+ constant 2
 651 /acc8 unstack8
 652 acc16= unstack16
 653 acc16CompareAcc8
 654 brlt 658
 655 acc8= constant 70
 656 call writeLineAcc8
 657 ;test5.j(101)     if (one+four >= 12/(1+2)) println(71);
 658 acc16= variable 2
 659 acc16+ variable 6
 660 <acc16
 661 acc8= constant 12
 662 <acc8= constant 1
 663 acc8+ constant 2
 664 /acc8 unstack8
 665 acc16= unstack16
 666 acc16CompareAcc8
 667 brlt 671
 668 acc8= constant 71
 669 call writeLineAcc8
 670 ;test5.j(102)     if (one+three == twelve/(one+2)) println(72);
 671 acc16= variable 2
 672 acc16+ variable 4
 673 <acc16
 674 acc16= variable 10
 675 <acc16= variable 2
 676 acc16+ constant 2
 677 /acc16 unstack16
 678 revAcc16Comp unstack16
 679 brne 683
 680 acc8= constant 72
 681 call writeLineAcc8
 682 ;test5.j(103)     if (one+four  != twelve/(one+2)) println(73);
 683 acc16= variable 2
 684 acc16+ variable 6
 685 <acc16
 686 acc16= variable 10
 687 <acc16= variable 2
 688 acc16+ constant 2
 689 /acc16 unstack16
 690 revAcc16Comp unstack16
 691 breq 695
 692 acc8= constant 73
 693 call writeLineAcc8
 694 ;test5.j(104)     if (one+one < twelve/(one+2)) println(74);
 695 acc16= variable 2
 696 acc16+ variable 2
 697 <acc16
 698 acc16= variable 10
 699 <acc16= variable 2
 700 acc16+ constant 2
 701 /acc16 unstack16
 702 revAcc16Comp unstack16
 703 brle 707
 704 acc8= constant 74
 705 call writeLineAcc8
 706 ;test5.j(105)     if (one+four > twelve/(one+2)) println(75);
 707 acc16= variable 2
 708 acc16+ variable 6
 709 <acc16
 710 acc16= variable 10
 711 <acc16= variable 2
 712 acc16+ constant 2
 713 /acc16 unstack16
 714 revAcc16Comp unstack16
 715 brge 719
 716 acc8= constant 75
 717 call writeLineAcc8
 718 ;test5.j(106)     if (one+one <= twelve/(one+2)) println(76);
 719 acc16= variable 2
 720 acc16+ variable 2
 721 <acc16
 722 acc16= variable 10
 723 <acc16= variable 2
 724 acc16+ constant 2
 725 /acc16 unstack16
 726 revAcc16Comp unstack16
 727 brlt 731
 728 acc8= constant 76
 729 call writeLineAcc8
 730 ;test5.j(107)     if (one+three <= twelve/(one+2)) println(77);
 731 acc16= variable 2
 732 acc16+ variable 4
 733 <acc16
 734 acc16= variable 10
 735 <acc16= variable 2
 736 acc16+ constant 2
 737 /acc16 unstack16
 738 revAcc16Comp unstack16
 739 brlt 743
 740 acc8= constant 77
 741 call writeLineAcc8
 742 ;test5.j(108)     if (one+three >= twelve/(one+2)) println(78);
 743 acc16= variable 2
 744 acc16+ variable 4
 745 <acc16
 746 acc16= variable 10
 747 <acc16= variable 2
 748 acc16+ constant 2
 749 /acc16 unstack16
 750 revAcc16Comp unstack16
 751 brgt 755
 752 acc8= constant 78
 753 call writeLineAcc8
 754 ;test5.j(109)     if (one+four >= twelve/(one+2)) println(79);
 755 acc16= variable 2
 756 acc16+ variable 6
 757 <acc16
 758 acc16= variable 10
 759 <acc16= variable 2
 760 acc16+ constant 2
 761 /acc16 unstack16
 762 revAcc16Comp unstack16
 763 brgt 767
 764 acc8= constant 79
 765 call writeLineAcc8
 766 ;test5.j(110)     if (four == 12/(1+2)) println(80);
 767 acc8= constant 12
 768 <acc8= constant 1
 769 acc8+ constant 2
 770 /acc8 unstack8
 771 acc16= variable 6
 772 acc16CompareAcc8
 773 brne 777
 774 acc8= constant 80
 775 call writeLineAcc8
 776 ;test5.j(111)     if (three != 12/(1+2)) println(81);
 777 acc8= constant 12
 778 <acc8= constant 1
 779 acc8+ constant 2
 780 /acc8 unstack8
 781 acc16= variable 4
 782 acc16CompareAcc8
 783 breq 787
 784 acc8= constant 81
 785 call writeLineAcc8
 786 ;test5.j(112)     if (three < 12/(1+2)) println(82);
 787 acc8= constant 12
 788 <acc8= constant 1
 789 acc8+ constant 2
 790 /acc8 unstack8
 791 acc16= variable 4
 792 acc16CompareAcc8
 793 brge 797
 794 acc8= constant 82
 795 call writeLineAcc8
 796 ;test5.j(113)     if (twelve > 12/(1+2)) println(83);
 797 acc8= constant 12
 798 <acc8= constant 1
 799 acc8+ constant 2
 800 /acc8 unstack8
 801 acc16= variable 10
 802 acc16CompareAcc8
 803 brle 807
 804 acc8= constant 83
 805 call writeLineAcc8
 806 ;test5.j(114)     if (four <= 12/(1+2)) println(84);
 807 acc8= constant 12
 808 <acc8= constant 1
 809 acc8+ constant 2
 810 /acc8 unstack8
 811 acc16= variable 6
 812 acc16CompareAcc8
 813 brgt 817
 814 acc8= constant 84
 815 call writeLineAcc8
 816 ;test5.j(115)     if (three <= 12/(1+2)) println(85);
 817 acc8= constant 12
 818 <acc8= constant 1
 819 acc8+ constant 2
 820 /acc8 unstack8
 821 acc16= variable 4
 822 acc16CompareAcc8
 823 brgt 827
 824 acc8= constant 85
 825 call writeLineAcc8
 826 ;test5.j(116)     if (four >= 12/(1+2)) println(86);
 827 acc8= constant 12
 828 <acc8= constant 1
 829 acc8+ constant 2
 830 /acc8 unstack8
 831 acc16= variable 6
 832 acc16CompareAcc8
 833 brlt 837
 834 acc8= constant 86
 835 call writeLineAcc8
 836 ;test5.j(117)     if (twelve >= 12/(1+2)) println(87);
 837 acc8= constant 12
 838 <acc8= constant 1
 839 acc8+ constant 2
 840 /acc8 unstack8
 841 acc16= variable 10
 842 acc16CompareAcc8
 843 brlt 847
 844 acc8= constant 87
 845 call writeLineAcc8
 846 ;test5.j(118)     if (four == twelve/(one+2)) println(88);
 847 acc16= variable 10
 848 <acc16= variable 2
 849 acc16+ constant 2
 850 /acc16 unstack16
 851 acc16Comp variable 6
 852 brne 856
 853 acc8= constant 88
 854 call writeLineAcc8
 855 ;test5.j(119)     if (three != twelve/(one+2)) println(89);
 856 acc16= variable 10
 857 <acc16= variable 2
 858 acc16+ constant 2
 859 /acc16 unstack16
 860 acc16Comp variable 4
 861 breq 865
 862 acc8= constant 89
 863 call writeLineAcc8
 864 ;test5.j(120)     if (three < twelve/(one+2)) println(90);
 865 acc16= variable 10
 866 <acc16= variable 2
 867 acc16+ constant 2
 868 /acc16 unstack16
 869 acc16Comp variable 4
 870 brle 874
 871 acc8= constant 90
 872 call writeLineAcc8
 873 ;test5.j(121)     if (twelve > twelve/(one+2)) println(91);
 874 acc16= variable 10
 875 <acc16= variable 2
 876 acc16+ constant 2
 877 /acc16 unstack16
 878 acc16Comp variable 10
 879 brge 883
 880 acc8= constant 91
 881 call writeLineAcc8
 882 ;test5.j(122)     if (four <= twelve/(one+2)) println(92);
 883 acc16= variable 10
 884 <acc16= variable 2
 885 acc16+ constant 2
 886 /acc16 unstack16
 887 acc16Comp variable 6
 888 brlt 892
 889 acc8= constant 92
 890 call writeLineAcc8
 891 ;test5.j(123)     if (three <= twelve/(one+2)) println(93);
 892 acc16= variable 10
 893 <acc16= variable 2
 894 acc16+ constant 2
 895 /acc16 unstack16
 896 acc16Comp variable 4
 897 brlt 901
 898 acc8= constant 93
 899 call writeLineAcc8
 900 ;test5.j(124)     if (four >= twelve/(one+2)) println(94);
 901 acc16= variable 10
 902 <acc16= variable 2
 903 acc16+ constant 2
 904 /acc16 unstack16
 905 acc16Comp variable 6
 906 brgt 910
 907 acc8= constant 94
 908 call writeLineAcc8
 909 ;test5.j(125)     if (twelve >= twelve/(one+2)) println(95);
 910 acc16= variable 10
 911 <acc16= variable 2
 912 acc16+ constant 2
 913 /acc16 unstack16
 914 acc16Comp variable 10
 915 brgt 919
 916 acc8= constant 95
 917 call writeLineAcc8
 918 ;test5.j(126)     if (1+3 == 12/(1+2)) println(96);
 919 acc8= constant 1
 920 acc8+ constant 3
 921 <acc8
 922 acc8= constant 12
 923 <acc8= constant 1
 924 acc8+ constant 2
 925 /acc8 unstack8
 926 revAcc8Comp unstack8
 927 brne 931
 928 acc8= constant 96
 929 call writeLineAcc8
 930 ;test5.j(127)     if (1+2 != 12/(1+2)) println(97);
 931 acc8= constant 1
 932 acc8+ constant 2
 933 <acc8
 934 acc8= constant 12
 935 <acc8= constant 1
 936 acc8+ constant 2
 937 /acc8 unstack8
 938 revAcc8Comp unstack8
 939 breq 943
 940 acc8= constant 97
 941 call writeLineAcc8
 942 ;test5.j(128)     if (1+2 < 12/(1+2)) println(98);
 943 acc8= constant 1
 944 acc8+ constant 2
 945 <acc8
 946 acc8= constant 12
 947 <acc8= constant 1
 948 acc8+ constant 2
 949 /acc8 unstack8
 950 revAcc8Comp unstack8
 951 brle 955
 952 acc8= constant 98
 953 call writeLineAcc8
 954 ;test5.j(129)     if (1+4 > 12/(1+2)) println(99);
 955 acc8= constant 1
 956 acc8+ constant 4
 957 <acc8
 958 acc8= constant 12
 959 <acc8= constant 1
 960 acc8+ constant 2
 961 /acc8 unstack8
 962 revAcc8Comp unstack8
 963 brge 967
 964 acc8= constant 99
 965 call writeLineAcc8
 966 ;test5.j(130)     if (1+2 <= 12/(1+2)) println(100);
 967 acc8= constant 1
 968 acc8+ constant 2
 969 <acc8
 970 acc8= constant 12
 971 <acc8= constant 1
 972 acc8+ constant 2
 973 /acc8 unstack8
 974 revAcc8Comp unstack8
 975 brlt 979
 976 acc8= constant 100
 977 call writeLineAcc8
 978 ;test5.j(131)     if (1+3 <= 12/(1+2)) println(101);
 979 acc8= constant 1
 980 acc8+ constant 3
 981 <acc8
 982 acc8= constant 12
 983 <acc8= constant 1
 984 acc8+ constant 2
 985 /acc8 unstack8
 986 revAcc8Comp unstack8
 987 brlt 991
 988 acc8= constant 101
 989 call writeLineAcc8
 990 ;test5.j(132)     if (1+3 >= 12/(1+2)) println(102);
 991 acc8= constant 1
 992 acc8+ constant 3
 993 <acc8
 994 acc8= constant 12
 995 <acc8= constant 1
 996 acc8+ constant 2
 997 /acc8 unstack8
 998 revAcc8Comp unstack8
 999 brgt 1003
1000 acc8= constant 102
1001 call writeLineAcc8
1002 ;test5.j(133)     if (1+4 >= 12/(1+2)) println(103);
1003 acc8= constant 1
1004 acc8+ constant 4
1005 <acc8
1006 acc8= constant 12
1007 <acc8= constant 1
1008 acc8+ constant 2
1009 /acc8 unstack8
1010 revAcc8Comp unstack8
1011 brgt 1015
1012 acc8= constant 103
1013 call writeLineAcc8
1014 ;test5.j(134)     if (1+3 == twelve/(one+2)) println(104);
1015 acc8= constant 1
1016 acc8+ constant 3
1017 <acc8
1018 acc16= variable 10
1019 <acc16= variable 2
1020 acc16+ constant 2
1021 /acc16 unstack16
1022 acc8= unstack8
1023 acc8CompareAcc16
1024 brne 1028
1025 acc8= constant 104
1026 call writeLineAcc8
1027 ;test5.j(135)     if (1+2 != twelve/(one+2)) println(105);
1028 acc8= constant 1
1029 acc8+ constant 2
1030 <acc8
1031 acc16= variable 10
1032 <acc16= variable 2
1033 acc16+ constant 2
1034 /acc16 unstack16
1035 acc8= unstack8
1036 acc8CompareAcc16
1037 breq 1041
1038 acc8= constant 105
1039 call writeLineAcc8
1040 ;test5.j(136)     if (1+2 < twelve/(one+2)) println(106);
1041 acc8= constant 1
1042 acc8+ constant 2
1043 <acc8
1044 acc16= variable 10
1045 <acc16= variable 2
1046 acc16+ constant 2
1047 /acc16 unstack16
1048 acc8= unstack8
1049 acc8CompareAcc16
1050 brge 1054
1051 acc8= constant 106
1052 call writeLineAcc8
1053 ;test5.j(137)     if (1+4 > twelve/(one+2)) println(107);
1054 acc8= constant 1
1055 acc8+ constant 4
1056 <acc8
1057 acc16= variable 10
1058 <acc16= variable 2
1059 acc16+ constant 2
1060 /acc16 unstack16
1061 acc8= unstack8
1062 acc8CompareAcc16
1063 brle 1067
1064 acc8= constant 107
1065 call writeLineAcc8
1066 ;test5.j(138)     if (1+2 <= twelve/(one+2)) println(108);
1067 acc8= constant 1
1068 acc8+ constant 2
1069 <acc8
1070 acc16= variable 10
1071 <acc16= variable 2
1072 acc16+ constant 2
1073 /acc16 unstack16
1074 acc8= unstack8
1075 acc8CompareAcc16
1076 brgt 1080
1077 acc8= constant 108
1078 call writeLineAcc8
1079 ;test5.j(139)     if (1+3 <= twelve/(one+2)) println(109);
1080 acc8= constant 1
1081 acc8+ constant 3
1082 <acc8
1083 acc16= variable 10
1084 <acc16= variable 2
1085 acc16+ constant 2
1086 /acc16 unstack16
1087 acc8= unstack8
1088 acc8CompareAcc16
1089 brgt 1093
1090 acc8= constant 109
1091 call writeLineAcc8
1092 ;test5.j(140)     if (1+3 >= twelve/(one+2)) println(110);
1093 acc8= constant 1
1094 acc8+ constant 3
1095 <acc8
1096 acc16= variable 10
1097 <acc16= variable 2
1098 acc16+ constant 2
1099 /acc16 unstack16
1100 acc8= unstack8
1101 acc8CompareAcc16
1102 brlt 1106
1103 acc8= constant 110
1104 call writeLineAcc8
1105 ;test5.j(141)     if (1+4 >= twelve/(one+2)) println(111);
1106 acc8= constant 1
1107 acc8+ constant 4
1108 <acc8
1109 acc16= variable 10
1110 <acc16= variable 2
1111 acc16+ constant 2
1112 /acc16 unstack16
1113 acc8= unstack8
1114 acc8CompareAcc16
1115 brlt 1119
1116 acc8= constant 111
1117 call writeLineAcc8
1118 ;test5.j(142)     if (4 == 12/(1+2)) println(112);
1119 acc8= constant 12
1120 <acc8= constant 1
1121 acc8+ constant 2
1122 /acc8 unstack8
1123 acc8Comp constant 4
1124 brne 1128
1125 acc8= constant 112
1126 call writeLineAcc8
1127 ;test5.j(143)     if (3 != 12/(1+2)) println(113);
1128 acc8= constant 12
1129 <acc8= constant 1
1130 acc8+ constant 2
1131 /acc8 unstack8
1132 acc8Comp constant 3
1133 breq 1137
1134 acc8= constant 113
1135 call writeLineAcc8
1136 ;test5.j(144)     if (3 < 12/(1+2)) println(114);
1137 acc8= constant 12
1138 <acc8= constant 1
1139 acc8+ constant 2
1140 /acc8 unstack8
1141 acc8Comp constant 3
1142 brle 1146
1143 acc8= constant 114
1144 call writeLineAcc8
1145 ;test5.j(145)     if (5 > 12/(1+2)) println(115);
1146 acc8= constant 12
1147 <acc8= constant 1
1148 acc8+ constant 2
1149 /acc8 unstack8
1150 acc8Comp constant 5
1151 brge 1155
1152 acc8= constant 115
1153 call writeLineAcc8
1154 ;test5.j(146)     if (3 <= 12/(1+2)) println(116);
1155 acc8= constant 12
1156 <acc8= constant 1
1157 acc8+ constant 2
1158 /acc8 unstack8
1159 acc8Comp constant 3
1160 brlt 1164
1161 acc8= constant 116
1162 call writeLineAcc8
1163 ;test5.j(147)     if (4 <= 12/(1+2)) println(117);
1164 acc8= constant 12
1165 <acc8= constant 1
1166 acc8+ constant 2
1167 /acc8 unstack8
1168 acc8Comp constant 4
1169 brlt 1173
1170 acc8= constant 117
1171 call writeLineAcc8
1172 ;test5.j(148)     if (4 >= 12/(1+2)) println(118);
1173 acc8= constant 12
1174 <acc8= constant 1
1175 acc8+ constant 2
1176 /acc8 unstack8
1177 acc8Comp constant 4
1178 brgt 1182
1179 acc8= constant 118
1180 call writeLineAcc8
1181 ;test5.j(149)     if (5 >= 12/(1+2)) println(119);
1182 acc8= constant 12
1183 <acc8= constant 1
1184 acc8+ constant 2
1185 /acc8 unstack8
1186 acc8Comp constant 5
1187 brgt 1191
1188 acc8= constant 119
1189 call writeLineAcc8
1190 ;test5.j(150)     if (4 == twelve/(one+2)) println(120);
1191 acc16= variable 10
1192 <acc16= variable 2
1193 acc16+ constant 2
1194 /acc16 unstack16
1195 acc8= constant 4
1196 acc8CompareAcc16
1197 brne 1201
1198 acc8= constant 120
1199 call writeLineAcc8
1200 ;test5.j(151)     if (3 != twelve/(one+2)) println(121);
1201 acc16= variable 10
1202 <acc16= variable 2
1203 acc16+ constant 2
1204 /acc16 unstack16
1205 acc8= constant 3
1206 acc8CompareAcc16
1207 breq 1211
1208 acc8= constant 121
1209 call writeLineAcc8
1210 ;test5.j(152)     if (2 < twelve/(one+2)) println(122);
1211 acc16= variable 10
1212 <acc16= variable 2
1213 acc16+ constant 2
1214 /acc16 unstack16
1215 acc8= constant 2
1216 acc8CompareAcc16
1217 brge 1221
1218 acc8= constant 122
1219 call writeLineAcc8
1220 ;test5.j(153)     if (5 > twelve/(one+2)) println(123);
1221 acc16= variable 10
1222 <acc16= variable 2
1223 acc16+ constant 2
1224 /acc16 unstack16
1225 acc8= constant 5
1226 acc8CompareAcc16
1227 brle 1231
1228 acc8= constant 123
1229 call writeLineAcc8
1230 ;test5.j(154)     if (3 <= twelve/(one+2)) println(124);
1231 acc16= variable 10
1232 <acc16= variable 2
1233 acc16+ constant 2
1234 /acc16 unstack16
1235 acc8= constant 3
1236 acc8CompareAcc16
1237 brgt 1241
1238 acc8= constant 124
1239 call writeLineAcc8
1240 ;test5.j(155)     if (4 <= twelve/(one+2)) println(125);
1241 acc16= variable 10
1242 <acc16= variable 2
1243 acc16+ constant 2
1244 /acc16 unstack16
1245 acc8= constant 4
1246 acc8CompareAcc16
1247 brgt 1251
1248 acc8= constant 125
1249 call writeLineAcc8
1250 ;test5.j(156)     if (4 >= twelve/(one+2)) println(126);
1251 acc16= variable 10
1252 <acc16= variable 2
1253 acc16+ constant 2
1254 /acc16 unstack16
1255 acc8= constant 4
1256 acc8CompareAcc16
1257 brlt 1261
1258 acc8= constant 126
1259 call writeLineAcc8
1260 ;test5.j(157)     if (5 >= twelve/(one+2)) println(127);
1261 acc16= variable 10
1262 <acc16= variable 2
1263 acc16+ constant 2
1264 /acc16 unstack16
1265 acc8= constant 5
1266 acc8CompareAcc16
1267 brlt 1271
1268 acc8= constant 127
1269 call writeLineAcc8
1270 ;test5.j(158)     if (four == 0 + 12/(1 + 2)) println(128);
1271 acc8= constant 0
1272 <acc8= constant 12
1273 <acc8= constant 1
1274 acc8+ constant 2
1275 /acc8 unstack8
1276 acc8+ unstack8
1277 acc16= variable 6
1278 acc16CompareAcc8
1279 brne 1283
1280 acc8= constant 128
1281 call writeLineAcc8
1282 ;test5.j(159)     if (four == 0 + 12/(1 + 2)) println(129);
1283 acc8= constant 0
1284 <acc8= constant 12
1285 <acc8= constant 1
1286 acc8+ constant 2
1287 /acc8 unstack8
1288 acc8+ unstack8
1289 acc16= variable 6
1290 acc16CompareAcc8
1291 brne 1295
1292 acc8= constant 129
1293 call writeLineAcc8
1294 ;test5.j(160)     if (four == 0 + 12/(byteOne + 2)) println(130);
1295 acc8= constant 0
1296 <acc8= constant 12
1297 <acc8= variable 12
1298 acc8+ constant 2
1299 /acc8 unstack8
1300 acc8+ unstack8
1301 acc16= variable 6
1302 acc16CompareAcc8
1303 brne 1307
1304 acc8= constant 130
1305 call writeLineAcc8
1306 ;test5.j(161)     if (four == 0 + 12/(one + 2)) println(131);
1307 acc8= constant 0
1308 <acc8= constant 12
1309 acc16= variable 2
1310 acc16+ constant 2
1311 /acc16 acc8
1312 acc16+ unstack8
1313 acc16Comp variable 6
1314 brne 1318
1315 acc8= constant 131
1316 call writeLineAcc8
1317 ;test5.j(162)     if (4 == zero + twelve/(1+2)) println(132);
1318 acc16= variable 0
1319 <acc16= variable 10
1320 acc8= constant 1
1321 acc8+ constant 2
1322 acc16/ acc8
1323 acc16+ unstack16
1324 acc8= constant 4
1325 acc8CompareAcc16
1326 brne 1333
1327 acc8= constant 132
1328 call writeLineAcc8
1329 ;test5.j(163)   
1330 ;test5.j(164)     /************************/
1331 ;test5.j(165)     // global variable b used within if scope
1332 ;test5.j(166)     b = 133;
1333 acc8= constant 133
1334 acc8=> variable 14
1335 ;test5.j(167)     if (b>132) {
1336 acc8= variable 14
1337 acc8Comp constant 132
1338 brle 1358
1339 ;test5.j(168)       //word j = 1001;
1340 ;test5.j(169)       //byte c = b;
1341 ;test5.j(170)       //byte d = c;
1342 ;test5.j(171)       j = 1001;
1343 acc16= constant 1001
1344 acc16=> variable 15
1345 ;test5.j(172)       c = b;
1346 acc8= variable 14
1347 acc8=> variable 17
1348 ;test5.j(173)       d = c;
1349 acc8= variable 17
1350 acc8=> variable 18
1351 ;test5.j(174)       b--;
1352 decr8 variable 14
1353 ;test5.j(175)       println (c);
1354 acc8= variable 17
1355 call writeLineAcc8
1356 ;test5.j(176)     } else {
1357 br 1365
1358 ;test5.j(177)       println(999);
1359 acc16= constant 999
1360 call writeLineAcc16
1361 ;test5.j(178)     }
1362 ;test5.j(179)   
1363 ;test5.j(180)     /************************/
1364 ;test5.j(181)     println (134);
1365 acc8= constant 134
1366 call writeLineAcc8
1367 ;test5.j(182)     println("Klaar");
1368 acc16= constant 1374
1369 writeLineString
1370 ;test5.j(183)   }
1371 ;test5.j(184) }
1372 ;test5.j(185) //comment after final }.
1373 stop
1374 stringConstant 0 = "Klaar"
