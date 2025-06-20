   0 call 12
   1 stop
   2 ;me\TestPackageMe.j(0) /*
   3 ;me\TestPackageMe.j(1)  * A small program in the miniJava language.
   4 ;me\TestPackageMe.j(2)  * Test something
   5 ;me\TestPackageMe.j(3)  */
   6 ;me\TestPackageMe.j(4) package me;
   7 package me
   8 ;me\TestPackageMe.j(5) 
   9 ;me\TestPackageMe.j(6) class TestPackageMe {
  10 class me.TestPackageMe []
  11 ;me\TestPackageMe.j(7)   static word zero = 0;
  12 acc8= constant 0
  13 acc8=> word variable 0
  14 ;me\TestPackageMe.j(8)   static byte one = 1;
  15 acc8= constant 1
  16 acc8=> byte variable 2
  17 br 19
  18 ;me\TestPackageMe.j(9)   public static void main() {
  19 method me.TestPackageMe.main [public, static] void ()
  20 <basePointer
  21 basePointer= stackPointer
  22 stackPointer+ constant 2
  23 ;me\TestPackageMe.j(10)     println(zero);
  24 acc16= word variable 0
  25 writeLineAcc16
  26 ;me\TestPackageMe.j(11)     println(one);
  27 acc8= byte variable 2
  28 writeLineAcc8
  29 ;me\TestPackageMe.j(12)     println("2 Hallo wereld");
  30 acc16= stringconstant 49
  31 writeLineString
  32 ;me\TestPackageMe.j(13)     String str = "3 Hello too.";
  33 acc16= stringconstant 50
  34 acc16=> String basePointer + 2
  35 ;me\TestPackageMe.j(14)     println(str);
  36 acc16= String basePointer + 2
  37 writeLineString
  38 ;me\TestPackageMe.j(15)     println(4);
  39 acc8= constant 4
  40 writeLineAcc8
  41 ;me\TestPackageMe.j(16)     println("Klaar");
  42 acc16= stringconstant 51
  43 writeLineString
  44 ;me\TestPackageMe.j(17)   }
  45 stackPointer= basePointer
  46 basePointer<
  47 return
  48 ;me\TestPackageMe.j(18) }
  49 stringConstant 0 = "2 Hallo wereld"
  50 stringConstant 1 = "3 Hello too."
  51 stringConstant 2 = "Klaar"
