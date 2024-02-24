   0 call 22
   1 stop
   2 ;test1.j(0) /* Program to test generated Z80 assembler code */
   3 ;test1.j(1) class TestWhile {
   4 class TestWhile []
   5 ;test1.j(2)   private static byte b = 0;
   6 acc8= constant 0
   7 acc8=> variable 0
   8 ;test1.j(3)   private static byte b2 = 32;
   9 acc8= constant 32
  10 acc8=> variable 1
  11 ;test1.j(4)   private static word i = 110;
  12 acc8= constant 110
  13 acc8=> variable 2
  14 ;test1.j(5)   private static word i2 = 105;
  15 acc8= constant 105
  16 acc8=> variable 4
  17 ;test1.j(6)   private static word p = 12;
  18 acc8= constant 12
  19 acc8=> variable 6
  20 ;test1.j(7) 
  21 ;test1.j(8)   public static void main() {
  22 method main [public, static] void
  23 ;test1.j(9)     /*Possible operand types: 
  24 ;test1.j(10)      * constant, acc, var, stack8, stack16
  25 ;test1.j(11)      *Possible datatype combinations:
  26 ;test1.j(12)      * byte - byte
  27 ;test1.j(13)      * byte - integer
  28 ;test1.j(14)      * integer - byte
  29 ;test1.j(15)      * integer - integer
  30 ;test1.j(16)     */
  31 ;test1.j(17)   
  32 ;test1.j(18)     println(0);
  33 acc8= constant 0
  34 call writeLineAcc8
  35 ;test1.j(19)   
  36 ;test1.j(20)     /************************/
  37 ;test1.j(21)     // global variable within while scope
  38 ;test1.j(22)     b++;
  39 incr8 variable 0
  40 ;test1.j(23)     println (b);
  41 acc8= variable 0
  42 call writeLineAcc8
  43 ;test1.j(24)     while (b < 2) {
  44 acc8= variable 0
  45 acc8Comp constant 2
  46 brge 72
  47 ;test1.j(25)       b++;
  48 incr8 variable 0
  49 ;test1.j(26)       word j = 1001;
  50 acc16= constant 1001
  51 acc16=> variable 8
  52 ;test1.j(27)       byte c = b;
  53 acc8= variable 0
  54 acc8=> variable 10
  55 ;test1.j(28)       byte d = c;
  56 acc8= variable 10
  57 acc8=> variable 11
  58 ;test1.j(29)       println (c);
  59 acc8= variable 10
  60 call writeLineAcc8
  61 br 44
  62 ;test1.j(30)     }
  63 ;test1.j(31)   
  64 ;test1.j(32)     /************************/
  65 ;test1.j(33)     // constant - constant
  66 ;test1.j(34)     // not relevant
  67 ;test1.j(35)   
  68 ;test1.j(36)     /************************/
  69 ;test1.j(37)     // constant - acc
  70 ;test1.j(38)     // byte - byte
  71 ;test1.j(39)     b = 3;
  72 acc8= constant 3
  73 acc8=> variable 0
  74 ;test1.j(40)     while (3 == b+0) { println (b); b++; }
  75 acc8= variable 0
  76 acc8+ constant 0
  77 acc8Comp constant 3
  78 brne 84
  79 acc8= variable 0
  80 call writeLineAcc8
  81 incr8 variable 0
  82 br 75
  83 ;test1.j(41)     while (4 != b+0) { println (b); b++; }
  84 acc8= variable 0
  85 acc8+ constant 0
  86 acc8Comp constant 4
  87 breq 93
  88 acc8= variable 0
  89 call writeLineAcc8
  90 incr8 variable 0
  91 br 84
  92 ;test1.j(42)     while (6 > b+0) { println (b); b++; }
  93 acc8= variable 0
  94 acc8+ constant 0
  95 acc8Comp constant 6
  96 brge 102
  97 acc8= variable 0
  98 call writeLineAcc8
  99 incr8 variable 0
 100 br 93
 101 ;test1.j(43)     while (7 >= b+0) { println (b); b++; }
 102 acc8= variable 0
 103 acc8+ constant 0
 104 acc8Comp constant 7
 105 brgt 111
 106 acc8= variable 0
 107 call writeLineAcc8
 108 incr8 variable 0
 109 br 102
 110 ;test1.j(44)     p=8;
 111 acc8= constant 8
 112 acc8=> variable 6
 113 ;test1.j(45)     while (6 <  b+0) { println (p); p++; b--; }
 114 acc8= variable 0
 115 acc8+ constant 0
 116 acc8Comp constant 6
 117 brle 124
 118 acc16= variable 6
 119 call writeLineAcc16
 120 incr16 variable 6
 121 decr8 variable 0
 122 br 114
 123 ;test1.j(46)     while (5 <= b+0) { println (p); p++; b--; }
 124 acc8= variable 0
 125 acc8+ constant 0
 126 acc8Comp constant 5
 127 brlt 137
 128 acc16= variable 6
 129 call writeLineAcc16
 130 incr16 variable 6
 131 decr8 variable 0
 132 br 124
 133 ;test1.j(47)     
 134 ;test1.j(48)     // constant - acc
 135 ;test1.j(49)     // byte - integer
 136 ;test1.j(50)     i=12;
 137 acc8= constant 12
 138 acc8=> variable 2
 139 ;test1.j(51)     while (12 == i+0) { println (i); i++; }
 140 acc16= variable 2
 141 acc16+ constant 0
 142 acc8= constant 12
 143 acc8CompareAcc16
 144 brne 150
 145 acc16= variable 2
 146 call writeLineAcc16
 147 incr16 variable 2
 148 br 140
 149 ;test1.j(52)     while (15 != i+0) { println (i); i++; }
 150 acc16= variable 2
 151 acc16+ constant 0
 152 acc8= constant 15
 153 acc8CompareAcc16
 154 breq 160
 155 acc16= variable 2
 156 call writeLineAcc16
 157 incr16 variable 2
 158 br 150
 159 ;test1.j(53)     while (17 > i+0) { println (i); i++; }
 160 acc16= variable 2
 161 acc16+ constant 0
 162 acc8= constant 17
 163 acc8CompareAcc16
 164 brle 170
 165 acc16= variable 2
 166 call writeLineAcc16
 167 incr16 variable 2
 168 br 160
 169 ;test1.j(54)     while (18 >= i+0) { println (i); i++; }
 170 acc16= variable 2
 171 acc16+ constant 0
 172 acc8= constant 18
 173 acc8CompareAcc16
 174 brlt 180
 175 acc16= variable 2
 176 call writeLineAcc16
 177 incr16 variable 2
 178 br 170
 179 ;test1.j(55)     p=i;
 180 acc16= variable 2
 181 acc16=> variable 6
 182 ;test1.j(56)     while (17 <  i+0) { println (p); i--; p++; }
 183 acc16= variable 2
 184 acc16+ constant 0
 185 acc8= constant 17
 186 acc8CompareAcc16
 187 brge 194
 188 acc16= variable 6
 189 call writeLineAcc16
 190 decr16 variable 2
 191 incr16 variable 6
 192 br 183
 193 ;test1.j(57)     while (16 <= i+0) { println (p); i--; p++; }
 194 acc16= variable 2
 195 acc16+ constant 0
 196 acc8= constant 16
 197 acc8CompareAcc16
 198 brgt 212
 199 acc16= variable 6
 200 call writeLineAcc16
 201 decr16 variable 2
 202 incr16 variable 6
 203 br 194
 204 ;test1.j(58)   
 205 ;test1.j(59)     // constant - acc
 206 ;test1.j(60)     // integer - byte
 207 ;test1.j(61)     // not relevant
 208 ;test1.j(62)   
 209 ;test1.j(63)     // constant - acc
 210 ;test1.j(64)     // integer - integer
 211 ;test1.j(65)     i=23;
 212 acc8= constant 23
 213 acc8=> variable 2
 214 ;test1.j(66)     while (23 == i+0) { println (i); i++; }
 215 acc16= variable 2
 216 acc16+ constant 0
 217 acc8= constant 23
 218 acc8CompareAcc16
 219 brne 225
 220 acc16= variable 2
 221 call writeLineAcc16
 222 incr16 variable 2
 223 br 215
 224 ;test1.j(67)     while (26 != i+0) { println (i); i++; }
 225 acc16= variable 2
 226 acc16+ constant 0
 227 acc8= constant 26
 228 acc8CompareAcc16
 229 breq 235
 230 acc16= variable 2
 231 call writeLineAcc16
 232 incr16 variable 2
 233 br 225
 234 ;test1.j(68)     while (28 > i+0) { println (i); i++; }
 235 acc16= variable 2
 236 acc16+ constant 0
 237 acc8= constant 28
 238 acc8CompareAcc16
 239 brle 245
 240 acc16= variable 2
 241 call writeLineAcc16
 242 incr16 variable 2
 243 br 235
 244 ;test1.j(69)     while (29 >= i+0) { println (i); i++; }
 245 acc16= variable 2
 246 acc16+ constant 0
 247 acc8= constant 29
 248 acc8CompareAcc16
 249 brlt 255
 250 acc16= variable 2
 251 call writeLineAcc16
 252 incr16 variable 2
 253 br 245
 254 ;test1.j(70)     p=i;
 255 acc16= variable 2
 256 acc16=> variable 6
 257 ;test1.j(71)     while (28 <  i+0) { println (p); p++; i--; }
 258 acc16= variable 2
 259 acc16+ constant 0
 260 acc8= constant 28
 261 acc8CompareAcc16
 262 brge 269
 263 acc16= variable 6
 264 call writeLineAcc16
 265 incr16 variable 6
 266 decr16 variable 2
 267 br 258
 268 ;test1.j(72)     while (27 <= i+0) { println (p); p++; i--; }
 269 acc16= variable 2
 270 acc16+ constant 0
 271 acc8= constant 27
 272 acc8CompareAcc16
 273 brgt 284
 274 acc16= variable 6
 275 call writeLineAcc16
 276 incr16 variable 6
 277 decr16 variable 2
 278 br 269
 279 ;test1.j(73)   
 280 ;test1.j(74)     /************************/
 281 ;test1.j(75)     // constant - var
 282 ;test1.j(76)     // byte - byte
 283 ;test1.j(77)     b=35;
 284 acc8= constant 35
 285 acc8=> variable 0
 286 ;test1.j(78)     while (33 <= b) { println (p); p++; b--; }
 287 acc8= variable 0
 288 acc8Comp constant 33
 289 brlt 298
 290 acc16= variable 6
 291 call writeLineAcc16
 292 incr16 variable 6
 293 decr8 variable 0
 294 br 287
 295 ;test1.j(79)     // constant - var
 296 ;test1.j(80)     // byte - integer
 297 ;test1.j(81)     i=37;
 298 acc8= constant 37
 299 acc8=> variable 2
 300 ;test1.j(82)     while (36 <= i) { println (p); p++; i--; }
 301 acc16= variable 2
 302 acc8= constant 36
 303 acc8CompareAcc16
 304 brgt 317
 305 acc16= variable 6
 306 call writeLineAcc16
 307 incr16 variable 6
 308 decr16 variable 2
 309 br 301
 310 ;test1.j(83)     // constant - var
 311 ;test1.j(84)     // integer - byte
 312 ;test1.j(85)     // not relevant
 313 ;test1.j(86)   
 314 ;test1.j(87)     // constant - var
 315 ;test1.j(88)     // integer - integer
 316 ;test1.j(89)     while (34 <= i) { println (p); p++; i--; }
 317 acc16= variable 2
 318 acc8= constant 34
 319 acc8CompareAcc16
 320 brgt 363
 321 acc16= variable 6
 322 call writeLineAcc16
 323 incr16 variable 6
 324 decr16 variable 2
 325 br 317
 326 ;test1.j(90)   
 327 ;test1.j(91)     /************************/
 328 ;test1.j(92)     // stack8 - constant
 329 ;test1.j(93)     // stack8 - acc
 330 ;test1.j(94)     // stack8 - var
 331 ;test1.j(95)     // stack8 - stack8
 332 ;test1.j(96)     // stack8 - stack16
 333 ;test1.j(97)     //TODO
 334 ;test1.j(98)   
 335 ;test1.j(99)     /************************/
 336 ;test1.j(100)     // stack16 - constant
 337 ;test1.j(101)     // stack16 - acc
 338 ;test1.j(102)     // stack16 - var
 339 ;test1.j(103)     // stack16 - stack8
 340 ;test1.j(104)     // stack16 - stack16
 341 ;test1.j(105)     //TODO
 342 ;test1.j(106)   
 343 ;test1.j(107)     /************************/
 344 ;test1.j(108)     // var - stack16
 345 ;test1.j(109)     // byte - byte
 346 ;test1.j(110)     // byte - integer
 347 ;test1.j(111)     // integer - byte
 348 ;test1.j(112)     // integer - integer
 349 ;test1.j(113)     //TODO
 350 ;test1.j(114)   
 351 ;test1.j(115)     /************************/
 352 ;test1.j(116)     // var - stack8
 353 ;test1.j(117)     // byte - byte
 354 ;test1.j(118)     // byte - integer
 355 ;test1.j(119)     // integer - byte
 356 ;test1.j(120)     // integer - integer
 357 ;test1.j(121)     //TODO
 358 ;test1.j(122)   
 359 ;test1.j(123)     /************************/
 360 ;test1.j(124)     // var - var
 361 ;test1.j(125)     // byte - byte
 362 ;test1.j(126)     b=33;
 363 acc8= constant 33
 364 acc8=> variable 0
 365 ;test1.j(127)     while (b2 <= b) { println (p); p++; b--; }
 366 acc8= variable 1
 367 acc8Comp variable 0
 368 brgt 376
 369 acc16= variable 6
 370 call writeLineAcc16
 371 incr16 variable 6
 372 decr8 variable 0
 373 br 366
 374 ;test1.j(128)     // byte - integer
 375 ;test1.j(129)     i = 33;
 376 acc8= constant 33
 377 acc8=> variable 2
 378 ;test1.j(130)     while (b2 <= i) { println (p); p++; i--; }
 379 acc8= variable 1
 380 acc16= variable 2
 381 acc8CompareAcc16
 382 brgt 390
 383 acc16= variable 6
 384 call writeLineAcc16
 385 incr16 variable 6
 386 decr16 variable 2
 387 br 379
 388 ;test1.j(131)     // integer - byte
 389 ;test1.j(132)     b=33;
 390 acc8= constant 33
 391 acc8=> variable 0
 392 ;test1.j(133)     i=b2;
 393 acc8= variable 1
 394 acc8=> variable 2
 395 ;test1.j(134)     while (i <= b) { println (p); p++; b--; }
 396 acc16= variable 2
 397 acc8= variable 0
 398 acc16CompareAcc8
 399 brgt 407
 400 acc16= variable 6
 401 call writeLineAcc16
 402 incr16 variable 6
 403 decr8 variable 0
 404 br 396
 405 ;test1.j(135)     // integer - integer
 406 ;test1.j(136)     i=33;
 407 acc8= constant 33
 408 acc8=> variable 2
 409 ;test1.j(137)     i2=b2;
 410 acc8= variable 1
 411 acc8=> variable 4
 412 ;test1.j(138)     while (i2 <= i) { println (p); p++; i--; }
 413 acc16= variable 4
 414 acc16Comp variable 2
 415 brgt 426
 416 acc16= variable 6
 417 call writeLineAcc16
 418 incr16 variable 6
 419 decr16 variable 2
 420 br 413
 421 ;test1.j(139)   
 422 ;test1.j(140)     /************************/
 423 ;test1.j(141)     // var - acc
 424 ;test1.j(142)     // byte - byte
 425 ;test1.j(143)     b=49;
 426 acc8= constant 49
 427 acc8=> variable 0
 428 ;test1.j(144)     while (b <= 50+0) { println (b); b++; }
 429 acc8= constant 50
 430 acc8+ constant 0
 431 acc8Comp variable 0
 432 brlt 439
 433 acc8= variable 0
 434 call writeLineAcc8
 435 incr8 variable 0
 436 br 429
 437 ;test1.j(145)     // byte - integer
 438 ;test1.j(146)     i=52;
 439 acc8= constant 52
 440 acc8=> variable 2
 441 ;test1.j(147)     while (b <= i+0) { println (b); b++; }
 442 acc16= variable 2
 443 acc16+ constant 0
 444 acc8= variable 0
 445 acc8CompareAcc16
 446 brgt 453
 447 acc8= variable 0
 448 call writeLineAcc8
 449 incr8 variable 0
 450 br 442
 451 ;test1.j(148)     // integer - byte
 452 ;test1.j(149)     i=b;
 453 acc8= variable 0
 454 acc8=> variable 2
 455 ;test1.j(150)     while (i <= 54+0) { println (i); i++; }
 456 acc8= constant 54
 457 acc8+ constant 0
 458 acc16= variable 2
 459 acc16CompareAcc8
 460 brgt 467
 461 acc16= variable 2
 462 call writeLineAcc16
 463 incr16 variable 2
 464 br 456
 465 ;test1.j(151)     // integer - integer
 466 ;test1.j(152)     b=i;
 467 acc16= variable 2
 468 acc16=> variable 0
 469 ;test1.j(153)     i=1098;
 470 acc16= constant 1098
 471 acc16=> variable 2
 472 ;test1.j(154)     while (i <= 1099+0) { println (b); b++; i++; }
 473 acc16= constant 1099
 474 acc16+ constant 0
 475 acc16Comp variable 2
 476 brlt 487
 477 acc8= variable 0
 478 call writeLineAcc8
 479 incr8 variable 0
 480 incr16 variable 2
 481 br 473
 482 ;test1.j(155)   
 483 ;test1.j(156)     /************************/
 484 ;test1.j(157)     // var - constant
 485 ;test1.j(158)     // byte - byte
 486 ;test1.j(159)     while (b <= 58) { println (b); b++; }
 487 acc8= variable 0
 488 acc8Comp constant 58
 489 brgt 499
 490 acc8= variable 0
 491 call writeLineAcc8
 492 incr8 variable 0
 493 br 487
 494 ;test1.j(160)     // byte - integer
 495 ;test1.j(161)     //not relevant
 496 ;test1.j(162)   
 497 ;test1.j(163)     // integer - byte
 498 ;test1.j(164)     i=b;
 499 acc8= variable 0
 500 acc8=> variable 2
 501 ;test1.j(165)     while (i <= 60) { println (i); i++; }
 502 acc16= variable 2
 503 acc8= constant 60
 504 acc16CompareAcc8
 505 brgt 512
 506 acc16= variable 2
 507 call writeLineAcc16
 508 incr16 variable 2
 509 br 502
 510 ;test1.j(166)     // integer - integer
 511 ;test1.j(167)     i2=1090;
 512 acc16= constant 1090
 513 acc16=> variable 4
 514 ;test1.j(168)     while (i2 <= 1091) { println (i); i++; i2++; }
 515 acc16= variable 4
 516 acc16Comp constant 1091
 517 brgt 529
 518 acc16= variable 2
 519 call writeLineAcc16
 520 incr16 variable 2
 521 incr16 variable 4
 522 br 515
 523 ;test1.j(169)   
 524 ;test1.j(170)     /************************/
 525 ;test1.j(171)     // acc - stack8
 526 ;test1.j(172)     // byte - byte
 527 ;test1.j(173)     //TODO
 528 ;test1.j(174)     println(63);
 529 acc8= constant 63
 530 call writeLineAcc8
 531 ;test1.j(175)     println(64);
 532 acc8= constant 64
 533 call writeLineAcc8
 534 ;test1.j(176)     // byte - integer
 535 ;test1.j(177)     //TODO
 536 ;test1.j(178)     println(65);
 537 acc8= constant 65
 538 call writeLineAcc8
 539 ;test1.j(179)     println(66);
 540 acc8= constant 66
 541 call writeLineAcc8
 542 ;test1.j(180)     // integer - byte
 543 ;test1.j(181)     //TODO
 544 ;test1.j(182)     println(67);
 545 acc8= constant 67
 546 call writeLineAcc8
 547 ;test1.j(183)     println(68);
 548 acc8= constant 68
 549 call writeLineAcc8
 550 ;test1.j(184)     // integer - integer
 551 ;test1.j(185)     //TODO
 552 ;test1.j(186)     println(69);
 553 acc8= constant 69
 554 call writeLineAcc8
 555 ;test1.j(187)     println(70);
 556 acc8= constant 70
 557 call writeLineAcc8
 558 ;test1.j(188)   
 559 ;test1.j(189)     /************************/
 560 ;test1.j(190)     // acc - stack16
 561 ;test1.j(191)     // byte - byte
 562 ;test1.j(192)     //TODO
 563 ;test1.j(193)     println(71);
 564 acc8= constant 71
 565 call writeLineAcc8
 566 ;test1.j(194)     println(72);
 567 acc8= constant 72
 568 call writeLineAcc8
 569 ;test1.j(195)     // byte - integer
 570 ;test1.j(196)     //TODO
 571 ;test1.j(197)     println(73);
 572 acc8= constant 73
 573 call writeLineAcc8
 574 ;test1.j(198)     println(74);
 575 acc8= constant 74
 576 call writeLineAcc8
 577 ;test1.j(199)     // integer - byte
 578 ;test1.j(200)     //TODO
 579 ;test1.j(201)     println(75);
 580 acc8= constant 75
 581 call writeLineAcc8
 582 ;test1.j(202)     println(76);
 583 acc8= constant 76
 584 call writeLineAcc8
 585 ;test1.j(203)     // integer - integer
 586 ;test1.j(204)     //TODO
 587 ;test1.j(205)     println(77);
 588 acc8= constant 77
 589 call writeLineAcc8
 590 ;test1.j(206)     println(78);
 591 acc8= constant 78
 592 call writeLineAcc8
 593 ;test1.j(207)   
 594 ;test1.j(208)     /************************/
 595 ;test1.j(209)     // acc - var
 596 ;test1.j(210)     // byte - byte
 597 ;test1.j(211)     b=79;
 598 acc8= constant 79
 599 acc8=> variable 0
 600 ;test1.j(212)     b2=79;
 601 acc8= constant 79
 602 acc8=> variable 1
 603 ;test1.j(213)     while (78+0 <= b2) { println (b); b++; b2--; }
 604 acc8= constant 78
 605 acc8+ constant 0
 606 acc8Comp variable 1
 607 brgt 617
 608 acc8= variable 0
 609 call writeLineAcc8
 610 incr8 variable 0
 611 decr8 variable 1
 612 br 604
 613 ;test1.j(214)     // byte - integer
 614 ;test1.j(215)     i=79;
 615 acc8= constant 79
 616 acc8=> variable 2
 617 ;test1.j(216)     while (78+0 <= i) { println (b); b++; i--; }
 618 acc8= constant 78
 619 acc8+ constant 0
 620 acc16= variable 2
 621 acc8CompareAcc16
 622 brgt 634
 623 acc8= variable 0
 624 call writeLineAcc8
 625 incr8 variable 0
 626 decr16 variable 2
 627 br 620
 628 ;test1.j(217)     // integer - byte
 629 ;test1.j(218)     i=78;
 630 acc8= constant 78
 631 acc8=> variable 2
 632 ;test1.j(219)     b2=79;
 633 acc8= constant 79
 634 acc8=> variable 1
 635 ;test1.j(220)     while (i+0 <= b2) { println (b); b++; b2--; } 
 636 acc16= variable 2
 637 acc16+ constant 0
 638 acc8= variable 1
 639 acc16CompareAcc8
 640 brgt 654
 641 acc8= variable 0
 642 call writeLineAcc8
 643 incr8 variable 0
 644 decr8 variable 1
 645 br 640
 646 ;test1.j(221)     // integer - integer
 647 ;test1.j(222)     i=1066;
 648 acc16= constant 1066
 649 acc16=> variable 2
 650 ;test1.j(223)     while (1000+65 <= i) { println (b); b++; i--; }
 651 acc16= constant 1000
 652 acc16+ constant 65
 653 acc16Comp variable 2
 654 brgt 673
 655 acc8= variable 0
 656 call writeLineAcc8
 657 incr8 variable 0
 658 decr16 variable 2
 659 br 657
 660 ;test1.j(224)   
 661 ;test1.j(225)     /************************/
 662 ;test1.j(226)     // acc - acc
 663 ;test1.j(227)     // byte - byte
 664 ;test1.j(228)     b=87;
 665 acc8= constant 87
 666 acc8=> variable 0
 667 ;test1.j(229)     b2=64;
 668 acc8= constant 64
 669 acc8=> variable 1
 670 ;test1.j(230)     while (63+0 <= b2+0) { println (b); b++; b2--; }
 671 acc8= constant 63
 672 acc8+ constant 0
 673 <acc8
 674 acc8= variable 1
 675 acc8+ constant 0
 676 revAcc8Comp unstack8
 677 brlt 693
 678 acc8= variable 0
 679 call writeLineAcc8
 680 incr8 variable 0
 681 decr8 variable 1
 682 br 679
 683 ;test1.j(231)     // byte - integer
 684 ;test1.j(232)     i=62;
 685 acc8= constant 62
 686 acc8=> variable 2
 687 ;test1.j(233)     while (61+0 <= i+0) { println (b); b++; i--; }
 688 acc8= constant 61
 689 acc8+ constant 0
 690 <acc8
 691 acc16= variable 2
 692 acc16+ constant 0
 693 acc8= unstack8
 694 acc8CompareAcc16
 695 brgt 711
 696 acc8= variable 0
 697 call writeLineAcc8
 698 incr8 variable 0
 699 decr16 variable 2
 700 br 696
 701 ;test1.j(234)     // integer - byte
 702 ;test1.j(235)     i=59;
 703 acc8= constant 59
 704 acc8=> variable 2
 705 ;test1.j(236)     b2=60;
 706 acc8= constant 60
 707 acc8=> variable 1
 708 ;test1.j(237)     while (i+0 <= b2+0) { println (b); b++; b2--; }
 709 acc16= variable 2
 710 acc16+ constant 0
 711 <acc16
 712 acc8= variable 1
 713 acc8+ constant 0
 714 acc16= unstack16
 715 acc16CompareAcc8
 716 brgt 732
 717 acc8= variable 0
 718 call writeLineAcc8
 719 incr8 variable 0
 720 decr8 variable 1
 721 br 717
 722 ;test1.j(238)     // integer - integer
 723 ;test1.j(239)     i=1058;
 724 acc16= constant 1058
 725 acc16=> variable 2
 726 ;test1.j(240)     while (1000+57 <= i+0) { println (b); b++; i--; }
 727 acc16= constant 1000
 728 acc16+ constant 57
 729 <acc16
 730 acc16= variable 2
 731 acc16+ constant 0
 732 revAcc16Comp unstack16
 733 brlt 752
 734 acc8= variable 0
 735 call writeLineAcc8
 736 incr8 variable 0
 737 decr16 variable 2
 738 br 735
 739 ;test1.j(241)   
 740 ;test1.j(242)     /************************/
 741 ;test1.j(243)     // acc - constant
 742 ;test1.j(244)     // byte - byte
 743 ;test1.j(245)     while (b+0 <= 96) { println (b); b++; }
 744 acc8= variable 0
 745 acc8+ constant 0
 746 acc8Comp constant 96
 747 brgt 766
 748 acc8= variable 0
 749 call writeLineAcc8
 750 incr8 variable 0
 751 br 752
 752 ;test1.j(246)     // byte - integer
 753 ;test1.j(247)     //not relevant
 754 ;test1.j(248)     // integer - byte
 755 ;test1.j(249)     i=b;
 756 acc8= variable 0
 757 acc8=> variable 2
 758 ;test1.j(250)     while (i+0 <= 98) { println (i); i++; }
 759 acc16= variable 2
 760 acc16+ constant 0
 761 acc8= constant 98
 762 acc16CompareAcc8
 763 brgt 781
 764 acc16= variable 2
 765 call writeLineAcc16
 766 incr16 variable 2
 767 br 769
 768 ;test1.j(251)     b=i;
 769 acc16= variable 2
 770 acc16=> variable 0
 771 ;test1.j(252)     i=1052;
 772 acc16= constant 1052
 773 acc16=> variable 2
 774 ;test1.j(253)     // integer - integer
 775 ;test1.j(254)     while (i+0 <= 1053) { println (b); b++; i++; }
 776 acc16= variable 2
 777 acc16+ constant 0
 778 acc16Comp constant 1053
 779 brgt 805
 780 acc8= variable 0
 781 call writeLineAcc8
 782 incr8 variable 0
 783 incr16 variable 2
 784 br 788
 785 ;test1.j(255)   
 786 ;test1.j(256)     /************************/
 787 ;test1.j(257)     // constant - stack8
 788 ;test1.j(258)     // byte - byte
 789 ;test1.j(259)     //TODO
 790 ;test1.j(260)     println(101);
 791 acc8= constant 101
 792 call writeLineAcc8
 793 ;test1.j(261)     println(102);
 794 acc8= constant 102
 795 call writeLineAcc8
 796 ;test1.j(262)     // constant - stack8
 797 ;test1.j(263)     // byte - integer
 798 ;test1.j(264)     //TODO
 799 ;test1.j(265)     println(103);
 800 acc8= constant 103
 801 call writeLineAcc8
 802 ;test1.j(266)     println(104);
 803 acc8= constant 104
 804 call writeLineAcc8
 805 ;test1.j(267)     // constant - stack8
 806 ;test1.j(268)     // integer - byte
 807 ;test1.j(269)     //TODO
 808 ;test1.j(270)     println(105);
 809 acc8= constant 105
 810 call writeLineAcc8
 811 ;test1.j(271)     println(106);
 812 acc8= constant 106
 813 call writeLineAcc8
 814 ;test1.j(272)     // constant - stack88
 815 ;test1.j(273)     // integer - integer
 816 ;test1.j(274)     //TODO
 817 ;test1.j(275)     println(107);
 818 acc8= constant 107
 819 call writeLineAcc8
 820 ;test1.j(276)     println(108);
 821 acc8= constant 108
 822 call writeLineAcc8
 823 ;test1.j(277)   
 824 ;test1.j(278)     /************************/
 825 ;test1.j(279)     // constant - stack16
 826 ;test1.j(280)     // byte - byte
 827 ;test1.j(281)     //TODO
 828 ;test1.j(282)     println(109);
 829 acc8= constant 109
 830 call writeLineAcc8
 831 ;test1.j(283)     println(110);
 832 acc8= constant 110
 833 call writeLineAcc8
 834 ;test1.j(284)     // constant - stack16
 835 ;test1.j(285)     // byte - integer
 836 ;test1.j(286)     //TODO
 837 ;test1.j(287)     println(111);
 838 acc8= constant 111
 839 call writeLineAcc8
 840 ;test1.j(288)     println(112);
 841 acc8= constant 112
 842 call writeLineAcc8
 843 ;test1.j(289)     // constant - stack16
 844 ;test1.j(290)     // integer - byte
 845 ;test1.j(291)     //TODO
 846 ;test1.j(292)     println(113);
 847 acc8= constant 113
 848 call writeLineAcc8
 849 ;test1.j(293)     println(114);
 850 acc8= constant 114
 851 call writeLineAcc8
 852 ;test1.j(294)     // constant - stack16
 853 ;test1.j(295)     // integer - integer
 854 ;test1.j(296)     //TODO
 855 ;test1.j(297)     println(115);
 856 acc8= constant 115
 857 call writeLineAcc8
 858 ;test1.j(298)     println(116);
 859 acc8= constant 116
 860 call writeLineAcc8
 861 ;test1.j(299)   
 862 ;test1.j(300)     println("Klaar");
 863 acc16= constant 868
 864 writeLineString
 865 return
 866 ;test1.j(301)   }
 867 ;test1.j(302) }
 868 stringConstant 0 = "Klaar"
