   0 call 11
   1 stop
   2 ;test13.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   3 ;test13.j(1) class TestOutputInput {
   4 class TestOutputInput []
   5 ;test13.j(2)   private static byte value;
   6 ;test13.j(3)   private static final byte OUTPUT_PORT = 0x08;
   7 ;test13.j(4)   private static final byte INPUT_PORT = 10;
   8 ;test13.j(5)   private static final byte FINAL_VALUE = 20;
   9 ;test13.j(6) 
  10 ;test13.j(7)   public static void main() {
  11 method main [public, static] void
  12 ;test13.j(8)     println(0);
  13 acc8= constant 0
  14 call writeLineAcc8
  15 ;test13.j(9)   
  16 ;test13.j(10)     // Possible port operand types:  constant, final var.
  17 ;test13.j(11)     // Possible value operand types: constant, acc, var, final var, stack8.
  18 ;test13.j(12)   
  19 ;test13.j(13)     /**********/
  20 ;test13.j(14)     /* Output */
  21 ;test13.j(15)     /**********/
  22 ;test13.j(16)   
  23 ;test13.j(17)     //port as decimal constant + value as decimal constant
  24 ;test13.j(18)     output(2, 1);
  25 output port 0x02 value 0x01
  26 ;test13.j(19)     println(3);
  27 acc8= constant 3
  28 call writeLineAcc8
  29 ;test13.j(20)   
  30 ;test13.j(21)     //port as decimal constant
  31 ;test13.j(22)     println("Enter 5");
  32 acc16= stringconstant 123
  33 writeLineString
  34 ;test13.j(23)     value = input(4);
  35 input port 0x04
  36 acc8=> variable 0
  37 ;test13.j(24)     println(value);
  38 acc8= variable 0
  39 call writeLineAcc8
  40 ;test13.j(25)     println(6);
  41 acc8= constant 6
  42 call writeLineAcc8
  43 ;test13.j(26)   
  44 ;test13.j(27)     //port as final variable + value as hexadecimal constant
  45 ;test13.j(28)     output(OUTPUT_PORT, 0x07);
  46 output port 0x08 value 0x07
  47 ;test13.j(29)     println(9);
  48 acc8= constant 9
  49 call writeLineAcc8
  50 ;test13.j(30)   
  51 ;test13.j(31)     //port as final variable + value as acc8
  52 ;test13.j(32)     println("Enter 11");
  53 acc16= stringconstant 124
  54 writeLineString
  55 ;test13.j(33)     output(12, input(INPUT_PORT));
  56 input port 0x0A
  57 output port 0x0C, value acc8
  58 ;test13.j(34)     println(13);
  59 acc8= constant 13
  60 call writeLineAcc8
  61 ;test13.j(35)   
  62 ;test13.j(36)     //constant + byte expression
  63 ;test13.j(37)     output(15, 4 + 2 * 5);
  64 acc8= constant 4
  65 <acc8= constant 2
  66 acc8* constant 5
  67 acc8+ unstack8
  68 output port 0x0F, value acc8
  69 ;test13.j(38)     println(16);
  70 acc8= constant 16
  71 call writeLineAcc8
  72 ;test13.j(39)    
  73 ;test13.j(40)     //constant + byte variable
  74 ;test13.j(41)     value = 17;
  75 acc8= constant 17
  76 acc8=> variable 0
  77 ;test13.j(42)     output(0x12, value);
  78 output port 0x12, value variable 0
  79 ;test13.j(43)     println(19);
  80 acc8= constant 19
  81 call writeLineAcc8
  82 ;test13.j(44)   
  83 ;test13.j(45)     //constant + final variable
  84 ;test13.j(46)     output(21, FINAL_VALUE);
  85 output port 0x15 value 0x14
  86 ;test13.j(47)     println(22);
  87 acc8= constant 22
  88 call writeLineAcc8
  89 ;test13.j(48)     
  90 ;test13.j(49)     //TODO enable test on output() with port number as constant expression
  91 ;test13.j(50)     /*
  92 ;test13.j(51)     //byte constant expression + decimal constant
  93 ;test13.j(52)     output(4 * 5 + 4, 23);
  94 ;test13.j(53)     println(15);
  95 ;test13.j(54)     */
  96 ;test13.j(55)   
  97 ;test13.j(56)   /*
  98 ;test13.j(57)     //hexadecimal constant
  99 ;test13.j(58)     //IN0     A,(0x13)
 100 ;test13.j(59)     println("Enter 16");
 101 ;test13.j(60)     value = input(0x0F);
 102 ;test13.j(61)     println(value);
 103 ;test13.j(62)   
 104 ;test13.j(63)     //byte constant expression
 105 ;test13.j(64)     println("Enter 18");
 106 ;test13.j(65)     value = input(7 + 5 * 2);
 107 ;test13.j(66)     println(value);
 108 ;test13.j(67)   
 109 ;test13.j(68)     //final variable
 110 ;test13.j(69)     //IN0     A,(0x13)
 111 ;test13.j(70)     port = 0x11;
 112 ;test13.j(71)     println("Enter 20");
 113 ;test13.j(72)     value = input(port);
 114 ;test13.j(73)     println(value);
 115 ;test13.j(74)   */
 116 ;test13.j(75)   
 117 ;test13.j(76)     println("Klaar");
 118 acc16= stringconstant 125
 119 writeLineString
 120 return
 121 ;test13.j(77)   }
 122 ;test13.j(78) }
 123 stringConstant 0 = "Enter 5"
 124 stringConstant 1 = "Enter 11"
 125 stringConstant 2 = "Klaar"
