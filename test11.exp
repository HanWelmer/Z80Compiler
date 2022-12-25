   0 ;test11.j(0) /* Program to test generated Z80 assembler code */
   1 ;test11.j(1) class TestFor {
   2 ;test11.j(2)   int i2 = 105;
   3 acc8= constant 105
   4 acc8=> variable 0
   5 ;test11.j(3)   int p = 12;
   6 acc8= constant 12
   7 acc8=> variable 2
   8 ;test11.j(4)   byte b2 = 111;
   9 acc8= constant 111
  10 acc8=> variable 4
  11 ;test11.j(5) 
  12 ;test11.j(6)   /************************/
  13 ;test11.j(7)   // stack8 - constant
  14 ;test11.j(8)   // stack8 - acc
  15 ;test11.j(9)   // stack8 - var
  16 ;test11.j(10)   // stack8 - stack8
  17 ;test11.j(11)   // stack8 - stack16
  18 ;test11.j(12)   //TODO
  19 ;test11.j(13) 
  20 ;test11.j(14)   /************************/
  21 ;test11.j(15)   // stack16 - constant
  22 ;test11.j(16)   // stack16 - acc
  23 ;test11.j(17)   // stack16 - var
  24 ;test11.j(18)   // stack16 - stack8
  25 ;test11.j(19)   // stack16 - stack16
  26 ;test11.j(20)   //TODO
  27 ;test11.j(21) 
  28 ;test11.j(22)   /************************/
  29 ;test11.j(23)   // var - stack16
  30 ;test11.j(24)   // byte - byte
  31 ;test11.j(25)   // byte - integer
  32 ;test11.j(26)   // integer - byte
  33 ;test11.j(27)   // integer - integer
  34 ;test11.j(28)   //TODO
  35 ;test11.j(29) 
  36 ;test11.j(30)   /************************/
  37 ;test11.j(31)   // var - stack8
  38 ;test11.j(32)   // byte - byte
  39 ;test11.j(33)   // byte - integer
  40 ;test11.j(34)   // integer - byte
  41 ;test11.j(35)   // integer - integer
  42 ;test11.j(36)   //TODO
  43 ;test11.j(37) 
  44 ;test11.j(38)   /************************/
  45 ;test11.j(39)   // var - var
  46 ;test11.j(40)   // byte - byte
  47 ;test11.j(41)   b2 = 111;
  48 acc8= constant 111
  49 acc8=> variable 4
  50 ;test11.j(42)   for (byte b = 112; b2 <= b; b--) { write (b); }
  51 acc8= constant 112
  52 acc8=> variable 5
  53 acc8= variable 4
  54 acc8Comp variable 5
  55 brgt 64
  56 br 59
  57 decr8 variable 5
  58 br 53
  59 acc8= variable 5
  60 call writeAcc8
  61 br 57
  62 ;test11.j(43)   // byte - integer
  63 ;test11.j(44)   b2 = 109;
  64 acc8= constant 109
  65 acc8=> variable 4
  66 ;test11.j(45)   for(int i = 110; b2 <= i; i--) { write(i); }
  67 acc8= constant 110
  68 acc8=> variable 5
  69 acc8= variable 4
  70 acc16= variable 5
  71 acc8CompareAcc16
  72 brgt 81
  73 br 76
  74 decr16 variable 5
  75 br 69
  76 acc16= variable 5
  77 call writeAcc16
  78 br 74
  79 ;test11.j(46)   // integer - byte
  80 ;test11.j(47)   i2=107;
  81 acc8= constant 107
  82 acc8=> variable 0
  83 ;test11.j(48)   for (byte b = 108; i2 <= b; b--) { write (b); }
  84 acc8= constant 108
  85 acc8=> variable 5
  86 acc16= variable 0
  87 acc8= variable 5
  88 acc16CompareAcc8
  89 brgt 98
  90 br 93
  91 decr8 variable 5
  92 br 86
  93 acc8= variable 5
  94 call writeAcc8
  95 br 91
  96 ;test11.j(49)   // integer - integer
  97 ;test11.j(50)   i2=105;
  98 acc8= constant 105
  99 acc8=> variable 0
 100 ;test11.j(51)   for(int i = 106; i2 <= i; i--) { write(i); }
 101 acc8= constant 106
 102 acc8=> variable 5
 103 acc16= variable 0
 104 acc16Comp variable 5
 105 brgt 117
 106 br 109
 107 decr16 variable 5
 108 br 103
 109 acc16= variable 5
 110 call writeAcc16
 111 br 107
 112 ;test11.j(52) 
 113 ;test11.j(53)   /************************/
 114 ;test11.j(54)   // var - acc
 115 ;test11.j(55)   // byte - byte
 116 ;test11.j(56)   i2=104;
 117 acc8= constant 104
 118 acc8=> variable 0
 119 ;test11.j(57)   for (byte b = 104; b <= 105+0; b++) { write (i2); i2--; }
 120 acc8= constant 104
 121 acc8=> variable 5
 122 acc8= constant 105
 123 acc8+ constant 0
 124 acc8Comp variable 5
 125 brlt 135
 126 br 129
 127 incr8 variable 5
 128 br 122
 129 acc16= variable 0
 130 call writeAcc16
 131 decr16 variable 0
 132 br 127
 133 ;test11.j(58)   // byte - integer
 134 ;test11.j(59)   i2=103;
 135 acc8= constant 103
 136 acc8=> variable 0
 137 ;test11.j(60)   for (byte b = 102; b <= i2+0; b--) { write (b); i2=i2-2; }
 138 acc8= constant 102
 139 acc8=> variable 5
 140 acc16= variable 0
 141 acc16+ constant 0
 142 acc8= variable 5
 143 acc8CompareAcc16
 144 brgt 156
 145 br 148
 146 decr8 variable 5
 147 br 140
 148 acc8= variable 5
 149 call writeAcc8
 150 acc16= variable 0
 151 acc16- constant 2
 152 acc16=> variable 0
 153 br 146
 154 ;test11.j(61)   // integer - byte
 155 ;test11.j(62)   b2=100;
 156 acc8= constant 100
 157 acc8=> variable 4
 158 ;test11.j(63)   for(int i = 100; i <= 101+0; i++) { write(b2); b2--; }
 159 acc8= constant 100
 160 acc8=> variable 5
 161 acc8= constant 101
 162 acc8+ constant 0
 163 acc16= variable 5
 164 acc16CompareAcc8
 165 brgt 175
 166 br 169
 167 incr16 variable 5
 168 br 161
 169 acc8= variable 4
 170 call writeAcc8
 171 decr8 variable 4
 172 br 167
 173 ;test11.j(64)   // integer - integer
 174 ;test11.j(65)   for(int i = 1098; i <= 1099+0; i++) { write(b2); b2--; }
 175 acc16= constant 1098
 176 acc16=> variable 5
 177 acc16= constant 1099
 178 acc16+ constant 0
 179 acc16Comp variable 5
 180 brlt 193
 181 br 184
 182 incr16 variable 5
 183 br 177
 184 acc8= variable 4
 185 call writeAcc8
 186 decr8 variable 4
 187 br 182
 188 ;test11.j(66) 
 189 ;test11.j(67)   /************************/
 190 ;test11.j(68)   // var - constant
 191 ;test11.j(69)   // byte - byte
 192 ;test11.j(70)   i2=96;
 193 acc8= constant 96
 194 acc8=> variable 0
 195 ;test11.j(71)   for (byte b = 96; b <= 97; b++) { write (i2); i2--; }
 196 acc8= constant 96
 197 acc8=> variable 5
 198 acc8= variable 5
 199 acc8Comp constant 97
 200 brgt 211
 201 br 204
 202 incr8 variable 5
 203 br 198
 204 acc16= variable 0
 205 call writeAcc16
 206 decr16 variable 0
 207 br 202
 208 ;test11.j(72)   // byte - integer
 209 ;test11.j(73)   //not relevant
 210 ;test11.j(74)   write(94);
 211 acc8= constant 94
 212 call writeAcc8
 213 ;test11.j(75)   write(93);
 214 acc8= constant 93
 215 call writeAcc8
 216 ;test11.j(76)   // integer - byte
 217 ;test11.j(77)   b2=92;
 218 acc8= constant 92
 219 acc8=> variable 4
 220 ;test11.j(78)   for(int i = 92; i <= 93; i++) { write(b2); b2--; }
 221 acc8= constant 92
 222 acc8=> variable 5
 223 acc16= variable 5
 224 acc8= constant 93
 225 acc16CompareAcc8
 226 brgt 236
 227 br 230
 228 incr16 variable 5
 229 br 223
 230 acc8= variable 4
 231 call writeAcc8
 232 decr8 variable 4
 233 br 228
 234 ;test11.j(79)   // integer - integer
 235 ;test11.j(80)   for(int i = 1090; i <= 1091; i++) { write(b2); b2--; }
 236 acc16= constant 1090
 237 acc16=> variable 5
 238 acc16= variable 5
 239 acc16Comp constant 1091
 240 brgt 254
 241 br 244
 242 incr16 variable 5
 243 br 238
 244 acc8= variable 4
 245 call writeAcc8
 246 decr8 variable 4
 247 br 242
 248 ;test11.j(81) 
 249 ;test11.j(82)   /************************/
 250 ;test11.j(83)   // acc - stack8
 251 ;test11.j(84)   // byte - byte
 252 ;test11.j(85)   //TODO
 253 ;test11.j(86)   write(88);
 254 acc8= constant 88
 255 call writeAcc8
 256 ;test11.j(87)   write(87);
 257 acc8= constant 87
 258 call writeAcc8
 259 ;test11.j(88)   // byte - integer
 260 ;test11.j(89)   //TODO
 261 ;test11.j(90)   write(86);
 262 acc8= constant 86
 263 call writeAcc8
 264 ;test11.j(91)   write(85);
 265 acc8= constant 85
 266 call writeAcc8
 267 ;test11.j(92)   // integer - byte
 268 ;test11.j(93)   //TODO
 269 ;test11.j(94)   write(84);
 270 acc8= constant 84
 271 call writeAcc8
 272 ;test11.j(95)   write(83);
 273 acc8= constant 83
 274 call writeAcc8
 275 ;test11.j(96)   // integer - integer
 276 ;test11.j(97)   //TODO
 277 ;test11.j(98)   write(82);
 278 acc8= constant 82
 279 call writeAcc8
 280 ;test11.j(99)   write(81);
 281 acc8= constant 81
 282 call writeAcc8
 283 ;test11.j(100) 
 284 ;test11.j(101)   /************************/
 285 ;test11.j(102)   // acc - stack16
 286 ;test11.j(103)   // byte - byte
 287 ;test11.j(104)   //TODO
 288 ;test11.j(105)   write(80);
 289 acc8= constant 80
 290 call writeAcc8
 291 ;test11.j(106)   write(79);
 292 acc8= constant 79
 293 call writeAcc8
 294 ;test11.j(107)   // byte - integer
 295 ;test11.j(108)   //TODO
 296 ;test11.j(109)   write(78);
 297 acc8= constant 78
 298 call writeAcc8
 299 ;test11.j(110)   write(77);
 300 acc8= constant 77
 301 call writeAcc8
 302 ;test11.j(111)   // integer - byte
 303 ;test11.j(112)   //TODO
 304 ;test11.j(113)   write(76);
 305 acc8= constant 76
 306 call writeAcc8
 307 ;test11.j(114)   write(75);
 308 acc8= constant 75
 309 call writeAcc8
 310 ;test11.j(115)   // integer - integer
 311 ;test11.j(116)   //TODO
 312 ;test11.j(117)   write(74);
 313 acc8= constant 74
 314 call writeAcc8
 315 ;test11.j(118)   write(73);
 316 acc8= constant 73
 317 call writeAcc8
 318 ;test11.j(119) 
 319 ;test11.j(120)   /************************/
 320 ;test11.j(121)   // acc - var
 321 ;test11.j(122)   // byte - byte
 322 ;test11.j(123)   for (byte b = 72; 71+0 <= b; b--) { write (b); }
 323 acc8= constant 72
 324 acc8=> variable 5
 325 acc8= constant 71
 326 acc8+ constant 0
 327 acc8Comp variable 5
 328 brgt 337
 329 br 332
 330 decr8 variable 5
 331 br 325
 332 acc8= variable 5
 333 call writeAcc8
 334 br 330
 335 ;test11.j(124)   // byte - integer
 336 ;test11.j(125)   for(int i = 70; 69+0 <= i; i--) { write(i); }
 337 acc8= constant 70
 338 acc8=> variable 5
 339 acc8= constant 69
 340 acc8+ constant 0
 341 acc16= variable 5
 342 acc8CompareAcc16
 343 brgt 352
 344 br 347
 345 decr16 variable 5
 346 br 339
 347 acc16= variable 5
 348 call writeAcc16
 349 br 345
 350 ;test11.j(126)   // integer - byte
 351 ;test11.j(127)   i2=67;
 352 acc8= constant 67
 353 acc8=> variable 0
 354 ;test11.j(128)   for (byte b = 68; i2+0 <= b; b--) { write (b); }
 355 acc8= constant 68
 356 acc8=> variable 5
 357 acc16= variable 0
 358 acc16+ constant 0
 359 acc8= variable 5
 360 acc16CompareAcc8
 361 brgt 370
 362 br 365
 363 decr8 variable 5
 364 br 357
 365 acc8= variable 5
 366 call writeAcc8
 367 br 363
 368 ;test11.j(129)   // integer - integer
 369 ;test11.j(130)   b2 = 66;
 370 acc8= constant 66
 371 acc8=> variable 4
 372 ;test11.j(131)   for(int i = 1066; 1000+65 <= i; i--) { write (b2); b2--; }
 373 acc16= constant 1066
 374 acc16=> variable 5
 375 acc16= constant 1000
 376 acc16+ constant 65
 377 acc16Comp variable 5
 378 brgt 391
 379 br 382
 380 decr16 variable 5
 381 br 375
 382 acc8= variable 4
 383 call writeAcc8
 384 decr8 variable 4
 385 br 380
 386 ;test11.j(132) 
 387 ;test11.j(133)   /************************/
 388 ;test11.j(134)   // acc - acc
 389 ;test11.j(135)   // byte - byte
 390 ;test11.j(136)   for (byte b = 64; 63+0 <= b+0; b--) { write (b); }
 391 acc8= constant 64
 392 acc8=> variable 5
 393 acc8= constant 63
 394 acc8+ constant 0
 395 <acc8
 396 acc8= variable 5
 397 acc8+ constant 0
 398 revAcc8Comp unstack8
 399 brlt 408
 400 br 403
 401 decr8 variable 5
 402 br 393
 403 acc8= variable 5
 404 call writeAcc8
 405 br 401
 406 ;test11.j(137)   // byte - integer
 407 ;test11.j(138)   for(int i = 62; 61+0 <= i+0; i--) { write(i); }
 408 acc8= constant 62
 409 acc8=> variable 5
 410 acc8= constant 61
 411 acc8+ constant 0
 412 <acc8
 413 acc16= variable 5
 414 acc16+ constant 0
 415 acc8= unstack8
 416 acc8CompareAcc16
 417 brgt 426
 418 br 421
 419 decr16 variable 5
 420 br 410
 421 acc16= variable 5
 422 call writeAcc16
 423 br 419
 424 ;test11.j(139)   // integer - byte
 425 ;test11.j(140)   i2=59;
 426 acc8= constant 59
 427 acc8=> variable 0
 428 ;test11.j(141)   for (byte b = 60; i2+0 <= b+0; b--) { write (b); }
 429 acc8= constant 60
 430 acc8=> variable 5
 431 acc16= variable 0
 432 acc16+ constant 0
 433 <acc16
 434 acc8= variable 5
 435 acc8+ constant 0
 436 acc16= unstack16
 437 acc16CompareAcc8
 438 brgt 447
 439 br 442
 440 decr8 variable 5
 441 br 431
 442 acc8= variable 5
 443 call writeAcc8
 444 br 440
 445 ;test11.j(142)   // integer - integer
 446 ;test11.j(143)   b2=58;
 447 acc8= constant 58
 448 acc8=> variable 4
 449 ;test11.j(144)   for(int i = 1058; 1000+57 <= i+0; i--) { write(b2); b2--; }
 450 acc16= constant 1058
 451 acc16=> variable 5
 452 acc16= constant 1000
 453 acc16+ constant 57
 454 <acc16
 455 acc16= variable 5
 456 acc16+ constant 0
 457 revAcc16Comp unstack16
 458 brlt 471
 459 br 462
 460 decr16 variable 5
 461 br 452
 462 acc8= variable 4
 463 call writeAcc8
 464 decr8 variable 4
 465 br 460
 466 ;test11.j(145) 
 467 ;test11.j(146)   /************************/
 468 ;test11.j(147)   // acc - constant
 469 ;test11.j(148)   // byte - byte
 470 ;test11.j(149)   i2=56;
 471 acc8= constant 56
 472 acc8=> variable 0
 473 ;test11.j(150)   for (byte b = 56; b+0 <= 57; b++) { write (i2); i2--; }
 474 acc8= constant 56
 475 acc8=> variable 5
 476 acc8= variable 5
 477 acc8+ constant 0
 478 acc8Comp constant 57
 479 brgt 491
 480 br 483
 481 incr8 variable 5
 482 br 476
 483 acc16= variable 0
 484 call writeAcc16
 485 decr16 variable 0
 486 br 481
 487 ;test11.j(151)   // byte - integer
 488 ;test11.j(152)   //not relevant
 489 ;test11.j(153)   // integer - byte
 490 ;test11.j(154)   b2=54;
 491 acc8= constant 54
 492 acc8=> variable 4
 493 ;test11.j(155)   for (int i = 54; i+0 <= 55; i++) { write (b2); b2--;}
 494 acc8= constant 54
 495 acc8=> variable 5
 496 acc16= variable 5
 497 acc16+ constant 0
 498 acc8= constant 55
 499 acc16CompareAcc8
 500 brgt 510
 501 br 504
 502 incr16 variable 5
 503 br 496
 504 acc8= variable 4
 505 call writeAcc8
 506 decr8 variable 4
 507 br 502
 508 ;test11.j(156)   // integer - integer
 509 ;test11.j(157)   b2=52;
 510 acc8= constant 52
 511 acc8=> variable 4
 512 ;test11.j(158)   for(int i = 1052; i+0 <= 1053; i++) { write(b2); b2--; }
 513 acc16= constant 1052
 514 acc16=> variable 5
 515 acc16= variable 5
 516 acc16+ constant 0
 517 acc16Comp constant 1053
 518 brgt 532
 519 br 522
 520 incr16 variable 5
 521 br 515
 522 acc8= variable 4
 523 call writeAcc8
 524 decr8 variable 4
 525 br 520
 526 ;test11.j(159) 
 527 ;test11.j(160)   /************************/
 528 ;test11.j(161)   // constant - stack8
 529 ;test11.j(162)   // byte - byte
 530 ;test11.j(163)   //TODO
 531 ;test11.j(164)   write(50);
 532 acc8= constant 50
 533 call writeAcc8
 534 ;test11.j(165)   // constant - stack8
 535 ;test11.j(166)   // byte - integer
 536 ;test11.j(167)   //TODO
 537 ;test11.j(168)   write(49);
 538 acc8= constant 49
 539 call writeAcc8
 540 ;test11.j(169)   // constant - stack8
 541 ;test11.j(170)   // integer - byte
 542 ;test11.j(171)   //TODO
 543 ;test11.j(172)   write(48);
 544 acc8= constant 48
 545 call writeAcc8
 546 ;test11.j(173)   // constant - stack88
 547 ;test11.j(174)   // integer - integer
 548 ;test11.j(175)   //TODO
 549 ;test11.j(176)   write(47);
 550 acc8= constant 47
 551 call writeAcc8
 552 ;test11.j(177) 
 553 ;test11.j(178)   /************************/
 554 ;test11.j(179)   // constant - stack16
 555 ;test11.j(180)   // byte - byte
 556 ;test11.j(181)   //TODO
 557 ;test11.j(182)   write(46);
 558 acc8= constant 46
 559 call writeAcc8
 560 ;test11.j(183)   // constant - stack16
 561 ;test11.j(184)   // byte - integer
 562 ;test11.j(185)   //TODO
 563 ;test11.j(186)   write(45);
 564 acc8= constant 45
 565 call writeAcc8
 566 ;test11.j(187)   // constant - stack16
 567 ;test11.j(188)   // integer - byte
 568 ;test11.j(189)   //TODO
 569 ;test11.j(190)   write(44);
 570 acc8= constant 44
 571 call writeAcc8
 572 ;test11.j(191)   // constant - stack16
 573 ;test11.j(192)   // integer - integer
 574 ;test11.j(193)   //TODO
 575 ;test11.j(194)   write(43);
 576 acc8= constant 43
 577 call writeAcc8
 578 ;test11.j(195) 
 579 ;test11.j(196)   /************************/
 580 ;test11.j(197)   // constant - var
 581 ;test11.j(198)   // byte - byte
 582 ;test11.j(199)   for (byte b = 42; 41 <= b; b--) { write (b); }
 583 acc8= constant 42
 584 acc8=> variable 5
 585 acc8= variable 5
 586 acc8Comp constant 41
 587 brlt 597
 588 br 591
 589 decr8 variable 5
 590 br 585
 591 acc8= variable 5
 592 call writeAcc8
 593 br 589
 594 ;test11.j(200)   // constant - var
 595 ;test11.j(201)   // byte - integer
 596 ;test11.j(202)   for(int i = 40; 39 <= i; i--) { write(i); }
 597 acc8= constant 40
 598 acc8=> variable 5
 599 acc16= variable 5
 600 acc8= constant 39
 601 acc8CompareAcc16
 602 brgt 615
 603 br 606
 604 decr16 variable 5
 605 br 599
 606 acc16= variable 5
 607 call writeAcc16
 608 br 604
 609 ;test11.j(203)   // constant - var
 610 ;test11.j(204)   // integer - byte
 611 ;test11.j(205)   // not relevant
 612 ;test11.j(206)   // constant - var
 613 ;test11.j(207)   // integer - integer
 614 ;test11.j(208)   b2=38;
 615 acc8= constant 38
 616 acc8=> variable 4
 617 ;test11.j(209)   for(int i = 1038; 1037 <= i; i--) { write(b2); b2--; }
 618 acc16= constant 1038
 619 acc16=> variable 5
 620 acc16= variable 5
 621 acc16Comp constant 1037
 622 brlt 635
 623 br 626
 624 decr16 variable 5
 625 br 620
 626 acc8= variable 4
 627 call writeAcc8
 628 decr8 variable 4
 629 br 624
 630 ;test11.j(210) 
 631 ;test11.j(211)   /************************/
 632 ;test11.j(212)   // constant - acc
 633 ;test11.j(213)   // byte - byte
 634 ;test11.j(214)   for (byte b = 36; 136 == b+100; b--) { write (b); }
 635 acc8= constant 36
 636 acc8=> variable 5
 637 acc8= variable 5
 638 acc8+ constant 100
 639 acc8Comp constant 136
 640 brne 648
 641 br 644
 642 decr8 variable 5
 643 br 637
 644 acc8= variable 5
 645 call writeAcc8
 646 br 642
 647 ;test11.j(215)   for (byte b = 35; 132 != b+100; b--) { write (b); }
 648 acc8= constant 35
 649 acc8=> variable 5
 650 acc8= variable 5
 651 acc8+ constant 100
 652 acc8Comp constant 132
 653 breq 661
 654 br 657
 655 decr8 variable 5
 656 br 650
 657 acc8= variable 5
 658 call writeAcc8
 659 br 655
 660 ;test11.j(216)   b2=32;
 661 acc8= constant 32
 662 acc8=> variable 4
 663 ;test11.j(217)   for (byte b = 32; 134 > b+100; b++) { write (b2); b2--; }
 664 acc8= constant 32
 665 acc8=> variable 5
 666 acc8= variable 5
 667 acc8+ constant 100
 668 acc8Comp constant 134
 669 brge 678
 670 br 673
 671 incr8 variable 5
 672 br 666
 673 acc8= variable 4
 674 call writeAcc8
 675 decr8 variable 4
 676 br 671
 677 ;test11.j(218)   for (byte b = 34; 135 >= b+100; b++) { write (b2); b2--; }
 678 acc8= constant 34
 679 acc8=> variable 5
 680 acc8= variable 5
 681 acc8+ constant 100
 682 acc8Comp constant 135
 683 brgt 692
 684 br 687
 685 incr8 variable 5
 686 br 680
 687 acc8= variable 4
 688 call writeAcc8
 689 decr8 variable 4
 690 br 685
 691 ;test11.j(219)   for (byte b = 28; 126 <  b+100; b--) { write (b); }
 692 acc8= constant 28
 693 acc8=> variable 5
 694 acc8= variable 5
 695 acc8+ constant 100
 696 acc8Comp constant 126
 697 brle 705
 698 br 701
 699 decr8 variable 5
 700 br 694
 701 acc8= variable 5
 702 call writeAcc8
 703 br 699
 704 ;test11.j(220)   for (byte b = 26; 125 <= b+100; b--) { write (b); }
 705 acc8= constant 26
 706 acc8=> variable 5
 707 acc8= variable 5
 708 acc8+ constant 100
 709 acc8Comp constant 125
 710 brlt 720
 711 br 714
 712 decr8 variable 5
 713 br 707
 714 acc8= variable 5
 715 call writeAcc8
 716 br 712
 717 ;test11.j(221)   // constant - acc
 718 ;test11.j(222)   // byte - integer
 719 ;test11.j(223)   for(int i = 24; 24 == i+0; i--) { write(i); }
 720 acc8= constant 24
 721 acc8=> variable 5
 722 acc16= variable 5
 723 acc16+ constant 0
 724 acc8= constant 24
 725 acc8CompareAcc16
 726 brne 734
 727 br 730
 728 decr16 variable 5
 729 br 722
 730 acc16= variable 5
 731 call writeAcc16
 732 br 728
 733 ;test11.j(224)   for(int i = 23; 120 != i+100; i--) { write(i); }
 734 acc8= constant 23
 735 acc8=> variable 5
 736 acc16= variable 5
 737 acc16+ constant 100
 738 acc8= constant 120
 739 acc8CompareAcc16
 740 breq 748
 741 br 744
 742 decr16 variable 5
 743 br 736
 744 acc16= variable 5
 745 call writeAcc16
 746 br 742
 747 ;test11.j(225)   b2=20;
 748 acc8= constant 20
 749 acc8=> variable 4
 750 ;test11.j(226)   for(int i = 20; 122 > i+100; i++) { write (b2); b2--; }
 751 acc8= constant 20
 752 acc8=> variable 5
 753 acc16= variable 5
 754 acc16+ constant 100
 755 acc8= constant 122
 756 acc8CompareAcc16
 757 brle 766
 758 br 761
 759 incr16 variable 5
 760 br 753
 761 acc8= variable 4
 762 call writeAcc8
 763 decr8 variable 4
 764 br 759
 765 ;test11.j(227)   for(int i = 22; 123 >= i+100; i++) { write (b2); b2--; }
 766 acc8= constant 22
 767 acc8=> variable 5
 768 acc16= variable 5
 769 acc16+ constant 100
 770 acc8= constant 123
 771 acc8CompareAcc16
 772 brlt 781
 773 br 776
 774 incr16 variable 5
 775 br 768
 776 acc8= variable 4
 777 call writeAcc8
 778 decr8 variable 4
 779 br 774
 780 ;test11.j(228)   for(int i = 16; 114 <  i+100; i--) { write(i); }
 781 acc8= constant 16
 782 acc8=> variable 5
 783 acc16= variable 5
 784 acc16+ constant 100
 785 acc8= constant 114
 786 acc8CompareAcc16
 787 brge 795
 788 br 791
 789 decr16 variable 5
 790 br 783
 791 acc16= variable 5
 792 call writeAcc16
 793 br 789
 794 ;test11.j(229)   for(int i = 14; 113 <= i+100; i--) { write(i); }
 795 acc8= constant 14
 796 acc8=> variable 5
 797 acc16= variable 5
 798 acc16+ constant 100
 799 acc8= constant 113
 800 acc8CompareAcc16
 801 brgt 815
 802 br 805
 803 decr16 variable 5
 804 br 797
 805 acc16= variable 5
 806 call writeAcc16
 807 br 803
 808 ;test11.j(230)   // constant - acc
 809 ;test11.j(231)   // integer - byte
 810 ;test11.j(232)   // not relevant
 811 ;test11.j(233) 
 812 ;test11.j(234)   // constant - acc
 813 ;test11.j(235)   // integer - integer
 814 ;test11.j(236)   for(int i = 12; 1012 == i+1000; i--) { write(i); }
 815 acc8= constant 12
 816 acc8=> variable 5
 817 acc16= variable 5
 818 acc16+ constant 1000
 819 acc16Comp constant 1012
 820 brne 828
 821 br 824
 822 decr16 variable 5
 823 br 817
 824 acc16= variable 5
 825 call writeAcc16
 826 br 822
 827 ;test11.j(237)   for(int i = 11; 1008 != i+1000; i--) { write(i); }
 828 acc8= constant 11
 829 acc8=> variable 5
 830 acc16= variable 5
 831 acc16+ constant 1000
 832 acc16Comp constant 1008
 833 breq 841
 834 br 837
 835 decr16 variable 5
 836 br 830
 837 acc16= variable 5
 838 call writeAcc16
 839 br 835
 840 ;test11.j(238)   b2=8;
 841 acc8= constant 8
 842 acc8=> variable 4
 843 ;test11.j(239)   for(int i = 8; 1010 > i+1000; i++) { write (b2); b2--; }
 844 acc8= constant 8
 845 acc8=> variable 5
 846 acc16= variable 5
 847 acc16+ constant 1000
 848 acc16Comp constant 1010
 849 brge 858
 850 br 853
 851 incr16 variable 5
 852 br 846
 853 acc8= variable 4
 854 call writeAcc8
 855 decr8 variable 4
 856 br 851
 857 ;test11.j(240)   for(int i = 10; 1011 >= i+1000; i++) { write (b2); b2--; }
 858 acc8= constant 10
 859 acc8=> variable 5
 860 acc16= variable 5
 861 acc16+ constant 1000
 862 acc16Comp constant 1011
 863 brgt 872
 864 br 867
 865 incr16 variable 5
 866 br 860
 867 acc8= variable 4
 868 call writeAcc8
 869 decr8 variable 4
 870 br 865
 871 ;test11.j(241)   for(int i = 4; 1002 <  i+1000; i--) { write(i); }
 872 acc8= constant 4
 873 acc8=> variable 5
 874 acc16= variable 5
 875 acc16+ constant 1000
 876 acc16Comp constant 1002
 877 brle 885
 878 br 881
 879 decr16 variable 5
 880 br 874
 881 acc16= variable 5
 882 call writeAcc16
 883 br 879
 884 ;test11.j(242)   for(int i = 2; 1001 <= i+1000; i--) { write(i); }
 885 acc8= constant 2
 886 acc8=> variable 5
 887 acc16= variable 5
 888 acc16+ constant 1000
 889 acc16Comp constant 1001
 890 brlt 898
 891 br 894
 892 decr16 variable 5
 893 br 887
 894 acc16= variable 5
 895 call writeAcc16
 896 br 892
 897 ;test11.j(243)   write(0);
 898 acc8= constant 0
 899 call writeAcc8
 900 ;test11.j(244) }
 901 stop
