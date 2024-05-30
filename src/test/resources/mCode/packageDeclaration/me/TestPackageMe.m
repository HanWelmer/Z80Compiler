   0 call 18
   1 stop
   2 ;me\TestPackageMe.j(0) /*
   3 ;me\TestPackageMe.j(1)  * A small program in the miniJava language.
   4 ;me\TestPackageMe.j(2)  * Test something
   5 ;me\TestPackageMe.j(3)  */
   6 ;me\TestPackageMe.j(4) package me;
   7 package me
   8 ;me\TestPackageMe.j(5) 
   9 ;me\TestPackageMe.j(6) class TestPackageMe {
  10 class TestPackageMe []
  11 ;me\TestPackageMe.j(7)   static word zero = 0;
  12 acc8= constant 0
  13 acc8=> variable 0
  14 ;me\TestPackageMe.j(8)   static byte one = 1;
  15 acc8= constant 1
  16 acc8=> variable 2
  17 ;me\TestPackageMe.j(9)   public static void main() {
  18 method main [public, static] void ()
  19 <basePointer
  20 basePointer= stackPointer
  21 stackPointer+ constant 2
  22 ;me\TestPackageMe.j(10)     println(zero);
  23 acc16= variable 0
  24 writeLineAcc16
  25 ;me\TestPackageMe.j(11)     println(one);
  26 acc8= variable 2
  27 writeLineAcc8
  28 ;me\TestPackageMe.j(12)     println("2 Hallo wereld");
  29 acc16= stringconstant 48
  30 writeLineString
  31 ;me\TestPackageMe.j(13)     String str = "3 Hello too.";
  32 acc16= stringconstant 49
  33 acc16=> (basePointer + -2)
  34 ;me\TestPackageMe.j(14)     println(str);
  35 acc16= (basePointer + -2)
  36 writeLineString
  37 ;me\TestPackageMe.j(15)     println(4);
  38 acc8= constant 4
  39 writeLineAcc8
  40 ;me\TestPackageMe.j(16)     println("Klaar");
  41 acc16= stringconstant 50
  42 writeLineString
  43 ;me\TestPackageMe.j(17)   }
  44 stackPointer= basePointer
  45 basePointer<
  46 return
  47 ;me\TestPackageMe.j(18) }
  48 stringConstant 0 = "2 Hallo wereld"
  49 stringConstant 1 = "3 Hello too."
  50 stringConstant 2 = "Klaar"
