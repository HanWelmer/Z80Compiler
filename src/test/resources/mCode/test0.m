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
  10 method main [staticLexeme] voidLexeme
  11 ;test0.j(6)     println(0);
  12 acc8= constant 0
  13 call writeLineAcc8
  14 ;test0.j(7)     println(i);
  15 acc16= variable 0
  16 call writeLineAcc16
  17 ;test0.j(8)     println(b);
  18 acc8= variable 2
  19 call writeLineAcc8
  20 ;test0.j(9)     println("Hallo" + " wereld.");
  21 acc16= constant 57
  22 writeString
  23 acc16= constant 58
  24 writeLineString
  25 ;test0.j(10)     println("Nog" + " een" + " bericht.");
  26 acc16= constant 59
  27 writeString
  28 acc16= constant 60
  29 writeString
  30 acc16= constant 61
  31 writeLineString
  32 ;test0.j(11)     println("3 + 2 = " + 5);
  33 acc16= constant 62
  34 writeString
  35 acc8= constant 5
  36 call writeLineAcc8
  37 ;test0.j(12)     println("3 + 3 = " + (2 * 3));
  38 acc16= constant 63
  39 writeString
  40 acc8= constant 2
  41 acc8* constant 3
  42 call writeLineAcc8
  43 ;test0.j(13)     println("3 + 4 = " + (2 + 5) + ".");
  44 acc16= constant 64
  45 writeString
  46 acc8= constant 2
  47 acc8+ constant 5
  48 call writeAcc8
  49 acc16= constant 65
  50 writeLineString
  51 ;test0.j(14)     println("Klaar.");
  52 acc16= constant 66
  53 writeLineString
  54 ;test0.j(15)   }
  55 ;test0.j(16) }
  56 stop
  57 stringConstant 0 = "Hallo"
  58 stringConstant 1 = " wereld."
  59 stringConstant 2 = "Nog"
  60 stringConstant 3 = " een"
  61 stringConstant 4 = " bericht."
  62 stringConstant 5 = "3 + 2 = "
  63 stringConstant 6 = "3 + 3 = "
  64 stringConstant 7 = "3 + 4 = "
  65 stringConstant 8 = "."
  66 stringConstant 9 = "Klaar."
