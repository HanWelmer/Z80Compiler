   0 call 12
   1 stop
   2 ;TestImportMeTo.j(0) /*
   3 ;TestImportMeTo.j(1)  * A small program in the miniJava language.
   4 ;TestImportMeTo.j(2)  * Test something
   5 ;TestImportMeTo.j(3)  */
   6 ;TestImportMeTo.j(4) import me.to.ImportedClass;
   7 import me.to.ImportedClass
   8 ;TestImportMeTo.j(5) 
   9 ;TestImportMeTo.j(6) class TestImportMeTo {
  10 class TestImportMeTo []
  11 ;TestImportMeTo.j(7)   public static void main() {
  12 method main [public, static] void ()
  13 <basePointer
  14 basePointer= stackPointer
  15 stackPointer+ constant 0
  16 ;TestImportMeTo.j(8)     println("TestImportMeTo importing ImportedClass");
  17 acc16= stringconstant 27
  18 writeLineString
  19 ;TestImportMeTo.j(9)     println("TestImportMeTo Klaar");
  20 acc16= stringconstant 28
  21 writeLineString
  22 ;TestImportMeTo.j(10)   }
  23 stackPointer= basePointer
  24 basePointer<
  25 return
  26 ;TestImportMeTo.j(11) }
  27 stringConstant 0 = "TestImportMeTo importing ImportedClass"
  28 stringConstant 1 = "TestImportMeTo Klaar"
