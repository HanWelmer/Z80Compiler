   0 ;test15.j(0) /* Program to test bitwise operators and, or and xor. */
   1 ;test15.j(1) class TestBitwiseOperators {
   2 class TestBitwiseOperators []
   3 ;test15.j(2)   private static byte b1 = 0x1C;
   4 acc8= constant 28
   5 acc8=> variable 0
   6 ;test15.j(3)   private static byte b2 = 0x07;
   7 acc8= constant 7
   8 acc8=> variable 1
   9 ;test15.j(4)   private static word w1 = 0x032C;
  10 acc16= constant 812
  11 acc16=> variable 2
  12 ;test15.j(5)   private static word w2 = 0x1234;
  13 acc16= constant 4660
  14 acc16=> variable 4
  15 ;test15.j(6)   private static final byte fb1 = 0x1C;
  16 ;test15.j(7)   private static final byte fb2 = 0x07;
  17 ;test15.j(8)   private static final word fw1 = 0x032C;
  18 ;test15.j(9)   private static final word fw2 = 0x1234;
  19 ;test15.j(10) 
  20 ;test15.j(11)   public static void main() {
  21 method main [public, static] void
  22 ;test15.j(12)     println(0);
  23 acc8= constant 0
  24 call writeLineAcc8
  25 ;test15.j(13)     
  26 ;test15.j(14)     // Possible operand types: constant, acc, var, final var, stack8, stack16.
  27 ;test15.j(15)     // Possible data types: byte, word.
  28 ;test15.j(16)   
  29 ;test15.j(17)     //constant/constant
  30 ;test15.j(18)     //*****************
  31 ;test15.j(19)     //constant byte/constant byte
  32 ;test15.j(20)     if (0x07 & 0x1C == 0x04) println (1); else println (999); //0000.0111 & 0001.1100 = 0000.0100
  33 acc8= constant 7
  34 acc8And constant 28
  35 acc8Comp constant 4
  36 brne 40
  37 acc8= constant 1
  38 call writeLineAcc8
  39 br 43
  40 acc16= constant 999
  41 call writeLineAcc16
  42 ;test15.j(21)     if (0x07 | 0x1C == 0x1F) println (2); else println (999); //0000.0111 | 0001.1100 = 0001.1111
  43 acc8= constant 7
  44 acc8Or constant 28
  45 acc8Comp constant 31
  46 brne 50
  47 acc8= constant 2
  48 call writeLineAcc8
  49 br 53
  50 acc16= constant 999
  51 call writeLineAcc16
  52 ;test15.j(22)     if (0x07 ^ 0x1C == 0x1B) println (3); else println (999); //0000.0111 ^ 0001.1100 = 0001.1011
  53 acc8= constant 7
  54 acc8Xor constant 28
  55 acc8Comp constant 27
  56 brne 60
  57 acc8= constant 3
  58 call writeLineAcc8
  59 br 64
  60 acc16= constant 999
  61 call writeLineAcc16
  62 ;test15.j(23)     //constant word/constant word
  63 ;test15.j(24)     if (0x1234 & 0x032C == 0x0224) println (4); else println (999);
  64 acc16= constant 4660
  65 acc16And constant 812
  66 acc16Comp constant 548
  67 brne 71
  68 acc8= constant 4
  69 call writeLineAcc8
  70 br 75
  71 acc16= constant 999
  72 call writeLineAcc16
  73 ;test15.j(25)     //0001.0010.0011.0100 & 0000.0011.0010.1100 = 0000.0010.0010.0100
  74 ;test15.j(26)     if (0x1234 | 0x032C == 0x133C) println (5); else println (999);
  75 acc16= constant 4660
  76 acc16Or constant 812
  77 acc16Comp constant 4924
  78 brne 82
  79 acc8= constant 5
  80 call writeLineAcc8
  81 br 86
  82 acc16= constant 999
  83 call writeLineAcc16
  84 ;test15.j(27)     //0001.0010.0011.0100 | 0000.0011.0010.1100 = 0001.0011.0011.1100
  85 ;test15.j(28)     if (0x1234 ^ 0x032C == 0x1118) println (6); else println (999);
  86 acc16= constant 4660
  87 acc16Xor constant 812
  88 acc16Comp constant 4376
  89 brne 93
  90 acc8= constant 6
  91 call writeLineAcc8
  92 br 98
  93 acc16= constant 999
  94 call writeLineAcc16
  95 ;test15.j(29)     //0001.0010.0011.0100 ^ 0000.0011.0010.1100 = 0001.0001.0001.1000
  96 ;test15.j(30)     //constant byte/constant word
  97 ;test15.j(31)     if (0x1C & 0x1234 == 0x0014) println (7); else println (999); //0001.1100 & 0001.0010.0011.0100 = 0000.0000.0001.0100
  98 acc8= constant 28
  99 acc8ToAcc16
 100 acc16And constant 4660
 101 acc8= constant 20
 102 acc16CompareAcc8
 103 brne 107
 104 acc8= constant 7
 105 call writeLineAcc8
 106 br 110
 107 acc16= constant 999
 108 call writeLineAcc16
 109 ;test15.j(32)     if (0x1C | 0x1234 == 0x123C) println (8); else println (999); //0001.1100 | 0001.0010.0011.0100 = 0001.0010.0011.1100
 110 acc8= constant 28
 111 acc8ToAcc16
 112 acc16Or constant 4660
 113 acc16Comp constant 4668
 114 brne 118
 115 acc8= constant 8
 116 call writeLineAcc8
 117 br 121
 118 acc16= constant 999
 119 call writeLineAcc16
 120 ;test15.j(33)     if (0x1C ^ 0x1234 == 0x1228) println (9); else println (999); //0001.1100 ^ 0001.0010.0011.0100 = 0001.0010.0010.1000
 121 acc8= constant 28
 122 acc8ToAcc16
 123 acc16Xor constant 4660
 124 acc16Comp constant 4648
 125 brne 129
 126 acc8= constant 9
 127 call writeLineAcc8
 128 br 133
 129 acc16= constant 999
 130 call writeLineAcc16
 131 ;test15.j(34)     //constant word/constant byte
 132 ;test15.j(35)     if (0x1234 & 0x1C == 0x0014) println (10); else println (999); //0001.0010.0011.0100 & 0001.1100 = 0000.0000.0001.0100
 133 acc16= constant 4660
 134 acc16And constant 28
 135 acc8= constant 20
 136 acc16CompareAcc8
 137 brne 141
 138 acc8= constant 10
 139 call writeLineAcc8
 140 br 144
 141 acc16= constant 999
 142 call writeLineAcc16
 143 ;test15.j(36)     if (0x1234 | 0x1C == 0x123C) println (11); else println (999); //0001.0010.0011.0100 | 0001.1100 = 0001.0010.0011.1100
 144 acc16= constant 4660
 145 acc16Or constant 28
 146 acc16Comp constant 4668
 147 brne 151
 148 acc8= constant 11
 149 call writeLineAcc8
 150 br 154
 151 acc16= constant 999
 152 call writeLineAcc16
 153 ;test15.j(37)     if (0x1234 ^ 0x1C == 0x1228) println (12); else println (999); //0001.0010.0011.0100 ^ 0001.1100 = 0001.0010.0010.1000
 154 acc16= constant 4660
 155 acc16Xor constant 28
 156 acc16Comp constant 4648
 157 brne 161
 158 acc8= constant 12
 159 call writeLineAcc8
 160 br 168
 161 acc16= constant 999
 162 call writeLineAcc16
 163 ;test15.j(38)   
 164 ;test15.j(39)     //constant/acc
 165 ;test15.j(40)     //************
 166 ;test15.j(41)     //constant byte/acc byte
 167 ;test15.j(42)     if (0x07 & (0x10 + 0x0C) == 0x04) println (13); else println (999);
 168 acc8= constant 7
 169 <acc8= constant 16
 170 acc8+ constant 12
 171 acc8And unstack8
 172 acc8Comp constant 4
 173 brne 177
 174 acc8= constant 13
 175 call writeLineAcc8
 176 br 180
 177 acc16= constant 999
 178 call writeLineAcc16
 179 ;test15.j(43)     if (0x07 | (0x10 + 0x0C) == 0x1F) println (14); else println (999);
 180 acc8= constant 7
 181 <acc8= constant 16
 182 acc8+ constant 12
 183 acc8Or unstack8
 184 acc8Comp constant 31
 185 brne 189
 186 acc8= constant 14
 187 call writeLineAcc8
 188 br 192
 189 acc16= constant 999
 190 call writeLineAcc16
 191 ;test15.j(44)     if (0x07 ^ (0x10 + 0x0C) == 0x1B) println (15); else println (999);
 192 acc8= constant 7
 193 <acc8= constant 16
 194 acc8+ constant 12
 195 acc8Xor unstack8
 196 acc8Comp constant 27
 197 brne 201
 198 acc8= constant 15
 199 call writeLineAcc8
 200 br 205
 201 acc16= constant 999
 202 call writeLineAcc16
 203 ;test15.j(45)     //constant word/acc word
 204 ;test15.j(46)     if (0x1234 & 0x0100 + 0x022C == 0x0224) println (16); else println (999);
 205 acc16= constant 4660
 206 <acc16= constant 256
 207 acc16+ constant 556
 208 acc16And unstack16
 209 acc16Comp constant 548
 210 brne 214
 211 acc8= constant 16
 212 call writeLineAcc8
 213 br 217
 214 acc16= constant 999
 215 call writeLineAcc16
 216 ;test15.j(47)     if (0x1234 | 0x0100 + 0x022C == 0x133C) println (17); else println (999);
 217 acc16= constant 4660
 218 <acc16= constant 256
 219 acc16+ constant 556
 220 acc16Or unstack16
 221 acc16Comp constant 4924
 222 brne 226
 223 acc8= constant 17
 224 call writeLineAcc8
 225 br 229
 226 acc16= constant 999
 227 call writeLineAcc16
 228 ;test15.j(48)     if (0x1234 ^ 0x0100 + 0x022C == 0x1118) println (18); else println (999);
 229 acc16= constant 4660
 230 <acc16= constant 256
 231 acc16+ constant 556
 232 acc16Xor unstack16
 233 acc16Comp constant 4376
 234 brne 238
 235 acc8= constant 18
 236 call writeLineAcc8
 237 br 242
 238 acc16= constant 999
 239 call writeLineAcc16
 240 ;test15.j(49)     //constant byte/acc word
 241 ;test15.j(50)     if (0x1C & 0x1000 + 0x0234 == 0x0014) println (19); else println (999);
 242 acc8= constant 28
 243 acc16= constant 4096
 244 acc16+ constant 564
 245 acc16And acc8
 246 acc8= constant 20
 247 acc16CompareAcc8
 248 brne 252
 249 acc8= constant 19
 250 call writeLineAcc8
 251 br 255
 252 acc16= constant 999
 253 call writeLineAcc16
 254 ;test15.j(51)     if (0x1C | 0x1000 + 0x0234 == 0x123C) println (20); else println (999);
 255 acc8= constant 28
 256 acc16= constant 4096
 257 acc16+ constant 564
 258 acc16Or acc8
 259 acc16Comp constant 4668
 260 brne 264
 261 acc8= constant 20
 262 call writeLineAcc8
 263 br 267
 264 acc16= constant 999
 265 call writeLineAcc16
 266 ;test15.j(52)     if (0x1C ^ 0x1000 + 0x0234 == 0x1228) println (21); else println (999);
 267 acc8= constant 28
 268 acc16= constant 4096
 269 acc16+ constant 564
 270 acc16Xor acc8
 271 acc16Comp constant 4648
 272 brne 276
 273 acc8= constant 21
 274 call writeLineAcc8
 275 br 280
 276 acc16= constant 999
 277 call writeLineAcc16
 278 ;test15.j(53)     //constant word/acc byte
 279 ;test15.j(54)     if (0x1234 & 0x10 + 0x0C == 0x0014) println (22); else println (999);
 280 acc16= constant 4660
 281 acc8= constant 16
 282 acc8+ constant 12
 283 acc16And acc8
 284 acc8= constant 20
 285 acc16CompareAcc8
 286 brne 290
 287 acc8= constant 22
 288 call writeLineAcc8
 289 br 293
 290 acc16= constant 999
 291 call writeLineAcc16
 292 ;test15.j(55)     if (0x1234 | 0x10 + 0x0C == 0x123C) println (23); else println (999);
 293 acc16= constant 4660
 294 acc8= constant 16
 295 acc8+ constant 12
 296 acc16Or acc8
 297 acc16Comp constant 4668
 298 brne 302
 299 acc8= constant 23
 300 call writeLineAcc8
 301 br 305
 302 acc16= constant 999
 303 call writeLineAcc16
 304 ;test15.j(56)     if (0x1234 ^ 0x10 + 0x0C == 0x1228) println (24); else println (999);
 305 acc16= constant 4660
 306 acc8= constant 16
 307 acc8+ constant 12
 308 acc16Xor acc8
 309 acc16Comp constant 4648
 310 brne 314
 311 acc8= constant 24
 312 call writeLineAcc8
 313 br 321
 314 acc16= constant 999
 315 call writeLineAcc16
 316 ;test15.j(57)   
 317 ;test15.j(58)     //constant/var
 318 ;test15.j(59)     //*****************
 319 ;test15.j(60)     //constant byte/var byte
 320 ;test15.j(61)     if (0x07 & b1 == 0x04) println (25); else println (999);
 321 acc8= constant 7
 322 acc8And variable 0
 323 acc8Comp constant 4
 324 brne 328
 325 acc8= constant 25
 326 call writeLineAcc8
 327 br 331
 328 acc16= constant 999
 329 call writeLineAcc16
 330 ;test15.j(62)     if (0x07 | b1 == 0x1F) println (26); else println (999);
 331 acc8= constant 7
 332 acc8Or variable 0
 333 acc8Comp constant 31
 334 brne 338
 335 acc8= constant 26
 336 call writeLineAcc8
 337 br 341
 338 acc16= constant 999
 339 call writeLineAcc16
 340 ;test15.j(63)     if (0x07 ^ b1 == 0x1B) println (27); else println (999);
 341 acc8= constant 7
 342 acc8Xor variable 0
 343 acc8Comp constant 27
 344 brne 348
 345 acc8= constant 27
 346 call writeLineAcc8
 347 br 352
 348 acc16= constant 999
 349 call writeLineAcc16
 350 ;test15.j(64)     //constant word/var word
 351 ;test15.j(65)     if (0x1234 & w1 == 0x0224) println (28); else println (999);
 352 acc16= constant 4660
 353 acc16And variable 2
 354 acc16Comp constant 548
 355 brne 359
 356 acc8= constant 28
 357 call writeLineAcc8
 358 br 362
 359 acc16= constant 999
 360 call writeLineAcc16
 361 ;test15.j(66)     if (0x1234 | w1 == 0x133C) println (29); else println (999);
 362 acc16= constant 4660
 363 acc16Or variable 2
 364 acc16Comp constant 4924
 365 brne 369
 366 acc8= constant 29
 367 call writeLineAcc8
 368 br 372
 369 acc16= constant 999
 370 call writeLineAcc16
 371 ;test15.j(67)     if (0x1234 ^ w1 == 0x1118) println (30); else println (999);
 372 acc16= constant 4660
 373 acc16Xor variable 2
 374 acc16Comp constant 4376
 375 brne 379
 376 acc8= constant 30
 377 call writeLineAcc8
 378 br 383
 379 acc16= constant 999
 380 call writeLineAcc16
 381 ;test15.j(68)     //constant byte/var word
 382 ;test15.j(69)     if (0x1C & w2 == 0x0014) println (31); else println (999);
 383 acc8= constant 28
 384 acc8ToAcc16
 385 acc16And variable 4
 386 acc8= constant 20
 387 acc16CompareAcc8
 388 brne 392
 389 acc8= constant 31
 390 call writeLineAcc8
 391 br 395
 392 acc16= constant 999
 393 call writeLineAcc16
 394 ;test15.j(70)     if (0x1C | w2 == 0x123C) println (32); else println (999);
 395 acc8= constant 28
 396 acc8ToAcc16
 397 acc16Or variable 4
 398 acc16Comp constant 4668
 399 brne 403
 400 acc8= constant 32
 401 call writeLineAcc8
 402 br 406
 403 acc16= constant 999
 404 call writeLineAcc16
 405 ;test15.j(71)     if (0x1C ^ w2 == 0x1228) println (33); else println (999);
 406 acc8= constant 28
 407 acc8ToAcc16
 408 acc16Xor variable 4
 409 acc16Comp constant 4648
 410 brne 414
 411 acc8= constant 33
 412 call writeLineAcc8
 413 br 418
 414 acc16= constant 999
 415 call writeLineAcc16
 416 ;test15.j(72)     //constant word/var byte
 417 ;test15.j(73)     if (0x1234 & b1 == 0x0014) println (34); else println (999);
 418 acc16= constant 4660
 419 acc16And variable 0
 420 acc8= constant 20
 421 acc16CompareAcc8
 422 brne 426
 423 acc8= constant 34
 424 call writeLineAcc8
 425 br 429
 426 acc16= constant 999
 427 call writeLineAcc16
 428 ;test15.j(74)     if (0x1234 | b1 == 0x123C) println (35); else println (999);
 429 acc16= constant 4660
 430 acc16Or variable 0
 431 acc16Comp constant 4668
 432 brne 436
 433 acc8= constant 35
 434 call writeLineAcc8
 435 br 439
 436 acc16= constant 999
 437 call writeLineAcc16
 438 ;test15.j(75)     if (0x1234 ^ b1 == 0x1228) println (36); else println (999);
 439 acc16= constant 4660
 440 acc16Xor variable 0
 441 acc16Comp constant 4648
 442 brne 446
 443 acc8= constant 36
 444 call writeLineAcc8
 445 br 453
 446 acc16= constant 999
 447 call writeLineAcc16
 448 ;test15.j(76)   
 449 ;test15.j(77)     //constant/final var
 450 ;test15.j(78)     //*****************
 451 ;test15.j(79)     //constant byte/final var byte
 452 ;test15.j(80)     if (0x07 & fb1 == 0x04) println (37); else println (999);
 453 acc8= constant 7
 454 acc8And constant 28
 455 acc8Comp constant 4
 456 brne 460
 457 acc8= constant 37
 458 call writeLineAcc8
 459 br 463
 460 acc16= constant 999
 461 call writeLineAcc16
 462 ;test15.j(81)     if (0x07 | fb1 == 0x1F) println (38); else println (999);
 463 acc8= constant 7
 464 acc8Or constant 28
 465 acc8Comp constant 31
 466 brne 470
 467 acc8= constant 38
 468 call writeLineAcc8
 469 br 473
 470 acc16= constant 999
 471 call writeLineAcc16
 472 ;test15.j(82)     if (0x07 ^ fb1 == 0x1B) println (39); else println (999);
 473 acc8= constant 7
 474 acc8Xor constant 28
 475 acc8Comp constant 27
 476 brne 480
 477 acc8= constant 39
 478 call writeLineAcc8
 479 br 484
 480 acc16= constant 999
 481 call writeLineAcc16
 482 ;test15.j(83)     //constant word/final var word
 483 ;test15.j(84)     if (0x1234 & fw1 == 0x0224) println (40); else println (999);
 484 acc16= constant 4660
 485 acc16And constant 812
 486 acc16Comp constant 548
 487 brne 491
 488 acc8= constant 40
 489 call writeLineAcc8
 490 br 494
 491 acc16= constant 999
 492 call writeLineAcc16
 493 ;test15.j(85)     if (0x1234 | fw1 == 0x133C) println (41); else println (999);
 494 acc16= constant 4660
 495 acc16Or constant 812
 496 acc16Comp constant 4924
 497 brne 501
 498 acc8= constant 41
 499 call writeLineAcc8
 500 br 504
 501 acc16= constant 999
 502 call writeLineAcc16
 503 ;test15.j(86)     if (0x1234 ^ fw1 == 0x1118) println (42); else println (999);
 504 acc16= constant 4660
 505 acc16Xor constant 812
 506 acc16Comp constant 4376
 507 brne 511
 508 acc8= constant 42
 509 call writeLineAcc8
 510 br 515
 511 acc16= constant 999
 512 call writeLineAcc16
 513 ;test15.j(87)     //constant byte/final var word
 514 ;test15.j(88)     if (0x1C & fw2 == 0x0014) println (43); else println (999);
 515 acc8= constant 28
 516 acc8ToAcc16
 517 acc16And constant 4660
 518 acc8= constant 20
 519 acc16CompareAcc8
 520 brne 524
 521 acc8= constant 43
 522 call writeLineAcc8
 523 br 527
 524 acc16= constant 999
 525 call writeLineAcc16
 526 ;test15.j(89)     if (0x1C | fw2 == 0x123C) println (44); else println (999);
 527 acc8= constant 28
 528 acc8ToAcc16
 529 acc16Or constant 4660
 530 acc16Comp constant 4668
 531 brne 535
 532 acc8= constant 44
 533 call writeLineAcc8
 534 br 538
 535 acc16= constant 999
 536 call writeLineAcc16
 537 ;test15.j(90)     if (0x1C ^ fw2 == 0x1228) println (45); else println (999);
 538 acc8= constant 28
 539 acc8ToAcc16
 540 acc16Xor constant 4660
 541 acc16Comp constant 4648
 542 brne 546
 543 acc8= constant 45
 544 call writeLineAcc8
 545 br 550
 546 acc16= constant 999
 547 call writeLineAcc16
 548 ;test15.j(91)     //constant word/final var byte
 549 ;test15.j(92)     if (0x1234 & fb1 == 0x0014) println (46); else println (999);
 550 acc16= constant 4660
 551 acc16And constant 28
 552 acc8= constant 20
 553 acc16CompareAcc8
 554 brne 558
 555 acc8= constant 46
 556 call writeLineAcc8
 557 br 561
 558 acc16= constant 999
 559 call writeLineAcc16
 560 ;test15.j(93)     if (0x1234 | fb1 == 0x123C) println (47); else println (999);
 561 acc16= constant 4660
 562 acc16Or constant 28
 563 acc16Comp constant 4668
 564 brne 568
 565 acc8= constant 47
 566 call writeLineAcc8
 567 br 571
 568 acc16= constant 999
 569 call writeLineAcc16
 570 ;test15.j(94)     if (0x1234 ^ fb1 == 0x1228) println (48); else println (999);
 571 acc16= constant 4660
 572 acc16Xor constant 28
 573 acc16Comp constant 4648
 574 brne 578
 575 acc8= constant 48
 576 call writeLineAcc8
 577 br 585
 578 acc16= constant 999
 579 call writeLineAcc16
 580 ;test15.j(95)   
 581 ;test15.j(96)     //acc/constant
 582 ;test15.j(97)     //************
 583 ;test15.j(98)     //acc byte/constant byte
 584 ;test15.j(99)     if ((0x04 + 0x03) & 0x1C == 0x04) println (49); else println (999);
 585 acc8= constant 4
 586 acc8+ constant 3
 587 acc8And constant 28
 588 acc8Comp constant 4
 589 brne 593
 590 acc8= constant 49
 591 call writeLineAcc8
 592 br 596
 593 acc16= constant 999
 594 call writeLineAcc16
 595 ;test15.j(100)     if ((0x04 + 0x03) | 0x1C == 0x1F) println (50); else println (999);
 596 acc8= constant 4
 597 acc8+ constant 3
 598 acc8Or constant 28
 599 acc8Comp constant 31
 600 brne 604
 601 acc8= constant 50
 602 call writeLineAcc8
 603 br 607
 604 acc16= constant 999
 605 call writeLineAcc16
 606 ;test15.j(101)     if ((0x04 + 0x03) ^ 0x1C == 0x1B) println (51); else println (999);
 607 acc8= constant 4
 608 acc8+ constant 3
 609 acc8Xor constant 28
 610 acc8Comp constant 27
 611 brne 615
 612 acc8= constant 51
 613 call writeLineAcc8
 614 br 619
 615 acc16= constant 999
 616 call writeLineAcc16
 617 ;test15.j(102)     //acc word/constant word
 618 ;test15.j(103)     if (0x1000 + 0x0234 & 0x032C == 0x0224) println (52); else println (999);
 619 acc16= constant 4096
 620 acc16+ constant 564
 621 acc16And constant 812
 622 acc16Comp constant 548
 623 brne 627
 624 acc8= constant 52
 625 call writeLineAcc8
 626 br 630
 627 acc16= constant 999
 628 call writeLineAcc16
 629 ;test15.j(104)     if (0x1000 + 0x0234 | 0x032C == 0x133C) println (53); else println (999);
 630 acc16= constant 4096
 631 acc16+ constant 564
 632 acc16Or constant 812
 633 acc16Comp constant 4924
 634 brne 638
 635 acc8= constant 53
 636 call writeLineAcc8
 637 br 641
 638 acc16= constant 999
 639 call writeLineAcc16
 640 ;test15.j(105)     if (0x1000 + 0x0234 ^ 0x032C == 0x1118) println (54); else println (999);
 641 acc16= constant 4096
 642 acc16+ constant 564
 643 acc16Xor constant 812
 644 acc16Comp constant 4376
 645 brne 649
 646 acc8= constant 54
 647 call writeLineAcc8
 648 br 653
 649 acc16= constant 999
 650 call writeLineAcc16
 651 ;test15.j(106)     //acc byte/constant word
 652 ;test15.j(107)     if (0x10 + 0x0C & 0x1234 == 0x0014) println (55); else println (999);
 653 acc8= constant 16
 654 acc8+ constant 12
 655 acc8ToAcc16
 656 acc16And constant 4660
 657 acc8= constant 20
 658 acc16CompareAcc8
 659 brne 663
 660 acc8= constant 55
 661 call writeLineAcc8
 662 br 666
 663 acc16= constant 999
 664 call writeLineAcc16
 665 ;test15.j(108)     if (0x10 + 0x0C | 0x1234 == 0x123C) println (56); else println (999);
 666 acc8= constant 16
 667 acc8+ constant 12
 668 acc8ToAcc16
 669 acc16Or constant 4660
 670 acc16Comp constant 4668
 671 brne 675
 672 acc8= constant 56
 673 call writeLineAcc8
 674 br 678
 675 acc16= constant 999
 676 call writeLineAcc16
 677 ;test15.j(109)     if (0x10 + 0x0C ^ 0x1234 == 0x1228) println (57); else println (999);
 678 acc8= constant 16
 679 acc8+ constant 12
 680 acc8ToAcc16
 681 acc16Xor constant 4660
 682 acc16Comp constant 4648
 683 brne 687
 684 acc8= constant 57
 685 call writeLineAcc8
 686 br 691
 687 acc16= constant 999
 688 call writeLineAcc16
 689 ;test15.j(110)     //acc word/constant byte
 690 ;test15.j(111)     if (0x1000 + 0x0234 & 0x1C == 0x0014) println (58); else println (999);
 691 acc16= constant 4096
 692 acc16+ constant 564
 693 acc16And constant 28
 694 acc8= constant 20
 695 acc16CompareAcc8
 696 brne 700
 697 acc8= constant 58
 698 call writeLineAcc8
 699 br 703
 700 acc16= constant 999
 701 call writeLineAcc16
 702 ;test15.j(112)     if (0x1000 + 0x0234 | 0x1C == 0x123C) println (59); else println (999);
 703 acc16= constant 4096
 704 acc16+ constant 564
 705 acc16Or constant 28
 706 acc16Comp constant 4668
 707 brne 711
 708 acc8= constant 59
 709 call writeLineAcc8
 710 br 714
 711 acc16= constant 999
 712 call writeLineAcc16
 713 ;test15.j(113)     if (0x1000 + 0x0234 ^ 0x1C == 0x1228) println (60); else println (999);
 714 acc16= constant 4096
 715 acc16+ constant 564
 716 acc16Xor constant 28
 717 acc16Comp constant 4648
 718 brne 722
 719 acc8= constant 60
 720 call writeLineAcc8
 721 br 729
 722 acc16= constant 999
 723 call writeLineAcc16
 724 ;test15.j(114)   
 725 ;test15.j(115)     //acc/acc
 726 ;test15.j(116)     //*******
 727 ;test15.j(117)     //acc byte/acc byte
 728 ;test15.j(118)     if (0x04 + 0x03 & 0x10 + 0x0C == 0x04) println (61); else println (999);
 729 acc8= constant 4
 730 acc8+ constant 3
 731 <acc8= constant 16
 732 acc8+ constant 12
 733 acc8And unstack8
 734 acc8Comp constant 4
 735 brne 739
 736 acc8= constant 61
 737 call writeLineAcc8
 738 br 742
 739 acc16= constant 999
 740 call writeLineAcc16
 741 ;test15.j(119)     if (0x04 + 0x03 | 0x10 + 0x0C == 0x1F) println (62); else println (999);
 742 acc8= constant 4
 743 acc8+ constant 3
 744 <acc8= constant 16
 745 acc8+ constant 12
 746 acc8Or unstack8
 747 acc8Comp constant 31
 748 brne 752
 749 acc8= constant 62
 750 call writeLineAcc8
 751 br 755
 752 acc16= constant 999
 753 call writeLineAcc16
 754 ;test15.j(120)     if (0x04 + 0x03 ^ 0x10 + 0x0C == 0x1B) println (63); else println (999);
 755 acc8= constant 4
 756 acc8+ constant 3
 757 <acc8= constant 16
 758 acc8+ constant 12
 759 acc8Xor unstack8
 760 acc8Comp constant 27
 761 brne 765
 762 acc8= constant 63
 763 call writeLineAcc8
 764 br 769
 765 acc16= constant 999
 766 call writeLineAcc16
 767 ;test15.j(121)     //acc word/acc word
 768 ;test15.j(122)     if (0x1000 + 0x0234 & 0x0100 + 0x022C == 0x0224) println (64); else println (999);
 769 acc16= constant 4096
 770 acc16+ constant 564
 771 <acc16= constant 256
 772 acc16+ constant 556
 773 acc16And unstack16
 774 acc16Comp constant 548
 775 brne 779
 776 acc8= constant 64
 777 call writeLineAcc8
 778 br 782
 779 acc16= constant 999
 780 call writeLineAcc16
 781 ;test15.j(123)     if (0x1000 + 0x0234 | 0x0100 + 0x022C == 0x133C) println (65); else println (999);
 782 acc16= constant 4096
 783 acc16+ constant 564
 784 <acc16= constant 256
 785 acc16+ constant 556
 786 acc16Or unstack16
 787 acc16Comp constant 4924
 788 brne 792
 789 acc8= constant 65
 790 call writeLineAcc8
 791 br 795
 792 acc16= constant 999
 793 call writeLineAcc16
 794 ;test15.j(124)     if (0x1000 + 0x0234 ^ 0x0100 + 0x022C == 0x1118) println (66); else println (999);
 795 acc16= constant 4096
 796 acc16+ constant 564
 797 <acc16= constant 256
 798 acc16+ constant 556
 799 acc16Xor unstack16
 800 acc16Comp constant 4376
 801 brne 805
 802 acc8= constant 66
 803 call writeLineAcc8
 804 br 809
 805 acc16= constant 999
 806 call writeLineAcc16
 807 ;test15.j(125)     //acc byte/acc word
 808 ;test15.j(126)     if (0x10 + 0x0C & 0x1000 + 0x0234 == 0x0014) println (67); else println (999);
 809 acc8= constant 16
 810 acc8+ constant 12
 811 acc16= constant 4096
 812 acc16+ constant 564
 813 acc16And acc8
 814 acc8= constant 20
 815 acc16CompareAcc8
 816 brne 820
 817 acc8= constant 67
 818 call writeLineAcc8
 819 br 823
 820 acc16= constant 999
 821 call writeLineAcc16
 822 ;test15.j(127)     if (0x10 + 0x0C | 0x1000 + 0x0234 == 0x123C) println (68); else println (999);
 823 acc8= constant 16
 824 acc8+ constant 12
 825 acc16= constant 4096
 826 acc16+ constant 564
 827 acc16Or acc8
 828 acc16Comp constant 4668
 829 brne 833
 830 acc8= constant 68
 831 call writeLineAcc8
 832 br 836
 833 acc16= constant 999
 834 call writeLineAcc16
 835 ;test15.j(128)     if (0x10 + 0x0C ^ 0x1000 + 0x0234 == 0x1228) println (69); else println (999);
 836 acc8= constant 16
 837 acc8+ constant 12
 838 acc16= constant 4096
 839 acc16+ constant 564
 840 acc16Xor acc8
 841 acc16Comp constant 4648
 842 brne 846
 843 acc8= constant 69
 844 call writeLineAcc8
 845 br 850
 846 acc16= constant 999
 847 call writeLineAcc16
 848 ;test15.j(129)     //acc word/acc byte
 849 ;test15.j(130)     if (0x1000 + 0x0234 & 0x10 + 0x0C == 0x0014) println (70); else println (999);
 850 acc16= constant 4096
 851 acc16+ constant 564
 852 acc8= constant 16
 853 acc8+ constant 12
 854 acc16And acc8
 855 acc8= constant 20
 856 acc16CompareAcc8
 857 brne 861
 858 acc8= constant 70
 859 call writeLineAcc8
 860 br 864
 861 acc16= constant 999
 862 call writeLineAcc16
 863 ;test15.j(131)     if (0x1000 + 0x0234 | 0x10 + 0x0C == 0x123C) println (71); else println (999);
 864 acc16= constant 4096
 865 acc16+ constant 564
 866 acc8= constant 16
 867 acc8+ constant 12
 868 acc16Or acc8
 869 acc16Comp constant 4668
 870 brne 874
 871 acc8= constant 71
 872 call writeLineAcc8
 873 br 877
 874 acc16= constant 999
 875 call writeLineAcc16
 876 ;test15.j(132)     if (0x1000 + 0x0234 ^ 0x10 + 0x0C == 0x1228) println (72); else println (999);
 877 acc16= constant 4096
 878 acc16+ constant 564
 879 acc8= constant 16
 880 acc8+ constant 12
 881 acc16Xor acc8
 882 acc16Comp constant 4648
 883 brne 887
 884 acc8= constant 72
 885 call writeLineAcc8
 886 br 894
 887 acc16= constant 999
 888 call writeLineAcc16
 889 ;test15.j(133)   
 890 ;test15.j(134)     //acc/var
 891 ;test15.j(135)     //*******
 892 ;test15.j(136)     //acc byte/var byte
 893 ;test15.j(137)     if (0x04 + 0x03 & b1 == 0x04) println (73); else println (999);
 894 acc8= constant 4
 895 acc8+ constant 3
 896 acc8And variable 0
 897 acc8Comp constant 4
 898 brne 902
 899 acc8= constant 73
 900 call writeLineAcc8
 901 br 905
 902 acc16= constant 999
 903 call writeLineAcc16
 904 ;test15.j(138)     if (0x04 + 0x03 | b1 == 0x1F) println (74); else println (999);
 905 acc8= constant 4
 906 acc8+ constant 3
 907 acc8Or variable 0
 908 acc8Comp constant 31
 909 brne 913
 910 acc8= constant 74
 911 call writeLineAcc8
 912 br 916
 913 acc16= constant 999
 914 call writeLineAcc16
 915 ;test15.j(139)     if (0x04 + 0x03 ^ b1 == 0x1B) println (75); else println (999);
 916 acc8= constant 4
 917 acc8+ constant 3
 918 acc8Xor variable 0
 919 acc8Comp constant 27
 920 brne 924
 921 acc8= constant 75
 922 call writeLineAcc8
 923 br 928
 924 acc16= constant 999
 925 call writeLineAcc16
 926 ;test15.j(140)     //acc word/var word
 927 ;test15.j(141)     if (0x1000 + 0x0234 & w1 == 0x0224) println (76); else println (999);
 928 acc16= constant 4096
 929 acc16+ constant 564
 930 acc16And variable 2
 931 acc16Comp constant 548
 932 brne 936
 933 acc8= constant 76
 934 call writeLineAcc8
 935 br 939
 936 acc16= constant 999
 937 call writeLineAcc16
 938 ;test15.j(142)     if (0x1000 + 0x0234 | w1 == 0x133C) println (77); else println (999);
 939 acc16= constant 4096
 940 acc16+ constant 564
 941 acc16Or variable 2
 942 acc16Comp constant 4924
 943 brne 947
 944 acc8= constant 77
 945 call writeLineAcc8
 946 br 950
 947 acc16= constant 999
 948 call writeLineAcc16
 949 ;test15.j(143)     if (0x1000 + 0x0234 ^ w1 == 0x1118) println (78); else println (999);
 950 acc16= constant 4096
 951 acc16+ constant 564
 952 acc16Xor variable 2
 953 acc16Comp constant 4376
 954 brne 958
 955 acc8= constant 78
 956 call writeLineAcc8
 957 br 962
 958 acc16= constant 999
 959 call writeLineAcc16
 960 ;test15.j(144)     //acc byte/var word
 961 ;test15.j(145)     if (0x10 + 0x0C & w2 == 0x0014) println (79); else println (999);
 962 acc8= constant 16
 963 acc8+ constant 12
 964 acc8ToAcc16
 965 acc16And variable 4
 966 acc8= constant 20
 967 acc16CompareAcc8
 968 brne 972
 969 acc8= constant 79
 970 call writeLineAcc8
 971 br 975
 972 acc16= constant 999
 973 call writeLineAcc16
 974 ;test15.j(146)     if (0x10 + 0x0C | w2 == 0x123C) println (80); else println (999);
 975 acc8= constant 16
 976 acc8+ constant 12
 977 acc8ToAcc16
 978 acc16Or variable 4
 979 acc16Comp constant 4668
 980 brne 984
 981 acc8= constant 80
 982 call writeLineAcc8
 983 br 987
 984 acc16= constant 999
 985 call writeLineAcc16
 986 ;test15.j(147)     if (0x10 + 0x0C ^ w2 == 0x1228) println (81); else println (999);
 987 acc8= constant 16
 988 acc8+ constant 12
 989 acc8ToAcc16
 990 acc16Xor variable 4
 991 acc16Comp constant 4648
 992 brne 996
 993 acc8= constant 81
 994 call writeLineAcc8
 995 br 1000
 996 acc16= constant 999
 997 call writeLineAcc16
 998 ;test15.j(148)     //acc word/var byte
 999 ;test15.j(149)     if (0x1000 + 0x0234 & b1 == 0x0014) println (82); else println (999);
1000 acc16= constant 4096
1001 acc16+ constant 564
1002 acc16And variable 0
1003 acc8= constant 20
1004 acc16CompareAcc8
1005 brne 1009
1006 acc8= constant 82
1007 call writeLineAcc8
1008 br 1012
1009 acc16= constant 999
1010 call writeLineAcc16
1011 ;test15.j(150)     if (0x1000 + 0x0234 | b1 == 0x123C) println (83); else println (999);
1012 acc16= constant 4096
1013 acc16+ constant 564
1014 acc16Or variable 0
1015 acc16Comp constant 4668
1016 brne 1020
1017 acc8= constant 83
1018 call writeLineAcc8
1019 br 1023
1020 acc16= constant 999
1021 call writeLineAcc16
1022 ;test15.j(151)     if (0x1000 + 0x0234 ^ b1 == 0x1228) println (84); else println (999);
1023 acc16= constant 4096
1024 acc16+ constant 564
1025 acc16Xor variable 0
1026 acc16Comp constant 4648
1027 brne 1031
1028 acc8= constant 84
1029 call writeLineAcc8
1030 br 1038
1031 acc16= constant 999
1032 call writeLineAcc16
1033 ;test15.j(152)   
1034 ;test15.j(153)     //acc/final var
1035 ;test15.j(154)     //*************
1036 ;test15.j(155)     //acc byte/final var byte
1037 ;test15.j(156)     if (0x04 + 0x03 & fb1 == 0x04) println (85); else println (999);
1038 acc8= constant 4
1039 acc8+ constant 3
1040 acc8And constant 28
1041 acc8Comp constant 4
1042 brne 1046
1043 acc8= constant 85
1044 call writeLineAcc8
1045 br 1049
1046 acc16= constant 999
1047 call writeLineAcc16
1048 ;test15.j(157)     if (0x04 + 0x03 | fb1 == 0x1F) println (86); else println (999);
1049 acc8= constant 4
1050 acc8+ constant 3
1051 acc8Or constant 28
1052 acc8Comp constant 31
1053 brne 1057
1054 acc8= constant 86
1055 call writeLineAcc8
1056 br 1060
1057 acc16= constant 999
1058 call writeLineAcc16
1059 ;test15.j(158)     if (0x04 + 0x03 ^ fb1 == 0x1B) println (87); else println (999);
1060 acc8= constant 4
1061 acc8+ constant 3
1062 acc8Xor constant 28
1063 acc8Comp constant 27
1064 brne 1068
1065 acc8= constant 87
1066 call writeLineAcc8
1067 br 1072
1068 acc16= constant 999
1069 call writeLineAcc16
1070 ;test15.j(159)     //acc word/final var word
1071 ;test15.j(160)     if (0x1000 + 0x0234 & fw1 == 0x0224) println (88); else println (999);
1072 acc16= constant 4096
1073 acc16+ constant 564
1074 acc16And constant 812
1075 acc16Comp constant 548
1076 brne 1080
1077 acc8= constant 88
1078 call writeLineAcc8
1079 br 1083
1080 acc16= constant 999
1081 call writeLineAcc16
1082 ;test15.j(161)     if (0x1000 + 0x0234 | fw1 == 0x133C) println (89); else println (999);
1083 acc16= constant 4096
1084 acc16+ constant 564
1085 acc16Or constant 812
1086 acc16Comp constant 4924
1087 brne 1091
1088 acc8= constant 89
1089 call writeLineAcc8
1090 br 1094
1091 acc16= constant 999
1092 call writeLineAcc16
1093 ;test15.j(162)     if (0x1000 + 0x0234 ^ fw1 == 0x1118) println (90); else println (999);
1094 acc16= constant 4096
1095 acc16+ constant 564
1096 acc16Xor constant 812
1097 acc16Comp constant 4376
1098 brne 1102
1099 acc8= constant 90
1100 call writeLineAcc8
1101 br 1106
1102 acc16= constant 999
1103 call writeLineAcc16
1104 ;test15.j(163)     //acc byte/final var word
1105 ;test15.j(164)     if (0x10 + 0x0C & fw2 == 0x0014) println (91); else println (999);
1106 acc8= constant 16
1107 acc8+ constant 12
1108 acc8ToAcc16
1109 acc16And constant 4660
1110 acc8= constant 20
1111 acc16CompareAcc8
1112 brne 1116
1113 acc8= constant 91
1114 call writeLineAcc8
1115 br 1119
1116 acc16= constant 999
1117 call writeLineAcc16
1118 ;test15.j(165)     if (0x10 + 0x0C | fw2 == 0x123C) println (92); else println (999);
1119 acc8= constant 16
1120 acc8+ constant 12
1121 acc8ToAcc16
1122 acc16Or constant 4660
1123 acc16Comp constant 4668
1124 brne 1128
1125 acc8= constant 92
1126 call writeLineAcc8
1127 br 1131
1128 acc16= constant 999
1129 call writeLineAcc16
1130 ;test15.j(166)     if (0x10 + 0x0C ^ fw2 == 0x1228) println (93); else println (999);
1131 acc8= constant 16
1132 acc8+ constant 12
1133 acc8ToAcc16
1134 acc16Xor constant 4660
1135 acc16Comp constant 4648
1136 brne 1140
1137 acc8= constant 93
1138 call writeLineAcc8
1139 br 1144
1140 acc16= constant 999
1141 call writeLineAcc16
1142 ;test15.j(167)     //acc word/final var byte
1143 ;test15.j(168)     if (0x1000 + 0x0234 & fb1 == 0x0014) println (94); else println (999);
1144 acc16= constant 4096
1145 acc16+ constant 564
1146 acc16And constant 28
1147 acc8= constant 20
1148 acc16CompareAcc8
1149 brne 1153
1150 acc8= constant 94
1151 call writeLineAcc8
1152 br 1156
1153 acc16= constant 999
1154 call writeLineAcc16
1155 ;test15.j(169)     if (0x1000 + 0x0234 | fb1 == 0x123C) println (95); else println (999);
1156 acc16= constant 4096
1157 acc16+ constant 564
1158 acc16Or constant 28
1159 acc16Comp constant 4668
1160 brne 1164
1161 acc8= constant 95
1162 call writeLineAcc8
1163 br 1167
1164 acc16= constant 999
1165 call writeLineAcc16
1166 ;test15.j(170)     if (0x1000 + 0x0234 ^ fb1 == 0x1228) println (96); else println (999);
1167 acc16= constant 4096
1168 acc16+ constant 564
1169 acc16Xor constant 28
1170 acc16Comp constant 4648
1171 brne 1175
1172 acc8= constant 96
1173 call writeLineAcc8
1174 br 1182
1175 acc16= constant 999
1176 call writeLineAcc16
1177 ;test15.j(171)   
1178 ;test15.j(172)     //var/constant
1179 ;test15.j(173)     //************
1180 ;test15.j(174)     //var byte/constant byte
1181 ;test15.j(175)     if (b2 & 0x1C == 0x04) println (97); else println (999);
1182 acc8= variable 1
1183 acc8And constant 28
1184 acc8Comp constant 4
1185 brne 1189
1186 acc8= constant 97
1187 call writeLineAcc8
1188 br 1192
1189 acc16= constant 999
1190 call writeLineAcc16
1191 ;test15.j(176)     if (b2 | 0x1C == 0x1F) println (98); else println (999);
1192 acc8= variable 1
1193 acc8Or constant 28
1194 acc8Comp constant 31
1195 brne 1199
1196 acc8= constant 98
1197 call writeLineAcc8
1198 br 1202
1199 acc16= constant 999
1200 call writeLineAcc16
1201 ;test15.j(177)     if (b2 ^ 0x1C == 0x1B) println (99); else println (999);
1202 acc8= variable 1
1203 acc8Xor constant 28
1204 acc8Comp constant 27
1205 brne 1209
1206 acc8= constant 99
1207 call writeLineAcc8
1208 br 1213
1209 acc16= constant 999
1210 call writeLineAcc16
1211 ;test15.j(178)     //var word/constant word
1212 ;test15.j(179)     if (w2 & 0x032C == 0x0224) println (100); else println (999);
1213 acc16= variable 4
1214 acc16And constant 812
1215 acc16Comp constant 548
1216 brne 1220
1217 acc8= constant 100
1218 call writeLineAcc8
1219 br 1223
1220 acc16= constant 999
1221 call writeLineAcc16
1222 ;test15.j(180)     if (w2 | 0x032C == 0x133C) println (101); else println (999);
1223 acc16= variable 4
1224 acc16Or constant 812
1225 acc16Comp constant 4924
1226 brne 1230
1227 acc8= constant 101
1228 call writeLineAcc8
1229 br 1233
1230 acc16= constant 999
1231 call writeLineAcc16
1232 ;test15.j(181)     if (w2 ^ 0x032C == 0x1118) println (102); else println (999);
1233 acc16= variable 4
1234 acc16Xor constant 812
1235 acc16Comp constant 4376
1236 brne 1240
1237 acc8= constant 102
1238 call writeLineAcc8
1239 br 1244
1240 acc16= constant 999
1241 call writeLineAcc16
1242 ;test15.j(182)     //var byte/constant word
1243 ;test15.j(183)     if (b1 & 0x1234 == 0x0014) println (103); else println (999);
1244 acc8= variable 0
1245 acc8ToAcc16
1246 acc16And constant 4660
1247 acc8= constant 20
1248 acc16CompareAcc8
1249 brne 1253
1250 acc8= constant 103
1251 call writeLineAcc8
1252 br 1256
1253 acc16= constant 999
1254 call writeLineAcc16
1255 ;test15.j(184)     if (b1 | 0x1234 == 0x123C) println (104); else println (999);
1256 acc8= variable 0
1257 acc8ToAcc16
1258 acc16Or constant 4660
1259 acc16Comp constant 4668
1260 brne 1264
1261 acc8= constant 104
1262 call writeLineAcc8
1263 br 1267
1264 acc16= constant 999
1265 call writeLineAcc16
1266 ;test15.j(185)     if (b1 ^ 0x1234 == 0x1228) println (105); else println (999);
1267 acc8= variable 0
1268 acc8ToAcc16
1269 acc16Xor constant 4660
1270 acc16Comp constant 4648
1271 brne 1275
1272 acc8= constant 105
1273 call writeLineAcc8
1274 br 1279
1275 acc16= constant 999
1276 call writeLineAcc16
1277 ;test15.j(186)     //var word/constant byte
1278 ;test15.j(187)     if (w2 & 0x1C == 0x0014) println (106); else println (999);
1279 acc16= variable 4
1280 acc16And constant 28
1281 acc8= constant 20
1282 acc16CompareAcc8
1283 brne 1287
1284 acc8= constant 106
1285 call writeLineAcc8
1286 br 1290
1287 acc16= constant 999
1288 call writeLineAcc16
1289 ;test15.j(188)     if (w2 | 0x1C == 0x123C) println (107); else println (999);
1290 acc16= variable 4
1291 acc16Or constant 28
1292 acc16Comp constant 4668
1293 brne 1297
1294 acc8= constant 107
1295 call writeLineAcc8
1296 br 1300
1297 acc16= constant 999
1298 call writeLineAcc16
1299 ;test15.j(189)     if (w2 ^ 0x1C == 0x1228) println (108); else println (999);
1300 acc16= variable 4
1301 acc16Xor constant 28
1302 acc16Comp constant 4648
1303 brne 1307
1304 acc8= constant 108
1305 call writeLineAcc8
1306 br 1314
1307 acc16= constant 999
1308 call writeLineAcc16
1309 ;test15.j(190)   
1310 ;test15.j(191)     //var/acc
1311 ;test15.j(192)     //*******
1312 ;test15.j(193)     //var byte/acc byte
1313 ;test15.j(194)     if (b2 & (0x10 + 0x0C) == 0x04) println (109); else println (999);
1314 acc8= variable 1
1315 <acc8= constant 16
1316 acc8+ constant 12
1317 acc8And unstack8
1318 acc8Comp constant 4
1319 brne 1323
1320 acc8= constant 109
1321 call writeLineAcc8
1322 br 1326
1323 acc16= constant 999
1324 call writeLineAcc16
1325 ;test15.j(195)     if (b2 | (0x10 + 0x0C) == 0x1F) println (110); else println (999);
1326 acc8= variable 1
1327 <acc8= constant 16
1328 acc8+ constant 12
1329 acc8Or unstack8
1330 acc8Comp constant 31
1331 brne 1335
1332 acc8= constant 110
1333 call writeLineAcc8
1334 br 1338
1335 acc16= constant 999
1336 call writeLineAcc16
1337 ;test15.j(196)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (111); else println (999);
1338 acc8= variable 1
1339 <acc8= constant 16
1340 acc8+ constant 12
1341 acc8Xor unstack8
1342 acc8Comp constant 27
1343 brne 1347
1344 acc8= constant 111
1345 call writeLineAcc8
1346 br 1351
1347 acc16= constant 999
1348 call writeLineAcc16
1349 ;test15.j(197)     //var word/acc word
1350 ;test15.j(198)     if (w2 & 0x0100 + 0x022C == 0x0224) println (112); else println (999);
1351 acc16= variable 4
1352 <acc16= constant 256
1353 acc16+ constant 556
1354 acc16And unstack16
1355 acc16Comp constant 548
1356 brne 1360
1357 acc8= constant 112
1358 call writeLineAcc8
1359 br 1363
1360 acc16= constant 999
1361 call writeLineAcc16
1362 ;test15.j(199)     if (w2 | 0x0100 + 0x022C == 0x133C) println (113); else println (999);
1363 acc16= variable 4
1364 <acc16= constant 256
1365 acc16+ constant 556
1366 acc16Or unstack16
1367 acc16Comp constant 4924
1368 brne 1372
1369 acc8= constant 113
1370 call writeLineAcc8
1371 br 1375
1372 acc16= constant 999
1373 call writeLineAcc16
1374 ;test15.j(200)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (114); else println (999);
1375 acc16= variable 4
1376 <acc16= constant 256
1377 acc16+ constant 556
1378 acc16Xor unstack16
1379 acc16Comp constant 4376
1380 brne 1384
1381 acc8= constant 114
1382 call writeLineAcc8
1383 br 1388
1384 acc16= constant 999
1385 call writeLineAcc16
1386 ;test15.j(201)     //var byte/acc word
1387 ;test15.j(202)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (115); else println (999);
1388 acc8= variable 0
1389 acc16= constant 4096
1390 acc16+ constant 564
1391 acc16And acc8
1392 acc8= constant 20
1393 acc16CompareAcc8
1394 brne 1398
1395 acc8= constant 115
1396 call writeLineAcc8
1397 br 1401
1398 acc16= constant 999
1399 call writeLineAcc16
1400 ;test15.j(203)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (116); else println (999);
1401 acc8= variable 0
1402 acc16= constant 4096
1403 acc16+ constant 564
1404 acc16Or acc8
1405 acc16Comp constant 4668
1406 brne 1410
1407 acc8= constant 116
1408 call writeLineAcc8
1409 br 1413
1410 acc16= constant 999
1411 call writeLineAcc16
1412 ;test15.j(204)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (117); else println (999);
1413 acc8= variable 0
1414 acc16= constant 4096
1415 acc16+ constant 564
1416 acc16Xor acc8
1417 acc16Comp constant 4648
1418 brne 1422
1419 acc8= constant 117
1420 call writeLineAcc8
1421 br 1426
1422 acc16= constant 999
1423 call writeLineAcc16
1424 ;test15.j(205)     //var word/acc byte
1425 ;test15.j(206)     if (w2 & 0x10 + 0x0C == 0x0014) println (118); else println (999);
1426 acc16= variable 4
1427 acc8= constant 16
1428 acc8+ constant 12
1429 acc16And acc8
1430 acc8= constant 20
1431 acc16CompareAcc8
1432 brne 1436
1433 acc8= constant 118
1434 call writeLineAcc8
1435 br 1439
1436 acc16= constant 999
1437 call writeLineAcc16
1438 ;test15.j(207)     if (w2 | 0x10 + 0x0C == 0x123C) println (119); else println (999);
1439 acc16= variable 4
1440 acc8= constant 16
1441 acc8+ constant 12
1442 acc16Or acc8
1443 acc16Comp constant 4668
1444 brne 1448
1445 acc8= constant 119
1446 call writeLineAcc8
1447 br 1451
1448 acc16= constant 999
1449 call writeLineAcc16
1450 ;test15.j(208)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (120); else println (999);
1451 acc16= variable 4
1452 acc8= constant 16
1453 acc8+ constant 12
1454 acc16Xor acc8
1455 acc16Comp constant 4648
1456 brne 1460
1457 acc8= constant 120
1458 call writeLineAcc8
1459 br 1467
1460 acc16= constant 999
1461 call writeLineAcc16
1462 ;test15.j(209)   
1463 ;test15.j(210)     //var/var
1464 ;test15.j(211)     //*******
1465 ;test15.j(212)     //var byte/var byte
1466 ;test15.j(213)     if (b2 & b1 == 0x04) println (121); else println (999);
1467 acc8= variable 1
1468 acc8And variable 0
1469 acc8Comp constant 4
1470 brne 1474
1471 acc8= constant 121
1472 call writeLineAcc8
1473 br 1477
1474 acc16= constant 999
1475 call writeLineAcc16
1476 ;test15.j(214)     if (b2 | b1 == 0x1F) println (122); else println (999);
1477 acc8= variable 1
1478 acc8Or variable 0
1479 acc8Comp constant 31
1480 brne 1484
1481 acc8= constant 122
1482 call writeLineAcc8
1483 br 1487
1484 acc16= constant 999
1485 call writeLineAcc16
1486 ;test15.j(215)     if (b2 ^ b1 == 0x1B) println (123); else println (999);
1487 acc8= variable 1
1488 acc8Xor variable 0
1489 acc8Comp constant 27
1490 brne 1494
1491 acc8= constant 123
1492 call writeLineAcc8
1493 br 1498
1494 acc16= constant 999
1495 call writeLineAcc16
1496 ;test15.j(216)     //var word/var word
1497 ;test15.j(217)     if (w2 & w1 == 0x0224) println (124); else println (999);
1498 acc16= variable 4
1499 acc16And variable 2
1500 acc16Comp constant 548
1501 brne 1505
1502 acc8= constant 124
1503 call writeLineAcc8
1504 br 1508
1505 acc16= constant 999
1506 call writeLineAcc16
1507 ;test15.j(218)     if (w2 | w1 == 0x133C) println (125); else println (999);
1508 acc16= variable 4
1509 acc16Or variable 2
1510 acc16Comp constant 4924
1511 brne 1515
1512 acc8= constant 125
1513 call writeLineAcc8
1514 br 1518
1515 acc16= constant 999
1516 call writeLineAcc16
1517 ;test15.j(219)     if (w2 ^ w1 == 0x1118) println (126); else println (999);
1518 acc16= variable 4
1519 acc16Xor variable 2
1520 acc16Comp constant 4376
1521 brne 1525
1522 acc8= constant 126
1523 call writeLineAcc8
1524 br 1529
1525 acc16= constant 999
1526 call writeLineAcc16
1527 ;test15.j(220)     //var byte/var word
1528 ;test15.j(221)     if (b1 & w2 == 0x0014) println (127); else println (999);
1529 acc8= variable 0
1530 acc8ToAcc16
1531 acc16And variable 4
1532 acc8= constant 20
1533 acc16CompareAcc8
1534 brne 1538
1535 acc8= constant 127
1536 call writeLineAcc8
1537 br 1541
1538 acc16= constant 999
1539 call writeLineAcc16
1540 ;test15.j(222)     if (b1 | w2 == 0x123C) println (128); else println (999);
1541 acc8= variable 0
1542 acc8ToAcc16
1543 acc16Or variable 4
1544 acc16Comp constant 4668
1545 brne 1549
1546 acc8= constant 128
1547 call writeLineAcc8
1548 br 1552
1549 acc16= constant 999
1550 call writeLineAcc16
1551 ;test15.j(223)     if (b1 ^ w2 == 0x1228) println (129); else println (999);
1552 acc8= variable 0
1553 acc8ToAcc16
1554 acc16Xor variable 4
1555 acc16Comp constant 4648
1556 brne 1560
1557 acc8= constant 129
1558 call writeLineAcc8
1559 br 1564
1560 acc16= constant 999
1561 call writeLineAcc16
1562 ;test15.j(224)     //var word/var byte
1563 ;test15.j(225)     if (w2 & b1 == 0x0014) println (130); else println (999);
1564 acc16= variable 4
1565 acc16And variable 0
1566 acc8= constant 20
1567 acc16CompareAcc8
1568 brne 1572
1569 acc8= constant 130
1570 call writeLineAcc8
1571 br 1575
1572 acc16= constant 999
1573 call writeLineAcc16
1574 ;test15.j(226)     if (w2 | b1 == 0x123C) println (131); else println (999);
1575 acc16= variable 4
1576 acc16Or variable 0
1577 acc16Comp constant 4668
1578 brne 1582
1579 acc8= constant 131
1580 call writeLineAcc8
1581 br 1585
1582 acc16= constant 999
1583 call writeLineAcc16
1584 ;test15.j(227)     if (w2 ^ b1 == 0x1228) println (132); else println (999);
1585 acc16= variable 4
1586 acc16Xor variable 0
1587 acc16Comp constant 4648
1588 brne 1592
1589 acc8= constant 132
1590 call writeLineAcc8
1591 br 1599
1592 acc16= constant 999
1593 call writeLineAcc16
1594 ;test15.j(228)   
1595 ;test15.j(229)     //var/final var
1596 ;test15.j(230)     //*************
1597 ;test15.j(231)     //var byte/final var byte
1598 ;test15.j(232)     if (b2 & fb1 == 0x04) println (133); else println (999);
1599 acc8= variable 1
1600 acc8And constant 28
1601 acc8Comp constant 4
1602 brne 1606
1603 acc8= constant 133
1604 call writeLineAcc8
1605 br 1609
1606 acc16= constant 999
1607 call writeLineAcc16
1608 ;test15.j(233)     if (b2 | fb1 == 0x1F) println (134); else println (999);
1609 acc8= variable 1
1610 acc8Or constant 28
1611 acc8Comp constant 31
1612 brne 1616
1613 acc8= constant 134
1614 call writeLineAcc8
1615 br 1619
1616 acc16= constant 999
1617 call writeLineAcc16
1618 ;test15.j(234)     if (b2 ^ fb1 == 0x1B) println (135); else println (999);
1619 acc8= variable 1
1620 acc8Xor constant 28
1621 acc8Comp constant 27
1622 brne 1626
1623 acc8= constant 135
1624 call writeLineAcc8
1625 br 1630
1626 acc16= constant 999
1627 call writeLineAcc16
1628 ;test15.j(235)     //var word/final var word
1629 ;test15.j(236)     if (w2 & fw1 == 0x0224) println (136); else println (999);
1630 acc16= variable 4
1631 acc16And constant 812
1632 acc16Comp constant 548
1633 brne 1637
1634 acc8= constant 136
1635 call writeLineAcc8
1636 br 1640
1637 acc16= constant 999
1638 call writeLineAcc16
1639 ;test15.j(237)     if (w2 | fw1 == 0x133C) println (137); else println (999);
1640 acc16= variable 4
1641 acc16Or constant 812
1642 acc16Comp constant 4924
1643 brne 1647
1644 acc8= constant 137
1645 call writeLineAcc8
1646 br 1650
1647 acc16= constant 999
1648 call writeLineAcc16
1649 ;test15.j(238)     if (w2 ^ fw1 == 0x1118) println (138); else println (999);
1650 acc16= variable 4
1651 acc16Xor constant 812
1652 acc16Comp constant 4376
1653 brne 1657
1654 acc8= constant 138
1655 call writeLineAcc8
1656 br 1661
1657 acc16= constant 999
1658 call writeLineAcc16
1659 ;test15.j(239)     //var byte/final var word
1660 ;test15.j(240)     if (b1 & fw2 == 0x0014) println (139); else println (999);
1661 acc8= variable 0
1662 acc8ToAcc16
1663 acc16And constant 4660
1664 acc8= constant 20
1665 acc16CompareAcc8
1666 brne 1670
1667 acc8= constant 139
1668 call writeLineAcc8
1669 br 1673
1670 acc16= constant 999
1671 call writeLineAcc16
1672 ;test15.j(241)     if (b1 | fw2 == 0x123C) println (140); else println (999);
1673 acc8= variable 0
1674 acc8ToAcc16
1675 acc16Or constant 4660
1676 acc16Comp constant 4668
1677 brne 1681
1678 acc8= constant 140
1679 call writeLineAcc8
1680 br 1684
1681 acc16= constant 999
1682 call writeLineAcc16
1683 ;test15.j(242)     if (b1 ^ fw2 == 0x1228) println (141); else println (999);
1684 acc8= variable 0
1685 acc8ToAcc16
1686 acc16Xor constant 4660
1687 acc16Comp constant 4648
1688 brne 1692
1689 acc8= constant 141
1690 call writeLineAcc8
1691 br 1696
1692 acc16= constant 999
1693 call writeLineAcc16
1694 ;test15.j(243)     //var word/final var byte
1695 ;test15.j(244)     if (w2 & fb1 == 0x0014) println (142); else println (999);
1696 acc16= variable 4
1697 acc16And constant 28
1698 acc8= constant 20
1699 acc16CompareAcc8
1700 brne 1704
1701 acc8= constant 142
1702 call writeLineAcc8
1703 br 1707
1704 acc16= constant 999
1705 call writeLineAcc16
1706 ;test15.j(245)     if (w2 | fb1 == 0x123C) println (143); else println (999);
1707 acc16= variable 4
1708 acc16Or constant 28
1709 acc16Comp constant 4668
1710 brne 1714
1711 acc8= constant 143
1712 call writeLineAcc8
1713 br 1717
1714 acc16= constant 999
1715 call writeLineAcc16
1716 ;test15.j(246)     if (w2 ^ fb1 == 0x1228) println (144); else println (999);
1717 acc16= variable 4
1718 acc16Xor constant 28
1719 acc16Comp constant 4648
1720 brne 1724
1721 acc8= constant 144
1722 call writeLineAcc8
1723 br 1731
1724 acc16= constant 999
1725 call writeLineAcc16
1726 ;test15.j(247)   
1727 ;test15.j(248)     //final var/constant
1728 ;test15.j(249)     //******************
1729 ;test15.j(250)     //final var byte/constant byte
1730 ;test15.j(251)     if (b2 & 0x1C == 0x04) println (145); else println (999);
1731 acc8= variable 1
1732 acc8And constant 28
1733 acc8Comp constant 4
1734 brne 1738
1735 acc8= constant 145
1736 call writeLineAcc8
1737 br 1741
1738 acc16= constant 999
1739 call writeLineAcc16
1740 ;test15.j(252)     if (b2 | 0x1C == 0x1F) println (146); else println (999);
1741 acc8= variable 1
1742 acc8Or constant 28
1743 acc8Comp constant 31
1744 brne 1748
1745 acc8= constant 146
1746 call writeLineAcc8
1747 br 1751
1748 acc16= constant 999
1749 call writeLineAcc16
1750 ;test15.j(253)     if (b2 ^ 0x1C == 0x1B) println (147); else println (999);
1751 acc8= variable 1
1752 acc8Xor constant 28
1753 acc8Comp constant 27
1754 brne 1758
1755 acc8= constant 147
1756 call writeLineAcc8
1757 br 1762
1758 acc16= constant 999
1759 call writeLineAcc16
1760 ;test15.j(254)     //final var word/constant word
1761 ;test15.j(255)     if (w2 & 0x032C == 0x0224) println (148); else println (999);
1762 acc16= variable 4
1763 acc16And constant 812
1764 acc16Comp constant 548
1765 brne 1769
1766 acc8= constant 148
1767 call writeLineAcc8
1768 br 1772
1769 acc16= constant 999
1770 call writeLineAcc16
1771 ;test15.j(256)     if (w2 | 0x032C == 0x133C) println (149); else println (999);
1772 acc16= variable 4
1773 acc16Or constant 812
1774 acc16Comp constant 4924
1775 brne 1779
1776 acc8= constant 149
1777 call writeLineAcc8
1778 br 1782
1779 acc16= constant 999
1780 call writeLineAcc16
1781 ;test15.j(257)     if (w2 ^ 0x032C == 0x1118) println (150); else println (999);
1782 acc16= variable 4
1783 acc16Xor constant 812
1784 acc16Comp constant 4376
1785 brne 1789
1786 acc8= constant 150
1787 call writeLineAcc8
1788 br 1793
1789 acc16= constant 999
1790 call writeLineAcc16
1791 ;test15.j(258)     //final var byte/constant word
1792 ;test15.j(259)     if (b1 & 0x1234 == 0x0014) println (151); else println (999);
1793 acc8= variable 0
1794 acc8ToAcc16
1795 acc16And constant 4660
1796 acc8= constant 20
1797 acc16CompareAcc8
1798 brne 1802
1799 acc8= constant 151
1800 call writeLineAcc8
1801 br 1805
1802 acc16= constant 999
1803 call writeLineAcc16
1804 ;test15.j(260)     if (b1 | 0x1234 == 0x123C) println (152); else println (999);
1805 acc8= variable 0
1806 acc8ToAcc16
1807 acc16Or constant 4660
1808 acc16Comp constant 4668
1809 brne 1813
1810 acc8= constant 152
1811 call writeLineAcc8
1812 br 1816
1813 acc16= constant 999
1814 call writeLineAcc16
1815 ;test15.j(261)     if (b1 ^ 0x1234 == 0x1228) println (153); else println (999);
1816 acc8= variable 0
1817 acc8ToAcc16
1818 acc16Xor constant 4660
1819 acc16Comp constant 4648
1820 brne 1824
1821 acc8= constant 153
1822 call writeLineAcc8
1823 br 1828
1824 acc16= constant 999
1825 call writeLineAcc16
1826 ;test15.j(262)     //final var word/constant byte
1827 ;test15.j(263)     if (w2 & 0x1C == 0x0014) println (154); else println (999);
1828 acc16= variable 4
1829 acc16And constant 28
1830 acc8= constant 20
1831 acc16CompareAcc8
1832 brne 1836
1833 acc8= constant 154
1834 call writeLineAcc8
1835 br 1839
1836 acc16= constant 999
1837 call writeLineAcc16
1838 ;test15.j(264)     if (w2 | 0x1C == 0x123C) println (155); else println (999);
1839 acc16= variable 4
1840 acc16Or constant 28
1841 acc16Comp constant 4668
1842 brne 1846
1843 acc8= constant 155
1844 call writeLineAcc8
1845 br 1849
1846 acc16= constant 999
1847 call writeLineAcc16
1848 ;test15.j(265)     if (w2 ^ 0x1C == 0x1228) println (156); else println (999);
1849 acc16= variable 4
1850 acc16Xor constant 28
1851 acc16Comp constant 4648
1852 brne 1856
1853 acc8= constant 156
1854 call writeLineAcc8
1855 br 1863
1856 acc16= constant 999
1857 call writeLineAcc16
1858 ;test15.j(266)   
1859 ;test15.j(267)     //final var/acc
1860 ;test15.j(268)     //*************
1861 ;test15.j(269)     //final var byte/acc byte
1862 ;test15.j(270)     if (b2 & (0x10 + 0x0C) == 0x04) println (157); else println (999);
1863 acc8= variable 1
1864 <acc8= constant 16
1865 acc8+ constant 12
1866 acc8And unstack8
1867 acc8Comp constant 4
1868 brne 1872
1869 acc8= constant 157
1870 call writeLineAcc8
1871 br 1875
1872 acc16= constant 999
1873 call writeLineAcc16
1874 ;test15.j(271)     if (b2 | (0x10 + 0x0C) == 0x1F) println (158); else println (999);
1875 acc8= variable 1
1876 <acc8= constant 16
1877 acc8+ constant 12
1878 acc8Or unstack8
1879 acc8Comp constant 31
1880 brne 1884
1881 acc8= constant 158
1882 call writeLineAcc8
1883 br 1887
1884 acc16= constant 999
1885 call writeLineAcc16
1886 ;test15.j(272)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (159); else println (999);
1887 acc8= variable 1
1888 <acc8= constant 16
1889 acc8+ constant 12
1890 acc8Xor unstack8
1891 acc8Comp constant 27
1892 brne 1896
1893 acc8= constant 159
1894 call writeLineAcc8
1895 br 1900
1896 acc16= constant 999
1897 call writeLineAcc16
1898 ;test15.j(273)     //final var word/acc word
1899 ;test15.j(274)     if (w2 & 0x0100 + 0x022C == 0x0224) println (160); else println (999);
1900 acc16= variable 4
1901 <acc16= constant 256
1902 acc16+ constant 556
1903 acc16And unstack16
1904 acc16Comp constant 548
1905 brne 1909
1906 acc8= constant 160
1907 call writeLineAcc8
1908 br 1912
1909 acc16= constant 999
1910 call writeLineAcc16
1911 ;test15.j(275)     if (w2 | 0x0100 + 0x022C == 0x133C) println (161); else println (999);
1912 acc16= variable 4
1913 <acc16= constant 256
1914 acc16+ constant 556
1915 acc16Or unstack16
1916 acc16Comp constant 4924
1917 brne 1921
1918 acc8= constant 161
1919 call writeLineAcc8
1920 br 1924
1921 acc16= constant 999
1922 call writeLineAcc16
1923 ;test15.j(276)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (162); else println (999);
1924 acc16= variable 4
1925 <acc16= constant 256
1926 acc16+ constant 556
1927 acc16Xor unstack16
1928 acc16Comp constant 4376
1929 brne 1933
1930 acc8= constant 162
1931 call writeLineAcc8
1932 br 1937
1933 acc16= constant 999
1934 call writeLineAcc16
1935 ;test15.j(277)     //final var byte/acc word
1936 ;test15.j(278)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (163); else println (999);
1937 acc8= variable 0
1938 acc16= constant 4096
1939 acc16+ constant 564
1940 acc16And acc8
1941 acc8= constant 20
1942 acc16CompareAcc8
1943 brne 1947
1944 acc8= constant 163
1945 call writeLineAcc8
1946 br 1950
1947 acc16= constant 999
1948 call writeLineAcc16
1949 ;test15.j(279)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (164); else println (999);
1950 acc8= variable 0
1951 acc16= constant 4096
1952 acc16+ constant 564
1953 acc16Or acc8
1954 acc16Comp constant 4668
1955 brne 1959
1956 acc8= constant 164
1957 call writeLineAcc8
1958 br 1962
1959 acc16= constant 999
1960 call writeLineAcc16
1961 ;test15.j(280)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (165); else println (999);
1962 acc8= variable 0
1963 acc16= constant 4096
1964 acc16+ constant 564
1965 acc16Xor acc8
1966 acc16Comp constant 4648
1967 brne 1971
1968 acc8= constant 165
1969 call writeLineAcc8
1970 br 1975
1971 acc16= constant 999
1972 call writeLineAcc16
1973 ;test15.j(281)     //final var word/acc byte
1974 ;test15.j(282)     if (w2 & 0x10 + 0x0C == 0x0014) println (166); else println (999);
1975 acc16= variable 4
1976 acc8= constant 16
1977 acc8+ constant 12
1978 acc16And acc8
1979 acc8= constant 20
1980 acc16CompareAcc8
1981 brne 1985
1982 acc8= constant 166
1983 call writeLineAcc8
1984 br 1988
1985 acc16= constant 999
1986 call writeLineAcc16
1987 ;test15.j(283)     if (w2 | 0x10 + 0x0C == 0x123C) println (167); else println (999);
1988 acc16= variable 4
1989 acc8= constant 16
1990 acc8+ constant 12
1991 acc16Or acc8
1992 acc16Comp constant 4668
1993 brne 1997
1994 acc8= constant 167
1995 call writeLineAcc8
1996 br 2000
1997 acc16= constant 999
1998 call writeLineAcc16
1999 ;test15.j(284)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (168); else println (999);
2000 acc16= variable 4
2001 acc8= constant 16
2002 acc8+ constant 12
2003 acc16Xor acc8
2004 acc16Comp constant 4648
2005 brne 2009
2006 acc8= constant 168
2007 call writeLineAcc8
2008 br 2016
2009 acc16= constant 999
2010 call writeLineAcc16
2011 ;test15.j(285)   
2012 ;test15.j(286)     //final var/var
2013 ;test15.j(287)     //*************
2014 ;test15.j(288)     //final var byte/var byte
2015 ;test15.j(289)     if (b2 & b1 == 0x04) println (169); else println (999);
2016 acc8= variable 1
2017 acc8And variable 0
2018 acc8Comp constant 4
2019 brne 2023
2020 acc8= constant 169
2021 call writeLineAcc8
2022 br 2026
2023 acc16= constant 999
2024 call writeLineAcc16
2025 ;test15.j(290)     if (b2 | b1 == 0x1F) println (170); else println (999);
2026 acc8= variable 1
2027 acc8Or variable 0
2028 acc8Comp constant 31
2029 brne 2033
2030 acc8= constant 170
2031 call writeLineAcc8
2032 br 2036
2033 acc16= constant 999
2034 call writeLineAcc16
2035 ;test15.j(291)     if (b2 ^ b1 == 0x1B) println (171); else println (999);
2036 acc8= variable 1
2037 acc8Xor variable 0
2038 acc8Comp constant 27
2039 brne 2043
2040 acc8= constant 171
2041 call writeLineAcc8
2042 br 2047
2043 acc16= constant 999
2044 call writeLineAcc16
2045 ;test15.j(292)     //final var word/var word
2046 ;test15.j(293)     if (w2 & w1 == 0x0224) println (172); else println (999);
2047 acc16= variable 4
2048 acc16And variable 2
2049 acc16Comp constant 548
2050 brne 2054
2051 acc8= constant 172
2052 call writeLineAcc8
2053 br 2057
2054 acc16= constant 999
2055 call writeLineAcc16
2056 ;test15.j(294)     if (w2 | w1 == 0x133C) println (173); else println (999);
2057 acc16= variable 4
2058 acc16Or variable 2
2059 acc16Comp constant 4924
2060 brne 2064
2061 acc8= constant 173
2062 call writeLineAcc8
2063 br 2067
2064 acc16= constant 999
2065 call writeLineAcc16
2066 ;test15.j(295)     if (w2 ^ w1 == 0x1118) println (174); else println (999);
2067 acc16= variable 4
2068 acc16Xor variable 2
2069 acc16Comp constant 4376
2070 brne 2074
2071 acc8= constant 174
2072 call writeLineAcc8
2073 br 2078
2074 acc16= constant 999
2075 call writeLineAcc16
2076 ;test15.j(296)     //final var byte/var word
2077 ;test15.j(297)     if (b1 & w2 == 0x0014) println (175); else println (999);
2078 acc8= variable 0
2079 acc8ToAcc16
2080 acc16And variable 4
2081 acc8= constant 20
2082 acc16CompareAcc8
2083 brne 2087
2084 acc8= constant 175
2085 call writeLineAcc8
2086 br 2090
2087 acc16= constant 999
2088 call writeLineAcc16
2089 ;test15.j(298)     if (b1 | w2 == 0x123C) println (176); else println (999);
2090 acc8= variable 0
2091 acc8ToAcc16
2092 acc16Or variable 4
2093 acc16Comp constant 4668
2094 brne 2098
2095 acc8= constant 176
2096 call writeLineAcc8
2097 br 2101
2098 acc16= constant 999
2099 call writeLineAcc16
2100 ;test15.j(299)     if (b1 ^ w2 == 0x1228) println (177); else println (999);
2101 acc8= variable 0
2102 acc8ToAcc16
2103 acc16Xor variable 4
2104 acc16Comp constant 4648
2105 brne 2109
2106 acc8= constant 177
2107 call writeLineAcc8
2108 br 2113
2109 acc16= constant 999
2110 call writeLineAcc16
2111 ;test15.j(300)     //final var word/var byte
2112 ;test15.j(301)     if (w2 & b1 == 0x0014) println (178); else println (999);
2113 acc16= variable 4
2114 acc16And variable 0
2115 acc8= constant 20
2116 acc16CompareAcc8
2117 brne 2121
2118 acc8= constant 178
2119 call writeLineAcc8
2120 br 2124
2121 acc16= constant 999
2122 call writeLineAcc16
2123 ;test15.j(302)     if (w2 | b1 == 0x123C) println (179); else println (999);
2124 acc16= variable 4
2125 acc16Or variable 0
2126 acc16Comp constant 4668
2127 brne 2131
2128 acc8= constant 179
2129 call writeLineAcc8
2130 br 2134
2131 acc16= constant 999
2132 call writeLineAcc16
2133 ;test15.j(303)     if (w2 ^ b1 == 0x1228) println (180); else println (999);
2134 acc16= variable 4
2135 acc16Xor variable 0
2136 acc16Comp constant 4648
2137 brne 2141
2138 acc8= constant 180
2139 call writeLineAcc8
2140 br 2148
2141 acc16= constant 999
2142 call writeLineAcc16
2143 ;test15.j(304)   
2144 ;test15.j(305)     //final var/final var
2145 ;test15.j(306)     //*******************
2146 ;test15.j(307)     //final var byte/final var byte
2147 ;test15.j(308)     if (fb2 & fb1 == 0x04) println (181); else println (999);
2148 acc8= constant 7
2149 acc8And constant 28
2150 acc8Comp constant 4
2151 brne 2155
2152 acc8= constant 181
2153 call writeLineAcc8
2154 br 2158
2155 acc16= constant 999
2156 call writeLineAcc16
2157 ;test15.j(309)     if (fb2 | fb1 == 0x1F) println (182); else println (999);
2158 acc8= constant 7
2159 acc8Or constant 28
2160 acc8Comp constant 31
2161 brne 2165
2162 acc8= constant 182
2163 call writeLineAcc8
2164 br 2168
2165 acc16= constant 999
2166 call writeLineAcc16
2167 ;test15.j(310)     if (fb2 ^ fb1 == 0x1B) println (183); else println (999);
2168 acc8= constant 7
2169 acc8Xor constant 28
2170 acc8Comp constant 27
2171 brne 2175
2172 acc8= constant 183
2173 call writeLineAcc8
2174 br 2179
2175 acc16= constant 999
2176 call writeLineAcc16
2177 ;test15.j(311)     //final var word/final var word
2178 ;test15.j(312)     if (fw2 & fw1 == 0x0224) println (184); else println (999);
2179 acc16= constant 4660
2180 acc16And constant 812
2181 acc16Comp constant 548
2182 brne 2186
2183 acc8= constant 184
2184 call writeLineAcc8
2185 br 2189
2186 acc16= constant 999
2187 call writeLineAcc16
2188 ;test15.j(313)     if (fw2 | fw1 == 0x133C) println (185); else println (999);
2189 acc16= constant 4660
2190 acc16Or constant 812
2191 acc16Comp constant 4924
2192 brne 2196
2193 acc8= constant 185
2194 call writeLineAcc8
2195 br 2199
2196 acc16= constant 999
2197 call writeLineAcc16
2198 ;test15.j(314)     if (fw2 ^ fw1 == 0x1118) println (186); else println (999);
2199 acc16= constant 4660
2200 acc16Xor constant 812
2201 acc16Comp constant 4376
2202 brne 2206
2203 acc8= constant 186
2204 call writeLineAcc8
2205 br 2210
2206 acc16= constant 999
2207 call writeLineAcc16
2208 ;test15.j(315)     //final var byte/final var word
2209 ;test15.j(316)     if (fb1 & fw2 == 0x0014) println (187); else println (999);
2210 acc8= constant 28
2211 acc8ToAcc16
2212 acc16And constant 4660
2213 acc8= constant 20
2214 acc16CompareAcc8
2215 brne 2219
2216 acc8= constant 187
2217 call writeLineAcc8
2218 br 2222
2219 acc16= constant 999
2220 call writeLineAcc16
2221 ;test15.j(317)     if (fb1 | fw2 == 0x123C) println (188); else println (999);
2222 acc8= constant 28
2223 acc8ToAcc16
2224 acc16Or constant 4660
2225 acc16Comp constant 4668
2226 brne 2230
2227 acc8= constant 188
2228 call writeLineAcc8
2229 br 2233
2230 acc16= constant 999
2231 call writeLineAcc16
2232 ;test15.j(318)     if (fb1 ^ fw2 == 0x1228) println (189); else println (999);
2233 acc8= constant 28
2234 acc8ToAcc16
2235 acc16Xor constant 4660
2236 acc16Comp constant 4648
2237 brne 2241
2238 acc8= constant 189
2239 call writeLineAcc8
2240 br 2245
2241 acc16= constant 999
2242 call writeLineAcc16
2243 ;test15.j(319)     //final var word/final var byte
2244 ;test15.j(320)     if (fw2 & fb1 == 0x0014) println (190); else println (999);
2245 acc16= constant 4660
2246 acc16And constant 28
2247 acc8= constant 20
2248 acc16CompareAcc8
2249 brne 2253
2250 acc8= constant 190
2251 call writeLineAcc8
2252 br 2256
2253 acc16= constant 999
2254 call writeLineAcc16
2255 ;test15.j(321)     if (fw2 | fb1 == 0x123C) println (191); else println (999);
2256 acc16= constant 4660
2257 acc16Or constant 28
2258 acc16Comp constant 4668
2259 brne 2263
2260 acc8= constant 191
2261 call writeLineAcc8
2262 br 2266
2263 acc16= constant 999
2264 call writeLineAcc16
2265 ;test15.j(322)     if (fw2 ^ fb1 == 0x1228) println (192); else println (999);
2266 acc16= constant 4660
2267 acc16Xor constant 28
2268 acc16Comp constant 4648
2269 brne 2273
2270 acc8= constant 192
2271 call writeLineAcc8
2272 br 2277
2273 acc16= constant 999
2274 call writeLineAcc16
2275 ;test15.j(323)   
2276 ;test15.j(324)     println("Klaar");
2277 acc16= constant 2282
2278 writeLineString
2279 ;test15.j(325)   }
2280 ;test15.j(326) }
2281 stop
2282 stringConstant 0 = "Klaar"
