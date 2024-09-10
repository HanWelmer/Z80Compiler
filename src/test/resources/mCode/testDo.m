   0 call 6
   1 stop
   2 ;testDo.j(0) /* Program to test generated Z80 assembler code */
   3 ;testDo.j(1) class TestDo {
   4 class TestDo []
   5 ;testDo.j(2)   private static byte b = 1;
   6 acc8= constant 1
   7 acc8=> variable 0
   8 ;testDo.j(3)   private static word i = 12;
   9 acc8= constant 12
  10 acc8=> variable 1
  11 ;testDo.j(4)   private static word p = 12;
  12 acc8= constant 12
  13 acc8=> variable 3
  14 br 17
  15 ;testDo.j(5) 
  16 ;testDo.j(6)   public static void main() {
  17 method TestDo.main [public, static] void ()
  18 <basePointer
  19 basePointer= stackPointer
  20 stackPointer+ constant 4
  21 ;testDo.j(7)     println(0);
  22 acc8= constant 0
  23 writeLineAcc8
  24 ;testDo.j(8)   
  25 ;testDo.j(9)     /************************/
  26 ;testDo.j(10)     // global variable within do scope
  27 ;testDo.j(11)     println (b);
  28 acc8= variable 0
  29 writeLineAcc8
  30 ;testDo.j(12)     b++;
  31 incr8 variable 0
  32 ;testDo.j(13)     do {
  33 ;testDo.j(14)       word j = 1001;
  34 acc16= constant 1001
  35 acc16=> (basePointer + -2)
  36 ;testDo.j(15)       byte c = b;
  37 acc8= variable 0
  38 acc8=> (basePointer + -3)
  39 ;testDo.j(16)       byte d = c;
  40 acc8= (basePointer + -3)
  41 acc8=> (basePointer + -4)
  42 ;testDo.j(17)       b++;
  43 incr8 variable 0
  44 ;testDo.j(18)       println (c);
  45 acc8= (basePointer + -3)
  46 writeLineAcc8
  47 ;testDo.j(19)     } while (b<2);
  48 acc8= variable 0
  49 acc8Comp constant 2
  50 brlt 33
  51 ;testDo.j(20)   
  52 ;testDo.j(21)     /************************/
  53 ;testDo.j(22)     // constant - constant
  54 ;testDo.j(23)     // not relevant
  55 ;testDo.j(24)   
  56 ;testDo.j(25)     /************************/
  57 ;testDo.j(26)     // constant - acc
  58 ;testDo.j(27)     // byte - byte
  59 ;testDo.j(28)     do { println (b); b++; } while (103 == b+100);
  60 acc8= variable 0
  61 writeLineAcc8
  62 incr8 variable 0
  63 acc8= variable 0
  64 acc8+ constant 100
  65 acc8Comp constant 103
  66 breq 60
  67 ;testDo.j(29)     do { println (b); b++; } while (106 != b+100);
  68 acc8= variable 0
  69 writeLineAcc8
  70 incr8 variable 0
  71 acc8= variable 0
  72 acc8+ constant 100
  73 acc8Comp constant 106
  74 brne 68
  75 ;testDo.j(30)     do { println (b); b++; } while (108 >  b+100);
  76 acc8= variable 0
  77 writeLineAcc8
  78 incr8 variable 0
  79 acc8= variable 0
  80 acc8+ constant 100
  81 acc8Comp constant 108
  82 brlt 76
  83 ;testDo.j(31)     do { println (b); b++; } while (109 >= b+100);
  84 acc8= variable 0
  85 writeLineAcc8
  86 incr8 variable 0
  87 acc8= variable 0
  88 acc8+ constant 100
  89 acc8Comp constant 109
  90 brle 84
  91 ;testDo.j(32)     p=10;
  92 acc8= constant 10
  93 acc8=> variable 3
  94 ;testDo.j(33)     do { println (p); p++; b--; } while (108 <  b+100);
  95 acc16= variable 3
  96 writeLineAcc16
  97 incr16 variable 3
  98 decr8 variable 0
  99 acc8= variable 0
 100 acc8+ constant 100
 101 acc8Comp constant 108
 102 brgt 95
 103 ;testDo.j(34)     do { println (p); p++; b--; } while (107 <= b+100);
 104 acc16= variable 3
 105 writeLineAcc16
 106 incr16 variable 3
 107 decr8 variable 0
 108 acc8= variable 0
 109 acc8+ constant 100
 110 acc8Comp constant 107
 111 brge 104
 112 ;testDo.j(35)   
 113 ;testDo.j(36)     // constant - acc
 114 ;testDo.j(37)     // byte - integer
 115 ;testDo.j(38)     i=14;
 116 acc8= constant 14
 117 acc8=> variable 1
 118 ;testDo.j(39)     do { println (i); i++; } while (15 == i+0);
 119 acc16= variable 1
 120 writeLineAcc16
 121 incr16 variable 1
 122 acc16= variable 1
 123 acc16+ constant 0
 124 acc8= constant 15
 125 acc8CompareAcc16
 126 breq 119
 127 ;testDo.j(40)     do { println (i); i++; } while (18 != i+0);
 128 acc16= variable 1
 129 writeLineAcc16
 130 incr16 variable 1
 131 acc16= variable 1
 132 acc16+ constant 0
 133 acc8= constant 18
 134 acc8CompareAcc16
 135 brne 128
 136 ;testDo.j(41)     do { println (i); i++; } while (20 >  i+0);
 137 acc16= variable 1
 138 writeLineAcc16
 139 incr16 variable 1
 140 acc16= variable 1
 141 acc16+ constant 0
 142 acc8= constant 20
 143 acc8CompareAcc16
 144 brgt 137
 145 ;testDo.j(42)     do { println (i); i++; } while (21 >= i+0);
 146 acc16= variable 1
 147 writeLineAcc16
 148 incr16 variable 1
 149 acc16= variable 1
 150 acc16+ constant 0
 151 acc8= constant 21
 152 acc8CompareAcc16
 153 brge 146
 154 ;testDo.j(43)     p=22;
 155 acc8= constant 22
 156 acc8=> variable 3
 157 ;testDo.j(44)     do { println (p); p++; i--; } while (20 <  i+0);
 158 acc16= variable 3
 159 writeLineAcc16
 160 incr16 variable 3
 161 decr16 variable 1
 162 acc16= variable 1
 163 acc16+ constant 0
 164 acc8= constant 20
 165 acc8CompareAcc16
 166 brlt 158
 167 ;testDo.j(45)     do { println (p); p++; i--; } while (19 <= i+0);
 168 acc16= variable 3
 169 writeLineAcc16
 170 incr16 variable 3
 171 decr16 variable 1
 172 acc16= variable 1
 173 acc16+ constant 0
 174 acc8= constant 19
 175 acc8CompareAcc16
 176 brle 168
 177 ;testDo.j(46)   
 178 ;testDo.j(47)     // constant - acc
 179 ;testDo.j(48)     // integer - byte
 180 ;testDo.j(49)     // not relevant
 181 ;testDo.j(50)   
 182 ;testDo.j(51)     // constant - acc
 183 ;testDo.j(52)     // integer - integer
 184 ;testDo.j(53)     i=p;
 185 acc16= variable 3
 186 acc16=> variable 1
 187 ;testDo.j(54)     do { println (i); i++; } while (1027 == i+1000);
 188 acc16= variable 1
 189 writeLineAcc16
 190 incr16 variable 1
 191 acc16= variable 1
 192 acc16+ constant 1000
 193 acc16Comp constant 1027
 194 breq 188
 195 ;testDo.j(55)     do { println (i); i++; } while (1029 != i+1000);
 196 acc16= variable 1
 197 writeLineAcc16
 198 incr16 variable 1
 199 acc16= variable 1
 200 acc16+ constant 1000
 201 acc16Comp constant 1029
 202 brne 196
 203 ;testDo.j(56)     do { println (i); i++; } while (1031 >  i+1000);
 204 acc16= variable 1
 205 writeLineAcc16
 206 incr16 variable 1
 207 acc16= variable 1
 208 acc16+ constant 1000
 209 acc16Comp constant 1031
 210 brlt 204
 211 ;testDo.j(57)     do { println (i); i++; } while (1032 >= i+1000);
 212 acc16= variable 1
 213 writeLineAcc16
 214 incr16 variable 1
 215 acc16= variable 1
 216 acc16+ constant 1000
 217 acc16Comp constant 1032
 218 brle 212
 219 ;testDo.j(58)     p=i;
 220 acc16= variable 1
 221 acc16=> variable 3
 222 ;testDo.j(59)     do { println (p); p++; i--; } while (1031 <  i+1000);
 223 acc16= variable 3
 224 writeLineAcc16
 225 incr16 variable 3
 226 decr16 variable 1
 227 acc16= variable 1
 228 acc16+ constant 1000
 229 acc16Comp constant 1031
 230 brgt 223
 231 ;testDo.j(60)     do { println (p); p++; i--; } while (1030 <= i+1000);
 232 acc16= variable 3
 233 writeLineAcc16
 234 incr16 variable 3
 235 decr16 variable 1
 236 acc16= variable 1
 237 acc16+ constant 1000
 238 acc16Comp constant 1030
 239 brge 232
 240 ;testDo.j(61)   
 241 ;testDo.j(62)     /************************/
 242 ;testDo.j(63)     // constant - var
 243 ;testDo.j(64)     // byte - byte
 244 ;testDo.j(65)     b=37;
 245 acc8= constant 37
 246 acc8=> variable 0
 247 ;testDo.j(66)     do { println (b); b++; } while (38 >= b);
 248 acc8= variable 0
 249 writeLineAcc8
 250 incr8 variable 0
 251 acc8= variable 0
 252 acc8Comp constant 38
 253 brle 248
 254 ;testDo.j(67)     // byte - integer
 255 ;testDo.j(68)     i=39;
 256 acc8= constant 39
 257 acc8=> variable 1
 258 ;testDo.j(69)     do { println (i); i++; } while (40 >= i);
 259 acc16= variable 1
 260 writeLineAcc16
 261 incr16 variable 1
 262 acc16= variable 1
 263 acc8= constant 40
 264 acc8CompareAcc16
 265 brge 259
 266 ;testDo.j(70)     // integer - byte
 267 ;testDo.j(71)     // not relevant
 268 ;testDo.j(72)     // integer - integer
 269 ;testDo.j(73)     i=1038;
 270 acc16= constant 1038
 271 acc16=> variable 1
 272 ;testDo.j(74)     b=41;
 273 acc8= constant 41
 274 acc8=> variable 0
 275 ;testDo.j(75)     do { println (b); b++; i--; } while (1037 <= i);
 276 acc8= variable 0
 277 writeLineAcc8
 278 incr8 variable 0
 279 decr16 variable 1
 280 acc16= variable 1
 281 acc16Comp constant 1037
 282 brge 276
 283 ;testDo.j(76)   
 284 ;testDo.j(77)     /************************/
 285 ;testDo.j(78)     // constant - stack8
 286 ;testDo.j(79)     // byte - byte
 287 ;testDo.j(80)     //TODO
 288 ;testDo.j(81)     println(43);
 289 acc8= constant 43
 290 writeLineAcc8
 291 ;testDo.j(82)     // constant - stack8
 292 ;testDo.j(83)     // byte - integer
 293 ;testDo.j(84)     //TODO
 294 ;testDo.j(85)     println(44);
 295 acc8= constant 44
 296 writeLineAcc8
 297 ;testDo.j(86)     // constant - stack8
 298 ;testDo.j(87)     // integer - byte
 299 ;testDo.j(88)     //TODO
 300 ;testDo.j(89)     println(45);
 301 acc8= constant 45
 302 writeLineAcc8
 303 ;testDo.j(90)     // constant - stack88
 304 ;testDo.j(91)     // integer - integer
 305 ;testDo.j(92)     //TODO
 306 ;testDo.j(93)     println(46);
 307 acc8= constant 46
 308 writeLineAcc8
 309 ;testDo.j(94)   
 310 ;testDo.j(95)     /************************/
 311 ;testDo.j(96)     // constant - stack16
 312 ;testDo.j(97)     // byte - byte
 313 ;testDo.j(98)     //TODO
 314 ;testDo.j(99)     println(47);
 315 acc8= constant 47
 316 writeLineAcc8
 317 ;testDo.j(100)     // constant - stack16
 318 ;testDo.j(101)     // byte - integer
 319 ;testDo.j(102)     //TODO
 320 ;testDo.j(103)     println(48);
 321 acc8= constant 48
 322 writeLineAcc8
 323 ;testDo.j(104)     // constant - stack16
 324 ;testDo.j(105)     // integer - byte
 325 ;testDo.j(106)     //TODO
 326 ;testDo.j(107)     println(49);
 327 acc8= constant 49
 328 writeLineAcc8
 329 ;testDo.j(108)     // constant - stack16
 330 ;testDo.j(109)     // integer - integer
 331 ;testDo.j(110)     //TODO
 332 ;testDo.j(111)     println(50);
 333 acc8= constant 50
 334 writeLineAcc8
 335 ;testDo.j(112)   
 336 ;testDo.j(113)     /************************/
 337 ;testDo.j(114)     // acc - constant
 338 ;testDo.j(115)     // byte - byte
 339 ;testDo.j(116)     b=51;
 340 acc8= constant 51
 341 acc8=> variable 0
 342 ;testDo.j(117)     do { println (b); b++; } while (b+0 <= 52);
 343 acc8= variable 0
 344 writeLineAcc8
 345 incr8 variable 0
 346 acc8= variable 0
 347 acc8+ constant 0
 348 acc8Comp constant 52
 349 brle 343
 350 ;testDo.j(118)     // byte - integer
 351 ;testDo.j(119)     //not relevant
 352 ;testDo.j(120)     // integer - byte
 353 ;testDo.j(121)     i=53;
 354 acc8= constant 53
 355 acc8=> variable 1
 356 ;testDo.j(122)     do { println (i); i++; } while (i+0 <= 54);
 357 acc16= variable 1
 358 writeLineAcc16
 359 incr16 variable 1
 360 acc16= variable 1
 361 acc16+ constant 0
 362 acc8= constant 54
 363 acc16CompareAcc8
 364 brle 357
 365 ;testDo.j(123)   
 366 ;testDo.j(124)     b=55;
 367 acc8= constant 55
 368 acc8=> variable 0
 369 ;testDo.j(125)     i=1055;
 370 acc16= constant 1055
 371 acc16=> variable 1
 372 ;testDo.j(126)     // integer - integer
 373 ;testDo.j(127)     do { println (b); b++; i++; } while (i+0 <= 1056);
 374 acc8= variable 0
 375 writeLineAcc8
 376 incr8 variable 0
 377 incr16 variable 1
 378 acc16= variable 1
 379 acc16+ constant 0
 380 acc16Comp constant 1056
 381 brle 374
 382 ;testDo.j(128)   
 383 ;testDo.j(129)     /************************/
 384 ;testDo.j(130)     // acc - acc
 385 ;testDo.j(131)     // byte - byte
 386 ;testDo.j(132)     b=57;
 387 acc8= constant 57
 388 acc8=> variable 0
 389 ;testDo.j(133)     do { println (b); b++; } while (b+0 <= 58+0);
 390 acc8= variable 0
 391 writeLineAcc8
 392 incr8 variable 0
 393 acc8= variable 0
 394 acc8+ constant 0
 395 <acc8
 396 acc8= constant 58
 397 acc8+ constant 0
 398 revAcc8Comp unstack8
 399 brge 390
 400 ;testDo.j(134)     // byte - integer
 401 ;testDo.j(135)     i=61;
 402 acc8= constant 61
 403 acc8=> variable 1
 404 ;testDo.j(136)     do { println (b); b++; i--; } while (60+0 <= i+0);
 405 acc8= variable 0
 406 writeLineAcc8
 407 incr8 variable 0
 408 decr16 variable 1
 409 acc8= constant 60
 410 acc8+ constant 0
 411 <acc8
 412 acc16= variable 1
 413 acc16+ constant 0
 414 acc8<
 415 acc8CompareAcc16
 416 brle 405
 417 ;testDo.j(137)     // integer - byte
 418 ;testDo.j(138)     i=61;
 419 acc8= constant 61
 420 acc8=> variable 1
 421 ;testDo.j(139)     b=62;
 422 acc8= constant 62
 423 acc8=> variable 0
 424 ;testDo.j(140)     do { println (i); i++; } while (i+0 <= b+0);
 425 acc16= variable 1
 426 writeLineAcc16
 427 incr16 variable 1
 428 acc16= variable 1
 429 acc16+ constant 0
 430 <acc16
 431 acc8= variable 0
 432 acc8+ constant 0
 433 acc16<
 434 acc16CompareAcc8
 435 brle 425
 436 ;testDo.j(141)     // integer - integer
 437 ;testDo.j(142)     b=63;
 438 acc8= constant 63
 439 acc8=> variable 0
 440 ;testDo.j(143)     i=1063;
 441 acc16= constant 1063
 442 acc16=> variable 1
 443 ;testDo.j(144)     do { println (b); b++; i--; } while (1000+62 <= i+0);
 444 acc8= variable 0
 445 writeLineAcc8
 446 incr8 variable 0
 447 decr16 variable 1
 448 acc16= constant 1000
 449 acc16+ constant 62
 450 <acc16
 451 acc16= variable 1
 452 acc16+ constant 0
 453 revAcc16Comp unstack16
 454 brge 444
 455 ;testDo.j(145)   
 456 ;testDo.j(146)     /************************/
 457 ;testDo.j(147)     // acc - var
 458 ;testDo.j(148)     // byte - byte
 459 ;testDo.j(149)     b=65;
 460 acc8= constant 65
 461 acc8=> variable 0
 462 ;testDo.j(150)     i=65;
 463 acc8= constant 65
 464 acc8=> variable 1
 465 ;testDo.j(151)     do { println (i); i++; b--; } while (64+0 <= b);
 466 acc16= variable 1
 467 writeLineAcc16
 468 incr16 variable 1
 469 decr8 variable 0
 470 acc8= constant 64
 471 acc8+ constant 0
 472 acc8Comp variable 0
 473 brle 466
 474 ;testDo.j(152)     // byte - integer
 475 ;testDo.j(153)     b=67;
 476 acc8= constant 67
 477 acc8=> variable 0
 478 ;testDo.j(154)     i=67;
 479 acc8= constant 67
 480 acc8=> variable 1
 481 ;testDo.j(155)     do { println (b); b++; i--; } while (66+0 <= i);
 482 acc8= variable 0
 483 writeLineAcc8
 484 incr8 variable 0
 485 decr16 variable 1
 486 acc8= constant 66
 487 acc8+ constant 0
 488 acc16= variable 1
 489 acc8CompareAcc16
 490 brle 482
 491 ;testDo.j(156)     // integer - byte
 492 ;testDo.j(157)     i=69;
 493 acc8= constant 69
 494 acc8=> variable 1
 495 ;testDo.j(158)     b=69;
 496 acc8= constant 69
 497 acc8=> variable 0
 498 ;testDo.j(159)     do { println (i); i++; b--; } while (1000+68 <= b);
 499 acc16= variable 1
 500 writeLineAcc16
 501 incr16 variable 1
 502 decr8 variable 0
 503 acc16= constant 1000
 504 acc16+ constant 68
 505 acc8= variable 0
 506 acc16CompareAcc8
 507 brle 499
 508 ;testDo.j(160)     // integer - integer
 509 ;testDo.j(161)     i=1071;
 510 acc16= constant 1071
 511 acc16=> variable 1
 512 ;testDo.j(162)     b=70;
 513 acc8= constant 70
 514 acc8=> variable 0
 515 ;testDo.j(163)     do { println (b); b++; i--; } while (1000+70 <= i);
 516 acc8= variable 0
 517 writeLineAcc8
 518 incr8 variable 0
 519 decr16 variable 1
 520 acc16= constant 1000
 521 acc16+ constant 70
 522 acc16Comp variable 1
 523 brle 516
 524 ;testDo.j(164)   
 525 ;testDo.j(165)     /************************/
 526 ;testDo.j(166)     // acc - stack16
 527 ;testDo.j(167)     // byte - byte
 528 ;testDo.j(168)     //TODO
 529 ;testDo.j(169)     println(72);
 530 acc8= constant 72
 531 writeLineAcc8
 532 ;testDo.j(170)     println(73);
 533 acc8= constant 73
 534 writeLineAcc8
 535 ;testDo.j(171)     // byte - integer
 536 ;testDo.j(172)     //TODO
 537 ;testDo.j(173)     println(74);
 538 acc8= constant 74
 539 writeLineAcc8
 540 ;testDo.j(174)     println(75);
 541 acc8= constant 75
 542 writeLineAcc8
 543 ;testDo.j(175)     // integer - byte
 544 ;testDo.j(176)     //TODO
 545 ;testDo.j(177)     println(76);
 546 acc8= constant 76
 547 writeLineAcc8
 548 ;testDo.j(178)     println(77);
 549 acc8= constant 77
 550 writeLineAcc8
 551 ;testDo.j(179)     // integer - integer
 552 ;testDo.j(180)     //TODO
 553 ;testDo.j(181)     println(78);
 554 acc8= constant 78
 555 writeLineAcc8
 556 ;testDo.j(182)     println(79);
 557 acc8= constant 79
 558 writeLineAcc8
 559 ;testDo.j(183)   
 560 ;testDo.j(184)     /************************/
 561 ;testDo.j(185)     // acc - stack8
 562 ;testDo.j(186)     // byte - byte
 563 ;testDo.j(187)     //TODO
 564 ;testDo.j(188)     println(80);
 565 acc8= constant 80
 566 writeLineAcc8
 567 ;testDo.j(189)     println(81);
 568 acc8= constant 81
 569 writeLineAcc8
 570 ;testDo.j(190)     // byte - integer
 571 ;testDo.j(191)     //TODO
 572 ;testDo.j(192)     println(82);
 573 acc8= constant 82
 574 writeLineAcc8
 575 ;testDo.j(193)     println(83);
 576 acc8= constant 83
 577 writeLineAcc8
 578 ;testDo.j(194)     // integer - byte
 579 ;testDo.j(195)     //TODO
 580 ;testDo.j(196)     println(84);
 581 acc8= constant 84
 582 writeLineAcc8
 583 ;testDo.j(197)     println(85);
 584 acc8= constant 85
 585 writeLineAcc8
 586 ;testDo.j(198)     // integer - integer
 587 ;testDo.j(199)     //TODO
 588 ;testDo.j(200)     println(86);
 589 acc8= constant 86
 590 writeLineAcc8
 591 ;testDo.j(201)     println(87);
 592 acc8= constant 87
 593 writeLineAcc8
 594 ;testDo.j(202)   
 595 ;testDo.j(203)     /************************/
 596 ;testDo.j(204)     // var - constant
 597 ;testDo.j(205)     // byte - byte
 598 ;testDo.j(206)     b=88;
 599 acc8= constant 88
 600 acc8=> variable 0
 601 ;testDo.j(207)     do { println (b); b++; } while (b <= 89);
 602 acc8= variable 0
 603 writeLineAcc8
 604 incr8 variable 0
 605 acc8= variable 0
 606 acc8Comp constant 89
 607 brle 602
 608 ;testDo.j(208)     // byte - integer
 609 ;testDo.j(209)     //not relevant
 610 ;testDo.j(210)     println(90);
 611 acc8= constant 90
 612 writeLineAcc8
 613 ;testDo.j(211)     println(91);
 614 acc8= constant 91
 615 writeLineAcc8
 616 ;testDo.j(212)     // integer - byte
 617 ;testDo.j(213)     i=92;
 618 acc8= constant 92
 619 acc8=> variable 1
 620 ;testDo.j(214)     do { println (i); i++; } while (i <= 93);
 621 acc16= variable 1
 622 writeLineAcc16
 623 incr16 variable 1
 624 acc16= variable 1
 625 acc8= constant 93
 626 acc16CompareAcc8
 627 brle 621
 628 ;testDo.j(215)     // integer - integer
 629 ;testDo.j(216)     i=1094;
 630 acc16= constant 1094
 631 acc16=> variable 1
 632 ;testDo.j(217)     b=94;
 633 acc8= constant 94
 634 acc8=> variable 0
 635 ;testDo.j(218)     do { println (b); b++; i++; } while (i <= 1095  );
 636 acc8= variable 0
 637 writeLineAcc8
 638 incr8 variable 0
 639 incr16 variable 1
 640 acc16= variable 1
 641 acc16Comp constant 1095
 642 brle 636
 643 ;testDo.j(219)   
 644 ;testDo.j(220)     /************************/
 645 ;testDo.j(221)     // var - acc
 646 ;testDo.j(222)     // byte - byte
 647 ;testDo.j(223)     do { println (b); b++; } while (b <= 97+0);
 648 acc8= variable 0
 649 writeLineAcc8
 650 incr8 variable 0
 651 acc8= constant 97
 652 acc8+ constant 0
 653 acc8Comp variable 0
 654 brge 648
 655 ;testDo.j(224)     // byte - integer
 656 ;testDo.j(225)     //not relevant
 657 ;testDo.j(226)     i=99;
 658 acc8= constant 99
 659 acc8=> variable 1
 660 ;testDo.j(227)     do { println (b); b++; } while (b <= i+0);
 661 acc8= variable 0
 662 writeLineAcc8
 663 incr8 variable 0
 664 acc16= variable 1
 665 acc16+ constant 0
 666 acc8= variable 0
 667 acc8CompareAcc16
 668 brle 661
 669 ;testDo.j(228)     // integer - byte
 670 ;testDo.j(229)     i=100;
 671 acc8= constant 100
 672 acc8=> variable 1
 673 ;testDo.j(230)     do { println (i); i++; } while (i <= 101+0);
 674 acc16= variable 1
 675 writeLineAcc16
 676 incr16 variable 1
 677 acc8= constant 101
 678 acc8+ constant 0
 679 acc16= variable 1
 680 acc16CompareAcc8
 681 brle 674
 682 ;testDo.j(231)     // integer - integer
 683 ;testDo.j(232)     i=1102;
 684 acc16= constant 1102
 685 acc16=> variable 1
 686 ;testDo.j(233)     b=102;
 687 acc8= constant 102
 688 acc8=> variable 0
 689 ;testDo.j(234)     do { println (b); b++; i++; } while (i <= 1103+0);
 690 acc8= variable 0
 691 writeLineAcc8
 692 incr8 variable 0
 693 incr16 variable 1
 694 acc16= constant 1103
 695 acc16+ constant 0
 696 acc16Comp variable 1
 697 brge 690
 698 ;testDo.j(235)   
 699 ;testDo.j(236)     /************************/
 700 ;testDo.j(237)     // var - var
 701 ;testDo.j(238)     // byte - byte
 702 ;testDo.j(239)     byte b2 = 105;
 703 acc8= constant 105
 704 acc8=> (basePointer + -1)
 705 ;testDo.j(240)     do { println (b); b++; } while (b <= b2);
 706 acc8= variable 0
 707 writeLineAcc8
 708 incr8 variable 0
 709 acc8= variable 0
 710 acc8Comp (basePointer + -1)
 711 brle 706
 712 ;testDo.j(241)     // byte - integer
 713 ;testDo.j(242)     i=107;
 714 acc8= constant 107
 715 acc8=> variable 1
 716 ;testDo.j(243)     do { println (b); b++; } while (b <= i);
 717 acc8= variable 0
 718 writeLineAcc8
 719 incr8 variable 0
 720 acc8= variable 0
 721 acc16= variable 1
 722 acc8CompareAcc16
 723 brle 717
 724 ;testDo.j(244)     // integer - byte
 725 ;testDo.j(245)     i=b;
 726 acc8= variable 0
 727 acc8=> variable 1
 728 ;testDo.j(246)     b=109;
 729 acc8= constant 109
 730 acc8=> variable 0
 731 ;testDo.j(247)     do { println (i); i++; } while (i <= b);
 732 acc16= variable 1
 733 writeLineAcc16
 734 incr16 variable 1
 735 acc16= variable 1
 736 acc8= variable 0
 737 acc16CompareAcc8
 738 brle 732
 739 ;testDo.j(248)     // integer - integer
 740 ;testDo.j(249)     word i2 = 111;
 741 acc8= constant 111
 742 acc8=> (basePointer + -3)
 743 ;testDo.j(250)     do { println (i); i++; } while (i <= i2);
 744 acc16= variable 1
 745 writeLineAcc16
 746 incr16 variable 1
 747 acc16= variable 1
 748 acc16Comp (basePointer + -3)
 749 brle 744
 750 ;testDo.j(251)   
 751 ;testDo.j(252)     /************************/
 752 ;testDo.j(253)     // var - stack8
 753 ;testDo.j(254)     // byte - byte
 754 ;testDo.j(255)     // byte - integer
 755 ;testDo.j(256)     // integer - byte
 756 ;testDo.j(257)     // integer - integer
 757 ;testDo.j(258)     //TODO
 758 ;testDo.j(259)   
 759 ;testDo.j(260)     /************************/
 760 ;testDo.j(261)     // var - stack16
 761 ;testDo.j(262)     // byte - byte
 762 ;testDo.j(263)     // byte - integer
 763 ;testDo.j(264)     // integer - byte
 764 ;testDo.j(265)     // integer - integer
 765 ;testDo.j(266)     //TODO
 766 ;testDo.j(267)   
 767 ;testDo.j(268)     /************************/
 768 ;testDo.j(269)     // stack8 - constant
 769 ;testDo.j(270)     // stack8 - acc
 770 ;testDo.j(271)     // stack8 - var
 771 ;testDo.j(272)     // stack8 - stack8
 772 ;testDo.j(273)     // stack8 - stack16
 773 ;testDo.j(274)     //TODO
 774 ;testDo.j(275)   
 775 ;testDo.j(276)     /************************/
 776 ;testDo.j(277)     // stack16 - constant
 777 ;testDo.j(278)     // stack16 - acc
 778 ;testDo.j(279)     // stack16 - var
 779 ;testDo.j(280)     // stack16 - stack8
 780 ;testDo.j(281)     // stack16 - stack16
 781 ;testDo.j(282)     //TODO
 782 ;testDo.j(283)   
 783 ;testDo.j(284)     println("Klaar");
 784 acc16= stringconstant 791
 785 writeLineString
 786 ;testDo.j(285)   }
 787 stackPointer= basePointer
 788 basePointer<
 789 return
 790 ;testDo.j(286) }
 791 stringConstant 0 = "Klaar"
