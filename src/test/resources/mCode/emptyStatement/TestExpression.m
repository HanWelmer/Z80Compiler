   0 call 7
   1 stop
   2 ;TestExpression.j(0) /* Program to test generated Z80 assembler code */
   3 ;TestExpression.j(1) class TestExpression {
   4 class TestExpression []
   5 ;TestExpression.j(2) 
   6 ;TestExpression.j(3)   public static void main() {
   7 method TestExpression.main [public, static] void ()
   8 <basePointer
   9 basePointer= stackPointer
  10 stackPointer+ constant 1
  11 ;TestExpression.j(4)     println(1);
  12 acc8= constant 1
  13 writeLineAcc8
  14 ;TestExpression.j(5)     byte b = 1;
  15 acc8= constant 1
  16 acc8=> (basePointer + 1)
  17 ;TestExpression.j(6)     ;
  18 ;TestExpression.j(7)     println(2);
  19 acc8= constant 2
  20 writeLineAcc8
  21 ;TestExpression.j(8)     println("Klaar.");
  22 acc16= stringconstant 29
  23 writeLineString
  24 ;TestExpression.j(9)   }
  25 stackPointer= basePointer
  26 basePointer<
  27 return
  28 ;TestExpression.j(10) }
  29 stringConstant 0 = "Klaar."
