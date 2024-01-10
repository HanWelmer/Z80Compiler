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
  13 ;test6.j(13)     println(0);         // 0
  14 acc8= constant 0
  15 call writeLineAcc8
  16 ;test6.j(14)     //LD    A,0
  17 ;test6.j(15)     //CALL  writeA
  18 ;test6.j(16)     //OK
  19 ;test6.j(17)   
  20 ;test6.j(18)     /*********************/
  21 ;test6.j(19)     /* Single term 8-bit */
  22 ;test6.j(20)     /*********************/
  23 ;test6.j(21)     b = 1;
  24 acc8= constant 1
  25 acc8=> variable 0
  26 ;test6.j(22)     c = 4;
  27 acc8= constant 4
  28 acc8=> variable 1
  29 ;test6.j(23)     println(b);         // 1
  30 acc8= variable 0
  31 call writeLineAcc8
  32 ;test6.j(24)     //LD    A,1
  33 ;test6.j(25)     //LD    (04000H),A
  34 ;test6.j(26)     //LD    A,(04000H)
  35 ;test6.j(27)     //CALL  writeA
  36 ;test6.j(28)     //OK
  37 ;test6.j(29)   
  38 ;test6.j(30)     /************************/
  39 ;test6.j(31)     /* Dual term addition   */
  40 ;test6.j(32)     /************************/
  41 ;test6.j(33)     println(0 + 2);     // 2
  42 acc8= constant 0
  43 acc8+ constant 2
  44 call writeLineAcc8
  45 ;test6.j(34)     println(b + 2);     // 3
  46 acc8= variable 0
  47 acc8+ constant 2
  48 call writeLineAcc8
  49 ;test6.j(35)     println(3 + b);     // 4
  50 acc8= constant 3
  51 acc8+ variable 0
  52 call writeLineAcc8
  53 ;test6.j(36)     println(b + c);     // 5
  54 acc8= variable 0
  55 acc8+ variable 1
  56 call writeLineAcc8
  57 ;test6.j(37)   
  58 ;test6.j(38)     c = 4 + 2;
  59 acc8= constant 4
  60 acc8+ constant 2
  61 acc8=> variable 1
  62 ;test6.j(39)     println(c);         // 6
  63 acc8= variable 1
  64 call writeLineAcc8
  65 ;test6.j(40)     c = b + 6;
  66 acc8= variable 0
  67 acc8+ constant 6
  68 acc8=> variable 1
  69 ;test6.j(41)     println(c);         // 7
  70 acc8= variable 1
  71 call writeLineAcc8
  72 ;test6.j(42)     c = 7 + b;
  73 acc8= constant 7
  74 acc8+ variable 0
  75 acc8=> variable 1
  76 ;test6.j(43)     println(c);         // 8
  77 acc8= variable 1
  78 call writeLineAcc8
  79 ;test6.j(44)     c = b + c;
  80 acc8= variable 0
  81 acc8+ variable 1
  82 acc8=> variable 1
  83 ;test6.j(45)     println(c);         // 9
  84 acc8= variable 1
  85 call writeLineAcc8
  86 ;test6.j(46)   
  87 ;test6.j(47)   
  88 ;test6.j(48)     i = 10;
  89 acc8= constant 10
  90 acc8=> variable 2
  91 ;test6.j(49)     println(i);         // 10
  92 acc16= variable 2
  93 call writeLineAcc16
  94 ;test6.j(50)     //LD    A,10
  95 ;test6.j(51)     //LD    L,A
  96 ;test6.j(52)     //LD    H,0
  97 ;test6.j(53)     //LD    (04004H),HL
  98 ;test6.j(54)     //OK
  99 ;test6.j(55)     
 100 ;test6.j(56)     println(i + 1);     // 11
 101 acc16= variable 2
 102 acc16+ constant 1
 103 call writeLineAcc16
 104 ;test6.j(57)     println(2 + i);     // 12
 105 acc8= constant 2
 106 acc8ToAcc16
 107 acc16+ variable 2
 108 call writeLineAcc16
 109 ;test6.j(58)     b = 3;
 110 acc8= constant 3
 111 acc8=> variable 0
 112 ;test6.j(59)     println(i + b);     // 13
 113 acc16= variable 2
 114 acc16+ variable 0
 115 call writeLineAcc16
 116 ;test6.j(60)     b++; //4
 117 incr8 variable 0
 118 ;test6.j(61)     println(b + i);     // 14
 119 acc8= variable 0
 120 acc8ToAcc16
 121 acc16+ variable 2
 122 call writeLineAcc16
 123 ;test6.j(62)   
 124 ;test6.j(63)     j = i + 5;    // 15
 125 acc16= variable 2
 126 acc16+ constant 5
 127 acc16=> variable 4
 128 ;test6.j(64)     println(j);
 129 acc16= variable 4
 130 call writeLineAcc16
 131 ;test6.j(65)     j = 6 + i;        // 16
 132 acc8= constant 6
 133 acc8ToAcc16
 134 acc16+ variable 2
 135 acc16=> variable 4
 136 ;test6.j(66)     println(j);
 137 acc16= variable 4
 138 call writeLineAcc16
 139 ;test6.j(67)     j = 7;
 140 acc8= constant 7
 141 acc8=> variable 4
 142 ;test6.j(68)     j = i + j;        // 17
 143 acc16= variable 2
 144 acc16+ variable 4
 145 acc16=> variable 4
 146 ;test6.j(69)     println(j);
 147 acc16= variable 4
 148 call writeLineAcc16
 149 ;test6.j(70)   
 150 ;test6.j(71)     /*************************/
 151 ;test6.j(72)     /* Dual term subtraction */
 152 ;test6.j(73)     /*************************/
 153 ;test6.j(74)     b = 33;
 154 acc8= constant 33
 155 acc8=> variable 0
 156 ;test6.j(75)     c = 12;
 157 acc8= constant 12
 158 acc8=> variable 1
 159 ;test6.j(76)     println(19 - 1);    // 18
 160 acc8= constant 19
 161 acc8- constant 1
 162 call writeLineAcc8
 163 ;test6.j(77)     println(b - 14);    // 19
 164 acc8= variable 0
 165 acc8- constant 14
 166 call writeLineAcc8
 167 ;test6.j(78)     println(53 - b);    // 20
 168 acc8= constant 53
 169 acc8- variable 0
 170 call writeLineAcc8
 171 ;test6.j(79)     println(b - c);     // 21
 172 acc8= variable 0
 173 acc8- variable 1
 174 call writeLineAcc8
 175 ;test6.j(80)   
 176 ;test6.j(81)     c = 24 - 2;
 177 acc8= constant 24
 178 acc8- constant 2
 179 acc8=> variable 1
 180 ;test6.j(82)     println(c);         // 22
 181 acc8= variable 1
 182 call writeLineAcc8
 183 ;test6.j(83)     c = b - 10;
 184 acc8= variable 0
 185 acc8- constant 10
 186 acc8=> variable 1
 187 ;test6.j(84)     println(c);         // 23
 188 acc8= variable 1
 189 call writeLineAcc8
 190 ;test6.j(85)     c = 57 - b;
 191 acc8= constant 57
 192 acc8- variable 0
 193 acc8=> variable 1
 194 ;test6.j(86)     println(c);         // 24
 195 acc8= variable 1
 196 call writeLineAcc8
 197 ;test6.j(87)     c = 8;
 198 acc8= constant 8
 199 acc8=> variable 1
 200 ;test6.j(88)     c = b - c;
 201 acc8= variable 0
 202 acc8- variable 1
 203 acc8=> variable 1
 204 ;test6.j(89)     println(c);         // 25
 205 acc8= variable 1
 206 call writeLineAcc8
 207 ;test6.j(90)   
 208 ;test6.j(91)     i = 40;
 209 acc8= constant 40
 210 acc8=> variable 2
 211 ;test6.j(92)     println(i - 14);    // 26
 212 acc16= variable 2
 213 acc16- constant 14
 214 call writeLineAcc16
 215 ;test6.j(93)     println(67 - i);    // 27
 216 acc8= constant 67
 217 acc8ToAcc16
 218 acc16- variable 2
 219 call writeLineAcc16
 220 ;test6.j(94)     b = 12;
 221 acc8= constant 12
 222 acc8=> variable 0
 223 ;test6.j(95)     println(i - b);     // 28
 224 acc16= variable 2
 225 acc16- variable 0
 226 call writeLineAcc16
 227 ;test6.j(96)     b = 69;
 228 acc8= constant 69
 229 acc8=> variable 0
 230 ;test6.j(97)     println(b - i);     // 29
 231 acc8= variable 0
 232 acc8ToAcc16
 233 acc16- variable 2
 234 call writeLineAcc16
 235 ;test6.j(98)   
 236 ;test6.j(99)     j = i - 10;
 237 acc16= variable 2
 238 acc16- constant 10
 239 acc16=> variable 4
 240 ;test6.j(100)     println(j);         // 30
 241 acc16= variable 4
 242 call writeLineAcc16
 243 ;test6.j(101)     j = 71 - i;
 244 acc8= constant 71
 245 acc8ToAcc16
 246 acc16- variable 2
 247 acc16=> variable 4
 248 ;test6.j(102)     println(j);         // 31
 249 acc16= variable 4
 250 call writeLineAcc16
 251 ;test6.j(103)     j = 8;
 252 acc8= constant 8
 253 acc8=> variable 4
 254 ;test6.j(104)     j = i - j;
 255 acc16= variable 2
 256 acc16- variable 4
 257 acc16=> variable 4
 258 ;test6.j(105)     println(j);         // 32
 259 acc16= variable 4
 260 call writeLineAcc16
 261 ;test6.j(106)     
 262 ;test6.j(107)     /****************************/
 263 ;test6.j(108)     /* Dual term multiplication */
 264 ;test6.j(109)     /****************************/
 265 ;test6.j(110)     println(3 * 11);    // 33
 266 acc8= constant 3
 267 acc8* constant 11
 268 call writeLineAcc8
 269 ;test6.j(111)     b = 17;
 270 acc8= constant 17
 271 acc8=> variable 0
 272 ;test6.j(112)     println(b * 2);     // 34
 273 acc8= variable 0
 274 acc8* constant 2
 275 call writeLineAcc8
 276 ;test6.j(113)     b = 7;
 277 acc8= constant 7
 278 acc8=> variable 0
 279 ;test6.j(114)     println(5 * b);     // 35
 280 acc8= constant 5
 281 acc8* variable 0
 282 call writeLineAcc8
 283 ;test6.j(115)     b = 2;
 284 acc8= constant 2
 285 acc8=> variable 0
 286 ;test6.j(116)     c = 18;
 287 acc8= constant 18
 288 acc8=> variable 1
 289 ;test6.j(117)     println(b * c);     // 36
 290 acc8= variable 0
 291 acc8* variable 1
 292 call writeLineAcc8
 293 ;test6.j(118)     
 294 ;test6.j(119)     c = 37 * 1;
 295 acc8= constant 37
 296 acc8* constant 1
 297 acc8=> variable 1
 298 ;test6.j(120)     println(c);         // 37
 299 acc8= variable 1
 300 call writeLineAcc8
 301 ;test6.j(121)     b = 2;
 302 acc8= constant 2
 303 acc8=> variable 0
 304 ;test6.j(122)     c = b * 19;
 305 acc8= variable 0
 306 acc8* constant 19
 307 acc8=> variable 1
 308 ;test6.j(123)     println(c);         // 38
 309 acc8= variable 1
 310 call writeLineAcc8
 311 ;test6.j(124)     b = 3;
 312 acc8= constant 3
 313 acc8=> variable 0
 314 ;test6.j(125)     c = 13 * b;
 315 acc8= constant 13
 316 acc8* variable 0
 317 acc8=> variable 1
 318 ;test6.j(126)     println(c);         // 39
 319 acc8= variable 1
 320 call writeLineAcc8
 321 ;test6.j(127)     b = 5;
 322 acc8= constant 5
 323 acc8=> variable 0
 324 ;test6.j(128)     c = 8;
 325 acc8= constant 8
 326 acc8=> variable 1
 327 ;test6.j(129)     c = b * c;
 328 acc8= variable 0
 329 acc8* variable 1
 330 acc8=> variable 1
 331 ;test6.j(130)     println(c);         // 40
 332 acc8= variable 1
 333 call writeLineAcc8
 334 ;test6.j(131)   
 335 ;test6.j(132)     /**********************/
 336 ;test6.j(133)     /* Dual term division */
 337 ;test6.j(134)     /**********************/
 338 ;test6.j(135)     println(123 / 3);   // 41
 339 acc8= constant 123
 340 acc8/ constant 3
 341 call writeLineAcc8
 342 ;test6.j(136)     b = 126;
 343 acc8= constant 126
 344 acc8=> variable 0
 345 ;test6.j(137)     println(b / 3);     // 42
 346 acc8= variable 0
 347 acc8/ constant 3
 348 call writeLineAcc8
 349 ;test6.j(138)     b = 3;
 350 acc8= constant 3
 351 acc8=> variable 0
 352 ;test6.j(139)     println(129 / b);   // 43
 353 acc8= constant 129
 354 acc8/ variable 0
 355 call writeLineAcc8
 356 ;test6.j(140)     b = 132;
 357 acc8= constant 132
 358 acc8=> variable 0
 359 ;test6.j(141)     c = 3;
 360 acc8= constant 3
 361 acc8=> variable 1
 362 ;test6.j(142)     println(b / c);     // 44
 363 acc8= variable 0
 364 acc8/ variable 1
 365 call writeLineAcc8
 366 ;test6.j(143)     
 367 ;test6.j(144)     c = 135 / 3;
 368 acc8= constant 135
 369 acc8/ constant 3
 370 acc8=> variable 1
 371 ;test6.j(145)     println(c);         // 45
 372 acc8= variable 1
 373 call writeLineAcc8
 374 ;test6.j(146)     b = 138;
 375 acc8= constant 138
 376 acc8=> variable 0
 377 ;test6.j(147)     c = b / 3;
 378 acc8= variable 0
 379 acc8/ constant 3
 380 acc8=> variable 1
 381 ;test6.j(148)     println(c);         // 46
 382 acc8= variable 1
 383 call writeLineAcc8
 384 ;test6.j(149)     b = 3;
 385 acc8= constant 3
 386 acc8=> variable 0
 387 ;test6.j(150)     c = 141 / b;
 388 acc8= constant 141
 389 acc8/ variable 0
 390 acc8=> variable 1
 391 ;test6.j(151)     println(c);         // 47
 392 acc8= variable 1
 393 call writeLineAcc8
 394 ;test6.j(152)     b = 144;
 395 acc8= constant 144
 396 acc8=> variable 0
 397 ;test6.j(153)     c = 3;
 398 acc8= constant 3
 399 acc8=> variable 1
 400 ;test6.j(154)     c = b / c;
 401 acc8= variable 0
 402 acc8/ variable 1
 403 acc8=> variable 1
 404 ;test6.j(155)     println(c);         // 48
 405 acc8= variable 1
 406 call writeLineAcc8
 407 ;test6.j(156)   
 408 ;test6.j(157)     /*************************/
 409 ;test6.j(158)     /* possible loss of data */
 410 ;test6.j(159)     /*************************/
 411 ;test6.j(160)     println("Nu komen 251 en 252");
 412 acc16= constant 900
 413 writeLineString
 414 ;test6.j(161)     b = 507;
 415 acc16= constant 507
 416 acc16=> variable 0
 417 ;test6.j(162)     println(b);         // 251
 418 acc8= variable 0
 419 call writeLineAcc8
 420 ;test6.j(163)     i = 508;
 421 acc16= constant 508
 422 acc16=> variable 2
 423 ;test6.j(164)     b = i;
 424 acc16= variable 2
 425 acc16=> variable 0
 426 ;test6.j(165)     println(b);         // 252
 427 acc8= variable 0
 428 call writeLineAcc8
 429 ;test6.j(166)   
 430 ;test6.j(167)     println("Nu komen -253 en -254");
 431 acc16= constant 901
 432 writeLineString
 433 ;test6.j(168)     b = b - 505;
 434 acc8= variable 0
 435 acc8ToAcc16
 436 acc16- constant 505
 437 acc16=> variable 0
 438 ;test6.j(169)     println(b);         // 252 - 505 = -253
 439 acc8= variable 0
 440 call writeLineAcc8
 441 ;test6.j(170)     i = i + 5;
 442 acc16= variable 2
 443 acc16+ constant 5
 444 acc16=> variable 2
 445 ;test6.j(171)     b = b - i;
 446 acc8= variable 0
 447 acc8ToAcc16
 448 acc16- variable 2
 449 acc16=> variable 0
 450 ;test6.j(172)     println(b);         // -233 - 11 = -254
 451 acc8= variable 0
 452 call writeLineAcc8
 453 ;test6.j(173)     
 454 ;test6.j(174)     println("Nu komen 255 en 256");
 455 acc16= constant 902
 456 writeLineString
 457 ;test6.j(175)     b = 255;
 458 acc8= constant 255
 459 acc8=> variable 0
 460 ;test6.j(176)     println(b);         // 255
 461 acc8= variable 0
 462 call writeLineAcc8
 463 ;test6.j(177)     //LD    A,255
 464 ;test6.j(178)     //LD    (04001H),A
 465 ;test6.j(179)     //LD    A,(04001H)
 466 ;test6.j(180)     //CALL  writeA
 467 ;test6.j(181)     //OK
 468 ;test6.j(182)   
 469 ;test6.j(183)     /**********************/
 470 ;test6.j(184)     /* Single term 16-bit */
 471 ;test6.j(185)     /**********************/
 472 ;test6.j(186)     i = 256;
 473 acc16= constant 256
 474 acc16=> variable 2
 475 ;test6.j(187)     println(i);         // 256
 476 acc16= variable 2
 477 call writeLineAcc16
 478 ;test6.j(188)     //LD    HL,256
 479 ;test6.j(189)     //LD    (04006H),HL
 480 ;test6.j(190)     //LD    HL,(04006H)
 481 ;test6.j(191)     //CALL  writeHL
 482 ;test6.j(192)     //OK
 483 ;test6.j(193)   
 484 ;test6.j(194)     println("Nu komen 1000..1047");
 485 acc16= constant 903
 486 writeLineString
 487 ;test6.j(195)     println(1000);      // 1000
 488 acc16= constant 1000
 489 call writeLineAcc16
 490 ;test6.j(196)     j = 1001;
 491 acc16= constant 1001
 492 acc16=> variable 4
 493 ;test6.j(197)     println(j);         // 1001
 494 acc16= variable 4
 495 call writeLineAcc16
 496 ;test6.j(198)   
 497 ;test6.j(199)     /************************/
 498 ;test6.j(200)     /* Dual term addition   */
 499 ;test6.j(201)     /************************/
 500 ;test6.j(202)     println(1000 + 2);  // 1002
 501 acc16= constant 1000
 502 acc16+ constant 2
 503 call writeLineAcc16
 504 ;test6.j(203)     println(3 + 1000);  // 1003
 505 acc8= constant 3
 506 acc8ToAcc16
 507 acc16+ constant 1000
 508 call writeLineAcc16
 509 ;test6.j(204)     println(500 + 504); // 1004
 510 acc16= constant 500
 511 acc16+ constant 504
 512 call writeLineAcc16
 513 ;test6.j(205)     i = 1000 + 5;
 514 acc16= constant 1000
 515 acc16+ constant 5
 516 acc16=> variable 2
 517 ;test6.j(206)     println(i);         // 1005
 518 acc16= variable 2
 519 call writeLineAcc16
 520 ;test6.j(207)     i = 6 + 1000;
 521 acc8= constant 6
 522 acc8ToAcc16
 523 acc16+ constant 1000
 524 acc16=> variable 2
 525 ;test6.j(208)     println(i);         // 1006
 526 acc16= variable 2
 527 call writeLineAcc16
 528 ;test6.j(209)     i = 500 + 507;
 529 acc16= constant 500
 530 acc16+ constant 507
 531 acc16=> variable 2
 532 ;test6.j(210)     println(i);         // 1007
 533 acc16= variable 2
 534 call writeLineAcc16
 535 ;test6.j(211)     
 536 ;test6.j(212)     j = 1000;
 537 acc16= constant 1000
 538 acc16=> variable 4
 539 ;test6.j(213)     b = 10;
 540 acc8= constant 10
 541 acc8=> variable 0
 542 ;test6.j(214)     i = 514;
 543 acc16= constant 514
 544 acc16=> variable 2
 545 ;test6.j(215)     println(j + 8);     // 1008
 546 acc16= variable 4
 547 acc16+ constant 8
 548 call writeLineAcc16
 549 ;test6.j(216)     println(9 + j);     // 1009
 550 acc8= constant 9
 551 acc8ToAcc16
 552 acc16+ variable 4
 553 call writeLineAcc16
 554 ;test6.j(217)     println(j + b);     // 1010
 555 acc16= variable 4
 556 acc16+ variable 0
 557 call writeLineAcc16
 558 ;test6.j(218)     b++;
 559 incr8 variable 0
 560 ;test6.j(219)     println(b + j);     // 1011
 561 acc8= variable 0
 562 acc8ToAcc16
 563 acc16+ variable 4
 564 call writeLineAcc16
 565 ;test6.j(220)     j = 500;
 566 acc16= constant 500
 567 acc16=> variable 4
 568 ;test6.j(221)     println(j + 512);   // 1012
 569 acc16= variable 4
 570 acc16+ constant 512
 571 call writeLineAcc16
 572 ;test6.j(222)     println(513 + j);   // 1013
 573 acc16= constant 513
 574 acc16+ variable 4
 575 call writeLineAcc16
 576 ;test6.j(223)     println(i + j);     // 1014
 577 acc16= variable 2
 578 acc16+ variable 4
 579 call writeLineAcc16
 580 ;test6.j(224)     
 581 ;test6.j(225)     j = 1000;
 582 acc16= constant 1000
 583 acc16=> variable 4
 584 ;test6.j(226)     b = 17;
 585 acc8= constant 17
 586 acc8=> variable 0
 587 ;test6.j(227)     i = j + 15;
 588 acc16= variable 4
 589 acc16+ constant 15
 590 acc16=> variable 2
 591 ;test6.j(228)     println(i);         // 1015
 592 acc16= variable 2
 593 call writeLineAcc16
 594 ;test6.j(229)     i = 16 + j;
 595 acc8= constant 16
 596 acc8ToAcc16
 597 acc16+ variable 4
 598 acc16=> variable 2
 599 ;test6.j(230)     println(i);         // 1016
 600 acc16= variable 2
 601 call writeLineAcc16
 602 ;test6.j(231)     i = j + b;
 603 acc16= variable 4
 604 acc16+ variable 0
 605 acc16=> variable 2
 606 ;test6.j(232)     println(i);         // 1017
 607 acc16= variable 2
 608 call writeLineAcc16
 609 ;test6.j(233)     b++;
 610 incr8 variable 0
 611 ;test6.j(234)     i = b + j;
 612 acc8= variable 0
 613 acc8ToAcc16
 614 acc16+ variable 4
 615 acc16=> variable 2
 616 ;test6.j(235)     println(i);         // 1018
 617 acc16= variable 2
 618 call writeLineAcc16
 619 ;test6.j(236)     j = 500;
 620 acc16= constant 500
 621 acc16=> variable 4
 622 ;test6.j(237)     i = j + 519;
 623 acc16= variable 4
 624 acc16+ constant 519
 625 acc16=> variable 2
 626 ;test6.j(238)     println(i);         // 1019
 627 acc16= variable 2
 628 call writeLineAcc16
 629 ;test6.j(239)     i = 520 + j;
 630 acc16= constant 520
 631 acc16+ variable 4
 632 acc16=> variable 2
 633 ;test6.j(240)     println(i);         // 1020
 634 acc16= variable 2
 635 call writeLineAcc16
 636 ;test6.j(241)     i = 521;
 637 acc16= constant 521
 638 acc16=> variable 2
 639 ;test6.j(242)     i = i + j;
 640 acc16= variable 2
 641 acc16+ variable 4
 642 acc16=> variable 2
 643 ;test6.j(243)     println(i);         // 1021
 644 acc16= variable 2
 645 call writeLineAcc16
 646 ;test6.j(244)     
 647 ;test6.j(245)     /*************************/
 648 ;test6.j(246)     /* Dual term subtraction */
 649 ;test6.j(247)     /*************************/
 650 ;test6.j(248)     println(1024 - 2);  // 1022
 651 acc16= constant 1024
 652 acc16- constant 2
 653 call writeLineAcc16
 654 ;test6.j(249)     println(1523 - 500);// 1023
 655 acc16= constant 1523
 656 acc16- constant 500
 657 call writeLineAcc16
 658 ;test6.j(250)     i = 1030 - 6;
 659 acc16= constant 1030
 660 acc16- constant 6
 661 acc16=> variable 2
 662 ;test6.j(251)     println(i);         // 1024
 663 acc16= variable 2
 664 call writeLineAcc16
 665 ;test6.j(252)     i = 1525 - 500;
 666 acc16= constant 1525
 667 acc16- constant 500
 668 acc16=> variable 2
 669 ;test6.j(253)     println(i);         // 1025
 670 acc16= variable 2
 671 call writeLineAcc16
 672 ;test6.j(254)     
 673 ;test6.j(255)     j = 1040;
 674 acc16= constant 1040
 675 acc16=> variable 4
 676 ;test6.j(256)     b = 13;
 677 acc8= constant 13
 678 acc8=> variable 0
 679 ;test6.j(257)     i = 3030;
 680 acc16= constant 3030
 681 acc16=> variable 2
 682 ;test6.j(258)     println(j - 14);    // 1026
 683 acc16= variable 4
 684 acc16- constant 14
 685 call writeLineAcc16
 686 ;test6.j(259)     println(j - b);     // 1027
 687 acc16= variable 4
 688 acc16- variable 0
 689 call writeLineAcc16
 690 ;test6.j(260)     j = 2000;
 691 acc16= constant 2000
 692 acc16=> variable 4
 693 ;test6.j(261)     println(j - 972);   // 1028
 694 acc16= variable 4
 695 acc16- constant 972
 696 call writeLineAcc16
 697 ;test6.j(262)     println(3029 - j);  // 1029
 698 acc16= constant 3029
 699 acc16- variable 4
 700 call writeLineAcc16
 701 ;test6.j(263)     println(i - j);     // 1030
 702 acc16= variable 2
 703 acc16- variable 4
 704 call writeLineAcc16
 705 ;test6.j(264)     
 706 ;test6.j(265)     j = 1050;
 707 acc16= constant 1050
 708 acc16=> variable 4
 709 ;test6.j(266)     b = 18;
 710 acc8= constant 18
 711 acc8=> variable 0
 712 ;test6.j(267)     i = j - 19;
 713 acc16= variable 4
 714 acc16- constant 19
 715 acc16=> variable 2
 716 ;test6.j(268)     println(i);         // 1031
 717 acc16= variable 2
 718 call writeLineAcc16
 719 ;test6.j(269)     i = j - b;
 720 acc16= variable 4
 721 acc16- variable 0
 722 acc16=> variable 2
 723 ;test6.j(270)     println(i);         // 1032
 724 acc16= variable 2
 725 call writeLineAcc16
 726 ;test6.j(271)     j = 2000;
 727 acc16= constant 2000
 728 acc16=> variable 4
 729 ;test6.j(272)     i = j - 967;
 730 acc16= variable 4
 731 acc16- constant 967
 732 acc16=> variable 2
 733 ;test6.j(273)     println(i);         // 1033
 734 acc16= variable 2
 735 call writeLineAcc16
 736 ;test6.j(274)     i = 3034 - j;
 737 acc16= constant 3034
 738 acc16- variable 4
 739 acc16=> variable 2
 740 ;test6.j(275)     println(i);         // 1034
 741 acc16= variable 2
 742 call writeLineAcc16
 743 ;test6.j(276)     i = 3035;
 744 acc16= constant 3035
 745 acc16=> variable 2
 746 ;test6.j(277)     i = i - j;
 747 acc16= variable 2
 748 acc16- variable 4
 749 acc16=> variable 2
 750 ;test6.j(278)     println(i);         // 1035
 751 acc16= variable 2
 752 call writeLineAcc16
 753 ;test6.j(279)     
 754 ;test6.j(280)     /****************************/
 755 ;test6.j(281)     /* Dual term multiplication */
 756 ;test6.j(282)     /****************************/
 757 ;test6.j(283)     println(518 * 2);   // 1036
 758 acc16= constant 518
 759 acc16* constant 2
 760 call writeLineAcc16
 761 ;test6.j(284)     println(1 * 1037);  // 1037
 762 acc8= constant 1
 763 acc8ToAcc16
 764 acc16* constant 1037
 765 call writeLineAcc16
 766 ;test6.j(285)     println(500 * 504 - 54354); // 1038 = 55392 - 54354
 767 acc16= constant 500
 768 acc16* constant 504
 769 acc16- constant 54354
 770 call writeLineAcc16
 771 ;test6.j(286)   
 772 ;test6.j(287)     i = 1039 * 1;
 773 acc16= constant 1039
 774 acc16* constant 1
 775 acc16=> variable 2
 776 ;test6.j(288)     println(i);         // 1039
 777 acc16= variable 2
 778 call writeLineAcc16
 779 ;test6.j(289)     i = 2 * 520;
 780 acc8= constant 2
 781 acc8ToAcc16
 782 acc16* constant 520
 783 acc16=> variable 2
 784 ;test6.j(290)     println(i);         // 1040
 785 acc16= variable 2
 786 call writeLineAcc16
 787 ;test6.j(291)   
 788 ;test6.j(292)     i = 1041;
 789 acc16= constant 1041
 790 acc16=> variable 2
 791 ;test6.j(293)     println(i * 1);     // 1041
 792 acc16= variable 2
 793 acc16* constant 1
 794 call writeLineAcc16
 795 ;test6.j(294)     i = 521;
 796 acc16= constant 521
 797 acc16=> variable 2
 798 ;test6.j(295)     println(2 * i);     // 1042
 799 acc8= constant 2
 800 acc8ToAcc16
 801 acc16* variable 2
 802 call writeLineAcc16
 803 ;test6.j(296)   
 804 ;test6.j(297)     i = 1043;
 805 acc16= constant 1043
 806 acc16=> variable 2
 807 ;test6.j(298)     i = i * 1;
 808 acc16= variable 2
 809 acc16* constant 1
 810 acc16=> variable 2
 811 ;test6.j(299)     println(i);         // 1043
 812 acc16= variable 2
 813 call writeLineAcc16
 814 ;test6.j(300)     i = 522;
 815 acc16= constant 522
 816 acc16=> variable 2
 817 ;test6.j(301)     i = 2 * i;
 818 acc8= constant 2
 819 acc8ToAcc16
 820 acc16* variable 2
 821 acc16=> variable 2
 822 ;test6.j(302)     println(i);         // 1044
 823 acc16= variable 2
 824 call writeLineAcc16
 825 ;test6.j(303)   
 826 ;test6.j(304)     i = 500 * 504 - 54347; // 1045 = 55392 - 54347
 827 acc16= constant 500
 828 acc16* constant 504
 829 acc16- constant 54347
 830 acc16=> variable 2
 831 ;test6.j(305)     println(i);         // 1045
 832 acc16= variable 2
 833 call writeLineAcc16
 834 ;test6.j(306)     i = 500;
 835 acc16= constant 500
 836 acc16=> variable 2
 837 ;test6.j(307)     i = i * 504 - 54346;
 838 acc16= variable 2
 839 acc16* constant 504
 840 acc16- constant 54346
 841 acc16=> variable 2
 842 ;test6.j(308)     println(i);         // 1046
 843 acc16= variable 2
 844 call writeLineAcc16
 845 ;test6.j(309)     i = 504;
 846 acc16= constant 504
 847 acc16=> variable 2
 848 ;test6.j(310)     i = 500 * i - 54345;
 849 acc16= constant 500
 850 acc16* variable 2
 851 acc16- constant 54345
 852 acc16=> variable 2
 853 ;test6.j(311)     println(i);         // 1047
 854 acc16= variable 2
 855 call writeLineAcc16
 856 ;test6.j(312)     
 857 ;test6.j(313)     /************/
 858 ;test6.j(314)     /* Overflow */
 859 ;test6.j(315)     /************/
 860 ;test6.j(316)     println("Nu komen 24.764 en 25.064");
 861 acc16= constant 904
 862 writeLineString
 863 ;test6.j(317)     println(300 * 301); // 90.300 % 65536 = 24.764
 864 acc16= constant 300
 865 acc16* constant 301
 866 call writeLineAcc16
 867 ;test6.j(318)     i = 300 * 302;
 868 acc16= constant 300
 869 acc16* constant 302
 870 acc16=> variable 2
 871 ;test6.j(319)     println(i);         // 90.600 % 65536 = 25.064
 872 acc16= variable 2
 873 call writeLineAcc16
 874 ;test6.j(320)   
 875 ;test6.j(321)     /***************************/
 876 ;test6.j(322)     /* hex noatation constants */
 877 ;test6.j(323)     /***************************/
 878 ;test6.j(324)     println("hex notation constants");
 879 acc16= constant 905
 880 writeLineString
 881 ;test6.j(325)     byteHex = 0x41;
 882 acc8= constant 65
 883 acc8=> variable 6
 884 ;test6.j(326)     println(byteHex);
 885 acc8= variable 6
 886 call writeLineAcc8
 887 ;test6.j(327)     wordHex = 0x042A;
 888 acc16= constant 1066
 889 acc16=> variable 7
 890 ;test6.j(328)     println(wordHex);
 891 acc16= variable 7
 892 call writeLineAcc16
 893 ;test6.j(329)   
 894 ;test6.j(330)     println("Klaar");
 895 acc16= constant 906
 896 writeLineString
 897 ;test6.j(331)   }
 898 ;test6.j(332) }
 899 stop
 900 stringConstant 0 = "Nu komen 251 en 252"
 901 stringConstant 1 = "Nu komen -253 en -254"
 902 stringConstant 2 = "Nu komen 255 en 256"
 903 stringConstant 3 = "Nu komen 1000..1047"
 904 stringConstant 4 = "Nu komen 24.764 en 25.064"
 905 stringConstant 5 = "hex notation constants"
 906 stringConstant 6 = "Klaar"
