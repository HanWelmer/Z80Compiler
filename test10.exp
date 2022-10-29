   0 ;test10.j(0) /* Program to test generated Z80 assembler code */
   1 ;test10.j(1) class TestDo {
   2 ;test10.j(2)   int i = 12;
   3 acc8= constant 12
   4 acc8=> variable 0
   5 ;test10.j(3)   int p = 12;
   6 acc8= constant 12
   7 acc8=> variable 2
   8 ;test10.j(4)   byte b = 24;
   9 acc8= constant 24
  10 acc8=> variable 4
  11 ;test10.j(5) 
  12 ;test10.j(6)   /************************/
  13 ;test10.j(7)   // stack8 - constant
  14 ;test10.j(8)   // stack8 - acc
  15 ;test10.j(9)   // stack8 - var
  16 ;test10.j(10)   // stack8 - stack8
  17 ;test10.j(11)   // stack8 - stack16
  18 ;test10.j(12)   //TODO
  19 ;test10.j(13) 
  20 ;test10.j(14)   /************************/
  21 ;test10.j(15)   // stack16 - constant
  22 ;test10.j(16)   // stack16 - acc
  23 ;test10.j(17)   // stack16 - var
  24 ;test10.j(18)   // stack16 - stack8
  25 ;test10.j(19)   // stack16 - stack16
  26 ;test10.j(20)   //TODO
  27 ;test10.j(21) 
  28 ;test10.j(22)   /************************/
  29 ;test10.j(23)   // var - stack16
  30 ;test10.j(24)   // byte - byte
  31 ;test10.j(25)   // byte - integer
  32 ;test10.j(26)   // integer - byte
  33 ;test10.j(27)   // integer - integer
  34 ;test10.j(28)   //TODO
  35 ;test10.j(29) 
  36 ;test10.j(30)   /************************/
  37 ;test10.j(31)   // var - stack8
  38 ;test10.j(32)   // byte - byte
  39 ;test10.j(33)   // byte - integer
  40 ;test10.j(34)   // integer - byte
  41 ;test10.j(35)   // integer - integer
  42 ;test10.j(36)   //TODO
  43 ;test10.j(37) 
  44 ;test10.j(38)   /************************/
  45 ;test10.j(39)   // var - var
  46 ;test10.j(40)   // byte - byte
  47 ;test10.j(41)   b=112;
  48 acc8= constant 112
  49 acc8=> variable 4
  50 ;test10.j(42)   byte b2 = 111;
  51 acc8= constant 111
  52 acc8=> variable 5
  53 ;test10.j(43)   do { write (b); b--; } while (b2 <= b);
  54 acc8= variable 4
  55 call writeAcc8
  56 decr8 variable 4
  57 acc8= variable 5
  58 acc8Comp variable 4
  59 brle 54
  60 ;test10.j(44)   // byte - integer
  61 ;test10.j(45)   i=110;
  62 acc8= constant 110
  63 acc8=> variable 0
  64 ;test10.j(46)   b2 = 109;
  65 acc8= constant 109
  66 acc8=> variable 5
  67 ;test10.j(47)   do { write (i); i--; } while (b2 <= i);
  68 acc16= variable 0
  69 call writeAcc16
  70 decr16 variable 0
  71 acc8= variable 5
  72 acc16= variable 0
  73 acc8CompareAcc16
  74 brle 68
  75 ;test10.j(48)   // integer - byte
  76 ;test10.j(49)   b=108;
  77 acc8= constant 108
  78 acc8=> variable 4
  79 ;test10.j(50)   i=107;
  80 acc8= constant 107
  81 acc8=> variable 0
  82 ;test10.j(51)   do { write (b); b--; } while (i <= b);
  83 acc8= variable 4
  84 call writeAcc8
  85 decr8 variable 4
  86 acc16= variable 0
  87 acc8= variable 4
  88 acc16CompareAcc8
  89 brle 83
  90 ;test10.j(52)   // integer - integer
  91 ;test10.j(53)   i=106;
  92 acc8= constant 106
  93 acc8=> variable 0
  94 ;test10.j(54)   int i2 = 105;
  95 acc8= constant 105
  96 acc8=> variable 6
  97 ;test10.j(55)   do { write (i); i--; } while (i2 <= i);
  98 acc16= variable 0
  99 call writeAcc16
 100 decr16 variable 0
 101 acc16= variable 6
 102 acc16Comp variable 0
 103 brle 98
 104 ;test10.j(56) 
 105 ;test10.j(57)   /************************/
 106 ;test10.j(58)   // var - acc
 107 ;test10.j(59)   // byte - byte
 108 ;test10.j(60)   i=104;
 109 acc8= constant 104
 110 acc8=> variable 0
 111 ;test10.j(61)   b=104;
 112 acc8= constant 104
 113 acc8=> variable 4
 114 ;test10.j(62)   do { write (i); i--; b++; } while (b <= 105+0);
 115 acc16= variable 0
 116 call writeAcc16
 117 decr16 variable 0
 118 incr8 variable 4
 119 acc8= variable 4
 120 <acc8
 121 acc8= constant 105
 122 acc8+ constant 0
 123 revAcc8Comp unstack8
 124 brge 115
 125 ;test10.j(63)   // byte - integer
 126 ;test10.j(64)   //not relevant
 127 ;test10.j(65)   i=103;
 128 acc8= constant 103
 129 acc8=> variable 0
 130 ;test10.j(66)   b=102;
 131 acc8= constant 102
 132 acc8=> variable 4
 133 ;test10.j(67)   do { write (b); b--; i=i-2; } while (b <= i+0);
 134 acc8= variable 4
 135 call writeAcc8
 136 decr8 variable 4
 137 acc16= variable 0
 138 acc16- constant 2
 139 acc16=> variable 0
 140 acc8= variable 4
 141 <acc8
 142 acc16= variable 0
 143 acc16+ constant 0
 144 acc8= unstack8
 145 acc8CompareAcc16
 146 brle 134
 147 ;test10.j(68)   // integer - byte
 148 ;test10.j(69)   i=100;
 149 acc8= constant 100
 150 acc8=> variable 0
 151 ;test10.j(70)   do { write (b); b--; i++; } while (i <= 101+0);
 152 acc8= variable 4
 153 call writeAcc8
 154 decr8 variable 4
 155 incr16 variable 0
 156 acc16= variable 0
 157 <acc16
 158 acc8= constant 101
 159 acc8+ constant 0
 160 acc16= unstack16
 161 acc16CompareAcc8
 162 brle 152
 163 ;test10.j(71)   // integer - integer
 164 ;test10.j(72)   i=1098;
 165 acc16= constant 1098
 166 acc16=> variable 0
 167 ;test10.j(73)   do { write (b); b--; i++; } while (i <= 1099+0);
 168 acc8= variable 4
 169 call writeAcc8
 170 decr8 variable 4
 171 incr16 variable 0
 172 acc16= variable 0
 173 <acc16
 174 acc16= constant 1099
 175 acc16+ constant 0
 176 revAcc16Comp unstack16
 177 brge 168
 178 ;test10.j(74) 
 179 ;test10.j(75)   /************************/
 180 ;test10.j(76)   // var - constant
 181 ;test10.j(77)   // byte - byte
 182 ;test10.j(78)   i=96;
 183 acc8= constant 96
 184 acc8=> variable 0
 185 ;test10.j(79)   b=96;
 186 acc8= constant 96
 187 acc8=> variable 4
 188 ;test10.j(80)   do { write (i); i--; b++; } while (b <= 97);
 189 acc16= variable 0
 190 call writeAcc16
 191 decr16 variable 0
 192 incr8 variable 4
 193 acc8= variable 4
 194 acc8Comp constant 97
 195 brle 189
 196 ;test10.j(81)   // byte - integer
 197 ;test10.j(82)   //not relevant
 198 ;test10.j(83)   write(94);
 199 acc8= constant 94
 200 call writeAcc8
 201 ;test10.j(84)   write(93);
 202 acc8= constant 93
 203 call writeAcc8
 204 ;test10.j(85)   // integer - byte
 205 ;test10.j(86)   i=92;
 206 acc8= constant 92
 207 acc8=> variable 0
 208 ;test10.j(87)   b=92;
 209 acc8= constant 92
 210 acc8=> variable 4
 211 ;test10.j(88)   do { write (b); b--; i++; } while (i <= 93);
 212 acc8= variable 4
 213 call writeAcc8
 214 decr8 variable 4
 215 incr16 variable 0
 216 acc16= variable 0
 217 acc8= constant 93
 218 acc16CompareAcc8
 219 brle 212
 220 ;test10.j(89)   // integer - integer
 221 ;test10.j(90)   i=1090;
 222 acc16= constant 1090
 223 acc16=> variable 0
 224 ;test10.j(91)   do { write (b); b--; i++; } while (i <= 1091);
 225 acc8= variable 4
 226 call writeAcc8
 227 decr8 variable 4
 228 incr16 variable 0
 229 acc16= variable 0
 230 acc16Comp constant 1091
 231 brle 225
 232 ;test10.j(92) 
 233 ;test10.j(93)   /************************/
 234 ;test10.j(94)   // acc - stack8
 235 ;test10.j(95)   // byte - byte
 236 ;test10.j(96)   //TODO
 237 ;test10.j(97)   write(88);
 238 acc8= constant 88
 239 call writeAcc8
 240 ;test10.j(98)   write(87);
 241 acc8= constant 87
 242 call writeAcc8
 243 ;test10.j(99)   // byte - integer
 244 ;test10.j(100)   //TODO
 245 ;test10.j(101)   write(86);
 246 acc8= constant 86
 247 call writeAcc8
 248 ;test10.j(102)   write(85);
 249 acc8= constant 85
 250 call writeAcc8
 251 ;test10.j(103)   // integer - byte
 252 ;test10.j(104)   //TODO
 253 ;test10.j(105)   write(84);
 254 acc8= constant 84
 255 call writeAcc8
 256 ;test10.j(106)   write(83);
 257 acc8= constant 83
 258 call writeAcc8
 259 ;test10.j(107)   // integer - integer
 260 ;test10.j(108)   //TODO
 261 ;test10.j(109)   write(82);
 262 acc8= constant 82
 263 call writeAcc8
 264 ;test10.j(110)   write(81);
 265 acc8= constant 81
 266 call writeAcc8
 267 ;test10.j(111) 
 268 ;test10.j(112)   /************************/
 269 ;test10.j(113)   // acc - stack16
 270 ;test10.j(114)   // byte - byte
 271 ;test10.j(115)   //TODO
 272 ;test10.j(116)   write(80);
 273 acc8= constant 80
 274 call writeAcc8
 275 ;test10.j(117)   write(79);
 276 acc8= constant 79
 277 call writeAcc8
 278 ;test10.j(118)   // byte - integer
 279 ;test10.j(119)   //TODO
 280 ;test10.j(120)   write(78);
 281 acc8= constant 78
 282 call writeAcc8
 283 ;test10.j(121)   write(77);
 284 acc8= constant 77
 285 call writeAcc8
 286 ;test10.j(122)   // integer - byte
 287 ;test10.j(123)   //TODO
 288 ;test10.j(124)   write(76);
 289 acc8= constant 76
 290 call writeAcc8
 291 ;test10.j(125)   write(75);
 292 acc8= constant 75
 293 call writeAcc8
 294 ;test10.j(126)   // integer - integer
 295 ;test10.j(127)   //TODO
 296 ;test10.j(128)   write(74);
 297 acc8= constant 74
 298 call writeAcc8
 299 ;test10.j(129)   write(73);
 300 acc8= constant 73
 301 call writeAcc8
 302 ;test10.j(130) 
 303 ;test10.j(131)   /************************/
 304 ;test10.j(132)   // acc - var
 305 ;test10.j(133)   // byte - byte
 306 ;test10.j(134)   b=72;
 307 acc8= constant 72
 308 acc8=> variable 4
 309 ;test10.j(135)   do { write (b); b--; } while (71+0 <= b);
 310 acc8= variable 4
 311 call writeAcc8
 312 decr8 variable 4
 313 acc8= constant 71
 314 acc8+ constant 0
 315 acc8Comp variable 4
 316 brle 310
 317 ;test10.j(136)   // byte - integer
 318 ;test10.j(137)   i=70;
 319 acc8= constant 70
 320 acc8=> variable 0
 321 ;test10.j(138)   do { write (i); i--; } while (69+0 <= i);
 322 acc16= variable 0
 323 call writeAcc16
 324 decr16 variable 0
 325 acc8= constant 69
 326 acc8+ constant 0
 327 acc16= variable 0
 328 acc8CompareAcc16
 329 brle 322
 330 ;test10.j(139)   // integer - byte
 331 ;test10.j(140)   i=67;
 332 acc8= constant 67
 333 acc8=> variable 0
 334 ;test10.j(141)   b=68;
 335 acc8= constant 68
 336 acc8=> variable 4
 337 ;test10.j(142)   do { write (b); b--; } while (i+0 <= b);
 338 acc8= variable 4
 339 call writeAcc8
 340 decr8 variable 4
 341 acc16= variable 0
 342 acc16+ constant 0
 343 acc8= variable 4
 344 acc16CompareAcc8
 345 brle 338
 346 ;test10.j(143)   // integer - integer
 347 ;test10.j(144)   i=1066;
 348 acc16= constant 1066
 349 acc16=> variable 0
 350 ;test10.j(145)   do { write (b); b--; i--; } while (1000+65 <= i);
 351 acc8= variable 4
 352 call writeAcc8
 353 decr8 variable 4
 354 decr16 variable 0
 355 acc16= constant 1000
 356 acc16+ constant 65
 357 acc16Comp variable 0
 358 brle 351
 359 ;test10.j(146) 
 360 ;test10.j(147)   /************************/
 361 ;test10.j(148)   // acc - acc
 362 ;test10.j(149)   // byte - byte
 363 ;test10.j(150)   b=64;
 364 acc8= constant 64
 365 acc8=> variable 4
 366 ;test10.j(151)   do { write (b); b--; } while (63+0 <= b+0);
 367 acc8= variable 4
 368 call writeAcc8
 369 decr8 variable 4
 370 acc8= constant 63
 371 acc8+ constant 0
 372 <acc8
 373 acc8= variable 4
 374 acc8+ constant 0
 375 revAcc8Comp unstack8
 376 brge 367
 377 ;test10.j(152)   // byte - integer
 378 ;test10.j(153)   i=62;
 379 acc8= constant 62
 380 acc8=> variable 0
 381 ;test10.j(154)   do { write (i); i--; } while (61+0 <= i+0);
 382 acc16= variable 0
 383 call writeAcc16
 384 decr16 variable 0
 385 acc8= constant 61
 386 acc8+ constant 0
 387 <acc8
 388 acc16= variable 0
 389 acc16+ constant 0
 390 acc8= unstack8
 391 acc8CompareAcc16
 392 brle 382
 393 ;test10.j(155)   // integer - byte
 394 ;test10.j(156)   i=59;
 395 acc8= constant 59
 396 acc8=> variable 0
 397 ;test10.j(157)   b=60;
 398 acc8= constant 60
 399 acc8=> variable 4
 400 ;test10.j(158)   do { write (b); b--; } while (i+0 <= b+0);
 401 acc8= variable 4
 402 call writeAcc8
 403 decr8 variable 4
 404 acc16= variable 0
 405 acc16+ constant 0
 406 <acc16
 407 acc8= variable 4
 408 acc8+ constant 0
 409 acc16= unstack16
 410 acc16CompareAcc8
 411 brle 401
 412 ;test10.j(159)   // integer - integer
 413 ;test10.j(160)   i=1058;
 414 acc16= constant 1058
 415 acc16=> variable 0
 416 ;test10.j(161)   do { write (b); b--; i--; } while (1000+57 <= i+0);
 417 acc8= variable 4
 418 call writeAcc8
 419 decr8 variable 4
 420 decr16 variable 0
 421 acc16= constant 1000
 422 acc16+ constant 57
 423 <acc16
 424 acc16= variable 0
 425 acc16+ constant 0
 426 revAcc16Comp unstack16
 427 brge 417
 428 ;test10.j(162) 
 429 ;test10.j(163)   /************************/
 430 ;test10.j(164)   // acc - constant
 431 ;test10.j(165)   // byte - byte
 432 ;test10.j(166)   i=56;
 433 acc8= constant 56
 434 acc8=> variable 0
 435 ;test10.j(167)   b=56;
 436 acc8= constant 56
 437 acc8=> variable 4
 438 ;test10.j(168)   do { write (i); i--; b++; } while (b+0 <= 57);
 439 acc16= variable 0
 440 call writeAcc16
 441 decr16 variable 0
 442 incr8 variable 4
 443 acc8= variable 4
 444 acc8+ constant 0
 445 acc8Comp constant 57
 446 brle 439
 447 ;test10.j(169)   // byte - integer
 448 ;test10.j(170)   //not relevant
 449 ;test10.j(171)   // integer - byte
 450 ;test10.j(172)   i=54;
 451 acc8= constant 54
 452 acc8=> variable 0
 453 ;test10.j(173)   b=54;
 454 acc8= constant 54
 455 acc8=> variable 4
 456 ;test10.j(174)   do { write (b); b--; i++; } while (i+0 <= 55);
 457 acc8= variable 4
 458 call writeAcc8
 459 decr8 variable 4
 460 incr16 variable 0
 461 acc16= variable 0
 462 acc16+ constant 0
 463 acc8= constant 55
 464 acc16CompareAcc8
 465 brle 457
 466 ;test10.j(175)   i=1052;
 467 acc16= constant 1052
 468 acc16=> variable 0
 469 ;test10.j(176)   // integer - integer
 470 ;test10.j(177)   do { write (b); b--; i++; } while (i+0 <= 1053);
 471 acc8= variable 4
 472 call writeAcc8
 473 decr8 variable 4
 474 incr16 variable 0
 475 acc16= variable 0
 476 acc16+ constant 0
 477 acc16Comp constant 1053
 478 brle 471
 479 ;test10.j(178) 
 480 ;test10.j(179)   /************************/
 481 ;test10.j(180)   // constant - stack8
 482 ;test10.j(181)   // byte - byte
 483 ;test10.j(182)   //TODO
 484 ;test10.j(183)   write(50);
 485 acc8= constant 50
 486 call writeAcc8
 487 ;test10.j(184)   // constant - stack8
 488 ;test10.j(185)   // byte - integer
 489 ;test10.j(186)   //TODO
 490 ;test10.j(187)   write(49);
 491 acc8= constant 49
 492 call writeAcc8
 493 ;test10.j(188)   // constant - stack8
 494 ;test10.j(189)   // integer - byte
 495 ;test10.j(190)   //TODO
 496 ;test10.j(191)   write(48);
 497 acc8= constant 48
 498 call writeAcc8
 499 ;test10.j(192)   // constant - stack88
 500 ;test10.j(193)   // integer - integer
 501 ;test10.j(194)   //TODO
 502 ;test10.j(195)   write(47);
 503 acc8= constant 47
 504 call writeAcc8
 505 ;test10.j(196) 
 506 ;test10.j(197)   /************************/
 507 ;test10.j(198)   // constant - stack16
 508 ;test10.j(199)   // byte - byte
 509 ;test10.j(200)   //TODO
 510 ;test10.j(201)   write(46);
 511 acc8= constant 46
 512 call writeAcc8
 513 ;test10.j(202)   // constant - stack16
 514 ;test10.j(203)   // byte - integer
 515 ;test10.j(204)   //TODO
 516 ;test10.j(205)   write(45);
 517 acc8= constant 45
 518 call writeAcc8
 519 ;test10.j(206)   // constant - stack16
 520 ;test10.j(207)   // integer - byte
 521 ;test10.j(208)   //TODO
 522 ;test10.j(209)   write(44);
 523 acc8= constant 44
 524 call writeAcc8
 525 ;test10.j(210)   // constant - stack16
 526 ;test10.j(211)   // integer - integer
 527 ;test10.j(212)   //TODO
 528 ;test10.j(213)   write(43);
 529 acc8= constant 43
 530 call writeAcc8
 531 ;test10.j(214) 
 532 ;test10.j(215)   /************************/
 533 ;test10.j(216)   // constant - var
 534 ;test10.j(217)   // byte - byte
 535 ;test10.j(218)   b=42;
 536 acc8= constant 42
 537 acc8=> variable 4
 538 ;test10.j(219)   do { write (b); b--; } while (41 <= b);
 539 acc8= variable 4
 540 call writeAcc8
 541 decr8 variable 4
 542 acc8= variable 4
 543 acc8Comp constant 41
 544 brge 539
 545 ;test10.j(220) 
 546 ;test10.j(221)   // constant - var
 547 ;test10.j(222)   // byte - integer
 548 ;test10.j(223)   i=40;
 549 acc8= constant 40
 550 acc8=> variable 0
 551 ;test10.j(224)   do { write (i); i--; } while (39 <= i);
 552 acc16= variable 0
 553 call writeAcc16
 554 decr16 variable 0
 555 acc16= variable 0
 556 acc8= constant 39
 557 acc8CompareAcc16
 558 brle 552
 559 ;test10.j(225) 
 560 ;test10.j(226)   // constant - var
 561 ;test10.j(227)   // integer - byte
 562 ;test10.j(228)   // not relevant
 563 ;test10.j(229) 
 564 ;test10.j(230)   // constant - var
 565 ;test10.j(231)   // integer - integer
 566 ;test10.j(232)   i=1038;
 567 acc16= constant 1038
 568 acc16=> variable 0
 569 ;test10.j(233)   b=38;
 570 acc8= constant 38
 571 acc8=> variable 4
 572 ;test10.j(234)   do { write (b); b--; i--; } while (1037 <= i);
 573 acc8= variable 4
 574 call writeAcc8
 575 decr8 variable 4
 576 decr16 variable 0
 577 acc16= variable 0
 578 acc16Comp constant 1037
 579 brge 573
 580 ;test10.j(235) 
 581 ;test10.j(236)   /************************/
 582 ;test10.j(237)   // constant - acc
 583 ;test10.j(238)   // byte - byte
 584 ;test10.j(239)   b=36;
 585 acc8= constant 36
 586 acc8=> variable 4
 587 ;test10.j(240)   do { write (b); b--; } while (135 == b+100);
 588 acc8= variable 4
 589 call writeAcc8
 590 decr8 variable 4
 591 acc8= variable 4
 592 acc8+ constant 100
 593 acc8Comp constant 135
 594 breq 588
 595 ;test10.j(241)   do { write (b); b--; } while (132 != b+100);
 596 acc8= variable 4
 597 call writeAcc8
 598 decr8 variable 4
 599 acc8= variable 4
 600 acc8+ constant 100
 601 acc8Comp constant 132
 602 brne 596
 603 ;test10.j(242)   p=32;
 604 acc8= constant 32
 605 acc8=> variable 2
 606 ;test10.j(243)   do { write (p); p--; b++; } while (134 > b+100);
 607 acc16= variable 2
 608 call writeAcc16
 609 decr16 variable 2
 610 incr8 variable 4
 611 acc8= variable 4
 612 acc8+ constant 100
 613 acc8Comp constant 134
 614 brlt 607
 615 ;test10.j(244)   do { write (p); p--; b++; } while (135 >= b+100);
 616 acc16= variable 2
 617 call writeAcc16
 618 decr16 variable 2
 619 incr8 variable 4
 620 acc8= variable 4
 621 acc8+ constant 100
 622 acc8Comp constant 135
 623 brle 616
 624 ;test10.j(245)   b=28;
 625 acc8= constant 28
 626 acc8=> variable 4
 627 ;test10.j(246)   do { write (b); b--; } while (126 <  b+100);
 628 acc8= variable 4
 629 call writeAcc8
 630 decr8 variable 4
 631 acc8= variable 4
 632 acc8+ constant 100
 633 acc8Comp constant 126
 634 brgt 628
 635 ;test10.j(247)   do { write (b); b--; } while (125 <= b+100);
 636 acc8= variable 4
 637 call writeAcc8
 638 decr8 variable 4
 639 acc8= variable 4
 640 acc8+ constant 100
 641 acc8Comp constant 125
 642 brge 636
 643 ;test10.j(248)   // constant - acc
 644 ;test10.j(249)   // byte - integer
 645 ;test10.j(250)   i=24;
 646 acc8= constant 24
 647 acc8=> variable 0
 648 ;test10.j(251)   b=23;
 649 acc8= constant 23
 650 acc8=> variable 4
 651 ;test10.j(252)   do { write (i); i--; } while (23 == i+0);
 652 acc16= variable 0
 653 call writeAcc16
 654 decr16 variable 0
 655 acc16= variable 0
 656 acc16+ constant 0
 657 acc8= constant 23
 658 acc8CompareAcc16
 659 breq 652
 660 ;test10.j(253)   do { write (i); i--; } while (120 != i+100);
 661 acc16= variable 0
 662 call writeAcc16
 663 decr16 variable 0
 664 acc16= variable 0
 665 acc16+ constant 100
 666 acc8= constant 120
 667 acc8CompareAcc16
 668 brne 661
 669 ;test10.j(254)   p=20;
 670 acc8= constant 20
 671 acc8=> variable 2
 672 ;test10.j(255)   do { write (p); p--; i++; } while (122 > i+100);
 673 acc16= variable 2
 674 call writeAcc16
 675 decr16 variable 2
 676 incr16 variable 0
 677 acc16= variable 0
 678 acc16+ constant 100
 679 acc8= constant 122
 680 acc8CompareAcc16
 681 brgt 673
 682 ;test10.j(256)   do { write (p); p--; i++; } while (123 >= i+100);
 683 acc16= variable 2
 684 call writeAcc16
 685 decr16 variable 2
 686 incr16 variable 0
 687 acc16= variable 0
 688 acc16+ constant 100
 689 acc8= constant 123
 690 acc8CompareAcc16
 691 brge 683
 692 ;test10.j(257)   i=16;
 693 acc8= constant 16
 694 acc8=> variable 0
 695 ;test10.j(258)   do { write (i); i--; } while (114 <  i+100);
 696 acc16= variable 0
 697 call writeAcc16
 698 decr16 variable 0
 699 acc16= variable 0
 700 acc16+ constant 100
 701 acc8= constant 114
 702 acc8CompareAcc16
 703 brlt 696
 704 ;test10.j(259)   do { write (i); i--; } while (113 <= i+100);
 705 acc16= variable 0
 706 call writeAcc16
 707 decr16 variable 0
 708 acc16= variable 0
 709 acc16+ constant 100
 710 acc8= constant 113
 711 acc8CompareAcc16
 712 brle 705
 713 ;test10.j(260)   // constant - acc
 714 ;test10.j(261)   // integer - byte
 715 ;test10.j(262)   // not relevant
 716 ;test10.j(263) 
 717 ;test10.j(264)   // constant - acc
 718 ;test10.j(265)   // integer - integer
 719 ;test10.j(266)   i=12;
 720 acc8= constant 12
 721 acc8=> variable 0
 722 ;test10.j(267)   do { write (i); i--; } while (1011 == i+1000);
 723 acc16= variable 0
 724 call writeAcc16
 725 decr16 variable 0
 726 acc16= variable 0
 727 acc16+ constant 1000
 728 acc16Comp constant 1011
 729 breq 723
 730 ;test10.j(268)   //i=10
 731 ;test10.j(269)   do { write (i); i--; } while (1008 != i+1000);
 732 acc16= variable 0
 733 call writeAcc16
 734 decr16 variable 0
 735 acc16= variable 0
 736 acc16+ constant 1000
 737 acc16Comp constant 1008
 738 brne 732
 739 ;test10.j(270)   //i=8
 740 ;test10.j(271)   p=8;
 741 acc8= constant 8
 742 acc8=> variable 2
 743 ;test10.j(272)   do { write (p); p--; i++; } while (1010 > i+1000);
 744 acc16= variable 2
 745 call writeAcc16
 746 decr16 variable 2
 747 incr16 variable 0
 748 acc16= variable 0
 749 acc16+ constant 1000
 750 acc16Comp constant 1010
 751 brlt 744
 752 ;test10.j(273)   //i=10; p=6
 753 ;test10.j(274)   do { write (p); p--; i++; } while (1011 >= i+1000);
 754 acc16= variable 2
 755 call writeAcc16
 756 decr16 variable 2
 757 incr16 variable 0
 758 acc16= variable 0
 759 acc16+ constant 1000
 760 acc16Comp constant 1011
 761 brle 754
 762 ;test10.j(275)   i=4;
 763 acc8= constant 4
 764 acc8=> variable 0
 765 ;test10.j(276)   do { write (i); i--; } while (1002 <  i+1000);
 766 acc16= variable 0
 767 call writeAcc16
 768 decr16 variable 0
 769 acc16= variable 0
 770 acc16+ constant 1000
 771 acc16Comp constant 1002
 772 brgt 766
 773 ;test10.j(277)   //i=2;
 774 ;test10.j(278)   do { write (i); i--; } while (1001 <= i+1000);
 775 acc16= variable 0
 776 call writeAcc16
 777 decr16 variable 0
 778 acc16= variable 0
 779 acc16+ constant 1000
 780 acc16Comp constant 1001
 781 brge 775
 782 ;test10.j(279) 
 783 ;test10.j(280)   /************************/
 784 ;test10.j(281)   // constant - constant
 785 ;test10.j(282)   // not relevant
 786 ;test10.j(283)   write(0);
 787 acc8= constant 0
 788 call writeAcc8
 789 ;test10.j(284) }
 790 stop
