   0 ;test15.j(0) /* Program to test bitwise operators and, or and xor. */
   1 ;test15.j(1) class TestBitwiseOperators {
   2 ;test15.j(2)   private static byte b1 = 0x1C;
   3 acc8= constant 28
   4 acc8=> variable 0
   5 ;test15.j(3)   private static byte b2 = 0x07;
   6 acc8= constant 7
   7 acc8=> variable 1
   8 ;test15.j(4)   private static word w1 = 0x032C;
   9 acc16= constant 812
  10 acc16=> variable 2
  11 ;test15.j(5)   private static word w2 = 0x1234;
  12 acc16= constant 4660
  13 acc16=> variable 4
  14 ;test15.j(6)   private static final byte fb1 = 0x1C;
  15 ;test15.j(7)   private static final byte fb2 = 0x07;
  16 ;test15.j(8)   private static final word fw1 = 0x032C;
  17 ;test15.j(9)   private static final word fw2 = 0x1234;
  18 ;test15.j(10) 
  19 ;test15.j(11)   public static void main() {
  20 method main [staticLexeme] voidLexeme
  21 ;test15.j(12)     println(0);
  22 acc8= constant 0
  23 call writeLineAcc8
  24 ;test15.j(13)     
  25 ;test15.j(14)     // Possible operand types: constant, acc, var, final var, stack8, stack16.
  26 ;test15.j(15)     // Possible data types: byte, word.
  27 ;test15.j(16)   
  28 ;test15.j(17)     //constant/constant
  29 ;test15.j(18)     //*****************
  30 ;test15.j(19)     //constant byte/constant byte
  31 ;test15.j(20)     if (0x07 & 0x1C == 0x04) println (1); else println (999); //0000.0111 & 0001.1100 = 0000.0100
  32 acc8= constant 7
  33 acc8And constant 28
  34 acc8Comp constant 4
  35 brne 39
  36 acc8= constant 1
  37 call writeLineAcc8
  38 br 42
  39 acc16= constant 999
  40 call writeLineAcc16
  41 ;test15.j(21)     if (0x07 | 0x1C == 0x1F) println (2); else println (999); //0000.0111 | 0001.1100 = 0001.1111
  42 acc8= constant 7
  43 acc8Or constant 28
  44 acc8Comp constant 31
  45 brne 49
  46 acc8= constant 2
  47 call writeLineAcc8
  48 br 52
  49 acc16= constant 999
  50 call writeLineAcc16
  51 ;test15.j(22)     if (0x07 ^ 0x1C == 0x1B) println (3); else println (999); //0000.0111 ^ 0001.1100 = 0001.1011
  52 acc8= constant 7
  53 acc8Xor constant 28
  54 acc8Comp constant 27
  55 brne 59
  56 acc8= constant 3
  57 call writeLineAcc8
  58 br 63
  59 acc16= constant 999
  60 call writeLineAcc16
  61 ;test15.j(23)     //constant word/constant word
  62 ;test15.j(24)     if (0x1234 & 0x032C == 0x0224) println (4); else println (999);
  63 acc16= constant 4660
  64 acc16And constant 812
  65 acc16Comp constant 548
  66 brne 70
  67 acc8= constant 4
  68 call writeLineAcc8
  69 br 74
  70 acc16= constant 999
  71 call writeLineAcc16
  72 ;test15.j(25)     //0001.0010.0011.0100 & 0000.0011.0010.1100 = 0000.0010.0010.0100
  73 ;test15.j(26)     if (0x1234 | 0x032C == 0x133C) println (5); else println (999);
  74 acc16= constant 4660
  75 acc16Or constant 812
  76 acc16Comp constant 4924
  77 brne 81
  78 acc8= constant 5
  79 call writeLineAcc8
  80 br 85
  81 acc16= constant 999
  82 call writeLineAcc16
  83 ;test15.j(27)     //0001.0010.0011.0100 | 0000.0011.0010.1100 = 0001.0011.0011.1100
  84 ;test15.j(28)     if (0x1234 ^ 0x032C == 0x1118) println (6); else println (999);
  85 acc16= constant 4660
  86 acc16Xor constant 812
  87 acc16Comp constant 4376
  88 brne 92
  89 acc8= constant 6
  90 call writeLineAcc8
  91 br 97
  92 acc16= constant 999
  93 call writeLineAcc16
  94 ;test15.j(29)     //0001.0010.0011.0100 ^ 0000.0011.0010.1100 = 0001.0001.0001.1000
  95 ;test15.j(30)     //constant byte/constant word
  96 ;test15.j(31)     if (0x1C & 0x1234 == 0x0014) println (7); else println (999); //0001.1100 & 0001.0010.0011.0100 = 0000.0000.0001.0100
  97 acc8= constant 28
  98 acc8ToAcc16
  99 acc16And constant 4660
 100 acc8= constant 20
 101 acc16CompareAcc8
 102 brne 106
 103 acc8= constant 7
 104 call writeLineAcc8
 105 br 109
 106 acc16= constant 999
 107 call writeLineAcc16
 108 ;test15.j(32)     if (0x1C | 0x1234 == 0x123C) println (8); else println (999); //0001.1100 | 0001.0010.0011.0100 = 0001.0010.0011.1100
 109 acc8= constant 28
 110 acc8ToAcc16
 111 acc16Or constant 4660
 112 acc16Comp constant 4668
 113 brne 117
 114 acc8= constant 8
 115 call writeLineAcc8
 116 br 120
 117 acc16= constant 999
 118 call writeLineAcc16
 119 ;test15.j(33)     if (0x1C ^ 0x1234 == 0x1228) println (9); else println (999); //0001.1100 ^ 0001.0010.0011.0100 = 0001.0010.0010.1000
 120 acc8= constant 28
 121 acc8ToAcc16
 122 acc16Xor constant 4660
 123 acc16Comp constant 4648
 124 brne 128
 125 acc8= constant 9
 126 call writeLineAcc8
 127 br 132
 128 acc16= constant 999
 129 call writeLineAcc16
 130 ;test15.j(34)     //constant word/constant byte
 131 ;test15.j(35)     if (0x1234 & 0x1C == 0x0014) println (10); else println (999); //0001.0010.0011.0100 & 0001.1100 = 0000.0000.0001.0100
 132 acc16= constant 4660
 133 acc16And constant 28
 134 acc8= constant 20
 135 acc16CompareAcc8
 136 brne 140
 137 acc8= constant 10
 138 call writeLineAcc8
 139 br 143
 140 acc16= constant 999
 141 call writeLineAcc16
 142 ;test15.j(36)     if (0x1234 | 0x1C == 0x123C) println (11); else println (999); //0001.0010.0011.0100 | 0001.1100 = 0001.0010.0011.1100
 143 acc16= constant 4660
 144 acc16Or constant 28
 145 acc16Comp constant 4668
 146 brne 150
 147 acc8= constant 11
 148 call writeLineAcc8
 149 br 153
 150 acc16= constant 999
 151 call writeLineAcc16
 152 ;test15.j(37)     if (0x1234 ^ 0x1C == 0x1228) println (12); else println (999); //0001.0010.0011.0100 ^ 0001.1100 = 0001.0010.0010.1000
 153 acc16= constant 4660
 154 acc16Xor constant 28
 155 acc16Comp constant 4648
 156 brne 160
 157 acc8= constant 12
 158 call writeLineAcc8
 159 br 167
 160 acc16= constant 999
 161 call writeLineAcc16
 162 ;test15.j(38)   
 163 ;test15.j(39)     //constant/acc
 164 ;test15.j(40)     //************
 165 ;test15.j(41)     //constant byte/acc byte
 166 ;test15.j(42)     if (0x07 & (0x10 + 0x0C) == 0x04) println (13); else println (999);
 167 acc8= constant 7
 168 <acc8= constant 16
 169 acc8+ constant 12
 170 acc8And unstack8
 171 acc8Comp constant 4
 172 brne 176
 173 acc8= constant 13
 174 call writeLineAcc8
 175 br 179
 176 acc16= constant 999
 177 call writeLineAcc16
 178 ;test15.j(43)     if (0x07 | (0x10 + 0x0C) == 0x1F) println (14); else println (999);
 179 acc8= constant 7
 180 <acc8= constant 16
 181 acc8+ constant 12
 182 acc8Or unstack8
 183 acc8Comp constant 31
 184 brne 188
 185 acc8= constant 14
 186 call writeLineAcc8
 187 br 191
 188 acc16= constant 999
 189 call writeLineAcc16
 190 ;test15.j(44)     if (0x07 ^ (0x10 + 0x0C) == 0x1B) println (15); else println (999);
 191 acc8= constant 7
 192 <acc8= constant 16
 193 acc8+ constant 12
 194 acc8Xor unstack8
 195 acc8Comp constant 27
 196 brne 200
 197 acc8= constant 15
 198 call writeLineAcc8
 199 br 204
 200 acc16= constant 999
 201 call writeLineAcc16
 202 ;test15.j(45)     //constant word/acc word
 203 ;test15.j(46)     if (0x1234 & 0x0100 + 0x022C == 0x0224) println (16); else println (999);
 204 acc16= constant 4660
 205 <acc16= constant 256
 206 acc16+ constant 556
 207 acc16And unstack16
 208 acc16Comp constant 548
 209 brne 213
 210 acc8= constant 16
 211 call writeLineAcc8
 212 br 216
 213 acc16= constant 999
 214 call writeLineAcc16
 215 ;test15.j(47)     if (0x1234 | 0x0100 + 0x022C == 0x133C) println (17); else println (999);
 216 acc16= constant 4660
 217 <acc16= constant 256
 218 acc16+ constant 556
 219 acc16Or unstack16
 220 acc16Comp constant 4924
 221 brne 225
 222 acc8= constant 17
 223 call writeLineAcc8
 224 br 228
 225 acc16= constant 999
 226 call writeLineAcc16
 227 ;test15.j(48)     if (0x1234 ^ 0x0100 + 0x022C == 0x1118) println (18); else println (999);
 228 acc16= constant 4660
 229 <acc16= constant 256
 230 acc16+ constant 556
 231 acc16Xor unstack16
 232 acc16Comp constant 4376
 233 brne 237
 234 acc8= constant 18
 235 call writeLineAcc8
 236 br 241
 237 acc16= constant 999
 238 call writeLineAcc16
 239 ;test15.j(49)     //constant byte/acc word
 240 ;test15.j(50)     if (0x1C & 0x1000 + 0x0234 == 0x0014) println (19); else println (999);
 241 acc8= constant 28
 242 acc16= constant 4096
 243 acc16+ constant 564
 244 acc16And acc8
 245 acc8= constant 20
 246 acc16CompareAcc8
 247 brne 251
 248 acc8= constant 19
 249 call writeLineAcc8
 250 br 254
 251 acc16= constant 999
 252 call writeLineAcc16
 253 ;test15.j(51)     if (0x1C | 0x1000 + 0x0234 == 0x123C) println (20); else println (999);
 254 acc8= constant 28
 255 acc16= constant 4096
 256 acc16+ constant 564
 257 acc16Or acc8
 258 acc16Comp constant 4668
 259 brne 263
 260 acc8= constant 20
 261 call writeLineAcc8
 262 br 266
 263 acc16= constant 999
 264 call writeLineAcc16
 265 ;test15.j(52)     if (0x1C ^ 0x1000 + 0x0234 == 0x1228) println (21); else println (999);
 266 acc8= constant 28
 267 acc16= constant 4096
 268 acc16+ constant 564
 269 acc16Xor acc8
 270 acc16Comp constant 4648
 271 brne 275
 272 acc8= constant 21
 273 call writeLineAcc8
 274 br 279
 275 acc16= constant 999
 276 call writeLineAcc16
 277 ;test15.j(53)     //constant word/acc byte
 278 ;test15.j(54)     if (0x1234 & 0x10 + 0x0C == 0x0014) println (22); else println (999);
 279 acc16= constant 4660
 280 acc8= constant 16
 281 acc8+ constant 12
 282 acc16And acc8
 283 acc8= constant 20
 284 acc16CompareAcc8
 285 brne 289
 286 acc8= constant 22
 287 call writeLineAcc8
 288 br 292
 289 acc16= constant 999
 290 call writeLineAcc16
 291 ;test15.j(55)     if (0x1234 | 0x10 + 0x0C == 0x123C) println (23); else println (999);
 292 acc16= constant 4660
 293 acc8= constant 16
 294 acc8+ constant 12
 295 acc16Or acc8
 296 acc16Comp constant 4668
 297 brne 301
 298 acc8= constant 23
 299 call writeLineAcc8
 300 br 304
 301 acc16= constant 999
 302 call writeLineAcc16
 303 ;test15.j(56)     if (0x1234 ^ 0x10 + 0x0C == 0x1228) println (24); else println (999);
 304 acc16= constant 4660
 305 acc8= constant 16
 306 acc8+ constant 12
 307 acc16Xor acc8
 308 acc16Comp constant 4648
 309 brne 313
 310 acc8= constant 24
 311 call writeLineAcc8
 312 br 320
 313 acc16= constant 999
 314 call writeLineAcc16
 315 ;test15.j(57)   
 316 ;test15.j(58)     //constant/var
 317 ;test15.j(59)     //*****************
 318 ;test15.j(60)     //constant byte/var byte
 319 ;test15.j(61)     if (0x07 & b1 == 0x04) println (25); else println (999);
 320 acc8= constant 7
 321 acc8And variable 0
 322 acc8Comp constant 4
 323 brne 327
 324 acc8= constant 25
 325 call writeLineAcc8
 326 br 330
 327 acc16= constant 999
 328 call writeLineAcc16
 329 ;test15.j(62)     if (0x07 | b1 == 0x1F) println (26); else println (999);
 330 acc8= constant 7
 331 acc8Or variable 0
 332 acc8Comp constant 31
 333 brne 337
 334 acc8= constant 26
 335 call writeLineAcc8
 336 br 340
 337 acc16= constant 999
 338 call writeLineAcc16
 339 ;test15.j(63)     if (0x07 ^ b1 == 0x1B) println (27); else println (999);
 340 acc8= constant 7
 341 acc8Xor variable 0
 342 acc8Comp constant 27
 343 brne 347
 344 acc8= constant 27
 345 call writeLineAcc8
 346 br 351
 347 acc16= constant 999
 348 call writeLineAcc16
 349 ;test15.j(64)     //constant word/var word
 350 ;test15.j(65)     if (0x1234 & w1 == 0x0224) println (28); else println (999);
 351 acc16= constant 4660
 352 acc16And variable 2
 353 acc16Comp constant 548
 354 brne 358
 355 acc8= constant 28
 356 call writeLineAcc8
 357 br 361
 358 acc16= constant 999
 359 call writeLineAcc16
 360 ;test15.j(66)     if (0x1234 | w1 == 0x133C) println (29); else println (999);
 361 acc16= constant 4660
 362 acc16Or variable 2
 363 acc16Comp constant 4924
 364 brne 368
 365 acc8= constant 29
 366 call writeLineAcc8
 367 br 371
 368 acc16= constant 999
 369 call writeLineAcc16
 370 ;test15.j(67)     if (0x1234 ^ w1 == 0x1118) println (30); else println (999);
 371 acc16= constant 4660
 372 acc16Xor variable 2
 373 acc16Comp constant 4376
 374 brne 378
 375 acc8= constant 30
 376 call writeLineAcc8
 377 br 382
 378 acc16= constant 999
 379 call writeLineAcc16
 380 ;test15.j(68)     //constant byte/var word
 381 ;test15.j(69)     if (0x1C & w2 == 0x0014) println (31); else println (999);
 382 acc8= constant 28
 383 acc8ToAcc16
 384 acc16And variable 4
 385 acc8= constant 20
 386 acc16CompareAcc8
 387 brne 391
 388 acc8= constant 31
 389 call writeLineAcc8
 390 br 394
 391 acc16= constant 999
 392 call writeLineAcc16
 393 ;test15.j(70)     if (0x1C | w2 == 0x123C) println (32); else println (999);
 394 acc8= constant 28
 395 acc8ToAcc16
 396 acc16Or variable 4
 397 acc16Comp constant 4668
 398 brne 402
 399 acc8= constant 32
 400 call writeLineAcc8
 401 br 405
 402 acc16= constant 999
 403 call writeLineAcc16
 404 ;test15.j(71)     if (0x1C ^ w2 == 0x1228) println (33); else println (999);
 405 acc8= constant 28
 406 acc8ToAcc16
 407 acc16Xor variable 4
 408 acc16Comp constant 4648
 409 brne 413
 410 acc8= constant 33
 411 call writeLineAcc8
 412 br 417
 413 acc16= constant 999
 414 call writeLineAcc16
 415 ;test15.j(72)     //constant word/var byte
 416 ;test15.j(73)     if (0x1234 & b1 == 0x0014) println (34); else println (999);
 417 acc16= constant 4660
 418 acc16And variable 0
 419 acc8= constant 20
 420 acc16CompareAcc8
 421 brne 425
 422 acc8= constant 34
 423 call writeLineAcc8
 424 br 428
 425 acc16= constant 999
 426 call writeLineAcc16
 427 ;test15.j(74)     if (0x1234 | b1 == 0x123C) println (35); else println (999);
 428 acc16= constant 4660
 429 acc16Or variable 0
 430 acc16Comp constant 4668
 431 brne 435
 432 acc8= constant 35
 433 call writeLineAcc8
 434 br 438
 435 acc16= constant 999
 436 call writeLineAcc16
 437 ;test15.j(75)     if (0x1234 ^ b1 == 0x1228) println (36); else println (999);
 438 acc16= constant 4660
 439 acc16Xor variable 0
 440 acc16Comp constant 4648
 441 brne 445
 442 acc8= constant 36
 443 call writeLineAcc8
 444 br 452
 445 acc16= constant 999
 446 call writeLineAcc16
 447 ;test15.j(76)   
 448 ;test15.j(77)     //constant/final var
 449 ;test15.j(78)     //*****************
 450 ;test15.j(79)     //constant byte/final var byte
 451 ;test15.j(80)     if (0x07 & fb1 == 0x04) println (37); else println (999);
 452 acc8= constant 7
 453 acc8And constant 28
 454 acc8Comp constant 4
 455 brne 459
 456 acc8= constant 37
 457 call writeLineAcc8
 458 br 462
 459 acc16= constant 999
 460 call writeLineAcc16
 461 ;test15.j(81)     if (0x07 | fb1 == 0x1F) println (38); else println (999);
 462 acc8= constant 7
 463 acc8Or constant 28
 464 acc8Comp constant 31
 465 brne 469
 466 acc8= constant 38
 467 call writeLineAcc8
 468 br 472
 469 acc16= constant 999
 470 call writeLineAcc16
 471 ;test15.j(82)     if (0x07 ^ fb1 == 0x1B) println (39); else println (999);
 472 acc8= constant 7
 473 acc8Xor constant 28
 474 acc8Comp constant 27
 475 brne 479
 476 acc8= constant 39
 477 call writeLineAcc8
 478 br 483
 479 acc16= constant 999
 480 call writeLineAcc16
 481 ;test15.j(83)     //constant word/final var word
 482 ;test15.j(84)     if (0x1234 & fw1 == 0x0224) println (40); else println (999);
 483 acc16= constant 4660
 484 acc16And constant 812
 485 acc16Comp constant 548
 486 brne 490
 487 acc8= constant 40
 488 call writeLineAcc8
 489 br 493
 490 acc16= constant 999
 491 call writeLineAcc16
 492 ;test15.j(85)     if (0x1234 | fw1 == 0x133C) println (41); else println (999);
 493 acc16= constant 4660
 494 acc16Or constant 812
 495 acc16Comp constant 4924
 496 brne 500
 497 acc8= constant 41
 498 call writeLineAcc8
 499 br 503
 500 acc16= constant 999
 501 call writeLineAcc16
 502 ;test15.j(86)     if (0x1234 ^ fw1 == 0x1118) println (42); else println (999);
 503 acc16= constant 4660
 504 acc16Xor constant 812
 505 acc16Comp constant 4376
 506 brne 510
 507 acc8= constant 42
 508 call writeLineAcc8
 509 br 514
 510 acc16= constant 999
 511 call writeLineAcc16
 512 ;test15.j(87)     //constant byte/final var word
 513 ;test15.j(88)     if (0x1C & fw2 == 0x0014) println (43); else println (999);
 514 acc8= constant 28
 515 acc8ToAcc16
 516 acc16And constant 4660
 517 acc8= constant 20
 518 acc16CompareAcc8
 519 brne 523
 520 acc8= constant 43
 521 call writeLineAcc8
 522 br 526
 523 acc16= constant 999
 524 call writeLineAcc16
 525 ;test15.j(89)     if (0x1C | fw2 == 0x123C) println (44); else println (999);
 526 acc8= constant 28
 527 acc8ToAcc16
 528 acc16Or constant 4660
 529 acc16Comp constant 4668
 530 brne 534
 531 acc8= constant 44
 532 call writeLineAcc8
 533 br 537
 534 acc16= constant 999
 535 call writeLineAcc16
 536 ;test15.j(90)     if (0x1C ^ fw2 == 0x1228) println (45); else println (999);
 537 acc8= constant 28
 538 acc8ToAcc16
 539 acc16Xor constant 4660
 540 acc16Comp constant 4648
 541 brne 545
 542 acc8= constant 45
 543 call writeLineAcc8
 544 br 549
 545 acc16= constant 999
 546 call writeLineAcc16
 547 ;test15.j(91)     //constant word/final var byte
 548 ;test15.j(92)     if (0x1234 & fb1 == 0x0014) println (46); else println (999);
 549 acc16= constant 4660
 550 acc16And constant 28
 551 acc8= constant 20
 552 acc16CompareAcc8
 553 brne 557
 554 acc8= constant 46
 555 call writeLineAcc8
 556 br 560
 557 acc16= constant 999
 558 call writeLineAcc16
 559 ;test15.j(93)     if (0x1234 | fb1 == 0x123C) println (47); else println (999);
 560 acc16= constant 4660
 561 acc16Or constant 28
 562 acc16Comp constant 4668
 563 brne 567
 564 acc8= constant 47
 565 call writeLineAcc8
 566 br 570
 567 acc16= constant 999
 568 call writeLineAcc16
 569 ;test15.j(94)     if (0x1234 ^ fb1 == 0x1228) println (48); else println (999);
 570 acc16= constant 4660
 571 acc16Xor constant 28
 572 acc16Comp constant 4648
 573 brne 577
 574 acc8= constant 48
 575 call writeLineAcc8
 576 br 584
 577 acc16= constant 999
 578 call writeLineAcc16
 579 ;test15.j(95)   
 580 ;test15.j(96)     //acc/constant
 581 ;test15.j(97)     //************
 582 ;test15.j(98)     //acc byte/constant byte
 583 ;test15.j(99)     if ((0x04 + 0x03) & 0x1C == 0x04) println (49); else println (999);
 584 acc8= constant 4
 585 acc8+ constant 3
 586 acc8And constant 28
 587 acc8Comp constant 4
 588 brne 592
 589 acc8= constant 49
 590 call writeLineAcc8
 591 br 595
 592 acc16= constant 999
 593 call writeLineAcc16
 594 ;test15.j(100)     if ((0x04 + 0x03) | 0x1C == 0x1F) println (50); else println (999);
 595 acc8= constant 4
 596 acc8+ constant 3
 597 acc8Or constant 28
 598 acc8Comp constant 31
 599 brne 603
 600 acc8= constant 50
 601 call writeLineAcc8
 602 br 606
 603 acc16= constant 999
 604 call writeLineAcc16
 605 ;test15.j(101)     if ((0x04 + 0x03) ^ 0x1C == 0x1B) println (51); else println (999);
 606 acc8= constant 4
 607 acc8+ constant 3
 608 acc8Xor constant 28
 609 acc8Comp constant 27
 610 brne 614
 611 acc8= constant 51
 612 call writeLineAcc8
 613 br 618
 614 acc16= constant 999
 615 call writeLineAcc16
 616 ;test15.j(102)     //acc word/constant word
 617 ;test15.j(103)     if (0x1000 + 0x0234 & 0x032C == 0x0224) println (52); else println (999);
 618 acc16= constant 4096
 619 acc16+ constant 564
 620 acc16And constant 812
 621 acc16Comp constant 548
 622 brne 626
 623 acc8= constant 52
 624 call writeLineAcc8
 625 br 629
 626 acc16= constant 999
 627 call writeLineAcc16
 628 ;test15.j(104)     if (0x1000 + 0x0234 | 0x032C == 0x133C) println (53); else println (999);
 629 acc16= constant 4096
 630 acc16+ constant 564
 631 acc16Or constant 812
 632 acc16Comp constant 4924
 633 brne 637
 634 acc8= constant 53
 635 call writeLineAcc8
 636 br 640
 637 acc16= constant 999
 638 call writeLineAcc16
 639 ;test15.j(105)     if (0x1000 + 0x0234 ^ 0x032C == 0x1118) println (54); else println (999);
 640 acc16= constant 4096
 641 acc16+ constant 564
 642 acc16Xor constant 812
 643 acc16Comp constant 4376
 644 brne 648
 645 acc8= constant 54
 646 call writeLineAcc8
 647 br 652
 648 acc16= constant 999
 649 call writeLineAcc16
 650 ;test15.j(106)     //acc byte/constant word
 651 ;test15.j(107)     if (0x10 + 0x0C & 0x1234 == 0x0014) println (55); else println (999);
 652 acc8= constant 16
 653 acc8+ constant 12
 654 acc8ToAcc16
 655 acc16And constant 4660
 656 acc8= constant 20
 657 acc16CompareAcc8
 658 brne 662
 659 acc8= constant 55
 660 call writeLineAcc8
 661 br 665
 662 acc16= constant 999
 663 call writeLineAcc16
 664 ;test15.j(108)     if (0x10 + 0x0C | 0x1234 == 0x123C) println (56); else println (999);
 665 acc8= constant 16
 666 acc8+ constant 12
 667 acc8ToAcc16
 668 acc16Or constant 4660
 669 acc16Comp constant 4668
 670 brne 674
 671 acc8= constant 56
 672 call writeLineAcc8
 673 br 677
 674 acc16= constant 999
 675 call writeLineAcc16
 676 ;test15.j(109)     if (0x10 + 0x0C ^ 0x1234 == 0x1228) println (57); else println (999);
 677 acc8= constant 16
 678 acc8+ constant 12
 679 acc8ToAcc16
 680 acc16Xor constant 4660
 681 acc16Comp constant 4648
 682 brne 686
 683 acc8= constant 57
 684 call writeLineAcc8
 685 br 690
 686 acc16= constant 999
 687 call writeLineAcc16
 688 ;test15.j(110)     //acc word/constant byte
 689 ;test15.j(111)     if (0x1000 + 0x0234 & 0x1C == 0x0014) println (58); else println (999);
 690 acc16= constant 4096
 691 acc16+ constant 564
 692 acc16And constant 28
 693 acc8= constant 20
 694 acc16CompareAcc8
 695 brne 699
 696 acc8= constant 58
 697 call writeLineAcc8
 698 br 702
 699 acc16= constant 999
 700 call writeLineAcc16
 701 ;test15.j(112)     if (0x1000 + 0x0234 | 0x1C == 0x123C) println (59); else println (999);
 702 acc16= constant 4096
 703 acc16+ constant 564
 704 acc16Or constant 28
 705 acc16Comp constant 4668
 706 brne 710
 707 acc8= constant 59
 708 call writeLineAcc8
 709 br 713
 710 acc16= constant 999
 711 call writeLineAcc16
 712 ;test15.j(113)     if (0x1000 + 0x0234 ^ 0x1C == 0x1228) println (60); else println (999);
 713 acc16= constant 4096
 714 acc16+ constant 564
 715 acc16Xor constant 28
 716 acc16Comp constant 4648
 717 brne 721
 718 acc8= constant 60
 719 call writeLineAcc8
 720 br 728
 721 acc16= constant 999
 722 call writeLineAcc16
 723 ;test15.j(114)   
 724 ;test15.j(115)     //acc/acc
 725 ;test15.j(116)     //*******
 726 ;test15.j(117)     //acc byte/acc byte
 727 ;test15.j(118)     if (0x04 + 0x03 & 0x10 + 0x0C == 0x04) println (61); else println (999);
 728 acc8= constant 4
 729 acc8+ constant 3
 730 <acc8= constant 16
 731 acc8+ constant 12
 732 acc8And unstack8
 733 acc8Comp constant 4
 734 brne 738
 735 acc8= constant 61
 736 call writeLineAcc8
 737 br 741
 738 acc16= constant 999
 739 call writeLineAcc16
 740 ;test15.j(119)     if (0x04 + 0x03 | 0x10 + 0x0C == 0x1F) println (62); else println (999);
 741 acc8= constant 4
 742 acc8+ constant 3
 743 <acc8= constant 16
 744 acc8+ constant 12
 745 acc8Or unstack8
 746 acc8Comp constant 31
 747 brne 751
 748 acc8= constant 62
 749 call writeLineAcc8
 750 br 754
 751 acc16= constant 999
 752 call writeLineAcc16
 753 ;test15.j(120)     if (0x04 + 0x03 ^ 0x10 + 0x0C == 0x1B) println (63); else println (999);
 754 acc8= constant 4
 755 acc8+ constant 3
 756 <acc8= constant 16
 757 acc8+ constant 12
 758 acc8Xor unstack8
 759 acc8Comp constant 27
 760 brne 764
 761 acc8= constant 63
 762 call writeLineAcc8
 763 br 768
 764 acc16= constant 999
 765 call writeLineAcc16
 766 ;test15.j(121)     //acc word/acc word
 767 ;test15.j(122)     if (0x1000 + 0x0234 & 0x0100 + 0x022C == 0x0224) println (64); else println (999);
 768 acc16= constant 4096
 769 acc16+ constant 564
 770 <acc16= constant 256
 771 acc16+ constant 556
 772 acc16And unstack16
 773 acc16Comp constant 548
 774 brne 778
 775 acc8= constant 64
 776 call writeLineAcc8
 777 br 781
 778 acc16= constant 999
 779 call writeLineAcc16
 780 ;test15.j(123)     if (0x1000 + 0x0234 | 0x0100 + 0x022C == 0x133C) println (65); else println (999);
 781 acc16= constant 4096
 782 acc16+ constant 564
 783 <acc16= constant 256
 784 acc16+ constant 556
 785 acc16Or unstack16
 786 acc16Comp constant 4924
 787 brne 791
 788 acc8= constant 65
 789 call writeLineAcc8
 790 br 794
 791 acc16= constant 999
 792 call writeLineAcc16
 793 ;test15.j(124)     if (0x1000 + 0x0234 ^ 0x0100 + 0x022C == 0x1118) println (66); else println (999);
 794 acc16= constant 4096
 795 acc16+ constant 564
 796 <acc16= constant 256
 797 acc16+ constant 556
 798 acc16Xor unstack16
 799 acc16Comp constant 4376
 800 brne 804
 801 acc8= constant 66
 802 call writeLineAcc8
 803 br 808
 804 acc16= constant 999
 805 call writeLineAcc16
 806 ;test15.j(125)     //acc byte/acc word
 807 ;test15.j(126)     if (0x10 + 0x0C & 0x1000 + 0x0234 == 0x0014) println (67); else println (999);
 808 acc8= constant 16
 809 acc8+ constant 12
 810 acc16= constant 4096
 811 acc16+ constant 564
 812 acc16And acc8
 813 acc8= constant 20
 814 acc16CompareAcc8
 815 brne 819
 816 acc8= constant 67
 817 call writeLineAcc8
 818 br 822
 819 acc16= constant 999
 820 call writeLineAcc16
 821 ;test15.j(127)     if (0x10 + 0x0C | 0x1000 + 0x0234 == 0x123C) println (68); else println (999);
 822 acc8= constant 16
 823 acc8+ constant 12
 824 acc16= constant 4096
 825 acc16+ constant 564
 826 acc16Or acc8
 827 acc16Comp constant 4668
 828 brne 832
 829 acc8= constant 68
 830 call writeLineAcc8
 831 br 835
 832 acc16= constant 999
 833 call writeLineAcc16
 834 ;test15.j(128)     if (0x10 + 0x0C ^ 0x1000 + 0x0234 == 0x1228) println (69); else println (999);
 835 acc8= constant 16
 836 acc8+ constant 12
 837 acc16= constant 4096
 838 acc16+ constant 564
 839 acc16Xor acc8
 840 acc16Comp constant 4648
 841 brne 845
 842 acc8= constant 69
 843 call writeLineAcc8
 844 br 849
 845 acc16= constant 999
 846 call writeLineAcc16
 847 ;test15.j(129)     //acc word/acc byte
 848 ;test15.j(130)     if (0x1000 + 0x0234 & 0x10 + 0x0C == 0x0014) println (70); else println (999);
 849 acc16= constant 4096
 850 acc16+ constant 564
 851 acc8= constant 16
 852 acc8+ constant 12
 853 acc16And acc8
 854 acc8= constant 20
 855 acc16CompareAcc8
 856 brne 860
 857 acc8= constant 70
 858 call writeLineAcc8
 859 br 863
 860 acc16= constant 999
 861 call writeLineAcc16
 862 ;test15.j(131)     if (0x1000 + 0x0234 | 0x10 + 0x0C == 0x123C) println (71); else println (999);
 863 acc16= constant 4096
 864 acc16+ constant 564
 865 acc8= constant 16
 866 acc8+ constant 12
 867 acc16Or acc8
 868 acc16Comp constant 4668
 869 brne 873
 870 acc8= constant 71
 871 call writeLineAcc8
 872 br 876
 873 acc16= constant 999
 874 call writeLineAcc16
 875 ;test15.j(132)     if (0x1000 + 0x0234 ^ 0x10 + 0x0C == 0x1228) println (72); else println (999);
 876 acc16= constant 4096
 877 acc16+ constant 564
 878 acc8= constant 16
 879 acc8+ constant 12
 880 acc16Xor acc8
 881 acc16Comp constant 4648
 882 brne 886
 883 acc8= constant 72
 884 call writeLineAcc8
 885 br 893
 886 acc16= constant 999
 887 call writeLineAcc16
 888 ;test15.j(133)   
 889 ;test15.j(134)     //acc/var
 890 ;test15.j(135)     //*******
 891 ;test15.j(136)     //acc byte/var byte
 892 ;test15.j(137)     if (0x04 + 0x03 & b1 == 0x04) println (73); else println (999);
 893 acc8= constant 4
 894 acc8+ constant 3
 895 acc8And variable 0
 896 acc8Comp constant 4
 897 brne 901
 898 acc8= constant 73
 899 call writeLineAcc8
 900 br 904
 901 acc16= constant 999
 902 call writeLineAcc16
 903 ;test15.j(138)     if (0x04 + 0x03 | b1 == 0x1F) println (74); else println (999);
 904 acc8= constant 4
 905 acc8+ constant 3
 906 acc8Or variable 0
 907 acc8Comp constant 31
 908 brne 912
 909 acc8= constant 74
 910 call writeLineAcc8
 911 br 915
 912 acc16= constant 999
 913 call writeLineAcc16
 914 ;test15.j(139)     if (0x04 + 0x03 ^ b1 == 0x1B) println (75); else println (999);
 915 acc8= constant 4
 916 acc8+ constant 3
 917 acc8Xor variable 0
 918 acc8Comp constant 27
 919 brne 923
 920 acc8= constant 75
 921 call writeLineAcc8
 922 br 927
 923 acc16= constant 999
 924 call writeLineAcc16
 925 ;test15.j(140)     //acc word/var word
 926 ;test15.j(141)     if (0x1000 + 0x0234 & w1 == 0x0224) println (76); else println (999);
 927 acc16= constant 4096
 928 acc16+ constant 564
 929 acc16And variable 2
 930 acc16Comp constant 548
 931 brne 935
 932 acc8= constant 76
 933 call writeLineAcc8
 934 br 938
 935 acc16= constant 999
 936 call writeLineAcc16
 937 ;test15.j(142)     if (0x1000 + 0x0234 | w1 == 0x133C) println (77); else println (999);
 938 acc16= constant 4096
 939 acc16+ constant 564
 940 acc16Or variable 2
 941 acc16Comp constant 4924
 942 brne 946
 943 acc8= constant 77
 944 call writeLineAcc8
 945 br 949
 946 acc16= constant 999
 947 call writeLineAcc16
 948 ;test15.j(143)     if (0x1000 + 0x0234 ^ w1 == 0x1118) println (78); else println (999);
 949 acc16= constant 4096
 950 acc16+ constant 564
 951 acc16Xor variable 2
 952 acc16Comp constant 4376
 953 brne 957
 954 acc8= constant 78
 955 call writeLineAcc8
 956 br 961
 957 acc16= constant 999
 958 call writeLineAcc16
 959 ;test15.j(144)     //acc byte/var word
 960 ;test15.j(145)     if (0x10 + 0x0C & w2 == 0x0014) println (79); else println (999);
 961 acc8= constant 16
 962 acc8+ constant 12
 963 acc8ToAcc16
 964 acc16And variable 4
 965 acc8= constant 20
 966 acc16CompareAcc8
 967 brne 971
 968 acc8= constant 79
 969 call writeLineAcc8
 970 br 974
 971 acc16= constant 999
 972 call writeLineAcc16
 973 ;test15.j(146)     if (0x10 + 0x0C | w2 == 0x123C) println (80); else println (999);
 974 acc8= constant 16
 975 acc8+ constant 12
 976 acc8ToAcc16
 977 acc16Or variable 4
 978 acc16Comp constant 4668
 979 brne 983
 980 acc8= constant 80
 981 call writeLineAcc8
 982 br 986
 983 acc16= constant 999
 984 call writeLineAcc16
 985 ;test15.j(147)     if (0x10 + 0x0C ^ w2 == 0x1228) println (81); else println (999);
 986 acc8= constant 16
 987 acc8+ constant 12
 988 acc8ToAcc16
 989 acc16Xor variable 4
 990 acc16Comp constant 4648
 991 brne 995
 992 acc8= constant 81
 993 call writeLineAcc8
 994 br 999
 995 acc16= constant 999
 996 call writeLineAcc16
 997 ;test15.j(148)     //acc word/var byte
 998 ;test15.j(149)     if (0x1000 + 0x0234 & b1 == 0x0014) println (82); else println (999);
 999 acc16= constant 4096
1000 acc16+ constant 564
1001 acc16And variable 0
1002 acc8= constant 20
1003 acc16CompareAcc8
1004 brne 1008
1005 acc8= constant 82
1006 call writeLineAcc8
1007 br 1011
1008 acc16= constant 999
1009 call writeLineAcc16
1010 ;test15.j(150)     if (0x1000 + 0x0234 | b1 == 0x123C) println (83); else println (999);
1011 acc16= constant 4096
1012 acc16+ constant 564
1013 acc16Or variable 0
1014 acc16Comp constant 4668
1015 brne 1019
1016 acc8= constant 83
1017 call writeLineAcc8
1018 br 1022
1019 acc16= constant 999
1020 call writeLineAcc16
1021 ;test15.j(151)     if (0x1000 + 0x0234 ^ b1 == 0x1228) println (84); else println (999);
1022 acc16= constant 4096
1023 acc16+ constant 564
1024 acc16Xor variable 0
1025 acc16Comp constant 4648
1026 brne 1030
1027 acc8= constant 84
1028 call writeLineAcc8
1029 br 1037
1030 acc16= constant 999
1031 call writeLineAcc16
1032 ;test15.j(152)   
1033 ;test15.j(153)     //acc/final var
1034 ;test15.j(154)     //*************
1035 ;test15.j(155)     //acc byte/final var byte
1036 ;test15.j(156)     if (0x04 + 0x03 & fb1 == 0x04) println (85); else println (999);
1037 acc8= constant 4
1038 acc8+ constant 3
1039 acc8And constant 28
1040 acc8Comp constant 4
1041 brne 1045
1042 acc8= constant 85
1043 call writeLineAcc8
1044 br 1048
1045 acc16= constant 999
1046 call writeLineAcc16
1047 ;test15.j(157)     if (0x04 + 0x03 | fb1 == 0x1F) println (86); else println (999);
1048 acc8= constant 4
1049 acc8+ constant 3
1050 acc8Or constant 28
1051 acc8Comp constant 31
1052 brne 1056
1053 acc8= constant 86
1054 call writeLineAcc8
1055 br 1059
1056 acc16= constant 999
1057 call writeLineAcc16
1058 ;test15.j(158)     if (0x04 + 0x03 ^ fb1 == 0x1B) println (87); else println (999);
1059 acc8= constant 4
1060 acc8+ constant 3
1061 acc8Xor constant 28
1062 acc8Comp constant 27
1063 brne 1067
1064 acc8= constant 87
1065 call writeLineAcc8
1066 br 1071
1067 acc16= constant 999
1068 call writeLineAcc16
1069 ;test15.j(159)     //acc word/final var word
1070 ;test15.j(160)     if (0x1000 + 0x0234 & fw1 == 0x0224) println (88); else println (999);
1071 acc16= constant 4096
1072 acc16+ constant 564
1073 acc16And constant 812
1074 acc16Comp constant 548
1075 brne 1079
1076 acc8= constant 88
1077 call writeLineAcc8
1078 br 1082
1079 acc16= constant 999
1080 call writeLineAcc16
1081 ;test15.j(161)     if (0x1000 + 0x0234 | fw1 == 0x133C) println (89); else println (999);
1082 acc16= constant 4096
1083 acc16+ constant 564
1084 acc16Or constant 812
1085 acc16Comp constant 4924
1086 brne 1090
1087 acc8= constant 89
1088 call writeLineAcc8
1089 br 1093
1090 acc16= constant 999
1091 call writeLineAcc16
1092 ;test15.j(162)     if (0x1000 + 0x0234 ^ fw1 == 0x1118) println (90); else println (999);
1093 acc16= constant 4096
1094 acc16+ constant 564
1095 acc16Xor constant 812
1096 acc16Comp constant 4376
1097 brne 1101
1098 acc8= constant 90
1099 call writeLineAcc8
1100 br 1105
1101 acc16= constant 999
1102 call writeLineAcc16
1103 ;test15.j(163)     //acc byte/final var word
1104 ;test15.j(164)     if (0x10 + 0x0C & fw2 == 0x0014) println (91); else println (999);
1105 acc8= constant 16
1106 acc8+ constant 12
1107 acc8ToAcc16
1108 acc16And constant 4660
1109 acc8= constant 20
1110 acc16CompareAcc8
1111 brne 1115
1112 acc8= constant 91
1113 call writeLineAcc8
1114 br 1118
1115 acc16= constant 999
1116 call writeLineAcc16
1117 ;test15.j(165)     if (0x10 + 0x0C | fw2 == 0x123C) println (92); else println (999);
1118 acc8= constant 16
1119 acc8+ constant 12
1120 acc8ToAcc16
1121 acc16Or constant 4660
1122 acc16Comp constant 4668
1123 brne 1127
1124 acc8= constant 92
1125 call writeLineAcc8
1126 br 1130
1127 acc16= constant 999
1128 call writeLineAcc16
1129 ;test15.j(166)     if (0x10 + 0x0C ^ fw2 == 0x1228) println (93); else println (999);
1130 acc8= constant 16
1131 acc8+ constant 12
1132 acc8ToAcc16
1133 acc16Xor constant 4660
1134 acc16Comp constant 4648
1135 brne 1139
1136 acc8= constant 93
1137 call writeLineAcc8
1138 br 1143
1139 acc16= constant 999
1140 call writeLineAcc16
1141 ;test15.j(167)     //acc word/final var byte
1142 ;test15.j(168)     if (0x1000 + 0x0234 & fb1 == 0x0014) println (94); else println (999);
1143 acc16= constant 4096
1144 acc16+ constant 564
1145 acc16And constant 28
1146 acc8= constant 20
1147 acc16CompareAcc8
1148 brne 1152
1149 acc8= constant 94
1150 call writeLineAcc8
1151 br 1155
1152 acc16= constant 999
1153 call writeLineAcc16
1154 ;test15.j(169)     if (0x1000 + 0x0234 | fb1 == 0x123C) println (95); else println (999);
1155 acc16= constant 4096
1156 acc16+ constant 564
1157 acc16Or constant 28
1158 acc16Comp constant 4668
1159 brne 1163
1160 acc8= constant 95
1161 call writeLineAcc8
1162 br 1166
1163 acc16= constant 999
1164 call writeLineAcc16
1165 ;test15.j(170)     if (0x1000 + 0x0234 ^ fb1 == 0x1228) println (96); else println (999);
1166 acc16= constant 4096
1167 acc16+ constant 564
1168 acc16Xor constant 28
1169 acc16Comp constant 4648
1170 brne 1174
1171 acc8= constant 96
1172 call writeLineAcc8
1173 br 1181
1174 acc16= constant 999
1175 call writeLineAcc16
1176 ;test15.j(171)   
1177 ;test15.j(172)     //var/constant
1178 ;test15.j(173)     //************
1179 ;test15.j(174)     //var byte/constant byte
1180 ;test15.j(175)     if (b2 & 0x1C == 0x04) println (97); else println (999);
1181 acc8= variable 1
1182 acc8And constant 28
1183 acc8Comp constant 4
1184 brne 1188
1185 acc8= constant 97
1186 call writeLineAcc8
1187 br 1191
1188 acc16= constant 999
1189 call writeLineAcc16
1190 ;test15.j(176)     if (b2 | 0x1C == 0x1F) println (98); else println (999);
1191 acc8= variable 1
1192 acc8Or constant 28
1193 acc8Comp constant 31
1194 brne 1198
1195 acc8= constant 98
1196 call writeLineAcc8
1197 br 1201
1198 acc16= constant 999
1199 call writeLineAcc16
1200 ;test15.j(177)     if (b2 ^ 0x1C == 0x1B) println (99); else println (999);
1201 acc8= variable 1
1202 acc8Xor constant 28
1203 acc8Comp constant 27
1204 brne 1208
1205 acc8= constant 99
1206 call writeLineAcc8
1207 br 1212
1208 acc16= constant 999
1209 call writeLineAcc16
1210 ;test15.j(178)     //var word/constant word
1211 ;test15.j(179)     if (w2 & 0x032C == 0x0224) println (100); else println (999);
1212 acc16= variable 4
1213 acc16And constant 812
1214 acc16Comp constant 548
1215 brne 1219
1216 acc8= constant 100
1217 call writeLineAcc8
1218 br 1222
1219 acc16= constant 999
1220 call writeLineAcc16
1221 ;test15.j(180)     if (w2 | 0x032C == 0x133C) println (101); else println (999);
1222 acc16= variable 4
1223 acc16Or constant 812
1224 acc16Comp constant 4924
1225 brne 1229
1226 acc8= constant 101
1227 call writeLineAcc8
1228 br 1232
1229 acc16= constant 999
1230 call writeLineAcc16
1231 ;test15.j(181)     if (w2 ^ 0x032C == 0x1118) println (102); else println (999);
1232 acc16= variable 4
1233 acc16Xor constant 812
1234 acc16Comp constant 4376
1235 brne 1239
1236 acc8= constant 102
1237 call writeLineAcc8
1238 br 1243
1239 acc16= constant 999
1240 call writeLineAcc16
1241 ;test15.j(182)     //var byte/constant word
1242 ;test15.j(183)     if (b1 & 0x1234 == 0x0014) println (103); else println (999);
1243 acc8= variable 0
1244 acc8ToAcc16
1245 acc16And constant 4660
1246 acc8= constant 20
1247 acc16CompareAcc8
1248 brne 1252
1249 acc8= constant 103
1250 call writeLineAcc8
1251 br 1255
1252 acc16= constant 999
1253 call writeLineAcc16
1254 ;test15.j(184)     if (b1 | 0x1234 == 0x123C) println (104); else println (999);
1255 acc8= variable 0
1256 acc8ToAcc16
1257 acc16Or constant 4660
1258 acc16Comp constant 4668
1259 brne 1263
1260 acc8= constant 104
1261 call writeLineAcc8
1262 br 1266
1263 acc16= constant 999
1264 call writeLineAcc16
1265 ;test15.j(185)     if (b1 ^ 0x1234 == 0x1228) println (105); else println (999);
1266 acc8= variable 0
1267 acc8ToAcc16
1268 acc16Xor constant 4660
1269 acc16Comp constant 4648
1270 brne 1274
1271 acc8= constant 105
1272 call writeLineAcc8
1273 br 1278
1274 acc16= constant 999
1275 call writeLineAcc16
1276 ;test15.j(186)     //var word/constant byte
1277 ;test15.j(187)     if (w2 & 0x1C == 0x0014) println (106); else println (999);
1278 acc16= variable 4
1279 acc16And constant 28
1280 acc8= constant 20
1281 acc16CompareAcc8
1282 brne 1286
1283 acc8= constant 106
1284 call writeLineAcc8
1285 br 1289
1286 acc16= constant 999
1287 call writeLineAcc16
1288 ;test15.j(188)     if (w2 | 0x1C == 0x123C) println (107); else println (999);
1289 acc16= variable 4
1290 acc16Or constant 28
1291 acc16Comp constant 4668
1292 brne 1296
1293 acc8= constant 107
1294 call writeLineAcc8
1295 br 1299
1296 acc16= constant 999
1297 call writeLineAcc16
1298 ;test15.j(189)     if (w2 ^ 0x1C == 0x1228) println (108); else println (999);
1299 acc16= variable 4
1300 acc16Xor constant 28
1301 acc16Comp constant 4648
1302 brne 1306
1303 acc8= constant 108
1304 call writeLineAcc8
1305 br 1313
1306 acc16= constant 999
1307 call writeLineAcc16
1308 ;test15.j(190)   
1309 ;test15.j(191)     //var/acc
1310 ;test15.j(192)     //*******
1311 ;test15.j(193)     //var byte/acc byte
1312 ;test15.j(194)     if (b2 & (0x10 + 0x0C) == 0x04) println (109); else println (999);
1313 acc8= variable 1
1314 <acc8= constant 16
1315 acc8+ constant 12
1316 acc8And unstack8
1317 acc8Comp constant 4
1318 brne 1322
1319 acc8= constant 109
1320 call writeLineAcc8
1321 br 1325
1322 acc16= constant 999
1323 call writeLineAcc16
1324 ;test15.j(195)     if (b2 | (0x10 + 0x0C) == 0x1F) println (110); else println (999);
1325 acc8= variable 1
1326 <acc8= constant 16
1327 acc8+ constant 12
1328 acc8Or unstack8
1329 acc8Comp constant 31
1330 brne 1334
1331 acc8= constant 110
1332 call writeLineAcc8
1333 br 1337
1334 acc16= constant 999
1335 call writeLineAcc16
1336 ;test15.j(196)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (111); else println (999);
1337 acc8= variable 1
1338 <acc8= constant 16
1339 acc8+ constant 12
1340 acc8Xor unstack8
1341 acc8Comp constant 27
1342 brne 1346
1343 acc8= constant 111
1344 call writeLineAcc8
1345 br 1350
1346 acc16= constant 999
1347 call writeLineAcc16
1348 ;test15.j(197)     //var word/acc word
1349 ;test15.j(198)     if (w2 & 0x0100 + 0x022C == 0x0224) println (112); else println (999);
1350 acc16= variable 4
1351 <acc16= constant 256
1352 acc16+ constant 556
1353 acc16And unstack16
1354 acc16Comp constant 548
1355 brne 1359
1356 acc8= constant 112
1357 call writeLineAcc8
1358 br 1362
1359 acc16= constant 999
1360 call writeLineAcc16
1361 ;test15.j(199)     if (w2 | 0x0100 + 0x022C == 0x133C) println (113); else println (999);
1362 acc16= variable 4
1363 <acc16= constant 256
1364 acc16+ constant 556
1365 acc16Or unstack16
1366 acc16Comp constant 4924
1367 brne 1371
1368 acc8= constant 113
1369 call writeLineAcc8
1370 br 1374
1371 acc16= constant 999
1372 call writeLineAcc16
1373 ;test15.j(200)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (114); else println (999);
1374 acc16= variable 4
1375 <acc16= constant 256
1376 acc16+ constant 556
1377 acc16Xor unstack16
1378 acc16Comp constant 4376
1379 brne 1383
1380 acc8= constant 114
1381 call writeLineAcc8
1382 br 1387
1383 acc16= constant 999
1384 call writeLineAcc16
1385 ;test15.j(201)     //var byte/acc word
1386 ;test15.j(202)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (115); else println (999);
1387 acc8= variable 0
1388 acc16= constant 4096
1389 acc16+ constant 564
1390 acc16And acc8
1391 acc8= constant 20
1392 acc16CompareAcc8
1393 brne 1397
1394 acc8= constant 115
1395 call writeLineAcc8
1396 br 1400
1397 acc16= constant 999
1398 call writeLineAcc16
1399 ;test15.j(203)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (116); else println (999);
1400 acc8= variable 0
1401 acc16= constant 4096
1402 acc16+ constant 564
1403 acc16Or acc8
1404 acc16Comp constant 4668
1405 brne 1409
1406 acc8= constant 116
1407 call writeLineAcc8
1408 br 1412
1409 acc16= constant 999
1410 call writeLineAcc16
1411 ;test15.j(204)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (117); else println (999);
1412 acc8= variable 0
1413 acc16= constant 4096
1414 acc16+ constant 564
1415 acc16Xor acc8
1416 acc16Comp constant 4648
1417 brne 1421
1418 acc8= constant 117
1419 call writeLineAcc8
1420 br 1425
1421 acc16= constant 999
1422 call writeLineAcc16
1423 ;test15.j(205)     //var word/acc byte
1424 ;test15.j(206)     if (w2 & 0x10 + 0x0C == 0x0014) println (118); else println (999);
1425 acc16= variable 4
1426 acc8= constant 16
1427 acc8+ constant 12
1428 acc16And acc8
1429 acc8= constant 20
1430 acc16CompareAcc8
1431 brne 1435
1432 acc8= constant 118
1433 call writeLineAcc8
1434 br 1438
1435 acc16= constant 999
1436 call writeLineAcc16
1437 ;test15.j(207)     if (w2 | 0x10 + 0x0C == 0x123C) println (119); else println (999);
1438 acc16= variable 4
1439 acc8= constant 16
1440 acc8+ constant 12
1441 acc16Or acc8
1442 acc16Comp constant 4668
1443 brne 1447
1444 acc8= constant 119
1445 call writeLineAcc8
1446 br 1450
1447 acc16= constant 999
1448 call writeLineAcc16
1449 ;test15.j(208)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (120); else println (999);
1450 acc16= variable 4
1451 acc8= constant 16
1452 acc8+ constant 12
1453 acc16Xor acc8
1454 acc16Comp constant 4648
1455 brne 1459
1456 acc8= constant 120
1457 call writeLineAcc8
1458 br 1466
1459 acc16= constant 999
1460 call writeLineAcc16
1461 ;test15.j(209)   
1462 ;test15.j(210)     //var/var
1463 ;test15.j(211)     //*******
1464 ;test15.j(212)     //var byte/var byte
1465 ;test15.j(213)     if (b2 & b1 == 0x04) println (121); else println (999);
1466 acc8= variable 1
1467 acc8And variable 0
1468 acc8Comp constant 4
1469 brne 1473
1470 acc8= constant 121
1471 call writeLineAcc8
1472 br 1476
1473 acc16= constant 999
1474 call writeLineAcc16
1475 ;test15.j(214)     if (b2 | b1 == 0x1F) println (122); else println (999);
1476 acc8= variable 1
1477 acc8Or variable 0
1478 acc8Comp constant 31
1479 brne 1483
1480 acc8= constant 122
1481 call writeLineAcc8
1482 br 1486
1483 acc16= constant 999
1484 call writeLineAcc16
1485 ;test15.j(215)     if (b2 ^ b1 == 0x1B) println (123); else println (999);
1486 acc8= variable 1
1487 acc8Xor variable 0
1488 acc8Comp constant 27
1489 brne 1493
1490 acc8= constant 123
1491 call writeLineAcc8
1492 br 1497
1493 acc16= constant 999
1494 call writeLineAcc16
1495 ;test15.j(216)     //var word/var word
1496 ;test15.j(217)     if (w2 & w1 == 0x0224) println (124); else println (999);
1497 acc16= variable 4
1498 acc16And variable 2
1499 acc16Comp constant 548
1500 brne 1504
1501 acc8= constant 124
1502 call writeLineAcc8
1503 br 1507
1504 acc16= constant 999
1505 call writeLineAcc16
1506 ;test15.j(218)     if (w2 | w1 == 0x133C) println (125); else println (999);
1507 acc16= variable 4
1508 acc16Or variable 2
1509 acc16Comp constant 4924
1510 brne 1514
1511 acc8= constant 125
1512 call writeLineAcc8
1513 br 1517
1514 acc16= constant 999
1515 call writeLineAcc16
1516 ;test15.j(219)     if (w2 ^ w1 == 0x1118) println (126); else println (999);
1517 acc16= variable 4
1518 acc16Xor variable 2
1519 acc16Comp constant 4376
1520 brne 1524
1521 acc8= constant 126
1522 call writeLineAcc8
1523 br 1528
1524 acc16= constant 999
1525 call writeLineAcc16
1526 ;test15.j(220)     //var byte/var word
1527 ;test15.j(221)     if (b1 & w2 == 0x0014) println (127); else println (999);
1528 acc8= variable 0
1529 acc8ToAcc16
1530 acc16And variable 4
1531 acc8= constant 20
1532 acc16CompareAcc8
1533 brne 1537
1534 acc8= constant 127
1535 call writeLineAcc8
1536 br 1540
1537 acc16= constant 999
1538 call writeLineAcc16
1539 ;test15.j(222)     if (b1 | w2 == 0x123C) println (128); else println (999);
1540 acc8= variable 0
1541 acc8ToAcc16
1542 acc16Or variable 4
1543 acc16Comp constant 4668
1544 brne 1548
1545 acc8= constant 128
1546 call writeLineAcc8
1547 br 1551
1548 acc16= constant 999
1549 call writeLineAcc16
1550 ;test15.j(223)     if (b1 ^ w2 == 0x1228) println (129); else println (999);
1551 acc8= variable 0
1552 acc8ToAcc16
1553 acc16Xor variable 4
1554 acc16Comp constant 4648
1555 brne 1559
1556 acc8= constant 129
1557 call writeLineAcc8
1558 br 1563
1559 acc16= constant 999
1560 call writeLineAcc16
1561 ;test15.j(224)     //var word/var byte
1562 ;test15.j(225)     if (w2 & b1 == 0x0014) println (130); else println (999);
1563 acc16= variable 4
1564 acc16And variable 0
1565 acc8= constant 20
1566 acc16CompareAcc8
1567 brne 1571
1568 acc8= constant 130
1569 call writeLineAcc8
1570 br 1574
1571 acc16= constant 999
1572 call writeLineAcc16
1573 ;test15.j(226)     if (w2 | b1 == 0x123C) println (131); else println (999);
1574 acc16= variable 4
1575 acc16Or variable 0
1576 acc16Comp constant 4668
1577 brne 1581
1578 acc8= constant 131
1579 call writeLineAcc8
1580 br 1584
1581 acc16= constant 999
1582 call writeLineAcc16
1583 ;test15.j(227)     if (w2 ^ b1 == 0x1228) println (132); else println (999);
1584 acc16= variable 4
1585 acc16Xor variable 0
1586 acc16Comp constant 4648
1587 brne 1591
1588 acc8= constant 132
1589 call writeLineAcc8
1590 br 1598
1591 acc16= constant 999
1592 call writeLineAcc16
1593 ;test15.j(228)   
1594 ;test15.j(229)     //var/final var
1595 ;test15.j(230)     //*************
1596 ;test15.j(231)     //var byte/final var byte
1597 ;test15.j(232)     if (b2 & fb1 == 0x04) println (133); else println (999);
1598 acc8= variable 1
1599 acc8And constant 28
1600 acc8Comp constant 4
1601 brne 1605
1602 acc8= constant 133
1603 call writeLineAcc8
1604 br 1608
1605 acc16= constant 999
1606 call writeLineAcc16
1607 ;test15.j(233)     if (b2 | fb1 == 0x1F) println (134); else println (999);
1608 acc8= variable 1
1609 acc8Or constant 28
1610 acc8Comp constant 31
1611 brne 1615
1612 acc8= constant 134
1613 call writeLineAcc8
1614 br 1618
1615 acc16= constant 999
1616 call writeLineAcc16
1617 ;test15.j(234)     if (b2 ^ fb1 == 0x1B) println (135); else println (999);
1618 acc8= variable 1
1619 acc8Xor constant 28
1620 acc8Comp constant 27
1621 brne 1625
1622 acc8= constant 135
1623 call writeLineAcc8
1624 br 1629
1625 acc16= constant 999
1626 call writeLineAcc16
1627 ;test15.j(235)     //var word/final var word
1628 ;test15.j(236)     if (w2 & fw1 == 0x0224) println (136); else println (999);
1629 acc16= variable 4
1630 acc16And constant 812
1631 acc16Comp constant 548
1632 brne 1636
1633 acc8= constant 136
1634 call writeLineAcc8
1635 br 1639
1636 acc16= constant 999
1637 call writeLineAcc16
1638 ;test15.j(237)     if (w2 | fw1 == 0x133C) println (137); else println (999);
1639 acc16= variable 4
1640 acc16Or constant 812
1641 acc16Comp constant 4924
1642 brne 1646
1643 acc8= constant 137
1644 call writeLineAcc8
1645 br 1649
1646 acc16= constant 999
1647 call writeLineAcc16
1648 ;test15.j(238)     if (w2 ^ fw1 == 0x1118) println (138); else println (999);
1649 acc16= variable 4
1650 acc16Xor constant 812
1651 acc16Comp constant 4376
1652 brne 1656
1653 acc8= constant 138
1654 call writeLineAcc8
1655 br 1660
1656 acc16= constant 999
1657 call writeLineAcc16
1658 ;test15.j(239)     //var byte/final var word
1659 ;test15.j(240)     if (b1 & fw2 == 0x0014) println (139); else println (999);
1660 acc8= variable 0
1661 acc8ToAcc16
1662 acc16And constant 4660
1663 acc8= constant 20
1664 acc16CompareAcc8
1665 brne 1669
1666 acc8= constant 139
1667 call writeLineAcc8
1668 br 1672
1669 acc16= constant 999
1670 call writeLineAcc16
1671 ;test15.j(241)     if (b1 | fw2 == 0x123C) println (140); else println (999);
1672 acc8= variable 0
1673 acc8ToAcc16
1674 acc16Or constant 4660
1675 acc16Comp constant 4668
1676 brne 1680
1677 acc8= constant 140
1678 call writeLineAcc8
1679 br 1683
1680 acc16= constant 999
1681 call writeLineAcc16
1682 ;test15.j(242)     if (b1 ^ fw2 == 0x1228) println (141); else println (999);
1683 acc8= variable 0
1684 acc8ToAcc16
1685 acc16Xor constant 4660
1686 acc16Comp constant 4648
1687 brne 1691
1688 acc8= constant 141
1689 call writeLineAcc8
1690 br 1695
1691 acc16= constant 999
1692 call writeLineAcc16
1693 ;test15.j(243)     //var word/final var byte
1694 ;test15.j(244)     if (w2 & fb1 == 0x0014) println (142); else println (999);
1695 acc16= variable 4
1696 acc16And constant 28
1697 acc8= constant 20
1698 acc16CompareAcc8
1699 brne 1703
1700 acc8= constant 142
1701 call writeLineAcc8
1702 br 1706
1703 acc16= constant 999
1704 call writeLineAcc16
1705 ;test15.j(245)     if (w2 | fb1 == 0x123C) println (143); else println (999);
1706 acc16= variable 4
1707 acc16Or constant 28
1708 acc16Comp constant 4668
1709 brne 1713
1710 acc8= constant 143
1711 call writeLineAcc8
1712 br 1716
1713 acc16= constant 999
1714 call writeLineAcc16
1715 ;test15.j(246)     if (w2 ^ fb1 == 0x1228) println (144); else println (999);
1716 acc16= variable 4
1717 acc16Xor constant 28
1718 acc16Comp constant 4648
1719 brne 1723
1720 acc8= constant 144
1721 call writeLineAcc8
1722 br 1730
1723 acc16= constant 999
1724 call writeLineAcc16
1725 ;test15.j(247)   
1726 ;test15.j(248)     //final var/constant
1727 ;test15.j(249)     //******************
1728 ;test15.j(250)     //final var byte/constant byte
1729 ;test15.j(251)     if (b2 & 0x1C == 0x04) println (145); else println (999);
1730 acc8= variable 1
1731 acc8And constant 28
1732 acc8Comp constant 4
1733 brne 1737
1734 acc8= constant 145
1735 call writeLineAcc8
1736 br 1740
1737 acc16= constant 999
1738 call writeLineAcc16
1739 ;test15.j(252)     if (b2 | 0x1C == 0x1F) println (146); else println (999);
1740 acc8= variable 1
1741 acc8Or constant 28
1742 acc8Comp constant 31
1743 brne 1747
1744 acc8= constant 146
1745 call writeLineAcc8
1746 br 1750
1747 acc16= constant 999
1748 call writeLineAcc16
1749 ;test15.j(253)     if (b2 ^ 0x1C == 0x1B) println (147); else println (999);
1750 acc8= variable 1
1751 acc8Xor constant 28
1752 acc8Comp constant 27
1753 brne 1757
1754 acc8= constant 147
1755 call writeLineAcc8
1756 br 1761
1757 acc16= constant 999
1758 call writeLineAcc16
1759 ;test15.j(254)     //final var word/constant word
1760 ;test15.j(255)     if (w2 & 0x032C == 0x0224) println (148); else println (999);
1761 acc16= variable 4
1762 acc16And constant 812
1763 acc16Comp constant 548
1764 brne 1768
1765 acc8= constant 148
1766 call writeLineAcc8
1767 br 1771
1768 acc16= constant 999
1769 call writeLineAcc16
1770 ;test15.j(256)     if (w2 | 0x032C == 0x133C) println (149); else println (999);
1771 acc16= variable 4
1772 acc16Or constant 812
1773 acc16Comp constant 4924
1774 brne 1778
1775 acc8= constant 149
1776 call writeLineAcc8
1777 br 1781
1778 acc16= constant 999
1779 call writeLineAcc16
1780 ;test15.j(257)     if (w2 ^ 0x032C == 0x1118) println (150); else println (999);
1781 acc16= variable 4
1782 acc16Xor constant 812
1783 acc16Comp constant 4376
1784 brne 1788
1785 acc8= constant 150
1786 call writeLineAcc8
1787 br 1792
1788 acc16= constant 999
1789 call writeLineAcc16
1790 ;test15.j(258)     //final var byte/constant word
1791 ;test15.j(259)     if (b1 & 0x1234 == 0x0014) println (151); else println (999);
1792 acc8= variable 0
1793 acc8ToAcc16
1794 acc16And constant 4660
1795 acc8= constant 20
1796 acc16CompareAcc8
1797 brne 1801
1798 acc8= constant 151
1799 call writeLineAcc8
1800 br 1804
1801 acc16= constant 999
1802 call writeLineAcc16
1803 ;test15.j(260)     if (b1 | 0x1234 == 0x123C) println (152); else println (999);
1804 acc8= variable 0
1805 acc8ToAcc16
1806 acc16Or constant 4660
1807 acc16Comp constant 4668
1808 brne 1812
1809 acc8= constant 152
1810 call writeLineAcc8
1811 br 1815
1812 acc16= constant 999
1813 call writeLineAcc16
1814 ;test15.j(261)     if (b1 ^ 0x1234 == 0x1228) println (153); else println (999);
1815 acc8= variable 0
1816 acc8ToAcc16
1817 acc16Xor constant 4660
1818 acc16Comp constant 4648
1819 brne 1823
1820 acc8= constant 153
1821 call writeLineAcc8
1822 br 1827
1823 acc16= constant 999
1824 call writeLineAcc16
1825 ;test15.j(262)     //final var word/constant byte
1826 ;test15.j(263)     if (w2 & 0x1C == 0x0014) println (154); else println (999);
1827 acc16= variable 4
1828 acc16And constant 28
1829 acc8= constant 20
1830 acc16CompareAcc8
1831 brne 1835
1832 acc8= constant 154
1833 call writeLineAcc8
1834 br 1838
1835 acc16= constant 999
1836 call writeLineAcc16
1837 ;test15.j(264)     if (w2 | 0x1C == 0x123C) println (155); else println (999);
1838 acc16= variable 4
1839 acc16Or constant 28
1840 acc16Comp constant 4668
1841 brne 1845
1842 acc8= constant 155
1843 call writeLineAcc8
1844 br 1848
1845 acc16= constant 999
1846 call writeLineAcc16
1847 ;test15.j(265)     if (w2 ^ 0x1C == 0x1228) println (156); else println (999);
1848 acc16= variable 4
1849 acc16Xor constant 28
1850 acc16Comp constant 4648
1851 brne 1855
1852 acc8= constant 156
1853 call writeLineAcc8
1854 br 1862
1855 acc16= constant 999
1856 call writeLineAcc16
1857 ;test15.j(266)   
1858 ;test15.j(267)     //final var/acc
1859 ;test15.j(268)     //*************
1860 ;test15.j(269)     //final var byte/acc byte
1861 ;test15.j(270)     if (b2 & (0x10 + 0x0C) == 0x04) println (157); else println (999);
1862 acc8= variable 1
1863 <acc8= constant 16
1864 acc8+ constant 12
1865 acc8And unstack8
1866 acc8Comp constant 4
1867 brne 1871
1868 acc8= constant 157
1869 call writeLineAcc8
1870 br 1874
1871 acc16= constant 999
1872 call writeLineAcc16
1873 ;test15.j(271)     if (b2 | (0x10 + 0x0C) == 0x1F) println (158); else println (999);
1874 acc8= variable 1
1875 <acc8= constant 16
1876 acc8+ constant 12
1877 acc8Or unstack8
1878 acc8Comp constant 31
1879 brne 1883
1880 acc8= constant 158
1881 call writeLineAcc8
1882 br 1886
1883 acc16= constant 999
1884 call writeLineAcc16
1885 ;test15.j(272)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (159); else println (999);
1886 acc8= variable 1
1887 <acc8= constant 16
1888 acc8+ constant 12
1889 acc8Xor unstack8
1890 acc8Comp constant 27
1891 brne 1895
1892 acc8= constant 159
1893 call writeLineAcc8
1894 br 1899
1895 acc16= constant 999
1896 call writeLineAcc16
1897 ;test15.j(273)     //final var word/acc word
1898 ;test15.j(274)     if (w2 & 0x0100 + 0x022C == 0x0224) println (160); else println (999);
1899 acc16= variable 4
1900 <acc16= constant 256
1901 acc16+ constant 556
1902 acc16And unstack16
1903 acc16Comp constant 548
1904 brne 1908
1905 acc8= constant 160
1906 call writeLineAcc8
1907 br 1911
1908 acc16= constant 999
1909 call writeLineAcc16
1910 ;test15.j(275)     if (w2 | 0x0100 + 0x022C == 0x133C) println (161); else println (999);
1911 acc16= variable 4
1912 <acc16= constant 256
1913 acc16+ constant 556
1914 acc16Or unstack16
1915 acc16Comp constant 4924
1916 brne 1920
1917 acc8= constant 161
1918 call writeLineAcc8
1919 br 1923
1920 acc16= constant 999
1921 call writeLineAcc16
1922 ;test15.j(276)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (162); else println (999);
1923 acc16= variable 4
1924 <acc16= constant 256
1925 acc16+ constant 556
1926 acc16Xor unstack16
1927 acc16Comp constant 4376
1928 brne 1932
1929 acc8= constant 162
1930 call writeLineAcc8
1931 br 1936
1932 acc16= constant 999
1933 call writeLineAcc16
1934 ;test15.j(277)     //final var byte/acc word
1935 ;test15.j(278)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (163); else println (999);
1936 acc8= variable 0
1937 acc16= constant 4096
1938 acc16+ constant 564
1939 acc16And acc8
1940 acc8= constant 20
1941 acc16CompareAcc8
1942 brne 1946
1943 acc8= constant 163
1944 call writeLineAcc8
1945 br 1949
1946 acc16= constant 999
1947 call writeLineAcc16
1948 ;test15.j(279)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (164); else println (999);
1949 acc8= variable 0
1950 acc16= constant 4096
1951 acc16+ constant 564
1952 acc16Or acc8
1953 acc16Comp constant 4668
1954 brne 1958
1955 acc8= constant 164
1956 call writeLineAcc8
1957 br 1961
1958 acc16= constant 999
1959 call writeLineAcc16
1960 ;test15.j(280)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (165); else println (999);
1961 acc8= variable 0
1962 acc16= constant 4096
1963 acc16+ constant 564
1964 acc16Xor acc8
1965 acc16Comp constant 4648
1966 brne 1970
1967 acc8= constant 165
1968 call writeLineAcc8
1969 br 1974
1970 acc16= constant 999
1971 call writeLineAcc16
1972 ;test15.j(281)     //final var word/acc byte
1973 ;test15.j(282)     if (w2 & 0x10 + 0x0C == 0x0014) println (166); else println (999);
1974 acc16= variable 4
1975 acc8= constant 16
1976 acc8+ constant 12
1977 acc16And acc8
1978 acc8= constant 20
1979 acc16CompareAcc8
1980 brne 1984
1981 acc8= constant 166
1982 call writeLineAcc8
1983 br 1987
1984 acc16= constant 999
1985 call writeLineAcc16
1986 ;test15.j(283)     if (w2 | 0x10 + 0x0C == 0x123C) println (167); else println (999);
1987 acc16= variable 4
1988 acc8= constant 16
1989 acc8+ constant 12
1990 acc16Or acc8
1991 acc16Comp constant 4668
1992 brne 1996
1993 acc8= constant 167
1994 call writeLineAcc8
1995 br 1999
1996 acc16= constant 999
1997 call writeLineAcc16
1998 ;test15.j(284)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (168); else println (999);
1999 acc16= variable 4
2000 acc8= constant 16
2001 acc8+ constant 12
2002 acc16Xor acc8
2003 acc16Comp constant 4648
2004 brne 2008
2005 acc8= constant 168
2006 call writeLineAcc8
2007 br 2015
2008 acc16= constant 999
2009 call writeLineAcc16
2010 ;test15.j(285)   
2011 ;test15.j(286)     //final var/var
2012 ;test15.j(287)     //*************
2013 ;test15.j(288)     //final var byte/var byte
2014 ;test15.j(289)     if (b2 & b1 == 0x04) println (169); else println (999);
2015 acc8= variable 1
2016 acc8And variable 0
2017 acc8Comp constant 4
2018 brne 2022
2019 acc8= constant 169
2020 call writeLineAcc8
2021 br 2025
2022 acc16= constant 999
2023 call writeLineAcc16
2024 ;test15.j(290)     if (b2 | b1 == 0x1F) println (170); else println (999);
2025 acc8= variable 1
2026 acc8Or variable 0
2027 acc8Comp constant 31
2028 brne 2032
2029 acc8= constant 170
2030 call writeLineAcc8
2031 br 2035
2032 acc16= constant 999
2033 call writeLineAcc16
2034 ;test15.j(291)     if (b2 ^ b1 == 0x1B) println (171); else println (999);
2035 acc8= variable 1
2036 acc8Xor variable 0
2037 acc8Comp constant 27
2038 brne 2042
2039 acc8= constant 171
2040 call writeLineAcc8
2041 br 2046
2042 acc16= constant 999
2043 call writeLineAcc16
2044 ;test15.j(292)     //final var word/var word
2045 ;test15.j(293)     if (w2 & w1 == 0x0224) println (172); else println (999);
2046 acc16= variable 4
2047 acc16And variable 2
2048 acc16Comp constant 548
2049 brne 2053
2050 acc8= constant 172
2051 call writeLineAcc8
2052 br 2056
2053 acc16= constant 999
2054 call writeLineAcc16
2055 ;test15.j(294)     if (w2 | w1 == 0x133C) println (173); else println (999);
2056 acc16= variable 4
2057 acc16Or variable 2
2058 acc16Comp constant 4924
2059 brne 2063
2060 acc8= constant 173
2061 call writeLineAcc8
2062 br 2066
2063 acc16= constant 999
2064 call writeLineAcc16
2065 ;test15.j(295)     if (w2 ^ w1 == 0x1118) println (174); else println (999);
2066 acc16= variable 4
2067 acc16Xor variable 2
2068 acc16Comp constant 4376
2069 brne 2073
2070 acc8= constant 174
2071 call writeLineAcc8
2072 br 2077
2073 acc16= constant 999
2074 call writeLineAcc16
2075 ;test15.j(296)     //final var byte/var word
2076 ;test15.j(297)     if (b1 & w2 == 0x0014) println (175); else println (999);
2077 acc8= variable 0
2078 acc8ToAcc16
2079 acc16And variable 4
2080 acc8= constant 20
2081 acc16CompareAcc8
2082 brne 2086
2083 acc8= constant 175
2084 call writeLineAcc8
2085 br 2089
2086 acc16= constant 999
2087 call writeLineAcc16
2088 ;test15.j(298)     if (b1 | w2 == 0x123C) println (176); else println (999);
2089 acc8= variable 0
2090 acc8ToAcc16
2091 acc16Or variable 4
2092 acc16Comp constant 4668
2093 brne 2097
2094 acc8= constant 176
2095 call writeLineAcc8
2096 br 2100
2097 acc16= constant 999
2098 call writeLineAcc16
2099 ;test15.j(299)     if (b1 ^ w2 == 0x1228) println (177); else println (999);
2100 acc8= variable 0
2101 acc8ToAcc16
2102 acc16Xor variable 4
2103 acc16Comp constant 4648
2104 brne 2108
2105 acc8= constant 177
2106 call writeLineAcc8
2107 br 2112
2108 acc16= constant 999
2109 call writeLineAcc16
2110 ;test15.j(300)     //final var word/var byte
2111 ;test15.j(301)     if (w2 & b1 == 0x0014) println (178); else println (999);
2112 acc16= variable 4
2113 acc16And variable 0
2114 acc8= constant 20
2115 acc16CompareAcc8
2116 brne 2120
2117 acc8= constant 178
2118 call writeLineAcc8
2119 br 2123
2120 acc16= constant 999
2121 call writeLineAcc16
2122 ;test15.j(302)     if (w2 | b1 == 0x123C) println (179); else println (999);
2123 acc16= variable 4
2124 acc16Or variable 0
2125 acc16Comp constant 4668
2126 brne 2130
2127 acc8= constant 179
2128 call writeLineAcc8
2129 br 2133
2130 acc16= constant 999
2131 call writeLineAcc16
2132 ;test15.j(303)     if (w2 ^ b1 == 0x1228) println (180); else println (999);
2133 acc16= variable 4
2134 acc16Xor variable 0
2135 acc16Comp constant 4648
2136 brne 2140
2137 acc8= constant 180
2138 call writeLineAcc8
2139 br 2147
2140 acc16= constant 999
2141 call writeLineAcc16
2142 ;test15.j(304)   
2143 ;test15.j(305)     //final var/final var
2144 ;test15.j(306)     //*******************
2145 ;test15.j(307)     //final var byte/final var byte
2146 ;test15.j(308)     if (fb2 & fb1 == 0x04) println (181); else println (999);
2147 acc8= constant 7
2148 acc8And constant 28
2149 acc8Comp constant 4
2150 brne 2154
2151 acc8= constant 181
2152 call writeLineAcc8
2153 br 2157
2154 acc16= constant 999
2155 call writeLineAcc16
2156 ;test15.j(309)     if (fb2 | fb1 == 0x1F) println (182); else println (999);
2157 acc8= constant 7
2158 acc8Or constant 28
2159 acc8Comp constant 31
2160 brne 2164
2161 acc8= constant 182
2162 call writeLineAcc8
2163 br 2167
2164 acc16= constant 999
2165 call writeLineAcc16
2166 ;test15.j(310)     if (fb2 ^ fb1 == 0x1B) println (183); else println (999);
2167 acc8= constant 7
2168 acc8Xor constant 28
2169 acc8Comp constant 27
2170 brne 2174
2171 acc8= constant 183
2172 call writeLineAcc8
2173 br 2178
2174 acc16= constant 999
2175 call writeLineAcc16
2176 ;test15.j(311)     //final var word/final var word
2177 ;test15.j(312)     if (fw2 & fw1 == 0x0224) println (184); else println (999);
2178 acc16= constant 4660
2179 acc16And constant 812
2180 acc16Comp constant 548
2181 brne 2185
2182 acc8= constant 184
2183 call writeLineAcc8
2184 br 2188
2185 acc16= constant 999
2186 call writeLineAcc16
2187 ;test15.j(313)     if (fw2 | fw1 == 0x133C) println (185); else println (999);
2188 acc16= constant 4660
2189 acc16Or constant 812
2190 acc16Comp constant 4924
2191 brne 2195
2192 acc8= constant 185
2193 call writeLineAcc8
2194 br 2198
2195 acc16= constant 999
2196 call writeLineAcc16
2197 ;test15.j(314)     if (fw2 ^ fw1 == 0x1118) println (186); else println (999);
2198 acc16= constant 4660
2199 acc16Xor constant 812
2200 acc16Comp constant 4376
2201 brne 2205
2202 acc8= constant 186
2203 call writeLineAcc8
2204 br 2209
2205 acc16= constant 999
2206 call writeLineAcc16
2207 ;test15.j(315)     //final var byte/final var word
2208 ;test15.j(316)     if (fb1 & fw2 == 0x0014) println (187); else println (999);
2209 acc8= constant 28
2210 acc8ToAcc16
2211 acc16And constant 4660
2212 acc8= constant 20
2213 acc16CompareAcc8
2214 brne 2218
2215 acc8= constant 187
2216 call writeLineAcc8
2217 br 2221
2218 acc16= constant 999
2219 call writeLineAcc16
2220 ;test15.j(317)     if (fb1 | fw2 == 0x123C) println (188); else println (999);
2221 acc8= constant 28
2222 acc8ToAcc16
2223 acc16Or constant 4660
2224 acc16Comp constant 4668
2225 brne 2229
2226 acc8= constant 188
2227 call writeLineAcc8
2228 br 2232
2229 acc16= constant 999
2230 call writeLineAcc16
2231 ;test15.j(318)     if (fb1 ^ fw2 == 0x1228) println (189); else println (999);
2232 acc8= constant 28
2233 acc8ToAcc16
2234 acc16Xor constant 4660
2235 acc16Comp constant 4648
2236 brne 2240
2237 acc8= constant 189
2238 call writeLineAcc8
2239 br 2244
2240 acc16= constant 999
2241 call writeLineAcc16
2242 ;test15.j(319)     //final var word/final var byte
2243 ;test15.j(320)     if (fw2 & fb1 == 0x0014) println (190); else println (999);
2244 acc16= constant 4660
2245 acc16And constant 28
2246 acc8= constant 20
2247 acc16CompareAcc8
2248 brne 2252
2249 acc8= constant 190
2250 call writeLineAcc8
2251 br 2255
2252 acc16= constant 999
2253 call writeLineAcc16
2254 ;test15.j(321)     if (fw2 | fb1 == 0x123C) println (191); else println (999);
2255 acc16= constant 4660
2256 acc16Or constant 28
2257 acc16Comp constant 4668
2258 brne 2262
2259 acc8= constant 191
2260 call writeLineAcc8
2261 br 2265
2262 acc16= constant 999
2263 call writeLineAcc16
2264 ;test15.j(322)     if (fw2 ^ fb1 == 0x1228) println (192); else println (999);
2265 acc16= constant 4660
2266 acc16Xor constant 28
2267 acc16Comp constant 4648
2268 brne 2272
2269 acc8= constant 192
2270 call writeLineAcc8
2271 br 2276
2272 acc16= constant 999
2273 call writeLineAcc16
2274 ;test15.j(323)   
2275 ;test15.j(324)     println("Klaar");
2276 acc16= constant 2281
2277 writeLineString
2278 ;test15.j(325)   }
2279 ;test15.j(326) }
2280 stop
2281 stringConstant 0 = "Klaar"
