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
  13 method main [public, static] void ()
  14 <basePointer
  15 basePointer= stackPointer
  16 stackPointer+ constant 0
  17 ;test14.j(6)     println(0);
  18 acc8= constant 0
  19 writeLineAcc8
  20 ;test14.j(7)   
  21 ;test14.j(8)     println("sleeping 0.25 second:");
  22 acc16= stringconstant 50
  23 writeLineString
  24 ;test14.j(9)     sleep(250);
  25 sleep 250
  26 ;test14.j(10)     println("sleeping 10 second:");
  27 acc16= stringconstant 51
  28 writeLineString
  29 ;test14.j(11)     sleep(10000);
  30 sleep 10000
  31 ;test14.j(12)     println("sleeping 0.25 second:");
  32 acc16= stringconstant 50
  33 writeLineString
  34 ;test14.j(13)     sleep(value);
  35 sleep 0
  36 ;test14.j(14)     println("sleeping 10 second:");
  37 acc16= stringconstant 51
  38 writeLineString
  39 ;test14.j(15)     sleep(bigValue);
  40 sleep 1
  41 ;test14.j(16)   
  42 ;test14.j(17)     println("Klaar");
  43 acc16= stringconstant 52
  44 writeLineString
  45 stackPointer= basePointer
  46 basePointer<
  47 return
  48 ;test14.j(18)   }
  49 ;test14.j(19) }
  50 stringConstant 0 = "sleeping 0.25 second:"
  51 stringConstant 1 = "sleeping 10 second:"
  52 stringConstant 2 = "Klaar"
