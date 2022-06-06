   0 ;test5.p(0) /*
   1 ;test5.p(1)  * A small program in the miniJava language.
   2 ;test5.p(2)  * Test comparisons
   3 ;test5.p(3)  */
   4 ;test5.p(4) class TestIf {
   5 ;test5.p(5)   int zero = 0;
   6 acc8= constant 0
   7 acc8=> variable 0
   8 ;test5.p(6)   int one = 1;
   9 acc8= constant 1
  10 acc8=> variable 2
  11 ;test5.p(7)   int three = 3;
  12 acc8= constant 3
  13 acc8=> variable 4
  14 ;test5.p(8)   int four = 4;
  15 acc8= constant 4
  16 acc8=> variable 6
  17 ;test5.p(9)   int five = 5;
  18 acc8= constant 5
  19 acc8=> variable 8
  20 ;test5.p(10)   int twelve = 12;
  21 acc8= constant 12
  22 acc8=> variable 10
  23 ;test5.p(11)   byte byteOne = 1;
  24 acc8= constant 1
  25 acc8=> variable 12
  26 ;test5.p(12)   byte byteSix = 262;
  27 acc16= constant 262
  28 acc16=> variable 13
  29 ;test5.p(13)   write(133);
  30 acc8= constant 133
  31 call writeAcc8
  32 ;test5.p(14)   if (4 == (zero + twelve/(1+2))) write(132);
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
  44 ;test5.p(15)   if (four == (0 + 12/(one + 2))) write(131);
  45 acc16= variable 6
  46 <acc16
  47 acc8= constant 0
  48 <acc8= constant 12
  49 acc16= variable 2
  50 acc16+ constant 2
  51 /acc16 acc8
  52 acc16+ unstack8
  53 revAcc16Comp unstack16
  54 brne 58
  55 acc8= constant 131
  56 call writeAcc8
  57 ;test5.p(16)   if (four == (0 + 12/(byteOne + 2))) write(130);
  58 acc16= variable 6
  59 <acc16
  60 acc8= constant 0
  61 <acc8= constant 12
  62 <acc8= variable 12
  63 acc8+ constant 2
  64 /acc8 unstack8
  65 acc8+ unstack8
  66 acc16= unstack16
  67 acc16CompareAcc8
  68 brne 72
  69 acc8= constant 130
  70 call writeAcc8
  71 ;test5.p(17)   if (four == (0 + 12/(1 + 2))) write(129);
  72 acc16= variable 6
  73 <acc16
  74 acc8= constant 0
  75 <acc8= constant 12
  76 <acc8= constant 1
  77 acc8+ constant 2
  78 /acc8 unstack8
  79 acc8+ unstack8
  80 acc16= unstack16
  81 acc16CompareAcc8
  82 brne 86
  83 acc8= constant 129
  84 call writeAcc8
  85 ;test5.p(18)   if (four == 0 + 12/(1 + 2)) write(128);
  86 acc16= variable 6
  87 <acc16
  88 acc8= constant 0
  89 <acc8= constant 12
  90 <acc8= constant 1
  91 acc8+ constant 2
  92 /acc8 unstack8
  93 acc8+ unstack8
  94 acc16= unstack16
  95 acc16CompareAcc8
  96 brne 101
  97 acc8= constant 128
  98 call writeAcc8
  99 ;test5.p(19)   //stack level 2
 100 ;test5.p(20)   if (5 >= (twelve/(one+2))) write(127);
 101 acc16= variable 10
 102 <acc16= variable 2
 103 acc16+ constant 2
 104 /acc16 unstack16
 105 acc8= constant 5
 106 acc8CompareAcc16
 107 brlt 111
 108 acc8= constant 127
 109 call writeAcc8
 110 ;test5.p(21)   if (4 >= (twelve/(one+2))) write(126);
 111 acc16= variable 10
 112 <acc16= variable 2
 113 acc16+ constant 2
 114 /acc16 unstack16
 115 acc8= constant 4
 116 acc8CompareAcc16
 117 brlt 121
 118 acc8= constant 126
 119 call writeAcc8
 120 ;test5.p(22)   if (4 <= (twelve/(one+2))) write(125);
 121 acc16= variable 10
 122 <acc16= variable 2
 123 acc16+ constant 2
 124 /acc16 unstack16
 125 acc8= constant 4
 126 acc8CompareAcc16
 127 brgt 131
 128 acc8= constant 125
 129 call writeAcc8
 130 ;test5.p(23)   if (3 <= (twelve/(one+2))) write(124);
 131 acc16= variable 10
 132 <acc16= variable 2
 133 acc16+ constant 2
 134 /acc16 unstack16
 135 acc8= constant 3
 136 acc8CompareAcc16
 137 brgt 141
 138 acc8= constant 124
 139 call writeAcc8
 140 ;test5.p(24)   if (5 > (twelve/(one+2))) write(123);
 141 acc16= variable 10
 142 <acc16= variable 2
 143 acc16+ constant 2
 144 /acc16 unstack16
 145 acc8= constant 5
 146 acc8CompareAcc16
 147 brle 151
 148 acc8= constant 123
 149 call writeAcc8
 150 ;test5.p(25)   if (2 < (twelve/(one+2))) write(122);
 151 acc16= variable 10
 152 <acc16= variable 2
 153 acc16+ constant 2
 154 /acc16 unstack16
 155 acc8= constant 2
 156 acc8CompareAcc16
 157 brge 161
 158 acc8= constant 122
 159 call writeAcc8
 160 ;test5.p(26)   if (3 != (twelve/(one+2))) write(121);
 161 acc16= variable 10
 162 <acc16= variable 2
 163 acc16+ constant 2
 164 /acc16 unstack16
 165 acc8= constant 3
 166 acc8CompareAcc16
 167 breq 171
 168 acc8= constant 121
 169 call writeAcc8
 170 ;test5.p(27)   if (4 == (twelve/(one+2))) write(120);
 171 acc16= variable 10
 172 <acc16= variable 2
 173 acc16+ constant 2
 174 /acc16 unstack16
 175 acc8= constant 4
 176 acc8CompareAcc16
 177 brne 181
 178 acc8= constant 120
 179 call writeAcc8
 180 ;test5.p(28)   if (5 >= (12/(1+2))) write(119);
 181 acc8= constant 12
 182 <acc8= constant 1
 183 acc8+ constant 2
 184 /acc8 unstack8
 185 acc8Comp constant 5
 186 brgt 190
 187 acc8= constant 119
 188 call writeAcc8
 189 ;test5.p(29)   if (4 >= (12/(1+2))) write(118);
 190 acc8= constant 12
 191 <acc8= constant 1
 192 acc8+ constant 2
 193 /acc8 unstack8
 194 acc8Comp constant 4
 195 brgt 199
 196 acc8= constant 118
 197 call writeAcc8
 198 ;test5.p(30)   if (4 <= (12/(1+2))) write(117);
 199 acc8= constant 12
 200 <acc8= constant 1
 201 acc8+ constant 2
 202 /acc8 unstack8
 203 acc8Comp constant 4
 204 brlt 208
 205 acc8= constant 117
 206 call writeAcc8
 207 ;test5.p(31)   if (3 <= (12/(1+2))) write(116);
 208 acc8= constant 12
 209 <acc8= constant 1
 210 acc8+ constant 2
 211 /acc8 unstack8
 212 acc8Comp constant 3
 213 brlt 217
 214 acc8= constant 116
 215 call writeAcc8
 216 ;test5.p(32)   if (5 > (12/(1+2))) write(115);
 217 acc8= constant 12
 218 <acc8= constant 1
 219 acc8+ constant 2
 220 /acc8 unstack8
 221 acc8Comp constant 5
 222 brge 226
 223 acc8= constant 115
 224 call writeAcc8
 225 ;test5.p(33)   if (3 < (12/(1+2))) write(114);
 226 acc8= constant 12
 227 <acc8= constant 1
 228 acc8+ constant 2
 229 /acc8 unstack8
 230 acc8Comp constant 3
 231 brle 235
 232 acc8= constant 114
 233 call writeAcc8
 234 ;test5.p(34)   if (3 != (12/(1+2))) write(113);
 235 acc8= constant 12
 236 <acc8= constant 1
 237 acc8+ constant 2
 238 /acc8 unstack8
 239 acc8Comp constant 3
 240 breq 244
 241 acc8= constant 113
 242 call writeAcc8
 243 ;test5.p(35)   if (4 == (12/(1+2))) write(112);
 244 acc8= constant 12
 245 <acc8= constant 1
 246 acc8+ constant 2
 247 /acc8 unstack8
 248 acc8Comp constant 4
 249 brne 253
 250 acc8= constant 112
 251 call writeAcc8
 252 ;test5.p(36)   if (1+4 >= (twelve/(one+2))) write(111);
 253 acc8= constant 1
 254 acc8+ constant 4
 255 <acc8
 256 acc16= variable 10
 257 <acc16= variable 2
 258 acc16+ constant 2
 259 /acc16 unstack16
 260 acc8= unstack8
 261 acc8CompareAcc16
 262 brlt 266
 263 acc8= constant 111
 264 call writeAcc8
 265 ;test5.p(37)   if (1+3 >= (twelve/(one+2))) write(110);
 266 acc8= constant 1
 267 acc8+ constant 3
 268 <acc8
 269 acc16= variable 10
 270 <acc16= variable 2
 271 acc16+ constant 2
 272 /acc16 unstack16
 273 acc8= unstack8
 274 acc8CompareAcc16
 275 brlt 279
 276 acc8= constant 110
 277 call writeAcc8
 278 ;test5.p(38)   if (1+3 <= (twelve/(one+2))) write(109);
 279 acc8= constant 1
 280 acc8+ constant 3
 281 <acc8
 282 acc16= variable 10
 283 <acc16= variable 2
 284 acc16+ constant 2
 285 /acc16 unstack16
 286 acc8= unstack8
 287 acc8CompareAcc16
 288 brgt 292
 289 acc8= constant 109
 290 call writeAcc8
 291 ;test5.p(39)   if (1+2 <= (twelve/(one+2))) write(108);
 292 acc8= constant 1
 293 acc8+ constant 2
 294 <acc8
 295 acc16= variable 10
 296 <acc16= variable 2
 297 acc16+ constant 2
 298 /acc16 unstack16
 299 acc8= unstack8
 300 acc8CompareAcc16
 301 brgt 305
 302 acc8= constant 108
 303 call writeAcc8
 304 ;test5.p(40)   if (1+4 > (twelve/(one+2))) write(107);
 305 acc8= constant 1
 306 acc8+ constant 4
 307 <acc8
 308 acc16= variable 10
 309 <acc16= variable 2
 310 acc16+ constant 2
 311 /acc16 unstack16
 312 acc8= unstack8
 313 acc8CompareAcc16
 314 brle 318
 315 acc8= constant 107
 316 call writeAcc8
 317 ;test5.p(41)   if (1+2 < (twelve/(one+2))) write(106);
 318 acc8= constant 1
 319 acc8+ constant 2
 320 <acc8
 321 acc16= variable 10
 322 <acc16= variable 2
 323 acc16+ constant 2
 324 /acc16 unstack16
 325 acc8= unstack8
 326 acc8CompareAcc16
 327 brge 331
 328 acc8= constant 106
 329 call writeAcc8
 330 ;test5.p(42)   if (1+2 != (twelve/(one+2))) write(105);
 331 acc8= constant 1
 332 acc8+ constant 2
 333 <acc8
 334 acc16= variable 10
 335 <acc16= variable 2
 336 acc16+ constant 2
 337 /acc16 unstack16
 338 acc8= unstack8
 339 acc8CompareAcc16
 340 breq 344
 341 acc8= constant 105
 342 call writeAcc8
 343 ;test5.p(43)   if (1+3 == (twelve/(one+2))) write(104);
 344 acc8= constant 1
 345 acc8+ constant 3
 346 <acc8
 347 acc16= variable 10
 348 <acc16= variable 2
 349 acc16+ constant 2
 350 /acc16 unstack16
 351 acc8= unstack8
 352 acc8CompareAcc16
 353 brne 357
 354 acc8= constant 104
 355 call writeAcc8
 356 ;test5.p(44)   if (1+4 >= (12/(1+2))) write(103);
 357 acc8= constant 1
 358 acc8+ constant 4
 359 <acc8
 360 acc8= constant 12
 361 <acc8= constant 1
 362 acc8+ constant 2
 363 /acc8 unstack8
 364 revAcc8Comp unstack8
 365 brgt 369
 366 acc8= constant 103
 367 call writeAcc8
 368 ;test5.p(45)   if (1+3 >= (12/(1+2))) write(102);
 369 acc8= constant 1
 370 acc8+ constant 3
 371 <acc8
 372 acc8= constant 12
 373 <acc8= constant 1
 374 acc8+ constant 2
 375 /acc8 unstack8
 376 revAcc8Comp unstack8
 377 brgt 381
 378 acc8= constant 102
 379 call writeAcc8
 380 ;test5.p(46)   if (1+3 <= (12/(1+2))) write(101);
 381 acc8= constant 1
 382 acc8+ constant 3
 383 <acc8
 384 acc8= constant 12
 385 <acc8= constant 1
 386 acc8+ constant 2
 387 /acc8 unstack8
 388 revAcc8Comp unstack8
 389 brlt 393
 390 acc8= constant 101
 391 call writeAcc8
 392 ;test5.p(47)   if (1+2 <= (12/(1+2))) write(100);
 393 acc8= constant 1
 394 acc8+ constant 2
 395 <acc8
 396 acc8= constant 12
 397 <acc8= constant 1
 398 acc8+ constant 2
 399 /acc8 unstack8
 400 revAcc8Comp unstack8
 401 brlt 405
 402 acc8= constant 100
 403 call writeAcc8
 404 ;test5.p(48)   if (1+4 > (12/(1+2))) write(99);
 405 acc8= constant 1
 406 acc8+ constant 4
 407 <acc8
 408 acc8= constant 12
 409 <acc8= constant 1
 410 acc8+ constant 2
 411 /acc8 unstack8
 412 revAcc8Comp unstack8
 413 brge 417
 414 acc8= constant 99
 415 call writeAcc8
 416 ;test5.p(49)   if (1+2 < (12/(1+2))) write(98);
 417 acc8= constant 1
 418 acc8+ constant 2
 419 <acc8
 420 acc8= constant 12
 421 <acc8= constant 1
 422 acc8+ constant 2
 423 /acc8 unstack8
 424 revAcc8Comp unstack8
 425 brle 429
 426 acc8= constant 98
 427 call writeAcc8
 428 ;test5.p(50)   if (1+2 != (12/(1+2))) write(97);
 429 acc8= constant 1
 430 acc8+ constant 2
 431 <acc8
 432 acc8= constant 12
 433 <acc8= constant 1
 434 acc8+ constant 2
 435 /acc8 unstack8
 436 revAcc8Comp unstack8
 437 breq 441
 438 acc8= constant 97
 439 call writeAcc8
 440 ;test5.p(51)   if (1+3 == (12/(1+2))) write(96);
 441 acc8= constant 1
 442 acc8+ constant 3
 443 <acc8
 444 acc8= constant 12
 445 <acc8= constant 1
 446 acc8+ constant 2
 447 /acc8 unstack8
 448 revAcc8Comp unstack8
 449 brne 453
 450 acc8= constant 96
 451 call writeAcc8
 452 ;test5.p(52)   if (twelve >= (twelve/(one+2))) write(95);
 453 acc16= variable 10
 454 <acc16
 455 acc16= variable 10
 456 <acc16= variable 2
 457 acc16+ constant 2
 458 /acc16 unstack16
 459 revAcc16Comp unstack16
 460 brgt 464
 461 acc8= constant 95
 462 call writeAcc8
 463 ;test5.p(53)   if (four >= (twelve/(one+2))) write(94);
 464 acc16= variable 6
 465 <acc16
 466 acc16= variable 10
 467 <acc16= variable 2
 468 acc16+ constant 2
 469 /acc16 unstack16
 470 revAcc16Comp unstack16
 471 brgt 475
 472 acc8= constant 94
 473 call writeAcc8
 474 ;test5.p(54)   if (three <= (twelve/(one+2))) write(93);
 475 acc16= variable 4
 476 <acc16
 477 acc16= variable 10
 478 <acc16= variable 2
 479 acc16+ constant 2
 480 /acc16 unstack16
 481 revAcc16Comp unstack16
 482 brlt 486
 483 acc8= constant 93
 484 call writeAcc8
 485 ;test5.p(55)   if (four <= (twelve/(one+2))) write(92);
 486 acc16= variable 6
 487 <acc16
 488 acc16= variable 10
 489 <acc16= variable 2
 490 acc16+ constant 2
 491 /acc16 unstack16
 492 revAcc16Comp unstack16
 493 brlt 497
 494 acc8= constant 92
 495 call writeAcc8
 496 ;test5.p(56)   if (twelve > (twelve/(one+2))) write(91);
 497 acc16= variable 10
 498 <acc16
 499 acc16= variable 10
 500 <acc16= variable 2
 501 acc16+ constant 2
 502 /acc16 unstack16
 503 revAcc16Comp unstack16
 504 brge 508
 505 acc8= constant 91
 506 call writeAcc8
 507 ;test5.p(57)   if (three < (twelve/(one+2))) write(90);
 508 acc16= variable 4
 509 <acc16
 510 acc16= variable 10
 511 <acc16= variable 2
 512 acc16+ constant 2
 513 /acc16 unstack16
 514 revAcc16Comp unstack16
 515 brle 519
 516 acc8= constant 90
 517 call writeAcc8
 518 ;test5.p(58)   if (three != (twelve/(one+2))) write(89);
 519 acc16= variable 4
 520 <acc16
 521 acc16= variable 10
 522 <acc16= variable 2
 523 acc16+ constant 2
 524 /acc16 unstack16
 525 revAcc16Comp unstack16
 526 breq 530
 527 acc8= constant 89
 528 call writeAcc8
 529 ;test5.p(59)   if (four == (twelve/(one+2))) write(88);
 530 acc16= variable 6
 531 <acc16
 532 acc16= variable 10
 533 <acc16= variable 2
 534 acc16+ constant 2
 535 /acc16 unstack16
 536 revAcc16Comp unstack16
 537 brne 541
 538 acc8= constant 88
 539 call writeAcc8
 540 ;test5.p(60)   if (twelve >= (12/(1+2))) write(87);
 541 acc16= variable 10
 542 <acc16
 543 acc8= constant 12
 544 <acc8= constant 1
 545 acc8+ constant 2
 546 /acc8 unstack8
 547 acc16= unstack16
 548 acc16CompareAcc8
 549 brlt 553
 550 acc8= constant 87
 551 call writeAcc8
 552 ;test5.p(61)   if (four >= (12/(1+2))) write(86);
 553 acc16= variable 6
 554 <acc16
 555 acc8= constant 12
 556 <acc8= constant 1
 557 acc8+ constant 2
 558 /acc8 unstack8
 559 acc16= unstack16
 560 acc16CompareAcc8
 561 brlt 565
 562 acc8= constant 86
 563 call writeAcc8
 564 ;test5.p(62)   if (three <= (12/(1+2))) write(85);
 565 acc16= variable 4
 566 <acc16
 567 acc8= constant 12
 568 <acc8= constant 1
 569 acc8+ constant 2
 570 /acc8 unstack8
 571 acc16= unstack16
 572 acc16CompareAcc8
 573 brgt 577
 574 acc8= constant 85
 575 call writeAcc8
 576 ;test5.p(63)   if (four <= (12/(1+2))) write(84);
 577 acc16= variable 6
 578 <acc16
 579 acc8= constant 12
 580 <acc8= constant 1
 581 acc8+ constant 2
 582 /acc8 unstack8
 583 acc16= unstack16
 584 acc16CompareAcc8
 585 brgt 589
 586 acc8= constant 84
 587 call writeAcc8
 588 ;test5.p(64)   if (twelve > (12/(1+2))) write(83);
 589 acc16= variable 10
 590 <acc16
 591 acc8= constant 12
 592 <acc8= constant 1
 593 acc8+ constant 2
 594 /acc8 unstack8
 595 acc16= unstack16
 596 acc16CompareAcc8
 597 brle 601
 598 acc8= constant 83
 599 call writeAcc8
 600 ;test5.p(65)   if (three < (12/(1+2))) write(82);
 601 acc16= variable 4
 602 <acc16
 603 acc8= constant 12
 604 <acc8= constant 1
 605 acc8+ constant 2
 606 /acc8 unstack8
 607 acc16= unstack16
 608 acc16CompareAcc8
 609 brge 613
 610 acc8= constant 82
 611 call writeAcc8
 612 ;test5.p(66)   if (three != (12/(1+2))) write(81);
 613 acc16= variable 4
 614 <acc16
 615 acc8= constant 12
 616 <acc8= constant 1
 617 acc8+ constant 2
 618 /acc8 unstack8
 619 acc16= unstack16
 620 acc16CompareAcc8
 621 breq 625
 622 acc8= constant 81
 623 call writeAcc8
 624 ;test5.p(67)   if (four == (12/(1+2))) write(80);
 625 acc16= variable 6
 626 <acc16
 627 acc8= constant 12
 628 <acc8= constant 1
 629 acc8+ constant 2
 630 /acc8 unstack8
 631 acc16= unstack16
 632 acc16CompareAcc8
 633 brne 637
 634 acc8= constant 80
 635 call writeAcc8
 636 ;test5.p(68)   if (one+four >= (twelve/(one+2))) write(79);
 637 acc16= variable 2
 638 acc16+ variable 6
 639 <acc16
 640 acc16= variable 10
 641 <acc16= variable 2
 642 acc16+ constant 2
 643 /acc16 unstack16
 644 revAcc16Comp unstack16
 645 brgt 649
 646 acc8= constant 79
 647 call writeAcc8
 648 ;test5.p(69)   if (one+three >= (twelve/(one+2))) write(78);
 649 acc16= variable 2
 650 acc16+ variable 4
 651 <acc16
 652 acc16= variable 10
 653 <acc16= variable 2
 654 acc16+ constant 2
 655 /acc16 unstack16
 656 revAcc16Comp unstack16
 657 brgt 661
 658 acc8= constant 78
 659 call writeAcc8
 660 ;test5.p(70)   if (one+three <= (twelve/(one+2))) write(77);
 661 acc16= variable 2
 662 acc16+ variable 4
 663 <acc16
 664 acc16= variable 10
 665 <acc16= variable 2
 666 acc16+ constant 2
 667 /acc16 unstack16
 668 revAcc16Comp unstack16
 669 brlt 673
 670 acc8= constant 77
 671 call writeAcc8
 672 ;test5.p(71)   if (one+one <= (twelve/(one+2))) write(76);
 673 acc16= variable 2
 674 acc16+ variable 2
 675 <acc16
 676 acc16= variable 10
 677 <acc16= variable 2
 678 acc16+ constant 2
 679 /acc16 unstack16
 680 revAcc16Comp unstack16
 681 brlt 685
 682 acc8= constant 76
 683 call writeAcc8
 684 ;test5.p(72)   if (one+four > (twelve/(one+2))) write(75);
 685 acc16= variable 2
 686 acc16+ variable 6
 687 <acc16
 688 acc16= variable 10
 689 <acc16= variable 2
 690 acc16+ constant 2
 691 /acc16 unstack16
 692 revAcc16Comp unstack16
 693 brge 697
 694 acc8= constant 75
 695 call writeAcc8
 696 ;test5.p(73)   if (one+one < (twelve/(one+2))) write(74);
 697 acc16= variable 2
 698 acc16+ variable 2
 699 <acc16
 700 acc16= variable 10
 701 <acc16= variable 2
 702 acc16+ constant 2
 703 /acc16 unstack16
 704 revAcc16Comp unstack16
 705 brle 709
 706 acc8= constant 74
 707 call writeAcc8
 708 ;test5.p(74)   if (one+four  != (twelve/(one+2))) write(73);
 709 acc16= variable 2
 710 acc16+ variable 6
 711 <acc16
 712 acc16= variable 10
 713 <acc16= variable 2
 714 acc16+ constant 2
 715 /acc16 unstack16
 716 revAcc16Comp unstack16
 717 breq 721
 718 acc8= constant 73
 719 call writeAcc8
 720 ;test5.p(75)   if (one+three == (twelve/(one+2))) write(72);
 721 acc16= variable 2
 722 acc16+ variable 4
 723 <acc16
 724 acc16= variable 10
 725 <acc16= variable 2
 726 acc16+ constant 2
 727 /acc16 unstack16
 728 revAcc16Comp unstack16
 729 brne 733
 730 acc8= constant 72
 731 call writeAcc8
 732 ;test5.p(76)   if (one+four >= (12/(1+2))) write(71);
 733 acc16= variable 2
 734 acc16+ variable 6
 735 <acc16
 736 acc8= constant 12
 737 <acc8= constant 1
 738 acc8+ constant 2
 739 /acc8 unstack8
 740 acc16= unstack16
 741 acc16CompareAcc8
 742 brlt 746
 743 acc8= constant 71
 744 call writeAcc8
 745 ;test5.p(77)   if (one+three >= (12/(1+2))) write(70);
 746 acc16= variable 2
 747 acc16+ variable 4
 748 <acc16
 749 acc8= constant 12
 750 <acc8= constant 1
 751 acc8+ constant 2
 752 /acc8 unstack8
 753 acc16= unstack16
 754 acc16CompareAcc8
 755 brlt 759
 756 acc8= constant 70
 757 call writeAcc8
 758 ;test5.p(78)   if (one+three <= (12/(1+2))) write(69);
 759 acc16= variable 2
 760 acc16+ variable 4
 761 <acc16
 762 acc8= constant 12
 763 <acc8= constant 1
 764 acc8+ constant 2
 765 /acc8 unstack8
 766 acc16= unstack16
 767 acc16CompareAcc8
 768 brgt 772
 769 acc8= constant 69
 770 call writeAcc8
 771 ;test5.p(79)   if (one+one <= (12/(1+2))) write(68);
 772 acc16= variable 2
 773 acc16+ variable 2
 774 <acc16
 775 acc8= constant 12
 776 <acc8= constant 1
 777 acc8+ constant 2
 778 /acc8 unstack8
 779 acc16= unstack16
 780 acc16CompareAcc8
 781 brgt 785
 782 acc8= constant 68
 783 call writeAcc8
 784 ;test5.p(80)   if (one+four > (12/(1+2))) write(67);
 785 acc16= variable 2
 786 acc16+ variable 6
 787 <acc16
 788 acc8= constant 12
 789 <acc8= constant 1
 790 acc8+ constant 2
 791 /acc8 unstack8
 792 acc16= unstack16
 793 acc16CompareAcc8
 794 brle 798
 795 acc8= constant 67
 796 call writeAcc8
 797 ;test5.p(81)   if (one+one < (12/(1+2))) write(66);
 798 acc16= variable 2
 799 acc16+ variable 2
 800 <acc16
 801 acc8= constant 12
 802 <acc8= constant 1
 803 acc8+ constant 2
 804 /acc8 unstack8
 805 acc16= unstack16
 806 acc16CompareAcc8
 807 brge 811
 808 acc8= constant 66
 809 call writeAcc8
 810 ;test5.p(82)   if (one+four  != (12/(1+2))) write(65);
 811 acc16= variable 2
 812 acc16+ variable 6
 813 <acc16
 814 acc8= constant 12
 815 <acc8= constant 1
 816 acc8+ constant 2
 817 /acc8 unstack8
 818 acc16= unstack16
 819 acc16CompareAcc8
 820 breq 824
 821 acc8= constant 65
 822 call writeAcc8
 823 ;test5.p(83)   if (one+three == (12/(1+2))) write(64);
 824 acc16= variable 2
 825 acc16+ variable 4
 826 <acc16
 827 acc8= constant 12
 828 <acc8= constant 1
 829 acc8+ constant 2
 830 /acc8 unstack8
 831 acc16= unstack16
 832 acc16CompareAcc8
 833 brne 839
 834 acc8= constant 64
 835 call writeAcc8
 836 ;test5.p(84)   //stack level 1
 837 ;test5.p(85)   //integer-byte
 838 ;test5.p(86)   if (four >= 4) write(63);
 839 acc16= variable 6
 840 <acc16
 841 acc16= unstack16
 842 acc8= constant 4
 843 acc16CompareAcc8
 844 brlt 848
 845 acc8= constant 63
 846 call writeAcc8
 847 ;test5.p(87)   if (four >= (12/(1+2))) write(62);
 848 acc16= variable 6
 849 <acc16
 850 acc8= constant 12
 851 <acc8= constant 1
 852 acc8+ constant 2
 853 /acc8 unstack8
 854 acc16= unstack16
 855 acc16CompareAcc8
 856 brlt 860
 857 acc8= constant 62
 858 call writeAcc8
 859 ;test5.p(88)   if (five >= 4) write(61);
 860 acc16= variable 8
 861 <acc16
 862 acc16= unstack16
 863 acc8= constant 4
 864 acc16CompareAcc8
 865 brlt 869
 866 acc8= constant 61
 867 call writeAcc8
 868 ;test5.p(89)   if (five >= (12/(1+2))) write(60);
 869 acc16= variable 8
 870 <acc16
 871 acc8= constant 12
 872 <acc8= constant 1
 873 acc8+ constant 2
 874 /acc8 unstack8
 875 acc16= unstack16
 876 acc16CompareAcc8
 877 brlt 881
 878 acc8= constant 60
 879 call writeAcc8
 880 ;test5.p(90)   if (four <= 4) write(59);
 881 acc16= variable 6
 882 <acc16
 883 acc16= unstack16
 884 acc8= constant 4
 885 acc16CompareAcc8
 886 brgt 890
 887 acc8= constant 59
 888 call writeAcc8
 889 ;test5.p(91)   if (four <= (12/(1+2))) write(58);
 890 acc16= variable 6
 891 <acc16
 892 acc8= constant 12
 893 <acc8= constant 1
 894 acc8+ constant 2
 895 /acc8 unstack8
 896 acc16= unstack16
 897 acc16CompareAcc8
 898 brgt 902
 899 acc8= constant 58
 900 call writeAcc8
 901 ;test5.p(92)   if (three <= 4) write(57);
 902 acc16= variable 4
 903 <acc16
 904 acc16= unstack16
 905 acc8= constant 4
 906 acc16CompareAcc8
 907 brgt 911
 908 acc8= constant 57
 909 call writeAcc8
 910 ;test5.p(93)   if (three <= (12/(1+2))) write(56);
 911 acc16= variable 4
 912 <acc16
 913 acc8= constant 12
 914 <acc8= constant 1
 915 acc8+ constant 2
 916 /acc8 unstack8
 917 acc16= unstack16
 918 acc16CompareAcc8
 919 brgt 923
 920 acc8= constant 56
 921 call writeAcc8
 922 ;test5.p(94)   if (five > 4) write(55);
 923 acc16= variable 8
 924 <acc16
 925 acc16= unstack16
 926 acc8= constant 4
 927 acc16CompareAcc8
 928 brle 932
 929 acc8= constant 55
 930 call writeAcc8
 931 ;test5.p(95)   if (five > (12/(1+2))) write(54);
 932 acc16= variable 8
 933 <acc16
 934 acc8= constant 12
 935 <acc8= constant 1
 936 acc8+ constant 2
 937 /acc8 unstack8
 938 acc16= unstack16
 939 acc16CompareAcc8
 940 brle 944
 941 acc8= constant 54
 942 call writeAcc8
 943 ;test5.p(96)   if (three < 4) write(53);
 944 acc16= variable 4
 945 <acc16
 946 acc16= unstack16
 947 acc8= constant 4
 948 acc16CompareAcc8
 949 brge 953
 950 acc8= constant 53
 951 call writeAcc8
 952 ;test5.p(97)   if (three < (12/(1+2))) write(52);
 953 acc16= variable 4
 954 <acc16
 955 acc8= constant 12
 956 <acc8= constant 1
 957 acc8+ constant 2
 958 /acc8 unstack8
 959 acc16= unstack16
 960 acc16CompareAcc8
 961 brge 965
 962 acc8= constant 52
 963 call writeAcc8
 964 ;test5.p(98)   if (three != 4) write(51);
 965 acc16= variable 4
 966 <acc16
 967 acc16= unstack16
 968 acc8= constant 4
 969 acc16CompareAcc8
 970 breq 974
 971 acc8= constant 51
 972 call writeAcc8
 973 ;test5.p(99)   if (three != (12/(1+2))) write(50);
 974 acc16= variable 4
 975 <acc16
 976 acc8= constant 12
 977 <acc8= constant 1
 978 acc8+ constant 2
 979 /acc8 unstack8
 980 acc16= unstack16
 981 acc16CompareAcc8
 982 breq 986
 983 acc8= constant 50
 984 call writeAcc8
 985 ;test5.p(100)   if (four == 4) write(49);
 986 acc16= variable 6
 987 <acc16
 988 acc16= unstack16
 989 acc8= constant 4
 990 acc16CompareAcc8
 991 brne 995
 992 acc8= constant 49
 993 call writeAcc8
 994 ;test5.p(101)   if (four == (12/(1+2))) write(48);
 995 acc16= variable 6
 996 <acc16
 997 acc8= constant 12
 998 <acc8= constant 1
 999 acc8+ constant 2
1000 /acc8 unstack8
1001 acc16= unstack16
1002 acc16CompareAcc8
1003 brne 1008
1004 acc8= constant 48
1005 call writeAcc8
1006 ;test5.p(102)   //byte-integer
1007 ;test5.p(103)   if (4 >= four) write(47);
1008 acc16= variable 6
1009 acc8= constant 4
1010 acc8CompareAcc16
1011 brlt 1015
1012 acc8= constant 47
1013 call writeAcc8
1014 ;test5.p(104)   if (4 >= (twelve/(1+2))) write(46);
1015 acc16= variable 10
1016 acc8= constant 1
1017 acc8+ constant 2
1018 acc16/ acc8
1019 acc8= constant 4
1020 acc8CompareAcc16
1021 brlt 1025
1022 acc8= constant 46
1023 call writeAcc8
1024 ;test5.p(105)   if (5 >= four) write(45);
1025 acc16= variable 6
1026 acc8= constant 5
1027 acc8CompareAcc16
1028 brlt 1032
1029 acc8= constant 45
1030 call writeAcc8
1031 ;test5.p(106)   if (5 >= (twelve/(1+2))) write(44);
1032 acc16= variable 10
1033 acc8= constant 1
1034 acc8+ constant 2
1035 acc16/ acc8
1036 acc8= constant 5
1037 acc8CompareAcc16
1038 brlt 1042
1039 acc8= constant 44
1040 call writeAcc8
1041 ;test5.p(107)   if (4 <= four) write(43);
1042 acc16= variable 6
1043 acc8= constant 4
1044 acc8CompareAcc16
1045 brgt 1049
1046 acc8= constant 43
1047 call writeAcc8
1048 ;test5.p(108)   if (4 <= (twelve/(1+2))) write(42);
1049 acc16= variable 10
1050 acc8= constant 1
1051 acc8+ constant 2
1052 acc16/ acc8
1053 acc8= constant 4
1054 acc8CompareAcc16
1055 brgt 1059
1056 acc8= constant 42
1057 call writeAcc8
1058 ;test5.p(109)   if (3 <= four) write(41);
1059 acc16= variable 6
1060 acc8= constant 3
1061 acc8CompareAcc16
1062 brgt 1066
1063 acc8= constant 41
1064 call writeAcc8
1065 ;test5.p(110)   if (3 <= (twelve/(1+2))) write(40);
1066 acc16= variable 10
1067 acc8= constant 1
1068 acc8+ constant 2
1069 acc16/ acc8
1070 acc8= constant 3
1071 acc8CompareAcc16
1072 brgt 1076
1073 acc8= constant 40
1074 call writeAcc8
1075 ;test5.p(111)   if (5 > four) write(39);
1076 acc16= variable 6
1077 acc8= constant 5
1078 acc8CompareAcc16
1079 brle 1083
1080 acc8= constant 39
1081 call writeAcc8
1082 ;test5.p(112)   if (5 > (twelve/(1+2))) write(38);
1083 acc16= variable 10
1084 acc8= constant 1
1085 acc8+ constant 2
1086 acc16/ acc8
1087 acc8= constant 5
1088 acc8CompareAcc16
1089 brle 1093
1090 acc8= constant 38
1091 call writeAcc8
1092 ;test5.p(113)   if (3 < four) write(37);
1093 acc16= variable 6
1094 acc8= constant 3
1095 acc8CompareAcc16
1096 brge 1100
1097 acc8= constant 37
1098 call writeAcc8
1099 ;test5.p(114)   if (3 < (twelve/(1+2))) write(36);
1100 acc16= variable 10
1101 acc8= constant 1
1102 acc8+ constant 2
1103 acc16/ acc8
1104 acc8= constant 3
1105 acc8CompareAcc16
1106 brge 1110
1107 acc8= constant 36
1108 call writeAcc8
1109 ;test5.p(115)   if (3 != four) write(35);
1110 acc16= variable 6
1111 acc8= constant 3
1112 acc8CompareAcc16
1113 breq 1117
1114 acc8= constant 35
1115 call writeAcc8
1116 ;test5.p(116)   if (3 != (twelve/(1+2))) write(34);
1117 acc16= variable 10
1118 acc8= constant 1
1119 acc8+ constant 2
1120 acc16/ acc8
1121 acc8= constant 3
1122 acc8CompareAcc16
1123 breq 1127
1124 acc8= constant 34
1125 call writeAcc8
1126 ;test5.p(117)   if (4 == four) write(33);
1127 acc16= variable 6
1128 acc8= constant 4
1129 acc8CompareAcc16
1130 brne 1134
1131 acc8= constant 33
1132 call writeAcc8
1133 ;test5.p(118)   if (4 == (twelve/(1+2))) write(32);
1134 acc16= variable 10
1135 acc8= constant 1
1136 acc8+ constant 2
1137 acc16/ acc8
1138 acc8= constant 4
1139 acc8CompareAcc16
1140 brne 1145
1141 acc8= constant 32
1142 call writeAcc8
1143 ;test5.p(119)   //integer-integer
1144 ;test5.p(120)   if (400 >= 400) write(31);
1145 acc16= constant 400
1146 acc16Comp constant 400
1147 brlt 1151
1148 acc8= constant 31
1149 call writeAcc8
1150 ;test5.p(121)   if (400 >= (1200/(1+2))) write(30);
1151 acc16= constant 1200
1152 acc8= constant 1
1153 acc8+ constant 2
1154 acc16/ acc8
1155 acc16Comp constant 400
1156 brgt 1160
1157 acc8= constant 30
1158 call writeAcc8
1159 ;test5.p(122)   if (500 >= 400) write(29);
1160 acc16= constant 500
1161 acc16Comp constant 400
1162 brlt 1166
1163 acc8= constant 29
1164 call writeAcc8
1165 ;test5.p(123)   if (500 >= (1200/(1+2))) write(28);
1166 acc16= constant 1200
1167 acc8= constant 1
1168 acc8+ constant 2
1169 acc16/ acc8
1170 acc16Comp constant 500
1171 brgt 1175
1172 acc8= constant 28
1173 call writeAcc8
1174 ;test5.p(124)   if (400 <= 400) write(27);
1175 acc16= constant 400
1176 acc16Comp constant 400
1177 brgt 1181
1178 acc8= constant 27
1179 call writeAcc8
1180 ;test5.p(125)   if (400 <= (1200/(1+2))) write(26);
1181 acc16= constant 1200
1182 acc8= constant 1
1183 acc8+ constant 2
1184 acc16/ acc8
1185 acc16Comp constant 400
1186 brlt 1190
1187 acc8= constant 26
1188 call writeAcc8
1189 ;test5.p(126)   if (300 <= 400) write(25);
1190 acc16= constant 300
1191 acc16Comp constant 400
1192 brgt 1196
1193 acc8= constant 25
1194 call writeAcc8
1195 ;test5.p(127)   if (300 <= (1200/(1+2))) write(24);
1196 acc16= constant 1200
1197 acc8= constant 1
1198 acc8+ constant 2
1199 acc16/ acc8
1200 acc16Comp constant 300
1201 brlt 1205
1202 acc8= constant 24
1203 call writeAcc8
1204 ;test5.p(128)   if (500 > 400) write(23);
1205 acc16= constant 500
1206 acc16Comp constant 400
1207 brle 1211
1208 acc8= constant 23
1209 call writeAcc8
1210 ;test5.p(129)   if (500 > (1200/(1+2))) write(22);
1211 acc16= constant 1200
1212 acc8= constant 1
1213 acc8+ constant 2
1214 acc16/ acc8
1215 acc16Comp constant 500
1216 brge 1220
1217 acc8= constant 22
1218 call writeAcc8
1219 ;test5.p(130)   if (300 < 400) write(21);
1220 acc16= constant 300
1221 acc16Comp constant 400
1222 brge 1226
1223 acc8= constant 21
1224 call writeAcc8
1225 ;test5.p(131)   if (300 < (1200/(1+2))) write(20);
1226 acc16= constant 1200
1227 acc8= constant 1
1228 acc8+ constant 2
1229 acc16/ acc8
1230 acc16Comp constant 300
1231 brle 1235
1232 acc8= constant 20
1233 call writeAcc8
1234 ;test5.p(132)   if (300 != 400) write(19);
1235 acc16= constant 300
1236 acc16Comp constant 400
1237 breq 1241
1238 acc8= constant 19
1239 call writeAcc8
1240 ;test5.p(133)   if (300 != (1200/(1+2))) write(18);
1241 acc16= constant 1200
1242 acc8= constant 1
1243 acc8+ constant 2
1244 acc16/ acc8
1245 acc16Comp constant 300
1246 breq 1250
1247 acc8= constant 18
1248 call writeAcc8
1249 ;test5.p(134)   if (400 == 400) write(17);
1250 acc16= constant 400
1251 acc16Comp constant 400
1252 brne 1256
1253 acc8= constant 17
1254 call writeAcc8
1255 ;test5.p(135)   if (400 == (1200/(1+2))) write(16);
1256 acc16= constant 1200
1257 acc8= constant 1
1258 acc8+ constant 2
1259 acc16/ acc8
1260 acc16Comp constant 400
1261 brne 1266
1262 acc8= constant 16
1263 call writeAcc8
1264 ;test5.p(136)   //byte-byte
1265 ;test5.p(137)   if (4 >= 4) write(15);
1266 acc8= constant 4
1267 acc8Comp constant 4
1268 brlt 1272
1269 acc8= constant 15
1270 call writeAcc8
1271 ;test5.p(138)   if (4 >= (12/(1+2))) write(14);
1272 acc8= constant 12
1273 <acc8= constant 1
1274 acc8+ constant 2
1275 /acc8 unstack8
1276 acc8Comp constant 4
1277 brgt 1281
1278 acc8= constant 14
1279 call writeAcc8
1280 ;test5.p(139)   if (5 >= 4) write(13);
1281 acc8= constant 5
1282 acc8Comp constant 4
1283 brlt 1287
1284 acc8= constant 13
1285 call writeAcc8
1286 ;test5.p(140)   if (5 >= (12/(1+2))) write(12);
1287 acc8= constant 12
1288 <acc8= constant 1
1289 acc8+ constant 2
1290 /acc8 unstack8
1291 acc8Comp constant 5
1292 brgt 1296
1293 acc8= constant 12
1294 call writeAcc8
1295 ;test5.p(141)   if (4 <= 4) write(11);
1296 acc8= constant 4
1297 acc8Comp constant 4
1298 brgt 1302
1299 acc8= constant 11
1300 call writeAcc8
1301 ;test5.p(142)   if (4 <= (12/(1+2))) write(10);
1302 acc8= constant 12
1303 <acc8= constant 1
1304 acc8+ constant 2
1305 /acc8 unstack8
1306 acc8Comp constant 4
1307 brlt 1311
1308 acc8= constant 10
1309 call writeAcc8
1310 ;test5.p(143)   if (3 <= 4) write(9);
1311 acc8= constant 3
1312 acc8Comp constant 4
1313 brgt 1317
1314 acc8= constant 9
1315 call writeAcc8
1316 ;test5.p(144)   if (3 <= (12/(1+2))) write(8);
1317 acc8= constant 12
1318 <acc8= constant 1
1319 acc8+ constant 2
1320 /acc8 unstack8
1321 acc8Comp constant 3
1322 brlt 1326
1323 acc8= constant 8
1324 call writeAcc8
1325 ;test5.p(145)   if (5 > 4) write(7);
1326 acc8= constant 5
1327 acc8Comp constant 4
1328 brle 1332
1329 acc8= constant 7
1330 call writeAcc8
1331 ;test5.p(146)   if (5 > (12/(1+2))) write(6);
1332 acc8= constant 12
1333 <acc8= constant 1
1334 acc8+ constant 2
1335 /acc8 unstack8
1336 acc8Comp constant 5
1337 brge 1341
1338 acc8= constant 6
1339 call writeAcc8
1340 ;test5.p(147)   if (3 < 4) write(5);
1341 acc8= constant 3
1342 acc8Comp constant 4
1343 brge 1347
1344 acc8= constant 5
1345 call writeAcc8
1346 ;test5.p(148)   if (3 < (12/(1+2))) write(4);
1347 acc8= constant 12
1348 <acc8= constant 1
1349 acc8+ constant 2
1350 /acc8 unstack8
1351 acc8Comp constant 3
1352 brle 1356
1353 acc8= constant 4
1354 call writeAcc8
1355 ;test5.p(149)   if (3 != 4) write(3);
1356 acc8= constant 3
1357 acc8Comp constant 4
1358 breq 1362
1359 acc8= constant 3
1360 call writeAcc8
1361 ;test5.p(150)   if (3 != (12/(1+2))) write(2);
1362 acc8= constant 12
1363 <acc8= constant 1
1364 acc8+ constant 2
1365 /acc8 unstack8
1366 acc8Comp constant 3
1367 breq 1371
1368 acc8= constant 2
1369 call writeAcc8
1370 ;test5.p(151)   if (4 == 4) write(1);
1371 acc8= constant 4
1372 acc8Comp constant 4
1373 brne 1377
1374 acc8= constant 1
1375 call writeAcc8
1376 ;test5.p(152)   if (4 == (12/(1+2))) write(0);
1377 acc8= constant 12
1378 <acc8= constant 1
1379 acc8+ constant 2
1380 /acc8 unstack8
1381 acc8Comp constant 4
1382 brne 1386
1383 acc8= constant 0
1384 call writeAcc8
1385 ;test5.p(153) }
1386 stop
