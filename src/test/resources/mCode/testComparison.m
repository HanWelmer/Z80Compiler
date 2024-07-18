   0 call 35
   1 stop
   2 ;testComparison.j(0) /*
   3 ;testComparison.j(1)  * A small program in the miniJava language.
   4 ;testComparison.j(2)  * Test comparison
   5 ;testComparison.j(3)  */
   6 ;testComparison.j(4) class TestComparison {
   7 class TestComparison []
   8 ;testComparison.j(5)   private static word zero = 0;
   9 acc8= constant 0
  10 acc8=> variable 0
  11 ;testComparison.j(6)   private static word one = 1;
  12 acc8= constant 1
  13 acc8=> variable 2
  14 ;testComparison.j(7)   private static word three = 3;
  15 acc8= constant 3
  16 acc8=> variable 4
  17 ;testComparison.j(8)   private static word four = 4;
  18 acc8= constant 4
  19 acc8=> variable 6
  20 ;testComparison.j(9)   private static word five = 5;
  21 acc8= constant 5
  22 acc8=> variable 8
  23 ;testComparison.j(10)   private static word twelve = 12;
  24 acc8= constant 12
  25 acc8=> variable 10
  26 ;testComparison.j(11)   private static byte byteOne = 1;
  27 acc8= constant 1
  28 acc8=> variable 12
  29 ;testComparison.j(12)   private static byte byteSix = 262;
  30 acc16= constant 262
  31 acc16=> variable 13
  32 ;testComparison.j(13)   private static byte b;
  33 ;testComparison.j(14)   
  34 ;testComparison.j(15)   public static void main() {
  35 method TestComparison.main [public, static] void ()
  36 <basePointer
  37 basePointer= stackPointer
  38 stackPointer+ constant 4
  39 ;testComparison.j(16)     //stack level 1
  40 ;testComparison.j(17)     //byte-byte
  41 ;testComparison.j(18)     if (4 == 12/(1+2)) println(0);
  42 acc8= constant 12
  43 <acc8= constant 1
  44 acc8+ constant 2
  45 /acc8 unstack8
  46 acc8Comp constant 4
  47 brne 51
  48 acc8= constant 0
  49 writeLineAcc8
  50 ;testComparison.j(19)     if (4 == 4) println(1);
  51 acc8= constant 4
  52 acc8Comp constant 4
  53 brne 57
  54 acc8= constant 1
  55 writeLineAcc8
  56 ;testComparison.j(20)     if (3 != 12/(1+2)) println(2);
  57 acc8= constant 12
  58 <acc8= constant 1
  59 acc8+ constant 2
  60 /acc8 unstack8
  61 acc8Comp constant 3
  62 breq 66
  63 acc8= constant 2
  64 writeLineAcc8
  65 ;testComparison.j(21)     if (3 != 4) println(3);
  66 acc8= constant 3
  67 acc8Comp constant 4
  68 breq 72
  69 acc8= constant 3
  70 writeLineAcc8
  71 ;testComparison.j(22)     if (3 < 12/(1+2)) println(4);
  72 acc8= constant 12
  73 <acc8= constant 1
  74 acc8+ constant 2
  75 /acc8 unstack8
  76 acc8Comp constant 3
  77 brle 81
  78 acc8= constant 4
  79 writeLineAcc8
  80 ;testComparison.j(23)     if (3 < 4) println(5);
  81 acc8= constant 3
  82 acc8Comp constant 4
  83 brge 87
  84 acc8= constant 5
  85 writeLineAcc8
  86 ;testComparison.j(24)     if (5 > 12/(1+2)) println(6);
  87 acc8= constant 12
  88 <acc8= constant 1
  89 acc8+ constant 2
  90 /acc8 unstack8
  91 acc8Comp constant 5
  92 brge 96
  93 acc8= constant 6
  94 writeLineAcc8
  95 ;testComparison.j(25)     if (5 > 4) println(7);
  96 acc8= constant 5
  97 acc8Comp constant 4
  98 brle 102
  99 acc8= constant 7
 100 writeLineAcc8
 101 ;testComparison.j(26)     if (3 <= 12/(1+2)) println(8);
 102 acc8= constant 12
 103 <acc8= constant 1
 104 acc8+ constant 2
 105 /acc8 unstack8
 106 acc8Comp constant 3
 107 brlt 111
 108 acc8= constant 8
 109 writeLineAcc8
 110 ;testComparison.j(27)     if (3 <= 4) println(9);
 111 acc8= constant 3
 112 acc8Comp constant 4
 113 brgt 117
 114 acc8= constant 9
 115 writeLineAcc8
 116 ;testComparison.j(28)     if (4 <= 12/(1+2)) println(10);
 117 acc8= constant 12
 118 <acc8= constant 1
 119 acc8+ constant 2
 120 /acc8 unstack8
 121 acc8Comp constant 4
 122 brlt 126
 123 acc8= constant 10
 124 writeLineAcc8
 125 ;testComparison.j(29)     if (4 <= 4) println(11);
 126 acc8= constant 4
 127 acc8Comp constant 4
 128 brgt 132
 129 acc8= constant 11
 130 writeLineAcc8
 131 ;testComparison.j(30)     if (5 >= 12/(1+2)) println(12);
 132 acc8= constant 12
 133 <acc8= constant 1
 134 acc8+ constant 2
 135 /acc8 unstack8
 136 acc8Comp constant 5
 137 brgt 141
 138 acc8= constant 12
 139 writeLineAcc8
 140 ;testComparison.j(31)     if (5 >= 4) println(13);
 141 acc8= constant 5
 142 acc8Comp constant 4
 143 brlt 147
 144 acc8= constant 13
 145 writeLineAcc8
 146 ;testComparison.j(32)     if (4 >= 12/(1+2)) println(14);
 147 acc8= constant 12
 148 <acc8= constant 1
 149 acc8+ constant 2
 150 /acc8 unstack8
 151 acc8Comp constant 4
 152 brgt 156
 153 acc8= constant 14
 154 writeLineAcc8
 155 ;testComparison.j(33)     if (4 >= 4) println(15);
 156 acc8= constant 4
 157 acc8Comp constant 4
 158 brlt 164
 159 acc8= constant 15
 160 writeLineAcc8
 161 ;testComparison.j(34)     //stack level 1
 162 ;testComparison.j(35)     //byte-integer
 163 ;testComparison.j(36)     if (4 == twelve/(1+2)) println(16);
 164 acc16= variable 10
 165 acc8= constant 1
 166 acc8+ constant 2
 167 acc16/ acc8
 168 acc8= constant 4
 169 acc8CompareAcc16
 170 brne 174
 171 acc8= constant 16
 172 writeLineAcc8
 173 ;testComparison.j(37)     if (4 == four) println(17);
 174 acc16= variable 6
 175 acc8= constant 4
 176 acc8CompareAcc16
 177 brne 181
 178 acc8= constant 17
 179 writeLineAcc8
 180 ;testComparison.j(38)     if (3 != twelve/(1+2)) println(18);
 181 acc16= variable 10
 182 acc8= constant 1
 183 acc8+ constant 2
 184 acc16/ acc8
 185 acc8= constant 3
 186 acc8CompareAcc16
 187 breq 191
 188 acc8= constant 18
 189 writeLineAcc8
 190 ;testComparison.j(39)     if (3 != four) println(19);
 191 acc16= variable 6
 192 acc8= constant 3
 193 acc8CompareAcc16
 194 breq 198
 195 acc8= constant 19
 196 writeLineAcc8
 197 ;testComparison.j(40)     if (3 < twelve/(1+2)) println(20);
 198 acc16= variable 10
 199 acc8= constant 1
 200 acc8+ constant 2
 201 acc16/ acc8
 202 acc8= constant 3
 203 acc8CompareAcc16
 204 brge 208
 205 acc8= constant 20
 206 writeLineAcc8
 207 ;testComparison.j(41)     if (3 < four) println(21);
 208 acc16= variable 6
 209 acc8= constant 3
 210 acc8CompareAcc16
 211 brge 215
 212 acc8= constant 21
 213 writeLineAcc8
 214 ;testComparison.j(42)     if (5 > twelve/(1+2)) println(22);
 215 acc16= variable 10
 216 acc8= constant 1
 217 acc8+ constant 2
 218 acc16/ acc8
 219 acc8= constant 5
 220 acc8CompareAcc16
 221 brle 225
 222 acc8= constant 22
 223 writeLineAcc8
 224 ;testComparison.j(43)     if (5 > four) println(23);
 225 acc16= variable 6
 226 acc8= constant 5
 227 acc8CompareAcc16
 228 brle 232
 229 acc8= constant 23
 230 writeLineAcc8
 231 ;testComparison.j(44)     if (3 <= twelve/(1+2)) println(24);
 232 acc16= variable 10
 233 acc8= constant 1
 234 acc8+ constant 2
 235 acc16/ acc8
 236 acc8= constant 3
 237 acc8CompareAcc16
 238 brgt 242
 239 acc8= constant 24
 240 writeLineAcc8
 241 ;testComparison.j(45)     if (3 <= four) println(25);
 242 acc16= variable 6
 243 acc8= constant 3
 244 acc8CompareAcc16
 245 brgt 249
 246 acc8= constant 25
 247 writeLineAcc8
 248 ;testComparison.j(46)     if (4 <= twelve/(1+2)) println(26);
 249 acc16= variable 10
 250 acc8= constant 1
 251 acc8+ constant 2
 252 acc16/ acc8
 253 acc8= constant 4
 254 acc8CompareAcc16
 255 brgt 259
 256 acc8= constant 26
 257 writeLineAcc8
 258 ;testComparison.j(47)     if (4 <= four) println(27);
 259 acc16= variable 6
 260 acc8= constant 4
 261 acc8CompareAcc16
 262 brgt 266
 263 acc8= constant 27
 264 writeLineAcc8
 265 ;testComparison.j(48)     if (5 >= twelve/(1+2)) println(28);
 266 acc16= variable 10
 267 acc8= constant 1
 268 acc8+ constant 2
 269 acc16/ acc8
 270 acc8= constant 5
 271 acc8CompareAcc16
 272 brlt 276
 273 acc8= constant 28
 274 writeLineAcc8
 275 ;testComparison.j(49)     if (5 >= four) println(29);
 276 acc16= variable 6
 277 acc8= constant 5
 278 acc8CompareAcc16
 279 brlt 283
 280 acc8= constant 29
 281 writeLineAcc8
 282 ;testComparison.j(50)     if (4 >= twelve/(1+2)) println(30);
 283 acc16= variable 10
 284 acc8= constant 1
 285 acc8+ constant 2
 286 acc16/ acc8
 287 acc8= constant 4
 288 acc8CompareAcc16
 289 brlt 293
 290 acc8= constant 30
 291 writeLineAcc8
 292 ;testComparison.j(51)     if (4 >= four) println(31);
 293 acc16= variable 6
 294 acc8= constant 4
 295 acc8CompareAcc16
 296 brlt 302
 297 acc8= constant 31
 298 writeLineAcc8
 299 ;testComparison.j(52)     //stack level 1
 300 ;testComparison.j(53)     //integer-byte
 301 ;testComparison.j(54)     if (four == 12/(1+2)) println(32);
 302 acc8= constant 12
 303 <acc8= constant 1
 304 acc8+ constant 2
 305 /acc8 unstack8
 306 acc16= variable 6
 307 acc16CompareAcc8
 308 brne 312
 309 acc8= constant 32
 310 writeLineAcc8
 311 ;testComparison.j(55)     if (four == 4) println(33);
 312 acc16= variable 6
 313 acc8= constant 4
 314 acc16CompareAcc8
 315 brne 319
 316 acc8= constant 33
 317 writeLineAcc8
 318 ;testComparison.j(56)     if (three != 12/(1+2)) println(34);
 319 acc8= constant 12
 320 <acc8= constant 1
 321 acc8+ constant 2
 322 /acc8 unstack8
 323 acc16= variable 4
 324 acc16CompareAcc8
 325 breq 329
 326 acc8= constant 34
 327 writeLineAcc8
 328 ;testComparison.j(57)     if (three != 4) println(35);
 329 acc16= variable 4
 330 acc8= constant 4
 331 acc16CompareAcc8
 332 breq 336
 333 acc8= constant 35
 334 writeLineAcc8
 335 ;testComparison.j(58)     if (three < 12/(1+2)) println(36);
 336 acc8= constant 12
 337 <acc8= constant 1
 338 acc8+ constant 2
 339 /acc8 unstack8
 340 acc16= variable 4
 341 acc16CompareAcc8
 342 brge 346
 343 acc8= constant 36
 344 writeLineAcc8
 345 ;testComparison.j(59)     if (three < 4) println(37);
 346 acc16= variable 4
 347 acc8= constant 4
 348 acc16CompareAcc8
 349 brge 353
 350 acc8= constant 37
 351 writeLineAcc8
 352 ;testComparison.j(60)     if (five > 12/(1+2)) println(38);
 353 acc8= constant 12
 354 <acc8= constant 1
 355 acc8+ constant 2
 356 /acc8 unstack8
 357 acc16= variable 8
 358 acc16CompareAcc8
 359 brle 363
 360 acc8= constant 38
 361 writeLineAcc8
 362 ;testComparison.j(61)     if (five > 4) println(39);
 363 acc16= variable 8
 364 acc8= constant 4
 365 acc16CompareAcc8
 366 brle 370
 367 acc8= constant 39
 368 writeLineAcc8
 369 ;testComparison.j(62)     if (three <= 12/(1+2)) println(40);
 370 acc8= constant 12
 371 <acc8= constant 1
 372 acc8+ constant 2
 373 /acc8 unstack8
 374 acc16= variable 4
 375 acc16CompareAcc8
 376 brgt 380
 377 acc8= constant 40
 378 writeLineAcc8
 379 ;testComparison.j(63)     if (three <= 4) println(41);
 380 acc16= variable 4
 381 acc8= constant 4
 382 acc16CompareAcc8
 383 brgt 387
 384 acc8= constant 41
 385 writeLineAcc8
 386 ;testComparison.j(64)     if (four <= 12/(1+2)) println(42);
 387 acc8= constant 12
 388 <acc8= constant 1
 389 acc8+ constant 2
 390 /acc8 unstack8
 391 acc16= variable 6
 392 acc16CompareAcc8
 393 brgt 397
 394 acc8= constant 42
 395 writeLineAcc8
 396 ;testComparison.j(65)     if (four <= 4) println(43);
 397 acc16= variable 6
 398 acc8= constant 4
 399 acc16CompareAcc8
 400 brgt 404
 401 acc8= constant 43
 402 writeLineAcc8
 403 ;testComparison.j(66)     if (five >= 12/(1+2)) println(44);
 404 acc8= constant 12
 405 <acc8= constant 1
 406 acc8+ constant 2
 407 /acc8 unstack8
 408 acc16= variable 8
 409 acc16CompareAcc8
 410 brlt 414
 411 acc8= constant 44
 412 writeLineAcc8
 413 ;testComparison.j(67)     if (five >= 4) println(45);
 414 acc16= variable 8
 415 acc8= constant 4
 416 acc16CompareAcc8
 417 brlt 421
 418 acc8= constant 45
 419 writeLineAcc8
 420 ;testComparison.j(68)     if (four >= 12/(1+2)) println(46);
 421 acc8= constant 12
 422 <acc8= constant 1
 423 acc8+ constant 2
 424 /acc8 unstack8
 425 acc16= variable 6
 426 acc16CompareAcc8
 427 brlt 431
 428 acc8= constant 46
 429 writeLineAcc8
 430 ;testComparison.j(69)     if (four >= 4) println(47);
 431 acc16= variable 6
 432 acc8= constant 4
 433 acc16CompareAcc8
 434 brlt 440
 435 acc8= constant 47
 436 writeLineAcc8
 437 ;testComparison.j(70)     //stack level 1
 438 ;testComparison.j(71)     //integer-integer
 439 ;testComparison.j(72)     if (400 == 1200/(1+2)) println(48);
 440 acc16= constant 1200
 441 acc8= constant 1
 442 acc8+ constant 2
 443 acc16/ acc8
 444 acc16Comp constant 400
 445 brne 449
 446 acc8= constant 48
 447 writeLineAcc8
 448 ;testComparison.j(73)     if (400 == 400) println(49);
 449 acc16= constant 400
 450 acc16Comp constant 400
 451 brne 455
 452 acc8= constant 49
 453 writeLineAcc8
 454 ;testComparison.j(74)     if (300 != 1200/(1+2)) println(50);
 455 acc16= constant 1200
 456 acc8= constant 1
 457 acc8+ constant 2
 458 acc16/ acc8
 459 acc16Comp constant 300
 460 breq 464
 461 acc8= constant 50
 462 writeLineAcc8
 463 ;testComparison.j(75)     if (300 != 400) println(51);
 464 acc16= constant 300
 465 acc16Comp constant 400
 466 breq 470
 467 acc8= constant 51
 468 writeLineAcc8
 469 ;testComparison.j(76)     if (300 < 1200/(1+2)) println(52);
 470 acc16= constant 1200
 471 acc8= constant 1
 472 acc8+ constant 2
 473 acc16/ acc8
 474 acc16Comp constant 300
 475 brle 479
 476 acc8= constant 52
 477 writeLineAcc8
 478 ;testComparison.j(77)     if (300 < 400) println(53);
 479 acc16= constant 300
 480 acc16Comp constant 400
 481 brge 485
 482 acc8= constant 53
 483 writeLineAcc8
 484 ;testComparison.j(78)     if (500 > 1200/(1+2)) println(54);
 485 acc16= constant 1200
 486 acc8= constant 1
 487 acc8+ constant 2
 488 acc16/ acc8
 489 acc16Comp constant 500
 490 brge 494
 491 acc8= constant 54
 492 writeLineAcc8
 493 ;testComparison.j(79)     if (500 > 400) println(55);
 494 acc16= constant 500
 495 acc16Comp constant 400
 496 brle 500
 497 acc8= constant 55
 498 writeLineAcc8
 499 ;testComparison.j(80)     if (300 <= 1200/(1+2)) println(56);
 500 acc16= constant 1200
 501 acc8= constant 1
 502 acc8+ constant 2
 503 acc16/ acc8
 504 acc16Comp constant 300
 505 brlt 509
 506 acc8= constant 56
 507 writeLineAcc8
 508 ;testComparison.j(81)     if (300 <= 400) println(57);
 509 acc16= constant 300
 510 acc16Comp constant 400
 511 brgt 515
 512 acc8= constant 57
 513 writeLineAcc8
 514 ;testComparison.j(82)     if (400 <= 1200/(1+2)) println(58);
 515 acc16= constant 1200
 516 acc8= constant 1
 517 acc8+ constant 2
 518 acc16/ acc8
 519 acc16Comp constant 400
 520 brlt 524
 521 acc8= constant 58
 522 writeLineAcc8
 523 ;testComparison.j(83)     if (400 <= 400) println(59);
 524 acc16= constant 400
 525 acc16Comp constant 400
 526 brgt 530
 527 acc8= constant 59
 528 writeLineAcc8
 529 ;testComparison.j(84)     if (500 >= 1200/(1+2)) println(60);
 530 acc16= constant 1200
 531 acc8= constant 1
 532 acc8+ constant 2
 533 acc16/ acc8
 534 acc16Comp constant 500
 535 brgt 539
 536 acc8= constant 60
 537 writeLineAcc8
 538 ;testComparison.j(85)     if (500 >= 400) println(61);
 539 acc16= constant 500
 540 acc16Comp constant 400
 541 brlt 545
 542 acc8= constant 61
 543 writeLineAcc8
 544 ;testComparison.j(86)     if (400 >= 1200/(1+2)) println(62);
 545 acc16= constant 1200
 546 acc8= constant 1
 547 acc8+ constant 2
 548 acc16/ acc8
 549 acc16Comp constant 400
 550 brgt 554
 551 acc8= constant 62
 552 writeLineAcc8
 553 ;testComparison.j(87)     if (400 >= 400) println(63);
 554 acc16= constant 400
 555 acc16Comp constant 400
 556 brlt 562
 557 acc8= constant 63
 558 writeLineAcc8
 559 ;testComparison.j(88)   
 560 ;testComparison.j(89)     //stack level 2
 561 ;testComparison.j(90)     if (one+three == 12/(1+2)) println(64);
 562 acc16= variable 2
 563 acc16+ variable 4
 564 <acc16
 565 acc8= constant 12
 566 <acc8= constant 1
 567 acc8+ constant 2
 568 /acc8 unstack8
 569 acc16<
 570 acc16CompareAcc8
 571 brne 575
 572 acc8= constant 64
 573 writeLineAcc8
 574 ;testComparison.j(91)     if (one+four  != 12/(1+2)) println(65);
 575 acc16= variable 2
 576 acc16+ variable 6
 577 <acc16
 578 acc8= constant 12
 579 <acc8= constant 1
 580 acc8+ constant 2
 581 /acc8 unstack8
 582 acc16<
 583 acc16CompareAcc8
 584 breq 588
 585 acc8= constant 65
 586 writeLineAcc8
 587 ;testComparison.j(92)     if (one+one < 12/(1+2)) println(66);
 588 acc16= variable 2
 589 acc16+ variable 2
 590 <acc16
 591 acc8= constant 12
 592 <acc8= constant 1
 593 acc8+ constant 2
 594 /acc8 unstack8
 595 acc16<
 596 acc16CompareAcc8
 597 brge 601
 598 acc8= constant 66
 599 writeLineAcc8
 600 ;testComparison.j(93)     if (one+four > 12/(1+2)) println(67);
 601 acc16= variable 2
 602 acc16+ variable 6
 603 <acc16
 604 acc8= constant 12
 605 <acc8= constant 1
 606 acc8+ constant 2
 607 /acc8 unstack8
 608 acc16<
 609 acc16CompareAcc8
 610 brle 614
 611 acc8= constant 67
 612 writeLineAcc8
 613 ;testComparison.j(94)     if (one+one <= 12/(1+2)) println(68);
 614 acc16= variable 2
 615 acc16+ variable 2
 616 <acc16
 617 acc8= constant 12
 618 <acc8= constant 1
 619 acc8+ constant 2
 620 /acc8 unstack8
 621 acc16<
 622 acc16CompareAcc8
 623 brgt 627
 624 acc8= constant 68
 625 writeLineAcc8
 626 ;testComparison.j(95)     if (one+three <= 12/(1+2)) println(69);
 627 acc16= variable 2
 628 acc16+ variable 4
 629 <acc16
 630 acc8= constant 12
 631 <acc8= constant 1
 632 acc8+ constant 2
 633 /acc8 unstack8
 634 acc16<
 635 acc16CompareAcc8
 636 brgt 640
 637 acc8= constant 69
 638 writeLineAcc8
 639 ;testComparison.j(96)     if (one+three >= 12/(1+2)) println(70);
 640 acc16= variable 2
 641 acc16+ variable 4
 642 <acc16
 643 acc8= constant 12
 644 <acc8= constant 1
 645 acc8+ constant 2
 646 /acc8 unstack8
 647 acc16<
 648 acc16CompareAcc8
 649 brlt 653
 650 acc8= constant 70
 651 writeLineAcc8
 652 ;testComparison.j(97)     if (one+four >= 12/(1+2)) println(71);
 653 acc16= variable 2
 654 acc16+ variable 6
 655 <acc16
 656 acc8= constant 12
 657 <acc8= constant 1
 658 acc8+ constant 2
 659 /acc8 unstack8
 660 acc16<
 661 acc16CompareAcc8
 662 brlt 666
 663 acc8= constant 71
 664 writeLineAcc8
 665 ;testComparison.j(98)     if (one+three == twelve/(one+2)) println(72);
 666 acc16= variable 2
 667 acc16+ variable 4
 668 <acc16
 669 acc16= variable 10
 670 <acc16= variable 2
 671 acc16+ constant 2
 672 /acc16 unstack16
 673 revAcc16Comp unstack16
 674 brne 678
 675 acc8= constant 72
 676 writeLineAcc8
 677 ;testComparison.j(99)     if (one+four  != twelve/(one+2)) println(73);
 678 acc16= variable 2
 679 acc16+ variable 6
 680 <acc16
 681 acc16= variable 10
 682 <acc16= variable 2
 683 acc16+ constant 2
 684 /acc16 unstack16
 685 revAcc16Comp unstack16
 686 breq 690
 687 acc8= constant 73
 688 writeLineAcc8
 689 ;testComparison.j(100)     if (one+one < twelve/(one+2)) println(74);
 690 acc16= variable 2
 691 acc16+ variable 2
 692 <acc16
 693 acc16= variable 10
 694 <acc16= variable 2
 695 acc16+ constant 2
 696 /acc16 unstack16
 697 revAcc16Comp unstack16
 698 brle 702
 699 acc8= constant 74
 700 writeLineAcc8
 701 ;testComparison.j(101)     if (one+four > twelve/(one+2)) println(75);
 702 acc16= variable 2
 703 acc16+ variable 6
 704 <acc16
 705 acc16= variable 10
 706 <acc16= variable 2
 707 acc16+ constant 2
 708 /acc16 unstack16
 709 revAcc16Comp unstack16
 710 brge 714
 711 acc8= constant 75
 712 writeLineAcc8
 713 ;testComparison.j(102)     if (one+one <= twelve/(one+2)) println(76);
 714 acc16= variable 2
 715 acc16+ variable 2
 716 <acc16
 717 acc16= variable 10
 718 <acc16= variable 2
 719 acc16+ constant 2
 720 /acc16 unstack16
 721 revAcc16Comp unstack16
 722 brlt 726
 723 acc8= constant 76
 724 writeLineAcc8
 725 ;testComparison.j(103)     if (one+three <= twelve/(one+2)) println(77);
 726 acc16= variable 2
 727 acc16+ variable 4
 728 <acc16
 729 acc16= variable 10
 730 <acc16= variable 2
 731 acc16+ constant 2
 732 /acc16 unstack16
 733 revAcc16Comp unstack16
 734 brlt 738
 735 acc8= constant 77
 736 writeLineAcc8
 737 ;testComparison.j(104)     if (one+three >= twelve/(one+2)) println(78);
 738 acc16= variable 2
 739 acc16+ variable 4
 740 <acc16
 741 acc16= variable 10
 742 <acc16= variable 2
 743 acc16+ constant 2
 744 /acc16 unstack16
 745 revAcc16Comp unstack16
 746 brgt 750
 747 acc8= constant 78
 748 writeLineAcc8
 749 ;testComparison.j(105)     if (one+four >= twelve/(one+2)) println(79);
 750 acc16= variable 2
 751 acc16+ variable 6
 752 <acc16
 753 acc16= variable 10
 754 <acc16= variable 2
 755 acc16+ constant 2
 756 /acc16 unstack16
 757 revAcc16Comp unstack16
 758 brgt 762
 759 acc8= constant 79
 760 writeLineAcc8
 761 ;testComparison.j(106)     if (four == 12/(1+2)) println(80);
 762 acc8= constant 12
 763 <acc8= constant 1
 764 acc8+ constant 2
 765 /acc8 unstack8
 766 acc16= variable 6
 767 acc16CompareAcc8
 768 brne 772
 769 acc8= constant 80
 770 writeLineAcc8
 771 ;testComparison.j(107)     if (three != 12/(1+2)) println(81);
 772 acc8= constant 12
 773 <acc8= constant 1
 774 acc8+ constant 2
 775 /acc8 unstack8
 776 acc16= variable 4
 777 acc16CompareAcc8
 778 breq 782
 779 acc8= constant 81
 780 writeLineAcc8
 781 ;testComparison.j(108)     if (three < 12/(1+2)) println(82);
 782 acc8= constant 12
 783 <acc8= constant 1
 784 acc8+ constant 2
 785 /acc8 unstack8
 786 acc16= variable 4
 787 acc16CompareAcc8
 788 brge 792
 789 acc8= constant 82
 790 writeLineAcc8
 791 ;testComparison.j(109)     if (twelve > 12/(1+2)) println(83);
 792 acc8= constant 12
 793 <acc8= constant 1
 794 acc8+ constant 2
 795 /acc8 unstack8
 796 acc16= variable 10
 797 acc16CompareAcc8
 798 brle 802
 799 acc8= constant 83
 800 writeLineAcc8
 801 ;testComparison.j(110)     if (four <= 12/(1+2)) println(84);
 802 acc8= constant 12
 803 <acc8= constant 1
 804 acc8+ constant 2
 805 /acc8 unstack8
 806 acc16= variable 6
 807 acc16CompareAcc8
 808 brgt 812
 809 acc8= constant 84
 810 writeLineAcc8
 811 ;testComparison.j(111)     if (three <= 12/(1+2)) println(85);
 812 acc8= constant 12
 813 <acc8= constant 1
 814 acc8+ constant 2
 815 /acc8 unstack8
 816 acc16= variable 4
 817 acc16CompareAcc8
 818 brgt 822
 819 acc8= constant 85
 820 writeLineAcc8
 821 ;testComparison.j(112)     if (four >= 12/(1+2)) println(86);
 822 acc8= constant 12
 823 <acc8= constant 1
 824 acc8+ constant 2
 825 /acc8 unstack8
 826 acc16= variable 6
 827 acc16CompareAcc8
 828 brlt 832
 829 acc8= constant 86
 830 writeLineAcc8
 831 ;testComparison.j(113)     if (twelve >= 12/(1+2)) println(87);
 832 acc8= constant 12
 833 <acc8= constant 1
 834 acc8+ constant 2
 835 /acc8 unstack8
 836 acc16= variable 10
 837 acc16CompareAcc8
 838 brlt 842
 839 acc8= constant 87
 840 writeLineAcc8
 841 ;testComparison.j(114)     if (four == twelve/(one+2)) println(88);
 842 acc16= variable 10
 843 <acc16= variable 2
 844 acc16+ constant 2
 845 /acc16 unstack16
 846 acc16Comp variable 6
 847 brne 851
 848 acc8= constant 88
 849 writeLineAcc8
 850 ;testComparison.j(115)     if (three != twelve/(one+2)) println(89);
 851 acc16= variable 10
 852 <acc16= variable 2
 853 acc16+ constant 2
 854 /acc16 unstack16
 855 acc16Comp variable 4
 856 breq 860
 857 acc8= constant 89
 858 writeLineAcc8
 859 ;testComparison.j(116)     if (three < twelve/(one+2)) println(90);
 860 acc16= variable 10
 861 <acc16= variable 2
 862 acc16+ constant 2
 863 /acc16 unstack16
 864 acc16Comp variable 4
 865 brle 869
 866 acc8= constant 90
 867 writeLineAcc8
 868 ;testComparison.j(117)     if (twelve > twelve/(one+2)) println(91);
 869 acc16= variable 10
 870 <acc16= variable 2
 871 acc16+ constant 2
 872 /acc16 unstack16
 873 acc16Comp variable 10
 874 brge 878
 875 acc8= constant 91
 876 writeLineAcc8
 877 ;testComparison.j(118)     if (four <= twelve/(one+2)) println(92);
 878 acc16= variable 10
 879 <acc16= variable 2
 880 acc16+ constant 2
 881 /acc16 unstack16
 882 acc16Comp variable 6
 883 brlt 887
 884 acc8= constant 92
 885 writeLineAcc8
 886 ;testComparison.j(119)     if (three <= twelve/(one+2)) println(93);
 887 acc16= variable 10
 888 <acc16= variable 2
 889 acc16+ constant 2
 890 /acc16 unstack16
 891 acc16Comp variable 4
 892 brlt 896
 893 acc8= constant 93
 894 writeLineAcc8
 895 ;testComparison.j(120)     if (four >= twelve/(one+2)) println(94);
 896 acc16= variable 10
 897 <acc16= variable 2
 898 acc16+ constant 2
 899 /acc16 unstack16
 900 acc16Comp variable 6
 901 brgt 905
 902 acc8= constant 94
 903 writeLineAcc8
 904 ;testComparison.j(121)     if (twelve >= twelve/(one+2)) println(95);
 905 acc16= variable 10
 906 <acc16= variable 2
 907 acc16+ constant 2
 908 /acc16 unstack16
 909 acc16Comp variable 10
 910 brgt 914
 911 acc8= constant 95
 912 writeLineAcc8
 913 ;testComparison.j(122)     if (1+3 == 12/(1+2)) println(96);
 914 acc8= constant 1
 915 acc8+ constant 3
 916 <acc8
 917 acc8= constant 12
 918 <acc8= constant 1
 919 acc8+ constant 2
 920 /acc8 unstack8
 921 revAcc8Comp unstack8
 922 brne 926
 923 acc8= constant 96
 924 writeLineAcc8
 925 ;testComparison.j(123)     if (1+2 != 12/(1+2)) println(97);
 926 acc8= constant 1
 927 acc8+ constant 2
 928 <acc8
 929 acc8= constant 12
 930 <acc8= constant 1
 931 acc8+ constant 2
 932 /acc8 unstack8
 933 revAcc8Comp unstack8
 934 breq 938
 935 acc8= constant 97
 936 writeLineAcc8
 937 ;testComparison.j(124)     if (1+2 < 12/(1+2)) println(98);
 938 acc8= constant 1
 939 acc8+ constant 2
 940 <acc8
 941 acc8= constant 12
 942 <acc8= constant 1
 943 acc8+ constant 2
 944 /acc8 unstack8
 945 revAcc8Comp unstack8
 946 brle 950
 947 acc8= constant 98
 948 writeLineAcc8
 949 ;testComparison.j(125)     if (1+4 > 12/(1+2)) println(99);
 950 acc8= constant 1
 951 acc8+ constant 4
 952 <acc8
 953 acc8= constant 12
 954 <acc8= constant 1
 955 acc8+ constant 2
 956 /acc8 unstack8
 957 revAcc8Comp unstack8
 958 brge 962
 959 acc8= constant 99
 960 writeLineAcc8
 961 ;testComparison.j(126)     if (1+2 <= 12/(1+2)) println(100);
 962 acc8= constant 1
 963 acc8+ constant 2
 964 <acc8
 965 acc8= constant 12
 966 <acc8= constant 1
 967 acc8+ constant 2
 968 /acc8 unstack8
 969 revAcc8Comp unstack8
 970 brlt 974
 971 acc8= constant 100
 972 writeLineAcc8
 973 ;testComparison.j(127)     if (1+3 <= 12/(1+2)) println(101);
 974 acc8= constant 1
 975 acc8+ constant 3
 976 <acc8
 977 acc8= constant 12
 978 <acc8= constant 1
 979 acc8+ constant 2
 980 /acc8 unstack8
 981 revAcc8Comp unstack8
 982 brlt 986
 983 acc8= constant 101
 984 writeLineAcc8
 985 ;testComparison.j(128)     if (1+3 >= 12/(1+2)) println(102);
 986 acc8= constant 1
 987 acc8+ constant 3
 988 <acc8
 989 acc8= constant 12
 990 <acc8= constant 1
 991 acc8+ constant 2
 992 /acc8 unstack8
 993 revAcc8Comp unstack8
 994 brgt 998
 995 acc8= constant 102
 996 writeLineAcc8
 997 ;testComparison.j(129)     if (1+4 >= 12/(1+2)) println(103);
 998 acc8= constant 1
 999 acc8+ constant 4
1000 <acc8
1001 acc8= constant 12
1002 <acc8= constant 1
1003 acc8+ constant 2
1004 /acc8 unstack8
1005 revAcc8Comp unstack8
1006 brgt 1010
1007 acc8= constant 103
1008 writeLineAcc8
1009 ;testComparison.j(130)     if (1+3 == twelve/(one+2)) println(104);
1010 acc8= constant 1
1011 acc8+ constant 3
1012 <acc8
1013 acc16= variable 10
1014 <acc16= variable 2
1015 acc16+ constant 2
1016 /acc16 unstack16
1017 acc8<
1018 acc8CompareAcc16
1019 brne 1023
1020 acc8= constant 104
1021 writeLineAcc8
1022 ;testComparison.j(131)     if (1+2 != twelve/(one+2)) println(105);
1023 acc8= constant 1
1024 acc8+ constant 2
1025 <acc8
1026 acc16= variable 10
1027 <acc16= variable 2
1028 acc16+ constant 2
1029 /acc16 unstack16
1030 acc8<
1031 acc8CompareAcc16
1032 breq 1036
1033 acc8= constant 105
1034 writeLineAcc8
1035 ;testComparison.j(132)     if (1+2 < twelve/(one+2)) println(106);
1036 acc8= constant 1
1037 acc8+ constant 2
1038 <acc8
1039 acc16= variable 10
1040 <acc16= variable 2
1041 acc16+ constant 2
1042 /acc16 unstack16
1043 acc8<
1044 acc8CompareAcc16
1045 brge 1049
1046 acc8= constant 106
1047 writeLineAcc8
1048 ;testComparison.j(133)     if (1+4 > twelve/(one+2)) println(107);
1049 acc8= constant 1
1050 acc8+ constant 4
1051 <acc8
1052 acc16= variable 10
1053 <acc16= variable 2
1054 acc16+ constant 2
1055 /acc16 unstack16
1056 acc8<
1057 acc8CompareAcc16
1058 brle 1062
1059 acc8= constant 107
1060 writeLineAcc8
1061 ;testComparison.j(134)     if (1+2 <= twelve/(one+2)) println(108);
1062 acc8= constant 1
1063 acc8+ constant 2
1064 <acc8
1065 acc16= variable 10
1066 <acc16= variable 2
1067 acc16+ constant 2
1068 /acc16 unstack16
1069 acc8<
1070 acc8CompareAcc16
1071 brgt 1075
1072 acc8= constant 108
1073 writeLineAcc8
1074 ;testComparison.j(135)     if (1+3 <= twelve/(one+2)) println(109);
1075 acc8= constant 1
1076 acc8+ constant 3
1077 <acc8
1078 acc16= variable 10
1079 <acc16= variable 2
1080 acc16+ constant 2
1081 /acc16 unstack16
1082 acc8<
1083 acc8CompareAcc16
1084 brgt 1088
1085 acc8= constant 109
1086 writeLineAcc8
1087 ;testComparison.j(136)     if (1+3 >= twelve/(one+2)) println(110);
1088 acc8= constant 1
1089 acc8+ constant 3
1090 <acc8
1091 acc16= variable 10
1092 <acc16= variable 2
1093 acc16+ constant 2
1094 /acc16 unstack16
1095 acc8<
1096 acc8CompareAcc16
1097 brlt 1101
1098 acc8= constant 110
1099 writeLineAcc8
1100 ;testComparison.j(137)     if (1+4 >= twelve/(one+2)) println(111);
1101 acc8= constant 1
1102 acc8+ constant 4
1103 <acc8
1104 acc16= variable 10
1105 <acc16= variable 2
1106 acc16+ constant 2
1107 /acc16 unstack16
1108 acc8<
1109 acc8CompareAcc16
1110 brlt 1114
1111 acc8= constant 111
1112 writeLineAcc8
1113 ;testComparison.j(138)     if (4 == 12/(1+2)) println(112);
1114 acc8= constant 12
1115 <acc8= constant 1
1116 acc8+ constant 2
1117 /acc8 unstack8
1118 acc8Comp constant 4
1119 brne 1123
1120 acc8= constant 112
1121 writeLineAcc8
1122 ;testComparison.j(139)     if (3 != 12/(1+2)) println(113);
1123 acc8= constant 12
1124 <acc8= constant 1
1125 acc8+ constant 2
1126 /acc8 unstack8
1127 acc8Comp constant 3
1128 breq 1132
1129 acc8= constant 113
1130 writeLineAcc8
1131 ;testComparison.j(140)     if (3 < 12/(1+2)) println(114);
1132 acc8= constant 12
1133 <acc8= constant 1
1134 acc8+ constant 2
1135 /acc8 unstack8
1136 acc8Comp constant 3
1137 brle 1141
1138 acc8= constant 114
1139 writeLineAcc8
1140 ;testComparison.j(141)     if (5 > 12/(1+2)) println(115);
1141 acc8= constant 12
1142 <acc8= constant 1
1143 acc8+ constant 2
1144 /acc8 unstack8
1145 acc8Comp constant 5
1146 brge 1150
1147 acc8= constant 115
1148 writeLineAcc8
1149 ;testComparison.j(142)     if (3 <= 12/(1+2)) println(116);
1150 acc8= constant 12
1151 <acc8= constant 1
1152 acc8+ constant 2
1153 /acc8 unstack8
1154 acc8Comp constant 3
1155 brlt 1159
1156 acc8= constant 116
1157 writeLineAcc8
1158 ;testComparison.j(143)     if (4 <= 12/(1+2)) println(117);
1159 acc8= constant 12
1160 <acc8= constant 1
1161 acc8+ constant 2
1162 /acc8 unstack8
1163 acc8Comp constant 4
1164 brlt 1168
1165 acc8= constant 117
1166 writeLineAcc8
1167 ;testComparison.j(144)     if (4 >= 12/(1+2)) println(118);
1168 acc8= constant 12
1169 <acc8= constant 1
1170 acc8+ constant 2
1171 /acc8 unstack8
1172 acc8Comp constant 4
1173 brgt 1177
1174 acc8= constant 118
1175 writeLineAcc8
1176 ;testComparison.j(145)     if (5 >= 12/(1+2)) println(119);
1177 acc8= constant 12
1178 <acc8= constant 1
1179 acc8+ constant 2
1180 /acc8 unstack8
1181 acc8Comp constant 5
1182 brgt 1186
1183 acc8= constant 119
1184 writeLineAcc8
1185 ;testComparison.j(146)     if (4 == twelve/(one+2)) println(120);
1186 acc16= variable 10
1187 <acc16= variable 2
1188 acc16+ constant 2
1189 /acc16 unstack16
1190 acc8= constant 4
1191 acc8CompareAcc16
1192 brne 1196
1193 acc8= constant 120
1194 writeLineAcc8
1195 ;testComparison.j(147)     if (3 != twelve/(one+2)) println(121);
1196 acc16= variable 10
1197 <acc16= variable 2
1198 acc16+ constant 2
1199 /acc16 unstack16
1200 acc8= constant 3
1201 acc8CompareAcc16
1202 breq 1206
1203 acc8= constant 121
1204 writeLineAcc8
1205 ;testComparison.j(148)     if (2 < twelve/(one+2)) println(122);
1206 acc16= variable 10
1207 <acc16= variable 2
1208 acc16+ constant 2
1209 /acc16 unstack16
1210 acc8= constant 2
1211 acc8CompareAcc16
1212 brge 1216
1213 acc8= constant 122
1214 writeLineAcc8
1215 ;testComparison.j(149)     if (5 > twelve/(one+2)) println(123);
1216 acc16= variable 10
1217 <acc16= variable 2
1218 acc16+ constant 2
1219 /acc16 unstack16
1220 acc8= constant 5
1221 acc8CompareAcc16
1222 brle 1226
1223 acc8= constant 123
1224 writeLineAcc8
1225 ;testComparison.j(150)     if (3 <= twelve/(one+2)) println(124);
1226 acc16= variable 10
1227 <acc16= variable 2
1228 acc16+ constant 2
1229 /acc16 unstack16
1230 acc8= constant 3
1231 acc8CompareAcc16
1232 brgt 1236
1233 acc8= constant 124
1234 writeLineAcc8
1235 ;testComparison.j(151)     if (4 <= twelve/(one+2)) println(125);
1236 acc16= variable 10
1237 <acc16= variable 2
1238 acc16+ constant 2
1239 /acc16 unstack16
1240 acc8= constant 4
1241 acc8CompareAcc16
1242 brgt 1246
1243 acc8= constant 125
1244 writeLineAcc8
1245 ;testComparison.j(152)     if (4 >= twelve/(one+2)) println(126);
1246 acc16= variable 10
1247 <acc16= variable 2
1248 acc16+ constant 2
1249 /acc16 unstack16
1250 acc8= constant 4
1251 acc8CompareAcc16
1252 brlt 1256
1253 acc8= constant 126
1254 writeLineAcc8
1255 ;testComparison.j(153)     if (5 >= twelve/(one+2)) println(127);
1256 acc16= variable 10
1257 <acc16= variable 2
1258 acc16+ constant 2
1259 /acc16 unstack16
1260 acc8= constant 5
1261 acc8CompareAcc16
1262 brlt 1266
1263 acc8= constant 127
1264 writeLineAcc8
1265 ;testComparison.j(154)     if (four == 0 + 12/(1 + 2)) println(128);
1266 acc8= constant 0
1267 <acc8= constant 12
1268 <acc8= constant 1
1269 acc8+ constant 2
1270 /acc8 unstack8
1271 acc8+ unstack8
1272 acc16= variable 6
1273 acc16CompareAcc8
1274 brne 1278
1275 acc8= constant 128
1276 writeLineAcc8
1277 ;testComparison.j(155)     if (four == 0 + 12/(1 + 2)) println(129);
1278 acc8= constant 0
1279 <acc8= constant 12
1280 <acc8= constant 1
1281 acc8+ constant 2
1282 /acc8 unstack8
1283 acc8+ unstack8
1284 acc16= variable 6
1285 acc16CompareAcc8
1286 brne 1290
1287 acc8= constant 129
1288 writeLineAcc8
1289 ;testComparison.j(156)     if (four == 0 + 12/(byteOne + 2)) println(130);
1290 acc8= constant 0
1291 <acc8= constant 12
1292 <acc8= variable 12
1293 acc8+ constant 2
1294 /acc8 unstack8
1295 acc8+ unstack8
1296 acc16= variable 6
1297 acc16CompareAcc8
1298 brne 1302
1299 acc8= constant 130
1300 writeLineAcc8
1301 ;testComparison.j(157)     if (four == 0 + 12/(one + 2)) println(131);
1302 acc8= constant 0
1303 <acc8= constant 12
1304 acc16= variable 2
1305 acc16+ constant 2
1306 /acc16 acc8
1307 acc16+ unstack8
1308 acc16Comp variable 6
1309 brne 1313
1310 acc8= constant 131
1311 writeLineAcc8
1312 ;testComparison.j(158)     if (4 == zero + twelve/(1+2)) println(132);
1313 acc16= variable 0
1314 <acc16= variable 10
1315 acc8= constant 1
1316 acc8+ constant 2
1317 acc16/ acc8
1318 acc16+ unstack16
1319 acc8= constant 4
1320 acc8CompareAcc16
1321 brne 1328
1322 acc8= constant 132
1323 writeLineAcc8
1324 ;testComparison.j(159)   
1325 ;testComparison.j(160)     /************************/
1326 ;testComparison.j(161)     // global variable b used within if scope
1327 ;testComparison.j(162)     b = 133;
1328 acc8= constant 133
1329 acc8=> variable 14
1330 ;testComparison.j(163)     if (b>132) {
1331 acc8= variable 14
1332 acc8Comp constant 132
1333 brle 1350
1334 ;testComparison.j(164)       word j = 1001;
1335 acc16= constant 1001
1336 acc16=> (basePointer + -2)
1337 ;testComparison.j(165)       byte c = b;
1338 acc8= variable 14
1339 acc8=> (basePointer + -3)
1340 ;testComparison.j(166)       byte d = c;
1341 acc8= (basePointer + -3)
1342 acc8=> (basePointer + -4)
1343 ;testComparison.j(167)       b--;
1344 decr8 variable 14
1345 ;testComparison.j(168)       println (c);
1346 acc8= (basePointer + -3)
1347 writeLineAcc8
1348 ;testComparison.j(169)     } else {
1349 br 1357
1350 ;testComparison.j(170)       println(999);
1351 acc16= constant 999
1352 writeLineAcc16
1353 ;testComparison.j(171)     }
1354 ;testComparison.j(172)   
1355 ;testComparison.j(173)     /************************/
1356 ;testComparison.j(174)     println (134);
1357 acc8= constant 134
1358 writeLineAcc8
1359 ;testComparison.j(175)     println("Klaar");
1360 acc16= stringconstant 1367
1361 writeLineString
1362 ;testComparison.j(176)   }
1363 stackPointer= basePointer
1364 basePointer<
1365 return
1366 ;testComparison.j(177) }
1367 stringConstant 0 = "Klaar"
