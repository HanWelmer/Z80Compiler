   0 ;StaticMain.j(0) /*
   1 ;StaticMain.j(1)  * A small program in the miniJava language.
   2 ;StaticMain.j(2)  * Test final modifier in method declaration gives an error.
   3 ;StaticMain.j(3)  */
   4 ;StaticMain.j(4) import TestImport;
   5 import TestImport
   6 ;StaticMain.j(5) 
   7 ;StaticMain.j(6) class TestImport {
   8 class TestImport []
   9 ;StaticMain.j(7)   static void main() {
  10 method main [static] void
  11 ;StaticMain.j(8)     println("TestImport Klaar");
  12 acc16= constant 17
  13 writeLineString
  14 ;StaticMain.j(9)   }
  15 ;StaticMain.j(10) }
  16 stop
  17 stringConstant 0 = "TestImport Klaar"
