   0 ;test3.j(0) /* Program to test multiplication */
   1 ;test3.j(1) class TestMultiply {
   2 class TestMultiply []
   3 ;test3.j(2)   private static word a;
   4 ;test3.j(3) 
   5 ;test3.j(4)   public static void main() {
   6 method main [public, static] void
   7 ;test3.j(5)     println(1 * 0);
   8 acc8= constant 1
   9 acc8* constant 0
  10 call writeLineAcc8
  11 ;test3.j(6)     println(1 * 1);
  12 acc8= constant 1
  13 acc8* constant 1
  14 call writeLineAcc8
  15 ;test3.j(7)     println(2 * 1);
  16 acc8= constant 2
  17 acc8* constant 1
  18 call writeLineAcc8
  19 ;test3.j(8)     println(1 * 3);
  20 acc8= constant 1
  21 acc8* constant 3
  22 call writeLineAcc8
  23 ;test3.j(9)     a = 2 * 2;
  24 acc8= constant 2
  25 acc8* constant 2
  26 acc8=> variable 0
  27 ;test3.j(10)     println(a);
  28 acc16= variable 0
  29 call writeLineAcc16
  30 ;test3.j(11)     a = 1;
  31 acc8= constant 1
  32 acc8=> variable 0
  33 ;test3.j(12)     println(a * 5);
  34 acc16= variable 0
  35 acc16* constant 5
  36 call writeLineAcc16
  37 ;test3.j(13)     a = 2;
  38 acc8= constant 2
  39 acc8=> variable 0
  40 ;test3.j(14)     println(3 * a);
  41 acc8= constant 3
  42 acc8ToAcc16
  43 acc16* variable 0
  44 call writeLineAcc16
  45 ;test3.j(15)     if (7 * 5 == 35) println (7); else println (999);
  46 acc8= constant 7
  47 acc8* constant 5
  48 acc8Comp constant 35
  49 brne 53
  50 acc8= constant 7
  51 call writeLineAcc8
  52 br 56
  53 acc16= constant 999
  54 call writeLineAcc16
  55 ;test3.j(16)     if (2 * 9 * 9 == 162) println (8); else println (999);
  56 acc8= constant 2
  57 acc8* constant 9
  58 acc8* constant 9
  59 acc8Comp constant 162
  60 brne 64
  61 acc8= constant 8
  62 call writeLineAcc8
  63 br 67
  64 acc16= constant 999
  65 call writeLineAcc16
  66 ;test3.j(17)     if (729 == 729) println (9); else println (999);
  67 acc16= constant 729
  68 acc16Comp constant 729
  69 brne 73
  70 acc8= constant 9
  71 call writeLineAcc8
  72 br 76
  73 acc16= constant 999
  74 call writeLineAcc16
  75 ;test3.j(18)     if (729 * 9 == 6561) println (10); else println (999);
  76 acc16= constant 729
  77 acc16* constant 9
  78 acc16Comp constant 6561
  79 brne 83
  80 acc8= constant 10
  81 call writeLineAcc8
  82 br 86
  83 acc16= constant 999
  84 call writeLineAcc16
  85 ;test3.j(19)     if (6561 / 729 == 9) println (11); else println (999);
  86 acc16= constant 6561
  87 acc16/ constant 729
  88 acc8= constant 9
  89 acc16CompareAcc8
  90 brne 94
  91 acc8= constant 11
  92 call writeLineAcc8
  93 br 97
  94 acc16= constant 999
  95 call writeLineAcc16
  96 ;test3.j(20)     a = 13;
  97 acc8= constant 13
  98 acc8=> variable 0
  99 ;test3.j(21)     a--;
 100 decr16 variable 0
 101 ;test3.j(22)     println(a);
 102 acc16= variable 0
 103 call writeLineAcc16
 104 ;test3.j(23)     a++;
 105 incr16 variable 0
 106 ;test3.j(24)     println(a);
 107 acc16= variable 0
 108 call writeLineAcc16
 109 ;test3.j(25)     println(14);
 110 acc8= constant 14
 111 call writeLineAcc8
 112 ;test3.j(26)     println("Klaar");
 113 acc16= constant 118
 114 writeLineString
 115 ;test3.j(27)   }
 116 ;test3.j(28) }
 117 stop
 118 stringConstant 0 = "Klaar"
