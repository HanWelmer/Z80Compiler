   0 call 9
   1 stop
   2 ;testWrite.j(0) /*
   3 ;testWrite.j(1)  * A small program in the miniJava language.
   4 ;testWrite.j(2)  * Test something
   5 ;testWrite.j(3)  */
   6 ;testWrite.j(4) class TestWrite {
   7 class TestWrite []
   8 ;testWrite.j(5)   private static word zero = 0;
   9 acc8= constant 0
  10 acc8=> word variable 0
  11 ;testWrite.j(6)   private static byte one = 1;
  12 acc8= constant 1
  13 acc8=> byte variable 2
  14 br 17
  15 ;testWrite.j(7) 
  16 ;testWrite.j(8)   public static void main() {
  17 method TestWrite.main [public, static] void ()
  18 <basePointer
  19 basePointer= stackPointer
  20 stackPointer+ constant 2
  21 ;testWrite.j(9)     println(zero);
  22 acc16= word variable 0
  23 writeLineAcc16
  24 ;testWrite.j(10)     println(one);
  25 acc8= byte variable 2
  26 writeLineAcc8
  27 ;testWrite.j(11)     println(2);
  28 acc8= constant 2
  29 writeLineAcc8
  30 ;testWrite.j(12)     println("3  Drie keer.");
  31 acc16= stringconstant 134
  32 writeLineString
  33 ;testWrite.j(13)     println("3  Drie keer.");
  34 acc16= stringconstant 134
  35 writeLineString
  36 ;testWrite.j(14)     println("3  Drie keer.");
  37 acc16= stringconstant 134
  38 writeLineString
  39 ;testWrite.j(15)     println("4  Hier klinkt een bel\a en dan gaan we door.");
  40 acc16= stringconstant 135
  41 writeLineString
  42 ;testWrite.j(16)     println("5  Dit is pagina 1.\f   En dit is pagina 2.");
  43 acc16= stringconstant 136
  44 writeLineString
  45 ;testWrite.j(17)     println("6  Dit is gu\boed.");
  46 acc16= stringconstant 137
  47 writeLineString
  48 ;testWrite.j(18)     println("7  Getal na een tab\t1.");
  49 acc16= stringconstant 138
  50 writeLineString
  51 ;testWrite.j(19)     println("8  Dit zie je niet\r8  Dit zie je wel.");
  52 acc16= stringconstant 139
  53 writeLineString
  54 ;testWrite.j(20)     println("9  Dit is regel 1.\n   En dit regel 2.");
  55 acc16= stringconstant 140
  56 writeLineString
  57 ;testWrite.j(21)     println("10 Hier komt een dubbele quote \".");
  58 acc16= stringconstant 141
  59 writeLineString
  60 ;testWrite.j(22)     println("11 Hier komt een single quote \'.");
  61 acc16= stringconstant 142
  62 writeLineString
  63 ;testWrite.j(23)     println("12 Hier komt een backslash \\.");
  64 acc16= stringconstant 143
  65 writeLineString
  66 ;testWrite.j(24)     String str = "13 Hallo wereld.";
  67 acc16= stringconstant 144
  68 acc16=> String basePointer + 2
  69 ;testWrite.j(25)     println(str);
  70 acc16= String basePointer + 2
  71 writeLineString
  72 ;testWrite.j(26)     println(7 * 2);
  73 acc8= constant 7
  74 acc8* constant 2
  75 writeLineAcc8
  76 ;testWrite.j(27)     println(7 + 2 * 4);
  77 acc8= constant 7
  78 <acc8= constant 2
  79 acc8* constant 4
  80 acc8+ unstack8
  81 writeLineAcc8
  82 ;testWrite.j(28)     println(2 * 6 + 4);
  83 acc8= constant 2
  84 acc8* constant 6
  85 acc8+ constant 4
  86 writeLineAcc8
  87 ;testWrite.j(29)     println(9 + 2 * (1 + 3));
  88 acc8= constant 9
  89 <acc8= constant 2
  90 <acc8= constant 1
  91 acc8+ constant 3
  92 acc8* unstack8
  93 acc8+ unstack8
  94 writeLineAcc8
  95 ;testWrite.j(30)     println("18 Hallo" + " wereld.");
  96 acc16= stringconstant 145
  97 writeString
  98 acc16= stringconstant 146
  99 writeLineString
 100 ;testWrite.j(31)     println("19 Nog" + " een" + " bericht.");
 101 acc16= stringconstant 147
 102 writeString
 103 acc16= stringconstant 148
 104 writeString
 105 acc16= stringconstant 149
 106 writeLineString
 107 ;testWrite.j(32)     println("12 + 8 = " + 20);
 108 acc16= stringconstant 150
 109 writeString
 110 acc8= constant 20
 111 writeLineAcc8
 112 ;testWrite.j(33)     println("7 * 3 = " + (7 * 3));
 113 acc16= stringconstant 151
 114 writeString
 115 acc8= constant 7
 116 acc8* constant 3
 117 writeLineAcc8
 118 ;testWrite.j(34)     println("10 + 12 = " + (10 + 12) + ".");
 119 acc16= stringconstant 152
 120 writeString
 121 acc8= constant 10
 122 acc8+ constant 12
 123 writeAcc8
 124 acc16= stringconstant 153
 125 writeLineString
 126 ;testWrite.j(35)     println("Klaar");
 127 acc16= stringconstant 154
 128 writeLineString
 129 ;testWrite.j(36)   }
 130 stackPointer= basePointer
 131 basePointer<
 132 return
 133 ;testWrite.j(37) }
 134 stringConstant 0 = "3  Drie keer."
 135 stringConstant 1 = "4  Hier klinkt een bel en dan gaan we door."
 136 stringConstant 2 = "5  Dit is pagina 1.
   En dit is pagina 2."
 137 stringConstant 3 = "6  Dit is guoed."
 138 stringConstant 4 = "7  Getal na een tab	1."
 139 stringConstant 5 = "8  Dit zie je niet8  Dit zie je wel."
 140 stringConstant 6 = "9  Dit is regel 1.
   En dit regel 2."
 141 stringConstant 7 = "10 Hier komt een dubbele quote "."
 142 stringConstant 8 = "11 Hier komt een single quote '."
 143 stringConstant 9 = "12 Hier komt een backslash \."
 144 stringConstant 10 = "13 Hallo wereld."
 145 stringConstant 11 = "18 Hallo"
 146 stringConstant 12 = " wereld."
 147 stringConstant 13 = "19 Nog"
 148 stringConstant 14 = " een"
 149 stringConstant 15 = " bericht."
 150 stringConstant 16 = "12 + 8 = "
 151 stringConstant 17 = "7 * 3 = "
 152 stringConstant 18 = "10 + 12 = "
 153 stringConstant 19 = "."
 154 stringConstant 20 = "Klaar"
