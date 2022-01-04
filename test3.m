   0 ;test3.p(0) /* Program to test multiplication */
   1 ;test3.p(1) class TestMultiply {
   2 ;test3.p(2)   write(14);
   3 acc8= constant 14
   4 call writeAcc8
   5 ;test3.p(3)   int a = 14;
   6 acc8= constant 14
   7 acc8ToAcc16
   8 acc16=> variable 0
   9 ;test3.p(4)   a--;
  10 decr16 variable 0
  11 ;test3.p(5)   write(a);
  12 acc16= variable 0
  13 call writeAcc16
  14 ;test3.p(6)   a = 11;
  15 acc8= constant 11
  16 acc8ToAcc16
  17 acc16=> variable 0
  18 ;test3.p(7)   a++;
  19 incr16 variable 0
  20 ;test3.p(8)   write(a);
  21 acc16= variable 0
  22 call writeAcc16
  23 ;test3.p(9)   if (6561 / 729 == 9) write (11); else write (0);
  24 acc16= constant 6561
  25 acc16/ constant 729
  26 <acc16
  27 acc16= unstack16
  28 acc8= constant 9
  29 acc16CompareAcc8
  30 brne 34
  31 acc8= constant 11
  32 call writeAcc8
  33 br 37
  34 acc8= constant 0
  35 call writeAcc8
  36 ;test3.p(10)   if (729 * 9 == 6561) write (10); else write (0);
  37 acc16= constant 729
  38 acc16* constant 9
  39 <acc16
  40 acc16= unstack16
  41 acc16Comp constant 6561
  42 brne 46
  43 acc8= constant 10
  44 call writeAcc8
  45 br 49
  46 acc8= constant 0
  47 call writeAcc8
  48 ;test3.p(11)   if (729 == 729) write (9); else write (0);
  49 acc16= constant 729
  50 acc16Comp constant 729
  51 brne 55
  52 acc8= constant 9
  53 call writeAcc8
  54 br 58
  55 acc8= constant 0
  56 call writeAcc8
  57 ;test3.p(12)   if (2 * 9 * 9 == 162) write (8); else write (0);
  58 acc8= constant 2
  59 acc8* constant 9
  60 acc8* constant 9
  61 <acc8
  62 acc8= unstack8
  63 acc8Comp constant 162
  64 brne 68
  65 acc8= constant 8
  66 call writeAcc8
  67 br 71
  68 acc8= constant 0
  69 call writeAcc8
  70 ;test3.p(13)   if (7 * 5 == 35) write (7); else write (0);
  71 acc8= constant 7
  72 acc8* constant 5
  73 <acc8
  74 acc8= unstack8
  75 acc8Comp constant 35
  76 brne 80
  77 acc8= constant 7
  78 call writeAcc8
  79 br 83
  80 acc8= constant 0
  81 call writeAcc8
  82 ;test3.p(14)   a = 2;
  83 acc8= constant 2
  84 acc8ToAcc16
  85 acc16=> variable 0
  86 ;test3.p(15)   write(3 * a);
  87 acc8= constant 3
  88 acc8ToAcc16
  89 acc16* variable 0
  90 call writeAcc16
  91 ;test3.p(16)   a = 1;
  92 acc8= constant 1
  93 acc8ToAcc16
  94 acc16=> variable 0
  95 ;test3.p(17)   write(a * 5);
  96 acc16= variable 0
  97 acc16* constant 5
  98 call writeAcc16
  99 ;test3.p(18)   a = 2 * 2;
 100 acc8= constant 2
 101 acc8* constant 2
 102 acc8ToAcc16
 103 acc16=> variable 0
 104 ;test3.p(19)   write(a);
 105 acc16= variable 0
 106 call writeAcc16
 107 ;test3.p(20)   write(1 * 3);
 108 acc8= constant 1
 109 acc8* constant 3
 110 call writeAcc8
 111 ;test3.p(21)   write(2 * 1);
 112 acc8= constant 2
 113 acc8* constant 1
 114 call writeAcc8
 115 ;test3.p(22)   write(1 * 1);
 116 acc8= constant 1
 117 acc8* constant 1
 118 call writeAcc8
 119 ;test3.p(23)   write(1 * 0);
 120 acc8= constant 1
 121 acc8* constant 0
 122 call writeAcc8
 123 ;test3.p(24) }
 124 stop
