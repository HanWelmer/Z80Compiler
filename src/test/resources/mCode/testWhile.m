   0 call 6
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
  20 br 23
  21 ;testWhile.j(7) 
  22 ;testWhile.j(8)   public static void main() {
  23 method TestWhile.main [public, static] void ()
  24 <basePointer
  25 basePointer= stackPointer
  26 stackPointer+ constant 4
  27 ;testWhile.j(9)     /*Possible operand types: 
  28 ;testWhile.j(10)      * constant, acc, var, stack8, stack16
  29 ;testWhile.j(11)      *Possible datatype combinations:
  30 ;testWhile.j(12)      * byte - byte
  31 ;testWhile.j(13)      * byte - integer
  32 ;testWhile.j(14)      * integer - byte
  33 ;testWhile.j(15)      * integer - integer
  34 ;testWhile.j(16)     */
  35 ;testWhile.j(17)   
  36 ;testWhile.j(18)     println(0);
  37 acc8= constant 0
  38 writeLineAcc8
  39 ;testWhile.j(19)   
  40 ;testWhile.j(20)     /************************/
  41 ;testWhile.j(21)     // global variable within while scope
  42 ;testWhile.j(22)     b++;
  43 incr8 variable 0
  44 ;testWhile.j(23)     println (b);
  45 acc8= variable 0
  46 writeLineAcc8
  47 ;testWhile.j(24)     while (b < 2) {
  48 acc8= variable 0
  49 acc8Comp constant 2
  50 brge 76
  51 ;testWhile.j(25)       b++;
  52 incr8 variable 0
  53 ;testWhile.j(26)       word j = 1001;
  54 acc16= constant 1001
  55 acc16=> (basePointer + -2)
  56 ;testWhile.j(27)       byte c = b;
  57 acc8= variable 0
  58 acc8=> (basePointer + -3)
  59 ;testWhile.j(28)       byte d = c;
  60 acc8= (basePointer + -3)
  61 acc8=> (basePointer + -4)
  62 ;testWhile.j(29)       println (c);
  63 acc8= (basePointer + -3)
  64 writeLineAcc8
  65 ;testWhile.j(30)     }
  66 br 48
  67 ;testWhile.j(31)   
  68 ;testWhile.j(32)     /************************/
  69 ;testWhile.j(33)     // constant - constant
  70 ;testWhile.j(34)     // not relevant
  71 ;testWhile.j(35)   
  72 ;testWhile.j(36)     /************************/
  73 ;testWhile.j(37)     // constant - acc
  74 ;testWhile.j(38)     // byte - byte
  75 ;testWhile.j(39)     b = 3;
  76 acc8= constant 3
  77 acc8=> variable 0
  78 ;testWhile.j(40)     while (3 == b+0) { println (b); b++; }
  79 acc8= variable 0
  80 acc8+ constant 0
  81 acc8Comp constant 3
  82 brne 88
  83 acc8= variable 0
  84 writeLineAcc8
  85 incr8 variable 0
  86 br 79
  87 ;testWhile.j(41)     while (4 != b+0) { println (b); b++; }
  88 acc8= variable 0
  89 acc8+ constant 0
  90 acc8Comp constant 4
  91 breq 97
  92 acc8= variable 0
  93 writeLineAcc8
  94 incr8 variable 0
  95 br 88
  96 ;testWhile.j(42)     while (6 > b+0) { println (b); b++; }
  97 acc8= variable 0
  98 acc8+ constant 0
  99 acc8Comp constant 6
 100 brge 106
 101 acc8= variable 0
 102 writeLineAcc8
 103 incr8 variable 0
 104 br 97
 105 ;testWhile.j(43)     while (7 >= b+0) { println (b); b++; }
 106 acc8= variable 0
 107 acc8+ constant 0
 108 acc8Comp constant 7
 109 brgt 115
 110 acc8= variable 0
 111 writeLineAcc8
 112 incr8 variable 0
 113 br 106
 114 ;testWhile.j(44)     p=8;
 115 acc8= constant 8
 116 acc8=> variable 6
 117 ;testWhile.j(45)     while (6 <  b+0) { println (p); p++; b--; }
 118 acc8= variable 0
 119 acc8+ constant 0
 120 acc8Comp constant 6
 121 brle 128
 122 acc16= variable 6
 123 writeLineAcc16
 124 incr16 variable 6
 125 decr8 variable 0
 126 br 118
 127 ;testWhile.j(46)     while (5 <= b+0) { println (p); p++; b--; }
 128 acc8= variable 0
 129 acc8+ constant 0
 130 acc8Comp constant 5
 131 brlt 141
 132 acc16= variable 6
 133 writeLineAcc16
 134 incr16 variable 6
 135 decr8 variable 0
 136 br 128
 137 ;testWhile.j(47)     
 138 ;testWhile.j(48)     // constant - acc
 139 ;testWhile.j(49)     // byte - integer
 140 ;testWhile.j(50)     i=12;
 141 acc8= constant 12
 142 acc8=> variable 2
 143 ;testWhile.j(51)     while (12 == i+0) { println (i); i++; }
 144 acc16= variable 2
 145 acc16+ constant 0
 146 acc8= constant 12
 147 acc8CompareAcc16
 148 brne 154
 149 acc16= variable 2
 150 writeLineAcc16
 151 incr16 variable 2
 152 br 144
 153 ;testWhile.j(52)     while (15 != i+0) { println (i); i++; }
 154 acc16= variable 2
 155 acc16+ constant 0
 156 acc8= constant 15
 157 acc8CompareAcc16
 158 breq 164
 159 acc16= variable 2
 160 writeLineAcc16
 161 incr16 variable 2
 162 br 154
 163 ;testWhile.j(53)     while (17 > i+0) { println (i); i++; }
 164 acc16= variable 2
 165 acc16+ constant 0
 166 acc8= constant 17
 167 acc8CompareAcc16
 168 brle 174
 169 acc16= variable 2
 170 writeLineAcc16
 171 incr16 variable 2
 172 br 164
 173 ;testWhile.j(54)     while (18 >= i+0) { println (i); i++; }
 174 acc16= variable 2
 175 acc16+ constant 0
 176 acc8= constant 18
 177 acc8CompareAcc16
 178 brlt 184
 179 acc16= variable 2
 180 writeLineAcc16
 181 incr16 variable 2
 182 br 174
 183 ;testWhile.j(55)     p=i;
 184 acc16= variable 2
 185 acc16=> variable 6
 186 ;testWhile.j(56)     while (17 <  i+0) { println (p); i--; p++; }
 187 acc16= variable 2
 188 acc16+ constant 0
 189 acc8= constant 17
 190 acc8CompareAcc16
 191 brge 198
 192 acc16= variable 6
 193 writeLineAcc16
 194 decr16 variable 2
 195 incr16 variable 6
 196 br 187
 197 ;testWhile.j(57)     while (16 <= i+0) { println (p); i--; p++; }
 198 acc16= variable 2
 199 acc16+ constant 0
 200 acc8= constant 16
 201 acc8CompareAcc16
 202 brgt 216
 203 acc16= variable 6
 204 writeLineAcc16
 205 decr16 variable 2
 206 incr16 variable 6
 207 br 198
 208 ;testWhile.j(58)   
 209 ;testWhile.j(59)     // constant - acc
 210 ;testWhile.j(60)     // integer - byte
 211 ;testWhile.j(61)     // not relevant
 212 ;testWhile.j(62)   
 213 ;testWhile.j(63)     // constant - acc
 214 ;testWhile.j(64)     // integer - integer
 215 ;testWhile.j(65)     i=23;
 216 acc8= constant 23
 217 acc8=> variable 2
 218 ;testWhile.j(66)     while (23 == i+0) { println (i); i++; }
 219 acc16= variable 2
 220 acc16+ constant 0
 221 acc8= constant 23
 222 acc8CompareAcc16
 223 brne 229
 224 acc16= variable 2
 225 writeLineAcc16
 226 incr16 variable 2
 227 br 219
 228 ;testWhile.j(67)     while (26 != i+0) { println (i); i++; }
 229 acc16= variable 2
 230 acc16+ constant 0
 231 acc8= constant 26
 232 acc8CompareAcc16
 233 breq 239
 234 acc16= variable 2
 235 writeLineAcc16
 236 incr16 variable 2
 237 br 229
 238 ;testWhile.j(68)     while (28 > i+0) { println (i); i++; }
 239 acc16= variable 2
 240 acc16+ constant 0
 241 acc8= constant 28
 242 acc8CompareAcc16
 243 brle 249
 244 acc16= variable 2
 245 writeLineAcc16
 246 incr16 variable 2
 247 br 239
 248 ;testWhile.j(69)     while (29 >= i+0) { println (i); i++; }
 249 acc16= variable 2
 250 acc16+ constant 0
 251 acc8= constant 29
 252 acc8CompareAcc16
 253 brlt 259
 254 acc16= variable 2
 255 writeLineAcc16
 256 incr16 variable 2
 257 br 249
 258 ;testWhile.j(70)     p=i;
 259 acc16= variable 2
 260 acc16=> variable 6
 261 ;testWhile.j(71)     while (28 <  i+0) { println (p); p++; i--; }
 262 acc16= variable 2
 263 acc16+ constant 0
 264 acc8= constant 28
 265 acc8CompareAcc16
 266 brge 273
 267 acc16= variable 6
 268 writeLineAcc16
 269 incr16 variable 6
 270 decr16 variable 2
 271 br 262
 272 ;testWhile.j(72)     while (27 <= i+0) { println (p); p++; i--; }
 273 acc16= variable 2
 274 acc16+ constant 0
 275 acc8= constant 27
 276 acc8CompareAcc16
 277 brgt 288
 278 acc16= variable 6
 279 writeLineAcc16
 280 incr16 variable 6
 281 decr16 variable 2
 282 br 273
 283 ;testWhile.j(73)   
 284 ;testWhile.j(74)     /************************/
 285 ;testWhile.j(75)     // constant - var
 286 ;testWhile.j(76)     // byte - byte
 287 ;testWhile.j(77)     b=35;
 288 acc8= constant 35
 289 acc8=> variable 0
 290 ;testWhile.j(78)     while (33 <= b) { println (p); p++; b--; }
 291 acc8= variable 0
 292 acc8Comp constant 33
 293 brlt 302
 294 acc16= variable 6
 295 writeLineAcc16
 296 incr16 variable 6
 297 decr8 variable 0
 298 br 291
 299 ;testWhile.j(79)     // constant - var
 300 ;testWhile.j(80)     // byte - integer
 301 ;testWhile.j(81)     i=37;
 302 acc8= constant 37
 303 acc8=> variable 2
 304 ;testWhile.j(82)     while (36 <= i) { println (p); p++; i--; }
 305 acc16= variable 2
 306 acc8= constant 36
 307 acc8CompareAcc16
 308 brgt 321
 309 acc16= variable 6
 310 writeLineAcc16
 311 incr16 variable 6
 312 decr16 variable 2
 313 br 305
 314 ;testWhile.j(83)     // constant - var
 315 ;testWhile.j(84)     // integer - byte
 316 ;testWhile.j(85)     // not relevant
 317 ;testWhile.j(86)   
 318 ;testWhile.j(87)     // constant - var
 319 ;testWhile.j(88)     // integer - integer
 320 ;testWhile.j(89)     while (34 <= i) { println (p); p++; i--; }
 321 acc16= variable 2
 322 acc8= constant 34
 323 acc8CompareAcc16
 324 brgt 367
 325 acc16= variable 6
 326 writeLineAcc16
 327 incr16 variable 6
 328 decr16 variable 2
 329 br 321
 330 ;testWhile.j(90)   
 331 ;testWhile.j(91)     /************************/
 332 ;testWhile.j(92)     // stack8 - constant
 333 ;testWhile.j(93)     // stack8 - acc
 334 ;testWhile.j(94)     // stack8 - var
 335 ;testWhile.j(95)     // stack8 - stack8
 336 ;testWhile.j(96)     // stack8 - stack16
 337 ;testWhile.j(97)     //TODO
 338 ;testWhile.j(98)   
 339 ;testWhile.j(99)     /************************/
 340 ;testWhile.j(100)     // stack16 - constant
 341 ;testWhile.j(101)     // stack16 - acc
 342 ;testWhile.j(102)     // stack16 - var
 343 ;testWhile.j(103)     // stack16 - stack8
 344 ;testWhile.j(104)     // stack16 - stack16
 345 ;testWhile.j(105)     //TODO
 346 ;testWhile.j(106)   
 347 ;testWhile.j(107)     /************************/
 348 ;testWhile.j(108)     // var - stack16
 349 ;testWhile.j(109)     // byte - byte
 350 ;testWhile.j(110)     // byte - integer
 351 ;testWhile.j(111)     // integer - byte
 352 ;testWhile.j(112)     // integer - integer
 353 ;testWhile.j(113)     //TODO
 354 ;testWhile.j(114)   
 355 ;testWhile.j(115)     /************************/
 356 ;testWhile.j(116)     // var - stack8
 357 ;testWhile.j(117)     // byte - byte
 358 ;testWhile.j(118)     // byte - integer
 359 ;testWhile.j(119)     // integer - byte
 360 ;testWhile.j(120)     // integer - integer
 361 ;testWhile.j(121)     //TODO
 362 ;testWhile.j(122)   
 363 ;testWhile.j(123)     /************************/
 364 ;testWhile.j(124)     // var - var
 365 ;testWhile.j(125)     // byte - byte
 366 ;testWhile.j(126)     b=33;
 367 acc8= constant 33
 368 acc8=> variable 0
 369 ;testWhile.j(127)     while (b2 <= b) { println (p); p++; b--; }
 370 acc8= variable 1
 371 acc8Comp variable 0
 372 brgt 380
 373 acc16= variable 6
 374 writeLineAcc16
 375 incr16 variable 6
 376 decr8 variable 0
 377 br 370
 378 ;testWhile.j(128)     // byte - integer
 379 ;testWhile.j(129)     i = 33;
 380 acc8= constant 33
 381 acc8=> variable 2
 382 ;testWhile.j(130)     while (b2 <= i) { println (p); p++; i--; }
 383 acc8= variable 1
 384 acc16= variable 2
 385 acc8CompareAcc16
 386 brgt 394
 387 acc16= variable 6
 388 writeLineAcc16
 389 incr16 variable 6
 390 decr16 variable 2
 391 br 383
 392 ;testWhile.j(131)     // integer - byte
 393 ;testWhile.j(132)     b=33;
 394 acc8= constant 33
 395 acc8=> variable 0
 396 ;testWhile.j(133)     i=b2;
 397 acc8= variable 1
 398 acc8=> variable 2
 399 ;testWhile.j(134)     while (i <= b) { println (p); p++; b--; }
 400 acc16= variable 2
 401 acc8= variable 0
 402 acc16CompareAcc8
 403 brgt 411
 404 acc16= variable 6
 405 writeLineAcc16
 406 incr16 variable 6
 407 decr8 variable 0
 408 br 400
 409 ;testWhile.j(135)     // integer - integer
 410 ;testWhile.j(136)     i=33;
 411 acc8= constant 33
 412 acc8=> variable 2
 413 ;testWhile.j(137)     i2=b2;
 414 acc8= variable 1
 415 acc8=> variable 4
 416 ;testWhile.j(138)     while (i2 <= i) { println (p); p++; i--; }
 417 acc16= variable 4
 418 acc16Comp variable 2
 419 brgt 430
 420 acc16= variable 6
 421 writeLineAcc16
 422 incr16 variable 6
 423 decr16 variable 2
 424 br 417
 425 ;testWhile.j(139)   
 426 ;testWhile.j(140)     /************************/
 427 ;testWhile.j(141)     // var - acc
 428 ;testWhile.j(142)     // byte - byte
 429 ;testWhile.j(143)     b=49;
 430 acc8= constant 49
 431 acc8=> variable 0
 432 ;testWhile.j(144)     while (b <= 50+0) { println (b); b++; }
 433 acc8= constant 50
 434 acc8+ constant 0
 435 acc8Comp variable 0
 436 brlt 443
 437 acc8= variable 0
 438 writeLineAcc8
 439 incr8 variable 0
 440 br 433
 441 ;testWhile.j(145)     // byte - integer
 442 ;testWhile.j(146)     i=52;
 443 acc8= constant 52
 444 acc8=> variable 2
 445 ;testWhile.j(147)     while (b <= i+0) { println (b); b++; }
 446 acc16= variable 2
 447 acc16+ constant 0
 448 acc8= variable 0
 449 acc8CompareAcc16
 450 brgt 457
 451 acc8= variable 0
 452 writeLineAcc8
 453 incr8 variable 0
 454 br 446
 455 ;testWhile.j(148)     // integer - byte
 456 ;testWhile.j(149)     i=b;
 457 acc8= variable 0
 458 acc8=> variable 2
 459 ;testWhile.j(150)     while (i <= 54+0) { println (i); i++; }
 460 acc8= constant 54
 461 acc8+ constant 0
 462 acc16= variable 2
 463 acc16CompareAcc8
 464 brgt 471
 465 acc16= variable 2
 466 writeLineAcc16
 467 incr16 variable 2
 468 br 460
 469 ;testWhile.j(151)     // integer - integer
 470 ;testWhile.j(152)     b=i;
 471 acc16= variable 2
 472 acc16=> variable 0
 473 ;testWhile.j(153)     i=1098;
 474 acc16= constant 1098
 475 acc16=> variable 2
 476 ;testWhile.j(154)     while (i <= 1099+0) { println (b); b++; i++; }
 477 acc16= constant 1099
 478 acc16+ constant 0
 479 acc16Comp variable 2
 480 brlt 491
 481 acc8= variable 0
 482 writeLineAcc8
 483 incr8 variable 0
 484 incr16 variable 2
 485 br 477
 486 ;testWhile.j(155)   
 487 ;testWhile.j(156)     /************************/
 488 ;testWhile.j(157)     // var - constant
 489 ;testWhile.j(158)     // byte - byte
 490 ;testWhile.j(159)     while (b <= 58) { println (b); b++; }
 491 acc8= variable 0
 492 acc8Comp constant 58
 493 brgt 503
 494 acc8= variable 0
 495 writeLineAcc8
 496 incr8 variable 0
 497 br 491
 498 ;testWhile.j(160)     // byte - integer
 499 ;testWhile.j(161)     //not relevant
 500 ;testWhile.j(162)   
 501 ;testWhile.j(163)     // integer - byte
 502 ;testWhile.j(164)     i=b;
 503 acc8= variable 0
 504 acc8=> variable 2
 505 ;testWhile.j(165)     while (i <= 60) { println (i); i++; }
 506 acc16= variable 2
 507 acc8= constant 60
 508 acc16CompareAcc8
 509 brgt 516
 510 acc16= variable 2
 511 writeLineAcc16
 512 incr16 variable 2
 513 br 506
 514 ;testWhile.j(166)     // integer - integer
 515 ;testWhile.j(167)     i2=1090;
 516 acc16= constant 1090
 517 acc16=> variable 4
 518 ;testWhile.j(168)     while (i2 <= 1091) { println (i); i++; i2++; }
 519 acc16= variable 4
 520 acc16Comp constant 1091
 521 brgt 533
 522 acc16= variable 2
 523 writeLineAcc16
 524 incr16 variable 2
 525 incr16 variable 4
 526 br 519
 527 ;testWhile.j(169)   
 528 ;testWhile.j(170)     /************************/
 529 ;testWhile.j(171)     // acc - stack8
 530 ;testWhile.j(172)     // byte - byte
 531 ;testWhile.j(173)     //TODO
 532 ;testWhile.j(174)     println(63);
 533 acc8= constant 63
 534 writeLineAcc8
 535 ;testWhile.j(175)     println(64);
 536 acc8= constant 64
 537 writeLineAcc8
 538 ;testWhile.j(176)     // byte - integer
 539 ;testWhile.j(177)     //TODO
 540 ;testWhile.j(178)     println(65);
 541 acc8= constant 65
 542 writeLineAcc8
 543 ;testWhile.j(179)     println(66);
 544 acc8= constant 66
 545 writeLineAcc8
 546 ;testWhile.j(180)     // integer - byte
 547 ;testWhile.j(181)     //TODO
 548 ;testWhile.j(182)     println(67);
 549 acc8= constant 67
 550 writeLineAcc8
 551 ;testWhile.j(183)     println(68);
 552 acc8= constant 68
 553 writeLineAcc8
 554 ;testWhile.j(184)     // integer - integer
 555 ;testWhile.j(185)     //TODO
 556 ;testWhile.j(186)     println(69);
 557 acc8= constant 69
 558 writeLineAcc8
 559 ;testWhile.j(187)     println(70);
 560 acc8= constant 70
 561 writeLineAcc8
 562 ;testWhile.j(188)   
 563 ;testWhile.j(189)     /************************/
 564 ;testWhile.j(190)     // acc - stack16
 565 ;testWhile.j(191)     // byte - byte
 566 ;testWhile.j(192)     //TODO
 567 ;testWhile.j(193)     println(71);
 568 acc8= constant 71
 569 writeLineAcc8
 570 ;testWhile.j(194)     println(72);
 571 acc8= constant 72
 572 writeLineAcc8
 573 ;testWhile.j(195)     // byte - integer
 574 ;testWhile.j(196)     //TODO
 575 ;testWhile.j(197)     println(73);
 576 acc8= constant 73
 577 writeLineAcc8
 578 ;testWhile.j(198)     println(74);
 579 acc8= constant 74
 580 writeLineAcc8
 581 ;testWhile.j(199)     // integer - byte
 582 ;testWhile.j(200)     //TODO
 583 ;testWhile.j(201)     println(75);
 584 acc8= constant 75
 585 writeLineAcc8
 586 ;testWhile.j(202)     println(76);
 587 acc8= constant 76
 588 writeLineAcc8
 589 ;testWhile.j(203)     // integer - integer
 590 ;testWhile.j(204)     //TODO
 591 ;testWhile.j(205)     println(77);
 592 acc8= constant 77
 593 writeLineAcc8
 594 ;testWhile.j(206)     println(78);
 595 acc8= constant 78
 596 writeLineAcc8
 597 ;testWhile.j(207)   
 598 ;testWhile.j(208)     /************************/
 599 ;testWhile.j(209)     // acc - var
 600 ;testWhile.j(210)     // byte - byte
 601 ;testWhile.j(211)     b=79;
 602 acc8= constant 79
 603 acc8=> variable 0
 604 ;testWhile.j(212)     b2=79;
 605 acc8= constant 79
 606 acc8=> variable 1
 607 ;testWhile.j(213)     while (78+0 <= b2) { println (b); b++; b2--; }
 608 acc8= constant 78
 609 acc8+ constant 0
 610 acc8Comp variable 1
 611 brgt 619
 612 acc8= variable 0
 613 writeLineAcc8
 614 incr8 variable 0
 615 decr8 variable 1
 616 br 608
 617 ;testWhile.j(214)     // byte - integer
 618 ;testWhile.j(215)     i=79;
 619 acc8= constant 79
 620 acc8=> variable 2
 621 ;testWhile.j(216)     while (78+0 <= i) { println (b); b++; i--; }
 622 acc8= constant 78
 623 acc8+ constant 0
 624 acc16= variable 2
 625 acc8CompareAcc16
 626 brgt 634
 627 acc8= variable 0
 628 writeLineAcc8
 629 incr8 variable 0
 630 decr16 variable 2
 631 br 622
 632 ;testWhile.j(217)     // integer - byte
 633 ;testWhile.j(218)     i=78;
 634 acc8= constant 78
 635 acc8=> variable 2
 636 ;testWhile.j(219)     b2=79;
 637 acc8= constant 79
 638 acc8=> variable 1
 639 ;testWhile.j(220)     while (i+0 <= b2) { println (b); b++; b2--; } 
 640 acc16= variable 2
 641 acc16+ constant 0
 642 acc8= variable 1
 643 acc16CompareAcc8
 644 brgt 652
 645 acc8= variable 0
 646 writeLineAcc8
 647 incr8 variable 0
 648 decr8 variable 1
 649 br 640
 650 ;testWhile.j(221)     // integer - integer
 651 ;testWhile.j(222)     i=1066;
 652 acc16= constant 1066
 653 acc16=> variable 2
 654 ;testWhile.j(223)     while (1000+65 <= i) { println (b); b++; i--; }
 655 acc16= constant 1000
 656 acc16+ constant 65
 657 acc16Comp variable 2
 658 brgt 669
 659 acc8= variable 0
 660 writeLineAcc8
 661 incr8 variable 0
 662 decr16 variable 2
 663 br 655
 664 ;testWhile.j(224)   
 665 ;testWhile.j(225)     /************************/
 666 ;testWhile.j(226)     // acc - acc
 667 ;testWhile.j(227)     // byte - byte
 668 ;testWhile.j(228)     b=87;
 669 acc8= constant 87
 670 acc8=> variable 0
 671 ;testWhile.j(229)     b2=64;
 672 acc8= constant 64
 673 acc8=> variable 1
 674 ;testWhile.j(230)     while (63+0 <= b2+0) { println (b); b++; b2--; }
 675 acc8= constant 63
 676 acc8+ constant 0
 677 <acc8
 678 acc8= variable 1
 679 acc8+ constant 0
 680 revAcc8Comp unstack8
 681 brlt 689
 682 acc8= variable 0
 683 writeLineAcc8
 684 incr8 variable 0
 685 decr8 variable 1
 686 br 675
 687 ;testWhile.j(231)     // byte - integer
 688 ;testWhile.j(232)     i=62;
 689 acc8= constant 62
 690 acc8=> variable 2
 691 ;testWhile.j(233)     while (61+0 <= i+0) { println (b); b++; i--; }
 692 acc8= constant 61
 693 acc8+ constant 0
 694 <acc8
 695 acc16= variable 2
 696 acc16+ constant 0
 697 acc8<
 698 acc8CompareAcc16
 699 brgt 707
 700 acc8= variable 0
 701 writeLineAcc8
 702 incr8 variable 0
 703 decr16 variable 2
 704 br 692
 705 ;testWhile.j(234)     // integer - byte
 706 ;testWhile.j(235)     i=59;
 707 acc8= constant 59
 708 acc8=> variable 2
 709 ;testWhile.j(236)     b2=60;
 710 acc8= constant 60
 711 acc8=> variable 1
 712 ;testWhile.j(237)     while (i+0 <= b2+0) { println (b); b++; b2--; }
 713 acc16= variable 2
 714 acc16+ constant 0
 715 <acc16
 716 acc8= variable 1
 717 acc8+ constant 0
 718 acc16<
 719 acc16CompareAcc8
 720 brgt 728
 721 acc8= variable 0
 722 writeLineAcc8
 723 incr8 variable 0
 724 decr8 variable 1
 725 br 713
 726 ;testWhile.j(238)     // integer - integer
 727 ;testWhile.j(239)     i=1058;
 728 acc16= constant 1058
 729 acc16=> variable 2
 730 ;testWhile.j(240)     while (1000+57 <= i+0) { println (b); b++; i--; }
 731 acc16= constant 1000
 732 acc16+ constant 57
 733 <acc16
 734 acc16= variable 2
 735 acc16+ constant 0
 736 revAcc16Comp unstack16
 737 brlt 748
 738 acc8= variable 0
 739 writeLineAcc8
 740 incr8 variable 0
 741 decr16 variable 2
 742 br 731
 743 ;testWhile.j(241)   
 744 ;testWhile.j(242)     /************************/
 745 ;testWhile.j(243)     // acc - constant
 746 ;testWhile.j(244)     // byte - byte
 747 ;testWhile.j(245)     while (b+0 <= 96) { println (b); b++; }
 748 acc8= variable 0
 749 acc8+ constant 0
 750 acc8Comp constant 96
 751 brgt 760
 752 acc8= variable 0
 753 writeLineAcc8
 754 incr8 variable 0
 755 br 748
 756 ;testWhile.j(246)     // byte - integer
 757 ;testWhile.j(247)     //not relevant
 758 ;testWhile.j(248)     // integer - byte
 759 ;testWhile.j(249)     i=b;
 760 acc8= variable 0
 761 acc8=> variable 2
 762 ;testWhile.j(250)     while (i+0 <= 98) { println (i); i++; }
 763 acc16= variable 2
 764 acc16+ constant 0
 765 acc8= constant 98
 766 acc16CompareAcc8
 767 brgt 773
 768 acc16= variable 2
 769 writeLineAcc16
 770 incr16 variable 2
 771 br 763
 772 ;testWhile.j(251)     b=i;
 773 acc16= variable 2
 774 acc16=> variable 0
 775 ;testWhile.j(252)     i=1052;
 776 acc16= constant 1052
 777 acc16=> variable 2
 778 ;testWhile.j(253)     // integer - integer
 779 ;testWhile.j(254)     while (i+0 <= 1053) { println (b); b++; i++; }
 780 acc16= variable 2
 781 acc16+ constant 0
 782 acc16Comp constant 1053
 783 brgt 795
 784 acc8= variable 0
 785 writeLineAcc8
 786 incr8 variable 0
 787 incr16 variable 2
 788 br 780
 789 ;testWhile.j(255)   
 790 ;testWhile.j(256)     /************************/
 791 ;testWhile.j(257)     // constant - stack8
 792 ;testWhile.j(258)     // byte - byte
 793 ;testWhile.j(259)     //TODO
 794 ;testWhile.j(260)     println(101);
 795 acc8= constant 101
 796 writeLineAcc8
 797 ;testWhile.j(261)     println(102);
 798 acc8= constant 102
 799 writeLineAcc8
 800 ;testWhile.j(262)     // constant - stack8
 801 ;testWhile.j(263)     // byte - integer
 802 ;testWhile.j(264)     //TODO
 803 ;testWhile.j(265)     println(103);
 804 acc8= constant 103
 805 writeLineAcc8
 806 ;testWhile.j(266)     println(104);
 807 acc8= constant 104
 808 writeLineAcc8
 809 ;testWhile.j(267)     // constant - stack8
 810 ;testWhile.j(268)     // integer - byte
 811 ;testWhile.j(269)     //TODO
 812 ;testWhile.j(270)     println(105);
 813 acc8= constant 105
 814 writeLineAcc8
 815 ;testWhile.j(271)     println(106);
 816 acc8= constant 106
 817 writeLineAcc8
 818 ;testWhile.j(272)     // constant - stack88
 819 ;testWhile.j(273)     // integer - integer
 820 ;testWhile.j(274)     //TODO
 821 ;testWhile.j(275)     println(107);
 822 acc8= constant 107
 823 writeLineAcc8
 824 ;testWhile.j(276)     println(108);
 825 acc8= constant 108
 826 writeLineAcc8
 827 ;testWhile.j(277)   
 828 ;testWhile.j(278)     /************************/
 829 ;testWhile.j(279)     // constant - stack16
 830 ;testWhile.j(280)     // byte - byte
 831 ;testWhile.j(281)     //TODO
 832 ;testWhile.j(282)     println(109);
 833 acc8= constant 109
 834 writeLineAcc8
 835 ;testWhile.j(283)     println(110);
 836 acc8= constant 110
 837 writeLineAcc8
 838 ;testWhile.j(284)     // constant - stack16
 839 ;testWhile.j(285)     // byte - integer
 840 ;testWhile.j(286)     //TODO
 841 ;testWhile.j(287)     println(111);
 842 acc8= constant 111
 843 writeLineAcc8
 844 ;testWhile.j(288)     println(112);
 845 acc8= constant 112
 846 writeLineAcc8
 847 ;testWhile.j(289)     // constant - stack16
 848 ;testWhile.j(290)     // integer - byte
 849 ;testWhile.j(291)     //TODO
 850 ;testWhile.j(292)     println(113);
 851 acc8= constant 113
 852 writeLineAcc8
 853 ;testWhile.j(293)     println(114);
 854 acc8= constant 114
 855 writeLineAcc8
 856 ;testWhile.j(294)     // constant - stack16
 857 ;testWhile.j(295)     // integer - integer
 858 ;testWhile.j(296)     //TODO
 859 ;testWhile.j(297)     println(115);
 860 acc8= constant 115
 861 writeLineAcc8
 862 ;testWhile.j(298)     println(116);
 863 acc8= constant 116
 864 writeLineAcc8
 865 ;testWhile.j(299)   
 866 ;testWhile.j(300)     println("Klaar");
 867 acc16= stringconstant 874
 868 writeLineString
 869 ;testWhile.j(301)   }
 870 stackPointer= basePointer
 871 basePointer<
 872 return
 873 ;testWhile.j(302) }
 874 stringConstant 0 = "Klaar"
