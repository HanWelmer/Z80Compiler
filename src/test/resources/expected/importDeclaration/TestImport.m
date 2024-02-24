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
  12 method main [public, static] void
  13 ;TestImport.j(8)     println("TestImport Klaar");
  14 acc16= constant 19
  15 writeLineString
  16 return
  17 ;TestImport.j(9)   }
  18 ;TestImport.j(10) }
  19 stringConstant 0 = "TestImport Klaar"
