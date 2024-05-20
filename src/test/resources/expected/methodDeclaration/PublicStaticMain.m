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
  12 method main [public, static] void ()
  13 <basePointer
  14 basePointer= stackPointer
  15 stackPointer+ constant 0
  16 ;PublicStaticMain.j(8)     println("TestImport Klaar");
  17 acc16= stringconstant 24
  18 writeLineString
  19 ;PublicStaticMain.j(9)   }
  20 stackPointer= basePointer
  21 basePointer<
  22 return
  23 ;PublicStaticMain.j(10) }
  24 stringConstant 0 = "TestImport Klaar"
