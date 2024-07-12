   0 call 31
   1 stop
   2 ;TestImport.j(0) /*
   3 ;TestImport.j(1)  * A small program in the miniJava language.
   4 ;TestImport.j(2)  * Test something
   5 ;TestImport.j(3)  */
   6 ;TestImport.j(4) import ImportedClass;
   7 import ImportedClass
   8 ;ImportedClass.j(0) /*
   9 ;ImportedClass.j(1)  * A small program in the miniJava language.
  10 ;ImportedClass.j(2)  * Test something
  11 ;ImportedClass.j(3)  */
  12 ;ImportedClass.j(4) class ImportedClass {
  13 class ImportedClass []
  14 ;ImportedClass.j(5)   public static void importedFunction() {
  15 method importedFunction [public, static] void ()
  16 <basePointer
  17 basePointer= stackPointer
  18 stackPointer+ constant 0
  19 ;ImportedClass.j(6)     println("ImportedClass.importedFunction() Klaar");
  20 acc16= stringconstant 47
  21 writeLineString
  22 ;ImportedClass.j(7)   }
  23 stackPointer= basePointer
  24 basePointer<
  25 return
  26 ;ImportedClass.j(8) }
  27 ;TestImport.j(5) 
  28 ;TestImport.j(6) class TestImport {
  29 class TestImport []
  30 ;TestImport.j(7)   public static void main() {
  31 method main [public, static] void ()
  32 <basePointer
  33 basePointer= stackPointer
  34 stackPointer+ constant 0
  35 ;TestImport.j(8)     println("TestImport importing ImportedClass");
  36 acc16= stringconstant 48
  37 writeLineString
  38 ;TestImport.j(9)     //ImportedClass.importedFunction();
  39 ;TestImport.j(10)     println("TestImport Klaar");
  40 acc16= stringconstant 49
  41 writeLineString
  42 ;TestImport.j(11)   }
  43 stackPointer= basePointer
  44 basePointer<
  45 return
  46 ;TestImport.j(12) }
  47 stringConstant 0 = "ImportedClass.importedFunction() Klaar"
  48 stringConstant 1 = "TestImport importing ImportedClass"
  49 stringConstant 2 = "TestImport Klaar"
