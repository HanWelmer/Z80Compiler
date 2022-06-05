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
  10 <acc16
  11 acc16= unstack16
  12 acc8= constant 1
  13 acc16CompareAcc8
  14 brne 19
  15 acc8= constant 8
  16 call writeAcc8
  17 ;test2.p(5)   //commentaar.
  18 ;test2.p(6)   if (a != 0) write(7);
  19 acc16= variable 0
  20 <acc16
  21 acc16= unstack16
  22 acc8= constant 0
  23 acc16CompareAcc8
  24 breq 28
  25 acc8= constant 7
  26 call writeAcc8
  27 ;test2.p(7)   if (a > 0) write(6);
  28 acc16= variable 0
  29 <acc16
  30 acc16= unstack16
  31 acc8= constant 0
  32 acc16CompareAcc8
  33 brle 37
  34 acc8= constant 6
  35 call writeAcc8
  36 ;test2.p(8)   if (a >= 0) write(5);
  37 acc16= variable 0
  38 <acc16
  39 acc16= unstack16
  40 acc8= constant 0
  41 acc16CompareAcc8
  42 brlt 46
  43 acc8= constant 5
  44 call writeAcc8
  45 ;test2.p(9)   if (a >= 1) write(4);
  46 acc16= variable 0
  47 <acc16
  48 acc16= unstack16
  49 acc8= constant 1
  50 acc16CompareAcc8
  51 brlt 55
  52 acc8= constant 4
  53 call writeAcc8
  54 ;test2.p(10)   if (a < 2) write(3);
  55 acc16= variable 0
  56 <acc16
  57 acc16= unstack16
  58 acc8= constant 2
  59 acc16CompareAcc8
  60 brge 64
  61 acc8= constant 3
  62 call writeAcc8
  63 ;test2.p(11)   if (a <= 2) write(2);
  64 acc16= variable 0
  65 <acc16
  66 acc16= unstack16
  67 acc8= constant 2
  68 acc16CompareAcc8
  69 brgt 73
  70 acc8= constant 2
  71 call writeAcc8
  72 ;test2.p(12)   if (a <= 1) write(1);
  73 acc16= variable 0
  74 <acc16
  75 acc16= unstack16
  76 acc8= constant 1
  77 acc16CompareAcc8
  78 brgt 82
  79 acc8= constant 1
  80 call writeAcc8
  81 ;test2.p(13)   write(0);
  82 acc8= constant 0
  83 call writeAcc8
  84 ;test2.p(14) }
  85 stop
