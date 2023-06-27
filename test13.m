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
  23 acc16= constant 97
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
  44 ;test13.j(28)   //port as final variable + value as acc8
  45 ;test13.j(29)   final byte inputPort = 10;
  46 ;test13.j(30)   println("Enter 12");
  47 acc16= constant 98
  48 writeLineString
  49 ;test13.j(31)   output(11, input(inputPort));
  50 input port 0x0A
  51 output port 0x0B, value acc8
  52 ;test13.j(32)   println(13);
  53 acc8= constant 13
  54 call writeLineAcc8
  55 ;test13.j(33) 
  56 ;test13.j(34)   /*
  57 ;test13.j(35)   //final variable + byte constant expression
  58 ;test13.j(36)   output(8, 3 + 2 * 2);
  59 ;test13.j(37)   println(9);
  60 ;test13.j(38)  
  61 ;test13.j(39)   //final variable + byte variable
  62 ;test13.j(40)   byte value = 10;
  63 ;test13.j(41)   output(0x0B, value);
  64 ;test13.j(42)   println(12);
  65 ;test13.j(43) 
  66 ;test13.j(44)   //byte constant expression + decimal constant
  67 ;test13.j(45)   output(2 * 5 + 4, 13);
  68 ;test13.j(46)   println(15);
  69 ;test13.j(47)   
  70 ;test13.j(48)   */
  71 ;test13.j(49) 
  72 ;test13.j(50) /*
  73 ;test13.j(51)   //hexadecimal constant
  74 ;test13.j(52)   //IN0     A,(0x13)
  75 ;test13.j(53)   println("Enter 16");
  76 ;test13.j(54)   value = input(0x0F);
  77 ;test13.j(55)   println(value);
  78 ;test13.j(56) 
  79 ;test13.j(57)   //byte constant expression
  80 ;test13.j(58)   println("Enter 18");
  81 ;test13.j(59)   value = input(7 + 5 * 2);
  82 ;test13.j(60)   println(value);
  83 ;test13.j(61) 
  84 ;test13.j(62)   //final variable
  85 ;test13.j(63)   //IN0     A,(0x13)
  86 ;test13.j(64)   port = 0x11;
  87 ;test13.j(65)   println("Enter 20");
  88 ;test13.j(66)   value = input(port);
  89 ;test13.j(67)   println(value);
  90 ;test13.j(68) */
  91 ;test13.j(69) 
  92 ;test13.j(70)   println("Klaar");
  93 acc16= constant 99
  94 writeLineString
  95 ;test13.j(71) }
  96 stop
  97 stringConstant 0 = "Enter 5"
  98 stringConstant 1 = "Enter 12"
  99 stringConstant 2 = "Klaar"
