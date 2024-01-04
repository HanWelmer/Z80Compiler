   0 ;test3.j(0) /* Program to test multiplication */
   1 ;test3.j(1) class TestMultiply {
   2 ;test3.j(2)   private static word a;
   3 ;test3.j(3) 
   4 ;test3.j(4)   public static void main() {
   5 ;test3.j(5)     println(1 * 0);
   6 acc8= constant 1
   7 acc8* constant 0
   8 call writeLineAcc8
   9 ;test3.j(6)     println(1 * 1);
  10 acc8= constant 1
  11 acc8* constant 1
  12 call writeLineAcc8
  13 ;test3.j(7)     println(2 * 1);
  14 acc8= constant 2
  15 acc8* constant 1
  16 call writeLineAcc8
  17 ;test3.j(8)     println(1 * 3);
  18 acc8= constant 1
  19 acc8* constant 3
  20 call writeLineAcc8
  21 ;test3.j(9)     a = 2 * 2;
  22 acc8= constant 2
  23 acc8* constant 2
  24 acc8=> variable 0
  25 ;test3.j(10)     println(a);
  26 acc16= variable 0
  27 call writeLineAcc16
  28 ;test3.j(11)     a = 1;
  29 acc8= constant 1
  30 acc8=> variable 0
  31 ;test3.j(12)     println(a * 5);
  32 acc16= variable 0
  33 acc16* constant 5
  34 call writeLineAcc16
  35 ;test3.j(13)     a = 2;
  36 acc8= constant 2
  37 acc8=> variable 0
  38 ;test3.j(14)     println(3 * a);
  39 acc8= constant 3
  40 acc8ToAcc16
  41 acc16* variable 0
  42 call writeLineAcc16
  43 ;test3.j(15)     if (7 * 5 == 35) println (7); else println (999);
  44 acc8= constant 7
  45 acc8* constant 5
  46 acc8Comp constant 35
  47 brne 51
  48 acc8= constant 7
  49 call writeLineAcc8
  50 br 54
  51 acc16= constant 999
  52 call writeLineAcc16
  53 ;test3.j(16)     if (2 * 9 * 9 == 162) println (8); else println (999);
  54 acc8= constant 2
  55 acc8* constant 9
  56 acc8* constant 9
  57 acc8Comp constant 162
  58 brne 62
  59 acc8= constant 8
  60 call writeLineAcc8
  61 br 65
  62 acc16= constant 999
  63 call writeLineAcc16
  64 ;test3.j(17)     if (729 == 729) println (9); else println (999);
  65 acc16= constant 729
  66 acc16Comp constant 729
  67 brne 71
  68 acc8= constant 9
  69 call writeLineAcc8
  70 br 74
  71 acc16= constant 999
  72 call writeLineAcc16
  73 ;test3.j(18)     if (729 * 9 == 6561) println (10); else println (999);
  74 acc16= constant 729
  75 acc16* constant 9
  76 acc16Comp constant 6561
  77 brne 81
  78 acc8= constant 10
  79 call writeLineAcc8
  80 br 84
  81 acc16= constant 999
  82 call writeLineAcc16
  83 ;test3.j(19)     if (6561 / 729 == 9) println (11); else println (999);
  84 acc16= constant 6561
  85 acc16/ constant 729
  86 acc8= constant 9
  87 acc16CompareAcc8
  88 brne 92
  89 acc8= constant 11
  90 call writeLineAcc8
  91 br 95
  92 acc16= constant 999
  93 call writeLineAcc16
  94 ;test3.j(20)     a = 13;
  95 acc8= constant 13
  96 acc8=> variable 0
  97 ;test3.j(21)     a--;
  98 decr16 variable 0
  99 ;test3.j(22)     println(a);
 100 acc16= variable 0
 101 call writeLineAcc16
 102 ;test3.j(23)     a++;
 103 incr16 variable 0
 104 ;test3.j(24)     println(a);
 105 acc16= variable 0
 106 call writeLineAcc16
 107 ;test3.j(25)     println(14);
 108 acc8= constant 14
 109 call writeLineAcc8
 110 ;test3.j(26)     println("Klaar");
 111 acc16= constant 116
 112 writeLineString
 113 ;test3.j(27)   }
 114 ;test3.j(28) }
 115 stop
 116 stringConstant 0 = "Klaar"
