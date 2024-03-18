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
  22 method main [public, static] void ()
  23 <basePointer
  24 basePointer= stackPointer
  25 stackPointer+ constant 4
  26 ;test1.j(9)     /*Possible operand types: 
  27 ;test1.j(10)      * constant, acc, var, stack8, stack16
  28 ;test1.j(11)      *Possible datatype combinations:
  29 ;test1.j(12)      * byte - byte
  30 ;test1.j(13)      * byte - integer
  31 ;test1.j(14)      * integer - byte
  32 ;test1.j(15)      * integer - integer
  33 ;test1.j(16)     */
  34 ;test1.j(17)   
  35 ;test1.j(18)     println(0);
  36 acc8= constant 0
  37 writeLineAcc8
  38 ;test1.j(19)   
  39 ;test1.j(20)     /************************/
  40 ;test1.j(21)     // global variable within while scope
  41 ;test1.j(22)     b++;
  42 incr8 variable 0
  43 ;test1.j(23)     println (b);
  44 acc8= variable 0
  45 writeLineAcc8
  46 ;test1.j(24)     while (b < 2) {
  47 acc8= variable 0
  48 acc8Comp constant 2
  49 brge 75
  50 ;test1.j(25)       b++;
  51 incr8 variable 0
  52 ;test1.j(26)       word j = 1001;
  53 acc16= constant 1001
  54 acc16=> (basePointer + -2)
  55 ;test1.j(27)       byte c = b;
  56 acc8= variable 0
  57 acc8=> (basePointer + -3)
  58 ;test1.j(28)       byte d = c;
  59 acc8= (basePointer + -3)
  60 acc8=> (basePointer + -4)
  61 ;test1.j(29)       println (c);
  62 acc8= (basePointer + -3)
  63 writeLineAcc8
  64 br 47
  65 ;test1.j(30)     }
  66 ;test1.j(31)   
  67 ;test1.j(32)     /************************/
  68 ;test1.j(33)     // constant - constant
  69 ;test1.j(34)     // not relevant
  70 ;test1.j(35)   
  71 ;test1.j(36)     /************************/
  72 ;test1.j(37)     // constant - acc
  73 ;test1.j(38)     // byte - byte
  74 ;test1.j(39)     b = 3;
  75 acc8= constant 3
  76 acc8=> variable 0
  77 ;test1.j(40)     while (3 == b+0) { println (b); b++; }
  78 acc8= variable 0
  79 acc8+ constant 0
  80 acc8Comp constant 3
  81 brne 87
  82 acc8= variable 0
  83 writeLineAcc8
  84 incr8 variable 0
  85 br 78
  86 ;test1.j(41)     while (4 != b+0) { println (b); b++; }
  87 acc8= variable 0
  88 acc8+ constant 0
  89 acc8Comp constant 4
  90 breq 96
  91 acc8= variable 0
  92 writeLineAcc8
  93 incr8 variable 0
  94 br 87
  95 ;test1.j(42)     while (6 > b+0) { println (b); b++; }
  96 acc8= variable 0
  97 acc8+ constant 0
  98 acc8Comp constant 6
  99 brge 105
 100 acc8= variable 0
 101 writeLineAcc8
 102 incr8 variable 0
 103 br 96
 104 ;test1.j(43)     while (7 >= b+0) { println (b); b++; }
 105 acc8= variable 0
 106 acc8+ constant 0
 107 acc8Comp constant 7
 108 brgt 114
 109 acc8= variable 0
 110 writeLineAcc8
 111 incr8 variable 0
 112 br 105
 113 ;test1.j(44)     p=8;
 114 acc8= constant 8
 115 acc8=> variable 6
 116 ;test1.j(45)     while (6 <  b+0) { println (p); p++; b--; }
 117 acc8= variable 0
 118 acc8+ constant 0
 119 acc8Comp constant 6
 120 brle 127
 121 acc16= variable 6
 122 writeLineAcc16
 123 incr16 variable 6
 124 decr8 variable 0
 125 br 117
 126 ;test1.j(46)     while (5 <= b+0) { println (p); p++; b--; }
 127 acc8= variable 0
 128 acc8+ constant 0
 129 acc8Comp constant 5
 130 brlt 140
 131 acc16= variable 6
 132 writeLineAcc16
 133 incr16 variable 6
 134 decr8 variable 0
 135 br 127
 136 ;test1.j(47)     
 137 ;test1.j(48)     // constant - acc
 138 ;test1.j(49)     // byte - integer
 139 ;test1.j(50)     i=12;
 140 acc8= constant 12
 141 acc8=> variable 2
 142 ;test1.j(51)     while (12 == i+0) { println (i); i++; }
 143 acc16= variable 2
 144 acc16+ constant 0
 145 acc8= constant 12
 146 acc8CompareAcc16
 147 brne 153
 148 acc16= variable 2
 149 writeLineAcc16
 150 incr16 variable 2
 151 br 143
 152 ;test1.j(52)     while (15 != i+0) { println (i); i++; }
 153 acc16= variable 2
 154 acc16+ constant 0
 155 acc8= constant 15
 156 acc8CompareAcc16
 157 breq 163
 158 acc16= variable 2
 159 writeLineAcc16
 160 incr16 variable 2
 161 br 153
 162 ;test1.j(53)     while (17 > i+0) { println (i); i++; }
 163 acc16= variable 2
 164 acc16+ constant 0
 165 acc8= constant 17
 166 acc8CompareAcc16
 167 brle 173
 168 acc16= variable 2
 169 writeLineAcc16
 170 incr16 variable 2
 171 br 163
 172 ;test1.j(54)     while (18 >= i+0) { println (i); i++; }
 173 acc16= variable 2
 174 acc16+ constant 0
 175 acc8= constant 18
 176 acc8CompareAcc16
 177 brlt 183
 178 acc16= variable 2
 179 writeLineAcc16
 180 incr16 variable 2
 181 br 173
 182 ;test1.j(55)     p=i;
 183 acc16= variable 2
 184 acc16=> variable 6
 185 ;test1.j(56)     while (17 <  i+0) { println (p); i--; p++; }
 186 acc16= variable 2
 187 acc16+ constant 0
 188 acc8= constant 17
 189 acc8CompareAcc16
 190 brge 197
 191 acc16= variable 6
 192 writeLineAcc16
 193 decr16 variable 2
 194 incr16 variable 6
 195 br 186
 196 ;test1.j(57)     while (16 <= i+0) { println (p); i--; p++; }
 197 acc16= variable 2
 198 acc16+ constant 0
 199 acc8= constant 16
 200 acc8CompareAcc16
 201 brgt 215
 202 acc16= variable 6
 203 writeLineAcc16
 204 decr16 variable 2
 205 incr16 variable 6
 206 br 197
 207 ;test1.j(58)   
 208 ;test1.j(59)     // constant - acc
 209 ;test1.j(60)     // integer - byte
 210 ;test1.j(61)     // not relevant
 211 ;test1.j(62)   
 212 ;test1.j(63)     // constant - acc
 213 ;test1.j(64)     // integer - integer
 214 ;test1.j(65)     i=23;
 215 acc8= constant 23
 216 acc8=> variable 2
 217 ;test1.j(66)     while (23 == i+0) { println (i); i++; }
 218 acc16= variable 2
 219 acc16+ constant 0
 220 acc8= constant 23
 221 acc8CompareAcc16
 222 brne 228
 223 acc16= variable 2
 224 writeLineAcc16
 225 incr16 variable 2
 226 br 218
 227 ;test1.j(67)     while (26 != i+0) { println (i); i++; }
 228 acc16= variable 2
 229 acc16+ constant 0
 230 acc8= constant 26
 231 acc8CompareAcc16
 232 breq 238
 233 acc16= variable 2
 234 writeLineAcc16
 235 incr16 variable 2
 236 br 228
 237 ;test1.j(68)     while (28 > i+0) { println (i); i++; }
 238 acc16= variable 2
 239 acc16+ constant 0
 240 acc8= constant 28
 241 acc8CompareAcc16
 242 brle 248
 243 acc16= variable 2
 244 writeLineAcc16
 245 incr16 variable 2
 246 br 238
 247 ;test1.j(69)     while (29 >= i+0) { println (i); i++; }
 248 acc16= variable 2
 249 acc16+ constant 0
 250 acc8= constant 29
 251 acc8CompareAcc16
 252 brlt 258
 253 acc16= variable 2
 254 writeLineAcc16
 255 incr16 variable 2
 256 br 248
 257 ;test1.j(70)     p=i;
 258 acc16= variable 2
 259 acc16=> variable 6
 260 ;test1.j(71)     while (28 <  i+0) { println (p); p++; i--; }
 261 acc16= variable 2
 262 acc16+ constant 0
 263 acc8= constant 28
 264 acc8CompareAcc16
 265 brge 272
 266 acc16= variable 6
 267 writeLineAcc16
 268 incr16 variable 6
 269 decr16 variable 2
 270 br 261
 271 ;test1.j(72)     while (27 <= i+0) { println (p); p++; i--; }
 272 acc16= variable 2
 273 acc16+ constant 0
 274 acc8= constant 27
 275 acc8CompareAcc16
 276 brgt 287
 277 acc16= variable 6
 278 writeLineAcc16
 279 incr16 variable 6
 280 decr16 variable 2
 281 br 272
 282 ;test1.j(73)   
 283 ;test1.j(74)     /************************/
 284 ;test1.j(75)     // constant - var
 285 ;test1.j(76)     // byte - byte
 286 ;test1.j(77)     b=35;
 287 acc8= constant 35
 288 acc8=> variable 0
 289 ;test1.j(78)     while (33 <= b) { println (p); p++; b--; }
 290 acc8= variable 0
 291 acc8Comp constant 33
 292 brlt 301
 293 acc16= variable 6
 294 writeLineAcc16
 295 incr16 variable 6
 296 decr8 variable 0
 297 br 290
 298 ;test1.j(79)     // constant - var
 299 ;test1.j(80)     // byte - integer
 300 ;test1.j(81)     i=37;
 301 acc8= constant 37
 302 acc8=> variable 2
 303 ;test1.j(82)     while (36 <= i) { println (p); p++; i--; }
 304 acc16= variable 2
 305 acc8= constant 36
 306 acc8CompareAcc16
 307 brgt 320
 308 acc16= variable 6
 309 writeLineAcc16
 310 incr16 variable 6
 311 decr16 variable 2
 312 br 304
 313 ;test1.j(83)     // constant - var
 314 ;test1.j(84)     // integer - byte
 315 ;test1.j(85)     // not relevant
 316 ;test1.j(86)   
 317 ;test1.j(87)     // constant - var
 318 ;test1.j(88)     // integer - integer
 319 ;test1.j(89)     while (34 <= i) { println (p); p++; i--; }
 320 acc16= variable 2
 321 acc8= constant 34
 322 acc8CompareAcc16
 323 brgt 366
 324 acc16= variable 6
 325 writeLineAcc16
 326 incr16 variable 6
 327 decr16 variable 2
 328 br 320
 329 ;test1.j(90)   
 330 ;test1.j(91)     /************************/
 331 ;test1.j(92)     // stack8 - constant
 332 ;test1.j(93)     // stack8 - acc
 333 ;test1.j(94)     // stack8 - var
 334 ;test1.j(95)     // stack8 - stack8
 335 ;test1.j(96)     // stack8 - stack16
 336 ;test1.j(97)     //TODO
 337 ;test1.j(98)   
 338 ;test1.j(99)     /************************/
 339 ;test1.j(100)     // stack16 - constant
 340 ;test1.j(101)     // stack16 - acc
 341 ;test1.j(102)     // stack16 - var
 342 ;test1.j(103)     // stack16 - stack8
 343 ;test1.j(104)     // stack16 - stack16
 344 ;test1.j(105)     //TODO
 345 ;test1.j(106)   
 346 ;test1.j(107)     /************************/
 347 ;test1.j(108)     // var - stack16
 348 ;test1.j(109)     // byte - byte
 349 ;test1.j(110)     // byte - integer
 350 ;test1.j(111)     // integer - byte
 351 ;test1.j(112)     // integer - integer
 352 ;test1.j(113)     //TODO
 353 ;test1.j(114)   
 354 ;test1.j(115)     /************************/
 355 ;test1.j(116)     // var - stack8
 356 ;test1.j(117)     // byte - byte
 357 ;test1.j(118)     // byte - integer
 358 ;test1.j(119)     // integer - byte
 359 ;test1.j(120)     // integer - integer
 360 ;test1.j(121)     //TODO
 361 ;test1.j(122)   
 362 ;test1.j(123)     /************************/
 363 ;test1.j(124)     // var - var
 364 ;test1.j(125)     // byte - byte
 365 ;test1.j(126)     b=33;
 366 acc8= constant 33
 367 acc8=> variable 0
 368 ;test1.j(127)     while (b2 <= b) { println (p); p++; b--; }
 369 acc8= variable 1
 370 acc8Comp variable 0
 371 brgt 379
 372 acc16= variable 6
 373 writeLineAcc16
 374 incr16 variable 6
 375 decr8 variable 0
 376 br 369
 377 ;test1.j(128)     // byte - integer
 378 ;test1.j(129)     i = 33;
 379 acc8= constant 33
 380 acc8=> variable 2
 381 ;test1.j(130)     while (b2 <= i) { println (p); p++; i--; }
 382 acc8= variable 1
 383 acc16= variable 2
 384 acc8CompareAcc16
 385 brgt 393
 386 acc16= variable 6
 387 writeLineAcc16
 388 incr16 variable 6
 389 decr16 variable 2
 390 br 382
 391 ;test1.j(131)     // integer - byte
 392 ;test1.j(132)     b=33;
 393 acc8= constant 33
 394 acc8=> variable 0
 395 ;test1.j(133)     i=b2;
 396 acc8= variable 1
 397 acc8=> variable 2
 398 ;test1.j(134)     while (i <= b) { println (p); p++; b--; }
 399 acc16= variable 2
 400 acc8= variable 0
 401 acc16CompareAcc8
 402 brgt 410
 403 acc16= variable 6
 404 writeLineAcc16
 405 incr16 variable 6
 406 decr8 variable 0
 407 br 399
 408 ;test1.j(135)     // integer - integer
 409 ;test1.j(136)     i=33;
 410 acc8= constant 33
 411 acc8=> variable 2
 412 ;test1.j(137)     i2=b2;
 413 acc8= variable 1
 414 acc8=> variable 4
 415 ;test1.j(138)     while (i2 <= i) { println (p); p++; i--; }
 416 acc16= variable 4
 417 acc16Comp variable 2
 418 brgt 429
 419 acc16= variable 6
 420 writeLineAcc16
 421 incr16 variable 6
 422 decr16 variable 2
 423 br 416
 424 ;test1.j(139)   
 425 ;test1.j(140)     /************************/
 426 ;test1.j(141)     // var - acc
 427 ;test1.j(142)     // byte - byte
 428 ;test1.j(143)     b=49;
 429 acc8= constant 49
 430 acc8=> variable 0
 431 ;test1.j(144)     while (b <= 50+0) { println (b); b++; }
 432 acc8= constant 50
 433 acc8+ constant 0
 434 acc8Comp variable 0
 435 brlt 442
 436 acc8= variable 0
 437 writeLineAcc8
 438 incr8 variable 0
 439 br 432
 440 ;test1.j(145)     // byte - integer
 441 ;test1.j(146)     i=52;
 442 acc8= constant 52
 443 acc8=> variable 2
 444 ;test1.j(147)     while (b <= i+0) { println (b); b++; }
 445 acc16= variable 2
 446 acc16+ constant 0
 447 acc8= variable 0
 448 acc8CompareAcc16
 449 brgt 456
 450 acc8= variable 0
 451 writeLineAcc8
 452 incr8 variable 0
 453 br 445
 454 ;test1.j(148)     // integer - byte
 455 ;test1.j(149)     i=b;
 456 acc8= variable 0
 457 acc8=> variable 2
 458 ;test1.j(150)     while (i <= 54+0) { println (i); i++; }
 459 acc8= constant 54
 460 acc8+ constant 0
 461 acc16= variable 2
 462 acc16CompareAcc8
 463 brgt 470
 464 acc16= variable 2
 465 writeLineAcc16
 466 incr16 variable 2
 467 br 459
 468 ;test1.j(151)     // integer - integer
 469 ;test1.j(152)     b=i;
 470 acc16= variable 2
 471 acc16=> variable 0
 472 ;test1.j(153)     i=1098;
 473 acc16= constant 1098
 474 acc16=> variable 2
 475 ;test1.j(154)     while (i <= 1099+0) { println (b); b++; i++; }
 476 acc16= constant 1099
 477 acc16+ constant 0
 478 acc16Comp variable 2
 479 brlt 490
 480 acc8= variable 0
 481 writeLineAcc8
 482 incr8 variable 0
 483 incr16 variable 2
 484 br 476
 485 ;test1.j(155)   
 486 ;test1.j(156)     /************************/
 487 ;test1.j(157)     // var - constant
 488 ;test1.j(158)     // byte - byte
 489 ;test1.j(159)     while (b <= 58) { println (b); b++; }
 490 acc8= variable 0
 491 acc8Comp constant 58
 492 brgt 502
 493 acc8= variable 0
 494 writeLineAcc8
 495 incr8 variable 0
 496 br 490
 497 ;test1.j(160)     // byte - integer
 498 ;test1.j(161)     //not relevant
 499 ;test1.j(162)   
 500 ;test1.j(163)     // integer - byte
 501 ;test1.j(164)     i=b;
 502 acc8= variable 0
 503 acc8=> variable 2
 504 ;test1.j(165)     while (i <= 60) { println (i); i++; }
 505 acc16= variable 2
 506 acc8= constant 60
 507 acc16CompareAcc8
 508 brgt 515
 509 acc16= variable 2
 510 writeLineAcc16
 511 incr16 variable 2
 512 br 505
 513 ;test1.j(166)     // integer - integer
 514 ;test1.j(167)     i2=1090;
 515 acc16= constant 1090
 516 acc16=> variable 4
 517 ;test1.j(168)     while (i2 <= 1091) { println (i); i++; i2++; }
 518 acc16= variable 4
 519 acc16Comp constant 1091
 520 brgt 532
 521 acc16= variable 2
 522 writeLineAcc16
 523 incr16 variable 2
 524 incr16 variable 4
 525 br 518
 526 ;test1.j(169)   
 527 ;test1.j(170)     /************************/
 528 ;test1.j(171)     // acc - stack8
 529 ;test1.j(172)     // byte - byte
 530 ;test1.j(173)     //TODO
 531 ;test1.j(174)     println(63);
 532 acc8= constant 63
 533 writeLineAcc8
 534 ;test1.j(175)     println(64);
 535 acc8= constant 64
 536 writeLineAcc8
 537 ;test1.j(176)     // byte - integer
 538 ;test1.j(177)     //TODO
 539 ;test1.j(178)     println(65);
 540 acc8= constant 65
 541 writeLineAcc8
 542 ;test1.j(179)     println(66);
 543 acc8= constant 66
 544 writeLineAcc8
 545 ;test1.j(180)     // integer - byte
 546 ;test1.j(181)     //TODO
 547 ;test1.j(182)     println(67);
 548 acc8= constant 67
 549 writeLineAcc8
 550 ;test1.j(183)     println(68);
 551 acc8= constant 68
 552 writeLineAcc8
 553 ;test1.j(184)     // integer - integer
 554 ;test1.j(185)     //TODO
 555 ;test1.j(186)     println(69);
 556 acc8= constant 69
 557 writeLineAcc8
 558 ;test1.j(187)     println(70);
 559 acc8= constant 70
 560 writeLineAcc8
 561 ;test1.j(188)   
 562 ;test1.j(189)     /************************/
 563 ;test1.j(190)     // acc - stack16
 564 ;test1.j(191)     // byte - byte
 565 ;test1.j(192)     //TODO
 566 ;test1.j(193)     println(71);
 567 acc8= constant 71
 568 writeLineAcc8
 569 ;test1.j(194)     println(72);
 570 acc8= constant 72
 571 writeLineAcc8
 572 ;test1.j(195)     // byte - integer
 573 ;test1.j(196)     //TODO
 574 ;test1.j(197)     println(73);
 575 acc8= constant 73
 576 writeLineAcc8
 577 ;test1.j(198)     println(74);
 578 acc8= constant 74
 579 writeLineAcc8
 580 ;test1.j(199)     // integer - byte
 581 ;test1.j(200)     //TODO
 582 ;test1.j(201)     println(75);
 583 acc8= constant 75
 584 writeLineAcc8
 585 ;test1.j(202)     println(76);
 586 acc8= constant 76
 587 writeLineAcc8
 588 ;test1.j(203)     // integer - integer
 589 ;test1.j(204)     //TODO
 590 ;test1.j(205)     println(77);
 591 acc8= constant 77
 592 writeLineAcc8
 593 ;test1.j(206)     println(78);
 594 acc8= constant 78
 595 writeLineAcc8
 596 ;test1.j(207)   
 597 ;test1.j(208)     /************************/
 598 ;test1.j(209)     // acc - var
 599 ;test1.j(210)     // byte - byte
 600 ;test1.j(211)     b=79;
 601 acc8= constant 79
 602 acc8=> variable 0
 603 ;test1.j(212)     b2=79;
 604 acc8= constant 79
 605 acc8=> variable 1
 606 ;test1.j(213)     while (78+0 <= b2) { println (b); b++; b2--; }
 607 acc8= constant 78
 608 acc8+ constant 0
 609 acc8Comp variable 1
 610 brgt 620
 611 acc8= variable 0
 612 writeLineAcc8
 613 incr8 variable 0
 614 decr8 variable 1
 615 br 607
 616 ;test1.j(214)     // byte - integer
 617 ;test1.j(215)     i=79;
 618 acc8= constant 79
 619 acc8=> variable 2
 620 ;test1.j(216)     while (78+0 <= i) { println (b); b++; i--; }
 621 acc8= constant 78
 622 acc8+ constant 0
 623 acc16= variable 2
 624 acc8CompareAcc16
 625 brgt 637
 626 acc8= variable 0
 627 writeLineAcc8
 628 incr8 variable 0
 629 decr16 variable 2
 630 br 623
 631 ;test1.j(217)     // integer - byte
 632 ;test1.j(218)     i=78;
 633 acc8= constant 78
 634 acc8=> variable 2
 635 ;test1.j(219)     b2=79;
 636 acc8= constant 79
 637 acc8=> variable 1
 638 ;test1.j(220)     while (i+0 <= b2) { println (b); b++; b2--; } 
 639 acc16= variable 2
 640 acc16+ constant 0
 641 acc8= variable 1
 642 acc16CompareAcc8
 643 brgt 657
 644 acc8= variable 0
 645 writeLineAcc8
 646 incr8 variable 0
 647 decr8 variable 1
 648 br 643
 649 ;test1.j(221)     // integer - integer
 650 ;test1.j(222)     i=1066;
 651 acc16= constant 1066
 652 acc16=> variable 2
 653 ;test1.j(223)     while (1000+65 <= i) { println (b); b++; i--; }
 654 acc16= constant 1000
 655 acc16+ constant 65
 656 acc16Comp variable 2
 657 brgt 676
 658 acc8= variable 0
 659 writeLineAcc8
 660 incr8 variable 0
 661 decr16 variable 2
 662 br 660
 663 ;test1.j(224)   
 664 ;test1.j(225)     /************************/
 665 ;test1.j(226)     // acc - acc
 666 ;test1.j(227)     // byte - byte
 667 ;test1.j(228)     b=87;
 668 acc8= constant 87
 669 acc8=> variable 0
 670 ;test1.j(229)     b2=64;
 671 acc8= constant 64
 672 acc8=> variable 1
 673 ;test1.j(230)     while (63+0 <= b2+0) { println (b); b++; b2--; }
 674 acc8= constant 63
 675 acc8+ constant 0
 676 <acc8
 677 acc8= variable 1
 678 acc8+ constant 0
 679 revAcc8Comp unstack8
 680 brlt 696
 681 acc8= variable 0
 682 writeLineAcc8
 683 incr8 variable 0
 684 decr8 variable 1
 685 br 682
 686 ;test1.j(231)     // byte - integer
 687 ;test1.j(232)     i=62;
 688 acc8= constant 62
 689 acc8=> variable 2
 690 ;test1.j(233)     while (61+0 <= i+0) { println (b); b++; i--; }
 691 acc8= constant 61
 692 acc8+ constant 0
 693 <acc8
 694 acc16= variable 2
 695 acc16+ constant 0
 696 acc8<
 697 acc8CompareAcc16
 698 brgt 714
 699 acc8= variable 0
 700 writeLineAcc8
 701 incr8 variable 0
 702 decr16 variable 2
 703 br 699
 704 ;test1.j(234)     // integer - byte
 705 ;test1.j(235)     i=59;
 706 acc8= constant 59
 707 acc8=> variable 2
 708 ;test1.j(236)     b2=60;
 709 acc8= constant 60
 710 acc8=> variable 1
 711 ;test1.j(237)     while (i+0 <= b2+0) { println (b); b++; b2--; }
 712 acc16= variable 2
 713 acc16+ constant 0
 714 <acc16
 715 acc8= variable 1
 716 acc8+ constant 0
 717 acc16<
 718 acc16CompareAcc8
 719 brgt 735
 720 acc8= variable 0
 721 writeLineAcc8
 722 incr8 variable 0
 723 decr8 variable 1
 724 br 720
 725 ;test1.j(238)     // integer - integer
 726 ;test1.j(239)     i=1058;
 727 acc16= constant 1058
 728 acc16=> variable 2
 729 ;test1.j(240)     while (1000+57 <= i+0) { println (b); b++; i--; }
 730 acc16= constant 1000
 731 acc16+ constant 57
 732 <acc16
 733 acc16= variable 2
 734 acc16+ constant 0
 735 revAcc16Comp unstack16
 736 brlt 755
 737 acc8= variable 0
 738 writeLineAcc8
 739 incr8 variable 0
 740 decr16 variable 2
 741 br 738
 742 ;test1.j(241)   
 743 ;test1.j(242)     /************************/
 744 ;test1.j(243)     // acc - constant
 745 ;test1.j(244)     // byte - byte
 746 ;test1.j(245)     while (b+0 <= 96) { println (b); b++; }
 747 acc8= variable 0
 748 acc8+ constant 0
 749 acc8Comp constant 96
 750 brgt 769
 751 acc8= variable 0
 752 writeLineAcc8
 753 incr8 variable 0
 754 br 755
 755 ;test1.j(246)     // byte - integer
 756 ;test1.j(247)     //not relevant
 757 ;test1.j(248)     // integer - byte
 758 ;test1.j(249)     i=b;
 759 acc8= variable 0
 760 acc8=> variable 2
 761 ;test1.j(250)     while (i+0 <= 98) { println (i); i++; }
 762 acc16= variable 2
 763 acc16+ constant 0
 764 acc8= constant 98
 765 acc16CompareAcc8
 766 brgt 784
 767 acc16= variable 2
 768 writeLineAcc16
 769 incr16 variable 2
 770 br 772
 771 ;test1.j(251)     b=i;
 772 acc16= variable 2
 773 acc16=> variable 0
 774 ;test1.j(252)     i=1052;
 775 acc16= constant 1052
 776 acc16=> variable 2
 777 ;test1.j(253)     // integer - integer
 778 ;test1.j(254)     while (i+0 <= 1053) { println (b); b++; i++; }
 779 acc16= variable 2
 780 acc16+ constant 0
 781 acc16Comp constant 1053
 782 brgt 808
 783 acc8= variable 0
 784 writeLineAcc8
 785 incr8 variable 0
 786 incr16 variable 2
 787 br 791
 788 ;test1.j(255)   
 789 ;test1.j(256)     /************************/
 790 ;test1.j(257)     // constant - stack8
 791 ;test1.j(258)     // byte - byte
 792 ;test1.j(259)     //TODO
 793 ;test1.j(260)     println(101);
 794 acc8= constant 101
 795 writeLineAcc8
 796 ;test1.j(261)     println(102);
 797 acc8= constant 102
 798 writeLineAcc8
 799 ;test1.j(262)     // constant - stack8
 800 ;test1.j(263)     // byte - integer
 801 ;test1.j(264)     //TODO
 802 ;test1.j(265)     println(103);
 803 acc8= constant 103
 804 writeLineAcc8
 805 ;test1.j(266)     println(104);
 806 acc8= constant 104
 807 writeLineAcc8
 808 ;test1.j(267)     // constant - stack8
 809 ;test1.j(268)     // integer - byte
 810 ;test1.j(269)     //TODO
 811 ;test1.j(270)     println(105);
 812 acc8= constant 105
 813 writeLineAcc8
 814 ;test1.j(271)     println(106);
 815 acc8= constant 106
 816 writeLineAcc8
 817 ;test1.j(272)     // constant - stack88
 818 ;test1.j(273)     // integer - integer
 819 ;test1.j(274)     //TODO
 820 ;test1.j(275)     println(107);
 821 acc8= constant 107
 822 writeLineAcc8
 823 ;test1.j(276)     println(108);
 824 acc8= constant 108
 825 writeLineAcc8
 826 ;test1.j(277)   
 827 ;test1.j(278)     /************************/
 828 ;test1.j(279)     // constant - stack16
 829 ;test1.j(280)     // byte - byte
 830 ;test1.j(281)     //TODO
 831 ;test1.j(282)     println(109);
 832 acc8= constant 109
 833 writeLineAcc8
 834 ;test1.j(283)     println(110);
 835 acc8= constant 110
 836 writeLineAcc8
 837 ;test1.j(284)     // constant - stack16
 838 ;test1.j(285)     // byte - integer
 839 ;test1.j(286)     //TODO
 840 ;test1.j(287)     println(111);
 841 acc8= constant 111
 842 writeLineAcc8
 843 ;test1.j(288)     println(112);
 844 acc8= constant 112
 845 writeLineAcc8
 846 ;test1.j(289)     // constant - stack16
 847 ;test1.j(290)     // integer - byte
 848 ;test1.j(291)     //TODO
 849 ;test1.j(292)     println(113);
 850 acc8= constant 113
 851 writeLineAcc8
 852 ;test1.j(293)     println(114);
 853 acc8= constant 114
 854 writeLineAcc8
 855 ;test1.j(294)     // constant - stack16
 856 ;test1.j(295)     // integer - integer
 857 ;test1.j(296)     //TODO
 858 ;test1.j(297)     println(115);
 859 acc8= constant 115
 860 writeLineAcc8
 861 ;test1.j(298)     println(116);
 862 acc8= constant 116
 863 writeLineAcc8
 864 ;test1.j(299)   
 865 ;test1.j(300)     println("Klaar");
 866 acc16= stringconstant 873
 867 writeLineString
 868 stackPointer= basePointer
 869 basePointer<
 870 return
 871 ;test1.j(301)   }
 872 ;test1.j(302) }
 873 stringConstant 0 = "Klaar"
