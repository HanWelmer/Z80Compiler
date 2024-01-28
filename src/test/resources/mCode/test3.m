   0 ;test3.j(0) /* Program to test multiplication */
   1 ;test3.j(1) class TestMultiply {
   2 ;test3.j(2)   private static word a;
   3 ;test3.j(3) 
   4 ;test3.j(4)   public static void main() {
   5 method main [publicLexeme, staticLexeme] voidLexeme
   6 ;test3.j(5)     println(1 * 0);
   7 acc8= constant 1
   8 acc8* constant 0
   9 call writeLineAcc8
  10 ;test3.j(6)     println(1 * 1);
  11 acc8= constant 1
  12 acc8* constant 1
  13 call writeLineAcc8
  14 ;test3.j(7)     println(2 * 1);
  15 acc8= constant 2
  16 acc8* constant 1
  17 call writeLineAcc8
  18 ;test3.j(8)     println(1 * 3);
  19 acc8= constant 1
  20 acc8* constant 3
  21 call writeLineAcc8
  22 ;test3.j(9)     a = 2 * 2;
  23 acc8= constant 2
  24 acc8* constant 2
  25 acc8=> variable 0
  26 ;test3.j(10)     println(a);
  27 acc16= variable 0
  28 call writeLineAcc16
  29 ;test3.j(11)     a = 1;
  30 acc8= constant 1
  31 acc8=> variable 0
  32 ;test3.j(12)     println(a * 5);
  33 acc16= variable 0
  34 acc16* constant 5
  35 call writeLineAcc16
  36 ;test3.j(13)     a = 2;
  37 acc8= constant 2
  38 acc8=> variable 0
  39 ;test3.j(14)     println(3 * a);
  40 acc8= constant 3
  41 acc8ToAcc16
  42 acc16* variable 0
  43 call writeLineAcc16
  44 ;test3.j(15)     if (7 * 5 == 35) println (7); else println (999);
  45 acc8= constant 7
  46 acc8* constant 5
  47 acc8Comp constant 35
  48 brne 52
  49 acc8= constant 7
  50 call writeLineAcc8
  51 br 55
  52 acc16= constant 999
  53 call writeLineAcc16
  54 ;test3.j(16)     if (2 * 9 * 9 == 162) println (8); else println (999);
  55 acc8= constant 2
  56 acc8* constant 9
  57 acc8* constant 9
  58 acc8Comp constant 162
  59 brne 63
  60 acc8= constant 8
  61 call writeLineAcc8
  62 br 66
  63 acc16= constant 999
  64 call writeLineAcc16
  65 ;test3.j(17)     if (729 == 729) println (9); else println (999);
  66 acc16= constant 729
  67 acc16Comp constant 729
  68 brne 72
  69 acc8= constant 9
  70 call writeLineAcc8
  71 br 75
  72 acc16= constant 999
  73 call writeLineAcc16
  74 ;test3.j(18)     if (729 * 9 == 6561) println (10); else println (999);
  75 acc16= constant 729
  76 acc16* constant 9
  77 acc16Comp constant 6561
  78 brne 82
  79 acc8= constant 10
  80 call writeLineAcc8
  81 br 85
  82 acc16= constant 999
  83 call writeLineAcc16
  84 ;test3.j(19)     if (6561 / 729 == 9) println (11); else println (999);
  85 acc16= constant 6561
  86 acc16/ constant 729
  87 acc8= constant 9
  88 acc16CompareAcc8
  89 brne 93
  90 acc8= constant 11
  91 call writeLineAcc8
  92 br 96
  93 acc16= constant 999
  94 call writeLineAcc16
  95 ;test3.j(20)     a = 13;
  96 acc8= constant 13
  97 acc8=> variable 0
  98 ;test3.j(21)     a--;
  99 decr16 variable 0
 100 ;test3.j(22)     println(a);
 101 acc16= variable 0
 102 call writeLineAcc16
 103 ;test3.j(23)     a++;
 104 incr16 variable 0
 105 ;test3.j(24)     println(a);
 106 acc16= variable 0
 107 call writeLineAcc16
 108 ;test3.j(25)     println(14);
 109 acc8= constant 14
 110 call writeLineAcc8
 111 ;test3.j(26)     println("Klaar");
 112 acc16= constant 117
 113 writeLineString
 114 ;test3.j(27)   }
 115 ;test3.j(28) }
 116 stop
 117 stringConstant 0 = "Klaar"
