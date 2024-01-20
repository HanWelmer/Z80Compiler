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
  20 ;test15.j(12)     println(0);
  21 acc8= constant 0
  22 call writeLineAcc8
  23 ;test15.j(13)     
  24 ;test15.j(14)     // Possible operand types: constant, acc, var, final var, stack8, stack16.
  25 ;test15.j(15)     // Possible data types: byte, word.
  26 ;test15.j(16)   
  27 ;test15.j(17)     //constant/constant
  28 ;test15.j(18)     //*****************
  29 ;test15.j(19)     //constant byte/constant byte
  30 ;test15.j(20)     if (0x07 & 0x1C == 0x04) println (1); else println (999); //0000.0111 & 0001.1100 = 0000.0100
  31 acc8= constant 7
  32 acc8And constant 28
  33 acc8Comp constant 4
  34 brne 38
  35 acc8= constant 1
  36 call writeLineAcc8
  37 br 41
  38 acc16= constant 999
  39 call writeLineAcc16
  40 ;test15.j(21)     if (0x07 | 0x1C == 0x1F) println (2); else println (999); //0000.0111 | 0001.1100 = 0001.1111
  41 acc8= constant 7
  42 acc8Or constant 28
  43 acc8Comp constant 31
  44 brne 48
  45 acc8= constant 2
  46 call writeLineAcc8
  47 br 51
  48 acc16= constant 999
  49 call writeLineAcc16
  50 ;test15.j(22)     if (0x07 ^ 0x1C == 0x1B) println (3); else println (999); //0000.0111 ^ 0001.1100 = 0001.1011
  51 acc8= constant 7
  52 acc8Xor constant 28
  53 acc8Comp constant 27
  54 brne 58
  55 acc8= constant 3
  56 call writeLineAcc8
  57 br 62
  58 acc16= constant 999
  59 call writeLineAcc16
  60 ;test15.j(23)     //constant word/constant word
  61 ;test15.j(24)     if (0x1234 & 0x032C == 0x0224) println (4); else println (999);
  62 acc16= constant 4660
  63 acc16And constant 812
  64 acc16Comp constant 548
  65 brne 69
  66 acc8= constant 4
  67 call writeLineAcc8
  68 br 73
  69 acc16= constant 999
  70 call writeLineAcc16
  71 ;test15.j(25)     //0001.0010.0011.0100 & 0000.0011.0010.1100 = 0000.0010.0010.0100
  72 ;test15.j(26)     if (0x1234 | 0x032C == 0x133C) println (5); else println (999);
  73 acc16= constant 4660
  74 acc16Or constant 812
  75 acc16Comp constant 4924
  76 brne 80
  77 acc8= constant 5
  78 call writeLineAcc8
  79 br 84
  80 acc16= constant 999
  81 call writeLineAcc16
  82 ;test15.j(27)     //0001.0010.0011.0100 | 0000.0011.0010.1100 = 0001.0011.0011.1100
  83 ;test15.j(28)     if (0x1234 ^ 0x032C == 0x1118) println (6); else println (999);
  84 acc16= constant 4660
  85 acc16Xor constant 812
  86 acc16Comp constant 4376
  87 brne 91
  88 acc8= constant 6
  89 call writeLineAcc8
  90 br 96
  91 acc16= constant 999
  92 call writeLineAcc16
  93 ;test15.j(29)     //0001.0010.0011.0100 ^ 0000.0011.0010.1100 = 0001.0001.0001.1000
  94 ;test15.j(30)     //constant byte/constant word
  95 ;test15.j(31)     if (0x1C & 0x1234 == 0x0014) println (7); else println (999); //0001.1100 & 0001.0010.0011.0100 = 0000.0000.0001.0100
  96 acc8= constant 28
  97 acc8ToAcc16
  98 acc16And constant 4660
  99 acc8= constant 20
 100 acc16CompareAcc8
 101 brne 105
 102 acc8= constant 7
 103 call writeLineAcc8
 104 br 108
 105 acc16= constant 999
 106 call writeLineAcc16
 107 ;test15.j(32)     if (0x1C | 0x1234 == 0x123C) println (8); else println (999); //0001.1100 | 0001.0010.0011.0100 = 0001.0010.0011.1100
 108 acc8= constant 28
 109 acc8ToAcc16
 110 acc16Or constant 4660
 111 acc16Comp constant 4668
 112 brne 116
 113 acc8= constant 8
 114 call writeLineAcc8
 115 br 119
 116 acc16= constant 999
 117 call writeLineAcc16
 118 ;test15.j(33)     if (0x1C ^ 0x1234 == 0x1228) println (9); else println (999); //0001.1100 ^ 0001.0010.0011.0100 = 0001.0010.0010.1000
 119 acc8= constant 28
 120 acc8ToAcc16
 121 acc16Xor constant 4660
 122 acc16Comp constant 4648
 123 brne 127
 124 acc8= constant 9
 125 call writeLineAcc8
 126 br 131
 127 acc16= constant 999
 128 call writeLineAcc16
 129 ;test15.j(34)     //constant word/constant byte
 130 ;test15.j(35)     if (0x1234 & 0x1C == 0x0014) println (10); else println (999); //0001.0010.0011.0100 & 0001.1100 = 0000.0000.0001.0100
 131 acc16= constant 4660
 132 acc16And constant 28
 133 acc8= constant 20
 134 acc16CompareAcc8
 135 brne 139
 136 acc8= constant 10
 137 call writeLineAcc8
 138 br 142
 139 acc16= constant 999
 140 call writeLineAcc16
 141 ;test15.j(36)     if (0x1234 | 0x1C == 0x123C) println (11); else println (999); //0001.0010.0011.0100 | 0001.1100 = 0001.0010.0011.1100
 142 acc16= constant 4660
 143 acc16Or constant 28
 144 acc16Comp constant 4668
 145 brne 149
 146 acc8= constant 11
 147 call writeLineAcc8
 148 br 152
 149 acc16= constant 999
 150 call writeLineAcc16
 151 ;test15.j(37)     if (0x1234 ^ 0x1C == 0x1228) println (12); else println (999); //0001.0010.0011.0100 ^ 0001.1100 = 0001.0010.0010.1000
 152 acc16= constant 4660
 153 acc16Xor constant 28
 154 acc16Comp constant 4648
 155 brne 159
 156 acc8= constant 12
 157 call writeLineAcc8
 158 br 166
 159 acc16= constant 999
 160 call writeLineAcc16
 161 ;test15.j(38)   
 162 ;test15.j(39)     //constant/acc
 163 ;test15.j(40)     //************
 164 ;test15.j(41)     //constant byte/acc byte
 165 ;test15.j(42)     if (0x07 & (0x10 + 0x0C) == 0x04) println (13); else println (999);
 166 acc8= constant 7
 167 <acc8= constant 16
 168 acc8+ constant 12
 169 acc8And unstack8
 170 acc8Comp constant 4
 171 brne 175
 172 acc8= constant 13
 173 call writeLineAcc8
 174 br 178
 175 acc16= constant 999
 176 call writeLineAcc16
 177 ;test15.j(43)     if (0x07 | (0x10 + 0x0C) == 0x1F) println (14); else println (999);
 178 acc8= constant 7
 179 <acc8= constant 16
 180 acc8+ constant 12
 181 acc8Or unstack8
 182 acc8Comp constant 31
 183 brne 187
 184 acc8= constant 14
 185 call writeLineAcc8
 186 br 190
 187 acc16= constant 999
 188 call writeLineAcc16
 189 ;test15.j(44)     if (0x07 ^ (0x10 + 0x0C) == 0x1B) println (15); else println (999);
 190 acc8= constant 7
 191 <acc8= constant 16
 192 acc8+ constant 12
 193 acc8Xor unstack8
 194 acc8Comp constant 27
 195 brne 199
 196 acc8= constant 15
 197 call writeLineAcc8
 198 br 203
 199 acc16= constant 999
 200 call writeLineAcc16
 201 ;test15.j(45)     //constant word/acc word
 202 ;test15.j(46)     if (0x1234 & 0x0100 + 0x022C == 0x0224) println (16); else println (999);
 203 acc16= constant 4660
 204 <acc16= constant 256
 205 acc16+ constant 556
 206 acc16And unstack16
 207 acc16Comp constant 548
 208 brne 212
 209 acc8= constant 16
 210 call writeLineAcc8
 211 br 215
 212 acc16= constant 999
 213 call writeLineAcc16
 214 ;test15.j(47)     if (0x1234 | 0x0100 + 0x022C == 0x133C) println (17); else println (999);
 215 acc16= constant 4660
 216 <acc16= constant 256
 217 acc16+ constant 556
 218 acc16Or unstack16
 219 acc16Comp constant 4924
 220 brne 224
 221 acc8= constant 17
 222 call writeLineAcc8
 223 br 227
 224 acc16= constant 999
 225 call writeLineAcc16
 226 ;test15.j(48)     if (0x1234 ^ 0x0100 + 0x022C == 0x1118) println (18); else println (999);
 227 acc16= constant 4660
 228 <acc16= constant 256
 229 acc16+ constant 556
 230 acc16Xor unstack16
 231 acc16Comp constant 4376
 232 brne 236
 233 acc8= constant 18
 234 call writeLineAcc8
 235 br 240
 236 acc16= constant 999
 237 call writeLineAcc16
 238 ;test15.j(49)     //constant byte/acc word
 239 ;test15.j(50)     if (0x1C & 0x1000 + 0x0234 == 0x0014) println (19); else println (999);
 240 acc8= constant 28
 241 acc16= constant 4096
 242 acc16+ constant 564
 243 acc16And acc8
 244 acc8= constant 20
 245 acc16CompareAcc8
 246 brne 250
 247 acc8= constant 19
 248 call writeLineAcc8
 249 br 253
 250 acc16= constant 999
 251 call writeLineAcc16
 252 ;test15.j(51)     if (0x1C | 0x1000 + 0x0234 == 0x123C) println (20); else println (999);
 253 acc8= constant 28
 254 acc16= constant 4096
 255 acc16+ constant 564
 256 acc16Or acc8
 257 acc16Comp constant 4668
 258 brne 262
 259 acc8= constant 20
 260 call writeLineAcc8
 261 br 265
 262 acc16= constant 999
 263 call writeLineAcc16
 264 ;test15.j(52)     if (0x1C ^ 0x1000 + 0x0234 == 0x1228) println (21); else println (999);
 265 acc8= constant 28
 266 acc16= constant 4096
 267 acc16+ constant 564
 268 acc16Xor acc8
 269 acc16Comp constant 4648
 270 brne 274
 271 acc8= constant 21
 272 call writeLineAcc8
 273 br 278
 274 acc16= constant 999
 275 call writeLineAcc16
 276 ;test15.j(53)     //constant word/acc byte
 277 ;test15.j(54)     if (0x1234 & 0x10 + 0x0C == 0x0014) println (22); else println (999);
 278 acc16= constant 4660
 279 acc8= constant 16
 280 acc8+ constant 12
 281 acc16And acc8
 282 acc8= constant 20
 283 acc16CompareAcc8
 284 brne 288
 285 acc8= constant 22
 286 call writeLineAcc8
 287 br 291
 288 acc16= constant 999
 289 call writeLineAcc16
 290 ;test15.j(55)     if (0x1234 | 0x10 + 0x0C == 0x123C) println (23); else println (999);
 291 acc16= constant 4660
 292 acc8= constant 16
 293 acc8+ constant 12
 294 acc16Or acc8
 295 acc16Comp constant 4668
 296 brne 300
 297 acc8= constant 23
 298 call writeLineAcc8
 299 br 303
 300 acc16= constant 999
 301 call writeLineAcc16
 302 ;test15.j(56)     if (0x1234 ^ 0x10 + 0x0C == 0x1228) println (24); else println (999);
 303 acc16= constant 4660
 304 acc8= constant 16
 305 acc8+ constant 12
 306 acc16Xor acc8
 307 acc16Comp constant 4648
 308 brne 312
 309 acc8= constant 24
 310 call writeLineAcc8
 311 br 319
 312 acc16= constant 999
 313 call writeLineAcc16
 314 ;test15.j(57)   
 315 ;test15.j(58)     //constant/var
 316 ;test15.j(59)     //*****************
 317 ;test15.j(60)     //constant byte/var byte
 318 ;test15.j(61)     if (0x07 & b1 == 0x04) println (25); else println (999);
 319 acc8= constant 7
 320 acc8And variable 0
 321 acc8Comp constant 4
 322 brne 326
 323 acc8= constant 25
 324 call writeLineAcc8
 325 br 329
 326 acc16= constant 999
 327 call writeLineAcc16
 328 ;test15.j(62)     if (0x07 | b1 == 0x1F) println (26); else println (999);
 329 acc8= constant 7
 330 acc8Or variable 0
 331 acc8Comp constant 31
 332 brne 336
 333 acc8= constant 26
 334 call writeLineAcc8
 335 br 339
 336 acc16= constant 999
 337 call writeLineAcc16
 338 ;test15.j(63)     if (0x07 ^ b1 == 0x1B) println (27); else println (999);
 339 acc8= constant 7
 340 acc8Xor variable 0
 341 acc8Comp constant 27
 342 brne 346
 343 acc8= constant 27
 344 call writeLineAcc8
 345 br 350
 346 acc16= constant 999
 347 call writeLineAcc16
 348 ;test15.j(64)     //constant word/var word
 349 ;test15.j(65)     if (0x1234 & w1 == 0x0224) println (28); else println (999);
 350 acc16= constant 4660
 351 acc16And variable 2
 352 acc16Comp constant 548
 353 brne 357
 354 acc8= constant 28
 355 call writeLineAcc8
 356 br 360
 357 acc16= constant 999
 358 call writeLineAcc16
 359 ;test15.j(66)     if (0x1234 | w1 == 0x133C) println (29); else println (999);
 360 acc16= constant 4660
 361 acc16Or variable 2
 362 acc16Comp constant 4924
 363 brne 367
 364 acc8= constant 29
 365 call writeLineAcc8
 366 br 370
 367 acc16= constant 999
 368 call writeLineAcc16
 369 ;test15.j(67)     if (0x1234 ^ w1 == 0x1118) println (30); else println (999);
 370 acc16= constant 4660
 371 acc16Xor variable 2
 372 acc16Comp constant 4376
 373 brne 377
 374 acc8= constant 30
 375 call writeLineAcc8
 376 br 381
 377 acc16= constant 999
 378 call writeLineAcc16
 379 ;test15.j(68)     //constant byte/var word
 380 ;test15.j(69)     if (0x1C & w2 == 0x0014) println (31); else println (999);
 381 acc8= constant 28
 382 acc8ToAcc16
 383 acc16And variable 4
 384 acc8= constant 20
 385 acc16CompareAcc8
 386 brne 390
 387 acc8= constant 31
 388 call writeLineAcc8
 389 br 393
 390 acc16= constant 999
 391 call writeLineAcc16
 392 ;test15.j(70)     if (0x1C | w2 == 0x123C) println (32); else println (999);
 393 acc8= constant 28
 394 acc8ToAcc16
 395 acc16Or variable 4
 396 acc16Comp constant 4668
 397 brne 401
 398 acc8= constant 32
 399 call writeLineAcc8
 400 br 404
 401 acc16= constant 999
 402 call writeLineAcc16
 403 ;test15.j(71)     if (0x1C ^ w2 == 0x1228) println (33); else println (999);
 404 acc8= constant 28
 405 acc8ToAcc16
 406 acc16Xor variable 4
 407 acc16Comp constant 4648
 408 brne 412
 409 acc8= constant 33
 410 call writeLineAcc8
 411 br 416
 412 acc16= constant 999
 413 call writeLineAcc16
 414 ;test15.j(72)     //constant word/var byte
 415 ;test15.j(73)     if (0x1234 & b1 == 0x0014) println (34); else println (999);
 416 acc16= constant 4660
 417 acc16And variable 0
 418 acc8= constant 20
 419 acc16CompareAcc8
 420 brne 424
 421 acc8= constant 34
 422 call writeLineAcc8
 423 br 427
 424 acc16= constant 999
 425 call writeLineAcc16
 426 ;test15.j(74)     if (0x1234 | b1 == 0x123C) println (35); else println (999);
 427 acc16= constant 4660
 428 acc16Or variable 0
 429 acc16Comp constant 4668
 430 brne 434
 431 acc8= constant 35
 432 call writeLineAcc8
 433 br 437
 434 acc16= constant 999
 435 call writeLineAcc16
 436 ;test15.j(75)     if (0x1234 ^ b1 == 0x1228) println (36); else println (999);
 437 acc16= constant 4660
 438 acc16Xor variable 0
 439 acc16Comp constant 4648
 440 brne 444
 441 acc8= constant 36
 442 call writeLineAcc8
 443 br 451
 444 acc16= constant 999
 445 call writeLineAcc16
 446 ;test15.j(76)   
 447 ;test15.j(77)     //constant/final var
 448 ;test15.j(78)     //*****************
 449 ;test15.j(79)     //constant byte/final var byte
 450 ;test15.j(80)     if (0x07 & fb1 == 0x04) println (37); else println (999);
 451 acc8= constant 7
 452 acc8And constant 28
 453 acc8Comp constant 4
 454 brne 458
 455 acc8= constant 37
 456 call writeLineAcc8
 457 br 461
 458 acc16= constant 999
 459 call writeLineAcc16
 460 ;test15.j(81)     if (0x07 | fb1 == 0x1F) println (38); else println (999);
 461 acc8= constant 7
 462 acc8Or constant 28
 463 acc8Comp constant 31
 464 brne 468
 465 acc8= constant 38
 466 call writeLineAcc8
 467 br 471
 468 acc16= constant 999
 469 call writeLineAcc16
 470 ;test15.j(82)     if (0x07 ^ fb1 == 0x1B) println (39); else println (999);
 471 acc8= constant 7
 472 acc8Xor constant 28
 473 acc8Comp constant 27
 474 brne 478
 475 acc8= constant 39
 476 call writeLineAcc8
 477 br 482
 478 acc16= constant 999
 479 call writeLineAcc16
 480 ;test15.j(83)     //constant word/final var word
 481 ;test15.j(84)     if (0x1234 & fw1 == 0x0224) println (40); else println (999);
 482 acc16= constant 4660
 483 acc16And constant 812
 484 acc16Comp constant 548
 485 brne 489
 486 acc8= constant 40
 487 call writeLineAcc8
 488 br 492
 489 acc16= constant 999
 490 call writeLineAcc16
 491 ;test15.j(85)     if (0x1234 | fw1 == 0x133C) println (41); else println (999);
 492 acc16= constant 4660
 493 acc16Or constant 812
 494 acc16Comp constant 4924
 495 brne 499
 496 acc8= constant 41
 497 call writeLineAcc8
 498 br 502
 499 acc16= constant 999
 500 call writeLineAcc16
 501 ;test15.j(86)     if (0x1234 ^ fw1 == 0x1118) println (42); else println (999);
 502 acc16= constant 4660
 503 acc16Xor constant 812
 504 acc16Comp constant 4376
 505 brne 509
 506 acc8= constant 42
 507 call writeLineAcc8
 508 br 513
 509 acc16= constant 999
 510 call writeLineAcc16
 511 ;test15.j(87)     //constant byte/final var word
 512 ;test15.j(88)     if (0x1C & fw2 == 0x0014) println (43); else println (999);
 513 acc8= constant 28
 514 acc8ToAcc16
 515 acc16And constant 4660
 516 acc8= constant 20
 517 acc16CompareAcc8
 518 brne 522
 519 acc8= constant 43
 520 call writeLineAcc8
 521 br 525
 522 acc16= constant 999
 523 call writeLineAcc16
 524 ;test15.j(89)     if (0x1C | fw2 == 0x123C) println (44); else println (999);
 525 acc8= constant 28
 526 acc8ToAcc16
 527 acc16Or constant 4660
 528 acc16Comp constant 4668
 529 brne 533
 530 acc8= constant 44
 531 call writeLineAcc8
 532 br 536
 533 acc16= constant 999
 534 call writeLineAcc16
 535 ;test15.j(90)     if (0x1C ^ fw2 == 0x1228) println (45); else println (999);
 536 acc8= constant 28
 537 acc8ToAcc16
 538 acc16Xor constant 4660
 539 acc16Comp constant 4648
 540 brne 544
 541 acc8= constant 45
 542 call writeLineAcc8
 543 br 548
 544 acc16= constant 999
 545 call writeLineAcc16
 546 ;test15.j(91)     //constant word/final var byte
 547 ;test15.j(92)     if (0x1234 & fb1 == 0x0014) println (46); else println (999);
 548 acc16= constant 4660
 549 acc16And constant 28
 550 acc8= constant 20
 551 acc16CompareAcc8
 552 brne 556
 553 acc8= constant 46
 554 call writeLineAcc8
 555 br 559
 556 acc16= constant 999
 557 call writeLineAcc16
 558 ;test15.j(93)     if (0x1234 | fb1 == 0x123C) println (47); else println (999);
 559 acc16= constant 4660
 560 acc16Or constant 28
 561 acc16Comp constant 4668
 562 brne 566
 563 acc8= constant 47
 564 call writeLineAcc8
 565 br 569
 566 acc16= constant 999
 567 call writeLineAcc16
 568 ;test15.j(94)     if (0x1234 ^ fb1 == 0x1228) println (48); else println (999);
 569 acc16= constant 4660
 570 acc16Xor constant 28
 571 acc16Comp constant 4648
 572 brne 576
 573 acc8= constant 48
 574 call writeLineAcc8
 575 br 583
 576 acc16= constant 999
 577 call writeLineAcc16
 578 ;test15.j(95)   
 579 ;test15.j(96)     //acc/constant
 580 ;test15.j(97)     //************
 581 ;test15.j(98)     //acc byte/constant byte
 582 ;test15.j(99)     if ((0x04 + 0x03) & 0x1C == 0x04) println (49); else println (999);
 583 acc8= constant 4
 584 acc8+ constant 3
 585 acc8And constant 28
 586 acc8Comp constant 4
 587 brne 591
 588 acc8= constant 49
 589 call writeLineAcc8
 590 br 594
 591 acc16= constant 999
 592 call writeLineAcc16
 593 ;test15.j(100)     if ((0x04 + 0x03) | 0x1C == 0x1F) println (50); else println (999);
 594 acc8= constant 4
 595 acc8+ constant 3
 596 acc8Or constant 28
 597 acc8Comp constant 31
 598 brne 602
 599 acc8= constant 50
 600 call writeLineAcc8
 601 br 605
 602 acc16= constant 999
 603 call writeLineAcc16
 604 ;test15.j(101)     if ((0x04 + 0x03) ^ 0x1C == 0x1B) println (51); else println (999);
 605 acc8= constant 4
 606 acc8+ constant 3
 607 acc8Xor constant 28
 608 acc8Comp constant 27
 609 brne 613
 610 acc8= constant 51
 611 call writeLineAcc8
 612 br 617
 613 acc16= constant 999
 614 call writeLineAcc16
 615 ;test15.j(102)     //acc word/constant word
 616 ;test15.j(103)     if (0x1000 + 0x0234 & 0x032C == 0x0224) println (52); else println (999);
 617 acc16= constant 4096
 618 acc16+ constant 564
 619 acc16And constant 812
 620 acc16Comp constant 548
 621 brne 625
 622 acc8= constant 52
 623 call writeLineAcc8
 624 br 628
 625 acc16= constant 999
 626 call writeLineAcc16
 627 ;test15.j(104)     if (0x1000 + 0x0234 | 0x032C == 0x133C) println (53); else println (999);
 628 acc16= constant 4096
 629 acc16+ constant 564
 630 acc16Or constant 812
 631 acc16Comp constant 4924
 632 brne 636
 633 acc8= constant 53
 634 call writeLineAcc8
 635 br 639
 636 acc16= constant 999
 637 call writeLineAcc16
 638 ;test15.j(105)     if (0x1000 + 0x0234 ^ 0x032C == 0x1118) println (54); else println (999);
 639 acc16= constant 4096
 640 acc16+ constant 564
 641 acc16Xor constant 812
 642 acc16Comp constant 4376
 643 brne 647
 644 acc8= constant 54
 645 call writeLineAcc8
 646 br 651
 647 acc16= constant 999
 648 call writeLineAcc16
 649 ;test15.j(106)     //acc byte/constant word
 650 ;test15.j(107)     if (0x10 + 0x0C & 0x1234 == 0x0014) println (55); else println (999);
 651 acc8= constant 16
 652 acc8+ constant 12
 653 acc8ToAcc16
 654 acc16And constant 4660
 655 acc8= constant 20
 656 acc16CompareAcc8
 657 brne 661
 658 acc8= constant 55
 659 call writeLineAcc8
 660 br 664
 661 acc16= constant 999
 662 call writeLineAcc16
 663 ;test15.j(108)     if (0x10 + 0x0C | 0x1234 == 0x123C) println (56); else println (999);
 664 acc8= constant 16
 665 acc8+ constant 12
 666 acc8ToAcc16
 667 acc16Or constant 4660
 668 acc16Comp constant 4668
 669 brne 673
 670 acc8= constant 56
 671 call writeLineAcc8
 672 br 676
 673 acc16= constant 999
 674 call writeLineAcc16
 675 ;test15.j(109)     if (0x10 + 0x0C ^ 0x1234 == 0x1228) println (57); else println (999);
 676 acc8= constant 16
 677 acc8+ constant 12
 678 acc8ToAcc16
 679 acc16Xor constant 4660
 680 acc16Comp constant 4648
 681 brne 685
 682 acc8= constant 57
 683 call writeLineAcc8
 684 br 689
 685 acc16= constant 999
 686 call writeLineAcc16
 687 ;test15.j(110)     //acc word/constant byte
 688 ;test15.j(111)     if (0x1000 + 0x0234 & 0x1C == 0x0014) println (58); else println (999);
 689 acc16= constant 4096
 690 acc16+ constant 564
 691 acc16And constant 28
 692 acc8= constant 20
 693 acc16CompareAcc8
 694 brne 698
 695 acc8= constant 58
 696 call writeLineAcc8
 697 br 701
 698 acc16= constant 999
 699 call writeLineAcc16
 700 ;test15.j(112)     if (0x1000 + 0x0234 | 0x1C == 0x123C) println (59); else println (999);
 701 acc16= constant 4096
 702 acc16+ constant 564
 703 acc16Or constant 28
 704 acc16Comp constant 4668
 705 brne 709
 706 acc8= constant 59
 707 call writeLineAcc8
 708 br 712
 709 acc16= constant 999
 710 call writeLineAcc16
 711 ;test15.j(113)     if (0x1000 + 0x0234 ^ 0x1C == 0x1228) println (60); else println (999);
 712 acc16= constant 4096
 713 acc16+ constant 564
 714 acc16Xor constant 28
 715 acc16Comp constant 4648
 716 brne 720
 717 acc8= constant 60
 718 call writeLineAcc8
 719 br 727
 720 acc16= constant 999
 721 call writeLineAcc16
 722 ;test15.j(114)   
 723 ;test15.j(115)     //acc/acc
 724 ;test15.j(116)     //*******
 725 ;test15.j(117)     //acc byte/acc byte
 726 ;test15.j(118)     if (0x04 + 0x03 & 0x10 + 0x0C == 0x04) println (61); else println (999);
 727 acc8= constant 4
 728 acc8+ constant 3
 729 <acc8= constant 16
 730 acc8+ constant 12
 731 acc8And unstack8
 732 acc8Comp constant 4
 733 brne 737
 734 acc8= constant 61
 735 call writeLineAcc8
 736 br 740
 737 acc16= constant 999
 738 call writeLineAcc16
 739 ;test15.j(119)     if (0x04 + 0x03 | 0x10 + 0x0C == 0x1F) println (62); else println (999);
 740 acc8= constant 4
 741 acc8+ constant 3
 742 <acc8= constant 16
 743 acc8+ constant 12
 744 acc8Or unstack8
 745 acc8Comp constant 31
 746 brne 750
 747 acc8= constant 62
 748 call writeLineAcc8
 749 br 753
 750 acc16= constant 999
 751 call writeLineAcc16
 752 ;test15.j(120)     if (0x04 + 0x03 ^ 0x10 + 0x0C == 0x1B) println (63); else println (999);
 753 acc8= constant 4
 754 acc8+ constant 3
 755 <acc8= constant 16
 756 acc8+ constant 12
 757 acc8Xor unstack8
 758 acc8Comp constant 27
 759 brne 763
 760 acc8= constant 63
 761 call writeLineAcc8
 762 br 767
 763 acc16= constant 999
 764 call writeLineAcc16
 765 ;test15.j(121)     //acc word/acc word
 766 ;test15.j(122)     if (0x1000 + 0x0234 & 0x0100 + 0x022C == 0x0224) println (64); else println (999);
 767 acc16= constant 4096
 768 acc16+ constant 564
 769 <acc16= constant 256
 770 acc16+ constant 556
 771 acc16And unstack16
 772 acc16Comp constant 548
 773 brne 777
 774 acc8= constant 64
 775 call writeLineAcc8
 776 br 780
 777 acc16= constant 999
 778 call writeLineAcc16
 779 ;test15.j(123)     if (0x1000 + 0x0234 | 0x0100 + 0x022C == 0x133C) println (65); else println (999);
 780 acc16= constant 4096
 781 acc16+ constant 564
 782 <acc16= constant 256
 783 acc16+ constant 556
 784 acc16Or unstack16
 785 acc16Comp constant 4924
 786 brne 790
 787 acc8= constant 65
 788 call writeLineAcc8
 789 br 793
 790 acc16= constant 999
 791 call writeLineAcc16
 792 ;test15.j(124)     if (0x1000 + 0x0234 ^ 0x0100 + 0x022C == 0x1118) println (66); else println (999);
 793 acc16= constant 4096
 794 acc16+ constant 564
 795 <acc16= constant 256
 796 acc16+ constant 556
 797 acc16Xor unstack16
 798 acc16Comp constant 4376
 799 brne 803
 800 acc8= constant 66
 801 call writeLineAcc8
 802 br 807
 803 acc16= constant 999
 804 call writeLineAcc16
 805 ;test15.j(125)     //acc byte/acc word
 806 ;test15.j(126)     if (0x10 + 0x0C & 0x1000 + 0x0234 == 0x0014) println (67); else println (999);
 807 acc8= constant 16
 808 acc8+ constant 12
 809 acc16= constant 4096
 810 acc16+ constant 564
 811 acc16And acc8
 812 acc8= constant 20
 813 acc16CompareAcc8
 814 brne 818
 815 acc8= constant 67
 816 call writeLineAcc8
 817 br 821
 818 acc16= constant 999
 819 call writeLineAcc16
 820 ;test15.j(127)     if (0x10 + 0x0C | 0x1000 + 0x0234 == 0x123C) println (68); else println (999);
 821 acc8= constant 16
 822 acc8+ constant 12
 823 acc16= constant 4096
 824 acc16+ constant 564
 825 acc16Or acc8
 826 acc16Comp constant 4668
 827 brne 831
 828 acc8= constant 68
 829 call writeLineAcc8
 830 br 834
 831 acc16= constant 999
 832 call writeLineAcc16
 833 ;test15.j(128)     if (0x10 + 0x0C ^ 0x1000 + 0x0234 == 0x1228) println (69); else println (999);
 834 acc8= constant 16
 835 acc8+ constant 12
 836 acc16= constant 4096
 837 acc16+ constant 564
 838 acc16Xor acc8
 839 acc16Comp constant 4648
 840 brne 844
 841 acc8= constant 69
 842 call writeLineAcc8
 843 br 848
 844 acc16= constant 999
 845 call writeLineAcc16
 846 ;test15.j(129)     //acc word/acc byte
 847 ;test15.j(130)     if (0x1000 + 0x0234 & 0x10 + 0x0C == 0x0014) println (70); else println (999);
 848 acc16= constant 4096
 849 acc16+ constant 564
 850 acc8= constant 16
 851 acc8+ constant 12
 852 acc16And acc8
 853 acc8= constant 20
 854 acc16CompareAcc8
 855 brne 859
 856 acc8= constant 70
 857 call writeLineAcc8
 858 br 862
 859 acc16= constant 999
 860 call writeLineAcc16
 861 ;test15.j(131)     if (0x1000 + 0x0234 | 0x10 + 0x0C == 0x123C) println (71); else println (999);
 862 acc16= constant 4096
 863 acc16+ constant 564
 864 acc8= constant 16
 865 acc8+ constant 12
 866 acc16Or acc8
 867 acc16Comp constant 4668
 868 brne 872
 869 acc8= constant 71
 870 call writeLineAcc8
 871 br 875
 872 acc16= constant 999
 873 call writeLineAcc16
 874 ;test15.j(132)     if (0x1000 + 0x0234 ^ 0x10 + 0x0C == 0x1228) println (72); else println (999);
 875 acc16= constant 4096
 876 acc16+ constant 564
 877 acc8= constant 16
 878 acc8+ constant 12
 879 acc16Xor acc8
 880 acc16Comp constant 4648
 881 brne 885
 882 acc8= constant 72
 883 call writeLineAcc8
 884 br 892
 885 acc16= constant 999
 886 call writeLineAcc16
 887 ;test15.j(133)   
 888 ;test15.j(134)     //acc/var
 889 ;test15.j(135)     //*******
 890 ;test15.j(136)     //acc byte/var byte
 891 ;test15.j(137)     if (0x04 + 0x03 & b1 == 0x04) println (73); else println (999);
 892 acc8= constant 4
 893 acc8+ constant 3
 894 acc8And variable 0
 895 acc8Comp constant 4
 896 brne 900
 897 acc8= constant 73
 898 call writeLineAcc8
 899 br 903
 900 acc16= constant 999
 901 call writeLineAcc16
 902 ;test15.j(138)     if (0x04 + 0x03 | b1 == 0x1F) println (74); else println (999);
 903 acc8= constant 4
 904 acc8+ constant 3
 905 acc8Or variable 0
 906 acc8Comp constant 31
 907 brne 911
 908 acc8= constant 74
 909 call writeLineAcc8
 910 br 914
 911 acc16= constant 999
 912 call writeLineAcc16
 913 ;test15.j(139)     if (0x04 + 0x03 ^ b1 == 0x1B) println (75); else println (999);
 914 acc8= constant 4
 915 acc8+ constant 3
 916 acc8Xor variable 0
 917 acc8Comp constant 27
 918 brne 922
 919 acc8= constant 75
 920 call writeLineAcc8
 921 br 926
 922 acc16= constant 999
 923 call writeLineAcc16
 924 ;test15.j(140)     //acc word/var word
 925 ;test15.j(141)     if (0x1000 + 0x0234 & w1 == 0x0224) println (76); else println (999);
 926 acc16= constant 4096
 927 acc16+ constant 564
 928 acc16And variable 2
 929 acc16Comp constant 548
 930 brne 934
 931 acc8= constant 76
 932 call writeLineAcc8
 933 br 937
 934 acc16= constant 999
 935 call writeLineAcc16
 936 ;test15.j(142)     if (0x1000 + 0x0234 | w1 == 0x133C) println (77); else println (999);
 937 acc16= constant 4096
 938 acc16+ constant 564
 939 acc16Or variable 2
 940 acc16Comp constant 4924
 941 brne 945
 942 acc8= constant 77
 943 call writeLineAcc8
 944 br 948
 945 acc16= constant 999
 946 call writeLineAcc16
 947 ;test15.j(143)     if (0x1000 + 0x0234 ^ w1 == 0x1118) println (78); else println (999);
 948 acc16= constant 4096
 949 acc16+ constant 564
 950 acc16Xor variable 2
 951 acc16Comp constant 4376
 952 brne 956
 953 acc8= constant 78
 954 call writeLineAcc8
 955 br 960
 956 acc16= constant 999
 957 call writeLineAcc16
 958 ;test15.j(144)     //acc byte/var word
 959 ;test15.j(145)     if (0x10 + 0x0C & w2 == 0x0014) println (79); else println (999);
 960 acc8= constant 16
 961 acc8+ constant 12
 962 acc8ToAcc16
 963 acc16And variable 4
 964 acc8= constant 20
 965 acc16CompareAcc8
 966 brne 970
 967 acc8= constant 79
 968 call writeLineAcc8
 969 br 973
 970 acc16= constant 999
 971 call writeLineAcc16
 972 ;test15.j(146)     if (0x10 + 0x0C | w2 == 0x123C) println (80); else println (999);
 973 acc8= constant 16
 974 acc8+ constant 12
 975 acc8ToAcc16
 976 acc16Or variable 4
 977 acc16Comp constant 4668
 978 brne 982
 979 acc8= constant 80
 980 call writeLineAcc8
 981 br 985
 982 acc16= constant 999
 983 call writeLineAcc16
 984 ;test15.j(147)     if (0x10 + 0x0C ^ w2 == 0x1228) println (81); else println (999);
 985 acc8= constant 16
 986 acc8+ constant 12
 987 acc8ToAcc16
 988 acc16Xor variable 4
 989 acc16Comp constant 4648
 990 brne 994
 991 acc8= constant 81
 992 call writeLineAcc8
 993 br 998
 994 acc16= constant 999
 995 call writeLineAcc16
 996 ;test15.j(148)     //acc word/var byte
 997 ;test15.j(149)     if (0x1000 + 0x0234 & b1 == 0x0014) println (82); else println (999);
 998 acc16= constant 4096
 999 acc16+ constant 564
