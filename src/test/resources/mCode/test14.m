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
  10 ;test14.j(6)     println(0);
  11 acc8= constant 0
  12 call writeLineAcc8
  13 ;test14.j(7)   
  14 ;test14.j(8)     println("sleeping 0.25 second:");
  15 acc16= constant 41
  16 writeLineString
  17 ;test14.j(9)     sleep(250);
  18 sleep 250
  19 ;test14.j(10)     println("sleeping 10 second:");
  20 acc16= constant 42
  21 writeLineString
  22 ;test14.j(11)     sleep(10000);
  23 sleep 10000
  24 ;test14.j(12)     println("sleeping 0.25 second:");
  25 acc16= constant 41
  26 writeLineString
  27 ;test14.j(13)     sleep(value);
  28 sleep 0
  29 ;test14.j(14)     println("sleeping 10 second:");
  30 acc16= constant 42
  31 writeLineString
  32 ;test14.j(15)     sleep(bigValue);
  33 sleep 1
  34 ;test14.j(16)   
  35 ;test14.j(17)     println("Klaar");
  36 acc16= constant 43
  37 writeLineString
  38 ;test14.j(18)   }
  39 ;test14.j(19) }
  40 stop
  41 stringConstant 0 = "sleeping 0.25 second:"
  42 stringConstant 1 = "sleeping 10 second:"
  43 stringConstant 2 = "Klaar"
