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
  13 ;test12.j(8)   static String str;
  14 ;test12.j(9) 
  15 ;test12.j(10)   public static void main() {
  16 method main [public, static] void
  17 ;test12.j(11)     println(zero);
  18 acc16= variable 0
  19 call writeLineAcc16
  20 ;test12.j(12)     println(one);
  21 acc8= variable 2
  22 call writeLineAcc8
  23 ;test12.j(13)     println(2);
  24 acc8= constant 2
  25 call writeLineAcc8
  26 ;test12.j(14)     println("3  Drie keer.");
  27 acc16= constant 128
  28 writeLineString
  29 ;test12.j(15)     println("3  Drie keer.");
  30 acc16= constant 128
  31 writeLineString
  32 ;test12.j(16)     println("3  Drie keer.");
  33 acc16= constant 128
  34 writeLineString
  35 ;test12.j(17)     println("4  Hier klinkt een bel\a en dan gaan we door.");
  36 acc16= constant 129
  37 writeLineString
  38 ;test12.j(18)     println("5  Dit is pagina 1.\f   En dit is pagina 2.");
  39 acc16= constant 130
  40 writeLineString
  41 ;test12.j(19)     println("6  Dit is gu\boed.");
  42 acc16= constant 131
  43 writeLineString
  44 ;test12.j(20)     println("7  Getal na een tab\t1.");
  45 acc16= constant 132
  46 writeLineString
  47 ;test12.j(21)     println("8  Dit zie je niet\r8  Dit zie je wel.");
  48 acc16= constant 133
  49 writeLineString
  50 ;test12.j(22)     println("9  Dit is regel 1.\n   En dit regel 2.");
  51 acc16= constant 134
  52 writeLineString
  53 ;test12.j(23)     println("10 Hier komt een dubbele quote \".");
  54 acc16= constant 135
  55 writeLineString
  56 ;test12.j(24)     println("11 Hier komt een single quote \'.");
  57 acc16= constant 136
  58 writeLineString
  59 ;test12.j(25)     println("12 Hier komt een backslash \\.");
  60 acc16= constant 137
  61 writeLineString
  62 ;test12.j(26)     str = "13 Hallo wereld.";
  63 acc16= constant 138
  64 acc16=> variable 3
  65 ;test12.j(27)     println(str);
  66 acc16= variable 3
  67 writeLineString
  68 ;test12.j(28)     println(7 * 2);
  69 acc8= constant 7
  70 acc8* constant 2
  71 call writeLineAcc8
  72 ;test12.j(29)     println(7 + 2 * 4);
  73 acc8= constant 7
  74 <acc8= constant 2
  75 acc8* constant 4
  76 acc8+ unstack8
  77 call writeLineAcc8
  78 ;test12.j(30)     println(2 * 6 + 4);
  79 acc8= constant 2
  80 acc8* constant 6
  81 acc8+ constant 4
  82 call writeLineAcc8
  83 ;test12.j(31)     println(9 + 2 * (1 + 3));
  84 acc8= constant 9
  85 <acc8= constant 2
  86 <acc8= constant 1
  87 acc8+ constant 3
  88 acc8* unstack8
  89 acc8+ unstack8
  90 call writeLineAcc8
  91 ;test12.j(32)     println("18 Hallo" + " wereld.");
  92 acc16= constant 139
  93 writeString
  94 acc16= constant 140
  95 writeLineString
  96 ;test12.j(33)     println("19 Nog" + " een" + " bericht.");
  97 acc16= constant 141
  98 writeString
  99 acc16= constant 142
 100 writeString
 101 acc16= constant 143
 102 writeLineString
 103 ;test12.j(34)     println("12 + 8 = " + 20);
 104 acc16= constant 144
 105 writeString
 106 acc8= constant 20
 107 call writeLineAcc8
 108 ;test12.j(35)     println("7 * 3 = " + (7 * 3));
 109 acc16= constant 145
 110 writeString
 111 acc8= constant 7
 112 acc8* constant 3
 113 call writeLineAcc8
 114 ;test12.j(36)     println("10 + 12 = " + (10 + 12) + ".");
 115 acc16= constant 146
 116 writeString
 117 acc8= constant 10
 118 acc8+ constant 12
 119 call writeAcc8
 120 acc16= constant 147
 121 writeLineString
 122 ;test12.j(37)     println("Klaar");
 123 acc16= constant 148
 124 writeLineString
 125 ;test12.j(38)   }
 126 ;test12.j(39) }
 127 stop
 128 stringConstant 0 = "3  Drie keer."
 129 stringConstant 1 = "4  Hier klinkt een bel en dan gaan we door."
 130 stringConstant 2 = "5  Dit is pagina 1.
   En dit is pagina 2."
 131 stringConstant 3 = "6  Dit is guoed."
 132 stringConstant 4 = "7  Getal na een tab	1."
 133 stringConstant 5 = "8  Dit zie je niet8  Dit zie je wel."
 134 stringConstant 6 = "9  Dit is regel 1.
   En dit regel 2."
 135 stringConstant 7 = "10 Hier komt een dubbele quote "."
 136 stringConstant 8 = "11 Hier komt een single quote '."
 137 stringConstant 9 = "12 Hier komt een backslash \."
 138 stringConstant 10 = "13 Hallo wereld."
 139 stringConstant 11 = "18 Hallo"
 140 stringConstant 12 = " wereld."
 141 stringConstant 13 = "19 Nog"
 142 stringConstant 14 = " een"
 143 stringConstant 15 = " bericht."
 144 stringConstant 16 = "12 + 8 = "
 145 stringConstant 17 = "7 * 3 = "
 146 stringConstant 18 = "10 + 12 = "
 147 stringConstant 19 = "."
 148 stringConstant 20 = "Klaar"