1000 acc16And variable 0
1001 acc8= constant 20
1002 acc16CompareAcc8
1003 brne 1007
1004 acc8= constant 82
1005 call writeLineAcc8
1006 br 1010
1007 acc16= constant 999
1008 call writeLineAcc16
1009 ;test15.j(150)     if (0x1000 + 0x0234 | b1 == 0x123C) println (83); else println (999);
1010 acc16= constant 4096
1011 acc16+ constant 564
1012 acc16Or variable 0
1013 acc16Comp constant 4668
1014 brne 1018
1015 acc8= constant 83
1016 call writeLineAcc8
1017 br 1021
1018 acc16= constant 999
1019 call writeLineAcc16
1020 ;test15.j(151)     if (0x1000 + 0x0234 ^ b1 == 0x1228) println (84); else println (999);
1021 acc16= constant 4096
1022 acc16+ constant 564
1023 acc16Xor variable 0
1024 acc16Comp constant 4648
1025 brne 1029
1026 acc8= constant 84
1027 call writeLineAcc8
1028 br 1036
1029 acc16= constant 999
1030 call writeLineAcc16
1031 ;test15.j(152)   
1032 ;test15.j(153)     //acc/final var
1033 ;test15.j(154)     //*************
1034 ;test15.j(155)     //acc byte/final var byte
1035 ;test15.j(156)     if (0x04 + 0x03 & fb1 == 0x04) println (85); else println (999);
1036 acc8= constant 4
1037 acc8+ constant 3
1038 acc8And constant 28
1039 acc8Comp constant 4
1040 brne 1044
1041 acc8= constant 85
1042 call writeLineAcc8
1043 br 1047
1044 acc16= constant 999
1045 call writeLineAcc16
1046 ;test15.j(157)     if (0x04 + 0x03 | fb1 == 0x1F) println (86); else println (999);
1047 acc8= constant 4
1048 acc8+ constant 3
1049 acc8Or constant 28
1050 acc8Comp constant 31
1051 brne 1055
1052 acc8= constant 86
1053 call writeLineAcc8
1054 br 1058
1055 acc16= constant 999
1056 call writeLineAcc16
1057 ;test15.j(158)     if (0x04 + 0x03 ^ fb1 == 0x1B) println (87); else println (999);
1058 acc8= constant 4
1059 acc8+ constant 3
1060 acc8Xor constant 28
1061 acc8Comp constant 27
1062 brne 1066
1063 acc8= constant 87
1064 call writeLineAcc8
1065 br 1070
1066 acc16= constant 999
1067 call writeLineAcc16
1068 ;test15.j(159)     //acc word/final var word
1069 ;test15.j(160)     if (0x1000 + 0x0234 & fw1 == 0x0224) println (88); else println (999);
1070 acc16= constant 4096
1071 acc16+ constant 564
1072 acc16And constant 812
1073 acc16Comp constant 548
1074 brne 1078
1075 acc8= constant 88
1076 call writeLineAcc8
1077 br 1081
1078 acc16= constant 999
1079 call writeLineAcc16
1080 ;test15.j(161)     if (0x1000 + 0x0234 | fw1 == 0x133C) println (89); else println (999);
1081 acc16= constant 4096
1082 acc16+ constant 564
1083 acc16Or constant 812
1084 acc16Comp constant 4924
1085 brne 1089
1086 acc8= constant 89
1087 call writeLineAcc8
1088 br 1092
1089 acc16= constant 999
1090 call writeLineAcc16
1091 ;test15.j(162)     if (0x1000 + 0x0234 ^ fw1 == 0x1118) println (90); else println (999);
1092 acc16= constant 4096
1093 acc16+ constant 564
1094 acc16Xor constant 812
1095 acc16Comp constant 4376
1096 brne 1100
1097 acc8= constant 90
1098 call writeLineAcc8
1099 br 1104
1100 acc16= constant 999
1101 call writeLineAcc16
1102 ;test15.j(163)     //acc byte/final var word
1103 ;test15.j(164)     if (0x10 + 0x0C & fw2 == 0x0014) println (91); else println (999);
1104 acc8= constant 16
1105 acc8+ constant 12
1106 acc8ToAcc16
1107 acc16And constant 4660
1108 acc8= constant 20
1109 acc16CompareAcc8
1110 brne 1114
1111 acc8= constant 91
1112 call writeLineAcc8
1113 br 1117
1114 acc16= constant 999
1115 call writeLineAcc16
1116 ;test15.j(165)     if (0x10 + 0x0C | fw2 == 0x123C) println (92); else println (999);
1117 acc8= constant 16
1118 acc8+ constant 12
1119 acc8ToAcc16
1120 acc16Or constant 4660
1121 acc16Comp constant 4668
1122 brne 1126
1123 acc8= constant 92
1124 call writeLineAcc8
1125 br 1129
1126 acc16= constant 999
1127 call writeLineAcc16
1128 ;test15.j(166)     if (0x10 + 0x0C ^ fw2 == 0x1228) println (93); else println (999);
1129 acc8= constant 16
1130 acc8+ constant 12
1131 acc8ToAcc16
1132 acc16Xor constant 4660
1133 acc16Comp constant 4648
1134 brne 1138
1135 acc8= constant 93
1136 call writeLineAcc8
1137 br 1142
1138 acc16= constant 999
1139 call writeLineAcc16
1140 ;test15.j(167)     //acc word/final var byte
1141 ;test15.j(168)     if (0x1000 + 0x0234 & fb1 == 0x0014) println (94); else println (999);
1142 acc16= constant 4096
1143 acc16+ constant 564
1144 acc16And constant 28
1145 acc8= constant 20
1146 acc16CompareAcc8
1147 brne 1151
1148 acc8= constant 94
1149 call writeLineAcc8
1150 br 1154
1151 acc16= constant 999
1152 call writeLineAcc16
1153 ;test15.j(169)     if (0x1000 + 0x0234 | fb1 == 0x123C) println (95); else println (999);
1154 acc16= constant 4096
1155 acc16+ constant 564
1156 acc16Or constant 28
1157 acc16Comp constant 4668
1158 brne 1162
1159 acc8= constant 95
1160 call writeLineAcc8
1161 br 1165
1162 acc16= constant 999
1163 call writeLineAcc16
1164 ;test15.j(170)     if (0x1000 + 0x0234 ^ fb1 == 0x1228) println (96); else println (999);
1165 acc16= constant 4096
1166 acc16+ constant 564
1167 acc16Xor constant 28
1168 acc16Comp constant 4648
1169 brne 1173
1170 acc8= constant 96
1171 call writeLineAcc8
1172 br 1180
1173 acc16= constant 999
1174 call writeLineAcc16
1175 ;test15.j(171)   
1176 ;test15.j(172)     //var/constant
1177 ;test15.j(173)     //************
1178 ;test15.j(174)     //var byte/constant byte
1179 ;test15.j(175)     if (b2 & 0x1C == 0x04) println (97); else println (999);
1180 acc8= variable 1
1181 acc8And constant 28
1182 acc8Comp constant 4
1183 brne 1187
1184 acc8= constant 97
1185 call writeLineAcc8
1186 br 1190
1187 acc16= constant 999
1188 call writeLineAcc16
1189 ;test15.j(176)     if (b2 | 0x1C == 0x1F) println (98); else println (999);
1190 acc8= variable 1
1191 acc8Or constant 28
1192 acc8Comp constant 31
1193 brne 1197
1194 acc8= constant 98
1195 call writeLineAcc8
1196 br 1200
1197 acc16= constant 999
1198 call writeLineAcc16
1199 ;test15.j(177)     if (b2 ^ 0x1C == 0x1B) println (99); else println (999);
1200 acc8= variable 1
1201 acc8Xor constant 28
1202 acc8Comp constant 27
1203 brne 1207
1204 acc8= constant 99
1205 call writeLineAcc8
1206 br 1211
1207 acc16= constant 999
1208 call writeLineAcc16
1209 ;test15.j(178)     //var word/constant word
1210 ;test15.j(179)     if (w2 & 0x032C == 0x0224) println (100); else println (999);
1211 acc16= variable 4
1212 acc16And constant 812
1213 acc16Comp constant 548
1214 brne 1218
1215 acc8= constant 100
1216 call writeLineAcc8
1217 br 1221
1218 acc16= constant 999
1219 call writeLineAcc16
1220 ;test15.j(180)     if (w2 | 0x032C == 0x133C) println (101); else println (999);
1221 acc16= variable 4
1222 acc16Or constant 812
1223 acc16Comp constant 4924
1224 brne 1228
1225 acc8= constant 101
1226 call writeLineAcc8
1227 br 1231
1228 acc16= constant 999
1229 call writeLineAcc16
1230 ;test15.j(181)     if (w2 ^ 0x032C == 0x1118) println (102); else println (999);
1231 acc16= variable 4
1232 acc16Xor constant 812
1233 acc16Comp constant 4376
1234 brne 1238
1235 acc8= constant 102
1236 call writeLineAcc8
1237 br 1242
1238 acc16= constant 999
1239 call writeLineAcc16
1240 ;test15.j(182)     //var byte/constant word
1241 ;test15.j(183)     if (b1 & 0x1234 == 0x0014) println (103); else println (999);
1242 acc8= variable 0
1243 acc8ToAcc16
1244 acc16And constant 4660
1245 acc8= constant 20
1246 acc16CompareAcc8
1247 brne 1251
1248 acc8= constant 103
1249 call writeLineAcc8
1250 br 1254
1251 acc16= constant 999
1252 call writeLineAcc16
1253 ;test15.j(184)     if (b1 | 0x1234 == 0x123C) println (104); else println (999);
1254 acc8= variable 0
1255 acc8ToAcc16
1256 acc16Or constant 4660
1257 acc16Comp constant 4668
1258 brne 1262
1259 acc8= constant 104
1260 call writeLineAcc8
1261 br 1265
1262 acc16= constant 999
1263 call writeLineAcc16
1264 ;test15.j(185)     if (b1 ^ 0x1234 == 0x1228) println (105); else println (999);
1265 acc8= variable 0
1266 acc8ToAcc16
1267 acc16Xor constant 4660
1268 acc16Comp constant 4648
1269 brne 1273
1270 acc8= constant 105
1271 call writeLineAcc8
1272 br 1277
1273 acc16= constant 999
1274 call writeLineAcc16
1275 ;test15.j(186)     //var word/constant byte
1276 ;test15.j(187)     if (w2 & 0x1C == 0x0014) println (106); else println (999);
1277 acc16= variable 4
1278 acc16And constant 28
1279 acc8= constant 20
1280 acc16CompareAcc8
1281 brne 1285
1282 acc8= constant 106
1283 call writeLineAcc8
1284 br 1288
1285 acc16= constant 999
1286 call writeLineAcc16
1287 ;test15.j(188)     if (w2 | 0x1C == 0x123C) println (107); else println (999);
1288 acc16= variable 4
1289 acc16Or constant 28
1290 acc16Comp constant 4668
1291 brne 1295
1292 acc8= constant 107
1293 call writeLineAcc8
1294 br 1298
1295 acc16= constant 999
1296 call writeLineAcc16
1297 ;test15.j(189)     if (w2 ^ 0x1C == 0x1228) println (108); else println (999);
1298 acc16= variable 4
1299 acc16Xor constant 28
1300 acc16Comp constant 4648
1301 brne 1305
1302 acc8= constant 108
1303 call writeLineAcc8
1304 br 1312
1305 acc16= constant 999
1306 call writeLineAcc16
1307 ;test15.j(190)   
1308 ;test15.j(191)     //var/acc
1309 ;test15.j(192)     //*******
1310 ;test15.j(193)     //var byte/acc byte
1311 ;test15.j(194)     if (b2 & (0x10 + 0x0C) == 0x04) println (109); else println (999);
1312 acc8= variable 1
1313 <acc8= constant 16
1314 acc8+ constant 12
1315 acc8And unstack8
1316 acc8Comp constant 4
1317 brne 1321
1318 acc8= constant 109
1319 call writeLineAcc8
1320 br 1324
1321 acc16= constant 999
1322 call writeLineAcc16
1323 ;test15.j(195)     if (b2 | (0x10 + 0x0C) == 0x1F) println (110); else println (999);
1324 acc8= variable 1
1325 <acc8= constant 16
1326 acc8+ constant 12
1327 acc8Or unstack8
1328 acc8Comp constant 31
1329 brne 1333
1330 acc8= constant 110
1331 call writeLineAcc8
1332 br 1336
1333 acc16= constant 999
1334 call writeLineAcc16
1335 ;test15.j(196)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (111); else println (999);
1336 acc8= variable 1
1337 <acc8= constant 16
1338 acc8+ constant 12
1339 acc8Xor unstack8
1340 acc8Comp constant 27
1341 brne 1345
1342 acc8= constant 111
1343 call writeLineAcc8
1344 br 1349
1345 acc16= constant 999
1346 call writeLineAcc16
1347 ;test15.j(197)     //var word/acc word
1348 ;test15.j(198)     if (w2 & 0x0100 + 0x022C == 0x0224) println (112); else println (999);
1349 acc16= variable 4
1350 <acc16= constant 256
1351 acc16+ constant 556
1352 acc16And unstack16
1353 acc16Comp constant 548
1354 brne 1358
1355 acc8= constant 112
1356 call writeLineAcc8
1357 br 1361
1358 acc16= constant 999
1359 call writeLineAcc16
1360 ;test15.j(199)     if (w2 | 0x0100 + 0x022C == 0x133C) println (113); else println (999);
1361 acc16= variable 4
1362 <acc16= constant 256
1363 acc16+ constant 556
1364 acc16Or unstack16
1365 acc16Comp constant 4924
1366 brne 1370
1367 acc8= constant 113
1368 call writeLineAcc8
1369 br 1373
1370 acc16= constant 999
1371 call writeLineAcc16
1372 ;test15.j(200)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (114); else println (999);
1373 acc16= variable 4
1374 <acc16= constant 256
1375 acc16+ constant 556
1376 acc16Xor unstack16
1377 acc16Comp constant 4376
1378 brne 1382
1379 acc8= constant 114
1380 call writeLineAcc8
1381 br 1386
1382 acc16= constant 999
1383 call writeLineAcc16
1384 ;test15.j(201)     //var byte/acc word
1385 ;test15.j(202)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (115); else println (999);
1386 acc8= variable 0
1387 acc16= constant 4096
1388 acc16+ constant 564
1389 acc16And acc8
1390 acc8= constant 20
1391 acc16CompareAcc8
1392 brne 1396
1393 acc8= constant 115
1394 call writeLineAcc8
1395 br 1399
1396 acc16= constant 999
1397 call writeLineAcc16
1398 ;test15.j(203)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (116); else println (999);
1399 acc8= variable 0
1400 acc16= constant 4096
1401 acc16+ constant 564
1402 acc16Or acc8
1403 acc16Comp constant 4668
1404 brne 1408
1405 acc8= constant 116
1406 call writeLineAcc8
1407 br 1411
1408 acc16= constant 999
1409 call writeLineAcc16
1410 ;test15.j(204)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (117); else println (999);
1411 acc8= variable 0
1412 acc16= constant 4096
1413 acc16+ constant 564
1414 acc16Xor acc8
1415 acc16Comp constant 4648
1416 brne 1420
1417 acc8= constant 117
1418 call writeLineAcc8
1419 br 1424
1420 acc16= constant 999
1421 call writeLineAcc16
1422 ;test15.j(205)     //var word/acc byte
1423 ;test15.j(206)     if (w2 & 0x10 + 0x0C == 0x0014) println (118); else println (999);
1424 acc16= variable 4
1425 acc8= constant 16
1426 acc8+ constant 12
1427 acc16And acc8
1428 acc8= constant 20
1429 acc16CompareAcc8
1430 brne 1434
1431 acc8= constant 118
1432 call writeLineAcc8
1433 br 1437
1434 acc16= constant 999
1435 call writeLineAcc16
1436 ;test15.j(207)     if (w2 | 0x10 + 0x0C == 0x123C) println (119); else println (999);
1437 acc16= variable 4
1438 acc8= constant 16
1439 acc8+ constant 12
1440 acc16Or acc8
1441 acc16Comp constant 4668
1442 brne 1446
1443 acc8= constant 119
1444 call writeLineAcc8
1445 br 1449
1446 acc16= constant 999
1447 call writeLineAcc16
1448 ;test15.j(208)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (120); else println (999);
1449 acc16= variable 4
1450 acc8= constant 16
1451 acc8+ constant 12
1452 acc16Xor acc8
1453 acc16Comp constant 4648
1454 brne 1458
1455 acc8= constant 120
1456 call writeLineAcc8
1457 br 1465
1458 acc16= constant 999
1459 call writeLineAcc16
1460 ;test15.j(209)   
1461 ;test15.j(210)     //var/var
1462 ;test15.j(211)     //*******
1463 ;test15.j(212)     //var byte/var byte
1464 ;test15.j(213)     if (b2 & b1 == 0x04) println (121); else println (999);
1465 acc8= variable 1
1466 acc8And variable 0
1467 acc8Comp constant 4
1468 brne 1472
1469 acc8= constant 121
1470 call writeLineAcc8
1471 br 1475
1472 acc16= constant 999
1473 call writeLineAcc16
1474 ;test15.j(214)     if (b2 | b1 == 0x1F) println (122); else println (999);
1475 acc8= variable 1
1476 acc8Or variable 0
1477 acc8Comp constant 31
1478 brne 1482
1479 acc8= constant 122
1480 call writeLineAcc8
1481 br 1485
1482 acc16= constant 999
1483 call writeLineAcc16
1484 ;test15.j(215)     if (b2 ^ b1 == 0x1B) println (123); else println (999);
1485 acc8= variable 1
1486 acc8Xor variable 0
1487 acc8Comp constant 27
1488 brne 1492
1489 acc8= constant 123
1490 call writeLineAcc8
1491 br 1496
1492 acc16= constant 999
1493 call writeLineAcc16
1494 ;test15.j(216)     //var word/var word
1495 ;test15.j(217)     if (w2 & w1 == 0x0224) println (124); else println (999);
1496 acc16= variable 4
1497 acc16And variable 2
1498 acc16Comp constant 548
1499 brne 1503
1500 acc8= constant 124
1501 call writeLineAcc8
1502 br 1506
1503 acc16= constant 999
1504 call writeLineAcc16
1505 ;test15.j(218)     if (w2 | w1 == 0x133C) println (125); else println (999);
1506 acc16= variable 4
1507 acc16Or variable 2
1508 acc16Comp constant 4924
1509 brne 1513
1510 acc8= constant 125
1511 call writeLineAcc8
1512 br 1516
1513 acc16= constant 999
1514 call writeLineAcc16
1515 ;test15.j(219)     if (w2 ^ w1 == 0x1118) println (126); else println (999);
1516 acc16= variable 4
1517 acc16Xor variable 2
1518 acc16Comp constant 4376
1519 brne 1523
1520 acc8= constant 126
1521 call writeLineAcc8
1522 br 1527
1523 acc16= constant 999
1524 call writeLineAcc16
1525 ;test15.j(220)     //var byte/var word
1526 ;test15.j(221)     if (b1 & w2 == 0x0014) println (127); else println (999);
1527 acc8= variable 0
1528 acc8ToAcc16
1529 acc16And variable 4
1530 acc8= constant 20
1531 acc16CompareAcc8
1532 brne 1536
1533 acc8= constant 127
1534 call writeLineAcc8
1535 br 1539
1536 acc16= constant 999
1537 call writeLineAcc16
1538 ;test15.j(222)     if (b1 | w2 == 0x123C) println (128); else println (999);
1539 acc8= variable 0
1540 acc8ToAcc16
1541 acc16Or variable 4
1542 acc16Comp constant 4668
1543 brne 1547
1544 acc8= constant 128
1545 call writeLineAcc8
1546 br 1550
1547 acc16= constant 999
1548 call writeLineAcc16
1549 ;test15.j(223)     if (b1 ^ w2 == 0x1228) println (129); else println (999);
1550 acc8= variable 0
1551 acc8ToAcc16
1552 acc16Xor variable 4
1553 acc16Comp constant 4648
1554 brne 1558
1555 acc8= constant 129
1556 call writeLineAcc8
1557 br 1562
1558 acc16= constant 999
1559 call writeLineAcc16
1560 ;test15.j(224)     //var word/var byte
1561 ;test15.j(225)     if (w2 & b1 == 0x0014) println (130); else println (999);
1562 acc16= variable 4
1563 acc16And variable 0
1564 acc8= constant 20
1565 acc16CompareAcc8
1566 brne 1570
1567 acc8= constant 130
1568 call writeLineAcc8
1569 br 1573
1570 acc16= constant 999
1571 call writeLineAcc16
1572 ;test15.j(226)     if (w2 | b1 == 0x123C) println (131); else println (999);
1573 acc16= variable 4
1574 acc16Or variable 0
1575 acc16Comp constant 4668
1576 brne 1580
1577 acc8= constant 131
1578 call writeLineAcc8
1579 br 1583
1580 acc16= constant 999
1581 call writeLineAcc16
1582 ;test15.j(227)     if (w2 ^ b1 == 0x1228) println (132); else println (999);
1583 acc16= variable 4
1584 acc16Xor variable 0
1585 acc16Comp constant 4648
1586 brne 1590
1587 acc8= constant 132
1588 call writeLineAcc8
1589 br 1597
1590 acc16= constant 999
1591 call writeLineAcc16
1592 ;test15.j(228)   
1593 ;test15.j(229)     //var/final var
1594 ;test15.j(230)     //*************
1595 ;test15.j(231)     //var byte/final var byte
1596 ;test15.j(232)     if (b2 & fb1 == 0x04) println (133); else println (999);
1597 acc8= variable 1
1598 acc8And constant 28
1599 acc8Comp constant 4
1600 brne 1604
1601 acc8= constant 133
1602 call writeLineAcc8
1603 br 1607
1604 acc16= constant 999
1605 call writeLineAcc16
1606 ;test15.j(233)     if (b2 | fb1 == 0x1F) println (134); else println (999);
1607 acc8= variable 1
1608 acc8Or constant 28
1609 acc8Comp constant 31
1610 brne 1614
1611 acc8= constant 134
1612 call writeLineAcc8
1613 br 1617
1614 acc16= constant 999
1615 call writeLineAcc16
1616 ;test15.j(234)     if (b2 ^ fb1 == 0x1B) println (135); else println (999);
1617 acc8= variable 1
1618 acc8Xor constant 28
1619 acc8Comp constant 27
1620 brne 1624
1621 acc8= constant 135
1622 call writeLineAcc8
1623 br 1628
1624 acc16= constant 999
1625 call writeLineAcc16
1626 ;test15.j(235)     //var word/final var word
1627 ;test15.j(236)     if (w2 & fw1 == 0x0224) println (136); else println (999);
1628 acc16= variable 4
1629 acc16And constant 812
1630 acc16Comp constant 548
1631 brne 1635
1632 acc8= constant 136
1633 call writeLineAcc8
1634 br 1638
1635 acc16= constant 999
1636 call writeLineAcc16
1637 ;test15.j(237)     if (w2 | fw1 == 0x133C) println (137); else println (999);
1638 acc16= variable 4
1639 acc16Or constant 812
1640 acc16Comp constant 4924
1641 brne 1645
1642 acc8= constant 137
1643 call writeLineAcc8
1644 br 1648
1645 acc16= constant 999
1646 call writeLineAcc16
1647 ;test15.j(238)     if (w2 ^ fw1 == 0x1118) println (138); else println (999);
1648 acc16= variable 4
1649 acc16Xor constant 812
1650 acc16Comp constant 4376
1651 brne 1655
1652 acc8= constant 138
1653 call writeLineAcc8
1654 br 1659
1655 acc16= constant 999
1656 call writeLineAcc16
1657 ;test15.j(239)     //var byte/final var word
1658 ;test15.j(240)     if (b1 & fw2 == 0x0014) println (139); else println (999);
1659 acc8= variable 0
1660 acc8ToAcc16
1661 acc16And constant 4660
1662 acc8= constant 20
1663 acc16CompareAcc8
1664 brne 1668
1665 acc8= constant 139
1666 call writeLineAcc8
1667 br 1671
1668 acc16= constant 999
1669 call writeLineAcc16
1670 ;test15.j(241)     if (b1 | fw2 == 0x123C) println (140); else println (999);
1671 acc8= variable 0
1672 acc8ToAcc16
1673 acc16Or constant 4660
1674 acc16Comp constant 4668
1675 brne 1679
1676 acc8= constant 140
1677 call writeLineAcc8
1678 br 1682
1679 acc16= constant 999
1680 call writeLineAcc16
1681 ;test15.j(242)     if (b1 ^ fw2 == 0x1228) println (141); else println (999);
1682 acc8= variable 0
1683 acc8ToAcc16
1684 acc16Xor constant 4660
1685 acc16Comp constant 4648
1686 brne 1690
1687 acc8= constant 141
1688 call writeLineAcc8
1689 br 1694
1690 acc16= constant 999
1691 call writeLineAcc16
1692 ;test15.j(243)     //var word/final var byte
1693 ;test15.j(244)     if (w2 & fb1 == 0x0014) println (142); else println (999);
1694 acc16= variable 4
1695 acc16And constant 28
1696 acc8= constant 20
1697 acc16CompareAcc8
1698 brne 1702
1699 acc8= constant 142
1700 call writeLineAcc8
1701 br 1705
1702 acc16= constant 999
1703 call writeLineAcc16
1704 ;test15.j(245)     if (w2 | fb1 == 0x123C) println (143); else println (999);
1705 acc16= variable 4
1706 acc16Or constant 28
1707 acc16Comp constant 4668
1708 brne 1712
1709 acc8= constant 143
1710 call writeLineAcc8
1711 br 1715
1712 acc16= constant 999
1713 call writeLineAcc16
1714 ;test15.j(246)     if (w2 ^ fb1 == 0x1228) println (144); else println (999);
1715 acc16= variable 4
1716 acc16Xor constant 28
1717 acc16Comp constant 4648
1718 brne 1722
1719 acc8= constant 144
1720 call writeLineAcc8
1721 br 1729
1722 acc16= constant 999
1723 call writeLineAcc16
1724 ;test15.j(247)   
1725 ;test15.j(248)     //final var/constant
1726 ;test15.j(249)     //******************
1727 ;test15.j(250)     //final var byte/constant byte
1728 ;test15.j(251)     if (b2 & 0x1C == 0x04) println (145); else println (999);
1729 acc8= variable 1
1730 acc8And constant 28
1731 acc8Comp constant 4
1732 brne 1736
1733 acc8= constant 145
1734 call writeLineAcc8
1735 br 1739
1736 acc16= constant 999
1737 call writeLineAcc16
1738 ;test15.j(252)     if (b2 | 0x1C == 0x1F) println (146); else println (999);
1739 acc8= variable 1
1740 acc8Or constant 28
1741 acc8Comp constant 31
1742 brne 1746
1743 acc8= constant 146
1744 call writeLineAcc8
1745 br 1749
1746 acc16= constant 999
1747 call writeLineAcc16
1748 ;test15.j(253)     if (b2 ^ 0x1C == 0x1B) println (147); else println (999);
1749 acc8= variable 1
1750 acc8Xor constant 28
1751 acc8Comp constant 27
1752 brne 1756
1753 acc8= constant 147
1754 call writeLineAcc8
1755 br 1760
1756 acc16= constant 999
1757 call writeLineAcc16
1758 ;test15.j(254)     //final var word/constant word
1759 ;test15.j(255)     if (w2 & 0x032C == 0x0224) println (148); else println (999);
1760 acc16= variable 4
1761 acc16And constant 812
1762 acc16Comp constant 548
1763 brne 1767
1764 acc8= constant 148
1765 call writeLineAcc8
1766 br 1770
1767 acc16= constant 999
1768 call writeLineAcc16
1769 ;test15.j(256)     if (w2 | 0x032C == 0x133C) println (149); else println (999);
1770 acc16= variable 4
1771 acc16Or constant 812
1772 acc16Comp constant 4924
1773 brne 1777
1774 acc8= constant 149
1775 call writeLineAcc8
1776 br 1780
1777 acc16= constant 999
1778 call writeLineAcc16
1779 ;test15.j(257)     if (w2 ^ 0x032C == 0x1118) println (150); else println (999);
1780 acc16= variable 4
1781 acc16Xor constant 812
1782 acc16Comp constant 4376
1783 brne 1787
1784 acc8= constant 150
1785 call writeLineAcc8
1786 br 1791
1787 acc16= constant 999
1788 call writeLineAcc16
1789 ;test15.j(258)     //final var byte/constant word
1790 ;test15.j(259)     if (b1 & 0x1234 == 0x0014) println (151); else println (999);
1791 acc8= variable 0
1792 acc8ToAcc16
1793 acc16And constant 4660
1794 acc8= constant 20
1795 acc16CompareAcc8
1796 brne 1800
1797 acc8= constant 151
1798 call writeLineAcc8
1799 br 1803
1800 acc16= constant 999
1801 call writeLineAcc16
1802 ;test15.j(260)     if (b1 | 0x1234 == 0x123C) println (152); else println (999);
1803 acc8= variable 0
1804 acc8ToAcc16
1805 acc16Or constant 4660
1806 acc16Comp constant 4668
1807 brne 1811
1808 acc8= constant 152
1809 call writeLineAcc8
1810 br 1814
1811 acc16= constant 999
1812 call writeLineAcc16
1813 ;test15.j(261)     if (b1 ^ 0x1234 == 0x1228) println (153); else println (999);
1814 acc8= variable 0
1815 acc8ToAcc16
1816 acc16Xor constant 4660
1817 acc16Comp constant 4648
1818 brne 1822
1819 acc8= constant 153
1820 call writeLineAcc8
1821 br 1826
1822 acc16= constant 999
1823 call writeLineAcc16
1824 ;test15.j(262)     //final var word/constant byte
1825 ;test15.j(263)     if (w2 & 0x1C == 0x0014) println (154); else println (999);
1826 acc16= variable 4
1827 acc16And constant 28
1828 acc8= constant 20
1829 acc16CompareAcc8
1830 brne 1834
1831 acc8= constant 154
1832 call writeLineAcc8
1833 br 1837
1834 acc16= constant 999
1835 call writeLineAcc16
1836 ;test15.j(264)     if (w2 | 0x1C == 0x123C) println (155); else println (999);
1837 acc16= variable 4
1838 acc16Or constant 28
1839 acc16Comp constant 4668
1840 brne 1844
1841 acc8= constant 155
1842 call writeLineAcc8
1843 br 1847
1844 acc16= constant 999
1845 call writeLineAcc16
1846 ;test15.j(265)     if (w2 ^ 0x1C == 0x1228) println (156); else println (999);
1847 acc16= variable 4
1848 acc16Xor constant 28
1849 acc16Comp constant 4648
1850 brne 1854
1851 acc8= constant 156
1852 call writeLineAcc8
1853 br 1861
1854 acc16= constant 999
1855 call writeLineAcc16
1856 ;test15.j(266)   
1857 ;test15.j(267)     //final var/acc
1858 ;test15.j(268)     //*************
1859 ;test15.j(269)     //final var byte/acc byte
1860 ;test15.j(270)     if (b2 & (0x10 + 0x0C) == 0x04) println (157); else println (999);
1861 acc8= variable 1
1862 <acc8= constant 16
1863 acc8+ constant 12
1864 acc8And unstack8
1865 acc8Comp constant 4
1866 brne 1870
1867 acc8= constant 157
1868 call writeLineAcc8
1869 br 1873
1870 acc16= constant 999
1871 call writeLineAcc16
1872 ;test15.j(271)     if (b2 | (0x10 + 0x0C) == 0x1F) println (158); else println (999);
1873 acc8= variable 1
1874 <acc8= constant 16
1875 acc8+ constant 12
1876 acc8Or unstack8
1877 acc8Comp constant 31
1878 brne 1882
1879 acc8= constant 158
1880 call writeLineAcc8
1881 br 1885
1882 acc16= constant 999
1883 call writeLineAcc16
1884 ;test15.j(272)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (159); else println (999);
1885 acc8= variable 1
1886 <acc8= constant 16
1887 acc8+ constant 12
1888 acc8Xor unstack8
1889 acc8Comp constant 27
1890 brne 1894
1891 acc8= constant 159
1892 call writeLineAcc8
1893 br 1898
1894 acc16= constant 999
1895 call writeLineAcc16
1896 ;test15.j(273)     //final var word/acc word
1897 ;test15.j(274)     if (w2 & 0x0100 + 0x022C == 0x0224) println (160); else println (999);
1898 acc16= variable 4
1899 <acc16= constant 256
1900 acc16+ constant 556
1901 acc16And unstack16
1902 acc16Comp constant 548
1903 brne 1907
1904 acc8= constant 160
1905 call writeLineAcc8
1906 br 1910
1907 acc16= constant 999
1908 call writeLineAcc16
1909 ;test15.j(275)     if (w2 | 0x0100 + 0x022C == 0x133C) println (161); else println (999);
1910 acc16= variable 4
1911 <acc16= constant 256
1912 acc16+ constant 556
1913 acc16Or unstack16
1914 acc16Comp constant 4924
1915 brne 1919
1916 acc8= constant 161
1917 call writeLineAcc8
1918 br 1922
1919 acc16= constant 999
1920 call writeLineAcc16
1921 ;test15.j(276)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (162); else println (999);
1922 acc16= variable 4
1923 <acc16= constant 256
1924 acc16+ constant 556
1925 acc16Xor unstack16
1926 acc16Comp constant 4376
1927 brne 1931
1928 acc8= constant 162
1929 call writeLineAcc8
1930 br 1935
1931 acc16= constant 999
1932 call writeLineAcc16
1933 ;test15.j(277)     //final var byte/acc word
1934 ;test15.j(278)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (163); else println (999);
1935 acc8= variable 0
1936 acc16= constant 4096
1937 acc16+ constant 564
1938 acc16And acc8
1939 acc8= constant 20
1940 acc16CompareAcc8
1941 brne 1945
1942 acc8= constant 163
1943 call writeLineAcc8
1944 br 1948
1945 acc16= constant 999
1946 call writeLineAcc16
1947 ;test15.j(279)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (164); else println (999);
1948 acc8= variable 0
1949 acc16= constant 4096
1950 acc16+ constant 564
1951 acc16Or acc8
1952 acc16Comp constant 4668
1953 brne 1957
1954 acc8= constant 164
1955 call writeLineAcc8
1956 br 1960
1957 acc16= constant 999
1958 call writeLineAcc16
1959 ;test15.j(280)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (165); else println (999);
1960 acc8= variable 0
1961 acc16= constant 4096
1962 acc16+ constant 564
1963 acc16Xor acc8
1964 acc16Comp constant 4648
1965 brne 1969
1966 acc8= constant 165
1967 call writeLineAcc8
1968 br 1973
1969 acc16= constant 999
1970 call writeLineAcc16
1971 ;test15.j(281)     //final var word/acc byte
1972 ;test15.j(282)     if (w2 & 0x10 + 0x0C == 0x0014) println (166); else println (999);
1973 acc16= variable 4
1974 acc8= constant 16
1975 acc8+ constant 12
1976 acc16And acc8
1977 acc8= constant 20
1978 acc16CompareAcc8
1979 brne 1983
1980 acc8= constant 166
1981 call writeLineAcc8
1982 br 1986
1983 acc16= constant 999
1984 call writeLineAcc16
1985 ;test15.j(283)     if (w2 | 0x10 + 0x0C == 0x123C) println (167); else println (999);
1986 acc16= variable 4
1987 acc8= constant 16
1988 acc8+ constant 12
1989 acc16Or acc8
1990 acc16Comp constant 4668
1991 brne 1995
1992 acc8= constant 167
1993 call writeLineAcc8
1994 br 1998
1995 acc16= constant 999
1996 call writeLineAcc16
1997 ;test15.j(284)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (168); else println (999);
1998 acc16= variable 4
1999 acc8= constant 16
2000 acc8+ constant 12
2001 acc16Xor acc8
2002 acc16Comp constant 4648
2003 brne 2007
2004 acc8= constant 168
2005 call writeLineAcc8
2006 br 2014
2007 acc16= constant 999
2008 call writeLineAcc16
2009 ;test15.j(285)   
2010 ;test15.j(286)     //final var/var
2011 ;test15.j(287)     //*************
2012 ;test15.j(288)     //final var byte/var byte
2013 ;test15.j(289)     if (b2 & b1 == 0x04) println (169); else println (999);
2014 acc8= variable 1
2015 acc8And variable 0
2016 acc8Comp constant 4
2017 brne 2021
2018 acc8= constant 169
2019 call writeLineAcc8
2020 br 2024
2021 acc16= constant 999
2022 call writeLineAcc16
2023 ;test15.j(290)     if (b2 | b1 == 0x1F) println (170); else println (999);
2024 acc8= variable 1
2025 acc8Or variable 0
2026 acc8Comp constant 31
2027 brne 2031
2028 acc8= constant 170
2029 call writeLineAcc8
2030 br 2034
2031 acc16= constant 999
2032 call writeLineAcc16
2033 ;test15.j(291)     if (b2 ^ b1 == 0x1B) println (171); else println (999);
2034 acc8= variable 1
2035 acc8Xor variable 0
2036 acc8Comp constant 27
2037 brne 2041
2038 acc8= constant 171
2039 call writeLineAcc8
2040 br 2045
2041 acc16= constant 999
2042 call writeLineAcc16
2043 ;test15.j(292)     //final var word/var word
2044 ;test15.j(293)     if (w2 & w1 == 0x0224) println (172); else println (999);
2045 acc16= variable 4
2046 acc16And variable 2
2047 acc16Comp constant 548
2048 brne 2052
2049 acc8= constant 172
2050 call writeLineAcc8
2051 br 2055
2052 acc16= constant 999
2053 call writeLineAcc16
2054 ;test15.j(294)     if (w2 | w1 == 0x133C) println (173); else println (999);
2055 acc16= variable 4
2056 acc16Or variable 2
2057 acc16Comp constant 4924
2058 brne 2062
2059 acc8= constant 173
2060 call writeLineAcc8
2061 br 2065
2062 acc16= constant 999
2063 call writeLineAcc16
2064 ;test15.j(295)     if (w2 ^ w1 == 0x1118) println (174); else println (999);
2065 acc16= variable 4
2066 acc16Xor variable 2
2067 acc16Comp constant 4376
2068 brne 2072
2069 acc8= constant 174
2070 call writeLineAcc8
2071 br 2076
2072 acc16= constant 999
2073 call writeLineAcc16
2074 ;test15.j(296)     //final var byte/var word
2075 ;test15.j(297)     if (b1 & w2 == 0x0014) println (175); else println (999);
2076 acc8= variable 0
2077 acc8ToAcc16
2078 acc16And variable 4
2079 acc8= constant 20
2080 acc16CompareAcc8
2081 brne 2085
2082 acc8= constant 175
2083 call writeLineAcc8
2084 br 2088
2085 acc16= constant 999
2086 call writeLineAcc16
2087 ;test15.j(298)     if (b1 | w2 == 0x123C) println (176); else println (999);
2088 acc8= variable 0
2089 acc8ToAcc16
2090 acc16Or variable 4
2091 acc16Comp constant 4668
2092 brne 2096
2093 acc8= constant 176
2094 call writeLineAcc8
2095 br 2099
2096 acc16= constant 999
2097 call writeLineAcc16
2098 ;test15.j(299)     if (b1 ^ w2 == 0x1228) println (177); else println (999);
2099 acc8= variable 0
2100 acc8ToAcc16
2101 acc16Xor variable 4
2102 acc16Comp constant 4648
2103 brne 2107
2104 acc8= constant 177
2105 call writeLineAcc8
2106 br 2111
2107 acc16= constant 999
2108 call writeLineAcc16
2109 ;test15.j(300)     //final var word/var byte
2110 ;test15.j(301)     if (w2 & b1 == 0x0014) println (178); else println (999);
2111 acc16= variable 4
2112 acc16And variable 0
2113 acc8= constant 20
2114 acc16CompareAcc8
2115 brne 2119
2116 acc8= constant 178
2117 call writeLineAcc8
2118 br 2122
2119 acc16= constant 999
2120 call writeLineAcc16
2121 ;test15.j(302)     if (w2 | b1 == 0x123C) println (179); else println (999);
2122 acc16= variable 4
2123 acc16Or variable 0
2124 acc16Comp constant 4668
2125 brne 2129
2126 acc8= constant 179
2127 call writeLineAcc8
2128 br 2132
2129 acc16= constant 999
2130 call writeLineAcc16
2131 ;test15.j(303)     if (w2 ^ b1 == 0x1228) println (180); else println (999);
2132 acc16= variable 4
2133 acc16Xor variable 0
2134 acc16Comp constant 4648
2135 brne 2139
2136 acc8= constant 180
2137 call writeLineAcc8
2138 br 2146
2139 acc16= constant 999
2140 call writeLineAcc16
2141 ;test15.j(304)   
2142 ;test15.j(305)     //final var/final var
2143 ;test15.j(306)     //*******************
2144 ;test15.j(307)     //final var byte/final var byte
2145 ;test15.j(308)     if (fb2 & fb1 == 0x04) println (181); else println (999);
2146 acc8= constant 7
2147 acc8And constant 28
2148 acc8Comp constant 4
2149 brne 2153
2150 acc8= constant 181
2151 call writeLineAcc8
2152 br 2156
2153 acc16= constant 999
2154 call writeLineAcc16
2155 ;test15.j(309)     if (fb2 | fb1 == 0x1F) println (182); else println (999);
2156 acc8= constant 7
2157 acc8Or constant 28
2158 acc8Comp constant 31
2159 brne 2163
2160 acc8= constant 182
2161 call writeLineAcc8
2162 br 2166
2163 acc16= constant 999
2164 call writeLineAcc16
2165 ;test15.j(310)     if (fb2 ^ fb1 == 0x1B) println (183); else println (999);
2166 acc8= constant 7
2167 acc8Xor constant 28
2168 acc8Comp constant 27
2169 brne 2173
2170 acc8= constant 183
2171 call writeLineAcc8
2172 br 2177
2173 acc16= constant 999
2174 call writeLineAcc16
2175 ;test15.j(311)     //final var word/final var word
2176 ;test15.j(312)     if (fw2 & fw1 == 0x0224) println (184); else println (999);
2177 acc16= constant 4660
2178 acc16And constant 812
2179 acc16Comp constant 548
2180 brne 2184
2181 acc8= constant 184
2182 call writeLineAcc8
2183 br 2187
2184 acc16= constant 999
2185 call writeLineAcc16
2186 ;test15.j(313)     if (fw2 | fw1 == 0x133C) println (185); else println (999);
2187 acc16= constant 4660
2188 acc16Or constant 812
2189 acc16Comp constant 4924
2190 brne 2194
2191 acc8= constant 185
2192 call writeLineAcc8
2193 br 2197
2194 acc16= constant 999
2195 call writeLineAcc16
2196 ;test15.j(314)     if (fw2 ^ fw1 == 0x1118) println (186); else println (999);
2197 acc16= constant 4660
2198 acc16Xor constant 812
2199 acc16Comp constant 4376
2200 brne 2204
2201 acc8= constant 186
2202 call writeLineAcc8
2203 br 2208
2204 acc16= constant 999
2205 call writeLineAcc16
2206 ;test15.j(315)     //final var byte/final var word
2207 ;test15.j(316)     if (fb1 & fw2 == 0x0014) println (187); else println (999);
2208 acc8= constant 28
2209 acc8ToAcc16
2210 acc16And constant 4660
2211 acc8= constant 20
2212 acc16CompareAcc8
2213 brne 2217
2214 acc8= constant 187
2215 call writeLineAcc8
2216 br 2220
2217 acc16= constant 999
2218 call writeLineAcc16
2219 ;test15.j(317)     if (fb1 | fw2 == 0x123C) println (188); else println (999);
2220 acc8= constant 28
2221 acc8ToAcc16
2222 acc16Or constant 4660
2223 acc16Comp constant 4668
2224 brne 2228
2225 acc8= constant 188
2226 call writeLineAcc8
2227 br 2231
2228 acc16= constant 999
2229 call writeLineAcc16
2230 ;test15.j(318)     if (fb1 ^ fw2 == 0x1228) println (189); else println (999);
2231 acc8= constant 28
2232 acc8ToAcc16
2233 acc16Xor constant 4660
2234 acc16Comp constant 4648
2235 brne 2239
2236 acc8= constant 189
2237 call writeLineAcc8
2238 br 2243
2239 acc16= constant 999
2240 call writeLineAcc16
2241 ;test15.j(319)     //final var word/final var byte
2242 ;test15.j(320)     if (fw2 & fb1 == 0x0014) println (190); else println (999);
2243 acc16= constant 4660
2244 acc16And constant 28
2245 acc8= constant 20
2246 acc16CompareAcc8
2247 brne 2251
2248 acc8= constant 190
2249 call writeLineAcc8
2250 br 2254
2251 acc16= constant 999
2252 call writeLineAcc16
2253 ;test15.j(321)     if (fw2 | fb1 == 0x123C) println (191); else println (999);
2254 acc16= constant 4660
2255 acc16Or constant 28
2256 acc16Comp constant 4668
2257 brne 2261
2258 acc8= constant 191
2259 call writeLineAcc8
2260 br 2264
2261 acc16= constant 999
2262 call writeLineAcc16
2263 ;test15.j(322)     if (fw2 ^ fb1 == 0x1228) println (192); else println (999);
2264 acc16= constant 4660
2265 acc16Xor constant 28
2266 acc16Comp constant 4648
2267 brne 2271
2268 acc8= constant 192
2269 call writeLineAcc8
2270 br 2275
2271 acc16= constant 999
2272 call writeLineAcc16
2273 ;test15.j(323)   
2274 ;test15.j(324)     println("Klaar");
2275 acc16= constant 2280
2276 writeLineString
2277 ;test15.j(325)   }
2278 ;test15.j(326) }
2279 stop
2280 stringConstant 0 = "Klaar"
