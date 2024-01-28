   0 ;test12.j(0) /*
   1 ;test12.j(1)  * A small program in the miniJava language.
   2 ;test12.j(2)  * Test something
   3 ;test12.j(3)  */
   4 ;test12.j(4) class TestWrite {
   5 ;test12.j(5)   private static word zero = 0;
   6 acc8= constant 0
   7 acc8=> variable 0
   8 ;test12.j(6)   private static byte one = 1;
   9 acc8= constant 1
  10 acc8=> variable 2
  11 ;test12.j(7) 
  12 ;test12.j(8)   public static void main() {
  13 method main [staticLexeme] voidLexeme
  14 ;test12.j(9)     println(zero);
  15 acc16= variable 0
  16 call writeLineAcc16
  17 ;test12.j(10)     println(one);
  18 acc8= variable 2
  19 call writeLineAcc8
  20 ;test12.j(11)     println(2);
  21 acc8= constant 2
  22 call writeLineAcc8
  23 ;test12.j(12)     println("3  Drie keer.");
  24 acc16= constant 125
  25 writeLineString
  26 ;test12.j(13)     println("3  Drie keer.");
  27 acc16= constant 125
  28 writeLineString
  29 ;test12.j(14)     println("3  Drie keer.");
  30 acc16= constant 125
  31 writeLineString
  32 ;test12.j(15)     println("4  Hier klinkt een bel\a en dan gaan we door.");
  33 acc16= constant 126
  34 writeLineString
  35 ;test12.j(16)     println("5  Dit is pagina 1.\f   En dit is pagina 2.");
  36 acc16= constant 127
  37 writeLineString
  38 ;test12.j(17)     println("6  Dit is gu\boed.");
  39 acc16= constant 128
  40 writeLineString
  41 ;test12.j(18)     println("7  Getal na een tab\t1.");
  42 acc16= constant 129
  43 writeLineString
  44 ;test12.j(19)     println("8  Dit zie je niet\r8  Dit zie je wel.");
  45 acc16= constant 130
  46 writeLineString
  47 ;test12.j(20)     println("9  Dit is regel 1.\n   En dit regel 2.");
  48 acc16= constant 131
  49 writeLineString
  50 ;test12.j(21)     println("10 Hier komt een dubbele quote \".");
  51 acc16= constant 132
  52 writeLineString
  53 ;test12.j(22)     println("11 Hier komt een single quote \'.");
  54 acc16= constant 133
  55 writeLineString
  56 ;test12.j(23)     println("12 Hier komt een backslash \\.");
  57 acc16= constant 134
  58 writeLineString
  59 ;test12.j(24)     String str = "13 Hallo wereld.";
  60 acc16= constant 135
  61 acc16=> variable 3
  62 ;test12.j(25)     println(str);
  63 acc16= variable 3
  64 writeLineString
  65 ;test12.j(26)     println(7 * 2);
  66 acc8= constant 7
  67 acc8* constant 2
  68 call writeLineAcc8
  69 ;test12.j(27)     println(7 + 2 * 4);
  70 acc8= constant 7
  71 <acc8= constant 2
  72 acc8* constant 4
  73 acc8+ unstack8
  74 call writeLineAcc8
  75 ;test12.j(28)     println(2 * 6 + 4);
  76 acc8= constant 2
  77 acc8* constant 6
  78 acc8+ constant 4
  79 call writeLineAcc8
  80 ;test12.j(29)     println(9 + 2 * (1 + 3));
  81 acc8= constant 9
  82 <acc8= constant 2
  83 <acc8= constant 1
  84 acc8+ constant 3
  85 acc8* unstack8
  86 acc8+ unstack8
  87 call writeLineAcc8
  88 ;test12.j(30)     println("18 Hallo" + " wereld.");
  89 acc16= constant 136
  90 writeString
  91 acc16= constant 137
  92 writeLineString
  93 ;test12.j(31)     println("19 Nog" + " een" + " bericht.");
  94 acc16= constant 138
  95 writeString
  96 acc16= constant 139
  97 writeString
  98 acc16= constant 140
  99 writeLineString
 100 ;test12.j(32)     println("12 + 8 = " + 20);
 101 acc16= constant 141
 102 writeString
 103 acc8= constant 20
 104 call writeLineAcc8
 105 ;test12.j(33)     println("7 * 3 = " + (7 * 3));
 106 acc16= constant 142
 107 writeString
 108 acc8= constant 7
 109 acc8* constant 3
 110 call writeLineAcc8
 111 ;test12.j(34)     println("10 + 12 = " + (10 + 12) + ".");
 112 acc16= constant 143
 113 writeString
 114 acc8= constant 10
 115 acc8+ constant 12
 116 call writeAcc8
 117 acc16= constant 144
 118 writeLineString
 119 ;test12.j(35)     println("Klaar");
 120 acc16= constant 145
 121 writeLineString
 122 ;test12.j(36)   }
 123 ;test12.j(37) }
 124 stop
 125 stringConstant 0 = "3  Drie keer."
 126 stringConstant 1 = "4  Hier klinkt een bel en dan gaan we door."
 127 stringConstant 2 = "5  Dit is pagina 1.
   En dit is pagina 2."
 128 stringConstant 3 = "6  Dit is guoed."
 129 stringConstant 4 = "7  Getal na een tab	1."
 130 stringConstant 5 = "8  Dit zie je niet8  Dit zie je wel."
 131 stringConstant 6 = "9  Dit is regel 1.
   En dit regel 2."
 132 stringConstant 7 = "10 Hier komt een dubbele quote "."
 133 stringConstant 8 = "11 Hier komt een single quote '."
 134 stringConstant 9 = "12 Hier komt een backslash \."
 135 stringConstant 10 = "13 Hallo wereld."
 136 stringConstant 11 = "18 Hallo"
 137 stringConstant 12 = " wereld."
 138 stringConstant 13 = "19 Nog"
 139 stringConstant 14 = " een"
 140 stringConstant 15 = " bericht."
 141 stringConstant 16 = "12 + 8 = "
 142 stringConstant 17 = "7 * 3 = "
 143 stringConstant 18 = "10 + 12 = "
 144 stringConstant 19 = "."
 145 stringConstant 20 = "Klaar"
