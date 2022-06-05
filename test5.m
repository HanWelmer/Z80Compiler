   0 ;test5.p(0) /*
   1 ;test5.p(1)  * A small program in the miniJava language.
   2 ;test5.p(2)  * Test comparisons
   3 ;test5.p(3)  */
   4 ;test5.p(4) class TestIf {
   5 ;test5.p(5)   int one = 1;
   6 acc8= constant 1
   7 acc8=> variable 0
   8 ;test5.p(6)   int three = 3;
   9 acc8= constant 3
  10 acc8=> variable 2
  11 ;test5.p(7)   int four = 4;
  12 acc8= constant 4
  13 acc8=> variable 4
  14 ;test5.p(8)   int five = 5;
  15 acc8= constant 5
  16 acc8=> variable 6
  17 ;test5.p(9)   int twelve = 12;
  18 acc8= constant 12
  19 acc8=> variable 8
  20 ;test5.p(10)   write(128);
  21 acc8= constant 128
  22 call writeAcc8
  23 ;test5.p(11)   //stack level 2
  24 ;test5.p(12)   if (5 >= (twelve/(one+2))) write(127);
  25 acc16= variable 8
  26 <acc16= variable 0
  27 acc16+ constant 2
  28 /acc16 unstack16
  29 acc8= constant 5
  30 acc8CompareAcc16
  31 brlt 35
  32 acc8= constant 127
  33 call writeAcc8
  34 ;test5.p(13)   if (4 >= (twelve/(one+2))) write(126);
  35 acc16= variable 8
  36 <acc16= variable 0
  37 acc16+ constant 2
  38 /acc16 unstack16
  39 acc8= constant 4
  40 acc8CompareAcc16
  41 brlt 45
  42 acc8= constant 126
  43 call writeAcc8
  44 ;test5.p(14)   if (4 <= (twelve/(one+2))) write(125);
  45 acc16= variable 8
  46 <acc16= variable 0
  47 acc16+ constant 2
  48 /acc16 unstack16
  49 acc8= constant 4
  50 acc8CompareAcc16
  51 brgt 55
  52 acc8= constant 125
  53 call writeAcc8
  54 ;test5.p(15)   if (3 <= (twelve/(one+2))) write(124);
  55 acc16= variable 8
  56 <acc16= variable 0
  57 acc16+ constant 2
  58 /acc16 unstack16
  59 acc8= constant 3
  60 acc8CompareAcc16
  61 brgt 65
  62 acc8= constant 124
  63 call writeAcc8
  64 ;test5.p(16)   if (5 > (twelve/(one+2))) write(123);
  65 acc16= variable 8
  66 <acc16= variable 0
  67 acc16+ constant 2
  68 /acc16 unstack16
  69 acc8= constant 5
  70 acc8CompareAcc16
  71 brle 75
  72 acc8= constant 123
  73 call writeAcc8
  74 ;test5.p(17)   if (2 < (twelve/(one+2))) write(122);
  75 acc16= variable 8
  76 <acc16= variable 0
  77 acc16+ constant 2
  78 /acc16 unstack16
  79 acc8= constant 2
  80 acc8CompareAcc16
  81 brge 85
  82 acc8= constant 122
  83 call writeAcc8
  84 ;test5.p(18)   if (3 != (twelve/(one+2))) write(121);
  85 acc16= variable 8
  86 <acc16= variable 0
  87 acc16+ constant 2
  88 /acc16 unstack16
  89 acc8= constant 3
  90 acc8CompareAcc16
  91 breq 95
  92 acc8= constant 121
  93 call writeAcc8
  94 ;test5.p(19)   if (4 == (twelve/(one+2))) write(120);
  95 acc16= variable 8
  96 <acc16= variable 0
  97 acc16+ constant 2
  98 /acc16 unstack16
  99 acc8= constant 4
 100 acc8CompareAcc16
 101 brne 105
 102 acc8= constant 120
 103 call writeAcc8
 104 ;test5.p(20)   if (5 >= (12/(1+2))) write(119);
 105 acc8= constant 12
 106 <acc8= constant 1
 107 acc8+ constant 2
 108 /acc8 unstack8
 109 acc8Comp constant 5
 110 brgt 114
 111 acc8= constant 119
 112 call writeAcc8
 113 ;test5.p(21)   if (4 >= (12/(1+2))) write(118);
 114 acc8= constant 12
 115 <acc8= constant 1
 116 acc8+ constant 2
 117 /acc8 unstack8
 118 acc8Comp constant 4
 119 brgt 123
 120 acc8= constant 118
 121 call writeAcc8
 122 ;test5.p(22)   if (4 <= (12/(1+2))) write(117);
 123 acc8= constant 12
 124 <acc8= constant 1
 125 acc8+ constant 2
 126 /acc8 unstack8
 127 acc8Comp constant 4
 128 brlt 132
 129 acc8= constant 117
 130 call writeAcc8
 131 ;test5.p(23)   if (3 <= (12/(1+2))) write(116);
 132 acc8= constant 12
 133 <acc8= constant 1
 134 acc8+ constant 2
 135 /acc8 unstack8
 136 acc8Comp constant 3
 137 brlt 141
 138 acc8= constant 116
 139 call writeAcc8
 140 ;test5.p(24)   if (5 > (12/(1+2))) write(115);
 141 acc8= constant 12
 142 <acc8= constant 1
 143 acc8+ constant 2
 144 /acc8 unstack8
 145 acc8Comp constant 5
 146 brge 150
 147 acc8= constant 115
 148 call writeAcc8
 149 ;test5.p(25)   if (3 < (12/(1+2))) write(114);
 150 acc8= constant 12
 151 <acc8= constant 1
 152 acc8+ constant 2
 153 /acc8 unstack8
 154 acc8Comp constant 3
 155 brle 159
 156 acc8= constant 114
 157 call writeAcc8
 158 ;test5.p(26)   if (3 != (12/(1+2))) write(113);
 159 acc8= constant 12
 160 <acc8= constant 1
 161 acc8+ constant 2
 162 /acc8 unstack8
 163 acc8Comp constant 3
 164 breq 168
 165 acc8= constant 113
 166 call writeAcc8
 167 ;test5.p(27)   if (4 == (12/(1+2))) write(112);
 168 acc8= constant 12
 169 <acc8= constant 1
 170 acc8+ constant 2
 171 /acc8 unstack8
 172 acc8Comp constant 4
 173 brne 177
 174 acc8= constant 112
 175 call writeAcc8
 176 ;test5.p(28)   if (1+4 >= (twelve/(one+2))) write(111);
 177 acc8= constant 1
 178 acc8+ constant 4
 179 <acc8
 180 acc16= variable 8
 181 <acc16= variable 0
 182 acc16+ constant 2
 183 /acc16 unstack16
 184 acc8= unstack8
 185 acc8CompareAcc16
 186 brlt 190
 187 acc8= constant 111
 188 call writeAcc8
 189 ;test5.p(29)   if (1+3 >= (twelve/(one+2))) write(110);
 190 acc8= constant 1
 191 acc8+ constant 3
 192 <acc8
 193 acc16= variable 8
 194 <acc16= variable 0
 195 acc16+ constant 2
 196 /acc16 unstack16
 197 acc8= unstack8
 198 acc8CompareAcc16
 199 brlt 203
 200 acc8= constant 110
 201 call writeAcc8
 202 ;test5.p(30)   if (1+3 <= (twelve/(one+2))) write(109);
 203 acc8= constant 1
 204 acc8+ constant 3
 205 <acc8
 206 acc16= variable 8
 207 <acc16= variable 0
 208 acc16+ constant 2
 209 /acc16 unstack16
 210 acc8= unstack8
 211 acc8CompareAcc16
 212 brgt 216
 213 acc8= constant 109
 214 call writeAcc8
 215 ;test5.p(31)   if (1+2 <= (twelve/(one+2))) write(108);
 216 acc8= constant 1
 217 acc8+ constant 2
 218 <acc8
 219 acc16= variable 8
 220 <acc16= variable 0
 221 acc16+ constant 2
 222 /acc16 unstack16
 223 acc8= unstack8
 224 acc8CompareAcc16
 225 brgt 229
 226 acc8= constant 108
 227 call writeAcc8
 228 ;test5.p(32)   if (1+4 > (twelve/(one+2))) write(107);
 229 acc8= constant 1
 230 acc8+ constant 4
 231 <acc8
 232 acc16= variable 8
 233 <acc16= variable 0
 234 acc16+ constant 2
 235 /acc16 unstack16
 236 acc8= unstack8
 237 acc8CompareAcc16
 238 brle 242
 239 acc8= constant 107
 240 call writeAcc8
 241 ;test5.p(33)   if (1+2 < (twelve/(one+2))) write(106);
 242 acc8= constant 1
 243 acc8+ constant 2
 244 <acc8
 245 acc16= variable 8
 246 <acc16= variable 0
 247 acc16+ constant 2
 248 /acc16 unstack16
 249 acc8= unstack8
 250 acc8CompareAcc16
 251 brge 255
 252 acc8= constant 106
 253 call writeAcc8
 254 ;test5.p(34)   if (1+2 != (twelve/(one+2))) write(105);
 255 acc8= constant 1
 256 acc8+ constant 2
 257 <acc8
 258 acc16= variable 8
 259 <acc16= variable 0
 260 acc16+ constant 2
 261 /acc16 unstack16
 262 acc8= unstack8
 263 acc8CompareAcc16
 264 breq 268
 265 acc8= constant 105
 266 call writeAcc8
 267 ;test5.p(35)   if (1+3 == (twelve/(one+2))) write(104);
 268 acc8= constant 1
 269 acc8+ constant 3
 270 <acc8
 271 acc16= variable 8
 272 <acc16= variable 0
 273 acc16+ constant 2
 274 /acc16 unstack16
 275 acc8= unstack8
 276 acc8CompareAcc16
 277 brne 281
 278 acc8= constant 104
 279 call writeAcc8
 280 ;test5.p(36)   if (1+4 >= (12/(1+2))) write(103);
 281 acc8= constant 1
 282 acc8+ constant 4
 283 <acc8
 284 acc8= constant 12
 285 <acc8= constant 1
 286 acc8+ constant 2
 287 /acc8 unstack8
 288 revAcc8Comp unstack8
 289 brgt 293
 290 acc8= constant 103
 291 call writeAcc8
 292 ;test5.p(37)   if (1+3 >= (12/(1+2))) write(102);
 293 acc8= constant 1
 294 acc8+ constant 3
 295 <acc8
 296 acc8= constant 12
 297 <acc8= constant 1
 298 acc8+ constant 2
 299 /acc8 unstack8
 300 revAcc8Comp unstack8
 301 brgt 305
 302 acc8= constant 102
 303 call writeAcc8
 304 ;test5.p(38)   if (1+3 <= (12/(1+2))) write(101);
 305 acc8= constant 1
 306 acc8+ constant 3
 307 <acc8
 308 acc8= constant 12
 309 <acc8= constant 1
 310 acc8+ constant 2
 311 /acc8 unstack8
 312 revAcc8Comp unstack8
 313 brlt 317
 314 acc8= constant 101
 315 call writeAcc8
 316 ;test5.p(39)   if (1+2 <= (12/(1+2))) write(100);
 317 acc8= constant 1
 318 acc8+ constant 2
 319 <acc8
 320 acc8= constant 12
 321 <acc8= constant 1
 322 acc8+ constant 2
 323 /acc8 unstack8
 324 revAcc8Comp unstack8
 325 brlt 329
 326 acc8= constant 100
 327 call writeAcc8
 328 ;test5.p(40)   if (1+4 > (12/(1+2))) write(99);
 329 acc8= constant 1
 330 acc8+ constant 4
 331 <acc8
 332 acc8= constant 12
 333 <acc8= constant 1
 334 acc8+ constant 2
 335 /acc8 unstack8
 336 revAcc8Comp unstack8
 337 brge 341
 338 acc8= constant 99
 339 call writeAcc8
 340 ;test5.p(41)   if (1+2 < (12/(1+2))) write(98);
 341 acc8= constant 1
 342 acc8+ constant 2
 343 <acc8
 344 acc8= constant 12
 345 <acc8= constant 1
 346 acc8+ constant 2
 347 /acc8 unstack8
 348 revAcc8Comp unstack8
 349 brle 353
 350 acc8= constant 98
 351 call writeAcc8
 352 ;test5.p(42)   if (1+2 != (12/(1+2))) write(97);
 353 acc8= constant 1
 354 acc8+ constant 2
 355 <acc8
 356 acc8= constant 12
 357 <acc8= constant 1
 358 acc8+ constant 2
 359 /acc8 unstack8
 360 revAcc8Comp unstack8
 361 breq 365
 362 acc8= constant 97
 363 call writeAcc8
 364 ;test5.p(43)   if (1+3 == (12/(1+2))) write(96);
 365 acc8= constant 1
 366 acc8+ constant 3
 367 <acc8
 368 acc8= constant 12
 369 <acc8= constant 1
 370 acc8+ constant 2
 371 /acc8 unstack8
 372 revAcc8Comp unstack8
 373 brne 377
 374 acc8= constant 96
 375 call writeAcc8
 376 ;test5.p(44)   if (twelve >= (twelve/(one+2))) write(95);
 377 acc16= variable 8
 378 <acc16
 379 acc16= variable 8
 380 <acc16= variable 0
 381 acc16+ constant 2
 382 /acc16 unstack16
 383 revAcc16Comp unstack16
 384 brgt 388
 385 acc8= constant 95
 386 call writeAcc8
 387 ;test5.p(45)   if (four >= (twelve/(one+2))) write(94);
 388 acc16= variable 4
 389 <acc16
 390 acc16= variable 8
 391 <acc16= variable 0
 392 acc16+ constant 2
 393 /acc16 unstack16
 394 revAcc16Comp unstack16
 395 brgt 399
 396 acc8= constant 94
 397 call writeAcc8
 398 ;test5.p(46)   if (three <= (twelve/(one+2))) write(93);
 399 acc16= variable 2
 400 <acc16
 401 acc16= variable 8
 402 <acc16= variable 0
 403 acc16+ constant 2
 404 /acc16 unstack16
 405 revAcc16Comp unstack16
 406 brlt 410
 407 acc8= constant 93
 408 call writeAcc8
 409 ;test5.p(47)   if (four <= (twelve/(one+2))) write(92);
 410 acc16= variable 4
 411 <acc16
 412 acc16= variable 8
 413 <acc16= variable 0
 414 acc16+ constant 2
 415 /acc16 unstack16
 416 revAcc16Comp unstack16
 417 brlt 421
 418 acc8= constant 92
 419 call writeAcc8
 420 ;test5.p(48)   if (twelve > (twelve/(one+2))) write(91);
 421 acc16= variable 8
 422 <acc16
 423 acc16= variable 8
 424 <acc16= variable 0
 425 acc16+ constant 2
 426 /acc16 unstack16
 427 revAcc16Comp unstack16
 428 brge 432
 429 acc8= constant 91
 430 call writeAcc8
 431 ;test5.p(49)   if (three < (twelve/(one+2))) write(90);
 432 acc16= variable 2
 433 <acc16
 434 acc16= variable 8
 435 <acc16= variable 0
 436 acc16+ constant 2
 437 /acc16 unstack16
 438 revAcc16Comp unstack16
 439 brle 443
 440 acc8= constant 90
 441 call writeAcc8
 442 ;test5.p(50)   if (three != (twelve/(one+2))) write(89);
 443 acc16= variable 2
 444 <acc16
 445 acc16= variable 8
 446 <acc16= variable 0
 447 acc16+ constant 2
 448 /acc16 unstack16
 449 revAcc16Comp unstack16
 450 breq 454
 451 acc8= constant 89
 452 call writeAcc8
 453 ;test5.p(51)   if (four == (twelve/(one+2))) write(88);
 454 acc16= variable 4
 455 <acc16
 456 acc16= variable 8
 457 <acc16= variable 0
 458 acc16+ constant 2
 459 /acc16 unstack16
 460 revAcc16Comp unstack16
 461 brne 465
 462 acc8= constant 88
 463 call writeAcc8
 464 ;test5.p(52)   if (twelve >= (12/(1+2))) write(87);
 465 acc16= variable 8
 466 <acc16
 467 acc8= constant 12
 468 <acc8= constant 1
 469 acc8+ constant 2
 470 /acc8 unstack8
 471 acc16= unstack16
 472 acc16CompareAcc8
 473 brlt 477
 474 acc8= constant 87
 475 call writeAcc8
 476 ;test5.p(53)   if (four >= (12/(1+2))) write(86);
 477 acc16= variable 4
 478 <acc16
 479 acc8= constant 12
 480 <acc8= constant 1
 481 acc8+ constant 2
 482 /acc8 unstack8
 483 acc16= unstack16
 484 acc16CompareAcc8
 485 brlt 489
 486 acc8= constant 86
 487 call writeAcc8
 488 ;test5.p(54)   if (three <= (12/(1+2))) write(85);
 489 acc16= variable 2
 490 <acc16
 491 acc8= constant 12
 492 <acc8= constant 1
 493 acc8+ constant 2
 494 /acc8 unstack8
 495 acc16= unstack16
 496 acc16CompareAcc8
 497 brgt 501
 498 acc8= constant 85
 499 call writeAcc8
 500 ;test5.p(55)   if (four <= (12/(1+2))) write(84);
 501 acc16= variable 4
 502 <acc16
 503 acc8= constant 12
 504 <acc8= constant 1
 505 acc8+ constant 2
 506 /acc8 unstack8
 507 acc16= unstack16
 508 acc16CompareAcc8
 509 brgt 513
 510 acc8= constant 84
 511 call writeAcc8
 512 ;test5.p(56)   if (twelve > (12/(1+2))) write(83);
 513 acc16= variable 8
 514 <acc16
 515 acc8= constant 12
 516 <acc8= constant 1
 517 acc8+ constant 2
 518 /acc8 unstack8
 519 acc16= unstack16
 520 acc16CompareAcc8
 521 brle 525
 522 acc8= constant 83
 523 call writeAcc8
 524 ;test5.p(57)   if (three < (12/(1+2))) write(82);
 525 acc16= variable 2
 526 <acc16
 527 acc8= constant 12
 528 <acc8= constant 1
 529 acc8+ constant 2
 530 /acc8 unstack8
 531 acc16= unstack16
 532 acc16CompareAcc8
 533 brge 537
 534 acc8= constant 82
 535 call writeAcc8
 536 ;test5.p(58)   if (three != (12/(1+2))) write(81);
 537 acc16= variable 2
 538 <acc16
 539 acc8= constant 12
 540 <acc8= constant 1
 541 acc8+ constant 2
 542 /acc8 unstack8
 543 acc16= unstack16
 544 acc16CompareAcc8
 545 breq 549
 546 acc8= constant 81
 547 call writeAcc8
 548 ;test5.p(59)   if (four == (12/(1+2))) write(80);
 549 acc16= variable 4
 550 <acc16
 551 acc8= constant 12
 552 <acc8= constant 1
 553 acc8+ constant 2
 554 /acc8 unstack8
 555 acc16= unstack16
 556 acc16CompareAcc8
 557 brne 561
 558 acc8= constant 80
 559 call writeAcc8
 560 ;test5.p(60)   if (one+four >= (twelve/(one+2))) write(79);
 561 acc16= variable 0
 562 acc16+ variable 4
 563 <acc16
 564 acc16= variable 8
 565 <acc16= variable 0
 566 acc16+ constant 2
 567 /acc16 unstack16
 568 revAcc16Comp unstack16
 569 brgt 573
 570 acc8= constant 79
 571 call writeAcc8
 572 ;test5.p(61)   if (one+three >= (twelve/(one+2))) write(78);
 573 acc16= variable 0
 574 acc16+ variable 2
 575 <acc16
 576 acc16= variable 8
 577 <acc16= variable 0
 578 acc16+ constant 2
 579 /acc16 unstack16
 580 revAcc16Comp unstack16
 581 brgt 585
 582 acc8= constant 78
 583 call writeAcc8
 584 ;test5.p(62)   if (one+three <= (twelve/(one+2))) write(77);
 585 acc16= variable 0
 586 acc16+ variable 2
 587 <acc16
 588 acc16= variable 8
 589 <acc16= variable 0
 590 acc16+ constant 2
 591 /acc16 unstack16
 592 revAcc16Comp unstack16
 593 brlt 597
 594 acc8= constant 77
 595 call writeAcc8
 596 ;test5.p(63)   if (one+one <= (twelve/(one+2))) write(76);
 597 acc16= variable 0
 598 acc16+ variable 0
 599 <acc16
 600 acc16= variable 8
 601 <acc16= variable 0
 602 acc16+ constant 2
 603 /acc16 unstack16
 604 revAcc16Comp unstack16
 605 brlt 609
 606 acc8= constant 76
 607 call writeAcc8
 608 ;test5.p(64)   if (one+four > (twelve/(one+2))) write(75);
 609 acc16= variable 0
 610 acc16+ variable 4
 611 <acc16
 612 acc16= variable 8
 613 <acc16= variable 0
 614 acc16+ constant 2
 615 /acc16 unstack16
 616 revAcc16Comp unstack16
 617 brge 621
 618 acc8= constant 75
 619 call writeAcc8
 620 ;test5.p(65)   if (one+one < (twelve/(one+2))) write(74);
 621 acc16= variable 0
 622 acc16+ variable 0
 623 <acc16
 624 acc16= variable 8
 625 <acc16= variable 0
 626 acc16+ constant 2
 627 /acc16 unstack16
 628 revAcc16Comp unstack16
 629 brle 633
 630 acc8= constant 74
 631 call writeAcc8
 632 ;test5.p(66)   if (one+four  != (twelve/(one+2))) write(73);
 633 acc16= variable 0
 634 acc16+ variable 4
 635 <acc16
 636 acc16= variable 8
 637 <acc16= variable 0
 638 acc16+ constant 2
 639 /acc16 unstack16
 640 revAcc16Comp unstack16
 641 breq 645
 642 acc8= constant 73
 643 call writeAcc8
 644 ;test5.p(67)   if (one+three == (twelve/(one+2))) write(72);
 645 acc16= variable 0
 646 acc16+ variable 2
 647 <acc16
 648 acc16= variable 8
 649 <acc16= variable 0
 650 acc16+ constant 2
 651 /acc16 unstack16
 652 revAcc16Comp unstack16
 653 brne 657
 654 acc8= constant 72
 655 call writeAcc8
 656 ;test5.p(68)   if (one+four >= (12/(1+2))) write(71);
 657 acc16= variable 0
 658 acc16+ variable 4
 659 <acc16
 660 acc8= constant 12
 661 <acc8= constant 1
 662 acc8+ constant 2
 663 /acc8 unstack8
 664 acc16= unstack16
 665 acc16CompareAcc8
 666 brlt 670
 667 acc8= constant 71
 668 call writeAcc8
 669 ;test5.p(69)   if (one+three >= (12/(1+2))) write(70);
 670 acc16= variable 0
 671 acc16+ variable 2
 672 <acc16
 673 acc8= constant 12
 674 <acc8= constant 1
 675 acc8+ constant 2
 676 /acc8 unstack8
 677 acc16= unstack16
 678 acc16CompareAcc8
 679 brlt 683
 680 acc8= constant 70
 681 call writeAcc8
 682 ;test5.p(70)   if (one+three <= (12/(1+2))) write(69);
 683 acc16= variable 0
 684 acc16+ variable 2
 685 <acc16
 686 acc8= constant 12
 687 <acc8= constant 1
 688 acc8+ constant 2
 689 /acc8 unstack8
 690 acc16= unstack16
 691 acc16CompareAcc8
 692 brgt 696
 693 acc8= constant 69
 694 call writeAcc8
 695 ;test5.p(71)   if (one+one <= (12/(1+2))) write(68);
 696 acc16= variable 0
 697 acc16+ variable 0
 698 <acc16
 699 acc8= constant 12
 700 <acc8= constant 1
 701 acc8+ constant 2
 702 /acc8 unstack8
 703 acc16= unstack16
 704 acc16CompareAcc8
 705 brgt 709
 706 acc8= constant 68
 707 call writeAcc8
 708 ;test5.p(72)   if (one+four > (12/(1+2))) write(67);
 709 acc16= variable 0
 710 acc16+ variable 4
 711 <acc16
 712 acc8= constant 12
 713 <acc8= constant 1
 714 acc8+ constant 2
 715 /acc8 unstack8
 716 acc16= unstack16
 717 acc16CompareAcc8
 718 brle 722
 719 acc8= constant 67
 720 call writeAcc8
 721 ;test5.p(73)   if (one+one < (12/(1+2))) write(66);
 722 acc16= variable 0
 723 acc16+ variable 0
 724 <acc16
 725 acc8= constant 12
 726 <acc8= constant 1
 727 acc8+ constant 2
 728 /acc8 unstack8
 729 acc16= unstack16
 730 acc16CompareAcc8
 731 brge 735
 732 acc8= constant 66
 733 call writeAcc8
 734 ;test5.p(74)   if (one+four  != (12/(1+2))) write(65);
 735 acc16= variable 0
 736 acc16+ variable 4
 737 <acc16
 738 acc8= constant 12
 739 <acc8= constant 1
 740 acc8+ constant 2
 741 /acc8 unstack8
 742 acc16= unstack16
 743 acc16CompareAcc8
 744 breq 748
 745 acc8= constant 65
 746 call writeAcc8
 747 ;test5.p(75)   if (one+three == (12/(1+2))) write(64);
 748 acc16= variable 0
 749 acc16+ variable 2
 750 <acc16
 751 acc8= constant 12
 752 <acc8= constant 1
 753 acc8+ constant 2
 754 /acc8 unstack8
 755 acc16= unstack16
 756 acc16CompareAcc8
 757 brne 763
 758 acc8= constant 64
 759 call writeAcc8
 760 ;test5.p(76)   //stack level 1
 761 ;test5.p(77)   //integer-byte
 762 ;test5.p(78)   if (four >= 4) write(63);
 763 acc16= variable 4
 764 <acc16
 765 acc16= unstack16
 766 acc8= constant 4
 767 acc16CompareAcc8
 768 brlt 772
 769 acc8= constant 63
 770 call writeAcc8
 771 ;test5.p(79)   if (four >= (12/(1+2))) write(62);
 772 acc16= variable 4
 773 <acc16
 774 acc8= constant 12
 775 <acc8= constant 1
 776 acc8+ constant 2
 777 /acc8 unstack8
 778 acc16= unstack16
 779 acc16CompareAcc8
 780 brlt 784
 781 acc8= constant 62
 782 call writeAcc8
 783 ;test5.p(80)   if (five >= 4) write(61);
 784 acc16= variable 6
 785 <acc16
 786 acc16= unstack16
 787 acc8= constant 4
 788 acc16CompareAcc8
 789 brlt 793
 790 acc8= constant 61
 791 call writeAcc8
 792 ;test5.p(81)   if (five >= (12/(1+2))) write(60);
 793 acc16= variable 6
 794 <acc16
 795 acc8= constant 12
 796 <acc8= constant 1
 797 acc8+ constant 2
 798 /acc8 unstack8
 799 acc16= unstack16
 800 acc16CompareAcc8
 801 brlt 805
 802 acc8= constant 60
 803 call writeAcc8
 804 ;test5.p(82)   if (four <= 4) write(59);
 805 acc16= variable 4
 806 <acc16
 807 acc16= unstack16
 808 acc8= constant 4
 809 acc16CompareAcc8
 810 brgt 814
 811 acc8= constant 59
 812 call writeAcc8
 813 ;test5.p(83)   if (four <= (12/(1+2))) write(58);
 814 acc16= variable 4
 815 <acc16
 816 acc8= constant 12
 817 <acc8= constant 1
 818 acc8+ constant 2
 819 /acc8 unstack8
 820 acc16= unstack16
 821 acc16CompareAcc8
 822 brgt 826
 823 acc8= constant 58
 824 call writeAcc8
 825 ;test5.p(84)   if (three <= 4) write(57);
 826 acc16= variable 2
 827 <acc16
 828 acc16= unstack16
 829 acc8= constant 4
 830 acc16CompareAcc8
 831 brgt 835
 832 acc8= constant 57
 833 call writeAcc8
 834 ;test5.p(85)   if (three <= (12/(1+2))) write(56);
 835 acc16= variable 2
 836 <acc16
 837 acc8= constant 12
 838 <acc8= constant 1
 839 acc8+ constant 2
 840 /acc8 unstack8
 841 acc16= unstack16
 842 acc16CompareAcc8
 843 brgt 847
 844 acc8= constant 56
 845 call writeAcc8
 846 ;test5.p(86)   if (five > 4) write(55);
 847 acc16= variable 6
 848 <acc16
 849 acc16= unstack16
 850 acc8= constant 4
 851 acc16CompareAcc8
 852 brle 856
 853 acc8= constant 55
 854 call writeAcc8
 855 ;test5.p(87)   if (five > (12/(1+2))) write(54);
 856 acc16= variable 6
 857 <acc16
 858 acc8= constant 12
 859 <acc8= constant 1
 860 acc8+ constant 2
 861 /acc8 unstack8
 862 acc16= unstack16
 863 acc16CompareAcc8
 864 brle 868
 865 acc8= constant 54
 866 call writeAcc8
 867 ;test5.p(88)   if (three < 4) write(53);
 868 acc16= variable 2
 869 <acc16
 870 acc16= unstack16
 871 acc8= constant 4
 872 acc16CompareAcc8
 873 brge 877
 874 acc8= constant 53
 875 call writeAcc8
 876 ;test5.p(89)   if (three < (12/(1+2))) write(52);
 877 acc16= variable 2
 878 <acc16
 879 acc8= constant 12
 880 <acc8= constant 1
 881 acc8+ constant 2
 882 /acc8 unstack8
 883 acc16= unstack16
 884 acc16CompareAcc8
 885 brge 889
 886 acc8= constant 52
 887 call writeAcc8
 888 ;test5.p(90)   if (three != 4) write(51);
 889 acc16= variable 2
 890 <acc16
 891 acc16= unstack16
 892 acc8= constant 4
 893 acc16CompareAcc8
 894 breq 898
 895 acc8= constant 51
 896 call writeAcc8
 897 ;test5.p(91)   if (three != (12/(1+2))) write(50);
 898 acc16= variable 2
 899 <acc16
 900 acc8= constant 12
 901 <acc8= constant 1
 902 acc8+ constant 2
 903 /acc8 unstack8
 904 acc16= unstack16
 905 acc16CompareAcc8
 906 breq 910
 907 acc8= constant 50
 908 call writeAcc8
 909 ;test5.p(92)   if (four == 4) write(49);
 910 acc16= variable 4
 911 <acc16
 912 acc16= unstack16
 913 acc8= constant 4
 914 acc16CompareAcc8
 915 brne 919
 916 acc8= constant 49
 917 call writeAcc8
 918 ;test5.p(93)   if (four == (12/(1+2))) write(48);
 919 acc16= variable 4
 920 <acc16
 921 acc8= constant 12
 922 <acc8= constant 1
 923 acc8+ constant 2
 924 /acc8 unstack8
 925 acc16= unstack16
 926 acc16CompareAcc8
 927 brne 932
 928 acc8= constant 48
 929 call writeAcc8
 930 ;test5.p(94)   //byte-integer
 931 ;test5.p(95)   if (4 >= four) write(47);
 932 acc16= variable 4
 933 acc8= constant 4
 934 acc8CompareAcc16
 935 brlt 939
 936 acc8= constant 47
 937 call writeAcc8
 938 ;test5.p(96)   if (4 >= (twelve/(1+2))) write(46);
 939 acc16= variable 8
 940 acc8= constant 1
 941 acc8+ constant 2
 942 acc16/ acc8
 943 acc8= constant 4
 944 acc8CompareAcc16
 945 brlt 949
 946 acc8= constant 46
 947 call writeAcc8
 948 ;test5.p(97)   if (5 >= four) write(45);
 949 acc16= variable 4
 950 acc8= constant 5
 951 acc8CompareAcc16
 952 brlt 956
 953 acc8= constant 45
 954 call writeAcc8
 955 ;test5.p(98)   if (5 >= (twelve/(1+2))) write(44);
 956 acc16= variable 8
 957 acc8= constant 1
 958 acc8+ constant 2
 959 acc16/ acc8
 960 acc8= constant 5
 961 acc8CompareAcc16
 962 brlt 966
 963 acc8= constant 44
 964 call writeAcc8
 965 ;test5.p(99)   if (4 <= four) write(43);
 966 acc16= variable 4
 967 acc8= constant 4
 968 acc8CompareAcc16
 969 brgt 973
 970 acc8= constant 43
 971 call writeAcc8
 972 ;test5.p(100)   if (4 <= (twelve/(1+2))) write(42);
 973 acc16= variable 8
 974 acc8= constant 1
 975 acc8+ constant 2
 976 acc16/ acc8
 977 acc8= constant 4
 978 acc8CompareAcc16
 979 brgt 983
 980 acc8= constant 42
 981 call writeAcc8
 982 ;test5.p(101)   if (3 <= four) write(41);
 983 acc16= variable 4
 984 acc8= constant 3
 985 acc8CompareAcc16
 986 brgt 990
 987 acc8= constant 41
 988 call writeAcc8
 989 ;test5.p(102)   if (3 <= (twelve/(1+2))) write(40);
 990 acc16= variable 8
 991 acc8= constant 1
 992 acc8+ constant 2
 993 acc16/ acc8
 994 acc8= constant 3
 995 acc8CompareAcc16
 996 brgt 1000
 997 acc8= constant 40
 998 call writeAcc8
 999 ;test5.p(103)   if (5 > four) write(39);
1000 acc16= variable 4
1001 acc8= constant 5
1002 acc8CompareAcc16
1003 brle 1007
1004 acc8= constant 39
1005 call writeAcc8
1006 ;test5.p(104)   if (5 > (twelve/(1+2))) write(38);
1007 acc16= variable 8
1008 acc8= constant 1
1009 acc8+ constant 2
1010 acc16/ acc8
1011 acc8= constant 5
1012 acc8CompareAcc16
1013 brle 1017
1014 acc8= constant 38
1015 call writeAcc8
1016 ;test5.p(105)   if (3 < four) write(37);
1017 acc16= variable 4
1018 acc8= constant 3
1019 acc8CompareAcc16
1020 brge 1024
1021 acc8= constant 37
1022 call writeAcc8
1023 ;test5.p(106)   if (3 < (twelve/(1+2))) write(36);
1024 acc16= variable 8
1025 acc8= constant 1
1026 acc8+ constant 2
1027 acc16/ acc8
1028 acc8= constant 3
1029 acc8CompareAcc16
1030 brge 1034
1031 acc8= constant 36
1032 call writeAcc8
1033 ;test5.p(107)   if (3 != four) write(35);
1034 acc16= variable 4
1035 acc8= constant 3
1036 acc8CompareAcc16
1037 breq 1041
1038 acc8= constant 35
1039 call writeAcc8
1040 ;test5.p(108)   if (3 != (twelve/(1+2))) write(34);
1041 acc16= variable 8
1042 acc8= constant 1
1043 acc8+ constant 2
1044 acc16/ acc8
1045 acc8= constant 3
1046 acc8CompareAcc16
1047 breq 1051
1048 acc8= constant 34
1049 call writeAcc8
1050 ;test5.p(109)   if (4 == four) write(33);
1051 acc16= variable 4
1052 acc8= constant 4
1053 acc8CompareAcc16
1054 brne 1058
1055 acc8= constant 33
1056 call writeAcc8
1057 ;test5.p(110)   if (4 == (twelve/(1+2))) write(32);
1058 acc16= variable 8
1059 acc8= constant 1
1060 acc8+ constant 2
1061 acc16/ acc8
1062 acc8= constant 4
1063 acc8CompareAcc16
1064 brne 1069
1065 acc8= constant 32
1066 call writeAcc8
1067 ;test5.p(111)   //integer-integer
1068 ;test5.p(112)   if (400 >= 400) write(31);
1069 acc16= constant 400
1070 acc16Comp constant 400
1071 brlt 1075
1072 acc8= constant 31
1073 call writeAcc8
1074 ;test5.p(113)   if (400 >= (1200/(1+2))) write(30);
1075 acc16= constant 1200
1076 acc8= constant 1
1077 acc8+ constant 2
1078 acc16/ acc8
1079 acc16Comp constant 400
1080 brgt 1084
1081 acc8= constant 30
1082 call writeAcc8
1083 ;test5.p(114)   if (500 >= 400) write(29);
1084 acc16= constant 500
1085 acc16Comp constant 400
1086 brlt 1090
1087 acc8= constant 29
1088 call writeAcc8
1089 ;test5.p(115)   if (500 >= (1200/(1+2))) write(28);
1090 acc16= constant 1200
1091 acc8= constant 1
1092 acc8+ constant 2
1093 acc16/ acc8
1094 acc16Comp constant 500
1095 brgt 1099
1096 acc8= constant 28
1097 call writeAcc8
1098 ;test5.p(116)   if (400 <= 400) write(27);
1099 acc16= constant 400
1100 acc16Comp constant 400
1101 brgt 1105
1102 acc8= constant 27
1103 call writeAcc8
1104 ;test5.p(117)   if (400 <= (1200/(1+2))) write(26);
1105 acc16= constant 1200
1106 acc8= constant 1
1107 acc8+ constant 2
1108 acc16/ acc8
1109 acc16Comp constant 400
1110 brlt 1114
1111 acc8= constant 26
1112 call writeAcc8
1113 ;test5.p(118)   if (300 <= 400) write(25);
1114 acc16= constant 300
1115 acc16Comp constant 400
1116 brgt 1120
1117 acc8= constant 25
1118 call writeAcc8
1119 ;test5.p(119)   if (300 <= (1200/(1+2))) write(24);
1120 acc16= constant 1200
1121 acc8= constant 1
1122 acc8+ constant 2
1123 acc16/ acc8
1124 acc16Comp constant 300
1125 brlt 1129
1126 acc8= constant 24
1127 call writeAcc8
1128 ;test5.p(120)   if (500 > 400) write(23);
1129 acc16= constant 500
1130 acc16Comp constant 400
1131 brle 1135
1132 acc8= constant 23
1133 call writeAcc8
1134 ;test5.p(121)   if (500 > (1200/(1+2))) write(22);
1135 acc16= constant 1200
1136 acc8= constant 1
1137 acc8+ constant 2
1138 acc16/ acc8
1139 acc16Comp constant 500
1140 brge 1144
1141 acc8= constant 22
1142 call writeAcc8
1143 ;test5.p(122)   if (300 < 400) write(21);
1144 acc16= constant 300
1145 acc16Comp constant 400
1146 brge 1150
1147 acc8= constant 21
1148 call writeAcc8
1149 ;test5.p(123)   if (300 < (1200/(1+2))) write(20);
1150 acc16= constant 1200
1151 acc8= constant 1
1152 acc8+ constant 2
1153 acc16/ acc8
1154 acc16Comp constant 300
1155 brle 1159
1156 acc8= constant 20
1157 call writeAcc8
1158 ;test5.p(124)   if (300 != 400) write(19);
1159 acc16= constant 300
1160 acc16Comp constant 400
1161 breq 1165
1162 acc8= constant 19
1163 call writeAcc8
1164 ;test5.p(125)   if (300 != (1200/(1+2))) write(18);
1165 acc16= constant 1200
1166 acc8= constant 1
1167 acc8+ constant 2
1168 acc16/ acc8
1169 acc16Comp constant 300
1170 breq 1174
1171 acc8= constant 18
1172 call writeAcc8
1173 ;test5.p(126)   if (400 == 400) write(17);
1174 acc16= constant 400
1175 acc16Comp constant 400
1176 brne 1180
1177 acc8= constant 17
1178 call writeAcc8
1179 ;test5.p(127)   if (400 == (1200/(1+2))) write(16);
1180 acc16= constant 1200
1181 acc8= constant 1
1182 acc8+ constant 2
1183 acc16/ acc8
1184 acc16Comp constant 400
1185 brne 1190
1186 acc8= constant 16
1187 call writeAcc8
1188 ;test5.p(128)   //byte-byte
1189 ;test5.p(129)   if (4 >= 4) write(15);
1190 acc8= constant 4
1191 acc8Comp constant 4
1192 brlt 1196
1193 acc8= constant 15
1194 call writeAcc8
1195 ;test5.p(130)   if (4 >= (12/(1+2))) write(14);
1196 acc8= constant 12
1197 <acc8= constant 1
1198 acc8+ constant 2
1199 /acc8 unstack8
1200 acc8Comp constant 4
1201 brgt 1205
1202 acc8= constant 14
1203 call writeAcc8
1204 ;test5.p(131)   if (5 >= 4) write(13);
1205 acc8= constant 5
1206 acc8Comp constant 4
1207 brlt 1211
1208 acc8= constant 13
1209 call writeAcc8
1210 ;test5.p(132)   if (5 >= (12/(1+2))) write(12);
1211 acc8= constant 12
1212 <acc8= constant 1
1213 acc8+ constant 2
1214 /acc8 unstack8
1215 acc8Comp constant 5
1216 brgt 1220
1217 acc8= constant 12
1218 call writeAcc8
1219 ;test5.p(133)   if (4 <= 4) write(11);
1220 acc8= constant 4
1221 acc8Comp constant 4
1222 brgt 1226
1223 acc8= constant 11
1224 call writeAcc8
1225 ;test5.p(134)   if (4 <= (12/(1+2))) write(10);
1226 acc8= constant 12
1227 <acc8= constant 1
1228 acc8+ constant 2
1229 /acc8 unstack8
1230 acc8Comp constant 4
1231 brlt 1235
1232 acc8= constant 10
1233 call writeAcc8
1234 ;test5.p(135)   if (3 <= 4) write(9);
1235 acc8= constant 3
1236 acc8Comp constant 4
1237 brgt 1241
1238 acc8= constant 9
1239 call writeAcc8
1240 ;test5.p(136)   if (3 <= (12/(1+2))) write(8);
1241 acc8= constant 12
1242 <acc8= constant 1
1243 acc8+ constant 2
1244 /acc8 unstack8
1245 acc8Comp constant 3
1246 brlt 1250
1247 acc8= constant 8
1248 call writeAcc8
1249 ;test5.p(137)   if (5 > 4) write(7);
1250 acc8= constant 5
1251 acc8Comp constant 4
1252 brle 1256
1253 acc8= constant 7
1254 call writeAcc8
1255 ;test5.p(138)   if (5 > (12/(1+2))) write(6);
1256 acc8= constant 12
1257 <acc8= constant 1
1258 acc8+ constant 2
1259 /acc8 unstack8
1260 acc8Comp constant 5
1261 brge 1265
1262 acc8= constant 6
1263 call writeAcc8
1264 ;test5.p(139)   if (3 < 4) write(5);
1265 acc8= constant 3
1266 acc8Comp constant 4
1267 brge 1271
1268 acc8= constant 5
1269 call writeAcc8
1270 ;test5.p(140)   if (3 < (12/(1+2))) write(4);
1271 acc8= constant 12
1272 <acc8= constant 1
1273 acc8+ constant 2
1274 /acc8 unstack8
1275 acc8Comp constant 3
1276 brle 1280
1277 acc8= constant 4
1278 call writeAcc8
1279 ;test5.p(141)   if (3 != 4) write(3);
1280 acc8= constant 3
1281 acc8Comp constant 4
1282 breq 1286
1283 acc8= constant 3
1284 call writeAcc8
1285 ;test5.p(142)   if (3 != (12/(1+2))) write(2);
1286 acc8= constant 12
1287 <acc8= constant 1
1288 acc8+ constant 2
1289 /acc8 unstack8
1290 acc8Comp constant 3
1291 breq 1295
1292 acc8= constant 2
1293 call writeAcc8
1294 ;test5.p(143)   if (4 == 4) write(1);
1295 acc8= constant 4
1296 acc8Comp constant 4
1297 brne 1301
1298 acc8= constant 1
1299 call writeAcc8
1300 ;test5.p(144)   if (4 == (12/(1+2))) write(0);
1301 acc8= constant 12
1302 <acc8= constant 1
1303 acc8+ constant 2
1304 /acc8 unstack8
1305 acc8Comp constant 4
1306 brne 1310
1307 acc8= constant 0
1308 call writeAcc8
1309 ;test5.p(145) }
1310 stop
