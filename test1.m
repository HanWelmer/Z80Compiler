  0 ;test1.p(0) /* Program to test generated Z80 assembler code */
  1 ;test1.p(1) class TestWhile {
  2 ;test1.p(2)   byte b = 6;
  3 acc8= constant 6
  4 acc8=> variable 0
  5 ;test1.p(3)   int p = 1;
  6 acc8= constant 1
  7 acc8ToAcc16
  8 acc16=> variable 1
  9 ;test1.p(4)   while (b > 4) {
 10 acc8= variable 0
 11 accom8 constant 4
 12 brle 29
 13 ;test1.p(5)     int test = 1;
 14 acc8= constant 1
 15 acc8ToAcc16
 16 acc16=> variable 3
 17 ;test1.p(6)     write(b);
 18 acc8= variable 0
 19 call writeAcc8
 20 ;test1.p(7)     b = b - p;
 21 acc8= variable 0
 22 acc8ToAcc16
 23 acc16- variable 1
 24 acc16ToAcc8
 25 acc8=> variable 0
 26 ;test1.p(8)   }
 27 br 10
 28 ;test1.p(9)   p = 4;
 29 acc8= constant 4
 30 acc8ToAcc16
 31 acc16=> variable 1
 32 ;test1.p(10)   while (p > 2) {
 33 acc16= variable 1
 34 accom16 constant 2
 35 brle 50
 36 ;test1.p(11)     int test = 2;
 37 acc8= constant 2
 38 acc8ToAcc16
 39 acc16=> variable 3
 40 ;test1.p(12)     write(p);
 41 acc16= variable 1
 42 call writeAcc16
 43 ;test1.p(13)     p = p - 1;
 44 acc16= variable 1
 45 acc16- constant 1
 46 acc16=> variable 1
 47 ;test1.p(14)   }
 48 br 33
 49 ;test1.p(15)   byte a = 2;
 50 acc8= constant 2
 51 acc8=> variable 3
 52 ;test1.p(16)   while (a >= 1) {
 53 acc8= variable 3
 54 accom8 constant 1
 55 brlt 66
 56 ;test1.p(17)     write(a);
 57 acc8= variable 3
 58 call writeAcc8
 59 ;test1.p(18)     a = a - 1;
 60 acc8= variable 3
 61 acc8- constant 1
 62 acc8=> variable 3
 63 ;test1.p(19)   }
 64 br 53
 65 ;test1.p(20)   write(0);
 66 acc8= constant 0
 67 call writeAcc8
 68 ;test1.p(21) }
 69 stop
