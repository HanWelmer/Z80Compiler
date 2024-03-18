   0 call 14
   1 stop
   2 ;TestImportTwo.j(0) /*
   3 ;TestImportTwo.j(1)  * A small program in the miniJava language.
   4 ;TestImportTwo.j(2)  * Test something
   5 ;TestImportTwo.j(3)  */
   6 ;TestImportTwo.j(4) import me.TestImportMe;
   7 import me.TestImportMe
   8 ;TestImportTwo.j(5) import me.to.TestImportMe;
   9 import me.to.TestImportMe
  10 ;TestImportTwo.j(6) 
  11 ;TestImportTwo.j(7) class TestImportTwo {
  12 class TestImportTwo []
  13 ;TestImportTwo.j(8)   public static void main() {
  14 method main [public, static] void ()
  15 <basePointer
  16 basePointer= stackPointer
  17 stackPointer+ constant 0
  18 ;TestImportTwo.j(9)     println("TestImportTwo Klaar");
  19 acc16= stringconstant 26
  20 writeLineString
  21 stackPointer= basePointer
  22 basePointer<
  23 return
  24 ;TestImportTwo.j(10)   }
  25 ;TestImportTwo.j(11) }
  26 stringConstant 0 = "TestImportTwo Klaar"
