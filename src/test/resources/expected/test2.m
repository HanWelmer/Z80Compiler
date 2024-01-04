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
  22 ;test2.j(10)     /*Possible operand types: 
  23 ;test2.j(11)      * constant, acc, var, stack8, stack16
  24 ;test2.j(12)      *Possible datatype combinations:
  25 ;test2.j(13)      * byte - byte
  26 ;test2.j(14)      * byte - integer
  27 ;test2.j(15)      * integer - byte
  28 ;test2.j(16)      * integer - integer
  29 ;test2.j(17)     */
  30 ;test2.j(18)   
  31 ;test2.j(19)     println(0);
  32 acc8= constant 0
  33 call writeLineAcc8
  34 ;test2.j(20)   
  35 ;test2.j(21)     /************************/
  36 ;test2.j(22)     // constant - constant
  37 ;test2.j(23)     // byte - byte
  38 ;test2.j(24)     if (1 == 1) println(1); else println(999);
  39 acc8= constant 1
  40 acc8Comp constant 1
  41 brne 45
  42 acc8= constant 1
  43 call writeLineAcc8
  44 br 48
  45 acc16= constant 999
  46 call writeLineAcc16
  47 ;test2.j(25)     if (1 != 0) println(2); else println(999);
  48 acc8= constant 1
  49 acc8Comp constant 0
  50 breq 54
  51 acc8= constant 2
  52 call writeLineAcc8
  53 br 57
  54 acc16= constant 999
  55 call writeLineAcc16
  56 ;test2.j(26)     if (1 >  0) println(3); else println(999);
  57 acc8= constant 1
  58 acc8Comp constant 0
  59 brle 63
  60 acc8= constant 3
  61 call writeLineAcc8
  62 br 66
  63 acc16= constant 999
  64 call writeLineAcc16
  65 ;test2.j(27)     if (1 >= 0) println(4); else println(999);
  66 acc8= constant 1
  67 acc8Comp constant 0
  68 brlt 72
  69 acc8= constant 4
  70 call writeLineAcc8
  71 br 75
  72 acc16= constant 999
  73 call writeLineAcc16
  74 ;test2.j(28)     if (1 >= 1) println(5); else println(999);
  75 acc8= constant 1
  76 acc8Comp constant 1
  77 brlt 81
  78 acc8= constant 5
  79 call writeLineAcc8
  80 br 84
  81 acc16= constant 999
  82 call writeLineAcc16
  83 ;test2.j(29)     if (1 <  2) println(6); else println(999);
  84 acc8= constant 1
  85 acc8Comp constant 2
  86 brge 90
  87 acc8= constant 6
  88 call writeLineAcc8
  89 br 93
  90 acc16= constant 999
  91 call writeLineAcc16
  92 ;test2.j(30)     if (1 <= 2) println(7); else println(999);
  93 acc8= constant 1
  94 acc8Comp constant 2
  95 brgt 99
  96 acc8= constant 7
  97 call writeLineAcc8
  98 br 102
  99 acc16= constant 999
 100 call writeLineAcc16
 101 ;test2.j(31)     if (1 <= 1) println(8); else println(999);
 102 acc8= constant 1
 103 acc8Comp constant 1
 104 brgt 108
 105 acc8= constant 8
 106 call writeLineAcc8
 107 br 111
 108 acc16= constant 999
 109 call writeLineAcc16
 110 ;test2.j(32)     println(9);
 111 acc8= constant 9
 112 call writeLineAcc8
 113 ;test2.j(33)   
 114 ;test2.j(34)     // constant - constant
 115 ;test2.j(35)     // byte - integer
 116 ;test2.j(36)     if (1 == 1000) println(999); else println(10);
 117 acc8= constant 1
 118 acc16= constant 1000
 119 acc8CompareAcc16
 120 brne 124
 121 acc16= constant 999
 122 call writeLineAcc16
 123 br 127
 124 acc8= constant 10
 125 call writeLineAcc8
 126 ;test2.j(37)     if (1 != 1000) println(11);  else println(999);
 127 acc8= constant 1
 128 acc16= constant 1000
 129 acc8CompareAcc16
 130 breq 134
 131 acc8= constant 11
 132 call writeLineAcc8
 133 br 137
 134 acc16= constant 999
 135 call writeLineAcc16
 136 ;test2.j(38)     if (1 >  1000) println(999); else println(12);
 137 acc8= constant 1
 138 acc16= constant 1000
 139 acc8CompareAcc16
 140 brle 144
 141 acc16= constant 999
 142 call writeLineAcc16
 143 br 147
 144 acc8= constant 12
 145 call writeLineAcc8
 146 ;test2.j(39)     if (1 >= 1000) println(999); else println(13);
 147 acc8= constant 1
 148 acc16= constant 1000
 149 acc8CompareAcc16
 150 brlt 154
 151 acc16= constant 999
 152 call writeLineAcc16
 153 br 157
 154 acc8= constant 13
 155 call writeLineAcc8
 156 ;test2.j(40)     if (1 >= 1000) println(999); else println(14);
 157 acc8= constant 1
 158 acc16= constant 1000
 159 acc8CompareAcc16
 160 brlt 164
 161 acc16= constant 999
 162 call writeLineAcc16
 163 br 167
 164 acc8= constant 14
 165 call writeLineAcc8
 166 ;test2.j(41)     if (1 <  2000) println(15);  else println(999);
 167 acc8= constant 1
 168 acc16= constant 2000
 169 acc8CompareAcc16
 170 brge 174
 171 acc8= constant 15
 172 call writeLineAcc8
 173 br 177
 174 acc16= constant 999
 175 call writeLineAcc16
 176 ;test2.j(42)     if (1 <= 2000) println(16);  else println(999);
 177 acc8= constant 1
 178 acc16= constant 2000
 179 acc8CompareAcc16
 180 brgt 184
 181 acc8= constant 16
 182 call writeLineAcc8
 183 br 187
 184 acc16= constant 999
 185 call writeLineAcc16
 186 ;test2.j(43)     if (1 <= 1000) println(17);  else println(999);
 187 acc8= constant 1
 188 acc16= constant 1000
 189 acc8CompareAcc16
 190 brgt 194
 191 acc8= constant 17
 192 call writeLineAcc8
 193 br 197
 194 acc16= constant 999
 195 call writeLineAcc16
 196 ;test2.j(44)     println(18);
 197 acc8= constant 18
 198 call writeLineAcc8
 199 ;test2.j(45)     println(19);
 200 acc8= constant 19
 201 call writeLineAcc8
 202 ;test2.j(46)   
 203 ;test2.j(47)     // constant - constant
 204 ;test2.j(48)     // integer - byte
 205 ;test2.j(49)     if (1000 == 1) println(999); else println(20);
 206 acc16= constant 1000
 207 acc8= constant 1
 208 acc16CompareAcc8
 209 brne 213
 210 acc16= constant 999
 211 call writeLineAcc16
 212 br 216
 213 acc8= constant 20
 214 call writeLineAcc8
 215 ;test2.j(50)     if (1000 != 0) println(21);  else println(999);
 216 acc16= constant 1000
 217 acc8= constant 0
 218 acc16CompareAcc8
 219 breq 223
 220 acc8= constant 21
 221 call writeLineAcc8
 222 br 226
 223 acc16= constant 999
 224 call writeLineAcc16
 225 ;test2.j(51)     if (1000 >  0) println(22);  else println(999);
 226 acc16= constant 1000
 227 acc8= constant 0
 228 acc16CompareAcc8
 229 brle 233
 230 acc8= constant 22
 231 call writeLineAcc8
 232 br 236
 233 acc16= constant 999
 234 call writeLineAcc16
 235 ;test2.j(52)     if (1000 >= 0) println(23);  else println(999);
 236 acc16= constant 1000
 237 acc8= constant 0
 238 acc16CompareAcc8
 239 brlt 243
 240 acc8= constant 23
 241 call writeLineAcc8
 242 br 246
 243 acc16= constant 999
 244 call writeLineAcc16
 245 ;test2.j(53)     if (1000 >= 1) println(24);  else println(999);
 246 acc16= constant 1000
 247 acc8= constant 1
 248 acc16CompareAcc8
 249 brlt 253
 250 acc8= constant 24
 251 call writeLineAcc8
 252 br 256
 253 acc16= constant 999
 254 call writeLineAcc16
 255 ;test2.j(54)     if (1 <  2000) println(25);  else println(999);
 256 acc8= constant 1
 257 acc16= constant 2000
 258 acc8CompareAcc16
 259 brge 263
 260 acc8= constant 25
 261 call writeLineAcc8
 262 br 266
 263 acc16= constant 999
 264 call writeLineAcc16
 265 ;test2.j(55)     if (1 <= 2000) println(26);  else println(999);
 266 acc8= constant 1
 267 acc16= constant 2000
 268 acc8CompareAcc16
 269 brgt 273
 270 acc8= constant 26
 271 call writeLineAcc8
 272 br 276
 273 acc16= constant 999
 274 call writeLineAcc16
 275 ;test2.j(56)     if (1 <= 1000) println(27);  else println(999);
 276 acc8= constant 1
 277 acc16= constant 1000
 278 acc8CompareAcc16
 279 brgt 283
 280 acc8= constant 27
 281 call writeLineAcc8
 282 br 286
 283 acc16= constant 999
 284 call writeLineAcc16
 285 ;test2.j(57)     println(28);
 286 acc8= constant 28
 287 call writeLineAcc8
 288 ;test2.j(58)     println(29);
 289 acc8= constant 29
 290 call writeLineAcc8
 291 ;test2.j(59)   
 292 ;test2.j(60)     // constant - constant
 293 ;test2.j(61)     // integer - integer
 294 ;test2.j(62)     if (1000 == 1000) println(30); else println(999);
 295 acc16= constant 1000
 296 acc16Comp constant 1000
 297 brne 301
 298 acc8= constant 30
 299 call writeLineAcc8
 300 br 304
 301 acc16= constant 999
 302 call writeLineAcc16
 303 ;test2.j(63)     if (1000 != 2000) println(31); else println(999);
 304 acc16= constant 1000
 305 acc16Comp constant 2000
 306 breq 310
 307 acc8= constant 31
 308 call writeLineAcc8
 309 br 313
 310 acc16= constant 999
 311 call writeLineAcc16
 312 ;test2.j(64)     if (2000 >  1000) println(32); else println(999);
 313 acc16= constant 2000
 314 acc16Comp constant 1000
 315 brle 319
 316 acc8= constant 32
 317 call writeLineAcc8
 318 br 322
 319 acc16= constant 999
 320 call writeLineAcc16
 321 ;test2.j(65)     if (2000 >= 1000) println(33); else println(999);
 322 acc16= constant 2000
 323 acc16Comp constant 1000
 324 brlt 328
 325 acc8= constant 33
 326 call writeLineAcc8
 327 br 331
 328 acc16= constant 999
 329 call writeLineAcc16
 330 ;test2.j(66)     if (1000 >= 1000) println(34); else println(999);
 331 acc16= constant 1000
 332 acc16Comp constant 1000
 333 brlt 337
 334 acc8= constant 34
 335 call writeLineAcc8
 336 br 340
 337 acc16= constant 999
 338 call writeLineAcc16
 339 ;test2.j(67)     if (1000 <  2000) println(35); else println(999);
 340 acc16= constant 1000
 341 acc16Comp constant 2000
 342 brge 346
 343 acc8= constant 35
 344 call writeLineAcc8
 345 br 349
 346 acc16= constant 999
 347 call writeLineAcc16
 348 ;test2.j(68)     if (1000 <= 2000) println(36); else println(999);
 349 acc16= constant 1000
 350 acc16Comp constant 2000
 351 brgt 355
 352 acc8= constant 36
 353 call writeLineAcc8
 354 br 358
 355 acc16= constant 999
 356 call writeLineAcc16
 357 ;test2.j(69)     if (1000 <= 1000) println(37); else println(999);
 358 acc16= constant 1000
 359 acc16Comp constant 1000
 360 brgt 364
 361 acc8= constant 37
 362 call writeLineAcc8
 363 br 367
 364 acc16= constant 999
 365 call writeLineAcc16
 366 ;test2.j(70)     println(38);
 367 acc8= constant 38
 368 call writeLineAcc8
 369 ;test2.j(71)     println(39);
 370 acc8= constant 39
 371 call writeLineAcc8
 372 ;test2.j(72)   
 373 ;test2.j(73)     /************************/
 374 ;test2.j(74)     // constant - acc
 375 ;test2.j(75)     // byte - byte
 376 ;test2.j(76)     if (1 > 0+0) println(40); else println(999);
 377 acc8= constant 0
 378 acc8+ constant 0
 379 acc8Comp constant 1
 380 brge 384
 381 acc8= constant 40
 382 call writeLineAcc8
 383 br 387
 384 acc16= constant 999
 385 call writeLineAcc16
 386 ;test2.j(77)     if (1 < 2+0) println(41); else println(999);
 387 acc8= constant 2
 388 acc8+ constant 0
 389 acc8Comp constant 1
 390 brle 394
 391 acc8= constant 41
 392 call writeLineAcc8
 393 br 399
 394 acc16= constant 999
 395 call writeLineAcc16
 396 ;test2.j(78)     // constant - acc
 397 ;test2.j(79)     // byte - integer
 398 ;test2.j(80)     if (1 > 1000+0) println(999); else println(42);
 399 acc16= constant 1000
 400 acc16+ constant 0
 401 acc8= constant 1
 402 acc8CompareAcc16
 403 brle 407
 404 acc16= constant 999
 405 call writeLineAcc16
 406 br 410
 407 acc8= constant 42
 408 call writeLineAcc8
 409 ;test2.j(81)     if (1 < 1000+0) println(43);  else println(999);
 410 acc16= constant 1000
 411 acc16+ constant 0
 412 acc8= constant 1
 413 acc8CompareAcc16
 414 brge 418
 415 acc8= constant 43
 416 call writeLineAcc8
 417 br 423
 418 acc16= constant 999
 419 call writeLineAcc16
 420 ;test2.j(82)     // constant - acc
 421 ;test2.j(83)     // integer - byte
 422 ;test2.j(84)     if (1000 > 0+0) println(44);  else println(999);
 423 acc8= constant 0
 424 acc8+ constant 0
 425 acc16= constant 1000
 426 acc16CompareAcc8
 427 brle 431
 428 acc8= constant 44
 429 call writeLineAcc8
 430 br 434
 431 acc16= constant 999
 432 call writeLineAcc16
 433 ;test2.j(85)     if (1000 < 0+0) println(999); else println(45);
 434 acc8= constant 0
 435 acc8+ constant 0
 436 acc16= constant 1000
 437 acc16CompareAcc8
 438 brge 442
 439 acc16= constant 999
 440 call writeLineAcc16
 441 br 447
 442 acc8= constant 45
 443 call writeLineAcc8
 444 ;test2.j(86)     // constant - acc
 445 ;test2.j(87)     // integer - integer
 446 ;test2.j(88)     if (2000 > 1000+0) println(46); else println(999);
 447 acc16= constant 1000
 448 acc16+ constant 0
 449 acc16Comp constant 2000
 450 brge 454
 451 acc8= constant 46
 452 call writeLineAcc8
 453 br 457
 454 acc16= constant 999
 455 call writeLineAcc16
 456 ;test2.j(89)     if (1000 < 2000+0) println(47); else println(999);
 457 acc16= constant 2000
 458 acc16+ constant 0
 459 acc16Comp constant 1000
 460 brle 464
 461 acc8= constant 47
 462 call writeLineAcc8
 463 br 467
 464 acc16= constant 999
 465 call writeLineAcc16
 466 ;test2.j(90)     println(48);
 467 acc8= constant 48
 468 call writeLineAcc8
 469 ;test2.j(91)     println(49);
 470 acc8= constant 49
 471 call writeLineAcc8
 472 ;test2.j(92)   
 473 ;test2.j(93)     /************************/
 474 ;test2.j(94)     // constant - var
 475 ;test2.j(95)     // byte - byte
 476 ;test2.j(96)     if (30 > b) println(50); else println(999);
 477 acc8= variable 6
 478 acc8Comp constant 30
 479 brge 483
 480 acc8= constant 50
 481 call writeLineAcc8
 482 br 486
 483 acc16= constant 999
 484 call writeLineAcc16
 485 ;test2.j(97)     if (10 < b) println(51); else println(999);
 486 acc8= variable 6
 487 acc8Comp constant 10
 488 brle 492
 489 acc8= constant 51
 490 call writeLineAcc8
 491 br 497
 492 acc16= constant 999
 493 call writeLineAcc16
 494 ;test2.j(98)     // constant - var
 495 ;test2.j(99)     // byte - integer
 496 ;test2.j(100)     if (30 > i) println(999); else println(52);
 497 acc16= variable 0
 498 acc8= constant 30
 499 acc8CompareAcc16
 500 brle 504
 501 acc16= constant 999
 502 call writeLineAcc16
 503 br 507
 504 acc8= constant 52
 505 call writeLineAcc8
 506 ;test2.j(101)     if (10 < i) println(53); else println(999);
 507 acc16= variable 0
 508 acc8= constant 10
 509 acc8CompareAcc16
 510 brge 514
 511 acc8= constant 53
 512 call writeLineAcc8
 513 br 519
 514 acc16= constant 999
 515 call writeLineAcc16
 516 ;test2.j(102)     // constant - var
 517 ;test2.j(103)     // integer - byte
 518 ;test2.j(104)     if (3000 > b) println(54); else println(999);
 519 acc8= variable 6
 520 acc16= constant 3000
 521 acc16CompareAcc8
 522 brle 526
 523 acc8= constant 54
 524 call writeLineAcc8
 525 br 529
 526 acc16= constant 999
 527 call writeLineAcc16
 528 ;test2.j(105)     if (1000 < b) println(999); else println(55);
 529 acc8= variable 6
 530 acc16= constant 1000
 531 acc16CompareAcc8
 532 brge 536
 533 acc16= constant 999
 534 call writeLineAcc16
 535 br 541
 536 acc8= constant 55
 537 call writeLineAcc8
 538 ;test2.j(106)     // constant - var
 539 ;test2.j(107)     // integer - integer
 540 ;test2.j(108)     if (3000 > i) println(56); else println(999);
 541 acc16= variable 0
 542 acc16Comp constant 3000
 543 brge 547
 544 acc8= constant 56
 545 call writeLineAcc8
 546 br 550
 547 acc16= constant 999
 548 call writeLineAcc16
 549 ;test2.j(109)     if (1000 < i) println(57); else println(999);
 550 acc16= variable 0
 551 acc16Comp constant 1000
 552 brle 556
 553 acc8= constant 57
 554 call writeLineAcc8
 555 br 559
 556 acc16= constant 999
 557 call writeLineAcc16
 558 ;test2.j(110)     println(58);
 559 acc8= constant 58
 560 call writeLineAcc8
 561 ;test2.j(111)     println(59);
 562 acc8= constant 59
 563 call writeLineAcc8
 564 ;test2.j(112)   
 565 ;test2.j(113)     /************************/
 566 ;test2.j(114)     // constant - stack8
 567 ;test2.j(115)     // byte - byte
 568 ;test2.j(116)     println(60);
 569 acc8= constant 60
 570 call writeLineAcc8
 571 ;test2.j(117)     println(61);
 572 acc8= constant 61
 573 call writeLineAcc8
 574 ;test2.j(118)     // constant - stack8
 575 ;test2.j(119)     // byte - integer
 576 ;test2.j(120)     println(62);
 577 acc8= constant 62
 578 call writeLineAcc8
 579 ;test2.j(121)     println(63);
 580 acc8= constant 63
 581 call writeLineAcc8
 582 ;test2.j(122)     // constant - stack8
 583 ;test2.j(123)     // integer - byte
 584 ;test2.j(124)     println(64);
 585 acc8= constant 64
 586 call writeLineAcc8
 587 ;test2.j(125)     println(65);
 588 acc8= constant 65
 589 call writeLineAcc8
 590 ;test2.j(126)     // constant - stack8
 591 ;test2.j(127)     // integer - integer
 592 ;test2.j(128)     println(66);
 593 acc8= constant 66
 594 call writeLineAcc8
 595 ;test2.j(129)     println(67);
 596 acc8= constant 67
 597 call writeLineAcc8
 598 ;test2.j(130)     println(68);
 599 acc8= constant 68
 600 call writeLineAcc8
 601 ;test2.j(131)     println(69);
 602 acc8= constant 69
 603 call writeLineAcc8
 604 ;test2.j(132)   
 605 ;test2.j(133)     /************************/
 606 ;test2.j(134)     // constant - stack16
 607 ;test2.j(135)     // byte - byte
 608 ;test2.j(136)     println(70);
 609 acc8= constant 70
 610 call writeLineAcc8
 611 ;test2.j(137)     println(71);
 612 acc8= constant 71
 613 call writeLineAcc8
 614 ;test2.j(138)     // constant - stack16
 615 ;test2.j(139)     // byte - integer
 616 ;test2.j(140)     println(72);
 617 acc8= constant 72
 618 call writeLineAcc8
 619 ;test2.j(141)     println(73);
 620 acc8= constant 73
 621 call writeLineAcc8
 622 ;test2.j(142)     // constant - stack16
 623 ;test2.j(143)     // integer - byte
 624 ;test2.j(144)     println(74);
 625 acc8= constant 74
 626 call writeLineAcc8
 627 ;test2.j(145)     println(75);
 628 acc8= constant 75
 629 call writeLineAcc8
 630 ;test2.j(146)     // constant - stack16
 631 ;test2.j(147)     // integer - integer
 632 ;test2.j(148)     println(76);
 633 acc8= constant 76
 634 call writeLineAcc8
 635 ;test2.j(149)     println(77);
 636 acc8= constant 77
 637 call writeLineAcc8
 638 ;test2.j(150)     println(78);
 639 acc8= constant 78
 640 call writeLineAcc8
 641 ;test2.j(151)     println(79);
 642 acc8= constant 79
 643 call writeLineAcc8
 644 ;test2.j(152)   
 645 ;test2.j(153)     /************************/
 646 ;test2.j(154)     // acc - constant
 647 ;test2.j(155)     // byte - byte
 648 ;test2.j(156)     if (30+0 > 20) println(80); else println(999);
 649 acc8= constant 30
 650 acc8+ constant 0
 651 acc8Comp constant 20
 652 brle 656
 653 acc8= constant 80
 654 call writeLineAcc8
 655 br 659
 656 acc16= constant 999
 657 call writeLineAcc16
 658 ;test2.j(157)     if (10+0 < 20) println(81); else println(999);
 659 acc8= constant 10
 660 acc8+ constant 0
 661 acc8Comp constant 20
 662 brge 666
 663 acc8= constant 81
 664 call writeLineAcc8
 665 br 671
 666 acc16= constant 999
 667 call writeLineAcc16
 668 ;test2.j(158)     // acc - constant
 669 ;test2.j(159)     // byte - integer
 670 ;test2.j(160)     if (30+0 > 2000) println(999); else println(82);
 671 acc8= constant 30
 672 acc8+ constant 0
 673 acc16= constant 2000
 674 acc8CompareAcc16
 675 brle 679
 676 acc16= constant 999
 677 call writeLineAcc16
 678 br 682
 679 acc8= constant 82
 680 call writeLineAcc8
 681 ;test2.j(161)     if (10+0 < 2000) println(83); else println(999);
 682 acc8= constant 10
 683 acc8+ constant 0
 684 acc16= constant 2000
 685 acc8CompareAcc16
 686 brge 690
 687 acc8= constant 83
 688 call writeLineAcc8
 689 br 695
 690 acc16= constant 999
 691 call writeLineAcc16
 692 ;test2.j(162)     // acc - constant
 693 ;test2.j(163)     // integer - byte
 694 ;test2.j(164)     if (3000+0 > 20) println(84); else println(999);
 695 acc16= constant 3000
 696 acc16+ constant 0
 697 acc8= constant 20
 698 acc16CompareAcc8
 699 brle 703
 700 acc8= constant 84
 701 call writeLineAcc8
 702 br 706
 703 acc16= constant 999
 704 call writeLineAcc16
 705 ;test2.j(165)     if (1000+0 < 20) println(999); else println(85);
 706 acc16= constant 1000
 707 acc16+ constant 0
 708 acc8= constant 20
 709 acc16CompareAcc8
 710 brge 714
 711 acc16= constant 999
 712 call writeLineAcc16
 713 br 719
 714 acc8= constant 85
 715 call writeLineAcc8
 716 ;test2.j(166)     // acc - constant
 717 ;test2.j(167)     // integer - integer
 718 ;test2.j(168)     if (3000+0 > 2000) println(86); else println(999);
 719 acc16= constant 3000
 720 acc16+ constant 0
 721 acc16Comp constant 2000
 722 brle 726
 723 acc8= constant 86
 724 call writeLineAcc8
 725 br 729
 726 acc16= constant 999
 727 call writeLineAcc16
 728 ;test2.j(169)     if (1000+0 < 2000) println(87); else println(999);
 729 acc16= constant 1000
 730 acc16+ constant 0
 731 acc16Comp constant 2000
 732 brge 736
 733 acc8= constant 87
 734 call writeLineAcc8
 735 br 739
 736 acc16= constant 999
 737 call writeLineAcc16
 738 ;test2.j(170)     println(88);
 739 acc8= constant 88
 740 call writeLineAcc8
 741 ;test2.j(171)     println(89);
 742 acc8= constant 89
 743 call writeLineAcc8
 744 ;test2.j(172)   
 745 ;test2.j(173)     /************************/
 746 ;test2.j(174)     // acc - acc
 747 ;test2.j(175)     // byte - byte
 748 ;test2.j(176)     if (30+0 > 20+0) println(90); else println(999);
 749 acc8= constant 30
 750 acc8+ constant 0
 751 <acc8
 752 acc8= constant 20
 753 acc8+ constant 0
 754 revAcc8Comp unstack8
 755 brge 759
 756 acc8= constant 90
 757 call writeLineAcc8
 758 br 762
 759 acc16= constant 999
 760 call writeLineAcc16
 761 ;test2.j(177)     if (10+0 < 20+0) println(91); else println(999);
 762 acc8= constant 10
 763 acc8+ constant 0
 764 <acc8
 765 acc8= constant 20
 766 acc8+ constant 0
 767 revAcc8Comp unstack8
 768 brle 772
 769 acc8= constant 91
 770 call writeLineAcc8
 771 br 777
 772 acc16= constant 999
 773 call writeLineAcc16
 774 ;test2.j(178)     // acc - acc
 775 ;test2.j(179)     // byte - integer
 776 ;test2.j(180)     if (30+0 > 2000+0) println(999); else println(92);
 777 acc8= constant 30
 778 acc8+ constant 0
 779 <acc8
 780 acc16= constant 2000
 781 acc16+ constant 0
 782 acc8= unstack8
 783 acc8CompareAcc16
 784 brle 788
 785 acc16= constant 999
 786 call writeLineAcc16
 787 br 791
 788 acc8= constant 92
 789 call writeLineAcc8
 790 ;test2.j(181)     if (10+0 < 2000+0) println(93); else println(999);
 791 acc8= constant 10
 792 acc8+ constant 0
 793 <acc8
 794 acc16= constant 2000
 795 acc16+ constant 0
 796 acc8= unstack8
 797 acc8CompareAcc16
 798 brge 802
 799 acc8= constant 93
 800 call writeLineAcc8
 801 br 807
 802 acc16= constant 999
 803 call writeLineAcc16
 804 ;test2.j(182)     // acc - acc
 805 ;test2.j(183)     // integer - byte
 806 ;test2.j(184)     if (3000+0 > 20+0) println(94); else println(999);
 807 acc16= constant 3000
 808 acc16+ constant 0
 809 <acc16
 810 acc8= constant 20
 811 acc8+ constant 0
 812 acc16= unstack16
 813 acc16CompareAcc8
 814 brle 818
 815 acc8= constant 94
 816 call writeLineAcc8
 817 br 821
 818 acc16= constant 999
 819 call writeLineAcc16
 820 ;test2.j(185)     if (1000+0 < 20+0) println(999); else println(95);
 821 acc16= constant 1000
 822 acc16+ constant 0
 823 <acc16
 824 acc8= constant 20
 825 acc8+ constant 0
 826 acc16= unstack16
 827 acc16CompareAcc8
 828 brge 832
 829 acc16= constant 999
 830 call writeLineAcc16
 831 br 837
 832 acc8= constant 95
 833 call writeLineAcc8
 834 ;test2.j(186)     // acc - acc
 835 ;test2.j(187)     // integer - integer
 836 ;test2.j(188)     if (3000+0 > 2000+0) println(96); else println(999);
 837 acc16= constant 3000
 838 acc16+ constant 0
 839 <acc16
 840 acc16= constant 2000
 841 acc16+ constant 0
 842 revAcc16Comp unstack16
 843 brge 847
 844 acc8= constant 96
 845 call writeLineAcc8
 846 br 850
 847 acc16= constant 999
 848 call writeLineAcc16
 849 ;test2.j(189)     if (1000+0 < 2000+0) println(97); else println(999);
 850 acc16= constant 1000
 851 acc16+ constant 0
 852 <acc16
 853 acc16= constant 2000
 854 acc16+ constant 0
 855 revAcc16Comp unstack16
 856 brle 860
 857 acc8= constant 97
 858 call writeLineAcc8
 859 br 863
 860 acc16= constant 999
 861 call writeLineAcc16
 862 ;test2.j(190)     println(98);
 863 acc8= constant 98
 864 call writeLineAcc8
 865 ;test2.j(191)     println(99);
 866 acc8= constant 99
 867 call writeLineAcc8
 868 ;test2.j(192)   
 869 ;test2.j(193)     /************************/
 870 ;test2.j(194)     // acc - var
 871 ;test2.j(195)     // byte - byte
 872 ;test2.j(196)     if (30+0 > b) println(100); else println(999);
 873 acc8= constant 30
 874 acc8+ constant 0
 875 acc8Comp variable 6
 876 brle 880
 877 acc8= constant 100
 878 call writeLineAcc8
 879 br 883
 880 acc16= constant 999
 881 call writeLineAcc16
 882 ;test2.j(197)     if (10+0 < b) println(101); else println(999);
 883 acc8= constant 10
 884 acc8+ constant 0
 885 acc8Comp variable 6
 886 brge 890
 887 acc8= constant 101
 888 call writeLineAcc8
 889 br 895
 890 acc16= constant 999
 891 call writeLineAcc16
 892 ;test2.j(198)     // acc - var
 893 ;test2.j(199)     // byte - integer
 894 ;test2.j(200)     if (30+0 > i) println(999); else println(102);
 895 acc8= constant 30
 896 acc8+ constant 0
 897 acc16= variable 0
 898 acc8CompareAcc16
 899 brle 903
 900 acc16= constant 999
 901 call writeLineAcc16
 902 br 906
 903 acc8= constant 102
 904 call writeLineAcc8
 905 ;test2.j(201)     if (10+0 < i) println(103); else println(999);
 906 acc8= constant 10
 907 acc8+ constant 0
 908 acc16= variable 0
 909 acc8CompareAcc16
 910 brge 914
 911 acc8= constant 103
 912 call writeLineAcc8
 913 br 919
 914 acc16= constant 999
 915 call writeLineAcc16
 916 ;test2.j(202)     // acc - var
 917 ;test2.j(203)     // integer - byte
 918 ;test2.j(204)     if (3000+0 > b) println(104); else println(999);
 919 acc16= constant 3000
 920 acc16+ constant 0
 921 acc8= variable 6
 922 acc16CompareAcc8
 923 brle 927
 924 acc8= constant 104
 925 call writeLineAcc8
 926 br 930
 927 acc16= constant 999
 928 call writeLineAcc16
 929 ;test2.j(205)     if (1000+0 < b) println(999); else println(105);
 930 acc16= constant 1000
 931 acc16+ constant 0
 932 acc8= variable 6
 933 acc16CompareAcc8
 934 brge 938
 935 acc16= constant 999
 936 call writeLineAcc16
 937 br 943
 938 acc8= constant 105
 939 call writeLineAcc8
 940 ;test2.j(206)     // acc - var
 941 ;test2.j(207)     // integer - integer
 942 ;test2.j(208)     if (3000+0 > i) println(106); else println(999);
 943 acc16= constant 3000
 944 acc16+ constant 0
 945 acc16Comp variable 0
 946 brle 950
 947 acc8= constant 106
 948 call writeLineAcc8
 949 br 953
 950 acc16= constant 999
 951 call writeLineAcc16
 952 ;test2.j(209)     if (1000+0 < i) println(107); else println(999);
 953 acc16= constant 1000
 954 acc16+ constant 0
 955 acc16Comp variable 0
 956 brge 960
 957 acc8= constant 107
 958 call writeLineAcc8
 959 br 963
 960 acc16= constant 999
 961 call writeLineAcc16
 962 ;test2.j(210)     println(108);
 963 acc8= constant 108
 964 call writeLineAcc8
 965 ;test2.j(211)     println(109);
 966 acc8= constant 109
 967 call writeLineAcc8
 968 ;test2.j(212)   
 969 ;test2.j(213)     /************************/
 970 ;test2.j(214)     // acc - stack8
 971 ;test2.j(215)     // byte - byte
 972 ;test2.j(216)     println(110);
 973 acc8= constant 110
 974 call writeLineAcc8
 975 ;test2.j(217)     println(111);
 976 acc8= constant 111
 977 call writeLineAcc8
 978 ;test2.j(218)     // acc - stack8
 979 ;test2.j(219)     // byte - integer
 980 ;test2.j(220)     println(112);
 981 acc8= constant 112
 982 call writeLineAcc8
 983 ;test2.j(221)     println(113);
 984 acc8= constant 113
 985 call writeLineAcc8
 986 ;test2.j(222)     // acc - stack8
 987 ;test2.j(223)     // integer - byte
 988 ;test2.j(224)     println(114);
 989 acc8= constant 114
 990 call writeLineAcc8
 991 ;test2.j(225)     println(115);
 992 acc8= constant 115
 993 call writeLineAcc8
 994 ;test2.j(226)     // acc - stack8
 995 ;test2.j(227)     // integer - integer
 996 ;test2.j(228)     println(116);
 997 acc8= constant 116
 998 call writeLineAcc8
 999 ;test2.j(229)     println(117);
