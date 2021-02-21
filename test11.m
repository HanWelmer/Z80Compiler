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
 21 accom16 constant 0
 22 brle 32
 23 br 26
 24 decr16 variable 0
 25 br 20
 26 ;test11.p(6)     write(i);
 27 acc16= variable 0
 28 call writeAcc16
 29 ;test11.p(7)   }
 30 br 24
 31 ;test11.p(8)   write(0);
 32 acc8= constant 0
 33 call writeAcc8
 34 ;test11.p(9) }
 35 stop
