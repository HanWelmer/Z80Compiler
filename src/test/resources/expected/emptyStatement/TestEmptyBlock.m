   0 call 7
   1 stop
   2 ;TestEmptyBlock.j(0) /* Program to test generated Z80 assembler code */
   3 ;TestEmptyBlock.j(1) class TestEmptyBlock {
   4 class TestEmptyBlock []
   5 ;TestEmptyBlock.j(2) 
   6 ;TestEmptyBlock.j(3)   public static void main() {
   7 method main [public, static] void
   8 ;TestEmptyBlock.j(4)     println(1);
   9 acc8= constant 1
  10 call writeLineAcc8
  11 ;TestEmptyBlock.j(5)     {
  12 ;TestEmptyBlock.j(6)       ;
  13 ;TestEmptyBlock.j(7)     }
  14 ;TestEmptyBlock.j(8)     println(2);
  15 acc8= constant 2
  16 call writeLineAcc8
  17 ;TestEmptyBlock.j(9)     println("Klaar.");
  18 acc16= stringconstant 23
  19 writeLineString
  20 return
  21 ;TestEmptyBlock.j(10)   }
  22 ;TestEmptyBlock.j(11) }
  23 stringConstant 0 = "Klaar."
