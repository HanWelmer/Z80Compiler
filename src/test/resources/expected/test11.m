   0 call 19
   1 stop
   2 ;test11.j(0) /* Program to test generated Z80 assembler code */
   3 ;test11.j(1) class TestFor {
   4 class TestFor []
   5 ;test11.j(2)   private static byte b1 = 1;
   6 acc8= constant 1
   7 acc8=> variable 0
   8 ;test11.j(3)   private static byte b2 = 1;
   9 acc8= constant 1
  10 acc8=> variable 1
  11 ;test11.j(4)   private static word i2 = 1;
  12 acc8= constant 1
  13 acc8=> variable 2
  14 ;test11.j(5)   private static word p = 1;
  15 acc8= constant 1
  16 acc8=> variable 4
  17 ;test11.j(6) 
  18 ;test11.j(7)   public static void main() {
  19 method main [public, static] void
  20 ;test11.j(8)     println(0);
  21 acc8= constant 0
  22 call writeLineAcc8
  23 ;test11.j(9)   
  24 ;test11.j(10)     /************************/
  25 ;test11.j(11)     // global variable within for scope
  26 ;test11.j(12)     for (byte b = 1; b <= 2; b++) {
  27 acc8= constant 1
  28 acc8=> variable 6
  29 acc8= variable 6
  30 acc8Comp constant 2
  31 brgt 54
  32 br 35
  33 incr8 variable 6
  34 br 29
  35 ;test11.j(13)       byte c = b1;
  36 acc8= variable 0
  37 acc8=> variable 7
  38 ;test11.j(14)       println (c);
  39 acc8= variable 7
  40 call writeLineAcc8
  41 ;test11.j(15)       b1++;
  42 incr8 variable 0
  43 br 33
  44 ;test11.j(16)     }
  45 ;test11.j(17)   
  46 ;test11.j(18)     /************************/
  47 ;test11.j(19)     // constant - constant
  48 ;test11.j(20)     // not relevant
  49 ;test11.j(21)   
  50 ;test11.j(22)     /************************/
  51 ;test11.j(23)     // constant - acc
  52 ;test11.j(24)     // byte - byte
  53 ;test11.j(25)     for (byte b = 3; 103 == b+100; b++) { println (b); }
  54 acc8= constant 3
  55 acc8=> variable 6
  56 acc8= variable 6
  57 acc8+ constant 100
  58 acc8Comp constant 103
  59 brne 67
  60 br 63
  61 incr8 variable 6
  62 br 56
  63 acc8= variable 6
  64 call writeLineAcc8
  65 br 61
  66 ;test11.j(26)     for (byte b = 4; 105 != b+100; b++) { println (b); }
  67 acc8= constant 4
  68 acc8=> variable 6
  69 acc8= variable 6
  70 acc8+ constant 100
  71 acc8Comp constant 105
  72 breq 80
  73 br 76
  74 incr8 variable 6
  75 br 69
  76 acc8= variable 6
  77 call writeLineAcc8
  78 br 74
  79 ;test11.j(27)     b2=5;
  80 acc8= constant 5
  81 acc8=> variable 1
  82 ;test11.j(28)     for (byte b = 32; 134 > b+100; b++) { println (b2); b2++; }
  83 acc8= constant 32
  84 acc8=> variable 6
  85 acc8= variable 6
  86 acc8+ constant 100
  87 acc8Comp constant 134
  88 brge 97
  89 br 92
  90 incr8 variable 6
  91 br 85
  92 acc8= variable 1
  93 call writeLineAcc8
  94 incr8 variable 1
  95 br 90
  96 ;test11.j(29)     for (byte b = 34; 135 >= b+100; b++) { println (b2); b2++; }
  97 acc8= constant 34
  98 acc8=> variable 6
  99 acc8= variable 6
 100 acc8+ constant 100
 101 acc8Comp constant 135
 102 brgt 111
 103 br 106
 104 incr8 variable 6
 105 br 99
 106 acc8= variable 1
 107 call writeLineAcc8
 108 incr8 variable 1
 109 br 104
 110 ;test11.j(30)     for (byte b = 28; 126 <  b+100; b--) { println (b2); b2++; }
 111 acc8= constant 28
 112 acc8=> variable 6
 113 acc8= variable 6
 114 acc8+ constant 100
 115 acc8Comp constant 126
 116 brle 125
 117 br 120
 118 decr8 variable 6
 119 br 113
 120 acc8= variable 1
 121 call writeLineAcc8
 122 incr8 variable 1
 123 br 118
 124 ;test11.j(31)     for (byte b = 26; 125 <= b+100; b--) { println (b2); b2++; }
 125 acc8= constant 26
 126 acc8=> variable 6
 127 acc8= variable 6
 128 acc8+ constant 100
 129 acc8Comp constant 125
 130 brlt 140
 131 br 134
 132 decr8 variable 6
 133 br 127
 134 acc8= variable 1
 135 call writeLineAcc8
 136 incr8 variable 1
 137 br 132
 138 ;test11.j(32)     // byte - integer
 139 ;test11.j(33)     for(word i = 24; 24  == i+0; i--) { println (b2); b2++; }
 140 acc8= constant 24
 141 acc8=> variable 6
 142 acc16= variable 6
 143 acc16+ constant 0
 144 acc8= constant 24
 145 acc8CompareAcc16
 146 brne 155
 147 br 150
 148 decr16 variable 6
 149 br 142
 150 acc8= variable 1
 151 call writeLineAcc8
 152 incr8 variable 1
 153 br 148
 154 ;test11.j(34)     for(word i = 23; 120 != i+100; i--) { println (b2); b2++; }
 155 acc8= constant 23
 156 acc8=> variable 6
 157 acc16= variable 6
 158 acc16+ constant 100
 159 acc8= constant 120
 160 acc8CompareAcc16
 161 breq 170
 162 br 165
 163 decr16 variable 6
 164 br 157
 165 acc8= variable 1
 166 call writeLineAcc8
 167 incr8 variable 1
 168 br 163
 169 ;test11.j(35)     for(word i = 20; 122 > i+100; i++) { println (b2); b2++; }
 170 acc8= constant 20
 171 acc8=> variable 6
 172 acc16= variable 6
 173 acc16+ constant 100
 174 acc8= constant 122
 175 acc8CompareAcc16
 176 brle 185
 177 br 180
 178 incr16 variable 6
 179 br 172
 180 acc8= variable 1
 181 call writeLineAcc8
 182 incr8 variable 1
 183 br 178
 184 ;test11.j(36)     for(word i = 22; 123 >= i+100; i++) { println (b2); b2++; }
 185 acc8= constant 22
 186 acc8=> variable 6
 187 acc16= variable 6
 188 acc16+ constant 100
 189 acc8= constant 123
 190 acc8CompareAcc16
 191 brlt 200
 192 br 195
 193 incr16 variable 6
 194 br 187
 195 acc8= variable 1
 196 call writeLineAcc8
 197 incr8 variable 1
 198 br 193
 199 ;test11.j(37)     for(word i = 16; 114 <  i+100; i--) { println (b2); b2++; }
 200 acc8= constant 16
 201 acc8=> variable 6
 202 acc16= variable 6
 203 acc16+ constant 100
 204 acc8= constant 114
 205 acc8CompareAcc16
 206 brge 215
 207 br 210
 208 decr16 variable 6
 209 br 202
 210 acc8= variable 1
 211 call writeLineAcc8
 212 incr8 variable 1
 213 br 208
 214 ;test11.j(38)     for(word i = 14; 113 <= i+100; i--) { println (b2); b2++; }
 215 acc8= constant 14
 216 acc8=> variable 6
 217 acc16= variable 6
 218 acc16+ constant 100
 219 acc8= constant 113
 220 acc8CompareAcc16
 221 brgt 233
 222 br 225
 223 decr16 variable 6
 224 br 217
 225 acc8= variable 1
 226 call writeLineAcc8
 227 incr8 variable 1
 228 br 223
 229 ;test11.j(39)     // integer - byte
 230 ;test11.j(40)     // not relevant
 231 ;test11.j(41)     // integer - integer
 232 ;test11.j(42)     for(word i = 12; 1012 == i+1000; i--) { println (b2); b2++; }
 233 acc8= constant 12
 234 acc8=> variable 6
 235 acc16= variable 6
 236 acc16+ constant 1000
 237 acc16Comp constant 1012
 238 brne 247
 239 br 242
 240 decr16 variable 6
 241 br 235
 242 acc8= variable 1
 243 call writeLineAcc8
 244 incr8 variable 1
 245 br 240
 246 ;test11.j(43)     for(word i = 11; 1008 != i+1000; i--) { println (b2); b2++; }
 247 acc8= constant 11
 248 acc8=> variable 6
 249 acc16= variable 6
 250 acc16+ constant 1000
 251 acc16Comp constant 1008
 252 breq 261
 253 br 256
 254 decr16 variable 6
 255 br 249
 256 acc8= variable 1
 257 call writeLineAcc8
 258 incr8 variable 1
 259 br 254
 260 ;test11.j(44)     for(word i = 8; 1010 > i+1000; i++) { println (b2); b2++; }
 261 acc8= constant 8
 262 acc8=> variable 6
 263 acc16= variable 6
 264 acc16+ constant 1000
 265 acc16Comp constant 1010
 266 brge 275
 267 br 270
 268 incr16 variable 6
 269 br 263
 270 acc8= variable 1
 271 call writeLineAcc8
 272 incr8 variable 1
 273 br 268
 274 ;test11.j(45)     for(word i = 10; 1011 >= i+1000; i++) { println (b2); b2++; }
 275 acc8= constant 10
 276 acc8=> variable 6
 277 acc16= variable 6
 278 acc16+ constant 1000
 279 acc16Comp constant 1011
 280 brgt 289
 281 br 284
 282 incr16 variable 6
 283 br 277
 284 acc8= variable 1
 285 call writeLineAcc8
 286 incr8 variable 1
 287 br 282
 288 ;test11.j(46)     for(word i = 4; 1002 <  i+1000; i--) { println (b2); b2++; }
 289 acc8= constant 4
 290 acc8=> variable 6
 291 acc16= variable 6
 292 acc16+ constant 1000
 293 acc16Comp constant 1002
 294 brle 303
 295 br 298
 296 decr16 variable 6
 297 br 291
 298 acc8= variable 1
 299 call writeLineAcc8
 300 incr8 variable 1
 301 br 296
 302 ;test11.j(47)     for(word i = 2; 1001 <= i+1000; i--) { println (b2); b2++; }
 303 acc8= constant 2
 304 acc8=> variable 6
 305 acc16= variable 6
 306 acc16+ constant 1000
 307 acc16Comp constant 1001
 308 brlt 321
 309 br 312
 310 decr16 variable 6
 311 br 305
 312 acc8= variable 1
 313 call writeLineAcc8
 314 incr8 variable 1
 315 br 310
 316 ;test11.j(48)   
 317 ;test11.j(49)     /************************/
 318 ;test11.j(50)     // constant - var
 319 ;test11.j(51)     // byte - byte
 320 ;test11.j(52)     for (byte b = 42; 41 <= b; b--) { println (b2); b2++; }
 321 acc8= constant 42
 322 acc8=> variable 6
 323 acc8= variable 6
 324 acc8Comp constant 41
 325 brlt 335
 326 br 329
 327 decr8 variable 6
 328 br 323
 329 acc8= variable 1
 330 call writeLineAcc8
 331 incr8 variable 1
 332 br 327
 333 ;test11.j(53)     // byte - integer
 334 ;test11.j(54)     for(word i = 40; 39 <= i; i--) { println (b2); b2++; }
 335 acc8= constant 40
 336 acc8=> variable 6
 337 acc16= variable 6
 338 acc8= constant 39
 339 acc8CompareAcc16
 340 brgt 352
 341 br 344
 342 decr16 variable 6
 343 br 337
 344 acc8= variable 1
 345 call writeLineAcc8
 346 incr8 variable 1
 347 br 342
 348 ;test11.j(55)     // integer - byte
 349 ;test11.j(56)     // not relevant
 350 ;test11.j(57)     // integer - integer
 351 ;test11.j(58)     for(word i = 1038; 1037 <= i; i--) { println (b2); b2++; }
 352 acc16= constant 1038
 353 acc16=> variable 6
 354 acc16= variable 6
 355 acc16Comp constant 1037
 356 brlt 370
 357 br 360
 358 decr16 variable 6
 359 br 354
 360 acc8= variable 1
 361 call writeLineAcc8
 362 incr8 variable 1
 363 br 358
 364 ;test11.j(59)   
 365 ;test11.j(60)     /************************/
 366 ;test11.j(61)     // constant - stack8
 367 ;test11.j(62)     // byte - byte
 368 ;test11.j(63)     //TODO
 369 ;test11.j(64)     println(43);
 370 acc8= constant 43
 371 call writeLineAcc8
 372 ;test11.j(65)     println(44);
 373 acc8= constant 44
 374 call writeLineAcc8
 375 ;test11.j(66)     // constant - stack8
 376 ;test11.j(67)     // byte - integer
 377 ;test11.j(68)     //TODO
 378 ;test11.j(69)     println(45);
 379 acc8= constant 45
 380 call writeLineAcc8
 381 ;test11.j(70)     println(46);
 382 acc8= constant 46
 383 call writeLineAcc8
 384 ;test11.j(71)     // constant - stack8
 385 ;test11.j(72)     // integer - byte
 386 ;test11.j(73)     //TODO
 387 ;test11.j(74)     println(47);
 388 acc8= constant 47
 389 call writeLineAcc8
 390 ;test11.j(75)     println(48);
 391 acc8= constant 48
 392 call writeLineAcc8
 393 ;test11.j(76)     // constant - stack88
 394 ;test11.j(77)     // integer - integer
 395 ;test11.j(78)     //TODO
 396 ;test11.j(79)     println(49);
 397 acc8= constant 49
 398 call writeLineAcc8
 399 ;test11.j(80)     println(50);
 400 acc8= constant 50
 401 call writeLineAcc8
 402 ;test11.j(81)   
 403 ;test11.j(82)     /************************/
 404 ;test11.j(83)     // constant - stack16
 405 ;test11.j(84)     // byte - byte
 406 ;test11.j(85)     //TODO
 407 ;test11.j(86)     println(51);
 408 acc8= constant 51
 409 call writeLineAcc8
 410 ;test11.j(87)     println(52);
 411 acc8= constant 52
 412 call writeLineAcc8
 413 ;test11.j(88)     // constant - stack16
 414 ;test11.j(89)     // byte - integer
 415 ;test11.j(90)     //TODO
 416 ;test11.j(91)     println(53);
 417 acc8= constant 53
 418 call writeLineAcc8
 419 ;test11.j(92)     println(54);
 420 acc8= constant 54
 421 call writeLineAcc8
 422 ;test11.j(93)     // constant - stack16
 423 ;test11.j(94)     // integer - byte
 424 ;test11.j(95)     //TODO
 425 ;test11.j(96)     println(55);
 426 acc8= constant 55
 427 call writeLineAcc8
 428 ;test11.j(97)     println(56);
 429 acc8= constant 56
 430 call writeLineAcc8
 431 ;test11.j(98)     // constant - stack16
 432 ;test11.j(99)     // integer - integer
 433 ;test11.j(100)     //TODO
 434 ;test11.j(101)     println(57);
 435 acc8= constant 57
 436 call writeLineAcc8
 437 ;test11.j(102)     println(58);
 438 acc8= constant 58
 439 call writeLineAcc8
 440 ;test11.j(103)   
 441 ;test11.j(104)     /************************/
 442 ;test11.j(105)     // acc - constant
 443 ;test11.j(106)     // byte - byte
 444 ;test11.j(107)     b2 = 59;
 445 acc8= constant 59
 446 acc8=> variable 1
 447 ;test11.j(108)     for (byte b = 56; b+0 <= 57; b++) { println (b2); b2++; }
 448 acc8= constant 56
 449 acc8=> variable 6
 450 acc8= variable 6
 451 acc8+ constant 0
 452 acc8Comp constant 57
 453 brgt 467
 454 br 459
 455 incr8 variable 6
 456 br 450
 457 acc8= variable 1
 458 call writeLineAcc8
 459 incr8 variable 1
 460 br 457
 461 ;test11.j(109)     // byte - integer
 462 ;test11.j(110)     //not relevant
 463 ;test11.j(111)     // integer - byte
 464 ;test11.j(112)     for (word i = 54; i+0 <= 55; i++) { println (b2); b2++;}
 465 acc8= constant 54
 466 acc8=> variable 6
 467 acc16= variable 6
 468 acc16+ constant 0
 469 acc8= constant 55
 470 acc16CompareAcc8
 471 brgt 485
 472 br 479
 473 incr16 variable 6
 474 br 469
 475 acc8= variable 1
 476 call writeLineAcc8
 477 incr8 variable 1
 478 br 477
 479 ;test11.j(113)     // integer - integer
 480 ;test11.j(114)     for(word i = 1052; i+0 <= 1053; i++) { println (b2); b2++; }
 481 acc16= constant 1052
 482 acc16=> variable 6
 483 acc16= variable 6
 484 acc16+ constant 0
 485 acc16Comp constant 1053
 486 brgt 505
 487 br 496
 488 incr16 variable 6
 489 br 487
 490 acc8= variable 1
 491 call writeLineAcc8
 492 incr8 variable 1
 493 br 494
 494 ;test11.j(115)   
 495 ;test11.j(116)     /************************/
 496 ;test11.j(117)     // acc - acc
 497 ;test11.j(118)     // byte - byte
 498 ;test11.j(119)     for (byte b = 64; 63+0 <= b+0; b--) { println (b2); b2++; }
 499 acc8= constant 64
 500 acc8=> variable 6
 501 acc8= constant 63
 502 acc8+ constant 0
 503 <acc8
 504 acc8= variable 6
 505 acc8+ constant 0
 506 revAcc8Comp unstack8
 507 brlt 523
 508 br 517
 509 decr8 variable 6
 510 br 507
 511 acc8= variable 1
 512 call writeLineAcc8
 513 incr8 variable 1
 514 br 515
 515 ;test11.j(120)     // byte - integer
 516 ;test11.j(121)     for(word i = 62; 61+0 <= i+0; i--) { println (b2); b2++; }
 517 acc8= constant 62
 518 acc8=> variable 6
 519 acc8= constant 61
 520 acc8+ constant 0
 521 <acc8
 522 acc16= variable 6
 523 acc16+ constant 0
 524 acc8= unstack8
 525 acc8CompareAcc16
 526 brgt 542
 527 br 536
 528 decr16 variable 6
 529 br 525
 530 acc8= variable 1
 531 call writeLineAcc8
 532 incr8 variable 1
 533 br 534
 534 ;test11.j(122)     // integer - byte
 535 ;test11.j(123)     i2=59;
 536 acc8= constant 59
 537 acc8=> variable 2
 538 ;test11.j(124)     for (byte b = 60; i2+0 <= b+0; b--) { println (b2); b2++; }
 539 acc8= constant 60
 540 acc8=> variable 6
 541 acc16= variable 2
 542 acc16+ constant 0
 543 <acc16
 544 acc8= variable 6
 545 acc8+ constant 0
 546 acc16= unstack16
 547 acc16CompareAcc8
 548 brgt 564
 549 br 558
 550 decr8 variable 6
 551 br 547
 552 acc8= variable 1
 553 call writeLineAcc8
 554 incr8 variable 1
 555 br 556
 556 ;test11.j(125)     // integer - integer
 557 ;test11.j(126)     for(word i = 1058; 1000+57 <= i+0; i--) { println (b2); b2++; }
 558 acc16= constant 1058
 559 acc16=> variable 6
 560 acc16= constant 1000
 561 acc16+ constant 57
 562 <acc16
 563 acc16= variable 6
 564 acc16+ constant 0
 565 revAcc16Comp unstack16
 566 brlt 585
 567 br 576
 568 decr16 variable 6
 569 br 566
 570 acc8= variable 1
 571 call writeLineAcc8
 572 incr8 variable 1
 573 br 574
 574 ;test11.j(127)   
 575 ;test11.j(128)     /************************/
 576 ;test11.j(129)     // acc - var
 577 ;test11.j(130)     // byte - byte
 578 ;test11.j(131)     for (byte b = 72; 71+0 <= b; b--) { println (b2); b2++; }
 579 acc8= constant 72
 580 acc8=> variable 6
 581 acc8= constant 71
 582 acc8+ constant 0
 583 acc8Comp variable 6
 584 brgt 602
 585 br 596
 586 decr8 variable 6
 587 br 587
 588 acc8= variable 1
 589 call writeLineAcc8
 590 incr8 variable 1
 591 br 594
 592 ;test11.j(132)     // byte - integer
 593 ;test11.j(133)     for(word i = 70; 69+0 <= i; i--) { println (b2); b2++; }
 594 acc8= constant 70
 595 acc8=> variable 6
 596 acc8= constant 69
 597 acc8+ constant 0
 598 acc16= variable 6
 599 acc8CompareAcc16
 600 brgt 620
 601 br 614
 602 decr16 variable 6
 603 br 604
 604 acc8= variable 1
 605 call writeLineAcc8
 606 incr8 variable 1
 607 br 612
 608 ;test11.j(134)     // integer - byte
 609 ;test11.j(135)     i2=67;
 610 acc8= constant 67
 611 acc8=> variable 2
 612 ;test11.j(136)     for (byte b = 68; i2+0 <= b; b--) { println (b2); b2++; }
 613 acc8= constant 68
 614 acc8=> variable 6
 615 acc16= variable 2
 616 acc16+ constant 0
 617 acc8= variable 6
 618 acc16CompareAcc8
 619 brgt 641
 620 br 635
 621 decr8 variable 6
 622 br 625
 623 acc8= variable 1
 624 call writeLineAcc8
 625 incr8 variable 1
 626 br 633
 627 ;test11.j(137)     // integer - integer
 628 ;test11.j(138)     for(word i = 1066; 1000+65 <= i; i--) { println (b2); b2++; }
 629 acc16= constant 1066
 630 acc16=> variable 6
 631 acc16= constant 1000
 632 acc16+ constant 65
 633 acc16Comp variable 6
 634 brgt 662
 635 br 652
 636 decr16 variable 6
 637 br 643
 638 acc8= variable 1
 639 call writeLineAcc8
 640 incr8 variable 1
 641 br 650
 642 ;test11.j(139)   
 643 ;test11.j(140)     /************************/
 644 ;test11.j(141)     // acc - stack8
 645 ;test11.j(142)     // byte - byte
 646 ;test11.j(143)     //TODO
 647 ;test11.j(144)     println(81);
 648 acc8= constant 81
 649 call writeLineAcc8
 650 ;test11.j(145)     println(82);
 651 acc8= constant 82
 652 call writeLineAcc8
 653 ;test11.j(146)     // byte - integer
 654 ;test11.j(147)     //TODO
 655 ;test11.j(148)     println(83);
 656 acc8= constant 83
 657 call writeLineAcc8
 658 ;test11.j(149)     println(84);
 659 acc8= constant 84
 660 call writeLineAcc8
 661 ;test11.j(150)     // integer - byte
 662 ;test11.j(151)     //TODO
 663 ;test11.j(152)     println(85);
 664 acc8= constant 85
 665 call writeLineAcc8
 666 ;test11.j(153)     println(86);
 667 acc8= constant 86
 668 call writeLineAcc8
 669 ;test11.j(154)     // integer - integer
 670 ;test11.j(155)     //TODO
 671 ;test11.j(156)     println(87);
 672 acc8= constant 87
 673 call writeLineAcc8
 674 ;test11.j(157)     println(88);
 675 acc8= constant 88
 676 call writeLineAcc8
 677 ;test11.j(158)   
 678 ;test11.j(159)     /************************/
 679 ;test11.j(160)     // acc - stack16
 680 ;test11.j(161)     // byte - byte
 681 ;test11.j(162)     //TODO
 682 ;test11.j(163)     println(89);
 683 acc8= constant 89
 684 call writeLineAcc8
 685 ;test11.j(164)     println(90);
 686 acc8= constant 90
 687 call writeLineAcc8
 688 ;test11.j(165)     // byte - integer
 689 ;test11.j(166)     //TODO
 690 ;test11.j(167)     println(91);
 691 acc8= constant 91
 692 call writeLineAcc8
 693 ;test11.j(168)     println(92);
 694 acc8= constant 92
 695 call writeLineAcc8
 696 ;test11.j(169)     // integer - byte
 697 ;test11.j(170)     //TODO
 698 ;test11.j(171)     println(93);
 699 acc8= constant 93
 700 call writeLineAcc8
 701 ;test11.j(172)     println(94);
 702 acc8= constant 94
 703 call writeLineAcc8
 704 ;test11.j(173)     // integer - integer
 705 ;test11.j(174)     //TODO
 706 ;test11.j(175)     println(95);
 707 acc8= constant 95
 708 call writeLineAcc8
 709 ;test11.j(176)     println(96);
 710 acc8= constant 96
 711 call writeLineAcc8
 712 ;test11.j(177)   
 713 ;test11.j(178)     /************************/
 714 ;test11.j(179)     // var - constant
 715 ;test11.j(180)     // byte - byte
 716 ;test11.j(181)     b2=97;
 717 acc8= constant 97
 718 acc8=> variable 1
 719 ;test11.j(182)     for (byte b = 96; b <= 97; b++) { println (b2); b2++; }
 720 acc8= constant 96
 721 acc8=> variable 6
 722 acc8= variable 6
 723 acc8Comp constant 97
 724 brgt 750
 725 br 742
 726 incr8 variable 6
 727 br 736
 728 acc8= variable 1
 729 call writeLineAcc8
 730 incr8 variable 1
 731 br 740
 732 ;test11.j(183)     // byte - integer
 733 ;test11.j(184)     //not relevant
 734 ;test11.j(185)     // integer - byte
 735 ;test11.j(186)     for(word i = 92; i <= 93; i++) { println (b2); b2++; }
 736 acc8= constant 92
 737 acc8=> variable 6
 738 acc16= variable 6
 739 acc8= constant 93
 740 acc16CompareAcc8
 741 brgt 765
 742 br 759
 743 incr16 variable 6
 744 br 752
 745 acc8= variable 1
 746 call writeLineAcc8
 747 incr8 variable 1
 748 br 757
 749 ;test11.j(187)     // integer - integer
 750 ;test11.j(188)     for(word i = 1090; i <= 1091; i++) { println (b2); b2++; }
 751 acc16= constant 1090
 752 acc16=> variable 6
 753 acc16= variable 6
 754 acc16Comp constant 1091
 755 brgt 782
 756 br 773
 757 incr16 variable 6
 758 br 767
 759 acc8= variable 1
 760 call writeLineAcc8
 761 incr8 variable 1
 762 br 771
 763 ;test11.j(189)   
 764 ;test11.j(190)     /************************/
 765 ;test11.j(191)     // var - acc
 766 ;test11.j(192)     // byte - byte
 767 ;test11.j(193)     for (byte b = 104; b <= 105+0; b++) { println (b2); b2++; }
 768 acc8= constant 104
 769 acc8=> variable 6
 770 acc8= constant 105
 771 acc8+ constant 0
 772 acc8Comp variable 6
 773 brlt 797
 774 br 791
 775 incr8 variable 6
 776 br 784
 777 acc8= variable 1
 778 call writeLineAcc8
 779 incr8 variable 1
 780 br 789
 781 ;test11.j(194)     // byte - integer
 782 ;test11.j(195)     i2=103;
 783 acc8= constant 103
 784 acc8=> variable 2
 785 ;test11.j(196)     for (byte b = 102; b <= i2+0; b++) { println (b2); b2++; }
 786 acc8= constant 102
 787 acc8=> variable 6
 788 acc16= variable 2
 789 acc16+ constant 0
 790 acc8= variable 6
 791 acc8CompareAcc16
 792 brgt 816
 793 br 810
 794 incr8 variable 6
 795 br 802
 796 acc8= variable 1
 797 call writeLineAcc8
 798 incr8 variable 1
 799 br 808
 800 ;test11.j(197)     // integer - byte
 801 ;test11.j(198)     for(word i = 100; i <= 101+0; i++) { println (b2); b2++; }
 802 acc8= constant 100
 803 acc8=> variable 6
 804 acc8= constant 101
 805 acc8+ constant 0
 806 acc16= variable 6
 807 acc16CompareAcc8
 808 brgt 832
 809 br 826
 810 incr16 variable 6
 811 br 818
 812 acc8= variable 1
 813 call writeLineAcc8
 814 incr8 variable 1
 815 br 824
 816 ;test11.j(199)     // integer - integer
 817 ;test11.j(200)     for(word i = 1098; i <= 1099+0; i++) { println (b2); b2++; }
 818 acc16= constant 1098
 819 acc16=> variable 6
 820 acc16= constant 1099
 821 acc16+ constant 0
 822 acc16Comp variable 6
 823 brlt 850
 824 br 841
 825 incr16 variable 6
 826 br 834
 827 acc8= variable 1
 828 call writeLineAcc8
 829 incr8 variable 1
 830 br 839
 831 ;test11.j(201)   
 832 ;test11.j(202)     /************************/
 833 ;test11.j(203)     // var - var
 834 ;test11.j(204)     // byte - byte
 835 ;test11.j(205)     for (byte b = 112; b2 <= b; b--) { println (b2); b2++; }
 836 acc8= constant 112
 837 acc8=> variable 6
 838 acc8= variable 1
 839 acc8Comp variable 6
 840 brgt 864
 841 br 858
 842 decr8 variable 6
 843 br 852
 844 acc8= variable 1
 845 call writeLineAcc8
 846 incr8 variable 1
 847 br 856
 848 ;test11.j(206)     // byte - integer
 849 ;test11.j(207)     for(word i = 116; b2 <= i; i--) { println (b2); b2++; }
 850 acc8= constant 116
 851 acc8=> variable 6
 852 acc8= variable 1
 853 acc16= variable 6
 854 acc8CompareAcc16
 855 brgt 879
 856 br 873
 857 decr16 variable 6
 858 br 866
 859 acc8= variable 1
 860 call writeLineAcc8
 861 incr8 variable 1
 862 br 871
 863 ;test11.j(208)     // integer - byte
 864 ;test11.j(209)     i2=b2;
 865 acc8= variable 1
 866 acc8=> variable 2
 867 ;test11.j(210)     for (byte b = 118; i2 <= b; b--) { println (b2); b2++; }
 868 acc8= constant 118
 869 acc8=> variable 6
 870 acc16= variable 2
 871 acc8= variable 6
 872 acc16CompareAcc8
 873 brgt 897
 874 br 891
 875 decr8 variable 6
 876 br 884
 877 acc8= variable 1
 878 call writeLineAcc8
 879 incr8 variable 1
 880 br 889
 881 ;test11.j(211)     // integer - integer
 882 ;test11.j(212)     i2=120;
 883 acc8= constant 120
 884 acc8=> variable 2
 885 ;test11.j(213)     for(word i = b2+4; i2 <= i; i--) { println (b2); b2++; }
 886 acc8= variable 1
 887 acc8+ constant 4
 888 acc8=> variable 6
 889 acc16= variable 2
 890 acc16Comp variable 6
 891 brgt 947
 892 br 909
 893 decr16 variable 6
 894 br 903
 895 acc8= variable 1
 896 call writeLineAcc8
 897 incr8 variable 1
 898 br 907
 899 ;test11.j(214)   
 900 ;test11.j(215)     /************************/
 901 ;test11.j(216)     // var - stack8
 902 ;test11.j(217)     // byte - byte
 903 ;test11.j(218)     // byte - integer
 904 ;test11.j(219)     // integer - byte
 905 ;test11.j(220)     // integer - integer
 906 ;test11.j(221)     //TODO
 907 ;test11.j(222)   
 908 ;test11.j(223)     /************************/
 909 ;test11.j(224)     // var - stack16
 910 ;test11.j(225)     // byte - byte
 911 ;test11.j(226)     // byte - integer
 912 ;test11.j(227)     // integer - byte
 913 ;test11.j(228)     // integer - integer
 914 ;test11.j(229)     //TODO
 915 ;test11.j(230)   
 916 ;test11.j(231)     /************************/
 917 ;test11.j(232)     // stack8 - constant
 918 ;test11.j(233)     // stack8 - acc
 919 ;test11.j(234)     // stack8 - var
 920 ;test11.j(235)     // stack8 - stack8
 921 ;test11.j(236)     // stack8 - stack16
 922 ;test11.j(237)     //TODO
 923 ;test11.j(238)   
 924 ;test11.j(239)     /************************/
 925 ;test11.j(240)     // stack16 - constant
 926 ;test11.j(241)     // stack16 - acc
 927 ;test11.j(242)     // stack16 - var
 928 ;test11.j(243)     // stack16 - stack8
 929 ;test11.j(244)     // stack16 - stack16
 930 ;test11.j(245)     //TODO
 931 ;test11.j(246)   
 932 ;test11.j(247)     println("Klaar.");
 933 acc16= constant 938
 934 writeLineString
 935 return
 936 ;test11.j(248)   }
 937 ;test11.j(249) }
 938 stringConstant 0 = "Klaar."
