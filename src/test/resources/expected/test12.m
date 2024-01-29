   0 ;test12.j(0) /*
   1 ;test12.j(1)  * A small program in the miniJava language.
   2 ;test12.j(2)  * Test something
   3 ;test12.j(3)  */
   4 ;test12.j(4) class TestWrite {
   5 class TestWrite []
   6 ;test12.j(5)   private static word zero = 0;
   7 acc8= constant 0
   8 acc8=> variable 0
   9 ;test12.j(6)   private static byte one = 1;
  10 acc8= constant 1
  11 acc8=> variable 2
  12 ;test12.j(7) 
  13 ;test12.j(8)   public static void main() {
  14 method main [public, static] void
  15 ;test12.j(9)     println(zero);
  16 acc16= variable 0
  17 call writeLineAcc16
  18 ;test12.j(10)     println(one);
  19 acc8= variable 2
  20 call writeLineAcc8
  21 ;test12.j(11)     println(2);
  22 acc8= constant 2
  23 call writeLineAcc8
  24 ;test12.j(12)     println("3  Drie keer.");
  25 acc16= constant 126
  26 writeLineString
  27 ;test12.j(13)     println("3  Drie keer.");
  28 acc16= constant 126
  29 writeLineString
  30 ;test12.j(14)     println("3  Drie keer.");
  31 acc16= constant 126
  32 writeLineString
  33 ;test12.j(15)     println("4  Hier klinkt een bel\a en dan gaan we door.");
  34 acc16= constant 127
  35 writeLineString
  36 ;test12.j(16)     println("5  Dit is pagina 1.\f   En dit is pagina 2.");
  37 acc16= constant 128
  38 writeLineString
  39 ;test12.j(17)     println("6  Dit is gu\boed.");
  40 acc16= constant 129
  41 writeLineString
  42 ;test12.j(18)     println("7  Getal na een tab\t1.");
  43 acc16= constant 130
  44 writeLineString
  45 ;test12.j(19)     println("8  Dit zie je niet\r8  Dit zie je wel.");
  46 acc16= constant 131
  47 writeLineString
  48 ;test12.j(20)     println("9  Dit is regel 1.\n   En dit regel 2.");
  49 acc16= constant 132
  50 writeLineString
  51 ;test12.j(21)     println("10 Hier komt een dubbele quote \".");
  52 acc16= constant 133
  53 writeLineString
  54 ;test12.j(22)     println("11 Hier komt een single quote \'.");
  55 acc16= constant 134
  56 writeLineString
  57 ;test12.j(23)     println("12 Hier komt een backslash \\.");
  58 acc16= constant 135
  59 writeLineString
  60 ;test12.j(24)     String str = "13 Hallo wereld.";
  61 acc16= constant 136
  62 acc16=> variable 3
  63 ;test12.j(25)     println(str);
  64 acc16= variable 3
  65 writeLineString
  66 ;test12.j(26)     println(7 * 2);
  67 acc8= constant 7
  68 acc8* constant 2
  69 call writeLineAcc8
  70 ;test12.j(27)     println(7 + 2 * 4);
  71 acc8= constant 7
  72 <acc8= constant 2
  73 acc8* constant 4
  74 acc8+ unstack8
  75 call writeLineAcc8
  76 ;test12.j(28)     println(2 * 6 + 4);
  77 acc8= constant 2
  78 acc8* constant 6
  79 acc8+ constant 4
  80 call writeLineAcc8
  81 ;test12.j(29)     println(9 + 2 * (1 + 3));
  82 acc8= constant 9
  83 <acc8= constant 2
  84 <acc8= constant 1
  85 acc8+ constant 3
  86 acc8* unstack8
  87 acc8+ unstack8
  88 call writeLineAcc8
  89 ;test12.j(30)     println("18 Hallo" + " wereld.");
  90 acc16= constant 137
  91 writeString
  92 acc16= constant 138
  93 writeLineString
  94 ;test12.j(31)     println("19 Nog" + " een" + " bericht.");
  95 acc16= constant 139
  96 writeString
  97 acc16= constant 140
  98 writeString
  99 acc16= constant 141
 100 writeLineString
 101 ;test12.j(32)     println("12 + 8 = " + 20);
 102 acc16= constant 142
 103 writeString
 104 acc8= constant 20
 105 call writeLineAcc8
 106 ;test12.j(33)     println("7 * 3 = " + (7 * 3));
 107 acc16= constant 143
 108 writeString
 109 acc8= constant 7
 110 acc8* constant 3
 111 call writeLineAcc8
 112 ;test12.j(34)     println("10 + 12 = " + (10 + 12) + ".");
 113 acc16= constant 144
 114 writeString
 115 acc8= constant 10
 116 acc8+ constant 12
 117 call writeAcc8
 118 acc16= constant 145
 119 writeLineString
 120 ;test12.j(35)     println("Klaar");
 121 acc16= constant 146
 122 writeLineString
 123 ;test12.j(36)   }
 124 ;test12.j(37) }
 125 stop
 126 stringConstant 0 = "3  Drie keer."
 127 stringConstant 1 = "4  Hier klinkt een bel en dan gaan we door."
 128 stringConstant 2 = "5  Dit is pagina 1.
   En dit is pagina 2."
 129 stringConstant 3 = "6  Dit is guoed."
 130 stringConstant 4 = "7  Getal na een tab  1."
 131 stringConstant 5 = "8  Dit zie je niet
8  Dit zie je wel."
 132 stringConstant 6 = "9  Dit is regel 1.
   En dit regel 2."
 133 stringConstant 7 = "10 Hier komt een dubbele quote "."
 134 stringConstant 8 = "11 Hier komt een single quote '."
 135 stringConstant 9 = "12 Hier komt een backslash \."
 136 stringConstant 10 = "13 Hallo wereld."
 137 stringConstant 11 = "18 Hallo"
 138 stringConstant 12 = " wereld."
 139 stringConstant 13 = "19 Nog"
 140 stringConstant 14 = " een"
 141 stringConstant 15 = " bericht."
 142 stringConstant 16 = "12 + 8 = "
 143 stringConstant 17 = "7 * 3 = "
 144 stringConstant 18 = "10 + 12 = "
 145 stringConstant 19 = "."
 146 stringConstant 20 = "Klaar"
