   0 call 14
   1 stop
   2 ;TestNoParameters.j(0) public class TestStatementExpression {
   3 class TestStatementExpression [public]
   4 ;TestNoParameters.j(1)   
   5 ;TestNoParameters.j(2)   private static void doIt() {
   6 method doIt [private, static] void
   7 ;TestNoParameters.j(3)     println("Hallo");
   8 acc16= stringconstant 26
   9 writeLineString
  10 return
  11 ;TestNoParameters.j(4)   }
  12 ;TestNoParameters.j(5) 
  13 ;TestNoParameters.j(6)   public static void main() {
  14 method main [public, static] void
  15 ;TestNoParameters.j(7)     println("");
  16 acc16= stringconstant 27
  17 writeLineString
  18 ;TestNoParameters.j(8)     doIt();
  19 call 6
  20 ;TestNoParameters.j(9)     println("      wereld");
  21 acc16= stringconstant 28
  22 writeLineString
  23 return
  24 ;TestNoParameters.j(10)   }
  25 ;TestNoParameters.j(11) }
  26 stringConstant 0 = "Hallo"
  27 stringConstant 1 = ""
  28 stringConstant 2 = "      wereld"
