   0 call 12
   1 stop
   2 ;TestImportMeTo.j(0) /*
   3 ;TestImportMeTo.j(1)  * A small program in the miniJava language.
   4 ;TestImportMeTo.j(2)  * Test something
   5 ;TestImportMeTo.j(3)  */
   6 ;TestImportMeTo.j(4) import me.to.TestMeToImportMeTo;
   7 import me.to.TestMeToImportMeTo
   8 ;TestImportMeTo.j(5) 
   9 ;TestImportMeTo.j(6) class TestImportMeTo {
  10 class TestImportMeTo []
  11 ;TestImportMeTo.j(7)   public static void main() {
  12 method main [public, static] void ()
  13 <basePointer
  14 basePointer= stackPointer
  15 stackPointer+ constant 0
  16 ;TestImportMeTo.j(8)     println("TestImportMeTo Klaar");
  17 acc16= stringconstant 24
  18 writeLineString
  19 ;TestImportMeTo.j(9)   }
  20 stackPointer= basePointer
  21 basePointer<
  22 return
  23 ;TestImportMeTo.j(10) }
  24 stringConstant 0 = "TestImportMeTo Klaar"
