   0 ;test1.j(0) /* Program to test generated Z80 assembler code */
   1 ;test1.j(1) class TestWhile {
   2 ;test1.j(2)   int i = 110;
   3 acc8= constant 110
   4 acc8=> variable 0
   5 ;test1.j(3)   int i2 = 105;
   6 acc8= constant 105
   7 acc8=> variable 2
   8 ;test1.j(4)   int p = 12;
   9 acc8= constant 12
  10 acc8=> variable 4
  11 ;test1.j(5)   byte b = 112;
  12 acc8= constant 112
  13 acc8=> variable 6
  14 ;test1.j(6)   byte b2 = 111;
  15 acc8= constant 111
  16 acc8=> variable 7
  17 ;test1.j(7) 
  18 ;test1.j(8)   /************************/
  19 ;test1.j(9)   // stack8 - constant
  20 ;test1.j(10)   // stack8 - acc
  21 ;test1.j(11)   // stack8 - var
  22 ;test1.j(12)   // stack8 - stack8
  23 ;test1.j(13)   // stack8 - stack16
  24 ;test1.j(14)   //TODO
  25 ;test1.j(15) 
  26 ;test1.j(16)   /************************/
  27 ;test1.j(17)   // stack16 - constant
  28 ;test1.j(18)   // stack16 - acc
  29 ;test1.j(19)   // stack16 - var
  30 ;test1.j(20)   // stack16 - stack8
  31 ;test1.j(21)   // stack16 - stack16
  32 ;test1.j(22)   //TODO
  33 ;test1.j(23) 
  34 ;test1.j(24)   /************************/
  35 ;test1.j(25)   // var - stack16
  36 ;test1.j(26)   // byte - byte
  37 ;test1.j(27)   // byte - integer
  38 ;test1.j(28)   // integer - byte
  39 ;test1.j(29)   // integer - integer
  40 ;test1.j(30)   //TODO
  41 ;test1.j(31) 
  42 ;test1.j(32)   /************************/
  43 ;test1.j(33)   // var - stack8
  44 ;test1.j(34)   // byte - byte
  45 ;test1.j(35)   // byte - integer
  46 ;test1.j(36)   // integer - byte
  47 ;test1.j(37)   // integer - integer
  48 ;test1.j(38)   //TODO
  49 ;test1.j(39) 
  50 ;test1.j(40)   /************************/
  51 ;test1.j(41)   // var - var
  52 ;test1.j(42)   // byte - byte
  53 ;test1.j(43)   while (b2 <= b) { write (b); b--; }
  54 acc8= variable 7
  55 acc8Comp variable 6
  56 brgt 63
  57 acc8= variable 6
  58 call writeAcc8
  59 decr8 variable 6
  60 br 54
  61 ;test1.j(44)   // byte - integer
  62 ;test1.j(45)   b2 = 109;
  63 acc8= constant 109
  64 acc8=> variable 7
  65 ;test1.j(46)   while (b2 <= i) { write (i); i--; }
  66 acc8= variable 7
  67 acc16= variable 0
  68 acc8CompareAcc16
  69 brgt 76
  70 acc16= variable 0
  71 call writeAcc16
  72 decr16 variable 0
  73 br 66
  74 ;test1.j(47)   // integer - byte
  75 ;test1.j(48)   b=108;
  76 acc8= constant 108
  77 acc8=> variable 6
  78 ;test1.j(49)   i=107;
  79 acc8= constant 107
  80 acc8=> variable 0
  81 ;test1.j(50)   while (i <= b) { write (b); b--; }
  82 acc16= variable 0
  83 acc8= variable 6
  84 acc16CompareAcc8
  85 brgt 92
  86 acc8= variable 6
  87 call writeAcc8
  88 decr8 variable 6
  89 br 82
  90 ;test1.j(51)   // integer - integer
  91 ;test1.j(52)   i=106;
  92 acc8= constant 106
  93 acc8=> variable 0
  94 ;test1.j(53)   while (i2 <= i) { write (i); i--; }
  95 acc16= variable 2
  96 acc16Comp variable 0
  97 brgt 107
  98 acc16= variable 0
  99 call writeAcc16
 100 decr16 variable 0
 101 br 95
 102 ;test1.j(54) 
 103 ;test1.j(55)   /************************/
 104 ;test1.j(56)   // var - acc
 105 ;test1.j(57)   // byte - byte
 106 ;test1.j(58)   i=104;
 107 acc8= constant 104
 108 acc8=> variable 0
 109 ;test1.j(59)   b=104;
 110 acc8= constant 104
 111 acc8=> variable 6
 112 ;test1.j(60)   while (b <= 105+0) { write (i); i--; b++; }
 113 acc8= constant 105
 114 acc8+ constant 0
 115 acc8Comp variable 6
 116 brlt 124
 117 acc16= variable 0
 118 call writeAcc16
 119 decr16 variable 0
 120 incr8 variable 6
 121 br 113
 122 ;test1.j(61)   // byte - integer
 123 ;test1.j(62)   i=103;
 124 acc8= constant 103
 125 acc8=> variable 0
 126 ;test1.j(63)   b=102;
 127 acc8= constant 102
 128 acc8=> variable 6
 129 ;test1.j(64)   while (b <= i+0) { write (b); b--; i=i-2; }
 130 acc16= variable 0
 131 acc16+ constant 0
 132 acc8= variable 6
 133 acc8CompareAcc16
 134 brgt 144
 135 acc8= variable 6
 136 call writeAcc8
 137 decr8 variable 6
 138 acc16= variable 0
 139 acc16- constant 2
 140 acc16=> variable 0
 141 br 130
 142 ;test1.j(65)   // integer - byte
 143 ;test1.j(66)   i=100;
 144 acc8= constant 100
 145 acc8=> variable 0
 146 ;test1.j(67)   while (i <= 101+0) { write (b); b--; i++; }
 147 acc8= constant 101
 148 acc8+ constant 0
 149 acc16= variable 0
 150 acc16CompareAcc8
 151 brgt 159
 152 acc8= variable 6
 153 call writeAcc8
 154 decr8 variable 6
 155 incr16 variable 0
 156 br 147
 157 ;test1.j(68)   // integer - integer
 158 ;test1.j(69)   i=1098;
 159 acc16= constant 1098
 160 acc16=> variable 0
 161 ;test1.j(70)   while (i <= 1099+0) { write (b); b--; i++; }
 162 acc16= constant 1099
 163 acc16+ constant 0
 164 acc16Comp variable 0
 165 brlt 176
 166 acc8= variable 6
 167 call writeAcc8
 168 decr8 variable 6
 169 incr16 variable 0
 170 br 162
 171 ;test1.j(71) 
 172 ;test1.j(72)   /************************/
 173 ;test1.j(73)   // var - constant
 174 ;test1.j(74)   // byte - byte
 175 ;test1.j(75)   i=96;
 176 acc8= constant 96
 177 acc8=> variable 0
 178 ;test1.j(76)   b=96;
 179 acc8= constant 96
 180 acc8=> variable 6
 181 ;test1.j(77)   while (b <= 97) { write (i); i--; b++; }
 182 acc8= variable 6
 183 acc8Comp constant 97
 184 brgt 193
 185 acc16= variable 0
 186 call writeAcc16
 187 decr16 variable 0
 188 incr8 variable 6
 189 br 182
 190 ;test1.j(78)   // byte - integer
 191 ;test1.j(79)   //not relevant
 192 ;test1.j(80)   write(94);
 193 acc8= constant 94
 194 call writeAcc8
 195 ;test1.j(81)   write(93);
 196 acc8= constant 93
 197 call writeAcc8
 198 ;test1.j(82)   // integer - byte
 199 ;test1.j(83)   i=92;
 200 acc8= constant 92
 201 acc8=> variable 0
 202 ;test1.j(84)   b=92;
 203 acc8= constant 92
 204 acc8=> variable 6
 205 ;test1.j(85)   while (i <= 93) { write (b); b--; i++; }
 206 acc16= variable 0
 207 acc8= constant 93
 208 acc16CompareAcc8
 209 brgt 217
 210 acc8= variable 6
 211 call writeAcc8
 212 decr8 variable 6
 213 incr16 variable 0
 214 br 206
 215 ;test1.j(86)   // integer - integer
 216 ;test1.j(87)   i=1090;
 217 acc16= constant 1090
 218 acc16=> variable 0
 219 ;test1.j(88)   while (i <= 1091) { write (b); b--; i++; }
 220 acc16= variable 0
 221 acc16Comp constant 1091
 222 brgt 234
 223 acc8= variable 6
 224 call writeAcc8
 225 decr8 variable 6
 226 incr16 variable 0
 227 br 220
 228 ;test1.j(89) 
 229 ;test1.j(90)   /************************/
 230 ;test1.j(91)   // acc - stack8
 231 ;test1.j(92)   // byte - byte
 232 ;test1.j(93)   //TODO
 233 ;test1.j(94)   write(88);
 234 acc8= constant 88
 235 call writeAcc8
 236 ;test1.j(95)   write(87);
 237 acc8= constant 87
 238 call writeAcc8
 239 ;test1.j(96)   // byte - integer
 240 ;test1.j(97)   //TODO
 241 ;test1.j(98)   write(86);
 242 acc8= constant 86
 243 call writeAcc8
 244 ;test1.j(99)   write(85);
 245 acc8= constant 85
 246 call writeAcc8
 247 ;test1.j(100)   // integer - byte
 248 ;test1.j(101)   //TODO
 249 ;test1.j(102)   write(84);
 250 acc8= constant 84
 251 call writeAcc8
 252 ;test1.j(103)   write(83);
 253 acc8= constant 83
 254 call writeAcc8
 255 ;test1.j(104)   // integer - integer
 256 ;test1.j(105)   //TODO
 257 ;test1.j(106)   write(82);
 258 acc8= constant 82
 259 call writeAcc8
 260 ;test1.j(107)   write(81);
 261 acc8= constant 81
 262 call writeAcc8
 263 ;test1.j(108) 
 264 ;test1.j(109)   /************************/
 265 ;test1.j(110)   // acc - stack16
 266 ;test1.j(111)   // byte - byte
 267 ;test1.j(112)   //TODO
 268 ;test1.j(113)   write(80);
 269 acc8= constant 80
 270 call writeAcc8
 271 ;test1.j(114)   write(79);
 272 acc8= constant 79
 273 call writeAcc8
 274 ;test1.j(115)   // byte - integer
 275 ;test1.j(116)   //TODO
 276 ;test1.j(117)   write(78);
 277 acc8= constant 78
 278 call writeAcc8
 279 ;test1.j(118)   write(77);
 280 acc8= constant 77
 281 call writeAcc8
 282 ;test1.j(119)   // integer - byte
 283 ;test1.j(120)   //TODO
 284 ;test1.j(121)   write(76);
 285 acc8= constant 76
 286 call writeAcc8
 287 ;test1.j(122)   write(75);
 288 acc8= constant 75
 289 call writeAcc8
 290 ;test1.j(123)   // integer - integer
 291 ;test1.j(124)   //TODO
 292 ;test1.j(125)   write(74);
 293 acc8= constant 74
 294 call writeAcc8
 295 ;test1.j(126)   write(73);
 296 acc8= constant 73
 297 call writeAcc8
 298 ;test1.j(127) 
 299 ;test1.j(128)   /************************/
 300 ;test1.j(129)   // acc - var
 301 ;test1.j(130)   // byte - byte
 302 ;test1.j(131)   b=72;
 303 acc8= constant 72
 304 acc8=> variable 6
 305 ;test1.j(132)   while (71+0 <= b) { write (b); b--; }
 306 acc8= constant 71
 307 acc8+ constant 0
 308 acc8Comp variable 6
 309 brgt 316
 310 acc8= variable 6
 311 call writeAcc8
 312 decr8 variable 6
 313 br 306
 314 ;test1.j(133)   // byte - integer
 315 ;test1.j(134)   i=70;
 316 acc8= constant 70
 317 acc8=> variable 0
 318 ;test1.j(135)   while (69+0 <= i) { write (i); i--; }
 319 acc8= constant 69
 320 acc8+ constant 0
 321 acc16= variable 0
 322 acc8CompareAcc16
 323 brgt 330
 324 acc16= variable 0
 325 call writeAcc16
 326 decr16 variable 0
 327 br 319
 328 ;test1.j(136)   // integer - byte
 329 ;test1.j(137)   i=67;
 330 acc8= constant 67
 331 acc8=> variable 0
 332 ;test1.j(138)   b=68;
 333 acc8= constant 68
 334 acc8=> variable 6
 335 ;test1.j(139)   while (i+0 <= b) { write (b); b--; } 
 336 acc16= variable 0
 337 acc16+ constant 0
 338 acc8= variable 6
 339 acc16CompareAcc8
 340 brgt 347
 341 acc8= variable 6
 342 call writeAcc8
 343 decr8 variable 6
 344 br 336
 345 ;test1.j(140)   // integer - integer
 346 ;test1.j(141)   i=1066;
 347 acc16= constant 1066
 348 acc16=> variable 0
 349 ;test1.j(142)   while (1000+65 <= i) { write (b); b--; i--; }
 350 acc16= constant 1000
 351 acc16+ constant 65
 352 acc16Comp variable 0
 353 brgt 364
 354 acc8= variable 6
 355 call writeAcc8
 356 decr8 variable 6
 357 decr16 variable 0
 358 br 350
 359 ;test1.j(143) 
 360 ;test1.j(144)   /************************/
 361 ;test1.j(145)   // acc - acc
 362 ;test1.j(146)   // byte - byte
 363 ;test1.j(147)   b=64;
 364 acc8= constant 64
 365 acc8=> variable 6
 366 ;test1.j(148)   while (63+0 <= b+0) { write (b); b--; }
 367 acc8= constant 63
 368 acc8+ constant 0
 369 <acc8
 370 acc8= variable 6
 371 acc8+ constant 0
 372 revAcc8Comp unstack8
 373 brlt 380
 374 acc8= variable 6
 375 call writeAcc8
 376 decr8 variable 6
 377 br 367
 378 ;test1.j(149)   // byte - integer
 379 ;test1.j(150)   i=62;
 380 acc8= constant 62
 381 acc8=> variable 0
 382 ;test1.j(151)   while (61+0 <= i+0) { write (i); i--; }
 383 acc8= constant 61
 384 acc8+ constant 0
 385 <acc8
 386 acc16= variable 0
 387 acc16+ constant 0
 388 acc8= unstack8
 389 acc8CompareAcc16
 390 brgt 397
 391 acc16= variable 0
 392 call writeAcc16
 393 decr16 variable 0
 394 br 383
 395 ;test1.j(152)   // integer - byte
 396 ;test1.j(153)   i=59;
 397 acc8= constant 59
 398 acc8=> variable 0
 399 ;test1.j(154)   b=60;
 400 acc8= constant 60
 401 acc8=> variable 6
 402 ;test1.j(155)   while (i+0 <= b+0) { write (b); b--; }
 403 acc16= variable 0
 404 acc16+ constant 0
 405 <acc16
 406 acc8= variable 6
 407 acc8+ constant 0
 408 acc16= unstack16
 409 acc16CompareAcc8
 410 brgt 417
 411 acc8= variable 6
 412 call writeAcc8
 413 decr8 variable 6
 414 br 403
 415 ;test1.j(156)   // integer - integer
 416 ;test1.j(157)   i=1058;
 417 acc16= constant 1058
 418 acc16=> variable 0
 419 ;test1.j(158)   while (1000+57 <= i+0) { write (b); b--; i--; }
 420 acc16= constant 1000
 421 acc16+ constant 57
 422 <acc16
 423 acc16= variable 0
 424 acc16+ constant 0
 425 revAcc16Comp unstack16
 426 brlt 437
 427 acc8= variable 6
 428 call writeAcc8
 429 decr8 variable 6
 430 decr16 variable 0
 431 br 420
 432 ;test1.j(159) 
 433 ;test1.j(160)   /************************/
 434 ;test1.j(161)   // acc - constant
 435 ;test1.j(162)   // byte - byte
 436 ;test1.j(163)   i=56;
 437 acc8= constant 56
 438 acc8=> variable 0
 439 ;test1.j(164)   b=56;
 440 acc8= constant 56
 441 acc8=> variable 6
 442 ;test1.j(165)   while (b+0 <= 57) { write (i); i--; b++; }
 443 acc8= variable 6
 444 acc8+ constant 0
 445 acc8Comp constant 57
 446 brgt 456
 447 acc16= variable 0
 448 call writeAcc16
 449 decr16 variable 0
 450 incr8 variable 6
 451 br 443
 452 ;test1.j(166)   // byte - integer
 453 ;test1.j(167)   //not relevant
 454 ;test1.j(168)   // integer - byte
 455 ;test1.j(169)   i=54;
 456 acc8= constant 54
 457 acc8=> variable 0
 458 ;test1.j(170)   b=54;
 459 acc8= constant 54
 460 acc8=> variable 6
 461 ;test1.j(171)   while (i+0 <= 55) { write (b); b--; i++; }
 462 acc16= variable 0
 463 acc16+ constant 0
 464 acc8= constant 55
 465 acc16CompareAcc8
 466 brgt 473
 467 acc8= variable 6
 468 call writeAcc8
 469 decr8 variable 6
 470 incr16 variable 0
 471 br 462
 472 ;test1.j(172)   i=1052;
 473 acc16= constant 1052
 474 acc16=> variable 0
 475 ;test1.j(173)   // integer - integer
 476 ;test1.j(174)   while (i+0 <= 1053) { write (b); b--; i++; }
 477 acc16= variable 0
 478 acc16+ constant 0
 479 acc16Comp constant 1053
 480 brgt 492
 481 acc8= variable 6
 482 call writeAcc8
 483 decr8 variable 6
 484 incr16 variable 0
 485 br 477
 486 ;test1.j(175) 
 487 ;test1.j(176)   /************************/
 488 ;test1.j(177)   // constant - stack8
 489 ;test1.j(178)   // byte - byte
 490 ;test1.j(179)   //TODO
 491 ;test1.j(180)   write(50);
 492 acc8= constant 50
 493 call writeAcc8
 494 ;test1.j(181)   // constant - stack8
 495 ;test1.j(182)   // byte - integer
 496 ;test1.j(183)   //TODO
 497 ;test1.j(184)   write(49);
 498 acc8= constant 49
 499 call writeAcc8
 500 ;test1.j(185)   // constant - stack8
 501 ;test1.j(186)   // integer - byte
 502 ;test1.j(187)   //TODO
 503 ;test1.j(188)   write(48);
 504 acc8= constant 48
 505 call writeAcc8
 506 ;test1.j(189)   // constant - stack88
 507 ;test1.j(190)   // integer - integer
 508 ;test1.j(191)   //TODO
 509 ;test1.j(192)   write(47);
 510 acc8= constant 47
 511 call writeAcc8
 512 ;test1.j(193) 
 513 ;test1.j(194)   /************************/
 514 ;test1.j(195)   // constant - stack16
 515 ;test1.j(196)   // byte - byte
 516 ;test1.j(197)   //TODO
 517 ;test1.j(198)   write(46);
 518 acc8= constant 46
 519 call writeAcc8
 520 ;test1.j(199)   // constant - stack16
 521 ;test1.j(200)   // byte - integer
 522 ;test1.j(201)   //TODO
 523 ;test1.j(202)   write(45);
 524 acc8= constant 45
 525 call writeAcc8
 526 ;test1.j(203)   // constant - stack16
 527 ;test1.j(204)   // integer - byte
 528 ;test1.j(205)   //TODO
 529 ;test1.j(206)   write(44);
 530 acc8= constant 44
 531 call writeAcc8
 532 ;test1.j(207)   // constant - stack16
 533 ;test1.j(208)   // integer - integer
 534 ;test1.j(209)   //TODO
 535 ;test1.j(210)   write(43);
 536 acc8= constant 43
 537 call writeAcc8
 538 ;test1.j(211) 
 539 ;test1.j(212)   /************************/
 540 ;test1.j(213)   // constant - var
 541 ;test1.j(214)   // byte - byte
 542 ;test1.j(215)   b=42;
 543 acc8= constant 42
 544 acc8=> variable 6
 545 ;test1.j(216)   while (41 <= b) { write (b); b--; }
 546 acc8= variable 6
 547 acc8Comp constant 41
 548 brlt 557
 549 acc8= variable 6
 550 call writeAcc8
 551 decr8 variable 6
 552 br 546
 553 ;test1.j(217) 
 554 ;test1.j(218)   // constant - var
 555 ;test1.j(219)   // byte - integer
 556 ;test1.j(220)   i=40;
 557 acc8= constant 40
 558 acc8=> variable 0
 559 ;test1.j(221)   while (39 <= i) { write (i); i--; }
 560 acc16= variable 0
 561 acc8= constant 39
 562 acc8CompareAcc16
 563 brgt 576
 564 acc16= variable 0
 565 call writeAcc16
 566 decr16 variable 0
 567 br 560
 568 ;test1.j(222) 
 569 ;test1.j(223)   // constant - var
 570 ;test1.j(224)   // integer - byte
 571 ;test1.j(225)   // not relevant
 572 ;test1.j(226) 
 573 ;test1.j(227)   // constant - var
 574 ;test1.j(228)   // integer - integer
 575 ;test1.j(229)   i=1038;
 576 acc16= constant 1038
 577 acc16=> variable 0
 578 ;test1.j(230)   b=38;
 579 acc8= constant 38
 580 acc8=> variable 6
 581 ;test1.j(231)   while (1037 <= i) { write (b); b--; i--; }
 582 acc16= variable 0
 583 acc16Comp constant 1037
 584 brlt 595
 585 acc8= variable 6
 586 call writeAcc8
 587 decr8 variable 6
 588 decr16 variable 0
 589 br 582
 590 ;test1.j(232) 
 591 ;test1.j(233)   /************************/
 592 ;test1.j(234)   // constant - acc
 593 ;test1.j(235)   // byte - byte
 594 ;test1.j(236)   b=36;
 595 acc8= constant 36
 596 acc8=> variable 6
 597 ;test1.j(237)   while (135 == b+100) { write (b); b--; }
 598 acc8= variable 6
 599 acc8+ constant 100
 600 acc8Comp constant 135
 601 brne 607
 602 acc8= variable 6
 603 call writeAcc8
 604 decr8 variable 6
 605 br 598
 606 ;test1.j(238)   while (132 != b+100) { write (b); b--; }
 607 acc8= variable 6
 608 acc8+ constant 100
 609 acc8Comp constant 132
 610 breq 616
 611 acc8= variable 6
 612 call writeAcc8
 613 decr8 variable 6
 614 br 607
 615 ;test1.j(239)   p=32;
 616 acc8= constant 32
 617 acc8=> variable 4
 618 ;test1.j(240)   while (134 > b+100) { write (p); p--; b++; }
 619 acc8= variable 6
 620 acc8+ constant 100
 621 acc8Comp constant 134
 622 brge 629
 623 acc16= variable 4
 624 call writeAcc16
 625 decr16 variable 4
 626 incr8 variable 6
 627 br 619
 628 ;test1.j(241)   while (135 >= b+100) { write (p); p--; b++; }
 629 acc8= variable 6
 630 acc8+ constant 100
 631 acc8Comp constant 135
 632 brgt 639
 633 acc16= variable 4
 634 call writeAcc16
 635 decr16 variable 4
 636 incr8 variable 6
 637 br 629
 638 ;test1.j(242)   b=28;
 639 acc8= constant 28
 640 acc8=> variable 6
 641 ;test1.j(243)   while (126 <  b+100) { write (b); b--; }
 642 acc8= variable 6
 643 acc8+ constant 100
 644 acc8Comp constant 126
 645 brle 651
 646 acc8= variable 6
 647 call writeAcc8
 648 decr8 variable 6
 649 br 642
 650 ;test1.j(244)   while (125 <= b+100) { write (b); b--; }
 651 acc8= variable 6
 652 acc8+ constant 100
 653 acc8Comp constant 125
 654 brlt 662
 655 acc8= variable 6
 656 call writeAcc8
 657 decr8 variable 6
 658 br 651
 659 ;test1.j(245)   // constant - acc
 660 ;test1.j(246)   // byte - integer
 661 ;test1.j(247)   i=24;
 662 acc8= constant 24
 663 acc8=> variable 0
 664 ;test1.j(248)   b=23;
 665 acc8= constant 23
 666 acc8=> variable 6
 667 ;test1.j(249)   while (23 == i+0) { write (i); i--; }
 668 acc16= variable 0
 669 acc16+ constant 0
 670 acc8= constant 23
 671 acc8CompareAcc16
 672 brne 678
 673 acc16= variable 0
 674 call writeAcc16
 675 decr16 variable 0
 676 br 668
 677 ;test1.j(250)   while (120 != i+100) { write (i); i--; }
 678 acc16= variable 0
 679 acc16+ constant 100
 680 acc8= constant 120
 681 acc8CompareAcc16
 682 breq 688
 683 acc16= variable 0
 684 call writeAcc16
 685 decr16 variable 0
 686 br 678
 687 ;test1.j(251)   p=20;
 688 acc8= constant 20
 689 acc8=> variable 4
 690 ;test1.j(252)   while (122 > i+100) { write (p); p--; i++; }
 691 acc16= variable 0
 692 acc16+ constant 100
 693 acc8= constant 122
 694 acc8CompareAcc16
 695 brle 702
 696 acc16= variable 4
 697 call writeAcc16
 698 decr16 variable 4
 699 incr16 variable 0
 700 br 691
 701 ;test1.j(253)   while (123 >= i+100) { write (p); p--; i++; }
 702 acc16= variable 0
 703 acc16+ constant 100
 704 acc8= constant 123
 705 acc8CompareAcc16
 706 brlt 713
 707 acc16= variable 4
 708 call writeAcc16
 709 decr16 variable 4
 710 incr16 variable 0
 711 br 702
 712 ;test1.j(254)   i=16;
 713 acc8= constant 16
 714 acc8=> variable 0
 715 ;test1.j(255)   while (114 <  i+100) { write (i); i--; }
 716 acc16= variable 0
 717 acc16+ constant 100
 718 acc8= constant 114
 719 acc8CompareAcc16
 720 brge 726
 721 acc16= variable 0
 722 call writeAcc16
 723 decr16 variable 0
 724 br 716
 725 ;test1.j(256)   while (113 <= i+100) { write (i); i--; }
 726 acc16= variable 0
 727 acc16+ constant 100
 728 acc8= constant 113
 729 acc8CompareAcc16
 730 brgt 742
 731 acc16= variable 0
 732 call writeAcc16
 733 decr16 variable 0
 734 br 726
 735 ;test1.j(257)   // constant - acc
 736 ;test1.j(258)   // integer - byte
 737 ;test1.j(259)   // not relevant
 738 ;test1.j(260) 
 739 ;test1.j(261)   // constant - acc
 740 ;test1.j(262)   // integer - integer
 741 ;test1.j(263)   i=12;
 742 acc8= constant 12
 743 acc8=> variable 0
 744 ;test1.j(264)   while (1011 == i+1000) { write (i); i--; }
 745 acc16= variable 0
 746 acc16+ constant 1000
 747 acc16Comp constant 1011
 748 brne 755
 749 acc16= variable 0
 750 call writeAcc16
 751 decr16 variable 0
 752 br 745
 753 ;test1.j(265)   //i=10
 754 ;test1.j(266)   while (1008 != i+1000) { write (i); i--; }
 755 acc16= variable 0
 756 acc16+ constant 1000
 757 acc16Comp constant 1008
 758 breq 765
 759 acc16= variable 0
 760 call writeAcc16
 761 decr16 variable 0
 762 br 755
 763 ;test1.j(267)   //i=8
 764 ;test1.j(268)   p=8;
 765 acc8= constant 8
 766 acc8=> variable 4
 767 ;test1.j(269)   while (1010 > i+1000) { write (p); p--; i++; }
 768 acc16= variable 0
 769 acc16+ constant 1000
 770 acc16Comp constant 1010
 771 brge 779
 772 acc16= variable 4
 773 call writeAcc16
 774 decr16 variable 4
 775 incr16 variable 0
 776 br 768
 777 ;test1.j(270)   //i=10; p=6
 778 ;test1.j(271)   while (1011 >= i+1000) { write (p); p--; i++; }
 779 acc16= variable 0
 780 acc16+ constant 1000
 781 acc16Comp constant 1011
 782 brgt 789
 783 acc16= variable 4
 784 call writeAcc16
 785 decr16 variable 4
 786 incr16 variable 0
 787 br 779
 788 ;test1.j(272)   i=4;
 789 acc8= constant 4
 790 acc8=> variable 0
 791 ;test1.j(273)   while (1002 <  i+1000) { write (i); i--; }
 792 acc16= variable 0
 793 acc16+ constant 1000
 794 acc16Comp constant 1002
 795 brle 802
 796 acc16= variable 0
 797 call writeAcc16
 798 decr16 variable 0
 799 br 792
 800 ;test1.j(274)   //i=2;
 801 ;test1.j(275)   while (1001 <= i+1000) { write (i); i--; }
 802 acc16= variable 0
 803 acc16+ constant 1000
 804 acc16Comp constant 1001
 805 brlt 815
 806 acc16= variable 0
 807 call writeAcc16
 808 decr16 variable 0
 809 br 802
 810 ;test1.j(276) 
 811 ;test1.j(277)   /************************/
 812 ;test1.j(278)   // constant - constant
 813 ;test1.j(279)   // not relevant
 814 ;test1.j(280)   write(0);
 815 acc8= constant 0
 816 call writeAcc8
 817 ;test1.j(281) }
 818 stop
