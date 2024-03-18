   0 call 16
   1 stop
   2 ;TestImportNotFound.j(0) /*
   3 ;TestImportNotFound.j(1)  * A small program in the miniJava language.
   4 ;TestImportNotFound.j(2)  * Test something
   5 ;TestImportNotFound.j(3)  */
   6 ;TestImportNotFound.j(4) import ImportSomething;
   7 import ImportSomething
   8 ;TestImportNotFound.j(5) import me.ImportSomething;
   9 import me.ImportSomething
  10 ;TestImportNotFound.j(6) import me.to.ImportSomething;
  11 import me.to.ImportSomething
  12 ;TestImportNotFound.j(7) 
  13 ;TestImportNotFound.j(8) class TestImportNotFound {
  14 class TestImportNotFound []
  15 ;TestImportNotFound.j(9)   public static void main() {
  16 method main [public, static] void ()
  17 <basePointer
  18 basePointer= stackPointer
  19 stackPointer+ constant 0
  20 ;TestImportNotFound.j(10)     println("TestImportNotFound Klaar");
  21 acc16= stringconstant 28
  22 writeLineString
  23 stackPointer= basePointer
  24 basePointer<
  25 return
  26 ;TestImportNotFound.j(11)   }
  27 ;TestImportNotFound.j(12) }
  28 stringConstant 0 = "TestImportNotFound Klaar"
