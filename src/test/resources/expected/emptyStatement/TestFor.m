   0 call 7
   1 stop
   2 ;TestFor.j(0) /* Program to test generated Z80 assembler code */
   3 ;TestFor.j(1) class TestFor {
   4 class TestFor []
   5 ;TestFor.j(2) 
   6 ;TestFor.j(3)   public static void main() {
   7 method main [public, static] void
   8 ;TestFor.j(4)     println(1);
   9 acc8= constant 1
  10 call writeLineAcc8
  11 ;TestFor.j(5)     for (byte b = 1; b < 2; b++) {
  12 acc8= constant 1
  13 acc8=> variable 0
  14 acc8= variable 0
  15 acc8Comp constant 2
  16 brge 24
  17 br 20
  18 incr8 variable 0
  19 br 14
  20 ;TestFor.j(6)       ;
  21 br 18
  22 ;TestFor.j(7)     }
  23 ;TestFor.j(8)     println(2);
  24 acc8= constant 2
  25 call writeLineAcc8
  26 ;TestFor.j(9)     for (byte b = 1; b < 2; b++) ;
  27 acc8= constant 1
  28 acc8=> variable 0
  29 acc8= variable 0
  30 acc8Comp constant 2
  31 brge 37
  32 br 35
  33 incr8 variable 0
  34 br 29
  35 br 33
  36 ;TestFor.j(10)     println(3);
  37 acc8= constant 3
  38 call writeLineAcc8
  39 ;TestFor.j(11)     for (byte b = 1; b < 2;) {
  40 acc8= constant 1
  41 acc8=> variable 0
  42 acc8= variable 0
  43 acc8Comp constant 2
  44 brge 55
  45 br 47
  46 br 42
  47 ;TestFor.j(12)       println(4);
  48 acc8= constant 4
  49 call writeLineAcc8
  50 ;TestFor.j(13)       b++;
  51 incr8 variable 0
  52 br 46
  53 ;TestFor.j(14)     }
  54 ;TestFor.j(15)     println(5);
  55 acc8= constant 5
  56 call writeLineAcc8
  57 ;TestFor.j(16)     println("Klaar.");
  58 acc16= stringconstant 63
  59 writeLineString
  60 return
  61 ;TestFor.j(17)   }
  62 ;TestFor.j(18) }
  63 stringConstant 0 = "Klaar."
