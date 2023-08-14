   0 ;test14.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   1 ;test14.j(1) class TestSleep {
   2 ;test14.j(2) 
   3 ;test14.j(3)   println(0);
   4 acc8= constant 0
   5 call writeLineAcc8
   6 ;test14.j(4) 
   7 ;test14.j(5)   println("sleeping 0.25 second:");
   8 acc16= constant 39
   9 writeLineString
  10 ;test14.j(6)   sleep(250);
  11 sleep 250
  12 ;test14.j(7)   println("sleeping 10 second:");
  13 acc16= constant 40
  14 writeLineString
  15 ;test14.j(8)   sleep(10000);
  16 sleep 10000
  17 ;test14.j(9)   println("sleeping 0.25 second:");
  18 acc16= constant 39
  19 writeLineString
  20 ;test14.j(10)   byte value = 200;
  21 acc8= constant 200
  22 acc8=> variable 0
  23 ;test14.j(11)   sleep(value);
  24 sleep 0
  25 ;test14.j(12)   println("sleeping 10 second:");
  26 acc16= constant 40
  27 writeLineString
  28 ;test14.j(13)   word bigValue = 10000;
  29 acc16= constant 10000
  30 acc16=> variable 1
  31 ;test14.j(14)   sleep(bigValue);
  32 sleep 1
  33 ;test14.j(15) 
  34 ;test14.j(16)   println("Klaar");
  35 acc16= constant 41
  36 writeLineString
  37 ;test14.j(17) }
  38 stop
  39 stringConstant 0 = "sleeping 0.25 second:"
  40 stringConstant 1 = "sleeping 10 second:"
  41 stringConstant 2 = "Klaar"
