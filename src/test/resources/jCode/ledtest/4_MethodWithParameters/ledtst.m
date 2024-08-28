   0 call 207
   1 stop
   2 ;ledtst.j(0) /* Z80S183 program that tests switching on/off the LED at the PWRSWTCH  output. */
   3 ;ledtst.j(1) /* Transcribed from LEDTest.asm to ledtest.j */
   4 ;ledtst.j(2) class LEDTest {
   5 class LEDTest []
   6 ;ledtst.j(3)   /*******************************
   7 ;ledtst.j(4)   To compile this class and generate Z80 asm, listing and hex files:
   8 ;ledtst.j(5)   - cd src\test\resources\jCode\ledtest\localVariableNoParameter
   9 ;ledtst.j(6)   - java -jar ..\..\..\..\..\..\target\z80Compiler-1.0-SNAPSHOT.jar -z -b ledtst.j
  10 ;ledtst.j(7)   Assumes that code can be run from internal RAM with 1 wait state.
  11 ;ledtst.j(8)   Assumes data can be read/written to internal RAM with 1 wait state.
  12 ;ledtst.j(9)   Assumes the Z80S183 is driven by an 18.432 MHz clock at the XTAL pin
  13 ;ledtst.j(10)   Assumes that an active-low LED is available at the PWRSWTCH pin:
  14 ;ledtst.j(11)    - connect anode of low-current (2 mA) LED to VCC
  15 ;ledtst.j(12)    - connect cathode of low-current LED to 1k8 resistor
  16 ;ledtst.j(13)    - connect other end of resistor to PWR_SW (pin 13 of J23).
  17 ;ledtst.j(14)   
  18 ;ledtst.j(15)   Connect Z80S183 evaluation board via DB9 (male-female) cable to RS232 of host computer.
  19 ;ledtst.j(16)   Start hyperterminal or TeraTerm:
  20 ;ledtst.j(17)    - Select serial communication using COM1
  21 ;ledtst.j(18)    - Set up | Serial port
  22 ;ledtst.j(19)      * COM1
  23 ;ledtst.j(20)      * 57600
  24 ;ledtst.j(21)      * 8N2
  25 ;ledtst.j(22)      * no flow control
  26 ;ledtst.j(23)    - connect 9V DC adapter to Z80S183 evaluation board.
  27 ;ledtst.j(24)    - Press RESET on Z80S183 evaluation board
  28 ;ledtst.j(25)      The text Zilog Z80183 Monitor Version 2.8 should appear.
  29 ;ledtst.j(26)   Upload Intel hex file ledtst.hex:
  30 ;ledtst.j(27)    -  type L
  31 ;ledtst.j(28)    -  File | Send file
  32 ;ledtst.j(29)       * Browse to file ledtst.hex and select OK
  33 ;ledtst.j(30)       * The text 10(10) records in Hex file should appear
  34 ;ledtst.j(31)   Check memory contents:
  35 ;ledtst.j(32)    -  D 2000 32
  36 ;ledtst.j(33)   Run program
  37 ;ledtst.j(34)    -  G 2000
  38 ;ledtst.j(35)    - The LED should blink at a rate of 1Hz.
  39 ;ledtst.j(36)   *******************************/
  40 ;ledtst.j(37) 
  41 ;ledtst.j(38)   // Definition of on-chip Z80S183 registers
  42 ;ledtst.j(39)   //                Name  Address  Description
  43 ;ledtst.j(40)   //                ====  =======  =========
  44 ;ledtst.j(41)   static final byte WDTCR = 0x65;  //Watchdog Timer Control Register
  45 ;ledtst.j(42)   static final byte SCR   = 0x7F;  //System Configuration Register P91
  46 ;ledtst.j(43)   static final byte CCR   = 0x1F;  //CPU Control Register P84
  47 ;ledtst.j(44)   static final byte DCNTL = 0x32;  //DMA/Wait Control Register P121
  48 ;ledtst.j(45)   static final byte WSGCR = 0x6B;  //Wait State Generator Control Register P96
  49 ;ledtst.j(46)   static final byte PCR   = 0x7E;  //Power Control Register
  50 ;ledtst.j(47) 
  51 ;ledtst.j(48)   //Device initialisation
  52 ;ledtst.j(49)   public static void init() {
  53 method LEDTest.init [public, static] void ()
  54 <basePointer
  55 basePointer= stackPointer
  56 stackPointer+ constant 0
  57 ;ledtst.j(50)     // Enable writing to system ctrl registers
  58 ;ledtst.j(51)     output(WDTCR, 0x00);
  59 output port 0x65 value 0x00
  60 ;ledtst.j(52)     // LD      A,00BH
  61 ;ledtst.j(53)     // OUT0    (WDTCR),A
  62 ;ledtst.j(54) 
  63 ;ledtst.j(55)     // System configuration Register P91
  64 ;ledtst.j(56)     // b7 = 0 on-chip ROM disabled
  65 ;ledtst.j(57)     // b6 = 1 on-chip RAM enabled
  66 ;ledtst.j(58)     // b5 = 0 on-chip RAM at xF800H-xFFFFH
  67 ;ledtst.j(59)     // b4 = 1 ROMCS enabled/disabled
  68 ;ledtst.j(60)     // b3 = 1 RAMCS enabled/disabled
  69 ;ledtst.j(61)     // b2 = 1 IOCS  enabled/disabled
  70 ;ledtst.j(62)     // b10=00 PHI = EXTAL clock
  71 ;ledtst.j(63)     output(SCR, 0x5C);
  72 output port 0x7F value 0x5C
  73 ;ledtst.j(64)     // LD      A,05CH
  74 ;ledtst.j(65)     // OUT0    (SCR),A
  75 ;ledtst.j(66)   
  76 ;ledtst.j(67)     // CPU Control Register P84
  77 ;ledtst.j(68)     // b7 = 1 PHI = XTAL / 1
  78 ;ledtst.j(69)     // b63=00 SLP instruction enters sleep mode
  79 ;ledtst.j(70)     // b5 = 0 BREQ in standby ignored
  80 ;ledtst.j(71)     // b4 = 0 PHI low noise disabled
  81 ;ledtst.j(72)     // b2 = x reserved
  82 ;ledtst.j(73)     // b1 = 0 IORD/IOWR low noise disabled
  83 ;ledtst.j(74)     // b0 = 0 A19-0/D7-0 low noise disabled
  84 ;ledtst.j(75)     output(CCR, 0x80);    
  85 output port 0x1F value 0x80
  86 ;ledtst.j(76)     // LD      A,080H
  87 ;ledtst.j(77)     // OUT0    (CCR),A
  88 ;ledtst.j(78) 
  89 ;ledtst.j(79)     
  90 ;ledtst.j(80)     // DMA/Wait Control Register P121
  91 ;ledtst.j(81)     // b76=00 0 wait state CPU memory cycle
  92 ;ledtst.j(82)     // b54=00 0 wait state CPU I/O cycle
  93 ;ledtst.j(83)     // b3 = 0 level detect on DMA1 Request
  94 ;ledtst.j(84)     // b2 = 0 level detect on DMA0 Request
  95 ;ledtst.j(85)     // b1 = 0 DMA from memory to I/O 
  96 ;ledtst.j(86)     // b0 = 0 DMA increasing memory address
  97 ;ledtst.j(87)     output(DCNTL, 0x00);
  98 output port 0x32 value 0x00
  99 ;ledtst.j(88)     // XOR      A
 100 ;ledtst.j(89)     // OUT0    (DCNTL),A
 101 ;ledtst.j(90) 
 102 ;ledtst.j(91)     // Wait State Generator Control Register P96
 103 ;ledtst.j(92)     // b76=00 0 wait states CSROM
 104 ;ledtst.j(93)     // b54=00 0 wait states CSRAM
 105 ;ledtst.j(94)     // b32=00 0 wait states other
 106 ;ledtst.j(95)     // b10=xx reserved
 107 ;ledtst.j(96)     output(WSGCR, 0x00);
 108 output port 0x6B value 0x00
 109 ;ledtst.j(97)     // OUT0    (WSGCR),A
 110 ;ledtst.j(98) 
 111 ;ledtst.j(99)     // Block writing to system ctrl registers
 112 ;ledtst.j(100)     output(WDTCR, 0x00);
 113 output port 0x65 value 0x00
 114 ;ledtst.j(101)     // XOR     A
 115 ;ledtst.j(102)     // OUT0    (WDTCR),A
 116 ;ledtst.j(103)   }
 117 stackPointer= basePointer
 118 basePointer<
 119 return
 120 ;ledtst.j(104) 
 121 ;ledtst.j(105)   public static void toggle() {
 122 method LEDTest.toggle [public, static] void ()
 123 <basePointer
 124 basePointer= stackPointer
 125 stackPointer+ constant 0
 126 ;ledtst.j(106)     // Enable writing to PCR
 127 ;ledtst.j(107)     output(WDTCR, 0x0B);
 128 output port 0x65 value 0x0B
 129 ;ledtst.j(108)     //LD      A,00BH
 130 ;ledtst.j(109)     //OUT0    (WDTCR),A
 131 ;ledtst.j(110) 
 132 ;ledtst.j(111)     // Toggle LED at PWR_SW
 133 ;ledtst.j(112)     output(PCR, input(PCR) ^ 0x20);
 134 input port 0x7E
 135 acc8Xor constant 32
 136 output port 0x7E value acc8
 137 ;ledtst.j(113)     //IN0     A,(PCR)
 138 ;ledtst.j(114)     //XOR     A,020H
 139 ;ledtst.j(115)     //OUT0    (PCR),A
 140 ;ledtst.j(116) 
 141 ;ledtst.j(117)     // Disable writing to PCR
 142 ;ledtst.j(118)     output(WDTCR, 0x00);
 143 output port 0x65 value 0x00
 144 ;ledtst.j(119)     //XOR     A,A
 145 ;ledtst.j(120)     //OUT0    (WDTCR),A
 146 ;ledtst.j(121)   }
 147 stackPointer= basePointer
 148 basePointer<
 149 return
 150 ;ledtst.j(122) 
 151 ;ledtst.j(123)   /**
 152 ;ledtst.j(124)    * Wait 1 msec at 18,432 MHz with no wait states.
 153 ;ledtst.j(125)    * 
 154 ;ledtst.j(126)    * With n=255 the routine requires 108 + n * 71 = 18213 T-states, 
 155 ;ledtst.j(127)    * which is 219 T-states or 11,8 microseconds short of 1 millisecond.
 156 ;ledtst.j(128)    * 
 157 ;ledtst.j(129)    * Duplicating the for loop with a total of 257 for n and m 
 158 ;ledtst.j(130)    * requires 132 + (n + m) * 71 = 18379 T-states,
 159 ;ledtst.j(131)    * which is 53 T-states or 2,8 microseconds short of 1 millisecond.
 160 ;ledtst.j(132)    */
 161 ;ledtst.j(133)   public static void sleepOneMillisecond() {
 162 method LEDTest.sleepOneMillisecond [public, static] void ()
 163 <basePointer
 164 basePointer= stackPointer
 165 stackPointer+ constant 1
 166 ;ledtst.j(134)     for (byte b = 255; b!=0; b--) ;
 167 acc8= constant 255
 168 acc8=> (basePointer + -1)
 169 acc8= (basePointer + -1)
 170 acc8Comp constant 0
 171 breq 177
 172 br 175
 173 decr8 (basePointer + -1)
 174 br 169
 175 br 173
 176 ;ledtst.j(135)   }
 177 stackPointer= basePointer
 178 basePointer<
 179 return
 180 ;ledtst.j(136) 
 181 ;ledtst.j(137)   /**
 182 ;ledtst.j(138)    * sleep for n miliseconds.
 183 ;ledtst.j(139)    */
 184 ;ledtst.j(140)   public static void sleep(word n) {
 185 method LEDTest.sleep [public, static] void (word n {bp+4})
 186 <basePointer
 187 basePointer= stackPointer
 188 stackPointer+ constant 0
 189 ;ledtst.j(141)     while (n != 0) {
 190 acc16= (basePointer + 4)
 191 acc8= constant 0
 192 acc16CompareAcc8
 193 breq 201
 194 ;ledtst.j(142)       sleepOneMillisecond();
 195 call 162
 196 ;ledtst.j(143)       n--;
 197 decr16 (basePointer + 4)
 198 ;ledtst.j(144)     }
 199 br 190
 200 ;ledtst.j(145)   }
 201 stackPointer= basePointer
 202 basePointer<
 203 return
 204 ;ledtst.j(146) 
 205 ;ledtst.j(147)   // Blink LED on/off in a XXxxXXxx pattern at 1 Hz.
 206 ;ledtst.j(148)   public static void main() {
 207 method LEDTest.main [public, static] void ()
 208 <basePointer
 209 basePointer= stackPointer
 210 stackPointer+ constant 0
 211 ;ledtst.j(149)     init();
 212 call 53
 213 ;ledtst.j(150)     while (1==1) {
 214 acc8= constant 1
 215 acc8Comp constant 1
 216 brne 228
 217 ;ledtst.j(151)       toggle();
 218 call 122
 219 ;ledtst.j(152)       //Thread.sleep(500); // Sleep for 500 miliseconds.
 220 ;ledtst.j(153)       sleep(500); // Sleep for 500 miliseconds.
 221 acc16= constant 500
 222 <acc16
 223 call 185
 224 stackPointer+ constant -2
 225 ;ledtst.j(154)     }
 226 br 214
 227 ;ledtst.j(155)   }
 228 stackPointer= basePointer
 229 basePointer<
 230 return
 231 ;ledtst.j(156) }
