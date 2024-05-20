   0 call 6
   1 stop
   2 ;testDivide.j(0) /* Program to test division */
   3 ;testDivide.j(1) class TestDivide {
   4 class TestDivide []
   5 ;testDivide.j(2)   public static void main() {
   6 method main [public, static] void ()
   7 <basePointer
   8 basePointer= stackPointer
   9 stackPointer+ constant 0
  10 ;testDivide.j(3)     println(0 * 1);
  11 acc8= constant 0
  12 acc8* constant 1
  13 writeLineAcc8
  14 ;testDivide.j(4)     println(1 * 1);
  15 acc8= constant 1
  16 acc8* constant 1
  17 writeLineAcc8
  18 ;testDivide.j(5)     println(4 / 2);
  19 acc8= constant 4
  20 acc8/ constant 2
  21 writeLineAcc8
  22 ;testDivide.j(6)     println(9 / 3);
  23 acc8= constant 9
  24 acc8/ constant 3
  25 writeLineAcc8
  26 ;testDivide.j(7)     println(8 / 2);
  27 acc8= constant 8
  28 acc8/ constant 2
  29 writeLineAcc8
  30 ;testDivide.j(8)     println(5 / 1);
  31 acc8= constant 5
  32 acc8/ constant 1
  33 writeLineAcc8
  34 ;testDivide.j(9)     println((3 * 8) / 4);
  35 acc8= constant 3
  36 acc8* constant 8
  37 acc8/ constant 4
  38 writeLineAcc8
  39 ;testDivide.j(10)     println((7 * 7) / 7);
  40 acc8= constant 7
  41 acc8* constant 7
  42 acc8/ constant 7
  43 writeLineAcc8
  44 ;testDivide.j(11)     println((4 * 5 * 2) / 5);
  45 acc8= constant 4
  46 acc8* constant 5
  47 acc8* constant 2
  48 acc8/ constant 5
  49 writeLineAcc8
  50 ;testDivide.j(12)     println(6561 / 729);
  51 acc16= constant 6561
  52 acc16/ constant 729
  53 writeLineAcc16
  54 ;testDivide.j(13)     println(60 / 6);
  55 acc8= constant 60
  56 acc8/ constant 6
  57 writeLineAcc8
  58 ;testDivide.j(14)     println(22 / 2);
  59 acc8= constant 22
  60 acc8/ constant 2
  61 writeLineAcc8
  62 ;testDivide.j(15)     println(12);
  63 acc8= constant 12
  64 writeLineAcc8
  65 ;testDivide.j(16)     println("Klaar");
  66 acc16= stringconstant 73
  67 writeLineString
  68 ;testDivide.j(17)   }
  69 stackPointer= basePointer
  70 basePointer<
  71 return
  72 ;testDivide.j(18) }
  73 stringConstant 0 = "Klaar"
