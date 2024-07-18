   0 call 23
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
  17 ;testBitwiseOperators.j(6)   private static final byte fb1 = 0x1C;
  18 ;testBitwiseOperators.j(7)   private static final byte fb2 = 0x07;
  19 ;testBitwiseOperators.j(8)   private static final word fw1 = 0x032C;
  20 ;testBitwiseOperators.j(9)   private static final word fw2 = 0x1234;
  21 ;testBitwiseOperators.j(10) 
  22 ;testBitwiseOperators.j(11)   public static void main() {
  23 method TestBitwiseOperators.main [public, static] void ()
  24 <basePointer
  25 basePointer= stackPointer
  26 stackPointer+ constant 0
  27 ;testBitwiseOperators.j(12)     println(0);
  28 acc8= constant 0
  29 writeLineAcc8
  30 ;testBitwiseOperators.j(13)     
  31 ;testBitwiseOperators.j(14)     // Possible operand types: constant, acc, var, final var, stack8, stack16.
  32 ;testBitwiseOperators.j(15)     // Possible data types: byte, word.
  33 ;testBitwiseOperators.j(16)   
  34 ;testBitwiseOperators.j(17)     //constant/constant
  35 ;testBitwiseOperators.j(18)     //*****************
  36 ;testBitwiseOperators.j(19)     //constant byte/constant byte
  37 ;testBitwiseOperators.j(20)     if (0x07 & 0x1C == 0x04) println (1); else println (999); //0000.0111 & 0001.1100 = 0000.0100
  38 acc8= constant 7
  39 acc8And constant 28
  40 acc8Comp constant 4
  41 brne 47
  42 acc8= constant 1
  43 writeLineAcc8
  44 br 50
  45 acc16= constant 999
  46 writeLineAcc16
  47 ;testBitwiseOperators.j(21)     if (0x07 | 0x1C == 0x1F) println (2); else println (999); //0000.0111 | 0001.1100 = 0001.1111
  48 acc8= constant 7
  49 acc8Or constant 28
  50 acc8Comp constant 31
  51 brne 59
  52 acc8= constant 2
  53 writeLineAcc8
  54 br 62
  55 acc16= constant 999
  56 writeLineAcc16
  57 ;testBitwiseOperators.j(22)     if (0x07 ^ 0x1C == 0x1B) println (3); else println (999); //0000.0111 ^ 0001.1100 = 0001.1011
  58 acc8= constant 7
  59 acc8Xor constant 28
  60 acc8Comp constant 27
  61 brne 71
  62 acc8= constant 3
  63 writeLineAcc8
  64 br 75
  65 acc16= constant 999
  66 writeLineAcc16
  67 ;testBitwiseOperators.j(23)     //constant word/constant word
  68 ;testBitwiseOperators.j(24)     if (0x1234 & 0x032C == 0x0224) println (4); else println (999);
  69 acc16= constant 4660
  70 acc16And constant 812
  71 acc16Comp constant 548
  72 brne 84
  73 acc8= constant 4
  74 writeLineAcc8
  75 br 88
  76 acc16= constant 999
  77 writeLineAcc16
  78 ;testBitwiseOperators.j(25)     //0001.0010.0011.0100 & 0000.0011.0010.1100 = 0000.0010.0010.0100
  79 ;testBitwiseOperators.j(26)     if (0x1234 | 0x032C == 0x133C) println (5); else println (999);
  80 acc16= constant 4660
  81 acc16Or constant 812
  82 acc16Comp constant 4924
  83 brne 97
  84 acc8= constant 5
  85 writeLineAcc8
  86 br 101
  87 acc16= constant 999
  88 writeLineAcc16
  89 ;testBitwiseOperators.j(27)     //0001.0010.0011.0100 | 0000.0011.0010.1100 = 0001.0011.0011.1100
  90 ;testBitwiseOperators.j(28)     if (0x1234 ^ 0x032C == 0x1118) println (6); else println (999);
  91 acc16= constant 4660
  92 acc16Xor constant 812
  93 acc16Comp constant 4376
  94 brne 110
  95 acc8= constant 6
  96 writeLineAcc8
  97 br 115
  98 acc16= constant 999
  99 writeLineAcc16
 100 ;testBitwiseOperators.j(29)     //0001.0010.0011.0100 ^ 0000.0011.0010.1100 = 0001.0001.0001.1000
 101 ;testBitwiseOperators.j(30)     //constant byte/constant word
 102 ;testBitwiseOperators.j(31)     if (0x1C & 0x1234 == 0x0014) println (7); else println (999); //0001.1100 & 0001.0010.0011.0100 = 0000.0000.0001.0100
 103 acc8= constant 28
 104 acc8ToAcc16
 105 acc16And constant 4660
 106 acc8= constant 20
 107 acc16CompareAcc8
 108 brne 126
 109 acc8= constant 7
 110 writeLineAcc8
 111 br 129
 112 acc16= constant 999
 113 writeLineAcc16
 114 ;testBitwiseOperators.j(32)     if (0x1C | 0x1234 == 0x123C) println (8); else println (999); //0001.1100 | 0001.0010.0011.0100 = 0001.0010.0011.1100
 115 acc8= constant 28
 116 acc8ToAcc16
 117 acc16Or constant 4660
 118 acc16Comp constant 4668
 119 brne 139
 120 acc8= constant 8
 121 writeLineAcc8
 122 br 142
 123 acc16= constant 999
 124 writeLineAcc16
 125 ;testBitwiseOperators.j(33)     if (0x1C ^ 0x1234 == 0x1228) println (9); else println (999); //0001.1100 ^ 0001.0010.0011.0100 = 0001.0010.0010.1000
 126 acc8= constant 28
 127 acc8ToAcc16
 128 acc16Xor constant 4660
 129 acc16Comp constant 4648
 130 brne 152
 131 acc8= constant 9
 132 writeLineAcc8
 133 br 156
 134 acc16= constant 999
 135 writeLineAcc16
 136 ;testBitwiseOperators.j(34)     //constant word/constant byte
 137 ;testBitwiseOperators.j(35)     if (0x1234 & 0x1C == 0x0014) println (10); else println (999); //0001.0010.0011.0100 & 0001.1100 = 0000.0000.0001.0100
 138 acc16= constant 4660
 139 acc16And constant 28
 140 acc8= constant 20
 141 acc16CompareAcc8
 142 brne 166
 143 acc8= constant 10
 144 writeLineAcc8
 145 br 169
 146 acc16= constant 999
 147 writeLineAcc16
 148 ;testBitwiseOperators.j(36)     if (0x1234 | 0x1C == 0x123C) println (11); else println (999); //0001.0010.0011.0100 | 0001.1100 = 0001.0010.0011.1100
 149 acc16= constant 4660
 150 acc16Or constant 28
 151 acc16Comp constant 4668
 152 brne 178
 153 acc8= constant 11
 154 writeLineAcc8
 155 br 181
 156 acc16= constant 999
 157 writeLineAcc16
 158 ;testBitwiseOperators.j(37)     if (0x1234 ^ 0x1C == 0x1228) println (12); else println (999); //0001.0010.0011.0100 ^ 0001.1100 = 0001.0010.0010.1000
 159 acc16= constant 4660
 160 acc16Xor constant 28
 161 acc16Comp constant 4648
 162 brne 190
 163 acc8= constant 12
 164 writeLineAcc8
 165 br 197
 166 acc16= constant 999
 167 writeLineAcc16
 168 ;testBitwiseOperators.j(38)   
 169 ;testBitwiseOperators.j(39)     //constant/acc
 170 ;testBitwiseOperators.j(40)     //************
 171 ;testBitwiseOperators.j(41)     //constant byte/acc byte
 172 ;testBitwiseOperators.j(42)     if (0x07 & (0x10 + 0x0C) == 0x04) println (13); else println (999);
 173 acc8= constant 7
 174 <acc8= constant 16
 175 acc8+ constant 12
 176 acc8And unstack8
 177 acc8Comp constant 4
 178 brne 208
 179 acc8= constant 13
 180 writeLineAcc8
 181 br 211
 182 acc16= constant 999
 183 writeLineAcc16
 184 ;testBitwiseOperators.j(43)     if (0x07 | (0x10 + 0x0C) == 0x1F) println (14); else println (999);
 185 acc8= constant 7
 186 <acc8= constant 16
 187 acc8+ constant 12
 188 acc8Or unstack8
 189 acc8Comp constant 31
 190 brne 222
 191 acc8= constant 14
 192 writeLineAcc8
 193 br 225
 194 acc16= constant 999
 195 writeLineAcc16
 196 ;testBitwiseOperators.j(44)     if (0x07 ^ (0x10 + 0x0C) == 0x1B) println (15); else println (999);
 197 acc8= constant 7
 198 <acc8= constant 16
 199 acc8+ constant 12
 200 acc8Xor unstack8
 201 acc8Comp constant 27
 202 brne 236
 203 acc8= constant 15
 204 writeLineAcc8
 205 br 240
 206 acc16= constant 999
 207 writeLineAcc16
 208 ;testBitwiseOperators.j(45)     //constant word/acc word
 209 ;testBitwiseOperators.j(46)     if (0x1234 & 0x0100 + 0x022C == 0x0224) println (16); else println (999);
 210 acc16= constant 4660
 211 <acc16= constant 256
 212 acc16+ constant 556
 213 acc16And unstack16
 214 acc16Comp constant 548
 215 brne 251
 216 acc8= constant 16
 217 writeLineAcc8
 218 br 254
 219 acc16= constant 999
 220 writeLineAcc16
 221 ;testBitwiseOperators.j(47)     if (0x1234 | 0x0100 + 0x022C == 0x133C) println (17); else println (999);
 222 acc16= constant 4660
 223 <acc16= constant 256
 224 acc16+ constant 556
 225 acc16Or unstack16
 226 acc16Comp constant 4924
 227 brne 265
 228 acc8= constant 17
 229 writeLineAcc8
 230 br 268
 231 acc16= constant 999
 232 writeLineAcc16
 233 ;testBitwiseOperators.j(48)     if (0x1234 ^ 0x0100 + 0x022C == 0x1118) println (18); else println (999);
 234 acc16= constant 4660
 235 <acc16= constant 256
 236 acc16+ constant 556
 237 acc16Xor unstack16
 238 acc16Comp constant 4376
 239 brne 279
 240 acc8= constant 18
 241 writeLineAcc8
 242 br 283
 243 acc16= constant 999
 244 writeLineAcc16
 245 ;testBitwiseOperators.j(49)     //constant byte/acc word
 246 ;testBitwiseOperators.j(50)     if (0x1C & 0x1000 + 0x0234 == 0x0014) println (19); else println (999);
 247 acc8= constant 28
 248 acc16= constant 4096
 249 acc16+ constant 564
 250 acc16And acc8
 251 acc8= constant 20
 252 acc16CompareAcc8
 253 brne 295
 254 acc8= constant 19
 255 writeLineAcc8
 256 br 298
 257 acc16= constant 999
 258 writeLineAcc16
 259 ;testBitwiseOperators.j(51)     if (0x1C | 0x1000 + 0x0234 == 0x123C) println (20); else println (999);
 260 acc8= constant 28
 261 acc16= constant 4096
 262 acc16+ constant 564
 263 acc16Or acc8
 264 acc16Comp constant 4668
 265 brne 309
 266 acc8= constant 20
 267 writeLineAcc8
 268 br 312
 269 acc16= constant 999
 270 writeLineAcc16
 271 ;testBitwiseOperators.j(52)     if (0x1C ^ 0x1000 + 0x0234 == 0x1228) println (21); else println (999);
 272 acc8= constant 28
 273 acc16= constant 4096
 274 acc16+ constant 564
 275 acc16Xor acc8
 276 acc16Comp constant 4648
 277 brne 323
 278 acc8= constant 21
 279 writeLineAcc8
 280 br 327
 281 acc16= constant 999
 282 writeLineAcc16
 283 ;testBitwiseOperators.j(53)     //constant word/acc byte
 284 ;testBitwiseOperators.j(54)     if (0x1234 & 0x10 + 0x0C == 0x0014) println (22); else println (999);
 285 acc16= constant 4660
 286 acc8= constant 16
 287 acc8+ constant 12
 288 acc16And acc8
 289 acc8= constant 20
 290 acc16CompareAcc8
 291 brne 339
 292 acc8= constant 22
 293 writeLineAcc8
 294 br 342
 295 acc16= constant 999
 296 writeLineAcc16
 297 ;testBitwiseOperators.j(55)     if (0x1234 | 0x10 + 0x0C == 0x123C) println (23); else println (999);
 298 acc16= constant 4660
 299 acc8= constant 16
 300 acc8+ constant 12
 301 acc16Or acc8
 302 acc16Comp constant 4668
 303 brne 353
 304 acc8= constant 23
 305 writeLineAcc8
 306 br 356
 307 acc16= constant 999
 308 writeLineAcc16
 309 ;testBitwiseOperators.j(56)     if (0x1234 ^ 0x10 + 0x0C == 0x1228) println (24); else println (999);
 310 acc16= constant 4660
 311 acc8= constant 16
 312 acc8+ constant 12
 313 acc16Xor acc8
 314 acc16Comp constant 4648
 315 brne 367
 316 acc8= constant 24
 317 writeLineAcc8
 318 br 374
 319 acc16= constant 999
 320 writeLineAcc16
 321 ;testBitwiseOperators.j(57)   
 322 ;testBitwiseOperators.j(58)     //constant/var
 323 ;testBitwiseOperators.j(59)     //*****************
 324 ;testBitwiseOperators.j(60)     //constant byte/var byte
 325 ;testBitwiseOperators.j(61)     if (0x07 & b1 == 0x04) println (25); else println (999);
 326 acc8= constant 7
 327 acc8And variable 0
 328 acc8Comp constant 4
 329 brne 383
 330 acc8= constant 25
 331 writeLineAcc8
 332 br 386
 333 acc16= constant 999
 334 writeLineAcc16
 335 ;testBitwiseOperators.j(62)     if (0x07 | b1 == 0x1F) println (26); else println (999);
 336 acc8= constant 7
 337 acc8Or variable 0
 338 acc8Comp constant 31
 339 brne 395
 340 acc8= constant 26
 341 writeLineAcc8
 342 br 398
 343 acc16= constant 999
 344 writeLineAcc16
 345 ;testBitwiseOperators.j(63)     if (0x07 ^ b1 == 0x1B) println (27); else println (999);
 346 acc8= constant 7
 347 acc8Xor variable 0
 348 acc8Comp constant 27
 349 brne 407
 350 acc8= constant 27
 351 writeLineAcc8
 352 br 411
 353 acc16= constant 999
 354 writeLineAcc16
 355 ;testBitwiseOperators.j(64)     //constant word/var word
 356 ;testBitwiseOperators.j(65)     if (0x1234 & w1 == 0x0224) println (28); else println (999);
 357 acc16= constant 4660
 358 acc16And variable 2
 359 acc16Comp constant 548
 360 brne 420
 361 acc8= constant 28
 362 writeLineAcc8
 363 br 423
 364 acc16= constant 999
 365 writeLineAcc16
 366 ;testBitwiseOperators.j(66)     if (0x1234 | w1 == 0x133C) println (29); else println (999);
 367 acc16= constant 4660
 368 acc16Or variable 2
 369 acc16Comp constant 4924
 370 brne 432
 371 acc8= constant 29
 372 writeLineAcc8
 373 br 435
 374 acc16= constant 999
 375 writeLineAcc16
 376 ;testBitwiseOperators.j(67)     if (0x1234 ^ w1 == 0x1118) println (30); else println (999);
 377 acc16= constant 4660
 378 acc16Xor variable 2
 379 acc16Comp constant 4376
 380 brne 444
 381 acc8= constant 30
 382 writeLineAcc8
 383 br 448
 384 acc16= constant 999
 385 writeLineAcc16
 386 ;testBitwiseOperators.j(68)     //constant byte/var word
 387 ;testBitwiseOperators.j(69)     if (0x1C & w2 == 0x0014) println (31); else println (999);
 388 acc8= constant 28
 389 acc8ToAcc16
 390 acc16And variable 4
 391 acc8= constant 20
 392 acc16CompareAcc8
 393 brne 459
 394 acc8= constant 31
 395 writeLineAcc8
 396 br 462
 397 acc16= constant 999
 398 writeLineAcc16
 399 ;testBitwiseOperators.j(70)     if (0x1C | w2 == 0x123C) println (32); else println (999);
 400 acc8= constant 28
 401 acc8ToAcc16
 402 acc16Or variable 4
 403 acc16Comp constant 4668
 404 brne 472
 405 acc8= constant 32
 406 writeLineAcc8
 407 br 475
 408 acc16= constant 999
 409 writeLineAcc16
 410 ;testBitwiseOperators.j(71)     if (0x1C ^ w2 == 0x1228) println (33); else println (999);
 411 acc8= constant 28
 412 acc8ToAcc16
 413 acc16Xor variable 4
 414 acc16Comp constant 4648
 415 brne 485
 416 acc8= constant 33
 417 writeLineAcc8
 418 br 489
 419 acc16= constant 999
 420 writeLineAcc16
 421 ;testBitwiseOperators.j(72)     //constant word/var byte
 422 ;testBitwiseOperators.j(73)     if (0x1234 & b1 == 0x0014) println (34); else println (999);
 423 acc16= constant 4660
 424 acc16And variable 0
 425 acc8= constant 20
 426 acc16CompareAcc8
 427 brne 499
 428 acc8= constant 34
 429 writeLineAcc8
 430 br 502
 431 acc16= constant 999
 432 writeLineAcc16
 433 ;testBitwiseOperators.j(74)     if (0x1234 | b1 == 0x123C) println (35); else println (999);
 434 acc16= constant 4660
 435 acc16Or variable 0
 436 acc16Comp constant 4668
 437 brne 511
 438 acc8= constant 35
 439 writeLineAcc8
 440 br 514
 441 acc16= constant 999
 442 writeLineAcc16
 443 ;testBitwiseOperators.j(75)     if (0x1234 ^ b1 == 0x1228) println (36); else println (999);
 444 acc16= constant 4660
 445 acc16Xor variable 0
 446 acc16Comp constant 4648
 447 brne 523
 448 acc8= constant 36
 449 writeLineAcc8
 450 br 530
 451 acc16= constant 999
 452 writeLineAcc16
 453 ;testBitwiseOperators.j(76)   
 454 ;testBitwiseOperators.j(77)     //constant/final var
 455 ;testBitwiseOperators.j(78)     //*****************
 456 ;testBitwiseOperators.j(79)     //constant byte/final var byte
 457 ;testBitwiseOperators.j(80)     if (0x07 & fb1 == 0x04) println (37); else println (999);
 458 acc8= constant 7
 459 acc8And constant 28
 460 acc8Comp constant 4
 461 brne 539
 462 acc8= constant 37
 463 writeLineAcc8
 464 br 542
 465 acc16= constant 999
 466 writeLineAcc16
 467 ;testBitwiseOperators.j(81)     if (0x07 | fb1 == 0x1F) println (38); else println (999);
 468 acc8= constant 7
 469 acc8Or constant 28
 470 acc8Comp constant 31
 471 brne 551
 472 acc8= constant 38
 473 writeLineAcc8
 474 br 554
 475 acc16= constant 999
 476 writeLineAcc16
 477 ;testBitwiseOperators.j(82)     if (0x07 ^ fb1 == 0x1B) println (39); else println (999);
 478 acc8= constant 7
 479 acc8Xor constant 28
 480 acc8Comp constant 27
 481 brne 563
 482 acc8= constant 39
 483 writeLineAcc8
 484 br 567
 485 acc16= constant 999
 486 writeLineAcc16
 487 ;testBitwiseOperators.j(83)     //constant word/final var word
 488 ;testBitwiseOperators.j(84)     if (0x1234 & fw1 == 0x0224) println (40); else println (999);
 489 acc16= constant 4660
 490 acc16And constant 812
 491 acc16Comp constant 548
 492 brne 576
 493 acc8= constant 40
 494 writeLineAcc8
 495 br 579
 496 acc16= constant 999
 497 writeLineAcc16
 498 ;testBitwiseOperators.j(85)     if (0x1234 | fw1 == 0x133C) println (41); else println (999);
 499 acc16= constant 4660
 500 acc16Or constant 812
 501 acc16Comp constant 4924
 502 brne 588
 503 acc8= constant 41
 504 writeLineAcc8
 505 br 591
 506 acc16= constant 999
 507 writeLineAcc16
 508 ;testBitwiseOperators.j(86)     if (0x1234 ^ fw1 == 0x1118) println (42); else println (999);
 509 acc16= constant 4660
 510 acc16Xor constant 812
 511 acc16Comp constant 4376
 512 brne 600
 513 acc8= constant 42
 514 writeLineAcc8
 515 br 604
 516 acc16= constant 999
 517 writeLineAcc16
 518 ;testBitwiseOperators.j(87)     //constant byte/final var word
 519 ;testBitwiseOperators.j(88)     if (0x1C & fw2 == 0x0014) println (43); else println (999);
 520 acc8= constant 28
 521 acc8ToAcc16
 522 acc16And constant 4660
 523 acc8= constant 20
 524 acc16CompareAcc8
 525 brne 615
 526 acc8= constant 43
 527 writeLineAcc8
 528 br 618
 529 acc16= constant 999
 530 writeLineAcc16
 531 ;testBitwiseOperators.j(89)     if (0x1C | fw2 == 0x123C) println (44); else println (999);
 532 acc8= constant 28
 533 acc8ToAcc16
 534 acc16Or constant 4660
 535 acc16Comp constant 4668
 536 brne 628
 537 acc8= constant 44
 538 writeLineAcc8
 539 br 631
 540 acc16= constant 999
 541 writeLineAcc16
 542 ;testBitwiseOperators.j(90)     if (0x1C ^ fw2 == 0x1228) println (45); else println (999);
 543 acc8= constant 28
 544 acc8ToAcc16
 545 acc16Xor constant 4660
 546 acc16Comp constant 4648
 547 brne 641
 548 acc8= constant 45
 549 writeLineAcc8
 550 br 645
 551 acc16= constant 999
 552 writeLineAcc16
 553 ;testBitwiseOperators.j(91)     //constant word/final var byte
 554 ;testBitwiseOperators.j(92)     if (0x1234 & fb1 == 0x0014) println (46); else println (999);
 555 acc16= constant 4660
 556 acc16And constant 28
 557 acc8= constant 20
 558 acc16CompareAcc8
 559 brne 655
 560 acc8= constant 46
 561 writeLineAcc8
 562 br 658
 563 acc16= constant 999
 564 writeLineAcc16
 565 ;testBitwiseOperators.j(93)     if (0x1234 | fb1 == 0x123C) println (47); else println (999);
 566 acc16= constant 4660
 567 acc16Or constant 28
 568 acc16Comp constant 4668
 569 brne 667
 570 acc8= constant 47
 571 writeLineAcc8
 572 br 670
 573 acc16= constant 999
 574 writeLineAcc16
 575 ;testBitwiseOperators.j(94)     if (0x1234 ^ fb1 == 0x1228) println (48); else println (999);
 576 acc16= constant 4660
 577 acc16Xor constant 28
 578 acc16Comp constant 4648
 579 brne 679
 580 acc8= constant 48
 581 writeLineAcc8
 582 br 686
 583 acc16= constant 999
 584 writeLineAcc16
 585 ;testBitwiseOperators.j(95)   
 586 ;testBitwiseOperators.j(96)     //acc/constant
 587 ;testBitwiseOperators.j(97)     //************
 588 ;testBitwiseOperators.j(98)     //acc byte/constant byte
 589 ;testBitwiseOperators.j(99)     if ((0x04 + 0x03) & 0x1C == 0x04) println (49); else println (999);
 590 acc8= constant 4
 591 acc8+ constant 3
 592 acc8And constant 28
 593 acc8Comp constant 4
 594 brne 696
 595 acc8= constant 49
 596 writeLineAcc8
 597 br 699
 598 acc16= constant 999
 599 writeLineAcc16
 600 ;testBitwiseOperators.j(100)     if ((0x04 + 0x03) | 0x1C == 0x1F) println (50); else println (999);
 601 acc8= constant 4
 602 acc8+ constant 3
 603 acc8Or constant 28
 604 acc8Comp constant 31
 605 brne 709
 606 acc8= constant 50
 607 writeLineAcc8
 608 br 712
 609 acc16= constant 999
 610 writeLineAcc16
 611 ;testBitwiseOperators.j(101)     if ((0x04 + 0x03) ^ 0x1C == 0x1B) println (51); else println (999);
 612 acc8= constant 4
 613 acc8+ constant 3
 614 acc8Xor constant 28
 615 acc8Comp constant 27
 616 brne 722
 617 acc8= constant 51
 618 writeLineAcc8
 619 br 726
 620 acc16= constant 999
 621 writeLineAcc16
 622 ;testBitwiseOperators.j(102)     //acc word/constant word
 623 ;testBitwiseOperators.j(103)     if (0x1000 + 0x0234 & 0x032C == 0x0224) println (52); else println (999);
 624 acc16= constant 4096
 625 acc16+ constant 564
 626 acc16And constant 812
 627 acc16Comp constant 548
 628 brne 736
 629 acc8= constant 52
 630 writeLineAcc8
 631 br 739
 632 acc16= constant 999
 633 writeLineAcc16
 634 ;testBitwiseOperators.j(104)     if (0x1000 + 0x0234 | 0x032C == 0x133C) println (53); else println (999);
 635 acc16= constant 4096
 636 acc16+ constant 564
 637 acc16Or constant 812
 638 acc16Comp constant 4924
 639 brne 749
 640 acc8= constant 53
 641 writeLineAcc8
 642 br 752
 643 acc16= constant 999
 644 writeLineAcc16
 645 ;testBitwiseOperators.j(105)     if (0x1000 + 0x0234 ^ 0x032C == 0x1118) println (54); else println (999);
 646 acc16= constant 4096
 647 acc16+ constant 564
 648 acc16Xor constant 812
 649 acc16Comp constant 4376
 650 brne 762
 651 acc8= constant 54
 652 writeLineAcc8
 653 br 766
 654 acc16= constant 999
 655 writeLineAcc16
 656 ;testBitwiseOperators.j(106)     //acc byte/constant word
 657 ;testBitwiseOperators.j(107)     if (0x10 + 0x0C & 0x1234 == 0x0014) println (55); else println (999);
 658 acc8= constant 16
 659 acc8+ constant 12
 660 acc8ToAcc16
 661 acc16And constant 4660
 662 acc8= constant 20
 663 acc16CompareAcc8
 664 brne 778
 665 acc8= constant 55
 666 writeLineAcc8
 667 br 781
 668 acc16= constant 999
 669 writeLineAcc16
 670 ;testBitwiseOperators.j(108)     if (0x10 + 0x0C | 0x1234 == 0x123C) println (56); else println (999);
 671 acc8= constant 16
 672 acc8+ constant 12
 673 acc8ToAcc16
 674 acc16Or constant 4660
 675 acc16Comp constant 4668
 676 brne 792
 677 acc8= constant 56
 678 writeLineAcc8
 679 br 795
 680 acc16= constant 999
 681 writeLineAcc16
 682 ;testBitwiseOperators.j(109)     if (0x10 + 0x0C ^ 0x1234 == 0x1228) println (57); else println (999);
 683 acc8= constant 16
 684 acc8+ constant 12
 685 acc8ToAcc16
 686 acc16Xor constant 4660
 687 acc16Comp constant 4648
 688 brne 806
 689 acc8= constant 57
 690 writeLineAcc8
 691 br 810
 692 acc16= constant 999
 693 writeLineAcc16
 694 ;testBitwiseOperators.j(110)     //acc word/constant byte
 695 ;testBitwiseOperators.j(111)     if (0x1000 + 0x0234 & 0x1C == 0x0014) println (58); else println (999);
 696 acc16= constant 4096
 697 acc16+ constant 564
 698 acc16And constant 28
 699 acc8= constant 20
 700 acc16CompareAcc8
 701 brne 821
 702 acc8= constant 58
 703 writeLineAcc8
 704 br 824
 705 acc16= constant 999
 706 writeLineAcc16
 707 ;testBitwiseOperators.j(112)     if (0x1000 + 0x0234 | 0x1C == 0x123C) println (59); else println (999);
 708 acc16= constant 4096
 709 acc16+ constant 564
 710 acc16Or constant 28
 711 acc16Comp constant 4668
 712 brne 834
 713 acc8= constant 59
 714 writeLineAcc8
 715 br 837
 716 acc16= constant 999
 717 writeLineAcc16
 718 ;testBitwiseOperators.j(113)     if (0x1000 + 0x0234 ^ 0x1C == 0x1228) println (60); else println (999);
 719 acc16= constant 4096
 720 acc16+ constant 564
 721 acc16Xor constant 28
 722 acc16Comp constant 4648
 723 brne 847
 724 acc8= constant 60
 725 writeLineAcc8
 726 br 854
 727 acc16= constant 999
 728 writeLineAcc16
 729 ;testBitwiseOperators.j(114)   
 730 ;testBitwiseOperators.j(115)     //acc/acc
 731 ;testBitwiseOperators.j(116)     //*******
 732 ;testBitwiseOperators.j(117)     //acc byte/acc byte
 733 ;testBitwiseOperators.j(118)     if (0x04 + 0x03 & 0x10 + 0x0C == 0x04) println (61); else println (999);
 734 acc8= constant 4
 735 acc8+ constant 3
 736 <acc8= constant 16
 737 acc8+ constant 12
 738 acc8And unstack8
 739 acc8Comp constant 4
 740 brne 866
 741 acc8= constant 61
 742 writeLineAcc8
 743 br 869
 744 acc16= constant 999
 745 writeLineAcc16
 746 ;testBitwiseOperators.j(119)     if (0x04 + 0x03 | 0x10 + 0x0C == 0x1F) println (62); else println (999);
 747 acc8= constant 4
 748 acc8+ constant 3
 749 <acc8= constant 16
 750 acc8+ constant 12
 751 acc8Or unstack8
 752 acc8Comp constant 31
 753 brne 881
 754 acc8= constant 62
 755 writeLineAcc8
 756 br 884
 757 acc16= constant 999
 758 writeLineAcc16
 759 ;testBitwiseOperators.j(120)     if (0x04 + 0x03 ^ 0x10 + 0x0C == 0x1B) println (63); else println (999);
 760 acc8= constant 4
 761 acc8+ constant 3
 762 <acc8= constant 16
 763 acc8+ constant 12
 764 acc8Xor unstack8
 765 acc8Comp constant 27
 766 brne 896
 767 acc8= constant 63
 768 writeLineAcc8
 769 br 900
 770 acc16= constant 999
 771 writeLineAcc16
 772 ;testBitwiseOperators.j(121)     //acc word/acc word
 773 ;testBitwiseOperators.j(122)     if (0x1000 + 0x0234 & 0x0100 + 0x022C == 0x0224) println (64); else println (999);
 774 acc16= constant 4096
 775 acc16+ constant 564
 776 <acc16= constant 256
 777 acc16+ constant 556
 778 acc16And unstack16
 779 acc16Comp constant 548
 780 brne 912
 781 acc8= constant 64
 782 writeLineAcc8
 783 br 915
 784 acc16= constant 999
 785 writeLineAcc16
 786 ;testBitwiseOperators.j(123)     if (0x1000 + 0x0234 | 0x0100 + 0x022C == 0x133C) println (65); else println (999);
 787 acc16= constant 4096
 788 acc16+ constant 564
 789 <acc16= constant 256
 790 acc16+ constant 556
 791 acc16Or unstack16
 792 acc16Comp constant 4924
 793 brne 927
 794 acc8= constant 65
 795 writeLineAcc8
 796 br 930
 797 acc16= constant 999
 798 writeLineAcc16
 799 ;testBitwiseOperators.j(124)     if (0x1000 + 0x0234 ^ 0x0100 + 0x022C == 0x1118) println (66); else println (999);
 800 acc16= constant 4096
 801 acc16+ constant 564
 802 <acc16= constant 256
 803 acc16+ constant 556
 804 acc16Xor unstack16
 805 acc16Comp constant 4376
 806 brne 942
 807 acc8= constant 66
 808 writeLineAcc8
 809 br 946
 810 acc16= constant 999
 811 writeLineAcc16
 812 ;testBitwiseOperators.j(125)     //acc byte/acc word
 813 ;testBitwiseOperators.j(126)     if (0x10 + 0x0C & 0x1000 + 0x0234 == 0x0014) println (67); else println (999);
 814 acc8= constant 16
 815 acc8+ constant 12
 816 acc16= constant 4096
 817 acc16+ constant 564
 818 acc16And acc8
 819 acc8= constant 20
 820 acc16CompareAcc8
 821 brne 959
 822 acc8= constant 67
 823 writeLineAcc8
 824 br 962
 825 acc16= constant 999
 826 writeLineAcc16
 827 ;testBitwiseOperators.j(127)     if (0x10 + 0x0C | 0x1000 + 0x0234 == 0x123C) println (68); else println (999);
 828 acc8= constant 16
 829 acc8+ constant 12
 830 acc16= constant 4096
 831 acc16+ constant 564
 832 acc16Or acc8
 833 acc16Comp constant 4668
 834 brne 974
 835 acc8= constant 68
 836 writeLineAcc8
 837 br 977
 838 acc16= constant 999
 839 writeLineAcc16
 840 ;testBitwiseOperators.j(128)     if (0x10 + 0x0C ^ 0x1000 + 0x0234 == 0x1228) println (69); else println (999);
 841 acc8= constant 16
 842 acc8+ constant 12
 843 acc16= constant 4096
 844 acc16+ constant 564
 845 acc16Xor acc8
 846 acc16Comp constant 4648
 847 brne 989
 848 acc8= constant 69
 849 writeLineAcc8
 850 br 993
 851 acc16= constant 999
 852 writeLineAcc16
 853 ;testBitwiseOperators.j(129)     //acc word/acc byte
 854 ;testBitwiseOperators.j(130)     if (0x1000 + 0x0234 & 0x10 + 0x0C == 0x0014) println (70); else println (999);
 855 acc16= constant 4096
 856 acc16+ constant 564
 857 acc8= constant 16
 858 acc8+ constant 12
 859 acc16And acc8
 860 acc8= constant 20
 861 acc16CompareAcc8
 862 brne 1006
 863 acc8= constant 70
 864 writeLineAcc8
 865 br 1009
 866 acc16= constant 999
 867 writeLineAcc16
 868 ;testBitwiseOperators.j(131)     if (0x1000 + 0x0234 | 0x10 + 0x0C == 0x123C) println (71); else println (999);
 869 acc16= constant 4096
 870 acc16+ constant 564
 871 acc8= constant 16
 872 acc8+ constant 12
 873 acc16Or acc8
 874 acc16Comp constant 4668
 875 brne 1021
 876 acc8= constant 71
 877 writeLineAcc8
 878 br 1024
 879 acc16= constant 999
 880 writeLineAcc16
 881 ;testBitwiseOperators.j(132)     if (0x1000 + 0x0234 ^ 0x10 + 0x0C == 0x1228) println (72); else println (999);
 882 acc16= constant 4096
 883 acc16+ constant 564
 884 acc8= constant 16
 885 acc8+ constant 12
 886 acc16Xor acc8
 887 acc16Comp constant 4648
 888 brne 1036
 889 acc8= constant 72
 890 writeLineAcc8
 891 br 1043
 892 acc16= constant 999
 893 writeLineAcc16
 894 ;testBitwiseOperators.j(133)   
 895 ;testBitwiseOperators.j(134)     //acc/var
 896 ;testBitwiseOperators.j(135)     //*******
 897 ;testBitwiseOperators.j(136)     //acc byte/var byte
 898 ;testBitwiseOperators.j(137)     if (0x04 + 0x03 & b1 == 0x04) println (73); else println (999);
 899 acc8= constant 4
 900 acc8+ constant 3
 901 acc8And variable 0
 902 acc8Comp constant 4
 903 brne 1053
 904 acc8= constant 73
 905 writeLineAcc8
 906 br 1056
 907 acc16= constant 999
 908 writeLineAcc16
 909 ;testBitwiseOperators.j(138)     if (0x04 + 0x03 | b1 == 0x1F) println (74); else println (999);
 910 acc8= constant 4
 911 acc8+ constant 3
 912 acc8Or variable 0
 913 acc8Comp constant 31
 914 brne 1066
 915 acc8= constant 74
 916 writeLineAcc8
 917 br 1069
 918 acc16= constant 999
 919 writeLineAcc16
 920 ;testBitwiseOperators.j(139)     if (0x04 + 0x03 ^ b1 == 0x1B) println (75); else println (999);
 921 acc8= constant 4
 922 acc8+ constant 3
 923 acc8Xor variable 0
 924 acc8Comp constant 27
 925 brne 1079
 926 acc8= constant 75
 927 writeLineAcc8
 928 br 1083
 929 acc16= constant 999
 930 writeLineAcc16
 931 ;testBitwiseOperators.j(140)     //acc word/var word
 932 ;testBitwiseOperators.j(141)     if (0x1000 + 0x0234 & w1 == 0x0224) println (76); else println (999);
 933 acc16= constant 4096
 934 acc16+ constant 564
 935 acc16And variable 2
 936 acc16Comp constant 548
 937 brne 1093
 938 acc8= constant 76
 939 writeLineAcc8
 940 br 1096
 941 acc16= constant 999
 942 writeLineAcc16
 943 ;testBitwiseOperators.j(142)     if (0x1000 + 0x0234 | w1 == 0x133C) println (77); else println (999);
 944 acc16= constant 4096
 945 acc16+ constant 564
 946 acc16Or variable 2
 947 acc16Comp constant 4924
 948 brne 1106
 949 acc8= constant 77
 950 writeLineAcc8
 951 br 1109
 952 acc16= constant 999
 953 writeLineAcc16
 954 ;testBitwiseOperators.j(143)     if (0x1000 + 0x0234 ^ w1 == 0x1118) println (78); else println (999);
 955 acc16= constant 4096
 956 acc16+ constant 564
 957 acc16Xor variable 2
 958 acc16Comp constant 4376
 959 brne 1119
 960 acc8= constant 78
 961 writeLineAcc8
 962 br 1123
 963 acc16= constant 999
 964 writeLineAcc16
 965 ;testBitwiseOperators.j(144)     //acc byte/var word
 966 ;testBitwiseOperators.j(145)     if (0x10 + 0x0C & w2 == 0x0014) println (79); else println (999);
 967 acc8= constant 16
 968 acc8+ constant 12
 969 acc8ToAcc16
 970 acc16And variable 4
 971 acc8= constant 20
 972 acc16CompareAcc8
 973 brne 1135
 974 acc8= constant 79
 975 writeLineAcc8
 976 br 1138
 977 acc16= constant 999
 978 writeLineAcc16
 979 ;testBitwiseOperators.j(146)     if (0x10 + 0x0C | w2 == 0x123C) println (80); else println (999);
 980 acc8= constant 16
 981 acc8+ constant 12
 982 acc8ToAcc16
 983 acc16Or variable 4
 984 acc16Comp constant 4668
 985 brne 1149
 986 acc8= constant 80
 987 writeLineAcc8
 988 br 1152
 989 acc16= constant 999
 990 writeLineAcc16
 991 ;testBitwiseOperators.j(147)     if (0x10 + 0x0C ^ w2 == 0x1228) println (81); else println (999);
 992 acc8= constant 16
 993 acc8+ constant 12
 994 acc8ToAcc16
 995 acc16Xor variable 4
 996 acc16Comp constant 4648
 997 brne 1163
 998 acc8= constant 81
 999 writeLineAcc8
1000 br 1167
1001 acc16= constant 999
1002 writeLineAcc16
1003 ;testBitwiseOperators.j(148)     //acc word/var byte
1004 ;testBitwiseOperators.j(149)     if (0x1000 + 0x0234 & b1 == 0x0014) println (82); else println (999);
1005 acc16= constant 4096
1006 acc16+ constant 564
1007 acc16And variable 0
1008 acc8= constant 20
1009 acc16CompareAcc8
1010 brne 1178
1011 acc8= constant 82
1012 writeLineAcc8
1013 br 1181
1014 acc16= constant 999
1015 writeLineAcc16
1016 ;testBitwiseOperators.j(150)     if (0x1000 + 0x0234 | b1 == 0x123C) println (83); else println (999);
1017 acc16= constant 4096
1018 acc16+ constant 564
1019 acc16Or variable 0
1020 acc16Comp constant 4668
1021 brne 1191
1022 acc8= constant 83
1023 writeLineAcc8
1024 br 1194
1025 acc16= constant 999
1026 writeLineAcc16
1027 ;testBitwiseOperators.j(151)     if (0x1000 + 0x0234 ^ b1 == 0x1228) println (84); else println (999);
1028 acc16= constant 4096
1029 acc16+ constant 564
1030 acc16Xor variable 0
1031 acc16Comp constant 4648
1032 brne 1204
1033 acc8= constant 84
1034 writeLineAcc8
1035 br 1211
1036 acc16= constant 999
1037 writeLineAcc16
1038 ;testBitwiseOperators.j(152)   
1039 ;testBitwiseOperators.j(153)     //acc/final var
1040 ;testBitwiseOperators.j(154)     //*************
1041 ;testBitwiseOperators.j(155)     //acc byte/final var byte
1042 ;testBitwiseOperators.j(156)     if (0x04 + 0x03 & fb1 == 0x04) println (85); else println (999);
1043 acc8= constant 4
1044 acc8+ constant 3
1045 acc8And constant 28
1046 acc8Comp constant 4
1047 brne 1221
1048 acc8= constant 85
1049 writeLineAcc8
1050 br 1224
1051 acc16= constant 999
1052 writeLineAcc16
1053 ;testBitwiseOperators.j(157)     if (0x04 + 0x03 | fb1 == 0x1F) println (86); else println (999);
1054 acc8= constant 4
1055 acc8+ constant 3
1056 acc8Or constant 28
1057 acc8Comp constant 31
1058 brne 1234
1059 acc8= constant 86
1060 writeLineAcc8
1061 br 1237
1062 acc16= constant 999
1063 writeLineAcc16
1064 ;testBitwiseOperators.j(158)     if (0x04 + 0x03 ^ fb1 == 0x1B) println (87); else println (999);
1065 acc8= constant 4
1066 acc8+ constant 3
1067 acc8Xor constant 28
1068 acc8Comp constant 27
1069 brne 1247
1070 acc8= constant 87
1071 writeLineAcc8
1072 br 1251
1073 acc16= constant 999
1074 writeLineAcc16
1075 ;testBitwiseOperators.j(159)     //acc word/final var word
1076 ;testBitwiseOperators.j(160)     if (0x1000 + 0x0234 & fw1 == 0x0224) println (88); else println (999);
1077 acc16= constant 4096
1078 acc16+ constant 564
1079 acc16And constant 812
1080 acc16Comp constant 548
1081 brne 1261
1082 acc8= constant 88
1083 writeLineAcc8
1084 br 1264
1085 acc16= constant 999
1086 writeLineAcc16
1087 ;testBitwiseOperators.j(161)     if (0x1000 + 0x0234 | fw1 == 0x133C) println (89); else println (999);
1088 acc16= constant 4096
1089 acc16+ constant 564
1090 acc16Or constant 812
1091 acc16Comp constant 4924
1092 brne 1274
1093 acc8= constant 89
1094 writeLineAcc8
1095 br 1277
1096 acc16= constant 999
1097 writeLineAcc16
1098 ;testBitwiseOperators.j(162)     if (0x1000 + 0x0234 ^ fw1 == 0x1118) println (90); else println (999);
1099 acc16= constant 4096
1100 acc16+ constant 564
1101 acc16Xor constant 812
1102 acc16Comp constant 4376
1103 brne 1287
1104 acc8= constant 90
1105 writeLineAcc8
1106 br 1291
1107 acc16= constant 999
1108 writeLineAcc16
1109 ;testBitwiseOperators.j(163)     //acc byte/final var word
1110 ;testBitwiseOperators.j(164)     if (0x10 + 0x0C & fw2 == 0x0014) println (91); else println (999);
1111 acc8= constant 16
1112 acc8+ constant 12
1113 acc8ToAcc16
1114 acc16And constant 4660
1115 acc8= constant 20
1116 acc16CompareAcc8
1117 brne 1303
1118 acc8= constant 91
1119 writeLineAcc8
1120 br 1306
1121 acc16= constant 999
1122 writeLineAcc16
1123 ;testBitwiseOperators.j(165)     if (0x10 + 0x0C | fw2 == 0x123C) println (92); else println (999);
1124 acc8= constant 16
1125 acc8+ constant 12
1126 acc8ToAcc16
1127 acc16Or constant 4660
1128 acc16Comp constant 4668
1129 brne 1317
1130 acc8= constant 92
1131 writeLineAcc8
1132 br 1320
1133 acc16= constant 999
1134 writeLineAcc16
1135 ;testBitwiseOperators.j(166)     if (0x10 + 0x0C ^ fw2 == 0x1228) println (93); else println (999);
1136 acc8= constant 16
1137 acc8+ constant 12
1138 acc8ToAcc16
1139 acc16Xor constant 4660
1140 acc16Comp constant 4648
1141 brne 1331
1142 acc8= constant 93
1143 writeLineAcc8
1144 br 1335
1145 acc16= constant 999
1146 writeLineAcc16
1147 ;testBitwiseOperators.j(167)     //acc word/final var byte
1148 ;testBitwiseOperators.j(168)     if (0x1000 + 0x0234 & fb1 == 0x0014) println (94); else println (999);
1149 acc16= constant 4096
1150 acc16+ constant 564
1151 acc16And constant 28
1152 acc8= constant 20
1153 acc16CompareAcc8
1154 brne 1346
1155 acc8= constant 94
1156 writeLineAcc8
1157 br 1349
1158 acc16= constant 999
1159 writeLineAcc16
1160 ;testBitwiseOperators.j(169)     if (0x1000 + 0x0234 | fb1 == 0x123C) println (95); else println (999);
1161 acc16= constant 4096
1162 acc16+ constant 564
1163 acc16Or constant 28
1164 acc16Comp constant 4668
1165 brne 1359
1166 acc8= constant 95
1167 writeLineAcc8
1168 br 1362
1169 acc16= constant 999
1170 writeLineAcc16
1171 ;testBitwiseOperators.j(170)     if (0x1000 + 0x0234 ^ fb1 == 0x1228) println (96); else println (999);
1172 acc16= constant 4096
1173 acc16+ constant 564
1174 acc16Xor constant 28
1175 acc16Comp constant 4648
1176 brne 1372
1177 acc8= constant 96
1178 writeLineAcc8
1179 br 1379
1180 acc16= constant 999
1181 writeLineAcc16
1182 ;testBitwiseOperators.j(171)   
1183 ;testBitwiseOperators.j(172)     //var/constant
1184 ;testBitwiseOperators.j(173)     //************
1185 ;testBitwiseOperators.j(174)     //var byte/constant byte
1186 ;testBitwiseOperators.j(175)     if (b2 & 0x1C == 0x04) println (97); else println (999);
1187 acc8= variable 1
1188 acc8And constant 28
1189 acc8Comp constant 4
1190 brne 1388
1191 acc8= constant 97
1192 writeLineAcc8
1193 br 1391
1194 acc16= constant 999
1195 writeLineAcc16
1196 ;testBitwiseOperators.j(176)     if (b2 | 0x1C == 0x1F) println (98); else println (999);
1197 acc8= variable 1
1198 acc8Or constant 28
1199 acc8Comp constant 31
1200 brne 1400
1201 acc8= constant 98
1202 writeLineAcc8
1203 br 1403
1204 acc16= constant 999
1205 writeLineAcc16
1206 ;testBitwiseOperators.j(177)     if (b2 ^ 0x1C == 0x1B) println (99); else println (999);
1207 acc8= variable 1
1208 acc8Xor constant 28
1209 acc8Comp constant 27
1210 brne 1412
1211 acc8= constant 99
1212 writeLineAcc8
1213 br 1416
1214 acc16= constant 999
1215 writeLineAcc16
1216 ;testBitwiseOperators.j(178)     //var word/constant word
1217 ;testBitwiseOperators.j(179)     if (w2 & 0x032C == 0x0224) println (100); else println (999);
1218 acc16= variable 4
1219 acc16And constant 812
1220 acc16Comp constant 548
1221 brne 1425
1222 acc8= constant 100
1223 writeLineAcc8
1224 br 1428
1225 acc16= constant 999
1226 writeLineAcc16
1227 ;testBitwiseOperators.j(180)     if (w2 | 0x032C == 0x133C) println (101); else println (999);
1228 acc16= variable 4
1229 acc16Or constant 812
1230 acc16Comp constant 4924
1231 brne 1437
1232 acc8= constant 101
1233 writeLineAcc8
1234 br 1440
1235 acc16= constant 999
1236 writeLineAcc16
1237 ;testBitwiseOperators.j(181)     if (w2 ^ 0x032C == 0x1118) println (102); else println (999);
1238 acc16= variable 4
1239 acc16Xor constant 812
1240 acc16Comp constant 4376
1241 brne 1449
1242 acc8= constant 102
1243 writeLineAcc8
1244 br 1453
1245 acc16= constant 999
1246 writeLineAcc16
1247 ;testBitwiseOperators.j(182)     //var byte/constant word
1248 ;testBitwiseOperators.j(183)     if (b1 & 0x1234 == 0x0014) println (103); else println (999);
1249 acc8= variable 0
1250 acc8ToAcc16
1251 acc16And constant 4660
1252 acc8= constant 20
1253 acc16CompareAcc8
1254 brne 1464
1255 acc8= constant 103
1256 writeLineAcc8
1257 br 1467
1258 acc16= constant 999
1259 writeLineAcc16
1260 ;testBitwiseOperators.j(184)     if (b1 | 0x1234 == 0x123C) println (104); else println (999);
1261 acc8= variable 0
1262 acc8ToAcc16
1263 acc16Or constant 4660
1264 acc16Comp constant 4668
1265 brne 1477
1266 acc8= constant 104
1267 writeLineAcc8
1268 br 1480
1269 acc16= constant 999
1270 writeLineAcc16
1271 ;testBitwiseOperators.j(185)     if (b1 ^ 0x1234 == 0x1228) println (105); else println (999);
1272 acc8= variable 0
1273 acc8ToAcc16
1274 acc16Xor constant 4660
1275 acc16Comp constant 4648
1276 brne 1490
1277 acc8= constant 105
1278 writeLineAcc8
1279 br 1494
1280 acc16= constant 999
1281 writeLineAcc16
1282 ;testBitwiseOperators.j(186)     //var word/constant byte
1283 ;testBitwiseOperators.j(187)     if (w2 & 0x1C == 0x0014) println (106); else println (999);
1284 acc16= variable 4
1285 acc16And constant 28
1286 acc8= constant 20
1287 acc16CompareAcc8
1288 brne 1504
1289 acc8= constant 106
1290 writeLineAcc8
1291 br 1507
1292 acc16= constant 999
1293 writeLineAcc16
1294 ;testBitwiseOperators.j(188)     if (w2 | 0x1C == 0x123C) println (107); else println (999);
1295 acc16= variable 4
1296 acc16Or constant 28
1297 acc16Comp constant 4668
1298 brne 1516
1299 acc8= constant 107
1300 writeLineAcc8
1301 br 1519
1302 acc16= constant 999
1303 writeLineAcc16
1304 ;testBitwiseOperators.j(189)     if (w2 ^ 0x1C == 0x1228) println (108); else println (999);
1305 acc16= variable 4
1306 acc16Xor constant 28
1307 acc16Comp constant 4648
1308 brne 1528
1309 acc8= constant 108
1310 writeLineAcc8
1311 br 1535
1312 acc16= constant 999
1313 writeLineAcc16
1314 ;testBitwiseOperators.j(190)   
1315 ;testBitwiseOperators.j(191)     //var/acc
1316 ;testBitwiseOperators.j(192)     //*******
1317 ;testBitwiseOperators.j(193)     //var byte/acc byte
1318 ;testBitwiseOperators.j(194)     if (b2 & (0x10 + 0x0C) == 0x04) println (109); else println (999);
1319 acc8= variable 1
1320 <acc8= constant 16
1321 acc8+ constant 12
1322 acc8And unstack8
1323 acc8Comp constant 4
1324 brne 1546
1325 acc8= constant 109
1326 writeLineAcc8
1327 br 1549
1328 acc16= constant 999
1329 writeLineAcc16
1330 ;testBitwiseOperators.j(195)     if (b2 | (0x10 + 0x0C) == 0x1F) println (110); else println (999);
1331 acc8= variable 1
1332 <acc8= constant 16
1333 acc8+ constant 12
1334 acc8Or unstack8
1335 acc8Comp constant 31
1336 brne 1560
1337 acc8= constant 110
1338 writeLineAcc8
1339 br 1563
1340 acc16= constant 999
1341 writeLineAcc16
1342 ;testBitwiseOperators.j(196)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (111); else println (999);
1343 acc8= variable 1
1344 <acc8= constant 16
1345 acc8+ constant 12
1346 acc8Xor unstack8
1347 acc8Comp constant 27
1348 brne 1574
1349 acc8= constant 111
1350 writeLineAcc8
1351 br 1578
1352 acc16= constant 999
1353 writeLineAcc16
1354 ;testBitwiseOperators.j(197)     //var word/acc word
1355 ;testBitwiseOperators.j(198)     if (w2 & 0x0100 + 0x022C == 0x0224) println (112); else println (999);
1356 acc16= variable 4
1357 <acc16= constant 256
1358 acc16+ constant 556
1359 acc16And unstack16
1360 acc16Comp constant 548
1361 brne 1589
1362 acc8= constant 112
1363 writeLineAcc8
1364 br 1592
1365 acc16= constant 999
1366 writeLineAcc16
1367 ;testBitwiseOperators.j(199)     if (w2 | 0x0100 + 0x022C == 0x133C) println (113); else println (999);
1368 acc16= variable 4
1369 <acc16= constant 256
1370 acc16+ constant 556
1371 acc16Or unstack16
1372 acc16Comp constant 4924
1373 brne 1603
1374 acc8= constant 113
1375 writeLineAcc8
1376 br 1606
1377 acc16= constant 999
1378 writeLineAcc16
1379 ;testBitwiseOperators.j(200)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (114); else println (999);
1380 acc16= variable 4
1381 <acc16= constant 256
1382 acc16+ constant 556
1383 acc16Xor unstack16
1384 acc16Comp constant 4376
1385 brne 1617
1386 acc8= constant 114
1387 writeLineAcc8
1388 br 1621
1389 acc16= constant 999
1390 writeLineAcc16
1391 ;testBitwiseOperators.j(201)     //var byte/acc word
1392 ;testBitwiseOperators.j(202)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (115); else println (999);
1393 acc8= variable 0
1394 acc16= constant 4096
1395 acc16+ constant 564
1396 acc16And acc8
1397 acc8= constant 20
1398 acc16CompareAcc8
1399 brne 1633
1400 acc8= constant 115
1401 writeLineAcc8
1402 br 1636
1403 acc16= constant 999
1404 writeLineAcc16
1405 ;testBitwiseOperators.j(203)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (116); else println (999);
1406 acc8= variable 0
1407 acc16= constant 4096
1408 acc16+ constant 564
1409 acc16Or acc8
1410 acc16Comp constant 4668
1411 brne 1647
1412 acc8= constant 116
1413 writeLineAcc8
1414 br 1650
1415 acc16= constant 999
1416 writeLineAcc16
1417 ;testBitwiseOperators.j(204)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (117); else println (999);
1418 acc8= variable 0
1419 acc16= constant 4096
1420 acc16+ constant 564
1421 acc16Xor acc8
1422 acc16Comp constant 4648
1423 brne 1661
1424 acc8= constant 117
1425 writeLineAcc8
1426 br 1665
1427 acc16= constant 999
1428 writeLineAcc16
1429 ;testBitwiseOperators.j(205)     //var word/acc byte
1430 ;testBitwiseOperators.j(206)     if (w2 & 0x10 + 0x0C == 0x0014) println (118); else println (999);
1431 acc16= variable 4
1432 acc8= constant 16
1433 acc8+ constant 12
1434 acc16And acc8
1435 acc8= constant 20
1436 acc16CompareAcc8
1437 brne 1677
1438 acc8= constant 118
1439 writeLineAcc8
1440 br 1680
1441 acc16= constant 999
1442 writeLineAcc16
1443 ;testBitwiseOperators.j(207)     if (w2 | 0x10 + 0x0C == 0x123C) println (119); else println (999);
1444 acc16= variable 4
1445 acc8= constant 16
1446 acc8+ constant 12
1447 acc16Or acc8
1448 acc16Comp constant 4668
1449 brne 1691
1450 acc8= constant 119
1451 writeLineAcc8
1452 br 1694
1453 acc16= constant 999
1454 writeLineAcc16
1455 ;testBitwiseOperators.j(208)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (120); else println (999);
1456 acc16= variable 4
1457 acc8= constant 16
1458 acc8+ constant 12
1459 acc16Xor acc8
1460 acc16Comp constant 4648
1461 brne 1705
1462 acc8= constant 120
1463 writeLineAcc8
1464 br 1712
1465 acc16= constant 999
1466 writeLineAcc16
1467 ;testBitwiseOperators.j(209)   
1468 ;testBitwiseOperators.j(210)     //var/var
1469 ;testBitwiseOperators.j(211)     //*******
1470 ;testBitwiseOperators.j(212)     //var byte/var byte
1471 ;testBitwiseOperators.j(213)     if (b2 & b1 == 0x04) println (121); else println (999);
1472 acc8= variable 1
1473 acc8And variable 0
1474 acc8Comp constant 4
1475 brne 1721
1476 acc8= constant 121
1477 writeLineAcc8
1478 br 1724
1479 acc16= constant 999
1480 writeLineAcc16
1481 ;testBitwiseOperators.j(214)     if (b2 | b1 == 0x1F) println (122); else println (999);
1482 acc8= variable 1
1483 acc8Or variable 0
1484 acc8Comp constant 31
1485 brne 1733
1486 acc8= constant 122
1487 writeLineAcc8
1488 br 1736
1489 acc16= constant 999
1490 writeLineAcc16
1491 ;testBitwiseOperators.j(215)     if (b2 ^ b1 == 0x1B) println (123); else println (999);
1492 acc8= variable 1
1493 acc8Xor variable 0
1494 acc8Comp constant 27
1495 brne 1745
1496 acc8= constant 123
1497 writeLineAcc8
1498 br 1749
1499 acc16= constant 999
1500 writeLineAcc16
1501 ;testBitwiseOperators.j(216)     //var word/var word
1502 ;testBitwiseOperators.j(217)     if (w2 & w1 == 0x0224) println (124); else println (999);
1503 acc16= variable 4
1504 acc16And variable 2
1505 acc16Comp constant 548
1506 brne 1758
1507 acc8= constant 124
1508 writeLineAcc8
1509 br 1761
1510 acc16= constant 999
1511 writeLineAcc16
1512 ;testBitwiseOperators.j(218)     if (w2 | w1 == 0x133C) println (125); else println (999);
1513 acc16= variable 4
1514 acc16Or variable 2
1515 acc16Comp constant 4924
1516 brne 1770
1517 acc8= constant 125
1518 writeLineAcc8
1519 br 1773
1520 acc16= constant 999
1521 writeLineAcc16
1522 ;testBitwiseOperators.j(219)     if (w2 ^ w1 == 0x1118) println (126); else println (999);
1523 acc16= variable 4
1524 acc16Xor variable 2
1525 acc16Comp constant 4376
1526 brne 1782
1527 acc8= constant 126
1528 writeLineAcc8
1529 br 1786
1530 acc16= constant 999
1531 writeLineAcc16
1532 ;testBitwiseOperators.j(220)     //var byte/var word
1533 ;testBitwiseOperators.j(221)     if (b1 & w2 == 0x0014) println (127); else println (999);
1534 acc8= variable 0
1535 acc8ToAcc16
1536 acc16And variable 4
1537 acc8= constant 20
1538 acc16CompareAcc8
1539 brne 1797
1540 acc8= constant 127
1541 writeLineAcc8
1542 br 1800
1543 acc16= constant 999
1544 writeLineAcc16
1545 ;testBitwiseOperators.j(222)     if (b1 | w2 == 0x123C) println (128); else println (999);
1546 acc8= variable 0
1547 acc8ToAcc16
1548 acc16Or variable 4
1549 acc16Comp constant 4668
1550 brne 1810
1551 acc8= constant 128
1552 writeLineAcc8
1553 br 1813
1554 acc16= constant 999
1555 writeLineAcc16
1556 ;testBitwiseOperators.j(223)     if (b1 ^ w2 == 0x1228) println (129); else println (999);
1557 acc8= variable 0
1558 acc8ToAcc16
1559 acc16Xor variable 4
1560 acc16Comp constant 4648
1561 brne 1823
1562 acc8= constant 129
1563 writeLineAcc8
1564 br 1827
1565 acc16= constant 999
1566 writeLineAcc16
1567 ;testBitwiseOperators.j(224)     //var word/var byte
1568 ;testBitwiseOperators.j(225)     if (w2 & b1 == 0x0014) println (130); else println (999);
1569 acc16= variable 4
1570 acc16And variable 0
1571 acc8= constant 20
1572 acc16CompareAcc8
1573 brne 1837
1574 acc8= constant 130
1575 writeLineAcc8
1576 br 1840
1577 acc16= constant 999
1578 writeLineAcc16
1579 ;testBitwiseOperators.j(226)     if (w2 | b1 == 0x123C) println (131); else println (999);
1580 acc16= variable 4
1581 acc16Or variable 0
1582 acc16Comp constant 4668
1583 brne 1849
1584 acc8= constant 131
1585 writeLineAcc8
1586 br 1852
1587 acc16= constant 999
1588 writeLineAcc16
1589 ;testBitwiseOperators.j(227)     if (w2 ^ b1 == 0x1228) println (132); else println (999);
1590 acc16= variable 4
1591 acc16Xor variable 0
1592 acc16Comp constant 4648
1593 brne 1861
1594 acc8= constant 132
1595 writeLineAcc8
1596 br 1868
1597 acc16= constant 999
1598 writeLineAcc16
1599 ;testBitwiseOperators.j(228)   
1600 ;testBitwiseOperators.j(229)     //var/final var
1601 ;testBitwiseOperators.j(230)     //*************
1602 ;testBitwiseOperators.j(231)     //var byte/final var byte
1603 ;testBitwiseOperators.j(232)     if (b2 & fb1 == 0x04) println (133); else println (999);
1604 acc8= variable 1
1605 acc8And constant 28
1606 acc8Comp constant 4
1607 brne 1877
1608 acc8= constant 133
1609 writeLineAcc8
1610 br 1880
1611 acc16= constant 999
1612 writeLineAcc16
1613 ;testBitwiseOperators.j(233)     if (b2 | fb1 == 0x1F) println (134); else println (999);
1614 acc8= variable 1
1615 acc8Or constant 28
1616 acc8Comp constant 31
1617 brne 1889
1618 acc8= constant 134
1619 writeLineAcc8
1620 br 1892
1621 acc16= constant 999
1622 writeLineAcc16
1623 ;testBitwiseOperators.j(234)     if (b2 ^ fb1 == 0x1B) println (135); else println (999);
1624 acc8= variable 1
1625 acc8Xor constant 28
1626 acc8Comp constant 27
1627 brne 1901
1628 acc8= constant 135
1629 writeLineAcc8
1630 br 1905
1631 acc16= constant 999
1632 writeLineAcc16
1633 ;testBitwiseOperators.j(235)     //var word/final var word
1634 ;testBitwiseOperators.j(236)     if (w2 & fw1 == 0x0224) println (136); else println (999);
1635 acc16= variable 4
1636 acc16And constant 812
1637 acc16Comp constant 548
1638 brne 1914
1639 acc8= constant 136
1640 writeLineAcc8
1641 br 1917
1642 acc16= constant 999
1643 writeLineAcc16
1644 ;testBitwiseOperators.j(237)     if (w2 | fw1 == 0x133C) println (137); else println (999);
1645 acc16= variable 4
1646 acc16Or constant 812
1647 acc16Comp constant 4924
1648 brne 1926
1649 acc8= constant 137
1650 writeLineAcc8
1651 br 1929
1652 acc16= constant 999
1653 writeLineAcc16
1654 ;testBitwiseOperators.j(238)     if (w2 ^ fw1 == 0x1118) println (138); else println (999);
1655 acc16= variable 4
1656 acc16Xor constant 812
1657 acc16Comp constant 4376
1658 brne 1938
1659 acc8= constant 138
1660 writeLineAcc8
1661 br 1942
1662 acc16= constant 999
1663 writeLineAcc16
1664 ;testBitwiseOperators.j(239)     //var byte/final var word
1665 ;testBitwiseOperators.j(240)     if (b1 & fw2 == 0x0014) println (139); else println (999);
1666 acc8= variable 0
1667 acc8ToAcc16
1668 acc16And constant 4660
1669 acc8= constant 20
1670 acc16CompareAcc8
1671 brne 1953
1672 acc8= constant 139
1673 writeLineAcc8
1674 br 1956
1675 acc16= constant 999
1676 writeLineAcc16
1677 ;testBitwiseOperators.j(241)     if (b1 | fw2 == 0x123C) println (140); else println (999);
1678 acc8= variable 0
1679 acc8ToAcc16
1680 acc16Or constant 4660
1681 acc16Comp constant 4668
1682 brne 1966
1683 acc8= constant 140
1684 writeLineAcc8
1685 br 1969
1686 acc16= constant 999
1687 writeLineAcc16
1688 ;testBitwiseOperators.j(242)     if (b1 ^ fw2 == 0x1228) println (141); else println (999);
1689 acc8= variable 0
1690 acc8ToAcc16
1691 acc16Xor constant 4660
1692 acc16Comp constant 4648
1693 brne 1979
1694 acc8= constant 141
1695 writeLineAcc8
1696 br 1983
1697 acc16= constant 999
1698 writeLineAcc16
1699 ;testBitwiseOperators.j(243)     //var word/final var byte
1700 ;testBitwiseOperators.j(244)     if (w2 & fb1 == 0x0014) println (142); else println (999);
1701 acc16= variable 4
1702 acc16And constant 28
1703 acc8= constant 20
1704 acc16CompareAcc8
1705 brne 1993
1706 acc8= constant 142
1707 writeLineAcc8
1708 br 1996
1709 acc16= constant 999
1710 writeLineAcc16
1711 ;testBitwiseOperators.j(245)     if (w2 | fb1 == 0x123C) println (143); else println (999);
1712 acc16= variable 4
1713 acc16Or constant 28
1714 acc16Comp constant 4668
1715 brne 2005
1716 acc8= constant 143
1717 writeLineAcc8
1718 br 2008
1719 acc16= constant 999
1720 writeLineAcc16
1721 ;testBitwiseOperators.j(246)     if (w2 ^ fb1 == 0x1228) println (144); else println (999);
1722 acc16= variable 4
1723 acc16Xor constant 28
1724 acc16Comp constant 4648
1725 brne 2017
1726 acc8= constant 144
1727 writeLineAcc8
1728 br 2024
1729 acc16= constant 999
1730 writeLineAcc16
1731 ;testBitwiseOperators.j(247)   
1732 ;testBitwiseOperators.j(248)     //final var/constant
1733 ;testBitwiseOperators.j(249)     //******************
1734 ;testBitwiseOperators.j(250)     //final var byte/constant byte
1735 ;testBitwiseOperators.j(251)     if (b2 & 0x1C == 0x04) println (145); else println (999);
1736 acc8= variable 1
1737 acc8And constant 28
1738 acc8Comp constant 4
1739 brne 2033
1740 acc8= constant 145
1741 writeLineAcc8
1742 br 2036
1743 acc16= constant 999
1744 writeLineAcc16
1745 ;testBitwiseOperators.j(252)     if (b2 | 0x1C == 0x1F) println (146); else println (999);
1746 acc8= variable 1
1747 acc8Or constant 28
1748 acc8Comp constant 31
1749 brne 2045
1750 acc8= constant 146
1751 writeLineAcc8
1752 br 2048
1753 acc16= constant 999
1754 writeLineAcc16
1755 ;testBitwiseOperators.j(253)     if (b2 ^ 0x1C == 0x1B) println (147); else println (999);
1756 acc8= variable 1
1757 acc8Xor constant 28
1758 acc8Comp constant 27
1759 brne 2057
1760 acc8= constant 147
1761 writeLineAcc8
1762 br 2061
1763 acc16= constant 999
1764 writeLineAcc16
1765 ;testBitwiseOperators.j(254)     //final var word/constant word
1766 ;testBitwiseOperators.j(255)     if (w2 & 0x032C == 0x0224) println (148); else println (999);
1767 acc16= variable 4
1768 acc16And constant 812
1769 acc16Comp constant 548
1770 brne 2070
1771 acc8= constant 148
1772 writeLineAcc8
1773 br 2073
1774 acc16= constant 999
1775 writeLineAcc16
1776 ;testBitwiseOperators.j(256)     if (w2 | 0x032C == 0x133C) println (149); else println (999);
1777 acc16= variable 4
1778 acc16Or constant 812
1779 acc16Comp constant 4924
1780 brne 2082
1781 acc8= constant 149
1782 writeLineAcc8
1783 br 2085
1784 acc16= constant 999
1785 writeLineAcc16
1786 ;testBitwiseOperators.j(257)     if (w2 ^ 0x032C == 0x1118) println (150); else println (999);
1787 acc16= variable 4
1788 acc16Xor constant 812
1789 acc16Comp constant 4376
1790 brne 2094
1791 acc8= constant 150
1792 writeLineAcc8
1793 br 2098
1794 acc16= constant 999
1795 writeLineAcc16
1796 ;testBitwiseOperators.j(258)     //final var byte/constant word
1797 ;testBitwiseOperators.j(259)     if (b1 & 0x1234 == 0x0014) println (151); else println (999);
1798 acc8= variable 0
1799 acc8ToAcc16
1800 acc16And constant 4660
1801 acc8= constant 20
1802 acc16CompareAcc8
1803 brne 2109
1804 acc8= constant 151
1805 writeLineAcc8
1806 br 2112
1807 acc16= constant 999
1808 writeLineAcc16
1809 ;testBitwiseOperators.j(260)     if (b1 | 0x1234 == 0x123C) println (152); else println (999);
1810 acc8= variable 0
1811 acc8ToAcc16
1812 acc16Or constant 4660
1813 acc16Comp constant 4668
1814 brne 2122
1815 acc8= constant 152
1816 writeLineAcc8
1817 br 2125
1818 acc16= constant 999
1819 writeLineAcc16
1820 ;testBitwiseOperators.j(261)     if (b1 ^ 0x1234 == 0x1228) println (153); else println (999);
1821 acc8= variable 0
1822 acc8ToAcc16
1823 acc16Xor constant 4660
1824 acc16Comp constant 4648
1825 brne 2135
1826 acc8= constant 153
1827 writeLineAcc8
1828 br 2139
1829 acc16= constant 999
1830 writeLineAcc16
1831 ;testBitwiseOperators.j(262)     //final var word/constant byte
1832 ;testBitwiseOperators.j(263)     if (w2 & 0x1C == 0x0014) println (154); else println (999);
1833 acc16= variable 4
1834 acc16And constant 28
1835 acc8= constant 20
1836 acc16CompareAcc8
1837 brne 2149
1838 acc8= constant 154
1839 writeLineAcc8
1840 br 2152
1841 acc16= constant 999
1842 writeLineAcc16
1843 ;testBitwiseOperators.j(264)     if (w2 | 0x1C == 0x123C) println (155); else println (999);
1844 acc16= variable 4
1845 acc16Or constant 28
1846 acc16Comp constant 4668
1847 brne 2161
1848 acc8= constant 155
1849 writeLineAcc8
1850 br 2164
1851 acc16= constant 999
1852 writeLineAcc16
1853 ;testBitwiseOperators.j(265)     if (w2 ^ 0x1C == 0x1228) println (156); else println (999);
1854 acc16= variable 4
1855 acc16Xor constant 28
1856 acc16Comp constant 4648
1857 brne 2173
1858 acc8= constant 156
1859 writeLineAcc8
1860 br 2180
1861 acc16= constant 999
1862 writeLineAcc16
1863 ;testBitwiseOperators.j(266)   
1864 ;testBitwiseOperators.j(267)     //final var/acc
1865 ;testBitwiseOperators.j(268)     //*************
1866 ;testBitwiseOperators.j(269)     //final var byte/acc byte
1867 ;testBitwiseOperators.j(270)     if (b2 & (0x10 + 0x0C) == 0x04) println (157); else println (999);
1868 acc8= variable 1
1869 <acc8= constant 16
1870 acc8+ constant 12
1871 acc8And unstack8
1872 acc8Comp constant 4
1873 brne 2191
1874 acc8= constant 157
1875 writeLineAcc8
1876 br 2194
1877 acc16= constant 999
1878 writeLineAcc16
1879 ;testBitwiseOperators.j(271)     if (b2 | (0x10 + 0x0C) == 0x1F) println (158); else println (999);
1880 acc8= variable 1
1881 <acc8= constant 16
1882 acc8+ constant 12
1883 acc8Or unstack8
1884 acc8Comp constant 31
1885 brne 2205
1886 acc8= constant 158
1887 writeLineAcc8
1888 br 2208
1889 acc16= constant 999
1890 writeLineAcc16
1891 ;testBitwiseOperators.j(272)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (159); else println (999);
1892 acc8= variable 1
1893 <acc8= constant 16
1894 acc8+ constant 12
1895 acc8Xor unstack8
1896 acc8Comp constant 27
1897 brne 2219
1898 acc8= constant 159
1899 writeLineAcc8
1900 br 2223
1901 acc16= constant 999
1902 writeLineAcc16
1903 ;testBitwiseOperators.j(273)     //final var word/acc word
1904 ;testBitwiseOperators.j(274)     if (w2 & 0x0100 + 0x022C == 0x0224) println (160); else println (999);
1905 acc16= variable 4
1906 <acc16= constant 256
1907 acc16+ constant 556
1908 acc16And unstack16
1909 acc16Comp constant 548
1910 brne 2234
1911 acc8= constant 160
1912 writeLineAcc8
1913 br 2237
1914 acc16= constant 999
1915 writeLineAcc16
1916 ;testBitwiseOperators.j(275)     if (w2 | 0x0100 + 0x022C == 0x133C) println (161); else println (999);
1917 acc16= variable 4
1918 <acc16= constant 256
1919 acc16+ constant 556
1920 acc16Or unstack16
1921 acc16Comp constant 4924
1922 brne 2248
1923 acc8= constant 161
1924 writeLineAcc8
1925 br 2251
1926 acc16= constant 999
1927 writeLineAcc16
1928 ;testBitwiseOperators.j(276)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (162); else println (999);
1929 acc16= variable 4
1930 <acc16= constant 256
1931 acc16+ constant 556
1932 acc16Xor unstack16
1933 acc16Comp constant 4376
1934 brne 2262
1935 acc8= constant 162
1936 writeLineAcc8
1937 br 2266
1938 acc16= constant 999
1939 writeLineAcc16
1940 ;testBitwiseOperators.j(277)     //final var byte/acc word
1941 ;testBitwiseOperators.j(278)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (163); else println (999);
1942 acc8= variable 0
1943 acc16= constant 4096
1944 acc16+ constant 564
1945 acc16And acc8
1946 acc8= constant 20
1947 acc16CompareAcc8
1948 brne 2278
1949 acc8= constant 163
1950 writeLineAcc8
1951 br 2281
1952 acc16= constant 999
1953 writeLineAcc16
1954 ;testBitwiseOperators.j(279)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (164); else println (999);
1955 acc8= variable 0
1956 acc16= constant 4096
1957 acc16+ constant 564
1958 acc16Or acc8
1959 acc16Comp constant 4668
1960 brne 2292
1961 acc8= constant 164
1962 writeLineAcc8
1963 br 2295
1964 acc16= constant 999
1965 writeLineAcc16
1966 ;testBitwiseOperators.j(280)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (165); else println (999);
1967 acc8= variable 0
1968 acc16= constant 4096
1969 acc16+ constant 564
1970 acc16Xor acc8
1971 acc16Comp constant 4648
1972 brne 2306
1973 acc8= constant 165
1974 writeLineAcc8
1975 br 2310
1976 acc16= constant 999
1977 writeLineAcc16
1978 ;testBitwiseOperators.j(281)     //final var word/acc byte
1979 ;testBitwiseOperators.j(282)     if (w2 & 0x10 + 0x0C == 0x0014) println (166); else println (999);
1980 acc16= variable 4
1981 acc8= constant 16
1982 acc8+ constant 12
1983 acc16And acc8
1984 acc8= constant 20
1985 acc16CompareAcc8
1986 brne 2322
1987 acc8= constant 166
1988 writeLineAcc8
1989 br 2325
1990 acc16= constant 999
1991 writeLineAcc16
1992 ;testBitwiseOperators.j(283)     if (w2 | 0x10 + 0x0C == 0x123C) println (167); else println (999);
1993 acc16= variable 4
1994 acc8= constant 16
1995 acc8+ constant 12
1996 acc16Or acc8
1997 acc16Comp constant 4668
1998 brne 2336
1999 acc8= constant 167
2000 writeLineAcc8
2001 br 2339
2002 acc16= constant 999
2003 writeLineAcc16
2004 ;testBitwiseOperators.j(284)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (168); else println (999);
2005 acc16= variable 4
2006 acc8= constant 16
2007 acc8+ constant 12
2008 acc16Xor acc8
2009 acc16Comp constant 4648
2010 brne 2350
2011 acc8= constant 168
2012 writeLineAcc8
2013 br 2357
2014 acc16= constant 999
2015 writeLineAcc16
2016 ;testBitwiseOperators.j(285)   
2017 ;testBitwiseOperators.j(286)     //final var/var
2018 ;testBitwiseOperators.j(287)     //*************
2019 ;testBitwiseOperators.j(288)     //final var byte/var byte
2020 ;testBitwiseOperators.j(289)     if (b2 & b1 == 0x04) println (169); else println (999);
2021 acc8= variable 1
2022 acc8And variable 0
2023 acc8Comp constant 4
2024 brne 2366
2025 acc8= constant 169
2026 writeLineAcc8
2027 br 2369
2028 acc16= constant 999
2029 writeLineAcc16
2030 ;testBitwiseOperators.j(290)     if (b2 | b1 == 0x1F) println (170); else println (999);
2031 acc8= variable 1
2032 acc8Or variable 0
2033 acc8Comp constant 31
2034 brne 2378
2035 acc8= constant 170
2036 writeLineAcc8
2037 br 2381
2038 acc16= constant 999
2039 writeLineAcc16
2040 ;testBitwiseOperators.j(291)     if (b2 ^ b1 == 0x1B) println (171); else println (999);
2041 acc8= variable 1
2042 acc8Xor variable 0
2043 acc8Comp constant 27
2044 brne 2390
2045 acc8= constant 171
2046 writeLineAcc8
2047 br 2394
2048 acc16= constant 999
2049 writeLineAcc16
2050 ;testBitwiseOperators.j(292)     //final var word/var word
2051 ;testBitwiseOperators.j(293)     if (w2 & w1 == 0x0224) println (172); else println (999);
2052 acc16= variable 4
2053 acc16And variable 2
2054 acc16Comp constant 548
2055 brne 2403
2056 acc8= constant 172
2057 writeLineAcc8
2058 br 2406
2059 acc16= constant 999
2060 writeLineAcc16
2061 ;testBitwiseOperators.j(294)     if (w2 | w1 == 0x133C) println (173); else println (999);
2062 acc16= variable 4
2063 acc16Or variable 2
2064 acc16Comp constant 4924
2065 brne 2415
2066 acc8= constant 173
2067 writeLineAcc8
2068 br 2418
2069 acc16= constant 999
2070 writeLineAcc16
2071 ;testBitwiseOperators.j(295)     if (w2 ^ w1 == 0x1118) println (174); else println (999);
2072 acc16= variable 4
2073 acc16Xor variable 2
2074 acc16Comp constant 4376
2075 brne 2427
2076 acc8= constant 174
2077 writeLineAcc8
2078 br 2431
2079 acc16= constant 999
2080 writeLineAcc16
2081 ;testBitwiseOperators.j(296)     //final var byte/var word
2082 ;testBitwiseOperators.j(297)     if (b1 & w2 == 0x0014) println (175); else println (999);
2083 acc8= variable 0
2084 acc8ToAcc16
2085 acc16And variable 4
2086 acc8= constant 20
2087 acc16CompareAcc8
2088 brne 2442
2089 acc8= constant 175
2090 writeLineAcc8
2091 br 2445
2092 acc16= constant 999
2093 writeLineAcc16
2094 ;testBitwiseOperators.j(298)     if (b1 | w2 == 0x123C) println (176); else println (999);
2095 acc8= variable 0
2096 acc8ToAcc16
2097 acc16Or variable 4
2098 acc16Comp constant 4668
2099 brne 2455
2100 acc8= constant 176
2101 writeLineAcc8
2102 br 2458
2103 acc16= constant 999
2104 writeLineAcc16
2105 ;testBitwiseOperators.j(299)     if (b1 ^ w2 == 0x1228) println (177); else println (999);
2106 acc8= variable 0
2107 acc8ToAcc16
2108 acc16Xor variable 4
2109 acc16Comp constant 4648
2110 brne 2468
2111 acc8= constant 177
2112 writeLineAcc8
2113 br 2472
2114 acc16= constant 999
2115 writeLineAcc16
2116 ;testBitwiseOperators.j(300)     //final var word/var byte
2117 ;testBitwiseOperators.j(301)     if (w2 & b1 == 0x0014) println (178); else println (999);
2118 acc16= variable 4
2119 acc16And variable 0
2120 acc8= constant 20
2121 acc16CompareAcc8
2122 brne 2482
2123 acc8= constant 178
2124 writeLineAcc8
2125 br 2485
2126 acc16= constant 999
2127 writeLineAcc16
2128 ;testBitwiseOperators.j(302)     if (w2 | b1 == 0x123C) println (179); else println (999);
2129 acc16= variable 4
2130 acc16Or variable 0
2131 acc16Comp constant 4668
2132 brne 2494
2133 acc8= constant 179
2134 writeLineAcc8
2135 br 2497
2136 acc16= constant 999
2137 writeLineAcc16
2138 ;testBitwiseOperators.j(303)     if (w2 ^ b1 == 0x1228) println (180); else println (999);
2139 acc16= variable 4
2140 acc16Xor variable 0
2141 acc16Comp constant 4648
2142 brne 2506
2143 acc8= constant 180
2144 writeLineAcc8
2145 br 2513
2146 acc16= constant 999
2147 writeLineAcc16
2148 ;testBitwiseOperators.j(304)   
2149 ;testBitwiseOperators.j(305)     //final var/final var
2150 ;testBitwiseOperators.j(306)     //*******************
2151 ;testBitwiseOperators.j(307)     //final var byte/final var byte
2152 ;testBitwiseOperators.j(308)     if (fb2 & fb1 == 0x04) println (181); else println (999);
2153 acc8= constant 7
2154 acc8And constant 28
2155 acc8Comp constant 4
2156 brne 2522
2157 acc8= constant 181
2158 writeLineAcc8
2159 br 2525
2160 acc16= constant 999
2161 writeLineAcc16
2162 ;testBitwiseOperators.j(309)     if (fb2 | fb1 == 0x1F) println (182); else println (999);
2163 acc8= constant 7
2164 acc8Or constant 28
2165 acc8Comp constant 31
2166 brne 2534
2167 acc8= constant 182
2168 writeLineAcc8
2169 br 2537
2170 acc16= constant 999
2171 writeLineAcc16
2172 ;testBitwiseOperators.j(310)     if (fb2 ^ fb1 == 0x1B) println (183); else println (999);
2173 acc8= constant 7
2174 acc8Xor constant 28
2175 acc8Comp constant 27
2176 brne 2546
2177 acc8= constant 183
2178 writeLineAcc8
2179 br 2550
2180 acc16= constant 999
2181 writeLineAcc16
2182 ;testBitwiseOperators.j(311)     //final var word/final var word
2183 ;testBitwiseOperators.j(312)     if (fw2 & fw1 == 0x0224) println (184); else println (999);
2184 acc16= constant 4660
2185 acc16And constant 812
2186 acc16Comp constant 548
2187 brne 2559
2188 acc8= constant 184
2189 writeLineAcc8
2190 br 2562
2191 acc16= constant 999
2192 writeLineAcc16
2193 ;testBitwiseOperators.j(313)     if (fw2 | fw1 == 0x133C) println (185); else println (999);
2194 acc16= constant 4660
2195 acc16Or constant 812
2196 acc16Comp constant 4924
2197 brne 2571
2198 acc8= constant 185
2199 writeLineAcc8
2200 br 2574
2201 acc16= constant 999
2202 writeLineAcc16
2203 ;testBitwiseOperators.j(314)     if (fw2 ^ fw1 == 0x1118) println (186); else println (999);
2204 acc16= constant 4660
2205 acc16Xor constant 812
2206 acc16Comp constant 4376
2207 brne 2583
2208 acc8= constant 186
2209 writeLineAcc8
2210 br 2587
2211 acc16= constant 999
2212 writeLineAcc16
2213 ;testBitwiseOperators.j(315)     //final var byte/final var word
2214 ;testBitwiseOperators.j(316)     if (fb1 & fw2 == 0x0014) println (187); else println (999);
2215 acc8= constant 28
2216 acc8ToAcc16
2217 acc16And constant 4660
2218 acc8= constant 20
2219 acc16CompareAcc8
2220 brne 2598
2221 acc8= constant 187
2222 writeLineAcc8
2223 br 2601
2224 acc16= constant 999
2225 writeLineAcc16
2226 ;testBitwiseOperators.j(317)     if (fb1 | fw2 == 0x123C) println (188); else println (999);
2227 acc8= constant 28
2228 acc8ToAcc16
2229 acc16Or constant 4660
2230 acc16Comp constant 4668
2231 brne 2611
2232 acc8= constant 188
2233 writeLineAcc8
2234 br 2614
2235 acc16= constant 999
2236 writeLineAcc16
2237 ;testBitwiseOperators.j(318)     if (fb1 ^ fw2 == 0x1228) println (189); else println (999);
2238 acc8= constant 28
2239 acc8ToAcc16
2240 acc16Xor constant 4660
2241 acc16Comp constant 4648
2242 brne 2624
2243 acc8= constant 189
2244 writeLineAcc8
2245 br 2628
2246 acc16= constant 999
2247 writeLineAcc16
2248 ;testBitwiseOperators.j(319)     //final var word/final var byte
2249 ;testBitwiseOperators.j(320)     if (fw2 & fb1 == 0x0014) println (190); else println (999);
2250 acc16= constant 4660
2251 acc16And constant 28
2252 acc8= constant 20
2253 acc16CompareAcc8
2254 brne 2638
2255 acc8= constant 190
2256 writeLineAcc8
2257 br 2641
2258 acc16= constant 999
2259 writeLineAcc16
2260 ;testBitwiseOperators.j(321)     if (fw2 | fb1 == 0x123C) println (191); else println (999);
2261 acc16= constant 4660
2262 acc16Or constant 28
2263 acc16Comp constant 4668
2264 brne 2650
2265 acc8= constant 191
2266 writeLineAcc8
2267 br 2653
2268 acc16= constant 999
2269 writeLineAcc16
2270 ;testBitwiseOperators.j(322)     if (fw2 ^ fb1 == 0x1228) println (192); else println (999);
2271 acc16= constant 4660
2272 acc16Xor constant 28
2273 acc16Comp constant 4648
2274 brne 2662
2275 acc8= constant 192
2276 writeLineAcc8
2277 br 2666
2278 acc16= constant 999
2279 writeLineAcc16
2280 ;testBitwiseOperators.j(323)   
2281 ;testBitwiseOperators.j(324)     println("Klaar");
2282 acc16= stringconstant 2289
2283 writeLineString
2284 ;testBitwiseOperators.j(325)   }
2285 stackPointer= basePointer
2286 basePointer<
2287 return
2288 ;testBitwiseOperators.j(326) }
2289 stringConstant 0 = "Klaar"
