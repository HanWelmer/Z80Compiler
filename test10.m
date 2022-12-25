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
 119 acc8= constant 105
 120 acc8+ constant 0
 121 acc8Comp variable 4
 122 brge 115
 123 ;test10.j(63)   // byte - integer
 124 ;test10.j(64)   //not relevant
 125 ;test10.j(65)   i=103;
 126 acc8= constant 103
 127 acc8=> variable 0
 128 ;test10.j(66)   b=102;
 129 acc8= constant 102
 130 acc8=> variable 4
 131 ;test10.j(67)   do { write (b); b--; i=i-2; } while (b <= i+0);
 132 acc8= variable 4
 133 call writeAcc8
 134 decr8 variable 4
 135 acc16= variable 0
 136 acc16- constant 2
 137 acc16=> variable 0
 138 acc16= variable 0
 139 acc16+ constant 0
 140 acc8= variable 4
 141 acc8CompareAcc16
 142 brle 132
 143 ;test10.j(68)   // integer - byte
 144 ;test10.j(69)   i=100;
 145 acc8= constant 100
 146 acc8=> variable 0
 147 ;test10.j(70)   do { write (b); b--; i++; } while (i <= 101+0);
 148 acc8= variable 4
 149 call writeAcc8
 150 decr8 variable 4
 151 incr16 variable 0
 152 acc8= constant 101
 153 acc8+ constant 0
 154 acc16= variable 0
 155 acc16CompareAcc8
 156 brle 148
 157 ;test10.j(71)   // integer - integer
 158 ;test10.j(72)   i=1098;
 159 acc16= constant 1098
 160 acc16=> variable 0
 161 ;test10.j(73)   do { write (b); b--; i++; } while (i <= 1099+0);
 162 acc8= variable 4
 163 call writeAcc8
 164 decr8 variable 4
 165 incr16 variable 0
 166 acc16= constant 1099
 167 acc16+ constant 0
 168 acc16Comp variable 0
 169 brge 162
 170 ;test10.j(74) 
 171 ;test10.j(75)   /************************/
 172 ;test10.j(76)   // var - constant
 173 ;test10.j(77)   // byte - byte
 174 ;test10.j(78)   i=96;
 175 acc8= constant 96
 176 acc8=> variable 0
 177 ;test10.j(79)   b=96;
 178 acc8= constant 96
 179 acc8=> variable 4
 180 ;test10.j(80)   do { write (i); i--; b++; } while (b <= 97);
 181 acc16= variable 0
 182 call writeAcc16
 183 decr16 variable 0
 184 incr8 variable 4
 185 acc8= variable 4
 186 acc8Comp constant 97
 187 brle 181
 188 ;test10.j(81)   // byte - integer
 189 ;test10.j(82)   //not relevant
 190 ;test10.j(83)   write(94);
 191 acc8= constant 94
 192 call writeAcc8
 193 ;test10.j(84)   write(93);
 194 acc8= constant 93
 195 call writeAcc8
 196 ;test10.j(85)   // integer - byte
 197 ;test10.j(86)   i=92;
 198 acc8= constant 92
 199 acc8=> variable 0
 200 ;test10.j(87)   b=92;
 201 acc8= constant 92
 202 acc8=> variable 4
 203 ;test10.j(88)   do { write (b); b--; i++; } while (i <= 93);
 204 acc8= variable 4
 205 call writeAcc8
 206 decr8 variable 4
 207 incr16 variable 0
 208 acc16= variable 0
 209 acc8= constant 93
 210 acc16CompareAcc8
 211 brle 204
 212 ;test10.j(89)   // integer - integer
 213 ;test10.j(90)   i=1090;
 214 acc16= constant 1090
 215 acc16=> variable 0
 216 ;test10.j(91)   do { write (b); b--; i++; } while (i <= 1091);
 217 acc8= variable 4
 218 call writeAcc8
 219 decr8 variable 4
 220 incr16 variable 0
 221 acc16= variable 0
 222 acc16Comp constant 1091
 223 brle 217
 224 ;test10.j(92) 
 225 ;test10.j(93)   /************************/
 226 ;test10.j(94)   // acc - stack8
 227 ;test10.j(95)   // byte - byte
 228 ;test10.j(96)   //TODO
 229 ;test10.j(97)   write(88);
 230 acc8= constant 88
 231 call writeAcc8
 232 ;test10.j(98)   write(87);
 233 acc8= constant 87
 234 call writeAcc8
 235 ;test10.j(99)   // byte - integer
 236 ;test10.j(100)   //TODO
 237 ;test10.j(101)   write(86);
 238 acc8= constant 86
 239 call writeAcc8
 240 ;test10.j(102)   write(85);
 241 acc8= constant 85
 242 call writeAcc8
 243 ;test10.j(103)   // integer - byte
 244 ;test10.j(104)   //TODO
 245 ;test10.j(105)   write(84);
 246 acc8= constant 84
 247 call writeAcc8
 248 ;test10.j(106)   write(83);
 249 acc8= constant 83
 250 call writeAcc8
 251 ;test10.j(107)   // integer - integer
 252 ;test10.j(108)   //TODO
 253 ;test10.j(109)   write(82);
 254 acc8= constant 82
 255 call writeAcc8
 256 ;test10.j(110)   write(81);
 257 acc8= constant 81
 258 call writeAcc8
 259 ;test10.j(111) 
 260 ;test10.j(112)   /************************/
 261 ;test10.j(113)   // acc - stack16
 262 ;test10.j(114)   // byte - byte
 263 ;test10.j(115)   //TODO
 264 ;test10.j(116)   write(80);
 265 acc8= constant 80
 266 call writeAcc8
 267 ;test10.j(117)   write(79);
 268 acc8= constant 79
 269 call writeAcc8
 270 ;test10.j(118)   // byte - integer
 271 ;test10.j(119)   //TODO
 272 ;test10.j(120)   write(78);
 273 acc8= constant 78
 274 call writeAcc8
 275 ;test10.j(121)   write(77);
 276 acc8= constant 77
 277 call writeAcc8
 278 ;test10.j(122)   // integer - byte
 279 ;test10.j(123)   //TODO
 280 ;test10.j(124)   write(76);
 281 acc8= constant 76
 282 call writeAcc8
 283 ;test10.j(125)   write(75);
 284 acc8= constant 75
 285 call writeAcc8
 286 ;test10.j(126)   // integer - integer
 287 ;test10.j(127)   //TODO
 288 ;test10.j(128)   write(74);
 289 acc8= constant 74
 290 call writeAcc8
 291 ;test10.j(129)   write(73);
 292 acc8= constant 73
 293 call writeAcc8
 294 ;test10.j(130) 
 295 ;test10.j(131)   /************************/
 296 ;test10.j(132)   // acc - var
 297 ;test10.j(133)   // byte - byte
 298 ;test10.j(134)   b=72;
 299 acc8= constant 72
 300 acc8=> variable 4
 301 ;test10.j(135)   do { write (b); b--; } while (71+0 <= b);
 302 acc8= variable 4
 303 call writeAcc8
 304 decr8 variable 4
 305 acc8= constant 71
 306 acc8+ constant 0
 307 acc8Comp variable 4
 308 brle 302
 309 ;test10.j(136)   // byte - integer
 310 ;test10.j(137)   i=70;
 311 acc8= constant 70
 312 acc8=> variable 0
 313 ;test10.j(138)   do { write (i); i--; } while (69+0 <= i);
 314 acc16= variable 0
 315 call writeAcc16
 316 decr16 variable 0
 317 acc8= constant 69
 318 acc8+ constant 0
 319 acc16= variable 0
 320 acc8CompareAcc16
 321 brle 314
 322 ;test10.j(139)   // integer - byte
 323 ;test10.j(140)   i=67;
 324 acc8= constant 67
 325 acc8=> variable 0
 326 ;test10.j(141)   b=68;
 327 acc8= constant 68
 328 acc8=> variable 4
 329 ;test10.j(142)   do { write (b); b--; } while (i+0 <= b);
 330 acc8= variable 4
 331 call writeAcc8
 332 decr8 variable 4
 333 acc16= variable 0
 334 acc16+ constant 0
 335 acc8= variable 4
 336 acc16CompareAcc8
 337 brle 330
 338 ;test10.j(143)   // integer - integer
 339 ;test10.j(144)   i=1066;
 340 acc16= constant 1066
 341 acc16=> variable 0
 342 ;test10.j(145)   do { write (b); b--; i--; } while (1000+65 <= i);
 343 acc8= variable 4
 344 call writeAcc8
 345 decr8 variable 4
 346 decr16 variable 0
 347 acc16= constant 1000
 348 acc16+ constant 65
 349 acc16Comp variable 0
 350 brle 343
 351 ;test10.j(146) 
 352 ;test10.j(147)   /************************/
 353 ;test10.j(148)   // acc - acc
 354 ;test10.j(149)   // byte - byte
 355 ;test10.j(150)   b=64;
 356 acc8= constant 64
 357 acc8=> variable 4
 358 ;test10.j(151)   do { write (b); b--; } while (63+0 <= b+0);
 359 acc8= variable 4
 360 call writeAcc8
 361 decr8 variable 4
 362 acc8= constant 63
 363 acc8+ constant 0
 364 <acc8
 365 acc8= variable 4
 366 acc8+ constant 0
 367 revAcc8Comp unstack8
 368 brge 359
 369 ;test10.j(152)   // byte - integer
 370 ;test10.j(153)   i=62;
 371 acc8= constant 62
 372 acc8=> variable 0
 373 ;test10.j(154)   do { write (i); i--; } while (61+0 <= i+0);
 374 acc16= variable 0
 375 call writeAcc16
 376 decr16 variable 0
 377 acc8= constant 61
 378 acc8+ constant 0
 379 <acc8
 380 acc16= variable 0
 381 acc16+ constant 0
 382 acc8= unstack8
 383 acc8CompareAcc16
 384 brle 374
 385 ;test10.j(155)   // integer - byte
 386 ;test10.j(156)   i=59;
 387 acc8= constant 59
 388 acc8=> variable 0
 389 ;test10.j(157)   b=60;
 390 acc8= constant 60
 391 acc8=> variable 4
 392 ;test10.j(158)   do { write (b); b--; } while (i+0 <= b+0);
 393 acc8= variable 4
 394 call writeAcc8
 395 decr8 variable 4
 396 acc16= variable 0
 397 acc16+ constant 0
 398 <acc16
 399 acc8= variable 4
 400 acc8+ constant 0
 401 acc16= unstack16
 402 acc16CompareAcc8
 403 brle 393
 404 ;test10.j(159)   // integer - integer
 405 ;test10.j(160)   i=1058;
 406 acc16= constant 1058
 407 acc16=> variable 0
 408 ;test10.j(161)   do { write (b); b--; i--; } while (1000+57 <= i+0);
 409 acc8= variable 4
 410 call writeAcc8
 411 decr8 variable 4
 412 decr16 variable 0
 413 acc16= constant 1000
 414 acc16+ constant 57
 415 <acc16
 416 acc16= variable 0
 417 acc16+ constant 0
 418 revAcc16Comp unstack16
 419 brge 409
 420 ;test10.j(162) 
 421 ;test10.j(163)   /************************/
 422 ;test10.j(164)   // acc - constant
 423 ;test10.j(165)   // byte - byte
 424 ;test10.j(166)   i=56;
 425 acc8= constant 56
 426 acc8=> variable 0
 427 ;test10.j(167)   b=56;
 428 acc8= constant 56
 429 acc8=> variable 4
 430 ;test10.j(168)   do { write (i); i--; b++; } while (b+0 <= 57);
 431 acc16= variable 0
 432 call writeAcc16
 433 decr16 variable 0
 434 incr8 variable 4
 435 acc8= variable 4
 436 acc8+ constant 0
 437 acc8Comp constant 57
 438 brle 431
 439 ;test10.j(169)   // byte - integer
 440 ;test10.j(170)   //not relevant
 441 ;test10.j(171)   // integer - byte
 442 ;test10.j(172)   i=54;
 443 acc8= constant 54
 444 acc8=> variable 0
 445 ;test10.j(173)   b=54;
 446 acc8= constant 54
 447 acc8=> variable 4
 448 ;test10.j(174)   do { write (b); b--; i++; } while (i+0 <= 55);
 449 acc8= variable 4
 450 call writeAcc8
 451 decr8 variable 4
 452 incr16 variable 0
 453 acc16= variable 0
 454 acc16+ constant 0
 455 acc8= constant 55
 456 acc16CompareAcc8
 457 brle 449
 458 ;test10.j(175)   i=1052;
 459 acc16= constant 1052
 460 acc16=> variable 0
 461 ;test10.j(176)   // integer - integer
 462 ;test10.j(177)   do { write (b); b--; i++; } while (i+0 <= 1053);
 463 acc8= variable 4
 464 call writeAcc8
 465 decr8 variable 4
 466 incr16 variable 0
 467 acc16= variable 0
 468 acc16+ constant 0
 469 acc16Comp constant 1053
 470 brle 463
 471 ;test10.j(178) 
 472 ;test10.j(179)   /************************/
 473 ;test10.j(180)   // constant - stack8
 474 ;test10.j(181)   // byte - byte
 475 ;test10.j(182)   //TODO
 476 ;test10.j(183)   write(50);
 477 acc8= constant 50
 478 call writeAcc8
 479 ;test10.j(184)   // constant - stack8
 480 ;test10.j(185)   // byte - integer
 481 ;test10.j(186)   //TODO
 482 ;test10.j(187)   write(49);
 483 acc8= constant 49
 484 call writeAcc8
 485 ;test10.j(188)   // constant - stack8
 486 ;test10.j(189)   // integer - byte
 487 ;test10.j(190)   //TODO
 488 ;test10.j(191)   write(48);
 489 acc8= constant 48
 490 call writeAcc8
 491 ;test10.j(192)   // constant - stack88
 492 ;test10.j(193)   // integer - integer
 493 ;test10.j(194)   //TODO
 494 ;test10.j(195)   write(47);
 495 acc8= constant 47
 496 call writeAcc8
 497 ;test10.j(196) 
 498 ;test10.j(197)   /************************/
 499 ;test10.j(198)   // constant - stack16
 500 ;test10.j(199)   // byte - byte
 501 ;test10.j(200)   //TODO
 502 ;test10.j(201)   write(46);
 503 acc8= constant 46
 504 call writeAcc8
 505 ;test10.j(202)   // constant - stack16
 506 ;test10.j(203)   // byte - integer
 507 ;test10.j(204)   //TODO
 508 ;test10.j(205)   write(45);
 509 acc8= constant 45
 510 call writeAcc8
 511 ;test10.j(206)   // constant - stack16
 512 ;test10.j(207)   // integer - byte
 513 ;test10.j(208)   //TODO
 514 ;test10.j(209)   write(44);
 515 acc8= constant 44
 516 call writeAcc8
 517 ;test10.j(210)   // constant - stack16
 518 ;test10.j(211)   // integer - integer
 519 ;test10.j(212)   //TODO
 520 ;test10.j(213)   write(43);
 521 acc8= constant 43
 522 call writeAcc8
 523 ;test10.j(214) 
 524 ;test10.j(215)   /************************/
 525 ;test10.j(216)   // constant - var
 526 ;test10.j(217)   // byte - byte
 527 ;test10.j(218)   b=42;
 528 acc8= constant 42
 529 acc8=> variable 4
 530 ;test10.j(219)   do { write (b); b--; } while (41 <= b);
 531 acc8= variable 4
 532 call writeAcc8
 533 decr8 variable 4
 534 acc8= variable 4
 535 acc8Comp constant 41
 536 brge 531
 537 ;test10.j(220) 
 538 ;test10.j(221)   // constant - var
 539 ;test10.j(222)   // byte - integer
 540 ;test10.j(223)   i=40;
 541 acc8= constant 40
 542 acc8=> variable 0
 543 ;test10.j(224)   do { write (i); i--; } while (39 <= i);
 544 acc16= variable 0
 545 call writeAcc16
 546 decr16 variable 0
 547 acc16= variable 0
 548 acc8= constant 39
 549 acc8CompareAcc16
 550 brle 544
 551 ;test10.j(225) 
 552 ;test10.j(226)   // constant - var
 553 ;test10.j(227)   // integer - byte
 554 ;test10.j(228)   // not relevant
 555 ;test10.j(229) 
 556 ;test10.j(230)   // constant - var
 557 ;test10.j(231)   // integer - integer
 558 ;test10.j(232)   i=1038;
 559 acc16= constant 1038
 560 acc16=> variable 0
 561 ;test10.j(233)   b=38;
 562 acc8= constant 38
 563 acc8=> variable 4
 564 ;test10.j(234)   do { write (b); b--; i--; } while (1037 <= i);
 565 acc8= variable 4
 566 call writeAcc8
 567 decr8 variable 4
 568 decr16 variable 0
 569 acc16= variable 0
 570 acc16Comp constant 1037
 571 brge 565
 572 ;test10.j(235) 
 573 ;test10.j(236)   /************************/
 574 ;test10.j(237)   // constant - acc
 575 ;test10.j(238)   // byte - byte
 576 ;test10.j(239)   b=36;
 577 acc8= constant 36
 578 acc8=> variable 4
 579 ;test10.j(240)   do { write (b); b--; } while (135 == b+100);
 580 acc8= variable 4
 581 call writeAcc8
 582 decr8 variable 4
 583 acc8= variable 4
 584 acc8+ constant 100
 585 acc8Comp constant 135
 586 breq 580
 587 ;test10.j(241)   do { write (b); b--; } while (132 != b+100);
 588 acc8= variable 4
 589 call writeAcc8
 590 decr8 variable 4
 591 acc8= variable 4
 592 acc8+ constant 100
 593 acc8Comp constant 132
 594 brne 588
 595 ;test10.j(242)   p=32;
 596 acc8= constant 32
 597 acc8=> variable 2
 598 ;test10.j(243)   do { write (p); p--; b++; } while (134 > b+100);
 599 acc16= variable 2
 600 call writeAcc16
 601 decr16 variable 2
 602 incr8 variable 4
 603 acc8= variable 4
 604 acc8+ constant 100
 605 acc8Comp constant 134
 606 brlt 599
 607 ;test10.j(244)   do { write (p); p--; b++; } while (135 >= b+100);
 608 acc16= variable 2
 609 call writeAcc16
 610 decr16 variable 2
 611 incr8 variable 4
 612 acc8= variable 4
 613 acc8+ constant 100
 614 acc8Comp constant 135
 615 brle 608
 616 ;test10.j(245)   b=28;
 617 acc8= constant 28
 618 acc8=> variable 4
 619 ;test10.j(246)   do { write (b); b--; } while (126 <  b+100);
 620 acc8= variable 4
 621 call writeAcc8
 622 decr8 variable 4
 623 acc8= variable 4
 624 acc8+ constant 100
 625 acc8Comp constant 126
 626 brgt 620
 627 ;test10.j(247)   do { write (b); b--; } while (125 <= b+100);
 628 acc8= variable 4
 629 call writeAcc8
 630 decr8 variable 4
 631 acc8= variable 4
 632 acc8+ constant 100
 633 acc8Comp constant 125
 634 brge 628
 635 ;test10.j(248)   // constant - acc
 636 ;test10.j(249)   // byte - integer
 637 ;test10.j(250)   i=24;
 638 acc8= constant 24
 639 acc8=> variable 0
 640 ;test10.j(251)   b=23;
 641 acc8= constant 23
 642 acc8=> variable 4
 643 ;test10.j(252)   do { write (i); i--; } while (23 == i+0);
 644 acc16= variable 0
 645 call writeAcc16
 646 decr16 variable 0
 647 acc16= variable 0
 648 acc16+ constant 0
 649 acc8= constant 23
 650 acc8CompareAcc16
 651 breq 644
 652 ;test10.j(253)   do { write (i); i--; } while (120 != i+100);
 653 acc16= variable 0
 654 call writeAcc16
 655 decr16 variable 0
 656 acc16= variable 0
 657 acc16+ constant 100
 658 acc8= constant 120
 659 acc8CompareAcc16
 660 brne 653
 661 ;test10.j(254)   p=20;
 662 acc8= constant 20
 663 acc8=> variable 2
 664 ;test10.j(255)   do { write (p); p--; i++; } while (122 > i+100);
 665 acc16= variable 2
 666 call writeAcc16
 667 decr16 variable 2
 668 incr16 variable 0
 669 acc16= variable 0
 670 acc16+ constant 100
 671 acc8= constant 122
 672 acc8CompareAcc16
 673 brgt 665
 674 ;test10.j(256)   do { write (p); p--; i++; } while (123 >= i+100);
 675 acc16= variable 2
 676 call writeAcc16
 677 decr16 variable 2
 678 incr16 variable 0
 679 acc16= variable 0
 680 acc16+ constant 100
 681 acc8= constant 123
 682 acc8CompareAcc16
 683 brge 675
 684 ;test10.j(257)   i=16;
 685 acc8= constant 16
 686 acc8=> variable 0
 687 ;test10.j(258)   do { write (i); i--; } while (114 <  i+100);
 688 acc16= variable 0
 689 call writeAcc16
 690 decr16 variable 0
 691 acc16= variable 0
 692 acc16+ constant 100
 693 acc8= constant 114
 694 acc8CompareAcc16
 695 brlt 688
 696 ;test10.j(259)   do { write (i); i--; } while (113 <= i+100);
 697 acc16= variable 0
 698 call writeAcc16
 699 decr16 variable 0
 700 acc16= variable 0
 701 acc16+ constant 100
 702 acc8= constant 113
 703 acc8CompareAcc16
 704 brle 697
 705 ;test10.j(260)   // constant - acc
 706 ;test10.j(261)   // integer - byte
 707 ;test10.j(262)   // not relevant
 708 ;test10.j(263) 
 709 ;test10.j(264)   // constant - acc
 710 ;test10.j(265)   // integer - integer
 711 ;test10.j(266)   i=12;
 712 acc8= constant 12
 713 acc8=> variable 0
 714 ;test10.j(267)   do { write (i); i--; } while (1011 == i+1000);
 715 acc16= variable 0
 716 call writeAcc16
 717 decr16 variable 0
 718 acc16= variable 0
 719 acc16+ constant 1000
 720 acc16Comp constant 1011
 721 breq 715
 722 ;test10.j(268)   //i=10
 723 ;test10.j(269)   do { write (i); i--; } while (1008 != i+1000);
 724 acc16= variable 0
 725 call writeAcc16
 726 decr16 variable 0
 727 acc16= variable 0
 728 acc16+ constant 1000
 729 acc16Comp constant 1008
 730 brne 724
 731 ;test10.j(270)   //i=8
 732 ;test10.j(271)   p=8;
 733 acc8= constant 8
 734 acc8=> variable 2
 735 ;test10.j(272)   do { write (p); p--; i++; } while (1010 > i+1000);
 736 acc16= variable 2
 737 call writeAcc16
 738 decr16 variable 2
 739 incr16 variable 0
 740 acc16= variable 0
 741 acc16+ constant 1000
 742 acc16Comp constant 1010
 743 brlt 736
 744 ;test10.j(273)   //i=10; p=6
 745 ;test10.j(274)   do { write (p); p--; i++; } while (1011 >= i+1000);
 746 acc16= variable 2
 747 call writeAcc16
 748 decr16 variable 2
 749 incr16 variable 0
 750 acc16= variable 0
 751 acc16+ constant 1000
 752 acc16Comp constant 1011
 753 brle 746
 754 ;test10.j(275)   i=4;
 755 acc8= constant 4
 756 acc8=> variable 0
 757 ;test10.j(276)   do { write (i); i--; } while (1002 <  i+1000);
 758 acc16= variable 0
 759 call writeAcc16
 760 decr16 variable 0
 761 acc16= variable 0
 762 acc16+ constant 1000
 763 acc16Comp constant 1002
 764 brgt 758
 765 ;test10.j(277)   //i=2;
 766 ;test10.j(278)   do { write (i); i--; } while (1001 <= i+1000);
 767 acc16= variable 0
 768 call writeAcc16
 769 decr16 variable 0
 770 acc16= variable 0
 771 acc16+ constant 1000
 772 acc16Comp constant 1001
 773 brge 767
 774 ;test10.j(279) 
 775 ;test10.j(280)   /************************/
 776 ;test10.j(281)   // constant - constant
 777 ;test10.j(282)   // not relevant
 778 ;test10.j(283)   write(0);
 779 acc8= constant 0
 780 call writeAcc8
 781 ;test10.j(284) }
 782 stop
