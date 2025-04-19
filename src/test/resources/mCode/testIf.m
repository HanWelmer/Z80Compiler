   0 call 6
   1 stop
   2 ;testIf.j(0) /* Program to test branch instructions in an if statement */
   3 ;testIf.j(1) class TestIf {
   4 class TestIf []
   5 ;testIf.j(2)   private static word i = 2000;
   6 acc16= constant 2000
   7 acc16=> word variable 0
   8 ;testIf.j(3)   private static word i1 = 1000;
   9 acc16= constant 1000
  10 acc16=> word variable 2
  11 ;testIf.j(4)   private static word i3 = 3000;
  12 acc16= constant 3000
  13 acc16=> word variable 4
  14 ;testIf.j(5)   private static byte b = 20;
  15 acc8= constant 20
  16 acc8=> byte variable 6
  17 ;testIf.j(6)   private static byte b1 = 10;
  18 acc8= constant 10
  19 acc8=> byte variable 7
  20 ;testIf.j(7)   private static byte b3 = 30;
  21 acc8= constant 30
  22 acc8=> byte variable 8
  23 br 26
  24 ;testIf.j(8) 
  25 ;testIf.j(9)   public static void main() {
  26 method TestIf.main [public, static] void ()
  27 <basePointer
  28 basePointer= stackPointer
  29 stackPointer+ constant 0
  30 ;testIf.j(10)     /*Possible operand types: 
  31 ;testIf.j(11)      * constant, acc, var, stack8, stack16
  32 ;testIf.j(12)      *Possible datatype combinations:
  33 ;testIf.j(13)      * byte - byte
  34 ;testIf.j(14)      * byte - integer
  35 ;testIf.j(15)      * integer - byte
  36 ;testIf.j(16)      * integer - integer
  37 ;testIf.j(17)     */
  38 ;testIf.j(18)   
  39 ;testIf.j(19)     println(0);
  40 acc8= constant 0
  41 writeLineAcc8
  42 ;testIf.j(20)   
  43 ;testIf.j(21)     /************************/
  44 ;testIf.j(22)     // constant - constant
  45 ;testIf.j(23)     // byte - byte
  46 ;testIf.j(24)     if (1 == 1) println(1); else println(999);
  47 acc8= constant 1
  48 acc8Comp constant 1
  49 brne 53
  50 acc8= constant 1
  51 writeLineAcc8
  52 br 56
  53 acc16= constant 999
  54 writeLineAcc16
  55 ;testIf.j(25)     if (1 != 0) println(2); else println(999);
  56 acc8= constant 1
  57 acc8Comp constant 0
  58 breq 62
  59 acc8= constant 2
  60 writeLineAcc8
  61 br 65
  62 acc16= constant 999
  63 writeLineAcc16
  64 ;testIf.j(26)     if (1 >  0) println(3); else println(999);
  65 acc8= constant 1
  66 acc8Comp constant 0
  67 brle 71
  68 acc8= constant 3
  69 writeLineAcc8
  70 br 74
  71 acc16= constant 999
  72 writeLineAcc16
  73 ;testIf.j(27)     if (1 >= 0) println(4); else println(999);
  74 acc8= constant 1
  75 acc8Comp constant 0
  76 brlt 80
  77 acc8= constant 4
  78 writeLineAcc8
  79 br 83
  80 acc16= constant 999
  81 writeLineAcc16
  82 ;testIf.j(28)     if (1 >= 1) println(5); else println(999);
  83 acc8= constant 1
  84 acc8Comp constant 1
  85 brlt 89
  86 acc8= constant 5
  87 writeLineAcc8
  88 br 92
  89 acc16= constant 999
  90 writeLineAcc16
  91 ;testIf.j(29)     if (1 <  2) println(6); else println(999);
  92 acc8= constant 1
  93 acc8Comp constant 2
  94 brge 98
  95 acc8= constant 6
  96 writeLineAcc8
  97 br 101
  98 acc16= constant 999
  99 writeLineAcc16
 100 ;testIf.j(30)     if (1 <= 2) println(7); else println(999);
 101 acc8= constant 1
 102 acc8Comp constant 2
 103 brgt 107
 104 acc8= constant 7
 105 writeLineAcc8
 106 br 110
 107 acc16= constant 999
 108 writeLineAcc16
 109 ;testIf.j(31)     if (1 <= 1) println(8); else println(999);
 110 acc8= constant 1
 111 acc8Comp constant 1
 112 brgt 116
 113 acc8= constant 8
 114 writeLineAcc8
 115 br 119
 116 acc16= constant 999
 117 writeLineAcc16
 118 ;testIf.j(32)     println(9);
 119 acc8= constant 9
 120 writeLineAcc8
 121 ;testIf.j(33)   
 122 ;testIf.j(34)     // constant - constant
 123 ;testIf.j(35)     // byte - integer
 124 ;testIf.j(36)     if (1 == 1000) println(999); else println(10);
 125 acc8= constant 1
 126 acc16= constant 1000
 127 acc8CompareAcc16
 128 brne 132
 129 acc16= constant 999
 130 writeLineAcc16
 131 br 135
 132 acc8= constant 10
 133 writeLineAcc8
 134 ;testIf.j(37)     if (1 != 1000) println(11);  else println(999);
 135 acc8= constant 1
 136 acc16= constant 1000
 137 acc8CompareAcc16
 138 breq 142
 139 acc8= constant 11
 140 writeLineAcc8
 141 br 145
 142 acc16= constant 999
 143 writeLineAcc16
 144 ;testIf.j(38)     if (1 >  1000) println(999); else println(12);
 145 acc8= constant 1
 146 acc16= constant 1000
 147 acc8CompareAcc16
 148 brle 152
 149 acc16= constant 999
 150 writeLineAcc16
 151 br 155
 152 acc8= constant 12
 153 writeLineAcc8
 154 ;testIf.j(39)     if (1 >= 1000) println(999); else println(13);
 155 acc8= constant 1
 156 acc16= constant 1000
 157 acc8CompareAcc16
 158 brlt 162
 159 acc16= constant 999
 160 writeLineAcc16
 161 br 165
 162 acc8= constant 13
 163 writeLineAcc8
 164 ;testIf.j(40)     if (1 >= 1000) println(999); else println(14);
 165 acc8= constant 1
 166 acc16= constant 1000
 167 acc8CompareAcc16
 168 brlt 172
 169 acc16= constant 999
 170 writeLineAcc16
 171 br 175
 172 acc8= constant 14
 173 writeLineAcc8
 174 ;testIf.j(41)     if (1 <  2000) println(15);  else println(999);
 175 acc8= constant 1
 176 acc16= constant 2000
 177 acc8CompareAcc16
 178 brge 182
 179 acc8= constant 15
 180 writeLineAcc8
 181 br 185
 182 acc16= constant 999
 183 writeLineAcc16
 184 ;testIf.j(42)     if (1 <= 2000) println(16);  else println(999);
 185 acc8= constant 1
 186 acc16= constant 2000
 187 acc8CompareAcc16
 188 brgt 192
 189 acc8= constant 16
 190 writeLineAcc8
 191 br 195
 192 acc16= constant 999
 193 writeLineAcc16
 194 ;testIf.j(43)     if (1 <= 1000) println(17);  else println(999);
 195 acc8= constant 1
 196 acc16= constant 1000
 197 acc8CompareAcc16
 198 brgt 202
 199 acc8= constant 17
 200 writeLineAcc8
 201 br 205
 202 acc16= constant 999
 203 writeLineAcc16
 204 ;testIf.j(44)     println(18);
 205 acc8= constant 18
 206 writeLineAcc8
 207 ;testIf.j(45)     println(19);
 208 acc8= constant 19
 209 writeLineAcc8
 210 ;testIf.j(46)   
 211 ;testIf.j(47)     // constant - constant
 212 ;testIf.j(48)     // integer - byte
 213 ;testIf.j(49)     if (1000 == 1) println(999); else println(20);
 214 acc16= constant 1000
 215 acc8= constant 1
 216 acc16CompareAcc8
 217 brne 221
 218 acc16= constant 999
 219 writeLineAcc16
 220 br 224
 221 acc8= constant 20
 222 writeLineAcc8
 223 ;testIf.j(50)     if (1000 != 0) println(21);  else println(999);
 224 acc16= constant 1000
 225 acc8= constant 0
 226 acc16CompareAcc8
 227 breq 231
 228 acc8= constant 21
 229 writeLineAcc8
 230 br 234
 231 acc16= constant 999
 232 writeLineAcc16
 233 ;testIf.j(51)     if (1000 >  0) println(22);  else println(999);
 234 acc16= constant 1000
 235 acc8= constant 0
 236 acc16CompareAcc8
 237 brle 241
 238 acc8= constant 22
 239 writeLineAcc8
 240 br 244
 241 acc16= constant 999
 242 writeLineAcc16
 243 ;testIf.j(52)     if (1000 >= 0) println(23);  else println(999);
 244 acc16= constant 1000
 245 acc8= constant 0
 246 acc16CompareAcc8
 247 brlt 251
 248 acc8= constant 23
 249 writeLineAcc8
 250 br 254
 251 acc16= constant 999
 252 writeLineAcc16
 253 ;testIf.j(53)     if (1000 >= 1) println(24);  else println(999);
 254 acc16= constant 1000
 255 acc8= constant 1
 256 acc16CompareAcc8
 257 brlt 261
 258 acc8= constant 24
 259 writeLineAcc8
 260 br 264
 261 acc16= constant 999
 262 writeLineAcc16
 263 ;testIf.j(54)     if (1 <  2000) println(25);  else println(999);
 264 acc8= constant 1
 265 acc16= constant 2000
 266 acc8CompareAcc16
 267 brge 271
 268 acc8= constant 25
 269 writeLineAcc8
 270 br 274
 271 acc16= constant 999
 272 writeLineAcc16
 273 ;testIf.j(55)     if (1 <= 2000) println(26);  else println(999);
 274 acc8= constant 1
 275 acc16= constant 2000
 276 acc8CompareAcc16
 277 brgt 281
 278 acc8= constant 26
 279 writeLineAcc8
 280 br 284
 281 acc16= constant 999
 282 writeLineAcc16
 283 ;testIf.j(56)     if (1 <= 1000) println(27);  else println(999);
 284 acc8= constant 1
 285 acc16= constant 1000
 286 acc8CompareAcc16
 287 brgt 291
 288 acc8= constant 27
 289 writeLineAcc8
 290 br 294
 291 acc16= constant 999
 292 writeLineAcc16
 293 ;testIf.j(57)     println(28);
 294 acc8= constant 28
 295 writeLineAcc8
 296 ;testIf.j(58)     println(29);
 297 acc8= constant 29
 298 writeLineAcc8
 299 ;testIf.j(59)   
 300 ;testIf.j(60)     // constant - constant
 301 ;testIf.j(61)     // integer - integer
 302 ;testIf.j(62)     if (1000 == 1000) println(30); else println(999);
 303 acc16= constant 1000
 304 acc16Comp constant 1000
 305 brne 309
 306 acc8= constant 30
 307 writeLineAcc8
 308 br 312
 309 acc16= constant 999
 310 writeLineAcc16
 311 ;testIf.j(63)     if (1000 != 2000) println(31); else println(999);
 312 acc16= constant 1000
 313 acc16Comp constant 2000
 314 breq 318
 315 acc8= constant 31
 316 writeLineAcc8
 317 br 321
 318 acc16= constant 999
 319 writeLineAcc16
 320 ;testIf.j(64)     if (2000 >  1000) println(32); else println(999);
 321 acc16= constant 2000
 322 acc16Comp constant 1000
 323 brle 327
 324 acc8= constant 32
 325 writeLineAcc8
 326 br 330
 327 acc16= constant 999
 328 writeLineAcc16
 329 ;testIf.j(65)     if (2000 >= 1000) println(33); else println(999);
 330 acc16= constant 2000
 331 acc16Comp constant 1000
 332 brlt 336
 333 acc8= constant 33
 334 writeLineAcc8
 335 br 339
 336 acc16= constant 999
 337 writeLineAcc16
 338 ;testIf.j(66)     if (1000 >= 1000) println(34); else println(999);
 339 acc16= constant 1000
 340 acc16Comp constant 1000
 341 brlt 345
 342 acc8= constant 34
 343 writeLineAcc8
 344 br 348
 345 acc16= constant 999
 346 writeLineAcc16
 347 ;testIf.j(67)     if (1000 <  2000) println(35); else println(999);
 348 acc16= constant 1000
 349 acc16Comp constant 2000
 350 brge 354
 351 acc8= constant 35
 352 writeLineAcc8
 353 br 357
 354 acc16= constant 999
 355 writeLineAcc16
 356 ;testIf.j(68)     if (1000 <= 2000) println(36); else println(999);
 357 acc16= constant 1000
 358 acc16Comp constant 2000
 359 brgt 363
 360 acc8= constant 36
 361 writeLineAcc8
 362 br 366
 363 acc16= constant 999
 364 writeLineAcc16
 365 ;testIf.j(69)     if (1000 <= 1000) println(37); else println(999);
 366 acc16= constant 1000
 367 acc16Comp constant 1000
 368 brgt 372
 369 acc8= constant 37
 370 writeLineAcc8
 371 br 375
 372 acc16= constant 999
 373 writeLineAcc16
 374 ;testIf.j(70)     println(38);
 375 acc8= constant 38
 376 writeLineAcc8
 377 ;testIf.j(71)     println(39);
 378 acc8= constant 39
 379 writeLineAcc8
 380 ;testIf.j(72)   
 381 ;testIf.j(73)     /************************/
 382 ;testIf.j(74)     // constant - acc
 383 ;testIf.j(75)     // byte - byte
 384 ;testIf.j(76)     if (1 > 0+0) println(40); else println(999);
 385 acc8= constant 0
 386 acc8+ constant 0
 387 acc8Comp constant 1
 388 brge 392
 389 acc8= constant 40
 390 writeLineAcc8
 391 br 395
 392 acc16= constant 999
 393 writeLineAcc16
 394 ;testIf.j(77)     if (1 < 2+0) println(41); else println(999);
 395 acc8= constant 2
 396 acc8+ constant 0
 397 acc8Comp constant 1
 398 brle 402
 399 acc8= constant 41
 400 writeLineAcc8
 401 br 407
 402 acc16= constant 999
 403 writeLineAcc16
 404 ;testIf.j(78)     // constant - acc
 405 ;testIf.j(79)     // byte - integer
 406 ;testIf.j(80)     if (1 > 1000+0) println(999); else println(42);
 407 acc16= constant 1000
 408 acc16+ constant 0
 409 acc8= constant 1
 410 acc8CompareAcc16
 411 brle 415
 412 acc16= constant 999
 413 writeLineAcc16
 414 br 418
 415 acc8= constant 42
 416 writeLineAcc8
 417 ;testIf.j(81)     if (1 < 1000+0) println(43);  else println(999);
 418 acc16= constant 1000
 419 acc16+ constant 0
 420 acc8= constant 1
 421 acc8CompareAcc16
 422 brge 426
 423 acc8= constant 43
 424 writeLineAcc8
 425 br 431
 426 acc16= constant 999
 427 writeLineAcc16
 428 ;testIf.j(82)     // constant - acc
 429 ;testIf.j(83)     // integer - byte
 430 ;testIf.j(84)     if (1000 > 0+0) println(44);  else println(999);
 431 acc8= constant 0
 432 acc8+ constant 0
 433 acc16= constant 1000
 434 acc16CompareAcc8
 435 brle 439
 436 acc8= constant 44
 437 writeLineAcc8
 438 br 442
 439 acc16= constant 999
 440 writeLineAcc16
 441 ;testIf.j(85)     if (1000 < 0+0) println(999); else println(45);
 442 acc8= constant 0
 443 acc8+ constant 0
 444 acc16= constant 1000
 445 acc16CompareAcc8
 446 brge 450
 447 acc16= constant 999
 448 writeLineAcc16
 449 br 455
 450 acc8= constant 45
 451 writeLineAcc8
 452 ;testIf.j(86)     // constant - acc
 453 ;testIf.j(87)     // integer - integer
 454 ;testIf.j(88)     if (2000 > 1000+0) println(46); else println(999);
 455 acc16= constant 1000
 456 acc16+ constant 0
 457 acc16Comp constant 2000
 458 brge 462
 459 acc8= constant 46
 460 writeLineAcc8
 461 br 465
 462 acc16= constant 999
 463 writeLineAcc16
 464 ;testIf.j(89)     if (1000 < 2000+0) println(47); else println(999);
 465 acc16= constant 2000
 466 acc16+ constant 0
 467 acc16Comp constant 1000
 468 brle 472
 469 acc8= constant 47
 470 writeLineAcc8
 471 br 475
 472 acc16= constant 999
 473 writeLineAcc16
 474 ;testIf.j(90)     println(48);
 475 acc8= constant 48
 476 writeLineAcc8
 477 ;testIf.j(91)     println(49);
 478 acc8= constant 49
 479 writeLineAcc8
 480 ;testIf.j(92)   
 481 ;testIf.j(93)     /************************/
 482 ;testIf.j(94)     // constant - var
 483 ;testIf.j(95)     // byte - byte
 484 ;testIf.j(96)     if (30 > b) println(50); else println(999);
 485 acc8= byte variable 6
 486 acc8Comp constant 30
 487 brge 491
 488 acc8= constant 50
 489 writeLineAcc8
 490 br 494
 491 acc16= constant 999
 492 writeLineAcc16
 493 ;testIf.j(97)     if (10 < b) println(51); else println(999);
 494 acc8= byte variable 6
 495 acc8Comp constant 10
 496 brle 500
 497 acc8= constant 51
 498 writeLineAcc8
 499 br 505
 500 acc16= constant 999
 501 writeLineAcc16
 502 ;testIf.j(98)     // constant - var
 503 ;testIf.j(99)     // byte - integer
 504 ;testIf.j(100)     if (30 > i) println(999); else println(52);
 505 acc16= word variable 0
 506 acc8= constant 30
 507 acc8CompareAcc16
 508 brle 512
 509 acc16= constant 999
 510 writeLineAcc16
 511 br 515
 512 acc8= constant 52
 513 writeLineAcc8
 514 ;testIf.j(101)     if (10 < i) println(53); else println(999);
 515 acc16= word variable 0
 516 acc8= constant 10
 517 acc8CompareAcc16
 518 brge 522
 519 acc8= constant 53
 520 writeLineAcc8
 521 br 527
 522 acc16= constant 999
 523 writeLineAcc16
 524 ;testIf.j(102)     // constant - var
 525 ;testIf.j(103)     // integer - byte
 526 ;testIf.j(104)     if (3000 > b) println(54); else println(999);
 527 acc8= byte variable 6
 528 acc16= constant 3000
 529 acc16CompareAcc8
 530 brle 534
 531 acc8= constant 54
 532 writeLineAcc8
 533 br 537
 534 acc16= constant 999
 535 writeLineAcc16
 536 ;testIf.j(105)     if (1000 < b) println(999); else println(55);
 537 acc8= byte variable 6
 538 acc16= constant 1000
 539 acc16CompareAcc8
 540 brge 544
 541 acc16= constant 999
 542 writeLineAcc16
 543 br 549
 544 acc8= constant 55
 545 writeLineAcc8
 546 ;testIf.j(106)     // constant - var
 547 ;testIf.j(107)     // integer - integer
 548 ;testIf.j(108)     if (3000 > i) println(56); else println(999);
 549 acc16= word variable 0
 550 acc16Comp constant 3000
 551 brge 555
 552 acc8= constant 56
 553 writeLineAcc8
 554 br 558
 555 acc16= constant 999
 556 writeLineAcc16
 557 ;testIf.j(109)     if (1000 < i) println(57); else println(999);
 558 acc16= word variable 0
 559 acc16Comp constant 1000
 560 brle 564
 561 acc8= constant 57
 562 writeLineAcc8
 563 br 567
 564 acc16= constant 999
 565 writeLineAcc16
 566 ;testIf.j(110)     println(58);
 567 acc8= constant 58
 568 writeLineAcc8
 569 ;testIf.j(111)     println(59);
 570 acc8= constant 59
 571 writeLineAcc8
 572 ;testIf.j(112)   
 573 ;testIf.j(113)     /************************/
 574 ;testIf.j(114)     // constant - stack8
 575 ;testIf.j(115)     // byte - byte
 576 ;testIf.j(116)     println(60);
 577 acc8= constant 60
 578 writeLineAcc8
 579 ;testIf.j(117)     println(61);
 580 acc8= constant 61
 581 writeLineAcc8
 582 ;testIf.j(118)     // constant - stack8
 583 ;testIf.j(119)     // byte - integer
 584 ;testIf.j(120)     println(62);
 585 acc8= constant 62
 586 writeLineAcc8
 587 ;testIf.j(121)     println(63);
 588 acc8= constant 63
 589 writeLineAcc8
 590 ;testIf.j(122)     // constant - stack8
 591 ;testIf.j(123)     // integer - byte
 592 ;testIf.j(124)     println(64);
 593 acc8= constant 64
 594 writeLineAcc8
 595 ;testIf.j(125)     println(65);
 596 acc8= constant 65
 597 writeLineAcc8
 598 ;testIf.j(126)     // constant - stack8
 599 ;testIf.j(127)     // integer - integer
 600 ;testIf.j(128)     println(66);
 601 acc8= constant 66
 602 writeLineAcc8
 603 ;testIf.j(129)     println(67);
 604 acc8= constant 67
 605 writeLineAcc8
 606 ;testIf.j(130)     println(68);
 607 acc8= constant 68
 608 writeLineAcc8
 609 ;testIf.j(131)     println(69);
 610 acc8= constant 69
 611 writeLineAcc8
 612 ;testIf.j(132)   
 613 ;testIf.j(133)     /************************/
 614 ;testIf.j(134)     // constant - stack16
 615 ;testIf.j(135)     // byte - byte
 616 ;testIf.j(136)     println(70);
 617 acc8= constant 70
 618 writeLineAcc8
 619 ;testIf.j(137)     println(71);
 620 acc8= constant 71
 621 writeLineAcc8
 622 ;testIf.j(138)     // constant - stack16
 623 ;testIf.j(139)     // byte - integer
 624 ;testIf.j(140)     println(72);
 625 acc8= constant 72
 626 writeLineAcc8
 627 ;testIf.j(141)     println(73);
 628 acc8= constant 73
 629 writeLineAcc8
 630 ;testIf.j(142)     // constant - stack16
 631 ;testIf.j(143)     // integer - byte
 632 ;testIf.j(144)     println(74);
 633 acc8= constant 74
 634 writeLineAcc8
 635 ;testIf.j(145)     println(75);
 636 acc8= constant 75
 637 writeLineAcc8
 638 ;testIf.j(146)     // constant - stack16
 639 ;testIf.j(147)     // integer - integer
 640 ;testIf.j(148)     println(76);
 641 acc8= constant 76
 642 writeLineAcc8
 643 ;testIf.j(149)     println(77);
 644 acc8= constant 77
 645 writeLineAcc8
 646 ;testIf.j(150)     println(78);
 647 acc8= constant 78
 648 writeLineAcc8
 649 ;testIf.j(151)     println(79);
 650 acc8= constant 79
 651 writeLineAcc8
 652 ;testIf.j(152)   
 653 ;testIf.j(153)     /************************/
 654 ;testIf.j(154)     // acc - constant
 655 ;testIf.j(155)     // byte - byte
 656 ;testIf.j(156)     if (30+0 > 20) println(80); else println(999);
 657 acc8= constant 30
 658 acc8+ constant 0
 659 acc8Comp constant 20
 660 brle 664
 661 acc8= constant 80
 662 writeLineAcc8
 663 br 667
 664 acc16= constant 999
 665 writeLineAcc16
 666 ;testIf.j(157)     if (10+0 < 20) println(81); else println(999);
 667 acc8= constant 10
 668 acc8+ constant 0
 669 acc8Comp constant 20
 670 brge 674
 671 acc8= constant 81
 672 writeLineAcc8
 673 br 679
 674 acc16= constant 999
 675 writeLineAcc16
 676 ;testIf.j(158)     // acc - constant
 677 ;testIf.j(159)     // byte - integer
 678 ;testIf.j(160)     if (30+0 > 2000) println(999); else println(82);
 679 acc8= constant 30
 680 acc8+ constant 0
 681 acc16= constant 2000
 682 acc8CompareAcc16
 683 brle 687
 684 acc16= constant 999
 685 writeLineAcc16
 686 br 690
 687 acc8= constant 82
 688 writeLineAcc8
 689 ;testIf.j(161)     if (10+0 < 2000) println(83); else println(999);
 690 acc8= constant 10
 691 acc8+ constant 0
 692 acc16= constant 2000
 693 acc8CompareAcc16
 694 brge 698
 695 acc8= constant 83
 696 writeLineAcc8
 697 br 703
 698 acc16= constant 999
 699 writeLineAcc16
 700 ;testIf.j(162)     // acc - constant
 701 ;testIf.j(163)     // integer - byte
 702 ;testIf.j(164)     if (3000+0 > 20) println(84); else println(999);
 703 acc16= constant 3000
 704 acc16+ constant 0
 705 acc8= constant 20
 706 acc16CompareAcc8
 707 brle 711
 708 acc8= constant 84
 709 writeLineAcc8
 710 br 714
 711 acc16= constant 999
 712 writeLineAcc16
 713 ;testIf.j(165)     if (1000+0 < 20) println(999); else println(85);
 714 acc16= constant 1000
 715 acc16+ constant 0
 716 acc8= constant 20
 717 acc16CompareAcc8
 718 brge 722
 719 acc16= constant 999
 720 writeLineAcc16
 721 br 727
 722 acc8= constant 85
 723 writeLineAcc8
 724 ;testIf.j(166)     // acc - constant
 725 ;testIf.j(167)     // integer - integer
 726 ;testIf.j(168)     if (3000+0 > 2000) println(86); else println(999);
 727 acc16= constant 3000
 728 acc16+ constant 0
 729 acc16Comp constant 2000
 730 brle 734
 731 acc8= constant 86
 732 writeLineAcc8
 733 br 737
 734 acc16= constant 999
 735 writeLineAcc16
 736 ;testIf.j(169)     if (1000+0 < 2000) println(87); else println(999);
 737 acc16= constant 1000
 738 acc16+ constant 0
 739 acc16Comp constant 2000
 740 brge 744
 741 acc8= constant 87
 742 writeLineAcc8
 743 br 747
 744 acc16= constant 999
 745 writeLineAcc16
 746 ;testIf.j(170)     println(88);
 747 acc8= constant 88
 748 writeLineAcc8
 749 ;testIf.j(171)     println(89);
 750 acc8= constant 89
 751 writeLineAcc8
 752 ;testIf.j(172)   
 753 ;testIf.j(173)     /************************/
 754 ;testIf.j(174)     // acc - acc
 755 ;testIf.j(175)     // byte - byte
 756 ;testIf.j(176)     if (30+0 > 20+0) println(90); else println(999);
 757 acc8= constant 30
 758 acc8+ constant 0
 759 <acc8
 760 acc8= constant 20
 761 acc8+ constant 0
 762 revAcc8Comp unstack8
 763 brge 767
 764 acc8= constant 90
 765 writeLineAcc8
 766 br 770
 767 acc16= constant 999
 768 writeLineAcc16
 769 ;testIf.j(177)     if (10+0 < 20+0) println(91); else println(999);
 770 acc8= constant 10
 771 acc8+ constant 0
 772 <acc8
 773 acc8= constant 20
 774 acc8+ constant 0
 775 revAcc8Comp unstack8
 776 brle 780
 777 acc8= constant 91
 778 writeLineAcc8
 779 br 785
 780 acc16= constant 999
 781 writeLineAcc16
 782 ;testIf.j(178)     // acc - acc
 783 ;testIf.j(179)     // byte - integer
 784 ;testIf.j(180)     if (30+0 > 2000+0) println(999); else println(92);
 785 acc8= constant 30
 786 acc8+ constant 0
 787 <acc8
 788 acc16= constant 2000
 789 acc16+ constant 0
 790 acc8<
 791 acc8CompareAcc16
 792 brle 796
 793 acc16= constant 999
 794 writeLineAcc16
 795 br 799
 796 acc8= constant 92
 797 writeLineAcc8
 798 ;testIf.j(181)     if (10+0 < 2000+0) println(93); else println(999);
 799 acc8= constant 10
 800 acc8+ constant 0
 801 <acc8
 802 acc16= constant 2000
 803 acc16+ constant 0
 804 acc8<
 805 acc8CompareAcc16
 806 brge 810
 807 acc8= constant 93
 808 writeLineAcc8
 809 br 815
 810 acc16= constant 999
 811 writeLineAcc16
 812 ;testIf.j(182)     // acc - acc
 813 ;testIf.j(183)     // integer - byte
 814 ;testIf.j(184)     if (3000+0 > 20+0) println(94); else println(999);
 815 acc16= constant 3000
 816 acc16+ constant 0
 817 <acc16
 818 acc8= constant 20
 819 acc8+ constant 0
 820 acc16<
 821 acc16CompareAcc8
 822 brle 826
 823 acc8= constant 94
 824 writeLineAcc8
 825 br 829
 826 acc16= constant 999
 827 writeLineAcc16
 828 ;testIf.j(185)     if (1000+0 < 20+0) println(999); else println(95);
 829 acc16= constant 1000
 830 acc16+ constant 0
 831 <acc16
 832 acc8= constant 20
 833 acc8+ constant 0
 834 acc16<
 835 acc16CompareAcc8
 836 brge 840
 837 acc16= constant 999
 838 writeLineAcc16
 839 br 845
 840 acc8= constant 95
 841 writeLineAcc8
 842 ;testIf.j(186)     // acc - acc
 843 ;testIf.j(187)     // integer - integer
 844 ;testIf.j(188)     if (3000+0 > 2000+0) println(96); else println(999);
 845 acc16= constant 3000
 846 acc16+ constant 0
 847 <acc16
 848 acc16= constant 2000
 849 acc16+ constant 0
 850 revAcc16Comp unstack16
 851 brge 855
 852 acc8= constant 96
 853 writeLineAcc8
 854 br 858
 855 acc16= constant 999
 856 writeLineAcc16
 857 ;testIf.j(189)     if (1000+0 < 2000+0) println(97); else println(999);
 858 acc16= constant 1000
 859 acc16+ constant 0
 860 <acc16
 861 acc16= constant 2000
 862 acc16+ constant 0
 863 revAcc16Comp unstack16
 864 brle 868
 865 acc8= constant 97
 866 writeLineAcc8
 867 br 871
 868 acc16= constant 999
 869 writeLineAcc16
 870 ;testIf.j(190)     println(98);
 871 acc8= constant 98
 872 writeLineAcc8
 873 ;testIf.j(191)     println(99);
 874 acc8= constant 99
 875 writeLineAcc8
 876 ;testIf.j(192)   
 877 ;testIf.j(193)     /************************/
 878 ;testIf.j(194)     // acc - var
 879 ;testIf.j(195)     // byte - byte
 880 ;testIf.j(196)     if (30+0 > b) println(100); else println(999);
 881 acc8= constant 30
 882 acc8+ constant 0
 883 acc8Comp byte variable 6
 884 brle 888
 885 acc8= constant 100
 886 writeLineAcc8
 887 br 891
 888 acc16= constant 999
 889 writeLineAcc16
 890 ;testIf.j(197)     if (10+0 < b) println(101); else println(999);
 891 acc8= constant 10
 892 acc8+ constant 0
 893 acc8Comp byte variable 6
 894 brge 898
 895 acc8= constant 101
 896 writeLineAcc8
 897 br 903
 898 acc16= constant 999
 899 writeLineAcc16
 900 ;testIf.j(198)     // acc - var
 901 ;testIf.j(199)     // byte - integer
 902 ;testIf.j(200)     if (30+0 > i) println(999); else println(102);
 903 acc8= constant 30
 904 acc8+ constant 0
 905 acc16= word variable 0
 906 acc8CompareAcc16
 907 brle 911
 908 acc16= constant 999
 909 writeLineAcc16
 910 br 914
 911 acc8= constant 102
 912 writeLineAcc8
 913 ;testIf.j(201)     if (10+0 < i) println(103); else println(999);
 914 acc8= constant 10
 915 acc8+ constant 0
 916 acc16= word variable 0
 917 acc8CompareAcc16
 918 brge 922
 919 acc8= constant 103
 920 writeLineAcc8
 921 br 927
 922 acc16= constant 999
 923 writeLineAcc16
 924 ;testIf.j(202)     // acc - var
 925 ;testIf.j(203)     // integer - byte
 926 ;testIf.j(204)     if (3000+0 > b) println(104); else println(999);
 927 acc16= constant 3000
 928 acc16+ constant 0
 929 acc8= byte variable 6
 930 acc16CompareAcc8
 931 brle 935
 932 acc8= constant 104
 933 writeLineAcc8
 934 br 938
 935 acc16= constant 999
 936 writeLineAcc16
 937 ;testIf.j(205)     if (1000+0 < b) println(999); else println(105);
 938 acc16= constant 1000
 939 acc16+ constant 0
 940 acc8= byte variable 6
 941 acc16CompareAcc8
 942 brge 946
 943 acc16= constant 999
 944 writeLineAcc16
 945 br 951
 946 acc8= constant 105
 947 writeLineAcc8
 948 ;testIf.j(206)     // acc - var
 949 ;testIf.j(207)     // integer - integer
 950 ;testIf.j(208)     if (3000+0 > i) println(106); else println(999);
 951 acc16= constant 3000
 952 acc16+ constant 0
 953 acc16Comp word variable 0
 954 brle 958
 955 acc8= constant 106
 956 writeLineAcc8
 957 br 961
 958 acc16= constant 999
 959 writeLineAcc16
 960 ;testIf.j(209)     if (1000+0 < i) println(107); else println(999);
 961 acc16= constant 1000
 962 acc16+ constant 0
 963 acc16Comp word variable 0
 964 brge 968
 965 acc8= constant 107
 966 writeLineAcc8
 967 br 971
 968 acc16= constant 999
 969 writeLineAcc16
 970 ;testIf.j(210)     println(108);
 971 acc8= constant 108
 972 writeLineAcc8
 973 ;testIf.j(211)     println(109);
 974 acc8= constant 109
 975 writeLineAcc8
 976 ;testIf.j(212)   
 977 ;testIf.j(213)     /************************/
 978 ;testIf.j(214)     // acc - stack8
 979 ;testIf.j(215)     // byte - byte
 980 ;testIf.j(216)     println(110);
 981 acc8= constant 110
 982 writeLineAcc8
 983 ;testIf.j(217)     println(111);
 984 acc8= constant 111
 985 writeLineAcc8
 986 ;testIf.j(218)     // acc - stack8
 987 ;testIf.j(219)     // byte - integer
 988 ;testIf.j(220)     println(112);
 989 acc8= constant 112
 990 writeLineAcc8
 991 ;testIf.j(221)     println(113);
 992 acc8= constant 113
 993 writeLineAcc8
 994 ;testIf.j(222)     // acc - stack8
 995 ;testIf.j(223)     // integer - byte
 996 ;testIf.j(224)     println(114);
 997 acc8= constant 114
 998 writeLineAcc8
 999 ;testIf.j(225)     println(115);
1000 acc8= constant 115
1001 writeLineAcc8
1002 ;testIf.j(226)     // acc - stack8
1003 ;testIf.j(227)     // integer - integer
1004 ;testIf.j(228)     println(116);
1005 acc8= constant 116
1006 writeLineAcc8
1007 ;testIf.j(229)     println(117);
1008 acc8= constant 117
1009 writeLineAcc8
1010 ;testIf.j(230)     println(118);
1011 acc8= constant 118
1012 writeLineAcc8
1013 ;testIf.j(231)     println(119);
1014 acc8= constant 119
1015 writeLineAcc8
1016 ;testIf.j(232)   
1017 ;testIf.j(233)     /************************/
1018 ;testIf.j(234)     // acc - stack16
1019 ;testIf.j(235)     // byte - byte
1020 ;testIf.j(236)     println(120);
1021 acc8= constant 120
1022 writeLineAcc8
1023 ;testIf.j(237)     println(121);
1024 acc8= constant 121
1025 writeLineAcc8
1026 ;testIf.j(238)     // acc - stack16
1027 ;testIf.j(239)     // byte - integer
1028 ;testIf.j(240)     println(122);
1029 acc8= constant 122
1030 writeLineAcc8
1031 ;testIf.j(241)     println(123);
1032 acc8= constant 123
1033 writeLineAcc8
1034 ;testIf.j(242)     // acc - stack16
1035 ;testIf.j(243)     // integer - byte
1036 ;testIf.j(244)     println(124);
1037 acc8= constant 124
1038 writeLineAcc8
1039 ;testIf.j(245)     println(125);
1040 acc8= constant 125
1041 writeLineAcc8
1042 ;testIf.j(246)     // acc - stack16
1043 ;testIf.j(247)     // integer - integer
1044 ;testIf.j(248)     println(126);
1045 acc8= constant 126
1046 writeLineAcc8
1047 ;testIf.j(249)     println(127);
1048 acc8= constant 127
1049 writeLineAcc8
1050 ;testIf.j(250)     println(128);
1051 acc8= constant 128
1052 writeLineAcc8
1053 ;testIf.j(251)     println(129);
1054 acc8= constant 129
1055 writeLineAcc8
1056 ;testIf.j(252)   
1057 ;testIf.j(253)     /************************/
1058 ;testIf.j(254)     // var - constant
1059 ;testIf.j(255)     // byte - byte
1060 ;testIf.j(256)     if (b > 10) println(130); else println(999);
1061 acc8= byte variable 6
1062 acc8Comp constant 10
1063 brle 1067
1064 acc8= constant 130
1065 writeLineAcc8
1066 br 1070
1067 acc16= constant 999
1068 writeLineAcc16
1069 ;testIf.j(257)     if (b < 30) println(131); else println(999);
1070 acc8= byte variable 6
1071 acc8Comp constant 30
1072 brge 1076
1073 acc8= constant 131
1074 writeLineAcc8
1075 br 1081
1076 acc16= constant 999
1077 writeLineAcc16
1078 ;testIf.j(258)     // var - constant
1079 ;testIf.j(259)     // byte - integer
1080 ;testIf.j(260)     if (b > 1000) println(999); else println(132);
1081 acc8= byte variable 6
1082 acc16= constant 1000
1083 acc8CompareAcc16
1084 brle 1088
1085 acc16= constant 999
1086 writeLineAcc16
1087 br 1091
1088 acc8= constant 132
1089 writeLineAcc8
1090 ;testIf.j(261)     if (b < 1000) println(133); else println(999);
1091 acc8= byte variable 6
1092 acc16= constant 1000
1093 acc8CompareAcc16
1094 brge 1098
1095 acc8= constant 133
1096 writeLineAcc8
1097 br 1103
1098 acc16= constant 999
1099 writeLineAcc16
1100 ;testIf.j(262)     // var - constant
1101 ;testIf.j(263)     // integer - byte
1102 ;testIf.j(264)     if (i > 1000) println(134); else println(999);
1103 acc16= word variable 0
1104 acc16Comp constant 1000
1105 brle 1109
1106 acc8= constant 134
1107 writeLineAcc8
1108 br 1112
1109 acc16= constant 999
1110 writeLineAcc16
1111 ;testIf.j(265)     if (i < 3000) println(135); else println(999);
1112 acc16= word variable 0
1113 acc16Comp constant 3000
1114 brge 1118
1115 acc8= constant 135
1116 writeLineAcc8
1117 br 1123
1118 acc16= constant 999
1119 writeLineAcc16
1120 ;testIf.j(266)     // var - constant
1121 ;testIf.j(267)     // integer - integer
1122 ;testIf.j(268)     if (i > 1000) println(136); else println(999);
1123 acc16= word variable 0
1124 acc16Comp constant 1000
1125 brle 1129
1126 acc8= constant 136
1127 writeLineAcc8
1128 br 1132
1129 acc16= constant 999
1130 writeLineAcc16
1131 ;testIf.j(269)     if (i < 3000) println(137); else println(999);
1132 acc16= word variable 0
1133 acc16Comp constant 3000
1134 brge 1138
1135 acc8= constant 137
1136 writeLineAcc8
1137 br 1141
1138 acc16= constant 999
1139 writeLineAcc16
1140 ;testIf.j(270)     println(138);
1141 acc8= constant 138
1142 writeLineAcc8
1143 ;testIf.j(271)     println(139);
1144 acc8= constant 139
1145 writeLineAcc8
1146 ;testIf.j(272)   
1147 ;testIf.j(273)     /************************/
1148 ;testIf.j(274)     // var - acc
1149 ;testIf.j(275)     // byte - byte
1150 ;testIf.j(276)     if (b > 10+0) println(140); else println(999);
1151 acc8= constant 10
1152 acc8+ constant 0
1153 acc8Comp byte variable 6
1154 brge 1158
1155 acc8= constant 140
1156 writeLineAcc8
1157 br 1161
1158 acc16= constant 999
1159 writeLineAcc16
1160 ;testIf.j(277)     if (b < 30+0) println(141); else println(999);
1161 acc8= constant 30
1162 acc8+ constant 0
1163 acc8Comp byte variable 6
1164 brle 1168
1165 acc8= constant 141
1166 writeLineAcc8
1167 br 1173
1168 acc16= constant 999
1169 writeLineAcc16
1170 ;testIf.j(278)     // var - acc
1171 ;testIf.j(279)     // byte - integer
1172 ;testIf.j(280)     if (b > 1000+0) println(999); else println(142);
1173 acc16= constant 1000
1174 acc16+ constant 0
1175 acc8= byte variable 6
1176 acc8CompareAcc16
1177 brle 1181
1178 acc16= constant 999
1179 writeLineAcc16
1180 br 1184
1181 acc8= constant 142
1182 writeLineAcc8
1183 ;testIf.j(281)     if (b < 1000+0) println(143); else println(999);
1184 acc16= constant 1000
1185 acc16+ constant 0
1186 acc8= byte variable 6
1187 acc8CompareAcc16
1188 brge 1192
1189 acc8= constant 143
1190 writeLineAcc8
1191 br 1197
1192 acc16= constant 999
1193 writeLineAcc16
1194 ;testIf.j(282)     // var - acc
1195 ;testIf.j(283)     // integer - byte
1196 ;testIf.j(284)     if (i > 1000+0) println(144); else println(999);
1197 acc16= constant 1000
1198 acc16+ constant 0
1199 acc16Comp word variable 0
1200 brge 1204
1201 acc8= constant 144
1202 writeLineAcc8
1203 br 1207
1204 acc16= constant 999
1205 writeLineAcc16
1206 ;testIf.j(285)     if (i < 3000+0) println(145); else println(999);
1207 acc16= constant 3000
1208 acc16+ constant 0
1209 acc16Comp word variable 0
1210 brle 1214
1211 acc8= constant 145
1212 writeLineAcc8
1213 br 1219
1214 acc16= constant 999
1215 writeLineAcc16
1216 ;testIf.j(286)     // var - acc
1217 ;testIf.j(287)     // integer - integer
1218 ;testIf.j(288)     if (i > 1000+0) println(146); else println(999);
1219 acc16= constant 1000
1220 acc16+ constant 0
1221 acc16Comp word variable 0
1222 brge 1226
1223 acc8= constant 146
1224 writeLineAcc8
1225 br 1229
1226 acc16= constant 999
1227 writeLineAcc16
1228 ;testIf.j(289)     if (i < 3000+0) println(147); else println(999);
1229 acc16= constant 3000
1230 acc16+ constant 0
1231 acc16Comp word variable 0
1232 brle 1236
1233 acc8= constant 147
1234 writeLineAcc8
1235 br 1239
1236 acc16= constant 999
1237 writeLineAcc16
1238 ;testIf.j(290)     println(148);
1239 acc8= constant 148
1240 writeLineAcc8
1241 ;testIf.j(291)     println(149);
1242 acc8= constant 149
1243 writeLineAcc8
1244 ;testIf.j(292)   
1245 ;testIf.j(293)     /************************/
1246 ;testIf.j(294)     // var - var
1247 ;testIf.j(295)     // byte - byte
1248 ;testIf.j(296)     if (b > b1) println(150);
1249 acc8= byte variable 6
1250 acc8Comp byte variable 7
1251 brle 1255
1252 acc8= constant 150
1253 writeLineAcc8
1254 ;testIf.j(297)     if (b < b3) println(151);
1255 acc8= byte variable 6
1256 acc8Comp byte variable 8
1257 brge 1263
1258 acc8= constant 151
1259 writeLineAcc8
1260 ;testIf.j(298)     // var - var
1261 ;testIf.j(299)     // byte - integer
1262 ;testIf.j(300)     if (b > i1) println(999); else println(152);
1263 acc8= byte variable 6
1264 acc16= word variable 2
1265 acc8CompareAcc16
1266 brle 1270
1267 acc16= constant 999
1268 writeLineAcc16
1269 br 1273
1270 acc8= constant 152
1271 writeLineAcc8
1272 ;testIf.j(301)     if (b < i3) println(153);
1273 acc8= byte variable 6
1274 acc16= word variable 4
1275 acc8CompareAcc16
1276 brge 1282
1277 acc8= constant 153
1278 writeLineAcc8
1279 ;testIf.j(302)     // var - var
1280 ;testIf.j(303)     // integer - byte
1281 ;testIf.j(304)     if (i > i1) println(154);
1282 acc16= word variable 0
1283 acc16Comp word variable 2
1284 brle 1288
1285 acc8= constant 154
1286 writeLineAcc8
1287 ;testIf.j(305)     if (i < i3) println(155);
1288 acc16= word variable 0
1289 acc16Comp word variable 4
1290 brge 1296
1291 acc8= constant 155
1292 writeLineAcc8
1293 ;testIf.j(306)     // var - var
1294 ;testIf.j(307)     // integer - integer
1295 ;testIf.j(308)     if (i > i1) println(156);
1296 acc16= word variable 0
1297 acc16Comp word variable 2
1298 brle 1302
1299 acc8= constant 156
1300 writeLineAcc8
1301 ;testIf.j(309)     if (i < i3) println(157);
1302 acc16= word variable 0
1303 acc16Comp word variable 4
1304 brge 1308
1305 acc8= constant 157
1306 writeLineAcc8
1307 ;testIf.j(310)     println(158);
1308 acc8= constant 158
1309 writeLineAcc8
1310 ;testIf.j(311)     println(159);
1311 acc8= constant 159
1312 writeLineAcc8
1313 ;testIf.j(312)   
1314 ;testIf.j(313)     /************************/
1315 ;testIf.j(314)     // var - stack8
1316 ;testIf.j(315)     // byte - byte
1317 ;testIf.j(316)   
1318 ;testIf.j(317)     // var - stack8
1319 ;testIf.j(318)     // byte - integer
1320 ;testIf.j(319)   
1321 ;testIf.j(320)     // var - stack8
1322 ;testIf.j(321)     // integer - byte 
1323 ;testIf.j(322)   
1324 ;testIf.j(323)     // var - stack8
1325 ;testIf.j(324)     // integer - integer
1326 ;testIf.j(325)   
1327 ;testIf.j(326)     /************************/
1328 ;testIf.j(327)     // var - stack16
1329 ;testIf.j(328)     // byte - byte
1330 ;testIf.j(329)   
1331 ;testIf.j(330)     // var - stack16
1332 ;testIf.j(331)     // byte - integer
1333 ;testIf.j(332)   
1334 ;testIf.j(333)     // var - stack16
1335 ;testIf.j(334)     // integer - byte
1336 ;testIf.j(335)   
1337 ;testIf.j(336)     // var - stack16
1338 ;testIf.j(337)     // integer - integer
1339 ;testIf.j(338)   
1340 ;testIf.j(339)     /************************/
1341 ;testIf.j(340)     // stack8 - constant
1342 ;testIf.j(341)     // stack8 - acc
1343 ;testIf.j(342)     // stack8 - var
1344 ;testIf.j(343)     // stack8 - stack8
1345 ;testIf.j(344)     // stack8 - stack16
1346 ;testIf.j(345)   
1347 ;testIf.j(346)     /************************/
1348 ;testIf.j(347)     // stack16 - constant
1349 ;testIf.j(348)     // stack16 - acc
1350 ;testIf.j(349)     // stack16 - var
1351 ;testIf.j(350)     // stack16 - stack8
1352 ;testIf.j(351)     // stack16 - stack16
1353 ;testIf.j(352)   
1354 ;testIf.j(353)     println("Klaar");
1355 acc16= stringconstant 1362
1356 writeLineString
1357 ;testIf.j(354)   }
1358 stackPointer= basePointer
1359 basePointer<
1360 return
1361 ;testIf.j(355) }
1362 stringConstant 0 = "Klaar"
