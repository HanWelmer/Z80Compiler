   0 ;test2.p(0) /* Program to test branch instructions */
   1 ;test2.p(1) class TestBranches {
   2 ;test2.p(2)   write(9);
   3 acc8= constant 9
   4 call writeAcc8
   5 ;test2.p(3)   int a = 1;
   6 acc8= constant 1
   7 acc8=> variable 0
   8 ;test2.p(4)   if (a == 1) write(8);
   9 acc16= variable 0
  10 acc8= constant 1
  11 acc16CompareAcc8
  12 brne 17
  13 acc8= constant 8
  14 call writeAcc8
  15 ;test2.p(5)   //commentaar.
  16 ;test2.p(6)   if (a != 0) write(7);
  17 acc16= variable 0
  18 acc8= constant 0
  19 acc16CompareAcc8
  20 breq 24
  21 acc8= constant 7
  22 call writeAcc8
  23 ;test2.p(7)   if (a > 0) write(6);
  24 acc16= variable 0
  25 acc8= constant 0
  26 acc16CompareAcc8
  27 brle 31
  28 acc8= constant 6
  29 call writeAcc8
  30 ;test2.p(8)   if (a >= 0) write(5);
  31 acc16= variable 0
  32 acc8= constant 0
  33 acc16CompareAcc8
  34 brlt 38
  35 acc8= constant 5
  36 call writeAcc8
  37 ;test2.p(9)   if (a >= 1) write(4);
  38 acc16= variable 0
  39 acc8= constant 1
  40 acc16CompareAcc8
  41 brlt 45
  42 acc8= constant 4
  43 call writeAcc8
  44 ;test2.p(10)   if (a < 2) write(3);
  45 acc16= variable 0
  46 acc8= constant 2
  47 acc16CompareAcc8
  48 brge 52
  49 acc8= constant 3
  50 call writeAcc8
  51 ;test2.p(11)   if (a <= 2) write(2);
  52 acc16= variable 0
  53 acc8= constant 2
  54 acc16CompareAcc8
  55 brgt 59
  56 acc8= constant 2
  57 call writeAcc8
  58 ;test2.p(12)   if (a <= 1) write(1);
  59 acc16= variable 0
  60 acc8= constant 1
  61 acc16CompareAcc8
  62 brgt 66
  63 acc8= constant 1
  64 call writeAcc8
  65 ;test2.p(13)   write(0);
  66 acc8= constant 0
  67 call writeAcc8
  68 ;test2.p(14) }
  69 stop
