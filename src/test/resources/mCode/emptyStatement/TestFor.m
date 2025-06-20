   0 call 7
   1 stop
   2 ;TestFor.j(0) /* Program to test generated Z80 assembler code */
   3 ;TestFor.j(1) class TestFor {
   4 class TestFor []
   5 ;TestFor.j(2) 
   6 ;TestFor.j(3)   public static void main() {
   7 method TestFor.main [public, static] void ()
   8 <basePointer
   9 basePointer= stackPointer
  10 stackPointer+ constant 1
  11 ;TestFor.j(4)     println(1);
  12 acc8= constant 1
  13 writeLineAcc8
  14 ;TestFor.j(5)     for (byte b = 1; b < 2; b++) {
  15 acc8= constant 1
  16 acc8=> byte basePointer + 1
  17 acc8= byte basePointer + 1
  18 acc8Comp constant 2
  19 brge 27
  20 br 23
  21 incr8 byte basePointer + 1
  22 br 17
  23 ;TestFor.j(6)       ;
  24 ;TestFor.j(7)     }
  25 br 21
  26 ;TestFor.j(8)     println(2);
  27 acc8= constant 2
  28 writeLineAcc8
  29 ;TestFor.j(9)     for (byte b = 1; b < 2; b++) ;
  30 acc8= constant 1
  31 acc8=> byte basePointer + 1
  32 acc8= byte basePointer + 1
  33 acc8Comp constant 2
  34 brge 40
  35 br 38
  36 incr8 byte basePointer + 1
  37 br 32
  38 br 36
  39 ;TestFor.j(10)     println(3);
  40 acc8= constant 3
  41 writeLineAcc8
  42 ;TestFor.j(11)     for (byte b = 1; b < 2;) {
  43 acc8= constant 1
  44 acc8=> byte basePointer + 1
  45 acc8= byte basePointer + 1
  46 acc8Comp constant 2
  47 brge 58
  48 br 50
  49 br 45
  50 ;TestFor.j(12)       println(4);
  51 acc8= constant 4
  52 writeLineAcc8
  53 ;TestFor.j(13)       b++;
  54 incr8 byte basePointer + 1
  55 ;TestFor.j(14)     }
  56 br 49
  57 ;TestFor.j(15)     println(5);
  58 acc8= constant 5
  59 writeLineAcc8
  60 ;TestFor.j(16)     println("Klaar.");
  61 acc16= stringconstant 68
  62 writeLineString
  63 ;TestFor.j(17)   }
  64 stackPointer= basePointer
  65 basePointer<
  66 return
  67 ;TestFor.j(18) }
  68 stringConstant 0 = "Klaar."
