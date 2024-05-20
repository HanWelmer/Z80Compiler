   0 call 16
   1 stop
   2 ;testExpression.j(0) /*
   3 ;testExpression.j(1)  * A small program in the miniJava language.
   4 ;testExpression.j(2)  * Test 8-bit and 16-bit expressions.
   5 ;testExpression.j(3)  */
   6 ;testExpression.j(4) class TestExpression {
   7 class TestExpression []
   8 ;testExpression.j(5)   private static byte b;
   9 ;testExpression.j(6)   private static byte c;
  10 ;testExpression.j(7)   private static word i;
  11 ;testExpression.j(8)   private static word j;
  12 ;testExpression.j(9)   private static byte byteHex;
  13 ;testExpression.j(10)   private static word wordHex;
  14 ;testExpression.j(11) 
  15 ;testExpression.j(12)   public static void main() {
  16 method main [public, static] void ()
  17 <basePointer
  18 basePointer= stackPointer
  19 stackPointer+ constant 0
  20 ;testExpression.j(13)     println(0);         // 0
  21 acc8= constant 0
  22 writeLineAcc8
  23 ;testExpression.j(14)     //LD    A,0
  24 ;testExpression.j(15)     //CALL  writeA
  25 ;testExpression.j(16)     //OK
  26 ;testExpression.j(17)   
  27 ;testExpression.j(18)     /*********************/
  28 ;testExpression.j(19)     /* Single term 8-bit */
  29 ;testExpression.j(20)     /*********************/
  30 ;testExpression.j(21)     b = 1;
  31 acc8= constant 1
  32 acc8=> variable 0
  33 ;testExpression.j(22)     c = 4;
  34 acc8= constant 4
  35 acc8=> variable 1
  36 ;testExpression.j(23)     println(b);         // 1
  37 acc8= variable 0
  38 writeLineAcc8
  39 ;testExpression.j(24)     //LD    A,1
  40 ;testExpression.j(25)     //LD    (04000H),A
  41 ;testExpression.j(26)     //LD    A,(04000H)
  42 ;testExpression.j(27)     //CALL  writeA
  43 ;testExpression.j(28)     //OK
  44 ;testExpression.j(29)   
  45 ;testExpression.j(30)     /************************/
  46 ;testExpression.j(31)     /* Dual term addition   */
  47 ;testExpression.j(32)     /************************/
  48 ;testExpression.j(33)     println(0 + 2);     // 2
  49 acc8= constant 0
  50 acc8+ constant 2
  51 writeLineAcc8
  52 ;testExpression.j(34)     println(b + 2);     // 3
  53 acc8= variable 0
  54 acc8+ constant 2
  55 writeLineAcc8
  56 ;testExpression.j(35)     println(3 + b);     // 4
  57 acc8= constant 3
  58 acc8+ variable 0
  59 writeLineAcc8
  60 ;testExpression.j(36)     println(b + c);     // 5
  61 acc8= variable 0
  62 acc8+ variable 1
  63 writeLineAcc8
  64 ;testExpression.j(37)   
  65 ;testExpression.j(38)     c = 4 + 2;
  66 acc8= constant 4
  67 acc8+ constant 2
  68 acc8=> variable 1
  69 ;testExpression.j(39)     println(c);         // 6
  70 acc8= variable 1
  71 writeLineAcc8
  72 ;testExpression.j(40)     c = b + 6;
  73 acc8= variable 0
  74 acc8+ constant 6
  75 acc8=> variable 1
  76 ;testExpression.j(41)     println(c);         // 7
  77 acc8= variable 1
  78 writeLineAcc8
  79 ;testExpression.j(42)     c = 7 + b;
  80 acc8= constant 7
  81 acc8+ variable 0
  82 acc8=> variable 1
  83 ;testExpression.j(43)     println(c);         // 8
  84 acc8= variable 1
  85 writeLineAcc8
  86 ;testExpression.j(44)     c = b + c;
  87 acc8= variable 0
  88 acc8+ variable 1
  89 acc8=> variable 1
  90 ;testExpression.j(45)     println(c);         // 9
  91 acc8= variable 1
  92 writeLineAcc8
  93 ;testExpression.j(46)   
  94 ;testExpression.j(47)   
  95 ;testExpression.j(48)     i = 10;
  96 acc8= constant 10
  97 acc8=> variable 2
  98 ;testExpression.j(49)     println(i);         // 10
  99 acc16= variable 2
 100 writeLineAcc16
 101 ;testExpression.j(50)     //LD    A,10
 102 ;testExpression.j(51)     //LD    L,A
 103 ;testExpression.j(52)     //LD    H,0
 104 ;testExpression.j(53)     //LD    (04004H),HL
 105 ;testExpression.j(54)     //OK
 106 ;testExpression.j(55)     
 107 ;testExpression.j(56)     println(i + 1);     // 11
 108 acc16= variable 2
 109 acc16+ constant 1
 110 writeLineAcc16
 111 ;testExpression.j(57)     println(2 + i);     // 12
 112 acc8= constant 2
 113 acc8ToAcc16
 114 acc16+ variable 2
 115 writeLineAcc16
 116 ;testExpression.j(58)     b = 3;
 117 acc8= constant 3
 118 acc8=> variable 0
 119 ;testExpression.j(59)     println(i + b);     // 13
 120 acc16= variable 2
 121 acc16+ variable 0
 122 writeLineAcc16
 123 ;testExpression.j(60)     b++; //4
 124 incr8 variable 0
 125 ;testExpression.j(61)     println(b + i);     // 14
 126 acc8= variable 0
 127 acc8ToAcc16
 128 acc16+ variable 2
 129 writeLineAcc16
 130 ;testExpression.j(62)   
 131 ;testExpression.j(63)     j = i + 5;    // 15
 132 acc16= variable 2
 133 acc16+ constant 5
 134 acc16=> variable 4
 135 ;testExpression.j(64)     println(j);
 136 acc16= variable 4
 137 writeLineAcc16
 138 ;testExpression.j(65)     j = 6 + i;        // 16
 139 acc8= constant 6
 140 acc8ToAcc16
 141 acc16+ variable 2
 142 acc16=> variable 4
 143 ;testExpression.j(66)     println(j);
 144 acc16= variable 4
 145 writeLineAcc16
 146 ;testExpression.j(67)     j = 7;
 147 acc8= constant 7
 148 acc8=> variable 4
 149 ;testExpression.j(68)     j = i + j;        // 17
 150 acc16= variable 2
 151 acc16+ variable 4
 152 acc16=> variable 4
 153 ;testExpression.j(69)     println(j);
 154 acc16= variable 4
 155 writeLineAcc16
 156 ;testExpression.j(70)   
 157 ;testExpression.j(71)     /*************************/
 158 ;testExpression.j(72)     /* Dual term subtraction */
 159 ;testExpression.j(73)     /*************************/
 160 ;testExpression.j(74)     b = 33;
 161 acc8= constant 33
 162 acc8=> variable 0
 163 ;testExpression.j(75)     c = 12;
 164 acc8= constant 12
 165 acc8=> variable 1
 166 ;testExpression.j(76)     println(19 - 1);    // 18
 167 acc8= constant 19
 168 acc8- constant 1
 169 writeLineAcc8
 170 ;testExpression.j(77)     println(b - 14);    // 19
 171 acc8= variable 0
 172 acc8- constant 14
 173 writeLineAcc8
 174 ;testExpression.j(78)     println(53 - b);    // 20
 175 acc8= constant 53
 176 acc8- variable 0
 177 writeLineAcc8
 178 ;testExpression.j(79)     println(b - c);     // 21
 179 acc8= variable 0
 180 acc8- variable 1
 181 writeLineAcc8
 182 ;testExpression.j(80)   
 183 ;testExpression.j(81)     c = 24 - 2;
 184 acc8= constant 24
 185 acc8- constant 2
 186 acc8=> variable 1
 187 ;testExpression.j(82)     println(c);         // 22
 188 acc8= variable 1
 189 writeLineAcc8
 190 ;testExpression.j(83)     c = b - 10;
 191 acc8= variable 0
 192 acc8- constant 10
 193 acc8=> variable 1
 194 ;testExpression.j(84)     println(c);         // 23
 195 acc8= variable 1
 196 writeLineAcc8
 197 ;testExpression.j(85)     c = 57 - b;
 198 acc8= constant 57
 199 acc8- variable 0
 200 acc8=> variable 1
 201 ;testExpression.j(86)     println(c);         // 24
 202 acc8= variable 1
 203 writeLineAcc8
 204 ;testExpression.j(87)     c = 8;
 205 acc8= constant 8
 206 acc8=> variable 1
 207 ;testExpression.j(88)     c = b - c;
 208 acc8= variable 0
 209 acc8- variable 1
 210 acc8=> variable 1
 211 ;testExpression.j(89)     println(c);         // 25
 212 acc8= variable 1
 213 writeLineAcc8
 214 ;testExpression.j(90)   
 215 ;testExpression.j(91)     i = 40;
 216 acc8= constant 40
 217 acc8=> variable 2
 218 ;testExpression.j(92)     println(i - 14);    // 26
 219 acc16= variable 2
 220 acc16- constant 14
 221 writeLineAcc16
 222 ;testExpression.j(93)     println(67 - i);    // 27
 223 acc8= constant 67
 224 acc8ToAcc16
 225 acc16- variable 2
 226 writeLineAcc16
 227 ;testExpression.j(94)     b = 12;
 228 acc8= constant 12
 229 acc8=> variable 0
 230 ;testExpression.j(95)     println(i - b);     // 28
 231 acc16= variable 2
 232 acc16- variable 0
 233 writeLineAcc16
 234 ;testExpression.j(96)     b = 69;
 235 acc8= constant 69
 236 acc8=> variable 0
 237 ;testExpression.j(97)     println(b - i);     // 29
 238 acc8= variable 0
 239 acc8ToAcc16
 240 acc16- variable 2
 241 writeLineAcc16
 242 ;testExpression.j(98)   
 243 ;testExpression.j(99)     j = i - 10;
 244 acc16= variable 2
 245 acc16- constant 10
 246 acc16=> variable 4
 247 ;testExpression.j(100)     println(j);         // 30
 248 acc16= variable 4
 249 writeLineAcc16
 250 ;testExpression.j(101)     j = 71 - i;
 251 acc8= constant 71
 252 acc8ToAcc16
 253 acc16- variable 2
 254 acc16=> variable 4
 255 ;testExpression.j(102)     println(j);         // 31
 256 acc16= variable 4
 257 writeLineAcc16
 258 ;testExpression.j(103)     j = 8;
 259 acc8= constant 8
 260 acc8=> variable 4
 261 ;testExpression.j(104)     j = i - j;
 262 acc16= variable 2
 263 acc16- variable 4
 264 acc16=> variable 4
 265 ;testExpression.j(105)     println(j);         // 32
 266 acc16= variable 4
 267 writeLineAcc16
 268 ;testExpression.j(106)     
 269 ;testExpression.j(107)     /****************************/
 270 ;testExpression.j(108)     /* Dual term multiplication */
 271 ;testExpression.j(109)     /****************************/
 272 ;testExpression.j(110)     println(3 * 11);    // 33
 273 acc8= constant 3
 274 acc8* constant 11
 275 writeLineAcc8
 276 ;testExpression.j(111)     b = 17;
 277 acc8= constant 17
 278 acc8=> variable 0
 279 ;testExpression.j(112)     println(b * 2);     // 34
 280 acc8= variable 0
 281 acc8* constant 2
 282 writeLineAcc8
 283 ;testExpression.j(113)     b = 7;
 284 acc8= constant 7
 285 acc8=> variable 0
 286 ;testExpression.j(114)     println(5 * b);     // 35
 287 acc8= constant 5
 288 acc8* variable 0
 289 writeLineAcc8
 290 ;testExpression.j(115)     b = 2;
 291 acc8= constant 2
 292 acc8=> variable 0
 293 ;testExpression.j(116)     c = 18;
 294 acc8= constant 18
 295 acc8=> variable 1
 296 ;testExpression.j(117)     println(b * c);     // 36
 297 acc8= variable 0
 298 acc8* variable 1
 299 writeLineAcc8
 300 ;testExpression.j(118)     
 301 ;testExpression.j(119)     c = 37 * 1;
 302 acc8= constant 37
 303 acc8* constant 1
 304 acc8=> variable 1
 305 ;testExpression.j(120)     println(c);         // 37
 306 acc8= variable 1
 307 writeLineAcc8
 308 ;testExpression.j(121)     b = 2;
 309 acc8= constant 2
 310 acc8=> variable 0
 311 ;testExpression.j(122)     c = b * 19;
 312 acc8= variable 0
 313 acc8* constant 19
 314 acc8=> variable 1
 315 ;testExpression.j(123)     println(c);         // 38
 316 acc8= variable 1
 317 writeLineAcc8
 318 ;testExpression.j(124)     b = 3;
 319 acc8= constant 3
 320 acc8=> variable 0
 321 ;testExpression.j(125)     c = 13 * b;
 322 acc8= constant 13
 323 acc8* variable 0
 324 acc8=> variable 1
 325 ;testExpression.j(126)     println(c);         // 39
 326 acc8= variable 1
 327 writeLineAcc8
 328 ;testExpression.j(127)     b = 5;
 329 acc8= constant 5
 330 acc8=> variable 0
 331 ;testExpression.j(128)     c = 8;
 332 acc8= constant 8
 333 acc8=> variable 1
 334 ;testExpression.j(129)     c = b * c;
 335 acc8= variable 0
 336 acc8* variable 1
 337 acc8=> variable 1
 338 ;testExpression.j(130)     println(c);         // 40
 339 acc8= variable 1
 340 writeLineAcc8
 341 ;testExpression.j(131)   
 342 ;testExpression.j(132)     /**********************/
 343 ;testExpression.j(133)     /* Dual term division */
 344 ;testExpression.j(134)     /**********************/
 345 ;testExpression.j(135)     println(123 / 3);   // 41
 346 acc8= constant 123
 347 acc8/ constant 3
 348 writeLineAcc8
 349 ;testExpression.j(136)     b = 126;
 350 acc8= constant 126
 351 acc8=> variable 0
 352 ;testExpression.j(137)     println(b / 3);     // 42
 353 acc8= variable 0
 354 acc8/ constant 3
 355 writeLineAcc8
 356 ;testExpression.j(138)     b = 3;
 357 acc8= constant 3
 358 acc8=> variable 0
 359 ;testExpression.j(139)     println(129 / b);   // 43
 360 acc8= constant 129
 361 acc8/ variable 0
 362 writeLineAcc8
 363 ;testExpression.j(140)     b = 132;
 364 acc8= constant 132
 365 acc8=> variable 0
 366 ;testExpression.j(141)     c = 3;
 367 acc8= constant 3
 368 acc8=> variable 1
 369 ;testExpression.j(142)     println(b / c);     // 44
 370 acc8= variable 0
 371 acc8/ variable 1
 372 writeLineAcc8
 373 ;testExpression.j(143)     
 374 ;testExpression.j(144)     c = 135 / 3;
 375 acc8= constant 135
 376 acc8/ constant 3
 377 acc8=> variable 1
 378 ;testExpression.j(145)     println(c);         // 45
 379 acc8= variable 1
 380 writeLineAcc8
 381 ;testExpression.j(146)     b = 138;
 382 acc8= constant 138
 383 acc8=> variable 0
 384 ;testExpression.j(147)     c = b / 3;
 385 acc8= variable 0
 386 acc8/ constant 3
 387 acc8=> variable 1
 388 ;testExpression.j(148)     println(c);         // 46
 389 acc8= variable 1
 390 writeLineAcc8
 391 ;testExpression.j(149)     b = 3;
 392 acc8= constant 3
 393 acc8=> variable 0
 394 ;testExpression.j(150)     c = 141 / b;
 395 acc8= constant 141
 396 acc8/ variable 0
 397 acc8=> variable 1
 398 ;testExpression.j(151)     println(c);         // 47
 399 acc8= variable 1
 400 writeLineAcc8
 401 ;testExpression.j(152)     b = 144;
 402 acc8= constant 144
 403 acc8=> variable 0
 404 ;testExpression.j(153)     c = 3;
 405 acc8= constant 3
 406 acc8=> variable 1
 407 ;testExpression.j(154)     c = b / c;
 408 acc8= variable 0
 409 acc8/ variable 1
 410 acc8=> variable 1
 411 ;testExpression.j(155)     println(c);         // 48
 412 acc8= variable 1
 413 writeLineAcc8
 414 ;testExpression.j(156)   
 415 ;testExpression.j(157)     /*************************/
 416 ;testExpression.j(158)     /* possible loss of data */
 417 ;testExpression.j(159)     /*************************/
 418 ;testExpression.j(160)     println("Nu komen 251 en 252");
 419 acc16= stringconstant 909
 420 writeLineString
 421 ;testExpression.j(161)     b = 507;
 422 acc16= constant 507
 423 acc16=> variable 0
 424 ;testExpression.j(162)     println(b);         // 251
 425 acc8= variable 0
 426 writeLineAcc8
 427 ;testExpression.j(163)     i = 508;
 428 acc16= constant 508
 429 acc16=> variable 2
 430 ;testExpression.j(164)     b = i;
 431 acc16= variable 2
 432 acc16=> variable 0
 433 ;testExpression.j(165)     println(b);         // 252
 434 acc8= variable 0
 435 writeLineAcc8
 436 ;testExpression.j(166)   
 437 ;testExpression.j(167)     println("Nu komen -253 en -254");
 438 acc16= stringconstant 910
 439 writeLineString
 440 ;testExpression.j(168)     b = b - 505;
 441 acc8= variable 0
 442 acc8ToAcc16
 443 acc16- constant 505
 444 acc16=> variable 0
 445 ;testExpression.j(169)     println(b);         // 252 - 505 = -253
 446 acc8= variable 0
 447 writeLineAcc8
 448 ;testExpression.j(170)     i = i + 5;
 449 acc16= variable 2
 450 acc16+ constant 5
 451 acc16=> variable 2
 452 ;testExpression.j(171)     b = b - i;
 453 acc8= variable 0
 454 acc8ToAcc16
 455 acc16- variable 2
 456 acc16=> variable 0
 457 ;testExpression.j(172)     println(b);         // -233 - 11 = -254
 458 acc8= variable 0
 459 writeLineAcc8
 460 ;testExpression.j(173)     
 461 ;testExpression.j(174)     println("Nu komen 255 en 256");
 462 acc16= stringconstant 911
 463 writeLineString
 464 ;testExpression.j(175)     b = 255;
 465 acc8= constant 255
 466 acc8=> variable 0
 467 ;testExpression.j(176)     println(b);         // 255
 468 acc8= variable 0
 469 writeLineAcc8
 470 ;testExpression.j(177)     //LD    A,255
 471 ;testExpression.j(178)     //LD    (04001H),A
 472 ;testExpression.j(179)     //LD    A,(04001H)
 473 ;testExpression.j(180)     //CALL  writeA
 474 ;testExpression.j(181)     //OK
 475 ;testExpression.j(182)   
 476 ;testExpression.j(183)     /**********************/
 477 ;testExpression.j(184)     /* Single term 16-bit */
 478 ;testExpression.j(185)     /**********************/
 479 ;testExpression.j(186)     i = 256;
 480 acc16= constant 256
 481 acc16=> variable 2
 482 ;testExpression.j(187)     println(i);         // 256
 483 acc16= variable 2
 484 writeLineAcc16
 485 ;testExpression.j(188)     //LD    HL,256
 486 ;testExpression.j(189)     //LD    (04006H),HL
 487 ;testExpression.j(190)     //LD    HL,(04006H)
 488 ;testExpression.j(191)     //CALL  writeHL
 489 ;testExpression.j(192)     //OK
 490 ;testExpression.j(193)   
 491 ;testExpression.j(194)     println("Nu komen 1000..1047");
 492 acc16= stringconstant 912
 493 writeLineString
 494 ;testExpression.j(195)     println(1000);      // 1000
 495 acc16= constant 1000
 496 writeLineAcc16
 497 ;testExpression.j(196)     j = 1001;
 498 acc16= constant 1001
 499 acc16=> variable 4
 500 ;testExpression.j(197)     println(j);         // 1001
 501 acc16= variable 4
 502 writeLineAcc16
 503 ;testExpression.j(198)   
 504 ;testExpression.j(199)     /************************/
 505 ;testExpression.j(200)     /* Dual term addition   */
 506 ;testExpression.j(201)     /************************/
 507 ;testExpression.j(202)     println(1000 + 2);  // 1002
 508 acc16= constant 1000
 509 acc16+ constant 2
 510 writeLineAcc16
 511 ;testExpression.j(203)     println(3 + 1000);  // 1003
 512 acc8= constant 3
 513 acc8ToAcc16
 514 acc16+ constant 1000
 515 writeLineAcc16
 516 ;testExpression.j(204)     println(500 + 504); // 1004
 517 acc16= constant 500
 518 acc16+ constant 504
 519 writeLineAcc16
 520 ;testExpression.j(205)     i = 1000 + 5;
 521 acc16= constant 1000
 522 acc16+ constant 5
 523 acc16=> variable 2
 524 ;testExpression.j(206)     println(i);         // 1005
 525 acc16= variable 2
 526 writeLineAcc16
 527 ;testExpression.j(207)     i = 6 + 1000;
 528 acc8= constant 6
 529 acc8ToAcc16
 530 acc16+ constant 1000
 531 acc16=> variable 2
 532 ;testExpression.j(208)     println(i);         // 1006
 533 acc16= variable 2
 534 writeLineAcc16
 535 ;testExpression.j(209)     i = 500 + 507;
 536 acc16= constant 500
 537 acc16+ constant 507
 538 acc16=> variable 2
 539 ;testExpression.j(210)     println(i);         // 1007
 540 acc16= variable 2
 541 writeLineAcc16
 542 ;testExpression.j(211)     
 543 ;testExpression.j(212)     j = 1000;
 544 acc16= constant 1000
 545 acc16=> variable 4
 546 ;testExpression.j(213)     b = 10;
 547 acc8= constant 10
 548 acc8=> variable 0
 549 ;testExpression.j(214)     i = 514;
 550 acc16= constant 514
 551 acc16=> variable 2
 552 ;testExpression.j(215)     println(j + 8);     // 1008
 553 acc16= variable 4
 554 acc16+ constant 8
 555 writeLineAcc16
 556 ;testExpression.j(216)     println(9 + j);     // 1009
 557 acc8= constant 9
 558 acc8ToAcc16
 559 acc16+ variable 4
 560 writeLineAcc16
 561 ;testExpression.j(217)     println(j + b);     // 1010
 562 acc16= variable 4
 563 acc16+ variable 0
 564 writeLineAcc16
 565 ;testExpression.j(218)     b++;
 566 incr8 variable 0
 567 ;testExpression.j(219)     println(b + j);     // 1011
 568 acc8= variable 0
 569 acc8ToAcc16
 570 acc16+ variable 4
 571 writeLineAcc16
 572 ;testExpression.j(220)     j = 500;
 573 acc16= constant 500
 574 acc16=> variable 4
 575 ;testExpression.j(221)     println(j + 512);   // 1012
 576 acc16= variable 4
 577 acc16+ constant 512
 578 writeLineAcc16
 579 ;testExpression.j(222)     println(513 + j);   // 1013
 580 acc16= constant 513
 581 acc16+ variable 4
 582 writeLineAcc16
 583 ;testExpression.j(223)     println(i + j);     // 1014
 584 acc16= variable 2
 585 acc16+ variable 4
 586 writeLineAcc16
 587 ;testExpression.j(224)     
 588 ;testExpression.j(225)     j = 1000;
 589 acc16= constant 1000
 590 acc16=> variable 4
 591 ;testExpression.j(226)     b = 17;
 592 acc8= constant 17
 593 acc8=> variable 0
 594 ;testExpression.j(227)     i = j + 15;
 595 acc16= variable 4
 596 acc16+ constant 15
 597 acc16=> variable 2
 598 ;testExpression.j(228)     println(i);         // 1015
 599 acc16= variable 2
 600 writeLineAcc16
 601 ;testExpression.j(229)     i = 16 + j;
 602 acc8= constant 16
 603 acc8ToAcc16
 604 acc16+ variable 4
 605 acc16=> variable 2
 606 ;testExpression.j(230)     println(i);         // 1016
 607 acc16= variable 2
 608 writeLineAcc16
 609 ;testExpression.j(231)     i = j + b;
 610 acc16= variable 4
 611 acc16+ variable 0
 612 acc16=> variable 2
 613 ;testExpression.j(232)     println(i);         // 1017
 614 acc16= variable 2
 615 writeLineAcc16
 616 ;testExpression.j(233)     b++;
 617 incr8 variable 0
 618 ;testExpression.j(234)     i = b + j;
 619 acc8= variable 0
 620 acc8ToAcc16
 621 acc16+ variable 4
 622 acc16=> variable 2
 623 ;testExpression.j(235)     println(i);         // 1018
 624 acc16= variable 2
 625 writeLineAcc16
 626 ;testExpression.j(236)     j = 500;
 627 acc16= constant 500
 628 acc16=> variable 4
 629 ;testExpression.j(237)     i = j + 519;
 630 acc16= variable 4
 631 acc16+ constant 519
 632 acc16=> variable 2
 633 ;testExpression.j(238)     println(i);         // 1019
 634 acc16= variable 2
 635 writeLineAcc16
 636 ;testExpression.j(239)     i = 520 + j;
 637 acc16= constant 520
 638 acc16+ variable 4
 639 acc16=> variable 2
 640 ;testExpression.j(240)     println(i);         // 1020
 641 acc16= variable 2
 642 writeLineAcc16
 643 ;testExpression.j(241)     i = 521;
 644 acc16= constant 521
 645 acc16=> variable 2
 646 ;testExpression.j(242)     i = i + j;
 647 acc16= variable 2
 648 acc16+ variable 4
 649 acc16=> variable 2
 650 ;testExpression.j(243)     println(i);         // 1021
 651 acc16= variable 2
 652 writeLineAcc16
 653 ;testExpression.j(244)     
 654 ;testExpression.j(245)     /*************************/
 655 ;testExpression.j(246)     /* Dual term subtraction */
 656 ;testExpression.j(247)     /*************************/
 657 ;testExpression.j(248)     println(1024 - 2);  // 1022
 658 acc16= constant 1024
 659 acc16- constant 2
 660 writeLineAcc16
 661 ;testExpression.j(249)     println(1523 - 500);// 1023
 662 acc16= constant 1523
 663 acc16- constant 500
 664 writeLineAcc16
 665 ;testExpression.j(250)     i = 1030 - 6;
 666 acc16= constant 1030
 667 acc16- constant 6
 668 acc16=> variable 2
 669 ;testExpression.j(251)     println(i);         // 1024
 670 acc16= variable 2
 671 writeLineAcc16
 672 ;testExpression.j(252)     i = 1525 - 500;
 673 acc16= constant 1525
 674 acc16- constant 500
 675 acc16=> variable 2
 676 ;testExpression.j(253)     println(i);         // 1025
 677 acc16= variable 2
 678 writeLineAcc16
 679 ;testExpression.j(254)     
 680 ;testExpression.j(255)     j = 1040;
 681 acc16= constant 1040
 682 acc16=> variable 4
 683 ;testExpression.j(256)     b = 13;
 684 acc8= constant 13
 685 acc8=> variable 0
 686 ;testExpression.j(257)     i = 3030;
 687 acc16= constant 3030
 688 acc16=> variable 2
 689 ;testExpression.j(258)     println(j - 14);    // 1026
 690 acc16= variable 4
 691 acc16- constant 14
 692 writeLineAcc16
 693 ;testExpression.j(259)     println(j - b);     // 1027
 694 acc16= variable 4
 695 acc16- variable 0
 696 writeLineAcc16
 697 ;testExpression.j(260)     j = 2000;
 698 acc16= constant 2000
 699 acc16=> variable 4
 700 ;testExpression.j(261)     println(j - 972);   // 1028
 701 acc16= variable 4
 702 acc16- constant 972
 703 writeLineAcc16
 704 ;testExpression.j(262)     println(3029 - j);  // 1029
 705 acc16= constant 3029
 706 acc16- variable 4
 707 writeLineAcc16
 708 ;testExpression.j(263)     println(i - j);     // 1030
 709 acc16= variable 2
 710 acc16- variable 4
 711 writeLineAcc16
 712 ;testExpression.j(264)     
 713 ;testExpression.j(265)     j = 1050;
 714 acc16= constant 1050
 715 acc16=> variable 4
 716 ;testExpression.j(266)     b = 18;
 717 acc8= constant 18
 718 acc8=> variable 0
 719 ;testExpression.j(267)     i = j - 19;
 720 acc16= variable 4
 721 acc16- constant 19
 722 acc16=> variable 2
 723 ;testExpression.j(268)     println(i);         // 1031
 724 acc16= variable 2
 725 writeLineAcc16
 726 ;testExpression.j(269)     i = j - b;
 727 acc16= variable 4
 728 acc16- variable 0
 729 acc16=> variable 2
 730 ;testExpression.j(270)     println(i);         // 1032
 731 acc16= variable 2
 732 writeLineAcc16
 733 ;testExpression.j(271)     j = 2000;
 734 acc16= constant 2000
 735 acc16=> variable 4
 736 ;testExpression.j(272)     i = j - 967;
 737 acc16= variable 4
 738 acc16- constant 967
 739 acc16=> variable 2
 740 ;testExpression.j(273)     println(i);         // 1033
 741 acc16= variable 2
 742 writeLineAcc16
 743 ;testExpression.j(274)     i = 3034 - j;
 744 acc16= constant 3034
 745 acc16- variable 4
 746 acc16=> variable 2
 747 ;testExpression.j(275)     println(i);         // 1034
 748 acc16= variable 2
 749 writeLineAcc16
 750 ;testExpression.j(276)     i = 3035;
 751 acc16= constant 3035
 752 acc16=> variable 2
 753 ;testExpression.j(277)     i = i - j;
 754 acc16= variable 2
 755 acc16- variable 4
 756 acc16=> variable 2
 757 ;testExpression.j(278)     println(i);         // 1035
 758 acc16= variable 2
 759 writeLineAcc16
 760 ;testExpression.j(279)     
 761 ;testExpression.j(280)     /****************************/
 762 ;testExpression.j(281)     /* Dual term multiplication */
 763 ;testExpression.j(282)     /****************************/
 764 ;testExpression.j(283)     println(518 * 2);   // 1036
 765 acc16= constant 518
 766 acc16* constant 2
 767 writeLineAcc16
 768 ;testExpression.j(284)     println(1 * 1037);  // 1037
 769 acc8= constant 1
 770 acc8ToAcc16
 771 acc16* constant 1037
 772 writeLineAcc16
 773 ;testExpression.j(285)     println(500 * 504 - 54354); // 1038 = 55392 - 54354
 774 acc16= constant 500
 775 acc16* constant 504
 776 acc16- constant 54354
 777 writeLineAcc16
 778 ;testExpression.j(286)   
 779 ;testExpression.j(287)     i = 1039 * 1;
 780 acc16= constant 1039
 781 acc16* constant 1
 782 acc16=> variable 2
 783 ;testExpression.j(288)     println(i);         // 1039
 784 acc16= variable 2
 785 writeLineAcc16
 786 ;testExpression.j(289)     i = 2 * 520;
 787 acc8= constant 2
 788 acc8ToAcc16
 789 acc16* constant 520
 790 acc16=> variable 2
 791 ;testExpression.j(290)     println(i);         // 1040
 792 acc16= variable 2
 793 writeLineAcc16
 794 ;testExpression.j(291)   
 795 ;testExpression.j(292)     i = 1041;
 796 acc16= constant 1041
 797 acc16=> variable 2
 798 ;testExpression.j(293)     println(i * 1);     // 1041
 799 acc16= variable 2
 800 acc16* constant 1
 801 writeLineAcc16
 802 ;testExpression.j(294)     i = 521;
 803 acc16= constant 521
 804 acc16=> variable 2
 805 ;testExpression.j(295)     println(2 * i);     // 1042
 806 acc8= constant 2
 807 acc8ToAcc16
 808 acc16* variable 2
 809 writeLineAcc16
 810 ;testExpression.j(296)   
 811 ;testExpression.j(297)     i = 1043;
 812 acc16= constant 1043
 813 acc16=> variable 2
 814 ;testExpression.j(298)     i = i * 1;
 815 acc16= variable 2
 816 acc16* constant 1
 817 acc16=> variable 2
 818 ;testExpression.j(299)     println(i);         // 1043
 819 acc16= variable 2
 820 writeLineAcc16
 821 ;testExpression.j(300)     i = 522;
 822 acc16= constant 522
 823 acc16=> variable 2
 824 ;testExpression.j(301)     i = 2 * i;
 825 acc8= constant 2
 826 acc8ToAcc16
 827 acc16* variable 2
 828 acc16=> variable 2
 829 ;testExpression.j(302)     println(i);         // 1044
 830 acc16= variable 2
 831 writeLineAcc16
 832 ;testExpression.j(303)   
 833 ;testExpression.j(304)     i = 500 * 504 - 54347; // 1045 = 55392 - 54347
 834 acc16= constant 500
 835 acc16* constant 504
 836 acc16- constant 54347
 837 acc16=> variable 2
 838 ;testExpression.j(305)     println(i);         // 1045
 839 acc16= variable 2
 840 writeLineAcc16
 841 ;testExpression.j(306)     i = 500;
 842 acc16= constant 500
 843 acc16=> variable 2
 844 ;testExpression.j(307)     i = i * 504 - 54346;
 845 acc16= variable 2
 846 acc16* constant 504
 847 acc16- constant 54346
 848 acc16=> variable 2
 849 ;testExpression.j(308)     println(i);         // 1046
 850 acc16= variable 2
 851 writeLineAcc16
 852 ;testExpression.j(309)     i = 504;
 853 acc16= constant 504
 854 acc16=> variable 2
 855 ;testExpression.j(310)     i = 500 * i - 54345;
 856 acc16= constant 500
 857 acc16* variable 2
 858 acc16- constant 54345
 859 acc16=> variable 2
 860 ;testExpression.j(311)     println(i);         // 1047
 861 acc16= variable 2
 862 writeLineAcc16
 863 ;testExpression.j(312)     
 864 ;testExpression.j(313)     /************/
 865 ;testExpression.j(314)     /* Overflow */
 866 ;testExpression.j(315)     /************/
 867 ;testExpression.j(316)     println("Nu komen 24.764 en 25.064");
 868 acc16= stringconstant 913
 869 writeLineString
 870 ;testExpression.j(317)     println(300 * 301); // 90.300 % 65536 = 24.764
 871 acc16= constant 300
 872 acc16* constant 301
 873 writeLineAcc16
 874 ;testExpression.j(318)     i = 300 * 302;
 875 acc16= constant 300
 876 acc16* constant 302
 877 acc16=> variable 2
 878 ;testExpression.j(319)     println(i);         // 90.600 % 65536 = 25.064
 879 acc16= variable 2
 880 writeLineAcc16
 881 ;testExpression.j(320)   
 882 ;testExpression.j(321)     /***************************/
 883 ;testExpression.j(322)     /* hex noatation constants */
 884 ;testExpression.j(323)     /***************************/
 885 ;testExpression.j(324)     println("hex notation constants");
 886 acc16= stringconstant 914
 887 writeLineString
 888 ;testExpression.j(325)     byteHex = 0x41;
 889 acc8= constant 65
 890 acc8=> variable 6
 891 ;testExpression.j(326)     println(byteHex);
 892 acc8= variable 6
 893 writeLineAcc8
 894 ;testExpression.j(327)     wordHex = 0x042A;
 895 acc16= constant 1066
 896 acc16=> variable 7
 897 ;testExpression.j(328)     println(wordHex);
 898 acc16= variable 7
 899 writeLineAcc16
 900 ;testExpression.j(329)   
 901 ;testExpression.j(330)     println("Klaar");
 902 acc16= stringconstant 915
 903 writeLineString
 904 ;testExpression.j(331)   }
 905 stackPointer= basePointer
 906 basePointer<
 907 return
 908 ;testExpression.j(332) }
 909 stringConstant 0 = "Nu komen 251 en 252"
 910 stringConstant 1 = "Nu komen -253 en -254"
 911 stringConstant 2 = "Nu komen 255 en 256"
 912 stringConstant 3 = "Nu komen 1000..1047"
 913 stringConstant 4 = "Nu komen 24.764 en 25.064"
 914 stringConstant 5 = "hex notation constants"
 915 stringConstant 6 = "Klaar"
