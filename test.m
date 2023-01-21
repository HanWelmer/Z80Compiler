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
  11 ;test.j(7)   write(4);
  12 acc8= constant 4
  13 call writeAcc8
  14 ;test.j(8)   write("Hallo wereld");
  15 acc16= constant 31
  16 writeString
  17 ;test.j(9)   String str = "Hello too.";
  18 acc16= constant 32
  19 acc16=> variable 3
  20 ;test.j(10)   write(str);
  21 acc16= variable 3
  22 writeString
  23 ;test.j(11)   write(one);
  24 acc8= variable 2
  25 call writeAcc8
  26 ;test.j(12)   write(zero);
  27 acc16= variable 0
  28 call writeAcc16
  29 ;test.j(13) }
  30 stop
  31 stringConstant 0 = "Hallo wereld"
  32 stringConstant 1 = "Hello too."
