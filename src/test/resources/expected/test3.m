   0 ;test3.j(0) /* Program to test multiplication */
   1 ;test3.j(1) class TestMultiply {
   2 ;test3.j(2)   private static word a;
   3 ;test3.j(3)   public static void main() {
   4 ;test3.j(4)     println(1 * 0);
   5 acc8= constant 1
   6 acc8* constant 0
   7 call writeLineAcc8
   8 ;test3.j(5)     println(1 * 1);
   9 acc8= constant 1
  10 acc8* constant 1
  11 call writeLineAcc8
  12 ;test3.j(6)     println(2 * 1);
  13 acc8= constant 2
  14 acc8* constant 1
  15 call writeLineAcc8
  16 ;test3.j(7)     println(1 * 3);
  17 acc8= constant 1
  18 acc8* constant 3
  19 call writeLineAcc8
  20 ;test3.j(8)     a = 2 * 2;
  21 acc8= constant 2
  22 acc8* constant 2
  23 acc8=> variable 0
  24 ;test3.j(9)     println(a);
  25 acc16= variable 0
  26 call writeLineAcc16
  27 ;test3.j(10)     a = 1;
  28 acc8= constant 1
  29 acc8=> variable 0
  30 ;test3.j(11)     println(a * 5);
  31 acc16= variable 0
  32 acc16* constant 5
  33 call writeLineAcc16
  34 ;test3.j(12)     a = 2;
  35 acc8= constant 2
  36 acc8=> variable 0
  37 ;test3.j(13)     println(3 * a);
  38 acc8= constant 3
  39 acc8ToAcc16
  40 acc16* variable 0
  41 call writeLineAcc16
  42 ;test3.j(14)     if (7 * 5 == 35) println (7); else println (999);
  43 acc8= constant 7
  44 acc8* constant 5
  45 acc8Comp constant 35
  46 brne 50
  47 acc8= constant 7
  48 call writeLineAcc8
  49 br 53
  50 acc16= constant 999
  51 call writeLineAcc16
  52 ;test3.j(15)     if (2 * 9 * 9 == 162) println (8); else println (999);
  53 acc8= constant 2
  54 acc8* constant 9
  55 acc8* constant 9
  56 acc8Comp constant 162
  57 brne 61
  58 acc8= constant 8
  59 call writeLineAcc8
  60 br 64
  61 acc16= constant 999
  62 call writeLineAcc16
  63 ;test3.j(16)     if (729 == 729) println (9); else println (999);
  64 acc16= constant 729
  65 acc16Comp constant 729
  66 brne 70
  67 acc8= constant 9
  68 call writeLineAcc8
  69 br 73
  70 acc16= constant 999
  71 call writeLineAcc16
  72 ;test3.j(17)     if (729 * 9 == 6561) println (10); else println (999);
  73 acc16= constant 729
  74 acc16* constant 9
  75 acc16Comp constant 6561
  76 brne 80
  77 acc8= constant 10
  78 call writeLineAcc8
  79 br 83
  80 acc16= constant 999
  81 call writeLineAcc16
  82 ;test3.j(18)     if (6561 / 729 == 9) println (11); else println (999);
  83 acc16= constant 6561
  84 acc16/ constant 729
  85 acc8= constant 9
  86 acc16CompareAcc8
  87 brne 91
  88 acc8= constant 11
  89 call writeLineAcc8
  90 br 94
  91 acc16= constant 999
  92 call writeLineAcc16
  93 ;test3.j(19)     a = 13;
  94 acc8= constant 13
  95 acc8=> variable 0
  96 ;test3.j(20)     a--;
  97 decr16 variable 0
  98 ;test3.j(21)     println(a);
  99 acc16= variable 0
 100 call writeLineAcc16
 101 ;test3.j(22)     a++;
 102 incr16 variable 0
 103 ;test3.j(23)     println(a);
 104 acc16= variable 0
 105 call writeLineAcc16
 106 ;test3.j(24)     println(14);
 107 acc8= constant 14
 108 call writeLineAcc8
 109 ;test3.j(25)     println("Klaar");
 110 acc16= constant 115
 111 writeLineString
 112 ;test3.j(26)   }
 113 ;test3.j(27) }
 114 stop
 115 stringConstant 0 = "Klaar"
