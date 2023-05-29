   0 ;test.j(0) /*
   1 ;test.j(1)  * A small program in the miniJava language.
   2 ;test.j(2)  * Test something
   3 ;test.j(3)  */
   4 ;test.j(4) class TestWrite {
   5 ;test.j(5)   word zero = 0;
   6 acc8= constant 0
   7 acc8=> variable 0
   8 ;test.j(6)   byte one = 1;
   9 acc8= constant 1
  10 acc8=> variable 2
  11 ;test.j(7)   write(0);
  12 acc8= constant 0
  13 call writeAcc8
  14 ;test.j(8)   write(one);
  15 acc8= variable 2
  16 call writeAcc8
  17 ;test.j(9)   write("2 Hallo wereld");
  18 acc16= constant 34
  19 writeString
  20 ;test.j(10)   String str = "3 Hello too.";
  21 acc16= constant 35
  22 acc16=> variable 3
  23 ;test.j(11)   write(str);
  24 acc16= variable 3
  25 writeString
  26 ;test.j(12)   write(4);
  27 acc8= constant 4
  28 call writeAcc8
  29 ;test.j(13)   write("Klaar");
  30 acc16= constant 36
  31 writeString
  32 ;test.j(14) }
  33 stop
  34 stringConstant 0 = "2 Hallo wereld"
  35 stringConstant 1 = "3 Hello too."
  36 stringConstant 2 = "Klaar"
