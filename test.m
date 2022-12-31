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
  11 ;test.j(7)   write("4 als een string");
  12 call writeString "4 als een string"
  13 ;test.j(8)   write(1003-1000);
  14 acc16= constant 1003
  15 acc16- constant 1000
  16 call writeAcc16
  17 ;test.j(9)   write(2);
  18 acc8= constant 2
  19 call writeAcc8
  20 ;test.j(10)   write(one);
  21 acc8= variable 2
  22 call writeAcc8
  23 ;test.j(11)   write(zero);
  24 acc16= variable 0
  25 call writeAcc16
  26 ;test.j(12) }
  27 stop
