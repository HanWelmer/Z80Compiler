   0 call 9
   1 stop
   2 ;TestClassModifierDefault.j(0) /*
   3 ;TestClassModifierDefault.j(1)  * A small program in the miniJava language.
   4 ;TestClassModifierDefault.j(2)  * Test ClassDeclaration without modifier.
   5 ;TestClassModifierDefault.j(3)  */
   6 ;TestClassModifierDefault.j(4) class TestClassModifierDefault {
   7 class TestClassModifierDefault []
   8 ;TestClassModifierDefault.j(5)   public static void main() {
   9 method main [public, static] void ()
  10 <basePointer
  11 basePointer= stackPointer
  12 stackPointer+ constant 0
  13 ;TestClassModifierDefault.j(6)     println("Klaar");
  14 acc16= stringconstant 21
  15 writeLineString
  16 stackPointer= basePointer
  17 basePointer<
  18 return
  19 ;TestClassModifierDefault.j(7)   }
  20 ;TestClassModifierDefault.j(8) }
  21 stringConstant 0 = "Klaar"
