   0 ;test14.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   1 ;test14.j(1) class TestSleep {
   2 ;test14.j(2)   private static byte value = 200;
   3 acc8= constant 200
   4 acc8=> variable 0
   5 ;test14.j(3)   private static word bigValue = 10000;
   6 acc16= constant 10000
   7 acc16=> variable 1
   8 ;test14.j(4) 
   9 ;test14.j(5)   public static void main() {
  10 method main [staticLexeme] voidLexeme
  11 ;test14.j(6)     println(0);
  12 acc8= constant 0
  13 call writeLineAcc8
  14 ;test14.j(7)   
  15 ;test14.j(8)     println("sleeping 0.25 second:");
  16 acc16= constant 42
  17 writeLineString
  18 ;test14.j(9)     sleep(250);
  19 sleep 250
  20 ;test14.j(10)     println("sleeping 10 second:");
  21 acc16= constant 43
  22 writeLineString
  23 ;test14.j(11)     sleep(10000);
  24 sleep 10000
  25 ;test14.j(12)     println("sleeping 0.25 second:");
  26 acc16= constant 42
  27 writeLineString
  28 ;test14.j(13)     sleep(value);
  29 sleep 0
  30 ;test14.j(14)     println("sleeping 10 second:");
  31 acc16= constant 43
  32 writeLineString
  33 ;test14.j(15)     sleep(bigValue);
  34 sleep 1
  35 ;test14.j(16)   
  36 ;test14.j(17)     println("Klaar");
  37 acc16= constant 44
  38 writeLineString
  39 ;test14.j(18)   }
  40 ;test14.j(19) }
  41 stop
  42 stringConstant 0 = "sleeping 0.25 second:"
  43 stringConstant 1 = "sleeping 10 second:"
  44 stringConstant 2 = "Klaar"
