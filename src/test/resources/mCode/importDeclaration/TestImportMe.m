   0 call 12
   1 stop
   2 ;TestImportMe.j(0) /*
   3 ;TestImportMe.j(1)  * A small program in the miniJava language.
   4 ;TestImportMe.j(2)  * Test something
   5 ;TestImportMe.j(3)  */
   6 ;TestImportMe.j(4) import me.TestImportMe;
   7 import me.TestImportMe
   8 ;TestImportMe.j(5) 
   9 ;TestImportMe.j(6) class TestMeImportMe {
  10 class TestMeImportMe []
  11 ;TestImportMe.j(7)   public static void main() {
  12 method main [public, static] void ()
  13 <basePointer
  14 basePointer= stackPointer
  15 stackPointer+ constant 0
  16 ;TestImportMe.j(8)     println("TestImportMe Klaar");
  17 acc16= stringconstant 24
  18 writeLineString
  19 ;TestImportMe.j(9)   }
  20 stackPointer= basePointer
  21 basePointer<
  22 return
  23 ;TestImportMe.j(10) }
  24 stringConstant 0 = "TestImportMe Klaar"
