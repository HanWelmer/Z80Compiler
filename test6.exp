   0 ;test6.p(0) /*
   1 ;test6.p(1)  * A small program in the miniJava language.
   2 ;test6.p(2)  * Test 8-bit and 16-bit expressions.
   3 ;test6.p(3)  */
   4 ;test6.p(4) class Test8And16BitExpressions {
   5 ;test6.p(5)   write(0);         // 0
   6 acc8= constant 0
   7 call writeAcc8
   8 ;test6.p(6)   //LD    A,0
   9 ;test6.p(7)   //CALL  writeA
  10 ;test6.p(8)   //OK
  11 ;test6.p(9) 
  12 ;test6.p(10)   /*********************/
  13 ;test6.p(11)   /* Single term 8-bit */
  14 ;test6.p(12)   /*********************/
  15 ;test6.p(13)   byte b = 1;
  16 acc8= constant 1
  17 acc8=> variable 0
  18 ;test6.p(14)   byte c = 4;
  19 acc8= constant 4
  20 acc8=> variable 1
  21 ;test6.p(15)   write(b);         // 1
  22 acc8= variable 0
  23 call writeAcc8
  24 ;test6.p(16)   //LD    A,1
  25 ;test6.p(17)   //LD    (04000H),A
  26 ;test6.p(18)   //LD    A,(04000H)
  27 ;test6.p(19)   //CALL  writeA
  28 ;test6.p(20)   //OK
  29 ;test6.p(21) 
  30 ;test6.p(22)   /************************/
  31 ;test6.p(23)   /* Dual term addition   */
  32 ;test6.p(24)   /************************/
  33 ;test6.p(25)   write(0 + 2);     // 2
  34 acc8= constant 0
  35 acc8+ constant 2
  36 call writeAcc8
  37 ;test6.p(26)   write(b + 2);     // 3
  38 acc8= variable 0
  39 acc8+ constant 2
  40 call writeAcc8
  41 ;test6.p(27)   write(3 + b);     // 4
  42 acc8= constant 3
  43 acc8+ variable 0
  44 call writeAcc8
  45 ;test6.p(28)   write(b + c);     // 5
  46 acc8= variable 0
  47 acc8+ variable 1
  48 call writeAcc8
  49 ;test6.p(29) 
  50 ;test6.p(30)   c = 4 + 2;
  51 acc8= constant 4
  52 acc8+ constant 2
  53 acc8=> variable 1
  54 ;test6.p(31)   write(c);         // 6
  55 acc8= variable 1
  56 call writeAcc8
  57 ;test6.p(32)   c = b + 6;
  58 acc8= variable 0
  59 acc8+ constant 6
  60 acc8=> variable 1
  61 ;test6.p(33)   write(c);         // 7
  62 acc8= variable 1
  63 call writeAcc8
  64 ;test6.p(34)   c = 7 + b;
  65 acc8= constant 7
  66 acc8+ variable 0
  67 acc8=> variable 1
  68 ;test6.p(35)   write(c);         // 8
  69 acc8= variable 1
  70 call writeAcc8
  71 ;test6.p(36)   c = b + c;
  72 acc8= variable 0
  73 acc8+ variable 1
  74 acc8=> variable 1
  75 ;test6.p(37)   write(c);         // 9
  76 acc8= variable 1
  77 call writeAcc8
  78 ;test6.p(38) 
  79 ;test6.p(39) 
  80 ;test6.p(40)   int i = 10;
  81 acc8= constant 10
  82 acc8ToAcc16
  83 acc16=> variable 2
  84 ;test6.p(41)   write(i);         // 10
  85 acc16= variable 2
  86 call writeAcc16
  87 ;test6.p(42)   //LD    A,10
  88 ;test6.p(43)   //LD    L,A
  89 ;test6.p(44)   //LD    H,0
  90 ;test6.p(45)   //LD    (04004H),HL
  91 ;test6.p(46)   //OK
  92 ;test6.p(47)   
  93 ;test6.p(48)   write(i + 1);     // 11
  94 acc16= variable 2
  95 acc16+ constant 1
  96 call writeAcc16
  97 ;test6.p(49)   write(2 + i);     // 12
  98 acc8= constant 2
  99 acc8ToAcc16
 100 acc16+ variable 2
 101 call writeAcc16
 102 ;test6.p(50)   b = 3;
 103 acc8= constant 3
 104 acc8=> variable 0
 105 ;test6.p(51)   write(i + b);     // 13
 106 acc16= variable 2
 107 acc16+ variable 0
 108 call writeAcc16
 109 ;test6.p(52)   b++; //4
 110 incr8 variable 0
 111 ;test6.p(53)   write(b + i);     // 14
 112 acc8= variable 0
 113 acc8ToAcc16
 114 acc16+ variable 2
 115 call writeAcc16
 116 ;test6.p(54) 
 117 ;test6.p(55)   int j = i + 5;    // 15
 118 acc16= variable 2
 119 acc16+ constant 5
 120 acc16=> variable 4
 121 ;test6.p(56)   write(j);
 122 acc16= variable 4
 123 call writeAcc16
 124 ;test6.p(57)   j = 6 + i;        // 16
 125 acc8= constant 6
 126 acc8ToAcc16
 127 acc16+ variable 2
 128 acc16=> variable 4
 129 ;test6.p(58)   write(j);
 130 acc16= variable 4
 131 call writeAcc16
 132 ;test6.p(59)   j = 7;
 133 acc8= constant 7
 134 acc8ToAcc16
 135 acc16=> variable 4
 136 ;test6.p(60)   j = i + j;        // 17
 137 acc16= variable 2
 138 acc16+ variable 4
 139 acc16=> variable 4
 140 ;test6.p(61)   write(j);
 141 acc16= variable 4
 142 call writeAcc16
 143 ;test6.p(62) 
 144 ;test6.p(63)   /*************************/
 145 ;test6.p(64)   /* Dual term subtraction */
 146 ;test6.p(65)   /*************************/
 147 ;test6.p(66)   b = 33;
 148 acc8= constant 33
 149 acc8=> variable 0
 150 ;test6.p(67)   c = 12;
 151 acc8= constant 12
 152 acc8=> variable 1
 153 ;test6.p(68)   write(19 - 1);    // 18
 154 acc8= constant 19
 155 acc8- constant 1
 156 call writeAcc8
 157 ;test6.p(69)   write(b - 14);    // 19
 158 acc8= variable 0
 159 acc8- constant 14
 160 call writeAcc8
 161 ;test6.p(70)   write(53 - b);    // 20
 162 acc8= constant 53
 163 acc8- variable 0
 164 call writeAcc8
 165 ;test6.p(71)   write(b - c);     // 21
 166 acc8= variable 0
 167 acc8- variable 1
 168 call writeAcc8
 169 ;test6.p(72) 
 170 ;test6.p(73)   c = 24 - 2;
 171 acc8= constant 24
 172 acc8- constant 2
 173 acc8=> variable 1
 174 ;test6.p(74)   write(c);         // 22
 175 acc8= variable 1
 176 call writeAcc8
 177 ;test6.p(75)   c = b - 10;
 178 acc8= variable 0
 179 acc8- constant 10
 180 acc8=> variable 1
 181 ;test6.p(76)   write(c);         // 23
 182 acc8= variable 1
 183 call writeAcc8
 184 ;test6.p(77)   c = 57 - b;
 185 acc8= constant 57
 186 acc8- variable 0
 187 acc8=> variable 1
 188 ;test6.p(78)   write(c);         // 24
 189 acc8= variable 1
 190 call writeAcc8
 191 ;test6.p(79)   c = 8;
 192 acc8= constant 8
 193 acc8=> variable 1
 194 ;test6.p(80)   c = b - c;
 195 acc8= variable 0
 196 acc8- variable 1
 197 acc8=> variable 1
 198 ;test6.p(81)   write(c);         // 25
 199 acc8= variable 1
 200 call writeAcc8
 201 ;test6.p(82) 
 202 ;test6.p(83)   i = 40;
 203 acc8= constant 40
 204 acc8ToAcc16
 205 acc16=> variable 2
 206 ;test6.p(84)   write(i - 14);    // 26
 207 acc16= variable 2
 208 acc16- constant 14
 209 call writeAcc16
 210 ;test6.p(85)   write(67 - i);    // 27
 211 acc8= constant 67
 212 acc8ToAcc16
 213 acc16- variable 2
 214 call writeAcc16
 215 ;test6.p(86)   b = 12;
 216 acc8= constant 12
 217 acc8=> variable 0
 218 ;test6.p(87)   write(i - b);     // 28
 219 acc16= variable 2
 220 acc16- variable 0
 221 call writeAcc16
 222 ;test6.p(88)   b = 69;
 223 acc8= constant 69
 224 acc8=> variable 0
 225 ;test6.p(89)   write(b - i);     // 29
 226 acc8= variable 0
 227 acc8ToAcc16
 228 acc16- variable 2
 229 call writeAcc16
 230 ;test6.p(90) 
 231 ;test6.p(91)   j = i - 10;
 232 acc16= variable 2
 233 acc16- constant 10
 234 acc16=> variable 4
 235 ;test6.p(92)   write(j);         // 30
 236 acc16= variable 4
 237 call writeAcc16
 238 ;test6.p(93)   j = 71 - i;
 239 acc8= constant 71
 240 acc8ToAcc16
 241 acc16- variable 2
 242 acc16=> variable 4
 243 ;test6.p(94)   write(j);         // 31
 244 acc16= variable 4
 245 call writeAcc16
 246 ;test6.p(95)   j = 8;
 247 acc8= constant 8
 248 acc8ToAcc16
 249 acc16=> variable 4
 250 ;test6.p(96)   j = i - j;
 251 acc16= variable 2
 252 acc16- variable 4
 253 acc16=> variable 4
 254 ;test6.p(97)   write(j);         // 32
 255 acc16= variable 4
 256 call writeAcc16
 257 ;test6.p(98)   
 258 ;test6.p(99)   /****************************/
 259 ;test6.p(100)   /* Dual term multiplication */
 260 ;test6.p(101)   /****************************/
 261 ;test6.p(102)   write(3 * 11);    // 33
 262 acc8= constant 3
 263 acc8* constant 11
 264 call writeAcc8
 265 ;test6.p(103)   b = 17;
 266 acc8= constant 17
 267 acc8=> variable 0
 268 ;test6.p(104)   write(b * 2);     // 34
 269 acc8= variable 0
 270 acc8* constant 2
 271 call writeAcc8
 272 ;test6.p(105)   b = 7;
 273 acc8= constant 7
 274 acc8=> variable 0
 275 ;test6.p(106)   write(5 * b);     // 35
 276 acc8= constant 5
 277 acc8* variable 0
 278 call writeAcc8
 279 ;test6.p(107)   b = 2;
 280 acc8= constant 2
 281 acc8=> variable 0
 282 ;test6.p(108)   c = 18;
 283 acc8= constant 18
 284 acc8=> variable 1
 285 ;test6.p(109)   write(b * c);     // 36
 286 acc8= variable 0
 287 acc8* variable 1
 288 call writeAcc8
 289 ;test6.p(110)   
 290 ;test6.p(111)   c = 37 * 1;
 291 acc8= constant 37
 292 acc8* constant 1
 293 acc8=> variable 1
 294 ;test6.p(112)   write(c);         // 37
 295 acc8= variable 1
 296 call writeAcc8
 297 ;test6.p(113)   b = 2;
 298 acc8= constant 2
 299 acc8=> variable 0
 300 ;test6.p(114)   c = b * 19;
 301 acc8= variable 0
 302 acc8* constant 19
 303 acc8=> variable 1
 304 ;test6.p(115)   write(c);         // 38
 305 acc8= variable 1
 306 call writeAcc8
 307 ;test6.p(116)   b = 3;
 308 acc8= constant 3
 309 acc8=> variable 0
 310 ;test6.p(117)   c = 13 * b;
 311 acc8= constant 13
 312 acc8* variable 0
 313 acc8=> variable 1
 314 ;test6.p(118)   write(c);         // 39
 315 acc8= variable 1
 316 call writeAcc8
 317 ;test6.p(119)   b = 5;
 318 acc8= constant 5
 319 acc8=> variable 0
 320 ;test6.p(120)   c = 8;
 321 acc8= constant 8
 322 acc8=> variable 1
 323 ;test6.p(121)   c = b * c;
 324 acc8= variable 0
 325 acc8* variable 1
 326 acc8=> variable 1
 327 ;test6.p(122)   write(c);         // 40
 328 acc8= variable 1
 329 call writeAcc8
 330 ;test6.p(123) 
 331 ;test6.p(124)   /**********************/
 332 ;test6.p(125)   /* Dual term division */
 333 ;test6.p(126)   /**********************/
 334 ;test6.p(127)   write(123 / 3);   // 41
 335 acc8= constant 123
 336 acc8/ constant 3
 337 call writeAcc8
 338 ;test6.p(128)   b = 126;
 339 acc8= constant 126
 340 acc8=> variable 0
 341 ;test6.p(129)   write(b / 3);     // 42
 342 acc8= variable 0
 343 acc8/ constant 3
 344 call writeAcc8
 345 ;test6.p(130)   b = 3;
 346 acc8= constant 3
 347 acc8=> variable 0
 348 ;test6.p(131)   write(129 / b);   // 43
 349 acc8= constant 129
 350 acc8/ variable 0
 351 call writeAcc8
 352 ;test6.p(132)   b = 132;
 353 acc8= constant 132
 354 acc8=> variable 0
 355 ;test6.p(133)   c = 3;
 356 acc8= constant 3
 357 acc8=> variable 1
 358 ;test6.p(134)   write(b / c);     // 44
 359 acc8= variable 0
 360 acc8/ variable 1
 361 call writeAcc8
 362 ;test6.p(135)   
 363 ;test6.p(136)   c = 135 / 3;
 364 acc8= constant 135
 365 acc8/ constant 3
 366 acc8=> variable 1
 367 ;test6.p(137)   write(c);         // 45
 368 acc8= variable 1
 369 call writeAcc8
 370 ;test6.p(138)   b = 138;
 371 acc8= constant 138
 372 acc8=> variable 0
 373 ;test6.p(139)   c = b / 3;
 374 acc8= variable 0
 375 acc8/ constant 3
 376 acc8=> variable 1
 377 ;test6.p(140)   write(c);         // 46
 378 acc8= variable 1
 379 call writeAcc8
 380 ;test6.p(141)   b = 3;
 381 acc8= constant 3
 382 acc8=> variable 0
 383 ;test6.p(142)   c = 141 / b;
 384 acc8= constant 141
 385 acc8/ variable 0
 386 acc8=> variable 1
 387 ;test6.p(143)   write(c);         // 47
 388 acc8= variable 1
 389 call writeAcc8
 390 ;test6.p(144)   b = 144;
 391 acc8= constant 144
 392 acc8=> variable 0
 393 ;test6.p(145)   c = 3;
 394 acc8= constant 3
 395 acc8=> variable 1
 396 ;test6.p(146)   c = b / c;
 397 acc8= variable 0
 398 acc8/ variable 1
 399 acc8=> variable 1
 400 ;test6.p(147)   write(c);         // 48
 401 acc8= variable 1
 402 call writeAcc8
 403 ;test6.p(148) 
 404 ;test6.p(149)   /*************************/
 405 ;test6.p(150)   /* possible loss of data */
 406 ;test6.p(151)   /*************************/
 407 ;test6.p(152)   b = 507;
 408 acc16= constant 507
 409 acc16ToAcc8
 410 acc8=> variable 0
 411 ;test6.p(153)   write(b);         // 251
 412 acc8= variable 0
 413 call writeAcc8
 414 ;test6.p(154)   i = 508;
 415 acc16= constant 508
 416 acc16=> variable 2
 417 ;test6.p(155)   b = i;
 418 acc16= variable 2
 419 acc16ToAcc8
 420 acc8=> variable 0
 421 ;test6.p(156)   write(b);         // 252
 422 acc8= variable 0
 423 call writeAcc8
 424 ;test6.p(157) 
 425 ;test6.p(158)   b = b - 505;
 426 acc8= variable 0
 427 acc8ToAcc16
 428 acc16- constant 505
 429 acc16ToAcc8
 430 acc8=> variable 0
 431 ;test6.p(159)   write(b);         // 252 - 505 = -253
 432 acc8= variable 0
 433 call writeAcc8
 434 ;test6.p(160)   i = i + 5;
 435 acc16= variable 2
 436 acc16+ constant 5
 437 acc16=> variable 2
 438 ;test6.p(161)   b = b - i;
 439 acc8= variable 0
 440 acc8ToAcc16
 441 acc16- variable 2
 442 acc16ToAcc8
 443 acc8=> variable 0
 444 ;test6.p(162)   write(b);         // -233 - 11 = -254
 445 acc8= variable 0
 446 call writeAcc8
 447 ;test6.p(163)   
 448 ;test6.p(164)   b = 255;
 449 acc8= constant 255
 450 acc8=> variable 0
 451 ;test6.p(165)   write(b);         // 255
 452 acc8= variable 0
 453 call writeAcc8
 454 ;test6.p(166)   //LD    A,255
 455 ;test6.p(167)   //LD    (04001H),A
 456 ;test6.p(168)   //LD    A,(04001H)
 457 ;test6.p(169)   //CALL  writeA
 458 ;test6.p(170)   //OK
 459 ;test6.p(171) 
 460 ;test6.p(172)   /**********************/
 461 ;test6.p(173)   /* Single term 16-bit */
 462 ;test6.p(174)   /**********************/
 463 ;test6.p(175)   i = 256;
 464 acc16= constant 256
 465 acc16=> variable 2
 466 ;test6.p(176)   write(i);         // 256
 467 acc16= variable 2
 468 call writeAcc16
 469 ;test6.p(177)   //LD    HL,256
 470 ;test6.p(178)   //LD    (04006H),HL
 471 ;test6.p(179)   //LD    HL,(04006H)
 472 ;test6.p(180)   //CALL  writeHL
 473 ;test6.p(181)   //OK
 474 ;test6.p(182) 
 475 ;test6.p(183)   write(1000);      // 1000
 476 acc16= constant 1000
 477 call writeAcc16
 478 ;test6.p(184)   j = 1001;
 479 acc16= constant 1001
 480 acc16=> variable 4
 481 ;test6.p(185)   write(j);         // 1001
 482 acc16= variable 4
 483 call writeAcc16
 484 ;test6.p(186) 
 485 ;test6.p(187)   /************************/
 486 ;test6.p(188)   /* Dual term addition   */
 487 ;test6.p(189)   /************************/
 488 ;test6.p(190)   write(1000 + 2);  // 1002
 489 acc16= constant 1000
 490 acc16+ constant 2
 491 call writeAcc16
 492 ;test6.p(191)   write(3 + 1000);  // 1003
 493 acc8= constant 3
 494 acc8ToAcc16
 495 acc16+ constant 1000
 496 call writeAcc16
 497 ;test6.p(192)   write(500 + 504); // 1004
 498 acc16= constant 500
 499 acc16+ constant 504
 500 call writeAcc16
 501 ;test6.p(193)   i = 1000 + 5;
 502 acc16= constant 1000
 503 acc16+ constant 5
 504 acc16=> variable 2
 505 ;test6.p(194)   write(i);         // 1005
 506 acc16= variable 2
 507 call writeAcc16
 508 ;test6.p(195)   i = 6 + 1000;
 509 acc8= constant 6
 510 acc8ToAcc16
 511 acc16+ constant 1000
 512 acc16=> variable 2
 513 ;test6.p(196)   write(i);         // 1006
 514 acc16= variable 2
 515 call writeAcc16
 516 ;test6.p(197)   i = 500 + 507;
 517 acc16= constant 500
 518 acc16+ constant 507
 519 acc16=> variable 2
 520 ;test6.p(198)   write(i);         // 1007
 521 acc16= variable 2
 522 call writeAcc16
 523 ;test6.p(199)   
 524 ;test6.p(200)   j = 1000;
 525 acc16= constant 1000
 526 acc16=> variable 4
 527 ;test6.p(201)   b = 10;
 528 acc8= constant 10
 529 acc8=> variable 0
 530 ;test6.p(202)   i = 514;
 531 acc16= constant 514
 532 acc16=> variable 2
 533 ;test6.p(203)   write(j + 8);     // 1008
 534 acc16= variable 4
 535 acc16+ constant 8
 536 call writeAcc16
 537 ;test6.p(204)   write(9 + j);     // 1009
 538 acc8= constant 9
 539 acc8ToAcc16
 540 acc16+ variable 4
 541 call writeAcc16
 542 ;test6.p(205)   write(j + b);     // 1010
 543 acc16= variable 4
 544 acc16+ variable 0
 545 call writeAcc16
 546 ;test6.p(206)   b++;
 547 incr8 variable 0
 548 ;test6.p(207)   write(b + j);     // 1011
 549 acc8= variable 0
 550 acc8ToAcc16
 551 acc16+ variable 4
 552 call writeAcc16
 553 ;test6.p(208)   j = 500;
 554 acc16= constant 500
 555 acc16=> variable 4
 556 ;test6.p(209)   write(j + 512);   // 1012
 557 acc16= variable 4
 558 acc16+ constant 512
 559 call writeAcc16
 560 ;test6.p(210)   write(513 + j);   // 1013
 561 acc16= constant 513
 562 acc16+ variable 4
 563 call writeAcc16
 564 ;test6.p(211)   write(i + j);     // 1014
 565 acc16= variable 2
 566 acc16+ variable 4
 567 call writeAcc16
 568 ;test6.p(212)   
 569 ;test6.p(213)   j = 1000;
 570 acc16= constant 1000
 571 acc16=> variable 4
 572 ;test6.p(214)   b = 17;
 573 acc8= constant 17
 574 acc8=> variable 0
 575 ;test6.p(215)   i = j + 15;
 576 acc16= variable 4
 577 acc16+ constant 15
 578 acc16=> variable 2
 579 ;test6.p(216)   write(i);         // 1015
 580 acc16= variable 2
 581 call writeAcc16
 582 ;test6.p(217)   i = 16 + j;
 583 acc8= constant 16
 584 acc8ToAcc16
 585 acc16+ variable 4
 586 acc16=> variable 2
 587 ;test6.p(218)   write(i);         // 1016
 588 acc16= variable 2
 589 call writeAcc16
 590 ;test6.p(219)   i = j + b;
 591 acc16= variable 4
 592 acc16+ variable 0
 593 acc16=> variable 2
 594 ;test6.p(220)   write(i);         // 1017
 595 acc16= variable 2
 596 call writeAcc16
 597 ;test6.p(221)   b++;
 598 incr8 variable 0
 599 ;test6.p(222)   i = b + j;
 600 acc8= variable 0
 601 acc8ToAcc16
 602 acc16+ variable 4
 603 acc16=> variable 2
 604 ;test6.p(223)   write(i);         // 1018
 605 acc16= variable 2
 606 call writeAcc16
 607 ;test6.p(224)   j = 500;
 608 acc16= constant 500
 609 acc16=> variable 4
 610 ;test6.p(225)   i = j + 519;
 611 acc16= variable 4
 612 acc16+ constant 519
 613 acc16=> variable 2
 614 ;test6.p(226)   write(i);         // 1019
 615 acc16= variable 2
 616 call writeAcc16
 617 ;test6.p(227)   i = 520 + j;
 618 acc16= constant 520
 619 acc16+ variable 4
 620 acc16=> variable 2
 621 ;test6.p(228)   write(i);         // 1020
 622 acc16= variable 2
 623 call writeAcc16
 624 ;test6.p(229)   i = 521;
 625 acc16= constant 521
 626 acc16=> variable 2
 627 ;test6.p(230)   i = i + j;
 628 acc16= variable 2
 629 acc16+ variable 4
 630 acc16=> variable 2
 631 ;test6.p(231)   write(i);         // 1021
 632 acc16= variable 2
 633 call writeAcc16
 634 ;test6.p(232)   
 635 ;test6.p(233)   /*************************/
 636 ;test6.p(234)   /* Dual term subtraction */
 637 ;test6.p(235)   /*************************/
 638 ;test6.p(236)   write(1024 - 2);  // 1022
 639 acc16= constant 1024
 640 acc16- constant 2
 641 call writeAcc16
 642 ;test6.p(237)   write(1523 - 500);// 1023
 643 acc16= constant 1523
 644 acc16- constant 500
 645 call writeAcc16
 646 ;test6.p(238)   i = 1030 - 6;
 647 acc16= constant 1030
 648 acc16- constant 6
 649 acc16=> variable 2
 650 ;test6.p(239)   write(i);         // 1024
 651 acc16= variable 2
 652 call writeAcc16
 653 ;test6.p(240)   i = 1525 - 500;
 654 acc16= constant 1525
 655 acc16- constant 500
 656 acc16=> variable 2
 657 ;test6.p(241)   write(i);         // 1025
 658 acc16= variable 2
 659 call writeAcc16
 660 ;test6.p(242)   
 661 ;test6.p(243)   j = 1040;
 662 acc16= constant 1040
 663 acc16=> variable 4
 664 ;test6.p(244)   b = 13;
 665 acc8= constant 13
 666 acc8=> variable 0
 667 ;test6.p(245)   i = 3030;
 668 acc16= constant 3030
 669 acc16=> variable 2
 670 ;test6.p(246)   write(j - 14);    // 1026
 671 acc16= variable 4
 672 acc16- constant 14
 673 call writeAcc16
 674 ;test6.p(247)   write(j - b);     // 1027
 675 acc16= variable 4
 676 acc16- variable 0
 677 call writeAcc16
 678 ;test6.p(248)   j = 2000;
 679 acc16= constant 2000
 680 acc16=> variable 4
 681 ;test6.p(249)   write(j - 972);   // 1028
 682 acc16= variable 4
 683 acc16- constant 972
 684 call writeAcc16
 685 ;test6.p(250)   write(3029 - j);  // 1029
 686 acc16= constant 3029
 687 acc16- variable 4
 688 call writeAcc16
 689 ;test6.p(251)   write(i - j);     // 1030
 690 acc16= variable 2
 691 acc16- variable 4
 692 call writeAcc16
 693 ;test6.p(252)   
 694 ;test6.p(253)   j = 1050;
 695 acc16= constant 1050
 696 acc16=> variable 4
 697 ;test6.p(254)   b = 18;
 698 acc8= constant 18
 699 acc8=> variable 0
 700 ;test6.p(255)   i = j - 19;
 701 acc16= variable 4
 702 acc16- constant 19
 703 acc16=> variable 2
 704 ;test6.p(256)   write(i);         // 1031
 705 acc16= variable 2
 706 call writeAcc16
 707 ;test6.p(257)   i = j - b;
 708 acc16= variable 4
 709 acc16- variable 0
 710 acc16=> variable 2
 711 ;test6.p(258)   write(i);         // 1032
 712 acc16= variable 2
 713 call writeAcc16
 714 ;test6.p(259)   j = 2000;
 715 acc16= constant 2000
 716 acc16=> variable 4
 717 ;test6.p(260)   i = j - 967;
 718 acc16= variable 4
 719 acc16- constant 967
 720 acc16=> variable 2
 721 ;test6.p(261)   write(i);         // 1033
 722 acc16= variable 2
 723 call writeAcc16
 724 ;test6.p(262)   i = 3034 - j;
 725 acc16= constant 3034
 726 acc16- variable 4
 727 acc16=> variable 2
 728 ;test6.p(263)   write(i);         // 1034
 729 acc16= variable 2
 730 call writeAcc16
 731 ;test6.p(264)   i = 3035;
 732 acc16= constant 3035
 733 acc16=> variable 2
 734 ;test6.p(265)   i = i - j;
 735 acc16= variable 2
 736 acc16- variable 4
 737 acc16=> variable 2
 738 ;test6.p(266)   write(i);         // 1035
 739 acc16= variable 2
 740 call writeAcc16
 741 ;test6.p(267)   
 742 ;test6.p(268)   /****************************/
 743 ;test6.p(269)   /* Dual term multiplication */
 744 ;test6.p(270)   /****************************/
 745 ;test6.p(271)   write(518 * 2);   // 1036
 746 acc16= constant 518
 747 acc16* constant 2
 748 call writeAcc16
 749 ;test6.p(272)   write(1 * 1037);  // 1037
 750 acc8= constant 1
 751 acc8ToAcc16
 752 acc16* constant 1037
 753 call writeAcc16
 754 ;test6.p(273)   write(500 * 504 - 54354); // 1038 = 55392 - 54354
 755 acc16= constant 500
 756 acc16* constant 504
 757 acc16- constant 54354
 758 call writeAcc16
 759 ;test6.p(274) 
 760 ;test6.p(275)   i = 1039 * 1;
 761 acc16= constant 1039
 762 acc16* constant 1
 763 acc16=> variable 2
 764 ;test6.p(276)   write(i);         // 1039
 765 acc16= variable 2
 766 call writeAcc16
 767 ;test6.p(277)   i = 2 * 520;
 768 acc8= constant 2
 769 acc8ToAcc16
 770 acc16* constant 520
 771 acc16=> variable 2
 772 ;test6.p(278)   write(i);         // 1040
 773 acc16= variable 2
 774 call writeAcc16
 775 ;test6.p(279) 
 776 ;test6.p(280)   i = 1041;
 777 acc16= constant 1041
 778 acc16=> variable 2
 779 ;test6.p(281)   write(i * 1);     // 1041
 780 acc16= variable 2
 781 acc16* constant 1
 782 call writeAcc16
 783 ;test6.p(282)   i = 521;
 784 acc16= constant 521
 785 acc16=> variable 2
 786 ;test6.p(283)   write(2 * i);     // 1042
 787 acc8= constant 2
 788 acc8ToAcc16
 789 acc16* variable 2
 790 call writeAcc16
 791 ;test6.p(284) 
 792 ;test6.p(285)   i = 1043;
 793 acc16= constant 1043
 794 acc16=> variable 2
 795 ;test6.p(286)   i = i * 1;
 796 acc16= variable 2
 797 acc16* constant 1
 798 acc16=> variable 2
 799 ;test6.p(287)   write(i);         // 1043
 800 acc16= variable 2
 801 call writeAcc16
 802 ;test6.p(288)   i = 522;
 803 acc16= constant 522
 804 acc16=> variable 2
 805 ;test6.p(289)   i = 2 * i;
 806 acc8= constant 2
 807 acc8ToAcc16
 808 acc16* variable 2
 809 acc16=> variable 2
 810 ;test6.p(290)   write(i);         // 1044
 811 acc16= variable 2
 812 call writeAcc16
 813 ;test6.p(291) 
 814 ;test6.p(292)   i = 500 * 504 - 54347; // 1045 = 55392 - 54347
 815 acc16= constant 500
 816 acc16* constant 504
 817 acc16- constant 54347
 818 acc16=> variable 2
 819 ;test6.p(293)   write(i);         // 1045
 820 acc16= variable 2
 821 call writeAcc16
 822 ;test6.p(294)   i = 500;
 823 acc16= constant 500
 824 acc16=> variable 2
 825 ;test6.p(295)   i = i * 504 - 54346;
 826 acc16= variable 2
 827 acc16* constant 504
 828 acc16- constant 54346
 829 acc16=> variable 2
 830 ;test6.p(296)   write(i);         // 1046
 831 acc16= variable 2
 832 call writeAcc16
 833 ;test6.p(297)   i = 504;
 834 acc16= constant 504
 835 acc16=> variable 2
 836 ;test6.p(298)   i = 500 * i - 54345;
 837 acc16= constant 500
 838 acc16* variable 2
 839 acc16- constant 54345
 840 acc16=> variable 2
 841 ;test6.p(299)   write(i);         // 1047
 842 acc16= variable 2
 843 call writeAcc16
 844 ;test6.p(300)   
 845 ;test6.p(301)   /************/
 846 ;test6.p(302)   /* Overflow */
 847 ;test6.p(303)   /************/
 848 ;test6.p(304)   write(300 * 301); // 90.300 % 65536 = 24.764
 849 acc16= constant 300
 850 acc16* constant 301
 851 call writeAcc16
 852 ;test6.p(305)   i = 300 * 302;
 853 acc16= constant 300
 854 acc16* constant 302
 855 acc16=> variable 2
 856 ;test6.p(306)   write(i);         // 90.600 % 65536 = 25.064
 857 acc16= variable 2
 858 call writeAcc16
 859 ;test6.p(307) 
 860 ;test6.p(308) }
 861 stop
