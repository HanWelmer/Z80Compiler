   0 ;test0.j(0) /* Program to test generated Z80 assembler code */
   1 ;test0.j(1) class TestPrint {
   2 class TestPrint []
   3 ;test0.j(2)   private static word i = 1;
   4 acc8= constant 1
   5 acc8=> variable 0
   6 ;test0.j(3)   private static byte b = 2;
   7 acc8= constant 2
   8 acc8=> variable 2
   9 ;test0.j(4)   
  10 ;test0.j(5)   public static void main() {
  11 method main [public, static] void
  12 ;test0.j(6)     println(0);
  13 acc8= constant 0
  14 call writeLineAcc8
  15 ;test0.j(7)     println(i);
  16 acc16= variable 0
  17 call writeLineAcc16
  18 ;test0.j(8)     println(b);
  19 acc8= variable 2
  20 call writeLineAcc8
  21 ;test0.j(9)     println("Hallo" + " wereld.");
  22 acc16= constant 58
  23 writeString
  24 acc16= constant 59
  25 writeLineString
  26 ;test0.j(10)     println("Nog" + " een" + " bericht.");
  27 acc16= constant 60
  28 writeString
  29 acc16= constant 61
  30 writeString
  31 acc16= constant 62
  32 writeLineString
  33 ;test0.j(11)     println("3 + 2 = " + 5);
  34 acc16= constant 63
  35 writeString
  36 acc8= constant 5
  37 call writeLineAcc8
  38 ;test0.j(12)     println("3 + 3 = " + (2 * 3));
  39 acc16= constant 64
  40 writeString
  41 acc8= constant 2
  42 acc8* constant 3
  43 call writeLineAcc8
  44 ;test0.j(13)     println("3 + 4 = " + (2 + 5) + ".");
  45 acc16= constant 65
  46 writeString
  47 acc8= constant 2
  48 acc8+ constant 5
  49 call writeAcc8
  50 acc16= constant 66
  51 writeLineString
  52 ;test0.j(14)     println("Klaar.");
  53 acc16= constant 67
  54 writeLineString
  55 ;test0.j(15)   }
  56 ;test0.j(16) }
  57 stop
  58 stringConstant 0 = "Hallo"
  59 stringConstant 1 = " wereld."
  60 stringConstant 2 = "Nog"
  61 stringConstant 3 = " een"
  62 stringConstant 4 = " bericht."
  63 stringConstant 5 = "3 + 2 = "
  64 stringConstant 6 = "3 + 3 = "
  65 stringConstant 7 = "3 + 4 = "
  66 stringConstant 8 = "."
  67 stringConstant 9 = "Klaar."
