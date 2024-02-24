   0 call 12
   1 stop
   2 ;StaticMain.j(0) /*
   3 ;StaticMain.j(1)  * A small program in the miniJava language.
   4 ;StaticMain.j(2)  * Test final modifier in method declaration gives an error.
   5 ;StaticMain.j(3)  */
   6 ;StaticMain.j(4) import TestImport;
   7 import TestImport
   8 ;StaticMain.j(5) 
   9 ;StaticMain.j(6) class TestImport {
  10 class TestImport []
  11 ;StaticMain.j(7)   static void main() {
  12 method main [static] void
  13 ;StaticMain.j(8)     println("TestImport Klaar");
  14 acc16= constant 19
  15 writeLineString
  16 return
  17 ;StaticMain.j(9)   }
  18 ;StaticMain.j(10) }
  19 stringConstant 0 = "TestImport Klaar"
