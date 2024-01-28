   0 ;test13.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   1 ;test13.j(1) class TestOutputInput {
   2 ;test13.j(2)   private static byte value;
   3 ;test13.j(3)   private static final byte OUTPUT_PORT = 0x08;
   4 ;test13.j(4)   private static final byte INPUT_PORT = 10;
   5 ;test13.j(5)   private static final byte FINAL_VALUE = 20;
   6 ;test13.j(6) 
   7 ;test13.j(7)   public static void main() {
   8 method main [staticLexeme] voidLexeme
   9 ;test13.j(8)     println(0);
  10 acc8= constant 0
  11 call writeLineAcc8
  12 ;test13.j(9)   
  13 ;test13.j(10)     // Possible port operand types:  constant, final var.
  14 ;test13.j(11)     // Possible value operand types: constant, acc, var, final var, stack8.
  15 ;test13.j(12)   
  16 ;test13.j(13)     /**********/
  17 ;test13.j(14)     /* Output */
  18 ;test13.j(15)     /**********/
  19 ;test13.j(16)   
  20 ;test13.j(17)     //port as decimal constant + value as decimal constant
  21 ;test13.j(18)     output(2, 1);
  22 output port 0x02 value 0x01
  23 ;test13.j(19)     println(3);
  24 acc8= constant 3
  25 call writeLineAcc8
  26 ;test13.j(20)   
  27 ;test13.j(21)     //port as decimal constant
  28 ;test13.j(22)     println("Enter 5");
  29 acc16= constant 120
  30 writeLineString
  31 ;test13.j(23)     value = input(4);
  32 input port 0x04
  33 acc8=> variable 0
  34 ;test13.j(24)     println(value);
  35 acc8= variable 0
  36 call writeLineAcc8
  37 ;test13.j(25)     println(6);
  38 acc8= constant 6
  39 call writeLineAcc8
  40 ;test13.j(26)   
  41 ;test13.j(27)     //port as final variable + value as hexadecimal constant
  42 ;test13.j(28)     output(OUTPUT_PORT, 0x07);
  43 output port 0x08 value 0x07
  44 ;test13.j(29)     println(9);
  45 acc8= constant 9
  46 call writeLineAcc8
  47 ;test13.j(30)   
  48 ;test13.j(31)     //port as final variable + value as acc8
  49 ;test13.j(32)     println("Enter 11");
  50 acc16= constant 121
  51 writeLineString
  52 ;test13.j(33)     output(12, input(INPUT_PORT));
  53 input port 0x0A
  54 output port 0x0C, value acc8
  55 ;test13.j(34)     println(13);
  56 acc8= constant 13
  57 call writeLineAcc8
  58 ;test13.j(35)   
  59 ;test13.j(36)     //constant + byte expression
  60 ;test13.j(37)     output(15, 4 + 2 * 5);
  61 acc8= constant 4
  62 <acc8= constant 2
  63 acc8* constant 5
  64 acc8+ unstack8
  65 output port 0x0F, value acc8
  66 ;test13.j(38)     println(16);
  67 acc8= constant 16
  68 call writeLineAcc8
  69 ;test13.j(39)    
  70 ;test13.j(40)     //constant + byte variable
  71 ;test13.j(41)     value = 17;
  72 acc8= constant 17
  73 acc8=> variable 0
  74 ;test13.j(42)     output(0x12, value);
  75 output port 0x12, value variable 0
  76 ;test13.j(43)     println(19);
  77 acc8= constant 19
  78 call writeLineAcc8
  79 ;test13.j(44)   
  80 ;test13.j(45)     //constant + final variable
  81 ;test13.j(46)     output(21, FINAL_VALUE);
  82 output port 0x15 value 0x14
  83 ;test13.j(47)     println(22);
  84 acc8= constant 22
  85 call writeLineAcc8
  86 ;test13.j(48)     
  87 ;test13.j(49)     //TODO enable test on output() with port number as constant expression
  88 ;test13.j(50)     /*
  89 ;test13.j(51)     //byte constant expression + decimal constant
  90 ;test13.j(52)     output(4 * 5 + 4, 23);
  91 ;test13.j(53)     println(15);
  92 ;test13.j(54)     */
  93 ;test13.j(55)   
  94 ;test13.j(56)   /*
  95 ;test13.j(57)     //hexadecimal constant
  96 ;test13.j(58)     //IN0     A,(0x13)
  97 ;test13.j(59)     println("Enter 16");
  98 ;test13.j(60)     value = input(0x0F);
  99 ;test13.j(61)     println(value);
 100 ;test13.j(62)   
 101 ;test13.j(63)     //byte constant expression
 102 ;test13.j(64)     println("Enter 18");
 103 ;test13.j(65)     value = input(7 + 5 * 2);
 104 ;test13.j(66)     println(value);
 105 ;test13.j(67)   
 106 ;test13.j(68)     //final variable
 107 ;test13.j(69)     //IN0     A,(0x13)
 108 ;test13.j(70)     port = 0x11;
 109 ;test13.j(71)     println("Enter 20");
 110 ;test13.j(72)     value = input(port);
 111 ;test13.j(73)     println(value);
 112 ;test13.j(74)   */
 113 ;test13.j(75)   
 114 ;test13.j(76)     println("Klaar");
 115 acc16= constant 122
 116 writeLineString
 117 ;test13.j(77)   }
 118 ;test13.j(78) }
 119 stop
 120 stringConstant 0 = "Enter 5"
 121 stringConstant 1 = "Enter 11"
 122 stringConstant 2 = "Klaar"
