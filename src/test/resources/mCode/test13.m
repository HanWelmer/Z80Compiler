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
  11 method main [public, static] void ()
  12 <basePointer
  13 basePointer= stackPointer
  14 stackPointer+ constant 0
  15 ;test13.j(8)     println(0);
  16 acc8= constant 0
  17 writeLineAcc8
  18 ;test13.j(9)   
  19 ;test13.j(10)     // Possible port operand types:  constant, final var.
  20 ;test13.j(11)     // Possible value operand types: constant, acc, var, final var, stack8.
  21 ;test13.j(12)   
  22 ;test13.j(13)     /**********/
  23 ;test13.j(14)     /* Output */
  24 ;test13.j(15)     /**********/
  25 ;test13.j(16)   
  26 ;test13.j(17)     //port as decimal constant + value as decimal constant
  27 ;test13.j(18)     output(2, 1);
  28 output port 0x02 value 0x01
  29 ;test13.j(19)     println(3);
  30 acc8= constant 3
  31 writeLineAcc8
  32 ;test13.j(20)   
  33 ;test13.j(21)     //port as decimal constant
  34 ;test13.j(22)     println("Enter 5");
  35 acc16= stringconstant 128
  36 writeLineString
  37 ;test13.j(23)     value = input(4);
  38 input port 0x04
  39 acc8=> variable 0
  40 ;test13.j(24)     println(value);
  41 acc8= variable 0
  42 writeLineAcc8
  43 ;test13.j(25)     println(6);
  44 acc8= constant 6
  45 writeLineAcc8
  46 ;test13.j(26)   
  47 ;test13.j(27)     //port as final variable + value as hexadecimal constant
  48 ;test13.j(28)     output(OUTPUT_PORT, 0x07);
  49 output port 0x08 value 0x07
  50 ;test13.j(29)     println(9);
  51 acc8= constant 9
  52 writeLineAcc8
  53 ;test13.j(30)   
  54 ;test13.j(31)     //port as final variable + value as acc8
  55 ;test13.j(32)     println("Enter 11");
  56 acc16= stringconstant 129
  57 writeLineString
  58 ;test13.j(33)     output(12, input(INPUT_PORT));
  59 input port 0x0A
  60 output port 0x0C, value acc8
  61 ;test13.j(34)     println(13);
  62 acc8= constant 13
  63 writeLineAcc8
  64 ;test13.j(35)   
  65 ;test13.j(36)     //constant + byte expression
  66 ;test13.j(37)     output(15, 4 + 2 * 5);
  67 acc8= constant 4
  68 <acc8= constant 2
  69 acc8* constant 5
  70 acc8+ unstack8
  71 output port 0x0F, value acc8
  72 ;test13.j(38)     println(16);
  73 acc8= constant 16
  74 writeLineAcc8
  75 ;test13.j(39)    
  76 ;test13.j(40)     //constant + byte variable
  77 ;test13.j(41)     value = 17;
  78 acc8= constant 17
  79 acc8=> variable 0
  80 ;test13.j(42)     output(0x12, value);
  81 output port 0x12, value variable 0
  82 ;test13.j(43)     println(19);
  83 acc8= constant 19
  84 writeLineAcc8
  85 ;test13.j(44)   
  86 ;test13.j(45)     //constant + final variable
  87 ;test13.j(46)     output(21, FINAL_VALUE);
  88 output port 0x15 value 0x14
  89 ;test13.j(47)     println(22);
  90 acc8= constant 22
  91 writeLineAcc8
  92 ;test13.j(48)     
  93 ;test13.j(49)     //TODO enable test on output() with port number as constant expression
  94 ;test13.j(50)     /*
  95 ;test13.j(51)     //byte constant expression + decimal constant
  96 ;test13.j(52)     output(4 * 5 + 4, 23);
  97 ;test13.j(53)     println(15);
  98 ;test13.j(54)     */
  99 ;test13.j(55)   
 100 ;test13.j(56)   /*
 101 ;test13.j(57)     //hexadecimal constant
 102 ;test13.j(58)     //IN0     A,(0x13)
 103 ;test13.j(59)     println("Enter 16");
 104 ;test13.j(60)     value = input(0x0F);
 105 ;test13.j(61)     println(value);
 106 ;test13.j(62)   
 107 ;test13.j(63)     //byte constant expression
 108 ;test13.j(64)     println("Enter 18");
 109 ;test13.j(65)     value = input(7 + 5 * 2);
 110 ;test13.j(66)     println(value);
 111 ;test13.j(67)   
 112 ;test13.j(68)     //final variable
 113 ;test13.j(69)     //IN0     A,(0x13)
 114 ;test13.j(70)     port = 0x11;
 115 ;test13.j(71)     println("Enter 20");
 116 ;test13.j(72)     value = input(port);
 117 ;test13.j(73)     println(value);
 118 ;test13.j(74)   */
 119 ;test13.j(75)   
 120 ;test13.j(76)     println("Klaar");
 121 acc16= stringconstant 130
 122 writeLineString
 123 stackPointer= basePointer
 124 basePointer<
 125 return
 126 ;test13.j(77)   }
 127 ;test13.j(78) }
 128 stringConstant 0 = "Enter 5"
 129 stringConstant 1 = "Enter 11"
 130 stringConstant 2 = "Klaar"
