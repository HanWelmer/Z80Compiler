   0 ;test10.j(0) /* Program to test generated Z80 assembler code */
   1 ;test10.j(1) class TestDo {
   2 class TestDo []
   3 ;test10.j(2)   private static byte b = 1;
   4 acc8= constant 1
   5 acc8=> variable 0
   6 ;test10.j(3)   private static word i = 12;
   7 acc8= constant 12
   8 acc8=> variable 1
   9 ;test10.j(4)   private static word p = 12;
  10 acc8= constant 12
  11 acc8=> variable 3
  12 ;test10.j(5) 
  13 ;test10.j(6)   public static void main() {
  14 method main [static] void
  15 ;test10.j(7)     println(0);
  16 acc8= constant 0
  17 call writeLineAcc8
  18 ;test10.j(8)   
  19 ;test10.j(9)     /************************/
  20 ;test10.j(10)     // global variable within do scope
  21 ;test10.j(11)     println (b);
  22 acc8= variable 0
  23 call writeLineAcc8
  24 ;test10.j(12)     b++;
  25 incr8 variable 0
  26 ;test10.j(13)     do {
  27 ;test10.j(14)       word j = 1001;
  28 acc16= constant 1001
  29 acc16=> variable 5
  30 ;test10.j(15)       byte c = b;
  31 acc8= variable 0
  32 acc8=> variable 7
  33 ;test10.j(16)       byte d = c;
  34 acc8= variable 7
  35 acc8=> variable 8
  36 ;test10.j(17)       b++;
  37 incr8 variable 0
  38 ;test10.j(18)       println (c);
  39 acc8= variable 7
  40 call writeLineAcc8
  41 ;test10.j(19)     } while (b<2);
  42 acc8= variable 0
  43 acc8Comp constant 2
  44 brlt 27
  45 ;test10.j(20)   
  46 ;test10.j(21)     /************************/
  47 ;test10.j(22)     // constant - constant
  48 ;test10.j(23)     // not relevant
  49 ;test10.j(24)   
  50 ;test10.j(25)     /************************/
  51 ;test10.j(26)     // constant - acc
  52 ;test10.j(27)     // byte - byte
  53 ;test10.j(28)     do { println (b); b++; } while (103 == b+100);
  54 acc8= variable 0
  55 call writeLineAcc8
  56 incr8 variable 0
  57 acc8= variable 0
  58 acc8+ constant 100
  59 acc8Comp constant 103
  60 breq 54
  61 ;test10.j(29)     do { println (b); b++; } while (106 != b+100);
  62 acc8= variable 0
  63 call writeLineAcc8
  64 incr8 variable 0
  65 acc8= variable 0
  66 acc8+ constant 100
  67 acc8Comp constant 106
  68 brne 62
  69 ;test10.j(30)     do { println (b); b++; } while (108 >  b+100);
  70 acc8= variable 0
  71 call writeLineAcc8
  72 incr8 variable 0
  73 acc8= variable 0
  74 acc8+ constant 100
  75 acc8Comp constant 108
  76 brlt 70
  77 ;test10.j(31)     do { println (b); b++; } while (109 >= b+100);
  78 acc8= variable 0
  79 call writeLineAcc8
  80 incr8 variable 0
  81 acc8= variable 0
  82 acc8+ constant 100
  83 acc8Comp constant 109
  84 brle 78
  85 ;test10.j(32)     p=10;
  86 acc8= constant 10
  87 acc8=> variable 3
  88 ;test10.j(33)     do { println (p); p++; b--; } while (108 <  b+100);
  89 acc16= variable 3
  90 call writeLineAcc16
  91 incr16 variable 3
  92 decr8 variable 0
  93 acc8= variable 0
  94 acc8+ constant 100
  95 acc8Comp constant 108
  96 brgt 89
  97 ;test10.j(34)     do { println (p); p++; b--; } while (107 <= b+100);
  98 acc16= variable 3
  99 call writeLineAcc16
 100 incr16 variable 3
 101 decr8 variable 0
 102 acc8= variable 0
 103 acc8+ constant 100
 104 acc8Comp constant 107
 105 brge 98
 106 ;test10.j(35)   
 107 ;test10.j(36)     // constant - acc
 108 ;test10.j(37)     // byte - integer
 109 ;test10.j(38)     i=14;
 110 acc8= constant 14
 111 acc8=> variable 1
 112 ;test10.j(39)     do { println (i); i++; } while (15 == i+0);
 113 acc16= variable 1
 114 call writeLineAcc16
 115 incr16 variable 1
 116 acc16= variable 1
 117 acc16+ constant 0
 118 acc8= constant 15
 119 acc8CompareAcc16
 120 breq 113
 121 ;test10.j(40)     do { println (i); i++; } while (18 != i+0);
 122 acc16= variable 1
 123 call writeLineAcc16
 124 incr16 variable 1
 125 acc16= variable 1
 126 acc16+ constant 0
 127 acc8= constant 18
 128 acc8CompareAcc16
 129 brne 122
 130 ;test10.j(41)     do { println (i); i++; } while (20 >  i+0);
 131 acc16= variable 1
 132 call writeLineAcc16
 133 incr16 variable 1
 134 acc16= variable 1
 135 acc16+ constant 0
 136 acc8= constant 20
 137 acc8CompareAcc16
 138 brgt 131
 139 ;test10.j(42)     do { println (i); i++; } while (21 >= i+0);
 140 acc16= variable 1
 141 call writeLineAcc16
 142 incr16 variable 1
 143 acc16= variable 1
 144 acc16+ constant 0
 145 acc8= constant 21
 146 acc8CompareAcc16
 147 brge 140
 148 ;test10.j(43)     p=22;
 149 acc8= constant 22
 150 acc8=> variable 3
 151 ;test10.j(44)     do { println (p); p++; i--; } while (20 <  i+0);
 152 acc16= variable 3
 153 call writeLineAcc16
 154 incr16 variable 3
 155 decr16 variable 1
 156 acc16= variable 1
 157 acc16+ constant 0
 158 acc8= constant 20
 159 acc8CompareAcc16
 160 brlt 152
 161 ;test10.j(45)     do { println (p); p++; i--; } while (19 <= i+0);
 162 acc16= variable 3
 163 call writeLineAcc16
 164 incr16 variable 3
 165 decr16 variable 1
 166 acc16= variable 1
 167 acc16+ constant 0
 168 acc8= constant 19
 169 acc8CompareAcc16
 170 brle 162
 171 ;test10.j(46)   
 172 ;test10.j(47)     // constant - acc
 173 ;test10.j(48)     // integer - byte
 174 ;test10.j(49)     // not relevant
 175 ;test10.j(50)   
 176 ;test10.j(51)     // constant - acc
 177 ;test10.j(52)     // integer - integer
 178 ;test10.j(53)     i=p;
 179 acc16= variable 3
 180 acc16=> variable 1
 181 ;test10.j(54)     do { println (i); i++; } while (1027 == i+1000);
 182 acc16= variable 1
 183 call writeLineAcc16
 184 incr16 variable 1
 185 acc16= variable 1
 186 acc16+ constant 1000
 187 acc16Comp constant 1027
 188 breq 182
 189 ;test10.j(55)     do { println (i); i++; } while (1029 != i+1000);
 190 acc16= variable 1
 191 call writeLineAcc16
 192 incr16 variable 1
 193 acc16= variable 1
 194 acc16+ constant 1000
 195 acc16Comp constant 1029
 196 brne 190
 197 ;test10.j(56)     do { println (i); i++; } while (1031 >  i+1000);
 198 acc16= variable 1
 199 call writeLineAcc16
 200 incr16 variable 1
 201 acc16= variable 1
 202 acc16+ constant 1000
 203 acc16Comp constant 1031
 204 brlt 198
 205 ;test10.j(57)     do { println (i); i++; } while (1032 >= i+1000);
 206 acc16= variable 1
 207 call writeLineAcc16
 208 incr16 variable 1
 209 acc16= variable 1
 210 acc16+ constant 1000
 211 acc16Comp constant 1032
 212 brle 206
 213 ;test10.j(58)     p=i;
 214 acc16= variable 1
 215 acc16=> variable 3
 216 ;test10.j(59)     do { println (p); p++; i--; } while (1031 <  i+1000);
 217 acc16= variable 3
 218 call writeLineAcc16
 219 incr16 variable 3
 220 decr16 variable 1
 221 acc16= variable 1
 222 acc16+ constant 1000
 223 acc16Comp constant 1031
 224 brgt 217
 225 ;test10.j(60)     do { println (p); p++; i--; } while (1030 <= i+1000);
 226 acc16= variable 3
 227 call writeLineAcc16
 228 incr16 variable 3
 229 decr16 variable 1
 230 acc16= variable 1
 231 acc16+ constant 1000
 232 acc16Comp constant 1030
 233 brge 226
 234 ;test10.j(61)   
 235 ;test10.j(62)     /************************/
 236 ;test10.j(63)     // constant - var
 237 ;test10.j(64)     // byte - byte
 238 ;test10.j(65)     b=37;
 239 acc8= constant 37
 240 acc8=> variable 0
 241 ;test10.j(66)     do { println (b); b++; } while (38 >= b);
 242 acc8= variable 0
 243 call writeLineAcc8
 244 incr8 variable 0
 245 acc8= variable 0
 246 acc8Comp constant 38
 247 brle 242
 248 ;test10.j(67)     // byte - integer
 249 ;test10.j(68)     i=39;
 250 acc8= constant 39
 251 acc8=> variable 1
 252 ;test10.j(69)     do { println (i); i++; } while (40 >= i);
 253 acc16= variable 1
 254 call writeLineAcc16
 255 incr16 variable 1
 256 acc16= variable 1
 257 acc8= constant 40
 258 acc8CompareAcc16
 259 brge 253
 260 ;test10.j(70)     // integer - byte
 261 ;test10.j(71)     // not relevant
 262 ;test10.j(72)     // integer - integer
 263 ;test10.j(73)     i=1038;
 264 acc16= constant 1038
 265 acc16=> variable 1
 266 ;test10.j(74)     b=41;
 267 acc8= constant 41
 268 acc8=> variable 0
 269 ;test10.j(75)     do { println (b); b++; i--; } while (1037 <= i);
 270 acc8= variable 0
 271 call writeLineAcc8
 272 incr8 variable 0
 273 decr16 variable 1
 274 acc16= variable 1
 275 acc16Comp constant 1037
 276 brge 270
 277 ;test10.j(76)   
 278 ;test10.j(77)     /************************/
 279 ;test10.j(78)     // constant - stack8
 280 ;test10.j(79)     // byte - byte
 281 ;test10.j(80)     //TODO
 282 ;test10.j(81)     println(43);
 283 acc8= constant 43
 284 call writeLineAcc8
 285 ;test10.j(82)     // constant - stack8
 286 ;test10.j(83)     // byte - integer
 287 ;test10.j(84)     //TODO
 288 ;test10.j(85)     println(44);
 289 acc8= constant 44
 290 call writeLineAcc8
 291 ;test10.j(86)     // constant - stack8
 292 ;test10.j(87)     // integer - byte
 293 ;test10.j(88)     //TODO
 294 ;test10.j(89)     println(45);
 295 acc8= constant 45
 296 call writeLineAcc8
 297 ;test10.j(90)     // constant - stack88
 298 ;test10.j(91)     // integer - integer
 299 ;test10.j(92)     //TODO
 300 ;test10.j(93)     println(46);
 301 acc8= constant 46
 302 call writeLineAcc8
 303 ;test10.j(94)   
 304 ;test10.j(95)     /************************/
 305 ;test10.j(96)     // constant - stack16
 306 ;test10.j(97)     // byte - byte
 307 ;test10.j(98)     //TODO
 308 ;test10.j(99)     println(47);
 309 acc8= constant 47
 310 call writeLineAcc8
 311 ;test10.j(100)     // constant - stack16
 312 ;test10.j(101)     // byte - integer
 313 ;test10.j(102)     //TODO
 314 ;test10.j(103)     println(48);
 315 acc8= constant 48
 316 call writeLineAcc8
 317 ;test10.j(104)     // constant - stack16
 318 ;test10.j(105)     // integer - byte
 319 ;test10.j(106)     //TODO
 320 ;test10.j(107)     println(49);
 321 acc8= constant 49
 322 call writeLineAcc8
 323 ;test10.j(108)     // constant - stack16
 324 ;test10.j(109)     // integer - integer
 325 ;test10.j(110)     //TODO
 326 ;test10.j(111)     println(50);
 327 acc8= constant 50
 328 call writeLineAcc8
 329 ;test10.j(112)   
 330 ;test10.j(113)     /************************/
 331 ;test10.j(114)     // acc - constant
 332 ;test10.j(115)     // byte - byte
 333 ;test10.j(116)     b=51;
 334 acc8= constant 51
 335 acc8=> variable 0
 336 ;test10.j(117)     do { println (b); b++; } while (b+0 <= 52);
 337 acc8= variable 0
 338 call writeLineAcc8
 339 incr8 variable 0
 340 acc8= variable 0
 341 acc8+ constant 0
 342 acc8Comp constant 52
 343 brle 337
 344 ;test10.j(118)     // byte - integer
 345 ;test10.j(119)     //not relevant
 346 ;test10.j(120)     // integer - byte
 347 ;test10.j(121)     i=53;
 348 acc8= constant 53
 349 acc8=> variable 1
 350 ;test10.j(122)     do { println (i); i++; } while (i+0 <= 54);
 351 acc16= variable 1
 352 call writeLineAcc16
 353 incr16 variable 1
 354 acc16= variable 1
 355 acc16+ constant 0
 356 acc8= constant 54
 357 acc16CompareAcc8
 358 brle 351
 359 ;test10.j(123)   
 360 ;test10.j(124)     b=55;
 361 acc8= constant 55
 362 acc8=> variable 0
 363 ;test10.j(125)     i=1055;
 364 acc16= constant 1055
 365 acc16=> variable 1
 366 ;test10.j(126)     // integer - integer
 367 ;test10.j(127)     do { println (b); b++; i++; } while (i+0 <= 1056);
 368 acc8= variable 0
 369 call writeLineAcc8
 370 incr8 variable 0
 371 incr16 variable 1
 372 acc16= variable 1
 373 acc16+ constant 0
 374 acc16Comp constant 1056
 375 brle 368
 376 ;test10.j(128)   
 377 ;test10.j(129)     /************************/
 378 ;test10.j(130)     // acc - acc
 379 ;test10.j(131)     // byte - byte
 380 ;test10.j(132)     b=57;
 381 acc8= constant 57
 382 acc8=> variable 0
 383 ;test10.j(133)     do { println (b); b++; } while (b+0 <= 58+0);
 384 acc8= variable 0
 385 call writeLineAcc8
 386 incr8 variable 0
 387 acc8= variable 0
 388 acc8+ constant 0
 389 <acc8
 390 acc8= constant 58
 391 acc8+ constant 0
 392 revAcc8Comp unstack8
 393 brge 384
 394 ;test10.j(134)     // byte - integer
 395 ;test10.j(135)     i=61;
 396 acc8= constant 61
 397 acc8=> variable 1
 398 ;test10.j(136)     do { println (b); b++; i--; } while (60+0 <= i+0);
 399 acc8= variable 0
 400 call writeLineAcc8
 401 incr8 variable 0
 402 decr16 variable 1
 403 acc8= constant 60
 404 acc8+ constant 0
 405 <acc8
 406 acc16= variable 1
 407 acc16+ constant 0
 408 acc8= unstack8
 409 acc8CompareAcc16
 410 brle 399
 411 ;test10.j(137)     // integer - byte
 412 ;test10.j(138)     i=61;
 413 acc8= constant 61
 414 acc8=> variable 1
 415 ;test10.j(139)     b=62;
 416 acc8= constant 62
 417 acc8=> variable 0
 418 ;test10.j(140)     do { println (i); i++; } while (i+0 <= b+0);
 419 acc16= variable 1
 420 call writeLineAcc16
 421 incr16 variable 1
 422 acc16= variable 1
 423 acc16+ constant 0
 424 <acc16
 425 acc8= variable 0
 426 acc8+ constant 0
 427 acc16= unstack16
 428 acc16CompareAcc8
 429 brle 419
 430 ;test10.j(141)     // integer - integer
 431 ;test10.j(142)     b=63;
 432 acc8= constant 63
 433 acc8=> variable 0
 434 ;test10.j(143)     i=1063;
 435 acc16= constant 1063
 436 acc16=> variable 1
 437 ;test10.j(144)     do { println (b); b++; i--; } while (1000+62 <= i+0);
 438 acc8= variable 0
 439 call writeLineAcc8
 440 incr8 variable 0
 441 decr16 variable 1
 442 acc16= constant 1000
 443 acc16+ constant 62
 444 <acc16
 445 acc16= variable 1
 446 acc16+ constant 0
 447 revAcc16Comp unstack16
 448 brge 438
 449 ;test10.j(145)   
 450 ;test10.j(146)     /************************/
 451 ;test10.j(147)     // acc - var
 452 ;test10.j(148)     // byte - byte
 453 ;test10.j(149)     b=65;
 454 acc8= constant 65
 455 acc8=> variable 0
 456 ;test10.j(150)     i=65;
 457 acc8= constant 65
 458 acc8=> variable 1
 459 ;test10.j(151)     do { println (i); i++; b--; } while (64+0 <= b);
 460 acc16= variable 1
 461 call writeLineAcc16
 462 incr16 variable 1
 463 decr8 variable 0
 464 acc8= constant 64
 465 acc8+ constant 0
 466 acc8Comp variable 0
 467 brle 460
 468 ;test10.j(152)     // byte - integer
 469 ;test10.j(153)     b=67;
 470 acc8= constant 67
 471 acc8=> variable 0
 472 ;test10.j(154)     i=67;
 473 acc8= constant 67
 474 acc8=> variable 1
 475 ;test10.j(155)     do { println (b); b++; i--; } while (66+0 <= i);
 476 acc8= variable 0
 477 call writeLineAcc8
 478 incr8 variable 0
 479 decr16 variable 1
 480 acc8= constant 66
 481 acc8+ constant 0
 482 acc16= variable 1
 483 acc8CompareAcc16
 484 brle 476
 485 ;test10.j(156)     // integer - byte
 486 ;test10.j(157)     i=69;
 487 acc8= constant 69
 488 acc8=> variable 1
 489 ;test10.j(158)     b=69;
 490 acc8= constant 69
 491 acc8=> variable 0
 492 ;test10.j(159)     do { println (i); i++; b--; } while (1000+68 <= b);
 493 acc16= variable 1
 494 call writeLineAcc16
 495 incr16 variable 1
 496 decr8 variable 0
 497 acc16= constant 1000
 498 acc16+ constant 68
 499 acc8= variable 0
 500 acc16CompareAcc8
 501 brle 493
 502 ;test10.j(160)     // integer - integer
 503 ;test10.j(161)     i=1071;
 504 acc16= constant 1071
 505 acc16=> variable 1
 506 ;test10.j(162)     b=70;
 507 acc8= constant 70
 508 acc8=> variable 0
 509 ;test10.j(163)     do { println (b); b++; i--; } while (1000+70 <= i);
 510 acc8= variable 0
 511 call writeLineAcc8
 512 incr8 variable 0
 513 decr16 variable 1
 514 acc16= constant 1000
 515 acc16+ constant 70
 516 acc16Comp variable 1
 517 brle 510
 518 ;test10.j(164)   
 519 ;test10.j(165)     /************************/
 520 ;test10.j(166)     // acc - stack16
 521 ;test10.j(167)     // byte - byte
 522 ;test10.j(168)     //TODO
 523 ;test10.j(169)     println(72);
 524 acc8= constant 72
 525 call writeLineAcc8
 526 ;test10.j(170)     println(73);
 527 acc8= constant 73
 528 call writeLineAcc8
 529 ;test10.j(171)     // byte - integer
 530 ;test10.j(172)     //TODO
 531 ;test10.j(173)     println(74);
 532 acc8= constant 74
 533 call writeLineAcc8
 534 ;test10.j(174)     println(75);
 535 acc8= constant 75
 536 call writeLineAcc8
 537 ;test10.j(175)     // integer - byte
 538 ;test10.j(176)     //TODO
 539 ;test10.j(177)     println(76);
 540 acc8= constant 76
 541 call writeLineAcc8
 542 ;test10.j(178)     println(77);
 543 acc8= constant 77
 544 call writeLineAcc8
 545 ;test10.j(179)     // integer - integer
 546 ;test10.j(180)     //TODO
 547 ;test10.j(181)     println(78);
 548 acc8= constant 78
 549 call writeLineAcc8
 550 ;test10.j(182)     println(79);
 551 acc8= constant 79
 552 call writeLineAcc8
 553 ;test10.j(183)   
 554 ;test10.j(184)     /************************/
 555 ;test10.j(185)     // acc - stack8
 556 ;test10.j(186)     // byte - byte
 557 ;test10.j(187)     //TODO
 558 ;test10.j(188)     println(80);
 559 acc8= constant 80
 560 call writeLineAcc8
 561 ;test10.j(189)     println(81);
 562 acc8= constant 81
 563 call writeLineAcc8
 564 ;test10.j(190)     // byte - integer
 565 ;test10.j(191)     //TODO
 566 ;test10.j(192)     println(82);
 567 acc8= constant 82
 568 call writeLineAcc8
 569 ;test10.j(193)     println(83);
 570 acc8= constant 83
 571 call writeLineAcc8
 572 ;test10.j(194)     // integer - byte
 573 ;test10.j(195)     //TODO
 574 ;test10.j(196)     println(84);
 575 acc8= constant 84
 576 call writeLineAcc8
 577 ;test10.j(197)     println(85);
 578 acc8= constant 85
 579 call writeLineAcc8
 580 ;test10.j(198)     // integer - integer
 581 ;test10.j(199)     //TODO
 582 ;test10.j(200)     println(86);
 583 acc8= constant 86
 584 call writeLineAcc8
 585 ;test10.j(201)     println(87);
 586 acc8= constant 87
 587 call writeLineAcc8
 588 ;test10.j(202)   
 589 ;test10.j(203)     /************************/
 590 ;test10.j(204)     // var - constant
 591 ;test10.j(205)     // byte - byte
 592 ;test10.j(206)     b=88;
 593 acc8= constant 88
 594 acc8=> variable 0
 595 ;test10.j(207)     do { println (b); b++; } while (b <= 89);
 596 acc8= variable 0
 597 call writeLineAcc8
 598 incr8 variable 0
 599 acc8= variable 0
 600 acc8Comp constant 89
 601 brle 596
 602 ;test10.j(208)     // byte - integer
 603 ;test10.j(209)     //not relevant
 604 ;test10.j(210)     println(90);
 605 acc8= constant 90
 606 call writeLineAcc8
 607 ;test10.j(211)     println(91);
 608 acc8= constant 91
 609 call writeLineAcc8
 610 ;test10.j(212)     // integer - byte
 611 ;test10.j(213)     i=92;
 612 acc8= constant 92
 613 acc8=> variable 1
 614 ;test10.j(214)     do { println (i); i++; } while (i <= 93);
 615 acc16= variable 1
 616 call writeLineAcc16
 617 incr16 variable 1
 618 acc16= variable 1
 619 acc8= constant 93
 620 acc16CompareAcc8
 621 brle 615
 622 ;test10.j(215)     // integer - integer
 623 ;test10.j(216)     i=1094;
 624 acc16= constant 1094
 625 acc16=> variable 1
 626 ;test10.j(217)     b=94;
 627 acc8= constant 94
 628 acc8=> variable 0
 629 ;test10.j(218)     do { println (b); b++; i++; } while (i <= 1095  );
 630 acc8= variable 0
 631 call writeLineAcc8
 632 incr8 variable 0
 633 incr16 variable 1
 634 acc16= variable 1
 635 acc16Comp constant 1095
 636 brle 630
 637 ;test10.j(219)   
 638 ;test10.j(220)     /************************/
 639 ;test10.j(221)     // var - acc
 640 ;test10.j(222)     // byte - byte
 641 ;test10.j(223)     do { println (b); b++; } while (b <= 97+0);
 642 acc8= variable 0
 643 call writeLineAcc8
 644 incr8 variable 0
 645 acc8= constant 97
 646 acc8+ constant 0
 647 acc8Comp variable 0
 648 brge 642
 649 ;test10.j(224)     // byte - integer
 650 ;test10.j(225)     //not relevant
 651 ;test10.j(226)     i=99;
 652 acc8= constant 99
 653 acc8=> variable 1
 654 ;test10.j(227)     do { println (b); b++; } while (b <= i+0);
 655 acc8= variable 0
 656 call writeLineAcc8
 657 incr8 variable 0
 658 acc16= variable 1
 659 acc16+ constant 0
 660 acc8= variable 0
 661 acc8CompareAcc16
 662 brle 655
 663 ;test10.j(228)     // integer - byte
 664 ;test10.j(229)     i=100;
 665 acc8= constant 100
 666 acc8=> variable 1
 667 ;test10.j(230)     do { println (i); i++; } while (i <= 101+0);
 668 acc16= variable 1
 669 call writeLineAcc16
 670 incr16 variable 1
 671 acc8= constant 101
 672 acc8+ constant 0
 673 acc16= variable 1
 674 acc16CompareAcc8
 675 brle 668
 676 ;test10.j(231)     // integer - integer
 677 ;test10.j(232)     i=1102;
 678 acc16= constant 1102
 679 acc16=> variable 1
 680 ;test10.j(233)     b=102;
 681 acc8= constant 102
 682 acc8=> variable 0
 683 ;test10.j(234)     do { println (b); b++; i++; } while (i <= 1103+0);
 684 acc8= variable 0
 685 call writeLineAcc8
 686 incr8 variable 0
 687 incr16 variable 1
 688 acc16= constant 1103
 689 acc16+ constant 0
 690 acc16Comp variable 1
 691 brge 684
 692 ;test10.j(235)   
 693 ;test10.j(236)     /************************/
 694 ;test10.j(237)     // var - var
 695 ;test10.j(238)     // byte - byte
 696 ;test10.j(239)     byte b2 = 105;
 697 acc8= constant 105
 698 acc8=> variable 5
 699 ;test10.j(240)     do { println (b); b++; } while (b <= b2);
 700 acc8= variable 0
 701 call writeLineAcc8
 702 incr8 variable 0
 703 acc8= variable 0
 704 acc8Comp variable 5
 705 brle 700
 706 ;test10.j(241)     // byte - integer
 707 ;test10.j(242)     i=107;
 708 acc8= constant 107
 709 acc8=> variable 1
 710 ;test10.j(243)     do { println (b); b++; } while (b <= i);
 711 acc8= variable 0
 712 call writeLineAcc8
 713 incr8 variable 0
 714 acc8= variable 0
 715 acc16= variable 1
 716 acc8CompareAcc16
 717 brle 711
 718 ;test10.j(244)     // integer - byte
 719 ;test10.j(245)     i=b;
 720 acc8= variable 0
 721 acc8=> variable 1
 722 ;test10.j(246)     b=109;
 723 acc8= constant 109
 724 acc8=> variable 0
 725 ;test10.j(247)     do { println (i); i++; } while (i <= b);
 726 acc16= variable 1
 727 call writeLineAcc16
 728 incr16 variable 1
 729 acc16= variable 1
 730 acc8= variable 0
 731 acc16CompareAcc8
 732 brle 726
 733 ;test10.j(248)     // integer - integer
 734 ;test10.j(249)     word i2 = 111;
 735 acc8= constant 111
 736 acc8=> variable 6
 737 ;test10.j(250)     do { println (i); i++; } while (i <= i2);
 738 acc16= variable 1
 739 call writeLineAcc16
 740 incr16 variable 1
 741 acc16= variable 1
 742 acc16Comp variable 6
 743 brle 738
 744 ;test10.j(251)   
 745 ;test10.j(252)     /************************/
 746 ;test10.j(253)     // var - stack8
 747 ;test10.j(254)     // byte - byte
 748 ;test10.j(255)     // byte - integer
 749 ;test10.j(256)     // integer - byte
 750 ;test10.j(257)     // integer - integer
 751 ;test10.j(258)     //TODO
 752 ;test10.j(259)   
 753 ;test10.j(260)     /************************/
 754 ;test10.j(261)     // var - stack16
 755 ;test10.j(262)     // byte - byte
 756 ;test10.j(263)     // byte - integer
 757 ;test10.j(264)     // integer - byte
 758 ;test10.j(265)     // integer - integer
 759 ;test10.j(266)     //TODO
 760 ;test10.j(267)   
 761 ;test10.j(268)     /************************/
 762 ;test10.j(269)     // stack8 - constant
 763 ;test10.j(270)     // stack8 - acc
 764 ;test10.j(271)     // stack8 - var
 765 ;test10.j(272)     // stack8 - stack8
 766 ;test10.j(273)     // stack8 - stack16
 767 ;test10.j(274)     //TODO
 768 ;test10.j(275)   
 769 ;test10.j(276)     /************************/
 770 ;test10.j(277)     // stack16 - constant
 771 ;test10.j(278)     // stack16 - acc
 772 ;test10.j(279)     // stack16 - var
 773 ;test10.j(280)     // stack16 - stack8
 774 ;test10.j(281)     // stack16 - stack16
 775 ;test10.j(282)     //TODO
 776 ;test10.j(283)   
 777 ;test10.j(284)     println("Klaar");
 778 acc16= constant 783
 779 writeLineString
 780 ;test10.j(285)   }
 781 ;test10.j(286) }
 782 stop
 783 stringConstant 0 = "Klaar"
