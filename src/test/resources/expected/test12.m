   0 call 16
   1 stop
   2 ;test12.j(0) /*
   3 ;test12.j(1)  * A small program in the miniJava language.
   4 ;test12.j(2)  * Test something
   5 ;test12.j(3)  */
   6 ;test12.j(4) class TestWrite {
   7 class TestWrite []
   8 ;test12.j(5)   private static word zero = 0;
   9 acc8= constant 0
  10 acc8=> variable 0
  11 ;test12.j(6)   private static byte one = 1;
  12 acc8= constant 1
  13 acc8=> variable 2
  14 ;test12.j(7) 
  15 ;test12.j(8)   public static void main() {
  16 method main [public, static] void
  17 ;test12.j(9)     println(zero);
  18 acc16= variable 0
  19 call writeLineAcc16
  20 ;test12.j(10)     println(one);
  21 acc8= variable 2
  22 call writeLineAcc8
  23 ;test12.j(11)     println(2);
  24 acc8= constant 2
  25 call writeLineAcc8
  26 ;test12.j(12)     println("3  Drie keer.");
  27 acc16= stringconstant 128
  28 writeLineString
  29 ;test12.j(13)     println("3  Drie keer.");
  30 acc16= stringconstant 128
  31 writeLineString
  32 ;test12.j(14)     println("3  Drie keer.");
  33 acc16= stringconstant 128
  34 writeLineString
  35 ;test12.j(15)     println("4  Hier klinkt een bel\a en dan gaan we door.");
  36 acc16= stringconstant 129
  37 writeLineString
  38 ;test12.j(16)     println("5  Dit is pagina 1.\f   En dit is pagina 2.");
  39 acc16= stringconstant 130
  40 writeLineString
  41 ;test12.j(17)     println("6  Dit is gu\boed.");
  42 acc16= stringconstant 131
  43 writeLineString
  44 ;test12.j(18)     println("7  Getal na een tab\t1.");
  45 acc16= stringconstant 132
  46 writeLineString
  47 ;test12.j(19)     println("8  Dit zie je niet\r8  Dit zie je wel.");
  48 acc16= stringconstant 133
  49 writeLineString
  50 ;test12.j(20)     println("9  Dit is regel 1.\n   En dit regel 2.");
  51 acc16= stringconstant 134
  52 writeLineString
  53 ;test12.j(21)     println("10 Hier komt een dubbele quote \".");
  54 acc16= stringconstant 135
  55 writeLineString
  56 ;test12.j(22)     println("11 Hier komt een single quote \'.");
  57 acc16= stringconstant 136
  58 writeLineString
  59 ;test12.j(23)     println("12 Hier komt een backslash \\.");
  60 acc16= stringconstant 137
  61 writeLineString
  62 ;test12.j(24)     String str = "13 Hallo wereld.";
  63 acc16= stringconstant 138
  64 acc16=> variable 3
  65 ;test12.j(25)     println(str);
  66 acc16= variable 3
  67 writeLineString
  68 ;test12.j(26)     println(7 * 2);
  69 acc8= constant 7
  70 acc8* constant 2
  71 call writeLineAcc8
  72 ;test12.j(27)     println(7 + 2 * 4);
  73 acc8= constant 7
  74 <acc8= constant 2
  75 acc8* constant 4
  76 acc8+ unstack8
  77 call writeLineAcc8
  78 ;test12.j(28)     println(2 * 6 + 4);
  79 acc8= constant 2
  80 acc8* constant 6
  81 acc8+ constant 4
  82 call writeLineAcc8
  83 ;test12.j(29)     println(9 + 2 * (1 + 3));
  84 acc8= constant 9
  85 <acc8= constant 2
  86 <acc8= constant 1
  87 acc8+ constant 3
  88 acc8* unstack8
  89 acc8+ unstack8
  90 call writeLineAcc8
  91 ;test12.j(30)     println("18 Hallo" + " wereld.");
  92 acc16= stringconstant 139
  93 writeString
  94 acc16= stringconstant 140
  95 writeLineString
  96 ;test12.j(31)     println("19 Nog" + " een" + " bericht.");
  97 acc16= stringconstant 141
  98 writeString
  99 acc16= stringconstant 142
 100 writeString
 101 acc16= stringconstant 143
 102 writeLineString
 103 ;test12.j(32)     println("12 + 8 = " + 20);
 104 acc16= stringconstant 144
 105 writeString
 106 acc8= constant 20
 107 call writeLineAcc8
 108 ;test12.j(33)     println("7 * 3 = " + (7 * 3));
 109 acc16= stringconstant 145
 110 writeString
 111 acc8= constant 7
 112 acc8* constant 3
 113 call writeLineAcc8
 114 ;test12.j(34)     println("10 + 12 = " + (10 + 12) + ".");
 115 acc16= stringconstant 146
 116 writeString
 117 acc8= constant 10
 118 acc8+ constant 12
 119 call writeAcc8
 120 acc16= stringconstant 147
 121 writeLineString
 122 ;test12.j(35)     println("Klaar");
 123 acc16= stringconstant 148
 124 writeLineString
 125 return
 126 ;test12.j(36)   }
 127 ;test12.j(37) }
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
