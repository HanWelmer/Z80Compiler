   0 ;test1.j(0) /* Program to test generated Z80 assembler code */
   1 ;test1.j(1) class TestWhile {
   2 ;test1.j(2)   byte b = 0;
   3 acc8= constant 0
   4 acc8=> variable 0
   5 ;test1.j(3)   byte b2 = 32;
   6 acc8= constant 32
   7 acc8=> variable 1
   8 ;test1.j(4)   word i = 110;
   9 acc8= constant 110
  10 acc8=> variable 2
  11 ;test1.j(5)   word i2 = 105;
  12 acc8= constant 105
  13 acc8=> variable 4
  14 ;test1.j(6)   word p = 12;
  15 acc8= constant 12
  16 acc8=> variable 6
  17 ;test1.j(7)   
  18 ;test1.j(8)   /*Possible operand types: 
  19 ;test1.j(9)    * constant, acc, var, stack8, stack16
  20 ;test1.j(10)    *Possible datatype combinations:
  21 ;test1.j(11)    * byte - byte
  22 ;test1.j(12)    * byte - integer
  23 ;test1.j(13)    * integer - byte
  24 ;test1.j(14)    * integer - integer
  25 ;test1.j(15)   */
  26 ;test1.j(16) 
  27 ;test1.j(17)   write(0);
  28 acc8= constant 0
  29 call writeAcc8
  30 ;test1.j(18) 
  31 ;test1.j(19)   /************************/
  32 ;test1.j(20)   // global variable within while scope
  33 ;test1.j(21)   b++;
  34 incr8 variable 0
  35 ;test1.j(22)   write (b);
  36 acc8= variable 0
  37 call writeAcc8
  38 ;test1.j(23)   while (b < 2) {
  39 acc8= variable 0
  40 acc8Comp constant 2
  41 brge 67
  42 ;test1.j(24)     b++;
  43 incr8 variable 0
  44 ;test1.j(25)     word j = 1001;
  45 acc16= constant 1001
  46 acc16=> variable 8
  47 ;test1.j(26)     byte c = b;
  48 acc8= variable 0
  49 acc8=> variable 10
  50 ;test1.j(27)     byte d = c;
  51 acc8= variable 10
  52 acc8=> variable 11
  53 ;test1.j(28)     write (c);
  54 acc8= variable 10
  55 call writeAcc8
  56 ;test1.j(29)   }
  57 br 39
  58 ;test1.j(30) 
  59 ;test1.j(31)   /************************/
  60 ;test1.j(32)   // constant - constant
  61 ;test1.j(33)   // not relevant
  62 ;test1.j(34) 
  63 ;test1.j(35)   /************************/
  64 ;test1.j(36)   // constant - acc
  65 ;test1.j(37)   // byte - byte
  66 ;test1.j(38)   b = 3;
  67 acc8= constant 3
  68 acc8=> variable 0
  69 ;test1.j(39)   while (3 == b+0) { write (b); b++; }
  70 acc8= variable 0
  71 acc8+ constant 0
  72 acc8Comp constant 3
  73 brne 79
  74 acc8= variable 0
  75 call writeAcc8
  76 incr8 variable 0
  77 br 70
  78 ;test1.j(40)   while (4 != b+0) { write (b); b++; }
  79 acc8= variable 0
  80 acc8+ constant 0
  81 acc8Comp constant 4
  82 breq 88
  83 acc8= variable 0
  84 call writeAcc8
  85 incr8 variable 0
  86 br 79
  87 ;test1.j(41)   while (6 > b+0) { write (b); b++; }
  88 acc8= variable 0
  89 acc8+ constant 0
  90 acc8Comp constant 6
  91 brge 97
  92 acc8= variable 0
  93 call writeAcc8
  94 incr8 variable 0
  95 br 88
  96 ;test1.j(42)   while (7 >= b+0) { write (b); b++; }
  97 acc8= variable 0
  98 acc8+ constant 0
  99 acc8Comp constant 7
 100 brgt 106
 101 acc8= variable 0
 102 call writeAcc8
 103 incr8 variable 0
 104 br 97
 105 ;test1.j(43)   p=8;
 106 acc8= constant 8
 107 acc8=> variable 6
 108 ;test1.j(44)   while (6 <  b+0) { write (p); p++; b--; }
 109 acc8= variable 0
 110 acc8+ constant 0
 111 acc8Comp constant 6
 112 brle 119
 113 acc16= variable 6
 114 call writeAcc16
 115 incr16 variable 6
 116 decr8 variable 0
 117 br 109
 118 ;test1.j(45)   while (5 <= b+0) { write (p); p++; b--; }
 119 acc8= variable 0
 120 acc8+ constant 0
 121 acc8Comp constant 5
 122 brlt 132
 123 acc16= variable 6
 124 call writeAcc16
 125 incr16 variable 6
 126 decr8 variable 0
 127 br 119
 128 ;test1.j(46)   
 129 ;test1.j(47)   // constant - acc
 130 ;test1.j(48)   // byte - integer
 131 ;test1.j(49)   i=12;
 132 acc8= constant 12
 133 acc8=> variable 2
 134 ;test1.j(50)   while (12 == i+0) { write (i); i++; }
 135 acc16= variable 2
 136 acc16+ constant 0
 137 acc8= constant 12
 138 acc8CompareAcc16
 139 brne 145
 140 acc16= variable 2
 141 call writeAcc16
 142 incr16 variable 2
 143 br 135
 144 ;test1.j(51)   while (15 != i+0) { write (i); i++; }
 145 acc16= variable 2
 146 acc16+ constant 0
 147 acc8= constant 15
 148 acc8CompareAcc16
 149 breq 155
 150 acc16= variable 2
 151 call writeAcc16
 152 incr16 variable 2
 153 br 145
 154 ;test1.j(52)   while (17 > i+0) { write (i); i++; }
 155 acc16= variable 2
 156 acc16+ constant 0
 157 acc8= constant 17
 158 acc8CompareAcc16
 159 brle 165
 160 acc16= variable 2
 161 call writeAcc16
 162 incr16 variable 2
 163 br 155
 164 ;test1.j(53)   while (18 >= i+0) { write (i); i++; }
 165 acc16= variable 2
 166 acc16+ constant 0
 167 acc8= constant 18
 168 acc8CompareAcc16
 169 brlt 175
 170 acc16= variable 2
 171 call writeAcc16
 172 incr16 variable 2
 173 br 165
 174 ;test1.j(54)   p=i;
 175 acc16= variable 2
 176 acc16=> variable 6
 177 ;test1.j(55)   while (17 <  i+0) { write (p); i--; p++; }
 178 acc16= variable 2
 179 acc16+ constant 0
 180 acc8= constant 17
 181 acc8CompareAcc16
 182 brge 189
 183 acc16= variable 6
 184 call writeAcc16
 185 decr16 variable 2
 186 incr16 variable 6
 187 br 178
 188 ;test1.j(56)   while (16 <= i+0) { write (p); i--; p++; }
 189 acc16= variable 2
 190 acc16+ constant 0
 191 acc8= constant 16
 192 acc8CompareAcc16
 193 brgt 207
 194 acc16= variable 6
 195 call writeAcc16
 196 decr16 variable 2
 197 incr16 variable 6
 198 br 189
 199 ;test1.j(57) 
 200 ;test1.j(58)   // constant - acc
 201 ;test1.j(59)   // integer - byte
 202 ;test1.j(60)   // not relevant
 203 ;test1.j(61) 
 204 ;test1.j(62)   // constant - acc
 205 ;test1.j(63)   // integer - integer
 206 ;test1.j(64)   i=23;
 207 acc8= constant 23
 208 acc8=> variable 2
 209 ;test1.j(65)   while (23 == i+0) { write (i); i++; }
 210 acc16= variable 2
 211 acc16+ constant 0
 212 acc8= constant 23
 213 acc8CompareAcc16
 214 brne 220
 215 acc16= variable 2
 216 call writeAcc16
 217 incr16 variable 2
 218 br 210
 219 ;test1.j(66)   while (26 != i+0) { write (i); i++; }
 220 acc16= variable 2
 221 acc16+ constant 0
 222 acc8= constant 26
 223 acc8CompareAcc16
 224 breq 230
 225 acc16= variable 2
 226 call writeAcc16
 227 incr16 variable 2
 228 br 220
 229 ;test1.j(67)   while (28 > i+0) { write (i); i++; }
 230 acc16= variable 2
 231 acc16+ constant 0
 232 acc8= constant 28
 233 acc8CompareAcc16
 234 brle 240
 235 acc16= variable 2
 236 call writeAcc16
 237 incr16 variable 2
 238 br 230
 239 ;test1.j(68)   while (29 >= i+0) { write (i); i++; }
 240 acc16= variable 2
 241 acc16+ constant 0
 242 acc8= constant 29
 243 acc8CompareAcc16
 244 brlt 250
 245 acc16= variable 2
 246 call writeAcc16
 247 incr16 variable 2
 248 br 240
 249 ;test1.j(69)   p=i;
 250 acc16= variable 2
 251 acc16=> variable 6
 252 ;test1.j(70)   while (28 <  i+0) { write (p); p++; i--; }
 253 acc16= variable 2
 254 acc16+ constant 0
 255 acc8= constant 28
 256 acc8CompareAcc16
 257 brge 264
 258 acc16= variable 6
 259 call writeAcc16
 260 incr16 variable 6
 261 decr16 variable 2
 262 br 253
 263 ;test1.j(71)   while (27 <= i+0) { write (p); p++; i--; }
 264 acc16= variable 2
 265 acc16+ constant 0
 266 acc8= constant 27
 267 acc8CompareAcc16
 268 brgt 279
 269 acc16= variable 6
 270 call writeAcc16
 271 incr16 variable 6
 272 decr16 variable 2
 273 br 264
 274 ;test1.j(72) 
 275 ;test1.j(73)   /************************/
 276 ;test1.j(74)   // constant - var
 277 ;test1.j(75)   // byte - byte
 278 ;test1.j(76)   b=35;
 279 acc8= constant 35
 280 acc8=> variable 0
 281 ;test1.j(77)   while (33 <= b) { write (p); p++; b--; }
 282 acc8= variable 0
 283 acc8Comp constant 33
 284 brlt 293
 285 acc16= variable 6
 286 call writeAcc16
 287 incr16 variable 6
 288 decr8 variable 0
 289 br 282
 290 ;test1.j(78)   // constant - var
 291 ;test1.j(79)   // byte - integer
 292 ;test1.j(80)   i=37;
 293 acc8= constant 37
 294 acc8=> variable 2
 295 ;test1.j(81)   while (36 <= i) { write (p); p++; i--; }
 296 acc16= variable 2
 297 acc8= constant 36
 298 acc8CompareAcc16
 299 brgt 312
 300 acc16= variable 6
 301 call writeAcc16
 302 incr16 variable 6
 303 decr16 variable 2
 304 br 296
 305 ;test1.j(82)   // constant - var
 306 ;test1.j(83)   // integer - byte
 307 ;test1.j(84)   // not relevant
 308 ;test1.j(85) 
 309 ;test1.j(86)   // constant - var
 310 ;test1.j(87)   // integer - integer
 311 ;test1.j(88)   while (34 <= i) { write (p); p++; i--; }
 312 acc16= variable 2
 313 acc8= constant 34
 314 acc8CompareAcc16
 315 brgt 358
 316 acc16= variable 6
 317 call writeAcc16
 318 incr16 variable 6
 319 decr16 variable 2
 320 br 312
 321 ;test1.j(89) 
 322 ;test1.j(90)   /************************/
 323 ;test1.j(91)   // stack8 - constant
 324 ;test1.j(92)   // stack8 - acc
 325 ;test1.j(93)   // stack8 - var
 326 ;test1.j(94)   // stack8 - stack8
 327 ;test1.j(95)   // stack8 - stack16
 328 ;test1.j(96)   //TODO
 329 ;test1.j(97) 
 330 ;test1.j(98)   /************************/
 331 ;test1.j(99)   // stack16 - constant
 332 ;test1.j(100)   // stack16 - acc
 333 ;test1.j(101)   // stack16 - var
 334 ;test1.j(102)   // stack16 - stack8
 335 ;test1.j(103)   // stack16 - stack16
 336 ;test1.j(104)   //TODO
 337 ;test1.j(105) 
 338 ;test1.j(106)   /************************/
 339 ;test1.j(107)   // var - stack16
 340 ;test1.j(108)   // byte - byte
 341 ;test1.j(109)   // byte - integer
 342 ;test1.j(110)   // integer - byte
 343 ;test1.j(111)   // integer - integer
 344 ;test1.j(112)   //TODO
 345 ;test1.j(113) 
 346 ;test1.j(114)   /************************/
 347 ;test1.j(115)   // var - stack8
 348 ;test1.j(116)   // byte - byte
 349 ;test1.j(117)   // byte - integer
 350 ;test1.j(118)   // integer - byte
 351 ;test1.j(119)   // integer - integer
 352 ;test1.j(120)   //TODO
 353 ;test1.j(121) 
 354 ;test1.j(122)   /************************/
 355 ;test1.j(123)   // var - var
 356 ;test1.j(124)   // byte - byte
 357 ;test1.j(125)   b=33;
 358 acc8= constant 33
 359 acc8=> variable 0
 360 ;test1.j(126)   while (b2 <= b) { write (p); p++; b--; }
 361 acc8= variable 1
 362 acc8Comp variable 0
 363 brgt 371
 364 acc16= variable 6
 365 call writeAcc16
 366 incr16 variable 6
 367 decr8 variable 0
 368 br 361
 369 ;test1.j(127)   // byte - integer
 370 ;test1.j(128)   i = 33;
 371 acc8= constant 33
 372 acc8=> variable 2
 373 ;test1.j(129)   while (b2 <= i) { write (p); p++; i--; }
 374 acc8= variable 1
 375 acc16= variable 2
 376 acc8CompareAcc16
 377 brgt 385
 378 acc16= variable 6
 379 call writeAcc16
 380 incr16 variable 6
 381 decr16 variable 2
 382 br 374
 383 ;test1.j(130)   // integer - byte
 384 ;test1.j(131)   b=33;
 385 acc8= constant 33
 386 acc8=> variable 0
 387 ;test1.j(132)   i=b2;
 388 acc8= variable 1
 389 acc8=> variable 2
 390 ;test1.j(133)   while (i <= b) { write (p); p++; b--; }
 391 acc16= variable 2
 392 acc8= variable 0
 393 acc16CompareAcc8
 394 brgt 402
 395 acc16= variable 6
 396 call writeAcc16
 397 incr16 variable 6
 398 decr8 variable 0
 399 br 391
 400 ;test1.j(134)   // integer - integer
 401 ;test1.j(135)   i=33;
 402 acc8= constant 33
 403 acc8=> variable 2
 404 ;test1.j(136)   i2=b2;
 405 acc8= variable 1
 406 acc8=> variable 4
 407 ;test1.j(137)   while (i2 <= i) { write (p); p++; i--; }
 408 acc16= variable 4
 409 acc16Comp variable 2
 410 brgt 421
 411 acc16= variable 6
 412 call writeAcc16
 413 incr16 variable 6
 414 decr16 variable 2
 415 br 408
 416 ;test1.j(138) 
 417 ;test1.j(139)   /************************/
 418 ;test1.j(140)   // var - acc
 419 ;test1.j(141)   // byte - byte
 420 ;test1.j(142)   b=49;
 421 acc8= constant 49
 422 acc8=> variable 0
 423 ;test1.j(143)   while (b <= 50+0) { write (b); b++; }
 424 acc8= constant 50
 425 acc8+ constant 0
 426 acc8Comp variable 0
 427 brlt 434
 428 acc8= variable 0
 429 call writeAcc8
 430 incr8 variable 0
 431 br 424
 432 ;test1.j(144)   // byte - integer
 433 ;test1.j(145)   i=52;
 434 acc8= constant 52
 435 acc8=> variable 2
 436 ;test1.j(146)   while (b <= i+0) { write (b); b++; }
 437 acc16= variable 2
 438 acc16+ constant 0
 439 acc8= variable 0
 440 acc8CompareAcc16
 441 brgt 448
 442 acc8= variable 0
 443 call writeAcc8
 444 incr8 variable 0
 445 br 437
 446 ;test1.j(147)   // integer - byte
 447 ;test1.j(148)   i=b;
 448 acc8= variable 0
 449 acc8=> variable 2
 450 ;test1.j(149)   while (i <= 54+0) { write (i); i++; }
 451 acc8= constant 54
 452 acc8+ constant 0
 453 acc16= variable 2
 454 acc16CompareAcc8
 455 brgt 462
 456 acc16= variable 2
 457 call writeAcc16
 458 incr16 variable 2
 459 br 451
 460 ;test1.j(150)   // integer - integer
 461 ;test1.j(151)   b=i;
 462 acc16= variable 2
 463 acc16=> variable 0
 464 ;test1.j(152)   i=1098;
 465 acc16= constant 1098
 466 acc16=> variable 2
 467 ;test1.j(153)   while (i <= 1099+0) { write (b); b++; i++; }
 468 acc16= constant 1099
 469 acc16+ constant 0
 470 acc16Comp variable 2
 471 brlt 482
 472 acc8= variable 0
 473 call writeAcc8
 474 incr8 variable 0
 475 incr16 variable 2
 476 br 468
 477 ;test1.j(154) 
 478 ;test1.j(155)   /************************/
 479 ;test1.j(156)   // var - constant
 480 ;test1.j(157)   // byte - byte
 481 ;test1.j(158)   while (b <= 58) { write (b); b++; }
 482 acc8= variable 0
 483 acc8Comp constant 58
 484 brgt 494
 485 acc8= variable 0
 486 call writeAcc8
 487 incr8 variable 0
 488 br 482
 489 ;test1.j(159)   // byte - integer
 490 ;test1.j(160)   //not relevant
 491 ;test1.j(161) 
 492 ;test1.j(162)   // integer - byte
 493 ;test1.j(163)   i=b;
 494 acc8= variable 0
 495 acc8=> variable 2
 496 ;test1.j(164)   while (i <= 60) { write (i); i++; }
 497 acc16= variable 2
 498 acc8= constant 60
 499 acc16CompareAcc8
 500 brgt 507
 501 acc16= variable 2
 502 call writeAcc16
 503 incr16 variable 2
 504 br 497
 505 ;test1.j(165)   // integer - integer
 506 ;test1.j(166)   i2=1090;
 507 acc16= constant 1090
 508 acc16=> variable 4
 509 ;test1.j(167)   while (i2 <= 1091) { write (i); i++; i2++; }
 510 acc16= variable 4
 511 acc16Comp constant 1091
 512 brgt 524
 513 acc16= variable 2
 514 call writeAcc16
 515 incr16 variable 2
 516 incr16 variable 4
 517 br 510
 518 ;test1.j(168) 
 519 ;test1.j(169)   /************************/
 520 ;test1.j(170)   // acc - stack8
 521 ;test1.j(171)   // byte - byte
 522 ;test1.j(172)   //TODO
 523 ;test1.j(173)   write(63);
 524 acc8= constant 63
 525 call writeAcc8
 526 ;test1.j(174)   write(64);
 527 acc8= constant 64
 528 call writeAcc8
 529 ;test1.j(175)   // byte - integer
 530 ;test1.j(176)   //TODO
 531 ;test1.j(177)   write(65);
 532 acc8= constant 65
 533 call writeAcc8
 534 ;test1.j(178)   write(66);
 535 acc8= constant 66
 536 call writeAcc8
 537 ;test1.j(179)   // integer - byte
 538 ;test1.j(180)   //TODO
 539 ;test1.j(181)   write(67);
 540 acc8= constant 67
 541 call writeAcc8
 542 ;test1.j(182)   write(68);
 543 acc8= constant 68
 544 call writeAcc8
 545 ;test1.j(183)   // integer - integer
 546 ;test1.j(184)   //TODO
 547 ;test1.j(185)   write(69);
 548 acc8= constant 69
 549 call writeAcc8
 550 ;test1.j(186)   write(70);
 551 acc8= constant 70
 552 call writeAcc8
 553 ;test1.j(187) 
 554 ;test1.j(188)   /************************/
 555 ;test1.j(189)   // acc - stack16
 556 ;test1.j(190)   // byte - byte
 557 ;test1.j(191)   //TODO
 558 ;test1.j(192)   write(71);
 559 acc8= constant 71
 560 call writeAcc8
 561 ;test1.j(193)   write(72);
 562 acc8= constant 72
 563 call writeAcc8
 564 ;test1.j(194)   // byte - integer
 565 ;test1.j(195)   //TODO
 566 ;test1.j(196)   write(73);
 567 acc8= constant 73
 568 call writeAcc8
 569 ;test1.j(197)   write(74);
 570 acc8= constant 74
 571 call writeAcc8
 572 ;test1.j(198)   // integer - byte
 573 ;test1.j(199)   //TODO
 574 ;test1.j(200)   write(75);
 575 acc8= constant 75
 576 call writeAcc8
 577 ;test1.j(201)   write(76);
 578 acc8= constant 76
 579 call writeAcc8
 580 ;test1.j(202)   // integer - integer
 581 ;test1.j(203)   //TODO
 582 ;test1.j(204)   write(77);
 583 acc8= constant 77
 584 call writeAcc8
 585 ;test1.j(205)   write(78);
 586 acc8= constant 78
 587 call writeAcc8
 588 ;test1.j(206) 
 589 ;test1.j(207)   /************************/
 590 ;test1.j(208)   // acc - var
 591 ;test1.j(209)   // byte - byte
 592 ;test1.j(210)   b=79;
 593 acc8= constant 79
 594 acc8=> variable 0
 595 ;test1.j(211)   b2=79;
 596 acc8= constant 79
 597 acc8=> variable 1
 598 ;test1.j(212)   while (78+0 <= b2) { write (b); b++; b2--; }
 599 acc8= constant 78
 600 acc8+ constant 0
 601 acc8Comp variable 1
 602 brgt 610
 603 acc8= variable 0
 604 call writeAcc8
 605 incr8 variable 0
 606 decr8 variable 1
 607 br 599
 608 ;test1.j(213)   // byte - integer
 609 ;test1.j(214)   i=79;
 610 acc8= constant 79
 611 acc8=> variable 2
 612 ;test1.j(215)   while (78+0 <= i) { write (b); b++; i--; }
 613 acc8= constant 78
 614 acc8+ constant 0
 615 acc16= variable 2
 616 acc8CompareAcc16
 617 brgt 625
 618 acc8= variable 0
 619 call writeAcc8
 620 incr8 variable 0
 621 decr16 variable 2
 622 br 613
 623 ;test1.j(216)   // integer - byte
 624 ;test1.j(217)   i=78;
 625 acc8= constant 78
 626 acc8=> variable 2
 627 ;test1.j(218)   b2=79;
 628 acc8= constant 79
 629 acc8=> variable 1
 630 ;test1.j(219)   while (i+0 <= b2) { write (b); b++; b2--; } 
 631 acc16= variable 2
 632 acc16+ constant 0
 633 acc8= variable 1
 634 acc16CompareAcc8
 635 brgt 643
 636 acc8= variable 0
 637 call writeAcc8
 638 incr8 variable 0
 639 decr8 variable 1
 640 br 631
 641 ;test1.j(220)   // integer - integer
 642 ;test1.j(221)   i=1066;
 643 acc16= constant 1066
 644 acc16=> variable 2
 645 ;test1.j(222)   while (1000+65 <= i) { write (b); b++; i--; }
 646 acc16= constant 1000
 647 acc16+ constant 65
 648 acc16Comp variable 2
 649 brgt 660
 650 acc8= variable 0
 651 call writeAcc8
 652 incr8 variable 0
 653 decr16 variable 2
 654 br 646
 655 ;test1.j(223) 
 656 ;test1.j(224)   /************************/
 657 ;test1.j(225)   // acc - acc
 658 ;test1.j(226)   // byte - byte
 659 ;test1.j(227)   b=87;
 660 acc8= constant 87
 661 acc8=> variable 0
 662 ;test1.j(228)   b2=64;
 663 acc8= constant 64
 664 acc8=> variable 1
 665 ;test1.j(229)   while (63+0 <= b2+0) { write (b); b++; b2--; }
 666 acc8= constant 63
 667 acc8+ constant 0
 668 <acc8
 669 acc8= variable 1
 670 acc8+ constant 0
 671 revAcc8Comp unstack8
 672 brlt 680
 673 acc8= variable 0
 674 call writeAcc8
 675 incr8 variable 0
 676 decr8 variable 1
 677 br 666
 678 ;test1.j(230)   // byte - integer
 679 ;test1.j(231)   i=62;
 680 acc8= constant 62
 681 acc8=> variable 2
 682 ;test1.j(232)   while (61+0 <= i+0) { write (b); b++; i--; }
 683 acc8= constant 61
 684 acc8+ constant 0
 685 <acc8
 686 acc16= variable 2
 687 acc16+ constant 0
 688 acc8= unstack8
 689 acc8CompareAcc16
 690 brgt 698
 691 acc8= variable 0
 692 call writeAcc8
 693 incr8 variable 0
 694 decr16 variable 2
 695 br 683
 696 ;test1.j(233)   // integer - byte
 697 ;test1.j(234)   i=59;
 698 acc8= constant 59
 699 acc8=> variable 2
 700 ;test1.j(235)   b2=60;
 701 acc8= constant 60
 702 acc8=> variable 1
 703 ;test1.j(236)   while (i+0 <= b2+0) { write (b); b++; b2--; }
 704 acc16= variable 2
 705 acc16+ constant 0
 706 <acc16
 707 acc8= variable 1
 708 acc8+ constant 0
 709 acc16= unstack16
 710 acc16CompareAcc8
 711 brgt 719
 712 acc8= variable 0
 713 call writeAcc8
 714 incr8 variable 0
 715 decr8 variable 1
 716 br 704
 717 ;test1.j(237)   // integer - integer
 718 ;test1.j(238)   i=1058;
 719 acc16= constant 1058
 720 acc16=> variable 2
 721 ;test1.j(239)   while (1000+57 <= i+0) { write (b); b++; i--; }
 722 acc16= constant 1000
 723 acc16+ constant 57
 724 <acc16
 725 acc16= variable 2
 726 acc16+ constant 0
 727 revAcc16Comp unstack16
 728 brlt 739
 729 acc8= variable 0
 730 call writeAcc8
 731 incr8 variable 0
 732 decr16 variable 2
 733 br 722
 734 ;test1.j(240) 
 735 ;test1.j(241)   /************************/
 736 ;test1.j(242)   // acc - constant
 737 ;test1.j(243)   // byte - byte
 738 ;test1.j(244)   while (b+0 <= 96) { write (b); b++; }
 739 acc8= variable 0
 740 acc8+ constant 0
 741 acc8Comp constant 96
 742 brgt 751
 743 acc8= variable 0
 744 call writeAcc8
 745 incr8 variable 0
 746 br 739
 747 ;test1.j(245)   // byte - integer
 748 ;test1.j(246)   //not relevant
 749 ;test1.j(247)   // integer - byte
 750 ;test1.j(248)   i=b;
 751 acc8= variable 0
 752 acc8=> variable 2
 753 ;test1.j(249)   while (i+0 <= 98) { write (i); i++; }
 754 acc16= variable 2
 755 acc16+ constant 0
 756 acc8= constant 98
 757 acc16CompareAcc8
 758 brgt 764
 759 acc16= variable 2
 760 call writeAcc16
 761 incr16 variable 2
 762 br 754
 763 ;test1.j(250)   b=i;
 764 acc16= variable 2
 765 acc16=> variable 0
 766 ;test1.j(251)   i=1052;
 767 acc16= constant 1052
 768 acc16=> variable 2
 769 ;test1.j(252)   // integer - integer
 770 ;test1.j(253)   while (i+0 <= 1053) { write (b); b++; i++; }
 771 acc16= variable 2
 772 acc16+ constant 0
 773 acc16Comp constant 1053
 774 brgt 786
 775 acc8= variable 0
 776 call writeAcc8
 777 incr8 variable 0
 778 incr16 variable 2
 779 br 771
 780 ;test1.j(254) 
 781 ;test1.j(255)   /************************/
 782 ;test1.j(256)   // constant - stack8
 783 ;test1.j(257)   // byte - byte
 784 ;test1.j(258)   //TODO
 785 ;test1.j(259)   write(101);
 786 acc8= constant 101
 787 call writeAcc8
 788 ;test1.j(260)   write(102);
 789 acc8= constant 102
 790 call writeAcc8
 791 ;test1.j(261)   // constant - stack8
 792 ;test1.j(262)   // byte - integer
 793 ;test1.j(263)   //TODO
 794 ;test1.j(264)   write(103);
 795 acc8= constant 103
 796 call writeAcc8
 797 ;test1.j(265)   write(104);
 798 acc8= constant 104
 799 call writeAcc8
 800 ;test1.j(266)   // constant - stack8
 801 ;test1.j(267)   // integer - byte
 802 ;test1.j(268)   //TODO
 803 ;test1.j(269)   write(105);
 804 acc8= constant 105
 805 call writeAcc8
 806 ;test1.j(270)   write(106);
 807 acc8= constant 106
 808 call writeAcc8
 809 ;test1.j(271)   // constant - stack88
 810 ;test1.j(272)   // integer - integer
 811 ;test1.j(273)   //TODO
 812 ;test1.j(274)   write(107);
 813 acc8= constant 107
 814 call writeAcc8
 815 ;test1.j(275)   write(108);
 816 acc8= constant 108
 817 call writeAcc8
 818 ;test1.j(276) 
 819 ;test1.j(277)   /************************/
 820 ;test1.j(278)   // constant - stack16
 821 ;test1.j(279)   // byte - byte
 822 ;test1.j(280)   //TODO
 823 ;test1.j(281)   write(109);
 824 acc8= constant 109
 825 call writeAcc8
 826 ;test1.j(282)   write(110);
 827 acc8= constant 110
 828 call writeAcc8
 829 ;test1.j(283)   // constant - stack16
 830 ;test1.j(284)   // byte - integer
 831 ;test1.j(285)   //TODO
 832 ;test1.j(286)   write(111);
 833 acc8= constant 111
 834 call writeAcc8
 835 ;test1.j(287)   write(112);
 836 acc8= constant 112
 837 call writeAcc8
 838 ;test1.j(288)   // constant - stack16
 839 ;test1.j(289)   // integer - byte
 840 ;test1.j(290)   //TODO
 841 ;test1.j(291)   write(113);
 842 acc8= constant 113
 843 call writeAcc8
 844 ;test1.j(292)   write(114);
 845 acc8= constant 114
 846 call writeAcc8
 847 ;test1.j(293)   // constant - stack16
 848 ;test1.j(294)   // integer - integer
 849 ;test1.j(295)   //TODO
 850 ;test1.j(296)   write(115);
 851 acc8= constant 115
 852 call writeAcc8
 853 ;test1.j(297)   write(116);
 854 acc8= constant 116
 855 call writeAcc8
 856 ;test1.j(298) 
 857 ;test1.j(299)   write("Klaar");
 858 acc16= constant 862
 859 writeString
 860 ;test1.j(300) }
 861 stop
 862 stringConstant 0 = "Klaar"
