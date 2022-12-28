   0 ;test3.j(0) /* Program to test multiplication */
   1 ;test3.j(1) class TestMultiply {
   2 ;test3.j(2)   write(14);
   3 acc8= constant 14
   4 call writeAcc8
   5 ;test3.j(3)   word a = 14;
   6 acc8= constant 14
   7 acc8=> variable 0
   8 ;test3.j(4)   a--;
   9 decr16 variable 0
  10 ;test3.j(5)   write(a);
  11 acc16= variable 0
  12 call writeAcc16
  13 ;test3.j(6)   a = 11;
  14 acc8= constant 11
  15 acc8=> variable 0
  16 ;test3.j(7)   a++;
  17 incr16 variable 0
  18 ;test3.j(8)   write(a);
  19 acc16= variable 0
  20 call writeAcc16
  21 ;test3.j(9)   if (6561 / 729 == 9) write (11); else write (0);
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
  32 ;test3.j(10)   if (729 * 9 == 6561) write (10); else write (0);
  33 acc16= constant 729
  34 acc16* constant 9
  35 acc16Comp constant 6561
  36 brne 40
  37 acc8= constant 10
  38 call writeAcc8
  39 br 43
  40 acc8= constant 0
  41 call writeAcc8
  42 ;test3.j(11)   if (729 == 729) write (9); else write (0);
  43 acc16= constant 729
  44 acc16Comp constant 729
  45 brne 49
  46 acc8= constant 9
  47 call writeAcc8
  48 br 52
  49 acc8= constant 0
  50 call writeAcc8
  51 ;test3.j(12)   if (2 * 9 * 9 == 162) write (8); else write (0);
  52 acc8= constant 2
  53 acc8* constant 9
  54 acc8* constant 9
  55 acc8Comp constant 162
  56 brne 60
  57 acc8= constant 8
  58 call writeAcc8
  59 br 63
  60 acc8= constant 0
  61 call writeAcc8
  62 ;test3.j(13)   if (7 * 5 == 35) write (7); else write (0);
  63 acc8= constant 7
  64 acc8* constant 5
  65 acc8Comp constant 35
  66 brne 70
  67 acc8= constant 7
  68 call writeAcc8
  69 br 73
  70 acc8= constant 0
  71 call writeAcc8
  72 ;test3.j(14)   a = 2;
  73 acc8= constant 2
  74 acc8=> variable 0
  75 ;test3.j(15)   write(3 * a);
  76 acc8= constant 3
  77 acc8ToAcc16
  78 acc16* variable 0
  79 call writeAcc16
  80 ;test3.j(16)   a = 1;
  81 acc8= constant 1
  82 acc8=> variable 0
  83 ;test3.j(17)   write(a * 5);
  84 acc16= variable 0
  85 acc16* constant 5
  86 call writeAcc16
  87 ;test3.j(18)   a = 2 * 2;
  88 acc8= constant 2
  89 acc8* constant 2
  90 acc8=> variable 0
  91 ;test3.j(19)   write(a);
  92 acc16= variable 0
  93 call writeAcc16
  94 ;test3.j(20)   write(1 * 3);
  95 acc8= constant 1
  96 acc8* constant 3
  97 call writeAcc8
  98 ;test3.j(21)   write(2 * 1);
  99 acc8= constant 2
 100 acc8* constant 1
 101 call writeAcc8
 102 ;test3.j(22)   write(1 * 1);
 103 acc8= constant 1
 104 acc8* constant 1
 105 call writeAcc8
 106 ;test3.j(23)   write(1 * 0);
 107 acc8= constant 1
 108 acc8* constant 0
 109 call writeAcc8
 110 ;test3.j(24) }
 111 stop
