   0 call 22
   1 stop
   2 ;testWhile.j(0) /* Program to test generated Z80 assembler code */
   3 ;testWhile.j(1) class TestWhile {
   4 class TestWhile []
   5 ;testWhile.j(2)   private static byte b = 0;
   6 acc8= constant 0
   7 acc8=> variable 0
   8 ;testWhile.j(3)   private static byte b2 = 32;
   9 acc8= constant 32
  10 acc8=> variable 1
  11 ;testWhile.j(4)   private static word i = 110;
  12 acc8= constant 110
  13 acc8=> variable 2
  14 ;testWhile.j(5)   private static word i2 = 105;
  15 acc8= constant 105
  16 acc8=> variable 4
  17 ;testWhile.j(6)   private static word p = 12;
  18 acc8= constant 12
  19 acc8=> variable 6
  20 ;testWhile.j(7) 
  21 ;testWhile.j(8)   public static void main() {
  22 method TestWhile.main [public, static] void ()
  23 <basePointer
  24 basePointer= stackPointer
  25 stackPointer+ constant 4
  26 ;testWhile.j(9)     /*Possible operand types: 
  27 ;testWhile.j(10)      * constant, acc, var, stack8, stack16
  28 ;testWhile.j(11)      *Possible datatype combinations:
  29 ;testWhile.j(12)      * byte - byte
  30 ;testWhile.j(13)      * byte - integer
  31 ;testWhile.j(14)      * integer - byte
  32 ;testWhile.j(15)      * integer - integer
  33 ;testWhile.j(16)     */
  34 ;testWhile.j(17)   
  35 ;testWhile.j(18)     println(0);
  36 acc8= constant 0
  37 writeLineAcc8
  38 ;testWhile.j(19)   
  39 ;testWhile.j(20)     /************************/
  40 ;testWhile.j(21)     // global variable within while scope
  41 ;testWhile.j(22)     b++;
  42 incr8 variable 0
  43 ;testWhile.j(23)     println (b);
  44 acc8= variable 0
  45 writeLineAcc8
  46 ;testWhile.j(24)     while (b < 2) {
  47 acc8= variable 0
  48 acc8Comp constant 2
  49 brge 75
  50 ;testWhile.j(25)       b++;
  51 incr8 variable 0
  52 ;testWhile.j(26)       word j = 1001;
  53 acc16= constant 1001
  54 acc16=> (basePointer + -2)
  55 ;testWhile.j(27)       byte c = b;
  56 acc8= variable 0
  57 acc8=> (basePointer + -3)
  58 ;testWhile.j(28)       byte d = c;
  59 acc8= (basePointer + -3)
  60 acc8=> (basePointer + -4)
  61 ;testWhile.j(29)       println (c);
  62 acc8= (basePointer + -3)
  63 writeLineAcc8
  64 ;testWhile.j(30)     }
  65 br 47
  66 ;testWhile.j(31)   
  67 ;testWhile.j(32)     /************************/
  68 ;testWhile.j(33)     // constant - constant
  69 ;testWhile.j(34)     // not relevant
  70 ;testWhile.j(35)   
  71 ;testWhile.j(36)     /************************/
  72 ;testWhile.j(37)     // constant - acc
  73 ;testWhile.j(38)     // byte - byte
  74 ;testWhile.j(39)     b = 3;
  75 acc8= constant 3
  76 acc8=> variable 0
  77 ;testWhile.j(40)     while (3 == b+0) { println (b); b++; }
  78 acc8= variable 0
  79 acc8+ constant 0
  80 acc8Comp constant 3
  81 brne 87
  82 acc8= variable 0
  83 writeLineAcc8
  84 incr8 variable 0
  85 br 78
  86 ;testWhile.j(41)     while (4 != b+0) { println (b); b++; }
  87 acc8= variable 0
  88 acc8+ constant 0
  89 acc8Comp constant 4
  90 breq 96
  91 acc8= variable 0
  92 writeLineAcc8
  93 incr8 variable 0
  94 br 87
  95 ;testWhile.j(42)     while (6 > b+0) { println (b); b++; }
  96 acc8= variable 0
  97 acc8+ constant 0
  98 acc8Comp constant 6
  99 brge 105
 100 acc8= variable 0
 101 writeLineAcc8
 102 incr8 variable 0
 103 br 96
 104 ;testWhile.j(43)     while (7 >= b+0) { println (b); b++; }
 105 acc8= variable 0
 106 acc8+ constant 0
 107 acc8Comp constant 7
 108 brgt 114
 109 acc8= variable 0
 110 writeLineAcc8
 111 incr8 variable 0
 112 br 105
 113 ;testWhile.j(44)     p=8;
 114 acc8= constant 8
 115 acc8=> variable 6
 116 ;testWhile.j(45)     while (6 <  b+0) { println (p); p++; b--; }
 117 acc8= variable 0
 118 acc8+ constant 0
 119 acc8Comp constant 6
 120 brle 127
 121 acc16= variable 6
 122 writeLineAcc16
 123 incr16 variable 6
 124 decr8 variable 0
 125 br 117
 126 ;testWhile.j(46)     while (5 <= b+0) { println (p); p++; b--; }
 127 acc8= variable 0
 128 acc8+ constant 0
 129 acc8Comp constant 5
 130 brlt 140
 131 acc16= variable 6
 132 writeLineAcc16
 133 incr16 variable 6
 134 decr8 variable 0
 135 br 127
 136 ;testWhile.j(47)     
 137 ;testWhile.j(48)     // constant - acc
 138 ;testWhile.j(49)     // byte - integer
 139 ;testWhile.j(50)     i=12;
 140 acc8= constant 12
 141 acc8=> variable 2
 142 ;testWhile.j(51)     while (12 == i+0) { println (i); i++; }
 143 acc16= variable 2
 144 acc16+ constant 0
 145 acc8= constant 12
 146 acc8CompareAcc16
 147 brne 153
 148 acc16= variable 2
 149 writeLineAcc16
 150 incr16 variable 2
 151 br 143
 152 ;testWhile.j(52)     while (15 != i+0) { println (i); i++; }
 153 acc16= variable 2
 154 acc16+ constant 0
 155 acc8= constant 15
 156 acc8CompareAcc16
 157 breq 163
 158 acc16= variable 2
 159 writeLineAcc16
 160 incr16 variable 2
 161 br 153
 162 ;testWhile.j(53)     while (17 > i+0) { println (i); i++; }
 163 acc16= variable 2
 164 acc16+ constant 0
 165 acc8= constant 17
 166 acc8CompareAcc16
 167 brle 173
 168 acc16= variable 2
 169 writeLineAcc16
 170 incr16 variable 2
 171 br 163
 172 ;testWhile.j(54)     while (18 >= i+0) { println (i); i++; }
 173 acc16= variable 2
 174 acc16+ constant 0
 175 acc8= constant 18
 176 acc8CompareAcc16
 177 brlt 183
 178 acc16= variable 2
 179 writeLineAcc16
 180 incr16 variable 2
 181 br 173
 182 ;testWhile.j(55)     p=i;
 183 acc16= variable 2
 184 acc16=> variable 6
 185 ;testWhile.j(56)     while (17 <  i+0) { println (p); i--; p++; }
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
 196 ;testWhile.j(57)     while (16 <= i+0) { println (p); i--; p++; }
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
 207 ;testWhile.j(58)   
 208 ;testWhile.j(59)     // constant - acc
 209 ;testWhile.j(60)     // integer - byte
 210 ;testWhile.j(61)     // not relevant
 211 ;testWhile.j(62)   
 212 ;testWhile.j(63)     // constant - acc
 213 ;testWhile.j(64)     // integer - integer
 214 ;testWhile.j(65)     i=23;
 215 acc8= constant 23
 216 acc8=> variable 2
 217 ;testWhile.j(66)     while (23 == i+0) { println (i); i++; }
 218 acc16= variable 2
 219 acc16+ constant 0
 220 acc8= constant 23
 221 acc8CompareAcc16
 222 brne 228
 223 acc16= variable 2
 224 writeLineAcc16
 225 incr16 variable 2
 226 br 218
 227 ;testWhile.j(67)     while (26 != i+0) { println (i); i++; }
 228 acc16= variable 2
 229 acc16+ constant 0
 230 acc8= constant 26
 231 acc8CompareAcc16
 232 breq 238
 233 acc16= variable 2
 234 writeLineAcc16
 235 incr16 variable 2
 236 br 228
 237 ;testWhile.j(68)     while (28 > i+0) { println (i); i++; }
 238 acc16= variable 2
 239 acc16+ constant 0
 240 acc8= constant 28
 241 acc8CompareAcc16
 242 brle 248
 243 acc16= variable 2
 244 writeLineAcc16
 245 incr16 variable 2
 246 br 238
 247 ;testWhile.j(69)     while (29 >= i+0) { println (i); i++; }
 248 acc16= variable 2
 249 acc16+ constant 0
 250 acc8= constant 29
 251 acc8CompareAcc16
 252 brlt 258
 253 acc16= variable 2
 254 writeLineAcc16
 255 incr16 variable 2
 256 br 248
 257 ;testWhile.j(70)     p=i;
 258 acc16= variable 2
 259 acc16=> variable 6
 260 ;testWhile.j(71)     while (28 <  i+0) { println (p); p++; i--; }
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
 271 ;testWhile.j(72)     while (27 <= i+0) { println (p); p++; i--; }
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
 282 ;testWhile.j(73)   
 283 ;testWhile.j(74)     /************************/
 284 ;testWhile.j(75)     // constant - var
 285 ;testWhile.j(76)     // byte - byte
 286 ;testWhile.j(77)     b=35;
 287 acc8= constant 35
 288 acc8=> variable 0
 289 ;testWhile.j(78)     while (33 <= b) { println (p); p++; b--; }
 290 acc8= variable 0
 291 acc8Comp constant 33
 292 brlt 301
 293 acc16= variable 6
 294 writeLineAcc16
 295 incr16 variable 6
 296 decr8 variable 0
 297 br 290
 298 ;testWhile.j(79)     // constant - var
 299 ;testWhile.j(80)     // byte - integer
 300 ;testWhile.j(81)     i=37;
 301 acc8= constant 37
 302 acc8=> variable 2
 303 ;testWhile.j(82)     while (36 <= i) { println (p); p++; i--; }
 304 acc16= variable 2
 305 acc8= constant 36
 306 acc8CompareAcc16
 307 brgt 320
 308 acc16= variable 6
 309 writeLineAcc16
 310 incr16 variable 6
 311 decr16 variable 2
 312 br 304
 313 ;testWhile.j(83)     // constant - var
 314 ;testWhile.j(84)     // integer - byte
 315 ;testWhile.j(85)     // not relevant
 316 ;testWhile.j(86)   
 317 ;testWhile.j(87)     // constant - var
 318 ;testWhile.j(88)     // integer - integer
 319 ;testWhile.j(89)     while (34 <= i) { println (p); p++; i--; }
 320 acc16= variable 2
 321 acc8= constant 34
 322 acc8CompareAcc16
 323 brgt 366
 324 acc16= variable 6
 325 writeLineAcc16
 326 incr16 variable 6
 327 decr16 variable 2
 328 br 320
 329 ;testWhile.j(90)   
 330 ;testWhile.j(91)     /************************/
 331 ;testWhile.j(92)     // stack8 - constant
 332 ;testWhile.j(93)     // stack8 - acc
 333 ;testWhile.j(94)     // stack8 - var
 334 ;testWhile.j(95)     // stack8 - stack8
 335 ;testWhile.j(96)     // stack8 - stack16
 336 ;testWhile.j(97)     //TODO
 337 ;testWhile.j(98)   
 338 ;testWhile.j(99)     /************************/
 339 ;testWhile.j(100)     // stack16 - constant
 340 ;testWhile.j(101)     // stack16 - acc
 341 ;testWhile.j(102)     // stack16 - var
 342 ;testWhile.j(103)     // stack16 - stack8
 343 ;testWhile.j(104)     // stack16 - stack16
 344 ;testWhile.j(105)     //TODO
 345 ;testWhile.j(106)   
 346 ;testWhile.j(107)     /************************/
 347 ;testWhile.j(108)     // var - stack16
 348 ;testWhile.j(109)     // byte - byte
 349 ;testWhile.j(110)     // byte - integer
 350 ;testWhile.j(111)     // integer - byte
 351 ;testWhile.j(112)     // integer - integer
 352 ;testWhile.j(113)     //TODO
 353 ;testWhile.j(114)   
 354 ;testWhile.j(115)     /************************/
 355 ;testWhile.j(116)     // var - stack8
 356 ;testWhile.j(117)     // byte - byte
 357 ;testWhile.j(118)     // byte - integer
 358 ;testWhile.j(119)     // integer - byte
 359 ;testWhile.j(120)     // integer - integer
 360 ;testWhile.j(121)     //TODO
 361 ;testWhile.j(122)   
 362 ;testWhile.j(123)     /************************/
 363 ;testWhile.j(124)     // var - var
 364 ;testWhile.j(125)     // byte - byte
 365 ;testWhile.j(126)     b=33;
 366 acc8= constant 33
 367 acc8=> variable 0
 368 ;testWhile.j(127)     while (b2 <= b) { println (p); p++; b--; }
 369 acc8= variable 1
 370 acc8Comp variable 0
 371 brgt 379
 372 acc16= variable 6
 373 writeLineAcc16
 374 incr16 variable 6
 375 decr8 variable 0
 376 br 369
 377 ;testWhile.j(128)     // byte - integer
 378 ;testWhile.j(129)     i = 33;
 379 acc8= constant 33
 380 acc8=> variable 2
 381 ;testWhile.j(130)     while (b2 <= i) { println (p); p++; i--; }
 382 acc8= variable 1
 383 acc16= variable 2
 384 acc8CompareAcc16
 385 brgt 393
 386 acc16= variable 6
 387 writeLineAcc16
 388 incr16 variable 6
 389 decr16 variable 2
 390 br 382
 391 ;testWhile.j(131)     // integer - byte
 392 ;testWhile.j(132)     b=33;
 393 acc8= constant 33
 394 acc8=> variable 0
 395 ;testWhile.j(133)     i=b2;
 396 acc8= variable 1
 397 acc8=> variable 2
 398 ;testWhile.j(134)     while (i <= b) { println (p); p++; b--; }
 399 acc16= variable 2
 400 acc8= variable 0
 401 acc16CompareAcc8
 402 brgt 410
 403 acc16= variable 6
 404 writeLineAcc16
 405 incr16 variable 6
 406 decr8 variable 0
 407 br 399
 408 ;testWhile.j(135)     // integer - integer
 409 ;testWhile.j(136)     i=33;
 410 acc8= constant 33
 411 acc8=> variable 2
 412 ;testWhile.j(137)     i2=b2;
 413 acc8= variable 1
 414 acc8=> variable 4
 415 ;testWhile.j(138)     while (i2 <= i) { println (p); p++; i--; }
 416 acc16= variable 4
 417 acc16Comp variable 2
 418 brgt 429
 419 acc16= variable 6
 420 writeLineAcc16
 421 incr16 variable 6
 422 decr16 variable 2
 423 br 416
 424 ;testWhile.j(139)   
 425 ;testWhile.j(140)     /************************/
 426 ;testWhile.j(141)     // var - acc
 427 ;testWhile.j(142)     // byte - byte
 428 ;testWhile.j(143)     b=49;
 429 acc8= constant 49
 430 acc8=> variable 0
 431 ;testWhile.j(144)     while (b <= 50+0) { println (b); b++; }
 432 acc8= constant 50
 433 acc8+ constant 0
 434 acc8Comp variable 0
 435 brlt 442
 436 acc8= variable 0
 437 writeLineAcc8
 438 incr8 variable 0
 439 br 432
 440 ;testWhile.j(145)     // byte - integer
 441 ;testWhile.j(146)     i=52;
 442 acc8= constant 52
 443 acc8=> variable 2
 444 ;testWhile.j(147)     while (b <= i+0) { println (b); b++; }
 445 acc16= variable 2
 446 acc16+ constant 0
 447 acc8= variable 0
 448 acc8CompareAcc16
 449 brgt 456
 450 acc8= variable 0
 451 writeLineAcc8
 452 incr8 variable 0
 453 br 445
 454 ;testWhile.j(148)     // integer - byte
 455 ;testWhile.j(149)     i=b;
 456 acc8= variable 0
 457 acc8=> variable 2
 458 ;testWhile.j(150)     while (i <= 54+0) { println (i); i++; }
 459 acc8= constant 54
 460 acc8+ constant 0
 461 acc16= variable 2
 462 acc16CompareAcc8
 463 brgt 470
 464 acc16= variable 2
 465 writeLineAcc16
 466 incr16 variable 2
 467 br 459
 468 ;testWhile.j(151)     // integer - integer
 469 ;testWhile.j(152)     b=i;
 470 acc16= variable 2
 471 acc16=> variable 0
 472 ;testWhile.j(153)     i=1098;
 473 acc16= constant 1098
 474 acc16=> variable 2
 475 ;testWhile.j(154)     while (i <= 1099+0) { println (b); b++; i++; }
 476 acc16= constant 1099
 477 acc16+ constant 0
 478 acc16Comp variable 2
 479 brlt 490
 480 acc8= variable 0
 481 writeLineAcc8
 482 incr8 variable 0
 483 incr16 variable 2
 484 br 476
 485 ;testWhile.j(155)   
 486 ;testWhile.j(156)     /************************/
 487 ;testWhile.j(157)     // var - constant
 488 ;testWhile.j(158)     // byte - byte
 489 ;testWhile.j(159)     while (b <= 58) { println (b); b++; }
 490 acc8= variable 0
 491 acc8Comp constant 58
 492 brgt 502
 493 acc8= variable 0
 494 writeLineAcc8
 495 incr8 variable 0
 496 br 490
 497 ;testWhile.j(160)     // byte - integer
 498 ;testWhile.j(161)     //not relevant
 499 ;testWhile.j(162)   
 500 ;testWhile.j(163)     // integer - byte
 501 ;testWhile.j(164)     i=b;
 502 acc8= variable 0
 503 acc8=> variable 2
 504 ;testWhile.j(165)     while (i <= 60) { println (i); i++; }
 505 acc16= variable 2
 506 acc8= constant 60
 507 acc16CompareAcc8
 508 brgt 515
 509 acc16= variable 2
 510 writeLineAcc16
 511 incr16 variable 2
 512 br 505
 513 ;testWhile.j(166)     // integer - integer
 514 ;testWhile.j(167)     i2=1090;
 515 acc16= constant 1090
 516 acc16=> variable 4
 517 ;testWhile.j(168)     while (i2 <= 1091) { println (i); i++; i2++; }
 518 acc16= variable 4
 519 acc16Comp constant 1091
 520 brgt 532
 521 acc16= variable 2
 522 writeLineAcc16
 523 incr16 variable 2
 524 incr16 variable 4
 525 br 518
 526 ;testWhile.j(169)   
 527 ;testWhile.j(170)     /************************/
 528 ;testWhile.j(171)     // acc - stack8
 529 ;testWhile.j(172)     // byte - byte
 530 ;testWhile.j(173)     //TODO
 531 ;testWhile.j(174)     println(63);
 532 acc8= constant 63
 533 writeLineAcc8
 534 ;testWhile.j(175)     println(64);
 535 acc8= constant 64
 536 writeLineAcc8
 537 ;testWhile.j(176)     // byte - integer
 538 ;testWhile.j(177)     //TODO
 539 ;testWhile.j(178)     println(65);
 540 acc8= constant 65
 541 writeLineAcc8
 542 ;testWhile.j(179)     println(66);
 543 acc8= constant 66
 544 writeLineAcc8
 545 ;testWhile.j(180)     // integer - byte
 546 ;testWhile.j(181)     //TODO
 547 ;testWhile.j(182)     println(67);
 548 acc8= constant 67
 549 writeLineAcc8
 550 ;testWhile.j(183)     println(68);
 551 acc8= constant 68
 552 writeLineAcc8
 553 ;testWhile.j(184)     // integer - integer
 554 ;testWhile.j(185)     //TODO
 555 ;testWhile.j(186)     println(69);
 556 acc8= constant 69
 557 writeLineAcc8
 558 ;testWhile.j(187)     println(70);
 559 acc8= constant 70
 560 writeLineAcc8
 561 ;testWhile.j(188)   
 562 ;testWhile.j(189)     /************************/
 563 ;testWhile.j(190)     // acc - stack16
 564 ;testWhile.j(191)     // byte - byte
 565 ;testWhile.j(192)     //TODO
 566 ;testWhile.j(193)     println(71);
 567 acc8= constant 71
 568 writeLineAcc8
 569 ;testWhile.j(194)     println(72);
 570 acc8= constant 72
 571 writeLineAcc8
 572 ;testWhile.j(195)     // byte - integer
 573 ;testWhile.j(196)     //TODO
 574 ;testWhile.j(197)     println(73);
 575 acc8= constant 73
 576 writeLineAcc8
 577 ;testWhile.j(198)     println(74);
 578 acc8= constant 74
 579 writeLineAcc8
 580 ;testWhile.j(199)     // integer - byte
 581 ;testWhile.j(200)     //TODO
 582 ;testWhile.j(201)     println(75);
 583 acc8= constant 75
 584 writeLineAcc8
 585 ;testWhile.j(202)     println(76);
 586 acc8= constant 76
 587 writeLineAcc8
 588 ;testWhile.j(203)     // integer - integer
 589 ;testWhile.j(204)     //TODO
 590 ;testWhile.j(205)     println(77);
 591 acc8= constant 77
 592 writeLineAcc8
 593 ;testWhile.j(206)     println(78);
 594 acc8= constant 78
 595 writeLineAcc8
 596 ;testWhile.j(207)   
 597 ;testWhile.j(208)     /************************/
 598 ;testWhile.j(209)     // acc - var
 599 ;testWhile.j(210)     // byte - byte
 600 ;testWhile.j(211)     b=79;
 601 acc8= constant 79
 602 acc8=> variable 0
 603 ;testWhile.j(212)     b2=79;
 604 acc8= constant 79
 605 acc8=> variable 1
 606 ;testWhile.j(213)     while (78+0 <= b2) { println (b); b++; b2--; }
 607 acc8= constant 78
 608 acc8+ constant 0
 609 acc8Comp variable 1
 610 brgt 620
 611 acc8= variable 0
 612 writeLineAcc8
 613 incr8 variable 0
 614 decr8 variable 1
 615 br 607
 616 ;testWhile.j(214)     // byte - integer
 617 ;testWhile.j(215)     i=79;
 618 acc8= constant 79
 619 acc8=> variable 2
 620 ;testWhile.j(216)     while (78+0 <= i) { println (b); b++; i--; }
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
 631 ;testWhile.j(217)     // integer - byte
 632 ;testWhile.j(218)     i=78;
 633 acc8= constant 78
 634 acc8=> variable 2
 635 ;testWhile.j(219)     b2=79;
 636 acc8= constant 79
 637 acc8=> variable 1
 638 ;testWhile.j(220)     while (i+0 <= b2) { println (b); b++; b2--; } 
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
 649 ;testWhile.j(221)     // integer - integer
 650 ;testWhile.j(222)     i=1066;
 651 acc16= constant 1066
 652 acc16=> variable 2
 653 ;testWhile.j(223)     while (1000+65 <= i) { println (b); b++; i--; }
 654 acc16= constant 1000
 655 acc16+ constant 65
 656 acc16Comp variable 2
 657 brgt 676
 658 acc8= variable 0
 659 writeLineAcc8
 660 incr8 variable 0
 661 decr16 variable 2
 662 br 660
 663 ;testWhile.j(224)   
 664 ;testWhile.j(225)     /************************/
 665 ;testWhile.j(226)     // acc - acc
 666 ;testWhile.j(227)     // byte - byte
 667 ;testWhile.j(228)     b=87;
 668 acc8= constant 87
 669 acc8=> variable 0
 670 ;testWhile.j(229)     b2=64;
 671 acc8= constant 64
 672 acc8=> variable 1
 673 ;testWhile.j(230)     while (63+0 <= b2+0) { println (b); b++; b2--; }
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
 686 ;testWhile.j(231)     // byte - integer
 687 ;testWhile.j(232)     i=62;
 688 acc8= constant 62
 689 acc8=> variable 2
 690 ;testWhile.j(233)     while (61+0 <= i+0) { println (b); b++; i--; }
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
 704 ;testWhile.j(234)     // integer - byte
 705 ;testWhile.j(235)     i=59;
 706 acc8= constant 59
 707 acc8=> variable 2
 708 ;testWhile.j(236)     b2=60;
 709 acc8= constant 60
 710 acc8=> variable 1
 711 ;testWhile.j(237)     while (i+0 <= b2+0) { println (b); b++; b2--; }
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
 725 ;testWhile.j(238)     // integer - integer
 726 ;testWhile.j(239)     i=1058;
 727 acc16= constant 1058
 728 acc16=> variable 2
 729 ;testWhile.j(240)     while (1000+57 <= i+0) { println (b); b++; i--; }
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
 742 ;testWhile.j(241)   
 743 ;testWhile.j(242)     /************************/
 744 ;testWhile.j(243)     // acc - constant
 745 ;testWhile.j(244)     // byte - byte
 746 ;testWhile.j(245)     while (b+0 <= 96) { println (b); b++; }
 747 acc8= variable 0
 748 acc8+ constant 0
 749 acc8Comp constant 96
 750 brgt 769
 751 acc8= variable 0
 752 writeLineAcc8
 753 incr8 variable 0
 754 br 755
 755 ;testWhile.j(246)     // byte - integer
 756 ;testWhile.j(247)     //not relevant
 757 ;testWhile.j(248)     // integer - byte
 758 ;testWhile.j(249)     i=b;
 759 acc8= variable 0
 760 acc8=> variable 2
 761 ;testWhile.j(250)     while (i+0 <= 98) { println (i); i++; }
 762 acc16= variable 2
 763 acc16+ constant 0
 764 acc8= constant 98
 765 acc16CompareAcc8
 766 brgt 784
 767 acc16= variable 2
 768 writeLineAcc16
 769 incr16 variable 2
 770 br 772
 771 ;testWhile.j(251)     b=i;
 772 acc16= variable 2
 773 acc16=> variable 0
 774 ;testWhile.j(252)     i=1052;
 775 acc16= constant 1052
 776 acc16=> variable 2
 777 ;testWhile.j(253)     // integer - integer
 778 ;testWhile.j(254)     while (i+0 <= 1053) { println (b); b++; i++; }
 779 acc16= variable 2
 780 acc16+ constant 0
 781 acc16Comp constant 1053
 782 brgt 808
 783 acc8= variable 0
 784 writeLineAcc8
 785 incr8 variable 0
 786 incr16 variable 2
 787 br 791
 788 ;testWhile.j(255)   
 789 ;testWhile.j(256)     /************************/
 790 ;testWhile.j(257)     // constant - stack8
 791 ;testWhile.j(258)     // byte - byte
 792 ;testWhile.j(259)     //TODO
 793 ;testWhile.j(260)     println(101);
 794 acc8= constant 101
 795 writeLineAcc8
 796 ;testWhile.j(261)     println(102);
 797 acc8= constant 102
 798 writeLineAcc8
 799 ;testWhile.j(262)     // constant - stack8
 800 ;testWhile.j(263)     // byte - integer
 801 ;testWhile.j(264)     //TODO
 802 ;testWhile.j(265)     println(103);
 803 acc8= constant 103
 804 writeLineAcc8
 805 ;testWhile.j(266)     println(104);
 806 acc8= constant 104
 807 writeLineAcc8
 808 ;testWhile.j(267)     // constant - stack8
 809 ;testWhile.j(268)     // integer - byte
 810 ;testWhile.j(269)     //TODO
 811 ;testWhile.j(270)     println(105);
 812 acc8= constant 105
 813 writeLineAcc8
 814 ;testWhile.j(271)     println(106);
 815 acc8= constant 106
 816 writeLineAcc8
 817 ;testWhile.j(272)     // constant - stack88
 818 ;testWhile.j(273)     // integer - integer
 819 ;testWhile.j(274)     //TODO
 820 ;testWhile.j(275)     println(107);
 821 acc8= constant 107
 822 writeLineAcc8
 823 ;testWhile.j(276)     println(108);
 824 acc8= constant 108
 825 writeLineAcc8
 826 ;testWhile.j(277)   
 827 ;testWhile.j(278)     /************************/
 828 ;testWhile.j(279)     // constant - stack16
 829 ;testWhile.j(280)     // byte - byte
 830 ;testWhile.j(281)     //TODO
 831 ;testWhile.j(282)     println(109);
 832 acc8= constant 109
 833 writeLineAcc8
 834 ;testWhile.j(283)     println(110);
 835 acc8= constant 110
 836 writeLineAcc8
 837 ;testWhile.j(284)     // constant - stack16
 838 ;testWhile.j(285)     // byte - integer
 839 ;testWhile.j(286)     //TODO
 840 ;testWhile.j(287)     println(111);
 841 acc8= constant 111
 842 writeLineAcc8
 843 ;testWhile.j(288)     println(112);
 844 acc8= constant 112
 845 writeLineAcc8
 846 ;testWhile.j(289)     // constant - stack16
 847 ;testWhile.j(290)     // integer - byte
 848 ;testWhile.j(291)     //TODO
 849 ;testWhile.j(292)     println(113);
 850 acc8= constant 113
 851 writeLineAcc8
 852 ;testWhile.j(293)     println(114);
 853 acc8= constant 114
 854 writeLineAcc8
 855 ;testWhile.j(294)     // constant - stack16
 856 ;testWhile.j(295)     // integer - integer
 857 ;testWhile.j(296)     //TODO
 858 ;testWhile.j(297)     println(115);
 859 acc8= constant 115
 860 writeLineAcc8
 861 ;testWhile.j(298)     println(116);
 862 acc8= constant 116
 863 writeLineAcc8
 864 ;testWhile.j(299)   
 865 ;testWhile.j(300)     println("Klaar");
 866 acc16= stringconstant 873
 867 writeLineString
 868 ;testWhile.j(301)   }
 869 stackPointer= basePointer
 870 basePointer<
 871 return
 872 ;testWhile.j(302) }
 873 stringConstant 0 = "Klaar"
