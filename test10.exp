   0 ;test10.p(0) /* Program to test generated Z80 assembler code */
   1 ;test10.p(1) class TestDo {
   2 ;test10.p(2)   byte a = 2;
   3 acc8= constant 2
   4 acc8=> variable 0
   5 ;test10.p(3)   do {
   6 ;test10.p(4)     int i = 1;
   7 acc8= constant 1
   8 acc8ToAcc16
   9 acc16=> variable 1
  10 ;test10.p(5)     write(a);
  11 acc8= variable 0
  12 call writeAcc8
  13 ;test10.p(6)     a = a - i;
  14 acc8= variable 0
  15 acc8ToAcc16
  16 acc16- variable 1
  17 acc16ToAcc8
  18 acc8=> variable 0
  19 ;test10.p(7)   } while (a > 1);
  20 acc8= variable 0
  21 acc16Comp constant 1
  22 brge 6
  23 ;test10.p(8)   write(0);
  24 acc8= constant 0
  25 call writeAcc8
  26 ;test10.p(9) }
  27 stop
