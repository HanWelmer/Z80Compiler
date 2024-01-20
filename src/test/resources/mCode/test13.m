   0 ;test13.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   1 ;test13.j(1) class TestOutputInput {
   2 ;test13.j(2)   private static byte value;
   3 ;test13.j(3)   private static final byte OUTPUT_PORT = 0x08;
   4 ;test13.j(4)   private static final byte INPUT_PORT = 10;
   5 ;test13.j(5)   private static final byte FINAL_VALUE = 20;
   6 ;test13.j(6) 
   7 ;test13.j(7)   public static void main() {
   8 ;test13.j(8)     println(0);
   9 acc8= constant 0
  10 call writeLineAcc8
  11 ;test13.j(9)   
  12 ;test13.j(10)     // Possible port operand types:  constant, final var.
  13 ;test13.j(11)     // Possible value operand types: constant, acc, var, final var, stack8.
  14 ;test13.j(12)   
  15 ;test13.j(13)     /**********/
  16 ;test13.j(14)     /* Output */
  17 ;test13.j(15)     /**********/
  18 ;test13.j(16)   
  19 ;test13.j(17)     //port as decimal constant + value as decimal constant
  20 ;test13.j(18)     output(2, 1);
  21 output port 0x02 value 0x01
  22 ;test13.j(19)     println(3);
  23 acc8= constant 3
  24 call writeLineAcc8
  25 ;test13.j(20)   
  26 ;test13.j(21)     //port as decimal constant
  27 ;test13.j(22)     println("Enter 5");
  28 acc16= constant 119
  29 writeLineString
  30 ;test13.j(23)     value = input(4);
  31 input port 0x04
  32 acc8=> variable 0
  33 ;test13.j(24)     println(value);
  34 acc8= variable 0
  35 call writeLineAcc8
  36 ;test13.j(25)     println(6);
  37 acc8= constant 6
  38 call writeLineAcc8
  39 ;test13.j(26)   
  40 ;test13.j(27)     //port as final variable + value as hexadecimal constant
  41 ;test13.j(28)     output(OUTPUT_PORT, 0x07);
  42 output port 0x08 value 0x07
  43 ;test13.j(29)     println(9);
  44 acc8= constant 9
  45 call writeLineAcc8
  46 ;test13.j(30)   
  47 ;test13.j(31)     //port as final variable + value as acc8
  48 ;test13.j(32)     println("Enter 11");
  49 acc16= constant 120
  50 writeLineString
  51 ;test13.j(33)     output(12, input(INPUT_PORT));
  52 input port 0x0A
  53 output port 0x0C, value acc8
  54 ;test13.j(34)     println(13);
  55 acc8= constant 13
  56 call writeLineAcc8
  57 ;test13.j(35)   
  58 ;test13.j(36)     //constant + byte expression
  59 ;test13.j(37)     output(15, 4 + 2 * 5);
  60 acc8= constant 4
  61 <acc8= constant 2
  62 acc8* constant 5
  63 acc8+ unstack8
  64 output port 0x0F, value acc8
  65 ;test13.j(38)     println(16);
  66 acc8= constant 16
  67 call writeLineAcc8
  68 ;test13.j(39)    
  69 ;test13.j(40)     //constant + byte variable
  70 ;test13.j(41)     value = 17;
  71 acc8= constant 17
  72 acc8=> variable 0
  73 ;test13.j(42)     output(0x12, value);
  74 output port 0x12, value variable 0
  75 ;test13.j(43)     println(19);
  76 acc8= constant 19
  77 call writeLineAcc8
  78 ;test13.j(44)   
  79 ;test13.j(45)     //constant + final variable
  80 ;test13.j(46)     output(21, FINAL_VALUE);
  81 output port 0x15 value 0x14
  82 ;test13.j(47)     println(22);
  83 acc8= constant 22
  84 call writeLineAcc8
  85 ;test13.j(48)     
  86 ;test13.j(49)     //TODO enable test on output() with port number as constant expression
  87 ;test13.j(50)     /*
  88 ;test13.j(51)     //byte constant expression + decimal constant
  89 ;test13.j(52)     output(4 * 5 + 4, 23);
  90 ;test13.j(53)     println(15);
  91 ;test13.j(54)     */
  92 ;test13.j(55)   
  93 ;test13.j(56)   /*
  94 ;test13.j(57)     //hexadecimal constant
  95 ;test13.j(58)     //IN0     A,(0x13)
  96 ;test13.j(59)     println("Enter 16");
  97 ;test13.j(60)     value = input(0x0F);
  98 ;test13.j(61)     println(value);
  99 ;test13.j(62)   
 100 ;test13.j(63)     //byte constant expression
 101 ;test13.j(64)     println("Enter 18");
 102 ;test13.j(65)     value = input(7 + 5 * 2);
 103 ;test13.j(66)     println(value);
 104 ;test13.j(67)   
 105 ;test13.j(68)     //final variable
 106 ;test13.j(69)     //IN0     A,(0x13)
 107 ;test13.j(70)     port = 0x11;
 108 ;test13.j(71)     println("Enter 20");
 109 ;test13.j(72)     value = input(port);
 110 ;test13.j(73)     println(value);
 111 ;test13.j(74)   */
 112 ;test13.j(75)   
 113 ;test13.j(76)     println("Klaar");
 114 acc16= constant 121
 115 writeLineString
 116 ;test13.j(77)   }
 117 ;test13.j(78) }
 118 stop
 119 stringConstant 0 = "Enter 5"
 120 stringConstant 1 = "Enter 11"
 121 stringConstant 2 = "Klaar"
