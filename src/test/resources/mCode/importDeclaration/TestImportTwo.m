   0 call 70
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
  17 ;me\TestImportMe.j(7)   private static void doIt() {
  18 method me.TestImportMe.doIt [private, static] void ()
  19 <basePointer
  20 basePointer= stackPointer
  21 stackPointer+ constant 0
  22 ;me\TestImportMe.j(8)     println("TestImportMe");
  23 acc16= stringconstant 82
  24 writeLineString
  25 ;me\TestImportMe.j(9)   }
  26 stackPointer= basePointer
  27 basePointer<
  28 return
  29 ;me\TestImportMe.j(10)   
  30 ;me\TestImportMe.j(11)   public static void main() {
  31 method me.TestImportMe.main [public, static] void ()
  32 <basePointer
  33 basePointer= stackPointer
  34 stackPointer+ constant 0
  35 ;me\TestImportMe.j(12)     doIt();
  36 call 18
  37 ;me\TestImportMe.j(13)   }
  38 stackPointer= basePointer
  39 basePointer<
  40 return
  41 ;me\TestImportMe.j(14) }
  42 ;TestImportTwo.j(5) import me.to.ImportedClass;
  43 import me.to.ImportedClass
  44 ;me\to\ImportedClass.j(0) /*
  45 ;me\to\ImportedClass.j(1)  * A small program in the miniJava language.
  46 ;me\to\ImportedClass.j(2)  * Test something
  47 ;me\to\ImportedClass.j(3)  */
  48 ;me\to\ImportedClass.j(4) package me.to;
  49 package me.to
  50 ;me\to\ImportedClass.j(5) 
  51 ;me\to\ImportedClass.j(6) class ImportedClass {
  52 class me.to.ImportedClass []
  53 ;me\to\ImportedClass.j(7)   public static void importedFunction() {
  54 method me.to.ImportedClass.importedFunction [public, static] void ()
  55 <basePointer
  56 basePointer= stackPointer
  57 stackPointer+ constant 0
  58 ;me\to\ImportedClass.j(8)     println("me.to.ImportedClass.importedFunction() Klaar");
  59 acc16= stringconstant 83
  60 writeLineString
  61 ;me\to\ImportedClass.j(9)   }
  62 stackPointer= basePointer
  63 basePointer<
  64 return
  65 ;me\to\ImportedClass.j(10) }
  66 ;TestImportTwo.j(6) 
  67 ;TestImportTwo.j(7) class TestImportTwo {
  68 class TestImportTwo []
  69 ;TestImportTwo.j(8)   public static void main() {
  70 method TestImportTwo.main [public, static] void ()
  71 <basePointer
  72 basePointer= stackPointer
  73 stackPointer+ constant 0
  74 ;TestImportTwo.j(9)     println("TestImportTwo Klaar");
  75 acc16= stringconstant 84
  76 writeLineString
  77 ;TestImportTwo.j(10)   }
  78 stackPointer= basePointer
  79 basePointer<
  80 return
  81 ;TestImportTwo.j(11) }
  82 stringConstant 0 = "TestImportMe"
  83 stringConstant 1 = "me.to.ImportedClass.importedFunction() Klaar"
  84 stringConstant 2 = "TestImportTwo Klaar"
