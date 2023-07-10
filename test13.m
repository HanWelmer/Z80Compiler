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
  23 acc16= constant 143
  24 writeLineString
  25 ;test13.j(18)   byte value = input(4);
  26 input port 0x04
  27 acc8=> variable 0
  28 ;test13.j(19)   println(value);
  29 acc8= variable 0
  30 call writeLineAcc8
  31 ;test13.j(20)   println(6);
  32 acc8= constant 6
  33 call writeLineAcc8
  34 ;test13.j(21) 
  35 ;test13.j(22)   //port as final variable + value as hexadecimal constant
  36 ;test13.j(23)   final byte port = 0x08;
  37 ;test13.j(24)   output(port, 0x07);
  38 output port 0x08 value 0x07
  39 ;test13.j(25)   println(9);
  40 acc8= constant 9
  41 call writeLineAcc8
  42 ;test13.j(26) 
  43 ;test13.j(27)   //port as final variable + value as acc8
  44 ;test13.j(28)   final byte inputPort = 10;
  45 ;test13.j(29)   println("Enter 11");
  46 acc16= constant 144
  47 writeLineString
  48 ;test13.j(30)   output(12, input(inputPort));
  49 input port 0x0A
  50 output port 0x0C, value acc8
  51 ;test13.j(31)   println(13);
  52 acc8= constant 13
  53 call writeLineAcc8
  54 ;test13.j(32) 
  55 ;test13.j(33)   //constant + byte expression
  56 ;test13.j(34)   output(15, 4 + 2 * 5);
  57 acc8= constant 4
  58 <acc8= constant 2
  59 acc8* constant 5
  60 acc8+ unstack8
  61 output port 0x0F, value acc8
  62 ;test13.j(35)   println(16);
  63 acc8= constant 16
  64 call writeLineAcc8
  65 ;test13.j(36)  
  66 ;test13.j(37)   //constant + byte variable
  67 ;test13.j(38)   value = 17;
  68 acc8= constant 17
  69 acc8=> variable 0
  70 ;test13.j(39)   output(0x12, value);
  71 output port 0x12, value variable 0
  72 ;test13.j(40)   println(19);
  73 acc8= constant 19
  74 call writeLineAcc8
  75 ;test13.j(41) 
  76 ;test13.j(42)   //constant + final variable
  77 ;test13.j(43)   final byte finalValue = 20;
  78 ;test13.j(44)   output(21, finalValue);
  79 output port 0x15 value 0x14
  80 ;test13.j(45)   println(22);
  81 acc8= constant 22
  82 call writeLineAcc8
  83 ;test13.j(46)   
  84 ;test13.j(47)   //temp test; move it somewhere else once it works
  85 ;test13.j(48)   println("Enter 23, expect 0x14"); //0001.0111 & 0001.1100 = 0001.0100
  86 acc16= constant 145
  87 writeLineString
  88 ;test13.j(49)   final byte PCR = 0x7E;
  89 ;test13.j(50)   output(PCR, input(PCR) & 0x1C);
  90 input port 0x7E
  91 acc8And constant 28
  92 output port 0x7E, value acc8
  93 ;test13.j(51) 
  94 ;test13.j(52)   //temp test; move it somewhere else once it works
  95 ;test13.j(53)   println("Enter 24, expect 0x19"); //0001.1000 | 0001.0001 = 0001.1001
  96 acc16= constant 146
  97 writeLineString
  98 ;test13.j(54)   output(PCR, input(PCR) | 0x11);
  99 input port 0x7E
 100 acc8Or constant 17
 101 output port 0x7E, value acc8
 102 ;test13.j(55) 
 103 ;test13.j(56)   //temp test; move it somewhere else once it works
 104 ;test13.j(57)   println("Enter 25, expect 0x0B"); //0001.1001 ^ 0001.0010 = 0000.1011
 105 acc16= constant 147
 106 writeLineString
 107 ;test13.j(58)   output(PCR, input(PCR) ^ 0x12);
 108 input port 0x7E
 109 acc8Xor constant 18
 110 output port 0x7E, value acc8
 111 ;test13.j(59) 
 112 ;test13.j(60)   /*
 113 ;test13.j(61)   //byte constant expression + decimal constant
 114 ;test13.j(62)   output(4 * 5 + 4, 23);
 115 ;test13.j(63)   println(15);
 116 ;test13.j(64)   */
 117 ;test13.j(65) 
 118 ;test13.j(66) /*
 119 ;test13.j(67)   //hexadecimal constant
 120 ;test13.j(68)   //IN0     A,(0x13)
 121 ;test13.j(69)   println("Enter 16");
 122 ;test13.j(70)   value = input(0x0F);
 123 ;test13.j(71)   println(value);
 124 ;test13.j(72) 
 125 ;test13.j(73)   //byte constant expression
 126 ;test13.j(74)   println("Enter 18");
 127 ;test13.j(75)   value = input(7 + 5 * 2);
 128 ;test13.j(76)   println(value);
 129 ;test13.j(77) 
 130 ;test13.j(78)   //final variable
 131 ;test13.j(79)   //IN0     A,(0x13)
 132 ;test13.j(80)   port = 0x11;
 133 ;test13.j(81)   println("Enter 20");
 134 ;test13.j(82)   value = input(port);
 135 ;test13.j(83)   println(value);
 136 ;test13.j(84) */
 137 ;test13.j(85) 
 138 ;test13.j(86)   println("Klaar");
 139 acc16= constant 148
 140 writeLineString
 141 ;test13.j(87) }
 142 stop
 143 stringConstant 0 = "Enter 5"
 144 stringConstant 1 = "Enter 11"
 145 stringConstant 2 = "Enter 23, expect 0x14"
 146 stringConstant 3 = "Enter 24, expect 0x19"
 147 stringConstant 4 = "Enter 25, expect 0x0B"
 148 stringConstant 5 = "Klaar"
