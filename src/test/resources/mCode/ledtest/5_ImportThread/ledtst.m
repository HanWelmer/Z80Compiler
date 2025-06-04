   0 call 223
   1 stop
   2 ;ledtst.j(0) /* Z80S183 program that tests switching on/off the LED at the PWRSWTCH  output. */
   3 ;ledtst.j(1) /* Transcribed from LEDTest.asm to ledtest.j */
   4 ;ledtst.j(2) 
   5 ;ledtst.j(3) import Thread;
   6 import Thread
   7 ;Thread.j(0) 
   8 ;Thread.j(1) /* Z80S183 program that tests switching on/off the LED at the PWRSWTCH  output. */
   9 ;Thread.j(2) /* Transcribed from LEDTest.asm to ledtest.j */
  10 ;Thread.j(3) 
  11 ;Thread.j(4) class Thread {
  12 class Thread []
  13 ;Thread.j(5) 
  14 ;Thread.j(6)   /**
  15 ;Thread.j(7)    * Wait 1 msec at 18,432 MHz with no wait states.
  16 ;Thread.j(8)    * 
  17 ;Thread.j(9)    * Assumes that code can be run from internal RAM with 1 wait state.
  18 ;Thread.j(10)    * Assumes data can be read/written to internal RAM with 1 wait state.
  19 ;Thread.j(11)    * Assumes the Z80S183 is driven by an 18.432 MHz clock at the XTAL pin
  20 ;Thread.j(12)    * 
  21 ;Thread.j(13)    * With b=255 the routine requires 108 + b * 71 = 18213 T-states, 
  22 ;Thread.j(14)    * which is 219 T-states or 11,8 microseconds short of 1 millisecond.
  23 ;Thread.j(15)    * 
  24 ;Thread.j(16)    * Duplicating the for loop with a total of 257 for b and c 
  25 ;Thread.j(17)    * requires 132 + (b + c) * 71 = 18379 T-states,
  26 ;Thread.j(18)    * which is 53 T-states or 2,8 microseconds short of 1 millisecond.
  27 ;Thread.j(19)    */
  28 ;Thread.j(20)   private static void sleepOneMillisecond() {
  29 method Thread.sleepOneMillisecond [private, static] void ()
  30 <basePointer
  31 basePointer= stackPointer
  32 stackPointer+ constant 1
  33 ;Thread.j(21)     for (byte b = 255; b!=0; b--) ;
  34 acc8= constant 255
  35 acc8=> (basePointer + 1)
  36 acc8= (basePointer + 1)
  37 acc8Comp constant 0
  38 breq 44
  39 br 42
  40 decr8 (basePointer + 1)
  41 br 36
  42 br 40
  43 ;Thread.j(22)   }
  44 stackPointer= basePointer
  45 basePointer<
  46 return
  47 ;Thread.j(23) 
  48 ;Thread.j(24)   /**
  49 ;Thread.j(25)    * sleep for n miliseconds.
  50 ;Thread.j(26)    */
  51 ;Thread.j(27)   public static void sleep(word n) {
  52 method Thread.sleep [public, static] void (word n {bp-4})
  53 <basePointer
  54 basePointer= stackPointer
  55 stackPointer+ constant 0
  56 ;Thread.j(28)     while (n != 0) {
  57 acc16= (basePointer + -4)
  58 acc8= constant 0
  59 acc16CompareAcc8
  60 breq 68
  61 ;Thread.j(29)       sleepOneMillisecond();
  62 call 29
  63 ;Thread.j(30)       n--;
  64 decr16 (basePointer + -4)
  65 ;Thread.j(31)     }
  66 br 57
  67 ;Thread.j(32)   }
  68 stackPointer= basePointer
  69 basePointer<
  70 return
  71 ;Thread.j(33) 
  72 ;Thread.j(34) }
  73 ;ledtst.j(4) 
  74 ;ledtst.j(5) class LEDTest {
  75 class LEDTest []
  76 ;ledtst.j(6)   /*******************************
  77 ;ledtst.j(7)   To compile this class and generate Z80 asm, listing and hex files:
  78 ;ledtst.j(8)   - cd src\test\resources\jCode\ledtest\5_ImportThread
  79 ;ledtst.j(9)   - java -jar ..\..\..\..\..\..\target\z80Compiler-1.0-SNAPSHOT.jar -z -b ledtst.j
  80 ;ledtst.j(10)   Assumes that code can be run from internal RAM with 1 wait state.
  81 ;ledtst.j(11)   Assumes data can be read/written to internal RAM with 1 wait state.
  82 ;ledtst.j(12)   Assumes the Z80S183 is driven by an 18.432 MHz clock at the XTAL pin
  83 ;ledtst.j(13)   Assumes that an active-low LED is available at the PWRSWTCH pin:
  84 ;ledtst.j(14)    - connect anode of low-current (2 mA) LED to VCC
  85 ;ledtst.j(15)    - connect cathode of low-current LED to 1k8 resistor
  86 ;ledtst.j(16)    - connect other end of resistor to PWR_SW (pin 13 of J23).
  87 ;ledtst.j(17)   
  88 ;ledtst.j(18)   Connect Z80S183 evaluation board via DB9 (male-female) cable to RS232 of host computer.
  89 ;ledtst.j(19)   Start hyperterminal or TeraTerm:
  90 ;ledtst.j(20)    - Select serial communication using COM1
  91 ;ledtst.j(21)    - Set up | Serial port
  92 ;ledtst.j(22)      * COM1
  93 ;ledtst.j(23)      * 57600
  94 ;ledtst.j(24)      * 8N2
  95 ;ledtst.j(25)      * no flow control
  96 ;ledtst.j(26)    - connect 9V DC adapter to Z80S183 evaluation board.
  97 ;ledtst.j(27)    - Press RESET on Z80S183 evaluation board
  98 ;ledtst.j(28)      The text Zilog Z80183 Monitor Version 2.8 should appear.
  99 ;ledtst.j(29)   Upload Intel hex file ledtst.hex:
 100 ;ledtst.j(30)    -  type L
 101 ;ledtst.j(31)    -  File | Send file
 102 ;ledtst.j(32)       * Browse to file ledtst.hex and select OK
 103 ;ledtst.j(33)       * The text 10(10) records in Hex file should appear
 104 ;ledtst.j(34)   Check memory contents:
 105 ;ledtst.j(35)    -  D 2000 32
 106 ;ledtst.j(36)   Run program
 107 ;ledtst.j(37)    -  G 2000
 108 ;ledtst.j(38)    - The LED should blink at a rate of 1Hz.
 109 ;ledtst.j(39)   *******************************/
 110 ;ledtst.j(40) 
 111 ;ledtst.j(41)   // Definition of on-chip Z80S183 registers
 112 ;ledtst.j(42)   //                Name  Address  Description
 113 ;ledtst.j(43)   //                ====  =======  =========
 114 ;ledtst.j(44)   static final byte WDTCR = 0x65;  //Watchdog Timer Control Register
 115 ;ledtst.j(45)   static final byte SCR   = 0x7F;  //System Configuration Register P91
 116 ;ledtst.j(46)   static final byte CCR   = 0x1F;  //CPU Control Register P84
 117 ;ledtst.j(47)   static final byte DCNTL = 0x32;  //DMA/Wait Control Register P121
 118 ;ledtst.j(48)   static final byte WSGCR = 0x6B;  //Wait State Generator Control Register P96
 119 ;ledtst.j(49)   static final byte PCR   = 0x7E;  //Power Control Register
 120 ;ledtst.j(50) 
 121 ;ledtst.j(51)   //Device initialisation
 122 ;ledtst.j(52)   public static void init() {
 123 method LEDTest.init [public, static] void ()
 124 <basePointer
 125 basePointer= stackPointer
 126 stackPointer+ constant 0
 127 ;ledtst.j(53)     // Enable writing to system ctrl registers
 128 ;ledtst.j(54)     output(WDTCR, 0x00);
 129 output port 0x65 value 0x00
 130 ;ledtst.j(55)     // LD      A,00BH
 131 ;ledtst.j(56)     // OUT0    (WDTCR),A
 132 ;ledtst.j(57) 
 133 ;ledtst.j(58)     // System configuration Register P91
 134 ;ledtst.j(59)     // b7 = 0 on-chip ROM disabled
 135 ;ledtst.j(60)     // b6 = 1 on-chip RAM enabled
 136 ;ledtst.j(61)     // b5 = 0 on-chip RAM at xF800H-xFFFFH
 137 ;ledtst.j(62)     // b4 = 1 ROMCS enabled/disabled
 138 ;ledtst.j(63)     // b3 = 1 RAMCS enabled/disabled
 139 ;ledtst.j(64)     // b2 = 1 IOCS  enabled/disabled
 140 ;ledtst.j(65)     // b10=00 PHI = EXTAL clock
 141 ;ledtst.j(66)     output(SCR, 0x5C);
 142 output port 0x7F value 0x5C
 143 ;ledtst.j(67)     // LD      A,05CH
 144 ;ledtst.j(68)     // OUT0    (SCR),A
 145 ;ledtst.j(69)   
 146 ;ledtst.j(70)     // CPU Control Register P84
 147 ;ledtst.j(71)     // b7 = 1 PHI = XTAL / 1
 148 ;ledtst.j(72)     // b63=00 SLP instruction enters sleep mode
 149 ;ledtst.j(73)     // b5 = 0 BREQ in standby ignored
 150 ;ledtst.j(74)     // b4 = 0 PHI low noise disabled
 151 ;ledtst.j(75)     // b2 = x reserved
 152 ;ledtst.j(76)     // b1 = 0 IORD/IOWR low noise disabled
 153 ;ledtst.j(77)     // b0 = 0 A19-0/D7-0 low noise disabled
 154 ;ledtst.j(78)     output(CCR, 0x80);    
 155 output port 0x1F value 0x80
 156 ;ledtst.j(79)     // LD      A,080H
 157 ;ledtst.j(80)     // OUT0    (CCR),A
 158 ;ledtst.j(81) 
 159 ;ledtst.j(82)     
 160 ;ledtst.j(83)     // DMA/Wait Control Register P121
 161 ;ledtst.j(84)     // b76=00 0 wait state CPU memory cycle
 162 ;ledtst.j(85)     // b54=00 0 wait state CPU I/O cycle
 163 ;ledtst.j(86)     // b3 = 0 level detect on DMA1 Request
 164 ;ledtst.j(87)     // b2 = 0 level detect on DMA0 Request
 165 ;ledtst.j(88)     // b1 = 0 DMA from memory to I/O 
 166 ;ledtst.j(89)     // b0 = 0 DMA increasing memory address
 167 ;ledtst.j(90)     output(DCNTL, 0x00);
 168 output port 0x32 value 0x00
 169 ;ledtst.j(91)     // XOR      A
 170 ;ledtst.j(92)     // OUT0    (DCNTL),A
 171 ;ledtst.j(93) 
 172 ;ledtst.j(94)     // Wait State Generator Control Register P96
 173 ;ledtst.j(95)     // b76=00 0 wait states CSROM
 174 ;ledtst.j(96)     // b54=00 0 wait states CSRAM
 175 ;ledtst.j(97)     // b32=00 0 wait states other
 176 ;ledtst.j(98)     // b10=xx reserved
 177 ;ledtst.j(99)     output(WSGCR, 0x00);
 178 output port 0x6B value 0x00
 179 ;ledtst.j(100)     // OUT0    (WSGCR),A
 180 ;ledtst.j(101) 
 181 ;ledtst.j(102)     // Block writing to system ctrl registers
 182 ;ledtst.j(103)     output(WDTCR, 0x00);
 183 output port 0x65 value 0x00
 184 ;ledtst.j(104)     // XOR     A
 185 ;ledtst.j(105)     // OUT0    (WDTCR),A
 186 ;ledtst.j(106)   }
 187 stackPointer= basePointer
 188 basePointer<
 189 return
 190 ;ledtst.j(107) 
 191 ;ledtst.j(108)   public static void toggle() {
 192 method LEDTest.toggle [public, static] void ()
 193 <basePointer
 194 basePointer= stackPointer
 195 stackPointer+ constant 0
 196 ;ledtst.j(109)     // Enable writing to PCR
 197 ;ledtst.j(110)     output(WDTCR, 0x0B);
 198 output port 0x65 value 0x0B
 199 ;ledtst.j(111)     //LD      A,00BH
 200 ;ledtst.j(112)     //OUT0    (WDTCR),A
 201 ;ledtst.j(113) 
 202 ;ledtst.j(114)     // Toggle LED at PWR_SW
 203 ;ledtst.j(115)     output(PCR, input(PCR) ^ 0x20);
 204 input port 0x7E
 205 acc8Xor constant 32
 206 output port 0x7E value acc8
 207 ;ledtst.j(116)     //IN0     A,(PCR)
 208 ;ledtst.j(117)     //XOR     A,020H
 209 ;ledtst.j(118)     //OUT0    (PCR),A
 210 ;ledtst.j(119) 
 211 ;ledtst.j(120)     // Disable writing to PCR
 212 ;ledtst.j(121)     output(WDTCR, 0x00);
 213 output port 0x65 value 0x00
 214 ;ledtst.j(122)     //XOR     A,A
 215 ;ledtst.j(123)     //OUT0    (WDTCR),A
 216 ;ledtst.j(124)   }
 217 stackPointer= basePointer
 218 basePointer<
 219 return
 220 ;ledtst.j(125) 
 221 ;ledtst.j(126)   // Blink LED on/off in a XXxxXXxx pattern at 1 Hz.
 222 ;ledtst.j(127)   public static void main() {
 223 method LEDTest.main [public, static] void ()
 224 <basePointer
 225 basePointer= stackPointer
 226 stackPointer+ constant 0
 227 ;ledtst.j(128)     init();
 228 call 123
 229 ;ledtst.j(129)     while (1==1) {
 230 acc8= constant 1
 231 acc8Comp constant 1
 232 brne 243
 233 ;ledtst.j(130)       toggle();
 234 call 192
 235 ;ledtst.j(131)       Thread.sleep(500); // Sleep for 500 miliseconds.
 236 acc16= constant 500
 237 <acc16
 238 call 52
 239 stackPointer+ constant -2
 240 ;ledtst.j(132)     }
 241 br 230
 242 ;ledtst.j(133)   }
 243 stackPointer= basePointer
 244 basePointer<
 245 return
 246 ;ledtst.j(134) }
