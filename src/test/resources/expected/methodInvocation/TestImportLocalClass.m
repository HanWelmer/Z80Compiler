   0 call 25
   1 stop
   2 ;TestImportLocalClass.j(0) import ImportedClass;
   3 import ImportedClass
   4 ;ImportedClass.j(0) public class ImportedClass {
   5 class ImportedClass [public]
   6 ;ImportedClass.j(1)   
   7 ;ImportedClass.j(2)   private static void doIt() {
   8 method ImportedClass.doIt [private, static] void ()
   9 <basePointer
  10 basePointer= stackPointer
  11 stackPointer+ constant 0
  12 ;ImportedClass.j(3)     println(" goede");
  13 acc16= stringconstant 42
  14 writeLineString
  15 ;ImportedClass.j(4)   }
  16 stackPointer= basePointer
  17 basePointer<
  18 return
  19 ;ImportedClass.j(5) }
  20 ;TestImportLocalClass.j(1) 
  21 ;TestImportLocalClass.j(2) public class TestImportLocalClass {
  22 class TestImportLocalClass [public]
  23 ;TestImportLocalClass.j(3)   
  24 ;TestImportLocalClass.j(4)   public static void main() {
  25 method TestImportLocalClass.main [public, static] void ()
  26 <basePointer
  27 basePointer= stackPointer
  28 stackPointer+ constant 0
  29 ;TestImportLocalClass.j(5)     println("Hallo ");
  30 acc16= stringconstant 43
  31 writeLineString
  32 ;TestImportLocalClass.j(6)     ImportedClass.doIt();
  33 call 8
  34 ;TestImportLocalClass.j(7)     println("  wereld");
  35 acc16= stringconstant 44
  36 writeLineString
  37 ;TestImportLocalClass.j(8)   }
  38 stackPointer= basePointer
  39 basePointer<
  40 return
  41 ;TestImportLocalClass.j(9) }
  42 stringConstant 0 = " goede"
  43 stringConstant 1 = "Hallo "
  44 stringConstant 2 = "  wereld"
