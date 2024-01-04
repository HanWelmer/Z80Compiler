   0 ;test0.j(0) /* Program to test generated Z80 assembler code */
   1 ;test0.j(1) class TestPrint {
   2 ;test0.j(2)   private static word i = 1;
   3 acc8= constant 1
   4 acc8=> variable 0
   5 ;test0.j(3)   private static byte b = 2;
   6 acc8= constant 2
   7 acc8=> variable 2
   8 ;test0.j(4)   
   9 ;test0.j(5)   public static void main() {
  10 ;test0.j(6)     println(0);
  11 acc8= constant 0
  12 call writeLineAcc8
  13 ;test0.j(7)     println(i);
  14 acc16= variable 0
  15 call writeLineAcc16
  16 ;test0.j(8)     println(b);
  17 acc8= variable 2
  18 call writeLineAcc8
  19 ;test0.j(9)     println("Hallo" + " wereld.");
  20 acc16= constant 56
  21 writeString
  22 acc16= constant 57
  23 writeLineString
  24 ;test0.j(10)     println("Nog" + " een" + " bericht.");
  25 acc16= constant 58
  26 writeString
  27 acc16= constant 59
  28 writeString
  29 acc16= constant 60
  30 writeLineString
  31 ;test0.j(11)     println("3 + 2 = " + 5);
  32 acc16= constant 61
  33 writeString
  34 acc8= constant 5
  35 call writeLineAcc8
  36 ;test0.j(12)     println("3 + 3 = " + (2 * 3));
  37 acc16= constant 62
  38 writeString
  39 acc8= constant 2
  40 acc8* constant 3
  41 call writeLineAcc8
  42 ;test0.j(13)     println("3 + 4 = " + (2 + 5) + ".");
  43 acc16= constant 63
  44 writeString
  45 acc8= constant 2
  46 acc8+ constant 5
  47 call writeAcc8
  48 acc16= constant 64
  49 writeLineString
  50 ;test0.j(14)     println("Klaar.");
  51 acc16= constant 65
  52 writeLineString
  53 ;test0.j(15)   }
  54 ;test0.j(16) }
  55 stop
  56 stringConstant 0 = "Hallo"
  57 stringConstant 1 = " wereld."
  58 stringConstant 2 = "Nog"
  59 stringConstant 3 = " een"
  60 stringConstant 4 = " bericht."
  61 stringConstant 5 = "3 + 2 = "
  62 stringConstant 6 = "3 + 3 = "
  63 stringConstant 7 = "3 + 4 = "
  64 stringConstant 8 = "."
  65 stringConstant 9 = "Klaar."
