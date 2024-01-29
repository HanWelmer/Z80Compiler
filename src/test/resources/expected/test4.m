   0 ;test4.j(0) /* Program to test division */
   1 ;test4.j(1) class TestDivide {
   2 class TestDivide []
   3 ;test4.j(2)   public static void main() {
   4 method main [public, static] void
   5 ;test4.j(3)     println(0 * 1);
   6 acc8= constant 0
   7 acc8* constant 1
   8 call writeLineAcc8
   9 ;test4.j(4)     println(1 * 1);
  10 acc8= constant 1
  11 acc8* constant 1
  12 call writeLineAcc8
  13 ;test4.j(5)     println(4 / 2);
  14 acc8= constant 4
  15 acc8/ constant 2
  16 call writeLineAcc8
  17 ;test4.j(6)     println(9 / 3);
  18 acc8= constant 9
  19 acc8/ constant 3
  20 call writeLineAcc8
  21 ;test4.j(7)     println(8 / 2);
  22 acc8= constant 8
  23 acc8/ constant 2
  24 call writeLineAcc8
  25 ;test4.j(8)     println(5 / 1);
  26 acc8= constant 5
  27 acc8/ constant 1
  28 call writeLineAcc8
  29 ;test4.j(9)     println((3 * 8) / 4);
  30 acc8= constant 3
  31 acc8* constant 8
  32 acc8/ constant 4
  33 call writeLineAcc8
  34 ;test4.j(10)     println((7 * 7) / 7);
  35 acc8= constant 7
  36 acc8* constant 7
  37 acc8/ constant 7
  38 call writeLineAcc8
  39 ;test4.j(11)     println((4 * 5 * 2) / 5);
  40 acc8= constant 4
  41 acc8* constant 5
  42 acc8* constant 2
  43 acc8/ constant 5
  44 call writeLineAcc8
  45 ;test4.j(12)     println(6561 / 729);
  46 acc16= constant 6561
  47 acc16/ constant 729
  48 call writeLineAcc16
  49 ;test4.j(13)     println(60 / 6);
  50 acc8= constant 60
  51 acc8/ constant 6
  52 call writeLineAcc8
  53 ;test4.j(14)     println(22 / 2);
  54 acc8= constant 22
  55 acc8/ constant 2
  56 call writeLineAcc8
  57 ;test4.j(15)     println(12);
  58 acc8= constant 12
  59 call writeLineAcc8
  60 ;test4.j(16)     println("Klaar");
  61 acc16= constant 66
  62 writeLineString
  63 ;test4.j(17)   }
  64 ;test4.j(18) }
  65 stop
  66 stringConstant 0 = "Klaar"
