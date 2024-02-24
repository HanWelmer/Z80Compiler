   0 call 6
   1 stop
   2 ;test4.j(0) /* Program to test division */
   3 ;test4.j(1) class TestDivide {
   4 class TestDivide []
   5 ;test4.j(2)   public static void main() {
   6 method main [public, static] void
   7 ;test4.j(3)     println(0 * 1);
   8 acc8= constant 0
   9 acc8* constant 1
  10 call writeLineAcc8
  11 ;test4.j(4)     println(1 * 1);
  12 acc8= constant 1
  13 acc8* constant 1
  14 call writeLineAcc8
  15 ;test4.j(5)     println(4 / 2);
  16 acc8= constant 4
  17 acc8/ constant 2
  18 call writeLineAcc8
  19 ;test4.j(6)     println(9 / 3);
  20 acc8= constant 9
  21 acc8/ constant 3
  22 call writeLineAcc8
  23 ;test4.j(7)     println(8 / 2);
  24 acc8= constant 8
  25 acc8/ constant 2
  26 call writeLineAcc8
  27 ;test4.j(8)     println(5 / 1);
  28 acc8= constant 5
  29 acc8/ constant 1
  30 call writeLineAcc8
  31 ;test4.j(9)     println((3 * 8) / 4);
  32 acc8= constant 3
  33 acc8* constant 8
  34 acc8/ constant 4
  35 call writeLineAcc8
  36 ;test4.j(10)     println((7 * 7) / 7);
  37 acc8= constant 7
  38 acc8* constant 7
  39 acc8/ constant 7
  40 call writeLineAcc8
  41 ;test4.j(11)     println((4 * 5 * 2) / 5);
  42 acc8= constant 4
  43 acc8* constant 5
  44 acc8* constant 2
  45 acc8/ constant 5
  46 call writeLineAcc8
  47 ;test4.j(12)     println(6561 / 729);
  48 acc16= constant 6561
  49 acc16/ constant 729
  50 call writeLineAcc16
  51 ;test4.j(13)     println(60 / 6);
  52 acc8= constant 60
  53 acc8/ constant 6
  54 call writeLineAcc8
  55 ;test4.j(14)     println(22 / 2);
  56 acc8= constant 22
  57 acc8/ constant 2
  58 call writeLineAcc8
  59 ;test4.j(15)     println(12);
  60 acc8= constant 12
  61 call writeLineAcc8
  62 ;test4.j(16)     println("Klaar");
  63 acc16= constant 68
  64 writeLineString
  65 return
  66 ;test4.j(17)   }
  67 ;test4.j(18) }
  68 stringConstant 0 = "Klaar"
