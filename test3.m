   0 ;test3.p(0) /* Program to test multiplication */
   1 ;test3.p(1) class TestMultiply {
   2 ;test3.p(2)   write(14);
   3 acc8= constant 14
   4 call writeAcc8
   5 ;test3.p(3)   int a = 14;
   6 acc8= constant 14
   7 acc8=> variable 0
   8 ;test3.p(4)   a--;
   9 decr16 variable 0
  10 ;test3.p(5)   write(a);
  11 acc16= variable 0
  12 call writeAcc16
  13 ;test3.p(6)   a = 11;
  14 acc8= constant 11
  15 acc8=> variable 0
  16 ;test3.p(7)   a++;
  17 incr16 variable 0
  18 ;test3.p(8)   write(a);
  19 acc16= variable 0
  20 call writeAcc16
  21 ;test3.p(9)   if (6561 / 729 == 9) write (11); else write (0);
  22 acc16= constant 6561
  23 acc16/ constant 729
  24 acc8= constant 9
  25 acc16CompareAcc8
  26 brne 30
  27 acc8= constant 11
  28 call writeAcc8
  29 br 33
  30 acc8= constant 0
  31 call writeAcc8
  32 ;test3.p(10)   if (729 * 9 == 6561) write (10); else write (0);
  33 acc16= constant 729
  34 acc16* constant 9
  35 acc16Comp constant 6561
  36 brne 40
  37 acc8= constant 10
  38 call writeAcc8
  39 br 43
  40 acc8= constant 0
  41 call writeAcc8
  42 ;test3.p(11)   if (729 == 729) write (9); else write (0);
  43 acc16= constant 729
  44 acc16Comp constant 729
  45 brne 49
  46 acc8= constant 9
  47 call writeAcc8
  48 br 52
  49 acc8= constant 0
  50 call writeAcc8
  51 ;test3.p(12)   if (2 * 9 * 9 == 162) write (8); else write (0);
  52 acc8= constant 2
  53 acc8* constant 9
  54 acc8* constant 9
  55 <acc8
  56 acc8= unstack8
  57 acc8Comp constant 162
  58 brne 62
  59 acc8= constant 8
  60 call writeAcc8
  61 br 65
  62 acc8= constant 0
  63 call writeAcc8
  64 ;test3.p(13)   if (7 * 5 == 35) write (7); else write (0);
  65 acc8= constant 7
  66 acc8* constant 5
  67 <acc8
  68 acc8= unstack8
  69 acc8Comp constant 35
  70 brne 74
  71 acc8= constant 7
  72 call writeAcc8
  73 br 77
  74 acc8= constant 0
  75 call writeAcc8
  76 ;test3.p(14)   a = 2;
  77 acc8= constant 2
  78 acc8=> variable 0
  79 ;test3.p(15)   write(3 * a);
  80 acc8= constant 3
  81 acc8ToAcc16
  82 acc16* variable 0
  83 call writeAcc16
  84 ;test3.p(16)   a = 1;
  85 acc8= constant 1
  86 acc8=> variable 0
  87 ;test3.p(17)   write(a * 5);
  88 acc16= variable 0
  89 acc16* constant 5
  90 call writeAcc16
  91 ;test3.p(18)   a = 2 * 2;
  92 acc8= constant 2
  93 acc8* constant 2
  94 acc8=> variable 0
  95 ;test3.p(19)   write(a);
  96 acc16= variable 0
  97 call writeAcc16
  98 ;test3.p(20)   write(1 * 3);
  99 acc8= constant 1
 100 acc8* constant 3
 101 call writeAcc8
 102 ;test3.p(21)   write(2 * 1);
 103 acc8= constant 2
 104 acc8* constant 1
 105 call writeAcc8
 106 ;test3.p(22)   write(1 * 1);
 107 acc8= constant 1
 108 acc8* constant 1
 109 call writeAcc8
 110 ;test3.p(23)   write(1 * 0);
 111 acc8= constant 1
 112 acc8* constant 0
 113 call writeAcc8
 114 ;test3.p(24) }
 115 stop
