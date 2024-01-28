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
  19 method main [staticLexeme] voidLexeme
  20 ;test1.j(9)     /*Possible operand types: 
  21 ;test1.j(10)      * constant, acc, var, stack8, stack16
  22 ;test1.j(11)      *Possible datatype combinations:
  23 ;test1.j(12)      * byte - byte
  24 ;test1.j(13)      * byte - integer
  25 ;test1.j(14)      * integer - byte
  26 ;test1.j(15)      * integer - integer
  27 ;test1.j(16)     */
  28 ;test1.j(17)   
  29 ;test1.j(18)     println(0);
  30 acc8= constant 0
  31 call writeLineAcc8
  32 ;test1.j(19)   
  33 ;test1.j(20)     /************************/
  34 ;test1.j(21)     // global variable within while scope
  35 ;test1.j(22)     b++;
  36 incr8 variable 0
  37 ;test1.j(23)     println (b);
  38 acc8= variable 0
  39 call writeLineAcc8
  40 ;test1.j(24)     while (b < 2) {
  41 acc8= variable 0
  42 acc8Comp constant 2
  43 brge 69
  44 ;test1.j(25)       b++;
  45 incr8 variable 0
  46 ;test1.j(26)       word j = 1001;
  47 acc16= constant 1001
  48 acc16=> variable 8
  49 ;test1.j(27)       byte c = b;
  50 acc8= variable 0
  51 acc8=> variable 10
  52 ;test1.j(28)       byte d = c;
  53 acc8= variable 10
  54 acc8=> variable 11
  55 ;test1.j(29)       println (c);
  56 acc8= variable 10
  57 call writeLineAcc8
  58 ;test1.j(30)     }
  59 br 41
  60 ;test1.j(31)   
  61 ;test1.j(32)     /************************/
  62 ;test1.j(33)     // constant - constant
  63 ;test1.j(34)     // not relevant
  64 ;test1.j(35)   
  65 ;test1.j(36)     /************************/
  66 ;test1.j(37)     // constant - acc
  67 ;test1.j(38)     // byte - byte
  68 ;test1.j(39)     b = 3;
  69 acc8= constant 3
  70 acc8=> variable 0
  71 ;test1.j(40)     while (3 == b+0) { println (b); b++; }
  72 acc8= variable 0
  73 acc8+ constant 0
  74 acc8Comp constant 3
  75 brne 81
  76 acc8= variable 0
  77 call writeLineAcc8
  78 incr8 variable 0
  79 br 72
  80 ;test1.j(41)     while (4 != b+0) { println (b); b++; }
  81 acc8= variable 0
  82 acc8+ constant 0
  83 acc8Comp constant 4
  84 breq 90
  85 acc8= variable 0
  86 call writeLineAcc8
  87 incr8 variable 0
  88 br 81
  89 ;test1.j(42)     while (6 > b+0) { println (b); b++; }
  90 acc8= variable 0
  91 acc8+ constant 0
  92 acc8Comp constant 6
  93 brge 99
  94 acc8= variable 0
  95 call writeLineAcc8
  96 incr8 variable 0
  97 br 90
  98 ;test1.j(43)     while (7 >= b+0) { println (b); b++; }
  99 acc8= variable 0
 100 acc8+ constant 0
 101 acc8Comp constant 7
 102 brgt 108
 103 acc8= variable 0
 104 call writeLineAcc8
 105 incr8 variable 0
 106 br 99
 107 ;test1.j(44)     p=8;
 108 acc8= constant 8
 109 acc8=> variable 6
 110 ;test1.j(45)     while (6 <  b+0) { println (p); p++; b--; }
 111 acc8= variable 0
 112 acc8+ constant 0
 113 acc8Comp constant 6
 114 brle 121
 115 acc16= variable 6
 116 call writeLineAcc16
 117 incr16 variable 6
 118 decr8 variable 0
 119 br 111
 120 ;test1.j(46)     while (5 <= b+0) { println (p); p++; b--; }
 121 acc8= variable 0
 122 acc8+ constant 0
 123 acc8Comp constant 5
 124 brlt 134
 125 acc16= variable 6
 126 call writeLineAcc16
 127 incr16 variable 6
 128 decr8 variable 0
 129 br 121
 130 ;test1.j(47)     
 131 ;test1.j(48)     // constant - acc
 132 ;test1.j(49)     // byte - integer
 133 ;test1.j(50)     i=12;
 134 acc8= constant 12
 135 acc8=> variable 2
 136 ;test1.j(51)     while (12 == i+0) { println (i); i++; }
 137 acc16= variable 2
 138 acc16+ constant 0
 139 acc8= constant 12
 140 acc8CompareAcc16
 141 brne 147
 142 acc16= variable 2
 143 call writeLineAcc16
 144 incr16 variable 2
 145 br 137
 146 ;test1.j(52)     while (15 != i+0) { println (i); i++; }
 147 acc16= variable 2
 148 acc16+ constant 0
 149 acc8= constant 15
 150 acc8CompareAcc16
 151 breq 157
 152 acc16= variable 2
 153 call writeLineAcc16
 154 incr16 variable 2
 155 br 147
 156 ;test1.j(53)     while (17 > i+0) { println (i); i++; }
 157 acc16= variable 2
 158 acc16+ constant 0
 159 acc8= constant 17
 160 acc8CompareAcc16
 161 brle 167
 162 acc16= variable 2
 163 call writeLineAcc16
 164 incr16 variable 2
 165 br 157
 166 ;test1.j(54)     while (18 >= i+0) { println (i); i++; }
 167 acc16= variable 2
 168 acc16+ constant 0
 169 acc8= constant 18
 170 acc8CompareAcc16
 171 brlt 177
 172 acc16= variable 2
 173 call writeLineAcc16
 174 incr16 variable 2
 175 br 167
 176 ;test1.j(55)     p=i;
 177 acc16= variable 2
 178 acc16=> variable 6
 179 ;test1.j(56)     while (17 <  i+0) { println (p); i--; p++; }
 180 acc16= variable 2
 181 acc16+ constant 0
 182 acc8= constant 17
 183 acc8CompareAcc16
 184 brge 191
 185 acc16= variable 6
 186 call writeLineAcc16
 187 decr16 variable 2
 188 incr16 variable 6
 189 br 180
 190 ;test1.j(57)     while (16 <= i+0) { println (p); i--; p++; }
 191 acc16= variable 2
 192 acc16+ constant 0
 193 acc8= constant 16
 194 acc8CompareAcc16
 195 brgt 209
 196 acc16= variable 6
 197 call writeLineAcc16
 198 decr16 variable 2
 199 incr16 variable 6
 200 br 191
 201 ;test1.j(58)   
 202 ;test1.j(59)     // constant - acc
 203 ;test1.j(60)     // integer - byte
 204 ;test1.j(61)     // not relevant
 205 ;test1.j(62)   
 206 ;test1.j(63)     // constant - acc
 207 ;test1.j(64)     // integer - integer
 208 ;test1.j(65)     i=23;
 209 acc8= constant 23
 210 acc8=> variable 2
 211 ;test1.j(66)     while (23 == i+0) { println (i); i++; }
 212 acc16= variable 2
 213 acc16+ constant 0
 214 acc8= constant 23
 215 acc8CompareAcc16
 216 brne 222
 217 acc16= variable 2
 218 call writeLineAcc16
 219 incr16 variable 2
 220 br 212
 221 ;test1.j(67)     while (26 != i+0) { println (i); i++; }
 222 acc16= variable 2
 223 acc16+ constant 0
 224 acc8= constant 26
 225 acc8CompareAcc16
 226 breq 232
 227 acc16= variable 2
 228 call writeLineAcc16
 229 incr16 variable 2
 230 br 222
 231 ;test1.j(68)     while (28 > i+0) { println (i); i++; }
 232 acc16= variable 2
 233 acc16+ constant 0
 234 acc8= constant 28
 235 acc8CompareAcc16
 236 brle 242
 237 acc16= variable 2
 238 call writeLineAcc16
 239 incr16 variable 2
 240 br 232
 241 ;test1.j(69)     while (29 >= i+0) { println (i); i++; }
 242 acc16= variable 2
 243 acc16+ constant 0
 244 acc8= constant 29
 245 acc8CompareAcc16
 246 brlt 252
 247 acc16= variable 2
 248 call writeLineAcc16
 249 incr16 variable 2
 250 br 242
 251 ;test1.j(70)     p=i;
 252 acc16= variable 2
 253 acc16=> variable 6
 254 ;test1.j(71)     while (28 <  i+0) { println (p); p++; i--; }
 255 acc16= variable 2
 256 acc16+ constant 0
 257 acc8= constant 28
 258 acc8CompareAcc16
 259 brge 266
 260 acc16= variable 6
 261 call writeLineAcc16
 262 incr16 variable 6
 263 decr16 variable 2
 264 br 255
 265 ;test1.j(72)     while (27 <= i+0) { println (p); p++; i--; }
 266 acc16= variable 2
 267 acc16+ constant 0
 268 acc8= constant 27
 269 acc8CompareAcc16
 270 brgt 281
 271 acc16= variable 6
 272 call writeLineAcc16
 273 incr16 variable 6
 274 decr16 variable 2
 275 br 266
 276 ;test1.j(73)   
 277 ;test1.j(74)     /************************/
 278 ;test1.j(75)     // constant - var
 279 ;test1.j(76)     // byte - byte
 280 ;test1.j(77)     b=35;
 281 acc8= constant 35
 282 acc8=> variable 0
 283 ;test1.j(78)     while (33 <= b) { println (p); p++; b--; }
 284 acc8= variable 0
 285 acc8Comp constant 33
 286 brlt 295
 287 acc16= variable 6
 288 call writeLineAcc16
 289 incr16 variable 6
 290 decr8 variable 0
 291 br 284
 292 ;test1.j(79)     // constant - var
 293 ;test1.j(80)     // byte - integer
 294 ;test1.j(81)     i=37;
 295 acc8= constant 37
 296 acc8=> variable 2
 297 ;test1.j(82)     while (36 <= i) { println (p); p++; i--; }
 298 acc16= variable 2
 299 acc8= constant 36
 300 acc8CompareAcc16
 301 brgt 314
 302 acc16= variable 6
 303 call writeLineAcc16
 304 incr16 variable 6
 305 decr16 variable 2
 306 br 298
 307 ;test1.j(83)     // constant - var
 308 ;test1.j(84)     // integer - byte
 309 ;test1.j(85)     // not relevant
 310 ;test1.j(86)   
 311 ;test1.j(87)     // constant - var
 312 ;test1.j(88)     // integer - integer
 313 ;test1.j(89)     while (34 <= i) { println (p); p++; i--; }
 314 acc16= variable 2
 315 acc8= constant 34
 316 acc8CompareAcc16
 317 brgt 360
 318 acc16= variable 6
 319 call writeLineAcc16
 320 incr16 variable 6
 321 decr16 variable 2
 322 br 314
 323 ;test1.j(90)   
 324 ;test1.j(91)     /************************/
 325 ;test1.j(92)     // stack8 - constant
 326 ;test1.j(93)     // stack8 - acc
 327 ;test1.j(94)     // stack8 - var
 328 ;test1.j(95)     // stack8 - stack8
 329 ;test1.j(96)     // stack8 - stack16
 330 ;test1.j(97)     //TODO
 331 ;test1.j(98)   
 332 ;test1.j(99)     /************************/
 333 ;test1.j(100)     // stack16 - constant
 334 ;test1.j(101)     // stack16 - acc
 335 ;test1.j(102)     // stack16 - var
 336 ;test1.j(103)     // stack16 - stack8
 337 ;test1.j(104)     // stack16 - stack16
 338 ;test1.j(105)     //TODO
 339 ;test1.j(106)   
 340 ;test1.j(107)     /************************/
 341 ;test1.j(108)     // var - stack16
 342 ;test1.j(109)     // byte - byte
 343 ;test1.j(110)     // byte - integer
 344 ;test1.j(111)     // integer - byte
 345 ;test1.j(112)     // integer - integer
 346 ;test1.j(113)     //TODO
 347 ;test1.j(114)   
 348 ;test1.j(115)     /************************/
 349 ;test1.j(116)     // var - stack8
 350 ;test1.j(117)     // byte - byte
 351 ;test1.j(118)     // byte - integer
 352 ;test1.j(119)     // integer - byte
 353 ;test1.j(120)     // integer - integer
 354 ;test1.j(121)     //TODO
 355 ;test1.j(122)   
 356 ;test1.j(123)     /************************/
 357 ;test1.j(124)     // var - var
 358 ;test1.j(125)     // byte - byte
 359 ;test1.j(126)     b=33;
 360 acc8= constant 33
 361 acc8=> variable 0
 362 ;test1.j(127)     while (b2 <= b) { println (p); p++; b--; }
 363 acc8= variable 1
 364 acc8Comp variable 0
 365 brgt 373
 366 acc16= variable 6
 367 call writeLineAcc16
 368 incr16 variable 6
 369 decr8 variable 0
 370 br 363
 371 ;test1.j(128)     // byte - integer
 372 ;test1.j(129)     i = 33;
 373 acc8= constant 33
 374 acc8=> variable 2
 375 ;test1.j(130)     while (b2 <= i) { println (p); p++; i--; }
 376 acc8= variable 1
 377 acc16= variable 2
 378 acc8CompareAcc16
 379 brgt 387
 380 acc16= variable 6
 381 call writeLineAcc16
 382 incr16 variable 6
 383 decr16 variable 2
 384 br 376
 385 ;test1.j(131)     // integer - byte
 386 ;test1.j(132)     b=33;
 387 acc8= constant 33
 388 acc8=> variable 0
 389 ;test1.j(133)     i=b2;
 390 acc8= variable 1
 391 acc8=> variable 2
 392 ;test1.j(134)     while (i <= b) { println (p); p++; b--; }
 393 acc16= variable 2
 394 acc8= variable 0
 395 acc16CompareAcc8
 396 brgt 404
 397 acc16= variable 6
 398 call writeLineAcc16
 399 incr16 variable 6
 400 decr8 variable 0
 401 br 393
 402 ;test1.j(135)     // integer - integer
 403 ;test1.j(136)     i=33;
 404 acc8= constant 33
 405 acc8=> variable 2
 406 ;test1.j(137)     i2=b2;
 407 acc8= variable 1
 408 acc8=> variable 4
 409 ;test1.j(138)     while (i2 <= i) { println (p); p++; i--; }
 410 acc16= variable 4
 411 acc16Comp variable 2
 412 brgt 423
 413 acc16= variable 6
 414 call writeLineAcc16
 415 incr16 variable 6
 416 decr16 variable 2
 417 br 410
 418 ;test1.j(139)   
 419 ;test1.j(140)     /************************/
 420 ;test1.j(141)     // var - acc
 421 ;test1.j(142)     // byte - byte
 422 ;test1.j(143)     b=49;
 423 acc8= constant 49
 424 acc8=> variable 0
 425 ;test1.j(144)     while (b <= 50+0) { println (b); b++; }
 426 acc8= constant 50
 427 acc8+ constant 0
 428 acc8Comp variable 0
 429 brlt 436
 430 acc8= variable 0
 431 call writeLineAcc8
 432 incr8 variable 0
 433 br 426
 434 ;test1.j(145)     // byte - integer
 435 ;test1.j(146)     i=52;
 436 acc8= constant 52
 437 acc8=> variable 2
 438 ;test1.j(147)     while (b <= i+0) { println (b); b++; }
 439 acc16= variable 2
 440 acc16+ constant 0
 441 acc8= variable 0
 442 acc8CompareAcc16
 443 brgt 450
 444 acc8= variable 0
 445 call writeLineAcc8
 446 incr8 variable 0
 447 br 439
 448 ;test1.j(148)     // integer - byte
 449 ;test1.j(149)     i=b;
 450 acc8= variable 0
 451 acc8=> variable 2
 452 ;test1.j(150)     while (i <= 54+0) { println (i); i++; }
 453 acc8= constant 54
 454 acc8+ constant 0
 455 acc16= variable 2
 456 acc16CompareAcc8
 457 brgt 464
 458 acc16= variable 2
 459 call writeLineAcc16
 460 incr16 variable 2
 461 br 453
 462 ;test1.j(151)     // integer - integer
 463 ;test1.j(152)     b=i;
 464 acc16= variable 2
 465 acc16=> variable 0
 466 ;test1.j(153)     i=1098;
 467 acc16= constant 1098
 468 acc16=> variable 2
 469 ;test1.j(154)     while (i <= 1099+0) { println (b); b++; i++; }
 470 acc16= constant 1099
 471 acc16+ constant 0
 472 acc16Comp variable 2
 473 brlt 484
 474 acc8= variable 0
 475 call writeLineAcc8
 476 incr8 variable 0
 477 incr16 variable 2
 478 br 470
 479 ;test1.j(155)   
 480 ;test1.j(156)     /************************/
 481 ;test1.j(157)     // var - constant
 482 ;test1.j(158)     // byte - byte
 483 ;test1.j(159)     while (b <= 58) { println (b); b++; }
 484 acc8= variable 0
 485 acc8Comp constant 58
 486 brgt 496
 487 acc8= variable 0
 488 call writeLineAcc8
 489 incr8 variable 0
 490 br 484
 491 ;test1.j(160)     // byte - integer
 492 ;test1.j(161)     //not relevant
 493 ;test1.j(162)   
 494 ;test1.j(163)     // integer - byte
 495 ;test1.j(164)     i=b;
 496 acc8= variable 0
 497 acc8=> variable 2
 498 ;test1.j(165)     while (i <= 60) { println (i); i++; }
 499 acc16= variable 2
 500 acc8= constant 60
 501 acc16CompareAcc8
 502 brgt 509
 503 acc16= variable 2
 504 call writeLineAcc16
 505 incr16 variable 2
 506 br 499
 507 ;test1.j(166)     // integer - integer
 508 ;test1.j(167)     i2=1090;
 509 acc16= constant 1090
 510 acc16=> variable 4
 511 ;test1.j(168)     while (i2 <= 1091) { println (i); i++; i2++; }
 512 acc16= variable 4
 513 acc16Comp constant 1091
 514 brgt 526
 515 acc16= variable 2
 516 call writeLineAcc16
 517 incr16 variable 2
 518 incr16 variable 4
 519 br 512
 520 ;test1.j(169)   
 521 ;test1.j(170)     /************************/
 522 ;test1.j(171)     // acc - stack8
 523 ;test1.j(172)     // byte - byte
 524 ;test1.j(173)     //TODO
 525 ;test1.j(174)     println(63);
 526 acc8= constant 63
 527 call writeLineAcc8
 528 ;test1.j(175)     println(64);
 529 acc8= constant 64
 530 call writeLineAcc8
 531 ;test1.j(176)     // byte - integer
 532 ;test1.j(177)     //TODO
 533 ;test1.j(178)     println(65);
 534 acc8= constant 65
 535 call writeLineAcc8
 536 ;test1.j(179)     println(66);
 537 acc8= constant 66
 538 call writeLineAcc8
 539 ;test1.j(180)     // integer - byte
 540 ;test1.j(181)     //TODO
 541 ;test1.j(182)     println(67);
 542 acc8= constant 67
 543 call writeLineAcc8
 544 ;test1.j(183)     println(68);
 545 acc8= constant 68
 546 call writeLineAcc8
 547 ;test1.j(184)     // integer - integer
 548 ;test1.j(185)     //TODO
 549 ;test1.j(186)     println(69);
 550 acc8= constant 69
 551 call writeLineAcc8
 552 ;test1.j(187)     println(70);
 553 acc8= constant 70
 554 call writeLineAcc8
 555 ;test1.j(188)   
 556 ;test1.j(189)     /************************/
 557 ;test1.j(190)     // acc - stack16
 558 ;test1.j(191)     // byte - byte
 559 ;test1.j(192)     //TODO
 560 ;test1.j(193)     println(71);
 561 acc8= constant 71
 562 call writeLineAcc8
 563 ;test1.j(194)     println(72);
 564 acc8= constant 72
 565 call writeLineAcc8
 566 ;test1.j(195)     // byte - integer
 567 ;test1.j(196)     //TODO
 568 ;test1.j(197)     println(73);
 569 acc8= constant 73
 570 call writeLineAcc8
 571 ;test1.j(198)     println(74);
 572 acc8= constant 74
 573 call writeLineAcc8
 574 ;test1.j(199)     // integer - byte
 575 ;test1.j(200)     //TODO
 576 ;test1.j(201)     println(75);
 577 acc8= constant 75
 578 call writeLineAcc8
 579 ;test1.j(202)     println(76);
 580 acc8= constant 76
 581 call writeLineAcc8
 582 ;test1.j(203)     // integer - integer
 583 ;test1.j(204)     //TODO
 584 ;test1.j(205)     println(77);
 585 acc8= constant 77
 586 call writeLineAcc8
 587 ;test1.j(206)     println(78);
 588 acc8= constant 78
 589 call writeLineAcc8
 590 ;test1.j(207)   
 591 ;test1.j(208)     /************************/
 592 ;test1.j(209)     // acc - var
 593 ;test1.j(210)     // byte - byte
 594 ;test1.j(211)     b=79;
 595 acc8= constant 79
 596 acc8=> variable 0
 597 ;test1.j(212)     b2=79;
 598 acc8= constant 79
 599 acc8=> variable 1
 600 ;test1.j(213)     while (78+0 <= b2) { println (b); b++; b2--; }
 601 acc8= constant 78
 602 acc8+ constant 0
 603 acc8Comp variable 1
 604 brgt 612
 605 acc8= variable 0
 606 call writeLineAcc8
 607 incr8 variable 0
 608 decr8 variable 1
 609 br 601
 610 ;test1.j(214)     // byte - integer
 611 ;test1.j(215)     i=79;
 612 acc8= constant 79
 613 acc8=> variable 2
 614 ;test1.j(216)     while (78+0 <= i) { println (b); b++; i--; }
 615 acc8= constant 78
 616 acc8+ constant 0
 617 acc16= variable 2
 618 acc8CompareAcc16
 619 brgt 627
 620 acc8= variable 0
 621 call writeLineAcc8
 622 incr8 variable 0
 623 decr16 variable 2
 624 br 615
 625 ;test1.j(217)     // integer - byte
 626 ;test1.j(218)     i=78;
 627 acc8= constant 78
 628 acc8=> variable 2
 629 ;test1.j(219)     b2=79;
 630 acc8= constant 79
 631 acc8=> variable 1
 632 ;test1.j(220)     while (i+0 <= b2) { println (b); b++; b2--; } 
 633 acc16= variable 2
 634 acc16+ constant 0
 635 acc8= variable 1
 636 acc16CompareAcc8
 637 brgt 645
 638 acc8= variable 0
 639 call writeLineAcc8
 640 incr8 variable 0
 641 decr8 variable 1
 642 br 633
 643 ;test1.j(221)     // integer - integer
 644 ;test1.j(222)     i=1066;
 645 acc16= constant 1066
 646 acc16=> variable 2
 647 ;test1.j(223)     while (1000+65 <= i) { println (b); b++; i--; }
 648 acc16= constant 1000
 649 acc16+ constant 65
 650 acc16Comp variable 2
 651 brgt 662
 652 acc8= variable 0
 653 call writeLineAcc8
 654 incr8 variable 0
 655 decr16 variable 2
 656 br 648
 657 ;test1.j(224)   
 658 ;test1.j(225)     /************************/
 659 ;test1.j(226)     // acc - acc
 660 ;test1.j(227)     // byte - byte
 661 ;test1.j(228)     b=87;
 662 acc8= constant 87
 663 acc8=> variable 0
 664 ;test1.j(229)     b2=64;
 665 acc8= constant 64
 666 acc8=> variable 1
 667 ;test1.j(230)     while (63+0 <= b2+0) { println (b); b++; b2--; }
 668 acc8= constant 63
 669 acc8+ constant 0
 670 <acc8
 671 acc8= variable 1
 672 acc8+ constant 0
 673 revAcc8Comp unstack8
 674 brlt 682
 675 acc8= variable 0
 676 call writeLineAcc8
 677 incr8 variable 0
 678 decr8 variable 1
 679 br 668
 680 ;test1.j(231)     // byte - integer
 681 ;test1.j(232)     i=62;
 682 acc8= constant 62
 683 acc8=> variable 2
 684 ;test1.j(233)     while (61+0 <= i+0) { println (b); b++; i--; }
 685 acc8= constant 61
 686 acc8+ constant 0
 687 <acc8
 688 acc16= variable 2
 689 acc16+ constant 0
 690 acc8= unstack8
 691 acc8CompareAcc16
 692 brgt 700
 693 acc8= variable 0
 694 call writeLineAcc8
 695 incr8 variable 0
 696 decr16 variable 2
 697 br 685
 698 ;test1.j(234)     // integer - byte
 699 ;test1.j(235)     i=59;
 700 acc8= constant 59
 701 acc8=> variable 2
 702 ;test1.j(236)     b2=60;
 703 acc8= constant 60
 704 acc8=> variable 1
 705 ;test1.j(237)     while (i+0 <= b2+0) { println (b); b++; b2--; }
 706 acc16= variable 2
 707 acc16+ constant 0
 708 <acc16
 709 acc8= variable 1
 710 acc8+ constant 0
 711 acc16= unstack16
 712 acc16CompareAcc8
 713 brgt 721
 714 acc8= variable 0
 715 call writeLineAcc8
 716 incr8 variable 0
 717 decr8 variable 1
 718 br 706
 719 ;test1.j(238)     // integer - integer
 720 ;test1.j(239)     i=1058;
 721 acc16= constant 1058
 722 acc16=> variable 2
 723 ;test1.j(240)     while (1000+57 <= i+0) { println (b); b++; i--; }
 724 acc16= constant 1000
 725 acc16+ constant 57
 726 <acc16
 727 acc16= variable 2
 728 acc16+ constant 0
 729 revAcc16Comp unstack16
 730 brlt 741
 731 acc8= variable 0
 732 call writeLineAcc8
 733 incr8 variable 0
 734 decr16 variable 2
 735 br 724
 736 ;test1.j(241)   
 737 ;test1.j(242)     /************************/
 738 ;test1.j(243)     // acc - constant
 739 ;test1.j(244)     // byte - byte
 740 ;test1.j(245)     while (b+0 <= 96) { println (b); b++; }
 741 acc8= variable 0
 742 acc8+ constant 0
 743 acc8Comp constant 96
 744 brgt 753
 745 acc8= variable 0
 746 call writeLineAcc8
 747 incr8 variable 0
 748 br 741
 749 ;test1.j(246)     // byte - integer
 750 ;test1.j(247)     //not relevant
 751 ;test1.j(248)     // integer - byte
 752 ;test1.j(249)     i=b;
 753 acc8= variable 0
 754 acc8=> variable 2
 755 ;test1.j(250)     while (i+0 <= 98) { println (i); i++; }
 756 acc16= variable 2
 757 acc16+ constant 0
 758 acc8= constant 98
 759 acc16CompareAcc8
 760 brgt 766
 761 acc16= variable 2
 762 call writeLineAcc16
 763 incr16 variable 2
 764 br 756
 765 ;test1.j(251)     b=i;
 766 acc16= variable 2
 767 acc16=> variable 0
 768 ;test1.j(252)     i=1052;
 769 acc16= constant 1052
 770 acc16=> variable 2
 771 ;test1.j(253)     // integer - integer
 772 ;test1.j(254)     while (i+0 <= 1053) { println (b); b++; i++; }
 773 acc16= variable 2
 774 acc16+ constant 0
 775 acc16Comp constant 1053
 776 brgt 788
 777 acc8= variable 0
 778 call writeLineAcc8
 779 incr8 variable 0
 780 incr16 variable 2
 781 br 773
 782 ;test1.j(255)   
 783 ;test1.j(256)     /************************/
 784 ;test1.j(257)     // constant - stack8
 785 ;test1.j(258)     // byte - byte
 786 ;test1.j(259)     //TODO
 787 ;test1.j(260)     println(101);
 788 acc8= constant 101
 789 call writeLineAcc8
 790 ;test1.j(261)     println(102);
 791 acc8= constant 102
 792 call writeLineAcc8
 793 ;test1.j(262)     // constant - stack8
 794 ;test1.j(263)     // byte - integer
 795 ;test1.j(264)     //TODO
 796 ;test1.j(265)     println(103);
 797 acc8= constant 103
 798 call writeLineAcc8
 799 ;test1.j(266)     println(104);
 800 acc8= constant 104
 801 call writeLineAcc8
 802 ;test1.j(267)     // constant - stack8
 803 ;test1.j(268)     // integer - byte
 804 ;test1.j(269)     //TODO
 805 ;test1.j(270)     println(105);
 806 acc8= constant 105
 807 call writeLineAcc8
 808 ;test1.j(271)     println(106);
 809 acc8= constant 106
 810 call writeLineAcc8
 811 ;test1.j(272)     // constant - stack88
 812 ;test1.j(273)     // integer - integer
 813 ;test1.j(274)     //TODO
 814 ;test1.j(275)     println(107);
 815 acc8= constant 107
 816 call writeLineAcc8
 817 ;test1.j(276)     println(108);
 818 acc8= constant 108
 819 call writeLineAcc8
 820 ;test1.j(277)   
 821 ;test1.j(278)     /************************/
 822 ;test1.j(279)     // constant - stack16
 823 ;test1.j(280)     // byte - byte
 824 ;test1.j(281)     //TODO
 825 ;test1.j(282)     println(109);
 826 acc8= constant 109
 827 call writeLineAcc8
 828 ;test1.j(283)     println(110);
 829 acc8= constant 110
 830 call writeLineAcc8
 831 ;test1.j(284)     // constant - stack16
 832 ;test1.j(285)     // byte - integer
 833 ;test1.j(286)     //TODO
 834 ;test1.j(287)     println(111);
 835 acc8= constant 111
 836 call writeLineAcc8
 837 ;test1.j(288)     println(112);
 838 acc8= constant 112
 839 call writeLineAcc8
 840 ;test1.j(289)     // constant - stack16
 841 ;test1.j(290)     // integer - byte
 842 ;test1.j(291)     //TODO
 843 ;test1.j(292)     println(113);
 844 acc8= constant 113
 845 call writeLineAcc8
 846 ;test1.j(293)     println(114);
 847 acc8= constant 114
 848 call writeLineAcc8
 849 ;test1.j(294)     // constant - stack16
 850 ;test1.j(295)     // integer - integer
 851 ;test1.j(296)     //TODO
 852 ;test1.j(297)     println(115);
 853 acc8= constant 115
 854 call writeLineAcc8
 855 ;test1.j(298)     println(116);
 856 acc8= constant 116
 857 call writeLineAcc8
 858 ;test1.j(299)   
 859 ;test1.j(300)     println("Klaar");
 860 acc16= constant 865
 861 writeLineString
 862 ;test1.j(301)   }
 863 ;test1.j(302) }
 864 stop
 865 stringConstant 0 = "Klaar"
