   0 call 7
   1 stop
   2 ;TestWhile.j(0) /* Program to test generated Z80 assembler code */
   3 ;TestWhile.j(1) class TestWhile {
   4 class TestWhile []
   5 ;TestWhile.j(2) 
   6 ;TestWhile.j(3)   public static void main() {
   7 method main [public, static] void ()
   8 <basePointer
   9 basePointer= stackPointer
  10 stackPointer+ constant 0
  11 ;TestWhile.j(4)     println(1);
  12 acc8= constant 1
  13 writeLineAcc8
  14 ;TestWhile.j(5)     while (1==0) {
  15 acc8= constant 1
  16 acc8Comp constant 0
  17 brne 22
  18 ;TestWhile.j(6)       ;
  19 br 15
  20 ;TestWhile.j(7)     }
  21 ;TestWhile.j(8)     println(2);
  22 acc8= constant 2
  23 writeLineAcc8
  24 ;TestWhile.j(9)     while (1==0) ;
  25 acc8= constant 1
  26 acc8Comp constant 0
  27 brne 30
  28 br 25
  29 ;TestWhile.j(10)     println(3);
  30 acc8= constant 3
  31 writeLineAcc8
  32 ;TestWhile.j(11)     println("Klaar.");
  33 acc16= stringconstant 40
  34 writeLineString
  35 stackPointer= basePointer
  36 basePointer<
  37 return
  38 ;TestWhile.j(12)   }
  39 ;TestWhile.j(13) }
  40 stringConstant 0 = "Klaar."
