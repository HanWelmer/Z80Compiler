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
 11 acc8= constant 1
 12 acc16CompareAcc8
 13 brne 18
 14 acc8= constant 8
 15 call writeAcc8
 16 ;test2.p(5)   //commentaar.
 17 ;test2.p(6)   if (a != 0) write(7);
 18 acc16= variable 0
 19 acc8= constant 0
 20 acc16CompareAcc8
 21 breq 25
 22 acc8= constant 7
 23 call writeAcc8
 24 ;test2.p(7)   if (a > 0) write(6);
 25 acc16= variable 0
 26 acc8= constant 0
 27 acc16CompareAcc8
 28 brle 32
 29 acc8= constant 6
 30 call writeAcc8
 31 ;test2.p(8)   if (a >= 0) write(5);
 32 acc16= variable 0
 33 acc8= constant 0
 34 acc16CompareAcc8
 35 brlt 39
 36 acc8= constant 5
 37 call writeAcc8
 38 ;test2.p(9)   if (a >= 1) write(4);
 39 acc16= variable 0
 40 acc8= constant 1
 41 acc16CompareAcc8
 42 brlt 46
 43 acc8= constant 4
 44 call writeAcc8
 45 ;test2.p(10)   if (a < 2) write(3);
 46 acc16= variable 0
 47 acc8= constant 2
 48 acc16CompareAcc8
 49 brge 53
 50 acc8= constant 3
 51 call writeAcc8
 52 ;test2.p(11)   if (a <= 2) write(2);
 53 acc16= variable 0
 54 acc8= constant 2
 55 acc16CompareAcc8
 56 brgt 60
 57 acc8= constant 2
 58 call writeAcc8
 59 ;test2.p(12)   if (a <= 1) write(1);
 60 acc16= variable 0
 61 acc8= constant 1
 62 acc16CompareAcc8
 63 brgt 67
 64 acc8= constant 1
 65 call writeAcc8
 66 ;test2.p(13)   write(0);
 67 acc8= constant 0
 68 call writeAcc8
 69 ;test2.p(14) }
 70 stop
