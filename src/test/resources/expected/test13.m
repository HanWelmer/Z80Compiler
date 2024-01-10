   0 ;test13.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   1 ;test13.j(1) class TestOutputInput {
   2 ;test13.j(2)   private static byte value;
   3 ;test13.j(3)   private static final byte OUTPUT_PORT = 0x08;
   4 acc8= constant 8
   5 acc8=> variable 1
   6 ;test13.j(4)   private static final byte INPUT_PORT = 10;
   7 acc8= constant 10
   8 acc8=> variable 2
   9 ;test13.j(5)   private static final byte FINAL_VALUE = 20;
  10 acc8= constant 20
  11 acc8=> variable 3
  12 ;test13.j(6) 
  13 ;test13.j(7)   public static void main() {
  14 ;test13.j(8)     println(0);
  15 acc8= constant 0
  16 call writeLineAcc8
  17 ;test13.j(9)   
  18 ;test13.j(10)     // Possible port operand types:  constant, final var.
  19 ;test13.j(11)     // Possible value operand types: constant, acc, var, final var, stack8.
  20 ;test13.j(12)   
  21 ;test13.j(13)     /**********/
  22 ;test13.j(14)     /* Output */
  23 ;test13.j(15)     /**********/
  24 ;test13.j(16)   
  25 ;test13.j(17)     //port as decimal constant + value as decimal constant
  26 ;test13.j(18)     output(2, 1);
  27 output port 0x02 value 0x01
  28 ;test13.j(19)     println(3);
  29 acc8= constant 3
  30 call writeLineAcc8
  31 ;test13.j(20)   
  32 ;test13.j(21)     //port as decimal constant
  33 ;test13.j(22)     println("Enter 5");
  34 acc16= constant 125
  35 writeLineString
  36 ;test13.j(23)     value = input(4);
  37 input port 0x04
  38 acc8=> variable 0
  39 ;test13.j(24)     println(value);
  40 acc8= variable 0
  41 call writeLineAcc8
  42 ;test13.j(25)     println(6);
  43 acc8= constant 6
  44 call writeLineAcc8
  45 ;test13.j(26)   
  46 ;test13.j(27)     //port as final variable + value as hexadecimal constant
  47 ;test13.j(28)     output(OUTPUT_PORT, 0x07);
  48 output port 0x00 value 0x07
  49 ;test13.j(29)     println(9);
  50 acc8= constant 9
  51 call writeLineAcc8
  52 ;test13.j(30)   
  53 ;test13.j(31)     //port as final variable + value as acc8
  54 ;test13.j(32)     println("Enter 11");
  55 acc16= constant 126
  56 writeLineString
  57 ;test13.j(33)     output(12, input(INPUT_PORT));
  58 input port 0x00
  59 output port 0x0C, value acc8
  60 ;test13.j(34)     println(13);
  61 acc8= constant 13
  62 call writeLineAcc8
  63 ;test13.j(35)   
  64 ;test13.j(36)     //constant + byte expression
  65 ;test13.j(37)     output(15, 4 + 2 * 5);
  66 acc8= constant 4
  67 <acc8= constant 2
  68 acc8* constant 5
  69 acc8+ unstack8
  70 output port 0x0F, value acc8
  71 ;test13.j(38)     println(16);
  72 acc8= constant 16
  73 call writeLineAcc8
  74 ;test13.j(39)    
  75 ;test13.j(40)     //constant + byte variable
  76 ;test13.j(41)     value = 17;
  77 acc8= constant 17
  78 acc8=> variable 0
  79 ;test13.j(42)     output(0x12, value);
  80 output port 0x12, value variable 0
  81 ;test13.j(43)     println(19);
  82 acc8= constant 19
  83 call writeLineAcc8
  84 ;test13.j(44)   
  85 ;test13.j(45)     //constant + final variable
  86 ;test13.j(46)     output(21, FINAL_VALUE);
  87 output port 0x15 value 0x00
  88 ;test13.j(47)     println(22);
  89 acc8= constant 22
  90 call writeLineAcc8
  91 ;test13.j(48)     
  92 ;test13.j(49)     //TODO enable test on output() with port number as constant expression
  93 ;test13.j(50)     /*
  94 ;test13.j(51)     //byte constant expression + decimal constant
  95 ;test13.j(52)     output(4 * 5 + 4, 23);
  96 ;test13.j(53)     println(15);
  97 ;test13.j(54)     */
  98 ;test13.j(55)   
  99 ;test13.j(56)   /*
 100 ;test13.j(57)     //hexadecimal constant
 101 ;test13.j(58)     //IN0     A,(0x13)
 102 ;test13.j(59)     println("Enter 16");
 103 ;test13.j(60)     value = input(0x0F);
 104 ;test13.j(61)     println(value);
 105 ;test13.j(62)   
 106 ;test13.j(63)     //byte constant expression
 107 ;test13.j(64)     println("Enter 18");
 108 ;test13.j(65)     value = input(7 + 5 * 2);
 109 ;test13.j(66)     println(value);
 110 ;test13.j(67)   
 111 ;test13.j(68)     //final variable
 112 ;test13.j(69)     //IN0     A,(0x13)
 113 ;test13.j(70)     port = 0x11;
 114 ;test13.j(71)     println("Enter 20");
 115 ;test13.j(72)     value = input(port);
 116 ;test13.j(73)     println(value);
 117 ;test13.j(74)   */
 118 ;test13.j(75)   
 119 ;test13.j(76)     println("Klaar");
 120 acc16= constant 127
 121 writeLineString
 122 ;test13.j(77)   }
 123 ;test13.j(78) }
 124 stop
 125 stringConstant 0 = "Enter 5"
 126 stringConstant 1 = "Enter 11"
 127 stringConstant 2 = "Klaar"
