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
  21 acc16= constant 67
  22 writeLineString
  23 ;test12.j(11)   println("3  Drie keer.");
  24 acc16= constant 67
  25 writeLineString
  26 ;test12.j(12)   println("3  Drie keer.");
  27 acc16= constant 67
  28 writeLineString
  29 ;test12.j(13)   println("4  Hier klinkt een bel\a en dan gaan we door.");
  30 acc16= constant 68
  31 writeLineString
  32 ;test12.j(14)   println("5  Dit is pagina 1.\f   En dit is pagina 2.");
  33 acc16= constant 69
  34 writeLineString
  35 ;test12.j(15)   println("6  Dit is gu\boed.");
  36 acc16= constant 70
  37 writeLineString
  38 ;test12.j(16)   println("7  Getal na een tab\t1.");
  39 acc16= constant 71
  40 writeLineString
  41 ;test12.j(17)   println("8  Dit zie je niet\r8  Dit zie je wel.");
  42 acc16= constant 72
  43 writeLineString
  44 ;test12.j(18)   println("9  Dit is regel 1.\n   En dit regel 2.");
  45 acc16= constant 73
  46 writeLineString
  47 ;test12.j(19)   println("10 Hier komt een dubbele quote \".");
  48 acc16= constant 74
  49 writeLineString
  50 ;test12.j(20)   println("11 Hier komt een single quote \'.");
  51 acc16= constant 75
  52 writeLineString
  53 ;test12.j(21)   println("12 Hier komt een backslash \\.");
  54 acc16= constant 76
  55 writeLineString
  56 ;test12.j(22)   String str = "13 Hallo wereld.";
  57 acc16= constant 77
  58 acc16=> variable 3
  59 ;test12.j(23)   println(str);
  60 acc16= variable 3
  61 writeLineString
  62 ;test12.j(24)   println("Klaar");
  63 acc16= constant 78
  64 writeLineString
  65 ;test12.j(25) }
  66 stop
  67 stringConstant 0 = "3  Drie keer."
  68 stringConstant 1 = "4  Hier klinkt een bel en dan gaan we door."
  69 stringConstant 2 = "5  Dit is pagina 1.
   En dit is pagina 2."
  70 stringConstant 3 = "6  Dit is guoed."
  71 stringConstant 4 = "7  Getal na een tab	1."
  72 stringConstant 5 = "8  Dit zie je niet8  Dit zie je wel."
  73 stringConstant 6 = "9  Dit is regel 1.
   En dit regel 2."
  74 stringConstant 7 = "10 Hier komt een dubbele quote "."
  75 stringConstant 8 = "11 Hier komt een single quote '."
  76 stringConstant 9 = "12 Hier komt een backslash \."
  77 stringConstant 10 = "13 Hallo wereld."
  78 stringConstant 11 = "Klaar"
