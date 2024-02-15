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
  19 ;test1.j(8)   static word j = 1001;
  20 acc16= constant 1001
  21 acc16=> variable 8
  22 ;test1.j(9)   static byte c = b;
  23 acc8= variable 0
  24 acc8=> variable 10
  25 ;test1.j(10)   static byte d = c;
  26 acc8= variable 10
  27 acc8=> variable 11
  28 ;test1.j(11) 
  29 ;test1.j(12)   public static void main() {
  30 method main [public, static] void
  31 ;test1.j(13)     /*Possible operand types: 
  32 ;test1.j(14)      * constant, acc, var, stack8, stack16
  33 ;test1.j(15)      *Possible datatype combinations:
  34 ;test1.j(16)      * byte - byte
  35 ;test1.j(17)      * byte - integer
  36 ;test1.j(18)      * integer - byte
  37 ;test1.j(19)      * integer - integer
  38 ;test1.j(20)     */
  39 ;test1.j(21)   
  40 ;test1.j(22)     println(0);
  41 acc8= constant 0
  42 call writeLineAcc8
  43 ;test1.j(23)   
  44 ;test1.j(24)     /************************/
  45 ;test1.j(25)     // global variable within while scope
  46 ;test1.j(26)     b++;
  47 incr8 variable 0
  48 ;test1.j(27)     println (b);
  49 acc8= variable 0
  50 call writeLineAcc8
  51 ;test1.j(28)     while (b < 2) {
  52 acc8= variable 0
  53 acc8Comp constant 2
  54 brge 83
  55 ;test1.j(29)       b++;
  56 incr8 variable 0
  57 ;test1.j(30)       //word j = 1001;
  58 ;test1.j(31)       //byte c = b;
  59 ;test1.j(32)       //byte d = c;
  60 ;test1.j(33)       j = 1001;
  61 acc16= constant 1001
  62 acc16=> variable 8
  63 ;test1.j(34)       c = b;
  64 acc8= variable 0
  65 acc8=> variable 10
  66 ;test1.j(35)       d = c;
  67 acc8= variable 10
  68 acc8=> variable 11
  69 ;test1.j(36)       println (c);
  70 acc8= variable 10
  71 call writeLineAcc8
  72 br 52
  73 ;test1.j(37)     }
  74 ;test1.j(38)   
  75 ;test1.j(39)     /************************/
  76 ;test1.j(40)     // constant - constant
  77 ;test1.j(41)     // not relevant
  78 ;test1.j(42)   
  79 ;test1.j(43)     /************************/
  80 ;test1.j(44)     // constant - acc
  81 ;test1.j(45)     // byte - byte
  82 ;test1.j(46)     b = 3;
  83 acc8= constant 3
  84 acc8=> variable 0
  85 ;test1.j(47)     while (3 == b+0) { println (b); b++; }
  86 acc8= variable 0
  87 acc8+ constant 0
  88 acc8Comp constant 3
  89 brne 95
  90 acc8= variable 0
  91 call writeLineAcc8
  92 incr8 variable 0
  93 br 86
  94 ;test1.j(48)     while (4 != b+0) { println (b); b++; }
  95 acc8= variable 0
  96 acc8+ constant 0
  97 acc8Comp constant 4
  98 breq 104
  99 acc8= variable 0
 100 call writeLineAcc8
 101 incr8 variable 0
 102 br 95
 103 ;test1.j(49)     while (6 > b+0) { println (b); b++; }
 104 acc8= variable 0
 105 acc8+ constant 0
 106 acc8Comp constant 6
 107 brge 113
 108 acc8= variable 0
 109 call writeLineAcc8
 110 incr8 variable 0
 111 br 104
 112 ;test1.j(50)     while (7 >= b+0) { println (b); b++; }
 113 acc8= variable 0
 114 acc8+ constant 0
 115 acc8Comp constant 7
 116 brgt 122
 117 acc8= variable 0
 118 call writeLineAcc8
 119 incr8 variable 0
 120 br 113
 121 ;test1.j(51)     p=8;
 122 acc8= constant 8
 123 acc8=> variable 6
 124 ;test1.j(52)     while (6 <  b+0) { println (p); p++; b--; }
 125 acc8= variable 0
 126 acc8+ constant 0
 127 acc8Comp constant 6
 128 brle 135
 129 acc16= variable 6
 130 call writeLineAcc16
 131 incr16 variable 6
 132 decr8 variable 0
 133 br 125
 134 ;test1.j(53)     while (5 <= b+0) { println (p); p++; b--; }
 135 acc8= variable 0
 136 acc8+ constant 0
 137 acc8Comp constant 5
 138 brlt 148
 139 acc16= variable 6
 140 call writeLineAcc16
 141 incr16 variable 6
 142 decr8 variable 0
 143 br 135
 144 ;test1.j(54)     
 145 ;test1.j(55)     // constant - acc
 146 ;test1.j(56)     // byte - integer
 147 ;test1.j(57)     i=12;
 148 acc8= constant 12
 149 acc8=> variable 2
 150 ;test1.j(58)     while (12 == i+0) { println (i); i++; }
 151 acc16= variable 2
 152 acc16+ constant 0
 153 acc8= constant 12
 154 acc8CompareAcc16
 155 brne 161
 156 acc16= variable 2
 157 call writeLineAcc16
 158 incr16 variable 2
 159 br 151
 160 ;test1.j(59)     while (15 != i+0) { println (i); i++; }
 161 acc16= variable 2
 162 acc16+ constant 0
 163 acc8= constant 15
 164 acc8CompareAcc16
 165 breq 171
 166 acc16= variable 2
 167 call writeLineAcc16
 168 incr16 variable 2
 169 br 161
 170 ;test1.j(60)     while (17 > i+0) { println (i); i++; }
 171 acc16= variable 2
 172 acc16+ constant 0
 173 acc8= constant 17
 174 acc8CompareAcc16
 175 brle 181
 176 acc16= variable 2
 177 call writeLineAcc16
 178 incr16 variable 2
 179 br 171
 180 ;test1.j(61)     while (18 >= i+0) { println (i); i++; }
 181 acc16= variable 2
 182 acc16+ constant 0
 183 acc8= constant 18
 184 acc8CompareAcc16
 185 brlt 191
 186 acc16= variable 2
 187 call writeLineAcc16
 188 incr16 variable 2
 189 br 181
 190 ;test1.j(62)     p=i;
 191 acc16= variable 2
 192 acc16=> variable 6
 193 ;test1.j(63)     while (17 <  i+0) { println (p); i--; p++; }
 194 acc16= variable 2
 195 acc16+ constant 0
 196 acc8= constant 17
 197 acc8CompareAcc16
 198 brge 205
 199 acc16= variable 6
 200 call writeLineAcc16
 201 decr16 variable 2
 202 incr16 variable 6
 203 br 194
 204 ;test1.j(64)     while (16 <= i+0) { println (p); i--; p++; }
 205 acc16= variable 2
 206 acc16+ constant 0
 207 acc8= constant 16
 208 acc8CompareAcc16
 209 brgt 223
 210 acc16= variable 6
 211 call writeLineAcc16
 212 decr16 variable 2
 213 incr16 variable 6
 214 br 205
 215 ;test1.j(65)   
 216 ;test1.j(66)     // constant - acc
 217 ;test1.j(67)     // integer - byte
 218 ;test1.j(68)     // not relevant
 219 ;test1.j(69)   
 220 ;test1.j(70)     // constant - acc
 221 ;test1.j(71)     // integer - integer
 222 ;test1.j(72)     i=23;
 223 acc8= constant 23
 224 acc8=> variable 2
 225 ;test1.j(73)     while (23 == i+0) { println (i); i++; }
 226 acc16= variable 2
 227 acc16+ constant 0
 228 acc8= constant 23
 229 acc8CompareAcc16
 230 brne 236
 231 acc16= variable 2
 232 call writeLineAcc16
 233 incr16 variable 2
 234 br 226
 235 ;test1.j(74)     while (26 != i+0) { println (i); i++; }
 236 acc16= variable 2
 237 acc16+ constant 0
 238 acc8= constant 26
 239 acc8CompareAcc16
 240 breq 246
 241 acc16= variable 2
 242 call writeLineAcc16
 243 incr16 variable 2
 244 br 236
 245 ;test1.j(75)     while (28 > i+0) { println (i); i++; }
 246 acc16= variable 2
 247 acc16+ constant 0
 248 acc8= constant 28
 249 acc8CompareAcc16
 250 brle 256
 251 acc16= variable 2
 252 call writeLineAcc16
 253 incr16 variable 2
 254 br 246
 255 ;test1.j(76)     while (29 >= i+0) { println (i); i++; }
 256 acc16= variable 2
 257 acc16+ constant 0
 258 acc8= constant 29
 259 acc8CompareAcc16
 260 brlt 266
 261 acc16= variable 2
 262 call writeLineAcc16
 263 incr16 variable 2
 264 br 256
 265 ;test1.j(77)     p=i;
 266 acc16= variable 2
 267 acc16=> variable 6
 268 ;test1.j(78)     while (28 <  i+0) { println (p); p++; i--; }
 269 acc16= variable 2
 270 acc16+ constant 0
 271 acc8= constant 28
 272 acc8CompareAcc16
 273 brge 280
 274 acc16= variable 6
 275 call writeLineAcc16
 276 incr16 variable 6
 277 decr16 variable 2
 278 br 269
 279 ;test1.j(79)     while (27 <= i+0) { println (p); p++; i--; }
 280 acc16= variable 2
 281 acc16+ constant 0
 282 acc8= constant 27
 283 acc8CompareAcc16
 284 brgt 295
 285 acc16= variable 6
 286 call writeLineAcc16
 287 incr16 variable 6
 288 decr16 variable 2
 289 br 280
 290 ;test1.j(80)   
 291 ;test1.j(81)     /************************/
 292 ;test1.j(82)     // constant - var
 293 ;test1.j(83)     // byte - byte
 294 ;test1.j(84)     b=35;
 295 acc8= constant 35
 296 acc8=> variable 0
 297 ;test1.j(85)     while (33 <= b) { println (p); p++; b--; }
 298 acc8= variable 0
 299 acc8Comp constant 33
 300 brlt 309
 301 acc16= variable 6
 302 call writeLineAcc16
 303 incr16 variable 6
 304 decr8 variable 0
 305 br 298
 306 ;test1.j(86)     // constant - var
 307 ;test1.j(87)     // byte - integer
 308 ;test1.j(88)     i=37;
 309 acc8= constant 37
 310 acc8=> variable 2
 311 ;test1.j(89)     while (36 <= i) { println (p); p++; i--; }
 312 acc16= variable 2
 313 acc8= constant 36
 314 acc8CompareAcc16
 315 brgt 328
 316 acc16= variable 6
 317 call writeLineAcc16
 318 incr16 variable 6
 319 decr16 variable 2
 320 br 312
 321 ;test1.j(90)     // constant - var
 322 ;test1.j(91)     // integer - byte
 323 ;test1.j(92)     // not relevant
 324 ;test1.j(93)   
 325 ;test1.j(94)     // constant - var
 326 ;test1.j(95)     // integer - integer
 327 ;test1.j(96)     while (34 <= i) { println (p); p++; i--; }
 328 acc16= variable 2
 329 acc8= constant 34
 330 acc8CompareAcc16
 331 brgt 374
 332 acc16= variable 6
 333 call writeLineAcc16
 334 incr16 variable 6
 335 decr16 variable 2
 336 br 328
 337 ;test1.j(97)   
 338 ;test1.j(98)     /************************/
 339 ;test1.j(99)     // stack8 - constant
 340 ;test1.j(100)     // stack8 - acc
 341 ;test1.j(101)     // stack8 - var
 342 ;test1.j(102)     // stack8 - stack8
 343 ;test1.j(103)     // stack8 - stack16
 344 ;test1.j(104)     //TODO
 345 ;test1.j(105)   
 346 ;test1.j(106)     /************************/
 347 ;test1.j(107)     // stack16 - constant
 348 ;test1.j(108)     // stack16 - acc
 349 ;test1.j(109)     // stack16 - var
 350 ;test1.j(110)     // stack16 - stack8
 351 ;test1.j(111)     // stack16 - stack16
 352 ;test1.j(112)     //TODO
 353 ;test1.j(113)   
 354 ;test1.j(114)     /************************/
 355 ;test1.j(115)     // var - stack16
 356 ;test1.j(116)     // byte - byte
 357 ;test1.j(117)     // byte - integer
 358 ;test1.j(118)     // integer - byte
 359 ;test1.j(119)     // integer - integer
 360 ;test1.j(120)     //TODO
 361 ;test1.j(121)   
 362 ;test1.j(122)     /************************/
 363 ;test1.j(123)     // var - stack8
 364 ;test1.j(124)     // byte - byte
 365 ;test1.j(125)     // byte - integer
 366 ;test1.j(126)     // integer - byte
 367 ;test1.j(127)     // integer - integer
 368 ;test1.j(128)     //TODO
 369 ;test1.j(129)   
 370 ;test1.j(130)     /************************/
 371 ;test1.j(131)     // var - var
 372 ;test1.j(132)     // byte - byte
 373 ;test1.j(133)     b=33;
 374 acc8= constant 33
 375 acc8=> variable 0
 376 ;test1.j(134)     while (b2 <= b) { println (p); p++; b--; }
 377 acc8= variable 1
 378 acc8Comp variable 0
 379 brgt 387
 380 acc16= variable 6
 381 call writeLineAcc16
 382 incr16 variable 6
 383 decr8 variable 0
 384 br 377
 385 ;test1.j(135)     // byte - integer
 386 ;test1.j(136)     i = 33;
 387 acc8= constant 33
 388 acc8=> variable 2
 389 ;test1.j(137)     while (b2 <= i) { println (p); p++; i--; }
 390 acc8= variable 1
 391 acc16= variable 2
 392 acc8CompareAcc16
 393 brgt 401
 394 acc16= variable 6
 395 call writeLineAcc16
 396 incr16 variable 6
 397 decr16 variable 2
 398 br 390
 399 ;test1.j(138)     // integer - byte
 400 ;test1.j(139)     b=33;
 401 acc8= constant 33
 402 acc8=> variable 0
 403 ;test1.j(140)     i=b2;
 404 acc8= variable 1
 405 acc8=> variable 2
 406 ;test1.j(141)     while (i <= b) { println (p); p++; b--; }
 407 acc16= variable 2
 408 acc8= variable 0
 409 acc16CompareAcc8
 410 brgt 418
 411 acc16= variable 6
 412 call writeLineAcc16
 413 incr16 variable 6
 414 decr8 variable 0
 415 br 407
 416 ;test1.j(142)     // integer - integer
 417 ;test1.j(143)     i=33;
 418 acc8= constant 33
 419 acc8=> variable 2
 420 ;test1.j(144)     i2=b2;
 421 acc8= variable 1
 422 acc8=> variable 4
 423 ;test1.j(145)     while (i2 <= i) { println (p); p++; i--; }
 424 acc16= variable 4
 425 acc16Comp variable 2
 426 brgt 437
 427 acc16= variable 6
 428 call writeLineAcc16
 429 incr16 variable 6
 430 decr16 variable 2
 431 br 424
 432 ;test1.j(146)   
 433 ;test1.j(147)     /************************/
 434 ;test1.j(148)     // var - acc
 435 ;test1.j(149)     // byte - byte
 436 ;test1.j(150)     b=49;
 437 acc8= constant 49
 438 acc8=> variable 0
 439 ;test1.j(151)     while (b <= 50+0) { println (b); b++; }
 440 acc8= constant 50
 441 acc8+ constant 0
 442 acc8Comp variable 0
 443 brlt 450
 444 acc8= variable 0
 445 call writeLineAcc8
 446 incr8 variable 0
 447 br 440
 448 ;test1.j(152)     // byte - integer
 449 ;test1.j(153)     i=52;
 450 acc8= constant 52
 451 acc8=> variable 2
 452 ;test1.j(154)     while (b <= i+0) { println (b); b++; }
 453 acc16= variable 2
 454 acc16+ constant 0
 455 acc8= variable 0
 456 acc8CompareAcc16
 457 brgt 464
 458 acc8= variable 0
 459 call writeLineAcc8
 460 incr8 variable 0
 461 br 453
 462 ;test1.j(155)     // integer - byte
 463 ;test1.j(156)     i=b;
 464 acc8= variable 0
 465 acc8=> variable 2
 466 ;test1.j(157)     while (i <= 54+0) { println (i); i++; }
 467 acc8= constant 54
 468 acc8+ constant 0
 469 acc16= variable 2
 470 acc16CompareAcc8
 471 brgt 478
 472 acc16= variable 2
 473 call writeLineAcc16
 474 incr16 variable 2
 475 br 467
 476 ;test1.j(158)     // integer - integer
 477 ;test1.j(159)     b=i;
 478 acc16= variable 2
 479 acc16=> variable 0
 480 ;test1.j(160)     i=1098;
 481 acc16= constant 1098
 482 acc16=> variable 2
 483 ;test1.j(161)     while (i <= 1099+0) { println (b); b++; i++; }
 484 acc16= constant 1099
 485 acc16+ constant 0
 486 acc16Comp variable 2
 487 brlt 498
 488 acc8= variable 0
 489 call writeLineAcc8
 490 incr8 variable 0
 491 incr16 variable 2
 492 br 484
 493 ;test1.j(162)   
 494 ;test1.j(163)     /************************/
 495 ;test1.j(164)     // var - constant
 496 ;test1.j(165)     // byte - byte
 497 ;test1.j(166)     while (b <= 58) { println (b); b++; }
 498 acc8= variable 0
 499 acc8Comp constant 58
 500 brgt 510
 501 acc8= variable 0
 502 call writeLineAcc8
 503 incr8 variable 0
 504 br 498
 505 ;test1.j(167)     // byte - integer
 506 ;test1.j(168)     //not relevant
 507 ;test1.j(169)   
 508 ;test1.j(170)     // integer - byte
 509 ;test1.j(171)     i=b;
 510 acc8= variable 0
 511 acc8=> variable 2
 512 ;test1.j(172)     while (i <= 60) { println (i); i++; }
 513 acc16= variable 2
 514 acc8= constant 60
 515 acc16CompareAcc8
 516 brgt 523
 517 acc16= variable 2
 518 call writeLineAcc16
 519 incr16 variable 2
 520 br 513
 521 ;test1.j(173)     // integer - integer
 522 ;test1.j(174)     i2=1090;
 523 acc16= constant 1090
 524 acc16=> variable 4
 525 ;test1.j(175)     while (i2 <= 1091) { println (i); i++; i2++; }
 526 acc16= variable 4
 527 acc16Comp constant 1091
 528 brgt 540
 529 acc16= variable 2
 530 call writeLineAcc16
 531 incr16 variable 2
 532 incr16 variable 4
 533 br 526
 534 ;test1.j(176)   
 535 ;test1.j(177)     /************************/
 536 ;test1.j(178)     // acc - stack8
 537 ;test1.j(179)     // byte - byte
 538 ;test1.j(180)     //TODO
 539 ;test1.j(181)     println(63);
 540 acc8= constant 63
 541 call writeLineAcc8
 542 ;test1.j(182)     println(64);
 543 acc8= constant 64
 544 call writeLineAcc8
 545 ;test1.j(183)     // byte - integer
 546 ;test1.j(184)     //TODO
 547 ;test1.j(185)     println(65);
 548 acc8= constant 65
 549 call writeLineAcc8
 550 ;test1.j(186)     println(66);
 551 acc8= constant 66
 552 call writeLineAcc8
 553 ;test1.j(187)     // integer - byte
 554 ;test1.j(188)     //TODO
 555 ;test1.j(189)     println(67);
 556 acc8= constant 67
 557 call writeLineAcc8
 558 ;test1.j(190)     println(68);
 559 acc8= constant 68
 560 call writeLineAcc8
 561 ;test1.j(191)     // integer - integer
 562 ;test1.j(192)     //TODO
 563 ;test1.j(193)     println(69);
 564 acc8= constant 69
 565 call writeLineAcc8
 566 ;test1.j(194)     println(70);
 567 acc8= constant 70
 568 call writeLineAcc8
 569 ;test1.j(195)   
 570 ;test1.j(196)     /************************/
 571 ;test1.j(197)     // acc - stack16
 572 ;test1.j(198)     // byte - byte
 573 ;test1.j(199)     //TODO
 574 ;test1.j(200)     println(71);
 575 acc8= constant 71
 576 call writeLineAcc8
 577 ;test1.j(201)     println(72);
 578 acc8= constant 72
 579 call writeLineAcc8
 580 ;test1.j(202)     // byte - integer
 581 ;test1.j(203)     //TODO
 582 ;test1.j(204)     println(73);
 583 acc8= constant 73
 584 call writeLineAcc8
 585 ;test1.j(205)     println(74);
 586 acc8= constant 74
 587 call writeLineAcc8
 588 ;test1.j(206)     // integer - byte
 589 ;test1.j(207)     //TODO
 590 ;test1.j(208)     println(75);
 591 acc8= constant 75
 592 call writeLineAcc8
 593 ;test1.j(209)     println(76);
 594 acc8= constant 76
 595 call writeLineAcc8
 596 ;test1.j(210)     // integer - integer
 597 ;test1.j(211)     //TODO
 598 ;test1.j(212)     println(77);
 599 acc8= constant 77
 600 call writeLineAcc8
 601 ;test1.j(213)     println(78);
 602 acc8= constant 78
 603 call writeLineAcc8
 604 ;test1.j(214)   
 605 ;test1.j(215)     /************************/
 606 ;test1.j(216)     // acc - var
 607 ;test1.j(217)     // byte - byte
 608 ;test1.j(218)     b=79;
 609 acc8= constant 79
 610 acc8=> variable 0
 611 ;test1.j(219)     b2=79;
 612 acc8= constant 79
 613 acc8=> variable 1
 614 ;test1.j(220)     while (78+0 <= b2) { println (b); b++; b2--; }
 615 acc8= constant 78
 616 acc8+ constant 0
 617 acc8Comp variable 1
 618 brgt 626
 619 acc8= variable 0
 620 call writeLineAcc8
 621 incr8 variable 0
 622 decr8 variable 1
 623 br 615
 624 ;test1.j(221)     // byte - integer
 625 ;test1.j(222)     i=79;
 626 acc8= constant 79
 627 acc8=> variable 2
 628 ;test1.j(223)     while (78+0 <= i) { println (b); b++; i--; }
 629 acc8= constant 78
 630 acc8+ constant 0
 631 acc16= variable 2
 632 acc8CompareAcc16
 633 brgt 641
 634 acc8= variable 0
 635 call writeLineAcc8
 636 incr8 variable 0
 637 decr16 variable 2
 638 br 629
 639 ;test1.j(224)     // integer - byte
 640 ;test1.j(225)     i=78;
 641 acc8= constant 78
 642 acc8=> variable 2
 643 ;test1.j(226)     b2=79;
 644 acc8= constant 79
 645 acc8=> variable 1
 646 ;test1.j(227)     while (i+0 <= b2) { println (b); b++; b2--; } 
 647 acc16= variable 2
 648 acc16+ constant 0
 649 acc8= variable 1
 650 acc16CompareAcc8
 651 brgt 659
 652 acc8= variable 0
 653 call writeLineAcc8
 654 incr8 variable 0
 655 decr8 variable 1
 656 br 647
 657 ;test1.j(228)     // integer - integer
 658 ;test1.j(229)     i=1066;
 659 acc16= constant 1066
 660 acc16=> variable 2
 661 ;test1.j(230)     while (1000+65 <= i) { println (b); b++; i--; }
 662 acc16= constant 1000
 663 acc16+ constant 65
 664 acc16Comp variable 2
 665 brgt 676
 666 acc8= variable 0
 667 call writeLineAcc8
 668 incr8 variable 0
 669 decr16 variable 2
 670 br 662
 671 ;test1.j(231)   
 672 ;test1.j(232)     /************************/
 673 ;test1.j(233)     // acc - acc
 674 ;test1.j(234)     // byte - byte
 675 ;test1.j(235)     b=87;
 676 acc8= constant 87
 677 acc8=> variable 0
 678 ;test1.j(236)     b2=64;
 679 acc8= constant 64
 680 acc8=> variable 1
 681 ;test1.j(237)     while (63+0 <= b2+0) { println (b); b++; b2--; }
 682 acc8= constant 63
 683 acc8+ constant 0
 684 <acc8
 685 acc8= variable 1
 686 acc8+ constant 0
 687 revAcc8Comp unstack8
 688 brlt 696
 689 acc8= variable 0
 690 call writeLineAcc8
 691 incr8 variable 0
 692 decr8 variable 1
 693 br 682
 694 ;test1.j(238)     // byte - integer
 695 ;test1.j(239)     i=62;
 696 acc8= constant 62
 697 acc8=> variable 2
 698 ;test1.j(240)     while (61+0 <= i+0) { println (b); b++; i--; }
 699 acc8= constant 61
 700 acc8+ constant 0
 701 <acc8
 702 acc16= variable 2
 703 acc16+ constant 0
 704 acc8= unstack8
 705 acc8CompareAcc16
 706 brgt 714
 707 acc8= variable 0
 708 call writeLineAcc8
 709 incr8 variable 0
 710 decr16 variable 2
 711 br 699
 712 ;test1.j(241)     // integer - byte
 713 ;test1.j(242)     i=59;
 714 acc8= constant 59
 715 acc8=> variable 2
 716 ;test1.j(243)     b2=60;
 717 acc8= constant 60
 718 acc8=> variable 1
 719 ;test1.j(244)     while (i+0 <= b2+0) { println (b); b++; b2--; }
 720 acc16= variable 2
 721 acc16+ constant 0
 722 <acc16
 723 acc8= variable 1
 724 acc8+ constant 0
 725 acc16= unstack16
 726 acc16CompareAcc8
 727 brgt 735
 728 acc8= variable 0
 729 call writeLineAcc8
 730 incr8 variable 0
 731 decr8 variable 1
 732 br 720
 733 ;test1.j(245)     // integer - integer
 734 ;test1.j(246)     i=1058;
 735 acc16= constant 1058
 736 acc16=> variable 2
 737 ;test1.j(247)     while (1000+57 <= i+0) { println (b); b++; i--; }
 738 acc16= constant 1000
 739 acc16+ constant 57
 740 <acc16
 741 acc16= variable 2
 742 acc16+ constant 0
 743 revAcc16Comp unstack16
 744 brlt 755
 745 acc8= variable 0
 746 call writeLineAcc8
 747 incr8 variable 0
 748 decr16 variable 2
 749 br 738
 750 ;test1.j(248)   
 751 ;test1.j(249)     /************************/
 752 ;test1.j(250)     // acc - constant
 753 ;test1.j(251)     // byte - byte
 754 ;test1.j(252)     while (b+0 <= 96) { println (b); b++; }
 755 acc8= variable 0
 756 acc8+ constant 0
 757 acc8Comp constant 96
 758 brgt 767
 759 acc8= variable 0
 760 call writeLineAcc8
 761 incr8 variable 0
 762 br 755
 763 ;test1.j(253)     // byte - integer
 764 ;test1.j(254)     //not relevant
 765 ;test1.j(255)     // integer - byte
 766 ;test1.j(256)     i=b;
 767 acc8= variable 0
 768 acc8=> variable 2
 769 ;test1.j(257)     while (i+0 <= 98) { println (i); i++; }
 770 acc16= variable 2
 771 acc16+ constant 0
 772 acc8= constant 98
 773 acc16CompareAcc8
 774 brgt 780
 775 acc16= variable 2
 776 call writeLineAcc16
 777 incr16 variable 2
 778 br 770
 779 ;test1.j(258)     b=i;
 780 acc16= variable 2
 781 acc16=> variable 0
 782 ;test1.j(259)     i=1052;
 783 acc16= constant 1052
 784 acc16=> variable 2
 785 ;test1.j(260)     // integer - integer
 786 ;test1.j(261)     while (i+0 <= 1053) { println (b); b++; i++; }
 787 acc16= variable 2
 788 acc16+ constant 0
 789 acc16Comp constant 1053
 790 brgt 802
 791 acc8= variable 0
 792 call writeLineAcc8
 793 incr8 variable 0
 794 incr16 variable 2
 795 br 787
 796 ;test1.j(262)   
 797 ;test1.j(263)     /************************/
 798 ;test1.j(264)     // constant - stack8
 799 ;test1.j(265)     // byte - byte
 800 ;test1.j(266)     //TODO
 801 ;test1.j(267)     println(101);
 802 acc8= constant 101
 803 call writeLineAcc8
 804 ;test1.j(268)     println(102);
 805 acc8= constant 102
 806 call writeLineAcc8
 807 ;test1.j(269)     // constant - stack8
 808 ;test1.j(270)     // byte - integer
 809 ;test1.j(271)     //TODO
 810 ;test1.j(272)     println(103);
 811 acc8= constant 103
 812 call writeLineAcc8
 813 ;test1.j(273)     println(104);
 814 acc8= constant 104
 815 call writeLineAcc8
 816 ;test1.j(274)     // constant - stack8
 817 ;test1.j(275)     // integer - byte
 818 ;test1.j(276)     //TODO
 819 ;test1.j(277)     println(105);
 820 acc8= constant 105
 821 call writeLineAcc8
 822 ;test1.j(278)     println(106);
 823 acc8= constant 106
 824 call writeLineAcc8
 825 ;test1.j(279)     // constant - stack88
 826 ;test1.j(280)     // integer - integer
 827 ;test1.j(281)     //TODO
 828 ;test1.j(282)     println(107);
 829 acc8= constant 107
 830 call writeLineAcc8
 831 ;test1.j(283)     println(108);
 832 acc8= constant 108
 833 call writeLineAcc8
 834 ;test1.j(284)   
 835 ;test1.j(285)     /************************/
 836 ;test1.j(286)     // constant - stack16
 837 ;test1.j(287)     // byte - byte
 838 ;test1.j(288)     //TODO
 839 ;test1.j(289)     println(109);
 840 acc8= constant 109
 841 call writeLineAcc8
 842 ;test1.j(290)     println(110);
 843 acc8= constant 110
 844 call writeLineAcc8
 845 ;test1.j(291)     // constant - stack16
 846 ;test1.j(292)     // byte - integer
 847 ;test1.j(293)     //TODO
 848 ;test1.j(294)     println(111);
 849 acc8= constant 111
 850 call writeLineAcc8
 851 ;test1.j(295)     println(112);
 852 acc8= constant 112
 853 call writeLineAcc8
 854 ;test1.j(296)     // constant - stack16
 855 ;test1.j(297)     // integer - byte
 856 ;test1.j(298)     //TODO
 857 ;test1.j(299)     println(113);
 858 acc8= constant 113
 859 call writeLineAcc8
 860 ;test1.j(300)     println(114);
 861 acc8= constant 114
 862 call writeLineAcc8
 863 ;test1.j(301)     // constant - stack16
 864 ;test1.j(302)     // integer - integer
 865 ;test1.j(303)     //TODO
 866 ;test1.j(304)     println(115);
 867 acc8= constant 115
 868 call writeLineAcc8
 869 ;test1.j(305)     println(116);
 870 acc8= constant 116
 871 call writeLineAcc8
 872 ;test1.j(306)   
 873 ;test1.j(307)     println("Klaar");
 874 acc16= constant 879
 875 writeLineString
 876 ;test1.j(308)   }
 877 ;test1.j(309) }
 878 stop
 879 stringConstant 0 = "Klaar"
