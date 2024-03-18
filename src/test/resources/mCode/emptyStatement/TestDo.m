   0 call 7
   1 stop
   2 ;TestDo.j(0) /* Program to test generated Z80 assembler code */
   3 ;TestDo.j(1) class TestDo {
   4 class TestDo []
   5 ;TestDo.j(2) 
   6 ;TestDo.j(3)   public static void main() {
   7 method main [public, static] void ()
   8 <basePointer
   9 basePointer= stackPointer
  10 stackPointer+ constant 0
  11 ;TestDo.j(4)     println(1);
  12 acc8= constant 1
  13 writeLineAcc8
  14 ;TestDo.j(5)     do
  15 ;TestDo.j(6)     {
  16 ;TestDo.j(7)       ;
  17 ;TestDo.j(8)     }
  18 ;TestDo.j(9)     while (1==0);
  19 acc8= constant 1
  20 acc8Comp constant 0
  21 breq 16
  22 ;TestDo.j(10)     println(2);
  23 acc8= constant 2
  24 writeLineAcc8
  25 ;TestDo.j(11)     do
  26 ;TestDo.j(12)       ;
  27 ;TestDo.j(13)     while (1==0);
  28 acc8= constant 1
  29 acc8Comp constant 0
  30 breq 27
  31 ;TestDo.j(14)     println(3);
  32 acc8= constant 3
  33 writeLineAcc8
  34 ;TestDo.j(15)     println("Klaar.");
  35 acc16= stringconstant 42
  36 writeLineString
  37 stackPointer= basePointer
  38 basePointer<
  39 return
  40 ;TestDo.j(16)   }
  41 ;TestDo.j(17) }
  42 stringConstant 0 = "Klaar."
