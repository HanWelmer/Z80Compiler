   0 call 14
   1 stop
   2 ;TestNoParameters.j(0) public class TestStatementExpression {
   3 class TestStatementExpression [public]
   4 ;TestNoParameters.j(1)   
   5 ;TestNoParameters.j(2)   private static void doIt() {
   6 method doIt [private, static] void
   7 ;TestNoParameters.j(3)     println("doIt");
   8 acc16= constant 20
   9 writeLineString
  10 return
  11 ;TestNoParameters.j(4)   }
  12 ;TestNoParameters.j(5) 
  13 ;TestNoParameters.j(6)   public static void main() {
  14 method main [public, static] void
  15 ;TestNoParameters.j(7)     doIt();
  16 call 6
  17 return
  18 ;TestNoParameters.j(8)   }
  19 ;TestNoParameters.j(9) }
  20 stringConstant 0 = "doIt"
