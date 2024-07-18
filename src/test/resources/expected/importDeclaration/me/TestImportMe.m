   0 call 12
   1 stop
   2 ;me\TestImportMe.j(0) /*
   3 ;me\TestImportMe.j(1)  * A small program in the miniJava language.
   4 ;me\TestImportMe.j(2)  * Test something
   5 ;me\TestImportMe.j(3)  */
   6 ;me\TestImportMe.j(4) package me;
   7 package me
   8 ;me\TestImportMe.j(5) 
   9 ;me\TestImportMe.j(6) class TestImportMe {
  10 class me.TestImportMe []
  11 ;me\TestImportMe.j(7)   public static void main() {
  12 method me.TestImportMe.main [public, static] void ()
  13 <basePointer
  14 basePointer= stackPointer
  15 stackPointer+ constant 0
  16 ;me\TestImportMe.j(8)     println("TestImportMe Klaar");
  17 acc16= stringconstant 24
  18 writeLineString
  19 ;me\TestImportMe.j(9)   }
  20 stackPointer= basePointer
  21 basePointer<
  22 return
  23 ;me\TestImportMe.j(10) }
  24 stringConstant 0 = "TestImportMe Klaar"
