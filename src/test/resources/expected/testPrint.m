   0 call 6
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
  11 br 14
  12 ;testPrint.j(4)   
  13 ;testPrint.j(5)   public static void main() {
  14 method TestPrint.main [public, static] void ()
  15 <basePointer
  16 basePointer= stackPointer
  17 stackPointer+ constant 0
  18 ;testPrint.j(6)     println(0);
  19 acc8= constant 0
  20 writeLineAcc8
  21 ;testPrint.j(7)     println(i);
  22 acc16= variable 0
  23 writeLineAcc16
  24 ;testPrint.j(8)     println(b);
  25 acc8= variable 2
  26 writeLineAcc8
  27 ;testPrint.j(9)     println("Hallo" + " wereld.");
  28 acc16= stringconstant 66
  29 writeString
  30 acc16= stringconstant 67
  31 writeLineString
  32 ;testPrint.j(10)     println("Nog" + " een" + " bericht.");
  33 acc16= stringconstant 68
  34 writeString
  35 acc16= stringconstant 69
  36 writeString
  37 acc16= stringconstant 70
  38 writeLineString
  39 ;testPrint.j(11)     println("3 + 2 = " + 5);
  40 acc16= stringconstant 71
  41 writeString
  42 acc8= constant 5
  43 writeLineAcc8
  44 ;testPrint.j(12)     println("3 + 3 = " + (2 * 3));
  45 acc16= stringconstant 72
  46 writeString
  47 acc8= constant 2
  48 acc8* constant 3
  49 writeLineAcc8
  50 ;testPrint.j(13)     println("3 + 4 = " + (2 + 5) + ".");
  51 acc16= stringconstant 73
  52 writeString
  53 acc8= constant 2
  54 acc8+ constant 5
  55 writeAcc8
  56 acc16= stringconstant 74
  57 writeLineString
  58 ;testPrint.j(14)     println("Klaar.");
  59 acc16= stringconstant 75
  60 writeLineString
  61 ;testPrint.j(15)   }
  62 stackPointer= basePointer
  63 basePointer<
  64 return
  65 ;testPrint.j(16) }
  66 stringConstant 0 = "Hallo"
  67 stringConstant 1 = " wereld."
  68 stringConstant 2 = "Nog"
  69 stringConstant 3 = " een"
  70 stringConstant 4 = " bericht."
  71 stringConstant 5 = "3 + 2 = "
  72 stringConstant 6 = "3 + 3 = "
  73 stringConstant 7 = "3 + 4 = "
  74 stringConstant 8 = "."
  75 stringConstant 9 = "Klaar."
