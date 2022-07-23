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
 840 acc8= constant 4
 841 acc16CompareAcc8
 842 brlt 846
 843 acc8= constant 63
 844 call writeAcc8
 845 ;test5.p(87)   if (four >= (12/(1+2))) write(62);
 846 acc16= variable 6
 847 <acc16
 848 acc8= constant 12
 849 <acc8= constant 1
 850 acc8+ constant 2
 851 /acc8 unstack8
 852 acc16= unstack16
 853 acc16CompareAcc8
 854 brlt 858
 855 acc8= constant 62
 856 call writeAcc8
 857 ;test5.p(88)   if (five >= 4) write(61);
 858 acc16= variable 8
 859 acc8= constant 4
 860 acc16CompareAcc8
 861 brlt 865
 862 acc8= constant 61
 863 call writeAcc8
 864 ;test5.p(89)   if (five >= (12/(1+2))) write(60);
 865 acc16= variable 8
 866 <acc16
 867 acc8= constant 12
 868 <acc8= constant 1
 869 acc8+ constant 2
 870 /acc8 unstack8
 871 acc16= unstack16
 872 acc16CompareAcc8
 873 brlt 877
 874 acc8= constant 60
 875 call writeAcc8
 876 ;test5.p(90)   if (four <= 4) write(59);
 877 acc16= variable 6
 878 acc8= constant 4
 879 acc16CompareAcc8
 880 brgt 884
 881 acc8= constant 59
 882 call writeAcc8
 883 ;test5.p(91)   if (four <= (12/(1+2))) write(58);
 884 acc16= variable 6
 885 <acc16
 886 acc8= constant 12
 887 <acc8= constant 1
 888 acc8+ constant 2
 889 /acc8 unstack8
 890 acc16= unstack16
 891 acc16CompareAcc8
 892 brgt 896
 893 acc8= constant 58
 894 call writeAcc8
 895 ;test5.p(92)   if (three <= 4) write(57);
 896 acc16= variable 4
 897 acc8= constant 4
 898 acc16CompareAcc8
 899 brgt 903
 900 acc8= constant 57
 901 call writeAcc8
 902 ;test5.p(93)   if (three <= (12/(1+2))) write(56);
 903 acc16= variable 4
 904 <acc16
 905 acc8= constant 12
 906 <acc8= constant 1
 907 acc8+ constant 2
 908 /acc8 unstack8
 909 acc16= unstack16
 910 acc16CompareAcc8
 911 brgt 915
 912 acc8= constant 56
 913 call writeAcc8
 914 ;test5.p(94)   if (five > 4) write(55);
 915 acc16= variable 8
 916 acc8= constant 4
 917 acc16CompareAcc8
 918 brle 922
 919 acc8= constant 55
 920 call writeAcc8
 921 ;test5.p(95)   if (five > (12/(1+2))) write(54);
 922 acc16= variable 8
 923 <acc16
 924 acc8= constant 12
 925 <acc8= constant 1
 926 acc8+ constant 2
 927 /acc8 unstack8
 928 acc16= unstack16
 929 acc16CompareAcc8
 930 brle 934
 931 acc8= constant 54
 932 call writeAcc8
 933 ;test5.p(96)   if (three < 4) write(53);
 934 acc16= variable 4
 935 acc8= constant 4
 936 acc16CompareAcc8
 937 brge 941
 938 acc8= constant 53
 939 call writeAcc8
 940 ;test5.p(97)   if (three < (12/(1+2))) write(52);
 941 acc16= variable 4
 942 <acc16
 943 acc8= constant 12
 944 <acc8= constant 1
 945 acc8+ constant 2
 946 /acc8 unstack8
 947 acc16= unstack16
 948 acc16CompareAcc8
 949 brge 953
 950 acc8= constant 52
 951 call writeAcc8
 952 ;test5.p(98)   if (three != 4) write(51);
 953 acc16= variable 4
 954 acc8= constant 4
 955 acc16CompareAcc8
 956 breq 960
 957 acc8= constant 51
 958 call writeAcc8
 959 ;test5.p(99)   if (three != (12/(1+2))) write(50);
 960 acc16= variable 4
 961 <acc16
 962 acc8= constant 12
 963 <acc8= constant 1
 964 acc8+ constant 2
 965 /acc8 unstack8
 966 acc16= unstack16
 967 acc16CompareAcc8
 968 breq 972
 969 acc8= constant 50
 970 call writeAcc8
 971 ;test5.p(100)   if (four == 4) write(49);
 972 acc16= variable 6
 973 acc8= constant 4
 974 acc16CompareAcc8
 975 brne 979
 976 acc8= constant 49
 977 call writeAcc8
 978 ;test5.p(101)   if (four == (12/(1+2))) write(48);
 979 acc16= variable 6
 980 <acc16
 981 acc8= constant 12
 982 <acc8= constant 1
 983 acc8+ constant 2
 984 /acc8 unstack8
 985 acc16= unstack16
 986 acc16CompareAcc8
 987 brne 992
 988 acc8= constant 48
 989 call writeAcc8
 990 ;test5.p(102)   //byte-integer
 991 ;test5.p(103)   if (4 >= four) write(47);
 992 acc16= variable 6
 993 acc8= constant 4
 994 acc8CompareAcc16
 995 brlt 999
 996 acc8= constant 47
 997 call writeAcc8
 998 ;test5.p(104)   if (4 >= (twelve/(1+2))) write(46);
 999 acc16= variable 10
