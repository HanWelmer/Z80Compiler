   0 call 25
   1 stop
   2 ;test2.j(0) /* Program to test branch instructions in an if statement */
   3 ;test2.j(1) class TestIf {
   4 class TestIf []
   5 ;test2.j(2)   private static word i = 2000;
   6 acc16= constant 2000
   7 acc16=> variable 0
   8 ;test2.j(3)   private static word i1 = 1000;
   9 acc16= constant 1000
  10 acc16=> variable 2
  11 ;test2.j(4)   private static word i3 = 3000;
  12 acc16= constant 3000
  13 acc16=> variable 4
  14 ;test2.j(5)   private static byte b = 20;
  15 acc8= constant 20
  16 acc8=> variable 6
  17 ;test2.j(6)   private static byte b1 = 10;
  18 acc8= constant 10
  19 acc8=> variable 7
  20 ;test2.j(7)   private static byte b3 = 30;
  21 acc8= constant 30
  22 acc8=> variable 8
  23 ;test2.j(8) 
  24 ;test2.j(9)   public static void main() {
  25 method main [public, static] void
  26 ;test2.j(10)     /*Possible operand types: 
  27 ;test2.j(11)      * constant, acc, var, stack8, stack16
  28 ;test2.j(12)      *Possible datatype combinations:
  29 ;test2.j(13)      * byte - byte
  30 ;test2.j(14)      * byte - integer
  31 ;test2.j(15)      * integer - byte
  32 ;test2.j(16)      * integer - integer
  33 ;test2.j(17)     */
  34 ;test2.j(18)   
  35 ;test2.j(19)     println(0);
  36 acc8= constant 0
  37 call writeLineAcc8
  38 ;test2.j(20)   
  39 ;test2.j(21)     /************************/
  40 ;test2.j(22)     // constant - constant
  41 ;test2.j(23)     // byte - byte
  42 ;test2.j(24)     if (1 == 1) println(1); else println(999);
  43 acc8= constant 1
  44 acc8Comp constant 1
  45 brne 49
  46 acc8= constant 1
  47 call writeLineAcc8
  48 br 52
  49 acc16= constant 999
  50 call writeLineAcc16
  51 ;test2.j(25)     if (1 != 0) println(2); else println(999);
  52 acc8= constant 1
  53 acc8Comp constant 0
  54 breq 58
  55 acc8= constant 2
  56 call writeLineAcc8
  57 br 61
  58 acc16= constant 999
  59 call writeLineAcc16
  60 ;test2.j(26)     if (1 >  0) println(3); else println(999);
  61 acc8= constant 1
  62 acc8Comp constant 0
  63 brle 67
  64 acc8= constant 3
  65 call writeLineAcc8
  66 br 70
  67 acc16= constant 999
  68 call writeLineAcc16
  69 ;test2.j(27)     if (1 >= 0) println(4); else println(999);
  70 acc8= constant 1
  71 acc8Comp constant 0
  72 brlt 76
  73 acc8= constant 4
  74 call writeLineAcc8
  75 br 79
  76 acc16= constant 999
  77 call writeLineAcc16
  78 ;test2.j(28)     if (1 >= 1) println(5); else println(999);
  79 acc8= constant 1
  80 acc8Comp constant 1
  81 brlt 85
  82 acc8= constant 5
  83 call writeLineAcc8
  84 br 88
  85 acc16= constant 999
  86 call writeLineAcc16
  87 ;test2.j(29)     if (1 <  2) println(6); else println(999);
  88 acc8= constant 1
  89 acc8Comp constant 2
  90 brge 94
  91 acc8= constant 6
  92 call writeLineAcc8
  93 br 97
  94 acc16= constant 999
  95 call writeLineAcc16
  96 ;test2.j(30)     if (1 <= 2) println(7); else println(999);
  97 acc8= constant 1
  98 acc8Comp constant 2
  99 brgt 103
 100 acc8= constant 7
 101 call writeLineAcc8
 102 br 106
 103 acc16= constant 999
 104 call writeLineAcc16
 105 ;test2.j(31)     if (1 <= 1) println(8); else println(999);
 106 acc8= constant 1
 107 acc8Comp constant 1
 108 brgt 112
 109 acc8= constant 8
 110 call writeLineAcc8
 111 br 115
 112 acc16= constant 999
 113 call writeLineAcc16
 114 ;test2.j(32)     println(9);
 115 acc8= constant 9
 116 call writeLineAcc8
 117 ;test2.j(33)   
 118 ;test2.j(34)     // constant - constant
 119 ;test2.j(35)     // byte - integer
 120 ;test2.j(36)     if (1 == 1000) println(999); else println(10);
 121 acc8= constant 1
 122 acc16= constant 1000
 123 acc8CompareAcc16
 124 brne 128
 125 acc16= constant 999
 126 call writeLineAcc16
 127 br 131
 128 acc8= constant 10
 129 call writeLineAcc8
 130 ;test2.j(37)     if (1 != 1000) println(11);  else println(999);
 131 acc8= constant 1
 132 acc16= constant 1000
 133 acc8CompareAcc16
 134 breq 138
 135 acc8= constant 11
 136 call writeLineAcc8
 137 br 141
 138 acc16= constant 999
 139 call writeLineAcc16
 140 ;test2.j(38)     if (1 >  1000) println(999); else println(12);
 141 acc8= constant 1
 142 acc16= constant 1000
 143 acc8CompareAcc16
 144 brle 148
 145 acc16= constant 999
 146 call writeLineAcc16
 147 br 151
 148 acc8= constant 12
 149 call writeLineAcc8
 150 ;test2.j(39)     if (1 >= 1000) println(999); else println(13);
 151 acc8= constant 1
 152 acc16= constant 1000
 153 acc8CompareAcc16
 154 brlt 158
 155 acc16= constant 999
 156 call writeLineAcc16
 157 br 161
 158 acc8= constant 13
 159 call writeLineAcc8
 160 ;test2.j(40)     if (1 >= 1000) println(999); else println(14);
 161 acc8= constant 1
 162 acc16= constant 1000
 163 acc8CompareAcc16
 164 brlt 168
 165 acc16= constant 999
 166 call writeLineAcc16
 167 br 171
 168 acc8= constant 14
 169 call writeLineAcc8
 170 ;test2.j(41)     if (1 <  2000) println(15);  else println(999);
 171 acc8= constant 1
 172 acc16= constant 2000
 173 acc8CompareAcc16
 174 brge 178
 175 acc8= constant 15
 176 call writeLineAcc8
 177 br 181
 178 acc16= constant 999
 179 call writeLineAcc16
 180 ;test2.j(42)     if (1 <= 2000) println(16);  else println(999);
 181 acc8= constant 1
 182 acc16= constant 2000
 183 acc8CompareAcc16
 184 brgt 188
 185 acc8= constant 16
 186 call writeLineAcc8
 187 br 191
 188 acc16= constant 999
 189 call writeLineAcc16
 190 ;test2.j(43)     if (1 <= 1000) println(17);  else println(999);
 191 acc8= constant 1
 192 acc16= constant 1000
 193 acc8CompareAcc16
 194 brgt 198
 195 acc8= constant 17
 196 call writeLineAcc8
 197 br 201
 198 acc16= constant 999
 199 call writeLineAcc16
 200 ;test2.j(44)     println(18);
 201 acc8= constant 18
 202 call writeLineAcc8
 203 ;test2.j(45)     println(19);
 204 acc8= constant 19
 205 call writeLineAcc8
 206 ;test2.j(46)   
 207 ;test2.j(47)     // constant - constant
 208 ;test2.j(48)     // integer - byte
 209 ;test2.j(49)     if (1000 == 1) println(999); else println(20);
 210 acc16= constant 1000
 211 acc8= constant 1
 212 acc16CompareAcc8
 213 brne 217
 214 acc16= constant 999
 215 call writeLineAcc16
 216 br 220
 217 acc8= constant 20
 218 call writeLineAcc8
 219 ;test2.j(50)     if (1000 != 0) println(21);  else println(999);
 220 acc16= constant 1000
 221 acc8= constant 0
 222 acc16CompareAcc8
 223 breq 227
 224 acc8= constant 21
 225 call writeLineAcc8
 226 br 230
 227 acc16= constant 999
 228 call writeLineAcc16
 229 ;test2.j(51)     if (1000 >  0) println(22);  else println(999);
 230 acc16= constant 1000
 231 acc8= constant 0
 232 acc16CompareAcc8
 233 brle 237
 234 acc8= constant 22
 235 call writeLineAcc8
 236 br 240
 237 acc16= constant 999
 238 call writeLineAcc16
 239 ;test2.j(52)     if (1000 >= 0) println(23);  else println(999);
 240 acc16= constant 1000
 241 acc8= constant 0
 242 acc16CompareAcc8
 243 brlt 247
 244 acc8= constant 23
 245 call writeLineAcc8
 246 br 250
 247 acc16= constant 999
 248 call writeLineAcc16
 249 ;test2.j(53)     if (1000 >= 1) println(24);  else println(999);
 250 acc16= constant 1000
 251 acc8= constant 1
 252 acc16CompareAcc8
 253 brlt 257
 254 acc8= constant 24
 255 call writeLineAcc8
 256 br 260
 257 acc16= constant 999
 258 call writeLineAcc16
 259 ;test2.j(54)     if (1 <  2000) println(25);  else println(999);
 260 acc8= constant 1
 261 acc16= constant 2000
 262 acc8CompareAcc16
 263 brge 267
 264 acc8= constant 25
 265 call writeLineAcc8
 266 br 270
 267 acc16= constant 999
 268 call writeLineAcc16
 269 ;test2.j(55)     if (1 <= 2000) println(26);  else println(999);
 270 acc8= constant 1
 271 acc16= constant 2000
 272 acc8CompareAcc16
 273 brgt 277
 274 acc8= constant 26
 275 call writeLineAcc8
 276 br 280
 277 acc16= constant 999
 278 call writeLineAcc16
 279 ;test2.j(56)     if (1 <= 1000) println(27);  else println(999);
 280 acc8= constant 1
 281 acc16= constant 1000
 282 acc8CompareAcc16
 283 brgt 287
 284 acc8= constant 27
 285 call writeLineAcc8
 286 br 290
 287 acc16= constant 999
 288 call writeLineAcc16
 289 ;test2.j(57)     println(28);
 290 acc8= constant 28
 291 call writeLineAcc8
 292 ;test2.j(58)     println(29);
 293 acc8= constant 29
 294 call writeLineAcc8
 295 ;test2.j(59)   
 296 ;test2.j(60)     // constant - constant
 297 ;test2.j(61)     // integer - integer
 298 ;test2.j(62)     if (1000 == 1000) println(30); else println(999);
 299 acc16= constant 1000
 300 acc16Comp constant 1000
 301 brne 305
 302 acc8= constant 30
 303 call writeLineAcc8
 304 br 308
 305 acc16= constant 999
 306 call writeLineAcc16
 307 ;test2.j(63)     if (1000 != 2000) println(31); else println(999);
 308 acc16= constant 1000
 309 acc16Comp constant 2000
 310 breq 314
 311 acc8= constant 31
 312 call writeLineAcc8
 313 br 317
 314 acc16= constant 999
 315 call writeLineAcc16
 316 ;test2.j(64)     if (2000 >  1000) println(32); else println(999);
 317 acc16= constant 2000
 318 acc16Comp constant 1000
 319 brle 323
 320 acc8= constant 32
 321 call writeLineAcc8
 322 br 326
 323 acc16= constant 999
 324 call writeLineAcc16
 325 ;test2.j(65)     if (2000 >= 1000) println(33); else println(999);
 326 acc16= constant 2000
 327 acc16Comp constant 1000
 328 brlt 332
 329 acc8= constant 33
 330 call writeLineAcc8
 331 br 335
 332 acc16= constant 999
 333 call writeLineAcc16
 334 ;test2.j(66)     if (1000 >= 1000) println(34); else println(999);
 335 acc16= constant 1000
 336 acc16Comp constant 1000
 337 brlt 341
 338 acc8= constant 34
 339 call writeLineAcc8
 340 br 344
 341 acc16= constant 999
 342 call writeLineAcc16
 343 ;test2.j(67)     if (1000 <  2000) println(35); else println(999);
 344 acc16= constant 1000
 345 acc16Comp constant 2000
 346 brge 350
 347 acc8= constant 35
 348 call writeLineAcc8
 349 br 353
 350 acc16= constant 999
 351 call writeLineAcc16
 352 ;test2.j(68)     if (1000 <= 2000) println(36); else println(999);
 353 acc16= constant 1000
 354 acc16Comp constant 2000
 355 brgt 359
 356 acc8= constant 36
 357 call writeLineAcc8
 358 br 362
 359 acc16= constant 999
 360 call writeLineAcc16
 361 ;test2.j(69)     if (1000 <= 1000) println(37); else println(999);
 362 acc16= constant 1000
 363 acc16Comp constant 1000
 364 brgt 368
 365 acc8= constant 37
 366 call writeLineAcc8
 367 br 371
 368 acc16= constant 999
 369 call writeLineAcc16
 370 ;test2.j(70)     println(38);
 371 acc8= constant 38
 372 call writeLineAcc8
 373 ;test2.j(71)     println(39);
 374 acc8= constant 39
 375 call writeLineAcc8
 376 ;test2.j(72)   
 377 ;test2.j(73)     /************************/
 378 ;test2.j(74)     // constant - acc
 379 ;test2.j(75)     // byte - byte
 380 ;test2.j(76)     if (1 > 0+0) println(40); else println(999);
 381 acc8= constant 0
 382 acc8+ constant 0
 383 acc8Comp constant 1
 384 brge 388
 385 acc8= constant 40
 386 call writeLineAcc8
 387 br 391
 388 acc16= constant 999
 389 call writeLineAcc16
 390 ;test2.j(77)     if (1 < 2+0) println(41); else println(999);
 391 acc8= constant 2
 392 acc8+ constant 0
 393 acc8Comp constant 1
 394 brle 398
 395 acc8= constant 41
 396 call writeLineAcc8
 397 br 403
 398 acc16= constant 999
 399 call writeLineAcc16
 400 ;test2.j(78)     // constant - acc
 401 ;test2.j(79)     // byte - integer
 402 ;test2.j(80)     if (1 > 1000+0) println(999); else println(42);
 403 acc16= constant 1000
 404 acc16+ constant 0
 405 acc8= constant 1
 406 acc8CompareAcc16
 407 brle 411
 408 acc16= constant 999
 409 call writeLineAcc16
 410 br 414
 411 acc8= constant 42
 412 call writeLineAcc8
 413 ;test2.j(81)     if (1 < 1000+0) println(43);  else println(999);
 414 acc16= constant 1000
 415 acc16+ constant 0
 416 acc8= constant 1
 417 acc8CompareAcc16
 418 brge 422
 419 acc8= constant 43
 420 call writeLineAcc8
 421 br 427
 422 acc16= constant 999
 423 call writeLineAcc16
 424 ;test2.j(82)     // constant - acc
 425 ;test2.j(83)     // integer - byte
 426 ;test2.j(84)     if (1000 > 0+0) println(44);  else println(999);
 427 acc8= constant 0
 428 acc8+ constant 0
 429 acc16= constant 1000
 430 acc16CompareAcc8
 431 brle 435
 432 acc8= constant 44
 433 call writeLineAcc8
 434 br 438
 435 acc16= constant 999
 436 call writeLineAcc16
 437 ;test2.j(85)     if (1000 < 0+0) println(999); else println(45);
 438 acc8= constant 0
 439 acc8+ constant 0
 440 acc16= constant 1000
 441 acc16CompareAcc8
 442 brge 446
 443 acc16= constant 999
 444 call writeLineAcc16
 445 br 451
 446 acc8= constant 45
 447 call writeLineAcc8
 448 ;test2.j(86)     // constant - acc
 449 ;test2.j(87)     // integer - integer
 450 ;test2.j(88)     if (2000 > 1000+0) println(46); else println(999);
 451 acc16= constant 1000
 452 acc16+ constant 0
 453 acc16Comp constant 2000
 454 brge 458
 455 acc8= constant 46
 456 call writeLineAcc8
 457 br 461
 458 acc16= constant 999
 459 call writeLineAcc16
 460 ;test2.j(89)     if (1000 < 2000+0) println(47); else println(999);
 461 acc16= constant 2000
 462 acc16+ constant 0
 463 acc16Comp constant 1000
 464 brle 468
 465 acc8= constant 47
 466 call writeLineAcc8
 467 br 471
 468 acc16= constant 999
 469 call writeLineAcc16
 470 ;test2.j(90)     println(48);
 471 acc8= constant 48
 472 call writeLineAcc8
 473 ;test2.j(91)     println(49);
 474 acc8= constant 49
 475 call writeLineAcc8
 476 ;test2.j(92)   
 477 ;test2.j(93)     /************************/
 478 ;test2.j(94)     // constant - var
 479 ;test2.j(95)     // byte - byte
 480 ;test2.j(96)     if (30 > b) println(50); else println(999);
 481 acc8= variable 6
 482 acc8Comp constant 30
 483 brge 487
 484 acc8= constant 50
 485 call writeLineAcc8
 486 br 490
 487 acc16= constant 999
 488 call writeLineAcc16
 489 ;test2.j(97)     if (10 < b) println(51); else println(999);
 490 acc8= variable 6
 491 acc8Comp constant 10
 492 brle 496
 493 acc8= constant 51
 494 call writeLineAcc8
 495 br 501
 496 acc16= constant 999
 497 call writeLineAcc16
 498 ;test2.j(98)     // constant - var
 499 ;test2.j(99)     // byte - integer
 500 ;test2.j(100)     if (30 > i) println(999); else println(52);
 501 acc16= variable 0
 502 acc8= constant 30
 503 acc8CompareAcc16
 504 brle 508
 505 acc16= constant 999
 506 call writeLineAcc16
 507 br 511
 508 acc8= constant 52
 509 call writeLineAcc8
 510 ;test2.j(101)     if (10 < i) println(53); else println(999);
 511 acc16= variable 0
 512 acc8= constant 10
 513 acc8CompareAcc16
 514 brge 518
 515 acc8= constant 53
 516 call writeLineAcc8
 517 br 523
 518 acc16= constant 999
 519 call writeLineAcc16
 520 ;test2.j(102)     // constant - var
 521 ;test2.j(103)     // integer - byte
 522 ;test2.j(104)     if (3000 > b) println(54); else println(999);
 523 acc8= variable 6
 524 acc16= constant 3000
 525 acc16CompareAcc8
 526 brle 530
 527 acc8= constant 54
 528 call writeLineAcc8
 529 br 533
 530 acc16= constant 999
 531 call writeLineAcc16
 532 ;test2.j(105)     if (1000 < b) println(999); else println(55);
 533 acc8= variable 6
 534 acc16= constant 1000
 535 acc16CompareAcc8
 536 brge 540
 537 acc16= constant 999
 538 call writeLineAcc16
 539 br 545
 540 acc8= constant 55
 541 call writeLineAcc8
 542 ;test2.j(106)     // constant - var
 543 ;test2.j(107)     // integer - integer
 544 ;test2.j(108)     if (3000 > i) println(56); else println(999);
 545 acc16= variable 0
 546 acc16Comp constant 3000
 547 brge 551
 548 acc8= constant 56
 549 call writeLineAcc8
 550 br 554
 551 acc16= constant 999
 552 call writeLineAcc16
 553 ;test2.j(109)     if (1000 < i) println(57); else println(999);
 554 acc16= variable 0
 555 acc16Comp constant 1000
 556 brle 560
 557 acc8= constant 57
 558 call writeLineAcc8
 559 br 563
 560 acc16= constant 999
 561 call writeLineAcc16
 562 ;test2.j(110)     println(58);
 563 acc8= constant 58
 564 call writeLineAcc8
 565 ;test2.j(111)     println(59);
 566 acc8= constant 59
 567 call writeLineAcc8
 568 ;test2.j(112)   
 569 ;test2.j(113)     /************************/
 570 ;test2.j(114)     // constant - stack8
 571 ;test2.j(115)     // byte - byte
 572 ;test2.j(116)     println(60);
 573 acc8= constant 60
 574 call writeLineAcc8
 575 ;test2.j(117)     println(61);
 576 acc8= constant 61
 577 call writeLineAcc8
 578 ;test2.j(118)     // constant - stack8
 579 ;test2.j(119)     // byte - integer
 580 ;test2.j(120)     println(62);
 581 acc8= constant 62
 582 call writeLineAcc8
 583 ;test2.j(121)     println(63);
 584 acc8= constant 63
 585 call writeLineAcc8
 586 ;test2.j(122)     // constant - stack8
 587 ;test2.j(123)     // integer - byte
 588 ;test2.j(124)     println(64);
 589 acc8= constant 64
 590 call writeLineAcc8
 591 ;test2.j(125)     println(65);
 592 acc8= constant 65
 593 call writeLineAcc8
 594 ;test2.j(126)     // constant - stack8
 595 ;test2.j(127)     // integer - integer
 596 ;test2.j(128)     println(66);
 597 acc8= constant 66
 598 call writeLineAcc8
 599 ;test2.j(129)     println(67);
 600 acc8= constant 67
 601 call writeLineAcc8
 602 ;test2.j(130)     println(68);
 603 acc8= constant 68
 604 call writeLineAcc8
 605 ;test2.j(131)     println(69);
 606 acc8= constant 69
 607 call writeLineAcc8
 608 ;test2.j(132)   
 609 ;test2.j(133)     /************************/
 610 ;test2.j(134)     // constant - stack16
 611 ;test2.j(135)     // byte - byte
 612 ;test2.j(136)     println(70);
 613 acc8= constant 70
 614 call writeLineAcc8
 615 ;test2.j(137)     println(71);
 616 acc8= constant 71
 617 call writeLineAcc8
 618 ;test2.j(138)     // constant - stack16
 619 ;test2.j(139)     // byte - integer
 620 ;test2.j(140)     println(72);
 621 acc8= constant 72
 622 call writeLineAcc8
 623 ;test2.j(141)     println(73);
 624 acc8= constant 73
 625 call writeLineAcc8
 626 ;test2.j(142)     // constant - stack16
 627 ;test2.j(143)     // integer - byte
 628 ;test2.j(144)     println(74);
 629 acc8= constant 74
 630 call writeLineAcc8
 631 ;test2.j(145)     println(75);
 632 acc8= constant 75
 633 call writeLineAcc8
 634 ;test2.j(146)     // constant - stack16
 635 ;test2.j(147)     // integer - integer
 636 ;test2.j(148)     println(76);
 637 acc8= constant 76
 638 call writeLineAcc8
 639 ;test2.j(149)     println(77);
 640 acc8= constant 77
 641 call writeLineAcc8
 642 ;test2.j(150)     println(78);
 643 acc8= constant 78
 644 call writeLineAcc8
 645 ;test2.j(151)     println(79);
 646 acc8= constant 79
 647 call writeLineAcc8
 648 ;test2.j(152)   
 649 ;test2.j(153)     /************************/
 650 ;test2.j(154)     // acc - constant
 651 ;test2.j(155)     // byte - byte
 652 ;test2.j(156)     if (30+0 > 20) println(80); else println(999);
 653 acc8= constant 30
 654 acc8+ constant 0
 655 acc8Comp constant 20
 656 brle 662
 657 acc8= constant 80
 658 call writeLineAcc8
 659 br 665
 660 acc16= constant 999
 661 call writeLineAcc16
 662 ;test2.j(157)     if (10+0 < 20) println(81); else println(999);
 663 acc8= constant 10
 664 acc8+ constant 0
 665 acc8Comp constant 20
 666 brge 674
 667 acc8= constant 81
 668 call writeLineAcc8
 669 br 679
 670 acc16= constant 999
 671 call writeLineAcc16
 672 ;test2.j(158)     // acc - constant
 673 ;test2.j(159)     // byte - integer
 674 ;test2.j(160)     if (30+0 > 2000) println(999); else println(82);
 675 acc8= constant 30
 676 acc8+ constant 0
 677 acc16= constant 2000
 678 acc8CompareAcc16
 679 brle 689
 680 acc16= constant 999
 681 call writeLineAcc16
 682 br 692
 683 acc8= constant 82
 684 call writeLineAcc8
 685 ;test2.j(161)     if (10+0 < 2000) println(83); else println(999);
 686 acc8= constant 10
 687 acc8+ constant 0
 688 acc16= constant 2000
 689 acc8CompareAcc16
 690 brge 702
 691 acc8= constant 83
 692 call writeLineAcc8
 693 br 707
 694 acc16= constant 999
 695 call writeLineAcc16
 696 ;test2.j(162)     // acc - constant
 697 ;test2.j(163)     // integer - byte
 698 ;test2.j(164)     if (3000+0 > 20) println(84); else println(999);
 699 acc16= constant 3000
 700 acc16+ constant 0
 701 acc8= constant 20
 702 acc16CompareAcc8
 703 brle 717
 704 acc8= constant 84
 705 call writeLineAcc8
 706 br 720
 707 acc16= constant 999
 708 call writeLineAcc16
 709 ;test2.j(165)     if (1000+0 < 20) println(999); else println(85);
 710 acc16= constant 1000
 711 acc16+ constant 0
 712 acc8= constant 20
 713 acc16CompareAcc8
 714 brge 730
 715 acc16= constant 999
 716 call writeLineAcc16
 717 br 735
 718 acc8= constant 85
 719 call writeLineAcc8
 720 ;test2.j(166)     // acc - constant
 721 ;test2.j(167)     // integer - integer
 722 ;test2.j(168)     if (3000+0 > 2000) println(86); else println(999);
 723 acc16= constant 3000
 724 acc16+ constant 0
 725 acc16Comp constant 2000
 726 brle 744
 727 acc8= constant 86
 728 call writeLineAcc8
 729 br 747
 730 acc16= constant 999
 731 call writeLineAcc16
 732 ;test2.j(169)     if (1000+0 < 2000) println(87); else println(999);
 733 acc16= constant 1000
 734 acc16+ constant 0
 735 acc16Comp constant 2000
 736 brge 756
 737 acc8= constant 87
 738 call writeLineAcc8
 739 br 759
 740 acc16= constant 999
 741 call writeLineAcc16
 742 ;test2.j(170)     println(88);
 743 acc8= constant 88
 744 call writeLineAcc8
 745 ;test2.j(171)     println(89);
 746 acc8= constant 89
 747 call writeLineAcc8
 748 ;test2.j(172)   
 749 ;test2.j(173)     /************************/
 750 ;test2.j(174)     // acc - acc
 751 ;test2.j(175)     // byte - byte
 752 ;test2.j(176)     if (30+0 > 20+0) println(90); else println(999);
 753 acc8= constant 30
 754 acc8+ constant 0
 755 <acc8
 756 acc8= constant 20
 757 acc8+ constant 0
 758 revAcc8Comp unstack8
 759 brge 779
 760 acc8= constant 90
 761 call writeLineAcc8
 762 br 782
 763 acc16= constant 999
 764 call writeLineAcc16
 765 ;test2.j(177)     if (10+0 < 20+0) println(91); else println(999);
 766 acc8= constant 10
 767 acc8+ constant 0
 768 <acc8
 769 acc8= constant 20
 770 acc8+ constant 0
 771 revAcc8Comp unstack8
 772 brle 792
 773 acc8= constant 91
 774 call writeLineAcc8
 775 br 797
 776 acc16= constant 999
 777 call writeLineAcc16
 778 ;test2.j(178)     // acc - acc
 779 ;test2.j(179)     // byte - integer
 780 ;test2.j(180)     if (30+0 > 2000+0) println(999); else println(92);
 781 acc8= constant 30
 782 acc8+ constant 0
 783 <acc8
 784 acc16= constant 2000
 785 acc16+ constant 0
 786 acc8= unstack8
 787 acc8CompareAcc16
 788 brle 808
 789 acc16= constant 999
 790 call writeLineAcc16
 791 br 811
 792 acc8= constant 92
 793 call writeLineAcc8
 794 ;test2.j(181)     if (10+0 < 2000+0) println(93); else println(999);
 795 acc8= constant 10
 796 acc8+ constant 0
 797 <acc8
 798 acc16= constant 2000
 799 acc16+ constant 0
 800 acc8= unstack8
 801 acc8CompareAcc16
 802 brge 822
 803 acc8= constant 93
 804 call writeLineAcc8
 805 br 827
 806 acc16= constant 999
 807 call writeLineAcc16
 808 ;test2.j(182)     // acc - acc
 809 ;test2.j(183)     // integer - byte
 810 ;test2.j(184)     if (3000+0 > 20+0) println(94); else println(999);
 811 acc16= constant 3000
 812 acc16+ constant 0
 813 <acc16
 814 acc8= constant 20
 815 acc8+ constant 0
 816 acc16= unstack16
 817 acc16CompareAcc8
 818 brle 838
 819 acc8= constant 94
 820 call writeLineAcc8
 821 br 841
 822 acc16= constant 999
 823 call writeLineAcc16
 824 ;test2.j(185)     if (1000+0 < 20+0) println(999); else println(95);
 825 acc16= constant 1000
 826 acc16+ constant 0
 827 <acc16
 828 acc8= constant 20
 829 acc8+ constant 0
 830 acc16= unstack16
 831 acc16CompareAcc8
 832 brge 852
 833 acc16= constant 999
 834 call writeLineAcc16
 835 br 857
 836 acc8= constant 95
 837 call writeLineAcc8
 838 ;test2.j(186)     // acc - acc
 839 ;test2.j(187)     // integer - integer
 840 ;test2.j(188)     if (3000+0 > 2000+0) println(96); else println(999);
 841 acc16= constant 3000
 842 acc16+ constant 0
 843 <acc16
 844 acc16= constant 2000
 845 acc16+ constant 0
 846 revAcc16Comp unstack16
 847 brge 867
 848 acc8= constant 96
 849 call writeLineAcc8
 850 br 870
 851 acc16= constant 999
 852 call writeLineAcc16
 853 ;test2.j(189)     if (1000+0 < 2000+0) println(97); else println(999);
 854 acc16= constant 1000
 855 acc16+ constant 0
 856 <acc16
 857 acc16= constant 2000
 858 acc16+ constant 0
 859 revAcc16Comp unstack16
 860 brle 880
 861 acc8= constant 97
 862 call writeLineAcc8
 863 br 883
 864 acc16= constant 999
 865 call writeLineAcc16
 866 ;test2.j(190)     println(98);
 867 acc8= constant 98
 868 call writeLineAcc8
 869 ;test2.j(191)     println(99);
 870 acc8= constant 99
 871 call writeLineAcc8
 872 ;test2.j(192)   
 873 ;test2.j(193)     /************************/
 874 ;test2.j(194)     // acc - var
 875 ;test2.j(195)     // byte - byte
 876 ;test2.j(196)     if (30+0 > b) println(100); else println(999);
 877 acc8= constant 30
 878 acc8+ constant 0
 879 acc8Comp variable 6
 880 brle 902
 881 acc8= constant 100
 882 call writeLineAcc8
 883 br 905
 884 acc16= constant 999
 885 call writeLineAcc16
 886 ;test2.j(197)     if (10+0 < b) println(101); else println(999);
 887 acc8= constant 10
 888 acc8+ constant 0
 889 acc8Comp variable 6
 890 brge 914
 891 acc8= constant 101
 892 call writeLineAcc8
 893 br 919
 894 acc16= constant 999
 895 call writeLineAcc16
 896 ;test2.j(198)     // acc - var
 897 ;test2.j(199)     // byte - integer
 898 ;test2.j(200)     if (30+0 > i) println(999); else println(102);
 899 acc8= constant 30
 900 acc8+ constant 0
 901 acc16= variable 0
 902 acc8CompareAcc16
 903 brle 929
 904 acc16= constant 999
 905 call writeLineAcc16
 906 br 932
 907 acc8= constant 102
 908 call writeLineAcc8
 909 ;test2.j(201)     if (10+0 < i) println(103); else println(999);
 910 acc8= constant 10
 911 acc8+ constant 0
 912 acc16= variable 0
 913 acc8CompareAcc16
 914 brge 942
 915 acc8= constant 103
 916 call writeLineAcc8
 917 br 947
 918 acc16= constant 999
 919 call writeLineAcc16
 920 ;test2.j(202)     // acc - var
 921 ;test2.j(203)     // integer - byte
 922 ;test2.j(204)     if (3000+0 > b) println(104); else println(999);
 923 acc16= constant 3000
 924 acc16+ constant 0
 925 acc8= variable 6
 926 acc16CompareAcc8
 927 brle 957
 928 acc8= constant 104
 929 call writeLineAcc8
 930 br 960
 931 acc16= constant 999
 932 call writeLineAcc16
 933 ;test2.j(205)     if (1000+0 < b) println(999); else println(105);
 934 acc16= constant 1000
 935 acc16+ constant 0
 936 acc8= variable 6
 937 acc16CompareAcc8
 938 brge 970
 939 acc16= constant 999
 940 call writeLineAcc16
 941 br 975
 942 acc8= constant 105
 943 call writeLineAcc8
 944 ;test2.j(206)     // acc - var
 945 ;test2.j(207)     // integer - integer
 946 ;test2.j(208)     if (3000+0 > i) println(106); else println(999);
 947 acc16= constant 3000
 948 acc16+ constant 0
 949 acc16Comp variable 0
 950 brle 984
 951 acc8= constant 106
 952 call writeLineAcc8
 953 br 987
 954 acc16= constant 999
 955 call writeLineAcc16
 956 ;test2.j(209)     if (1000+0 < i) println(107); else println(999);
 957 acc16= constant 1000
 958 acc16+ constant 0
 959 acc16Comp variable 0
 960 brge 996
 961 acc8= constant 107
 962 call writeLineAcc8
 963 br 999
 964 acc16= constant 999
 965 call writeLineAcc16
 966 ;test2.j(210)     println(108);
 967 acc8= constant 108
 968 call writeLineAcc8
 969 ;test2.j(211)     println(109);
 970 acc8= constant 109
 971 call writeLineAcc8
 972 ;test2.j(212)   
 973 ;test2.j(213)     /************************/
 974 ;test2.j(214)     // acc - stack8
 975 ;test2.j(215)     // byte - byte
 976 ;test2.j(216)     println(110);
 977 acc8= constant 110
 978 call writeLineAcc8
 979 ;test2.j(217)     println(111);
 980 acc8= constant 111
 981 call writeLineAcc8
 982 ;test2.j(218)     // acc - stack8
 983 ;test2.j(219)     // byte - integer
 984 ;test2.j(220)     println(112);
 985 acc8= constant 112
 986 call writeLineAcc8
 987 ;test2.j(221)     println(113);
 988 acc8= constant 113
 989 call writeLineAcc8
 990 ;test2.j(222)     // acc - stack8
 991 ;test2.j(223)     // integer - byte
 992 ;test2.j(224)     println(114);
 993 acc8= constant 114
 994 call writeLineAcc8
 995 ;test2.j(225)     println(115);
 996 acc8= constant 115
 997 call writeLineAcc8
 998 ;test2.j(226)     // acc - stack8
 999 ;test2.j(227)     // integer - integer
1000 ;test2.j(228)     println(116);
1001 acc8= constant 116
1002 call writeLineAcc8
1003 ;test2.j(229)     println(117);
1004 acc8= constant 117
1005 call writeLineAcc8
1006 ;test2.j(230)     println(118);
1007 acc8= constant 118
1008 call writeLineAcc8
1009 ;test2.j(231)     println(119);
1010 acc8= constant 119
1011 call writeLineAcc8
1012 ;test2.j(232)   
1013 ;test2.j(233)     /************************/
1014 ;test2.j(234)     // acc - stack16
1015 ;test2.j(235)     // byte - byte
1016 ;test2.j(236)     println(120);
1017 acc8= constant 120
1018 call writeLineAcc8
1019 ;test2.j(237)     println(121);
1020 acc8= constant 121
1021 call writeLineAcc8
1022 ;test2.j(238)     // acc - stack16
1023 ;test2.j(239)     // byte - integer
1024 ;test2.j(240)     println(122);
1025 acc8= constant 122
1026 call writeLineAcc8
1027 ;test2.j(241)     println(123);
1028 acc8= constant 123
1029 call writeLineAcc8
1030 ;test2.j(242)     // acc - stack16
1031 ;test2.j(243)     // integer - byte
1032 ;test2.j(244)     println(124);
1033 acc8= constant 124
1034 call writeLineAcc8
1035 ;test2.j(245)     println(125);
1036 acc8= constant 125
1037 call writeLineAcc8
1038 ;test2.j(246)     // acc - stack16
1039 ;test2.j(247)     // integer - integer
1040 ;test2.j(248)     println(126);
1041 acc8= constant 126
1042 call writeLineAcc8
1043 ;test2.j(249)     println(127);
1044 acc8= constant 127
1045 call writeLineAcc8
1046 ;test2.j(250)     println(128);
1047 acc8= constant 128
1048 call writeLineAcc8
1049 ;test2.j(251)     println(129);
1050 acc8= constant 129
1051 call writeLineAcc8
1052 ;test2.j(252)   
1053 ;test2.j(253)     /************************/
1054 ;test2.j(254)     // var - constant
1055 ;test2.j(255)     // byte - byte
1056 ;test2.j(256)     if (b > 10) println(130); else println(999);
1057 acc8= variable 6
1058 acc8Comp constant 10
1059 brle 1095
1060 acc8= constant 130
1061 call writeLineAcc8
1062 br 1098
1063 acc16= constant 999
1064 call writeLineAcc16
1065 ;test2.j(257)     if (b < 30) println(131); else println(999);
1066 acc8= variable 6
1067 acc8Comp constant 30
1068 brge 1104
1069 acc8= constant 131
1070 call writeLineAcc8
1071 br 1109
1072 acc16= constant 999
1073 call writeLineAcc16
1074 ;test2.j(258)     // var - constant
1075 ;test2.j(259)     // byte - integer
1076 ;test2.j(260)     if (b > 1000) println(999); else println(132);
1077 acc8= variable 6
1078 acc16= constant 1000
1079 acc8CompareAcc16
1080 brle 1116
1081 acc16= constant 999
1082 call writeLineAcc16
1083 br 1119
1084 acc8= constant 132
1085 call writeLineAcc8
1086 ;test2.j(261)     if (b < 1000) println(133); else println(999);
1087 acc8= variable 6
1088 acc16= constant 1000
1089 acc8CompareAcc16
1090 brge 1126
1091 acc8= constant 133
1092 call writeLineAcc8
1093 br 1131
1094 acc16= constant 999
1095 call writeLineAcc16
1096 ;test2.j(262)     // var - constant
1097 ;test2.j(263)     // integer - byte
1098 ;test2.j(264)     if (i > 1000) println(134); else println(999);
1099 acc16= variable 0
1100 acc16Comp constant 1000
1101 brle 1137
1102 acc8= constant 134
1103 call writeLineAcc8
1104 br 1140
1105 acc16= constant 999
1106 call writeLineAcc16
1107 ;test2.j(265)     if (i < 3000) println(135); else println(999);
1108 acc16= variable 0
1109 acc16Comp constant 3000
1110 brge 1146
1111 acc8= constant 135
1112 call writeLineAcc8
1113 br 1151
1114 acc16= constant 999
1115 call writeLineAcc16
1116 ;test2.j(266)     // var - constant
1117 ;test2.j(267)     // integer - integer
1118 ;test2.j(268)     if (i > 1000) println(136); else println(999);
1119 acc16= variable 0
1120 acc16Comp constant 1000
1121 brle 1157
1122 acc8= constant 136
1123 call writeLineAcc8
1124 br 1160
1125 acc16= constant 999
1126 call writeLineAcc16
1127 ;test2.j(269)     if (i < 3000) println(137); else println(999);
1128 acc16= variable 0
1129 acc16Comp constant 3000
1130 brge 1166
1131 acc8= constant 137
1132 call writeLineAcc8
1133 br 1169
1134 acc16= constant 999
1135 call writeLineAcc16
1136 ;test2.j(270)     println(138);
1137 acc8= constant 138
1138 call writeLineAcc8
1139 ;test2.j(271)     println(139);
1140 acc8= constant 139
1141 call writeLineAcc8
1142 ;test2.j(272)   
1143 ;test2.j(273)     /************************/
1144 ;test2.j(274)     // var - acc
1145 ;test2.j(275)     // byte - byte
1146 ;test2.j(276)     if (b > 10+0) println(140); else println(999);
1147 acc8= constant 10
1148 acc8+ constant 0
1149 acc8Comp variable 6
1150 brge 1186
1151 acc8= constant 140
1152 call writeLineAcc8
1153 br 1189
1154 acc16= constant 999
1155 call writeLineAcc16
1156 ;test2.j(277)     if (b < 30+0) println(141); else println(999);
1157 acc8= constant 30
1158 acc8+ constant 0
1159 acc8Comp variable 6
1160 brle 1196
1161 acc8= constant 141
1162 call writeLineAcc8
1163 br 1201
1164 acc16= constant 999
1165 call writeLineAcc16
1166 ;test2.j(278)     // var - acc
1167 ;test2.j(279)     // byte - integer
1168 ;test2.j(280)     if (b > 1000+0) println(999); else println(142);
1169 acc16= constant 1000
1170 acc16+ constant 0
1171 acc8= variable 6
1172 acc8CompareAcc16
1173 brle 1209
1174 acc16= constant 999
1175 call writeLineAcc16
1176 br 1212
1177 acc8= constant 142
1178 call writeLineAcc8
1179 ;test2.j(281)     if (b < 1000+0) println(143); else println(999);
1180 acc16= constant 1000
1181 acc16+ constant 0
1182 acc8= variable 6
1183 acc8CompareAcc16
1184 brge 1220
1185 acc8= constant 143
1186 call writeLineAcc8
1187 br 1225
1188 acc16= constant 999
1189 call writeLineAcc16
1190 ;test2.j(282)     // var - acc
1191 ;test2.j(283)     // integer - byte
1192 ;test2.j(284)     if (i > 1000+0) println(144); else println(999);
1193 acc16= constant 1000
1194 acc16+ constant 0
1195 acc16Comp variable 0
1196 brge 1232
1197 acc8= constant 144
1198 call writeLineAcc8
1199 br 1235
1200 acc16= constant 999
1201 call writeLineAcc16
1202 ;test2.j(285)     if (i < 3000+0) println(145); else println(999);
1203 acc16= constant 3000
1204 acc16+ constant 0
1205 acc16Comp variable 0
1206 brle 1242
1207 acc8= constant 145
1208 call writeLineAcc8
1209 br 1247
1210 acc16= constant 999
1211 call writeLineAcc16
1212 ;test2.j(286)     // var - acc
1213 ;test2.j(287)     // integer - integer
1214 ;test2.j(288)     if (i > 1000+0) println(146); else println(999);
1215 acc16= constant 1000
1216 acc16+ constant 0
1217 acc16Comp variable 0
1218 brge 1254
1219 acc8= constant 146
1220 call writeLineAcc8
1221 br 1257
1222 acc16= constant 999
1223 call writeLineAcc16
1224 ;test2.j(289)     if (i < 3000+0) println(147); else println(999);
1225 acc16= constant 3000
1226 acc16+ constant 0
1227 acc16Comp variable 0
1228 brle 1264
1229 acc8= constant 147
1230 call writeLineAcc8
1231 br 1267
1232 acc16= constant 999
1233 call writeLineAcc16
1234 ;test2.j(290)     println(148);
1235 acc8= constant 148
1236 call writeLineAcc8
1237 ;test2.j(291)     println(149);
1238 acc8= constant 149
1239 call writeLineAcc8
1240 ;test2.j(292)   
1241 ;test2.j(293)     /************************/
1242 ;test2.j(294)     // var - var
1243 ;test2.j(295)     // byte - byte
1244 ;test2.j(296)     if (b > b1) println(150);
1245 acc8= variable 6
1246 acc8Comp variable 7
1247 brle 1283
1248 acc8= constant 150
1249 call writeLineAcc8
1250 ;test2.j(297)     if (b < b3) println(151);
1251 acc8= variable 6
1252 acc8Comp variable 8
1253 brge 1291
1254 acc8= constant 151
1255 call writeLineAcc8
1256 ;test2.j(298)     // var - var
1257 ;test2.j(299)     // byte - integer
1258 ;test2.j(300)     if (b > i1) println(999); else println(152);
1259 acc8= variable 6
1260 acc16= variable 2
1261 acc8CompareAcc16
1262 brle 1298
1263 acc16= constant 999
1264 call writeLineAcc16
1265 br 1301
1266 acc8= constant 152
1267 call writeLineAcc8
1268 ;test2.j(301)     if (b < i3) println(153);
1269 acc8= variable 6
1270 acc16= variable 4
1271 acc8CompareAcc16
1272 brge 1310
1273 acc8= constant 153
1274 call writeLineAcc8
1275 ;test2.j(302)     // var - var
1276 ;test2.j(303)     // integer - byte
1277 ;test2.j(304)     if (i > i1) println(154);
1278 acc16= variable 0
1279 acc16Comp variable 2
1280 brle 1316
1281 acc8= constant 154
1282 call writeLineAcc8
1283 ;test2.j(305)     if (i < i3) println(155);
1284 acc16= variable 0
1285 acc16Comp variable 4
1286 brge 1324
1287 acc8= constant 155
1288 call writeLineAcc8
1289 ;test2.j(306)     // var - var
1290 ;test2.j(307)     // integer - integer
1291 ;test2.j(308)     if (i > i1) println(156);
1292 acc16= variable 0
1293 acc16Comp variable 2
1294 brle 1330
1295 acc8= constant 156
1296 call writeLineAcc8
1297 ;test2.j(309)     if (i < i3) println(157);
1298 acc16= variable 0
1299 acc16Comp variable 4
1300 brge 1336
1301 acc8= constant 157
1302 call writeLineAcc8
1303 ;test2.j(310)     println(158);
1304 acc8= constant 158
1305 call writeLineAcc8
1306 ;test2.j(311)     println(159);
1307 acc8= constant 159
1308 call writeLineAcc8
1309 ;test2.j(312)   
1310 ;test2.j(313)     /************************/
1311 ;test2.j(314)     // var - stack8
1312 ;test2.j(315)     // byte - byte
1313 ;test2.j(316)   
1314 ;test2.j(317)     // var - stack8
1315 ;test2.j(318)     // byte - integer
1316 ;test2.j(319)   
1317 ;test2.j(320)     // var - stack8
1318 ;test2.j(321)     // integer - byte 
1319 ;test2.j(322)   
1320 ;test2.j(323)     // var - stack8
1321 ;test2.j(324)     // integer - integer
1322 ;test2.j(325)   
1323 ;test2.j(326)     /************************/
1324 ;test2.j(327)     // var - stack16
1325 ;test2.j(328)     // byte - byte
1326 ;test2.j(329)   
1327 ;test2.j(330)     // var - stack16
1328 ;test2.j(331)     // byte - integer
1329 ;test2.j(332)   
1330 ;test2.j(333)     // var - stack16
1331 ;test2.j(334)     // integer - byte
1332 ;test2.j(335)   
1333 ;test2.j(336)     // var - stack16
1334 ;test2.j(337)     // integer - integer
1335 ;test2.j(338)   
1336 ;test2.j(339)     /************************/
1337 ;test2.j(340)     // stack8 - constant
1338 ;test2.j(341)     // stack8 - acc
1339 ;test2.j(342)     // stack8 - var
1340 ;test2.j(343)     // stack8 - stack8
1341 ;test2.j(344)     // stack8 - stack16
1342 ;test2.j(345)   
1343 ;test2.j(346)     /************************/
1344 ;test2.j(347)     // stack16 - constant
1345 ;test2.j(348)     // stack16 - acc
1346 ;test2.j(349)     // stack16 - var
1347 ;test2.j(350)     // stack16 - stack8
1348 ;test2.j(351)     // stack16 - stack16
1349 ;test2.j(352)   
1350 ;test2.j(353)     println("Klaar");
1351 acc16= constant 1356
1352 writeLineString
1353 return
1354 ;test2.j(354)   }
1355 ;test2.j(355) }
1356 stringConstant 0 = "Klaar"
