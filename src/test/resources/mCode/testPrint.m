   0 call 13
   1 stop
   2 ;testPrint.j(0) /* Program to test generated Z80 assembler code */
   3 ;testPrint.j(1) class TestPrint {
   4 class TestPrint []
   5 ;testPrint.j(2)   private static word i = 1;
   6 acc8= constant 1
   7 acc8=> variable 0
   8 ;testPrint.j(3)   private static byte b = 2;
   9 acc8= constant 2
  10 acc8=> variable 2
  11 ;testPrint.j(4)   
  12 ;testPrint.j(5)   public static void main() {
  13 method TestPrint.main [public, static] void ()
  14 <basePointer
  15 basePointer= stackPointer
  16 stackPointer+ constant 0
  17 ;testPrint.j(6)     println(0);
  18 acc8= constant 0
  19 writeLineAcc8
  20 ;testPrint.j(7)     println(i);
  21 acc16= variable 0
  22 writeLineAcc16
  23 ;testPrint.j(8)     println(b);
  24 acc8= variable 2
  25 writeLineAcc8
  26 ;testPrint.j(9)     println("Hallo" + " wereld.");
  27 acc16= stringconstant 65
  28 writeString
  29 acc16= stringconstant 66
  30 writeLineString
  31 ;testPrint.j(10)     println("Nog" + " een" + " bericht.");
  32 acc16= stringconstant 67
  33 writeString
  34 acc16= stringconstant 68
  35 writeString
  36 acc16= stringconstant 69
  37 writeLineString
  38 ;testPrint.j(11)     println("3 + 2 = " + 5);
  39 acc16= stringconstant 70
  40 writeString
  41 acc8= constant 5
  42 writeLineAcc8
  43 ;testPrint.j(12)     println("3 + 3 = " + (2 * 3));
  44 acc16= stringconstant 71
  45 writeString
  46 acc8= constant 2
  47 acc8* constant 3
  48 writeLineAcc8
  49 ;testPrint.j(13)     println("3 + 4 = " + (2 + 5) + ".");
  50 acc16= stringconstant 72
  51 writeString
  52 acc8= constant 2
  53 acc8+ constant 5
  54 writeAcc8
  55 acc16= stringconstant 73
  56 writeLineString
  57 ;testPrint.j(14)     println("Klaar.");
  58 acc16= stringconstant 74
  59 writeLineString
  60 ;testPrint.j(15)   }
  61 stackPointer= basePointer
  62 basePointer<
  63 return
  64 ;testPrint.j(16) }
  65 stringConstant 0 = "Hallo"
  66 stringConstant 1 = " wereld."
  67 stringConstant 2 = "Nog"
  68 stringConstant 3 = " een"
  69 stringConstant 4 = " bericht."
  70 stringConstant 5 = "3 + 2 = "
  71 stringConstant 6 = "3 + 3 = "
  72 stringConstant 7 = "3 + 4 = "
  73 stringConstant 8 = "."
  74 stringConstant 9 = "Klaar."
