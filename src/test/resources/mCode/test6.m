   0 ;test6.j(0) /*
   1 ;test6.j(1)  * A small program in the miniJava language.
   2 ;test6.j(2)  * Test 8-bit and 16-bit expressions.
   3 ;test6.j(3)  */
   4 ;test6.j(4) class TestExpression {
   5 ;test6.j(5)   private static byte b;
   6 ;test6.j(6)   private static byte c;
   7 ;test6.j(7)   private static word i;
   8 ;test6.j(8)   private static word j;
   9 ;test6.j(9)   private static byte byteHex;
  10 ;test6.j(10)   private static word wordHex;
  11 ;test6.j(11) 
  12 ;test6.j(12)   public static void main() {
  13 method main [publicLexeme, staticLexeme] voidLexeme
  14 ;test6.j(13)     println(0);         // 0
  15 acc8= constant 0
  16 call writeLineAcc8
  17 ;test6.j(14)     //LD    A,0
  18 ;test6.j(15)     //CALL  writeA
  19 ;test6.j(16)     //OK
  20 ;test6.j(17)   
  21 ;test6.j(18)     /*********************/
  22 ;test6.j(19)     /* Single term 8-bit */
  23 ;test6.j(20)     /*********************/
  24 ;test6.j(21)     b = 1;
  25 acc8= constant 1
  26 acc8=> variable 0
  27 ;test6.j(22)     c = 4;
  28 acc8= constant 4
  29 acc8=> variable 1
  30 ;test6.j(23)     println(b);         // 1
  31 acc8= variable 0
  32 call writeLineAcc8
  33 ;test6.j(24)     //LD    A,1
  34 ;test6.j(25)     //LD    (04000H),A
  35 ;test6.j(26)     //LD    A,(04000H)
  36 ;test6.j(27)     //CALL  writeA
  37 ;test6.j(28)     //OK
  38 ;test6.j(29)   
  39 ;test6.j(30)     /************************/
  40 ;test6.j(31)     /* Dual term addition   */
  41 ;test6.j(32)     /************************/
  42 ;test6.j(33)     println(0 + 2);     // 2
  43 acc8= constant 0
  44 acc8+ constant 2
  45 call writeLineAcc8
  46 ;test6.j(34)     println(b + 2);     // 3
  47 acc8= variable 0
  48 acc8+ constant 2
  49 call writeLineAcc8
  50 ;test6.j(35)     println(3 + b);     // 4
  51 acc8= constant 3
  52 acc8+ variable 0
  53 call writeLineAcc8
  54 ;test6.j(36)     println(b + c);     // 5
  55 acc8= variable 0
  56 acc8+ variable 1
  57 call writeLineAcc8
  58 ;test6.j(37)   
  59 ;test6.j(38)     c = 4 + 2;
  60 acc8= constant 4
  61 acc8+ constant 2
  62 acc8=> variable 1
  63 ;test6.j(39)     println(c);         // 6
  64 acc8= variable 1
  65 call writeLineAcc8
  66 ;test6.j(40)     c = b + 6;
  67 acc8= variable 0
  68 acc8+ constant 6
  69 acc8=> variable 1
  70 ;test6.j(41)     println(c);         // 7
  71 acc8= variable 1
  72 call writeLineAcc8
  73 ;test6.j(42)     c = 7 + b;
  74 acc8= constant 7
  75 acc8+ variable 0
  76 acc8=> variable 1
  77 ;test6.j(43)     println(c);         // 8
  78 acc8= variable 1
  79 call writeLineAcc8
  80 ;test6.j(44)     c = b + c;
  81 acc8= variable 0
  82 acc8+ variable 1
  83 acc8=> variable 1
  84 ;test6.j(45)     println(c);         // 9
  85 acc8= variable 1
  86 call writeLineAcc8
  87 ;test6.j(46)   
  88 ;test6.j(47)   
  89 ;test6.j(48)     i = 10;
  90 acc8= constant 10
  91 acc8=> variable 2
  92 ;test6.j(49)     println(i);         // 10
  93 acc16= variable 2
  94 call writeLineAcc16
  95 ;test6.j(50)     //LD    A,10
  96 ;test6.j(51)     //LD    L,A
  97 ;test6.j(52)     //LD    H,0
  98 ;test6.j(53)     //LD    (04004H),HL
  99 ;test6.j(54)     //OK
 100 ;test6.j(55)     
 101 ;test6.j(56)     println(i + 1);     // 11
 102 acc16= variable 2
 103 acc16+ constant 1
 104 call writeLineAcc16
 105 ;test6.j(57)     println(2 + i);     // 12
 106 acc8= constant 2
 107 acc8ToAcc16
 108 acc16+ variable 2
 109 call writeLineAcc16
 110 ;test6.j(58)     b = 3;
 111 acc8= constant 3
 112 acc8=> variable 0
 113 ;test6.j(59)     println(i + b);     // 13
 114 acc16= variable 2
 115 acc16+ variable 0
 116 call writeLineAcc16
 117 ;test6.j(60)     b++; //4
 118 incr8 variable 0
 119 ;test6.j(61)     println(b + i);     // 14
 120 acc8= variable 0
 121 acc8ToAcc16
 122 acc16+ variable 2
 123 call writeLineAcc16
 124 ;test6.j(62)   
 125 ;test6.j(63)     j = i + 5;    // 15
 126 acc16= variable 2
 127 acc16+ constant 5
 128 acc16=> variable 4
 129 ;test6.j(64)     println(j);
 130 acc16= variable 4
 131 call writeLineAcc16
 132 ;test6.j(65)     j = 6 + i;        // 16
 133 acc8= constant 6
 134 acc8ToAcc16
 135 acc16+ variable 2
 136 acc16=> variable 4
 137 ;test6.j(66)     println(j);
 138 acc16= variable 4
 139 call writeLineAcc16
 140 ;test6.j(67)     j = 7;
 141 acc8= constant 7
 142 acc8=> variable 4
 143 ;test6.j(68)     j = i + j;        // 17
 144 acc16= variable 2
 145 acc16+ variable 4
 146 acc16=> variable 4
 147 ;test6.j(69)     println(j);
 148 acc16= variable 4
 149 call writeLineAcc16
 150 ;test6.j(70)   
 151 ;test6.j(71)     /*************************/
 152 ;test6.j(72)     /* Dual term subtraction */
 153 ;test6.j(73)     /*************************/
 154 ;test6.j(74)     b = 33;
 155 acc8= constant 33
 156 acc8=> variable 0
 157 ;test6.j(75)     c = 12;
 158 acc8= constant 12
 159 acc8=> variable 1
 160 ;test6.j(76)     println(19 - 1);    // 18
 161 acc8= constant 19
 162 acc8- constant 1
 163 call writeLineAcc8
 164 ;test6.j(77)     println(b - 14);    // 19
 165 acc8= variable 0
 166 acc8- constant 14
 167 call writeLineAcc8
 168 ;test6.j(78)     println(53 - b);    // 20
 169 acc8= constant 53
 170 acc8- variable 0
 171 call writeLineAcc8
 172 ;test6.j(79)     println(b - c);     // 21
 173 acc8= variable 0
 174 acc8- variable 1
 175 call writeLineAcc8
 176 ;test6.j(80)   
 177 ;test6.j(81)     c = 24 - 2;
 178 acc8= constant 24
 179 acc8- constant 2
 180 acc8=> variable 1
 181 ;test6.j(82)     println(c);         // 22
 182 acc8= variable 1
 183 call writeLineAcc8
 184 ;test6.j(83)     c = b - 10;
 185 acc8= variable 0
 186 acc8- constant 10
 187 acc8=> variable 1
 188 ;test6.j(84)     println(c);         // 23
 189 acc8= variable 1
 190 call writeLineAcc8
 191 ;test6.j(85)     c = 57 - b;
 192 acc8= constant 57
 193 acc8- variable 0
 194 acc8=> variable 1
 195 ;test6.j(86)     println(c);         // 24
 196 acc8= variable 1
 197 call writeLineAcc8
 198 ;test6.j(87)     c = 8;
 199 acc8= constant 8
 200 acc8=> variable 1
 201 ;test6.j(88)     c = b - c;
 202 acc8= variable 0
 203 acc8- variable 1
 204 acc8=> variable 1
 205 ;test6.j(89)     println(c);         // 25
 206 acc8= variable 1
 207 call writeLineAcc8
 208 ;test6.j(90)   
 209 ;test6.j(91)     i = 40;
 210 acc8= constant 40
 211 acc8=> variable 2
 212 ;test6.j(92)     println(i - 14);    // 26
 213 acc16= variable 2
 214 acc16- constant 14
 215 call writeLineAcc16
 216 ;test6.j(93)     println(67 - i);    // 27
 217 acc8= constant 67
 218 acc8ToAcc16
 219 acc16- variable 2
 220 call writeLineAcc16
 221 ;test6.j(94)     b = 12;
 222 acc8= constant 12
 223 acc8=> variable 0
 224 ;test6.j(95)     println(i - b);     // 28
 225 acc16= variable 2
 226 acc16- variable 0
 227 call writeLineAcc16
 228 ;test6.j(96)     b = 69;
 229 acc8= constant 69
 230 acc8=> variable 0
 231 ;test6.j(97)     println(b - i);     // 29
 232 acc8= variable 0
 233 acc8ToAcc16
 234 acc16- variable 2
 235 call writeLineAcc16
 236 ;test6.j(98)   
 237 ;test6.j(99)     j = i - 10;
 238 acc16= variable 2
 239 acc16- constant 10
 240 acc16=> variable 4
 241 ;test6.j(100)     println(j);         // 30
 242 acc16= variable 4
 243 call writeLineAcc16
 244 ;test6.j(101)     j = 71 - i;
 245 acc8= constant 71
 246 acc8ToAcc16
 247 acc16- variable 2
 248 acc16=> variable 4
 249 ;test6.j(102)     println(j);         // 31
 250 acc16= variable 4
 251 call writeLineAcc16
 252 ;test6.j(103)     j = 8;
 253 acc8= constant 8
 254 acc8=> variable 4
 255 ;test6.j(104)     j = i - j;
 256 acc16= variable 2
 257 acc16- variable 4
 258 acc16=> variable 4
 259 ;test6.j(105)     println(j);         // 32
 260 acc16= variable 4
 261 call writeLineAcc16
 262 ;test6.j(106)     
 263 ;test6.j(107)     /****************************/
 264 ;test6.j(108)     /* Dual term multiplication */
 265 ;test6.j(109)     /****************************/
 266 ;test6.j(110)     println(3 * 11);    // 33
 267 acc8= constant 3
 268 acc8* constant 11
 269 call writeLineAcc8
 270 ;test6.j(111)     b = 17;
 271 acc8= constant 17
 272 acc8=> variable 0
 273 ;test6.j(112)     println(b * 2);     // 34
 274 acc8= variable 0
 275 acc8* constant 2
 276 call writeLineAcc8
 277 ;test6.j(113)     b = 7;
 278 acc8= constant 7
 279 acc8=> variable 0
 280 ;test6.j(114)     println(5 * b);     // 35
 281 acc8= constant 5
 282 acc8* variable 0
 283 call writeLineAcc8
 284 ;test6.j(115)     b = 2;
 285 acc8= constant 2
 286 acc8=> variable 0
 287 ;test6.j(116)     c = 18;
 288 acc8= constant 18
 289 acc8=> variable 1
 290 ;test6.j(117)     println(b * c);     // 36
 291 acc8= variable 0
 292 acc8* variable 1
 293 call writeLineAcc8
 294 ;test6.j(118)     
 295 ;test6.j(119)     c = 37 * 1;
 296 acc8= constant 37
 297 acc8* constant 1
 298 acc8=> variable 1
 299 ;test6.j(120)     println(c);         // 37
 300 acc8= variable 1
 301 call writeLineAcc8
 302 ;test6.j(121)     b = 2;
 303 acc8= constant 2
 304 acc8=> variable 0
 305 ;test6.j(122)     c = b * 19;
 306 acc8= variable 0
 307 acc8* constant 19
 308 acc8=> variable 1
 309 ;test6.j(123)     println(c);         // 38
 310 acc8= variable 1
 311 call writeLineAcc8
 312 ;test6.j(124)     b = 3;
 313 acc8= constant 3
 314 acc8=> variable 0
 315 ;test6.j(125)     c = 13 * b;
 316 acc8= constant 13
 317 acc8* variable 0
 318 acc8=> variable 1
 319 ;test6.j(126)     println(c);         // 39
 320 acc8= variable 1
 321 call writeLineAcc8
 322 ;test6.j(127)     b = 5;
 323 acc8= constant 5
 324 acc8=> variable 0
 325 ;test6.j(128)     c = 8;
 326 acc8= constant 8
 327 acc8=> variable 1
 328 ;test6.j(129)     c = b * c;
 329 acc8= variable 0
 330 acc8* variable 1
 331 acc8=> variable 1
 332 ;test6.j(130)     println(c);         // 40
 333 acc8= variable 1
 334 call writeLineAcc8
 335 ;test6.j(131)   
 336 ;test6.j(132)     /**********************/
 337 ;test6.j(133)     /* Dual term division */
 338 ;test6.j(134)     /**********************/
 339 ;test6.j(135)     println(123 / 3);   // 41
 340 acc8= constant 123
 341 acc8/ constant 3
 342 call writeLineAcc8
 343 ;test6.j(136)     b = 126;
 344 acc8= constant 126
 345 acc8=> variable 0
 346 ;test6.j(137)     println(b / 3);     // 42
 347 acc8= variable 0
 348 acc8/ constant 3
 349 call writeLineAcc8
 350 ;test6.j(138)     b = 3;
 351 acc8= constant 3
 352 acc8=> variable 0
 353 ;test6.j(139)     println(129 / b);   // 43
 354 acc8= constant 129
 355 acc8/ variable 0
 356 call writeLineAcc8
 357 ;test6.j(140)     b = 132;
 358 acc8= constant 132
 359 acc8=> variable 0
 360 ;test6.j(141)     c = 3;
 361 acc8= constant 3
 362 acc8=> variable 1
 363 ;test6.j(142)     println(b / c);     // 44
 364 acc8= variable 0
 365 acc8/ variable 1
 366 call writeLineAcc8
 367 ;test6.j(143)     
 368 ;test6.j(144)     c = 135 / 3;
 369 acc8= constant 135
 370 acc8/ constant 3
 371 acc8=> variable 1
 372 ;test6.j(145)     println(c);         // 45
 373 acc8= variable 1
 374 call writeLineAcc8
 375 ;test6.j(146)     b = 138;
 376 acc8= constant 138
 377 acc8=> variable 0
 378 ;test6.j(147)     c = b / 3;
 379 acc8= variable 0
 380 acc8/ constant 3
 381 acc8=> variable 1
 382 ;test6.j(148)     println(c);         // 46
 383 acc8= variable 1
 384 call writeLineAcc8
 385 ;test6.j(149)     b = 3;
 386 acc8= constant 3
 387 acc8=> variable 0
 388 ;test6.j(150)     c = 141 / b;
 389 acc8= constant 141
 390 acc8/ variable 0
 391 acc8=> variable 1
 392 ;test6.j(151)     println(c);         // 47
 393 acc8= variable 1
 394 call writeLineAcc8
 395 ;test6.j(152)     b = 144;
 396 acc8= constant 144
 397 acc8=> variable 0
 398 ;test6.j(153)     c = 3;
 399 acc8= constant 3
 400 acc8=> variable 1
 401 ;test6.j(154)     c = b / c;
 402 acc8= variable 0
 403 acc8/ variable 1
 404 acc8=> variable 1
 405 ;test6.j(155)     println(c);         // 48
 406 acc8= variable 1
 407 call writeLineAcc8
 408 ;test6.j(156)   
 409 ;test6.j(157)     /*************************/
 410 ;test6.j(158)     /* possible loss of data */
 411 ;test6.j(159)     /*************************/
 412 ;test6.j(160)     println("Nu komen 251 en 252");
 413 acc16= constant 901
 414 writeLineString
 415 ;test6.j(161)     b = 507;
 416 acc16= constant 507
 417 acc16=> variable 0
 418 ;test6.j(162)     println(b);         // 251
 419 acc8= variable 0
 420 call writeLineAcc8
 421 ;test6.j(163)     i = 508;
 422 acc16= constant 508
 423 acc16=> variable 2
 424 ;test6.j(164)     b = i;
 425 acc16= variable 2
 426 acc16=> variable 0
 427 ;test6.j(165)     println(b);         // 252
 428 acc8= variable 0
 429 call writeLineAcc8
 430 ;test6.j(166)   
 431 ;test6.j(167)     println("Nu komen -253 en -254");
 432 acc16= constant 902
 433 writeLineString
 434 ;test6.j(168)     b = b - 505;
 435 acc8= variable 0
 436 acc8ToAcc16
 437 acc16- constant 505
 438 acc16=> variable 0
 439 ;test6.j(169)     println(b);         // 252 - 505 = -253
 440 acc8= variable 0
 441 call writeLineAcc8
 442 ;test6.j(170)     i = i + 5;
 443 acc16= variable 2
 444 acc16+ constant 5
 445 acc16=> variable 2
 446 ;test6.j(171)     b = b - i;
 447 acc8= variable 0
 448 acc8ToAcc16
 449 acc16- variable 2
 450 acc16=> variable 0
 451 ;test6.j(172)     println(b);         // -233 - 11 = -254
 452 acc8= variable 0
 453 call writeLineAcc8
 454 ;test6.j(173)     
 455 ;test6.j(174)     println("Nu komen 255 en 256");
 456 acc16= constant 903
 457 writeLineString
 458 ;test6.j(175)     b = 255;
 459 acc8= constant 255
 460 acc8=> variable 0
 461 ;test6.j(176)     println(b);         // 255
 462 acc8= variable 0
 463 call writeLineAcc8
 464 ;test6.j(177)     //LD    A,255
 465 ;test6.j(178)     //LD    (04001H),A
 466 ;test6.j(179)     //LD    A,(04001H)
 467 ;test6.j(180)     //CALL  writeA
 468 ;test6.j(181)     //OK
 469 ;test6.j(182)   
 470 ;test6.j(183)     /**********************/
 471 ;test6.j(184)     /* Single term 16-bit */
 472 ;test6.j(185)     /**********************/
 473 ;test6.j(186)     i = 256;
 474 acc16= constant 256
 475 acc16=> variable 2
 476 ;test6.j(187)     println(i);         // 256
 477 acc16= variable 2
 478 call writeLineAcc16
 479 ;test6.j(188)     //LD    HL,256
 480 ;test6.j(189)     //LD    (04006H),HL
 481 ;test6.j(190)     //LD    HL,(04006H)
 482 ;test6.j(191)     //CALL  writeHL
 483 ;test6.j(192)     //OK
 484 ;test6.j(193)   
 485 ;test6.j(194)     println("Nu komen 1000..1047");
 486 acc16= constant 904
 487 writeLineString
 488 ;test6.j(195)     println(1000);      // 1000
 489 acc16= constant 1000
 490 call writeLineAcc16
 491 ;test6.j(196)     j = 1001;
 492 acc16= constant 1001
 493 acc16=> variable 4
 494 ;test6.j(197)     println(j);         // 1001
 495 acc16= variable 4
 496 call writeLineAcc16
 497 ;test6.j(198)   
 498 ;test6.j(199)     /************************/
 499 ;test6.j(200)     /* Dual term addition   */
 500 ;test6.j(201)     /************************/
 501 ;test6.j(202)     println(1000 + 2);  // 1002
 502 acc16= constant 1000
 503 acc16+ constant 2
 504 call writeLineAcc16
 505 ;test6.j(203)     println(3 + 1000);  // 1003
 506 acc8= constant 3
 507 acc8ToAcc16
 508 acc16+ constant 1000
 509 call writeLineAcc16
 510 ;test6.j(204)     println(500 + 504); // 1004
 511 acc16= constant 500
 512 acc16+ constant 504
 513 call writeLineAcc16
 514 ;test6.j(205)     i = 1000 + 5;
 515 acc16= constant 1000
 516 acc16+ constant 5
 517 acc16=> variable 2
 518 ;test6.j(206)     println(i);         // 1005
 519 acc16= variable 2
 520 call writeLineAcc16
 521 ;test6.j(207)     i = 6 + 1000;
 522 acc8= constant 6
 523 acc8ToAcc16
 524 acc16+ constant 1000
 525 acc16=> variable 2
 526 ;test6.j(208)     println(i);         // 1006
 527 acc16= variable 2
 528 call writeLineAcc16
 529 ;test6.j(209)     i = 500 + 507;
 530 acc16= constant 500
 531 acc16+ constant 507
 532 acc16=> variable 2
 533 ;test6.j(210)     println(i);         // 1007
 534 acc16= variable 2
 535 call writeLineAcc16
 536 ;test6.j(211)     
 537 ;test6.j(212)     j = 1000;
 538 acc16= constant 1000
 539 acc16=> variable 4
 540 ;test6.j(213)     b = 10;
 541 acc8= constant 10
 542 acc8=> variable 0
 543 ;test6.j(214)     i = 514;
 544 acc16= constant 514
 545 acc16=> variable 2
 546 ;test6.j(215)     println(j + 8);     // 1008
 547 acc16= variable 4
 548 acc16+ constant 8
 549 call writeLineAcc16
 550 ;test6.j(216)     println(9 + j);     // 1009
 551 acc8= constant 9
 552 acc8ToAcc16
 553 acc16+ variable 4
 554 call writeLineAcc16
 555 ;test6.j(217)     println(j + b);     // 1010
 556 acc16= variable 4
 557 acc16+ variable 0
 558 call writeLineAcc16
 559 ;test6.j(218)     b++;
 560 incr8 variable 0
 561 ;test6.j(219)     println(b + j);     // 1011
 562 acc8= variable 0
 563 acc8ToAcc16
 564 acc16+ variable 4
 565 call writeLineAcc16
 566 ;test6.j(220)     j = 500;
 567 acc16= constant 500
 568 acc16=> variable 4
 569 ;test6.j(221)     println(j + 512);   // 1012
 570 acc16= variable 4
 571 acc16+ constant 512
 572 call writeLineAcc16
 573 ;test6.j(222)     println(513 + j);   // 1013
 574 acc16= constant 513
 575 acc16+ variable 4
 576 call writeLineAcc16
 577 ;test6.j(223)     println(i + j);     // 1014
 578 acc16= variable 2
 579 acc16+ variable 4
 580 call writeLineAcc16
 581 ;test6.j(224)     
 582 ;test6.j(225)     j = 1000;
 583 acc16= constant 1000
 584 acc16=> variable 4
 585 ;test6.j(226)     b = 17;
 586 acc8= constant 17
 587 acc8=> variable 0
 588 ;test6.j(227)     i = j + 15;
 589 acc16= variable 4
 590 acc16+ constant 15
 591 acc16=> variable 2
 592 ;test6.j(228)     println(i);         // 1015
 593 acc16= variable 2
 594 call writeLineAcc16
 595 ;test6.j(229)     i = 16 + j;
 596 acc8= constant 16
 597 acc8ToAcc16
 598 acc16+ variable 4
 599 acc16=> variable 2
 600 ;test6.j(230)     println(i);         // 1016
 601 acc16= variable 2
 602 call writeLineAcc16
 603 ;test6.j(231)     i = j + b;
 604 acc16= variable 4
 605 acc16+ variable 0
 606 acc16=> variable 2
 607 ;test6.j(232)     println(i);         // 1017
 608 acc16= variable 2
 609 call writeLineAcc16
 610 ;test6.j(233)     b++;
 611 incr8 variable 0
 612 ;test6.j(234)     i = b + j;
 613 acc8= variable 0
 614 acc8ToAcc16
 615 acc16+ variable 4
 616 acc16=> variable 2
 617 ;test6.j(235)     println(i);         // 1018
 618 acc16= variable 2
 619 call writeLineAcc16
 620 ;test6.j(236)     j = 500;
 621 acc16= constant 500
 622 acc16=> variable 4
 623 ;test6.j(237)     i = j + 519;
 624 acc16= variable 4
 625 acc16+ constant 519
 626 acc16=> variable 2
 627 ;test6.j(238)     println(i);         // 1019
 628 acc16= variable 2
 629 call writeLineAcc16
 630 ;test6.j(239)     i = 520 + j;
 631 acc16= constant 520
 632 acc16+ variable 4
 633 acc16=> variable 2
 634 ;test6.j(240)     println(i);         // 1020
 635 acc16= variable 2
 636 call writeLineAcc16
 637 ;test6.j(241)     i = 521;
 638 acc16= constant 521
 639 acc16=> variable 2
 640 ;test6.j(242)     i = i + j;
 641 acc16= variable 2
 642 acc16+ variable 4
 643 acc16=> variable 2
 644 ;test6.j(243)     println(i);         // 1021
 645 acc16= variable 2
 646 call writeLineAcc16
 647 ;test6.j(244)     
 648 ;test6.j(245)     /*************************/
 649 ;test6.j(246)     /* Dual term subtraction */
 650 ;test6.j(247)     /*************************/
 651 ;test6.j(248)     println(1024 - 2);  // 1022
 652 acc16= constant 1024
 653 acc16- constant 2
 654 call writeLineAcc16
 655 ;test6.j(249)     println(1523 - 500);// 1023
 656 acc16= constant 1523
 657 acc16- constant 500
 658 call writeLineAcc16
 659 ;test6.j(250)     i = 1030 - 6;
 660 acc16= constant 1030
 661 acc16- constant 6
 662 acc16=> variable 2
 663 ;test6.j(251)     println(i);         // 1024
 664 acc16= variable 2
 665 call writeLineAcc16
 666 ;test6.j(252)     i = 1525 - 500;
 667 acc16= constant 1525
 668 acc16- constant 500
 669 acc16=> variable 2
 670 ;test6.j(253)     println(i);         // 1025
 671 acc16= variable 2
 672 call writeLineAcc16
 673 ;test6.j(254)     
 674 ;test6.j(255)     j = 1040;
 675 acc16= constant 1040
 676 acc16=> variable 4
 677 ;test6.j(256)     b = 13;
 678 acc8= constant 13
 679 acc8=> variable 0
 680 ;test6.j(257)     i = 3030;
 681 acc16= constant 3030
 682 acc16=> variable 2
 683 ;test6.j(258)     println(j - 14);    // 1026
 684 acc16= variable 4
 685 acc16- constant 14
 686 call writeLineAcc16
 687 ;test6.j(259)     println(j - b);     // 1027
 688 acc16= variable 4
 689 acc16- variable 0
 690 call writeLineAcc16
 691 ;test6.j(260)     j = 2000;
 692 acc16= constant 2000
 693 acc16=> variable 4
 694 ;test6.j(261)     println(j - 972);   // 1028
 695 acc16= variable 4
 696 acc16- constant 972
 697 call writeLineAcc16
 698 ;test6.j(262)     println(3029 - j);  // 1029
 699 acc16= constant 3029
 700 acc16- variable 4
 701 call writeLineAcc16
 702 ;test6.j(263)     println(i - j);     // 1030
 703 acc16= variable 2
 704 acc16- variable 4
 705 call writeLineAcc16
 706 ;test6.j(264)     
 707 ;test6.j(265)     j = 1050;
 708 acc16= constant 1050
 709 acc16=> variable 4
 710 ;test6.j(266)     b = 18;
 711 acc8= constant 18
 712 acc8=> variable 0
 713 ;test6.j(267)     i = j - 19;
 714 acc16= variable 4
 715 acc16- constant 19
 716 acc16=> variable 2
 717 ;test6.j(268)     println(i);         // 1031
 718 acc16= variable 2
 719 call writeLineAcc16
 720 ;test6.j(269)     i = j - b;
 721 acc16= variable 4
 722 acc16- variable 0
 723 acc16=> variable 2
 724 ;test6.j(270)     println(i);         // 1032
 725 acc16= variable 2
 726 call writeLineAcc16
 727 ;test6.j(271)     j = 2000;
 728 acc16= constant 2000
 729 acc16=> variable 4
 730 ;test6.j(272)     i = j - 967;
 731 acc16= variable 4
 732 acc16- constant 967
 733 acc16=> variable 2
 734 ;test6.j(273)     println(i);         // 1033
 735 acc16= variable 2
 736 call writeLineAcc16
 737 ;test6.j(274)     i = 3034 - j;
 738 acc16= constant 3034
 739 acc16- variable 4
 740 acc16=> variable 2
 741 ;test6.j(275)     println(i);         // 1034
 742 acc16= variable 2
 743 call writeLineAcc16
 744 ;test6.j(276)     i = 3035;
 745 acc16= constant 3035
 746 acc16=> variable 2
 747 ;test6.j(277)     i = i - j;
 748 acc16= variable 2
 749 acc16- variable 4
 750 acc16=> variable 2
 751 ;test6.j(278)     println(i);         // 1035
 752 acc16= variable 2
 753 call writeLineAcc16
 754 ;test6.j(279)     
 755 ;test6.j(280)     /****************************/
 756 ;test6.j(281)     /* Dual term multiplication */
 757 ;test6.j(282)     /****************************/
 758 ;test6.j(283)     println(518 * 2);   // 1036
 759 acc16= constant 518
 760 acc16* constant 2
 761 call writeLineAcc16
 762 ;test6.j(284)     println(1 * 1037);  // 1037
 763 acc8= constant 1
 764 acc8ToAcc16
 765 acc16* constant 1037
 766 call writeLineAcc16
 767 ;test6.j(285)     println(500 * 504 - 54354); // 1038 = 55392 - 54354
 768 acc16= constant 500
 769 acc16* constant 504
 770 acc16- constant 54354
 771 call writeLineAcc16
 772 ;test6.j(286)   
 773 ;test6.j(287)     i = 1039 * 1;
 774 acc16= constant 1039
 775 acc16* constant 1
 776 acc16=> variable 2
 777 ;test6.j(288)     println(i);         // 1039
 778 acc16= variable 2
 779 call writeLineAcc16
 780 ;test6.j(289)     i = 2 * 520;
 781 acc8= constant 2
 782 acc8ToAcc16
 783 acc16* constant 520
 784 acc16=> variable 2
 785 ;test6.j(290)     println(i);         // 1040
 786 acc16= variable 2
 787 call writeLineAcc16
 788 ;test6.j(291)   
 789 ;test6.j(292)     i = 1041;
 790 acc16= constant 1041
 791 acc16=> variable 2
 792 ;test6.j(293)     println(i * 1);     // 1041
 793 acc16= variable 2
 794 acc16* constant 1
 795 call writeLineAcc16
 796 ;test6.j(294)     i = 521;
 797 acc16= constant 521
 798 acc16=> variable 2
 799 ;test6.j(295)     println(2 * i);     // 1042
 800 acc8= constant 2
 801 acc8ToAcc16
 802 acc16* variable 2
 803 call writeLineAcc16
 804 ;test6.j(296)   
 805 ;test6.j(297)     i = 1043;
 806 acc16= constant 1043
 807 acc16=> variable 2
 808 ;test6.j(298)     i = i * 1;
 809 acc16= variable 2
 810 acc16* constant 1
 811 acc16=> variable 2
 812 ;test6.j(299)     println(i);         // 1043
 813 acc16= variable 2
 814 call writeLineAcc16
 815 ;test6.j(300)     i = 522;
 816 acc16= constant 522
 817 acc16=> variable 2
 818 ;test6.j(301)     i = 2 * i;
 819 acc8= constant 2
 820 acc8ToAcc16
 821 acc16* variable 2
 822 acc16=> variable 2
 823 ;test6.j(302)     println(i);         // 1044
 824 acc16= variable 2
 825 call writeLineAcc16
 826 ;test6.j(303)   
 827 ;test6.j(304)     i = 500 * 504 - 54347; // 1045 = 55392 - 54347
 828 acc16= constant 500
 829 acc16* constant 504
 830 acc16- constant 54347
 831 acc16=> variable 2
 832 ;test6.j(305)     println(i);         // 1045
 833 acc16= variable 2
 834 call writeLineAcc16
 835 ;test6.j(306)     i = 500;
 836 acc16= constant 500
 837 acc16=> variable 2
 838 ;test6.j(307)     i = i * 504 - 54346;
 839 acc16= variable 2
 840 acc16* constant 504
 841 acc16- constant 54346
 842 acc16=> variable 2
 843 ;test6.j(308)     println(i);         // 1046
 844 acc16= variable 2
 845 call writeLineAcc16
 846 ;test6.j(309)     i = 504;
 847 acc16= constant 504
 848 acc16=> variable 2
 849 ;test6.j(310)     i = 500 * i - 54345;
 850 acc16= constant 500
 851 acc16* variable 2
 852 acc16- constant 54345
 853 acc16=> variable 2
 854 ;test6.j(311)     println(i);         // 1047
 855 acc16= variable 2
 856 call writeLineAcc16
 857 ;test6.j(312)     
 858 ;test6.j(313)     /************/
 859 ;test6.j(314)     /* Overflow */
 860 ;test6.j(315)     /************/
 861 ;test6.j(316)     println("Nu komen 24.764 en 25.064");
 862 acc16= constant 905
 863 writeLineString
 864 ;test6.j(317)     println(300 * 301); // 90.300 % 65536 = 24.764
 865 acc16= constant 300
 866 acc16* constant 301
 867 call writeLineAcc16
 868 ;test6.j(318)     i = 300 * 302;
 869 acc16= constant 300
 870 acc16* constant 302
 871 acc16=> variable 2
 872 ;test6.j(319)     println(i);         // 90.600 % 65536 = 25.064
 873 acc16= variable 2
 874 call writeLineAcc16
 875 ;test6.j(320)   
 876 ;test6.j(321)     /***************************/
 877 ;test6.j(322)     /* hex noatation constants */
 878 ;test6.j(323)     /***************************/
 879 ;test6.j(324)     println("hex notation constants");
 880 acc16= constant 906
 881 writeLineString
 882 ;test6.j(325)     byteHex = 0x41;
 883 acc8= constant 65
 884 acc8=> variable 6
 885 ;test6.j(326)     println(byteHex);
 886 acc8= variable 6
 887 call writeLineAcc8
 888 ;test6.j(327)     wordHex = 0x042A;
 889 acc16= constant 1066
 890 acc16=> variable 7
 891 ;test6.j(328)     println(wordHex);
 892 acc16= variable 7
 893 call writeLineAcc16
 894 ;test6.j(329)   
 895 ;test6.j(330)     println("Klaar");
 896 acc16= constant 907
 897 writeLineString
 898 ;test6.j(331)   }
 899 ;test6.j(332) }
 900 stop
 901 stringConstant 0 = "Nu komen 251 en 252"
 902 stringConstant 1 = "Nu komen -253 en -254"
 903 stringConstant 2 = "Nu komen 255 en 256"
 904 stringConstant 3 = "Nu komen 1000..1047"
 905 stringConstant 4 = "Nu komen 24.764 en 25.064"
 906 stringConstant 5 = "hex notation constants"
 907 stringConstant 6 = "Klaar"
