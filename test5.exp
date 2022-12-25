   0 ;test5.j(0) /*
   1 ;test5.j(1)  * A small program in the miniJava language.
   2 ;test5.j(2)  * Test comparisons
   3 ;test5.j(3)  */
   4 ;test5.j(4) class TestIf {
   5 ;test5.j(5)   int zero = 0;
   6 acc8= constant 0
   7 acc8=> variable 0
   8 ;test5.j(6)   int one = 1;
   9 acc8= constant 1
  10 acc8=> variable 2
  11 ;test5.j(7)   int three = 3;
  12 acc8= constant 3
  13 acc8=> variable 4
  14 ;test5.j(8)   int four = 4;
  15 acc8= constant 4
  16 acc8=> variable 6
  17 ;test5.j(9)   int five = 5;
  18 acc8= constant 5
  19 acc8=> variable 8
  20 ;test5.j(10)   int twelve = 12;
  21 acc8= constant 12
  22 acc8=> variable 10
  23 ;test5.j(11)   byte byteOne = 1;
  24 acc8= constant 1
  25 acc8=> variable 12
  26 ;test5.j(12)   byte byteSix = 262;
  27 acc16= constant 262
  28 acc16=> variable 13
  29 ;test5.j(13)   write(133);
  30 acc8= constant 133
  31 call writeAcc8
  32 ;test5.j(14)   if (4 == zero + twelve/(1+2)) write(132);
  33 acc16= variable 0
  34 <acc16= variable 10
  35 acc8= constant 1
  36 acc8+ constant 2
  37 acc16/ acc8
  38 acc16+ unstack16
  39 acc8= constant 4
  40 acc8CompareAcc16
  41 brne 45
  42 acc8= constant 132
  43 call writeAcc8
  44 ;test5.j(15)   if (four == 0 + 12/(one + 2)) write(131);
  45 acc8= constant 0
  46 <acc8= constant 12
  47 acc16= variable 2
  48 acc16+ constant 2
  49 /acc16 acc8
  50 acc16+ unstack8
  51 acc16Comp variable 6
  52 brne 56
  53 acc8= constant 131
  54 call writeAcc8
  55 ;test5.j(16)   if (four == 0 + 12/(byteOne + 2)) write(130);
  56 acc8= constant 0
  57 <acc8= constant 12
  58 <acc8= variable 12
  59 acc8+ constant 2
  60 /acc8 unstack8
  61 acc8+ unstack8
  62 acc16= variable 6
  63 acc16CompareAcc8
  64 brne 68
  65 acc8= constant 130
  66 call writeAcc8
  67 ;test5.j(17)   if (four == 0 + 12/(1 + 2)) write(129);
  68 acc8= constant 0
  69 <acc8= constant 12
  70 <acc8= constant 1
  71 acc8+ constant 2
  72 /acc8 unstack8
  73 acc8+ unstack8
  74 acc16= variable 6
  75 acc16CompareAcc8
  76 brne 80
  77 acc8= constant 129
  78 call writeAcc8
  79 ;test5.j(18)   if (four == 0 + 12/(1 + 2)) write(128);
  80 acc8= constant 0
  81 <acc8= constant 12
  82 <acc8= constant 1
  83 acc8+ constant 2
  84 /acc8 unstack8
  85 acc8+ unstack8
  86 acc16= variable 6
  87 acc16CompareAcc8
  88 brne 93
  89 acc8= constant 128
  90 call writeAcc8
  91 ;test5.j(19)   //stack level 2
  92 ;test5.j(20)   if (5 >= twelve/(one+2)) write(127);
  93 acc16= variable 10
  94 <acc16= variable 2
  95 acc16+ constant 2
  96 /acc16 unstack16
  97 acc8= constant 5
  98 acc8CompareAcc16
  99 brlt 103
 100 acc8= constant 127
 101 call writeAcc8
 102 ;test5.j(21)   if (4 >= twelve/(one+2)) write(126);
 103 acc16= variable 10
 104 <acc16= variable 2
 105 acc16+ constant 2
 106 /acc16 unstack16
 107 acc8= constant 4
 108 acc8CompareAcc16
 109 brlt 113
 110 acc8= constant 126
 111 call writeAcc8
 112 ;test5.j(22)   if (4 <= twelve/(one+2)) write(125);
 113 acc16= variable 10
 114 <acc16= variable 2
 115 acc16+ constant 2
 116 /acc16 unstack16
 117 acc8= constant 4
 118 acc8CompareAcc16
 119 brgt 123
 120 acc8= constant 125
 121 call writeAcc8
 122 ;test5.j(23)   if (3 <= twelve/(one+2)) write(124);
 123 acc16= variable 10
 124 <acc16= variable 2
 125 acc16+ constant 2
 126 /acc16 unstack16
 127 acc8= constant 3
 128 acc8CompareAcc16
 129 brgt 133
 130 acc8= constant 124
 131 call writeAcc8
 132 ;test5.j(24)   if (5 > twelve/(one+2)) write(123);
 133 acc16= variable 10
 134 <acc16= variable 2
 135 acc16+ constant 2
 136 /acc16 unstack16
 137 acc8= constant 5
 138 acc8CompareAcc16
 139 brle 143
 140 acc8= constant 123
 141 call writeAcc8
 142 ;test5.j(25)   if (2 < twelve/(one+2)) write(122);
 143 acc16= variable 10
 144 <acc16= variable 2
 145 acc16+ constant 2
 146 /acc16 unstack16
 147 acc8= constant 2
 148 acc8CompareAcc16
 149 brge 153
 150 acc8= constant 122
 151 call writeAcc8
 152 ;test5.j(26)   if (3 != twelve/(one+2)) write(121);
 153 acc16= variable 10
 154 <acc16= variable 2
 155 acc16+ constant 2
 156 /acc16 unstack16
 157 acc8= constant 3
 158 acc8CompareAcc16
 159 breq 163
 160 acc8= constant 121
 161 call writeAcc8
 162 ;test5.j(27)   if (4 == twelve/(one+2)) write(120);
 163 acc16= variable 10
 164 <acc16= variable 2
 165 acc16+ constant 2
 166 /acc16 unstack16
 167 acc8= constant 4
 168 acc8CompareAcc16
 169 brne 173
 170 acc8= constant 120
 171 call writeAcc8
 172 ;test5.j(28)   if (5 >= 12/(1+2)) write(119);
 173 acc8= constant 12
 174 <acc8= constant 1
 175 acc8+ constant 2
 176 /acc8 unstack8
 177 acc8Comp constant 5
 178 brgt 182
 179 acc8= constant 119
 180 call writeAcc8
 181 ;test5.j(29)   if (4 >= 12/(1+2)) write(118);
 182 acc8= constant 12
 183 <acc8= constant 1
 184 acc8+ constant 2
 185 /acc8 unstack8
 186 acc8Comp constant 4
 187 brgt 191
 188 acc8= constant 118
 189 call writeAcc8
 190 ;test5.j(30)   if (4 <= 12/(1+2)) write(117);
 191 acc8= constant 12
 192 <acc8= constant 1
 193 acc8+ constant 2
 194 /acc8 unstack8
 195 acc8Comp constant 4
 196 brlt 200
 197 acc8= constant 117
 198 call writeAcc8
 199 ;test5.j(31)   if (3 <= 12/(1+2)) write(116);
 200 acc8= constant 12
 201 <acc8= constant 1
 202 acc8+ constant 2
 203 /acc8 unstack8
 204 acc8Comp constant 3
 205 brlt 209
 206 acc8= constant 116
 207 call writeAcc8
 208 ;test5.j(32)   if (5 > 12/(1+2)) write(115);
 209 acc8= constant 12
 210 <acc8= constant 1
 211 acc8+ constant 2
 212 /acc8 unstack8
 213 acc8Comp constant 5
 214 brge 218
 215 acc8= constant 115
 216 call writeAcc8
 217 ;test5.j(33)   if (3 < 12/(1+2)) write(114);
 218 acc8= constant 12
 219 <acc8= constant 1
 220 acc8+ constant 2
 221 /acc8 unstack8
 222 acc8Comp constant 3
 223 brle 227
 224 acc8= constant 114
 225 call writeAcc8
 226 ;test5.j(34)   if (3 != 12/(1+2)) write(113);
 227 acc8= constant 12
 228 <acc8= constant 1
 229 acc8+ constant 2
 230 /acc8 unstack8
 231 acc8Comp constant 3
 232 breq 236
 233 acc8= constant 113
 234 call writeAcc8
 235 ;test5.j(35)   if (4 == 12/(1+2)) write(112);
 236 acc8= constant 12
 237 <acc8= constant 1
 238 acc8+ constant 2
 239 /acc8 unstack8
 240 acc8Comp constant 4
 241 brne 245
 242 acc8= constant 112
 243 call writeAcc8
 244 ;test5.j(36)   if (1+4 >= twelve/(one+2)) write(111);
 245 acc8= constant 1
 246 acc8+ constant 4
 247 <acc8
 248 acc16= variable 10
 249 <acc16= variable 2
 250 acc16+ constant 2
 251 /acc16 unstack16
 252 acc8= unstack8
 253 acc8CompareAcc16
 254 brlt 258
 255 acc8= constant 111
 256 call writeAcc8
 257 ;test5.j(37)   if (1+3 >= twelve/(one+2)) write(110);
 258 acc8= constant 1
 259 acc8+ constant 3
 260 <acc8
 261 acc16= variable 10
 262 <acc16= variable 2
 263 acc16+ constant 2
 264 /acc16 unstack16
 265 acc8= unstack8
 266 acc8CompareAcc16
 267 brlt 271
 268 acc8= constant 110
 269 call writeAcc8
 270 ;test5.j(38)   if (1+3 <= twelve/(one+2)) write(109);
 271 acc8= constant 1
 272 acc8+ constant 3
 273 <acc8
 274 acc16= variable 10
 275 <acc16= variable 2
 276 acc16+ constant 2
 277 /acc16 unstack16
 278 acc8= unstack8
 279 acc8CompareAcc16
 280 brgt 284
 281 acc8= constant 109
 282 call writeAcc8
 283 ;test5.j(39)   if (1+2 <= twelve/(one+2)) write(108);
 284 acc8= constant 1
 285 acc8+ constant 2
 286 <acc8
 287 acc16= variable 10
 288 <acc16= variable 2
 289 acc16+ constant 2
 290 /acc16 unstack16
 291 acc8= unstack8
 292 acc8CompareAcc16
 293 brgt 297
 294 acc8= constant 108
 295 call writeAcc8
 296 ;test5.j(40)   if (1+4 > twelve/(one+2)) write(107);
 297 acc8= constant 1
 298 acc8+ constant 4
 299 <acc8
 300 acc16= variable 10
 301 <acc16= variable 2
 302 acc16+ constant 2
 303 /acc16 unstack16
 304 acc8= unstack8
 305 acc8CompareAcc16
 306 brle 310
 307 acc8= constant 107
 308 call writeAcc8
 309 ;test5.j(41)   if (1+2 < twelve/(one+2)) write(106);
 310 acc8= constant 1
 311 acc8+ constant 2
 312 <acc8
 313 acc16= variable 10
 314 <acc16= variable 2
 315 acc16+ constant 2
 316 /acc16 unstack16
 317 acc8= unstack8
 318 acc8CompareAcc16
 319 brge 323
 320 acc8= constant 106
 321 call writeAcc8
 322 ;test5.j(42)   if (1+2 != twelve/(one+2)) write(105);
 323 acc8= constant 1
 324 acc8+ constant 2
 325 <acc8
 326 acc16= variable 10
 327 <acc16= variable 2
 328 acc16+ constant 2
 329 /acc16 unstack16
 330 acc8= unstack8
 331 acc8CompareAcc16
 332 breq 336
 333 acc8= constant 105
 334 call writeAcc8
 335 ;test5.j(43)   if (1+3 == twelve/(one+2)) write(104);
 336 acc8= constant 1
 337 acc8+ constant 3
 338 <acc8
 339 acc16= variable 10
 340 <acc16= variable 2
 341 acc16+ constant 2
 342 /acc16 unstack16
 343 acc8= unstack8
 344 acc8CompareAcc16
 345 brne 349
 346 acc8= constant 104
 347 call writeAcc8
 348 ;test5.j(44)   if (1+4 >= 12/(1+2)) write(103);
 349 acc8= constant 1
 350 acc8+ constant 4
 351 <acc8
 352 acc8= constant 12
 353 <acc8= constant 1
 354 acc8+ constant 2
 355 /acc8 unstack8
 356 revAcc8Comp unstack8
 357 brgt 361
 358 acc8= constant 103
 359 call writeAcc8
 360 ;test5.j(45)   if (1+3 >= 12/(1+2)) write(102);
 361 acc8= constant 1
 362 acc8+ constant 3
 363 <acc8
 364 acc8= constant 12
 365 <acc8= constant 1
 366 acc8+ constant 2
 367 /acc8 unstack8
 368 revAcc8Comp unstack8
 369 brgt 373
 370 acc8= constant 102
 371 call writeAcc8
 372 ;test5.j(46)   if (1+3 <= 12/(1+2)) write(101);
 373 acc8= constant 1
 374 acc8+ constant 3
 375 <acc8
 376 acc8= constant 12
 377 <acc8= constant 1
 378 acc8+ constant 2
 379 /acc8 unstack8
 380 revAcc8Comp unstack8
 381 brlt 385
 382 acc8= constant 101
 383 call writeAcc8
 384 ;test5.j(47)   if (1+2 <= 12/(1+2)) write(100);
 385 acc8= constant 1
 386 acc8+ constant 2
 387 <acc8
 388 acc8= constant 12
 389 <acc8= constant 1
 390 acc8+ constant 2
 391 /acc8 unstack8
 392 revAcc8Comp unstack8
 393 brlt 397
 394 acc8= constant 100
 395 call writeAcc8
 396 ;test5.j(48)   if (1+4 > 12/(1+2)) write(99);
 397 acc8= constant 1
 398 acc8+ constant 4
 399 <acc8
 400 acc8= constant 12
 401 <acc8= constant 1
 402 acc8+ constant 2
 403 /acc8 unstack8
 404 revAcc8Comp unstack8
 405 brge 409
 406 acc8= constant 99
 407 call writeAcc8
 408 ;test5.j(49)   if (1+2 < 12/(1+2)) write(98);
 409 acc8= constant 1
 410 acc8+ constant 2
 411 <acc8
 412 acc8= constant 12
 413 <acc8= constant 1
 414 acc8+ constant 2
 415 /acc8 unstack8
 416 revAcc8Comp unstack8
 417 brle 421
 418 acc8= constant 98
 419 call writeAcc8
 420 ;test5.j(50)   if (1+2 != 12/(1+2)) write(97);
 421 acc8= constant 1
 422 acc8+ constant 2
 423 <acc8
 424 acc8= constant 12
 425 <acc8= constant 1
 426 acc8+ constant 2
 427 /acc8 unstack8
 428 revAcc8Comp unstack8
 429 breq 433
 430 acc8= constant 97
 431 call writeAcc8
 432 ;test5.j(51)   if (1+3 == 12/(1+2)) write(96);
 433 acc8= constant 1
 434 acc8+ constant 3
 435 <acc8
 436 acc8= constant 12
 437 <acc8= constant 1
 438 acc8+ constant 2
 439 /acc8 unstack8
 440 revAcc8Comp unstack8
 441 brne 445
 442 acc8= constant 96
 443 call writeAcc8
 444 ;test5.j(52)   if (twelve >= twelve/(one+2)) write(95);
 445 acc16= variable 10
 446 <acc16= variable 2
 447 acc16+ constant 2
 448 /acc16 unstack16
 449 acc16Comp variable 10
 450 brgt 454
 451 acc8= constant 95
 452 call writeAcc8
 453 ;test5.j(53)   if (four >= twelve/(one+2)) write(94);
 454 acc16= variable 10
 455 <acc16= variable 2
 456 acc16+ constant 2
 457 /acc16 unstack16
 458 acc16Comp variable 6
 459 brgt 463
 460 acc8= constant 94
 461 call writeAcc8
 462 ;test5.j(54)   if (three <= twelve/(one+2)) write(93);
 463 acc16= variable 10
 464 <acc16= variable 2
 465 acc16+ constant 2
 466 /acc16 unstack16
 467 acc16Comp variable 4
 468 brlt 472
 469 acc8= constant 93
 470 call writeAcc8
 471 ;test5.j(55)   if (four <= twelve/(one+2)) write(92);
 472 acc16= variable 10
 473 <acc16= variable 2
 474 acc16+ constant 2
 475 /acc16 unstack16
 476 acc16Comp variable 6
 477 brlt 481
 478 acc8= constant 92
 479 call writeAcc8
 480 ;test5.j(56)   if (twelve > twelve/(one+2)) write(91);
 481 acc16= variable 10
 482 <acc16= variable 2
 483 acc16+ constant 2
 484 /acc16 unstack16
 485 acc16Comp variable 10
 486 brge 490
 487 acc8= constant 91
 488 call writeAcc8
 489 ;test5.j(57)   if (three < twelve/(one+2)) write(90);
 490 acc16= variable 10
 491 <acc16= variable 2
 492 acc16+ constant 2
 493 /acc16 unstack16
 494 acc16Comp variable 4
 495 brle 499
 496 acc8= constant 90
 497 call writeAcc8
 498 ;test5.j(58)   if (three != twelve/(one+2)) write(89);
 499 acc16= variable 10
 500 <acc16= variable 2
 501 acc16+ constant 2
 502 /acc16 unstack16
 503 acc16Comp variable 4
 504 breq 508
 505 acc8= constant 89
 506 call writeAcc8
 507 ;test5.j(59)   if (four == twelve/(one+2)) write(88);
 508 acc16= variable 10
 509 <acc16= variable 2
 510 acc16+ constant 2
 511 /acc16 unstack16
 512 acc16Comp variable 6
 513 brne 517
 514 acc8= constant 88
 515 call writeAcc8
 516 ;test5.j(60)   if (twelve >= 12/(1+2)) write(87);
 517 acc8= constant 12
 518 <acc8= constant 1
 519 acc8+ constant 2
 520 /acc8 unstack8
 521 acc16= variable 10
 522 acc16CompareAcc8
 523 brlt 527
 524 acc8= constant 87
 525 call writeAcc8
 526 ;test5.j(61)   if (four >= 12/(1+2)) write(86);
 527 acc8= constant 12
 528 <acc8= constant 1
 529 acc8+ constant 2
 530 /acc8 unstack8
 531 acc16= variable 6
 532 acc16CompareAcc8
 533 brlt 537
 534 acc8= constant 86
 535 call writeAcc8
 536 ;test5.j(62)   if (three <= 12/(1+2)) write(85);
 537 acc8= constant 12
 538 <acc8= constant 1
 539 acc8+ constant 2
 540 /acc8 unstack8
 541 acc16= variable 4
 542 acc16CompareAcc8
 543 brgt 547
 544 acc8= constant 85
 545 call writeAcc8
 546 ;test5.j(63)   if (four <= 12/(1+2)) write(84);
 547 acc8= constant 12
 548 <acc8= constant 1
 549 acc8+ constant 2
 550 /acc8 unstack8
 551 acc16= variable 6
 552 acc16CompareAcc8
 553 brgt 557
 554 acc8= constant 84
 555 call writeAcc8
 556 ;test5.j(64)   if (twelve > 12/(1+2)) write(83);
 557 acc8= constant 12
 558 <acc8= constant 1
 559 acc8+ constant 2
 560 /acc8 unstack8
 561 acc16= variable 10
 562 acc16CompareAcc8
 563 brle 567
 564 acc8= constant 83
 565 call writeAcc8
 566 ;test5.j(65)   if (three < 12/(1+2)) write(82);
 567 acc8= constant 12
 568 <acc8= constant 1
 569 acc8+ constant 2
 570 /acc8 unstack8
 571 acc16= variable 4
 572 acc16CompareAcc8
 573 brge 577
 574 acc8= constant 82
 575 call writeAcc8
 576 ;test5.j(66)   if (three != 12/(1+2)) write(81);
 577 acc8= constant 12
 578 <acc8= constant 1
 579 acc8+ constant 2
 580 /acc8 unstack8
 581 acc16= variable 4
 582 acc16CompareAcc8
 583 breq 587
 584 acc8= constant 81
 585 call writeAcc8
 586 ;test5.j(67)   if (four == 12/(1+2)) write(80);
 587 acc8= constant 12
 588 <acc8= constant 1
 589 acc8+ constant 2
 590 /acc8 unstack8
 591 acc16= variable 6
 592 acc16CompareAcc8
 593 brne 597
 594 acc8= constant 80
 595 call writeAcc8
 596 ;test5.j(68)   if (one+four >= twelve/(one+2)) write(79);
 597 acc16= variable 2
 598 acc16+ variable 6
 599 <acc16
 600 acc16= variable 10
 601 <acc16= variable 2
 602 acc16+ constant 2
 603 /acc16 unstack16
 604 revAcc16Comp unstack16
 605 brgt 609
 606 acc8= constant 79
 607 call writeAcc8
 608 ;test5.j(69)   if (one+three >= twelve/(one+2)) write(78);
 609 acc16= variable 2
 610 acc16+ variable 4
 611 <acc16
 612 acc16= variable 10
 613 <acc16= variable 2
 614 acc16+ constant 2
 615 /acc16 unstack16
 616 revAcc16Comp unstack16
 617 brgt 621
 618 acc8= constant 78
 619 call writeAcc8
 620 ;test5.j(70)   if (one+three <= twelve/(one+2)) write(77);
 621 acc16= variable 2
 622 acc16+ variable 4
 623 <acc16
 624 acc16= variable 10
 625 <acc16= variable 2
 626 acc16+ constant 2
 627 /acc16 unstack16
 628 revAcc16Comp unstack16
 629 brlt 633
 630 acc8= constant 77
 631 call writeAcc8
 632 ;test5.j(71)   if (one+one <= twelve/(one+2)) write(76);
 633 acc16= variable 2
 634 acc16+ variable 2
 635 <acc16
 636 acc16= variable 10
 637 <acc16= variable 2
 638 acc16+ constant 2
 639 /acc16 unstack16
 640 revAcc16Comp unstack16
 641 brlt 645
 642 acc8= constant 76
 643 call writeAcc8
 644 ;test5.j(72)   if (one+four > twelve/(one+2)) write(75);
 645 acc16= variable 2
 646 acc16+ variable 6
 647 <acc16
 648 acc16= variable 10
 649 <acc16= variable 2
 650 acc16+ constant 2
 651 /acc16 unstack16
 652 revAcc16Comp unstack16
 653 brge 657
 654 acc8= constant 75
 655 call writeAcc8
 656 ;test5.j(73)   if (one+one < twelve/(one+2)) write(74);
 657 acc16= variable 2
 658 acc16+ variable 2
 659 <acc16
 660 acc16= variable 10
 661 <acc16= variable 2
 662 acc16+ constant 2
 663 /acc16 unstack16
 664 revAcc16Comp unstack16
 665 brle 669
 666 acc8= constant 74
 667 call writeAcc8
 668 ;test5.j(74)   if (one+four  != twelve/(one+2)) write(73);
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
 680 ;test5.j(75)   if (one+three == twelve/(one+2)) write(72);
 681 acc16= variable 2
 682 acc16+ variable 4
 683 <acc16
 684 acc16= variable 10
 685 <acc16= variable 2
 686 acc16+ constant 2
 687 /acc16 unstack16
 688 revAcc16Comp unstack16
 689 brne 693
 690 acc8= constant 72
 691 call writeAcc8
 692 ;test5.j(76)   if (one+four >= 12/(1+2)) write(71);
 693 acc16= variable 2
 694 acc16+ variable 6
 695 <acc16
 696 acc8= constant 12
 697 <acc8= constant 1
 698 acc8+ constant 2
 699 /acc8 unstack8
 700 acc16= unstack16
 701 acc16CompareAcc8
 702 brlt 706
 703 acc8= constant 71
 704 call writeAcc8
 705 ;test5.j(77)   if (one+three >= 12/(1+2)) write(70);
 706 acc16= variable 2
 707 acc16+ variable 4
 708 <acc16
 709 acc8= constant 12
 710 <acc8= constant 1
 711 acc8+ constant 2
 712 /acc8 unstack8
 713 acc16= unstack16
 714 acc16CompareAcc8
 715 brlt 719
 716 acc8= constant 70
 717 call writeAcc8
 718 ;test5.j(78)   if (one+three <= 12/(1+2)) write(69);
 719 acc16= variable 2
 720 acc16+ variable 4
 721 <acc16
 722 acc8= constant 12
 723 <acc8= constant 1
 724 acc8+ constant 2
 725 /acc8 unstack8
 726 acc16= unstack16
 727 acc16CompareAcc8
 728 brgt 732
 729 acc8= constant 69
 730 call writeAcc8
 731 ;test5.j(79)   if (one+one <= 12/(1+2)) write(68);
 732 acc16= variable 2
 733 acc16+ variable 2
 734 <acc16
 735 acc8= constant 12
 736 <acc8= constant 1
 737 acc8+ constant 2
 738 /acc8 unstack8
 739 acc16= unstack16
 740 acc16CompareAcc8
 741 brgt 745
 742 acc8= constant 68
 743 call writeAcc8
 744 ;test5.j(80)   if (one+four > 12/(1+2)) write(67);
 745 acc16= variable 2
 746 acc16+ variable 6
 747 <acc16
 748 acc8= constant 12
 749 <acc8= constant 1
 750 acc8+ constant 2
 751 /acc8 unstack8
 752 acc16= unstack16
 753 acc16CompareAcc8
 754 brle 758
 755 acc8= constant 67
 756 call writeAcc8
 757 ;test5.j(81)   if (one+one < 12/(1+2)) write(66);
 758 acc16= variable 2
 759 acc16+ variable 2
 760 <acc16
 761 acc8= constant 12
 762 <acc8= constant 1
 763 acc8+ constant 2
 764 /acc8 unstack8
 765 acc16= unstack16
 766 acc16CompareAcc8
 767 brge 771
 768 acc8= constant 66
 769 call writeAcc8
 770 ;test5.j(82)   if (one+four  != 12/(1+2)) write(65);
 771 acc16= variable 2
 772 acc16+ variable 6
 773 <acc16
 774 acc8= constant 12
 775 <acc8= constant 1
 776 acc8+ constant 2
 777 /acc8 unstack8
 778 acc16= unstack16
 779 acc16CompareAcc8
 780 breq 784
 781 acc8= constant 65
 782 call writeAcc8
 783 ;test5.j(83)   if (one+three == 12/(1+2)) write(64);
 784 acc16= variable 2
 785 acc16+ variable 4
 786 <acc16
 787 acc8= constant 12
 788 <acc8= constant 1
 789 acc8+ constant 2
 790 /acc8 unstack8
 791 acc16= unstack16
 792 acc16CompareAcc8
 793 brne 799
 794 acc8= constant 64
 795 call writeAcc8
 796 ;test5.j(84)   //stack level 1
 797 ;test5.j(85)   //integer-byte
 798 ;test5.j(86)   if (four >= 4) write(63);
 799 acc16= variable 6
 800 acc8= constant 4
 801 acc16CompareAcc8
 802 brlt 806
 803 acc8= constant 63
 804 call writeAcc8
 805 ;test5.j(87)   if (four >= 12/(1+2)) write(62);
 806 acc8= constant 12
 807 <acc8= constant 1
 808 acc8+ constant 2
 809 /acc8 unstack8
 810 acc16= variable 6
 811 acc16CompareAcc8
 812 brlt 816
 813 acc8= constant 62
 814 call writeAcc8
 815 ;test5.j(88)   if (five >= 4) write(61);
 816 acc16= variable 8
 817 acc8= constant 4
 818 acc16CompareAcc8
 819 brlt 823
 820 acc8= constant 61
 821 call writeAcc8
 822 ;test5.j(89)   if (five >= 12/(1+2)) write(60);
 823 acc8= constant 12
 824 <acc8= constant 1
 825 acc8+ constant 2
 826 /acc8 unstack8
 827 acc16= variable 8
 828 acc16CompareAcc8
 829 brlt 833
 830 acc8= constant 60
 831 call writeAcc8
 832 ;test5.j(90)   if (four <= 4) write(59);
 833 acc16= variable 6
 834 acc8= constant 4
 835 acc16CompareAcc8
 836 brgt 840
 837 acc8= constant 59
 838 call writeAcc8
 839 ;test5.j(91)   if (four <= 12/(1+2)) write(58);
 840 acc8= constant 12
 841 <acc8= constant 1
 842 acc8+ constant 2
 843 /acc8 unstack8
 844 acc16= variable 6
 845 acc16CompareAcc8
 846 brgt 850
 847 acc8= constant 58
 848 call writeAcc8
 849 ;test5.j(92)   if (three <= 4) write(57);
 850 acc16= variable 4
 851 acc8= constant 4
 852 acc16CompareAcc8
 853 brgt 857
 854 acc8= constant 57
 855 call writeAcc8
 856 ;test5.j(93)   if (three <= 12/(1+2)) write(56);
 857 acc8= constant 12
 858 <acc8= constant 1
 859 acc8+ constant 2
 860 /acc8 unstack8
 861 acc16= variable 4
 862 acc16CompareAcc8
 863 brgt 867
 864 acc8= constant 56
 865 call writeAcc8
 866 ;test5.j(94)   if (five > 4) write(55);
 867 acc16= variable 8
 868 acc8= constant 4
 869 acc16CompareAcc8
 870 brle 874
 871 acc8= constant 55
 872 call writeAcc8
 873 ;test5.j(95)   if (five > 12/(1+2)) write(54);
 874 acc8= constant 12
 875 <acc8= constant 1
 876 acc8+ constant 2
 877 /acc8 unstack8
 878 acc16= variable 8
 879 acc16CompareAcc8
 880 brle 884
 881 acc8= constant 54
 882 call writeAcc8
 883 ;test5.j(96)   if (three < 4) write(53);
 884 acc16= variable 4
 885 acc8= constant 4
 886 acc16CompareAcc8
 887 brge 891
 888 acc8= constant 53
 889 call writeAcc8
 890 ;test5.j(97)   if (three < 12/(1+2)) write(52);
 891 acc8= constant 12
 892 <acc8= constant 1
 893 acc8+ constant 2
 894 /acc8 unstack8
 895 acc16= variable 4
 896 acc16CompareAcc8
 897 brge 901
 898 acc8= constant 52
 899 call writeAcc8
 900 ;test5.j(98)   if (three != 4) write(51);
 901 acc16= variable 4
 902 acc8= constant 4
 903 acc16CompareAcc8
 904 breq 908
 905 acc8= constant 51
 906 call writeAcc8
 907 ;test5.j(99)   if (three != 12/(1+2)) write(50);
 908 acc8= constant 12
 909 <acc8= constant 1
 910 acc8+ constant 2
 911 /acc8 unstack8
 912 acc16= variable 4
 913 acc16CompareAcc8
 914 breq 918
 915 acc8= constant 50
 916 call writeAcc8
 917 ;test5.j(100)   if (four == 4) write(49);
 918 acc16= variable 6
 919 acc8= constant 4
 920 acc16CompareAcc8
 921 brne 925
 922 acc8= constant 49
 923 call writeAcc8
 924 ;test5.j(101)   if (four == 12/(1+2)) write(48);
 925 acc8= constant 12
 926 <acc8= constant 1
 927 acc8+ constant 2
 928 /acc8 unstack8
 929 acc16= variable 6
 930 acc16CompareAcc8
 931 brne 936
 932 acc8= constant 48
 933 call writeAcc8
 934 ;test5.j(102)   //byte-integer
 935 ;test5.j(103)   if (4 >= four) write(47);
 936 acc16= variable 6
 937 acc8= constant 4
 938 acc8CompareAcc16
 939 brlt 943
 940 acc8= constant 47
 941 call writeAcc8
 942 ;test5.j(104)   if (4 >= twelve/(1+2)) write(46);
 943 acc16= variable 10
 944 acc8= constant 1
 945 acc8+ constant 2
 946 acc16/ acc8
 947 acc8= constant 4
 948 acc8CompareAcc16
 949 brlt 953
 950 acc8= constant 46
 951 call writeAcc8
 952 ;test5.j(105)   if (5 >= four) write(45);
 953 acc16= variable 6
 954 acc8= constant 5
 955 acc8CompareAcc16
 956 brlt 960
 957 acc8= constant 45
 958 call writeAcc8
 959 ;test5.j(106)   if (5 >= twelve/(1+2)) write(44);
 960 acc16= variable 10
 961 acc8= constant 1
 962 acc8+ constant 2
 963 acc16/ acc8
 964 acc8= constant 5
 965 acc8CompareAcc16
 966 brlt 970
 967 acc8= constant 44
 968 call writeAcc8
 969 ;test5.j(107)   if (4 <= four) write(43);
 970 acc16= variable 6
 971 acc8= constant 4
 972 acc8CompareAcc16
 973 brgt 977
 974 acc8= constant 43
 975 call writeAcc8
 976 ;test5.j(108)   if (4 <= twelve/(1+2)) write(42);
 977 acc16= variable 10
 978 acc8= constant 1
 979 acc8+ constant 2
 980 acc16/ acc8
 981 acc8= constant 4
 982 acc8CompareAcc16
 983 brgt 987
 984 acc8= constant 42
 985 call writeAcc8
 986 ;test5.j(109)   if (3 <= four) write(41);
 987 acc16= variable 6
 988 acc8= constant 3
 989 acc8CompareAcc16
 990 brgt 994
 991 acc8= constant 41
 992 call writeAcc8
 993 ;test5.j(110)   if (3 <= twelve/(1+2)) write(40);
 994 acc16= variable 10
 995 acc8= constant 1
 996 acc8+ constant 2
 997 acc16/ acc8
 998 acc8= constant 3
 999 acc8CompareAcc16
1000 brgt 1004
1001 acc8= constant 40
1002 call writeAcc8
1003 ;test5.j(111)   if (5 > four) write(39);
1004 acc16= variable 6
1005 acc8= constant 5
1006 acc8CompareAcc16
1007 brle 1011
1008 acc8= constant 39
1009 call writeAcc8
1010 ;test5.j(112)   if (5 > twelve/(1+2)) write(38);
1011 acc16= variable 10
1012 acc8= constant 1
1013 acc8+ constant 2
1014 acc16/ acc8
1015 acc8= constant 5
1016 acc8CompareAcc16
1017 brle 1021
1018 acc8= constant 38
1019 call writeAcc8
1020 ;test5.j(113)   if (3 < four) write(37);
1021 acc16= variable 6
1022 acc8= constant 3
1023 acc8CompareAcc16
1024 brge 1028
1025 acc8= constant 37
1026 call writeAcc8
1027 ;test5.j(114)   if (3 < twelve/(1+2)) write(36);
1028 acc16= variable 10
1029 acc8= constant 1
1030 acc8+ constant 2
1031 acc16/ acc8
1032 acc8= constant 3
1033 acc8CompareAcc16
1034 brge 1038
1035 acc8= constant 36
1036 call writeAcc8
1037 ;test5.j(115)   if (3 != four) write(35);
1038 acc16= variable 6
1039 acc8= constant 3
1040 acc8CompareAcc16
1041 breq 1045
1042 acc8= constant 35
1043 call writeAcc8
1044 ;test5.j(116)   if (3 != twelve/(1+2)) write(34);
1045 acc16= variable 10
1046 acc8= constant 1
1047 acc8+ constant 2
1048 acc16/ acc8
1049 acc8= constant 3
1050 acc8CompareAcc16
1051 breq 1055
1052 acc8= constant 34
1053 call writeAcc8
1054 ;test5.j(117)   if (4 == four) write(33);
1055 acc16= variable 6
1056 acc8= constant 4
1057 acc8CompareAcc16
1058 brne 1062
1059 acc8= constant 33
1060 call writeAcc8
1061 ;test5.j(118)   if (4 == twelve/(1+2)) write(32);
1062 acc16= variable 10
1063 acc8= constant 1
1064 acc8+ constant 2
1065 acc16/ acc8
1066 acc8= constant 4
1067 acc8CompareAcc16
1068 brne 1073
1069 acc8= constant 32
1070 call writeAcc8
1071 ;test5.j(119)   //integer-integer
1072 ;test5.j(120)   if (400 >= 400) write(31);
1073 acc16= constant 400
1074 acc16Comp constant 400
1075 brlt 1079
1076 acc8= constant 31
1077 call writeAcc8
1078 ;test5.j(121)   if (400 >= 1200/(1+2)) write(30);
1079 acc16= constant 1200
1080 acc8= constant 1
1081 acc8+ constant 2
1082 acc16/ acc8
1083 acc16Comp constant 400
1084 brgt 1088
1085 acc8= constant 30
1086 call writeAcc8
1087 ;test5.j(122)   if (500 >= 400) write(29);
1088 acc16= constant 500
1089 acc16Comp constant 400
1090 brlt 1094
1091 acc8= constant 29
1092 call writeAcc8
1093 ;test5.j(123)   if (500 >= 1200/(1+2)) write(28);
1094 acc16= constant 1200
1095 acc8= constant 1
1096 acc8+ constant 2
1097 acc16/ acc8
1098 acc16Comp constant 500
1099 brgt 1103
1100 acc8= constant 28
1101 call writeAcc8
1102 ;test5.j(124)   if (400 <= 400) write(27);
1103 acc16= constant 400
1104 acc16Comp constant 400
1105 brgt 1109
1106 acc8= constant 27
1107 call writeAcc8
1108 ;test5.j(125)   if (400 <= 1200/(1+2)) write(26);
1109 acc16= constant 1200
1110 acc8= constant 1
1111 acc8+ constant 2
1112 acc16/ acc8
1113 acc16Comp constant 400
1114 brlt 1118
1115 acc8= constant 26
1116 call writeAcc8
1117 ;test5.j(126)   if (300 <= 400) write(25);
1118 acc16= constant 300
1119 acc16Comp constant 400
1120 brgt 1124
1121 acc8= constant 25
1122 call writeAcc8
1123 ;test5.j(127)   if (300 <= 1200/(1+2)) write(24);
1124 acc16= constant 1200
1125 acc8= constant 1
1126 acc8+ constant 2
1127 acc16/ acc8
1128 acc16Comp constant 300
1129 brlt 1133
1130 acc8= constant 24
1131 call writeAcc8
1132 ;test5.j(128)   if (500 > 400) write(23);
1133 acc16= constant 500
1134 acc16Comp constant 400
1135 brle 1139
1136 acc8= constant 23
1137 call writeAcc8
1138 ;test5.j(129)   if (500 > 1200/(1+2)) write(22);
1139 acc16= constant 1200
1140 acc8= constant 1
1141 acc8+ constant 2
1142 acc16/ acc8
1143 acc16Comp constant 500
1144 brge 1148
1145 acc8= constant 22
1146 call writeAcc8
1147 ;test5.j(130)   if (300 < 400) write(21);
1148 acc16= constant 300
1149 acc16Comp constant 400
1150 brge 1154
1151 acc8= constant 21
1152 call writeAcc8
1153 ;test5.j(131)   if (300 < 1200/(1+2)) write(20);
1154 acc16= constant 1200
1155 acc8= constant 1
1156 acc8+ constant 2
1157 acc16/ acc8
1158 acc16Comp constant 300
1159 brle 1163
1160 acc8= constant 20
1161 call writeAcc8
1162 ;test5.j(132)   if (300 != 400) write(19);
1163 acc16= constant 300
1164 acc16Comp constant 400
1165 breq 1169
1166 acc8= constant 19
1167 call writeAcc8
1168 ;test5.j(133)   if (300 != 1200/(1+2)) write(18);
1169 acc16= constant 1200
1170 acc8= constant 1
1171 acc8+ constant 2
1172 acc16/ acc8
1173 acc16Comp constant 300
1174 breq 1178
1175 acc8= constant 18
1176 call writeAcc8
1177 ;test5.j(134)   if (400 == 400) write(17);
1178 acc16= constant 400
1179 acc16Comp constant 400
1180 brne 1184
1181 acc8= constant 17
1182 call writeAcc8
1183 ;test5.j(135)   if (400 == 1200/(1+2)) write(16);
1184 acc16= constant 1200
1185 acc8= constant 1
1186 acc8+ constant 2
1187 acc16/ acc8
1188 acc16Comp constant 400
1189 brne 1194
1190 acc8= constant 16
1191 call writeAcc8
1192 ;test5.j(136)   //byte-byte
1193 ;test5.j(137)   if (4 >= 4) write(15);
1194 acc8= constant 4
1195 acc8Comp constant 4
1196 brlt 1200
1197 acc8= constant 15
1198 call writeAcc8
1199 ;test5.j(138)   if (4 >= 12/(1+2)) write(14);
1200 acc8= constant 12
1201 <acc8= constant 1
1202 acc8+ constant 2
1203 /acc8 unstack8
1204 acc8Comp constant 4
1205 brgt 1209
1206 acc8= constant 14
1207 call writeAcc8
1208 ;test5.j(139)   if (5 >= 4) write(13);
1209 acc8= constant 5
1210 acc8Comp constant 4
1211 brlt 1215
1212 acc8= constant 13
1213 call writeAcc8
1214 ;test5.j(140)   if (5 >= 12/(1+2)) write(12);
1215 acc8= constant 12
1216 <acc8= constant 1
1217 acc8+ constant 2
1218 /acc8 unstack8
1219 acc8Comp constant 5
1220 brgt 1224
1221 acc8= constant 12
1222 call writeAcc8
1223 ;test5.j(141)   if (4 <= 4) write(11);
1224 acc8= constant 4
1225 acc8Comp constant 4
1226 brgt 1230
1227 acc8= constant 11
1228 call writeAcc8
1229 ;test5.j(142)   if (4 <= 12/(1+2)) write(10);
1230 acc8= constant 12
1231 <acc8= constant 1
1232 acc8+ constant 2
1233 /acc8 unstack8
1234 acc8Comp constant 4
1235 brlt 1239
1236 acc8= constant 10
1237 call writeAcc8
1238 ;test5.j(143)   if (3 <= 4) write(9);
1239 acc8= constant 3
1240 acc8Comp constant 4
1241 brgt 1245
1242 acc8= constant 9
1243 call writeAcc8
1244 ;test5.j(144)   if (3 <= 12/(1+2)) write(8);
1245 acc8= constant 12
1246 <acc8= constant 1
1247 acc8+ constant 2
1248 /acc8 unstack8
1249 acc8Comp constant 3
1250 brlt 1254
1251 acc8= constant 8
1252 call writeAcc8
1253 ;test5.j(145)   if (5 > 4) write(7);
1254 acc8= constant 5
1255 acc8Comp constant 4
1256 brle 1260
1257 acc8= constant 7
1258 call writeAcc8
1259 ;test5.j(146)   if (5 > 12/(1+2)) write(6);
1260 acc8= constant 12
1261 <acc8= constant 1
1262 acc8+ constant 2
1263 /acc8 unstack8
1264 acc8Comp constant 5
1265 brge 1269
1266 acc8= constant 6
1267 call writeAcc8
1268 ;test5.j(147)   if (3 < 4) write(5);
1269 acc8= constant 3
1270 acc8Comp constant 4
1271 brge 1275
1272 acc8= constant 5
1273 call writeAcc8
1274 ;test5.j(148)   if (3 < 12/(1+2)) write(4);
1275 acc8= constant 12
1276 <acc8= constant 1
1277 acc8+ constant 2
1278 /acc8 unstack8
1279 acc8Comp constant 3
1280 brle 1284
1281 acc8= constant 4
1282 call writeAcc8
1283 ;test5.j(149)   if (3 != 4) write(3);
1284 acc8= constant 3
1285 acc8Comp constant 4
1286 breq 1290
1287 acc8= constant 3
1288 call writeAcc8
1289 ;test5.j(150)   if (3 != 12/(1+2)) write(2);
1290 acc8= constant 12
1291 <acc8= constant 1
1292 acc8+ constant 2
1293 /acc8 unstack8
1294 acc8Comp constant 3
1295 breq 1299
1296 acc8= constant 2
1297 call writeAcc8
1298 ;test5.j(151)   if (4 == 4) write(1);
1299 acc8= constant 4
1300 acc8Comp constant 4
1301 brne 1305
1302 acc8= constant 1
1303 call writeAcc8
1304 ;test5.j(152)   if (4 == 12/(1+2)) write(0);
1305 acc8= constant 12
1306 <acc8= constant 1
1307 acc8+ constant 2
1308 /acc8 unstack8
1309 acc8Comp constant 4
1310 brne 1314
1311 acc8= constant 0
1312 call writeAcc8
1313 ;test5.j(153) }
1314 stop
