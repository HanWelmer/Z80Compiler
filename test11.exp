   0 ;test11.p(0) /* Program to test generated Z80 assembler code */
   1 ;test11.p(1) class TestFor {
   2 ;test11.p(2)   for(byte b = 4; b>2; b--) {
   3 acc8= constant 4
   4 acc8=> variable 0
   5 acc8= variable 0
   6 <acc8
   7 acc8= unstack8
   8 acc8Comp constant 2
   9 brle 19
  10 br 13
  11 decr8 variable 0
  12 br 5
  13 ;test11.p(3)     write(b);
  14 acc8= variable 0
  15 call writeAcc8
  16 ;test11.p(4)   }
  17 br 11
  18 ;test11.p(5)   for(int i = 2; i>0; i--) {
  19 acc8= constant 2
  20 acc8=> variable 0
  21 acc16= variable 0
  22 acc8= constant 0
  23 acc16CompareAcc8
  24 brle 34
  25 br 28
  26 decr16 variable 0
  27 br 21
  28 ;test11.p(6)     write(i);
  29 acc16= variable 0
  30 call writeAcc16
  31 ;test11.p(7)   }
  32 br 26
  33 ;test11.p(8)   write(0);
  34 acc8= constant 0
  35 call writeAcc8
  36 ;test11.p(9) }
  37 stop
