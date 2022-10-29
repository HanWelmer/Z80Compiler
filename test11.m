   0 ;test11.j(0) /* Program to test generated Z80 assembler code */
   1 ;test11.j(1) class TestFor {
   2 ;test11.j(2)   int i2 = 105;
   3 acc8= constant 105
   4 acc8=> variable 0
   5 ;test11.j(3)   int p = 12;
   6 acc8= constant 12
   7 acc8=> variable 2
   8 ;test11.j(4)   byte b2 = 111;
   9 acc8= constant 111
  10 acc8=> variable 4
  11 ;test11.j(5) 
  12 ;test11.j(6)   /************************/
  13 ;test11.j(7)   // stack8 - constant
  14 ;test11.j(8)   // stack8 - acc
  15 ;test11.j(9)   // stack8 - var
  16 ;test11.j(10)   // stack8 - stack8
  17 ;test11.j(11)   // stack8 - stack16
  18 ;test11.j(12)   //TODO
  19 ;test11.j(13) 
  20 ;test11.j(14)   /************************/
  21 ;test11.j(15)   // stack16 - constant
  22 ;test11.j(16)   // stack16 - acc
  23 ;test11.j(17)   // stack16 - var
  24 ;test11.j(18)   // stack16 - stack8
  25 ;test11.j(19)   // stack16 - stack16
  26 ;test11.j(20)   //TODO
  27 ;test11.j(21) 
  28 ;test11.j(22)   /************************/
  29 ;test11.j(23)   // var - stack16
  30 ;test11.j(24)   // byte - byte
  31 ;test11.j(25)   // byte - integer
  32 ;test11.j(26)   // integer - byte
  33 ;test11.j(27)   // integer - integer
  34 ;test11.j(28)   //TODO
  35 ;test11.j(29) 
  36 ;test11.j(30)   /************************/
  37 ;test11.j(31)   // var - stack8
  38 ;test11.j(32)   // byte - byte
  39 ;test11.j(33)   // byte - integer
  40 ;test11.j(34)   // integer - byte
  41 ;test11.j(35)   // integer - integer
  42 ;test11.j(36)   //TODO
  43 ;test11.j(37) 
  44 ;test11.j(38)   /************************/
  45 ;test11.j(39)   // var - var
  46 ;test11.j(40)   // byte - byte
  47 ;test11.j(41)   b2 = 111;
  48 acc8= constant 111
  49 acc8=> variable 4
  50 ;test11.j(42)   for (byte b = 112; b2 <= b; b--) { write (b); }
  51 acc8= constant 112
  52 acc8=> variable 5
  53 acc8= variable 4
  54 acc8Comp variable 5
  55 brgt 64
  56 br 59
  57 decr8 variable 5
  58 br 53
  59 acc8= variable 5
  60 call writeAcc8
  61 br 57
  62 ;test11.j(43)   // byte - integer
  63 ;test11.j(44)   b2 = 109;
  64 acc8= constant 109
  65 acc8=> variable 4
  66 ;test11.j(45)   for(int i = 110; b2 <= i; i--) { write(i); }
  67 acc8= constant 110
  68 acc8=> variable 5
  69 acc8= variable 4
  70 acc16= variable 5
  71 acc8CompareAcc16
  72 brgt 81
  73 br 76
  74 decr16 variable 5
  75 br 69
  76 acc16= variable 5
  77 call writeAcc16
  78 br 74
  79 ;test11.j(46)   // integer - byte
  80 ;test11.j(47)   i2=107;
  81 acc8= constant 107
  82 acc8=> variable 0
  83 ;test11.j(48)   for (byte b = 108; i2 <= b; b--) { write (b); }
  84 acc8= constant 108
  85 acc8=> variable 5
  86 acc16= variable 0
  87 acc8= variable 5
  88 acc16CompareAcc8
  89 brgt 98
  90 br 93
  91 decr8 variable 5
  92 br 86
  93 acc8= variable 5
  94 call writeAcc8
  95 br 91
  96 ;test11.j(49)   // integer - integer
  97 ;test11.j(50)   i2=105;
  98 acc8= constant 105
  99 acc8=> variable 0
 100 ;test11.j(51)   for(int i = 106; i2 <= i; i--) { write(i); }
 101 acc8= constant 106
 102 acc8=> variable 5
 103 acc16= variable 0
 104 acc16Comp variable 5
 105 brgt 117
 106 br 109
 107 decr16 variable 5
 108 br 103
 109 acc16= variable 5
 110 call writeAcc16
 111 br 107
 112 ;test11.j(52) 
 113 ;test11.j(53)   /************************/
 114 ;test11.j(54)   // var - acc
 115 ;test11.j(55)   // byte - byte
 116 ;test11.j(56)   i2=104;
 117 acc8= constant 104
 118 acc8=> variable 0
 119 ;test11.j(57)   for (byte b = 104; b <= 105+0; b++) { write (i2); i2--; }
 120 acc8= constant 104
 121 acc8=> variable 5
 122 acc8= variable 5
 123 <acc8
 124 acc8= constant 105
 125 acc8+ constant 0
 126 revAcc8Comp unstack8
 127 brlt 137
 128 br 131
 129 incr8 variable 5
 130 br 122
 131 acc16= variable 0
 132 call writeAcc16
 133 decr16 variable 0
 134 br 129
 135 ;test11.j(58)   // byte - integer
 136 ;test11.j(59)   i2=103;
 137 acc8= constant 103
 138 acc8=> variable 0
 139 ;test11.j(60)   for (byte b = 102; b <= i2+0; b--) { write (b); i2=i2-2; }
 140 acc8= constant 102
 141 acc8=> variable 5
 142 acc8= variable 5
 143 <acc8
 144 acc16= variable 0
 145 acc16+ constant 0
 146 acc8= unstack8
 147 acc8CompareAcc16
 148 brgt 160
 149 br 152
 150 decr8 variable 5
 151 br 142
 152 acc8= variable 5
 153 call writeAcc8
 154 acc16= variable 0
 155 acc16- constant 2
 156 acc16=> variable 0
 157 br 150
 158 ;test11.j(61)   // integer - byte
 159 ;test11.j(62)   b2=100;
 160 acc8= constant 100
 161 acc8=> variable 4
 162 ;test11.j(63)   for(int i = 100; i <= 101+0; i++) { write(b2); b2--; }
 163 acc8= constant 100
 164 acc8=> variable 5
 165 acc16= variable 5
 166 <acc16
 167 acc8= constant 101
 168 acc8+ constant 0
 169 acc16= unstack16
 170 acc16CompareAcc8
 171 brgt 181
 172 br 175
 173 incr16 variable 5
 174 br 165
 175 acc8= variable 4
 176 call writeAcc8
 177 decr8 variable 4
 178 br 173
 179 ;test11.j(64)   // integer - integer
 180 ;test11.j(65)   for(int i = 1098; i <= 1099+0; i++) { write(b2); b2--; }
 181 acc16= constant 1098
 182 acc16=> variable 5
 183 acc16= variable 5
 184 <acc16
 185 acc16= constant 1099
 186 acc16+ constant 0
 187 revAcc16Comp unstack16
 188 brlt 201
 189 br 192
 190 incr16 variable 5
 191 br 183
 192 acc8= variable 4
 193 call writeAcc8
 194 decr8 variable 4
 195 br 190
 196 ;test11.j(66) 
 197 ;test11.j(67)   /************************/
 198 ;test11.j(68)   // var - constant
 199 ;test11.j(69)   // byte - byte
 200 ;test11.j(70)   i2=96;
 201 acc8= constant 96
 202 acc8=> variable 0
 203 ;test11.j(71)   for (byte b = 96; b <= 97; b++) { write (i2); i2--; }
 204 acc8= constant 96
 205 acc8=> variable 5
 206 acc8= variable 5
 207 acc8Comp constant 97
 208 brgt 219
 209 br 212
 210 incr8 variable 5
 211 br 206
 212 acc16= variable 0
 213 call writeAcc16
 214 decr16 variable 0
 215 br 210
 216 ;test11.j(72)   // byte - integer
 217 ;test11.j(73)   //not relevant
 218 ;test11.j(74)   write(94);
 219 acc8= constant 94
 220 call writeAcc8
 221 ;test11.j(75)   write(93);
 222 acc8= constant 93
 223 call writeAcc8
 224 ;test11.j(76)   // integer - byte
 225 ;test11.j(77)   b2=92;
 226 acc8= constant 92
 227 acc8=> variable 4
 228 ;test11.j(78)   for(int i = 92; i <= 93; i++) { write(b2); b2--; }
 229 acc8= constant 92
 230 acc8=> variable 5
 231 acc16= variable 5
 232 acc8= constant 93
 233 acc16CompareAcc8
 234 brgt 244
 235 br 238
 236 incr16 variable 5
 237 br 231
 238 acc8= variable 4
 239 call writeAcc8
 240 decr8 variable 4
 241 br 236
 242 ;test11.j(79)   // integer - integer
 243 ;test11.j(80)   for(int i = 1090; i <= 1091; i++) { write(b2); b2--; }
 244 acc16= constant 1090
 245 acc16=> variable 5
 246 acc16= variable 5
 247 acc16Comp constant 1091
 248 brgt 262
 249 br 252
 250 incr16 variable 5
 251 br 246
 252 acc8= variable 4
 253 call writeAcc8
 254 decr8 variable 4
 255 br 250
 256 ;test11.j(81) 
 257 ;test11.j(82)   /************************/
 258 ;test11.j(83)   // acc - stack8
 259 ;test11.j(84)   // byte - byte
 260 ;test11.j(85)   //TODO
 261 ;test11.j(86)   write(88);
 262 acc8= constant 88
 263 call writeAcc8
 264 ;test11.j(87)   write(87);
 265 acc8= constant 87
 266 call writeAcc8
 267 ;test11.j(88)   // byte - integer
 268 ;test11.j(89)   //TODO
 269 ;test11.j(90)   write(86);
 270 acc8= constant 86
 271 call writeAcc8
 272 ;test11.j(91)   write(85);
 273 acc8= constant 85
 274 call writeAcc8
 275 ;test11.j(92)   // integer - byte
 276 ;test11.j(93)   //TODO
 277 ;test11.j(94)   write(84);
 278 acc8= constant 84
 279 call writeAcc8
 280 ;test11.j(95)   write(83);
 281 acc8= constant 83
 282 call writeAcc8
 283 ;test11.j(96)   // integer - integer
 284 ;test11.j(97)   //TODO
 285 ;test11.j(98)   write(82);
 286 acc8= constant 82
 287 call writeAcc8
 288 ;test11.j(99)   write(81);
 289 acc8= constant 81
 290 call writeAcc8
 291 ;test11.j(100) 
 292 ;test11.j(101)   /************************/
 293 ;test11.j(102)   // acc - stack16
 294 ;test11.j(103)   // byte - byte
 295 ;test11.j(104)   //TODO
 296 ;test11.j(105)   write(80);
 297 acc8= constant 80
 298 call writeAcc8
 299 ;test11.j(106)   write(79);
 300 acc8= constant 79
 301 call writeAcc8
 302 ;test11.j(107)   // byte - integer
 303 ;test11.j(108)   //TODO
 304 ;test11.j(109)   write(78);
 305 acc8= constant 78
 306 call writeAcc8
 307 ;test11.j(110)   write(77);
 308 acc8= constant 77
 309 call writeAcc8
 310 ;test11.j(111)   // integer - byte
 311 ;test11.j(112)   //TODO
 312 ;test11.j(113)   write(76);
 313 acc8= constant 76
 314 call writeAcc8
 315 ;test11.j(114)   write(75);
 316 acc8= constant 75
 317 call writeAcc8
 318 ;test11.j(115)   // integer - integer
 319 ;test11.j(116)   //TODO
 320 ;test11.j(117)   write(74);
 321 acc8= constant 74
 322 call writeAcc8
 323 ;test11.j(118)   write(73);
 324 acc8= constant 73
 325 call writeAcc8
 326 ;test11.j(119) 
 327 ;test11.j(120)   /************************/
 328 ;test11.j(121)   // acc - var
 329 ;test11.j(122)   // byte - byte
 330 ;test11.j(123)   for (byte b = 72; 71+0 <= b; b--) { write (b); }
 331 acc8= constant 72
 332 acc8=> variable 5
 333 acc8= constant 71
 334 acc8+ constant 0
 335 acc8Comp variable 5
 336 brgt 345
 337 br 340
 338 decr8 variable 5
 339 br 333
 340 acc8= variable 5
 341 call writeAcc8
 342 br 338
 343 ;test11.j(124)   // byte - integer
 344 ;test11.j(125)   for(int i = 70; 69+0 <= i; i--) { write(i); }
 345 acc8= constant 70
 346 acc8=> variable 5
 347 acc8= constant 69
 348 acc8+ constant 0
 349 acc16= variable 5
 350 acc8CompareAcc16
 351 brgt 360
 352 br 355
 353 decr16 variable 5
 354 br 347
 355 acc16= variable 5
 356 call writeAcc16
 357 br 353
 358 ;test11.j(126)   // integer - byte
 359 ;test11.j(127)   i2=67;
 360 acc8= constant 67
 361 acc8=> variable 0
 362 ;test11.j(128)   for (byte b = 68; i2+0 <= b; b--) { write (b); }
 363 acc8= constant 68
 364 acc8=> variable 5
 365 acc16= variable 0
 366 acc16+ constant 0
 367 acc8= variable 5
 368 acc16CompareAcc8
 369 brgt 378
 370 br 373
 371 decr8 variable 5
 372 br 365
 373 acc8= variable 5
 374 call writeAcc8
 375 br 371
 376 ;test11.j(129)   // integer - integer
 377 ;test11.j(130)   b2 = 66;
 378 acc8= constant 66
 379 acc8=> variable 4
 380 ;test11.j(131)   for(int i = 1066; 1000+65 <= i; i--) { write (b2); b2--; }
 381 acc16= constant 1066
 382 acc16=> variable 5
 383 acc16= constant 1000
 384 acc16+ constant 65
 385 acc16Comp variable 5
 386 brgt 399
 387 br 390
 388 decr16 variable 5
 389 br 383
 390 acc8= variable 4
 391 call writeAcc8
 392 decr8 variable 4
 393 br 388
 394 ;test11.j(132) 
 395 ;test11.j(133)   /************************/
 396 ;test11.j(134)   // acc - acc
 397 ;test11.j(135)   // byte - byte
 398 ;test11.j(136)   for (byte b = 64; 63+0 <= b+0; b--) { write (b); }
 399 acc8= constant 64
 400 acc8=> variable 5
 401 acc8= constant 63
 402 acc8+ constant 0
 403 <acc8
 404 acc8= variable 5
 405 acc8+ constant 0
 406 revAcc8Comp unstack8
 407 brlt 416
 408 br 411
 409 decr8 variable 5
 410 br 401
 411 acc8= variable 5
 412 call writeAcc8
 413 br 409
 414 ;test11.j(137)   // byte - integer
 415 ;test11.j(138)   for(int i = 62; 61+0 <= i+0; i--) { write(i); }
 416 acc8= constant 62
 417 acc8=> variable 5
 418 acc8= constant 61
 419 acc8+ constant 0
 420 <acc8
 421 acc16= variable 5
 422 acc16+ constant 0
 423 acc8= unstack8
 424 acc8CompareAcc16
 425 brgt 434
 426 br 429
 427 decr16 variable 5
 428 br 418
 429 acc16= variable 5
 430 call writeAcc16
 431 br 427
 432 ;test11.j(139)   // integer - byte
 433 ;test11.j(140)   i2=59;
 434 acc8= constant 59
 435 acc8=> variable 0
 436 ;test11.j(141)   for (byte b = 60; i2+0 <= b+0; b--) { write (b); }
 437 acc8= constant 60
 438 acc8=> variable 5
 439 acc16= variable 0
 440 acc16+ constant 0
 441 <acc16
 442 acc8= variable 5
 443 acc8+ constant 0
 444 acc16= unstack16
 445 acc16CompareAcc8
 446 brgt 455
 447 br 450
 448 decr8 variable 5
 449 br 439
 450 acc8= variable 5
 451 call writeAcc8
 452 br 448
 453 ;test11.j(142)   // integer - integer
 454 ;test11.j(143)   b2=58;
 455 acc8= constant 58
 456 acc8=> variable 4
 457 ;test11.j(144)   for(int i = 1058; 1000+57 <= i+0; i--) { write(b2); b2--; }
 458 acc16= constant 1058
 459 acc16=> variable 5
 460 acc16= constant 1000
 461 acc16+ constant 57
 462 <acc16
 463 acc16= variable 5
 464 acc16+ constant 0
 465 revAcc16Comp unstack16
 466 brlt 479
 467 br 470
 468 decr16 variable 5
 469 br 460
 470 acc8= variable 4
 471 call writeAcc8
 472 decr8 variable 4
 473 br 468
 474 ;test11.j(145) 
 475 ;test11.j(146)   /************************/
 476 ;test11.j(147)   // acc - constant
 477 ;test11.j(148)   // byte - byte
 478 ;test11.j(149)   i2=56;
 479 acc8= constant 56
 480 acc8=> variable 0
 481 ;test11.j(150)   for (byte b = 56; b+0 <= 57; b++) { write (i2); i2--; }
 482 acc8= constant 56
 483 acc8=> variable 5
 484 acc8= variable 5
 485 acc8+ constant 0
 486 acc8Comp constant 57
 487 brgt 499
 488 br 491
 489 incr8 variable 5
 490 br 484
 491 acc16= variable 0
 492 call writeAcc16
 493 decr16 variable 0
 494 br 489
 495 ;test11.j(151)   // byte - integer
 496 ;test11.j(152)   //not relevant
 497 ;test11.j(153)   // integer - byte
 498 ;test11.j(154)   b2=54;
 499 acc8= constant 54
 500 acc8=> variable 4
 501 ;test11.j(155)   for (int i = 54; i+0 <= 55; i++) { write (b2); b2--;}
 502 acc8= constant 54
 503 acc8=> variable 5
 504 acc16= variable 5
 505 acc16+ constant 0
 506 acc8= constant 55
 507 acc16CompareAcc8
 508 brgt 518
 509 br 512
 510 incr16 variable 5
 511 br 504
 512 acc8= variable 4
 513 call writeAcc8
 514 decr8 variable 4
 515 br 510
 516 ;test11.j(156)   // integer - integer
 517 ;test11.j(157)   b2=52;
 518 acc8= constant 52
 519 acc8=> variable 4
 520 ;test11.j(158)   for(int i = 1052; i+0 <= 1053; i++) { write(b2); b2--; }
 521 acc16= constant 1052
 522 acc16=> variable 5
 523 acc16= variable 5
 524 acc16+ constant 0
 525 acc16Comp constant 1053
 526 brgt 540
 527 br 530
 528 incr16 variable 5
 529 br 523
 530 acc8= variable 4
 531 call writeAcc8
 532 decr8 variable 4
 533 br 528
 534 ;test11.j(159) 
 535 ;test11.j(160)   /************************/
 536 ;test11.j(161)   // constant - stack8
 537 ;test11.j(162)   // byte - byte
 538 ;test11.j(163)   //TODO
 539 ;test11.j(164)   write(50);
 540 acc8= constant 50
 541 call writeAcc8
 542 ;test11.j(165)   // constant - stack8
 543 ;test11.j(166)   // byte - integer
 544 ;test11.j(167)   //TODO
 545 ;test11.j(168)   write(49);
 546 acc8= constant 49
 547 call writeAcc8
 548 ;test11.j(169)   // constant - stack8
 549 ;test11.j(170)   // integer - byte
 550 ;test11.j(171)   //TODO
 551 ;test11.j(172)   write(48);
 552 acc8= constant 48
 553 call writeAcc8
 554 ;test11.j(173)   // constant - stack88
 555 ;test11.j(174)   // integer - integer
 556 ;test11.j(175)   //TODO
 557 ;test11.j(176)   write(47);
 558 acc8= constant 47
 559 call writeAcc8
 560 ;test11.j(177) 
 561 ;test11.j(178)   /************************/
 562 ;test11.j(179)   // constant - stack16
 563 ;test11.j(180)   // byte - byte
 564 ;test11.j(181)   //TODO
 565 ;test11.j(182)   write(46);
 566 acc8= constant 46
 567 call writeAcc8
 568 ;test11.j(183)   // constant - stack16
 569 ;test11.j(184)   // byte - integer
 570 ;test11.j(185)   //TODO
 571 ;test11.j(186)   write(45);
 572 acc8= constant 45
 573 call writeAcc8
 574 ;test11.j(187)   // constant - stack16
 575 ;test11.j(188)   // integer - byte
 576 ;test11.j(189)   //TODO
 577 ;test11.j(190)   write(44);
 578 acc8= constant 44
 579 call writeAcc8
 580 ;test11.j(191)   // constant - stack16
 581 ;test11.j(192)   // integer - integer
 582 ;test11.j(193)   //TODO
 583 ;test11.j(194)   write(43);
 584 acc8= constant 43
 585 call writeAcc8
 586 ;test11.j(195) 
 587 ;test11.j(196)   /************************/
 588 ;test11.j(197)   // constant - var
 589 ;test11.j(198)   // byte - byte
 590 ;test11.j(199)   for (byte b = 42; 41 <= b; b--) { write (b); }
 591 acc8= constant 42
 592 acc8=> variable 5
 593 acc8= variable 5
 594 acc8Comp constant 41
 595 brlt 605
 596 br 599
 597 decr8 variable 5
 598 br 593
 599 acc8= variable 5
 600 call writeAcc8
 601 br 597
 602 ;test11.j(200)   // constant - var
 603 ;test11.j(201)   // byte - integer
 604 ;test11.j(202)   for(int i = 40; 39 <= i; i--) { write(i); }
 605 acc8= constant 40
 606 acc8=> variable 5
 607 acc16= variable 5
 608 acc8= constant 39
 609 acc8CompareAcc16
 610 brgt 623
 611 br 614
 612 decr16 variable 5
 613 br 607
 614 acc16= variable 5
 615 call writeAcc16
 616 br 612
 617 ;test11.j(203)   // constant - var
 618 ;test11.j(204)   // integer - byte
 619 ;test11.j(205)   // not relevant
 620 ;test11.j(206)   // constant - var
 621 ;test11.j(207)   // integer - integer
 622 ;test11.j(208)   b2=38;
 623 acc8= constant 38
 624 acc8=> variable 4
 625 ;test11.j(209)   for(int i = 1038; 1037 <= i; i--) { write(b2); b2--; }
 626 acc16= constant 1038
 627 acc16=> variable 5
 628 acc16= variable 5
 629 acc16Comp constant 1037
 630 brlt 643
 631 br 634
 632 decr16 variable 5
 633 br 628
 634 acc8= variable 4
 635 call writeAcc8
 636 decr8 variable 4
 637 br 632
 638 ;test11.j(210) 
 639 ;test11.j(211)   /************************/
 640 ;test11.j(212)   // constant - acc
 641 ;test11.j(213)   // byte - byte
 642 ;test11.j(214)   for (byte b = 36; 136 == b+100; b--) { write (b); }
 643 acc8= constant 36
 644 acc8=> variable 5
 645 acc8= variable 5
 646 acc8+ constant 100
 647 acc8Comp constant 136
 648 brne 656
 649 br 652
 650 decr8 variable 5
 651 br 645
 652 acc8= variable 5
 653 call writeAcc8
 654 br 650
 655 ;test11.j(215)   for (byte b = 35; 132 != b+100; b--) { write (b); }
 656 acc8= constant 35
 657 acc8=> variable 5
 658 acc8= variable 5
 659 acc8+ constant 100
 660 acc8Comp constant 132
 661 breq 669
 662 br 665
 663 decr8 variable 5
 664 br 658
 665 acc8= variable 5
 666 call writeAcc8
 667 br 663
 668 ;test11.j(216)   b2=32;
 669 acc8= constant 32
 670 acc8=> variable 4
 671 ;test11.j(217)   for (byte b = 32; 134 > b+100; b++) { write (b2); b2--; }
 672 acc8= constant 32
 673 acc8=> variable 5
 674 acc8= variable 5
 675 acc8+ constant 100
 676 acc8Comp constant 134
 677 brge 686
 678 br 681
 679 incr8 variable 5
 680 br 674
 681 acc8= variable 4
 682 call writeAcc8
 683 decr8 variable 4
 684 br 679
 685 ;test11.j(218)   for (byte b = 34; 135 >= b+100; b++) { write (b2); b2--; }
 686 acc8= constant 34
 687 acc8=> variable 5
 688 acc8= variable 5
 689 acc8+ constant 100
 690 acc8Comp constant 135
 691 brgt 700
 692 br 695
 693 incr8 variable 5
 694 br 688
 695 acc8= variable 4
 696 call writeAcc8
 697 decr8 variable 4
 698 br 693
 699 ;test11.j(219)   for (byte b = 28; 126 <  b+100; b--) { write (b); }
 700 acc8= constant 28
 701 acc8=> variable 5
 702 acc8= variable 5
 703 acc8+ constant 100
 704 acc8Comp constant 126
 705 brle 713
 706 br 709
 707 decr8 variable 5
 708 br 702
 709 acc8= variable 5
 710 call writeAcc8
 711 br 707
 712 ;test11.j(220)   for (byte b = 26; 125 <= b+100; b--) { write (b); }
 713 acc8= constant 26
 714 acc8=> variable 5
 715 acc8= variable 5
 716 acc8+ constant 100
 717 acc8Comp constant 125
 718 brlt 728
 719 br 722
 720 decr8 variable 5
 721 br 715
 722 acc8= variable 5
 723 call writeAcc8
 724 br 720
 725 ;test11.j(221)   // constant - acc
 726 ;test11.j(222)   // byte - integer
 727 ;test11.j(223)   for(int i = 24; 24 == i+0; i--) { write(i); }
 728 acc8= constant 24
 729 acc8=> variable 5
 730 acc16= variable 5
 731 acc16+ constant 0
 732 acc8= constant 24
 733 acc8CompareAcc16
 734 brne 742
 735 br 738
 736 decr16 variable 5
 737 br 730
 738 acc16= variable 5
 739 call writeAcc16
 740 br 736
 741 ;test11.j(224)   for(int i = 23; 120 != i+100; i--) { write(i); }
 742 acc8= constant 23
 743 acc8=> variable 5
 744 acc16= variable 5
 745 acc16+ constant 100
 746 acc8= constant 120
 747 acc8CompareAcc16
 748 breq 756
 749 br 752
 750 decr16 variable 5
 751 br 744
 752 acc16= variable 5
 753 call writeAcc16
 754 br 750
 755 ;test11.j(225)   b2=20;
 756 acc8= constant 20
 757 acc8=> variable 4
 758 ;test11.j(226)   for(int i = 20; 122 > i+100; i++) { write (b2); b2--; }
 759 acc8= constant 20
 760 acc8=> variable 5
 761 acc16= variable 5
 762 acc16+ constant 100
 763 acc8= constant 122
 764 acc8CompareAcc16
 765 brle 774
 766 br 769
 767 incr16 variable 5
 768 br 761
 769 acc8= variable 4
 770 call writeAcc8
 771 decr8 variable 4
 772 br 767
 773 ;test11.j(227)   for(int i = 22; 123 >= i+100; i++) { write (b2); b2--; }
 774 acc8= constant 22
 775 acc8=> variable 5
 776 acc16= variable 5
 777 acc16+ constant 100
 778 acc8= constant 123
 779 acc8CompareAcc16
 780 brlt 789
 781 br 784
 782 incr16 variable 5
 783 br 776
 784 acc8= variable 4
 785 call writeAcc8
 786 decr8 variable 4
 787 br 782
 788 ;test11.j(228)   for(int i = 16; 114 <  i+100; i--) { write(i); }
 789 acc8= constant 16
 790 acc8=> variable 5
 791 acc16= variable 5
 792 acc16+ constant 100
 793 acc8= constant 114
 794 acc8CompareAcc16
 795 brge 803
 796 br 799
 797 decr16 variable 5
 798 br 791
 799 acc16= variable 5
 800 call writeAcc16
 801 br 797
 802 ;test11.j(229)   for(int i = 14; 113 <= i+100; i--) { write(i); }
 803 acc8= constant 14
 804 acc8=> variable 5
 805 acc16= variable 5
 806 acc16+ constant 100
 807 acc8= constant 113
 808 acc8CompareAcc16
 809 brgt 823
 810 br 813
 811 decr16 variable 5
 812 br 805
 813 acc16= variable 5
 814 call writeAcc16
 815 br 811
 816 ;test11.j(230)   // constant - acc
 817 ;test11.j(231)   // integer - byte
 818 ;test11.j(232)   // not relevant
 819 ;test11.j(233) 
 820 ;test11.j(234)   // constant - acc
 821 ;test11.j(235)   // integer - integer
 822 ;test11.j(236)   for(int i = 12; 1012 == i+1000; i--) { write(i); }
 823 acc8= constant 12
 824 acc8=> variable 5
 825 acc16= variable 5
 826 acc16+ constant 1000
 827 acc16Comp constant 1012
 828 brne 836
 829 br 832
 830 decr16 variable 5
 831 br 825
 832 acc16= variable 5
 833 call writeAcc16
 834 br 830
 835 ;test11.j(237)   for(int i = 11; 1008 != i+1000; i--) { write(i); }
 836 acc8= constant 11
 837 acc8=> variable 5
 838 acc16= variable 5
 839 acc16+ constant 1000
 840 acc16Comp constant 1008
 841 breq 849
 842 br 845
 843 decr16 variable 5
 844 br 838
 845 acc16= variable 5
 846 call writeAcc16
 847 br 843
 848 ;test11.j(238)   b2=8;
 849 acc8= constant 8
 850 acc8=> variable 4
 851 ;test11.j(239)   for(int i = 8; 1010 > i+1000; i++) { write (b2); b2--; }
 852 acc8= constant 8
 853 acc8=> variable 5
 854 acc16= variable 5
 855 acc16+ constant 1000
 856 acc16Comp constant 1010
 857 brge 866
 858 br 861
 859 incr16 variable 5
 860 br 854
 861 acc8= variable 4
 862 call writeAcc8
 863 decr8 variable 4
 864 br 859
 865 ;test11.j(240)   for(int i = 10; 1011 >= i+1000; i++) { write (b2); b2--; }
 866 acc8= constant 10
 867 acc8=> variable 5
 868 acc16= variable 5
 869 acc16+ constant 1000
 870 acc16Comp constant 1011
 871 brgt 880
 872 br 875
 873 incr16 variable 5
 874 br 868
 875 acc8= variable 4
 876 call writeAcc8
 877 decr8 variable 4
 878 br 873
 879 ;test11.j(241)   for(int i = 4; 1002 <  i+1000; i--) { write(i); }
 880 acc8= constant 4
 881 acc8=> variable 5
 882 acc16= variable 5
 883 acc16+ constant 1000
 884 acc16Comp constant 1002
 885 brle 893
 886 br 889
 887 decr16 variable 5
 888 br 882
 889 acc16= variable 5
 890 call writeAcc16
 891 br 887
 892 ;test11.j(242)   for(int i = 2; 1001 <= i+1000; i--) { write(i); }
 893 acc8= constant 2
 894 acc8=> variable 5
 895 acc16= variable 5
 896 acc16+ constant 1000
 897 acc16Comp constant 1001
 898 brlt 906
 899 br 902
 900 decr16 variable 5
 901 br 895
 902 acc16= variable 5
 903 call writeAcc16
 904 br 900
 905 ;test11.j(243)   write(0);
 906 acc8= constant 0
 907 call writeAcc8
 908 ;test11.j(244) }
 909 stop
