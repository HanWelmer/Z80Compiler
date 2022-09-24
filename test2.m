   0 ;test2.j(0) /* Program to test branch instructions */
   1 ;test2.j(1) class TestBranches {
   2 ;test2.j(2)   int i = 2000;
   3 acc16= constant 2000
   4 acc16=> variable 0
   5 ;test2.j(3)   int i1 = 1000;
   6 acc16= constant 1000
   7 acc16=> variable 2
   8 ;test2.j(4)   int i3 = 3000;
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
 149 acc16= variable 0
 150 <acc16
 151 acc16= constant 1000
 152 acc16+ constant 0
 153 revAcc16Comp unstack16
 154 brge 158
 155 acc8= constant 147
 156 call writeAcc8
 157 ;test2.j(84)   if (i < 3000+0) write(146);
 158 acc16= variable 0
 159 <acc16
 160 acc16= constant 3000
 161 acc16+ constant 0
 162 revAcc16Comp unstack16
 163 brle 169
 164 acc8= constant 146
 165 call writeAcc8
 166 ;test2.j(85)   // var - acc
 167 ;test2.j(86)   // integer - byte
 168 ;test2.j(87)   if (i > 1000+0) write(145);
 169 acc16= variable 0
 170 <acc16
 171 acc16= constant 1000
 172 acc16+ constant 0
 173 revAcc16Comp unstack16
 174 brge 178
 175 acc8= constant 145
 176 call writeAcc8
 177 ;test2.j(88)   if (i < 3000+0) write(144);
 178 acc16= variable 0
 179 <acc16
 180 acc16= constant 3000
 181 acc16+ constant 0
 182 revAcc16Comp unstack16
 183 brle 189
 184 acc8= constant 144
 185 call writeAcc8
 186 ;test2.j(89)   // var - acc
 187 ;test2.j(90)   // byte - integer
 188 ;test2.j(91)   if (b > 1000+0) write(999); else write(143);
 189 acc8= variable 6
 190 <acc8
 191 acc16= constant 1000
 192 acc16+ constant 0
 193 acc8= unstack8
 194 acc8CompareAcc16
 195 brle 199
 196 acc16= constant 999
 197 call writeAcc16
 198 br 202
 199 acc8= constant 143
 200 call writeAcc8
 201 ;test2.j(92)   if (b < 1000+0) write(142);
 202 acc8= variable 6
 203 <acc8
 204 acc16= constant 1000
 205 acc16+ constant 0
 206 acc8= unstack8
 207 acc8CompareAcc16
 208 brge 214
 209 acc8= constant 142
 210 call writeAcc8
 211 ;test2.j(93)   // var - acc
 212 ;test2.j(94)   // byte - byte
 213 ;test2.j(95)   if (b > 10+0) write(141);
 214 acc8= variable 6
 215 <acc8
 216 acc8= constant 10
 217 acc8+ constant 0
 218 revAcc8Comp unstack8
 219 brge 223
 220 acc8= constant 141
 221 call writeAcc8
 222 ;test2.j(96)   if (b < 30+0) write(140);
 223 acc8= variable 6
 224 <acc8
 225 acc8= constant 30
 226 acc8+ constant 0
 227 revAcc8Comp unstack8
 228 brle 236
 229 acc8= constant 140
 230 call writeAcc8
 231 ;test2.j(97) 
 232 ;test2.j(98)   /************************/
 233 ;test2.j(99)   // var - constant
 234 ;test2.j(100)   // integer - integer
 235 ;test2.j(101)   write(139);
 236 acc8= constant 139
 237 call writeAcc8
 238 ;test2.j(102)   write(138);
 239 acc8= constant 138
 240 call writeAcc8
 241 ;test2.j(103)   if (i > 1000) write(137);
 242 acc16= variable 0
 243 acc16Comp constant 1000
 244 brle 248
 245 acc8= constant 137
 246 call writeAcc8
 247 ;test2.j(104)   if (i < 3000) write(136);
 248 acc16= variable 0
 249 acc16Comp constant 3000
 250 brge 256
 251 acc8= constant 136
 252 call writeAcc8
 253 ;test2.j(105)   // var - constant
 254 ;test2.j(106)   // integer - byte
 255 ;test2.j(107)   if (i > 1000) write(135);
 256 acc16= variable 0
 257 acc16Comp constant 1000
 258 brle 262
 259 acc8= constant 135
 260 call writeAcc8
 261 ;test2.j(108)   if (i < 3000) write(134);
 262 acc16= variable 0
 263 acc16Comp constant 3000
 264 brge 270
 265 acc8= constant 134
 266 call writeAcc8
 267 ;test2.j(109)   // var - constant
 268 ;test2.j(110)   // byte - integer
 269 ;test2.j(111)   if (b > 1000) write(999); else write(133);
 270 acc8= variable 6
 271 acc16= constant 1000
 272 acc8CompareAcc16
 273 brle 277
 274 acc16= constant 999
 275 call writeAcc16
 276 br 280
 277 acc8= constant 133
 278 call writeAcc8
 279 ;test2.j(112)   if (b < 1000) write(132);
 280 acc8= variable 6
 281 acc16= constant 1000
 282 acc8CompareAcc16
 283 brge 289
 284 acc8= constant 132
 285 call writeAcc8
 286 ;test2.j(113)   // var - constant
 287 ;test2.j(114)   // byte - byte
 288 ;test2.j(115)   if (b > 10) write(131);
 289 acc8= variable 6
 290 acc8Comp constant 10
 291 brle 295
 292 acc8= constant 131
 293 call writeAcc8
 294 ;test2.j(116)   if (b < 30) write(130);
 295 acc8= variable 6
 296 acc8Comp constant 30
 297 brge 305
 298 acc8= constant 130
 299 call writeAcc8
 300 ;test2.j(117) 
 301 ;test2.j(118)   /************************/
 302 ;test2.j(119)   // acc - stack8
 303 ;test2.j(120)   // integer - integer
 304 ;test2.j(121)   write(129);
 305 acc8= constant 129
 306 call writeAcc8
 307 ;test2.j(122)   write(128);
 308 acc8= constant 128
 309 call writeAcc8
 310 ;test2.j(123)   write(127);
 311 acc8= constant 127
 312 call writeAcc8
 313 ;test2.j(124)   write(126);
 314 acc8= constant 126
 315 call writeAcc8
 316 ;test2.j(125)   // acc - stack8
 317 ;test2.j(126)   // integer - byte
 318 ;test2.j(127)   write(125);
 319 acc8= constant 125
 320 call writeAcc8
 321 ;test2.j(128)   write(124);
 322 acc8= constant 124
 323 call writeAcc8
 324 ;test2.j(129)   // acc - stack8
 325 ;test2.j(130)   // byte - integer
 326 ;test2.j(131)   write(123);
 327 acc8= constant 123
 328 call writeAcc8
 329 ;test2.j(132)   write(122);
 330 acc8= constant 122
 331 call writeAcc8
 332 ;test2.j(133)   // acc - stack8
 333 ;test2.j(134)   // byte - byte
 334 ;test2.j(135)   write(121);
 335 acc8= constant 121
 336 call writeAcc8
 337 ;test2.j(136)   write(120);
 338 acc8= constant 120
 339 call writeAcc8
 340 ;test2.j(137) 
 341 ;test2.j(138)   /************************/
 342 ;test2.j(139)   // acc - stack16
 343 ;test2.j(140)   // integer - integer
 344 ;test2.j(141)   write(119);
 345 acc8= constant 119
 346 call writeAcc8
 347 ;test2.j(142)   write(118);
 348 acc8= constant 118
 349 call writeAcc8
 350 ;test2.j(143)   write(117);
 351 acc8= constant 117
 352 call writeAcc8
 353 ;test2.j(144)   write(116);
 354 acc8= constant 116
 355 call writeAcc8
 356 ;test2.j(145)   // acc - stack16
 357 ;test2.j(146)   // integer - byte
 358 ;test2.j(147)   write(115);
 359 acc8= constant 115
 360 call writeAcc8
 361 ;test2.j(148)   write(114);
 362 acc8= constant 114
 363 call writeAcc8
 364 ;test2.j(149)   // acc - stack16
 365 ;test2.j(150)   // byte - integer
 366 ;test2.j(151)   write(113);
 367 acc8= constant 113
 368 call writeAcc8
 369 ;test2.j(152)   write(112);
 370 acc8= constant 112
 371 call writeAcc8
 372 ;test2.j(153)   // acc - stack16
 373 ;test2.j(154)   // byte - byte
 374 ;test2.j(155)   write(111);
 375 acc8= constant 111
 376 call writeAcc8
 377 ;test2.j(156)   write(110);
 378 acc8= constant 110
 379 call writeAcc8
 380 ;test2.j(157) 
 381 ;test2.j(158)   /************************/
 382 ;test2.j(159)   // acc - var
 383 ;test2.j(160)   // integer - integer
 384 ;test2.j(161)   write(109);
 385 acc8= constant 109
 386 call writeAcc8
 387 ;test2.j(162)   write(108);
 388 acc8= constant 108
 389 call writeAcc8
 390 ;test2.j(163)   if (3000+0 > i) write(107);
 391 acc16= constant 3000
 392 acc16+ constant 0
 393 acc16Comp variable 0
 394 brle 398
 395 acc8= constant 107
 396 call writeAcc8
 397 ;test2.j(164)   if (1000+0 < i) write(106);
 398 acc16= constant 1000
 399 acc16+ constant 0
 400 acc16Comp variable 0
 401 brge 407
 402 acc8= constant 106
 403 call writeAcc8
 404 ;test2.j(165)   // acc - var
 405 ;test2.j(166)   // integer - byte
 406 ;test2.j(167)   if (3000+0 > b) write(105);
 407 acc16= constant 3000
 408 acc16+ constant 0
 409 acc8= variable 6
 410 acc16CompareAcc8
 411 brle 415
 412 acc8= constant 105
 413 call writeAcc8
 414 ;test2.j(168)   if (1000+0 < b) write(999); else write(104);
 415 acc16= constant 1000
 416 acc16+ constant 0
 417 acc8= variable 6
 418 acc16CompareAcc8
 419 brge 423
 420 acc16= constant 999
 421 call writeAcc16
 422 br 428
 423 acc8= constant 104
 424 call writeAcc8
 425 ;test2.j(169)   // acc - var
 426 ;test2.j(170)   // byte - integer
 427 ;test2.j(171)   if (30+0 > i) write(999); else write(103);
 428 acc8= constant 30
 429 acc8+ constant 0
 430 acc16= variable 0
 431 acc8CompareAcc16
 432 brle 436
 433 acc16= constant 999
 434 call writeAcc16
 435 br 439
 436 acc8= constant 103
 437 call writeAcc8
 438 ;test2.j(172)   if (10+0 < i) write(102);
 439 acc8= constant 10
 440 acc8+ constant 0
 441 acc16= variable 0
 442 acc8CompareAcc16
 443 brge 449
 444 acc8= constant 102
 445 call writeAcc8
 446 ;test2.j(173)   // acc - var
 447 ;test2.j(174)   // byte - byte
 448 ;test2.j(175)   if (30+0 > b) write(101);
 449 acc8= constant 30
 450 acc8+ constant 0
 451 acc8Comp variable 6
 452 brle 456
 453 acc8= constant 101
 454 call writeAcc8
 455 ;test2.j(176)   if (10+0 < b) write(100);
 456 acc8= constant 10
 457 acc8+ constant 0
 458 acc8Comp variable 6
 459 brge 467
 460 acc8= constant 100
 461 call writeAcc8
 462 ;test2.j(177) 
 463 ;test2.j(178)   /************************/
 464 ;test2.j(179)   // acc - acc
 465 ;test2.j(180)   // integer - integer
 466 ;test2.j(181)   write(99);
 467 acc8= constant 99
 468 call writeAcc8
 469 ;test2.j(182)   write(98);
 470 acc8= constant 98
 471 call writeAcc8
 472 ;test2.j(183)   if (3000+0 > 2000+0) write(97);
 473 acc16= constant 3000
 474 acc16+ constant 0
 475 <acc16
 476 acc16= constant 2000
 477 acc16+ constant 0
 478 revAcc16Comp unstack16
 479 brge 483
 480 acc8= constant 97
 481 call writeAcc8
 482 ;test2.j(184)   if (1000+0 < 2000+0) write(96);
 483 acc16= constant 1000
 484 acc16+ constant 0
 485 <acc16
 486 acc16= constant 2000
 487 acc16+ constant 0
 488 revAcc16Comp unstack16
 489 brle 495
 490 acc8= constant 96
 491 call writeAcc8
 492 ;test2.j(185)   // acc - acc
 493 ;test2.j(186)   // integer - byte
 494 ;test2.j(187)   if (3000+0 > 20+0) write(95);
 495 acc16= constant 3000
 496 acc16+ constant 0
 497 <acc16
 498 acc8= constant 20
 499 acc8+ constant 0
 500 acc16= unstack16
 501 acc16CompareAcc8
 502 brle 506
 503 acc8= constant 95
 504 call writeAcc8
 505 ;test2.j(188)   if (1000+0 < 20+0) write(999); else write(94);
 506 acc16= constant 1000
 507 acc16+ constant 0
 508 <acc16
 509 acc8= constant 20
 510 acc8+ constant 0
 511 acc16= unstack16
 512 acc16CompareAcc8
 513 brge 517
 514 acc16= constant 999
 515 call writeAcc16
 516 br 522
 517 acc8= constant 94
 518 call writeAcc8
 519 ;test2.j(189)   // acc - acc
 520 ;test2.j(190)   // byte - integer
 521 ;test2.j(191)   if (30+0 > 2000+0) write(999); else write(93);
 522 acc8= constant 30
 523 acc8+ constant 0
 524 <acc8
 525 acc16= constant 2000
 526 acc16+ constant 0
 527 acc8= unstack8
 528 acc8CompareAcc16
 529 brle 533
 530 acc16= constant 999
 531 call writeAcc16
 532 br 536
 533 acc8= constant 93
 534 call writeAcc8
 535 ;test2.j(192)   if (10+0 < 2000+0) write(92);
 536 acc8= constant 10
 537 acc8+ constant 0
 538 <acc8
 539 acc16= constant 2000
 540 acc16+ constant 0
 541 acc8= unstack8
 542 acc8CompareAcc16
 543 brge 549
 544 acc8= constant 92
 545 call writeAcc8
 546 ;test2.j(193)   // acc - acc
 547 ;test2.j(194)   // byte - byte
 548 ;test2.j(195)   if (30+0 > 20+0) write(91);
 549 acc8= constant 30
 550 acc8+ constant 0
 551 <acc8
 552 acc8= constant 20
 553 acc8+ constant 0
 554 revAcc8Comp unstack8
 555 brge 559
 556 acc8= constant 91
 557 call writeAcc8
 558 ;test2.j(196)   if (10+0 < 20+0) write(90);
 559 acc8= constant 10
 560 acc8+ constant 0
 561 <acc8
 562 acc8= constant 20
 563 acc8+ constant 0
 564 revAcc8Comp unstack8
 565 brle 573
 566 acc8= constant 90
 567 call writeAcc8
 568 ;test2.j(197) 
 569 ;test2.j(198)   /************************/
 570 ;test2.j(199)   // acc - constant
 571 ;test2.j(200)   // integer - integer
 572 ;test2.j(201)   write(89);
 573 acc8= constant 89
 574 call writeAcc8
 575 ;test2.j(202)   write(88);
 576 acc8= constant 88
 577 call writeAcc8
 578 ;test2.j(203)   if (3000+0 > 2000) write(87);
 579 acc16= constant 3000
 580 acc16+ constant 0
 581 acc16Comp constant 2000
 582 brle 586
 583 acc8= constant 87
 584 call writeAcc8
 585 ;test2.j(204)   if (1000+0 < 2000) write(86);
 586 acc16= constant 1000
 587 acc16+ constant 0
 588 acc16Comp constant 2000
 589 brge 595
 590 acc8= constant 86
 591 call writeAcc8
 592 ;test2.j(205)   // acc - constant
 593 ;test2.j(206)   // integer - byte
 594 ;test2.j(207)   if (3000+0 > 20) write(85);
 595 acc16= constant 3000
 596 acc16+ constant 0
 597 acc8= constant 20
 598 acc16CompareAcc8
 599 brle 603
 600 acc8= constant 85
 601 call writeAcc8
 602 ;test2.j(208)   if (1000+0 < 20) write(999); else write(84);
 603 acc16= constant 1000
 604 acc16+ constant 0
 605 acc8= constant 20
 606 acc16CompareAcc8
 607 brge 611
 608 acc16= constant 999
 609 call writeAcc16
 610 br 616
 611 acc8= constant 84
 612 call writeAcc8
 613 ;test2.j(209)   // acc - constant
 614 ;test2.j(210)   // byte - integer
 615 ;test2.j(211)   if (30+0 > 2000) write(999); else write(83);
 616 acc8= constant 30
 617 acc8+ constant 0
 618 acc16= constant 2000
 619 acc8CompareAcc16
 620 brle 624
 621 acc16= constant 999
 622 call writeAcc16
 623 br 627
 624 acc8= constant 83
 625 call writeAcc8
 626 ;test2.j(212)   if (10+0 < 2000) write(82);
 627 acc8= constant 10
 628 acc8+ constant 0
 629 acc16= constant 2000
 630 acc8CompareAcc16
 631 brge 637
 632 acc8= constant 82
 633 call writeAcc8
 634 ;test2.j(213)   // acc - constant
 635 ;test2.j(214)   // byte - byte
 636 ;test2.j(215)   if (30+0 > 20) write(81);
 637 acc8= constant 30
 638 acc8+ constant 0
 639 acc8Comp constant 20
 640 brle 644
 641 acc8= constant 81
 642 call writeAcc8
 643 ;test2.j(216)   if (10+0 < 20) write(80);
 644 acc8= constant 10
 645 acc8+ constant 0
 646 acc8Comp constant 20
 647 brge 655
 648 acc8= constant 80
 649 call writeAcc8
 650 ;test2.j(217) 
 651 ;test2.j(218)   /************************/
 652 ;test2.j(219)   // constant - stack8
 653 ;test2.j(220)   // byte - byte
 654 ;test2.j(221)   write(79);
 655 acc8= constant 79
 656 call writeAcc8
 657 ;test2.j(222)   write(78);
 658 acc8= constant 78
 659 call writeAcc8
 660 ;test2.j(223)   write(77);
 661 acc8= constant 77
 662 call writeAcc8
 663 ;test2.j(224)   write(76);
 664 acc8= constant 76
 665 call writeAcc8
 666 ;test2.j(225)   // constant - stack8
 667 ;test2.j(226)   // byte - integer
 668 ;test2.j(227)   write(75);
 669 acc8= constant 75
 670 call writeAcc8
 671 ;test2.j(228)   write(74);
 672 acc8= constant 74
 673 call writeAcc8
 674 ;test2.j(229)   // constant - stack8
 675 ;test2.j(230)   // integer - byte
 676 ;test2.j(231)   write(73);
 677 acc8= constant 73
 678 call writeAcc8
 679 ;test2.j(232)   write(72);
 680 acc8= constant 72
 681 call writeAcc8
 682 ;test2.j(233)   // constant - stack8
 683 ;test2.j(234)   // integer - integer
 684 ;test2.j(235)   write(71);
 685 acc8= constant 71
 686 call writeAcc8
 687 ;test2.j(236)   write(70);
 688 acc8= constant 70
 689 call writeAcc8
 690 ;test2.j(237) 
 691 ;test2.j(238) 
 692 ;test2.j(239)   /************************/
 693 ;test2.j(240)   // constant - stack16
 694 ;test2.j(241)   // byte - byte
 695 ;test2.j(242)   write(69);
 696 acc8= constant 69
 697 call writeAcc8
 698 ;test2.j(243)   write(68);
 699 acc8= constant 68
 700 call writeAcc8
 701 ;test2.j(244)   write(67);
 702 acc8= constant 67
 703 call writeAcc8
 704 ;test2.j(245)   write(66);
 705 acc8= constant 66
 706 call writeAcc8
 707 ;test2.j(246)   // constant - stack16
 708 ;test2.j(247)   // byte - integer
 709 ;test2.j(248)   write(65);
 710 acc8= constant 65
 711 call writeAcc8
 712 ;test2.j(249)   write(64);
 713 acc8= constant 64
 714 call writeAcc8
 715 ;test2.j(250)   // constant - stack16
 716 ;test2.j(251)   // integer - byte
 717 ;test2.j(252)   write(63);
 718 acc8= constant 63
 719 call writeAcc8
 720 ;test2.j(253)   write(62);
 721 acc8= constant 62
 722 call writeAcc8
 723 ;test2.j(254)   // constant - stack16
 724 ;test2.j(255)   // integer - integer
 725 ;test2.j(256)   write(61);
 726 acc8= constant 61
 727 call writeAcc8
 728 ;test2.j(257)   write(60);
 729 acc8= constant 60
 730 call writeAcc8
 731 ;test2.j(258) 
 732 ;test2.j(259) 
 733 ;test2.j(260)   /************************/
 734 ;test2.j(261)   // constant - var
 735 ;test2.j(262)   // byte - byte
 736 ;test2.j(263)   write(59);
 737 acc8= constant 59
 738 call writeAcc8
 739 ;test2.j(264)   write(58);
 740 acc8= constant 58
 741 call writeAcc8
 742 ;test2.j(265)   if (30 > b) write(57);
 743 acc8= variable 6
 744 acc8Comp constant 30
 745 brge 749
 746 acc8= constant 57
 747 call writeAcc8
 748 ;test2.j(266)   if (10 < b) write(56);
 749 acc8= variable 6
 750 acc8Comp constant 10
 751 brle 757
 752 acc8= constant 56
 753 call writeAcc8
 754 ;test2.j(267)   // constant - var
 755 ;test2.j(268)   // byte - integer
 756 ;test2.j(269)   if (30 > i) write(999); else write(55);
 757 acc16= variable 0
 758 acc8= constant 30
 759 acc8CompareAcc16
 760 brle 764
 761 acc16= constant 999
 762 call writeAcc16
 763 br 767
 764 acc8= constant 55
 765 call writeAcc8
 766 ;test2.j(270)   if (10 < i) write(54);
 767 acc16= variable 0
 768 acc8= constant 10
 769 acc8CompareAcc16
 770 brge 776
 771 acc8= constant 54
 772 call writeAcc8
 773 ;test2.j(271)   // constant - var
 774 ;test2.j(272)   // integer - byte
 775 ;test2.j(273)   if (3000 > b) write(53);
 776 acc8= variable 6
 777 acc16= constant 3000
 778 acc16CompareAcc8
 779 brle 783
 780 acc8= constant 53
 781 call writeAcc8
 782 ;test2.j(274)   if (1000 < b) write(999); else write(52);
 783 acc8= variable 6
 784 acc16= constant 1000
 785 acc16CompareAcc8
 786 brge 790
 787 acc16= constant 999
 788 call writeAcc16
 789 br 795
 790 acc8= constant 52
 791 call writeAcc8
 792 ;test2.j(275)   // constant - var
 793 ;test2.j(276)   // integer - integer
 794 ;test2.j(277)   if (3000 > i) write(51);
 795 acc16= variable 0
 796 acc16Comp constant 3000
 797 brge 801
 798 acc8= constant 51
 799 call writeAcc8
 800 ;test2.j(278)   if (1000 < i) write(50);
 801 acc16= variable 0
 802 acc16Comp constant 1000
 803 brle 811
 804 acc8= constant 50
 805 call writeAcc8
 806 ;test2.j(279) 
 807 ;test2.j(280)   /************************/
 808 ;test2.j(281)   // constant - acc
 809 ;test2.j(282)   // byte - byte
 810 ;test2.j(283)   write(49);
 811 acc8= constant 49
 812 call writeAcc8
 813 ;test2.j(284)   write(48);
 814 acc8= constant 48
 815 call writeAcc8
 816 ;test2.j(285)   if (1 > 0+0) write(47);
 817 acc8= constant 0
 818 acc8+ constant 0
 819 acc8Comp constant 1
 820 brge 824
 821 acc8= constant 47
 822 call writeAcc8
 823 ;test2.j(286)   if (1 < 2+0) write(46);
 824 acc8= constant 2
 825 acc8+ constant 0
 826 acc8Comp constant 1
 827 brle 833
 828 acc8= constant 46
 829 call writeAcc8
 830 ;test2.j(287)   // constant - acc
 831 ;test2.j(288)   // byte - integer
 832 ;test2.j(289)   if (1 > 1000+0) write(999); else write(45);
 833 acc16= constant 1000
 834 acc16+ constant 0
 835 acc8= constant 1
 836 acc8CompareAcc16
 837 brle 841
 838 acc16= constant 999
 839 call writeAcc16
 840 br 844
 841 acc8= constant 45
 842 call writeAcc8
 843 ;test2.j(290)   if (1 < 1000+0) write(44);
 844 acc16= constant 1000
 845 acc16+ constant 0
 846 acc8= constant 1
 847 acc8CompareAcc16
 848 brge 854
 849 acc8= constant 44
 850 call writeAcc8
 851 ;test2.j(291)   // constant - acc
 852 ;test2.j(292)   // integer - byte
 853 ;test2.j(293)   if (1000 > 0+0) write(43);
 854 acc8= constant 0
 855 acc8+ constant 0
 856 acc16= constant 1000
 857 acc16CompareAcc8
 858 brle 862
 859 acc8= constant 43
 860 call writeAcc8
 861 ;test2.j(294)   if (1000 < 0+0) write(999); else write(42);
 862 acc8= constant 0
 863 acc8+ constant 0
 864 acc16= constant 1000
 865 acc16CompareAcc8
 866 brge 870
 867 acc16= constant 999
 868 call writeAcc16
 869 br 875
 870 acc8= constant 42
 871 call writeAcc8
 872 ;test2.j(295)   // constant - acc
 873 ;test2.j(296)   // integer - integer
 874 ;test2.j(297)   if (2000 > 1000+0) write(41);
 875 acc16= constant 1000
 876 acc16+ constant 0
 877 acc16Comp constant 2000
 878 brge 882
 879 acc8= constant 41
 880 call writeAcc8
 881 ;test2.j(298)   if (1000 < 2000+0) write(40);
 882 acc16= constant 2000
 883 acc16+ constant 0
 884 acc16Comp constant 1000
 885 brle 893
 886 acc8= constant 40
 887 call writeAcc8
 888 ;test2.j(299) 
 889 ;test2.j(300)   /************************/
 890 ;test2.j(301)   // constant - constant
 891 ;test2.j(302)   // byte - byte
 892 ;test2.j(303)   write(39);
 893 acc8= constant 39
 894 call writeAcc8
 895 ;test2.j(304)   if (1 == 1) write(38);
 896 acc8= constant 1
 897 acc8Comp constant 1
 898 brne 902
 899 acc8= constant 38
 900 call writeAcc8
 901 ;test2.j(305)   if (1 != 0) write(37);
 902 acc8= constant 1
 903 acc8Comp constant 0
 904 breq 908
 905 acc8= constant 37
 906 call writeAcc8
 907 ;test2.j(306)   if (1 > 0) write(36);
 908 acc8= constant 1
 909 acc8Comp constant 0
 910 brle 914
 911 acc8= constant 36
 912 call writeAcc8
 913 ;test2.j(307)   if (1 >= 0) write(35);
 914 acc8= constant 1
 915 acc8Comp constant 0
 916 brlt 920
 917 acc8= constant 35
 918 call writeAcc8
 919 ;test2.j(308)   if (1 >= 1) write(34);
 920 acc8= constant 1
 921 acc8Comp constant 1
 922 brlt 926
 923 acc8= constant 34
 924 call writeAcc8
 925 ;test2.j(309)   if (1 < 2) write(33);
 926 acc8= constant 1
 927 acc8Comp constant 2
 928 brge 932
 929 acc8= constant 33
 930 call writeAcc8
 931 ;test2.j(310)   if (1 <= 2) write(32);
 932 acc8= constant 1
 933 acc8Comp constant 2
 934 brgt 938
 935 acc8= constant 32
 936 call writeAcc8
 937 ;test2.j(311)   if (1 <= 1) write(31);
 938 acc8= constant 1
 939 acc8Comp constant 1
 940 brgt 944
 941 acc8= constant 31
 942 call writeAcc8
 943 ;test2.j(312)   write(30);
 944 acc8= constant 30
 945 call writeAcc8
 946 ;test2.j(313)   // constant - constant
 947 ;test2.j(314)   // byte - integer
 948 ;test2.j(315)   write(29);
 949 acc8= constant 29
 950 call writeAcc8
 951 ;test2.j(316)   if (1 == 1000) write(999); else write(28);
 952 acc8= constant 1
 953 acc16= constant 1000
 954 acc8CompareAcc16
 955 brne 959
 956 acc16= constant 999
 957 call writeAcc16
 958 br 962
 959 acc8= constant 28
 960 call writeAcc8
 961 ;test2.j(317)   if (1 != 1000) write(27);
 962 acc8= constant 1
 963 acc16= constant 1000
 964 acc8CompareAcc16
 965 breq 969
 966 acc8= constant 27
 967 call writeAcc8
 968 ;test2.j(318)   if (1 > 1000) write(999); else write(26);
 969 acc8= constant 1
 970 acc16= constant 1000
 971 acc8CompareAcc16
 972 brle 976
 973 acc16= constant 999
 974 call writeAcc16
 975 br 979
 976 acc8= constant 26
 977 call writeAcc8
 978 ;test2.j(319)   if (1 >= 1000) write(999); write(25);
 979 acc8= constant 1
 980 acc16= constant 1000
 981 acc8CompareAcc16
 982 brlt 985
 983 acc16= constant 999
 984 call writeAcc16
 985 acc8= constant 25
 986 call writeAcc8
 987 ;test2.j(320)   if (1 >= 1000) write(999); write(24);
 988 acc8= constant 1
 989 acc16= constant 1000
 990 acc8CompareAcc16
 991 brlt 994
 992 acc16= constant 999
 993 call writeAcc16
 994 acc8= constant 24
 995 call writeAcc8
 996 ;test2.j(321)   if (1 < 2000) write(23);
 997 acc8= constant 1
 998 acc16= constant 2000
 999 acc8CompareAcc16
1000 brge 1004
1001 acc8= constant 23
1002 call writeAcc8
1003 ;test2.j(322)   if (1 <= 2000) write(22);
1004 acc8= constant 1
1005 acc16= constant 2000
1006 acc8CompareAcc16
1007 brgt 1011
1008 acc8= constant 22
1009 call writeAcc8
1010 ;test2.j(323)   if (1 <= 1000) write(21);
1011 acc8= constant 1
1012 acc16= constant 1000
1013 acc8CompareAcc16
1014 brgt 1018
1015 acc8= constant 21
1016 call writeAcc8
1017 ;test2.j(324)   write(20);
1018 acc8= constant 20
1019 call writeAcc8
1020 ;test2.j(325)   // constant - constant
1021 ;test2.j(326)   // integer - byte
1022 ;test2.j(327)   write(19);
1023 acc8= constant 19
1024 call writeAcc8
1025 ;test2.j(328)   if (1000 == 1) { write(999); } else { write(18); }
1026 acc16= constant 1000
1027 acc8= constant 1
1028 acc16CompareAcc8
1029 brne 1033
1030 acc16= constant 999
1031 call writeAcc16
1032 br 1036
1033 acc8= constant 18
1034 call writeAcc8
1035 ;test2.j(329)   if (1000 != 0) write(17);
1036 acc16= constant 1000
1037 acc8= constant 0
1038 acc16CompareAcc8
1039 breq 1043
1040 acc8= constant 17
1041 call writeAcc8
1042 ;test2.j(330)   if (1000 > 0) write(16);
1043 acc16= constant 1000
1044 acc8= constant 0
1045 acc16CompareAcc8
1046 brle 1050
1047 acc8= constant 16
1048 call writeAcc8
1049 ;test2.j(331)   if (1000 >= 0) write(15);
1050 acc16= constant 1000
1051 acc8= constant 0
1052 acc16CompareAcc8
1053 brlt 1057
1054 acc8= constant 15
1055 call writeAcc8
1056 ;test2.j(332)   if (1000 >= 1) write(14);
1057 acc16= constant 1000
1058 acc8= constant 1
1059 acc16CompareAcc8
1060 brlt 1064
1061 acc8= constant 14
1062 call writeAcc8
1063 ;test2.j(333)   if (1 < 2000) write(13);
1064 acc8= constant 1
1065 acc16= constant 2000
1066 acc8CompareAcc16
1067 brge 1071
1068 acc8= constant 13
1069 call writeAcc8
1070 ;test2.j(334)   if (1 <= 2000) write(12);
1071 acc8= constant 1
1072 acc16= constant 2000
1073 acc8CompareAcc16
1074 brgt 1078
1075 acc8= constant 12
1076 call writeAcc8
1077 ;test2.j(335)   if (1 <= 1000) write(11);
1078 acc8= constant 1
1079 acc16= constant 1000
1080 acc8CompareAcc16
1081 brgt 1085
1082 acc8= constant 11
1083 call writeAcc8
1084 ;test2.j(336)   write(10);
1085 acc8= constant 10
1086 call writeAcc8
1087 ;test2.j(337)   // constant - constant
1088 ;test2.j(338)   // integer - integer
1089 ;test2.j(339)   write(9);
1090 acc8= constant 9
1091 call writeAcc8
1092 ;test2.j(340)   if (1000 == 1000) write(8);
1093 acc16= constant 1000
1094 acc16Comp constant 1000
1095 brne 1099
1096 acc8= constant 8
1097 call writeAcc8
1098 ;test2.j(341)   if (1000 != 2000) write(7);
1099 acc16= constant 1000
1100 acc16Comp constant 2000
1101 breq 1105
1102 acc8= constant 7
1103 call writeAcc8
1104 ;test2.j(342)   if (2000 > 1000) write(6);
1105 acc16= constant 2000
1106 acc16Comp constant 1000
1107 brle 1111
1108 acc8= constant 6
1109 call writeAcc8
1110 ;test2.j(343)   if (2000 >= 1000) write(5);
1111 acc16= constant 2000
1112 acc16Comp constant 1000
1113 brlt 1117
1114 acc8= constant 5
1115 call writeAcc8
1116 ;test2.j(344)   if (1000 >= 1000) write(4);
1117 acc16= constant 1000
1118 acc16Comp constant 1000
1119 brlt 1123
1120 acc8= constant 4
1121 call writeAcc8
1122 ;test2.j(345)   if (1000 < 2000) write(3);
1123 acc16= constant 1000
1124 acc16Comp constant 2000
1125 brge 1129
1126 acc8= constant 3
1127 call writeAcc8
1128 ;test2.j(346)   if (1000 <= 2000) write(2);
1129 acc16= constant 1000
1130 acc16Comp constant 2000
1131 brgt 1135
1132 acc8= constant 2
1133 call writeAcc8
1134 ;test2.j(347)   if (1000 <= 1000) write(1);
1135 acc16= constant 1000
1136 acc16Comp constant 1000
1137 brgt 1142
1138 acc8= constant 1
1139 call writeAcc8
1140 ;test2.j(348) 
1141 ;test2.j(349)   write(0);
1142 acc8= constant 0
1143 call writeAcc8
1144 ;test2.j(350) }
1145 stop
