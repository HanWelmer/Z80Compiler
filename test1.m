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
  32 acc8= constant 2
  33 acc16CompareAcc8
  34 brle 48
  35 ;test1.p(11)     int test = 2;
  36 acc8= constant 2
  37 acc8=> variable 3
  38 ;test1.p(12)     write(p);
  39 acc16= variable 1
  40 call writeAcc16
  41 ;test1.p(13)     p = p - 1;
  42 acc16= variable 1
  43 acc16- constant 1
  44 acc16=> variable 1
  45 ;test1.p(14)   }
  46 br 31
  47 ;test1.p(15)   byte a = 2;
  48 acc8= constant 2
  49 acc8=> variable 3
  50 ;test1.p(16)   while (a >= 1) {
  51 acc8= variable 3
  52 <acc8
  53 acc8= unstack8
  54 acc8Comp constant 1
  55 brlt 66
  56 ;test1.p(17)     write(a);
  57 acc8= variable 3
  58 call writeAcc8
  59 ;test1.p(18)     a = a - 1;
  60 acc8= variable 3
  61 acc8- constant 1
  62 acc8=> variable 3
  63 ;test1.p(19)   }
  64 br 51
  65 ;test1.p(20)   write(0);
  66 acc8= constant 0
  67 call writeAcc8
  68 ;test1.p(21) }
  69 stop
