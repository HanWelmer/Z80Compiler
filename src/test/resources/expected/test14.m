   0 call 13
   1 stop
   2 ;test14.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   3 ;test14.j(1) class TestSleep {
   4 class TestSleep []
   5 ;test14.j(2)   private static byte value = 200;
   6 acc8= constant 200
   7 acc8=> variable 0
   8 ;test14.j(3)   private static word bigValue = 10000;
   9 acc16= constant 10000
  10 acc16=> variable 1
  11 ;test14.j(4) 
  12 ;test14.j(5)   public static void main() {
  13 method main [public, static] void
  14 ;test14.j(6)     println(0);
  15 acc8= constant 0
  16 call writeLineAcc8
  17 ;test14.j(7)   
  18 ;test14.j(8)     println("sleeping 0.25 second:");
  19 acc16= stringconstant 45
  20 writeLineString
  21 ;test14.j(9)     sleep(250);
  22 sleep 250
  23 ;test14.j(10)     println("sleeping 10 second:");
  24 acc16= stringconstant 46
  25 writeLineString
  26 ;test14.j(11)     sleep(10000);
  27 sleep 10000
  28 ;test14.j(12)     println("sleeping 0.25 second:");
  29 acc16= stringconstant 45
  30 writeLineString
  31 ;test14.j(13)     sleep(value);
  32 sleep 0
  33 ;test14.j(14)     println("sleeping 10 second:");
  34 acc16= stringconstant 46
  35 writeLineString
  36 ;test14.j(15)     sleep(bigValue);
  37 sleep 1
  38 ;test14.j(16)   
  39 ;test14.j(17)     println("Klaar");
  40 acc16= stringconstant 47
  41 writeLineString
  42 return
  43 ;test14.j(18)   }
  44 ;test14.j(19) }
  45 stringConstant 0 = "sleeping 0.25 second:"
  46 stringConstant 1 = "sleeping 10 second:"
  47 stringConstant 2 = "Klaar"
