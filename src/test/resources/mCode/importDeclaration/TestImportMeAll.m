   0 call 12
   1 stop
   2 ;TestImportMeAll.j(0) /*
   3 ;TestImportMeAll.j(1)  * A small program in the miniJava language.
   4 ;TestImportMeAll.j(2)  * Test import with wildcard.
   5 ;TestImportMeAll.j(3)  */
   6 ;TestImportMeAll.j(4) import me.*;
   7 import me.*
   8 ;TestImportMeAll.j(5) 
   9 ;TestImportMeAll.j(6) class TestImportMeAll {
  10 class TestImportMeAll []
  11 ;TestImportMeAll.j(7)   public static void main() {
  12 method main [public, static] void ()
  13 <basePointer
  14 basePointer= stackPointer
  15 stackPointer+ constant 0
  16 ;TestImportMeAll.j(8)     println("Klaar");
  17 acc16= stringconstant 24
  18 writeLineString
  19 stackPointer= basePointer
  20 basePointer<
  21 return
  22 ;TestImportMeAll.j(9)   }
  23 ;TestImportMeAll.j(10) }
  24 stringConstant 0 = "Klaar"
