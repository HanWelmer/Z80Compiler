   0 ;test15.j(0) /* Program to test bitwise operators and, or and xor. */
   1 ;test15.j(1) class TestBitwiseOperators {
   2 ;test15.j(2)   println(0);
   3 acc8= constant 0
   4 call writeLineAcc8
   5 ;test15.j(3)   
   6 ;test15.j(4)   // Possible operand types: constant, acc, var, final var, stack8, stack16.
   7 ;test15.j(5)   // Possible data types: byte, word.
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
  93 ;test15.j(29)   //constant byte/constant word
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
 128 ;test15.j(33)   //constant word/constant byte
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
 237 ;test15.j(48)   //constant byte/acc word
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
 275 ;test15.j(52)   //constant word/acc byte
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
 378 ;test15.j(67)   //constant byte/var word
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
 413 ;test15.j(71)   //constant word/var byte
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
 510 ;test15.j(86)   //constant byte/final var word
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
 545 ;test15.j(90)   //constant word/final var byte
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
 648 ;test15.j(105)   //acc byte/constant word
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
 686 ;test15.j(109)   //acc word/constant byte
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
 765 ;test15.j(121)   if (0x1000 + 0x0234 & 0x0100 + 0x022C == 0x0224) println (64); else println (999);
 766 acc16= constant 4096
 767 acc16+ constant 564
 768 <acc16= constant 256
 769 acc16+ constant 556
 770 acc16And unstack16
 771 acc16Comp constant 548
 772 brne 776
 773 acc8= constant 64
 774 call writeLineAcc8
 775 br 779
 776 acc16= constant 999
 777 call writeLineAcc16
 778 ;test15.j(122)   if (0x1000 + 0x0234 | 0x0100 + 0x022C == 0x133C) println (65); else println (999);
 779 acc16= constant 4096
 780 acc16+ constant 564
 781 <acc16= constant 256
 782 acc16+ constant 556
 783 acc16Or unstack16
 784 acc16Comp constant 4924
 785 brne 789
 786 acc8= constant 65
 787 call writeLineAcc8
 788 br 792
 789 acc16= constant 999
 790 call writeLineAcc16
 791 ;test15.j(123)   if (0x1000 + 0x0234 ^ 0x0100 + 0x022C == 0x1118) println (66); else println (999);
 792 acc16= constant 4096
 793 acc16+ constant 564
 794 <acc16= constant 256
 795 acc16+ constant 556
 796 acc16Xor unstack16
 797 acc16Comp constant 4376
 798 brne 802
 799 acc8= constant 66
 800 call writeLineAcc8
 801 br 806
 802 acc16= constant 999
 803 call writeLineAcc16
 804 ;test15.j(124)   //acc byte/acc word
 805 ;test15.j(125)   if (0x10 + 0x0C & 0x1000 + 0x0234 == 0x0014) println (67); else println (999);
 806 acc8= constant 16
 807 acc8+ constant 12
 808 acc16= constant 4096
 809 acc16+ constant 564
 810 acc16And acc8
 811 acc8= constant 20
 812 acc16CompareAcc8
 813 brne 817
 814 acc8= constant 67
 815 call writeLineAcc8
 816 br 820
 817 acc16= constant 999
 818 call writeLineAcc16
 819 ;test15.j(126)   if (0x10 + 0x0C | 0x1000 + 0x0234 == 0x123C) println (68); else println (999);
 820 acc8= constant 16
 821 acc8+ constant 12
 822 acc16= constant 4096
 823 acc16+ constant 564
 824 acc16Or acc8
 825 acc16Comp constant 4668
 826 brne 830
 827 acc8= constant 68
 828 call writeLineAcc8
 829 br 833
 830 acc16= constant 999
 831 call writeLineAcc16
 832 ;test15.j(127)   if (0x10 + 0x0C ^ 0x1000 + 0x0234 == 0x1228) println (69); else println (999);
 833 acc8= constant 16
 834 acc8+ constant 12
 835 acc16= constant 4096
 836 acc16+ constant 564
 837 acc16Xor acc8
 838 acc16Comp constant 4648
 839 brne 843
 840 acc8= constant 69
 841 call writeLineAcc8
 842 br 847
 843 acc16= constant 999
 844 call writeLineAcc16
 845 ;test15.j(128)   //acc word/acc byte
 846 ;test15.j(129)   if (0x1000 + 0x0234 & 0x10 + 0x0C == 0x0014) println (70); else println (999);
 847 acc16= constant 4096
 848 acc16+ constant 564
 849 acc8= constant 16
 850 acc8+ constant 12
 851 acc16And acc8
 852 acc8= constant 20
 853 acc16CompareAcc8
 854 brne 858
 855 acc8= constant 70
 856 call writeLineAcc8
 857 br 861
 858 acc16= constant 999
 859 call writeLineAcc16
 860 ;test15.j(130)   if (0x1000 + 0x0234 | 0x10 + 0x0C == 0x123C) println (71); else println (999);
 861 acc16= constant 4096
 862 acc16+ constant 564
 863 acc8= constant 16
 864 acc8+ constant 12
 865 acc16Or acc8
 866 acc16Comp constant 4668
 867 brne 871
 868 acc8= constant 71
 869 call writeLineAcc8
 870 br 874
 871 acc16= constant 999
 872 call writeLineAcc16
 873 ;test15.j(131)   if (0x1000 + 0x0234 ^ 0x10 + 0x0C == 0x1228) println (72); else println (999);
 874 acc16= constant 4096
 875 acc16+ constant 564
 876 acc8= constant 16
 877 acc8+ constant 12
 878 acc16Xor acc8
 879 acc16Comp constant 4648
 880 brne 884
 881 acc8= constant 72
 882 call writeLineAcc8
 883 br 891
 884 acc16= constant 999
 885 call writeLineAcc16
 886 ;test15.j(132) 
 887 ;test15.j(133)   //acc/var
 888 ;test15.j(134)   //*******
 889 ;test15.j(135)   //acc byte/var byte
 890 ;test15.j(136)   if (0x04 + 0x03 & b1 == 0x04) println (73); else println (999);
 891 acc8= constant 4
 892 acc8+ constant 3
 893 acc8And variable 0
 894 acc8Comp constant 4
 895 brne 899
 896 acc8= constant 73
 897 call writeLineAcc8
 898 br 902
 899 acc16= constant 999
 900 call writeLineAcc16
 901 ;test15.j(137)   if (0x04 + 0x03 | b1 == 0x1F) println (74); else println (999);
 902 acc8= constant 4
 903 acc8+ constant 3
 904 acc8Or variable 0
 905 acc8Comp constant 31
 906 brne 910
 907 acc8= constant 74
 908 call writeLineAcc8
 909 br 913
 910 acc16= constant 999
 911 call writeLineAcc16
 912 ;test15.j(138)   if (0x04 + 0x03 ^ b1 == 0x1B) println (75); else println (999);
 913 acc8= constant 4
 914 acc8+ constant 3
 915 acc8Xor variable 0
 916 acc8Comp constant 27
 917 brne 921
 918 acc8= constant 75
 919 call writeLineAcc8
 920 br 925
 921 acc16= constant 999
 922 call writeLineAcc16
 923 ;test15.j(139)   //acc word/var word
 924 ;test15.j(140)   if (0x1000 + 0x0234 & w1 == 0x0224) println (76); else println (999);
 925 acc16= constant 4096
 926 acc16+ constant 564
 927 acc16And variable 2
 928 acc16Comp constant 548
 929 brne 933
 930 acc8= constant 76
 931 call writeLineAcc8
 932 br 936
 933 acc16= constant 999
 934 call writeLineAcc16
 935 ;test15.j(141)   if (0x1000 + 0x0234 | w1 == 0x133C) println (77); else println (999);
 936 acc16= constant 4096
 937 acc16+ constant 564
 938 acc16Or variable 2
 939 acc16Comp constant 4924
 940 brne 944
 941 acc8= constant 77
 942 call writeLineAcc8
 943 br 947
 944 acc16= constant 999
 945 call writeLineAcc16
 946 ;test15.j(142)   if (0x1000 + 0x0234 ^ w1 == 0x1118) println (78); else println (999);
 947 acc16= constant 4096
 948 acc16+ constant 564
 949 acc16Xor variable 2
 950 acc16Comp constant 4376
 951 brne 955
 952 acc8= constant 78
 953 call writeLineAcc8
 954 br 959
 955 acc16= constant 999
 956 call writeLineAcc16
 957 ;test15.j(143)   //acc byte/var word
 958 ;test15.j(144)   if (0x10 + 0x0C & w2 == 0x0014) println (79); else println (999);
 959 acc8= constant 16
 960 acc8+ constant 12
 961 acc8ToAcc16
 962 acc16And variable 4
 963 acc8= constant 20
 964 acc16CompareAcc8
 965 brne 969
 966 acc8= constant 79
 967 call writeLineAcc8
 968 br 972
 969 acc16= constant 999
 970 call writeLineAcc16
 971 ;test15.j(145)   if (0x10 + 0x0C | w2 == 0x123C) println (80); else println (999);
 972 acc8= constant 16
 973 acc8+ constant 12
 974 acc8ToAcc16
 975 acc16Or variable 4
 976 acc16Comp constant 4668
 977 brne 981
 978 acc8= constant 80
 979 call writeLineAcc8
 980 br 984
 981 acc16= constant 999
 982 call writeLineAcc16
 983 ;test15.j(146)   if (0x10 + 0x0C ^ w2 == 0x1228) println (81); else println (999);
 984 acc8= constant 16
 985 acc8+ constant 12
 986 acc8ToAcc16
 987 acc16Xor variable 4
 988 acc16Comp constant 4648
 989 brne 993
 990 acc8= constant 81
 991 call writeLineAcc8
 992 br 997
 993 acc16= constant 999
 994 call writeLineAcc16
 995 ;test15.j(147)   //acc word/var byte
 996 ;test15.j(148)   if (0x1000 + 0x0234 & b1 == 0x0014) println (82); else println (999);
 997 acc16= constant 4096
 998 acc16+ constant 564
 999 acc16And variable 0
1000 acc8= constant 20
1001 acc16CompareAcc8
1002 brne 1006
1003 acc8= constant 82
1004 call writeLineAcc8
1005 br 1009
1006 acc16= constant 999
1007 call writeLineAcc16
1008 ;test15.j(149)   if (0x1000 + 0x0234 | b1 == 0x123C) println (83); else println (999);
1009 acc16= constant 4096
1010 acc16+ constant 564
1011 acc16Or variable 0
1012 acc16Comp constant 4668
1013 brne 1017
1014 acc8= constant 83
1015 call writeLineAcc8
1016 br 1020
1017 acc16= constant 999
1018 call writeLineAcc16
1019 ;test15.j(150)   if (0x1000 + 0x0234 ^ b1 == 0x1228) println (84); else println (999);
1020 acc16= constant 4096
1021 acc16+ constant 564
1022 acc16Xor variable 0
1023 acc16Comp constant 4648
1024 brne 1028
1025 acc8= constant 84
1026 call writeLineAcc8
1027 br 1035
1028 acc16= constant 999
1029 call writeLineAcc16
1030 ;test15.j(151) 
1031 ;test15.j(152)   //acc/final var
1032 ;test15.j(153)   //*************
1033 ;test15.j(154)   //acc byte/final var byte
1034 ;test15.j(155)   if (0x04 + 0x03 & fb1 == 0x04) println (85); else println (999);
1035 acc8= constant 4
1036 acc8+ constant 3
1037 acc8And constant 28
1038 acc8Comp constant 4
1039 brne 1043
1040 acc8= constant 85
1041 call writeLineAcc8
1042 br 1046
1043 acc16= constant 999
1044 call writeLineAcc16
1045 ;test15.j(156)   if (0x04 + 0x03 | fb1 == 0x1F) println (86); else println (999);
1046 acc8= constant 4
1047 acc8+ constant 3
1048 acc8Or constant 28
1049 acc8Comp constant 31
1050 brne 1054
1051 acc8= constant 86
1052 call writeLineAcc8
1053 br 1057
1054 acc16= constant 999
1055 call writeLineAcc16
1056 ;test15.j(157)   if (0x04 + 0x03 ^ fb1 == 0x1B) println (87); else println (999);
1057 acc8= constant 4
1058 acc8+ constant 3
1059 acc8Xor constant 28
1060 acc8Comp constant 27
1061 brne 1065
1062 acc8= constant 87
1063 call writeLineAcc8
1064 br 1069
1065 acc16= constant 999
1066 call writeLineAcc16
1067 ;test15.j(158)   //acc word/final var word
1068 ;test15.j(159)   if (0x1000 + 0x0234 & fw1 == 0x0224) println (88); else println (999);
1069 acc16= constant 4096
1070 acc16+ constant 564
1071 acc16And constant 812
1072 acc16Comp constant 548
1073 brne 1077
1074 acc8= constant 88
1075 call writeLineAcc8
1076 br 1080
1077 acc16= constant 999
1078 call writeLineAcc16
1079 ;test15.j(160)   if (0x1000 + 0x0234 | fw1 == 0x133C) println (89); else println (999);
1080 acc16= constant 4096
1081 acc16+ constant 564
1082 acc16Or constant 812
1083 acc16Comp constant 4924
1084 brne 1088
1085 acc8= constant 89
1086 call writeLineAcc8
1087 br 1091
1088 acc16= constant 999
1089 call writeLineAcc16
1090 ;test15.j(161)   if (0x1000 + 0x0234 ^ fw1 == 0x1118) println (90); else println (999);
1091 acc16= constant 4096
1092 acc16+ constant 564
1093 acc16Xor constant 812
1094 acc16Comp constant 4376
1095 brne 1099
1096 acc8= constant 90
1097 call writeLineAcc8
1098 br 1103
1099 acc16= constant 999
1100 call writeLineAcc16
1101 ;test15.j(162)   //acc byte/final var word
1102 ;test15.j(163)   if (0x10 + 0x0C & fw2 == 0x0014) println (91); else println (999);
1103 acc8= constant 16
1104 acc8+ constant 12
1105 acc8ToAcc16
1106 acc16And constant 4660
1107 acc8= constant 20
1108 acc16CompareAcc8
1109 brne 1113
1110 acc8= constant 91
1111 call writeLineAcc8
1112 br 1116
1113 acc16= constant 999
1114 call writeLineAcc16
1115 ;test15.j(164)   if (0x10 + 0x0C | fw2 == 0x123C) println (92); else println (999);
1116 acc8= constant 16
1117 acc8+ constant 12
1118 acc8ToAcc16
1119 acc16Or constant 4660
1120 acc16Comp constant 4668
1121 brne 1125
1122 acc8= constant 92
1123 call writeLineAcc8
1124 br 1128
1125 acc16= constant 999
1126 call writeLineAcc16
1127 ;test15.j(165)   if (0x10 + 0x0C ^ fw2 == 0x1228) println (93); else println (999);
1128 acc8= constant 16
1129 acc8+ constant 12
1130 acc8ToAcc16
1131 acc16Xor constant 4660
1132 acc16Comp constant 4648
1133 brne 1137
1134 acc8= constant 93
1135 call writeLineAcc8
1136 br 1141
1137 acc16= constant 999
1138 call writeLineAcc16
1139 ;test15.j(166)   //acc word/final var byte
1140 ;test15.j(167)   if (0x1000 + 0x0234 & fb1 == 0x0014) println (94); else println (999);
1141 acc16= constant 4096
1142 acc16+ constant 564
1143 acc16And constant 28
1144 acc8= constant 20
1145 acc16CompareAcc8
1146 brne 1150
1147 acc8= constant 94
1148 call writeLineAcc8
1149 br 1153
1150 acc16= constant 999
1151 call writeLineAcc16
1152 ;test15.j(168)   if (0x1000 + 0x0234 | fb1 == 0x123C) println (95); else println (999);
1153 acc16= constant 4096
1154 acc16+ constant 564
1155 acc16Or constant 28
1156 acc16Comp constant 4668
1157 brne 1161
1158 acc8= constant 95
1159 call writeLineAcc8
1160 br 1164
1161 acc16= constant 999
1162 call writeLineAcc16
1163 ;test15.j(169)   if (0x1000 + 0x0234 ^ fb1 == 0x1228) println (96); else println (999);
1164 acc16= constant 4096
1165 acc16+ constant 564
1166 acc16Xor constant 28
1167 acc16Comp constant 4648
1168 brne 1172
1169 acc8= constant 96
1170 call writeLineAcc8
1171 br 1179
1172 acc16= constant 999
1173 call writeLineAcc16
1174 ;test15.j(170) 
1175 ;test15.j(171)   //var/constant
1176 ;test15.j(172)   //************
1177 ;test15.j(173)   //var byte/constant byte
1178 ;test15.j(174)   if (b2 & 0x1C == 0x04) println (97); else println (999);
1179 acc8= variable 1
1180 acc8And constant 28
1181 acc8Comp constant 4
1182 brne 1186
1183 acc8= constant 97
1184 call writeLineAcc8
1185 br 1189
1186 acc16= constant 999
1187 call writeLineAcc16
1188 ;test15.j(175)   if (b2 | 0x1C == 0x1F) println (98); else println (999);
1189 acc8= variable 1
1190 acc8Or constant 28
1191 acc8Comp constant 31
1192 brne 1196
1193 acc8= constant 98
1194 call writeLineAcc8
1195 br 1199
1196 acc16= constant 999
1197 call writeLineAcc16
1198 ;test15.j(176)   if (b2 ^ 0x1C == 0x1B) println (99); else println (999);
1199 acc8= variable 1
1200 acc8Xor constant 28
1201 acc8Comp constant 27
1202 brne 1206
1203 acc8= constant 99
1204 call writeLineAcc8
1205 br 1210
1206 acc16= constant 999
1207 call writeLineAcc16
1208 ;test15.j(177)   //var word/constant word
1209 ;test15.j(178)   if (w2 & 0x032C == 0x0224) println (100); else println (999);
1210 acc16= variable 4
1211 acc16And constant 812
1212 acc16Comp constant 548
1213 brne 1217
1214 acc8= constant 100
1215 call writeLineAcc8
1216 br 1220
1217 acc16= constant 999
1218 call writeLineAcc16
1219 ;test15.j(179)   if (w2 | 0x032C == 0x133C) println (101); else println (999);
1220 acc16= variable 4
1221 acc16Or constant 812
1222 acc16Comp constant 4924
1223 brne 1227
1224 acc8= constant 101
1225 call writeLineAcc8
1226 br 1230
1227 acc16= constant 999
1228 call writeLineAcc16
1229 ;test15.j(180)   if (w2 ^ 0x032C == 0x1118) println (102); else println (999);
1230 acc16= variable 4
1231 acc16Xor constant 812
1232 acc16Comp constant 4376
1233 brne 1237
1234 acc8= constant 102
1235 call writeLineAcc8
1236 br 1241
1237 acc16= constant 999
1238 call writeLineAcc16
1239 ;test15.j(181)   //var byte/constant word
1240 ;test15.j(182)   if (b1 & 0x1234 == 0x0014) println (103); else println (999);
1241 acc8= variable 0
1242 acc8ToAcc16
1243 acc16And constant 4660
1244 acc8= constant 20
1245 acc16CompareAcc8
1246 brne 1250
1247 acc8= constant 103
1248 call writeLineAcc8
1249 br 1253
1250 acc16= constant 999
1251 call writeLineAcc16
1252 ;test15.j(183)   if (b1 | 0x1234 == 0x123C) println (104); else println (999);
1253 acc8= variable 0
1254 acc8ToAcc16
1255 acc16Or constant 4660
1256 acc16Comp constant 4668
1257 brne 1261
1258 acc8= constant 104
1259 call writeLineAcc8
1260 br 1264
1261 acc16= constant 999
1262 call writeLineAcc16
1263 ;test15.j(184)   if (b1 ^ 0x1234 == 0x1228) println (105); else println (999);
1264 acc8= variable 0
1265 acc8ToAcc16
1266 acc16Xor constant 4660
1267 acc16Comp constant 4648
1268 brne 1272
1269 acc8= constant 105
1270 call writeLineAcc8
1271 br 1276
1272 acc16= constant 999
1273 call writeLineAcc16
1274 ;test15.j(185)   //var word/constant byte
1275 ;test15.j(186)   if (w2 & 0x1C == 0x0014) println (106); else println (999);
1276 acc16= variable 4
1277 acc16And constant 28
1278 acc8= constant 20
1279 acc16CompareAcc8
1280 brne 1284
1281 acc8= constant 106
1282 call writeLineAcc8
1283 br 1287
1284 acc16= constant 999
1285 call writeLineAcc16
1286 ;test15.j(187)   if (w2 | 0x1C == 0x123C) println (107); else println (999);
1287 acc16= variable 4
1288 acc16Or constant 28
1289 acc16Comp constant 4668
1290 brne 1294
1291 acc8= constant 107
1292 call writeLineAcc8
1293 br 1297
1294 acc16= constant 999
1295 call writeLineAcc16
1296 ;test15.j(188)   if (w2 ^ 0x1C == 0x1228) println (108); else println (999);
1297 acc16= variable 4
1298 acc16Xor constant 28
1299 acc16Comp constant 4648
1300 brne 1304
1301 acc8= constant 108
1302 call writeLineAcc8
1303 br 1311
1304 acc16= constant 999
1305 call writeLineAcc16
1306 ;test15.j(189) 
1307 ;test15.j(190)   //var/acc
1308 ;test15.j(191)   //*******
1309 ;test15.j(192)   //var byte/acc byte
1310 ;test15.j(193)   if (b2 & (0x10 + 0x0C) == 0x04) println (109); else println (999);
1311 acc8= variable 1
1312 <acc8= constant 16
1313 acc8+ constant 12
1314 acc8And unstack8
1315 acc8Comp constant 4
1316 brne 1320
1317 acc8= constant 109
1318 call writeLineAcc8
1319 br 1323
1320 acc16= constant 999
1321 call writeLineAcc16
1322 ;test15.j(194)   if (b2 | (0x10 + 0x0C) == 0x1F) println (110); else println (999);
1323 acc8= variable 1
1324 <acc8= constant 16
1325 acc8+ constant 12
1326 acc8Or unstack8
1327 acc8Comp constant 31
1328 brne 1332
1329 acc8= constant 110
1330 call writeLineAcc8
1331 br 1335
1332 acc16= constant 999
1333 call writeLineAcc16
1334 ;test15.j(195)   if (b2 ^ (0x10 + 0x0C) == 0x1B) println (111); else println (999);
1335 acc8= variable 1
1336 <acc8= constant 16
1337 acc8+ constant 12
1338 acc8Xor unstack8
1339 acc8Comp constant 27
1340 brne 1344
1341 acc8= constant 111
1342 call writeLineAcc8
1343 br 1348
1344 acc16= constant 999
1345 call writeLineAcc16
1346 ;test15.j(196)   //var word/acc word
1347 ;test15.j(197)   if (w2 & 0x0100 + 0x022C == 0x0224) println (112); else println (999);
1348 acc16= variable 4
1349 <acc16= constant 256
1350 acc16+ constant 556
1351 acc16And unstack16
1352 acc16Comp constant 548
1353 brne 1357
1354 acc8= constant 112
1355 call writeLineAcc8
1356 br 1360
1357 acc16= constant 999
1358 call writeLineAcc16
1359 ;test15.j(198)   if (w2 | 0x0100 + 0x022C == 0x133C) println (113); else println (999);
1360 acc16= variable 4
1361 <acc16= constant 256
1362 acc16+ constant 556
1363 acc16Or unstack16
1364 acc16Comp constant 4924
1365 brne 1369
1366 acc8= constant 113
1367 call writeLineAcc8
1368 br 1372
1369 acc16= constant 999
1370 call writeLineAcc16
1371 ;test15.j(199)   if (w2 ^ 0x0100 + 0x022C == 0x1118) println (114); else println (999);
1372 acc16= variable 4
1373 <acc16= constant 256
1374 acc16+ constant 556
1375 acc16Xor unstack16
1376 acc16Comp constant 4376
1377 brne 1381
1378 acc8= constant 114
1379 call writeLineAcc8
1380 br 1385
1381 acc16= constant 999
1382 call writeLineAcc16
1383 ;test15.j(200)   //var byte/acc word
1384 ;test15.j(201)   if (b1 & 0x1000 + 0x0234 == 0x0014) println (115); else println (999);
1385 acc8= variable 0
1386 acc16= constant 4096
1387 acc16+ constant 564
1388 acc16And acc8
1389 acc8= constant 20
1390 acc16CompareAcc8
1391 brne 1395
1392 acc8= constant 115
1393 call writeLineAcc8
1394 br 1398
1395 acc16= constant 999
1396 call writeLineAcc16
1397 ;test15.j(202)   if (b1 | 0x1000 + 0x0234 == 0x123C) println (116); else println (999);
1398 acc8= variable 0
1399 acc16= constant 4096
1400 acc16+ constant 564
1401 acc16Or acc8
1402 acc16Comp constant 4668
1403 brne 1407
1404 acc8= constant 116
1405 call writeLineAcc8
1406 br 1410
1407 acc16= constant 999
1408 call writeLineAcc16
1409 ;test15.j(203)   if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (117); else println (999);
1410 acc8= variable 0
1411 acc16= constant 4096
1412 acc16+ constant 564
1413 acc16Xor acc8
1414 acc16Comp constant 4648
1415 brne 1419
1416 acc8= constant 117
1417 call writeLineAcc8
1418 br 1423
1419 acc16= constant 999
1420 call writeLineAcc16
1421 ;test15.j(204)   //var word/acc byte
1422 ;test15.j(205)   if (w2 & 0x10 + 0x0C == 0x0014) println (118); else println (999);
1423 acc16= variable 4
1424 acc8= constant 16
1425 acc8+ constant 12
1426 acc16And acc8
1427 acc8= constant 20
1428 acc16CompareAcc8
1429 brne 1433
1430 acc8= constant 118
1431 call writeLineAcc8
1432 br 1436
1433 acc16= constant 999
1434 call writeLineAcc16
1435 ;test15.j(206)   if (w2 | 0x10 + 0x0C == 0x123C) println (119); else println (999);
1436 acc16= variable 4
1437 acc8= constant 16
1438 acc8+ constant 12
1439 acc16Or acc8
1440 acc16Comp constant 4668
1441 brne 1445
1442 acc8= constant 119
1443 call writeLineAcc8
1444 br 1448
1445 acc16= constant 999
1446 call writeLineAcc16
1447 ;test15.j(207)   if (w2 ^ 0x10 + 0x0C == 0x1228) println (120); else println (999);
1448 acc16= variable 4
1449 acc8= constant 16
1450 acc8+ constant 12
1451 acc16Xor acc8
1452 acc16Comp constant 4648
1453 brne 1457
1454 acc8= constant 120
1455 call writeLineAcc8
1456 br 1464
1457 acc16= constant 999
1458 call writeLineAcc16
1459 ;test15.j(208) 
1460 ;test15.j(209)   //var/var
1461 ;test15.j(210)   //*******
1462 ;test15.j(211)   //var byte/var byte
1463 ;test15.j(212)   if (b2 & b1 == 0x04) println (121); else println (999);
1464 acc8= variable 1
1465 acc8And variable 0
1466 acc8Comp constant 4
1467 brne 1471
1468 acc8= constant 121
1469 call writeLineAcc8
1470 br 1474
1471 acc16= constant 999
1472 call writeLineAcc16
1473 ;test15.j(213)   if (b2 | b1 == 0x1F) println (122); else println (999);
1474 acc8= variable 1
1475 acc8Or variable 0
1476 acc8Comp constant 31
1477 brne 1481
1478 acc8= constant 122
1479 call writeLineAcc8
1480 br 1484
1481 acc16= constant 999
1482 call writeLineAcc16
1483 ;test15.j(214)   if (b2 ^ b1 == 0x1B) println (123); else println (999);
1484 acc8= variable 1
1485 acc8Xor variable 0
1486 acc8Comp constant 27
1487 brne 1491
1488 acc8= constant 123
1489 call writeLineAcc8
1490 br 1495
1491 acc16= constant 999
1492 call writeLineAcc16
1493 ;test15.j(215)   //var word/var word
1494 ;test15.j(216)   if (w2 & w1 == 0x0224) println (124); else println (999);
1495 acc16= variable 4
1496 acc16And variable 2
1497 acc16Comp constant 548
1498 brne 1502
1499 acc8= constant 124
1500 call writeLineAcc8
1501 br 1505
1502 acc16= constant 999
1503 call writeLineAcc16
1504 ;test15.j(217)   if (w2 | w1 == 0x133C) println (125); else println (999);
1505 acc16= variable 4
1506 acc16Or variable 2
1507 acc16Comp constant 4924
1508 brne 1512
1509 acc8= constant 125
1510 call writeLineAcc8
1511 br 1515
1512 acc16= constant 999
1513 call writeLineAcc16
1514 ;test15.j(218)   if (w2 ^ w1 == 0x1118) println (126); else println (999);
1515 acc16= variable 4
1516 acc16Xor variable 2
1517 acc16Comp constant 4376
1518 brne 1522
1519 acc8= constant 126
1520 call writeLineAcc8
1521 br 1526
1522 acc16= constant 999
1523 call writeLineAcc16
1524 ;test15.j(219)   //var byte/var word
1525 ;test15.j(220)   if (b1 & w2 == 0x0014) println (127); else println (999);
1526 acc8= variable 0
1527 acc8ToAcc16
1528 acc16And variable 4
1529 acc8= constant 20
1530 acc16CompareAcc8
1531 brne 1535
1532 acc8= constant 127
1533 call writeLineAcc8
1534 br 1538
1535 acc16= constant 999
1536 call writeLineAcc16
1537 ;test15.j(221)   if (b1 | w2 == 0x123C) println (128); else println (999);
1538 acc8= variable 0
1539 acc8ToAcc16
1540 acc16Or variable 4
1541 acc16Comp constant 4668
1542 brne 1546
1543 acc8= constant 128
1544 call writeLineAcc8
1545 br 1549
1546 acc16= constant 999
1547 call writeLineAcc16
1548 ;test15.j(222)   if (b1 ^ w2 == 0x1228) println (129); else println (999);
1549 acc8= variable 0
1550 acc8ToAcc16
1551 acc16Xor variable 4
1552 acc16Comp constant 4648
1553 brne 1557
1554 acc8= constant 129
1555 call writeLineAcc8
1556 br 1561
1557 acc16= constant 999
1558 call writeLineAcc16
1559 ;test15.j(223)   //var word/var byte
1560 ;test15.j(224)   if (w2 & b1 == 0x0014) println (130); else println (999);
1561 acc16= variable 4
1562 acc16And variable 0
1563 acc8= constant 20
1564 acc16CompareAcc8
1565 brne 1569
1566 acc8= constant 130
1567 call writeLineAcc8
1568 br 1572
1569 acc16= constant 999
1570 call writeLineAcc16
1571 ;test15.j(225)   if (w2 | b1 == 0x123C) println (131); else println (999);
1572 acc16= variable 4
1573 acc16Or variable 0
1574 acc16Comp constant 4668
1575 brne 1579
1576 acc8= constant 131
1577 call writeLineAcc8
1578 br 1582
1579 acc16= constant 999
1580 call writeLineAcc16
1581 ;test15.j(226)   if (w2 ^ b1 == 0x1228) println (132); else println (999);
1582 acc16= variable 4
1583 acc16Xor variable 0
1584 acc16Comp constant 4648
1585 brne 1589
1586 acc8= constant 132
1587 call writeLineAcc8
1588 br 1596
1589 acc16= constant 999
1590 call writeLineAcc16
1591 ;test15.j(227) 
1592 ;test15.j(228)   //var/final var
1593 ;test15.j(229)   //*************
1594 ;test15.j(230)   //var byte/final var byte
1595 ;test15.j(231)   if (b2 & fb1 == 0x04) println (133); else println (999);
1596 acc8= variable 1
1597 acc8And constant 28
1598 acc8Comp constant 4
1599 brne 1603
1600 acc8= constant 133
1601 call writeLineAcc8
1602 br 1606
1603 acc16= constant 999
1604 call writeLineAcc16
1605 ;test15.j(232)   if (b2 | fb1 == 0x1F) println (134); else println (999);
1606 acc8= variable 1
1607 acc8Or constant 28
1608 acc8Comp constant 31
1609 brne 1613
1610 acc8= constant 134
1611 call writeLineAcc8
1612 br 1616
1613 acc16= constant 999
1614 call writeLineAcc16
1615 ;test15.j(233)   if (b2 ^ fb1 == 0x1B) println (135); else println (999);
1616 acc8= variable 1
1617 acc8Xor constant 28
1618 acc8Comp constant 27
1619 brne 1623
1620 acc8= constant 135
1621 call writeLineAcc8
1622 br 1627
1623 acc16= constant 999
1624 call writeLineAcc16
1625 ;test15.j(234)   //var word/final var word
1626 ;test15.j(235)   if (w2 & fw1 == 0x0224) println (136); else println (999);
1627 acc16= variable 4
1628 acc16And constant 812
1629 acc16Comp constant 548
1630 brne 1634
1631 acc8= constant 136
1632 call writeLineAcc8
1633 br 1637
1634 acc16= constant 999
1635 call writeLineAcc16
1636 ;test15.j(236)   if (w2 | fw1 == 0x133C) println (137); else println (999);
1637 acc16= variable 4
1638 acc16Or constant 812
1639 acc16Comp constant 4924
1640 brne 1644
1641 acc8= constant 137
1642 call writeLineAcc8
1643 br 1647
1644 acc16= constant 999
1645 call writeLineAcc16
1646 ;test15.j(237)   if (w2 ^ fw1 == 0x1118) println (138); else println (999);
1647 acc16= variable 4
1648 acc16Xor constant 812
1649 acc16Comp constant 4376
1650 brne 1654
1651 acc8= constant 138
1652 call writeLineAcc8
1653 br 1658
1654 acc16= constant 999
1655 call writeLineAcc16
1656 ;test15.j(238)   //var byte/final var word
1657 ;test15.j(239)   if (b1 & fw2 == 0x0014) println (139); else println (999);
1658 acc8= variable 0
1659 acc8ToAcc16
1660 acc16And constant 4660
1661 acc8= constant 20
1662 acc16CompareAcc8
1663 brne 1667
1664 acc8= constant 139
1665 call writeLineAcc8
1666 br 1670
1667 acc16= constant 999
1668 call writeLineAcc16
1669 ;test15.j(240)   if (b1 | fw2 == 0x123C) println (140); else println (999);
1670 acc8= variable 0
1671 acc8ToAcc16
1672 acc16Or constant 4660
1673 acc16Comp constant 4668
1674 brne 1678
1675 acc8= constant 140
1676 call writeLineAcc8
1677 br 1681
1678 acc16= constant 999
1679 call writeLineAcc16
1680 ;test15.j(241)   if (b1 ^ fw2 == 0x1228) println (141); else println (999);
1681 acc8= variable 0
1682 acc8ToAcc16
1683 acc16Xor constant 4660
1684 acc16Comp constant 4648
1685 brne 1689
1686 acc8= constant 141
1687 call writeLineAcc8
1688 br 1693
1689 acc16= constant 999
1690 call writeLineAcc16
1691 ;test15.j(242)   //var word/final var byte
1692 ;test15.j(243)   if (w2 & fb1 == 0x0014) println (142); else println (999);
1693 acc16= variable 4
1694 acc16And constant 28
1695 acc8= constant 20
1696 acc16CompareAcc8
1697 brne 1701
1698 acc8= constant 142
1699 call writeLineAcc8
1700 br 1704
1701 acc16= constant 999
1702 call writeLineAcc16
1703 ;test15.j(244)   if (w2 | fb1 == 0x123C) println (143); else println (999);
1704 acc16= variable 4
1705 acc16Or constant 28
1706 acc16Comp constant 4668
1707 brne 1711
1708 acc8= constant 143
1709 call writeLineAcc8
1710 br 1714
1711 acc16= constant 999
1712 call writeLineAcc16
1713 ;test15.j(245)   if (w2 ^ fb1 == 0x1228) println (144); else println (999);
1714 acc16= variable 4
1715 acc16Xor constant 28
1716 acc16Comp constant 4648
1717 brne 1721
1718 acc8= constant 144
1719 call writeLineAcc8
1720 br 1728
1721 acc16= constant 999
1722 call writeLineAcc16
1723 ;test15.j(246) 
1724 ;test15.j(247)   //final var/constant
1725 ;test15.j(248)   //******************
1726 ;test15.j(249)   //final var byte/constant byte
1727 ;test15.j(250)   if (b2 & 0x1C == 0x04) println (145); else println (999);
1728 acc8= variable 1
1729 acc8And constant 28
1730 acc8Comp constant 4
1731 brne 1735
1732 acc8= constant 145
1733 call writeLineAcc8
1734 br 1738
1735 acc16= constant 999
1736 call writeLineAcc16
1737 ;test15.j(251)   if (b2 | 0x1C == 0x1F) println (146); else println (999);
1738 acc8= variable 1
1739 acc8Or constant 28
1740 acc8Comp constant 31
1741 brne 1745
1742 acc8= constant 146
1743 call writeLineAcc8
1744 br 1748
1745 acc16= constant 999
1746 call writeLineAcc16
1747 ;test15.j(252)   if (b2 ^ 0x1C == 0x1B) println (147); else println (999);
1748 acc8= variable 1
1749 acc8Xor constant 28
1750 acc8Comp constant 27
1751 brne 1755
1752 acc8= constant 147
1753 call writeLineAcc8
1754 br 1759
1755 acc16= constant 999
1756 call writeLineAcc16
1757 ;test15.j(253)   //final var word/constant word
1758 ;test15.j(254)   if (w2 & 0x032C == 0x0224) println (148); else println (999);
1759 acc16= variable 4
1760 acc16And constant 812
1761 acc16Comp constant 548
1762 brne 1766
1763 acc8= constant 148
1764 call writeLineAcc8
1765 br 1769
1766 acc16= constant 999
1767 call writeLineAcc16
1768 ;test15.j(255)   if (w2 | 0x032C == 0x133C) println (149); else println (999);
1769 acc16= variable 4
1770 acc16Or constant 812
1771 acc16Comp constant 4924
1772 brne 1776
1773 acc8= constant 149
1774 call writeLineAcc8
1775 br 1779
1776 acc16= constant 999
1777 call writeLineAcc16
1778 ;test15.j(256)   if (w2 ^ 0x032C == 0x1118) println (150); else println (999);
1779 acc16= variable 4
1780 acc16Xor constant 812
1781 acc16Comp constant 4376
1782 brne 1786
1783 acc8= constant 150
1784 call writeLineAcc8
1785 br 1790
1786 acc16= constant 999
1787 call writeLineAcc16
1788 ;test15.j(257)   //final var byte/constant word
1789 ;test15.j(258)   if (b1 & 0x1234 == 0x0014) println (151); else println (999);
1790 acc8= variable 0
1791 acc8ToAcc16
1792 acc16And constant 4660
1793 acc8= constant 20
1794 acc16CompareAcc8
1795 brne 1799
1796 acc8= constant 151
1797 call writeLineAcc8
1798 br 1802
1799 acc16= constant 999
1800 call writeLineAcc16
1801 ;test15.j(259)   if (b1 | 0x1234 == 0x123C) println (152); else println (999);
1802 acc8= variable 0
1803 acc8ToAcc16
1804 acc16Or constant 4660
1805 acc16Comp constant 4668
1806 brne 1810
1807 acc8= constant 152
1808 call writeLineAcc8
1809 br 1813
1810 acc16= constant 999
1811 call writeLineAcc16
1812 ;test15.j(260)   if (b1 ^ 0x1234 == 0x1228) println (153); else println (999);
1813 acc8= variable 0
1814 acc8ToAcc16
1815 acc16Xor constant 4660
1816 acc16Comp constant 4648
1817 brne 1821
1818 acc8= constant 153
1819 call writeLineAcc8
1820 br 1825
1821 acc16= constant 999
1822 call writeLineAcc16
1823 ;test15.j(261)   //final var word/constant byte
1824 ;test15.j(262)   if (w2 & 0x1C == 0x0014) println (154); else println (999);
1825 acc16= variable 4
1826 acc16And constant 28
1827 acc8= constant 20
1828 acc16CompareAcc8
1829 brne 1833
1830 acc8= constant 154
1831 call writeLineAcc8
1832 br 1836
1833 acc16= constant 999
1834 call writeLineAcc16
1835 ;test15.j(263)   if (w2 | 0x1C == 0x123C) println (155); else println (999);
1836 acc16= variable 4
1837 acc16Or constant 28
1838 acc16Comp constant 4668
1839 brne 1843
1840 acc8= constant 155
1841 call writeLineAcc8
1842 br 1846
1843 acc16= constant 999
1844 call writeLineAcc16
1845 ;test15.j(264)   if (w2 ^ 0x1C == 0x1228) println (156); else println (999);
1846 acc16= variable 4
1847 acc16Xor constant 28
1848 acc16Comp constant 4648
1849 brne 1853
1850 acc8= constant 156
1851 call writeLineAcc8
1852 br 1860
1853 acc16= constant 999
1854 call writeLineAcc16
1855 ;test15.j(265) 
1856 ;test15.j(266)   //final var/acc
1857 ;test15.j(267)   //*************
1858 ;test15.j(268)   //final var byte/acc byte
1859 ;test15.j(269)   if (b2 & (0x10 + 0x0C) == 0x04) println (157); else println (999);
1860 acc8= variable 1
1861 <acc8= constant 16
1862 acc8+ constant 12
1863 acc8And unstack8
1864 acc8Comp constant 4
1865 brne 1869
1866 acc8= constant 157
1867 call writeLineAcc8
1868 br 1872
1869 acc16= constant 999
1870 call writeLineAcc16
1871 ;test15.j(270)   if (b2 | (0x10 + 0x0C) == 0x1F) println (158); else println (999);
1872 acc8= variable 1
1873 <acc8= constant 16
1874 acc8+ constant 12
1875 acc8Or unstack8
1876 acc8Comp constant 31
1877 brne 1881
1878 acc8= constant 158
1879 call writeLineAcc8
1880 br 1884
1881 acc16= constant 999
1882 call writeLineAcc16
1883 ;test15.j(271)   if (b2 ^ (0x10 + 0x0C) == 0x1B) println (159); else println (999);
1884 acc8= variable 1
1885 <acc8= constant 16
1886 acc8+ constant 12
1887 acc8Xor unstack8
1888 acc8Comp constant 27
1889 brne 1893
1890 acc8= constant 159
1891 call writeLineAcc8
1892 br 1897
1893 acc16= constant 999
1894 call writeLineAcc16
1895 ;test15.j(272)   //final var word/acc word
1896 ;test15.j(273)   if (w2 & 0x0100 + 0x022C == 0x0224) println (160); else println (999);
1897 acc16= variable 4
1898 <acc16= constant 256
1899 acc16+ constant 556
1900 acc16And unstack16
1901 acc16Comp constant 548
1902 brne 1906
1903 acc8= constant 160
1904 call writeLineAcc8
1905 br 1909
1906 acc16= constant 999
1907 call writeLineAcc16
1908 ;test15.j(274)   if (w2 | 0x0100 + 0x022C == 0x133C) println (161); else println (999);
1909 acc16= variable 4
1910 <acc16= constant 256
1911 acc16+ constant 556
1912 acc16Or unstack16
1913 acc16Comp constant 4924
1914 brne 1918
1915 acc8= constant 161
1916 call writeLineAcc8
1917 br 1921
1918 acc16= constant 999
1919 call writeLineAcc16
1920 ;test15.j(275)   if (w2 ^ 0x0100 + 0x022C == 0x1118) println (162); else println (999);
1921 acc16= variable 4
1922 <acc16= constant 256
1923 acc16+ constant 556
1924 acc16Xor unstack16
1925 acc16Comp constant 4376
1926 brne 1930
1927 acc8= constant 162
1928 call writeLineAcc8
1929 br 1934
1930 acc16= constant 999
1931 call writeLineAcc16
1932 ;test15.j(276)   //final var byte/acc word
1933 ;test15.j(277)   if (b1 & 0x1000 + 0x0234 == 0x0014) println (163); else println (999);
1934 acc8= variable 0
1935 acc16= constant 4096
1936 acc16+ constant 564
1937 acc16And acc8
1938 acc8= constant 20
1939 acc16CompareAcc8
1940 brne 1944
1941 acc8= constant 163
1942 call writeLineAcc8
1943 br 1947
1944 acc16= constant 999
1945 call writeLineAcc16
1946 ;test15.j(278)   if (b1 | 0x1000 + 0x0234 == 0x123C) println (164); else println (999);
1947 acc8= variable 0
1948 acc16= constant 4096
1949 acc16+ constant 564
1950 acc16Or acc8
1951 acc16Comp constant 4668
1952 brne 1956
1953 acc8= constant 164
1954 call writeLineAcc8
1955 br 1959
1956 acc16= constant 999
1957 call writeLineAcc16
1958 ;test15.j(279)   if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (165); else println (999);
1959 acc8= variable 0
1960 acc16= constant 4096
1961 acc16+ constant 564
1962 acc16Xor acc8
1963 acc16Comp constant 4648
1964 brne 1968
1965 acc8= constant 165
1966 call writeLineAcc8
1967 br 1972
1968 acc16= constant 999
1969 call writeLineAcc16
1970 ;test15.j(280)   //final var word/acc byte
1971 ;test15.j(281)   if (w2 & 0x10 + 0x0C == 0x0014) println (166); else println (999);
1972 acc16= variable 4
1973 acc8= constant 16
1974 acc8+ constant 12
1975 acc16And acc8
1976 acc8= constant 20
1977 acc16CompareAcc8
1978 brne 1982
1979 acc8= constant 166
1980 call writeLineAcc8
1981 br 1985
1982 acc16= constant 999
1983 call writeLineAcc16
1984 ;test15.j(282)   if (w2 | 0x10 + 0x0C == 0x123C) println (167); else println (999);
1985 acc16= variable 4
1986 acc8= constant 16
1987 acc8+ constant 12
1988 acc16Or acc8
1989 acc16Comp constant 4668
1990 brne 1994
1991 acc8= constant 167
1992 call writeLineAcc8
1993 br 1997
1994 acc16= constant 999
1995 call writeLineAcc16
1996 ;test15.j(283)   if (w2 ^ 0x10 + 0x0C == 0x1228) println (168); else println (999);
1997 acc16= variable 4
1998 acc8= constant 16
1999 acc8+ constant 12
2000 acc16Xor acc8
2001 acc16Comp constant 4648
2002 brne 2006
2003 acc8= constant 168
2004 call writeLineAcc8
2005 br 2013
2006 acc16= constant 999
2007 call writeLineAcc16
2008 ;test15.j(284) 
2009 ;test15.j(285)   //final var/var
2010 ;test15.j(286)   //*************
2011 ;test15.j(287)   //final var byte/var byte
2012 ;test15.j(288)   if (b2 & b1 == 0x04) println (169); else println (999);
2013 acc8= variable 1
2014 acc8And variable 0
2015 acc8Comp constant 4
2016 brne 2020
2017 acc8= constant 169
2018 call writeLineAcc8
2019 br 2023
2020 acc16= constant 999
2021 call writeLineAcc16
2022 ;test15.j(289)   if (b2 | b1 == 0x1F) println (170); else println (999);
2023 acc8= variable 1
2024 acc8Or variable 0
2025 acc8Comp constant 31
2026 brne 2030
2027 acc8= constant 170
2028 call writeLineAcc8
2029 br 2033
2030 acc16= constant 999
2031 call writeLineAcc16
2032 ;test15.j(290)   if (b2 ^ b1 == 0x1B) println (171); else println (999);
2033 acc8= variable 1
2034 acc8Xor variable 0
2035 acc8Comp constant 27
2036 brne 2040
2037 acc8= constant 171
2038 call writeLineAcc8
2039 br 2044
2040 acc16= constant 999
2041 call writeLineAcc16
2042 ;test15.j(291)   //final var word/var word
2043 ;test15.j(292)   if (w2 & w1 == 0x0224) println (172); else println (999);
2044 acc16= variable 4
2045 acc16And variable 2
2046 acc16Comp constant 548
2047 brne 2051
2048 acc8= constant 172
2049 call writeLineAcc8
2050 br 2054
2051 acc16= constant 999
2052 call writeLineAcc16
2053 ;test15.j(293)   if (w2 | w1 == 0x133C) println (173); else println (999);
2054 acc16= variable 4
2055 acc16Or variable 2
2056 acc16Comp constant 4924
2057 brne 2061
2058 acc8= constant 173
2059 call writeLineAcc8
2060 br 2064
2061 acc16= constant 999
2062 call writeLineAcc16
2063 ;test15.j(294)   if (w2 ^ w1 == 0x1118) println (174); else println (999);
2064 acc16= variable 4
2065 acc16Xor variable 2
2066 acc16Comp constant 4376
2067 brne 2071
2068 acc8= constant 174
2069 call writeLineAcc8
2070 br 2075
2071 acc16= constant 999
2072 call writeLineAcc16
2073 ;test15.j(295)   //final var byte/var word
2074 ;test15.j(296)   if (b1 & w2 == 0x0014) println (175); else println (999);
2075 acc8= variable 0
2076 acc8ToAcc16
2077 acc16And variable 4
2078 acc8= constant 20
2079 acc16CompareAcc8
2080 brne 2084
2081 acc8= constant 175
2082 call writeLineAcc8
2083 br 2087
2084 acc16= constant 999
2085 call writeLineAcc16
2086 ;test15.j(297)   if (b1 | w2 == 0x123C) println (176); else println (999);
2087 acc8= variable 0
2088 acc8ToAcc16
2089 acc16Or variable 4
2090 acc16Comp constant 4668
2091 brne 2095
2092 acc8= constant 176
2093 call writeLineAcc8
2094 br 2098
2095 acc16= constant 999
2096 call writeLineAcc16
2097 ;test15.j(298)   if (b1 ^ w2 == 0x1228) println (177); else println (999);
2098 acc8= variable 0
2099 acc8ToAcc16
2100 acc16Xor variable 4
2101 acc16Comp constant 4648
2102 brne 2106
2103 acc8= constant 177
2104 call writeLineAcc8
2105 br 2110
2106 acc16= constant 999
2107 call writeLineAcc16
2108 ;test15.j(299)   //final var word/var byte
2109 ;test15.j(300)   if (w2 & b1 == 0x0014) println (178); else println (999);
2110 acc16= variable 4
2111 acc16And variable 0
2112 acc8= constant 20
2113 acc16CompareAcc8
2114 brne 2118
2115 acc8= constant 178
2116 call writeLineAcc8
2117 br 2121
2118 acc16= constant 999
2119 call writeLineAcc16
2120 ;test15.j(301)   if (w2 | b1 == 0x123C) println (179); else println (999);
2121 acc16= variable 4
2122 acc16Or variable 0
2123 acc16Comp constant 4668
2124 brne 2128
2125 acc8= constant 179
2126 call writeLineAcc8
2127 br 2131
2128 acc16= constant 999
2129 call writeLineAcc16
2130 ;test15.j(302)   if (w2 ^ b1 == 0x1228) println (180); else println (999);
2131 acc16= variable 4
2132 acc16Xor variable 0
2133 acc16Comp constant 4648
2134 brne 2138
2135 acc8= constant 180
2136 call writeLineAcc8
2137 br 2145
2138 acc16= constant 999
2139 call writeLineAcc16
2140 ;test15.j(303) 
2141 ;test15.j(304)   //final var/final var
2142 ;test15.j(305)   //*******************
2143 ;test15.j(306)   //final var byte/final var byte
2144 ;test15.j(307)   if (fb2 & fb1 == 0x04) println (181); else println (999);
2145 acc8= constant 7
2146 acc8And constant 28
2147 acc8Comp constant 4
2148 brne 2152
2149 acc8= constant 181
2150 call writeLineAcc8
2151 br 2155
2152 acc16= constant 999
2153 call writeLineAcc16
2154 ;test15.j(308)   if (fb2 | fb1 == 0x1F) println (182); else println (999);
2155 acc8= constant 7
2156 acc8Or constant 28
2157 acc8Comp constant 31
2158 brne 2162
2159 acc8= constant 182
2160 call writeLineAcc8
2161 br 2165
2162 acc16= constant 999
2163 call writeLineAcc16
2164 ;test15.j(309)   if (fb2 ^ fb1 == 0x1B) println (183); else println (999);
2165 acc8= constant 7
2166 acc8Xor constant 28
2167 acc8Comp constant 27
2168 brne 2172
2169 acc8= constant 183
2170 call writeLineAcc8
2171 br 2176
2172 acc16= constant 999
2173 call writeLineAcc16
2174 ;test15.j(310)   //final var word/final var word
2175 ;test15.j(311)   if (fw2 & fw1 == 0x0224) println (184); else println (999);
2176 acc16= constant 4660
2177 acc16And constant 812
2178 acc16Comp constant 548
2179 brne 2183
2180 acc8= constant 184
2181 call writeLineAcc8
2182 br 2186
2183 acc16= constant 999
2184 call writeLineAcc16
2185 ;test15.j(312)   if (fw2 | fw1 == 0x133C) println (185); else println (999);
2186 acc16= constant 4660
2187 acc16Or constant 812
2188 acc16Comp constant 4924
2189 brne 2193
2190 acc8= constant 185
2191 call writeLineAcc8
2192 br 2196
2193 acc16= constant 999
2194 call writeLineAcc16
2195 ;test15.j(313)   if (fw2 ^ fw1 == 0x1118) println (186); else println (999);
2196 acc16= constant 4660
2197 acc16Xor constant 812
2198 acc16Comp constant 4376
2199 brne 2203
2200 acc8= constant 186
2201 call writeLineAcc8
2202 br 2207
2203 acc16= constant 999
2204 call writeLineAcc16
2205 ;test15.j(314)   //final var byte/final var word
2206 ;test15.j(315)   if (fb1 & fw2 == 0x0014) println (187); else println (999);
2207 acc8= constant 28
2208 acc8ToAcc16
2209 acc16And constant 4660
2210 acc8= constant 20
2211 acc16CompareAcc8
2212 brne 2216
2213 acc8= constant 187
2214 call writeLineAcc8
2215 br 2219
2216 acc16= constant 999
2217 call writeLineAcc16
2218 ;test15.j(316)   if (fb1 | fw2 == 0x123C) println (188); else println (999);
2219 acc8= constant 28
2220 acc8ToAcc16
2221 acc16Or constant 4660
2222 acc16Comp constant 4668
2223 brne 2227
2224 acc8= constant 188
2225 call writeLineAcc8
2226 br 2230
2227 acc16= constant 999
2228 call writeLineAcc16
2229 ;test15.j(317)   if (fb1 ^ fw2 == 0x1228) println (189); else println (999);
2230 acc8= constant 28
2231 acc8ToAcc16
2232 acc16Xor constant 4660
2233 acc16Comp constant 4648
2234 brne 2238
2235 acc8= constant 189
2236 call writeLineAcc8
2237 br 2242
2238 acc16= constant 999
2239 call writeLineAcc16
2240 ;test15.j(318)   //final var word/final var byte
2241 ;test15.j(319)   if (fw2 & fb1 == 0x0014) println (190); else println (999);
2242 acc16= constant 4660
2243 acc16And constant 28
2244 acc8= constant 20
2245 acc16CompareAcc8
2246 brne 2250
2247 acc8= constant 190
2248 call writeLineAcc8
2249 br 2253
2250 acc16= constant 999
2251 call writeLineAcc16
2252 ;test15.j(320)   if (fw2 | fb1 == 0x123C) println (191); else println (999);
2253 acc16= constant 4660
2254 acc16Or constant 28
2255 acc16Comp constant 4668
2256 brne 2260
2257 acc8= constant 191
2258 call writeLineAcc8
2259 br 2263
2260 acc16= constant 999
2261 call writeLineAcc16
2262 ;test15.j(321)   if (fw2 ^ fb1 == 0x1228) println (192); else println (999);
2263 acc16= constant 4660
2264 acc16Xor constant 28
2265 acc16Comp constant 4648
2266 brne 2270
2267 acc8= constant 192
2268 call writeLineAcc8
2269 br 2274
2270 acc16= constant 999
2271 call writeLineAcc16
2272 ;test15.j(322) 
2273 ;test15.j(323)   println("Klaar");
2274 acc16= constant 2278
2275 writeLineString
2276 ;test15.j(324) }
2277 stop
2278 stringConstant 0 = "Klaar"
