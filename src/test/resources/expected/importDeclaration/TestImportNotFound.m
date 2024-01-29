   0 ;TestImportNotFound.j(0) /*
   1 ;TestImportNotFound.j(1)  * A small program in the miniJava language.
   2 ;TestImportNotFound.j(2)  * Test something
   3 ;TestImportNotFound.j(3)  */
   4 ;TestImportNotFound.j(4) import ImportSomething;
   5 import ImportSomething
   6 ;TestImportNotFound.j(5) import me.ImportSomething;
   7 import me.ImportSomething
   8 ;TestImportNotFound.j(6) import me.to.ImportSomething;
   9 import me.to.ImportSomething
  10 ;TestImportNotFound.j(7) 
  11 ;TestImportNotFound.j(8) class TestImportNotFound {
  12 class TestImportNotFound []
  13 ;TestImportNotFound.j(9)   public static void main() {
  14 method main [public, static] void
  15 ;TestImportNotFound.j(10)     println("TestImportNotFound Klaar");
  16 acc16= constant 21
  17 writeLineString
  18 ;TestImportNotFound.j(11)   }
  19 ;TestImportNotFound.j(12) }
  20 stop
  21 stringConstant 0 = "TestImportNotFound Klaar"
