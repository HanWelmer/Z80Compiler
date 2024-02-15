   0 ;test11.j(0) /* Program to test generated Z80 assembler code */
   1 ;test11.j(1) class TestFor {
   2 class TestFor []
   3 ;test11.j(2)   private static byte b1 = 1;
   4 acc8= constant 1
   5 acc8=> variable 0
   6 ;test11.j(3)   private static byte b2 = 1;
   7 acc8= constant 1
   8 acc8=> variable 1
   9 ;test11.j(4)   private static word i2 = 1;
  10 acc8= constant 1
  11 acc8=> variable 2
  12 ;test11.j(5)   private static word p = 1;
  13 acc8= constant 1
  14 acc8=> variable 4
  15 ;test11.j(6) 
  16 ;test11.j(7)   static byte c = b1;
  17 acc8= variable 0
  18 acc8=> variable 6
  19 ;test11.j(8) 
  20 ;test11.j(9)   public static void main() {
  21 method main [public, static] void
  22 ;test11.j(10)     println(0);
  23 acc8= constant 0
  24 call writeLineAcc8
  25 ;test11.j(11)   
  26 ;test11.j(12)     /************************/
  27 ;test11.j(13)     // global variable within for scope
  28 ;test11.j(14)     for (byte b = 1; b <= 2; b++) {
  29 acc8= constant 1
  30 acc8=> variable 7
  31 acc8= variable 7
  32 acc8Comp constant 2
  33 brgt 57
  34 br 37
  35 incr8 variable 7
  36 br 31
  37 ;test11.j(15)       //byte c = b1;
  38 ;test11.j(16)       c = b1;
  39 acc8= variable 0
  40 acc8=> variable 6
  41 ;test11.j(17)       println (c);
  42 acc8= variable 6
  43 call writeLineAcc8
  44 ;test11.j(18)       b1++;
  45 incr8 variable 0
  46 br 35
  47 ;test11.j(19)     }
  48 ;test11.j(20)   
  49 ;test11.j(21)     /************************/
  50 ;test11.j(22)     // constant - constant
  51 ;test11.j(23)     // not relevant
  52 ;test11.j(24)   
  53 ;test11.j(25)     /************************/
  54 ;test11.j(26)     // constant - acc
  55 ;test11.j(27)     // byte - byte
  56 ;test11.j(28)     for (byte b = 3; 103 == b+100; b++) { println (b); }
  57 acc8= constant 3
  58 acc8=> variable 7
  59 acc8= variable 7
  60 acc8+ constant 100
  61 acc8Comp constant 103
  62 brne 70
  63 br 66
  64 incr8 variable 7
  65 br 59
  66 acc8= variable 7
  67 call writeLineAcc8
  68 br 64
  69 ;test11.j(29)     for (byte b = 4; 105 != b+100; b++) { println (b); }
  70 acc8= constant 4
  71 acc8=> variable 7
  72 acc8= variable 7
  73 acc8+ constant 100
  74 acc8Comp constant 105
  75 breq 83
  76 br 79
  77 incr8 variable 7
  78 br 72
  79 acc8= variable 7
  80 call writeLineAcc8
  81 br 77
  82 ;test11.j(30)     b2=5;
  83 acc8= constant 5
  84 acc8=> variable 1
  85 ;test11.j(31)     for (byte b = 32; 134 > b+100; b++) { println (b2); b2++; }
  86 acc8= constant 32
  87 acc8=> variable 7
  88 acc8= variable 7
  89 acc8+ constant 100
  90 acc8Comp constant 134
  91 brge 100
  92 br 95
  93 incr8 variable 7
  94 br 88
  95 acc8= variable 1
  96 call writeLineAcc8
  97 incr8 variable 1
  98 br 93
  99 ;test11.j(32)     for (byte b = 34; 135 >= b+100; b++) { println (b2); b2++; }
 100 acc8= constant 34
 101 acc8=> variable 7
 102 acc8= variable 7
 103 acc8+ constant 100
 104 acc8Comp constant 135
 105 brgt 114
 106 br 109
 107 incr8 variable 7
 108 br 102
 109 acc8= variable 1
 110 call writeLineAcc8
 111 incr8 variable 1
 112 br 107
 113 ;test11.j(33)     for (byte b = 28; 126 <  b+100; b--) { println (b2); b2++; }
 114 acc8= constant 28
 115 acc8=> variable 7
 116 acc8= variable 7
 117 acc8+ constant 100
 118 acc8Comp constant 126
 119 brle 128
 120 br 123
 121 decr8 variable 7
 122 br 116
 123 acc8= variable 1
 124 call writeLineAcc8
 125 incr8 variable 1
 126 br 121
 127 ;test11.j(34)     for (byte b = 26; 125 <= b+100; b--) { println (b2); b2++; }
 128 acc8= constant 26
 129 acc8=> variable 7
 130 acc8= variable 7
 131 acc8+ constant 100
 132 acc8Comp constant 125
 133 brlt 143
 134 br 137
 135 decr8 variable 7
 136 br 130
 137 acc8= variable 1
 138 call writeLineAcc8
 139 incr8 variable 1
 140 br 135
 141 ;test11.j(35)     // byte - integer
 142 ;test11.j(36)     for(word i = 24; 24  == i+0; i--) { println (b2); b2++; }
 143 acc8= constant 24
 144 acc8=> variable 7
 145 acc16= variable 7
 146 acc16+ constant 0
 147 acc8= constant 24
 148 acc8CompareAcc16
 149 brne 158
 150 br 153
 151 decr16 variable 7
 152 br 145
 153 acc8= variable 1
 154 call writeLineAcc8
 155 incr8 variable 1
 156 br 151
 157 ;test11.j(37)     for(word i = 23; 120 != i+100; i--) { println (b2); b2++; }
 158 acc8= constant 23
 159 acc8=> variable 7
 160 acc16= variable 7
 161 acc16+ constant 100
 162 acc8= constant 120
 163 acc8CompareAcc16
 164 breq 173
 165 br 168
 166 decr16 variable 7
 167 br 160
 168 acc8= variable 1
 169 call writeLineAcc8
 170 incr8 variable 1
 171 br 166
 172 ;test11.j(38)     for(word i = 20; 122 > i+100; i++) { println (b2); b2++; }
 173 acc8= constant 20
 174 acc8=> variable 7
 175 acc16= variable 7
 176 acc16+ constant 100
 177 acc8= constant 122
 178 acc8CompareAcc16
 179 brle 188
 180 br 183
 181 incr16 variable 7
 182 br 175
 183 acc8= variable 1
 184 call writeLineAcc8
 185 incr8 variable 1
 186 br 181
 187 ;test11.j(39)     for(word i = 22; 123 >= i+100; i++) { println (b2); b2++; }
 188 acc8= constant 22
 189 acc8=> variable 7
 190 acc16= variable 7
 191 acc16+ constant 100
 192 acc8= constant 123
 193 acc8CompareAcc16
 194 brlt 203
 195 br 198
 196 incr16 variable 7
 197 br 190
 198 acc8= variable 1
 199 call writeLineAcc8
 200 incr8 variable 1
 201 br 196
 202 ;test11.j(40)     for(word i = 16; 114 <  i+100; i--) { println (b2); b2++; }
 203 acc8= constant 16
 204 acc8=> variable 7
 205 acc16= variable 7
 206 acc16+ constant 100
 207 acc8= constant 114
 208 acc8CompareAcc16
 209 brge 218
 210 br 213
 211 decr16 variable 7
 212 br 205
 213 acc8= variable 1
 214 call writeLineAcc8
 215 incr8 variable 1
 216 br 211
 217 ;test11.j(41)     for(word i = 14; 113 <= i+100; i--) { println (b2); b2++; }
 218 acc8= constant 14
 219 acc8=> variable 7
 220 acc16= variable 7
 221 acc16+ constant 100
 222 acc8= constant 113
 223 acc8CompareAcc16
 224 brgt 236
 225 br 228
 226 decr16 variable 7
 227 br 220
 228 acc8= variable 1
 229 call writeLineAcc8
 230 incr8 variable 1
 231 br 226
 232 ;test11.j(42)     // integer - byte
 233 ;test11.j(43)     // not relevant
 234 ;test11.j(44)     // integer - integer
 235 ;test11.j(45)     for(word i = 12; 1012 == i+1000; i--) { println (b2); b2++; }
 236 acc8= constant 12
 237 acc8=> variable 7
 238 acc16= variable 7
 239 acc16+ constant 1000
 240 acc16Comp constant 1012
 241 brne 250
 242 br 245
 243 decr16 variable 7
 244 br 238
 245 acc8= variable 1
 246 call writeLineAcc8
 247 incr8 variable 1
 248 br 243
 249 ;test11.j(46)     for(word i = 11; 1008 != i+1000; i--) { println (b2); b2++; }
 250 acc8= constant 11
 251 acc8=> variable 7
 252 acc16= variable 7
 253 acc16+ constant 1000
 254 acc16Comp constant 1008
 255 breq 264
 256 br 259
 257 decr16 variable 7
 258 br 252
 259 acc8= variable 1
 260 call writeLineAcc8
 261 incr8 variable 1
 262 br 257
 263 ;test11.j(47)     for(word i = 8; 1010 > i+1000; i++) { println (b2); b2++; }
 264 acc8= constant 8
 265 acc8=> variable 7
 266 acc16= variable 7
 267 acc16+ constant 1000
 268 acc16Comp constant 1010
 269 brge 278
 270 br 273
 271 incr16 variable 7
 272 br 266
 273 acc8= variable 1
 274 call writeLineAcc8
 275 incr8 variable 1
 276 br 271
 277 ;test11.j(48)     for(word i = 10; 1011 >= i+1000; i++) { println (b2); b2++; }
 278 acc8= constant 10
 279 acc8=> variable 7
 280 acc16= variable 7
 281 acc16+ constant 1000
 282 acc16Comp constant 1011
 283 brgt 292
 284 br 287
 285 incr16 variable 7
 286 br 280
 287 acc8= variable 1
 288 call writeLineAcc8
 289 incr8 variable 1
 290 br 285
 291 ;test11.j(49)     for(word i = 4; 1002 <  i+1000; i--) { println (b2); b2++; }
 292 acc8= constant 4
 293 acc8=> variable 7
 294 acc16= variable 7
 295 acc16+ constant 1000
 296 acc16Comp constant 1002
 297 brle 306
 298 br 301
 299 decr16 variable 7
 300 br 294
 301 acc8= variable 1
 302 call writeLineAcc8
 303 incr8 variable 1
 304 br 299
 305 ;test11.j(50)     for(word i = 2; 1001 <= i+1000; i--) { println (b2); b2++; }
 306 acc8= constant 2
 307 acc8=> variable 7
 308 acc16= variable 7
 309 acc16+ constant 1000
 310 acc16Comp constant 1001
 311 brlt 324
 312 br 315
 313 decr16 variable 7
 314 br 308
 315 acc8= variable 1
 316 call writeLineAcc8
 317 incr8 variable 1
 318 br 313
 319 ;test11.j(51)   
 320 ;test11.j(52)     /************************/
 321 ;test11.j(53)     // constant - var
 322 ;test11.j(54)     // byte - byte
 323 ;test11.j(55)     for (byte b = 42; 41 <= b; b--) { println (b2); b2++; }
 324 acc8= constant 42
 325 acc8=> variable 7
 326 acc8= variable 7
 327 acc8Comp constant 41
 328 brlt 338
 329 br 332
 330 decr8 variable 7
 331 br 326
 332 acc8= variable 1
 333 call writeLineAcc8
 334 incr8 variable 1
 335 br 330
 336 ;test11.j(56)     // byte - integer
 337 ;test11.j(57)     for(word i = 40; 39 <= i; i--) { println (b2); b2++; }
 338 acc8= constant 40
 339 acc8=> variable 7
 340 acc16= variable 7
 341 acc8= constant 39
 342 acc8CompareAcc16
 343 brgt 355
 344 br 347
 345 decr16 variable 7
 346 br 340
 347 acc8= variable 1
 348 call writeLineAcc8
 349 incr8 variable 1
 350 br 345
 351 ;test11.j(58)     // integer - byte
 352 ;test11.j(59)     // not relevant
 353 ;test11.j(60)     // integer - integer
 354 ;test11.j(61)     for(word i = 1038; 1037 <= i; i--) { println (b2); b2++; }
 355 acc16= constant 1038
 356 acc16=> variable 7
 357 acc16= variable 7
 358 acc16Comp constant 1037
 359 brlt 373
 360 br 363
 361 decr16 variable 7
 362 br 357
 363 acc8= variable 1
 364 call writeLineAcc8
 365 incr8 variable 1
 366 br 361
 367 ;test11.j(62)   
 368 ;test11.j(63)     /************************/
 369 ;test11.j(64)     // constant - stack8
 370 ;test11.j(65)     // byte - byte
 371 ;test11.j(66)     //TODO
 372 ;test11.j(67)     println(43);
 373 acc8= constant 43
 374 call writeLineAcc8
 375 ;test11.j(68)     println(44);
 376 acc8= constant 44
 377 call writeLineAcc8
 378 ;test11.j(69)     // constant - stack8
 379 ;test11.j(70)     // byte - integer
 380 ;test11.j(71)     //TODO
 381 ;test11.j(72)     println(45);
 382 acc8= constant 45
 383 call writeLineAcc8
 384 ;test11.j(73)     println(46);
 385 acc8= constant 46
 386 call writeLineAcc8
 387 ;test11.j(74)     // constant - stack8
 388 ;test11.j(75)     // integer - byte
 389 ;test11.j(76)     //TODO
 390 ;test11.j(77)     println(47);
 391 acc8= constant 47
 392 call writeLineAcc8
 393 ;test11.j(78)     println(48);
 394 acc8= constant 48
 395 call writeLineAcc8
 396 ;test11.j(79)     // constant - stack88
 397 ;test11.j(80)     // integer - integer
 398 ;test11.j(81)     //TODO
 399 ;test11.j(82)     println(49);
 400 acc8= constant 49
 401 call writeLineAcc8
 402 ;test11.j(83)     println(50);
 403 acc8= constant 50
 404 call writeLineAcc8
 405 ;test11.j(84)   
 406 ;test11.j(85)     /************************/
 407 ;test11.j(86)     // constant - stack16
 408 ;test11.j(87)     // byte - byte
 409 ;test11.j(88)     //TODO
 410 ;test11.j(89)     println(51);
 411 acc8= constant 51
 412 call writeLineAcc8
 413 ;test11.j(90)     println(52);
 414 acc8= constant 52
 415 call writeLineAcc8
 416 ;test11.j(91)     // constant - stack16
 417 ;test11.j(92)     // byte - integer
 418 ;test11.j(93)     //TODO
 419 ;test11.j(94)     println(53);
 420 acc8= constant 53
 421 call writeLineAcc8
 422 ;test11.j(95)     println(54);
 423 acc8= constant 54
 424 call writeLineAcc8
 425 ;test11.j(96)     // constant - stack16
 426 ;test11.j(97)     // integer - byte
 427 ;test11.j(98)     //TODO
 428 ;test11.j(99)     println(55);
 429 acc8= constant 55
 430 call writeLineAcc8
 431 ;test11.j(100)     println(56);
 432 acc8= constant 56
 433 call writeLineAcc8
 434 ;test11.j(101)     // constant - stack16
 435 ;test11.j(102)     // integer - integer
 436 ;test11.j(103)     //TODO
 437 ;test11.j(104)     println(57);
 438 acc8= constant 57
 439 call writeLineAcc8
 440 ;test11.j(105)     println(58);
 441 acc8= constant 58
 442 call writeLineAcc8
 443 ;test11.j(106)   
 444 ;test11.j(107)     /************************/
 445 ;test11.j(108)     // acc - constant
 446 ;test11.j(109)     // byte - byte
 447 ;test11.j(110)     b2 = 59;
 448 acc8= constant 59
 449 acc8=> variable 1
 450 ;test11.j(111)     for (byte b = 56; b+0 <= 57; b++) { println (b2); b2++; }
 451 acc8= constant 56
 452 acc8=> variable 7
 453 acc8= variable 7
 454 acc8+ constant 0
 455 acc8Comp constant 57
 456 brgt 468
 457 br 460
 458 incr8 variable 7
 459 br 453
 460 acc8= variable 1
 461 call writeLineAcc8
 462 incr8 variable 1
 463 br 458
 464 ;test11.j(112)     // byte - integer
 465 ;test11.j(113)     //not relevant
 466 ;test11.j(114)     // integer - byte
 467 ;test11.j(115)     for (word i = 54; i+0 <= 55; i++) { println (b2); b2++;}
 468 acc8= constant 54
 469 acc8=> variable 7
 470 acc16= variable 7
 471 acc16+ constant 0
 472 acc8= constant 55
 473 acc16CompareAcc8
 474 brgt 484
 475 br 478
 476 incr16 variable 7
 477 br 470
 478 acc8= variable 1
 479 call writeLineAcc8
 480 incr8 variable 1
 481 br 476
 482 ;test11.j(116)     // integer - integer
 483 ;test11.j(117)     for(word i = 1052; i+0 <= 1053; i++) { println (b2); b2++; }
 484 acc16= constant 1052
 485 acc16=> variable 7
 486 acc16= variable 7
 487 acc16+ constant 0
 488 acc16Comp constant 1053
 489 brgt 502
 490 br 493
 491 incr16 variable 7
 492 br 486
 493 acc8= variable 1
 494 call writeLineAcc8
 495 incr8 variable 1
 496 br 491
 497 ;test11.j(118)   
 498 ;test11.j(119)     /************************/
 499 ;test11.j(120)     // acc - acc
 500 ;test11.j(121)     // byte - byte
 501 ;test11.j(122)     for (byte b = 64; 63+0 <= b+0; b--) { println (b2); b2++; }
 502 acc8= constant 64
 503 acc8=> variable 7
 504 acc8= constant 63
 505 acc8+ constant 0
 506 <acc8
 507 acc8= variable 7
 508 acc8+ constant 0
 509 revAcc8Comp unstack8
 510 brlt 520
 511 br 514
 512 decr8 variable 7
 513 br 504
 514 acc8= variable 1
 515 call writeLineAcc8
 516 incr8 variable 1
 517 br 512
 518 ;test11.j(123)     // byte - integer
 519 ;test11.j(124)     for(word i = 62; 61+0 <= i+0; i--) { println (b2); b2++; }
 520 acc8= constant 62
 521 acc8=> variable 7
 522 acc8= constant 61
 523 acc8+ constant 0
 524 <acc8
 525 acc16= variable 7
 526 acc16+ constant 0
 527 acc8= unstack8
 528 acc8CompareAcc16
 529 brgt 539
 530 br 533
 531 decr16 variable 7
 532 br 522
 533 acc8= variable 1
 534 call writeLineAcc8
 535 incr8 variable 1
 536 br 531
 537 ;test11.j(125)     // integer - byte
 538 ;test11.j(126)     i2=59;
 539 acc8= constant 59
 540 acc8=> variable 2
 541 ;test11.j(127)     for (byte b = 60; i2+0 <= b+0; b--) { println (b2); b2++; }
 542 acc8= constant 60
 543 acc8=> variable 7
 544 acc16= variable 2
 545 acc16+ constant 0
 546 <acc16
 547 acc8= variable 7
 548 acc8+ constant 0
 549 acc16= unstack16
 550 acc16CompareAcc8
 551 brgt 561
 552 br 555
 553 decr8 variable 7
 554 br 544
 555 acc8= variable 1
 556 call writeLineAcc8
 557 incr8 variable 1
 558 br 553
 559 ;test11.j(128)     // integer - integer
 560 ;test11.j(129)     for(word i = 1058; 1000+57 <= i+0; i--) { println (b2); b2++; }
 561 acc16= constant 1058
 562 acc16=> variable 7
 563 acc16= constant 1000
 564 acc16+ constant 57
 565 <acc16
 566 acc16= variable 7
 567 acc16+ constant 0
 568 revAcc16Comp unstack16
 569 brlt 582
 570 br 573
 571 decr16 variable 7
 572 br 563
 573 acc8= variable 1
 574 call writeLineAcc8
 575 incr8 variable 1
 576 br 571
 577 ;test11.j(130)   
 578 ;test11.j(131)     /************************/
 579 ;test11.j(132)     // acc - var
 580 ;test11.j(133)     // byte - byte
 581 ;test11.j(134)     for (byte b = 72; 71+0 <= b; b--) { println (b2); b2++; }
 582 acc8= constant 72
 583 acc8=> variable 7
 584 acc8= constant 71
 585 acc8+ constant 0
 586 acc8Comp variable 7
 587 brgt 597
 588 br 591
 589 decr8 variable 7
 590 br 584
 591 acc8= variable 1
 592 call writeLineAcc8
 593 incr8 variable 1
 594 br 589
 595 ;test11.j(135)     // byte - integer
 596 ;test11.j(136)     for(word i = 70; 69+0 <= i; i--) { println (b2); b2++; }
 597 acc8= constant 70
 598 acc8=> variable 7
 599 acc8= constant 69
 600 acc8+ constant 0
 601 acc16= variable 7
 602 acc8CompareAcc16
 603 brgt 613
 604 br 607
 605 decr16 variable 7
 606 br 599
 607 acc8= variable 1
 608 call writeLineAcc8
 609 incr8 variable 1
 610 br 605
 611 ;test11.j(137)     // integer - byte
 612 ;test11.j(138)     i2=67;
 613 acc8= constant 67
 614 acc8=> variable 2
 615 ;test11.j(139)     for (byte b = 68; i2+0 <= b; b--) { println (b2); b2++; }
 616 acc8= constant 68
 617 acc8=> variable 7
 618 acc16= variable 2
 619 acc16+ constant 0
 620 acc8= variable 7
 621 acc16CompareAcc8
 622 brgt 632
 623 br 626
 624 decr8 variable 7
 625 br 618
 626 acc8= variable 1
 627 call writeLineAcc8
 628 incr8 variable 1
 629 br 624
 630 ;test11.j(140)     // integer - integer
 631 ;test11.j(141)     for(word i = 1066; 1000+65 <= i; i--) { println (b2); b2++; }
 632 acc16= constant 1066
 633 acc16=> variable 7
 634 acc16= constant 1000
 635 acc16+ constant 65
 636 acc16Comp variable 7
 637 brgt 651
 638 br 641
 639 decr16 variable 7
 640 br 634
 641 acc8= variable 1
 642 call writeLineAcc8
 643 incr8 variable 1
 644 br 639
 645 ;test11.j(142)   
 646 ;test11.j(143)     /************************/
 647 ;test11.j(144)     // acc - stack8
 648 ;test11.j(145)     // byte - byte
 649 ;test11.j(146)     //TODO
 650 ;test11.j(147)     println(81);
 651 acc8= constant 81
 652 call writeLineAcc8
 653 ;test11.j(148)     println(82);
 654 acc8= constant 82
 655 call writeLineAcc8
 656 ;test11.j(149)     // byte - integer
 657 ;test11.j(150)     //TODO
 658 ;test11.j(151)     println(83);
 659 acc8= constant 83
 660 call writeLineAcc8
 661 ;test11.j(152)     println(84);
 662 acc8= constant 84
 663 call writeLineAcc8
 664 ;test11.j(153)     // integer - byte
 665 ;test11.j(154)     //TODO
 666 ;test11.j(155)     println(85);
 667 acc8= constant 85
 668 call writeLineAcc8
 669 ;test11.j(156)     println(86);
 670 acc8= constant 86
 671 call writeLineAcc8
 672 ;test11.j(157)     // integer - integer
 673 ;test11.j(158)     //TODO
 674 ;test11.j(159)     println(87);
 675 acc8= constant 87
 676 call writeLineAcc8
 677 ;test11.j(160)     println(88);
 678 acc8= constant 88
 679 call writeLineAcc8
 680 ;test11.j(161)   
 681 ;test11.j(162)     /************************/
 682 ;test11.j(163)     // acc - stack16
 683 ;test11.j(164)     // byte - byte
 684 ;test11.j(165)     //TODO
 685 ;test11.j(166)     println(89);
 686 acc8= constant 89
 687 call writeLineAcc8
 688 ;test11.j(167)     println(90);
 689 acc8= constant 90
 690 call writeLineAcc8
 691 ;test11.j(168)     // byte - integer
 692 ;test11.j(169)     //TODO
 693 ;test11.j(170)     println(91);
 694 acc8= constant 91
 695 call writeLineAcc8
 696 ;test11.j(171)     println(92);
 697 acc8= constant 92
 698 call writeLineAcc8
 699 ;test11.j(172)     // integer - byte
 700 ;test11.j(173)     //TODO
 701 ;test11.j(174)     println(93);
 702 acc8= constant 93
 703 call writeLineAcc8
 704 ;test11.j(175)     println(94);
 705 acc8= constant 94
 706 call writeLineAcc8
 707 ;test11.j(176)     // integer - integer
 708 ;test11.j(177)     //TODO
 709 ;test11.j(178)     println(95);
 710 acc8= constant 95
 711 call writeLineAcc8
 712 ;test11.j(179)     println(96);
 713 acc8= constant 96
 714 call writeLineAcc8
 715 ;test11.j(180)   
 716 ;test11.j(181)     /************************/
 717 ;test11.j(182)     // var - constant
 718 ;test11.j(183)     // byte - byte
 719 ;test11.j(184)     b2=97;
 720 acc8= constant 97
 721 acc8=> variable 1
 722 ;test11.j(185)     for (byte b = 96; b <= 97; b++) { println (b2); b2++; }
 723 acc8= constant 96
 724 acc8=> variable 7
 725 acc8= variable 7
 726 acc8Comp constant 97
 727 brgt 739
 728 br 731
 729 incr8 variable 7
 730 br 725
 731 acc8= variable 1
 732 call writeLineAcc8
 733 incr8 variable 1
 734 br 729
 735 ;test11.j(186)     // byte - integer
 736 ;test11.j(187)     //not relevant
 737 ;test11.j(188)     // integer - byte
 738 ;test11.j(189)     for(word i = 92; i <= 93; i++) { println (b2); b2++; }
 739 acc8= constant 92
 740 acc8=> variable 7
 741 acc16= variable 7
 742 acc8= constant 93
 743 acc16CompareAcc8
 744 brgt 754
 745 br 748
 746 incr16 variable 7
 747 br 741
 748 acc8= variable 1
 749 call writeLineAcc8
 750 incr8 variable 1
 751 br 746
 752 ;test11.j(190)     // integer - integer
 753 ;test11.j(191)     for(word i = 1090; i <= 1091; i++) { println (b2); b2++; }
 754 acc16= constant 1090
 755 acc16=> variable 7
 756 acc16= variable 7
 757 acc16Comp constant 1091
 758 brgt 771
 759 br 762
 760 incr16 variable 7
 761 br 756
 762 acc8= variable 1
 763 call writeLineAcc8
 764 incr8 variable 1
 765 br 760
 766 ;test11.j(192)   
 767 ;test11.j(193)     /************************/
 768 ;test11.j(194)     // var - acc
 769 ;test11.j(195)     // byte - byte
 770 ;test11.j(196)     for (byte b = 104; b <= 105+0; b++) { println (b2); b2++; }
 771 acc8= constant 104
 772 acc8=> variable 7
 773 acc8= constant 105
 774 acc8+ constant 0
 775 acc8Comp variable 7
 776 brlt 786
 777 br 780
 778 incr8 variable 7
 779 br 773
 780 acc8= variable 1
 781 call writeLineAcc8
 782 incr8 variable 1
 783 br 778
 784 ;test11.j(197)     // byte - integer
 785 ;test11.j(198)     i2=103;
 786 acc8= constant 103
 787 acc8=> variable 2
 788 ;test11.j(199)     for (byte b = 102; b <= i2+0; b++) { println (b2); b2++; }
 789 acc8= constant 102
 790 acc8=> variable 7
 791 acc16= variable 2
 792 acc16+ constant 0
 793 acc8= variable 7
 794 acc8CompareAcc16
 795 brgt 805
 796 br 799
 797 incr8 variable 7
 798 br 791
 799 acc8= variable 1
 800 call writeLineAcc8
 801 incr8 variable 1
 802 br 797
 803 ;test11.j(200)     // integer - byte
 804 ;test11.j(201)     for(word i = 100; i <= 101+0; i++) { println (b2); b2++; }
 805 acc8= constant 100
 806 acc8=> variable 7
 807 acc8= constant 101
 808 acc8+ constant 0
 809 acc16= variable 7
 810 acc16CompareAcc8
 811 brgt 821
 812 br 815
 813 incr16 variable 7
 814 br 807
 815 acc8= variable 1
 816 call writeLineAcc8
 817 incr8 variable 1
 818 br 813
 819 ;test11.j(202)     // integer - integer
 820 ;test11.j(203)     for(word i = 1098; i <= 1099+0; i++) { println (b2); b2++; }
 821 acc16= constant 1098
 822 acc16=> variable 7
 823 acc16= constant 1099
 824 acc16+ constant 0
 825 acc16Comp variable 7
 826 brlt 839
 827 br 830
 828 incr16 variable 7
 829 br 823
 830 acc8= variable 1
 831 call writeLineAcc8
 832 incr8 variable 1
 833 br 828
 834 ;test11.j(204)   
 835 ;test11.j(205)     /************************/
 836 ;test11.j(206)     // var - var
 837 ;test11.j(207)     // byte - byte
 838 ;test11.j(208)     for (byte b = 112; b2 <= b; b--) { println (b2); b2++; }
 839 acc8= constant 112
 840 acc8=> variable 7
 841 acc8= variable 1
 842 acc8Comp variable 7
 843 brgt 853
 844 br 847
 845 decr8 variable 7
 846 br 841
 847 acc8= variable 1
 848 call writeLineAcc8
 849 incr8 variable 1
 850 br 845
 851 ;test11.j(209)     // byte - integer
 852 ;test11.j(210)     for(word i = 116; b2 <= i; i--) { println (b2); b2++; }
 853 acc8= constant 116
 854 acc8=> variable 7
 855 acc8= variable 1
 856 acc16= variable 7
 857 acc8CompareAcc16
 858 brgt 868
 859 br 862
 860 decr16 variable 7
 861 br 855
 862 acc8= variable 1
 863 call writeLineAcc8
 864 incr8 variable 1
 865 br 860
 866 ;test11.j(211)     // integer - byte
 867 ;test11.j(212)     i2=b2;
 868 acc8= variable 1
 869 acc8=> variable 2
 870 ;test11.j(213)     for (byte b = 118; i2 <= b; b--) { println (b2); b2++; }
 871 acc8= constant 118
 872 acc8=> variable 7
 873 acc16= variable 2
 874 acc8= variable 7
 875 acc16CompareAcc8
 876 brgt 886
 877 br 880
 878 decr8 variable 7
 879 br 873
 880 acc8= variable 1
 881 call writeLineAcc8
 882 incr8 variable 1
 883 br 878
 884 ;test11.j(214)     // integer - integer
 885 ;test11.j(215)     i2=120;
 886 acc8= constant 120
 887 acc8=> variable 2
 888 ;test11.j(216)     for(word i = b2+4; i2 <= i; i--) { println (b2); b2++; }
 889 acc8= variable 1
 890 acc8+ constant 4
 891 acc8=> variable 7
 892 acc16= variable 2
 893 acc16Comp variable 7
 894 brgt 936
 895 br 898
 896 decr16 variable 7
 897 br 892
 898 acc8= variable 1
 899 call writeLineAcc8
 900 incr8 variable 1
 901 br 896
 902 ;test11.j(217)   
 903 ;test11.j(218)     /************************/
 904 ;test11.j(219)     // var - stack8
 905 ;test11.j(220)     // byte - byte
 906 ;test11.j(221)     // byte - integer
 907 ;test11.j(222)     // integer - byte
 908 ;test11.j(223)     // integer - integer
 909 ;test11.j(224)     //TODO
 910 ;test11.j(225)   
 911 ;test11.j(226)     /************************/
 912 ;test11.j(227)     // var - stack16
 913 ;test11.j(228)     // byte - byte
 914 ;test11.j(229)     // byte - integer
 915 ;test11.j(230)     // integer - byte
 916 ;test11.j(231)     // integer - integer
 917 ;test11.j(232)     //TODO
 918 ;test11.j(233)   
 919 ;test11.j(234)     /************************/
 920 ;test11.j(235)     // stack8 - constant
 921 ;test11.j(236)     // stack8 - acc
 922 ;test11.j(237)     // stack8 - var
 923 ;test11.j(238)     // stack8 - stack8
 924 ;test11.j(239)     // stack8 - stack16
 925 ;test11.j(240)     //TODO
 926 ;test11.j(241)   
 927 ;test11.j(242)     /************************/
 928 ;test11.j(243)     // stack16 - constant
 929 ;test11.j(244)     // stack16 - acc
 930 ;test11.j(245)     // stack16 - var
 931 ;test11.j(246)     // stack16 - stack8
 932 ;test11.j(247)     // stack16 - stack16
 933 ;test11.j(248)     //TODO
 934 ;test11.j(249)   
 935 ;test11.j(250)     println("Klaar.");
 936 acc16= constant 941
 937 writeLineString
 938 ;test11.j(251)   }
 939 ;test11.j(252) }
 940 stop
 941 stringConstant 0 = "Klaar."
