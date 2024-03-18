   0 call 7
   1 stop
   2 ;TestEmptyBlock.j(0) /* Program to test generated Z80 assembler code */
   3 ;TestEmptyBlock.j(1) class TestEmptyBlock {
   4 class TestEmptyBlock []
   5 ;TestEmptyBlock.j(2) 
   6 ;TestEmptyBlock.j(3)   public static void main() {
   7 method main [public, static] void ()
   8 <basePointer
   9 basePointer= stackPointer
  10 stackPointer+ constant 0
  11 ;TestEmptyBlock.j(4)     println(1);
  12 acc8= constant 1
  13 writeLineAcc8
  14 ;TestEmptyBlock.j(5)     {
  15 ;TestEmptyBlock.j(6)       ;
  16 ;TestEmptyBlock.j(7)     }
  17 ;TestEmptyBlock.j(8)     println(2);
  18 acc8= constant 2
  19 writeLineAcc8
  20 ;TestEmptyBlock.j(9)     println("Klaar.");
  21 acc16= stringconstant 28
  22 writeLineString
  23 stackPointer= basePointer
  24 basePointer<
  25 return
  26 ;TestEmptyBlock.j(10)   }
  27 ;TestEmptyBlock.j(11) }
  28 stringConstant 0 = "Klaar."
