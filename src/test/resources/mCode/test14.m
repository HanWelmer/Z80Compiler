   0 ;test14.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   1 ;test14.j(1) class TestSleep {
   2 class TestSleep []
   3 ;test14.j(2)   private static byte value = 200;
   4 acc8= constant 200
   5 acc8=> variable 0
   6 ;test14.j(3)   private static word bigValue = 10000;
   7 acc16= constant 10000
   8 acc16=> variable 1
   9 ;test14.j(4) 
  10 ;test14.j(5)   public static void main() {
  11 method main [static] void
  12 ;test14.j(6)     println(0);
  13 acc8= constant 0
  14 call writeLineAcc8
  15 ;test14.j(7)   
  16 ;test14.j(8)     println("sleeping 0.25 second:");
  17 acc16= constant 43
  18 writeLineString
  19 ;test14.j(9)     sleep(250);
  20 sleep 250
  21 ;test14.j(10)     println("sleeping 10 second:");
  22 acc16= constant 44
  23 writeLineString
  24 ;test14.j(11)     sleep(10000);
  25 sleep 10000
  26 ;test14.j(12)     println("sleeping 0.25 second:");
  27 acc16= constant 43
  28 writeLineString
  29 ;test14.j(13)     sleep(value);
  30 sleep 0
  31 ;test14.j(14)     println("sleeping 10 second:");
  32 acc16= constant 44
  33 writeLineString
  34 ;test14.j(15)     sleep(bigValue);
  35 sleep 1
  36 ;test14.j(16)   
  37 ;test14.j(17)     println("Klaar");
  38 acc16= constant 45
  39 writeLineString
  40 ;test14.j(18)   }
  41 ;test14.j(19) }
  42 stop
  43 stringConstant 0 = "sleeping 0.25 second:"
  44 stringConstant 1 = "sleeping 10 second:"
  45 stringConstant 2 = "Klaar"
