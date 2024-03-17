   0 call 9
   1 stop
   2 ;FinalModifier.j(0) /*
   3 ;FinalModifier.j(1)  * A small program in the miniJava language.
   4 ;FinalModifier.j(2)  * Test final modifier in a local variable declaration.
   5 ;FinalModifier.j(3)  */
   6 ;FinalModifier.j(4) class FinalModifier {
   7 class FinalModifier []
   8 ;FinalModifier.j(5)   public static void main() {
   9 method main [public, static] void ()
  10 <basePointer
  11 basePointer= stackPointer
  12 stackPointer+ constant 1
  13 ;FinalModifier.j(6)     final byte b = 1;
  14 acc8= constant 1
  15 acc8=> (basePointer + -1)
  16 stackPointer= basePointer
  17 basePointer<
  18 return
  19 ;FinalModifier.j(7)   }
  20 ;FinalModifier.j(8) }
