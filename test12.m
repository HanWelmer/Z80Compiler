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
  11 ;test12.j(7)   write(13);
  12 acc8= constant 13
  13 call writeAcc8
  14 ;test12.j(8)   write("12 Hier komt een backslash \\");
  15 acc16= constant id=61
  16 call writeString
  17 ;test12.j(9)   write("11 Hier komt een single quote \'");
  18 acc16= constant id=62
  19 call writeString
  20 ;test12.j(10)   write("10 Hier komt een dubbele quote \"");
  21 acc16= constant id=63
  22 call writeString
  23 ;test12.j(11)   write("9  Dit is regel 1.\n   En dit regel 2.");
  24 acc16= constant id=64
  25 call writeString
  26 ;test12.j(12)   write("8  Dit zie je niet\r8  Dit zie je wel.");
  27 acc16= constant id=65
  28 call writeString
  29 ;test12.j(13)   write("7  Getal na een tab\t1");
  30 acc16= constant id=66
  31 call writeString
  32 ;test12.j(14)   write("6  Dit is gu\boed.");
  33 acc16= constant id=67
  34 call writeString
  35 ;test12.j(15)   write("5  Dit is pagina 1.\f   En dit is pagina 2.");
  36 acc16= constant id=68
  37 call writeString
  38 ;test12.j(16)   write("4  Hier klinkt een bel\a en dan gaan we door.");
  39 acc16= constant id=69
  40 call writeString
  41 ;test12.j(17)   write("3 Drie keer.");
  42 acc16= constant id=70
  43 call writeString
  44 ;test12.j(18)   write("3 Drie keer.");
  45 acc16= constant id=70
  46 call writeString
  47 ;test12.j(19)   write("3 Drie keer.");
  48 acc16= constant id=70
  49 call writeString
  50 ;test12.j(20)   write(2);
  51 acc8= constant 2
  52 call writeAcc8
  53 ;test12.j(21)   write(one);
  54 acc8= variable 2
  55 call writeAcc8
  56 ;test12.j(22)   write(zero);
  57 acc16= variable 0
  58 call writeAcc16
  59 ;test12.j(23) }
  60 stop
  61 stringConstant 0 = "12 Hier komt een backslash \"
  62 stringConstant 1 = "11 Hier komt een single quote '"
  63 stringConstant 2 = "10 Hier komt een dubbele quote ""
  64 stringConstant 3 = "9  Dit is regel 1.
   En dit regel 2."
  65 stringConstant 4 = "8  Dit zie je niet8  Dit zie je wel."
  66 stringConstant 5 = "7  Getal na een tab	1"
  67 stringConstant 6 = "6  Dit is guoed."
  68 stringConstant 7 = "5  Dit is pagina 1.
   En dit is pagina 2."
  69 stringConstant 8 = "4  Hier klinkt een bel en dan gaan we door."
  70 stringConstant 9 = "3 Drie keer."
