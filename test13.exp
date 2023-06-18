   0 ;test13.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   1 ;test13.j(1) class TestOutputInput {
   2 ;test13.j(2) 
   3 ;test13.j(3)   println(0);
   4 acc8= constant 0
   5 call writeLineAcc8
   6 ;test13.j(4)   
   7 ;test13.j(5)   // Possible operand types: constant, acc, var, stack8.
   8 ;test13.j(6)   
   9 ;test13.j(7)   //constant + decimal constant
  10 ;test13.j(8)   output(2, 1);
  11 output port 0x02 value 0x01
  12 ;test13.j(9)   println(3);
  13 acc8= constant 3
  14 call writeLineAcc8
  15 ;test13.j(10) 
  16 ;test13.j(11)   //final variable + hexadecimal constant
  17 ;test13.j(12)   final byte port = 0x05;
  18 ;test13.j(13)   output(port, 0x04);
  19 output port 0x05 value 0x04
  20 ;test13.j(14)   println(6);
  21 acc8= constant 6
  22 call writeLineAcc8
  23 ;test13.j(15) 
  24 ;test13.j(16)   println("Klaar");
  25 acc16= constant 29
  26 writeLineString
  27 ;test13.j(17) }
  28 stop
  29 stringConstant 0 = "Klaar"
