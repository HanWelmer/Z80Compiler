   0 call 7
   1 stop
   2 ;TestDo.j(0) /* Program to test generated Z80 assembler code */
   3 ;TestDo.j(1) class TestDo {
   4 class TestDo []
   5 ;TestDo.j(2) 
   6 ;TestDo.j(3)   public static void main() {
   7 method main [public, static] void
   8 ;TestDo.j(4)     println(1);
   9 acc8= constant 1
  10 call writeLineAcc8
  11 ;TestDo.j(5)     do
  12 ;TestDo.j(6)     {
  13 ;TestDo.j(7)       ;
  14 ;TestDo.j(8)     }
  15 ;TestDo.j(9)     while (1==0);
  16 acc8= constant 1
  17 acc8Comp constant 0
  18 breq 13
  19 ;TestDo.j(10)     println(2);
  20 acc8= constant 2
  21 call writeLineAcc8
  22 ;TestDo.j(11)     do
  23 ;TestDo.j(12)       ;
  24 ;TestDo.j(13)     while (1==0);
  25 acc8= constant 1
  26 acc8Comp constant 0
  27 breq 24
  28 ;TestDo.j(14)     println(3);
  29 acc8= constant 3
  30 call writeLineAcc8
  31 ;TestDo.j(15)     println("Klaar.");
  32 acc16= stringconstant 37
  33 writeLineString
  34 return
  35 ;TestDo.j(16)   }
  36 ;TestDo.j(17) }
  37 stringConstant 0 = "Klaar."
