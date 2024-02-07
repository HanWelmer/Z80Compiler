   0 ;TestEmptyBlock.j(0) /* Program to test generated Z80 assembler code */
   1 ;TestEmptyBlock.j(1) class TestEmptyBlock {
   2 class TestEmptyBlock []
   3 ;TestEmptyBlock.j(2) 
   4 ;TestEmptyBlock.j(3)   public static void main() {
   5 method main [public, static] void
   6 ;TestEmptyBlock.j(4)     println(1);
   7 acc8= constant 1
   8 call writeLineAcc8
   9 ;TestEmptyBlock.j(5)     {
  10 ;TestEmptyBlock.j(6)       ;
  11 ;TestEmptyBlock.j(7)     }
  12 ;TestEmptyBlock.j(8)     println(2);
  13 acc8= constant 2
  14 call writeLineAcc8
  15 ;TestEmptyBlock.j(9)     println("Klaar.");
  16 acc16= constant 21
  17 writeLineString
  18 ;TestEmptyBlock.j(10)   }
  19 ;TestEmptyBlock.j(11) }
  20 stop
  21 stringConstant 0 = "Klaar."
