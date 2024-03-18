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
  25 method main [public, static] void ()
  26 <basePointer
  27 basePointer= stackPointer
  28 stackPointer+ constant 0
  29 ;test2.j(10)     /*Possible operand types: 
  30 ;test2.j(11)      * constant, acc, var, stack8, stack16
  31 ;test2.j(12)      *Possible datatype combinations:
  32 ;test2.j(13)      * byte - byte
  33 ;test2.j(14)      * byte - integer
  34 ;test2.j(15)      * integer - byte
  35 ;test2.j(16)      * integer - integer
  36 ;test2.j(17)     */
  37 ;test2.j(18)   
  38 ;test2.j(19)     println(0);
  39 acc8= constant 0
  40 writeLineAcc8
  41 ;test2.j(20)   
  42 ;test2.j(21)     /************************/
  43 ;test2.j(22)     // constant - constant
  44 ;test2.j(23)     // byte - byte
  45 ;test2.j(24)     if (1 == 1) println(1); else println(999);
  46 acc8= constant 1
  47 acc8Comp constant 1
  48 brne 52
  49 acc8= constant 1
  50 writeLineAcc8
  51 br 55
  52 acc16= constant 999
  53 writeLineAcc16
  54 ;test2.j(25)     if (1 != 0) println(2); else println(999);
  55 acc8= constant 1
  56 acc8Comp constant 0
  57 breq 61
  58 acc8= constant 2
  59 writeLineAcc8
  60 br 64
  61 acc16= constant 999
  62 writeLineAcc16
  63 ;test2.j(26)     if (1 >  0) println(3); else println(999);
  64 acc8= constant 1
  65 acc8Comp constant 0
  66 brle 70
  67 acc8= constant 3
  68 writeLineAcc8
  69 br 73
  70 acc16= constant 999
  71 writeLineAcc16
  72 ;test2.j(27)     if (1 >= 0) println(4); else println(999);
  73 acc8= constant 1
  74 acc8Comp constant 0
  75 brlt 79
  76 acc8= constant 4
  77 writeLineAcc8
  78 br 82
  79 acc16= constant 999
  80 writeLineAcc16
  81 ;test2.j(28)     if (1 >= 1) println(5); else println(999);
  82 acc8= constant 1
  83 acc8Comp constant 1
  84 brlt 88
  85 acc8= constant 5
  86 writeLineAcc8
  87 br 91
  88 acc16= constant 999
  89 writeLineAcc16
  90 ;test2.j(29)     if (1 <  2) println(6); else println(999);
  91 acc8= constant 1
  92 acc8Comp constant 2
  93 brge 97
  94 acc8= constant 6
  95 writeLineAcc8
  96 br 100
  97 acc16= constant 999
  98 writeLineAcc16
  99 ;test2.j(30)     if (1 <= 2) println(7); else println(999);
 100 acc8= constant 1
 101 acc8Comp constant 2
 102 brgt 106
 103 acc8= constant 7
 104 writeLineAcc8
 105 br 109
 106 acc16= constant 999
 107 writeLineAcc16
 108 ;test2.j(31)     if (1 <= 1) println(8); else println(999);
 109 acc8= constant 1
 110 acc8Comp constant 1
 111 brgt 115
 112 acc8= constant 8
 113 writeLineAcc8
 114 br 118
 115 acc16= constant 999
 116 writeLineAcc16
 117 ;test2.j(32)     println(9);
 118 acc8= constant 9
 119 writeLineAcc8
 120 ;test2.j(33)   
 121 ;test2.j(34)     // constant - constant
 122 ;test2.j(35)     // byte - integer
 123 ;test2.j(36)     if (1 == 1000) println(999); else println(10);
 124 acc8= constant 1
 125 acc16= constant 1000
 126 acc8CompareAcc16
 127 brne 131
 128 acc16= constant 999
 129 writeLineAcc16
 130 br 134
 131 acc8= constant 10
 132 writeLineAcc8
 133 ;test2.j(37)     if (1 != 1000) println(11);  else println(999);
 134 acc8= constant 1
 135 acc16= constant 1000
 136 acc8CompareAcc16
 137 breq 141
 138 acc8= constant 11
 139 writeLineAcc8
 140 br 144
 141 acc16= constant 999
 142 writeLineAcc16
 143 ;test2.j(38)     if (1 >  1000) println(999); else println(12);
 144 acc8= constant 1
 145 acc16= constant 1000
 146 acc8CompareAcc16
 147 brle 151
 148 acc16= constant 999
 149 writeLineAcc16
 150 br 154
 151 acc8= constant 12
 152 writeLineAcc8
 153 ;test2.j(39)     if (1 >= 1000) println(999); else println(13);
 154 acc8= constant 1
 155 acc16= constant 1000
 156 acc8CompareAcc16
 157 brlt 161
 158 acc16= constant 999
 159 writeLineAcc16
 160 br 164
 161 acc8= constant 13
 162 writeLineAcc8
 163 ;test2.j(40)     if (1 >= 1000) println(999); else println(14);
 164 acc8= constant 1
 165 acc16= constant 1000
 166 acc8CompareAcc16
 167 brlt 171
 168 acc16= constant 999
 169 writeLineAcc16
 170 br 174
 171 acc8= constant 14
 172 writeLineAcc8
 173 ;test2.j(41)     if (1 <  2000) println(15);  else println(999);
 174 acc8= constant 1
 175 acc16= constant 2000
 176 acc8CompareAcc16
 177 brge 181
 178 acc8= constant 15
 179 writeLineAcc8
 180 br 184
 181 acc16= constant 999
 182 writeLineAcc16
 183 ;test2.j(42)     if (1 <= 2000) println(16);  else println(999);
 184 acc8= constant 1
 185 acc16= constant 2000
 186 acc8CompareAcc16
 187 brgt 191
 188 acc8= constant 16
 189 writeLineAcc8
 190 br 194
 191 acc16= constant 999
 192 writeLineAcc16
 193 ;test2.j(43)     if (1 <= 1000) println(17);  else println(999);
 194 acc8= constant 1
 195 acc16= constant 1000
 196 acc8CompareAcc16
 197 brgt 201
 198 acc8= constant 17
 199 writeLineAcc8
 200 br 204
 201 acc16= constant 999
 202 writeLineAcc16
 203 ;test2.j(44)     println(18);
 204 acc8= constant 18
 205 writeLineAcc8
 206 ;test2.j(45)     println(19);
 207 acc8= constant 19
 208 writeLineAcc8
 209 ;test2.j(46)   
 210 ;test2.j(47)     // constant - constant
 211 ;test2.j(48)     // integer - byte
 212 ;test2.j(49)     if (1000 == 1) println(999); else println(20);
 213 acc16= constant 1000
 214 acc8= constant 1
 215 acc16CompareAcc8
 216 brne 220
 217 acc16= constant 999
 218 writeLineAcc16
 219 br 223
 220 acc8= constant 20
 221 writeLineAcc8
 222 ;test2.j(50)     if (1000 != 0) println(21);  else println(999);
 223 acc16= constant 1000
 224 acc8= constant 0
 225 acc16CompareAcc8
 226 breq 230
 227 acc8= constant 21
 228 writeLineAcc8
 229 br 233
 230 acc16= constant 999
 231 writeLineAcc16
 232 ;test2.j(51)     if (1000 >  0) println(22);  else println(999);
 233 acc16= constant 1000
 234 acc8= constant 0
 235 acc16CompareAcc8
 236 brle 240
 237 acc8= constant 22
 238 writeLineAcc8
 239 br 243
 240 acc16= constant 999
 241 writeLineAcc16
 242 ;test2.j(52)     if (1000 >= 0) println(23);  else println(999);
 243 acc16= constant 1000
 244 acc8= constant 0
 245 acc16CompareAcc8
 246 brlt 250
 247 acc8= constant 23
 248 writeLineAcc8
 249 br 253
 250 acc16= constant 999
 251 writeLineAcc16
 252 ;test2.j(53)     if (1000 >= 1) println(24);  else println(999);
 253 acc16= constant 1000
 254 acc8= constant 1
 255 acc16CompareAcc8
 256 brlt 260
 257 acc8= constant 24
 258 writeLineAcc8
 259 br 263
 260 acc16= constant 999
 261 writeLineAcc16
 262 ;test2.j(54)     if (1 <  2000) println(25);  else println(999);
 263 acc8= constant 1
 264 acc16= constant 2000
 265 acc8CompareAcc16
 266 brge 270
 267 acc8= constant 25
 268 writeLineAcc8
 269 br 273
 270 acc16= constant 999
 271 writeLineAcc16
 272 ;test2.j(55)     if (1 <= 2000) println(26);  else println(999);
 273 acc8= constant 1
 274 acc16= constant 2000
 275 acc8CompareAcc16
 276 brgt 280
 277 acc8= constant 26
 278 writeLineAcc8
 279 br 283
 280 acc16= constant 999
 281 writeLineAcc16
 282 ;test2.j(56)     if (1 <= 1000) println(27);  else println(999);
 283 acc8= constant 1
 284 acc16= constant 1000
 285 acc8CompareAcc16
 286 brgt 290
 287 acc8= constant 27
 288 writeLineAcc8
 289 br 293
 290 acc16= constant 999
 291 writeLineAcc16
 292 ;test2.j(57)     println(28);
 293 acc8= constant 28
 294 writeLineAcc8
 295 ;test2.j(58)     println(29);
 296 acc8= constant 29
 297 writeLineAcc8
 298 ;test2.j(59)   
 299 ;test2.j(60)     // constant - constant
 300 ;test2.j(61)     // integer - integer
 301 ;test2.j(62)     if (1000 == 1000) println(30); else println(999);
 302 acc16= constant 1000
 303 acc16Comp constant 1000
 304 brne 308
 305 acc8= constant 30
 306 writeLineAcc8
 307 br 311
 308 acc16= constant 999
 309 writeLineAcc16
 310 ;test2.j(63)     if (1000 != 2000) println(31); else println(999);
 311 acc16= constant 1000
 312 acc16Comp constant 2000
 313 breq 317
 314 acc8= constant 31
 315 writeLineAcc8
 316 br 320
 317 acc16= constant 999
 318 writeLineAcc16
 319 ;test2.j(64)     if (2000 >  1000) println(32); else println(999);
 320 acc16= constant 2000
 321 acc16Comp constant 1000
 322 brle 326
 323 acc8= constant 32
 324 writeLineAcc8
 325 br 329
 326 acc16= constant 999
 327 writeLineAcc16
 328 ;test2.j(65)     if (2000 >= 1000) println(33); else println(999);
 329 acc16= constant 2000
 330 acc16Comp constant 1000
 331 brlt 335
 332 acc8= constant 33
 333 writeLineAcc8
 334 br 338
 335 acc16= constant 999
 336 writeLineAcc16
 337 ;test2.j(66)     if (1000 >= 1000) println(34); else println(999);
 338 acc16= constant 1000
 339 acc16Comp constant 1000
 340 brlt 344
 341 acc8= constant 34
 342 writeLineAcc8
 343 br 347
 344 acc16= constant 999
 345 writeLineAcc16
 346 ;test2.j(67)     if (1000 <  2000) println(35); else println(999);
 347 acc16= constant 1000
 348 acc16Comp constant 2000
 349 brge 353
 350 acc8= constant 35
 351 writeLineAcc8
 352 br 356
 353 acc16= constant 999
 354 writeLineAcc16
 355 ;test2.j(68)     if (1000 <= 2000) println(36); else println(999);
 356 acc16= constant 1000
 357 acc16Comp constant 2000
 358 brgt 362
 359 acc8= constant 36
 360 writeLineAcc8
 361 br 365
 362 acc16= constant 999
 363 writeLineAcc16
 364 ;test2.j(69)     if (1000 <= 1000) println(37); else println(999);
 365 acc16= constant 1000
 366 acc16Comp constant 1000
 367 brgt 371
 368 acc8= constant 37
 369 writeLineAcc8
 370 br 374
 371 acc16= constant 999
 372 writeLineAcc16
 373 ;test2.j(70)     println(38);
 374 acc8= constant 38
 375 writeLineAcc8
 376 ;test2.j(71)     println(39);
 377 acc8= constant 39
 378 writeLineAcc8
 379 ;test2.j(72)   
 380 ;test2.j(73)     /************************/
 381 ;test2.j(74)     // constant - acc
 382 ;test2.j(75)     // byte - byte
 383 ;test2.j(76)     if (1 > 0+0) println(40); else println(999);
 384 acc8= constant 0
 385 acc8+ constant 0
 386 acc8Comp constant 1
 387 brge 391
 388 acc8= constant 40
 389 writeLineAcc8
 390 br 394
 391 acc16= constant 999
 392 writeLineAcc16
 393 ;test2.j(77)     if (1 < 2+0) println(41); else println(999);
 394 acc8= constant 2
 395 acc8+ constant 0
 396 acc8Comp constant 1
 397 brle 401
 398 acc8= constant 41
 399 writeLineAcc8
 400 br 406
 401 acc16= constant 999
 402 writeLineAcc16
 403 ;test2.j(78)     // constant - acc
 404 ;test2.j(79)     // byte - integer
 405 ;test2.j(80)     if (1 > 1000+0) println(999); else println(42);
 406 acc16= constant 1000
 407 acc16+ constant 0
 408 acc8= constant 1
 409 acc8CompareAcc16
 410 brle 414
 411 acc16= constant 999
 412 writeLineAcc16
 413 br 417
 414 acc8= constant 42
 415 writeLineAcc8
 416 ;test2.j(81)     if (1 < 1000+0) println(43);  else println(999);
 417 acc16= constant 1000
 418 acc16+ constant 0
 419 acc8= constant 1
 420 acc8CompareAcc16
 421 brge 425
 422 acc8= constant 43
 423 writeLineAcc8
 424 br 430
 425 acc16= constant 999
 426 writeLineAcc16
 427 ;test2.j(82)     // constant - acc
 428 ;test2.j(83)     // integer - byte
 429 ;test2.j(84)     if (1000 > 0+0) println(44);  else println(999);
 430 acc8= constant 0
 431 acc8+ constant 0
 432 acc16= constant 1000
 433 acc16CompareAcc8
 434 brle 438
 435 acc8= constant 44
 436 writeLineAcc8
 437 br 441
 438 acc16= constant 999
 439 writeLineAcc16
 440 ;test2.j(85)     if (1000 < 0+0) println(999); else println(45);
 441 acc8= constant 0
 442 acc8+ constant 0
 443 acc16= constant 1000
 444 acc16CompareAcc8
 445 brge 449
 446 acc16= constant 999
 447 writeLineAcc16
 448 br 454
 449 acc8= constant 45
 450 writeLineAcc8
 451 ;test2.j(86)     // constant - acc
 452 ;test2.j(87)     // integer - integer
 453 ;test2.j(88)     if (2000 > 1000+0) println(46); else println(999);
 454 acc16= constant 1000
 455 acc16+ constant 0
 456 acc16Comp constant 2000
 457 brge 461
 458 acc8= constant 46
 459 writeLineAcc8
 460 br 464
 461 acc16= constant 999
 462 writeLineAcc16
 463 ;test2.j(89)     if (1000 < 2000+0) println(47); else println(999);
 464 acc16= constant 2000
 465 acc16+ constant 0
 466 acc16Comp constant 1000
 467 brle 471
 468 acc8= constant 47
 469 writeLineAcc8
 470 br 474
 471 acc16= constant 999
 472 writeLineAcc16
 473 ;test2.j(90)     println(48);
 474 acc8= constant 48
 475 writeLineAcc8
 476 ;test2.j(91)     println(49);
 477 acc8= constant 49
 478 writeLineAcc8
 479 ;test2.j(92)   
 480 ;test2.j(93)     /************************/
 481 ;test2.j(94)     // constant - var
 482 ;test2.j(95)     // byte - byte
 483 ;test2.j(96)     if (30 > b) println(50); else println(999);
 484 acc8= variable 6
 485 acc8Comp constant 30
 486 brge 490
 487 acc8= constant 50
 488 writeLineAcc8
 489 br 493
 490 acc16= constant 999
 491 writeLineAcc16
 492 ;test2.j(97)     if (10 < b) println(51); else println(999);
 493 acc8= variable 6
 494 acc8Comp constant 10
 495 brle 499
 496 acc8= constant 51
 497 writeLineAcc8
 498 br 504
 499 acc16= constant 999
 500 writeLineAcc16
 501 ;test2.j(98)     // constant - var
 502 ;test2.j(99)     // byte - integer
 503 ;test2.j(100)     if (30 > i) println(999); else println(52);
 504 acc16= variable 0
 505 acc8= constant 30
 506 acc8CompareAcc16
 507 brle 511
 508 acc16= constant 999
 509 writeLineAcc16
 510 br 514
 511 acc8= constant 52
 512 writeLineAcc8
 513 ;test2.j(101)     if (10 < i) println(53); else println(999);
 514 acc16= variable 0
 515 acc8= constant 10
 516 acc8CompareAcc16
 517 brge 521
 518 acc8= constant 53
 519 writeLineAcc8
 520 br 526
 521 acc16= constant 999
 522 writeLineAcc16
 523 ;test2.j(102)     // constant - var
 524 ;test2.j(103)     // integer - byte
 525 ;test2.j(104)     if (3000 > b) println(54); else println(999);
 526 acc8= variable 6
 527 acc16= constant 3000
 528 acc16CompareAcc8
 529 brle 533
 530 acc8= constant 54
 531 writeLineAcc8
 532 br 536
 533 acc16= constant 999
 534 writeLineAcc16
 535 ;test2.j(105)     if (1000 < b) println(999); else println(55);
 536 acc8= variable 6
 537 acc16= constant 1000
 538 acc16CompareAcc8
 539 brge 543
 540 acc16= constant 999
 541 writeLineAcc16
 542 br 548
 543 acc8= constant 55
 544 writeLineAcc8
 545 ;test2.j(106)     // constant - var
 546 ;test2.j(107)     // integer - integer
 547 ;test2.j(108)     if (3000 > i) println(56); else println(999);
 548 acc16= variable 0
 549 acc16Comp constant 3000
 550 brge 554
 551 acc8= constant 56
 552 writeLineAcc8
 553 br 557
 554 acc16= constant 999
 555 writeLineAcc16
 556 ;test2.j(109)     if (1000 < i) println(57); else println(999);
 557 acc16= variable 0
 558 acc16Comp constant 1000
 559 brle 563
 560 acc8= constant 57
 561 writeLineAcc8
 562 br 566
 563 acc16= constant 999
 564 writeLineAcc16
 565 ;test2.j(110)     println(58);
 566 acc8= constant 58
 567 writeLineAcc8
 568 ;test2.j(111)     println(59);
 569 acc8= constant 59
 570 writeLineAcc8
 571 ;test2.j(112)   
 572 ;test2.j(113)     /************************/
 573 ;test2.j(114)     // constant - stack8
 574 ;test2.j(115)     // byte - byte
 575 ;test2.j(116)     println(60);
 576 acc8= constant 60
 577 writeLineAcc8
 578 ;test2.j(117)     println(61);
 579 acc8= constant 61
 580 writeLineAcc8
 581 ;test2.j(118)     // constant - stack8
 582 ;test2.j(119)     // byte - integer
 583 ;test2.j(120)     println(62);
 584 acc8= constant 62
 585 writeLineAcc8
 586 ;test2.j(121)     println(63);
 587 acc8= constant 63
 588 writeLineAcc8
 589 ;test2.j(122)     // constant - stack8
 590 ;test2.j(123)     // integer - byte
 591 ;test2.j(124)     println(64);
 592 acc8= constant 64
 593 writeLineAcc8
 594 ;test2.j(125)     println(65);
 595 acc8= constant 65
 596 writeLineAcc8
 597 ;test2.j(126)     // constant - stack8
 598 ;test2.j(127)     // integer - integer
 599 ;test2.j(128)     println(66);
 600 acc8= constant 66
 601 writeLineAcc8
 602 ;test2.j(129)     println(67);
 603 acc8= constant 67
 604 writeLineAcc8
 605 ;test2.j(130)     println(68);
 606 acc8= constant 68
 607 writeLineAcc8
 608 ;test2.j(131)     println(69);
 609 acc8= constant 69
 610 writeLineAcc8
 611 ;test2.j(132)   
 612 ;test2.j(133)     /************************/
 613 ;test2.j(134)     // constant - stack16
 614 ;test2.j(135)     // byte - byte
 615 ;test2.j(136)     println(70);
 616 acc8= constant 70
 617 writeLineAcc8
 618 ;test2.j(137)     println(71);
 619 acc8= constant 71
 620 writeLineAcc8
 621 ;test2.j(138)     // constant - stack16
 622 ;test2.j(139)     // byte - integer
 623 ;test2.j(140)     println(72);
 624 acc8= constant 72
 625 writeLineAcc8
 626 ;test2.j(141)     println(73);
 627 acc8= constant 73
 628 writeLineAcc8
 629 ;test2.j(142)     // constant - stack16
 630 ;test2.j(143)     // integer - byte
 631 ;test2.j(144)     println(74);
 632 acc8= constant 74
 633 writeLineAcc8
 634 ;test2.j(145)     println(75);
 635 acc8= constant 75
 636 writeLineAcc8
 637 ;test2.j(146)     // constant - stack16
 638 ;test2.j(147)     // integer - integer
 639 ;test2.j(148)     println(76);
 640 acc8= constant 76
 641 writeLineAcc8
 642 ;test2.j(149)     println(77);
 643 acc8= constant 77
 644 writeLineAcc8
 645 ;test2.j(150)     println(78);
 646 acc8= constant 78
 647 writeLineAcc8
 648 ;test2.j(151)     println(79);
 649 acc8= constant 79
 650 writeLineAcc8
 651 ;test2.j(152)   
 652 ;test2.j(153)     /************************/
 653 ;test2.j(154)     // acc - constant
 654 ;test2.j(155)     // byte - byte
 655 ;test2.j(156)     if (30+0 > 20) println(80); else println(999);
 656 acc8= constant 30
 657 acc8+ constant 0
 658 acc8Comp constant 20
 659 brle 665
 660 acc8= constant 80
 661 writeLineAcc8
 662 br 668
 663 acc16= constant 999
 664 writeLineAcc16
 665 ;test2.j(157)     if (10+0 < 20) println(81); else println(999);
 666 acc8= constant 10
 667 acc8+ constant 0
 668 acc8Comp constant 20
 669 brge 677
 670 acc8= constant 81
 671 writeLineAcc8
 672 br 682
 673 acc16= constant 999
 674 writeLineAcc16
 675 ;test2.j(158)     // acc - constant
 676 ;test2.j(159)     // byte - integer
 677 ;test2.j(160)     if (30+0 > 2000) println(999); else println(82);
 678 acc8= constant 30
 679 acc8+ constant 0
 680 acc16= constant 2000
 681 acc8CompareAcc16
 682 brle 692
 683 acc16= constant 999
 684 writeLineAcc16
 685 br 695
 686 acc8= constant 82
 687 writeLineAcc8
 688 ;test2.j(161)     if (10+0 < 2000) println(83); else println(999);
 689 acc8= constant 10
 690 acc8+ constant 0
 691 acc16= constant 2000
 692 acc8CompareAcc16
 693 brge 705
 694 acc8= constant 83
 695 writeLineAcc8
 696 br 710
 697 acc16= constant 999
 698 writeLineAcc16
 699 ;test2.j(162)     // acc - constant
 700 ;test2.j(163)     // integer - byte
 701 ;test2.j(164)     if (3000+0 > 20) println(84); else println(999);
 702 acc16= constant 3000
 703 acc16+ constant 0
 704 acc8= constant 20
 705 acc16CompareAcc8
 706 brle 720
 707 acc8= constant 84
 708 writeLineAcc8
 709 br 723
 710 acc16= constant 999
 711 writeLineAcc16
 712 ;test2.j(165)     if (1000+0 < 20) println(999); else println(85);
 713 acc16= constant 1000
 714 acc16+ constant 0
 715 acc8= constant 20
 716 acc16CompareAcc8
 717 brge 733
 718 acc16= constant 999
 719 writeLineAcc16
 720 br 738
 721 acc8= constant 85
 722 writeLineAcc8
 723 ;test2.j(166)     // acc - constant
 724 ;test2.j(167)     // integer - integer
 725 ;test2.j(168)     if (3000+0 > 2000) println(86); else println(999);
 726 acc16= constant 3000
 727 acc16+ constant 0
 728 acc16Comp constant 2000
 729 brle 747
 730 acc8= constant 86
 731 writeLineAcc8
 732 br 750
 733 acc16= constant 999
 734 writeLineAcc16
 735 ;test2.j(169)     if (1000+0 < 2000) println(87); else println(999);
 736 acc16= constant 1000
 737 acc16+ constant 0
 738 acc16Comp constant 2000
 739 brge 759
 740 acc8= constant 87
 741 writeLineAcc8
 742 br 762
 743 acc16= constant 999
 744 writeLineAcc16
 745 ;test2.j(170)     println(88);
 746 acc8= constant 88
 747 writeLineAcc8
 748 ;test2.j(171)     println(89);
 749 acc8= constant 89
 750 writeLineAcc8
 751 ;test2.j(172)   
 752 ;test2.j(173)     /************************/
 753 ;test2.j(174)     // acc - acc
 754 ;test2.j(175)     // byte - byte
 755 ;test2.j(176)     if (30+0 > 20+0) println(90); else println(999);
 756 acc8= constant 30
 757 acc8+ constant 0
 758 <acc8
 759 acc8= constant 20
 760 acc8+ constant 0
 761 revAcc8Comp unstack8
 762 brge 782
 763 acc8= constant 90
 764 writeLineAcc8
 765 br 785
 766 acc16= constant 999
 767 writeLineAcc16
 768 ;test2.j(177)     if (10+0 < 20+0) println(91); else println(999);
 769 acc8= constant 10
 770 acc8+ constant 0
 771 <acc8
 772 acc8= constant 20
 773 acc8+ constant 0
 774 revAcc8Comp unstack8
 775 brle 795
 776 acc8= constant 91
 777 writeLineAcc8
 778 br 800
 779 acc16= constant 999
 780 writeLineAcc16
 781 ;test2.j(178)     // acc - acc
 782 ;test2.j(179)     // byte - integer
 783 ;test2.j(180)     if (30+0 > 2000+0) println(999); else println(92);
 784 acc8= constant 30
 785 acc8+ constant 0
 786 <acc8
 787 acc16= constant 2000
 788 acc16+ constant 0
 789 acc8<
 790 acc8CompareAcc16
 791 brle 811
 792 acc16= constant 999
 793 writeLineAcc16
 794 br 814
 795 acc8= constant 92
 796 writeLineAcc8
 797 ;test2.j(181)     if (10+0 < 2000+0) println(93); else println(999);
 798 acc8= constant 10
 799 acc8+ constant 0
 800 <acc8
 801 acc16= constant 2000
 802 acc16+ constant 0
 803 acc8<
 804 acc8CompareAcc16
 805 brge 825
 806 acc8= constant 93
 807 writeLineAcc8
 808 br 830
 809 acc16= constant 999
 810 writeLineAcc16
 811 ;test2.j(182)     // acc - acc
 812 ;test2.j(183)     // integer - byte
 813 ;test2.j(184)     if (3000+0 > 20+0) println(94); else println(999);
 814 acc16= constant 3000
 815 acc16+ constant 0
 816 <acc16
 817 acc8= constant 20
 818 acc8+ constant 0
 819 acc16<
 820 acc16CompareAcc8
 821 brle 841
 822 acc8= constant 94
 823 writeLineAcc8
 824 br 844
 825 acc16= constant 999
 826 writeLineAcc16
 827 ;test2.j(185)     if (1000+0 < 20+0) println(999); else println(95);
 828 acc16= constant 1000
 829 acc16+ constant 0
 830 <acc16
 831 acc8= constant 20
 832 acc8+ constant 0
 833 acc16<
 834 acc16CompareAcc8
 835 brge 855
 836 acc16= constant 999
 837 writeLineAcc16
 838 br 860
 839 acc8= constant 95
 840 writeLineAcc8
 841 ;test2.j(186)     // acc - acc
 842 ;test2.j(187)     // integer - integer
 843 ;test2.j(188)     if (3000+0 > 2000+0) println(96); else println(999);
 844 acc16= constant 3000
 845 acc16+ constant 0
 846 <acc16
 847 acc16= constant 2000
 848 acc16+ constant 0
 849 revAcc16Comp unstack16
 850 brge 870
 851 acc8= constant 96
 852 writeLineAcc8
 853 br 873
 854 acc16= constant 999
 855 writeLineAcc16
 856 ;test2.j(189)     if (1000+0 < 2000+0) println(97); else println(999);
 857 acc16= constant 1000
 858 acc16+ constant 0
 859 <acc16
 860 acc16= constant 2000
 861 acc16+ constant 0
 862 revAcc16Comp unstack16
 863 brle 883
 864 acc8= constant 97
 865 writeLineAcc8
 866 br 886
 867 acc16= constant 999
 868 writeLineAcc16
 869 ;test2.j(190)     println(98);
 870 acc8= constant 98
 871 writeLineAcc8
 872 ;test2.j(191)     println(99);
 873 acc8= constant 99
 874 writeLineAcc8
 875 ;test2.j(192)   
 876 ;test2.j(193)     /************************/
 877 ;test2.j(194)     // acc - var
 878 ;test2.j(195)     // byte - byte
 879 ;test2.j(196)     if (30+0 > b) println(100); else println(999);
 880 acc8= constant 30
 881 acc8+ constant 0
 882 acc8Comp variable 6
 883 brle 905
 884 acc8= constant 100
 885 writeLineAcc8
 886 br 908
 887 acc16= constant 999
 888 writeLineAcc16
 889 ;test2.j(197)     if (10+0 < b) println(101); else println(999);
 890 acc8= constant 10
 891 acc8+ constant 0
 892 acc8Comp variable 6
 893 brge 917
 894 acc8= constant 101
 895 writeLineAcc8
 896 br 922
 897 acc16= constant 999
 898 writeLineAcc16
 899 ;test2.j(198)     // acc - var
 900 ;test2.j(199)     // byte - integer
 901 ;test2.j(200)     if (30+0 > i) println(999); else println(102);
 902 acc8= constant 30
 903 acc8+ constant 0
 904 acc16= variable 0
 905 acc8CompareAcc16
 906 brle 932
 907 acc16= constant 999
 908 writeLineAcc16
 909 br 935
 910 acc8= constant 102
 911 writeLineAcc8
 912 ;test2.j(201)     if (10+0 < i) println(103); else println(999);
 913 acc8= constant 10
 914 acc8+ constant 0
 915 acc16= variable 0
 916 acc8CompareAcc16
 917 brge 945
 918 acc8= constant 103
 919 writeLineAcc8
 920 br 950
 921 acc16= constant 999
 922 writeLineAcc16
 923 ;test2.j(202)     // acc - var
 924 ;test2.j(203)     // integer - byte
 925 ;test2.j(204)     if (3000+0 > b) println(104); else println(999);
 926 acc16= constant 3000
 927 acc16+ constant 0
 928 acc8= variable 6
 929 acc16CompareAcc8
 930 brle 960
 931 acc8= constant 104
 932 writeLineAcc8
 933 br 963
 934 acc16= constant 999
 935 writeLineAcc16
 936 ;test2.j(205)     if (1000+0 < b) println(999); else println(105);
 937 acc16= constant 1000
 938 acc16+ constant 0
 939 acc8= variable 6
 940 acc16CompareAcc8
 941 brge 973
 942 acc16= constant 999
 943 writeLineAcc16
 944 br 978
 945 acc8= constant 105
 946 writeLineAcc8
 947 ;test2.j(206)     // acc - var
 948 ;test2.j(207)     // integer - integer
 949 ;test2.j(208)     if (3000+0 > i) println(106); else println(999);
 950 acc16= constant 3000
 951 acc16+ constant 0
 952 acc16Comp variable 0
 953 brle 987
 954 acc8= constant 106
 955 writeLineAcc8
 956 br 990
 957 acc16= constant 999
 958 writeLineAcc16
 959 ;test2.j(209)     if (1000+0 < i) println(107); else println(999);
 960 acc16= constant 1000
 961 acc16+ constant 0
 962 acc16Comp variable 0
 963 brge 999
 964 acc8= constant 107
 965 writeLineAcc8
 966 br 1002
 967 acc16= constant 999
 968 writeLineAcc16
 969 ;test2.j(210)     println(108);
 970 acc8= constant 108
 971 writeLineAcc8
 972 ;test2.j(211)     println(109);
 973 acc8= constant 109
 974 writeLineAcc8
 975 ;test2.j(212)   
 976 ;test2.j(213)     /************************/
 977 ;test2.j(214)     // acc - stack8
 978 ;test2.j(215)     // byte - byte
 979 ;test2.j(216)     println(110);
 980 acc8= constant 110
 981 writeLineAcc8
 982 ;test2.j(217)     println(111);
 983 acc8= constant 111
 984 writeLineAcc8
 985 ;test2.j(218)     // acc - stack8
 986 ;test2.j(219)     // byte - integer
 987 ;test2.j(220)     println(112);
 988 acc8= constant 112
 989 writeLineAcc8
 990 ;test2.j(221)     println(113);
 991 acc8= constant 113
 992 writeLineAcc8
 993 ;test2.j(222)     // acc - stack8
 994 ;test2.j(223)     // integer - byte
 995 ;test2.j(224)     println(114);
 996 acc8= constant 114
 997 writeLineAcc8
 998 ;test2.j(225)     println(115);
 999 acc8= constant 115
