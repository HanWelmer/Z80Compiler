   0 ;test6.j(0) /*
   1 ;test6.j(1)  * A small program in the miniJava language.
   2 ;test6.j(2)  * Test 8-bit and 16-bit expressions.
   3 ;test6.j(3)  */
   4 ;test6.j(4) class TestExpression {
   5 class TestExpression []
   6 ;test6.j(5)   private static byte b;
   7 ;test6.j(6)   private static byte c;
   8 ;test6.j(7)   private static word i;
   9 ;test6.j(8)   private static word j;
  10 ;test6.j(9)   private static byte byteHex;
  11 ;test6.j(10)   private static word wordHex;
  12 ;test6.j(11) 
  13 ;test6.j(12)   public static void main() {
  14 method main [public, static] void
  15 ;test6.j(13)     println(0);         // 0
  16 acc8= constant 0
  17 call writeLineAcc8
  18 ;test6.j(14)     //LD    A,0
  19 ;test6.j(15)     //CALL  writeA
  20 ;test6.j(16)     //OK
  21 ;test6.j(17)   
  22 ;test6.j(18)     /*********************/
  23 ;test6.j(19)     /* Single term 8-bit */
  24 ;test6.j(20)     /*********************/
  25 ;test6.j(21)     b = 1;
  26 acc8= constant 1
  27 acc8=> variable 0
  28 ;test6.j(22)     c = 4;
  29 acc8= constant 4
  30 acc8=> variable 1
  31 ;test6.j(23)     println(b);         // 1
  32 acc8= variable 0
  33 call writeLineAcc8
  34 ;test6.j(24)     //LD    A,1
  35 ;test6.j(25)     //LD    (04000H),A
  36 ;test6.j(26)     //LD    A,(04000H)
  37 ;test6.j(27)     //CALL  writeA
  38 ;test6.j(28)     //OK
  39 ;test6.j(29)   
  40 ;test6.j(30)     /************************/
  41 ;test6.j(31)     /* Dual term addition   */
  42 ;test6.j(32)     /************************/
  43 ;test6.j(33)     println(0 + 2);     // 2
  44 acc8= constant 0
  45 acc8+ constant 2
  46 call writeLineAcc8
  47 ;test6.j(34)     println(b + 2);     // 3
  48 acc8= variable 0
  49 acc8+ constant 2
  50 call writeLineAcc8
  51 ;test6.j(35)     println(3 + b);     // 4
  52 acc8= constant 3
  53 acc8+ variable 0
  54 call writeLineAcc8
  55 ;test6.j(36)     println(b + c);     // 5
  56 acc8= variable 0
  57 acc8+ variable 1
  58 call writeLineAcc8
  59 ;test6.j(37)   
  60 ;test6.j(38)     c = 4 + 2;
  61 acc8= constant 4
  62 acc8+ constant 2
  63 acc8=> variable 1
  64 ;test6.j(39)     println(c);         // 6
  65 acc8= variable 1
  66 call writeLineAcc8
  67 ;test6.j(40)     c = b + 6;
  68 acc8= variable 0
  69 acc8+ constant 6
  70 acc8=> variable 1
  71 ;test6.j(41)     println(c);         // 7
  72 acc8= variable 1
  73 call writeLineAcc8
  74 ;test6.j(42)     c = 7 + b;
  75 acc8= constant 7
  76 acc8+ variable 0
  77 acc8=> variable 1
  78 ;test6.j(43)     println(c);         // 8
  79 acc8= variable 1
  80 call writeLineAcc8
  81 ;test6.j(44)     c = b + c;
  82 acc8= variable 0
  83 acc8+ variable 1
  84 acc8=> variable 1
  85 ;test6.j(45)     println(c);         // 9
  86 acc8= variable 1
  87 call writeLineAcc8
  88 ;test6.j(46)   
  89 ;test6.j(47)   
  90 ;test6.j(48)     i = 10;
  91 acc8= constant 10
  92 acc8=> variable 2
  93 ;test6.j(49)     println(i);         // 10
  94 acc16= variable 2
  95 call writeLineAcc16
  96 ;test6.j(50)     //LD    A,10
  97 ;test6.j(51)     //LD    L,A
  98 ;test6.j(52)     //LD    H,0
  99 ;test6.j(53)     //LD    (04004H),HL
 100 ;test6.j(54)     //OK
 101 ;test6.j(55)     
 102 ;test6.j(56)     println(i + 1);     // 11
 103 acc16= variable 2
 104 acc16+ constant 1
 105 call writeLineAcc16
 106 ;test6.j(57)     println(2 + i);     // 12
 107 acc8= constant 2
 108 acc8ToAcc16
 109 acc16+ variable 2
 110 call writeLineAcc16
 111 ;test6.j(58)     b = 3;
 112 acc8= constant 3
 113 acc8=> variable 0
 114 ;test6.j(59)     println(i + b);     // 13
 115 acc16= variable 2
 116 acc16+ variable 0
 117 call writeLineAcc16
 118 ;test6.j(60)     b++; //4
 119 incr8 variable 0
 120 ;test6.j(61)     println(b + i);     // 14
 121 acc8= variable 0
 122 acc8ToAcc16
 123 acc16+ variable 2
 124 call writeLineAcc16
 125 ;test6.j(62)   
 126 ;test6.j(63)     j = i + 5;    // 15
 127 acc16= variable 2
 128 acc16+ constant 5
 129 acc16=> variable 4
 130 ;test6.j(64)     println(j);
 131 acc16= variable 4
 132 call writeLineAcc16
 133 ;test6.j(65)     j = 6 + i;        // 16
 134 acc8= constant 6
 135 acc8ToAcc16
 136 acc16+ variable 2
 137 acc16=> variable 4
 138 ;test6.j(66)     println(j);
 139 acc16= variable 4
 140 call writeLineAcc16
 141 ;test6.j(67)     j = 7;
 142 acc8= constant 7
 143 acc8=> variable 4
 144 ;test6.j(68)     j = i + j;        // 17
 145 acc16= variable 2
 146 acc16+ variable 4
 147 acc16=> variable 4
 148 ;test6.j(69)     println(j);
 149 acc16= variable 4
 150 call writeLineAcc16
 151 ;test6.j(70)   
 152 ;test6.j(71)     /*************************/
 153 ;test6.j(72)     /* Dual term subtraction */
 154 ;test6.j(73)     /*************************/
 155 ;test6.j(74)     b = 33;
 156 acc8= constant 33
 157 acc8=> variable 0
 158 ;test6.j(75)     c = 12;
 159 acc8= constant 12
 160 acc8=> variable 1
 161 ;test6.j(76)     println(19 - 1);    // 18
 162 acc8= constant 19
 163 acc8- constant 1
 164 call writeLineAcc8
 165 ;test6.j(77)     println(b - 14);    // 19
 166 acc8= variable 0
 167 acc8- constant 14
 168 call writeLineAcc8
 169 ;test6.j(78)     println(53 - b);    // 20
 170 acc8= constant 53
 171 acc8- variable 0
 172 call writeLineAcc8
 173 ;test6.j(79)     println(b - c);     // 21
 174 acc8= variable 0
 175 acc8- variable 1
 176 call writeLineAcc8
 177 ;test6.j(80)   
 178 ;test6.j(81)     c = 24 - 2;
 179 acc8= constant 24
 180 acc8- constant 2
 181 acc8=> variable 1
 182 ;test6.j(82)     println(c);         // 22
 183 acc8= variable 1
 184 call writeLineAcc8
 185 ;test6.j(83)     c = b - 10;
 186 acc8= variable 0
 187 acc8- constant 10
 188 acc8=> variable 1
 189 ;test6.j(84)     println(c);         // 23
 190 acc8= variable 1
 191 call writeLineAcc8
 192 ;test6.j(85)     c = 57 - b;
 193 acc8= constant 57
 194 acc8- variable 0
 195 acc8=> variable 1
 196 ;test6.j(86)     println(c);         // 24
 197 acc8= variable 1
 198 call writeLineAcc8
 199 ;test6.j(87)     c = 8;
 200 acc8= constant 8
 201 acc8=> variable 1
 202 ;test6.j(88)     c = b - c;
 203 acc8= variable 0
 204 acc8- variable 1
 205 acc8=> variable 1
 206 ;test6.j(89)     println(c);         // 25
 207 acc8= variable 1
 208 call writeLineAcc8
 209 ;test6.j(90)   
 210 ;test6.j(91)     i = 40;
 211 acc8= constant 40
 212 acc8=> variable 2
 213 ;test6.j(92)     println(i - 14);    // 26
 214 acc16= variable 2
 215 acc16- constant 14
 216 call writeLineAcc16
 217 ;test6.j(93)     println(67 - i);    // 27
 218 acc8= constant 67
 219 acc8ToAcc16
 220 acc16- variable 2
 221 call writeLineAcc16
 222 ;test6.j(94)     b = 12;
 223 acc8= constant 12
 224 acc8=> variable 0
 225 ;test6.j(95)     println(i - b);     // 28
 226 acc16= variable 2
 227 acc16- variable 0
 228 call writeLineAcc16
 229 ;test6.j(96)     b = 69;
 230 acc8= constant 69
 231 acc8=> variable 0
 232 ;test6.j(97)     println(b - i);     // 29
 233 acc8= variable 0
 234 acc8ToAcc16
 235 acc16- variable 2
 236 call writeLineAcc16
 237 ;test6.j(98)   
 238 ;test6.j(99)     j = i - 10;
 239 acc16= variable 2
 240 acc16- constant 10
 241 acc16=> variable 4
 242 ;test6.j(100)     println(j);         // 30
 243 acc16= variable 4
 244 call writeLineAcc16
 245 ;test6.j(101)     j = 71 - i;
 246 acc8= constant 71
 247 acc8ToAcc16
 248 acc16- variable 2
 249 acc16=> variable 4
 250 ;test6.j(102)     println(j);         // 31
 251 acc16= variable 4
 252 call writeLineAcc16
 253 ;test6.j(103)     j = 8;
 254 acc8= constant 8
 255 acc8=> variable 4
 256 ;test6.j(104)     j = i - j;
 257 acc16= variable 2
 258 acc16- variable 4
 259 acc16=> variable 4
 260 ;test6.j(105)     println(j);         // 32
 261 acc16= variable 4
 262 call writeLineAcc16
 263 ;test6.j(106)     
 264 ;test6.j(107)     /****************************/
 265 ;test6.j(108)     /* Dual term multiplication */
 266 ;test6.j(109)     /****************************/
 267 ;test6.j(110)     println(3 * 11);    // 33
 268 acc8= constant 3
 269 acc8* constant 11
 270 call writeLineAcc8
 271 ;test6.j(111)     b = 17;
 272 acc8= constant 17
 273 acc8=> variable 0
 274 ;test6.j(112)     println(b * 2);     // 34
 275 acc8= variable 0
 276 acc8* constant 2
 277 call writeLineAcc8
 278 ;test6.j(113)     b = 7;
 279 acc8= constant 7
 280 acc8=> variable 0
 281 ;test6.j(114)     println(5 * b);     // 35
 282 acc8= constant 5
 283 acc8* variable 0
 284 call writeLineAcc8
 285 ;test6.j(115)     b = 2;
 286 acc8= constant 2
 287 acc8=> variable 0
 288 ;test6.j(116)     c = 18;
 289 acc8= constant 18
 290 acc8=> variable 1
 291 ;test6.j(117)     println(b * c);     // 36
 292 acc8= variable 0
 293 acc8* variable 1
 294 call writeLineAcc8
 295 ;test6.j(118)     
 296 ;test6.j(119)     c = 37 * 1;
 297 acc8= constant 37
 298 acc8* constant 1
 299 acc8=> variable 1
 300 ;test6.j(120)     println(c);         // 37
 301 acc8= variable 1
 302 call writeLineAcc8
 303 ;test6.j(121)     b = 2;
 304 acc8= constant 2
 305 acc8=> variable 0
 306 ;test6.j(122)     c = b * 19;
 307 acc8= variable 0
 308 acc8* constant 19
 309 acc8=> variable 1
 310 ;test6.j(123)     println(c);         // 38
 311 acc8= variable 1
 312 call writeLineAcc8
 313 ;test6.j(124)     b = 3;
 314 acc8= constant 3
 315 acc8=> variable 0
 316 ;test6.j(125)     c = 13 * b;
 317 acc8= constant 13
 318 acc8* variable 0
 319 acc8=> variable 1
 320 ;test6.j(126)     println(c);         // 39
 321 acc8= variable 1
 322 call writeLineAcc8
 323 ;test6.j(127)     b = 5;
 324 acc8= constant 5
 325 acc8=> variable 0
 326 ;test6.j(128)     c = 8;
 327 acc8= constant 8
 328 acc8=> variable 1
 329 ;test6.j(129)     c = b * c;
 330 acc8= variable 0
 331 acc8* variable 1
 332 acc8=> variable 1
 333 ;test6.j(130)     println(c);         // 40
 334 acc8= variable 1
 335 call writeLineAcc8
 336 ;test6.j(131)   
 337 ;test6.j(132)     /**********************/
 338 ;test6.j(133)     /* Dual term division */
 339 ;test6.j(134)     /**********************/
 340 ;test6.j(135)     println(123 / 3);   // 41
 341 acc8= constant 123
 342 acc8/ constant 3
 343 call writeLineAcc8
 344 ;test6.j(136)     b = 126;
 345 acc8= constant 126
 346 acc8=> variable 0
 347 ;test6.j(137)     println(b / 3);     // 42
 348 acc8= variable 0
 349 acc8/ constant 3
 350 call writeLineAcc8
 351 ;test6.j(138)     b = 3;
 352 acc8= constant 3
 353 acc8=> variable 0
 354 ;test6.j(139)     println(129 / b);   // 43
 355 acc8= constant 129
 356 acc8/ variable 0
 357 call writeLineAcc8
 358 ;test6.j(140)     b = 132;
 359 acc8= constant 132
 360 acc8=> variable 0
 361 ;test6.j(141)     c = 3;
 362 acc8= constant 3
 363 acc8=> variable 1
 364 ;test6.j(142)     println(b / c);     // 44
 365 acc8= variable 0
 366 acc8/ variable 1
 367 call writeLineAcc8
 368 ;test6.j(143)     
 369 ;test6.j(144)     c = 135 / 3;
 370 acc8= constant 135
 371 acc8/ constant 3
 372 acc8=> variable 1
 373 ;test6.j(145)     println(c);         // 45
 374 acc8= variable 1
 375 call writeLineAcc8
 376 ;test6.j(146)     b = 138;
 377 acc8= constant 138
 378 acc8=> variable 0
 379 ;test6.j(147)     c = b / 3;
 380 acc8= variable 0
 381 acc8/ constant 3
 382 acc8=> variable 1
 383 ;test6.j(148)     println(c);         // 46
 384 acc8= variable 1
 385 call writeLineAcc8
 386 ;test6.j(149)     b = 3;
 387 acc8= constant 3
 388 acc8=> variable 0
 389 ;test6.j(150)     c = 141 / b;
 390 acc8= constant 141
 391 acc8/ variable 0
 392 acc8=> variable 1
 393 ;test6.j(151)     println(c);         // 47
 394 acc8= variable 1
 395 call writeLineAcc8
 396 ;test6.j(152)     b = 144;
 397 acc8= constant 144
 398 acc8=> variable 0
 399 ;test6.j(153)     c = 3;
 400 acc8= constant 3
 401 acc8=> variable 1
 402 ;test6.j(154)     c = b / c;
 403 acc8= variable 0
 404 acc8/ variable 1
 405 acc8=> variable 1
 406 ;test6.j(155)     println(c);         // 48
 407 acc8= variable 1
 408 call writeLineAcc8
 409 ;test6.j(156)   
 410 ;test6.j(157)     /*************************/
 411 ;test6.j(158)     /* possible loss of data */
 412 ;test6.j(159)     /*************************/
 413 ;test6.j(160)     println("Nu komen 251 en 252");
 414 acc16= constant 902
 415 writeLineString
 416 ;test6.j(161)     b = 507;
 417 acc16= constant 507
 418 acc16=> variable 0
 419 ;test6.j(162)     println(b);         // 251
 420 acc8= variable 0
 421 call writeLineAcc8
 422 ;test6.j(163)     i = 508;
 423 acc16= constant 508
 424 acc16=> variable 2
 425 ;test6.j(164)     b = i;
 426 acc16= variable 2
 427 acc16=> variable 0
 428 ;test6.j(165)     println(b);         // 252
 429 acc8= variable 0
 430 call writeLineAcc8
 431 ;test6.j(166)   
 432 ;test6.j(167)     println("Nu komen -253 en -254");
 433 acc16= constant 903
 434 writeLineString
 435 ;test6.j(168)     b = b - 505;
 436 acc8= variable 0
 437 acc8ToAcc16
 438 acc16- constant 505
 439 acc16=> variable 0
 440 ;test6.j(169)     println(b);         // 252 - 505 = -253
 441 acc8= variable 0
 442 call writeLineAcc8
 443 ;test6.j(170)     i = i + 5;
 444 acc16= variable 2
 445 acc16+ constant 5
 446 acc16=> variable 2
 447 ;test6.j(171)     b = b - i;
 448 acc8= variable 0
 449 acc8ToAcc16
 450 acc16- variable 2
 451 acc16=> variable 0
 452 ;test6.j(172)     println(b);         // -233 - 11 = -254
 453 acc8= variable 0
 454 call writeLineAcc8
 455 ;test6.j(173)     
 456 ;test6.j(174)     println("Nu komen 255 en 256");
 457 acc16= constant 904
 458 writeLineString
 459 ;test6.j(175)     b = 255;
 460 acc8= constant 255
 461 acc8=> variable 0
 462 ;test6.j(176)     println(b);         // 255
 463 acc8= variable 0
 464 call writeLineAcc8
 465 ;test6.j(177)     //LD    A,255
 466 ;test6.j(178)     //LD    (04001H),A
 467 ;test6.j(179)     //LD    A,(04001H)
 468 ;test6.j(180)     //CALL  writeA
 469 ;test6.j(181)     //OK
 470 ;test6.j(182)   
 471 ;test6.j(183)     /**********************/
 472 ;test6.j(184)     /* Single term 16-bit */
 473 ;test6.j(185)     /**********************/
 474 ;test6.j(186)     i = 256;
 475 acc16= constant 256
 476 acc16=> variable 2
 477 ;test6.j(187)     println(i);         // 256
 478 acc16= variable 2
 479 call writeLineAcc16
 480 ;test6.j(188)     //LD    HL,256
 481 ;test6.j(189)     //LD    (04006H),HL
 482 ;test6.j(190)     //LD    HL,(04006H)
 483 ;test6.j(191)     //CALL  writeHL
 484 ;test6.j(192)     //OK
 485 ;test6.j(193)   
 486 ;test6.j(194)     println("Nu komen 1000..1047");
 487 acc16= constant 905
 488 writeLineString
 489 ;test6.j(195)     println(1000);      // 1000
 490 acc16= constant 1000
 491 call writeLineAcc16
 492 ;test6.j(196)     j = 1001;
 493 acc16= constant 1001
 494 acc16=> variable 4
 495 ;test6.j(197)     println(j);         // 1001
 496 acc16= variable 4
 497 call writeLineAcc16
 498 ;test6.j(198)   
 499 ;test6.j(199)     /************************/
 500 ;test6.j(200)     /* Dual term addition   */
 501 ;test6.j(201)     /************************/
 502 ;test6.j(202)     println(1000 + 2);  // 1002
 503 acc16= constant 1000
 504 acc16+ constant 2
 505 call writeLineAcc16
 506 ;test6.j(203)     println(3 + 1000);  // 1003
 507 acc8= constant 3
 508 acc8ToAcc16
 509 acc16+ constant 1000
 510 call writeLineAcc16
 511 ;test6.j(204)     println(500 + 504); // 1004
 512 acc16= constant 500
 513 acc16+ constant 504
 514 call writeLineAcc16
 515 ;test6.j(205)     i = 1000 + 5;
 516 acc16= constant 1000
 517 acc16+ constant 5
 518 acc16=> variable 2
 519 ;test6.j(206)     println(i);         // 1005
 520 acc16= variable 2
 521 call writeLineAcc16
 522 ;test6.j(207)     i = 6 + 1000;
 523 acc8= constant 6
 524 acc8ToAcc16
 525 acc16+ constant 1000
 526 acc16=> variable 2
 527 ;test6.j(208)     println(i);         // 1006
 528 acc16= variable 2
 529 call writeLineAcc16
 530 ;test6.j(209)     i = 500 + 507;
 531 acc16= constant 500
 532 acc16+ constant 507
 533 acc16=> variable 2
 534 ;test6.j(210)     println(i);         // 1007
 535 acc16= variable 2
 536 call writeLineAcc16
 537 ;test6.j(211)     
 538 ;test6.j(212)     j = 1000;
 539 acc16= constant 1000
 540 acc16=> variable 4
 541 ;test6.j(213)     b = 10;
 542 acc8= constant 10
 543 acc8=> variable 0
 544 ;test6.j(214)     i = 514;
 545 acc16= constant 514
 546 acc16=> variable 2
 547 ;test6.j(215)     println(j + 8);     // 1008
 548 acc16= variable 4
 549 acc16+ constant 8
 550 call writeLineAcc16
 551 ;test6.j(216)     println(9 + j);     // 1009
 552 acc8= constant 9
 553 acc8ToAcc16
 554 acc16+ variable 4
 555 call writeLineAcc16
 556 ;test6.j(217)     println(j + b);     // 1010
 557 acc16= variable 4
 558 acc16+ variable 0
 559 call writeLineAcc16
 560 ;test6.j(218)     b++;
 561 incr8 variable 0
 562 ;test6.j(219)     println(b + j);     // 1011
 563 acc8= variable 0
 564 acc8ToAcc16
 565 acc16+ variable 4
 566 call writeLineAcc16
 567 ;test6.j(220)     j = 500;
 568 acc16= constant 500
 569 acc16=> variable 4
 570 ;test6.j(221)     println(j + 512);   // 1012
 571 acc16= variable 4
 572 acc16+ constant 512
 573 call writeLineAcc16
 574 ;test6.j(222)     println(513 + j);   // 1013
 575 acc16= constant 513
 576 acc16+ variable 4
 577 call writeLineAcc16
 578 ;test6.j(223)     println(i + j);     // 1014
 579 acc16= variable 2
 580 acc16+ variable 4
 581 call writeLineAcc16
 582 ;test6.j(224)     
 583 ;test6.j(225)     j = 1000;
 584 acc16= constant 1000
 585 acc16=> variable 4
 586 ;test6.j(226)     b = 17;
 587 acc8= constant 17
 588 acc8=> variable 0
 589 ;test6.j(227)     i = j + 15;
 590 acc16= variable 4
 591 acc16+ constant 15
 592 acc16=> variable 2
 593 ;test6.j(228)     println(i);         // 1015
 594 acc16= variable 2
 595 call writeLineAcc16
 596 ;test6.j(229)     i = 16 + j;
 597 acc8= constant 16
 598 acc8ToAcc16
 599 acc16+ variable 4
 600 acc16=> variable 2
 601 ;test6.j(230)     println(i);         // 1016
 602 acc16= variable 2
 603 call writeLineAcc16
 604 ;test6.j(231)     i = j + b;
 605 acc16= variable 4
 606 acc16+ variable 0
 607 acc16=> variable 2
 608 ;test6.j(232)     println(i);         // 1017
 609 acc16= variable 2
 610 call writeLineAcc16
 611 ;test6.j(233)     b++;
 612 incr8 variable 0
 613 ;test6.j(234)     i = b + j;
 614 acc8= variable 0
 615 acc8ToAcc16
 616 acc16+ variable 4
 617 acc16=> variable 2
 618 ;test6.j(235)     println(i);         // 1018
 619 acc16= variable 2
 620 call writeLineAcc16
 621 ;test6.j(236)     j = 500;
 622 acc16= constant 500
 623 acc16=> variable 4
 624 ;test6.j(237)     i = j + 519;
 625 acc16= variable 4
 626 acc16+ constant 519
 627 acc16=> variable 2
 628 ;test6.j(238)     println(i);         // 1019
 629 acc16= variable 2
 630 call writeLineAcc16
 631 ;test6.j(239)     i = 520 + j;
 632 acc16= constant 520
 633 acc16+ variable 4
 634 acc16=> variable 2
 635 ;test6.j(240)     println(i);         // 1020
 636 acc16= variable 2
 637 call writeLineAcc16
 638 ;test6.j(241)     i = 521;
 639 acc16= constant 521
 640 acc16=> variable 2
 641 ;test6.j(242)     i = i + j;
 642 acc16= variable 2
 643 acc16+ variable 4
 644 acc16=> variable 2
 645 ;test6.j(243)     println(i);         // 1021
 646 acc16= variable 2
 647 call writeLineAcc16
 648 ;test6.j(244)     
 649 ;test6.j(245)     /*************************/
 650 ;test6.j(246)     /* Dual term subtraction */
 651 ;test6.j(247)     /*************************/
 652 ;test6.j(248)     println(1024 - 2);  // 1022
 653 acc16= constant 1024
 654 acc16- constant 2
 655 call writeLineAcc16
 656 ;test6.j(249)     println(1523 - 500);// 1023
 657 acc16= constant 1523
 658 acc16- constant 500
 659 call writeLineAcc16
 660 ;test6.j(250)     i = 1030 - 6;
 661 acc16= constant 1030
 662 acc16- constant 6
 663 acc16=> variable 2
 664 ;test6.j(251)     println(i);         // 1024
 665 acc16= variable 2
 666 call writeLineAcc16
 667 ;test6.j(252)     i = 1525 - 500;
 668 acc16= constant 1525
 669 acc16- constant 500
 670 acc16=> variable 2
 671 ;test6.j(253)     println(i);         // 1025
 672 acc16= variable 2
 673 call writeLineAcc16
 674 ;test6.j(254)     
 675 ;test6.j(255)     j = 1040;
 676 acc16= constant 1040
 677 acc16=> variable 4
 678 ;test6.j(256)     b = 13;
 679 acc8= constant 13
 680 acc8=> variable 0
 681 ;test6.j(257)     i = 3030;
 682 acc16= constant 3030
 683 acc16=> variable 2
 684 ;test6.j(258)     println(j - 14);    // 1026
 685 acc16= variable 4
 686 acc16- constant 14
 687 call writeLineAcc16
 688 ;test6.j(259)     println(j - b);     // 1027
 689 acc16= variable 4
 690 acc16- variable 0
 691 call writeLineAcc16
 692 ;test6.j(260)     j = 2000;
 693 acc16= constant 2000
 694 acc16=> variable 4
 695 ;test6.j(261)     println(j - 972);   // 1028
 696 acc16= variable 4
 697 acc16- constant 972
 698 call writeLineAcc16
 699 ;test6.j(262)     println(3029 - j);  // 1029
 700 acc16= constant 3029
 701 acc16- variable 4
 702 call writeLineAcc16
 703 ;test6.j(263)     println(i - j);     // 1030
 704 acc16= variable 2
 705 acc16- variable 4
 706 call writeLineAcc16
 707 ;test6.j(264)     
 708 ;test6.j(265)     j = 1050;
 709 acc16= constant 1050
 710 acc16=> variable 4
 711 ;test6.j(266)     b = 18;
 712 acc8= constant 18
 713 acc8=> variable 0
 714 ;test6.j(267)     i = j - 19;
 715 acc16= variable 4
 716 acc16- constant 19
 717 acc16=> variable 2
 718 ;test6.j(268)     println(i);         // 1031
 719 acc16= variable 2
 720 call writeLineAcc16
 721 ;test6.j(269)     i = j - b;
 722 acc16= variable 4
 723 acc16- variable 0
 724 acc16=> variable 2
 725 ;test6.j(270)     println(i);         // 1032
 726 acc16= variable 2
 727 call writeLineAcc16
 728 ;test6.j(271)     j = 2000;
 729 acc16= constant 2000
 730 acc16=> variable 4
 731 ;test6.j(272)     i = j - 967;
 732 acc16= variable 4
 733 acc16- constant 967
 734 acc16=> variable 2
 735 ;test6.j(273)     println(i);         // 1033
 736 acc16= variable 2
 737 call writeLineAcc16
 738 ;test6.j(274)     i = 3034 - j;
 739 acc16= constant 3034
 740 acc16- variable 4
 741 acc16=> variable 2
 742 ;test6.j(275)     println(i);         // 1034
 743 acc16= variable 2
 744 call writeLineAcc16
 745 ;test6.j(276)     i = 3035;
 746 acc16= constant 3035
 747 acc16=> variable 2
 748 ;test6.j(277)     i = i - j;
 749 acc16= variable 2
 750 acc16- variable 4
 751 acc16=> variable 2
 752 ;test6.j(278)     println(i);         // 1035
 753 acc16= variable 2
 754 call writeLineAcc16
 755 ;test6.j(279)     
 756 ;test6.j(280)     /****************************/
 757 ;test6.j(281)     /* Dual term multiplication */
 758 ;test6.j(282)     /****************************/
 759 ;test6.j(283)     println(518 * 2);   // 1036
 760 acc16= constant 518
 761 acc16* constant 2
 762 call writeLineAcc16
 763 ;test6.j(284)     println(1 * 1037);  // 1037
 764 acc8= constant 1
 765 acc8ToAcc16
 766 acc16* constant 1037
 767 call writeLineAcc16
 768 ;test6.j(285)     println(500 * 504 - 54354); // 1038 = 55392 - 54354
 769 acc16= constant 500
 770 acc16* constant 504
 771 acc16- constant 54354
 772 call writeLineAcc16
 773 ;test6.j(286)   
 774 ;test6.j(287)     i = 1039 * 1;
 775 acc16= constant 1039
 776 acc16* constant 1
 777 acc16=> variable 2
 778 ;test6.j(288)     println(i);         // 1039
 779 acc16= variable 2
 780 call writeLineAcc16
 781 ;test6.j(289)     i = 2 * 520;
 782 acc8= constant 2
 783 acc8ToAcc16
 784 acc16* constant 520
 785 acc16=> variable 2
 786 ;test6.j(290)     println(i);         // 1040
 787 acc16= variable 2
 788 call writeLineAcc16
 789 ;test6.j(291)   
 790 ;test6.j(292)     i = 1041;
 791 acc16= constant 1041
 792 acc16=> variable 2
 793 ;test6.j(293)     println(i * 1);     // 1041
 794 acc16= variable 2
 795 acc16* constant 1
 796 call writeLineAcc16
 797 ;test6.j(294)     i = 521;
 798 acc16= constant 521
 799 acc16=> variable 2
 800 ;test6.j(295)     println(2 * i);     // 1042
 801 acc8= constant 2
 802 acc8ToAcc16
 803 acc16* variable 2
 804 call writeLineAcc16
 805 ;test6.j(296)   
 806 ;test6.j(297)     i = 1043;
 807 acc16= constant 1043
 808 acc16=> variable 2
 809 ;test6.j(298)     i = i * 1;
 810 acc16= variable 2
 811 acc16* constant 1
 812 acc16=> variable 2
 813 ;test6.j(299)     println(i);         // 1043
 814 acc16= variable 2
 815 call writeLineAcc16
 816 ;test6.j(300)     i = 522;
 817 acc16= constant 522
 818 acc16=> variable 2
 819 ;test6.j(301)     i = 2 * i;
 820 acc8= constant 2
 821 acc8ToAcc16
 822 acc16* variable 2
 823 acc16=> variable 2
 824 ;test6.j(302)     println(i);         // 1044
 825 acc16= variable 2
 826 call writeLineAcc16
 827 ;test6.j(303)   
 828 ;test6.j(304)     i = 500 * 504 - 54347; // 1045 = 55392 - 54347
 829 acc16= constant 500
 830 acc16* constant 504
 831 acc16- constant 54347
 832 acc16=> variable 2
 833 ;test6.j(305)     println(i);         // 1045
 834 acc16= variable 2
 835 call writeLineAcc16
 836 ;test6.j(306)     i = 500;
 837 acc16= constant 500
 838 acc16=> variable 2
 839 ;test6.j(307)     i = i * 504 - 54346;
 840 acc16= variable 2
 841 acc16* constant 504
 842 acc16- constant 54346
 843 acc16=> variable 2
 844 ;test6.j(308)     println(i);         // 1046
 845 acc16= variable 2
 846 call writeLineAcc16
 847 ;test6.j(309)     i = 504;
 848 acc16= constant 504
 849 acc16=> variable 2
 850 ;test6.j(310)     i = 500 * i - 54345;
 851 acc16= constant 500
 852 acc16* variable 2
 853 acc16- constant 54345
 854 acc16=> variable 2
 855 ;test6.j(311)     println(i);         // 1047
 856 acc16= variable 2
 857 call writeLineAcc16
 858 ;test6.j(312)     
 859 ;test6.j(313)     /************/
 860 ;test6.j(314)     /* Overflow */
 861 ;test6.j(315)     /************/
 862 ;test6.j(316)     println("Nu komen 24.764 en 25.064");
 863 acc16= constant 906
 864 writeLineString
 865 ;test6.j(317)     println(300 * 301); // 90.300 % 65536 = 24.764
 866 acc16= constant 300
 867 acc16* constant 301
 868 call writeLineAcc16
 869 ;test6.j(318)     i = 300 * 302;
 870 acc16= constant 300
 871 acc16* constant 302
 872 acc16=> variable 2
 873 ;test6.j(319)     println(i);         // 90.600 % 65536 = 25.064
 874 acc16= variable 2
 875 call writeLineAcc16
 876 ;test6.j(320)   
 877 ;test6.j(321)     /***************************/
 878 ;test6.j(322)     /* hex noatation constants */
 879 ;test6.j(323)     /***************************/
 880 ;test6.j(324)     println("hex notation constants");
 881 acc16= constant 907
 882 writeLineString
 883 ;test6.j(325)     byteHex = 0x41;
 884 acc8= constant 65
 885 acc8=> variable 6
 886 ;test6.j(326)     println(byteHex);
 887 acc8= variable 6
 888 call writeLineAcc8
 889 ;test6.j(327)     wordHex = 0x042A;
 890 acc16= constant 1066
 891 acc16=> variable 7
 892 ;test6.j(328)     println(wordHex);
 893 acc16= variable 7
 894 call writeLineAcc16
 895 ;test6.j(329)   
 896 ;test6.j(330)     println("Klaar");
 897 acc16= constant 908
 898 writeLineString
 899 ;test6.j(331)   }
 900 ;test6.j(332) }
 901 stop
 902 stringConstant 0 = "Nu komen 251 en 252"
 903 stringConstant 1 = "Nu komen -253 en -254"
 904 stringConstant 2 = "Nu komen 255 en 256"
 905 stringConstant 3 = "Nu komen 1000..1047"
 906 stringConstant 4 = "Nu komen 24.764 en 25.064"
 907 stringConstant 5 = "hex notation constants"
 908 stringConstant 6 = "Klaar"
