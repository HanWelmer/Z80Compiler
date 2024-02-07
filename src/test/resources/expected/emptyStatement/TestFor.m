   0 ;TestFor.j(0) /* Program to test generated Z80 assembler code */
   1 ;TestFor.j(1) class TestFor {
   2 class TestFor []
   3 ;TestFor.j(2) 
   4 ;TestFor.j(3)   public static void main() {
   5 method main [public, static] void
   6 ;TestFor.j(4)     println(1);
   7 acc8= constant 1
   8 call writeLineAcc8
   9 ;TestFor.j(5)     for (byte b = 1; b < 2; b++) {
  10 acc8= constant 1
  11 acc8=> variable 0
  12 acc8= variable 0
  13 acc8Comp constant 2
  14 brge 22
  15 br 18
  16 incr8 variable 0
  17 br 12
  18 br 16
  19 ;TestFor.j(6)       ;
  20 ;TestFor.j(7)     }
  21 ;TestFor.j(8)     println(2);
  22 acc8= constant 2
  23 call writeLineAcc8
  24 ;TestFor.j(9)     for (byte b = 1; b < 2; b++) ;
  25 acc8= constant 1
  26 acc8=> variable 0
  27 acc8= variable 0
  28 acc8Comp constant 2
  29 brge 35
  30 br 33
  31 incr8 variable 0
  32 br 27
  33 br 31
  34 ;TestFor.j(10)     println(3);
  35 acc8= constant 3
  36 call writeLineAcc8
  37 ;TestFor.j(11)     for (byte b = 1; b < 2;) {
  38 acc8= constant 1
  39 acc8=> variable 0
  40 acc8= variable 0
  41 acc8Comp constant 2
  42 brge 53
  43 br 45
  44 br 40
  45 ;TestFor.j(12)       println(4);
  46 acc8= constant 4
  47 call writeLineAcc8
  48 ;TestFor.j(13)       b++;
  49 incr8 variable 0
  50 br 44
  51 ;TestFor.j(14)     }
  52 ;TestFor.j(15)     println(5);
  53 acc8= constant 5
  54 call writeLineAcc8
  55 ;TestFor.j(16)     println("Klaar.");
  56 acc16= constant 61
  57 writeLineString
  58 ;TestFor.j(17)   }
  59 ;TestFor.j(18) }
  60 stop
  61 stringConstant 0 = "Klaar."
