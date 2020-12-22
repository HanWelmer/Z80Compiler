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
 11 accom16 constant 1
 12 brne 17
 13 acc8= constant 8
 14 call writeAcc8
 15 ;test2.p(5)   //commentaar.
 16 ;test2.p(6)   if (a != 0) write(7);
 17 acc16= variable 0
 18 accom16 constant 0
 19 breq 23
 20 acc8= constant 7
 21 call writeAcc8
 22 ;test2.p(7)   if (a > 0) write(6);
 23 acc16= variable 0
 24 accom16 constant 0
 25 brle 29
 26 acc8= constant 6
 27 call writeAcc8
 28 ;test2.p(8)   if (a >= 0) write(5);
 29 acc16= variable 0
 30 accom16 constant 0
 31 brlt 35
 32 acc8= constant 5
 33 call writeAcc8
 34 ;test2.p(9)   if (a >= 1) write(4);
 35 acc16= variable 0
 36 accom16 constant 1
 37 brlt 41
 38 acc8= constant 4
 39 call writeAcc8
 40 ;test2.p(10)   if (a < 2) write(3);
 41 acc16= variable 0
 42 accom16 constant 2
 43 brge 47
 44 acc8= constant 3
 45 call writeAcc8
 46 ;test2.p(11)   if (a <= 2) write(2);
 47 acc16= variable 0
 48 accom16 constant 2
 49 brgt 53
 50 acc8= constant 2
 51 call writeAcc8
 52 ;test2.p(12)   if (a <= 1) write(1);
 53 acc16= variable 0
 54 accom16 constant 1
 55 brgt 59
 56 acc8= constant 1
 57 call writeAcc8
 58 ;test2.p(13)   write(0);
 59 acc8= constant 0
 60 call writeAcc8
 61 ;test2.p(14) }
 62 stop
