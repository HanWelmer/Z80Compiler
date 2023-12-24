   0 ;me\TestPackageMe.j(0) /*
   1 ;me\TestPackageMe.j(1)  * A small program in the miniJava language.
   2 ;me\TestPackageMe.j(2)  * Test something
   3 ;me\TestPackageMe.j(3)  */
   4 ;me\TestPackageMe.j(4) package me;
   5 ;me\TestPackageMe.j(5) 
   6 ;me\TestPackageMe.j(6) class TestPackageMe {
   7 ;me\TestPackageMe.j(7)   word zero = 0;
   8 acc8= constant 0
   9 acc8=> variable 0
  10 ;me\TestPackageMe.j(8)   byte one = 1;
  11 acc8= constant 1
  12 acc8=> variable 2
  13 ;me\TestPackageMe.j(9)   println(0);
  14 acc8= constant 0
  15 call writeLineAcc8
  16 ;me\TestPackageMe.j(10)   println(one);
  17 acc8= variable 2
  18 call writeLineAcc8
  19 ;me\TestPackageMe.j(11)   println("2 Hallo wereld");
  20 acc16= constant 36
  21 writeLineString
  22 ;me\TestPackageMe.j(12)   String str = "3 Hello too.";
  23 acc16= constant 37
  24 acc16=> variable 3
  25 ;me\TestPackageMe.j(13)   println(str);
  26 acc16= variable 3
  27 writeLineString
  28 ;me\TestPackageMe.j(14)   println(4);
  29 acc8= constant 4
  30 call writeLineAcc8
  31 ;me\TestPackageMe.j(15)   println("Klaar");
  32 acc16= constant 38
  33 writeLineString
  34 ;me\TestPackageMe.j(16) }
  35 stop
  36 stringConstant 0 = "2 Hallo wereld"
  37 stringConstant 1 = "3 Hello too."
  38 stringConstant 2 = "Klaar"
