   0 ;test.j(0) /*
   1 ;test.j(1)  * A small program in the miniJava language.
   2 ;test.j(2)  * Test something
   3 ;test.j(3)  */
   4 ;test.j(4) class Test {
   5 ;test.j(5)   word zero = 0;
   6 acc8= constant 0
   7 acc8=> variable 0
   8 ;test.j(6)   byte one = 1;
   9 acc8= constant 1
  10 acc8=> variable 2
  11 ;test.j(7)   write(14);
  12 acc8= constant 14
  13 call writeAcc8
  14 ;test.j(8)   write("13 Hier komt een backslash \\");
  15 call writeString "13 Hier komt een backslash \"
  16 ;test.j(9)   write("12 Hier komt een single quote \'");
  17 call writeString "12 Hier komt een single quote '"
  18 ;test.j(10)   write("11 Hier komt een dubbele quote \"");
  19 call writeString "11 Hier komt een dubbele quote ""
  20 ;test.j(11)   write("10 Dit is regel 1.\n   En dit regel 2.");
  21 call writeString "10 Dit is regel 1.
   En dit regel 2."
  22 ;test.j(12)   write("9  Dit zie je niet\r9  Dit zie je wel.");
  23 call writeString "9  Dit zie je niet9  Dit zie je wel."
  24 ;test.j(13)   write("8  Getal na een tab\t1");
  25 call writeString "8  Getal na een tab	1"
  26 ;test.j(14)   write("7  Dit is gu\boed.");
  27 call writeString "7  Dit is guoed."
  28 ;test.j(15)   write("6  Dit is pagina 1.\f   En dit is pagina 2.");
  29 call writeString "6  Dit is pagina 1.
   En dit is pagina 2."
  30 ;test.j(16)   write("5  Hier klinkt een bel\a en dan gaan we door.");
  31 call writeString "5  Hier klinkt een bel en dan gaan we door."
  32 ;test.j(17)   write("4  Dit staat op regel 1.\vEn dit volgt verticaal eronder op de volgende regel.");
  33 call writeString "4  Dit staat op regel 1.	En dit volgt verticaal eronder op de volgende regel."
  34 ;test.j(18)   write(1003-1000);
  35 acc16= constant 1003
  36 acc16- constant 1000
  37 call writeAcc16
  38 ;test.j(19)   write(2);
  39 acc8= constant 2
  40 call writeAcc8
  41 ;test.j(20)   write(one);
  42 acc8= variable 2
  43 call writeAcc8
  44 ;test.j(21)   write(zero);
  45 acc16= variable 0
  46 call writeAcc16
  47 ;test.j(22) }
  48 stop
