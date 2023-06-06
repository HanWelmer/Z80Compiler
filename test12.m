   0 ;test12.j(0) /*
   1 ;test12.j(1)  * A small program in the miniJava language.
   2 ;test12.j(2)  * Test something
   3 ;test12.j(3)  */
   4 ;test12.j(4) class TestWrite {
   5 ;test12.j(5)   word zero = 0;
   6 acc8= constant 0
   7 acc8=> variable 0
   8 ;test12.j(6)   byte one = 1;
   9 acc8= constant 1
  10 acc8=> variable 2
  11 ;test12.j(7)   println(zero);
  12 acc16= variable 0
  13 call writeLineAcc16
  14 ;test12.j(8)   println(one);
  15 acc8= variable 2
  16 call writeLineAcc8
  17 ;test12.j(9)   println(2);
  18 acc8= constant 2
  19 call writeLineAcc8
  20 ;test12.j(10)   println("3  Drie keer.");
  21 acc16= constant 121
  22 writeLineString
  23 ;test12.j(11)   println("3  Drie keer.");
  24 acc16= constant 121
  25 writeLineString
  26 ;test12.j(12)   println("3  Drie keer.");
  27 acc16= constant 121
  28 writeLineString
  29 ;test12.j(13)   println("4  Hier klinkt een bel\a en dan gaan we door.");
  30 acc16= constant 122
  31 writeLineString
  32 ;test12.j(14)   println("5  Dit is pagina 1.\f   En dit is pagina 2.");
  33 acc16= constant 123
  34 writeLineString
  35 ;test12.j(15)   println("6  Dit is gu\boed.");
  36 acc16= constant 124
  37 writeLineString
  38 ;test12.j(16)   println("7  Getal na een tab\t1.");
  39 acc16= constant 125
  40 writeLineString
  41 ;test12.j(17)   println("8  Dit zie je niet\r8  Dit zie je wel.");
  42 acc16= constant 126
  43 writeLineString
  44 ;test12.j(18)   println("9  Dit is regel 1.\n   En dit regel 2.");
  45 acc16= constant 127
  46 writeLineString
  47 ;test12.j(19)   println("10 Hier komt een dubbele quote \".");
  48 acc16= constant 128
  49 writeLineString
  50 ;test12.j(20)   println("11 Hier komt een single quote \'.");
  51 acc16= constant 129
  52 writeLineString
  53 ;test12.j(21)   println("12 Hier komt een backslash \\.");
  54 acc16= constant 130
  55 writeLineString
  56 ;test12.j(22)   String str = "13 Hallo wereld.";
  57 acc16= constant 131
  58 acc16=> variable 3
  59 ;test12.j(23)   println(str);
  60 acc16= variable 3
  61 writeLineString
  62 ;test12.j(24)   println(7 * 2);
  63 acc8= constant 7
  64 acc8* constant 2
  65 call writeLineAcc8
  66 ;test12.j(25)   println(7 + 2 * 4);
  67 acc8= constant 7
  68 <acc8= constant 2
  69 acc8* constant 4
  70 acc8+ unstack8
  71 call writeLineAcc8
  72 ;test12.j(26)   println(2 * 6 + 4);
  73 acc8= constant 2
  74 acc8* constant 6
  75 acc8+ constant 4
  76 call writeLineAcc8
  77 ;test12.j(27)   println(9 + 2 * (1 + 3));
  78 acc8= constant 9
  79 <acc8= constant 2
  80 <acc8= constant 1
  81 acc8+ constant 3
  82 acc8* unstack8
  83 acc8+ unstack8
  84 call writeLineAcc8
  85 ;test12.j(28)   println("18 Hallo" + " wereld.");
  86 acc16= constant 132
  87 writeString
  88 acc16= constant 133
  89 writeLineString
  90 ;test12.j(29)   println("19 Nog" + " een" + " bericht.");
  91 acc16= constant 134
  92 writeString
  93 acc16= constant 135
  94 writeString
  95 acc16= constant 136
  96 writeLineString
  97 ;test12.j(30)   println("12 + 8 = " + 20);
  98 acc16= constant 137
  99 writeString
 100 acc8= constant 20
 101 call writeLineAcc8
 102 ;test12.j(31)   println("7 * 3 = " + (7 * 3));
 103 acc16= constant 138
 104 writeString
 105 acc8= constant 7
 106 acc8* constant 3
 107 call writeLineAcc8
 108 ;test12.j(32)   println("10 + 12 = " + (10 + 12) + ".");
 109 acc16= constant 139
 110 writeString
 111 acc8= constant 10
 112 acc8+ constant 12
 113 call writeAcc8
 114 acc16= constant 140
 115 writeLineString
 116 ;test12.j(33)   println("Klaar");
 117 acc16= constant 141
 118 writeLineString
 119 ;test12.j(34) }
 120 stop
 121 stringConstant 0 = "3  Drie keer."
 122 stringConstant 1 = "4  Hier klinkt een bel en dan gaan we door."
 123 stringConstant 2 = "5  Dit is pagina 1.
   En dit is pagina 2."
 124 stringConstant 3 = "6  Dit is guoed."
 125 stringConstant 4 = "7  Getal na een tab	1."
 126 stringConstant 5 = "8  Dit zie je niet8  Dit zie je wel."
 127 stringConstant 6 = "9  Dit is regel 1.
   En dit regel 2."
 128 stringConstant 7 = "10 Hier komt een dubbele quote "."
 129 stringConstant 8 = "11 Hier komt een single quote '."
 130 stringConstant 9 = "12 Hier komt een backslash \."
 131 stringConstant 10 = "13 Hallo wereld."
 132 stringConstant 11 = "18 Hallo"
 133 stringConstant 12 = " wereld."
 134 stringConstant 13 = "19 Nog"
 135 stringConstant 14 = " een"
 136 stringConstant 15 = " bericht."
 137 stringConstant 16 = "12 + 8 = "
 138 stringConstant 17 = "7 * 3 = "
 139 stringConstant 18 = "10 + 12 = "
 140 stringConstant 19 = "."
 141 stringConstant 20 = "Klaar"
