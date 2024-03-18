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
  12 method main [static] void ()
  13 <basePointer
  14 basePointer= stackPointer
  15 stackPointer+ constant 0
  16 ;StaticMain.j(8)     println("TestImport Klaar");
  17 acc16= stringconstant 24
  18 writeLineString
  19 stackPointer= basePointer
  20 basePointer<
  21 return
  22 ;StaticMain.j(9)   }
  23 ;StaticMain.j(10) }
  24 stringConstant 0 = "TestImport Klaar"
