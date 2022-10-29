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
 118 brlt 127
 119 acc16= variable 0
 120 call writeAcc16
 121 decr16 variable 0
 122 incr8 variable 6
 123 br 113
 124 ;test1.j(61)   // byte - integer
 125 ;test1.j(62)   //not relevant
 126 ;test1.j(63)   i=103;
 127 acc8= constant 103
 128 acc8=> variable 0
 129 ;test1.j(64)   b=102;
 130 acc8= constant 102
 131 acc8=> variable 6
 132 ;test1.j(65)   while (b <= i+0) { write (b); b--; i=i-2; }
 133 acc8= variable 6
 134 <acc8
 135 acc16= variable 0
 136 acc16+ constant 0
 137 acc8= unstack8
 138 acc8CompareAcc16
 139 brgt 149
 140 acc8= variable 6
 141 call writeAcc8
 142 decr8 variable 6
 143 acc16= variable 0
 144 acc16- constant 2
 145 acc16=> variable 0
 146 br 133
 147 ;test1.j(66)   // integer - byte
 148 ;test1.j(67)   i=100;
 149 acc8= constant 100
 150 acc8=> variable 0
 151 ;test1.j(68)   while (i <= 101+0) { write (b); b--; i++; }
 152 acc16= variable 0
 153 <acc16
 154 acc8= constant 101
 155 acc8+ constant 0
 156 acc16= unstack16
 157 acc16CompareAcc8
 158 brgt 166
 159 acc8= variable 6
 160 call writeAcc8
 161 decr8 variable 6
 162 incr16 variable 0
 163 br 152
 164 ;test1.j(69)   // integer - integer
 165 ;test1.j(70)   i=1098;
 166 acc16= constant 1098
 167 acc16=> variable 0
 168 ;test1.j(71)   while (i <= 1099+0) { write (b); b--; i++; }
 169 acc16= variable 0
 170 <acc16
 171 acc16= constant 1099
 172 acc16+ constant 0
 173 revAcc16Comp unstack16
 174 brlt 185
 175 acc8= variable 6
 176 call writeAcc8
 177 decr8 variable 6
 178 incr16 variable 0
 179 br 169
 180 ;test1.j(72) 
 181 ;test1.j(73)   /************************/
 182 ;test1.j(74)   // var - constant
 183 ;test1.j(75)   // byte - byte
 184 ;test1.j(76)   i=96;
 185 acc8= constant 96
 186 acc8=> variable 0
 187 ;test1.j(77)   b=96;
 188 acc8= constant 96
 189 acc8=> variable 6
 190 ;test1.j(78)   while (b <= 97) { write (i); i--; b++; }
 191 acc8= variable 6
 192 acc8Comp constant 97
 193 brgt 202
 194 acc16= variable 0
 195 call writeAcc16
 196 decr16 variable 0
 197 incr8 variable 6
 198 br 191
 199 ;test1.j(79)   // byte - integer
 200 ;test1.j(80)   //not relevant
 201 ;test1.j(81)   write(94);
 202 acc8= constant 94
 203 call writeAcc8
 204 ;test1.j(82)   write(93);
 205 acc8= constant 93
 206 call writeAcc8
 207 ;test1.j(83)   // integer - byte
 208 ;test1.j(84)   i=92;
 209 acc8= constant 92
 210 acc8=> variable 0
 211 ;test1.j(85)   b=92;
 212 acc8= constant 92
 213 acc8=> variable 6
 214 ;test1.j(86)   while (i <= 93) { write (b); b--; i++; }
 215 acc16= variable 0
 216 acc8= constant 93
 217 acc16CompareAcc8
 218 brgt 226
 219 acc8= variable 6
 220 call writeAcc8
 221 decr8 variable 6
 222 incr16 variable 0
 223 br 215
 224 ;test1.j(87)   // integer - integer
 225 ;test1.j(88)   i=1090;
 226 acc16= constant 1090
 227 acc16=> variable 0
 228 ;test1.j(89)   while (i <= 1091) { write (b); b--; i++; }
 229 acc16= variable 0
 230 acc16Comp constant 1091
 231 brgt 243
 232 acc8= variable 6
 233 call writeAcc8
 234 decr8 variable 6
 235 incr16 variable 0
 236 br 229
 237 ;test1.j(90) 
 238 ;test1.j(91)   /************************/
 239 ;test1.j(92)   // acc - stack8
 240 ;test1.j(93)   // byte - byte
 241 ;test1.j(94)   //TODO
 242 ;test1.j(95)   write(88);
 243 acc8= constant 88
 244 call writeAcc8
 245 ;test1.j(96)   write(87);
 246 acc8= constant 87
 247 call writeAcc8
 248 ;test1.j(97)   // byte - integer
 249 ;test1.j(98)   //TODO
 250 ;test1.j(99)   write(86);
 251 acc8= constant 86
 252 call writeAcc8
 253 ;test1.j(100)   write(85);
 254 acc8= constant 85
 255 call writeAcc8
 256 ;test1.j(101)   // integer - byte
 257 ;test1.j(102)   //TODO
 258 ;test1.j(103)   write(84);
 259 acc8= constant 84
 260 call writeAcc8
 261 ;test1.j(104)   write(83);
 262 acc8= constant 83
 263 call writeAcc8
 264 ;test1.j(105)   // integer - integer
 265 ;test1.j(106)   //TODO
 266 ;test1.j(107)   write(82);
 267 acc8= constant 82
 268 call writeAcc8
 269 ;test1.j(108)   write(81);
 270 acc8= constant 81
 271 call writeAcc8
 272 ;test1.j(109) 
 273 ;test1.j(110)   /************************/
 274 ;test1.j(111)   // acc - stack16
 275 ;test1.j(112)   // byte - byte
 276 ;test1.j(113)   //TODO
 277 ;test1.j(114)   write(80);
 278 acc8= constant 80
 279 call writeAcc8
 280 ;test1.j(115)   write(79);
 281 acc8= constant 79
 282 call writeAcc8
 283 ;test1.j(116)   // byte - integer
 284 ;test1.j(117)   //TODO
 285 ;test1.j(118)   write(78);
 286 acc8= constant 78
 287 call writeAcc8
 288 ;test1.j(119)   write(77);
 289 acc8= constant 77
 290 call writeAcc8
 291 ;test1.j(120)   // integer - byte
 292 ;test1.j(121)   //TODO
 293 ;test1.j(122)   write(76);
 294 acc8= constant 76
 295 call writeAcc8
 296 ;test1.j(123)   write(75);
 297 acc8= constant 75
 298 call writeAcc8
 299 ;test1.j(124)   // integer - integer
 300 ;test1.j(125)   //TODO
 301 ;test1.j(126)   write(74);
 302 acc8= constant 74
 303 call writeAcc8
 304 ;test1.j(127)   write(73);
 305 acc8= constant 73
 306 call writeAcc8
 307 ;test1.j(128) 
 308 ;test1.j(129)   /************************/
 309 ;test1.j(130)   // acc - var
 310 ;test1.j(131)   // byte - byte
 311 ;test1.j(132)   b=72;
 312 acc8= constant 72
 313 acc8=> variable 6
 314 ;test1.j(133)   while (71+0 <= b) { write (b); b--; }
 315 acc8= constant 71
 316 acc8+ constant 0
 317 acc8Comp variable 6
 318 brgt 325
 319 acc8= variable 6
 320 call writeAcc8
 321 decr8 variable 6
 322 br 315
 323 ;test1.j(134)   // byte - integer
 324 ;test1.j(135)   i=70;
 325 acc8= constant 70
 326 acc8=> variable 0
 327 ;test1.j(136)   while (69+0 <= i) { write (i); i--; }
 328 acc8= constant 69
 329 acc8+ constant 0
 330 acc16= variable 0
 331 acc8CompareAcc16
 332 brgt 339
 333 acc16= variable 0
 334 call writeAcc16
 335 decr16 variable 0
 336 br 328
 337 ;test1.j(137)   // integer - byte
 338 ;test1.j(138)   i=67;
 339 acc8= constant 67
 340 acc8=> variable 0
 341 ;test1.j(139)   b=68;
 342 acc8= constant 68
 343 acc8=> variable 6
 344 ;test1.j(140)   while (i+0 <= b) { write (b); b--; } 
 345 acc16= variable 0
 346 acc16+ constant 0
 347 acc8= variable 6
 348 acc16CompareAcc8
 349 brgt 356
 350 acc8= variable 6
 351 call writeAcc8
 352 decr8 variable 6
 353 br 345
 354 ;test1.j(141)   // integer - integer
 355 ;test1.j(142)   i=1066;
 356 acc16= constant 1066
 357 acc16=> variable 0
 358 ;test1.j(143)   while (1000+65 <= i) { write (b); b--; i--; }
 359 acc16= constant 1000
 360 acc16+ constant 65
 361 acc16Comp variable 0
 362 brgt 373
 363 acc8= variable 6
 364 call writeAcc8
 365 decr8 variable 6
 366 decr16 variable 0
 367 br 359
 368 ;test1.j(144) 
 369 ;test1.j(145)   /************************/
 370 ;test1.j(146)   // acc - acc
 371 ;test1.j(147)   // byte - byte
 372 ;test1.j(148)   b=64;
 373 acc8= constant 64
 374 acc8=> variable 6
 375 ;test1.j(149)   while (63+0 <= b+0) { write (b); b--; }
 376 acc8= constant 63
 377 acc8+ constant 0
 378 <acc8
 379 acc8= variable 6
 380 acc8+ constant 0
 381 revAcc8Comp unstack8
 382 brlt 389
 383 acc8= variable 6
 384 call writeAcc8
 385 decr8 variable 6
 386 br 376
 387 ;test1.j(150)   // byte - integer
 388 ;test1.j(151)   i=62;
 389 acc8= constant 62
 390 acc8=> variable 0
 391 ;test1.j(152)   while (61+0 <= i+0) { write (i); i--; }
 392 acc8= constant 61
 393 acc8+ constant 0
 394 <acc8
 395 acc16= variable 0
 396 acc16+ constant 0
 397 acc8= unstack8
 398 acc8CompareAcc16
 399 brgt 406
 400 acc16= variable 0
 401 call writeAcc16
 402 decr16 variable 0
 403 br 392
 404 ;test1.j(153)   // integer - byte
 405 ;test1.j(154)   i=59;
 406 acc8= constant 59
 407 acc8=> variable 0
 408 ;test1.j(155)   b=60;
 409 acc8= constant 60
 410 acc8=> variable 6
 411 ;test1.j(156)   while (i+0 <= b+0) { write (b); b--; }
 412 acc16= variable 0
 413 acc16+ constant 0
 414 <acc16
 415 acc8= variable 6
 416 acc8+ constant 0
 417 acc16= unstack16
 418 acc16CompareAcc8
 419 brgt 426
 420 acc8= variable 6
 421 call writeAcc8
 422 decr8 variable 6
 423 br 412
 424 ;test1.j(157)   // integer - integer
 425 ;test1.j(158)   i=1058;
 426 acc16= constant 1058
 427 acc16=> variable 0
 428 ;test1.j(159)   while (1000+57 <= i+0) { write (b); b--; i--; }
 429 acc16= constant 1000
 430 acc16+ constant 57
 431 <acc16
 432 acc16= variable 0
 433 acc16+ constant 0
 434 revAcc16Comp unstack16
 435 brlt 446
 436 acc8= variable 6
 437 call writeAcc8
 438 decr8 variable 6
 439 decr16 variable 0
 440 br 429
 441 ;test1.j(160) 
 442 ;test1.j(161)   /************************/
 443 ;test1.j(162)   // acc - constant
 444 ;test1.j(163)   // byte - byte
 445 ;test1.j(164)   i=56;
 446 acc8= constant 56
 447 acc8=> variable 0
 448 ;test1.j(165)   b=56;
 449 acc8= constant 56
 450 acc8=> variable 6
 451 ;test1.j(166)   while (b+0 <= 57) { write (i); i--; b++; }
 452 acc8= variable 6
 453 acc8+ constant 0
 454 acc8Comp constant 57
 455 brgt 465
 456 acc16= variable 0
 457 call writeAcc16
 458 decr16 variable 0
 459 incr8 variable 6
 460 br 452
 461 ;test1.j(167)   // byte - integer
 462 ;test1.j(168)   //not relevant
 463 ;test1.j(169)   // integer - byte
 464 ;test1.j(170)   i=54;
 465 acc8= constant 54
 466 acc8=> variable 0
 467 ;test1.j(171)   b=54;
 468 acc8= constant 54
 469 acc8=> variable 6
 470 ;test1.j(172)   while (i+0 <= 55) { write (b); b--; i++; }
 471 acc16= variable 0
 472 acc16+ constant 0
 473 acc8= constant 55
 474 acc16CompareAcc8
 475 brgt 482
 476 acc8= variable 6
 477 call writeAcc8
 478 decr8 variable 6
 479 incr16 variable 0
 480 br 471
 481 ;test1.j(173)   i=1052;
 482 acc16= constant 1052
 483 acc16=> variable 0
 484 ;test1.j(174)   // integer - integer
 485 ;test1.j(175)   while (i+0 <= 1053) { write (b); b--; i++; }
 486 acc16= variable 0
 487 acc16+ constant 0
 488 acc16Comp constant 1053
 489 brgt 501
 490 acc8= variable 6
 491 call writeAcc8
 492 decr8 variable 6
 493 incr16 variable 0
 494 br 486
 495 ;test1.j(176) 
 496 ;test1.j(177)   /************************/
 497 ;test1.j(178)   // constant - stack8
 498 ;test1.j(179)   // byte - byte
 499 ;test1.j(180)   //TODO
 500 ;test1.j(181)   write(50);
 501 acc8= constant 50
 502 call writeAcc8
 503 ;test1.j(182)   // constant - stack8
 504 ;test1.j(183)   // byte - integer
 505 ;test1.j(184)   //TODO
 506 ;test1.j(185)   write(49);
 507 acc8= constant 49
 508 call writeAcc8
 509 ;test1.j(186)   // constant - stack8
 510 ;test1.j(187)   // integer - byte
 511 ;test1.j(188)   //TODO
 512 ;test1.j(189)   write(48);
 513 acc8= constant 48
 514 call writeAcc8
 515 ;test1.j(190)   // constant - stack88
 516 ;test1.j(191)   // integer - integer
 517 ;test1.j(192)   //TODO
 518 ;test1.j(193)   write(47);
 519 acc8= constant 47
 520 call writeAcc8
 521 ;test1.j(194) 
 522 ;test1.j(195)   /************************/
 523 ;test1.j(196)   // constant - stack16
 524 ;test1.j(197)   // byte - byte
 525 ;test1.j(198)   //TODO
 526 ;test1.j(199)   write(46);
 527 acc8= constant 46
 528 call writeAcc8
 529 ;test1.j(200)   // constant - stack16
 530 ;test1.j(201)   // byte - integer
 531 ;test1.j(202)   //TODO
 532 ;test1.j(203)   write(45);
 533 acc8= constant 45
 534 call writeAcc8
 535 ;test1.j(204)   // constant - stack16
 536 ;test1.j(205)   // integer - byte
 537 ;test1.j(206)   //TODO
 538 ;test1.j(207)   write(44);
 539 acc8= constant 44
 540 call writeAcc8
 541 ;test1.j(208)   // constant - stack16
 542 ;test1.j(209)   // integer - integer
 543 ;test1.j(210)   //TODO
 544 ;test1.j(211)   write(43);
 545 acc8= constant 43
 546 call writeAcc8
 547 ;test1.j(212) 
 548 ;test1.j(213)   /************************/
 549 ;test1.j(214)   // constant - var
 550 ;test1.j(215)   // byte - byte
 551 ;test1.j(216)   b=42;
 552 acc8= constant 42
 553 acc8=> variable 6
 554 ;test1.j(217)   while (41 <= b) { write (b); b--; }
 555 acc8= variable 6
 556 acc8Comp constant 41
 557 brlt 566
 558 acc8= variable 6
 559 call writeAcc8
 560 decr8 variable 6
 561 br 555
 562 ;test1.j(218) 
 563 ;test1.j(219)   // constant - var
 564 ;test1.j(220)   // byte - integer
 565 ;test1.j(221)   i=40;
 566 acc8= constant 40
 567 acc8=> variable 0
 568 ;test1.j(222)   while (39 <= i) { write (i); i--; }
 569 acc16= variable 0
 570 acc8= constant 39
 571 acc8CompareAcc16
 572 brgt 585
 573 acc16= variable 0
 574 call writeAcc16
 575 decr16 variable 0
 576 br 569
 577 ;test1.j(223) 
 578 ;test1.j(224)   // constant - var
 579 ;test1.j(225)   // integer - byte
 580 ;test1.j(226)   // not relevant
 581 ;test1.j(227) 
 582 ;test1.j(228)   // constant - var
 583 ;test1.j(229)   // integer - integer
 584 ;test1.j(230)   i=1038;
 585 acc16= constant 1038
 586 acc16=> variable 0
 587 ;test1.j(231)   b=38;
 588 acc8= constant 38
 589 acc8=> variable 6
 590 ;test1.j(232)   while (1037 <= i) { write (b); b--; i--; }
 591 acc16= variable 0
 592 acc16Comp constant 1037
 593 brlt 604
 594 acc8= variable 6
 595 call writeAcc8
 596 decr8 variable 6
 597 decr16 variable 0
 598 br 591
 599 ;test1.j(233) 
 600 ;test1.j(234)   /************************/
 601 ;test1.j(235)   // constant - acc
 602 ;test1.j(236)   // byte - byte
 603 ;test1.j(237)   b=36;
 604 acc8= constant 36
 605 acc8=> variable 6
 606 ;test1.j(238)   while (135 == b+100) { write (b); b--; }
 607 acc8= variable 6
 608 acc8+ constant 100
 609 acc8Comp constant 135
 610 brne 616
 611 acc8= variable 6
 612 call writeAcc8
 613 decr8 variable 6
 614 br 607
 615 ;test1.j(239)   while (132 != b+100) { write (b); b--; }
 616 acc8= variable 6
 617 acc8+ constant 100
 618 acc8Comp constant 132
 619 breq 625
 620 acc8= variable 6
 621 call writeAcc8
 622 decr8 variable 6
 623 br 616
 624 ;test1.j(240)   p=32;
 625 acc8= constant 32
 626 acc8=> variable 4
 627 ;test1.j(241)   while (134 > b+100) { write (p); p--; b++; }
 628 acc8= variable 6
 629 acc8+ constant 100
 630 acc8Comp constant 134
 631 brge 638
 632 acc16= variable 4
 633 call writeAcc16
 634 decr16 variable 4
 635 incr8 variable 6
 636 br 628
 637 ;test1.j(242)   while (135 >= b+100) { write (p); p--; b++; }
 638 acc8= variable 6
 639 acc8+ constant 100
 640 acc8Comp constant 135
 641 brgt 648
 642 acc16= variable 4
 643 call writeAcc16
 644 decr16 variable 4
 645 incr8 variable 6
 646 br 638
 647 ;test1.j(243)   b=28;
 648 acc8= constant 28
 649 acc8=> variable 6
 650 ;test1.j(244)   while (126 <  b+100) { write (b); b--; }
 651 acc8= variable 6
 652 acc8+ constant 100
 653 acc8Comp constant 126
 654 brle 660
 655 acc8= variable 6
 656 call writeAcc8
 657 decr8 variable 6
 658 br 651
 659 ;test1.j(245)   while (125 <= b+100) { write (b); b--; }
 660 acc8= variable 6
 661 acc8+ constant 100
 662 acc8Comp constant 125
 663 brlt 671
 664 acc8= variable 6
 665 call writeAcc8
 666 decr8 variable 6
 667 br 660
 668 ;test1.j(246)   // constant - acc
 669 ;test1.j(247)   // byte - integer
 670 ;test1.j(248)   i=24;
 671 acc8= constant 24
 672 acc8=> variable 0
 673 ;test1.j(249)   b=23;
 674 acc8= constant 23
 675 acc8=> variable 6
 676 ;test1.j(250)   while (23 == i+0) { write (i); i--; }
 677 acc16= variable 0
 678 acc16+ constant 0
 679 acc8= constant 23
 680 acc8CompareAcc16
 681 brne 687
 682 acc16= variable 0
 683 call writeAcc16
 684 decr16 variable 0
 685 br 677
 686 ;test1.j(251)   while (120 != i+100) { write (i); i--; }
 687 acc16= variable 0
 688 acc16+ constant 100
 689 acc8= constant 120
 690 acc8CompareAcc16
 691 breq 697
 692 acc16= variable 0
 693 call writeAcc16
 694 decr16 variable 0
 695 br 687
 696 ;test1.j(252)   p=20;
 697 acc8= constant 20
 698 acc8=> variable 4
 699 ;test1.j(253)   while (122 > i+100) { write (p); p--; i++; }
 700 acc16= variable 0
 701 acc16+ constant 100
 702 acc8= constant 122
 703 acc8CompareAcc16
 704 brle 711
 705 acc16= variable 4
 706 call writeAcc16
 707 decr16 variable 4
 708 incr16 variable 0
 709 br 700
 710 ;test1.j(254)   while (123 >= i+100) { write (p); p--; i++; }
 711 acc16= variable 0
 712 acc16+ constant 100
 713 acc8= constant 123
 714 acc8CompareAcc16
 715 brlt 722
 716 acc16= variable 4
 717 call writeAcc16
 718 decr16 variable 4
 719 incr16 variable 0
 720 br 711
 721 ;test1.j(255)   i=16;
 722 acc8= constant 16
 723 acc8=> variable 0
 724 ;test1.j(256)   while (114 <  i+100) { write (i); i--; }
 725 acc16= variable 0
 726 acc16+ constant 100
 727 acc8= constant 114
 728 acc8CompareAcc16
 729 brge 735
 730 acc16= variable 0
 731 call writeAcc16
 732 decr16 variable 0
 733 br 725
 734 ;test1.j(257)   while (113 <= i+100) { write (i); i--; }
 735 acc16= variable 0
 736 acc16+ constant 100
 737 acc8= constant 113
 738 acc8CompareAcc16
 739 brgt 751
 740 acc16= variable 0
 741 call writeAcc16
 742 decr16 variable 0
 743 br 735
 744 ;test1.j(258)   // constant - acc
 745 ;test1.j(259)   // integer - byte
 746 ;test1.j(260)   // not relevant
 747 ;test1.j(261) 
 748 ;test1.j(262)   // constant - acc
 749 ;test1.j(263)   // integer - integer
 750 ;test1.j(264)   i=12;
 751 acc8= constant 12
 752 acc8=> variable 0
 753 ;test1.j(265)   while (1011 == i+1000) { write (i); i--; }
 754 acc16= variable 0
 755 acc16+ constant 1000
 756 acc16Comp constant 1011
 757 brne 764
 758 acc16= variable 0
 759 call writeAcc16
 760 decr16 variable 0
 761 br 754
 762 ;test1.j(266)   //i=10
 763 ;test1.j(267)   while (1008 != i+1000) { write (i); i--; }
 764 acc16= variable 0
 765 acc16+ constant 1000
 766 acc16Comp constant 1008
 767 breq 774
 768 acc16= variable 0
 769 call writeAcc16
 770 decr16 variable 0
 771 br 764
 772 ;test1.j(268)   //i=8
 773 ;test1.j(269)   p=8;
 774 acc8= constant 8
 775 acc8=> variable 4
 776 ;test1.j(270)   while (1010 > i+1000) { write (p); p--; i++; }
 777 acc16= variable 0
 778 acc16+ constant 1000
 779 acc16Comp constant 1010
 780 brge 788
 781 acc16= variable 4
 782 call writeAcc16
 783 decr16 variable 4
 784 incr16 variable 0
 785 br 777
 786 ;test1.j(271)   //i=10; p=6
 787 ;test1.j(272)   while (1011 >= i+1000) { write (p); p--; i++; }
 788 acc16= variable 0
 789 acc16+ constant 1000
 790 acc16Comp constant 1011
 791 brgt 798
 792 acc16= variable 4
 793 call writeAcc16
 794 decr16 variable 4
 795 incr16 variable 0
 796 br 788
 797 ;test1.j(273)   i=4;
 798 acc8= constant 4
 799 acc8=> variable 0
 800 ;test1.j(274)   while (1002 <  i+1000) { write (i); i--; }
 801 acc16= variable 0
 802 acc16+ constant 1000
 803 acc16Comp constant 1002
 804 brle 811
 805 acc16= variable 0
 806 call writeAcc16
 807 decr16 variable 0
 808 br 801
 809 ;test1.j(275)   //i=2;
 810 ;test1.j(276)   while (1001 <= i+1000) { write (i); i--; }
 811 acc16= variable 0
 812 acc16+ constant 1000
 813 acc16Comp constant 1001
 814 brlt 824
 815 acc16= variable 0
 816 call writeAcc16
 817 decr16 variable 0
 818 br 811
 819 ;test1.j(277) 
 820 ;test1.j(278)   /************************/
 821 ;test1.j(279)   // constant - constant
 822 ;test1.j(280)   // not relevant
 823 ;test1.j(281)   write(0);
 824 acc8= constant 0
 825 call writeAcc8
 826 ;test1.j(282) }
 827 stop
