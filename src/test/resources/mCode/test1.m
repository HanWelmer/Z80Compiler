   0 ;test1.j(0) /* Program to test generated Z80 assembler code */
   1 ;test1.j(1) class TestWhile {
   2 class TestWhile []
   3 ;test1.j(2)   private static byte b = 0;
   4 acc8= constant 0
   5 acc8=> variable 0
   6 ;test1.j(3)   private static byte b2 = 32;
   7 acc8= constant 32
   8 acc8=> variable 1
   9 ;test1.j(4)   private static word i = 110;
  10 acc8= constant 110
  11 acc8=> variable 2
  12 ;test1.j(5)   private static word i2 = 105;
  13 acc8= constant 105
  14 acc8=> variable 4
  15 ;test1.j(6)   private static word p = 12;
  16 acc8= constant 12
  17 acc8=> variable 6
  18 ;test1.j(7) 
  19 ;test1.j(8)   public static void main() {
  20 method main [public, static] void
  21 ;test1.j(9)     /*Possible operand types: 
  22 ;test1.j(10)      * constant, acc, var, stack8, stack16
  23 ;test1.j(11)      *Possible datatype combinations:
  24 ;test1.j(12)      * byte - byte
  25 ;test1.j(13)      * byte - integer
  26 ;test1.j(14)      * integer - byte
  27 ;test1.j(15)      * integer - integer
  28 ;test1.j(16)     */
  29 ;test1.j(17)   
  30 ;test1.j(18)     println(0);
  31 acc8= constant 0
  32 call writeLineAcc8
  33 ;test1.j(19)   
  34 ;test1.j(20)     /************************/
  35 ;test1.j(21)     // global variable within while scope
  36 ;test1.j(22)     b++;
  37 incr8 variable 0
  38 ;test1.j(23)     println (b);
  39 acc8= variable 0
  40 call writeLineAcc8
  41 ;test1.j(24)     while (b < 2) {
  42 acc8= variable 0
  43 acc8Comp constant 2
  44 brge 70
  45 ;test1.j(25)       b++;
  46 incr8 variable 0
  47 ;test1.j(26)       word j = 1001;
  48 acc16= constant 1001
  49 acc16=> variable 8
  50 ;test1.j(27)       byte c = b;
  51 acc8= variable 0
  52 acc8=> variable 10
  53 ;test1.j(28)       byte d = c;
  54 acc8= variable 10
  55 acc8=> variable 11
  56 ;test1.j(29)       println (c);
  57 acc8= variable 10
  58 call writeLineAcc8
  59 br 42
  60 ;test1.j(30)     }
  61 ;test1.j(31)   
  62 ;test1.j(32)     /************************/
  63 ;test1.j(33)     // constant - constant
  64 ;test1.j(34)     // not relevant
  65 ;test1.j(35)   
  66 ;test1.j(36)     /************************/
  67 ;test1.j(37)     // constant - acc
  68 ;test1.j(38)     // byte - byte
  69 ;test1.j(39)     b = 3;
  70 acc8= constant 3
  71 acc8=> variable 0
  72 ;test1.j(40)     while (3 == b+0) { println (b); b++; }
  73 acc8= variable 0
  74 acc8+ constant 0
  75 acc8Comp constant 3
  76 brne 82
  77 acc8= variable 0
  78 call writeLineAcc8
  79 incr8 variable 0
  80 br 73
  81 ;test1.j(41)     while (4 != b+0) { println (b); b++; }
  82 acc8= variable 0
  83 acc8+ constant 0
  84 acc8Comp constant 4
  85 breq 91
  86 acc8= variable 0
  87 call writeLineAcc8
  88 incr8 variable 0
  89 br 82
  90 ;test1.j(42)     while (6 > b+0) { println (b); b++; }
  91 acc8= variable 0
  92 acc8+ constant 0
  93 acc8Comp constant 6
  94 brge 100
  95 acc8= variable 0
  96 call writeLineAcc8
  97 incr8 variable 0
  98 br 91
  99 ;test1.j(43)     while (7 >= b+0) { println (b); b++; }
 100 acc8= variable 0
 101 acc8+ constant 0
 102 acc8Comp constant 7
 103 brgt 109
 104 acc8= variable 0
 105 call writeLineAcc8
 106 incr8 variable 0
 107 br 100
 108 ;test1.j(44)     p=8;
 109 acc8= constant 8
 110 acc8=> variable 6
 111 ;test1.j(45)     while (6 <  b+0) { println (p); p++; b--; }
 112 acc8= variable 0
 113 acc8+ constant 0
 114 acc8Comp constant 6
 115 brle 122
 116 acc16= variable 6
 117 call writeLineAcc16
 118 incr16 variable 6
 119 decr8 variable 0
 120 br 112
 121 ;test1.j(46)     while (5 <= b+0) { println (p); p++; b--; }
 122 acc8= variable 0
 123 acc8+ constant 0
 124 acc8Comp constant 5
 125 brlt 135
 126 acc16= variable 6
 127 call writeLineAcc16
 128 incr16 variable 6
 129 decr8 variable 0
 130 br 122
 131 ;test1.j(47)     
 132 ;test1.j(48)     // constant - acc
 133 ;test1.j(49)     // byte - integer
 134 ;test1.j(50)     i=12;
 135 acc8= constant 12
 136 acc8=> variable 2
 137 ;test1.j(51)     while (12 == i+0) { println (i); i++; }
 138 acc16= variable 2
 139 acc16+ constant 0
 140 acc8= constant 12
 141 acc8CompareAcc16
 142 brne 148
 143 acc16= variable 2
 144 call writeLineAcc16
 145 incr16 variable 2
 146 br 138
 147 ;test1.j(52)     while (15 != i+0) { println (i); i++; }
 148 acc16= variable 2
 149 acc16+ constant 0
 150 acc8= constant 15
 151 acc8CompareAcc16
 152 breq 158
 153 acc16= variable 2
 154 call writeLineAcc16
 155 incr16 variable 2
 156 br 148
 157 ;test1.j(53)     while (17 > i+0) { println (i); i++; }
 158 acc16= variable 2
 159 acc16+ constant 0
 160 acc8= constant 17
 161 acc8CompareAcc16
 162 brle 168
 163 acc16= variable 2
 164 call writeLineAcc16
 165 incr16 variable 2
 166 br 158
 167 ;test1.j(54)     while (18 >= i+0) { println (i); i++; }
 168 acc16= variable 2
 169 acc16+ constant 0
 170 acc8= constant 18
 171 acc8CompareAcc16
 172 brlt 178
 173 acc16= variable 2
 174 call writeLineAcc16
 175 incr16 variable 2
 176 br 168
 177 ;test1.j(55)     p=i;
 178 acc16= variable 2
 179 acc16=> variable 6
 180 ;test1.j(56)     while (17 <  i+0) { println (p); i--; p++; }
 181 acc16= variable 2
 182 acc16+ constant 0
 183 acc8= constant 17
 184 acc8CompareAcc16
 185 brge 192
 186 acc16= variable 6
 187 call writeLineAcc16
 188 decr16 variable 2
 189 incr16 variable 6
 190 br 181
 191 ;test1.j(57)     while (16 <= i+0) { println (p); i--; p++; }
 192 acc16= variable 2
 193 acc16+ constant 0
 194 acc8= constant 16
 195 acc8CompareAcc16
 196 brgt 210
 197 acc16= variable 6
 198 call writeLineAcc16
 199 decr16 variable 2
 200 incr16 variable 6
 201 br 192
 202 ;test1.j(58)   
 203 ;test1.j(59)     // constant - acc
 204 ;test1.j(60)     // integer - byte
 205 ;test1.j(61)     // not relevant
 206 ;test1.j(62)   
 207 ;test1.j(63)     // constant - acc
 208 ;test1.j(64)     // integer - integer
 209 ;test1.j(65)     i=23;
 210 acc8= constant 23
 211 acc8=> variable 2
 212 ;test1.j(66)     while (23 == i+0) { println (i); i++; }
 213 acc16= variable 2
 214 acc16+ constant 0
 215 acc8= constant 23
 216 acc8CompareAcc16
 217 brne 223
 218 acc16= variable 2
 219 call writeLineAcc16
 220 incr16 variable 2
 221 br 213
 222 ;test1.j(67)     while (26 != i+0) { println (i); i++; }
 223 acc16= variable 2
 224 acc16+ constant 0
 225 acc8= constant 26
 226 acc8CompareAcc16
 227 breq 233
 228 acc16= variable 2
 229 call writeLineAcc16
 230 incr16 variable 2
 231 br 223
 232 ;test1.j(68)     while (28 > i+0) { println (i); i++; }
 233 acc16= variable 2
 234 acc16+ constant 0
 235 acc8= constant 28
 236 acc8CompareAcc16
 237 brle 243
 238 acc16= variable 2
 239 call writeLineAcc16
 240 incr16 variable 2
 241 br 233
 242 ;test1.j(69)     while (29 >= i+0) { println (i); i++; }
 243 acc16= variable 2
 244 acc16+ constant 0
 245 acc8= constant 29
 246 acc8CompareAcc16
 247 brlt 253
 248 acc16= variable 2
 249 call writeLineAcc16
 250 incr16 variable 2
 251 br 243
 252 ;test1.j(70)     p=i;
 253 acc16= variable 2
 254 acc16=> variable 6
 255 ;test1.j(71)     while (28 <  i+0) { println (p); p++; i--; }
 256 acc16= variable 2
 257 acc16+ constant 0
 258 acc8= constant 28
 259 acc8CompareAcc16
 260 brge 267
 261 acc16= variable 6
 262 call writeLineAcc16
 263 incr16 variable 6
 264 decr16 variable 2
 265 br 256
 266 ;test1.j(72)     while (27 <= i+0) { println (p); p++; i--; }
 267 acc16= variable 2
 268 acc16+ constant 0
 269 acc8= constant 27
 270 acc8CompareAcc16
 271 brgt 282
 272 acc16= variable 6
 273 call writeLineAcc16
 274 incr16 variable 6
 275 decr16 variable 2
 276 br 267
 277 ;test1.j(73)   
 278 ;test1.j(74)     /************************/
 279 ;test1.j(75)     // constant - var
 280 ;test1.j(76)     // byte - byte
 281 ;test1.j(77)     b=35;
 282 acc8= constant 35
 283 acc8=> variable 0
 284 ;test1.j(78)     while (33 <= b) { println (p); p++; b--; }
 285 acc8= variable 0
 286 acc8Comp constant 33
 287 brlt 296
 288 acc16= variable 6
 289 call writeLineAcc16
 290 incr16 variable 6
 291 decr8 variable 0
 292 br 285
 293 ;test1.j(79)     // constant - var
 294 ;test1.j(80)     // byte - integer
 295 ;test1.j(81)     i=37;
 296 acc8= constant 37
 297 acc8=> variable 2
 298 ;test1.j(82)     while (36 <= i) { println (p); p++; i--; }
 299 acc16= variable 2
 300 acc8= constant 36
 301 acc8CompareAcc16
 302 brgt 315
 303 acc16= variable 6
 304 call writeLineAcc16
 305 incr16 variable 6
 306 decr16 variable 2
 307 br 299
 308 ;test1.j(83)     // constant - var
 309 ;test1.j(84)     // integer - byte
 310 ;test1.j(85)     // not relevant
 311 ;test1.j(86)   
 312 ;test1.j(87)     // constant - var
 313 ;test1.j(88)     // integer - integer
 314 ;test1.j(89)     while (34 <= i) { println (p); p++; i--; }
 315 acc16= variable 2
 316 acc8= constant 34
 317 acc8CompareAcc16
 318 brgt 361
 319 acc16= variable 6
 320 call writeLineAcc16
 321 incr16 variable 6
 322 decr16 variable 2
 323 br 315
 324 ;test1.j(90)   
 325 ;test1.j(91)     /************************/
 326 ;test1.j(92)     // stack8 - constant
 327 ;test1.j(93)     // stack8 - acc
 328 ;test1.j(94)     // stack8 - var
 329 ;test1.j(95)     // stack8 - stack8
 330 ;test1.j(96)     // stack8 - stack16
 331 ;test1.j(97)     //TODO
 332 ;test1.j(98)   
 333 ;test1.j(99)     /************************/
 334 ;test1.j(100)     // stack16 - constant
 335 ;test1.j(101)     // stack16 - acc
 336 ;test1.j(102)     // stack16 - var
 337 ;test1.j(103)     // stack16 - stack8
 338 ;test1.j(104)     // stack16 - stack16
 339 ;test1.j(105)     //TODO
 340 ;test1.j(106)   
 341 ;test1.j(107)     /************************/
 342 ;test1.j(108)     // var - stack16
 343 ;test1.j(109)     // byte - byte
 344 ;test1.j(110)     // byte - integer
 345 ;test1.j(111)     // integer - byte
 346 ;test1.j(112)     // integer - integer
 347 ;test1.j(113)     //TODO
 348 ;test1.j(114)   
 349 ;test1.j(115)     /************************/
 350 ;test1.j(116)     // var - stack8
 351 ;test1.j(117)     // byte - byte
 352 ;test1.j(118)     // byte - integer
 353 ;test1.j(119)     // integer - byte
 354 ;test1.j(120)     // integer - integer
 355 ;test1.j(121)     //TODO
 356 ;test1.j(122)   
 357 ;test1.j(123)     /************************/
 358 ;test1.j(124)     // var - var
 359 ;test1.j(125)     // byte - byte
 360 ;test1.j(126)     b=33;
 361 acc8= constant 33
 362 acc8=> variable 0
 363 ;test1.j(127)     while (b2 <= b) { println (p); p++; b--; }
 364 acc8= variable 1
 365 acc8Comp variable 0
 366 brgt 374
 367 acc16= variable 6
 368 call writeLineAcc16
 369 incr16 variable 6
 370 decr8 variable 0
 371 br 364
 372 ;test1.j(128)     // byte - integer
 373 ;test1.j(129)     i = 33;
 374 acc8= constant 33
 375 acc8=> variable 2
 376 ;test1.j(130)     while (b2 <= i) { println (p); p++; i--; }
 377 acc8= variable 1
 378 acc16= variable 2
 379 acc8CompareAcc16
 380 brgt 388
 381 acc16= variable 6
 382 call writeLineAcc16
 383 incr16 variable 6
 384 decr16 variable 2
 385 br 377
 386 ;test1.j(131)     // integer - byte
 387 ;test1.j(132)     b=33;
 388 acc8= constant 33
 389 acc8=> variable 0
 390 ;test1.j(133)     i=b2;
 391 acc8= variable 1
 392 acc8=> variable 2
 393 ;test1.j(134)     while (i <= b) { println (p); p++; b--; }
 394 acc16= variable 2
 395 acc8= variable 0
 396 acc16CompareAcc8
 397 brgt 405
 398 acc16= variable 6
 399 call writeLineAcc16
 400 incr16 variable 6
 401 decr8 variable 0
 402 br 394
 403 ;test1.j(135)     // integer - integer
 404 ;test1.j(136)     i=33;
 405 acc8= constant 33
 406 acc8=> variable 2
 407 ;test1.j(137)     i2=b2;
 408 acc8= variable 1
 409 acc8=> variable 4
 410 ;test1.j(138)     while (i2 <= i) { println (p); p++; i--; }
 411 acc16= variable 4
 412 acc16Comp variable 2
 413 brgt 424
 414 acc16= variable 6
 415 call writeLineAcc16
 416 incr16 variable 6
 417 decr16 variable 2
 418 br 411
 419 ;test1.j(139)   
 420 ;test1.j(140)     /************************/
 421 ;test1.j(141)     // var - acc
 422 ;test1.j(142)     // byte - byte
 423 ;test1.j(143)     b=49;
 424 acc8= constant 49
 425 acc8=> variable 0
 426 ;test1.j(144)     while (b <= 50+0) { println (b); b++; }
 427 acc8= constant 50
 428 acc8+ constant 0
 429 acc8Comp variable 0
 430 brlt 437
 431 acc8= variable 0
 432 call writeLineAcc8
 433 incr8 variable 0
 434 br 427
 435 ;test1.j(145)     // byte - integer
 436 ;test1.j(146)     i=52;
 437 acc8= constant 52
 438 acc8=> variable 2
 439 ;test1.j(147)     while (b <= i+0) { println (b); b++; }
 440 acc16= variable 2
 441 acc16+ constant 0
 442 acc8= variable 0
 443 acc8CompareAcc16
 444 brgt 451
 445 acc8= variable 0
 446 call writeLineAcc8
 447 incr8 variable 0
 448 br 440
 449 ;test1.j(148)     // integer - byte
 450 ;test1.j(149)     i=b;
 451 acc8= variable 0
 452 acc8=> variable 2
 453 ;test1.j(150)     while (i <= 54+0) { println (i); i++; }
 454 acc8= constant 54
 455 acc8+ constant 0
 456 acc16= variable 2
 457 acc16CompareAcc8
 458 brgt 465
 459 acc16= variable 2
 460 call writeLineAcc16
 461 incr16 variable 2
 462 br 454
 463 ;test1.j(151)     // integer - integer
 464 ;test1.j(152)     b=i;
 465 acc16= variable 2
 466 acc16=> variable 0
 467 ;test1.j(153)     i=1098;
 468 acc16= constant 1098
 469 acc16=> variable 2
 470 ;test1.j(154)     while (i <= 1099+0) { println (b); b++; i++; }
 471 acc16= constant 1099
 472 acc16+ constant 0
 473 acc16Comp variable 2
 474 brlt 485
 475 acc8= variable 0
 476 call writeLineAcc8
 477 incr8 variable 0
 478 incr16 variable 2
 479 br 471
 480 ;test1.j(155)   
 481 ;test1.j(156)     /************************/
 482 ;test1.j(157)     // var - constant
 483 ;test1.j(158)     // byte - byte
 484 ;test1.j(159)     while (b <= 58) { println (b); b++; }
 485 acc8= variable 0
 486 acc8Comp constant 58
 487 brgt 497
 488 acc8= variable 0
 489 call writeLineAcc8
 490 incr8 variable 0
 491 br 485
 492 ;test1.j(160)     // byte - integer
 493 ;test1.j(161)     //not relevant
 494 ;test1.j(162)   
 495 ;test1.j(163)     // integer - byte
 496 ;test1.j(164)     i=b;
 497 acc8= variable 0
 498 acc8=> variable 2
 499 ;test1.j(165)     while (i <= 60) { println (i); i++; }
 500 acc16= variable 2
 501 acc8= constant 60
 502 acc16CompareAcc8
 503 brgt 510
 504 acc16= variable 2
 505 call writeLineAcc16
 506 incr16 variable 2
 507 br 500
 508 ;test1.j(166)     // integer - integer
 509 ;test1.j(167)     i2=1090;
 510 acc16= constant 1090
 511 acc16=> variable 4
 512 ;test1.j(168)     while (i2 <= 1091) { println (i); i++; i2++; }
 513 acc16= variable 4
 514 acc16Comp constant 1091
 515 brgt 527
 516 acc16= variable 2
 517 call writeLineAcc16
 518 incr16 variable 2
 519 incr16 variable 4
 520 br 513
 521 ;test1.j(169)   
 522 ;test1.j(170)     /************************/
 523 ;test1.j(171)     // acc - stack8
 524 ;test1.j(172)     // byte - byte
 525 ;test1.j(173)     //TODO
 526 ;test1.j(174)     println(63);
 527 acc8= constant 63
 528 call writeLineAcc8
 529 ;test1.j(175)     println(64);
 530 acc8= constant 64
 531 call writeLineAcc8
 532 ;test1.j(176)     // byte - integer
 533 ;test1.j(177)     //TODO
 534 ;test1.j(178)     println(65);
 535 acc8= constant 65
 536 call writeLineAcc8
 537 ;test1.j(179)     println(66);
 538 acc8= constant 66
 539 call writeLineAcc8
 540 ;test1.j(180)     // integer - byte
 541 ;test1.j(181)     //TODO
 542 ;test1.j(182)     println(67);
 543 acc8= constant 67
 544 call writeLineAcc8
 545 ;test1.j(183)     println(68);
 546 acc8= constant 68
 547 call writeLineAcc8
 548 ;test1.j(184)     // integer - integer
 549 ;test1.j(185)     //TODO
 550 ;test1.j(186)     println(69);
 551 acc8= constant 69
 552 call writeLineAcc8
 553 ;test1.j(187)     println(70);
 554 acc8= constant 70
 555 call writeLineAcc8
 556 ;test1.j(188)   
 557 ;test1.j(189)     /************************/
 558 ;test1.j(190)     // acc - stack16
 559 ;test1.j(191)     // byte - byte
 560 ;test1.j(192)     //TODO
 561 ;test1.j(193)     println(71);
 562 acc8= constant 71
 563 call writeLineAcc8
 564 ;test1.j(194)     println(72);
 565 acc8= constant 72
 566 call writeLineAcc8
 567 ;test1.j(195)     // byte - integer
 568 ;test1.j(196)     //TODO
 569 ;test1.j(197)     println(73);
 570 acc8= constant 73
 571 call writeLineAcc8
 572 ;test1.j(198)     println(74);
 573 acc8= constant 74
 574 call writeLineAcc8
 575 ;test1.j(199)     // integer - byte
 576 ;test1.j(200)     //TODO
 577 ;test1.j(201)     println(75);
 578 acc8= constant 75
 579 call writeLineAcc8
 580 ;test1.j(202)     println(76);
 581 acc8= constant 76
 582 call writeLineAcc8
 583 ;test1.j(203)     // integer - integer
 584 ;test1.j(204)     //TODO
 585 ;test1.j(205)     println(77);
 586 acc8= constant 77
 587 call writeLineAcc8
 588 ;test1.j(206)     println(78);
 589 acc8= constant 78
 590 call writeLineAcc8
 591 ;test1.j(207)   
 592 ;test1.j(208)     /************************/
 593 ;test1.j(209)     // acc - var
 594 ;test1.j(210)     // byte - byte
 595 ;test1.j(211)     b=79;
 596 acc8= constant 79
 597 acc8=> variable 0
 598 ;test1.j(212)     b2=79;
 599 acc8= constant 79
 600 acc8=> variable 1
 601 ;test1.j(213)     while (78+0 <= b2) { println (b); b++; b2--; }
 602 acc8= constant 78
 603 acc8+ constant 0
 604 acc8Comp variable 1
 605 brgt 613
 606 acc8= variable 0
 607 call writeLineAcc8
 608 incr8 variable 0
 609 decr8 variable 1
 610 br 602
 611 ;test1.j(214)     // byte - integer
 612 ;test1.j(215)     i=79;
 613 acc8= constant 79
 614 acc8=> variable 2
 615 ;test1.j(216)     while (78+0 <= i) { println (b); b++; i--; }
 616 acc8= constant 78
 617 acc8+ constant 0
 618 acc16= variable 2
 619 acc8CompareAcc16
 620 brgt 628
 621 acc8= variable 0
 622 call writeLineAcc8
 623 incr8 variable 0
 624 decr16 variable 2
 625 br 616
 626 ;test1.j(217)     // integer - byte
 627 ;test1.j(218)     i=78;
 628 acc8= constant 78
 629 acc8=> variable 2
 630 ;test1.j(219)     b2=79;
 631 acc8= constant 79
 632 acc8=> variable 1
 633 ;test1.j(220)     while (i+0 <= b2) { println (b); b++; b2--; } 
 634 acc16= variable 2
 635 acc16+ constant 0
 636 acc8= variable 1
 637 acc16CompareAcc8
 638 brgt 646
 639 acc8= variable 0
 640 call writeLineAcc8
 641 incr8 variable 0
 642 decr8 variable 1
 643 br 634
 644 ;test1.j(221)     // integer - integer
 645 ;test1.j(222)     i=1066;
 646 acc16= constant 1066
 647 acc16=> variable 2
 648 ;test1.j(223)     while (1000+65 <= i) { println (b); b++; i--; }
 649 acc16= constant 1000
 650 acc16+ constant 65
 651 acc16Comp variable 2
 652 brgt 663
 653 acc8= variable 0
 654 call writeLineAcc8
 655 incr8 variable 0
 656 decr16 variable 2
 657 br 649
 658 ;test1.j(224)   
 659 ;test1.j(225)     /************************/
 660 ;test1.j(226)     // acc - acc
 661 ;test1.j(227)     // byte - byte
 662 ;test1.j(228)     b=87;
 663 acc8= constant 87
 664 acc8=> variable 0
 665 ;test1.j(229)     b2=64;
 666 acc8= constant 64
 667 acc8=> variable 1
 668 ;test1.j(230)     while (63+0 <= b2+0) { println (b); b++; b2--; }
 669 acc8= constant 63
 670 acc8+ constant 0
 671 <acc8
 672 acc8= variable 1
 673 acc8+ constant 0
 674 revAcc8Comp unstack8
 675 brlt 683
 676 acc8= variable 0
 677 call writeLineAcc8
 678 incr8 variable 0
 679 decr8 variable 1
 680 br 669
 681 ;test1.j(231)     // byte - integer
 682 ;test1.j(232)     i=62;
 683 acc8= constant 62
 684 acc8=> variable 2
 685 ;test1.j(233)     while (61+0 <= i+0) { println (b); b++; i--; }
 686 acc8= constant 61
 687 acc8+ constant 0
 688 <acc8
 689 acc16= variable 2
 690 acc16+ constant 0
 691 acc8= unstack8
 692 acc8CompareAcc16
 693 brgt 701
 694 acc8= variable 0
 695 call writeLineAcc8
 696 incr8 variable 0
 697 decr16 variable 2
 698 br 686
 699 ;test1.j(234)     // integer - byte
 700 ;test1.j(235)     i=59;
 701 acc8= constant 59
 702 acc8=> variable 2
 703 ;test1.j(236)     b2=60;
 704 acc8= constant 60
 705 acc8=> variable 1
 706 ;test1.j(237)     while (i+0 <= b2+0) { println (b); b++; b2--; }
 707 acc16= variable 2
 708 acc16+ constant 0
 709 <acc16
 710 acc8= variable 1
 711 acc8+ constant 0
 712 acc16= unstack16
 713 acc16CompareAcc8
 714 brgt 722
 715 acc8= variable 0
 716 call writeLineAcc8
 717 incr8 variable 0
 718 decr8 variable 1
 719 br 707
 720 ;test1.j(238)     // integer - integer
 721 ;test1.j(239)     i=1058;
 722 acc16= constant 1058
 723 acc16=> variable 2
 724 ;test1.j(240)     while (1000+57 <= i+0) { println (b); b++; i--; }
 725 acc16= constant 1000
 726 acc16+ constant 57
 727 <acc16
 728 acc16= variable 2
 729 acc16+ constant 0
 730 revAcc16Comp unstack16
 731 brlt 742
 732 acc8= variable 0
 733 call writeLineAcc8
 734 incr8 variable 0
 735 decr16 variable 2
 736 br 725
 737 ;test1.j(241)   
 738 ;test1.j(242)     /************************/
 739 ;test1.j(243)     // acc - constant
 740 ;test1.j(244)     // byte - byte
 741 ;test1.j(245)     while (b+0 <= 96) { println (b); b++; }
 742 acc8= variable 0
 743 acc8+ constant 0
 744 acc8Comp constant 96
 745 brgt 754
 746 acc8= variable 0
 747 call writeLineAcc8
 748 incr8 variable 0
 749 br 742
 750 ;test1.j(246)     // byte - integer
 751 ;test1.j(247)     //not relevant
 752 ;test1.j(248)     // integer - byte
 753 ;test1.j(249)     i=b;
 754 acc8= variable 0
 755 acc8=> variable 2
 756 ;test1.j(250)     while (i+0 <= 98) { println (i); i++; }
 757 acc16= variable 2
 758 acc16+ constant 0
 759 acc8= constant 98
 760 acc16CompareAcc8
 761 brgt 767
 762 acc16= variable 2
 763 call writeLineAcc16
 764 incr16 variable 2
 765 br 757
 766 ;test1.j(251)     b=i;
 767 acc16= variable 2
 768 acc16=> variable 0
 769 ;test1.j(252)     i=1052;
 770 acc16= constant 1052
 771 acc16=> variable 2
 772 ;test1.j(253)     // integer - integer
 773 ;test1.j(254)     while (i+0 <= 1053) { println (b); b++; i++; }
 774 acc16= variable 2
 775 acc16+ constant 0
 776 acc16Comp constant 1053
 777 brgt 789
 778 acc8= variable 0
 779 call writeLineAcc8
 780 incr8 variable 0
 781 incr16 variable 2
 782 br 774
 783 ;test1.j(255)   
 784 ;test1.j(256)     /************************/
 785 ;test1.j(257)     // constant - stack8
 786 ;test1.j(258)     // byte - byte
 787 ;test1.j(259)     //TODO
 788 ;test1.j(260)     println(101);
 789 acc8= constant 101
 790 call writeLineAcc8
 791 ;test1.j(261)     println(102);
 792 acc8= constant 102
 793 call writeLineAcc8
 794 ;test1.j(262)     // constant - stack8
 795 ;test1.j(263)     // byte - integer
 796 ;test1.j(264)     //TODO
 797 ;test1.j(265)     println(103);
 798 acc8= constant 103
 799 call writeLineAcc8
 800 ;test1.j(266)     println(104);
 801 acc8= constant 104
 802 call writeLineAcc8
 803 ;test1.j(267)     // constant - stack8
 804 ;test1.j(268)     // integer - byte
 805 ;test1.j(269)     //TODO
 806 ;test1.j(270)     println(105);
 807 acc8= constant 105
 808 call writeLineAcc8
 809 ;test1.j(271)     println(106);
 810 acc8= constant 106
 811 call writeLineAcc8
 812 ;test1.j(272)     // constant - stack88
 813 ;test1.j(273)     // integer - integer
 814 ;test1.j(274)     //TODO
 815 ;test1.j(275)     println(107);
 816 acc8= constant 107
 817 call writeLineAcc8
 818 ;test1.j(276)     println(108);
 819 acc8= constant 108
 820 call writeLineAcc8
 821 ;test1.j(277)   
 822 ;test1.j(278)     /************************/
 823 ;test1.j(279)     // constant - stack16
 824 ;test1.j(280)     // byte - byte
 825 ;test1.j(281)     //TODO
 826 ;test1.j(282)     println(109);
 827 acc8= constant 109
 828 call writeLineAcc8
 829 ;test1.j(283)     println(110);
 830 acc8= constant 110
 831 call writeLineAcc8
 832 ;test1.j(284)     // constant - stack16
 833 ;test1.j(285)     // byte - integer
 834 ;test1.j(286)     //TODO
 835 ;test1.j(287)     println(111);
 836 acc8= constant 111
 837 call writeLineAcc8
 838 ;test1.j(288)     println(112);
 839 acc8= constant 112
 840 call writeLineAcc8
 841 ;test1.j(289)     // constant - stack16
 842 ;test1.j(290)     // integer - byte
 843 ;test1.j(291)     //TODO
 844 ;test1.j(292)     println(113);
 845 acc8= constant 113
 846 call writeLineAcc8
 847 ;test1.j(293)     println(114);
 848 acc8= constant 114
 849 call writeLineAcc8
 850 ;test1.j(294)     // constant - stack16
 851 ;test1.j(295)     // integer - integer
 852 ;test1.j(296)     //TODO
 853 ;test1.j(297)     println(115);
 854 acc8= constant 115
 855 call writeLineAcc8
 856 ;test1.j(298)     println(116);
 857 acc8= constant 116
 858 call writeLineAcc8
 859 ;test1.j(299)   
 860 ;test1.j(300)     println("Klaar");
 861 acc16= constant 866
 862 writeLineString
 863 ;test1.j(301)   }
 864 ;test1.j(302) }
 865 stop
 866 stringConstant 0 = "Klaar"
