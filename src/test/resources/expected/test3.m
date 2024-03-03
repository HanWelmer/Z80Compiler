   0 call 8
   1 stop
   2 ;test3.j(0) /* Program to test multiplication */
   3 ;test3.j(1) class TestMultiply {
   4 class TestMultiply []
   5 ;test3.j(2)   private static word a;
   6 ;test3.j(3) 
   7 ;test3.j(4)   public static void main() {
   8 method main [public, static] void
   9 ;test3.j(5)     println(1 * 0);
  10 acc8= constant 1
  11 acc8* constant 0
  12 call writeLineAcc8
  13 ;test3.j(6)     println(1 * 1);
  14 acc8= constant 1
  15 acc8* constant 1
  16 call writeLineAcc8
  17 ;test3.j(7)     println(2 * 1);
  18 acc8= constant 2
  19 acc8* constant 1
  20 call writeLineAcc8
  21 ;test3.j(8)     println(1 * 3);
  22 acc8= constant 1
  23 acc8* constant 3
  24 call writeLineAcc8
  25 ;test3.j(9)     a = 2 * 2;
  26 acc8= constant 2
  27 acc8* constant 2
  28 acc8=> variable 0
  29 ;test3.j(10)     println(a);
  30 acc16= variable 0
  31 call writeLineAcc16
  32 ;test3.j(11)     a = 1;
  33 acc8= constant 1
  34 acc8=> variable 0
  35 ;test3.j(12)     println(a * 5);
  36 acc16= variable 0
  37 acc16* constant 5
  38 call writeLineAcc16
  39 ;test3.j(13)     a = 2;
  40 acc8= constant 2
  41 acc8=> variable 0
  42 ;test3.j(14)     println(3 * a);
  43 acc8= constant 3
  44 acc8ToAcc16
  45 acc16* variable 0
  46 call writeLineAcc16
  47 ;test3.j(15)     if (7 * 5 == 35) println (7); else println (999);
  48 acc8= constant 7
  49 acc8* constant 5
  50 acc8Comp constant 35
  51 brne 57
  52 acc8= constant 7
  53 call writeLineAcc8
  54 br 60
  55 acc16= constant 999
  56 call writeLineAcc16
  57 ;test3.j(16)     if (2 * 9 * 9 == 162) println (8); else println (999);
  58 acc8= constant 2
  59 acc8* constant 9
  60 acc8* constant 9
  61 acc8Comp constant 162
  62 brne 70
  63 acc8= constant 8
  64 call writeLineAcc8
  65 br 73
  66 acc16= constant 999
  67 call writeLineAcc16
  68 ;test3.j(17)     if (729 == 729) println (9); else println (999);
  69 acc16= constant 729
  70 acc16Comp constant 729
  71 brne 79
  72 acc8= constant 9
  73 call writeLineAcc8
  74 br 82
  75 acc16= constant 999
  76 call writeLineAcc16
  77 ;test3.j(18)     if (729 * 9 == 6561) println (10); else println (999);
  78 acc16= constant 729
  79 acc16* constant 9
  80 acc16Comp constant 6561
  81 brne 91
  82 acc8= constant 10
  83 call writeLineAcc8
  84 br 94
  85 acc16= constant 999
  86 call writeLineAcc16
  87 ;test3.j(19)     if (6561 / 729 == 9) println (11); else println (999);
  88 acc16= constant 6561
  89 acc16/ constant 729
  90 acc8= constant 9
  91 acc16CompareAcc8
  92 brne 104
  93 acc8= constant 11
  94 call writeLineAcc8
  95 br 107
  96 acc16= constant 999
  97 call writeLineAcc16
  98 ;test3.j(20)     a = 13;
  99 acc8= constant 13
 100 acc8=> variable 0
 101 ;test3.j(21)     a--;
 102 decr16 variable 0
 103 ;test3.j(22)     println(a);
 104 acc16= variable 0
 105 call writeLineAcc16
 106 ;test3.j(23)     a++;
 107 incr16 variable 0
 108 ;test3.j(24)     println(a);
 109 acc16= variable 0
 110 call writeLineAcc16
 111 ;test3.j(25)     println(14);
 112 acc8= constant 14
 113 call writeLineAcc8
 114 ;test3.j(26)     println("Klaar");
 115 acc16= stringconstant 120
 116 writeLineString
 117 return
 118 ;test3.j(27)   }
 119 ;test3.j(28) }
 120 stringConstant 0 = "Klaar"
