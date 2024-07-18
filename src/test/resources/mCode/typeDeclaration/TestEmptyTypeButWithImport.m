   0 call 15
   1 stop
   2 ;TestEmptyTypeButWithImport.j(0) /*
   3 ;TestEmptyTypeButWithImport.j(1)  * A small program in the miniJava language.
   4 ;TestEmptyTypeButWithImport.j(2)  * Test empty type declaration but with import.
   5 ;TestEmptyTypeButWithImport.j(3)  */
   6 ;TestEmptyTypeButWithImport.j(4) import TestImport;
   7 import TestImport
   8 ;TestImport.j(0) /*
   9 ;TestImport.j(1)  * A small program in the miniJava language.
  10 ;TestImport.j(2)  * Test something
  11 ;TestImport.j(3)  */
  12 ;TestImport.j(4) class TestImport {
  13 class TestImport []
  14 ;TestImport.j(5)   public static void main() {
  15 method main [public, static] void ()
  16 <basePointer
  17 basePointer= stackPointer
  18 stackPointer+ constant 0
  19 ;TestImport.j(6)     println("TestImport Klaar");
  20 acc16= stringconstant 27
  21 writeLineString
  22 ;TestImport.j(7)   }
  23 stackPointer= basePointer
  24 basePointer<
  25 return
  26 ;TestImport.j(8) }
  27 stringConstant 0 = "TestImport Klaar"
