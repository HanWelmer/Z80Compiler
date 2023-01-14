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
  15 writeString 49
  16 ;test12.j(9)   write("11 Hier komt een single quote \'");
  17 writeString 50
  18 ;test12.j(10)   write("10 Hier komt een dubbele quote \"");
  19 writeString 51
  20 ;test12.j(11)   write("9  Dit is regel 1.\n   En dit regel 2.");
  21 writeString 52
  22 ;test12.j(12)   write("8  Dit zie je niet\r8  Dit zie je wel.");
  23 writeString 53
  24 ;test12.j(13)   write("7  Getal na een tab\t1");
  25 writeString 54
  26 ;test12.j(14)   write("6  Dit is gu\boed.");
  27 writeString 55
  28 ;test12.j(15)   write("5  Dit is pagina 1.\f   En dit is pagina 2.");
  29 writeString 56
  30 ;test12.j(16)   write("4  Hier klinkt een bel\a en dan gaan we door.");
  31 writeString 57
  32 ;test12.j(17)   write("3 Drie keer.");
  33 writeString 58
  34 ;test12.j(18)   write("3 Drie keer.");
  35 writeString 58
  36 ;test12.j(19)   write("3 Drie keer.");
  37 writeString 58
  38 ;test12.j(20)   write(2);
  39 acc8= constant 2
  40 call writeAcc8
  41 ;test12.j(21)   write(one);
  42 acc8= variable 2
  43 call writeAcc8
  44 ;test12.j(22)   write(zero);
  45 acc16= variable 0
  46 call writeAcc16
  47 ;test12.j(23) }
  48 stop
  49 stringConstant 0 = "12 Hier komt een backslash \"
  50 stringConstant 1 = "11 Hier komt een single quote '"
  51 stringConstant 2 = "10 Hier komt een dubbele quote ""
  52 stringConstant 3 = "9  Dit is regel 1.
   En dit regel 2."
  53 stringConstant 4 = "8  Dit zie je niet8  Dit zie je wel."
  54 stringConstant 5 = "7  Getal na een tab	1"
  55 stringConstant 6 = "6  Dit is guoed."
  56 stringConstant 7 = "5  Dit is pagina 1.
   En dit is pagina 2."
  57 stringConstant 8 = "4  Hier klinkt een bel en dan gaan we door."
  58 stringConstant 9 = "3 Drie keer."
