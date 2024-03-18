   0 call 19
   1 stop
   2 ;TestNoParameters.j(0) public class TestStatementExpression {
   3 class TestStatementExpression [public]
   4 ;TestNoParameters.j(1)   
   5 ;TestNoParameters.j(2)   private static void doIt() {
   6 method doIt [private, static] void ()
   7 <basePointer
   8 basePointer= stackPointer
   9 stackPointer+ constant 0
  10 ;TestNoParameters.j(3)     println("Hallo");
  11 acc16= stringconstant 36
  12 writeLineString
  13 stackPointer= basePointer
  14 basePointer<
  15 return
  16 ;TestNoParameters.j(4)   }
  17 ;TestNoParameters.j(5) 
  18 ;TestNoParameters.j(6)   public static void main() {
  19 method main [public, static] void ()
  20 <basePointer
  21 basePointer= stackPointer
  22 stackPointer+ constant 0
  23 ;TestNoParameters.j(7)     println("");
  24 acc16= stringconstant 37
  25 writeLineString
  26 ;TestNoParameters.j(8)     doIt();
  27 call 6
  28 ;TestNoParameters.j(9)     println("      wereld");
  29 acc16= stringconstant 38
  30 writeLineString
  31 stackPointer= basePointer
  32 basePointer<
  33 return
  34 ;TestNoParameters.j(10)   }
  35 ;TestNoParameters.j(11) }
  36 stringConstant 0 = "Hallo"
  37 stringConstant 1 = ""
  38 stringConstant 2 = "      wereld"
