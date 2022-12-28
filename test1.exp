   0 ;test1.j(0) /* Program to test generated Z80 assembler code */
   1 ;test1.j(1) class TestWhile {
   2 ;test1.j(2)   byte b = 115;
   3 acc8= constant 115
   4 acc8=> variable 0
   5 ;test1.j(3)   
   6 ;test1.j(4)   /************************/
   7 ;test1.j(5)   // global variable within while scope
   8 ;test1.j(6)   write (b);
   9 acc8= variable 0
  10 call writeAcc8
  11 ;test1.j(7)   b--;
  12 decr8 variable 0
  13 ;test1.j(8)   while (b>112) {
  14 acc8= variable 0
  15 acc8Comp constant 112
  16 brle 35
  17 ;test1.j(9)     word j = 1001;
  18 acc16= constant 1001
  19 acc16=> variable 1
  20 ;test1.j(10)     byte c = b;
  21 acc8= variable 0
  22 acc8=> variable 3
  23 ;test1.j(11)     byte d = c;
  24 acc8= variable 3
  25 acc8=> variable 4
  26 ;test1.j(12)     b--;
  27 decr8 variable 0
  28 ;test1.j(13)     write (c);
  29 acc8= variable 3
  30 call writeAcc8
  31 ;test1.j(14)   }
  32 br 14
  33 ;test1.j(15) 
  34 ;test1.j(16)   word i = 110;
  35 acc8= constant 110
  36 acc8=> variable 1
  37 ;test1.j(17)   word i2 = 105;
  38 acc8= constant 105
  39 acc8=> variable 3
  40 ;test1.j(18)   word p = 12;
  41 acc8= constant 12
  42 acc8=> variable 5
  43 ;test1.j(19)   byte b2 = 111;
  44 acc8= constant 111
  45 acc8=> variable 7
  46 ;test1.j(20) 
  47 ;test1.j(21)   /************************/
  48 ;test1.j(22)   // stack8 - constant
  49 ;test1.j(23)   // stack8 - acc
  50 ;test1.j(24)   // stack8 - var
  51 ;test1.j(25)   // stack8 - stack8
  52 ;test1.j(26)   // stack8 - stack16
  53 ;test1.j(27)   //TODO
  54 ;test1.j(28) 
  55 ;test1.j(29)   /************************/
  56 ;test1.j(30)   // stack16 - constant
  57 ;test1.j(31)   // stack16 - acc
  58 ;test1.j(32)   // stack16 - var
  59 ;test1.j(33)   // stack16 - stack8
  60 ;test1.j(34)   // stack16 - stack16
  61 ;test1.j(35)   //TODO
  62 ;test1.j(36) 
  63 ;test1.j(37)   /************************/
  64 ;test1.j(38)   // var - stack16
  65 ;test1.j(39)   // byte - byte
  66 ;test1.j(40)   // byte - integer
  67 ;test1.j(41)   // integer - byte
  68 ;test1.j(42)   // integer - integer
  69 ;test1.j(43)   //TODO
  70 ;test1.j(44) 
  71 ;test1.j(45)   /************************/
  72 ;test1.j(46)   // var - stack8
  73 ;test1.j(47)   // byte - byte
  74 ;test1.j(48)   // byte - integer
  75 ;test1.j(49)   // integer - byte
  76 ;test1.j(50)   // integer - integer
  77 ;test1.j(51)   //TODO
  78 ;test1.j(52) 
  79 ;test1.j(53)   /************************/
  80 ;test1.j(54)   // var - var
  81 ;test1.j(55)   // byte - byte
  82 ;test1.j(56)   while (b2 <= b) { write (b); b--; }
  83 acc8= variable 7
  84 acc8Comp variable 0
  85 brgt 92
  86 acc8= variable 0
  87 call writeAcc8
  88 decr8 variable 0
  89 br 83
  90 ;test1.j(57)   // byte - integer
  91 ;test1.j(58)   b2 = 109;
  92 acc8= constant 109
  93 acc8=> variable 7
  94 ;test1.j(59)   while (b2 <= i) { write (i); i--; }
  95 acc8= variable 7
  96 acc16= variable 1
  97 acc8CompareAcc16
  98 brgt 105
  99 acc16= variable 1
 100 call writeAcc16
 101 decr16 variable 1
 102 br 95
 103 ;test1.j(60)   // integer - byte
 104 ;test1.j(61)   b=108;
 105 acc8= constant 108
 106 acc8=> variable 0
 107 ;test1.j(62)   i=107;
 108 acc8= constant 107
 109 acc8=> variable 1
 110 ;test1.j(63)   while (i <= b) { write (b); b--; }
 111 acc16= variable 1
 112 acc8= variable 0
 113 acc16CompareAcc8
 114 brgt 121
 115 acc8= variable 0
 116 call writeAcc8
 117 decr8 variable 0
 118 br 111
 119 ;test1.j(64)   // integer - integer
 120 ;test1.j(65)   i=106;
 121 acc8= constant 106
 122 acc8=> variable 1
 123 ;test1.j(66)   while (i2 <= i) { write (i); i--; }
 124 acc16= variable 3
 125 acc16Comp variable 1
 126 brgt 136
 127 acc16= variable 1
 128 call writeAcc16
 129 decr16 variable 1
 130 br 124
 131 ;test1.j(67) 
 132 ;test1.j(68)   /************************/
 133 ;test1.j(69)   // var - acc
 134 ;test1.j(70)   // byte - byte
 135 ;test1.j(71)   i=104;
 136 acc8= constant 104
 137 acc8=> variable 1
 138 ;test1.j(72)   b=104;
 139 acc8= constant 104
 140 acc8=> variable 0
 141 ;test1.j(73)   while (b <= 105+0) { write (i); i--; b++; }
 142 acc8= constant 105
 143 acc8+ constant 0
 144 acc8Comp variable 0
 145 brlt 153
 146 acc16= variable 1
 147 call writeAcc16
 148 decr16 variable 1
 149 incr8 variable 0
 150 br 142
 151 ;test1.j(74)   // byte - integer
 152 ;test1.j(75)   i=103;
 153 acc8= constant 103
 154 acc8=> variable 1
 155 ;test1.j(76)   b=102;
 156 acc8= constant 102
 157 acc8=> variable 0
 158 ;test1.j(77)   while (b <= i+0) { write (b); b--; i=i-2; }
 159 acc16= variable 1
 160 acc16+ constant 0
 161 acc8= variable 0
 162 acc8CompareAcc16
 163 brgt 173
 164 acc8= variable 0
 165 call writeAcc8
 166 decr8 variable 0
 167 acc16= variable 1
 168 acc16- constant 2
 169 acc16=> variable 1
 170 br 159
 171 ;test1.j(78)   // integer - byte
 172 ;test1.j(79)   i=100;
 173 acc8= constant 100
 174 acc8=> variable 1
 175 ;test1.j(80)   while (i <= 101+0) { write (b); b--; i++; }
 176 acc8= constant 101
 177 acc8+ constant 0
 178 acc16= variable 1
 179 acc16CompareAcc8
 180 brgt 188
 181 acc8= variable 0
 182 call writeAcc8
 183 decr8 variable 0
 184 incr16 variable 1
 185 br 176
 186 ;test1.j(81)   // integer - integer
 187 ;test1.j(82)   i=1098;
 188 acc16= constant 1098
 189 acc16=> variable 1
 190 ;test1.j(83)   while (i <= 1099+0) { write (b); b--; i++; }
 191 acc16= constant 1099
 192 acc16+ constant 0
 193 acc16Comp variable 1
 194 brlt 205
 195 acc8= variable 0
 196 call writeAcc8
 197 decr8 variable 0
 198 incr16 variable 1
 199 br 191
 200 ;test1.j(84) 
 201 ;test1.j(85)   /************************/
 202 ;test1.j(86)   // var - constant
 203 ;test1.j(87)   // byte - byte
 204 ;test1.j(88)   i=96;
 205 acc8= constant 96
 206 acc8=> variable 1
 207 ;test1.j(89)   b=96;
 208 acc8= constant 96
 209 acc8=> variable 0
 210 ;test1.j(90)   while (b <= 97) { write (i); i--; b++; }
 211 acc8= variable 0
 212 acc8Comp constant 97
 213 brgt 222
 214 acc16= variable 1
 215 call writeAcc16
 216 decr16 variable 1
 217 incr8 variable 0
 218 br 211
 219 ;test1.j(91)   // byte - integer
 220 ;test1.j(92)   //not relevant
 221 ;test1.j(93)   write(94);
 222 acc8= constant 94
 223 call writeAcc8
 224 ;test1.j(94)   write(93);
 225 acc8= constant 93
 226 call writeAcc8
 227 ;test1.j(95)   // integer - byte
 228 ;test1.j(96)   i=92;
 229 acc8= constant 92
 230 acc8=> variable 1
 231 ;test1.j(97)   b=92;
 232 acc8= constant 92
 233 acc8=> variable 0
 234 ;test1.j(98)   while (i <= 93) { write (b); b--; i++; }
 235 acc16= variable 1
 236 acc8= constant 93
 237 acc16CompareAcc8
 238 brgt 246
 239 acc8= variable 0
 240 call writeAcc8
 241 decr8 variable 0
 242 incr16 variable 1
 243 br 235
 244 ;test1.j(99)   // integer - integer
 245 ;test1.j(100)   i=1090;
 246 acc16= constant 1090
 247 acc16=> variable 1
 248 ;test1.j(101)   while (i <= 1091) { write (b); b--; i++; }
 249 acc16= variable 1
 250 acc16Comp constant 1091
 251 brgt 263
 252 acc8= variable 0
 253 call writeAcc8
 254 decr8 variable 0
 255 incr16 variable 1
 256 br 249
 257 ;test1.j(102) 
 258 ;test1.j(103)   /************************/
 259 ;test1.j(104)   // acc - stack8
 260 ;test1.j(105)   // byte - byte
 261 ;test1.j(106)   //TODO
 262 ;test1.j(107)   write(88);
 263 acc8= constant 88
 264 call writeAcc8
 265 ;test1.j(108)   write(87);
 266 acc8= constant 87
 267 call writeAcc8
 268 ;test1.j(109)   // byte - integer
 269 ;test1.j(110)   //TODO
 270 ;test1.j(111)   write(86);
 271 acc8= constant 86
 272 call writeAcc8
 273 ;test1.j(112)   write(85);
 274 acc8= constant 85
 275 call writeAcc8
 276 ;test1.j(113)   // integer - byte
 277 ;test1.j(114)   //TODO
 278 ;test1.j(115)   write(84);
 279 acc8= constant 84
 280 call writeAcc8
 281 ;test1.j(116)   write(83);
 282 acc8= constant 83
 283 call writeAcc8
 284 ;test1.j(117)   // integer - integer
 285 ;test1.j(118)   //TODO
 286 ;test1.j(119)   write(82);
 287 acc8= constant 82
 288 call writeAcc8
 289 ;test1.j(120)   write(81);
 290 acc8= constant 81
 291 call writeAcc8
 292 ;test1.j(121) 
 293 ;test1.j(122)   /************************/
 294 ;test1.j(123)   // acc - stack16
 295 ;test1.j(124)   // byte - byte
 296 ;test1.j(125)   //TODO
 297 ;test1.j(126)   write(80);
 298 acc8= constant 80
 299 call writeAcc8
 300 ;test1.j(127)   write(79);
 301 acc8= constant 79
 302 call writeAcc8
 303 ;test1.j(128)   // byte - integer
 304 ;test1.j(129)   //TODO
 305 ;test1.j(130)   write(78);
 306 acc8= constant 78
 307 call writeAcc8
 308 ;test1.j(131)   write(77);
 309 acc8= constant 77
 310 call writeAcc8
 311 ;test1.j(132)   // integer - byte
 312 ;test1.j(133)   //TODO
 313 ;test1.j(134)   write(76);
 314 acc8= constant 76
 315 call writeAcc8
 316 ;test1.j(135)   write(75);
 317 acc8= constant 75
 318 call writeAcc8
 319 ;test1.j(136)   // integer - integer
 320 ;test1.j(137)   //TODO
 321 ;test1.j(138)   write(74);
 322 acc8= constant 74
 323 call writeAcc8
 324 ;test1.j(139)   write(73);
 325 acc8= constant 73
 326 call writeAcc8
 327 ;test1.j(140) 
 328 ;test1.j(141)   /************************/
 329 ;test1.j(142)   // acc - var
 330 ;test1.j(143)   // byte - byte
 331 ;test1.j(144)   b=72;
 332 acc8= constant 72
 333 acc8=> variable 0
 334 ;test1.j(145)   while (71+0 <= b) { write (b); b--; }
 335 acc8= constant 71
 336 acc8+ constant 0
 337 acc8Comp variable 0
 338 brgt 345
 339 acc8= variable 0
 340 call writeAcc8
 341 decr8 variable 0
 342 br 335
 343 ;test1.j(146)   // byte - integer
 344 ;test1.j(147)   i=70;
 345 acc8= constant 70
 346 acc8=> variable 1
 347 ;test1.j(148)   while (69+0 <= i) { write (i); i--; }
 348 acc8= constant 69
 349 acc8+ constant 0
 350 acc16= variable 1
 351 acc8CompareAcc16
 352 brgt 359
 353 acc16= variable 1
 354 call writeAcc16
 355 decr16 variable 1
 356 br 348
 357 ;test1.j(149)   // integer - byte
 358 ;test1.j(150)   i=67;
 359 acc8= constant 67
 360 acc8=> variable 1
 361 ;test1.j(151)   b=68;
 362 acc8= constant 68
 363 acc8=> variable 0
 364 ;test1.j(152)   while (i+0 <= b) { write (b); b--; } 
 365 acc16= variable 1
 366 acc16+ constant 0
 367 acc8= variable 0
 368 acc16CompareAcc8
 369 brgt 376
 370 acc8= variable 0
 371 call writeAcc8
 372 decr8 variable 0
 373 br 365
 374 ;test1.j(153)   // integer - integer
 375 ;test1.j(154)   i=1066;
 376 acc16= constant 1066
 377 acc16=> variable 1
 378 ;test1.j(155)   while (1000+65 <= i) { write (b); b--; i--; }
 379 acc16= constant 1000
 380 acc16+ constant 65
 381 acc16Comp variable 1
 382 brgt 393
 383 acc8= variable 0
 384 call writeAcc8
 385 decr8 variable 0
 386 decr16 variable 1
 387 br 379
 388 ;test1.j(156) 
 389 ;test1.j(157)   /************************/
 390 ;test1.j(158)   // acc - acc
 391 ;test1.j(159)   // byte - byte
 392 ;test1.j(160)   b=64;
 393 acc8= constant 64
 394 acc8=> variable 0
 395 ;test1.j(161)   while (63+0 <= b+0) { write (b); b--; }
 396 acc8= constant 63
 397 acc8+ constant 0
 398 <acc8
 399 acc8= variable 0
 400 acc8+ constant 0
 401 revAcc8Comp unstack8
 402 brlt 409
 403 acc8= variable 0
 404 call writeAcc8
 405 decr8 variable 0
 406 br 396
 407 ;test1.j(162)   // byte - integer
 408 ;test1.j(163)   i=62;
 409 acc8= constant 62
 410 acc8=> variable 1
 411 ;test1.j(164)   while (61+0 <= i+0) { write (i); i--; }
 412 acc8= constant 61
 413 acc8+ constant 0
 414 <acc8
 415 acc16= variable 1
 416 acc16+ constant 0
 417 acc8= unstack8
 418 acc8CompareAcc16
 419 brgt 426
 420 acc16= variable 1
 421 call writeAcc16
 422 decr16 variable 1
 423 br 412
 424 ;test1.j(165)   // integer - byte
 425 ;test1.j(166)   i=59;
 426 acc8= constant 59
 427 acc8=> variable 1
 428 ;test1.j(167)   b=60;
 429 acc8= constant 60
 430 acc8=> variable 0
 431 ;test1.j(168)   while (i+0 <= b+0) { write (b); b--; }
 432 acc16= variable 1
 433 acc16+ constant 0
 434 <acc16
 435 acc8= variable 0
 436 acc8+ constant 0
 437 acc16= unstack16
 438 acc16CompareAcc8
 439 brgt 446
 440 acc8= variable 0
 441 call writeAcc8
 442 decr8 variable 0
 443 br 432
 444 ;test1.j(169)   // integer - integer
 445 ;test1.j(170)   i=1058;
 446 acc16= constant 1058
 447 acc16=> variable 1
 448 ;test1.j(171)   while (1000+57 <= i+0) { write (b); b--; i--; }
 449 acc16= constant 1000
 450 acc16+ constant 57
 451 <acc16
 452 acc16= variable 1
 453 acc16+ constant 0
 454 revAcc16Comp unstack16
 455 brlt 466
 456 acc8= variable 0
 457 call writeAcc8
 458 decr8 variable 0
 459 decr16 variable 1
 460 br 449
 461 ;test1.j(172) 
 462 ;test1.j(173)   /************************/
 463 ;test1.j(174)   // acc - constant
 464 ;test1.j(175)   // byte - byte
 465 ;test1.j(176)   i=56;
 466 acc8= constant 56
 467 acc8=> variable 1
 468 ;test1.j(177)   b=56;
 469 acc8= constant 56
 470 acc8=> variable 0
 471 ;test1.j(178)   while (b+0 <= 57) { write (i); i--; b++; }
 472 acc8= variable 0
 473 acc8+ constant 0
 474 acc8Comp constant 57
 475 brgt 485
 476 acc16= variable 1
 477 call writeAcc16
 478 decr16 variable 1
 479 incr8 variable 0
 480 br 472
 481 ;test1.j(179)   // byte - integer
 482 ;test1.j(180)   //not relevant
 483 ;test1.j(181)   // integer - byte
 484 ;test1.j(182)   i=54;
 485 acc8= constant 54
 486 acc8=> variable 1
 487 ;test1.j(183)   b=54;
 488 acc8= constant 54
 489 acc8=> variable 0
 490 ;test1.j(184)   while (i+0 <= 55) { write (b); b--; i++; }
 491 acc16= variable 1
 492 acc16+ constant 0
 493 acc8= constant 55
 494 acc16CompareAcc8
 495 brgt 502
 496 acc8= variable 0
 497 call writeAcc8
 498 decr8 variable 0
 499 incr16 variable 1
 500 br 491
 501 ;test1.j(185)   i=1052;
 502 acc16= constant 1052
 503 acc16=> variable 1
 504 ;test1.j(186)   // integer - integer
 505 ;test1.j(187)   while (i+0 <= 1053) { write (b); b--; i++; }
 506 acc16= variable 1
 507 acc16+ constant 0
 508 acc16Comp constant 1053
 509 brgt 521
 510 acc8= variable 0
 511 call writeAcc8
 512 decr8 variable 0
 513 incr16 variable 1
 514 br 506
 515 ;test1.j(188) 
 516 ;test1.j(189)   /************************/
 517 ;test1.j(190)   // constant - stack8
 518 ;test1.j(191)   // byte - byte
 519 ;test1.j(192)   //TODO
 520 ;test1.j(193)   write(50);
 521 acc8= constant 50
 522 call writeAcc8
 523 ;test1.j(194)   // constant - stack8
 524 ;test1.j(195)   // byte - integer
 525 ;test1.j(196)   //TODO
 526 ;test1.j(197)   write(49);
 527 acc8= constant 49
 528 call writeAcc8
 529 ;test1.j(198)   // constant - stack8
 530 ;test1.j(199)   // integer - byte
 531 ;test1.j(200)   //TODO
 532 ;test1.j(201)   write(48);
 533 acc8= constant 48
 534 call writeAcc8
 535 ;test1.j(202)   // constant - stack88
 536 ;test1.j(203)   // integer - integer
 537 ;test1.j(204)   //TODO
 538 ;test1.j(205)   write(47);
 539 acc8= constant 47
 540 call writeAcc8
 541 ;test1.j(206) 
 542 ;test1.j(207)   /************************/
 543 ;test1.j(208)   // constant - stack16
 544 ;test1.j(209)   // byte - byte
 545 ;test1.j(210)   //TODO
 546 ;test1.j(211)   write(46);
 547 acc8= constant 46
 548 call writeAcc8
 549 ;test1.j(212)   // constant - stack16
 550 ;test1.j(213)   // byte - integer
 551 ;test1.j(214)   //TODO
 552 ;test1.j(215)   write(45);
 553 acc8= constant 45
 554 call writeAcc8
 555 ;test1.j(216)   // constant - stack16
 556 ;test1.j(217)   // integer - byte
 557 ;test1.j(218)   //TODO
 558 ;test1.j(219)   write(44);
 559 acc8= constant 44
 560 call writeAcc8
 561 ;test1.j(220)   // constant - stack16
 562 ;test1.j(221)   // integer - integer
 563 ;test1.j(222)   //TODO
 564 ;test1.j(223)   write(43);
 565 acc8= constant 43
 566 call writeAcc8
 567 ;test1.j(224) 
 568 ;test1.j(225)   /************************/
 569 ;test1.j(226)   // constant - var
 570 ;test1.j(227)   // byte - byte
 571 ;test1.j(228)   b=42;
 572 acc8= constant 42
 573 acc8=> variable 0
 574 ;test1.j(229)   while (41 <= b) { write (b); b--; }
 575 acc8= variable 0
 576 acc8Comp constant 41
 577 brlt 586
 578 acc8= variable 0
 579 call writeAcc8
 580 decr8 variable 0
 581 br 575
 582 ;test1.j(230) 
 583 ;test1.j(231)   // constant - var
 584 ;test1.j(232)   // byte - integer
 585 ;test1.j(233)   i=40;
 586 acc8= constant 40
 587 acc8=> variable 1
 588 ;test1.j(234)   while (39 <= i) { write (i); i--; }
 589 acc16= variable 1
 590 acc8= constant 39
 591 acc8CompareAcc16
 592 brgt 605
 593 acc16= variable 1
 594 call writeAcc16
 595 decr16 variable 1
 596 br 589
 597 ;test1.j(235) 
 598 ;test1.j(236)   // constant - var
 599 ;test1.j(237)   // integer - byte
 600 ;test1.j(238)   // not relevant
 601 ;test1.j(239) 
 602 ;test1.j(240)   // constant - var
 603 ;test1.j(241)   // integer - integer
 604 ;test1.j(242)   i=1038;
 605 acc16= constant 1038
 606 acc16=> variable 1
 607 ;test1.j(243)   b=38;
 608 acc8= constant 38
 609 acc8=> variable 0
 610 ;test1.j(244)   while (1037 <= i) { write (b); b--; i--; }
 611 acc16= variable 1
 612 acc16Comp constant 1037
 613 brlt 624
 614 acc8= variable 0
 615 call writeAcc8
 616 decr8 variable 0
 617 decr16 variable 1
 618 br 611
 619 ;test1.j(245) 
 620 ;test1.j(246)   /************************/
 621 ;test1.j(247)   // constant - acc
 622 ;test1.j(248)   // byte - byte
 623 ;test1.j(249)   b=36;
 624 acc8= constant 36
 625 acc8=> variable 0
 626 ;test1.j(250)   while (135 == b+100) { write (b); b--; }
 627 acc8= variable 0
 628 acc8+ constant 100
 629 acc8Comp constant 135
 630 brne 636
 631 acc8= variable 0
 632 call writeAcc8
 633 decr8 variable 0
 634 br 627
 635 ;test1.j(251)   while (132 != b+100) { write (b); b--; }
 636 acc8= variable 0
 637 acc8+ constant 100
 638 acc8Comp constant 132
 639 breq 645
 640 acc8= variable 0
 641 call writeAcc8
 642 decr8 variable 0
 643 br 636
 644 ;test1.j(252)   p=32;
 645 acc8= constant 32
 646 acc8=> variable 5
 647 ;test1.j(253)   while (134 > b+100) { write (p); p--; b++; }
 648 acc8= variable 0
 649 acc8+ constant 100
 650 acc8Comp constant 134
 651 brge 658
 652 acc16= variable 5
 653 call writeAcc16
 654 decr16 variable 5
 655 incr8 variable 0
 656 br 648
 657 ;test1.j(254)   while (135 >= b+100) { write (p); p--; b++; }
 658 acc8= variable 0
 659 acc8+ constant 100
 660 acc8Comp constant 135
 661 brgt 668
 662 acc16= variable 5
 663 call writeAcc16
 664 decr16 variable 5
 665 incr8 variable 0
 666 br 658
 667 ;test1.j(255)   b=28;
 668 acc8= constant 28
 669 acc8=> variable 0
 670 ;test1.j(256)   while (126 <  b+100) { write (b); b--; }
 671 acc8= variable 0
 672 acc8+ constant 100
 673 acc8Comp constant 126
 674 brle 680
 675 acc8= variable 0
 676 call writeAcc8
 677 decr8 variable 0
 678 br 671
 679 ;test1.j(257)   while (125 <= b+100) { write (b); b--; }
 680 acc8= variable 0
 681 acc8+ constant 100
 682 acc8Comp constant 125
 683 brlt 691
 684 acc8= variable 0
 685 call writeAcc8
 686 decr8 variable 0
 687 br 680
 688 ;test1.j(258)   // constant - acc
 689 ;test1.j(259)   // byte - integer
 690 ;test1.j(260)   i=24;
 691 acc8= constant 24
 692 acc8=> variable 1
 693 ;test1.j(261)   b=23;
 694 acc8= constant 23
 695 acc8=> variable 0
 696 ;test1.j(262)   while (23 == i+0) { write (i); i--; }
 697 acc16= variable 1
 698 acc16+ constant 0
 699 acc8= constant 23
 700 acc8CompareAcc16
 701 brne 707
 702 acc16= variable 1
 703 call writeAcc16
 704 decr16 variable 1
 705 br 697
 706 ;test1.j(263)   while (120 != i+100) { write (i); i--; }
 707 acc16= variable 1
 708 acc16+ constant 100
 709 acc8= constant 120
 710 acc8CompareAcc16
 711 breq 717
 712 acc16= variable 1
 713 call writeAcc16
 714 decr16 variable 1
 715 br 707
 716 ;test1.j(264)   p=20;
 717 acc8= constant 20
 718 acc8=> variable 5
 719 ;test1.j(265)   while (122 > i+100) { write (p); p--; i++; }
 720 acc16= variable 1
 721 acc16+ constant 100
 722 acc8= constant 122
 723 acc8CompareAcc16
 724 brle 731
 725 acc16= variable 5
 726 call writeAcc16
 727 decr16 variable 5
 728 incr16 variable 1
 729 br 720
 730 ;test1.j(266)   while (123 >= i+100) { write (p); p--; i++; }
 731 acc16= variable 1
 732 acc16+ constant 100
 733 acc8= constant 123
 734 acc8CompareAcc16
 735 brlt 742
 736 acc16= variable 5
 737 call writeAcc16
 738 decr16 variable 5
 739 incr16 variable 1
 740 br 731
 741 ;test1.j(267)   i=16;
 742 acc8= constant 16
 743 acc8=> variable 1
 744 ;test1.j(268)   while (114 <  i+100) { write (i); i--; }
 745 acc16= variable 1
 746 acc16+ constant 100
 747 acc8= constant 114
 748 acc8CompareAcc16
 749 brge 755
 750 acc16= variable 1
 751 call writeAcc16
 752 decr16 variable 1
 753 br 745
 754 ;test1.j(269)   while (113 <= i+100) { write (i); i--; }
 755 acc16= variable 1
 756 acc16+ constant 100
 757 acc8= constant 113
 758 acc8CompareAcc16
 759 brgt 771
 760 acc16= variable 1
 761 call writeAcc16
 762 decr16 variable 1
 763 br 755
 764 ;test1.j(270)   // constant - acc
 765 ;test1.j(271)   // integer - byte
 766 ;test1.j(272)   // not relevant
 767 ;test1.j(273) 
 768 ;test1.j(274)   // constant - acc
 769 ;test1.j(275)   // integer - integer
 770 ;test1.j(276)   i=12;
 771 acc8= constant 12
 772 acc8=> variable 1
 773 ;test1.j(277)   while (1011 == i+1000) { write (i); i--; }
 774 acc16= variable 1
 775 acc16+ constant 1000
 776 acc16Comp constant 1011
 777 brne 784
 778 acc16= variable 1
 779 call writeAcc16
 780 decr16 variable 1
 781 br 774
 782 ;test1.j(278)   //i=10
 783 ;test1.j(279)   while (1008 != i+1000) { write (i); i--; }
 784 acc16= variable 1
 785 acc16+ constant 1000
 786 acc16Comp constant 1008
 787 breq 794
 788 acc16= variable 1
 789 call writeAcc16
 790 decr16 variable 1
 791 br 784
 792 ;test1.j(280)   //i=8
 793 ;test1.j(281)   p=8;
 794 acc8= constant 8
 795 acc8=> variable 5
 796 ;test1.j(282)   while (1010 > i+1000) { write (p); p--; i++; }
 797 acc16= variable 1
 798 acc16+ constant 1000
 799 acc16Comp constant 1010
 800 brge 808
 801 acc16= variable 5
 802 call writeAcc16
 803 decr16 variable 5
 804 incr16 variable 1
 805 br 797
 806 ;test1.j(283)   //i=10; p=6
 807 ;test1.j(284)   while (1011 >= i+1000) { write (p); p--; i++; }
 808 acc16= variable 1
 809 acc16+ constant 1000
 810 acc16Comp constant 1011
 811 brgt 818
 812 acc16= variable 5
 813 call writeAcc16
 814 decr16 variable 5
 815 incr16 variable 1
 816 br 808
 817 ;test1.j(285)   i=4;
 818 acc8= constant 4
 819 acc8=> variable 1
 820 ;test1.j(286)   while (1002 <  i+1000) { write (i); i--; }
 821 acc16= variable 1
 822 acc16+ constant 1000
 823 acc16Comp constant 1002
 824 brle 831
 825 acc16= variable 1
 826 call writeAcc16
 827 decr16 variable 1
 828 br 821
 829 ;test1.j(287)   //i=2;
 830 ;test1.j(288)   while (1001 <= i+1000) { write (i); i--; }
 831 acc16= variable 1
 832 acc16+ constant 1000
 833 acc16Comp constant 1001
 834 brlt 844
 835 acc16= variable 1
 836 call writeAcc16
 837 decr16 variable 1
 838 br 831
 839 ;test1.j(289) 
 840 ;test1.j(290)   /************************/
 841 ;test1.j(291)   // constant - constant
 842 ;test1.j(292)   // not relevant
 843 ;test1.j(293)   write(0);
 844 acc8= constant 0
 845 call writeAcc8
 846 ;test1.j(294) }
 847 stop
