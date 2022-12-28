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
  20 ;test2.j(8)     /*Possible operand types: 
  21 ;test2.j(9)      * leftOperand:  constant, acc, var, stack16, stack8
  22 ;test2.j(10)      * rightOperand: constant, acc, var, stack16, stack8
  23 ;test2.j(11)      *Possible datatype combinations:
  24 ;test2.j(12)      * integer - integer
  25 ;test2.j(13)      * integer - byte
  26 ;test2.j(14)      * byte - integer
  27 ;test2.j(15)      * byte - byte
  28 ;test2.j(16)     */
  29 ;test2.j(17) 
  30 ;test2.j(18)   /************************/
  31 ;test2.j(19)   // stack16 - constant
  32 ;test2.j(20)   // stack16 - acc
  33 ;test2.j(21)   // stack16 - var
  34 ;test2.j(22)   // stack16 - stack16
  35 ;test2.j(23)   // stack16 - stack8
  36 ;test2.j(24) 
  37 ;test2.j(25)   /************************/
  38 ;test2.j(26)   // stack8 - constant
  39 ;test2.j(27)   // stack8 - acc
  40 ;test2.j(28)   // stack8 - var
  41 ;test2.j(29)   // stack8 - stack16
  42 ;test2.j(30)   // stack8 - stack8
  43 ;test2.j(31) 
  44 ;test2.j(32)   /************************/
  45 ;test2.j(33)   // var - stack8
  46 ;test2.j(34)   // integer - integer
  47 ;test2.j(35) 
  48 ;test2.j(36)   // var - stack8
  49 ;test2.j(37)   // integer - byte 
  50 ;test2.j(38) 
  51 ;test2.j(39)   // var - stack8
  52 ;test2.j(40)   // byte - integer
  53 ;test2.j(41) 
  54 ;test2.j(42)   // var - stack8
  55 ;test2.j(43)   // byte - byte
  56 ;test2.j(44) 
  57 ;test2.j(45)   /************************/
  58 ;test2.j(46)   // var - stack16
  59 ;test2.j(47)   // integer - integer
  60 ;test2.j(48) 
  61 ;test2.j(49)   // var - stack16
  62 ;test2.j(50)   // integer - byte
  63 ;test2.j(51) 
  64 ;test2.j(52)   // var - stack16
  65 ;test2.j(53)   // byte - integer
  66 ;test2.j(54) 
  67 ;test2.j(55)   // var - stack16
  68 ;test2.j(56)   // byte - byte
  69 ;test2.j(57) 
  70 ;test2.j(58)   /************************/
  71 ;test2.j(59)   // var - var
  72 ;test2.j(60)   // integer - integer
  73 ;test2.j(61)   write(159);
  74 acc8= constant 159
  75 call writeAcc8
  76 ;test2.j(62)   write(158);
  77 acc8= constant 158
  78 call writeAcc8
  79 ;test2.j(63)   if (i > i1) write(157);
  80 acc16= variable 0
  81 acc16Comp variable 2
  82 brle 86
  83 acc8= constant 157
  84 call writeAcc8
  85 ;test2.j(64)   if (i < i3) write(156);
  86 acc16= variable 0
  87 acc16Comp variable 4
  88 brge 94
  89 acc8= constant 156
  90 call writeAcc8
  91 ;test2.j(65)   // var - var
  92 ;test2.j(66)   // integer - byte
  93 ;test2.j(67)   if (i > i1) write(155);
  94 acc16= variable 0
  95 acc16Comp variable 2
  96 brle 100
  97 acc8= constant 155
  98 call writeAcc8
  99 ;test2.j(68)   if (i < i3) write(154);
 100 acc16= variable 0
 101 acc16Comp variable 4
 102 brge 108
 103 acc8= constant 154
 104 call writeAcc8
 105 ;test2.j(69)   // var - var
 106 ;test2.j(70)   // byte - integer
 107 ;test2.j(71)   if (b > i1) write(999); else write(153);
 108 acc8= variable 6
 109 acc16= variable 2
 110 acc8CompareAcc16
 111 brle 115
 112 acc16= constant 999
 113 call writeAcc16
 114 br 118
 115 acc8= constant 153
 116 call writeAcc8
 117 ;test2.j(72)   if (b < i3) write(152);
 118 acc8= variable 6
 119 acc16= variable 4
 120 acc8CompareAcc16
 121 brge 127
 122 acc8= constant 152
 123 call writeAcc8
 124 ;test2.j(73)   // var - var
 125 ;test2.j(74)   // byte - byte
 126 ;test2.j(75)   if (b > b1) write(151);
 127 acc8= variable 6
 128 acc8Comp variable 7
 129 brle 133
 130 acc8= constant 151
 131 call writeAcc8
 132 ;test2.j(76)   if (b < b3) write(150);
 133 acc8= variable 6
 134 acc8Comp variable 8
 135 brge 143
 136 acc8= constant 150
 137 call writeAcc8
 138 ;test2.j(77) 
 139 ;test2.j(78)   /************************/
 140 ;test2.j(79)   // var - acc
 141 ;test2.j(80)   // integer - integer
 142 ;test2.j(81)   write(149);
 143 acc8= constant 149
 144 call writeAcc8
 145 ;test2.j(82)   write(148);
 146 acc8= constant 148
 147 call writeAcc8
 148 ;test2.j(83)   if (i > 1000+0) write(147);
 149 acc16= constant 1000
 150 acc16+ constant 0
 151 acc16Comp variable 0
 152 brge 156
 153 acc8= constant 147
 154 call writeAcc8
 155 ;test2.j(84)   if (i < 3000+0) write(146);
 156 acc16= constant 3000
 157 acc16+ constant 0
 158 acc16Comp variable 0
 159 brle 165
 160 acc8= constant 146
 161 call writeAcc8
 162 ;test2.j(85)   // var - acc
 163 ;test2.j(86)   // integer - byte
 164 ;test2.j(87)   if (i > 1000+0) write(145);
 165 acc16= constant 1000
 166 acc16+ constant 0
 167 acc16Comp variable 0
 168 brge 172
 169 acc8= constant 145
 170 call writeAcc8
 171 ;test2.j(88)   if (i < 3000+0) write(144);
 172 acc16= constant 3000
 173 acc16+ constant 0
 174 acc16Comp variable 0
 175 brle 181
 176 acc8= constant 144
 177 call writeAcc8
 178 ;test2.j(89)   // var - acc
 179 ;test2.j(90)   // byte - integer
 180 ;test2.j(91)   if (b > 1000+0) write(999); else write(143);
 181 acc16= constant 1000
 182 acc16+ constant 0
 183 acc8= variable 6
 184 acc8CompareAcc16
 185 brle 189
 186 acc16= constant 999
 187 call writeAcc16
 188 br 192
 189 acc8= constant 143
 190 call writeAcc8
 191 ;test2.j(92)   if (b < 1000+0) write(142);
 192 acc16= constant 1000
 193 acc16+ constant 0
 194 acc8= variable 6
 195 acc8CompareAcc16
 196 brge 202
 197 acc8= constant 142
 198 call writeAcc8
 199 ;test2.j(93)   // var - acc
 200 ;test2.j(94)   // byte - byte
 201 ;test2.j(95)   if (b > 10+0) write(141);
 202 acc8= constant 10
 203 acc8+ constant 0
 204 acc8Comp variable 6
 205 brge 209
 206 acc8= constant 141
 207 call writeAcc8
 208 ;test2.j(96)   if (b < 30+0) write(140);
 209 acc8= constant 30
 210 acc8+ constant 0
 211 acc8Comp variable 6
 212 brle 220
 213 acc8= constant 140
 214 call writeAcc8
 215 ;test2.j(97) 
 216 ;test2.j(98)   /************************/
 217 ;test2.j(99)   // var - constant
 218 ;test2.j(100)   // integer - integer
 219 ;test2.j(101)   write(139);
 220 acc8= constant 139
 221 call writeAcc8
 222 ;test2.j(102)   write(138);
 223 acc8= constant 138
 224 call writeAcc8
 225 ;test2.j(103)   if (i > 1000) write(137);
 226 acc16= variable 0
 227 acc16Comp constant 1000
 228 brle 232
 229 acc8= constant 137
 230 call writeAcc8
 231 ;test2.j(104)   if (i < 3000) write(136);
 232 acc16= variable 0
 233 acc16Comp constant 3000
 234 brge 240
 235 acc8= constant 136
 236 call writeAcc8
 237 ;test2.j(105)   // var - constant
 238 ;test2.j(106)   // integer - byte
 239 ;test2.j(107)   if (i > 1000) write(135);
 240 acc16= variable 0
 241 acc16Comp constant 1000
 242 brle 246
 243 acc8= constant 135
 244 call writeAcc8
 245 ;test2.j(108)   if (i < 3000) write(134);
 246 acc16= variable 0
 247 acc16Comp constant 3000
 248 brge 254
 249 acc8= constant 134
 250 call writeAcc8
 251 ;test2.j(109)   // var - constant
 252 ;test2.j(110)   // byte - integer
 253 ;test2.j(111)   if (b > 1000) write(999); else write(133);
 254 acc8= variable 6
 255 acc16= constant 1000
 256 acc8CompareAcc16
 257 brle 261
 258 acc16= constant 999
 259 call writeAcc16
 260 br 264
 261 acc8= constant 133
 262 call writeAcc8
 263 ;test2.j(112)   if (b < 1000) write(132);
 264 acc8= variable 6
 265 acc16= constant 1000
 266 acc8CompareAcc16
 267 brge 273
 268 acc8= constant 132
 269 call writeAcc8
 270 ;test2.j(113)   // var - constant
 271 ;test2.j(114)   // byte - byte
 272 ;test2.j(115)   if (b > 10) write(131);
 273 acc8= variable 6
 274 acc8Comp constant 10
 275 brle 279
 276 acc8= constant 131
 277 call writeAcc8
 278 ;test2.j(116)   if (b < 30) write(130);
 279 acc8= variable 6
 280 acc8Comp constant 30
 281 brge 289
 282 acc8= constant 130
 283 call writeAcc8
 284 ;test2.j(117) 
 285 ;test2.j(118)   /************************/
 286 ;test2.j(119)   // acc - stack8
 287 ;test2.j(120)   // integer - integer
 288 ;test2.j(121)   write(129);
 289 acc8= constant 129
 290 call writeAcc8
 291 ;test2.j(122)   write(128);
 292 acc8= constant 128
 293 call writeAcc8
 294 ;test2.j(123)   write(127);
 295 acc8= constant 127
 296 call writeAcc8
 297 ;test2.j(124)   write(126);
 298 acc8= constant 126
 299 call writeAcc8
 300 ;test2.j(125)   // acc - stack8
 301 ;test2.j(126)   // integer - byte
 302 ;test2.j(127)   write(125);
 303 acc8= constant 125
 304 call writeAcc8
 305 ;test2.j(128)   write(124);
 306 acc8= constant 124
 307 call writeAcc8
 308 ;test2.j(129)   // acc - stack8
 309 ;test2.j(130)   // byte - integer
 310 ;test2.j(131)   write(123);
 311 acc8= constant 123
 312 call writeAcc8
 313 ;test2.j(132)   write(122);
 314 acc8= constant 122
 315 call writeAcc8
 316 ;test2.j(133)   // acc - stack8
 317 ;test2.j(134)   // byte - byte
 318 ;test2.j(135)   write(121);
 319 acc8= constant 121
 320 call writeAcc8
 321 ;test2.j(136)   write(120);
 322 acc8= constant 120
 323 call writeAcc8
 324 ;test2.j(137) 
 325 ;test2.j(138)   /************************/
 326 ;test2.j(139)   // acc - stack16
 327 ;test2.j(140)   // integer - integer
 328 ;test2.j(141)   write(119);
 329 acc8= constant 119
 330 call writeAcc8
 331 ;test2.j(142)   write(118);
 332 acc8= constant 118
 333 call writeAcc8
 334 ;test2.j(143)   write(117);
 335 acc8= constant 117
 336 call writeAcc8
 337 ;test2.j(144)   write(116);
 338 acc8= constant 116
 339 call writeAcc8
 340 ;test2.j(145)   // acc - stack16
 341 ;test2.j(146)   // integer - byte
 342 ;test2.j(147)   write(115);
 343 acc8= constant 115
 344 call writeAcc8
 345 ;test2.j(148)   write(114);
 346 acc8= constant 114
 347 call writeAcc8
 348 ;test2.j(149)   // acc - stack16
 349 ;test2.j(150)   // byte - integer
 350 ;test2.j(151)   write(113);
 351 acc8= constant 113
 352 call writeAcc8
 353 ;test2.j(152)   write(112);
 354 acc8= constant 112
 355 call writeAcc8
 356 ;test2.j(153)   // acc - stack16
 357 ;test2.j(154)   // byte - byte
 358 ;test2.j(155)   write(111);
 359 acc8= constant 111
 360 call writeAcc8
 361 ;test2.j(156)   write(110);
 362 acc8= constant 110
 363 call writeAcc8
 364 ;test2.j(157) 
 365 ;test2.j(158)   /************************/
 366 ;test2.j(159)   // acc - var
 367 ;test2.j(160)   // integer - integer
 368 ;test2.j(161)   write(109);
 369 acc8= constant 109
 370 call writeAcc8
 371 ;test2.j(162)   write(108);
 372 acc8= constant 108
 373 call writeAcc8
 374 ;test2.j(163)   if (3000+0 > i) write(107);
 375 acc16= constant 3000
 376 acc16+ constant 0
 377 acc16Comp variable 0
 378 brle 382
 379 acc8= constant 107
 380 call writeAcc8
 381 ;test2.j(164)   if (1000+0 < i) write(106);
 382 acc16= constant 1000
 383 acc16+ constant 0
 384 acc16Comp variable 0
 385 brge 391
 386 acc8= constant 106
 387 call writeAcc8
 388 ;test2.j(165)   // acc - var
 389 ;test2.j(166)   // integer - byte
 390 ;test2.j(167)   if (3000+0 > b) write(105);
 391 acc16= constant 3000
 392 acc16+ constant 0
 393 acc8= variable 6
 394 acc16CompareAcc8
 395 brle 399
 396 acc8= constant 105
 397 call writeAcc8
 398 ;test2.j(168)   if (1000+0 < b) write(999); else write(104);
 399 acc16= constant 1000
 400 acc16+ constant 0
 401 acc8= variable 6
 402 acc16CompareAcc8
 403 brge 407
 404 acc16= constant 999
 405 call writeAcc16
 406 br 412
 407 acc8= constant 104
 408 call writeAcc8
 409 ;test2.j(169)   // acc - var
 410 ;test2.j(170)   // byte - integer
 411 ;test2.j(171)   if (30+0 > i) write(999); else write(103);
 412 acc8= constant 30
 413 acc8+ constant 0
 414 acc16= variable 0
 415 acc8CompareAcc16
 416 brle 420
 417 acc16= constant 999
 418 call writeAcc16
 419 br 423
 420 acc8= constant 103
 421 call writeAcc8
 422 ;test2.j(172)   if (10+0 < i) write(102);
 423 acc8= constant 10
 424 acc8+ constant 0
 425 acc16= variable 0
 426 acc8CompareAcc16
 427 brge 433
 428 acc8= constant 102
 429 call writeAcc8
 430 ;test2.j(173)   // acc - var
 431 ;test2.j(174)   // byte - byte
 432 ;test2.j(175)   if (30+0 > b) write(101);
 433 acc8= constant 30
 434 acc8+ constant 0
 435 acc8Comp variable 6
 436 brle 440
 437 acc8= constant 101
 438 call writeAcc8
 439 ;test2.j(176)   if (10+0 < b) write(100);
 440 acc8= constant 10
 441 acc8+ constant 0
 442 acc8Comp variable 6
 443 brge 451
 444 acc8= constant 100
 445 call writeAcc8
 446 ;test2.j(177) 
 447 ;test2.j(178)   /************************/
 448 ;test2.j(179)   // acc - acc
 449 ;test2.j(180)   // integer - integer
 450 ;test2.j(181)   write(99);
 451 acc8= constant 99
 452 call writeAcc8
 453 ;test2.j(182)   write(98);
 454 acc8= constant 98
 455 call writeAcc8
 456 ;test2.j(183)   if (3000+0 > 2000+0) write(97);
 457 acc16= constant 3000
 458 acc16+ constant 0
 459 <acc16
 460 acc16= constant 2000
 461 acc16+ constant 0
 462 revAcc16Comp unstack16
 463 brge 467
 464 acc8= constant 97
 465 call writeAcc8
 466 ;test2.j(184)   if (1000+0 < 2000+0) write(96);
 467 acc16= constant 1000
 468 acc16+ constant 0
 469 <acc16
 470 acc16= constant 2000
 471 acc16+ constant 0
 472 revAcc16Comp unstack16
 473 brle 479
 474 acc8= constant 96
 475 call writeAcc8
 476 ;test2.j(185)   // acc - acc
 477 ;test2.j(186)   // integer - byte
 478 ;test2.j(187)   if (3000+0 > 20+0) write(95);
 479 acc16= constant 3000
 480 acc16+ constant 0
 481 <acc16
 482 acc8= constant 20
 483 acc8+ constant 0
 484 acc16= unstack16
 485 acc16CompareAcc8
 486 brle 490
 487 acc8= constant 95
 488 call writeAcc8
 489 ;test2.j(188)   if (1000+0 < 20+0) write(999); else write(94);
 490 acc16= constant 1000
 491 acc16+ constant 0
 492 <acc16
 493 acc8= constant 20
 494 acc8+ constant 0
 495 acc16= unstack16
 496 acc16CompareAcc8
 497 brge 501
 498 acc16= constant 999
 499 call writeAcc16
 500 br 506
 501 acc8= constant 94
 502 call writeAcc8
 503 ;test2.j(189)   // acc - acc
 504 ;test2.j(190)   // byte - integer
 505 ;test2.j(191)   if (30+0 > 2000+0) write(999); else write(93);
 506 acc8= constant 30
 507 acc8+ constant 0
 508 <acc8
 509 acc16= constant 2000
 510 acc16+ constant 0
 511 acc8= unstack8
 512 acc8CompareAcc16
 513 brle 517
 514 acc16= constant 999
 515 call writeAcc16
 516 br 520
 517 acc8= constant 93
 518 call writeAcc8
 519 ;test2.j(192)   if (10+0 < 2000+0) write(92);
 520 acc8= constant 10
 521 acc8+ constant 0
 522 <acc8
 523 acc16= constant 2000
 524 acc16+ constant 0
 525 acc8= unstack8
 526 acc8CompareAcc16
 527 brge 533
 528 acc8= constant 92
 529 call writeAcc8
 530 ;test2.j(193)   // acc - acc
 531 ;test2.j(194)   // byte - byte
 532 ;test2.j(195)   if (30+0 > 20+0) write(91);
 533 acc8= constant 30
 534 acc8+ constant 0
 535 <acc8
 536 acc8= constant 20
 537 acc8+ constant 0
 538 revAcc8Comp unstack8
 539 brge 543
 540 acc8= constant 91
 541 call writeAcc8
 542 ;test2.j(196)   if (10+0 < 20+0) write(90);
 543 acc8= constant 10
 544 acc8+ constant 0
 545 <acc8
 546 acc8= constant 20
 547 acc8+ constant 0
 548 revAcc8Comp unstack8
 549 brle 557
 550 acc8= constant 90
 551 call writeAcc8
 552 ;test2.j(197) 
 553 ;test2.j(198)   /************************/
 554 ;test2.j(199)   // acc - constant
 555 ;test2.j(200)   // integer - integer
 556 ;test2.j(201)   write(89);
 557 acc8= constant 89
 558 call writeAcc8
 559 ;test2.j(202)   write(88);
 560 acc8= constant 88
 561 call writeAcc8
 562 ;test2.j(203)   if (3000+0 > 2000) write(87);
 563 acc16= constant 3000
 564 acc16+ constant 0
 565 acc16Comp constant 2000
 566 brle 570
 567 acc8= constant 87
 568 call writeAcc8
 569 ;test2.j(204)   if (1000+0 < 2000) write(86);
 570 acc16= constant 1000
 571 acc16+ constant 0
 572 acc16Comp constant 2000
 573 brge 579
 574 acc8= constant 86
 575 call writeAcc8
 576 ;test2.j(205)   // acc - constant
 577 ;test2.j(206)   // integer - byte
 578 ;test2.j(207)   if (3000+0 > 20) write(85);
 579 acc16= constant 3000
 580 acc16+ constant 0
 581 acc8= constant 20
 582 acc16CompareAcc8
 583 brle 587
 584 acc8= constant 85
 585 call writeAcc8
 586 ;test2.j(208)   if (1000+0 < 20) write(999); else write(84);
 587 acc16= constant 1000
 588 acc16+ constant 0
 589 acc8= constant 20
 590 acc16CompareAcc8
 591 brge 595
 592 acc16= constant 999
 593 call writeAcc16
 594 br 600
 595 acc8= constant 84
 596 call writeAcc8
 597 ;test2.j(209)   // acc - constant
 598 ;test2.j(210)   // byte - integer
 599 ;test2.j(211)   if (30+0 > 2000) write(999); else write(83);
 600 acc8= constant 30
 601 acc8+ constant 0
 602 acc16= constant 2000
 603 acc8CompareAcc16
 604 brle 608
 605 acc16= constant 999
 606 call writeAcc16
 607 br 611
 608 acc8= constant 83
 609 call writeAcc8
 610 ;test2.j(212)   if (10+0 < 2000) write(82);
 611 acc8= constant 10
 612 acc8+ constant 0
 613 acc16= constant 2000
 614 acc8CompareAcc16
 615 brge 621
 616 acc8= constant 82
 617 call writeAcc8
 618 ;test2.j(213)   // acc - constant
 619 ;test2.j(214)   // byte - byte
 620 ;test2.j(215)   if (30+0 > 20) write(81);
 621 acc8= constant 30
 622 acc8+ constant 0
 623 acc8Comp constant 20
 624 brle 628
 625 acc8= constant 81
 626 call writeAcc8
 627 ;test2.j(216)   if (10+0 < 20) write(80);
 628 acc8= constant 10
 629 acc8+ constant 0
 630 acc8Comp constant 20
 631 brge 639
 632 acc8= constant 80
 633 call writeAcc8
 634 ;test2.j(217) 
 635 ;test2.j(218)   /************************/
 636 ;test2.j(219)   // constant - stack8
 637 ;test2.j(220)   // byte - byte
 638 ;test2.j(221)   write(79);
 639 acc8= constant 79
 640 call writeAcc8
 641 ;test2.j(222)   write(78);
 642 acc8= constant 78
 643 call writeAcc8
 644 ;test2.j(223)   write(77);
 645 acc8= constant 77
 646 call writeAcc8
 647 ;test2.j(224)   write(76);
 648 acc8= constant 76
 649 call writeAcc8
 650 ;test2.j(225)   // constant - stack8
 651 ;test2.j(226)   // byte - integer
 652 ;test2.j(227)   write(75);
 653 acc8= constant 75
 654 call writeAcc8
 655 ;test2.j(228)   write(74);
 656 acc8= constant 74
 657 call writeAcc8
 658 ;test2.j(229)   // constant - stack8
 659 ;test2.j(230)   // integer - byte
 660 ;test2.j(231)   write(73);
 661 acc8= constant 73
 662 call writeAcc8
 663 ;test2.j(232)   write(72);
 664 acc8= constant 72
 665 call writeAcc8
 666 ;test2.j(233)   // constant - stack8
 667 ;test2.j(234)   // integer - integer
 668 ;test2.j(235)   write(71);
 669 acc8= constant 71
 670 call writeAcc8
 671 ;test2.j(236)   write(70);
 672 acc8= constant 70
 673 call writeAcc8
 674 ;test2.j(237) 
 675 ;test2.j(238) 
 676 ;test2.j(239)   /************************/
 677 ;test2.j(240)   // constant - stack16
 678 ;test2.j(241)   // byte - byte
 679 ;test2.j(242)   write(69);
 680 acc8= constant 69
 681 call writeAcc8
 682 ;test2.j(243)   write(68);
 683 acc8= constant 68
 684 call writeAcc8
 685 ;test2.j(244)   write(67);
 686 acc8= constant 67
 687 call writeAcc8
 688 ;test2.j(245)   write(66);
 689 acc8= constant 66
 690 call writeAcc8
 691 ;test2.j(246)   // constant - stack16
 692 ;test2.j(247)   // byte - integer
 693 ;test2.j(248)   write(65);
 694 acc8= constant 65
 695 call writeAcc8
 696 ;test2.j(249)   write(64);
 697 acc8= constant 64
 698 call writeAcc8
 699 ;test2.j(250)   // constant - stack16
 700 ;test2.j(251)   // integer - byte
 701 ;test2.j(252)   write(63);
 702 acc8= constant 63
 703 call writeAcc8
 704 ;test2.j(253)   write(62);
 705 acc8= constant 62
 706 call writeAcc8
 707 ;test2.j(254)   // constant - stack16
 708 ;test2.j(255)   // integer - integer
 709 ;test2.j(256)   write(61);
 710 acc8= constant 61
 711 call writeAcc8
 712 ;test2.j(257)   write(60);
 713 acc8= constant 60
 714 call writeAcc8
 715 ;test2.j(258) 
 716 ;test2.j(259) 
 717 ;test2.j(260)   /************************/
 718 ;test2.j(261)   // constant - var
 719 ;test2.j(262)   // byte - byte
 720 ;test2.j(263)   write(59);
 721 acc8= constant 59
 722 call writeAcc8
 723 ;test2.j(264)   write(58);
 724 acc8= constant 58
 725 call writeAcc8
 726 ;test2.j(265)   if (30 > b) write(57);
 727 acc8= variable 6
 728 acc8Comp constant 30
 729 brge 733
 730 acc8= constant 57
 731 call writeAcc8
 732 ;test2.j(266)   if (10 < b) write(56);
 733 acc8= variable 6
 734 acc8Comp constant 10
 735 brle 741
 736 acc8= constant 56
 737 call writeAcc8
 738 ;test2.j(267)   // constant - var
 739 ;test2.j(268)   // byte - integer
 740 ;test2.j(269)   if (30 > i) write(999); else write(55);
 741 acc16= variable 0
 742 acc8= constant 30
 743 acc8CompareAcc16
 744 brle 748
 745 acc16= constant 999
 746 call writeAcc16
 747 br 751
 748 acc8= constant 55
 749 call writeAcc8
 750 ;test2.j(270)   if (10 < i) write(54);
 751 acc16= variable 0
 752 acc8= constant 10
 753 acc8CompareAcc16
 754 brge 760
 755 acc8= constant 54
 756 call writeAcc8
 757 ;test2.j(271)   // constant - var
 758 ;test2.j(272)   // integer - byte
 759 ;test2.j(273)   if (3000 > b) write(53);
 760 acc8= variable 6
 761 acc16= constant 3000
 762 acc16CompareAcc8
 763 brle 767
 764 acc8= constant 53
 765 call writeAcc8
 766 ;test2.j(274)   if (1000 < b) write(999); else write(52);
 767 acc8= variable 6
 768 acc16= constant 1000
 769 acc16CompareAcc8
 770 brge 774
 771 acc16= constant 999
 772 call writeAcc16
 773 br 779
 774 acc8= constant 52
 775 call writeAcc8
 776 ;test2.j(275)   // constant - var
 777 ;test2.j(276)   // integer - integer
 778 ;test2.j(277)   if (3000 > i) write(51);
 779 acc16= variable 0
 780 acc16Comp constant 3000
 781 brge 785
 782 acc8= constant 51
 783 call writeAcc8
 784 ;test2.j(278)   if (1000 < i) write(50);
 785 acc16= variable 0
 786 acc16Comp constant 1000
 787 brle 795
 788 acc8= constant 50
 789 call writeAcc8
 790 ;test2.j(279) 
 791 ;test2.j(280)   /************************/
 792 ;test2.j(281)   // constant - acc
 793 ;test2.j(282)   // byte - byte
 794 ;test2.j(283)   write(49);
 795 acc8= constant 49
 796 call writeAcc8
 797 ;test2.j(284)   write(48);
 798 acc8= constant 48
 799 call writeAcc8
 800 ;test2.j(285)   if (1 > 0+0) write(47);
 801 acc8= constant 0
 802 acc8+ constant 0
 803 acc8Comp constant 1
 804 brge 808
 805 acc8= constant 47
 806 call writeAcc8
 807 ;test2.j(286)   if (1 < 2+0) write(46);
 808 acc8= constant 2
 809 acc8+ constant 0
 810 acc8Comp constant 1
 811 brle 817
 812 acc8= constant 46
 813 call writeAcc8
 814 ;test2.j(287)   // constant - acc
 815 ;test2.j(288)   // byte - integer
 816 ;test2.j(289)   if (1 > 1000+0) write(999); else write(45);
 817 acc16= constant 1000
 818 acc16+ constant 0
 819 acc8= constant 1
 820 acc8CompareAcc16
 821 brle 825
 822 acc16= constant 999
 823 call writeAcc16
 824 br 828
 825 acc8= constant 45
 826 call writeAcc8
 827 ;test2.j(290)   if (1 < 1000+0) write(44);
 828 acc16= constant 1000
 829 acc16+ constant 0
 830 acc8= constant 1
 831 acc8CompareAcc16
 832 brge 838
 833 acc8= constant 44
 834 call writeAcc8
 835 ;test2.j(291)   // constant - acc
 836 ;test2.j(292)   // integer - byte
 837 ;test2.j(293)   if (1000 > 0+0) write(43);
 838 acc8= constant 0
 839 acc8+ constant 0
 840 acc16= constant 1000
 841 acc16CompareAcc8
 842 brle 846
 843 acc8= constant 43
 844 call writeAcc8
 845 ;test2.j(294)   if (1000 < 0+0) write(999); else write(42);
 846 acc8= constant 0
 847 acc8+ constant 0
 848 acc16= constant 1000
 849 acc16CompareAcc8
 850 brge 854
 851 acc16= constant 999
 852 call writeAcc16
 853 br 859
 854 acc8= constant 42
 855 call writeAcc8
 856 ;test2.j(295)   // constant - acc
 857 ;test2.j(296)   // integer - integer
 858 ;test2.j(297)   if (2000 > 1000+0) write(41);
 859 acc16= constant 1000
 860 acc16+ constant 0
 861 acc16Comp constant 2000
 862 brge 866
 863 acc8= constant 41
 864 call writeAcc8
 865 ;test2.j(298)   if (1000 < 2000+0) write(40);
 866 acc16= constant 2000
 867 acc16+ constant 0
 868 acc16Comp constant 1000
 869 brle 877
 870 acc8= constant 40
 871 call writeAcc8
 872 ;test2.j(299) 
 873 ;test2.j(300)   /************************/
 874 ;test2.j(301)   // constant - constant
 875 ;test2.j(302)   // byte - byte
 876 ;test2.j(303)   write(39);
 877 acc8= constant 39
 878 call writeAcc8
 879 ;test2.j(304)   if (1 == 1) write(38);
 880 acc8= constant 1
 881 acc8Comp constant 1
 882 brne 886
 883 acc8= constant 38
 884 call writeAcc8
 885 ;test2.j(305)   if (1 != 0) write(37);
 886 acc8= constant 1
 887 acc8Comp constant 0
 888 breq 892
 889 acc8= constant 37
 890 call writeAcc8
 891 ;test2.j(306)   if (1 > 0) write(36);
 892 acc8= constant 1
 893 acc8Comp constant 0
 894 brle 898
 895 acc8= constant 36
 896 call writeAcc8
 897 ;test2.j(307)   if (1 >= 0) write(35);
 898 acc8= constant 1
 899 acc8Comp constant 0
 900 brlt 904
 901 acc8= constant 35
 902 call writeAcc8
 903 ;test2.j(308)   if (1 >= 1) write(34);
 904 acc8= constant 1
 905 acc8Comp constant 1
 906 brlt 910
 907 acc8= constant 34
 908 call writeAcc8
 909 ;test2.j(309)   if (1 < 2) write(33);
 910 acc8= constant 1
 911 acc8Comp constant 2
 912 brge 916
 913 acc8= constant 33
 914 call writeAcc8
 915 ;test2.j(310)   if (1 <= 2) write(32);
 916 acc8= constant 1
 917 acc8Comp constant 2
 918 brgt 922
 919 acc8= constant 32
 920 call writeAcc8
 921 ;test2.j(311)   if (1 <= 1) write(31);
 922 acc8= constant 1
 923 acc8Comp constant 1
 924 brgt 928
 925 acc8= constant 31
 926 call writeAcc8
 927 ;test2.j(312)   write(30);
 928 acc8= constant 30
 929 call writeAcc8
 930 ;test2.j(313)   // constant - constant
 931 ;test2.j(314)   // byte - integer
 932 ;test2.j(315)   write(29);
 933 acc8= constant 29
 934 call writeAcc8
 935 ;test2.j(316)   if (1 == 1000) write(999); else write(28);
 936 acc8= constant 1
 937 acc16= constant 1000
 938 acc8CompareAcc16
 939 brne 943
 940 acc16= constant 999
 941 call writeAcc16
 942 br 946
 943 acc8= constant 28
 944 call writeAcc8
 945 ;test2.j(317)   if (1 != 1000) write(27);
 946 acc8= constant 1
 947 acc16= constant 1000
 948 acc8CompareAcc16
 949 breq 953
 950 acc8= constant 27
 951 call writeAcc8
 952 ;test2.j(318)   if (1 > 1000) write(999); else write(26);
 953 acc8= constant 1
 954 acc16= constant 1000
 955 acc8CompareAcc16
 956 brle 960
 957 acc16= constant 999
 958 call writeAcc16
 959 br 963
 960 acc8= constant 26
 961 call writeAcc8
 962 ;test2.j(319)   if (1 >= 1000) write(999); write(25);
 963 acc8= constant 1
 964 acc16= constant 1000
 965 acc8CompareAcc16
 966 brlt 969
 967 acc16= constant 999
 968 call writeAcc16
 969 acc8= constant 25
 970 call writeAcc8
 971 ;test2.j(320)   if (1 >= 1000) write(999); write(24);
 972 acc8= constant 1
 973 acc16= constant 1000
 974 acc8CompareAcc16
 975 brlt 978
 976 acc16= constant 999
 977 call writeAcc16
 978 acc8= constant 24
 979 call writeAcc8
 980 ;test2.j(321)   if (1 < 2000) write(23);
 981 acc8= constant 1
 982 acc16= constant 2000
 983 acc8CompareAcc16
 984 brge 988
 985 acc8= constant 23
 986 call writeAcc8
 987 ;test2.j(322)   if (1 <= 2000) write(22);
 988 acc8= constant 1
 989 acc16= constant 2000
 990 acc8CompareAcc16
 991 brgt 995
 992 acc8= constant 22
 993 call writeAcc8
 994 ;test2.j(323)   if (1 <= 1000) write(21);
 995 acc8= constant 1
 996 acc16= constant 1000
 997 acc8CompareAcc16
 998 brgt 1002
 999 acc8= constant 21
