   0 ;test5.j(0) /*
   1 ;test5.j(1)  * A small program in the miniJava language.
   2 ;test5.j(2)  * Test comparisons
   3 ;test5.j(3)  */
   4 ;test5.j(4) class TestIf {
   5 ;test5.j(5)   write (134);
   6 acc8= constant 134
   7 call writeAcc8
   8 ;test5.j(6)   /************************/
   9 ;test5.j(7)   // global variable within if scope
  10 ;test5.j(8)   byte b = 133;
  11 acc8= constant 133
  12 acc8=> variable 0
  13 ;test5.j(9)   if (b>132) {
  14 acc8= variable 0
  15 acc8Comp constant 132
  16 brle 34
  17 ;test5.j(10)     word j = 1001;
  18 acc16= constant 1001
  19 acc16=> variable 1
  20 ;test5.j(11)     byte c = b;
  21 acc8= variable 0
  22 acc8=> variable 3
  23 ;test5.j(12)     byte d = c;
  24 acc8= variable 3
  25 acc8=> variable 4
  26 ;test5.j(13)     b--;
  27 decr8 variable 0
  28 ;test5.j(14)     write (c);
  29 acc8= variable 3
  30 call writeAcc8
  31 ;test5.j(15)   } else {
  32 br 39
  33 ;test5.j(16)     write(0);
  34 acc8= constant 0
  35 call writeAcc8
  36 ;test5.j(17)   }
  37 ;test5.j(18)   /************************/
  38 ;test5.j(19)   word zero = 0;
  39 acc8= constant 0
  40 acc8=> variable 1
  41 ;test5.j(20)   word one = 1;
  42 acc8= constant 1
  43 acc8=> variable 3
  44 ;test5.j(21)   word three = 3;
  45 acc8= constant 3
  46 acc8=> variable 5
  47 ;test5.j(22)   word four = 4;
  48 acc8= constant 4
  49 acc8=> variable 7
  50 ;test5.j(23)   word five = 5;
  51 acc8= constant 5
  52 acc8=> variable 9
  53 ;test5.j(24)   word twelve = 12;
  54 acc8= constant 12
  55 acc8=> variable 11
  56 ;test5.j(25)   byte byteOne = 1;
  57 acc8= constant 1
  58 acc8=> variable 13
  59 ;test5.j(26)   byte byteSix = 262;
  60 acc16= constant 262
  61 acc16=> variable 14
  62 ;test5.j(27)   if (4 == zero + twelve/(1+2)) write(132);
  63 acc16= variable 1
  64 <acc16= variable 11
  65 acc8= constant 1
  66 acc8+ constant 2
  67 acc16/ acc8
  68 acc16+ unstack16
  69 acc8= constant 4
  70 acc8CompareAcc16
  71 brne 75
  72 acc8= constant 132
  73 call writeAcc8
  74 ;test5.j(28)   if (four == 0 + 12/(one + 2)) write(131);
  75 acc8= constant 0
  76 <acc8= constant 12
  77 acc16= variable 3
  78 acc16+ constant 2
  79 /acc16 acc8
  80 acc16+ unstack8
  81 acc16Comp variable 7
  82 brne 86
  83 acc8= constant 131
  84 call writeAcc8
  85 ;test5.j(29)   if (four == 0 + 12/(byteOne + 2)) write(130);
  86 acc8= constant 0
  87 <acc8= constant 12
  88 <acc8= variable 13
  89 acc8+ constant 2
  90 /acc8 unstack8
  91 acc8+ unstack8
  92 acc16= variable 7
  93 acc16CompareAcc8
  94 brne 98
  95 acc8= constant 130
  96 call writeAcc8
  97 ;test5.j(30)   if (four == 0 + 12/(1 + 2)) write(129);
  98 acc8= constant 0
  99 <acc8= constant 12
 100 <acc8= constant 1
 101 acc8+ constant 2
 102 /acc8 unstack8
 103 acc8+ unstack8
 104 acc16= variable 7
 105 acc16CompareAcc8
 106 brne 110
 107 acc8= constant 129
 108 call writeAcc8
 109 ;test5.j(31)   if (four == 0 + 12/(1 + 2)) write(128);
 110 acc8= constant 0
 111 <acc8= constant 12
 112 <acc8= constant 1
 113 acc8+ constant 2
 114 /acc8 unstack8
 115 acc8+ unstack8
 116 acc16= variable 7
 117 acc16CompareAcc8
 118 brne 123
 119 acc8= constant 128
 120 call writeAcc8
 121 ;test5.j(32)   //stack level 2
 122 ;test5.j(33)   if (5 >= twelve/(one+2)) write(127);
 123 acc16= variable 11
 124 <acc16= variable 3
 125 acc16+ constant 2
 126 /acc16 unstack16
 127 acc8= constant 5
 128 acc8CompareAcc16
 129 brlt 133
 130 acc8= constant 127
 131 call writeAcc8
 132 ;test5.j(34)   if (4 >= twelve/(one+2)) write(126);
 133 acc16= variable 11
 134 <acc16= variable 3
 135 acc16+ constant 2
 136 /acc16 unstack16
 137 acc8= constant 4
 138 acc8CompareAcc16
 139 brlt 143
 140 acc8= constant 126
 141 call writeAcc8
 142 ;test5.j(35)   if (4 <= twelve/(one+2)) write(125);
 143 acc16= variable 11
 144 <acc16= variable 3
 145 acc16+ constant 2
 146 /acc16 unstack16
 147 acc8= constant 4
 148 acc8CompareAcc16
 149 brgt 153
 150 acc8= constant 125
 151 call writeAcc8
 152 ;test5.j(36)   if (3 <= twelve/(one+2)) write(124);
 153 acc16= variable 11
 154 <acc16= variable 3
 155 acc16+ constant 2
 156 /acc16 unstack16
 157 acc8= constant 3
 158 acc8CompareAcc16
 159 brgt 163
 160 acc8= constant 124
 161 call writeAcc8
 162 ;test5.j(37)   if (5 > twelve/(one+2)) write(123);
 163 acc16= variable 11
 164 <acc16= variable 3
 165 acc16+ constant 2
 166 /acc16 unstack16
 167 acc8= constant 5
 168 acc8CompareAcc16
 169 brle 173
 170 acc8= constant 123
 171 call writeAcc8
 172 ;test5.j(38)   if (2 < twelve/(one+2)) write(122);
 173 acc16= variable 11
 174 <acc16= variable 3
 175 acc16+ constant 2
 176 /acc16 unstack16
 177 acc8= constant 2
 178 acc8CompareAcc16
 179 brge 183
 180 acc8= constant 122
 181 call writeAcc8
 182 ;test5.j(39)   if (3 != twelve/(one+2)) write(121);
 183 acc16= variable 11
 184 <acc16= variable 3
 185 acc16+ constant 2
 186 /acc16 unstack16
 187 acc8= constant 3
 188 acc8CompareAcc16
 189 breq 193
 190 acc8= constant 121
 191 call writeAcc8
 192 ;test5.j(40)   if (4 == twelve/(one+2)) write(120);
 193 acc16= variable 11
 194 <acc16= variable 3
 195 acc16+ constant 2
 196 /acc16 unstack16
 197 acc8= constant 4
 198 acc8CompareAcc16
 199 brne 203
 200 acc8= constant 120
 201 call writeAcc8
 202 ;test5.j(41)   if (5 >= 12/(1+2)) write(119);
 203 acc8= constant 12
 204 <acc8= constant 1
 205 acc8+ constant 2
 206 /acc8 unstack8
 207 acc8Comp constant 5
 208 brgt 212
 209 acc8= constant 119
 210 call writeAcc8
 211 ;test5.j(42)   if (4 >= 12/(1+2)) write(118);
 212 acc8= constant 12
 213 <acc8= constant 1
 214 acc8+ constant 2
 215 /acc8 unstack8
 216 acc8Comp constant 4
 217 brgt 221
 218 acc8= constant 118
 219 call writeAcc8
 220 ;test5.j(43)   if (4 <= 12/(1+2)) write(117);
 221 acc8= constant 12
 222 <acc8= constant 1
 223 acc8+ constant 2
 224 /acc8 unstack8
 225 acc8Comp constant 4
 226 brlt 230
 227 acc8= constant 117
 228 call writeAcc8
 229 ;test5.j(44)   if (3 <= 12/(1+2)) write(116);
 230 acc8= constant 12
 231 <acc8= constant 1
 232 acc8+ constant 2
 233 /acc8 unstack8
 234 acc8Comp constant 3
 235 brlt 239
 236 acc8= constant 116
 237 call writeAcc8
 238 ;test5.j(45)   if (5 > 12/(1+2)) write(115);
 239 acc8= constant 12
 240 <acc8= constant 1
 241 acc8+ constant 2
 242 /acc8 unstack8
 243 acc8Comp constant 5
 244 brge 248
 245 acc8= constant 115
 246 call writeAcc8
 247 ;test5.j(46)   if (3 < 12/(1+2)) write(114);
 248 acc8= constant 12
 249 <acc8= constant 1
 250 acc8+ constant 2
 251 /acc8 unstack8
 252 acc8Comp constant 3
 253 brle 257
 254 acc8= constant 114
 255 call writeAcc8
 256 ;test5.j(47)   if (3 != 12/(1+2)) write(113);
 257 acc8= constant 12
 258 <acc8= constant 1
 259 acc8+ constant 2
 260 /acc8 unstack8
 261 acc8Comp constant 3
 262 breq 266
 263 acc8= constant 113
 264 call writeAcc8
 265 ;test5.j(48)   if (4 == 12/(1+2)) write(112);
 266 acc8= constant 12
 267 <acc8= constant 1
 268 acc8+ constant 2
 269 /acc8 unstack8
 270 acc8Comp constant 4
 271 brne 275
 272 acc8= constant 112
 273 call writeAcc8
 274 ;test5.j(49)   if (1+4 >= twelve/(one+2)) write(111);
 275 acc8= constant 1
 276 acc8+ constant 4
 277 <acc8
 278 acc16= variable 11
 279 <acc16= variable 3
 280 acc16+ constant 2
 281 /acc16 unstack16
 282 acc8= unstack8
 283 acc8CompareAcc16
 284 brlt 288
 285 acc8= constant 111
 286 call writeAcc8
 287 ;test5.j(50)   if (1+3 >= twelve/(one+2)) write(110);
 288 acc8= constant 1
 289 acc8+ constant 3
 290 <acc8
 291 acc16= variable 11
 292 <acc16= variable 3
 293 acc16+ constant 2
 294 /acc16 unstack16
 295 acc8= unstack8
 296 acc8CompareAcc16
 297 brlt 301
 298 acc8= constant 110
 299 call writeAcc8
 300 ;test5.j(51)   if (1+3 <= twelve/(one+2)) write(109);
 301 acc8= constant 1
 302 acc8+ constant 3
 303 <acc8
 304 acc16= variable 11
 305 <acc16= variable 3
 306 acc16+ constant 2
 307 /acc16 unstack16
 308 acc8= unstack8
 309 acc8CompareAcc16
 310 brgt 314
 311 acc8= constant 109
 312 call writeAcc8
 313 ;test5.j(52)   if (1+2 <= twelve/(one+2)) write(108);
 314 acc8= constant 1
 315 acc8+ constant 2
 316 <acc8
 317 acc16= variable 11
 318 <acc16= variable 3
 319 acc16+ constant 2
 320 /acc16 unstack16
 321 acc8= unstack8
 322 acc8CompareAcc16
 323 brgt 327
 324 acc8= constant 108
 325 call writeAcc8
 326 ;test5.j(53)   if (1+4 > twelve/(one+2)) write(107);
 327 acc8= constant 1
 328 acc8+ constant 4
 329 <acc8
 330 acc16= variable 11
 331 <acc16= variable 3
 332 acc16+ constant 2
 333 /acc16 unstack16
 334 acc8= unstack8
 335 acc8CompareAcc16
 336 brle 340
 337 acc8= constant 107
 338 call writeAcc8
 339 ;test5.j(54)   if (1+2 < twelve/(one+2)) write(106);
 340 acc8= constant 1
 341 acc8+ constant 2
 342 <acc8
 343 acc16= variable 11
 344 <acc16= variable 3
 345 acc16+ constant 2
 346 /acc16 unstack16
 347 acc8= unstack8
 348 acc8CompareAcc16
 349 brge 353
 350 acc8= constant 106
 351 call writeAcc8
 352 ;test5.j(55)   if (1+2 != twelve/(one+2)) write(105);
 353 acc8= constant 1
 354 acc8+ constant 2
 355 <acc8
 356 acc16= variable 11
 357 <acc16= variable 3
 358 acc16+ constant 2
 359 /acc16 unstack16
 360 acc8= unstack8
 361 acc8CompareAcc16
 362 breq 366
 363 acc8= constant 105
 364 call writeAcc8
 365 ;test5.j(56)   if (1+3 == twelve/(one+2)) write(104);
 366 acc8= constant 1
 367 acc8+ constant 3
 368 <acc8
 369 acc16= variable 11
 370 <acc16= variable 3
 371 acc16+ constant 2
 372 /acc16 unstack16
 373 acc8= unstack8
 374 acc8CompareAcc16
 375 brne 379
 376 acc8= constant 104
 377 call writeAcc8
 378 ;test5.j(57)   if (1+4 >= 12/(1+2)) write(103);
 379 acc8= constant 1
 380 acc8+ constant 4
 381 <acc8
 382 acc8= constant 12
 383 <acc8= constant 1
 384 acc8+ constant 2
 385 /acc8 unstack8
 386 revAcc8Comp unstack8
 387 brgt 391
 388 acc8= constant 103
 389 call writeAcc8
 390 ;test5.j(58)   if (1+3 >= 12/(1+2)) write(102);
 391 acc8= constant 1
 392 acc8+ constant 3
 393 <acc8
 394 acc8= constant 12
 395 <acc8= constant 1
 396 acc8+ constant 2
 397 /acc8 unstack8
 398 revAcc8Comp unstack8
 399 brgt 403
 400 acc8= constant 102
 401 call writeAcc8
 402 ;test5.j(59)   if (1+3 <= 12/(1+2)) write(101);
 403 acc8= constant 1
 404 acc8+ constant 3
 405 <acc8
 406 acc8= constant 12
 407 <acc8= constant 1
 408 acc8+ constant 2
 409 /acc8 unstack8
 410 revAcc8Comp unstack8
 411 brlt 415
 412 acc8= constant 101
 413 call writeAcc8
 414 ;test5.j(60)   if (1+2 <= 12/(1+2)) write(100);
 415 acc8= constant 1
 416 acc8+ constant 2
 417 <acc8
 418 acc8= constant 12
 419 <acc8= constant 1
 420 acc8+ constant 2
 421 /acc8 unstack8
 422 revAcc8Comp unstack8
 423 brlt 427
 424 acc8= constant 100
 425 call writeAcc8
 426 ;test5.j(61)   if (1+4 > 12/(1+2)) write(99);
 427 acc8= constant 1
 428 acc8+ constant 4
 429 <acc8
 430 acc8= constant 12
 431 <acc8= constant 1
 432 acc8+ constant 2
 433 /acc8 unstack8
 434 revAcc8Comp unstack8
 435 brge 439
 436 acc8= constant 99
 437 call writeAcc8
 438 ;test5.j(62)   if (1+2 < 12/(1+2)) write(98);
 439 acc8= constant 1
 440 acc8+ constant 2
 441 <acc8
 442 acc8= constant 12
 443 <acc8= constant 1
 444 acc8+ constant 2
 445 /acc8 unstack8
 446 revAcc8Comp unstack8
 447 brle 451
 448 acc8= constant 98
 449 call writeAcc8
 450 ;test5.j(63)   if (1+2 != 12/(1+2)) write(97);
 451 acc8= constant 1
 452 acc8+ constant 2
 453 <acc8
 454 acc8= constant 12
 455 <acc8= constant 1
 456 acc8+ constant 2
 457 /acc8 unstack8
 458 revAcc8Comp unstack8
 459 breq 463
 460 acc8= constant 97
 461 call writeAcc8
 462 ;test5.j(64)   if (1+3 == 12/(1+2)) write(96);
 463 acc8= constant 1
 464 acc8+ constant 3
 465 <acc8
 466 acc8= constant 12
 467 <acc8= constant 1
 468 acc8+ constant 2
 469 /acc8 unstack8
 470 revAcc8Comp unstack8
 471 brne 475
 472 acc8= constant 96
 473 call writeAcc8
 474 ;test5.j(65)   if (twelve >= twelve/(one+2)) write(95);
 475 acc16= variable 11
 476 <acc16= variable 3
 477 acc16+ constant 2
 478 /acc16 unstack16
 479 acc16Comp variable 11
 480 brgt 484
 481 acc8= constant 95
 482 call writeAcc8
 483 ;test5.j(66)   if (four >= twelve/(one+2)) write(94);
 484 acc16= variable 11
 485 <acc16= variable 3
 486 acc16+ constant 2
 487 /acc16 unstack16
 488 acc16Comp variable 7
 489 brgt 493
 490 acc8= constant 94
 491 call writeAcc8
 492 ;test5.j(67)   if (three <= twelve/(one+2)) write(93);
 493 acc16= variable 11
 494 <acc16= variable 3
 495 acc16+ constant 2
 496 /acc16 unstack16
 497 acc16Comp variable 5
 498 brlt 502
 499 acc8= constant 93
 500 call writeAcc8
 501 ;test5.j(68)   if (four <= twelve/(one+2)) write(92);
 502 acc16= variable 11
 503 <acc16= variable 3
 504 acc16+ constant 2
 505 /acc16 unstack16
 506 acc16Comp variable 7
 507 brlt 511
 508 acc8= constant 92
 509 call writeAcc8
 510 ;test5.j(69)   if (twelve > twelve/(one+2)) write(91);
 511 acc16= variable 11
 512 <acc16= variable 3
 513 acc16+ constant 2
 514 /acc16 unstack16
 515 acc16Comp variable 11
 516 brge 520
 517 acc8= constant 91
 518 call writeAcc8
 519 ;test5.j(70)   if (three < twelve/(one+2)) write(90);
 520 acc16= variable 11
 521 <acc16= variable 3
 522 acc16+ constant 2
 523 /acc16 unstack16
 524 acc16Comp variable 5
 525 brle 529
 526 acc8= constant 90
 527 call writeAcc8
 528 ;test5.j(71)   if (three != twelve/(one+2)) write(89);
 529 acc16= variable 11
 530 <acc16= variable 3
 531 acc16+ constant 2
 532 /acc16 unstack16
 533 acc16Comp variable 5
 534 breq 538
 535 acc8= constant 89
 536 call writeAcc8
 537 ;test5.j(72)   if (four == twelve/(one+2)) write(88);
 538 acc16= variable 11
 539 <acc16= variable 3
 540 acc16+ constant 2
 541 /acc16 unstack16
 542 acc16Comp variable 7
 543 brne 547
 544 acc8= constant 88
 545 call writeAcc8
 546 ;test5.j(73)   if (twelve >= 12/(1+2)) write(87);
 547 acc8= constant 12
 548 <acc8= constant 1
 549 acc8+ constant 2
 550 /acc8 unstack8
 551 acc16= variable 11
 552 acc16CompareAcc8
 553 brlt 557
 554 acc8= constant 87
 555 call writeAcc8
 556 ;test5.j(74)   if (four >= 12/(1+2)) write(86);
 557 acc8= constant 12
 558 <acc8= constant 1
 559 acc8+ constant 2
 560 /acc8 unstack8
 561 acc16= variable 7
 562 acc16CompareAcc8
 563 brlt 567
 564 acc8= constant 86
 565 call writeAcc8
 566 ;test5.j(75)   if (three <= 12/(1+2)) write(85);
 567 acc8= constant 12
 568 <acc8= constant 1
 569 acc8+ constant 2
 570 /acc8 unstack8
 571 acc16= variable 5
 572 acc16CompareAcc8
 573 brgt 577
 574 acc8= constant 85
 575 call writeAcc8
 576 ;test5.j(76)   if (four <= 12/(1+2)) write(84);
 577 acc8= constant 12
 578 <acc8= constant 1
 579 acc8+ constant 2
 580 /acc8 unstack8
 581 acc16= variable 7
 582 acc16CompareAcc8
 583 brgt 587
 584 acc8= constant 84
 585 call writeAcc8
 586 ;test5.j(77)   if (twelve > 12/(1+2)) write(83);
 587 acc8= constant 12
 588 <acc8= constant 1
 589 acc8+ constant 2
 590 /acc8 unstack8
 591 acc16= variable 11
 592 acc16CompareAcc8
 593 brle 597
 594 acc8= constant 83
 595 call writeAcc8
 596 ;test5.j(78)   if (three < 12/(1+2)) write(82);
 597 acc8= constant 12
 598 <acc8= constant 1
 599 acc8+ constant 2
 600 /acc8 unstack8
 601 acc16= variable 5
 602 acc16CompareAcc8
 603 brge 607
 604 acc8= constant 82
 605 call writeAcc8
 606 ;test5.j(79)   if (three != 12/(1+2)) write(81);
 607 acc8= constant 12
 608 <acc8= constant 1
 609 acc8+ constant 2
 610 /acc8 unstack8
 611 acc16= variable 5
 612 acc16CompareAcc8
 613 breq 617
 614 acc8= constant 81
 615 call writeAcc8
 616 ;test5.j(80)   if (four == 12/(1+2)) write(80);
 617 acc8= constant 12
 618 <acc8= constant 1
 619 acc8+ constant 2
 620 /acc8 unstack8
 621 acc16= variable 7
 622 acc16CompareAcc8
 623 brne 627
 624 acc8= constant 80
 625 call writeAcc8
 626 ;test5.j(81)   if (one+four >= twelve/(one+2)) write(79);
 627 acc16= variable 3
 628 acc16+ variable 7
 629 <acc16
 630 acc16= variable 11
 631 <acc16= variable 3
 632 acc16+ constant 2
 633 /acc16 unstack16
 634 revAcc16Comp unstack16
 635 brgt 639
 636 acc8= constant 79
 637 call writeAcc8
 638 ;test5.j(82)   if (one+three >= twelve/(one+2)) write(78);
 639 acc16= variable 3
 640 acc16+ variable 5
 641 <acc16
 642 acc16= variable 11
 643 <acc16= variable 3
 644 acc16+ constant 2
 645 /acc16 unstack16
 646 revAcc16Comp unstack16
 647 brgt 651
 648 acc8= constant 78
 649 call writeAcc8
 650 ;test5.j(83)   if (one+three <= twelve/(one+2)) write(77);
 651 acc16= variable 3
 652 acc16+ variable 5
 653 <acc16
 654 acc16= variable 11
 655 <acc16= variable 3
 656 acc16+ constant 2
 657 /acc16 unstack16
 658 revAcc16Comp unstack16
 659 brlt 663
 660 acc8= constant 77
 661 call writeAcc8
 662 ;test5.j(84)   if (one+one <= twelve/(one+2)) write(76);
 663 acc16= variable 3
 664 acc16+ variable 3
 665 <acc16
 666 acc16= variable 11
 667 <acc16= variable 3
 668 acc16+ constant 2
 669 /acc16 unstack16
 670 revAcc16Comp unstack16
 671 brlt 675
 672 acc8= constant 76
 673 call writeAcc8
 674 ;test5.j(85)   if (one+four > twelve/(one+2)) write(75);
 675 acc16= variable 3
 676 acc16+ variable 7
 677 <acc16
 678 acc16= variable 11
 679 <acc16= variable 3
 680 acc16+ constant 2
 681 /acc16 unstack16
 682 revAcc16Comp unstack16
 683 brge 687
 684 acc8= constant 75
 685 call writeAcc8
 686 ;test5.j(86)   if (one+one < twelve/(one+2)) write(74);
 687 acc16= variable 3
 688 acc16+ variable 3
 689 <acc16
 690 acc16= variable 11
 691 <acc16= variable 3
 692 acc16+ constant 2
 693 /acc16 unstack16
 694 revAcc16Comp unstack16
 695 brle 699
 696 acc8= constant 74
 697 call writeAcc8
 698 ;test5.j(87)   if (one+four  != twelve/(one+2)) write(73);
 699 acc16= variable 3
 700 acc16+ variable 7
 701 <acc16
 702 acc16= variable 11
 703 <acc16= variable 3
 704 acc16+ constant 2
 705 /acc16 unstack16
 706 revAcc16Comp unstack16
 707 breq 711
 708 acc8= constant 73
 709 call writeAcc8
 710 ;test5.j(88)   if (one+three == twelve/(one+2)) write(72);
 711 acc16= variable 3
 712 acc16+ variable 5
 713 <acc16
 714 acc16= variable 11
 715 <acc16= variable 3
 716 acc16+ constant 2
 717 /acc16 unstack16
 718 revAcc16Comp unstack16
 719 brne 723
 720 acc8= constant 72
 721 call writeAcc8
 722 ;test5.j(89)   if (one+four >= 12/(1+2)) write(71);
 723 acc16= variable 3
 724 acc16+ variable 7
 725 <acc16
 726 acc8= constant 12
 727 <acc8= constant 1
 728 acc8+ constant 2
 729 /acc8 unstack8
 730 acc16= unstack16
 731 acc16CompareAcc8
 732 brlt 736
 733 acc8= constant 71
 734 call writeAcc8
 735 ;test5.j(90)   if (one+three >= 12/(1+2)) write(70);
 736 acc16= variable 3
 737 acc16+ variable 5
 738 <acc16
 739 acc8= constant 12
 740 <acc8= constant 1
 741 acc8+ constant 2
 742 /acc8 unstack8
 743 acc16= unstack16
 744 acc16CompareAcc8
 745 brlt 749
 746 acc8= constant 70
 747 call writeAcc8
 748 ;test5.j(91)   if (one+three <= 12/(1+2)) write(69);
 749 acc16= variable 3
 750 acc16+ variable 5
 751 <acc16
 752 acc8= constant 12
 753 <acc8= constant 1
 754 acc8+ constant 2
 755 /acc8 unstack8
 756 acc16= unstack16
 757 acc16CompareAcc8
 758 brgt 762
 759 acc8= constant 69
 760 call writeAcc8
 761 ;test5.j(92)   if (one+one <= 12/(1+2)) write(68);
 762 acc16= variable 3
 763 acc16+ variable 3
 764 <acc16
 765 acc8= constant 12
 766 <acc8= constant 1
 767 acc8+ constant 2
 768 /acc8 unstack8
 769 acc16= unstack16
 770 acc16CompareAcc8
 771 brgt 775
 772 acc8= constant 68
 773 call writeAcc8
 774 ;test5.j(93)   if (one+four > 12/(1+2)) write(67);
 775 acc16= variable 3
 776 acc16+ variable 7
 777 <acc16
 778 acc8= constant 12
 779 <acc8= constant 1
 780 acc8+ constant 2
 781 /acc8 unstack8
 782 acc16= unstack16
 783 acc16CompareAcc8
 784 brle 788
 785 acc8= constant 67
 786 call writeAcc8
 787 ;test5.j(94)   if (one+one < 12/(1+2)) write(66);
 788 acc16= variable 3
 789 acc16+ variable 3
 790 <acc16
 791 acc8= constant 12
 792 <acc8= constant 1
 793 acc8+ constant 2
 794 /acc8 unstack8
 795 acc16= unstack16
 796 acc16CompareAcc8
 797 brge 801
 798 acc8= constant 66
 799 call writeAcc8
 800 ;test5.j(95)   if (one+four  != 12/(1+2)) write(65);
 801 acc16= variable 3
 802 acc16+ variable 7
 803 <acc16
 804 acc8= constant 12
 805 <acc8= constant 1
 806 acc8+ constant 2
 807 /acc8 unstack8
 808 acc16= unstack16
 809 acc16CompareAcc8
 810 breq 814
 811 acc8= constant 65
 812 call writeAcc8
 813 ;test5.j(96)   if (one+three == 12/(1+2)) write(64);
 814 acc16= variable 3
 815 acc16+ variable 5
 816 <acc16
 817 acc8= constant 12
 818 <acc8= constant 1
 819 acc8+ constant 2
 820 /acc8 unstack8
 821 acc16= unstack16
 822 acc16CompareAcc8
 823 brne 829
 824 acc8= constant 64
 825 call writeAcc8
 826 ;test5.j(97)   //stack level 1
 827 ;test5.j(98)   //integer-byte
 828 ;test5.j(99)   if (four >= 4) write(63);
 829 acc16= variable 7
 830 acc8= constant 4
 831 acc16CompareAcc8
 832 brlt 836
 833 acc8= constant 63
 834 call writeAcc8
 835 ;test5.j(100)   if (four >= 12/(1+2)) write(62);
 836 acc8= constant 12
 837 <acc8= constant 1
 838 acc8+ constant 2
 839 /acc8 unstack8
 840 acc16= variable 7
 841 acc16CompareAcc8
 842 brlt 846
 843 acc8= constant 62
 844 call writeAcc8
 845 ;test5.j(101)   if (five >= 4) write(61);
 846 acc16= variable 9
 847 acc8= constant 4
 848 acc16CompareAcc8
 849 brlt 853
 850 acc8= constant 61
 851 call writeAcc8
 852 ;test5.j(102)   if (five >= 12/(1+2)) write(60);
 853 acc8= constant 12
 854 <acc8= constant 1
 855 acc8+ constant 2
 856 /acc8 unstack8
 857 acc16= variable 9
 858 acc16CompareAcc8
 859 brlt 863
 860 acc8= constant 60
 861 call writeAcc8
 862 ;test5.j(103)   if (four <= 4) write(59);
 863 acc16= variable 7
 864 acc8= constant 4
 865 acc16CompareAcc8
 866 brgt 870
 867 acc8= constant 59
 868 call writeAcc8
 869 ;test5.j(104)   if (four <= 12/(1+2)) write(58);
 870 acc8= constant 12
 871 <acc8= constant 1
 872 acc8+ constant 2
 873 /acc8 unstack8
 874 acc16= variable 7
 875 acc16CompareAcc8
 876 brgt 880
 877 acc8= constant 58
 878 call writeAcc8
 879 ;test5.j(105)   if (three <= 4) write(57);
 880 acc16= variable 5
 881 acc8= constant 4
 882 acc16CompareAcc8
 883 brgt 887
 884 acc8= constant 57
 885 call writeAcc8
 886 ;test5.j(106)   if (three <= 12/(1+2)) write(56);
 887 acc8= constant 12
 888 <acc8= constant 1
 889 acc8+ constant 2
 890 /acc8 unstack8
 891 acc16= variable 5
 892 acc16CompareAcc8
 893 brgt 897
 894 acc8= constant 56
 895 call writeAcc8
 896 ;test5.j(107)   if (five > 4) write(55);
 897 acc16= variable 9
 898 acc8= constant 4
 899 acc16CompareAcc8
 900 brle 904
 901 acc8= constant 55
 902 call writeAcc8
 903 ;test5.j(108)   if (five > 12/(1+2)) write(54);
 904 acc8= constant 12
 905 <acc8= constant 1
 906 acc8+ constant 2
 907 /acc8 unstack8
 908 acc16= variable 9
 909 acc16CompareAcc8
 910 brle 914
 911 acc8= constant 54
 912 call writeAcc8
 913 ;test5.j(109)   if (three < 4) write(53);
 914 acc16= variable 5
 915 acc8= constant 4
 916 acc16CompareAcc8
 917 brge 921
 918 acc8= constant 53
 919 call writeAcc8
 920 ;test5.j(110)   if (three < 12/(1+2)) write(52);
 921 acc8= constant 12
 922 <acc8= constant 1
 923 acc8+ constant 2
 924 /acc8 unstack8
 925 acc16= variable 5
 926 acc16CompareAcc8
 927 brge 931
 928 acc8= constant 52
 929 call writeAcc8
 930 ;test5.j(111)   if (three != 4) write(51);
 931 acc16= variable 5
 932 acc8= constant 4
 933 acc16CompareAcc8
 934 breq 938
 935 acc8= constant 51
 936 call writeAcc8
 937 ;test5.j(112)   if (three != 12/(1+2)) write(50);
 938 acc8= constant 12
 939 <acc8= constant 1
 940 acc8+ constant 2
 941 /acc8 unstack8
 942 acc16= variable 5
 943 acc16CompareAcc8
 944 breq 948
 945 acc8= constant 50
 946 call writeAcc8
 947 ;test5.j(113)   if (four == 4) write(49);
 948 acc16= variable 7
 949 acc8= constant 4
 950 acc16CompareAcc8
 951 brne 955
 952 acc8= constant 49
 953 call writeAcc8
 954 ;test5.j(114)   if (four == 12/(1+2)) write(48);
 955 acc8= constant 12
 956 <acc8= constant 1
 957 acc8+ constant 2
 958 /acc8 unstack8
 959 acc16= variable 7
 960 acc16CompareAcc8
 961 brne 966
 962 acc8= constant 48
 963 call writeAcc8
 964 ;test5.j(115)   //byte-integer
 965 ;test5.j(116)   if (4 >= four) write(47);
 966 acc16= variable 7
 967 acc8= constant 4
 968 acc8CompareAcc16
 969 brlt 973
 970 acc8= constant 47
 971 call writeAcc8
 972 ;test5.j(117)   if (4 >= twelve/(1+2)) write(46);
 973 acc16= variable 11
 974 acc8= constant 1
 975 acc8+ constant 2
 976 acc16/ acc8
 977 acc8= constant 4
 978 acc8CompareAcc16
 979 brlt 983
 980 acc8= constant 46
 981 call writeAcc8
 982 ;test5.j(118)   if (5 >= four) write(45);
 983 acc16= variable 7
 984 acc8= constant 5
 985 acc8CompareAcc16
 986 brlt 990
 987 acc8= constant 45
 988 call writeAcc8
 989 ;test5.j(119)   if (5 >= twelve/(1+2)) write(44);
 990 acc16= variable 11
 991 acc8= constant 1
 992 acc8+ constant 2
 993 acc16/ acc8
 994 acc8= constant 5
 995 acc8CompareAcc16
 996 brlt 1000
 997 acc8= constant 44
 998 call writeAcc8
 999 ;test5.j(120)   if (4 <= four) write(43);
1000 acc16= variable 7
1001 acc8= constant 4
1002 acc8CompareAcc16
1003 brgt 1007
1004 acc8= constant 43
1005 call writeAcc8
1006 ;test5.j(121)   if (4 <= twelve/(1+2)) write(42);
1007 acc16= variable 11
1008 acc8= constant 1
1009 acc8+ constant 2
1010 acc16/ acc8
1011 acc8= constant 4
1012 acc8CompareAcc16
1013 brgt 1017
1014 acc8= constant 42
1015 call writeAcc8
1016 ;test5.j(122)   if (3 <= four) write(41);
1017 acc16= variable 7
1018 acc8= constant 3
1019 acc8CompareAcc16
1020 brgt 1024
1021 acc8= constant 41
1022 call writeAcc8
1023 ;test5.j(123)   if (3 <= twelve/(1+2)) write(40);
1024 acc16= variable 11
1025 acc8= constant 1
1026 acc8+ constant 2
1027 acc16/ acc8
1028 acc8= constant 3
1029 acc8CompareAcc16
1030 brgt 1034
1031 acc8= constant 40
1032 call writeAcc8
1033 ;test5.j(124)   if (5 > four) write(39);
1034 acc16= variable 7
1035 acc8= constant 5
1036 acc8CompareAcc16
1037 brle 1041
1038 acc8= constant 39
1039 call writeAcc8
1040 ;test5.j(125)   if (5 > twelve/(1+2)) write(38);
1041 acc16= variable 11
1042 acc8= constant 1
1043 acc8+ constant 2
1044 acc16/ acc8
1045 acc8= constant 5
1046 acc8CompareAcc16
1047 brle 1051
1048 acc8= constant 38
1049 call writeAcc8
1050 ;test5.j(126)   if (3 < four) write(37);
1051 acc16= variable 7
1052 acc8= constant 3
1053 acc8CompareAcc16
1054 brge 1058
1055 acc8= constant 37
1056 call writeAcc8
1057 ;test5.j(127)   if (3 < twelve/(1+2)) write(36);
1058 acc16= variable 11
1059 acc8= constant 1
1060 acc8+ constant 2
1061 acc16/ acc8
1062 acc8= constant 3
1063 acc8CompareAcc16
1064 brge 1068
1065 acc8= constant 36
1066 call writeAcc8
1067 ;test5.j(128)   if (3 != four) write(35);
1068 acc16= variable 7
1069 acc8= constant 3
1070 acc8CompareAcc16
1071 breq 1075
1072 acc8= constant 35
1073 call writeAcc8
1074 ;test5.j(129)   if (3 != twelve/(1+2)) write(34);
1075 acc16= variable 11
1076 acc8= constant 1
1077 acc8+ constant 2
1078 acc16/ acc8
1079 acc8= constant 3
1080 acc8CompareAcc16
1081 breq 1085
1082 acc8= constant 34
1083 call writeAcc8
1084 ;test5.j(130)   if (4 == four) write(33);
1085 acc16= variable 7
1086 acc8= constant 4
1087 acc8CompareAcc16
1088 brne 1092
1089 acc8= constant 33
1090 call writeAcc8
1091 ;test5.j(131)   if (4 == twelve/(1+2)) write(32);
1092 acc16= variable 11
1093 acc8= constant 1
1094 acc8+ constant 2
1095 acc16/ acc8
1096 acc8= constant 4
1097 acc8CompareAcc16
1098 brne 1103
1099 acc8= constant 32
1100 call writeAcc8
1101 ;test5.j(132)   //integer-integer
1102 ;test5.j(133)   if (400 >= 400) write(31);
1103 acc16= constant 400
1104 acc16Comp constant 400
1105 brlt 1109
1106 acc8= constant 31
1107 call writeAcc8
1108 ;test5.j(134)   if (400 >= 1200/(1+2)) write(30);
1109 acc16= constant 1200
1110 acc8= constant 1
1111 acc8+ constant 2
1112 acc16/ acc8
1113 acc16Comp constant 400
1114 brgt 1118
1115 acc8= constant 30
1116 call writeAcc8
1117 ;test5.j(135)   if (500 >= 400) write(29);
1118 acc16= constant 500
1119 acc16Comp constant 400
1120 brlt 1124
1121 acc8= constant 29
1122 call writeAcc8
1123 ;test5.j(136)   if (500 >= 1200/(1+2)) write(28);
1124 acc16= constant 1200
1125 acc8= constant 1
1126 acc8+ constant 2
1127 acc16/ acc8
1128 acc16Comp constant 500
1129 brgt 1133
1130 acc8= constant 28
1131 call writeAcc8
1132 ;test5.j(137)   if (400 <= 400) write(27);
1133 acc16= constant 400
1134 acc16Comp constant 400
1135 brgt 1139
1136 acc8= constant 27
1137 call writeAcc8
1138 ;test5.j(138)   if (400 <= 1200/(1+2)) write(26);
1139 acc16= constant 1200
1140 acc8= constant 1
1141 acc8+ constant 2
1142 acc16/ acc8
1143 acc16Comp constant 400
1144 brlt 1148
1145 acc8= constant 26
1146 call writeAcc8
1147 ;test5.j(139)   if (300 <= 400) write(25);
1148 acc16= constant 300
1149 acc16Comp constant 400
1150 brgt 1154
1151 acc8= constant 25
1152 call writeAcc8
1153 ;test5.j(140)   if (300 <= 1200/(1+2)) write(24);
1154 acc16= constant 1200
1155 acc8= constant 1
1156 acc8+ constant 2
1157 acc16/ acc8
1158 acc16Comp constant 300
1159 brlt 1163
1160 acc8= constant 24
1161 call writeAcc8
1162 ;test5.j(141)   if (500 > 400) write(23);
1163 acc16= constant 500
1164 acc16Comp constant 400
1165 brle 1169
1166 acc8= constant 23
1167 call writeAcc8
1168 ;test5.j(142)   if (500 > 1200/(1+2)) write(22);
1169 acc16= constant 1200
1170 acc8= constant 1
1171 acc8+ constant 2
1172 acc16/ acc8
1173 acc16Comp constant 500
1174 brge 1178
1175 acc8= constant 22
1176 call writeAcc8
1177 ;test5.j(143)   if (300 < 400) write(21);
1178 acc16= constant 300
1179 acc16Comp constant 400
1180 brge 1184
1181 acc8= constant 21
1182 call writeAcc8
1183 ;test5.j(144)   if (300 < 1200/(1+2)) write(20);
1184 acc16= constant 1200
1185 acc8= constant 1
1186 acc8+ constant 2
1187 acc16/ acc8
1188 acc16Comp constant 300
1189 brle 1193
1190 acc8= constant 20
1191 call writeAcc8
1192 ;test5.j(145)   if (300 != 400) write(19);
1193 acc16= constant 300
1194 acc16Comp constant 400
1195 breq 1199
1196 acc8= constant 19
1197 call writeAcc8
1198 ;test5.j(146)   if (300 != 1200/(1+2)) write(18);
1199 acc16= constant 1200
1200 acc8= constant 1
1201 acc8+ constant 2
1202 acc16/ acc8
1203 acc16Comp constant 300
1204 breq 1208
1205 acc8= constant 18
1206 call writeAcc8
1207 ;test5.j(147)   if (400 == 400) write(17);
1208 acc16= constant 400
1209 acc16Comp constant 400
1210 brne 1214
1211 acc8= constant 17
1212 call writeAcc8
1213 ;test5.j(148)   if (400 == 1200/(1+2)) write(16);
1214 acc16= constant 1200
1215 acc8= constant 1
1216 acc8+ constant 2
1217 acc16/ acc8
1218 acc16Comp constant 400
1219 brne 1224
1220 acc8= constant 16
1221 call writeAcc8
1222 ;test5.j(149)   //byte-byte
1223 ;test5.j(150)   if (4 >= 4) write(15);
1224 acc8= constant 4
1225 acc8Comp constant 4
1226 brlt 1230
1227 acc8= constant 15
1228 call writeAcc8
1229 ;test5.j(151)   if (4 >= 12/(1+2)) write(14);
1230 acc8= constant 12
1231 <acc8= constant 1
1232 acc8+ constant 2
1233 /acc8 unstack8
1234 acc8Comp constant 4
1235 brgt 1239
1236 acc8= constant 14
1237 call writeAcc8
1238 ;test5.j(152)   if (5 >= 4) write(13);
1239 acc8= constant 5
1240 acc8Comp constant 4
1241 brlt 1245
1242 acc8= constant 13
1243 call writeAcc8
1244 ;test5.j(153)   if (5 >= 12/(1+2)) write(12);
1245 acc8= constant 12
1246 <acc8= constant 1
1247 acc8+ constant 2
1248 /acc8 unstack8
1249 acc8Comp constant 5
1250 brgt 1254
1251 acc8= constant 12
1252 call writeAcc8
1253 ;test5.j(154)   if (4 <= 4) write(11);
1254 acc8= constant 4
1255 acc8Comp constant 4
1256 brgt 1260
1257 acc8= constant 11
1258 call writeAcc8
1259 ;test5.j(155)   if (4 <= 12/(1+2)) write(10);
1260 acc8= constant 12
1261 <acc8= constant 1
1262 acc8+ constant 2
1263 /acc8 unstack8
1264 acc8Comp constant 4
1265 brlt 1269
1266 acc8= constant 10
1267 call writeAcc8
1268 ;test5.j(156)   if (3 <= 4) write(9);
1269 acc8= constant 3
1270 acc8Comp constant 4
1271 brgt 1275
1272 acc8= constant 9
1273 call writeAcc8
1274 ;test5.j(157)   if (3 <= 12/(1+2)) write(8);
1275 acc8= constant 12
1276 <acc8= constant 1
1277 acc8+ constant 2
1278 /acc8 unstack8
1279 acc8Comp constant 3
1280 brlt 1284
1281 acc8= constant 8
1282 call writeAcc8
1283 ;test5.j(158)   if (5 > 4) write(7);
1284 acc8= constant 5
1285 acc8Comp constant 4
1286 brle 1290
1287 acc8= constant 7
1288 call writeAcc8
1289 ;test5.j(159)   if (5 > 12/(1+2)) write(6);
1290 acc8= constant 12
1291 <acc8= constant 1
1292 acc8+ constant 2
1293 /acc8 unstack8
1294 acc8Comp constant 5
1295 brge 1299
1296 acc8= constant 6
1297 call writeAcc8
1298 ;test5.j(160)   if (3 < 4) write(5);
1299 acc8= constant 3
1300 acc8Comp constant 4
1301 brge 1305
1302 acc8= constant 5
1303 call writeAcc8
1304 ;test5.j(161)   if (3 < 12/(1+2)) write(4);
1305 acc8= constant 12
1306 <acc8= constant 1
1307 acc8+ constant 2
1308 /acc8 unstack8
1309 acc8Comp constant 3
1310 brle 1314
1311 acc8= constant 4
1312 call writeAcc8
1313 ;test5.j(162)   if (3 != 4) write(3);
1314 acc8= constant 3
1315 acc8Comp constant 4
1316 breq 1320
1317 acc8= constant 3
1318 call writeAcc8
1319 ;test5.j(163)   if (3 != 12/(1+2)) write(2);
1320 acc8= constant 12
1321 <acc8= constant 1
1322 acc8+ constant 2
1323 /acc8 unstack8
1324 acc8Comp constant 3
1325 breq 1329
1326 acc8= constant 2
1327 call writeAcc8
1328 ;test5.j(164)   if (4 == 4) write(1);
1329 acc8= constant 4
1330 acc8Comp constant 4
1331 brne 1335
1332 acc8= constant 1
1333 call writeAcc8
1334 ;test5.j(165)   if (4 == 12/(1+2)) write(0);
1335 acc8= constant 12
1336 <acc8= constant 1
1337 acc8+ constant 2
1338 /acc8 unstack8
1339 acc8Comp constant 4
1340 brne 1344
1341 acc8= constant 0
1342 call writeAcc8
1343 ;test5.j(166) }
1344 stop
