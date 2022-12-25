   0 ;test10.j(0) /* Program to test generated Z80 assembler code */
   1 ;test10.j(1) class TestDo {
   2 ;test10.j(2)   byte b = 115;
   3 acc8= constant 115
   4 acc8=> variable 0
   5 ;test10.j(3)   
   6 ;test10.j(4)   /************************/
   7 ;test10.j(5)   // global variable within do scope
   8 ;test10.j(6)   write (b);
   9 acc8= variable 0
  10 call writeAcc8
  11 ;test10.j(7)   b--;
  12 decr8 variable 0
  13 ;test10.j(8)   do {
  14 ;test10.j(9)     int j = 1001;
  15 acc16= constant 1001
  16 acc16=> variable 1
  17 ;test10.j(10)     byte c = b;
  18 acc8= variable 0
  19 acc8=> variable 3
  20 ;test10.j(11)     byte d = c;
  21 acc8= variable 3
  22 acc8=> variable 4
  23 ;test10.j(12)     b--;
  24 decr8 variable 0
  25 ;test10.j(13)     write (c);
  26 acc8= variable 3
  27 call writeAcc8
  28 ;test10.j(14)   } while (b>112);
  29 acc8= variable 0
  30 acc8Comp constant 112
  31 brgt 14
  32 ;test10.j(15) 
  33 ;test10.j(16)   int i = 12;
  34 acc8= constant 12
  35 acc8=> variable 1
  36 ;test10.j(17)   int p = 12;
  37 acc8= constant 12
  38 acc8=> variable 3
  39 ;test10.j(18)   b = 24;
  40 acc8= constant 24
  41 acc8=> variable 0
  42 ;test10.j(19) 
  43 ;test10.j(20)   /************************/
  44 ;test10.j(21)   // stack8 - constant
  45 ;test10.j(22)   // stack8 - acc
  46 ;test10.j(23)   // stack8 - var
  47 ;test10.j(24)   // stack8 - stack8
  48 ;test10.j(25)   // stack8 - stack16
  49 ;test10.j(26)   //TODO
  50 ;test10.j(27) 
  51 ;test10.j(28)   /************************/
  52 ;test10.j(29)   // stack16 - constant
  53 ;test10.j(30)   // stack16 - acc
  54 ;test10.j(31)   // stack16 - var
  55 ;test10.j(32)   // stack16 - stack8
  56 ;test10.j(33)   // stack16 - stack16
  57 ;test10.j(34)   //TODO
  58 ;test10.j(35) 
  59 ;test10.j(36)   /************************/
  60 ;test10.j(37)   // var - stack16
  61 ;test10.j(38)   // byte - byte
  62 ;test10.j(39)   // byte - integer
  63 ;test10.j(40)   // integer - byte
  64 ;test10.j(41)   // integer - integer
  65 ;test10.j(42)   //TODO
  66 ;test10.j(43) 
  67 ;test10.j(44)   /************************/
  68 ;test10.j(45)   // var - stack8
  69 ;test10.j(46)   // byte - byte
  70 ;test10.j(47)   // byte - integer
  71 ;test10.j(48)   // integer - byte
  72 ;test10.j(49)   // integer - integer
  73 ;test10.j(50)   //TODO
  74 ;test10.j(51) 
  75 ;test10.j(52)   /************************/
  76 ;test10.j(53)   // var - var
  77 ;test10.j(54)   // byte - byte
  78 ;test10.j(55)   b=112;
  79 acc8= constant 112
  80 acc8=> variable 0
  81 ;test10.j(56)   byte b2 = 111;
  82 acc8= constant 111
  83 acc8=> variable 5
  84 ;test10.j(57)   do { write (b); b--; } while (b2 <= b);
  85 acc8= variable 0
  86 call writeAcc8
  87 decr8 variable 0
  88 acc8= variable 5
  89 acc8Comp variable 0
  90 brle 85
  91 ;test10.j(58)   // byte - integer
  92 ;test10.j(59)   i=110;
  93 acc8= constant 110
  94 acc8=> variable 1
  95 ;test10.j(60)   b2 = 109;
  96 acc8= constant 109
  97 acc8=> variable 5
  98 ;test10.j(61)   do { write (i); i--; } while (b2 <= i);
  99 acc16= variable 1
 100 call writeAcc16
 101 decr16 variable 1
 102 acc8= variable 5
 103 acc16= variable 1
 104 acc8CompareAcc16
 105 brle 99
 106 ;test10.j(62)   // integer - byte
 107 ;test10.j(63)   b=108;
 108 acc8= constant 108
 109 acc8=> variable 0
 110 ;test10.j(64)   i=107;
 111 acc8= constant 107
 112 acc8=> variable 1
 113 ;test10.j(65)   do { write (b); b--; } while (i <= b);
 114 acc8= variable 0
 115 call writeAcc8
 116 decr8 variable 0
 117 acc16= variable 1
 118 acc8= variable 0
 119 acc16CompareAcc8
 120 brle 114
 121 ;test10.j(66)   // integer - integer
 122 ;test10.j(67)   i=106;
 123 acc8= constant 106
 124 acc8=> variable 1
 125 ;test10.j(68)   int i2 = 105;
 126 acc8= constant 105
 127 acc8=> variable 6
 128 ;test10.j(69)   do { write (i); i--; } while (i2 <= i);
 129 acc16= variable 1
 130 call writeAcc16
 131 decr16 variable 1
 132 acc16= variable 6
 133 acc16Comp variable 1
 134 brle 129
 135 ;test10.j(70) 
 136 ;test10.j(71)   /************************/
 137 ;test10.j(72)   // var - acc
 138 ;test10.j(73)   // byte - byte
 139 ;test10.j(74)   i=104;
 140 acc8= constant 104
 141 acc8=> variable 1
 142 ;test10.j(75)   b=104;
 143 acc8= constant 104
 144 acc8=> variable 0
 145 ;test10.j(76)   do { write (i); i--; b++; } while (b <= 105+0);
 146 acc16= variable 1
 147 call writeAcc16
 148 decr16 variable 1
 149 incr8 variable 0
 150 acc8= constant 105
 151 acc8+ constant 0
 152 acc8Comp variable 0
 153 brge 146
 154 ;test10.j(77)   // byte - integer
 155 ;test10.j(78)   //not relevant
 156 ;test10.j(79)   i=103;
 157 acc8= constant 103
 158 acc8=> variable 1
 159 ;test10.j(80)   b=102;
 160 acc8= constant 102
 161 acc8=> variable 0
 162 ;test10.j(81)   do { write (b); b--; i=i-2; } while (b <= i+0);
 163 acc8= variable 0
 164 call writeAcc8
 165 decr8 variable 0
 166 acc16= variable 1
 167 acc16- constant 2
 168 acc16=> variable 1
 169 acc16= variable 1
 170 acc16+ constant 0
 171 acc8= variable 0
 172 acc8CompareAcc16
 173 brle 163
 174 ;test10.j(82)   // integer - byte
 175 ;test10.j(83)   i=100;
 176 acc8= constant 100
 177 acc8=> variable 1
 178 ;test10.j(84)   do { write (b); b--; i++; } while (i <= 101+0);
 179 acc8= variable 0
 180 call writeAcc8
 181 decr8 variable 0
 182 incr16 variable 1
 183 acc8= constant 101
 184 acc8+ constant 0
 185 acc16= variable 1
 186 acc16CompareAcc8
 187 brle 179
 188 ;test10.j(85)   // integer - integer
 189 ;test10.j(86)   i=1098;
 190 acc16= constant 1098
 191 acc16=> variable 1
 192 ;test10.j(87)   do { write (b); b--; i++; } while (i <= 1099+0);
 193 acc8= variable 0
 194 call writeAcc8
 195 decr8 variable 0
 196 incr16 variable 1
 197 acc16= constant 1099
 198 acc16+ constant 0
 199 acc16Comp variable 1
 200 brge 193
 201 ;test10.j(88) 
 202 ;test10.j(89)   /************************/
 203 ;test10.j(90)   // var - constant
 204 ;test10.j(91)   // byte - byte
 205 ;test10.j(92)   i=96;
 206 acc8= constant 96
 207 acc8=> variable 1
 208 ;test10.j(93)   b=96;
 209 acc8= constant 96
 210 acc8=> variable 0
 211 ;test10.j(94)   do { write (i); i--; b++; } while (b <= 97);
 212 acc16= variable 1
 213 call writeAcc16
 214 decr16 variable 1
 215 incr8 variable 0
 216 acc8= variable 0
 217 acc8Comp constant 97
 218 brle 212
 219 ;test10.j(95)   // byte - integer
 220 ;test10.j(96)   //not relevant
 221 ;test10.j(97)   write(94);
 222 acc8= constant 94
 223 call writeAcc8
 224 ;test10.j(98)   write(93);
 225 acc8= constant 93
 226 call writeAcc8
 227 ;test10.j(99)   // integer - byte
 228 ;test10.j(100)   i=92;
 229 acc8= constant 92
 230 acc8=> variable 1
 231 ;test10.j(101)   b=92;
 232 acc8= constant 92
 233 acc8=> variable 0
 234 ;test10.j(102)   do { write (b); b--; i++; } while (i <= 93);
 235 acc8= variable 0
 236 call writeAcc8
 237 decr8 variable 0
 238 incr16 variable 1
 239 acc16= variable 1
 240 acc8= constant 93
 241 acc16CompareAcc8
 242 brle 235
 243 ;test10.j(103)   // integer - integer
 244 ;test10.j(104)   i=1090;
 245 acc16= constant 1090
 246 acc16=> variable 1
 247 ;test10.j(105)   do { write (b); b--; i++; } while (i <= 1091);
 248 acc8= variable 0
 249 call writeAcc8
 250 decr8 variable 0
 251 incr16 variable 1
 252 acc16= variable 1
 253 acc16Comp constant 1091
 254 brle 248
 255 ;test10.j(106) 
 256 ;test10.j(107)   /************************/
 257 ;test10.j(108)   // acc - stack8
 258 ;test10.j(109)   // byte - byte
 259 ;test10.j(110)   //TODO
 260 ;test10.j(111)   write(88);
 261 acc8= constant 88
 262 call writeAcc8
 263 ;test10.j(112)   write(87);
 264 acc8= constant 87
 265 call writeAcc8
 266 ;test10.j(113)   // byte - integer
 267 ;test10.j(114)   //TODO
 268 ;test10.j(115)   write(86);
 269 acc8= constant 86
 270 call writeAcc8
 271 ;test10.j(116)   write(85);
 272 acc8= constant 85
 273 call writeAcc8
 274 ;test10.j(117)   // integer - byte
 275 ;test10.j(118)   //TODO
 276 ;test10.j(119)   write(84);
 277 acc8= constant 84
 278 call writeAcc8
 279 ;test10.j(120)   write(83);
 280 acc8= constant 83
 281 call writeAcc8
 282 ;test10.j(121)   // integer - integer
 283 ;test10.j(122)   //TODO
 284 ;test10.j(123)   write(82);
 285 acc8= constant 82
 286 call writeAcc8
 287 ;test10.j(124)   write(81);
 288 acc8= constant 81
 289 call writeAcc8
 290 ;test10.j(125) 
 291 ;test10.j(126)   /************************/
 292 ;test10.j(127)   // acc - stack16
 293 ;test10.j(128)   // byte - byte
 294 ;test10.j(129)   //TODO
 295 ;test10.j(130)   write(80);
 296 acc8= constant 80
 297 call writeAcc8
 298 ;test10.j(131)   write(79);
 299 acc8= constant 79
 300 call writeAcc8
 301 ;test10.j(132)   // byte - integer
 302 ;test10.j(133)   //TODO
 303 ;test10.j(134)   write(78);
 304 acc8= constant 78
 305 call writeAcc8
 306 ;test10.j(135)   write(77);
 307 acc8= constant 77
 308 call writeAcc8
 309 ;test10.j(136)   // integer - byte
 310 ;test10.j(137)   //TODO
 311 ;test10.j(138)   write(76);
 312 acc8= constant 76
 313 call writeAcc8
 314 ;test10.j(139)   write(75);
 315 acc8= constant 75
 316 call writeAcc8
 317 ;test10.j(140)   // integer - integer
 318 ;test10.j(141)   //TODO
 319 ;test10.j(142)   write(74);
 320 acc8= constant 74
 321 call writeAcc8
 322 ;test10.j(143)   write(73);
 323 acc8= constant 73
 324 call writeAcc8
 325 ;test10.j(144) 
 326 ;test10.j(145)   /************************/
 327 ;test10.j(146)   // acc - var
 328 ;test10.j(147)   // byte - byte
 329 ;test10.j(148)   b=72;
 330 acc8= constant 72
 331 acc8=> variable 0
 332 ;test10.j(149)   do { write (b); b--; } while (71+0 <= b);
 333 acc8= variable 0
 334 call writeAcc8
 335 decr8 variable 0
 336 acc8= constant 71
 337 acc8+ constant 0
 338 acc8Comp variable 0
 339 brle 333
 340 ;test10.j(150)   // byte - integer
 341 ;test10.j(151)   i=70;
 342 acc8= constant 70
 343 acc8=> variable 1
 344 ;test10.j(152)   do { write (i); i--; } while (69+0 <= i);
 345 acc16= variable 1
 346 call writeAcc16
 347 decr16 variable 1
 348 acc8= constant 69
 349 acc8+ constant 0
 350 acc16= variable 1
 351 acc8CompareAcc16
 352 brle 345
 353 ;test10.j(153)   // integer - byte
 354 ;test10.j(154)   i=67;
 355 acc8= constant 67
 356 acc8=> variable 1
 357 ;test10.j(155)   b=68;
 358 acc8= constant 68
 359 acc8=> variable 0
 360 ;test10.j(156)   do { write (b); b--; } while (i+0 <= b);
 361 acc8= variable 0
 362 call writeAcc8
 363 decr8 variable 0
 364 acc16= variable 1
 365 acc16+ constant 0
 366 acc8= variable 0
 367 acc16CompareAcc8
 368 brle 361
 369 ;test10.j(157)   // integer - integer
 370 ;test10.j(158)   i=1066;
 371 acc16= constant 1066
 372 acc16=> variable 1
 373 ;test10.j(159)   do { write (b); b--; i--; } while (1000+65 <= i);
 374 acc8= variable 0
 375 call writeAcc8
 376 decr8 variable 0
 377 decr16 variable 1
 378 acc16= constant 1000
 379 acc16+ constant 65
 380 acc16Comp variable 1
 381 brle 374
 382 ;test10.j(160) 
 383 ;test10.j(161)   /************************/
 384 ;test10.j(162)   // acc - acc
 385 ;test10.j(163)   // byte - byte
 386 ;test10.j(164)   b=64;
 387 acc8= constant 64
 388 acc8=> variable 0
 389 ;test10.j(165)   do { write (b); b--; } while (63+0 <= b+0);
 390 acc8= variable 0
 391 call writeAcc8
 392 decr8 variable 0
 393 acc8= constant 63
 394 acc8+ constant 0
 395 <acc8
 396 acc8= variable 0
 397 acc8+ constant 0
 398 revAcc8Comp unstack8
 399 brge 390
 400 ;test10.j(166)   // byte - integer
 401 ;test10.j(167)   i=62;
 402 acc8= constant 62
 403 acc8=> variable 1
 404 ;test10.j(168)   do { write (i); i--; } while (61+0 <= i+0);
 405 acc16= variable 1
 406 call writeAcc16
 407 decr16 variable 1
 408 acc8= constant 61
 409 acc8+ constant 0
 410 <acc8
 411 acc16= variable 1
 412 acc16+ constant 0
 413 acc8= unstack8
 414 acc8CompareAcc16
 415 brle 405
 416 ;test10.j(169)   // integer - byte
 417 ;test10.j(170)   i=59;
 418 acc8= constant 59
 419 acc8=> variable 1
 420 ;test10.j(171)   b=60;
 421 acc8= constant 60
 422 acc8=> variable 0
 423 ;test10.j(172)   do { write (b); b--; } while (i+0 <= b+0);
 424 acc8= variable 0
 425 call writeAcc8
 426 decr8 variable 0
 427 acc16= variable 1
 428 acc16+ constant 0
 429 <acc16
 430 acc8= variable 0
 431 acc8+ constant 0
 432 acc16= unstack16
 433 acc16CompareAcc8
 434 brle 424
 435 ;test10.j(173)   // integer - integer
 436 ;test10.j(174)   i=1058;
 437 acc16= constant 1058
 438 acc16=> variable 1
 439 ;test10.j(175)   do { write (b); b--; i--; } while (1000+57 <= i+0);
 440 acc8= variable 0
 441 call writeAcc8
 442 decr8 variable 0
 443 decr16 variable 1
 444 acc16= constant 1000
 445 acc16+ constant 57
 446 <acc16
 447 acc16= variable 1
 448 acc16+ constant 0
 449 revAcc16Comp unstack16
 450 brge 440
 451 ;test10.j(176) 
 452 ;test10.j(177)   /************************/
 453 ;test10.j(178)   // acc - constant
 454 ;test10.j(179)   // byte - byte
 455 ;test10.j(180)   i=56;
 456 acc8= constant 56
 457 acc8=> variable 1
 458 ;test10.j(181)   b=56;
 459 acc8= constant 56
 460 acc8=> variable 0
 461 ;test10.j(182)   do { write (i); i--; b++; } while (b+0 <= 57);
 462 acc16= variable 1
 463 call writeAcc16
 464 decr16 variable 1
 465 incr8 variable 0
 466 acc8= variable 0
 467 acc8+ constant 0
 468 acc8Comp constant 57
 469 brle 462
 470 ;test10.j(183)   // byte - integer
 471 ;test10.j(184)   //not relevant
 472 ;test10.j(185)   // integer - byte
 473 ;test10.j(186)   i=54;
 474 acc8= constant 54
 475 acc8=> variable 1
 476 ;test10.j(187)   b=54;
 477 acc8= constant 54
 478 acc8=> variable 0
 479 ;test10.j(188)   do { write (b); b--; i++; } while (i+0 <= 55);
 480 acc8= variable 0
 481 call writeAcc8
 482 decr8 variable 0
 483 incr16 variable 1
 484 acc16= variable 1
 485 acc16+ constant 0
 486 acc8= constant 55
 487 acc16CompareAcc8
 488 brle 480
 489 ;test10.j(189)   i=1052;
 490 acc16= constant 1052
 491 acc16=> variable 1
 492 ;test10.j(190)   // integer - integer
 493 ;test10.j(191)   do { write (b); b--; i++; } while (i+0 <= 1053);
 494 acc8= variable 0
 495 call writeAcc8
 496 decr8 variable 0
 497 incr16 variable 1
 498 acc16= variable 1
 499 acc16+ constant 0
 500 acc16Comp constant 1053
 501 brle 494
 502 ;test10.j(192) 
 503 ;test10.j(193)   /************************/
 504 ;test10.j(194)   // constant - stack8
 505 ;test10.j(195)   // byte - byte
 506 ;test10.j(196)   //TODO
 507 ;test10.j(197)   write(50);
 508 acc8= constant 50
 509 call writeAcc8
 510 ;test10.j(198)   // constant - stack8
 511 ;test10.j(199)   // byte - integer
 512 ;test10.j(200)   //TODO
 513 ;test10.j(201)   write(49);
 514 acc8= constant 49
 515 call writeAcc8
 516 ;test10.j(202)   // constant - stack8
 517 ;test10.j(203)   // integer - byte
 518 ;test10.j(204)   //TODO
 519 ;test10.j(205)   write(48);
 520 acc8= constant 48
 521 call writeAcc8
 522 ;test10.j(206)   // constant - stack88
 523 ;test10.j(207)   // integer - integer
 524 ;test10.j(208)   //TODO
 525 ;test10.j(209)   write(47);
 526 acc8= constant 47
 527 call writeAcc8
 528 ;test10.j(210) 
 529 ;test10.j(211)   /************************/
 530 ;test10.j(212)   // constant - stack16
 531 ;test10.j(213)   // byte - byte
 532 ;test10.j(214)   //TODO
 533 ;test10.j(215)   write(46);
 534 acc8= constant 46
 535 call writeAcc8
 536 ;test10.j(216)   // constant - stack16
 537 ;test10.j(217)   // byte - integer
 538 ;test10.j(218)   //TODO
 539 ;test10.j(219)   write(45);
 540 acc8= constant 45
 541 call writeAcc8
 542 ;test10.j(220)   // constant - stack16
 543 ;test10.j(221)   // integer - byte
 544 ;test10.j(222)   //TODO
 545 ;test10.j(223)   write(44);
 546 acc8= constant 44
 547 call writeAcc8
 548 ;test10.j(224)   // constant - stack16
 549 ;test10.j(225)   // integer - integer
 550 ;test10.j(226)   //TODO
 551 ;test10.j(227)   write(43);
 552 acc8= constant 43
 553 call writeAcc8
 554 ;test10.j(228) 
 555 ;test10.j(229)   /************************/
 556 ;test10.j(230)   // constant - var
 557 ;test10.j(231)   // byte - byte
 558 ;test10.j(232)   b=42;
 559 acc8= constant 42
 560 acc8=> variable 0
 561 ;test10.j(233)   do { write (b); b--; } while (41 <= b);
 562 acc8= variable 0
 563 call writeAcc8
 564 decr8 variable 0
 565 acc8= variable 0
 566 acc8Comp constant 41
 567 brge 562
 568 ;test10.j(234) 
 569 ;test10.j(235)   // constant - var
 570 ;test10.j(236)   // byte - integer
 571 ;test10.j(237)   i=40;
 572 acc8= constant 40
 573 acc8=> variable 1
 574 ;test10.j(238)   do { write (i); i--; } while (39 <= i);
 575 acc16= variable 1
 576 call writeAcc16
 577 decr16 variable 1
 578 acc16= variable 1
 579 acc8= constant 39
 580 acc8CompareAcc16
 581 brle 575
 582 ;test10.j(239) 
 583 ;test10.j(240)   // constant - var
 584 ;test10.j(241)   // integer - byte
 585 ;test10.j(242)   // not relevant
 586 ;test10.j(243) 
 587 ;test10.j(244)   // constant - var
 588 ;test10.j(245)   // integer - integer
 589 ;test10.j(246)   i=1038;
 590 acc16= constant 1038
 591 acc16=> variable 1
 592 ;test10.j(247)   b=38;
 593 acc8= constant 38
 594 acc8=> variable 0
 595 ;test10.j(248)   do { write (b); b--; i--; } while (1037 <= i);
 596 acc8= variable 0
 597 call writeAcc8
 598 decr8 variable 0
 599 decr16 variable 1
 600 acc16= variable 1
 601 acc16Comp constant 1037
 602 brge 596
 603 ;test10.j(249) 
 604 ;test10.j(250)   /************************/
 605 ;test10.j(251)   // constant - acc
 606 ;test10.j(252)   // byte - byte
 607 ;test10.j(253)   b=36;
 608 acc8= constant 36
 609 acc8=> variable 0
 610 ;test10.j(254)   do { write (b); b--; } while (135 == b+100);
 611 acc8= variable 0
 612 call writeAcc8
 613 decr8 variable 0
 614 acc8= variable 0
 615 acc8+ constant 100
 616 acc8Comp constant 135
 617 breq 611
 618 ;test10.j(255)   do { write (b); b--; } while (132 != b+100);
 619 acc8= variable 0
 620 call writeAcc8
 621 decr8 variable 0
 622 acc8= variable 0
 623 acc8+ constant 100
 624 acc8Comp constant 132
 625 brne 619
 626 ;test10.j(256)   p=32;
 627 acc8= constant 32
 628 acc8=> variable 3
 629 ;test10.j(257)   do { write (p); p--; b++; } while (134 > b+100);
 630 acc16= variable 3
 631 call writeAcc16
 632 decr16 variable 3
 633 incr8 variable 0
 634 acc8= variable 0
 635 acc8+ constant 100
 636 acc8Comp constant 134
 637 brlt 630
 638 ;test10.j(258)   do { write (p); p--; b++; } while (135 >= b+100);
 639 acc16= variable 3
 640 call writeAcc16
 641 decr16 variable 3
 642 incr8 variable 0
 643 acc8= variable 0
 644 acc8+ constant 100
 645 acc8Comp constant 135
 646 brle 639
 647 ;test10.j(259)   b=28;
 648 acc8= constant 28
 649 acc8=> variable 0
 650 ;test10.j(260)   do { write (b); b--; } while (126 <  b+100);
 651 acc8= variable 0
 652 call writeAcc8
 653 decr8 variable 0
 654 acc8= variable 0
 655 acc8+ constant 100
 656 acc8Comp constant 126
 657 brgt 651
 658 ;test10.j(261)   do { write (b); b--; } while (125 <= b+100);
 659 acc8= variable 0
 660 call writeAcc8
 661 decr8 variable 0
 662 acc8= variable 0
 663 acc8+ constant 100
 664 acc8Comp constant 125
 665 brge 659
 666 ;test10.j(262)   // constant - acc
 667 ;test10.j(263)   // byte - integer
 668 ;test10.j(264)   i=24;
 669 acc8= constant 24
 670 acc8=> variable 1
 671 ;test10.j(265)   b=23;
 672 acc8= constant 23
 673 acc8=> variable 0
 674 ;test10.j(266)   do { write (i); i--; } while (23 == i+0);
 675 acc16= variable 1
 676 call writeAcc16
 677 decr16 variable 1
 678 acc16= variable 1
 679 acc16+ constant 0
 680 acc8= constant 23
 681 acc8CompareAcc16
 682 breq 675
 683 ;test10.j(267)   do { write (i); i--; } while (120 != i+100);
 684 acc16= variable 1
 685 call writeAcc16
 686 decr16 variable 1
 687 acc16= variable 1
 688 acc16+ constant 100
 689 acc8= constant 120
 690 acc8CompareAcc16
 691 brne 684
 692 ;test10.j(268)   p=20;
 693 acc8= constant 20
 694 acc8=> variable 3
 695 ;test10.j(269)   do { write (p); p--; i++; } while (122 > i+100);
 696 acc16= variable 3
 697 call writeAcc16
 698 decr16 variable 3
 699 incr16 variable 1
 700 acc16= variable 1
 701 acc16+ constant 100
 702 acc8= constant 122
 703 acc8CompareAcc16
 704 brgt 696
 705 ;test10.j(270)   do { write (p); p--; i++; } while (123 >= i+100);
 706 acc16= variable 3
 707 call writeAcc16
 708 decr16 variable 3
 709 incr16 variable 1
 710 acc16= variable 1
 711 acc16+ constant 100
 712 acc8= constant 123
 713 acc8CompareAcc16
 714 brge 706
 715 ;test10.j(271)   i=16;
 716 acc8= constant 16
 717 acc8=> variable 1
 718 ;test10.j(272)   do { write (i); i--; } while (114 <  i+100);
 719 acc16= variable 1
 720 call writeAcc16
 721 decr16 variable 1
 722 acc16= variable 1
 723 acc16+ constant 100
 724 acc8= constant 114
 725 acc8CompareAcc16
 726 brlt 719
 727 ;test10.j(273)   do { write (i); i--; } while (113 <= i+100);
 728 acc16= variable 1
 729 call writeAcc16
 730 decr16 variable 1
 731 acc16= variable 1
 732 acc16+ constant 100
 733 acc8= constant 113
 734 acc8CompareAcc16
 735 brle 728
 736 ;test10.j(274)   // constant - acc
 737 ;test10.j(275)   // integer - byte
 738 ;test10.j(276)   // not relevant
 739 ;test10.j(277) 
 740 ;test10.j(278)   // constant - acc
 741 ;test10.j(279)   // integer - integer
 742 ;test10.j(280)   i=12;
 743 acc8= constant 12
 744 acc8=> variable 1
 745 ;test10.j(281)   do { write (i); i--; } while (1011 == i+1000);
 746 acc16= variable 1
 747 call writeAcc16
 748 decr16 variable 1
 749 acc16= variable 1
 750 acc16+ constant 1000
 751 acc16Comp constant 1011
 752 breq 746
 753 ;test10.j(282)   //i=10
 754 ;test10.j(283)   do { write (i); i--; } while (1008 != i+1000);
 755 acc16= variable 1
 756 call writeAcc16
 757 decr16 variable 1
 758 acc16= variable 1
 759 acc16+ constant 1000
 760 acc16Comp constant 1008
 761 brne 755
 762 ;test10.j(284)   //i=8
 763 ;test10.j(285)   p=8;
 764 acc8= constant 8
 765 acc8=> variable 3
 766 ;test10.j(286)   do { write (p); p--; i++; } while (1010 > i+1000);
 767 acc16= variable 3
 768 call writeAcc16
 769 decr16 variable 3
 770 incr16 variable 1
 771 acc16= variable 1
 772 acc16+ constant 1000
 773 acc16Comp constant 1010
 774 brlt 767
 775 ;test10.j(287)   //i=10; p=6
 776 ;test10.j(288)   do { write (p); p--; i++; } while (1011 >= i+1000);
 777 acc16= variable 3
 778 call writeAcc16
 779 decr16 variable 3
 780 incr16 variable 1
 781 acc16= variable 1
 782 acc16+ constant 1000
 783 acc16Comp constant 1011
 784 brle 777
 785 ;test10.j(289)   i=4;
 786 acc8= constant 4
 787 acc8=> variable 1
 788 ;test10.j(290)   do { write (i); i--; } while (1002 <  i+1000);
 789 acc16= variable 1
 790 call writeAcc16
 791 decr16 variable 1
 792 acc16= variable 1
 793 acc16+ constant 1000
 794 acc16Comp constant 1002
 795 brgt 789
 796 ;test10.j(291)   //i=2;
 797 ;test10.j(292)   do { write (i); i--; } while (1001 <= i+1000);
 798 acc16= variable 1
 799 call writeAcc16
 800 decr16 variable 1
 801 acc16= variable 1
 802 acc16+ constant 1000
 803 acc16Comp constant 1001
 804 brge 798
 805 ;test10.j(293) 
 806 ;test10.j(294)   /************************/
 807 ;test10.j(295)   // constant - constant
 808 ;test10.j(296)   // not relevant
 809 ;test10.j(297)   write(0);
 810 acc8= constant 0
 811 call writeAcc8
 812 ;test10.j(298) }
 813 stop
