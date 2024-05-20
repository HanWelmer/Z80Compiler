   0 call 11
   1 stop
   2 ;testOutputInput.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   3 ;testOutputInput.j(1) class TestOutputInput {
   4 class TestOutputInput []
   5 ;testOutputInput.j(2)   private static byte value;
   6 ;testOutputInput.j(3)   private static final byte OUTPUT_PORT = 0x08;
   7 ;testOutputInput.j(4)   private static final byte INPUT_PORT = 10;
   8 ;testOutputInput.j(5)   private static final byte FINAL_VALUE = 20;
   9 ;testOutputInput.j(6) 
  10 ;testOutputInput.j(7)   public static void main() {
  11 method main [public, static] void ()
  12 <basePointer
  13 basePointer= stackPointer
  14 stackPointer+ constant 0
  15 ;testOutputInput.j(8)     println(0);
  16 acc8= constant 0
  17 writeLineAcc8
  18 ;testOutputInput.j(9)   
  19 ;testOutputInput.j(10)     // Possible port operand types:  constant, final var.
  20 ;testOutputInput.j(11)     // Possible value operand types: constant, acc, var, final var, stack8.
  21 ;testOutputInput.j(12)   
  22 ;testOutputInput.j(13)     /**********/
  23 ;testOutputInput.j(14)     /* Output */
  24 ;testOutputInput.j(15)     /**********/
  25 ;testOutputInput.j(16)   
  26 ;testOutputInput.j(17)     //port as decimal constant + value as decimal constant
  27 ;testOutputInput.j(18)     output(2, 1);
  28 output port 0x02 value 0x01
  29 ;testOutputInput.j(19)     println(3);
  30 acc8= constant 3
  31 writeLineAcc8
  32 ;testOutputInput.j(20)   
  33 ;testOutputInput.j(21)     //port as decimal constant
  34 ;testOutputInput.j(22)     println("Enter 5");
  35 acc16= stringconstant 128
  36 writeLineString
  37 ;testOutputInput.j(23)     value = input(4);
  38 input port 0x04
  39 acc8=> variable 0
  40 ;testOutputInput.j(24)     println(value);
  41 acc8= variable 0
  42 writeLineAcc8
  43 ;testOutputInput.j(25)     println(6);
  44 acc8= constant 6
  45 writeLineAcc8
  46 ;testOutputInput.j(26)   
  47 ;testOutputInput.j(27)     //port as final variable + value as hexadecimal constant
  48 ;testOutputInput.j(28)     output(OUTPUT_PORT, 0x07);
  49 output port 0x08 value 0x07
  50 ;testOutputInput.j(29)     println(9);
  51 acc8= constant 9
  52 writeLineAcc8
  53 ;testOutputInput.j(30)   
  54 ;testOutputInput.j(31)     //port as final variable + value as acc8
  55 ;testOutputInput.j(32)     println("Enter 11");
  56 acc16= stringconstant 129
  57 writeLineString
  58 ;testOutputInput.j(33)     output(12, input(INPUT_PORT));
  59 input port 0x0A
  60 output port 0x0C, value acc8
  61 ;testOutputInput.j(34)     println(13);
  62 acc8= constant 13
  63 writeLineAcc8
  64 ;testOutputInput.j(35)   
  65 ;testOutputInput.j(36)     //constant + byte expression
  66 ;testOutputInput.j(37)     output(15, 4 + 2 * 5);
  67 acc8= constant 4
  68 <acc8= constant 2
  69 acc8* constant 5
  70 acc8+ unstack8
  71 output port 0x0F, value acc8
  72 ;testOutputInput.j(38)     println(16);
  73 acc8= constant 16
  74 writeLineAcc8
  75 ;testOutputInput.j(39)    
  76 ;testOutputInput.j(40)     //constant + byte variable
  77 ;testOutputInput.j(41)     value = 17;
  78 acc8= constant 17
  79 acc8=> variable 0
  80 ;testOutputInput.j(42)     output(0x12, value);
  81 output port 0x12, value variable 0
  82 ;testOutputInput.j(43)     println(19);
  83 acc8= constant 19
  84 writeLineAcc8
  85 ;testOutputInput.j(44)   
  86 ;testOutputInput.j(45)     //constant + final variable
  87 ;testOutputInput.j(46)     output(21, FINAL_VALUE);
  88 output port 0x15 value 0x14
  89 ;testOutputInput.j(47)     println(22);
  90 acc8= constant 22
  91 writeLineAcc8
  92 ;testOutputInput.j(48)     
  93 ;testOutputInput.j(49)     //TODO enable test on output() with port number as constant expression
  94 ;testOutputInput.j(50)     /*
  95 ;testOutputInput.j(51)     //byte constant expression + decimal constant
  96 ;testOutputInput.j(52)     output(4 * 5 + 4, 23);
  97 ;testOutputInput.j(53)     println(15);
  98 ;testOutputInput.j(54)     */
  99 ;testOutputInput.j(55)   
 100 ;testOutputInput.j(56)   /*
 101 ;testOutputInput.j(57)     //hexadecimal constant
 102 ;testOutputInput.j(58)     //IN0     A,(0x13)
 103 ;testOutputInput.j(59)     println("Enter 16");
 104 ;testOutputInput.j(60)     value = input(0x0F);
 105 ;testOutputInput.j(61)     println(value);
 106 ;testOutputInput.j(62)   
 107 ;testOutputInput.j(63)     //byte constant expression
 108 ;testOutputInput.j(64)     println("Enter 18");
 109 ;testOutputInput.j(65)     value = input(7 + 5 * 2);
 110 ;testOutputInput.j(66)     println(value);
 111 ;testOutputInput.j(67)   
 112 ;testOutputInput.j(68)     //final variable
 113 ;testOutputInput.j(69)     //IN0     A,(0x13)
 114 ;testOutputInput.j(70)     port = 0x11;
 115 ;testOutputInput.j(71)     println("Enter 20");
 116 ;testOutputInput.j(72)     value = input(port);
 117 ;testOutputInput.j(73)     println(value);
 118 ;testOutputInput.j(74)   */
 119 ;testOutputInput.j(75)   
 120 ;testOutputInput.j(76)     println("Klaar");
 121 acc16= stringconstant 130
 122 writeLineString
 123 ;testOutputInput.j(77)   }
 124 stackPointer= basePointer
 125 basePointer<
 126 return
 127 ;testOutputInput.j(78) }
 128 stringConstant 0 = "Enter 5"
 129 stringConstant 1 = "Enter 11"
 130 stringConstant 2 = "Klaar"
