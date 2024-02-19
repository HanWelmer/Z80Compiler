   0 ;TestExpression.j(0) /* Program to test generated Z80 assembler code */
   1 ;TestExpression.j(1) class TestExpression {
   2 class TestExpression []
   3 ;TestExpression.j(2) 
   4 ;TestExpression.j(3)   public static void main() {
   5 method main [public, static] void
   6 ;TestExpression.j(4)     println(1);
   7 acc8= constant 1
   8 call writeLineAcc8
   9 ;TestExpression.j(5)     byte b = 1;
  10 <acc8= constant 1
  11 acc8=> variable 0
  12 ;TestExpression.j(6)     ;
  13 ;TestExpression.j(7)     println(2);
  14 acc8= constant 2
  15 call writeLineAcc8
  16 ;TestExpression.j(8)     println("Klaar.");
  17 acc16= constant 22
  18 writeLineString
  19 ;TestExpression.j(9)   }
  20 ;TestExpression.j(10) }
  21 stop
  22 stringConstant 0 = "Klaar."
