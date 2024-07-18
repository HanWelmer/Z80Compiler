   0 call 18
   1 stop
   2 ;me\TestEmptyTypeButWithPackageNameAndImport.j(0) /*
   3 ;me\TestEmptyTypeButWithPackageNameAndImport.j(1)  * A small program in the miniJava language.
   4 ;me\TestEmptyTypeButWithPackageNameAndImport.j(2)  * Test empty type declaration but with package name
   5 ;me\TestEmptyTypeButWithPackageNameAndImport.j(3)  */
   6 ;me\TestEmptyTypeButWithPackageNameAndImport.j(4) package me;
   7 package me
   8 ;me\TestEmptyTypeButWithPackageNameAndImport.j(5) 
   9 ;me\TestEmptyTypeButWithPackageNameAndImport.j(6) import TestImport;
  10 import TestImport
  11 ;TestImport.j(0) /*
  12 ;TestImport.j(1)  * A small program in the miniJava language.
  13 ;TestImport.j(2)  * Test something
  14 ;TestImport.j(3)  */
  15 ;TestImport.j(4) class TestImport {
  16 class TestImport []
  17 ;TestImport.j(5)   public static void main() {
  18 method main [public, static] void ()
  19 <basePointer
  20 basePointer= stackPointer
  21 stackPointer+ constant 0
  22 ;TestImport.j(6)     println("TestImport Klaar");
  23 acc16= stringconstant 30
  24 writeLineString
  25 ;TestImport.j(7)   }
  26 stackPointer= basePointer
  27 basePointer<
  28 return
  29 ;TestImport.j(8) }
  30 stringConstant 0 = "TestImport Klaar"
