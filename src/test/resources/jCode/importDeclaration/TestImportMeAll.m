   0 call 46
   1 stop
   2 ;TestImportMeAll.j(0) /*
   3 ;TestImportMeAll.j(1)  * A small program in the miniJava language.
   4 ;TestImportMeAll.j(2)  * Test import with wildcard.
   5 ;TestImportMeAll.j(3)  */
   6 ;TestImportMeAll.j(4) import me.*;
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
  23 acc16= stringconstant 60
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
  42 ;TestImportMeAll.j(5) 
  43 ;TestImportMeAll.j(6) class TestImportMeAll {
  44 class TestImportMeAll []
  45 ;TestImportMeAll.j(7)   public static void main() {
  46 method TestImportMeAll.main [public, static] void ()
  47 <basePointer
  48 basePointer= stackPointer
  49 stackPointer+ constant 0
  50 ;TestImportMeAll.j(8)     me.TestImportMe.doIt();
  51 call 18
  52 ;TestImportMeAll.j(9)     println("Klaar");
  53 acc16= stringconstant 61
  54 writeLineString
  55 ;TestImportMeAll.j(10)   }
  56 stackPointer= basePointer
  57 basePointer<
  58 return
  59 ;TestImportMeAll.j(11) }
  60 stringConstant 0 = "TestImportMe"
  61 stringConstant 1 = "Klaar"
