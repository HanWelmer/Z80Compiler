   0 call 46
   1 stop
   2 ;TestImportMe.j(0) /*
   3 ;TestImportMe.j(1)  * A small program in the miniJava language.
   4 ;TestImportMe.j(2)  * Test something
   5 ;TestImportMe.j(3)  */
   6 ;TestImportMe.j(4) import me.TestImportMe;
   7 import me.TestImportMe
   8 ;me\TestImportMe.j(0) /*
   9 ;me\TestImportMe.j(1)  * A small program in the miniJava language.
  10 ;me\TestImportMe.j(2)  * Test something
  11 ;me\TestImportMe.j(3)  */
  12 ;me\TestImportMe.j(4) package me;
  13 package me
  14 ;me\TestImportMe.j(5) 
  15 ;me\TestImportMe.j(6) class TestImportMe {
  16 class me.TestImportMe []
  17 ;me\TestImportMe.j(7)   private static void doIt() {
  18 method me.TestImportMe.doIt [private, static] void ()
  19 <basePointer
  20 basePointer= stackPointer
  21 stackPointer+ constant 0
  22 ;me\TestImportMe.j(8)     println("TestImportMe");
  23 acc16= stringconstant 58
  24 writeLineString
  25 ;me\TestImportMe.j(9)   }
  26 stackPointer= basePointer
  27 basePointer<
  28 return
  29 ;me\TestImportMe.j(10)   
  30 ;me\TestImportMe.j(11)   public static void main() {
  31 method me.TestImportMe.main [public, static] void ()
  32 <basePointer
  33 basePointer= stackPointer
  34 stackPointer+ constant 0
  35 ;me\TestImportMe.j(12)     doIt();
  36 call 18
  37 ;me\TestImportMe.j(13)   }
  38 stackPointer= basePointer
  39 basePointer<
  40 return
  41 ;me\TestImportMe.j(14) }
  42 ;TestImportMe.j(5) 
  43 ;TestImportMe.j(6) class TestMeImportMe {
  44 class TestMeImportMe []
  45 ;TestImportMe.j(7)   public static void main() {
  46 method TestMeImportMe.main [public, static] void ()
  47 <basePointer
  48 basePointer= stackPointer
  49 stackPointer+ constant 0
  50 ;TestImportMe.j(8)     println("TestImportMe Klaar");
  51 acc16= stringconstant 59
  52 writeLineString
  53 ;TestImportMe.j(9)   }
  54 stackPointer= basePointer
  55 basePointer<
  56 return
  57 ;TestImportMe.j(10) }
  58 stringConstant 0 = "TestImportMe"
  59 stringConstant 1 = "TestImportMe Klaar"
