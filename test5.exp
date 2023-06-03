   0 ;test5.j(0) /*
   1 ;test5.j(1)  * A small program in the miniJava language.
   2 ;test5.j(2)  * Test comparisons
   3 ;test5.j(3)  */
   4 ;test5.j(4) class TestIf {
   5 ;test5.j(5)   word zero = 0;
   6 acc8= constant 0
   7 acc8=> variable 0
   8 ;test5.j(6)   word one = 1;
   9 acc8= constant 1
  10 acc8=> variable 2
  11 ;test5.j(7)   word three = 3;
  12 acc8= constant 3
  13 acc8=> variable 4
  14 ;test5.j(8)   word four = 4;
  15 acc8= constant 4
  16 acc8=> variable 6
  17 ;test5.j(9)   word five = 5;
  18 acc8= constant 5
  19 acc8=> variable 8
  20 ;test5.j(10)   word twelve = 12;
  21 acc8= constant 12
  22 acc8=> variable 10
  23 ;test5.j(11)   byte byteOne = 1;
  24 acc8= constant 1
  25 acc8=> variable 12
  26 ;test5.j(12)   byte byteSix = 262;
  27 acc16= constant 262
  28 acc16=> variable 13
  29 ;test5.j(13) 
  30 ;test5.j(14)   //stack level 1
  31 ;test5.j(15)   //byte-byte
  32 ;test5.j(16)   if (4 == 12/(1+2)) println(0);
  33 acc8= constant 12
  34 <acc8= constant 1
  35 acc8+ constant 2
  36 /acc8 unstack8
  37 acc8Comp constant 4
  38 brne 42
  39 acc8= constant 0
  40 call writeAcc8
  41 ;test5.j(17)   if (4 == 4) println(1);
  42 acc8= constant 4
  43 acc8Comp constant 4
  44 brne 48
  45 acc8= constant 1
  46 call writeAcc8
  47 ;test5.j(18)   if (3 != 12/(1+2)) println(2);
  48 acc8= constant 12
  49 <acc8= constant 1
  50 acc8+ constant 2
  51 /acc8 unstack8
  52 acc8Comp constant 3
  53 breq 57
  54 acc8= constant 2
  55 call writeAcc8
  56 ;test5.j(19)   if (3 != 4) println(3);
  57 acc8= constant 3
  58 acc8Comp constant 4
  59 breq 63
  60 acc8= constant 3
  61 call writeAcc8
  62 ;test5.j(20)   if (3 < 12/(1+2)) println(4);
  63 acc8= constant 12
  64 <acc8= constant 1
  65 acc8+ constant 2
  66 /acc8 unstack8
  67 acc8Comp constant 3
  68 brle 72
  69 acc8= constant 4
  70 call writeAcc8
  71 ;test5.j(21)   if (3 < 4) println(5);
  72 acc8= constant 3
  73 acc8Comp constant 4
  74 brge 78
  75 acc8= constant 5
  76 call writeAcc8
  77 ;test5.j(22)   if (5 > 12/(1+2)) println(6);
  78 acc8= constant 12
  79 <acc8= constant 1
  80 acc8+ constant 2
  81 /acc8 unstack8
  82 acc8Comp constant 5
  83 brge 87
  84 acc8= constant 6
  85 call writeAcc8
  86 ;test5.j(23)   if (5 > 4) println(7);
  87 acc8= constant 5
  88 acc8Comp constant 4
  89 brle 93
  90 acc8= constant 7
  91 call writeAcc8
  92 ;test5.j(24)   if (3 <= 12/(1+2)) println(8);
  93 acc8= constant 12
  94 <acc8= constant 1
  95 acc8+ constant 2
  96 /acc8 unstack8
  97 acc8Comp constant 3
  98 brlt 102
  99 acc8= constant 8
 100 call writeAcc8
 101 ;test5.j(25)   if (3 <= 4) println(9);
 102 acc8= constant 3
 103 acc8Comp constant 4
 104 brgt 108
 105 acc8= constant 9
 106 call writeAcc8
 107 ;test5.j(26)   if (4 <= 12/(1+2)) println(10);
 108 acc8= constant 12
 109 <acc8= constant 1
 110 acc8+ constant 2
 111 /acc8 unstack8
 112 acc8Comp constant 4
 113 brlt 117
 114 acc8= constant 10
 115 call writeAcc8
 116 ;test5.j(27)   if (4 <= 4) println(11);
 117 acc8= constant 4
 118 acc8Comp constant 4
 119 brgt 123
 120 acc8= constant 11
 121 call writeAcc8
 122 ;test5.j(28)   if (5 >= 12/(1+2)) println(12);
 123 acc8= constant 12
 124 <acc8= constant 1
 125 acc8+ constant 2
 126 /acc8 unstack8
 127 acc8Comp constant 5
 128 brgt 132
 129 acc8= constant 12
 130 call writeAcc8
 131 ;test5.j(29)   if (5 >= 4) println(13);
 132 acc8= constant 5
 133 acc8Comp constant 4
 134 brlt 138
 135 acc8= constant 13
 136 call writeAcc8
 137 ;test5.j(30)   if (4 >= 12/(1+2)) println(14);
 138 acc8= constant 12
 139 <acc8= constant 1
 140 acc8+ constant 2
 141 /acc8 unstack8
 142 acc8Comp constant 4
 143 brgt 147
 144 acc8= constant 14
 145 call writeAcc8
 146 ;test5.j(31)   if (4 >= 4) println(15);
 147 acc8= constant 4
 148 acc8Comp constant 4
 149 brlt 155
 150 acc8= constant 15
 151 call writeAcc8
 152 ;test5.j(32)   //stack level 1
 153 ;test5.j(33)   //byte-integer
 154 ;test5.j(34)   if (4 == twelve/(1+2)) println(16);
 155 acc16= variable 10
 156 acc8= constant 1
 157 acc8+ constant 2
 158 acc16/ acc8
 159 acc8= constant 4
 160 acc8CompareAcc16
 161 brne 165
 162 acc8= constant 16
 163 call writeAcc8
 164 ;test5.j(35)   if (4 == four) println(17);
 165 acc16= variable 6
 166 acc8= constant 4
 167 acc8CompareAcc16
 168 brne 172
 169 acc8= constant 17
 170 call writeAcc8
 171 ;test5.j(36)   if (3 != twelve/(1+2)) println(18);
 172 acc16= variable 10
 173 acc8= constant 1
 174 acc8+ constant 2
 175 acc16/ acc8
 176 acc8= constant 3
 177 acc8CompareAcc16
 178 breq 182
 179 acc8= constant 18
 180 call writeAcc8
 181 ;test5.j(37)   if (3 != four) println(19);
 182 acc16= variable 6
 183 acc8= constant 3
 184 acc8CompareAcc16
 185 breq 189
 186 acc8= constant 19
 187 call writeAcc8
 188 ;test5.j(38)   if (3 < twelve/(1+2)) println(20);
 189 acc16= variable 10
 190 acc8= constant 1
 191 acc8+ constant 2
 192 acc16/ acc8
 193 acc8= constant 3
 194 acc8CompareAcc16
 195 brge 199
 196 acc8= constant 20
 197 call writeAcc8
 198 ;test5.j(39)   if (3 < four) println(21);
 199 acc16= variable 6
 200 acc8= constant 3
 201 acc8CompareAcc16
 202 brge 206
 203 acc8= constant 21
 204 call writeAcc8
 205 ;test5.j(40)   if (5 > twelve/(1+2)) println(22);
 206 acc16= variable 10
 207 acc8= constant 1
 208 acc8+ constant 2
 209 acc16/ acc8
 210 acc8= constant 5
 211 acc8CompareAcc16
 212 brle 216
 213 acc8= constant 22
 214 call writeAcc8
 215 ;test5.j(41)   if (5 > four) println(23);
 216 acc16= variable 6
 217 acc8= constant 5
 218 acc8CompareAcc16
 219 brle 223
 220 acc8= constant 23
 221 call writeAcc8
 222 ;test5.j(42)   if (3 <= twelve/(1+2)) println(24);
 223 acc16= variable 10
 224 acc8= constant 1
 225 acc8+ constant 2
 226 acc16/ acc8
 227 acc8= constant 3
 228 acc8CompareAcc16
 229 brgt 233
 230 acc8= constant 24
 231 call writeAcc8
 232 ;test5.j(43)   if (3 <= four) println(25);
 233 acc16= variable 6
 234 acc8= constant 3
 235 acc8CompareAcc16
 236 brgt 240
 237 acc8= constant 25
 238 call writeAcc8
 239 ;test5.j(44)   if (4 <= twelve/(1+2)) println(26);
 240 acc16= variable 10
 241 acc8= constant 1
 242 acc8+ constant 2
 243 acc16/ acc8
 244 acc8= constant 4
 245 acc8CompareAcc16
 246 brgt 250
 247 acc8= constant 26
 248 call writeAcc8
 249 ;test5.j(45)   if (4 <= four) println(27);
 250 acc16= variable 6
 251 acc8= constant 4
 252 acc8CompareAcc16
 253 brgt 257
 254 acc8= constant 27
 255 call writeAcc8
 256 ;test5.j(46)   if (5 >= twelve/(1+2)) println(28);
 257 acc16= variable 10
 258 acc8= constant 1
 259 acc8+ constant 2
 260 acc16/ acc8
 261 acc8= constant 5
 262 acc8CompareAcc16
 263 brlt 267
 264 acc8= constant 28
 265 call writeAcc8
 266 ;test5.j(47)   if (5 >= four) println(29);
 267 acc16= variable 6
 268 acc8= constant 5
 269 acc8CompareAcc16
 270 brlt 274
 271 acc8= constant 29
 272 call writeAcc8
 273 ;test5.j(48)   if (4 >= twelve/(1+2)) println(30);
 274 acc16= variable 10
 275 acc8= constant 1
 276 acc8+ constant 2
 277 acc16/ acc8
 278 acc8= constant 4
 279 acc8CompareAcc16
 280 brlt 284
 281 acc8= constant 30
 282 call writeAcc8
 283 ;test5.j(49)   if (4 >= four) println(31);
 284 acc16= variable 6
 285 acc8= constant 4
 286 acc8CompareAcc16
 287 brlt 293
 288 acc8= constant 31
 289 call writeAcc8
 290 ;test5.j(50)   //stack level 1
 291 ;test5.j(51)   //integer-byte
 292 ;test5.j(52)   if (four == 12/(1+2)) println(32);
 293 acc8= constant 12
 294 <acc8= constant 1
 295 acc8+ constant 2
 296 /acc8 unstack8
 297 acc16= variable 6
 298 acc16CompareAcc8
 299 brne 303
 300 acc8= constant 32
 301 call writeAcc8
 302 ;test5.j(53)   if (four == 4) println(33);
 303 acc16= variable 6
 304 acc8= constant 4
 305 acc16CompareAcc8
 306 brne 310
 307 acc8= constant 33
 308 call writeAcc8
 309 ;test5.j(54)   if (three != 12/(1+2)) println(34);
 310 acc8= constant 12
 311 <acc8= constant 1
 312 acc8+ constant 2
 313 /acc8 unstack8
 314 acc16= variable 4
 315 acc16CompareAcc8
 316 breq 320
 317 acc8= constant 34
 318 call writeAcc8
 319 ;test5.j(55)   if (three != 4) println(35);
 320 acc16= variable 4
 321 acc8= constant 4
 322 acc16CompareAcc8
 323 breq 327
 324 acc8= constant 35
 325 call writeAcc8
 326 ;test5.j(56)   if (three < 12/(1+2)) println(36);
 327 acc8= constant 12
 328 <acc8= constant 1
 329 acc8+ constant 2
 330 /acc8 unstack8
 331 acc16= variable 4
 332 acc16CompareAcc8
 333 brge 337
 334 acc8= constant 36
 335 call writeAcc8
 336 ;test5.j(57)   if (three < 4) println(37);
 337 acc16= variable 4
 338 acc8= constant 4
 339 acc16CompareAcc8
 340 brge 344
 341 acc8= constant 37
 342 call writeAcc8
 343 ;test5.j(58)   if (five > 12/(1+2)) println(38);
 344 acc8= constant 12
 345 <acc8= constant 1
 346 acc8+ constant 2
 347 /acc8 unstack8
 348 acc16= variable 8
 349 acc16CompareAcc8
 350 brle 354
 351 acc8= constant 38
 352 call writeAcc8
 353 ;test5.j(59)   if (five > 4) println(39);
 354 acc16= variable 8
 355 acc8= constant 4
 356 acc16CompareAcc8
 357 brle 361
 358 acc8= constant 39
 359 call writeAcc8
 360 ;test5.j(60)   if (three <= 12/(1+2)) println(40);
 361 acc8= constant 12
 362 <acc8= constant 1
 363 acc8+ constant 2
 364 /acc8 unstack8
 365 acc16= variable 4
 366 acc16CompareAcc8
 367 brgt 371
 368 acc8= constant 40
 369 call writeAcc8
 370 ;test5.j(61)   if (three <= 4) println(41);
 371 acc16= variable 4
 372 acc8= constant 4
 373 acc16CompareAcc8
 374 brgt 378
 375 acc8= constant 41
 376 call writeAcc8
 377 ;test5.j(62)   if (four <= 12/(1+2)) println(42);
 378 acc8= constant 12
 379 <acc8= constant 1
 380 acc8+ constant 2
 381 /acc8 unstack8
 382 acc16= variable 6
 383 acc16CompareAcc8
 384 brgt 388
 385 acc8= constant 42
 386 call writeAcc8
 387 ;test5.j(63)   if (four <= 4) println(43);
 388 acc16= variable 6
 389 acc8= constant 4
 390 acc16CompareAcc8
 391 brgt 395
 392 acc8= constant 43
 393 call writeAcc8
 394 ;test5.j(64)   if (five >= 12/(1+2)) println(44);
 395 acc8= constant 12
 396 <acc8= constant 1
 397 acc8+ constant 2
 398 /acc8 unstack8
 399 acc16= variable 8
 400 acc16CompareAcc8
 401 brlt 405
 402 acc8= constant 44
 403 call writeAcc8
 404 ;test5.j(65)   if (five >= 4) println(45);
 405 acc16= variable 8
 406 acc8= constant 4
 407 acc16CompareAcc8
 408 brlt 412
 409 acc8= constant 45
 410 call writeAcc8
 411 ;test5.j(66)   if (four >= 12/(1+2)) println(46);
 412 acc8= constant 12
 413 <acc8= constant 1
 414 acc8+ constant 2
 415 /acc8 unstack8
 416 acc16= variable 6
 417 acc16CompareAcc8
 418 brlt 422
 419 acc8= constant 46
 420 call writeAcc8
 421 ;test5.j(67)   if (four >= 4) println(47);
 422 acc16= variable 6
 423 acc8= constant 4
 424 acc16CompareAcc8
 425 brlt 431
 426 acc8= constant 47
 427 call writeAcc8
 428 ;test5.j(68)   //stack level 1
 429 ;test5.j(69)   //integer-integer
 430 ;test5.j(70)   if (400 == 1200/(1+2)) println(48);
 431 acc16= constant 1200
 432 acc8= constant 1
 433 acc8+ constant 2
 434 acc16/ acc8
 435 acc16Comp constant 400
 436 brne 440
 437 acc8= constant 48
 438 call writeAcc8
 439 ;test5.j(71)   if (400 == 400) println(49);
 440 acc16= constant 400
 441 acc16Comp constant 400
 442 brne 446
 443 acc8= constant 49
 444 call writeAcc8
 445 ;test5.j(72)   if (300 != 1200/(1+2)) println(50);
 446 acc16= constant 1200
 447 acc8= constant 1
 448 acc8+ constant 2
 449 acc16/ acc8
 450 acc16Comp constant 300
 451 breq 455
 452 acc8= constant 50
 453 call writeAcc8
 454 ;test5.j(73)   if (300 != 400) println(51);
 455 acc16= constant 300
 456 acc16Comp constant 400
 457 breq 461
 458 acc8= constant 51
 459 call writeAcc8
 460 ;test5.j(74)   if (300 < 1200/(1+2)) println(52);
 461 acc16= constant 1200
 462 acc8= constant 1
 463 acc8+ constant 2
 464 acc16/ acc8
 465 acc16Comp constant 300
 466 brle 470
 467 acc8= constant 52
 468 call writeAcc8
 469 ;test5.j(75)   if (300 < 400) println(53);
 470 acc16= constant 300
 471 acc16Comp constant 400
 472 brge 476
 473 acc8= constant 53
 474 call writeAcc8
 475 ;test5.j(76)   if (500 > 1200/(1+2)) println(54);
 476 acc16= constant 1200
 477 acc8= constant 1
 478 acc8+ constant 2
 479 acc16/ acc8
 480 acc16Comp constant 500
 481 brge 485
 482 acc8= constant 54
 483 call writeAcc8
 484 ;test5.j(77)   if (500 > 400) println(55);
 485 acc16= constant 500
 486 acc16Comp constant 400
 487 brle 491
 488 acc8= constant 55
 489 call writeAcc8
 490 ;test5.j(78)   if (300 <= 1200/(1+2)) println(56);
 491 acc16= constant 1200
 492 acc8= constant 1
 493 acc8+ constant 2
 494 acc16/ acc8
 495 acc16Comp constant 300
 496 brlt 500
 497 acc8= constant 56
 498 call writeAcc8
 499 ;test5.j(79)   if (300 <= 400) println(57);
 500 acc16= constant 300
 501 acc16Comp constant 400
 502 brgt 506
 503 acc8= constant 57
 504 call writeAcc8
 505 ;test5.j(80)   if (400 <= 1200/(1+2)) println(58);
 506 acc16= constant 1200
 507 acc8= constant 1
 508 acc8+ constant 2
 509 acc16/ acc8
 510 acc16Comp constant 400
 511 brlt 515
 512 acc8= constant 58
 513 call writeAcc8
 514 ;test5.j(81)   if (400 <= 400) println(59);
 515 acc16= constant 400
 516 acc16Comp constant 400
 517 brgt 521
 518 acc8= constant 59
 519 call writeAcc8
 520 ;test5.j(82)   if (500 >= 1200/(1+2)) println(60);
 521 acc16= constant 1200
 522 acc8= constant 1
 523 acc8+ constant 2
 524 acc16/ acc8
 525 acc16Comp constant 500
 526 brgt 530
 527 acc8= constant 60
 528 call writeAcc8
 529 ;test5.j(83)   if (500 >= 400) println(61);
 530 acc16= constant 500
 531 acc16Comp constant 400
 532 brlt 536
 533 acc8= constant 61
 534 call writeAcc8
 535 ;test5.j(84)   if (400 >= 1200/(1+2)) println(62);
 536 acc16= constant 1200
 537 acc8= constant 1
 538 acc8+ constant 2
 539 acc16/ acc8
 540 acc16Comp constant 400
 541 brgt 545
 542 acc8= constant 62
 543 call writeAcc8
 544 ;test5.j(85)   if (400 >= 400) println(63);
 545 acc16= constant 400
 546 acc16Comp constant 400
 547 brlt 553
 548 acc8= constant 63
 549 call writeAcc8
 550 ;test5.j(86) 
 551 ;test5.j(87)   //stack level 2
 552 ;test5.j(88)   if (one+three == 12/(1+2)) println(64);
 553 acc16= variable 2
 554 acc16+ variable 4
 555 <acc16
 556 acc8= constant 12
 557 <acc8= constant 1
 558 acc8+ constant 2
 559 /acc8 unstack8
 560 acc16= unstack16
 561 acc16CompareAcc8
 562 brne 566
 563 acc8= constant 64
 564 call writeAcc8
 565 ;test5.j(89)   if (one+four  != 12/(1+2)) println(65);
 566 acc16= variable 2
 567 acc16+ variable 6
 568 <acc16
 569 acc8= constant 12
 570 <acc8= constant 1
 571 acc8+ constant 2
 572 /acc8 unstack8
 573 acc16= unstack16
 574 acc16CompareAcc8
 575 breq 579
 576 acc8= constant 65
 577 call writeAcc8
 578 ;test5.j(90)   if (one+one < 12/(1+2)) println(66);
 579 acc16= variable 2
 580 acc16+ variable 2
 581 <acc16
 582 acc8= constant 12
 583 <acc8= constant 1
 584 acc8+ constant 2
 585 /acc8 unstack8
 586 acc16= unstack16
 587 acc16CompareAcc8
 588 brge 592
 589 acc8= constant 66
 590 call writeAcc8
 591 ;test5.j(91)   if (one+four > 12/(1+2)) println(67);
 592 acc16= variable 2
 593 acc16+ variable 6
 594 <acc16
 595 acc8= constant 12
 596 <acc8= constant 1
 597 acc8+ constant 2
 598 /acc8 unstack8
 599 acc16= unstack16
 600 acc16CompareAcc8
 601 brle 605
 602 acc8= constant 67
 603 call writeAcc8
 604 ;test5.j(92)   if (one+one <= 12/(1+2)) println(68);
 605 acc16= variable 2
 606 acc16+ variable 2
 607 <acc16
 608 acc8= constant 12
 609 <acc8= constant 1
 610 acc8+ constant 2
 611 /acc8 unstack8
 612 acc16= unstack16
 613 acc16CompareAcc8
 614 brgt 618
 615 acc8= constant 68
 616 call writeAcc8
 617 ;test5.j(93)   if (one+three <= 12/(1+2)) println(69);
 618 acc16= variable 2
 619 acc16+ variable 4
 620 <acc16
 621 acc8= constant 12
 622 <acc8= constant 1
 623 acc8+ constant 2
 624 /acc8 unstack8
 625 acc16= unstack16
 626 acc16CompareAcc8
 627 brgt 631
 628 acc8= constant 69
 629 call writeAcc8
 630 ;test5.j(94)   if (one+three >= 12/(1+2)) println(70);
 631 acc16= variable 2
 632 acc16+ variable 4
 633 <acc16
 634 acc8= constant 12
 635 <acc8= constant 1
 636 acc8+ constant 2
 637 /acc8 unstack8
 638 acc16= unstack16
 639 acc16CompareAcc8
 640 brlt 644
 641 acc8= constant 70
 642 call writeAcc8
 643 ;test5.j(95)   if (one+four >= 12/(1+2)) println(71);
 644 acc16= variable 2
 645 acc16+ variable 6
 646 <acc16
 647 acc8= constant 12
 648 <acc8= constant 1
 649 acc8+ constant 2
 650 /acc8 unstack8
 651 acc16= unstack16
 652 acc16CompareAcc8
 653 brlt 657
 654 acc8= constant 71
 655 call writeAcc8
 656 ;test5.j(96)   if (one+three == twelve/(one+2)) println(72);
 657 acc16= variable 2
 658 acc16+ variable 4
 659 <acc16
 660 acc16= variable 10
 661 <acc16= variable 2
 662 acc16+ constant 2
 663 /acc16 unstack16
 664 revAcc16Comp unstack16
 665 brne 669
 666 acc8= constant 72
 667 call writeAcc8
 668 ;test5.j(97)   if (one+four  != twelve/(one+2)) println(73);
 669 acc16= variable 2
 670 acc16+ variable 6
 671 <acc16
 672 acc16= variable 10
 673 <acc16= variable 2
 674 acc16+ constant 2
 675 /acc16 unstack16
 676 revAcc16Comp unstack16
 677 breq 681
 678 acc8= constant 73
 679 call writeAcc8
 680 ;test5.j(98)   if (one+one < twelve/(one+2)) println(74);
 681 acc16= variable 2
 682 acc16+ variable 2
 683 <acc16
 684 acc16= variable 10
 685 <acc16= variable 2
 686 acc16+ constant 2
 687 /acc16 unstack16
 688 revAcc16Comp unstack16
 689 brle 693
 690 acc8= constant 74
 691 call writeAcc8
 692 ;test5.j(99)   if (one+four > twelve/(one+2)) println(75);
 693 acc16= variable 2
 694 acc16+ variable 6
 695 <acc16
 696 acc16= variable 10
 697 <acc16= variable 2
 698 acc16+ constant 2
 699 /acc16 unstack16
 700 revAcc16Comp unstack16
 701 brge 705
 702 acc8= constant 75
 703 call writeAcc8
 704 ;test5.j(100)   if (one+one <= twelve/(one+2)) println(76);
 705 acc16= variable 2
 706 acc16+ variable 2
 707 <acc16
 708 acc16= variable 10
 709 <acc16= variable 2
 710 acc16+ constant 2
 711 /acc16 unstack16
 712 revAcc16Comp unstack16
 713 brlt 717
 714 acc8= constant 76
 715 call writeAcc8
 716 ;test5.j(101)   if (one+three <= twelve/(one+2)) println(77);
 717 acc16= variable 2
 718 acc16+ variable 4
 719 <acc16
 720 acc16= variable 10
 721 <acc16= variable 2
 722 acc16+ constant 2
 723 /acc16 unstack16
 724 revAcc16Comp unstack16
 725 brlt 729
 726 acc8= constant 77
 727 call writeAcc8
 728 ;test5.j(102)   if (one+three >= twelve/(one+2)) println(78);
 729 acc16= variable 2
 730 acc16+ variable 4
 731 <acc16
 732 acc16= variable 10
 733 <acc16= variable 2
 734 acc16+ constant 2
 735 /acc16 unstack16
 736 revAcc16Comp unstack16
 737 brgt 741
 738 acc8= constant 78
 739 call writeAcc8
 740 ;test5.j(103)   if (one+four >= twelve/(one+2)) println(79);
 741 acc16= variable 2
 742 acc16+ variable 6
 743 <acc16
 744 acc16= variable 10
 745 <acc16= variable 2
 746 acc16+ constant 2
 747 /acc16 unstack16
 748 revAcc16Comp unstack16
 749 brgt 753
 750 acc8= constant 79
 751 call writeAcc8
 752 ;test5.j(104)   if (four == 12/(1+2)) println(80);
 753 acc8= constant 12
 754 <acc8= constant 1
 755 acc8+ constant 2
 756 /acc8 unstack8
 757 acc16= variable 6
 758 acc16CompareAcc8
 759 brne 763
 760 acc8= constant 80
 761 call writeAcc8
 762 ;test5.j(105)   if (three != 12/(1+2)) println(81);
 763 acc8= constant 12
 764 <acc8= constant 1
 765 acc8+ constant 2
 766 /acc8 unstack8
 767 acc16= variable 4
 768 acc16CompareAcc8
 769 breq 773
 770 acc8= constant 81
 771 call writeAcc8
 772 ;test5.j(106)   if (three < 12/(1+2)) println(82);
 773 acc8= constant 12
 774 <acc8= constant 1
 775 acc8+ constant 2
 776 /acc8 unstack8
 777 acc16= variable 4
 778 acc16CompareAcc8
 779 brge 783
 780 acc8= constant 82
 781 call writeAcc8
 782 ;test5.j(107)   if (twelve > 12/(1+2)) println(83);
 783 acc8= constant 12
 784 <acc8= constant 1
 785 acc8+ constant 2
 786 /acc8 unstack8
 787 acc16= variable 10
 788 acc16CompareAcc8
 789 brle 793
 790 acc8= constant 83
 791 call writeAcc8
 792 ;test5.j(108)   if (four <= 12/(1+2)) println(84);
 793 acc8= constant 12
 794 <acc8= constant 1
 795 acc8+ constant 2
 796 /acc8 unstack8
 797 acc16= variable 6
 798 acc16CompareAcc8
 799 brgt 803
 800 acc8= constant 84
 801 call writeAcc8
 802 ;test5.j(109)   if (three <= 12/(1+2)) println(85);
 803 acc8= constant 12
 804 <acc8= constant 1
 805 acc8+ constant 2
 806 /acc8 unstack8
 807 acc16= variable 4
 808 acc16CompareAcc8
 809 brgt 813
 810 acc8= constant 85
 811 call writeAcc8
 812 ;test5.j(110)   if (four >= 12/(1+2)) println(86);
 813 acc8= constant 12
 814 <acc8= constant 1
 815 acc8+ constant 2
 816 /acc8 unstack8
 817 acc16= variable 6
 818 acc16CompareAcc8
 819 brlt 823
 820 acc8= constant 86
 821 call writeAcc8
 822 ;test5.j(111)   if (twelve >= 12/(1+2)) println(87);
 823 acc8= constant 12
 824 <acc8= constant 1
 825 acc8+ constant 2
 826 /acc8 unstack8
 827 acc16= variable 10
 828 acc16CompareAcc8
 829 brlt 833
 830 acc8= constant 87
 831 call writeAcc8
 832 ;test5.j(112)   if (four == twelve/(one+2)) println(88);
 833 acc16= variable 10
 834 <acc16= variable 2
 835 acc16+ constant 2
 836 /acc16 unstack16
 837 acc16Comp variable 6
 838 brne 842
 839 acc8= constant 88
 840 call writeAcc8
 841 ;test5.j(113)   if (three != twelve/(one+2)) println(89);
 842 acc16= variable 10
 843 <acc16= variable 2
 844 acc16+ constant 2
 845 /acc16 unstack16
 846 acc16Comp variable 4
 847 breq 851
 848 acc8= constant 89
 849 call writeAcc8
 850 ;test5.j(114)   if (three < twelve/(one+2)) println(90);
 851 acc16= variable 10
 852 <acc16= variable 2
 853 acc16+ constant 2
 854 /acc16 unstack16
 855 acc16Comp variable 4
 856 brle 860
 857 acc8= constant 90
 858 call writeAcc8
 859 ;test5.j(115)   if (twelve > twelve/(one+2)) println(91);
 860 acc16= variable 10
 861 <acc16= variable 2
 862 acc16+ constant 2
 863 /acc16 unstack16
 864 acc16Comp variable 10
 865 brge 869
 866 acc8= constant 91
 867 call writeAcc8
 868 ;test5.j(116)   if (four <= twelve/(one+2)) println(92);
 869 acc16= variable 10
 870 <acc16= variable 2
 871 acc16+ constant 2
 872 /acc16 unstack16
 873 acc16Comp variable 6
 874 brlt 878
 875 acc8= constant 92
 876 call writeAcc8
 877 ;test5.j(117)   if (three <= twelve/(one+2)) println(93);
 878 acc16= variable 10
 879 <acc16= variable 2
 880 acc16+ constant 2
 881 /acc16 unstack16
 882 acc16Comp variable 4
 883 brlt 887
 884 acc8= constant 93
 885 call writeAcc8
 886 ;test5.j(118)   if (four >= twelve/(one+2)) println(94);
 887 acc16= variable 10
 888 <acc16= variable 2
 889 acc16+ constant 2
 890 /acc16 unstack16
 891 acc16Comp variable 6
 892 brgt 896
 893 acc8= constant 94
 894 call writeAcc8
 895 ;test5.j(119)   if (twelve >= twelve/(one+2)) println(95);
 896 acc16= variable 10
 897 <acc16= variable 2
 898 acc16+ constant 2
 899 /acc16 unstack16
 900 acc16Comp variable 10
 901 brgt 905
 902 acc8= constant 95
 903 call writeAcc8
 904 ;test5.j(120)   if (1+3 == 12/(1+2)) println(96);
 905 acc8= constant 1
 906 acc8+ constant 3
 907 <acc8
 908 acc8= constant 12
 909 <acc8= constant 1
 910 acc8+ constant 2
 911 /acc8 unstack8
 912 revAcc8Comp unstack8
 913 brne 917
 914 acc8= constant 96
 915 call writeAcc8
 916 ;test5.j(121)   if (1+2 != 12/(1+2)) println(97);
 917 acc8= constant 1
 918 acc8+ constant 2
 919 <acc8
 920 acc8= constant 12
 921 <acc8= constant 1
 922 acc8+ constant 2
 923 /acc8 unstack8
 924 revAcc8Comp unstack8
 925 breq 929
 926 acc8= constant 97
 927 call writeAcc8
 928 ;test5.j(122)   if (1+2 < 12/(1+2)) println(98);
 929 acc8= constant 1
 930 acc8+ constant 2
 931 <acc8
 932 acc8= constant 12
 933 <acc8= constant 1
 934 acc8+ constant 2
 935 /acc8 unstack8
 936 revAcc8Comp unstack8
 937 brle 941
 938 acc8= constant 98
 939 call writeAcc8
 940 ;test5.j(123)   if (1+4 > 12/(1+2)) println(99);
 941 acc8= constant 1
 942 acc8+ constant 4
 943 <acc8
 944 acc8= constant 12
 945 <acc8= constant 1
 946 acc8+ constant 2
 947 /acc8 unstack8
 948 revAcc8Comp unstack8
 949 brge 953
 950 acc8= constant 99
 951 call writeAcc8
 952 ;test5.j(124)   if (1+2 <= 12/(1+2)) println(100);
 953 acc8= constant 1
 954 acc8+ constant 2
 955 <acc8
 956 acc8= constant 12
 957 <acc8= constant 1
 958 acc8+ constant 2
 959 /acc8 unstack8
 960 revAcc8Comp unstack8
 961 brlt 965
 962 acc8= constant 100
 963 call writeAcc8
 964 ;test5.j(125)   if (1+3 <= 12/(1+2)) println(101);
 965 acc8= constant 1
 966 acc8+ constant 3
 967 <acc8
 968 acc8= constant 12
 969 <acc8= constant 1
 970 acc8+ constant 2
 971 /acc8 unstack8
 972 revAcc8Comp unstack8
 973 brlt 977
 974 acc8= constant 101
 975 call writeAcc8
 976 ;test5.j(126)   if (1+3 >= 12/(1+2)) println(102);
 977 acc8= constant 1
 978 acc8+ constant 3
 979 <acc8
 980 acc8= constant 12
 981 <acc8= constant 1
 982 acc8+ constant 2
 983 /acc8 unstack8
 984 revAcc8Comp unstack8
 985 brgt 989
 986 acc8= constant 102
 987 call writeAcc8
 988 ;test5.j(127)   if (1+4 >= 12/(1+2)) println(103);
 989 acc8= constant 1
 990 acc8+ constant 4
 991 <acc8
 992 acc8= constant 12
 993 <acc8= constant 1
 994 acc8+ constant 2
 995 /acc8 unstack8
 996 revAcc8Comp unstack8
 997 brgt 1001
 998 acc8= constant 103
 999 call writeAcc8
1000 ;test5.j(128)   if (1+3 == twelve/(one+2)) println(104);
1001 acc8= constant 1
1002 acc8+ constant 3
1003 <acc8
1004 acc16= variable 10
1005 <acc16= variable 2
1006 acc16+ constant 2
1007 /acc16 unstack16
1008 acc8= unstack8
1009 acc8CompareAcc16
1010 brne 1014
1011 acc8= constant 104
1012 call writeAcc8
1013 ;test5.j(129)   if (1+2 != twelve/(one+2)) println(105);
1014 acc8= constant 1
1015 acc8+ constant 2
1016 <acc8
1017 acc16= variable 10
1018 <acc16= variable 2
1019 acc16+ constant 2
1020 /acc16 unstack16
1021 acc8= unstack8
1022 acc8CompareAcc16
1023 breq 1027
1024 acc8= constant 105
1025 call writeAcc8
1026 ;test5.j(130)   if (1+2 < twelve/(one+2)) println(106);
1027 acc8= constant 1
1028 acc8+ constant 2
1029 <acc8
1030 acc16= variable 10
1031 <acc16= variable 2
1032 acc16+ constant 2
1033 /acc16 unstack16
1034 acc8= unstack8
1035 acc8CompareAcc16
1036 brge 1040
1037 acc8= constant 106
1038 call writeAcc8
1039 ;test5.j(131)   if (1+4 > twelve/(one+2)) println(107);
1040 acc8= constant 1
1041 acc8+ constant 4
1042 <acc8
1043 acc16= variable 10
1044 <acc16= variable 2
1045 acc16+ constant 2
1046 /acc16 unstack16
1047 acc8= unstack8
1048 acc8CompareAcc16
1049 brle 1053
1050 acc8= constant 107
1051 call writeAcc8
1052 ;test5.j(132)   if (1+2 <= twelve/(one+2)) println(108);
1053 acc8= constant 1
1054 acc8+ constant 2
1055 <acc8
1056 acc16= variable 10
1057 <acc16= variable 2
1058 acc16+ constant 2
1059 /acc16 unstack16
1060 acc8= unstack8
1061 acc8CompareAcc16
1062 brgt 1066
1063 acc8= constant 108
1064 call writeAcc8
1065 ;test5.j(133)   if (1+3 <= twelve/(one+2)) println(109);
1066 acc8= constant 1
1067 acc8+ constant 3
1068 <acc8
1069 acc16= variable 10
1070 <acc16= variable 2
1071 acc16+ constant 2
1072 /acc16 unstack16
1073 acc8= unstack8
1074 acc8CompareAcc16
1075 brgt 1079
1076 acc8= constant 109
1077 call writeAcc8
1078 ;test5.j(134)   if (1+3 >= twelve/(one+2)) println(110);
1079 acc8= constant 1
1080 acc8+ constant 3
1081 <acc8
1082 acc16= variable 10
1083 <acc16= variable 2
1084 acc16+ constant 2
1085 /acc16 unstack16
1086 acc8= unstack8
1087 acc8CompareAcc16
1088 brlt 1092
1089 acc8= constant 110
1090 call writeAcc8
1091 ;test5.j(135)   if (1+4 >= twelve/(one+2)) println(111);
1092 acc8= constant 1
1093 acc8+ constant 4
1094 <acc8
1095 acc16= variable 10
1096 <acc16= variable 2
1097 acc16+ constant 2
1098 /acc16 unstack16
1099 acc8= unstack8
1100 acc8CompareAcc16
1101 brlt 1105
1102 acc8= constant 111
1103 call writeAcc8
1104 ;test5.j(136)   if (4 == 12/(1+2)) println(112);
1105 acc8= constant 12
1106 <acc8= constant 1
1107 acc8+ constant 2
1108 /acc8 unstack8
1109 acc8Comp constant 4
1110 brne 1114
1111 acc8= constant 112
1112 call writeAcc8
1113 ;test5.j(137)   if (3 != 12/(1+2)) println(113);
1114 acc8= constant 12
1115 <acc8= constant 1
1116 acc8+ constant 2
1117 /acc8 unstack8
1118 acc8Comp constant 3
1119 breq 1123
1120 acc8= constant 113
1121 call writeAcc8
1122 ;test5.j(138)   if (3 < 12/(1+2)) println(114);
1123 acc8= constant 12
1124 <acc8= constant 1
1125 acc8+ constant 2
1126 /acc8 unstack8
1127 acc8Comp constant 3
1128 brle 1132
1129 acc8= constant 114
1130 call writeAcc8
1131 ;test5.j(139)   if (5 > 12/(1+2)) println(115);
1132 acc8= constant 12
1133 <acc8= constant 1
1134 acc8+ constant 2
1135 /acc8 unstack8
1136 acc8Comp constant 5
1137 brge 1141
1138 acc8= constant 115
1139 call writeAcc8
1140 ;test5.j(140)   if (3 <= 12/(1+2)) println(116);
1141 acc8= constant 12
1142 <acc8= constant 1
1143 acc8+ constant 2
1144 /acc8 unstack8
1145 acc8Comp constant 3
1146 brlt 1150
1147 acc8= constant 116
1148 call writeAcc8
1149 ;test5.j(141)   if (4 <= 12/(1+2)) println(117);
1150 acc8= constant 12
1151 <acc8= constant 1
1152 acc8+ constant 2
1153 /acc8 unstack8
1154 acc8Comp constant 4
1155 brlt 1159
1156 acc8= constant 117
1157 call writeAcc8
1158 ;test5.j(142)   if (4 >= 12/(1+2)) println(118);
1159 acc8= constant 12
1160 <acc8= constant 1
1161 acc8+ constant 2
1162 /acc8 unstack8
1163 acc8Comp constant 4
1164 brgt 1168
1165 acc8= constant 118
1166 call writeAcc8
1167 ;test5.j(143)   if (5 >= 12/(1+2)) println(119);
1168 acc8= constant 12
1169 <acc8= constant 1
1170 acc8+ constant 2
1171 /acc8 unstack8
1172 acc8Comp constant 5
1173 brgt 1177
1174 acc8= constant 119
1175 call writeAcc8
1176 ;test5.j(144)   if (4 == twelve/(one+2)) println(120);
1177 acc16= variable 10
1178 <acc16= variable 2
1179 acc16+ constant 2
1180 /acc16 unstack16
1181 acc8= constant 4
1182 acc8CompareAcc16
1183 brne 1187
1184 acc8= constant 120
1185 call writeAcc8
1186 ;test5.j(145)   if (3 != twelve/(one+2)) println(121);
1187 acc16= variable 10
1188 <acc16= variable 2
1189 acc16+ constant 2
1190 /acc16 unstack16
1191 acc8= constant 3
1192 acc8CompareAcc16
1193 breq 1197
1194 acc8= constant 121
1195 call writeAcc8
1196 ;test5.j(146)   if (2 < twelve/(one+2)) println(122);
1197 acc16= variable 10
1198 <acc16= variable 2
1199 acc16+ constant 2
1200 /acc16 unstack16
1201 acc8= constant 2
1202 acc8CompareAcc16
1203 brge 1207
1204 acc8= constant 122
1205 call writeAcc8
1206 ;test5.j(147)   if (5 > twelve/(one+2)) println(123);
1207 acc16= variable 10
1208 <acc16= variable 2
1209 acc16+ constant 2
1210 /acc16 unstack16
1211 acc8= constant 5
1212 acc8CompareAcc16
1213 brle 1217
1214 acc8= constant 123
1215 call writeAcc8
1216 ;test5.j(148)   if (3 <= twelve/(one+2)) println(124);
1217 acc16= variable 10
1218 <acc16= variable 2
1219 acc16+ constant 2
1220 /acc16 unstack16
1221 acc8= constant 3
1222 acc8CompareAcc16
1223 brgt 1227
1224 acc8= constant 124
1225 call writeAcc8
1226 ;test5.j(149)   if (4 <= twelve/(one+2)) println(125);
1227 acc16= variable 10
1228 <acc16= variable 2
1229 acc16+ constant 2
1230 /acc16 unstack16
1231 acc8= constant 4
1232 acc8CompareAcc16
1233 brgt 1237
1234 acc8= constant 125
1235 call writeAcc8
1236 ;test5.j(150)   if (4 >= twelve/(one+2)) println(126);
1237 acc16= variable 10
1238 <acc16= variable 2
1239 acc16+ constant 2
1240 /acc16 unstack16
1241 acc8= constant 4
1242 acc8CompareAcc16
1243 brlt 1247
1244 acc8= constant 126
1245 call writeAcc8
1246 ;test5.j(151)   if (5 >= twelve/(one+2)) println(127);
1247 acc16= variable 10
1248 <acc16= variable 2
1249 acc16+ constant 2
1250 /acc16 unstack16
1251 acc8= constant 5
1252 acc8CompareAcc16
1253 brlt 1257
1254 acc8= constant 127
1255 call writeAcc8
1256 ;test5.j(152)   if (four == 0 + 12/(1 + 2)) println(128);
1257 acc8= constant 0
1258 <acc8= constant 12
1259 <acc8= constant 1
1260 acc8+ constant 2
1261 /acc8 unstack8
1262 acc8+ unstack8
1263 acc16= variable 6
1264 acc16CompareAcc8
1265 brne 1269
1266 acc8= constant 128
1267 call writeAcc8
1268 ;test5.j(153)   if (four == 0 + 12/(1 + 2)) println(129);
1269 acc8= constant 0
1270 <acc8= constant 12
1271 <acc8= constant 1
1272 acc8+ constant 2
1273 /acc8 unstack8
1274 acc8+ unstack8
1275 acc16= variable 6
1276 acc16CompareAcc8
1277 brne 1281
1278 acc8= constant 129
1279 call writeAcc8
1280 ;test5.j(154)   if (four == 0 + 12/(byteOne + 2)) println(130);
1281 acc8= constant 0
1282 <acc8= constant 12
1283 <acc8= variable 12
1284 acc8+ constant 2
1285 /acc8 unstack8
1286 acc8+ unstack8
1287 acc16= variable 6
1288 acc16CompareAcc8
1289 brne 1293
1290 acc8= constant 130
1291 call writeAcc8
1292 ;test5.j(155)   if (four == 0 + 12/(one + 2)) println(131);
1293 acc8= constant 0
1294 <acc8= constant 12
1295 acc16= variable 2
1296 acc16+ constant 2
1297 /acc16 acc8
1298 acc16+ unstack8
1299 acc16Comp variable 6
1300 brne 1304
1301 acc8= constant 131
1302 call writeAcc8
1303 ;test5.j(156)   if (4 == zero + twelve/(1+2)) println(132);
1304 acc16= variable 0
1305 <acc16= variable 10
1306 acc8= constant 1
1307 acc8+ constant 2
1308 acc16/ acc8
1309 acc16+ unstack16
1310 acc8= constant 4
1311 acc8CompareAcc16
1312 brne 1319
1313 acc8= constant 132
1314 call writeAcc8
1315 ;test5.j(157) 
1316 ;test5.j(158)   /************************/
1317 ;test5.j(159)   // global variable within if scope
1318 ;test5.j(160)   byte b = 133;
1319 acc8= constant 133
1320 acc8=> variable 14
1321 ;test5.j(161)   if (b>132) {
1322 acc8= variable 14
1323 acc8Comp constant 132
1324 brle 1342
1325 ;test5.j(162)     word j = 1001;
1326 acc16= constant 1001
1327 acc16=> variable 15
1328 ;test5.j(163)     byte c = b;
1329 acc8= variable 14
1330 acc8=> variable 17
1331 ;test5.j(164)     byte d = c;
1332 acc8= variable 17
1333 acc8=> variable 18
1334 ;test5.j(165)     b--;
1335 decr8 variable 14
1336 ;test5.j(166)     println (c);
1337 acc8= variable 17
1338 call writeAcc8
1339 ;test5.j(167)   } else {
1340 br 1348
1341 ;test5.j(168)     println(999);
1342 acc16= constant 999
1343 call writeAcc16
1344 ;test5.j(169)   }
1345 ;test5.j(170) 
1346 ;test5.j(171)   /************************/
1347 ;test5.j(172)   println (134);
1348 acc8= constant 134
1349 call writeAcc8
1350 ;test5.j(173)   println("Klaar");
1351 acc16= constant 1355
1352 writeString
1353 ;test5.j(174) }
1354 stop
1355 stringConstant 0 = "Klaar"
