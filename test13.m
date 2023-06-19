   0 ;test13.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   1 ;test13.j(1) class TestOutputInput {
   2 ;test13.j(2) 
   3 ;test13.j(3)   println(0);
   4 acc8= constant 0
   5 call writeLineAcc8
   6 ;test13.j(4)   
   7 ;test13.j(5)   // Possible operand types: constant, acc, var, stack8.
   8 ;test13.j(6)   
   9 ;test13.j(7)   /**********/
  10 ;test13.j(8)   /* Output */
  11 ;test13.j(9)   /**********/
  12 ;test13.j(10)   
  13 ;test13.j(11)   //constant + decimal constant
  14 ;test13.j(12)   output(2, 1);
  15 output port 0x02 value 0x01
  16 ;test13.j(13)   println(3);
  17 acc8= constant 3
  18 call writeLineAcc8
  19 ;test13.j(14) 
  20 ;test13.j(15)   //final variable + hexadecimal constant
  21 ;test13.j(16)   final byte port = 0x05;
  22 ;test13.j(17)   output(port, 0x04);
  23 output port 0x05 value 0x04
  24 ;test13.j(18)   println(6);
  25 acc8= constant 6
  26 call writeLineAcc8
  27 ;test13.j(19) 
  28 ;test13.j(20)   /*
  29 ;test13.j(21) 
  30 ;test13.j(22)   //final variable + byte constant expression
  31 ;test13.j(23)   output(8, 3 + 2 * 2);
  32 ;test13.j(24)   println(9);
  33 ;test13.j(25)  
  34 ;test13.j(26)   //final variable + byte variable
  35 ;test13.j(27)   byte value = 10;
  36 ;test13.j(28)   output(0x0B, value);
  37 ;test13.j(29)   println(12);
  38 ;test13.j(30) 
  39 ;test13.j(31)   //byte constant expression + decimal constant
  40 ;test13.j(32)   output(2 * 5 + 4, 13);
  41 ;test13.j(33)   println(15);
  42 ;test13.j(34)   
  43 ;test13.j(35)   */
  44 ;test13.j(36) 
  45 ;test13.j(37)   /*********/
  46 ;test13.j(38)   /* Input */
  47 ;test13.j(39)   /*********/
  48 ;test13.j(40) 
  49 ;test13.j(41) /*
  50 ;test13.j(42)   //decimal constant
  51 ;test13.j(43)   println("Enter 14");
  52 ;test13.j(44)   value = input(13);
  53 ;test13.j(45)   //IN0     A,(13)
  54 ;test13.j(46)   println(value);
  55 ;test13.j(47) 
  56 ;test13.j(48)   //hexadecimal constant
  57 ;test13.j(49)   //IN0     A,(0x13)
  58 ;test13.j(50)   println("Enter 16");
  59 ;test13.j(51)   value = input(0x0F);
  60 ;test13.j(52)   println(value);
  61 ;test13.j(53) 
  62 ;test13.j(54)   //byte constant expression
  63 ;test13.j(55)   println("Enter 18");
  64 ;test13.j(56)   value = input(7 + 5 * 2);
  65 ;test13.j(57)   println(value);
  66 ;test13.j(58) 
  67 ;test13.j(59)   //final variable
  68 ;test13.j(60)   //IN0     A,(0x13)
  69 ;test13.j(61)   port = 0x11;
  70 ;test13.j(62)   println("Enter 20");
  71 ;test13.j(63)   value = input(port);
  72 ;test13.j(64)   println(value);
  73 ;test13.j(65) */
  74 ;test13.j(66) 
  75 ;test13.j(67)   println("Klaar");
  76 acc16= constant 80
  77 writeLineString
  78 ;test13.j(68) }
  79 stop
  80 stringConstant 0 = "Klaar"