1000 call writeAcc8
1001 ;test2.j(324)   write(20);
1002 acc8= constant 20
1003 call writeAcc8
1004 ;test2.j(325)   // constant - constant
1005 ;test2.j(326)   // integer - byte
1006 ;test2.j(327)   write(19);
1007 acc8= constant 19
1008 call writeAcc8
1009 ;test2.j(328)   if (1000 == 1) { write(999); } else { write(18); }
1010 acc16= constant 1000
1011 acc8= constant 1
1012 acc16CompareAcc8
1013 brne 1017
1014 acc16= constant 999
1015 call writeAcc16
1016 br 1020
1017 acc8= constant 18
1018 call writeAcc8
1019 ;test2.j(329)   if (1000 != 0) write(17);
1020 acc16= constant 1000
1021 acc8= constant 0
1022 acc16CompareAcc8
1023 breq 1027
1024 acc8= constant 17
1025 call writeAcc8
1026 ;test2.j(330)   if (1000 > 0) write(16);
1027 acc16= constant 1000
1028 acc8= constant 0
1029 acc16CompareAcc8
1030 brle 1034
1031 acc8= constant 16
1032 call writeAcc8
1033 ;test2.j(331)   if (1000 >= 0) write(15);
1034 acc16= constant 1000
1035 acc8= constant 0
1036 acc16CompareAcc8
1037 brlt 1041
1038 acc8= constant 15
1039 call writeAcc8
1040 ;test2.j(332)   if (1000 >= 1) write(14);
1041 acc16= constant 1000
1042 acc8= constant 1
1043 acc16CompareAcc8
1044 brlt 1048
1045 acc8= constant 14
1046 call writeAcc8
1047 ;test2.j(333)   if (1 < 2000) write(13);
1048 acc8= constant 1
1049 acc16= constant 2000
1050 acc8CompareAcc16
1051 brge 1055
1052 acc8= constant 13
1053 call writeAcc8
1054 ;test2.j(334)   if (1 <= 2000) write(12);
1055 acc8= constant 1
1056 acc16= constant 2000
1057 acc8CompareAcc16
1058 brgt 1062
1059 acc8= constant 12
1060 call writeAcc8
1061 ;test2.j(335)   if (1 <= 1000) write(11);
1062 acc8= constant 1
1063 acc16= constant 1000
1064 acc8CompareAcc16
1065 brgt 1069
1066 acc8= constant 11
1067 call writeAcc8
1068 ;test2.j(336)   write(10);
1069 acc8= constant 10
1070 call writeAcc8
1071 ;test2.j(337)   // constant - constant
1072 ;test2.j(338)   // integer - integer
1073 ;test2.j(339)   write(9);
1074 acc8= constant 9
1075 call writeAcc8
1076 ;test2.j(340)   if (1000 == 1000) write(8);
1077 acc16= constant 1000
1078 acc16Comp constant 1000
1079 brne 1083
1080 acc8= constant 8
1081 call writeAcc8
1082 ;test2.j(341)   if (1000 != 2000) write(7);
1083 acc16= constant 1000
1084 acc16Comp constant 2000
1085 breq 1089
1086 acc8= constant 7
1087 call writeAcc8
1088 ;test2.j(342)   if (2000 > 1000) write(6);
1089 acc16= constant 2000
1090 acc16Comp constant 1000
1091 brle 1095
1092 acc8= constant 6
1093 call writeAcc8
1094 ;test2.j(343)   if (2000 >= 1000) write(5);
1095 acc16= constant 2000
1096 acc16Comp constant 1000
1097 brlt 1101
1098 acc8= constant 5
1099 call writeAcc8
1100 ;test2.j(344)   if (1000 >= 1000) write(4);
1101 acc16= constant 1000
1102 acc16Comp constant 1000
1103 brlt 1107
1104 acc8= constant 4
1105 call writeAcc8
1106 ;test2.j(345)   if (1000 < 2000) write(3);
1107 acc16= constant 1000
1108 acc16Comp constant 2000
1109 brge 1113
1110 acc8= constant 3
1111 call writeAcc8
1112 ;test2.j(346)   if (1000 <= 2000) write(2);
1113 acc16= constant 1000
1114 acc16Comp constant 2000
1115 brgt 1119
1116 acc8= constant 2
1117 call writeAcc8
1118 ;test2.j(347)   if (1000 <= 1000) write(1);
1119 acc16= constant 1000
1120 acc16Comp constant 1000
1121 brgt 1126
1122 acc8= constant 1
1123 call writeAcc8
1124 ;test2.j(348) 
1125 ;test2.j(349)   write(0);
1126 acc8= constant 0
1127 call writeAcc8
1128 ;test2.j(350) }
1129 stop
