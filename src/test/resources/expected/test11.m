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
  16 ;test11.j(7)   public static void main() {
  17 method main [public, static] void
  18 ;test11.j(8)     println(0);
  19 acc8= constant 0
  20 call writeLineAcc8
  21 ;test11.j(9)   
  22 ;test11.j(10)     /************************/
  23 ;test11.j(11)     // global variable within for scope
  24 ;test11.j(12)     for (byte b = 1; b <= 2; b++) {
  25 acc8= constant 1
  26 acc8=> variable 6
  27 acc8= variable 6
  28 acc8Comp constant 2
  29 brgt 52
  30 br 33
  31 incr8 variable 6
  32 br 27
  33 ;test11.j(13)       byte c = b1;
  34 acc8= variable 0
  35 acc8=> variable 7
  36 ;test11.j(14)       println (c);
  37 acc8= variable 7
  38 call writeLineAcc8
  39 ;test11.j(15)       b1++;
  40 incr8 variable 0
  41 ;test11.j(16)     }
  42 br 31
  43 ;test11.j(17)   
  44 ;test11.j(18)     /************************/
  45 ;test11.j(19)     // constant - constant
  46 ;test11.j(20)     // not relevant
  47 ;test11.j(21)   
  48 ;test11.j(22)     /************************/
  49 ;test11.j(23)     // constant - acc
  50 ;test11.j(24)     // byte - byte
  51 ;test11.j(25)     for (byte b = 3; 103 == b+100; b++) { println (b); }
  52 acc8= constant 3
  53 acc8=> variable 6
  54 acc8= variable 6
  55 acc8+ constant 100
  56 acc8Comp constant 103
  57 brne 65
  58 br 61
  59 incr8 variable 6
  60 br 54
  61 acc8= variable 6
  62 call writeLineAcc8
  63 br 59
  64 ;test11.j(26)     for (byte b = 4; 105 != b+100; b++) { println (b); }
  65 acc8= constant 4
  66 acc8=> variable 6
  67 acc8= variable 6
  68 acc8+ constant 100
  69 acc8Comp constant 105
  70 breq 78
  71 br 74
  72 incr8 variable 6
  73 br 67
  74 acc8= variable 6
  75 call writeLineAcc8
  76 br 72
  77 ;test11.j(27)     b2=5;
  78 acc8= constant 5
  79 acc8=> variable 1
  80 ;test11.j(28)     for (byte b = 32; 134 > b+100; b++) { println (b2); b2++; }
  81 acc8= constant 32
  82 acc8=> variable 6
  83 acc8= variable 6
  84 acc8+ constant 100
  85 acc8Comp constant 134
  86 brge 95
  87 br 90
  88 incr8 variable 6
  89 br 83
  90 acc8= variable 1
  91 call writeLineAcc8
  92 incr8 variable 1
  93 br 88
  94 ;test11.j(29)     for (byte b = 34; 135 >= b+100; b++) { println (b2); b2++; }
  95 acc8= constant 34
  96 acc8=> variable 6
  97 acc8= variable 6
  98 acc8+ constant 100
  99 acc8Comp constant 135
 100 brgt 109
 101 br 104
 102 incr8 variable 6
 103 br 97
 104 acc8= variable 1
 105 call writeLineAcc8
 106 incr8 variable 1
 107 br 102
 108 ;test11.j(30)     for (byte b = 28; 126 <  b+100; b--) { println (b2); b2++; }
 109 acc8= constant 28
 110 acc8=> variable 6
 111 acc8= variable 6
 112 acc8+ constant 100
 113 acc8Comp constant 126
 114 brle 123
 115 br 118
 116 decr8 variable 6
 117 br 111
 118 acc8= variable 1
 119 call writeLineAcc8
 120 incr8 variable 1
 121 br 116
 122 ;test11.j(31)     for (byte b = 26; 125 <= b+100; b--) { println (b2); b2++; }
 123 acc8= constant 26
 124 acc8=> variable 6
 125 acc8= variable 6
 126 acc8+ constant 100
 127 acc8Comp constant 125
 128 brlt 138
 129 br 132
 130 decr8 variable 6
 131 br 125
 132 acc8= variable 1
 133 call writeLineAcc8
 134 incr8 variable 1
 135 br 130
 136 ;test11.j(32)     // byte - integer
 137 ;test11.j(33)     for(word i = 24; 24  == i+0; i--) { println (b2); b2++; }
 138 acc8= constant 24
 139 acc8=> variable 6
 140 acc16= variable 6
 141 acc16+ constant 0
 142 acc8= constant 24
 143 acc8CompareAcc16
 144 brne 153
 145 br 148
 146 decr16 variable 6
 147 br 140
 148 acc8= variable 1
 149 call writeLineAcc8
 150 incr8 variable 1
 151 br 146
 152 ;test11.j(34)     for(word i = 23; 120 != i+100; i--) { println (b2); b2++; }
 153 acc8= constant 23
 154 acc8=> variable 6
 155 acc16= variable 6
 156 acc16+ constant 100
 157 acc8= constant 120
 158 acc8CompareAcc16
 159 breq 168
 160 br 163
 161 decr16 variable 6
 162 br 155
 163 acc8= variable 1
 164 call writeLineAcc8
 165 incr8 variable 1
 166 br 161
 167 ;test11.j(35)     for(word i = 20; 122 > i+100; i++) { println (b2); b2++; }
 168 acc8= constant 20
 169 acc8=> variable 6
 170 acc16= variable 6
 171 acc16+ constant 100
 172 acc8= constant 122
 173 acc8CompareAcc16
 174 brle 183
 175 br 178
 176 incr16 variable 6
 177 br 170
 178 acc8= variable 1
 179 call writeLineAcc8
 180 incr8 variable 1
 181 br 176
 182 ;test11.j(36)     for(word i = 22; 123 >= i+100; i++) { println (b2); b2++; }
 183 acc8= constant 22
 184 acc8=> variable 6
 185 acc16= variable 6
 186 acc16+ constant 100
 187 acc8= constant 123
 188 acc8CompareAcc16
 189 brlt 198
 190 br 193
 191 incr16 variable 6
 192 br 185
 193 acc8= variable 1
 194 call writeLineAcc8
 195 incr8 variable 1
 196 br 191
 197 ;test11.j(37)     for(word i = 16; 114 <  i+100; i--) { println (b2); b2++; }
 198 acc8= constant 16
 199 acc8=> variable 6
 200 acc16= variable 6
 201 acc16+ constant 100
 202 acc8= constant 114
 203 acc8CompareAcc16
 204 brge 213
 205 br 208
 206 decr16 variable 6
 207 br 200
 208 acc8= variable 1
 209 call writeLineAcc8
 210 incr8 variable 1
 211 br 206
 212 ;test11.j(38)     for(word i = 14; 113 <= i+100; i--) { println (b2); b2++; }
 213 acc8= constant 14
 214 acc8=> variable 6
 215 acc16= variable 6
 216 acc16+ constant 100
 217 acc8= constant 113
 218 acc8CompareAcc16
 219 brgt 231
 220 br 223
 221 decr16 variable 6
 222 br 215
 223 acc8= variable 1
 224 call writeLineAcc8
 225 incr8 variable 1
 226 br 221
 227 ;test11.j(39)     // integer - byte
 228 ;test11.j(40)     // not relevant
 229 ;test11.j(41)     // integer - integer
 230 ;test11.j(42)     for(word i = 12; 1012 == i+1000; i--) { println (b2); b2++; }
 231 acc8= constant 12
 232 acc8=> variable 6
 233 acc16= variable 6
 234 acc16+ constant 1000
 235 acc16Comp constant 1012
 236 brne 245
 237 br 240
 238 decr16 variable 6
 239 br 233
 240 acc8= variable 1
 241 call writeLineAcc8
 242 incr8 variable 1
 243 br 238
 244 ;test11.j(43)     for(word i = 11; 1008 != i+1000; i--) { println (b2); b2++; }
 245 acc8= constant 11
 246 acc8=> variable 6
 247 acc16= variable 6
 248 acc16+ constant 1000
 249 acc16Comp constant 1008
 250 breq 259
 251 br 254
 252 decr16 variable 6
 253 br 247
 254 acc8= variable 1
 255 call writeLineAcc8
 256 incr8 variable 1
 257 br 252
 258 ;test11.j(44)     for(word i = 8; 1010 > i+1000; i++) { println (b2); b2++; }
 259 acc8= constant 8
 260 acc8=> variable 6
 261 acc16= variable 6
 262 acc16+ constant 1000
 263 acc16Comp constant 1010
 264 brge 273
 265 br 268
 266 incr16 variable 6
 267 br 261
 268 acc8= variable 1
 269 call writeLineAcc8
 270 incr8 variable 1
 271 br 266
 272 ;test11.j(45)     for(word i = 10; 1011 >= i+1000; i++) { println (b2); b2++; }
 273 acc8= constant 10
 274 acc8=> variable 6
 275 acc16= variable 6
 276 acc16+ constant 1000
 277 acc16Comp constant 1011
 278 brgt 287
 279 br 282
 280 incr16 variable 6
 281 br 275
 282 acc8= variable 1
 283 call writeLineAcc8
 284 incr8 variable 1
 285 br 280
 286 ;test11.j(46)     for(word i = 4; 1002 <  i+1000; i--) { println (b2); b2++; }
 287 acc8= constant 4
 288 acc8=> variable 6
 289 acc16= variable 6
 290 acc16+ constant 1000
 291 acc16Comp constant 1002
 292 brle 301
 293 br 296
 294 decr16 variable 6
 295 br 289
 296 acc8= variable 1
 297 call writeLineAcc8
 298 incr8 variable 1
 299 br 294
 300 ;test11.j(47)     for(word i = 2; 1001 <= i+1000; i--) { println (b2); b2++; }
 301 acc8= constant 2
 302 acc8=> variable 6
 303 acc16= variable 6
 304 acc16+ constant 1000
 305 acc16Comp constant 1001
 306 brlt 319
 307 br 310
 308 decr16 variable 6
 309 br 303
 310 acc8= variable 1
 311 call writeLineAcc8
 312 incr8 variable 1
 313 br 308
 314 ;test11.j(48)   
 315 ;test11.j(49)     /************************/
 316 ;test11.j(50)     // constant - var
 317 ;test11.j(51)     // byte - byte
 318 ;test11.j(52)     for (byte b = 42; 41 <= b; b--) { println (b2); b2++; }
 319 acc8= constant 42
 320 acc8=> variable 6
 321 acc8= variable 6
 322 acc8Comp constant 41
 323 brlt 333
 324 br 327
 325 decr8 variable 6
 326 br 321
 327 acc8= variable 1
 328 call writeLineAcc8
 329 incr8 variable 1
 330 br 325
 331 ;test11.j(53)     // byte - integer
 332 ;test11.j(54)     for(word i = 40; 39 <= i; i--) { println (b2); b2++; }
 333 acc8= constant 40
 334 acc8=> variable 6
 335 acc16= variable 6
 336 acc8= constant 39
 337 acc8CompareAcc16
 338 brgt 350
 339 br 342
 340 decr16 variable 6
 341 br 335
 342 acc8= variable 1
 343 call writeLineAcc8
 344 incr8 variable 1
 345 br 340
 346 ;test11.j(55)     // integer - byte
 347 ;test11.j(56)     // not relevant
 348 ;test11.j(57)     // integer - integer
 349 ;test11.j(58)     for(word i = 1038; 1037 <= i; i--) { println (b2); b2++; }
 350 acc16= constant 1038
 351 acc16=> variable 6
 352 acc16= variable 6
 353 acc16Comp constant 1037
 354 brlt 368
 355 br 358
 356 decr16 variable 6
 357 br 352
 358 acc8= variable 1
 359 call writeLineAcc8
 360 incr8 variable 1
 361 br 356
 362 ;test11.j(59)   
 363 ;test11.j(60)     /************************/
 364 ;test11.j(61)     // constant - stack8
 365 ;test11.j(62)     // byte - byte
 366 ;test11.j(63)     //TODO
 367 ;test11.j(64)     println(43);
 368 acc8= constant 43
 369 call writeLineAcc8
 370 ;test11.j(65)     println(44);
 371 acc8= constant 44
 372 call writeLineAcc8
 373 ;test11.j(66)     // constant - stack8
 374 ;test11.j(67)     // byte - integer
 375 ;test11.j(68)     //TODO
 376 ;test11.j(69)     println(45);
 377 acc8= constant 45
 378 call writeLineAcc8
 379 ;test11.j(70)     println(46);
 380 acc8= constant 46
 381 call writeLineAcc8
 382 ;test11.j(71)     // constant - stack8
 383 ;test11.j(72)     // integer - byte
 384 ;test11.j(73)     //TODO
 385 ;test11.j(74)     println(47);
 386 acc8= constant 47
 387 call writeLineAcc8
 388 ;test11.j(75)     println(48);
 389 acc8= constant 48
 390 call writeLineAcc8
 391 ;test11.j(76)     // constant - stack88
 392 ;test11.j(77)     // integer - integer
 393 ;test11.j(78)     //TODO
 394 ;test11.j(79)     println(49);
 395 acc8= constant 49
 396 call writeLineAcc8
 397 ;test11.j(80)     println(50);
 398 acc8= constant 50
 399 call writeLineAcc8
 400 ;test11.j(81)   
 401 ;test11.j(82)     /************************/
 402 ;test11.j(83)     // constant - stack16
 403 ;test11.j(84)     // byte - byte
 404 ;test11.j(85)     //TODO
 405 ;test11.j(86)     println(51);
 406 acc8= constant 51
 407 call writeLineAcc8
 408 ;test11.j(87)     println(52);
 409 acc8= constant 52
 410 call writeLineAcc8
 411 ;test11.j(88)     // constant - stack16
 412 ;test11.j(89)     // byte - integer
 413 ;test11.j(90)     //TODO
 414 ;test11.j(91)     println(53);
 415 acc8= constant 53
 416 call writeLineAcc8
 417 ;test11.j(92)     println(54);
 418 acc8= constant 54
 419 call writeLineAcc8
 420 ;test11.j(93)     // constant - stack16
 421 ;test11.j(94)     // integer - byte
 422 ;test11.j(95)     //TODO
 423 ;test11.j(96)     println(55);
 424 acc8= constant 55
 425 call writeLineAcc8
 426 ;test11.j(97)     println(56);
 427 acc8= constant 56
 428 call writeLineAcc8
 429 ;test11.j(98)     // constant - stack16
 430 ;test11.j(99)     // integer - integer
 431 ;test11.j(100)     //TODO
 432 ;test11.j(101)     println(57);
 433 acc8= constant 57
 434 call writeLineAcc8
 435 ;test11.j(102)     println(58);
 436 acc8= constant 58
 437 call writeLineAcc8
 438 ;test11.j(103)   
 439 ;test11.j(104)     /************************/
 440 ;test11.j(105)     // acc - constant
 441 ;test11.j(106)     // byte - byte
 442 ;test11.j(107)     b2 = 59;
 443 acc8= constant 59
 444 acc8=> variable 1
 445 ;test11.j(108)     for (byte b = 56; b+0 <= 57; b++) { println (b2); b2++; }
 446 acc8= constant 56
 447 acc8=> variable 6
 448 acc8= variable 6
 449 acc8+ constant 0
 450 acc8Comp constant 57
 451 brgt 463
 452 br 455
 453 incr8 variable 6
 454 br 448
 455 acc8= variable 1
 456 call writeLineAcc8
 457 incr8 variable 1
 458 br 453
 459 ;test11.j(109)     // byte - integer
 460 ;test11.j(110)     //not relevant
 461 ;test11.j(111)     // integer - byte
 462 ;test11.j(112)     for (word i = 54; i+0 <= 55; i++) { println (b2); b2++;}
 463 acc8= constant 54
 464 acc8=> variable 6
 465 acc16= variable 6
 466 acc16+ constant 0
 467 acc8= constant 55
 468 acc16CompareAcc8
 469 brgt 479
 470 br 473
 471 incr16 variable 6
 472 br 465
 473 acc8= variable 1
 474 call writeLineAcc8
 475 incr8 variable 1
 476 br 471
 477 ;test11.j(113)     // integer - integer
 478 ;test11.j(114)     for(word i = 1052; i+0 <= 1053; i++) { println (b2); b2++; }
 479 acc16= constant 1052
 480 acc16=> variable 6
 481 acc16= variable 6
 482 acc16+ constant 0
 483 acc16Comp constant 1053
 484 brgt 497
 485 br 488
 486 incr16 variable 6
 487 br 481
 488 acc8= variable 1
 489 call writeLineAcc8
 490 incr8 variable 1
 491 br 486
 492 ;test11.j(115)   
 493 ;test11.j(116)     /************************/
 494 ;test11.j(117)     // acc - acc
 495 ;test11.j(118)     // byte - byte
 496 ;test11.j(119)     for (byte b = 64; 63+0 <= b+0; b--) { println (b2); b2++; }
 497 acc8= constant 64
 498 acc8=> variable 6
 499 acc8= constant 63
 500 acc8+ constant 0
 501 <acc8
 502 acc8= variable 6
 503 acc8+ constant 0
 504 revAcc8Comp unstack8
 505 brlt 515
 506 br 509
 507 decr8 variable 6
 508 br 499
 509 acc8= variable 1
 510 call writeLineAcc8
 511 incr8 variable 1
 512 br 507
 513 ;test11.j(120)     // byte - integer
 514 ;test11.j(121)     for(word i = 62; 61+0 <= i+0; i--) { println (b2); b2++; }
 515 acc8= constant 62
 516 acc8=> variable 6
 517 acc8= constant 61
 518 acc8+ constant 0
 519 <acc8
 520 acc16= variable 6
 521 acc16+ constant 0
 522 acc8= unstack8
 523 acc8CompareAcc16
 524 brgt 534
 525 br 528
 526 decr16 variable 6
 527 br 517
 528 acc8= variable 1
 529 call writeLineAcc8
 530 incr8 variable 1
 531 br 526
 532 ;test11.j(122)     // integer - byte
 533 ;test11.j(123)     i2=59;
 534 acc8= constant 59
 535 acc8=> variable 2
 536 ;test11.j(124)     for (byte b = 60; i2+0 <= b+0; b--) { println (b2); b2++; }
 537 acc8= constant 60
 538 acc8=> variable 6
 539 acc16= variable 2
 540 acc16+ constant 0
 541 <acc16
 542 acc8= variable 6
 543 acc8+ constant 0
 544 acc16= unstack16
 545 acc16CompareAcc8
 546 brgt 556
 547 br 550
 548 decr8 variable 6
 549 br 539
 550 acc8= variable 1
 551 call writeLineAcc8
 552 incr8 variable 1
 553 br 548
 554 ;test11.j(125)     // integer - integer
 555 ;test11.j(126)     for(word i = 1058; 1000+57 <= i+0; i--) { println (b2); b2++; }
 556 acc16= constant 1058
 557 acc16=> variable 6
 558 acc16= constant 1000
 559 acc16+ constant 57
 560 <acc16
 561 acc16= variable 6
 562 acc16+ constant 0
 563 revAcc16Comp unstack16
 564 brlt 577
 565 br 568
 566 decr16 variable 6
 567 br 558
 568 acc8= variable 1
 569 call writeLineAcc8
 570 incr8 variable 1
 571 br 566
 572 ;test11.j(127)   
 573 ;test11.j(128)     /************************/
 574 ;test11.j(129)     // acc - var
 575 ;test11.j(130)     // byte - byte
 576 ;test11.j(131)     for (byte b = 72; 71+0 <= b; b--) { println (b2); b2++; }
 577 acc8= constant 72
 578 acc8=> variable 6
 579 acc8= constant 71
 580 acc8+ constant 0
 581 acc8Comp variable 6
 582 brgt 592
 583 br 586
 584 decr8 variable 6
 585 br 579
 586 acc8= variable 1
 587 call writeLineAcc8
 588 incr8 variable 1
 589 br 584
 590 ;test11.j(132)     // byte - integer
 591 ;test11.j(133)     for(word i = 70; 69+0 <= i; i--) { println (b2); b2++; }
 592 acc8= constant 70
 593 acc8=> variable 6
 594 acc8= constant 69
 595 acc8+ constant 0
 596 acc16= variable 6
 597 acc8CompareAcc16
 598 brgt 608
 599 br 602
 600 decr16 variable 6
 601 br 594
 602 acc8= variable 1
 603 call writeLineAcc8
 604 incr8 variable 1
 605 br 600
 606 ;test11.j(134)     // integer - byte
 607 ;test11.j(135)     i2=67;
 608 acc8= constant 67
 609 acc8=> variable 2
 610 ;test11.j(136)     for (byte b = 68; i2+0 <= b; b--) { println (b2); b2++; }
 611 acc8= constant 68
 612 acc8=> variable 6
 613 acc16= variable 2
 614 acc16+ constant 0
 615 acc8= variable 6
 616 acc16CompareAcc8
 617 brgt 627
 618 br 621
 619 decr8 variable 6
 620 br 613
 621 acc8= variable 1
 622 call writeLineAcc8
 623 incr8 variable 1
 624 br 619
 625 ;test11.j(137)     // integer - integer
 626 ;test11.j(138)     for(word i = 1066; 1000+65 <= i; i--) { println (b2); b2++; }
 627 acc16= constant 1066
 628 acc16=> variable 6
 629 acc16= constant 1000
 630 acc16+ constant 65
 631 acc16Comp variable 6
 632 brgt 646
 633 br 636
 634 decr16 variable 6
 635 br 629
 636 acc8= variable 1
 637 call writeLineAcc8
 638 incr8 variable 1
 639 br 634
 640 ;test11.j(139)   
 641 ;test11.j(140)     /************************/
 642 ;test11.j(141)     // acc - stack8
 643 ;test11.j(142)     // byte - byte
 644 ;test11.j(143)     //TODO
 645 ;test11.j(144)     println(81);
 646 acc8= constant 81
 647 call writeLineAcc8
 648 ;test11.j(145)     println(82);
 649 acc8= constant 82
 650 call writeLineAcc8
 651 ;test11.j(146)     // byte - integer
 652 ;test11.j(147)     //TODO
 653 ;test11.j(148)     println(83);
 654 acc8= constant 83
 655 call writeLineAcc8
 656 ;test11.j(149)     println(84);
 657 acc8= constant 84
 658 call writeLineAcc8
 659 ;test11.j(150)     // integer - byte
 660 ;test11.j(151)     //TODO
 661 ;test11.j(152)     println(85);
 662 acc8= constant 85
 663 call writeLineAcc8
 664 ;test11.j(153)     println(86);
 665 acc8= constant 86
 666 call writeLineAcc8
 667 ;test11.j(154)     // integer - integer
 668 ;test11.j(155)     //TODO
 669 ;test11.j(156)     println(87);
 670 acc8= constant 87
 671 call writeLineAcc8
 672 ;test11.j(157)     println(88);
 673 acc8= constant 88
 674 call writeLineAcc8
 675 ;test11.j(158)   
 676 ;test11.j(159)     /************************/
 677 ;test11.j(160)     // acc - stack16
 678 ;test11.j(161)     // byte - byte
 679 ;test11.j(162)     //TODO
 680 ;test11.j(163)     println(89);
 681 acc8= constant 89
 682 call writeLineAcc8
 683 ;test11.j(164)     println(90);
 684 acc8= constant 90
 685 call writeLineAcc8
 686 ;test11.j(165)     // byte - integer
 687 ;test11.j(166)     //TODO
 688 ;test11.j(167)     println(91);
 689 acc8= constant 91
 690 call writeLineAcc8
 691 ;test11.j(168)     println(92);
 692 acc8= constant 92
 693 call writeLineAcc8
 694 ;test11.j(169)     // integer - byte
 695 ;test11.j(170)     //TODO
 696 ;test11.j(171)     println(93);
 697 acc8= constant 93
 698 call writeLineAcc8
 699 ;test11.j(172)     println(94);
 700 acc8= constant 94
 701 call writeLineAcc8
 702 ;test11.j(173)     // integer - integer
 703 ;test11.j(174)     //TODO
 704 ;test11.j(175)     println(95);
 705 acc8= constant 95
 706 call writeLineAcc8
 707 ;test11.j(176)     println(96);
 708 acc8= constant 96
 709 call writeLineAcc8
 710 ;test11.j(177)   
 711 ;test11.j(178)     /************************/
 712 ;test11.j(179)     // var - constant
 713 ;test11.j(180)     // byte - byte
 714 ;test11.j(181)     b2=97;
 715 acc8= constant 97
 716 acc8=> variable 1
 717 ;test11.j(182)     for (byte b = 96; b <= 97; b++) { println (b2); b2++; }
 718 acc8= constant 96
 719 acc8=> variable 6
 720 acc8= variable 6
 721 acc8Comp constant 97
 722 brgt 734
 723 br 726
 724 incr8 variable 6
 725 br 720
 726 acc8= variable 1
 727 call writeLineAcc8
 728 incr8 variable 1
 729 br 724
 730 ;test11.j(183)     // byte - integer
 731 ;test11.j(184)     //not relevant
 732 ;test11.j(185)     // integer - byte
 733 ;test11.j(186)     for(word i = 92; i <= 93; i++) { println (b2); b2++; }
 734 acc8= constant 92
 735 acc8=> variable 6
 736 acc16= variable 6
 737 acc8= constant 93
 738 acc16CompareAcc8
 739 brgt 749
 740 br 743
 741 incr16 variable 6
 742 br 736
 743 acc8= variable 1
 744 call writeLineAcc8
 745 incr8 variable 1
 746 br 741
 747 ;test11.j(187)     // integer - integer
 748 ;test11.j(188)     for(word i = 1090; i <= 1091; i++) { println (b2); b2++; }
 749 acc16= constant 1090
 750 acc16=> variable 6
 751 acc16= variable 6
 752 acc16Comp constant 1091
 753 brgt 766
 754 br 757
 755 incr16 variable 6
 756 br 751
 757 acc8= variable 1
 758 call writeLineAcc8
 759 incr8 variable 1
 760 br 755
 761 ;test11.j(189)   
 762 ;test11.j(190)     /************************/
 763 ;test11.j(191)     // var - acc
 764 ;test11.j(192)     // byte - byte
 765 ;test11.j(193)     for (byte b = 104; b <= 105+0; b++) { println (b2); b2++; }
 766 acc8= constant 104
 767 acc8=> variable 6
 768 acc8= constant 105
 769 acc8+ constant 0
 770 acc8Comp variable 6
 771 brlt 781
 772 br 775
 773 incr8 variable 6
 774 br 768
 775 acc8= variable 1
 776 call writeLineAcc8
 777 incr8 variable 1
 778 br 773
 779 ;test11.j(194)     // byte - integer
 780 ;test11.j(195)     i2=103;
 781 acc8= constant 103
 782 acc8=> variable 2
 783 ;test11.j(196)     for (byte b = 102; b <= i2+0; b++) { println (b2); b2++; }
 784 acc8= constant 102
 785 acc8=> variable 6
 786 acc16= variable 2
 787 acc16+ constant 0
 788 acc8= variable 6
 789 acc8CompareAcc16
 790 brgt 800
 791 br 794
 792 incr8 variable 6
 793 br 786
 794 acc8= variable 1
 795 call writeLineAcc8
 796 incr8 variable 1
 797 br 792
 798 ;test11.j(197)     // integer - byte
 799 ;test11.j(198)     for(word i = 100; i <= 101+0; i++) { println (b2); b2++; }
 800 acc8= constant 100
 801 acc8=> variable 6
 802 acc8= constant 101
 803 acc8+ constant 0
 804 acc16= variable 6
 805 acc16CompareAcc8
 806 brgt 816
 807 br 810
 808 incr16 variable 6
 809 br 802
 810 acc8= variable 1
 811 call writeLineAcc8
 812 incr8 variable 1
 813 br 808
 814 ;test11.j(199)     // integer - integer
 815 ;test11.j(200)     for(word i = 1098; i <= 1099+0; i++) { println (b2); b2++; }
 816 acc16= constant 1098
 817 acc16=> variable 6
 818 acc16= constant 1099
 819 acc16+ constant 0
 820 acc16Comp variable 6
 821 brlt 834
 822 br 825
 823 incr16 variable 6
 824 br 818
 825 acc8= variable 1
 826 call writeLineAcc8
 827 incr8 variable 1
 828 br 823
 829 ;test11.j(201)   
 830 ;test11.j(202)     /************************/
 831 ;test11.j(203)     // var - var
 832 ;test11.j(204)     // byte - byte
 833 ;test11.j(205)     for (byte b = 112; b2 <= b; b--) { println (b2); b2++; }
 834 acc8= constant 112
 835 acc8=> variable 6
 836 acc8= variable 1
 837 acc8Comp variable 6
 838 brgt 848
 839 br 842
 840 decr8 variable 6
 841 br 836
 842 acc8= variable 1
 843 call writeLineAcc8
 844 incr8 variable 1
 845 br 840
 846 ;test11.j(206)     // byte - integer
 847 ;test11.j(207)     for(word i = 116; b2 <= i; i--) { println (b2); b2++; }
 848 acc8= constant 116
 849 acc8=> variable 6
 850 acc8= variable 1
 851 acc16= variable 6
 852 acc8CompareAcc16
 853 brgt 863
 854 br 857
 855 decr16 variable 6
 856 br 850
 857 acc8= variable 1
 858 call writeLineAcc8
 859 incr8 variable 1
 860 br 855
 861 ;test11.j(208)     // integer - byte
 862 ;test11.j(209)     i2=b2;
 863 acc8= variable 1
 864 acc8=> variable 2
 865 ;test11.j(210)     for (byte b = 118; i2 <= b; b--) { println (b2); b2++; }
 866 acc8= constant 118
 867 acc8=> variable 6
 868 acc16= variable 2
 869 acc8= variable 6
 870 acc16CompareAcc8
 871 brgt 881
 872 br 875
 873 decr8 variable 6
 874 br 868
 875 acc8= variable 1
 876 call writeLineAcc8
 877 incr8 variable 1
 878 br 873
 879 ;test11.j(211)     // integer - integer
 880 ;test11.j(212)     i2=120;
 881 acc8= constant 120
 882 acc8=> variable 2
 883 ;test11.j(213)     for(word i = b2+4; i2 <= i; i--) { println (b2); b2++; }
 884 acc8= variable 1
 885 acc8+ constant 4
 886 acc8=> variable 6
 887 acc16= variable 2
 888 acc16Comp variable 6
 889 brgt 931
 890 br 893
 891 decr16 variable 6
 892 br 887
 893 acc8= variable 1
 894 call writeLineAcc8
 895 incr8 variable 1
 896 br 891
 897 ;test11.j(214)   
 898 ;test11.j(215)     /************************/
 899 ;test11.j(216)     // var - stack8
 900 ;test11.j(217)     // byte - byte
 901 ;test11.j(218)     // byte - integer
 902 ;test11.j(219)     // integer - byte
 903 ;test11.j(220)     // integer - integer
 904 ;test11.j(221)     //TODO
 905 ;test11.j(222)   
 906 ;test11.j(223)     /************************/
 907 ;test11.j(224)     // var - stack16
 908 ;test11.j(225)     // byte - byte
 909 ;test11.j(226)     // byte - integer
 910 ;test11.j(227)     // integer - byte
 911 ;test11.j(228)     // integer - integer
 912 ;test11.j(229)     //TODO
 913 ;test11.j(230)   
 914 ;test11.j(231)     /************************/
 915 ;test11.j(232)     // stack8 - constant
 916 ;test11.j(233)     // stack8 - acc
 917 ;test11.j(234)     // stack8 - var
 918 ;test11.j(235)     // stack8 - stack8
 919 ;test11.j(236)     // stack8 - stack16
 920 ;test11.j(237)     //TODO
 921 ;test11.j(238)   
 922 ;test11.j(239)     /************************/
 923 ;test11.j(240)     // stack16 - constant
 924 ;test11.j(241)     // stack16 - acc
 925 ;test11.j(242)     // stack16 - var
 926 ;test11.j(243)     // stack16 - stack8
 927 ;test11.j(244)     // stack16 - stack16
 928 ;test11.j(245)     //TODO
 929 ;test11.j(246)   
 930 ;test11.j(247)     println("Klaar.");
 931 acc16= constant 936
 932 writeLineString
 933 ;test11.j(248)   }
 934 ;test11.j(249) }
 935 stop
 936 stringConstant 0 = "Klaar."
