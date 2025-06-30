   0 call 6
   1 stop
   2 ;testFor.j(0) /* Program to test generated Z80 assembler code */
   3 ;testFor.j(1) class TestFor {
   4 class TestFor []
   5 ;testFor.j(2)   private static byte b1 = 1;
   6 acc8= constant 1
   7 acc8=> byte variable 0
   8 ;testFor.j(3)   private static byte b2 = 1;
   9 acc8= constant 1
  10 acc8=> byte variable 1
  11 ;testFor.j(4)   private static word i2 = 1;
  12 acc8= constant 1
  13 acc8=> word variable 2
  14 ;testFor.j(5)   private static word p = 1;
  15 acc8= constant 1
  16 acc8=> word variable 4
  17 br 20
  18 ;testFor.j(6) 
  19 ;testFor.j(7)   public static void main() {
  20 method TestFor.main [public, static] void ()
  21 <basePointer
  22 basePointer= stackPointer
  23 stackPointer+ constant 2
  24 ;testFor.j(8)     println(0);
  25 acc8= constant 0
  26 writeLineAcc8
  27 ;testFor.j(9)   
  28 ;testFor.j(10)     /************************/
  29 ;testFor.j(11)     // global variable within for scope
  30 ;testFor.j(12)     for (byte b = 1; b <= 2; b++) {
  31 acc8= constant 1
  32 acc8=> byte basePointer + 1
  33 acc8= byte basePointer + 1
  34 acc8Comp constant 2
  35 brgt 58
  36 br 39
  37 incr8 byte basePointer + 1
  38 br 33
  39 ;testFor.j(13)       byte c = b1;
  40 acc8= byte variable 0
  41 acc8=> byte basePointer + 2
  42 ;testFor.j(14)       println (c);
  43 acc8= byte basePointer + 2
  44 writeLineAcc8
  45 ;testFor.j(15)       b1++;
  46 incr8 byte variable 0
  47 ;testFor.j(16)     }
  48 br 37
  49 ;testFor.j(17)   
  50 ;testFor.j(18)     /************************/
  51 ;testFor.j(19)     // constant - constant
  52 ;testFor.j(20)     // not relevant
  53 ;testFor.j(21)   
  54 ;testFor.j(22)     /************************/
  55 ;testFor.j(23)     // constant - acc
  56 ;testFor.j(24)     // byte - byte
  57 ;testFor.j(25)     for (byte b = 3; 103 == b+100; b++) { println (b); }
  58 acc8= constant 3
  59 acc8=> byte basePointer + 1
  60 acc8= byte basePointer + 1
  61 acc8+ constant 100
  62 revAcc8Comp constant 103
  63 brne 71
  64 br 67
  65 incr8 byte basePointer + 1
  66 br 60
  67 acc8= byte basePointer + 1
  68 writeLineAcc8
  69 br 65
  70 ;testFor.j(26)     for (byte b = 4; 105 != b+100; b++) { println (b); }
  71 acc8= constant 4
  72 acc8=> byte basePointer + 1
  73 acc8= byte basePointer + 1
  74 acc8+ constant 100
  75 revAcc8Comp constant 105
  76 breq 84
  77 br 80
  78 incr8 byte basePointer + 1
  79 br 73
  80 acc8= byte basePointer + 1
  81 writeLineAcc8
  82 br 78
  83 ;testFor.j(27)     b2=5;
  84 acc8= constant 5
  85 acc8=> byte variable 1
  86 ;testFor.j(28)     for (byte b = 32; 134 > b+100; b++) { println (b2); b2++; }
  87 acc8= constant 32
  88 acc8=> byte basePointer + 1
  89 acc8= byte basePointer + 1
  90 acc8+ constant 100
  91 revAcc8Comp constant 134
  92 brge 101
  93 br 96
  94 incr8 byte basePointer + 1
  95 br 89
  96 acc8= byte variable 1
  97 writeLineAcc8
  98 incr8 byte variable 1
  99 br 94
 100 ;testFor.j(29)     for (byte b = 34; 135 >= b+100; b++) { println (b2); b2++; }
 101 acc8= constant 34
 102 acc8=> byte basePointer + 1
 103 acc8= byte basePointer + 1
 104 acc8+ constant 100
 105 revAcc8Comp constant 135
 106 brgt 115
 107 br 110
 108 incr8 byte basePointer + 1
 109 br 103
 110 acc8= byte variable 1
 111 writeLineAcc8
 112 incr8 byte variable 1
 113 br 108
 114 ;testFor.j(30)     for (byte b = 28; 126 <  b+100; b--) { println (b2); b2++; }
 115 acc8= constant 28
 116 acc8=> byte basePointer + 1
 117 acc8= byte basePointer + 1
 118 acc8+ constant 100
 119 revAcc8Comp constant 126
 120 brle 129
 121 br 124
 122 decr8 byte basePointer + 1
 123 br 117
 124 acc8= byte variable 1
 125 writeLineAcc8
 126 incr8 byte variable 1
 127 br 122
 128 ;testFor.j(31)     for (byte b = 26; 125 <= b+100; b--) { println (b2); b2++; }
 129 acc8= constant 26
 130 acc8=> byte basePointer + 1
 131 acc8= byte basePointer + 1
 132 acc8+ constant 100
 133 revAcc8Comp constant 125
 134 brlt 144
 135 br 138
 136 decr8 byte basePointer + 1
 137 br 131
 138 acc8= byte variable 1
 139 writeLineAcc8
 140 incr8 byte variable 1
 141 br 136
 142 ;testFor.j(32)     // byte - integer
 143 ;testFor.j(33)     for(word i = 24; 24  == i+0; i--) { println (b2); b2++; }
 144 acc8= constant 24
 145 acc8=> word basePointer + 2
 146 acc16= word basePointer + 2
 147 acc16+ constant 0
 148 acc8= constant 24
 149 acc8CompareAcc16
 150 brne 159
 151 br 154
 152 decr16 word basePointer + 2
 153 br 146
 154 acc8= byte variable 1
 155 writeLineAcc8
 156 incr8 byte variable 1
 157 br 152
 158 ;testFor.j(34)     for(word i = 23; 120 != i+100; i--) { println (b2); b2++; }
 159 acc8= constant 23
 160 acc8=> word basePointer + 2
 161 acc16= word basePointer + 2
 162 acc16+ constant 100
 163 acc8= constant 120
 164 acc8CompareAcc16
 165 breq 174
 166 br 169
 167 decr16 word basePointer + 2
 168 br 161
 169 acc8= byte variable 1
 170 writeLineAcc8
 171 incr8 byte variable 1
 172 br 167
 173 ;testFor.j(35)     for(word i = 20; 122 > i+100; i++) { println (b2); b2++; }
 174 acc8= constant 20
 175 acc8=> word basePointer + 2
 176 acc16= word basePointer + 2
 177 acc16+ constant 100
 178 acc8= constant 122
 179 acc8CompareAcc16
 180 brle 189
 181 br 184
 182 incr16 word basePointer + 2
 183 br 176
 184 acc8= byte variable 1
 185 writeLineAcc8
 186 incr8 byte variable 1
 187 br 182
 188 ;testFor.j(36)     for(word i = 22; 123 >= i+100; i++) { println (b2); b2++; }
 189 acc8= constant 22
 190 acc8=> word basePointer + 2
 191 acc16= word basePointer + 2
 192 acc16+ constant 100
 193 acc8= constant 123
 194 acc8CompareAcc16
 195 brlt 204
 196 br 199
 197 incr16 word basePointer + 2
 198 br 191
 199 acc8= byte variable 1
 200 writeLineAcc8
 201 incr8 byte variable 1
 202 br 197
 203 ;testFor.j(37)     for(word i = 16; 114 <  i+100; i--) { println (b2); b2++; }
 204 acc8= constant 16
 205 acc8=> word basePointer + 2
 206 acc16= word basePointer + 2
 207 acc16+ constant 100
 208 acc8= constant 114
 209 acc8CompareAcc16
 210 brge 219
 211 br 214
 212 decr16 word basePointer + 2
 213 br 206
 214 acc8= byte variable 1
 215 writeLineAcc8
 216 incr8 byte variable 1
 217 br 212
 218 ;testFor.j(38)     for(word i = 14; 113 <= i+100; i--) { println (b2); b2++; }
 219 acc8= constant 14
 220 acc8=> word basePointer + 2
 221 acc16= word basePointer + 2
 222 acc16+ constant 100
 223 acc8= constant 113
 224 acc8CompareAcc16
 225 brgt 237
 226 br 229
 227 decr16 word basePointer + 2
 228 br 221
 229 acc8= byte variable 1
 230 writeLineAcc8
 231 incr8 byte variable 1
 232 br 227
 233 ;testFor.j(39)     // integer - byte
 234 ;testFor.j(40)     // not relevant
 235 ;testFor.j(41)     // integer - integer
 236 ;testFor.j(42)     for(word i = 12; 1012 == i+1000; i--) { println (b2); b2++; }
 237 acc8= constant 12
 238 acc8=> word basePointer + 2
 239 acc16= word basePointer + 2
 240 acc16+ constant 1000
 241 revAcc16Comp constant 1012
 242 brne 251
 243 br 246
 244 decr16 word basePointer + 2
 245 br 239
 246 acc8= byte variable 1
 247 writeLineAcc8
 248 incr8 byte variable 1
 249 br 244
 250 ;testFor.j(43)     for(word i = 11; 1008 != i+1000; i--) { println (b2); b2++; }
 251 acc8= constant 11
 252 acc8=> word basePointer + 2
 253 acc16= word basePointer + 2
 254 acc16+ constant 1000
 255 revAcc16Comp constant 1008
 256 breq 265
 257 br 260
 258 decr16 word basePointer + 2
 259 br 253
 260 acc8= byte variable 1
 261 writeLineAcc8
 262 incr8 byte variable 1
 263 br 258
 264 ;testFor.j(44)     for(word i = 8; 1010 > i+1000; i++) { println (b2); b2++; }
 265 acc8= constant 8
 266 acc8=> word basePointer + 2
 267 acc16= word basePointer + 2
 268 acc16+ constant 1000
 269 revAcc16Comp constant 1010
 270 brge 279
 271 br 274
 272 incr16 word basePointer + 2
 273 br 267
 274 acc8= byte variable 1
 275 writeLineAcc8
 276 incr8 byte variable 1
 277 br 272
 278 ;testFor.j(45)     for(word i = 10; 1011 >= i+1000; i++) { println (b2); b2++; }
 279 acc8= constant 10
 280 acc8=> word basePointer + 2
 281 acc16= word basePointer + 2
 282 acc16+ constant 1000
 283 revAcc16Comp constant 1011
 284 brgt 293
 285 br 288
 286 incr16 word basePointer + 2
 287 br 281
 288 acc8= byte variable 1
 289 writeLineAcc8
 290 incr8 byte variable 1
 291 br 286
 292 ;testFor.j(46)     for(word i = 4; 1002 <  i+1000; i--) { println (b2); b2++; }
 293 acc8= constant 4
 294 acc8=> word basePointer + 2
 295 acc16= word basePointer + 2
 296 acc16+ constant 1000
 297 revAcc16Comp constant 1002
 298 brle 307
 299 br 302
 300 decr16 word basePointer + 2
 301 br 295
 302 acc8= byte variable 1
 303 writeLineAcc8
 304 incr8 byte variable 1
 305 br 300
 306 ;testFor.j(47)     for(word i = 2; 1001 <= i+1000; i--) { println (b2); b2++; }
 307 acc8= constant 2
 308 acc8=> word basePointer + 2
 309 acc16= word basePointer + 2
 310 acc16+ constant 1000
 311 revAcc16Comp constant 1001
 312 brlt 325
 313 br 316
 314 decr16 word basePointer + 2
 315 br 309
 316 acc8= byte variable 1
 317 writeLineAcc8
 318 incr8 byte variable 1
 319 br 314
 320 ;testFor.j(48)   
 321 ;testFor.j(49)     /************************/
 322 ;testFor.j(50)     // constant - var
 323 ;testFor.j(51)     // byte - byte
 324 ;testFor.j(52)     for (byte b = 42; 41 <= b; b--) { println (b2); b2++; }
 325 acc8= constant 42
 326 acc8=> byte basePointer + 1
 327 acc8= byte basePointer + 1
 328 revAcc8Comp constant 41
 329 brlt 339
 330 br 333
 331 decr8 byte basePointer + 1
 332 br 327
 333 acc8= byte variable 1
 334 writeLineAcc8
 335 incr8 byte variable 1
 336 br 331
 337 ;testFor.j(53)     // byte - integer
 338 ;testFor.j(54)     for(word i = 40; 39 <= i; i--) { println (b2); b2++; }
 339 acc8= constant 40
 340 acc8=> word basePointer + 2
 341 acc16= word basePointer + 2
 342 acc8= constant 39
 343 acc8CompareAcc16
 344 brgt 356
 345 br 348
 346 decr16 word basePointer + 2
 347 br 341
 348 acc8= byte variable 1
 349 writeLineAcc8
 350 incr8 byte variable 1
 351 br 346
 352 ;testFor.j(55)     // integer - byte
 353 ;testFor.j(56)     // not relevant
 354 ;testFor.j(57)     // integer - integer
 355 ;testFor.j(58)     for(word i = 1038; 1037 <= i; i--) { println (b2); b2++; }
 356 acc16= constant 1038
 357 acc16=> word basePointer + 2
 358 acc16= word basePointer + 2
 359 revAcc16Comp constant 1037
 360 brlt 374
 361 br 364
 362 decr16 word basePointer + 2
 363 br 358
 364 acc8= byte variable 1
 365 writeLineAcc8
 366 incr8 byte variable 1
 367 br 362
 368 ;testFor.j(59)   
 369 ;testFor.j(60)     /************************/
 370 ;testFor.j(61)     // constant - stack8
 371 ;testFor.j(62)     // byte - byte
 372 ;testFor.j(63)     //TODO
 373 ;testFor.j(64)     println(43);
 374 acc8= constant 43
 375 writeLineAcc8
 376 ;testFor.j(65)     println(44);
 377 acc8= constant 44
 378 writeLineAcc8
 379 ;testFor.j(66)     // constant - stack8
 380 ;testFor.j(67)     // byte - integer
 381 ;testFor.j(68)     //TODO
 382 ;testFor.j(69)     println(45);
 383 acc8= constant 45
 384 writeLineAcc8
 385 ;testFor.j(70)     println(46);
 386 acc8= constant 46
 387 writeLineAcc8
 388 ;testFor.j(71)     // constant - stack8
 389 ;testFor.j(72)     // integer - byte
 390 ;testFor.j(73)     //TODO
 391 ;testFor.j(74)     println(47);
 392 acc8= constant 47
 393 writeLineAcc8
 394 ;testFor.j(75)     println(48);
 395 acc8= constant 48
 396 writeLineAcc8
 397 ;testFor.j(76)     // constant - stack88
 398 ;testFor.j(77)     // integer - integer
 399 ;testFor.j(78)     //TODO
 400 ;testFor.j(79)     println(49);
 401 acc8= constant 49
 402 writeLineAcc8
 403 ;testFor.j(80)     println(50);
 404 acc8= constant 50
 405 writeLineAcc8
 406 ;testFor.j(81)   
 407 ;testFor.j(82)     /************************/
 408 ;testFor.j(83)     // constant - stack16
 409 ;testFor.j(84)     // byte - byte
 410 ;testFor.j(85)     //TODO
 411 ;testFor.j(86)     println(51);
 412 acc8= constant 51
 413 writeLineAcc8
 414 ;testFor.j(87)     println(52);
 415 acc8= constant 52
 416 writeLineAcc8
 417 ;testFor.j(88)     // constant - stack16
 418 ;testFor.j(89)     // byte - integer
 419 ;testFor.j(90)     //TODO
 420 ;testFor.j(91)     println(53);
 421 acc8= constant 53
 422 writeLineAcc8
 423 ;testFor.j(92)     println(54);
 424 acc8= constant 54
 425 writeLineAcc8
 426 ;testFor.j(93)     // constant - stack16
 427 ;testFor.j(94)     // integer - byte
 428 ;testFor.j(95)     //TODO
 429 ;testFor.j(96)     println(55);
 430 acc8= constant 55
 431 writeLineAcc8
 432 ;testFor.j(97)     println(56);
 433 acc8= constant 56
 434 writeLineAcc8
 435 ;testFor.j(98)     // constant - stack16
 436 ;testFor.j(99)     // integer - integer
 437 ;testFor.j(100)     //TODO
 438 ;testFor.j(101)     println(57);
 439 acc8= constant 57
 440 writeLineAcc8
 441 ;testFor.j(102)     println(58);
 442 acc8= constant 58
 443 writeLineAcc8
 444 ;testFor.j(103)   
 445 ;testFor.j(104)     /************************/
 446 ;testFor.j(105)     // acc - constant
 447 ;testFor.j(106)     // byte - byte
 448 ;testFor.j(107)     b2 = 59;
 449 acc8= constant 59
 450 acc8=> byte variable 1
 451 ;testFor.j(108)     for (byte b = 56; b+0 <= 57; b++) { println (b2); b2++; }
 452 acc8= constant 56
 453 acc8=> byte basePointer + 1
 454 acc8= byte basePointer + 1
 455 acc8+ constant 0
 456 acc8Comp constant 57
 457 brgt 469
 458 br 461
 459 incr8 byte basePointer + 1
 460 br 454
 461 acc8= byte variable 1
 462 writeLineAcc8
 463 incr8 byte variable 1
 464 br 459
 465 ;testFor.j(109)     // byte - integer
 466 ;testFor.j(110)     //not relevant
 467 ;testFor.j(111)     // integer - byte
 468 ;testFor.j(112)     for (word i = 54; i+0 <= 55; i++) { println (b2); b2++;}
 469 acc8= constant 54
 470 acc8=> word basePointer + 2
 471 acc16= word basePointer + 2
 472 acc16+ constant 0
 473 acc8= constant 55
 474 acc16CompareAcc8
 475 brgt 485
 476 br 479
 477 incr16 word basePointer + 2
 478 br 471
 479 acc8= byte variable 1
 480 writeLineAcc8
 481 incr8 byte variable 1
 482 br 477
 483 ;testFor.j(113)     // integer - integer
 484 ;testFor.j(114)     for(word i = 1052; i+0 <= 1053; i++) { println (b2); b2++; }
 485 acc16= constant 1052
 486 acc16=> word basePointer + 2
 487 acc16= word basePointer + 2
 488 acc16+ constant 0
 489 acc16Comp constant 1053
 490 brgt 503
 491 br 494
 492 incr16 word basePointer + 2
 493 br 487
 494 acc8= byte variable 1
 495 writeLineAcc8
 496 incr8 byte variable 1
 497 br 492
 498 ;testFor.j(115)   
 499 ;testFor.j(116)     /************************/
 500 ;testFor.j(117)     // acc - acc
 501 ;testFor.j(118)     // byte - byte
 502 ;testFor.j(119)     for (byte b = 64; 63+0 <= b+0; b--) { println (b2); b2++; }
 503 acc8= constant 64
 504 acc8=> byte basePointer + 1
 505 acc8= constant 63
 506 acc8+ constant 0
 507 <acc8
 508 acc8= byte basePointer + 1
 509 acc8+ constant 0
 510 revAcc8Comp unstack8
 511 brlt 521
 512 br 515
 513 decr8 byte basePointer + 1
 514 br 505
 515 acc8= byte variable 1
 516 writeLineAcc8
 517 incr8 byte variable 1
 518 br 513
 519 ;testFor.j(120)     // byte - integer
 520 ;testFor.j(121)     for(word i = 62; 61+0 <= i+0; i--) { println (b2); b2++; }
 521 acc8= constant 62
 522 acc8=> word basePointer + 2
 523 acc8= constant 61
 524 acc8+ constant 0
 525 <acc8
 526 acc16= word basePointer + 2
 527 acc16+ constant 0
 528 acc8<
 529 acc8CompareAcc16
 530 brgt 540
 531 br 534
 532 decr16 word basePointer + 2
 533 br 523
 534 acc8= byte variable 1
 535 writeLineAcc8
 536 incr8 byte variable 1
 537 br 532
 538 ;testFor.j(122)     // integer - byte
 539 ;testFor.j(123)     i2=59;
 540 acc8= constant 59
 541 acc8=> word variable 2
 542 ;testFor.j(124)     for (byte b = 60; i2+0 <= b+0; b--) { println (b2); b2++; }
 543 acc8= constant 60
 544 acc8=> byte basePointer + 1
 545 acc16= word variable 2
 546 acc16+ constant 0
 547 <acc16
 548 acc8= byte basePointer + 1
 549 acc8+ constant 0
 550 acc16<
 551 acc16CompareAcc8
 552 brgt 562
 553 br 556
 554 decr8 byte basePointer + 1
 555 br 545
 556 acc8= byte variable 1
 557 writeLineAcc8
 558 incr8 byte variable 1
 559 br 554
 560 ;testFor.j(125)     // integer - integer
 561 ;testFor.j(126)     for(word i = 1058; 1000+57 <= i+0; i--) { println (b2); b2++; }
 562 acc16= constant 1058
 563 acc16=> word basePointer + 2
 564 acc16= constant 1000
 565 acc16+ constant 57
 566 <acc16
 567 acc16= word basePointer + 2
 568 acc16+ constant 0
 569 revAcc16Comp unstack16
 570 brlt 583
 571 br 574
 572 decr16 word basePointer + 2
 573 br 564
 574 acc8= byte variable 1
 575 writeLineAcc8
 576 incr8 byte variable 1
 577 br 572
 578 ;testFor.j(127)   
 579 ;testFor.j(128)     /************************/
 580 ;testFor.j(129)     // acc - var
 581 ;testFor.j(130)     // byte - byte
 582 ;testFor.j(131)     for (byte b = 72; 71+0 <= b; b--) { println (b2); b2++; }
 583 acc8= constant 72
 584 acc8=> byte basePointer + 1
 585 acc8= constant 71
 586 acc8+ constant 0
 587 acc8Comp byte basePointer + 1
 588 brgt 598
 589 br 592
 590 decr8 byte basePointer + 1
 591 br 585
 592 acc8= byte variable 1
 593 writeLineAcc8
 594 incr8 byte variable 1
 595 br 590
 596 ;testFor.j(132)     // byte - integer
 597 ;testFor.j(133)     for(word i = 70; 69+0 <= i; i--) { println (b2); b2++; }
 598 acc8= constant 70
 599 acc8=> word basePointer + 2
 600 acc8= constant 69
 601 acc8+ constant 0
 602 acc16= word basePointer + 2
 603 acc8CompareAcc16
 604 brgt 614
 605 br 608
 606 decr16 word basePointer + 2
 607 br 600
 608 acc8= byte variable 1
 609 writeLineAcc8
 610 incr8 byte variable 1
 611 br 606
 612 ;testFor.j(134)     // integer - byte
 613 ;testFor.j(135)     i2=67;
 614 acc8= constant 67
 615 acc8=> word variable 2
 616 ;testFor.j(136)     for (byte b = 68; i2+0 <= b; b--) { println (b2); b2++; }
 617 acc8= constant 68
 618 acc8=> byte basePointer + 1
 619 acc16= word variable 2
 620 acc16+ constant 0
 621 acc8= byte basePointer + 1
 622 acc16CompareAcc8
 623 brgt 633
 624 br 627
 625 decr8 byte basePointer + 1
 626 br 619
 627 acc8= byte variable 1
 628 writeLineAcc8
 629 incr8 byte variable 1
 630 br 625
 631 ;testFor.j(137)     // integer - integer
 632 ;testFor.j(138)     for(word i = 1066; 1000+65 <= i; i--) { println (b2); b2++; }
 633 acc16= constant 1066
 634 acc16=> word basePointer + 2
 635 acc16= constant 1000
 636 acc16+ constant 65
 637 acc16Comp word basePointer + 2
 638 brgt 652
 639 br 642
 640 decr16 word basePointer + 2
 641 br 635
 642 acc8= byte variable 1
 643 writeLineAcc8
 644 incr8 byte variable 1
 645 br 640
 646 ;testFor.j(139)   
 647 ;testFor.j(140)     /************************/
 648 ;testFor.j(141)     // acc - stack8
 649 ;testFor.j(142)     // byte - byte
 650 ;testFor.j(143)     //TODO
 651 ;testFor.j(144)     println(81);
 652 acc8= constant 81
 653 writeLineAcc8
 654 ;testFor.j(145)     println(82);
 655 acc8= constant 82
 656 writeLineAcc8
 657 ;testFor.j(146)     // byte - integer
 658 ;testFor.j(147)     //TODO
 659 ;testFor.j(148)     println(83);
 660 acc8= constant 83
 661 writeLineAcc8
 662 ;testFor.j(149)     println(84);
 663 acc8= constant 84
 664 writeLineAcc8
 665 ;testFor.j(150)     // integer - byte
 666 ;testFor.j(151)     //TODO
 667 ;testFor.j(152)     println(85);
 668 acc8= constant 85
 669 writeLineAcc8
 670 ;testFor.j(153)     println(86);
 671 acc8= constant 86
 672 writeLineAcc8
 673 ;testFor.j(154)     // integer - integer
 674 ;testFor.j(155)     //TODO
 675 ;testFor.j(156)     println(87);
 676 acc8= constant 87
 677 writeLineAcc8
 678 ;testFor.j(157)     println(88);
 679 acc8= constant 88
 680 writeLineAcc8
 681 ;testFor.j(158)   
 682 ;testFor.j(159)     /************************/
 683 ;testFor.j(160)     // acc - stack16
 684 ;testFor.j(161)     // byte - byte
 685 ;testFor.j(162)     //TODO
 686 ;testFor.j(163)     println(89);
 687 acc8= constant 89
 688 writeLineAcc8
 689 ;testFor.j(164)     println(90);
 690 acc8= constant 90
 691 writeLineAcc8
 692 ;testFor.j(165)     // byte - integer
 693 ;testFor.j(166)     //TODO
 694 ;testFor.j(167)     println(91);
 695 acc8= constant 91
 696 writeLineAcc8
 697 ;testFor.j(168)     println(92);
 698 acc8= constant 92
 699 writeLineAcc8
 700 ;testFor.j(169)     // integer - byte
 701 ;testFor.j(170)     //TODO
 702 ;testFor.j(171)     println(93);
 703 acc8= constant 93
 704 writeLineAcc8
 705 ;testFor.j(172)     println(94);
 706 acc8= constant 94
 707 writeLineAcc8
 708 ;testFor.j(173)     // integer - integer
 709 ;testFor.j(174)     //TODO
 710 ;testFor.j(175)     println(95);
 711 acc8= constant 95
 712 writeLineAcc8
 713 ;testFor.j(176)     println(96);
 714 acc8= constant 96
 715 writeLineAcc8
 716 ;testFor.j(177)   
 717 ;testFor.j(178)     /************************/
 718 ;testFor.j(179)     // var - constant
 719 ;testFor.j(180)     // byte - byte
 720 ;testFor.j(181)     b2=97;
 721 acc8= constant 97
 722 acc8=> byte variable 1
 723 ;testFor.j(182)     for (byte b = 96; b <= 97; b++) { println (b2); b2++; }
 724 acc8= constant 96
 725 acc8=> byte basePointer + 1
 726 acc8= byte basePointer + 1
 727 acc8Comp constant 97
 728 brgt 740
 729 br 732
 730 incr8 byte basePointer + 1
 731 br 726
 732 acc8= byte variable 1
 733 writeLineAcc8
 734 incr8 byte variable 1
 735 br 730
 736 ;testFor.j(183)     // byte - integer
 737 ;testFor.j(184)     //not relevant
 738 ;testFor.j(185)     // integer - byte
 739 ;testFor.j(186)     for(word i = 92; i <= 93; i++) { println (b2); b2++; }
 740 acc8= constant 92
 741 acc8=> word basePointer + 2
 742 acc16= word basePointer + 2
 743 acc8= constant 93
 744 acc16CompareAcc8
 745 brgt 755
 746 br 749
 747 incr16 word basePointer + 2
 748 br 742
 749 acc8= byte variable 1
 750 writeLineAcc8
 751 incr8 byte variable 1
 752 br 747
 753 ;testFor.j(187)     // integer - integer
 754 ;testFor.j(188)     for(word i = 1090; i <= 1091; i++) { println (b2); b2++; }
 755 acc16= constant 1090
 756 acc16=> word basePointer + 2
 757 acc16= word basePointer + 2
 758 acc16Comp constant 1091
 759 brgt 772
 760 br 763
 761 incr16 word basePointer + 2
 762 br 757
 763 acc8= byte variable 1
 764 writeLineAcc8
 765 incr8 byte variable 1
 766 br 761
 767 ;testFor.j(189)   
 768 ;testFor.j(190)     /************************/
 769 ;testFor.j(191)     // var - acc
 770 ;testFor.j(192)     // byte - byte
 771 ;testFor.j(193)     for (byte b = 104; b <= 105+0; b++) { println (b2); b2++; }
 772 acc8= constant 104
 773 acc8=> byte basePointer + 1
 774 acc8= constant 105
 775 acc8+ constant 0
 776 revAcc8Comp byte basePointer + 1
 777 brlt 787
 778 br 781
 779 incr8 byte basePointer + 1
 780 br 774
 781 acc8= byte variable 1
 782 writeLineAcc8
 783 incr8 byte variable 1
 784 br 779
 785 ;testFor.j(194)     // byte - integer
 786 ;testFor.j(195)     i2=103;
 787 acc8= constant 103
 788 acc8=> word variable 2
 789 ;testFor.j(196)     for (byte b = 102; b <= i2+0; b++) { println (b2); b2++; }
 790 acc8= constant 102
 791 acc8=> byte basePointer + 1
 792 acc16= word variable 2
 793 acc16+ constant 0
 794 acc8= byte basePointer + 1
 795 acc8CompareAcc16
 796 brgt 806
 797 br 800
 798 incr8 byte basePointer + 1
 799 br 792
 800 acc8= byte variable 1
 801 writeLineAcc8
 802 incr8 byte variable 1
 803 br 798
 804 ;testFor.j(197)     // integer - byte
 805 ;testFor.j(198)     for(word i = 100; i <= 101+0; i++) { println (b2); b2++; }
 806 acc8= constant 100
 807 acc8=> word basePointer + 2
 808 acc8= constant 101
 809 acc8+ constant 0
 810 acc16= word basePointer + 2
 811 acc16CompareAcc8
 812 brgt 822
 813 br 816
 814 incr16 word basePointer + 2
 815 br 808
 816 acc8= byte variable 1
 817 writeLineAcc8
 818 incr8 byte variable 1
 819 br 814
 820 ;testFor.j(199)     // integer - integer
 821 ;testFor.j(200)     for(word i = 1098; i <= 1099+0; i++) { println (b2); b2++; }
 822 acc16= constant 1098
 823 acc16=> word basePointer + 2
 824 acc16= constant 1099
 825 acc16+ constant 0
 826 revAcc16Comp word basePointer + 2
 827 brlt 840
 828 br 831
 829 incr16 word basePointer + 2
 830 br 824
 831 acc8= byte variable 1
 832 writeLineAcc8
 833 incr8 byte variable 1
 834 br 829
 835 ;testFor.j(201)   
 836 ;testFor.j(202)     /************************/
 837 ;testFor.j(203)     // var - var
 838 ;testFor.j(204)     // byte - byte
 839 ;testFor.j(205)     for (byte b = 112; b2 <= b; b--) { println (b2); b2++; }
 840 acc8= constant 112
 841 acc8=> byte basePointer + 1
 842 acc8= byte variable 1
 843 acc8Comp byte basePointer + 1
 844 brgt 854
 845 br 848
 846 decr8 byte basePointer + 1
 847 br 842
 848 acc8= byte variable 1
 849 writeLineAcc8
 850 incr8 byte variable 1
 851 br 846
 852 ;testFor.j(206)     // byte - integer
 853 ;testFor.j(207)     for(word i = 116; b2 <= i; i--) { println (b2); b2++; }
 854 acc8= constant 116
 855 acc8=> word basePointer + 2
 856 acc8= byte variable 1
 857 acc16= word basePointer + 2
 858 acc8CompareAcc16
 859 brgt 869
 860 br 863
 861 decr16 word basePointer + 2
 862 br 856
 863 acc8= byte variable 1
 864 writeLineAcc8
 865 incr8 byte variable 1
 866 br 861
 867 ;testFor.j(208)     // integer - byte
 868 ;testFor.j(209)     i2=b2;
 869 acc8= byte variable 1
 870 acc8=> word variable 2
 871 ;testFor.j(210)     for (byte b = 118; i2 <= b; b--) { println (b2); b2++; }
 872 acc8= constant 118
 873 acc8=> byte basePointer + 1
 874 acc16= word variable 2
 875 acc8= byte basePointer + 1
 876 acc16CompareAcc8
 877 brgt 887
 878 br 881
 879 decr8 byte basePointer + 1
 880 br 874
 881 acc8= byte variable 1
 882 writeLineAcc8
 883 incr8 byte variable 1
 884 br 879
 885 ;testFor.j(211)     // integer - integer
 886 ;testFor.j(212)     i2=120;
 887 acc8= constant 120
 888 acc8=> word variable 2
 889 ;testFor.j(213)     for(word i = b2+4; i2 <= i; i--) { println (b2); b2++; }
 890 acc8= byte variable 1
 891 acc8+ constant 4
 892 acc8=> word basePointer + 2
 893 acc16= word variable 2
 894 acc16Comp word basePointer + 2
 895 brgt 937
 896 br 899
 897 decr16 word basePointer + 2
 898 br 893
 899 acc8= byte variable 1
 900 writeLineAcc8
 901 incr8 byte variable 1
 902 br 897
 903 ;testFor.j(214)   
 904 ;testFor.j(215)     /************************/
 905 ;testFor.j(216)     // var - stack8
 906 ;testFor.j(217)     // byte - byte
 907 ;testFor.j(218)     // byte - integer
 908 ;testFor.j(219)     // integer - byte
 909 ;testFor.j(220)     // integer - integer
 910 ;testFor.j(221)     //TODO
 911 ;testFor.j(222)   
 912 ;testFor.j(223)     /************************/
 913 ;testFor.j(224)     // var - stack16
 914 ;testFor.j(225)     // byte - byte
 915 ;testFor.j(226)     // byte - integer
 916 ;testFor.j(227)     // integer - byte
 917 ;testFor.j(228)     // integer - integer
 918 ;testFor.j(229)     //TODO
 919 ;testFor.j(230)   
 920 ;testFor.j(231)     /************************/
 921 ;testFor.j(232)     // stack8 - constant
 922 ;testFor.j(233)     // stack8 - acc
 923 ;testFor.j(234)     // stack8 - var
 924 ;testFor.j(235)     // stack8 - stack8
 925 ;testFor.j(236)     // stack8 - stack16
 926 ;testFor.j(237)     //TODO
 927 ;testFor.j(238)   
 928 ;testFor.j(239)     /************************/
 929 ;testFor.j(240)     // stack16 - constant
 930 ;testFor.j(241)     // stack16 - acc
 931 ;testFor.j(242)     // stack16 - var
 932 ;testFor.j(243)     // stack16 - stack8
 933 ;testFor.j(244)     // stack16 - stack16
 934 ;testFor.j(245)     //TODO
 935 ;testFor.j(246)   
 936 ;testFor.j(247)     println("Klaar.");
 937 acc16= stringconstant 944
 938 writeLineString
 939 ;testFor.j(248)   }
 940 stackPointer= basePointer
 941 basePointer<
 942 return
 943 ;testFor.j(249) }
 944 stringConstant 0 = "Klaar."
