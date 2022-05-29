   0 ;test.p(0) /*
   1 ;test.p(1)  * A small program in the miniJava language.
   2 ;test.p(2)  * Test comparisons
   3 ;test.p(3)  */
   4 ;test.p(4) class TestIf {
   5 ;test.p(5)   int zero = 0;
   6 acc8= constant 0
   7 acc8ToAcc16
   8 acc16=> variable 0
   9 ;test.p(6)   int one = 1;
  10 acc8= constant 1
  11 acc8ToAcc16
  12 acc16=> variable 2
  13 ;test.p(7)   int four = 4;
  14 acc8= constant 4
  15 acc8ToAcc16
  16 acc16=> variable 4
  17 ;test.p(8)   int twelve = 12;
  18 acc8= constant 12
  19 acc8ToAcc16
  20 acc16=> variable 6
  21 ;test.p(9)   byte byteOne = 1;
  22 acc8= constant 1
  23 acc8=> variable 8
  24 ;test.p(10)   write(6);
  25 acc8= constant 6
  26 call writeAcc8
  27 ;test.p(11)   /*
  28 ;test.p(12)   if (4 == (zero + twelve/(1+2))) write(2);
  29 ;test.p(13)   //gewenste code voor regel 26: if (four == (0 + 12/(one+2))) write(1);
  30 ;test.p(14)   //                            acc8  acc16 F   stack
  31 ;test.p(15)   // 44 acc16= variable 4       -     4         []
  32 ;test.p(16)   // 45 <acc16                  0     4         [int4]
  33 ;test.p(17)   // 46 acc8= constant 0        0     4         [int4]
  34 ;test.p(18)   // 47 <acc8= constant 12      12    4         [int4, b0]
  35 ;test.p(19)   // 48 acc16= variable 2       12    1         [int4, b0]
  36 ;test.p(20)   // 49 acc16+ constant 2       12    3         [int4, b0]
  37 ;test.p(21)   // 50 /acc16 acc8             12    4         [int4, b0]
  38 ;test.p(22)   // 51 acc16+ unstack8         12    4         [int4]
  39 ;test.p(23)   // 52 revAcc16Comp unstack16  12    4     Z   []
  40 ;test.p(24)   // 53 brne 57
  41 ;test.p(25)   */
  42 ;test.p(26)   //if (four == (0 + 12/(one+2))) write(2);
  43 ;test.p(27)   if (four == (0 + 12/(one + 2))) write(5);
  44 acc16= variable 4
  45 <acc16
  46 acc8= constant 0
  47 <acc8= constant 12
  48 acc16= variable 2
  49 acc16+ constant 2
  50 /acc16 acc8
  51 acc16+ unstack8
  52 revAcc16Comp unstack16
  53 brne 57
  54 acc8= constant 5
  55 call writeAcc8
  56 ;test.p(28)   if (four == (0 + 12/(byteOne + 2))) write(4);
  57 acc16= variable 4
  58 <acc16
  59 acc8= constant 0
  60 <acc8= constant 12
  61 <acc8= variable 8
  62 acc8+ constant 2
  63 /acc8 unstack8
  64 acc8+ unstack8
  65 acc16= unstack16
  66 acc16CompareAcc8
  67 brne 71
  68 acc8= constant 4
  69 call writeAcc8
  70 ;test.p(29)   if (four == (0 + 12/(1 + 2))) write(3);
  71 acc16= variable 4
  72 <acc16
  73 acc8= constant 0
  74 <acc8= constant 12
  75 <acc8= constant 1
  76 acc8+ constant 2
  77 /acc8 unstack8
  78 acc8+ unstack8
  79 acc16= unstack16
  80 acc16CompareAcc8
  81 brne 85
  82 acc8= constant 3
  83 call writeAcc8
  84 ;test.p(30)   if (four == 0 + 12/(1 + 2)) write(2);
  85 acc16= variable 4
  86 <acc16
  87 acc8= constant 0
  88 <acc8= constant 12
  89 <acc8= constant 1
  90 acc8+ constant 2
  91 /acc8 unstack8
  92 acc8+ unstack8
  93 acc16= unstack16
  94 acc16CompareAcc8
  95 brne 99
  96 acc8= constant 2
  97 call writeAcc8
  98 ;test.p(31)   write(one);
  99 acc16= variable 2
 100 call writeAcc16
 101 ;test.p(32)   write(zero);
 102 acc16= variable 0
 103 call writeAcc16
 104 ;test.p(33) }
 105 stop
