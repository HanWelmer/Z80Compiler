   0 ;test11.j(0) /* Program to test generated Z80 assembler code */
   1 ;test11.j(1) class TestFor {
   2 ;test11.j(2)   byte b1 = 1;
   3 acc8= constant 1
   4 acc8=> variable 0
   5 ;test11.j(3)   byte b2 = 1;
   6 acc8= constant 1
   7 acc8=> variable 1
   8 ;test11.j(4)   word i2 = 1;
   9 acc8= constant 1
  10 acc8=> variable 2
  11 ;test11.j(5)   word p = 1;
  12 acc8= constant 1
  13 acc8=> variable 4
  14 ;test11.j(6) 
  15 ;test11.j(7)   println(0);
  16 acc8= constant 0
  17 call writeLineAcc8
  18 ;test11.j(8) 
  19 ;test11.j(9)   /************************/
  20 ;test11.j(10)   // global variable within for scope
  21 ;test11.j(11)   for (byte b = 1; b <= 2; b++) {
  22 acc8= constant 1
  23 acc8=> variable 6
  24 acc8= variable 6
  25 acc8Comp constant 2
  26 brgt 49
  27 br 30
  28 incr8 variable 6
  29 br 24
  30 ;test11.j(12)     byte c = b1;
  31 acc8= variable 0
  32 acc8=> variable 7
  33 ;test11.j(13)     println (c);
  34 acc8= variable 7
  35 call writeLineAcc8
  36 ;test11.j(14)     b1++;
  37 incr8 variable 0
  38 ;test11.j(15)   }
  39 br 28
  40 ;test11.j(16) 
  41 ;test11.j(17)   /************************/
  42 ;test11.j(18)   // constant - constant
  43 ;test11.j(19)   // not relevant
  44 ;test11.j(20) 
  45 ;test11.j(21)   /************************/
  46 ;test11.j(22)   // constant - acc
  47 ;test11.j(23)   // byte - byte
  48 ;test11.j(24)   for (byte b = 3; 103 == b+100; b++) { println (b); }
  49 acc8= constant 3
  50 acc8=> variable 6
  51 acc8= variable 6
  52 acc8+ constant 100
  53 acc8Comp constant 103
  54 brne 62
  55 br 58
  56 incr8 variable 6
  57 br 51
  58 acc8= variable 6
  59 call writeLineAcc8
  60 br 56
  61 ;test11.j(25)   for (byte b = 4; 105 != b+100; b++) { println (b); }
  62 acc8= constant 4
  63 acc8=> variable 6
  64 acc8= variable 6
  65 acc8+ constant 100
  66 acc8Comp constant 105
  67 breq 75
  68 br 71
  69 incr8 variable 6
  70 br 64
  71 acc8= variable 6
  72 call writeLineAcc8
  73 br 69
  74 ;test11.j(26)   b2=5;
  75 acc8= constant 5
  76 acc8=> variable 1
  77 ;test11.j(27)   for (byte b = 32; 134 > b+100; b++) { println (b2); b2++; }
  78 acc8= constant 32
  79 acc8=> variable 6
  80 acc8= variable 6
  81 acc8+ constant 100
  82 acc8Comp constant 134
  83 brge 92
  84 br 87
  85 incr8 variable 6
  86 br 80
  87 acc8= variable 1
  88 call writeLineAcc8
  89 incr8 variable 1
  90 br 85
  91 ;test11.j(28)   for (byte b = 34; 135 >= b+100; b++) { println (b2); b2++; }
  92 acc8= constant 34
  93 acc8=> variable 6
  94 acc8= variable 6
  95 acc8+ constant 100
  96 acc8Comp constant 135
  97 brgt 106
  98 br 101
  99 incr8 variable 6
 100 br 94
 101 acc8= variable 1
 102 call writeLineAcc8
 103 incr8 variable 1
 104 br 99
 105 ;test11.j(29)   for (byte b = 28; 126 <  b+100; b--) { println (b2); b2++; }
 106 acc8= constant 28
 107 acc8=> variable 6
 108 acc8= variable 6
 109 acc8+ constant 100
 110 acc8Comp constant 126
 111 brle 120
 112 br 115
 113 decr8 variable 6
 114 br 108
 115 acc8= variable 1
 116 call writeLineAcc8
 117 incr8 variable 1
 118 br 113
 119 ;test11.j(30)   for (byte b = 26; 125 <= b+100; b--) { println (b2); b2++; }
 120 acc8= constant 26
 121 acc8=> variable 6
 122 acc8= variable 6
 123 acc8+ constant 100
 124 acc8Comp constant 125
 125 brlt 135
 126 br 129
 127 decr8 variable 6
 128 br 122
 129 acc8= variable 1
 130 call writeLineAcc8
 131 incr8 variable 1
 132 br 127
 133 ;test11.j(31)   // byte - integer
 134 ;test11.j(32)   for(word i = 24; 24  == i+0; i--) { println (b2); b2++; }
 135 acc8= constant 24
 136 acc8=> variable 6
 137 acc16= variable 6
 138 acc16+ constant 0
 139 acc8= constant 24
 140 acc8CompareAcc16
 141 brne 150
 142 br 145
 143 decr16 variable 6
 144 br 137
 145 acc8= variable 1
 146 call writeLineAcc8
 147 incr8 variable 1
 148 br 143
 149 ;test11.j(33)   for(word i = 23; 120 != i+100; i--) { println (b2); b2++; }
 150 acc8= constant 23
 151 acc8=> variable 6
 152 acc16= variable 6
 153 acc16+ constant 100
 154 acc8= constant 120
 155 acc8CompareAcc16
 156 breq 165
 157 br 160
 158 decr16 variable 6
 159 br 152
 160 acc8= variable 1
 161 call writeLineAcc8
 162 incr8 variable 1
 163 br 158
 164 ;test11.j(34)   for(word i = 20; 122 > i+100; i++) { println (b2); b2++; }
 165 acc8= constant 20
 166 acc8=> variable 6
 167 acc16= variable 6
 168 acc16+ constant 100
 169 acc8= constant 122
 170 acc8CompareAcc16
 171 brle 180
 172 br 175
 173 incr16 variable 6
 174 br 167
 175 acc8= variable 1
 176 call writeLineAcc8
 177 incr8 variable 1
 178 br 173
 179 ;test11.j(35)   for(word i = 22; 123 >= i+100; i++) { println (b2); b2++; }
 180 acc8= constant 22
 181 acc8=> variable 6
 182 acc16= variable 6
 183 acc16+ constant 100
 184 acc8= constant 123
 185 acc8CompareAcc16
 186 brlt 195
 187 br 190
 188 incr16 variable 6
 189 br 182
 190 acc8= variable 1
 191 call writeLineAcc8
 192 incr8 variable 1
 193 br 188
 194 ;test11.j(36)   for(word i = 16; 114 <  i+100; i--) { println (b2); b2++; }
 195 acc8= constant 16
 196 acc8=> variable 6
 197 acc16= variable 6
 198 acc16+ constant 100
 199 acc8= constant 114
 200 acc8CompareAcc16
 201 brge 210
 202 br 205
 203 decr16 variable 6
 204 br 197
 205 acc8= variable 1
 206 call writeLineAcc8
 207 incr8 variable 1
 208 br 203
 209 ;test11.j(37)   for(word i = 14; 113 <= i+100; i--) { println (b2); b2++; }
 210 acc8= constant 14
 211 acc8=> variable 6
 212 acc16= variable 6
 213 acc16+ constant 100
 214 acc8= constant 113
 215 acc8CompareAcc16
 216 brgt 228
 217 br 220
 218 decr16 variable 6
 219 br 212
 220 acc8= variable 1
 221 call writeLineAcc8
 222 incr8 variable 1
 223 br 218
 224 ;test11.j(38)   // integer - byte
 225 ;test11.j(39)   // not relevant
 226 ;test11.j(40)   // integer - integer
 227 ;test11.j(41)   for(word i = 12; 1012 == i+1000; i--) { println (b2); b2++; }
 228 acc8= constant 12
 229 acc8=> variable 6
 230 acc16= variable 6
 231 acc16+ constant 1000
 232 acc16Comp constant 1012
 233 brne 242
 234 br 237
 235 decr16 variable 6
 236 br 230
 237 acc8= variable 1
 238 call writeLineAcc8
 239 incr8 variable 1
 240 br 235
 241 ;test11.j(42)   for(word i = 11; 1008 != i+1000; i--) { println (b2); b2++; }
 242 acc8= constant 11
 243 acc8=> variable 6
 244 acc16= variable 6
 245 acc16+ constant 1000
 246 acc16Comp constant 1008
 247 breq 256
 248 br 251
 249 decr16 variable 6
 250 br 244
 251 acc8= variable 1
 252 call writeLineAcc8
 253 incr8 variable 1
 254 br 249
 255 ;test11.j(43)   for(word i = 8; 1010 > i+1000; i++) { println (b2); b2++; }
 256 acc8= constant 8
 257 acc8=> variable 6
 258 acc16= variable 6
 259 acc16+ constant 1000
 260 acc16Comp constant 1010
 261 brge 270
 262 br 265
 263 incr16 variable 6
 264 br 258
 265 acc8= variable 1
 266 call writeLineAcc8
 267 incr8 variable 1
 268 br 263
 269 ;test11.j(44)   for(word i = 10; 1011 >= i+1000; i++) { println (b2); b2++; }
 270 acc8= constant 10
 271 acc8=> variable 6
 272 acc16= variable 6
 273 acc16+ constant 1000
 274 acc16Comp constant 1011
 275 brgt 284
 276 br 279
 277 incr16 variable 6
 278 br 272
 279 acc8= variable 1
 280 call writeLineAcc8
 281 incr8 variable 1
 282 br 277
 283 ;test11.j(45)   for(word i = 4; 1002 <  i+1000; i--) { println (b2); b2++; }
 284 acc8= constant 4
 285 acc8=> variable 6
 286 acc16= variable 6
 287 acc16+ constant 1000
 288 acc16Comp constant 1002
 289 brle 298
 290 br 293
 291 decr16 variable 6
 292 br 286
 293 acc8= variable 1
 294 call writeLineAcc8
 295 incr8 variable 1
 296 br 291
 297 ;test11.j(46)   for(word i = 2; 1001 <= i+1000; i--) { println (b2); b2++; }
 298 acc8= constant 2
 299 acc8=> variable 6
 300 acc16= variable 6
 301 acc16+ constant 1000
 302 acc16Comp constant 1001
 303 brlt 316
 304 br 307
 305 decr16 variable 6
 306 br 300
 307 acc8= variable 1
 308 call writeLineAcc8
 309 incr8 variable 1
 310 br 305
 311 ;test11.j(47) 
 312 ;test11.j(48)   /************************/
 313 ;test11.j(49)   // constant - var
 314 ;test11.j(50)   // byte - byte
 315 ;test11.j(51)   for (byte b = 42; 41 <= b; b--) { println (b2); b2++; }
 316 acc8= constant 42
 317 acc8=> variable 6
 318 acc8= variable 6
 319 acc8Comp constant 41
 320 brlt 330
 321 br 324
 322 decr8 variable 6
 323 br 318
 324 acc8= variable 1
 325 call writeLineAcc8
 326 incr8 variable 1
 327 br 322
 328 ;test11.j(52)   // byte - integer
 329 ;test11.j(53)   for(word i = 40; 39 <= i; i--) { println (b2); b2++; }
 330 acc8= constant 40
 331 acc8=> variable 6
 332 acc16= variable 6
 333 acc8= constant 39
 334 acc8CompareAcc16
 335 brgt 347
 336 br 339
 337 decr16 variable 6
 338 br 332
 339 acc8= variable 1
 340 call writeLineAcc8
 341 incr8 variable 1
 342 br 337
 343 ;test11.j(54)   // integer - byte
 344 ;test11.j(55)   // not relevant
 345 ;test11.j(56)   // integer - integer
 346 ;test11.j(57)   for(word i = 1038; 1037 <= i; i--) { println (b2); b2++; }
 347 acc16= constant 1038
 348 acc16=> variable 6
 349 acc16= variable 6
 350 acc16Comp constant 1037
 351 brlt 365
 352 br 355
 353 decr16 variable 6
 354 br 349
 355 acc8= variable 1
 356 call writeLineAcc8
 357 incr8 variable 1
 358 br 353
 359 ;test11.j(58) 
 360 ;test11.j(59)   /************************/
 361 ;test11.j(60)   // constant - stack8
 362 ;test11.j(61)   // byte - byte
 363 ;test11.j(62)   //TODO
 364 ;test11.j(63)   println(43);
 365 acc8= constant 43
 366 call writeLineAcc8
 367 ;test11.j(64)   println(44);
 368 acc8= constant 44
 369 call writeLineAcc8
 370 ;test11.j(65)   // constant - stack8
 371 ;test11.j(66)   // byte - integer
 372 ;test11.j(67)   //TODO
 373 ;test11.j(68)   println(45);
 374 acc8= constant 45
 375 call writeLineAcc8
 376 ;test11.j(69)   println(46);
 377 acc8= constant 46
 378 call writeLineAcc8
 379 ;test11.j(70)   // constant - stack8
 380 ;test11.j(71)   // integer - byte
 381 ;test11.j(72)   //TODO
 382 ;test11.j(73)   println(47);
 383 acc8= constant 47
 384 call writeLineAcc8
 385 ;test11.j(74)   println(48);
 386 acc8= constant 48
 387 call writeLineAcc8
 388 ;test11.j(75)   // constant - stack88
 389 ;test11.j(76)   // integer - integer
 390 ;test11.j(77)   //TODO
 391 ;test11.j(78)   println(49);
 392 acc8= constant 49
 393 call writeLineAcc8
 394 ;test11.j(79)   println(50);
 395 acc8= constant 50
 396 call writeLineAcc8
 397 ;test11.j(80) 
 398 ;test11.j(81)   /************************/
 399 ;test11.j(82)   // constant - stack16
 400 ;test11.j(83)   // byte - byte
 401 ;test11.j(84)   //TODO
 402 ;test11.j(85)   println(51);
 403 acc8= constant 51
 404 call writeLineAcc8
 405 ;test11.j(86)   println(52);
 406 acc8= constant 52
 407 call writeLineAcc8
 408 ;test11.j(87)   // constant - stack16
 409 ;test11.j(88)   // byte - integer
 410 ;test11.j(89)   //TODO
 411 ;test11.j(90)   println(53);
 412 acc8= constant 53
 413 call writeLineAcc8
 414 ;test11.j(91)   println(54);
 415 acc8= constant 54
 416 call writeLineAcc8
 417 ;test11.j(92)   // constant - stack16
 418 ;test11.j(93)   // integer - byte
 419 ;test11.j(94)   //TODO
 420 ;test11.j(95)   println(55);
 421 acc8= constant 55
 422 call writeLineAcc8
 423 ;test11.j(96)   println(56);
 424 acc8= constant 56
 425 call writeLineAcc8
 426 ;test11.j(97)   // constant - stack16
 427 ;test11.j(98)   // integer - integer
 428 ;test11.j(99)   //TODO
 429 ;test11.j(100)   println(57);
 430 acc8= constant 57
 431 call writeLineAcc8
 432 ;test11.j(101)   println(58);
 433 acc8= constant 58
 434 call writeLineAcc8
 435 ;test11.j(102) 
 436 ;test11.j(103)   /************************/
 437 ;test11.j(104)   // acc - constant
 438 ;test11.j(105)   // byte - byte
 439 ;test11.j(106)   b2 = 59;
 440 acc8= constant 59
 441 acc8=> variable 1
 442 ;test11.j(107)   for (byte b = 56; b+0 <= 57; b++) { println (b2); b2++; }
 443 acc8= constant 56
 444 acc8=> variable 6
 445 acc8= variable 6
 446 acc8+ constant 0
 447 acc8Comp constant 57
 448 brgt 460
 449 br 452
 450 incr8 variable 6
 451 br 445
 452 acc8= variable 1
 453 call writeLineAcc8
 454 incr8 variable 1
 455 br 450
 456 ;test11.j(108)   // byte - integer
 457 ;test11.j(109)   //not relevant
 458 ;test11.j(110)   // integer - byte
 459 ;test11.j(111)   for (word i = 54; i+0 <= 55; i++) { println (b2); b2++;}
 460 acc8= constant 54
 461 acc8=> variable 6
 462 acc16= variable 6
 463 acc16+ constant 0
 464 acc8= constant 55
 465 acc16CompareAcc8
 466 brgt 476
 467 br 470
 468 incr16 variable 6
 469 br 462
 470 acc8= variable 1
 471 call writeLineAcc8
 472 incr8 variable 1
 473 br 468
 474 ;test11.j(112)   // integer - integer
 475 ;test11.j(113)   for(word i = 1052; i+0 <= 1053; i++) { println (b2); b2++; }
 476 acc16= constant 1052
 477 acc16=> variable 6
 478 acc16= variable 6
 479 acc16+ constant 0
 480 acc16Comp constant 1053
 481 brgt 494
 482 br 485
 483 incr16 variable 6
 484 br 478
 485 acc8= variable 1
 486 call writeLineAcc8
 487 incr8 variable 1
 488 br 483
 489 ;test11.j(114) 
 490 ;test11.j(115)   /************************/
 491 ;test11.j(116)   // acc - acc
 492 ;test11.j(117)   // byte - byte
 493 ;test11.j(118)   for (byte b = 64; 63+0 <= b+0; b--) { println (b2); b2++; }
 494 acc8= constant 64
 495 acc8=> variable 6
 496 acc8= constant 63
 497 acc8+ constant 0
 498 <acc8
 499 acc8= variable 6
 500 acc8+ constant 0
 501 revAcc8Comp unstack8
 502 brlt 512
 503 br 506
 504 decr8 variable 6
 505 br 496
 506 acc8= variable 1
 507 call writeLineAcc8
 508 incr8 variable 1
 509 br 504
 510 ;test11.j(119)   // byte - integer
 511 ;test11.j(120)   for(word i = 62; 61+0 <= i+0; i--) { println (b2); b2++; }
 512 acc8= constant 62
 513 acc8=> variable 6
 514 acc8= constant 61
 515 acc8+ constant 0
 516 <acc8
 517 acc16= variable 6
 518 acc16+ constant 0
 519 acc8= unstack8
 520 acc8CompareAcc16
 521 brgt 531
 522 br 525
 523 decr16 variable 6
 524 br 514
 525 acc8= variable 1
 526 call writeLineAcc8
 527 incr8 variable 1
 528 br 523
 529 ;test11.j(121)   // integer - byte
 530 ;test11.j(122)   i2=59;
 531 acc8= constant 59
 532 acc8=> variable 2
 533 ;test11.j(123)   for (byte b = 60; i2+0 <= b+0; b--) { println (b2); b2++; }
 534 acc8= constant 60
 535 acc8=> variable 6
 536 acc16= variable 2
 537 acc16+ constant 0
 538 <acc16
 539 acc8= variable 6
 540 acc8+ constant 0
 541 acc16= unstack16
 542 acc16CompareAcc8
 543 brgt 553
 544 br 547
 545 decr8 variable 6
 546 br 536
 547 acc8= variable 1
 548 call writeLineAcc8
 549 incr8 variable 1
 550 br 545
 551 ;test11.j(124)   // integer - integer
 552 ;test11.j(125)   for(word i = 1058; 1000+57 <= i+0; i--) { println (b2); b2++; }
 553 acc16= constant 1058
 554 acc16=> variable 6
 555 acc16= constant 1000
 556 acc16+ constant 57
 557 <acc16
 558 acc16= variable 6
 559 acc16+ constant 0
 560 revAcc16Comp unstack16
 561 brlt 574
 562 br 565
 563 decr16 variable 6
 564 br 555
 565 acc8= variable 1
 566 call writeLineAcc8
 567 incr8 variable 1
 568 br 563
 569 ;test11.j(126) 
 570 ;test11.j(127)   /************************/
 571 ;test11.j(128)   // acc - var
 572 ;test11.j(129)   // byte - byte
 573 ;test11.j(130)   for (byte b = 72; 71+0 <= b; b--) { println (b2); b2++; }
 574 acc8= constant 72
 575 acc8=> variable 6
 576 acc8= constant 71
 577 acc8+ constant 0
 578 acc8Comp variable 6
 579 brgt 589
 580 br 583
 581 decr8 variable 6
 582 br 576
 583 acc8= variable 1
 584 call writeLineAcc8
 585 incr8 variable 1
 586 br 581
 587 ;test11.j(131)   // byte - integer
 588 ;test11.j(132)   for(word i = 70; 69+0 <= i; i--) { println (b2); b2++; }
 589 acc8= constant 70
 590 acc8=> variable 6
 591 acc8= constant 69
 592 acc8+ constant 0
 593 acc16= variable 6
 594 acc8CompareAcc16
 595 brgt 605
 596 br 599
 597 decr16 variable 6
 598 br 591
 599 acc8= variable 1
 600 call writeLineAcc8
 601 incr8 variable 1
 602 br 597
 603 ;test11.j(133)   // integer - byte
 604 ;test11.j(134)   i2=67;
 605 acc8= constant 67
 606 acc8=> variable 2
 607 ;test11.j(135)   for (byte b = 68; i2+0 <= b; b--) { println (b2); b2++; }
 608 acc8= constant 68
 609 acc8=> variable 6
 610 acc16= variable 2
 611 acc16+ constant 0
 612 acc8= variable 6
 613 acc16CompareAcc8
 614 brgt 624
 615 br 618
 616 decr8 variable 6
 617 br 610
 618 acc8= variable 1
 619 call writeLineAcc8
 620 incr8 variable 1
 621 br 616
 622 ;test11.j(136)   // integer - integer
 623 ;test11.j(137)   for(word i = 1066; 1000+65 <= i; i--) { println (b2); b2++; }
 624 acc16= constant 1066
 625 acc16=> variable 6
 626 acc16= constant 1000
 627 acc16+ constant 65
 628 acc16Comp variable 6
 629 brgt 643
 630 br 633
 631 decr16 variable 6
 632 br 626
 633 acc8= variable 1
 634 call writeLineAcc8
 635 incr8 variable 1
 636 br 631
 637 ;test11.j(138) 
 638 ;test11.j(139)   /************************/
 639 ;test11.j(140)   // acc - stack8
 640 ;test11.j(141)   // byte - byte
 641 ;test11.j(142)   //TODO
 642 ;test11.j(143)   println(81);
 643 acc8= constant 81
 644 call writeLineAcc8
 645 ;test11.j(144)   println(82);
 646 acc8= constant 82
 647 call writeLineAcc8
 648 ;test11.j(145)   // byte - integer
 649 ;test11.j(146)   //TODO
 650 ;test11.j(147)   println(83);
 651 acc8= constant 83
 652 call writeLineAcc8
 653 ;test11.j(148)   println(84);
 654 acc8= constant 84
 655 call writeLineAcc8
 656 ;test11.j(149)   // integer - byte
 657 ;test11.j(150)   //TODO
 658 ;test11.j(151)   println(85);
 659 acc8= constant 85
 660 call writeLineAcc8
 661 ;test11.j(152)   println(86);
 662 acc8= constant 86
 663 call writeLineAcc8
 664 ;test11.j(153)   // integer - integer
 665 ;test11.j(154)   //TODO
 666 ;test11.j(155)   println(87);
 667 acc8= constant 87
 668 call writeLineAcc8
 669 ;test11.j(156)   println(88);
 670 acc8= constant 88
 671 call writeLineAcc8
 672 ;test11.j(157) 
 673 ;test11.j(158)   /************************/
 674 ;test11.j(159)   // acc - stack16
 675 ;test11.j(160)   // byte - byte
 676 ;test11.j(161)   //TODO
 677 ;test11.j(162)   println(89);
 678 acc8= constant 89
 679 call writeLineAcc8
 680 ;test11.j(163)   println(90);
 681 acc8= constant 90
 682 call writeLineAcc8
 683 ;test11.j(164)   // byte - integer
 684 ;test11.j(165)   //TODO
 685 ;test11.j(166)   println(91);
 686 acc8= constant 91
 687 call writeLineAcc8
 688 ;test11.j(167)   println(92);
 689 acc8= constant 92
 690 call writeLineAcc8
 691 ;test11.j(168)   // integer - byte
 692 ;test11.j(169)   //TODO
 693 ;test11.j(170)   println(93);
 694 acc8= constant 93
 695 call writeLineAcc8
 696 ;test11.j(171)   println(94);
 697 acc8= constant 94
 698 call writeLineAcc8
 699 ;test11.j(172)   // integer - integer
 700 ;test11.j(173)   //TODO
 701 ;test11.j(174)   println(95);
 702 acc8= constant 95
 703 call writeLineAcc8
 704 ;test11.j(175)   println(96);
 705 acc8= constant 96
 706 call writeLineAcc8
 707 ;test11.j(176) 
 708 ;test11.j(177)   /************************/
 709 ;test11.j(178)   // var - constant
 710 ;test11.j(179)   // byte - byte
 711 ;test11.j(180)   b2=97;
 712 acc8= constant 97
 713 acc8=> variable 1
 714 ;test11.j(181)   for (byte b = 96; b <= 97; b++) { println (b2); b2++; }
 715 acc8= constant 96
 716 acc8=> variable 6
 717 acc8= variable 6
 718 acc8Comp constant 97
 719 brgt 731
 720 br 723
 721 incr8 variable 6
 722 br 717
 723 acc8= variable 1
 724 call writeLineAcc8
 725 incr8 variable 1
 726 br 721
 727 ;test11.j(182)   // byte - integer
 728 ;test11.j(183)   //not relevant
 729 ;test11.j(184)   // integer - byte
 730 ;test11.j(185)   for(word i = 92; i <= 93; i++) { println (b2); b2++; }
 731 acc8= constant 92
 732 acc8=> variable 6
 733 acc16= variable 6
 734 acc8= constant 93
 735 acc16CompareAcc8
 736 brgt 746
 737 br 740
 738 incr16 variable 6
 739 br 733
 740 acc8= variable 1
 741 call writeLineAcc8
 742 incr8 variable 1
 743 br 738
 744 ;test11.j(186)   // integer - integer
 745 ;test11.j(187)   for(word i = 1090; i <= 1091; i++) { println (b2); b2++; }
 746 acc16= constant 1090
 747 acc16=> variable 6
 748 acc16= variable 6
 749 acc16Comp constant 1091
 750 brgt 763
 751 br 754
 752 incr16 variable 6
 753 br 748
 754 acc8= variable 1
 755 call writeLineAcc8
 756 incr8 variable 1
 757 br 752
 758 ;test11.j(188) 
 759 ;test11.j(189)   /************************/
 760 ;test11.j(190)   // var - acc
 761 ;test11.j(191)   // byte - byte
 762 ;test11.j(192)   for (byte b = 104; b <= 105+0; b++) { println (b2); b2++; }
 763 acc8= constant 104
 764 acc8=> variable 6
 765 acc8= constant 105
 766 acc8+ constant 0
 767 acc8Comp variable 6
 768 brlt 778
 769 br 772
 770 incr8 variable 6
 771 br 765
 772 acc8= variable 1
 773 call writeLineAcc8
 774 incr8 variable 1
 775 br 770
 776 ;test11.j(193)   // byte - integer
 777 ;test11.j(194)   i2=103;
 778 acc8= constant 103
 779 acc8=> variable 2
 780 ;test11.j(195)   for (byte b = 102; b <= i2+0; b++) { println (b2); b2++; }
 781 acc8= constant 102
 782 acc8=> variable 6
 783 acc16= variable 2
 784 acc16+ constant 0
 785 acc8= variable 6
 786 acc8CompareAcc16
 787 brgt 797
 788 br 791
 789 incr8 variable 6
 790 br 783
 791 acc8= variable 1
 792 call writeLineAcc8
 793 incr8 variable 1
 794 br 789
 795 ;test11.j(196)   // integer - byte
 796 ;test11.j(197)   for(word i = 100; i <= 101+0; i++) { println (b2); b2++; }
 797 acc8= constant 100
 798 acc8=> variable 6
 799 acc8= constant 101
 800 acc8+ constant 0
 801 acc16= variable 6
 802 acc16CompareAcc8
 803 brgt 813
 804 br 807
 805 incr16 variable 6
 806 br 799
 807 acc8= variable 1
 808 call writeLineAcc8
 809 incr8 variable 1
 810 br 805
 811 ;test11.j(198)   // integer - integer
 812 ;test11.j(199)   for(word i = 1098; i <= 1099+0; i++) { println (b2); b2++; }
 813 acc16= constant 1098
 814 acc16=> variable 6
 815 acc16= constant 1099
 816 acc16+ constant 0
 817 acc16Comp variable 6
 818 brlt 831
 819 br 822
 820 incr16 variable 6
 821 br 815
 822 acc8= variable 1
 823 call writeLineAcc8
 824 incr8 variable 1
 825 br 820
 826 ;test11.j(200) 
 827 ;test11.j(201)   /************************/
 828 ;test11.j(202)   // var - var
 829 ;test11.j(203)   // byte - byte
 830 ;test11.j(204)   for (byte b = 112; b2 <= b; b--) { println (b2); b2++; }
 831 acc8= constant 112
 832 acc8=> variable 6
 833 acc8= variable 1
 834 acc8Comp variable 6
 835 brgt 845
 836 br 839
 837 decr8 variable 6
 838 br 833
 839 acc8= variable 1
 840 call writeLineAcc8
 841 incr8 variable 1
 842 br 837
 843 ;test11.j(205)   // byte - integer
 844 ;test11.j(206)   for(word i = 116; b2 <= i; i--) { println (b2); b2++; }
 845 acc8= constant 116
 846 acc8=> variable 6
 847 acc8= variable 1
 848 acc16= variable 6
 849 acc8CompareAcc16
 850 brgt 860
 851 br 854
 852 decr16 variable 6
 853 br 847
 854 acc8= variable 1
 855 call writeLineAcc8
 856 incr8 variable 1
 857 br 852
 858 ;test11.j(207)   // integer - byte
 859 ;test11.j(208)   i2=b2;
 860 acc8= variable 1
 861 acc8=> variable 2
 862 ;test11.j(209)   for (byte b = 118; i2 <= b; b--) { println (b2); b2++; }
 863 acc8= constant 118
 864 acc8=> variable 6
 865 acc16= variable 2
 866 acc8= variable 6
 867 acc16CompareAcc8
 868 brgt 878
 869 br 872
 870 decr8 variable 6
 871 br 865
 872 acc8= variable 1
 873 call writeLineAcc8
 874 incr8 variable 1
 875 br 870
 876 ;test11.j(210)   // integer - integer
 877 ;test11.j(211)   i2=120;
 878 acc8= constant 120
 879 acc8=> variable 2
 880 ;test11.j(212)   for(word i = b2+4; i2 <= i; i--) { println (b2); b2++; }
 881 acc8= variable 1
 882 acc8+ constant 4
 883 acc8=> variable 6
 884 acc16= variable 2
 885 acc16Comp variable 6
 886 brgt 928
 887 br 890
 888 decr16 variable 6
 889 br 884
 890 acc8= variable 1
 891 call writeLineAcc8
 892 incr8 variable 1
 893 br 888
 894 ;test11.j(213) 
 895 ;test11.j(214)   /************************/
 896 ;test11.j(215)   // var - stack8
 897 ;test11.j(216)   // byte - byte
 898 ;test11.j(217)   // byte - integer
 899 ;test11.j(218)   // integer - byte
 900 ;test11.j(219)   // integer - integer
 901 ;test11.j(220)   //TODO
 902 ;test11.j(221) 
 903 ;test11.j(222)   /************************/
 904 ;test11.j(223)   // var - stack16
 905 ;test11.j(224)   // byte - byte
 906 ;test11.j(225)   // byte - integer
 907 ;test11.j(226)   // integer - byte
 908 ;test11.j(227)   // integer - integer
 909 ;test11.j(228)   //TODO
 910 ;test11.j(229) 
 911 ;test11.j(230)   /************************/
 912 ;test11.j(231)   // stack8 - constant
 913 ;test11.j(232)   // stack8 - acc
 914 ;test11.j(233)   // stack8 - var
 915 ;test11.j(234)   // stack8 - stack8
 916 ;test11.j(235)   // stack8 - stack16
 917 ;test11.j(236)   //TODO
 918 ;test11.j(237) 
 919 ;test11.j(238)   /************************/
 920 ;test11.j(239)   // stack16 - constant
 921 ;test11.j(240)   // stack16 - acc
 922 ;test11.j(241)   // stack16 - var
 923 ;test11.j(242)   // stack16 - stack8
 924 ;test11.j(243)   // stack16 - stack16
 925 ;test11.j(244)   //TODO
 926 ;test11.j(245) 
 927 ;test11.j(246)   println("Klaar.");
 928 acc16= constant 932
 929 writeLineString
 930 ;test11.j(247) }
 931 stop
 932 stringConstant 0 = "Klaar."
