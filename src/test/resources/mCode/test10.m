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
  13 ;test10.j(6)   static       word j = 1001;
  14 acc16= constant 1001
  15 acc16=> variable 5
  16 ;test10.j(7)   static byte c = b;
  17 acc8= variable 0
  18 acc8=> variable 7
  19 ;test10.j(8)   static byte d = c;
  20 acc8= variable 7
  21 acc8=> variable 8
  22 ;test10.j(9)   static byte b2 = 105;
  23 acc8= constant 105
  24 acc8=> variable 9
  25 ;test10.j(10)   static word i2;
  26 ;test10.j(11) 
  27 ;test10.j(12)   public static void main() {
  28 method main [public, static] void
  29 ;test10.j(13)     println(0);
  30 acc8= constant 0
  31 call writeLineAcc8
  32 ;test10.j(14)   
  33 ;test10.j(15)     /************************/
  34 ;test10.j(16)     // global variable within do scope
  35 ;test10.j(17)     println (b);
  36 acc8= variable 0
  37 call writeLineAcc8
  38 ;test10.j(18)     b++;
  39 incr8 variable 0
  40 ;test10.j(19)     do {
  41 ;test10.j(20)        j = 1001;
  42 acc16= constant 1001
  43 acc16=> variable 5
  44 ;test10.j(21)        c = b;
  45 acc8= variable 0
  46 acc8=> variable 7
  47 ;test10.j(22)        d = c;
  48 acc8= variable 7
  49 acc8=> variable 8
  50 ;test10.j(23)       b++;
  51 incr8 variable 0
  52 ;test10.j(24)       println (c);
  53 acc8= variable 7
  54 call writeLineAcc8
  55 ;test10.j(25)     } while (b<2);
  56 acc8= variable 0
  57 acc8Comp constant 2
  58 brlt 41
  59 ;test10.j(26)   
  60 ;test10.j(27)     /************************/
  61 ;test10.j(28)     // constant - constant
  62 ;test10.j(29)     // not relevant
  63 ;test10.j(30)   
  64 ;test10.j(31)     /************************/
  65 ;test10.j(32)     // constant - acc
  66 ;test10.j(33)     // byte - byte
  67 ;test10.j(34)     do { println (b); b++; } while (103 == b+100);
  68 acc8= variable 0
  69 call writeLineAcc8
  70 incr8 variable 0
  71 acc8= variable 0
  72 acc8+ constant 100
  73 acc8Comp constant 103
  74 breq 68
  75 ;test10.j(35)     do { println (b); b++; } while (106 != b+100);
  76 acc8= variable 0
  77 call writeLineAcc8
  78 incr8 variable 0
  79 acc8= variable 0
  80 acc8+ constant 100
  81 acc8Comp constant 106
  82 brne 76
  83 ;test10.j(36)     do { println (b); b++; } while (108 >  b+100);
  84 acc8= variable 0
  85 call writeLineAcc8
  86 incr8 variable 0
  87 acc8= variable 0
  88 acc8+ constant 100
  89 acc8Comp constant 108
  90 brlt 84
  91 ;test10.j(37)     do { println (b); b++; } while (109 >= b+100);
  92 acc8= variable 0
  93 call writeLineAcc8
  94 incr8 variable 0
  95 acc8= variable 0
  96 acc8+ constant 100
  97 acc8Comp constant 109
  98 brle 92
  99 ;test10.j(38)     p=10;
 100 acc8= constant 10
 101 acc8=> variable 3
 102 ;test10.j(39)     do { println (p); p++; b--; } while (108 <  b+100);
 103 acc16= variable 3
 104 call writeLineAcc16
 105 incr16 variable 3
 106 decr8 variable 0
 107 acc8= variable 0
 108 acc8+ constant 100
 109 acc8Comp constant 108
 110 brgt 103
 111 ;test10.j(40)     do { println (p); p++; b--; } while (107 <= b+100);
 112 acc16= variable 3
 113 call writeLineAcc16
 114 incr16 variable 3
 115 decr8 variable 0
 116 acc8= variable 0
 117 acc8+ constant 100
 118 acc8Comp constant 107
 119 brge 112
 120 ;test10.j(41)   
 121 ;test10.j(42)     // constant - acc
 122 ;test10.j(43)     // byte - integer
 123 ;test10.j(44)     i=14;
 124 acc8= constant 14
 125 acc8=> variable 1
 126 ;test10.j(45)     do { println (i); i++; } while (15 == i+0);
 127 acc16= variable 1
 128 call writeLineAcc16
 129 incr16 variable 1
 130 acc16= variable 1
 131 acc16+ constant 0
 132 acc8= constant 15
 133 acc8CompareAcc16
 134 breq 127
 135 ;test10.j(46)     do { println (i); i++; } while (18 != i+0);
 136 acc16= variable 1
 137 call writeLineAcc16
 138 incr16 variable 1
 139 acc16= variable 1
 140 acc16+ constant 0
 141 acc8= constant 18
 142 acc8CompareAcc16
 143 brne 136
 144 ;test10.j(47)     do { println (i); i++; } while (20 >  i+0);
 145 acc16= variable 1
 146 call writeLineAcc16
 147 incr16 variable 1
 148 acc16= variable 1
 149 acc16+ constant 0
 150 acc8= constant 20
 151 acc8CompareAcc16
 152 brgt 145
 153 ;test10.j(48)     do { println (i); i++; } while (21 >= i+0);
 154 acc16= variable 1
 155 call writeLineAcc16
 156 incr16 variable 1
 157 acc16= variable 1
 158 acc16+ constant 0
 159 acc8= constant 21
 160 acc8CompareAcc16
 161 brge 154
 162 ;test10.j(49)     p=22;
 163 acc8= constant 22
 164 acc8=> variable 3
 165 ;test10.j(50)     do { println (p); p++; i--; } while (20 <  i+0);
 166 acc16= variable 3
 167 call writeLineAcc16
 168 incr16 variable 3
 169 decr16 variable 1
 170 acc16= variable 1
 171 acc16+ constant 0
 172 acc8= constant 20
 173 acc8CompareAcc16
 174 brlt 166
 175 ;test10.j(51)     do { println (p); p++; i--; } while (19 <= i+0);
 176 acc16= variable 3
 177 call writeLineAcc16
 178 incr16 variable 3
 179 decr16 variable 1
 180 acc16= variable 1
 181 acc16+ constant 0
 182 acc8= constant 19
 183 acc8CompareAcc16
 184 brle 176
 185 ;test10.j(52)   
 186 ;test10.j(53)     // constant - acc
 187 ;test10.j(54)     // integer - byte
 188 ;test10.j(55)     // not relevant
 189 ;test10.j(56)   
 190 ;test10.j(57)     // constant - acc
 191 ;test10.j(58)     // integer - integer
 192 ;test10.j(59)     i=p;
 193 acc16= variable 3
 194 acc16=> variable 1
 195 ;test10.j(60)     do { println (i); i++; } while (1027 == i+1000);
 196 acc16= variable 1
 197 call writeLineAcc16
 198 incr16 variable 1
 199 acc16= variable 1
 200 acc16+ constant 1000
 201 acc16Comp constant 1027
 202 breq 196
 203 ;test10.j(61)     do { println (i); i++; } while (1029 != i+1000);
 204 acc16= variable 1
 205 call writeLineAcc16
 206 incr16 variable 1
 207 acc16= variable 1
 208 acc16+ constant 1000
 209 acc16Comp constant 1029
 210 brne 204
 211 ;test10.j(62)     do { println (i); i++; } while (1031 >  i+1000);
 212 acc16= variable 1
 213 call writeLineAcc16
 214 incr16 variable 1
 215 acc16= variable 1
 216 acc16+ constant 1000
 217 acc16Comp constant 1031
 218 brlt 212
 219 ;test10.j(63)     do { println (i); i++; } while (1032 >= i+1000);
 220 acc16= variable 1
 221 call writeLineAcc16
 222 incr16 variable 1
 223 acc16= variable 1
 224 acc16+ constant 1000
 225 acc16Comp constant 1032
 226 brle 220
 227 ;test10.j(64)     p=i;
 228 acc16= variable 1
 229 acc16=> variable 3
 230 ;test10.j(65)     do { println (p); p++; i--; } while (1031 <  i+1000);
 231 acc16= variable 3
 232 call writeLineAcc16
 233 incr16 variable 3
 234 decr16 variable 1
 235 acc16= variable 1
 236 acc16+ constant 1000
 237 acc16Comp constant 1031
 238 brgt 231
 239 ;test10.j(66)     do { println (p); p++; i--; } while (1030 <= i+1000);
 240 acc16= variable 3
 241 call writeLineAcc16
 242 incr16 variable 3
 243 decr16 variable 1
 244 acc16= variable 1
 245 acc16+ constant 1000
 246 acc16Comp constant 1030
 247 brge 240
 248 ;test10.j(67)   
 249 ;test10.j(68)     /************************/
 250 ;test10.j(69)     // constant - var
 251 ;test10.j(70)     // byte - byte
 252 ;test10.j(71)     b=37;
 253 acc8= constant 37
 254 acc8=> variable 0
 255 ;test10.j(72)     do { println (b); b++; } while (38 >= b);
 256 acc8= variable 0
 257 call writeLineAcc8
 258 incr8 variable 0
 259 acc8= variable 0
 260 acc8Comp constant 38
 261 brle 256
 262 ;test10.j(73)     // byte - integer
 263 ;test10.j(74)     i=39;
 264 acc8= constant 39
 265 acc8=> variable 1
 266 ;test10.j(75)     do { println (i); i++; } while (40 >= i);
 267 acc16= variable 1
 268 call writeLineAcc16
 269 incr16 variable 1
 270 acc16= variable 1
 271 acc8= constant 40
 272 acc8CompareAcc16
 273 brge 267
 274 ;test10.j(76)     // integer - byte
 275 ;test10.j(77)     // not relevant
 276 ;test10.j(78)     // integer - integer
 277 ;test10.j(79)     i=1038;
 278 acc16= constant 1038
 279 acc16=> variable 1
 280 ;test10.j(80)     b=41;
 281 acc8= constant 41
 282 acc8=> variable 0
 283 ;test10.j(81)     do { println (b); b++; i--; } while (1037 <= i);
 284 acc8= variable 0
 285 call writeLineAcc8
 286 incr8 variable 0
 287 decr16 variable 1
 288 acc16= variable 1
 289 acc16Comp constant 1037
 290 brge 284
 291 ;test10.j(82)   
 292 ;test10.j(83)     /************************/
 293 ;test10.j(84)     // constant - stack8
 294 ;test10.j(85)     // byte - byte
 295 ;test10.j(86)     //TODO
 296 ;test10.j(87)     println(43);
 297 acc8= constant 43
 298 call writeLineAcc8
 299 ;test10.j(88)     // constant - stack8
 300 ;test10.j(89)     // byte - integer
 301 ;test10.j(90)     //TODO
 302 ;test10.j(91)     println(44);
 303 acc8= constant 44
 304 call writeLineAcc8
 305 ;test10.j(92)     // constant - stack8
 306 ;test10.j(93)     // integer - byte
 307 ;test10.j(94)     //TODO
 308 ;test10.j(95)     println(45);
 309 acc8= constant 45
 310 call writeLineAcc8
 311 ;test10.j(96)     // constant - stack88
 312 ;test10.j(97)     // integer - integer
 313 ;test10.j(98)     //TODO
 314 ;test10.j(99)     println(46);
 315 acc8= constant 46
 316 call writeLineAcc8
 317 ;test10.j(100)   
 318 ;test10.j(101)     /************************/
 319 ;test10.j(102)     // constant - stack16
 320 ;test10.j(103)     // byte - byte
 321 ;test10.j(104)     //TODO
 322 ;test10.j(105)     println(47);
 323 acc8= constant 47
 324 call writeLineAcc8
 325 ;test10.j(106)     // constant - stack16
 326 ;test10.j(107)     // byte - integer
 327 ;test10.j(108)     //TODO
 328 ;test10.j(109)     println(48);
 329 acc8= constant 48
 330 call writeLineAcc8
 331 ;test10.j(110)     // constant - stack16
 332 ;test10.j(111)     // integer - byte
 333 ;test10.j(112)     //TODO
 334 ;test10.j(113)     println(49);
 335 acc8= constant 49
 336 call writeLineAcc8
 337 ;test10.j(114)     // constant - stack16
 338 ;test10.j(115)     // integer - integer
 339 ;test10.j(116)     //TODO
 340 ;test10.j(117)     println(50);
 341 acc8= constant 50
 342 call writeLineAcc8
 343 ;test10.j(118)   
 344 ;test10.j(119)     /************************/
 345 ;test10.j(120)     // acc - constant
 346 ;test10.j(121)     // byte - byte
 347 ;test10.j(122)     b=51;
 348 acc8= constant 51
 349 acc8=> variable 0
 350 ;test10.j(123)     do { println (b); b++; } while (b+0 <= 52);
 351 acc8= variable 0
 352 call writeLineAcc8
 353 incr8 variable 0
 354 acc8= variable 0
 355 acc8+ constant 0
 356 acc8Comp constant 52
 357 brle 351
 358 ;test10.j(124)     // byte - integer
 359 ;test10.j(125)     //not relevant
 360 ;test10.j(126)     // integer - byte
 361 ;test10.j(127)     i=53;
 362 acc8= constant 53
 363 acc8=> variable 1
 364 ;test10.j(128)     do { println (i); i++; } while (i+0 <= 54);
 365 acc16= variable 1
 366 call writeLineAcc16
 367 incr16 variable 1
 368 acc16= variable 1
 369 acc16+ constant 0
 370 acc8= constant 54
 371 acc16CompareAcc8
 372 brle 365
 373 ;test10.j(129)   
 374 ;test10.j(130)     b=55;
 375 acc8= constant 55
 376 acc8=> variable 0
 377 ;test10.j(131)     i=1055;
 378 acc16= constant 1055
 379 acc16=> variable 1
 380 ;test10.j(132)     // integer - integer
 381 ;test10.j(133)     do { println (b); b++; i++; } while (i+0 <= 1056);
 382 acc8= variable 0
 383 call writeLineAcc8
 384 incr8 variable 0
 385 incr16 variable 1
 386 acc16= variable 1
 387 acc16+ constant 0
 388 acc16Comp constant 1056
 389 brle 382
 390 ;test10.j(134)   
 391 ;test10.j(135)     /************************/
 392 ;test10.j(136)     // acc - acc
 393 ;test10.j(137)     // byte - byte
 394 ;test10.j(138)     b=57;
 395 acc8= constant 57
 396 acc8=> variable 0
 397 ;test10.j(139)     do { println (b); b++; } while (b+0 <= 58+0);
 398 acc8= variable 0
 399 call writeLineAcc8
 400 incr8 variable 0
 401 acc8= variable 0
 402 acc8+ constant 0
 403 <acc8
 404 acc8= constant 58
 405 acc8+ constant 0
 406 revAcc8Comp unstack8
 407 brge 398
 408 ;test10.j(140)     // byte - integer
 409 ;test10.j(141)     i=61;
 410 acc8= constant 61
 411 acc8=> variable 1
 412 ;test10.j(142)     do { println (b); b++; i--; } while (60+0 <= i+0);
 413 acc8= variable 0
 414 call writeLineAcc8
 415 incr8 variable 0
 416 decr16 variable 1
 417 acc8= constant 60
 418 acc8+ constant 0
 419 <acc8
 420 acc16= variable 1
 421 acc16+ constant 0
 422 acc8= unstack8
 423 acc8CompareAcc16
 424 brle 413
 425 ;test10.j(143)     // integer - byte
 426 ;test10.j(144)     i=61;
 427 acc8= constant 61
 428 acc8=> variable 1
 429 ;test10.j(145)     b=62;
 430 acc8= constant 62
 431 acc8=> variable 0
 432 ;test10.j(146)     do { println (i); i++; } while (i+0 <= b+0);
 433 acc16= variable 1
 434 call writeLineAcc16
 435 incr16 variable 1
 436 acc16= variable 1
 437 acc16+ constant 0
 438 <acc16
 439 acc8= variable 0
 440 acc8+ constant 0
 441 acc16= unstack16
 442 acc16CompareAcc8
 443 brle 433
 444 ;test10.j(147)     // integer - integer
 445 ;test10.j(148)     b=63;
 446 acc8= constant 63
 447 acc8=> variable 0
 448 ;test10.j(149)     i=1063;
 449 acc16= constant 1063
 450 acc16=> variable 1
 451 ;test10.j(150)     do { println (b); b++; i--; } while (1000+62 <= i+0);
 452 acc8= variable 0
 453 call writeLineAcc8
 454 incr8 variable 0
 455 decr16 variable 1
 456 acc16= constant 1000
 457 acc16+ constant 62
 458 <acc16
 459 acc16= variable 1
 460 acc16+ constant 0
 461 revAcc16Comp unstack16
 462 brge 452
 463 ;test10.j(151)   
 464 ;test10.j(152)     /************************/
 465 ;test10.j(153)     // acc - var
 466 ;test10.j(154)     // byte - byte
 467 ;test10.j(155)     b=65;
 468 acc8= constant 65
 469 acc8=> variable 0
 470 ;test10.j(156)     i=65;
 471 acc8= constant 65
 472 acc8=> variable 1
 473 ;test10.j(157)     do { println (i); i++; b--; } while (64+0 <= b);
 474 acc16= variable 1
 475 call writeLineAcc16
 476 incr16 variable 1
 477 decr8 variable 0
 478 acc8= constant 64
 479 acc8+ constant 0
 480 acc8Comp variable 0
 481 brle 474
 482 ;test10.j(158)     // byte - integer
 483 ;test10.j(159)     b=67;
 484 acc8= constant 67
 485 acc8=> variable 0
 486 ;test10.j(160)     i=67;
 487 acc8= constant 67
 488 acc8=> variable 1
 489 ;test10.j(161)     do { println (b); b++; i--; } while (66+0 <= i);
 490 acc8= variable 0
 491 call writeLineAcc8
 492 incr8 variable 0
 493 decr16 variable 1
 494 acc8= constant 66
 495 acc8+ constant 0
 496 acc16= variable 1
 497 acc8CompareAcc16
 498 brle 490
 499 ;test10.j(162)     // integer - byte
 500 ;test10.j(163)     i=69;
 501 acc8= constant 69
 502 acc8=> variable 1
 503 ;test10.j(164)     b=69;
 504 acc8= constant 69
 505 acc8=> variable 0
 506 ;test10.j(165)     do { println (i); i++; b--; } while (1000+68 <= b);
 507 acc16= variable 1
 508 call writeLineAcc16
 509 incr16 variable 1
 510 decr8 variable 0
 511 acc16= constant 1000
 512 acc16+ constant 68
 513 acc8= variable 0
 514 acc16CompareAcc8
 515 brle 507
 516 ;test10.j(166)     // integer - integer
 517 ;test10.j(167)     i=1071;
 518 acc16= constant 1071
 519 acc16=> variable 1
 520 ;test10.j(168)     b=70;
 521 acc8= constant 70
 522 acc8=> variable 0
 523 ;test10.j(169)     do { println (b); b++; i--; } while (1000+70 <= i);
 524 acc8= variable 0
 525 call writeLineAcc8
 526 incr8 variable 0
 527 decr16 variable 1
 528 acc16= constant 1000
 529 acc16+ constant 70
 530 acc16Comp variable 1
 531 brle 524
 532 ;test10.j(170)   
 533 ;test10.j(171)     /************************/
 534 ;test10.j(172)     // acc - stack16
 535 ;test10.j(173)     // byte - byte
 536 ;test10.j(174)     //TODO
 537 ;test10.j(175)     println(72);
 538 acc8= constant 72
 539 call writeLineAcc8
 540 ;test10.j(176)     println(73);
 541 acc8= constant 73
 542 call writeLineAcc8
 543 ;test10.j(177)     // byte - integer
 544 ;test10.j(178)     //TODO
 545 ;test10.j(179)     println(74);
 546 acc8= constant 74
 547 call writeLineAcc8
 548 ;test10.j(180)     println(75);
 549 acc8= constant 75
 550 call writeLineAcc8
 551 ;test10.j(181)     // integer - byte
 552 ;test10.j(182)     //TODO
 553 ;test10.j(183)     println(76);
 554 acc8= constant 76
 555 call writeLineAcc8
 556 ;test10.j(184)     println(77);
 557 acc8= constant 77
 558 call writeLineAcc8
 559 ;test10.j(185)     // integer - integer
 560 ;test10.j(186)     //TODO
 561 ;test10.j(187)     println(78);
 562 acc8= constant 78
 563 call writeLineAcc8
 564 ;test10.j(188)     println(79);
 565 acc8= constant 79
 566 call writeLineAcc8
 567 ;test10.j(189)   
 568 ;test10.j(190)     /************************/
 569 ;test10.j(191)     // acc - stack8
 570 ;test10.j(192)     // byte - byte
 571 ;test10.j(193)     //TODO
 572 ;test10.j(194)     println(80);
 573 acc8= constant 80
 574 call writeLineAcc8
 575 ;test10.j(195)     println(81);
 576 acc8= constant 81
 577 call writeLineAcc8
 578 ;test10.j(196)     // byte - integer
 579 ;test10.j(197)     //TODO
 580 ;test10.j(198)     println(82);
 581 acc8= constant 82
 582 call writeLineAcc8
 583 ;test10.j(199)     println(83);
 584 acc8= constant 83
 585 call writeLineAcc8
 586 ;test10.j(200)     // integer - byte
 587 ;test10.j(201)     //TODO
 588 ;test10.j(202)     println(84);
 589 acc8= constant 84
 590 call writeLineAcc8
 591 ;test10.j(203)     println(85);
 592 acc8= constant 85
 593 call writeLineAcc8
 594 ;test10.j(204)     // integer - integer
 595 ;test10.j(205)     //TODO
 596 ;test10.j(206)     println(86);
 597 acc8= constant 86
 598 call writeLineAcc8
 599 ;test10.j(207)     println(87);
 600 acc8= constant 87
 601 call writeLineAcc8
 602 ;test10.j(208)   
 603 ;test10.j(209)     /************************/
 604 ;test10.j(210)     // var - constant
 605 ;test10.j(211)     // byte - byte
 606 ;test10.j(212)     b=88;
 607 acc8= constant 88
 608 acc8=> variable 0
 609 ;test10.j(213)     do { println (b); b++; } while (b <= 89);
 610 acc8= variable 0
 611 call writeLineAcc8
 612 incr8 variable 0
 613 acc8= variable 0
 614 acc8Comp constant 89
 615 brle 610
 616 ;test10.j(214)     // byte - integer
 617 ;test10.j(215)     //not relevant
 618 ;test10.j(216)     println(90);
 619 acc8= constant 90
 620 call writeLineAcc8
 621 ;test10.j(217)     println(91);
 622 acc8= constant 91
 623 call writeLineAcc8
 624 ;test10.j(218)     // integer - byte
 625 ;test10.j(219)     i=92;
 626 acc8= constant 92
 627 acc8=> variable 1
 628 ;test10.j(220)     do { println (i); i++; } while (i <= 93);
 629 acc16= variable 1
 630 call writeLineAcc16
 631 incr16 variable 1
 632 acc16= variable 1
 633 acc8= constant 93
 634 acc16CompareAcc8
 635 brle 629
 636 ;test10.j(221)     // integer - integer
 637 ;test10.j(222)     i=1094;
 638 acc16= constant 1094
 639 acc16=> variable 1
 640 ;test10.j(223)     b=94;
 641 acc8= constant 94
 642 acc8=> variable 0
 643 ;test10.j(224)     do { println (b); b++; i++; } while (i <= 1095  );
 644 acc8= variable 0
 645 call writeLineAcc8
 646 incr8 variable 0
 647 incr16 variable 1
 648 acc16= variable 1
 649 acc16Comp constant 1095
 650 brle 644
 651 ;test10.j(225)   
 652 ;test10.j(226)     /************************/
 653 ;test10.j(227)     // var - acc
 654 ;test10.j(228)     // byte - byte
 655 ;test10.j(229)     do { println (b); b++; } while (b <= 97+0);
 656 acc8= variable 0
 657 call writeLineAcc8
 658 incr8 variable 0
 659 acc8= constant 97
 660 acc8+ constant 0
 661 acc8Comp variable 0
 662 brge 656
 663 ;test10.j(230)     // byte - integer
 664 ;test10.j(231)     //not relevant
 665 ;test10.j(232)     i=99;
 666 acc8= constant 99
 667 acc8=> variable 1
 668 ;test10.j(233)     do { println (b); b++; } while (b <= i+0);
 669 acc8= variable 0
 670 call writeLineAcc8
 671 incr8 variable 0
 672 acc16= variable 1
 673 acc16+ constant 0
 674 acc8= variable 0
 675 acc8CompareAcc16
 676 brle 669
 677 ;test10.j(234)     // integer - byte
 678 ;test10.j(235)     i=100;
 679 acc8= constant 100
 680 acc8=> variable 1
 681 ;test10.j(236)     do { println (i); i++; } while (i <= 101+0);
 682 acc16= variable 1
 683 call writeLineAcc16
 684 incr16 variable 1
 685 acc8= constant 101
 686 acc8+ constant 0
 687 acc16= variable 1
 688 acc16CompareAcc8
 689 brle 682
 690 ;test10.j(237)     // integer - integer
 691 ;test10.j(238)     i=1102;
 692 acc16= constant 1102
 693 acc16=> variable 1
 694 ;test10.j(239)     b=102;
 695 acc8= constant 102
 696 acc8=> variable 0
 697 ;test10.j(240)     do { println (b); b++; i++; } while (i <= 1103+0);
 698 acc8= variable 0
 699 call writeLineAcc8
 700 incr8 variable 0
 701 incr16 variable 1
 702 acc16= constant 1103
 703 acc16+ constant 0
 704 acc16Comp variable 1
 705 brge 698
 706 ;test10.j(241)   
 707 ;test10.j(242)     /************************/
 708 ;test10.j(243)     // var - var
 709 ;test10.j(244)     // byte - byte
 710 ;test10.j(245)     b2 = 105;
 711 acc8= constant 105
 712 acc8=> variable 9
 713 ;test10.j(246)     do { println (b); b++; } while (b <= b2);
 714 acc8= variable 0
 715 call writeLineAcc8
 716 incr8 variable 0
 717 acc8= variable 0
 718 acc8Comp variable 9
 719 brle 714
 720 ;test10.j(247)     // byte - integer
 721 ;test10.j(248)     i=107;
 722 acc8= constant 107
 723 acc8=> variable 1
 724 ;test10.j(249)     do { println (b); b++; } while (b <= i);
 725 acc8= variable 0
 726 call writeLineAcc8
 727 incr8 variable 0
 728 acc8= variable 0
 729 acc16= variable 1
 730 acc8CompareAcc16
 731 brle 725
 732 ;test10.j(250)     // integer - byte
 733 ;test10.j(251)     i=b;
 734 acc8= variable 0
 735 acc8=> variable 1
 736 ;test10.j(252)     b=109;
 737 acc8= constant 109
 738 acc8=> variable 0
 739 ;test10.j(253)     do { println (i); i++; } while (i <= b);
 740 acc16= variable 1
 741 call writeLineAcc16
 742 incr16 variable 1
 743 acc16= variable 1
 744 acc8= variable 0
 745 acc16CompareAcc8
 746 brle 740
 747 ;test10.j(254)     // integer - integer
 748 ;test10.j(255)     i2 = 111;
 749 acc8= constant 111
 750 acc8=> variable 10
 751 ;test10.j(256)     do { println (i); i++; } while (i <= i2);
 752 acc16= variable 1
 753 call writeLineAcc16
 754 incr16 variable 1
 755 acc16= variable 1
 756 acc16Comp variable 10
 757 brle 752
 758 ;test10.j(257)   
 759 ;test10.j(258)     /************************/
 760 ;test10.j(259)     // var - stack8
 761 ;test10.j(260)     // byte - byte
 762 ;test10.j(261)     // byte - integer
 763 ;test10.j(262)     // integer - byte
 764 ;test10.j(263)     // integer - integer
 765 ;test10.j(264)     //TODO
 766 ;test10.j(265)   
 767 ;test10.j(266)     /************************/
 768 ;test10.j(267)     // var - stack16
 769 ;test10.j(268)     // byte - byte
 770 ;test10.j(269)     // byte - integer
 771 ;test10.j(270)     // integer - byte
 772 ;test10.j(271)     // integer - integer
 773 ;test10.j(272)     //TODO
 774 ;test10.j(273)   
 775 ;test10.j(274)     /************************/
 776 ;test10.j(275)     // stack8 - constant
 777 ;test10.j(276)     // stack8 - acc
 778 ;test10.j(277)     // stack8 - var
 779 ;test10.j(278)     // stack8 - stack8
 780 ;test10.j(279)     // stack8 - stack16
 781 ;test10.j(280)     //TODO
 782 ;test10.j(281)   
 783 ;test10.j(282)     /************************/
 784 ;test10.j(283)     // stack16 - constant
 785 ;test10.j(284)     // stack16 - acc
 786 ;test10.j(285)     // stack16 - var
 787 ;test10.j(286)     // stack16 - stack8
 788 ;test10.j(287)     // stack16 - stack16
 789 ;test10.j(288)     //TODO
 790 ;test10.j(289)   
 791 ;test10.j(290)     println("Klaar");
 792 acc16= constant 797
 793 writeLineString
 794 ;test10.j(291)   }
 795 ;test10.j(292) }
 796 stop
 797 stringConstant 0 = "Klaar"
