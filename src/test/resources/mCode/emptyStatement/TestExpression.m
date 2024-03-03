   0 call 7
   1 stop
   2 ;TestExpression.j(0) /* Program to test generated Z80 assembler code */
   3 ;TestExpression.j(1) class TestExpression {
   4 class TestExpression []
   5 ;TestExpression.j(2) 
   6 ;TestExpression.j(3)   public static void main() {
   7 method main [public, static] void
   8 ;TestExpression.j(4)     println(1);
   9 acc8= constant 1
  10 call writeLineAcc8
  11 ;TestExpression.j(5)     byte b = 1;
  12 acc8= constant 1
  13 acc8=> variable 0
  14 ;TestExpression.j(6)     ;
  15 ;TestExpression.j(7)     println(2);
  16 acc8= constant 2
  17 call writeLineAcc8
  18 ;TestExpression.j(8)     println("Klaar.");
  19 acc16= stringconstant 24
  20 writeLineString
  21 return
  22 ;TestExpression.j(9)   }
  23 ;TestExpression.j(10) }
  24 stringConstant 0 = "Klaar."
