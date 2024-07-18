   0 call 34
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
  17 ;me\TestImportMe.j(7)   public static void main() {
  18 method me.TestImportMe.main [public, static] void ()
  19 <basePointer
  20 basePointer= stackPointer
  21 stackPointer+ constant 0
  22 ;me\TestImportMe.j(8)     println("TestImportMe Klaar");
  23 acc16= stringconstant 46
  24 writeLineString
  25 ;me\TestImportMe.j(9)   }
  26 stackPointer= basePointer
  27 basePointer<
  28 return
  29 ;me\TestImportMe.j(10) }
  30 ;TestImportMe.j(5) 
  31 ;TestImportMe.j(6) class TestMeImportMe {
  32 class TestMeImportMe []
  33 ;TestImportMe.j(7)   public static void main() {
  34 method TestMeImportMe.main [public, static] void ()
  35 <basePointer
  36 basePointer= stackPointer
  37 stackPointer+ constant 0
  38 ;TestImportMe.j(8)     println("TestImportMe Klaar");
  39 acc16= stringconstant 46
  40 writeLineString
  41 ;TestImportMe.j(9)   }
  42 stackPointer= basePointer
  43 basePointer<
  44 return
  45 ;TestImportMe.j(10) }
  46 stringConstant 0 = "TestImportMe Klaar"
