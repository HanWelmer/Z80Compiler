   0 ;test5.p(0) /*
   1 ;test5.p(1)  * A small program in the miniJava language.
   2 ;test5.p(2)  * Test comparisons
   3 ;test5.p(3)  */
   4 ;test5.p(4) class TestIf {
   5 ;test5.p(5)   int one = 1;
   6 acc8= constant 1
   7 acc8ToAcc16
   8 acc16=> variable 0
   9 ;test5.p(6)   int three = 3;
  10 acc8= constant 3
  11 acc8ToAcc16
  12 acc16=> variable 2
  13 ;test5.p(7)   int four = 4;
  14 acc8= constant 4
  15 acc8ToAcc16
  16 acc16=> variable 4
  17 ;test5.p(8)   int five = 5;
  18 acc8= constant 5
  19 acc8ToAcc16
  20 acc16=> variable 6
  21 ;test5.p(9)   int twelve = 12;
  22 acc8= constant 12
  23 acc8ToAcc16
  24 acc16=> variable 8
  25 ;test5.p(10)   write(128);
  26 acc8= constant 128
  27 call writeAcc8
  28 ;test5.p(11)   //stack level 2
  29 ;test5.p(12)   if (5 >= (twelve/(one+2))) write(127);
  30 acc16= variable 8
  31 <acc16= variable 0
  32 acc16+ constant 2
  33 /acc16 unstack16
  34 acc8= constant 5
  35 acc8CompareAcc16
  36 brlt 40
  37 acc8= constant 127
  38 call writeAcc8
  39 ;test5.p(13)   if (4 >= (twelve/(one+2))) write(126);
  40 acc16= variable 8
  41 <acc16= variable 0
  42 acc16+ constant 2
  43 /acc16 unstack16
  44 acc8= constant 4
  45 acc8CompareAcc16
  46 brlt 50
  47 acc8= constant 126
  48 call writeAcc8
  49 ;test5.p(14)   if (4 <= (twelve/(one+2))) write(125);
  50 acc16= variable 8
  51 <acc16= variable 0
  52 acc16+ constant 2
  53 /acc16 unstack16
  54 acc8= constant 4
  55 acc8CompareAcc16
  56 brgt 60
  57 acc8= constant 125
  58 call writeAcc8
  59 ;test5.p(15)   if (3 <= (twelve/(one+2))) write(124);
  60 acc16= variable 8
  61 <acc16= variable 0
  62 acc16+ constant 2
  63 /acc16 unstack16
  64 acc8= constant 3
  65 acc8CompareAcc16
  66 brgt 70
  67 acc8= constant 124
  68 call writeAcc8
  69 ;test5.p(16)   if (5 > (twelve/(one+2))) write(123);
  70 acc16= variable 8
  71 <acc16= variable 0
  72 acc16+ constant 2
  73 /acc16 unstack16
  74 acc8= constant 5
  75 acc8CompareAcc16
  76 brle 80
  77 acc8= constant 123
  78 call writeAcc8
  79 ;test5.p(17)   if (2 < (twelve/(one+2))) write(122);
  80 acc16= variable 8
  81 <acc16= variable 0
  82 acc16+ constant 2
  83 /acc16 unstack16
  84 acc8= constant 2
  85 acc8CompareAcc16
  86 brge 90
  87 acc8= constant 122
  88 call writeAcc8
  89 ;test5.p(18)   if (3 != (twelve/(one+2))) write(121);
  90 acc16= variable 8
  91 <acc16= variable 0
  92 acc16+ constant 2
  93 /acc16 unstack16
  94 acc8= constant 3
  95 acc8CompareAcc16
  96 breq 100
  97 acc8= constant 121
  98 call writeAcc8
  99 ;test5.p(19)   if (4 == (twelve/(one+2))) write(120);
 100 acc16= variable 8
 101 <acc16= variable 0
 102 acc16+ constant 2
 103 /acc16 unstack16
 104 acc8= constant 4
 105 acc8CompareAcc16
 106 brne 110
 107 acc8= constant 120
 108 call writeAcc8
 109 ;test5.p(20)   if (5 >= (12/(1+2))) write(119);
 110 acc8= constant 12
 111 <acc8= constant 1
 112 acc8+ constant 2
 113 /acc8 unstack8
 114 acc8Comp constant 5
 115 brgt 119
 116 acc8= constant 119
 117 call writeAcc8
 118 ;test5.p(21)   if (4 >= (12/(1+2))) write(118);
 119 acc8= constant 12
 120 <acc8= constant 1
 121 acc8+ constant 2
 122 /acc8 unstack8
 123 acc8Comp constant 4
 124 brgt 128
 125 acc8= constant 118
 126 call writeAcc8
 127 ;test5.p(22)   if (4 <= (12/(1+2))) write(117);
 128 acc8= constant 12
 129 <acc8= constant 1
 130 acc8+ constant 2
 131 /acc8 unstack8
 132 acc8Comp constant 4
 133 brlt 137
 134 acc8= constant 117
 135 call writeAcc8
 136 ;test5.p(23)   if (3 <= (12/(1+2))) write(116);
 137 acc8= constant 12
 138 <acc8= constant 1
 139 acc8+ constant 2
 140 /acc8 unstack8
 141 acc8Comp constant 3
 142 brlt 146
 143 acc8= constant 116
 144 call writeAcc8
 145 ;test5.p(24)   if (5 > (12/(1+2))) write(115);
 146 acc8= constant 12
 147 <acc8= constant 1
 148 acc8+ constant 2
 149 /acc8 unstack8
 150 acc8Comp constant 5
 151 brge 155
 152 acc8= constant 115
 153 call writeAcc8
 154 ;test5.p(25)   if (3 < (12/(1+2))) write(114);
 155 acc8= constant 12
 156 <acc8= constant 1
 157 acc8+ constant 2
 158 /acc8 unstack8
 159 acc8Comp constant 3
 160 brle 164
 161 acc8= constant 114
 162 call writeAcc8
 163 ;test5.p(26)   if (3 != (12/(1+2))) write(113);
 164 acc8= constant 12
 165 <acc8= constant 1
 166 acc8+ constant 2
 167 /acc8 unstack8
 168 acc8Comp constant 3
 169 breq 173
 170 acc8= constant 113
 171 call writeAcc8
 172 ;test5.p(27)   if (4 == (12/(1+2))) write(112);
 173 acc8= constant 12
 174 <acc8= constant 1
 175 acc8+ constant 2
 176 /acc8 unstack8
 177 acc8Comp constant 4
 178 brne 182
 179 acc8= constant 112
 180 call writeAcc8
 181 ;test5.p(28)   if (1+4 >= (twelve/(one+2))) write(111);
 182 acc8= constant 1
 183 acc8+ constant 4
 184 <acc8
 185 acc16= variable 8
 186 <acc16= variable 0
 187 acc16+ constant 2
 188 /acc16 unstack16
 189 acc8= unstack8
 190 acc8CompareAcc16
 191 brlt 195
 192 acc8= constant 111
 193 call writeAcc8
 194 ;test5.p(29)   if (1+3 >= (twelve/(one+2))) write(110);
 195 acc8= constant 1
 196 acc8+ constant 3
 197 <acc8
 198 acc16= variable 8
 199 <acc16= variable 0
 200 acc16+ constant 2
 201 /acc16 unstack16
 202 acc8= unstack8
 203 acc8CompareAcc16
 204 brlt 208
 205 acc8= constant 110
 206 call writeAcc8
 207 ;test5.p(30)   if (1+3 <= (twelve/(one+2))) write(109);
 208 acc8= constant 1
 209 acc8+ constant 3
 210 <acc8
 211 acc16= variable 8
 212 <acc16= variable 0
 213 acc16+ constant 2
 214 /acc16 unstack16
 215 acc8= unstack8
 216 acc8CompareAcc16
 217 brgt 221
 218 acc8= constant 109
 219 call writeAcc8
 220 ;test5.p(31)   if (1+2 <= (twelve/(one+2))) write(108);
 221 acc8= constant 1
 222 acc8+ constant 2
 223 <acc8
 224 acc16= variable 8
 225 <acc16= variable 0
 226 acc16+ constant 2
 227 /acc16 unstack16
 228 acc8= unstack8
 229 acc8CompareAcc16
 230 brgt 234
 231 acc8= constant 108
 232 call writeAcc8
 233 ;test5.p(32)   if (1+4 > (twelve/(one+2))) write(107);
 234 acc8= constant 1
 235 acc8+ constant 4
 236 <acc8
 237 acc16= variable 8
 238 <acc16= variable 0
 239 acc16+ constant 2
 240 /acc16 unstack16
 241 acc8= unstack8
 242 acc8CompareAcc16
 243 brle 247
 244 acc8= constant 107
 245 call writeAcc8
 246 ;test5.p(33)   if (1+2 < (twelve/(one+2))) write(106);
 247 acc8= constant 1
 248 acc8+ constant 2
 249 <acc8
 250 acc16= variable 8
 251 <acc16= variable 0
 252 acc16+ constant 2
 253 /acc16 unstack16
 254 acc8= unstack8
 255 acc8CompareAcc16
 256 brge 260
 257 acc8= constant 106
 258 call writeAcc8
 259 ;test5.p(34)   if (1+2 != (twelve/(one+2))) write(105);
 260 acc8= constant 1
 261 acc8+ constant 2
 262 <acc8
 263 acc16= variable 8
 264 <acc16= variable 0
 265 acc16+ constant 2
 266 /acc16 unstack16
 267 acc8= unstack8
 268 acc8CompareAcc16
 269 breq 273
 270 acc8= constant 105
 271 call writeAcc8
 272 ;test5.p(35)   if (1+3 == (twelve/(one+2))) write(104);
 273 acc8= constant 1
 274 acc8+ constant 3
 275 <acc8
 276 acc16= variable 8
 277 <acc16= variable 0
 278 acc16+ constant 2
 279 /acc16 unstack16
 280 acc8= unstack8
 281 acc8CompareAcc16
 282 brne 286
 283 acc8= constant 104
 284 call writeAcc8
 285 ;test5.p(36)   if (1+4 >= (12/(1+2))) write(103);
 286 acc8= constant 1
 287 acc8+ constant 4
 288 <acc8
 289 acc8= constant 12
 290 <acc8= constant 1
 291 acc8+ constant 2
 292 /acc8 unstack8
 293 revAcc8Comp unstack8
 294 brgt 298
 295 acc8= constant 103
 296 call writeAcc8
 297 ;test5.p(37)   if (1+3 >= (12/(1+2))) write(102);
 298 acc8= constant 1
 299 acc8+ constant 3
 300 <acc8
 301 acc8= constant 12
 302 <acc8= constant 1
 303 acc8+ constant 2
 304 /acc8 unstack8
 305 revAcc8Comp unstack8
 306 brgt 310
 307 acc8= constant 102
 308 call writeAcc8
 309 ;test5.p(38)   if (1+3 <= (12/(1+2))) write(101);
 310 acc8= constant 1
 311 acc8+ constant 3
 312 <acc8
 313 acc8= constant 12
 314 <acc8= constant 1
 315 acc8+ constant 2
 316 /acc8 unstack8
 317 revAcc8Comp unstack8
 318 brlt 322
 319 acc8= constant 101
 320 call writeAcc8
 321 ;test5.p(39)   if (1+2 <= (12/(1+2))) write(100);
 322 acc8= constant 1
 323 acc8+ constant 2
 324 <acc8
 325 acc8= constant 12
 326 <acc8= constant 1
 327 acc8+ constant 2
 328 /acc8 unstack8
 329 revAcc8Comp unstack8
 330 brlt 334
 331 acc8= constant 100
 332 call writeAcc8
 333 ;test5.p(40)   if (1+4 > (12/(1+2))) write(99);
 334 acc8= constant 1
 335 acc8+ constant 4
 336 <acc8
 337 acc8= constant 12
 338 <acc8= constant 1
 339 acc8+ constant 2
 340 /acc8 unstack8
 341 revAcc8Comp unstack8
 342 brge 346
 343 acc8= constant 99
 344 call writeAcc8
 345 ;test5.p(41)   if (1+2 < (12/(1+2))) write(98);
 346 acc8= constant 1
 347 acc8+ constant 2
 348 <acc8
 349 acc8= constant 12
 350 <acc8= constant 1
 351 acc8+ constant 2
 352 /acc8 unstack8
 353 revAcc8Comp unstack8
 354 brle 358
 355 acc8= constant 98
 356 call writeAcc8
 357 ;test5.p(42)   if (1+2 != (12/(1+2))) write(97);
 358 acc8= constant 1
 359 acc8+ constant 2
 360 <acc8
 361 acc8= constant 12
 362 <acc8= constant 1
 363 acc8+ constant 2
 364 /acc8 unstack8
 365 revAcc8Comp unstack8
 366 breq 370
 367 acc8= constant 97
 368 call writeAcc8
 369 ;test5.p(43)   if (1+3 == (12/(1+2))) write(96);
 370 acc8= constant 1
 371 acc8+ constant 3
 372 <acc8
 373 acc8= constant 12
 374 <acc8= constant 1
 375 acc8+ constant 2
 376 /acc8 unstack8
 377 revAcc8Comp unstack8
 378 brne 382
 379 acc8= constant 96
 380 call writeAcc8
 381 ;test5.p(44)   if (twelve >= (twelve/(one+2))) write(95);
 382 acc16= variable 8
 383 <acc16
 384 acc16= variable 8
 385 <acc16= variable 0
 386 acc16+ constant 2
 387 /acc16 unstack16
 388 revAcc16Comp unstack16
 389 brgt 393
 390 acc8= constant 95
 391 call writeAcc8
 392 ;test5.p(45)   if (four >= (twelve/(one+2))) write(94);
 393 acc16= variable 4
 394 <acc16
 395 acc16= variable 8
 396 <acc16= variable 0
 397 acc16+ constant 2
 398 /acc16 unstack16
 399 revAcc16Comp unstack16
 400 brgt 404
 401 acc8= constant 94
 402 call writeAcc8
 403 ;test5.p(46)   if (three <= (twelve/(one+2))) write(93);
 404 acc16= variable 2
 405 <acc16
 406 acc16= variable 8
 407 <acc16= variable 0
 408 acc16+ constant 2
 409 /acc16 unstack16
 410 revAcc16Comp unstack16
 411 brlt 415
 412 acc8= constant 93
 413 call writeAcc8
 414 ;test5.p(47)   if (four <= (twelve/(one+2))) write(92);
 415 acc16= variable 4
 416 <acc16
 417 acc16= variable 8
 418 <acc16= variable 0
 419 acc16+ constant 2
 420 /acc16 unstack16
 421 revAcc16Comp unstack16
 422 brlt 426
 423 acc8= constant 92
 424 call writeAcc8
 425 ;test5.p(48)   if (twelve > (twelve/(one+2))) write(91);
 426 acc16= variable 8
 427 <acc16
 428 acc16= variable 8
 429 <acc16= variable 0
 430 acc16+ constant 2
 431 /acc16 unstack16
 432 revAcc16Comp unstack16
 433 brge 437
 434 acc8= constant 91
 435 call writeAcc8
 436 ;test5.p(49)   if (three < (twelve/(one+2))) write(90);
 437 acc16= variable 2
 438 <acc16
 439 acc16= variable 8
 440 <acc16= variable 0
 441 acc16+ constant 2
 442 /acc16 unstack16
 443 revAcc16Comp unstack16
 444 brle 448
 445 acc8= constant 90
 446 call writeAcc8
 447 ;test5.p(50)   if (three != (twelve/(one+2))) write(89);
 448 acc16= variable 2
 449 <acc16
 450 acc16= variable 8
 451 <acc16= variable 0
 452 acc16+ constant 2
 453 /acc16 unstack16
 454 revAcc16Comp unstack16
 455 breq 459
 456 acc8= constant 89
 457 call writeAcc8
 458 ;test5.p(51)   if (four == (twelve/(one+2))) write(88);
 459 acc16= variable 4
 460 <acc16
 461 acc16= variable 8
 462 <acc16= variable 0
 463 acc16+ constant 2
 464 /acc16 unstack16
 465 revAcc16Comp unstack16
 466 brne 470
 467 acc8= constant 88
 468 call writeAcc8
 469 ;test5.p(52)   if (twelve >= (12/(1+2))) write(87);
 470 acc16= variable 8
 471 <acc16
 472 acc8= constant 12
 473 <acc8= constant 1
 474 acc8+ constant 2
 475 /acc8 unstack8
 476 acc16= unstack16
 477 acc16CompareAcc8
 478 brlt 482
 479 acc8= constant 87
 480 call writeAcc8
 481 ;test5.p(53)   if (four >= (12/(1+2))) write(86);
 482 acc16= variable 4
 483 <acc16
 484 acc8= constant 12
 485 <acc8= constant 1
 486 acc8+ constant 2
 487 /acc8 unstack8
 488 acc16= unstack16
 489 acc16CompareAcc8
 490 brlt 494
 491 acc8= constant 86
 492 call writeAcc8
 493 ;test5.p(54)   if (three <= (12/(1+2))) write(85);
 494 acc16= variable 2
 495 <acc16
 496 acc8= constant 12
 497 <acc8= constant 1
 498 acc8+ constant 2
 499 /acc8 unstack8
 500 acc16= unstack16
 501 acc16CompareAcc8
 502 brgt 506
 503 acc8= constant 85
 504 call writeAcc8
 505 ;test5.p(55)   if (four <= (12/(1+2))) write(84);
 506 acc16= variable 4
 507 <acc16
 508 acc8= constant 12
 509 <acc8= constant 1
 510 acc8+ constant 2
 511 /acc8 unstack8
 512 acc16= unstack16
 513 acc16CompareAcc8
 514 brgt 518
 515 acc8= constant 84
 516 call writeAcc8
 517 ;test5.p(56)   if (twelve > (12/(1+2))) write(83);
 518 acc16= variable 8
 519 <acc16
 520 acc8= constant 12
 521 <acc8= constant 1
 522 acc8+ constant 2
 523 /acc8 unstack8
 524 acc16= unstack16
 525 acc16CompareAcc8
 526 brle 530
 527 acc8= constant 83
 528 call writeAcc8
 529 ;test5.p(57)   if (three < (12/(1+2))) write(82);
 530 acc16= variable 2
 531 <acc16
 532 acc8= constant 12
 533 <acc8= constant 1
 534 acc8+ constant 2
 535 /acc8 unstack8
 536 acc16= unstack16
 537 acc16CompareAcc8
 538 brge 542
 539 acc8= constant 82
 540 call writeAcc8
 541 ;test5.p(58)   if (three != (12/(1+2))) write(81);
 542 acc16= variable 2
 543 <acc16
 544 acc8= constant 12
 545 <acc8= constant 1
 546 acc8+ constant 2
 547 /acc8 unstack8
 548 acc16= unstack16
 549 acc16CompareAcc8
 550 breq 554
 551 acc8= constant 81
 552 call writeAcc8
 553 ;test5.p(59)   if (four == (12/(1+2))) write(80);
 554 acc16= variable 4
 555 <acc16
 556 acc8= constant 12
 557 <acc8= constant 1
 558 acc8+ constant 2
 559 /acc8 unstack8
 560 acc16= unstack16
 561 acc16CompareAcc8
 562 brne 566
 563 acc8= constant 80
 564 call writeAcc8
 565 ;test5.p(60)   if (one+four >= (twelve/(one+2))) write(79);
 566 acc16= variable 0
 567 acc16+ variable 4
 568 <acc16
 569 acc16= variable 8
 570 <acc16= variable 0
 571 acc16+ constant 2
 572 /acc16 unstack16
 573 revAcc16Comp unstack16
 574 brgt 578
 575 acc8= constant 79
 576 call writeAcc8
 577 ;test5.p(61)   if (one+three >= (twelve/(one+2))) write(78);
 578 acc16= variable 0
 579 acc16+ variable 2
 580 <acc16
 581 acc16= variable 8
 582 <acc16= variable 0
 583 acc16+ constant 2
 584 /acc16 unstack16
 585 revAcc16Comp unstack16
 586 brgt 590
 587 acc8= constant 78
 588 call writeAcc8
 589 ;test5.p(62)   if (one+three <= (twelve/(one+2))) write(77);
 590 acc16= variable 0
 591 acc16+ variable 2
 592 <acc16
 593 acc16= variable 8
 594 <acc16= variable 0
 595 acc16+ constant 2
 596 /acc16 unstack16
 597 revAcc16Comp unstack16
 598 brlt 602
 599 acc8= constant 77
 600 call writeAcc8
 601 ;test5.p(63)   if (one+one <= (twelve/(one+2))) write(76);
 602 acc16= variable 0
 603 acc16+ variable 0
 604 <acc16
 605 acc16= variable 8
 606 <acc16= variable 0
 607 acc16+ constant 2
 608 /acc16 unstack16
 609 revAcc16Comp unstack16
 610 brlt 614
 611 acc8= constant 76
 612 call writeAcc8
 613 ;test5.p(64)   if (one+four > (twelve/(one+2))) write(75);
 614 acc16= variable 0
 615 acc16+ variable 4
 616 <acc16
 617 acc16= variable 8
 618 <acc16= variable 0
 619 acc16+ constant 2
 620 /acc16 unstack16
 621 revAcc16Comp unstack16
 622 brge 626
 623 acc8= constant 75
 624 call writeAcc8
 625 ;test5.p(65)   if (one+one < (twelve/(one+2))) write(74);
 626 acc16= variable 0
 627 acc16+ variable 0
 628 <acc16
 629 acc16= variable 8
 630 <acc16= variable 0
 631 acc16+ constant 2
 632 /acc16 unstack16
 633 revAcc16Comp unstack16
 634 brle 638
 635 acc8= constant 74
 636 call writeAcc8
 637 ;test5.p(66)   if (one+four  != (twelve/(one+2))) write(73);
 638 acc16= variable 0
 639 acc16+ variable 4
 640 <acc16
 641 acc16= variable 8
 642 <acc16= variable 0
 643 acc16+ constant 2
 644 /acc16 unstack16
 645 revAcc16Comp unstack16
 646 breq 650
 647 acc8= constant 73
 648 call writeAcc8
 649 ;test5.p(67)   if (one+three == (twelve/(one+2))) write(72);
 650 acc16= variable 0
 651 acc16+ variable 2
 652 <acc16
 653 acc16= variable 8
 654 <acc16= variable 0
 655 acc16+ constant 2
 656 /acc16 unstack16
 657 revAcc16Comp unstack16
 658 brne 662
 659 acc8= constant 72
 660 call writeAcc8
 661 ;test5.p(68)   if (one+four >= (12/(1+2))) write(71);
 662 acc16= variable 0
 663 acc16+ variable 4
 664 <acc16
 665 acc8= constant 12
 666 <acc8= constant 1
 667 acc8+ constant 2
 668 /acc8 unstack8
 669 acc16= unstack16
 670 acc16CompareAcc8
 671 brlt 675
 672 acc8= constant 71
 673 call writeAcc8
 674 ;test5.p(69)   if (one+three >= (12/(1+2))) write(70);
 675 acc16= variable 0
 676 acc16+ variable 2
 677 <acc16
 678 acc8= constant 12
 679 <acc8= constant 1
 680 acc8+ constant 2
 681 /acc8 unstack8
 682 acc16= unstack16
 683 acc16CompareAcc8
 684 brlt 688
 685 acc8= constant 70
 686 call writeAcc8
 687 ;test5.p(70)   if (one+three <= (12/(1+2))) write(69);
 688 acc16= variable 0
 689 acc16+ variable 2
 690 <acc16
 691 acc8= constant 12
 692 <acc8= constant 1
 693 acc8+ constant 2
 694 /acc8 unstack8
 695 acc16= unstack16
 696 acc16CompareAcc8
 697 brgt 701
 698 acc8= constant 69
 699 call writeAcc8
 700 ;test5.p(71)   if (one+one <= (12/(1+2))) write(68);
 701 acc16= variable 0
 702 acc16+ variable 0
 703 <acc16
 704 acc8= constant 12
 705 <acc8= constant 1
 706 acc8+ constant 2
 707 /acc8 unstack8
 708 acc16= unstack16
 709 acc16CompareAcc8
 710 brgt 714
 711 acc8= constant 68
 712 call writeAcc8
 713 ;test5.p(72)   if (one+four > (12/(1+2))) write(67);
 714 acc16= variable 0
 715 acc16+ variable 4
 716 <acc16
 717 acc8= constant 12
 718 <acc8= constant 1
 719 acc8+ constant 2
 720 /acc8 unstack8
 721 acc16= unstack16
 722 acc16CompareAcc8
 723 brle 727
 724 acc8= constant 67
 725 call writeAcc8
 726 ;test5.p(73)   if (one+one < (12/(1+2))) write(66);
 727 acc16= variable 0
 728 acc16+ variable 0
 729 <acc16
 730 acc8= constant 12
 731 <acc8= constant 1
 732 acc8+ constant 2
 733 /acc8 unstack8
 734 acc16= unstack16
 735 acc16CompareAcc8
 736 brge 740
 737 acc8= constant 66
 738 call writeAcc8
 739 ;test5.p(74)   if (one+four  != (12/(1+2))) write(65);
 740 acc16= variable 0
 741 acc16+ variable 4
 742 <acc16
 743 acc8= constant 12
 744 <acc8= constant 1
 745 acc8+ constant 2
 746 /acc8 unstack8
 747 acc16= unstack16
 748 acc16CompareAcc8
 749 breq 753
 750 acc8= constant 65
 751 call writeAcc8
 752 ;test5.p(75)   if (one+three == (12/(1+2))) write(64);
 753 acc16= variable 0
 754 acc16+ variable 2
 755 <acc16
 756 acc8= constant 12
 757 <acc8= constant 1
 758 acc8+ constant 2
 759 /acc8 unstack8
 760 acc16= unstack16
 761 acc16CompareAcc8
 762 brne 768
 763 acc8= constant 64
 764 call writeAcc8
 765 ;test5.p(76)   //stack level 1
 766 ;test5.p(77)   //integer-byte
 767 ;test5.p(78)   if (four >= 4) write(63);
 768 acc16= variable 4
 769 <acc16
 770 acc16= unstack16
 771 acc8= constant 4
 772 acc16CompareAcc8
 773 brlt 777
 774 acc8= constant 63
 775 call writeAcc8
 776 ;test5.p(79)   if (four >= (12/(1+2))) write(62);
 777 acc16= variable 4
 778 <acc16
 779 acc8= constant 12
 780 <acc8= constant 1
 781 acc8+ constant 2
 782 /acc8 unstack8
 783 acc16= unstack16
 784 acc16CompareAcc8
 785 brlt 789
 786 acc8= constant 62
 787 call writeAcc8
 788 ;test5.p(80)   if (five >= 4) write(61);
 789 acc16= variable 6
 790 <acc16
 791 acc16= unstack16
 792 acc8= constant 4
 793 acc16CompareAcc8
 794 brlt 798
 795 acc8= constant 61
 796 call writeAcc8
 797 ;test5.p(81)   if (five >= (12/(1+2))) write(60);
 798 acc16= variable 6
 799 <acc16
 800 acc8= constant 12
 801 <acc8= constant 1
 802 acc8+ constant 2
 803 /acc8 unstack8
 804 acc16= unstack16
 805 acc16CompareAcc8
 806 brlt 810
 807 acc8= constant 60
 808 call writeAcc8
 809 ;test5.p(82)   if (four <= 4) write(59);
 810 acc16= variable 4
 811 <acc16
 812 acc16= unstack16
 813 acc8= constant 4
 814 acc16CompareAcc8
 815 brgt 819
 816 acc8= constant 59
 817 call writeAcc8
 818 ;test5.p(83)   if (four <= (12/(1+2))) write(58);
 819 acc16= variable 4
 820 <acc16
 821 acc8= constant 12
 822 <acc8= constant 1
 823 acc8+ constant 2
 824 /acc8 unstack8
 825 acc16= unstack16
 826 acc16CompareAcc8
 827 brgt 831
 828 acc8= constant 58
 829 call writeAcc8
 830 ;test5.p(84)   if (three <= 4) write(57);
 831 acc16= variable 2
 832 <acc16
 833 acc16= unstack16
 834 acc8= constant 4
 835 acc16CompareAcc8
 836 brgt 840
 837 acc8= constant 57
 838 call writeAcc8
 839 ;test5.p(85)   if (three <= (12/(1+2))) write(56);
 840 acc16= variable 2
 841 <acc16
 842 acc8= constant 12
 843 <acc8= constant 1
 844 acc8+ constant 2
 845 /acc8 unstack8
 846 acc16= unstack16
 847 acc16CompareAcc8
 848 brgt 852
 849 acc8= constant 56
 850 call writeAcc8
 851 ;test5.p(86)   if (five > 4) write(55);
 852 acc16= variable 6
 853 <acc16
 854 acc16= unstack16
 855 acc8= constant 4
 856 acc16CompareAcc8
 857 brle 861
 858 acc8= constant 55
 859 call writeAcc8
 860 ;test5.p(87)   if (five > (12/(1+2))) write(54);
 861 acc16= variable 6
 862 <acc16
 863 acc8= constant 12
 864 <acc8= constant 1
 865 acc8+ constant 2
 866 /acc8 unstack8
 867 acc16= unstack16
 868 acc16CompareAcc8
 869 brle 873
 870 acc8= constant 54
 871 call writeAcc8
 872 ;test5.p(88)   if (three < 4) write(53);
 873 acc16= variable 2
 874 <acc16
 875 acc16= unstack16
 876 acc8= constant 4
 877 acc16CompareAcc8
 878 brge 882
 879 acc8= constant 53
 880 call writeAcc8
 881 ;test5.p(89)   if (three < (12/(1+2))) write(52);
 882 acc16= variable 2
 883 <acc16
 884 acc8= constant 12
 885 <acc8= constant 1
 886 acc8+ constant 2
 887 /acc8 unstack8
 888 acc16= unstack16
 889 acc16CompareAcc8
 890 brge 894
 891 acc8= constant 52
 892 call writeAcc8
 893 ;test5.p(90)   if (three != 4) write(51);
 894 acc16= variable 2
 895 <acc16
 896 acc16= unstack16
 897 acc8= constant 4
 898 acc16CompareAcc8
 899 breq 903
 900 acc8= constant 51
 901 call writeAcc8
 902 ;test5.p(91)   if (three != (12/(1+2))) write(50);
 903 acc16= variable 2
 904 <acc16
 905 acc8= constant 12
 906 <acc8= constant 1
 907 acc8+ constant 2
 908 /acc8 unstack8
 909 acc16= unstack16
 910 acc16CompareAcc8
 911 breq 915
 912 acc8= constant 50
 913 call writeAcc8
 914 ;test5.p(92)   if (four == 4) write(49);
 915 acc16= variable 4
 916 <acc16
 917 acc16= unstack16
 918 acc8= constant 4
 919 acc16CompareAcc8
 920 brne 924
 921 acc8= constant 49
 922 call writeAcc8
 923 ;test5.p(93)   if (four == (12/(1+2))) write(48);
 924 acc16= variable 4
 925 <acc16
 926 acc8= constant 12
 927 <acc8= constant 1
 928 acc8+ constant 2
 929 /acc8 unstack8
 930 acc16= unstack16
 931 acc16CompareAcc8
 932 brne 937
 933 acc8= constant 48
 934 call writeAcc8
 935 ;test5.p(94)   //byte-integer
 936 ;test5.p(95)   if (4 >= four) write(47);
 937 acc16= variable 4
 938 acc8= constant 4
 939 acc8CompareAcc16
 940 brlt 944
 941 acc8= constant 47
 942 call writeAcc8
 943 ;test5.p(96)   if (4 >= (twelve/(1+2))) write(46);
 944 acc16= variable 8
 945 acc8= constant 1
 946 acc8+ constant 2
 947 acc16/ acc8
 948 acc8= constant 4
 949 acc8CompareAcc16
 950 brlt 954
 951 acc8= constant 46
 952 call writeAcc8
 953 ;test5.p(97)   if (5 >= four) write(45);
 954 acc16= variable 4
 955 acc8= constant 5
 956 acc8CompareAcc16
 957 brlt 961
 958 acc8= constant 45
 959 call writeAcc8
 960 ;test5.p(98)   if (5 >= (twelve/(1+2))) write(44);
 961 acc16= variable 8
 962 acc8= constant 1
 963 acc8+ constant 2
 964 acc16/ acc8
 965 acc8= constant 5
 966 acc8CompareAcc16
 967 brlt 971
 968 acc8= constant 44
 969 call writeAcc8
 970 ;test5.p(99)   if (4 <= four) write(43);
 971 acc16= variable 4
 972 acc8= constant 4
 973 acc8CompareAcc16
 974 brgt 978
 975 acc8= constant 43
 976 call writeAcc8
 977 ;test5.p(100)   if (4 <= (twelve/(1+2))) write(42);
 978 acc16= variable 8
 979 acc8= constant 1
 980 acc8+ constant 2
 981 acc16/ acc8
 982 acc8= constant 4
 983 acc8CompareAcc16
 984 brgt 988
 985 acc8= constant 42
 986 call writeAcc8
 987 ;test5.p(101)   if (3 <= four) write(41);
 988 acc16= variable 4
 989 acc8= constant 3
 990 acc8CompareAcc16
 991 brgt 995
 992 acc8= constant 41
 993 call writeAcc8
 994 ;test5.p(102)   if (3 <= (twelve/(1+2))) write(40);
 995 acc16= variable 8
 996 acc8= constant 1
 997 acc8+ constant 2
 998 acc16/ acc8
 999 acc8= constant 3
1000 acc8CompareAcc16
1001 brgt 1005
1002 acc8= constant 40
1003 call writeAcc8
1004 ;test5.p(103)   if (5 > four) write(39);
1005 acc16= variable 4
1006 acc8= constant 5
1007 acc8CompareAcc16
1008 brle 1012
1009 acc8= constant 39
1010 call writeAcc8
1011 ;test5.p(104)   if (5 > (twelve/(1+2))) write(38);
1012 acc16= variable 8
1013 acc8= constant 1
1014 acc8+ constant 2
1015 acc16/ acc8
1016 acc8= constant 5
1017 acc8CompareAcc16
1018 brle 1022
1019 acc8= constant 38
1020 call writeAcc8
1021 ;test5.p(105)   if (3 < four) write(37);
1022 acc16= variable 4
1023 acc8= constant 3
1024 acc8CompareAcc16
1025 brge 1029
1026 acc8= constant 37
1027 call writeAcc8
1028 ;test5.p(106)   if (3 < (twelve/(1+2))) write(36);
1029 acc16= variable 8
1030 acc8= constant 1
1031 acc8+ constant 2
1032 acc16/ acc8
1033 acc8= constant 3
1034 acc8CompareAcc16
1035 brge 1039
1036 acc8= constant 36
1037 call writeAcc8
1038 ;test5.p(107)   if (3 != four) write(35);
1039 acc16= variable 4
1040 acc8= constant 3
1041 acc8CompareAcc16
1042 breq 1046
1043 acc8= constant 35
1044 call writeAcc8
1045 ;test5.p(108)   if (3 != (twelve/(1+2))) write(34);
1046 acc16= variable 8
1047 acc8= constant 1
1048 acc8+ constant 2
1049 acc16/ acc8
1050 acc8= constant 3
1051 acc8CompareAcc16
1052 breq 1056
1053 acc8= constant 34
1054 call writeAcc8
1055 ;test5.p(109)   if (4 == four) write(33);
1056 acc16= variable 4
1057 acc8= constant 4
1058 acc8CompareAcc16
1059 brne 1063
1060 acc8= constant 33
1061 call writeAcc8
1062 ;test5.p(110)   if (4 == (twelve/(1+2))) write(32);
1063 acc16= variable 8
1064 acc8= constant 1
1065 acc8+ constant 2
1066 acc16/ acc8
1067 acc8= constant 4
1068 acc8CompareAcc16
1069 brne 1074
1070 acc8= constant 32
1071 call writeAcc8
1072 ;test5.p(111)   //integer-integer
1073 ;test5.p(112)   if (400 >= 400) write(31);
1074 acc16= constant 400
1075 acc16Comp constant 400
1076 brlt 1080
1077 acc8= constant 31
1078 call writeAcc8
1079 ;test5.p(113)   if (400 >= (1200/(1+2))) write(30);
1080 acc16= constant 1200
1081 acc8= constant 1
1082 acc8+ constant 2
1083 acc16/ acc8
1084 acc16Comp constant 400
1085 brgt 1089
1086 acc8= constant 30
1087 call writeAcc8
1088 ;test5.p(114)   if (500 >= 400) write(29);
1089 acc16= constant 500
1090 acc16Comp constant 400
1091 brlt 1095
1092 acc8= constant 29
1093 call writeAcc8
1094 ;test5.p(115)   if (500 >= (1200/(1+2))) write(28);
1095 acc16= constant 1200
1096 acc8= constant 1
1097 acc8+ constant 2
1098 acc16/ acc8
1099 acc16Comp constant 500
1100 brgt 1104
1101 acc8= constant 28
1102 call writeAcc8
1103 ;test5.p(116)   if (400 <= 400) write(27);
1104 acc16= constant 400
1105 acc16Comp constant 400
1106 brgt 1110
1107 acc8= constant 27
1108 call writeAcc8
1109 ;test5.p(117)   if (400 <= (1200/(1+2))) write(26);
1110 acc16= constant 1200
1111 acc8= constant 1
1112 acc8+ constant 2
1113 acc16/ acc8
1114 acc16Comp constant 400
1115 brlt 1119
1116 acc8= constant 26
1117 call writeAcc8
1118 ;test5.p(118)   if (300 <= 400) write(25);
1119 acc16= constant 300
1120 acc16Comp constant 400
1121 brgt 1125
1122 acc8= constant 25
1123 call writeAcc8
1124 ;test5.p(119)   if (300 <= (1200/(1+2))) write(24);
1125 acc16= constant 1200
1126 acc8= constant 1
1127 acc8+ constant 2
1128 acc16/ acc8
1129 acc16Comp constant 300
1130 brlt 1134
1131 acc8= constant 24
1132 call writeAcc8
1133 ;test5.p(120)   if (500 > 400) write(23);
1134 acc16= constant 500
1135 acc16Comp constant 400
1136 brle 1140
1137 acc8= constant 23
1138 call writeAcc8
1139 ;test5.p(121)   if (500 > (1200/(1+2))) write(22);
1140 acc16= constant 1200
1141 acc8= constant 1
1142 acc8+ constant 2
1143 acc16/ acc8
1144 acc16Comp constant 500
1145 brge 1149
1146 acc8= constant 22
1147 call writeAcc8
1148 ;test5.p(122)   if (300 < 400) write(21);
1149 acc16= constant 300
1150 acc16Comp constant 400
1151 brge 1155
1152 acc8= constant 21
1153 call writeAcc8
1154 ;test5.p(123)   if (300 < (1200/(1+2))) write(20);
1155 acc16= constant 1200
1156 acc8= constant 1
1157 acc8+ constant 2
1158 acc16/ acc8
1159 acc16Comp constant 300
1160 brle 1164
1161 acc8= constant 20
1162 call writeAcc8
1163 ;test5.p(124)   if (300 != 400) write(19);
1164 acc16= constant 300
1165 acc16Comp constant 400
1166 breq 1170
1167 acc8= constant 19
1168 call writeAcc8
1169 ;test5.p(125)   if (300 != (1200/(1+2))) write(18);
1170 acc16= constant 1200
1171 acc8= constant 1
1172 acc8+ constant 2
1173 acc16/ acc8
1174 acc16Comp constant 300
1175 breq 1179
1176 acc8= constant 18
1177 call writeAcc8
1178 ;test5.p(126)   if (400 == 400) write(17);
1179 acc16= constant 400
1180 acc16Comp constant 400
1181 brne 1185
1182 acc8= constant 17
1183 call writeAcc8
1184 ;test5.p(127)   if (400 == (1200/(1+2))) write(16);
1185 acc16= constant 1200
1186 acc8= constant 1
1187 acc8+ constant 2
1188 acc16/ acc8
1189 acc16Comp constant 400
1190 brne 1195
1191 acc8= constant 16
1192 call writeAcc8
1193 ;test5.p(128)   //byte-byte
1194 ;test5.p(129)   if (4 >= 4) write(15);
1195 acc8= constant 4
1196 acc8Comp constant 4
1197 brlt 1201
1198 acc8= constant 15
1199 call writeAcc8
1200 ;test5.p(130)   if (4 >= (12/(1+2))) write(14);
1201 acc8= constant 12
1202 <acc8= constant 1
1203 acc8+ constant 2
1204 /acc8 unstack8
1205 acc8Comp constant 4
1206 brgt 1210
1207 acc8= constant 14
1208 call writeAcc8
1209 ;test5.p(131)   if (5 >= 4) write(13);
1210 acc8= constant 5
1211 acc8Comp constant 4
1212 brlt 1216
1213 acc8= constant 13
1214 call writeAcc8
1215 ;test5.p(132)   if (5 >= (12/(1+2))) write(12);
1216 acc8= constant 12
1217 <acc8= constant 1
1218 acc8+ constant 2
1219 /acc8 unstack8
1220 acc8Comp constant 5
1221 brgt 1225
1222 acc8= constant 12
1223 call writeAcc8
1224 ;test5.p(133)   if (4 <= 4) write(11);
1225 acc8= constant 4
1226 acc8Comp constant 4
1227 brgt 1231
1228 acc8= constant 11
1229 call writeAcc8
1230 ;test5.p(134)   if (4 <= (12/(1+2))) write(10);
1231 acc8= constant 12
1232 <acc8= constant 1
1233 acc8+ constant 2
1234 /acc8 unstack8
1235 acc8Comp constant 4
1236 brlt 1240
1237 acc8= constant 10
1238 call writeAcc8
1239 ;test5.p(135)   if (3 <= 4) write(9);
1240 acc8= constant 3
1241 acc8Comp constant 4
1242 brgt 1246
1243 acc8= constant 9
1244 call writeAcc8
1245 ;test5.p(136)   if (3 <= (12/(1+2))) write(8);
1246 acc8= constant 12
1247 <acc8= constant 1
1248 acc8+ constant 2
1249 /acc8 unstack8
1250 acc8Comp constant 3
1251 brlt 1255
1252 acc8= constant 8
1253 call writeAcc8
1254 ;test5.p(137)   if (5 > 4) write(7);
1255 acc8= constant 5
1256 acc8Comp constant 4
1257 brle 1261
1258 acc8= constant 7
1259 call writeAcc8
1260 ;test5.p(138)   if (5 > (12/(1+2))) write(6);
1261 acc8= constant 12
1262 <acc8= constant 1
1263 acc8+ constant 2
1264 /acc8 unstack8
1265 acc8Comp constant 5
1266 brge 1270
1267 acc8= constant 6
1268 call writeAcc8
1269 ;test5.p(139)   if (3 < 4) write(5);
1270 acc8= constant 3
1271 acc8Comp constant 4
1272 brge 1276
1273 acc8= constant 5
1274 call writeAcc8
1275 ;test5.p(140)   if (3 < (12/(1+2))) write(4);
1276 acc8= constant 12
1277 <acc8= constant 1
1278 acc8+ constant 2
1279 /acc8 unstack8
1280 acc8Comp constant 3
1281 brle 1285
1282 acc8= constant 4
1283 call writeAcc8
1284 ;test5.p(141)   if (3 != 4) write(3);
1285 acc8= constant 3
1286 acc8Comp constant 4
1287 breq 1291
1288 acc8= constant 3
1289 call writeAcc8
1290 ;test5.p(142)   if (3 != (12/(1+2))) write(2);
1291 acc8= constant 12
1292 <acc8= constant 1
1293 acc8+ constant 2
1294 /acc8 unstack8
1295 acc8Comp constant 3
1296 breq 1300
1297 acc8= constant 2
1298 call writeAcc8
1299 ;test5.p(143)   if (4 == 4) write(1);
1300 acc8= constant 4
1301 acc8Comp constant 4
1302 brne 1306
1303 acc8= constant 1
1304 call writeAcc8
1305 ;test5.p(144)   if (4 == (12/(1+2))) write(0);
1306 acc8= constant 12
1307 <acc8= constant 1
1308 acc8+ constant 2
1309 /acc8 unstack8
1310 acc8Comp constant 4
1311 brne 1315
1312 acc8= constant 0
1313 call writeAcc8
1314 ;test5.p(145) }
1315 stop
