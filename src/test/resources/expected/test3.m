   0 call 8
   1 stop
   2 ;test3.j(0) /* Program to test multiplication */
   3 ;test3.j(1) class TestMultiply {
   4 class TestMultiply []
   5 ;test3.j(2)   private static word a;
   6 ;test3.j(3) 
   7 ;test3.j(4)   public static void main() {
   8 method main [public, static] void ()
   9 <basePointer
  10 basePointer= stackPointer
  11 stackPointer+ constant 0
  12 ;test3.j(5)     println(1 * 0);
  13 acc8= constant 1
  14 acc8* constant 0
  15 writeLineAcc8
  16 ;test3.j(6)     println(1 * 1);
  17 acc8= constant 1
  18 acc8* constant 1
  19 writeLineAcc8
  20 ;test3.j(7)     println(2 * 1);
  21 acc8= constant 2
  22 acc8* constant 1
  23 writeLineAcc8
  24 ;test3.j(8)     println(1 * 3);
  25 acc8= constant 1
  26 acc8* constant 3
  27 writeLineAcc8
  28 ;test3.j(9)     a = 2 * 2;
  29 acc8= constant 2
  30 acc8* constant 2
  31 acc8=> variable 0
  32 ;test3.j(10)     println(a);
  33 acc16= variable 0
  34 writeLineAcc16
  35 ;test3.j(11)     a = 1;
  36 acc8= constant 1
  37 acc8=> variable 0
  38 ;test3.j(12)     println(a * 5);
  39 acc16= variable 0
  40 acc16* constant 5
  41 writeLineAcc16
  42 ;test3.j(13)     a = 2;
  43 acc8= constant 2
  44 acc8=> variable 0
  45 ;test3.j(14)     println(3 * a);
  46 acc8= constant 3
  47 acc8ToAcc16
  48 acc16* variable 0
  49 writeLineAcc16
  50 ;test3.j(15)     if (7 * 5 == 35) println (7); else println (999);
  51 acc8= constant 7
  52 acc8* constant 5
  53 acc8Comp constant 35
  54 brne 60
  55 acc8= constant 7
  56 writeLineAcc8
  57 br 63
  58 acc16= constant 999
  59 writeLineAcc16
  60 ;test3.j(16)     if (2 * 9 * 9 == 162) println (8); else println (999);
  61 acc8= constant 2
  62 acc8* constant 9
  63 acc8* constant 9
  64 acc8Comp constant 162
  65 brne 73
  66 acc8= constant 8
  67 writeLineAcc8
  68 br 76
  69 acc16= constant 999
  70 writeLineAcc16
  71 ;test3.j(17)     if (729 == 729) println (9); else println (999);
  72 acc16= constant 729
  73 acc16Comp constant 729
  74 brne 82
  75 acc8= constant 9
  76 writeLineAcc8
  77 br 85
  78 acc16= constant 999
  79 writeLineAcc16
  80 ;test3.j(18)     if (729 * 9 == 6561) println (10); else println (999);
  81 acc16= constant 729
  82 acc16* constant 9
  83 acc16Comp constant 6561
  84 brne 94
  85 acc8= constant 10
  86 writeLineAcc8
  87 br 97
  88 acc16= constant 999
  89 writeLineAcc16
  90 ;test3.j(19)     if (6561 / 729 == 9) println (11); else println (999);
  91 acc16= constant 6561
  92 acc16/ constant 729
  93 acc8= constant 9
  94 acc16CompareAcc8
  95 brne 107
  96 acc8= constant 11
  97 writeLineAcc8
  98 br 110
  99 acc16= constant 999
 100 writeLineAcc16
 101 ;test3.j(20)     a = 13;
 102 acc8= constant 13
 103 acc8=> variable 0
 104 ;test3.j(21)     a--;
 105 decr16 variable 0
 106 ;test3.j(22)     println(a);
 107 acc16= variable 0
 108 writeLineAcc16
 109 ;test3.j(23)     a++;
 110 incr16 variable 0
 111 ;test3.j(24)     println(a);
 112 acc16= variable 0
 113 writeLineAcc16
 114 ;test3.j(25)     println(14);
 115 acc8= constant 14
 116 writeLineAcc8
 117 ;test3.j(26)     println("Klaar");
 118 acc16= stringconstant 125
 119 writeLineString
 120 stackPointer= basePointer
 121 basePointer<
 122 return
 123 ;test3.j(27)   }
 124 ;test3.j(28) }
 125 stringConstant 0 = "Klaar"
