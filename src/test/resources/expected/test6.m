   0 call 16
   1 stop
   2 ;test6.j(0) /*
   3 ;test6.j(1)  * A small program in the miniJava language.
   4 ;test6.j(2)  * Test 8-bit and 16-bit expressions.
   5 ;test6.j(3)  */
   6 ;test6.j(4) class TestExpression {
   7 class TestExpression []
   8 ;test6.j(5)   private static byte b;
   9 ;test6.j(6)   private static byte c;
  10 ;test6.j(7)   private static word i;
  11 ;test6.j(8)   private static word j;
  12 ;test6.j(9)   private static byte byteHex;
  13 ;test6.j(10)   private static word wordHex;
  14 ;test6.j(11) 
  15 ;test6.j(12)   public static void main() {
  16 method main [public, static] void
  17 ;test6.j(13)     println(0);         // 0
  18 acc8= constant 0
  19 call writeLineAcc8
  20 ;test6.j(14)     //LD    A,0
  21 ;test6.j(15)     //CALL  writeA
  22 ;test6.j(16)     //OK
  23 ;test6.j(17)   
  24 ;test6.j(18)     /*********************/
  25 ;test6.j(19)     /* Single term 8-bit */
  26 ;test6.j(20)     /*********************/
  27 ;test6.j(21)     b = 1;
  28 acc8= constant 1
  29 acc8=> variable 0
  30 ;test6.j(22)     c = 4;
  31 acc8= constant 4
  32 acc8=> variable 1
  33 ;test6.j(23)     println(b);         // 1
  34 acc8= variable 0
  35 call writeLineAcc8
  36 ;test6.j(24)     //LD    A,1
  37 ;test6.j(25)     //LD    (04000H),A
  38 ;test6.j(26)     //LD    A,(04000H)
  39 ;test6.j(27)     //CALL  writeA
  40 ;test6.j(28)     //OK
  41 ;test6.j(29)   
  42 ;test6.j(30)     /************************/
  43 ;test6.j(31)     /* Dual term addition   */
  44 ;test6.j(32)     /************************/
  45 ;test6.j(33)     println(0 + 2);     // 2
  46 acc8= constant 0
  47 acc8+ constant 2
  48 call writeLineAcc8
  49 ;test6.j(34)     println(b + 2);     // 3
  50 acc8= variable 0
  51 acc8+ constant 2
  52 call writeLineAcc8
  53 ;test6.j(35)     println(3 + b);     // 4
  54 acc8= constant 3
  55 acc8+ variable 0
  56 call writeLineAcc8
  57 ;test6.j(36)     println(b + c);     // 5
  58 acc8= variable 0
  59 acc8+ variable 1
  60 call writeLineAcc8
  61 ;test6.j(37)   
  62 ;test6.j(38)     c = 4 + 2;
  63 acc8= constant 4
  64 acc8+ constant 2
  65 acc8=> variable 1
  66 ;test6.j(39)     println(c);         // 6
  67 acc8= variable 1
  68 call writeLineAcc8
  69 ;test6.j(40)     c = b + 6;
  70 acc8= variable 0
  71 acc8+ constant 6
  72 acc8=> variable 1
  73 ;test6.j(41)     println(c);         // 7
  74 acc8= variable 1
  75 call writeLineAcc8
  76 ;test6.j(42)     c = 7 + b;
  77 acc8= constant 7
  78 acc8+ variable 0
  79 acc8=> variable 1
  80 ;test6.j(43)     println(c);         // 8
  81 acc8= variable 1
  82 call writeLineAcc8
  83 ;test6.j(44)     c = b + c;
  84 acc8= variable 0
  85 acc8+ variable 1
  86 acc8=> variable 1
  87 ;test6.j(45)     println(c);         // 9
  88 acc8= variable 1
  89 call writeLineAcc8
  90 ;test6.j(46)   
  91 ;test6.j(47)   
  92 ;test6.j(48)     i = 10;
  93 acc8= constant 10
  94 acc8=> variable 2
  95 ;test6.j(49)     println(i);         // 10
  96 acc16= variable 2
  97 call writeLineAcc16
  98 ;test6.j(50)     //LD    A,10
  99 ;test6.j(51)     //LD    L,A
 100 ;test6.j(52)     //LD    H,0
 101 ;test6.j(53)     //LD    (04004H),HL
 102 ;test6.j(54)     //OK
 103 ;test6.j(55)     
 104 ;test6.j(56)     println(i + 1);     // 11
 105 acc16= variable 2
 106 acc16+ constant 1
 107 call writeLineAcc16
 108 ;test6.j(57)     println(2 + i);     // 12
 109 acc8= constant 2
 110 acc8ToAcc16
 111 acc16+ variable 2
 112 call writeLineAcc16
 113 ;test6.j(58)     b = 3;
 114 acc8= constant 3
 115 acc8=> variable 0
 116 ;test6.j(59)     println(i + b);     // 13
 117 acc16= variable 2
 118 acc16+ variable 0
 119 call writeLineAcc16
 120 ;test6.j(60)     b++; //4
 121 incr8 variable 0
 122 ;test6.j(61)     println(b + i);     // 14
 123 acc8= variable 0
 124 acc8ToAcc16
 125 acc16+ variable 2
 126 call writeLineAcc16
 127 ;test6.j(62)   
 128 ;test6.j(63)     j = i + 5;    // 15
 129 acc16= variable 2
 130 acc16+ constant 5
 131 acc16=> variable 4
 132 ;test6.j(64)     println(j);
 133 acc16= variable 4
 134 call writeLineAcc16
 135 ;test6.j(65)     j = 6 + i;        // 16
 136 acc8= constant 6
 137 acc8ToAcc16
 138 acc16+ variable 2
 139 acc16=> variable 4
 140 ;test6.j(66)     println(j);
 141 acc16= variable 4
 142 call writeLineAcc16
 143 ;test6.j(67)     j = 7;
 144 acc8= constant 7
 145 acc8=> variable 4
 146 ;test6.j(68)     j = i + j;        // 17
 147 acc16= variable 2
 148 acc16+ variable 4
 149 acc16=> variable 4
 150 ;test6.j(69)     println(j);
 151 acc16= variable 4
 152 call writeLineAcc16
 153 ;test6.j(70)   
 154 ;test6.j(71)     /*************************/
 155 ;test6.j(72)     /* Dual term subtraction */
 156 ;test6.j(73)     /*************************/
 157 ;test6.j(74)     b = 33;
 158 acc8= constant 33
 159 acc8=> variable 0
 160 ;test6.j(75)     c = 12;
 161 acc8= constant 12
 162 acc8=> variable 1
 163 ;test6.j(76)     println(19 - 1);    // 18
 164 acc8= constant 19
 165 acc8- constant 1
 166 call writeLineAcc8
 167 ;test6.j(77)     println(b - 14);    // 19
 168 acc8= variable 0
 169 acc8- constant 14
 170 call writeLineAcc8
 171 ;test6.j(78)     println(53 - b);    // 20
 172 acc8= constant 53
 173 acc8- variable 0
 174 call writeLineAcc8
 175 ;test6.j(79)     println(b - c);     // 21
 176 acc8= variable 0
 177 acc8- variable 1
 178 call writeLineAcc8
 179 ;test6.j(80)   
 180 ;test6.j(81)     c = 24 - 2;
 181 acc8= constant 24
 182 acc8- constant 2
 183 acc8=> variable 1
 184 ;test6.j(82)     println(c);         // 22
 185 acc8= variable 1
 186 call writeLineAcc8
 187 ;test6.j(83)     c = b - 10;
 188 acc8= variable 0
 189 acc8- constant 10
 190 acc8=> variable 1
 191 ;test6.j(84)     println(c);         // 23
 192 acc8= variable 1
 193 call writeLineAcc8
 194 ;test6.j(85)     c = 57 - b;
 195 acc8= constant 57
 196 acc8- variable 0
 197 acc8=> variable 1
 198 ;test6.j(86)     println(c);         // 24
 199 acc8= variable 1
 200 call writeLineAcc8
 201 ;test6.j(87)     c = 8;
 202 acc8= constant 8
 203 acc8=> variable 1
 204 ;test6.j(88)     c = b - c;
 205 acc8= variable 0
 206 acc8- variable 1
 207 acc8=> variable 1
 208 ;test6.j(89)     println(c);         // 25
 209 acc8= variable 1
 210 call writeLineAcc8
 211 ;test6.j(90)   
 212 ;test6.j(91)     i = 40;
 213 acc8= constant 40
 214 acc8=> variable 2
 215 ;test6.j(92)     println(i - 14);    // 26
 216 acc16= variable 2
 217 acc16- constant 14
 218 call writeLineAcc16
 219 ;test6.j(93)     println(67 - i);    // 27
 220 acc8= constant 67
 221 acc8ToAcc16
 222 acc16- variable 2
 223 call writeLineAcc16
 224 ;test6.j(94)     b = 12;
 225 acc8= constant 12
 226 acc8=> variable 0
 227 ;test6.j(95)     println(i - b);     // 28
 228 acc16= variable 2
 229 acc16- variable 0
 230 call writeLineAcc16
 231 ;test6.j(96)     b = 69;
 232 acc8= constant 69
 233 acc8=> variable 0
 234 ;test6.j(97)     println(b - i);     // 29
 235 acc8= variable 0
 236 acc8ToAcc16
 237 acc16- variable 2
 238 call writeLineAcc16
 239 ;test6.j(98)   
 240 ;test6.j(99)     j = i - 10;
 241 acc16= variable 2
 242 acc16- constant 10
 243 acc16=> variable 4
 244 ;test6.j(100)     println(j);         // 30
 245 acc16= variable 4
 246 call writeLineAcc16
 247 ;test6.j(101)     j = 71 - i;
 248 acc8= constant 71
 249 acc8ToAcc16
 250 acc16- variable 2
 251 acc16=> variable 4
 252 ;test6.j(102)     println(j);         // 31
 253 acc16= variable 4
 254 call writeLineAcc16
 255 ;test6.j(103)     j = 8;
 256 acc8= constant 8
 257 acc8=> variable 4
 258 ;test6.j(104)     j = i - j;
 259 acc16= variable 2
 260 acc16- variable 4
 261 acc16=> variable 4
 262 ;test6.j(105)     println(j);         // 32
 263 acc16= variable 4
 264 call writeLineAcc16
 265 ;test6.j(106)     
 266 ;test6.j(107)     /****************************/
 267 ;test6.j(108)     /* Dual term multiplication */
 268 ;test6.j(109)     /****************************/
 269 ;test6.j(110)     println(3 * 11);    // 33
 270 acc8= constant 3
 271 acc8* constant 11
 272 call writeLineAcc8
 273 ;test6.j(111)     b = 17;
 274 acc8= constant 17
 275 acc8=> variable 0
 276 ;test6.j(112)     println(b * 2);     // 34
 277 acc8= variable 0
 278 acc8* constant 2
 279 call writeLineAcc8
 280 ;test6.j(113)     b = 7;
 281 acc8= constant 7
 282 acc8=> variable 0
 283 ;test6.j(114)     println(5 * b);     // 35
 284 acc8= constant 5
 285 acc8* variable 0
 286 call writeLineAcc8
 287 ;test6.j(115)     b = 2;
 288 acc8= constant 2
 289 acc8=> variable 0
 290 ;test6.j(116)     c = 18;
 291 acc8= constant 18
 292 acc8=> variable 1
 293 ;test6.j(117)     println(b * c);     // 36
 294 acc8= variable 0
 295 acc8* variable 1
 296 call writeLineAcc8
 297 ;test6.j(118)     
 298 ;test6.j(119)     c = 37 * 1;
 299 acc8= constant 37
 300 acc8* constant 1
 301 acc8=> variable 1
 302 ;test6.j(120)     println(c);         // 37
 303 acc8= variable 1
 304 call writeLineAcc8
 305 ;test6.j(121)     b = 2;
 306 acc8= constant 2
 307 acc8=> variable 0
 308 ;test6.j(122)     c = b * 19;
 309 acc8= variable 0
 310 acc8* constant 19
 311 acc8=> variable 1
 312 ;test6.j(123)     println(c);         // 38
 313 acc8= variable 1
 314 call writeLineAcc8
 315 ;test6.j(124)     b = 3;
 316 acc8= constant 3
 317 acc8=> variable 0
 318 ;test6.j(125)     c = 13 * b;
 319 acc8= constant 13
 320 acc8* variable 0
 321 acc8=> variable 1
 322 ;test6.j(126)     println(c);         // 39
 323 acc8= variable 1
 324 call writeLineAcc8
 325 ;test6.j(127)     b = 5;
 326 acc8= constant 5
 327 acc8=> variable 0
 328 ;test6.j(128)     c = 8;
 329 acc8= constant 8
 330 acc8=> variable 1
 331 ;test6.j(129)     c = b * c;
 332 acc8= variable 0
 333 acc8* variable 1
 334 acc8=> variable 1
 335 ;test6.j(130)     println(c);         // 40
 336 acc8= variable 1
 337 call writeLineAcc8
 338 ;test6.j(131)   
 339 ;test6.j(132)     /**********************/
 340 ;test6.j(133)     /* Dual term division */
 341 ;test6.j(134)     /**********************/
 342 ;test6.j(135)     println(123 / 3);   // 41
 343 acc8= constant 123
 344 acc8/ constant 3
 345 call writeLineAcc8
 346 ;test6.j(136)     b = 126;
 347 acc8= constant 126
 348 acc8=> variable 0
 349 ;test6.j(137)     println(b / 3);     // 42
 350 acc8= variable 0
 351 acc8/ constant 3
 352 call writeLineAcc8
 353 ;test6.j(138)     b = 3;
 354 acc8= constant 3
 355 acc8=> variable 0
 356 ;test6.j(139)     println(129 / b);   // 43
 357 acc8= constant 129
 358 acc8/ variable 0
 359 call writeLineAcc8
 360 ;test6.j(140)     b = 132;
 361 acc8= constant 132
 362 acc8=> variable 0
 363 ;test6.j(141)     c = 3;
 364 acc8= constant 3
 365 acc8=> variable 1
 366 ;test6.j(142)     println(b / c);     // 44
 367 acc8= variable 0
 368 acc8/ variable 1
 369 call writeLineAcc8
 370 ;test6.j(143)     
 371 ;test6.j(144)     c = 135 / 3;
 372 acc8= constant 135
 373 acc8/ constant 3
 374 acc8=> variable 1
 375 ;test6.j(145)     println(c);         // 45
 376 acc8= variable 1
 377 call writeLineAcc8
 378 ;test6.j(146)     b = 138;
 379 acc8= constant 138
 380 acc8=> variable 0
 381 ;test6.j(147)     c = b / 3;
 382 acc8= variable 0
 383 acc8/ constant 3
 384 acc8=> variable 1
 385 ;test6.j(148)     println(c);         // 46
 386 acc8= variable 1
 387 call writeLineAcc8
 388 ;test6.j(149)     b = 3;
 389 acc8= constant 3
 390 acc8=> variable 0
 391 ;test6.j(150)     c = 141 / b;
 392 acc8= constant 141
 393 acc8/ variable 0
 394 acc8=> variable 1
 395 ;test6.j(151)     println(c);         // 47
 396 acc8= variable 1
 397 call writeLineAcc8
 398 ;test6.j(152)     b = 144;
 399 acc8= constant 144
 400 acc8=> variable 0
 401 ;test6.j(153)     c = 3;
 402 acc8= constant 3
 403 acc8=> variable 1
 404 ;test6.j(154)     c = b / c;
 405 acc8= variable 0
 406 acc8/ variable 1
 407 acc8=> variable 1
 408 ;test6.j(155)     println(c);         // 48
 409 acc8= variable 1
 410 call writeLineAcc8
 411 ;test6.j(156)   
 412 ;test6.j(157)     /*************************/
 413 ;test6.j(158)     /* possible loss of data */
 414 ;test6.j(159)     /*************************/
 415 ;test6.j(160)     println("Nu komen 251 en 252");
 416 acc16= constant 904
 417 writeLineString
 418 ;test6.j(161)     b = 507;
 419 acc16= constant 507
 420 acc16=> variable 0
 421 ;test6.j(162)     println(b);         // 251
 422 acc8= variable 0
 423 call writeLineAcc8
 424 ;test6.j(163)     i = 508;
 425 acc16= constant 508
 426 acc16=> variable 2
 427 ;test6.j(164)     b = i;
 428 acc16= variable 2
 429 acc16=> variable 0
 430 ;test6.j(165)     println(b);         // 252
 431 acc8= variable 0
 432 call writeLineAcc8
 433 ;test6.j(166)   
 434 ;test6.j(167)     println("Nu komen -253 en -254");
 435 acc16= constant 905
 436 writeLineString
 437 ;test6.j(168)     b = b - 505;
 438 acc8= variable 0
 439 acc8ToAcc16
 440 acc16- constant 505
 441 acc16=> variable 0
 442 ;test6.j(169)     println(b);         // 252 - 505 = -253
 443 acc8= variable 0
 444 call writeLineAcc8
 445 ;test6.j(170)     i = i + 5;
 446 acc16= variable 2
 447 acc16+ constant 5
 448 acc16=> variable 2
 449 ;test6.j(171)     b = b - i;
 450 acc8= variable 0
 451 acc8ToAcc16
 452 acc16- variable 2
 453 acc16=> variable 0
 454 ;test6.j(172)     println(b);         // -233 - 11 = -254
 455 acc8= variable 0
 456 call writeLineAcc8
 457 ;test6.j(173)     
 458 ;test6.j(174)     println("Nu komen 255 en 256");
 459 acc16= constant 906
 460 writeLineString
 461 ;test6.j(175)     b = 255;
 462 acc8= constant 255
 463 acc8=> variable 0
 464 ;test6.j(176)     println(b);         // 255
 465 acc8= variable 0
 466 call writeLineAcc8
 467 ;test6.j(177)     //LD    A,255
 468 ;test6.j(178)     //LD    (04001H),A
 469 ;test6.j(179)     //LD    A,(04001H)
 470 ;test6.j(180)     //CALL  writeA
 471 ;test6.j(181)     //OK
 472 ;test6.j(182)   
 473 ;test6.j(183)     /**********************/
 474 ;test6.j(184)     /* Single term 16-bit */
 475 ;test6.j(185)     /**********************/
 476 ;test6.j(186)     i = 256;
 477 acc16= constant 256
 478 acc16=> variable 2
 479 ;test6.j(187)     println(i);         // 256
 480 acc16= variable 2
 481 call writeLineAcc16
 482 ;test6.j(188)     //LD    HL,256
 483 ;test6.j(189)     //LD    (04006H),HL
 484 ;test6.j(190)     //LD    HL,(04006H)
 485 ;test6.j(191)     //CALL  writeHL
 486 ;test6.j(192)     //OK
 487 ;test6.j(193)   
 488 ;test6.j(194)     println("Nu komen 1000..1047");
 489 acc16= constant 907
 490 writeLineString
 491 ;test6.j(195)     println(1000);      // 1000
 492 acc16= constant 1000
 493 call writeLineAcc16
 494 ;test6.j(196)     j = 1001;
 495 acc16= constant 1001
 496 acc16=> variable 4
 497 ;test6.j(197)     println(j);         // 1001
 498 acc16= variable 4
 499 call writeLineAcc16
 500 ;test6.j(198)   
 501 ;test6.j(199)     /************************/
 502 ;test6.j(200)     /* Dual term addition   */
 503 ;test6.j(201)     /************************/
 504 ;test6.j(202)     println(1000 + 2);  // 1002
 505 acc16= constant 1000
 506 acc16+ constant 2
 507 call writeLineAcc16
 508 ;test6.j(203)     println(3 + 1000);  // 1003
 509 acc8= constant 3
 510 acc8ToAcc16
 511 acc16+ constant 1000
 512 call writeLineAcc16
 513 ;test6.j(204)     println(500 + 504); // 1004
 514 acc16= constant 500
 515 acc16+ constant 504
 516 call writeLineAcc16
 517 ;test6.j(205)     i = 1000 + 5;
 518 acc16= constant 1000
 519 acc16+ constant 5
 520 acc16=> variable 2
 521 ;test6.j(206)     println(i);         // 1005
 522 acc16= variable 2
 523 call writeLineAcc16
 524 ;test6.j(207)     i = 6 + 1000;
 525 acc8= constant 6
 526 acc8ToAcc16
 527 acc16+ constant 1000
 528 acc16=> variable 2
 529 ;test6.j(208)     println(i);         // 1006
 530 acc16= variable 2
 531 call writeLineAcc16
 532 ;test6.j(209)     i = 500 + 507;
 533 acc16= constant 500
 534 acc16+ constant 507
 535 acc16=> variable 2
 536 ;test6.j(210)     println(i);         // 1007
 537 acc16= variable 2
 538 call writeLineAcc16
 539 ;test6.j(211)     
 540 ;test6.j(212)     j = 1000;
 541 acc16= constant 1000
 542 acc16=> variable 4
 543 ;test6.j(213)     b = 10;
 544 acc8= constant 10
 545 acc8=> variable 0
 546 ;test6.j(214)     i = 514;
 547 acc16= constant 514
 548 acc16=> variable 2
 549 ;test6.j(215)     println(j + 8);     // 1008
 550 acc16= variable 4
 551 acc16+ constant 8
 552 call writeLineAcc16
 553 ;test6.j(216)     println(9 + j);     // 1009
 554 acc8= constant 9
 555 acc8ToAcc16
 556 acc16+ variable 4
 557 call writeLineAcc16
 558 ;test6.j(217)     println(j + b);     // 1010
 559 acc16= variable 4
 560 acc16+ variable 0
 561 call writeLineAcc16
 562 ;test6.j(218)     b++;
 563 incr8 variable 0
 564 ;test6.j(219)     println(b + j);     // 1011
 565 acc8= variable 0
 566 acc8ToAcc16
 567 acc16+ variable 4
 568 call writeLineAcc16
 569 ;test6.j(220)     j = 500;
 570 acc16= constant 500
 571 acc16=> variable 4
 572 ;test6.j(221)     println(j + 512);   // 1012
 573 acc16= variable 4
 574 acc16+ constant 512
 575 call writeLineAcc16
 576 ;test6.j(222)     println(513 + j);   // 1013
 577 acc16= constant 513
 578 acc16+ variable 4
 579 call writeLineAcc16
 580 ;test6.j(223)     println(i + j);     // 1014
 581 acc16= variable 2
 582 acc16+ variable 4
 583 call writeLineAcc16
 584 ;test6.j(224)     
 585 ;test6.j(225)     j = 1000;
 586 acc16= constant 1000
 587 acc16=> variable 4
 588 ;test6.j(226)     b = 17;
 589 acc8= constant 17
 590 acc8=> variable 0
 591 ;test6.j(227)     i = j + 15;
 592 acc16= variable 4
 593 acc16+ constant 15
 594 acc16=> variable 2
 595 ;test6.j(228)     println(i);         // 1015
 596 acc16= variable 2
 597 call writeLineAcc16
 598 ;test6.j(229)     i = 16 + j;
 599 acc8= constant 16
 600 acc8ToAcc16
 601 acc16+ variable 4
 602 acc16=> variable 2
 603 ;test6.j(230)     println(i);         // 1016
 604 acc16= variable 2
 605 call writeLineAcc16
 606 ;test6.j(231)     i = j + b;
 607 acc16= variable 4
 608 acc16+ variable 0
 609 acc16=> variable 2
 610 ;test6.j(232)     println(i);         // 1017
 611 acc16= variable 2
 612 call writeLineAcc16
 613 ;test6.j(233)     b++;
 614 incr8 variable 0
 615 ;test6.j(234)     i = b + j;
 616 acc8= variable 0
 617 acc8ToAcc16
 618 acc16+ variable 4
 619 acc16=> variable 2
 620 ;test6.j(235)     println(i);         // 1018
 621 acc16= variable 2
 622 call writeLineAcc16
 623 ;test6.j(236)     j = 500;
 624 acc16= constant 500
 625 acc16=> variable 4
 626 ;test6.j(237)     i = j + 519;
 627 acc16= variable 4
 628 acc16+ constant 519
 629 acc16=> variable 2
 630 ;test6.j(238)     println(i);         // 1019
 631 acc16= variable 2
 632 call writeLineAcc16
 633 ;test6.j(239)     i = 520 + j;
 634 acc16= constant 520
 635 acc16+ variable 4
 636 acc16=> variable 2
 637 ;test6.j(240)     println(i);         // 1020
 638 acc16= variable 2
 639 call writeLineAcc16
 640 ;test6.j(241)     i = 521;
 641 acc16= constant 521
 642 acc16=> variable 2
 643 ;test6.j(242)     i = i + j;
 644 acc16= variable 2
 645 acc16+ variable 4
 646 acc16=> variable 2
 647 ;test6.j(243)     println(i);         // 1021
 648 acc16= variable 2
 649 call writeLineAcc16
 650 ;test6.j(244)     
 651 ;test6.j(245)     /*************************/
 652 ;test6.j(246)     /* Dual term subtraction */
 653 ;test6.j(247)     /*************************/
 654 ;test6.j(248)     println(1024 - 2);  // 1022
 655 acc16= constant 1024
 656 acc16- constant 2
 657 call writeLineAcc16
 658 ;test6.j(249)     println(1523 - 500);// 1023
 659 acc16= constant 1523
 660 acc16- constant 500
 661 call writeLineAcc16
 662 ;test6.j(250)     i = 1030 - 6;
 663 acc16= constant 1030
 664 acc16- constant 6
 665 acc16=> variable 2
 666 ;test6.j(251)     println(i);         // 1024
 667 acc16= variable 2
 668 call writeLineAcc16
 669 ;test6.j(252)     i = 1525 - 500;
 670 acc16= constant 1525
 671 acc16- constant 500
 672 acc16=> variable 2
 673 ;test6.j(253)     println(i);         // 1025
 674 acc16= variable 2
 675 call writeLineAcc16
 676 ;test6.j(254)     
 677 ;test6.j(255)     j = 1040;
 678 acc16= constant 1040
 679 acc16=> variable 4
 680 ;test6.j(256)     b = 13;
 681 acc8= constant 13
 682 acc8=> variable 0
 683 ;test6.j(257)     i = 3030;
 684 acc16= constant 3030
 685 acc16=> variable 2
 686 ;test6.j(258)     println(j - 14);    // 1026
 687 acc16= variable 4
 688 acc16- constant 14
 689 call writeLineAcc16
 690 ;test6.j(259)     println(j - b);     // 1027
 691 acc16= variable 4
 692 acc16- variable 0
 693 call writeLineAcc16
 694 ;test6.j(260)     j = 2000;
 695 acc16= constant 2000
 696 acc16=> variable 4
 697 ;test6.j(261)     println(j - 972);   // 1028
 698 acc16= variable 4
 699 acc16- constant 972
 700 call writeLineAcc16
 701 ;test6.j(262)     println(3029 - j);  // 1029
 702 acc16= constant 3029
 703 acc16- variable 4
 704 call writeLineAcc16
 705 ;test6.j(263)     println(i - j);     // 1030
 706 acc16= variable 2
 707 acc16- variable 4
 708 call writeLineAcc16
 709 ;test6.j(264)     
 710 ;test6.j(265)     j = 1050;
 711 acc16= constant 1050
 712 acc16=> variable 4
 713 ;test6.j(266)     b = 18;
 714 acc8= constant 18
 715 acc8=> variable 0
 716 ;test6.j(267)     i = j - 19;
 717 acc16= variable 4
 718 acc16- constant 19
 719 acc16=> variable 2
 720 ;test6.j(268)     println(i);         // 1031
 721 acc16= variable 2
 722 call writeLineAcc16
 723 ;test6.j(269)     i = j - b;
 724 acc16= variable 4
 725 acc16- variable 0
 726 acc16=> variable 2
 727 ;test6.j(270)     println(i);         // 1032
 728 acc16= variable 2
 729 call writeLineAcc16
 730 ;test6.j(271)     j = 2000;
 731 acc16= constant 2000
 732 acc16=> variable 4
 733 ;test6.j(272)     i = j - 967;
 734 acc16= variable 4
 735 acc16- constant 967
 736 acc16=> variable 2
 737 ;test6.j(273)     println(i);         // 1033
 738 acc16= variable 2
 739 call writeLineAcc16
 740 ;test6.j(274)     i = 3034 - j;
 741 acc16= constant 3034
 742 acc16- variable 4
 743 acc16=> variable 2
 744 ;test6.j(275)     println(i);         // 1034
 745 acc16= variable 2
 746 call writeLineAcc16
 747 ;test6.j(276)     i = 3035;
 748 acc16= constant 3035
 749 acc16=> variable 2
 750 ;test6.j(277)     i = i - j;
 751 acc16= variable 2
 752 acc16- variable 4
 753 acc16=> variable 2
 754 ;test6.j(278)     println(i);         // 1035
 755 acc16= variable 2
 756 call writeLineAcc16
 757 ;test6.j(279)     
 758 ;test6.j(280)     /****************************/
 759 ;test6.j(281)     /* Dual term multiplication */
 760 ;test6.j(282)     /****************************/
 761 ;test6.j(283)     println(518 * 2);   // 1036
 762 acc16= constant 518
 763 acc16* constant 2
 764 call writeLineAcc16
 765 ;test6.j(284)     println(1 * 1037);  // 1037
 766 acc8= constant 1
 767 acc8ToAcc16
 768 acc16* constant 1037
 769 call writeLineAcc16
 770 ;test6.j(285)     println(500 * 504 - 54354); // 1038 = 55392 - 54354
 771 acc16= constant 500
 772 acc16* constant 504
 773 acc16- constant 54354
 774 call writeLineAcc16
 775 ;test6.j(286)   
 776 ;test6.j(287)     i = 1039 * 1;
 777 acc16= constant 1039
 778 acc16* constant 1
 779 acc16=> variable 2
 780 ;test6.j(288)     println(i);         // 1039
 781 acc16= variable 2
 782 call writeLineAcc16
 783 ;test6.j(289)     i = 2 * 520;
 784 acc8= constant 2
 785 acc8ToAcc16
 786 acc16* constant 520
 787 acc16=> variable 2
 788 ;test6.j(290)     println(i);         // 1040
 789 acc16= variable 2
 790 call writeLineAcc16
 791 ;test6.j(291)   
 792 ;test6.j(292)     i = 1041;
 793 acc16= constant 1041
 794 acc16=> variable 2
 795 ;test6.j(293)     println(i * 1);     // 1041
 796 acc16= variable 2
 797 acc16* constant 1
 798 call writeLineAcc16
 799 ;test6.j(294)     i = 521;
 800 acc16= constant 521
 801 acc16=> variable 2
 802 ;test6.j(295)     println(2 * i);     // 1042
 803 acc8= constant 2
 804 acc8ToAcc16
 805 acc16* variable 2
 806 call writeLineAcc16
 807 ;test6.j(296)   
 808 ;test6.j(297)     i = 1043;
 809 acc16= constant 1043
 810 acc16=> variable 2
 811 ;test6.j(298)     i = i * 1;
 812 acc16= variable 2
 813 acc16* constant 1
 814 acc16=> variable 2
 815 ;test6.j(299)     println(i);         // 1043
 816 acc16= variable 2
 817 call writeLineAcc16
 818 ;test6.j(300)     i = 522;
 819 acc16= constant 522
 820 acc16=> variable 2
 821 ;test6.j(301)     i = 2 * i;
 822 acc8= constant 2
 823 acc8ToAcc16
 824 acc16* variable 2
 825 acc16=> variable 2
 826 ;test6.j(302)     println(i);         // 1044
 827 acc16= variable 2
 828 call writeLineAcc16
 829 ;test6.j(303)   
 830 ;test6.j(304)     i = 500 * 504 - 54347; // 1045 = 55392 - 54347
 831 acc16= constant 500
 832 acc16* constant 504
 833 acc16- constant 54347
 834 acc16=> variable 2
 835 ;test6.j(305)     println(i);         // 1045
 836 acc16= variable 2
 837 call writeLineAcc16
 838 ;test6.j(306)     i = 500;
 839 acc16= constant 500
 840 acc16=> variable 2
 841 ;test6.j(307)     i = i * 504 - 54346;
 842 acc16= variable 2
 843 acc16* constant 504
 844 acc16- constant 54346
 845 acc16=> variable 2
 846 ;test6.j(308)     println(i);         // 1046
 847 acc16= variable 2
 848 call writeLineAcc16
 849 ;test6.j(309)     i = 504;
 850 acc16= constant 504
 851 acc16=> variable 2
 852 ;test6.j(310)     i = 500 * i - 54345;
 853 acc16= constant 500
 854 acc16* variable 2
 855 acc16- constant 54345
 856 acc16=> variable 2
 857 ;test6.j(311)     println(i);         // 1047
 858 acc16= variable 2
 859 call writeLineAcc16
 860 ;test6.j(312)     
 861 ;test6.j(313)     /************/
 862 ;test6.j(314)     /* Overflow */
 863 ;test6.j(315)     /************/
 864 ;test6.j(316)     println("Nu komen 24.764 en 25.064");
 865 acc16= constant 908
 866 writeLineString
 867 ;test6.j(317)     println(300 * 301); // 90.300 % 65536 = 24.764
 868 acc16= constant 300
 869 acc16* constant 301
 870 call writeLineAcc16
 871 ;test6.j(318)     i = 300 * 302;
 872 acc16= constant 300
 873 acc16* constant 302
 874 acc16=> variable 2
 875 ;test6.j(319)     println(i);         // 90.600 % 65536 = 25.064
 876 acc16= variable 2
 877 call writeLineAcc16
 878 ;test6.j(320)   
 879 ;test6.j(321)     /***************************/
 880 ;test6.j(322)     /* hex noatation constants */
 881 ;test6.j(323)     /***************************/
 882 ;test6.j(324)     println("hex notation constants");
 883 acc16= constant 909
 884 writeLineString
 885 ;test6.j(325)     byteHex = 0x41;
 886 acc8= constant 65
 887 acc8=> variable 6
 888 ;test6.j(326)     println(byteHex);
 889 acc8= variable 6
 890 call writeLineAcc8
 891 ;test6.j(327)     wordHex = 0x042A;
 892 acc16= constant 1066
 893 acc16=> variable 7
 894 ;test6.j(328)     println(wordHex);
 895 acc16= variable 7
 896 call writeLineAcc16
 897 ;test6.j(329)   
 898 ;test6.j(330)     println("Klaar");
 899 acc16= constant 910
 900 writeLineString
 901 return
 902 ;test6.j(331)   }
 903 ;test6.j(332) }
 904 stringConstant 0 = "Nu komen 251 en 252"
 905 stringConstant 1 = "Nu komen -253 en -254"
 906 stringConstant 2 = "Nu komen 255 en 256"
 907 stringConstant 3 = "Nu komen 1000..1047"
 908 stringConstant 4 = "Nu komen 24.764 en 25.064"
 909 stringConstant 5 = "hex notation constants"
 910 stringConstant 6 = "Klaar"
