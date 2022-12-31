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
  15 call writeString "12 Hier komt een backslash \"
  16 ;test12.j(9)   write("11 Hier komt een single quote \'");
  17 call writeString "11 Hier komt een single quote '"
  18 ;test12.j(10)   write("10 Hier komt een dubbele quote \"");
  19 call writeString "10 Hier komt een dubbele quote ""
  20 ;test12.j(11)   write("9  Dit is regel 1.\n   En dit regel 2.");
  21 call writeString "9  Dit is regel 1.
   En dit regel 2."
  22 ;test12.j(12)   write("8  Dit zie je niet\r9  Dit zie je wel.");
  23 call writeString "8  Dit zie je niet9  Dit zie je wel."
  24 ;test12.j(13)   write("7  Getal na een tab\t1");
  25 call writeString "7  Getal na een tab	1"
  26 ;test12.j(14)   write("6  Dit is gu\boed.");
  27 call writeString "6  Dit is guoed."
  28 ;test12.j(15)   write("5  Dit is pagina 1.\f   En dit is pagina 2.");
  29 call writeString "5  Dit is pagina 1.
   En dit is pagina 2."
  30 ;test12.j(16)   write("4  Hier klinkt een bel\a en dan gaan we door.");
  31 call writeString "4  Hier klinkt een bel en dan gaan we door."
  32 ;test12.j(17)   write(1003-1000);
  33 acc16= constant 1003
  34 acc16- constant 1000
  35 call writeAcc16
  36 ;test12.j(18)   write(2);
  37 acc8= constant 2
  38 call writeAcc8
  39 ;test12.j(19)   write(one);
  40 acc8= variable 2
  41 call writeAcc8
  42 ;test12.j(20)   write(zero);
  43 acc16= variable 0
  44 call writeAcc16
  45 ;test12.j(21) }
  46 stop
