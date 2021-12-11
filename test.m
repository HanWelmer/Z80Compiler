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
 21 ;test.p(9)   write(3);
 22 acc8= constant 3
 23 call writeAcc8
 24 ;test.p(10)   if (4 == (zero + twelve/(1+2))) write(2);
 25 acc8= constant 4
 26 acc16= variable 0
 27 <acc8
 28 <acc16= variable 6
 29 acc8= constant 1
 30 acc8+ constant 2
 31 acc16/ acc8
 32 acc16+ unstack16
 33 revAcc16Comp unstack8
 34 brne 38
 35 acc8= constant 2
 36 call writeAcc8
 37 ;test.p(11)   if (four == (0 + 12/(one+2))) write(1);
                            acc8  acc16 stack
 38 acc16= variable 4       -     4     -
 39 acc8= constant 0        0     4     -
 40 <acc16                  0     4     int4
 41 <acc8= constant 12      12    4     b0  int4
 42 acc16= variable 2       12    1     b0  int4
 43 acc16+ constant 2       12    3     b0  int4
 44 /acc16 acc8             12    4     b0  int4
 45 acc16+ acc8             12    16    b0  int4
 46 revAcc16Comp unstack16  
 47 brne 51
gewenste code:
 37 ;test.p(11)   if (four == (0 + 12/(one+2))) write(1);
                            acc8  acc16 F   stack
 38 acc16= variable 4       -     4         -
 39 acc8= constant 0        0     4         -
 40 <acc16                  0     4         int4
 41 <acc8= constant 12      12    4         b0  int4
 42 acc16= variable 2       12    1         b0  int4
 43 acc16+ constant 2       12    3         b0  int4
 44 /acc16 acc8             12    4         b0  int4
 45 acc16+ unstack8         12    4         int4
 46 revAcc16Comp unstack16  12    4     Z
 47 brne 51

 48 acc8= constant 1
 49 call writeAcc8
 50 ;test.p(12)   write(0);
 51 acc8= constant 0
 52 call writeAcc8
 53 ;test.p(13) }
 54 stop