1000 writeLineAcc8
1001 ;test2.j(226)     // acc - stack8
1002 ;test2.j(227)     // integer - integer
1003 ;test2.j(228)     println(116);
1004 acc8= constant 116
1005 writeLineAcc8
1006 ;test2.j(229)     println(117);
1007 acc8= constant 117
1008 writeLineAcc8
1009 ;test2.j(230)     println(118);
1010 acc8= constant 118
1011 writeLineAcc8
1012 ;test2.j(231)     println(119);
1013 acc8= constant 119
1014 writeLineAcc8
1015 ;test2.j(232)   
1016 ;test2.j(233)     /************************/
1017 ;test2.j(234)     // acc - stack16
1018 ;test2.j(235)     // byte - byte
1019 ;test2.j(236)     println(120);
1020 acc8= constant 120
1021 writeLineAcc8
1022 ;test2.j(237)     println(121);
1023 acc8= constant 121
1024 writeLineAcc8
1025 ;test2.j(238)     // acc - stack16
1026 ;test2.j(239)     // byte - integer
1027 ;test2.j(240)     println(122);
1028 acc8= constant 122
1029 writeLineAcc8
1030 ;test2.j(241)     println(123);
1031 acc8= constant 123
1032 writeLineAcc8
1033 ;test2.j(242)     // acc - stack16
1034 ;test2.j(243)     // integer - byte
1035 ;test2.j(244)     println(124);
1036 acc8= constant 124
1037 writeLineAcc8
1038 ;test2.j(245)     println(125);
1039 acc8= constant 125
1040 writeLineAcc8
1041 ;test2.j(246)     // acc - stack16
1042 ;test2.j(247)     // integer - integer
1043 ;test2.j(248)     println(126);
1044 acc8= constant 126
1045 writeLineAcc8
1046 ;test2.j(249)     println(127);
1047 acc8= constant 127
1048 writeLineAcc8
1049 ;test2.j(250)     println(128);
1050 acc8= constant 128
1051 writeLineAcc8
1052 ;test2.j(251)     println(129);
1053 acc8= constant 129
1054 writeLineAcc8
1055 ;test2.j(252)   
1056 ;test2.j(253)     /************************/
1057 ;test2.j(254)     // var - constant
1058 ;test2.j(255)     // byte - byte
1059 ;test2.j(256)     if (b > 10) println(130); else println(999);
1060 acc8= variable 6
1061 acc8Comp constant 10
1062 brle 1098
1063 acc8= constant 130
1064 writeLineAcc8
1065 br 1101
1066 acc16= constant 999
1067 writeLineAcc16
1068 ;test2.j(257)     if (b < 30) println(131); else println(999);
1069 acc8= variable 6
1070 acc8Comp constant 30
1071 brge 1107
1072 acc8= constant 131
1073 writeLineAcc8
1074 br 1112
1075 acc16= constant 999
1076 writeLineAcc16
1077 ;test2.j(258)     // var - constant
1078 ;test2.j(259)     // byte - integer
1079 ;test2.j(260)     if (b > 1000) println(999); else println(132);
1080 acc8= variable 6
1081 acc16= constant 1000
1082 acc8CompareAcc16
1083 brle 1119
1084 acc16= constant 999
1085 writeLineAcc16
1086 br 1122
1087 acc8= constant 132
1088 writeLineAcc8
1089 ;test2.j(261)     if (b < 1000) println(133); else println(999);
1090 acc8= variable 6
1091 acc16= constant 1000
1092 acc8CompareAcc16
1093 brge 1129
1094 acc8= constant 133
1095 writeLineAcc8
1096 br 1134
1097 acc16= constant 999
1098 writeLineAcc16
1099 ;test2.j(262)     // var - constant
1100 ;test2.j(263)     // integer - byte
1101 ;test2.j(264)     if (i > 1000) println(134); else println(999);
1102 acc16= variable 0
1103 acc16Comp constant 1000
1104 brle 1140
1105 acc8= constant 134
1106 writeLineAcc8
1107 br 1143
1108 acc16= constant 999
1109 writeLineAcc16
1110 ;test2.j(265)     if (i < 3000) println(135); else println(999);
1111 acc16= variable 0
1112 acc16Comp constant 3000
1113 brge 1149
1114 acc8= constant 135
1115 writeLineAcc8
1116 br 1154
1117 acc16= constant 999
1118 writeLineAcc16
1119 ;test2.j(266)     // var - constant
1120 ;test2.j(267)     // integer - integer
1121 ;test2.j(268)     if (i > 1000) println(136); else println(999);
1122 acc16= variable 0
1123 acc16Comp constant 1000
1124 brle 1160
1125 acc8= constant 136
1126 writeLineAcc8
1127 br 1163
1128 acc16= constant 999
1129 writeLineAcc16
1130 ;test2.j(269)     if (i < 3000) println(137); else println(999);
1131 acc16= variable 0
1132 acc16Comp constant 3000
1133 brge 1169
1134 acc8= constant 137
1135 writeLineAcc8
1136 br 1172
1137 acc16= constant 999
1138 writeLineAcc16
1139 ;test2.j(270)     println(138);
1140 acc8= constant 138
1141 writeLineAcc8
1142 ;test2.j(271)     println(139);
1143 acc8= constant 139
1144 writeLineAcc8
1145 ;test2.j(272)   
1146 ;test2.j(273)     /************************/
1147 ;test2.j(274)     // var - acc
1148 ;test2.j(275)     // byte - byte
1149 ;test2.j(276)     if (b > 10+0) println(140); else println(999);
1150 acc8= constant 10
1151 acc8+ constant 0
1152 acc8Comp variable 6
1153 brge 1189
1154 acc8= constant 140
1155 writeLineAcc8
1156 br 1192
1157 acc16= constant 999
1158 writeLineAcc16
1159 ;test2.j(277)     if (b < 30+0) println(141); else println(999);
1160 acc8= constant 30
1161 acc8+ constant 0
1162 acc8Comp variable 6
1163 brle 1199
1164 acc8= constant 141
1165 writeLineAcc8
1166 br 1204
1167 acc16= constant 999
1168 writeLineAcc16
1169 ;test2.j(278)     // var - acc
1170 ;test2.j(279)     // byte - integer
1171 ;test2.j(280)     if (b > 1000+0) println(999); else println(142);
1172 acc16= constant 1000
1173 acc16+ constant 0
1174 acc8= variable 6
1175 acc8CompareAcc16
1176 brle 1212
1177 acc16= constant 999
1178 writeLineAcc16
1179 br 1215
1180 acc8= constant 142
1181 writeLineAcc8
1182 ;test2.j(281)     if (b < 1000+0) println(143); else println(999);
1183 acc16= constant 1000
1184 acc16+ constant 0
1185 acc8= variable 6
1186 acc8CompareAcc16
1187 brge 1223
1188 acc8= constant 143
1189 writeLineAcc8
1190 br 1228
1191 acc16= constant 999
1192 writeLineAcc16
1193 ;test2.j(282)     // var - acc
1194 ;test2.j(283)     // integer - byte
1195 ;test2.j(284)     if (i > 1000+0) println(144); else println(999);
1196 acc16= constant 1000
1197 acc16+ constant 0
1198 acc16Comp variable 0
1199 brge 1235
1200 acc8= constant 144
1201 writeLineAcc8
1202 br 1238
1203 acc16= constant 999
1204 writeLineAcc16
1205 ;test2.j(285)     if (i < 3000+0) println(145); else println(999);
1206 acc16= constant 3000
1207 acc16+ constant 0
1208 acc16Comp variable 0
1209 brle 1245
1210 acc8= constant 145
1211 writeLineAcc8
1212 br 1250
1213 acc16= constant 999
1214 writeLineAcc16
1215 ;test2.j(286)     // var - acc
1216 ;test2.j(287)     // integer - integer
1217 ;test2.j(288)     if (i > 1000+0) println(146); else println(999);
1218 acc16= constant 1000
1219 acc16+ constant 0
1220 acc16Comp variable 0
1221 brge 1257
1222 acc8= constant 146
1223 writeLineAcc8
1224 br 1260
1225 acc16= constant 999
1226 writeLineAcc16
1227 ;test2.j(289)     if (i < 3000+0) println(147); else println(999);
1228 acc16= constant 3000
1229 acc16+ constant 0
1230 acc16Comp variable 0
1231 brle 1267
1232 acc8= constant 147
1233 writeLineAcc8
1234 br 1270
1235 acc16= constant 999
1236 writeLineAcc16
1237 ;test2.j(290)     println(148);
1238 acc8= constant 148
1239 writeLineAcc8
1240 ;test2.j(291)     println(149);
1241 acc8= constant 149
1242 writeLineAcc8
1243 ;test2.j(292)   
1244 ;test2.j(293)     /************************/
1245 ;test2.j(294)     // var - var
1246 ;test2.j(295)     // byte - byte
1247 ;test2.j(296)     if (b > b1) println(150);
1248 acc8= variable 6
1249 acc8Comp variable 7
1250 brle 1286
1251 acc8= constant 150
1252 writeLineAcc8
1253 ;test2.j(297)     if (b < b3) println(151);
1254 acc8= variable 6
1255 acc8Comp variable 8
1256 brge 1294
1257 acc8= constant 151
1258 writeLineAcc8
1259 ;test2.j(298)     // var - var
1260 ;test2.j(299)     // byte - integer
1261 ;test2.j(300)     if (b > i1) println(999); else println(152);
1262 acc8= variable 6
1263 acc16= variable 2
1264 acc8CompareAcc16
1265 brle 1301
1266 acc16= constant 999
1267 writeLineAcc16
1268 br 1304
1269 acc8= constant 152
1270 writeLineAcc8
1271 ;test2.j(301)     if (b < i3) println(153);
1272 acc8= variable 6
1273 acc16= variable 4
1274 acc8CompareAcc16
1275 brge 1313
1276 acc8= constant 153
1277 writeLineAcc8
1278 ;test2.j(302)     // var - var
1279 ;test2.j(303)     // integer - byte
1280 ;test2.j(304)     if (i > i1) println(154);
1281 acc16= variable 0
1282 acc16Comp variable 2
1283 brle 1319
1284 acc8= constant 154
1285 writeLineAcc8
1286 ;test2.j(305)     if (i < i3) println(155);
1287 acc16= variable 0
1288 acc16Comp variable 4
1289 brge 1327
1290 acc8= constant 155
1291 writeLineAcc8
1292 ;test2.j(306)     // var - var
1293 ;test2.j(307)     // integer - integer
1294 ;test2.j(308)     if (i > i1) println(156);
1295 acc16= variable 0
1296 acc16Comp variable 2
1297 brle 1333
1298 acc8= constant 156
1299 writeLineAcc8
1300 ;test2.j(309)     if (i < i3) println(157);
1301 acc16= variable 0
1302 acc16Comp variable 4
1303 brge 1339
1304 acc8= constant 157
1305 writeLineAcc8
1306 ;test2.j(310)     println(158);
1307 acc8= constant 158
1308 writeLineAcc8
1309 ;test2.j(311)     println(159);
1310 acc8= constant 159
1311 writeLineAcc8
1312 ;test2.j(312)   
1313 ;test2.j(313)     /************************/
1314 ;test2.j(314)     // var - stack8
1315 ;test2.j(315)     // byte - byte
1316 ;test2.j(316)   
1317 ;test2.j(317)     // var - stack8
1318 ;test2.j(318)     // byte - integer
1319 ;test2.j(319)   
1320 ;test2.j(320)     // var - stack8
1321 ;test2.j(321)     // integer - byte 
1322 ;test2.j(322)   
1323 ;test2.j(323)     // var - stack8
1324 ;test2.j(324)     // integer - integer
1325 ;test2.j(325)   
1326 ;test2.j(326)     /************************/
1327 ;test2.j(327)     // var - stack16
1328 ;test2.j(328)     // byte - byte
1329 ;test2.j(329)   
1330 ;test2.j(330)     // var - stack16
1331 ;test2.j(331)     // byte - integer
1332 ;test2.j(332)   
1333 ;test2.j(333)     // var - stack16
1334 ;test2.j(334)     // integer - byte
1335 ;test2.j(335)   
1336 ;test2.j(336)     // var - stack16
1337 ;test2.j(337)     // integer - integer
1338 ;test2.j(338)   
1339 ;test2.j(339)     /************************/
1340 ;test2.j(340)     // stack8 - constant
1341 ;test2.j(341)     // stack8 - acc
1342 ;test2.j(342)     // stack8 - var
1343 ;test2.j(343)     // stack8 - stack8
1344 ;test2.j(344)     // stack8 - stack16
1345 ;test2.j(345)   
1346 ;test2.j(346)     /************************/
1347 ;test2.j(347)     // stack16 - constant
1348 ;test2.j(348)     // stack16 - acc
1349 ;test2.j(349)     // stack16 - var
1350 ;test2.j(350)     // stack16 - stack8
1351 ;test2.j(351)     // stack16 - stack16
1352 ;test2.j(352)   
1353 ;test2.j(353)     println("Klaar");
1354 acc16= stringconstant 1361
1355 writeLineString
1356 stackPointer= basePointer
1357 basePointer<
1358 return
1359 ;test2.j(354)   }
1360 ;test2.j(355) }
1361 stringConstant 0 = "Klaar"
