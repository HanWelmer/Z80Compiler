   0 call 19
   1 stop
   2 ;TestWordParameter.j(0) public class TestStatementExpression {
   3 class TestStatementExpression [public]
   4 ;TestWordParameter.j(1)   
   5 ;TestWordParameter.j(2)   private static void doIt(word w) {
   6 method TestStatementExpression.doIt [private, static] void (word w {bp+4})
   7 <basePointer
   8 basePointer= stackPointer
   9 stackPointer+ constant 0
  10 ;TestWordParameter.j(3)     println(w);
  11 acc16= (basePointer + 4)
  12 writeLineAcc16
  13 ;TestWordParameter.j(4)   }
  14 stackPointer= basePointer
  15 basePointer<
  16 return
  17 ;TestWordParameter.j(5) 
  18 ;TestWordParameter.j(6)   public static void main() {
  19 method TestStatementExpression.main [public, static] void ()
  20 <basePointer
  21 basePointer= stackPointer
  22 stackPointer+ constant 0
  23 ;TestWordParameter.j(7)     println("Hallo ");
  24 acc16= stringconstant 38
  25 writeLineString
  26 ;TestWordParameter.j(8)     doIt(257);
  27 acc16= constant 257
  28 <acc16
  29 call 6
  30 ;TestWordParameter.j(9)     println(" wereld");
  31 acc16= stringconstant 39
  32 writeLineString
  33 ;TestWordParameter.j(10)   }
  34 stackPointer= basePointer
  35 basePointer<
  36 return
  37 ;TestWordParameter.j(11) }
  38 stringConstant 0 = "Hallo "
  39 stringConstant 1 = " wereld"
