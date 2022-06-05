   0 ;test.p(0) /*
   1 ;test.p(1)  * A small program in the miniJava language.
   2 ;test.p(2)  * Test comparisons
   3 ;test.p(3)  */
   4 ;test.p(4) class TestIf {
   5 ;test.p(5)   int zero = 0;
   6 acc8= constant 0
   7 acc8=> variable 0
   8 ;test.p(6)   int one = 1;
   9 acc8= constant 1
  10 acc8=> variable 2
  11 ;test.p(7)   int four = 4;
  12 acc8= constant 4
  13 acc8=> variable 4
  14 ;test.p(8)   int twelve = 12;
  15 acc8= constant 12
  16 acc8=> variable 6
  17 ;test.p(9)   byte byteOne = 1;
  18 acc8= constant 1
  19 acc8=> variable 8
  20 ;test.p(10)   byte byteSix = 262;
  21 acc16= constant 262
  22 acc16=> variable 9
  23 ;test.p(11)   write(7);
  24 acc8= constant 7
  25 call writeAcc8
  26 ;test.p(12)   write(byteSix);
  27 acc8= variable 9
  28 call writeAcc8
  29 ;test.p(13)   /*
  30 ;test.p(14)   if (4 == (zero + twelve/(1+2))) write(2);
  31 ;test.p(15)   //gewenste code voor regel 26: if (four == (0 + 12/(one+2))) write(1);
  32 ;test.p(16)   //                            acc8  acc16 F   stack
  33 ;test.p(17)   // 44 acc16= variable 4       -     4         []
  34 ;test.p(18)   // 45 <acc16                  0     4         [int4]
  35 ;test.p(19)   // 46 acc8= constant 0        0     4         [int4]
  36 ;test.p(20)   // 47 <acc8= constant 12      12    4         [int4, b0]
  37 ;test.p(21)   // 48 acc16= variable 2       12    1         [int4, b0]
  38 ;test.p(22)   // 49 acc16+ constant 2       12    3         [int4, b0]
  39 ;test.p(23)   // 50 /acc16 acc8             12    4         [int4, b0]
  40 ;test.p(24)   // 51 acc16+ unstack8         12    4         [int4]
  41 ;test.p(25)   // 52 revAcc16Comp unstack16  12    4     Z   []
  42 ;test.p(26)   // 53 brne 57
  43 ;test.p(27)   */
  44 ;test.p(28)   //if (four == (0 + 12/(one+2))) write(2);
  45 ;test.p(29)   if (four == (0 + 12/(one + 2))) write(5);
  46 acc16= variable 4
  47 <acc16
  48 acc8= constant 0
  49 <acc8= constant 12
  50 acc16= variable 2
  51 acc16+ constant 2
  52 /acc16 acc8
  53 acc16+ unstack8
  54 revAcc16Comp unstack16
  55 brne 59
  56 acc8= constant 5
  57 call writeAcc8
  58 ;test.p(30)   if (four == (0 + 12/(byteOne + 2))) write(4);
  59 acc16= variable 4
  60 <acc16
  61 acc8= constant 0
  62 <acc8= constant 12
  63 <acc8= variable 8
  64 acc8+ constant 2
  65 /acc8 unstack8
  66 acc8+ unstack8
  67 acc16= unstack16
  68 acc16CompareAcc8
  69 brne 73
  70 acc8= constant 4
  71 call writeAcc8
  72 ;test.p(31)   if (four == (0 + 12/(1 + 2))) write(3);
  73 acc16= variable 4
  74 <acc16
  75 acc8= constant 0
  76 <acc8= constant 12
  77 <acc8= constant 1
  78 acc8+ constant 2
  79 /acc8 unstack8
  80 acc8+ unstack8
  81 acc16= unstack16
  82 acc16CompareAcc8
  83 brne 87
  84 acc8= constant 3
  85 call writeAcc8
  86 ;test.p(32)   if (four == 0 + 12/(1 + 2)) write(2);
  87 acc16= variable 4
  88 <acc16
  89 acc8= constant 0
  90 <acc8= constant 12
  91 <acc8= constant 1
  92 acc8+ constant 2
  93 /acc8 unstack8
  94 acc8+ unstack8
  95 acc16= unstack16
  96 acc16CompareAcc8
  97 brne 101
  98 acc8= constant 2
  99 call writeAcc8
 100 ;test.p(33)   write(byteOne);
 101 acc8= variable 8
 102 call writeAcc8
 103 ;test.p(34)   write(zero);
 104 acc16= variable 0
 105 call writeAcc16
 106 ;test.p(35) }
 107 stop
