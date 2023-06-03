   0 ;test3.j(0) /* Program to test multiplication */
   1 ;test3.j(1) class TestMultiply {
   2 ;test3.j(2)   println(1 * 0);
   3 acc8= constant 1
   4 acc8* constant 0
   5 call writeAcc8
   6 ;test3.j(3)   println(1 * 1);
   7 acc8= constant 1
   8 acc8* constant 1
   9 call writeAcc8
  10 ;test3.j(4)   println(2 * 1);
  11 acc8= constant 2
  12 acc8* constant 1
  13 call writeAcc8
  14 ;test3.j(5)   println(1 * 3);
  15 acc8= constant 1
  16 acc8* constant 3
  17 call writeAcc8
  18 ;test3.j(6)   word a = 2 * 2;
  19 acc8= constant 2
  20 acc8* constant 2
  21 acc8=> variable 0
  22 ;test3.j(7)   println(a);
  23 acc16= variable 0
  24 call writeAcc16
  25 ;test3.j(8)   a = 1;
  26 acc8= constant 1
  27 acc8=> variable 0
  28 ;test3.j(9)   println(a * 5);
  29 acc16= variable 0
  30 acc16* constant 5
  31 call writeAcc16
  32 ;test3.j(10)   a = 2;
  33 acc8= constant 2
  34 acc8=> variable 0
  35 ;test3.j(11)   println(3 * a);
  36 acc8= constant 3
  37 acc8ToAcc16
  38 acc16* variable 0
  39 call writeAcc16
  40 ;test3.j(12)   if (7 * 5 == 35) println (7); else println (999);
  41 acc8= constant 7
  42 acc8* constant 5
  43 acc8Comp constant 35
  44 brne 48
  45 acc8= constant 7
  46 call writeAcc8
  47 br 51
  48 acc16= constant 999
  49 call writeAcc16
  50 ;test3.j(13)   if (2 * 9 * 9 == 162) println (8); else println (999);
  51 acc8= constant 2
  52 acc8* constant 9
  53 acc8* constant 9
  54 acc8Comp constant 162
  55 brne 59
  56 acc8= constant 8
  57 call writeAcc8
  58 br 62
  59 acc16= constant 999
  60 call writeAcc16
  61 ;test3.j(14)   if (729 == 729) println (9); else println (999);
  62 acc16= constant 729
  63 acc16Comp constant 729
  64 brne 68
  65 acc8= constant 9
  66 call writeAcc8
  67 br 71
  68 acc16= constant 999
  69 call writeAcc16
  70 ;test3.j(15)   if (729 * 9 == 6561) println (10); else println (999);
  71 acc16= constant 729
  72 acc16* constant 9
  73 acc16Comp constant 6561
  74 brne 78
  75 acc8= constant 10
  76 call writeAcc8
  77 br 81
  78 acc16= constant 999
  79 call writeAcc16
  80 ;test3.j(16)   if (6561 / 729 == 9) println (11); else println (999);
  81 acc16= constant 6561
  82 acc16/ constant 729
  83 acc8= constant 9
  84 acc16CompareAcc8
  85 brne 89
  86 acc8= constant 11
  87 call writeAcc8
  88 br 92
  89 acc16= constant 999
  90 call writeAcc16
  91 ;test3.j(17)   a = 13;
  92 acc8= constant 13
  93 acc8=> variable 0
  94 ;test3.j(18)   a--;
  95 decr16 variable 0
  96 ;test3.j(19)   println(a);
  97 acc16= variable 0
  98 call writeAcc16
  99 ;test3.j(20)   a++;
 100 incr16 variable 0
 101 ;test3.j(21)   println(a);
 102 acc16= variable 0
 103 call writeAcc16
 104 ;test3.j(22)   println(14);
 105 acc8= constant 14
 106 call writeAcc8
 107 ;test3.j(23)   println("Klaar");
 108 acc16= constant 112
 109 writeString
 110 ;test3.j(24) }
 111 stop
 112 stringConstant 0 = "Klaar"
