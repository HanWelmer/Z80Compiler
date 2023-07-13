   0 ;test15.j(0) /* Program to test bitwise operators and, or and xor. */
   1 ;test15.j(1) class TestBitwiseOperators {
   2 ;test15.j(2)   println(0);
   3 acc8= constant 0
   4 call writeLineAcc8
   5 ;test15.j(3)   
   6 ;test15.j(4)   // Possible operand types: constant, acc, var, final var, stack8, stack16.
   7 ;test15.j(5)   // Possible data types: byt, word.
   8 ;test15.j(6) 
   9 ;test15.j(7)   byte b1 = 0x1C;
  10 acc8= constant 28
  11 acc8=> variable 0
  12 ;test15.j(8)   byte b2 = 0x07;
  13 acc8= constant 7
  14 acc8=> variable 1
  15 ;test15.j(9)   word w1 = 0x032C;
  16 acc16= constant 812
  17 acc16=> variable 2
  18 ;test15.j(10)   word w2 = 0x1234;
  19 acc16= constant 4660
  20 acc16=> variable 4
  21 ;test15.j(11)   final byte fb1 = 0x1C;
  22 ;test15.j(12)   final byte fb2 = 0x07;
  23 ;test15.j(13)   final word fw1 = 0x032C;
  24 ;test15.j(14)   final word fw2 = 0x1234;
  25 ;test15.j(15) 
  26 ;test15.j(16)   //constant/constant
  27 ;test15.j(17)   //*****************
  28 ;test15.j(18)   //constant byte/constant byte
  29 ;test15.j(19)   if (0x07 & 0x1C == 0x04) println (1); else println (999); //0000.0111 & 0001.1100 = 0000.0100
  30 acc8= constant 7
  31 acc8And constant 28
  32 acc8Comp constant 4
  33 brne 37
  34 acc8= constant 1
  35 call writeLineAcc8
  36 br 40
  37 acc16= constant 999
  38 call writeLineAcc16
  39 ;test15.j(20)   if (0x07 | 0x1C == 0x1F) println (2); else println (999); //0000.0111 | 0001.1100 = 0001.1111
  40 acc8= constant 7
  41 acc8Or constant 28
  42 acc8Comp constant 31
  43 brne 47
  44 acc8= constant 2
  45 call writeLineAcc8
  46 br 50
  47 acc16= constant 999
  48 call writeLineAcc16
  49 ;test15.j(21)   if (0x07 ^ 0x1C == 0x1B) println (3); else println (999); //0000.0111 ^ 0001.1100 = 0001.1011
  50 acc8= constant 7
  51 acc8Xor constant 28
  52 acc8Comp constant 27
  53 brne 57
  54 acc8= constant 3
  55 call writeLineAcc8
  56 br 61
  57 acc16= constant 999
  58 call writeLineAcc16
  59 ;test15.j(22)   //constant word/constant word
  60 ;test15.j(23)   if (0x1234 & 0x032C == 0x0224) println (4); else println (999);
  61 acc16= constant 4660
  62 acc16And constant 812
  63 acc16Comp constant 548
  64 brne 68
  65 acc8= constant 4
  66 call writeLineAcc8
  67 br 72
  68 acc16= constant 999
  69 call writeLineAcc16
  70 ;test15.j(24)   //0001.0010.0011.0100 & 0000.0011.0010.1100 = 0000.0010.0010.0100
  71 ;test15.j(25)   if (0x1234 | 0x032C == 0x133C) println (5); else println (999);
  72 acc16= constant 4660
  73 acc16Or constant 812
  74 acc16Comp constant 4924
  75 brne 79
  76 acc8= constant 5
  77 call writeLineAcc8
  78 br 83
  79 acc16= constant 999
  80 call writeLineAcc16
  81 ;test15.j(26)   //0001.0010.0011.0100 | 0000.0011.0010.1100 = 0001.0011.0011.1100
  82 ;test15.j(27)   if (0x1234 ^ 0x032C == 0x1118) println (6); else println (999);
  83 acc16= constant 4660
  84 acc16Xor constant 812
  85 acc16Comp constant 4376
  86 brne 90
  87 acc8= constant 6
  88 call writeLineAcc8
  89 br 95
  90 acc16= constant 999
  91 call writeLineAcc16
  92 ;test15.j(28)   //0001.0010.0011.0100 ^ 0000.0011.0010.1100 = 0001.0001.0001.1000
  93 ;test15.j(29)   //constant byt/constant word
  94 ;test15.j(30)   if (0x1C & 0x1234 == 0x0014) println (7); else println (999); //0001.1100 & 0001.0010.0011.0100 = 0000.0000.0001.0100
  95 acc8= constant 28
  96 acc8ToAcc16
  97 acc16And constant 4660
  98 acc8= constant 20
  99 acc16CompareAcc8
 100 brne 104
 101 acc8= constant 7
 102 call writeLineAcc8
 103 br 107
 104 acc16= constant 999
 105 call writeLineAcc16
 106 ;test15.j(31)   if (0x1C | 0x1234 == 0x123C) println (8); else println (999); //0001.1100 | 0001.0010.0011.0100 = 0001.0010.0011.1100
 107 acc8= constant 28
 108 acc8ToAcc16
 109 acc16Or constant 4660
 110 acc16Comp constant 4668
 111 brne 115
 112 acc8= constant 8
 113 call writeLineAcc8
 114 br 118
 115 acc16= constant 999
 116 call writeLineAcc16
 117 ;test15.j(32)   if (0x1C ^ 0x1234 == 0x1228) println (9); else println (999); //0001.1100 ^ 0001.0010.0011.0100 = 0001.0010.0010.1000
 118 acc8= constant 28
 119 acc8ToAcc16
 120 acc16Xor constant 4660
 121 acc16Comp constant 4648
 122 brne 126
 123 acc8= constant 9
 124 call writeLineAcc8
 125 br 130
 126 acc16= constant 999
 127 call writeLineAcc16
 128 ;test15.j(33)   //constant word/constant byt
 129 ;test15.j(34)   if (0x1234 & 0x1C == 0x0014) println (10); else println (999); //0001.0010.0011.0100 & 0001.1100 = 0000.0000.0001.0100
 130 acc16= constant 4660
 131 acc16And constant 28
 132 acc8= constant 20
 133 acc16CompareAcc8
 134 brne 138
 135 acc8= constant 10
 136 call writeLineAcc8
 137 br 141
 138 acc16= constant 999
 139 call writeLineAcc16
 140 ;test15.j(35)   if (0x1234 | 0x1C == 0x123C) println (11); else println (999); //0001.0010.0011.0100 | 0001.1100 = 0001.0010.0011.1100
 141 acc16= constant 4660
 142 acc16Or constant 28
 143 acc16Comp constant 4668
 144 brne 148
 145 acc8= constant 11
 146 call writeLineAcc8
 147 br 151
 148 acc16= constant 999
 149 call writeLineAcc16
 150 ;test15.j(36)   if (0x1234 ^ 0x1C == 0x1228) println (12); else println (999); //0001.0010.0011.0100 ^ 0001.1100 = 0001.0010.0010.1000
 151 acc16= constant 4660
 152 acc16Xor constant 28
 153 acc16Comp constant 4648
 154 brne 158
 155 acc8= constant 12
 156 call writeLineAcc8
 157 br 165
 158 acc16= constant 999
 159 call writeLineAcc16
 160 ;test15.j(37) 
 161 ;test15.j(38)   //constant/acc
 162 ;test15.j(39)   //************
 163 ;test15.j(40)   //constant byte/acc byte
 164 ;test15.j(41)   if (0x07 & (0x10 + 0x0C) == 0x04) println (13); else println (999);
 165 acc8= constant 7
 166 <acc8= constant 16
 167 acc8+ constant 12
 168 acc8And unstack8
 169 acc8Comp constant 4
 170 brne 174
 171 acc8= constant 13
 172 call writeLineAcc8
 173 br 177
 174 acc16= constant 999
 175 call writeLineAcc16
 176 ;test15.j(42)   if (0x07 | (0x10 + 0x0C) == 0x1F) println (14); else println (999);
 177 acc8= constant 7
 178 <acc8= constant 16
 179 acc8+ constant 12
 180 acc8Or unstack8
 181 acc8Comp constant 31
 182 brne 186
 183 acc8= constant 14
 184 call writeLineAcc8
 185 br 189
 186 acc16= constant 999
 187 call writeLineAcc16
 188 ;test15.j(43)   if (0x07 ^ (0x10 + 0x0C) == 0x1B) println (15); else println (999);
 189 acc8= constant 7
 190 <acc8= constant 16
 191 acc8+ constant 12
 192 acc8Xor unstack8
 193 acc8Comp constant 27
 194 brne 198
 195 acc8= constant 15
 196 call writeLineAcc8
 197 br 202
 198 acc16= constant 999
 199 call writeLineAcc16
 200 ;test15.j(44)   //constant word/acc word
 201 ;test15.j(45)   if (0x1234 & 0x0100 + 0x022C == 0x0224) println (16); else println (999);
 202 acc16= constant 4660
 203 <acc16= constant 256
 204 acc16+ constant 556
 205 acc16And unstack16
 206 acc16Comp constant 548
 207 brne 211
 208 acc8= constant 16
 209 call writeLineAcc8
 210 br 214
 211 acc16= constant 999
 212 call writeLineAcc16
 213 ;test15.j(46)   if (0x1234 | 0x0100 + 0x022C == 0x133C) println (17); else println (999);
 214 acc16= constant 4660
 215 <acc16= constant 256
 216 acc16+ constant 556
 217 acc16Or unstack16
 218 acc16Comp constant 4924
 219 brne 223
 220 acc8= constant 17
 221 call writeLineAcc8
 222 br 226
 223 acc16= constant 999
 224 call writeLineAcc16
 225 ;test15.j(47)   if (0x1234 ^ 0x0100 + 0x022C == 0x1118) println (18); else println (999);
 226 acc16= constant 4660
 227 <acc16= constant 256
 228 acc16+ constant 556
 229 acc16Xor unstack16
 230 acc16Comp constant 4376
 231 brne 235
 232 acc8= constant 18
 233 call writeLineAcc8
 234 br 239
 235 acc16= constant 999
 236 call writeLineAcc16
 237 ;test15.j(48)   //constant byt/acc word
 238 ;test15.j(49)   if (0x1C & 0x1000 + 0x0234 == 0x0014) println (19); else println (999);
 239 acc8= constant 28
 240 acc16= constant 4096
 241 acc16+ constant 564
 242 acc16And acc8
 243 acc8= constant 20
 244 acc16CompareAcc8
 245 brne 249
 246 acc8= constant 19
 247 call writeLineAcc8
 248 br 252
 249 acc16= constant 999
 250 call writeLineAcc16
 251 ;test15.j(50)   if (0x1C | 0x1000 + 0x0234 == 0x123C) println (20); else println (999);
 252 acc8= constant 28
 253 acc16= constant 4096
 254 acc16+ constant 564
 255 acc16Or acc8
 256 acc16Comp constant 4668
 257 brne 261
 258 acc8= constant 20
 259 call writeLineAcc8
 260 br 264
 261 acc16= constant 999
 262 call writeLineAcc16
 263 ;test15.j(51)   if (0x1C ^ 0x1000 + 0x0234 == 0x1228) println (21); else println (999);
 264 acc8= constant 28
 265 acc16= constant 4096
 266 acc16+ constant 564
 267 acc16Xor acc8
 268 acc16Comp constant 4648
 269 brne 273
 270 acc8= constant 21
 271 call writeLineAcc8
 272 br 277
 273 acc16= constant 999
 274 call writeLineAcc16
 275 ;test15.j(52)   //constant word/acc byt
 276 ;test15.j(53)   if (0x1234 & 0x10 + 0x0C == 0x0014) println (22); else println (999);
 277 acc16= constant 4660
 278 acc8= constant 16
 279 acc8+ constant 12
 280 acc16And acc8
 281 acc8= constant 20
 282 acc16CompareAcc8
 283 brne 287
 284 acc8= constant 22
 285 call writeLineAcc8
 286 br 290
 287 acc16= constant 999
 288 call writeLineAcc16
 289 ;test15.j(54)   if (0x1234 | 0x10 + 0x0C == 0x123C) println (23); else println (999);
 290 acc16= constant 4660
 291 acc8= constant 16
 292 acc8+ constant 12
 293 acc16Or acc8
 294 acc16Comp constant 4668
 295 brne 299
 296 acc8= constant 23
 297 call writeLineAcc8
 298 br 302
 299 acc16= constant 999
 300 call writeLineAcc16
 301 ;test15.j(55)   if (0x1234 ^ 0x10 + 0x0C == 0x1228) println (24); else println (999);
 302 acc16= constant 4660
 303 acc8= constant 16
 304 acc8+ constant 12
 305 acc16Xor acc8
 306 acc16Comp constant 4648
 307 brne 311
 308 acc8= constant 24
 309 call writeLineAcc8
 310 br 318
 311 acc16= constant 999
 312 call writeLineAcc16
 313 ;test15.j(56) 
 314 ;test15.j(57)   //constant/var
 315 ;test15.j(58)   //*****************
 316 ;test15.j(59)   //constant byte/var byte
 317 ;test15.j(60)   if (0x07 & b1 == 0x04) println (25); else println (999);
 318 acc8= constant 7
 319 acc8And variable 0
 320 acc8Comp constant 4
 321 brne 325
 322 acc8= constant 25
 323 call writeLineAcc8
 324 br 328
 325 acc16= constant 999
 326 call writeLineAcc16
 327 ;test15.j(61)   if (0x07 | b1 == 0x1F) println (26); else println (999);
 328 acc8= constant 7
 329 acc8Or variable 0
 330 acc8Comp constant 31
 331 brne 335
 332 acc8= constant 26
 333 call writeLineAcc8
 334 br 338
 335 acc16= constant 999
 336 call writeLineAcc16
 337 ;test15.j(62)   if (0x07 ^ b1 == 0x1B) println (27); else println (999);
 338 acc8= constant 7
 339 acc8Xor variable 0
 340 acc8Comp constant 27
 341 brne 345
 342 acc8= constant 27
 343 call writeLineAcc8
 344 br 349
 345 acc16= constant 999
 346 call writeLineAcc16
 347 ;test15.j(63)   //constant word/var word
 348 ;test15.j(64)   if (0x1234 & w1 == 0x0224) println (28); else println (999);
 349 acc16= constant 4660
 350 acc16And variable 2
 351 acc16Comp constant 548
 352 brne 356
 353 acc8= constant 28
 354 call writeLineAcc8
 355 br 359
 356 acc16= constant 999
 357 call writeLineAcc16
 358 ;test15.j(65)   if (0x1234 | w1 == 0x133C) println (29); else println (999);
 359 acc16= constant 4660
 360 acc16Or variable 2
 361 acc16Comp constant 4924
 362 brne 366
 363 acc8= constant 29
 364 call writeLineAcc8
 365 br 369
 366 acc16= constant 999
 367 call writeLineAcc16
 368 ;test15.j(66)   if (0x1234 ^ w1 == 0x1118) println (30); else println (999);
 369 acc16= constant 4660
 370 acc16Xor variable 2
 371 acc16Comp constant 4376
 372 brne 376
 373 acc8= constant 30
 374 call writeLineAcc8
 375 br 380
 376 acc16= constant 999
 377 call writeLineAcc16
 378 ;test15.j(67)   //constant byt/var word
 379 ;test15.j(68)   if (0x1C & w2 == 0x0014) println (31); else println (999);
 380 acc8= constant 28
 381 acc8ToAcc16
 382 acc16And variable 4
 383 acc8= constant 20
 384 acc16CompareAcc8
 385 brne 389
 386 acc8= constant 31
 387 call writeLineAcc8
 388 br 392
 389 acc16= constant 999
 390 call writeLineAcc16
 391 ;test15.j(69)   if (0x1C | w2 == 0x123C) println (32); else println (999);
 392 acc8= constant 28
 393 acc8ToAcc16
 394 acc16Or variable 4
 395 acc16Comp constant 4668
 396 brne 400
 397 acc8= constant 32
 398 call writeLineAcc8
 399 br 403
 400 acc16= constant 999
 401 call writeLineAcc16
 402 ;test15.j(70)   if (0x1C ^ w2 == 0x1228) println (33); else println (999);
 403 acc8= constant 28
 404 acc8ToAcc16
 405 acc16Xor variable 4
 406 acc16Comp constant 4648
 407 brne 411
 408 acc8= constant 33
 409 call writeLineAcc8
 410 br 415
 411 acc16= constant 999
 412 call writeLineAcc16
 413 ;test15.j(71)   //constant word/var byt
 414 ;test15.j(72)   if (0x1234 & b1 == 0x0014) println (34); else println (999);
 415 acc16= constant 4660
 416 acc16And variable 0
 417 acc8= constant 20
 418 acc16CompareAcc8
 419 brne 423
 420 acc8= constant 34
 421 call writeLineAcc8
 422 br 426
 423 acc16= constant 999
 424 call writeLineAcc16
 425 ;test15.j(73)   if (0x1234 | b1 == 0x123C) println (35); else println (999);
 426 acc16= constant 4660
 427 acc16Or variable 0
 428 acc16Comp constant 4668
 429 brne 433
 430 acc8= constant 35
 431 call writeLineAcc8
 432 br 436
 433 acc16= constant 999
 434 call writeLineAcc16
 435 ;test15.j(74)   if (0x1234 ^ b1 == 0x1228) println (36); else println (999);
 436 acc16= constant 4660
 437 acc16Xor variable 0
 438 acc16Comp constant 4648
 439 brne 443
 440 acc8= constant 36
 441 call writeLineAcc8
 442 br 450
 443 acc16= constant 999
 444 call writeLineAcc16
 445 ;test15.j(75) 
 446 ;test15.j(76)   //constant/final var
 447 ;test15.j(77)   //*****************
 448 ;test15.j(78)   //constant byte/final var byte
 449 ;test15.j(79)   if (0x07 & fb1 == 0x04) println (37); else println (999);
 450 acc8= constant 7
 451 acc8And constant 28
 452 acc8Comp constant 4
 453 brne 457
 454 acc8= constant 37
 455 call writeLineAcc8
 456 br 460
 457 acc16= constant 999
 458 call writeLineAcc16
 459 ;test15.j(80)   if (0x07 | fb1 == 0x1F) println (38); else println (999);
 460 acc8= constant 7
 461 acc8Or constant 28
 462 acc8Comp constant 31
 463 brne 467
 464 acc8= constant 38
 465 call writeLineAcc8
 466 br 470
 467 acc16= constant 999
 468 call writeLineAcc16
 469 ;test15.j(81)   if (0x07 ^ fb1 == 0x1B) println (39); else println (999);
 470 acc8= constant 7
 471 acc8Xor constant 28
 472 acc8Comp constant 27
 473 brne 477
 474 acc8= constant 39
 475 call writeLineAcc8
 476 br 481
 477 acc16= constant 999
 478 call writeLineAcc16
 479 ;test15.j(82)   //constant word/final var word
 480 ;test15.j(83)   if (0x1234 & fw1 == 0x0224) println (40); else println (999);
 481 acc16= constant 4660
 482 acc16And constant 812
 483 acc16Comp constant 548
 484 brne 488
 485 acc8= constant 40
 486 call writeLineAcc8
 487 br 491
 488 acc16= constant 999
 489 call writeLineAcc16
 490 ;test15.j(84)   if (0x1234 | fw1 == 0x133C) println (41); else println (999);
 491 acc16= constant 4660
 492 acc16Or constant 812
 493 acc16Comp constant 4924
 494 brne 498
 495 acc8= constant 41
 496 call writeLineAcc8
 497 br 501
 498 acc16= constant 999
 499 call writeLineAcc16
 500 ;test15.j(85)   if (0x1234 ^ fw1 == 0x1118) println (42); else println (999);
 501 acc16= constant 4660
 502 acc16Xor constant 812
 503 acc16Comp constant 4376
 504 brne 508
 505 acc8= constant 42
 506 call writeLineAcc8
 507 br 512
 508 acc16= constant 999
 509 call writeLineAcc16
 510 ;test15.j(86)   //constant byt/final var word
 511 ;test15.j(87)   if (0x1C & fw2 == 0x0014) println (43); else println (999);
 512 acc8= constant 28
 513 acc8ToAcc16
 514 acc16And constant 4660
 515 acc8= constant 20
 516 acc16CompareAcc8
 517 brne 521
 518 acc8= constant 43
 519 call writeLineAcc8
 520 br 524
 521 acc16= constant 999
 522 call writeLineAcc16
 523 ;test15.j(88)   if (0x1C | fw2 == 0x123C) println (44); else println (999);
 524 acc8= constant 28
 525 acc8ToAcc16
 526 acc16Or constant 4660
 527 acc16Comp constant 4668
 528 brne 532
 529 acc8= constant 44
 530 call writeLineAcc8
 531 br 535
 532 acc16= constant 999
 533 call writeLineAcc16
 534 ;test15.j(89)   if (0x1C ^ fw2 == 0x1228) println (45); else println (999);
 535 acc8= constant 28
 536 acc8ToAcc16
 537 acc16Xor constant 4660
 538 acc16Comp constant 4648
 539 brne 543
 540 acc8= constant 45
 541 call writeLineAcc8
 542 br 547
 543 acc16= constant 999
 544 call writeLineAcc16
 545 ;test15.j(90)   //constant word/final var byt
 546 ;test15.j(91)   if (0x1234 & fb1 == 0x0014) println (46); else println (999);
 547 acc16= constant 4660
 548 acc16And constant 28
 549 acc8= constant 20
 550 acc16CompareAcc8
 551 brne 555
 552 acc8= constant 46
 553 call writeLineAcc8
 554 br 558
 555 acc16= constant 999
 556 call writeLineAcc16
 557 ;test15.j(92)   if (0x1234 | fb1 == 0x123C) println (47); else println (999);
 558 acc16= constant 4660
 559 acc16Or constant 28
 560 acc16Comp constant 4668
 561 brne 565
 562 acc8= constant 47
 563 call writeLineAcc8
 564 br 568
 565 acc16= constant 999
 566 call writeLineAcc16
 567 ;test15.j(93)   if (0x1234 ^ fb1 == 0x1228) println (48); else println (999);
 568 acc16= constant 4660
 569 acc16Xor constant 28
 570 acc16Comp constant 4648
 571 brne 575
 572 acc8= constant 48
 573 call writeLineAcc8
 574 br 582
 575 acc16= constant 999
 576 call writeLineAcc16
 577 ;test15.j(94) 
 578 ;test15.j(95)   //acc/constant
 579 ;test15.j(96)   //************
 580 ;test15.j(97)   //acc byte/constant byte
 581 ;test15.j(98)   if ((0x04 + 0x03) & 0x1C == 0x04) println (49); else println (999);
 582 acc8= constant 4
 583 acc8+ constant 3
 584 acc8And constant 28
 585 acc8Comp constant 4
 586 brne 590
 587 acc8= constant 49
 588 call writeLineAcc8
 589 br 593
 590 acc16= constant 999
 591 call writeLineAcc16
 592 ;test15.j(99)   if ((0x04 + 0x03) | 0x1C == 0x1F) println (50); else println (999);
 593 acc8= constant 4
 594 acc8+ constant 3
 595 acc8Or constant 28
 596 acc8Comp constant 31
 597 brne 601
 598 acc8= constant 50
 599 call writeLineAcc8
 600 br 604
 601 acc16= constant 999
 602 call writeLineAcc16
 603 ;test15.j(100)   if ((0x04 + 0x03) ^ 0x1C == 0x1B) println (51); else println (999);
 604 acc8= constant 4
 605 acc8+ constant 3
 606 acc8Xor constant 28
 607 acc8Comp constant 27
 608 brne 612
 609 acc8= constant 51
 610 call writeLineAcc8
 611 br 616
 612 acc16= constant 999
 613 call writeLineAcc16
 614 ;test15.j(101)   //acc word/constant word
 615 ;test15.j(102)   if (0x1000 + 0x0234 & 0x032C == 0x0224) println (52); else println (999);
 616 acc16= constant 4096
 617 acc16+ constant 564
 618 acc16And constant 812
 619 acc16Comp constant 548
 620 brne 624
 621 acc8= constant 52
 622 call writeLineAcc8
 623 br 627
 624 acc16= constant 999
 625 call writeLineAcc16
 626 ;test15.j(103)   if (0x1000 + 0x0234 | 0x032C == 0x133C) println (53); else println (999);
 627 acc16= constant 4096
 628 acc16+ constant 564
 629 acc16Or constant 812
 630 acc16Comp constant 4924
 631 brne 635
 632 acc8= constant 53
 633 call writeLineAcc8
 634 br 638
 635 acc16= constant 999
 636 call writeLineAcc16
 637 ;test15.j(104)   if (0x1000 + 0x0234 ^ 0x032C == 0x1118) println (54); else println (999);
 638 acc16= constant 4096
 639 acc16+ constant 564
 640 acc16Xor constant 812
 641 acc16Comp constant 4376
 642 brne 646
 643 acc8= constant 54
 644 call writeLineAcc8
 645 br 650
 646 acc16= constant 999
 647 call writeLineAcc16
 648 ;test15.j(105)   //acc byt/constant word
 649 ;test15.j(106)   if (0x10 + 0x0C & 0x1234 == 0x0014) println (55); else println (999);
 650 acc8= constant 16
 651 acc8+ constant 12
 652 acc8ToAcc16
 653 acc16And constant 4660
 654 acc8= constant 20
 655 acc16CompareAcc8
 656 brne 660
 657 acc8= constant 55
 658 call writeLineAcc8
 659 br 663
 660 acc16= constant 999
 661 call writeLineAcc16
 662 ;test15.j(107)   if (0x10 + 0x0C | 0x1234 == 0x123C) println (56); else println (999);
 663 acc8= constant 16
 664 acc8+ constant 12
 665 acc8ToAcc16
 666 acc16Or constant 4660
 667 acc16Comp constant 4668
 668 brne 672
 669 acc8= constant 56
 670 call writeLineAcc8
 671 br 675
 672 acc16= constant 999
 673 call writeLineAcc16
 674 ;test15.j(108)   if (0x10 + 0x0C ^ 0x1234 == 0x1228) println (57); else println (999);
 675 acc8= constant 16
 676 acc8+ constant 12
 677 acc8ToAcc16
 678 acc16Xor constant 4660
 679 acc16Comp constant 4648
 680 brne 684
 681 acc8= constant 57
 682 call writeLineAcc8
 683 br 688
 684 acc16= constant 999
 685 call writeLineAcc16
 686 ;test15.j(109)   //acc word/constant byt
 687 ;test15.j(110)   if (0x1000 + 0x0234 & 0x1C == 0x0014) println (58); else println (999);
 688 acc16= constant 4096
 689 acc16+ constant 564
 690 acc16And constant 28
 691 acc8= constant 20
 692 acc16CompareAcc8
 693 brne 697
 694 acc8= constant 58
 695 call writeLineAcc8
 696 br 700
 697 acc16= constant 999
 698 call writeLineAcc16
 699 ;test15.j(111)   if (0x1000 + 0x0234 | 0x1C == 0x123C) println (59); else println (999);
 700 acc16= constant 4096
 701 acc16+ constant 564
 702 acc16Or constant 28
 703 acc16Comp constant 4668
 704 brne 708
 705 acc8= constant 59
 706 call writeLineAcc8
 707 br 711
 708 acc16= constant 999
 709 call writeLineAcc16
 710 ;test15.j(112)   if (0x1000 + 0x0234 ^ 0x1C == 0x1228) println (60); else println (999);
 711 acc16= constant 4096
 712 acc16+ constant 564
 713 acc16Xor constant 28
 714 acc16Comp constant 4648
 715 brne 719
 716 acc8= constant 60
 717 call writeLineAcc8
 718 br 726
 719 acc16= constant 999
 720 call writeLineAcc16
 721 ;test15.j(113) 
 722 ;test15.j(114)   //acc/acc
 723 ;test15.j(115)   //*******
 724 ;test15.j(116)   //acc byte/acc byte
 725 ;test15.j(117)   if (0x04 + 0x03 & 0x10 + 0x0C == 0x04) println (61); else println (999);
 726 acc8= constant 4
 727 acc8+ constant 3
 728 <acc8= constant 16
 729 acc8+ constant 12
 730 acc8And unstack8
 731 acc8Comp constant 4
 732 brne 736
 733 acc8= constant 61
 734 call writeLineAcc8
 735 br 739
 736 acc16= constant 999
 737 call writeLineAcc16
 738 ;test15.j(118)   if (0x04 + 0x03 | 0x10 + 0x0C == 0x1F) println (62); else println (999);
 739 acc8= constant 4
 740 acc8+ constant 3
 741 <acc8= constant 16
 742 acc8+ constant 12
 743 acc8Or unstack8
 744 acc8Comp constant 31
 745 brne 749
 746 acc8= constant 62
 747 call writeLineAcc8
 748 br 752
 749 acc16= constant 999
 750 call writeLineAcc16
 751 ;test15.j(119)   if (0x04 + 0x03 ^ 0x10 + 0x0C == 0x1B) println (63); else println (999);
 752 acc8= constant 4
 753 acc8+ constant 3
 754 <acc8= constant 16
 755 acc8+ constant 12
 756 acc8Xor unstack8
 757 acc8Comp constant 27
 758 brne 762
 759 acc8= constant 63
 760 call writeLineAcc8
 761 br 766
 762 acc16= constant 999
 763 call writeLineAcc16
 764 ;test15.j(120)   //acc word/acc word
 765 ;test15.j(121)   if (0x1234 & 0x0100 + 0x022C == 0x0224) println (64); else println (999);
 766 acc16= constant 4660
 767 <acc16= constant 256
 768 acc16+ constant 556
 769 acc16And unstack16
 770 acc16Comp constant 548
 771 brne 775
 772 acc8= constant 64
 773 call writeLineAcc8
 774 br 778
 775 acc16= constant 999
 776 call writeLineAcc16
 777 ;test15.j(122)   if (0x1234 | 0x0100 + 0x022C == 0x133C) println (65); else println (999);
 778 acc16= constant 4660
 779 <acc16= constant 256
 780 acc16+ constant 556
 781 acc16Or unstack16
 782 acc16Comp constant 4924
 783 brne 787
 784 acc8= constant 65
 785 call writeLineAcc8
 786 br 790
 787 acc16= constant 999
 788 call writeLineAcc16
 789 ;test15.j(123)   if (0x1234 ^ 0x0100 + 0x022C == 0x1118) println (66); else println (999);
 790 acc16= constant 4660
 791 <acc16= constant 256
 792 acc16+ constant 556
 793 acc16Xor unstack16
 794 acc16Comp constant 4376
 795 brne 799
 796 acc8= constant 66
 797 call writeLineAcc8
 798 br 803
 799 acc16= constant 999
 800 call writeLineAcc16
 801 ;test15.j(124)   //acc byt/acc word
 802 ;test15.j(125)   if (0x10 + 0x0C & 0x1000 + 0x0234 == 0x0014) println (67); else println (999);
 803 acc8= constant 16
 804 acc8+ constant 12
 805 acc16= constant 4096
 806 acc16+ constant 564
 807 acc16And acc8
 808 acc8= constant 20
 809 acc16CompareAcc8
 810 brne 814
 811 acc8= constant 67
 812 call writeLineAcc8
 813 br 817
 814 acc16= constant 999
 815 call writeLineAcc16
 816 ;test15.j(126)   if (0x10 + 0x0C | 0x1000 + 0x0234 == 0x123C) println (68); else println (999);
 817 acc8= constant 16
 818 acc8+ constant 12
 819 acc16= constant 4096
 820 acc16+ constant 564
 821 acc16Or acc8
 822 acc16Comp constant 4668
 823 brne 827
 824 acc8= constant 68
 825 call writeLineAcc8
 826 br 830
 827 acc16= constant 999
 828 call writeLineAcc16
 829 ;test15.j(127)   if (0x10 + 0x0C ^ 0x1000 + 0x0234 == 0x1228) println (69); else println (999);
 830 acc8= constant 16
 831 acc8+ constant 12
 832 acc16= constant 4096
 833 acc16+ constant 564
 834 acc16Xor acc8
 835 acc16Comp constant 4648
 836 brne 840
 837 acc8= constant 69
 838 call writeLineAcc8
 839 br 844
 840 acc16= constant 999
 841 call writeLineAcc16
 842 ;test15.j(128)   //acc word/acc byt
 843 ;test15.j(129)   if (0x1234 & 0x10 + 0x0C == 0x0014) println (70); else println (999);
 844 acc16= constant 4660
 845 acc8= constant 16
 846 acc8+ constant 12
 847 acc16And acc8
 848 acc8= constant 20
 849 acc16CompareAcc8
 850 brne 854
 851 acc8= constant 70
 852 call writeLineAcc8
 853 br 857
 854 acc16= constant 999
 855 call writeLineAcc16
 856 ;test15.j(130)   if (0x1234 | 0x10 + 0x0C == 0x123C) println (71); else println (999);
 857 acc16= constant 4660
 858 acc8= constant 16
 859 acc8+ constant 12
 860 acc16Or acc8
 861 acc16Comp constant 4668
 862 brne 866
 863 acc8= constant 71
 864 call writeLineAcc8
 865 br 869
 866 acc16= constant 999
 867 call writeLineAcc16
 868 ;test15.j(131)   if (0x1234 ^ 0x10 + 0x0C == 0x1228) println (72); else println (999);
 869 acc16= constant 4660
 870 acc8= constant 16
 871 acc8+ constant 12
 872 acc16Xor acc8
 873 acc16Comp constant 4648
 874 brne 878
 875 acc8= constant 72
 876 call writeLineAcc8
 877 br 885
 878 acc16= constant 999
 879 call writeLineAcc16
 880 ;test15.j(132) 
 881 ;test15.j(133)   //acc/var
 882 ;test15.j(134)   //*******
 883 ;test15.j(135)   //acc byte/var byte
 884 ;test15.j(136)   if (0x04 + 0x03 & b1 == 0x04) println (73); else println (999);
 885 acc8= constant 4
 886 acc8+ constant 3
 887 acc8And variable 0
 888 acc8Comp constant 4
 889 brne 893
 890 acc8= constant 73
 891 call writeLineAcc8
 892 br 896
 893 acc16= constant 999
 894 call writeLineAcc16
 895 ;test15.j(137)   if (0x04 + 0x03 | b1 == 0x1F) println (74); else println (999);
 896 acc8= constant 4
 897 acc8+ constant 3
 898 acc8Or variable 0
 899 acc8Comp constant 31
 900 brne 904
 901 acc8= constant 74
 902 call writeLineAcc8
 903 br 907
 904 acc16= constant 999
 905 call writeLineAcc16
 906 ;test15.j(138)   if (0x04 + 0x03 ^ b1 == 0x1B) println (75); else println (999);
 907 acc8= constant 4
 908 acc8+ constant 3
 909 acc8Xor variable 0
 910 acc8Comp constant 27
 911 brne 915
 912 acc8= constant 75
 913 call writeLineAcc8
 914 br 919
 915 acc16= constant 999
 916 call writeLineAcc16
 917 ;test15.j(139)   //acc word/var word
 918 ;test15.j(140)   if (0x1000 + 0x0234 & w1 == 0x0224) println (76); else println (999);
 919 acc16= constant 4096
 920 acc16+ constant 564
 921 acc16And variable 2
 922 acc16Comp constant 548
 923 brne 927
 924 acc8= constant 76
 925 call writeLineAcc8
 926 br 930
 927 acc16= constant 999
 928 call writeLineAcc16
 929 ;test15.j(141)   if (0x1000 + 0x0234 | w1 == 0x133C) println (77); else println (999);
 930 acc16= constant 4096
 931 acc16+ constant 564
 932 acc16Or variable 2
 933 acc16Comp constant 4924
 934 brne 938
 935 acc8= constant 77
 936 call writeLineAcc8
 937 br 941
 938 acc16= constant 999
 939 call writeLineAcc16
 940 ;test15.j(142)   if (0x1000 + 0x0234 ^ w1 == 0x1118) println (78); else println (999);
 941 acc16= constant 4096
 942 acc16+ constant 564
 943 acc16Xor variable 2
 944 acc16Comp constant 4376
 945 brne 949
 946 acc8= constant 78
 947 call writeLineAcc8
 948 br 953
 949 acc16= constant 999
 950 call writeLineAcc16
 951 ;test15.j(143)   //acc byt/var word
 952 ;test15.j(144)   if (0x10 + 0x0C & w2 == 0x0014) println (79); else println (999);
 953 acc8= constant 16
 954 acc8+ constant 12
 955 acc8ToAcc16
 956 acc16And variable 4
 957 acc8= constant 20
 958 acc16CompareAcc8
 959 brne 963
 960 acc8= constant 79
 961 call writeLineAcc8
 962 br 966
 963 acc16= constant 999
 964 call writeLineAcc16
 965 ;test15.j(145)   if (0x10 + 0x0C | w2 == 0x123C) println (80); else println (999);
 966 acc8= constant 16
 967 acc8+ constant 12
 968 acc8ToAcc16
 969 acc16Or variable 4
 970 acc16Comp constant 4668
 971 brne 975
 972 acc8= constant 80
 973 call writeLineAcc8
 974 br 978
 975 acc16= constant 999
 976 call writeLineAcc16
 977 ;test15.j(146)   if (0x10 + 0x0C ^ w2 == 0x1228) println (81); else println (999);
 978 acc8= constant 16
 979 acc8+ constant 12
 980 acc8ToAcc16
 981 acc16Xor variable 4
 982 acc16Comp constant 4648
 983 brne 987
 984 acc8= constant 81
 985 call writeLineAcc8
 986 br 991
 987 acc16= constant 999
 988 call writeLineAcc16
 989 ;test15.j(147)   //acc word/var byt
 990 ;test15.j(148)   if (0x1000 + 0x0234 & b1 == 0x0014) println (82); else println (999);
 991 acc16= constant 4096
 992 acc16+ constant 564
 993 acc16And variable 0
 994 acc8= constant 20
 995 acc16CompareAcc8
 996 brne 1000
 997 acc8= constant 82
 998 call writeLineAcc8
 999 br 1003
1000 acc16= constant 999
1001 call writeLineAcc16
1002 ;test15.j(149)   if (0x1000 + 0x0234 | b1 == 0x123C) println (83); else println (999);
1003 acc16= constant 4096
1004 acc16+ constant 564
1005 acc16Or variable 0
1006 acc16Comp constant 4668
1007 brne 1011
1008 acc8= constant 83
1009 call writeLineAcc8
1010 br 1014
1011 acc16= constant 999
1012 call writeLineAcc16
1013 ;test15.j(150)   if (0x1000 + 0x0234 ^ b1 == 0x1228) println (84); else println (999);
1014 acc16= constant 4096
1015 acc16+ constant 564
1016 acc16Xor variable 0
1017 acc16Comp constant 4648
1018 brne 1022
1019 acc8= constant 84
1020 call writeLineAcc8
1021 br 1029
1022 acc16= constant 999
1023 call writeLineAcc16
1024 ;test15.j(151) 
1025 ;test15.j(152)   //acc/final var
1026 ;test15.j(153)   //*************
1027 ;test15.j(154)   //acc byte/final var byte
1028 ;test15.j(155)   if (0x04 + 0x03 & fb1 == 0x04) println (85); else println (999);
1029 acc8= constant 4
1030 acc8+ constant 3
1031 acc8And constant 28
1032 acc8Comp constant 4
1033 brne 1037
1034 acc8= constant 85
1035 call writeLineAcc8
1036 br 1040
1037 acc16= constant 999
1038 call writeLineAcc16
1039 ;test15.j(156)   if (0x04 + 0x03 | fb1 == 0x1F) println (86); else println (999);
1040 acc8= constant 4
1041 acc8+ constant 3
1042 acc8Or constant 28
1043 acc8Comp constant 31
1044 brne 1048
1045 acc8= constant 86
1046 call writeLineAcc8
1047 br 1051
1048 acc16= constant 999
1049 call writeLineAcc16
1050 ;test15.j(157)   if (0x04 + 0x03 ^ fb1 == 0x1B) println (87); else println (999);
1051 acc8= constant 4
1052 acc8+ constant 3
1053 acc8Xor constant 28
1054 acc8Comp constant 27
1055 brne 1059
1056 acc8= constant 87
1057 call writeLineAcc8
1058 br 1063
1059 acc16= constant 999
1060 call writeLineAcc16
1061 ;test15.j(158)   //acc word/final var word
1062 ;test15.j(159)   if (0x1000 + 0x0234 & fw1 == 0x0224) println (88); else println (999);
1063 acc16= constant 4096
1064 acc16+ constant 564
1065 acc16And constant 812
1066 acc16Comp constant 548
1067 brne 1071
1068 acc8= constant 88
1069 call writeLineAcc8
1070 br 1074
1071 acc16= constant 999
1072 call writeLineAcc16
1073 ;test15.j(160)   if (0x1000 + 0x0234 | fw1 == 0x133C) println (89); else println (999);
1074 acc16= constant 4096
1075 acc16+ constant 564
1076 acc16Or constant 812
1077 acc16Comp constant 4924
1078 brne 1082
1079 acc8= constant 89
1080 call writeLineAcc8
1081 br 1085
1082 acc16= constant 999
1083 call writeLineAcc16
1084 ;test15.j(161)   if (0x1000 + 0x0234 ^ fw1 == 0x1118) println (90); else println (999);
1085 acc16= constant 4096
1086 acc16+ constant 564
1087 acc16Xor constant 812
1088 acc16Comp constant 4376
1089 brne 1093
1090 acc8= constant 90
1091 call writeLineAcc8
1092 br 1097
1093 acc16= constant 999
1094 call writeLineAcc16
1095 ;test15.j(162)   //acc byt/final var word
1096 ;test15.j(163)   if (0x10 + 0x0C & fw2 == 0x0014) println (91); else println (999);
1097 acc8= constant 16
1098 acc8+ constant 12
1099 acc8ToAcc16
1100 acc16And constant 4660
1101 acc8= constant 20
1102 acc16CompareAcc8
1103 brne 1107
1104 acc8= constant 91
1105 call writeLineAcc8
1106 br 1110
1107 acc16= constant 999
1108 call writeLineAcc16
1109 ;test15.j(164)   if (0x10 + 0x0C | fw2 == 0x123C) println (92); else println (999);
1110 acc8= constant 16
1111 acc8+ constant 12
1112 acc8ToAcc16
1113 acc16Or constant 4660
1114 acc16Comp constant 4668
1115 brne 1119
1116 acc8= constant 92
1117 call writeLineAcc8
1118 br 1122
1119 acc16= constant 999
1120 call writeLineAcc16
1121 ;test15.j(165)   if (0x10 + 0x0C ^ fw2 == 0x1228) println (93); else println (999);
1122 acc8= constant 16
1123 acc8+ constant 12
1124 acc8ToAcc16
1125 acc16Xor constant 4660
1126 acc16Comp constant 4648
1127 brne 1131
1128 acc8= constant 93
1129 call writeLineAcc8
1130 br 1135
1131 acc16= constant 999
1132 call writeLineAcc16
1133 ;test15.j(166)   //acc word/final var byt
1134 ;test15.j(167)   if (0x1000 + 0x0234 & fb1 == 0x0014) println (94); else println (999);
1135 acc16= constant 4096
1136 acc16+ constant 564
1137 acc16And constant 28
1138 acc8= constant 20
1139 acc16CompareAcc8
1140 brne 1144
1141 acc8= constant 94
1142 call writeLineAcc8
1143 br 1147
1144 acc16= constant 999
1145 call writeLineAcc16
1146 ;test15.j(168)   if (0x1000 + 0x0234 | fb1 == 0x123C) println (95); else println (999);
1147 acc16= constant 4096
1148 acc16+ constant 564
1149 acc16Or constant 28
1150 acc16Comp constant 4668
1151 brne 1155
1152 acc8= constant 95
1153 call writeLineAcc8
1154 br 1158
1155 acc16= constant 999
1156 call writeLineAcc16
1157 ;test15.j(169)   if (0x1000 + 0x0234 ^ fb1 == 0x1228) println (96); else println (999);
1158 acc16= constant 4096
1159 acc16+ constant 564
1160 acc16Xor constant 28
1161 acc16Comp constant 4648
1162 brne 1166
1163 acc8= constant 96
1164 call writeLineAcc8
1165 br 1173
1166 acc16= constant 999
1167 call writeLineAcc16
1168 ;test15.j(170) 
1169 ;test15.j(171)   //var/constant
1170 ;test15.j(172)   //************
1171 ;test15.j(173)   //var byte/constant byte
1172 ;test15.j(174)   if (b2 & 0x1C == 0x04) println (97); else println (999);
1173 acc8= variable 1
1174 acc8And constant 28
1175 acc8Comp constant 4
1176 brne 1180
1177 acc8= constant 97
1178 call writeLineAcc8
1179 br 1183
1180 acc16= constant 999
1181 call writeLineAcc16
1182 ;test15.j(175)   if (b2 | 0x1C == 0x1F) println (98); else println (999);
1183 acc8= variable 1
1184 acc8Or constant 28
1185 acc8Comp constant 31
1186 brne 1190
1187 acc8= constant 98
1188 call writeLineAcc8
1189 br 1193
1190 acc16= constant 999
1191 call writeLineAcc16
1192 ;test15.j(176)   if (b2 ^ 0x1C == 0x1B) println (99); else println (999);
1193 acc8= variable 1
1194 acc8Xor constant 28
1195 acc8Comp constant 27
1196 brne 1200
1197 acc8= constant 99
1198 call writeLineAcc8
1199 br 1204
1200 acc16= constant 999
1201 call writeLineAcc16
1202 ;test15.j(177)   //var word/constant word
1203 ;test15.j(178)   if (w2 & 0x032C == 0x0224) println (100); else println (999);
1204 acc16= variable 4
1205 acc16And constant 812
1206 acc16Comp constant 548
1207 brne 1211
1208 acc8= constant 100
1209 call writeLineAcc8
1210 br 1214
1211 acc16= constant 999
1212 call writeLineAcc16
1213 ;test15.j(179)   if (w2 | 0x032C == 0x133C) println (101); else println (999);
1214 acc16= variable 4
1215 acc16Or constant 812
1216 acc16Comp constant 4924
1217 brne 1221
1218 acc8= constant 101
1219 call writeLineAcc8
1220 br 1224
1221 acc16= constant 999
1222 call writeLineAcc16
1223 ;test15.j(180)   if (w2 ^ 0x032C == 0x1118) println (102); else println (999);
1224 acc16= variable 4
1225 acc16Xor constant 812
1226 acc16Comp constant 4376
1227 brne 1231
1228 acc8= constant 102
1229 call writeLineAcc8
1230 br 1235
1231 acc16= constant 999
1232 call writeLineAcc16
1233 ;test15.j(181)   //var byt/constant word
1234 ;test15.j(182)   if (b1 & 0x1234 == 0x0014) println (103); else println (999);
1235 acc8= variable 0
1236 acc8ToAcc16
1237 acc16And constant 4660
1238 acc8= constant 20
1239 acc16CompareAcc8
1240 brne 1244
1241 acc8= constant 103
1242 call writeLineAcc8
1243 br 1247
1244 acc16= constant 999
1245 call writeLineAcc16
1246 ;test15.j(183)   if (b1 | 0x1234 == 0x123C) println (104); else println (999);
1247 acc8= variable 0
1248 acc8ToAcc16
1249 acc16Or constant 4660
1250 acc16Comp constant 4668
1251 brne 1255
1252 acc8= constant 104
1253 call writeLineAcc8
1254 br 1258
1255 acc16= constant 999
1256 call writeLineAcc16
1257 ;test15.j(184)   if (b1 ^ 0x1234 == 0x1228) println (105); else println (999);
1258 acc8= variable 0
1259 acc8ToAcc16
1260 acc16Xor constant 4660
1261 acc16Comp constant 4648
1262 brne 1266
1263 acc8= constant 105
1264 call writeLineAcc8
1265 br 1270
1266 acc16= constant 999
1267 call writeLineAcc16
1268 ;test15.j(185)   //var word/constant byt
1269 ;test15.j(186)   if (w2 & 0x1C == 0x0014) println (106); else println (999);
1270 acc16= variable 4
1271 acc16And constant 28
1272 acc8= constant 20
1273 acc16CompareAcc8
1274 brne 1278
1275 acc8= constant 106
1276 call writeLineAcc8
1277 br 1281
1278 acc16= constant 999
1279 call writeLineAcc16
1280 ;test15.j(187)   if (w2 | 0x1C == 0x123C) println (107); else println (999);
1281 acc16= variable 4
1282 acc16Or constant 28
1283 acc16Comp constant 4668
1284 brne 1288
1285 acc8= constant 107
1286 call writeLineAcc8
1287 br 1291
1288 acc16= constant 999
1289 call writeLineAcc16
1290 ;test15.j(188)   if (w2 ^ 0x1C == 0x1228) println (108); else println (999);
1291 acc16= variable 4
1292 acc16Xor constant 28
1293 acc16Comp constant 4648
1294 brne 1298
1295 acc8= constant 108
1296 call writeLineAcc8
1297 br 1305
1298 acc16= constant 999
1299 call writeLineAcc16
1300 ;test15.j(189) 
1301 ;test15.j(190)   //var/acc
1302 ;test15.j(191)   //*******
1303 ;test15.j(192)   //var byte/acc byte
1304 ;test15.j(193)   if (b2 & (0x10 + 0x0C) == 0x04) println (109); else println (999);
1305 acc8= variable 1
1306 <acc8= constant 16
1307 acc8+ constant 12
1308 acc8And unstack8
1309 acc8Comp constant 4
1310 brne 1314
1311 acc8= constant 109
1312 call writeLineAcc8
1313 br 1317
1314 acc16= constant 999
1315 call writeLineAcc16
1316 ;test15.j(194)   if (b2 | (0x10 + 0x0C) == 0x1F) println (110); else println (999);
1317 acc8= variable 1
1318 <acc8= constant 16
1319 acc8+ constant 12
1320 acc8Or unstack8
1321 acc8Comp constant 31
1322 brne 1326
1323 acc8= constant 110
1324 call writeLineAcc8
1325 br 1329
1326 acc16= constant 999
1327 call writeLineAcc16
1328 ;test15.j(195)   if (b2 ^ (0x10 + 0x0C) == 0x1B) println (111); else println (999);
1329 acc8= variable 1
1330 <acc8= constant 16
1331 acc8+ constant 12
1332 acc8Xor unstack8
1333 acc8Comp constant 27
1334 brne 1338
1335 acc8= constant 111
1336 call writeLineAcc8
1337 br 1342
1338 acc16= constant 999
1339 call writeLineAcc16
1340 ;test15.j(196)   //var word/acc word
1341 ;test15.j(197)   if (w2 & 0x0100 + 0x022C == 0x0224) println (112); else println (999);
1342 acc16= variable 4
1343 <acc16= constant 256
1344 acc16+ constant 556
1345 acc16And unstack16
1346 acc16Comp constant 548
1347 brne 1351
1348 acc8= constant 112
1349 call writeLineAcc8
1350 br 1354
1351 acc16= constant 999
1352 call writeLineAcc16
1353 ;test15.j(198)   if (w2 | 0x0100 + 0x022C == 0x133C) println (113); else println (999);
1354 acc16= variable 4
1355 <acc16= constant 256
1356 acc16+ constant 556
1357 acc16Or unstack16
1358 acc16Comp constant 4924
1359 brne 1363
1360 acc8= constant 113
1361 call writeLineAcc8
1362 br 1366
1363 acc16= constant 999
1364 call writeLineAcc16
1365 ;test15.j(199)   if (w2 ^ 0x0100 + 0x022C == 0x1118) println (114); else println (999);
1366 acc16= variable 4
1367 <acc16= constant 256
1368 acc16+ constant 556
1369 acc16Xor unstack16
1370 acc16Comp constant 4376
1371 brne 1375
1372 acc8= constant 114
1373 call writeLineAcc8
1374 br 1379
1375 acc16= constant 999
1376 call writeLineAcc16
1377 ;test15.j(200)   //var byt/acc word
1378 ;test15.j(201)   if (b1 & 0x1000 + 0x0234 == 0x0014) println (115); else println (999);
1379 acc8= variable 0
1380 acc16= constant 4096
1381 acc16+ constant 564
1382 acc16And acc8
1383 acc8= constant 20
1384 acc16CompareAcc8
1385 brne 1389
1386 acc8= constant 115
1387 call writeLineAcc8
1388 br 1392
1389 acc16= constant 999
1390 call writeLineAcc16
1391 ;test15.j(202)   if (b1 | 0x1000 + 0x0234 == 0x123C) println (116); else println (999);
1392 acc8= variable 0
1393 acc16= constant 4096
1394 acc16+ constant 564
1395 acc16Or acc8
1396 acc16Comp constant 4668
1397 brne 1401
1398 acc8= constant 116
1399 call writeLineAcc8
1400 br 1404
1401 acc16= constant 999
1402 call writeLineAcc16
1403 ;test15.j(203)   if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (117); else println (999);
1404 acc8= variable 0
1405 acc16= constant 4096
1406 acc16+ constant 564
1407 acc16Xor acc8
1408 acc16Comp constant 4648
1409 brne 1413
1410 acc8= constant 117
1411 call writeLineAcc8
1412 br 1417
1413 acc16= constant 999
1414 call writeLineAcc16
1415 ;test15.j(204)   //var word/acc byt
1416 ;test15.j(205)   if (w2 & 0x10 + 0x0C == 0x0014) println (118); else println (999);
1417 acc16= variable 4
1418 acc8= constant 16
1419 acc8+ constant 12
1420 acc16And acc8
1421 acc8= constant 20
1422 acc16CompareAcc8
1423 brne 1427
1424 acc8= constant 118
1425 call writeLineAcc8
1426 br 1430
1427 acc16= constant 999
1428 call writeLineAcc16
1429 ;test15.j(206)   if (w2 | 0x10 + 0x0C == 0x123C) println (119); else println (999);
1430 acc16= variable 4
1431 acc8= constant 16
1432 acc8+ constant 12
1433 acc16Or acc8
1434 acc16Comp constant 4668
1435 brne 1439
1436 acc8= constant 119
1437 call writeLineAcc8
1438 br 1442
1439 acc16= constant 999
1440 call writeLineAcc16
1441 ;test15.j(207)   if (w2 ^ 0x10 + 0x0C == 0x1228) println (120); else println (999);
1442 acc16= variable 4
1443 acc8= constant 16
1444 acc8+ constant 12
1445 acc16Xor acc8
1446 acc16Comp constant 4648
1447 brne 1451
1448 acc8= constant 120
1449 call writeLineAcc8
1450 br 1458
1451 acc16= constant 999
1452 call writeLineAcc16
1453 ;test15.j(208) 
1454 ;test15.j(209)   //var/var
1455 ;test15.j(210)   //*******
1456 ;test15.j(211)   //var byte/var byte
1457 ;test15.j(212)   if (b2 & b1 == 0x04) println (121); else println (999);
1458 acc8= variable 1
1459 acc8And variable 0
1460 acc8Comp constant 4
1461 brne 1465
1462 acc8= constant 121
1463 call writeLineAcc8
1464 br 1468
1465 acc16= constant 999
1466 call writeLineAcc16
1467 ;test15.j(213)   if (b2 | b1 == 0x1F) println (122); else println (999);
1468 acc8= variable 1
1469 acc8Or variable 0
1470 acc8Comp constant 31
1471 brne 1475
1472 acc8= constant 122
1473 call writeLineAcc8
1474 br 1478
1475 acc16= constant 999
1476 call writeLineAcc16
1477 ;test15.j(214)   if (b2 ^ b1 == 0x1B) println (123); else println (999);
1478 acc8= variable 1
1479 acc8Xor variable 0
1480 acc8Comp constant 27
1481 brne 1485
1482 acc8= constant 123
1483 call writeLineAcc8
1484 br 1489
1485 acc16= constant 999
1486 call writeLineAcc16
1487 ;test15.j(215)   //var word/var word
1488 ;test15.j(216)   if (w2 & w1 == 0x0224) println (124); else println (999);
1489 acc16= variable 4
1490 acc16And variable 2
1491 acc16Comp constant 548
1492 brne 1496
1493 acc8= constant 124
1494 call writeLineAcc8
1495 br 1499
1496 acc16= constant 999
1497 call writeLineAcc16
1498 ;test15.j(217)   if (w2 | w1 == 0x133C) println (125); else println (999);
1499 acc16= variable 4
1500 acc16Or variable 2
1501 acc16Comp constant 4924
1502 brne 1506
1503 acc8= constant 125
1504 call writeLineAcc8
1505 br 1509
1506 acc16= constant 999
1507 call writeLineAcc16
1508 ;test15.j(218)   if (w2 ^ w1 == 0x1118) println (126); else println (999);
1509 acc16= variable 4
1510 acc16Xor variable 2
1511 acc16Comp constant 4376
1512 brne 1516
1513 acc8= constant 126
1514 call writeLineAcc8
1515 br 1520
1516 acc16= constant 999
1517 call writeLineAcc16
1518 ;test15.j(219)   //var byt/var word
1519 ;test15.j(220)   if (b1 & w2 == 0x0014) println (127); else println (999);
1520 acc8= variable 0
1521 acc8ToAcc16
1522 acc16And variable 4
1523 acc8= constant 20
1524 acc16CompareAcc8
1525 brne 1529
1526 acc8= constant 127
1527 call writeLineAcc8
1528 br 1532
1529 acc16= constant 999
1530 call writeLineAcc16
1531 ;test15.j(221)   if (b1 | w2 == 0x123C) println (128); else println (999);
1532 acc8= variable 0
1533 acc8ToAcc16
1534 acc16Or variable 4
1535 acc16Comp constant 4668
1536 brne 1540
1537 acc8= constant 128
1538 call writeLineAcc8
1539 br 1543
1540 acc16= constant 999
1541 call writeLineAcc16
1542 ;test15.j(222)   if (b1 ^ w2 == 0x1228) println (129); else println (999);
1543 acc8= variable 0
1544 acc8ToAcc16
1545 acc16Xor variable 4
1546 acc16Comp constant 4648
1547 brne 1551
1548 acc8= constant 129
1549 call writeLineAcc8
1550 br 1555
1551 acc16= constant 999
1552 call writeLineAcc16
1553 ;test15.j(223)   //var word/var byt
1554 ;test15.j(224)   if (w2 & b1 == 0x0014) println (130); else println (999);
1555 acc16= variable 4
1556 acc16And variable 0
1557 acc8= constant 20
1558 acc16CompareAcc8
1559 brne 1563
1560 acc8= constant 130
1561 call writeLineAcc8
1562 br 1566
1563 acc16= constant 999
1564 call writeLineAcc16
1565 ;test15.j(225)   if (w2 | b1 == 0x123C) println (131); else println (999);
1566 acc16= variable 4
1567 acc16Or variable 0
1568 acc16Comp constant 4668
1569 brne 1573
1570 acc8= constant 131
1571 call writeLineAcc8
1572 br 1576
1573 acc16= constant 999
1574 call writeLineAcc16
1575 ;test15.j(226)   if (w2 ^ b1 == 0x1228) println (132); else println (999);
1576 acc16= variable 4
1577 acc16Xor variable 0
1578 acc16Comp constant 4648
1579 brne 1583
1580 acc8= constant 132
1581 call writeLineAcc8
1582 br 1590
1583 acc16= constant 999
1584 call writeLineAcc16
1585 ;test15.j(227) 
1586 ;test15.j(228)   //var/final var
1587 ;test15.j(229)   //*************
1588 ;test15.j(230)   //var byte/final var byte
1589 ;test15.j(231)   if (b2 & fb1 == 0x04) println (133); else println (999);
1590 acc8= variable 1
1591 acc8And constant 28
1592 acc8Comp constant 4
1593 brne 1597
1594 acc8= constant 133
1595 call writeLineAcc8
1596 br 1600
1597 acc16= constant 999
1598 call writeLineAcc16
1599 ;test15.j(232)   if (b2 | fb1 == 0x1F) println (134); else println (999);
1600 acc8= variable 1
1601 acc8Or constant 28
1602 acc8Comp constant 31
1603 brne 1607
1604 acc8= constant 134
1605 call writeLineAcc8
1606 br 1610
1607 acc16= constant 999
1608 call writeLineAcc16
1609 ;test15.j(233)   if (b2 ^ fb1 == 0x1B) println (135); else println (999);
1610 acc8= variable 1
1611 acc8Xor constant 28
1612 acc8Comp constant 27
1613 brne 1617
1614 acc8= constant 135
1615 call writeLineAcc8
1616 br 1621
1617 acc16= constant 999
1618 call writeLineAcc16
1619 ;test15.j(234)   //var word/final var word
1620 ;test15.j(235)   if (w2 & fw1 == 0x0224) println (136); else println (999);
1621 acc16= variable 4
1622 acc16And constant 812
1623 acc16Comp constant 548
1624 brne 1628
1625 acc8= constant 136
1626 call writeLineAcc8
1627 br 1631
1628 acc16= constant 999
1629 call writeLineAcc16
1630 ;test15.j(236)   if (w2 | fw1 == 0x133C) println (137); else println (999);
1631 acc16= variable 4
1632 acc16Or constant 812
1633 acc16Comp constant 4924
1634 brne 1638
1635 acc8= constant 137
1636 call writeLineAcc8
1637 br 1641
1638 acc16= constant 999
1639 call writeLineAcc16
1640 ;test15.j(237)   if (w2 ^ fw1 == 0x1118) println (138); else println (999);
1641 acc16= variable 4
1642 acc16Xor constant 812
1643 acc16Comp constant 4376
1644 brne 1648
1645 acc8= constant 138
1646 call writeLineAcc8
1647 br 1652
1648 acc16= constant 999
1649 call writeLineAcc16
1650 ;test15.j(238)   //var byt/final var word
1651 ;test15.j(239)   if (b1 & fw2 == 0x0014) println (139); else println (999);
1652 acc8= variable 0
1653 acc8ToAcc16
1654 acc16And constant 4660
1655 acc8= constant 20
1656 acc16CompareAcc8
1657 brne 1661
1658 acc8= constant 139
1659 call writeLineAcc8
1660 br 1664
1661 acc16= constant 999
1662 call writeLineAcc16
1663 ;test15.j(240)   if (b1 | fw2 == 0x123C) println (140); else println (999);
1664 acc8= variable 0
1665 acc8ToAcc16
1666 acc16Or constant 4660
1667 acc16Comp constant 4668
1668 brne 1672
1669 acc8= constant 140
1670 call writeLineAcc8
1671 br 1675
1672 acc16= constant 999
1673 call writeLineAcc16
1674 ;test15.j(241)   if (b1 ^ fw2 == 0x1228) println (141); else println (999);
1675 acc8= variable 0
1676 acc8ToAcc16
1677 acc16Xor constant 4660
1678 acc16Comp constant 4648
1679 brne 1683
1680 acc8= constant 141
1681 call writeLineAcc8
1682 br 1687
1683 acc16= constant 999
1684 call writeLineAcc16
1685 ;test15.j(242)   //var word/final var byt
1686 ;test15.j(243)   if (w2 & fb1 == 0x0014) println (142); else println (999);
1687 acc16= variable 4
1688 acc16And constant 28
1689 acc8= constant 20
1690 acc16CompareAcc8
1691 brne 1695
1692 acc8= constant 142
1693 call writeLineAcc8
1694 br 1698
1695 acc16= constant 999
1696 call writeLineAcc16
1697 ;test15.j(244)   if (w2 | fb1 == 0x123C) println (143); else println (999);
1698 acc16= variable 4
1699 acc16Or constant 28
1700 acc16Comp constant 4668
1701 brne 1705
1702 acc8= constant 143
1703 call writeLineAcc8
1704 br 1708
1705 acc16= constant 999
1706 call writeLineAcc16
1707 ;test15.j(245)   if (w2 ^ fb1 == 0x1228) println (144); else println (999);
1708 acc16= variable 4
1709 acc16Xor constant 28
1710 acc16Comp constant 4648
1711 brne 1715
1712 acc8= constant 144
1713 call writeLineAcc8
1714 br 1722
1715 acc16= constant 999
1716 call writeLineAcc16
1717 ;test15.j(246) 
1718 ;test15.j(247)   //final var/constant
1719 ;test15.j(248)   //******************
1720 ;test15.j(249)   //final var byte/constant byte
1721 ;test15.j(250)   if (b2 & 0x1C == 0x04) println (145); else println (999);
1722 acc8= variable 1
1723 acc8And constant 28
1724 acc8Comp constant 4
1725 brne 1729
1726 acc8= constant 145
1727 call writeLineAcc8
1728 br 1732
1729 acc16= constant 999
1730 call writeLineAcc16
1731 ;test15.j(251)   if (b2 | 0x1C == 0x1F) println (146); else println (999);
1732 acc8= variable 1
1733 acc8Or constant 28
1734 acc8Comp constant 31
1735 brne 1739
1736 acc8= constant 146
1737 call writeLineAcc8
1738 br 1742
1739 acc16= constant 999
1740 call writeLineAcc16
1741 ;test15.j(252)   if (b2 ^ 0x1C == 0x1B) println (147); else println (999);
1742 acc8= variable 1
1743 acc8Xor constant 28
1744 acc8Comp constant 27
1745 brne 1749
1746 acc8= constant 147
1747 call writeLineAcc8
1748 br 1753
1749 acc16= constant 999
1750 call writeLineAcc16
1751 ;test15.j(253)   //final var word/constant word
1752 ;test15.j(254)   if (w2 & 0x032C == 0x0224) println (148); else println (999);
1753 acc16= variable 4
1754 acc16And constant 812
1755 acc16Comp constant 548
1756 brne 1760
1757 acc8= constant 148
1758 call writeLineAcc8
1759 br 1763
1760 acc16= constant 999
1761 call writeLineAcc16
1762 ;test15.j(255)   if (w2 | 0x032C == 0x133C) println (149); else println (999);
1763 acc16= variable 4
1764 acc16Or constant 812
1765 acc16Comp constant 4924
1766 brne 1770
1767 acc8= constant 149
1768 call writeLineAcc8
1769 br 1773
1770 acc16= constant 999
1771 call writeLineAcc16
1772 ;test15.j(256)   if (w2 ^ 0x032C == 0x1118) println (150); else println (999);
1773 acc16= variable 4
1774 acc16Xor constant 812
1775 acc16Comp constant 4376
1776 brne 1780
1777 acc8= constant 150
1778 call writeLineAcc8
1779 br 1784
1780 acc16= constant 999
1781 call writeLineAcc16
1782 ;test15.j(257)   //final var byt/constant word
1783 ;test15.j(258)   if (b1 & 0x1234 == 0x0014) println (151); else println (999);
1784 acc8= variable 0
1785 acc8ToAcc16
1786 acc16And constant 4660
1787 acc8= constant 20
1788 acc16CompareAcc8
1789 brne 1793
1790 acc8= constant 151
1791 call writeLineAcc8
1792 br 1796
1793 acc16= constant 999
1794 call writeLineAcc16
1795 ;test15.j(259)   if (b1 | 0x1234 == 0x123C) println (152); else println (999);
1796 acc8= variable 0
1797 acc8ToAcc16
1798 acc16Or constant 4660
1799 acc16Comp constant 4668
1800 brne 1804
1801 acc8= constant 152
1802 call writeLineAcc8
1803 br 1807
1804 acc16= constant 999
1805 call writeLineAcc16
1806 ;test15.j(260)   if (b1 ^ 0x1234 == 0x1228) println (153); else println (999);
1807 acc8= variable 0
1808 acc8ToAcc16
1809 acc16Xor constant 4660
1810 acc16Comp constant 4648
1811 brne 1815
1812 acc8= constant 153
1813 call writeLineAcc8
1814 br 1819
1815 acc16= constant 999
1816 call writeLineAcc16
1817 ;test15.j(261)   //final var word/constant byt
1818 ;test15.j(262)   if (w2 & 0x1C == 0x0014) println (154); else println (999);
1819 acc16= variable 4
1820 acc16And constant 28
1821 acc8= constant 20
1822 acc16CompareAcc8
1823 brne 1827
1824 acc8= constant 154
1825 call writeLineAcc8
1826 br 1830
1827 acc16= constant 999
1828 call writeLineAcc16
1829 ;test15.j(263)   if (w2 | 0x1C == 0x123C) println (155); else println (999);
1830 acc16= variable 4
1831 acc16Or constant 28
1832 acc16Comp constant 4668
1833 brne 1837
1834 acc8= constant 155
1835 call writeLineAcc8
1836 br 1840
1837 acc16= constant 999
1838 call writeLineAcc16
1839 ;test15.j(264)   if (w2 ^ 0x1C == 0x1228) println (156); else println (999);
1840 acc16= variable 4
1841 acc16Xor constant 28
1842 acc16Comp constant 4648
1843 brne 1847
1844 acc8= constant 156
1845 call writeLineAcc8
1846 br 1854
1847 acc16= constant 999
1848 call writeLineAcc16
1849 ;test15.j(265) 
1850 ;test15.j(266)   //final var/acc
1851 ;test15.j(267)   //*************
1852 ;test15.j(268)   //final var byte/acc byte
1853 ;test15.j(269)   if (b2 & (0x10 + 0x0C) == 0x04) println (157); else println (999);
1854 acc8= variable 1
1855 <acc8= constant 16
1856 acc8+ constant 12
1857 acc8And unstack8
1858 acc8Comp constant 4
1859 brne 1863
1860 acc8= constant 157
1861 call writeLineAcc8
1862 br 1866
1863 acc16= constant 999
1864 call writeLineAcc16
1865 ;test15.j(270)   if (b2 | (0x10 + 0x0C) == 0x1F) println (158); else println (999);
1866 acc8= variable 1
1867 <acc8= constant 16
1868 acc8+ constant 12
1869 acc8Or unstack8
1870 acc8Comp constant 31
1871 brne 1875
1872 acc8= constant 158
1873 call writeLineAcc8
1874 br 1878
1875 acc16= constant 999
1876 call writeLineAcc16
1877 ;test15.j(271)   if (b2 ^ (0x10 + 0x0C) == 0x1B) println (159); else println (999);
1878 acc8= variable 1
1879 <acc8= constant 16
1880 acc8+ constant 12
1881 acc8Xor unstack8
1882 acc8Comp constant 27
1883 brne 1887
1884 acc8= constant 159
1885 call writeLineAcc8
1886 br 1891
1887 acc16= constant 999
1888 call writeLineAcc16
1889 ;test15.j(272)   //final var word/acc word
1890 ;test15.j(273)   if (w2 & 0x0100 + 0x022C == 0x0224) println (160); else println (999);
1891 acc16= variable 4
1892 <acc16= constant 256
1893 acc16+ constant 556
1894 acc16And unstack16
1895 acc16Comp constant 548
1896 brne 1900
1897 acc8= constant 160
1898 call writeLineAcc8
1899 br 1903
1900 acc16= constant 999
1901 call writeLineAcc16
1902 ;test15.j(274)   if (w2 | 0x0100 + 0x022C == 0x133C) println (161); else println (999);
1903 acc16= variable 4
1904 <acc16= constant 256
1905 acc16+ constant 556
1906 acc16Or unstack16
1907 acc16Comp constant 4924
1908 brne 1912
1909 acc8= constant 161
1910 call writeLineAcc8
1911 br 1915
1912 acc16= constant 999
1913 call writeLineAcc16
1914 ;test15.j(275)   if (w2 ^ 0x0100 + 0x022C == 0x1118) println (162); else println (999);
1915 acc16= variable 4
1916 <acc16= constant 256
1917 acc16+ constant 556
1918 acc16Xor unstack16
1919 acc16Comp constant 4376
1920 brne 1924
1921 acc8= constant 162
1922 call writeLineAcc8
1923 br 1928
1924 acc16= constant 999
1925 call writeLineAcc16
1926 ;test15.j(276)   //final var byt/acc word
1927 ;test15.j(277)   if (b1 & 0x1000 + 0x0234 == 0x0014) println (163); else println (999);
1928 acc8= variable 0
1929 acc16= constant 4096
1930 acc16+ constant 564
1931 acc16And acc8
1932 acc8= constant 20
1933 acc16CompareAcc8
1934 brne 1938
1935 acc8= constant 163
1936 call writeLineAcc8
1937 br 1941
1938 acc16= constant 999
1939 call writeLineAcc16
1940 ;test15.j(278)   if (b1 | 0x1000 + 0x0234 == 0x123C) println (164); else println (999);
1941 acc8= variable 0
1942 acc16= constant 4096
1943 acc16+ constant 564
1944 acc16Or acc8
1945 acc16Comp constant 4668
1946 brne 1950
1947 acc8= constant 164
1948 call writeLineAcc8
1949 br 1953
1950 acc16= constant 999
1951 call writeLineAcc16
1952 ;test15.j(279)   if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (165); else println (999);
1953 acc8= variable 0
1954 acc16= constant 4096
1955 acc16+ constant 564
1956 acc16Xor acc8
1957 acc16Comp constant 4648
1958 brne 1962
1959 acc8= constant 165
1960 call writeLineAcc8
1961 br 1966
1962 acc16= constant 999
1963 call writeLineAcc16
1964 ;test15.j(280)   //final var word/acc byt
1965 ;test15.j(281)   if (w2 & 0x10 + 0x0C == 0x0014) println (166); else println (999);
1966 acc16= variable 4
1967 acc8= constant 16
1968 acc8+ constant 12
1969 acc16And acc8
1970 acc8= constant 20
1971 acc16CompareAcc8
1972 brne 1976
1973 acc8= constant 166
1974 call writeLineAcc8
1975 br 1979
1976 acc16= constant 999
1977 call writeLineAcc16
1978 ;test15.j(282)   if (w2 | 0x10 + 0x0C == 0x123C) println (167); else println (999);
1979 acc16= variable 4
1980 acc8= constant 16
1981 acc8+ constant 12
1982 acc16Or acc8
1983 acc16Comp constant 4668
1984 brne 1988
1985 acc8= constant 167
1986 call writeLineAcc8
1987 br 1991
1988 acc16= constant 999
1989 call writeLineAcc16
1990 ;test15.j(283)   if (w2 ^ 0x10 + 0x0C == 0x1228) println (168); else println (999);
1991 acc16= variable 4
1992 acc8= constant 16
1993 acc8+ constant 12
1994 acc16Xor acc8
1995 acc16Comp constant 4648
1996 brne 2000
1997 acc8= constant 168
1998 call writeLineAcc8
1999 br 2007
2000 acc16= constant 999
2001 call writeLineAcc16
2002 ;test15.j(284) 
2003 ;test15.j(285)   //final var/var
2004 ;test15.j(286)   //*************
2005 ;test15.j(287)   //final var byte/var byte
2006 ;test15.j(288)   if (b2 & b1 == 0x04) println (169); else println (999);
2007 acc8= variable 1
2008 acc8And variable 0
2009 acc8Comp constant 4
2010 brne 2014
2011 acc8= constant 169
2012 call writeLineAcc8
2013 br 2017
2014 acc16= constant 999
2015 call writeLineAcc16
2016 ;test15.j(289)   if (b2 | b1 == 0x1F) println (170); else println (999);
2017 acc8= variable 1
2018 acc8Or variable 0
2019 acc8Comp constant 31
2020 brne 2024
2021 acc8= constant 170
2022 call writeLineAcc8
2023 br 2027
2024 acc16= constant 999
2025 call writeLineAcc16
2026 ;test15.j(290)   if (b2 ^ b1 == 0x1B) println (171); else println (999);
2027 acc8= variable 1
2028 acc8Xor variable 0
2029 acc8Comp constant 27
2030 brne 2034
2031 acc8= constant 171
2032 call writeLineAcc8
2033 br 2038
2034 acc16= constant 999
2035 call writeLineAcc16
2036 ;test15.j(291)   //final var word/var word
2037 ;test15.j(292)   if (w2 & w1 == 0x0224) println (172); else println (999);
2038 acc16= variable 4
2039 acc16And variable 2
2040 acc16Comp constant 548
2041 brne 2045
2042 acc8= constant 172
2043 call writeLineAcc8
2044 br 2048
2045 acc16= constant 999
2046 call writeLineAcc16
2047 ;test15.j(293)   if (w2 | w1 == 0x133C) println (173); else println (999);
2048 acc16= variable 4
2049 acc16Or variable 2
2050 acc16Comp constant 4924
2051 brne 2055
2052 acc8= constant 173
2053 call writeLineAcc8
2054 br 2058
2055 acc16= constant 999
2056 call writeLineAcc16
2057 ;test15.j(294)   if (w2 ^ w1 == 0x1118) println (174); else println (999);
2058 acc16= variable 4
2059 acc16Xor variable 2
2060 acc16Comp constant 4376
2061 brne 2065
2062 acc8= constant 174
2063 call writeLineAcc8
2064 br 2069
2065 acc16= constant 999
2066 call writeLineAcc16
2067 ;test15.j(295)   //final var byt/var word
2068 ;test15.j(296)   if (b1 & w2 == 0x0014) println (175); else println (999);
2069 acc8= variable 0
2070 acc8ToAcc16
2071 acc16And variable 4
2072 acc8= constant 20
2073 acc16CompareAcc8
2074 brne 2078
2075 acc8= constant 175
2076 call writeLineAcc8
2077 br 2081
2078 acc16= constant 999
2079 call writeLineAcc16
2080 ;test15.j(297)   if (b1 | w2 == 0x123C) println (176); else println (999);
2081 acc8= variable 0
2082 acc8ToAcc16
2083 acc16Or variable 4
2084 acc16Comp constant 4668
2085 brne 2089
2086 acc8= constant 176
2087 call writeLineAcc8
2088 br 2092
2089 acc16= constant 999
2090 call writeLineAcc16
2091 ;test15.j(298)   if (b1 ^ w2 == 0x1228) println (177); else println (999);
2092 acc8= variable 0
2093 acc8ToAcc16
2094 acc16Xor variable 4
2095 acc16Comp constant 4648
2096 brne 2100
2097 acc8= constant 177
2098 call writeLineAcc8
2099 br 2104
2100 acc16= constant 999
2101 call writeLineAcc16
2102 ;test15.j(299)   //final var word/var byt
2103 ;test15.j(300)   if (w2 & b1 == 0x0014) println (178); else println (999);
2104 acc16= variable 4
2105 acc16And variable 0
2106 acc8= constant 20
2107 acc16CompareAcc8
2108 brne 2112
2109 acc8= constant 178
2110 call writeLineAcc8
2111 br 2115
2112 acc16= constant 999
2113 call writeLineAcc16
2114 ;test15.j(301)   if (w2 | b1 == 0x123C) println (179); else println (999);
2115 acc16= variable 4
2116 acc16Or variable 0
2117 acc16Comp constant 4668
2118 brne 2122
2119 acc8= constant 179
2120 call writeLineAcc8
2121 br 2125
2122 acc16= constant 999
2123 call writeLineAcc16
2124 ;test15.j(302)   if (w2 ^ b1 == 0x1228) println (180); else println (999);
2125 acc16= variable 4
2126 acc16Xor variable 0
2127 acc16Comp constant 4648
2128 brne 2132
2129 acc8= constant 180
2130 call writeLineAcc8
2131 br 2139
2132 acc16= constant 999
2133 call writeLineAcc16
2134 ;test15.j(303) 
2135 ;test15.j(304)   //final var/final var
2136 ;test15.j(305)   //*******************
2137 ;test15.j(306)   //final var byte/final var byte
2138 ;test15.j(307)   if (fb2 & fb1 == 0x04) println (181); else println (999);
2139 acc8= constant 7
2140 acc8And constant 28
2141 acc8Comp constant 4
2142 brne 2146
2143 acc8= constant 181
2144 call writeLineAcc8
2145 br 2149
2146 acc16= constant 999
2147 call writeLineAcc16
2148 ;test15.j(308)   if (fb2 | fb1 == 0x1F) println (182); else println (999);
2149 acc8= constant 7
2150 acc8Or constant 28
2151 acc8Comp constant 31
2152 brne 2156
2153 acc8= constant 182
2154 call writeLineAcc8
2155 br 2159
2156 acc16= constant 999
2157 call writeLineAcc16
2158 ;test15.j(309)   if (fb2 ^ fb1 == 0x1B) println (183); else println (999);
2159 acc8= constant 7
2160 acc8Xor constant 28
2161 acc8Comp constant 27
2162 brne 2166
2163 acc8= constant 183
2164 call writeLineAcc8
2165 br 2170
2166 acc16= constant 999
2167 call writeLineAcc16
2168 ;test15.j(310)   //final var word/final var word
2169 ;test15.j(311)   if (fw2 & fw1 == 0x0224) println (184); else println (999);
2170 acc16= constant 4660
2171 acc16And constant 812
2172 acc16Comp constant 548
2173 brne 2177
2174 acc8= constant 184
2175 call writeLineAcc8
2176 br 2180
2177 acc16= constant 999
2178 call writeLineAcc16
2179 ;test15.j(312)   if (fw2 | fw1 == 0x133C) println (185); else println (999);
2180 acc16= constant 4660
2181 acc16Or constant 812
2182 acc16Comp constant 4924
2183 brne 2187
2184 acc8= constant 185
2185 call writeLineAcc8
2186 br 2190
2187 acc16= constant 999
2188 call writeLineAcc16
2189 ;test15.j(313)   if (fw2 ^ fw1 == 0x1118) println (186); else println (999);
2190 acc16= constant 4660
2191 acc16Xor constant 812
2192 acc16Comp constant 4376
2193 brne 2197
2194 acc8= constant 186
2195 call writeLineAcc8
2196 br 2201
2197 acc16= constant 999
2198 call writeLineAcc16
2199 ;test15.j(314)   //final var byt/final var word
2200 ;test15.j(315)   if (fb1 & fw2 == 0x0014) println (187); else println (999);
2201 acc8= constant 28
2202 acc8ToAcc16
2203 acc16And constant 4660
2204 acc8= constant 20
2205 acc16CompareAcc8
2206 brne 2210
2207 acc8= constant 187
2208 call writeLineAcc8
2209 br 2213
2210 acc16= constant 999
2211 call writeLineAcc16
2212 ;test15.j(316)   if (fb1 | fw2 == 0x123C) println (188); else println (999);
2213 acc8= constant 28
2214 acc8ToAcc16
2215 acc16Or constant 4660
2216 acc16Comp constant 4668
2217 brne 2221
2218 acc8= constant 188
2219 call writeLineAcc8
2220 br 2224
2221 acc16= constant 999
2222 call writeLineAcc16
2223 ;test15.j(317)   if (fb1 ^ fw2 == 0x1228) println (189); else println (999);
2224 acc8= constant 28
2225 acc8ToAcc16
2226 acc16Xor constant 4660
2227 acc16Comp constant 4648
2228 brne 2232
2229 acc8= constant 189
2230 call writeLineAcc8
2231 br 2236
2232 acc16= constant 999
2233 call writeLineAcc16
2234 ;test15.j(318)   //final var word/final var byt
2235 ;test15.j(319)   if (fw2 & fb1 == 0x0014) println (190); else println (999);
2236 acc16= constant 4660
2237 acc16And constant 28
2238 acc8= constant 20
2239 acc16CompareAcc8
2240 brne 2244
2241 acc8= constant 190
2242 call writeLineAcc8
2243 br 2247
2244 acc16= constant 999
2245 call writeLineAcc16
2246 ;test15.j(320)   if (fw2 | fb1 == 0x123C) println (191); else println (999);
2247 acc16= constant 4660
2248 acc16Or constant 28
2249 acc16Comp constant 4668
2250 brne 2254
2251 acc8= constant 191
2252 call writeLineAcc8
2253 br 2257
2254 acc16= constant 999
2255 call writeLineAcc16
2256 ;test15.j(321)   if (fw2 ^ fb1 == 0x1228) println (192); else println (999);
2257 acc16= constant 4660
2258 acc16Xor constant 28
2259 acc16Comp constant 4648
2260 brne 2264
2261 acc8= constant 192
2262 call writeLineAcc8
2263 br 2268
2264 acc16= constant 999
2265 call writeLineAcc16
2266 ;test15.j(322) 
2267 ;test15.j(323)   println("Klaar");
2268 acc16= constant 2272
2269 writeLineString
2270 ;test15.j(324) }
2271 stop
2272 stringConstant 0 = "Klaar"
