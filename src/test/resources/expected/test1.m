   0 ;test1.j(0) /* Program to test generated Z80 assembler code */
   1 ;test1.j(1) class TestWhile {
   2 ;test1.j(2)   private static byte b = 0;
   3 acc8= constant 0
   4 acc8=> variable 0
   5 ;test1.j(3)   private static byte b2 = 32;
   6 acc8= constant 32
   7 acc8=> variable 1
   8 ;test1.j(4)   private static word i = 110;
   9 acc8= constant 110
  10 acc8=> variable 2
  11 ;test1.j(5)   private static word i2 = 105;
  12 acc8= constant 105
  13 acc8=> variable 4
  14 ;test1.j(6)   private static word p = 12;
  15 acc8= constant 12
  16 acc8=> variable 6
  17 ;test1.j(7) 
  18 ;test1.j(8)   public static void main() {
  19 ;test1.j(9)     /*Possible operand types: 
  20 ;test1.j(10)      * constant, acc, var, stack8, stack16
  21 ;test1.j(11)      *Possible datatype combinations:
  22 ;test1.j(12)      * byte - byte
  23 ;test1.j(13)      * byte - integer
  24 ;test1.j(14)      * integer - byte
  25 ;test1.j(15)      * integer - integer
  26 ;test1.j(16)     */
  27 ;test1.j(17)   
  28 ;test1.j(18)     println(0);
  29 acc8= constant 0
  30 call writeLineAcc8
  31 ;test1.j(19)   
  32 ;test1.j(20)     /************************/
  33 ;test1.j(21)     // global variable within while scope
  34 ;test1.j(22)     b++;
  35 incr8 variable 0
  36 ;test1.j(23)     println (b);
  37 acc8= variable 0
  38 call writeLineAcc8
  39 ;test1.j(24)     while (b < 2) {
  40 acc8= variable 0
  41 acc8Comp constant 2
  42 brge 68
  43 ;test1.j(25)       b++;
  44 incr8 variable 0
  45 ;test1.j(26)       word j = 1001;
  46 acc16= constant 1001
  47 acc16=> variable 8
  48 ;test1.j(27)       byte c = b;
  49 acc8= variable 0
  50 acc8=> variable 10
  51 ;test1.j(28)       byte d = c;
  52 acc8= variable 10
  53 acc8=> variable 11
  54 ;test1.j(29)       println (c);
  55 acc8= variable 10
  56 call writeLineAcc8
  57 ;test1.j(30)     }
  58 br 40
  59 ;test1.j(31)   
  60 ;test1.j(32)     /************************/
  61 ;test1.j(33)     // constant - constant
  62 ;test1.j(34)     // not relevant
  63 ;test1.j(35)   
  64 ;test1.j(36)     /************************/
  65 ;test1.j(37)     // constant - acc
  66 ;test1.j(38)     // byte - byte
  67 ;test1.j(39)     b = 3;
  68 acc8= constant 3
  69 acc8=> variable 0
  70 ;test1.j(40)     while (3 == b+0) { println (b); b++; }
  71 acc8= variable 0
  72 acc8+ constant 0
  73 acc8Comp constant 3
  74 brne 80
  75 acc8= variable 0
  76 call writeLineAcc8
  77 incr8 variable 0
  78 br 71
  79 ;test1.j(41)     while (4 != b+0) { println (b); b++; }
  80 acc8= variable 0
  81 acc8+ constant 0
  82 acc8Comp constant 4
  83 breq 89
  84 acc8= variable 0
  85 call writeLineAcc8
  86 incr8 variable 0
  87 br 80
  88 ;test1.j(42)     while (6 > b+0) { println (b); b++; }
  89 acc8= variable 0
  90 acc8+ constant 0
  91 acc8Comp constant 6
  92 brge 98
  93 acc8= variable 0
  94 call writeLineAcc8
  95 incr8 variable 0
  96 br 89
  97 ;test1.j(43)     while (7 >= b+0) { println (b); b++; }
  98 acc8= variable 0
  99 acc8+ constant 0
 100 acc8Comp constant 7
 101 brgt 107
 102 acc8= variable 0
 103 call writeLineAcc8
 104 incr8 variable 0
 105 br 98
 106 ;test1.j(44)     p=8;
 107 acc8= constant 8
 108 acc8=> variable 6
 109 ;test1.j(45)     while (6 <  b+0) { println (p); p++; b--; }
 110 acc8= variable 0
 111 acc8+ constant 0
 112 acc8Comp constant 6
 113 brle 120
 114 acc16= variable 6
 115 call writeLineAcc16
 116 incr16 variable 6
 117 decr8 variable 0
 118 br 110
 119 ;test1.j(46)     while (5 <= b+0) { println (p); p++; b--; }
 120 acc8= variable 0
 121 acc8+ constant 0
 122 acc8Comp constant 5
 123 brlt 133
 124 acc16= variable 6
 125 call writeLineAcc16
 126 incr16 variable 6
 127 decr8 variable 0
 128 br 120
 129 ;test1.j(47)     
 130 ;test1.j(48)     // constant - acc
 131 ;test1.j(49)     // byte - integer
 132 ;test1.j(50)     i=12;
 133 acc8= constant 12
 134 acc8=> variable 2
 135 ;test1.j(51)     while (12 == i+0) { println (i); i++; }
 136 acc16= variable 2
 137 acc16+ constant 0
 138 acc8= constant 12
 139 acc8CompareAcc16
 140 brne 146
 141 acc16= variable 2
 142 call writeLineAcc16
 143 incr16 variable 2
 144 br 136
 145 ;test1.j(52)     while (15 != i+0) { println (i); i++; }
 146 acc16= variable 2
 147 acc16+ constant 0
 148 acc8= constant 15
 149 acc8CompareAcc16
 150 breq 156
 151 acc16= variable 2
 152 call writeLineAcc16
 153 incr16 variable 2
 154 br 146
 155 ;test1.j(53)     while (17 > i+0) { println (i); i++; }
 156 acc16= variable 2
 157 acc16+ constant 0
 158 acc8= constant 17
 159 acc8CompareAcc16
 160 brle 166
 161 acc16= variable 2
 162 call writeLineAcc16
 163 incr16 variable 2
 164 br 156
 165 ;test1.j(54)     while (18 >= i+0) { println (i); i++; }
 166 acc16= variable 2
 167 acc16+ constant 0
 168 acc8= constant 18
 169 acc8CompareAcc16
 170 brlt 176
 171 acc16= variable 2
 172 call writeLineAcc16
 173 incr16 variable 2
 174 br 166
 175 ;test1.j(55)     p=i;
 176 acc16= variable 2
 177 acc16=> variable 6
 178 ;test1.j(56)     while (17 <  i+0) { println (p); i--; p++; }
 179 acc16= variable 2
 180 acc16+ constant 0
 181 acc8= constant 17
 182 acc8CompareAcc16
 183 brge 190
 184 acc16= variable 6
 185 call writeLineAcc16
 186 decr16 variable 2
 187 incr16 variable 6
 188 br 179
 189 ;test1.j(57)     while (16 <= i+0) { println (p); i--; p++; }
 190 acc16= variable 2
 191 acc16+ constant 0
 192 acc8= constant 16
 193 acc8CompareAcc16
 194 brgt 208
 195 acc16= variable 6
 196 call writeLineAcc16
 197 decr16 variable 2
 198 incr16 variable 6
 199 br 190
 200 ;test1.j(58)   
 201 ;test1.j(59)     // constant - acc
 202 ;test1.j(60)     // integer - byte
 203 ;test1.j(61)     // not relevant
 204 ;test1.j(62)   
 205 ;test1.j(63)     // constant - acc
 206 ;test1.j(64)     // integer - integer
 207 ;test1.j(65)     i=23;
 208 acc8= constant 23
 209 acc8=> variable 2
 210 ;test1.j(66)     while (23 == i+0) { println (i); i++; }
 211 acc16= variable 2
 212 acc16+ constant 0
 213 acc8= constant 23
 214 acc8CompareAcc16
 215 brne 221
 216 acc16= variable 2
 217 call writeLineAcc16
 218 incr16 variable 2
 219 br 211
 220 ;test1.j(67)     while (26 != i+0) { println (i); i++; }
 221 acc16= variable 2
 222 acc16+ constant 0
 223 acc8= constant 26
 224 acc8CompareAcc16
 225 breq 231
 226 acc16= variable 2
 227 call writeLineAcc16
 228 incr16 variable 2
 229 br 221
 230 ;test1.j(68)     while (28 > i+0) { println (i); i++; }
 231 acc16= variable 2
 232 acc16+ constant 0
 233 acc8= constant 28
 234 acc8CompareAcc16
 235 brle 241
 236 acc16= variable 2
 237 call writeLineAcc16
 238 incr16 variable 2
 239 br 231
 240 ;test1.j(69)     while (29 >= i+0) { println (i); i++; }
 241 acc16= variable 2
 242 acc16+ constant 0
 243 acc8= constant 29
 244 acc8CompareAcc16
 245 brlt 251
 246 acc16= variable 2
 247 call writeLineAcc16
 248 incr16 variable 2
 249 br 241
 250 ;test1.j(70)     p=i;
 251 acc16= variable 2
 252 acc16=> variable 6
 253 ;test1.j(71)     while (28 <  i+0) { println (p); p++; i--; }
 254 acc16= variable 2
 255 acc16+ constant 0
 256 acc8= constant 28
 257 acc8CompareAcc16
 258 brge 265
 259 acc16= variable 6
 260 call writeLineAcc16
 261 incr16 variable 6
 262 decr16 variable 2
 263 br 254
 264 ;test1.j(72)     while (27 <= i+0) { println (p); p++; i--; }
 265 acc16= variable 2
 266 acc16+ constant 0
 267 acc8= constant 27
 268 acc8CompareAcc16
 269 brgt 280
 270 acc16= variable 6
 271 call writeLineAcc16
 272 incr16 variable 6
 273 decr16 variable 2
 274 br 265
 275 ;test1.j(73)   
 276 ;test1.j(74)     /************************/
 277 ;test1.j(75)     // constant - var
 278 ;test1.j(76)     // byte - byte
 279 ;test1.j(77)     b=35;
 280 acc8= constant 35
 281 acc8=> variable 0
 282 ;test1.j(78)     while (33 <= b) { println (p); p++; b--; }
 283 acc8= variable 0
 284 acc8Comp constant 33
 285 brlt 294
 286 acc16= variable 6
 287 call writeLineAcc16
 288 incr16 variable 6
 289 decr8 variable 0
 290 br 283
 291 ;test1.j(79)     // constant - var
 292 ;test1.j(80)     // byte - integer
 293 ;test1.j(81)     i=37;
 294 acc8= constant 37
 295 acc8=> variable 2
 296 ;test1.j(82)     while (36 <= i) { println (p); p++; i--; }
 297 acc16= variable 2
 298 acc8= constant 36
 299 acc8CompareAcc16
 300 brgt 313
 301 acc16= variable 6
 302 call writeLineAcc16
 303 incr16 variable 6
 304 decr16 variable 2
 305 br 297
 306 ;test1.j(83)     // constant - var
 307 ;test1.j(84)     // integer - byte
 308 ;test1.j(85)     // not relevant
 309 ;test1.j(86)   
 310 ;test1.j(87)     // constant - var
 311 ;test1.j(88)     // integer - integer
 312 ;test1.j(89)     while (34 <= i) { println (p); p++; i--; }
 313 acc16= variable 2
 314 acc8= constant 34
 315 acc8CompareAcc16
 316 brgt 359
 317 acc16= variable 6
 318 call writeLineAcc16
 319 incr16 variable 6
 320 decr16 variable 2
 321 br 313
 322 ;test1.j(90)   
 323 ;test1.j(91)     /************************/
 324 ;test1.j(92)     // stack8 - constant
 325 ;test1.j(93)     // stack8 - acc
 326 ;test1.j(94)     // stack8 - var
 327 ;test1.j(95)     // stack8 - stack8
 328 ;test1.j(96)     // stack8 - stack16
 329 ;test1.j(97)     //TODO
 330 ;test1.j(98)   
 331 ;test1.j(99)     /************************/
 332 ;test1.j(100)     // stack16 - constant
 333 ;test1.j(101)     // stack16 - acc
 334 ;test1.j(102)     // stack16 - var
 335 ;test1.j(103)     // stack16 - stack8
 336 ;test1.j(104)     // stack16 - stack16
 337 ;test1.j(105)     //TODO
 338 ;test1.j(106)   
 339 ;test1.j(107)     /************************/
 340 ;test1.j(108)     // var - stack16
 341 ;test1.j(109)     // byte - byte
 342 ;test1.j(110)     // byte - integer
 343 ;test1.j(111)     // integer - byte
 344 ;test1.j(112)     // integer - integer
 345 ;test1.j(113)     //TODO
 346 ;test1.j(114)   
 347 ;test1.j(115)     /************************/
 348 ;test1.j(116)     // var - stack8
 349 ;test1.j(117)     // byte - byte
 350 ;test1.j(118)     // byte - integer
 351 ;test1.j(119)     // integer - byte
 352 ;test1.j(120)     // integer - integer
 353 ;test1.j(121)     //TODO
 354 ;test1.j(122)   
 355 ;test1.j(123)     /************************/
 356 ;test1.j(124)     // var - var
 357 ;test1.j(125)     // byte - byte
 358 ;test1.j(126)     b=33;
 359 acc8= constant 33
 360 acc8=> variable 0
 361 ;test1.j(127)     while (b2 <= b) { println (p); p++; b--; }
 362 acc8= variable 1
 363 acc8Comp variable 0
 364 brgt 372
 365 acc16= variable 6
 366 call writeLineAcc16
 367 incr16 variable 6
 368 decr8 variable 0
 369 br 362
 370 ;test1.j(128)     // byte - integer
 371 ;test1.j(129)     i = 33;
 372 acc8= constant 33
 373 acc8=> variable 2
 374 ;test1.j(130)     while (b2 <= i) { println (p); p++; i--; }
 375 acc8= variable 1
 376 acc16= variable 2
 377 acc8CompareAcc16
 378 brgt 386
 379 acc16= variable 6
 380 call writeLineAcc16
 381 incr16 variable 6
 382 decr16 variable 2
 383 br 375
 384 ;test1.j(131)     // integer - byte
 385 ;test1.j(132)     b=33;
 386 acc8= constant 33
 387 acc8=> variable 0
 388 ;test1.j(133)     i=b2;
 389 acc8= variable 1
 390 acc8=> variable 2
 391 ;test1.j(134)     while (i <= b) { println (p); p++; b--; }
 392 acc16= variable 2
 393 acc8= variable 0
 394 acc16CompareAcc8
 395 brgt 403
 396 acc16= variable 6
 397 call writeLineAcc16
 398 incr16 variable 6
 399 decr8 variable 0
 400 br 392
 401 ;test1.j(135)     // integer - integer
 402 ;test1.j(136)     i=33;
 403 acc8= constant 33
 404 acc8=> variable 2
 405 ;test1.j(137)     i2=b2;
 406 acc8= variable 1
 407 acc8=> variable 4
 408 ;test1.j(138)     while (i2 <= i) { println (p); p++; i--; }
 409 acc16= variable 4
 410 acc16Comp variable 2
 411 brgt 422
 412 acc16= variable 6
 413 call writeLineAcc16
 414 incr16 variable 6
 415 decr16 variable 2
 416 br 409
 417 ;test1.j(139)   
 418 ;test1.j(140)     /************************/
 419 ;test1.j(141)     // var - acc
 420 ;test1.j(142)     // byte - byte
 421 ;test1.j(143)     b=49;
 422 acc8= constant 49
 423 acc8=> variable 0
 424 ;test1.j(144)     while (b <= 50+0) { println (b); b++; }
 425 acc8= constant 50
 426 acc8+ constant 0
 427 acc8Comp variable 0
 428 brlt 435
 429 acc8= variable 0
 430 call writeLineAcc8
 431 incr8 variable 0
 432 br 425
 433 ;test1.j(145)     // byte - integer
 434 ;test1.j(146)     i=52;
 435 acc8= constant 52
 436 acc8=> variable 2
 437 ;test1.j(147)     while (b <= i+0) { println (b); b++; }
 438 acc16= variable 2
 439 acc16+ constant 0
 440 acc8= variable 0
 441 acc8CompareAcc16
 442 brgt 449
 443 acc8= variable 0
 444 call writeLineAcc8
 445 incr8 variable 0
 446 br 438
 447 ;test1.j(148)     // integer - byte
 448 ;test1.j(149)     i=b;
 449 acc8= variable 0
 450 acc8=> variable 2
 451 ;test1.j(150)     while (i <= 54+0) { println (i); i++; }
 452 acc8= constant 54
 453 acc8+ constant 0
 454 acc16= variable 2
 455 acc16CompareAcc8
 456 brgt 463
 457 acc16= variable 2
 458 call writeLineAcc16
 459 incr16 variable 2
 460 br 452
 461 ;test1.j(151)     // integer - integer
 462 ;test1.j(152)     b=i;
 463 acc16= variable 2
 464 acc16=> variable 0
 465 ;test1.j(153)     i=1098;
 466 acc16= constant 1098
 467 acc16=> variable 2
 468 ;test1.j(154)     while (i <= 1099+0) { println (b); b++; i++; }
 469 acc16= constant 1099
 470 acc16+ constant 0
 471 acc16Comp variable 2
 472 brlt 483
 473 acc8= variable 0
 474 call writeLineAcc8
 475 incr8 variable 0
 476 incr16 variable 2
 477 br 469
 478 ;test1.j(155)   
 479 ;test1.j(156)     /************************/
 480 ;test1.j(157)     // var - constant
 481 ;test1.j(158)     // byte - byte
 482 ;test1.j(159)     while (b <= 58) { println (b); b++; }
 483 acc8= variable 0
 484 acc8Comp constant 58
 485 brgt 495
 486 acc8= variable 0
 487 call writeLineAcc8
 488 incr8 variable 0
 489 br 483
 490 ;test1.j(160)     // byte - integer
 491 ;test1.j(161)     //not relevant
 492 ;test1.j(162)   
 493 ;test1.j(163)     // integer - byte
 494 ;test1.j(164)     i=b;
 495 acc8= variable 0
 496 acc8=> variable 2
 497 ;test1.j(165)     while (i <= 60) { println (i); i++; }
 498 acc16= variable 2
 499 acc8= constant 60
 500 acc16CompareAcc8
 501 brgt 508
 502 acc16= variable 2
 503 call writeLineAcc16
 504 incr16 variable 2
 505 br 498
 506 ;test1.j(166)     // integer - integer
 507 ;test1.j(167)     i2=1090;
 508 acc16= constant 1090
 509 acc16=> variable 4
 510 ;test1.j(168)     while (i2 <= 1091) { println (i); i++; i2++; }
 511 acc16= variable 4
 512 acc16Comp constant 1091
 513 brgt 525
 514 acc16= variable 2
 515 call writeLineAcc16
 516 incr16 variable 2
 517 incr16 variable 4
 518 br 511
 519 ;test1.j(169)   
 520 ;test1.j(170)     /************************/
 521 ;test1.j(171)     // acc - stack8
 522 ;test1.j(172)     // byte - byte
 523 ;test1.j(173)     //TODO
 524 ;test1.j(174)     println(63);
 525 acc8= constant 63
 526 call writeLineAcc8
 527 ;test1.j(175)     println(64);
 528 acc8= constant 64
 529 call writeLineAcc8
 530 ;test1.j(176)     // byte - integer
 531 ;test1.j(177)     //TODO
 532 ;test1.j(178)     println(65);
 533 acc8= constant 65
 534 call writeLineAcc8
 535 ;test1.j(179)     println(66);
 536 acc8= constant 66
 537 call writeLineAcc8
 538 ;test1.j(180)     // integer - byte
 539 ;test1.j(181)     //TODO
 540 ;test1.j(182)     println(67);
 541 acc8= constant 67
 542 call writeLineAcc8
 543 ;test1.j(183)     println(68);
 544 acc8= constant 68
 545 call writeLineAcc8
 546 ;test1.j(184)     // integer - integer
 547 ;test1.j(185)     //TODO
 548 ;test1.j(186)     println(69);
 549 acc8= constant 69
 550 call writeLineAcc8
 551 ;test1.j(187)     println(70);
 552 acc8= constant 70
 553 call writeLineAcc8
 554 ;test1.j(188)   
 555 ;test1.j(189)     /************************/
 556 ;test1.j(190)     // acc - stack16
 557 ;test1.j(191)     // byte - byte
 558 ;test1.j(192)     //TODO
 559 ;test1.j(193)     println(71);
 560 acc8= constant 71
 561 call writeLineAcc8
 562 ;test1.j(194)     println(72);
 563 acc8= constant 72
 564 call writeLineAcc8
 565 ;test1.j(195)     // byte - integer
 566 ;test1.j(196)     //TODO
 567 ;test1.j(197)     println(73);
 568 acc8= constant 73
 569 call writeLineAcc8
 570 ;test1.j(198)     println(74);
 571 acc8= constant 74
 572 call writeLineAcc8
 573 ;test1.j(199)     // integer - byte
 574 ;test1.j(200)     //TODO
 575 ;test1.j(201)     println(75);
 576 acc8= constant 75
 577 call writeLineAcc8
 578 ;test1.j(202)     println(76);
 579 acc8= constant 76
 580 call writeLineAcc8
 581 ;test1.j(203)     // integer - integer
 582 ;test1.j(204)     //TODO
 583 ;test1.j(205)     println(77);
 584 acc8= constant 77
 585 call writeLineAcc8
 586 ;test1.j(206)     println(78);
 587 acc8= constant 78
 588 call writeLineAcc8
 589 ;test1.j(207)   
 590 ;test1.j(208)     /************************/
 591 ;test1.j(209)     // acc - var
 592 ;test1.j(210)     // byte - byte
 593 ;test1.j(211)     b=79;
 594 acc8= constant 79
 595 acc8=> variable 0
 596 ;test1.j(212)     b2=79;
 597 acc8= constant 79
 598 acc8=> variable 1
 599 ;test1.j(213)     while (78+0 <= b2) { println (b); b++; b2--; }
 600 acc8= constant 78
 601 acc8+ constant 0
 602 acc8Comp variable 1
 603 brgt 611
 604 acc8= variable 0
 605 call writeLineAcc8
 606 incr8 variable 0
 607 decr8 variable 1
 608 br 600
 609 ;test1.j(214)     // byte - integer
 610 ;test1.j(215)     i=79;
 611 acc8= constant 79
 612 acc8=> variable 2
 613 ;test1.j(216)     while (78+0 <= i) { println (b); b++; i--; }
 614 acc8= constant 78
 615 acc8+ constant 0
 616 acc16= variable 2
 617 acc8CompareAcc16
 618 brgt 626
 619 acc8= variable 0
 620 call writeLineAcc8
 621 incr8 variable 0
 622 decr16 variable 2
 623 br 614
 624 ;test1.j(217)     // integer - byte
 625 ;test1.j(218)     i=78;
 626 acc8= constant 78
 627 acc8=> variable 2
 628 ;test1.j(219)     b2=79;
 629 acc8= constant 79
 630 acc8=> variable 1
 631 ;test1.j(220)     while (i+0 <= b2) { println (b); b++; b2--; } 
 632 acc16= variable 2
 633 acc16+ constant 0
 634 acc8= variable 1
 635 acc16CompareAcc8
 636 brgt 644
 637 acc8= variable 0
 638 call writeLineAcc8
 639 incr8 variable 0
 640 decr8 variable 1
 641 br 632
 642 ;test1.j(221)     // integer - integer
 643 ;test1.j(222)     i=1066;
 644 acc16= constant 1066
 645 acc16=> variable 2
 646 ;test1.j(223)     while (1000+65 <= i) { println (b); b++; i--; }
 647 acc16= constant 1000
 648 acc16+ constant 65
 649 acc16Comp variable 2
 650 brgt 661
 651 acc8= variable 0
 652 call writeLineAcc8
 653 incr8 variable 0
 654 decr16 variable 2
 655 br 647
 656 ;test1.j(224)   
 657 ;test1.j(225)     /************************/
 658 ;test1.j(226)     // acc - acc
 659 ;test1.j(227)     // byte - byte
 660 ;test1.j(228)     b=87;
 661 acc8= constant 87
 662 acc8=> variable 0
 663 ;test1.j(229)     b2=64;
 664 acc8= constant 64
 665 acc8=> variable 1
 666 ;test1.j(230)     while (63+0 <= b2+0) { println (b); b++; b2--; }
 667 acc8= constant 63
 668 acc8+ constant 0
 669 <acc8
 670 acc8= variable 1
 671 acc8+ constant 0
 672 revAcc8Comp unstack8
 673 brlt 681
 674 acc8= variable 0
 675 call writeLineAcc8
 676 incr8 variable 0
 677 decr8 variable 1
 678 br 667
 679 ;test1.j(231)     // byte - integer
 680 ;test1.j(232)     i=62;
 681 acc8= constant 62
 682 acc8=> variable 2
 683 ;test1.j(233)     while (61+0 <= i+0) { println (b); b++; i--; }
 684 acc8= constant 61
 685 acc8+ constant 0
 686 <acc8
 687 acc16= variable 2
 688 acc16+ constant 0
 689 acc8= unstack8
 690 acc8CompareAcc16
 691 brgt 699
 692 acc8= variable 0
 693 call writeLineAcc8
 694 incr8 variable 0
 695 decr16 variable 2
 696 br 684
 697 ;test1.j(234)     // integer - byte
 698 ;test1.j(235)     i=59;
 699 acc8= constant 59
 700 acc8=> variable 2
 701 ;test1.j(236)     b2=60;
 702 acc8= constant 60
 703 acc8=> variable 1
 704 ;test1.j(237)     while (i+0 <= b2+0) { println (b); b++; b2--; }
 705 acc16= variable 2
 706 acc16+ constant 0
 707 <acc16
 708 acc8= variable 1
 709 acc8+ constant 0
 710 acc16= unstack16
 711 acc16CompareAcc8
 712 brgt 720
 713 acc8= variable 0
 714 call writeLineAcc8
 715 incr8 variable 0
 716 decr8 variable 1
 717 br 705
 718 ;test1.j(238)     // integer - integer
 719 ;test1.j(239)     i=1058;
 720 acc16= constant 1058
 721 acc16=> variable 2
 722 ;test1.j(240)     while (1000+57 <= i+0) { println (b); b++; i--; }
 723 acc16= constant 1000
 724 acc16+ constant 57
 725 <acc16
 726 acc16= variable 2
 727 acc16+ constant 0
 728 revAcc16Comp unstack16
 729 brlt 740
 730 acc8= variable 0
 731 call writeLineAcc8
 732 incr8 variable 0
 733 decr16 variable 2
 734 br 723
 735 ;test1.j(241)   
 736 ;test1.j(242)     /************************/
 737 ;test1.j(243)     // acc - constant
 738 ;test1.j(244)     // byte - byte
 739 ;test1.j(245)     while (b+0 <= 96) { println (b); b++; }
 740 acc8= variable 0
 741 acc8+ constant 0
 742 acc8Comp constant 96
 743 brgt 752
 744 acc8= variable 0
 745 call writeLineAcc8
 746 incr8 variable 0
 747 br 740
 748 ;test1.j(246)     // byte - integer
 749 ;test1.j(247)     //not relevant
 750 ;test1.j(248)     // integer - byte
 751 ;test1.j(249)     i=b;
 752 acc8= variable 0
 753 acc8=> variable 2
 754 ;test1.j(250)     while (i+0 <= 98) { println (i); i++; }
 755 acc16= variable 2
 756 acc16+ constant 0
 757 acc8= constant 98
 758 acc16CompareAcc8
 759 brgt 765
 760 acc16= variable 2
 761 call writeLineAcc16
 762 incr16 variable 2
 763 br 755
 764 ;test1.j(251)     b=i;
 765 acc16= variable 2
 766 acc16=> variable 0
 767 ;test1.j(252)     i=1052;
 768 acc16= constant 1052
 769 acc16=> variable 2
 770 ;test1.j(253)     // integer - integer
 771 ;test1.j(254)     while (i+0 <= 1053) { println (b); b++; i++; }
 772 acc16= variable 2
 773 acc16+ constant 0
 774 acc16Comp constant 1053
 775 brgt 787
 776 acc8= variable 0
 777 call writeLineAcc8
 778 incr8 variable 0
 779 incr16 variable 2
 780 br 772
 781 ;test1.j(255)   
 782 ;test1.j(256)     /************************/
 783 ;test1.j(257)     // constant - stack8
 784 ;test1.j(258)     // byte - byte
 785 ;test1.j(259)     //TODO
 786 ;test1.j(260)     println(101);
 787 acc8= constant 101
 788 call writeLineAcc8
 789 ;test1.j(261)     println(102);
 790 acc8= constant 102
 791 call writeLineAcc8
 792 ;test1.j(262)     // constant - stack8
 793 ;test1.j(263)     // byte - integer
 794 ;test1.j(264)     //TODO
 795 ;test1.j(265)     println(103);
 796 acc8= constant 103
 797 call writeLineAcc8
 798 ;test1.j(266)     println(104);
 799 acc8= constant 104
 800 call writeLineAcc8
 801 ;test1.j(267)     // constant - stack8
 802 ;test1.j(268)     // integer - byte
 803 ;test1.j(269)     //TODO
 804 ;test1.j(270)     println(105);
 805 acc8= constant 105
 806 call writeLineAcc8
 807 ;test1.j(271)     println(106);
 808 acc8= constant 106
 809 call writeLineAcc8
 810 ;test1.j(272)     // constant - stack88
 811 ;test1.j(273)     // integer - integer
 812 ;test1.j(274)     //TODO
 813 ;test1.j(275)     println(107);
 814 acc8= constant 107
 815 call writeLineAcc8
 816 ;test1.j(276)     println(108);
 817 acc8= constant 108
 818 call writeLineAcc8
 819 ;test1.j(277)   
 820 ;test1.j(278)     /************************/
 821 ;test1.j(279)     // constant - stack16
 822 ;test1.j(280)     // byte - byte
 823 ;test1.j(281)     //TODO
 824 ;test1.j(282)     println(109);
 825 acc8= constant 109
 826 call writeLineAcc8
 827 ;test1.j(283)     println(110);
 828 acc8= constant 110
 829 call writeLineAcc8
 830 ;test1.j(284)     // constant - stack16
 831 ;test1.j(285)     // byte - integer
 832 ;test1.j(286)     //TODO
 833 ;test1.j(287)     println(111);
 834 acc8= constant 111
 835 call writeLineAcc8
 836 ;test1.j(288)     println(112);
 837 acc8= constant 112
 838 call writeLineAcc8
 839 ;test1.j(289)     // constant - stack16
 840 ;test1.j(290)     // integer - byte
 841 ;test1.j(291)     //TODO
 842 ;test1.j(292)     println(113);
 843 acc8= constant 113
 844 call writeLineAcc8
 845 ;test1.j(293)     println(114);
 846 acc8= constant 114
 847 call writeLineAcc8
 848 ;test1.j(294)     // constant - stack16
 849 ;test1.j(295)     // integer - integer
 850 ;test1.j(296)     //TODO
 851 ;test1.j(297)     println(115);
 852 acc8= constant 115
 853 call writeLineAcc8
 854 ;test1.j(298)     println(116);
 855 acc8= constant 116
 856 call writeLineAcc8
 857 ;test1.j(299)   
 858 ;test1.j(300)     println("Klaar");
 859 acc16= constant 864
 860 writeLineString
 861 ;test1.j(301)   }
 862 ;test1.j(302) }
 863 stop
 864 stringConstant 0 = "Klaar"
