   0 call 23
   1 stop
   2 ;test15.j(0) /* Program to test bitwise operators and, or and xor. */
   3 ;test15.j(1) class TestBitwiseOperators {
   4 class TestBitwiseOperators []
   5 ;test15.j(2)   private static byte b1 = 0x1C;
   6 acc8= constant 28
   7 acc8=> variable 0
   8 ;test15.j(3)   private static byte b2 = 0x07;
   9 acc8= constant 7
  10 acc8=> variable 1
  11 ;test15.j(4)   private static word w1 = 0x032C;
  12 acc16= constant 812
  13 acc16=> variable 2
  14 ;test15.j(5)   private static word w2 = 0x1234;
  15 acc16= constant 4660
  16 acc16=> variable 4
  17 ;test15.j(6)   private static final byte fb1 = 0x1C;
  18 ;test15.j(7)   private static final byte fb2 = 0x07;
  19 ;test15.j(8)   private static final word fw1 = 0x032C;
  20 ;test15.j(9)   private static final word fw2 = 0x1234;
  21 ;test15.j(10) 
  22 ;test15.j(11)   public static void main() {
  23 method main [public, static] void
  24 ;test15.j(12)     println(0);
  25 acc8= constant 0
  26 call writeLineAcc8
  27 ;test15.j(13)     
  28 ;test15.j(14)     // Possible operand types: constant, acc, var, final var, stack8, stack16.
  29 ;test15.j(15)     // Possible data types: byte, word.
  30 ;test15.j(16)   
  31 ;test15.j(17)     //constant/constant
  32 ;test15.j(18)     //*****************
  33 ;test15.j(19)     //constant byte/constant byte
  34 ;test15.j(20)     if (0x07 & 0x1C == 0x04) println (1); else println (999); //0000.0111 & 0001.1100 = 0000.0100
  35 acc8= constant 7
  36 acc8And constant 28
  37 acc8Comp constant 4
  38 brne 44
  39 acc8= constant 1
  40 call writeLineAcc8
  41 br 47
  42 acc16= constant 999
  43 call writeLineAcc16
  44 ;test15.j(21)     if (0x07 | 0x1C == 0x1F) println (2); else println (999); //0000.0111 | 0001.1100 = 0001.1111
  45 acc8= constant 7
  46 acc8Or constant 28
  47 acc8Comp constant 31
  48 brne 56
  49 acc8= constant 2
  50 call writeLineAcc8
  51 br 59
  52 acc16= constant 999
  53 call writeLineAcc16
  54 ;test15.j(22)     if (0x07 ^ 0x1C == 0x1B) println (3); else println (999); //0000.0111 ^ 0001.1100 = 0001.1011
  55 acc8= constant 7
  56 acc8Xor constant 28
  57 acc8Comp constant 27
  58 brne 68
  59 acc8= constant 3
  60 call writeLineAcc8
  61 br 72
  62 acc16= constant 999
  63 call writeLineAcc16
  64 ;test15.j(23)     //constant word/constant word
  65 ;test15.j(24)     if (0x1234 & 0x032C == 0x0224) println (4); else println (999);
  66 acc16= constant 4660
  67 acc16And constant 812
  68 acc16Comp constant 548
  69 brne 81
  70 acc8= constant 4
  71 call writeLineAcc8
  72 br 85
  73 acc16= constant 999
  74 call writeLineAcc16
  75 ;test15.j(25)     //0001.0010.0011.0100 & 0000.0011.0010.1100 = 0000.0010.0010.0100
  76 ;test15.j(26)     if (0x1234 | 0x032C == 0x133C) println (5); else println (999);
  77 acc16= constant 4660
  78 acc16Or constant 812
  79 acc16Comp constant 4924
  80 brne 94
  81 acc8= constant 5
  82 call writeLineAcc8
  83 br 98
  84 acc16= constant 999
  85 call writeLineAcc16
  86 ;test15.j(27)     //0001.0010.0011.0100 | 0000.0011.0010.1100 = 0001.0011.0011.1100
  87 ;test15.j(28)     if (0x1234 ^ 0x032C == 0x1118) println (6); else println (999);
  88 acc16= constant 4660
  89 acc16Xor constant 812
  90 acc16Comp constant 4376
  91 brne 107
  92 acc8= constant 6
  93 call writeLineAcc8
  94 br 112
  95 acc16= constant 999
  96 call writeLineAcc16
  97 ;test15.j(29)     //0001.0010.0011.0100 ^ 0000.0011.0010.1100 = 0001.0001.0001.1000
  98 ;test15.j(30)     //constant byte/constant word
  99 ;test15.j(31)     if (0x1C & 0x1234 == 0x0014) println (7); else println (999); //0001.1100 & 0001.0010.0011.0100 = 0000.0000.0001.0100
 100 acc8= constant 28
 101 acc8ToAcc16
 102 acc16And constant 4660
 103 acc8= constant 20
 104 acc16CompareAcc8
 105 brne 123
 106 acc8= constant 7
 107 call writeLineAcc8
 108 br 126
 109 acc16= constant 999
 110 call writeLineAcc16
 111 ;test15.j(32)     if (0x1C | 0x1234 == 0x123C) println (8); else println (999); //0001.1100 | 0001.0010.0011.0100 = 0001.0010.0011.1100
 112 acc8= constant 28
 113 acc8ToAcc16
 114 acc16Or constant 4660
 115 acc16Comp constant 4668
 116 brne 136
 117 acc8= constant 8
 118 call writeLineAcc8
 119 br 139
 120 acc16= constant 999
 121 call writeLineAcc16
 122 ;test15.j(33)     if (0x1C ^ 0x1234 == 0x1228) println (9); else println (999); //0001.1100 ^ 0001.0010.0011.0100 = 0001.0010.0010.1000
 123 acc8= constant 28
 124 acc8ToAcc16
 125 acc16Xor constant 4660
 126 acc16Comp constant 4648
 127 brne 149
 128 acc8= constant 9
 129 call writeLineAcc8
 130 br 153
 131 acc16= constant 999
 132 call writeLineAcc16
 133 ;test15.j(34)     //constant word/constant byte
 134 ;test15.j(35)     if (0x1234 & 0x1C == 0x0014) println (10); else println (999); //0001.0010.0011.0100 & 0001.1100 = 0000.0000.0001.0100
 135 acc16= constant 4660
 136 acc16And constant 28
 137 acc8= constant 20
 138 acc16CompareAcc8
 139 brne 163
 140 acc8= constant 10
 141 call writeLineAcc8
 142 br 166
 143 acc16= constant 999
 144 call writeLineAcc16
 145 ;test15.j(36)     if (0x1234 | 0x1C == 0x123C) println (11); else println (999); //0001.0010.0011.0100 | 0001.1100 = 0001.0010.0011.1100
 146 acc16= constant 4660
 147 acc16Or constant 28
 148 acc16Comp constant 4668
 149 brne 175
 150 acc8= constant 11
 151 call writeLineAcc8
 152 br 178
 153 acc16= constant 999
 154 call writeLineAcc16
 155 ;test15.j(37)     if (0x1234 ^ 0x1C == 0x1228) println (12); else println (999); //0001.0010.0011.0100 ^ 0001.1100 = 0001.0010.0010.1000
 156 acc16= constant 4660
 157 acc16Xor constant 28
 158 acc16Comp constant 4648
 159 brne 187
 160 acc8= constant 12
 161 call writeLineAcc8
 162 br 194
 163 acc16= constant 999
 164 call writeLineAcc16
 165 ;test15.j(38)   
 166 ;test15.j(39)     //constant/acc
 167 ;test15.j(40)     //************
 168 ;test15.j(41)     //constant byte/acc byte
 169 ;test15.j(42)     if (0x07 & (0x10 + 0x0C) == 0x04) println (13); else println (999);
 170 acc8= constant 7
 171 <acc8= constant 16
 172 acc8+ constant 12
 173 acc8And unstack8
 174 acc8Comp constant 4
 175 brne 205
 176 acc8= constant 13
 177 call writeLineAcc8
 178 br 208
 179 acc16= constant 999
 180 call writeLineAcc16
 181 ;test15.j(43)     if (0x07 | (0x10 + 0x0C) == 0x1F) println (14); else println (999);
 182 acc8= constant 7
 183 <acc8= constant 16
 184 acc8+ constant 12
 185 acc8Or unstack8
 186 acc8Comp constant 31
 187 brne 219
 188 acc8= constant 14
 189 call writeLineAcc8
 190 br 222
 191 acc16= constant 999
 192 call writeLineAcc16
 193 ;test15.j(44)     if (0x07 ^ (0x10 + 0x0C) == 0x1B) println (15); else println (999);
 194 acc8= constant 7
 195 <acc8= constant 16
 196 acc8+ constant 12
 197 acc8Xor unstack8
 198 acc8Comp constant 27
 199 brne 233
 200 acc8= constant 15
 201 call writeLineAcc8
 202 br 237
 203 acc16= constant 999
 204 call writeLineAcc16
 205 ;test15.j(45)     //constant word/acc word
 206 ;test15.j(46)     if (0x1234 & 0x0100 + 0x022C == 0x0224) println (16); else println (999);
 207 acc16= constant 4660
 208 <acc16= constant 256
 209 acc16+ constant 556
 210 acc16And unstack16
 211 acc16Comp constant 548
 212 brne 248
 213 acc8= constant 16
 214 call writeLineAcc8
 215 br 251
 216 acc16= constant 999
 217 call writeLineAcc16
 218 ;test15.j(47)     if (0x1234 | 0x0100 + 0x022C == 0x133C) println (17); else println (999);
 219 acc16= constant 4660
 220 <acc16= constant 256
 221 acc16+ constant 556
 222 acc16Or unstack16
 223 acc16Comp constant 4924
 224 brne 262
 225 acc8= constant 17
 226 call writeLineAcc8
 227 br 265
 228 acc16= constant 999
 229 call writeLineAcc16
 230 ;test15.j(48)     if (0x1234 ^ 0x0100 + 0x022C == 0x1118) println (18); else println (999);
 231 acc16= constant 4660
 232 <acc16= constant 256
 233 acc16+ constant 556
 234 acc16Xor unstack16
 235 acc16Comp constant 4376
 236 brne 276
 237 acc8= constant 18
 238 call writeLineAcc8
 239 br 280
 240 acc16= constant 999
 241 call writeLineAcc16
 242 ;test15.j(49)     //constant byte/acc word
 243 ;test15.j(50)     if (0x1C & 0x1000 + 0x0234 == 0x0014) println (19); else println (999);
 244 acc8= constant 28
 245 acc16= constant 4096
 246 acc16+ constant 564
 247 acc16And acc8
 248 acc8= constant 20
 249 acc16CompareAcc8
 250 brne 292
 251 acc8= constant 19
 252 call writeLineAcc8
 253 br 295
 254 acc16= constant 999
 255 call writeLineAcc16
 256 ;test15.j(51)     if (0x1C | 0x1000 + 0x0234 == 0x123C) println (20); else println (999);
 257 acc8= constant 28
 258 acc16= constant 4096
 259 acc16+ constant 564
 260 acc16Or acc8
 261 acc16Comp constant 4668
 262 brne 306
 263 acc8= constant 20
 264 call writeLineAcc8
 265 br 309
 266 acc16= constant 999
 267 call writeLineAcc16
 268 ;test15.j(52)     if (0x1C ^ 0x1000 + 0x0234 == 0x1228) println (21); else println (999);
 269 acc8= constant 28
 270 acc16= constant 4096
 271 acc16+ constant 564
 272 acc16Xor acc8
 273 acc16Comp constant 4648
 274 brne 320
 275 acc8= constant 21
 276 call writeLineAcc8
 277 br 324
 278 acc16= constant 999
 279 call writeLineAcc16
 280 ;test15.j(53)     //constant word/acc byte
 281 ;test15.j(54)     if (0x1234 & 0x10 + 0x0C == 0x0014) println (22); else println (999);
 282 acc16= constant 4660
 283 acc8= constant 16
 284 acc8+ constant 12
 285 acc16And acc8
 286 acc8= constant 20
 287 acc16CompareAcc8
 288 brne 336
 289 acc8= constant 22
 290 call writeLineAcc8
 291 br 339
 292 acc16= constant 999
 293 call writeLineAcc16
 294 ;test15.j(55)     if (0x1234 | 0x10 + 0x0C == 0x123C) println (23); else println (999);
 295 acc16= constant 4660
 296 acc8= constant 16
 297 acc8+ constant 12
 298 acc16Or acc8
 299 acc16Comp constant 4668
 300 brne 350
 301 acc8= constant 23
 302 call writeLineAcc8
 303 br 353
 304 acc16= constant 999
 305 call writeLineAcc16
 306 ;test15.j(56)     if (0x1234 ^ 0x10 + 0x0C == 0x1228) println (24); else println (999);
 307 acc16= constant 4660
 308 acc8= constant 16
 309 acc8+ constant 12
 310 acc16Xor acc8
 311 acc16Comp constant 4648
 312 brne 364
 313 acc8= constant 24
 314 call writeLineAcc8
 315 br 371
 316 acc16= constant 999
 317 call writeLineAcc16
 318 ;test15.j(57)   
 319 ;test15.j(58)     //constant/var
 320 ;test15.j(59)     //*****************
 321 ;test15.j(60)     //constant byte/var byte
 322 ;test15.j(61)     if (0x07 & b1 == 0x04) println (25); else println (999);
 323 acc8= constant 7
 324 acc8And variable 0
 325 acc8Comp constant 4
 326 brne 380
 327 acc8= constant 25
 328 call writeLineAcc8
 329 br 383
 330 acc16= constant 999
 331 call writeLineAcc16
 332 ;test15.j(62)     if (0x07 | b1 == 0x1F) println (26); else println (999);
 333 acc8= constant 7
 334 acc8Or variable 0
 335 acc8Comp constant 31
 336 brne 392
 337 acc8= constant 26
 338 call writeLineAcc8
 339 br 395
 340 acc16= constant 999
 341 call writeLineAcc16
 342 ;test15.j(63)     if (0x07 ^ b1 == 0x1B) println (27); else println (999);
 343 acc8= constant 7
 344 acc8Xor variable 0
 345 acc8Comp constant 27
 346 brne 404
 347 acc8= constant 27
 348 call writeLineAcc8
 349 br 408
 350 acc16= constant 999
 351 call writeLineAcc16
 352 ;test15.j(64)     //constant word/var word
 353 ;test15.j(65)     if (0x1234 & w1 == 0x0224) println (28); else println (999);
 354 acc16= constant 4660
 355 acc16And variable 2
 356 acc16Comp constant 548
 357 brne 417
 358 acc8= constant 28
 359 call writeLineAcc8
 360 br 420
 361 acc16= constant 999
 362 call writeLineAcc16
 363 ;test15.j(66)     if (0x1234 | w1 == 0x133C) println (29); else println (999);
 364 acc16= constant 4660
 365 acc16Or variable 2
 366 acc16Comp constant 4924
 367 brne 429
 368 acc8= constant 29
 369 call writeLineAcc8
 370 br 432
 371 acc16= constant 999
 372 call writeLineAcc16
 373 ;test15.j(67)     if (0x1234 ^ w1 == 0x1118) println (30); else println (999);
 374 acc16= constant 4660
 375 acc16Xor variable 2
 376 acc16Comp constant 4376
 377 brne 441
 378 acc8= constant 30
 379 call writeLineAcc8
 380 br 445
 381 acc16= constant 999
 382 call writeLineAcc16
 383 ;test15.j(68)     //constant byte/var word
 384 ;test15.j(69)     if (0x1C & w2 == 0x0014) println (31); else println (999);
 385 acc8= constant 28
 386 acc8ToAcc16
 387 acc16And variable 4
 388 acc8= constant 20
 389 acc16CompareAcc8
 390 brne 456
 391 acc8= constant 31
 392 call writeLineAcc8
 393 br 459
 394 acc16= constant 999
 395 call writeLineAcc16
 396 ;test15.j(70)     if (0x1C | w2 == 0x123C) println (32); else println (999);
 397 acc8= constant 28
 398 acc8ToAcc16
 399 acc16Or variable 4
 400 acc16Comp constant 4668
 401 brne 469
 402 acc8= constant 32
 403 call writeLineAcc8
 404 br 472
 405 acc16= constant 999
 406 call writeLineAcc16
 407 ;test15.j(71)     if (0x1C ^ w2 == 0x1228) println (33); else println (999);
 408 acc8= constant 28
 409 acc8ToAcc16
 410 acc16Xor variable 4
 411 acc16Comp constant 4648
 412 brne 482
 413 acc8= constant 33
 414 call writeLineAcc8
 415 br 486
 416 acc16= constant 999
 417 call writeLineAcc16
 418 ;test15.j(72)     //constant word/var byte
 419 ;test15.j(73)     if (0x1234 & b1 == 0x0014) println (34); else println (999);
 420 acc16= constant 4660
 421 acc16And variable 0
 422 acc8= constant 20
 423 acc16CompareAcc8
 424 brne 496
 425 acc8= constant 34
 426 call writeLineAcc8
 427 br 499
 428 acc16= constant 999
 429 call writeLineAcc16
 430 ;test15.j(74)     if (0x1234 | b1 == 0x123C) println (35); else println (999);
 431 acc16= constant 4660
 432 acc16Or variable 0
 433 acc16Comp constant 4668
 434 brne 508
 435 acc8= constant 35
 436 call writeLineAcc8
 437 br 511
 438 acc16= constant 999
 439 call writeLineAcc16
 440 ;test15.j(75)     if (0x1234 ^ b1 == 0x1228) println (36); else println (999);
 441 acc16= constant 4660
 442 acc16Xor variable 0
 443 acc16Comp constant 4648
 444 brne 520
 445 acc8= constant 36
 446 call writeLineAcc8
 447 br 527
 448 acc16= constant 999
 449 call writeLineAcc16
 450 ;test15.j(76)   
 451 ;test15.j(77)     //constant/final var
 452 ;test15.j(78)     //*****************
 453 ;test15.j(79)     //constant byte/final var byte
 454 ;test15.j(80)     if (0x07 & fb1 == 0x04) println (37); else println (999);
 455 acc8= constant 7
 456 acc8And constant 28
 457 acc8Comp constant 4
 458 brne 536
 459 acc8= constant 37
 460 call writeLineAcc8
 461 br 539
 462 acc16= constant 999
 463 call writeLineAcc16
 464 ;test15.j(81)     if (0x07 | fb1 == 0x1F) println (38); else println (999);
 465 acc8= constant 7
 466 acc8Or constant 28
 467 acc8Comp constant 31
 468 brne 548
 469 acc8= constant 38
 470 call writeLineAcc8
 471 br 551
 472 acc16= constant 999
 473 call writeLineAcc16
 474 ;test15.j(82)     if (0x07 ^ fb1 == 0x1B) println (39); else println (999);
 475 acc8= constant 7
 476 acc8Xor constant 28
 477 acc8Comp constant 27
 478 brne 560
 479 acc8= constant 39
 480 call writeLineAcc8
 481 br 564
 482 acc16= constant 999
 483 call writeLineAcc16
 484 ;test15.j(83)     //constant word/final var word
 485 ;test15.j(84)     if (0x1234 & fw1 == 0x0224) println (40); else println (999);
 486 acc16= constant 4660
 487 acc16And constant 812
 488 acc16Comp constant 548
 489 brne 573
 490 acc8= constant 40
 491 call writeLineAcc8
 492 br 576
 493 acc16= constant 999
 494 call writeLineAcc16
 495 ;test15.j(85)     if (0x1234 | fw1 == 0x133C) println (41); else println (999);
 496 acc16= constant 4660
 497 acc16Or constant 812
 498 acc16Comp constant 4924
 499 brne 585
 500 acc8= constant 41
 501 call writeLineAcc8
 502 br 588
 503 acc16= constant 999
 504 call writeLineAcc16
 505 ;test15.j(86)     if (0x1234 ^ fw1 == 0x1118) println (42); else println (999);
 506 acc16= constant 4660
 507 acc16Xor constant 812
 508 acc16Comp constant 4376
 509 brne 597
 510 acc8= constant 42
 511 call writeLineAcc8
 512 br 601
 513 acc16= constant 999
 514 call writeLineAcc16
 515 ;test15.j(87)     //constant byte/final var word
 516 ;test15.j(88)     if (0x1C & fw2 == 0x0014) println (43); else println (999);
 517 acc8= constant 28
 518 acc8ToAcc16
 519 acc16And constant 4660
 520 acc8= constant 20
 521 acc16CompareAcc8
 522 brne 612
 523 acc8= constant 43
 524 call writeLineAcc8
 525 br 615
 526 acc16= constant 999
 527 call writeLineAcc16
 528 ;test15.j(89)     if (0x1C | fw2 == 0x123C) println (44); else println (999);
 529 acc8= constant 28
 530 acc8ToAcc16
 531 acc16Or constant 4660
 532 acc16Comp constant 4668
 533 brne 625
 534 acc8= constant 44
 535 call writeLineAcc8
 536 br 628
 537 acc16= constant 999
 538 call writeLineAcc16
 539 ;test15.j(90)     if (0x1C ^ fw2 == 0x1228) println (45); else println (999);
 540 acc8= constant 28
 541 acc8ToAcc16
 542 acc16Xor constant 4660
 543 acc16Comp constant 4648
 544 brne 638
 545 acc8= constant 45
 546 call writeLineAcc8
 547 br 642
 548 acc16= constant 999
 549 call writeLineAcc16
 550 ;test15.j(91)     //constant word/final var byte
 551 ;test15.j(92)     if (0x1234 & fb1 == 0x0014) println (46); else println (999);
 552 acc16= constant 4660
 553 acc16And constant 28
 554 acc8= constant 20
 555 acc16CompareAcc8
 556 brne 652
 557 acc8= constant 46
 558 call writeLineAcc8
 559 br 655
 560 acc16= constant 999
 561 call writeLineAcc16
 562 ;test15.j(93)     if (0x1234 | fb1 == 0x123C) println (47); else println (999);
 563 acc16= constant 4660
 564 acc16Or constant 28
 565 acc16Comp constant 4668
 566 brne 664
 567 acc8= constant 47
 568 call writeLineAcc8
 569 br 667
 570 acc16= constant 999
 571 call writeLineAcc16
 572 ;test15.j(94)     if (0x1234 ^ fb1 == 0x1228) println (48); else println (999);
 573 acc16= constant 4660
 574 acc16Xor constant 28
 575 acc16Comp constant 4648
 576 brne 676
 577 acc8= constant 48
 578 call writeLineAcc8
 579 br 683
 580 acc16= constant 999
 581 call writeLineAcc16
 582 ;test15.j(95)   
 583 ;test15.j(96)     //acc/constant
 584 ;test15.j(97)     //************
 585 ;test15.j(98)     //acc byte/constant byte
 586 ;test15.j(99)     if ((0x04 + 0x03) & 0x1C == 0x04) println (49); else println (999);
 587 acc8= constant 4
 588 acc8+ constant 3
 589 acc8And constant 28
 590 acc8Comp constant 4
 591 brne 693
 592 acc8= constant 49
 593 call writeLineAcc8
 594 br 696
 595 acc16= constant 999
 596 call writeLineAcc16
 597 ;test15.j(100)     if ((0x04 + 0x03) | 0x1C == 0x1F) println (50); else println (999);
 598 acc8= constant 4
 599 acc8+ constant 3
 600 acc8Or constant 28
 601 acc8Comp constant 31
 602 brne 706
 603 acc8= constant 50
 604 call writeLineAcc8
 605 br 709
 606 acc16= constant 999
 607 call writeLineAcc16
 608 ;test15.j(101)     if ((0x04 + 0x03) ^ 0x1C == 0x1B) println (51); else println (999);
 609 acc8= constant 4
 610 acc8+ constant 3
 611 acc8Xor constant 28
 612 acc8Comp constant 27
 613 brne 719
 614 acc8= constant 51
 615 call writeLineAcc8
 616 br 723
 617 acc16= constant 999
 618 call writeLineAcc16
 619 ;test15.j(102)     //acc word/constant word
 620 ;test15.j(103)     if (0x1000 + 0x0234 & 0x032C == 0x0224) println (52); else println (999);
 621 acc16= constant 4096
 622 acc16+ constant 564
 623 acc16And constant 812
 624 acc16Comp constant 548
 625 brne 733
 626 acc8= constant 52
 627 call writeLineAcc8
 628 br 736
 629 acc16= constant 999
 630 call writeLineAcc16
 631 ;test15.j(104)     if (0x1000 + 0x0234 | 0x032C == 0x133C) println (53); else println (999);
 632 acc16= constant 4096
 633 acc16+ constant 564
 634 acc16Or constant 812
 635 acc16Comp constant 4924
 636 brne 746
 637 acc8= constant 53
 638 call writeLineAcc8
 639 br 749
 640 acc16= constant 999
 641 call writeLineAcc16
 642 ;test15.j(105)     if (0x1000 + 0x0234 ^ 0x032C == 0x1118) println (54); else println (999);
 643 acc16= constant 4096
 644 acc16+ constant 564
 645 acc16Xor constant 812
 646 acc16Comp constant 4376
 647 brne 759
 648 acc8= constant 54
 649 call writeLineAcc8
 650 br 763
 651 acc16= constant 999
 652 call writeLineAcc16
 653 ;test15.j(106)     //acc byte/constant word
 654 ;test15.j(107)     if (0x10 + 0x0C & 0x1234 == 0x0014) println (55); else println (999);
 655 acc8= constant 16
 656 acc8+ constant 12
 657 acc8ToAcc16
 658 acc16And constant 4660
 659 acc8= constant 20
 660 acc16CompareAcc8
 661 brne 775
 662 acc8= constant 55
 663 call writeLineAcc8
 664 br 778
 665 acc16= constant 999
 666 call writeLineAcc16
 667 ;test15.j(108)     if (0x10 + 0x0C | 0x1234 == 0x123C) println (56); else println (999);
 668 acc8= constant 16
 669 acc8+ constant 12
 670 acc8ToAcc16
 671 acc16Or constant 4660
 672 acc16Comp constant 4668
 673 brne 789
 674 acc8= constant 56
 675 call writeLineAcc8
 676 br 792
 677 acc16= constant 999
 678 call writeLineAcc16
 679 ;test15.j(109)     if (0x10 + 0x0C ^ 0x1234 == 0x1228) println (57); else println (999);
 680 acc8= constant 16
 681 acc8+ constant 12
 682 acc8ToAcc16
 683 acc16Xor constant 4660
 684 acc16Comp constant 4648
 685 brne 803
 686 acc8= constant 57
 687 call writeLineAcc8
 688 br 807
 689 acc16= constant 999
 690 call writeLineAcc16
 691 ;test15.j(110)     //acc word/constant byte
 692 ;test15.j(111)     if (0x1000 + 0x0234 & 0x1C == 0x0014) println (58); else println (999);
 693 acc16= constant 4096
 694 acc16+ constant 564
 695 acc16And constant 28
 696 acc8= constant 20
 697 acc16CompareAcc8
 698 brne 818
 699 acc8= constant 58
 700 call writeLineAcc8
 701 br 821
 702 acc16= constant 999
 703 call writeLineAcc16
 704 ;test15.j(112)     if (0x1000 + 0x0234 | 0x1C == 0x123C) println (59); else println (999);
 705 acc16= constant 4096
 706 acc16+ constant 564
 707 acc16Or constant 28
 708 acc16Comp constant 4668
 709 brne 831
 710 acc8= constant 59
 711 call writeLineAcc8
 712 br 834
 713 acc16= constant 999
 714 call writeLineAcc16
 715 ;test15.j(113)     if (0x1000 + 0x0234 ^ 0x1C == 0x1228) println (60); else println (999);
 716 acc16= constant 4096
 717 acc16+ constant 564
 718 acc16Xor constant 28
 719 acc16Comp constant 4648
 720 brne 844
 721 acc8= constant 60
 722 call writeLineAcc8
 723 br 851
 724 acc16= constant 999
 725 call writeLineAcc16
 726 ;test15.j(114)   
 727 ;test15.j(115)     //acc/acc
 728 ;test15.j(116)     //*******
 729 ;test15.j(117)     //acc byte/acc byte
 730 ;test15.j(118)     if (0x04 + 0x03 & 0x10 + 0x0C == 0x04) println (61); else println (999);
 731 acc8= constant 4
 732 acc8+ constant 3
 733 <acc8= constant 16
 734 acc8+ constant 12
 735 acc8And unstack8
 736 acc8Comp constant 4
 737 brne 863
 738 acc8= constant 61
 739 call writeLineAcc8
 740 br 866
 741 acc16= constant 999
 742 call writeLineAcc16
 743 ;test15.j(119)     if (0x04 + 0x03 | 0x10 + 0x0C == 0x1F) println (62); else println (999);
 744 acc8= constant 4
 745 acc8+ constant 3
 746 <acc8= constant 16
 747 acc8+ constant 12
 748 acc8Or unstack8
 749 acc8Comp constant 31
 750 brne 878
 751 acc8= constant 62
 752 call writeLineAcc8
 753 br 881
 754 acc16= constant 999
 755 call writeLineAcc16
 756 ;test15.j(120)     if (0x04 + 0x03 ^ 0x10 + 0x0C == 0x1B) println (63); else println (999);
 757 acc8= constant 4
 758 acc8+ constant 3
 759 <acc8= constant 16
 760 acc8+ constant 12
 761 acc8Xor unstack8
 762 acc8Comp constant 27
 763 brne 893
 764 acc8= constant 63
 765 call writeLineAcc8
 766 br 897
 767 acc16= constant 999
 768 call writeLineAcc16
 769 ;test15.j(121)     //acc word/acc word
 770 ;test15.j(122)     if (0x1000 + 0x0234 & 0x0100 + 0x022C == 0x0224) println (64); else println (999);
 771 acc16= constant 4096
 772 acc16+ constant 564
 773 <acc16= constant 256
 774 acc16+ constant 556
 775 acc16And unstack16
 776 acc16Comp constant 548
 777 brne 909
 778 acc8= constant 64
 779 call writeLineAcc8
 780 br 912
 781 acc16= constant 999
 782 call writeLineAcc16
 783 ;test15.j(123)     if (0x1000 + 0x0234 | 0x0100 + 0x022C == 0x133C) println (65); else println (999);
 784 acc16= constant 4096
 785 acc16+ constant 564
 786 <acc16= constant 256
 787 acc16+ constant 556
 788 acc16Or unstack16
 789 acc16Comp constant 4924
 790 brne 924
 791 acc8= constant 65
 792 call writeLineAcc8
 793 br 927
 794 acc16= constant 999
 795 call writeLineAcc16
 796 ;test15.j(124)     if (0x1000 + 0x0234 ^ 0x0100 + 0x022C == 0x1118) println (66); else println (999);
 797 acc16= constant 4096
 798 acc16+ constant 564
 799 <acc16= constant 256
 800 acc16+ constant 556
 801 acc16Xor unstack16
 802 acc16Comp constant 4376
 803 brne 939
 804 acc8= constant 66
 805 call writeLineAcc8
 806 br 943
 807 acc16= constant 999
 808 call writeLineAcc16
 809 ;test15.j(125)     //acc byte/acc word
 810 ;test15.j(126)     if (0x10 + 0x0C & 0x1000 + 0x0234 == 0x0014) println (67); else println (999);
 811 acc8= constant 16
 812 acc8+ constant 12
 813 acc16= constant 4096
 814 acc16+ constant 564
 815 acc16And acc8
 816 acc8= constant 20
 817 acc16CompareAcc8
 818 brne 956
 819 acc8= constant 67
 820 call writeLineAcc8
 821 br 959
 822 acc16= constant 999
 823 call writeLineAcc16
 824 ;test15.j(127)     if (0x10 + 0x0C | 0x1000 + 0x0234 == 0x123C) println (68); else println (999);
 825 acc8= constant 16
 826 acc8+ constant 12
 827 acc16= constant 4096
 828 acc16+ constant 564
 829 acc16Or acc8
 830 acc16Comp constant 4668
 831 brne 971
 832 acc8= constant 68
 833 call writeLineAcc8
 834 br 974
 835 acc16= constant 999
 836 call writeLineAcc16
 837 ;test15.j(128)     if (0x10 + 0x0C ^ 0x1000 + 0x0234 == 0x1228) println (69); else println (999);
 838 acc8= constant 16
 839 acc8+ constant 12
 840 acc16= constant 4096
 841 acc16+ constant 564
 842 acc16Xor acc8
 843 acc16Comp constant 4648
 844 brne 986
 845 acc8= constant 69
 846 call writeLineAcc8
 847 br 990
 848 acc16= constant 999
 849 call writeLineAcc16
 850 ;test15.j(129)     //acc word/acc byte
 851 ;test15.j(130)     if (0x1000 + 0x0234 & 0x10 + 0x0C == 0x0014) println (70); else println (999);
 852 acc16= constant 4096
 853 acc16+ constant 564
 854 acc8= constant 16
 855 acc8+ constant 12
 856 acc16And acc8
 857 acc8= constant 20
 858 acc16CompareAcc8
 859 brne 1003
 860 acc8= constant 70
 861 call writeLineAcc8
 862 br 1006
 863 acc16= constant 999
 864 call writeLineAcc16
 865 ;test15.j(131)     if (0x1000 + 0x0234 | 0x10 + 0x0C == 0x123C) println (71); else println (999);
 866 acc16= constant 4096
 867 acc16+ constant 564
 868 acc8= constant 16
 869 acc8+ constant 12
 870 acc16Or acc8
 871 acc16Comp constant 4668
 872 brne 1018
 873 acc8= constant 71
 874 call writeLineAcc8
 875 br 1021
 876 acc16= constant 999
 877 call writeLineAcc16
 878 ;test15.j(132)     if (0x1000 + 0x0234 ^ 0x10 + 0x0C == 0x1228) println (72); else println (999);
 879 acc16= constant 4096
 880 acc16+ constant 564
 881 acc8= constant 16
 882 acc8+ constant 12
 883 acc16Xor acc8
 884 acc16Comp constant 4648
 885 brne 1033
 886 acc8= constant 72
 887 call writeLineAcc8
 888 br 1040
 889 acc16= constant 999
 890 call writeLineAcc16
 891 ;test15.j(133)   
 892 ;test15.j(134)     //acc/var
 893 ;test15.j(135)     //*******
 894 ;test15.j(136)     //acc byte/var byte
 895 ;test15.j(137)     if (0x04 + 0x03 & b1 == 0x04) println (73); else println (999);
 896 acc8= constant 4
 897 acc8+ constant 3
 898 acc8And variable 0
 899 acc8Comp constant 4
 900 brne 1050
 901 acc8= constant 73
 902 call writeLineAcc8
 903 br 1053
 904 acc16= constant 999
 905 call writeLineAcc16
 906 ;test15.j(138)     if (0x04 + 0x03 | b1 == 0x1F) println (74); else println (999);
 907 acc8= constant 4
 908 acc8+ constant 3
 909 acc8Or variable 0
 910 acc8Comp constant 31
 911 brne 1063
 912 acc8= constant 74
 913 call writeLineAcc8
 914 br 1066
 915 acc16= constant 999
 916 call writeLineAcc16
 917 ;test15.j(139)     if (0x04 + 0x03 ^ b1 == 0x1B) println (75); else println (999);
 918 acc8= constant 4
 919 acc8+ constant 3
 920 acc8Xor variable 0
 921 acc8Comp constant 27
 922 brne 1076
 923 acc8= constant 75
 924 call writeLineAcc8
 925 br 1080
 926 acc16= constant 999
 927 call writeLineAcc16
 928 ;test15.j(140)     //acc word/var word
 929 ;test15.j(141)     if (0x1000 + 0x0234 & w1 == 0x0224) println (76); else println (999);
 930 acc16= constant 4096
 931 acc16+ constant 564
 932 acc16And variable 2
 933 acc16Comp constant 548
 934 brne 1090
 935 acc8= constant 76
 936 call writeLineAcc8
 937 br 1093
 938 acc16= constant 999
 939 call writeLineAcc16
 940 ;test15.j(142)     if (0x1000 + 0x0234 | w1 == 0x133C) println (77); else println (999);
 941 acc16= constant 4096
 942 acc16+ constant 564
 943 acc16Or variable 2
 944 acc16Comp constant 4924
 945 brne 1103
 946 acc8= constant 77
 947 call writeLineAcc8
 948 br 1106
 949 acc16= constant 999
 950 call writeLineAcc16
 951 ;test15.j(143)     if (0x1000 + 0x0234 ^ w1 == 0x1118) println (78); else println (999);
 952 acc16= constant 4096
 953 acc16+ constant 564
 954 acc16Xor variable 2
 955 acc16Comp constant 4376
 956 brne 1116
 957 acc8= constant 78
 958 call writeLineAcc8
 959 br 1120
 960 acc16= constant 999
 961 call writeLineAcc16
 962 ;test15.j(144)     //acc byte/var word
 963 ;test15.j(145)     if (0x10 + 0x0C & w2 == 0x0014) println (79); else println (999);
 964 acc8= constant 16
 965 acc8+ constant 12
 966 acc8ToAcc16
 967 acc16And variable 4
 968 acc8= constant 20
 969 acc16CompareAcc8
 970 brne 1132
 971 acc8= constant 79
 972 call writeLineAcc8
 973 br 1135
 974 acc16= constant 999
 975 call writeLineAcc16
 976 ;test15.j(146)     if (0x10 + 0x0C | w2 == 0x123C) println (80); else println (999);
 977 acc8= constant 16
 978 acc8+ constant 12
 979 acc8ToAcc16
 980 acc16Or variable 4
 981 acc16Comp constant 4668
 982 brne 1146
 983 acc8= constant 80
 984 call writeLineAcc8
 985 br 1149
 986 acc16= constant 999
 987 call writeLineAcc16
 988 ;test15.j(147)     if (0x10 + 0x0C ^ w2 == 0x1228) println (81); else println (999);
 989 acc8= constant 16
 990 acc8+ constant 12
 991 acc8ToAcc16
 992 acc16Xor variable 4
 993 acc16Comp constant 4648
 994 brne 1160
 995 acc8= constant 81
 996 call writeLineAcc8
 997 br 1164
 998 acc16= constant 999
 999 call writeLineAcc16
1000 ;test15.j(148)     //acc word/var byte
1001 ;test15.j(149)     if (0x1000 + 0x0234 & b1 == 0x0014) println (82); else println (999);
1002 acc16= constant 4096
1003 acc16+ constant 564
1004 acc16And variable 0
1005 acc8= constant 20
1006 acc16CompareAcc8
1007 brne 1175
1008 acc8= constant 82
1009 call writeLineAcc8
1010 br 1178
1011 acc16= constant 999
1012 call writeLineAcc16
1013 ;test15.j(150)     if (0x1000 + 0x0234 | b1 == 0x123C) println (83); else println (999);
1014 acc16= constant 4096
1015 acc16+ constant 564
1016 acc16Or variable 0
1017 acc16Comp constant 4668
1018 brne 1188
1019 acc8= constant 83
1020 call writeLineAcc8
1021 br 1191
1022 acc16= constant 999
1023 call writeLineAcc16
1024 ;test15.j(151)     if (0x1000 + 0x0234 ^ b1 == 0x1228) println (84); else println (999);
1025 acc16= constant 4096
1026 acc16+ constant 564
1027 acc16Xor variable 0
1028 acc16Comp constant 4648
1029 brne 1201
1030 acc8= constant 84
1031 call writeLineAcc8
1032 br 1208
1033 acc16= constant 999
1034 call writeLineAcc16
1035 ;test15.j(152)   
1036 ;test15.j(153)     //acc/final var
1037 ;test15.j(154)     //*************
1038 ;test15.j(155)     //acc byte/final var byte
1039 ;test15.j(156)     if (0x04 + 0x03 & fb1 == 0x04) println (85); else println (999);
1040 acc8= constant 4
1041 acc8+ constant 3
1042 acc8And constant 28
1043 acc8Comp constant 4
1044 brne 1218
1045 acc8= constant 85
1046 call writeLineAcc8
1047 br 1221
1048 acc16= constant 999
1049 call writeLineAcc16
1050 ;test15.j(157)     if (0x04 + 0x03 | fb1 == 0x1F) println (86); else println (999);
1051 acc8= constant 4
1052 acc8+ constant 3
1053 acc8Or constant 28
1054 acc8Comp constant 31
1055 brne 1231
1056 acc8= constant 86
1057 call writeLineAcc8
1058 br 1234
1059 acc16= constant 999
1060 call writeLineAcc16
1061 ;test15.j(158)     if (0x04 + 0x03 ^ fb1 == 0x1B) println (87); else println (999);
1062 acc8= constant 4
1063 acc8+ constant 3
1064 acc8Xor constant 28
1065 acc8Comp constant 27
1066 brne 1244
1067 acc8= constant 87
1068 call writeLineAcc8
1069 br 1248
1070 acc16= constant 999
1071 call writeLineAcc16
1072 ;test15.j(159)     //acc word/final var word
1073 ;test15.j(160)     if (0x1000 + 0x0234 & fw1 == 0x0224) println (88); else println (999);
1074 acc16= constant 4096
1075 acc16+ constant 564
1076 acc16And constant 812
1077 acc16Comp constant 548
1078 brne 1258
1079 acc8= constant 88
1080 call writeLineAcc8
1081 br 1261
1082 acc16= constant 999
1083 call writeLineAcc16
1084 ;test15.j(161)     if (0x1000 + 0x0234 | fw1 == 0x133C) println (89); else println (999);
1085 acc16= constant 4096
1086 acc16+ constant 564
1087 acc16Or constant 812
1088 acc16Comp constant 4924
1089 brne 1271
1090 acc8= constant 89
1091 call writeLineAcc8
1092 br 1274
1093 acc16= constant 999
1094 call writeLineAcc16
1095 ;test15.j(162)     if (0x1000 + 0x0234 ^ fw1 == 0x1118) println (90); else println (999);
1096 acc16= constant 4096
1097 acc16+ constant 564
1098 acc16Xor constant 812
1099 acc16Comp constant 4376
1100 brne 1284
1101 acc8= constant 90
1102 call writeLineAcc8
1103 br 1288
1104 acc16= constant 999
1105 call writeLineAcc16
1106 ;test15.j(163)     //acc byte/final var word
1107 ;test15.j(164)     if (0x10 + 0x0C & fw2 == 0x0014) println (91); else println (999);
1108 acc8= constant 16
1109 acc8+ constant 12
1110 acc8ToAcc16
1111 acc16And constant 4660
1112 acc8= constant 20
1113 acc16CompareAcc8
1114 brne 1300
1115 acc8= constant 91
1116 call writeLineAcc8
1117 br 1303
1118 acc16= constant 999
1119 call writeLineAcc16
1120 ;test15.j(165)     if (0x10 + 0x0C | fw2 == 0x123C) println (92); else println (999);
1121 acc8= constant 16
1122 acc8+ constant 12
1123 acc8ToAcc16
1124 acc16Or constant 4660
1125 acc16Comp constant 4668
1126 brne 1314
1127 acc8= constant 92
1128 call writeLineAcc8
1129 br 1317
1130 acc16= constant 999
1131 call writeLineAcc16
1132 ;test15.j(166)     if (0x10 + 0x0C ^ fw2 == 0x1228) println (93); else println (999);
1133 acc8= constant 16
1134 acc8+ constant 12
1135 acc8ToAcc16
1136 acc16Xor constant 4660
1137 acc16Comp constant 4648
1138 brne 1328
1139 acc8= constant 93
1140 call writeLineAcc8
1141 br 1332
1142 acc16= constant 999
1143 call writeLineAcc16
1144 ;test15.j(167)     //acc word/final var byte
1145 ;test15.j(168)     if (0x1000 + 0x0234 & fb1 == 0x0014) println (94); else println (999);
1146 acc16= constant 4096
1147 acc16+ constant 564
1148 acc16And constant 28
1149 acc8= constant 20
1150 acc16CompareAcc8
1151 brne 1343
1152 acc8= constant 94
1153 call writeLineAcc8
1154 br 1346
1155 acc16= constant 999
1156 call writeLineAcc16
1157 ;test15.j(169)     if (0x1000 + 0x0234 | fb1 == 0x123C) println (95); else println (999);
1158 acc16= constant 4096
1159 acc16+ constant 564
1160 acc16Or constant 28
1161 acc16Comp constant 4668
1162 brne 1356
1163 acc8= constant 95
1164 call writeLineAcc8
1165 br 1359
1166 acc16= constant 999
1167 call writeLineAcc16
1168 ;test15.j(170)     if (0x1000 + 0x0234 ^ fb1 == 0x1228) println (96); else println (999);
1169 acc16= constant 4096
1170 acc16+ constant 564
1171 acc16Xor constant 28
1172 acc16Comp constant 4648
1173 brne 1369
1174 acc8= constant 96
1175 call writeLineAcc8
1176 br 1376
1177 acc16= constant 999
1178 call writeLineAcc16
1179 ;test15.j(171)   
1180 ;test15.j(172)     //var/constant
1181 ;test15.j(173)     //************
1182 ;test15.j(174)     //var byte/constant byte
1183 ;test15.j(175)     if (b2 & 0x1C == 0x04) println (97); else println (999);
1184 acc8= variable 1
1185 acc8And constant 28
1186 acc8Comp constant 4
1187 brne 1385
1188 acc8= constant 97
1189 call writeLineAcc8
1190 br 1388
1191 acc16= constant 999
1192 call writeLineAcc16
1193 ;test15.j(176)     if (b2 | 0x1C == 0x1F) println (98); else println (999);
1194 acc8= variable 1
1195 acc8Or constant 28
1196 acc8Comp constant 31
1197 brne 1397
1198 acc8= constant 98
1199 call writeLineAcc8
1200 br 1400
1201 acc16= constant 999
1202 call writeLineAcc16
1203 ;test15.j(177)     if (b2 ^ 0x1C == 0x1B) println (99); else println (999);
1204 acc8= variable 1
1205 acc8Xor constant 28
1206 acc8Comp constant 27
1207 brne 1409
1208 acc8= constant 99
1209 call writeLineAcc8
1210 br 1413
1211 acc16= constant 999
1212 call writeLineAcc16
1213 ;test15.j(178)     //var word/constant word
1214 ;test15.j(179)     if (w2 & 0x032C == 0x0224) println (100); else println (999);
1215 acc16= variable 4
1216 acc16And constant 812
1217 acc16Comp constant 548
1218 brne 1422
1219 acc8= constant 100
1220 call writeLineAcc8
1221 br 1425
1222 acc16= constant 999
1223 call writeLineAcc16
1224 ;test15.j(180)     if (w2 | 0x032C == 0x133C) println (101); else println (999);
1225 acc16= variable 4
1226 acc16Or constant 812
1227 acc16Comp constant 4924
1228 brne 1434
1229 acc8= constant 101
1230 call writeLineAcc8
1231 br 1437
1232 acc16= constant 999
1233 call writeLineAcc16
1234 ;test15.j(181)     if (w2 ^ 0x032C == 0x1118) println (102); else println (999);
1235 acc16= variable 4
1236 acc16Xor constant 812
1237 acc16Comp constant 4376
1238 brne 1446
1239 acc8= constant 102
1240 call writeLineAcc8
1241 br 1450
1242 acc16= constant 999
1243 call writeLineAcc16
1244 ;test15.j(182)     //var byte/constant word
1245 ;test15.j(183)     if (b1 & 0x1234 == 0x0014) println (103); else println (999);
1246 acc8= variable 0
1247 acc8ToAcc16
1248 acc16And constant 4660
1249 acc8= constant 20
1250 acc16CompareAcc8
1251 brne 1461
1252 acc8= constant 103
1253 call writeLineAcc8
1254 br 1464
1255 acc16= constant 999
1256 call writeLineAcc16
1257 ;test15.j(184)     if (b1 | 0x1234 == 0x123C) println (104); else println (999);
1258 acc8= variable 0
1259 acc8ToAcc16
1260 acc16Or constant 4660
1261 acc16Comp constant 4668
1262 brne 1474
1263 acc8= constant 104
1264 call writeLineAcc8
1265 br 1477
1266 acc16= constant 999
1267 call writeLineAcc16
1268 ;test15.j(185)     if (b1 ^ 0x1234 == 0x1228) println (105); else println (999);
1269 acc8= variable 0
1270 acc8ToAcc16
1271 acc16Xor constant 4660
1272 acc16Comp constant 4648
1273 brne 1487
1274 acc8= constant 105
1275 call writeLineAcc8
1276 br 1491
1277 acc16= constant 999
1278 call writeLineAcc16
1279 ;test15.j(186)     //var word/constant byte
1280 ;test15.j(187)     if (w2 & 0x1C == 0x0014) println (106); else println (999);
1281 acc16= variable 4
1282 acc16And constant 28
1283 acc8= constant 20
1284 acc16CompareAcc8
1285 brne 1501
1286 acc8= constant 106
1287 call writeLineAcc8
1288 br 1504
1289 acc16= constant 999
1290 call writeLineAcc16
1291 ;test15.j(188)     if (w2 | 0x1C == 0x123C) println (107); else println (999);
1292 acc16= variable 4
1293 acc16Or constant 28
1294 acc16Comp constant 4668
1295 brne 1513
1296 acc8= constant 107
1297 call writeLineAcc8
1298 br 1516
1299 acc16= constant 999
1300 call writeLineAcc16
1301 ;test15.j(189)     if (w2 ^ 0x1C == 0x1228) println (108); else println (999);
1302 acc16= variable 4
1303 acc16Xor constant 28
1304 acc16Comp constant 4648
1305 brne 1525
1306 acc8= constant 108
1307 call writeLineAcc8
1308 br 1532
1309 acc16= constant 999
1310 call writeLineAcc16
1311 ;test15.j(190)   
1312 ;test15.j(191)     //var/acc
1313 ;test15.j(192)     //*******
1314 ;test15.j(193)     //var byte/acc byte
1315 ;test15.j(194)     if (b2 & (0x10 + 0x0C) == 0x04) println (109); else println (999);
1316 acc8= variable 1
1317 <acc8= constant 16
1318 acc8+ constant 12
1319 acc8And unstack8
1320 acc8Comp constant 4
1321 brne 1543
1322 acc8= constant 109
1323 call writeLineAcc8
1324 br 1546
1325 acc16= constant 999
1326 call writeLineAcc16
1327 ;test15.j(195)     if (b2 | (0x10 + 0x0C) == 0x1F) println (110); else println (999);
1328 acc8= variable 1
1329 <acc8= constant 16
1330 acc8+ constant 12
1331 acc8Or unstack8
1332 acc8Comp constant 31
1333 brne 1557
1334 acc8= constant 110
1335 call writeLineAcc8
1336 br 1560
1337 acc16= constant 999
1338 call writeLineAcc16
1339 ;test15.j(196)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (111); else println (999);
1340 acc8= variable 1
1341 <acc8= constant 16
1342 acc8+ constant 12
1343 acc8Xor unstack8
1344 acc8Comp constant 27
1345 brne 1571
1346 acc8= constant 111
1347 call writeLineAcc8
1348 br 1575
1349 acc16= constant 999
1350 call writeLineAcc16
1351 ;test15.j(197)     //var word/acc word
1352 ;test15.j(198)     if (w2 & 0x0100 + 0x022C == 0x0224) println (112); else println (999);
1353 acc16= variable 4
1354 <acc16= constant 256
1355 acc16+ constant 556
1356 acc16And unstack16
1357 acc16Comp constant 548
1358 brne 1586
1359 acc8= constant 112
1360 call writeLineAcc8
1361 br 1589
1362 acc16= constant 999
1363 call writeLineAcc16
1364 ;test15.j(199)     if (w2 | 0x0100 + 0x022C == 0x133C) println (113); else println (999);
1365 acc16= variable 4
1366 <acc16= constant 256
1367 acc16+ constant 556
1368 acc16Or unstack16
1369 acc16Comp constant 4924
1370 brne 1600
1371 acc8= constant 113
1372 call writeLineAcc8
1373 br 1603
1374 acc16= constant 999
1375 call writeLineAcc16
1376 ;test15.j(200)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (114); else println (999);
1377 acc16= variable 4
1378 <acc16= constant 256
1379 acc16+ constant 556
1380 acc16Xor unstack16
1381 acc16Comp constant 4376
1382 brne 1614
1383 acc8= constant 114
1384 call writeLineAcc8
1385 br 1618
1386 acc16= constant 999
1387 call writeLineAcc16
1388 ;test15.j(201)     //var byte/acc word
1389 ;test15.j(202)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (115); else println (999);
1390 acc8= variable 0
1391 acc16= constant 4096
1392 acc16+ constant 564
1393 acc16And acc8
1394 acc8= constant 20
1395 acc16CompareAcc8
1396 brne 1630
1397 acc8= constant 115
1398 call writeLineAcc8
1399 br 1633
1400 acc16= constant 999
1401 call writeLineAcc16
1402 ;test15.j(203)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (116); else println (999);
1403 acc8= variable 0
1404 acc16= constant 4096
1405 acc16+ constant 564
1406 acc16Or acc8
1407 acc16Comp constant 4668
1408 brne 1644
1409 acc8= constant 116
1410 call writeLineAcc8
1411 br 1647
1412 acc16= constant 999
1413 call writeLineAcc16
1414 ;test15.j(204)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (117); else println (999);
1415 acc8= variable 0
1416 acc16= constant 4096
1417 acc16+ constant 564
1418 acc16Xor acc8
1419 acc16Comp constant 4648
1420 brne 1658
1421 acc8= constant 117
1422 call writeLineAcc8
1423 br 1662
1424 acc16= constant 999
1425 call writeLineAcc16
1426 ;test15.j(205)     //var word/acc byte
1427 ;test15.j(206)     if (w2 & 0x10 + 0x0C == 0x0014) println (118); else println (999);
1428 acc16= variable 4
1429 acc8= constant 16
1430 acc8+ constant 12
1431 acc16And acc8
1432 acc8= constant 20
1433 acc16CompareAcc8
1434 brne 1674
1435 acc8= constant 118
1436 call writeLineAcc8
1437 br 1677
1438 acc16= constant 999
1439 call writeLineAcc16
1440 ;test15.j(207)     if (w2 | 0x10 + 0x0C == 0x123C) println (119); else println (999);
1441 acc16= variable 4
1442 acc8= constant 16
1443 acc8+ constant 12
1444 acc16Or acc8
1445 acc16Comp constant 4668
1446 brne 1688
1447 acc8= constant 119
1448 call writeLineAcc8
1449 br 1691
1450 acc16= constant 999
1451 call writeLineAcc16
1452 ;test15.j(208)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (120); else println (999);
1453 acc16= variable 4
1454 acc8= constant 16
1455 acc8+ constant 12
1456 acc16Xor acc8
1457 acc16Comp constant 4648
1458 brne 1702
1459 acc8= constant 120
1460 call writeLineAcc8
1461 br 1709
1462 acc16= constant 999
1463 call writeLineAcc16
1464 ;test15.j(209)   
1465 ;test15.j(210)     //var/var
1466 ;test15.j(211)     //*******
1467 ;test15.j(212)     //var byte/var byte
1468 ;test15.j(213)     if (b2 & b1 == 0x04) println (121); else println (999);
1469 acc8= variable 1
1470 acc8And variable 0
1471 acc8Comp constant 4
1472 brne 1718
1473 acc8= constant 121
1474 call writeLineAcc8
1475 br 1721
1476 acc16= constant 999
1477 call writeLineAcc16
1478 ;test15.j(214)     if (b2 | b1 == 0x1F) println (122); else println (999);
1479 acc8= variable 1
1480 acc8Or variable 0
1481 acc8Comp constant 31
1482 brne 1730
1483 acc8= constant 122
1484 call writeLineAcc8
1485 br 1733
1486 acc16= constant 999
1487 call writeLineAcc16
1488 ;test15.j(215)     if (b2 ^ b1 == 0x1B) println (123); else println (999);
1489 acc8= variable 1
1490 acc8Xor variable 0
1491 acc8Comp constant 27
1492 brne 1742
1493 acc8= constant 123
1494 call writeLineAcc8
1495 br 1746
1496 acc16= constant 999
1497 call writeLineAcc16
1498 ;test15.j(216)     //var word/var word
1499 ;test15.j(217)     if (w2 & w1 == 0x0224) println (124); else println (999);
1500 acc16= variable 4
1501 acc16And variable 2
1502 acc16Comp constant 548
1503 brne 1755
1504 acc8= constant 124
1505 call writeLineAcc8
1506 br 1758
1507 acc16= constant 999
1508 call writeLineAcc16
1509 ;test15.j(218)     if (w2 | w1 == 0x133C) println (125); else println (999);
1510 acc16= variable 4
1511 acc16Or variable 2
1512 acc16Comp constant 4924
1513 brne 1767
1514 acc8= constant 125
1515 call writeLineAcc8
1516 br 1770
1517 acc16= constant 999
1518 call writeLineAcc16
1519 ;test15.j(219)     if (w2 ^ w1 == 0x1118) println (126); else println (999);
1520 acc16= variable 4
1521 acc16Xor variable 2
1522 acc16Comp constant 4376
1523 brne 1779
1524 acc8= constant 126
1525 call writeLineAcc8
1526 br 1783
1527 acc16= constant 999
1528 call writeLineAcc16
1529 ;test15.j(220)     //var byte/var word
1530 ;test15.j(221)     if (b1 & w2 == 0x0014) println (127); else println (999);
1531 acc8= variable 0
1532 acc8ToAcc16
1533 acc16And variable 4
1534 acc8= constant 20
1535 acc16CompareAcc8
1536 brne 1794
1537 acc8= constant 127
1538 call writeLineAcc8
1539 br 1797
1540 acc16= constant 999
1541 call writeLineAcc16
1542 ;test15.j(222)     if (b1 | w2 == 0x123C) println (128); else println (999);
1543 acc8= variable 0
1544 acc8ToAcc16
1545 acc16Or variable 4
1546 acc16Comp constant 4668
1547 brne 1807
1548 acc8= constant 128
1549 call writeLineAcc8
1550 br 1810
1551 acc16= constant 999
1552 call writeLineAcc16
1553 ;test15.j(223)     if (b1 ^ w2 == 0x1228) println (129); else println (999);
1554 acc8= variable 0
1555 acc8ToAcc16
1556 acc16Xor variable 4
1557 acc16Comp constant 4648
1558 brne 1820
1559 acc8= constant 129
1560 call writeLineAcc8
1561 br 1824
1562 acc16= constant 999
1563 call writeLineAcc16
1564 ;test15.j(224)     //var word/var byte
1565 ;test15.j(225)     if (w2 & b1 == 0x0014) println (130); else println (999);
1566 acc16= variable 4
1567 acc16And variable 0
1568 acc8= constant 20
1569 acc16CompareAcc8
1570 brne 1834
1571 acc8= constant 130
1572 call writeLineAcc8
1573 br 1837
1574 acc16= constant 999
1575 call writeLineAcc16
1576 ;test15.j(226)     if (w2 | b1 == 0x123C) println (131); else println (999);
1577 acc16= variable 4
1578 acc16Or variable 0
1579 acc16Comp constant 4668
1580 brne 1846
1581 acc8= constant 131
1582 call writeLineAcc8
1583 br 1849
1584 acc16= constant 999
1585 call writeLineAcc16
1586 ;test15.j(227)     if (w2 ^ b1 == 0x1228) println (132); else println (999);
1587 acc16= variable 4
1588 acc16Xor variable 0
1589 acc16Comp constant 4648
1590 brne 1858
1591 acc8= constant 132
1592 call writeLineAcc8
1593 br 1865
1594 acc16= constant 999
1595 call writeLineAcc16
1596 ;test15.j(228)   
1597 ;test15.j(229)     //var/final var
1598 ;test15.j(230)     //*************
1599 ;test15.j(231)     //var byte/final var byte
1600 ;test15.j(232)     if (b2 & fb1 == 0x04) println (133); else println (999);
1601 acc8= variable 1
1602 acc8And constant 28
1603 acc8Comp constant 4
1604 brne 1874
1605 acc8= constant 133
1606 call writeLineAcc8
1607 br 1877
1608 acc16= constant 999
1609 call writeLineAcc16
1610 ;test15.j(233)     if (b2 | fb1 == 0x1F) println (134); else println (999);
1611 acc8= variable 1
1612 acc8Or constant 28
1613 acc8Comp constant 31
1614 brne 1886
1615 acc8= constant 134
1616 call writeLineAcc8
1617 br 1889
1618 acc16= constant 999
1619 call writeLineAcc16
1620 ;test15.j(234)     if (b2 ^ fb1 == 0x1B) println (135); else println (999);
1621 acc8= variable 1
1622 acc8Xor constant 28
1623 acc8Comp constant 27
1624 brne 1898
1625 acc8= constant 135
1626 call writeLineAcc8
1627 br 1902
1628 acc16= constant 999
1629 call writeLineAcc16
1630 ;test15.j(235)     //var word/final var word
1631 ;test15.j(236)     if (w2 & fw1 == 0x0224) println (136); else println (999);
1632 acc16= variable 4
1633 acc16And constant 812
1634 acc16Comp constant 548
1635 brne 1911
1636 acc8= constant 136
1637 call writeLineAcc8
1638 br 1914
1639 acc16= constant 999
1640 call writeLineAcc16
1641 ;test15.j(237)     if (w2 | fw1 == 0x133C) println (137); else println (999);
1642 acc16= variable 4
1643 acc16Or constant 812
1644 acc16Comp constant 4924
1645 brne 1923
1646 acc8= constant 137
1647 call writeLineAcc8
1648 br 1926
1649 acc16= constant 999
1650 call writeLineAcc16
1651 ;test15.j(238)     if (w2 ^ fw1 == 0x1118) println (138); else println (999);
1652 acc16= variable 4
1653 acc16Xor constant 812
1654 acc16Comp constant 4376
1655 brne 1935
1656 acc8= constant 138
1657 call writeLineAcc8
1658 br 1939
1659 acc16= constant 999
1660 call writeLineAcc16
1661 ;test15.j(239)     //var byte/final var word
1662 ;test15.j(240)     if (b1 & fw2 == 0x0014) println (139); else println (999);
1663 acc8= variable 0
1664 acc8ToAcc16
1665 acc16And constant 4660
1666 acc8= constant 20
1667 acc16CompareAcc8
1668 brne 1950
1669 acc8= constant 139
1670 call writeLineAcc8
1671 br 1953
1672 acc16= constant 999
1673 call writeLineAcc16
1674 ;test15.j(241)     if (b1 | fw2 == 0x123C) println (140); else println (999);
1675 acc8= variable 0
1676 acc8ToAcc16
1677 acc16Or constant 4660
1678 acc16Comp constant 4668
1679 brne 1963
1680 acc8= constant 140
1681 call writeLineAcc8
1682 br 1966
1683 acc16= constant 999
1684 call writeLineAcc16
1685 ;test15.j(242)     if (b1 ^ fw2 == 0x1228) println (141); else println (999);
1686 acc8= variable 0
1687 acc8ToAcc16
1688 acc16Xor constant 4660
1689 acc16Comp constant 4648
1690 brne 1976
1691 acc8= constant 141
1692 call writeLineAcc8
1693 br 1980
1694 acc16= constant 999
1695 call writeLineAcc16
1696 ;test15.j(243)     //var word/final var byte
1697 ;test15.j(244)     if (w2 & fb1 == 0x0014) println (142); else println (999);
1698 acc16= variable 4
1699 acc16And constant 28
1700 acc8= constant 20
1701 acc16CompareAcc8
1702 brne 1990
1703 acc8= constant 142
1704 call writeLineAcc8
1705 br 1993
1706 acc16= constant 999
1707 call writeLineAcc16
1708 ;test15.j(245)     if (w2 | fb1 == 0x123C) println (143); else println (999);
1709 acc16= variable 4
1710 acc16Or constant 28
1711 acc16Comp constant 4668
1712 brne 2002
1713 acc8= constant 143
1714 call writeLineAcc8
1715 br 2005
1716 acc16= constant 999
1717 call writeLineAcc16
1718 ;test15.j(246)     if (w2 ^ fb1 == 0x1228) println (144); else println (999);
1719 acc16= variable 4
1720 acc16Xor constant 28
1721 acc16Comp constant 4648
1722 brne 2014
1723 acc8= constant 144
1724 call writeLineAcc8
1725 br 2021
1726 acc16= constant 999
1727 call writeLineAcc16
1728 ;test15.j(247)   
1729 ;test15.j(248)     //final var/constant
1730 ;test15.j(249)     //******************
1731 ;test15.j(250)     //final var byte/constant byte
1732 ;test15.j(251)     if (b2 & 0x1C == 0x04) println (145); else println (999);
1733 acc8= variable 1
1734 acc8And constant 28
1735 acc8Comp constant 4
1736 brne 2030
1737 acc8= constant 145
1738 call writeLineAcc8
1739 br 2033
1740 acc16= constant 999
1741 call writeLineAcc16
1742 ;test15.j(252)     if (b2 | 0x1C == 0x1F) println (146); else println (999);
1743 acc8= variable 1
1744 acc8Or constant 28
1745 acc8Comp constant 31
1746 brne 2042
1747 acc8= constant 146
1748 call writeLineAcc8
1749 br 2045
1750 acc16= constant 999
1751 call writeLineAcc16
1752 ;test15.j(253)     if (b2 ^ 0x1C == 0x1B) println (147); else println (999);
1753 acc8= variable 1
1754 acc8Xor constant 28
1755 acc8Comp constant 27
1756 brne 2054
1757 acc8= constant 147
1758 call writeLineAcc8
1759 br 2058
1760 acc16= constant 999
1761 call writeLineAcc16
1762 ;test15.j(254)     //final var word/constant word
1763 ;test15.j(255)     if (w2 & 0x032C == 0x0224) println (148); else println (999);
1764 acc16= variable 4
1765 acc16And constant 812
1766 acc16Comp constant 548
1767 brne 2067
1768 acc8= constant 148
1769 call writeLineAcc8
1770 br 2070
1771 acc16= constant 999
1772 call writeLineAcc16
1773 ;test15.j(256)     if (w2 | 0x032C == 0x133C) println (149); else println (999);
1774 acc16= variable 4
1775 acc16Or constant 812
1776 acc16Comp constant 4924
1777 brne 2079
1778 acc8= constant 149
1779 call writeLineAcc8
1780 br 2082
1781 acc16= constant 999
1782 call writeLineAcc16
1783 ;test15.j(257)     if (w2 ^ 0x032C == 0x1118) println (150); else println (999);
1784 acc16= variable 4
1785 acc16Xor constant 812
1786 acc16Comp constant 4376
1787 brne 2091
1788 acc8= constant 150
1789 call writeLineAcc8
1790 br 2095
1791 acc16= constant 999
1792 call writeLineAcc16
1793 ;test15.j(258)     //final var byte/constant word
1794 ;test15.j(259)     if (b1 & 0x1234 == 0x0014) println (151); else println (999);
1795 acc8= variable 0
1796 acc8ToAcc16
1797 acc16And constant 4660
1798 acc8= constant 20
1799 acc16CompareAcc8
1800 brne 2106
1801 acc8= constant 151
1802 call writeLineAcc8
1803 br 2109
1804 acc16= constant 999
1805 call writeLineAcc16
1806 ;test15.j(260)     if (b1 | 0x1234 == 0x123C) println (152); else println (999);
1807 acc8= variable 0
1808 acc8ToAcc16
1809 acc16Or constant 4660
1810 acc16Comp constant 4668
1811 brne 2119
1812 acc8= constant 152
1813 call writeLineAcc8
1814 br 2122
1815 acc16= constant 999
1816 call writeLineAcc16
1817 ;test15.j(261)     if (b1 ^ 0x1234 == 0x1228) println (153); else println (999);
1818 acc8= variable 0
1819 acc8ToAcc16
1820 acc16Xor constant 4660
1821 acc16Comp constant 4648
1822 brne 2132
1823 acc8= constant 153
1824 call writeLineAcc8
1825 br 2136
1826 acc16= constant 999
1827 call writeLineAcc16
1828 ;test15.j(262)     //final var word/constant byte
1829 ;test15.j(263)     if (w2 & 0x1C == 0x0014) println (154); else println (999);
1830 acc16= variable 4
1831 acc16And constant 28
1832 acc8= constant 20
1833 acc16CompareAcc8
1834 brne 2146
1835 acc8= constant 154
1836 call writeLineAcc8
1837 br 2149
1838 acc16= constant 999
1839 call writeLineAcc16
1840 ;test15.j(264)     if (w2 | 0x1C == 0x123C) println (155); else println (999);
1841 acc16= variable 4
1842 acc16Or constant 28
1843 acc16Comp constant 4668
1844 brne 2158
1845 acc8= constant 155
1846 call writeLineAcc8
1847 br 2161
1848 acc16= constant 999
1849 call writeLineAcc16
1850 ;test15.j(265)     if (w2 ^ 0x1C == 0x1228) println (156); else println (999);
1851 acc16= variable 4
1852 acc16Xor constant 28
1853 acc16Comp constant 4648
1854 brne 2170
1855 acc8= constant 156
1856 call writeLineAcc8
1857 br 2177
1858 acc16= constant 999
1859 call writeLineAcc16
1860 ;test15.j(266)   
1861 ;test15.j(267)     //final var/acc
1862 ;test15.j(268)     //*************
1863 ;test15.j(269)     //final var byte/acc byte
1864 ;test15.j(270)     if (b2 & (0x10 + 0x0C) == 0x04) println (157); else println (999);
1865 acc8= variable 1
1866 <acc8= constant 16
1867 acc8+ constant 12
1868 acc8And unstack8
1869 acc8Comp constant 4
1870 brne 2188
1871 acc8= constant 157
1872 call writeLineAcc8
1873 br 2191
1874 acc16= constant 999
1875 call writeLineAcc16
1876 ;test15.j(271)     if (b2 | (0x10 + 0x0C) == 0x1F) println (158); else println (999);
1877 acc8= variable 1
1878 <acc8= constant 16
1879 acc8+ constant 12
1880 acc8Or unstack8
1881 acc8Comp constant 31
1882 brne 2202
1883 acc8= constant 158
1884 call writeLineAcc8
1885 br 2205
1886 acc16= constant 999
1887 call writeLineAcc16
1888 ;test15.j(272)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (159); else println (999);
1889 acc8= variable 1
1890 <acc8= constant 16
1891 acc8+ constant 12
1892 acc8Xor unstack8
1893 acc8Comp constant 27
1894 brne 2216
1895 acc8= constant 159
1896 call writeLineAcc8
1897 br 2220
1898 acc16= constant 999
1899 call writeLineAcc16
1900 ;test15.j(273)     //final var word/acc word
1901 ;test15.j(274)     if (w2 & 0x0100 + 0x022C == 0x0224) println (160); else println (999);
1902 acc16= variable 4
1903 <acc16= constant 256
1904 acc16+ constant 556
1905 acc16And unstack16
1906 acc16Comp constant 548
1907 brne 2231
1908 acc8= constant 160
1909 call writeLineAcc8
1910 br 2234
1911 acc16= constant 999
1912 call writeLineAcc16
1913 ;test15.j(275)     if (w2 | 0x0100 + 0x022C == 0x133C) println (161); else println (999);
1914 acc16= variable 4
1915 <acc16= constant 256
1916 acc16+ constant 556
1917 acc16Or unstack16
1918 acc16Comp constant 4924
1919 brne 2245
1920 acc8= constant 161
1921 call writeLineAcc8
1922 br 2248
1923 acc16= constant 999
1924 call writeLineAcc16
1925 ;test15.j(276)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (162); else println (999);
1926 acc16= variable 4
1927 <acc16= constant 256
1928 acc16+ constant 556
1929 acc16Xor unstack16
1930 acc16Comp constant 4376
1931 brne 2259
1932 acc8= constant 162
1933 call writeLineAcc8
1934 br 2263
1935 acc16= constant 999
1936 call writeLineAcc16
1937 ;test15.j(277)     //final var byte/acc word
1938 ;test15.j(278)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (163); else println (999);
1939 acc8= variable 0
1940 acc16= constant 4096
1941 acc16+ constant 564
1942 acc16And acc8
1943 acc8= constant 20
1944 acc16CompareAcc8
1945 brne 2275
1946 acc8= constant 163
1947 call writeLineAcc8
1948 br 2278
1949 acc16= constant 999
1950 call writeLineAcc16
1951 ;test15.j(279)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (164); else println (999);
1952 acc8= variable 0
1953 acc16= constant 4096
1954 acc16+ constant 564
1955 acc16Or acc8
1956 acc16Comp constant 4668
1957 brne 2289
1958 acc8= constant 164
1959 call writeLineAcc8
1960 br 2292
1961 acc16= constant 999
1962 call writeLineAcc16
1963 ;test15.j(280)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (165); else println (999);
1964 acc8= variable 0
1965 acc16= constant 4096
1966 acc16+ constant 564
1967 acc16Xor acc8
1968 acc16Comp constant 4648
1969 brne 2303
1970 acc8= constant 165
1971 call writeLineAcc8
1972 br 2307
1973 acc16= constant 999
1974 call writeLineAcc16
1975 ;test15.j(281)     //final var word/acc byte
1976 ;test15.j(282)     if (w2 & 0x10 + 0x0C == 0x0014) println (166); else println (999);
1977 acc16= variable 4
1978 acc8= constant 16
1979 acc8+ constant 12
1980 acc16And acc8
1981 acc8= constant 20
1982 acc16CompareAcc8
1983 brne 2319
1984 acc8= constant 166
1985 call writeLineAcc8
1986 br 2322
1987 acc16= constant 999
1988 call writeLineAcc16
1989 ;test15.j(283)     if (w2 | 0x10 + 0x0C == 0x123C) println (167); else println (999);
1990 acc16= variable 4
1991 acc8= constant 16
1992 acc8+ constant 12
1993 acc16Or acc8
1994 acc16Comp constant 4668
1995 brne 2333
1996 acc8= constant 167
1997 call writeLineAcc8
1998 br 2336
1999 acc16= constant 999
2000 call writeLineAcc16
2001 ;test15.j(284)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (168); else println (999);
2002 acc16= variable 4
2003 acc8= constant 16
2004 acc8+ constant 12
2005 acc16Xor acc8
2006 acc16Comp constant 4648
2007 brne 2347
2008 acc8= constant 168
2009 call writeLineAcc8
2010 br 2354
2011 acc16= constant 999
2012 call writeLineAcc16
2013 ;test15.j(285)   
2014 ;test15.j(286)     //final var/var
2015 ;test15.j(287)     //*************
2016 ;test15.j(288)     //final var byte/var byte
2017 ;test15.j(289)     if (b2 & b1 == 0x04) println (169); else println (999);
2018 acc8= variable 1
2019 acc8And variable 0
2020 acc8Comp constant 4
2021 brne 2363
2022 acc8= constant 169
2023 call writeLineAcc8
2024 br 2366
2025 acc16= constant 999
2026 call writeLineAcc16
2027 ;test15.j(290)     if (b2 | b1 == 0x1F) println (170); else println (999);
2028 acc8= variable 1
2029 acc8Or variable 0
2030 acc8Comp constant 31
2031 brne 2375
2032 acc8= constant 170
2033 call writeLineAcc8
2034 br 2378
2035 acc16= constant 999
2036 call writeLineAcc16
2037 ;test15.j(291)     if (b2 ^ b1 == 0x1B) println (171); else println (999);
2038 acc8= variable 1
2039 acc8Xor variable 0
2040 acc8Comp constant 27
2041 brne 2387
2042 acc8= constant 171
2043 call writeLineAcc8
2044 br 2391
2045 acc16= constant 999
2046 call writeLineAcc16
2047 ;test15.j(292)     //final var word/var word
2048 ;test15.j(293)     if (w2 & w1 == 0x0224) println (172); else println (999);
2049 acc16= variable 4
2050 acc16And variable 2
2051 acc16Comp constant 548
2052 brne 2400
2053 acc8= constant 172
2054 call writeLineAcc8
2055 br 2403
2056 acc16= constant 999
2057 call writeLineAcc16
2058 ;test15.j(294)     if (w2 | w1 == 0x133C) println (173); else println (999);
2059 acc16= variable 4
2060 acc16Or variable 2
2061 acc16Comp constant 4924
2062 brne 2412
2063 acc8= constant 173
2064 call writeLineAcc8
2065 br 2415
2066 acc16= constant 999
2067 call writeLineAcc16
2068 ;test15.j(295)     if (w2 ^ w1 == 0x1118) println (174); else println (999);
2069 acc16= variable 4
2070 acc16Xor variable 2
2071 acc16Comp constant 4376
2072 brne 2424
2073 acc8= constant 174
2074 call writeLineAcc8
2075 br 2428
2076 acc16= constant 999
2077 call writeLineAcc16
2078 ;test15.j(296)     //final var byte/var word
2079 ;test15.j(297)     if (b1 & w2 == 0x0014) println (175); else println (999);
2080 acc8= variable 0
2081 acc8ToAcc16
2082 acc16And variable 4
2083 acc8= constant 20
2084 acc16CompareAcc8
2085 brne 2439
2086 acc8= constant 175
2087 call writeLineAcc8
2088 br 2442
2089 acc16= constant 999
2090 call writeLineAcc16
2091 ;test15.j(298)     if (b1 | w2 == 0x123C) println (176); else println (999);
2092 acc8= variable 0
2093 acc8ToAcc16
2094 acc16Or variable 4
2095 acc16Comp constant 4668
2096 brne 2452
2097 acc8= constant 176
2098 call writeLineAcc8
2099 br 2455
2100 acc16= constant 999
2101 call writeLineAcc16
2102 ;test15.j(299)     if (b1 ^ w2 == 0x1228) println (177); else println (999);
2103 acc8= variable 0
2104 acc8ToAcc16
2105 acc16Xor variable 4
2106 acc16Comp constant 4648
2107 brne 2465
2108 acc8= constant 177
2109 call writeLineAcc8
2110 br 2469
2111 acc16= constant 999
2112 call writeLineAcc16
2113 ;test15.j(300)     //final var word/var byte
2114 ;test15.j(301)     if (w2 & b1 == 0x0014) println (178); else println (999);
2115 acc16= variable 4
2116 acc16And variable 0
2117 acc8= constant 20
2118 acc16CompareAcc8
2119 brne 2479
2120 acc8= constant 178
2121 call writeLineAcc8
2122 br 2482
2123 acc16= constant 999
2124 call writeLineAcc16
2125 ;test15.j(302)     if (w2 | b1 == 0x123C) println (179); else println (999);
2126 acc16= variable 4
2127 acc16Or variable 0
2128 acc16Comp constant 4668
2129 brne 2491
2130 acc8= constant 179
2131 call writeLineAcc8
2132 br 2494
2133 acc16= constant 999
2134 call writeLineAcc16
2135 ;test15.j(303)     if (w2 ^ b1 == 0x1228) println (180); else println (999);
2136 acc16= variable 4
2137 acc16Xor variable 0
2138 acc16Comp constant 4648
2139 brne 2503
2140 acc8= constant 180
2141 call writeLineAcc8
2142 br 2510
2143 acc16= constant 999
2144 call writeLineAcc16
2145 ;test15.j(304)   
2146 ;test15.j(305)     //final var/final var
2147 ;test15.j(306)     //*******************
2148 ;test15.j(307)     //final var byte/final var byte
2149 ;test15.j(308)     if (fb2 & fb1 == 0x04) println (181); else println (999);
2150 acc8= constant 7
2151 acc8And constant 28
2152 acc8Comp constant 4
2153 brne 2519
2154 acc8= constant 181
2155 call writeLineAcc8
2156 br 2522
2157 acc16= constant 999
2158 call writeLineAcc16
2159 ;test15.j(309)     if (fb2 | fb1 == 0x1F) println (182); else println (999);
2160 acc8= constant 7
2161 acc8Or constant 28
2162 acc8Comp constant 31
2163 brne 2531
2164 acc8= constant 182
2165 call writeLineAcc8
2166 br 2534
2167 acc16= constant 999
2168 call writeLineAcc16
2169 ;test15.j(310)     if (fb2 ^ fb1 == 0x1B) println (183); else println (999);
2170 acc8= constant 7
2171 acc8Xor constant 28
2172 acc8Comp constant 27
2173 brne 2543
2174 acc8= constant 183
2175 call writeLineAcc8
2176 br 2547
2177 acc16= constant 999
2178 call writeLineAcc16
2179 ;test15.j(311)     //final var word/final var word
2180 ;test15.j(312)     if (fw2 & fw1 == 0x0224) println (184); else println (999);
2181 acc16= constant 4660
2182 acc16And constant 812
2183 acc16Comp constant 548
2184 brne 2556
2185 acc8= constant 184
2186 call writeLineAcc8
2187 br 2559
2188 acc16= constant 999
2189 call writeLineAcc16
2190 ;test15.j(313)     if (fw2 | fw1 == 0x133C) println (185); else println (999);
2191 acc16= constant 4660
2192 acc16Or constant 812
2193 acc16Comp constant 4924
2194 brne 2568
2195 acc8= constant 185
2196 call writeLineAcc8
2197 br 2571
2198 acc16= constant 999
2199 call writeLineAcc16
2200 ;test15.j(314)     if (fw2 ^ fw1 == 0x1118) println (186); else println (999);
2201 acc16= constant 4660
2202 acc16Xor constant 812
2203 acc16Comp constant 4376
2204 brne 2580
2205 acc8= constant 186
2206 call writeLineAcc8
2207 br 2584
2208 acc16= constant 999
2209 call writeLineAcc16
2210 ;test15.j(315)     //final var byte/final var word
2211 ;test15.j(316)     if (fb1 & fw2 == 0x0014) println (187); else println (999);
2212 acc8= constant 28
2213 acc8ToAcc16
2214 acc16And constant 4660
2215 acc8= constant 20
2216 acc16CompareAcc8
2217 brne 2595
2218 acc8= constant 187
2219 call writeLineAcc8
2220 br 2598
2221 acc16= constant 999
2222 call writeLineAcc16
2223 ;test15.j(317)     if (fb1 | fw2 == 0x123C) println (188); else println (999);
2224 acc8= constant 28
2225 acc8ToAcc16
2226 acc16Or constant 4660
2227 acc16Comp constant 4668
2228 brne 2608
2229 acc8= constant 188
2230 call writeLineAcc8
2231 br 2611
2232 acc16= constant 999
2233 call writeLineAcc16
2234 ;test15.j(318)     if (fb1 ^ fw2 == 0x1228) println (189); else println (999);
2235 acc8= constant 28
2236 acc8ToAcc16
2237 acc16Xor constant 4660
2238 acc16Comp constant 4648
2239 brne 2621
2240 acc8= constant 189
2241 call writeLineAcc8
2242 br 2625
2243 acc16= constant 999
2244 call writeLineAcc16
2245 ;test15.j(319)     //final var word/final var byte
2246 ;test15.j(320)     if (fw2 & fb1 == 0x0014) println (190); else println (999);
2247 acc16= constant 4660
2248 acc16And constant 28
2249 acc8= constant 20
2250 acc16CompareAcc8
2251 brne 2635
2252 acc8= constant 190
2253 call writeLineAcc8
2254 br 2638
2255 acc16= constant 999
2256 call writeLineAcc16
2257 ;test15.j(321)     if (fw2 | fb1 == 0x123C) println (191); else println (999);
2258 acc16= constant 4660
2259 acc16Or constant 28
2260 acc16Comp constant 4668
2261 brne 2647
2262 acc8= constant 191
2263 call writeLineAcc8
2264 br 2650
2265 acc16= constant 999
2266 call writeLineAcc16
2267 ;test15.j(322)     if (fw2 ^ fb1 == 0x1228) println (192); else println (999);
2268 acc16= constant 4660
2269 acc16Xor constant 28
2270 acc16Comp constant 4648
2271 brne 2659
2272 acc8= constant 192
2273 call writeLineAcc8
2274 br 2663
2275 acc16= constant 999
2276 call writeLineAcc16
2277 ;test15.j(323)   
2278 ;test15.j(324)     println("Klaar");
2279 acc16= constant 2284
2280 writeLineString
2281 return
2282 ;test15.j(325)   }
2283 ;test15.j(326) }
2284 stringConstant 0 = "Klaar"
