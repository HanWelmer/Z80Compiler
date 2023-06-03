   0 ;test4.j(0) /* Program to test division */
   1 ;test4.j(1) class TestMultiplyDivide {
   2 ;test4.j(2)   println(0 * 1);
   3 acc8= constant 0
   4 acc8* constant 1
   5 call writeAcc8
   6 ;test4.j(3)   println(1 * 1);
   7 acc8= constant 1
   8 acc8* constant 1
   9 call writeAcc8
  10 ;test4.j(4)   println(4 / 2);
  11 acc8= constant 4
  12 acc8/ constant 2
  13 call writeAcc8
  14 ;test4.j(5)   println(9 / 3);
  15 acc8= constant 9
  16 acc8/ constant 3
  17 call writeAcc8
  18 ;test4.j(6)   println(8 / 2);
  19 acc8= constant 8
  20 acc8/ constant 2
  21 call writeAcc8
  22 ;test4.j(7)   println(5 / 1);
  23 acc8= constant 5
  24 acc8/ constant 1
  25 call writeAcc8
  26 ;test4.j(8)   println((3 * 8) / 4);
  27 acc8= constant 3
  28 acc8* constant 8
  29 acc8/ constant 4
  30 call writeAcc8
  31 ;test4.j(9)   println((7 * 7) / 7);
  32 acc8= constant 7
  33 acc8* constant 7
  34 acc8/ constant 7
  35 call writeAcc8
  36 ;test4.j(10)   println((4 * 5 * 2) / 5);
  37 acc8= constant 4
  38 acc8* constant 5
  39 acc8* constant 2
  40 acc8/ constant 5
  41 call writeAcc8
  42 ;test4.j(11)   println(6561 / 729);
  43 acc16= constant 6561
  44 acc16/ constant 729
  45 call writeAcc16
  46 ;test4.j(12)   println(60 / 6);
  47 acc8= constant 60
  48 acc8/ constant 6
  49 call writeAcc8
  50 ;test4.j(13)   println(22 / 2);
  51 acc8= constant 22
  52 acc8/ constant 2
  53 call writeAcc8
  54 ;test4.j(14)   println(12);
  55 acc8= constant 12
  56 call writeAcc8
  57 ;test4.j(15)   println("Klaar");
  58 acc16= constant 62
  59 writeString
  60 ;test4.j(16) }
  61 stop
  62 stringConstant 0 = "Klaar"
