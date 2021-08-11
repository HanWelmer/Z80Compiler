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
 34 acc8= constant 2
 35 acc16CompareAcc8
 36 brle 51
 37 ;test1.p(11)     int test = 2;
 38 acc8= constant 2
 39 acc8ToAcc16
 40 acc16=> variable 3
 41 ;test1.p(12)     write(p);
 42 acc16= variable 1
 43 call writeAcc16
 44 ;test1.p(13)     p = p - 1;
 45 acc16= variable 1
 46 acc16- constant 1
 47 acc16=> variable 1
 48 ;test1.p(14)   }
 49 br 33
 50 ;test1.p(15)   byte a = 2;
 51 acc8= constant 2
 52 acc8=> variable 3
 53 ;test1.p(16)   while (a >= 1) {
 54 acc8= variable 3
 55 accom8 constant 1
 56 brlt 67
 57 ;test1.p(17)     write(a);
 58 acc8= variable 3
 59 call writeAcc8
 60 ;test1.p(18)     a = a - 1;
 61 acc8= variable 3
 62 acc8- constant 1
 63 acc8=> variable 3
 64 ;test1.p(19)   }
 65 br 54
 66 ;test1.p(20)   write(0);
 67 acc8= constant 0
 68 call writeAcc8
 69 ;test1.p(21) }
 70 stop
