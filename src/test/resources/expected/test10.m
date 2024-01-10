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
  13 ;test10.j(7)     println(0);
  14 acc8= constant 0
  15 call writeLineAcc8
  16 ;test10.j(8)   
  17 ;test10.j(9)     /************************/
  18 ;test10.j(10)     // global variable within do scope
  19 ;test10.j(11)     println (b);
  20 acc8= variable 0
  21 call writeLineAcc8
  22 ;test10.j(12)     b++;
  23 incr8 variable 0
  24 ;test10.j(13)     do {
  25 ;test10.j(14)       word j = 1001;
  26 acc16= constant 1001
  27 acc16=> variable 5
  28 ;test10.j(15)       byte c = b;
  29 acc8= variable 0
  30 acc8=> variable 7
  31 ;test10.j(16)       byte d = c;
  32 acc8= variable 7
  33 acc8=> variable 8
  34 ;test10.j(17)       b++;
  35 incr8 variable 0
  36 ;test10.j(18)       println (c);
  37 acc8= variable 7
  38 call writeLineAcc8
  39 ;test10.j(19)     } while (b<2);
  40 acc8= variable 0
  41 acc8Comp constant 2
  42 brlt 25
  43 ;test10.j(20)   
  44 ;test10.j(21)     /************************/
  45 ;test10.j(22)     // constant - constant
  46 ;test10.j(23)     // not relevant
  47 ;test10.j(24)   
  48 ;test10.j(25)     /************************/
  49 ;test10.j(26)     // constant - acc
  50 ;test10.j(27)     // byte - byte
  51 ;test10.j(28)     do { println (b); b++; } while (103 == b+100);
  52 acc8= variable 0
  53 call writeLineAcc8
  54 incr8 variable 0
  55 acc8= variable 0
  56 acc8+ constant 100
  57 acc8Comp constant 103
  58 breq 52
  59 ;test10.j(29)     do { println (b); b++; } while (106 != b+100);
  60 acc8= variable 0
  61 call writeLineAcc8
  62 incr8 variable 0
  63 acc8= variable 0
  64 acc8+ constant 100
  65 acc8Comp constant 106
  66 brne 60
  67 ;test10.j(30)     do { println (b); b++; } while (108 >  b+100);
  68 acc8= variable 0
  69 call writeLineAcc8
  70 incr8 variable 0
  71 acc8= variable 0
  72 acc8+ constant 100
  73 acc8Comp constant 108
  74 brlt 68
  75 ;test10.j(31)     do { println (b); b++; } while (109 >= b+100);
  76 acc8= variable 0
  77 call writeLineAcc8
  78 incr8 variable 0
  79 acc8= variable 0
  80 acc8+ constant 100
  81 acc8Comp constant 109
  82 brle 76
  83 ;test10.j(32)     p=10;
  84 acc8= constant 10
  85 acc8=> variable 3
  86 ;test10.j(33)     do { println (p); p++; b--; } while (108 <  b+100);
  87 acc16= variable 3
  88 call writeLineAcc16
  89 incr16 variable 3
  90 decr8 variable 0
  91 acc8= variable 0
  92 acc8+ constant 100
  93 acc8Comp constant 108
  94 brgt 87
  95 ;test10.j(34)     do { println (p); p++; b--; } while (107 <= b+100);
  96 acc16= variable 3
  97 call writeLineAcc16
  98 incr16 variable 3
  99 decr8 variable 0
 100 acc8= variable 0
 101 acc8+ constant 100
 102 acc8Comp constant 107
 103 brge 96
 104 ;test10.j(35)   
 105 ;test10.j(36)     // constant - acc
 106 ;test10.j(37)     // byte - integer
 107 ;test10.j(38)     i=14;
 108 acc8= constant 14
 109 acc8=> variable 1
 110 ;test10.j(39)     do { println (i); i++; } while (15 == i+0);
 111 acc16= variable 1
 112 call writeLineAcc16
 113 incr16 variable 1
 114 acc16= variable 1
 115 acc16+ constant 0
 116 acc8= constant 15
 117 acc8CompareAcc16
 118 breq 111
 119 ;test10.j(40)     do { println (i); i++; } while (18 != i+0);
 120 acc16= variable 1
 121 call writeLineAcc16
 122 incr16 variable 1
 123 acc16= variable 1
 124 acc16+ constant 0
 125 acc8= constant 18
 126 acc8CompareAcc16
 127 brne 120
 128 ;test10.j(41)     do { println (i); i++; } while (20 >  i+0);
 129 acc16= variable 1
 130 call writeLineAcc16
 131 incr16 variable 1
 132 acc16= variable 1
 133 acc16+ constant 0
 134 acc8= constant 20
 135 acc8CompareAcc16
 136 brgt 129
 137 ;test10.j(42)     do { println (i); i++; } while (21 >= i+0);
 138 acc16= variable 1
 139 call writeLineAcc16
 140 incr16 variable 1
 141 acc16= variable 1
 142 acc16+ constant 0
 143 acc8= constant 21
 144 acc8CompareAcc16
 145 brge 138
 146 ;test10.j(43)     p=22;
 147 acc8= constant 22
 148 acc8=> variable 3
 149 ;test10.j(44)     do { println (p); p++; i--; } while (20 <  i+0);
 150 acc16= variable 3
 151 call writeLineAcc16
 152 incr16 variable 3
 153 decr16 variable 1
 154 acc16= variable 1
 155 acc16+ constant 0
 156 acc8= constant 20
 157 acc8CompareAcc16
 158 brlt 150
 159 ;test10.j(45)     do { println (p); p++; i--; } while (19 <= i+0);
 160 acc16= variable 3
 161 call writeLineAcc16
 162 incr16 variable 3
 163 decr16 variable 1
 164 acc16= variable 1
 165 acc16+ constant 0
 166 acc8= constant 19
 167 acc8CompareAcc16
 168 brle 160
 169 ;test10.j(46)   
 170 ;test10.j(47)     // constant - acc
 171 ;test10.j(48)     // integer - byte
 172 ;test10.j(49)     // not relevant
 173 ;test10.j(50)   
 174 ;test10.j(51)     // constant - acc
 175 ;test10.j(52)     // integer - integer
 176 ;test10.j(53)     i=p;
 177 acc16= variable 3
 178 acc16=> variable 1
 179 ;test10.j(54)     do { println (i); i++; } while (1027 == i+1000);
 180 acc16= variable 1
 181 call writeLineAcc16
 182 incr16 variable 1
 183 acc16= variable 1
 184 acc16+ constant 1000
 185 acc16Comp constant 1027
 186 breq 180
 187 ;test10.j(55)     do { println (i); i++; } while (1029 != i+1000);
 188 acc16= variable 1
 189 call writeLineAcc16
 190 incr16 variable 1
 191 acc16= variable 1
 192 acc16+ constant 1000
 193 acc16Comp constant 1029
 194 brne 188
 195 ;test10.j(56)     do { println (i); i++; } while (1031 >  i+1000);
 196 acc16= variable 1
 197 call writeLineAcc16
 198 incr16 variable 1
 199 acc16= variable 1
 200 acc16+ constant 1000
 201 acc16Comp constant 1031
 202 brlt 196
 203 ;test10.j(57)     do { println (i); i++; } while (1032 >= i+1000);
 204 acc16= variable 1
 205 call writeLineAcc16
 206 incr16 variable 1
 207 acc16= variable 1
 208 acc16+ constant 1000
 209 acc16Comp constant 1032
 210 brle 204
 211 ;test10.j(58)     p=i;
 212 acc16= variable 1
 213 acc16=> variable 3
 214 ;test10.j(59)     do { println (p); p++; i--; } while (1031 <  i+1000);
 215 acc16= variable 3
 216 call writeLineAcc16
 217 incr16 variable 3
 218 decr16 variable 1
 219 acc16= variable 1
 220 acc16+ constant 1000
 221 acc16Comp constant 1031
 222 brgt 215
 223 ;test10.j(60)     do { println (p); p++; i--; } while (1030 <= i+1000);
 224 acc16= variable 3
 225 call writeLineAcc16
 226 incr16 variable 3
 227 decr16 variable 1
 228 acc16= variable 1
 229 acc16+ constant 1000
 230 acc16Comp constant 1030
 231 brge 224
 232 ;test10.j(61)   
 233 ;test10.j(62)     /************************/
 234 ;test10.j(63)     // constant - var
 235 ;test10.j(64)     // byte - byte
 236 ;test10.j(65)     b=37;
 237 acc8= constant 37
 238 acc8=> variable 0
 239 ;test10.j(66)     do { println (b); b++; } while (38 >= b);
 240 acc8= variable 0
 241 call writeLineAcc8
 242 incr8 variable 0
 243 acc8= variable 0
 244 acc8Comp constant 38
 245 brle 240
 246 ;test10.j(67)     // byte - integer
 247 ;test10.j(68)     i=39;
 248 acc8= constant 39
 249 acc8=> variable 1
 250 ;test10.j(69)     do { println (i); i++; } while (40 >= i);
 251 acc16= variable 1
 252 call writeLineAcc16
 253 incr16 variable 1
 254 acc16= variable 1
 255 acc8= constant 40
 256 acc8CompareAcc16
 257 brge 251
 258 ;test10.j(70)     // integer - byte
 259 ;test10.j(71)     // not relevant
 260 ;test10.j(72)     // integer - integer
 261 ;test10.j(73)     i=1038;
 262 acc16= constant 1038
 263 acc16=> variable 1
 264 ;test10.j(74)     b=41;
 265 acc8= constant 41
 266 acc8=> variable 0
 267 ;test10.j(75)     do { println (b); b++; i--; } while (1037 <= i);
 268 acc8= variable 0
 269 call writeLineAcc8
 270 incr8 variable 0
 271 decr16 variable 1
 272 acc16= variable 1
 273 acc16Comp constant 1037
 274 brge 268
 275 ;test10.j(76)   
 276 ;test10.j(77)     /************************/
 277 ;test10.j(78)     // constant - stack8
 278 ;test10.j(79)     // byte - byte
 279 ;test10.j(80)     //TODO
 280 ;test10.j(81)     println(43);
 281 acc8= constant 43
 282 call writeLineAcc8
 283 ;test10.j(82)     // constant - stack8
 284 ;test10.j(83)     // byte - integer
 285 ;test10.j(84)     //TODO
 286 ;test10.j(85)     println(44);
 287 acc8= constant 44
 288 call writeLineAcc8
 289 ;test10.j(86)     // constant - stack8
 290 ;test10.j(87)     // integer - byte
 291 ;test10.j(88)     //TODO
 292 ;test10.j(89)     println(45);
 293 acc8= constant 45
 294 call writeLineAcc8
 295 ;test10.j(90)     // constant - stack88
 296 ;test10.j(91)     // integer - integer
 297 ;test10.j(92)     //TODO
 298 ;test10.j(93)     println(46);
 299 acc8= constant 46
 300 call writeLineAcc8
 301 ;test10.j(94)   
 302 ;test10.j(95)     /************************/
 303 ;test10.j(96)     // constant - stack16
 304 ;test10.j(97)     // byte - byte
 305 ;test10.j(98)     //TODO
 306 ;test10.j(99)     println(47);
 307 acc8= constant 47
 308 call writeLineAcc8
 309 ;test10.j(100)     // constant - stack16
 310 ;test10.j(101)     // byte - integer
 311 ;test10.j(102)     //TODO
 312 ;test10.j(103)     println(48);
 313 acc8= constant 48
 314 call writeLineAcc8
 315 ;test10.j(104)     // constant - stack16
 316 ;test10.j(105)     // integer - byte
 317 ;test10.j(106)     //TODO
 318 ;test10.j(107)     println(49);
 319 acc8= constant 49
 320 call writeLineAcc8
 321 ;test10.j(108)     // constant - stack16
 322 ;test10.j(109)     // integer - integer
 323 ;test10.j(110)     //TODO
 324 ;test10.j(111)     println(50);
 325 acc8= constant 50
 326 call writeLineAcc8
 327 ;test10.j(112)   
 328 ;test10.j(113)     /************************/
 329 ;test10.j(114)     // acc - constant
 330 ;test10.j(115)     // byte - byte
 331 ;test10.j(116)     b=51;
 332 acc8= constant 51
 333 acc8=> variable 0
 334 ;test10.j(117)     do { println (b); b++; } while (b+0 <= 52);
 335 acc8= variable 0
 336 call writeLineAcc8
 337 incr8 variable 0
 338 acc8= variable 0
 339 acc8+ constant 0
 340 acc8Comp constant 52
 341 brle 335
 342 ;test10.j(118)     // byte - integer
 343 ;test10.j(119)     //not relevant
 344 ;test10.j(120)     // integer - byte
 345 ;test10.j(121)     i=53;
 346 acc8= constant 53
 347 acc8=> variable 1
 348 ;test10.j(122)     do { println (i); i++; } while (i+0 <= 54);
 349 acc16= variable 1
 350 call writeLineAcc16
 351 incr16 variable 1
 352 acc16= variable 1
 353 acc16+ constant 0
 354 acc8= constant 54
 355 acc16CompareAcc8
 356 brle 349
 357 ;test10.j(123)   
 358 ;test10.j(124)     b=55;
 359 acc8= constant 55
 360 acc8=> variable 0
 361 ;test10.j(125)     i=1055;
 362 acc16= constant 1055
 363 acc16=> variable 1
 364 ;test10.j(126)     // integer - integer
 365 ;test10.j(127)     do { println (b); b++; i++; } while (i+0 <= 1056);
 366 acc8= variable 0
 367 call writeLineAcc8
 368 incr8 variable 0
 369 incr16 variable 1
 370 acc16= variable 1
 371 acc16+ constant 0
 372 acc16Comp constant 1056
 373 brle 366
 374 ;test10.j(128)   
 375 ;test10.j(129)     /************************/
 376 ;test10.j(130)     // acc - acc
 377 ;test10.j(131)     // byte - byte
 378 ;test10.j(132)     b=57;
 379 acc8= constant 57
 380 acc8=> variable 0
 381 ;test10.j(133)     do { println (b); b++; } while (b+0 <= 58+0);
 382 acc8= variable 0
 383 call writeLineAcc8
 384 incr8 variable 0
 385 acc8= variable 0
 386 acc8+ constant 0
 387 <acc8
 388 acc8= constant 58
 389 acc8+ constant 0
 390 revAcc8Comp unstack8
 391 brge 382
 392 ;test10.j(134)     // byte - integer
 393 ;test10.j(135)     i=61;
 394 acc8= constant 61
 395 acc8=> variable 1
 396 ;test10.j(136)     do { println (b); b++; i--; } while (60+0 <= i+0);
 397 acc8= variable 0
 398 call writeLineAcc8
 399 incr8 variable 0
 400 decr16 variable 1
 401 acc8= constant 60
 402 acc8+ constant 0
 403 <acc8
 404 acc16= variable 1
 405 acc16+ constant 0
 406 acc8= unstack8
 407 acc8CompareAcc16
 408 brle 397
 409 ;test10.j(137)     // integer - byte
 410 ;test10.j(138)     i=61;
 411 acc8= constant 61
 412 acc8=> variable 1
 413 ;test10.j(139)     b=62;
 414 acc8= constant 62
 415 acc8=> variable 0
 416 ;test10.j(140)     do { println (i); i++; } while (i+0 <= b+0);
 417 acc16= variable 1
 418 call writeLineAcc16
 419 incr16 variable 1
 420 acc16= variable 1
 421 acc16+ constant 0
 422 <acc16
 423 acc8= variable 0
 424 acc8+ constant 0
 425 acc16= unstack16
 426 acc16CompareAcc8
 427 brle 417
 428 ;test10.j(141)     // integer - integer
 429 ;test10.j(142)     b=63;
 430 acc8= constant 63
 431 acc8=> variable 0
 432 ;test10.j(143)     i=1063;
 433 acc16= constant 1063
 434 acc16=> variable 1
 435 ;test10.j(144)     do { println (b); b++; i--; } while (1000+62 <= i+0);
 436 acc8= variable 0
 437 call writeLineAcc8
 438 incr8 variable 0
 439 decr16 variable 1
 440 acc16= constant 1000
 441 acc16+ constant 62
 442 <acc16
 443 acc16= variable 1
 444 acc16+ constant 0
 445 revAcc16Comp unstack16
 446 brge 436
 447 ;test10.j(145)   
 448 ;test10.j(146)     /************************/
 449 ;test10.j(147)     // acc - var
 450 ;test10.j(148)     // byte - byte
 451 ;test10.j(149)     b=65;
 452 acc8= constant 65
 453 acc8=> variable 0
 454 ;test10.j(150)     i=65;
 455 acc8= constant 65
 456 acc8=> variable 1
 457 ;test10.j(151)     do { println (i); i++; b--; } while (64+0 <= b);
 458 acc16= variable 1
 459 call writeLineAcc16
 460 incr16 variable 1
 461 decr8 variable 0
 462 acc8= constant 64
 463 acc8+ constant 0
 464 acc8Comp variable 0
 465 brle 458
 466 ;test10.j(152)     // byte - integer
 467 ;test10.j(153)     b=67;
 468 acc8= constant 67
 469 acc8=> variable 0
 470 ;test10.j(154)     i=67;
 471 acc8= constant 67
 472 acc8=> variable 1
 473 ;test10.j(155)     do { println (b); b++; i--; } while (66+0 <= i);
 474 acc8= variable 0
 475 call writeLineAcc8
 476 incr8 variable 0
 477 decr16 variable 1
 478 acc8= constant 66
 479 acc8+ constant 0
 480 acc16= variable 1
 481 acc8CompareAcc16
 482 brle 474
 483 ;test10.j(156)     // integer - byte
 484 ;test10.j(157)     i=69;
 485 acc8= constant 69
 486 acc8=> variable 1
 487 ;test10.j(158)     b=69;
 488 acc8= constant 69
 489 acc8=> variable 0
 490 ;test10.j(159)     do { println (i); i++; b--; } while (1000+68 <= b);
 491 acc16= variable 1
 492 call writeLineAcc16
 493 incr16 variable 1
 494 decr8 variable 0
 495 acc16= constant 1000
 496 acc16+ constant 68
 497 acc8= variable 0
 498 acc16CompareAcc8
 499 brle 491
 500 ;test10.j(160)     // integer - integer
 501 ;test10.j(161)     i=1071;
 502 acc16= constant 1071
 503 acc16=> variable 1
 504 ;test10.j(162)     b=70;
 505 acc8= constant 70
 506 acc8=> variable 0
 507 ;test10.j(163)     do { println (b); b++; i--; } while (1000+70 <= i);
 508 acc8= variable 0
 509 call writeLineAcc8
 510 incr8 variable 0
 511 decr16 variable 1
 512 acc16= constant 1000
 513 acc16+ constant 70
 514 acc16Comp variable 1
 515 brle 508
 516 ;test10.j(164)   
 517 ;test10.j(165)     /************************/
 518 ;test10.j(166)     // acc - stack16
 519 ;test10.j(167)     // byte - byte
 520 ;test10.j(168)     //TODO
 521 ;test10.j(169)     println(72);
 522 acc8= constant 72
 523 call writeLineAcc8
 524 ;test10.j(170)     println(73);
 525 acc8= constant 73
 526 call writeLineAcc8
 527 ;test10.j(171)     // byte - integer
 528 ;test10.j(172)     //TODO
 529 ;test10.j(173)     println(74);
 530 acc8= constant 74
 531 call writeLineAcc8
 532 ;test10.j(174)     println(75);
 533 acc8= constant 75
 534 call writeLineAcc8
 535 ;test10.j(175)     // integer - byte
 536 ;test10.j(176)     //TODO
 537 ;test10.j(177)     println(76);
 538 acc8= constant 76
 539 call writeLineAcc8
 540 ;test10.j(178)     println(77);
 541 acc8= constant 77
 542 call writeLineAcc8
 543 ;test10.j(179)     // integer - integer
 544 ;test10.j(180)     //TODO
 545 ;test10.j(181)     println(78);
 546 acc8= constant 78
 547 call writeLineAcc8
 548 ;test10.j(182)     println(79);
 549 acc8= constant 79
 550 call writeLineAcc8
 551 ;test10.j(183)   
 552 ;test10.j(184)     /************************/
 553 ;test10.j(185)     // acc - stack8
 554 ;test10.j(186)     // byte - byte
 555 ;test10.j(187)     //TODO
 556 ;test10.j(188)     println(80);
 557 acc8= constant 80
 558 call writeLineAcc8
 559 ;test10.j(189)     println(81);
 560 acc8= constant 81
 561 call writeLineAcc8
 562 ;test10.j(190)     // byte - integer
 563 ;test10.j(191)     //TODO
 564 ;test10.j(192)     println(82);
 565 acc8= constant 82
 566 call writeLineAcc8
 567 ;test10.j(193)     println(83);
 568 acc8= constant 83
 569 call writeLineAcc8
 570 ;test10.j(194)     // integer - byte
 571 ;test10.j(195)     //TODO
 572 ;test10.j(196)     println(84);
 573 acc8= constant 84
 574 call writeLineAcc8
 575 ;test10.j(197)     println(85);
 576 acc8= constant 85
 577 call writeLineAcc8
 578 ;test10.j(198)     // integer - integer
 579 ;test10.j(199)     //TODO
 580 ;test10.j(200)     println(86);
 581 acc8= constant 86
 582 call writeLineAcc8
 583 ;test10.j(201)     println(87);
 584 acc8= constant 87
 585 call writeLineAcc8
 586 ;test10.j(202)   
 587 ;test10.j(203)     /************************/
 588 ;test10.j(204)     // var - constant
 589 ;test10.j(205)     // byte - byte
 590 ;test10.j(206)     b=88;
 591 acc8= constant 88
 592 acc8=> variable 0
 593 ;test10.j(207)     do { println (b); b++; } while (b <= 89);
 594 acc8= variable 0
 595 call writeLineAcc8
 596 incr8 variable 0
 597 acc8= variable 0
 598 acc8Comp constant 89
 599 brle 594
 600 ;test10.j(208)     // byte - integer
 601 ;test10.j(209)     //not relevant
 602 ;test10.j(210)     println(90);
 603 acc8= constant 90
 604 call writeLineAcc8
 605 ;test10.j(211)     println(91);
 606 acc8= constant 91
 607 call writeLineAcc8
 608 ;test10.j(212)     // integer - byte
 609 ;test10.j(213)     i=92;
 610 acc8= constant 92
 611 acc8=> variable 1
 612 ;test10.j(214)     do { println (i); i++; } while (i <= 93);
 613 acc16= variable 1
 614 call writeLineAcc16
 615 incr16 variable 1
 616 acc16= variable 1
 617 acc8= constant 93
 618 acc16CompareAcc8
 619 brle 613
 620 ;test10.j(215)     // integer - integer
 621 ;test10.j(216)     i=1094;
 622 acc16= constant 1094
 623 acc16=> variable 1
 624 ;test10.j(217)     b=94;
 625 acc8= constant 94
 626 acc8=> variable 0
 627 ;test10.j(218)     do { println (b); b++; i++; } while (i <= 1095  );
 628 acc8= variable 0
 629 call writeLineAcc8
 630 incr8 variable 0
 631 incr16 variable 1
 632 acc16= variable 1
 633 acc16Comp constant 1095
 634 brle 628
 635 ;test10.j(219)   
 636 ;test10.j(220)     /************************/
 637 ;test10.j(221)     // var - acc
 638 ;test10.j(222)     // byte - byte
 639 ;test10.j(223)     do { println (b); b++; } while (b <= 97+0);
 640 acc8= variable 0
 641 call writeLineAcc8
 642 incr8 variable 0
 643 acc8= constant 97
 644 acc8+ constant 0
 645 acc8Comp variable 0
 646 brge 640
 647 ;test10.j(224)     // byte - integer
 648 ;test10.j(225)     //not relevant
 649 ;test10.j(226)     i=99;
 650 acc8= constant 99
 651 acc8=> variable 1
 652 ;test10.j(227)     do { println (b); b++; } while (b <= i+0);
 653 acc8= variable 0
 654 call writeLineAcc8
 655 incr8 variable 0
 656 acc16= variable 1
 657 acc16+ constant 0
 658 acc8= variable 0
 659 acc8CompareAcc16
 660 brle 653
 661 ;test10.j(228)     // integer - byte
 662 ;test10.j(229)     i=100;
 663 acc8= constant 100
 664 acc8=> variable 1
 665 ;test10.j(230)     do { println (i); i++; } while (i <= 101+0);
 666 acc16= variable 1
 667 call writeLineAcc16
 668 incr16 variable 1
 669 acc8= constant 101
 670 acc8+ constant 0
 671 acc16= variable 1
 672 acc16CompareAcc8
 673 brle 666
 674 ;test10.j(231)     // integer - integer
 675 ;test10.j(232)     i=1102;
 676 acc16= constant 1102
 677 acc16=> variable 1
 678 ;test10.j(233)     b=102;
 679 acc8= constant 102
 680 acc8=> variable 0
 681 ;test10.j(234)     do { println (b); b++; i++; } while (i <= 1103+0);
 682 acc8= variable 0
 683 call writeLineAcc8
 684 incr8 variable 0
 685 incr16 variable 1
 686 acc16= constant 1103
 687 acc16+ constant 0
 688 acc16Comp variable 1
 689 brge 682
 690 ;test10.j(235)   
 691 ;test10.j(236)     /************************/
 692 ;test10.j(237)     // var - var
 693 ;test10.j(238)     // byte - byte
 694 ;test10.j(239)     byte b2 = 105;
 695 acc8= constant 105
 696 acc8=> variable 5
 697 ;test10.j(240)     do { println (b); b++; } while (b <= b2);
 698 acc8= variable 0
 699 call writeLineAcc8
 700 incr8 variable 0
 701 acc8= variable 0
 702 acc8Comp variable 5
 703 brle 698
 704 ;test10.j(241)     // byte - integer
 705 ;test10.j(242)     i=107;
 706 acc8= constant 107
 707 acc8=> variable 1
 708 ;test10.j(243)     do { println (b); b++; } while (b <= i);
 709 acc8= variable 0
 710 call writeLineAcc8
 711 incr8 variable 0
 712 acc8= variable 0
 713 acc16= variable 1
 714 acc8CompareAcc16
 715 brle 709
 716 ;test10.j(244)     // integer - byte
 717 ;test10.j(245)     i=b;
 718 acc8= variable 0
 719 acc8=> variable 1
 720 ;test10.j(246)     b=109;
 721 acc8= constant 109
 722 acc8=> variable 0
 723 ;test10.j(247)     do { println (i); i++; } while (i <= b);
 724 acc16= variable 1
 725 call writeLineAcc16
 726 incr16 variable 1
 727 acc16= variable 1
 728 acc8= variable 0
 729 acc16CompareAcc8
 730 brle 724
 731 ;test10.j(248)     // integer - integer
 732 ;test10.j(249)     word i2 = 111;
 733 acc8= constant 111
 734 acc8=> variable 6
 735 ;test10.j(250)     do { println (i); i++; } while (i <= i2);
 736 acc16= variable 1
 737 call writeLineAcc16
 738 incr16 variable 1
 739 acc16= variable 1
 740 acc16Comp variable 6
 741 brle 736
 742 ;test10.j(251)   
 743 ;test10.j(252)     /************************/
 744 ;test10.j(253)     // var - stack8
 745 ;test10.j(254)     // byte - byte
 746 ;test10.j(255)     // byte - integer
 747 ;test10.j(256)     // integer - byte
 748 ;test10.j(257)     // integer - integer
 749 ;test10.j(258)     //TODO
 750 ;test10.j(259)   
 751 ;test10.j(260)     /************************/
 752 ;test10.j(261)     // var - stack16
 753 ;test10.j(262)     // byte - byte
 754 ;test10.j(263)     // byte - integer
 755 ;test10.j(264)     // integer - byte
 756 ;test10.j(265)     // integer - integer
 757 ;test10.j(266)     //TODO
 758 ;test10.j(267)   
 759 ;test10.j(268)     /************************/
 760 ;test10.j(269)     // stack8 - constant
 761 ;test10.j(270)     // stack8 - acc
 762 ;test10.j(271)     // stack8 - var
 763 ;test10.j(272)     // stack8 - stack8
 764 ;test10.j(273)     // stack8 - stack16
 765 ;test10.j(274)     //TODO
 766 ;test10.j(275)   
 767 ;test10.j(276)     /************************/
 768 ;test10.j(277)     // stack16 - constant
 769 ;test10.j(278)     // stack16 - acc
 770 ;test10.j(279)     // stack16 - var
 771 ;test10.j(280)     // stack16 - stack8
 772 ;test10.j(281)     // stack16 - stack16
 773 ;test10.j(282)     //TODO
 774 ;test10.j(283)   
 775 ;test10.j(284)     println("Klaar");
 776 acc16= constant 781
 777 writeLineString
 778 ;test10.j(285)   }
 779 ;test10.j(286) }
 780 stop
 781 stringConstant 0 = "Klaar"
