   0 call 16
   1 stop
   2 ;test10.j(0) /* Program to test generated Z80 assembler code */
   3 ;test10.j(1) class TestDo {
   4 class TestDo []
   5 ;test10.j(2)   private static byte b = 1;
   6 acc8= constant 1
   7 acc8=> variable 0
   8 ;test10.j(3)   private static word i = 12;
   9 acc8= constant 12
  10 acc8=> variable 1
  11 ;test10.j(4)   private static word p = 12;
  12 acc8= constant 12
  13 acc8=> variable 3
  14 ;test10.j(5) 
  15 ;test10.j(6)   public static void main() {
  16 method main [public, static] void
  17 ;test10.j(7)     println(0);
  18 acc8= constant 0
  19 call writeLineAcc8
  20 ;test10.j(8)   
  21 ;test10.j(9)     /************************/
  22 ;test10.j(10)     // global variable within do scope
  23 ;test10.j(11)     println (b);
  24 acc8= variable 0
  25 call writeLineAcc8
  26 ;test10.j(12)     b++;
  27 incr8 variable 0
  28 ;test10.j(13)     do {
  29 ;test10.j(14)       word j = 1001;
  30 acc16= constant 1001
  31 acc16=> variable 5
  32 ;test10.j(15)       byte c = b;
  33 acc8= variable 0
  34 acc8=> variable 7
  35 ;test10.j(16)       byte d = c;
  36 acc8= variable 7
  37 acc8=> variable 8
  38 ;test10.j(17)       b++;
  39 incr8 variable 0
  40 ;test10.j(18)       println (c);
  41 acc8= variable 7
  42 call writeLineAcc8
  43 ;test10.j(19)     } while (b<2);
  44 acc8= variable 0
  45 acc8Comp constant 2
  46 brlt 29
  47 ;test10.j(20)   
  48 ;test10.j(21)     /************************/
  49 ;test10.j(22)     // constant - constant
  50 ;test10.j(23)     // not relevant
  51 ;test10.j(24)   
  52 ;test10.j(25)     /************************/
  53 ;test10.j(26)     // constant - acc
  54 ;test10.j(27)     // byte - byte
  55 ;test10.j(28)     do { println (b); b++; } while (103 == b+100);
  56 acc8= variable 0
  57 call writeLineAcc8
  58 incr8 variable 0
  59 acc8= variable 0
  60 acc8+ constant 100
  61 acc8Comp constant 103
  62 breq 56
  63 ;test10.j(29)     do { println (b); b++; } while (106 != b+100);
  64 acc8= variable 0
  65 call writeLineAcc8
  66 incr8 variable 0
  67 acc8= variable 0
  68 acc8+ constant 100
  69 acc8Comp constant 106
  70 brne 64
  71 ;test10.j(30)     do { println (b); b++; } while (108 >  b+100);
  72 acc8= variable 0
  73 call writeLineAcc8
  74 incr8 variable 0
  75 acc8= variable 0
  76 acc8+ constant 100
  77 acc8Comp constant 108
  78 brlt 72
  79 ;test10.j(31)     do { println (b); b++; } while (109 >= b+100);
  80 acc8= variable 0
  81 call writeLineAcc8
  82 incr8 variable 0
  83 acc8= variable 0
  84 acc8+ constant 100
  85 acc8Comp constant 109
  86 brle 80
  87 ;test10.j(32)     p=10;
  88 acc8= constant 10
  89 acc8=> variable 3
  90 ;test10.j(33)     do { println (p); p++; b--; } while (108 <  b+100);
  91 acc16= variable 3
  92 call writeLineAcc16
  93 incr16 variable 3
  94 decr8 variable 0
  95 acc8= variable 0
  96 acc8+ constant 100
  97 acc8Comp constant 108
  98 brgt 91
  99 ;test10.j(34)     do { println (p); p++; b--; } while (107 <= b+100);
 100 acc16= variable 3
 101 call writeLineAcc16
 102 incr16 variable 3
 103 decr8 variable 0
 104 acc8= variable 0
 105 acc8+ constant 100
 106 acc8Comp constant 107
 107 brge 100
 108 ;test10.j(35)   
 109 ;test10.j(36)     // constant - acc
 110 ;test10.j(37)     // byte - integer
 111 ;test10.j(38)     i=14;
 112 acc8= constant 14
 113 acc8=> variable 1
 114 ;test10.j(39)     do { println (i); i++; } while (15 == i+0);
 115 acc16= variable 1
 116 call writeLineAcc16
 117 incr16 variable 1
 118 acc16= variable 1
 119 acc16+ constant 0
 120 acc8= constant 15
 121 acc8CompareAcc16
 122 breq 115
 123 ;test10.j(40)     do { println (i); i++; } while (18 != i+0);
 124 acc16= variable 1
 125 call writeLineAcc16
 126 incr16 variable 1
 127 acc16= variable 1
 128 acc16+ constant 0
 129 acc8= constant 18
 130 acc8CompareAcc16
 131 brne 124
 132 ;test10.j(41)     do { println (i); i++; } while (20 >  i+0);
 133 acc16= variable 1
 134 call writeLineAcc16
 135 incr16 variable 1
 136 acc16= variable 1
 137 acc16+ constant 0
 138 acc8= constant 20
 139 acc8CompareAcc16
 140 brgt 133
 141 ;test10.j(42)     do { println (i); i++; } while (21 >= i+0);
 142 acc16= variable 1
 143 call writeLineAcc16
 144 incr16 variable 1
 145 acc16= variable 1
 146 acc16+ constant 0
 147 acc8= constant 21
 148 acc8CompareAcc16
 149 brge 142
 150 ;test10.j(43)     p=22;
 151 acc8= constant 22
 152 acc8=> variable 3
 153 ;test10.j(44)     do { println (p); p++; i--; } while (20 <  i+0);
 154 acc16= variable 3
 155 call writeLineAcc16
 156 incr16 variable 3
 157 decr16 variable 1
 158 acc16= variable 1
 159 acc16+ constant 0
 160 acc8= constant 20
 161 acc8CompareAcc16
 162 brlt 154
 163 ;test10.j(45)     do { println (p); p++; i--; } while (19 <= i+0);
 164 acc16= variable 3
 165 call writeLineAcc16
 166 incr16 variable 3
 167 decr16 variable 1
 168 acc16= variable 1
 169 acc16+ constant 0
 170 acc8= constant 19
 171 acc8CompareAcc16
 172 brle 164
 173 ;test10.j(46)   
 174 ;test10.j(47)     // constant - acc
 175 ;test10.j(48)     // integer - byte
 176 ;test10.j(49)     // not relevant
 177 ;test10.j(50)   
 178 ;test10.j(51)     // constant - acc
 179 ;test10.j(52)     // integer - integer
 180 ;test10.j(53)     i=p;
 181 acc16= variable 3
 182 acc16=> variable 1
 183 ;test10.j(54)     do { println (i); i++; } while (1027 == i+1000);
 184 acc16= variable 1
 185 call writeLineAcc16
 186 incr16 variable 1
 187 acc16= variable 1
 188 acc16+ constant 1000
 189 acc16Comp constant 1027
 190 breq 184
 191 ;test10.j(55)     do { println (i); i++; } while (1029 != i+1000);
 192 acc16= variable 1
 193 call writeLineAcc16
 194 incr16 variable 1
 195 acc16= variable 1
 196 acc16+ constant 1000
 197 acc16Comp constant 1029
 198 brne 192
 199 ;test10.j(56)     do { println (i); i++; } while (1031 >  i+1000);
 200 acc16= variable 1
 201 call writeLineAcc16
 202 incr16 variable 1
 203 acc16= variable 1
 204 acc16+ constant 1000
 205 acc16Comp constant 1031
 206 brlt 200
 207 ;test10.j(57)     do { println (i); i++; } while (1032 >= i+1000);
 208 acc16= variable 1
 209 call writeLineAcc16
 210 incr16 variable 1
 211 acc16= variable 1
 212 acc16+ constant 1000
 213 acc16Comp constant 1032
 214 brle 208
 215 ;test10.j(58)     p=i;
 216 acc16= variable 1
 217 acc16=> variable 3
 218 ;test10.j(59)     do { println (p); p++; i--; } while (1031 <  i+1000);
 219 acc16= variable 3
 220 call writeLineAcc16
 221 incr16 variable 3
 222 decr16 variable 1
 223 acc16= variable 1
 224 acc16+ constant 1000
 225 acc16Comp constant 1031
 226 brgt 219
 227 ;test10.j(60)     do { println (p); p++; i--; } while (1030 <= i+1000);
 228 acc16= variable 3
 229 call writeLineAcc16
 230 incr16 variable 3
 231 decr16 variable 1
 232 acc16= variable 1
 233 acc16+ constant 1000
 234 acc16Comp constant 1030
 235 brge 228
 236 ;test10.j(61)   
 237 ;test10.j(62)     /************************/
 238 ;test10.j(63)     // constant - var
 239 ;test10.j(64)     // byte - byte
 240 ;test10.j(65)     b=37;
 241 acc8= constant 37
 242 acc8=> variable 0
 243 ;test10.j(66)     do { println (b); b++; } while (38 >= b);
 244 acc8= variable 0
 245 call writeLineAcc8
 246 incr8 variable 0
 247 acc8= variable 0
 248 acc8Comp constant 38
 249 brle 244
 250 ;test10.j(67)     // byte - integer
 251 ;test10.j(68)     i=39;
 252 acc8= constant 39
 253 acc8=> variable 1
 254 ;test10.j(69)     do { println (i); i++; } while (40 >= i);
 255 acc16= variable 1
 256 call writeLineAcc16
 257 incr16 variable 1
 258 acc16= variable 1
 259 acc8= constant 40
 260 acc8CompareAcc16
 261 brge 255
 262 ;test10.j(70)     // integer - byte
 263 ;test10.j(71)     // not relevant
 264 ;test10.j(72)     // integer - integer
 265 ;test10.j(73)     i=1038;
 266 acc16= constant 1038
 267 acc16=> variable 1
 268 ;test10.j(74)     b=41;
 269 acc8= constant 41
 270 acc8=> variable 0
 271 ;test10.j(75)     do { println (b); b++; i--; } while (1037 <= i);
 272 acc8= variable 0
 273 call writeLineAcc8
 274 incr8 variable 0
 275 decr16 variable 1
 276 acc16= variable 1
 277 acc16Comp constant 1037
 278 brge 272
 279 ;test10.j(76)   
 280 ;test10.j(77)     /************************/
 281 ;test10.j(78)     // constant - stack8
 282 ;test10.j(79)     // byte - byte
 283 ;test10.j(80)     //TODO
 284 ;test10.j(81)     println(43);
 285 acc8= constant 43
 286 call writeLineAcc8
 287 ;test10.j(82)     // constant - stack8
 288 ;test10.j(83)     // byte - integer
 289 ;test10.j(84)     //TODO
 290 ;test10.j(85)     println(44);
 291 acc8= constant 44
 292 call writeLineAcc8
 293 ;test10.j(86)     // constant - stack8
 294 ;test10.j(87)     // integer - byte
 295 ;test10.j(88)     //TODO
 296 ;test10.j(89)     println(45);
 297 acc8= constant 45
 298 call writeLineAcc8
 299 ;test10.j(90)     // constant - stack88
 300 ;test10.j(91)     // integer - integer
 301 ;test10.j(92)     //TODO
 302 ;test10.j(93)     println(46);
 303 acc8= constant 46
 304 call writeLineAcc8
 305 ;test10.j(94)   
 306 ;test10.j(95)     /************************/
 307 ;test10.j(96)     // constant - stack16
 308 ;test10.j(97)     // byte - byte
 309 ;test10.j(98)     //TODO
 310 ;test10.j(99)     println(47);
 311 acc8= constant 47
 312 call writeLineAcc8
 313 ;test10.j(100)     // constant - stack16
 314 ;test10.j(101)     // byte - integer
 315 ;test10.j(102)     //TODO
 316 ;test10.j(103)     println(48);
 317 acc8= constant 48
 318 call writeLineAcc8
 319 ;test10.j(104)     // constant - stack16
 320 ;test10.j(105)     // integer - byte
 321 ;test10.j(106)     //TODO
 322 ;test10.j(107)     println(49);
 323 acc8= constant 49
 324 call writeLineAcc8
 325 ;test10.j(108)     // constant - stack16
 326 ;test10.j(109)     // integer - integer
 327 ;test10.j(110)     //TODO
 328 ;test10.j(111)     println(50);
 329 acc8= constant 50
 330 call writeLineAcc8
 331 ;test10.j(112)   
 332 ;test10.j(113)     /************************/
 333 ;test10.j(114)     // acc - constant
 334 ;test10.j(115)     // byte - byte
 335 ;test10.j(116)     b=51;
 336 acc8= constant 51
 337 acc8=> variable 0
 338 ;test10.j(117)     do { println (b); b++; } while (b+0 <= 52);
 339 acc8= variable 0
 340 call writeLineAcc8
 341 incr8 variable 0
 342 acc8= variable 0
 343 acc8+ constant 0
 344 acc8Comp constant 52
 345 brle 339
 346 ;test10.j(118)     // byte - integer
 347 ;test10.j(119)     //not relevant
 348 ;test10.j(120)     // integer - byte
 349 ;test10.j(121)     i=53;
 350 acc8= constant 53
 351 acc8=> variable 1
 352 ;test10.j(122)     do { println (i); i++; } while (i+0 <= 54);
 353 acc16= variable 1
 354 call writeLineAcc16
 355 incr16 variable 1
 356 acc16= variable 1
 357 acc16+ constant 0
 358 acc8= constant 54
 359 acc16CompareAcc8
 360 brle 355
 361 ;test10.j(123)   
 362 ;test10.j(124)     b=55;
 363 acc8= constant 55
 364 acc8=> variable 0
 365 ;test10.j(125)     i=1055;
 366 acc16= constant 1055
 367 acc16=> variable 1
 368 ;test10.j(126)     // integer - integer
 369 ;test10.j(127)     do { println (b); b++; i++; } while (i+0 <= 1056);
 370 acc8= variable 0
 371 call writeLineAcc8
 372 incr8 variable 0
 373 incr16 variable 1
 374 acc16= variable 1
 375 acc16+ constant 0
 376 acc16Comp constant 1056
 377 brle 374
 378 ;test10.j(128)   
 379 ;test10.j(129)     /************************/
 380 ;test10.j(130)     // acc - acc
 381 ;test10.j(131)     // byte - byte
 382 ;test10.j(132)     b=57;
 383 acc8= constant 57
 384 acc8=> variable 0
 385 ;test10.j(133)     do { println (b); b++; } while (b+0 <= 58+0);
 386 acc8= variable 0
 387 call writeLineAcc8
 388 incr8 variable 0
 389 acc8= variable 0
 390 acc8+ constant 0
 391 <acc8
 392 acc8= constant 58
 393 acc8+ constant 0
 394 revAcc8Comp unstack8
 395 brge 392
 396 ;test10.j(134)     // byte - integer
 397 ;test10.j(135)     i=61;
 398 acc8= constant 61
 399 acc8=> variable 1
 400 ;test10.j(136)     do { println (b); b++; i--; } while (60+0 <= i+0);
 401 acc8= variable 0
 402 call writeLineAcc8
 403 incr8 variable 0
 404 decr16 variable 1
 405 acc8= constant 60
 406 acc8+ constant 0
 407 <acc8
 408 acc16= variable 1
 409 acc16+ constant 0
 410 acc8= unstack8
 411 acc8CompareAcc16
 412 brle 407
 413 ;test10.j(137)     // integer - byte
 414 ;test10.j(138)     i=61;
 415 acc8= constant 61
 416 acc8=> variable 1
 417 ;test10.j(139)     b=62;
 418 acc8= constant 62
 419 acc8=> variable 0
 420 ;test10.j(140)     do { println (i); i++; } while (i+0 <= b+0);
 421 acc16= variable 1
 422 call writeLineAcc16
 423 incr16 variable 1
 424 acc16= variable 1
 425 acc16+ constant 0
 426 <acc16
 427 acc8= variable 0
 428 acc8+ constant 0
 429 acc16= unstack16
 430 acc16CompareAcc8
 431 brle 427
 432 ;test10.j(141)     // integer - integer
 433 ;test10.j(142)     b=63;
 434 acc8= constant 63
 435 acc8=> variable 0
 436 ;test10.j(143)     i=1063;
 437 acc16= constant 1063
 438 acc16=> variable 1
 439 ;test10.j(144)     do { println (b); b++; i--; } while (1000+62 <= i+0);
 440 acc8= variable 0
 441 call writeLineAcc8
 442 incr8 variable 0
 443 decr16 variable 1
 444 acc16= constant 1000
 445 acc16+ constant 62
 446 <acc16
 447 acc16= variable 1
 448 acc16+ constant 0
 449 revAcc16Comp unstack16
 450 brge 446
 451 ;test10.j(145)   
 452 ;test10.j(146)     /************************/
 453 ;test10.j(147)     // acc - var
 454 ;test10.j(148)     // byte - byte
 455 ;test10.j(149)     b=65;
 456 acc8= constant 65
 457 acc8=> variable 0
 458 ;test10.j(150)     i=65;
 459 acc8= constant 65
 460 acc8=> variable 1
 461 ;test10.j(151)     do { println (i); i++; b--; } while (64+0 <= b);
 462 acc16= variable 1
 463 call writeLineAcc16
 464 incr16 variable 1
 465 decr8 variable 0
 466 acc8= constant 64
 467 acc8+ constant 0
 468 acc8Comp variable 0
 469 brle 468
 470 ;test10.j(152)     // byte - integer
 471 ;test10.j(153)     b=67;
 472 acc8= constant 67
 473 acc8=> variable 0
 474 ;test10.j(154)     i=67;
 475 acc8= constant 67
 476 acc8=> variable 1
 477 ;test10.j(155)     do { println (b); b++; i--; } while (66+0 <= i);
 478 acc8= variable 0
 479 call writeLineAcc8
 480 incr8 variable 0
 481 decr16 variable 1
 482 acc8= constant 66
 483 acc8+ constant 0
 484 acc16= variable 1
 485 acc8CompareAcc16
 486 brle 486
 487 ;test10.j(156)     // integer - byte
 488 ;test10.j(157)     i=69;
 489 acc8= constant 69
 490 acc8=> variable 1
 491 ;test10.j(158)     b=69;
 492 acc8= constant 69
 493 acc8=> variable 0
 494 ;test10.j(159)     do { println (i); i++; b--; } while (1000+68 <= b);
 495 acc16= variable 1
 496 call writeLineAcc16
 497 incr16 variable 1
 498 decr8 variable 0
 499 acc16= constant 1000
 500 acc16+ constant 68
 501 acc8= variable 0
 502 acc16CompareAcc8
 503 brle 505
 504 ;test10.j(160)     // integer - integer
 505 ;test10.j(161)     i=1071;
 506 acc16= constant 1071
 507 acc16=> variable 1
 508 ;test10.j(162)     b=70;
 509 acc8= constant 70
 510 acc8=> variable 0
 511 ;test10.j(163)     do { println (b); b++; i--; } while (1000+70 <= i);
 512 acc8= variable 0
 513 call writeLineAcc8
 514 incr8 variable 0
 515 decr16 variable 1
 516 acc16= constant 1000
 517 acc16+ constant 70
 518 acc16Comp variable 1
 519 brle 524
 520 ;test10.j(164)   
 521 ;test10.j(165)     /************************/
 522 ;test10.j(166)     // acc - stack16
 523 ;test10.j(167)     // byte - byte
 524 ;test10.j(168)     //TODO
 525 ;test10.j(169)     println(72);
 526 acc8= constant 72
 527 call writeLineAcc8
 528 ;test10.j(170)     println(73);
 529 acc8= constant 73
 530 call writeLineAcc8
 531 ;test10.j(171)     // byte - integer
 532 ;test10.j(172)     //TODO
 533 ;test10.j(173)     println(74);
 534 acc8= constant 74
 535 call writeLineAcc8
 536 ;test10.j(174)     println(75);
 537 acc8= constant 75
 538 call writeLineAcc8
 539 ;test10.j(175)     // integer - byte
 540 ;test10.j(176)     //TODO
 541 ;test10.j(177)     println(76);
 542 acc8= constant 76
 543 call writeLineAcc8
 544 ;test10.j(178)     println(77);
 545 acc8= constant 77
 546 call writeLineAcc8
 547 ;test10.j(179)     // integer - integer
 548 ;test10.j(180)     //TODO
 549 ;test10.j(181)     println(78);
 550 acc8= constant 78
 551 call writeLineAcc8
 552 ;test10.j(182)     println(79);
 553 acc8= constant 79
 554 call writeLineAcc8
 555 ;test10.j(183)   
 556 ;test10.j(184)     /************************/
 557 ;test10.j(185)     // acc - stack8
 558 ;test10.j(186)     // byte - byte
 559 ;test10.j(187)     //TODO
 560 ;test10.j(188)     println(80);
 561 acc8= constant 80
 562 call writeLineAcc8
 563 ;test10.j(189)     println(81);
 564 acc8= constant 81
 565 call writeLineAcc8
 566 ;test10.j(190)     // byte - integer
 567 ;test10.j(191)     //TODO
 568 ;test10.j(192)     println(82);
 569 acc8= constant 82
 570 call writeLineAcc8
 571 ;test10.j(193)     println(83);
 572 acc8= constant 83
 573 call writeLineAcc8
 574 ;test10.j(194)     // integer - byte
 575 ;test10.j(195)     //TODO
 576 ;test10.j(196)     println(84);
 577 acc8= constant 84
 578 call writeLineAcc8
 579 ;test10.j(197)     println(85);
 580 acc8= constant 85
 581 call writeLineAcc8
 582 ;test10.j(198)     // integer - integer
 583 ;test10.j(199)     //TODO
 584 ;test10.j(200)     println(86);
 585 acc8= constant 86
 586 call writeLineAcc8
 587 ;test10.j(201)     println(87);
 588 acc8= constant 87
 589 call writeLineAcc8
 590 ;test10.j(202)   
 591 ;test10.j(203)     /************************/
 592 ;test10.j(204)     // var - constant
 593 ;test10.j(205)     // byte - byte
 594 ;test10.j(206)     b=88;
 595 acc8= constant 88
 596 acc8=> variable 0
 597 ;test10.j(207)     do { println (b); b++; } while (b <= 89);
 598 acc8= variable 0
 599 call writeLineAcc8
 600 incr8 variable 0
 601 acc8= variable 0
 602 acc8Comp constant 89
 603 brle 612
 604 ;test10.j(208)     // byte - integer
 605 ;test10.j(209)     //not relevant
 606 ;test10.j(210)     println(90);
 607 acc8= constant 90
 608 call writeLineAcc8
 609 ;test10.j(211)     println(91);
 610 acc8= constant 91
 611 call writeLineAcc8
 612 ;test10.j(212)     // integer - byte
 613 ;test10.j(213)     i=92;
 614 acc8= constant 92
 615 acc8=> variable 1
 616 ;test10.j(214)     do { println (i); i++; } while (i <= 93);
 617 acc16= variable 1
 618 call writeLineAcc16
 619 incr16 variable 1
 620 acc16= variable 1
 621 acc8= constant 93
 622 acc16CompareAcc8
 623 brle 631
 624 ;test10.j(215)     // integer - integer
 625 ;test10.j(216)     i=1094;
 626 acc16= constant 1094
 627 acc16=> variable 1
 628 ;test10.j(217)     b=94;
 629 acc8= constant 94
 630 acc8=> variable 0
 631 ;test10.j(218)     do { println (b); b++; i++; } while (i <= 1095  );
 632 acc8= variable 0
 633 call writeLineAcc8
 634 incr8 variable 0
 635 incr16 variable 1
 636 acc16= variable 1
 637 acc16Comp constant 1095
 638 brle 646
 639 ;test10.j(219)   
 640 ;test10.j(220)     /************************/
 641 ;test10.j(221)     // var - acc
 642 ;test10.j(222)     // byte - byte
 643 ;test10.j(223)     do { println (b); b++; } while (b <= 97+0);
 644 acc8= variable 0
 645 call writeLineAcc8
 646 incr8 variable 0
 647 acc8= constant 97
 648 acc8+ constant 0
 649 acc8Comp variable 0
 650 brge 658
 651 ;test10.j(224)     // byte - integer
 652 ;test10.j(225)     //not relevant
 653 ;test10.j(226)     i=99;
 654 acc8= constant 99
 655 acc8=> variable 1
 656 ;test10.j(227)     do { println (b); b++; } while (b <= i+0);
 657 acc8= variable 0
 658 call writeLineAcc8
 659 incr8 variable 0
 660 acc16= variable 1
 661 acc16+ constant 0
 662 acc8= variable 0
 663 acc8CompareAcc16
 664 brle 671
 665 ;test10.j(228)     // integer - byte
 666 ;test10.j(229)     i=100;
 667 acc8= constant 100
 668 acc8=> variable 1
 669 ;test10.j(230)     do { println (i); i++; } while (i <= 101+0);
 670 acc16= variable 1
 671 call writeLineAcc16
 672 incr16 variable 1
 673 acc8= constant 101
 674 acc8+ constant 0
 675 acc16= variable 1
 676 acc16CompareAcc8
 677 brle 684
 678 ;test10.j(231)     // integer - integer
 679 ;test10.j(232)     i=1102;
 680 acc16= constant 1102
 681 acc16=> variable 1
 682 ;test10.j(233)     b=102;
 683 acc8= constant 102
 684 acc8=> variable 0
 685 ;test10.j(234)     do { println (b); b++; i++; } while (i <= 1103+0);
 686 acc8= variable 0
 687 call writeLineAcc8
 688 incr8 variable 0
 689 incr16 variable 1
 690 acc16= constant 1103
 691 acc16+ constant 0
 692 acc16Comp variable 1
 693 brge 700
 694 ;test10.j(235)   
 695 ;test10.j(236)     /************************/
 696 ;test10.j(237)     // var - var
 697 ;test10.j(238)     // byte - byte
 698 ;test10.j(239)     byte b2 = 105;
 699 acc8= constant 105
 700 acc8=> variable 5
 701 ;test10.j(240)     do { println (b); b++; } while (b <= b2);
 702 acc8= variable 0
 703 call writeLineAcc8
 704 incr8 variable 0
 705 acc8= variable 0
 706 acc8Comp variable 5
 707 brle 716
 708 ;test10.j(241)     // byte - integer
 709 ;test10.j(242)     i=107;
 710 acc8= constant 107
 711 acc8=> variable 1
 712 ;test10.j(243)     do { println (b); b++; } while (b <= i);
 713 acc8= variable 0
 714 call writeLineAcc8
 715 incr8 variable 0
 716 acc8= variable 0
 717 acc16= variable 1
 718 acc8CompareAcc16
 719 brle 727
 720 ;test10.j(244)     // integer - byte
 721 ;test10.j(245)     i=b;
 722 acc8= variable 0
 723 acc8=> variable 1
 724 ;test10.j(246)     b=109;
 725 acc8= constant 109
 726 acc8=> variable 0
 727 ;test10.j(247)     do { println (i); i++; } while (i <= b);
 728 acc16= variable 1
 729 call writeLineAcc16
 730 incr16 variable 1
 731 acc16= variable 1
 732 acc8= variable 0
 733 acc16CompareAcc8
 734 brle 742
 735 ;test10.j(248)     // integer - integer
 736 ;test10.j(249)     word i2 = 111;
 737 acc8= constant 111
 738 acc8=> variable 6
 739 ;test10.j(250)     do { println (i); i++; } while (i <= i2);
 740 acc16= variable 1
 741 call writeLineAcc16
 742 incr16 variable 1
 743 acc16= variable 1
 744 acc16Comp variable 6
 745 brle 754
 746 ;test10.j(251)   
 747 ;test10.j(252)     /************************/
 748 ;test10.j(253)     // var - stack8
 749 ;test10.j(254)     // byte - byte
 750 ;test10.j(255)     // byte - integer
 751 ;test10.j(256)     // integer - byte
 752 ;test10.j(257)     // integer - integer
 753 ;test10.j(258)     //TODO
 754 ;test10.j(259)   
 755 ;test10.j(260)     /************************/
 756 ;test10.j(261)     // var - stack16
 757 ;test10.j(262)     // byte - byte
 758 ;test10.j(263)     // byte - integer
 759 ;test10.j(264)     // integer - byte
 760 ;test10.j(265)     // integer - integer
 761 ;test10.j(266)     //TODO
 762 ;test10.j(267)   
 763 ;test10.j(268)     /************************/
 764 ;test10.j(269)     // stack8 - constant
 765 ;test10.j(270)     // stack8 - acc
 766 ;test10.j(271)     // stack8 - var
 767 ;test10.j(272)     // stack8 - stack8
 768 ;test10.j(273)     // stack8 - stack16
 769 ;test10.j(274)     //TODO
 770 ;test10.j(275)   
 771 ;test10.j(276)     /************************/
 772 ;test10.j(277)     // stack16 - constant
 773 ;test10.j(278)     // stack16 - acc
 774 ;test10.j(279)     // stack16 - var
 775 ;test10.j(280)     // stack16 - stack8
 776 ;test10.j(281)     // stack16 - stack16
 777 ;test10.j(282)     //TODO
 778 ;test10.j(283)   
 779 ;test10.j(284)     println("Klaar");
 780 acc16= stringconstant 785
 781 writeLineString
 782 return
 783 ;test10.j(285)   }
 784 ;test10.j(286) }
 785 stringConstant 0 = "Klaar"
