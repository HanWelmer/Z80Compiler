   0 call 58
   1 stop
   2 ;TestImportTwo.j(0) /*
   3 ;TestImportTwo.j(1)  * A small program in the miniJava language.
   4 ;TestImportTwo.j(2)  * Test something
   5 ;TestImportTwo.j(3)  */
   6 ;TestImportTwo.j(4) import me.TestImportMe;
   7 import me.TestImportMe
   8 ;me\TestImportMe.j(0) /*
   9 ;me\TestImportMe.j(1)  * A small program in the miniJava language.
  10 ;me\TestImportMe.j(2)  * Test something
  11 ;me\TestImportMe.j(3)  */
  12 ;me\TestImportMe.j(4) package me;
  13 package me
  14 ;me\TestImportMe.j(5) 
  15 ;me\TestImportMe.j(6) class TestImportMe {
  16 class me.TestImportMe []
  17 ;me\TestImportMe.j(7)   public static void main() {
  18 method me.TestImportMe.main [public, static] void ()
  19 <basePointer
  20 basePointer= stackPointer
  21 stackPointer+ constant 0
  22 ;me\TestImportMe.j(8)     println("TestImportMe Klaar");
  23 acc16= stringconstant 70
  24 writeLineString
  25 ;me\TestImportMe.j(9)   }
  26 stackPointer= basePointer
  27 basePointer<
  28 return
  29 ;me\TestImportMe.j(10) }
  30 ;TestImportTwo.j(5) import me.to.ImportedClass;
  31 import me.to.ImportedClass
  32 ;me\to\ImportedClass.j(0) /*
  33 ;me\to\ImportedClass.j(1)  * A small program in the miniJava language.
  34 ;me\to\ImportedClass.j(2)  * Test something
  35 ;me\to\ImportedClass.j(3)  */
  36 ;me\to\ImportedClass.j(4) package me.to;
  37 package me.to
  38 ;me\to\ImportedClass.j(5) 
  39 ;me\to\ImportedClass.j(6) class ImportedClass {
  40 class me.to.ImportedClass []
  41 ;me\to\ImportedClass.j(7)   public static void importedFunction() {
  42 method me.to.ImportedClass.importedFunction [public, static] void ()
  43 <basePointer
  44 basePointer= stackPointer
  45 stackPointer+ constant 0
  46 ;me\to\ImportedClass.j(8)     println("me.to.ImportedClass.importedFunction() Klaar");
  47 acc16= stringconstant 71
  48 writeLineString
  49 ;me\to\ImportedClass.j(9)   }
  50 stackPointer= basePointer
  51 basePointer<
  52 return
  53 ;me\to\ImportedClass.j(10) }
  54 ;TestImportTwo.j(6) 
  55 ;TestImportTwo.j(7) class TestImportTwo {
  56 class TestImportTwo []
  57 ;TestImportTwo.j(8)   public static void main() {
  58 method TestImportTwo.main [public, static] void ()
  59 <basePointer
  60 basePointer= stackPointer
  61 stackPointer+ constant 0
  62 ;TestImportTwo.j(9)     println("TestImportTwo Klaar");
  63 acc16= stringconstant 72
  64 writeLineString
  65 ;TestImportTwo.j(10)   }
  66 stackPointer= basePointer
  67 basePointer<
  68 return
  69 ;TestImportTwo.j(11) }
  70 stringConstant 0 = "TestImportMe Klaar"
  71 stringConstant 1 = "me.to.ImportedClass.importedFunction() Klaar"
  72 stringConstant 2 = "TestImportTwo Klaar"
