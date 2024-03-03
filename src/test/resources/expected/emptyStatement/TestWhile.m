   0 call 7
   1 stop
   2 ;TestWhile.j(0) /* Program to test generated Z80 assembler code */
   3 ;TestWhile.j(1) class TestWhile {
   4 class TestWhile []
   5 ;TestWhile.j(2) 
   6 ;TestWhile.j(3)   public static void main() {
   7 method main [public, static] void
   8 ;TestWhile.j(4)     println(1);
   9 acc8= constant 1
  10 call writeLineAcc8
  11 ;TestWhile.j(5)     while (1==0) {
  12 acc8= constant 1
  13 acc8Comp constant 0
  14 brne 19
  15 ;TestWhile.j(6)       ;
  16 br 12
  17 ;TestWhile.j(7)     }
  18 ;TestWhile.j(8)     println(2);
  19 acc8= constant 2
  20 call writeLineAcc8
  21 ;TestWhile.j(9)     while (1==0) ;
  22 acc8= constant 1
  23 acc8Comp constant 0
  24 brne 27
  25 br 22
  26 ;TestWhile.j(10)     println(3);
  27 acc8= constant 3
  28 call writeLineAcc8
  29 ;TestWhile.j(11)     println("Klaar.");
  30 acc16= stringconstant 35
  31 writeLineString
  32 return
  33 ;TestWhile.j(12)   }
  34 ;TestWhile.j(13) }
  35 stringConstant 0 = "Klaar."
