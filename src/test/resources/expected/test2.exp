   0 ;test2.j(0) /* Program to test branch instructions */
   1 ;test2.j(1) class TestBranches {
   2 ;test2.j(2)   word i = 2000;
   3 acc16= constant 2000
   4 acc16=> variable 0
   5 ;test2.j(3)   word i1 = 1000;
   6 acc16= constant 1000
   7 acc16=> variable 2
   8 ;test2.j(4)   word i3 = 3000;
   9 acc16= constant 3000
  10 acc16=> variable 4
  11 ;test2.j(5)   byte b = 20;
  12 acc8= constant 20
  13 acc8=> variable 6
  14 ;test2.j(6)   byte b1 = 10;
  15 acc8= constant 10
  16 acc8=> variable 7
  17 ;test2.j(7)   byte b3 = 30;
  18 acc8= constant 30
  19 acc8=> variable 8
  20 ;test2.j(8) 
  21 ;test2.j(9)   /*Possible operand types: 
  22 ;test2.j(10)    * constant, acc, var, stack8, stack16
  23 ;test2.j(11)    *Possible datatype combinations:
  24 ;test2.j(12)    * byte - byte
  25 ;test2.j(13)    * byte - integer
  26 ;test2.j(14)    * integer - byte
  27 ;test2.j(15)    * integer - integer
  28 ;test2.j(16)   */
  29 ;test2.j(17) 
  30 ;test2.j(18)   println(0);
  31 acc8= constant 0
  32 call writeLineAcc8
  33 ;test2.j(19) 
  34 ;test2.j(20)   /************************/
  35 ;test2.j(21)   // constant - constant
  36 ;test2.j(22)   // byte - byte
  37 ;test2.j(23)   if (1 == 1) println(1); else println(999);
  38 acc8= constant 1
  39 acc8Comp constant 1
  40 brne 44
  41 acc8= constant 1
  42 call writeLineAcc8
  43 br 47
  44 acc16= constant 999
  45 call writeLineAcc16
  46 ;test2.j(24)   if (1 != 0) println(2); else println(999);
  47 acc8= constant 1
  48 acc8Comp constant 0
  49 breq 53
  50 acc8= constant 2
  51 call writeLineAcc8
  52 br 56
  53 acc16= constant 999
  54 call writeLineAcc16
  55 ;test2.j(25)   if (1 >  0) println(3); else println(999);
  56 acc8= constant 1
  57 acc8Comp constant 0
  58 brle 62
  59 acc8= constant 3
  60 call writeLineAcc8
  61 br 65
  62 acc16= constant 999
  63 call writeLineAcc16
  64 ;test2.j(26)   if (1 >= 0) println(4); else println(999);
  65 acc8= constant 1
  66 acc8Comp constant 0
  67 brlt 71
  68 acc8= constant 4
  69 call writeLineAcc8
  70 br 74
  71 acc16= constant 999
  72 call writeLineAcc16
  73 ;test2.j(27)   if (1 >= 1) println(5); else println(999);
  74 acc8= constant 1
  75 acc8Comp constant 1
  76 brlt 80
  77 acc8= constant 5
  78 call writeLineAcc8
  79 br 83
  80 acc16= constant 999
  81 call writeLineAcc16
  82 ;test2.j(28)   if (1 <  2) println(6); else println(999);
  83 acc8= constant 1
  84 acc8Comp constant 2
  85 brge 89
  86 acc8= constant 6
  87 call writeLineAcc8
  88 br 92
  89 acc16= constant 999
  90 call writeLineAcc16
  91 ;test2.j(29)   if (1 <= 2) println(7); else println(999);
  92 acc8= constant 1
  93 acc8Comp constant 2
  94 brgt 98
  95 acc8= constant 7
  96 call writeLineAcc8
  97 br 101
  98 acc16= constant 999
  99 call writeLineAcc16
 100 ;test2.j(30)   if (1 <= 1) println(8); else println(999);
 101 acc8= constant 1
 102 acc8Comp constant 1
 103 brgt 107
 104 acc8= constant 8
 105 call writeLineAcc8
 106 br 110
 107 acc16= constant 999
 108 call writeLineAcc16
 109 ;test2.j(31)   println(9);
 110 acc8= constant 9
 111 call writeLineAcc8
 112 ;test2.j(32) 
 113 ;test2.j(33)   // constant - constant
 114 ;test2.j(34)   // byte - integer
 115 ;test2.j(35)   if (1 == 1000) println(999); else println(10);
 116 acc8= constant 1
 117 acc16= constant 1000
 118 acc8CompareAcc16
 119 brne 123
 120 acc16= constant 999
 121 call writeLineAcc16
 122 br 126
 123 acc8= constant 10
 124 call writeLineAcc8
 125 ;test2.j(36)   if (1 != 1000) println(11);  else println(999);
 126 acc8= constant 1
 127 acc16= constant 1000
 128 acc8CompareAcc16
 129 breq 133
 130 acc8= constant 11
 131 call writeLineAcc8
 132 br 136
 133 acc16= constant 999
 134 call writeLineAcc16
 135 ;test2.j(37)   if (1 >  1000) println(999); else println(12);
 136 acc8= constant 1
 137 acc16= constant 1000
 138 acc8CompareAcc16
 139 brle 143
 140 acc16= constant 999
 141 call writeLineAcc16
 142 br 146
 143 acc8= constant 12
 144 call writeLineAcc8
 145 ;test2.j(38)   if (1 >= 1000) println(999); else println(13);
 146 acc8= constant 1
 147 acc16= constant 1000
 148 acc8CompareAcc16
 149 brlt 153
 150 acc16= constant 999
 151 call writeLineAcc16
 152 br 156
 153 acc8= constant 13
 154 call writeLineAcc8
 155 ;test2.j(39)   if (1 >= 1000) println(999); else println(14);
 156 acc8= constant 1
 157 acc16= constant 1000
 158 acc8CompareAcc16
 159 brlt 163
 160 acc16= constant 999
 161 call writeLineAcc16
 162 br 166
 163 acc8= constant 14
 164 call writeLineAcc8
 165 ;test2.j(40)   if (1 <  2000) println(15);  else println(999);
 166 acc8= constant 1
 167 acc16= constant 2000
 168 acc8CompareAcc16
 169 brge 173
 170 acc8= constant 15
 171 call writeLineAcc8
 172 br 176
 173 acc16= constant 999
 174 call writeLineAcc16
 175 ;test2.j(41)   if (1 <= 2000) println(16);  else println(999);
 176 acc8= constant 1
 177 acc16= constant 2000
 178 acc8CompareAcc16
 179 brgt 183
 180 acc8= constant 16
 181 call writeLineAcc8
 182 br 186
 183 acc16= constant 999
 184 call writeLineAcc16
 185 ;test2.j(42)   if (1 <= 1000) println(17);  else println(999);
 186 acc8= constant 1
 187 acc16= constant 1000
 188 acc8CompareAcc16
 189 brgt 193
 190 acc8= constant 17
 191 call writeLineAcc8
 192 br 196
 193 acc16= constant 999
 194 call writeLineAcc16
 195 ;test2.j(43)   println(18);
 196 acc8= constant 18
 197 call writeLineAcc8
 198 ;test2.j(44)   println(19);
 199 acc8= constant 19
 200 call writeLineAcc8
 201 ;test2.j(45) 
 202 ;test2.j(46)   // constant - constant
 203 ;test2.j(47)   // integer - byte
 204 ;test2.j(48)   if (1000 == 1) println(999); else println(20);
 205 acc16= constant 1000
 206 acc8= constant 1
 207 acc16CompareAcc8
 208 brne 212
 209 acc16= constant 999
 210 call writeLineAcc16
 211 br 215
 212 acc8= constant 20
 213 call writeLineAcc8
 214 ;test2.j(49)   if (1000 != 0) println(21);  else println(999);
 215 acc16= constant 1000
 216 acc8= constant 0
 217 acc16CompareAcc8
 218 breq 222
 219 acc8= constant 21
 220 call writeLineAcc8
 221 br 225
 222 acc16= constant 999
 223 call writeLineAcc16
 224 ;test2.j(50)   if (1000 >  0) println(22);  else println(999);
 225 acc16= constant 1000
 226 acc8= constant 0
 227 acc16CompareAcc8
 228 brle 232
 229 acc8= constant 22
 230 call writeLineAcc8
 231 br 235
 232 acc16= constant 999
 233 call writeLineAcc16
 234 ;test2.j(51)   if (1000 >= 0) println(23);  else println(999);
 235 acc16= constant 1000
 236 acc8= constant 0
 237 acc16CompareAcc8
 238 brlt 242
 239 acc8= constant 23
 240 call writeLineAcc8
 241 br 245
 242 acc16= constant 999
 243 call writeLineAcc16
 244 ;test2.j(52)   if (1000 >= 1) println(24);  else println(999);
 245 acc16= constant 1000
 246 acc8= constant 1
 247 acc16CompareAcc8
 248 brlt 252
 249 acc8= constant 24
 250 call writeLineAcc8
 251 br 255
 252 acc16= constant 999
 253 call writeLineAcc16
 254 ;test2.j(53)   if (1 <  2000) println(25);  else println(999);
 255 acc8= constant 1
 256 acc16= constant 2000
 257 acc8CompareAcc16
 258 brge 262
 259 acc8= constant 25
 260 call writeLineAcc8
 261 br 265
 262 acc16= constant 999
 263 call writeLineAcc16
 264 ;test2.j(54)   if (1 <= 2000) println(26);  else println(999);
 265 acc8= constant 1
 266 acc16= constant 2000
 267 acc8CompareAcc16
 268 brgt 272
 269 acc8= constant 26
 270 call writeLineAcc8
 271 br 275
 272 acc16= constant 999
 273 call writeLineAcc16
 274 ;test2.j(55)   if (1 <= 1000) println(27);  else println(999);
 275 acc8= constant 1
 276 acc16= constant 1000
 277 acc8CompareAcc16
 278 brgt 282
 279 acc8= constant 27
 280 call writeLineAcc8
 281 br 285
 282 acc16= constant 999
 283 call writeLineAcc16
 284 ;test2.j(56)   println(28);
 285 acc8= constant 28
 286 call writeLineAcc8
 287 ;test2.j(57)   println(29);
 288 acc8= constant 29
 289 call writeLineAcc8
 290 ;test2.j(58) 
 291 ;test2.j(59)   // constant - constant
 292 ;test2.j(60)   // integer - integer
 293 ;test2.j(61)   if (1000 == 1000) println(30); else println(999);
 294 acc16= constant 1000
 295 acc16Comp constant 1000
 296 brne 300
 297 acc8= constant 30
 298 call writeLineAcc8
 299 br 303
 300 acc16= constant 999
 301 call writeLineAcc16
 302 ;test2.j(62)   if (1000 != 2000) println(31); else println(999);
 303 acc16= constant 1000
 304 acc16Comp constant 2000
 305 breq 309
 306 acc8= constant 31
 307 call writeLineAcc8
 308 br 312
 309 acc16= constant 999
 310 call writeLineAcc16
 311 ;test2.j(63)   if (2000 >  1000) println(32); else println(999);
 312 acc16= constant 2000
 313 acc16Comp constant 1000
 314 brle 318
 315 acc8= constant 32
 316 call writeLineAcc8
 317 br 321
 318 acc16= constant 999
 319 call writeLineAcc16
 320 ;test2.j(64)   if (2000 >= 1000) println(33); else println(999);
 321 acc16= constant 2000
 322 acc16Comp constant 1000
 323 brlt 327
 324 acc8= constant 33
 325 call writeLineAcc8
 326 br 330
 327 acc16= constant 999
 328 call writeLineAcc16
 329 ;test2.j(65)   if (1000 >= 1000) println(34); else println(999);
 330 acc16= constant 1000
 331 acc16Comp constant 1000
 332 brlt 336
 333 acc8= constant 34
 334 call writeLineAcc8
 335 br 339
 336 acc16= constant 999
 337 call writeLineAcc16
 338 ;test2.j(66)   if (1000 <  2000) println(35); else println(999);
 339 acc16= constant 1000
 340 acc16Comp constant 2000
 341 brge 345
 342 acc8= constant 35
 343 call writeLineAcc8
 344 br 348
 345 acc16= constant 999
 346 call writeLineAcc16
 347 ;test2.j(67)   if (1000 <= 2000) println(36); else println(999);
 348 acc16= constant 1000
 349 acc16Comp constant 2000
 350 brgt 354
 351 acc8= constant 36
 352 call writeLineAcc8
 353 br 357
 354 acc16= constant 999
 355 call writeLineAcc16
 356 ;test2.j(68)   if (1000 <= 1000) println(37); else println(999);
 357 acc16= constant 1000
 358 acc16Comp constant 1000
 359 brgt 363
 360 acc8= constant 37
 361 call writeLineAcc8
 362 br 366
 363 acc16= constant 999
 364 call writeLineAcc16
 365 ;test2.j(69)   println(38);
 366 acc8= constant 38
 367 call writeLineAcc8
 368 ;test2.j(70)   println(39);
 369 acc8= constant 39
 370 call writeLineAcc8
 371 ;test2.j(71) 
 372 ;test2.j(72)   /************************/
 373 ;test2.j(73)   // constant - acc
 374 ;test2.j(74)   // byte - byte
 375 ;test2.j(75)   if (1 > 0+0) println(40); else println(999);
 376 acc8= constant 0
 377 acc8+ constant 0
 378 acc8Comp constant 1
 379 brge 383
 380 acc8= constant 40
 381 call writeLineAcc8
 382 br 386
 383 acc16= constant 999
 384 call writeLineAcc16
 385 ;test2.j(76)   if (1 < 2+0) println(41); else println(999);
 386 acc8= constant 2
 387 acc8+ constant 0
 388 acc8Comp constant 1
 389 brle 393
 390 acc8= constant 41
 391 call writeLineAcc8
 392 br 398
 393 acc16= constant 999
 394 call writeLineAcc16
 395 ;test2.j(77)   // constant - acc
 396 ;test2.j(78)   // byte - integer
 397 ;test2.j(79)   if (1 > 1000+0) println(999); else println(42);
 398 acc16= constant 1000
 399 acc16+ constant 0
 400 acc8= constant 1
 401 acc8CompareAcc16
 402 brle 406
 403 acc16= constant 999
 404 call writeLineAcc16
 405 br 409
 406 acc8= constant 42
 407 call writeLineAcc8
 408 ;test2.j(80)   if (1 < 1000+0) println(43);  else println(999);
 409 acc16= constant 1000
 410 acc16+ constant 0
 411 acc8= constant 1
 412 acc8CompareAcc16
 413 brge 417
 414 acc8= constant 43
 415 call writeLineAcc8
 416 br 422
 417 acc16= constant 999
 418 call writeLineAcc16
 419 ;test2.j(81)   // constant - acc
 420 ;test2.j(82)   // integer - byte
 421 ;test2.j(83)   if (1000 > 0+0) println(44);  else println(999);
 422 acc8= constant 0
 423 acc8+ constant 0
 424 acc16= constant 1000
 425 acc16CompareAcc8
 426 brle 430
 427 acc8= constant 44
 428 call writeLineAcc8
 429 br 433
 430 acc16= constant 999
 431 call writeLineAcc16
 432 ;test2.j(84)   if (1000 < 0+0) println(999); else println(45);
 433 acc8= constant 0
 434 acc8+ constant 0
 435 acc16= constant 1000
 436 acc16CompareAcc8
 437 brge 441
 438 acc16= constant 999
 439 call writeLineAcc16
 440 br 446
 441 acc8= constant 45
 442 call writeLineAcc8
 443 ;test2.j(85)   // constant - acc
 444 ;test2.j(86)   // integer - integer
 445 ;test2.j(87)   if (2000 > 1000+0) println(46); else println(999);
 446 acc16= constant 1000
 447 acc16+ constant 0
 448 acc16Comp constant 2000
 449 brge 453
 450 acc8= constant 46
 451 call writeLineAcc8
 452 br 456
 453 acc16= constant 999
 454 call writeLineAcc16
 455 ;test2.j(88)   if (1000 < 2000+0) println(47); else println(999);
 456 acc16= constant 2000
 457 acc16+ constant 0
 458 acc16Comp constant 1000
 459 brle 463
 460 acc8= constant 47
 461 call writeLineAcc8
 462 br 466
 463 acc16= constant 999
 464 call writeLineAcc16
 465 ;test2.j(89)   println(48);
 466 acc8= constant 48
 467 call writeLineAcc8
 468 ;test2.j(90)   println(49);
 469 acc8= constant 49
 470 call writeLineAcc8
 471 ;test2.j(91) 
 472 ;test2.j(92)   /************************/
 473 ;test2.j(93)   // constant - var
 474 ;test2.j(94)   // byte - byte
 475 ;test2.j(95)   if (30 > b) println(50); else println(999);
 476 acc8= variable 6
 477 acc8Comp constant 30
 478 brge 482
 479 acc8= constant 50
 480 call writeLineAcc8
 481 br 485
 482 acc16= constant 999
 483 call writeLineAcc16
 484 ;test2.j(96)   if (10 < b) println(51); else println(999);
 485 acc8= variable 6
 486 acc8Comp constant 10
 487 brle 491
 488 acc8= constant 51
 489 call writeLineAcc8
 490 br 496
 491 acc16= constant 999
 492 call writeLineAcc16
 493 ;test2.j(97)   // constant - var
 494 ;test2.j(98)   // byte - integer
 495 ;test2.j(99)   if (30 > i) println(999); else println(52);
 496 acc16= variable 0
 497 acc8= constant 30
 498 acc8CompareAcc16
 499 brle 503
 500 acc16= constant 999
 501 call writeLineAcc16
 502 br 506
 503 acc8= constant 52
 504 call writeLineAcc8
 505 ;test2.j(100)   if (10 < i) println(53); else println(999);
 506 acc16= variable 0
 507 acc8= constant 10
 508 acc8CompareAcc16
 509 brge 513
 510 acc8= constant 53
 511 call writeLineAcc8
 512 br 518
 513 acc16= constant 999
 514 call writeLineAcc16
 515 ;test2.j(101)   // constant - var
 516 ;test2.j(102)   // integer - byte
 517 ;test2.j(103)   if (3000 > b) println(54); else println(999);
 518 acc8= variable 6
 519 acc16= constant 3000
 520 acc16CompareAcc8
 521 brle 525
 522 acc8= constant 54
 523 call writeLineAcc8
 524 br 528
 525 acc16= constant 999
 526 call writeLineAcc16
 527 ;test2.j(104)   if (1000 < b) println(999); else println(55);
 528 acc8= variable 6
 529 acc16= constant 1000
 530 acc16CompareAcc8
 531 brge 535
 532 acc16= constant 999
 533 call writeLineAcc16
 534 br 540
 535 acc8= constant 55
 536 call writeLineAcc8
 537 ;test2.j(105)   // constant - var
 538 ;test2.j(106)   // integer - integer
 539 ;test2.j(107)   if (3000 > i) println(56); else println(999);
 540 acc16= variable 0
 541 acc16Comp constant 3000
 542 brge 546
 543 acc8= constant 56
 544 call writeLineAcc8
 545 br 549
 546 acc16= constant 999
 547 call writeLineAcc16
 548 ;test2.j(108)   if (1000 < i) println(57); else println(999);
 549 acc16= variable 0
 550 acc16Comp constant 1000
 551 brle 555
 552 acc8= constant 57
 553 call writeLineAcc8
 554 br 558
 555 acc16= constant 999
 556 call writeLineAcc16
 557 ;test2.j(109)   println(58);
 558 acc8= constant 58
 559 call writeLineAcc8
 560 ;test2.j(110)   println(59);
 561 acc8= constant 59
 562 call writeLineAcc8
 563 ;test2.j(111) 
 564 ;test2.j(112)   /************************/
 565 ;test2.j(113)   // constant - stack8
 566 ;test2.j(114)   // byte - byte
 567 ;test2.j(115)   println(60);
 568 acc8= constant 60
 569 call writeLineAcc8
 570 ;test2.j(116)   println(61);
 571 acc8= constant 61
 572 call writeLineAcc8
 573 ;test2.j(117)   // constant - stack8
 574 ;test2.j(118)   // byte - integer
 575 ;test2.j(119)   println(62);
 576 acc8= constant 62
 577 call writeLineAcc8
 578 ;test2.j(120)   println(63);
 579 acc8= constant 63
 580 call writeLineAcc8
 581 ;test2.j(121)   // constant - stack8
 582 ;test2.j(122)   // integer - byte
 583 ;test2.j(123)   println(64);
 584 acc8= constant 64
 585 call writeLineAcc8
 586 ;test2.j(124)   println(65);
 587 acc8= constant 65
 588 call writeLineAcc8
 589 ;test2.j(125)   // constant - stack8
 590 ;test2.j(126)   // integer - integer
 591 ;test2.j(127)   println(66);
 592 acc8= constant 66
 593 call writeLineAcc8
 594 ;test2.j(128)   println(67);
 595 acc8= constant 67
 596 call writeLineAcc8
 597 ;test2.j(129)   println(68);
 598 acc8= constant 68
 599 call writeLineAcc8
 600 ;test2.j(130)   println(69);
 601 acc8= constant 69
 602 call writeLineAcc8
 603 ;test2.j(131) 
 604 ;test2.j(132)   /************************/
 605 ;test2.j(133)   // constant - stack16
 606 ;test2.j(134)   // byte - byte
 607 ;test2.j(135)   println(70);
 608 acc8= constant 70
 609 call writeLineAcc8
 610 ;test2.j(136)   println(71);
 611 acc8= constant 71
 612 call writeLineAcc8
 613 ;test2.j(137)   // constant - stack16
 614 ;test2.j(138)   // byte - integer
 615 ;test2.j(139)   println(72);
 616 acc8= constant 72
 617 call writeLineAcc8
 618 ;test2.j(140)   println(73);
 619 acc8= constant 73
 620 call writeLineAcc8
 621 ;test2.j(141)   // constant - stack16
 622 ;test2.j(142)   // integer - byte
 623 ;test2.j(143)   println(74);
 624 acc8= constant 74
 625 call writeLineAcc8
 626 ;test2.j(144)   println(75);
 627 acc8= constant 75
 628 call writeLineAcc8
 629 ;test2.j(145)   // constant - stack16
 630 ;test2.j(146)   // integer - integer
 631 ;test2.j(147)   println(76);
 632 acc8= constant 76
 633 call writeLineAcc8
 634 ;test2.j(148)   println(77);
 635 acc8= constant 77
 636 call writeLineAcc8
 637 ;test2.j(149)   println(78);
 638 acc8= constant 78
 639 call writeLineAcc8
 640 ;test2.j(150)   println(79);
 641 acc8= constant 79
 642 call writeLineAcc8
 643 ;test2.j(151) 
 644 ;test2.j(152)   /************************/
 645 ;test2.j(153)   // acc - constant
 646 ;test2.j(154)   // byte - byte
 647 ;test2.j(155)   if (30+0 > 20) println(80); else println(999);
 648 acc8= constant 30
 649 acc8+ constant 0
 650 acc8Comp constant 20
 651 brle 655
 652 acc8= constant 80
 653 call writeLineAcc8
 654 br 658
 655 acc16= constant 999
 656 call writeLineAcc16
 657 ;test2.j(156)   if (10+0 < 20) println(81); else println(999);
 658 acc8= constant 10
 659 acc8+ constant 0
 660 acc8Comp constant 20
 661 brge 665
 662 acc8= constant 81
 663 call writeLineAcc8
 664 br 670
 665 acc16= constant 999
 666 call writeLineAcc16
 667 ;test2.j(157)   // acc - constant
 668 ;test2.j(158)   // byte - integer
 669 ;test2.j(159)   if (30+0 > 2000) println(999); else println(82);
 670 acc8= constant 30
 671 acc8+ constant 0
 672 acc16= constant 2000
 673 acc8CompareAcc16
 674 brle 678
 675 acc16= constant 999
 676 call writeLineAcc16
 677 br 681
 678 acc8= constant 82
 679 call writeLineAcc8
 680 ;test2.j(160)   if (10+0 < 2000) println(83); else println(999);
 681 acc8= constant 10
 682 acc8+ constant 0
 683 acc16= constant 2000
 684 acc8CompareAcc16
 685 brge 689
 686 acc8= constant 83
 687 call writeLineAcc8
 688 br 694
 689 acc16= constant 999
 690 call writeLineAcc16
 691 ;test2.j(161)   // acc - constant
 692 ;test2.j(162)   // integer - byte
 693 ;test2.j(163)   if (3000+0 > 20) println(84); else println(999);
 694 acc16= constant 3000
 695 acc16+ constant 0
 696 acc8= constant 20
 697 acc16CompareAcc8
 698 brle 702
 699 acc8= constant 84
 700 call writeLineAcc8
 701 br 705
 702 acc16= constant 999
 703 call writeLineAcc16
 704 ;test2.j(164)   if (1000+0 < 20) println(999); else println(85);
 705 acc16= constant 1000
 706 acc16+ constant 0
 707 acc8= constant 20
 708 acc16CompareAcc8
 709 brge 713
 710 acc16= constant 999
 711 call writeLineAcc16
 712 br 718
 713 acc8= constant 85
 714 call writeLineAcc8
 715 ;test2.j(165)   // acc - constant
 716 ;test2.j(166)   // integer - integer
 717 ;test2.j(167)   if (3000+0 > 2000) println(86); else println(999);
 718 acc16= constant 3000
 719 acc16+ constant 0
 720 acc16Comp constant 2000
 721 brle 725
 722 acc8= constant 86
 723 call writeLineAcc8
 724 br 728
 725 acc16= constant 999
 726 call writeLineAcc16
 727 ;test2.j(168)   if (1000+0 < 2000) println(87); else println(999);
 728 acc16= constant 1000
 729 acc16+ constant 0
 730 acc16Comp constant 2000
 731 brge 735
 732 acc8= constant 87
 733 call writeLineAcc8
 734 br 738
 735 acc16= constant 999
 736 call writeLineAcc16
 737 ;test2.j(169)   println(88);
 738 acc8= constant 88
 739 call writeLineAcc8
 740 ;test2.j(170)   println(89);
 741 acc8= constant 89
 742 call writeLineAcc8
 743 ;test2.j(171) 
 744 ;test2.j(172)   /************************/
 745 ;test2.j(173)   // acc - acc
 746 ;test2.j(174)   // byte - byte
 747 ;test2.j(175)   if (30+0 > 20+0) println(90); else println(999);
 748 acc8= constant 30
 749 acc8+ constant 0
 750 <acc8
 751 acc8= constant 20
 752 acc8+ constant 0
 753 revAcc8Comp unstack8
 754 brge 758
 755 acc8= constant 90
 756 call writeLineAcc8
 757 br 761
 758 acc16= constant 999
 759 call writeLineAcc16
 760 ;test2.j(176)   if (10+0 < 20+0) println(91); else println(999);
 761 acc8= constant 10
 762 acc8+ constant 0
 763 <acc8
 764 acc8= constant 20
 765 acc8+ constant 0
 766 revAcc8Comp unstack8
 767 brle 771
 768 acc8= constant 91
 769 call writeLineAcc8
 770 br 776
 771 acc16= constant 999
 772 call writeLineAcc16
 773 ;test2.j(177)   // acc - acc
 774 ;test2.j(178)   // byte - integer
 775 ;test2.j(179)   if (30+0 > 2000+0) println(999); else println(92);
 776 acc8= constant 30
 777 acc8+ constant 0
 778 <acc8
 779 acc16= constant 2000
 780 acc16+ constant 0
 781 acc8= unstack8
 782 acc8CompareAcc16
 783 brle 787
 784 acc16= constant 999
 785 call writeLineAcc16
 786 br 790
 787 acc8= constant 92
 788 call writeLineAcc8
 789 ;test2.j(180)   if (10+0 < 2000+0) println(93); else println(999);
 790 acc8= constant 10
 791 acc8+ constant 0
 792 <acc8
 793 acc16= constant 2000
 794 acc16+ constant 0
 795 acc8= unstack8
 796 acc8CompareAcc16
 797 brge 801
 798 acc8= constant 93
 799 call writeLineAcc8
 800 br 806
 801 acc16= constant 999
 802 call writeLineAcc16
 803 ;test2.j(181)   // acc - acc
 804 ;test2.j(182)   // integer - byte
 805 ;test2.j(183)   if (3000+0 > 20+0) println(94); else println(999);
 806 acc16= constant 3000
 807 acc16+ constant 0
 808 <acc16
 809 acc8= constant 20
 810 acc8+ constant 0
 811 acc16= unstack16
 812 acc16CompareAcc8
 813 brle 817
 814 acc8= constant 94
 815 call writeLineAcc8
 816 br 820
 817 acc16= constant 999
 818 call writeLineAcc16
 819 ;test2.j(184)   if (1000+0 < 20+0) println(999); else println(95);
 820 acc16= constant 1000
 821 acc16+ constant 0
 822 <acc16
 823 acc8= constant 20
 824 acc8+ constant 0
 825 acc16= unstack16
 826 acc16CompareAcc8
 827 brge 831
 828 acc16= constant 999
 829 call writeLineAcc16
 830 br 836
 831 acc8= constant 95
 832 call writeLineAcc8
 833 ;test2.j(185)   // acc - acc
 834 ;test2.j(186)   // integer - integer
 835 ;test2.j(187)   if (3000+0 > 2000+0) println(96); else println(999);
 836 acc16= constant 3000
 837 acc16+ constant 0
 838 <acc16
 839 acc16= constant 2000
 840 acc16+ constant 0
 841 revAcc16Comp unstack16
 842 brge 846
 843 acc8= constant 96
 844 call writeLineAcc8
 845 br 849
 846 acc16= constant 999
 847 call writeLineAcc16
 848 ;test2.j(188)   if (1000+0 < 2000+0) println(97); else println(999);
 849 acc16= constant 1000
 850 acc16+ constant 0
 851 <acc16
 852 acc16= constant 2000
 853 acc16+ constant 0
 854 revAcc16Comp unstack16
 855 brle 859
 856 acc8= constant 97
 857 call writeLineAcc8
 858 br 862
 859 acc16= constant 999
 860 call writeLineAcc16
 861 ;test2.j(189)   println(98);
 862 acc8= constant 98
 863 call writeLineAcc8
 864 ;test2.j(190)   println(99);
 865 acc8= constant 99
 866 call writeLineAcc8
 867 ;test2.j(191) 
 868 ;test2.j(192)   /************************/
 869 ;test2.j(193)   // acc - var
 870 ;test2.j(194)   // byte - byte
 871 ;test2.j(195)   if (30+0 > b) println(100); else println(999);
 872 acc8= constant 30
 873 acc8+ constant 0
 874 acc8Comp variable 6
 875 brle 879
 876 acc8= constant 100
 877 call writeLineAcc8
 878 br 882
 879 acc16= constant 999
 880 call writeLineAcc16
 881 ;test2.j(196)   if (10+0 < b) println(101); else println(999);
 882 acc8= constant 10
 883 acc8+ constant 0
 884 acc8Comp variable 6
 885 brge 889
 886 acc8= constant 101
 887 call writeLineAcc8
 888 br 894
 889 acc16= constant 999
 890 call writeLineAcc16
 891 ;test2.j(197)   // acc - var
 892 ;test2.j(198)   // byte - integer
 893 ;test2.j(199)   if (30+0 > i) println(999); else println(102);
 894 acc8= constant 30
 895 acc8+ constant 0
 896 acc16= variable 0
 897 acc8CompareAcc16
 898 brle 902
 899 acc16= constant 999
 900 call writeLineAcc16
 901 br 905
 902 acc8= constant 102
 903 call writeLineAcc8
 904 ;test2.j(200)   if (10+0 < i) println(103); else println(999);
 905 acc8= constant 10
 906 acc8+ constant 0
 907 acc16= variable 0
 908 acc8CompareAcc16
 909 brge 913
 910 acc8= constant 103
 911 call writeLineAcc8
 912 br 918
 913 acc16= constant 999
 914 call writeLineAcc16
 915 ;test2.j(201)   // acc - var
 916 ;test2.j(202)   // integer - byte
 917 ;test2.j(203)   if (3000+0 > b) println(104); else println(999);
 918 acc16= constant 3000
 919 acc16+ constant 0
 920 acc8= variable 6
 921 acc16CompareAcc8
 922 brle 926
 923 acc8= constant 104
 924 call writeLineAcc8
 925 br 929
 926 acc16= constant 999
 927 call writeLineAcc16
 928 ;test2.j(204)   if (1000+0 < b) println(999); else println(105);
 929 acc16= constant 1000
 930 acc16+ constant 0
 931 acc8= variable 6
 932 acc16CompareAcc8
 933 brge 937
 934 acc16= constant 999
 935 call writeLineAcc16
 936 br 942
 937 acc8= constant 105
 938 call writeLineAcc8
 939 ;test2.j(205)   // acc - var
 940 ;test2.j(206)   // integer - integer
 941 ;test2.j(207)   if (3000+0 > i) println(106); else println(999);
 942 acc16= constant 3000
 943 acc16+ constant 0
 944 acc16Comp variable 0
 945 brle 949
 946 acc8= constant 106
 947 call writeLineAcc8
 948 br 952
 949 acc16= constant 999
 950 call writeLineAcc16
 951 ;test2.j(208)   if (1000+0 < i) println(107); else println(999);
 952 acc16= constant 1000
 953 acc16+ constant 0
 954 acc16Comp variable 0
 955 brge 959
 956 acc8= constant 107
 957 call writeLineAcc8
 958 br 962
 959 acc16= constant 999
 960 call writeLineAcc16
 961 ;test2.j(209)   println(108);
 962 acc8= constant 108
 963 call writeLineAcc8
 964 ;test2.j(210)   println(109);
 965 acc8= constant 109
 966 call writeLineAcc8
 967 ;test2.j(211) 
 968 ;test2.j(212)   /************************/
 969 ;test2.j(213)   // acc - stack8
 970 ;test2.j(214)   // byte - byte
 971 ;test2.j(215)   println(110);
 972 acc8= constant 110
 973 call writeLineAcc8
 974 ;test2.j(216)   println(111);
 975 acc8= constant 111
 976 call writeLineAcc8
 977 ;test2.j(217)   // acc - stack8
 978 ;test2.j(218)   // byte - integer
 979 ;test2.j(219)   println(112);
 980 acc8= constant 112
 981 call writeLineAcc8
 982 ;test2.j(220)   println(113);
 983 acc8= constant 113
 984 call writeLineAcc8
 985 ;test2.j(221)   // acc - stack8
 986 ;test2.j(222)   // integer - byte
 987 ;test2.j(223)   println(114);
 988 acc8= constant 114
 989 call writeLineAcc8
 990 ;test2.j(224)   println(115);
 991 acc8= constant 115
 992 call writeLineAcc8
 993 ;test2.j(225)   // acc - stack8
 994 ;test2.j(226)   // integer - integer
 995 ;test2.j(227)   println(116);
 996 acc8= constant 116
 997 call writeLineAcc8
 998 ;test2.j(228)   println(117);
 999 acc8= constant 117
1000 call writeLineAcc8
1001 ;test2.j(229)   println(118);
1002 acc8= constant 118
1003 call writeLineAcc8
1004 ;test2.j(230)   println(119);
1005 acc8= constant 119
1006 call writeLineAcc8
1007 ;test2.j(231) 
1008 ;test2.j(232)   /************************/
1009 ;test2.j(233)   // acc - stack16
1010 ;test2.j(234)   // byte - byte
1011 ;test2.j(235)   println(120);
1012 acc8= constant 120
1013 call writeLineAcc8
1014 ;test2.j(236)   println(121);
1015 acc8= constant 121
1016 call writeLineAcc8
1017 ;test2.j(237)   // acc - stack16
1018 ;test2.j(238)   // byte - integer
1019 ;test2.j(239)   println(122);
1020 acc8= constant 122
1021 call writeLineAcc8
1022 ;test2.j(240)   println(123);
1023 acc8= constant 123
1024 call writeLineAcc8
1025 ;test2.j(241)   // acc - stack16
1026 ;test2.j(242)   // integer - byte
1027 ;test2.j(243)   println(124);
1028 acc8= constant 124
1029 call writeLineAcc8
1030 ;test2.j(244)   println(125);
1031 acc8= constant 125
1032 call writeLineAcc8
1033 ;test2.j(245)   // acc - stack16
1034 ;test2.j(246)   // integer - integer
1035 ;test2.j(247)   println(126);
1036 acc8= constant 126
1037 call writeLineAcc8
1038 ;test2.j(248)   println(127);
1039 acc8= constant 127
1040 call writeLineAcc8
1041 ;test2.j(249)   println(128);
1042 acc8= constant 128
1043 call writeLineAcc8
1044 ;test2.j(250)   println(129);
1045 acc8= constant 129
1046 call writeLineAcc8
1047 ;test2.j(251) 
1048 ;test2.j(252)   /************************/
1049 ;test2.j(253)   // var - constant
1050 ;test2.j(254)   // byte - byte
1051 ;test2.j(255)   if (b > 10) println(130); else println(999);
1052 acc8= variable 6
1053 acc8Comp constant 10
1054 brle 1058
1055 acc8= constant 130
1056 call writeLineAcc8
1057 br 1061
1058 acc16= constant 999
1059 call writeLineAcc16
1060 ;test2.j(256)   if (b < 30) println(131); else println(999);
1061 acc8= variable 6
1062 acc8Comp constant 30
1063 brge 1067
1064 acc8= constant 131
1065 call writeLineAcc8
1066 br 1072
1067 acc16= constant 999
1068 call writeLineAcc16
1069 ;test2.j(257)   // var - constant
1070 ;test2.j(258)   // byte - integer
1071 ;test2.j(259)   if (b > 1000) println(999); else println(132);
1072 acc8= variable 6
1073 acc16= constant 1000
1074 acc8CompareAcc16
1075 brle 1079
1076 acc16= constant 999
1077 call writeLineAcc16
1078 br 1082
1079 acc8= constant 132
1080 call writeLineAcc8
1081 ;test2.j(260)   if (b < 1000) println(133); else println(999);
1082 acc8= variable 6
1083 acc16= constant 1000
1084 acc8CompareAcc16
1085 brge 1089
1086 acc8= constant 133
1087 call writeLineAcc8
1088 br 1094
1089 acc16= constant 999
1090 call writeLineAcc16
1091 ;test2.j(261)   // var - constant
1092 ;test2.j(262)   // integer - byte
1093 ;test2.j(263)   if (i > 1000) println(134); else println(999);
1094 acc16= variable 0
1095 acc16Comp constant 1000
1096 brle 1100
1097 acc8= constant 134
1098 call writeLineAcc8
1099 br 1103
1100 acc16= constant 999
1101 call writeLineAcc16
1102 ;test2.j(264)   if (i < 3000) println(135); else println(999);
1103 acc16= variable 0
1104 acc16Comp constant 3000
1105 brge 1109
1106 acc8= constant 135
1107 call writeLineAcc8
1108 br 1114
1109 acc16= constant 999
1110 call writeLineAcc16
1111 ;test2.j(265)   // var - constant
1112 ;test2.j(266)   // integer - integer
1113 ;test2.j(267)   if (i > 1000) println(136); else println(999);
1114 acc16= variable 0
1115 acc16Comp constant 1000
1116 brle 1120
1117 acc8= constant 136
1118 call writeLineAcc8
1119 br 1123
1120 acc16= constant 999
1121 call writeLineAcc16
1122 ;test2.j(268)   if (i < 3000) println(137); else println(999);
1123 acc16= variable 0
1124 acc16Comp constant 3000
1125 brge 1129
1126 acc8= constant 137
1127 call writeLineAcc8
1128 br 1132
1129 acc16= constant 999
1130 call writeLineAcc16
1131 ;test2.j(269)   println(138);
1132 acc8= constant 138
1133 call writeLineAcc8
1134 ;test2.j(270)   println(139);
1135 acc8= constant 139
1136 call writeLineAcc8
1137 ;test2.j(271) 
1138 ;test2.j(272)   /************************/
1139 ;test2.j(273)   // var - acc
1140 ;test2.j(274)   // byte - byte
1141 ;test2.j(275)   if (b > 10+0) println(140); else println(999);
1142 acc8= constant 10
1143 acc8+ constant 0
1144 acc8Comp variable 6
1145 brge 1149
1146 acc8= constant 140
1147 call writeLineAcc8
1148 br 1152
1149 acc16= constant 999
1150 call writeLineAcc16
1151 ;test2.j(276)   if (b < 30+0) println(141); else println(999);
1152 acc8= constant 30
1153 acc8+ constant 0
1154 acc8Comp variable 6
1155 brle 1159
1156 acc8= constant 141
1157 call writeLineAcc8
1158 br 1164
1159 acc16= constant 999
1160 call writeLineAcc16
1161 ;test2.j(277)   // var - acc
1162 ;test2.j(278)   // byte - integer
1163 ;test2.j(279)   if (b > 1000+0) println(999); else println(142);
1164 acc16= constant 1000
1165 acc16+ constant 0
1166 acc8= variable 6
1167 acc8CompareAcc16
1168 brle 1172
1169 acc16= constant 999
1170 call writeLineAcc16
1171 br 1175
1172 acc8= constant 142
1173 call writeLineAcc8
1174 ;test2.j(280)   if (b < 1000+0) println(143); else println(999);
1175 acc16= constant 1000
1176 acc16+ constant 0
1177 acc8= variable 6
1178 acc8CompareAcc16
1179 brge 1183
1180 acc8= constant 143
1181 call writeLineAcc8
1182 br 1188
1183 acc16= constant 999
1184 call writeLineAcc16
1185 ;test2.j(281)   // var - acc
1186 ;test2.j(282)   // integer - byte
1187 ;test2.j(283)   if (i > 1000+0) println(144); else println(999);
1188 acc16= constant 1000
1189 acc16+ constant 0
1190 acc16Comp variable 0
1191 brge 1195
1192 acc8= constant 144
1193 call writeLineAcc8
1194 br 1198
1195 acc16= constant 999
1196 call writeLineAcc16
1197 ;test2.j(284)   if (i < 3000+0) println(145); else println(999);
1198 acc16= constant 3000
1199 acc16+ constant 0
1200 acc16Comp variable 0
1201 brle 1205
1202 acc8= constant 145
1203 call writeLineAcc8
1204 br 1210
1205 acc16= constant 999
1206 call writeLineAcc16
1207 ;test2.j(285)   // var - acc
1208 ;test2.j(286)   // integer - integer
1209 ;test2.j(287)   if (i > 1000+0) println(146); else println(999);
1210 acc16= constant 1000
1211 acc16+ constant 0
1212 acc16Comp variable 0
1213 brge 1217
1214 acc8= constant 146
1215 call writeLineAcc8
1216 br 1220
1217 acc16= constant 999
1218 call writeLineAcc16
1219 ;test2.j(288)   if (i < 3000+0) println(147); else println(999);
1220 acc16= constant 3000
1221 acc16+ constant 0
1222 acc16Comp variable 0
1223 brle 1227
1224 acc8= constant 147
1225 call writeLineAcc8
1226 br 1230
1227 acc16= constant 999
1228 call writeLineAcc16
1229 ;test2.j(289)   println(148);
1230 acc8= constant 148
1231 call writeLineAcc8
1232 ;test2.j(290)   println(149);
1233 acc8= constant 149
1234 call writeLineAcc8
1235 ;test2.j(291) 
1236 ;test2.j(292)   /************************/
1237 ;test2.j(293)   // var - var
1238 ;test2.j(294)   // byte - byte
1239 ;test2.j(295)   if (b > b1) println(150);
1240 acc8= variable 6
1241 acc8Comp variable 7
1242 brle 1246
1243 acc8= constant 150
1244 call writeLineAcc8
1245 ;test2.j(296)   if (b < b3) println(151);
1246 acc8= variable 6
1247 acc8Comp variable 8
1248 brge 1254
1249 acc8= constant 151
1250 call writeLineAcc8
1251 ;test2.j(297)   // var - var
1252 ;test2.j(298)   // byte - integer
1253 ;test2.j(299)   if (b > i1) println(999); else println(152);
1254 acc8= variable 6
1255 acc16= variable 2
1256 acc8CompareAcc16
1257 brle 1261
1258 acc16= constant 999
1259 call writeLineAcc16
1260 br 1264
1261 acc8= constant 152
1262 call writeLineAcc8
1263 ;test2.j(300)   if (b < i3) println(153);
1264 acc8= variable 6
1265 acc16= variable 4
1266 acc8CompareAcc16
1267 brge 1273
1268 acc8= constant 153
1269 call writeLineAcc8
1270 ;test2.j(301)   // var - var
1271 ;test2.j(302)   // integer - byte
1272 ;test2.j(303)   if (i > i1) println(154);
1273 acc16= variable 0
1274 acc16Comp variable 2
1275 brle 1279
1276 acc8= constant 154
1277 call writeLineAcc8
1278 ;test2.j(304)   if (i < i3) println(155);
1279 acc16= variable 0
1280 acc16Comp variable 4
1281 brge 1287
1282 acc8= constant 155
1283 call writeLineAcc8
1284 ;test2.j(305)   // var - var
1285 ;test2.j(306)   // integer - integer
1286 ;test2.j(307)   if (i > i1) println(156);
1287 acc16= variable 0
1288 acc16Comp variable 2
1289 brle 1293
1290 acc8= constant 156
1291 call writeLineAcc8
1292 ;test2.j(308)   if (i < i3) println(157);
1293 acc16= variable 0
1294 acc16Comp variable 4
1295 brge 1299
1296 acc8= constant 157
1297 call writeLineAcc8
1298 ;test2.j(309)   println(158);
1299 acc8= constant 158
1300 call writeLineAcc8
1301 ;test2.j(310)   println(159);
1302 acc8= constant 159
1303 call writeLineAcc8
1304 ;test2.j(311) 
1305 ;test2.j(312)   /************************/
1306 ;test2.j(313)   // var - stack8
1307 ;test2.j(314)   // byte - byte
1308 ;test2.j(315) 
1309 ;test2.j(316)   // var - stack8
1310 ;test2.j(317)   // byte - integer
1311 ;test2.j(318) 
1312 ;test2.j(319)   // var - stack8
1313 ;test2.j(320)   // integer - byte 
1314 ;test2.j(321) 
1315 ;test2.j(322)   // var - stack8
1316 ;test2.j(323)   // integer - integer
1317 ;test2.j(324) 
1318 ;test2.j(325)   /************************/
1319 ;test2.j(326)   // var - stack16
1320 ;test2.j(327)   // byte - byte
1321 ;test2.j(328) 
1322 ;test2.j(329)   // var - stack16
1323 ;test2.j(330)   // byte - integer
1324 ;test2.j(331) 
1325 ;test2.j(332)   // var - stack16
1326 ;test2.j(333)   // integer - byte
1327 ;test2.j(334) 
1328 ;test2.j(335)   // var - stack16
1329 ;test2.j(336)   // integer - integer
1330 ;test2.j(337) 
1331 ;test2.j(338)   /************************/
1332 ;test2.j(339)   // stack8 - constant
1333 ;test2.j(340)   // stack8 - acc
1334 ;test2.j(341)   // stack8 - var
1335 ;test2.j(342)   // stack8 - stack8
1336 ;test2.j(343)   // stack8 - stack16
1337 ;test2.j(344) 
1338 ;test2.j(345)   /************************/
1339 ;test2.j(346)   // stack16 - constant
1340 ;test2.j(347)   // stack16 - acc
1341 ;test2.j(348)   // stack16 - var
1342 ;test2.j(349)   // stack16 - stack8
1343 ;test2.j(350)   // stack16 - stack16
1344 ;test2.j(351) 
1345 ;test2.j(352)   println("Klaar");
1346 acc16= constant 1350
1347 writeLineString
1348 ;test2.j(353) }
1349 stop
1350 stringConstant 0 = "Klaar"
