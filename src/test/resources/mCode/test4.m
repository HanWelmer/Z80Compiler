   0 ;test4.j(0) /* Program to test division */
   1 ;test4.j(1) class TestDivide {
   2 ;test4.j(2)   public static void main() {
   3 method main [publicLexeme, staticLexeme] voidLexeme
   4 ;test4.j(3)     println(0 * 1);
   5 acc8= constant 0
   6 acc8* constant 1
   7 call writeLineAcc8
   8 ;test4.j(4)     println(1 * 1);
   9 acc8= constant 1
  10 acc8* constant 1
  11 call writeLineAcc8
  12 ;test4.j(5)     println(4 / 2);
  13 acc8= constant 4
  14 acc8/ constant 2
  15 call writeLineAcc8
  16 ;test4.j(6)     println(9 / 3);
  17 acc8= constant 9
  18 acc8/ constant 3
  19 call writeLineAcc8
  20 ;test4.j(7)     println(8 / 2);
  21 acc8= constant 8
  22 acc8/ constant 2
  23 call writeLineAcc8
  24 ;test4.j(8)     println(5 / 1);
  25 acc8= constant 5
  26 acc8/ constant 1
  27 call writeLineAcc8
  28 ;test4.j(9)     println((3 * 8) / 4);
  29 acc8= constant 3
  30 acc8* constant 8
  31 acc8/ constant 4
  32 call writeLineAcc8
  33 ;test4.j(10)     println((7 * 7) / 7);
  34 acc8= constant 7
  35 acc8* constant 7
  36 acc8/ constant 7
  37 call writeLineAcc8
  38 ;test4.j(11)     println((4 * 5 * 2) / 5);
  39 acc8= constant 4
  40 acc8* constant 5
  41 acc8* constant 2
  42 acc8/ constant 5
  43 call writeLineAcc8
  44 ;test4.j(12)     println(6561 / 729);
  45 acc16= constant 6561
  46 acc16/ constant 729
  47 call writeLineAcc16
  48 ;test4.j(13)     println(60 / 6);
  49 acc8= constant 60
  50 acc8/ constant 6
  51 call writeLineAcc8
  52 ;test4.j(14)     println(22 / 2);
  53 acc8= constant 22
  54 acc8/ constant 2
  55 call writeLineAcc8
  56 ;test4.j(15)     println(12);
  57 acc8= constant 12
  58 call writeLineAcc8
  59 ;test4.j(16)     println("Klaar");
  60 acc16= constant 65
  61 writeLineString
  62 ;test4.j(17)   }
  63 ;test4.j(18) }
  64 stop
  65 stringConstant 0 = "Klaar"
