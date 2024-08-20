   0 call 140
   1 stop
   2 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(0) /* Z80S183 program that tests switching on/off the LED at the PWRSWTCH  output. */
   3 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(1) /* Transcribed from LEDTest.asm to ledtest.j */
   4 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(2) class LEDTest {
   5 class LEDTest []
   6 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(3)   /*******************************
   7 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(4)   Assumes that code can be run from internal RAM with 1 wait state.
   8 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(5)   Assumes data can be read/written to internal RAM with 1 wait state.
   9 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(6)   Assumes the Z80S183 is driven by an 18.432 MHz clock at the XTAL pin
  10 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(7)   Assumes that an active-low LED is available at the PWRSWTCH pin:
  11 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(8)    - connect anode of low-current (2 mA) LED to VCC
  12 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(9)    - connect cathode of low-current LED to 1k8 resistor
  13 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(10)    - connect other end of resistor to PWR_SW (pin 13 of J23).
  14 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(11)   
  15 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(12)   Connect Z80S183 evaluation board via DB9 (male-female) cable to RS232 of host computer.
  16 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(13)   Start hyperterminal or TeraTerm:
  17 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(14)    - Select serial communication using COM1
  18 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(15)    - Set up | Serial port
  19 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(16)      * COM1
  20 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(17)      * 57600
  21 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(18)      * 8N2
  22 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(19)      * no flow control
  23 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(20)    - connect 9V DC adapter to Z80S183 evaluation board.
  24 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(21)    - Press RESET on Z80S183 evaluation board
  25 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(22)      The text Zilog Z80183 Monitor Version 2.8 should appear.
  26 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(23)   Upload Intel hex file ledtst.hex:
  27 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(24)    -  type L
  28 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(25)    -  File | Send file
  29 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(26)       * Browse to file ledtst.hex and select OK
  30 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(27)       * The text 10(10) records in Hex file should appear
  31 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(28)   Check memory contents:
  32 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(29)    -  D 2000 32
  33 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(30)   Run program
  34 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(31)    -  G 2000
  35 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(32)    - The LED should blink at a rate of 1Hz.
  36 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(33)   *******************************/
  37 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(34) 
  38 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(35)   // Definition of on-chip Z80S183 registers
  39 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(36)   //                Name  Address  Description
  40 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(37)   //                ====  =======  =========
  41 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(38)   static final byte WDTCR = 0x65;  //Watchdog Timer Control Register
  42 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(39)   static final byte SCR   = 0x7F;  //System Configuration Register P91
  43 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(40)   static final byte CCR   = 0x1F;  //CPU Control Register P84
  44 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(41)   static final byte DCNTL = 0x32;  //DMA/Wait Control Register P121
  45 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(42)   static final byte WSGCR = 0x6B;  //Wait State Generator Control Register P96
  46 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(43)   static final byte PCR   = 0x7E;  //Power Control Register
  47 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(44) 
  48 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(45)   //Device initialisation
  49 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(46)   public static void init() {
  50 method init [public, static] void
  51 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(47)     // Enable writing to system ctrl registers
  52 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(48)     output(WDTCR, 0x00);
  53 output port 0x65 value 0x00
  54 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(49)     // LD      A,00BH
  55 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(50)     // OUT0    (WDTCR),A
  56 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(51) 
  57 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(52)     // System configuration Register P91
  58 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(53)     // b7 = 0 on-chip ROM disabled
  59 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(54)     // b6 = 1 on-chip RAM enabled
  60 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(55)     // b5 = 0 on-chip RAM at xF800H-xFFFFH
  61 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(56)     // b4 = 1 ROMCS enabled/disabled
  62 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(57)     // b3 = 1 RAMCS enabled/disabled
  63 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(58)     // b2 = 1 IOCS  enabled/disabled
  64 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(59)     // b10=00 PHI = EXTAL clock
  65 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(60)     output(SCR, 0x5C);
  66 output port 0x7F value 0x5C
  67 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(61)     // LD      A,05CH
  68 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(62)     // OUT0    (SCR),A
  69 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(63)   
  70 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(64)     // CPU Control Register P84
  71 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(65)     // b7 = 1 PHI = XTAL / 1
  72 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(66)     // b63=00 SLP instruction enters sleep mode
  73 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(67)     // b5 = 0 BREQ in standby ignored
  74 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(68)     // b4 = 0 PHI low noise disabled
  75 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(69)     // b2 = x reserved
  76 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(70)     // b1 = 0 IORD/IOWR low noise disabled
  77 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(71)     // b0 = 0 A19-0/D7-0 low noise disabled
  78 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(72)     output(CCR, 0x80);    
  79 output port 0x1F value 0x80
  80 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(73)     // LD      A,080H
  81 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(74)     // OUT0    (CCR),A
  82 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(75) 
  83 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(76)     
  84 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(77)     // DMA/Wait Control Register P121
  85 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(78)     // b76=00 0 wait state CPU memory cycle
  86 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(79)     // b54=00 0 wait state CPU I/O cycle
  87 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(80)     // b3 = 0 level detect on DMA1 Request
  88 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(81)     // b2 = 0 level detect on DMA0 Request
  89 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(82)     // b1 = 0 DMA from memory to I/O 
  90 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(83)     // b0 = 0 DMA increasing memory address
  91 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(84)     output(DCNTL, 0x00);
  92 output port 0x32 value 0x00
  93 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(85)     // XOR      A
  94 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(86)     // OUT0    (DCNTL),A
  95 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(87) 
  96 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(88)     // Wait State Generator Control Register P96
  97 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(89)     // b76=00 0 wait states CSROM
  98 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(90)     // b54=00 0 wait states CSRAM
  99 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(91)     // b32=00 0 wait states other
 100 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(92)     // b10=xx reserved
 101 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(93)     output(WSGCR, 0x00);
 102 output port 0x6B value 0x00
 103 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(94)     // OUT0    (WSGCR),A
 104 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(95) 
 105 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(96)     // Block writing to system ctrl registers
 106 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(97)     output(WDTCR, 0x00);
 107 output port 0x65 value 0x00
 108 return
 109 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(98)     // XOR     A
 110 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(99)     // OUT0    (WDTCR),A
 111 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(100)   }
 112 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(101) 
 113 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(102)   public static void toggle() {
 114 method toggle [public, static] void
 115 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(103)     // Enable writing to PCR
 116 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(104)     output(WDTCR, 0x0B);
 117 output port 0x65 value 0x0B
 118 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(105)     //LD      A,00BH
 119 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(106)     //OUT0    (WDTCR),A
 120 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(107) 
 121 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(108)     // Toggle LED at PWR_SW
 122 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(109)     output(PCR, input(PCR) ^ 0x20);
 123 input port 0x7E
 124 acc8Xor constant 32
 125 output port 0x7E, value acc8
 126 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(110)     //IN0     A,(PCR)
 127 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(111)     //XOR     A,020H
 128 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(112)     //OUT0    (PCR),A
 129 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(113) 
 130 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(114)     // Disable writing to PCR
 131 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(115)     output(WDTCR, 0x00);
 132 output port 0x65 value 0x00
 133 return
 134 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(116)     //XOR     A,A
 135 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(117)     //OUT0    (WDTCR),A
 136 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(118)   }
 137 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(119) 
 138 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(120)   // Blink LED on/off in a XXxxXXxx pattern at 1 Hz.
 139 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(121)   public static void main() {
 140 method main [public, static] void
 141 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(122)     init();
 142 call 50
 143 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(123)     while (1==1) {
 144 acc8= constant 1
 145 acc8Comp constant 1
 146 brne 154
 147 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(124)       toggle();
 148 call 114
 149 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(125)       sleep(500);
 150 sleep 500
 151 br 144
 152 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(126)     }
 153 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(127)   }
 154 return
 155 ;..\src\test\resources\jCode\ledtest\parameterLessMethods\ledtst.j(128) }
