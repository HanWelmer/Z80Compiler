   0 call 24
   1 stop
   2 ;TestImportLocalClass.j(0) import ImportedClass;
   3 ;ImportedClass.j(0) public class ImportedClass {
   4 class ImportedClass [public]
   5 ;ImportedClass.j(1)   
   6 ;ImportedClass.j(2)   private static void doIt() {
   7 method ImportedClass.doIt [private, static] void ()
   8 <basePointer
   9 basePointer= stackPointer
  10 stackPointer+ constant 0
  11 ;ImportedClass.j(3)     println(" goede");
  12 acc16= stringconstant 41
  13 writeLineString
  14 ;ImportedClass.j(4)   }
  15 stackPointer= basePointer
  16 basePointer<
  17 return
  18 ;ImportedClass.j(5) }
  19 ;TestImportLocalClass.j(1) 
  20 ;TestImportLocalClass.j(2) public class TestImportLocalClass {
  21 class TestImportLocalClass [public]
  22 ;TestImportLocalClass.j(3) 
  23 ;TestImportLocalClass.j(4)   public static void main() {
  24 method TestImportLocalClass.main [public, static] void ()
  25 <basePointer
  26 basePointer= stackPointer
  27 stackPointer+ constant 0
  28 ;TestImportLocalClass.j(5)     println("Hallo ");
  29 acc16= stringconstant 42
  30 writeLineString
  31 ;TestImportLocalClass.j(6)     doIt();
  32 call 7
  33 ;TestImportLocalClass.j(7)     println("  wereld");
  34 acc16= stringconstant 43
  35 writeLineString
  36 ;TestImportLocalClass.j(8)   }
  37 stackPointer= basePointer
  38 basePointer<
  39 return
  40 ;TestImportLocalClass.j(9) }
  41 stringConstant 0 = " goede"
  42 stringConstant 1 = "Hallo "
  43 stringConstant 2 = "  wereld"
