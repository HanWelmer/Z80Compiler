   0 ;test.j(0) /*
   1 ;test.j(1)  * A small program in the miniJava language.
   2 ;test.j(2)  * Test something
   3 ;test.j(3)  */
   4 ;test.j(4) class Test {
   5 ;test.j(5)   word zero = 0;
   6 acc8= constant 0
   7 acc8=> variable 0
   8 ;test.j(6)   word one = 1;
   9 acc8= constant 1
  10 acc8=> variable 2
  11 ;test.j(7)   word four = 4;
  12 acc8= constant 4
  13 acc8=> variable 4
  14 ;test.j(8)   word twelve = 12;
  15 acc8= constant 12
  16 acc8=> variable 6
  17 ;test.j(9)   byte byteOne = 1;
  18 acc8= constant 1
  19 acc8=> variable 8
  20 ;test.j(10)   //if (four == zero + 12/(one + 2)) write(2);
  21 ;test.j(11)   write(byteOne);
  22 acc8= variable 8
  23 call writeAcc8
  24 ;test.j(12)   write(zero);
  25 acc16= variable 0
  26 call writeAcc16
  27 ;test.j(13) }
  28 stop
