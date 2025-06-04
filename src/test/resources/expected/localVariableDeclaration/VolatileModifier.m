   0 call 9
   1 stop
   2 ;VolatileModifier.j(0) /*
   3 ;VolatileModifier.j(1)  * A small program in the miniJava language.
   4 ;VolatileModifier.j(2)  * Test final modifier in a local variable declaration.
   5 ;VolatileModifier.j(3)  */
   6 ;VolatileModifier.j(4) class VolatileModifier {
   7 class VolatileModifier []
   8 ;VolatileModifier.j(5)   public static void main() {
   9 method VolatileModifier.main [public, static] void ()
  10 <basePointer
  11 basePointer= stackPointer
  12 stackPointer+ constant 1
  13 ;VolatileModifier.j(6)     volatile byte b = 1;
  14 acc8= constant 1
  15 acc8=> (basePointer + 0)
  16 ;VolatileModifier.j(7)   }
  17 stackPointer= basePointer
  18 basePointer<
  19 return
  20 ;VolatileModifier.j(8) }
