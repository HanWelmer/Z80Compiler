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
  29 ;test13.j(21)   // Possible port operand types:  constant, final var.
  30 ;test13.j(22)   // Possible value operand types: constant, acc, var, final var, stack8.
  31 ;test13.j(23)   
  32 ;test13.j(24)   //constant + decimal constant
  33 ;test13.j(25)   output(2, 1);
  34 ;test13.j(26)   println(3);
  35 ;test13.j(27) 
  36 ;test13.j(28)   //decimal constant
  37 ;test13.j(29)   println("Enter 4");
  38 ;test13.j(30)   byte value = input(5);
  39 ;test13.j(31)   //IN0     A,(5)
  40 ;test13.j(32)   println(value);
  41 ;test13.j(33)   println(6);
  42 ;test13.j(34) 
  43 ;test13.j(35)   println("Enter 7");
  44 ;test13.j(36)   output(2, input(8));
  45 ;test13.j(37)   println(9);
  46 ;test13.j(38) 
  47 ;test13.j(39)   //final variable + hexadecimal constant
  48 ;test13.j(40)   final byte port = 0x0A;
  49 ;test13.j(41)   output(port, 0x0B);
  50 ;test13.j(42)   println(12);
  51 ;test13.j(43) 
  52 ;test13.j(44)   println("Enter 13");
  53 ;test13.j(45)   output(0x0F, input(0xE));
  54 ;test13.j(46)   println(16);
  55 ;test13.j(47) 
  56 ;test13.j(48)   println("Enter 17");
  57 ;test13.j(49)   output(0x13, input(0x12));
  58 ;test13.j(50)   println(0x14);
  59 ;test13.j(51)   */
  60 ;test13.j(52) 
  61 ;test13.j(53)   //final variable + byte constant expression
  62 ;test13.j(54)   /*
  63 ;test13.j(55)   output(8, 3 + 2 * 2);
  64 ;test13.j(56)   println(9);
  65 ;test13.j(57)  
  66 ;test13.j(58)   //final variable + byte variable
  67 ;test13.j(59)   byte value = 10;
  68 ;test13.j(60)   output(0x0B, value);
  69 ;test13.j(61)   println(12);
  70 ;test13.j(62) 
  71 ;test13.j(63)   //byte constant expression + decimal constant
  72 ;test13.j(64)   output(2 * 5 + 4, 13);
  73 ;test13.j(65)   println(15);
  74 ;test13.j(66)   
  75 ;test13.j(67)   */
  76 ;test13.j(68) 
  77 ;test13.j(69) /*
  78 ;test13.j(70)   //hexadecimal constant
  79 ;test13.j(71)   //IN0     A,(0x13)
  80 ;test13.j(72)   println("Enter 16");
  81 ;test13.j(73)   value = input(0x0F);
  82 ;test13.j(74)   println(value);
  83 ;test13.j(75) 
  84 ;test13.j(76)   //byte constant expression
  85 ;test13.j(77)   println("Enter 18");
  86 ;test13.j(78)   value = input(7 + 5 * 2);
  87 ;test13.j(79)   println(value);
  88 ;test13.j(80) 
  89 ;test13.j(81)   //final variable
  90 ;test13.j(82)   //IN0     A,(0x13)
  91 ;test13.j(83)   port = 0x11;
  92 ;test13.j(84)   println("Enter 20");
  93 ;test13.j(85)   value = input(port);
  94 ;test13.j(86)   println(value);
  95 ;test13.j(87) */
  96 ;test13.j(88) 
  97 ;test13.j(89)   println("Klaar");
  98 acc16= constant 102
  99 writeLineString
 100 ;test13.j(90) }
 101 stop
 102 stringConstant 0 = "Klaar"
