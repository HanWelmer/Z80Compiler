   0 call 12
   1 stop
   2 ;TestImport.j(0) /*
   3 ;TestImport.j(1)  * A small program in the miniJava language.
   4 ;TestImport.j(2)  * Test something
   5 ;TestImport.j(3)  */
   6 ;TestImport.j(4) import TestImport;
   7 import TestImport
   8 ;TestImport.j(5) 
   9 ;TestImport.j(6) class TestImport {
  10 class TestImport []
  11 ;TestImport.j(7)   public static void main() {
  12 method main [public, static] void ()
  13 <basePointer
  14 basePointer= stackPointer
  15 stackPointer+ constant 0
  16 ;TestImport.j(8)     println("TestImport Klaar");
  17 acc16= stringconstant 24
  18 writeLineString
  19 stackPointer= basePointer
  20 basePointer<
  21 return
  22 ;TestImport.j(9)   }
  23 ;TestImport.j(10) }
  24 stringConstant 0 = "TestImport Klaar"
