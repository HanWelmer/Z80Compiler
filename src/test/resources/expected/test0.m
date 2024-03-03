   0 call 13
   1 stop
   2 ;test0.j(0) /* Program to test generated Z80 assembler code */
   3 ;test0.j(1) class TestPrint {
   4 class TestPrint []
   5 ;test0.j(2)   private static word i = 1;
   6 acc8= constant 1
   7 acc8=> variable 0
   8 ;test0.j(3)   private static byte b = 2;
   9 acc8= constant 2
  10 acc8=> variable 2
  11 ;test0.j(4)   
  12 ;test0.j(5)   public static void main() {
  13 method main [public, static] void
  14 ;test0.j(6)     println(0);
  15 acc8= constant 0
  16 call writeLineAcc8
  17 ;test0.j(7)     println(i);
  18 acc16= variable 0
  19 call writeLineAcc16
  20 ;test0.j(8)     println(b);
  21 acc8= variable 2
  22 call writeLineAcc8
  23 ;test0.j(9)     println("Hallo" + " wereld.");
  24 acc16= stringconstant 60
  25 writeString
  26 acc16= stringconstant 61
  27 writeLineString
  28 ;test0.j(10)     println("Nog" + " een" + " bericht.");
  29 acc16= stringconstant 62
  30 writeString
  31 acc16= stringconstant 63
  32 writeString
  33 acc16= stringconstant 64
  34 writeLineString
  35 ;test0.j(11)     println("3 + 2 = " + 5);
  36 acc16= stringconstant 65
  37 writeString
  38 acc8= constant 5
  39 call writeLineAcc8
  40 ;test0.j(12)     println("3 + 3 = " + (2 * 3));
  41 acc16= stringconstant 66
  42 writeString
  43 acc8= constant 2
  44 acc8* constant 3
  45 call writeLineAcc8
  46 ;test0.j(13)     println("3 + 4 = " + (2 + 5) + ".");
  47 acc16= stringconstant 67
  48 writeString
  49 acc8= constant 2
  50 acc8+ constant 5
  51 call writeAcc8
  52 acc16= stringconstant 68
  53 writeLineString
  54 ;test0.j(14)     println("Klaar.");
  55 acc16= stringconstant 69
  56 writeLineString
  57 return
  58 ;test0.j(15)   }
  59 ;test0.j(16) }
  60 stringConstant 0 = "Hallo"
  61 stringConstant 1 = " wereld."
  62 stringConstant 2 = "Nog"
  63 stringConstant 3 = " een"
  64 stringConstant 4 = " bericht."
  65 stringConstant 5 = "3 + 2 = "
  66 stringConstant 6 = "3 + 3 = "
  67 stringConstant 7 = "3 + 4 = "
  68 stringConstant 8 = "."
  69 stringConstant 9 = "Klaar."
