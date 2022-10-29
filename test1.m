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
 113 acc8= variable 6
 114 <acc8
 115 acc8= constant 105
 116 acc8+ constant 0
 117 revAcc8Comp unstack8
 118 brlt 126
 119 acc16= variable 0
 120 call writeAcc16
 121 decr16 variable 0
 122 incr8 variable 6
 123 br 113
 124 ;test1.j(61)   // byte - integer
 125 ;test1.j(62)   i=103;
 126 acc8= constant 103
 127 acc8=> variable 0
 128 ;test1.j(63)   b=102;
 129 acc8= constant 102
 130 acc8=> variable 6
 131 ;test1.j(64)   while (b <= i+0) { write (b); b--; i=i-2; }
 132 acc8= variable 6
 133 <acc8
 134 acc16= variable 0
 135 acc16+ constant 0
 136 acc8= unstack8
 137 acc8CompareAcc16
 138 brgt 148
 139 acc8= variable 6
 140 call writeAcc8
 141 decr8 variable 6
 142 acc16= variable 0
 143 acc16- constant 2
 144 acc16=> variable 0
 145 br 132
 146 ;test1.j(65)   // integer - byte
 147 ;test1.j(66)   i=100;
 148 acc8= constant 100
 149 acc8=> variable 0
 150 ;test1.j(67)   while (i <= 101+0) { write (b); b--; i++; }
 151 acc16= variable 0
 152 <acc16
 153 acc8= constant 101
 154 acc8+ constant 0
 155 acc16= unstack16
 156 acc16CompareAcc8
 157 brgt 165
 158 acc8= variable 6
 159 call writeAcc8
 160 decr8 variable 6
 161 incr16 variable 0
 162 br 151
 163 ;test1.j(68)   // integer - integer
 164 ;test1.j(69)   i=1098;
 165 acc16= constant 1098
 166 acc16=> variable 0
 167 ;test1.j(70)   while (i <= 1099+0) { write (b); b--; i++; }
 168 acc16= variable 0
 169 <acc16
 170 acc16= constant 1099
 171 acc16+ constant 0
 172 revAcc16Comp unstack16
 173 brlt 184
 174 acc8= variable 6
 175 call writeAcc8
 176 decr8 variable 6
 177 incr16 variable 0
 178 br 168
 179 ;test1.j(71) 
 180 ;test1.j(72)   /************************/
 181 ;test1.j(73)   // var - constant
 182 ;test1.j(74)   // byte - byte
 183 ;test1.j(75)   i=96;
 184 acc8= constant 96
 185 acc8=> variable 0
 186 ;test1.j(76)   b=96;
 187 acc8= constant 96
 188 acc8=> variable 6
 189 ;test1.j(77)   while (b <= 97) { write (i); i--; b++; }
 190 acc8= variable 6
 191 acc8Comp constant 97
 192 brgt 201
 193 acc16= variable 0
 194 call writeAcc16
 195 decr16 variable 0
 196 incr8 variable 6
 197 br 190
 198 ;test1.j(78)   // byte - integer
 199 ;test1.j(79)   //not relevant
 200 ;test1.j(80)   write(94);
 201 acc8= constant 94
 202 call writeAcc8
 203 ;test1.j(81)   write(93);
 204 acc8= constant 93
 205 call writeAcc8
 206 ;test1.j(82)   // integer - byte
 207 ;test1.j(83)   i=92;
 208 acc8= constant 92
 209 acc8=> variable 0
 210 ;test1.j(84)   b=92;
 211 acc8= constant 92
 212 acc8=> variable 6
 213 ;test1.j(85)   while (i <= 93) { write (b); b--; i++; }
 214 acc16= variable 0
 215 acc8= constant 93
 216 acc16CompareAcc8
 217 brgt 225
 218 acc8= variable 6
 219 call writeAcc8
 220 decr8 variable 6
 221 incr16 variable 0
 222 br 214
 223 ;test1.j(86)   // integer - integer
 224 ;test1.j(87)   i=1090;
 225 acc16= constant 1090
 226 acc16=> variable 0
 227 ;test1.j(88)   while (i <= 1091) { write (b); b--; i++; }
 228 acc16= variable 0
 229 acc16Comp constant 1091
 230 brgt 242
 231 acc8= variable 6
 232 call writeAcc8
 233 decr8 variable 6
 234 incr16 variable 0
 235 br 228
 236 ;test1.j(89) 
 237 ;test1.j(90)   /************************/
 238 ;test1.j(91)   // acc - stack8
 239 ;test1.j(92)   // byte - byte
 240 ;test1.j(93)   //TODO
 241 ;test1.j(94)   write(88);
 242 acc8= constant 88
 243 call writeAcc8
 244 ;test1.j(95)   write(87);
 245 acc8= constant 87
 246 call writeAcc8
 247 ;test1.j(96)   // byte - integer
 248 ;test1.j(97)   //TODO
 249 ;test1.j(98)   write(86);
 250 acc8= constant 86
 251 call writeAcc8
 252 ;test1.j(99)   write(85);
 253 acc8= constant 85
 254 call writeAcc8
 255 ;test1.j(100)   // integer - byte
 256 ;test1.j(101)   //TODO
 257 ;test1.j(102)   write(84);
 258 acc8= constant 84
 259 call writeAcc8
 260 ;test1.j(103)   write(83);
 261 acc8= constant 83
 262 call writeAcc8
 263 ;test1.j(104)   // integer - integer
 264 ;test1.j(105)   //TODO
 265 ;test1.j(106)   write(82);
 266 acc8= constant 82
 267 call writeAcc8
 268 ;test1.j(107)   write(81);
 269 acc8= constant 81
 270 call writeAcc8
 271 ;test1.j(108) 
 272 ;test1.j(109)   /************************/
 273 ;test1.j(110)   // acc - stack16
 274 ;test1.j(111)   // byte - byte
 275 ;test1.j(112)   //TODO
 276 ;test1.j(113)   write(80);
 277 acc8= constant 80
 278 call writeAcc8
 279 ;test1.j(114)   write(79);
 280 acc8= constant 79
 281 call writeAcc8
 282 ;test1.j(115)   // byte - integer
 283 ;test1.j(116)   //TODO
 284 ;test1.j(117)   write(78);
 285 acc8= constant 78
 286 call writeAcc8
 287 ;test1.j(118)   write(77);
 288 acc8= constant 77
 289 call writeAcc8
 290 ;test1.j(119)   // integer - byte
 291 ;test1.j(120)   //TODO
 292 ;test1.j(121)   write(76);
 293 acc8= constant 76
 294 call writeAcc8
 295 ;test1.j(122)   write(75);
 296 acc8= constant 75
 297 call writeAcc8
 298 ;test1.j(123)   // integer - integer
 299 ;test1.j(124)   //TODO
 300 ;test1.j(125)   write(74);
 301 acc8= constant 74
 302 call writeAcc8
 303 ;test1.j(126)   write(73);
 304 acc8= constant 73
 305 call writeAcc8
 306 ;test1.j(127) 
 307 ;test1.j(128)   /************************/
 308 ;test1.j(129)   // acc - var
 309 ;test1.j(130)   // byte - byte
 310 ;test1.j(131)   b=72;
 311 acc8= constant 72
 312 acc8=> variable 6
 313 ;test1.j(132)   while (71+0 <= b) { write (b); b--; }
 314 acc8= constant 71
 315 acc8+ constant 0
 316 acc8Comp variable 6
 317 brgt 324
 318 acc8= variable 6
 319 call writeAcc8
 320 decr8 variable 6
 321 br 314
 322 ;test1.j(133)   // byte - integer
 323 ;test1.j(134)   i=70;
 324 acc8= constant 70
 325 acc8=> variable 0
 326 ;test1.j(135)   while (69+0 <= i) { write (i); i--; }
 327 acc8= constant 69
 328 acc8+ constant 0
 329 acc16= variable 0
 330 acc8CompareAcc16
 331 brgt 338
 332 acc16= variable 0
 333 call writeAcc16
 334 decr16 variable 0
 335 br 327
 336 ;test1.j(136)   // integer - byte
 337 ;test1.j(137)   i=67;
 338 acc8= constant 67
 339 acc8=> variable 0
 340 ;test1.j(138)   b=68;
 341 acc8= constant 68
 342 acc8=> variable 6
 343 ;test1.j(139)   while (i+0 <= b) { write (b); b--; } 
 344 acc16= variable 0
 345 acc16+ constant 0
 346 acc8= variable 6
 347 acc16CompareAcc8
 348 brgt 355
 349 acc8= variable 6
 350 call writeAcc8
 351 decr8 variable 6
 352 br 344
 353 ;test1.j(140)   // integer - integer
 354 ;test1.j(141)   i=1066;
 355 acc16= constant 1066
 356 acc16=> variable 0
 357 ;test1.j(142)   while (1000+65 <= i) { write (b); b--; i--; }
 358 acc16= constant 1000
 359 acc16+ constant 65
 360 acc16Comp variable 0
 361 brgt 372
 362 acc8= variable 6
 363 call writeAcc8
 364 decr8 variable 6
 365 decr16 variable 0
 366 br 358
 367 ;test1.j(143) 
 368 ;test1.j(144)   /************************/
 369 ;test1.j(145)   // acc - acc
 370 ;test1.j(146)   // byte - byte
 371 ;test1.j(147)   b=64;
 372 acc8= constant 64
 373 acc8=> variable 6
 374 ;test1.j(148)   while (63+0 <= b+0) { write (b); b--; }
 375 acc8= constant 63
 376 acc8+ constant 0
 377 <acc8
 378 acc8= variable 6
 379 acc8+ constant 0
 380 revAcc8Comp unstack8
 381 brlt 388
 382 acc8= variable 6
 383 call writeAcc8
 384 decr8 variable 6
 385 br 375
 386 ;test1.j(149)   // byte - integer
 387 ;test1.j(150)   i=62;
 388 acc8= constant 62
 389 acc8=> variable 0
 390 ;test1.j(151)   while (61+0 <= i+0) { write (i); i--; }
 391 acc8= constant 61
 392 acc8+ constant 0
 393 <acc8
 394 acc16= variable 0
 395 acc16+ constant 0
 396 acc8= unstack8
 397 acc8CompareAcc16
 398 brgt 405
 399 acc16= variable 0
 400 call writeAcc16
 401 decr16 variable 0
 402 br 391
 403 ;test1.j(152)   // integer - byte
 404 ;test1.j(153)   i=59;
 405 acc8= constant 59
 406 acc8=> variable 0
 407 ;test1.j(154)   b=60;
 408 acc8= constant 60
 409 acc8=> variable 6
 410 ;test1.j(155)   while (i+0 <= b+0) { write (b); b--; }
 411 acc16= variable 0
 412 acc16+ constant 0
 413 <acc16
 414 acc8= variable 6
 415 acc8+ constant 0
 416 acc16= unstack16
 417 acc16CompareAcc8
 418 brgt 425
 419 acc8= variable 6
 420 call writeAcc8
 421 decr8 variable 6
 422 br 411
 423 ;test1.j(156)   // integer - integer
 424 ;test1.j(157)   i=1058;
 425 acc16= constant 1058
 426 acc16=> variable 0
 427 ;test1.j(158)   while (1000+57 <= i+0) { write (b); b--; i--; }
 428 acc16= constant 1000
 429 acc16+ constant 57
 430 <acc16
 431 acc16= variable 0
 432 acc16+ constant 0
 433 revAcc16Comp unstack16
 434 brlt 445
 435 acc8= variable 6
 436 call writeAcc8
 437 decr8 variable 6
 438 decr16 variable 0
 439 br 428
 440 ;test1.j(159) 
 441 ;test1.j(160)   /************************/
 442 ;test1.j(161)   // acc - constant
 443 ;test1.j(162)   // byte - byte
 444 ;test1.j(163)   i=56;
 445 acc8= constant 56
 446 acc8=> variable 0
 447 ;test1.j(164)   b=56;
 448 acc8= constant 56
 449 acc8=> variable 6
 450 ;test1.j(165)   while (b+0 <= 57) { write (i); i--; b++; }
 451 acc8= variable 6
 452 acc8+ constant 0
 453 acc8Comp constant 57
 454 brgt 464
 455 acc16= variable 0
 456 call writeAcc16
 457 decr16 variable 0
 458 incr8 variable 6
 459 br 451
 460 ;test1.j(166)   // byte - integer
 461 ;test1.j(167)   //not relevant
 462 ;test1.j(168)   // integer - byte
 463 ;test1.j(169)   i=54;
 464 acc8= constant 54
 465 acc8=> variable 0
 466 ;test1.j(170)   b=54;
 467 acc8= constant 54
 468 acc8=> variable 6
 469 ;test1.j(171)   while (i+0 <= 55) { write (b); b--; i++; }
 470 acc16= variable 0
 471 acc16+ constant 0
 472 acc8= constant 55
 473 acc16CompareAcc8
 474 brgt 481
 475 acc8= variable 6
 476 call writeAcc8
 477 decr8 variable 6
 478 incr16 variable 0
 479 br 470
 480 ;test1.j(172)   i=1052;
 481 acc16= constant 1052
 482 acc16=> variable 0
 483 ;test1.j(173)   // integer - integer
 484 ;test1.j(174)   while (i+0 <= 1053) { write (b); b--; i++; }
 485 acc16= variable 0
 486 acc16+ constant 0
 487 acc16Comp constant 1053
 488 brgt 500
 489 acc8= variable 6
 490 call writeAcc8
 491 decr8 variable 6
 492 incr16 variable 0
 493 br 485
 494 ;test1.j(175) 
 495 ;test1.j(176)   /************************/
 496 ;test1.j(177)   // constant - stack8
 497 ;test1.j(178)   // byte - byte
 498 ;test1.j(179)   //TODO
 499 ;test1.j(180)   write(50);
 500 acc8= constant 50
 501 call writeAcc8
 502 ;test1.j(181)   // constant - stack8
 503 ;test1.j(182)   // byte - integer
 504 ;test1.j(183)   //TODO
 505 ;test1.j(184)   write(49);
 506 acc8= constant 49
 507 call writeAcc8
 508 ;test1.j(185)   // constant - stack8
 509 ;test1.j(186)   // integer - byte
 510 ;test1.j(187)   //TODO
 511 ;test1.j(188)   write(48);
 512 acc8= constant 48
 513 call writeAcc8
 514 ;test1.j(189)   // constant - stack88
 515 ;test1.j(190)   // integer - integer
 516 ;test1.j(191)   //TODO
 517 ;test1.j(192)   write(47);
 518 acc8= constant 47
 519 call writeAcc8
 520 ;test1.j(193) 
 521 ;test1.j(194)   /************************/
 522 ;test1.j(195)   // constant - stack16
 523 ;test1.j(196)   // byte - byte
 524 ;test1.j(197)   //TODO
 525 ;test1.j(198)   write(46);
 526 acc8= constant 46
 527 call writeAcc8
 528 ;test1.j(199)   // constant - stack16
 529 ;test1.j(200)   // byte - integer
 530 ;test1.j(201)   //TODO
 531 ;test1.j(202)   write(45);
 532 acc8= constant 45
 533 call writeAcc8
 534 ;test1.j(203)   // constant - stack16
 535 ;test1.j(204)   // integer - byte
 536 ;test1.j(205)   //TODO
 537 ;test1.j(206)   write(44);
 538 acc8= constant 44
 539 call writeAcc8
 540 ;test1.j(207)   // constant - stack16
 541 ;test1.j(208)   // integer - integer
 542 ;test1.j(209)   //TODO
 543 ;test1.j(210)   write(43);
 544 acc8= constant 43
 545 call writeAcc8
 546 ;test1.j(211) 
 547 ;test1.j(212)   /************************/
 548 ;test1.j(213)   // constant - var
 549 ;test1.j(214)   // byte - byte
 550 ;test1.j(215)   b=42;
 551 acc8= constant 42
 552 acc8=> variable 6
 553 ;test1.j(216)   while (41 <= b) { write (b); b--; }
 554 acc8= variable 6
 555 acc8Comp constant 41
 556 brlt 565
 557 acc8= variable 6
 558 call writeAcc8
 559 decr8 variable 6
 560 br 554
 561 ;test1.j(217) 
 562 ;test1.j(218)   // constant - var
 563 ;test1.j(219)   // byte - integer
 564 ;test1.j(220)   i=40;
 565 acc8= constant 40
 566 acc8=> variable 0
 567 ;test1.j(221)   while (39 <= i) { write (i); i--; }
 568 acc16= variable 0
 569 acc8= constant 39
 570 acc8CompareAcc16
 571 brgt 584
 572 acc16= variable 0
 573 call writeAcc16
 574 decr16 variable 0
 575 br 568
 576 ;test1.j(222) 
 577 ;test1.j(223)   // constant - var
 578 ;test1.j(224)   // integer - byte
 579 ;test1.j(225)   // not relevant
 580 ;test1.j(226) 
 581 ;test1.j(227)   // constant - var
 582 ;test1.j(228)   // integer - integer
 583 ;test1.j(229)   i=1038;
 584 acc16= constant 1038
 585 acc16=> variable 0
 586 ;test1.j(230)   b=38;
 587 acc8= constant 38
 588 acc8=> variable 6
 589 ;test1.j(231)   while (1037 <= i) { write (b); b--; i--; }
 590 acc16= variable 0
 591 acc16Comp constant 1037
 592 brlt 603
 593 acc8= variable 6
 594 call writeAcc8
 595 decr8 variable 6
 596 decr16 variable 0
 597 br 590
 598 ;test1.j(232) 
 599 ;test1.j(233)   /************************/
 600 ;test1.j(234)   // constant - acc
 601 ;test1.j(235)   // byte - byte
 602 ;test1.j(236)   b=36;
 603 acc8= constant 36
 604 acc8=> variable 6
 605 ;test1.j(237)   while (135 == b+100) { write (b); b--; }
 606 acc8= variable 6
 607 acc8+ constant 100
 608 acc8Comp constant 135
 609 brne 615
 610 acc8= variable 6
 611 call writeAcc8
 612 decr8 variable 6
 613 br 606
 614 ;test1.j(238)   while (132 != b+100) { write (b); b--; }
 615 acc8= variable 6
 616 acc8+ constant 100
 617 acc8Comp constant 132
 618 breq 624
 619 acc8= variable 6
 620 call writeAcc8
 621 decr8 variable 6
 622 br 615
 623 ;test1.j(239)   p=32;
 624 acc8= constant 32
 625 acc8=> variable 4
 626 ;test1.j(240)   while (134 > b+100) { write (p); p--; b++; }
 627 acc8= variable 6
 628 acc8+ constant 100
 629 acc8Comp constant 134
 630 brge 637
 631 acc16= variable 4
 632 call writeAcc16
 633 decr16 variable 4
 634 incr8 variable 6
 635 br 627
 636 ;test1.j(241)   while (135 >= b+100) { write (p); p--; b++; }
 637 acc8= variable 6
 638 acc8+ constant 100
 639 acc8Comp constant 135
 640 brgt 647
 641 acc16= variable 4
 642 call writeAcc16
 643 decr16 variable 4
 644 incr8 variable 6
 645 br 637
 646 ;test1.j(242)   b=28;
 647 acc8= constant 28
 648 acc8=> variable 6
 649 ;test1.j(243)   while (126 <  b+100) { write (b); b--; }
 650 acc8= variable 6
 651 acc8+ constant 100
 652 acc8Comp constant 126
 653 brle 659
 654 acc8= variable 6
 655 call writeAcc8
 656 decr8 variable 6
 657 br 650
 658 ;test1.j(244)   while (125 <= b+100) { write (b); b--; }
 659 acc8= variable 6
 660 acc8+ constant 100
 661 acc8Comp constant 125
 662 brlt 670
 663 acc8= variable 6
 664 call writeAcc8
 665 decr8 variable 6
 666 br 659
 667 ;test1.j(245)   // constant - acc
 668 ;test1.j(246)   // byte - integer
 669 ;test1.j(247)   i=24;
 670 acc8= constant 24
 671 acc8=> variable 0
 672 ;test1.j(248)   b=23;
 673 acc8= constant 23
 674 acc8=> variable 6
 675 ;test1.j(249)   while (23 == i+0) { write (i); i--; }
 676 acc16= variable 0
 677 acc16+ constant 0
 678 acc8= constant 23
 679 acc8CompareAcc16
 680 brne 686
 681 acc16= variable 0
 682 call writeAcc16
 683 decr16 variable 0
 684 br 676
 685 ;test1.j(250)   while (120 != i+100) { write (i); i--; }
 686 acc16= variable 0
 687 acc16+ constant 100
 688 acc8= constant 120
 689 acc8CompareAcc16
 690 breq 696
 691 acc16= variable 0
 692 call writeAcc16
 693 decr16 variable 0
 694 br 686
 695 ;test1.j(251)   p=20;
 696 acc8= constant 20
 697 acc8=> variable 4
 698 ;test1.j(252)   while (122 > i+100) { write (p); p--; i++; }
 699 acc16= variable 0
 700 acc16+ constant 100
 701 acc8= constant 122
 702 acc8CompareAcc16
 703 brle 710
 704 acc16= variable 4
 705 call writeAcc16
 706 decr16 variable 4
 707 incr16 variable 0
 708 br 699
 709 ;test1.j(253)   while (123 >= i+100) { write (p); p--; i++; }
 710 acc16= variable 0
 711 acc16+ constant 100
 712 acc8= constant 123
 713 acc8CompareAcc16
 714 brlt 721
 715 acc16= variable 4
 716 call writeAcc16
 717 decr16 variable 4
 718 incr16 variable 0
 719 br 710
 720 ;test1.j(254)   i=16;
 721 acc8= constant 16
 722 acc8=> variable 0
 723 ;test1.j(255)   while (114 <  i+100) { write (i); i--; }
 724 acc16= variable 0
 725 acc16+ constant 100
 726 acc8= constant 114
 727 acc8CompareAcc16
 728 brge 734
 729 acc16= variable 0
 730 call writeAcc16
 731 decr16 variable 0
 732 br 724
 733 ;test1.j(256)   while (113 <= i+100) { write (i); i--; }
 734 acc16= variable 0
 735 acc16+ constant 100
 736 acc8= constant 113
 737 acc8CompareAcc16
 738 brgt 750
 739 acc16= variable 0
 740 call writeAcc16
 741 decr16 variable 0
 742 br 734
 743 ;test1.j(257)   // constant - acc
 744 ;test1.j(258)   // integer - byte
 745 ;test1.j(259)   // not relevant
 746 ;test1.j(260) 
 747 ;test1.j(261)   // constant - acc
 748 ;test1.j(262)   // integer - integer
 749 ;test1.j(263)   i=12;
 750 acc8= constant 12
 751 acc8=> variable 0
 752 ;test1.j(264)   while (1011 == i+1000) { write (i); i--; }
 753 acc16= variable 0
 754 acc16+ constant 1000
 755 acc16Comp constant 1011
 756 brne 763
 757 acc16= variable 0
 758 call writeAcc16
 759 decr16 variable 0
 760 br 753
 761 ;test1.j(265)   //i=10
 762 ;test1.j(266)   while (1008 != i+1000) { write (i); i--; }
 763 acc16= variable 0
 764 acc16+ constant 1000
 765 acc16Comp constant 1008
 766 breq 773
 767 acc16= variable 0
 768 call writeAcc16
 769 decr16 variable 0
 770 br 763
 771 ;test1.j(267)   //i=8
 772 ;test1.j(268)   p=8;
 773 acc8= constant 8
 774 acc8=> variable 4
 775 ;test1.j(269)   while (1010 > i+1000) { write (p); p--; i++; }
 776 acc16= variable 0
 777 acc16+ constant 1000
 778 acc16Comp constant 1010
 779 brge 787
 780 acc16= variable 4
 781 call writeAcc16
 782 decr16 variable 4
 783 incr16 variable 0
 784 br 776
 785 ;test1.j(270)   //i=10; p=6
 786 ;test1.j(271)   while (1011 >= i+1000) { write (p); p--; i++; }
 787 acc16= variable 0
 788 acc16+ constant 1000
 789 acc16Comp constant 1011
 790 brgt 797
 791 acc16= variable 4
 792 call writeAcc16
 793 decr16 variable 4
 794 incr16 variable 0
 795 br 787
 796 ;test1.j(272)   i=4;
 797 acc8= constant 4
 798 acc8=> variable 0
 799 ;test1.j(273)   while (1002 <  i+1000) { write (i); i--; }
 800 acc16= variable 0
 801 acc16+ constant 1000
 802 acc16Comp constant 1002
 803 brle 810
 804 acc16= variable 0
 805 call writeAcc16
 806 decr16 variable 0
 807 br 800
 808 ;test1.j(274)   //i=2;
 809 ;test1.j(275)   while (1001 <= i+1000) { write (i); i--; }
 810 acc16= variable 0
 811 acc16+ constant 1000
 812 acc16Comp constant 1001
 813 brlt 823
 814 acc16= variable 0
 815 call writeAcc16
 816 decr16 variable 0
 817 br 810
 818 ;test1.j(276) 
 819 ;test1.j(277)   /************************/
 820 ;test1.j(278)   // constant - constant
 821 ;test1.j(279)   // not relevant
 822 ;test1.j(280)   write(0);
 823 acc8= constant 0
 824 call writeAcc8
 825 ;test1.j(281) }
 826 stop
