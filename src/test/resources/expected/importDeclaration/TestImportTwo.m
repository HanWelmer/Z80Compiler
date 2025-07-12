   0 call 83
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
  23 acc16= stringconstant 95
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
  53 ;me\to\ImportedClass.j(7)   public static void importedFunction1() {
  54 method me.to.ImportedClass.importedFunction1 [public, static] void ()
  55 <basePointer
  56 basePointer= stackPointer
  57 stackPointer+ constant 0
  58 ;me\to\ImportedClass.j(8)     println("me.to.ImportedClass.importedFunction() function 1");
  59 acc16= stringconstant 96
  60 writeLineString
  61 ;me\to\ImportedClass.j(9)   }
  62 stackPointer= basePointer
  63 basePointer<
  64 return
  65 ;me\to\ImportedClass.j(10) 
  66 ;me\to\ImportedClass.j(11)   public static void importedFunction2() {
  67 method me.to.ImportedClass.importedFunction2 [public, static] void ()
  68 <basePointer
  69 basePointer= stackPointer
  70 stackPointer+ constant 0
  71 ;me\to\ImportedClass.j(12)     println("me.to.ImportedClass.importedFunction() function 2");
  72 acc16= stringconstant 97
  73 writeLineString
  74 ;me\to\ImportedClass.j(13)   }
  75 stackPointer= basePointer
  76 basePointer<
  77 return
  78 ;me\to\ImportedClass.j(14) }
  79 ;TestImportTwo.j(6) 
  80 ;TestImportTwo.j(7) class TestImportTwo {
  81 class TestImportTwo []
  82 ;TestImportTwo.j(8)   public static void main() {
  83 method TestImportTwo.main [public, static] void ()
  84 <basePointer
  85 basePointer= stackPointer
  86 stackPointer+ constant 0
  87 ;TestImportTwo.j(9)     println("TestImportTwo Klaar");
  88 acc16= stringconstant 98
  89 writeLineString
  90 ;TestImportTwo.j(10)   }
  91 stackPointer= basePointer
  92 basePointer<
  93 return
  94 ;TestImportTwo.j(11) }
  95 stringConstant 0 = "TestImportMe"
  96 stringConstant 1 = "me.to.ImportedClass.importedFunction() function 1"
  97 stringConstant 2 = "me.to.ImportedClass.importedFunction() function 2"
  98 stringConstant 3 = "TestImportTwo Klaar"
