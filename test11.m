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
  22 <acc16
  23 acc16= unstack16
  24 acc8= constant 0
  25 acc16CompareAcc8
  26 brle 36
  27 br 30
  28 decr16 variable 0
  29 br 21
  30 ;test11.p(6)     write(i);
  31 acc16= variable 0
  32 call writeAcc16
  33 ;test11.p(7)   }
  34 br 28
  35 ;test11.p(8)   write(0);
  36 acc8= constant 0
  37 call writeAcc8
  38 ;test11.p(9) }
  39 stop
