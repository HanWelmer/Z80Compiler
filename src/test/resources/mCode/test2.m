   0 ;test2.j(0) /* Program to test branch instructions in an if statement */
   1 ;test2.j(1) class TestIf {
   2 class TestIf []
   3 ;test2.j(2)   private static word i = 2000;
   4 acc16= constant 2000
   5 acc16=> variable 0
   6 ;test2.j(3)   private static word i1 = 1000;
   7 acc16= constant 1000
   8 acc16=> variable 2
   9 ;test2.j(4)   private static word i3 = 3000;
  10 acc16= constant 3000
  11 acc16=> variable 4
  12 ;test2.j(5)   private static byte b = 20;
  13 acc8= constant 20
  14 acc8=> variable 6
  15 ;test2.j(6)   private static byte b1 = 10;
  16 acc8= constant 10
  17 acc8=> variable 7
  18 ;test2.j(7)   private static byte b3 = 30;
  19 acc8= constant 30
  20 acc8=> variable 8
  21 ;test2.j(8) 
  22 ;test2.j(9)   public static void main() {
  23 method main [public, static] void
  24 ;test2.j(10)     /*Possible operand types: 
  25 ;test2.j(11)      * constant, acc, var, stack8, stack16
  26 ;test2.j(12)      *Possible datatype combinations:
  27 ;test2.j(13)      * byte - byte
  28 ;test2.j(14)      * byte - integer
  29 ;test2.j(15)      * integer - byte
  30 ;test2.j(16)      * integer - integer
  31 ;test2.j(17)     */
  32 ;test2.j(18)   
  33 ;test2.j(19)     println(0);
  34 acc8= constant 0
  35 call writeLineAcc8
  36 ;test2.j(20)   
  37 ;test2.j(21)     /************************/
  38 ;test2.j(22)     // constant - constant
  39 ;test2.j(23)     // byte - byte
  40 ;test2.j(24)     if (1 == 1) println(1); else println(999);
  41 acc8= constant 1
  42 acc8Comp constant 1
  43 brne 47
  44 acc8= constant 1
  45 call writeLineAcc8
  46 br 50
  47 acc16= constant 999
  48 call writeLineAcc16
  49 ;test2.j(25)     if (1 != 0) println(2); else println(999);
  50 acc8= constant 1
  51 acc8Comp constant 0
  52 breq 56
  53 acc8= constant 2
  54 call writeLineAcc8
  55 br 59
  56 acc16= constant 999
  57 call writeLineAcc16
  58 ;test2.j(26)     if (1 >  0) println(3); else println(999);
  59 acc8= constant 1
  60 acc8Comp constant 0
  61 brle 65
  62 acc8= constant 3
  63 call writeLineAcc8
  64 br 68
  65 acc16= constant 999
  66 call writeLineAcc16
  67 ;test2.j(27)     if (1 >= 0) println(4); else println(999);
  68 acc8= constant 1
  69 acc8Comp constant 0
  70 brlt 74
  71 acc8= constant 4
  72 call writeLineAcc8
  73 br 77
  74 acc16= constant 999
  75 call writeLineAcc16
  76 ;test2.j(28)     if (1 >= 1) println(5); else println(999);
  77 acc8= constant 1
  78 acc8Comp constant 1
  79 brlt 83
  80 acc8= constant 5
  81 call writeLineAcc8
  82 br 86
  83 acc16= constant 999
  84 call writeLineAcc16
  85 ;test2.j(29)     if (1 <  2) println(6); else println(999);
  86 acc8= constant 1
  87 acc8Comp constant 2
  88 brge 92
  89 acc8= constant 6
  90 call writeLineAcc8
  91 br 95
  92 acc16= constant 999
  93 call writeLineAcc16
  94 ;test2.j(30)     if (1 <= 2) println(7); else println(999);
  95 acc8= constant 1
  96 acc8Comp constant 2
  97 brgt 101
  98 acc8= constant 7
  99 call writeLineAcc8
 100 br 104
 101 acc16= constant 999
 102 call writeLineAcc16
 103 ;test2.j(31)     if (1 <= 1) println(8); else println(999);
 104 acc8= constant 1
 105 acc8Comp constant 1
 106 brgt 110
 107 acc8= constant 8
 108 call writeLineAcc8
 109 br 113
 110 acc16= constant 999
 111 call writeLineAcc16
 112 ;test2.j(32)     println(9);
 113 acc8= constant 9
 114 call writeLineAcc8
 115 ;test2.j(33)   
 116 ;test2.j(34)     // constant - constant
 117 ;test2.j(35)     // byte - integer
 118 ;test2.j(36)     if (1 == 1000) println(999); else println(10);
 119 acc8= constant 1
 120 acc16= constant 1000
 121 acc8CompareAcc16
 122 brne 126
 123 acc16= constant 999
 124 call writeLineAcc16
 125 br 129
 126 acc8= constant 10
 127 call writeLineAcc8
 128 ;test2.j(37)     if (1 != 1000) println(11);  else println(999);
 129 acc8= constant 1
 130 acc16= constant 1000
 131 acc8CompareAcc16
 132 breq 136
 133 acc8= constant 11
 134 call writeLineAcc8
 135 br 139
 136 acc16= constant 999
 137 call writeLineAcc16
 138 ;test2.j(38)     if (1 >  1000) println(999); else println(12);
 139 acc8= constant 1
 140 acc16= constant 1000
 141 acc8CompareAcc16
 142 brle 146
 143 acc16= constant 999
 144 call writeLineAcc16
 145 br 149
 146 acc8= constant 12
 147 call writeLineAcc8
 148 ;test2.j(39)     if (1 >= 1000) println(999); else println(13);
 149 acc8= constant 1
 150 acc16= constant 1000
 151 acc8CompareAcc16
 152 brlt 156
 153 acc16= constant 999
 154 call writeLineAcc16
 155 br 159
 156 acc8= constant 13
 157 call writeLineAcc8
 158 ;test2.j(40)     if (1 >= 1000) println(999); else println(14);
 159 acc8= constant 1
 160 acc16= constant 1000
 161 acc8CompareAcc16
 162 brlt 166
 163 acc16= constant 999
 164 call writeLineAcc16
 165 br 169
 166 acc8= constant 14
 167 call writeLineAcc8
 168 ;test2.j(41)     if (1 <  2000) println(15);  else println(999);
 169 acc8= constant 1
 170 acc16= constant 2000
 171 acc8CompareAcc16
 172 brge 176
 173 acc8= constant 15
 174 call writeLineAcc8
 175 br 179
 176 acc16= constant 999
 177 call writeLineAcc16
 178 ;test2.j(42)     if (1 <= 2000) println(16);  else println(999);
 179 acc8= constant 1
 180 acc16= constant 2000
 181 acc8CompareAcc16
 182 brgt 186
 183 acc8= constant 16
 184 call writeLineAcc8
 185 br 189
 186 acc16= constant 999
 187 call writeLineAcc16
 188 ;test2.j(43)     if (1 <= 1000) println(17);  else println(999);
 189 acc8= constant 1
 190 acc16= constant 1000
 191 acc8CompareAcc16
 192 brgt 196
 193 acc8= constant 17
 194 call writeLineAcc8
 195 br 199
 196 acc16= constant 999
 197 call writeLineAcc16
 198 ;test2.j(44)     println(18);
 199 acc8= constant 18
 200 call writeLineAcc8
 201 ;test2.j(45)     println(19);
 202 acc8= constant 19
 203 call writeLineAcc8
 204 ;test2.j(46)   
 205 ;test2.j(47)     // constant - constant
 206 ;test2.j(48)     // integer - byte
 207 ;test2.j(49)     if (1000 == 1) println(999); else println(20);
 208 acc16= constant 1000
 209 acc8= constant 1
 210 acc16CompareAcc8
 211 brne 215
 212 acc16= constant 999
 213 call writeLineAcc16
 214 br 218
 215 acc8= constant 20
 216 call writeLineAcc8
 217 ;test2.j(50)     if (1000 != 0) println(21);  else println(999);
 218 acc16= constant 1000
 219 acc8= constant 0
 220 acc16CompareAcc8
 221 breq 225
 222 acc8= constant 21
 223 call writeLineAcc8
 224 br 228
 225 acc16= constant 999
 226 call writeLineAcc16
 227 ;test2.j(51)     if (1000 >  0) println(22);  else println(999);
 228 acc16= constant 1000
 229 acc8= constant 0
 230 acc16CompareAcc8
 231 brle 235
 232 acc8= constant 22
 233 call writeLineAcc8
 234 br 238
 235 acc16= constant 999
 236 call writeLineAcc16
 237 ;test2.j(52)     if (1000 >= 0) println(23);  else println(999);
 238 acc16= constant 1000
 239 acc8= constant 0
 240 acc16CompareAcc8
 241 brlt 245
 242 acc8= constant 23
 243 call writeLineAcc8
 244 br 248
 245 acc16= constant 999
 246 call writeLineAcc16
 247 ;test2.j(53)     if (1000 >= 1) println(24);  else println(999);
 248 acc16= constant 1000
 249 acc8= constant 1
 250 acc16CompareAcc8
 251 brlt 255
 252 acc8= constant 24
 253 call writeLineAcc8
 254 br 258
 255 acc16= constant 999
 256 call writeLineAcc16
 257 ;test2.j(54)     if (1 <  2000) println(25);  else println(999);
 258 acc8= constant 1
 259 acc16= constant 2000
 260 acc8CompareAcc16
 261 brge 265
 262 acc8= constant 25
 263 call writeLineAcc8
 264 br 268
 265 acc16= constant 999
 266 call writeLineAcc16
 267 ;test2.j(55)     if (1 <= 2000) println(26);  else println(999);
 268 acc8= constant 1
 269 acc16= constant 2000
 270 acc8CompareAcc16
 271 brgt 275
 272 acc8= constant 26
 273 call writeLineAcc8
 274 br 278
 275 acc16= constant 999
 276 call writeLineAcc16
 277 ;test2.j(56)     if (1 <= 1000) println(27);  else println(999);
 278 acc8= constant 1
 279 acc16= constant 1000
 280 acc8CompareAcc16
 281 brgt 285
 282 acc8= constant 27
 283 call writeLineAcc8
 284 br 288
 285 acc16= constant 999
 286 call writeLineAcc16
 287 ;test2.j(57)     println(28);
 288 acc8= constant 28
 289 call writeLineAcc8
 290 ;test2.j(58)     println(29);
 291 acc8= constant 29
 292 call writeLineAcc8
 293 ;test2.j(59)   
 294 ;test2.j(60)     // constant - constant
 295 ;test2.j(61)     // integer - integer
 296 ;test2.j(62)     if (1000 == 1000) println(30); else println(999);
 297 acc16= constant 1000
 298 acc16Comp constant 1000
 299 brne 303
 300 acc8= constant 30
 301 call writeLineAcc8
 302 br 306
 303 acc16= constant 999
 304 call writeLineAcc16
 305 ;test2.j(63)     if (1000 != 2000) println(31); else println(999);
 306 acc16= constant 1000
 307 acc16Comp constant 2000
 308 breq 312
 309 acc8= constant 31
 310 call writeLineAcc8
 311 br 315
 312 acc16= constant 999
 313 call writeLineAcc16
 314 ;test2.j(64)     if (2000 >  1000) println(32); else println(999);
 315 acc16= constant 2000
 316 acc16Comp constant 1000
 317 brle 321
 318 acc8= constant 32
 319 call writeLineAcc8
 320 br 324
 321 acc16= constant 999
 322 call writeLineAcc16
 323 ;test2.j(65)     if (2000 >= 1000) println(33); else println(999);
 324 acc16= constant 2000
 325 acc16Comp constant 1000
 326 brlt 330
 327 acc8= constant 33
 328 call writeLineAcc8
 329 br 333
 330 acc16= constant 999
 331 call writeLineAcc16
 332 ;test2.j(66)     if (1000 >= 1000) println(34); else println(999);
 333 acc16= constant 1000
 334 acc16Comp constant 1000
 335 brlt 339
 336 acc8= constant 34
 337 call writeLineAcc8
 338 br 342
 339 acc16= constant 999
 340 call writeLineAcc16
 341 ;test2.j(67)     if (1000 <  2000) println(35); else println(999);
 342 acc16= constant 1000
 343 acc16Comp constant 2000
 344 brge 348
 345 acc8= constant 35
 346 call writeLineAcc8
 347 br 351
 348 acc16= constant 999
 349 call writeLineAcc16
 350 ;test2.j(68)     if (1000 <= 2000) println(36); else println(999);
 351 acc16= constant 1000
 352 acc16Comp constant 2000
 353 brgt 357
 354 acc8= constant 36
 355 call writeLineAcc8
 356 br 360
 357 acc16= constant 999
 358 call writeLineAcc16
 359 ;test2.j(69)     if (1000 <= 1000) println(37); else println(999);
 360 acc16= constant 1000
 361 acc16Comp constant 1000
 362 brgt 366
 363 acc8= constant 37
 364 call writeLineAcc8
 365 br 369
 366 acc16= constant 999
 367 call writeLineAcc16
 368 ;test2.j(70)     println(38);
 369 acc8= constant 38
 370 call writeLineAcc8
 371 ;test2.j(71)     println(39);
 372 acc8= constant 39
 373 call writeLineAcc8
 374 ;test2.j(72)   
 375 ;test2.j(73)     /************************/
 376 ;test2.j(74)     // constant - acc
 377 ;test2.j(75)     // byte - byte
 378 ;test2.j(76)     if (1 > 0+0) println(40); else println(999);
 379 acc8= constant 0
 380 acc8+ constant 0
 381 acc8Comp constant 1
 382 brge 386
 383 acc8= constant 40
 384 call writeLineAcc8
 385 br 389
 386 acc16= constant 999
 387 call writeLineAcc16
 388 ;test2.j(77)     if (1 < 2+0) println(41); else println(999);
 389 acc8= constant 2
 390 acc8+ constant 0
 391 acc8Comp constant 1
 392 brle 396
 393 acc8= constant 41
 394 call writeLineAcc8
 395 br 401
 396 acc16= constant 999
 397 call writeLineAcc16
 398 ;test2.j(78)     // constant - acc
 399 ;test2.j(79)     // byte - integer
 400 ;test2.j(80)     if (1 > 1000+0) println(999); else println(42);
 401 acc16= constant 1000
 402 acc16+ constant 0
 403 acc8= constant 1
 404 acc8CompareAcc16
 405 brle 409
 406 acc16= constant 999
 407 call writeLineAcc16
 408 br 412
 409 acc8= constant 42
 410 call writeLineAcc8
 411 ;test2.j(81)     if (1 < 1000+0) println(43);  else println(999);
 412 acc16= constant 1000
 413 acc16+ constant 0
 414 acc8= constant 1
 415 acc8CompareAcc16
 416 brge 420
 417 acc8= constant 43
 418 call writeLineAcc8
 419 br 425
 420 acc16= constant 999
 421 call writeLineAcc16
 422 ;test2.j(82)     // constant - acc
 423 ;test2.j(83)     // integer - byte
 424 ;test2.j(84)     if (1000 > 0+0) println(44);  else println(999);
 425 acc8= constant 0
 426 acc8+ constant 0
 427 acc16= constant 1000
 428 acc16CompareAcc8
 429 brle 433
 430 acc8= constant 44
 431 call writeLineAcc8
 432 br 436
 433 acc16= constant 999
 434 call writeLineAcc16
 435 ;test2.j(85)     if (1000 < 0+0) println(999); else println(45);
 436 acc8= constant 0
 437 acc8+ constant 0
 438 acc16= constant 1000
 439 acc16CompareAcc8
 440 brge 444
 441 acc16= constant 999
 442 call writeLineAcc16
 443 br 449
 444 acc8= constant 45
 445 call writeLineAcc8
 446 ;test2.j(86)     // constant - acc
 447 ;test2.j(87)     // integer - integer
 448 ;test2.j(88)     if (2000 > 1000+0) println(46); else println(999);
 449 acc16= constant 1000
 450 acc16+ constant 0
 451 acc16Comp constant 2000
 452 brge 456
 453 acc8= constant 46
 454 call writeLineAcc8
 455 br 459
 456 acc16= constant 999
 457 call writeLineAcc16
 458 ;test2.j(89)     if (1000 < 2000+0) println(47); else println(999);
 459 acc16= constant 2000
 460 acc16+ constant 0
 461 acc16Comp constant 1000
 462 brle 466
 463 acc8= constant 47
 464 call writeLineAcc8
 465 br 469
 466 acc16= constant 999
 467 call writeLineAcc16
 468 ;test2.j(90)     println(48);
 469 acc8= constant 48
 470 call writeLineAcc8
 471 ;test2.j(91)     println(49);
 472 acc8= constant 49
 473 call writeLineAcc8
 474 ;test2.j(92)   
 475 ;test2.j(93)     /************************/
 476 ;test2.j(94)     // constant - var
 477 ;test2.j(95)     // byte - byte
 478 ;test2.j(96)     if (30 > b) println(50); else println(999);
 479 acc8= variable 6
 480 acc8Comp constant 30
 481 brge 485
 482 acc8= constant 50
 483 call writeLineAcc8
 484 br 488
 485 acc16= constant 999
 486 call writeLineAcc16
 487 ;test2.j(97)     if (10 < b) println(51); else println(999);
 488 acc8= variable 6
 489 acc8Comp constant 10
 490 brle 494
 491 acc8= constant 51
 492 call writeLineAcc8
 493 br 499
 494 acc16= constant 999
 495 call writeLineAcc16
 496 ;test2.j(98)     // constant - var
 497 ;test2.j(99)     // byte - integer
 498 ;test2.j(100)     if (30 > i) println(999); else println(52);
 499 acc16= variable 0
 500 acc8= constant 30
 501 acc8CompareAcc16
 502 brle 506
 503 acc16= constant 999
 504 call writeLineAcc16
 505 br 509
 506 acc8= constant 52
 507 call writeLineAcc8
 508 ;test2.j(101)     if (10 < i) println(53); else println(999);
 509 acc16= variable 0
 510 acc8= constant 10
 511 acc8CompareAcc16
 512 brge 516
 513 acc8= constant 53
 514 call writeLineAcc8
 515 br 521
 516 acc16= constant 999
 517 call writeLineAcc16
 518 ;test2.j(102)     // constant - var
 519 ;test2.j(103)     // integer - byte
 520 ;test2.j(104)     if (3000 > b) println(54); else println(999);
 521 acc8= variable 6
 522 acc16= constant 3000
 523 acc16CompareAcc8
 524 brle 528
 525 acc8= constant 54
 526 call writeLineAcc8
 527 br 531
 528 acc16= constant 999
 529 call writeLineAcc16
 530 ;test2.j(105)     if (1000 < b) println(999); else println(55);
 531 acc8= variable 6
 532 acc16= constant 1000
 533 acc16CompareAcc8
 534 brge 538
 535 acc16= constant 999
 536 call writeLineAcc16
 537 br 543
 538 acc8= constant 55
 539 call writeLineAcc8
 540 ;test2.j(106)     // constant - var
 541 ;test2.j(107)     // integer - integer
 542 ;test2.j(108)     if (3000 > i) println(56); else println(999);
 543 acc16= variable 0
 544 acc16Comp constant 3000
 545 brge 549
 546 acc8= constant 56
 547 call writeLineAcc8
 548 br 552
 549 acc16= constant 999
 550 call writeLineAcc16
 551 ;test2.j(109)     if (1000 < i) println(57); else println(999);
 552 acc16= variable 0
 553 acc16Comp constant 1000
 554 brle 558
 555 acc8= constant 57
 556 call writeLineAcc8
 557 br 561
 558 acc16= constant 999
 559 call writeLineAcc16
 560 ;test2.j(110)     println(58);
 561 acc8= constant 58
 562 call writeLineAcc8
 563 ;test2.j(111)     println(59);
 564 acc8= constant 59
 565 call writeLineAcc8
 566 ;test2.j(112)   
 567 ;test2.j(113)     /************************/
 568 ;test2.j(114)     // constant - stack8
 569 ;test2.j(115)     // byte - byte
 570 ;test2.j(116)     println(60);
 571 acc8= constant 60
 572 call writeLineAcc8
 573 ;test2.j(117)     println(61);
 574 acc8= constant 61
 575 call writeLineAcc8
 576 ;test2.j(118)     // constant - stack8
 577 ;test2.j(119)     // byte - integer
 578 ;test2.j(120)     println(62);
 579 acc8= constant 62
 580 call writeLineAcc8
 581 ;test2.j(121)     println(63);
 582 acc8= constant 63
 583 call writeLineAcc8
 584 ;test2.j(122)     // constant - stack8
 585 ;test2.j(123)     // integer - byte
 586 ;test2.j(124)     println(64);
 587 acc8= constant 64
 588 call writeLineAcc8
 589 ;test2.j(125)     println(65);
 590 acc8= constant 65
 591 call writeLineAcc8
 592 ;test2.j(126)     // constant - stack8
 593 ;test2.j(127)     // integer - integer
 594 ;test2.j(128)     println(66);
 595 acc8= constant 66
 596 call writeLineAcc8
 597 ;test2.j(129)     println(67);
 598 acc8= constant 67
 599 call writeLineAcc8
 600 ;test2.j(130)     println(68);
 601 acc8= constant 68
 602 call writeLineAcc8
 603 ;test2.j(131)     println(69);
 604 acc8= constant 69
 605 call writeLineAcc8
 606 ;test2.j(132)   
 607 ;test2.j(133)     /************************/
 608 ;test2.j(134)     // constant - stack16
 609 ;test2.j(135)     // byte - byte
 610 ;test2.j(136)     println(70);
 611 acc8= constant 70
 612 call writeLineAcc8
 613 ;test2.j(137)     println(71);
 614 acc8= constant 71
 615 call writeLineAcc8
 616 ;test2.j(138)     // constant - stack16
 617 ;test2.j(139)     // byte - integer
 618 ;test2.j(140)     println(72);
 619 acc8= constant 72
 620 call writeLineAcc8
 621 ;test2.j(141)     println(73);
 622 acc8= constant 73
 623 call writeLineAcc8
 624 ;test2.j(142)     // constant - stack16
 625 ;test2.j(143)     // integer - byte
 626 ;test2.j(144)     println(74);
 627 acc8= constant 74
 628 call writeLineAcc8
 629 ;test2.j(145)     println(75);
 630 acc8= constant 75
 631 call writeLineAcc8
 632 ;test2.j(146)     // constant - stack16
 633 ;test2.j(147)     // integer - integer
 634 ;test2.j(148)     println(76);
 635 acc8= constant 76
 636 call writeLineAcc8
 637 ;test2.j(149)     println(77);
 638 acc8= constant 77
 639 call writeLineAcc8
 640 ;test2.j(150)     println(78);
 641 acc8= constant 78
 642 call writeLineAcc8
 643 ;test2.j(151)     println(79);
 644 acc8= constant 79
 645 call writeLineAcc8
 646 ;test2.j(152)   
 647 ;test2.j(153)     /************************/
 648 ;test2.j(154)     // acc - constant
 649 ;test2.j(155)     // byte - byte
 650 ;test2.j(156)     if (30+0 > 20) println(80); else println(999);
 651 acc8= constant 30
 652 acc8+ constant 0
 653 acc8Comp constant 20
 654 brle 658
 655 acc8= constant 80
 656 call writeLineAcc8
 657 br 661
 658 acc16= constant 999
 659 call writeLineAcc16
 660 ;test2.j(157)     if (10+0 < 20) println(81); else println(999);
 661 acc8= constant 10
 662 acc8+ constant 0
 663 acc8Comp constant 20
 664 brge 668
 665 acc8= constant 81
 666 call writeLineAcc8
 667 br 673
 668 acc16= constant 999
 669 call writeLineAcc16
 670 ;test2.j(158)     // acc - constant
 671 ;test2.j(159)     // byte - integer
 672 ;test2.j(160)     if (30+0 > 2000) println(999); else println(82);
 673 acc8= constant 30
 674 acc8+ constant 0
 675 acc16= constant 2000
 676 acc8CompareAcc16
 677 brle 681
 678 acc16= constant 999
 679 call writeLineAcc16
 680 br 684
 681 acc8= constant 82
 682 call writeLineAcc8
 683 ;test2.j(161)     if (10+0 < 2000) println(83); else println(999);
 684 acc8= constant 10
 685 acc8+ constant 0
 686 acc16= constant 2000
 687 acc8CompareAcc16
 688 brge 692
 689 acc8= constant 83
 690 call writeLineAcc8
 691 br 697
 692 acc16= constant 999
 693 call writeLineAcc16
 694 ;test2.j(162)     // acc - constant
 695 ;test2.j(163)     // integer - byte
 696 ;test2.j(164)     if (3000+0 > 20) println(84); else println(999);
 697 acc16= constant 3000
 698 acc16+ constant 0
 699 acc8= constant 20
 700 acc16CompareAcc8
 701 brle 705
 702 acc8= constant 84
 703 call writeLineAcc8
 704 br 708
 705 acc16= constant 999
 706 call writeLineAcc16
 707 ;test2.j(165)     if (1000+0 < 20) println(999); else println(85);
 708 acc16= constant 1000
 709 acc16+ constant 0
 710 acc8= constant 20
 711 acc16CompareAcc8
 712 brge 716
 713 acc16= constant 999
 714 call writeLineAcc16
 715 br 721
 716 acc8= constant 85
 717 call writeLineAcc8
 718 ;test2.j(166)     // acc - constant
 719 ;test2.j(167)     // integer - integer
 720 ;test2.j(168)     if (3000+0 > 2000) println(86); else println(999);
 721 acc16= constant 3000
 722 acc16+ constant 0
 723 acc16Comp constant 2000
 724 brle 728
 725 acc8= constant 86
 726 call writeLineAcc8
 727 br 731
 728 acc16= constant 999
 729 call writeLineAcc16
 730 ;test2.j(169)     if (1000+0 < 2000) println(87); else println(999);
 731 acc16= constant 1000
 732 acc16+ constant 0
 733 acc16Comp constant 2000
 734 brge 738
 735 acc8= constant 87
 736 call writeLineAcc8
 737 br 741
 738 acc16= constant 999
 739 call writeLineAcc16
 740 ;test2.j(170)     println(88);
 741 acc8= constant 88
 742 call writeLineAcc8
 743 ;test2.j(171)     println(89);
 744 acc8= constant 89
 745 call writeLineAcc8
 746 ;test2.j(172)   
 747 ;test2.j(173)     /************************/
 748 ;test2.j(174)     // acc - acc
 749 ;test2.j(175)     // byte - byte
 750 ;test2.j(176)     if (30+0 > 20+0) println(90); else println(999);
 751 acc8= constant 30
 752 acc8+ constant 0
 753 <acc8
 754 acc8= constant 20
 755 acc8+ constant 0
 756 revAcc8Comp unstack8
 757 brge 761
 758 acc8= constant 90
 759 call writeLineAcc8
 760 br 764
 761 acc16= constant 999
 762 call writeLineAcc16
 763 ;test2.j(177)     if (10+0 < 20+0) println(91); else println(999);
 764 acc8= constant 10
 765 acc8+ constant 0
 766 <acc8
 767 acc8= constant 20
 768 acc8+ constant 0
 769 revAcc8Comp unstack8
 770 brle 774
 771 acc8= constant 91
 772 call writeLineAcc8
 773 br 779
 774 acc16= constant 999
 775 call writeLineAcc16
 776 ;test2.j(178)     // acc - acc
 777 ;test2.j(179)     // byte - integer
 778 ;test2.j(180)     if (30+0 > 2000+0) println(999); else println(92);
 779 acc8= constant 30
 780 acc8+ constant 0
 781 <acc8
 782 acc16= constant 2000
 783 acc16+ constant 0
 784 acc8= unstack8
 785 acc8CompareAcc16
 786 brle 790
 787 acc16= constant 999
 788 call writeLineAcc16
 789 br 793
 790 acc8= constant 92
 791 call writeLineAcc8
 792 ;test2.j(181)     if (10+0 < 2000+0) println(93); else println(999);
 793 acc8= constant 10
 794 acc8+ constant 0
 795 <acc8
 796 acc16= constant 2000
 797 acc16+ constant 0
 798 acc8= unstack8
 799 acc8CompareAcc16
 800 brge 804
 801 acc8= constant 93
 802 call writeLineAcc8
 803 br 809
 804 acc16= constant 999
 805 call writeLineAcc16
 806 ;test2.j(182)     // acc - acc
 807 ;test2.j(183)     // integer - byte
 808 ;test2.j(184)     if (3000+0 > 20+0) println(94); else println(999);
 809 acc16= constant 3000
 810 acc16+ constant 0
 811 <acc16
 812 acc8= constant 20
 813 acc8+ constant 0
 814 acc16= unstack16
 815 acc16CompareAcc8
 816 brle 820
 817 acc8= constant 94
 818 call writeLineAcc8
 819 br 823
 820 acc16= constant 999
 821 call writeLineAcc16
 822 ;test2.j(185)     if (1000+0 < 20+0) println(999); else println(95);
 823 acc16= constant 1000
 824 acc16+ constant 0
 825 <acc16
 826 acc8= constant 20
 827 acc8+ constant 0
 828 acc16= unstack16
 829 acc16CompareAcc8
 830 brge 834
 831 acc16= constant 999
 832 call writeLineAcc16
 833 br 839
 834 acc8= constant 95
 835 call writeLineAcc8
 836 ;test2.j(186)     // acc - acc
 837 ;test2.j(187)     // integer - integer
 838 ;test2.j(188)     if (3000+0 > 2000+0) println(96); else println(999);
 839 acc16= constant 3000
 840 acc16+ constant 0
 841 <acc16
 842 acc16= constant 2000
 843 acc16+ constant 0
 844 revAcc16Comp unstack16
 845 brge 849
 846 acc8= constant 96
 847 call writeLineAcc8
 848 br 852
 849 acc16= constant 999
 850 call writeLineAcc16
 851 ;test2.j(189)     if (1000+0 < 2000+0) println(97); else println(999);
 852 acc16= constant 1000
 853 acc16+ constant 0
 854 <acc16
 855 acc16= constant 2000
 856 acc16+ constant 0
 857 revAcc16Comp unstack16
 858 brle 862
 859 acc8= constant 97
 860 call writeLineAcc8
 861 br 865
 862 acc16= constant 999
 863 call writeLineAcc16
 864 ;test2.j(190)     println(98);
 865 acc8= constant 98
 866 call writeLineAcc8
 867 ;test2.j(191)     println(99);
 868 acc8= constant 99
 869 call writeLineAcc8
 870 ;test2.j(192)   
 871 ;test2.j(193)     /************************/
 872 ;test2.j(194)     // acc - var
 873 ;test2.j(195)     // byte - byte
 874 ;test2.j(196)     if (30+0 > b) println(100); else println(999);
 875 acc8= constant 30
 876 acc8+ constant 0
 877 acc8Comp variable 6
 878 brle 882
 879 acc8= constant 100
 880 call writeLineAcc8
 881 br 885
 882 acc16= constant 999
 883 call writeLineAcc16
 884 ;test2.j(197)     if (10+0 < b) println(101); else println(999);
 885 acc8= constant 10
 886 acc8+ constant 0
 887 acc8Comp variable 6
 888 brge 892
 889 acc8= constant 101
 890 call writeLineAcc8
 891 br 897
 892 acc16= constant 999
 893 call writeLineAcc16
 894 ;test2.j(198)     // acc - var
 895 ;test2.j(199)     // byte - integer
 896 ;test2.j(200)     if (30+0 > i) println(999); else println(102);
 897 acc8= constant 30
 898 acc8+ constant 0
 899 acc16= variable 0
 900 acc8CompareAcc16
 901 brle 905
 902 acc16= constant 999
 903 call writeLineAcc16
 904 br 908
 905 acc8= constant 102
 906 call writeLineAcc8
 907 ;test2.j(201)     if (10+0 < i) println(103); else println(999);
 908 acc8= constant 10
 909 acc8+ constant 0
 910 acc16= variable 0
 911 acc8CompareAcc16
 912 brge 916
 913 acc8= constant 103
 914 call writeLineAcc8
 915 br 921
 916 acc16= constant 999
 917 call writeLineAcc16
 918 ;test2.j(202)     // acc - var
 919 ;test2.j(203)     // integer - byte
 920 ;test2.j(204)     if (3000+0 > b) println(104); else println(999);
 921 acc16= constant 3000
 922 acc16+ constant 0
 923 acc8= variable 6
 924 acc16CompareAcc8
 925 brle 929
 926 acc8= constant 104
 927 call writeLineAcc8
 928 br 932
 929 acc16= constant 999
 930 call writeLineAcc16
 931 ;test2.j(205)     if (1000+0 < b) println(999); else println(105);
 932 acc16= constant 1000
 933 acc16+ constant 0
 934 acc8= variable 6
 935 acc16CompareAcc8
 936 brge 940
 937 acc16= constant 999
 938 call writeLineAcc16
 939 br 945
 940 acc8= constant 105
 941 call writeLineAcc8
 942 ;test2.j(206)     // acc - var
 943 ;test2.j(207)     // integer - integer
 944 ;test2.j(208)     if (3000+0 > i) println(106); else println(999);
 945 acc16= constant 3000
 946 acc16+ constant 0
 947 acc16Comp variable 0
 948 brle 952
 949 acc8= constant 106
 950 call writeLineAcc8
 951 br 955
 952 acc16= constant 999
 953 call writeLineAcc16
 954 ;test2.j(209)     if (1000+0 < i) println(107); else println(999);
 955 acc16= constant 1000
 956 acc16+ constant 0
 957 acc16Comp variable 0
 958 brge 962
 959 acc8= constant 107
 960 call writeLineAcc8
 961 br 965
 962 acc16= constant 999
 963 call writeLineAcc16
 964 ;test2.j(210)     println(108);
 965 acc8= constant 108
 966 call writeLineAcc8
 967 ;test2.j(211)     println(109);
 968 acc8= constant 109
 969 call writeLineAcc8
 970 ;test2.j(212)   
 971 ;test2.j(213)     /************************/
 972 ;test2.j(214)     // acc - stack8
 973 ;test2.j(215)     // byte - byte
 974 ;test2.j(216)     println(110);
 975 acc8= constant 110
 976 call writeLineAcc8
 977 ;test2.j(217)     println(111);
 978 acc8= constant 111
 979 call writeLineAcc8
 980 ;test2.j(218)     // acc - stack8
 981 ;test2.j(219)     // byte - integer
 982 ;test2.j(220)     println(112);
 983 acc8= constant 112
 984 call writeLineAcc8
 985 ;test2.j(221)     println(113);
 986 acc8= constant 113
 987 call writeLineAcc8
 988 ;test2.j(222)     // acc - stack8
 989 ;test2.j(223)     // integer - byte
 990 ;test2.j(224)     println(114);
 991 acc8= constant 114
 992 call writeLineAcc8
 993 ;test2.j(225)     println(115);
 994 acc8= constant 115
 995 call writeLineAcc8
 996 ;test2.j(226)     // acc - stack8
 997 ;test2.j(227)     // integer - integer
 998 ;test2.j(228)     println(116);
 999 acc8= constant 116
1000 call writeLineAcc8
1001 ;test2.j(229)     println(117);
1002 acc8= constant 117
1003 call writeLineAcc8
1004 ;test2.j(230)     println(118);
1005 acc8= constant 118
1006 call writeLineAcc8
1007 ;test2.j(231)     println(119);
1008 acc8= constant 119
1009 call writeLineAcc8
1010 ;test2.j(232)   
1011 ;test2.j(233)     /************************/
1012 ;test2.j(234)     // acc - stack16
1013 ;test2.j(235)     // byte - byte
1014 ;test2.j(236)     println(120);
1015 acc8= constant 120
1016 call writeLineAcc8
1017 ;test2.j(237)     println(121);
1018 acc8= constant 121
1019 call writeLineAcc8
1020 ;test2.j(238)     // acc - stack16
1021 ;test2.j(239)     // byte - integer
1022 ;test2.j(240)     println(122);
1023 acc8= constant 122
1024 call writeLineAcc8
1025 ;test2.j(241)     println(123);
1026 acc8= constant 123
1027 call writeLineAcc8
1028 ;test2.j(242)     // acc - stack16
1029 ;test2.j(243)     // integer - byte
1030 ;test2.j(244)     println(124);
1031 acc8= constant 124
1032 call writeLineAcc8
1033 ;test2.j(245)     println(125);
1034 acc8= constant 125
1035 call writeLineAcc8
1036 ;test2.j(246)     // acc - stack16
1037 ;test2.j(247)     // integer - integer
1038 ;test2.j(248)     println(126);
1039 acc8= constant 126
1040 call writeLineAcc8
1041 ;test2.j(249)     println(127);
1042 acc8= constant 127
1043 call writeLineAcc8
1044 ;test2.j(250)     println(128);
1045 acc8= constant 128
1046 call writeLineAcc8
1047 ;test2.j(251)     println(129);
1048 acc8= constant 129
1049 call writeLineAcc8
1050 ;test2.j(252)   
1051 ;test2.j(253)     /************************/
1052 ;test2.j(254)     // var - constant
1053 ;test2.j(255)     // byte - byte
1054 ;test2.j(256)     if (b > 10) println(130); else println(999);
1055 acc8= variable 6
1056 acc8Comp constant 10
1057 brle 1061
1058 acc8= constant 130
1059 call writeLineAcc8
1060 br 1064
1061 acc16= constant 999
1062 call writeLineAcc16
1063 ;test2.j(257)     if (b < 30) println(131); else println(999);
1064 acc8= variable 6
1065 acc8Comp constant 30
1066 brge 1070
1067 acc8= constant 131
1068 call writeLineAcc8
1069 br 1075
1070 acc16= constant 999
1071 call writeLineAcc16
1072 ;test2.j(258)     // var - constant
1073 ;test2.j(259)     // byte - integer
1074 ;test2.j(260)     if (b > 1000) println(999); else println(132);
1075 acc8= variable 6
1076 acc16= constant 1000
1077 acc8CompareAcc16
1078 brle 1082
1079 acc16= constant 999
1080 call writeLineAcc16
1081 br 1085
1082 acc8= constant 132
1083 call writeLineAcc8
1084 ;test2.j(261)     if (b < 1000) println(133); else println(999);
1085 acc8= variable 6
1086 acc16= constant 1000
1087 acc8CompareAcc16
1088 brge 1092
1089 acc8= constant 133
1090 call writeLineAcc8
1091 br 1097
1092 acc16= constant 999
1093 call writeLineAcc16
1094 ;test2.j(262)     // var - constant
1095 ;test2.j(263)     // integer - byte
1096 ;test2.j(264)     if (i > 1000) println(134); else println(999);
1097 acc16= variable 0
1098 acc16Comp constant 1000
1099 brle 1103
1100 acc8= constant 134
1101 call writeLineAcc8
1102 br 1106
1103 acc16= constant 999
1104 call writeLineAcc16
1105 ;test2.j(265)     if (i < 3000) println(135); else println(999);
1106 acc16= variable 0
1107 acc16Comp constant 3000
1108 brge 1112
1109 acc8= constant 135
1110 call writeLineAcc8
1111 br 1117
1112 acc16= constant 999
1113 call writeLineAcc16
1114 ;test2.j(266)     // var - constant
1115 ;test2.j(267)     // integer - integer
1116 ;test2.j(268)     if (i > 1000) println(136); else println(999);
1117 acc16= variable 0
1118 acc16Comp constant 1000
1119 brle 1123
1120 acc8= constant 136
1121 call writeLineAcc8
1122 br 1126
1123 acc16= constant 999
1124 call writeLineAcc16
1125 ;test2.j(269)     if (i < 3000) println(137); else println(999);
1126 acc16= variable 0
1127 acc16Comp constant 3000
1128 brge 1132
1129 acc8= constant 137
1130 call writeLineAcc8
1131 br 1135
1132 acc16= constant 999
1133 call writeLineAcc16
1134 ;test2.j(270)     println(138);
1135 acc8= constant 138
1136 call writeLineAcc8
1137 ;test2.j(271)     println(139);
1138 acc8= constant 139
1139 call writeLineAcc8
1140 ;test2.j(272)   
1141 ;test2.j(273)     /************************/
1142 ;test2.j(274)     // var - acc
1143 ;test2.j(275)     // byte - byte
1144 ;test2.j(276)     if (b > 10+0) println(140); else println(999);
1145 acc8= constant 10
1146 acc8+ constant 0
1147 acc8Comp variable 6
1148 brge 1152
1149 acc8= constant 140
1150 call writeLineAcc8
1151 br 1155
1152 acc16= constant 999
1153 call writeLineAcc16
1154 ;test2.j(277)     if (b < 30+0) println(141); else println(999);
1155 acc8= constant 30
1156 acc8+ constant 0
1157 acc8Comp variable 6
1158 brle 1162
1159 acc8= constant 141
1160 call writeLineAcc8
1161 br 1167
1162 acc16= constant 999
1163 call writeLineAcc16
1164 ;test2.j(278)     // var - acc
1165 ;test2.j(279)     // byte - integer
1166 ;test2.j(280)     if (b > 1000+0) println(999); else println(142);
1167 acc16= constant 1000
1168 acc16+ constant 0
1169 acc8= variable 6
1170 acc8CompareAcc16
1171 brle 1175
1172 acc16= constant 999
1173 call writeLineAcc16
1174 br 1178
1175 acc8= constant 142
1176 call writeLineAcc8
1177 ;test2.j(281)     if (b < 1000+0) println(143); else println(999);
1178 acc16= constant 1000
1179 acc16+ constant 0
1180 acc8= variable 6
1181 acc8CompareAcc16
1182 brge 1186
1183 acc8= constant 143
1184 call writeLineAcc8
1185 br 1191
1186 acc16= constant 999
1187 call writeLineAcc16
1188 ;test2.j(282)     // var - acc
1189 ;test2.j(283)     // integer - byte
1190 ;test2.j(284)     if (i > 1000+0) println(144); else println(999);
1191 acc16= constant 1000
1192 acc16+ constant 0
1193 acc16Comp variable 0
1194 brge 1198
1195 acc8= constant 144
1196 call writeLineAcc8
1197 br 1201
1198 acc16= constant 999
1199 call writeLineAcc16
1200 ;test2.j(285)     if (i < 3000+0) println(145); else println(999);
1201 acc16= constant 3000
1202 acc16+ constant 0
1203 acc16Comp variable 0
1204 brle 1208
1205 acc8= constant 145
1206 call writeLineAcc8
1207 br 1213
1208 acc16= constant 999
1209 call writeLineAcc16
1210 ;test2.j(286)     // var - acc
1211 ;test2.j(287)     // integer - integer
1212 ;test2.j(288)     if (i > 1000+0) println(146); else println(999);
1213 acc16= constant 1000
1214 acc16+ constant 0
1215 acc16Comp variable 0
1216 brge 1220
1217 acc8= constant 146
1218 call writeLineAcc8
1219 br 1223
1220 acc16= constant 999
1221 call writeLineAcc16
1222 ;test2.j(289)     if (i < 3000+0) println(147); else println(999);
1223 acc16= constant 3000
1224 acc16+ constant 0
1225 acc16Comp variable 0
1226 brle 1230
1227 acc8= constant 147
1228 call writeLineAcc8
1229 br 1233
1230 acc16= constant 999
1231 call writeLineAcc16
1232 ;test2.j(290)     println(148);
1233 acc8= constant 148
1234 call writeLineAcc8
1235 ;test2.j(291)     println(149);
1236 acc8= constant 149
1237 call writeLineAcc8
1238 ;test2.j(292)   
1239 ;test2.j(293)     /************************/
1240 ;test2.j(294)     // var - var
1241 ;test2.j(295)     // byte - byte
1242 ;test2.j(296)     if (b > b1) println(150);
1243 acc8= variable 6
1244 acc8Comp variable 7
1245 brle 1249
1246 acc8= constant 150
1247 call writeLineAcc8
1248 ;test2.j(297)     if (b < b3) println(151);
1249 acc8= variable 6
1250 acc8Comp variable 8
1251 brge 1257
1252 acc8= constant 151
1253 call writeLineAcc8
1254 ;test2.j(298)     // var - var
1255 ;test2.j(299)     // byte - integer
1256 ;test2.j(300)     if (b > i1) println(999); else println(152);
1257 acc8= variable 6
1258 acc16= variable 2
1259 acc8CompareAcc16
1260 brle 1264
1261 acc16= constant 999
1262 call writeLineAcc16
1263 br 1267
1264 acc8= constant 152
1265 call writeLineAcc8
1266 ;test2.j(301)     if (b < i3) println(153);
1267 acc8= variable 6
1268 acc16= variable 4
1269 acc8CompareAcc16
1270 brge 1276
1271 acc8= constant 153
1272 call writeLineAcc8
1273 ;test2.j(302)     // var - var
1274 ;test2.j(303)     // integer - byte
1275 ;test2.j(304)     if (i > i1) println(154);
1276 acc16= variable 0
1277 acc16Comp variable 2
1278 brle 1282
1279 acc8= constant 154
1280 call writeLineAcc8
1281 ;test2.j(305)     if (i < i3) println(155);
1282 acc16= variable 0
1283 acc16Comp variable 4
1284 brge 1290
1285 acc8= constant 155
1286 call writeLineAcc8
1287 ;test2.j(306)     // var - var
1288 ;test2.j(307)     // integer - integer
1289 ;test2.j(308)     if (i > i1) println(156);
1290 acc16= variable 0
1291 acc16Comp variable 2
1292 brle 1296
1293 acc8= constant 156
1294 call writeLineAcc8
1295 ;test2.j(309)     if (i < i3) println(157);
1296 acc16= variable 0
1297 acc16Comp variable 4
1298 brge 1302
1299 acc8= constant 157
1300 call writeLineAcc8
1301 ;test2.j(310)     println(158);
1302 acc8= constant 158
1303 call writeLineAcc8
1304 ;test2.j(311)     println(159);
1305 acc8= constant 159
1306 call writeLineAcc8
1307 ;test2.j(312)   
1308 ;test2.j(313)     /************************/
1309 ;test2.j(314)     // var - stack8
1310 ;test2.j(315)     // byte - byte
1311 ;test2.j(316)   
1312 ;test2.j(317)     // var - stack8
1313 ;test2.j(318)     // byte - integer
1314 ;test2.j(319)   
1315 ;test2.j(320)     // var - stack8
1316 ;test2.j(321)     // integer - byte 
1317 ;test2.j(322)   
1318 ;test2.j(323)     // var - stack8
1319 ;test2.j(324)     // integer - integer
1320 ;test2.j(325)   
1321 ;test2.j(326)     /************************/
1322 ;test2.j(327)     // var - stack16
1323 ;test2.j(328)     // byte - byte
1324 ;test2.j(329)   
1325 ;test2.j(330)     // var - stack16
1326 ;test2.j(331)     // byte - integer
1327 ;test2.j(332)   
1328 ;test2.j(333)     // var - stack16
1329 ;test2.j(334)     // integer - byte
1330 ;test2.j(335)   
1331 ;test2.j(336)     // var - stack16
1332 ;test2.j(337)     // integer - integer
1333 ;test2.j(338)   
1334 ;test2.j(339)     /************************/
1335 ;test2.j(340)     // stack8 - constant
1336 ;test2.j(341)     // stack8 - acc
1337 ;test2.j(342)     // stack8 - var
1338 ;test2.j(343)     // stack8 - stack8
1339 ;test2.j(344)     // stack8 - stack16
1340 ;test2.j(345)   
1341 ;test2.j(346)     /************************/
1342 ;test2.j(347)     // stack16 - constant
1343 ;test2.j(348)     // stack16 - acc
1344 ;test2.j(349)     // stack16 - var
1345 ;test2.j(350)     // stack16 - stack8
1346 ;test2.j(351)     // stack16 - stack16
1347 ;test2.j(352)   
1348 ;test2.j(353)     println("Klaar");
1349 acc16= constant 1354
1350 writeLineString
1351 ;test2.j(354)   }
1352 ;test2.j(355) }
1353 stop
1354 stringConstant 0 = "Klaar"