1000 acc8= constant 1
1001 acc8+ constant 2
1002 acc16/ acc8
1003 acc8= constant 4
1004 acc8CompareAcc16
1005 brlt 1009
1006 acc8= constant 46
1007 call writeAcc8
1008 ;test5.p(105)   if (5 >= four) write(45);
1009 acc16= variable 6
1010 acc8= constant 5
1011 acc8CompareAcc16
1012 brlt 1016
1013 acc8= constant 45
1014 call writeAcc8
1015 ;test5.p(106)   if (5 >= (twelve/(1+2))) write(44);
1016 acc16= variable 10
1017 acc8= constant 1
1018 acc8+ constant 2
1019 acc16/ acc8
1020 acc8= constant 5
1021 acc8CompareAcc16
1022 brlt 1026
1023 acc8= constant 44
1024 call writeAcc8
1025 ;test5.p(107)   if (4 <= four) write(43);
1026 acc16= variable 6
1027 acc8= constant 4
1028 acc8CompareAcc16
1029 brgt 1033
1030 acc8= constant 43
1031 call writeAcc8
1032 ;test5.p(108)   if (4 <= (twelve/(1+2))) write(42);
1033 acc16= variable 10
1034 acc8= constant 1
1035 acc8+ constant 2
1036 acc16/ acc8
1037 acc8= constant 4
1038 acc8CompareAcc16
1039 brgt 1043
1040 acc8= constant 42
1041 call writeAcc8
1042 ;test5.p(109)   if (3 <= four) write(41);
1043 acc16= variable 6
1044 acc8= constant 3
1045 acc8CompareAcc16
1046 brgt 1050
1047 acc8= constant 41
1048 call writeAcc8
1049 ;test5.p(110)   if (3 <= (twelve/(1+2))) write(40);
1050 acc16= variable 10
1051 acc8= constant 1
1052 acc8+ constant 2
1053 acc16/ acc8
1054 acc8= constant 3
1055 acc8CompareAcc16
1056 brgt 1060
1057 acc8= constant 40
1058 call writeAcc8
1059 ;test5.p(111)   if (5 > four) write(39);
1060 acc16= variable 6
1061 acc8= constant 5
1062 acc8CompareAcc16
1063 brle 1067
1064 acc8= constant 39
1065 call writeAcc8
1066 ;test5.p(112)   if (5 > (twelve/(1+2))) write(38);
1067 acc16= variable 10
1068 acc8= constant 1
1069 acc8+ constant 2
1070 acc16/ acc8
1071 acc8= constant 5
1072 acc8CompareAcc16
1073 brle 1077
1074 acc8= constant 38
1075 call writeAcc8
1076 ;test5.p(113)   if (3 < four) write(37);
1077 acc16= variable 6
1078 acc8= constant 3
1079 acc8CompareAcc16
1080 brge 1084
1081 acc8= constant 37
1082 call writeAcc8
1083 ;test5.p(114)   if (3 < (twelve/(1+2))) write(36);
1084 acc16= variable 10
1085 acc8= constant 1
1086 acc8+ constant 2
1087 acc16/ acc8
1088 acc8= constant 3
1089 acc8CompareAcc16
1090 brge 1094
1091 acc8= constant 36
1092 call writeAcc8
1093 ;test5.p(115)   if (3 != four) write(35);
1094 acc16= variable 6
1095 acc8= constant 3
1096 acc8CompareAcc16
1097 breq 1101
1098 acc8= constant 35
1099 call writeAcc8
1100 ;test5.p(116)   if (3 != (twelve/(1+2))) write(34);
1101 acc16= variable 10
1102 acc8= constant 1
1103 acc8+ constant 2
1104 acc16/ acc8
1105 acc8= constant 3
1106 acc8CompareAcc16
1107 breq 1111
1108 acc8= constant 34
1109 call writeAcc8
1110 ;test5.p(117)   if (4 == four) write(33);
1111 acc16= variable 6
1112 acc8= constant 4
1113 acc8CompareAcc16
1114 brne 1118
1115 acc8= constant 33
1116 call writeAcc8
1117 ;test5.p(118)   if (4 == (twelve/(1+2))) write(32);
1118 acc16= variable 10
1119 acc8= constant 1
1120 acc8+ constant 2
1121 acc16/ acc8
1122 acc8= constant 4
1123 acc8CompareAcc16
1124 brne 1129
1125 acc8= constant 32
1126 call writeAcc8
1127 ;test5.p(119)   //integer-integer
1128 ;test5.p(120)   if (400 >= 400) write(31);
1129 acc16= constant 400
1130 acc16Comp constant 400
1131 brlt 1135
1132 acc8= constant 31
1133 call writeAcc8
1134 ;test5.p(121)   if (400 >= (1200/(1+2))) write(30);
1135 acc16= constant 1200
1136 acc8= constant 1
1137 acc8+ constant 2
1138 acc16/ acc8
1139 acc16Comp constant 400
1140 brgt 1144
1141 acc8= constant 30
1142 call writeAcc8
1143 ;test5.p(122)   if (500 >= 400) write(29);
1144 acc16= constant 500
1145 acc16Comp constant 400
1146 brlt 1150
1147 acc8= constant 29
1148 call writeAcc8
1149 ;test5.p(123)   if (500 >= (1200/(1+2))) write(28);
1150 acc16= constant 1200
1151 acc8= constant 1
1152 acc8+ constant 2
1153 acc16/ acc8
1154 acc16Comp constant 500
1155 brgt 1159
1156 acc8= constant 28
1157 call writeAcc8
1158 ;test5.p(124)   if (400 <= 400) write(27);
1159 acc16= constant 400
1160 acc16Comp constant 400
1161 brgt 1165
1162 acc8= constant 27
1163 call writeAcc8
1164 ;test5.p(125)   if (400 <= (1200/(1+2))) write(26);
1165 acc16= constant 1200
1166 acc8= constant 1
1167 acc8+ constant 2
1168 acc16/ acc8
1169 acc16Comp constant 400
1170 brlt 1174
1171 acc8= constant 26
1172 call writeAcc8
1173 ;test5.p(126)   if (300 <= 400) write(25);
1174 acc16= constant 300
1175 acc16Comp constant 400
1176 brgt 1180
1177 acc8= constant 25
1178 call writeAcc8
1179 ;test5.p(127)   if (300 <= (1200/(1+2))) write(24);
1180 acc16= constant 1200
1181 acc8= constant 1
1182 acc8+ constant 2
1183 acc16/ acc8
1184 acc16Comp constant 300
1185 brlt 1189
1186 acc8= constant 24
1187 call writeAcc8
1188 ;test5.p(128)   if (500 > 400) write(23);
1189 acc16= constant 500
1190 acc16Comp constant 400
1191 brle 1195
1192 acc8= constant 23
1193 call writeAcc8
1194 ;test5.p(129)   if (500 > (1200/(1+2))) write(22);
1195 acc16= constant 1200
1196 acc8= constant 1
1197 acc8+ constant 2
1198 acc16/ acc8
1199 acc16Comp constant 500
1200 brge 1204
1201 acc8= constant 22
1202 call writeAcc8
1203 ;test5.p(130)   if (300 < 400) write(21);
1204 acc16= constant 300
1205 acc16Comp constant 400
1206 brge 1210
1207 acc8= constant 21
1208 call writeAcc8
1209 ;test5.p(131)   if (300 < (1200/(1+2))) write(20);
1210 acc16= constant 1200
1211 acc8= constant 1
1212 acc8+ constant 2
1213 acc16/ acc8
1214 acc16Comp constant 300
1215 brle 1219
1216 acc8= constant 20
1217 call writeAcc8
1218 ;test5.p(132)   if (300 != 400) write(19);
1219 acc16= constant 300
1220 acc16Comp constant 400
1221 breq 1225
1222 acc8= constant 19
1223 call writeAcc8
1224 ;test5.p(133)   if (300 != (1200/(1+2))) write(18);
1225 acc16= constant 1200
1226 acc8= constant 1
1227 acc8+ constant 2
1228 acc16/ acc8
1229 acc16Comp constant 300
1230 breq 1234
1231 acc8= constant 18
1232 call writeAcc8
1233 ;test5.p(134)   if (400 == 400) write(17);
1234 acc16= constant 400
1235 acc16Comp constant 400
1236 brne 1240
1237 acc8= constant 17
1238 call writeAcc8
1239 ;test5.p(135)   if (400 == (1200/(1+2))) write(16);
1240 acc16= constant 1200
1241 acc8= constant 1
1242 acc8+ constant 2
1243 acc16/ acc8
1244 acc16Comp constant 400
1245 brne 1250
1246 acc8= constant 16
1247 call writeAcc8
1248 ;test5.p(136)   //byte-byte
1249 ;test5.p(137)   if (4 >= 4) write(15);
1250 acc8= constant 4
1251 acc8Comp constant 4
1252 brlt 1256
1253 acc8= constant 15
1254 call writeAcc8
1255 ;test5.p(138)   if (4 >= (12/(1+2))) write(14);
1256 acc8= constant 12
1257 <acc8= constant 1
1258 acc8+ constant 2
1259 /acc8 unstack8
1260 acc8Comp constant 4
1261 brgt 1265
1262 acc8= constant 14
1263 call writeAcc8
1264 ;test5.p(139)   if (5 >= 4) write(13);
1265 acc8= constant 5
1266 acc8Comp constant 4
1267 brlt 1271
1268 acc8= constant 13
1269 call writeAcc8
1270 ;test5.p(140)   if (5 >= (12/(1+2))) write(12);
1271 acc8= constant 12
1272 <acc8= constant 1
1273 acc8+ constant 2
1274 /acc8 unstack8
1275 acc8Comp constant 5
1276 brgt 1280
1277 acc8= constant 12
1278 call writeAcc8
1279 ;test5.p(141)   if (4 <= 4) write(11);
1280 acc8= constant 4
1281 acc8Comp constant 4
1282 brgt 1286
1283 acc8= constant 11
1284 call writeAcc8
1285 ;test5.p(142)   if (4 <= (12/(1+2))) write(10);
1286 acc8= constant 12
1287 <acc8= constant 1
1288 acc8+ constant 2
1289 /acc8 unstack8
1290 acc8Comp constant 4
1291 brlt 1295
1292 acc8= constant 10
1293 call writeAcc8
1294 ;test5.p(143)   if (3 <= 4) write(9);
1295 acc8= constant 3
1296 acc8Comp constant 4
1297 brgt 1301
1298 acc8= constant 9
1299 call writeAcc8
1300 ;test5.p(144)   if (3 <= (12/(1+2))) write(8);
1301 acc8= constant 12
1302 <acc8= constant 1
1303 acc8+ constant 2
1304 /acc8 unstack8
1305 acc8Comp constant 3
1306 brlt 1310
1307 acc8= constant 8
1308 call writeAcc8
1309 ;test5.p(145)   if (5 > 4) write(7);
1310 acc8= constant 5
1311 acc8Comp constant 4
1312 brle 1316
1313 acc8= constant 7
1314 call writeAcc8
1315 ;test5.p(146)   if (5 > (12/(1+2))) write(6);
1316 acc8= constant 12
1317 <acc8= constant 1
1318 acc8+ constant 2
1319 /acc8 unstack8
1320 acc8Comp constant 5
1321 brge 1325
1322 acc8= constant 6
1323 call writeAcc8
1324 ;test5.p(147)   if (3 < 4) write(5);
1325 acc8= constant 3
1326 acc8Comp constant 4
1327 brge 1331
1328 acc8= constant 5
1329 call writeAcc8
1330 ;test5.p(148)   if (3 < (12/(1+2))) write(4);
1331 acc8= constant 12
1332 <acc8= constant 1
1333 acc8+ constant 2
1334 /acc8 unstack8
1335 acc8Comp constant 3
1336 brle 1340
1337 acc8= constant 4
1338 call writeAcc8
1339 ;test5.p(149)   if (3 != 4) write(3);
1340 acc8= constant 3
1341 acc8Comp constant 4
1342 breq 1346
1343 acc8= constant 3
1344 call writeAcc8
1345 ;test5.p(150)   if (3 != (12/(1+2))) write(2);
1346 acc8= constant 12
1347 <acc8= constant 1
1348 acc8+ constant 2
1349 /acc8 unstack8
1350 acc8Comp constant 3
1351 breq 1355
1352 acc8= constant 2
1353 call writeAcc8
1354 ;test5.p(151)   if (4 == 4) write(1);
1355 acc8= constant 4
1356 acc8Comp constant 4
1357 brne 1361
1358 acc8= constant 1
1359 call writeAcc8
1360 ;test5.p(152)   if (4 == (12/(1+2))) write(0);
1361 acc8= constant 12
1362 <acc8= constant 1
1363 acc8+ constant 2
1364 /acc8 unstack8
1365 acc8Comp constant 4
1366 brne 1370
1367 acc8= constant 0
1368 call writeAcc8
1369 ;test5.p(153) }
1370 stop
