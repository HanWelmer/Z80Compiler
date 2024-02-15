   0 ;TestExpression.j(0) /* Program to test generated Z80 assembler code */
   1 ;TestExpression.j(1) class TestExpression {
   2 class TestExpression []
   3 ;TestExpression.j(2)   static byte b;
   4 ;TestExpression.j(3) 
   5 ;TestExpression.j(4)   public static void main() {
   6 method main [public, static] void
   7 ;TestExpression.j(5)     println(1);
   8 acc8= constant 1
   9 call writeLineAcc8
  10 ;TestExpression.j(6)     //byte b = 1;
  11 ;TestExpression.j(7)     b = 1;
  12 acc8= constant 1
  13 acc8=> variable 0
  14 ;TestExpression.j(8)     ;
  15 ;TestExpression.j(9)     println(2);
  16 acc8= constant 2
  17 call writeLineAcc8
  18 ;TestExpression.j(10)     println("Klaar.");
  19 acc16= constant 24
  20 writeLineString
  21 ;TestExpression.j(11)   }
  22 ;TestExpression.j(12) }
  23 stop
  24 stringConstant 0 = "Klaar."
