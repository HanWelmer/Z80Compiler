   0 call 22
   1 stop
   2 ;TwoMethods.j(0) /*
   3 ;TwoMethods.j(1)  * A small program in the miniJava language.
   4 ;TwoMethods.j(2)  * Test class with 2 methods, where main is the second method.
   5 ;TwoMethods.j(3)  */
   6 ;TwoMethods.j(4) class TwoMethods {
   7 class TwoMethods []
   8 ;TwoMethods.j(5)   private static void doIt() {
   9 method doIt [private, static] void ()
  10 <basePointer
  11 basePointer= stackPointer
  12 stackPointer+ constant 0
  13 ;TwoMethods.j(6)     println("TwoMethods doIt");
  14 acc16= stringconstant 36
  15 writeLineString
  16 stackPointer= basePointer
  17 basePointer<
  18 return
  19 ;TwoMethods.j(7)   }
  20 ;TwoMethods.j(8) 
  21 ;TwoMethods.j(9)   public static void main() {
  22 method main [public, static] void ()
  23 <basePointer
  24 basePointer= stackPointer
  25 stackPointer+ constant 0
  26 ;TwoMethods.j(10)     doIt();
  27 call 9
  28 ;TwoMethods.j(11)     println("TwoMethods Klaar");
  29 acc16= stringconstant 37
  30 writeLineString
  31 stackPointer= basePointer
  32 basePointer<
  33 return
  34 ;TwoMethods.j(12)   }
  35 ;TwoMethods.j(13) }
  36 stringConstant 0 = "TwoMethods doIt"
  37 stringConstant 1 = "TwoMethods Klaar"
