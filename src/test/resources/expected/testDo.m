   0 call 16
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
  14 ;testDo.j(5) 
  15 ;testDo.j(6)   public static void main() {
  16 method main [public, static] void ()
  17 <basePointer
  18 basePointer= stackPointer
  19 stackPointer+ constant 4
  20 ;testDo.j(7)     println(0);
  21 acc8= constant 0
  22 writeLineAcc8
  23 ;testDo.j(8)   
  24 ;testDo.j(9)     /************************/
  25 ;testDo.j(10)     // global variable within do scope
  26 ;testDo.j(11)     println (b);
  27 acc8= variable 0
  28 writeLineAcc8
  29 ;testDo.j(12)     b++;
  30 incr8 variable 0
  31 ;testDo.j(13)     do {
  32 ;testDo.j(14)       word j = 1001;
  33 acc16= constant 1001
  34 acc16=> (basePointer + -2)
  35 ;testDo.j(15)       byte c = b;
  36 acc8= variable 0
  37 acc8=> (basePointer + -3)
  38 ;testDo.j(16)       byte d = c;
  39 acc8= (basePointer + -3)
  40 acc8=> (basePointer + -4)
  41 ;testDo.j(17)       b++;
  42 incr8 variable 0
  43 ;testDo.j(18)       println (c);
  44 acc8= (basePointer + -3)
  45 writeLineAcc8
  46 ;testDo.j(19)     } while (b<2);
  47 acc8= variable 0
  48 acc8Comp constant 2
  49 brlt 32
  50 ;testDo.j(20)   
  51 ;testDo.j(21)     /************************/
  52 ;testDo.j(22)     // constant - constant
  53 ;testDo.j(23)     // not relevant
  54 ;testDo.j(24)   
  55 ;testDo.j(25)     /************************/
  56 ;testDo.j(26)     // constant - acc
  57 ;testDo.j(27)     // byte - byte
  58 ;testDo.j(28)     do { println (b); b++; } while (103 == b+100);
  59 acc8= variable 0
  60 writeLineAcc8
  61 incr8 variable 0
  62 acc8= variable 0
  63 acc8+ constant 100
  64 acc8Comp constant 103
  65 breq 59
  66 ;testDo.j(29)     do { println (b); b++; } while (106 != b+100);
  67 acc8= variable 0
  68 writeLineAcc8
  69 incr8 variable 0
  70 acc8= variable 0
  71 acc8+ constant 100
  72 acc8Comp constant 106
  73 brne 67
  74 ;testDo.j(30)     do { println (b); b++; } while (108 >  b+100);
  75 acc8= variable 0
  76 writeLineAcc8
  77 incr8 variable 0
  78 acc8= variable 0
  79 acc8+ constant 100
  80 acc8Comp constant 108
  81 brlt 75
  82 ;testDo.j(31)     do { println (b); b++; } while (109 >= b+100);
  83 acc8= variable 0
  84 writeLineAcc8
  85 incr8 variable 0
  86 acc8= variable 0
  87 acc8+ constant 100
  88 acc8Comp constant 109
  89 brle 83
  90 ;testDo.j(32)     p=10;
  91 acc8= constant 10
  92 acc8=> variable 3
  93 ;testDo.j(33)     do { println (p); p++; b--; } while (108 <  b+100);
  94 acc16= variable 3
  95 writeLineAcc16
  96 incr16 variable 3
  97 decr8 variable 0
  98 acc8= variable 0
  99 acc8+ constant 100
 100 acc8Comp constant 108
 101 brgt 94
 102 ;testDo.j(34)     do { println (p); p++; b--; } while (107 <= b+100);
 103 acc16= variable 3
 104 writeLineAcc16
 105 incr16 variable 3
 106 decr8 variable 0
 107 acc8= variable 0
 108 acc8+ constant 100
 109 acc8Comp constant 107
 110 brge 103
 111 ;testDo.j(35)   
 112 ;testDo.j(36)     // constant - acc
 113 ;testDo.j(37)     // byte - integer
 114 ;testDo.j(38)     i=14;
 115 acc8= constant 14
 116 acc8=> variable 1
 117 ;testDo.j(39)     do { println (i); i++; } while (15 == i+0);
 118 acc16= variable 1
 119 writeLineAcc16
 120 incr16 variable 1
 121 acc16= variable 1
 122 acc16+ constant 0
 123 acc8= constant 15
 124 acc8CompareAcc16
 125 breq 118
 126 ;testDo.j(40)     do { println (i); i++; } while (18 != i+0);
 127 acc16= variable 1
 128 writeLineAcc16
 129 incr16 variable 1
 130 acc16= variable 1
 131 acc16+ constant 0
 132 acc8= constant 18
 133 acc8CompareAcc16
 134 brne 127
 135 ;testDo.j(41)     do { println (i); i++; } while (20 >  i+0);
 136 acc16= variable 1
 137 writeLineAcc16
 138 incr16 variable 1
 139 acc16= variable 1
 140 acc16+ constant 0
 141 acc8= constant 20
 142 acc8CompareAcc16
 143 brgt 136
 144 ;testDo.j(42)     do { println (i); i++; } while (21 >= i+0);
 145 acc16= variable 1
 146 writeLineAcc16
 147 incr16 variable 1
 148 acc16= variable 1
 149 acc16+ constant 0
 150 acc8= constant 21
 151 acc8CompareAcc16
 152 brge 145
 153 ;testDo.j(43)     p=22;
 154 acc8= constant 22
 155 acc8=> variable 3
 156 ;testDo.j(44)     do { println (p); p++; i--; } while (20 <  i+0);
 157 acc16= variable 3
 158 writeLineAcc16
 159 incr16 variable 3
 160 decr16 variable 1
 161 acc16= variable 1
 162 acc16+ constant 0
 163 acc8= constant 20
 164 acc8CompareAcc16
 165 brlt 157
 166 ;testDo.j(45)     do { println (p); p++; i--; } while (19 <= i+0);
 167 acc16= variable 3
 168 writeLineAcc16
 169 incr16 variable 3
 170 decr16 variable 1
 171 acc16= variable 1
 172 acc16+ constant 0
 173 acc8= constant 19
 174 acc8CompareAcc16
 175 brle 167
 176 ;testDo.j(46)   
 177 ;testDo.j(47)     // constant - acc
 178 ;testDo.j(48)     // integer - byte
 179 ;testDo.j(49)     // not relevant
 180 ;testDo.j(50)   
 181 ;testDo.j(51)     // constant - acc
 182 ;testDo.j(52)     // integer - integer
 183 ;testDo.j(53)     i=p;
 184 acc16= variable 3
 185 acc16=> variable 1
 186 ;testDo.j(54)     do { println (i); i++; } while (1027 == i+1000);
 187 acc16= variable 1
 188 writeLineAcc16
 189 incr16 variable 1
 190 acc16= variable 1
 191 acc16+ constant 1000
 192 acc16Comp constant 1027
 193 breq 187
 194 ;testDo.j(55)     do { println (i); i++; } while (1029 != i+1000);
 195 acc16= variable 1
 196 writeLineAcc16
 197 incr16 variable 1
 198 acc16= variable 1
 199 acc16+ constant 1000
 200 acc16Comp constant 1029
 201 brne 195
 202 ;testDo.j(56)     do { println (i); i++; } while (1031 >  i+1000);
 203 acc16= variable 1
 204 writeLineAcc16
 205 incr16 variable 1
 206 acc16= variable 1
 207 acc16+ constant 1000
 208 acc16Comp constant 1031
 209 brlt 203
 210 ;testDo.j(57)     do { println (i); i++; } while (1032 >= i+1000);
 211 acc16= variable 1
 212 writeLineAcc16
 213 incr16 variable 1
 214 acc16= variable 1
 215 acc16+ constant 1000
 216 acc16Comp constant 1032
 217 brle 211
 218 ;testDo.j(58)     p=i;
 219 acc16= variable 1
 220 acc16=> variable 3
 221 ;testDo.j(59)     do { println (p); p++; i--; } while (1031 <  i+1000);
 222 acc16= variable 3
 223 writeLineAcc16
 224 incr16 variable 3
 225 decr16 variable 1
 226 acc16= variable 1
 227 acc16+ constant 1000
 228 acc16Comp constant 1031
 229 brgt 222
 230 ;testDo.j(60)     do { println (p); p++; i--; } while (1030 <= i+1000);
 231 acc16= variable 3
 232 writeLineAcc16
 233 incr16 variable 3
 234 decr16 variable 1
 235 acc16= variable 1
 236 acc16+ constant 1000
 237 acc16Comp constant 1030
 238 brge 231
 239 ;testDo.j(61)   
 240 ;testDo.j(62)     /************************/
 241 ;testDo.j(63)     // constant - var
 242 ;testDo.j(64)     // byte - byte
 243 ;testDo.j(65)     b=37;
 244 acc8= constant 37
 245 acc8=> variable 0
 246 ;testDo.j(66)     do { println (b); b++; } while (38 >= b);
 247 acc8= variable 0
 248 writeLineAcc8
 249 incr8 variable 0
 250 acc8= variable 0
 251 acc8Comp constant 38
 252 brle 247
 253 ;testDo.j(67)     // byte - integer
 254 ;testDo.j(68)     i=39;
 255 acc8= constant 39
 256 acc8=> variable 1
 257 ;testDo.j(69)     do { println (i); i++; } while (40 >= i);
 258 acc16= variable 1
 259 writeLineAcc16
 260 incr16 variable 1
 261 acc16= variable 1
 262 acc8= constant 40
 263 acc8CompareAcc16
 264 brge 258
 265 ;testDo.j(70)     // integer - byte
 266 ;testDo.j(71)     // not relevant
 267 ;testDo.j(72)     // integer - integer
 268 ;testDo.j(73)     i=1038;
 269 acc16= constant 1038
 270 acc16=> variable 1
 271 ;testDo.j(74)     b=41;
 272 acc8= constant 41
 273 acc8=> variable 0
 274 ;testDo.j(75)     do { println (b); b++; i--; } while (1037 <= i);
 275 acc8= variable 0
 276 writeLineAcc8
 277 incr8 variable 0
 278 decr16 variable 1
 279 acc16= variable 1
 280 acc16Comp constant 1037
 281 brge 275
 282 ;testDo.j(76)   
 283 ;testDo.j(77)     /************************/
 284 ;testDo.j(78)     // constant - stack8
 285 ;testDo.j(79)     // byte - byte
 286 ;testDo.j(80)     //TODO
 287 ;testDo.j(81)     println(43);
 288 acc8= constant 43
 289 writeLineAcc8
 290 ;testDo.j(82)     // constant - stack8
 291 ;testDo.j(83)     // byte - integer
 292 ;testDo.j(84)     //TODO
 293 ;testDo.j(85)     println(44);
 294 acc8= constant 44
 295 writeLineAcc8
 296 ;testDo.j(86)     // constant - stack8
 297 ;testDo.j(87)     // integer - byte
 298 ;testDo.j(88)     //TODO
 299 ;testDo.j(89)     println(45);
 300 acc8= constant 45
 301 writeLineAcc8
 302 ;testDo.j(90)     // constant - stack88
 303 ;testDo.j(91)     // integer - integer
 304 ;testDo.j(92)     //TODO
 305 ;testDo.j(93)     println(46);
 306 acc8= constant 46
 307 writeLineAcc8
 308 ;testDo.j(94)   
 309 ;testDo.j(95)     /************************/
 310 ;testDo.j(96)     // constant - stack16
 311 ;testDo.j(97)     // byte - byte
 312 ;testDo.j(98)     //TODO
 313 ;testDo.j(99)     println(47);
 314 acc8= constant 47
 315 writeLineAcc8
 316 ;testDo.j(100)     // constant - stack16
 317 ;testDo.j(101)     // byte - integer
 318 ;testDo.j(102)     //TODO
 319 ;testDo.j(103)     println(48);
 320 acc8= constant 48
 321 writeLineAcc8
 322 ;testDo.j(104)     // constant - stack16
 323 ;testDo.j(105)     // integer - byte
 324 ;testDo.j(106)     //TODO
 325 ;testDo.j(107)     println(49);
 326 acc8= constant 49
 327 writeLineAcc8
 328 ;testDo.j(108)     // constant - stack16
 329 ;testDo.j(109)     // integer - integer
 330 ;testDo.j(110)     //TODO
 331 ;testDo.j(111)     println(50);
 332 acc8= constant 50
 333 writeLineAcc8
 334 ;testDo.j(112)   
 335 ;testDo.j(113)     /************************/
 336 ;testDo.j(114)     // acc - constant
 337 ;testDo.j(115)     // byte - byte
 338 ;testDo.j(116)     b=51;
 339 acc8= constant 51
 340 acc8=> variable 0
 341 ;testDo.j(117)     do { println (b); b++; } while (b+0 <= 52);
 342 acc8= variable 0
 343 writeLineAcc8
 344 incr8 variable 0
 345 acc8= variable 0
 346 acc8+ constant 0
 347 acc8Comp constant 52
 348 brle 342
 349 ;testDo.j(118)     // byte - integer
 350 ;testDo.j(119)     //not relevant
 351 ;testDo.j(120)     // integer - byte
 352 ;testDo.j(121)     i=53;
 353 acc8= constant 53
 354 acc8=> variable 1
 355 ;testDo.j(122)     do { println (i); i++; } while (i+0 <= 54);
 356 acc16= variable 1
 357 writeLineAcc16
 358 incr16 variable 1
 359 acc16= variable 1
 360 acc16+ constant 0
 361 acc8= constant 54
 362 acc16CompareAcc8
 363 brle 358
 364 ;testDo.j(123)   
 365 ;testDo.j(124)     b=55;
 366 acc8= constant 55
 367 acc8=> variable 0
 368 ;testDo.j(125)     i=1055;
 369 acc16= constant 1055
 370 acc16=> variable 1
 371 ;testDo.j(126)     // integer - integer
 372 ;testDo.j(127)     do { println (b); b++; i++; } while (i+0 <= 1056);
 373 acc8= variable 0
 374 writeLineAcc8
 375 incr8 variable 0
 376 incr16 variable 1
 377 acc16= variable 1
 378 acc16+ constant 0
 379 acc16Comp constant 1056
 380 brle 377
 381 ;testDo.j(128)   
 382 ;testDo.j(129)     /************************/
 383 ;testDo.j(130)     // acc - acc
 384 ;testDo.j(131)     // byte - byte
 385 ;testDo.j(132)     b=57;
 386 acc8= constant 57
 387 acc8=> variable 0
 388 ;testDo.j(133)     do { println (b); b++; } while (b+0 <= 58+0);
 389 acc8= variable 0
 390 writeLineAcc8
 391 incr8 variable 0
 392 acc8= variable 0
 393 acc8+ constant 0
 394 <acc8
 395 acc8= constant 58
 396 acc8+ constant 0
 397 revAcc8Comp unstack8
 398 brge 395
 399 ;testDo.j(134)     // byte - integer
 400 ;testDo.j(135)     i=61;
 401 acc8= constant 61
 402 acc8=> variable 1
 403 ;testDo.j(136)     do { println (b); b++; i--; } while (60+0 <= i+0);
 404 acc8= variable 0
 405 writeLineAcc8
 406 incr8 variable 0
 407 decr16 variable 1
 408 acc8= constant 60
 409 acc8+ constant 0
 410 <acc8
 411 acc16= variable 1
 412 acc16+ constant 0
 413 acc8<
 414 acc8CompareAcc16
 415 brle 410
 416 ;testDo.j(137)     // integer - byte
 417 ;testDo.j(138)     i=61;
 418 acc8= constant 61
 419 acc8=> variable 1
 420 ;testDo.j(139)     b=62;
 421 acc8= constant 62
 422 acc8=> variable 0
 423 ;testDo.j(140)     do { println (i); i++; } while (i+0 <= b+0);
 424 acc16= variable 1
 425 writeLineAcc16
 426 incr16 variable 1
 427 acc16= variable 1
 428 acc16+ constant 0
 429 <acc16
 430 acc8= variable 0
 431 acc8+ constant 0
 432 acc16<
 433 acc16CompareAcc8
 434 brle 430
 435 ;testDo.j(141)     // integer - integer
 436 ;testDo.j(142)     b=63;
 437 acc8= constant 63
 438 acc8=> variable 0
 439 ;testDo.j(143)     i=1063;
 440 acc16= constant 1063
 441 acc16=> variable 1
 442 ;testDo.j(144)     do { println (b); b++; i--; } while (1000+62 <= i+0);
 443 acc8= variable 0
 444 writeLineAcc8
 445 incr8 variable 0
 446 decr16 variable 1
 447 acc16= constant 1000
 448 acc16+ constant 62
 449 <acc16
 450 acc16= variable 1
 451 acc16+ constant 0
 452 revAcc16Comp unstack16
 453 brge 449
 454 ;testDo.j(145)   
 455 ;testDo.j(146)     /************************/
 456 ;testDo.j(147)     // acc - var
 457 ;testDo.j(148)     // byte - byte
 458 ;testDo.j(149)     b=65;
 459 acc8= constant 65
 460 acc8=> variable 0
 461 ;testDo.j(150)     i=65;
 462 acc8= constant 65
 463 acc8=> variable 1
 464 ;testDo.j(151)     do { println (i); i++; b--; } while (64+0 <= b);
 465 acc16= variable 1
 466 writeLineAcc16
 467 incr16 variable 1
 468 decr8 variable 0
 469 acc8= constant 64
 470 acc8+ constant 0
 471 acc8Comp variable 0
 472 brle 471
 473 ;testDo.j(152)     // byte - integer
 474 ;testDo.j(153)     b=67;
 475 acc8= constant 67
 476 acc8=> variable 0
 477 ;testDo.j(154)     i=67;
 478 acc8= constant 67
 479 acc8=> variable 1
 480 ;testDo.j(155)     do { println (b); b++; i--; } while (66+0 <= i);
 481 acc8= variable 0
 482 writeLineAcc8
 483 incr8 variable 0
 484 decr16 variable 1
 485 acc8= constant 66
 486 acc8+ constant 0
 487 acc16= variable 1
 488 acc8CompareAcc16
 489 brle 489
 490 ;testDo.j(156)     // integer - byte
 491 ;testDo.j(157)     i=69;
 492 acc8= constant 69
 493 acc8=> variable 1
 494 ;testDo.j(158)     b=69;
 495 acc8= constant 69
 496 acc8=> variable 0
 497 ;testDo.j(159)     do { println (i); i++; b--; } while (1000+68 <= b);
 498 acc16= variable 1
 499 writeLineAcc16
 500 incr16 variable 1
 501 decr8 variable 0
 502 acc16= constant 1000
 503 acc16+ constant 68
 504 acc8= variable 0
 505 acc16CompareAcc8
 506 brle 508
 507 ;testDo.j(160)     // integer - integer
 508 ;testDo.j(161)     i=1071;
 509 acc16= constant 1071
 510 acc16=> variable 1
 511 ;testDo.j(162)     b=70;
 512 acc8= constant 70
 513 acc8=> variable 0
 514 ;testDo.j(163)     do { println (b); b++; i--; } while (1000+70 <= i);
 515 acc8= variable 0
 516 writeLineAcc8
 517 incr8 variable 0
 518 decr16 variable 1
 519 acc16= constant 1000
 520 acc16+ constant 70
 521 acc16Comp variable 1
 522 brle 527
 523 ;testDo.j(164)   
 524 ;testDo.j(165)     /************************/
 525 ;testDo.j(166)     // acc - stack16
 526 ;testDo.j(167)     // byte - byte
 527 ;testDo.j(168)     //TODO
 528 ;testDo.j(169)     println(72);
 529 acc8= constant 72
 530 writeLineAcc8
 531 ;testDo.j(170)     println(73);
 532 acc8= constant 73
 533 writeLineAcc8
 534 ;testDo.j(171)     // byte - integer
 535 ;testDo.j(172)     //TODO
 536 ;testDo.j(173)     println(74);
 537 acc8= constant 74
 538 writeLineAcc8
 539 ;testDo.j(174)     println(75);
 540 acc8= constant 75
 541 writeLineAcc8
 542 ;testDo.j(175)     // integer - byte
 543 ;testDo.j(176)     //TODO
 544 ;testDo.j(177)     println(76);
 545 acc8= constant 76
 546 writeLineAcc8
 547 ;testDo.j(178)     println(77);
 548 acc8= constant 77
 549 writeLineAcc8
 550 ;testDo.j(179)     // integer - integer
 551 ;testDo.j(180)     //TODO
 552 ;testDo.j(181)     println(78);
 553 acc8= constant 78
 554 writeLineAcc8
 555 ;testDo.j(182)     println(79);
 556 acc8= constant 79
 557 writeLineAcc8
 558 ;testDo.j(183)   
 559 ;testDo.j(184)     /************************/
 560 ;testDo.j(185)     // acc - stack8
 561 ;testDo.j(186)     // byte - byte
 562 ;testDo.j(187)     //TODO
 563 ;testDo.j(188)     println(80);
 564 acc8= constant 80
 565 writeLineAcc8
 566 ;testDo.j(189)     println(81);
 567 acc8= constant 81
 568 writeLineAcc8
 569 ;testDo.j(190)     // byte - integer
 570 ;testDo.j(191)     //TODO
 571 ;testDo.j(192)     println(82);
 572 acc8= constant 82
 573 writeLineAcc8
 574 ;testDo.j(193)     println(83);
 575 acc8= constant 83
 576 writeLineAcc8
 577 ;testDo.j(194)     // integer - byte
 578 ;testDo.j(195)     //TODO
 579 ;testDo.j(196)     println(84);
 580 acc8= constant 84
 581 writeLineAcc8
 582 ;testDo.j(197)     println(85);
 583 acc8= constant 85
 584 writeLineAcc8
 585 ;testDo.j(198)     // integer - integer
 586 ;testDo.j(199)     //TODO
 587 ;testDo.j(200)     println(86);
 588 acc8= constant 86
 589 writeLineAcc8
 590 ;testDo.j(201)     println(87);
 591 acc8= constant 87
 592 writeLineAcc8
 593 ;testDo.j(202)   
 594 ;testDo.j(203)     /************************/
 595 ;testDo.j(204)     // var - constant
 596 ;testDo.j(205)     // byte - byte
 597 ;testDo.j(206)     b=88;
 598 acc8= constant 88
 599 acc8=> variable 0
 600 ;testDo.j(207)     do { println (b); b++; } while (b <= 89);
 601 acc8= variable 0
 602 writeLineAcc8
 603 incr8 variable 0
 604 acc8= variable 0
 605 acc8Comp constant 89
 606 brle 615
 607 ;testDo.j(208)     // byte - integer
 608 ;testDo.j(209)     //not relevant
 609 ;testDo.j(210)     println(90);
 610 acc8= constant 90
 611 writeLineAcc8
 612 ;testDo.j(211)     println(91);
 613 acc8= constant 91
 614 writeLineAcc8
 615 ;testDo.j(212)     // integer - byte
 616 ;testDo.j(213)     i=92;
 617 acc8= constant 92
 618 acc8=> variable 1
 619 ;testDo.j(214)     do { println (i); i++; } while (i <= 93);
 620 acc16= variable 1
 621 writeLineAcc16
 622 incr16 variable 1
 623 acc16= variable 1
 624 acc8= constant 93
 625 acc16CompareAcc8
 626 brle 634
 627 ;testDo.j(215)     // integer - integer
 628 ;testDo.j(216)     i=1094;
 629 acc16= constant 1094
 630 acc16=> variable 1
 631 ;testDo.j(217)     b=94;
 632 acc8= constant 94
 633 acc8=> variable 0
 634 ;testDo.j(218)     do { println (b); b++; i++; } while (i <= 1095  );
 635 acc8= variable 0
 636 writeLineAcc8
 637 incr8 variable 0
 638 incr16 variable 1
 639 acc16= variable 1
 640 acc16Comp constant 1095
 641 brle 649
 642 ;testDo.j(219)   
 643 ;testDo.j(220)     /************************/
 644 ;testDo.j(221)     // var - acc
 645 ;testDo.j(222)     // byte - byte
 646 ;testDo.j(223)     do { println (b); b++; } while (b <= 97+0);
 647 acc8= variable 0
 648 writeLineAcc8
 649 incr8 variable 0
 650 acc8= constant 97
 651 acc8+ constant 0
 652 acc8Comp variable 0
 653 brge 661
 654 ;testDo.j(224)     // byte - integer
 655 ;testDo.j(225)     //not relevant
 656 ;testDo.j(226)     i=99;
 657 acc8= constant 99
 658 acc8=> variable 1
 659 ;testDo.j(227)     do { println (b); b++; } while (b <= i+0);
 660 acc8= variable 0
 661 writeLineAcc8
 662 incr8 variable 0
 663 acc16= variable 1
 664 acc16+ constant 0
 665 acc8= variable 0
 666 acc8CompareAcc16
 667 brle 674
 668 ;testDo.j(228)     // integer - byte
 669 ;testDo.j(229)     i=100;
 670 acc8= constant 100
 671 acc8=> variable 1
 672 ;testDo.j(230)     do { println (i); i++; } while (i <= 101+0);
 673 acc16= variable 1
 674 writeLineAcc16
 675 incr16 variable 1
 676 acc8= constant 101
 677 acc8+ constant 0
 678 acc16= variable 1
 679 acc16CompareAcc8
 680 brle 687
 681 ;testDo.j(231)     // integer - integer
 682 ;testDo.j(232)     i=1102;
 683 acc16= constant 1102
 684 acc16=> variable 1
 685 ;testDo.j(233)     b=102;
 686 acc8= constant 102
 687 acc8=> variable 0
 688 ;testDo.j(234)     do { println (b); b++; i++; } while (i <= 1103+0);
 689 acc8= variable 0
 690 writeLineAcc8
 691 incr8 variable 0
 692 incr16 variable 1
 693 acc16= constant 1103
 694 acc16+ constant 0
 695 acc16Comp variable 1
 696 brge 703
 697 ;testDo.j(235)   
 698 ;testDo.j(236)     /************************/
 699 ;testDo.j(237)     // var - var
 700 ;testDo.j(238)     // byte - byte
 701 ;testDo.j(239)     byte b2 = 105;
 702 acc8= constant 105
 703 acc8=> (basePointer + -1)
 704 ;testDo.j(240)     do { println (b); b++; } while (b <= b2);
 705 acc8= variable 0
 706 writeLineAcc8
 707 incr8 variable 0
 708 acc8= variable 0
 709 acc8Comp (basePointer + -1)
 710 brle 719
 711 ;testDo.j(241)     // byte - integer
 712 ;testDo.j(242)     i=107;
 713 acc8= constant 107
 714 acc8=> variable 1
 715 ;testDo.j(243)     do { println (b); b++; } while (b <= i);
 716 acc8= variable 0
 717 writeLineAcc8
 718 incr8 variable 0
 719 acc8= variable 0
 720 acc16= variable 1
 721 acc8CompareAcc16
 722 brle 730
 723 ;testDo.j(244)     // integer - byte
 724 ;testDo.j(245)     i=b;
 725 acc8= variable 0
 726 acc8=> variable 1
 727 ;testDo.j(246)     b=109;
 728 acc8= constant 109
 729 acc8=> variable 0
 730 ;testDo.j(247)     do { println (i); i++; } while (i <= b);
 731 acc16= variable 1
 732 writeLineAcc16
 733 incr16 variable 1
 734 acc16= variable 1
 735 acc8= variable 0
 736 acc16CompareAcc8
 737 brle 745
 738 ;testDo.j(248)     // integer - integer
 739 ;testDo.j(249)     word i2 = 111;
 740 acc8= constant 111
 741 acc8=> (basePointer + -3)
 742 ;testDo.j(250)     do { println (i); i++; } while (i <= i2);
 743 acc16= variable 1
 744 writeLineAcc16
 745 incr16 variable 1
 746 acc16= variable 1
 747 acc16Comp (basePointer + -3)
 748 brle 757
 749 ;testDo.j(251)   
 750 ;testDo.j(252)     /************************/
 751 ;testDo.j(253)     // var - stack8
 752 ;testDo.j(254)     // byte - byte
 753 ;testDo.j(255)     // byte - integer
 754 ;testDo.j(256)     // integer - byte
 755 ;testDo.j(257)     // integer - integer
 756 ;testDo.j(258)     //TODO
 757 ;testDo.j(259)   
 758 ;testDo.j(260)     /************************/
 759 ;testDo.j(261)     // var - stack16
 760 ;testDo.j(262)     // byte - byte
 761 ;testDo.j(263)     // byte - integer
 762 ;testDo.j(264)     // integer - byte
 763 ;testDo.j(265)     // integer - integer
 764 ;testDo.j(266)     //TODO
 765 ;testDo.j(267)   
 766 ;testDo.j(268)     /************************/
 767 ;testDo.j(269)     // stack8 - constant
 768 ;testDo.j(270)     // stack8 - acc
 769 ;testDo.j(271)     // stack8 - var
 770 ;testDo.j(272)     // stack8 - stack8
 771 ;testDo.j(273)     // stack8 - stack16
 772 ;testDo.j(274)     //TODO
 773 ;testDo.j(275)   
 774 ;testDo.j(276)     /************************/
 775 ;testDo.j(277)     // stack16 - constant
 776 ;testDo.j(278)     // stack16 - acc
 777 ;testDo.j(279)     // stack16 - var
 778 ;testDo.j(280)     // stack16 - stack8
 779 ;testDo.j(281)     // stack16 - stack16
 780 ;testDo.j(282)     //TODO
 781 ;testDo.j(283)   
 782 ;testDo.j(284)     println("Klaar");
 783 acc16= stringconstant 790
 784 writeLineString
 785 ;testDo.j(285)   }
 786 stackPointer= basePointer
 787 basePointer<
 788 return
 789 ;testDo.j(286) }
 790 stringConstant 0 = "Klaar"
