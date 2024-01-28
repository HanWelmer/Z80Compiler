   0 ;TwoMethods.j(0) /*
   1 ;TwoMethods.j(1)  * A small program in the miniJava language.
   2 ;TwoMethods.j(2)  * Test class with 2 methods, where main is the second method.
   3 ;TwoMethods.j(3)  */
   4 ;TwoMethods.j(4) class TwoMethods {
   5 class TwoMethods []
   6 ;TwoMethods.j(5)   private static void doIt() {
   7 method doIt [private, static] void
   8 ;TwoMethods.j(6)     println("TwoMethods doIt");
   9 acc16= constant 21
  10 writeLineString
  11 ;TwoMethods.j(7)   }
  12 ;TwoMethods.j(8) 
  13 ;TwoMethods.j(9)   public static void main() {
  14 method main [public, static] void
  15 ;TwoMethods.j(10)     println("TwoMethods Klaar");
  16 acc16= constant 22
  17 writeLineString
  18 ;TwoMethods.j(11)   }
  19 ;TwoMethods.j(12) }
  20 stop
  21 stringConstant 0 = "TwoMethods doIt"
  22 stringConstant 1 = "TwoMethods Klaar"
