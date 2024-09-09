   0 call 6
   1 stop
   2 ;testBitwiseOperators.j(0) /* Program to test bitwise operators and, or and xor. */
   3 ;testBitwiseOperators.j(1) class TestBitwiseOperators {
   4 class TestBitwiseOperators []
   5 ;testBitwiseOperators.j(2)   private static byte b1 = 0x1C;
   6 acc8= constant 28
   7 acc8=> variable 0
   8 ;testBitwiseOperators.j(3)   private static byte b2 = 0x07;
   9 acc8= constant 7
  10 acc8=> variable 1
  11 ;testBitwiseOperators.j(4)   private static word w1 = 0x032C;
  12 acc16= constant 812
  13 acc16=> variable 2
  14 ;testBitwiseOperators.j(5)   private static word w2 = 0x1234;
  15 acc16= constant 4660
  16 acc16=> variable 4
  17 br 24
  18 ;testBitwiseOperators.j(6)   private static final byte fb1 = 0x1C;
  19 ;testBitwiseOperators.j(7)   private static final byte fb2 = 0x07;
  20 ;testBitwiseOperators.j(8)   private static final word fw1 = 0x032C;
  21 ;testBitwiseOperators.j(9)   private static final word fw2 = 0x1234;
  22 ;testBitwiseOperators.j(10) 
  23 ;testBitwiseOperators.j(11)   public static void main() {
  24 method TestBitwiseOperators.main [public, static] void ()
  25 <basePointer
  26 basePointer= stackPointer
  27 stackPointer+ constant 0
  28 ;testBitwiseOperators.j(12)     println(0);
  29 acc8= constant 0
  30 writeLineAcc8
  31 ;testBitwiseOperators.j(13)     
  32 ;testBitwiseOperators.j(14)     // Possible operand types: constant, acc, var, final var, stack8, stack16.
  33 ;testBitwiseOperators.j(15)     // Possible data types: byte, word.
  34 ;testBitwiseOperators.j(16)   
  35 ;testBitwiseOperators.j(17)     //constant/constant
  36 ;testBitwiseOperators.j(18)     //*****************
  37 ;testBitwiseOperators.j(19)     //constant byte/constant byte
  38 ;testBitwiseOperators.j(20)     if (0x07 & 0x1C == 0x04) println (1); else println (999); //0000.0111 & 0001.1100 = 0000.0100
  39 acc8= constant 7
  40 acc8And constant 28
  41 acc8Comp constant 4
  42 brne 48
  43 acc8= constant 1
  44 writeLineAcc8
  45 br 51
  46 acc16= constant 999
  47 writeLineAcc16
  48 ;testBitwiseOperators.j(21)     if (0x07 | 0x1C == 0x1F) println (2); else println (999); //0000.0111 | 0001.1100 = 0001.1111
  49 acc8= constant 7
  50 acc8Or constant 28
  51 acc8Comp constant 31
  52 brne 60
  53 acc8= constant 2
  54 writeLineAcc8
  55 br 63
  56 acc16= constant 999
  57 writeLineAcc16
  58 ;testBitwiseOperators.j(22)     if (0x07 ^ 0x1C == 0x1B) println (3); else println (999); //0000.0111 ^ 0001.1100 = 0001.1011
  59 acc8= constant 7
  60 acc8Xor constant 28
  61 acc8Comp constant 27
  62 brne 72
  63 acc8= constant 3
  64 writeLineAcc8
  65 br 76
  66 acc16= constant 999
  67 writeLineAcc16
  68 ;testBitwiseOperators.j(23)     //constant word/constant word
  69 ;testBitwiseOperators.j(24)     if (0x1234 & 0x032C == 0x0224) println (4); else println (999);
  70 acc16= constant 4660
  71 acc16And constant 812
  72 acc16Comp constant 548
  73 brne 85
  74 acc8= constant 4
  75 writeLineAcc8
  76 br 89
  77 acc16= constant 999
  78 writeLineAcc16
  79 ;testBitwiseOperators.j(25)     //0001.0010.0011.0100 & 0000.0011.0010.1100 = 0000.0010.0010.0100
  80 ;testBitwiseOperators.j(26)     if (0x1234 | 0x032C == 0x133C) println (5); else println (999);
  81 acc16= constant 4660
  82 acc16Or constant 812
  83 acc16Comp constant 4924
  84 brne 98
  85 acc8= constant 5
  86 writeLineAcc8
  87 br 102
  88 acc16= constant 999
  89 writeLineAcc16
  90 ;testBitwiseOperators.j(27)     //0001.0010.0011.0100 | 0000.0011.0010.1100 = 0001.0011.0011.1100
  91 ;testBitwiseOperators.j(28)     if (0x1234 ^ 0x032C == 0x1118) println (6); else println (999);
  92 acc16= constant 4660
  93 acc16Xor constant 812
  94 acc16Comp constant 4376
  95 brne 111
  96 acc8= constant 6
  97 writeLineAcc8
  98 br 116
  99 acc16= constant 999
 100 writeLineAcc16
 101 ;testBitwiseOperators.j(29)     //0001.0010.0011.0100 ^ 0000.0011.0010.1100 = 0001.0001.0001.1000
 102 ;testBitwiseOperators.j(30)     //constant byte/constant word
 103 ;testBitwiseOperators.j(31)     if (0x1C & 0x1234 == 0x0014) println (7); else println (999); //0001.1100 & 0001.0010.0011.0100 = 0000.0000.0001.0100
 104 acc8= constant 28
 105 acc8ToAcc16
 106 acc16And constant 4660
 107 acc8= constant 20
 108 acc16CompareAcc8
 109 brne 127
 110 acc8= constant 7
 111 writeLineAcc8
 112 br 130
 113 acc16= constant 999
 114 writeLineAcc16
 115 ;testBitwiseOperators.j(32)     if (0x1C | 0x1234 == 0x123C) println (8); else println (999); //0001.1100 | 0001.0010.0011.0100 = 0001.0010.0011.1100
 116 acc8= constant 28
 117 acc8ToAcc16
 118 acc16Or constant 4660
 119 acc16Comp constant 4668
 120 brne 140
 121 acc8= constant 8
 122 writeLineAcc8
 123 br 143
 124 acc16= constant 999
 125 writeLineAcc16
 126 ;testBitwiseOperators.j(33)     if (0x1C ^ 0x1234 == 0x1228) println (9); else println (999); //0001.1100 ^ 0001.0010.0011.0100 = 0001.0010.0010.1000
 127 acc8= constant 28
 128 acc8ToAcc16
 129 acc16Xor constant 4660
 130 acc16Comp constant 4648
 131 brne 153
 132 acc8= constant 9
 133 writeLineAcc8
 134 br 157
 135 acc16= constant 999
 136 writeLineAcc16
 137 ;testBitwiseOperators.j(34)     //constant word/constant byte
 138 ;testBitwiseOperators.j(35)     if (0x1234 & 0x1C == 0x0014) println (10); else println (999); //0001.0010.0011.0100 & 0001.1100 = 0000.0000.0001.0100
 139 acc16= constant 4660
 140 acc16And constant 28
 141 acc8= constant 20
 142 acc16CompareAcc8
 143 brne 167
 144 acc8= constant 10
 145 writeLineAcc8
 146 br 170
 147 acc16= constant 999
 148 writeLineAcc16
 149 ;testBitwiseOperators.j(36)     if (0x1234 | 0x1C == 0x123C) println (11); else println (999); //0001.0010.0011.0100 | 0001.1100 = 0001.0010.0011.1100
 150 acc16= constant 4660
 151 acc16Or constant 28
 152 acc16Comp constant 4668
 153 brne 179
 154 acc8= constant 11
 155 writeLineAcc8
 156 br 182
 157 acc16= constant 999
 158 writeLineAcc16
 159 ;testBitwiseOperators.j(37)     if (0x1234 ^ 0x1C == 0x1228) println (12); else println (999); //0001.0010.0011.0100 ^ 0001.1100 = 0001.0010.0010.1000
 160 acc16= constant 4660
 161 acc16Xor constant 28
 162 acc16Comp constant 4648
 163 brne 191
 164 acc8= constant 12
 165 writeLineAcc8
 166 br 198
 167 acc16= constant 999
 168 writeLineAcc16
 169 ;testBitwiseOperators.j(38)   
 170 ;testBitwiseOperators.j(39)     //constant/acc
 171 ;testBitwiseOperators.j(40)     //************
 172 ;testBitwiseOperators.j(41)     //constant byte/acc byte
 173 ;testBitwiseOperators.j(42)     if (0x07 & (0x10 + 0x0C) == 0x04) println (13); else println (999);
 174 acc8= constant 7
 175 <acc8= constant 16
 176 acc8+ constant 12
 177 acc8And unstack8
 178 acc8Comp constant 4
 179 brne 209
 180 acc8= constant 13
 181 writeLineAcc8
 182 br 212
 183 acc16= constant 999
 184 writeLineAcc16
 185 ;testBitwiseOperators.j(43)     if (0x07 | (0x10 + 0x0C) == 0x1F) println (14); else println (999);
 186 acc8= constant 7
 187 <acc8= constant 16
 188 acc8+ constant 12
 189 acc8Or unstack8
 190 acc8Comp constant 31
 191 brne 223
 192 acc8= constant 14
 193 writeLineAcc8
 194 br 226
 195 acc16= constant 999
 196 writeLineAcc16
 197 ;testBitwiseOperators.j(44)     if (0x07 ^ (0x10 + 0x0C) == 0x1B) println (15); else println (999);
 198 acc8= constant 7
 199 <acc8= constant 16
 200 acc8+ constant 12
 201 acc8Xor unstack8
 202 acc8Comp constant 27
 203 brne 237
 204 acc8= constant 15
 205 writeLineAcc8
 206 br 241
 207 acc16= constant 999
 208 writeLineAcc16
 209 ;testBitwiseOperators.j(45)     //constant word/acc word
 210 ;testBitwiseOperators.j(46)     if (0x1234 & 0x0100 + 0x022C == 0x0224) println (16); else println (999);
 211 acc16= constant 4660
 212 <acc16= constant 256
 213 acc16+ constant 556
 214 acc16And unstack16
 215 acc16Comp constant 548
 216 brne 252
 217 acc8= constant 16
 218 writeLineAcc8
 219 br 255
 220 acc16= constant 999
 221 writeLineAcc16
 222 ;testBitwiseOperators.j(47)     if (0x1234 | 0x0100 + 0x022C == 0x133C) println (17); else println (999);
 223 acc16= constant 4660
 224 <acc16= constant 256
 225 acc16+ constant 556
 226 acc16Or unstack16
 227 acc16Comp constant 4924
 228 brne 266
 229 acc8= constant 17
 230 writeLineAcc8
 231 br 269
 232 acc16= constant 999
 233 writeLineAcc16
 234 ;testBitwiseOperators.j(48)     if (0x1234 ^ 0x0100 + 0x022C == 0x1118) println (18); else println (999);
 235 acc16= constant 4660
 236 <acc16= constant 256
 237 acc16+ constant 556
 238 acc16Xor unstack16
 239 acc16Comp constant 4376
 240 brne 280
 241 acc8= constant 18
 242 writeLineAcc8
 243 br 284
 244 acc16= constant 999
 245 writeLineAcc16
 246 ;testBitwiseOperators.j(49)     //constant byte/acc word
 247 ;testBitwiseOperators.j(50)     if (0x1C & 0x1000 + 0x0234 == 0x0014) println (19); else println (999);
 248 acc8= constant 28
 249 acc16= constant 4096
 250 acc16+ constant 564
 251 acc16And acc8
 252 acc8= constant 20
 253 acc16CompareAcc8
 254 brne 296
 255 acc8= constant 19
 256 writeLineAcc8
 257 br 299
 258 acc16= constant 999
 259 writeLineAcc16
 260 ;testBitwiseOperators.j(51)     if (0x1C | 0x1000 + 0x0234 == 0x123C) println (20); else println (999);
 261 acc8= constant 28
 262 acc16= constant 4096
 263 acc16+ constant 564
 264 acc16Or acc8
 265 acc16Comp constant 4668
 266 brne 310
 267 acc8= constant 20
 268 writeLineAcc8
 269 br 313
 270 acc16= constant 999
 271 writeLineAcc16
 272 ;testBitwiseOperators.j(52)     if (0x1C ^ 0x1000 + 0x0234 == 0x1228) println (21); else println (999);
 273 acc8= constant 28
 274 acc16= constant 4096
 275 acc16+ constant 564
 276 acc16Xor acc8
 277 acc16Comp constant 4648
 278 brne 324
 279 acc8= constant 21
 280 writeLineAcc8
 281 br 328
 282 acc16= constant 999
 283 writeLineAcc16
 284 ;testBitwiseOperators.j(53)     //constant word/acc byte
 285 ;testBitwiseOperators.j(54)     if (0x1234 & 0x10 + 0x0C == 0x0014) println (22); else println (999);
 286 acc16= constant 4660
 287 acc8= constant 16
 288 acc8+ constant 12
 289 acc16And acc8
 290 acc8= constant 20
 291 acc16CompareAcc8
 292 brne 340
 293 acc8= constant 22
 294 writeLineAcc8
 295 br 343
 296 acc16= constant 999
 297 writeLineAcc16
 298 ;testBitwiseOperators.j(55)     if (0x1234 | 0x10 + 0x0C == 0x123C) println (23); else println (999);
 299 acc16= constant 4660
 300 acc8= constant 16
 301 acc8+ constant 12
 302 acc16Or acc8
 303 acc16Comp constant 4668
 304 brne 354
 305 acc8= constant 23
 306 writeLineAcc8
 307 br 357
 308 acc16= constant 999
 309 writeLineAcc16
 310 ;testBitwiseOperators.j(56)     if (0x1234 ^ 0x10 + 0x0C == 0x1228) println (24); else println (999);
 311 acc16= constant 4660
 312 acc8= constant 16
 313 acc8+ constant 12
 314 acc16Xor acc8
 315 acc16Comp constant 4648
 316 brne 368
 317 acc8= constant 24
 318 writeLineAcc8
 319 br 375
 320 acc16= constant 999
 321 writeLineAcc16
 322 ;testBitwiseOperators.j(57)   
 323 ;testBitwiseOperators.j(58)     //constant/var
 324 ;testBitwiseOperators.j(59)     //*****************
 325 ;testBitwiseOperators.j(60)     //constant byte/var byte
 326 ;testBitwiseOperators.j(61)     if (0x07 & b1 == 0x04) println (25); else println (999);
 327 acc8= constant 7
 328 acc8And variable 0
 329 acc8Comp constant 4
 330 brne 384
 331 acc8= constant 25
 332 writeLineAcc8
 333 br 387
 334 acc16= constant 999
 335 writeLineAcc16
 336 ;testBitwiseOperators.j(62)     if (0x07 | b1 == 0x1F) println (26); else println (999);
 337 acc8= constant 7
 338 acc8Or variable 0
 339 acc8Comp constant 31
 340 brne 396
 341 acc8= constant 26
 342 writeLineAcc8
 343 br 399
 344 acc16= constant 999
 345 writeLineAcc16
 346 ;testBitwiseOperators.j(63)     if (0x07 ^ b1 == 0x1B) println (27); else println (999);
 347 acc8= constant 7
 348 acc8Xor variable 0
 349 acc8Comp constant 27
 350 brne 408
 351 acc8= constant 27
 352 writeLineAcc8
 353 br 412
 354 acc16= constant 999
 355 writeLineAcc16
 356 ;testBitwiseOperators.j(64)     //constant word/var word
 357 ;testBitwiseOperators.j(65)     if (0x1234 & w1 == 0x0224) println (28); else println (999);
 358 acc16= constant 4660
 359 acc16And variable 2
 360 acc16Comp constant 548
 361 brne 421
 362 acc8= constant 28
 363 writeLineAcc8
 364 br 424
 365 acc16= constant 999
 366 writeLineAcc16
 367 ;testBitwiseOperators.j(66)     if (0x1234 | w1 == 0x133C) println (29); else println (999);
 368 acc16= constant 4660
 369 acc16Or variable 2
 370 acc16Comp constant 4924
 371 brne 433
 372 acc8= constant 29
 373 writeLineAcc8
 374 br 436
 375 acc16= constant 999
 376 writeLineAcc16
 377 ;testBitwiseOperators.j(67)     if (0x1234 ^ w1 == 0x1118) println (30); else println (999);
 378 acc16= constant 4660
 379 acc16Xor variable 2
 380 acc16Comp constant 4376
 381 brne 445
 382 acc8= constant 30
 383 writeLineAcc8
 384 br 449
 385 acc16= constant 999
 386 writeLineAcc16
 387 ;testBitwiseOperators.j(68)     //constant byte/var word
 388 ;testBitwiseOperators.j(69)     if (0x1C & w2 == 0x0014) println (31); else println (999);
 389 acc8= constant 28
 390 acc8ToAcc16
 391 acc16And variable 4
 392 acc8= constant 20
 393 acc16CompareAcc8
 394 brne 460
 395 acc8= constant 31
 396 writeLineAcc8
 397 br 463
 398 acc16= constant 999
 399 writeLineAcc16
 400 ;testBitwiseOperators.j(70)     if (0x1C | w2 == 0x123C) println (32); else println (999);
 401 acc8= constant 28
 402 acc8ToAcc16
 403 acc16Or variable 4
 404 acc16Comp constant 4668
 405 brne 473
 406 acc8= constant 32
 407 writeLineAcc8
 408 br 476
 409 acc16= constant 999
 410 writeLineAcc16
 411 ;testBitwiseOperators.j(71)     if (0x1C ^ w2 == 0x1228) println (33); else println (999);
 412 acc8= constant 28
 413 acc8ToAcc16
 414 acc16Xor variable 4
 415 acc16Comp constant 4648
 416 brne 486
 417 acc8= constant 33
 418 writeLineAcc8
 419 br 490
 420 acc16= constant 999
 421 writeLineAcc16
 422 ;testBitwiseOperators.j(72)     //constant word/var byte
 423 ;testBitwiseOperators.j(73)     if (0x1234 & b1 == 0x0014) println (34); else println (999);
 424 acc16= constant 4660
 425 acc16And variable 0
 426 acc8= constant 20
 427 acc16CompareAcc8
 428 brne 500
 429 acc8= constant 34
 430 writeLineAcc8
 431 br 503
 432 acc16= constant 999
 433 writeLineAcc16
 434 ;testBitwiseOperators.j(74)     if (0x1234 | b1 == 0x123C) println (35); else println (999);
 435 acc16= constant 4660
 436 acc16Or variable 0
 437 acc16Comp constant 4668
 438 brne 512
 439 acc8= constant 35
 440 writeLineAcc8
 441 br 515
 442 acc16= constant 999
 443 writeLineAcc16
 444 ;testBitwiseOperators.j(75)     if (0x1234 ^ b1 == 0x1228) println (36); else println (999);
 445 acc16= constant 4660
 446 acc16Xor variable 0
 447 acc16Comp constant 4648
 448 brne 524
 449 acc8= constant 36
 450 writeLineAcc8
 451 br 531
 452 acc16= constant 999
 453 writeLineAcc16
 454 ;testBitwiseOperators.j(76)   
 455 ;testBitwiseOperators.j(77)     //constant/final var
 456 ;testBitwiseOperators.j(78)     //*****************
 457 ;testBitwiseOperators.j(79)     //constant byte/final var byte
 458 ;testBitwiseOperators.j(80)     if (0x07 & fb1 == 0x04) println (37); else println (999);
 459 acc8= constant 7
 460 acc8And constant 28
 461 acc8Comp constant 4
 462 brne 540
 463 acc8= constant 37
 464 writeLineAcc8
 465 br 543
 466 acc16= constant 999
 467 writeLineAcc16
 468 ;testBitwiseOperators.j(81)     if (0x07 | fb1 == 0x1F) println (38); else println (999);
 469 acc8= constant 7
 470 acc8Or constant 28
 471 acc8Comp constant 31
 472 brne 552
 473 acc8= constant 38
 474 writeLineAcc8
 475 br 555
 476 acc16= constant 999
 477 writeLineAcc16
 478 ;testBitwiseOperators.j(82)     if (0x07 ^ fb1 == 0x1B) println (39); else println (999);
 479 acc8= constant 7
 480 acc8Xor constant 28
 481 acc8Comp constant 27
 482 brne 564
 483 acc8= constant 39
 484 writeLineAcc8
 485 br 568
 486 acc16= constant 999
 487 writeLineAcc16
 488 ;testBitwiseOperators.j(83)     //constant word/final var word
 489 ;testBitwiseOperators.j(84)     if (0x1234 & fw1 == 0x0224) println (40); else println (999);
 490 acc16= constant 4660
 491 acc16And constant 812
 492 acc16Comp constant 548
 493 brne 577
 494 acc8= constant 40
 495 writeLineAcc8
 496 br 580
 497 acc16= constant 999
 498 writeLineAcc16
 499 ;testBitwiseOperators.j(85)     if (0x1234 | fw1 == 0x133C) println (41); else println (999);
 500 acc16= constant 4660
 501 acc16Or constant 812
 502 acc16Comp constant 4924
 503 brne 589
 504 acc8= constant 41
 505 writeLineAcc8
 506 br 592
 507 acc16= constant 999
 508 writeLineAcc16
 509 ;testBitwiseOperators.j(86)     if (0x1234 ^ fw1 == 0x1118) println (42); else println (999);
 510 acc16= constant 4660
 511 acc16Xor constant 812
 512 acc16Comp constant 4376
 513 brne 601
 514 acc8= constant 42
 515 writeLineAcc8
 516 br 605
 517 acc16= constant 999
 518 writeLineAcc16
 519 ;testBitwiseOperators.j(87)     //constant byte/final var word
 520 ;testBitwiseOperators.j(88)     if (0x1C & fw2 == 0x0014) println (43); else println (999);
 521 acc8= constant 28
 522 acc8ToAcc16
 523 acc16And constant 4660
 524 acc8= constant 20
 525 acc16CompareAcc8
 526 brne 616
 527 acc8= constant 43
 528 writeLineAcc8
 529 br 619
 530 acc16= constant 999
 531 writeLineAcc16
 532 ;testBitwiseOperators.j(89)     if (0x1C | fw2 == 0x123C) println (44); else println (999);
 533 acc8= constant 28
 534 acc8ToAcc16
 535 acc16Or constant 4660
 536 acc16Comp constant 4668
 537 brne 629
 538 acc8= constant 44
 539 writeLineAcc8
 540 br 632
 541 acc16= constant 999
 542 writeLineAcc16
 543 ;testBitwiseOperators.j(90)     if (0x1C ^ fw2 == 0x1228) println (45); else println (999);
 544 acc8= constant 28
 545 acc8ToAcc16
 546 acc16Xor constant 4660
 547 acc16Comp constant 4648
 548 brne 642
 549 acc8= constant 45
 550 writeLineAcc8
 551 br 646
 552 acc16= constant 999
 553 writeLineAcc16
 554 ;testBitwiseOperators.j(91)     //constant word/final var byte
 555 ;testBitwiseOperators.j(92)     if (0x1234 & fb1 == 0x0014) println (46); else println (999);
 556 acc16= constant 4660
 557 acc16And constant 28
 558 acc8= constant 20
 559 acc16CompareAcc8
 560 brne 656
 561 acc8= constant 46
 562 writeLineAcc8
 563 br 659
 564 acc16= constant 999
 565 writeLineAcc16
 566 ;testBitwiseOperators.j(93)     if (0x1234 | fb1 == 0x123C) println (47); else println (999);
 567 acc16= constant 4660
 568 acc16Or constant 28
 569 acc16Comp constant 4668
 570 brne 668
 571 acc8= constant 47
 572 writeLineAcc8
 573 br 671
 574 acc16= constant 999
 575 writeLineAcc16
 576 ;testBitwiseOperators.j(94)     if (0x1234 ^ fb1 == 0x1228) println (48); else println (999);
 577 acc16= constant 4660
 578 acc16Xor constant 28
 579 acc16Comp constant 4648
 580 brne 680
 581 acc8= constant 48
 582 writeLineAcc8
 583 br 687
 584 acc16= constant 999
 585 writeLineAcc16
 586 ;testBitwiseOperators.j(95)   
 587 ;testBitwiseOperators.j(96)     //acc/constant
 588 ;testBitwiseOperators.j(97)     //************
 589 ;testBitwiseOperators.j(98)     //acc byte/constant byte
 590 ;testBitwiseOperators.j(99)     if ((0x04 + 0x03) & 0x1C == 0x04) println (49); else println (999);
 591 acc8= constant 4
 592 acc8+ constant 3
 593 acc8And constant 28
 594 acc8Comp constant 4
 595 brne 697
 596 acc8= constant 49
 597 writeLineAcc8
 598 br 700
 599 acc16= constant 999
 600 writeLineAcc16
 601 ;testBitwiseOperators.j(100)     if ((0x04 + 0x03) | 0x1C == 0x1F) println (50); else println (999);
 602 acc8= constant 4
 603 acc8+ constant 3
 604 acc8Or constant 28
 605 acc8Comp constant 31
 606 brne 710
 607 acc8= constant 50
 608 writeLineAcc8
 609 br 713
 610 acc16= constant 999
 611 writeLineAcc16
 612 ;testBitwiseOperators.j(101)     if ((0x04 + 0x03) ^ 0x1C == 0x1B) println (51); else println (999);
 613 acc8= constant 4
 614 acc8+ constant 3
 615 acc8Xor constant 28
 616 acc8Comp constant 27
 617 brne 723
 618 acc8= constant 51
 619 writeLineAcc8
 620 br 727
 621 acc16= constant 999
 622 writeLineAcc16
 623 ;testBitwiseOperators.j(102)     //acc word/constant word
 624 ;testBitwiseOperators.j(103)     if (0x1000 + 0x0234 & 0x032C == 0x0224) println (52); else println (999);
 625 acc16= constant 4096
 626 acc16+ constant 564
 627 acc16And constant 812
 628 acc16Comp constant 548
 629 brne 737
 630 acc8= constant 52
 631 writeLineAcc8
 632 br 740
 633 acc16= constant 999
 634 writeLineAcc16
 635 ;testBitwiseOperators.j(104)     if (0x1000 + 0x0234 | 0x032C == 0x133C) println (53); else println (999);
 636 acc16= constant 4096
 637 acc16+ constant 564
 638 acc16Or constant 812
 639 acc16Comp constant 4924
 640 brne 750
 641 acc8= constant 53
 642 writeLineAcc8
 643 br 753
 644 acc16= constant 999
 645 writeLineAcc16
 646 ;testBitwiseOperators.j(105)     if (0x1000 + 0x0234 ^ 0x032C == 0x1118) println (54); else println (999);
 647 acc16= constant 4096
 648 acc16+ constant 564
 649 acc16Xor constant 812
 650 acc16Comp constant 4376
 651 brne 763
 652 acc8= constant 54
 653 writeLineAcc8
 654 br 767
 655 acc16= constant 999
 656 writeLineAcc16
 657 ;testBitwiseOperators.j(106)     //acc byte/constant word
 658 ;testBitwiseOperators.j(107)     if (0x10 + 0x0C & 0x1234 == 0x0014) println (55); else println (999);
 659 acc8= constant 16
 660 acc8+ constant 12
 661 acc8ToAcc16
 662 acc16And constant 4660
 663 acc8= constant 20
 664 acc16CompareAcc8
 665 brne 779
 666 acc8= constant 55
 667 writeLineAcc8
 668 br 782
 669 acc16= constant 999
 670 writeLineAcc16
 671 ;testBitwiseOperators.j(108)     if (0x10 + 0x0C | 0x1234 == 0x123C) println (56); else println (999);
 672 acc8= constant 16
 673 acc8+ constant 12
 674 acc8ToAcc16
 675 acc16Or constant 4660
 676 acc16Comp constant 4668
 677 brne 793
 678 acc8= constant 56
 679 writeLineAcc8
 680 br 796
 681 acc16= constant 999
 682 writeLineAcc16
 683 ;testBitwiseOperators.j(109)     if (0x10 + 0x0C ^ 0x1234 == 0x1228) println (57); else println (999);
 684 acc8= constant 16
 685 acc8+ constant 12
 686 acc8ToAcc16
 687 acc16Xor constant 4660
 688 acc16Comp constant 4648
 689 brne 807
 690 acc8= constant 57
 691 writeLineAcc8
 692 br 811
 693 acc16= constant 999
 694 writeLineAcc16
 695 ;testBitwiseOperators.j(110)     //acc word/constant byte
 696 ;testBitwiseOperators.j(111)     if (0x1000 + 0x0234 & 0x1C == 0x0014) println (58); else println (999);
 697 acc16= constant 4096
 698 acc16+ constant 564
 699 acc16And constant 28
 700 acc8= constant 20
 701 acc16CompareAcc8
 702 brne 822
 703 acc8= constant 58
 704 writeLineAcc8
 705 br 825
 706 acc16= constant 999
 707 writeLineAcc16
 708 ;testBitwiseOperators.j(112)     if (0x1000 + 0x0234 | 0x1C == 0x123C) println (59); else println (999);
 709 acc16= constant 4096
 710 acc16+ constant 564
 711 acc16Or constant 28
 712 acc16Comp constant 4668
 713 brne 835
 714 acc8= constant 59
 715 writeLineAcc8
 716 br 838
 717 acc16= constant 999
 718 writeLineAcc16
 719 ;testBitwiseOperators.j(113)     if (0x1000 + 0x0234 ^ 0x1C == 0x1228) println (60); else println (999);
 720 acc16= constant 4096
 721 acc16+ constant 564
 722 acc16Xor constant 28
 723 acc16Comp constant 4648
 724 brne 848
 725 acc8= constant 60
 726 writeLineAcc8
 727 br 855
 728 acc16= constant 999
 729 writeLineAcc16
 730 ;testBitwiseOperators.j(114)   
 731 ;testBitwiseOperators.j(115)     //acc/acc
 732 ;testBitwiseOperators.j(116)     //*******
 733 ;testBitwiseOperators.j(117)     //acc byte/acc byte
 734 ;testBitwiseOperators.j(118)     if (0x04 + 0x03 & 0x10 + 0x0C == 0x04) println (61); else println (999);
 735 acc8= constant 4
 736 acc8+ constant 3
 737 <acc8= constant 16
 738 acc8+ constant 12
 739 acc8And unstack8
 740 acc8Comp constant 4
 741 brne 867
 742 acc8= constant 61
 743 writeLineAcc8
 744 br 870
 745 acc16= constant 999
 746 writeLineAcc16
 747 ;testBitwiseOperators.j(119)     if (0x04 + 0x03 | 0x10 + 0x0C == 0x1F) println (62); else println (999);
 748 acc8= constant 4
 749 acc8+ constant 3
 750 <acc8= constant 16
 751 acc8+ constant 12
 752 acc8Or unstack8
 753 acc8Comp constant 31
 754 brne 882
 755 acc8= constant 62
 756 writeLineAcc8
 757 br 885
 758 acc16= constant 999
 759 writeLineAcc16
 760 ;testBitwiseOperators.j(120)     if (0x04 + 0x03 ^ 0x10 + 0x0C == 0x1B) println (63); else println (999);
 761 acc8= constant 4
 762 acc8+ constant 3
 763 <acc8= constant 16
 764 acc8+ constant 12
 765 acc8Xor unstack8
 766 acc8Comp constant 27
 767 brne 897
 768 acc8= constant 63
 769 writeLineAcc8
 770 br 901
 771 acc16= constant 999
 772 writeLineAcc16
 773 ;testBitwiseOperators.j(121)     //acc word/acc word
 774 ;testBitwiseOperators.j(122)     if (0x1000 + 0x0234 & 0x0100 + 0x022C == 0x0224) println (64); else println (999);
 775 acc16= constant 4096
 776 acc16+ constant 564
 777 <acc16= constant 256
 778 acc16+ constant 556
 779 acc16And unstack16
 780 acc16Comp constant 548
 781 brne 913
 782 acc8= constant 64
 783 writeLineAcc8
 784 br 916
 785 acc16= constant 999
 786 writeLineAcc16
 787 ;testBitwiseOperators.j(123)     if (0x1000 + 0x0234 | 0x0100 + 0x022C == 0x133C) println (65); else println (999);
 788 acc16= constant 4096
 789 acc16+ constant 564
 790 <acc16= constant 256
 791 acc16+ constant 556
 792 acc16Or unstack16
 793 acc16Comp constant 4924
 794 brne 928
 795 acc8= constant 65
 796 writeLineAcc8
 797 br 931
 798 acc16= constant 999
 799 writeLineAcc16
 800 ;testBitwiseOperators.j(124)     if (0x1000 + 0x0234 ^ 0x0100 + 0x022C == 0x1118) println (66); else println (999);
 801 acc16= constant 4096
 802 acc16+ constant 564
 803 <acc16= constant 256
 804 acc16+ constant 556
 805 acc16Xor unstack16
 806 acc16Comp constant 4376
 807 brne 943
 808 acc8= constant 66
 809 writeLineAcc8
 810 br 947
 811 acc16= constant 999
 812 writeLineAcc16
 813 ;testBitwiseOperators.j(125)     //acc byte/acc word
 814 ;testBitwiseOperators.j(126)     if (0x10 + 0x0C & 0x1000 + 0x0234 == 0x0014) println (67); else println (999);
 815 acc8= constant 16
 816 acc8+ constant 12
 817 acc16= constant 4096
 818 acc16+ constant 564
 819 acc16And acc8
 820 acc8= constant 20
 821 acc16CompareAcc8
 822 brne 960
 823 acc8= constant 67
 824 writeLineAcc8
 825 br 963
 826 acc16= constant 999
 827 writeLineAcc16
 828 ;testBitwiseOperators.j(127)     if (0x10 + 0x0C | 0x1000 + 0x0234 == 0x123C) println (68); else println (999);
 829 acc8= constant 16
 830 acc8+ constant 12
 831 acc16= constant 4096
 832 acc16+ constant 564
 833 acc16Or acc8
 834 acc16Comp constant 4668
 835 brne 975
 836 acc8= constant 68
 837 writeLineAcc8
 838 br 978
 839 acc16= constant 999
 840 writeLineAcc16
 841 ;testBitwiseOperators.j(128)     if (0x10 + 0x0C ^ 0x1000 + 0x0234 == 0x1228) println (69); else println (999);
 842 acc8= constant 16
 843 acc8+ constant 12
 844 acc16= constant 4096
 845 acc16+ constant 564
 846 acc16Xor acc8
 847 acc16Comp constant 4648
 848 brne 990
 849 acc8= constant 69
 850 writeLineAcc8
 851 br 994
 852 acc16= constant 999
 853 writeLineAcc16
 854 ;testBitwiseOperators.j(129)     //acc word/acc byte
 855 ;testBitwiseOperators.j(130)     if (0x1000 + 0x0234 & 0x10 + 0x0C == 0x0014) println (70); else println (999);
 856 acc16= constant 4096
 857 acc16+ constant 564
 858 acc8= constant 16
 859 acc8+ constant 12
 860 acc16And acc8
 861 acc8= constant 20
 862 acc16CompareAcc8
 863 brne 1007
 864 acc8= constant 70
 865 writeLineAcc8
 866 br 1010
 867 acc16= constant 999
 868 writeLineAcc16
 869 ;testBitwiseOperators.j(131)     if (0x1000 + 0x0234 | 0x10 + 0x0C == 0x123C) println (71); else println (999);
 870 acc16= constant 4096
 871 acc16+ constant 564
 872 acc8= constant 16
 873 acc8+ constant 12
 874 acc16Or acc8
 875 acc16Comp constant 4668
 876 brne 1022
 877 acc8= constant 71
 878 writeLineAcc8
 879 br 1025
 880 acc16= constant 999
 881 writeLineAcc16
 882 ;testBitwiseOperators.j(132)     if (0x1000 + 0x0234 ^ 0x10 + 0x0C == 0x1228) println (72); else println (999);
 883 acc16= constant 4096
 884 acc16+ constant 564
 885 acc8= constant 16
 886 acc8+ constant 12
 887 acc16Xor acc8
 888 acc16Comp constant 4648
 889 brne 1037
 890 acc8= constant 72
 891 writeLineAcc8
 892 br 1044
 893 acc16= constant 999
 894 writeLineAcc16
 895 ;testBitwiseOperators.j(133)   
 896 ;testBitwiseOperators.j(134)     //acc/var
 897 ;testBitwiseOperators.j(135)     //*******
 898 ;testBitwiseOperators.j(136)     //acc byte/var byte
 899 ;testBitwiseOperators.j(137)     if (0x04 + 0x03 & b1 == 0x04) println (73); else println (999);
 900 acc8= constant 4
 901 acc8+ constant 3
 902 acc8And variable 0
 903 acc8Comp constant 4
 904 brne 1054
 905 acc8= constant 73
 906 writeLineAcc8
 907 br 1057
 908 acc16= constant 999
 909 writeLineAcc16
 910 ;testBitwiseOperators.j(138)     if (0x04 + 0x03 | b1 == 0x1F) println (74); else println (999);
 911 acc8= constant 4
 912 acc8+ constant 3
 913 acc8Or variable 0
 914 acc8Comp constant 31
 915 brne 1067
 916 acc8= constant 74
 917 writeLineAcc8
 918 br 1070
 919 acc16= constant 999
 920 writeLineAcc16
 921 ;testBitwiseOperators.j(139)     if (0x04 + 0x03 ^ b1 == 0x1B) println (75); else println (999);
 922 acc8= constant 4
 923 acc8+ constant 3
 924 acc8Xor variable 0
 925 acc8Comp constant 27
 926 brne 1080
 927 acc8= constant 75
 928 writeLineAcc8
 929 br 1084
 930 acc16= constant 999
 931 writeLineAcc16
 932 ;testBitwiseOperators.j(140)     //acc word/var word
 933 ;testBitwiseOperators.j(141)     if (0x1000 + 0x0234 & w1 == 0x0224) println (76); else println (999);
 934 acc16= constant 4096
 935 acc16+ constant 564
 936 acc16And variable 2
 937 acc16Comp constant 548
 938 brne 1094
 939 acc8= constant 76
 940 writeLineAcc8
 941 br 1097
 942 acc16= constant 999
 943 writeLineAcc16
 944 ;testBitwiseOperators.j(142)     if (0x1000 + 0x0234 | w1 == 0x133C) println (77); else println (999);
 945 acc16= constant 4096
 946 acc16+ constant 564
 947 acc16Or variable 2
 948 acc16Comp constant 4924
 949 brne 1107
 950 acc8= constant 77
 951 writeLineAcc8
 952 br 1110
 953 acc16= constant 999
 954 writeLineAcc16
 955 ;testBitwiseOperators.j(143)     if (0x1000 + 0x0234 ^ w1 == 0x1118) println (78); else println (999);
 956 acc16= constant 4096
 957 acc16+ constant 564
 958 acc16Xor variable 2
 959 acc16Comp constant 4376
 960 brne 1120
 961 acc8= constant 78
 962 writeLineAcc8
 963 br 1124
 964 acc16= constant 999
 965 writeLineAcc16
 966 ;testBitwiseOperators.j(144)     //acc byte/var word
 967 ;testBitwiseOperators.j(145)     if (0x10 + 0x0C & w2 == 0x0014) println (79); else println (999);
 968 acc8= constant 16
 969 acc8+ constant 12
 970 acc8ToAcc16
 971 acc16And variable 4
 972 acc8= constant 20
 973 acc16CompareAcc8
 974 brne 1136
 975 acc8= constant 79
 976 writeLineAcc8
 977 br 1139
 978 acc16= constant 999
 979 writeLineAcc16
 980 ;testBitwiseOperators.j(146)     if (0x10 + 0x0C | w2 == 0x123C) println (80); else println (999);
 981 acc8= constant 16
 982 acc8+ constant 12
 983 acc8ToAcc16
 984 acc16Or variable 4
 985 acc16Comp constant 4668
 986 brne 1150
 987 acc8= constant 80
 988 writeLineAcc8
 989 br 1153
 990 acc16= constant 999
 991 writeLineAcc16
 992 ;testBitwiseOperators.j(147)     if (0x10 + 0x0C ^ w2 == 0x1228) println (81); else println (999);
 993 acc8= constant 16
 994 acc8+ constant 12
 995 acc8ToAcc16
 996 acc16Xor variable 4
 997 acc16Comp constant 4648
 998 brne 1164
 999 acc8= constant 81
1000 writeLineAcc8
1001 br 1168
1002 acc16= constant 999
1003 writeLineAcc16
1004 ;testBitwiseOperators.j(148)     //acc word/var byte
1005 ;testBitwiseOperators.j(149)     if (0x1000 + 0x0234 & b1 == 0x0014) println (82); else println (999);
1006 acc16= constant 4096
1007 acc16+ constant 564
1008 acc16And variable 0
1009 acc8= constant 20
1010 acc16CompareAcc8
1011 brne 1179
1012 acc8= constant 82
1013 writeLineAcc8
1014 br 1182
1015 acc16= constant 999
1016 writeLineAcc16
1017 ;testBitwiseOperators.j(150)     if (0x1000 + 0x0234 | b1 == 0x123C) println (83); else println (999);
1018 acc16= constant 4096
1019 acc16+ constant 564
1020 acc16Or variable 0
1021 acc16Comp constant 4668
1022 brne 1192
1023 acc8= constant 83
1024 writeLineAcc8
1025 br 1195
1026 acc16= constant 999
1027 writeLineAcc16
1028 ;testBitwiseOperators.j(151)     if (0x1000 + 0x0234 ^ b1 == 0x1228) println (84); else println (999);
1029 acc16= constant 4096
1030 acc16+ constant 564
1031 acc16Xor variable 0
1032 acc16Comp constant 4648
1033 brne 1205
1034 acc8= constant 84
1035 writeLineAcc8
1036 br 1212
1037 acc16= constant 999
1038 writeLineAcc16
1039 ;testBitwiseOperators.j(152)   
1040 ;testBitwiseOperators.j(153)     //acc/final var
1041 ;testBitwiseOperators.j(154)     //*************
1042 ;testBitwiseOperators.j(155)     //acc byte/final var byte
1043 ;testBitwiseOperators.j(156)     if (0x04 + 0x03 & fb1 == 0x04) println (85); else println (999);
1044 acc8= constant 4
1045 acc8+ constant 3
1046 acc8And constant 28
1047 acc8Comp constant 4
1048 brne 1222
1049 acc8= constant 85
1050 writeLineAcc8
1051 br 1225
1052 acc16= constant 999
1053 writeLineAcc16
1054 ;testBitwiseOperators.j(157)     if (0x04 + 0x03 | fb1 == 0x1F) println (86); else println (999);
1055 acc8= constant 4
1056 acc8+ constant 3
1057 acc8Or constant 28
1058 acc8Comp constant 31
1059 brne 1235
1060 acc8= constant 86
1061 writeLineAcc8
1062 br 1238
1063 acc16= constant 999
1064 writeLineAcc16
1065 ;testBitwiseOperators.j(158)     if (0x04 + 0x03 ^ fb1 == 0x1B) println (87); else println (999);
1066 acc8= constant 4
1067 acc8+ constant 3
1068 acc8Xor constant 28
1069 acc8Comp constant 27
1070 brne 1248
1071 acc8= constant 87
1072 writeLineAcc8
1073 br 1252
1074 acc16= constant 999
1075 writeLineAcc16
1076 ;testBitwiseOperators.j(159)     //acc word/final var word
1077 ;testBitwiseOperators.j(160)     if (0x1000 + 0x0234 & fw1 == 0x0224) println (88); else println (999);
1078 acc16= constant 4096
1079 acc16+ constant 564
1080 acc16And constant 812
1081 acc16Comp constant 548
1082 brne 1262
1083 acc8= constant 88
1084 writeLineAcc8
1085 br 1265
1086 acc16= constant 999
1087 writeLineAcc16
1088 ;testBitwiseOperators.j(161)     if (0x1000 + 0x0234 | fw1 == 0x133C) println (89); else println (999);
1089 acc16= constant 4096
1090 acc16+ constant 564
1091 acc16Or constant 812
1092 acc16Comp constant 4924
1093 brne 1275
1094 acc8= constant 89
1095 writeLineAcc8
1096 br 1278
1097 acc16= constant 999
1098 writeLineAcc16
1099 ;testBitwiseOperators.j(162)     if (0x1000 + 0x0234 ^ fw1 == 0x1118) println (90); else println (999);
1100 acc16= constant 4096
1101 acc16+ constant 564
1102 acc16Xor constant 812
1103 acc16Comp constant 4376
1104 brne 1288
1105 acc8= constant 90
1106 writeLineAcc8
1107 br 1292
1108 acc16= constant 999
1109 writeLineAcc16
1110 ;testBitwiseOperators.j(163)     //acc byte/final var word
1111 ;testBitwiseOperators.j(164)     if (0x10 + 0x0C & fw2 == 0x0014) println (91); else println (999);
1112 acc8= constant 16
1113 acc8+ constant 12
1114 acc8ToAcc16
1115 acc16And constant 4660
1116 acc8= constant 20
1117 acc16CompareAcc8
1118 brne 1304
1119 acc8= constant 91
1120 writeLineAcc8
1121 br 1307
1122 acc16= constant 999
1123 writeLineAcc16
1124 ;testBitwiseOperators.j(165)     if (0x10 + 0x0C | fw2 == 0x123C) println (92); else println (999);
1125 acc8= constant 16
1126 acc8+ constant 12
1127 acc8ToAcc16
1128 acc16Or constant 4660
1129 acc16Comp constant 4668
1130 brne 1318
1131 acc8= constant 92
1132 writeLineAcc8
1133 br 1321
1134 acc16= constant 999
1135 writeLineAcc16
1136 ;testBitwiseOperators.j(166)     if (0x10 + 0x0C ^ fw2 == 0x1228) println (93); else println (999);
1137 acc8= constant 16
1138 acc8+ constant 12
1139 acc8ToAcc16
1140 acc16Xor constant 4660
1141 acc16Comp constant 4648
1142 brne 1332
1143 acc8= constant 93
1144 writeLineAcc8
1145 br 1336
1146 acc16= constant 999
1147 writeLineAcc16
1148 ;testBitwiseOperators.j(167)     //acc word/final var byte
1149 ;testBitwiseOperators.j(168)     if (0x1000 + 0x0234 & fb1 == 0x0014) println (94); else println (999);
1150 acc16= constant 4096
1151 acc16+ constant 564
1152 acc16And constant 28
1153 acc8= constant 20
1154 acc16CompareAcc8
1155 brne 1347
1156 acc8= constant 94
1157 writeLineAcc8
1158 br 1350
1159 acc16= constant 999
1160 writeLineAcc16
1161 ;testBitwiseOperators.j(169)     if (0x1000 + 0x0234 | fb1 == 0x123C) println (95); else println (999);
1162 acc16= constant 4096
1163 acc16+ constant 564
1164 acc16Or constant 28
1165 acc16Comp constant 4668
1166 brne 1360
1167 acc8= constant 95
1168 writeLineAcc8
1169 br 1363
1170 acc16= constant 999
1171 writeLineAcc16
1172 ;testBitwiseOperators.j(170)     if (0x1000 + 0x0234 ^ fb1 == 0x1228) println (96); else println (999);
1173 acc16= constant 4096
1174 acc16+ constant 564
1175 acc16Xor constant 28
1176 acc16Comp constant 4648
1177 brne 1373
1178 acc8= constant 96
1179 writeLineAcc8
1180 br 1380
1181 acc16= constant 999
1182 writeLineAcc16
1183 ;testBitwiseOperators.j(171)   
1184 ;testBitwiseOperators.j(172)     //var/constant
1185 ;testBitwiseOperators.j(173)     //************
1186 ;testBitwiseOperators.j(174)     //var byte/constant byte
1187 ;testBitwiseOperators.j(175)     if (b2 & 0x1C == 0x04) println (97); else println (999);
1188 acc8= variable 1
1189 acc8And constant 28
1190 acc8Comp constant 4
1191 brne 1389
1192 acc8= constant 97
1193 writeLineAcc8
1194 br 1392
1195 acc16= constant 999
1196 writeLineAcc16
1197 ;testBitwiseOperators.j(176)     if (b2 | 0x1C == 0x1F) println (98); else println (999);
1198 acc8= variable 1
1199 acc8Or constant 28
1200 acc8Comp constant 31
1201 brne 1401
1202 acc8= constant 98
1203 writeLineAcc8
1204 br 1404
1205 acc16= constant 999
1206 writeLineAcc16
1207 ;testBitwiseOperators.j(177)     if (b2 ^ 0x1C == 0x1B) println (99); else println (999);
1208 acc8= variable 1
1209 acc8Xor constant 28
1210 acc8Comp constant 27
1211 brne 1413
1212 acc8= constant 99
1213 writeLineAcc8
1214 br 1417
1215 acc16= constant 999
1216 writeLineAcc16
1217 ;testBitwiseOperators.j(178)     //var word/constant word
1218 ;testBitwiseOperators.j(179)     if (w2 & 0x032C == 0x0224) println (100); else println (999);
1219 acc16= variable 4
1220 acc16And constant 812
1221 acc16Comp constant 548
1222 brne 1426
1223 acc8= constant 100
1224 writeLineAcc8
1225 br 1429
1226 acc16= constant 999
1227 writeLineAcc16
1228 ;testBitwiseOperators.j(180)     if (w2 | 0x032C == 0x133C) println (101); else println (999);
1229 acc16= variable 4
1230 acc16Or constant 812
1231 acc16Comp constant 4924
1232 brne 1438
1233 acc8= constant 101
1234 writeLineAcc8
1235 br 1441
1236 acc16= constant 999
1237 writeLineAcc16
1238 ;testBitwiseOperators.j(181)     if (w2 ^ 0x032C == 0x1118) println (102); else println (999);
1239 acc16= variable 4
1240 acc16Xor constant 812
1241 acc16Comp constant 4376
1242 brne 1450
1243 acc8= constant 102
1244 writeLineAcc8
1245 br 1454
1246 acc16= constant 999
1247 writeLineAcc16
1248 ;testBitwiseOperators.j(182)     //var byte/constant word
1249 ;testBitwiseOperators.j(183)     if (b1 & 0x1234 == 0x0014) println (103); else println (999);
1250 acc8= variable 0
1251 acc8ToAcc16
1252 acc16And constant 4660
1253 acc8= constant 20
1254 acc16CompareAcc8
1255 brne 1465
1256 acc8= constant 103
1257 writeLineAcc8
1258 br 1468
1259 acc16= constant 999
1260 writeLineAcc16
1261 ;testBitwiseOperators.j(184)     if (b1 | 0x1234 == 0x123C) println (104); else println (999);
1262 acc8= variable 0
1263 acc8ToAcc16
1264 acc16Or constant 4660
1265 acc16Comp constant 4668
1266 brne 1478
1267 acc8= constant 104
1268 writeLineAcc8
1269 br 1481
1270 acc16= constant 999
1271 writeLineAcc16
1272 ;testBitwiseOperators.j(185)     if (b1 ^ 0x1234 == 0x1228) println (105); else println (999);
1273 acc8= variable 0
1274 acc8ToAcc16
1275 acc16Xor constant 4660
1276 acc16Comp constant 4648
1277 brne 1491
1278 acc8= constant 105
1279 writeLineAcc8
1280 br 1495
1281 acc16= constant 999
1282 writeLineAcc16
1283 ;testBitwiseOperators.j(186)     //var word/constant byte
1284 ;testBitwiseOperators.j(187)     if (w2 & 0x1C == 0x0014) println (106); else println (999);
1285 acc16= variable 4
1286 acc16And constant 28
1287 acc8= constant 20
1288 acc16CompareAcc8
1289 brne 1505
1290 acc8= constant 106
1291 writeLineAcc8
1292 br 1508
1293 acc16= constant 999
1294 writeLineAcc16
1295 ;testBitwiseOperators.j(188)     if (w2 | 0x1C == 0x123C) println (107); else println (999);
1296 acc16= variable 4
1297 acc16Or constant 28
1298 acc16Comp constant 4668
1299 brne 1517
1300 acc8= constant 107
1301 writeLineAcc8
1302 br 1520
1303 acc16= constant 999
1304 writeLineAcc16
1305 ;testBitwiseOperators.j(189)     if (w2 ^ 0x1C == 0x1228) println (108); else println (999);
1306 acc16= variable 4
1307 acc16Xor constant 28
1308 acc16Comp constant 4648
1309 brne 1529
1310 acc8= constant 108
1311 writeLineAcc8
1312 br 1536
1313 acc16= constant 999
1314 writeLineAcc16
1315 ;testBitwiseOperators.j(190)   
1316 ;testBitwiseOperators.j(191)     //var/acc
1317 ;testBitwiseOperators.j(192)     //*******
1318 ;testBitwiseOperators.j(193)     //var byte/acc byte
1319 ;testBitwiseOperators.j(194)     if (b2 & (0x10 + 0x0C) == 0x04) println (109); else println (999);
1320 acc8= variable 1
1321 <acc8= constant 16
1322 acc8+ constant 12
1323 acc8And unstack8
1324 acc8Comp constant 4
1325 brne 1547
1326 acc8= constant 109
1327 writeLineAcc8
1328 br 1550
1329 acc16= constant 999
1330 writeLineAcc16
1331 ;testBitwiseOperators.j(195)     if (b2 | (0x10 + 0x0C) == 0x1F) println (110); else println (999);
1332 acc8= variable 1
1333 <acc8= constant 16
1334 acc8+ constant 12
1335 acc8Or unstack8
1336 acc8Comp constant 31
1337 brne 1561
1338 acc8= constant 110
1339 writeLineAcc8
1340 br 1564
1341 acc16= constant 999
1342 writeLineAcc16
1343 ;testBitwiseOperators.j(196)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (111); else println (999);
1344 acc8= variable 1
1345 <acc8= constant 16
1346 acc8+ constant 12
1347 acc8Xor unstack8
1348 acc8Comp constant 27
1349 brne 1575
1350 acc8= constant 111
1351 writeLineAcc8
1352 br 1579
1353 acc16= constant 999
1354 writeLineAcc16
1355 ;testBitwiseOperators.j(197)     //var word/acc word
1356 ;testBitwiseOperators.j(198)     if (w2 & 0x0100 + 0x022C == 0x0224) println (112); else println (999);
1357 acc16= variable 4
1358 <acc16= constant 256
1359 acc16+ constant 556
1360 acc16And unstack16
1361 acc16Comp constant 548
1362 brne 1590
1363 acc8= constant 112
1364 writeLineAcc8
1365 br 1593
1366 acc16= constant 999
1367 writeLineAcc16
1368 ;testBitwiseOperators.j(199)     if (w2 | 0x0100 + 0x022C == 0x133C) println (113); else println (999);
1369 acc16= variable 4
1370 <acc16= constant 256
1371 acc16+ constant 556
1372 acc16Or unstack16
1373 acc16Comp constant 4924
1374 brne 1604
1375 acc8= constant 113
1376 writeLineAcc8
1377 br 1607
1378 acc16= constant 999
1379 writeLineAcc16
1380 ;testBitwiseOperators.j(200)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (114); else println (999);
1381 acc16= variable 4
1382 <acc16= constant 256
1383 acc16+ constant 556
1384 acc16Xor unstack16
1385 acc16Comp constant 4376
1386 brne 1618
1387 acc8= constant 114
1388 writeLineAcc8
1389 br 1622
1390 acc16= constant 999
1391 writeLineAcc16
1392 ;testBitwiseOperators.j(201)     //var byte/acc word
1393 ;testBitwiseOperators.j(202)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (115); else println (999);
1394 acc8= variable 0
1395 acc16= constant 4096
1396 acc16+ constant 564
1397 acc16And acc8
1398 acc8= constant 20
1399 acc16CompareAcc8
1400 brne 1634
1401 acc8= constant 115
1402 writeLineAcc8
1403 br 1637
1404 acc16= constant 999
1405 writeLineAcc16
1406 ;testBitwiseOperators.j(203)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (116); else println (999);
1407 acc8= variable 0
1408 acc16= constant 4096
1409 acc16+ constant 564
1410 acc16Or acc8
1411 acc16Comp constant 4668
1412 brne 1648
1413 acc8= constant 116
1414 writeLineAcc8
1415 br 1651
1416 acc16= constant 999
1417 writeLineAcc16
1418 ;testBitwiseOperators.j(204)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (117); else println (999);
1419 acc8= variable 0
1420 acc16= constant 4096
1421 acc16+ constant 564
1422 acc16Xor acc8
1423 acc16Comp constant 4648
1424 brne 1662
1425 acc8= constant 117
1426 writeLineAcc8
1427 br 1666
1428 acc16= constant 999
1429 writeLineAcc16
1430 ;testBitwiseOperators.j(205)     //var word/acc byte
1431 ;testBitwiseOperators.j(206)     if (w2 & 0x10 + 0x0C == 0x0014) println (118); else println (999);
1432 acc16= variable 4
1433 acc8= constant 16
1434 acc8+ constant 12
1435 acc16And acc8
1436 acc8= constant 20
1437 acc16CompareAcc8
1438 brne 1678
1439 acc8= constant 118
1440 writeLineAcc8
1441 br 1681
1442 acc16= constant 999
1443 writeLineAcc16
1444 ;testBitwiseOperators.j(207)     if (w2 | 0x10 + 0x0C == 0x123C) println (119); else println (999);
1445 acc16= variable 4
1446 acc8= constant 16
1447 acc8+ constant 12
1448 acc16Or acc8
1449 acc16Comp constant 4668
1450 brne 1692
1451 acc8= constant 119
1452 writeLineAcc8
1453 br 1695
1454 acc16= constant 999
1455 writeLineAcc16
1456 ;testBitwiseOperators.j(208)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (120); else println (999);
1457 acc16= variable 4
1458 acc8= constant 16
1459 acc8+ constant 12
1460 acc16Xor acc8
1461 acc16Comp constant 4648
1462 brne 1706
1463 acc8= constant 120
1464 writeLineAcc8
1465 br 1713
1466 acc16= constant 999
1467 writeLineAcc16
1468 ;testBitwiseOperators.j(209)   
1469 ;testBitwiseOperators.j(210)     //var/var
1470 ;testBitwiseOperators.j(211)     //*******
1471 ;testBitwiseOperators.j(212)     //var byte/var byte
1472 ;testBitwiseOperators.j(213)     if (b2 & b1 == 0x04) println (121); else println (999);
1473 acc8= variable 1
1474 acc8And variable 0
1475 acc8Comp constant 4
1476 brne 1722
1477 acc8= constant 121
1478 writeLineAcc8
1479 br 1725
1480 acc16= constant 999
1481 writeLineAcc16
1482 ;testBitwiseOperators.j(214)     if (b2 | b1 == 0x1F) println (122); else println (999);
1483 acc8= variable 1
1484 acc8Or variable 0
1485 acc8Comp constant 31
1486 brne 1734
1487 acc8= constant 122
1488 writeLineAcc8
1489 br 1737
1490 acc16= constant 999
1491 writeLineAcc16
1492 ;testBitwiseOperators.j(215)     if (b2 ^ b1 == 0x1B) println (123); else println (999);
1493 acc8= variable 1
1494 acc8Xor variable 0
1495 acc8Comp constant 27
1496 brne 1746
1497 acc8= constant 123
1498 writeLineAcc8
1499 br 1750
1500 acc16= constant 999
1501 writeLineAcc16
1502 ;testBitwiseOperators.j(216)     //var word/var word
1503 ;testBitwiseOperators.j(217)     if (w2 & w1 == 0x0224) println (124); else println (999);
1504 acc16= variable 4
1505 acc16And variable 2
1506 acc16Comp constant 548
1507 brne 1759
1508 acc8= constant 124
1509 writeLineAcc8
1510 br 1762
1511 acc16= constant 999
1512 writeLineAcc16
1513 ;testBitwiseOperators.j(218)     if (w2 | w1 == 0x133C) println (125); else println (999);
1514 acc16= variable 4
1515 acc16Or variable 2
1516 acc16Comp constant 4924
1517 brne 1771
1518 acc8= constant 125
1519 writeLineAcc8
1520 br 1774
1521 acc16= constant 999
1522 writeLineAcc16
1523 ;testBitwiseOperators.j(219)     if (w2 ^ w1 == 0x1118) println (126); else println (999);
1524 acc16= variable 4
1525 acc16Xor variable 2
1526 acc16Comp constant 4376
1527 brne 1783
1528 acc8= constant 126
1529 writeLineAcc8
1530 br 1787
1531 acc16= constant 999
1532 writeLineAcc16
1533 ;testBitwiseOperators.j(220)     //var byte/var word
1534 ;testBitwiseOperators.j(221)     if (b1 & w2 == 0x0014) println (127); else println (999);
1535 acc8= variable 0
1536 acc8ToAcc16
1537 acc16And variable 4
1538 acc8= constant 20
1539 acc16CompareAcc8
1540 brne 1798
1541 acc8= constant 127
1542 writeLineAcc8
1543 br 1801
1544 acc16= constant 999
1545 writeLineAcc16
1546 ;testBitwiseOperators.j(222)     if (b1 | w2 == 0x123C) println (128); else println (999);
1547 acc8= variable 0
1548 acc8ToAcc16
1549 acc16Or variable 4
1550 acc16Comp constant 4668
1551 brne 1811
1552 acc8= constant 128
1553 writeLineAcc8
1554 br 1814
1555 acc16= constant 999
1556 writeLineAcc16
1557 ;testBitwiseOperators.j(223)     if (b1 ^ w2 == 0x1228) println (129); else println (999);
1558 acc8= variable 0
1559 acc8ToAcc16
1560 acc16Xor variable 4
1561 acc16Comp constant 4648
1562 brne 1824
1563 acc8= constant 129
1564 writeLineAcc8
1565 br 1828
1566 acc16= constant 999
1567 writeLineAcc16
1568 ;testBitwiseOperators.j(224)     //var word/var byte
1569 ;testBitwiseOperators.j(225)     if (w2 & b1 == 0x0014) println (130); else println (999);
1570 acc16= variable 4
1571 acc16And variable 0
1572 acc8= constant 20
1573 acc16CompareAcc8
1574 brne 1838
1575 acc8= constant 130
1576 writeLineAcc8
1577 br 1841
1578 acc16= constant 999
1579 writeLineAcc16
1580 ;testBitwiseOperators.j(226)     if (w2 | b1 == 0x123C) println (131); else println (999);
1581 acc16= variable 4
1582 acc16Or variable 0
1583 acc16Comp constant 4668
1584 brne 1850
1585 acc8= constant 131
1586 writeLineAcc8
1587 br 1853
1588 acc16= constant 999
1589 writeLineAcc16
1590 ;testBitwiseOperators.j(227)     if (w2 ^ b1 == 0x1228) println (132); else println (999);
1591 acc16= variable 4
1592 acc16Xor variable 0
1593 acc16Comp constant 4648
1594 brne 1862
1595 acc8= constant 132
1596 writeLineAcc8
1597 br 1869
1598 acc16= constant 999
1599 writeLineAcc16
1600 ;testBitwiseOperators.j(228)   
1601 ;testBitwiseOperators.j(229)     //var/final var
1602 ;testBitwiseOperators.j(230)     //*************
1603 ;testBitwiseOperators.j(231)     //var byte/final var byte
1604 ;testBitwiseOperators.j(232)     if (b2 & fb1 == 0x04) println (133); else println (999);
1605 acc8= variable 1
1606 acc8And constant 28
1607 acc8Comp constant 4
1608 brne 1878
1609 acc8= constant 133
1610 writeLineAcc8
1611 br 1881
1612 acc16= constant 999
1613 writeLineAcc16
1614 ;testBitwiseOperators.j(233)     if (b2 | fb1 == 0x1F) println (134); else println (999);
1615 acc8= variable 1
1616 acc8Or constant 28
1617 acc8Comp constant 31
1618 brne 1890
1619 acc8= constant 134
1620 writeLineAcc8
1621 br 1893
1622 acc16= constant 999
1623 writeLineAcc16
1624 ;testBitwiseOperators.j(234)     if (b2 ^ fb1 == 0x1B) println (135); else println (999);
1625 acc8= variable 1
1626 acc8Xor constant 28
1627 acc8Comp constant 27
1628 brne 1902
1629 acc8= constant 135
1630 writeLineAcc8
1631 br 1906
1632 acc16= constant 999
1633 writeLineAcc16
1634 ;testBitwiseOperators.j(235)     //var word/final var word
1635 ;testBitwiseOperators.j(236)     if (w2 & fw1 == 0x0224) println (136); else println (999);
1636 acc16= variable 4
1637 acc16And constant 812
1638 acc16Comp constant 548
1639 brne 1915
1640 acc8= constant 136
1641 writeLineAcc8
1642 br 1918
1643 acc16= constant 999
1644 writeLineAcc16
1645 ;testBitwiseOperators.j(237)     if (w2 | fw1 == 0x133C) println (137); else println (999);
1646 acc16= variable 4
1647 acc16Or constant 812
1648 acc16Comp constant 4924
1649 brne 1927
1650 acc8= constant 137
1651 writeLineAcc8
1652 br 1930
1653 acc16= constant 999
1654 writeLineAcc16
1655 ;testBitwiseOperators.j(238)     if (w2 ^ fw1 == 0x1118) println (138); else println (999);
1656 acc16= variable 4
1657 acc16Xor constant 812
1658 acc16Comp constant 4376
1659 brne 1939
1660 acc8= constant 138
1661 writeLineAcc8
1662 br 1943
1663 acc16= constant 999
1664 writeLineAcc16
1665 ;testBitwiseOperators.j(239)     //var byte/final var word
1666 ;testBitwiseOperators.j(240)     if (b1 & fw2 == 0x0014) println (139); else println (999);
1667 acc8= variable 0
1668 acc8ToAcc16
1669 acc16And constant 4660
1670 acc8= constant 20
1671 acc16CompareAcc8
1672 brne 1954
1673 acc8= constant 139
1674 writeLineAcc8
1675 br 1957
1676 acc16= constant 999
1677 writeLineAcc16
1678 ;testBitwiseOperators.j(241)     if (b1 | fw2 == 0x123C) println (140); else println (999);
1679 acc8= variable 0
1680 acc8ToAcc16
1681 acc16Or constant 4660
1682 acc16Comp constant 4668
1683 brne 1967
1684 acc8= constant 140
1685 writeLineAcc8
1686 br 1970
1687 acc16= constant 999
1688 writeLineAcc16
1689 ;testBitwiseOperators.j(242)     if (b1 ^ fw2 == 0x1228) println (141); else println (999);
1690 acc8= variable 0
1691 acc8ToAcc16
1692 acc16Xor constant 4660
1693 acc16Comp constant 4648
1694 brne 1980
1695 acc8= constant 141
1696 writeLineAcc8
1697 br 1984
1698 acc16= constant 999
1699 writeLineAcc16
1700 ;testBitwiseOperators.j(243)     //var word/final var byte
1701 ;testBitwiseOperators.j(244)     if (w2 & fb1 == 0x0014) println (142); else println (999);
1702 acc16= variable 4
1703 acc16And constant 28
1704 acc8= constant 20
1705 acc16CompareAcc8
1706 brne 1994
1707 acc8= constant 142
1708 writeLineAcc8
1709 br 1997
1710 acc16= constant 999
1711 writeLineAcc16
1712 ;testBitwiseOperators.j(245)     if (w2 | fb1 == 0x123C) println (143); else println (999);
1713 acc16= variable 4
1714 acc16Or constant 28
1715 acc16Comp constant 4668
1716 brne 2006
1717 acc8= constant 143
1718 writeLineAcc8
1719 br 2009
1720 acc16= constant 999
1721 writeLineAcc16
1722 ;testBitwiseOperators.j(246)     if (w2 ^ fb1 == 0x1228) println (144); else println (999);
1723 acc16= variable 4
1724 acc16Xor constant 28
1725 acc16Comp constant 4648
1726 brne 2018
1727 acc8= constant 144
1728 writeLineAcc8
1729 br 2025
1730 acc16= constant 999
1731 writeLineAcc16
1732 ;testBitwiseOperators.j(247)   
1733 ;testBitwiseOperators.j(248)     //final var/constant
1734 ;testBitwiseOperators.j(249)     //******************
1735 ;testBitwiseOperators.j(250)     //final var byte/constant byte
1736 ;testBitwiseOperators.j(251)     if (b2 & 0x1C == 0x04) println (145); else println (999);
1737 acc8= variable 1
1738 acc8And constant 28
1739 acc8Comp constant 4
1740 brne 2034
1741 acc8= constant 145
1742 writeLineAcc8
1743 br 2037
1744 acc16= constant 999
1745 writeLineAcc16
1746 ;testBitwiseOperators.j(252)     if (b2 | 0x1C == 0x1F) println (146); else println (999);
1747 acc8= variable 1
1748 acc8Or constant 28
1749 acc8Comp constant 31
1750 brne 2046
1751 acc8= constant 146
1752 writeLineAcc8
1753 br 2049
1754 acc16= constant 999
1755 writeLineAcc16
1756 ;testBitwiseOperators.j(253)     if (b2 ^ 0x1C == 0x1B) println (147); else println (999);
1757 acc8= variable 1
1758 acc8Xor constant 28
1759 acc8Comp constant 27
1760 brne 2058
1761 acc8= constant 147
1762 writeLineAcc8
1763 br 2062
1764 acc16= constant 999
1765 writeLineAcc16
1766 ;testBitwiseOperators.j(254)     //final var word/constant word
1767 ;testBitwiseOperators.j(255)     if (w2 & 0x032C == 0x0224) println (148); else println (999);
1768 acc16= variable 4
1769 acc16And constant 812
1770 acc16Comp constant 548
1771 brne 2071
1772 acc8= constant 148
1773 writeLineAcc8
1774 br 2074
1775 acc16= constant 999
1776 writeLineAcc16
1777 ;testBitwiseOperators.j(256)     if (w2 | 0x032C == 0x133C) println (149); else println (999);
1778 acc16= variable 4
1779 acc16Or constant 812
1780 acc16Comp constant 4924
1781 brne 2083
1782 acc8= constant 149
1783 writeLineAcc8
1784 br 2086
1785 acc16= constant 999
1786 writeLineAcc16
1787 ;testBitwiseOperators.j(257)     if (w2 ^ 0x032C == 0x1118) println (150); else println (999);
1788 acc16= variable 4
1789 acc16Xor constant 812
1790 acc16Comp constant 4376
1791 brne 2095
1792 acc8= constant 150
1793 writeLineAcc8
1794 br 2099
1795 acc16= constant 999
1796 writeLineAcc16
1797 ;testBitwiseOperators.j(258)     //final var byte/constant word
1798 ;testBitwiseOperators.j(259)     if (b1 & 0x1234 == 0x0014) println (151); else println (999);
1799 acc8= variable 0
1800 acc8ToAcc16
1801 acc16And constant 4660
1802 acc8= constant 20
1803 acc16CompareAcc8
1804 brne 2110
1805 acc8= constant 151
1806 writeLineAcc8
1807 br 2113
1808 acc16= constant 999
1809 writeLineAcc16
1810 ;testBitwiseOperators.j(260)     if (b1 | 0x1234 == 0x123C) println (152); else println (999);
1811 acc8= variable 0
1812 acc8ToAcc16
1813 acc16Or constant 4660
1814 acc16Comp constant 4668
1815 brne 2123
1816 acc8= constant 152
1817 writeLineAcc8
1818 br 2126
1819 acc16= constant 999
1820 writeLineAcc16
1821 ;testBitwiseOperators.j(261)     if (b1 ^ 0x1234 == 0x1228) println (153); else println (999);
1822 acc8= variable 0
1823 acc8ToAcc16
1824 acc16Xor constant 4660
1825 acc16Comp constant 4648
1826 brne 2136
1827 acc8= constant 153
1828 writeLineAcc8
1829 br 2140
1830 acc16= constant 999
1831 writeLineAcc16
1832 ;testBitwiseOperators.j(262)     //final var word/constant byte
1833 ;testBitwiseOperators.j(263)     if (w2 & 0x1C == 0x0014) println (154); else println (999);
1834 acc16= variable 4
1835 acc16And constant 28
1836 acc8= constant 20
1837 acc16CompareAcc8
1838 brne 2150
1839 acc8= constant 154
1840 writeLineAcc8
1841 br 2153
1842 acc16= constant 999
1843 writeLineAcc16
1844 ;testBitwiseOperators.j(264)     if (w2 | 0x1C == 0x123C) println (155); else println (999);
1845 acc16= variable 4
1846 acc16Or constant 28
1847 acc16Comp constant 4668
1848 brne 2162
1849 acc8= constant 155
1850 writeLineAcc8
1851 br 2165
1852 acc16= constant 999
1853 writeLineAcc16
1854 ;testBitwiseOperators.j(265)     if (w2 ^ 0x1C == 0x1228) println (156); else println (999);
1855 acc16= variable 4
1856 acc16Xor constant 28
1857 acc16Comp constant 4648
1858 brne 2174
1859 acc8= constant 156
1860 writeLineAcc8
1861 br 2181
1862 acc16= constant 999
1863 writeLineAcc16
1864 ;testBitwiseOperators.j(266)   
1865 ;testBitwiseOperators.j(267)     //final var/acc
1866 ;testBitwiseOperators.j(268)     //*************
1867 ;testBitwiseOperators.j(269)     //final var byte/acc byte
1868 ;testBitwiseOperators.j(270)     if (b2 & (0x10 + 0x0C) == 0x04) println (157); else println (999);
1869 acc8= variable 1
1870 <acc8= constant 16
1871 acc8+ constant 12
1872 acc8And unstack8
1873 acc8Comp constant 4
1874 brne 2192
1875 acc8= constant 157
1876 writeLineAcc8
1877 br 2195
1878 acc16= constant 999
1879 writeLineAcc16
1880 ;testBitwiseOperators.j(271)     if (b2 | (0x10 + 0x0C) == 0x1F) println (158); else println (999);
1881 acc8= variable 1
1882 <acc8= constant 16
1883 acc8+ constant 12
1884 acc8Or unstack8
1885 acc8Comp constant 31
1886 brne 2206
1887 acc8= constant 158
1888 writeLineAcc8
1889 br 2209
1890 acc16= constant 999
1891 writeLineAcc16
1892 ;testBitwiseOperators.j(272)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (159); else println (999);
1893 acc8= variable 1
1894 <acc8= constant 16
1895 acc8+ constant 12
1896 acc8Xor unstack8
1897 acc8Comp constant 27
1898 brne 2220
1899 acc8= constant 159
1900 writeLineAcc8
1901 br 2224
1902 acc16= constant 999
1903 writeLineAcc16
1904 ;testBitwiseOperators.j(273)     //final var word/acc word
1905 ;testBitwiseOperators.j(274)     if (w2 & 0x0100 + 0x022C == 0x0224) println (160); else println (999);
1906 acc16= variable 4
1907 <acc16= constant 256
1908 acc16+ constant 556
1909 acc16And unstack16
1910 acc16Comp constant 548
1911 brne 2235
1912 acc8= constant 160
1913 writeLineAcc8
1914 br 2238
1915 acc16= constant 999
1916 writeLineAcc16
1917 ;testBitwiseOperators.j(275)     if (w2 | 0x0100 + 0x022C == 0x133C) println (161); else println (999);
1918 acc16= variable 4
1919 <acc16= constant 256
1920 acc16+ constant 556
1921 acc16Or unstack16
1922 acc16Comp constant 4924
1923 brne 2249
1924 acc8= constant 161
1925 writeLineAcc8
1926 br 2252
1927 acc16= constant 999
1928 writeLineAcc16
1929 ;testBitwiseOperators.j(276)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (162); else println (999);
1930 acc16= variable 4
1931 <acc16= constant 256
1932 acc16+ constant 556
1933 acc16Xor unstack16
1934 acc16Comp constant 4376
1935 brne 2263
1936 acc8= constant 162
1937 writeLineAcc8
1938 br 2267
1939 acc16= constant 999
1940 writeLineAcc16
1941 ;testBitwiseOperators.j(277)     //final var byte/acc word
1942 ;testBitwiseOperators.j(278)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (163); else println (999);
1943 acc8= variable 0
1944 acc16= constant 4096
1945 acc16+ constant 564
1946 acc16And acc8
1947 acc8= constant 20
1948 acc16CompareAcc8
1949 brne 2279
1950 acc8= constant 163
1951 writeLineAcc8
1952 br 2282
1953 acc16= constant 999
1954 writeLineAcc16
1955 ;testBitwiseOperators.j(279)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (164); else println (999);
1956 acc8= variable 0
1957 acc16= constant 4096
1958 acc16+ constant 564
1959 acc16Or acc8
1960 acc16Comp constant 4668
1961 brne 2293
1962 acc8= constant 164
1963 writeLineAcc8
1964 br 2296
1965 acc16= constant 999
1966 writeLineAcc16
1967 ;testBitwiseOperators.j(280)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (165); else println (999);
1968 acc8= variable 0
1969 acc16= constant 4096
1970 acc16+ constant 564
1971 acc16Xor acc8
1972 acc16Comp constant 4648
1973 brne 2307
1974 acc8= constant 165
1975 writeLineAcc8
1976 br 2311
1977 acc16= constant 999
1978 writeLineAcc16
1979 ;testBitwiseOperators.j(281)     //final var word/acc byte
1980 ;testBitwiseOperators.j(282)     if (w2 & 0x10 + 0x0C == 0x0014) println (166); else println (999);
1981 acc16= variable 4
1982 acc8= constant 16
1983 acc8+ constant 12
1984 acc16And acc8
1985 acc8= constant 20
1986 acc16CompareAcc8
1987 brne 2323
1988 acc8= constant 166
1989 writeLineAcc8
1990 br 2326
1991 acc16= constant 999
1992 writeLineAcc16
1993 ;testBitwiseOperators.j(283)     if (w2 | 0x10 + 0x0C == 0x123C) println (167); else println (999);
1994 acc16= variable 4
1995 acc8= constant 16
1996 acc8+ constant 12
1997 acc16Or acc8
1998 acc16Comp constant 4668
1999 brne 2337
2000 acc8= constant 167
2001 writeLineAcc8
2002 br 2340
2003 acc16= constant 999
2004 writeLineAcc16
2005 ;testBitwiseOperators.j(284)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (168); else println (999);
2006 acc16= variable 4
2007 acc8= constant 16
2008 acc8+ constant 12
2009 acc16Xor acc8
2010 acc16Comp constant 4648
2011 brne 2351
2012 acc8= constant 168
2013 writeLineAcc8
2014 br 2358
2015 acc16= constant 999
2016 writeLineAcc16
2017 ;testBitwiseOperators.j(285)   
2018 ;testBitwiseOperators.j(286)     //final var/var
2019 ;testBitwiseOperators.j(287)     //*************
2020 ;testBitwiseOperators.j(288)     //final var byte/var byte
2021 ;testBitwiseOperators.j(289)     if (b2 & b1 == 0x04) println (169); else println (999);
2022 acc8= variable 1
2023 acc8And variable 0
2024 acc8Comp constant 4
2025 brne 2367
2026 acc8= constant 169
2027 writeLineAcc8
2028 br 2370
2029 acc16= constant 999
2030 writeLineAcc16
2031 ;testBitwiseOperators.j(290)     if (b2 | b1 == 0x1F) println (170); else println (999);
2032 acc8= variable 1
2033 acc8Or variable 0
2034 acc8Comp constant 31
2035 brne 2379
2036 acc8= constant 170
2037 writeLineAcc8
2038 br 2382
2039 acc16= constant 999
2040 writeLineAcc16
2041 ;testBitwiseOperators.j(291)     if (b2 ^ b1 == 0x1B) println (171); else println (999);
2042 acc8= variable 1
2043 acc8Xor variable 0
2044 acc8Comp constant 27
2045 brne 2391
2046 acc8= constant 171
2047 writeLineAcc8
2048 br 2395
2049 acc16= constant 999
2050 writeLineAcc16
2051 ;testBitwiseOperators.j(292)     //final var word/var word
2052 ;testBitwiseOperators.j(293)     if (w2 & w1 == 0x0224) println (172); else println (999);
2053 acc16= variable 4
2054 acc16And variable 2
2055 acc16Comp constant 548
2056 brne 2404
2057 acc8= constant 172
2058 writeLineAcc8
2059 br 2407
2060 acc16= constant 999
2061 writeLineAcc16
2062 ;testBitwiseOperators.j(294)     if (w2 | w1 == 0x133C) println (173); else println (999);
2063 acc16= variable 4
2064 acc16Or variable 2
2065 acc16Comp constant 4924
2066 brne 2416
2067 acc8= constant 173
2068 writeLineAcc8
2069 br 2419
2070 acc16= constant 999
2071 writeLineAcc16
2072 ;testBitwiseOperators.j(295)     if (w2 ^ w1 == 0x1118) println (174); else println (999);
2073 acc16= variable 4
2074 acc16Xor variable 2
2075 acc16Comp constant 4376
2076 brne 2428
2077 acc8= constant 174
2078 writeLineAcc8
2079 br 2432
2080 acc16= constant 999
2081 writeLineAcc16
2082 ;testBitwiseOperators.j(296)     //final var byte/var word
2083 ;testBitwiseOperators.j(297)     if (b1 & w2 == 0x0014) println (175); else println (999);
2084 acc8= variable 0
2085 acc8ToAcc16
2086 acc16And variable 4
2087 acc8= constant 20
2088 acc16CompareAcc8
2089 brne 2443
2090 acc8= constant 175
2091 writeLineAcc8
2092 br 2446
2093 acc16= constant 999
2094 writeLineAcc16
2095 ;testBitwiseOperators.j(298)     if (b1 | w2 == 0x123C) println (176); else println (999);
2096 acc8= variable 0
2097 acc8ToAcc16
2098 acc16Or variable 4
2099 acc16Comp constant 4668
2100 brne 2456
2101 acc8= constant 176
2102 writeLineAcc8
2103 br 2459
2104 acc16= constant 999
2105 writeLineAcc16
2106 ;testBitwiseOperators.j(299)     if (b1 ^ w2 == 0x1228) println (177); else println (999);
2107 acc8= variable 0
2108 acc8ToAcc16
2109 acc16Xor variable 4
2110 acc16Comp constant 4648
2111 brne 2469
2112 acc8= constant 177
2113 writeLineAcc8
2114 br 2473
2115 acc16= constant 999
2116 writeLineAcc16
2117 ;testBitwiseOperators.j(300)     //final var word/var byte
2118 ;testBitwiseOperators.j(301)     if (w2 & b1 == 0x0014) println (178); else println (999);
2119 acc16= variable 4
2120 acc16And variable 0
2121 acc8= constant 20
2122 acc16CompareAcc8
2123 brne 2483
2124 acc8= constant 178
2125 writeLineAcc8
2126 br 2486
2127 acc16= constant 999
2128 writeLineAcc16
2129 ;testBitwiseOperators.j(302)     if (w2 | b1 == 0x123C) println (179); else println (999);
2130 acc16= variable 4
2131 acc16Or variable 0
2132 acc16Comp constant 4668
2133 brne 2495
2134 acc8= constant 179
2135 writeLineAcc8
2136 br 2498
2137 acc16= constant 999
2138 writeLineAcc16
2139 ;testBitwiseOperators.j(303)     if (w2 ^ b1 == 0x1228) println (180); else println (999);
2140 acc16= variable 4
2141 acc16Xor variable 0
2142 acc16Comp constant 4648
2143 brne 2507
2144 acc8= constant 180
2145 writeLineAcc8
2146 br 2514
2147 acc16= constant 999
2148 writeLineAcc16
2149 ;testBitwiseOperators.j(304)   
2150 ;testBitwiseOperators.j(305)     //final var/final var
2151 ;testBitwiseOperators.j(306)     //*******************
2152 ;testBitwiseOperators.j(307)     //final var byte/final var byte
2153 ;testBitwiseOperators.j(308)     if (fb2 & fb1 == 0x04) println (181); else println (999);
2154 acc8= constant 7
2155 acc8And constant 28
2156 acc8Comp constant 4
2157 brne 2523
2158 acc8= constant 181
2159 writeLineAcc8
2160 br 2526
2161 acc16= constant 999
2162 writeLineAcc16
2163 ;testBitwiseOperators.j(309)     if (fb2 | fb1 == 0x1F) println (182); else println (999);
2164 acc8= constant 7
2165 acc8Or constant 28
2166 acc8Comp constant 31
2167 brne 2535
2168 acc8= constant 182
2169 writeLineAcc8
2170 br 2538
2171 acc16= constant 999
2172 writeLineAcc16
2173 ;testBitwiseOperators.j(310)     if (fb2 ^ fb1 == 0x1B) println (183); else println (999);
2174 acc8= constant 7
2175 acc8Xor constant 28
2176 acc8Comp constant 27
2177 brne 2547
2178 acc8= constant 183
2179 writeLineAcc8
2180 br 2551
2181 acc16= constant 999
2182 writeLineAcc16
2183 ;testBitwiseOperators.j(311)     //final var word/final var word
2184 ;testBitwiseOperators.j(312)     if (fw2 & fw1 == 0x0224) println (184); else println (999);
2185 acc16= constant 4660
2186 acc16And constant 812
2187 acc16Comp constant 548
2188 brne 2560
2189 acc8= constant 184
2190 writeLineAcc8
2191 br 2563
2192 acc16= constant 999
2193 writeLineAcc16
2194 ;testBitwiseOperators.j(313)     if (fw2 | fw1 == 0x133C) println (185); else println (999);
2195 acc16= constant 4660
2196 acc16Or constant 812
2197 acc16Comp constant 4924
2198 brne 2572
2199 acc8= constant 185
2200 writeLineAcc8
2201 br 2575
2202 acc16= constant 999
2203 writeLineAcc16
2204 ;testBitwiseOperators.j(314)     if (fw2 ^ fw1 == 0x1118) println (186); else println (999);
2205 acc16= constant 4660
2206 acc16Xor constant 812
2207 acc16Comp constant 4376
2208 brne 2584
2209 acc8= constant 186
2210 writeLineAcc8
2211 br 2588
2212 acc16= constant 999
2213 writeLineAcc16
2214 ;testBitwiseOperators.j(315)     //final var byte/final var word
2215 ;testBitwiseOperators.j(316)     if (fb1 & fw2 == 0x0014) println (187); else println (999);
2216 acc8= constant 28
2217 acc8ToAcc16
2218 acc16And constant 4660
2219 acc8= constant 20
2220 acc16CompareAcc8
2221 brne 2599
2222 acc8= constant 187
2223 writeLineAcc8
2224 br 2602
2225 acc16= constant 999
2226 writeLineAcc16
2227 ;testBitwiseOperators.j(317)     if (fb1 | fw2 == 0x123C) println (188); else println (999);
2228 acc8= constant 28
2229 acc8ToAcc16
2230 acc16Or constant 4660
2231 acc16Comp constant 4668
2232 brne 2612
2233 acc8= constant 188
2234 writeLineAcc8
2235 br 2615
2236 acc16= constant 999
2237 writeLineAcc16
2238 ;testBitwiseOperators.j(318)     if (fb1 ^ fw2 == 0x1228) println (189); else println (999);
2239 acc8= constant 28
2240 acc8ToAcc16
2241 acc16Xor constant 4660
2242 acc16Comp constant 4648
2243 brne 2625
2244 acc8= constant 189
2245 writeLineAcc8
2246 br 2629
2247 acc16= constant 999
2248 writeLineAcc16
2249 ;testBitwiseOperators.j(319)     //final var word/final var byte
2250 ;testBitwiseOperators.j(320)     if (fw2 & fb1 == 0x0014) println (190); else println (999);
2251 acc16= constant 4660
2252 acc16And constant 28
2253 acc8= constant 20
2254 acc16CompareAcc8
2255 brne 2639
2256 acc8= constant 190
2257 writeLineAcc8
2258 br 2642
2259 acc16= constant 999
2260 writeLineAcc16
2261 ;testBitwiseOperators.j(321)     if (fw2 | fb1 == 0x123C) println (191); else println (999);
2262 acc16= constant 4660
2263 acc16Or constant 28
2264 acc16Comp constant 4668
2265 brne 2651
2266 acc8= constant 191
2267 writeLineAcc8
2268 br 2654
2269 acc16= constant 999
2270 writeLineAcc16
2271 ;testBitwiseOperators.j(322)     if (fw2 ^ fb1 == 0x1228) println (192); else println (999);
2272 acc16= constant 4660
2273 acc16Xor constant 28
2274 acc16Comp constant 4648
2275 brne 2663
2276 acc8= constant 192
2277 writeLineAcc8
2278 br 2667
2279 acc16= constant 999
2280 writeLineAcc16
2281 ;testBitwiseOperators.j(323)   
2282 ;testBitwiseOperators.j(324)     println("Klaar");
2283 acc16= stringconstant 2290
2284 writeLineString
2285 ;testBitwiseOperators.j(325)   }
2286 stackPointer= basePointer
2287 basePointer<
2288 return
2289 ;testBitwiseOperators.j(326) }
2290 stringConstant 0 = "Klaar"
