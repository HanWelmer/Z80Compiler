   0 call 51
   1 stop
   2 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(0) /* Z80S183 program that tests switching on/off the LED at the PWRSWTCH  output. */
   3 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(1) /* Transcribed from LEDTest.asm to ledtest.j */
   4 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(2) class LEDTest {
   5 class LEDTest []
   6 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(3)   /*******************************
   7 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(4)   Assumes that code can be run from internal RAM with 1 wait state.
   8 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(5)   Assumes data can be read/written to internal RAM with 1 wait state.
   9 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(6)   Assumes the Z80S183 is driven by an 18.432 MHz clock at the XTAL pin
  10 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(7)   Assumes that an active-low LED is available at the PWRSWTCH pin:
  11 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(8)    - connect anode of low-current LED to VCC
  12 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(9)    - connect cathode of low-currebt LED to 1k8 resistor
  13 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(10)    - connect other end of resistor to PWR_SW (pin 13 of J23).
  14 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(11)   
  15 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(12)   Connect Z80S183 evaluation board via DB9 (male-female) cable to RS232 of host computer.
  16 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(13)   Start hyperterminal or TeraTerm:
  17 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(14)    - Select serial communication using COM1
  18 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(15)    - Set up | Serial port
  19 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(16)      * COM1
  20 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(17)      * 57600
  21 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(18)      * 8N2
  22 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(19)      * no flow control
  23 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(20)    - connect 9V DC adapter to Z80S183 evaluation board.
  24 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(21)    - Press RESET on Z80S183 evaluation board
  25 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(22)      The text Zilog Z80183 Monitor Version 2.8 should appear.
  26 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(23)   Upload Intel hex file ledtst.hex:
  27 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(24)    -  type L
  28 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(25)    -  File | Send file
  29 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(26)       * Browse to file ledtst.hex and select OK
  30 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(27)       * The text 10(10) records in Hex file should appear
  31 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(28)   Check memory contents:
  32 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(29)    -  D f800 32
  33 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(30)   Run program
  34 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(31)    -  G f800
  35 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(32)    - The LED should blink at a rate of 1Hz.
  36 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(33)   
  37 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(34)   The program switches on and off the LED at a rate of 1 Hz.
  38 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(35)   *******************************/
  39 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(36) 
  40 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(37)   //Definition of on-chip Z80S183 registers
  41 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(38)   //   Name  Address  Description
  42 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(39)   //   ====  =======  =========
  43 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(40)   static final byte WDTCR = 0x65;  //Watchdog Timer Control Register
  44 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(41)   static final byte SCR   = 0x7F;  //System Configuration Register P91
  45 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(42)   static final byte CCR   = 0x1F;  //CPU Control Register P84
  46 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(43)   static final byte DCNTL = 0x32;  //DMA/Wait Control Register P121
  47 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(44)   static final byte WSGCR = 0x6B;  //Wait State Generator Control Register P96
  48 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(45)   static final byte PCR   = 0x7E;  //Power Control Register
  49 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(46) 
  50 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(47)   public static void main() {
  51 method main [public, static] void
  52 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(48)     //Device initialisation
  53 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(49)     output(WDTCR, 0x00);  //Enable writing to system ctrl registers
  54 output port 0x65 value 0x00
  55 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(50)                           // LD      A,00BH
  56 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(51)                           // OUT0    (WDTCR),A
  57 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(52)     output(SCR, 0x5C);    //System configuration Register P91
  58 output port 0x7F value 0x5C
  59 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(53)                           // LD      A,05CH
  60 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(54)                           // OUT0    (SCR),A
  61 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(55)                           // b7 = 0 on-chip ROM disabled
  62 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(56)                           // b6 = 1 on-chip RAM enabled
  63 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(57)                           // b5 = 0 on-chip RAM at xF800H-xFFFFH
  64 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(58)                           // b4 = 1 ROMCS enabled/disabled
  65 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(59)                           // b3 = 1 RAMCS enabled/disabled
  66 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(60)                           // b2 = 1 IOCS  enabled/disabled
  67 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(61)                           // b10=00 PHI = EXTAL clock
  68 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(62)   
  69 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(63)     output(CCR, 0x80);    //CPU Control Register P84
  70 output port 0x1F value 0x80
  71 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(64)                           // LD      A,080H
  72 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(65)                           // OUT0    (CCR),A
  73 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(66)                           // b7 = 1 PHI = XTAL / 1
  74 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(67)                           // b63=00 SLP instruction enters sleep mode
  75 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(68)                           // b5 = 0 BREQ in standby ignored
  76 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(69)                           // b4 = 0 PHI low noise disabled
  77 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(70)                           // b2 = x reserved
  78 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(71)                           // b1 = 0 IORD/IOWR low noise disabled
  79 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(72)                           // b0 = 0 A19-0/D7-0 low noise disabled
  80 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(73)     output(DCNTL, 0x00);  //DMA/Wait Control Register P121
  81 output port 0x32 value 0x00
  82 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(74)                           // XOR      A
  83 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(75)                           // OUT0    (DCNTL),A
  84 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(76)                           // b76=00 0 wait state CPU memory cycle
  85 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(77)                           // b54=00 0 wait state CPU I/O cycle
  86 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(78)                           // b3 = 0 level detect on DMA1 Request
  87 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(79)                           // b2 = 0 level detect on DMA0 Request
  88 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(80)                           // b1 = 0 DMA from memory to I/O 
  89 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(81)                           // b0 = 0 DMA increasing memory address
  90 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(82)     output(WSGCR, 0x00);  //Wait State Generator Control Register P96
  91 output port 0x6B value 0x00
  92 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(83)                           // OUT0    (WSGCR),A
  93 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(84)                           // b76=00 0 wait states CSROM
  94 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(85)                           // b54=00 0 wait states CSRAM
  95 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(86)                           // b32=00 0 wait states other
  96 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(87)                           // b10=xx reserved
  97 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(88)     output(WDTCR, 0x00);  //Block writing to system ctrl registers
  98 output port 0x65 value 0x00
  99 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(89)                           // XOR     A
 100 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(90)                           // OUT0    (WDTCR),A
 101 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(91)   
 102 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(92)     //Einde device initialisatie
 103 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(93)   
 104 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(94)   
 105 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(95)     //Blink LED on/off in a XXxxXXxx rythm
 106 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(96)     //LedOK:      LD      DE,500
 107 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(97)     //LedOK2:     CALL    TOGGLE
 108 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(98)     //            CALL    WAIT
 109 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(99)     //            JR      LedOK2
 110 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(100)     while (1==1) {
 111 acc8= constant 1
 112 acc8Comp constant 1
 113 brne 167
 114 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(101)       output(WDTCR, 0x0B);  //enable writing to PCR
 115 output port 0x65 value 0x0B
 116 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(102)                             //LD      A,00BH      ;enable writing to PCR
 117 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(103)                             //OUT0    (WDTCR),A
 118 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(104)                             //;toggle LED at PWR_SW
 119 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(105)       output(PCR, input(PCR) ^ 0x20);
 120 input port 0x7E
 121 acc8Xor constant 32
 122 output port 0x7E, value acc8
 123 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(106)                             //IN0     A,(PCR)     ;toggle LED at PWR_SW
 124 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(107)                             //XOR     A,020H
 125 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(108)                             //OUT0    (PCR),A
 126 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(109)       //byte t = input(PCR);//IN0     A,(PCR)     ;toggle LED at PWR_SW
 127 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(110)       //t = t ^ 0x20;       //XOR     A,020H
 128 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(111)       //output(PCR, t);     //OUT0    (PCR),A
 129 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(112)       output(WDTCR, 0x00);  //disable writing to PCR
 130 output port 0x65 value 0x00
 131 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(113)                             //XOR     A,A         ;disable writing to PCR
 132 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(114)                             //OUT0    (WDTCR),A
 133 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(115)       sleep(500);           //wait 500 msec
 134 sleep 500
 135 br 111
 136 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(116)     }
 137 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(117)   
 138 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(118)   /*
 139 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(119)   ;Blink LED on/off in a XxXxxxxx rythm
 140 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(120)   LedErr:     CALL    TOGGLE
 141 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(121)               LD      DE,170
 142 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(122)               CALL    WAIT
 143 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(123)               CALL    TOGGLE
 144 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(124)               CALL    WAIT
 145 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(125)               CALL    TOGGLE
 146 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(126)               CALL    WAIT
 147 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(127)               CALL    TOGGLE
 148 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(128)               LD      DE,500
 149 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(129)               CALL    WAIT
 150 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(130)               JR      LedErr
 151 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(131)   ;TOGGLE
 152 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(132)   ;Switches off/on the LED connected to the PWRSWTCH output.
 153 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(133)   ;LED is connected to VCC, so the output must be driven low
 154 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(134)   ;in order to switch on the LED.
 155 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(135)   TOGGLE:     PUSH    AF
 156 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(136)               LD      A,00BH      ;enable writing to PCR
 157 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(137)               OUT0    (WDTCR),A
 158 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(138)               IN0     A,(PCR)     ;toggle LED at PWR_SW
 159 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(139)               XOR     A,020H
 160 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(140)               OUT0    (PCR),A
 161 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(141)               XOR     A,A         ;disable writing to PCR
 162 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(142)               OUT0    (WDTCR),A
 163 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(143)               POP     AF
 164 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(144)               RET
 165 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(145)     */
 166 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(146)   }
 167 return
 168 ;..\src\test\resources\jCode\ledtest\oneClass\ledtst.j(147) }
