   0 ;TestWhile.j(0) /* Program to test generated Z80 assembler code */
   1 ;TestWhile.j(1) class TestWhile {
   2 class TestWhile []
   3 ;TestWhile.j(2) 
   4 ;TestWhile.j(3)   public static void main() {
   5 method main [public, static] void
   6 ;TestWhile.j(4)     println(1);
   7 acc8= constant 1
   8 call writeLineAcc8
   9 ;TestWhile.j(5)     while (1==0) {
  10 acc8= constant 1
  11 acc8Comp constant 0
  12 brne 17
  13 br 10
  14 ;TestWhile.j(6)       ;
  15 ;TestWhile.j(7)     }
  16 ;TestWhile.j(8)     println(2);
  17 acc8= constant 2
  18 call writeLineAcc8
  19 ;TestWhile.j(9)     while (1==0) ;
  20 acc8= constant 1
  21 acc8Comp constant 0
  22 brne 25
  23 br 20
  24 ;TestWhile.j(10)     println(3);
  25 acc8= constant 3
  26 call writeLineAcc8
  27 ;TestWhile.j(11)     println("Klaar.");
  28 acc16= constant 33
  29 writeLineString
  30 ;TestWhile.j(12)   }
  31 ;TestWhile.j(13) }
  32 stop
  33 stringConstant 0 = "Klaar."
