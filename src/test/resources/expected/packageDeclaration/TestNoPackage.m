   0 call 9
   1 stop
   2 ;TestNoPackage.j(0) /*
   3 ;TestNoPackage.j(1)  * A small program in the miniJava language.
   4 ;TestNoPackage.j(2)  * Test class without package declaration.
   5 ;TestNoPackage.j(3)  */
   6 ;TestNoPackage.j(4) class TestNoPackage {
   7 class TestNoPackage []
   8 ;TestNoPackage.j(5)   public static void main() {
   9 method TestNoPackage.main [public, static] void ()
  10 <basePointer
  11 basePointer= stackPointer
  12 stackPointer+ constant 0
  13 ;TestNoPackage.j(6)     println("Klaar");
  14 acc16= stringconstant 21
  15 writeLineString
  16 ;TestNoPackage.j(7)   }
  17 stackPointer= basePointer
  18 basePointer<
  19 return
  20 ;TestNoPackage.j(8) }
  21 stringConstant 0 = "Klaar"
