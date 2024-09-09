   0 call 9
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
  32 br 36
  33 ;testComparison.j(13)   private static byte b;
  34 ;testComparison.j(14)   
  35 ;testComparison.j(15)   public static void main() {
  36 method TestComparison.main [public, static] void ()
  37 <basePointer
  38 basePointer= stackPointer
  39 stackPointer+ constant 4
  40 ;testComparison.j(16)     //stack level 1
  41 ;testComparison.j(17)     //byte-byte
  42 ;testComparison.j(18)     if (4 == 12/(1+2)) println(0);
  43 acc8= constant 12
  44 <acc8= constant 1
  45 acc8+ constant 2
  46 /acc8 unstack8
  47 acc8Comp constant 4
  48 brne 52
  49 acc8= constant 0
  50 writeLineAcc8
  51 ;testComparison.j(19)     if (4 == 4) println(1);
  52 acc8= constant 4
  53 acc8Comp constant 4
  54 brne 58
  55 acc8= constant 1
  56 writeLineAcc8
  57 ;testComparison.j(20)     if (3 != 12/(1+2)) println(2);
  58 acc8= constant 12
  59 <acc8= constant 1
  60 acc8+ constant 2
  61 /acc8 unstack8
  62 acc8Comp constant 3
  63 breq 67
  64 acc8= constant 2
  65 writeLineAcc8
  66 ;testComparison.j(21)     if (3 != 4) println(3);
  67 acc8= constant 3
  68 acc8Comp constant 4
  69 breq 73
  70 acc8= constant 3
  71 writeLineAcc8
  72 ;testComparison.j(22)     if (3 < 12/(1+2)) println(4);
  73 acc8= constant 12
  74 <acc8= constant 1
  75 acc8+ constant 2
  76 /acc8 unstack8
  77 acc8Comp constant 3
  78 brle 82
  79 acc8= constant 4
  80 writeLineAcc8
  81 ;testComparison.j(23)     if (3 < 4) println(5);
  82 acc8= constant 3
  83 acc8Comp constant 4
  84 brge 88
  85 acc8= constant 5
  86 writeLineAcc8
  87 ;testComparison.j(24)     if (5 > 12/(1+2)) println(6);
  88 acc8= constant 12
  89 <acc8= constant 1
  90 acc8+ constant 2
  91 /acc8 unstack8
  92 acc8Comp constant 5
  93 brge 97
  94 acc8= constant 6
  95 writeLineAcc8
  96 ;testComparison.j(25)     if (5 > 4) println(7);
  97 acc8= constant 5
  98 acc8Comp constant 4
  99 brle 103
 100 acc8= constant 7
 101 writeLineAcc8
 102 ;testComparison.j(26)     if (3 <= 12/(1+2)) println(8);
 103 acc8= constant 12
 104 <acc8= constant 1
 105 acc8+ constant 2
 106 /acc8 unstack8
 107 acc8Comp constant 3
 108 brlt 112
 109 acc8= constant 8
 110 writeLineAcc8
 111 ;testComparison.j(27)     if (3 <= 4) println(9);
 112 acc8= constant 3
 113 acc8Comp constant 4
 114 brgt 118
 115 acc8= constant 9
 116 writeLineAcc8
 117 ;testComparison.j(28)     if (4 <= 12/(1+2)) println(10);
 118 acc8= constant 12
 119 <acc8= constant 1
 120 acc8+ constant 2
 121 /acc8 unstack8
 122 acc8Comp constant 4
 123 brlt 127
 124 acc8= constant 10
 125 writeLineAcc8
 126 ;testComparison.j(29)     if (4 <= 4) println(11);
 127 acc8= constant 4
 128 acc8Comp constant 4
 129 brgt 133
 130 acc8= constant 11
 131 writeLineAcc8
 132 ;testComparison.j(30)     if (5 >= 12/(1+2)) println(12);
 133 acc8= constant 12
 134 <acc8= constant 1
 135 acc8+ constant 2
 136 /acc8 unstack8
 137 acc8Comp constant 5
 138 brgt 142
 139 acc8= constant 12
 140 writeLineAcc8
 141 ;testComparison.j(31)     if (5 >= 4) println(13);
 142 acc8= constant 5
 143 acc8Comp constant 4
 144 brlt 148
 145 acc8= constant 13
 146 writeLineAcc8
 147 ;testComparison.j(32)     if (4 >= 12/(1+2)) println(14);
 148 acc8= constant 12
 149 <acc8= constant 1
 150 acc8+ constant 2
 151 /acc8 unstack8
 152 acc8Comp constant 4
 153 brgt 157
 154 acc8= constant 14
 155 writeLineAcc8
 156 ;testComparison.j(33)     if (4 >= 4) println(15);
 157 acc8= constant 4
 158 acc8Comp constant 4
 159 brlt 165
 160 acc8= constant 15
 161 writeLineAcc8
 162 ;testComparison.j(34)     //stack level 1
 163 ;testComparison.j(35)     //byte-integer
 164 ;testComparison.j(36)     if (4 == twelve/(1+2)) println(16);
 165 acc16= variable 10
 166 acc8= constant 1
 167 acc8+ constant 2
 168 acc16/ acc8
 169 acc8= constant 4
 170 acc8CompareAcc16
 171 brne 175
 172 acc8= constant 16
 173 writeLineAcc8
 174 ;testComparison.j(37)     if (4 == four) println(17);
 175 acc16= variable 6
 176 acc8= constant 4
 177 acc8CompareAcc16
 178 brne 182
 179 acc8= constant 17
 180 writeLineAcc8
 181 ;testComparison.j(38)     if (3 != twelve/(1+2)) println(18);
 182 acc16= variable 10
 183 acc8= constant 1
 184 acc8+ constant 2
 185 acc16/ acc8
 186 acc8= constant 3
 187 acc8CompareAcc16
 188 breq 192
 189 acc8= constant 18
 190 writeLineAcc8
 191 ;testComparison.j(39)     if (3 != four) println(19);
 192 acc16= variable 6
 193 acc8= constant 3
 194 acc8CompareAcc16
 195 breq 199
 196 acc8= constant 19
 197 writeLineAcc8
 198 ;testComparison.j(40)     if (3 < twelve/(1+2)) println(20);
 199 acc16= variable 10
 200 acc8= constant 1
 201 acc8+ constant 2
 202 acc16/ acc8
 203 acc8= constant 3
 204 acc8CompareAcc16
 205 brge 209
 206 acc8= constant 20
 207 writeLineAcc8
 208 ;testComparison.j(41)     if (3 < four) println(21);
 209 acc16= variable 6
 210 acc8= constant 3
 211 acc8CompareAcc16
 212 brge 216
 213 acc8= constant 21
 214 writeLineAcc8
 215 ;testComparison.j(42)     if (5 > twelve/(1+2)) println(22);
 216 acc16= variable 10
 217 acc8= constant 1
 218 acc8+ constant 2
 219 acc16/ acc8
 220 acc8= constant 5
 221 acc8CompareAcc16
 222 brle 226
 223 acc8= constant 22
 224 writeLineAcc8
 225 ;testComparison.j(43)     if (5 > four) println(23);
 226 acc16= variable 6
 227 acc8= constant 5
 228 acc8CompareAcc16
 229 brle 233
 230 acc8= constant 23
 231 writeLineAcc8
 232 ;testComparison.j(44)     if (3 <= twelve/(1+2)) println(24);
 233 acc16= variable 10
 234 acc8= constant 1
 235 acc8+ constant 2
 236 acc16/ acc8
 237 acc8= constant 3
 238 acc8CompareAcc16
 239 brgt 243
 240 acc8= constant 24
 241 writeLineAcc8
 242 ;testComparison.j(45)     if (3 <= four) println(25);
 243 acc16= variable 6
 244 acc8= constant 3
 245 acc8CompareAcc16
 246 brgt 250
 247 acc8= constant 25
 248 writeLineAcc8
 249 ;testComparison.j(46)     if (4 <= twelve/(1+2)) println(26);
 250 acc16= variable 10
 251 acc8= constant 1
 252 acc8+ constant 2
 253 acc16/ acc8
 254 acc8= constant 4
 255 acc8CompareAcc16
 256 brgt 260
 257 acc8= constant 26
 258 writeLineAcc8
 259 ;testComparison.j(47)     if (4 <= four) println(27);
 260 acc16= variable 6
 261 acc8= constant 4
 262 acc8CompareAcc16
 263 brgt 267
 264 acc8= constant 27
 265 writeLineAcc8
 266 ;testComparison.j(48)     if (5 >= twelve/(1+2)) println(28);
 267 acc16= variable 10
 268 acc8= constant 1
 269 acc8+ constant 2
 270 acc16/ acc8
 271 acc8= constant 5
 272 acc8CompareAcc16
 273 brlt 277
 274 acc8= constant 28
 275 writeLineAcc8
 276 ;testComparison.j(49)     if (5 >= four) println(29);
 277 acc16= variable 6
 278 acc8= constant 5
 279 acc8CompareAcc16
 280 brlt 284
 281 acc8= constant 29
 282 writeLineAcc8
 283 ;testComparison.j(50)     if (4 >= twelve/(1+2)) println(30);
 284 acc16= variable 10
 285 acc8= constant 1
 286 acc8+ constant 2
 287 acc16/ acc8
 288 acc8= constant 4
 289 acc8CompareAcc16
 290 brlt 294
 291 acc8= constant 30
 292 writeLineAcc8
 293 ;testComparison.j(51)     if (4 >= four) println(31);
 294 acc16= variable 6
 295 acc8= constant 4
 296 acc8CompareAcc16
 297 brlt 303
 298 acc8= constant 31
 299 writeLineAcc8
 300 ;testComparison.j(52)     //stack level 1
 301 ;testComparison.j(53)     //integer-byte
 302 ;testComparison.j(54)     if (four == 12/(1+2)) println(32);
 303 acc8= constant 12
 304 <acc8= constant 1
 305 acc8+ constant 2
 306 /acc8 unstack8
 307 acc16= variable 6
 308 acc16CompareAcc8
 309 brne 313
 310 acc8= constant 32
 311 writeLineAcc8
 312 ;testComparison.j(55)     if (four == 4) println(33);
 313 acc16= variable 6
 314 acc8= constant 4
 315 acc16CompareAcc8
 316 brne 320
 317 acc8= constant 33
 318 writeLineAcc8
 319 ;testComparison.j(56)     if (three != 12/(1+2)) println(34);
 320 acc8= constant 12
 321 <acc8= constant 1
 322 acc8+ constant 2
 323 /acc8 unstack8
 324 acc16= variable 4
 325 acc16CompareAcc8
 326 breq 330
 327 acc8= constant 34
 328 writeLineAcc8
 329 ;testComparison.j(57)     if (three != 4) println(35);
 330 acc16= variable 4
 331 acc8= constant 4
 332 acc16CompareAcc8
 333 breq 337
 334 acc8= constant 35
 335 writeLineAcc8
 336 ;testComparison.j(58)     if (three < 12/(1+2)) println(36);
 337 acc8= constant 12
 338 <acc8= constant 1
 339 acc8+ constant 2
 340 /acc8 unstack8
 341 acc16= variable 4
 342 acc16CompareAcc8
 343 brge 347
 344 acc8= constant 36
 345 writeLineAcc8
 346 ;testComparison.j(59)     if (three < 4) println(37);
 347 acc16= variable 4
 348 acc8= constant 4
 349 acc16CompareAcc8
 350 brge 354
 351 acc8= constant 37
 352 writeLineAcc8
 353 ;testComparison.j(60)     if (five > 12/(1+2)) println(38);
 354 acc8= constant 12
 355 <acc8= constant 1
 356 acc8+ constant 2
 357 /acc8 unstack8
 358 acc16= variable 8
 359 acc16CompareAcc8
 360 brle 364
 361 acc8= constant 38
 362 writeLineAcc8
 363 ;testComparison.j(61)     if (five > 4) println(39);
 364 acc16= variable 8
 365 acc8= constant 4
 366 acc16CompareAcc8
 367 brle 371
 368 acc8= constant 39
 369 writeLineAcc8
 370 ;testComparison.j(62)     if (three <= 12/(1+2)) println(40);
 371 acc8= constant 12
 372 <acc8= constant 1
 373 acc8+ constant 2
 374 /acc8 unstack8
 375 acc16= variable 4
 376 acc16CompareAcc8
 377 brgt 381
 378 acc8= constant 40
 379 writeLineAcc8
 380 ;testComparison.j(63)     if (three <= 4) println(41);
 381 acc16= variable 4
 382 acc8= constant 4
 383 acc16CompareAcc8
 384 brgt 388
 385 acc8= constant 41
 386 writeLineAcc8
 387 ;testComparison.j(64)     if (four <= 12/(1+2)) println(42);
 388 acc8= constant 12
 389 <acc8= constant 1
 390 acc8+ constant 2
 391 /acc8 unstack8
 392 acc16= variable 6
 393 acc16CompareAcc8
 394 brgt 398
 395 acc8= constant 42
 396 writeLineAcc8
 397 ;testComparison.j(65)     if (four <= 4) println(43);
 398 acc16= variable 6
 399 acc8= constant 4
 400 acc16CompareAcc8
 401 brgt 405
 402 acc8= constant 43
 403 writeLineAcc8
 404 ;testComparison.j(66)     if (five >= 12/(1+2)) println(44);
 405 acc8= constant 12
 406 <acc8= constant 1
 407 acc8+ constant 2
 408 /acc8 unstack8
 409 acc16= variable 8
 410 acc16CompareAcc8
 411 brlt 415
 412 acc8= constant 44
 413 writeLineAcc8
 414 ;testComparison.j(67)     if (five >= 4) println(45);
 415 acc16= variable 8
 416 acc8= constant 4
 417 acc16CompareAcc8
 418 brlt 422
 419 acc8= constant 45
 420 writeLineAcc8
 421 ;testComparison.j(68)     if (four >= 12/(1+2)) println(46);
 422 acc8= constant 12
 423 <acc8= constant 1
 424 acc8+ constant 2
 425 /acc8 unstack8
 426 acc16= variable 6
 427 acc16CompareAcc8
 428 brlt 432
 429 acc8= constant 46
 430 writeLineAcc8
 431 ;testComparison.j(69)     if (four >= 4) println(47);
 432 acc16= variable 6
 433 acc8= constant 4
 434 acc16CompareAcc8
 435 brlt 441
 436 acc8= constant 47
 437 writeLineAcc8
 438 ;testComparison.j(70)     //stack level 1
 439 ;testComparison.j(71)     //integer-integer
 440 ;testComparison.j(72)     if (400 == 1200/(1+2)) println(48);
 441 acc16= constant 1200
 442 acc8= constant 1
 443 acc8+ constant 2
 444 acc16/ acc8
 445 acc16Comp constant 400
 446 brne 450
 447 acc8= constant 48
 448 writeLineAcc8
 449 ;testComparison.j(73)     if (400 == 400) println(49);
 450 acc16= constant 400
 451 acc16Comp constant 400
 452 brne 456
 453 acc8= constant 49
 454 writeLineAcc8
 455 ;testComparison.j(74)     if (300 != 1200/(1+2)) println(50);
 456 acc16= constant 1200
 457 acc8= constant 1
 458 acc8+ constant 2
 459 acc16/ acc8
 460 acc16Comp constant 300
 461 breq 465
 462 acc8= constant 50
 463 writeLineAcc8
 464 ;testComparison.j(75)     if (300 != 400) println(51);
 465 acc16= constant 300
 466 acc16Comp constant 400
 467 breq 471
 468 acc8= constant 51
 469 writeLineAcc8
 470 ;testComparison.j(76)     if (300 < 1200/(1+2)) println(52);
 471 acc16= constant 1200
 472 acc8= constant 1
 473 acc8+ constant 2
 474 acc16/ acc8
 475 acc16Comp constant 300
 476 brle 480
 477 acc8= constant 52
 478 writeLineAcc8
 479 ;testComparison.j(77)     if (300 < 400) println(53);
 480 acc16= constant 300
 481 acc16Comp constant 400
 482 brge 486
 483 acc8= constant 53
 484 writeLineAcc8
 485 ;testComparison.j(78)     if (500 > 1200/(1+2)) println(54);
 486 acc16= constant 1200
 487 acc8= constant 1
 488 acc8+ constant 2
 489 acc16/ acc8
 490 acc16Comp constant 500
 491 brge 495
 492 acc8= constant 54
 493 writeLineAcc8
 494 ;testComparison.j(79)     if (500 > 400) println(55);
 495 acc16= constant 500
 496 acc16Comp constant 400
 497 brle 501
 498 acc8= constant 55
 499 writeLineAcc8
 500 ;testComparison.j(80)     if (300 <= 1200/(1+2)) println(56);
 501 acc16= constant 1200
 502 acc8= constant 1
 503 acc8+ constant 2
 504 acc16/ acc8
 505 acc16Comp constant 300
 506 brlt 510
 507 acc8= constant 56
 508 writeLineAcc8
 509 ;testComparison.j(81)     if (300 <= 400) println(57);
 510 acc16= constant 300
 511 acc16Comp constant 400
 512 brgt 516
 513 acc8= constant 57
 514 writeLineAcc8
 515 ;testComparison.j(82)     if (400 <= 1200/(1+2)) println(58);
 516 acc16= constant 1200
 517 acc8= constant 1
 518 acc8+ constant 2
 519 acc16/ acc8
 520 acc16Comp constant 400
 521 brlt 525
 522 acc8= constant 58
 523 writeLineAcc8
 524 ;testComparison.j(83)     if (400 <= 400) println(59);
 525 acc16= constant 400
 526 acc16Comp constant 400
 527 brgt 531
 528 acc8= constant 59
 529 writeLineAcc8
 530 ;testComparison.j(84)     if (500 >= 1200/(1+2)) println(60);
 531 acc16= constant 1200
 532 acc8= constant 1
 533 acc8+ constant 2
 534 acc16/ acc8
 535 acc16Comp constant 500
 536 brgt 540
 537 acc8= constant 60
 538 writeLineAcc8
 539 ;testComparison.j(85)     if (500 >= 400) println(61);
 540 acc16= constant 500
 541 acc16Comp constant 400
 542 brlt 546
 543 acc8= constant 61
 544 writeLineAcc8
 545 ;testComparison.j(86)     if (400 >= 1200/(1+2)) println(62);
 546 acc16= constant 1200
 547 acc8= constant 1
 548 acc8+ constant 2
 549 acc16/ acc8
 550 acc16Comp constant 400
 551 brgt 555
 552 acc8= constant 62
 553 writeLineAcc8
 554 ;testComparison.j(87)     if (400 >= 400) println(63);
 555 acc16= constant 400
 556 acc16Comp constant 400
 557 brlt 563
 558 acc8= constant 63
 559 writeLineAcc8
 560 ;testComparison.j(88)   
 561 ;testComparison.j(89)     //stack level 2
 562 ;testComparison.j(90)     if (one+three == 12/(1+2)) println(64);
 563 acc16= variable 2
 564 acc16+ variable 4
 565 <acc16
 566 acc8= constant 12
 567 <acc8= constant 1
 568 acc8+ constant 2
 569 /acc8 unstack8
 570 acc16<
 571 acc16CompareAcc8
 572 brne 576
 573 acc8= constant 64
 574 writeLineAcc8
 575 ;testComparison.j(91)     if (one+four  != 12/(1+2)) println(65);
 576 acc16= variable 2
 577 acc16+ variable 6
 578 <acc16
 579 acc8= constant 12
 580 <acc8= constant 1
 581 acc8+ constant 2
 582 /acc8 unstack8
 583 acc16<
 584 acc16CompareAcc8
 585 breq 589
 586 acc8= constant 65
 587 writeLineAcc8
 588 ;testComparison.j(92)     if (one+one < 12/(1+2)) println(66);
 589 acc16= variable 2
 590 acc16+ variable 2
 591 <acc16
 592 acc8= constant 12
 593 <acc8= constant 1
 594 acc8+ constant 2
 595 /acc8 unstack8
 596 acc16<
 597 acc16CompareAcc8
 598 brge 602
 599 acc8= constant 66
 600 writeLineAcc8
 601 ;testComparison.j(93)     if (one+four > 12/(1+2)) println(67);
 602 acc16= variable 2
 603 acc16+ variable 6
 604 <acc16
 605 acc8= constant 12
 606 <acc8= constant 1
 607 acc8+ constant 2
 608 /acc8 unstack8
 609 acc16<
 610 acc16CompareAcc8
 611 brle 615
 612 acc8= constant 67
 613 writeLineAcc8
 614 ;testComparison.j(94)     if (one+one <= 12/(1+2)) println(68);
 615 acc16= variable 2
 616 acc16+ variable 2
 617 <acc16
 618 acc8= constant 12
 619 <acc8= constant 1
 620 acc8+ constant 2
 621 /acc8 unstack8
 622 acc16<
 623 acc16CompareAcc8
 624 brgt 628
 625 acc8= constant 68
 626 writeLineAcc8
 627 ;testComparison.j(95)     if (one+three <= 12/(1+2)) println(69);
 628 acc16= variable 2
 629 acc16+ variable 4
 630 <acc16
 631 acc8= constant 12
 632 <acc8= constant 1
 633 acc8+ constant 2
 634 /acc8 unstack8
 635 acc16<
 636 acc16CompareAcc8
 637 brgt 641
 638 acc8= constant 69
 639 writeLineAcc8
 640 ;testComparison.j(96)     if (one+three >= 12/(1+2)) println(70);
 641 acc16= variable 2
 642 acc16+ variable 4
 643 <acc16
 644 acc8= constant 12
 645 <acc8= constant 1
 646 acc8+ constant 2
 647 /acc8 unstack8
 648 acc16<
 649 acc16CompareAcc8
 650 brlt 654
 651 acc8= constant 70
 652 writeLineAcc8
 653 ;testComparison.j(97)     if (one+four >= 12/(1+2)) println(71);
 654 acc16= variable 2
 655 acc16+ variable 6
 656 <acc16
 657 acc8= constant 12
 658 <acc8= constant 1
 659 acc8+ constant 2
 660 /acc8 unstack8
 661 acc16<
 662 acc16CompareAcc8
 663 brlt 667
 664 acc8= constant 71
 665 writeLineAcc8
 666 ;testComparison.j(98)     if (one+three == twelve/(one+2)) println(72);
 667 acc16= variable 2
 668 acc16+ variable 4
 669 <acc16
 670 acc16= variable 10
 671 <acc16= variable 2
 672 acc16+ constant 2
 673 /acc16 unstack16
 674 revAcc16Comp unstack16
 675 brne 679
 676 acc8= constant 72
 677 writeLineAcc8
 678 ;testComparison.j(99)     if (one+four  != twelve/(one+2)) println(73);
 679 acc16= variable 2
 680 acc16+ variable 6
 681 <acc16
 682 acc16= variable 10
 683 <acc16= variable 2
 684 acc16+ constant 2
 685 /acc16 unstack16
 686 revAcc16Comp unstack16
 687 breq 691
 688 acc8= constant 73
 689 writeLineAcc8
 690 ;testComparison.j(100)     if (one+one < twelve/(one+2)) println(74);
 691 acc16= variable 2
 692 acc16+ variable 2
 693 <acc16
 694 acc16= variable 10
 695 <acc16= variable 2
 696 acc16+ constant 2
 697 /acc16 unstack16
 698 revAcc16Comp unstack16
 699 brle 703
 700 acc8= constant 74
 701 writeLineAcc8
 702 ;testComparison.j(101)     if (one+four > twelve/(one+2)) println(75);
 703 acc16= variable 2
 704 acc16+ variable 6
 705 <acc16
 706 acc16= variable 10
 707 <acc16= variable 2
 708 acc16+ constant 2
 709 /acc16 unstack16
 710 revAcc16Comp unstack16
 711 brge 715
 712 acc8= constant 75
 713 writeLineAcc8
 714 ;testComparison.j(102)     if (one+one <= twelve/(one+2)) println(76);
 715 acc16= variable 2
 716 acc16+ variable 2
 717 <acc16
 718 acc16= variable 10
 719 <acc16= variable 2
 720 acc16+ constant 2
 721 /acc16 unstack16
 722 revAcc16Comp unstack16
 723 brlt 727
 724 acc8= constant 76
 725 writeLineAcc8
 726 ;testComparison.j(103)     if (one+three <= twelve/(one+2)) println(77);
 727 acc16= variable 2
 728 acc16+ variable 4
 729 <acc16
 730 acc16= variable 10
 731 <acc16= variable 2
 732 acc16+ constant 2
 733 /acc16 unstack16
 734 revAcc16Comp unstack16
 735 brlt 739
 736 acc8= constant 77
 737 writeLineAcc8
 738 ;testComparison.j(104)     if (one+three >= twelve/(one+2)) println(78);
 739 acc16= variable 2
 740 acc16+ variable 4
 741 <acc16
 742 acc16= variable 10
 743 <acc16= variable 2
 744 acc16+ constant 2
 745 /acc16 unstack16
 746 revAcc16Comp unstack16
 747 brgt 751
 748 acc8= constant 78
 749 writeLineAcc8
 750 ;testComparison.j(105)     if (one+four >= twelve/(one+2)) println(79);
 751 acc16= variable 2
 752 acc16+ variable 6
 753 <acc16
 754 acc16= variable 10
 755 <acc16= variable 2
 756 acc16+ constant 2
 757 /acc16 unstack16
 758 revAcc16Comp unstack16
 759 brgt 763
 760 acc8= constant 79
 761 writeLineAcc8
 762 ;testComparison.j(106)     if (four == 12/(1+2)) println(80);
 763 acc8= constant 12
 764 <acc8= constant 1
 765 acc8+ constant 2
 766 /acc8 unstack8
 767 acc16= variable 6
 768 acc16CompareAcc8
 769 brne 773
 770 acc8= constant 80
 771 writeLineAcc8
 772 ;testComparison.j(107)     if (three != 12/(1+2)) println(81);
 773 acc8= constant 12
 774 <acc8= constant 1
 775 acc8+ constant 2
 776 /acc8 unstack8
 777 acc16= variable 4
 778 acc16CompareAcc8
 779 breq 783
 780 acc8= constant 81
 781 writeLineAcc8
 782 ;testComparison.j(108)     if (three < 12/(1+2)) println(82);
 783 acc8= constant 12
 784 <acc8= constant 1
 785 acc8+ constant 2
 786 /acc8 unstack8
 787 acc16= variable 4
 788 acc16CompareAcc8
 789 brge 793
 790 acc8= constant 82
 791 writeLineAcc8
 792 ;testComparison.j(109)     if (twelve > 12/(1+2)) println(83);
 793 acc8= constant 12
 794 <acc8= constant 1
 795 acc8+ constant 2
 796 /acc8 unstack8
 797 acc16= variable 10
 798 acc16CompareAcc8
 799 brle 803
 800 acc8= constant 83
 801 writeLineAcc8
 802 ;testComparison.j(110)     if (four <= 12/(1+2)) println(84);
 803 acc8= constant 12
 804 <acc8= constant 1
 805 acc8+ constant 2
 806 /acc8 unstack8
 807 acc16= variable 6
 808 acc16CompareAcc8
 809 brgt 813
 810 acc8= constant 84
 811 writeLineAcc8
 812 ;testComparison.j(111)     if (three <= 12/(1+2)) println(85);
 813 acc8= constant 12
 814 <acc8= constant 1
 815 acc8+ constant 2
 816 /acc8 unstack8
 817 acc16= variable 4
 818 acc16CompareAcc8
 819 brgt 823
 820 acc8= constant 85
 821 writeLineAcc8
 822 ;testComparison.j(112)     if (four >= 12/(1+2)) println(86);
 823 acc8= constant 12
 824 <acc8= constant 1
 825 acc8+ constant 2
 826 /acc8 unstack8
 827 acc16= variable 6
 828 acc16CompareAcc8
 829 brlt 833
 830 acc8= constant 86
 831 writeLineAcc8
 832 ;testComparison.j(113)     if (twelve >= 12/(1+2)) println(87);
 833 acc8= constant 12
 834 <acc8= constant 1
 835 acc8+ constant 2
 836 /acc8 unstack8
 837 acc16= variable 10
 838 acc16CompareAcc8
 839 brlt 843
 840 acc8= constant 87
 841 writeLineAcc8
 842 ;testComparison.j(114)     if (four == twelve/(one+2)) println(88);
 843 acc16= variable 10
 844 <acc16= variable 2
 845 acc16+ constant 2
 846 /acc16 unstack16
 847 acc16Comp variable 6
 848 brne 852
 849 acc8= constant 88
 850 writeLineAcc8
 851 ;testComparison.j(115)     if (three != twelve/(one+2)) println(89);
 852 acc16= variable 10
 853 <acc16= variable 2
 854 acc16+ constant 2
 855 /acc16 unstack16
 856 acc16Comp variable 4
 857 breq 861
 858 acc8= constant 89
 859 writeLineAcc8
 860 ;testComparison.j(116)     if (three < twelve/(one+2)) println(90);
 861 acc16= variable 10
 862 <acc16= variable 2
 863 acc16+ constant 2
 864 /acc16 unstack16
 865 acc16Comp variable 4
 866 brle 870
 867 acc8= constant 90
 868 writeLineAcc8
 869 ;testComparison.j(117)     if (twelve > twelve/(one+2)) println(91);
 870 acc16= variable 10
 871 <acc16= variable 2
 872 acc16+ constant 2
 873 /acc16 unstack16
 874 acc16Comp variable 10
 875 brge 879
 876 acc8= constant 91
 877 writeLineAcc8
 878 ;testComparison.j(118)     if (four <= twelve/(one+2)) println(92);
 879 acc16= variable 10
 880 <acc16= variable 2
 881 acc16+ constant 2
 882 /acc16 unstack16
 883 acc16Comp variable 6
 884 brlt 888
 885 acc8= constant 92
 886 writeLineAcc8
 887 ;testComparison.j(119)     if (three <= twelve/(one+2)) println(93);
 888 acc16= variable 10
 889 <acc16= variable 2
 890 acc16+ constant 2
 891 /acc16 unstack16
 892 acc16Comp variable 4
 893 brlt 897
 894 acc8= constant 93
 895 writeLineAcc8
 896 ;testComparison.j(120)     if (four >= twelve/(one+2)) println(94);
 897 acc16= variable 10
 898 <acc16= variable 2
 899 acc16+ constant 2
 900 /acc16 unstack16
 901 acc16Comp variable 6
 902 brgt 906
 903 acc8= constant 94
 904 writeLineAcc8
 905 ;testComparison.j(121)     if (twelve >= twelve/(one+2)) println(95);
 906 acc16= variable 10
 907 <acc16= variable 2
 908 acc16+ constant 2
 909 /acc16 unstack16
 910 acc16Comp variable 10
 911 brgt 915
 912 acc8= constant 95
 913 writeLineAcc8
 914 ;testComparison.j(122)     if (1+3 == 12/(1+2)) println(96);
 915 acc8= constant 1
 916 acc8+ constant 3
 917 <acc8
 918 acc8= constant 12
 919 <acc8= constant 1
 920 acc8+ constant 2
 921 /acc8 unstack8
 922 revAcc8Comp unstack8
 923 brne 927
 924 acc8= constant 96
 925 writeLineAcc8
 926 ;testComparison.j(123)     if (1+2 != 12/(1+2)) println(97);
 927 acc8= constant 1
 928 acc8+ constant 2
 929 <acc8
 930 acc8= constant 12
 931 <acc8= constant 1
 932 acc8+ constant 2
 933 /acc8 unstack8
 934 revAcc8Comp unstack8
 935 breq 939
 936 acc8= constant 97
 937 writeLineAcc8
 938 ;testComparison.j(124)     if (1+2 < 12/(1+2)) println(98);
 939 acc8= constant 1
 940 acc8+ constant 2
 941 <acc8
 942 acc8= constant 12
 943 <acc8= constant 1
 944 acc8+ constant 2
 945 /acc8 unstack8
 946 revAcc8Comp unstack8
 947 brle 951
 948 acc8= constant 98
 949 writeLineAcc8
 950 ;testComparison.j(125)     if (1+4 > 12/(1+2)) println(99);
 951 acc8= constant 1
 952 acc8+ constant 4
 953 <acc8
 954 acc8= constant 12
 955 <acc8= constant 1
 956 acc8+ constant 2
 957 /acc8 unstack8
 958 revAcc8Comp unstack8
 959 brge 963
 960 acc8= constant 99
 961 writeLineAcc8
 962 ;testComparison.j(126)     if (1+2 <= 12/(1+2)) println(100);
 963 acc8= constant 1
 964 acc8+ constant 2
 965 <acc8
 966 acc8= constant 12
 967 <acc8= constant 1
 968 acc8+ constant 2
 969 /acc8 unstack8
 970 revAcc8Comp unstack8
 971 brlt 975
 972 acc8= constant 100
 973 writeLineAcc8
 974 ;testComparison.j(127)     if (1+3 <= 12/(1+2)) println(101);
 975 acc8= constant 1
 976 acc8+ constant 3
 977 <acc8
 978 acc8= constant 12
 979 <acc8= constant 1
 980 acc8+ constant 2
 981 /acc8 unstack8
 982 revAcc8Comp unstack8
 983 brlt 987
 984 acc8= constant 101
 985 writeLineAcc8
 986 ;testComparison.j(128)     if (1+3 >= 12/(1+2)) println(102);
 987 acc8= constant 1
 988 acc8+ constant 3
 989 <acc8
 990 acc8= constant 12
 991 <acc8= constant 1
 992 acc8+ constant 2
 993 /acc8 unstack8
 994 revAcc8Comp unstack8
 995 brgt 999
 996 acc8= constant 102
 997 writeLineAcc8
 998 ;testComparison.j(129)     if (1+4 >= 12/(1+2)) println(103);
 999 acc8= constant 1
1000 acc8+ constant 4
1001 <acc8
1002 acc8= constant 12
1003 <acc8= constant 1
1004 acc8+ constant 2
1005 /acc8 unstack8
1006 revAcc8Comp unstack8
1007 brgt 1011
1008 acc8= constant 103
1009 writeLineAcc8
1010 ;testComparison.j(130)     if (1+3 == twelve/(one+2)) println(104);
1011 acc8= constant 1
1012 acc8+ constant 3
1013 <acc8
1014 acc16= variable 10
1015 <acc16= variable 2
1016 acc16+ constant 2
1017 /acc16 unstack16
1018 acc8<
1019 acc8CompareAcc16
1020 brne 1024
1021 acc8= constant 104
1022 writeLineAcc8
1023 ;testComparison.j(131)     if (1+2 != twelve/(one+2)) println(105);
1024 acc8= constant 1
1025 acc8+ constant 2
1026 <acc8
1027 acc16= variable 10
1028 <acc16= variable 2
1029 acc16+ constant 2
1030 /acc16 unstack16
1031 acc8<
1032 acc8CompareAcc16
1033 breq 1037
1034 acc8= constant 105
1035 writeLineAcc8
1036 ;testComparison.j(132)     if (1+2 < twelve/(one+2)) println(106);
1037 acc8= constant 1
1038 acc8+ constant 2
1039 <acc8
1040 acc16= variable 10
1041 <acc16= variable 2
1042 acc16+ constant 2
1043 /acc16 unstack16
1044 acc8<
1045 acc8CompareAcc16
1046 brge 1050
1047 acc8= constant 106
1048 writeLineAcc8
1049 ;testComparison.j(133)     if (1+4 > twelve/(one+2)) println(107);
1050 acc8= constant 1
1051 acc8+ constant 4
1052 <acc8
1053 acc16= variable 10
1054 <acc16= variable 2
1055 acc16+ constant 2
1056 /acc16 unstack16
1057 acc8<
1058 acc8CompareAcc16
1059 brle 1063
1060 acc8= constant 107
1061 writeLineAcc8
1062 ;testComparison.j(134)     if (1+2 <= twelve/(one+2)) println(108);
1063 acc8= constant 1
1064 acc8+ constant 2
1065 <acc8
1066 acc16= variable 10
1067 <acc16= variable 2
1068 acc16+ constant 2
1069 /acc16 unstack16
1070 acc8<
1071 acc8CompareAcc16
1072 brgt 1076
1073 acc8= constant 108
1074 writeLineAcc8
1075 ;testComparison.j(135)     if (1+3 <= twelve/(one+2)) println(109);
1076 acc8= constant 1
1077 acc8+ constant 3
1078 <acc8
1079 acc16= variable 10
1080 <acc16= variable 2
1081 acc16+ constant 2
1082 /acc16 unstack16
1083 acc8<
1084 acc8CompareAcc16
1085 brgt 1089
1086 acc8= constant 109
1087 writeLineAcc8
1088 ;testComparison.j(136)     if (1+3 >= twelve/(one+2)) println(110);
1089 acc8= constant 1
1090 acc8+ constant 3
1091 <acc8
1092 acc16= variable 10
1093 <acc16= variable 2
1094 acc16+ constant 2
1095 /acc16 unstack16
1096 acc8<
1097 acc8CompareAcc16
1098 brlt 1102
1099 acc8= constant 110
1100 writeLineAcc8
1101 ;testComparison.j(137)     if (1+4 >= twelve/(one+2)) println(111);
1102 acc8= constant 1
1103 acc8+ constant 4
1104 <acc8
1105 acc16= variable 10
1106 <acc16= variable 2
1107 acc16+ constant 2
1108 /acc16 unstack16
1109 acc8<
1110 acc8CompareAcc16
1111 brlt 1115
1112 acc8= constant 111
1113 writeLineAcc8
1114 ;testComparison.j(138)     if (4 == 12/(1+2)) println(112);
1115 acc8= constant 12
1116 <acc8= constant 1
1117 acc8+ constant 2
1118 /acc8 unstack8
1119 acc8Comp constant 4
1120 brne 1124
1121 acc8= constant 112
1122 writeLineAcc8
1123 ;testComparison.j(139)     if (3 != 12/(1+2)) println(113);
1124 acc8= constant 12
1125 <acc8= constant 1
1126 acc8+ constant 2
1127 /acc8 unstack8
1128 acc8Comp constant 3
1129 breq 1133
1130 acc8= constant 113
1131 writeLineAcc8
1132 ;testComparison.j(140)     if (3 < 12/(1+2)) println(114);
1133 acc8= constant 12
1134 <acc8= constant 1
1135 acc8+ constant 2
1136 /acc8 unstack8
1137 acc8Comp constant 3
1138 brle 1142
1139 acc8= constant 114
1140 writeLineAcc8
1141 ;testComparison.j(141)     if (5 > 12/(1+2)) println(115);
1142 acc8= constant 12
1143 <acc8= constant 1
1144 acc8+ constant 2
1145 /acc8 unstack8
1146 acc8Comp constant 5
1147 brge 1151
1148 acc8= constant 115
1149 writeLineAcc8
1150 ;testComparison.j(142)     if (3 <= 12/(1+2)) println(116);
1151 acc8= constant 12
1152 <acc8= constant 1
1153 acc8+ constant 2
1154 /acc8 unstack8
1155 acc8Comp constant 3
1156 brlt 1160
1157 acc8= constant 116
1158 writeLineAcc8
1159 ;testComparison.j(143)     if (4 <= 12/(1+2)) println(117);
1160 acc8= constant 12
1161 <acc8= constant 1
1162 acc8+ constant 2
1163 /acc8 unstack8
1164 acc8Comp constant 4
1165 brlt 1169
1166 acc8= constant 117
1167 writeLineAcc8
1168 ;testComparison.j(144)     if (4 >= 12/(1+2)) println(118);
1169 acc8= constant 12
1170 <acc8= constant 1
1171 acc8+ constant 2
1172 /acc8 unstack8
1173 acc8Comp constant 4
1174 brgt 1178
1175 acc8= constant 118
1176 writeLineAcc8
1177 ;testComparison.j(145)     if (5 >= 12/(1+2)) println(119);
1178 acc8= constant 12
1179 <acc8= constant 1
1180 acc8+ constant 2
1181 /acc8 unstack8
1182 acc8Comp constant 5
1183 brgt 1187
1184 acc8= constant 119
1185 writeLineAcc8
1186 ;testComparison.j(146)     if (4 == twelve/(one+2)) println(120);
1187 acc16= variable 10
1188 <acc16= variable 2
1189 acc16+ constant 2
1190 /acc16 unstack16
1191 acc8= constant 4
1192 acc8CompareAcc16
1193 brne 1197
1194 acc8= constant 120
1195 writeLineAcc8
1196 ;testComparison.j(147)     if (3 != twelve/(one+2)) println(121);
1197 acc16= variable 10
1198 <acc16= variable 2
1199 acc16+ constant 2
1200 /acc16 unstack16
1201 acc8= constant 3
1202 acc8CompareAcc16
1203 breq 1207
1204 acc8= constant 121
1205 writeLineAcc8
1206 ;testComparison.j(148)     if (2 < twelve/(one+2)) println(122);
1207 acc16= variable 10
1208 <acc16= variable 2
1209 acc16+ constant 2
1210 /acc16 unstack16
1211 acc8= constant 2
1212 acc8CompareAcc16
1213 brge 1217
1214 acc8= constant 122
1215 writeLineAcc8
1216 ;testComparison.j(149)     if (5 > twelve/(one+2)) println(123);
1217 acc16= variable 10
1218 <acc16= variable 2
1219 acc16+ constant 2
1220 /acc16 unstack16
1221 acc8= constant 5
1222 acc8CompareAcc16
1223 brle 1227
1224 acc8= constant 123
1225 writeLineAcc8
1226 ;testComparison.j(150)     if (3 <= twelve/(one+2)) println(124);
1227 acc16= variable 10
1228 <acc16= variable 2
1229 acc16+ constant 2
1230 /acc16 unstack16
1231 acc8= constant 3
1232 acc8CompareAcc16
1233 brgt 1237
1234 acc8= constant 124
1235 writeLineAcc8
1236 ;testComparison.j(151)     if (4 <= twelve/(one+2)) println(125);
1237 acc16= variable 10
1238 <acc16= variable 2
1239 acc16+ constant 2
1240 /acc16 unstack16
1241 acc8= constant 4
1242 acc8CompareAcc16
1243 brgt 1247
1244 acc8= constant 125
1245 writeLineAcc8
1246 ;testComparison.j(152)     if (4 >= twelve/(one+2)) println(126);
1247 acc16= variable 10
1248 <acc16= variable 2
1249 acc16+ constant 2
1250 /acc16 unstack16
1251 acc8= constant 4
1252 acc8CompareAcc16
1253 brlt 1257
1254 acc8= constant 126
1255 writeLineAcc8
1256 ;testComparison.j(153)     if (5 >= twelve/(one+2)) println(127);
1257 acc16= variable 10
1258 <acc16= variable 2
1259 acc16+ constant 2
1260 /acc16 unstack16
1261 acc8= constant 5
1262 acc8CompareAcc16
1263 brlt 1267
1264 acc8= constant 127
1265 writeLineAcc8
1266 ;testComparison.j(154)     if (four == 0 + 12/(1 + 2)) println(128);
1267 acc8= constant 0
1268 <acc8= constant 12
1269 <acc8= constant 1
1270 acc8+ constant 2
1271 /acc8 unstack8
1272 acc8+ unstack8
1273 acc16= variable 6
1274 acc16CompareAcc8
1275 brne 1279
1276 acc8= constant 128
1277 writeLineAcc8
1278 ;testComparison.j(155)     if (four == 0 + 12/(1 + 2)) println(129);
1279 acc8= constant 0
1280 <acc8= constant 12
1281 <acc8= constant 1
1282 acc8+ constant 2
1283 /acc8 unstack8
1284 acc8+ unstack8
1285 acc16= variable 6
1286 acc16CompareAcc8
1287 brne 1291
1288 acc8= constant 129
1289 writeLineAcc8
1290 ;testComparison.j(156)     if (four == 0 + 12/(byteOne + 2)) println(130);
1291 acc8= constant 0
1292 <acc8= constant 12
1293 <acc8= variable 12
1294 acc8+ constant 2
1295 /acc8 unstack8
1296 acc8+ unstack8
1297 acc16= variable 6
1298 acc16CompareAcc8
1299 brne 1303
1300 acc8= constant 130
1301 writeLineAcc8
1302 ;testComparison.j(157)     if (four == 0 + 12/(one + 2)) println(131);
1303 acc8= constant 0
1304 <acc8= constant 12
1305 acc16= variable 2
1306 acc16+ constant 2
1307 /acc16 acc8
1308 acc16+ unstack8
1309 acc16Comp variable 6
1310 brne 1314
1311 acc8= constant 131
1312 writeLineAcc8
1313 ;testComparison.j(158)     if (4 == zero + twelve/(1+2)) println(132);
1314 acc16= variable 0
1315 <acc16= variable 10
1316 acc8= constant 1
1317 acc8+ constant 2
1318 acc16/ acc8
1319 acc16+ unstack16
1320 acc8= constant 4
1321 acc8CompareAcc16
1322 brne 1329
1323 acc8= constant 132
1324 writeLineAcc8
1325 ;testComparison.j(159)   
1326 ;testComparison.j(160)     /************************/
1327 ;testComparison.j(161)     // global variable b used within if scope
1328 ;testComparison.j(162)     b = 133;
1329 acc8= constant 133
1330 acc8=> variable 14
1331 ;testComparison.j(163)     if (b>132) {
1332 acc8= variable 14
1333 acc8Comp constant 132
1334 brle 1351
1335 ;testComparison.j(164)       word j = 1001;
1336 acc16= constant 1001
1337 acc16=> (basePointer + -2)
1338 ;testComparison.j(165)       byte c = b;
1339 acc8= variable 14
1340 acc8=> (basePointer + -3)
1341 ;testComparison.j(166)       byte d = c;
1342 acc8= (basePointer + -3)
1343 acc8=> (basePointer + -4)
1344 ;testComparison.j(167)       b--;
1345 decr8 variable 14
1346 ;testComparison.j(168)       println (c);
1347 acc8= (basePointer + -3)
1348 writeLineAcc8
1349 ;testComparison.j(169)     } else {
1350 br 1358
1351 ;testComparison.j(170)       println(999);
1352 acc16= constant 999
1353 writeLineAcc16
1354 ;testComparison.j(171)     }
1355 ;testComparison.j(172)   
1356 ;testComparison.j(173)     /************************/
1357 ;testComparison.j(174)     println (134);
1358 acc8= constant 134
1359 writeLineAcc8
1360 ;testComparison.j(175)     println("Klaar");
1361 acc16= stringconstant 1368
1362 writeLineString
1363 ;testComparison.j(176)   }
1364 stackPointer= basePointer
1365 basePointer<
1366 return
1367 ;testComparison.j(177) }
1368 stringConstant 0 = "Klaar"
