   0 ;test4.j(0) /* Program to test division */
   1 ;test4.j(1) class TestDivide {
   2 ;test4.j(2)   public static void main() {
   3 ;test4.j(3)     println(0 * 1);
   4 acc8= constant 0
   5 acc8* constant 1
   6 call writeLineAcc8
   7 ;test4.j(4)     println(1 * 1);
   8 acc8= constant 1
   9 acc8* constant 1
  10 call writeLineAcc8
  11 ;test4.j(5)     println(4 / 2);
  12 acc8= constant 4
  13 acc8/ constant 2
  14 call writeLineAcc8
  15 ;test4.j(6)     println(9 / 3);
  16 acc8= constant 9
  17 acc8/ constant 3
  18 call writeLineAcc8
  19 ;test4.j(7)     println(8 / 2);
  20 acc8= constant 8
  21 acc8/ constant 2
  22 call writeLineAcc8
  23 ;test4.j(8)     println(5 / 1);
  24 acc8= constant 5
  25 acc8/ constant 1
  26 call writeLineAcc8
  27 ;test4.j(9)     println((3 * 8) / 4);
  28 acc8= constant 3
  29 acc8* constant 8
  30 acc8/ constant 4
  31 call writeLineAcc8
  32 ;test4.j(10)     println((7 * 7) / 7);
  33 acc8= constant 7
  34 acc8* constant 7
  35 acc8/ constant 7
  36 call writeLineAcc8
  37 ;test4.j(11)     println((4 * 5 * 2) / 5);
  38 acc8= constant 4
  39 acc8* constant 5
  40 acc8* constant 2
  41 acc8/ constant 5
  42 call writeLineAcc8
  43 ;test4.j(12)     println(6561 / 729);
  44 acc16= constant 6561
  45 acc16/ constant 729
  46 call writeLineAcc16
  47 ;test4.j(13)     println(60 / 6);
  48 acc8= constant 60
  49 acc8/ constant 6
  50 call writeLineAcc8
  51 ;test4.j(14)     println(22 / 2);
  52 acc8= constant 22
  53 acc8/ constant 2
  54 call writeLineAcc8
  55 ;test4.j(15)     println(12);
  56 acc8= constant 12
  57 call writeLineAcc8
  58 ;test4.j(16)     println("Klaar");
  59 acc16= constant 64
  60 writeLineString
  61 ;test4.j(17)   }
  62 ;test4.j(18) }
  63 stop
  64 stringConstant 0 = "Klaar"
