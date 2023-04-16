   0 ;test0.j(0) /* Program to test generated Z80 assembler code */
   1 ;test0.j(1) class TestPrint {
   2 ;test0.j(2)   byte b = 2;
   3 acc8= constant 2
   4 acc8=> variable 0
   5 ;test0.j(3)   word i = 1;
   6 acc8= constant 1
   7 acc8=> variable 1
   8 ;test0.j(4)   write(0);
   9 acc8= constant 0
  10 call writeAcc8
  11 ;test0.j(5)   write(i);
  12 acc16= variable 1
  13 call writeAcc16
  14 ;test0.j(6)   write(b);
  15 acc8= variable 0
  16 call writeAcc8
  17 ;test0.j(7)   write("Klaar");
  18 acc16= constant 22
  19 writeString
  20 ;test0.j(8) }
  21 stop
  22 stringConstant 0 = "Klaar"
