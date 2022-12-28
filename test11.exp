   0 ;test11.j(0) /* Program to test generated Z80 assembler code */
   1 ;test11.j(1) class TestFor {
   2 ;test11.j(2)   byte b1 = 115;
   3 acc8= constant 115
   4 acc8=> variable 0
   5 ;test11.j(3)   
   6 ;test11.j(4)   /************************/
   7 ;test11.j(5)   // global variable within for scope
   8 ;test11.j(6)   write (b1);
   9 acc8= variable 0
  10 call writeAcc8
  11 ;test11.j(7)   b1--;
  12 decr8 variable 0
  13 ;test11.j(8)   do {
  14 ;test11.j(9)     word j = 1001;
  15 acc16= constant 1001
  16 acc16=> variable 1
  17 ;test11.j(10)     byte c = b1;
  18 acc8= variable 0
  19 acc8=> variable 3
  20 ;test11.j(11)     byte d = c;
  21 acc8= variable 3
  22 acc8=> variable 4
  23 ;test11.j(12)     b1--;
  24 decr8 variable 0
  25 ;test11.j(13)     write (c);
  26 acc8= variable 3
  27 call writeAcc8
  28 ;test11.j(14)   } while (b1>112);
  29 acc8= variable 0
  30 acc8Comp constant 112
  31 brgt 14
  32 ;test11.j(15) 
  33 ;test11.j(16)   /************************/
  34 ;test11.j(17)   word i2 = 105;
  35 acc8= constant 105
  36 acc8=> variable 1
  37 ;test11.j(18)   word p = 12;
  38 acc8= constant 12
  39 acc8=> variable 3
  40 ;test11.j(19)   byte b2 = 111;
  41 acc8= constant 111
  42 acc8=> variable 5
  43 ;test11.j(20) 
  44 ;test11.j(21)   /************************/
  45 ;test11.j(22)   // stack8 - constant
  46 ;test11.j(23)   // stack8 - acc
  47 ;test11.j(24)   // stack8 - var
  48 ;test11.j(25)   // stack8 - stack8
  49 ;test11.j(26)   // stack8 - stack16
  50 ;test11.j(27)   //TODO
  51 ;test11.j(28) 
  52 ;test11.j(29)   /************************/
  53 ;test11.j(30)   // stack16 - constant
  54 ;test11.j(31)   // stack16 - acc
  55 ;test11.j(32)   // stack16 - var
  56 ;test11.j(33)   // stack16 - stack8
  57 ;test11.j(34)   // stack16 - stack16
  58 ;test11.j(35)   //TODO
  59 ;test11.j(36) 
  60 ;test11.j(37)   /************************/
  61 ;test11.j(38)   // var - stack16
  62 ;test11.j(39)   // byte - byte
  63 ;test11.j(40)   // byte - integer
  64 ;test11.j(41)   // integer - byte
  65 ;test11.j(42)   // integer - integer
  66 ;test11.j(43)   //TODO
  67 ;test11.j(44) 
  68 ;test11.j(45)   /************************/
  69 ;test11.j(46)   // var - stack8
  70 ;test11.j(47)   // byte - byte
  71 ;test11.j(48)   // byte - integer
  72 ;test11.j(49)   // integer - byte
  73 ;test11.j(50)   // integer - integer
  74 ;test11.j(51)   //TODO
  75 ;test11.j(52) 
  76 ;test11.j(53)   /************************/
  77 ;test11.j(54)   // var - var
  78 ;test11.j(55)   // byte - byte
  79 ;test11.j(56)   b2 = 111;
  80 acc8= constant 111
  81 acc8=> variable 5
  82 ;test11.j(57)   for (byte b = 112; b2 <= b; b--) { write (b); }
  83 acc8= constant 112
  84 acc8=> variable 6
  85 acc8= variable 5
  86 acc8Comp variable 6
  87 brgt 96
  88 br 91
  89 decr8 variable 6
  90 br 85
  91 acc8= variable 6
  92 call writeAcc8
  93 br 89
  94 ;test11.j(58)   // byte - integer
  95 ;test11.j(59)   b2 = 109;
  96 acc8= constant 109
  97 acc8=> variable 5
  98 ;test11.j(60)   for(word i = 110; b2 <= i; i--) { write(i); }
  99 acc8= constant 110
 100 acc8=> variable 6
 101 acc8= variable 5
 102 acc16= variable 6
 103 acc8CompareAcc16
 104 brgt 113
 105 br 108
 106 decr16 variable 6
 107 br 101
 108 acc16= variable 6
 109 call writeAcc16
 110 br 106
 111 ;test11.j(61)   // integer - byte
 112 ;test11.j(62)   i2=107;
 113 acc8= constant 107
 114 acc8=> variable 1
 115 ;test11.j(63)   for (byte b = 108; i2 <= b; b--) { write (b); }
 116 acc8= constant 108
 117 acc8=> variable 6
 118 acc16= variable 1
 119 acc8= variable 6
 120 acc16CompareAcc8
 121 brgt 130
 122 br 125
 123 decr8 variable 6
 124 br 118
 125 acc8= variable 6
 126 call writeAcc8
 127 br 123
 128 ;test11.j(64)   // integer - integer
 129 ;test11.j(65)   i2=105;
 130 acc8= constant 105
 131 acc8=> variable 1
 132 ;test11.j(66)   for(word i = 106; i2 <= i; i--) { write(i); }
 133 acc8= constant 106
 134 acc8=> variable 6
 135 acc16= variable 1
 136 acc16Comp variable 6
 137 brgt 149
 138 br 141
 139 decr16 variable 6
 140 br 135
 141 acc16= variable 6
 142 call writeAcc16
 143 br 139
 144 ;test11.j(67) 
 145 ;test11.j(68)   /************************/
 146 ;test11.j(69)   // var - acc
 147 ;test11.j(70)   // byte - byte
 148 ;test11.j(71)   i2=104;
 149 acc8= constant 104
 150 acc8=> variable 1
 151 ;test11.j(72)   for (byte b = 104; b <= 105+0; b++) { write (i2); i2--; }
 152 acc8= constant 104
 153 acc8=> variable 6
 154 acc8= constant 105
 155 acc8+ constant 0
 156 acc8Comp variable 6
 157 brlt 167
 158 br 161
 159 incr8 variable 6
 160 br 154
 161 acc16= variable 1
 162 call writeAcc16
 163 decr16 variable 1
 164 br 159
 165 ;test11.j(73)   // byte - integer
 166 ;test11.j(74)   i2=103;
 167 acc8= constant 103
 168 acc8=> variable 1
 169 ;test11.j(75)   for (byte b = 102; b <= i2+0; b--) { write (b); i2=i2-2; }
 170 acc8= constant 102
 171 acc8=> variable 6
 172 acc16= variable 1
 173 acc16+ constant 0
 174 acc8= variable 6
 175 acc8CompareAcc16
 176 brgt 188
 177 br 180
 178 decr8 variable 6
 179 br 172
 180 acc8= variable 6
 181 call writeAcc8
 182 acc16= variable 1
 183 acc16- constant 2
 184 acc16=> variable 1
 185 br 178
 186 ;test11.j(76)   // integer - byte
 187 ;test11.j(77)   b2=100;
 188 acc8= constant 100
 189 acc8=> variable 5
 190 ;test11.j(78)   for(word i = 100; i <= 101+0; i++) { write(b2); b2--; }
 191 acc8= constant 100
 192 acc8=> variable 6
 193 acc8= constant 101
 194 acc8+ constant 0
 195 acc16= variable 6
 196 acc16CompareAcc8
 197 brgt 207
 198 br 201
 199 incr16 variable 6
 200 br 193
 201 acc8= variable 5
 202 call writeAcc8
 203 decr8 variable 5
 204 br 199
 205 ;test11.j(79)   // integer - integer
 206 ;test11.j(80)   for(word i = 1098; i <= 1099+0; i++) { write(b2); b2--; }
 207 acc16= constant 1098
 208 acc16=> variable 6
 209 acc16= constant 1099
 210 acc16+ constant 0
 211 acc16Comp variable 6
 212 brlt 225
 213 br 216
 214 incr16 variable 6
 215 br 209
 216 acc8= variable 5
 217 call writeAcc8
 218 decr8 variable 5
 219 br 214
 220 ;test11.j(81) 
 221 ;test11.j(82)   /************************/
 222 ;test11.j(83)   // var - constant
 223 ;test11.j(84)   // byte - byte
 224 ;test11.j(85)   i2=96;
 225 acc8= constant 96
 226 acc8=> variable 1
 227 ;test11.j(86)   for (byte b = 96; b <= 97; b++) { write (i2); i2--; }
 228 acc8= constant 96
 229 acc8=> variable 6
 230 acc8= variable 6
 231 acc8Comp constant 97
 232 brgt 243
 233 br 236
 234 incr8 variable 6
 235 br 230
 236 acc16= variable 1
 237 call writeAcc16
 238 decr16 variable 1
 239 br 234
 240 ;test11.j(87)   // byte - integer
 241 ;test11.j(88)   //not relevant
 242 ;test11.j(89)   write(94);
 243 acc8= constant 94
 244 call writeAcc8
 245 ;test11.j(90)   write(93);
 246 acc8= constant 93
 247 call writeAcc8
 248 ;test11.j(91)   // integer - byte
 249 ;test11.j(92)   b2=92;
 250 acc8= constant 92
 251 acc8=> variable 5
 252 ;test11.j(93)   for(word i = 92; i <= 93; i++) { write(b2); b2--; }
 253 acc8= constant 92
 254 acc8=> variable 6
 255 acc16= variable 6
 256 acc8= constant 93
 257 acc16CompareAcc8
 258 brgt 268
 259 br 262
 260 incr16 variable 6
 261 br 255
 262 acc8= variable 5
 263 call writeAcc8
 264 decr8 variable 5
 265 br 260
 266 ;test11.j(94)   // integer - integer
 267 ;test11.j(95)   for(word i = 1090; i <= 1091; i++) { write(b2); b2--; }
 268 acc16= constant 1090
 269 acc16=> variable 6
 270 acc16= variable 6
 271 acc16Comp constant 1091
 272 brgt 286
 273 br 276
 274 incr16 variable 6
 275 br 270
 276 acc8= variable 5
 277 call writeAcc8
 278 decr8 variable 5
 279 br 274
 280 ;test11.j(96) 
 281 ;test11.j(97)   /************************/
 282 ;test11.j(98)   // acc - stack8
 283 ;test11.j(99)   // byte - byte
 284 ;test11.j(100)   //TODO
 285 ;test11.j(101)   write(88);
 286 acc8= constant 88
 287 call writeAcc8
 288 ;test11.j(102)   write(87);
 289 acc8= constant 87
 290 call writeAcc8
 291 ;test11.j(103)   // byte - integer
 292 ;test11.j(104)   //TODO
 293 ;test11.j(105)   write(86);
 294 acc8= constant 86
 295 call writeAcc8
 296 ;test11.j(106)   write(85);
 297 acc8= constant 85
 298 call writeAcc8
 299 ;test11.j(107)   // integer - byte
 300 ;test11.j(108)   //TODO
 301 ;test11.j(109)   write(84);
 302 acc8= constant 84
 303 call writeAcc8
 304 ;test11.j(110)   write(83);
 305 acc8= constant 83
 306 call writeAcc8
 307 ;test11.j(111)   // integer - integer
 308 ;test11.j(112)   //TODO
 309 ;test11.j(113)   write(82);
 310 acc8= constant 82
 311 call writeAcc8
 312 ;test11.j(114)   write(81);
 313 acc8= constant 81
 314 call writeAcc8
 315 ;test11.j(115) 
 316 ;test11.j(116)   /************************/
 317 ;test11.j(117)   // acc - stack16
 318 ;test11.j(118)   // byte - byte
 319 ;test11.j(119)   //TODO
 320 ;test11.j(120)   write(80);
 321 acc8= constant 80
 322 call writeAcc8
 323 ;test11.j(121)   write(79);
 324 acc8= constant 79
 325 call writeAcc8
 326 ;test11.j(122)   // byte - integer
 327 ;test11.j(123)   //TODO
 328 ;test11.j(124)   write(78);
 329 acc8= constant 78
 330 call writeAcc8
 331 ;test11.j(125)   write(77);
 332 acc8= constant 77
 333 call writeAcc8
 334 ;test11.j(126)   // integer - byte
 335 ;test11.j(127)   //TODO
 336 ;test11.j(128)   write(76);
 337 acc8= constant 76
 338 call writeAcc8
 339 ;test11.j(129)   write(75);
 340 acc8= constant 75
 341 call writeAcc8
 342 ;test11.j(130)   // integer - integer
 343 ;test11.j(131)   //TODO
 344 ;test11.j(132)   write(74);
 345 acc8= constant 74
 346 call writeAcc8
 347 ;test11.j(133)   write(73);
 348 acc8= constant 73
 349 call writeAcc8
 350 ;test11.j(134) 
 351 ;test11.j(135)   /************************/
 352 ;test11.j(136)   // acc - var
 353 ;test11.j(137)   // byte - byte
 354 ;test11.j(138)   for (byte b = 72; 71+0 <= b; b--) { write (b); }
 355 acc8= constant 72
 356 acc8=> variable 6
 357 acc8= constant 71
 358 acc8+ constant 0
 359 acc8Comp variable 6
 360 brgt 369
 361 br 364
 362 decr8 variable 6
 363 br 357
 364 acc8= variable 6
 365 call writeAcc8
 366 br 362
 367 ;test11.j(139)   // byte - integer
 368 ;test11.j(140)   for(word i = 70; 69+0 <= i; i--) { write(i); }
 369 acc8= constant 70
 370 acc8=> variable 6
 371 acc8= constant 69
 372 acc8+ constant 0
 373 acc16= variable 6
 374 acc8CompareAcc16
 375 brgt 384
 376 br 379
 377 decr16 variable 6
 378 br 371
 379 acc16= variable 6
 380 call writeAcc16
 381 br 377
 382 ;test11.j(141)   // integer - byte
 383 ;test11.j(142)   i2=67;
 384 acc8= constant 67
 385 acc8=> variable 1
 386 ;test11.j(143)   for (byte b = 68; i2+0 <= b; b--) { write (b); }
 387 acc8= constant 68
 388 acc8=> variable 6
 389 acc16= variable 1
 390 acc16+ constant 0
 391 acc8= variable 6
 392 acc16CompareAcc8
 393 brgt 402
 394 br 397
 395 decr8 variable 6
 396 br 389
 397 acc8= variable 6
 398 call writeAcc8
 399 br 395
 400 ;test11.j(144)   // integer - integer
 401 ;test11.j(145)   b2 = 66;
 402 acc8= constant 66
 403 acc8=> variable 5
 404 ;test11.j(146)   for(word i = 1066; 1000+65 <= i; i--) { write (b2); b2--; }
 405 acc16= constant 1066
 406 acc16=> variable 6
 407 acc16= constant 1000
 408 acc16+ constant 65
 409 acc16Comp variable 6
 410 brgt 423
 411 br 414
 412 decr16 variable 6
 413 br 407
 414 acc8= variable 5
 415 call writeAcc8
 416 decr8 variable 5
 417 br 412
 418 ;test11.j(147) 
 419 ;test11.j(148)   /************************/
 420 ;test11.j(149)   // acc - acc
 421 ;test11.j(150)   // byte - byte
 422 ;test11.j(151)   for (byte b = 64; 63+0 <= b+0; b--) { write (b); }
 423 acc8= constant 64
 424 acc8=> variable 6
 425 acc8= constant 63
 426 acc8+ constant 0
 427 <acc8
 428 acc8= variable 6
 429 acc8+ constant 0
 430 revAcc8Comp unstack8
 431 brlt 440
 432 br 435
 433 decr8 variable 6
 434 br 425
 435 acc8= variable 6
 436 call writeAcc8
 437 br 433
 438 ;test11.j(152)   // byte - integer
 439 ;test11.j(153)   for(word i = 62; 61+0 <= i+0; i--) { write(i); }
 440 acc8= constant 62
 441 acc8=> variable 6
 442 acc8= constant 61
 443 acc8+ constant 0
 444 <acc8
 445 acc16= variable 6
 446 acc16+ constant 0
 447 acc8= unstack8
 448 acc8CompareAcc16
 449 brgt 458
 450 br 453
 451 decr16 variable 6
 452 br 442
 453 acc16= variable 6
 454 call writeAcc16
 455 br 451
 456 ;test11.j(154)   // integer - byte
 457 ;test11.j(155)   i2=59;
 458 acc8= constant 59
 459 acc8=> variable 1
 460 ;test11.j(156)   for (byte b = 60; i2+0 <= b+0; b--) { write (b); }
 461 acc8= constant 60
 462 acc8=> variable 6
 463 acc16= variable 1
 464 acc16+ constant 0
 465 <acc16
 466 acc8= variable 6
 467 acc8+ constant 0
 468 acc16= unstack16
 469 acc16CompareAcc8
 470 brgt 479
 471 br 474
 472 decr8 variable 6
 473 br 463
 474 acc8= variable 6
 475 call writeAcc8
 476 br 472
 477 ;test11.j(157)   // integer - integer
 478 ;test11.j(158)   b2=58;
 479 acc8= constant 58
 480 acc8=> variable 5
 481 ;test11.j(159)   for(word i = 1058; 1000+57 <= i+0; i--) { write(b2); b2--; }
 482 acc16= constant 1058
 483 acc16=> variable 6
 484 acc16= constant 1000
 485 acc16+ constant 57
 486 <acc16
 487 acc16= variable 6
 488 acc16+ constant 0
 489 revAcc16Comp unstack16
 490 brlt 503
 491 br 494
 492 decr16 variable 6
 493 br 484
 494 acc8= variable 5
 495 call writeAcc8
 496 decr8 variable 5
 497 br 492
 498 ;test11.j(160) 
 499 ;test11.j(161)   /************************/
 500 ;test11.j(162)   // acc - constant
 501 ;test11.j(163)   // byte - byte
 502 ;test11.j(164)   i2=56;
 503 acc8= constant 56
 504 acc8=> variable 1
 505 ;test11.j(165)   for (byte b = 56; b+0 <= 57; b++) { write (i2); i2--; }
 506 acc8= constant 56
 507 acc8=> variable 6
 508 acc8= variable 6
 509 acc8+ constant 0
 510 acc8Comp constant 57
 511 brgt 523
 512 br 515
 513 incr8 variable 6
 514 br 508
 515 acc16= variable 1
 516 call writeAcc16
 517 decr16 variable 1
 518 br 513
 519 ;test11.j(166)   // byte - integer
 520 ;test11.j(167)   //not relevant
 521 ;test11.j(168)   // integer - byte
 522 ;test11.j(169)   b2=54;
 523 acc8= constant 54
 524 acc8=> variable 5
 525 ;test11.j(170)   for (word i = 54; i+0 <= 55; i++) { write (b2); b2--;}
 526 acc8= constant 54
 527 acc8=> variable 6
 528 acc16= variable 6
 529 acc16+ constant 0
 530 acc8= constant 55
 531 acc16CompareAcc8
 532 brgt 542
 533 br 536
 534 incr16 variable 6
 535 br 528
 536 acc8= variable 5
 537 call writeAcc8
 538 decr8 variable 5
 539 br 534
 540 ;test11.j(171)   // integer - integer
 541 ;test11.j(172)   b2=52;
 542 acc8= constant 52
 543 acc8=> variable 5
 544 ;test11.j(173)   for(word i = 1052; i+0 <= 1053; i++) { write(b2); b2--; }
 545 acc16= constant 1052
 546 acc16=> variable 6
 547 acc16= variable 6
 548 acc16+ constant 0
 549 acc16Comp constant 1053
 550 brgt 564
 551 br 554
 552 incr16 variable 6
 553 br 547
 554 acc8= variable 5
 555 call writeAcc8
 556 decr8 variable 5
 557 br 552
 558 ;test11.j(174) 
 559 ;test11.j(175)   /************************/
 560 ;test11.j(176)   // constant - stack8
 561 ;test11.j(177)   // byte - byte
 562 ;test11.j(178)   //TODO
 563 ;test11.j(179)   write(50);
 564 acc8= constant 50
 565 call writeAcc8
 566 ;test11.j(180)   // constant - stack8
 567 ;test11.j(181)   // byte - integer
 568 ;test11.j(182)   //TODO
 569 ;test11.j(183)   write(49);
 570 acc8= constant 49
 571 call writeAcc8
 572 ;test11.j(184)   // constant - stack8
 573 ;test11.j(185)   // integer - byte
 574 ;test11.j(186)   //TODO
 575 ;test11.j(187)   write(48);
 576 acc8= constant 48
 577 call writeAcc8
 578 ;test11.j(188)   // constant - stack88
 579 ;test11.j(189)   // integer - integer
 580 ;test11.j(190)   //TODO
 581 ;test11.j(191)   write(47);
 582 acc8= constant 47
 583 call writeAcc8
 584 ;test11.j(192) 
 585 ;test11.j(193)   /************************/
 586 ;test11.j(194)   // constant - stack16
 587 ;test11.j(195)   // byte - byte
 588 ;test11.j(196)   //TODO
 589 ;test11.j(197)   write(46);
 590 acc8= constant 46
 591 call writeAcc8
 592 ;test11.j(198)   // constant - stack16
 593 ;test11.j(199)   // byte - integer
 594 ;test11.j(200)   //TODO
 595 ;test11.j(201)   write(45);
 596 acc8= constant 45
 597 call writeAcc8
 598 ;test11.j(202)   // constant - stack16
 599 ;test11.j(203)   // integer - byte
 600 ;test11.j(204)   //TODO
 601 ;test11.j(205)   write(44);
 602 acc8= constant 44
 603 call writeAcc8
 604 ;test11.j(206)   // constant - stack16
 605 ;test11.j(207)   // integer - integer
 606 ;test11.j(208)   //TODO
 607 ;test11.j(209)   write(43);
 608 acc8= constant 43
 609 call writeAcc8
 610 ;test11.j(210) 
 611 ;test11.j(211)   /************************/
 612 ;test11.j(212)   // constant - var
 613 ;test11.j(213)   // byte - byte
 614 ;test11.j(214)   for (byte b = 42; 41 <= b; b--) { write (b); }
 615 acc8= constant 42
 616 acc8=> variable 6
 617 acc8= variable 6
 618 acc8Comp constant 41
 619 brlt 629
 620 br 623
 621 decr8 variable 6
 622 br 617
 623 acc8= variable 6
 624 call writeAcc8
 625 br 621
 626 ;test11.j(215)   // constant - var
 627 ;test11.j(216)   // byte - integer
 628 ;test11.j(217)   for(word i = 40; 39 <= i; i--) { write(i); }
 629 acc8= constant 40
 630 acc8=> variable 6
 631 acc16= variable 6
 632 acc8= constant 39
 633 acc8CompareAcc16
 634 brgt 647
 635 br 638
 636 decr16 variable 6
 637 br 631
 638 acc16= variable 6
 639 call writeAcc16
 640 br 636
 641 ;test11.j(218)   // constant - var
 642 ;test11.j(219)   // integer - byte
 643 ;test11.j(220)   // not relevant
 644 ;test11.j(221)   // constant - var
 645 ;test11.j(222)   // integer - integer
 646 ;test11.j(223)   b2=38;
 647 acc8= constant 38
 648 acc8=> variable 5
 649 ;test11.j(224)   for(word i = 1038; 1037 <= i; i--) { write(b2); b2--; }
 650 acc16= constant 1038
 651 acc16=> variable 6
 652 acc16= variable 6
 653 acc16Comp constant 1037
 654 brlt 667
 655 br 658
 656 decr16 variable 6
 657 br 652
 658 acc8= variable 5
 659 call writeAcc8
 660 decr8 variable 5
 661 br 656
 662 ;test11.j(225) 
 663 ;test11.j(226)   /************************/
 664 ;test11.j(227)   // constant - acc
 665 ;test11.j(228)   // byte - byte
 666 ;test11.j(229)   for (byte b = 36; 136 == b+100; b--) { write (b); }
 667 acc8= constant 36
 668 acc8=> variable 6
 669 acc8= variable 6
 670 acc8+ constant 100
 671 acc8Comp constant 136
 672 brne 680
 673 br 676
 674 decr8 variable 6
 675 br 669
 676 acc8= variable 6
 677 call writeAcc8
 678 br 674
 679 ;test11.j(230)   for (byte b = 35; 132 != b+100; b--) { write (b); }
 680 acc8= constant 35
 681 acc8=> variable 6
 682 acc8= variable 6
 683 acc8+ constant 100
 684 acc8Comp constant 132
 685 breq 693
 686 br 689
 687 decr8 variable 6
 688 br 682
 689 acc8= variable 6
 690 call writeAcc8
 691 br 687
 692 ;test11.j(231)   b2=32;
 693 acc8= constant 32
 694 acc8=> variable 5
 695 ;test11.j(232)   for (byte b = 32; 134 > b+100; b++) { write (b2); b2--; }
 696 acc8= constant 32
 697 acc8=> variable 6
 698 acc8= variable 6
 699 acc8+ constant 100
 700 acc8Comp constant 134
 701 brge 710
 702 br 705
 703 incr8 variable 6
 704 br 698
 705 acc8= variable 5
 706 call writeAcc8
 707 decr8 variable 5
 708 br 703
 709 ;test11.j(233)   for (byte b = 34; 135 >= b+100; b++) { write (b2); b2--; }
 710 acc8= constant 34
 711 acc8=> variable 6
 712 acc8= variable 6
 713 acc8+ constant 100
 714 acc8Comp constant 135
 715 brgt 724
 716 br 719
 717 incr8 variable 6
 718 br 712
 719 acc8= variable 5
 720 call writeAcc8
 721 decr8 variable 5
 722 br 717
 723 ;test11.j(234)   for (byte b = 28; 126 <  b+100; b--) { write (b); }
 724 acc8= constant 28
 725 acc8=> variable 6
 726 acc8= variable 6
 727 acc8+ constant 100
 728 acc8Comp constant 126
 729 brle 737
 730 br 733
 731 decr8 variable 6
 732 br 726
 733 acc8= variable 6
 734 call writeAcc8
 735 br 731
 736 ;test11.j(235)   for (byte b = 26; 125 <= b+100; b--) { write (b); }
 737 acc8= constant 26
 738 acc8=> variable 6
 739 acc8= variable 6
 740 acc8+ constant 100
 741 acc8Comp constant 125
 742 brlt 752
 743 br 746
 744 decr8 variable 6
 745 br 739
 746 acc8= variable 6
 747 call writeAcc8
 748 br 744
 749 ;test11.j(236)   // constant - acc
 750 ;test11.j(237)   // byte - integer
 751 ;test11.j(238)   for(word i = 24; 24 == i+0; i--) { write(i); }
 752 acc8= constant 24
 753 acc8=> variable 6
 754 acc16= variable 6
 755 acc16+ constant 0
 756 acc8= constant 24
 757 acc8CompareAcc16
 758 brne 766
 759 br 762
 760 decr16 variable 6
 761 br 754
 762 acc16= variable 6
 763 call writeAcc16
 764 br 760
 765 ;test11.j(239)   for(word i = 23; 120 != i+100; i--) { write(i); }
 766 acc8= constant 23
 767 acc8=> variable 6
 768 acc16= variable 6
 769 acc16+ constant 100
 770 acc8= constant 120
 771 acc8CompareAcc16
 772 breq 780
 773 br 776
 774 decr16 variable 6
 775 br 768
 776 acc16= variable 6
 777 call writeAcc16
 778 br 774
 779 ;test11.j(240)   b2=20;
 780 acc8= constant 20
 781 acc8=> variable 5
 782 ;test11.j(241)   for(word i = 20; 122 > i+100; i++) { write (b2); b2--; }
 783 acc8= constant 20
 784 acc8=> variable 6
 785 acc16= variable 6
 786 acc16+ constant 100
 787 acc8= constant 122
 788 acc8CompareAcc16
 789 brle 798
 790 br 793
 791 incr16 variable 6
 792 br 785
 793 acc8= variable 5
 794 call writeAcc8
 795 decr8 variable 5
 796 br 791
 797 ;test11.j(242)   for(word i = 22; 123 >= i+100; i++) { write (b2); b2--; }
 798 acc8= constant 22
 799 acc8=> variable 6
 800 acc16= variable 6
 801 acc16+ constant 100
 802 acc8= constant 123
 803 acc8CompareAcc16
 804 brlt 813
 805 br 808
 806 incr16 variable 6
 807 br 800
 808 acc8= variable 5
 809 call writeAcc8
 810 decr8 variable 5
 811 br 806
 812 ;test11.j(243)   for(word i = 16; 114 <  i+100; i--) { write(i); }
 813 acc8= constant 16
 814 acc8=> variable 6
 815 acc16= variable 6
 816 acc16+ constant 100
 817 acc8= constant 114
 818 acc8CompareAcc16
 819 brge 827
 820 br 823
 821 decr16 variable 6
 822 br 815
 823 acc16= variable 6
 824 call writeAcc16
 825 br 821
 826 ;test11.j(244)   for(word i = 14; 113 <= i+100; i--) { write(i); }
 827 acc8= constant 14
 828 acc8=> variable 6
 829 acc16= variable 6
 830 acc16+ constant 100
 831 acc8= constant 113
 832 acc8CompareAcc16
 833 brgt 847
 834 br 837
 835 decr16 variable 6
 836 br 829
 837 acc16= variable 6
 838 call writeAcc16
 839 br 835
 840 ;test11.j(245)   // constant - acc
 841 ;test11.j(246)   // integer - byte
 842 ;test11.j(247)   // not relevant
 843 ;test11.j(248) 
 844 ;test11.j(249)   // constant - acc
 845 ;test11.j(250)   // integer - integer
 846 ;test11.j(251)   for(word i = 12; 1012 == i+1000; i--) { write(i); }
 847 acc8= constant 12
 848 acc8=> variable 6
 849 acc16= variable 6
 850 acc16+ constant 1000
 851 acc16Comp constant 1012
 852 brne 860
 853 br 856
 854 decr16 variable 6
 855 br 849
 856 acc16= variable 6
 857 call writeAcc16
 858 br 854
 859 ;test11.j(252)   for(word i = 11; 1008 != i+1000; i--) { write(i); }
 860 acc8= constant 11
 861 acc8=> variable 6
 862 acc16= variable 6
 863 acc16+ constant 1000
 864 acc16Comp constant 1008
 865 breq 873
 866 br 869
 867 decr16 variable 6
 868 br 862
 869 acc16= variable 6
 870 call writeAcc16
 871 br 867
 872 ;test11.j(253)   b2=8;
 873 acc8= constant 8
 874 acc8=> variable 5
 875 ;test11.j(254)   for(word i = 8; 1010 > i+1000; i++) { write (b2); b2--; }
 876 acc8= constant 8
 877 acc8=> variable 6
 878 acc16= variable 6
 879 acc16+ constant 1000
 880 acc16Comp constant 1010
 881 brge 890
 882 br 885
 883 incr16 variable 6
 884 br 878
 885 acc8= variable 5
 886 call writeAcc8
 887 decr8 variable 5
 888 br 883
 889 ;test11.j(255)   for(word i = 10; 1011 >= i+1000; i++) { write (b2); b2--; }
 890 acc8= constant 10
 891 acc8=> variable 6
 892 acc16= variable 6
 893 acc16+ constant 1000
 894 acc16Comp constant 1011
 895 brgt 904
 896 br 899
 897 incr16 variable 6
 898 br 892
 899 acc8= variable 5
 900 call writeAcc8
 901 decr8 variable 5
 902 br 897
 903 ;test11.j(256)   for(word i = 4; 1002 <  i+1000; i--) { write(i); }
 904 acc8= constant 4
 905 acc8=> variable 6
 906 acc16= variable 6
 907 acc16+ constant 1000
 908 acc16Comp constant 1002
 909 brle 917
 910 br 913
 911 decr16 variable 6
 912 br 906
 913 acc16= variable 6
 914 call writeAcc16
 915 br 911
 916 ;test11.j(257)   for(word i = 2; 1001 <= i+1000; i--) { write(i); }
 917 acc8= constant 2
 918 acc8=> variable 6
 919 acc16= variable 6
 920 acc16+ constant 1000
 921 acc16Comp constant 1001
 922 brlt 930
 923 br 926
 924 decr16 variable 6
 925 br 919
 926 acc16= variable 6
 927 call writeAcc16
 928 br 924
 929 ;test11.j(258)   write(0);
 930 acc8= constant 0
 931 call writeAcc8
 932 ;test11.j(259) }
 933 stop
