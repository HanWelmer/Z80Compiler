   0 call 12
   1 stop
   2 ;TestImport.j(0) /*
   3 ;TestImport.j(1)  * A small program in the miniJava language.
   4 ;TestImport.j(2)  * Test something
   5 ;TestImport.j(3)  */
   6 ;TestImport.j(4) import ImportedClass;
   7 import ImportedClass
   8 ;TestImport.j(5) 
   9 ;TestImport.j(6) class TestImport {
  10 class TestImport []
  11 ;TestImport.j(7)   public static void main() {
  12 method main [public, static] void ()
  13 <basePointer
  14 basePointer= stackPointer
  15 stackPointer+ constant 0
  16 ;TestImport.j(8)     println("TestImport importing ImportedClass");
  17 acc16= stringconstant 28
  18 writeLineString
  19 ;TestImport.j(9)     //ImportedClass.importedFunction();
  20 ;TestImport.j(10)     println("TestImport Klaar");
  21 acc16= stringconstant 29
  22 writeLineString
  23 ;TestImport.j(11)   }
  24 stackPointer= basePointer
  25 basePointer<
  26 return
  27 ;TestImport.j(12) }
  28 stringConstant 0 = "TestImport importing ImportedClass"
  29 stringConstant 1 = "TestImport Klaar"
