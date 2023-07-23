   0 ;ledtst.j(0) /* Z80S183 program that tests switching on/off the LED at the PWRSWTCH  output. */
   1 ;ledtst.j(1) /* Transcribed from LEDTest.asm to ledtest.j */
   2 ;ledtst.j(2) class LEDTest {
   3 ;ledtst.j(3)   /*******************************
   4 ;ledtst.j(4)   Assumes that code can be run from internal RAM with 1 wait state.
   5 ;ledtst.j(5)   Assumes data can be read/written to internal RAM with 1 wait state.
   6 ;ledtst.j(6)   Assumes the Z80S183 is driven by an 18.432 MHz clock at the XTAL pin
   7 ;ledtst.j(7)   Assumes that an active-low LED is available at the PWRSWTCH pin:
   8 ;ledtst.j(8)    - connect anode of low-current LED to VCC
   9 ;ledtst.j(9)    - connect cathode of low-currebt LED to 1k8 resistor
  10 ;ledtst.j(10)    - connect other end of resistor to PWR_SW (pin 13 of J23).
  11 ;ledtst.j(11)   
  12 ;ledtst.j(12)   Connect Z80S183 evaluation board via DB9 (male-female) cable to RS232 of host computer.
  13 ;ledtst.j(13)   Start hyperterminal or TeraTerm:
  14 ;ledtst.j(14)    - Select serial communication using COM1
  15 ;ledtst.j(15)    - Set up | Serial port
  16 ;ledtst.j(16)      * COM1
  17 ;ledtst.j(17)      * 57600
  18 ;ledtst.j(18)      * 8N2
  19 ;ledtst.j(19)      * no flow control
  20 ;ledtst.j(20)    - connect 9V DC adapter to Z80S183 evaluation board.
  21 ;ledtst.j(21)    - Press RESET on Z80S183 evaluation board
  22 ;ledtst.j(22)      The text Zilog Z80183 Monitor Version 2.8 should appear.
  23 ;ledtst.j(23)   Upload Intel hex file ledtst.hex:
  24 ;ledtst.j(24)    -  type L
  25 ;ledtst.j(25)    -  File | Send file
  26 ;ledtst.j(26)       * Browse to file ledtst.hex and select OK
  27 ;ledtst.j(27)       * The text 10(10) records in Hex file should appear
  28 ;ledtst.j(28)   Check memory contents:
  29 ;ledtst.j(29)    -  D f800 32
  30 ;ledtst.j(30)   Run program
  31 ;ledtst.j(31)    -  G f800
  32 ;ledtst.j(32)    - The LED should blink at a rate of 1Hz.
  33 ;ledtst.j(33)   
  34 ;ledtst.j(34)   The program switches on and off the LED at a rate of 1 Hz.
  35 ;ledtst.j(35)   *******************************/
  36 ;ledtst.j(36) 
  37 ;ledtst.j(37)   //Definition of on-chip Z80S183 registers
  38 ;ledtst.j(38)   //   Name  Address  Description
  39 ;ledtst.j(39)   //   ====  =======  =========
  40 ;ledtst.j(40)   final byte WDTCR = 0x65;  //Watchdog Timer Control Register
  41 ;ledtst.j(41)   final byte SCR   = 0x7F;  //System Configuration Register P91
  42 ;ledtst.j(42)   final byte CCR   = 0x1F;  //CPU Control Register P84
  43 ;ledtst.j(43)   final byte DCNTL = 0x32;  //DMA/Wait Control Register P121
  44 ;ledtst.j(44)   final byte WSGCR = 0x6B;  //Wait State Generator Control Register P96
  45 ;ledtst.j(45)   final byte PCR   = 0x7E;  //Power Control Register
  46 ;ledtst.j(46) 
  47 ;ledtst.j(47)   //Device initialisation
  48 ;ledtst.j(48)   output(WDTCR, 0x00);  //Enable writing to system ctrl registers
  49 output port 0x65 value 0x00
  50 ;ledtst.j(49)                         // LD      A,00BH
  51 ;ledtst.j(50)                         // OUT0    (WDTCR),A
  52 ;ledtst.j(51)   output(SCR, 0x5C);    //System configuration Register P91
  53 output port 0x7F value 0x5C
  54 ;ledtst.j(52)                         // LD      A,05CH
  55 ;ledtst.j(53)                         // OUT0    (SCR),A
  56 ;ledtst.j(54)                         // b7 = 0 on-chip ROM disabled
  57 ;ledtst.j(55)                         // b6 = 1 on-chip RAM enabled
  58 ;ledtst.j(56)                         // b5 = 0 on-chip RAM at xF800H-xFFFFH
  59 ;ledtst.j(57)                         // b4 = 1 ROMCS enabled/disabled
  60 ;ledtst.j(58)                         // b3 = 1 RAMCS enabled/disabled
  61 ;ledtst.j(59)                         // b2 = 1 IOCS  enabled/disabled
  62 ;ledtst.j(60)                         // b10=00 PHI = EXTAL clock
  63 ;ledtst.j(61) 
  64 ;ledtst.j(62)   output(CCR, 0x80);    //CPU Control Register P84
  65 output port 0x1F value 0x80
  66 ;ledtst.j(63)                         // LD      A,080H
  67 ;ledtst.j(64)                         // OUT0    (CCR),A
  68 ;ledtst.j(65)                         // b7 = 1 PHI = XTAL / 1
  69 ;ledtst.j(66)                         // b63=00 SLP instruction enters sleep mode
  70 ;ledtst.j(67)                         // b5 = 0 BREQ in standby ignored
  71 ;ledtst.j(68)                         // b4 = 0 PHI low noise disabled
  72 ;ledtst.j(69)                         // b2 = x reserved
  73 ;ledtst.j(70)                         // b1 = 0 IORD/IOWR low noise disabled
  74 ;ledtst.j(71)                         // b0 = 0 A19-0/D7-0 low noise disabled
  75 ;ledtst.j(72)   output(DCNTL, 0x00);  //DMA/Wait Control Register P121
  76 output port 0x32 value 0x00
  77 ;ledtst.j(73)                         // XOR      A
  78 ;ledtst.j(74)                         // OUT0    (DCNTL),A
  79 ;ledtst.j(75)                         // b76=00 0 wait state CPU memory cycle
  80 ;ledtst.j(76)                         // b54=00 0 wait state CPU I/O cycle
  81 ;ledtst.j(77)                         // b3 = 0 level detect on DMA1 Request
  82 ;ledtst.j(78)                         // b2 = 0 level detect on DMA0 Request
  83 ;ledtst.j(79)                         // b1 = 0 DMA from memory to I/O 
  84 ;ledtst.j(80)                         // b0 = 0 DMA increasing memory address
  85 ;ledtst.j(81)   output(WSGCR, 0x00);  //Wait State Generator Control Register P96
  86 output port 0x6B value 0x00
  87 ;ledtst.j(82)                         // OUT0    (WSGCR),A
  88 ;ledtst.j(83)                         // b76=00 0 wait states CSROM
  89 ;ledtst.j(84)                         // b54=00 0 wait states CSRAM
  90 ;ledtst.j(85)                         // b32=00 0 wait states other
  91 ;ledtst.j(86)                         // b10=xx reserved
  92 ;ledtst.j(87)   output(WDTCR, 0x00);  //Block writing to system ctrl registers
  93 output port 0x65 value 0x00
  94 ;ledtst.j(88)                         // XOR     A
  95 ;ledtst.j(89)                         // OUT0    (WDTCR),A
  96 ;ledtst.j(90) 
  97 ;ledtst.j(91)   //Einde device initialisatie
  98 ;ledtst.j(92) 
  99 ;ledtst.j(93) 
 100 ;ledtst.j(94)   //Blink LED on/off in a XXxxXXxx rythm
 101 ;ledtst.j(95)   //LedOK:      LD      DE,500
 102 ;ledtst.j(96)   //LedOK2:     CALL    TOGGLE
 103 ;ledtst.j(97)   //            CALL    WAIT
 104 ;ledtst.j(98)   //            JR      LedOK2
 105 ;ledtst.j(99)   while (1==1) {
 106 acc8= constant 1
 107 acc8Comp constant 1
 108 brne 162
 109 ;ledtst.j(100)     output(WDTCR, 0x0B);  //enable writing to PCR
 110 output port 0x65 value 0x0B
 111 ;ledtst.j(101)                           //LD      A,00BH      ;enable writing to PCR
 112 ;ledtst.j(102)                           //OUT0    (WDTCR),A
 113 ;ledtst.j(103)                           //;toggle LED at PWR_SW
 114 ;ledtst.j(104)     output(PCR, input(PCR) ^ 0x20);
 115 input port 0x7E
 116 acc8Xor constant 32
 117 output port 0x7E, value acc8
 118 ;ledtst.j(105)                           //IN0     A,(PCR)     ;toggle LED at PWR_SW
 119 ;ledtst.j(106)                           //XOR     A,020H
 120 ;ledtst.j(107)                           //OUT0    (PCR),A
 121 ;ledtst.j(108)     //byte t = input(PCR);//IN0     A,(PCR)     ;toggle LED at PWR_SW
 122 ;ledtst.j(109)     //t = t ^ 0x20;       //XOR     A,020H
 123 ;ledtst.j(110)     //output(PCR, t);     //OUT0    (PCR),A
 124 ;ledtst.j(111)     output(WDTCR, 0x00);  //disable writing to PCR
 125 output port 0x65 value 0x00
 126 ;ledtst.j(112)                           //XOR     A,A         ;disable writing to PCR
 127 ;ledtst.j(113)                           //OUT0    (WDTCR),A
 128 ;ledtst.j(114)     sleep(500);           //wait 500 msec
 129 sleep 500
 130 ;ledtst.j(115)   }
 131 br 106
 132 ;ledtst.j(116) 
 133 ;ledtst.j(117) /*
 134 ;ledtst.j(118) ;Blink LED on/off in a XxXxxxxx rythm
 135 ;ledtst.j(119) LedErr:     CALL    TOGGLE
 136 ;ledtst.j(120)             LD      DE,170
 137 ;ledtst.j(121)             CALL    WAIT
 138 ;ledtst.j(122)             CALL    TOGGLE
 139 ;ledtst.j(123)             CALL    WAIT
 140 ;ledtst.j(124)             CALL    TOGGLE
 141 ;ledtst.j(125)             CALL    WAIT
 142 ;ledtst.j(126)             CALL    TOGGLE
 143 ;ledtst.j(127)             LD      DE,500
 144 ;ledtst.j(128)             CALL    WAIT
 145 ;ledtst.j(129)             JR      LedErr
 146 ;ledtst.j(130) ;TOGGLE
 147 ;ledtst.j(131) ;Switches off/on the LED connected to the PWRSWTCH output.
 148 ;ledtst.j(132) ;LED is connected to VCC, so the output must be driven low
 149 ;ledtst.j(133) ;in order to switch on the LED.
 150 ;ledtst.j(134) TOGGLE:     PUSH    AF
 151 ;ledtst.j(135)             LD      A,00BH      ;enable writing to PCR
 152 ;ledtst.j(136)             OUT0    (WDTCR),A
 153 ;ledtst.j(137)             IN0     A,(PCR)     ;toggle LED at PWR_SW
 154 ;ledtst.j(138)             XOR     A,020H
 155 ;ledtst.j(139)             OUT0    (PCR),A
 156 ;ledtst.j(140)             XOR     A,A         ;disable writing to PCR
 157 ;ledtst.j(141)             OUT0    (WDTCR),A
 158 ;ledtst.j(142)             POP     AF
 159 ;ledtst.j(143)             RET
 160 ;ledtst.j(144)   */
 161 ;ledtst.j(145) }
 162 stop
