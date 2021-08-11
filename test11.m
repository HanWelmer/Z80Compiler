  0 ;test11.p(0) /* Program to test generated Z80 assembler code */
  1 ;test11.p(1) class TestFor {
  2 ;test11.p(2)   for(byte b = 4; b>2; b--) {
  3 acc8= constant 4
  4 acc8=> variable 0
  5 acc8= variable 0
  6 accom8 constant 2
  7 brle 17
  8 br 11
  9 decr8 variable 0
 10 br 5
 11 ;test11.p(3)     write(b);
 12 acc8= variable 0
 13 call writeAcc8
 14 ;test11.p(4)   }
 15 br 9
 16 ;test11.p(5)   for(int i = 2; i>0; i--) {
 17 acc8= constant 2
 18 acc8ToAcc16
 19 acc16=> variable 0
 20 acc16= variable 0
 21 acc8= constant 0
 22 acc16CompareAcc8
 23 brle 33
 24 br 27
 25 decr16 variable 0
 26 br 20
 27 ;test11.p(6)     write(i);
 28 acc16= variable 0
 29 call writeAcc16
 30 ;test11.p(7)   }
 31 br 25
 32 ;test11.p(8)   write(0);
 33 acc8= constant 0
 34 call writeAcc8
 35 ;test11.p(9) }
 36 stop
