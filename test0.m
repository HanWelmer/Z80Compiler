   0 ;test0.p(0) /* Program to test generated Z80 assembler code */
   1 ;test0.p(1) class TestPrint {
   2 ;test0.p(2)   byte b = 2;
   3 acc8= constant 2
   4 acc8=> variable 0
   5 ;test0.p(3)   int i = 1;
   6 acc8= constant 1
   7 acc8=> variable 1
   8 ;test0.p(4)   write(b);
   9 acc8= variable 0
  10 call writeAcc8
  11 ;test0.p(5)   write(i);
  12 acc16= variable 1
  13 call writeAcc16
  14 ;test0.p(6)   write(0);
  15 acc8= constant 0
  16 call writeAcc8
  17 ;test0.p(7) }
  18 stop
