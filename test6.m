   0 ;test6.j(0) /*
   1 ;test6.j(1)  * A small program in the miniJava language.
   2 ;test6.j(2)  * Test 8-bit and 16-bit expressions.
   3 ;test6.j(3)  */
   4 ;test6.j(4) class Test8And16BitExpressions {
   5 ;test6.j(5)   println(0);         // 0
   6 acc8= constant 0
   7 call writeLineAcc8
   8 ;test6.j(6)   //LD    A,0
   9 ;test6.j(7)   //CALL  writeA
  10 ;test6.j(8)   //OK
  11 ;test6.j(9) 
  12 ;test6.j(10)   /*********************/
  13 ;test6.j(11)   /* Single term 8-bit */
  14 ;test6.j(12)   /*********************/
  15 ;test6.j(13)   byte b = 1;
  16 acc8= constant 1
  17 acc8=> variable 0
  18 ;test6.j(14)   byte c = 4;
  19 acc8= constant 4
  20 acc8=> variable 1
  21 ;test6.j(15)   println(b);         // 1
  22 acc8= variable 0
  23 call writeLineAcc8
  24 ;test6.j(16)   //LD    A,1
  25 ;test6.j(17)   //LD    (04000H),A
  26 ;test6.j(18)   //LD    A,(04000H)
  27 ;test6.j(19)   //CALL  writeA
  28 ;test6.j(20)   //OK
  29 ;test6.j(21) 
  30 ;test6.j(22)   /************************/
  31 ;test6.j(23)   /* Dual term addition   */
  32 ;test6.j(24)   /************************/
  33 ;test6.j(25)   println(0 + 2);     // 2
  34 acc8= constant 0
  35 acc8+ constant 2
  36 call writeLineAcc8
  37 ;test6.j(26)   println(b + 2);     // 3
  38 acc8= variable 0
  39 acc8+ constant 2
  40 call writeLineAcc8
  41 ;test6.j(27)   println(3 + b);     // 4
  42 acc8= constant 3
  43 acc8+ variable 0
  44 call writeLineAcc8
  45 ;test6.j(28)   println(b + c);     // 5
  46 acc8= variable 0
  47 acc8+ variable 1
  48 call writeLineAcc8
  49 ;test6.j(29) 
  50 ;test6.j(30)   c = 4 + 2;
  51 acc8= constant 4
  52 acc8+ constant 2
  53 acc8=> variable 1
  54 ;test6.j(31)   println(c);         // 6
  55 acc8= variable 1
  56 call writeLineAcc8
  57 ;test6.j(32)   c = b + 6;
  58 acc8= variable 0
  59 acc8+ constant 6
  60 acc8=> variable 1
  61 ;test6.j(33)   println(c);         // 7
  62 acc8= variable 1
  63 call writeLineAcc8
  64 ;test6.j(34)   c = 7 + b;
  65 acc8= constant 7
  66 acc8+ variable 0
  67 acc8=> variable 1
  68 ;test6.j(35)   println(c);         // 8
  69 acc8= variable 1
  70 call writeLineAcc8
  71 ;test6.j(36)   c = b + c;
  72 acc8= variable 0
  73 acc8+ variable 1
  74 acc8=> variable 1
  75 ;test6.j(37)   println(c);         // 9
  76 acc8= variable 1
  77 call writeLineAcc8
  78 ;test6.j(38) 
  79 ;test6.j(39) 
  80 ;test6.j(40)   word i = 10;
  81 acc8= constant 10
  82 acc8=> variable 2
  83 ;test6.j(41)   println(i);         // 10
  84 acc16= variable 2
  85 call writeLineAcc16
  86 ;test6.j(42)   //LD    A,10
  87 ;test6.j(43)   //LD    L,A
  88 ;test6.j(44)   //LD    H,0
  89 ;test6.j(45)   //LD    (04004H),HL
  90 ;test6.j(46)   //OK
  91 ;test6.j(47)   
  92 ;test6.j(48)   println(i + 1);     // 11
  93 acc16= variable 2
  94 acc16+ constant 1
  95 call writeLineAcc16
  96 ;test6.j(49)   println(2 + i);     // 12
  97 acc8= constant 2
  98 acc8ToAcc16
  99 acc16+ variable 2
 100 call writeLineAcc16
 101 ;test6.j(50)   b = 3;
 102 acc8= constant 3
 103 acc8=> variable 0
 104 ;test6.j(51)   println(i + b);     // 13
 105 acc16= variable 2
 106 acc16+ variable 0
 107 call writeLineAcc16
 108 ;test6.j(52)   b++; //4
 109 incr8 variable 0
 110 ;test6.j(53)   println(b + i);     // 14
 111 acc8= variable 0
 112 acc8ToAcc16
 113 acc16+ variable 2
 114 call writeLineAcc16
 115 ;test6.j(54) 
 116 ;test6.j(55)   word j = i + 5;    // 15
 117 acc16= variable 2
 118 acc16+ constant 5
 119 acc16=> variable 4
 120 ;test6.j(56)   println(j);
 121 acc16= variable 4
 122 call writeLineAcc16
 123 ;test6.j(57)   j = 6 + i;        // 16
 124 acc8= constant 6
 125 acc8ToAcc16
 126 acc16+ variable 2
 127 acc16=> variable 4
 128 ;test6.j(58)   println(j);
 129 acc16= variable 4
 130 call writeLineAcc16
 131 ;test6.j(59)   j = 7;
 132 acc8= constant 7
 133 acc8=> variable 4
 134 ;test6.j(60)   j = i + j;        // 17
 135 acc16= variable 2
 136 acc16+ variable 4
 137 acc16=> variable 4
 138 ;test6.j(61)   println(j);
 139 acc16= variable 4
 140 call writeLineAcc16
 141 ;test6.j(62) 
 142 ;test6.j(63)   /*************************/
 143 ;test6.j(64)   /* Dual term subtraction */
 144 ;test6.j(65)   /*************************/
 145 ;test6.j(66)   b = 33;
 146 acc8= constant 33
 147 acc8=> variable 0
 148 ;test6.j(67)   c = 12;
 149 acc8= constant 12
 150 acc8=> variable 1
 151 ;test6.j(68)   println(19 - 1);    // 18
 152 acc8= constant 19
 153 acc8- constant 1
 154 call writeLineAcc8
 155 ;test6.j(69)   println(b - 14);    // 19
 156 acc8= variable 0
 157 acc8- constant 14
 158 call writeLineAcc8
 159 ;test6.j(70)   println(53 - b);    // 20
 160 acc8= constant 53
 161 acc8- variable 0
 162 call writeLineAcc8
 163 ;test6.j(71)   println(b - c);     // 21
 164 acc8= variable 0
 165 acc8- variable 1
 166 call writeLineAcc8
 167 ;test6.j(72) 
 168 ;test6.j(73)   c = 24 - 2;
 169 acc8= constant 24
 170 acc8- constant 2
 171 acc8=> variable 1
 172 ;test6.j(74)   println(c);         // 22
 173 acc8= variable 1
 174 call writeLineAcc8
 175 ;test6.j(75)   c = b - 10;
 176 acc8= variable 0
 177 acc8- constant 10
 178 acc8=> variable 1
 179 ;test6.j(76)   println(c);         // 23
 180 acc8= variable 1
 181 call writeLineAcc8
 182 ;test6.j(77)   c = 57 - b;
 183 acc8= constant 57
 184 acc8- variable 0
 185 acc8=> variable 1
 186 ;test6.j(78)   println(c);         // 24
 187 acc8= variable 1
 188 call writeLineAcc8
 189 ;test6.j(79)   c = 8;
 190 acc8= constant 8
 191 acc8=> variable 1
 192 ;test6.j(80)   c = b - c;
 193 acc8= variable 0
 194 acc8- variable 1
 195 acc8=> variable 1
 196 ;test6.j(81)   println(c);         // 25
 197 acc8= variable 1
 198 call writeLineAcc8
 199 ;test6.j(82) 
 200 ;test6.j(83)   i = 40;
 201 acc8= constant 40
 202 acc8=> variable 2
 203 ;test6.j(84)   println(i - 14);    // 26
 204 acc16= variable 2
 205 acc16- constant 14
 206 call writeLineAcc16
 207 ;test6.j(85)   println(67 - i);    // 27
 208 acc8= constant 67
 209 acc8ToAcc16
 210 acc16- variable 2
 211 call writeLineAcc16
 212 ;test6.j(86)   b = 12;
 213 acc8= constant 12
 214 acc8=> variable 0
 215 ;test6.j(87)   println(i - b);     // 28
 216 acc16= variable 2
 217 acc16- variable 0
 218 call writeLineAcc16
 219 ;test6.j(88)   b = 69;
 220 acc8= constant 69
 221 acc8=> variable 0
 222 ;test6.j(89)   println(b - i);     // 29
 223 acc8= variable 0
 224 acc8ToAcc16
 225 acc16- variable 2
 226 call writeLineAcc16
 227 ;test6.j(90) 
 228 ;test6.j(91)   j = i - 10;
 229 acc16= variable 2
 230 acc16- constant 10
 231 acc16=> variable 4
 232 ;test6.j(92)   println(j);         // 30
 233 acc16= variable 4
 234 call writeLineAcc16
 235 ;test6.j(93)   j = 71 - i;
 236 acc8= constant 71
 237 acc8ToAcc16
 238 acc16- variable 2
 239 acc16=> variable 4
 240 ;test6.j(94)   println(j);         // 31
 241 acc16= variable 4
 242 call writeLineAcc16
 243 ;test6.j(95)   j = 8;
 244 acc8= constant 8
 245 acc8=> variable 4
 246 ;test6.j(96)   j = i - j;
 247 acc16= variable 2
 248 acc16- variable 4
 249 acc16=> variable 4
 250 ;test6.j(97)   println(j);         // 32
 251 acc16= variable 4
 252 call writeLineAcc16
 253 ;test6.j(98)   
 254 ;test6.j(99)   /****************************/
 255 ;test6.j(100)   /* Dual term multiplication */
 256 ;test6.j(101)   /****************************/
 257 ;test6.j(102)   println(3 * 11);    // 33
 258 acc8= constant 3
 259 acc8* constant 11
 260 call writeLineAcc8
 261 ;test6.j(103)   b = 17;
 262 acc8= constant 17
 263 acc8=> variable 0
 264 ;test6.j(104)   println(b * 2);     // 34
 265 acc8= variable 0
 266 acc8* constant 2
 267 call writeLineAcc8
 268 ;test6.j(105)   b = 7;
 269 acc8= constant 7
 270 acc8=> variable 0
 271 ;test6.j(106)   println(5 * b);     // 35
 272 acc8= constant 5
 273 acc8* variable 0
 274 call writeLineAcc8
 275 ;test6.j(107)   b = 2;
 276 acc8= constant 2
 277 acc8=> variable 0
 278 ;test6.j(108)   c = 18;
 279 acc8= constant 18
 280 acc8=> variable 1
 281 ;test6.j(109)   println(b * c);     // 36
 282 acc8= variable 0
 283 acc8* variable 1
 284 call writeLineAcc8
 285 ;test6.j(110)   
 286 ;test6.j(111)   c = 37 * 1;
 287 acc8= constant 37
 288 acc8* constant 1
 289 acc8=> variable 1
 290 ;test6.j(112)   println(c);         // 37
 291 acc8= variable 1
 292 call writeLineAcc8
 293 ;test6.j(113)   b = 2;
 294 acc8= constant 2
 295 acc8=> variable 0
 296 ;test6.j(114)   c = b * 19;
 297 acc8= variable 0
 298 acc8* constant 19
 299 acc8=> variable 1
 300 ;test6.j(115)   println(c);         // 38
 301 acc8= variable 1
 302 call writeLineAcc8
 303 ;test6.j(116)   b = 3;
 304 acc8= constant 3
 305 acc8=> variable 0
 306 ;test6.j(117)   c = 13 * b;
 307 acc8= constant 13
 308 acc8* variable 0
 309 acc8=> variable 1
 310 ;test6.j(118)   println(c);         // 39
 311 acc8= variable 1
 312 call writeLineAcc8
 313 ;test6.j(119)   b = 5;
 314 acc8= constant 5
 315 acc8=> variable 0
 316 ;test6.j(120)   c = 8;
 317 acc8= constant 8
 318 acc8=> variable 1
 319 ;test6.j(121)   c = b * c;
 320 acc8= variable 0
 321 acc8* variable 1
 322 acc8=> variable 1
 323 ;test6.j(122)   println(c);         // 40
 324 acc8= variable 1
 325 call writeLineAcc8
 326 ;test6.j(123) 
 327 ;test6.j(124)   /**********************/
 328 ;test6.j(125)   /* Dual term division */
 329 ;test6.j(126)   /**********************/
 330 ;test6.j(127)   println(123 / 3);   // 41
 331 acc8= constant 123
 332 acc8/ constant 3
 333 call writeLineAcc8
 334 ;test6.j(128)   b = 126;
 335 acc8= constant 126
 336 acc8=> variable 0
 337 ;test6.j(129)   println(b / 3);     // 42
 338 acc8= variable 0
 339 acc8/ constant 3
 340 call writeLineAcc8
 341 ;test6.j(130)   b = 3;
 342 acc8= constant 3
 343 acc8=> variable 0
 344 ;test6.j(131)   println(129 / b);   // 43
 345 acc8= constant 129
 346 acc8/ variable 0
 347 call writeLineAcc8
 348 ;test6.j(132)   b = 132;
 349 acc8= constant 132
 350 acc8=> variable 0
 351 ;test6.j(133)   c = 3;
 352 acc8= constant 3
 353 acc8=> variable 1
 354 ;test6.j(134)   println(b / c);     // 44
 355 acc8= variable 0
 356 acc8/ variable 1
 357 call writeLineAcc8
 358 ;test6.j(135)   
 359 ;test6.j(136)   c = 135 / 3;
 360 acc8= constant 135
 361 acc8/ constant 3
 362 acc8=> variable 1
 363 ;test6.j(137)   println(c);         // 45
 364 acc8= variable 1
 365 call writeLineAcc8
 366 ;test6.j(138)   b = 138;
 367 acc8= constant 138
 368 acc8=> variable 0
 369 ;test6.j(139)   c = b / 3;
 370 acc8= variable 0
 371 acc8/ constant 3
 372 acc8=> variable 1
 373 ;test6.j(140)   println(c);         // 46
 374 acc8= variable 1
 375 call writeLineAcc8
 376 ;test6.j(141)   b = 3;
 377 acc8= constant 3
 378 acc8=> variable 0
 379 ;test6.j(142)   c = 141 / b;
 380 acc8= constant 141
 381 acc8/ variable 0
 382 acc8=> variable 1
 383 ;test6.j(143)   println(c);         // 47
 384 acc8= variable 1
 385 call writeLineAcc8
 386 ;test6.j(144)   b = 144;
 387 acc8= constant 144
 388 acc8=> variable 0
 389 ;test6.j(145)   c = 3;
 390 acc8= constant 3
 391 acc8=> variable 1
 392 ;test6.j(146)   c = b / c;
 393 acc8= variable 0
 394 acc8/ variable 1
 395 acc8=> variable 1
 396 ;test6.j(147)   println(c);         // 48
 397 acc8= variable 1
 398 call writeLineAcc8
 399 ;test6.j(148) 
 400 ;test6.j(149)   /*************************/
 401 ;test6.j(150)   /* possible loss of data */
 402 ;test6.j(151)   /*************************/
 403 ;test6.j(152)   println("Nu komen 251 en 252");
 404 acc16= constant 891
 405 writeLineString
 406 ;test6.j(153)   b = 507;
 407 acc16= constant 507
 408 acc16=> variable 0
 409 ;test6.j(154)   println(b);         // 251
 410 acc8= variable 0
 411 call writeLineAcc8
 412 ;test6.j(155)   i = 508;
 413 acc16= constant 508
 414 acc16=> variable 2
 415 ;test6.j(156)   b = i;
 416 acc16= variable 2
 417 acc16=> variable 0
 418 ;test6.j(157)   println(b);         // 252
 419 acc8= variable 0
 420 call writeLineAcc8
 421 ;test6.j(158) 
 422 ;test6.j(159)   println("Nu komen -253 en -254");
 423 acc16= constant 892
 424 writeLineString
 425 ;test6.j(160)   b = b - 505;
 426 acc8= variable 0
 427 acc8ToAcc16
 428 acc16- constant 505
 429 acc16=> variable 0
 430 ;test6.j(161)   println(b);         // 252 - 505 = -253
 431 acc8= variable 0
 432 call writeLineAcc8
 433 ;test6.j(162)   i = i + 5;
 434 acc16= variable 2
 435 acc16+ constant 5
 436 acc16=> variable 2
 437 ;test6.j(163)   b = b - i;
 438 acc8= variable 0
 439 acc8ToAcc16
 440 acc16- variable 2
 441 acc16=> variable 0
 442 ;test6.j(164)   println(b);         // -233 - 11 = -254
 443 acc8= variable 0
 444 call writeLineAcc8
 445 ;test6.j(165)   
 446 ;test6.j(166)   println("Nu komen 255 en 256");
 447 acc16= constant 893
 448 writeLineString
 449 ;test6.j(167)   b = 255;
 450 acc8= constant 255
 451 acc8=> variable 0
 452 ;test6.j(168)   println(b);         // 255
 453 acc8= variable 0
 454 call writeLineAcc8
 455 ;test6.j(169)   //LD    A,255
 456 ;test6.j(170)   //LD    (04001H),A
 457 ;test6.j(171)   //LD    A,(04001H)
 458 ;test6.j(172)   //CALL  writeA
 459 ;test6.j(173)   //OK
 460 ;test6.j(174) 
 461 ;test6.j(175)   /**********************/
 462 ;test6.j(176)   /* Single term 16-bit */
 463 ;test6.j(177)   /**********************/
 464 ;test6.j(178)   i = 256;
 465 acc16= constant 256
 466 acc16=> variable 2
 467 ;test6.j(179)   println(i);         // 256
 468 acc16= variable 2
 469 call writeLineAcc16
 470 ;test6.j(180)   //LD    HL,256
 471 ;test6.j(181)   //LD    (04006H),HL
 472 ;test6.j(182)   //LD    HL,(04006H)
 473 ;test6.j(183)   //CALL  writeHL
 474 ;test6.j(184)   //OK
 475 ;test6.j(185) 
 476 ;test6.j(186)   println("Nu komen 1000..1047");
 477 acc16= constant 894
 478 writeLineString
 479 ;test6.j(187)   println(1000);      // 1000
 480 acc16= constant 1000
 481 call writeLineAcc16
 482 ;test6.j(188)   j = 1001;
 483 acc16= constant 1001
 484 acc16=> variable 4
 485 ;test6.j(189)   println(j);         // 1001
 486 acc16= variable 4
 487 call writeLineAcc16
 488 ;test6.j(190) 
 489 ;test6.j(191)   /************************/
 490 ;test6.j(192)   /* Dual term addition   */
 491 ;test6.j(193)   /************************/
 492 ;test6.j(194)   println(1000 + 2);  // 1002
 493 acc16= constant 1000
 494 acc16+ constant 2
 495 call writeLineAcc16
 496 ;test6.j(195)   println(3 + 1000);  // 1003
 497 acc8= constant 3
 498 acc8ToAcc16
 499 acc16+ constant 1000
 500 call writeLineAcc16
 501 ;test6.j(196)   println(500 + 504); // 1004
 502 acc16= constant 500
 503 acc16+ constant 504
 504 call writeLineAcc16
 505 ;test6.j(197)   i = 1000 + 5;
 506 acc16= constant 1000
 507 acc16+ constant 5
 508 acc16=> variable 2
 509 ;test6.j(198)   println(i);         // 1005
 510 acc16= variable 2
 511 call writeLineAcc16
 512 ;test6.j(199)   i = 6 + 1000;
 513 acc8= constant 6
 514 acc8ToAcc16
 515 acc16+ constant 1000
 516 acc16=> variable 2
 517 ;test6.j(200)   println(i);         // 1006
 518 acc16= variable 2
 519 call writeLineAcc16
 520 ;test6.j(201)   i = 500 + 507;
 521 acc16= constant 500
 522 acc16+ constant 507
 523 acc16=> variable 2
 524 ;test6.j(202)   println(i);         // 1007
 525 acc16= variable 2
 526 call writeLineAcc16
 527 ;test6.j(203)   
 528 ;test6.j(204)   j = 1000;
 529 acc16= constant 1000
 530 acc16=> variable 4
 531 ;test6.j(205)   b = 10;
 532 acc8= constant 10
 533 acc8=> variable 0
 534 ;test6.j(206)   i = 514;
 535 acc16= constant 514
 536 acc16=> variable 2
 537 ;test6.j(207)   println(j + 8);     // 1008
 538 acc16= variable 4
 539 acc16+ constant 8
 540 call writeLineAcc16
 541 ;test6.j(208)   println(9 + j);     // 1009
 542 acc8= constant 9
 543 acc8ToAcc16
 544 acc16+ variable 4
 545 call writeLineAcc16
 546 ;test6.j(209)   println(j + b);     // 1010
 547 acc16= variable 4
 548 acc16+ variable 0
 549 call writeLineAcc16
 550 ;test6.j(210)   b++;
 551 incr8 variable 0
 552 ;test6.j(211)   println(b + j);     // 1011
 553 acc8= variable 0
 554 acc8ToAcc16
 555 acc16+ variable 4
 556 call writeLineAcc16
 557 ;test6.j(212)   j = 500;
 558 acc16= constant 500
 559 acc16=> variable 4
 560 ;test6.j(213)   println(j + 512);   // 1012
 561 acc16= variable 4
 562 acc16+ constant 512
 563 call writeLineAcc16
 564 ;test6.j(214)   println(513 + j);   // 1013
 565 acc16= constant 513
 566 acc16+ variable 4
 567 call writeLineAcc16
 568 ;test6.j(215)   println(i + j);     // 1014
 569 acc16= variable 2
 570 acc16+ variable 4
 571 call writeLineAcc16
 572 ;test6.j(216)   
 573 ;test6.j(217)   j = 1000;
 574 acc16= constant 1000
 575 acc16=> variable 4
 576 ;test6.j(218)   b = 17;
 577 acc8= constant 17
 578 acc8=> variable 0
 579 ;test6.j(219)   i = j + 15;
 580 acc16= variable 4
 581 acc16+ constant 15
 582 acc16=> variable 2
 583 ;test6.j(220)   println(i);         // 1015
 584 acc16= variable 2
 585 call writeLineAcc16
 586 ;test6.j(221)   i = 16 + j;
 587 acc8= constant 16
 588 acc8ToAcc16
 589 acc16+ variable 4
 590 acc16=> variable 2
 591 ;test6.j(222)   println(i);         // 1016
 592 acc16= variable 2
 593 call writeLineAcc16
 594 ;test6.j(223)   i = j + b;
 595 acc16= variable 4
 596 acc16+ variable 0
 597 acc16=> variable 2
 598 ;test6.j(224)   println(i);         // 1017
 599 acc16= variable 2
 600 call writeLineAcc16
 601 ;test6.j(225)   b++;
 602 incr8 variable 0
 603 ;test6.j(226)   i = b + j;
 604 acc8= variable 0
 605 acc8ToAcc16
 606 acc16+ variable 4
 607 acc16=> variable 2
 608 ;test6.j(227)   println(i);         // 1018
 609 acc16= variable 2
 610 call writeLineAcc16
 611 ;test6.j(228)   j = 500;
 612 acc16= constant 500
 613 acc16=> variable 4
 614 ;test6.j(229)   i = j + 519;
 615 acc16= variable 4
 616 acc16+ constant 519
 617 acc16=> variable 2
 618 ;test6.j(230)   println(i);         // 1019
 619 acc16= variable 2
 620 call writeLineAcc16
 621 ;test6.j(231)   i = 520 + j;
 622 acc16= constant 520
 623 acc16+ variable 4
 624 acc16=> variable 2
 625 ;test6.j(232)   println(i);         // 1020
 626 acc16= variable 2
 627 call writeLineAcc16
 628 ;test6.j(233)   i = 521;
 629 acc16= constant 521
 630 acc16=> variable 2
 631 ;test6.j(234)   i = i + j;
 632 acc16= variable 2
 633 acc16+ variable 4
 634 acc16=> variable 2
 635 ;test6.j(235)   println(i);         // 1021
 636 acc16= variable 2
 637 call writeLineAcc16
 638 ;test6.j(236)   
 639 ;test6.j(237)   /*************************/
 640 ;test6.j(238)   /* Dual term subtraction */
 641 ;test6.j(239)   /*************************/
 642 ;test6.j(240)   println(1024 - 2);  // 1022
 643 acc16= constant 1024
 644 acc16- constant 2
 645 call writeLineAcc16
 646 ;test6.j(241)   println(1523 - 500);// 1023
 647 acc16= constant 1523
 648 acc16- constant 500
 649 call writeLineAcc16
 650 ;test6.j(242)   i = 1030 - 6;
 651 acc16= constant 1030
 652 acc16- constant 6
 653 acc16=> variable 2
 654 ;test6.j(243)   println(i);         // 1024
 655 acc16= variable 2
 656 call writeLineAcc16
 657 ;test6.j(244)   i = 1525 - 500;
 658 acc16= constant 1525
 659 acc16- constant 500
 660 acc16=> variable 2
 661 ;test6.j(245)   println(i);         // 1025
 662 acc16= variable 2
 663 call writeLineAcc16
 664 ;test6.j(246)   
 665 ;test6.j(247)   j = 1040;
 666 acc16= constant 1040
 667 acc16=> variable 4
 668 ;test6.j(248)   b = 13;
 669 acc8= constant 13
 670 acc8=> variable 0
 671 ;test6.j(249)   i = 3030;
 672 acc16= constant 3030
 673 acc16=> variable 2
 674 ;test6.j(250)   println(j - 14);    // 1026
 675 acc16= variable 4
 676 acc16- constant 14
 677 call writeLineAcc16
 678 ;test6.j(251)   println(j - b);     // 1027
 679 acc16= variable 4
 680 acc16- variable 0
 681 call writeLineAcc16
 682 ;test6.j(252)   j = 2000;
 683 acc16= constant 2000
 684 acc16=> variable 4
 685 ;test6.j(253)   println(j - 972);   // 1028
 686 acc16= variable 4
 687 acc16- constant 972
 688 call writeLineAcc16
 689 ;test6.j(254)   println(3029 - j);  // 1029
 690 acc16= constant 3029
 691 acc16- variable 4
 692 call writeLineAcc16
 693 ;test6.j(255)   println(i - j);     // 1030
 694 acc16= variable 2
 695 acc16- variable 4
 696 call writeLineAcc16
 697 ;test6.j(256)   
 698 ;test6.j(257)   j = 1050;
 699 acc16= constant 1050
 700 acc16=> variable 4
 701 ;test6.j(258)   b = 18;
 702 acc8= constant 18
 703 acc8=> variable 0
 704 ;test6.j(259)   i = j - 19;
 705 acc16= variable 4
 706 acc16- constant 19
 707 acc16=> variable 2
 708 ;test6.j(260)   println(i);         // 1031
 709 acc16= variable 2
 710 call writeLineAcc16
 711 ;test6.j(261)   i = j - b;
 712 acc16= variable 4
 713 acc16- variable 0
 714 acc16=> variable 2
 715 ;test6.j(262)   println(i);         // 1032
 716 acc16= variable 2
 717 call writeLineAcc16
 718 ;test6.j(263)   j = 2000;
 719 acc16= constant 2000
 720 acc16=> variable 4
 721 ;test6.j(264)   i = j - 967;
 722 acc16= variable 4
 723 acc16- constant 967
 724 acc16=> variable 2
 725 ;test6.j(265)   println(i);         // 1033
 726 acc16= variable 2
 727 call writeLineAcc16
 728 ;test6.j(266)   i = 3034 - j;
 729 acc16= constant 3034
 730 acc16- variable 4
 731 acc16=> variable 2
 732 ;test6.j(267)   println(i);         // 1034
 733 acc16= variable 2
 734 call writeLineAcc16
 735 ;test6.j(268)   i = 3035;
 736 acc16= constant 3035
 737 acc16=> variable 2
 738 ;test6.j(269)   i = i - j;
 739 acc16= variable 2
 740 acc16- variable 4
 741 acc16=> variable 2
 742 ;test6.j(270)   println(i);         // 1035
 743 acc16= variable 2
 744 call writeLineAcc16
 745 ;test6.j(271)   
 746 ;test6.j(272)   /****************************/
 747 ;test6.j(273)   /* Dual term multiplication */
 748 ;test6.j(274)   /****************************/
 749 ;test6.j(275)   println(518 * 2);   // 1036
 750 acc16= constant 518
 751 acc16* constant 2
 752 call writeLineAcc16
 753 ;test6.j(276)   println(1 * 1037);  // 1037
 754 acc8= constant 1
 755 acc8ToAcc16
 756 acc16* constant 1037
 757 call writeLineAcc16
 758 ;test6.j(277)   println(500 * 504 - 54354); // 1038 = 55392 - 54354
 759 acc16= constant 500
 760 acc16* constant 504
 761 acc16- constant 54354
 762 call writeLineAcc16
 763 ;test6.j(278) 
 764 ;test6.j(279)   i = 1039 * 1;
 765 acc16= constant 1039
 766 acc16* constant 1
 767 acc16=> variable 2
 768 ;test6.j(280)   println(i);         // 1039
 769 acc16= variable 2
 770 call writeLineAcc16
 771 ;test6.j(281)   i = 2 * 520;
 772 acc8= constant 2
 773 acc8ToAcc16
 774 acc16* constant 520
 775 acc16=> variable 2
 776 ;test6.j(282)   println(i);         // 1040
 777 acc16= variable 2
 778 call writeLineAcc16
 779 ;test6.j(283) 
 780 ;test6.j(284)   i = 1041;
 781 acc16= constant 1041
 782 acc16=> variable 2
 783 ;test6.j(285)   println(i * 1);     // 1041
 784 acc16= variable 2
 785 acc16* constant 1
 786 call writeLineAcc16
 787 ;test6.j(286)   i = 521;
 788 acc16= constant 521
 789 acc16=> variable 2
 790 ;test6.j(287)   println(2 * i);     // 1042
 791 acc8= constant 2
 792 acc8ToAcc16
 793 acc16* variable 2
 794 call writeLineAcc16
 795 ;test6.j(288) 
 796 ;test6.j(289)   i = 1043;
 797 acc16= constant 1043
 798 acc16=> variable 2
 799 ;test6.j(290)   i = i * 1;
 800 acc16= variable 2
 801 acc16* constant 1
 802 acc16=> variable 2
 803 ;test6.j(291)   println(i);         // 1043
 804 acc16= variable 2
 805 call writeLineAcc16
 806 ;test6.j(292)   i = 522;
 807 acc16= constant 522
 808 acc16=> variable 2
 809 ;test6.j(293)   i = 2 * i;
 810 acc8= constant 2
 811 acc8ToAcc16
 812 acc16* variable 2
 813 acc16=> variable 2
 814 ;test6.j(294)   println(i);         // 1044
 815 acc16= variable 2
 816 call writeLineAcc16
 817 ;test6.j(295) 
 818 ;test6.j(296)   i = 500 * 504 - 54347; // 1045 = 55392 - 54347
 819 acc16= constant 500
 820 acc16* constant 504
 821 acc16- constant 54347
 822 acc16=> variable 2
 823 ;test6.j(297)   println(i);         // 1045
 824 acc16= variable 2
 825 call writeLineAcc16
 826 ;test6.j(298)   i = 500;
 827 acc16= constant 500
 828 acc16=> variable 2
 829 ;test6.j(299)   i = i * 504 - 54346;
 830 acc16= variable 2
 831 acc16* constant 504
 832 acc16- constant 54346
 833 acc16=> variable 2
 834 ;test6.j(300)   println(i);         // 1046
 835 acc16= variable 2
 836 call writeLineAcc16
 837 ;test6.j(301)   i = 504;
 838 acc16= constant 504
 839 acc16=> variable 2
 840 ;test6.j(302)   i = 500 * i - 54345;
 841 acc16= constant 500
 842 acc16* variable 2
 843 acc16- constant 54345
 844 acc16=> variable 2
 845 ;test6.j(303)   println(i);         // 1047
 846 acc16= variable 2
 847 call writeLineAcc16
 848 ;test6.j(304)   
 849 ;test6.j(305)   /************/
 850 ;test6.j(306)   /* Overflow */
 851 ;test6.j(307)   /************/
 852 ;test6.j(308)   println("Nu komen 24.764 en 25.064");
 853 acc16= constant 895
 854 writeLineString
 855 ;test6.j(309)   println(300 * 301); // 90.300 % 65536 = 24.764
 856 acc16= constant 300
 857 acc16* constant 301
 858 call writeLineAcc16
 859 ;test6.j(310)   i = 300 * 302;
 860 acc16= constant 300
 861 acc16* constant 302
 862 acc16=> variable 2
 863 ;test6.j(311)   println(i);         // 90.600 % 65536 = 25.064
 864 acc16= variable 2
 865 call writeLineAcc16
 866 ;test6.j(312) 
 867 ;test6.j(313)   /***************************/
 868 ;test6.j(314)   /* hex noatation constants */
 869 ;test6.j(315)   /***************************/
 870 ;test6.j(316)   println("hex notation constants");
 871 acc16= constant 896
 872 writeLineString
 873 ;test6.j(317)   byte byteHex = 0x41;
 874 acc8= constant 65
 875 acc8=> variable 6
 876 ;test6.j(318)   println(byteHex);
 877 acc8= variable 6
 878 call writeLineAcc8
 879 ;test6.j(319)   word wordHex = 0x042A;
 880 acc16= constant 1066
 881 acc16=> variable 7
 882 ;test6.j(320)   println(wordHex);
 883 acc16= variable 7
 884 call writeLineAcc16
 885 ;test6.j(321) 
 886 ;test6.j(322)   println("Klaar");
 887 acc16= constant 897
 888 writeLineString
 889 ;test6.j(323) }
 890 stop
 891 stringConstant 0 = "Nu komen 251 en 252"
 892 stringConstant 1 = "Nu komen -253 en -254"
 893 stringConstant 2 = "Nu komen 255 en 256"
 894 stringConstant 3 = "Nu komen 1000..1047"
 895 stringConstant 4 = "Nu komen 24.764 en 25.064"
 896 stringConstant 5 = "hex notation constants"
 897 stringConstant 6 = "Klaar"
