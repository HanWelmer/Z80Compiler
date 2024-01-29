   0 ;test13.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   1 ;test13.j(1) class TestOutputInput {
   2 class TestOutputInput []
   3 ;test13.j(2)   private static byte value;
   4 ;test13.j(3)   private static final byte OUTPUT_PORT = 0x08;
   5 ;test13.j(4)   private static final byte INPUT_PORT = 10;
   6 ;test13.j(5)   private static final byte FINAL_VALUE = 20;
   7 ;test13.j(6) 
   8 ;test13.j(7)   public static void main() {
   9 method main [static] void
  10 ;test13.j(8)     println(0);
  11 acc8= constant 0
  12 call writeLineAcc8
  13 ;test13.j(9)   
  14 ;test13.j(10)     // Possible port operand types:  constant, final var.
  15 ;test13.j(11)     // Possible value operand types: constant, acc, var, final var, stack8.
  16 ;test13.j(12)   
  17 ;test13.j(13)     /**********/
  18 ;test13.j(14)     /* Output */
  19 ;test13.j(15)     /**********/
  20 ;test13.j(16)   
  21 ;test13.j(17)     //port as decimal constant + value as decimal constant
  22 ;test13.j(18)     output(2, 1);
  23 output port 0x02 value 0x01
  24 ;test13.j(19)     println(3);
  25 acc8= constant 3
  26 call writeLineAcc8
  27 ;test13.j(20)   
  28 ;test13.j(21)     //port as decimal constant
  29 ;test13.j(22)     println("Enter 5");
  30 acc16= constant 121
  31 writeLineString
  32 ;test13.j(23)     value = input(4);
  33 input port 0x04
  34 acc8=> variable 0
  35 ;test13.j(24)     println(value);
  36 acc8= variable 0
  37 call writeLineAcc8
  38 ;test13.j(25)     println(6);
  39 acc8= constant 6
  40 call writeLineAcc8
  41 ;test13.j(26)   
  42 ;test13.j(27)     //port as final variable + value as hexadecimal constant
  43 ;test13.j(28)     output(OUTPUT_PORT, 0x07);
  44 output port 0x08 value 0x07
  45 ;test13.j(29)     println(9);
  46 acc8= constant 9
  47 call writeLineAcc8
  48 ;test13.j(30)   
  49 ;test13.j(31)     //port as final variable + value as acc8
  50 ;test13.j(32)     println("Enter 11");
  51 acc16= constant 122
  52 writeLineString
  53 ;test13.j(33)     output(12, input(INPUT_PORT));
  54 input port 0x0A
  55 output port 0x0C, value acc8
  56 ;test13.j(34)     println(13);
  57 acc8= constant 13
  58 call writeLineAcc8
  59 ;test13.j(35)   
  60 ;test13.j(36)     //constant + byte expression
  61 ;test13.j(37)     output(15, 4 + 2 * 5);
  62 acc8= constant 4
  63 <acc8= constant 2
  64 acc8* constant 5
  65 acc8+ unstack8
  66 output port 0x0F, value acc8
  67 ;test13.j(38)     println(16);
  68 acc8= constant 16
  69 call writeLineAcc8
  70 ;test13.j(39)    
  71 ;test13.j(40)     //constant + byte variable
  72 ;test13.j(41)     value = 17;
  73 acc8= constant 17
  74 acc8=> variable 0
  75 ;test13.j(42)     output(0x12, value);
  76 output port 0x12, value variable 0
  77 ;test13.j(43)     println(19);
  78 acc8= constant 19
  79 call writeLineAcc8
  80 ;test13.j(44)   
  81 ;test13.j(45)     //constant + final variable
  82 ;test13.j(46)     output(21, FINAL_VALUE);
  83 output port 0x15 value 0x14
  84 ;test13.j(47)     println(22);
  85 acc8= constant 22
  86 call writeLineAcc8
  87 ;test13.j(48)     
  88 ;test13.j(49)     //TODO enable test on output() with port number as constant expression
  89 ;test13.j(50)     /*
  90 ;test13.j(51)     //byte constant expression + decimal constant
  91 ;test13.j(52)     output(4 * 5 + 4, 23);
  92 ;test13.j(53)     println(15);
  93 ;test13.j(54)     */
  94 ;test13.j(55)   
  95 ;test13.j(56)   /*
  96 ;test13.j(57)     //hexadecimal constant
  97 ;test13.j(58)     //IN0     A,(0x13)
  98 ;test13.j(59)     println("Enter 16");
  99 ;test13.j(60)     value = input(0x0F);
 100 ;test13.j(61)     println(value);
 101 ;test13.j(62)   
 102 ;test13.j(63)     //byte constant expression
 103 ;test13.j(64)     println("Enter 18");
 104 ;test13.j(65)     value = input(7 + 5 * 2);
 105 ;test13.j(66)     println(value);
 106 ;test13.j(67)   
 107 ;test13.j(68)     //final variable
 108 ;test13.j(69)     //IN0     A,(0x13)
 109 ;test13.j(70)     port = 0x11;
 110 ;test13.j(71)     println("Enter 20");
 111 ;test13.j(72)     value = input(port);
 112 ;test13.j(73)     println(value);
 113 ;test13.j(74)   */
 114 ;test13.j(75)   
 115 ;test13.j(76)     println("Klaar");
 116 acc16= constant 123
 117 writeLineString
 118 ;test13.j(77)   }
 119 ;test13.j(78) }
 120 stop
 121 stringConstant 0 = "Enter 5"
 122 stringConstant 1 = "Enter 11"
 123 stringConstant 2 = "Klaar"
