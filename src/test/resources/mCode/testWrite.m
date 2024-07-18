   0 call 16
   1 stop
   2 ;testWrite.j(0) /*
   3 ;testWrite.j(1)  * A small program in the miniJava language.
   4 ;testWrite.j(2)  * Test something
   5 ;testWrite.j(3)  */
   6 ;testWrite.j(4) class TestWrite {
   7 class TestWrite []
   8 ;testWrite.j(5)   private static word zero = 0;
   9 acc8= constant 0
  10 acc8=> variable 0
  11 ;testWrite.j(6)   private static byte one = 1;
  12 acc8= constant 1
  13 acc8=> variable 2
  14 ;testWrite.j(7) 
  15 ;testWrite.j(8)   public static void main() {
  16 method TestWrite.main [public, static] void ()
  17 <basePointer
  18 basePointer= stackPointer
  19 stackPointer+ constant 2
  20 ;testWrite.j(9)     println(zero);
  21 acc16= variable 0
  22 writeLineAcc16
  23 ;testWrite.j(10)     println(one);
  24 acc8= variable 2
  25 writeLineAcc8
  26 ;testWrite.j(11)     println(2);
  27 acc8= constant 2
  28 writeLineAcc8
  29 ;testWrite.j(12)     println("3  Drie keer.");
  30 acc16= stringconstant 133
  31 writeLineString
  32 ;testWrite.j(13)     println("3  Drie keer.");
  33 acc16= stringconstant 133
  34 writeLineString
  35 ;testWrite.j(14)     println("3  Drie keer.");
  36 acc16= stringconstant 133
  37 writeLineString
  38 ;testWrite.j(15)     println("4  Hier klinkt een bel\a en dan gaan we door.");
  39 acc16= stringconstant 134
  40 writeLineString
  41 ;testWrite.j(16)     println("5  Dit is pagina 1.\f   En dit is pagina 2.");
  42 acc16= stringconstant 135
  43 writeLineString
  44 ;testWrite.j(17)     println("6  Dit is gu\boed.");
  45 acc16= stringconstant 136
  46 writeLineString
  47 ;testWrite.j(18)     println("7  Getal na een tab\t1.");
  48 acc16= stringconstant 137
  49 writeLineString
  50 ;testWrite.j(19)     println("8  Dit zie je niet\r8  Dit zie je wel.");
  51 acc16= stringconstant 138
  52 writeLineString
  53 ;testWrite.j(20)     println("9  Dit is regel 1.\n   En dit regel 2.");
  54 acc16= stringconstant 139
  55 writeLineString
  56 ;testWrite.j(21)     println("10 Hier komt een dubbele quote \".");
  57 acc16= stringconstant 140
  58 writeLineString
  59 ;testWrite.j(22)     println("11 Hier komt een single quote \'.");
  60 acc16= stringconstant 141
  61 writeLineString
  62 ;testWrite.j(23)     println("12 Hier komt een backslash \\.");
  63 acc16= stringconstant 142
  64 writeLineString
  65 ;testWrite.j(24)     String str = "13 Hallo wereld.";
  66 acc16= stringconstant 143
  67 acc16=> (basePointer + -2)
  68 ;testWrite.j(25)     println(str);
  69 acc16= (basePointer + -2)
  70 writeLineString
  71 ;testWrite.j(26)     println(7 * 2);
  72 acc8= constant 7
  73 acc8* constant 2
  74 writeLineAcc8
  75 ;testWrite.j(27)     println(7 + 2 * 4);
  76 acc8= constant 7
  77 <acc8= constant 2
  78 acc8* constant 4
  79 acc8+ unstack8
  80 writeLineAcc8
  81 ;testWrite.j(28)     println(2 * 6 + 4);
  82 acc8= constant 2
  83 acc8* constant 6
  84 acc8+ constant 4
  85 writeLineAcc8
  86 ;testWrite.j(29)     println(9 + 2 * (1 + 3));
  87 acc8= constant 9
  88 <acc8= constant 2
  89 <acc8= constant 1
  90 acc8+ constant 3
  91 acc8* unstack8
  92 acc8+ unstack8
  93 writeLineAcc8
  94 ;testWrite.j(30)     println("18 Hallo" + " wereld.");
  95 acc16= stringconstant 144
  96 writeString
  97 acc16= stringconstant 145
  98 writeLineString
  99 ;testWrite.j(31)     println("19 Nog" + " een" + " bericht.");
 100 acc16= stringconstant 146
 101 writeString
 102 acc16= stringconstant 147
 103 writeString
 104 acc16= stringconstant 148
 105 writeLineString
 106 ;testWrite.j(32)     println("12 + 8 = " + 20);
 107 acc16= stringconstant 149
 108 writeString
 109 acc8= constant 20
 110 writeLineAcc8
 111 ;testWrite.j(33)     println("7 * 3 = " + (7 * 3));
 112 acc16= stringconstant 150
 113 writeString
 114 acc8= constant 7
 115 acc8* constant 3
 116 writeLineAcc8
 117 ;testWrite.j(34)     println("10 + 12 = " + (10 + 12) + ".");
 118 acc16= stringconstant 151
 119 writeString
 120 acc8= constant 10
 121 acc8+ constant 12
 122 writeAcc8
 123 acc16= stringconstant 152
 124 writeLineString
 125 ;testWrite.j(35)     println("Klaar");
 126 acc16= stringconstant 153
 127 writeLineString
 128 ;testWrite.j(36)   }
 129 stackPointer= basePointer
 130 basePointer<
 131 return
 132 ;testWrite.j(37) }
 133 stringConstant 0 = "3  Drie keer."
 134 stringConstant 1 = "4  Hier klinkt een bel en dan gaan we door."
 135 stringConstant 2 = "5  Dit is pagina 1.
   En dit is pagina 2."
 136 stringConstant 3 = "6  Dit is guoed."
 137 stringConstant 4 = "7  Getal na een tab	1."
 138 stringConstant 5 = "8  Dit zie je niet8  Dit zie je wel."
 139 stringConstant 6 = "9  Dit is regel 1.
   En dit regel 2."
 140 stringConstant 7 = "10 Hier komt een dubbele quote "."
 141 stringConstant 8 = "11 Hier komt een single quote '."
 142 stringConstant 9 = "12 Hier komt een backslash \."
 143 stringConstant 10 = "13 Hallo wereld."
 144 stringConstant 11 = "18 Hallo"
 145 stringConstant 12 = " wereld."
 146 stringConstant 13 = "19 Nog"
 147 stringConstant 14 = " een"
 148 stringConstant 15 = " bericht."
 149 stringConstant 16 = "12 + 8 = "
 150 stringConstant 17 = "7 * 3 = "
 151 stringConstant 18 = "10 + 12 = "
 152 stringConstant 19 = "."
 153 stringConstant 20 = "Klaar"
