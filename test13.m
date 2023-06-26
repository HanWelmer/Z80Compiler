   0 ;test13.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   1 ;test13.j(1) class TestOutputInput {
   2 ;test13.j(2) 
   3 ;test13.j(3)   println(0);
   4 acc8= constant 0
   5 call writeLineAcc8
   6 ;test13.j(4) 
   7 ;test13.j(5)   // Possible port operand types:  constant, final var.
   8 ;test13.j(6)   // Possible value operand types: constant, acc, var, final var, stack8.
   9 ;test13.j(7) 
  10 ;test13.j(8)   /**********/
  11 ;test13.j(9)   /* Output */
  12 ;test13.j(10)   /**********/
  13 ;test13.j(11) 
  14 ;test13.j(12)   //port as decimal constant + value as decimal constant
  15 ;test13.j(13)   output(2, 1);
  16 output port 0x02 value 0x01
  17 ;test13.j(14)   println(3);
  18 acc8= constant 3
  19 call writeLineAcc8
  20 ;test13.j(15) 
  21 ;test13.j(16)   //port as decimal constant
  22 ;test13.j(17)   println("Enter 5");
  23 acc16= constant 106
  24 writeLineString
  25 ;test13.j(18)   byte value = input(4);
  26 input port 0x04
  27 acc8=> variable 0
  28 ;test13.j(19)   //IN0     A,(4)
  29 ;test13.j(20)   println(value);
  30 acc8= variable 0
  31 call writeLineAcc8
  32 ;test13.j(21)   println(6);
  33 acc8= constant 6
  34 call writeLineAcc8
  35 ;test13.j(22) 
  36 ;test13.j(23)   //port as final variable + value as hexadecimal constant
  37 ;test13.j(24)   final byte port = 0x08;
  38 ;test13.j(25)   output(port, 0x07);
  39 output port 0x08 value 0x07
  40 ;test13.j(26)   println(9);
  41 acc8= constant 9
  42 call writeLineAcc8
  43 ;test13.j(27) 
  44 ;test13.j(28)   /*
  45 ;test13.j(29) 
  46 ;test13.j(30)   //port as decimal constant + value as acc8
  47 ;test13.j(31)   println("Enter 12");
  48 ;test13.j(32)   output(11, input(10));
  49 ;test13.j(33)   println(13);
  50 ;test13.j(34) 
  51 ;test13.j(35)   //final variable + hexadecimal constant
  52 ;test13.j(36)   final byte port = 0x0A;
  53 ;test13.j(37)   output(port, 0x0B);
  54 ;test13.j(38)   println(12);
  55 ;test13.j(39) 
  56 ;test13.j(40)   println("Enter 13");
  57 ;test13.j(41)   output(0x0F, input(0xE));
  58 ;test13.j(42)   println(16);
  59 ;test13.j(43) 
  60 ;test13.j(44)   println("Enter 17");
  61 ;test13.j(45)   output(0x13, input(0x12));
  62 ;test13.j(46)   println(0x14);
  63 ;test13.j(47)   */
  64 ;test13.j(48) 
  65 ;test13.j(49)   //final variable + byte constant expression
  66 ;test13.j(50)   /*
  67 ;test13.j(51)   output(8, 3 + 2 * 2);
  68 ;test13.j(52)   println(9);
  69 ;test13.j(53)  
  70 ;test13.j(54)   //final variable + byte variable
  71 ;test13.j(55)   byte value = 10;
  72 ;test13.j(56)   output(0x0B, value);
  73 ;test13.j(57)   println(12);
  74 ;test13.j(58) 
  75 ;test13.j(59)   //byte constant expression + decimal constant
  76 ;test13.j(60)   output(2 * 5 + 4, 13);
  77 ;test13.j(61)   println(15);
  78 ;test13.j(62)   
  79 ;test13.j(63)   */
  80 ;test13.j(64) 
  81 ;test13.j(65) /*
  82 ;test13.j(66)   //hexadecimal constant
  83 ;test13.j(67)   //IN0     A,(0x13)
  84 ;test13.j(68)   println("Enter 16");
  85 ;test13.j(69)   value = input(0x0F);
  86 ;test13.j(70)   println(value);
  87 ;test13.j(71) 
  88 ;test13.j(72)   //byte constant expression
  89 ;test13.j(73)   println("Enter 18");
  90 ;test13.j(74)   value = input(7 + 5 * 2);
  91 ;test13.j(75)   println(value);
  92 ;test13.j(76) 
  93 ;test13.j(77)   //final variable
  94 ;test13.j(78)   //IN0     A,(0x13)
  95 ;test13.j(79)   port = 0x11;
  96 ;test13.j(80)   println("Enter 20");
  97 ;test13.j(81)   value = input(port);
  98 ;test13.j(82)   println(value);
  99 ;test13.j(83) */
 100 ;test13.j(84) 
 101 ;test13.j(85)   println("Klaar");
 102 acc16= constant 107
 103 writeLineString
 104 ;test13.j(86) }
 105 stop
 106 stringConstant 0 = "Enter 5"
 107 stringConstant 1 = "Klaar"
