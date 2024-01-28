   0 ;test10.j(0) /* Program to test generated Z80 assembler code */
   1 ;test10.j(1) class TestDo {
   2 ;test10.j(2)   private static byte b = 1;
   3 acc8= constant 1
   4 acc8=> variable 0
   5 ;test10.j(3)   private static word i = 12;
   6 acc8= constant 12
   7 acc8=> variable 1
   8 ;test10.j(4)   private static word p = 12;
   9 acc8= constant 12
  10 acc8=> variable 3
  11 ;test10.j(5) 
  12 ;test10.j(6)   public static void main() {
  13 method main [staticLexeme] voidLexeme
  14 ;test10.j(7)     println(0);
  15 acc8= constant 0
  16 call writeLineAcc8
  17 ;test10.j(8)   
  18 ;test10.j(9)     /************************/
  19 ;test10.j(10)     // global variable within do scope
  20 ;test10.j(11)     println (b);
  21 acc8= variable 0
  22 call writeLineAcc8
  23 ;test10.j(12)     b++;
  24 incr8 variable 0
  25 ;test10.j(13)     do {
  26 ;test10.j(14)       word j = 1001;
  27 acc16= constant 1001
  28 acc16=> variable 5
  29 ;test10.j(15)       byte c = b;
  30 acc8= variable 0
  31 acc8=> variable 7
  32 ;test10.j(16)       byte d = c;
  33 acc8= variable 7
  34 acc8=> variable 8
  35 ;test10.j(17)       b++;
  36 incr8 variable 0
  37 ;test10.j(18)       println (c);
  38 acc8= variable 7
  39 call writeLineAcc8
  40 ;test10.j(19)     } while (b<2);
  41 acc8= variable 0
  42 acc8Comp constant 2
  43 brlt 26
  44 ;test10.j(20)   
  45 ;test10.j(21)     /************************/
  46 ;test10.j(22)     // constant - constant
  47 ;test10.j(23)     // not relevant
  48 ;test10.j(24)   
  49 ;test10.j(25)     /************************/
  50 ;test10.j(26)     // constant - acc
  51 ;test10.j(27)     // byte - byte
  52 ;test10.j(28)     do { println (b); b++; } while (103 == b+100);
  53 acc8= variable 0
  54 call writeLineAcc8
  55 incr8 variable 0
  56 acc8= variable 0
  57 acc8+ constant 100
  58 acc8Comp constant 103
  59 breq 53
  60 ;test10.j(29)     do { println (b); b++; } while (106 != b+100);
  61 acc8= variable 0
  62 call writeLineAcc8
  63 incr8 variable 0
  64 acc8= variable 0
  65 acc8+ constant 100
  66 acc8Comp constant 106
  67 brne 61
  68 ;test10.j(30)     do { println (b); b++; } while (108 >  b+100);
  69 acc8= variable 0
  70 call writeLineAcc8
  71 incr8 variable 0
  72 acc8= variable 0
  73 acc8+ constant 100
  74 acc8Comp constant 108
  75 brlt 69
  76 ;test10.j(31)     do { println (b); b++; } while (109 >= b+100);
  77 acc8= variable 0
  78 call writeLineAcc8
  79 incr8 variable 0
  80 acc8= variable 0
  81 acc8+ constant 100
  82 acc8Comp constant 109
  83 brle 77
  84 ;test10.j(32)     p=10;
  85 acc8= constant 10
  86 acc8=> variable 3
  87 ;test10.j(33)     do { println (p); p++; b--; } while (108 <  b+100);
  88 acc16= variable 3
  89 call writeLineAcc16
  90 incr16 variable 3
  91 decr8 variable 0
  92 acc8= variable 0
  93 acc8+ constant 100
  94 acc8Comp constant 108
  95 brgt 88
  96 ;test10.j(34)     do { println (p); p++; b--; } while (107 <= b+100);
  97 acc16= variable 3
  98 call writeLineAcc16
  99 incr16 variable 3
 100 decr8 variable 0
 101 acc8= variable 0
 102 acc8+ constant 100
 103 acc8Comp constant 107
 104 brge 97
 105 ;test10.j(35)   
 106 ;test10.j(36)     // constant - acc
 107 ;test10.j(37)     // byte - integer
 108 ;test10.j(38)     i=14;
 109 acc8= constant 14
 110 acc8=> variable 1
 111 ;test10.j(39)     do { println (i); i++; } while (15 == i+0);
 112 acc16= variable 1
 113 call writeLineAcc16
 114 incr16 variable 1
 115 acc16= variable 1
 116 acc16+ constant 0
 117 acc8= constant 15
 118 acc8CompareAcc16
 119 breq 112
 120 ;test10.j(40)     do { println (i); i++; } while (18 != i+0);
 121 acc16= variable 1
 122 call writeLineAcc16
 123 incr16 variable 1
 124 acc16= variable 1
 125 acc16+ constant 0
 126 acc8= constant 18
 127 acc8CompareAcc16
 128 brne 121
 129 ;test10.j(41)     do { println (i); i++; } while (20 >  i+0);
 130 acc16= variable 1
 131 call writeLineAcc16
 132 incr16 variable 1
 133 acc16= variable 1
 134 acc16+ constant 0
 135 acc8= constant 20
 136 acc8CompareAcc16
 137 brgt 130
 138 ;test10.j(42)     do { println (i); i++; } while (21 >= i+0);
 139 acc16= variable 1
 140 call writeLineAcc16
 141 incr16 variable 1
 142 acc16= variable 1
 143 acc16+ constant 0
 144 acc8= constant 21
 145 acc8CompareAcc16
 146 brge 139
 147 ;test10.j(43)     p=22;
 148 acc8= constant 22
 149 acc8=> variable 3
 150 ;test10.j(44)     do { println (p); p++; i--; } while (20 <  i+0);
 151 acc16= variable 3
 152 call writeLineAcc16
 153 incr16 variable 3
 154 decr16 variable 1
 155 acc16= variable 1
 156 acc16+ constant 0
 157 acc8= constant 20
 158 acc8CompareAcc16
 159 brlt 151
 160 ;test10.j(45)     do { println (p); p++; i--; } while (19 <= i+0);
 161 acc16= variable 3
 162 call writeLineAcc16
 163 incr16 variable 3
 164 decr16 variable 1
 165 acc16= variable 1
 166 acc16+ constant 0
 167 acc8= constant 19
 168 acc8CompareAcc16
 169 brle 161
 170 ;test10.j(46)   
 171 ;test10.j(47)     // constant - acc
 172 ;test10.j(48)     // integer - byte
 173 ;test10.j(49)     // not relevant
 174 ;test10.j(50)   
 175 ;test10.j(51)     // constant - acc
 176 ;test10.j(52)     // integer - integer
 177 ;test10.j(53)     i=p;
 178 acc16= variable 3
 179 acc16=> variable 1
 180 ;test10.j(54)     do { println (i); i++; } while (1027 == i+1000);
 181 acc16= variable 1
 182 call writeLineAcc16
 183 incr16 variable 1
 184 acc16= variable 1
 185 acc16+ constant 1000
 186 acc16Comp constant 1027
 187 breq 181
 188 ;test10.j(55)     do { println (i); i++; } while (1029 != i+1000);
 189 acc16= variable 1
 190 call writeLineAcc16
 191 incr16 variable 1
 192 acc16= variable 1
 193 acc16+ constant 1000
 194 acc16Comp constant 1029
 195 brne 189
 196 ;test10.j(56)     do { println (i); i++; } while (1031 >  i+1000);
 197 acc16= variable 1
 198 call writeLineAcc16
 199 incr16 variable 1
 200 acc16= variable 1
 201 acc16+ constant 1000
 202 acc16Comp constant 1031
 203 brlt 197
 204 ;test10.j(57)     do { println (i); i++; } while (1032 >= i+1000);
 205 acc16= variable 1
 206 call writeLineAcc16
 207 incr16 variable 1
 208 acc16= variable 1
 209 acc16+ constant 1000
 210 acc16Comp constant 1032
 211 brle 205
 212 ;test10.j(58)     p=i;
 213 acc16= variable 1
 214 acc16=> variable 3
 215 ;test10.j(59)     do { println (p); p++; i--; } while (1031 <  i+1000);
 216 acc16= variable 3
 217 call writeLineAcc16
 218 incr16 variable 3
 219 decr16 variable 1
 220 acc16= variable 1
 221 acc16+ constant 1000
 222 acc16Comp constant 1031
 223 brgt 216
 224 ;test10.j(60)     do { println (p); p++; i--; } while (1030 <= i+1000);
 225 acc16= variable 3
 226 call writeLineAcc16
 227 incr16 variable 3
 228 decr16 variable 1
 229 acc16= variable 1
 230 acc16+ constant 1000
 231 acc16Comp constant 1030
 232 brge 225
 233 ;test10.j(61)   
 234 ;test10.j(62)     /************************/
 235 ;test10.j(63)     // constant - var
 236 ;test10.j(64)     // byte - byte
 237 ;test10.j(65)     b=37;
 238 acc8= constant 37
 239 acc8=> variable 0
 240 ;test10.j(66)     do { println (b); b++; } while (38 >= b);
 241 acc8= variable 0
 242 call writeLineAcc8
 243 incr8 variable 0
 244 acc8= variable 0
 245 acc8Comp constant 38
 246 brle 241
 247 ;test10.j(67)     // byte - integer
 248 ;test10.j(68)     i=39;
 249 acc8= constant 39
 250 acc8=> variable 1
 251 ;test10.j(69)     do { println (i); i++; } while (40 >= i);
 252 acc16= variable 1
 253 call writeLineAcc16
 254 incr16 variable 1
 255 acc16= variable 1
 256 acc8= constant 40
 257 acc8CompareAcc16
 258 brge 252
 259 ;test10.j(70)     // integer - byte
 260 ;test10.j(71)     // not relevant
 261 ;test10.j(72)     // integer - integer
 262 ;test10.j(73)     i=1038;
 263 acc16= constant 1038
 264 acc16=> variable 1
 265 ;test10.j(74)     b=41;
 266 acc8= constant 41
 267 acc8=> variable 0
 268 ;test10.j(75)     do { println (b); b++; i--; } while (1037 <= i);
 269 acc8= variable 0
 270 call writeLineAcc8
 271 incr8 variable 0
 272 decr16 variable 1
 273 acc16= variable 1
 274 acc16Comp constant 1037
 275 brge 269
 276 ;test10.j(76)   
 277 ;test10.j(77)     /************************/
 278 ;test10.j(78)     // constant - stack8
 279 ;test10.j(79)     // byte - byte
 280 ;test10.j(80)     //TODO
 281 ;test10.j(81)     println(43);
 282 acc8= constant 43
 283 call writeLineAcc8
 284 ;test10.j(82)     // constant - stack8
 285 ;test10.j(83)     // byte - integer
 286 ;test10.j(84)     //TODO
 287 ;test10.j(85)     println(44);
 288 acc8= constant 44
 289 call writeLineAcc8
 290 ;test10.j(86)     // constant - stack8
 291 ;test10.j(87)     // integer - byte
 292 ;test10.j(88)     //TODO
 293 ;test10.j(89)     println(45);
 294 acc8= constant 45
 295 call writeLineAcc8
 296 ;test10.j(90)     // constant - stack88
 297 ;test10.j(91)     // integer - integer
 298 ;test10.j(92)     //TODO
 299 ;test10.j(93)     println(46);
 300 acc8= constant 46
 301 call writeLineAcc8
 302 ;test10.j(94)   
 303 ;test10.j(95)     /************************/
 304 ;test10.j(96)     // constant - stack16
 305 ;test10.j(97)     // byte - byte
 306 ;test10.j(98)     //TODO
 307 ;test10.j(99)     println(47);
 308 acc8= constant 47
 309 call writeLineAcc8
 310 ;test10.j(100)     // constant - stack16
 311 ;test10.j(101)     // byte - integer
 312 ;test10.j(102)     //TODO
 313 ;test10.j(103)     println(48);
 314 acc8= constant 48
 315 call writeLineAcc8
 316 ;test10.j(104)     // constant - stack16
 317 ;test10.j(105)     // integer - byte
 318 ;test10.j(106)     //TODO
 319 ;test10.j(107)     println(49);
 320 acc8= constant 49
 321 call writeLineAcc8
 322 ;test10.j(108)     // constant - stack16
 323 ;test10.j(109)     // integer - integer
 324 ;test10.j(110)     //TODO
 325 ;test10.j(111)     println(50);
 326 acc8= constant 50
 327 call writeLineAcc8
 328 ;test10.j(112)   
 329 ;test10.j(113)     /************************/
 330 ;test10.j(114)     // acc - constant
 331 ;test10.j(115)     // byte - byte
 332 ;test10.j(116)     b=51;
 333 acc8= constant 51
 334 acc8=> variable 0
 335 ;test10.j(117)     do { println (b); b++; } while (b+0 <= 52);
 336 acc8= variable 0
 337 call writeLineAcc8
 338 incr8 variable 0
 339 acc8= variable 0
 340 acc8+ constant 0
 341 acc8Comp constant 52
 342 brle 336
 343 ;test10.j(118)     // byte - integer
 344 ;test10.j(119)     //not relevant
 345 ;test10.j(120)     // integer - byte
 346 ;test10.j(121)     i=53;
 347 acc8= constant 53
 348 acc8=> variable 1
 349 ;test10.j(122)     do { println (i); i++; } while (i+0 <= 54);
 350 acc16= variable 1
 351 call writeLineAcc16
 352 incr16 variable 1
 353 acc16= variable 1
 354 acc16+ constant 0
 355 acc8= constant 54
 356 acc16CompareAcc8
 357 brle 350
 358 ;test10.j(123)   
 359 ;test10.j(124)     b=55;
 360 acc8= constant 55
 361 acc8=> variable 0
 362 ;test10.j(125)     i=1055;
 363 acc16= constant 1055
 364 acc16=> variable 1
 365 ;test10.j(126)     // integer - integer
 366 ;test10.j(127)     do { println (b); b++; i++; } while (i+0 <= 1056);
 367 acc8= variable 0
 368 call writeLineAcc8
 369 incr8 variable 0
 370 incr16 variable 1
 371 acc16= variable 1
 372 acc16+ constant 0
 373 acc16Comp constant 1056
 374 brle 367
 375 ;test10.j(128)   
 376 ;test10.j(129)     /************************/
 377 ;test10.j(130)     // acc - acc
 378 ;test10.j(131)     // byte - byte
 379 ;test10.j(132)     b=57;
 380 acc8= constant 57
 381 acc8=> variable 0
 382 ;test10.j(133)     do { println (b); b++; } while (b+0 <= 58+0);
 383 acc8= variable 0
 384 call writeLineAcc8
 385 incr8 variable 0
 386 acc8= variable 0
 387 acc8+ constant 0
 388 <acc8
 389 acc8= constant 58
 390 acc8+ constant 0
 391 revAcc8Comp unstack8
 392 brge 383
 393 ;test10.j(134)     // byte - integer
 394 ;test10.j(135)     i=61;
 395 acc8= constant 61
 396 acc8=> variable 1
 397 ;test10.j(136)     do { println (b); b++; i--; } while (60+0 <= i+0);
 398 acc8= variable 0
 399 call writeLineAcc8
 400 incr8 variable 0
 401 decr16 variable 1
 402 acc8= constant 60
 403 acc8+ constant 0
 404 <acc8
 405 acc16= variable 1
 406 acc16+ constant 0
 407 acc8= unstack8
 408 acc8CompareAcc16
 409 brle 398
 410 ;test10.j(137)     // integer - byte
 411 ;test10.j(138)     i=61;
 412 acc8= constant 61
 413 acc8=> variable 1
 414 ;test10.j(139)     b=62;
 415 acc8= constant 62
 416 acc8=> variable 0
 417 ;test10.j(140)     do { println (i); i++; } while (i+0 <= b+0);
 418 acc16= variable 1
 419 call writeLineAcc16
 420 incr16 variable 1
 421 acc16= variable 1
 422 acc16+ constant 0
 423 <acc16
 424 acc8= variable 0
 425 acc8+ constant 0
 426 acc16= unstack16
 427 acc16CompareAcc8
 428 brle 418
 429 ;test10.j(141)     // integer - integer
 430 ;test10.j(142)     b=63;
 431 acc8= constant 63
 432 acc8=> variable 0
 433 ;test10.j(143)     i=1063;
 434 acc16= constant 1063
 435 acc16=> variable 1
 436 ;test10.j(144)     do { println (b); b++; i--; } while (1000+62 <= i+0);
 437 acc8= variable 0
 438 call writeLineAcc8
 439 incr8 variable 0
 440 decr16 variable 1
 441 acc16= constant 1000
 442 acc16+ constant 62
 443 <acc16
 444 acc16= variable 1
 445 acc16+ constant 0
 446 revAcc16Comp unstack16
 447 brge 437
 448 ;test10.j(145)   
 449 ;test10.j(146)     /************************/
 450 ;test10.j(147)     // acc - var
 451 ;test10.j(148)     // byte - byte
 452 ;test10.j(149)     b=65;
 453 acc8= constant 65
 454 acc8=> variable 0
 455 ;test10.j(150)     i=65;
 456 acc8= constant 65
 457 acc8=> variable 1
 458 ;test10.j(151)     do { println (i); i++; b--; } while (64+0 <= b);
 459 acc16= variable 1
 460 call writeLineAcc16
 461 incr16 variable 1
 462 decr8 variable 0
 463 acc8= constant 64
 464 acc8+ constant 0
 465 acc8Comp variable 0
 466 brle 459
 467 ;test10.j(152)     // byte - integer
 468 ;test10.j(153)     b=67;
 469 acc8= constant 67
 470 acc8=> variable 0
 471 ;test10.j(154)     i=67;
 472 acc8= constant 67
 473 acc8=> variable 1
 474 ;test10.j(155)     do { println (b); b++; i--; } while (66+0 <= i);
 475 acc8= variable 0
 476 call writeLineAcc8
 477 incr8 variable 0
 478 decr16 variable 1
 479 acc8= constant 66
 480 acc8+ constant 0
 481 acc16= variable 1
 482 acc8CompareAcc16
 483 brle 475
 484 ;test10.j(156)     // integer - byte
 485 ;test10.j(157)     i=69;
 486 acc8= constant 69
 487 acc8=> variable 1
 488 ;test10.j(158)     b=69;
 489 acc8= constant 69
 490 acc8=> variable 0
 491 ;test10.j(159)     do { println (i); i++; b--; } while (1000+68 <= b);
 492 acc16= variable 1
 493 call writeLineAcc16
 494 incr16 variable 1
 495 decr8 variable 0
 496 acc16= constant 1000
 497 acc16+ constant 68
 498 acc8= variable 0
 499 acc16CompareAcc8
 500 brle 492
 501 ;test10.j(160)     // integer - integer
 502 ;test10.j(161)     i=1071;
 503 acc16= constant 1071
 504 acc16=> variable 1
 505 ;test10.j(162)     b=70;
 506 acc8= constant 70
 507 acc8=> variable 0
 508 ;test10.j(163)     do { println (b); b++; i--; } while (1000+70 <= i);
 509 acc8= variable 0
 510 call writeLineAcc8
 511 incr8 variable 0
 512 decr16 variable 1
 513 acc16= constant 1000
 514 acc16+ constant 70
 515 acc16Comp variable 1
 516 brle 509
 517 ;test10.j(164)   
 518 ;test10.j(165)     /************************/
 519 ;test10.j(166)     // acc - stack16
 520 ;test10.j(167)     // byte - byte
 521 ;test10.j(168)     //TODO
 522 ;test10.j(169)     println(72);
 523 acc8= constant 72
 524 call writeLineAcc8
 525 ;test10.j(170)     println(73);
 526 acc8= constant 73
 527 call writeLineAcc8
 528 ;test10.j(171)     // byte - integer
 529 ;test10.j(172)     //TODO
 530 ;test10.j(173)     println(74);
 531 acc8= constant 74
 532 call writeLineAcc8
 533 ;test10.j(174)     println(75);
 534 acc8= constant 75
 535 call writeLineAcc8
 536 ;test10.j(175)     // integer - byte
 537 ;test10.j(176)     //TODO
 538 ;test10.j(177)     println(76);
 539 acc8= constant 76
 540 call writeLineAcc8
 541 ;test10.j(178)     println(77);
 542 acc8= constant 77
 543 call writeLineAcc8
 544 ;test10.j(179)     // integer - integer
 545 ;test10.j(180)     //TODO
 546 ;test10.j(181)     println(78);
 547 acc8= constant 78
 548 call writeLineAcc8
 549 ;test10.j(182)     println(79);
 550 acc8= constant 79
 551 call writeLineAcc8
 552 ;test10.j(183)   
 553 ;test10.j(184)     /************************/
 554 ;test10.j(185)     // acc - stack8
 555 ;test10.j(186)     // byte - byte
 556 ;test10.j(187)     //TODO
 557 ;test10.j(188)     println(80);
 558 acc8= constant 80
 559 call writeLineAcc8
 560 ;test10.j(189)     println(81);
 561 acc8= constant 81
 562 call writeLineAcc8
 563 ;test10.j(190)     // byte - integer
 564 ;test10.j(191)     //TODO
 565 ;test10.j(192)     println(82);
 566 acc8= constant 82
 567 call writeLineAcc8
 568 ;test10.j(193)     println(83);
 569 acc8= constant 83
 570 call writeLineAcc8
 571 ;test10.j(194)     // integer - byte
 572 ;test10.j(195)     //TODO
 573 ;test10.j(196)     println(84);
 574 acc8= constant 84
 575 call writeLineAcc8
 576 ;test10.j(197)     println(85);
 577 acc8= constant 85
 578 call writeLineAcc8
 579 ;test10.j(198)     // integer - integer
 580 ;test10.j(199)     //TODO
 581 ;test10.j(200)     println(86);
 582 acc8= constant 86
 583 call writeLineAcc8
 584 ;test10.j(201)     println(87);
 585 acc8= constant 87
 586 call writeLineAcc8
 587 ;test10.j(202)   
 588 ;test10.j(203)     /************************/
 589 ;test10.j(204)     // var - constant
 590 ;test10.j(205)     // byte - byte
 591 ;test10.j(206)     b=88;
 592 acc8= constant 88
 593 acc8=> variable 0
 594 ;test10.j(207)     do { println (b); b++; } while (b <= 89);
 595 acc8= variable 0
 596 call writeLineAcc8
 597 incr8 variable 0
 598 acc8= variable 0
 599 acc8Comp constant 89
 600 brle 595
 601 ;test10.j(208)     // byte - integer
 602 ;test10.j(209)     //not relevant
 603 ;test10.j(210)     println(90);
 604 acc8= constant 90
 605 call writeLineAcc8
 606 ;test10.j(211)     println(91);
 607 acc8= constant 91
 608 call writeLineAcc8
 609 ;test10.j(212)     // integer - byte
 610 ;test10.j(213)     i=92;
 611 acc8= constant 92
 612 acc8=> variable 1
 613 ;test10.j(214)     do { println (i); i++; } while (i <= 93);
 614 acc16= variable 1
 615 call writeLineAcc16
 616 incr16 variable 1
 617 acc16= variable 1
 618 acc8= constant 93
 619 acc16CompareAcc8
 620 brle 614
 621 ;test10.j(215)     // integer - integer
 622 ;test10.j(216)     i=1094;
 623 acc16= constant 1094
 624 acc16=> variable 1
 625 ;test10.j(217)     b=94;
 626 acc8= constant 94
 627 acc8=> variable 0
 628 ;test10.j(218)     do { println (b); b++; i++; } while (i <= 1095  );
 629 acc8= variable 0
 630 call writeLineAcc8
 631 incr8 variable 0
 632 incr16 variable 1
 633 acc16= variable 1
 634 acc16Comp constant 1095
 635 brle 629
 636 ;test10.j(219)   
 637 ;test10.j(220)     /************************/
 638 ;test10.j(221)     // var - acc
 639 ;test10.j(222)     // byte - byte
 640 ;test10.j(223)     do { println (b); b++; } while (b <= 97+0);
 641 acc8= variable 0
 642 call writeLineAcc8
 643 incr8 variable 0
 644 acc8= constant 97
 645 acc8+ constant 0
 646 acc8Comp variable 0
 647 brge 641
 648 ;test10.j(224)     // byte - integer
 649 ;test10.j(225)     //not relevant
 650 ;test10.j(226)     i=99;
 651 acc8= constant 99
 652 acc8=> variable 1
 653 ;test10.j(227)     do { println (b); b++; } while (b <= i+0);
 654 acc8= variable 0
 655 call writeLineAcc8
 656 incr8 variable 0
 657 acc16= variable 1
 658 acc16+ constant 0
 659 acc8= variable 0
 660 acc8CompareAcc16
 661 brle 654
 662 ;test10.j(228)     // integer - byte
 663 ;test10.j(229)     i=100;
 664 acc8= constant 100
 665 acc8=> variable 1
 666 ;test10.j(230)     do { println (i); i++; } while (i <= 101+0);
 667 acc16= variable 1
 668 call writeLineAcc16
 669 incr16 variable 1
 670 acc8= constant 101
 671 acc8+ constant 0
 672 acc16= variable 1
 673 acc16CompareAcc8
 674 brle 667
 675 ;test10.j(231)     // integer - integer
 676 ;test10.j(232)     i=1102;
 677 acc16= constant 1102
 678 acc16=> variable 1
 679 ;test10.j(233)     b=102;
 680 acc8= constant 102
 681 acc8=> variable 0
 682 ;test10.j(234)     do { println (b); b++; i++; } while (i <= 1103+0);
 683 acc8= variable 0
 684 call writeLineAcc8
 685 incr8 variable 0
 686 incr16 variable 1
 687 acc16= constant 1103
 688 acc16+ constant 0
 689 acc16Comp variable 1
 690 brge 683
 691 ;test10.j(235)   
 692 ;test10.j(236)     /************************/
 693 ;test10.j(237)     // var - var
 694 ;test10.j(238)     // byte - byte
 695 ;test10.j(239)     byte b2 = 105;
 696 acc8= constant 105
 697 acc8=> variable 5
 698 ;test10.j(240)     do { println (b); b++; } while (b <= b2);
 699 acc8= variable 0
 700 call writeLineAcc8
 701 incr8 variable 0
 702 acc8= variable 0
 703 acc8Comp variable 5
 704 brle 699
 705 ;test10.j(241)     // byte - integer
 706 ;test10.j(242)     i=107;
 707 acc8= constant 107
 708 acc8=> variable 1
 709 ;test10.j(243)     do { println (b); b++; } while (b <= i);
 710 acc8= variable 0
 711 call writeLineAcc8
 712 incr8 variable 0
 713 acc8= variable 0
 714 acc16= variable 1
 715 acc8CompareAcc16
 716 brle 710
 717 ;test10.j(244)     // integer - byte
 718 ;test10.j(245)     i=b;
 719 acc8= variable 0
 720 acc8=> variable 1
 721 ;test10.j(246)     b=109;
 722 acc8= constant 109
 723 acc8=> variable 0
 724 ;test10.j(247)     do { println (i); i++; } while (i <= b);
 725 acc16= variable 1
 726 call writeLineAcc16
 727 incr16 variable 1
 728 acc16= variable 1
 729 acc8= variable 0
 730 acc16CompareAcc8
 731 brle 725
 732 ;test10.j(248)     // integer - integer
 733 ;test10.j(249)     word i2 = 111;
 734 acc8= constant 111
 735 acc8=> variable 6
 736 ;test10.j(250)     do { println (i); i++; } while (i <= i2);
 737 acc16= variable 1
 738 call writeLineAcc16
 739 incr16 variable 1
 740 acc16= variable 1
 741 acc16Comp variable 6
 742 brle 737
 743 ;test10.j(251)   
 744 ;test10.j(252)     /************************/
 745 ;test10.j(253)     // var - stack8
 746 ;test10.j(254)     // byte - byte
 747 ;test10.j(255)     // byte - integer
 748 ;test10.j(256)     // integer - byte
 749 ;test10.j(257)     // integer - integer
 750 ;test10.j(258)     //TODO
 751 ;test10.j(259)   
 752 ;test10.j(260)     /************************/
 753 ;test10.j(261)     // var - stack16
 754 ;test10.j(262)     // byte - byte
 755 ;test10.j(263)     // byte - integer
 756 ;test10.j(264)     // integer - byte
 757 ;test10.j(265)     // integer - integer
 758 ;test10.j(266)     //TODO
 759 ;test10.j(267)   
 760 ;test10.j(268)     /************************/
 761 ;test10.j(269)     // stack8 - constant
 762 ;test10.j(270)     // stack8 - acc
 763 ;test10.j(271)     // stack8 - var
 764 ;test10.j(272)     // stack8 - stack8
 765 ;test10.j(273)     // stack8 - stack16
 766 ;test10.j(274)     //TODO
 767 ;test10.j(275)   
 768 ;test10.j(276)     /************************/
 769 ;test10.j(277)     // stack16 - constant
 770 ;test10.j(278)     // stack16 - acc
 771 ;test10.j(279)     // stack16 - var
 772 ;test10.j(280)     // stack16 - stack8
 773 ;test10.j(281)     // stack16 - stack16
 774 ;test10.j(282)     //TODO
 775 ;test10.j(283)   
 776 ;test10.j(284)     println("Klaar");
 777 acc16= constant 782
 778 writeLineString
 779 ;test10.j(285)   }
 780 ;test10.j(286) }
 781 stop
 782 stringConstant 0 = "Klaar"
