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
  82 acc8=> variable 2
  83 ;test6.p(41)   write(i);         // 10
  84 acc16= variable 2
  85 call writeAcc16
  86 ;test6.p(42)   //LD    A,10
  87 ;test6.p(43)   //LD    L,A
  88 ;test6.p(44)   //LD    H,0
  89 ;test6.p(45)   //LD    (04004H),HL
  90 ;test6.p(46)   //OK
  91 ;test6.p(47)   
  92 ;test6.p(48)   write(i + 1);     // 11
  93 acc16= variable 2
  94 acc16+ constant 1
  95 call writeAcc16
  96 ;test6.p(49)   write(2 + i);     // 12
  97 acc8= constant 2
  98 acc8ToAcc16
  99 acc16+ variable 2
 100 call writeAcc16
 101 ;test6.p(50)   b = 3;
 102 acc8= constant 3
 103 acc8=> variable 0
 104 ;test6.p(51)   write(i + b);     // 13
 105 acc16= variable 2
 106 acc16+ variable 0
 107 call writeAcc16
 108 ;test6.p(52)   b++; //4
 109 incr8 variable 0
 110 ;test6.p(53)   write(b + i);     // 14
 111 acc8= variable 0
 112 acc8ToAcc16
 113 acc16+ variable 2
 114 call writeAcc16
 115 ;test6.p(54) 
 116 ;test6.p(55)   int j = i + 5;    // 15
 117 acc16= variable 2
 118 acc16+ constant 5
 119 acc16=> variable 4
 120 ;test6.p(56)   write(j);
 121 acc16= variable 4
 122 call writeAcc16
 123 ;test6.p(57)   j = 6 + i;        // 16
 124 acc8= constant 6
 125 acc8ToAcc16
 126 acc16+ variable 2
 127 acc16=> variable 4
 128 ;test6.p(58)   write(j);
 129 acc16= variable 4
 130 call writeAcc16
 131 ;test6.p(59)   j = 7;
 132 acc8= constant 7
 133 acc8=> variable 4
 134 ;test6.p(60)   j = i + j;        // 17
 135 acc16= variable 2
 136 acc16+ variable 4
 137 acc16=> variable 4
 138 ;test6.p(61)   write(j);
 139 acc16= variable 4
 140 call writeAcc16
 141 ;test6.p(62) 
 142 ;test6.p(63)   /*************************/
 143 ;test6.p(64)   /* Dual term subtraction */
 144 ;test6.p(65)   /*************************/
 145 ;test6.p(66)   b = 33;
 146 acc8= constant 33
 147 acc8=> variable 0
 148 ;test6.p(67)   c = 12;
 149 acc8= constant 12
 150 acc8=> variable 1
 151 ;test6.p(68)   write(19 - 1);    // 18
 152 acc8= constant 19
 153 acc8- constant 1
 154 call writeAcc8
 155 ;test6.p(69)   write(b - 14);    // 19
 156 acc8= variable 0
 157 acc8- constant 14
 158 call writeAcc8
 159 ;test6.p(70)   write(53 - b);    // 20
 160 acc8= constant 53
 161 acc8- variable 0
 162 call writeAcc8
 163 ;test6.p(71)   write(b - c);     // 21
 164 acc8= variable 0
 165 acc8- variable 1
 166 call writeAcc8
 167 ;test6.p(72) 
 168 ;test6.p(73)   c = 24 - 2;
 169 acc8= constant 24
 170 acc8- constant 2
 171 acc8=> variable 1
 172 ;test6.p(74)   write(c);         // 22
 173 acc8= variable 1
 174 call writeAcc8
 175 ;test6.p(75)   c = b - 10;
 176 acc8= variable 0
 177 acc8- constant 10
 178 acc8=> variable 1
 179 ;test6.p(76)   write(c);         // 23
 180 acc8= variable 1
 181 call writeAcc8
 182 ;test6.p(77)   c = 57 - b;
 183 acc8= constant 57
 184 acc8- variable 0
 185 acc8=> variable 1
 186 ;test6.p(78)   write(c);         // 24
 187 acc8= variable 1
 188 call writeAcc8
 189 ;test6.p(79)   c = 8;
 190 acc8= constant 8
 191 acc8=> variable 1
 192 ;test6.p(80)   c = b - c;
 193 acc8= variable 0
 194 acc8- variable 1
 195 acc8=> variable 1
 196 ;test6.p(81)   write(c);         // 25
 197 acc8= variable 1
 198 call writeAcc8
 199 ;test6.p(82) 
 200 ;test6.p(83)   i = 40;
 201 acc8= constant 40
 202 acc8=> variable 2
 203 ;test6.p(84)   write(i - 14);    // 26
 204 acc16= variable 2
 205 acc16- constant 14
 206 call writeAcc16
 207 ;test6.p(85)   write(67 - i);    // 27
 208 acc8= constant 67
 209 acc8ToAcc16
 210 acc16- variable 2
 211 call writeAcc16
 212 ;test6.p(86)   b = 12;
 213 acc8= constant 12
 214 acc8=> variable 0
 215 ;test6.p(87)   write(i - b);     // 28
 216 acc16= variable 2
 217 acc16- variable 0
 218 call writeAcc16
 219 ;test6.p(88)   b = 69;
 220 acc8= constant 69
 221 acc8=> variable 0
 222 ;test6.p(89)   write(b - i);     // 29
 223 acc8= variable 0
 224 acc8ToAcc16
 225 acc16- variable 2
 226 call writeAcc16
 227 ;test6.p(90) 
 228 ;test6.p(91)   j = i - 10;
 229 acc16= variable 2
 230 acc16- constant 10
 231 acc16=> variable 4
 232 ;test6.p(92)   write(j);         // 30
 233 acc16= variable 4
 234 call writeAcc16
 235 ;test6.p(93)   j = 71 - i;
 236 acc8= constant 71
 237 acc8ToAcc16
 238 acc16- variable 2
 239 acc16=> variable 4
 240 ;test6.p(94)   write(j);         // 31
 241 acc16= variable 4
 242 call writeAcc16
 243 ;test6.p(95)   j = 8;
 244 acc8= constant 8
 245 acc8=> variable 4
 246 ;test6.p(96)   j = i - j;
 247 acc16= variable 2
 248 acc16- variable 4
 249 acc16=> variable 4
 250 ;test6.p(97)   write(j);         // 32
 251 acc16= variable 4
 252 call writeAcc16
 253 ;test6.p(98)   
 254 ;test6.p(99)   /****************************/
 255 ;test6.p(100)   /* Dual term multiplication */
 256 ;test6.p(101)   /****************************/
 257 ;test6.p(102)   write(3 * 11);    // 33
 258 acc8= constant 3
 259 acc8* constant 11
 260 call writeAcc8
 261 ;test6.p(103)   b = 17;
 262 acc8= constant 17
 263 acc8=> variable 0
 264 ;test6.p(104)   write(b * 2);     // 34
 265 acc8= variable 0
 266 acc8* constant 2
 267 call writeAcc8
 268 ;test6.p(105)   b = 7;
 269 acc8= constant 7
 270 acc8=> variable 0
 271 ;test6.p(106)   write(5 * b);     // 35
 272 acc8= constant 5
 273 acc8* variable 0
 274 call writeAcc8
 275 ;test6.p(107)   b = 2;
 276 acc8= constant 2
 277 acc8=> variable 0
 278 ;test6.p(108)   c = 18;
 279 acc8= constant 18
 280 acc8=> variable 1
 281 ;test6.p(109)   write(b * c);     // 36
 282 acc8= variable 0
 283 acc8* variable 1
 284 call writeAcc8
 285 ;test6.p(110)   
 286 ;test6.p(111)   c = 37 * 1;
 287 acc8= constant 37
 288 acc8* constant 1
 289 acc8=> variable 1
 290 ;test6.p(112)   write(c);         // 37
 291 acc8= variable 1
 292 call writeAcc8
 293 ;test6.p(113)   b = 2;
 294 acc8= constant 2
 295 acc8=> variable 0
 296 ;test6.p(114)   c = b * 19;
 297 acc8= variable 0
 298 acc8* constant 19
 299 acc8=> variable 1
 300 ;test6.p(115)   write(c);         // 38
 301 acc8= variable 1
 302 call writeAcc8
 303 ;test6.p(116)   b = 3;
 304 acc8= constant 3
 305 acc8=> variable 0
 306 ;test6.p(117)   c = 13 * b;
 307 acc8= constant 13
 308 acc8* variable 0
 309 acc8=> variable 1
 310 ;test6.p(118)   write(c);         // 39
 311 acc8= variable 1
 312 call writeAcc8
 313 ;test6.p(119)   b = 5;
 314 acc8= constant 5
 315 acc8=> variable 0
 316 ;test6.p(120)   c = 8;
 317 acc8= constant 8
 318 acc8=> variable 1
 319 ;test6.p(121)   c = b * c;
 320 acc8= variable 0
 321 acc8* variable 1
 322 acc8=> variable 1
 323 ;test6.p(122)   write(c);         // 40
 324 acc8= variable 1
 325 call writeAcc8
 326 ;test6.p(123) 
 327 ;test6.p(124)   /**********************/
 328 ;test6.p(125)   /* Dual term division */
 329 ;test6.p(126)   /**********************/
 330 ;test6.p(127)   write(123 / 3);   // 41
 331 acc8= constant 123
 332 acc8/ constant 3
 333 call writeAcc8
 334 ;test6.p(128)   b = 126;
 335 acc8= constant 126
 336 acc8=> variable 0
 337 ;test6.p(129)   write(b / 3);     // 42
 338 acc8= variable 0
 339 acc8/ constant 3
 340 call writeAcc8
 341 ;test6.p(130)   b = 3;
 342 acc8= constant 3
 343 acc8=> variable 0
 344 ;test6.p(131)   write(129 / b);   // 43
 345 acc8= constant 129
 346 acc8/ variable 0
 347 call writeAcc8
 348 ;test6.p(132)   b = 132;
 349 acc8= constant 132
 350 acc8=> variable 0
 351 ;test6.p(133)   c = 3;
 352 acc8= constant 3
 353 acc8=> variable 1
 354 ;test6.p(134)   write(b / c);     // 44
 355 acc8= variable 0
 356 acc8/ variable 1
 357 call writeAcc8
 358 ;test6.p(135)   
 359 ;test6.p(136)   c = 135 / 3;
 360 acc8= constant 135
 361 acc8/ constant 3
 362 acc8=> variable 1
 363 ;test6.p(137)   write(c);         // 45
 364 acc8= variable 1
 365 call writeAcc8
 366 ;test6.p(138)   b = 138;
 367 acc8= constant 138
 368 acc8=> variable 0
 369 ;test6.p(139)   c = b / 3;
 370 acc8= variable 0
 371 acc8/ constant 3
 372 acc8=> variable 1
 373 ;test6.p(140)   write(c);         // 46
 374 acc8= variable 1
 375 call writeAcc8
 376 ;test6.p(141)   b = 3;
 377 acc8= constant 3
 378 acc8=> variable 0
 379 ;test6.p(142)   c = 141 / b;
 380 acc8= constant 141
 381 acc8/ variable 0
 382 acc8=> variable 1
 383 ;test6.p(143)   write(c);         // 47
 384 acc8= variable 1
 385 call writeAcc8
 386 ;test6.p(144)   b = 144;
 387 acc8= constant 144
 388 acc8=> variable 0
 389 ;test6.p(145)   c = 3;
 390 acc8= constant 3
 391 acc8=> variable 1
 392 ;test6.p(146)   c = b / c;
 393 acc8= variable 0
 394 acc8/ variable 1
 395 acc8=> variable 1
 396 ;test6.p(147)   write(c);         // 48
 397 acc8= variable 1
 398 call writeAcc8
 399 ;test6.p(148) 
 400 ;test6.p(149)   /*************************/
 401 ;test6.p(150)   /* possible loss of data */
 402 ;test6.p(151)   /*************************/
 403 ;test6.p(152)   b = 507;
 404 acc16= constant 507
 405 acc16=> variable 0
 406 ;test6.p(153)   write(b);         // 251
 407 acc8= variable 0
 408 call writeAcc8
 409 ;test6.p(154)   i = 508;
 410 acc16= constant 508
 411 acc16=> variable 2
 412 ;test6.p(155)   b = i;
 413 acc16= variable 2
 414 acc16=> variable 0
 415 ;test6.p(156)   write(b);         // 252
 416 acc8= variable 0
 417 call writeAcc8
 418 ;test6.p(157) 
 419 ;test6.p(158)   b = b - 505;
 420 acc8= variable 0
 421 acc8ToAcc16
 422 acc16- constant 505
 423 acc16=> variable 0
 424 ;test6.p(159)   write(b);         // 252 - 505 = -253
 425 acc8= variable 0
 426 call writeAcc8
 427 ;test6.p(160)   i = i + 5;
 428 acc16= variable 2
 429 acc16+ constant 5
 430 acc16=> variable 2
 431 ;test6.p(161)   b = b - i;
 432 acc8= variable 0
 433 acc8ToAcc16
 434 acc16- variable 2
 435 acc16=> variable 0
 436 ;test6.p(162)   write(b);         // -233 - 11 = -254
 437 acc8= variable 0
 438 call writeAcc8
 439 ;test6.p(163)   
 440 ;test6.p(164)   b = 255;
 441 acc8= constant 255
 442 acc8=> variable 0
 443 ;test6.p(165)   write(b);         // 255
 444 acc8= variable 0
 445 call writeAcc8
 446 ;test6.p(166)   //LD    A,255
 447 ;test6.p(167)   //LD    (04001H),A
 448 ;test6.p(168)   //LD    A,(04001H)
 449 ;test6.p(169)   //CALL  writeA
 450 ;test6.p(170)   //OK
 451 ;test6.p(171) 
 452 ;test6.p(172)   /**********************/
 453 ;test6.p(173)   /* Single term 16-bit */
 454 ;test6.p(174)   /**********************/
 455 ;test6.p(175)   i = 256;
 456 acc16= constant 256
 457 acc16=> variable 2
 458 ;test6.p(176)   write(i);         // 256
 459 acc16= variable 2
 460 call writeAcc16
 461 ;test6.p(177)   //LD    HL,256
 462 ;test6.p(178)   //LD    (04006H),HL
 463 ;test6.p(179)   //LD    HL,(04006H)
 464 ;test6.p(180)   //CALL  writeHL
 465 ;test6.p(181)   //OK
 466 ;test6.p(182) 
 467 ;test6.p(183)   write(1000);      // 1000
 468 acc16= constant 1000
 469 call writeAcc16
 470 ;test6.p(184)   j = 1001;
 471 acc16= constant 1001
 472 acc16=> variable 4
 473 ;test6.p(185)   write(j);         // 1001
 474 acc16= variable 4
 475 call writeAcc16
 476 ;test6.p(186) 
 477 ;test6.p(187)   /************************/
 478 ;test6.p(188)   /* Dual term addition   */
 479 ;test6.p(189)   /************************/
 480 ;test6.p(190)   write(1000 + 2);  // 1002
 481 acc16= constant 1000
 482 acc16+ constant 2
 483 call writeAcc16
 484 ;test6.p(191)   write(3 + 1000);  // 1003
 485 acc8= constant 3
 486 acc8ToAcc16
 487 acc16+ constant 1000
 488 call writeAcc16
 489 ;test6.p(192)   write(500 + 504); // 1004
 490 acc16= constant 500
 491 acc16+ constant 504
 492 call writeAcc16
 493 ;test6.p(193)   i = 1000 + 5;
 494 acc16= constant 1000
 495 acc16+ constant 5
 496 acc16=> variable 2
 497 ;test6.p(194)   write(i);         // 1005
 498 acc16= variable 2
 499 call writeAcc16
 500 ;test6.p(195)   i = 6 + 1000;
 501 acc8= constant 6
 502 acc8ToAcc16
 503 acc16+ constant 1000
 504 acc16=> variable 2
 505 ;test6.p(196)   write(i);         // 1006
 506 acc16= variable 2
 507 call writeAcc16
 508 ;test6.p(197)   i = 500 + 507;
 509 acc16= constant 500
 510 acc16+ constant 507
 511 acc16=> variable 2
 512 ;test6.p(198)   write(i);         // 1007
 513 acc16= variable 2
 514 call writeAcc16
 515 ;test6.p(199)   
 516 ;test6.p(200)   j = 1000;
 517 acc16= constant 1000
 518 acc16=> variable 4
 519 ;test6.p(201)   b = 10;
 520 acc8= constant 10
 521 acc8=> variable 0
 522 ;test6.p(202)   i = 514;
 523 acc16= constant 514
 524 acc16=> variable 2
 525 ;test6.p(203)   write(j + 8);     // 1008
 526 acc16= variable 4
 527 acc16+ constant 8
 528 call writeAcc16
 529 ;test6.p(204)   write(9 + j);     // 1009
 530 acc8= constant 9
 531 acc8ToAcc16
 532 acc16+ variable 4
 533 call writeAcc16
 534 ;test6.p(205)   write(j + b);     // 1010
 535 acc16= variable 4
 536 acc16+ variable 0
 537 call writeAcc16
 538 ;test6.p(206)   b++;
 539 incr8 variable 0
 540 ;test6.p(207)   write(b + j);     // 1011
 541 acc8= variable 0
 542 acc8ToAcc16
 543 acc16+ variable 4
 544 call writeAcc16
 545 ;test6.p(208)   j = 500;
 546 acc16= constant 500
 547 acc16=> variable 4
 548 ;test6.p(209)   write(j + 512);   // 1012
 549 acc16= variable 4
 550 acc16+ constant 512
 551 call writeAcc16
 552 ;test6.p(210)   write(513 + j);   // 1013
 553 acc16= constant 513
 554 acc16+ variable 4
 555 call writeAcc16
 556 ;test6.p(211)   write(i + j);     // 1014
 557 acc16= variable 2
 558 acc16+ variable 4
 559 call writeAcc16
 560 ;test6.p(212)   
 561 ;test6.p(213)   j = 1000;
 562 acc16= constant 1000
 563 acc16=> variable 4
 564 ;test6.p(214)   b = 17;
 565 acc8= constant 17
 566 acc8=> variable 0
 567 ;test6.p(215)   i = j + 15;
 568 acc16= variable 4
 569 acc16+ constant 15
 570 acc16=> variable 2
 571 ;test6.p(216)   write(i);         // 1015
 572 acc16= variable 2
 573 call writeAcc16
 574 ;test6.p(217)   i = 16 + j;
 575 acc8= constant 16
 576 acc8ToAcc16
 577 acc16+ variable 4
 578 acc16=> variable 2
 579 ;test6.p(218)   write(i);         // 1016
 580 acc16= variable 2
 581 call writeAcc16
 582 ;test6.p(219)   i = j + b;
 583 acc16= variable 4
 584 acc16+ variable 0
 585 acc16=> variable 2
 586 ;test6.p(220)   write(i);         // 1017
 587 acc16= variable 2
 588 call writeAcc16
 589 ;test6.p(221)   b++;
 590 incr8 variable 0
 591 ;test6.p(222)   i = b + j;
 592 acc8= variable 0
 593 acc8ToAcc16
 594 acc16+ variable 4
 595 acc16=> variable 2
 596 ;test6.p(223)   write(i);         // 1018
 597 acc16= variable 2
 598 call writeAcc16
 599 ;test6.p(224)   j = 500;
 600 acc16= constant 500
 601 acc16=> variable 4
 602 ;test6.p(225)   i = j + 519;
 603 acc16= variable 4
 604 acc16+ constant 519
 605 acc16=> variable 2
 606 ;test6.p(226)   write(i);         // 1019
 607 acc16= variable 2
 608 call writeAcc16
 609 ;test6.p(227)   i = 520 + j;
 610 acc16= constant 520
 611 acc16+ variable 4
 612 acc16=> variable 2
 613 ;test6.p(228)   write(i);         // 1020
 614 acc16= variable 2
 615 call writeAcc16
 616 ;test6.p(229)   i = 521;
 617 acc16= constant 521
 618 acc16=> variable 2
 619 ;test6.p(230)   i = i + j;
 620 acc16= variable 2
 621 acc16+ variable 4
 622 acc16=> variable 2
 623 ;test6.p(231)   write(i);         // 1021
 624 acc16= variable 2
 625 call writeAcc16
 626 ;test6.p(232)   
 627 ;test6.p(233)   /*************************/
 628 ;test6.p(234)   /* Dual term subtraction */
 629 ;test6.p(235)   /*************************/
 630 ;test6.p(236)   write(1024 - 2);  // 1022
 631 acc16= constant 1024
 632 acc16- constant 2
 633 call writeAcc16
 634 ;test6.p(237)   write(1523 - 500);// 1023
 635 acc16= constant 1523
 636 acc16- constant 500
 637 call writeAcc16
 638 ;test6.p(238)   i = 1030 - 6;
 639 acc16= constant 1030
 640 acc16- constant 6
 641 acc16=> variable 2
 642 ;test6.p(239)   write(i);         // 1024
 643 acc16= variable 2
 644 call writeAcc16
 645 ;test6.p(240)   i = 1525 - 500;
 646 acc16= constant 1525
 647 acc16- constant 500
 648 acc16=> variable 2
 649 ;test6.p(241)   write(i);         // 1025
 650 acc16= variable 2
 651 call writeAcc16
 652 ;test6.p(242)   
 653 ;test6.p(243)   j = 1040;
 654 acc16= constant 1040
 655 acc16=> variable 4
 656 ;test6.p(244)   b = 13;
 657 acc8= constant 13
 658 acc8=> variable 0
 659 ;test6.p(245)   i = 3030;
 660 acc16= constant 3030
 661 acc16=> variable 2
 662 ;test6.p(246)   write(j - 14);    // 1026
 663 acc16= variable 4
 664 acc16- constant 14
 665 call writeAcc16
 666 ;test6.p(247)   write(j - b);     // 1027
 667 acc16= variable 4
 668 acc16- variable 0
 669 call writeAcc16
 670 ;test6.p(248)   j = 2000;
 671 acc16= constant 2000
 672 acc16=> variable 4
 673 ;test6.p(249)   write(j - 972);   // 1028
 674 acc16= variable 4
 675 acc16- constant 972
 676 call writeAcc16
 677 ;test6.p(250)   write(3029 - j);  // 1029
 678 acc16= constant 3029
 679 acc16- variable 4
 680 call writeAcc16
 681 ;test6.p(251)   write(i - j);     // 1030
 682 acc16= variable 2
 683 acc16- variable 4
 684 call writeAcc16
 685 ;test6.p(252)   
 686 ;test6.p(253)   j = 1050;
 687 acc16= constant 1050
 688 acc16=> variable 4
 689 ;test6.p(254)   b = 18;
 690 acc8= constant 18
 691 acc8=> variable 0
 692 ;test6.p(255)   i = j - 19;
 693 acc16= variable 4
 694 acc16- constant 19
 695 acc16=> variable 2
 696 ;test6.p(256)   write(i);         // 1031
 697 acc16= variable 2
 698 call writeAcc16
 699 ;test6.p(257)   i = j - b;
 700 acc16= variable 4
 701 acc16- variable 0
 702 acc16=> variable 2
 703 ;test6.p(258)   write(i);         // 1032
 704 acc16= variable 2
 705 call writeAcc16
 706 ;test6.p(259)   j = 2000;
 707 acc16= constant 2000
 708 acc16=> variable 4
 709 ;test6.p(260)   i = j - 967;
 710 acc16= variable 4
 711 acc16- constant 967
 712 acc16=> variable 2
 713 ;test6.p(261)   write(i);         // 1033
 714 acc16= variable 2
 715 call writeAcc16
 716 ;test6.p(262)   i = 3034 - j;
 717 acc16= constant 3034
 718 acc16- variable 4
 719 acc16=> variable 2
 720 ;test6.p(263)   write(i);         // 1034
 721 acc16= variable 2
 722 call writeAcc16
 723 ;test6.p(264)   i = 3035;
 724 acc16= constant 3035
 725 acc16=> variable 2
 726 ;test6.p(265)   i = i - j;
 727 acc16= variable 2
 728 acc16- variable 4
 729 acc16=> variable 2
 730 ;test6.p(266)   write(i);         // 1035
 731 acc16= variable 2
 732 call writeAcc16
 733 ;test6.p(267)   
 734 ;test6.p(268)   /****************************/
 735 ;test6.p(269)   /* Dual term multiplication */
 736 ;test6.p(270)   /****************************/
 737 ;test6.p(271)   write(518 * 2);   // 1036
 738 acc16= constant 518
 739 acc16* constant 2
 740 call writeAcc16
 741 ;test6.p(272)   write(1 * 1037);  // 1037
 742 acc8= constant 1
 743 acc8ToAcc16
 744 acc16* constant 1037
 745 call writeAcc16
 746 ;test6.p(273)   write(500 * 504 - 54354); // 1038 = 55392 - 54354
 747 acc16= constant 500
 748 acc16* constant 504
 749 acc16- constant 54354
 750 call writeAcc16
 751 ;test6.p(274) 
 752 ;test6.p(275)   i = 1039 * 1;
 753 acc16= constant 1039
 754 acc16* constant 1
 755 acc16=> variable 2
 756 ;test6.p(276)   write(i);         // 1039
 757 acc16= variable 2
 758 call writeAcc16
 759 ;test6.p(277)   i = 2 * 520;
 760 acc8= constant 2
 761 acc8ToAcc16
 762 acc16* constant 520
 763 acc16=> variable 2
 764 ;test6.p(278)   write(i);         // 1040
 765 acc16= variable 2
 766 call writeAcc16
 767 ;test6.p(279) 
 768 ;test6.p(280)   i = 1041;
 769 acc16= constant 1041
 770 acc16=> variable 2
 771 ;test6.p(281)   write(i * 1);     // 1041
 772 acc16= variable 2
 773 acc16* constant 1
 774 call writeAcc16
 775 ;test6.p(282)   i = 521;
 776 acc16= constant 521
 777 acc16=> variable 2
 778 ;test6.p(283)   write(2 * i);     // 1042
 779 acc8= constant 2
 780 acc8ToAcc16
 781 acc16* variable 2
 782 call writeAcc16
 783 ;test6.p(284) 
 784 ;test6.p(285)   i = 1043;
 785 acc16= constant 1043
 786 acc16=> variable 2
 787 ;test6.p(286)   i = i * 1;
 788 acc16= variable 2
 789 acc16* constant 1
 790 acc16=> variable 2
 791 ;test6.p(287)   write(i);         // 1043
 792 acc16= variable 2
 793 call writeAcc16
 794 ;test6.p(288)   i = 522;
 795 acc16= constant 522
 796 acc16=> variable 2
 797 ;test6.p(289)   i = 2 * i;
 798 acc8= constant 2
 799 acc8ToAcc16
 800 acc16* variable 2
 801 acc16=> variable 2
 802 ;test6.p(290)   write(i);         // 1044
 803 acc16= variable 2
 804 call writeAcc16
 805 ;test6.p(291) 
 806 ;test6.p(292)   i = 500 * 504 - 54347; // 1045 = 55392 - 54347
 807 acc16= constant 500
 808 acc16* constant 504
 809 acc16- constant 54347
 810 acc16=> variable 2
 811 ;test6.p(293)   write(i);         // 1045
 812 acc16= variable 2
 813 call writeAcc16
 814 ;test6.p(294)   i = 500;
 815 acc16= constant 500
 816 acc16=> variable 2
 817 ;test6.p(295)   i = i * 504 - 54346;
 818 acc16= variable 2
 819 acc16* constant 504
 820 acc16- constant 54346
 821 acc16=> variable 2
 822 ;test6.p(296)   write(i);         // 1046
 823 acc16= variable 2
 824 call writeAcc16
 825 ;test6.p(297)   i = 504;
 826 acc16= constant 504
 827 acc16=> variable 2
 828 ;test6.p(298)   i = 500 * i - 54345;
 829 acc16= constant 500
 830 acc16* variable 2
 831 acc16- constant 54345
 832 acc16=> variable 2
 833 ;test6.p(299)   write(i);         // 1047
 834 acc16= variable 2
 835 call writeAcc16
 836 ;test6.p(300)   
 837 ;test6.p(301)   /************/
 838 ;test6.p(302)   /* Overflow */
 839 ;test6.p(303)   /************/
 840 ;test6.p(304)   write(300 * 301); // 90.300 % 65536 = 24.764
 841 acc16= constant 300
 842 acc16* constant 301
 843 call writeAcc16
 844 ;test6.p(305)   i = 300 * 302;
 845 acc16= constant 300
 846 acc16* constant 302
 847 acc16=> variable 2
 848 ;test6.p(306)   write(i);         // 90.600 % 65536 = 25.064
 849 acc16= variable 2
 850 call writeAcc16
 851 ;test6.p(307) 
 852 ;test6.p(308) }
 853 stop
