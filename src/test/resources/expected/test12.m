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
  13 ;test12.j(9)     println(zero);
  14 acc16= variable 0
  15 call writeLineAcc16
  16 ;test12.j(10)     println(one);
  17 acc8= variable 2
  18 call writeLineAcc8
  19 ;test12.j(11)     println(2);
  20 acc8= constant 2
  21 call writeLineAcc8
  22 ;test12.j(12)     println("3  Drie keer.");
  23 acc16= constant 124
  24 writeLineString
  25 ;test12.j(13)     println("3  Drie keer.");
  26 acc16= constant 124
  27 writeLineString
  28 ;test12.j(14)     println("3  Drie keer.");
  29 acc16= constant 124
  30 writeLineString
  31 ;test12.j(15)     println("4  Hier klinkt een bel\a en dan gaan we door.");
  32 acc16= constant 125
  33 writeLineString
  34 ;test12.j(16)     println("5  Dit is pagina 1.\f   En dit is pagina 2.");
  35 acc16= constant 126
  36 writeLineString
  37 ;test12.j(17)     println("6  Dit is gu\boed.");
  38 acc16= constant 127
  39 writeLineString
  40 ;test12.j(18)     println("7  Getal na een tab\t1.");
  41 acc16= constant 128
  42 writeLineString
  43 ;test12.j(19)     println("8  Dit zie je niet\r8  Dit zie je wel.");
  44 acc16= constant 129
  45 writeLineString
  46 ;test12.j(20)     println("9  Dit is regel 1.\n   En dit regel 2.");
  47 acc16= constant 130
  48 writeLineString
  49 ;test12.j(21)     println("10 Hier komt een dubbele quote \".");
  50 acc16= constant 131
  51 writeLineString
  52 ;test12.j(22)     println("11 Hier komt een single quote \'.");
  53 acc16= constant 132
  54 writeLineString
  55 ;test12.j(23)     println("12 Hier komt een backslash \\.");
  56 acc16= constant 133
  57 writeLineString
  58 ;test12.j(24)     String str = "13 Hallo wereld.";
  59 acc16= constant 134
  60 acc16=> variable 3
  61 ;test12.j(25)     println(str);
  62 acc16= variable 3
  63 writeLineString
  64 ;test12.j(26)     println(7 * 2);
  65 acc8= constant 7
  66 acc8* constant 2
  67 call writeLineAcc8
  68 ;test12.j(27)     println(7 + 2 * 4);
  69 acc8= constant 7
  70 <acc8= constant 2
  71 acc8* constant 4
  72 acc8+ unstack8
  73 call writeLineAcc8
  74 ;test12.j(28)     println(2 * 6 + 4);
  75 acc8= constant 2
  76 acc8* constant 6
  77 acc8+ constant 4
  78 call writeLineAcc8
  79 ;test12.j(29)     println(9 + 2 * (1 + 3));
  80 acc8= constant 9
  81 <acc8= constant 2
  82 <acc8= constant 1
  83 acc8+ constant 3
  84 acc8* unstack8
  85 acc8+ unstack8
  86 call writeLineAcc8
  87 ;test12.j(30)     println("18 Hallo" + " wereld.");
  88 acc16= constant 135
  89 writeString
  90 acc16= constant 136
  91 writeLineString
  92 ;test12.j(31)     println("19 Nog" + " een" + " bericht.");
  93 acc16= constant 137
  94 writeString
  95 acc16= constant 138
  96 writeString
  97 acc16= constant 139
  98 writeLineString
  99 ;test12.j(32)     println("12 + 8 = " + 20);
 100 acc16= constant 140
 101 writeString
 102 acc8= constant 20
 103 call writeLineAcc8
 104 ;test12.j(33)     println("7 * 3 = " + (7 * 3));
 105 acc16= constant 141
 106 writeString
 107 acc8= constant 7
 108 acc8* constant 3
 109 call writeLineAcc8
 110 ;test12.j(34)     println("10 + 12 = " + (10 + 12) + ".");
 111 acc16= constant 142
 112 writeString
 113 acc8= constant 10
 114 acc8+ constant 12
 115 call writeAcc8
 116 acc16= constant 143
 117 writeLineString
 118 ;test12.j(35)     println("Klaar");
 119 acc16= constant 144
 120 writeLineString
 121 ;test12.j(36)   }
 122 ;test12.j(37) }
 123 stop
 124 stringConstant 0 = "3  Drie keer."
 125 stringConstant 1 = "4  Hier klinkt een bel en dan gaan we door."
 126 stringConstant 2 = "5  Dit is pagina 1.
   En dit is pagina 2."
 127 stringConstant 3 = "6  Dit is guoed."
 128 stringConstant 4 = "7  Getal na een tab	1."
 129 stringConstant 5 = "8  Dit zie je niet8  Dit zie je wel."
 130 stringConstant 6 = "9  Dit is regel 1.
   En dit regel 2."
 131 stringConstant 7 = "10 Hier komt een dubbele quote "."
 132 stringConstant 8 = "11 Hier komt een single quote '."
 133 stringConstant 9 = "12 Hier komt een backslash \."
 134 stringConstant 10 = "13 Hallo wereld."
 135 stringConstant 11 = "18 Hallo"
 136 stringConstant 12 = " wereld."
 137 stringConstant 13 = "19 Nog"
 138 stringConstant 14 = " een"
 139 stringConstant 15 = " bericht."
 140 stringConstant 16 = "12 + 8 = "
 141 stringConstant 17 = "7 * 3 = "
 142 stringConstant 18 = "10 + 12 = "
 143 stringConstant 19 = "."
 144 stringConstant 20 = "Klaar"
