   0 ;test1.p(0) /* Program to test generated Z80 assembler code */
   1 ;test1.p(1) class TestWhile {
   2 ;test1.p(2)   byte b = 6;
   3 acc8= constant 6
   4 acc8=> variable 0
   5 ;test1.p(3)   int p = 1;
   6 acc8= constant 1
   7 acc8=> variable 1
   8 ;test1.p(4)   while (b > 4) {
   9 acc8= variable 0
  10 acc8Comp constant 4
  11 brle 26
  12 ;test1.p(5)     int test = 1;
  13 acc8= constant 1
  14 acc8=> variable 3
  15 ;test1.p(6)     write(b);
  16 acc8= variable 0
  17 call writeAcc8
  18 ;test1.p(7)     b = b - p;
  19 acc8= variable 0
  20 acc8ToAcc16
  21 acc16- variable 1
  22 acc16=> variable 0
  23 ;test1.p(8)   }
  24 br 9
  25 ;test1.p(9)   p = 4;
  26 acc8= constant 4
  27 acc8=> variable 1
  28 ;test1.p(10)   while (p > 2) {
  29 acc16= variable 1
  30 acc8= constant 2
  31 acc16CompareAcc8
  32 brle 46
  33 ;test1.p(11)     int test = 2;
  34 acc8= constant 2
  35 acc8=> variable 3
  36 ;test1.p(12)     write(p);
  37 acc16= variable 1
  38 call writeAcc16
  39 ;test1.p(13)     p = p - 1;
  40 acc16= variable 1
  41 acc16- constant 1
  42 acc16=> variable 1
  43 ;test1.p(14)   }
  44 br 29
  45 ;test1.p(15)   byte a = 2;
  46 acc8= constant 2
  47 acc8=> variable 3
  48 ;test1.p(16)   while (a >= 1) {
  49 acc8= variable 3
  50 acc8Comp constant 1
  51 brlt 62
  52 ;test1.p(17)     write(a);
  53 acc8= variable 3
  54 call writeAcc8
  55 ;test1.p(18)     a = a - 1;
  56 acc8= variable 3
  57 acc8- constant 1
  58 acc8=> variable 3
  59 ;test1.p(19)   }
  60 br 49
  61 ;test1.p(20)   write(0);
  62 acc8= constant 0
  63 call writeAcc8
  64 ;test1.p(21) }
  65 stop
