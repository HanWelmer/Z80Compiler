   0 ;test10.j(0) /* Program to test generated Z80 assembler code */
   1 ;test10.j(1) class TestDo {
   2 ;test10.j(2)   byte b = 1;
   3 acc8= constant 1
   4 acc8=> variable 0
   5 ;test10.j(3)   word i = 12;
   6 acc8= constant 12
   7 acc8=> variable 1
   8 ;test10.j(4)   word p = 12;
   9 acc8= constant 12
  10 acc8=> variable 3
  11 ;test10.j(5) 
  12 ;test10.j(6)   println(0);
  13 acc8= constant 0
  14 call writeLineAcc8
  15 ;test10.j(7) 
  16 ;test10.j(8)   /************************/
  17 ;test10.j(9)   // global variable within do scope
  18 ;test10.j(10)   println (b);
  19 acc8= variable 0
  20 call writeLineAcc8
  21 ;test10.j(11)   b++;
  22 incr8 variable 0
  23 ;test10.j(12)   do {
  24 ;test10.j(13)     word j = 1001;
  25 acc16= constant 1001
  26 acc16=> variable 5
  27 ;test10.j(14)     byte c = b;
  28 acc8= variable 0
  29 acc8=> variable 7
  30 ;test10.j(15)     byte d = c;
  31 acc8= variable 7
  32 acc8=> variable 8
  33 ;test10.j(16)     b++;
  34 incr8 variable 0
  35 ;test10.j(17)     println (c);
  36 acc8= variable 7
  37 call writeLineAcc8
  38 ;test10.j(18)   } while (b<2);
  39 acc8= variable 0
  40 acc8Comp constant 2
  41 brlt 24
  42 ;test10.j(19) 
  43 ;test10.j(20)   /************************/
  44 ;test10.j(21)   // constant - constant
  45 ;test10.j(22)   // not relevant
  46 ;test10.j(23) 
  47 ;test10.j(24)   /************************/
  48 ;test10.j(25)   // constant - acc
  49 ;test10.j(26)   // byte - byte
  50 ;test10.j(27)   do { println (b); b++; } while (103 == b+100);
  51 acc8= variable 0
  52 call writeLineAcc8
  53 incr8 variable 0
  54 acc8= variable 0
  55 acc8+ constant 100
  56 acc8Comp constant 103
  57 breq 51
  58 ;test10.j(28)   do { println (b); b++; } while (106 != b+100);
  59 acc8= variable 0
  60 call writeLineAcc8
  61 incr8 variable 0
  62 acc8= variable 0
  63 acc8+ constant 100
  64 acc8Comp constant 106
  65 brne 59
  66 ;test10.j(29)   do { println (b); b++; } while (108 >  b+100);
  67 acc8= variable 0
  68 call writeLineAcc8
  69 incr8 variable 0
  70 acc8= variable 0
  71 acc8+ constant 100
  72 acc8Comp constant 108
  73 brlt 67
  74 ;test10.j(30)   do { println (b); b++; } while (109 >= b+100);
  75 acc8= variable 0
  76 call writeLineAcc8
  77 incr8 variable 0
  78 acc8= variable 0
  79 acc8+ constant 100
  80 acc8Comp constant 109
  81 brle 75
  82 ;test10.j(31)   p=10;
  83 acc8= constant 10
  84 acc8=> variable 3
  85 ;test10.j(32)   do { println (p); p++; b--; } while (108 <  b+100);
  86 acc16= variable 3
  87 call writeLineAcc16
  88 incr16 variable 3
  89 decr8 variable 0
  90 acc8= variable 0
  91 acc8+ constant 100
  92 acc8Comp constant 108
  93 brgt 86
  94 ;test10.j(33)   do { println (p); p++; b--; } while (107 <= b+100);
  95 acc16= variable 3
  96 call writeLineAcc16
  97 incr16 variable 3
  98 decr8 variable 0
  99 acc8= variable 0
 100 acc8+ constant 100
 101 acc8Comp constant 107
 102 brge 95
 103 ;test10.j(34) 
 104 ;test10.j(35)   // constant - acc
 105 ;test10.j(36)   // byte - integer
 106 ;test10.j(37)   i=14;
 107 acc8= constant 14
 108 acc8=> variable 1
 109 ;test10.j(38)   do { println (i); i++; } while (15 == i+0);
 110 acc16= variable 1
 111 call writeLineAcc16
 112 incr16 variable 1
 113 acc16= variable 1
 114 acc16+ constant 0
 115 acc8= constant 15
 116 acc8CompareAcc16
 117 breq 110
 118 ;test10.j(39)   do { println (i); i++; } while (18 != i+0);
 119 acc16= variable 1
 120 call writeLineAcc16
 121 incr16 variable 1
 122 acc16= variable 1
 123 acc16+ constant 0
 124 acc8= constant 18
 125 acc8CompareAcc16
 126 brne 119
 127 ;test10.j(40)   do { println (i); i++; } while (20 >  i+0);
 128 acc16= variable 1
 129 call writeLineAcc16
 130 incr16 variable 1
 131 acc16= variable 1
 132 acc16+ constant 0
 133 acc8= constant 20
 134 acc8CompareAcc16
 135 brgt 128
 136 ;test10.j(41)   do { println (i); i++; } while (21 >= i+0);
 137 acc16= variable 1
 138 call writeLineAcc16
 139 incr16 variable 1
 140 acc16= variable 1
 141 acc16+ constant 0
 142 acc8= constant 21
 143 acc8CompareAcc16
 144 brge 137
 145 ;test10.j(42)   p=22;
 146 acc8= constant 22
 147 acc8=> variable 3
 148 ;test10.j(43)   do { println (p); p++; i--; } while (20 <  i+0);
 149 acc16= variable 3
 150 call writeLineAcc16
 151 incr16 variable 3
 152 decr16 variable 1
 153 acc16= variable 1
 154 acc16+ constant 0
 155 acc8= constant 20
 156 acc8CompareAcc16
 157 brlt 149
 158 ;test10.j(44)   do { println (p); p++; i--; } while (19 <= i+0);
 159 acc16= variable 3
 160 call writeLineAcc16
 161 incr16 variable 3
 162 decr16 variable 1
 163 acc16= variable 1
 164 acc16+ constant 0
 165 acc8= constant 19
 166 acc8CompareAcc16
 167 brle 159
 168 ;test10.j(45) 
 169 ;test10.j(46)   // constant - acc
 170 ;test10.j(47)   // integer - byte
 171 ;test10.j(48)   // not relevant
 172 ;test10.j(49) 
 173 ;test10.j(50)   // constant - acc
 174 ;test10.j(51)   // integer - integer
 175 ;test10.j(52)   i=p;
 176 acc16= variable 3
 177 acc16=> variable 1
 178 ;test10.j(53)   do { println (i); i++; } while (1027 == i+1000);
 179 acc16= variable 1
 180 call writeLineAcc16
 181 incr16 variable 1
 182 acc16= variable 1
 183 acc16+ constant 1000
 184 acc16Comp constant 1027
 185 breq 179
 186 ;test10.j(54)   do { println (i); i++; } while (1029 != i+1000);
 187 acc16= variable 1
 188 call writeLineAcc16
 189 incr16 variable 1
 190 acc16= variable 1
 191 acc16+ constant 1000
 192 acc16Comp constant 1029
 193 brne 187
 194 ;test10.j(55)   do { println (i); i++; } while (1031 >  i+1000);
 195 acc16= variable 1
 196 call writeLineAcc16
 197 incr16 variable 1
 198 acc16= variable 1
 199 acc16+ constant 1000
 200 acc16Comp constant 1031
 201 brlt 195
 202 ;test10.j(56)   do { println (i); i++; } while (1032 >= i+1000);
 203 acc16= variable 1
 204 call writeLineAcc16
 205 incr16 variable 1
 206 acc16= variable 1
 207 acc16+ constant 1000
 208 acc16Comp constant 1032
 209 brle 203
 210 ;test10.j(57)   p=i;
 211 acc16= variable 1
 212 acc16=> variable 3
 213 ;test10.j(58)   do { println (p); p++; i--; } while (1031 <  i+1000);
 214 acc16= variable 3
 215 call writeLineAcc16
 216 incr16 variable 3
 217 decr16 variable 1
 218 acc16= variable 1
 219 acc16+ constant 1000
 220 acc16Comp constant 1031
 221 brgt 214
 222 ;test10.j(59)   do { println (p); p++; i--; } while (1030 <= i+1000);
 223 acc16= variable 3
 224 call writeLineAcc16
 225 incr16 variable 3
 226 decr16 variable 1
 227 acc16= variable 1
 228 acc16+ constant 1000
 229 acc16Comp constant 1030
 230 brge 223
 231 ;test10.j(60) 
 232 ;test10.j(61)   /************************/
 233 ;test10.j(62)   // constant - var
 234 ;test10.j(63)   // byte - byte
 235 ;test10.j(64)   b=37;
 236 acc8= constant 37
 237 acc8=> variable 0
 238 ;test10.j(65)   do { println (b); b++; } while (38 >= b);
 239 acc8= variable 0
 240 call writeLineAcc8
 241 incr8 variable 0
 242 acc8= variable 0
 243 acc8Comp constant 38
 244 brle 239
 245 ;test10.j(66)   // byte - integer
 246 ;test10.j(67)   i=39;
 247 acc8= constant 39
 248 acc8=> variable 1
 249 ;test10.j(68)   do { println (i); i++; } while (40 >= i);
 250 acc16= variable 1
 251 call writeLineAcc16
 252 incr16 variable 1
 253 acc16= variable 1
 254 acc8= constant 40
 255 acc8CompareAcc16
 256 brge 250
 257 ;test10.j(69)   // integer - byte
 258 ;test10.j(70)   // not relevant
 259 ;test10.j(71)   // integer - integer
 260 ;test10.j(72)   i=1038;
 261 acc16= constant 1038
 262 acc16=> variable 1
 263 ;test10.j(73)   b=41;
 264 acc8= constant 41
 265 acc8=> variable 0
 266 ;test10.j(74)   do { println (b); b++; i--; } while (1037 <= i);
 267 acc8= variable 0
 268 call writeLineAcc8
 269 incr8 variable 0
 270 decr16 variable 1
 271 acc16= variable 1
 272 acc16Comp constant 1037
 273 brge 267
 274 ;test10.j(75) 
 275 ;test10.j(76)   /************************/
 276 ;test10.j(77)   // constant - stack8
 277 ;test10.j(78)   // byte - byte
 278 ;test10.j(79)   //TODO
 279 ;test10.j(80)   println(43);
 280 acc8= constant 43
 281 call writeLineAcc8
 282 ;test10.j(81)   // constant - stack8
 283 ;test10.j(82)   // byte - integer
 284 ;test10.j(83)   //TODO
 285 ;test10.j(84)   println(44);
 286 acc8= constant 44
 287 call writeLineAcc8
 288 ;test10.j(85)   // constant - stack8
 289 ;test10.j(86)   // integer - byte
 290 ;test10.j(87)   //TODO
 291 ;test10.j(88)   println(45);
 292 acc8= constant 45
 293 call writeLineAcc8
 294 ;test10.j(89)   // constant - stack88
 295 ;test10.j(90)   // integer - integer
 296 ;test10.j(91)   //TODO
 297 ;test10.j(92)   println(46);
 298 acc8= constant 46
 299 call writeLineAcc8
 300 ;test10.j(93) 
 301 ;test10.j(94)   /************************/
 302 ;test10.j(95)   // constant - stack16
 303 ;test10.j(96)   // byte - byte
 304 ;test10.j(97)   //TODO
 305 ;test10.j(98)   println(47);
 306 acc8= constant 47
 307 call writeLineAcc8
 308 ;test10.j(99)   // constant - stack16
 309 ;test10.j(100)   // byte - integer
 310 ;test10.j(101)   //TODO
 311 ;test10.j(102)   println(48);
 312 acc8= constant 48
 313 call writeLineAcc8
 314 ;test10.j(103)   // constant - stack16
 315 ;test10.j(104)   // integer - byte
 316 ;test10.j(105)   //TODO
 317 ;test10.j(106)   println(49);
 318 acc8= constant 49
 319 call writeLineAcc8
 320 ;test10.j(107)   // constant - stack16
 321 ;test10.j(108)   // integer - integer
 322 ;test10.j(109)   //TODO
 323 ;test10.j(110)   println(50);
 324 acc8= constant 50
 325 call writeLineAcc8
 326 ;test10.j(111) 
 327 ;test10.j(112)   /************************/
 328 ;test10.j(113)   // acc - constant
 329 ;test10.j(114)   // byte - byte
 330 ;test10.j(115)   b=51;
 331 acc8= constant 51
 332 acc8=> variable 0
 333 ;test10.j(116)   do { println (b); b++; } while (b+0 <= 52);
 334 acc8= variable 0
 335 call writeLineAcc8
 336 incr8 variable 0
 337 acc8= variable 0
 338 acc8+ constant 0
 339 acc8Comp constant 52
 340 brle 334
 341 ;test10.j(117)   // byte - integer
 342 ;test10.j(118)   //not relevant
 343 ;test10.j(119)   // integer - byte
 344 ;test10.j(120)   i=53;
 345 acc8= constant 53
 346 acc8=> variable 1
 347 ;test10.j(121)   do { println (i); i++; } while (i+0 <= 54);
 348 acc16= variable 1
 349 call writeLineAcc16
 350 incr16 variable 1
 351 acc16= variable 1
 352 acc16+ constant 0
 353 acc8= constant 54
 354 acc16CompareAcc8
 355 brle 348
 356 ;test10.j(122) 
 357 ;test10.j(123)   b=55;
 358 acc8= constant 55
 359 acc8=> variable 0
 360 ;test10.j(124)   i=1055;
 361 acc16= constant 1055
 362 acc16=> variable 1
 363 ;test10.j(125)   // integer - integer
 364 ;test10.j(126)   do { println (b); b++; i++; } while (i+0 <= 1056);
 365 acc8= variable 0
 366 call writeLineAcc8
 367 incr8 variable 0
 368 incr16 variable 1
 369 acc16= variable 1
 370 acc16+ constant 0
 371 acc16Comp constant 1056
 372 brle 365
 373 ;test10.j(127) 
 374 ;test10.j(128)   /************************/
 375 ;test10.j(129)   // acc - acc
 376 ;test10.j(130)   // byte - byte
 377 ;test10.j(131)   b=57;
 378 acc8= constant 57
 379 acc8=> variable 0
 380 ;test10.j(132)   do { println (b); b++; } while (b+0 <= 58+0);
 381 acc8= variable 0
 382 call writeLineAcc8
 383 incr8 variable 0
 384 acc8= variable 0
 385 acc8+ constant 0
 386 <acc8
 387 acc8= constant 58
 388 acc8+ constant 0
 389 revAcc8Comp unstack8
 390 brge 381
 391 ;test10.j(133)   // byte - integer
 392 ;test10.j(134)   i=61;
 393 acc8= constant 61
 394 acc8=> variable 1
 395 ;test10.j(135)   do { println (b); b++; i--; } while (60+0 <= i+0);
 396 acc8= variable 0
 397 call writeLineAcc8
 398 incr8 variable 0
 399 decr16 variable 1
 400 acc8= constant 60
 401 acc8+ constant 0
 402 <acc8
 403 acc16= variable 1
 404 acc16+ constant 0
 405 acc8= unstack8
 406 acc8CompareAcc16
 407 brle 396
 408 ;test10.j(136)   // integer - byte
 409 ;test10.j(137)   i=61;
 410 acc8= constant 61
 411 acc8=> variable 1
 412 ;test10.j(138)   b=62;
 413 acc8= constant 62
 414 acc8=> variable 0
 415 ;test10.j(139)   do { println (i); i++; } while (i+0 <= b+0);
 416 acc16= variable 1
 417 call writeLineAcc16
 418 incr16 variable 1
 419 acc16= variable 1
 420 acc16+ constant 0
 421 <acc16
 422 acc8= variable 0
 423 acc8+ constant 0
 424 acc16= unstack16
 425 acc16CompareAcc8
 426 brle 416
 427 ;test10.j(140)   // integer - integer
 428 ;test10.j(141)   b=63;
 429 acc8= constant 63
 430 acc8=> variable 0
 431 ;test10.j(142)   i=1063;
 432 acc16= constant 1063
 433 acc16=> variable 1
 434 ;test10.j(143)   do { println (b); b++; i--; } while (1000+62 <= i+0);
 435 acc8= variable 0
 436 call writeLineAcc8
 437 incr8 variable 0
 438 decr16 variable 1
 439 acc16= constant 1000
 440 acc16+ constant 62
 441 <acc16
 442 acc16= variable 1
 443 acc16+ constant 0
 444 revAcc16Comp unstack16
 445 brge 435
 446 ;test10.j(144) 
 447 ;test10.j(145)   /************************/
 448 ;test10.j(146)   // acc - var
 449 ;test10.j(147)   // byte - byte
 450 ;test10.j(148)   b=65;
 451 acc8= constant 65
 452 acc8=> variable 0
 453 ;test10.j(149)   i=65;
 454 acc8= constant 65
 455 acc8=> variable 1
 456 ;test10.j(150)   do { println (i); i++; b--; } while (64+0 <= b);
 457 acc16= variable 1
 458 call writeLineAcc16
 459 incr16 variable 1
 460 decr8 variable 0
 461 acc8= constant 64
 462 acc8+ constant 0
 463 acc8Comp variable 0
 464 brle 457
 465 ;test10.j(151)   // byte - integer
 466 ;test10.j(152)   b=67;
 467 acc8= constant 67
 468 acc8=> variable 0
 469 ;test10.j(153)   i=67;
 470 acc8= constant 67
 471 acc8=> variable 1
 472 ;test10.j(154)   do { println (b); b++; i--; } while (66+0 <= i);
 473 acc8= variable 0
 474 call writeLineAcc8
 475 incr8 variable 0
 476 decr16 variable 1
 477 acc8= constant 66
 478 acc8+ constant 0
 479 acc16= variable 1
 480 acc8CompareAcc16
 481 brle 473
 482 ;test10.j(155)   // integer - byte
 483 ;test10.j(156)   i=69;
 484 acc8= constant 69
 485 acc8=> variable 1
 486 ;test10.j(157)   b=69;
 487 acc8= constant 69
 488 acc8=> variable 0
 489 ;test10.j(158)   do { println (i); i++; b--; } while (1000+68 <= b);
 490 acc16= variable 1
 491 call writeLineAcc16
 492 incr16 variable 1
 493 decr8 variable 0
 494 acc16= constant 1000
 495 acc16+ constant 68
 496 acc8= variable 0
 497 acc16CompareAcc8
 498 brle 490
 499 ;test10.j(159)   // integer - integer
 500 ;test10.j(160)   i=1071;
 501 acc16= constant 1071
 502 acc16=> variable 1
 503 ;test10.j(161)   b=70;
 504 acc8= constant 70
 505 acc8=> variable 0
 506 ;test10.j(162)   do { println (b); b++; i--; } while (1000+70 <= i);
 507 acc8= variable 0
 508 call writeLineAcc8
 509 incr8 variable 0
 510 decr16 variable 1
 511 acc16= constant 1000
 512 acc16+ constant 70
 513 acc16Comp variable 1
 514 brle 507
 515 ;test10.j(163) 
 516 ;test10.j(164)   /************************/
 517 ;test10.j(165)   // acc - stack16
 518 ;test10.j(166)   // byte - byte
 519 ;test10.j(167)   //TODO
 520 ;test10.j(168)   println(72);
 521 acc8= constant 72
 522 call writeLineAcc8
 523 ;test10.j(169)   println(73);
 524 acc8= constant 73
 525 call writeLineAcc8
 526 ;test10.j(170)   // byte - integer
 527 ;test10.j(171)   //TODO
 528 ;test10.j(172)   println(74);
 529 acc8= constant 74
 530 call writeLineAcc8
 531 ;test10.j(173)   println(75);
 532 acc8= constant 75
 533 call writeLineAcc8
 534 ;test10.j(174)   // integer - byte
 535 ;test10.j(175)   //TODO
 536 ;test10.j(176)   println(76);
 537 acc8= constant 76
 538 call writeLineAcc8
 539 ;test10.j(177)   println(77);
 540 acc8= constant 77
 541 call writeLineAcc8
 542 ;test10.j(178)   // integer - integer
 543 ;test10.j(179)   //TODO
 544 ;test10.j(180)   println(78);
 545 acc8= constant 78
 546 call writeLineAcc8
 547 ;test10.j(181)   println(79);
 548 acc8= constant 79
 549 call writeLineAcc8
 550 ;test10.j(182) 
 551 ;test10.j(183)   /************************/
 552 ;test10.j(184)   // acc - stack8
 553 ;test10.j(185)   // byte - byte
 554 ;test10.j(186)   //TODO
 555 ;test10.j(187)   println(80);
 556 acc8= constant 80
 557 call writeLineAcc8
 558 ;test10.j(188)   println(81);
 559 acc8= constant 81
 560 call writeLineAcc8
 561 ;test10.j(189)   // byte - integer
 562 ;test10.j(190)   //TODO
 563 ;test10.j(191)   println(82);
 564 acc8= constant 82
 565 call writeLineAcc8
 566 ;test10.j(192)   println(83);
 567 acc8= constant 83
 568 call writeLineAcc8
 569 ;test10.j(193)   // integer - byte
 570 ;test10.j(194)   //TODO
 571 ;test10.j(195)   println(84);
 572 acc8= constant 84
 573 call writeLineAcc8
 574 ;test10.j(196)   println(85);
 575 acc8= constant 85
 576 call writeLineAcc8
 577 ;test10.j(197)   // integer - integer
 578 ;test10.j(198)   //TODO
 579 ;test10.j(199)   println(86);
 580 acc8= constant 86
 581 call writeLineAcc8
 582 ;test10.j(200)   println(87);
 583 acc8= constant 87
 584 call writeLineAcc8
 585 ;test10.j(201) 
 586 ;test10.j(202)   /************************/
 587 ;test10.j(203)   // var - constant
 588 ;test10.j(204)   // byte - byte
 589 ;test10.j(205)   b=88;
 590 acc8= constant 88
 591 acc8=> variable 0
 592 ;test10.j(206)   do { println (b); b++; } while (b <= 89);
 593 acc8= variable 0
 594 call writeLineAcc8
 595 incr8 variable 0
 596 acc8= variable 0
 597 acc8Comp constant 89
 598 brle 593
 599 ;test10.j(207)   // byte - integer
 600 ;test10.j(208)   //not relevant
 601 ;test10.j(209)   println(90);
 602 acc8= constant 90
 603 call writeLineAcc8
 604 ;test10.j(210)   println(91);
 605 acc8= constant 91
 606 call writeLineAcc8
 607 ;test10.j(211)   // integer - byte
 608 ;test10.j(212)   i=92;
 609 acc8= constant 92
 610 acc8=> variable 1
 611 ;test10.j(213)   do { println (i); i++; } while (i <= 93);
 612 acc16= variable 1
 613 call writeLineAcc16
 614 incr16 variable 1
 615 acc16= variable 1
 616 acc8= constant 93
 617 acc16CompareAcc8
 618 brle 612
 619 ;test10.j(214)   // integer - integer
 620 ;test10.j(215)   i=1094;
 621 acc16= constant 1094
 622 acc16=> variable 1
 623 ;test10.j(216)   b=94;
 624 acc8= constant 94
 625 acc8=> variable 0
 626 ;test10.j(217)   do { println (b); b++; i++; } while (i <= 1095  );
 627 acc8= variable 0
 628 call writeLineAcc8
 629 incr8 variable 0
 630 incr16 variable 1
 631 acc16= variable 1
 632 acc16Comp constant 1095
 633 brle 627
 634 ;test10.j(218) 
 635 ;test10.j(219)   /************************/
 636 ;test10.j(220)   // var - acc
 637 ;test10.j(221)   // byte - byte
 638 ;test10.j(222)   do { println (b); b++; } while (b <= 97+0);
 639 acc8= variable 0
 640 call writeLineAcc8
 641 incr8 variable 0
 642 acc8= constant 97
 643 acc8+ constant 0
 644 acc8Comp variable 0
 645 brge 639
 646 ;test10.j(223)   // byte - integer
 647 ;test10.j(224)   //not relevant
 648 ;test10.j(225)   i=99;
 649 acc8= constant 99
 650 acc8=> variable 1
 651 ;test10.j(226)   do { println (b); b++; } while (b <= i+0);
 652 acc8= variable 0
 653 call writeLineAcc8
 654 incr8 variable 0
 655 acc16= variable 1
 656 acc16+ constant 0
 657 acc8= variable 0
 658 acc8CompareAcc16
 659 brle 652
 660 ;test10.j(227)   // integer - byte
 661 ;test10.j(228)   i=100;
 662 acc8= constant 100
 663 acc8=> variable 1
 664 ;test10.j(229)   do { println (i); i++; } while (i <= 101+0);
 665 acc16= variable 1
 666 call writeLineAcc16
 667 incr16 variable 1
 668 acc8= constant 101
 669 acc8+ constant 0
 670 acc16= variable 1
 671 acc16CompareAcc8
 672 brle 665
 673 ;test10.j(230)   // integer - integer
 674 ;test10.j(231)   i=1102;
 675 acc16= constant 1102
 676 acc16=> variable 1
 677 ;test10.j(232)   b=102;
 678 acc8= constant 102
 679 acc8=> variable 0
 680 ;test10.j(233)   do { println (b); b++; i++; } while (i <= 1103+0);
 681 acc8= variable 0
 682 call writeLineAcc8
 683 incr8 variable 0
 684 incr16 variable 1
 685 acc16= constant 1103
 686 acc16+ constant 0
 687 acc16Comp variable 1
 688 brge 681
 689 ;test10.j(234) 
 690 ;test10.j(235)   /************************/
 691 ;test10.j(236)   // var - var
 692 ;test10.j(237)   // byte - byte
 693 ;test10.j(238)   byte b2 = 105;
 694 acc8= constant 105
 695 acc8=> variable 5
 696 ;test10.j(239)   do { println (b); b++; } while (b <= b2);
 697 acc8= variable 0
 698 call writeLineAcc8
 699 incr8 variable 0
 700 acc8= variable 0
 701 acc8Comp variable 5
 702 brle 697
 703 ;test10.j(240)   // byte - integer
 704 ;test10.j(241)   i=107;
 705 acc8= constant 107
 706 acc8=> variable 1
 707 ;test10.j(242)   do { println (b); b++; } while (b <= i);
 708 acc8= variable 0
 709 call writeLineAcc8
 710 incr8 variable 0
 711 acc8= variable 0
 712 acc16= variable 1
 713 acc8CompareAcc16
 714 brle 708
 715 ;test10.j(243)   // integer - byte
 716 ;test10.j(244)   i=b;
 717 acc8= variable 0
 718 acc8=> variable 1
 719 ;test10.j(245)   b=109;
 720 acc8= constant 109
 721 acc8=> variable 0
 722 ;test10.j(246)   do { println (i); i++; } while (i <= b);
 723 acc16= variable 1
 724 call writeLineAcc16
 725 incr16 variable 1
 726 acc16= variable 1
 727 acc8= variable 0
 728 acc16CompareAcc8
 729 brle 723
 730 ;test10.j(247)   // integer - integer
 731 ;test10.j(248)   word i2 = 111;
 732 acc8= constant 111
 733 acc8=> variable 6
 734 ;test10.j(249)   do { println (i); i++; } while (i <= i2);
 735 acc16= variable 1
 736 call writeLineAcc16
 737 incr16 variable 1
 738 acc16= variable 1
 739 acc16Comp variable 6
 740 brle 735
 741 ;test10.j(250) 
 742 ;test10.j(251)   /************************/
 743 ;test10.j(252)   // var - stack8
 744 ;test10.j(253)   // byte - byte
 745 ;test10.j(254)   // byte - integer
 746 ;test10.j(255)   // integer - byte
 747 ;test10.j(256)   // integer - integer
 748 ;test10.j(257)   //TODO
 749 ;test10.j(258) 
 750 ;test10.j(259)   /************************/
 751 ;test10.j(260)   // var - stack16
 752 ;test10.j(261)   // byte - byte
 753 ;test10.j(262)   // byte - integer
 754 ;test10.j(263)   // integer - byte
 755 ;test10.j(264)   // integer - integer
 756 ;test10.j(265)   //TODO
 757 ;test10.j(266) 
 758 ;test10.j(267)   /************************/
 759 ;test10.j(268)   // stack8 - constant
 760 ;test10.j(269)   // stack8 - acc
 761 ;test10.j(270)   // stack8 - var
 762 ;test10.j(271)   // stack8 - stack8
 763 ;test10.j(272)   // stack8 - stack16
 764 ;test10.j(273)   //TODO
 765 ;test10.j(274) 
 766 ;test10.j(275)   /************************/
 767 ;test10.j(276)   // stack16 - constant
 768 ;test10.j(277)   // stack16 - acc
 769 ;test10.j(278)   // stack16 - var
 770 ;test10.j(279)   // stack16 - stack8
 771 ;test10.j(280)   // stack16 - stack16
 772 ;test10.j(281)   //TODO
 773 ;test10.j(282) 
 774 ;test10.j(283)   println("Klaar");
 775 acc16= constant 779
 776 writeLineString
 777 ;test10.j(284) }
 778 stop
 779 stringConstant 0 = "Klaar"
