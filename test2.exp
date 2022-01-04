   0 ;test2.p(0) /* Program to test branch instructions */
   1 ;test2.p(1) class TestBranches {
   2 ;test2.p(2)   write(9);
   3 acc8= constant 9
   4 call writeAcc8
   5 ;test2.p(3)   int a = 1;
   6 acc8= constant 1
   7 acc8ToAcc16
   8 acc16=> variable 0
   9 ;test2.p(4)   if (a == 1) write(8);
  10 acc16= variable 0
  11 <acc16
  12 acc16= unstack16
  13 acc8= constant 1
  14 acc16CompareAcc8
  15 brne 20
  16 acc8= constant 8
  17 call writeAcc8
  18 ;test2.p(5)   //commentaar.
  19 ;test2.p(6)   if (a != 0) write(7);
  20 acc16= variable 0
  21 <acc16
  22 acc16= unstack16
  23 acc8= constant 0
  24 acc16CompareAcc8
  25 breq 29
  26 acc8= constant 7
  27 call writeAcc8
  28 ;test2.p(7)   if (a > 0) write(6);
  29 acc16= variable 0
  30 <acc16
  31 acc16= unstack16
  32 acc8= constant 0
  33 acc16CompareAcc8
  34 brle 38
  35 acc8= constant 6
  36 call writeAcc8
  37 ;test2.p(8)   if (a >= 0) write(5);
  38 acc16= variable 0
  39 <acc16
  40 acc16= unstack16
  41 acc8= constant 0
  42 acc16CompareAcc8
  43 brlt 47
  44 acc8= constant 5
  45 call writeAcc8
  46 ;test2.p(9)   if (a >= 1) write(4);
  47 acc16= variable 0
  48 <acc16
  49 acc16= unstack16
  50 acc8= constant 1
  51 acc16CompareAcc8
  52 brlt 56
  53 acc8= constant 4
  54 call writeAcc8
  55 ;test2.p(10)   if (a < 2) write(3);
  56 acc16= variable 0
  57 <acc16
  58 acc16= unstack16
  59 acc8= constant 2
  60 acc16CompareAcc8
  61 brge 65
  62 acc8= constant 3
  63 call writeAcc8
  64 ;test2.p(11)   if (a <= 2) write(2);
  65 acc16= variable 0
  66 <acc16
  67 acc16= unstack16
  68 acc8= constant 2
  69 acc16CompareAcc8
  70 brgt 74
  71 acc8= constant 2
  72 call writeAcc8
  73 ;test2.p(12)   if (a <= 1) write(1);
  74 acc16= variable 0
  75 <acc16
  76 acc16= unstack16
  77 acc8= constant 1
  78 acc16CompareAcc8
  79 brgt 83
  80 acc8= constant 1
  81 call writeAcc8
  82 ;test2.p(13)   write(0);
  83 acc8= constant 0
  84 call writeAcc8
  85 ;test2.p(14) }
  86 stop
