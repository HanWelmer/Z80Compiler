   0 ;TestDo.j(0) /* Program to test generated Z80 assembler code */
   1 ;TestDo.j(1) class TestDo {
   2 class TestDo []
   3 ;TestDo.j(2) 
   4 ;TestDo.j(3)   public static void main() {
   5 method main [public, static] void
   6 ;TestDo.j(4)     println(1);
   7 acc8= constant 1
   8 call writeLineAcc8
   9 ;TestDo.j(5)     do
  10 ;TestDo.j(6)     {
  11 ;TestDo.j(7)       ;
  12 ;TestDo.j(8)     }
  13 ;TestDo.j(9)     while (1==0);
  14 acc8= constant 1
  15 acc8Comp constant 0
  16 breq 11
  17 ;TestDo.j(10)     println(2);
  18 acc8= constant 2
  19 call writeLineAcc8
  20 ;TestDo.j(11)     do
  21 ;TestDo.j(12)       ;
  22 ;TestDo.j(13)     while (1==0);
  23 acc8= constant 1
  24 acc8Comp constant 0
  25 breq 22
  26 ;TestDo.j(14)     println(3);
  27 acc8= constant 3
  28 call writeLineAcc8
  29 ;TestDo.j(15)     println("Klaar.");
  30 acc16= constant 35
  31 writeLineString
  32 ;TestDo.j(16)   }
  33 ;TestDo.j(17) }
  34 stop
  35 stringConstant 0 = "Klaar."
