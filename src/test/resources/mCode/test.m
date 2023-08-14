   0 ;test.j(0) /*
   1 ;test.j(1)  * A small program in the miniJava language.
   2 ;test.j(2)  * Test something
   3 ;test.j(3)  */
   4 ;test.j(4) package me;
   5 ;test.j(5) 
   6 ;test.j(6) class TestWrite {
   7 ;test.j(7)   word zero = 0;
   8 acc8= constant 0
   9 acc8=> variable 0
  10 ;test.j(8)   byte one = 1;
  11 acc8= constant 1
  12 acc8=> variable 2
  13 ;test.j(9)   println(0);
  14 acc8= constant 0
  15 call writeLineAcc8
  16 ;test.j(10)   println(one);
  17 acc8= variable 2
  18 call writeLineAcc8
  19 ;test.j(11)   println("2 Hallo wereld");
  20 acc16= constant 36
  21 writeLineString
  22 ;test.j(12)   String str = "3 Hello too.";
  23 acc16= constant 37
  24 acc16=> variable 3
  25 ;test.j(13)   println(str);
  26 acc16= variable 3
  27 writeLineString
  28 ;test.j(14)   println(4);
  29 acc8= constant 4
  30 call writeLineAcc8
  31 ;test.j(15)   println("Klaar");
  32 acc16= constant 38
  33 writeLineString
  34 ;test.j(16) }
  35 stop
  36 stringConstant 0 = "2 Hallo wereld"
  37 stringConstant 1 = "3 Hello too."
  38 stringConstant 2 = "Klaar"
