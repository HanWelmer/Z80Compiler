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
  16 method main [staticLexeme] voidLexeme
  17 ;test11.j(8)     println(0);
  18 acc8= constant 0
  19 call writeLineAcc8
  20 ;test11.j(9)   
  21 ;test11.j(10)     /************************/
  22 ;test11.j(11)     // global variable within for scope
  23 ;test11.j(12)     for (byte b = 1; b <= 2; b++) {
  24 acc8= constant 1
  25 acc8=> variable 6
  26 acc8= variable 6
  27 acc8Comp constant 2
  28 brgt 51
  29 br 32
  30 incr8 variable 6
  31 br 26
  32 ;test11.j(13)       byte c = b1;
  33 acc8= variable 0
  34 acc8=> variable 7
  35 ;test11.j(14)       println (c);
  36 acc8= variable 7
  37 call writeLineAcc8
  38 ;test11.j(15)       b1++;
  39 incr8 variable 0
  40 ;test11.j(16)     }
  41 br 30
  42 ;test11.j(17)   
  43 ;test11.j(18)     /************************/
  44 ;test11.j(19)     // constant - constant
  45 ;test11.j(20)     // not relevant
  46 ;test11.j(21)   
  47 ;test11.j(22)     /************************/
  48 ;test11.j(23)     // constant - acc
  49 ;test11.j(24)     // byte - byte
  50 ;test11.j(25)     for (byte b = 3; 103 == b+100; b++) { println (b); }
  51 acc8= constant 3
  52 acc8=> variable 6
  53 acc8= variable 6
  54 acc8+ constant 100
  55 acc8Comp constant 103
  56 brne 64
  57 br 60
  58 incr8 variable 6
  59 br 53
  60 acc8= variable 6
  61 call writeLineAcc8
  62 br 58
  63 ;test11.j(26)     for (byte b = 4; 105 != b+100; b++) { println (b); }
  64 acc8= constant 4
  65 acc8=> variable 6
  66 acc8= variable 6
  67 acc8+ constant 100
  68 acc8Comp constant 105
  69 breq 77
  70 br 73
  71 incr8 variable 6
  72 br 66
  73 acc8= variable 6
  74 call writeLineAcc8
  75 br 71
  76 ;test11.j(27)     b2=5;
  77 acc8= constant 5
  78 acc8=> variable 1
  79 ;test11.j(28)     for (byte b = 32; 134 > b+100; b++) { println (b2); b2++; }
  80 acc8= constant 32
  81 acc8=> variable 6
  82 acc8= variable 6
  83 acc8+ constant 100
  84 acc8Comp constant 134
  85 brge 94
  86 br 89
  87 incr8 variable 6
  88 br 82
  89 acc8= variable 1
  90 call writeLineAcc8
  91 incr8 variable 1
  92 br 87
  93 ;test11.j(29)     for (byte b = 34; 135 >= b+100; b++) { println (b2); b2++; }
  94 acc8= constant 34
  95 acc8=> variable 6
  96 acc8= variable 6
  97 acc8+ constant 100
  98 acc8Comp constant 135
  99 brgt 108
 100 br 103
 101 incr8 variable 6
 102 br 96
 103 acc8= variable 1
 104 call writeLineAcc8
 105 incr8 variable 1
 106 br 101
 107 ;test11.j(30)     for (byte b = 28; 126 <  b+100; b--) { println (b2); b2++; }
 108 acc8= constant 28
 109 acc8=> variable 6
 110 acc8= variable 6
 111 acc8+ constant 100
 112 acc8Comp constant 126
 113 brle 122
 114 br 117
 115 decr8 variable 6
 116 br 110
 117 acc8= variable 1
 118 call writeLineAcc8
 119 incr8 variable 1
 120 br 115
 121 ;test11.j(31)     for (byte b = 26; 125 <= b+100; b--) { println (b2); b2++; }
 122 acc8= constant 26
 123 acc8=> variable 6
 124 acc8= variable 6
 125 acc8+ constant 100
 126 acc8Comp constant 125
 127 brlt 137
 128 br 131
 129 decr8 variable 6
 130 br 124
 131 acc8= variable 1
 132 call writeLineAcc8
 133 incr8 variable 1
 134 br 129
 135 ;test11.j(32)     // byte - integer
 136 ;test11.j(33)     for(word i = 24; 24  == i+0; i--) { println (b2); b2++; }
 137 acc8= constant 24
 138 acc8=> variable 6
 139 acc16= variable 6
 140 acc16+ constant 0
 141 acc8= constant 24
 142 acc8CompareAcc16
 143 brne 152
 144 br 147
 145 decr16 variable 6
 146 br 139
 147 acc8= variable 1
 148 call writeLineAcc8
 149 incr8 variable 1
 150 br 145
 151 ;test11.j(34)     for(word i = 23; 120 != i+100; i--) { println (b2); b2++; }
 152 acc8= constant 23
 153 acc8=> variable 6
 154 acc16= variable 6
 155 acc16+ constant 100
 156 acc8= constant 120
 157 acc8CompareAcc16
 158 breq 167
 159 br 162
 160 decr16 variable 6
 161 br 154
 162 acc8= variable 1
 163 call writeLineAcc8
 164 incr8 variable 1
 165 br 160
 166 ;test11.j(35)     for(word i = 20; 122 > i+100; i++) { println (b2); b2++; }
 167 acc8= constant 20
 168 acc8=> variable 6
 169 acc16= variable 6
 170 acc16+ constant 100
 171 acc8= constant 122
 172 acc8CompareAcc16
 173 brle 182
 174 br 177
 175 incr16 variable 6
 176 br 169
 177 acc8= variable 1
 178 call writeLineAcc8
 179 incr8 variable 1
 180 br 175
 181 ;test11.j(36)     for(word i = 22; 123 >= i+100; i++) { println (b2); b2++; }
 182 acc8= constant 22
 183 acc8=> variable 6
 184 acc16= variable 6
 185 acc16+ constant 100
 186 acc8= constant 123
 187 acc8CompareAcc16
 188 brlt 197
 189 br 192
 190 incr16 variable 6
 191 br 184
 192 acc8= variable 1
 193 call writeLineAcc8
 194 incr8 variable 1
 195 br 190
 196 ;test11.j(37)     for(word i = 16; 114 <  i+100; i--) { println (b2); b2++; }
 197 acc8= constant 16
 198 acc8=> variable 6
 199 acc16= variable 6
 200 acc16+ constant 100
 201 acc8= constant 114
 202 acc8CompareAcc16
 203 brge 212
 204 br 207
 205 decr16 variable 6
 206 br 199
 207 acc8= variable 1
 208 call writeLineAcc8
 209 incr8 variable 1
 210 br 205
 211 ;test11.j(38)     for(word i = 14; 113 <= i+100; i--) { println (b2); b2++; }
 212 acc8= constant 14
 213 acc8=> variable 6
 214 acc16= variable 6
 215 acc16+ constant 100
 216 acc8= constant 113
 217 acc8CompareAcc16
 218 brgt 230
 219 br 222
 220 decr16 variable 6
 221 br 214
 222 acc8= variable 1
 223 call writeLineAcc8
 224 incr8 variable 1
 225 br 220
 226 ;test11.j(39)     // integer - byte
 227 ;test11.j(40)     // not relevant
 228 ;test11.j(41)     // integer - integer
 229 ;test11.j(42)     for(word i = 12; 1012 == i+1000; i--) { println (b2); b2++; }
 230 acc8= constant 12
 231 acc8=> variable 6
 232 acc16= variable 6
 233 acc16+ constant 1000
 234 acc16Comp constant 1012
 235 brne 244
 236 br 239
 237 decr16 variable 6
 238 br 232
 239 acc8= variable 1
 240 call writeLineAcc8
 241 incr8 variable 1
 242 br 237
 243 ;test11.j(43)     for(word i = 11; 1008 != i+1000; i--) { println (b2); b2++; }
 244 acc8= constant 11
 245 acc8=> variable 6
 246 acc16= variable 6
 247 acc16+ constant 1000
 248 acc16Comp constant 1008
 249 breq 258
 250 br 253
 251 decr16 variable 6
 252 br 246
 253 acc8= variable 1
 254 call writeLineAcc8
 255 incr8 variable 1
 256 br 251
 257 ;test11.j(44)     for(word i = 8; 1010 > i+1000; i++) { println (b2); b2++; }
 258 acc8= constant 8
 259 acc8=> variable 6
 260 acc16= variable 6
 261 acc16+ constant 1000
 262 acc16Comp constant 1010
 263 brge 272
 264 br 267
 265 incr16 variable 6
 266 br 260
 267 acc8= variable 1
 268 call writeLineAcc8
 269 incr8 variable 1
 270 br 265
 271 ;test11.j(45)     for(word i = 10; 1011 >= i+1000; i++) { println (b2); b2++; }
 272 acc8= constant 10
 273 acc8=> variable 6
 274 acc16= variable 6
 275 acc16+ constant 1000
 276 acc16Comp constant 1011
 277 brgt 286
 278 br 281
 279 incr16 variable 6
 280 br 274
 281 acc8= variable 1
 282 call writeLineAcc8
 283 incr8 variable 1
 284 br 279
 285 ;test11.j(46)     for(word i = 4; 1002 <  i+1000; i--) { println (b2); b2++; }
 286 acc8= constant 4
 287 acc8=> variable 6
 288 acc16= variable 6
 289 acc16+ constant 1000
 290 acc16Comp constant 1002
 291 brle 300
 292 br 295
 293 decr16 variable 6
 294 br 288
 295 acc8= variable 1
 296 call writeLineAcc8
 297 incr8 variable 1
 298 br 293
 299 ;test11.j(47)     for(word i = 2; 1001 <= i+1000; i--) { println (b2); b2++; }
 300 acc8= constant 2
 301 acc8=> variable 6
 302 acc16= variable 6
 303 acc16+ constant 1000
 304 acc16Comp constant 1001
 305 brlt 318
 306 br 309
 307 decr16 variable 6
 308 br 302
 309 acc8= variable 1
 310 call writeLineAcc8
 311 incr8 variable 1
 312 br 307
 313 ;test11.j(48)   
 314 ;test11.j(49)     /************************/
 315 ;test11.j(50)     // constant - var
 316 ;test11.j(51)     // byte - byte
 317 ;test11.j(52)     for (byte b = 42; 41 <= b; b--) { println (b2); b2++; }
 318 acc8= constant 42
 319 acc8=> variable 6
 320 acc8= variable 6
 321 acc8Comp constant 41
 322 brlt 332
 323 br 326
 324 decr8 variable 6
 325 br 320
 326 acc8= variable 1
 327 call writeLineAcc8
 328 incr8 variable 1
 329 br 324
 330 ;test11.j(53)     // byte - integer
 331 ;test11.j(54)     for(word i = 40; 39 <= i; i--) { println (b2); b2++; }
 332 acc8= constant 40
 333 acc8=> variable 6
 334 acc16= variable 6
 335 acc8= constant 39
 336 acc8CompareAcc16
 337 brgt 349
 338 br 341
 339 decr16 variable 6
 340 br 334
 341 acc8= variable 1
 342 call writeLineAcc8
 343 incr8 variable 1
 344 br 339
 345 ;test11.j(55)     // integer - byte
 346 ;test11.j(56)     // not relevant
 347 ;test11.j(57)     // integer - integer
 348 ;test11.j(58)     for(word i = 1038; 1037 <= i; i--) { println (b2); b2++; }
 349 acc16= constant 1038
 350 acc16=> variable 6
 351 acc16= variable 6
 352 acc16Comp constant 1037
 353 brlt 367
 354 br 357
 355 decr16 variable 6
 356 br 351
 357 acc8= variable 1
 358 call writeLineAcc8
 359 incr8 variable 1
 360 br 355
 361 ;test11.j(59)   
 362 ;test11.j(60)     /************************/
 363 ;test11.j(61)     // constant - stack8
 364 ;test11.j(62)     // byte - byte
 365 ;test11.j(63)     //TODO
 366 ;test11.j(64)     println(43);
 367 acc8= constant 43
 368 call writeLineAcc8
 369 ;test11.j(65)     println(44);
 370 acc8= constant 44
 371 call writeLineAcc8
 372 ;test11.j(66)     // constant - stack8
 373 ;test11.j(67)     // byte - integer
 374 ;test11.j(68)     //TODO
 375 ;test11.j(69)     println(45);
 376 acc8= constant 45
 377 call writeLineAcc8
 378 ;test11.j(70)     println(46);
 379 acc8= constant 46
 380 call writeLineAcc8
 381 ;test11.j(71)     // constant - stack8
 382 ;test11.j(72)     // integer - byte
 383 ;test11.j(73)     //TODO
 384 ;test11.j(74)     println(47);
 385 acc8= constant 47
 386 call writeLineAcc8
 387 ;test11.j(75)     println(48);
 388 acc8= constant 48
 389 call writeLineAcc8
 390 ;test11.j(76)     // constant - stack88
 391 ;test11.j(77)     // integer - integer
 392 ;test11.j(78)     //TODO
 393 ;test11.j(79)     println(49);
 394 acc8= constant 49
 395 call writeLineAcc8
 396 ;test11.j(80)     println(50);
 397 acc8= constant 50
 398 call writeLineAcc8
 399 ;test11.j(81)   
 400 ;test11.j(82)     /************************/
 401 ;test11.j(83)     // constant - stack16
 402 ;test11.j(84)     // byte - byte
 403 ;test11.j(85)     //TODO
 404 ;test11.j(86)     println(51);
 405 acc8= constant 51
 406 call writeLineAcc8
 407 ;test11.j(87)     println(52);
 408 acc8= constant 52
 409 call writeLineAcc8
 410 ;test11.j(88)     // constant - stack16
 411 ;test11.j(89)     // byte - integer
 412 ;test11.j(90)     //TODO
 413 ;test11.j(91)     println(53);
 414 acc8= constant 53
 415 call writeLineAcc8
 416 ;test11.j(92)     println(54);
 417 acc8= constant 54
 418 call writeLineAcc8
 419 ;test11.j(93)     // constant - stack16
 420 ;test11.j(94)     // integer - byte
 421 ;test11.j(95)     //TODO
 422 ;test11.j(96)     println(55);
 423 acc8= constant 55
 424 call writeLineAcc8
 425 ;test11.j(97)     println(56);
 426 acc8= constant 56
 427 call writeLineAcc8
 428 ;test11.j(98)     // constant - stack16
 429 ;test11.j(99)     // integer - integer
 430 ;test11.j(100)     //TODO
 431 ;test11.j(101)     println(57);
 432 acc8= constant 57
 433 call writeLineAcc8
 434 ;test11.j(102)     println(58);
 435 acc8= constant 58
 436 call writeLineAcc8
 437 ;test11.j(103)   
 438 ;test11.j(104)     /************************/
 439 ;test11.j(105)     // acc - constant
 440 ;test11.j(106)     // byte - byte
 441 ;test11.j(107)     b2 = 59;
 442 acc8= constant 59
 443 acc8=> variable 1
 444 ;test11.j(108)     for (byte b = 56; b+0 <= 57; b++) { println (b2); b2++; }
 445 acc8= constant 56
 446 acc8=> variable 6
 447 acc8= variable 6
 448 acc8+ constant 0
 449 acc8Comp constant 57
 450 brgt 462
 451 br 454
 452 incr8 variable 6
 453 br 447
 454 acc8= variable 1
 455 call writeLineAcc8
 456 incr8 variable 1
 457 br 452
 458 ;test11.j(109)     // byte - integer
 459 ;test11.j(110)     //not relevant
 460 ;test11.j(111)     // integer - byte
 461 ;test11.j(112)     for (word i = 54; i+0 <= 55; i++) { println (b2); b2++;}
 462 acc8= constant 54
 463 acc8=> variable 6
 464 acc16= variable 6
 465 acc16+ constant 0
 466 acc8= constant 55
 467 acc16CompareAcc8
 468 brgt 478
 469 br 472
 470 incr16 variable 6
 471 br 464
 472 acc8= variable 1
 473 call writeLineAcc8
 474 incr8 variable 1
 475 br 470
 476 ;test11.j(113)     // integer - integer
 477 ;test11.j(114)     for(word i = 1052; i+0 <= 1053; i++) { println (b2); b2++; }
 478 acc16= constant 1052
 479 acc16=> variable 6
 480 acc16= variable 6
 481 acc16+ constant 0
 482 acc16Comp constant 1053
 483 brgt 496
 484 br 487
 485 incr16 variable 6
 486 br 480
 487 acc8= variable 1
 488 call writeLineAcc8
 489 incr8 variable 1
 490 br 485
 491 ;test11.j(115)   
 492 ;test11.j(116)     /************************/
 493 ;test11.j(117)     // acc - acc
 494 ;test11.j(118)     // byte - byte
 495 ;test11.j(119)     for (byte b = 64; 63+0 <= b+0; b--) { println (b2); b2++; }
 496 acc8= constant 64
 497 acc8=> variable 6
 498 acc8= constant 63
 499 acc8+ constant 0
 500 <acc8
 501 acc8= variable 6
 502 acc8+ constant 0
 503 revAcc8Comp unstack8
 504 brlt 514
 505 br 508
 506 decr8 variable 6
 507 br 498
 508 acc8= variable 1
 509 call writeLineAcc8
 510 incr8 variable 1
 511 br 506
 512 ;test11.j(120)     // byte - integer
 513 ;test11.j(121)     for(word i = 62; 61+0 <= i+0; i--) { println (b2); b2++; }
 514 acc8= constant 62
 515 acc8=> variable 6
 516 acc8= constant 61
 517 acc8+ constant 0
 518 <acc8
 519 acc16= variable 6
 520 acc16+ constant 0
 521 acc8= unstack8
 522 acc8CompareAcc16
 523 brgt 533
 524 br 527
 525 decr16 variable 6
 526 br 516
 527 acc8= variable 1
 528 call writeLineAcc8
 529 incr8 variable 1
 530 br 525
 531 ;test11.j(122)     // integer - byte
 532 ;test11.j(123)     i2=59;
 533 acc8= constant 59
 534 acc8=> variable 2
 535 ;test11.j(124)     for (byte b = 60; i2+0 <= b+0; b--) { println (b2); b2++; }
 536 acc8= constant 60
 537 acc8=> variable 6
 538 acc16= variable 2
 539 acc16+ constant 0
 540 <acc16
 541 acc8= variable 6
 542 acc8+ constant 0
 543 acc16= unstack16
 544 acc16CompareAcc8
 545 brgt 555
 546 br 549
 547 decr8 variable 6
 548 br 538
 549 acc8= variable 1
 550 call writeLineAcc8
 551 incr8 variable 1
 552 br 547
 553 ;test11.j(125)     // integer - integer
 554 ;test11.j(126)     for(word i = 1058; 1000+57 <= i+0; i--) { println (b2); b2++; }
 555 acc16= constant 1058
 556 acc16=> variable 6
 557 acc16= constant 1000
 558 acc16+ constant 57
 559 <acc16
 560 acc16= variable 6
 561 acc16+ constant 0
 562 revAcc16Comp unstack16
 563 brlt 576
 564 br 567
 565 decr16 variable 6
 566 br 557
 567 acc8= variable 1
 568 call writeLineAcc8
 569 incr8 variable 1
 570 br 565
 571 ;test11.j(127)   
 572 ;test11.j(128)     /************************/
 573 ;test11.j(129)     // acc - var
 574 ;test11.j(130)     // byte - byte
 575 ;test11.j(131)     for (byte b = 72; 71+0 <= b; b--) { println (b2); b2++; }
 576 acc8= constant 72
 577 acc8=> variable 6
 578 acc8= constant 71
 579 acc8+ constant 0
 580 acc8Comp variable 6
 581 brgt 591
 582 br 585
 583 decr8 variable 6
 584 br 578
 585 acc8= variable 1
 586 call writeLineAcc8
 587 incr8 variable 1
 588 br 583
 589 ;test11.j(132)     // byte - integer
 590 ;test11.j(133)     for(word i = 70; 69+0 <= i; i--) { println (b2); b2++; }
 591 acc8= constant 70
 592 acc8=> variable 6
 593 acc8= constant 69
 594 acc8+ constant 0
 595 acc16= variable 6
 596 acc8CompareAcc16
 597 brgt 607
 598 br 601
 599 decr16 variable 6
 600 br 593
 601 acc8= variable 1
 602 call writeLineAcc8
 603 incr8 variable 1
 604 br 599
 605 ;test11.j(134)     // integer - byte
 606 ;test11.j(135)     i2=67;
 607 acc8= constant 67
 608 acc8=> variable 2
 609 ;test11.j(136)     for (byte b = 68; i2+0 <= b; b--) { println (b2); b2++; }
 610 acc8= constant 68
 611 acc8=> variable 6
 612 acc16= variable 2
 613 acc16+ constant 0
 614 acc8= variable 6
 615 acc16CompareAcc8
 616 brgt 626
 617 br 620
 618 decr8 variable 6
 619 br 612
 620 acc8= variable 1
 621 call writeLineAcc8
 622 incr8 variable 1
 623 br 618
 624 ;test11.j(137)     // integer - integer
 625 ;test11.j(138)     for(word i = 1066; 1000+65 <= i; i--) { println (b2); b2++; }
 626 acc16= constant 1066
 627 acc16=> variable 6
 628 acc16= constant 1000
 629 acc16+ constant 65
 630 acc16Comp variable 6
 631 brgt 645
 632 br 635
 633 decr16 variable 6
 634 br 628
 635 acc8= variable 1
 636 call writeLineAcc8
 637 incr8 variable 1
 638 br 633
 639 ;test11.j(139)   
 640 ;test11.j(140)     /************************/
 641 ;test11.j(141)     // acc - stack8
 642 ;test11.j(142)     // byte - byte
 643 ;test11.j(143)     //TODO
 644 ;test11.j(144)     println(81);
 645 acc8= constant 81
 646 call writeLineAcc8
 647 ;test11.j(145)     println(82);
 648 acc8= constant 82
 649 call writeLineAcc8
 650 ;test11.j(146)     // byte - integer
 651 ;test11.j(147)     //TODO
 652 ;test11.j(148)     println(83);
 653 acc8= constant 83
 654 call writeLineAcc8
 655 ;test11.j(149)     println(84);
 656 acc8= constant 84
 657 call writeLineAcc8
 658 ;test11.j(150)     // integer - byte
 659 ;test11.j(151)     //TODO
 660 ;test11.j(152)     println(85);
 661 acc8= constant 85
 662 call writeLineAcc8
 663 ;test11.j(153)     println(86);
 664 acc8= constant 86
 665 call writeLineAcc8
 666 ;test11.j(154)     // integer - integer
 667 ;test11.j(155)     //TODO
 668 ;test11.j(156)     println(87);
 669 acc8= constant 87
 670 call writeLineAcc8
 671 ;test11.j(157)     println(88);
 672 acc8= constant 88
 673 call writeLineAcc8
 674 ;test11.j(158)   
 675 ;test11.j(159)     /************************/
 676 ;test11.j(160)     // acc - stack16
 677 ;test11.j(161)     // byte - byte
 678 ;test11.j(162)     //TODO
 679 ;test11.j(163)     println(89);
 680 acc8= constant 89
 681 call writeLineAcc8
 682 ;test11.j(164)     println(90);
 683 acc8= constant 90
 684 call writeLineAcc8
 685 ;test11.j(165)     // byte - integer
 686 ;test11.j(166)     //TODO
 687 ;test11.j(167)     println(91);
 688 acc8= constant 91
 689 call writeLineAcc8
 690 ;test11.j(168)     println(92);
 691 acc8= constant 92
 692 call writeLineAcc8
 693 ;test11.j(169)     // integer - byte
 694 ;test11.j(170)     //TODO
 695 ;test11.j(171)     println(93);
 696 acc8= constant 93
 697 call writeLineAcc8
 698 ;test11.j(172)     println(94);
 699 acc8= constant 94
 700 call writeLineAcc8
 701 ;test11.j(173)     // integer - integer
 702 ;test11.j(174)     //TODO
 703 ;test11.j(175)     println(95);
 704 acc8= constant 95
 705 call writeLineAcc8
 706 ;test11.j(176)     println(96);
 707 acc8= constant 96
 708 call writeLineAcc8
 709 ;test11.j(177)   
 710 ;test11.j(178)     /************************/
 711 ;test11.j(179)     // var - constant
 712 ;test11.j(180)     // byte - byte
 713 ;test11.j(181)     b2=97;
 714 acc8= constant 97
 715 acc8=> variable 1
 716 ;test11.j(182)     for (byte b = 96; b <= 97; b++) { println (b2); b2++; }
 717 acc8= constant 96
 718 acc8=> variable 6
 719 acc8= variable 6
 720 acc8Comp constant 97
 721 brgt 733
 722 br 725
 723 incr8 variable 6
 724 br 719
 725 acc8= variable 1
 726 call writeLineAcc8
 727 incr8 variable 1
 728 br 723
 729 ;test11.j(183)     // byte - integer
 730 ;test11.j(184)     //not relevant
 731 ;test11.j(185)     // integer - byte
 732 ;test11.j(186)     for(word i = 92; i <= 93; i++) { println (b2); b2++; }
 733 acc8= constant 92
 734 acc8=> variable 6
 735 acc16= variable 6
 736 acc8= constant 93
 737 acc16CompareAcc8
 738 brgt 748
 739 br 742
 740 incr16 variable 6
 741 br 735
 742 acc8= variable 1
 743 call writeLineAcc8
 744 incr8 variable 1
 745 br 740
 746 ;test11.j(187)     // integer - integer
 747 ;test11.j(188)     for(word i = 1090; i <= 1091; i++) { println (b2); b2++; }
 748 acc16= constant 1090
 749 acc16=> variable 6
 750 acc16= variable 6
 751 acc16Comp constant 1091
 752 brgt 765
 753 br 756
 754 incr16 variable 6
 755 br 750
 756 acc8= variable 1
 757 call writeLineAcc8
 758 incr8 variable 1
 759 br 754
 760 ;test11.j(189)   
 761 ;test11.j(190)     /************************/
 762 ;test11.j(191)     // var - acc
 763 ;test11.j(192)     // byte - byte
 764 ;test11.j(193)     for (byte b = 104; b <= 105+0; b++) { println (b2); b2++; }
 765 acc8= constant 104
 766 acc8=> variable 6
 767 acc8= constant 105
 768 acc8+ constant 0
 769 acc8Comp variable 6
 770 brlt 780
 771 br 774
 772 incr8 variable 6
 773 br 767
 774 acc8= variable 1
 775 call writeLineAcc8
 776 incr8 variable 1
 777 br 772
 778 ;test11.j(194)     // byte - integer
 779 ;test11.j(195)     i2=103;
 780 acc8= constant 103
 781 acc8=> variable 2
 782 ;test11.j(196)     for (byte b = 102; b <= i2+0; b++) { println (b2); b2++; }
 783 acc8= constant 102
 784 acc8=> variable 6
 785 acc16= variable 2
 786 acc16+ constant 0
 787 acc8= variable 6
 788 acc8CompareAcc16
 789 brgt 799
 790 br 793
 791 incr8 variable 6
 792 br 785
 793 acc8= variable 1
 794 call writeLineAcc8
 795 incr8 variable 1
 796 br 791
 797 ;test11.j(197)     // integer - byte
 798 ;test11.j(198)     for(word i = 100; i <= 101+0; i++) { println (b2); b2++; }
 799 acc8= constant 100
 800 acc8=> variable 6
 801 acc8= constant 101
 802 acc8+ constant 0
 803 acc16= variable 6
 804 acc16CompareAcc8
 805 brgt 815
 806 br 809
 807 incr16 variable 6
 808 br 801
 809 acc8= variable 1
 810 call writeLineAcc8
 811 incr8 variable 1
 812 br 807
 813 ;test11.j(199)     // integer - integer
 814 ;test11.j(200)     for(word i = 1098; i <= 1099+0; i++) { println (b2); b2++; }
 815 acc16= constant 1098
 816 acc16=> variable 6
 817 acc16= constant 1099
 818 acc16+ constant 0
 819 acc16Comp variable 6
 820 brlt 833
 821 br 824
 822 incr16 variable 6
 823 br 817
 824 acc8= variable 1
 825 call writeLineAcc8
 826 incr8 variable 1
 827 br 822
 828 ;test11.j(201)   
 829 ;test11.j(202)     /************************/
 830 ;test11.j(203)     // var - var
 831 ;test11.j(204)     // byte - byte
 832 ;test11.j(205)     for (byte b = 112; b2 <= b; b--) { println (b2); b2++; }
 833 acc8= constant 112
 834 acc8=> variable 6
 835 acc8= variable 1
 836 acc8Comp variable 6
 837 brgt 847
 838 br 841
 839 decr8 variable 6
 840 br 835
 841 acc8= variable 1
 842 call writeLineAcc8
 843 incr8 variable 1
 844 br 839
 845 ;test11.j(206)     // byte - integer
 846 ;test11.j(207)     for(word i = 116; b2 <= i; i--) { println (b2); b2++; }
 847 acc8= constant 116
 848 acc8=> variable 6
 849 acc8= variable 1
 850 acc16= variable 6
 851 acc8CompareAcc16
 852 brgt 862
 853 br 856
 854 decr16 variable 6
 855 br 849
 856 acc8= variable 1
 857 call writeLineAcc8
 858 incr8 variable 1
 859 br 854
 860 ;test11.j(208)     // integer - byte
 861 ;test11.j(209)     i2=b2;
 862 acc8= variable 1
 863 acc8=> variable 2
 864 ;test11.j(210)     for (byte b = 118; i2 <= b; b--) { println (b2); b2++; }
 865 acc8= constant 118
 866 acc8=> variable 6
 867 acc16= variable 2
 868 acc8= variable 6
 869 acc16CompareAcc8
 870 brgt 880
 871 br 874
 872 decr8 variable 6
 873 br 867
 874 acc8= variable 1
 875 call writeLineAcc8
 876 incr8 variable 1
 877 br 872
 878 ;test11.j(211)     // integer - integer
 879 ;test11.j(212)     i2=120;
 880 acc8= constant 120
 881 acc8=> variable 2
 882 ;test11.j(213)     for(word i = b2+4; i2 <= i; i--) { println (b2); b2++; }
 883 acc8= variable 1
 884 acc8+ constant 4
 885 acc8=> variable 6
 886 acc16= variable 2
 887 acc16Comp variable 6
 888 brgt 930
 889 br 892
 890 decr16 variable 6
 891 br 886
 892 acc8= variable 1
 893 call writeLineAcc8
 894 incr8 variable 1
 895 br 890
 896 ;test11.j(214)   
 897 ;test11.j(215)     /************************/
 898 ;test11.j(216)     // var - stack8
 899 ;test11.j(217)     // byte - byte
 900 ;test11.j(218)     // byte - integer
 901 ;test11.j(219)     // integer - byte
 902 ;test11.j(220)     // integer - integer
 903 ;test11.j(221)     //TODO
 904 ;test11.j(222)   
 905 ;test11.j(223)     /************************/
 906 ;test11.j(224)     // var - stack16
 907 ;test11.j(225)     // byte - byte
 908 ;test11.j(226)     // byte - integer
 909 ;test11.j(227)     // integer - byte
 910 ;test11.j(228)     // integer - integer
 911 ;test11.j(229)     //TODO
 912 ;test11.j(230)   
 913 ;test11.j(231)     /************************/
 914 ;test11.j(232)     // stack8 - constant
 915 ;test11.j(233)     // stack8 - acc
 916 ;test11.j(234)     // stack8 - var
 917 ;test11.j(235)     // stack8 - stack8
 918 ;test11.j(236)     // stack8 - stack16
 919 ;test11.j(237)     //TODO
 920 ;test11.j(238)   
 921 ;test11.j(239)     /************************/
 922 ;test11.j(240)     // stack16 - constant
 923 ;test11.j(241)     // stack16 - acc
 924 ;test11.j(242)     // stack16 - var
 925 ;test11.j(243)     // stack16 - stack8
 926 ;test11.j(244)     // stack16 - stack16
 927 ;test11.j(245)     //TODO
 928 ;test11.j(246)   
 929 ;test11.j(247)     println("Klaar.");
 930 acc16= constant 935
 931 writeLineString
 932 ;test11.j(248)   }
 933 ;test11.j(249) }
 934 stop
 935 stringConstant 0 = "Klaar."
