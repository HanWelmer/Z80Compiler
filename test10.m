   0 ;test10.p(0) /* Program to test generated Z80 assembler code */
   1 ;test10.p(1) class TestDo {
   2 ;test10.p(2)   byte a = 2;
   3 acc8= constant 2
   4 acc8=> variable 0
   5 ;test10.p(3)   do {
   6 ;test10.p(4)     int i = 1;
   7 acc8= constant 1
   8 acc8=> variable 1
   9 ;test10.p(5)     write(a);
  10 acc8= variable 0
  11 call writeAcc8
  12 ;test10.p(6)     a = a - i;
  13 acc8= variable 0
  14 acc8ToAcc16
  15 acc16- variable 1
  16 acc16=> variable 0
  17 ;test10.p(7)   } while (a > 1);
  18 acc8= variable 0
  19 acc16Comp constant 1
  20 brge 6
  21 ;test10.p(8)   write(0);
  22 acc8= constant 0
  23 call writeAcc8
  24 ;test10.p(9) }
  25 stop
