   0 ;test2.j(0) /* Program to test branch instructions in an if statement */
   1 ;test2.j(1) class TestIf {
   2 ;test2.j(2)   private static word i = 2000;
   3 acc16= constant 2000
   4 acc16=> variable 0
   5 ;test2.j(3)   private static word i1 = 1000;
   6 acc16= constant 1000
   7 acc16=> variable 2
   8 ;test2.j(4)   private static word i3 = 3000;
   9 acc16= constant 3000
  10 acc16=> variable 4
  11 ;test2.j(5)   private static byte b = 20;
  12 acc8= constant 20
  13 acc8=> variable 6
  14 ;test2.j(6)   private static byte b1 = 10;
  15 acc8= constant 10
  16 acc8=> variable 7
  17 ;test2.j(7)   private static byte b3 = 30;
  18 acc8= constant 30
  19 acc8=> variable 8
  20 ;test2.j(8) 
  21 ;test2.j(9)   public static void main() {
  22 method main [staticLexeme] voidLexeme
  23 ;test2.j(10)     /*Possible operand types: 
  24 ;test2.j(11)      * constant, acc, var, stack8, stack16
  25 ;test2.j(12)      *Possible datatype combinations:
  26 ;test2.j(13)      * byte - byte
  27 ;test2.j(14)      * byte - integer
  28 ;test2.j(15)      * integer - byte
  29 ;test2.j(16)      * integer - integer
  30 ;test2.j(17)     */
  31 ;test2.j(18)   
  32 ;test2.j(19)     println(0);
  33 acc8= constant 0
  34 call writeLineAcc8
  35 ;test2.j(20)   
  36 ;test2.j(21)     /************************/
  37 ;test2.j(22)     // constant - constant
  38 ;test2.j(23)     // byte - byte
  39 ;test2.j(24)     if (1 == 1) println(1); else println(999);
  40 acc8= constant 1
  41 acc8Comp constant 1
  42 brne 46
  43 acc8= constant 1
  44 call writeLineAcc8
  45 br 49
  46 acc16= constant 999
  47 call writeLineAcc16
  48 ;test2.j(25)     if (1 != 0) println(2); else println(999);
  49 acc8= constant 1
  50 acc8Comp constant 0
  51 breq 55
  52 acc8= constant 2
  53 call writeLineAcc8
  54 br 58
  55 acc16= constant 999
  56 call writeLineAcc16
  57 ;test2.j(26)     if (1 >  0) println(3); else println(999);
  58 acc8= constant 1
  59 acc8Comp constant 0
  60 brle 64
  61 acc8= constant 3
  62 call writeLineAcc8
  63 br 67
  64 acc16= constant 999
  65 call writeLineAcc16
  66 ;test2.j(27)     if (1 >= 0) println(4); else println(999);
  67 acc8= constant 1
  68 acc8Comp constant 0
  69 brlt 73
  70 acc8= constant 4
  71 call writeLineAcc8
  72 br 76
  73 acc16= constant 999
  74 call writeLineAcc16
  75 ;test2.j(28)     if (1 >= 1) println(5); else println(999);
  76 acc8= constant 1
  77 acc8Comp constant 1
  78 brlt 82
  79 acc8= constant 5
  80 call writeLineAcc8
  81 br 85
  82 acc16= constant 999
  83 call writeLineAcc16
  84 ;test2.j(29)     if (1 <  2) println(6); else println(999);
  85 acc8= constant 1
  86 acc8Comp constant 2
  87 brge 91
  88 acc8= constant 6
  89 call writeLineAcc8
  90 br 94
  91 acc16= constant 999
  92 call writeLineAcc16
  93 ;test2.j(30)     if (1 <= 2) println(7); else println(999);
  94 acc8= constant 1
  95 acc8Comp constant 2
  96 brgt 100
  97 acc8= constant 7
  98 call writeLineAcc8
  99 br 103
 100 acc16= constant 999
 101 call writeLineAcc16
 102 ;test2.j(31)     if (1 <= 1) println(8); else println(999);
 103 acc8= constant 1
 104 acc8Comp constant 1
 105 brgt 109
 106 acc8= constant 8
 107 call writeLineAcc8
 108 br 112
 109 acc16= constant 999
 110 call writeLineAcc16
 111 ;test2.j(32)     println(9);
 112 acc8= constant 9
 113 call writeLineAcc8
 114 ;test2.j(33)   
 115 ;test2.j(34)     // constant - constant
 116 ;test2.j(35)     // byte - integer
 117 ;test2.j(36)     if (1 == 1000) println(999); else println(10);
 118 acc8= constant 1
 119 acc16= constant 1000
 120 acc8CompareAcc16
 121 brne 125
 122 acc16= constant 999
 123 call writeLineAcc16
 124 br 128
 125 acc8= constant 10
 126 call writeLineAcc8
 127 ;test2.j(37)     if (1 != 1000) println(11);  else println(999);
 128 acc8= constant 1
 129 acc16= constant 1000
 130 acc8CompareAcc16
 131 breq 135
 132 acc8= constant 11
 133 call writeLineAcc8
 134 br 138
 135 acc16= constant 999
 136 call writeLineAcc16
 137 ;test2.j(38)     if (1 >  1000) println(999); else println(12);
 138 acc8= constant 1
 139 acc16= constant 1000
 140 acc8CompareAcc16
 141 brle 145
 142 acc16= constant 999
 143 call writeLineAcc16
 144 br 148
 145 acc8= constant 12
 146 call writeLineAcc8
 147 ;test2.j(39)     if (1 >= 1000) println(999); else println(13);
 148 acc8= constant 1
 149 acc16= constant 1000
 150 acc8CompareAcc16
 151 brlt 155
 152 acc16= constant 999
 153 call writeLineAcc16
 154 br 158
 155 acc8= constant 13
 156 call writeLineAcc8
 157 ;test2.j(40)     if (1 >= 1000) println(999); else println(14);
 158 acc8= constant 1
 159 acc16= constant 1000
 160 acc8CompareAcc16
 161 brlt 165
 162 acc16= constant 999
 163 call writeLineAcc16
 164 br 168
 165 acc8= constant 14
 166 call writeLineAcc8
 167 ;test2.j(41)     if (1 <  2000) println(15);  else println(999);
 168 acc8= constant 1
 169 acc16= constant 2000
 170 acc8CompareAcc16
 171 brge 175
 172 acc8= constant 15
 173 call writeLineAcc8
 174 br 178
 175 acc16= constant 999
 176 call writeLineAcc16
 177 ;test2.j(42)     if (1 <= 2000) println(16);  else println(999);
 178 acc8= constant 1
 179 acc16= constant 2000
 180 acc8CompareAcc16
 181 brgt 185
 182 acc8= constant 16
 183 call writeLineAcc8
 184 br 188
 185 acc16= constant 999
 186 call writeLineAcc16
 187 ;test2.j(43)     if (1 <= 1000) println(17);  else println(999);
 188 acc8= constant 1
 189 acc16= constant 1000
 190 acc8CompareAcc16
 191 brgt 195
 192 acc8= constant 17
 193 call writeLineAcc8
 194 br 198
 195 acc16= constant 999
 196 call writeLineAcc16
 197 ;test2.j(44)     println(18);
 198 acc8= constant 18
 199 call writeLineAcc8
 200 ;test2.j(45)     println(19);
 201 acc8= constant 19
 202 call writeLineAcc8
 203 ;test2.j(46)   
 204 ;test2.j(47)     // constant - constant
 205 ;test2.j(48)     // integer - byte
 206 ;test2.j(49)     if (1000 == 1) println(999); else println(20);
 207 acc16= constant 1000
 208 acc8= constant 1
 209 acc16CompareAcc8
 210 brne 214
 211 acc16= constant 999
 212 call writeLineAcc16
 213 br 217
 214 acc8= constant 20
 215 call writeLineAcc8
 216 ;test2.j(50)     if (1000 != 0) println(21);  else println(999);
 217 acc16= constant 1000
 218 acc8= constant 0
 219 acc16CompareAcc8
 220 breq 224
 221 acc8= constant 21
 222 call writeLineAcc8
 223 br 227
 224 acc16= constant 999
 225 call writeLineAcc16
 226 ;test2.j(51)     if (1000 >  0) println(22);  else println(999);
 227 acc16= constant 1000
 228 acc8= constant 0
 229 acc16CompareAcc8
 230 brle 234
 231 acc8= constant 22
 232 call writeLineAcc8
 233 br 237
 234 acc16= constant 999
 235 call writeLineAcc16
 236 ;test2.j(52)     if (1000 >= 0) println(23);  else println(999);
 237 acc16= constant 1000
 238 acc8= constant 0
 239 acc16CompareAcc8
 240 brlt 244
 241 acc8= constant 23
 242 call writeLineAcc8
 243 br 247
 244 acc16= constant 999
 245 call writeLineAcc16
 246 ;test2.j(53)     if (1000 >= 1) println(24);  else println(999);
 247 acc16= constant 1000
 248 acc8= constant 1
 249 acc16CompareAcc8
 250 brlt 254
 251 acc8= constant 24
 252 call writeLineAcc8
 253 br 257
 254 acc16= constant 999
 255 call writeLineAcc16
 256 ;test2.j(54)     if (1 <  2000) println(25);  else println(999);
 257 acc8= constant 1
 258 acc16= constant 2000
 259 acc8CompareAcc16
 260 brge 264
 261 acc8= constant 25
 262 call writeLineAcc8
 263 br 267
 264 acc16= constant 999
 265 call writeLineAcc16
 266 ;test2.j(55)     if (1 <= 2000) println(26);  else println(999);
 267 acc8= constant 1
 268 acc16= constant 2000
 269 acc8CompareAcc16
 270 brgt 274
 271 acc8= constant 26
 272 call writeLineAcc8
 273 br 277
 274 acc16= constant 999
 275 call writeLineAcc16
 276 ;test2.j(56)     if (1 <= 1000) println(27);  else println(999);
 277 acc8= constant 1
 278 acc16= constant 1000
 279 acc8CompareAcc16
 280 brgt 284
 281 acc8= constant 27
 282 call writeLineAcc8
 283 br 287
 284 acc16= constant 999
 285 call writeLineAcc16
 286 ;test2.j(57)     println(28);
 287 acc8= constant 28
 288 call writeLineAcc8
 289 ;test2.j(58)     println(29);
 290 acc8= constant 29
 291 call writeLineAcc8
 292 ;test2.j(59)   
 293 ;test2.j(60)     // constant - constant
 294 ;test2.j(61)     // integer - integer
 295 ;test2.j(62)     if (1000 == 1000) println(30); else println(999);
 296 acc16= constant 1000
 297 acc16Comp constant 1000
 298 brne 302
 299 acc8= constant 30
 300 call writeLineAcc8
 301 br 305
 302 acc16= constant 999
 303 call writeLineAcc16
 304 ;test2.j(63)     if (1000 != 2000) println(31); else println(999);
 305 acc16= constant 1000
 306 acc16Comp constant 2000
 307 breq 311
 308 acc8= constant 31
 309 call writeLineAcc8
 310 br 314
 311 acc16= constant 999
 312 call writeLineAcc16
 313 ;test2.j(64)     if (2000 >  1000) println(32); else println(999);
 314 acc16= constant 2000
 315 acc16Comp constant 1000
 316 brle 320
 317 acc8= constant 32
 318 call writeLineAcc8
 319 br 323
 320 acc16= constant 999
 321 call writeLineAcc16
 322 ;test2.j(65)     if (2000 >= 1000) println(33); else println(999);
 323 acc16= constant 2000
 324 acc16Comp constant 1000
 325 brlt 329
 326 acc8= constant 33
 327 call writeLineAcc8
 328 br 332
 329 acc16= constant 999
 330 call writeLineAcc16
 331 ;test2.j(66)     if (1000 >= 1000) println(34); else println(999);
 332 acc16= constant 1000
 333 acc16Comp constant 1000
 334 brlt 338
 335 acc8= constant 34
 336 call writeLineAcc8
 337 br 341
 338 acc16= constant 999
 339 call writeLineAcc16
 340 ;test2.j(67)     if (1000 <  2000) println(35); else println(999);
 341 acc16= constant 1000
 342 acc16Comp constant 2000
 343 brge 347
 344 acc8= constant 35
 345 call writeLineAcc8
 346 br 350
 347 acc16= constant 999
 348 call writeLineAcc16
 349 ;test2.j(68)     if (1000 <= 2000) println(36); else println(999);
 350 acc16= constant 1000
 351 acc16Comp constant 2000
 352 brgt 356
 353 acc8= constant 36
 354 call writeLineAcc8
 355 br 359
 356 acc16= constant 999
 357 call writeLineAcc16
 358 ;test2.j(69)     if (1000 <= 1000) println(37); else println(999);
 359 acc16= constant 1000
 360 acc16Comp constant 1000
 361 brgt 365
 362 acc8= constant 37
 363 call writeLineAcc8
 364 br 368
 365 acc16= constant 999
 366 call writeLineAcc16
 367 ;test2.j(70)     println(38);
 368 acc8= constant 38
 369 call writeLineAcc8
 370 ;test2.j(71)     println(39);
 371 acc8= constant 39
 372 call writeLineAcc8
 373 ;test2.j(72)   
 374 ;test2.j(73)     /************************/
 375 ;test2.j(74)     // constant - acc
 376 ;test2.j(75)     // byte - byte
 377 ;test2.j(76)     if (1 > 0+0) println(40); else println(999);
 378 acc8= constant 0
 379 acc8+ constant 0
 380 acc8Comp constant 1
 381 brge 385
 382 acc8= constant 40
 383 call writeLineAcc8
 384 br 388
 385 acc16= constant 999
 386 call writeLineAcc16
 387 ;test2.j(77)     if (1 < 2+0) println(41); else println(999);
 388 acc8= constant 2
 389 acc8+ constant 0
 390 acc8Comp constant 1
 391 brle 395
 392 acc8= constant 41
 393 call writeLineAcc8
 394 br 400
 395 acc16= constant 999
 396 call writeLineAcc16
 397 ;test2.j(78)     // constant - acc
 398 ;test2.j(79)     // byte - integer
 399 ;test2.j(80)     if (1 > 1000+0) println(999); else println(42);
 400 acc16= constant 1000
 401 acc16+ constant 0
 402 acc8= constant 1
 403 acc8CompareAcc16
 404 brle 408
 405 acc16= constant 999
 406 call writeLineAcc16
 407 br 411
 408 acc8= constant 42
 409 call writeLineAcc8
 410 ;test2.j(81)     if (1 < 1000+0) println(43);  else println(999);
 411 acc16= constant 1000
 412 acc16+ constant 0
 413 acc8= constant 1
 414 acc8CompareAcc16
 415 brge 419
 416 acc8= constant 43
 417 call writeLineAcc8
 418 br 424
 419 acc16= constant 999
 420 call writeLineAcc16
 421 ;test2.j(82)     // constant - acc
 422 ;test2.j(83)     // integer - byte
 423 ;test2.j(84)     if (1000 > 0+0) println(44);  else println(999);
 424 acc8= constant 0
 425 acc8+ constant 0
 426 acc16= constant 1000
 427 acc16CompareAcc8
 428 brle 432
 429 acc8= constant 44
 430 call writeLineAcc8
 431 br 435
 432 acc16= constant 999
 433 call writeLineAcc16
 434 ;test2.j(85)     if (1000 < 0+0) println(999); else println(45);
 435 acc8= constant 0
 436 acc8+ constant 0
 437 acc16= constant 1000
 438 acc16CompareAcc8
 439 brge 443
 440 acc16= constant 999
 441 call writeLineAcc16
 442 br 448
 443 acc8= constant 45
 444 call writeLineAcc8
 445 ;test2.j(86)     // constant - acc
 446 ;test2.j(87)     // integer - integer
 447 ;test2.j(88)     if (2000 > 1000+0) println(46); else println(999);
 448 acc16= constant 1000
 449 acc16+ constant 0
 450 acc16Comp constant 2000
 451 brge 455
 452 acc8= constant 46
 453 call writeLineAcc8
 454 br 458
 455 acc16= constant 999
 456 call writeLineAcc16
 457 ;test2.j(89)     if (1000 < 2000+0) println(47); else println(999);
 458 acc16= constant 2000
 459 acc16+ constant 0
 460 acc16Comp constant 1000
 461 brle 465
 462 acc8= constant 47
 463 call writeLineAcc8
 464 br 468
 465 acc16= constant 999
 466 call writeLineAcc16
 467 ;test2.j(90)     println(48);
 468 acc8= constant 48
 469 call writeLineAcc8
 470 ;test2.j(91)     println(49);
 471 acc8= constant 49
 472 call writeLineAcc8
 473 ;test2.j(92)   
 474 ;test2.j(93)     /************************/
 475 ;test2.j(94)     // constant - var
 476 ;test2.j(95)     // byte - byte
 477 ;test2.j(96)     if (30 > b) println(50); else println(999);
 478 acc8= variable 6
 479 acc8Comp constant 30
 480 brge 484
 481 acc8= constant 50
 482 call writeLineAcc8
 483 br 487
 484 acc16= constant 999
 485 call writeLineAcc16
 486 ;test2.j(97)     if (10 < b) println(51); else println(999);
 487 acc8= variable 6
 488 acc8Comp constant 10
 489 brle 493
 490 acc8= constant 51
 491 call writeLineAcc8
 492 br 498
 493 acc16= constant 999
 494 call writeLineAcc16
 495 ;test2.j(98)     // constant - var
 496 ;test2.j(99)     // byte - integer
 497 ;test2.j(100)     if (30 > i) println(999); else println(52);
 498 acc16= variable 0
 499 acc8= constant 30
 500 acc8CompareAcc16
 501 brle 505
 502 acc16= constant 999
 503 call writeLineAcc16
 504 br 508
 505 acc8= constant 52
 506 call writeLineAcc8
 507 ;test2.j(101)     if (10 < i) println(53); else println(999);
 508 acc16= variable 0
 509 acc8= constant 10
 510 acc8CompareAcc16
 511 brge 515
 512 acc8= constant 53
 513 call writeLineAcc8
 514 br 520
 515 acc16= constant 999
 516 call writeLineAcc16
 517 ;test2.j(102)     // constant - var
 518 ;test2.j(103)     // integer - byte
 519 ;test2.j(104)     if (3000 > b) println(54); else println(999);
 520 acc8= variable 6
 521 acc16= constant 3000
 522 acc16CompareAcc8
 523 brle 527
 524 acc8= constant 54
 525 call writeLineAcc8
 526 br 530
 527 acc16= constant 999
 528 call writeLineAcc16
 529 ;test2.j(105)     if (1000 < b) println(999); else println(55);
 530 acc8= variable 6
 531 acc16= constant 1000
 532 acc16CompareAcc8
 533 brge 537
 534 acc16= constant 999
 535 call writeLineAcc16
 536 br 542
 537 acc8= constant 55
 538 call writeLineAcc8
 539 ;test2.j(106)     // constant - var
 540 ;test2.j(107)     // integer - integer
 541 ;test2.j(108)     if (3000 > i) println(56); else println(999);
 542 acc16= variable 0
 543 acc16Comp constant 3000
 544 brge 548
 545 acc8= constant 56
 546 call writeLineAcc8
 547 br 551
 548 acc16= constant 999
 549 call writeLineAcc16
 550 ;test2.j(109)     if (1000 < i) println(57); else println(999);
 551 acc16= variable 0
 552 acc16Comp constant 1000
 553 brle 557
 554 acc8= constant 57
 555 call writeLineAcc8
 556 br 560
 557 acc16= constant 999
 558 call writeLineAcc16
 559 ;test2.j(110)     println(58);
 560 acc8= constant 58
 561 call writeLineAcc8
 562 ;test2.j(111)     println(59);
 563 acc8= constant 59
 564 call writeLineAcc8
 565 ;test2.j(112)   
 566 ;test2.j(113)     /************************/
 567 ;test2.j(114)     // constant - stack8
 568 ;test2.j(115)     // byte - byte
 569 ;test2.j(116)     println(60);
 570 acc8= constant 60
 571 call writeLineAcc8
 572 ;test2.j(117)     println(61);
 573 acc8= constant 61
 574 call writeLineAcc8
 575 ;test2.j(118)     // constant - stack8
 576 ;test2.j(119)     // byte - integer
 577 ;test2.j(120)     println(62);
 578 acc8= constant 62
 579 call writeLineAcc8
 580 ;test2.j(121)     println(63);
 581 acc8= constant 63
 582 call writeLineAcc8
 583 ;test2.j(122)     // constant - stack8
 584 ;test2.j(123)     // integer - byte
 585 ;test2.j(124)     println(64);
 586 acc8= constant 64
 587 call writeLineAcc8
 588 ;test2.j(125)     println(65);
 589 acc8= constant 65
 590 call writeLineAcc8
 591 ;test2.j(126)     // constant - stack8
 592 ;test2.j(127)     // integer - integer
 593 ;test2.j(128)     println(66);
 594 acc8= constant 66
 595 call writeLineAcc8
 596 ;test2.j(129)     println(67);
 597 acc8= constant 67
 598 call writeLineAcc8
 599 ;test2.j(130)     println(68);
 600 acc8= constant 68
 601 call writeLineAcc8
 602 ;test2.j(131)     println(69);
 603 acc8= constant 69
 604 call writeLineAcc8
 605 ;test2.j(132)   
 606 ;test2.j(133)     /************************/
 607 ;test2.j(134)     // constant - stack16
 608 ;test2.j(135)     // byte - byte
 609 ;test2.j(136)     println(70);
 610 acc8= constant 70
 611 call writeLineAcc8
 612 ;test2.j(137)     println(71);
 613 acc8= constant 71
 614 call writeLineAcc8
 615 ;test2.j(138)     // constant - stack16
 616 ;test2.j(139)     // byte - integer
 617 ;test2.j(140)     println(72);
 618 acc8= constant 72
 619 call writeLineAcc8
 620 ;test2.j(141)     println(73);
 621 acc8= constant 73
 622 call writeLineAcc8
 623 ;test2.j(142)     // constant - stack16
 624 ;test2.j(143)     // integer - byte
 625 ;test2.j(144)     println(74);
 626 acc8= constant 74
 627 call writeLineAcc8
 628 ;test2.j(145)     println(75);
 629 acc8= constant 75
 630 call writeLineAcc8
 631 ;test2.j(146)     // constant - stack16
 632 ;test2.j(147)     // integer - integer
 633 ;test2.j(148)     println(76);
 634 acc8= constant 76
 635 call writeLineAcc8
 636 ;test2.j(149)     println(77);
 637 acc8= constant 77
 638 call writeLineAcc8
 639 ;test2.j(150)     println(78);
 640 acc8= constant 78
 641 call writeLineAcc8
 642 ;test2.j(151)     println(79);
 643 acc8= constant 79
 644 call writeLineAcc8
 645 ;test2.j(152)   
 646 ;test2.j(153)     /************************/
 647 ;test2.j(154)     // acc - constant
 648 ;test2.j(155)     // byte - byte
 649 ;test2.j(156)     if (30+0 > 20) println(80); else println(999);
 650 acc8= constant 30
 651 acc8+ constant 0
 652 acc8Comp constant 20
 653 brle 657
 654 acc8= constant 80
 655 call writeLineAcc8
 656 br 660
 657 acc16= constant 999
 658 call writeLineAcc16
 659 ;test2.j(157)     if (10+0 < 20) println(81); else println(999);
 660 acc8= constant 10
 661 acc8+ constant 0
 662 acc8Comp constant 20
 663 brge 667
 664 acc8= constant 81
 665 call writeLineAcc8
 666 br 672
 667 acc16= constant 999
 668 call writeLineAcc16
 669 ;test2.j(158)     // acc - constant
 670 ;test2.j(159)     // byte - integer
 671 ;test2.j(160)     if (30+0 > 2000) println(999); else println(82);
 672 acc8= constant 30
 673 acc8+ constant 0
 674 acc16= constant 2000
 675 acc8CompareAcc16
 676 brle 680
 677 acc16= constant 999
 678 call writeLineAcc16
 679 br 683
 680 acc8= constant 82
 681 call writeLineAcc8
 682 ;test2.j(161)     if (10+0 < 2000) println(83); else println(999);
 683 acc8= constant 10
 684 acc8+ constant 0
 685 acc16= constant 2000
 686 acc8CompareAcc16
 687 brge 691
 688 acc8= constant 83
 689 call writeLineAcc8
 690 br 696
 691 acc16= constant 999
 692 call writeLineAcc16
 693 ;test2.j(162)     // acc - constant
 694 ;test2.j(163)     // integer - byte
 695 ;test2.j(164)     if (3000+0 > 20) println(84); else println(999);
 696 acc16= constant 3000
 697 acc16+ constant 0
 698 acc8= constant 20
 699 acc16CompareAcc8
 700 brle 704
 701 acc8= constant 84
 702 call writeLineAcc8
 703 br 707
 704 acc16= constant 999
 705 call writeLineAcc16
 706 ;test2.j(165)     if (1000+0 < 20) println(999); else println(85);
 707 acc16= constant 1000
 708 acc16+ constant 0
 709 acc8= constant 20
 710 acc16CompareAcc8
 711 brge 715
 712 acc16= constant 999
 713 call writeLineAcc16
 714 br 720
 715 acc8= constant 85
 716 call writeLineAcc8
 717 ;test2.j(166)     // acc - constant
 718 ;test2.j(167)     // integer - integer
 719 ;test2.j(168)     if (3000+0 > 2000) println(86); else println(999);
 720 acc16= constant 3000
 721 acc16+ constant 0
 722 acc16Comp constant 2000
 723 brle 727
 724 acc8= constant 86
 725 call writeLineAcc8
 726 br 730
 727 acc16= constant 999
 728 call writeLineAcc16
 729 ;test2.j(169)     if (1000+0 < 2000) println(87); else println(999);
 730 acc16= constant 1000
 731 acc16+ constant 0
 732 acc16Comp constant 2000
 733 brge 737
 734 acc8= constant 87
 735 call writeLineAcc8
 736 br 740
 737 acc16= constant 999
 738 call writeLineAcc16
 739 ;test2.j(170)     println(88);
 740 acc8= constant 88
 741 call writeLineAcc8
 742 ;test2.j(171)     println(89);
 743 acc8= constant 89
 744 call writeLineAcc8
 745 ;test2.j(172)   
 746 ;test2.j(173)     /************************/
 747 ;test2.j(174)     // acc - acc
 748 ;test2.j(175)     // byte - byte
 749 ;test2.j(176)     if (30+0 > 20+0) println(90); else println(999);
 750 acc8= constant 30
 751 acc8+ constant 0
 752 <acc8
 753 acc8= constant 20
 754 acc8+ constant 0
 755 revAcc8Comp unstack8
 756 brge 760
 757 acc8= constant 90
 758 call writeLineAcc8
 759 br 763
 760 acc16= constant 999
 761 call writeLineAcc16
 762 ;test2.j(177)     if (10+0 < 20+0) println(91); else println(999);
 763 acc8= constant 10
 764 acc8+ constant 0
 765 <acc8
 766 acc8= constant 20
 767 acc8+ constant 0
 768 revAcc8Comp unstack8
 769 brle 773
 770 acc8= constant 91
 771 call writeLineAcc8
 772 br 778
 773 acc16= constant 999
 774 call writeLineAcc16
 775 ;test2.j(178)     // acc - acc
 776 ;test2.j(179)     // byte - integer
 777 ;test2.j(180)     if (30+0 > 2000+0) println(999); else println(92);
 778 acc8= constant 30
 779 acc8+ constant 0
 780 <acc8
 781 acc16= constant 2000
 782 acc16+ constant 0
 783 acc8= unstack8
 784 acc8CompareAcc16
 785 brle 789
 786 acc16= constant 999
 787 call writeLineAcc16
 788 br 792
 789 acc8= constant 92
 790 call writeLineAcc8
 791 ;test2.j(181)     if (10+0 < 2000+0) println(93); else println(999);
 792 acc8= constant 10
 793 acc8+ constant 0
 794 <acc8
 795 acc16= constant 2000
 796 acc16+ constant 0
 797 acc8= unstack8
 798 acc8CompareAcc16
 799 brge 803
 800 acc8= constant 93
 801 call writeLineAcc8
 802 br 808
 803 acc16= constant 999
 804 call writeLineAcc16
 805 ;test2.j(182)     // acc - acc
 806 ;test2.j(183)     // integer - byte
 807 ;test2.j(184)     if (3000+0 > 20+0) println(94); else println(999);
 808 acc16= constant 3000
 809 acc16+ constant 0
 810 <acc16
 811 acc8= constant 20
 812 acc8+ constant 0
 813 acc16= unstack16
 814 acc16CompareAcc8
 815 brle 819
 816 acc8= constant 94
 817 call writeLineAcc8
 818 br 822
 819 acc16= constant 999
 820 call writeLineAcc16
 821 ;test2.j(185)     if (1000+0 < 20+0) println(999); else println(95);
 822 acc16= constant 1000
 823 acc16+ constant 0
 824 <acc16
 825 acc8= constant 20
 826 acc8+ constant 0
 827 acc16= unstack16
 828 acc16CompareAcc8
 829 brge 833
 830 acc16= constant 999
 831 call writeLineAcc16
 832 br 838
 833 acc8= constant 95
 834 call writeLineAcc8
 835 ;test2.j(186)     // acc - acc
 836 ;test2.j(187)     // integer - integer
 837 ;test2.j(188)     if (3000+0 > 2000+0) println(96); else println(999);
 838 acc16= constant 3000
 839 acc16+ constant 0
 840 <acc16
 841 acc16= constant 2000
 842 acc16+ constant 0
 843 revAcc16Comp unstack16
 844 brge 848
 845 acc8= constant 96
 846 call writeLineAcc8
 847 br 851
 848 acc16= constant 999
 849 call writeLineAcc16
 850 ;test2.j(189)     if (1000+0 < 2000+0) println(97); else println(999);
 851 acc16= constant 1000
 852 acc16+ constant 0
 853 <acc16
 854 acc16= constant 2000
 855 acc16+ constant 0
 856 revAcc16Comp unstack16
 857 brle 861
 858 acc8= constant 97
 859 call writeLineAcc8
 860 br 864
 861 acc16= constant 999
 862 call writeLineAcc16
 863 ;test2.j(190)     println(98);
 864 acc8= constant 98
 865 call writeLineAcc8
 866 ;test2.j(191)     println(99);
 867 acc8= constant 99
 868 call writeLineAcc8
 869 ;test2.j(192)   
 870 ;test2.j(193)     /************************/
 871 ;test2.j(194)     // acc - var
 872 ;test2.j(195)     // byte - byte
 873 ;test2.j(196)     if (30+0 > b) println(100); else println(999);
 874 acc8= constant 30
 875 acc8+ constant 0
 876 acc8Comp variable 6
 877 brle 881
 878 acc8= constant 100
 879 call writeLineAcc8
 880 br 884
 881 acc16= constant 999
 882 call writeLineAcc16
 883 ;test2.j(197)     if (10+0 < b) println(101); else println(999);
 884 acc8= constant 10
 885 acc8+ constant 0
 886 acc8Comp variable 6
 887 brge 891
 888 acc8= constant 101
 889 call writeLineAcc8
 890 br 896
 891 acc16= constant 999
 892 call writeLineAcc16
 893 ;test2.j(198)     // acc - var
 894 ;test2.j(199)     // byte - integer
 895 ;test2.j(200)     if (30+0 > i) println(999); else println(102);
 896 acc8= constant 30
 897 acc8+ constant 0
 898 acc16= variable 0
 899 acc8CompareAcc16
 900 brle 904
 901 acc16= constant 999
 902 call writeLineAcc16
 903 br 907
 904 acc8= constant 102
 905 call writeLineAcc8
 906 ;test2.j(201)     if (10+0 < i) println(103); else println(999);
 907 acc8= constant 10
 908 acc8+ constant 0
 909 acc16= variable 0
 910 acc8CompareAcc16
 911 brge 915
 912 acc8= constant 103
 913 call writeLineAcc8
 914 br 920
 915 acc16= constant 999
 916 call writeLineAcc16
 917 ;test2.j(202)     // acc - var
 918 ;test2.j(203)     // integer - byte
 919 ;test2.j(204)     if (3000+0 > b) println(104); else println(999);
 920 acc16= constant 3000
 921 acc16+ constant 0
 922 acc8= variable 6
 923 acc16CompareAcc8
 924 brle 928
 925 acc8= constant 104
 926 call writeLineAcc8
 927 br 931
 928 acc16= constant 999
 929 call writeLineAcc16
 930 ;test2.j(205)     if (1000+0 < b) println(999); else println(105);
 931 acc16= constant 1000
 932 acc16+ constant 0
 933 acc8= variable 6
 934 acc16CompareAcc8
 935 brge 939
 936 acc16= constant 999
 937 call writeLineAcc16
 938 br 944
 939 acc8= constant 105
 940 call writeLineAcc8
 941 ;test2.j(206)     // acc - var
 942 ;test2.j(207)     // integer - integer
 943 ;test2.j(208)     if (3000+0 > i) println(106); else println(999);
 944 acc16= constant 3000
 945 acc16+ constant 0
 946 acc16Comp variable 0
 947 brle 951
 948 acc8= constant 106
 949 call writeLineAcc8
 950 br 954
 951 acc16= constant 999
 952 call writeLineAcc16
 953 ;test2.j(209)     if (1000+0 < i) println(107); else println(999);
 954 acc16= constant 1000
 955 acc16+ constant 0
 956 acc16Comp variable 0
 957 brge 961
 958 acc8= constant 107
 959 call writeLineAcc8
 960 br 964
 961 acc16= constant 999
 962 call writeLineAcc16
 963 ;test2.j(210)     println(108);
 964 acc8= constant 108
 965 call writeLineAcc8
 966 ;test2.j(211)     println(109);
 967 acc8= constant 109
 968 call writeLineAcc8
 969 ;test2.j(212)   
 970 ;test2.j(213)     /************************/
 971 ;test2.j(214)     // acc - stack8
 972 ;test2.j(215)     // byte - byte
 973 ;test2.j(216)     println(110);
 974 acc8= constant 110
 975 call writeLineAcc8
 976 ;test2.j(217)     println(111);
 977 acc8= constant 111
 978 call writeLineAcc8
 979 ;test2.j(218)     // acc - stack8
 980 ;test2.j(219)     // byte - integer
 981 ;test2.j(220)     println(112);
 982 acc8= constant 112
 983 call writeLineAcc8
 984 ;test2.j(221)     println(113);
 985 acc8= constant 113
 986 call writeLineAcc8
 987 ;test2.j(222)     // acc - stack8
 988 ;test2.j(223)     // integer - byte
 989 ;test2.j(224)     println(114);
 990 acc8= constant 114
 991 call writeLineAcc8
 992 ;test2.j(225)     println(115);
 993 acc8= constant 115
 994 call writeLineAcc8
 995 ;test2.j(226)     // acc - stack8
 996 ;test2.j(227)     // integer - integer
 997 ;test2.j(228)     println(116);
 998 acc8= constant 116
 999 call writeLineAcc8
1000 ;test2.j(229)     println(117);
1001 acc8= constant 117
1002 call writeLineAcc8
1003 ;test2.j(230)     println(118);
1004 acc8= constant 118
1005 call writeLineAcc8
1006 ;test2.j(231)     println(119);
1007 acc8= constant 119
1008 call writeLineAcc8
1009 ;test2.j(232)   
1010 ;test2.j(233)     /************************/
1011 ;test2.j(234)     // acc - stack16
1012 ;test2.j(235)     // byte - byte
1013 ;test2.j(236)     println(120);
1014 acc8= constant 120
1015 call writeLineAcc8
1016 ;test2.j(237)     println(121);
1017 acc8= constant 121
1018 call writeLineAcc8
1019 ;test2.j(238)     // acc - stack16
1020 ;test2.j(239)     // byte - integer
1021 ;test2.j(240)     println(122);
1022 acc8= constant 122
1023 call writeLineAcc8
1024 ;test2.j(241)     println(123);
1025 acc8= constant 123
1026 call writeLineAcc8
1027 ;test2.j(242)     // acc - stack16
1028 ;test2.j(243)     // integer - byte
1029 ;test2.j(244)     println(124);
1030 acc8= constant 124
1031 call writeLineAcc8
1032 ;test2.j(245)     println(125);
1033 acc8= constant 125
1034 call writeLineAcc8
1035 ;test2.j(246)     // acc - stack16
1036 ;test2.j(247)     // integer - integer
1037 ;test2.j(248)     println(126);
1038 acc8= constant 126
1039 call writeLineAcc8
1040 ;test2.j(249)     println(127);
1041 acc8= constant 127
1042 call writeLineAcc8
1043 ;test2.j(250)     println(128);
1044 acc8= constant 128
1045 call writeLineAcc8
1046 ;test2.j(251)     println(129);
1047 acc8= constant 129
1048 call writeLineAcc8
1049 ;test2.j(252)   
1050 ;test2.j(253)     /************************/
1051 ;test2.j(254)     // var - constant
1052 ;test2.j(255)     // byte - byte
1053 ;test2.j(256)     if (b > 10) println(130); else println(999);
1054 acc8= variable 6
1055 acc8Comp constant 10
1056 brle 1060
1057 acc8= constant 130
1058 call writeLineAcc8
1059 br 1063
1060 acc16= constant 999
1061 call writeLineAcc16
1062 ;test2.j(257)     if (b < 30) println(131); else println(999);
1063 acc8= variable 6
1064 acc8Comp constant 30
1065 brge 1069
1066 acc8= constant 131
1067 call writeLineAcc8
1068 br 1074
1069 acc16= constant 999
1070 call writeLineAcc16
1071 ;test2.j(258)     // var - constant
1072 ;test2.j(259)     // byte - integer
1073 ;test2.j(260)     if (b > 1000) println(999); else println(132);
1074 acc8= variable 6
1075 acc16= constant 1000
1076 acc8CompareAcc16
1077 brle 1081
1078 acc16= constant 999
1079 call writeLineAcc16
1080 br 1084
1081 acc8= constant 132
1082 call writeLineAcc8
1083 ;test2.j(261)     if (b < 1000) println(133); else println(999);
1084 acc8= variable 6
1085 acc16= constant 1000
1086 acc8CompareAcc16
1087 brge 1091
1088 acc8= constant 133
1089 call writeLineAcc8
1090 br 1096
1091 acc16= constant 999
1092 call writeLineAcc16
1093 ;test2.j(262)     // var - constant
1094 ;test2.j(263)     // integer - byte
1095 ;test2.j(264)     if (i > 1000) println(134); else println(999);
1096 acc16= variable 0
1097 acc16Comp constant 1000
1098 brle 1102
1099 acc8= constant 134
1100 call writeLineAcc8
1101 br 1105
1102 acc16= constant 999
1103 call writeLineAcc16
1104 ;test2.j(265)     if (i < 3000) println(135); else println(999);
1105 acc16= variable 0
1106 acc16Comp constant 3000
1107 brge 1111
1108 acc8= constant 135
1109 call writeLineAcc8
1110 br 1116
1111 acc16= constant 999
1112 call writeLineAcc16
1113 ;test2.j(266)     // var - constant
1114 ;test2.j(267)     // integer - integer
1115 ;test2.j(268)     if (i > 1000) println(136); else println(999);
1116 acc16= variable 0
1117 acc16Comp constant 1000
1118 brle 1122
1119 acc8= constant 136
1120 call writeLineAcc8
1121 br 1125
1122 acc16= constant 999
1123 call writeLineAcc16
1124 ;test2.j(269)     if (i < 3000) println(137); else println(999);
1125 acc16= variable 0
1126 acc16Comp constant 3000
1127 brge 1131
1128 acc8= constant 137
1129 call writeLineAcc8
1130 br 1134
1131 acc16= constant 999
1132 call writeLineAcc16
1133 ;test2.j(270)     println(138);
1134 acc8= constant 138
1135 call writeLineAcc8
1136 ;test2.j(271)     println(139);
1137 acc8= constant 139
1138 call writeLineAcc8
1139 ;test2.j(272)   
1140 ;test2.j(273)     /************************/
1141 ;test2.j(274)     // var - acc
1142 ;test2.j(275)     // byte - byte
1143 ;test2.j(276)     if (b > 10+0) println(140); else println(999);
1144 acc8= constant 10
1145 acc8+ constant 0
1146 acc8Comp variable 6
1147 brge 1151
1148 acc8= constant 140
1149 call writeLineAcc8
1150 br 1154
1151 acc16= constant 999
1152 call writeLineAcc16
1153 ;test2.j(277)     if (b < 30+0) println(141); else println(999);
1154 acc8= constant 30
1155 acc8+ constant 0
1156 acc8Comp variable 6
1157 brle 1161
1158 acc8= constant 141
1159 call writeLineAcc8
1160 br 1166
1161 acc16= constant 999
1162 call writeLineAcc16
1163 ;test2.j(278)     // var - acc
1164 ;test2.j(279)     // byte - integer
1165 ;test2.j(280)     if (b > 1000+0) println(999); else println(142);
1166 acc16= constant 1000
1167 acc16+ constant 0
1168 acc8= variable 6
1169 acc8CompareAcc16
1170 brle 1174
1171 acc16= constant 999
1172 call writeLineAcc16
1173 br 1177
1174 acc8= constant 142
1175 call writeLineAcc8
1176 ;test2.j(281)     if (b < 1000+0) println(143); else println(999);
1177 acc16= constant 1000
1178 acc16+ constant 0
1179 acc8= variable 6
1180 acc8CompareAcc16
1181 brge 1185
1182 acc8= constant 143
1183 call writeLineAcc8
1184 br 1190
1185 acc16= constant 999
1186 call writeLineAcc16
1187 ;test2.j(282)     // var - acc
1188 ;test2.j(283)     // integer - byte
1189 ;test2.j(284)     if (i > 1000+0) println(144); else println(999);
1190 acc16= constant 1000
1191 acc16+ constant 0
1192 acc16Comp variable 0
1193 brge 1197
1194 acc8= constant 144
1195 call writeLineAcc8
1196 br 1200
1197 acc16= constant 999
1198 call writeLineAcc16
1199 ;test2.j(285)     if (i < 3000+0) println(145); else println(999);
1200 acc16= constant 3000
1201 acc16+ constant 0
1202 acc16Comp variable 0
1203 brle 1207
1204 acc8= constant 145
1205 call writeLineAcc8
1206 br 1212
1207 acc16= constant 999
1208 call writeLineAcc16
1209 ;test2.j(286)     // var - acc
1210 ;test2.j(287)     // integer - integer
1211 ;test2.j(288)     if (i > 1000+0) println(146); else println(999);
1212 acc16= constant 1000
1213 acc16+ constant 0
1214 acc16Comp variable 0
1215 brge 1219
1216 acc8= constant 146
1217 call writeLineAcc8
1218 br 1222
1219 acc16= constant 999
1220 call writeLineAcc16
1221 ;test2.j(289)     if (i < 3000+0) println(147); else println(999);
1222 acc16= constant 3000
1223 acc16+ constant 0
1224 acc16Comp variable 0
1225 brle 1229
1226 acc8= constant 147
1227 call writeLineAcc8
1228 br 1232
1229 acc16= constant 999
1230 call writeLineAcc16
1231 ;test2.j(290)     println(148);
1232 acc8= constant 148
1233 call writeLineAcc8
1234 ;test2.j(291)     println(149);
1235 acc8= constant 149
1236 call writeLineAcc8
1237 ;test2.j(292)   
1238 ;test2.j(293)     /************************/
1239 ;test2.j(294)     // var - var
1240 ;test2.j(295)     // byte - byte
1241 ;test2.j(296)     if (b > b1) println(150);
1242 acc8= variable 6
1243 acc8Comp variable 7
1244 brle 1248
1245 acc8= constant 150
1246 call writeLineAcc8
1247 ;test2.j(297)     if (b < b3) println(151);
1248 acc8= variable 6
1249 acc8Comp variable 8
1250 brge 1256
1251 acc8= constant 151
1252 call writeLineAcc8
1253 ;test2.j(298)     // var - var
1254 ;test2.j(299)     // byte - integer
1255 ;test2.j(300)     if (b > i1) println(999); else println(152);
1256 acc8= variable 6
1257 acc16= variable 2
1258 acc8CompareAcc16
1259 brle 1263
1260 acc16= constant 999
1261 call writeLineAcc16
1262 br 1266
1263 acc8= constant 152
1264 call writeLineAcc8
1265 ;test2.j(301)     if (b < i3) println(153);
1266 acc8= variable 6
1267 acc16= variable 4
1268 acc8CompareAcc16
1269 brge 1275
1270 acc8= constant 153
1271 call writeLineAcc8
1272 ;test2.j(302)     // var - var
1273 ;test2.j(303)     // integer - byte
1274 ;test2.j(304)     if (i > i1) println(154);
1275 acc16= variable 0
1276 acc16Comp variable 2
1277 brle 1281
1278 acc8= constant 154
1279 call writeLineAcc8
1280 ;test2.j(305)     if (i < i3) println(155);
1281 acc16= variable 0
1282 acc16Comp variable 4
1283 brge 1289
1284 acc8= constant 155
1285 call writeLineAcc8
1286 ;test2.j(306)     // var - var
1287 ;test2.j(307)     // integer - integer
1288 ;test2.j(308)     if (i > i1) println(156);
1289 acc16= variable 0
1290 acc16Comp variable 2
1291 brle 1295
1292 acc8= constant 156
1293 call writeLineAcc8
1294 ;test2.j(309)     if (i < i3) println(157);
1295 acc16= variable 0
1296 acc16Comp variable 4
1297 brge 1301
1298 acc8= constant 157
1299 call writeLineAcc8
1300 ;test2.j(310)     println(158);
1301 acc8= constant 158
1302 call writeLineAcc8
1303 ;test2.j(311)     println(159);
1304 acc8= constant 159
1305 call writeLineAcc8
1306 ;test2.j(312)   
1307 ;test2.j(313)     /************************/
1308 ;test2.j(314)     // var - stack8
1309 ;test2.j(315)     // byte - byte
1310 ;test2.j(316)   
1311 ;test2.j(317)     // var - stack8
1312 ;test2.j(318)     // byte - integer
1313 ;test2.j(319)   
1314 ;test2.j(320)     // var - stack8
1315 ;test2.j(321)     // integer - byte 
1316 ;test2.j(322)   
1317 ;test2.j(323)     // var - stack8
1318 ;test2.j(324)     // integer - integer
1319 ;test2.j(325)   
1320 ;test2.j(326)     /************************/
1321 ;test2.j(327)     // var - stack16
1322 ;test2.j(328)     // byte - byte
1323 ;test2.j(329)   
1324 ;test2.j(330)     // var - stack16
1325 ;test2.j(331)     // byte - integer
1326 ;test2.j(332)   
1327 ;test2.j(333)     // var - stack16
1328 ;test2.j(334)     // integer - byte
1329 ;test2.j(335)   
1330 ;test2.j(336)     // var - stack16
1331 ;test2.j(337)     // integer - integer
1332 ;test2.j(338)   
1333 ;test2.j(339)     /************************/
1334 ;test2.j(340)     // stack8 - constant
1335 ;test2.j(341)     // stack8 - acc
1336 ;test2.j(342)     // stack8 - var
1337 ;test2.j(343)     // stack8 - stack8
1338 ;test2.j(344)     // stack8 - stack16
1339 ;test2.j(345)   
1340 ;test2.j(346)     /************************/
1341 ;test2.j(347)     // stack16 - constant
1342 ;test2.j(348)     // stack16 - acc
1343 ;test2.j(349)     // stack16 - var
1344 ;test2.j(350)     // stack16 - stack8
1345 ;test2.j(351)     // stack16 - stack16
1346 ;test2.j(352)   
1347 ;test2.j(353)     println("Klaar");
1348 acc16= constant 1353
1349 writeLineString
1350 ;test2.j(354)   }
1351 ;test2.j(355) }
1352 stop
1353 stringConstant 0 = "Klaar"
