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
  10 <acc8
  11 acc8= unstack8
  12 acc8Comp constant 4
  13 brle 28
  14 ;test1.p(5)     int test = 1;
  15 acc8= constant 1
  16 acc8=> variable 3
  17 ;test1.p(6)     write(b);
  18 acc8= variable 0
  19 call writeAcc8
  20 ;test1.p(7)     b = b - p;
  21 acc8= variable 0
  22 acc8ToAcc16
  23 acc16- variable 1
  24 acc16=> variable 0
  25 ;test1.p(8)   }
  26 br 9
  27 ;test1.p(9)   p = 4;
  28 acc8= constant 4
  29 acc8=> variable 1
  30 ;test1.p(10)   while (p > 2) {
  31 acc16= variable 1
  32 <acc16
  33 acc16= unstack16
  34 acc8= constant 2
  35 acc16CompareAcc8
  36 brle 50
  37 ;test1.p(11)     int test = 2;
  38 acc8= constant 2
  39 acc8=> variable 3
  40 ;test1.p(12)     write(p);
  41 acc16= variable 1
  42 call writeAcc16
  43 ;test1.p(13)     p = p - 1;
  44 acc16= variable 1
  45 acc16- constant 1
  46 acc16=> variable 1
  47 ;test1.p(14)   }
  48 br 31
  49 ;test1.p(15)   byte a = 2;
  50 acc8= constant 2
  51 acc8=> variable 3
  52 ;test1.p(16)   while (a >= 1) {
  53 acc8= variable 3
  54 <acc8
  55 acc8= unstack8
  56 acc8Comp constant 1
  57 brlt 68
  58 ;test1.p(17)     write(a);
  59 acc8= variable 3
  60 call writeAcc8
  61 ;test1.p(18)     a = a - 1;
  62 acc8= variable 3
  63 acc8- constant 1
  64 acc8=> variable 3
  65 ;test1.p(19)   }
  66 br 53
  67 ;test1.p(20)   write(0);
  68 acc8= constant 0
  69 call writeAcc8
  70 ;test1.p(21) }
  71 stop
