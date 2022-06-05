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
  24 <acc16
  25 acc16= unstack16
  26 acc8= constant 9
  27 acc16CompareAcc8
  28 brne 32
  29 acc8= constant 11
  30 call writeAcc8
  31 br 35
  32 acc8= constant 0
  33 call writeAcc8
  34 ;test3.p(10)   if (729 * 9 == 6561) write (10); else write (0);
  35 acc16= constant 729
  36 acc16* constant 9
  37 <acc16
  38 acc16= unstack16
  39 acc16Comp constant 6561
  40 brne 44
  41 acc8= constant 10
  42 call writeAcc8
  43 br 47
  44 acc8= constant 0
  45 call writeAcc8
  46 ;test3.p(11)   if (729 == 729) write (9); else write (0);
  47 acc16= constant 729
  48 acc16Comp constant 729
  49 brne 53
  50 acc8= constant 9
  51 call writeAcc8
  52 br 56
  53 acc8= constant 0
  54 call writeAcc8
  55 ;test3.p(12)   if (2 * 9 * 9 == 162) write (8); else write (0);
  56 acc8= constant 2
  57 acc8* constant 9
  58 acc8* constant 9
  59 <acc8
  60 acc8= unstack8
  61 acc8Comp constant 162
  62 brne 66
  63 acc8= constant 8
  64 call writeAcc8
  65 br 69
  66 acc8= constant 0
  67 call writeAcc8
  68 ;test3.p(13)   if (7 * 5 == 35) write (7); else write (0);
  69 acc8= constant 7
  70 acc8* constant 5
  71 <acc8
  72 acc8= unstack8
  73 acc8Comp constant 35
  74 brne 78
  75 acc8= constant 7
  76 call writeAcc8
  77 br 81
  78 acc8= constant 0
  79 call writeAcc8
  80 ;test3.p(14)   a = 2;
  81 acc8= constant 2
  82 acc8=> variable 0
  83 ;test3.p(15)   write(3 * a);
  84 acc8= constant 3
  85 acc8ToAcc16
  86 acc16* variable 0
  87 call writeAcc16
  88 ;test3.p(16)   a = 1;
  89 acc8= constant 1
  90 acc8=> variable 0
  91 ;test3.p(17)   write(a * 5);
  92 acc16= variable 0
  93 acc16* constant 5
  94 call writeAcc16
  95 ;test3.p(18)   a = 2 * 2;
  96 acc8= constant 2
  97 acc8* constant 2
  98 acc8=> variable 0
  99 ;test3.p(19)   write(a);
 100 acc16= variable 0
 101 call writeAcc16
 102 ;test3.p(20)   write(1 * 3);
 103 acc8= constant 1
 104 acc8* constant 3
 105 call writeAcc8
 106 ;test3.p(21)   write(2 * 1);
 107 acc8= constant 2
 108 acc8* constant 1
 109 call writeAcc8
 110 ;test3.p(22)   write(1 * 1);
 111 acc8= constant 1
 112 acc8* constant 1
 113 call writeAcc8
 114 ;test3.p(23)   write(1 * 0);
 115 acc8= constant 1
 116 acc8* constant 0
 117 call writeAcc8
 118 ;test3.p(24) }
 119 stop
