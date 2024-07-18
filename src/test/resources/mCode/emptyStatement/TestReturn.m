   0 call 7
   1 stop
   2 ;TestReturn.j(0) /* Program to test generated Z80 assembler code */
   3 ;TestReturn.j(1) class TestReturn {
   4 class TestReturn []
   5 ;TestReturn.j(2) 
   6 ;TestReturn.j(3)   public static void main() {
   7 method TestReturn.main [public, static] void ()
   8 <basePointer
   9 basePointer= stackPointer
  10 stackPointer+ constant 0
  11 ;TestReturn.j(4)     println(1);
  12 acc8= constant 1
  13 writeLineAcc8
  14 ;TestReturn.j(5)     println(2);
  15 acc8= constant 2
  16 writeLineAcc8
  17 ;TestReturn.j(6)     println("Klaar.");
  18 acc16= stringconstant 27
  19 writeLineString
  20 ;TestReturn.j(7)     ;
  21 ;TestReturn.j(8)     return;
  22 stackPointer= basePointer
  23 basePointer<
  24 return
  25 ;TestReturn.j(9)   }
  26 ;TestReturn.j(10) }
  27 stringConstant 0 = "Klaar."
