   0 call 12
   1 stop
   2 ;PublicStaticMain.j(0) /*
   3 ;PublicStaticMain.j(1)  * A small program in the miniJava language.
   4 ;PublicStaticMain.j(2)  * Test final modifier in method declaration gives an error.
   5 ;PublicStaticMain.j(3)  */
   6 ;PublicStaticMain.j(4) import TestImport;
   7 import TestImport
   8 ;PublicStaticMain.j(5) 
   9 ;PublicStaticMain.j(6) class TestImport {
  10 class TestImport []
  11 ;PublicStaticMain.j(7)   public static void main() {
  12 method main [public, static] void
  13 ;PublicStaticMain.j(8)     println("TestImport Klaar");
  14 acc16= constant 19
  15 writeLineString
  16 return
  17 ;PublicStaticMain.j(9)   }
  18 ;PublicStaticMain.j(10) }
  19 stringConstant 0 = "TestImport Klaar"
