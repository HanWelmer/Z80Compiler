   0 ;test11.j(0) /* Program to test generated Z80 assembler code */
   1 ;test11.j(1) class TestFor {
   2 ;test11.j(2)   private static byte b1 = 1;
   3 acc8= constant 1
   4 acc8=> variable 0
   5 ;test11.j(3)   private static byte b2 = 1;
   6 acc8= constant 1
   7 acc8=> variable 1
   8 ;test11.j(4)   private static word i2 = 1;
   9 acc8= constant 1
  10 acc8=> variable 2
  11 ;test11.j(5)   private static word p = 1;
  12 acc8= constant 1
  13 acc8=> variable 4
  14 ;test11.j(6) 
  15 ;test11.j(7)   public static void main() {
  16 ;test11.j(8)     println(0);
  17 acc8= constant 0
  18 call writeLineAcc8
  19 ;test11.j(9)   
  20 ;test11.j(10)     /************************/
  21 ;test11.j(11)     // global variable within for scope
  22 ;test11.j(12)     for (byte b = 1; b <= 2; b++) {
  23 acc8= constant 1
  24 acc8=> variable 6
  25 acc8= variable 6
  26 acc8Comp constant 2
  27 brgt 50
  28 br 31
  29 incr8 variable 6
  30 br 25
  31 ;test11.j(13)       byte c = b1;
  32 acc8= variable 0
  33 acc8=> variable 7
  34 ;test11.j(14)       println (c);
  35 acc8= variable 7
  36 call writeLineAcc8
  37 ;test11.j(15)       b1++;
  38 incr8 variable 0
  39 ;test11.j(16)     }
  40 br 29
  41 ;test11.j(17)   
  42 ;test11.j(18)     /************************/
  43 ;test11.j(19)     // constant - constant
  44 ;test11.j(20)     // not relevant
  45 ;test11.j(21)   
  46 ;test11.j(22)     /************************/
  47 ;test11.j(23)     // constant - acc
  48 ;test11.j(24)     // byte - byte
  49 ;test11.j(25)     for (byte b = 3; 103 == b+100; b++) { println (b); }
  50 acc8= constant 3
  51 acc8=> variable 6
  52 acc8= variable 6
  53 acc8+ constant 100
  54 acc8Comp constant 103
  55 brne 63
  56 br 59
  57 incr8 variable 6
  58 br 52
  59 acc8= variable 6
  60 call writeLineAcc8
  61 br 57
  62 ;test11.j(26)     for (byte b = 4; 105 != b+100; b++) { println (b); }
  63 acc8= constant 4
  64 acc8=> variable 6
  65 acc8= variable 6
  66 acc8+ constant 100
  67 acc8Comp constant 105
  68 breq 76
  69 br 72
  70 incr8 variable 6
  71 br 65
  72 acc8= variable 6
  73 call writeLineAcc8
  74 br 70
  75 ;test11.j(27)     b2=5;
  76 acc8= constant 5
  77 acc8=> variable 1
  78 ;test11.j(28)     for (byte b = 32; 134 > b+100; b++) { println (b2); b2++; }
  79 acc8= constant 32
  80 acc8=> variable 6
  81 acc8= variable 6
  82 acc8+ constant 100
  83 acc8Comp constant 134
  84 brge 93
  85 br 88
  86 incr8 variable 6
  87 br 81
  88 acc8= variable 1
  89 call writeLineAcc8
  90 incr8 variable 1
  91 br 86
  92 ;test11.j(29)     for (byte b = 34; 135 >= b+100; b++) { println (b2); b2++; }
  93 acc8= constant 34
  94 acc8=> variable 6
  95 acc8= variable 6
  96 acc8+ constant 100
  97 acc8Comp constant 135
  98 brgt 107
  99 br 102
 100 incr8 variable 6
 101 br 95
 102 acc8= variable 1
 103 call writeLineAcc8
 104 incr8 variable 1
 105 br 100
 106 ;test11.j(30)     for (byte b = 28; 126 <  b+100; b--) { println (b2); b2++; }
 107 acc8= constant 28
 108 acc8=> variable 6
 109 acc8= variable 6
 110 acc8+ constant 100
 111 acc8Comp constant 126
 112 brle 121
 113 br 116
 114 decr8 variable 6
 115 br 109
 116 acc8= variable 1
 117 call writeLineAcc8
 118 incr8 variable 1
 119 br 114
 120 ;test11.j(31)     for (byte b = 26; 125 <= b+100; b--) { println (b2); b2++; }
 121 acc8= constant 26
 122 acc8=> variable 6
 123 acc8= variable 6
 124 acc8+ constant 100
 125 acc8Comp constant 125
 126 brlt 136
 127 br 130
 128 decr8 variable 6
 129 br 123
 130 acc8= variable 1
 131 call writeLineAcc8
 132 incr8 variable 1
 133 br 128
 134 ;test11.j(32)     // byte - integer
 135 ;test11.j(33)     for(word i = 24; 24  == i+0; i--) { println (b2); b2++; }
 136 acc8= constant 24
 137 acc8=> variable 6
 138 acc16= variable 6
 139 acc16+ constant 0
 140 acc8= constant 24
 141 acc8CompareAcc16
 142 brne 151
 143 br 146
 144 decr16 variable 6
 145 br 138
 146 acc8= variable 1
 147 call writeLineAcc8
 148 incr8 variable 1
 149 br 144
 150 ;test11.j(34)     for(word i = 23; 120 != i+100; i--) { println (b2); b2++; }
 151 acc8= constant 23
 152 acc8=> variable 6
 153 acc16= variable 6
 154 acc16+ constant 100
 155 acc8= constant 120
 156 acc8CompareAcc16
 157 breq 166
 158 br 161
 159 decr16 variable 6
 160 br 153
 161 acc8= variable 1
 162 call writeLineAcc8
 163 incr8 variable 1
 164 br 159
 165 ;test11.j(35)     for(word i = 20; 122 > i+100; i++) { println (b2); b2++; }
 166 acc8= constant 20
 167 acc8=> variable 6
 168 acc16= variable 6
 169 acc16+ constant 100
 170 acc8= constant 122
 171 acc8CompareAcc16
 172 brle 181
 173 br 176
 174 incr16 variable 6
 175 br 168
 176 acc8= variable 1
 177 call writeLineAcc8
 178 incr8 variable 1
 179 br 174
 180 ;test11.j(36)     for(word i = 22; 123 >= i+100; i++) { println (b2); b2++; }
 181 acc8= constant 22
 182 acc8=> variable 6
 183 acc16= variable 6
 184 acc16+ constant 100
 185 acc8= constant 123
 186 acc8CompareAcc16
 187 brlt 196
 188 br 191
 189 incr16 variable 6
 190 br 183
 191 acc8= variable 1
 192 call writeLineAcc8
 193 incr8 variable 1
 194 br 189
 195 ;test11.j(37)     for(word i = 16; 114 <  i+100; i--) { println (b2); b2++; }
 196 acc8= constant 16
 197 acc8=> variable 6
 198 acc16= variable 6
 199 acc16+ constant 100
 200 acc8= constant 114
 201 acc8CompareAcc16
 202 brge 211
 203 br 206
 204 decr16 variable 6
 205 br 198
 206 acc8= variable 1
 207 call writeLineAcc8
 208 incr8 variable 1
 209 br 204
 210 ;test11.j(38)     for(word i = 14; 113 <= i+100; i--) { println (b2); b2++; }
 211 acc8= constant 14
 212 acc8=> variable 6
 213 acc16= variable 6
 214 acc16+ constant 100
 215 acc8= constant 113
 216 acc8CompareAcc16
 217 brgt 229
 218 br 221
 219 decr16 variable 6
 220 br 213
 221 acc8= variable 1
 222 call writeLineAcc8
 223 incr8 variable 1
 224 br 219
 225 ;test11.j(39)     // integer - byte
 226 ;test11.j(40)     // not relevant
 227 ;test11.j(41)     // integer - integer
 228 ;test11.j(42)     for(word i = 12; 1012 == i+1000; i--) { println (b2); b2++; }
 229 acc8= constant 12
 230 acc8=> variable 6
 231 acc16= variable 6
 232 acc16+ constant 1000
 233 acc16Comp constant 1012
 234 brne 243
 235 br 238
 236 decr16 variable 6
 237 br 231
 238 acc8= variable 1
 239 call writeLineAcc8
 240 incr8 variable 1
 241 br 236
 242 ;test11.j(43)     for(word i = 11; 1008 != i+1000; i--) { println (b2); b2++; }
 243 acc8= constant 11
 244 acc8=> variable 6
 245 acc16= variable 6
 246 acc16+ constant 1000
 247 acc16Comp constant 1008
 248 breq 257
 249 br 252
 250 decr16 variable 6
 251 br 245
 252 acc8= variable 1
 253 call writeLineAcc8
 254 incr8 variable 1
 255 br 250
 256 ;test11.j(44)     for(word i = 8; 1010 > i+1000; i++) { println (b2); b2++; }
 257 acc8= constant 8
 258 acc8=> variable 6
 259 acc16= variable 6
 260 acc16+ constant 1000
 261 acc16Comp constant 1010
 262 brge 271
 263 br 266
 264 incr16 variable 6
 265 br 259
 266 acc8= variable 1
 267 call writeLineAcc8
 268 incr8 variable 1
 269 br 264
 270 ;test11.j(45)     for(word i = 10; 1011 >= i+1000; i++) { println (b2); b2++; }
 271 acc8= constant 10
 272 acc8=> variable 6
 273 acc16= variable 6
 274 acc16+ constant 1000
 275 acc16Comp constant 1011
 276 brgt 285
 277 br 280
 278 incr16 variable 6
 279 br 273
 280 acc8= variable 1
 281 call writeLineAcc8
 282 incr8 variable 1
 283 br 278
 284 ;test11.j(46)     for(word i = 4; 1002 <  i+1000; i--) { println (b2); b2++; }
 285 acc8= constant 4
 286 acc8=> variable 6
 287 acc16= variable 6
 288 acc16+ constant 1000
 289 acc16Comp constant 1002
 290 brle 299
 291 br 294
 292 decr16 variable 6
 293 br 287
 294 acc8= variable 1
 295 call writeLineAcc8
 296 incr8 variable 1
 297 br 292
 298 ;test11.j(47)     for(word i = 2; 1001 <= i+1000; i--) { println (b2); b2++; }
 299 acc8= constant 2
 300 acc8=> variable 6
 301 acc16= variable 6
 302 acc16+ constant 1000
 303 acc16Comp constant 1001
 304 brlt 317
 305 br 308
 306 decr16 variable 6
 307 br 301
 308 acc8= variable 1
 309 call writeLineAcc8
 310 incr8 variable 1
 311 br 306
 312 ;test11.j(48)   
 313 ;test11.j(49)     /************************/
 314 ;test11.j(50)     // constant - var
 315 ;test11.j(51)     // byte - byte
 316 ;test11.j(52)     for (byte b = 42; 41 <= b; b--) { println (b2); b2++; }
 317 acc8= constant 42
 318 acc8=> variable 6
 319 acc8= variable 6
 320 acc8Comp constant 41
 321 brlt 331
 322 br 325
 323 decr8 variable 6
 324 br 319
 325 acc8= variable 1
 326 call writeLineAcc8
 327 incr8 variable 1
 328 br 323
 329 ;test11.j(53)     // byte - integer
 330 ;test11.j(54)     for(word i = 40; 39 <= i; i--) { println (b2); b2++; }
 331 acc8= constant 40
 332 acc8=> variable 6
 333 acc16= variable 6
 334 acc8= constant 39
 335 acc8CompareAcc16
 336 brgt 348
 337 br 340
 338 decr16 variable 6
 339 br 333
 340 acc8= variable 1
 341 call writeLineAcc8
 342 incr8 variable 1
 343 br 338
 344 ;test11.j(55)     // integer - byte
 345 ;test11.j(56)     // not relevant
 346 ;test11.j(57)     // integer - integer
 347 ;test11.j(58)     for(word i = 1038; 1037 <= i; i--) { println (b2); b2++; }
 348 acc16= constant 1038
 349 acc16=> variable 6
 350 acc16= variable 6
 351 acc16Comp constant 1037
 352 brlt 366
 353 br 356
 354 decr16 variable 6
 355 br 350
 356 acc8= variable 1
 357 call writeLineAcc8
 358 incr8 variable 1
 359 br 354
 360 ;test11.j(59)   
 361 ;test11.j(60)     /************************/
 362 ;test11.j(61)     // constant - stack8
 363 ;test11.j(62)     // byte - byte
 364 ;test11.j(63)     //TODO
 365 ;test11.j(64)     println(43);
 366 acc8= constant 43
 367 call writeLineAcc8
 368 ;test11.j(65)     println(44);
 369 acc8= constant 44
 370 call writeLineAcc8
 371 ;test11.j(66)     // constant - stack8
 372 ;test11.j(67)     // byte - integer
 373 ;test11.j(68)     //TODO
 374 ;test11.j(69)     println(45);
 375 acc8= constant 45
 376 call writeLineAcc8
 377 ;test11.j(70)     println(46);
 378 acc8= constant 46
 379 call writeLineAcc8
 380 ;test11.j(71)     // constant - stack8
 381 ;test11.j(72)     // integer - byte
 382 ;test11.j(73)     //TODO
 383 ;test11.j(74)     println(47);
 384 acc8= constant 47
 385 call writeLineAcc8
 386 ;test11.j(75)     println(48);
 387 acc8= constant 48
 388 call writeLineAcc8
 389 ;test11.j(76)     // constant - stack88
 390 ;test11.j(77)     // integer - integer
 391 ;test11.j(78)     //TODO
 392 ;test11.j(79)     println(49);
 393 acc8= constant 49
 394 call writeLineAcc8
 395 ;test11.j(80)     println(50);
 396 acc8= constant 50
 397 call writeLineAcc8
 398 ;test11.j(81)   
 399 ;test11.j(82)     /************************/
 400 ;test11.j(83)     // constant - stack16
 401 ;test11.j(84)     // byte - byte
 402 ;test11.j(85)     //TODO
 403 ;test11.j(86)     println(51);
 404 acc8= constant 51
 405 call writeLineAcc8
 406 ;test11.j(87)     println(52);
 407 acc8= constant 52
 408 call writeLineAcc8
 409 ;test11.j(88)     // constant - stack16
 410 ;test11.j(89)     // byte - integer
 411 ;test11.j(90)     //TODO
 412 ;test11.j(91)     println(53);
 413 acc8= constant 53
 414 call writeLineAcc8
 415 ;test11.j(92)     println(54);
 416 acc8= constant 54
 417 call writeLineAcc8
 418 ;test11.j(93)     // constant - stack16
 419 ;test11.j(94)     // integer - byte
 420 ;test11.j(95)     //TODO
 421 ;test11.j(96)     println(55);
 422 acc8= constant 55
 423 call writeLineAcc8
 424 ;test11.j(97)     println(56);
 425 acc8= constant 56
 426 call writeLineAcc8
 427 ;test11.j(98)     // constant - stack16
 428 ;test11.j(99)     // integer - integer
 429 ;test11.j(100)     //TODO
 430 ;test11.j(101)     println(57);
 431 acc8= constant 57
 432 call writeLineAcc8
 433 ;test11.j(102)     println(58);
 434 acc8= constant 58
 435 call writeLineAcc8
 436 ;test11.j(103)   
 437 ;test11.j(104)     /************************/
 438 ;test11.j(105)     // acc - constant
 439 ;test11.j(106)     // byte - byte
 440 ;test11.j(107)     b2 = 59;
 441 acc8= constant 59
 442 acc8=> variable 1
 443 ;test11.j(108)     for (byte b = 56; b+0 <= 57; b++) { println (b2); b2++; }
 444 acc8= constant 56
 445 acc8=> variable 6
 446 acc8= variable 6
 447 acc8+ constant 0
 448 acc8Comp constant 57
 449 brgt 461
 450 br 453
 451 incr8 variable 6
 452 br 446
 453 acc8= variable 1
 454 call writeLineAcc8
 455 incr8 variable 1
 456 br 451
 457 ;test11.j(109)     // byte - integer
 458 ;test11.j(110)     //not relevant
 459 ;test11.j(111)     // integer - byte
 460 ;test11.j(112)     for (word i = 54; i+0 <= 55; i++) { println (b2); b2++;}
 461 acc8= constant 54
 462 acc8=> variable 6
 463 acc16= variable 6
 464 acc16+ constant 0
 465 acc8= constant 55
 466 acc16CompareAcc8
 467 brgt 477
 468 br 471
 469 incr16 variable 6
 470 br 463
 471 acc8= variable 1
 472 call writeLineAcc8
 473 incr8 variable 1
 474 br 469
 475 ;test11.j(113)     // integer - integer
 476 ;test11.j(114)     for(word i = 1052; i+0 <= 1053; i++) { println (b2); b2++; }
 477 acc16= constant 1052
 478 acc16=> variable 6
 479 acc16= variable 6
 480 acc16+ constant 0
 481 acc16Comp constant 1053
 482 brgt 495
 483 br 486
 484 incr16 variable 6
 485 br 479
 486 acc8= variable 1
 487 call writeLineAcc8
 488 incr8 variable 1
 489 br 484
 490 ;test11.j(115)   
 491 ;test11.j(116)     /************************/
 492 ;test11.j(117)     // acc - acc
 493 ;test11.j(118)     // byte - byte
 494 ;test11.j(119)     for (byte b = 64; 63+0 <= b+0; b--) { println (b2); b2++; }
 495 acc8= constant 64
 496 acc8=> variable 6
 497 acc8= constant 63
 498 acc8+ constant 0
 499 <acc8
 500 acc8= variable 6
 501 acc8+ constant 0
 502 revAcc8Comp unstack8
 503 brlt 513
 504 br 507
 505 decr8 variable 6
 506 br 497
 507 acc8= variable 1
 508 call writeLineAcc8
 509 incr8 variable 1
 510 br 505
 511 ;test11.j(120)     // byte - integer
 512 ;test11.j(121)     for(word i = 62; 61+0 <= i+0; i--) { println (b2); b2++; }
 513 acc8= constant 62
 514 acc8=> variable 6
 515 acc8= constant 61
 516 acc8+ constant 0
 517 <acc8
 518 acc16= variable 6
 519 acc16+ constant 0
 520 acc8= unstack8
 521 acc8CompareAcc16
 522 brgt 532
 523 br 526
 524 decr16 variable 6
 525 br 515
 526 acc8= variable 1
 527 call writeLineAcc8
 528 incr8 variable 1
 529 br 524
 530 ;test11.j(122)     // integer - byte
 531 ;test11.j(123)     i2=59;
 532 acc8= constant 59
 533 acc8=> variable 2
 534 ;test11.j(124)     for (byte b = 60; i2+0 <= b+0; b--) { println (b2); b2++; }
 535 acc8= constant 60
 536 acc8=> variable 6
 537 acc16= variable 2
 538 acc16+ constant 0
 539 <acc16
 540 acc8= variable 6
 541 acc8+ constant 0
 542 acc16= unstack16
 543 acc16CompareAcc8
 544 brgt 554
 545 br 548
 546 decr8 variable 6
 547 br 537
 548 acc8= variable 1
 549 call writeLineAcc8
 550 incr8 variable 1
 551 br 546
 552 ;test11.j(125)     // integer - integer
 553 ;test11.j(126)     for(word i = 1058; 1000+57 <= i+0; i--) { println (b2); b2++; }
 554 acc16= constant 1058
 555 acc16=> variable 6
 556 acc16= constant 1000
 557 acc16+ constant 57
 558 <acc16
 559 acc16= variable 6
 560 acc16+ constant 0
 561 revAcc16Comp unstack16
 562 brlt 575
 563 br 566
 564 decr16 variable 6
 565 br 556
 566 acc8= variable 1
 567 call writeLineAcc8
 568 incr8 variable 1
 569 br 564
 570 ;test11.j(127)   
 571 ;test11.j(128)     /************************/
 572 ;test11.j(129)     // acc - var
 573 ;test11.j(130)     // byte - byte
 574 ;test11.j(131)     for (byte b = 72; 71+0 <= b; b--) { println (b2); b2++; }
 575 acc8= constant 72
 576 acc8=> variable 6
 577 acc8= constant 71
 578 acc8+ constant 0
 579 acc8Comp variable 6
 580 brgt 590
 581 br 584
 582 decr8 variable 6
 583 br 577
 584 acc8= variable 1
 585 call writeLineAcc8
 586 incr8 variable 1
 587 br 582
 588 ;test11.j(132)     // byte - integer
 589 ;test11.j(133)     for(word i = 70; 69+0 <= i; i--) { println (b2); b2++; }
 590 acc8= constant 70
 591 acc8=> variable 6
 592 acc8= constant 69
 593 acc8+ constant 0
 594 acc16= variable 6
 595 acc8CompareAcc16
 596 brgt 606
 597 br 600
 598 decr16 variable 6
 599 br 592
 600 acc8= variable 1
 601 call writeLineAcc8
 602 incr8 variable 1
 603 br 598
 604 ;test11.j(134)     // integer - byte
 605 ;test11.j(135)     i2=67;
 606 acc8= constant 67
 607 acc8=> variable 2
 608 ;test11.j(136)     for (byte b = 68; i2+0 <= b; b--) { println (b2); b2++; }
 609 acc8= constant 68
 610 acc8=> variable 6
 611 acc16= variable 2
 612 acc16+ constant 0
 613 acc8= variable 6
 614 acc16CompareAcc8
 615 brgt 625
 616 br 619
 617 decr8 variable 6
 618 br 611
 619 acc8= variable 1
 620 call writeLineAcc8
 621 incr8 variable 1
 622 br 617
 623 ;test11.j(137)     // integer - integer
 624 ;test11.j(138)     for(word i = 1066; 1000+65 <= i; i--) { println (b2); b2++; }
 625 acc16= constant 1066
 626 acc16=> variable 6
 627 acc16= constant 1000
 628 acc16+ constant 65
 629 acc16Comp variable 6
 630 brgt 644
 631 br 634
 632 decr16 variable 6
 633 br 627
 634 acc8= variable 1
 635 call writeLineAcc8
 636 incr8 variable 1
 637 br 632
 638 ;test11.j(139)   
 639 ;test11.j(140)     /************************/
 640 ;test11.j(141)     // acc - stack8
 641 ;test11.j(142)     // byte - byte
 642 ;test11.j(143)     //TODO
 643 ;test11.j(144)     println(81);
 644 acc8= constant 81
 645 call writeLineAcc8
 646 ;test11.j(145)     println(82);
 647 acc8= constant 82
 648 call writeLineAcc8
 649 ;test11.j(146)     // byte - integer
 650 ;test11.j(147)     //TODO
 651 ;test11.j(148)     println(83);
 652 acc8= constant 83
 653 call writeLineAcc8
 654 ;test11.j(149)     println(84);
 655 acc8= constant 84
 656 call writeLineAcc8
 657 ;test11.j(150)     // integer - byte
 658 ;test11.j(151)     //TODO
 659 ;test11.j(152)     println(85);
 660 acc8= constant 85
 661 call writeLineAcc8
 662 ;test11.j(153)     println(86);
 663 acc8= constant 86
 664 call writeLineAcc8
 665 ;test11.j(154)     // integer - integer
 666 ;test11.j(155)     //TODO
 667 ;test11.j(156)     println(87);
 668 acc8= constant 87
 669 call writeLineAcc8
 670 ;test11.j(157)     println(88);
 671 acc8= constant 88
 672 call writeLineAcc8
 673 ;test11.j(158)   
 674 ;test11.j(159)     /************************/
 675 ;test11.j(160)     // acc - stack16
 676 ;test11.j(161)     // byte - byte
 677 ;test11.j(162)     //TODO
 678 ;test11.j(163)     println(89);
 679 acc8= constant 89
 680 call writeLineAcc8
 681 ;test11.j(164)     println(90);
 682 acc8= constant 90
 683 call writeLineAcc8
 684 ;test11.j(165)     // byte - integer
 685 ;test11.j(166)     //TODO
 686 ;test11.j(167)     println(91);
 687 acc8= constant 91
 688 call writeLineAcc8
 689 ;test11.j(168)     println(92);
 690 acc8= constant 92
 691 call writeLineAcc8
 692 ;test11.j(169)     // integer - byte
 693 ;test11.j(170)     //TODO
 694 ;test11.j(171)     println(93);
 695 acc8= constant 93
 696 call writeLineAcc8
 697 ;test11.j(172)     println(94);
 698 acc8= constant 94
 699 call writeLineAcc8
 700 ;test11.j(173)     // integer - integer
 701 ;test11.j(174)     //TODO
 702 ;test11.j(175)     println(95);
 703 acc8= constant 95
 704 call writeLineAcc8
 705 ;test11.j(176)     println(96);
 706 acc8= constant 96
 707 call writeLineAcc8
 708 ;test11.j(177)   
 709 ;test11.j(178)     /************************/
 710 ;test11.j(179)     // var - constant
 711 ;test11.j(180)     // byte - byte
 712 ;test11.j(181)     b2=97;
 713 acc8= constant 97
 714 acc8=> variable 1
 715 ;test11.j(182)     for (byte b = 96; b <= 97; b++) { println (b2); b2++; }
 716 acc8= constant 96
 717 acc8=> variable 6
 718 acc8= variable 6
 719 acc8Comp constant 97
 720 brgt 732
 721 br 724
 722 incr8 variable 6
 723 br 718
 724 acc8= variable 1
 725 call writeLineAcc8
 726 incr8 variable 1
 727 br 722
 728 ;test11.j(183)     // byte - integer
 729 ;test11.j(184)     //not relevant
 730 ;test11.j(185)     // integer - byte
 731 ;test11.j(186)     for(word i = 92; i <= 93; i++) { println (b2); b2++; }
 732 acc8= constant 92
 733 acc8=> variable 6
 734 acc16= variable 6
 735 acc8= constant 93
 736 acc16CompareAcc8
 737 brgt 747
 738 br 741
 739 incr16 variable 6
 740 br 734
 741 acc8= variable 1
 742 call writeLineAcc8
 743 incr8 variable 1
 744 br 739
 745 ;test11.j(187)     // integer - integer
 746 ;test11.j(188)     for(word i = 1090; i <= 1091; i++) { println (b2); b2++; }
 747 acc16= constant 1090
 748 acc16=> variable 6
 749 acc16= variable 6
 750 acc16Comp constant 1091
 751 brgt 764
 752 br 755
 753 incr16 variable 6
 754 br 749
 755 acc8= variable 1
 756 call writeLineAcc8
 757 incr8 variable 1
 758 br 753
 759 ;test11.j(189)   
 760 ;test11.j(190)     /************************/
 761 ;test11.j(191)     // var - acc
 762 ;test11.j(192)     // byte - byte
 763 ;test11.j(193)     for (byte b = 104; b <= 105+0; b++) { println (b2); b2++; }
 764 acc8= constant 104
 765 acc8=> variable 6
 766 acc8= constant 105
 767 acc8+ constant 0
 768 acc8Comp variable 6
 769 brlt 779
 770 br 773
 771 incr8 variable 6
 772 br 766
 773 acc8= variable 1
 774 call writeLineAcc8
 775 incr8 variable 1
 776 br 771
 777 ;test11.j(194)     // byte - integer
 778 ;test11.j(195)     i2=103;
 779 acc8= constant 103
 780 acc8=> variable 2
 781 ;test11.j(196)     for (byte b = 102; b <= i2+0; b++) { println (b2); b2++; }
 782 acc8= constant 102
 783 acc8=> variable 6
 784 acc16= variable 2
 785 acc16+ constant 0
 786 acc8= variable 6
 787 acc8CompareAcc16
 788 brgt 798
 789 br 792
 790 incr8 variable 6
 791 br 784
 792 acc8= variable 1
 793 call writeLineAcc8
 794 incr8 variable 1
 795 br 790
 796 ;test11.j(197)     // integer - byte
 797 ;test11.j(198)     for(word i = 100; i <= 101+0; i++) { println (b2); b2++; }
 798 acc8= constant 100
 799 acc8=> variable 6
 800 acc8= constant 101
 801 acc8+ constant 0
 802 acc16= variable 6
 803 acc16CompareAcc8
 804 brgt 814
 805 br 808
 806 incr16 variable 6
 807 br 800
 808 acc8= variable 1
 809 call writeLineAcc8
 810 incr8 variable 1
 811 br 806
 812 ;test11.j(199)     // integer - integer
 813 ;test11.j(200)     for(word i = 1098; i <= 1099+0; i++) { println (b2); b2++; }
 814 acc16= constant 1098
 815 acc16=> variable 6
 816 acc16= constant 1099
 817 acc16+ constant 0
 818 acc16Comp variable 6
 819 brlt 832
 820 br 823
 821 incr16 variable 6
 822 br 816
 823 acc8= variable 1
 824 call writeLineAcc8
 825 incr8 variable 1
 826 br 821
 827 ;test11.j(201)   
 828 ;test11.j(202)     /************************/
 829 ;test11.j(203)     // var - var
 830 ;test11.j(204)     // byte - byte
 831 ;test11.j(205)     for (byte b = 112; b2 <= b; b--) { println (b2); b2++; }
 832 acc8= constant 112
 833 acc8=> variable 6
 834 acc8= variable 1
 835 acc8Comp variable 6
 836 brgt 846
 837 br 840
 838 decr8 variable 6
 839 br 834
 840 acc8= variable 1
 841 call writeLineAcc8
 842 incr8 variable 1
 843 br 838
 844 ;test11.j(206)     // byte - integer
 845 ;test11.j(207)     for(word i = 116; b2 <= i; i--) { println (b2); b2++; }
 846 acc8= constant 116
 847 acc8=> variable 6
 848 acc8= variable 1
 849 acc16= variable 6
 850 acc8CompareAcc16
 851 brgt 861
 852 br 855
 853 decr16 variable 6
 854 br 848
 855 acc8= variable 1
 856 call writeLineAcc8
 857 incr8 variable 1
 858 br 853
 859 ;test11.j(208)     // integer - byte
 860 ;test11.j(209)     i2=b2;
 861 acc8= variable 1
 862 acc8=> variable 2
 863 ;test11.j(210)     for (byte b = 118; i2 <= b; b--) { println (b2); b2++; }
 864 acc8= constant 118
 865 acc8=> variable 6
 866 acc16= variable 2
 867 acc8= variable 6
 868 acc16CompareAcc8
 869 brgt 879
 870 br 873
 871 decr8 variable 6
 872 br 866
 873 acc8= variable 1
 874 call writeLineAcc8
 875 incr8 variable 1
 876 br 871
 877 ;test11.j(211)     // integer - integer
 878 ;test11.j(212)     i2=120;
 879 acc8= constant 120
 880 acc8=> variable 2
 881 ;test11.j(213)     for(word i = b2+4; i2 <= i; i--) { println (b2); b2++; }
 882 acc8= variable 1
 883 acc8+ constant 4
 884 acc8=> variable 6
 885 acc16= variable 2
 886 acc16Comp variable 6
 887 brgt 929
 888 br 891
 889 decr16 variable 6
 890 br 885
 891 acc8= variable 1
 892 call writeLineAcc8
 893 incr8 variable 1
 894 br 889
 895 ;test11.j(214)   
 896 ;test11.j(215)     /************************/
 897 ;test11.j(216)     // var - stack8
 898 ;test11.j(217)     // byte - byte
 899 ;test11.j(218)     // byte - integer
 900 ;test11.j(219)     // integer - byte
 901 ;test11.j(220)     // integer - integer
 902 ;test11.j(221)     //TODO
 903 ;test11.j(222)   
 904 ;test11.j(223)     /************************/
 905 ;test11.j(224)     // var - stack16
 906 ;test11.j(225)     // byte - byte
 907 ;test11.j(226)     // byte - integer
 908 ;test11.j(227)     // integer - byte
 909 ;test11.j(228)     // integer - integer
 910 ;test11.j(229)     //TODO
 911 ;test11.j(230)   
 912 ;test11.j(231)     /************************/
 913 ;test11.j(232)     // stack8 - constant
 914 ;test11.j(233)     // stack8 - acc
 915 ;test11.j(234)     // stack8 - var
 916 ;test11.j(235)     // stack8 - stack8
 917 ;test11.j(236)     // stack8 - stack16
 918 ;test11.j(237)     //TODO
 919 ;test11.j(238)   
 920 ;test11.j(239)     /************************/
 921 ;test11.j(240)     // stack16 - constant
 922 ;test11.j(241)     // stack16 - acc
 923 ;test11.j(242)     // stack16 - var
 924 ;test11.j(243)     // stack16 - stack8
 925 ;test11.j(244)     // stack16 - stack16
 926 ;test11.j(245)     //TODO
 927 ;test11.j(246)   
 928 ;test11.j(247)     println("Klaar.");
 929 acc16= constant 934
 930 writeLineString
 931 ;test11.j(248)   }
 932 ;test11.j(249) }
 933 stop
 934 stringConstant 0 = "Klaar."
