   0 call 47
   1 stop
   2 ;TestImportMeTo.j(0) /*
   3 ;TestImportMeTo.j(1)  * A small program in the miniJava language.
   4 ;TestImportMeTo.j(2)  * Test something
   5 ;TestImportMeTo.j(3)  */
   6 ;TestImportMeTo.j(4) import me.to.ImportedClass;
   7 import me.to.ImportedClass
   8 ;me\to\ImportedClass.j(0) /*
   9 ;me\to\ImportedClass.j(1)  * A small program in the miniJava language.
  10 ;me\to\ImportedClass.j(2)  * Test something
  11 ;me\to\ImportedClass.j(3)  */
  12 ;me\to\ImportedClass.j(4) package me.to;
  13 package me.to
  14 ;me\to\ImportedClass.j(5) 
  15 ;me\to\ImportedClass.j(6) class ImportedClass {
  16 class me.to.ImportedClass []
  17 ;me\to\ImportedClass.j(7)   public static void importedFunction1() {
  18 method me.to.ImportedClass.importedFunction1 [public, static] void ()
  19 <basePointer
  20 basePointer= stackPointer
  21 stackPointer+ constant 0
  22 ;me\to\ImportedClass.j(8)     println("me.to.ImportedClass.importedFunction() function 1");
  23 acc16= stringconstant 66
  24 writeLineString
  25 ;me\to\ImportedClass.j(9)   }
  26 stackPointer= basePointer
  27 basePointer<
  28 return
  29 ;me\to\ImportedClass.j(10) 
  30 ;me\to\ImportedClass.j(11)   public static void importedFunction2() {
  31 method me.to.ImportedClass.importedFunction2 [public, static] void ()
  32 <basePointer
  33 basePointer= stackPointer
  34 stackPointer+ constant 0
  35 ;me\to\ImportedClass.j(12)     println("me.to.ImportedClass.importedFunction() function 2");
  36 acc16= stringconstant 67
  37 writeLineString
  38 ;me\to\ImportedClass.j(13)   }
  39 stackPointer= basePointer
  40 basePointer<
  41 return
  42 ;me\to\ImportedClass.j(14) }
  43 ;TestImportMeTo.j(5) 
  44 ;TestImportMeTo.j(6) class TestImportMeTo {
  45 class TestImportMeTo []
  46 ;TestImportMeTo.j(7)   public static void main() {
  47 method TestImportMeTo.main [public, static] void ()
  48 <basePointer
  49 basePointer= stackPointer
  50 stackPointer+ constant 0
  51 ;TestImportMeTo.j(8)     println("TestImportMeTo importing 2 functions from ImportedClass");
  52 acc16= stringconstant 68
  53 writeLineString
  54 ;TestImportMeTo.j(9)     me.to.ImportedClass.importedFunction1();
  55 call 18
  56 ;TestImportMeTo.j(10)     me.to.ImportedClass.importedFunction2();
  57 call 31
  58 ;TestImportMeTo.j(11)     println("TestImportMeTo Klaar");
  59 acc16= stringconstant 69
  60 writeLineString
  61 ;TestImportMeTo.j(12)   }
  62 stackPointer= basePointer
  63 basePointer<
  64 return
  65 ;TestImportMeTo.j(13) }
  66 stringConstant 0 = "me.to.ImportedClass.importedFunction() function 1"
  67 stringConstant 1 = "me.to.ImportedClass.importedFunction() function 2"
  68 stringConstant 2 = "TestImportMeTo importing 2 functions from ImportedClass"
  69 stringConstant 3 = "TestImportMeTo Klaar"
