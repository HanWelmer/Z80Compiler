   0 call 17
   1 stop
   2 ;TwoMethods.j(0) /*
   3 ;TwoMethods.j(1)  * A small program in the miniJava language.
   4 ;TwoMethods.j(2)  * Test class with 2 methods, where main is the second method.
   5 ;TwoMethods.j(3)  */
   6 ;TwoMethods.j(4) class TwoMethods {
   7 class TwoMethods []
   8 ;TwoMethods.j(5)   private static void doIt() {
   9 method doIt [private, static] void
  10 ;TwoMethods.j(6)     println("TwoMethods doIt");
  11 acc16= stringconstant 26
  12 writeLineString
  13 return
  14 ;TwoMethods.j(7)   }
  15 ;TwoMethods.j(8) 
  16 ;TwoMethods.j(9)   public static void main() {
  17 method main [public, static] void
  18 ;TwoMethods.j(10)     doIt();
  19 call 9
  20 ;TwoMethods.j(11)     println("TwoMethods Klaar");
  21 acc16= stringconstant 27
  22 writeLineString
  23 return
  24 ;TwoMethods.j(12)   }
  25 ;TwoMethods.j(13) }
  26 stringConstant 0 = "TwoMethods doIt"
  27 stringConstant 1 = "TwoMethods Klaar"