1000 acc8= constant 117
1001 call writeLineAcc8
1002 ;test2.j(230)     println(118);
1003 acc8= constant 118
1004 call writeLineAcc8
1005 ;test2.j(231)     println(119);
1006 acc8= constant 119
1007 call writeLineAcc8
1008 ;test2.j(232)   
1009 ;test2.j(233)     /************************/
1010 ;test2.j(234)     // acc - stack16
1011 ;test2.j(235)     // byte - byte
1012 ;test2.j(236)     println(120);
1013 acc8= constant 120
1014 call writeLineAcc8
1015 ;test2.j(237)     println(121);
1016 acc8= constant 121
1017 call writeLineAcc8
1018 ;test2.j(238)     // acc - stack16
1019 ;test2.j(239)     // byte - integer
1020 ;test2.j(240)     println(122);
1021 acc8= constant 122
1022 call writeLineAcc8
1023 ;test2.j(241)     println(123);
1024 acc8= constant 123
1025 call writeLineAcc8
1026 ;test2.j(242)     // acc - stack16
1027 ;test2.j(243)     // integer - byte
1028 ;test2.j(244)     println(124);
1029 acc8= constant 124
1030 call writeLineAcc8
1031 ;test2.j(245)     println(125);
1032 acc8= constant 125
1033 call writeLineAcc8
1034 ;test2.j(246)     // acc - stack16
1035 ;test2.j(247)     // integer - integer
1036 ;test2.j(248)     println(126);
1037 acc8= constant 126
1038 call writeLineAcc8
1039 ;test2.j(249)     println(127);
1040 acc8= constant 127
1041 call writeLineAcc8
1042 ;test2.j(250)     println(128);
1043 acc8= constant 128
1044 call writeLineAcc8
1045 ;test2.j(251)     println(129);
1046 acc8= constant 129
1047 call writeLineAcc8
1048 ;test2.j(252)   
1049 ;test2.j(253)     /************************/
1050 ;test2.j(254)     // var - constant
1051 ;test2.j(255)     // byte - byte
1052 ;test2.j(256)     if (b > 10) println(130); else println(999);
1053 acc8= variable 6
1054 acc8Comp constant 10
1055 brle 1059
1056 acc8= constant 130
1057 call writeLineAcc8
1058 br 1062
1059 acc16= constant 999
1060 call writeLineAcc16
1061 ;test2.j(257)     if (b < 30) println(131); else println(999);
1062 acc8= variable 6
1063 acc8Comp constant 30
1064 brge 1068
1065 acc8= constant 131
1066 call writeLineAcc8
1067 br 1073
1068 acc16= constant 999
1069 call writeLineAcc16
1070 ;test2.j(258)     // var - constant
1071 ;test2.j(259)     // byte - integer
1072 ;test2.j(260)     if (b > 1000) println(999); else println(132);
1073 acc8= variable 6
1074 acc16= constant 1000
1075 acc8CompareAcc16
1076 brle 1080
1077 acc16= constant 999
1078 call writeLineAcc16
1079 br 1083
1080 acc8= constant 132
1081 call writeLineAcc8
1082 ;test2.j(261)     if (b < 1000) println(133); else println(999);
1083 acc8= variable 6
1084 acc16= constant 1000
1085 acc8CompareAcc16
1086 brge 1090
1087 acc8= constant 133
1088 call writeLineAcc8
1089 br 1095
1090 acc16= constant 999
1091 call writeLineAcc16
1092 ;test2.j(262)     // var - constant
1093 ;test2.j(263)     // integer - byte
1094 ;test2.j(264)     if (i > 1000) println(134); else println(999);
1095 acc16= variable 0
1096 acc16Comp constant 1000
1097 brle 1101
1098 acc8= constant 134
1099 call writeLineAcc8
1100 br 1104
1101 acc16= constant 999
1102 call writeLineAcc16
1103 ;test2.j(265)     if (i < 3000) println(135); else println(999);
1104 acc16= variable 0
1105 acc16Comp constant 3000
1106 brge 1110
1107 acc8= constant 135
1108 call writeLineAcc8
1109 br 1115
1110 acc16= constant 999
1111 call writeLineAcc16
1112 ;test2.j(266)     // var - constant
1113 ;test2.j(267)     // integer - integer
1114 ;test2.j(268)     if (i > 1000) println(136); else println(999);
1115 acc16= variable 0
1116 acc16Comp constant 1000
1117 brle 1121
1118 acc8= constant 136
1119 call writeLineAcc8
1120 br 1124
1121 acc16= constant 999
1122 call writeLineAcc16
1123 ;test2.j(269)     if (i < 3000) println(137); else println(999);
1124 acc16= variable 0
1125 acc16Comp constant 3000
1126 brge 1130
1127 acc8= constant 137
1128 call writeLineAcc8
1129 br 1133
1130 acc16= constant 999
1131 call writeLineAcc16
1132 ;test2.j(270)     println(138);
1133 acc8= constant 138
1134 call writeLineAcc8
1135 ;test2.j(271)     println(139);
1136 acc8= constant 139
1137 call writeLineAcc8
1138 ;test2.j(272)   
1139 ;test2.j(273)     /************************/
1140 ;test2.j(274)     // var - acc
1141 ;test2.j(275)     // byte - byte
1142 ;test2.j(276)     if (b > 10+0) println(140); else println(999);
1143 acc8= constant 10
1144 acc8+ constant 0
1145 acc8Comp variable 6
1146 brge 1150
1147 acc8= constant 140
1148 call writeLineAcc8
1149 br 1153
1150 acc16= constant 999
1151 call writeLineAcc16
1152 ;test2.j(277)     if (b < 30+0) println(141); else println(999);
1153 acc8= constant 30
1154 acc8+ constant 0
1155 acc8Comp variable 6
1156 brle 1160
1157 acc8= constant 141
1158 call writeLineAcc8
1159 br 1165
1160 acc16= constant 999
1161 call writeLineAcc16
1162 ;test2.j(278)     // var - acc
1163 ;test2.j(279)     // byte - integer
1164 ;test2.j(280)     if (b > 1000+0) println(999); else println(142);
1165 acc16= constant 1000
1166 acc16+ constant 0
1167 acc8= variable 6
1168 acc8CompareAcc16
1169 brle 1173
1170 acc16= constant 999
1171 call writeLineAcc16
1172 br 1176
1173 acc8= constant 142
1174 call writeLineAcc8
1175 ;test2.j(281)     if (b < 1000+0) println(143); else println(999);
1176 acc16= constant 1000
1177 acc16+ constant 0
1178 acc8= variable 6
1179 acc8CompareAcc16
1180 brge 1184
1181 acc8= constant 143
1182 call writeLineAcc8
1183 br 1189
1184 acc16= constant 999
1185 call writeLineAcc16
1186 ;test2.j(282)     // var - acc
1187 ;test2.j(283)     // integer - byte
1188 ;test2.j(284)     if (i > 1000+0) println(144); else println(999);
1189 acc16= constant 1000
1190 acc16+ constant 0
1191 acc16Comp variable 0
1192 brge 1196
1193 acc8= constant 144
1194 call writeLineAcc8
1195 br 1199
1196 acc16= constant 999
1197 call writeLineAcc16
1198 ;test2.j(285)     if (i < 3000+0) println(145); else println(999);
1199 acc16= constant 3000
1200 acc16+ constant 0
1201 acc16Comp variable 0
1202 brle 1206
1203 acc8= constant 145
1204 call writeLineAcc8
1205 br 1211
1206 acc16= constant 999
1207 call writeLineAcc16
1208 ;test2.j(286)     // var - acc
1209 ;test2.j(287)     // integer - integer
1210 ;test2.j(288)     if (i > 1000+0) println(146); else println(999);
1211 acc16= constant 1000
1212 acc16+ constant 0
1213 acc16Comp variable 0
1214 brge 1218
1215 acc8= constant 146
1216 call writeLineAcc8
1217 br 1221
1218 acc16= constant 999
1219 call writeLineAcc16
1220 ;test2.j(289)     if (i < 3000+0) println(147); else println(999);
1221 acc16= constant 3000
1222 acc16+ constant 0
1223 acc16Comp variable 0
1224 brle 1228
1225 acc8= constant 147
1226 call writeLineAcc8
1227 br 1231
1228 acc16= constant 999
1229 call writeLineAcc16
1230 ;test2.j(290)     println(148);
1231 acc8= constant 148
1232 call writeLineAcc8
1233 ;test2.j(291)     println(149);
1234 acc8= constant 149
1235 call writeLineAcc8
1236 ;test2.j(292)   
1237 ;test2.j(293)     /************************/
1238 ;test2.j(294)     // var - var
1239 ;test2.j(295)     // byte - byte
1240 ;test2.j(296)     if (b > b1) println(150);
1241 acc8= variable 6
1242 acc8Comp variable 7
1243 brle 1247
1244 acc8= constant 150
1245 call writeLineAcc8
1246 ;test2.j(297)     if (b < b3) println(151);
1247 acc8= variable 6
1248 acc8Comp variable 8
1249 brge 1255
1250 acc8= constant 151
1251 call writeLineAcc8
1252 ;test2.j(298)     // var - var
1253 ;test2.j(299)     // byte - integer
1254 ;test2.j(300)     if (b > i1) println(999); else println(152);
1255 acc8= variable 6
1256 acc16= variable 2
1257 acc8CompareAcc16
1258 brle 1262
1259 acc16= constant 999
1260 call writeLineAcc16
1261 br 1265
1262 acc8= constant 152
1263 call writeLineAcc8
1264 ;test2.j(301)     if (b < i3) println(153);
1265 acc8= variable 6
1266 acc16= variable 4
1267 acc8CompareAcc16
1268 brge 1274
1269 acc8= constant 153
1270 call writeLineAcc8
1271 ;test2.j(302)     // var - var
1272 ;test2.j(303)     // integer - byte
1273 ;test2.j(304)     if (i > i1) println(154);
1274 acc16= variable 0
1275 acc16Comp variable 2
1276 brle 1280
1277 acc8= constant 154
1278 call writeLineAcc8
1279 ;test2.j(305)     if (i < i3) println(155);
1280 acc16= variable 0
1281 acc16Comp variable 4
1282 brge 1288
1283 acc8= constant 155
1284 call writeLineAcc8
1285 ;test2.j(306)     // var - var
1286 ;test2.j(307)     // integer - integer
1287 ;test2.j(308)     if (i > i1) println(156);
1288 acc16= variable 0
1289 acc16Comp variable 2
1290 brle 1294
1291 acc8= constant 156
1292 call writeLineAcc8
1293 ;test2.j(309)     if (i < i3) println(157);
1294 acc16= variable 0
1295 acc16Comp variable 4
1296 brge 1300
1297 acc8= constant 157
1298 call writeLineAcc8
1299 ;test2.j(310)     println(158);
1300 acc8= constant 158
1301 call writeLineAcc8
1302 ;test2.j(311)     println(159);
1303 acc8= constant 159
1304 call writeLineAcc8
1305 ;test2.j(312)   
1306 ;test2.j(313)     /************************/
1307 ;test2.j(314)     // var - stack8
1308 ;test2.j(315)     // byte - byte
1309 ;test2.j(316)   
1310 ;test2.j(317)     // var - stack8
1311 ;test2.j(318)     // byte - integer
1312 ;test2.j(319)   
1313 ;test2.j(320)     // var - stack8
1314 ;test2.j(321)     // integer - byte 
1315 ;test2.j(322)   
1316 ;test2.j(323)     // var - stack8
1317 ;test2.j(324)     // integer - integer
1318 ;test2.j(325)   
1319 ;test2.j(326)     /************************/
1320 ;test2.j(327)     // var - stack16
1321 ;test2.j(328)     // byte - byte
1322 ;test2.j(329)   
1323 ;test2.j(330)     // var - stack16
1324 ;test2.j(331)     // byte - integer
1325 ;test2.j(332)   
1326 ;test2.j(333)     // var - stack16
1327 ;test2.j(334)     // integer - byte
1328 ;test2.j(335)   
1329 ;test2.j(336)     // var - stack16
1330 ;test2.j(337)     // integer - integer
1331 ;test2.j(338)   
1332 ;test2.j(339)     /************************/
1333 ;test2.j(340)     // stack8 - constant
1334 ;test2.j(341)     // stack8 - acc
1335 ;test2.j(342)     // stack8 - var
1336 ;test2.j(343)     // stack8 - stack8
1337 ;test2.j(344)     // stack8 - stack16
1338 ;test2.j(345)   
1339 ;test2.j(346)     /************************/
1340 ;test2.j(347)     // stack16 - constant
1341 ;test2.j(348)     // stack16 - acc
1342 ;test2.j(349)     // stack16 - var
1343 ;test2.j(350)     // stack16 - stack8
1344 ;test2.j(351)     // stack16 - stack16
1345 ;test2.j(352)   
1346 ;test2.j(353)     println("Klaar");
1347 acc16= constant 1352
1348 writeLineString
1349 ;test2.j(354)   }
1350 ;test2.j(355) }
1351 stop
1352 stringConstant 0 = "Klaar"
