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
  21 ;test.p(9)   write(2);
  22 acc8= constant 2
  23 call writeAcc8
  24 ;test.p(10)   /*
  25 ;test.p(11)   if (4 == (zero + twelve/(1+2))) write(2);
  26 ;test.p(12)   //gewenste code voor regel 26: if (four == (0 + 12/(one+2))) write(1);
  27 ;test.p(13)   //                            acc8  acc16 F   stack
  28 ;test.p(14)   // 40 acc16= variable 4       -     4         []
  29 ;test.p(15)   // 41 <acc16                  0     4         [int4]
  30 ;test.p(16)   // 42 acc8= constant 0        0     4         [int4]
  31 ;test.p(17)   // 43 <acc8= constant 12      12    4         [int4, b0]
  32 ;test.p(18)   // 44 acc16= variable 2       12    1         [int4, b0]
  33 ;test.p(19)   // 45 acc16+ constant 2       12    3         [int4, b0]
  34 ;test.p(20)   // 46 /acc16 acc8             12    4         [int4, b0]
  35 ;test.p(21)   // 47 acc16+ unstack8         12    4         [int4]
  36 ;test.p(22)   // 48 revAcc16Comp unstack16  12    4     Z   []
  37 ;test.p(23)   // 49 brne 53
  38 ;test.p(24)   */
  39 ;test.p(25)   if (four == (0 + 12/(one+2))) write(1);
  40 acc16= variable 4
  41 <acc16
  42 acc8= constant 0
  43 <acc8= constant 12
  44 acc16= variable 2
  45 acc16+ constant 2
  46 /acc16 acc8
  47 acc16+ acc8
  48 revAcc16Comp unstack16
  49 brne 53
  50 acc8= constant 1
  51 call writeAcc8
  52 ;test.p(26)   write(0);
  53 acc8= constant 0
  54 call writeAcc8
  55 ;test.p(27) }
  56 stop
