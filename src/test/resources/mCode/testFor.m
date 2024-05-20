   0 call 19
   1 stop
   2 ;testFor.j(0) /* Program to test generated Z80 assembler code */
   3 ;testFor.j(1) class TestFor {
   4 class TestFor []
   5 ;testFor.j(2)   private static byte b1 = 1;
   6 acc8= constant 1
   7 acc8=> variable 0
   8 ;testFor.j(3)   private static byte b2 = 1;
   9 acc8= constant 1
  10 acc8=> variable 1
  11 ;testFor.j(4)   private static word i2 = 1;
  12 acc8= constant 1
  13 acc8=> variable 2
  14 ;testFor.j(5)   private static word p = 1;
  15 acc8= constant 1
  16 acc8=> variable 4
  17 ;testFor.j(6) 
  18 ;testFor.j(7)   public static void main() {
  19 method main [public, static] void ()
  20 <basePointer
  21 basePointer= stackPointer
  22 stackPointer+ constant 2
  23 ;testFor.j(8)     println(0);
  24 acc8= constant 0
  25 writeLineAcc8
  26 ;testFor.j(9)   
  27 ;testFor.j(10)     /************************/
  28 ;testFor.j(11)     // global variable within for scope
  29 ;testFor.j(12)     for (byte b = 1; b <= 2; b++) {
  30 acc8= constant 1
  31 acc8=> (basePointer + -1)
  32 acc8= (basePointer + -1)
  33 acc8Comp constant 2
  34 brgt 57
  35 br 38
  36 incr8 (basePointer + -1)
  37 br 32
  38 ;testFor.j(13)       byte c = b1;
  39 acc8= variable 0
  40 acc8=> (basePointer + -2)
  41 ;testFor.j(14)       println (c);
  42 acc8= (basePointer + -2)
  43 writeLineAcc8
  44 ;testFor.j(15)       b1++;
  45 incr8 variable 0
  46 ;testFor.j(16)     }
  47 br 36
  48 ;testFor.j(17)   
  49 ;testFor.j(18)     /************************/
  50 ;testFor.j(19)     // constant - constant
  51 ;testFor.j(20)     // not relevant
  52 ;testFor.j(21)   
  53 ;testFor.j(22)     /************************/
  54 ;testFor.j(23)     // constant - acc
  55 ;testFor.j(24)     // byte - byte
  56 ;testFor.j(25)     for (byte b = 3; 103 == b+100; b++) { println (b); }
  57 acc8= constant 3
  58 acc8=> (basePointer + -1)
  59 acc8= (basePointer + -1)
  60 acc8+ constant 100
  61 acc8Comp constant 103
  62 brne 70
  63 br 66
  64 incr8 (basePointer + -1)
  65 br 59
  66 acc8= (basePointer + -1)
  67 writeLineAcc8
  68 br 64
  69 ;testFor.j(26)     for (byte b = 4; 105 != b+100; b++) { println (b); }
  70 acc8= constant 4
  71 acc8=> (basePointer + -1)
  72 acc8= (basePointer + -1)
  73 acc8+ constant 100
  74 acc8Comp constant 105
  75 breq 83
  76 br 79
  77 incr8 (basePointer + -1)
  78 br 72
  79 acc8= (basePointer + -1)
  80 writeLineAcc8
  81 br 77
  82 ;testFor.j(27)     b2=5;
  83 acc8= constant 5
  84 acc8=> variable 1
  85 ;testFor.j(28)     for (byte b = 32; 134 > b+100; b++) { println (b2); b2++; }
  86 acc8= constant 32
  87 acc8=> (basePointer + -1)
  88 acc8= (basePointer + -1)
  89 acc8+ constant 100
  90 acc8Comp constant 134
  91 brge 100
  92 br 95
  93 incr8 (basePointer + -1)
  94 br 88
  95 acc8= variable 1
  96 writeLineAcc8
  97 incr8 variable 1
  98 br 93
  99 ;testFor.j(29)     for (byte b = 34; 135 >= b+100; b++) { println (b2); b2++; }
 100 acc8= constant 34
 101 acc8=> (basePointer + -1)
 102 acc8= (basePointer + -1)
 103 acc8+ constant 100
 104 acc8Comp constant 135
 105 brgt 114
 106 br 109
 107 incr8 (basePointer + -1)
 108 br 102
 109 acc8= variable 1
 110 writeLineAcc8
 111 incr8 variable 1
 112 br 107
 113 ;testFor.j(30)     for (byte b = 28; 126 <  b+100; b--) { println (b2); b2++; }
 114 acc8= constant 28
 115 acc8=> (basePointer + -1)
 116 acc8= (basePointer + -1)
 117 acc8+ constant 100
 118 acc8Comp constant 126
 119 brle 128
 120 br 123
 121 decr8 (basePointer + -1)
 122 br 116
 123 acc8= variable 1
 124 writeLineAcc8
 125 incr8 variable 1
 126 br 121
 127 ;testFor.j(31)     for (byte b = 26; 125 <= b+100; b--) { println (b2); b2++; }
 128 acc8= constant 26
 129 acc8=> (basePointer + -1)
 130 acc8= (basePointer + -1)
 131 acc8+ constant 100
 132 acc8Comp constant 125
 133 brlt 143
 134 br 137
 135 decr8 (basePointer + -1)
 136 br 130
 137 acc8= variable 1
 138 writeLineAcc8
 139 incr8 variable 1
 140 br 135
 141 ;testFor.j(32)     // byte - integer
 142 ;testFor.j(33)     for(word i = 24; 24  == i+0; i--) { println (b2); b2++; }
 143 acc8= constant 24
 144 acc8=> (basePointer + -2)
 145 acc16= (basePointer + -2)
 146 acc16+ constant 0
 147 acc8= constant 24
 148 acc8CompareAcc16
 149 brne 158
 150 br 153
 151 decr16 (basePointer + -2)
 152 br 145
 153 acc8= variable 1
 154 writeLineAcc8
 155 incr8 variable 1
 156 br 151
 157 ;testFor.j(34)     for(word i = 23; 120 != i+100; i--) { println (b2); b2++; }
 158 acc8= constant 23
 159 acc8=> (basePointer + -2)
 160 acc16= (basePointer + -2)
 161 acc16+ constant 100
 162 acc8= constant 120
 163 acc8CompareAcc16
 164 breq 173
 165 br 168
 166 decr16 (basePointer + -2)
 167 br 160
 168 acc8= variable 1
 169 writeLineAcc8
 170 incr8 variable 1
 171 br 166
 172 ;testFor.j(35)     for(word i = 20; 122 > i+100; i++) { println (b2); b2++; }
 173 acc8= constant 20
 174 acc8=> (basePointer + -2)
 175 acc16= (basePointer + -2)
 176 acc16+ constant 100
 177 acc8= constant 122
 178 acc8CompareAcc16
 179 brle 188
 180 br 183
 181 incr16 (basePointer + -2)
 182 br 175
 183 acc8= variable 1
 184 writeLineAcc8
 185 incr8 variable 1
 186 br 181
 187 ;testFor.j(36)     for(word i = 22; 123 >= i+100; i++) { println (b2); b2++; }
 188 acc8= constant 22
 189 acc8=> (basePointer + -2)
 190 acc16= (basePointer + -2)
 191 acc16+ constant 100
 192 acc8= constant 123
 193 acc8CompareAcc16
 194 brlt 203
 195 br 198
 196 incr16 (basePointer + -2)
 197 br 190
 198 acc8= variable 1
 199 writeLineAcc8
 200 incr8 variable 1
 201 br 196
 202 ;testFor.j(37)     for(word i = 16; 114 <  i+100; i--) { println (b2); b2++; }
 203 acc8= constant 16
 204 acc8=> (basePointer + -2)
 205 acc16= (basePointer + -2)
 206 acc16+ constant 100
 207 acc8= constant 114
 208 acc8CompareAcc16
 209 brge 218
 210 br 213
 211 decr16 (basePointer + -2)
 212 br 205
 213 acc8= variable 1
 214 writeLineAcc8
 215 incr8 variable 1
 216 br 211
 217 ;testFor.j(38)     for(word i = 14; 113 <= i+100; i--) { println (b2); b2++; }
 218 acc8= constant 14
 219 acc8=> (basePointer + -2)
 220 acc16= (basePointer + -2)
 221 acc16+ constant 100
 222 acc8= constant 113
 223 acc8CompareAcc16
 224 brgt 236
 225 br 228
 226 decr16 (basePointer + -2)
 227 br 220
 228 acc8= variable 1
 229 writeLineAcc8
 230 incr8 variable 1
 231 br 226
 232 ;testFor.j(39)     // integer - byte
 233 ;testFor.j(40)     // not relevant
 234 ;testFor.j(41)     // integer - integer
 235 ;testFor.j(42)     for(word i = 12; 1012 == i+1000; i--) { println (b2); b2++; }
 236 acc8= constant 12
 237 acc8=> (basePointer + -2)
 238 acc16= (basePointer + -2)
 239 acc16+ constant 1000
 240 acc16Comp constant 1012
 241 brne 250
 242 br 245
 243 decr16 (basePointer + -2)
 244 br 238
 245 acc8= variable 1
 246 writeLineAcc8
 247 incr8 variable 1
 248 br 243
 249 ;testFor.j(43)     for(word i = 11; 1008 != i+1000; i--) { println (b2); b2++; }
 250 acc8= constant 11
 251 acc8=> (basePointer + -2)
 252 acc16= (basePointer + -2)
 253 acc16+ constant 1000
 254 acc16Comp constant 1008
 255 breq 264
 256 br 259
 257 decr16 (basePointer + -2)
 258 br 252
 259 acc8= variable 1
 260 writeLineAcc8
 261 incr8 variable 1
 262 br 257
 263 ;testFor.j(44)     for(word i = 8; 1010 > i+1000; i++) { println (b2); b2++; }
 264 acc8= constant 8
 265 acc8=> (basePointer + -2)
 266 acc16= (basePointer + -2)
 267 acc16+ constant 1000
 268 acc16Comp constant 1010
 269 brge 278
 270 br 273
 271 incr16 (basePointer + -2)
 272 br 266
 273 acc8= variable 1
 274 writeLineAcc8
 275 incr8 variable 1
 276 br 271
 277 ;testFor.j(45)     for(word i = 10; 1011 >= i+1000; i++) { println (b2); b2++; }
 278 acc8= constant 10
 279 acc8=> (basePointer + -2)
 280 acc16= (basePointer + -2)
 281 acc16+ constant 1000
 282 acc16Comp constant 1011
 283 brgt 292
 284 br 287
 285 incr16 (basePointer + -2)
 286 br 280
 287 acc8= variable 1
 288 writeLineAcc8
 289 incr8 variable 1
 290 br 285
 291 ;testFor.j(46)     for(word i = 4; 1002 <  i+1000; i--) { println (b2); b2++; }
 292 acc8= constant 4
 293 acc8=> (basePointer + -2)
 294 acc16= (basePointer + -2)
 295 acc16+ constant 1000
 296 acc16Comp constant 1002
 297 brle 306
 298 br 301
 299 decr16 (basePointer + -2)
 300 br 294
 301 acc8= variable 1
 302 writeLineAcc8
 303 incr8 variable 1
 304 br 299
 305 ;testFor.j(47)     for(word i = 2; 1001 <= i+1000; i--) { println (b2); b2++; }
 306 acc8= constant 2
 307 acc8=> (basePointer + -2)
 308 acc16= (basePointer + -2)
 309 acc16+ constant 1000
 310 acc16Comp constant 1001
 311 brlt 324
 312 br 315
 313 decr16 (basePointer + -2)
 314 br 308
 315 acc8= variable 1
 316 writeLineAcc8
 317 incr8 variable 1
 318 br 313
 319 ;testFor.j(48)   
 320 ;testFor.j(49)     /************************/
 321 ;testFor.j(50)     // constant - var
 322 ;testFor.j(51)     // byte - byte
 323 ;testFor.j(52)     for (byte b = 42; 41 <= b; b--) { println (b2); b2++; }
 324 acc8= constant 42
 325 acc8=> (basePointer + -1)
 326 acc8= (basePointer + -1)
 327 acc8Comp constant 41
 328 brlt 338
 329 br 332
 330 decr8 (basePointer + -1)
 331 br 326
 332 acc8= variable 1
 333 writeLineAcc8
 334 incr8 variable 1
 335 br 330
 336 ;testFor.j(53)     // byte - integer
 337 ;testFor.j(54)     for(word i = 40; 39 <= i; i--) { println (b2); b2++; }
 338 acc8= constant 40
 339 acc8=> (basePointer + -2)
 340 acc16= (basePointer + -2)
 341 acc8= constant 39
 342 acc8CompareAcc16
 343 brgt 355
 344 br 347
 345 decr16 (basePointer + -2)
 346 br 340
 347 acc8= variable 1
 348 writeLineAcc8
 349 incr8 variable 1
 350 br 345
 351 ;testFor.j(55)     // integer - byte
 352 ;testFor.j(56)     // not relevant
 353 ;testFor.j(57)     // integer - integer
 354 ;testFor.j(58)     for(word i = 1038; 1037 <= i; i--) { println (b2); b2++; }
 355 acc16= constant 1038
 356 acc16=> (basePointer + -2)
 357 acc16= (basePointer + -2)
 358 acc16Comp constant 1037
 359 brlt 373
 360 br 363
 361 decr16 (basePointer + -2)
 362 br 357
 363 acc8= variable 1
 364 writeLineAcc8
 365 incr8 variable 1
 366 br 361
 367 ;testFor.j(59)   
 368 ;testFor.j(60)     /************************/
 369 ;testFor.j(61)     // constant - stack8
 370 ;testFor.j(62)     // byte - byte
 371 ;testFor.j(63)     //TODO
 372 ;testFor.j(64)     println(43);
 373 acc8= constant 43
 374 writeLineAcc8
 375 ;testFor.j(65)     println(44);
 376 acc8= constant 44
 377 writeLineAcc8
 378 ;testFor.j(66)     // constant - stack8
 379 ;testFor.j(67)     // byte - integer
 380 ;testFor.j(68)     //TODO
 381 ;testFor.j(69)     println(45);
 382 acc8= constant 45
 383 writeLineAcc8
 384 ;testFor.j(70)     println(46);
 385 acc8= constant 46
 386 writeLineAcc8
 387 ;testFor.j(71)     // constant - stack8
 388 ;testFor.j(72)     // integer - byte
 389 ;testFor.j(73)     //TODO
 390 ;testFor.j(74)     println(47);
 391 acc8= constant 47
 392 writeLineAcc8
 393 ;testFor.j(75)     println(48);
 394 acc8= constant 48
 395 writeLineAcc8
 396 ;testFor.j(76)     // constant - stack88
 397 ;testFor.j(77)     // integer - integer
 398 ;testFor.j(78)     //TODO
 399 ;testFor.j(79)     println(49);
 400 acc8= constant 49
 401 writeLineAcc8
 402 ;testFor.j(80)     println(50);
 403 acc8= constant 50
 404 writeLineAcc8
 405 ;testFor.j(81)   
 406 ;testFor.j(82)     /************************/
 407 ;testFor.j(83)     // constant - stack16
 408 ;testFor.j(84)     // byte - byte
 409 ;testFor.j(85)     //TODO
 410 ;testFor.j(86)     println(51);
 411 acc8= constant 51
 412 writeLineAcc8
 413 ;testFor.j(87)     println(52);
 414 acc8= constant 52
 415 writeLineAcc8
 416 ;testFor.j(88)     // constant - stack16
 417 ;testFor.j(89)     // byte - integer
 418 ;testFor.j(90)     //TODO
 419 ;testFor.j(91)     println(53);
 420 acc8= constant 53
 421 writeLineAcc8
 422 ;testFor.j(92)     println(54);
 423 acc8= constant 54
 424 writeLineAcc8
 425 ;testFor.j(93)     // constant - stack16
 426 ;testFor.j(94)     // integer - byte
 427 ;testFor.j(95)     //TODO
 428 ;testFor.j(96)     println(55);
 429 acc8= constant 55
 430 writeLineAcc8
 431 ;testFor.j(97)     println(56);
 432 acc8= constant 56
 433 writeLineAcc8
 434 ;testFor.j(98)     // constant - stack16
 435 ;testFor.j(99)     // integer - integer
 436 ;testFor.j(100)     //TODO
 437 ;testFor.j(101)     println(57);
 438 acc8= constant 57
 439 writeLineAcc8
 440 ;testFor.j(102)     println(58);
 441 acc8= constant 58
 442 writeLineAcc8
 443 ;testFor.j(103)   
 444 ;testFor.j(104)     /************************/
 445 ;testFor.j(105)     // acc - constant
 446 ;testFor.j(106)     // byte - byte
 447 ;testFor.j(107)     b2 = 59;
 448 acc8= constant 59
 449 acc8=> variable 1
 450 ;testFor.j(108)     for (byte b = 56; b+0 <= 57; b++) { println (b2); b2++; }
 451 acc8= constant 56
 452 acc8=> (basePointer + -1)
 453 acc8= (basePointer + -1)
 454 acc8+ constant 0
 455 acc8Comp constant 57
 456 brgt 470
 457 br 462
 458 incr8 (basePointer + -1)
 459 br 453
 460 acc8= variable 1
 461 writeLineAcc8
 462 incr8 variable 1
 463 br 460
 464 ;testFor.j(109)     // byte - integer
 465 ;testFor.j(110)     //not relevant
 466 ;testFor.j(111)     // integer - byte
 467 ;testFor.j(112)     for (word i = 54; i+0 <= 55; i++) { println (b2); b2++;}
 468 acc8= constant 54
 469 acc8=> (basePointer + -2)
 470 acc16= (basePointer + -2)
 471 acc16+ constant 0
 472 acc8= constant 55
 473 acc16CompareAcc8
 474 brgt 488
 475 br 482
 476 incr16 (basePointer + -2)
 477 br 472
 478 acc8= variable 1
 479 writeLineAcc8
 480 incr8 variable 1
 481 br 480
 482 ;testFor.j(113)     // integer - integer
 483 ;testFor.j(114)     for(word i = 1052; i+0 <= 1053; i++) { println (b2); b2++; }
 484 acc16= constant 1052
 485 acc16=> (basePointer + -2)
 486 acc16= (basePointer + -2)
 487 acc16+ constant 0
 488 acc16Comp constant 1053
 489 brgt 508
 490 br 499
 491 incr16 (basePointer + -2)
 492 br 490
 493 acc8= variable 1
 494 writeLineAcc8
 495 incr8 variable 1
 496 br 497
 497 ;testFor.j(115)   
 498 ;testFor.j(116)     /************************/
 499 ;testFor.j(117)     // acc - acc
 500 ;testFor.j(118)     // byte - byte
 501 ;testFor.j(119)     for (byte b = 64; 63+0 <= b+0; b--) { println (b2); b2++; }
 502 acc8= constant 64
 503 acc8=> (basePointer + -1)
 504 acc8= constant 63
 505 acc8+ constant 0
 506 <acc8
 507 acc8= (basePointer + -1)
 508 acc8+ constant 0
 509 revAcc8Comp unstack8
 510 brlt 526
 511 br 520
 512 decr8 (basePointer + -1)
 513 br 510
 514 acc8= variable 1
 515 writeLineAcc8
 516 incr8 variable 1
 517 br 518
 518 ;testFor.j(120)     // byte - integer
 519 ;testFor.j(121)     for(word i = 62; 61+0 <= i+0; i--) { println (b2); b2++; }
 520 acc8= constant 62
 521 acc8=> (basePointer + -2)
 522 acc8= constant 61
 523 acc8+ constant 0
 524 <acc8
 525 acc16= (basePointer + -2)
 526 acc16+ constant 0
 527 acc8<
 528 acc8CompareAcc16
 529 brgt 545
 530 br 539
 531 decr16 (basePointer + -2)
 532 br 528
 533 acc8= variable 1
 534 writeLineAcc8
 535 incr8 variable 1
 536 br 537
 537 ;testFor.j(122)     // integer - byte
 538 ;testFor.j(123)     i2=59;
 539 acc8= constant 59
 540 acc8=> variable 2
 541 ;testFor.j(124)     for (byte b = 60; i2+0 <= b+0; b--) { println (b2); b2++; }
 542 acc8= constant 60
 543 acc8=> (basePointer + -1)
 544 acc16= variable 2
 545 acc16+ constant 0
 546 <acc16
 547 acc8= (basePointer + -1)
 548 acc8+ constant 0
 549 acc16<
 550 acc16CompareAcc8
 551 brgt 567
 552 br 561
 553 decr8 (basePointer + -1)
 554 br 550
 555 acc8= variable 1
 556 writeLineAcc8
 557 incr8 variable 1
 558 br 559
 559 ;testFor.j(125)     // integer - integer
 560 ;testFor.j(126)     for(word i = 1058; 1000+57 <= i+0; i--) { println (b2); b2++; }
 561 acc16= constant 1058
 562 acc16=> (basePointer + -2)
 563 acc16= constant 1000
 564 acc16+ constant 57
 565 <acc16
 566 acc16= (basePointer + -2)
 567 acc16+ constant 0
 568 revAcc16Comp unstack16
 569 brlt 588
 570 br 579
 571 decr16 (basePointer + -2)
 572 br 569
 573 acc8= variable 1
 574 writeLineAcc8
 575 incr8 variable 1
 576 br 577
 577 ;testFor.j(127)   
 578 ;testFor.j(128)     /************************/
 579 ;testFor.j(129)     // acc - var
 580 ;testFor.j(130)     // byte - byte
 581 ;testFor.j(131)     for (byte b = 72; 71+0 <= b; b--) { println (b2); b2++; }
 582 acc8= constant 72
 583 acc8=> (basePointer + -1)
 584 acc8= constant 71
 585 acc8+ constant 0
 586 acc8Comp (basePointer + -1)
 587 brgt 605
 588 br 599
 589 decr8 (basePointer + -1)
 590 br 590
 591 acc8= variable 1
 592 writeLineAcc8
 593 incr8 variable 1
 594 br 597
 595 ;testFor.j(132)     // byte - integer
 596 ;testFor.j(133)     for(word i = 70; 69+0 <= i; i--) { println (b2); b2++; }
 597 acc8= constant 70
 598 acc8=> (basePointer + -2)
 599 acc8= constant 69
 600 acc8+ constant 0
 601 acc16= (basePointer + -2)
 602 acc8CompareAcc16
 603 brgt 623
 604 br 617
 605 decr16 (basePointer + -2)
 606 br 607
 607 acc8= variable 1
 608 writeLineAcc8
 609 incr8 variable 1
 610 br 615
 611 ;testFor.j(134)     // integer - byte
 612 ;testFor.j(135)     i2=67;
 613 acc8= constant 67
 614 acc8=> variable 2
 615 ;testFor.j(136)     for (byte b = 68; i2+0 <= b; b--) { println (b2); b2++; }
 616 acc8= constant 68
 617 acc8=> (basePointer + -1)
 618 acc16= variable 2
 619 acc16+ constant 0
 620 acc8= (basePointer + -1)
 621 acc16CompareAcc8
 622 brgt 644
 623 br 638
 624 decr8 (basePointer + -1)
 625 br 628
 626 acc8= variable 1
 627 writeLineAcc8
 628 incr8 variable 1
 629 br 636
 630 ;testFor.j(137)     // integer - integer
 631 ;testFor.j(138)     for(word i = 1066; 1000+65 <= i; i--) { println (b2); b2++; }
 632 acc16= constant 1066
 633 acc16=> (basePointer + -2)
 634 acc16= constant 1000
 635 acc16+ constant 65
 636 acc16Comp (basePointer + -2)
 637 brgt 665
 638 br 655
 639 decr16 (basePointer + -2)
 640 br 646
 641 acc8= variable 1
 642 writeLineAcc8
 643 incr8 variable 1
 644 br 653
 645 ;testFor.j(139)   
 646 ;testFor.j(140)     /************************/
 647 ;testFor.j(141)     // acc - stack8
 648 ;testFor.j(142)     // byte - byte
 649 ;testFor.j(143)     //TODO
 650 ;testFor.j(144)     println(81);
 651 acc8= constant 81
 652 writeLineAcc8
 653 ;testFor.j(145)     println(82);
 654 acc8= constant 82
 655 writeLineAcc8
 656 ;testFor.j(146)     // byte - integer
 657 ;testFor.j(147)     //TODO
 658 ;testFor.j(148)     println(83);
 659 acc8= constant 83
 660 writeLineAcc8
 661 ;testFor.j(149)     println(84);
 662 acc8= constant 84
 663 writeLineAcc8
 664 ;testFor.j(150)     // integer - byte
 665 ;testFor.j(151)     //TODO
 666 ;testFor.j(152)     println(85);
 667 acc8= constant 85
 668 writeLineAcc8
 669 ;testFor.j(153)     println(86);
 670 acc8= constant 86
 671 writeLineAcc8
 672 ;testFor.j(154)     // integer - integer
 673 ;testFor.j(155)     //TODO
 674 ;testFor.j(156)     println(87);
 675 acc8= constant 87
 676 writeLineAcc8
 677 ;testFor.j(157)     println(88);
 678 acc8= constant 88
 679 writeLineAcc8
 680 ;testFor.j(158)   
 681 ;testFor.j(159)     /************************/
 682 ;testFor.j(160)     // acc - stack16
 683 ;testFor.j(161)     // byte - byte
 684 ;testFor.j(162)     //TODO
 685 ;testFor.j(163)     println(89);
 686 acc8= constant 89
 687 writeLineAcc8
 688 ;testFor.j(164)     println(90);
 689 acc8= constant 90
 690 writeLineAcc8
 691 ;testFor.j(165)     // byte - integer
 692 ;testFor.j(166)     //TODO
 693 ;testFor.j(167)     println(91);
 694 acc8= constant 91
 695 writeLineAcc8
 696 ;testFor.j(168)     println(92);
 697 acc8= constant 92
 698 writeLineAcc8
 699 ;testFor.j(169)     // integer - byte
 700 ;testFor.j(170)     //TODO
 701 ;testFor.j(171)     println(93);
 702 acc8= constant 93
 703 writeLineAcc8
 704 ;testFor.j(172)     println(94);
 705 acc8= constant 94
 706 writeLineAcc8
 707 ;testFor.j(173)     // integer - integer
 708 ;testFor.j(174)     //TODO
 709 ;testFor.j(175)     println(95);
 710 acc8= constant 95
 711 writeLineAcc8
 712 ;testFor.j(176)     println(96);
 713 acc8= constant 96
 714 writeLineAcc8
 715 ;testFor.j(177)   
 716 ;testFor.j(178)     /************************/
 717 ;testFor.j(179)     // var - constant
 718 ;testFor.j(180)     // byte - byte
 719 ;testFor.j(181)     b2=97;
 720 acc8= constant 97
 721 acc8=> variable 1
 722 ;testFor.j(182)     for (byte b = 96; b <= 97; b++) { println (b2); b2++; }
 723 acc8= constant 96
 724 acc8=> (basePointer + -1)
 725 acc8= (basePointer + -1)
 726 acc8Comp constant 97
 727 brgt 753
 728 br 745
 729 incr8 (basePointer + -1)
 730 br 739
 731 acc8= variable 1
 732 writeLineAcc8
 733 incr8 variable 1
 734 br 743
 735 ;testFor.j(183)     // byte - integer
 736 ;testFor.j(184)     //not relevant
 737 ;testFor.j(185)     // integer - byte
 738 ;testFor.j(186)     for(word i = 92; i <= 93; i++) { println (b2); b2++; }
 739 acc8= constant 92
 740 acc8=> (basePointer + -2)
 741 acc16= (basePointer + -2)
 742 acc8= constant 93
 743 acc16CompareAcc8
 744 brgt 768
 745 br 762
 746 incr16 (basePointer + -2)
 747 br 755
 748 acc8= variable 1
 749 writeLineAcc8
 750 incr8 variable 1
 751 br 760
 752 ;testFor.j(187)     // integer - integer
 753 ;testFor.j(188)     for(word i = 1090; i <= 1091; i++) { println (b2); b2++; }
 754 acc16= constant 1090
 755 acc16=> (basePointer + -2)
 756 acc16= (basePointer + -2)
 757 acc16Comp constant 1091
 758 brgt 785
 759 br 776
 760 incr16 (basePointer + -2)
 761 br 770
 762 acc8= variable 1
 763 writeLineAcc8
 764 incr8 variable 1
 765 br 774
 766 ;testFor.j(189)   
 767 ;testFor.j(190)     /************************/
 768 ;testFor.j(191)     // var - acc
 769 ;testFor.j(192)     // byte - byte
 770 ;testFor.j(193)     for (byte b = 104; b <= 105+0; b++) { println (b2); b2++; }
 771 acc8= constant 104
 772 acc8=> (basePointer + -1)
 773 acc8= constant 105
 774 acc8+ constant 0
 775 acc8Comp (basePointer + -1)
 776 brlt 800
 777 br 794
 778 incr8 (basePointer + -1)
 779 br 787
 780 acc8= variable 1
 781 writeLineAcc8
 782 incr8 variable 1
 783 br 792
 784 ;testFor.j(194)     // byte - integer
 785 ;testFor.j(195)     i2=103;
 786 acc8= constant 103
 787 acc8=> variable 2
 788 ;testFor.j(196)     for (byte b = 102; b <= i2+0; b++) { println (b2); b2++; }
 789 acc8= constant 102
 790 acc8=> (basePointer + -1)
 791 acc16= variable 2
 792 acc16+ constant 0
 793 acc8= (basePointer + -1)
 794 acc8CompareAcc16
 795 brgt 819
 796 br 813
 797 incr8 (basePointer + -1)
 798 br 805
 799 acc8= variable 1
 800 writeLineAcc8
 801 incr8 variable 1
 802 br 811
 803 ;testFor.j(197)     // integer - byte
 804 ;testFor.j(198)     for(word i = 100; i <= 101+0; i++) { println (b2); b2++; }
 805 acc8= constant 100
 806 acc8=> (basePointer + -2)
 807 acc8= constant 101
 808 acc8+ constant 0
 809 acc16= (basePointer + -2)
 810 acc16CompareAcc8
 811 brgt 835
 812 br 829
 813 incr16 (basePointer + -2)
 814 br 821
 815 acc8= variable 1
 816 writeLineAcc8
 817 incr8 variable 1
 818 br 827
 819 ;testFor.j(199)     // integer - integer
 820 ;testFor.j(200)     for(word i = 1098; i <= 1099+0; i++) { println (b2); b2++; }
 821 acc16= constant 1098
 822 acc16=> (basePointer + -2)
 823 acc16= constant 1099
 824 acc16+ constant 0
 825 acc16Comp (basePointer + -2)
 826 brlt 853
 827 br 844
 828 incr16 (basePointer + -2)
 829 br 837
 830 acc8= variable 1
 831 writeLineAcc8
 832 incr8 variable 1
 833 br 842
 834 ;testFor.j(201)   
 835 ;testFor.j(202)     /************************/
 836 ;testFor.j(203)     // var - var
 837 ;testFor.j(204)     // byte - byte
 838 ;testFor.j(205)     for (byte b = 112; b2 <= b; b--) { println (b2); b2++; }
 839 acc8= constant 112
 840 acc8=> (basePointer + -1)
 841 acc8= variable 1
 842 acc8Comp (basePointer + -1)
 843 brgt 867
 844 br 861
 845 decr8 (basePointer + -1)
 846 br 855
 847 acc8= variable 1
 848 writeLineAcc8
 849 incr8 variable 1
 850 br 859
 851 ;testFor.j(206)     // byte - integer
 852 ;testFor.j(207)     for(word i = 116; b2 <= i; i--) { println (b2); b2++; }
 853 acc8= constant 116
 854 acc8=> (basePointer + -2)
 855 acc8= variable 1
 856 acc16= (basePointer + -2)
 857 acc8CompareAcc16
 858 brgt 882
 859 br 876
 860 decr16 (basePointer + -2)
 861 br 869
 862 acc8= variable 1
 863 writeLineAcc8
 864 incr8 variable 1
 865 br 874
 866 ;testFor.j(208)     // integer - byte
 867 ;testFor.j(209)     i2=b2;
 868 acc8= variable 1
 869 acc8=> variable 2
 870 ;testFor.j(210)     for (byte b = 118; i2 <= b; b--) { println (b2); b2++; }
 871 acc8= constant 118
 872 acc8=> (basePointer + -1)
 873 acc16= variable 2
 874 acc8= (basePointer + -1)
 875 acc16CompareAcc8
 876 brgt 900
 877 br 894
 878 decr8 (basePointer + -1)
 879 br 887
 880 acc8= variable 1
 881 writeLineAcc8
 882 incr8 variable 1
 883 br 892
 884 ;testFor.j(211)     // integer - integer
 885 ;testFor.j(212)     i2=120;
 886 acc8= constant 120
 887 acc8=> variable 2
 888 ;testFor.j(213)     for(word i = b2+4; i2 <= i; i--) { println (b2); b2++; }
 889 acc8= variable 1
 890 acc8+ constant 4
 891 acc8=> (basePointer + -2)
 892 acc16= variable 2
 893 acc16Comp (basePointer + -2)
 894 brgt 950
 895 br 912
 896 decr16 (basePointer + -2)
 897 br 906
 898 acc8= variable 1
 899 writeLineAcc8
 900 incr8 variable 1
 901 br 910
 902 ;testFor.j(214)   
 903 ;testFor.j(215)     /************************/
 904 ;testFor.j(216)     // var - stack8
 905 ;testFor.j(217)     // byte - byte
 906 ;testFor.j(218)     // byte - integer
 907 ;testFor.j(219)     // integer - byte
 908 ;testFor.j(220)     // integer - integer
 909 ;testFor.j(221)     //TODO
 910 ;testFor.j(222)   
 911 ;testFor.j(223)     /************************/
 912 ;testFor.j(224)     // var - stack16
 913 ;testFor.j(225)     // byte - byte
 914 ;testFor.j(226)     // byte - integer
 915 ;testFor.j(227)     // integer - byte
 916 ;testFor.j(228)     // integer - integer
 917 ;testFor.j(229)     //TODO
 918 ;testFor.j(230)   
 919 ;testFor.j(231)     /************************/
 920 ;testFor.j(232)     // stack8 - constant
 921 ;testFor.j(233)     // stack8 - acc
 922 ;testFor.j(234)     // stack8 - var
 923 ;testFor.j(235)     // stack8 - stack8
 924 ;testFor.j(236)     // stack8 - stack16
 925 ;testFor.j(237)     //TODO
 926 ;testFor.j(238)   
 927 ;testFor.j(239)     /************************/
 928 ;testFor.j(240)     // stack16 - constant
 929 ;testFor.j(241)     // stack16 - acc
 930 ;testFor.j(242)     // stack16 - var
 931 ;testFor.j(243)     // stack16 - stack8
 932 ;testFor.j(244)     // stack16 - stack16
 933 ;testFor.j(245)     //TODO
 934 ;testFor.j(246)   
 935 ;testFor.j(247)     println("Klaar.");
 936 acc16= stringconstant 943
 937 writeLineString
 938 ;testFor.j(248)   }
 939 stackPointer= basePointer
 940 basePointer<
 941 return
 942 ;testFor.j(249) }
 943 stringConstant 0 = "Klaar."
