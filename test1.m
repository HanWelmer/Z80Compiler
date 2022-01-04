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
  11 <acc8
  12 acc8= unstack8
  13 acc8Comp constant 4
  14 brle 31
  15 ;test1.p(5)     int test = 1;
  16 acc8= constant 1
  17 acc8ToAcc16
  18 acc16=> variable 3
  19 ;test1.p(6)     write(b);
  20 acc8= variable 0
  21 call writeAcc8
  22 ;test1.p(7)     b = b - p;
  23 acc8= variable 0
  24 acc8ToAcc16
  25 acc16- variable 1
  26 acc16ToAcc8
  27 acc8=> variable 0
  28 ;test1.p(8)   }
  29 br 10
  30 ;test1.p(9)   p = 4;
  31 acc8= constant 4
  32 acc8ToAcc16
  33 acc16=> variable 1
  34 ;test1.p(10)   while (p > 2) {
  35 acc16= variable 1
  36 <acc16
  37 acc16= unstack16
  38 acc8= constant 2
  39 acc16CompareAcc8
  40 brle 55
  41 ;test1.p(11)     int test = 2;
  42 acc8= constant 2
  43 acc8ToAcc16
  44 acc16=> variable 3
  45 ;test1.p(12)     write(p);
  46 acc16= variable 1
  47 call writeAcc16
  48 ;test1.p(13)     p = p - 1;
  49 acc16= variable 1
  50 acc16- constant 1
  51 acc16=> variable 1
  52 ;test1.p(14)   }
  53 br 35
  54 ;test1.p(15)   byte a = 2;
  55 acc8= constant 2
  56 acc8=> variable 3
  57 ;test1.p(16)   while (a >= 1) {
  58 acc8= variable 3
  59 <acc8
  60 acc8= unstack8
  61 acc8Comp constant 1
  62 brlt 73
  63 ;test1.p(17)     write(a);
  64 acc8= variable 3
  65 call writeAcc8
  66 ;test1.p(18)     a = a - 1;
  67 acc8= variable 3
  68 acc8- constant 1
  69 acc8=> variable 3
  70 ;test1.p(19)   }
  71 br 58
  72 ;test1.p(20)   write(0);
  73 acc8= constant 0
  74 call writeAcc8
  75 ;test1.p(21) }
  76 stop
