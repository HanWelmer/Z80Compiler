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
  40 ;ledtst.j(40)   byte WDTCR = 0x65;  //Watchdog Timer Control Register
  41 acc8= constant 101
  42 acc8=> variable 0
  43 ;ledtst.j(41)   byte SCR   = 0x7F;  //System Configuration Register P91
  44 acc8= constant 127
  45 acc8=> variable 1
  46 ;ledtst.j(42)   byte CCR   = 0x1F;  //CPU Control Register P84
  47 acc8= constant 31
  48 acc8=> variable 2
  49 ;ledtst.j(43)   byte DCNTL = 0x32;  //DMA/Wait Control Register P121
  50 acc8= constant 50
  51 acc8=> variable 3
  52 ;ledtst.j(44)   byte WSGCR = 0x6B;  //Wait State Generator Control Register P96
  53 acc8= constant 107
  54 acc8=> variable 4
  55 ;ledtst.j(45)   byte PCR   = 0x7E;  //Power Control Register
  56 acc8= constant 126
  57 acc8=> variable 5
  58 ;ledtst.j(46) 
  59 ;ledtst.j(47)   //Device initialisation
  60 ;ledtst.j(48)   output(0x65, 0x00);  //Enable writing to system ctrl registers
  61 output port 0x65 value 0x00
  62 ;ledtst.j(49)                         // LD      A,00BH
  63 ;ledtst.j(50)                         // OUT0    (WDTCR),A
  64 ;ledtst.j(51) /*
  65 ;ledtst.j(52)   output(WDTCR, 0x00);  //Enable writing to system ctrl registers
  66 ;ledtst.j(53)                         // LD      A,00BH
  67 ;ledtst.j(54)                         // OUT0    (WDTCR),A
  68 ;ledtst.j(55)   output(SCR, 0x5C);    //System configuration Register P91
  69 ;ledtst.j(56)                         // LD      A,05CH
  70 ;ledtst.j(57)                         // OUT0    (SCR),A
  71 ;ledtst.j(58)                         // b7 = 0 on-chip ROM disabled
  72 ;ledtst.j(59)                         // b6 = 1 on-chip RAM enabled
  73 ;ledtst.j(60)                         // b5 = 0 on-chip RAM at xF800H-xFFFFH
  74 ;ledtst.j(61)                         // b4 = 1 ROMCS enabled/disabled
  75 ;ledtst.j(62)                         // b3 = 1 RAMCS enabled/disabled
  76 ;ledtst.j(63)                         // b2 = 1 IOCS  enabled/disabled
  77 ;ledtst.j(64)                         // b10=00 PHI = EXTAL clock
  78 ;ledtst.j(65) 
  79 ;ledtst.j(66)   output(CCR, 0x80);    //CPU Control Register P84
  80 ;ledtst.j(67)                         // LD      A,080H
  81 ;ledtst.j(68)                         // OUT0    (CCR),A
  82 ;ledtst.j(69)                         // b7 = 1 PHI = XTAL / 1
  83 ;ledtst.j(70)                         // b63=00 SLP instruction enters sleep mode
  84 ;ledtst.j(71)                         // b5 = 0 BREQ in standby ignored
  85 ;ledtst.j(72)                         // b4 = 0 PHI low noise disabled
  86 ;ledtst.j(73)                         // b2 = x reserved
  87 ;ledtst.j(74)                         // b1 = 0 IORD/IOWR low noise disabled
  88 ;ledtst.j(75)                         // b0 = 0 A19-0/D7-0 low noise disabled
  89 ;ledtst.j(76)   output(DCNTL, 0x00);  //DMA/Wait Control Register P121
  90 ;ledtst.j(77)                         // XOR      A
  91 ;ledtst.j(78)                         // OUT0    (DCNTL),A
  92 ;ledtst.j(79)                         // b76=00 0 wait state CPU memory cycle
  93 ;ledtst.j(80)                         // b54=00 0 wait state CPU I/O cycle
  94 ;ledtst.j(81)                         // b3 = 0 level detect on DMA1 Request
  95 ;ledtst.j(82)                         // b2 = 0 level detect on DMA0 Request
  96 ;ledtst.j(83)                         // b1 = 0 DMA from memory to I/O 
  97 ;ledtst.j(84)                         // b0 = 0 DMA increasing memory address
  98 ;ledtst.j(85)   output(WSGCR, 0x00);  //Wait State Generator Control Register P96
  99 ;ledtst.j(86)                         // OUT0    (WSGCR),A
 100 ;ledtst.j(87)                         // b76=00 0 wait states CSROM
 101 ;ledtst.j(88)                         // b54=00 0 wait states CSRAM
 102 ;ledtst.j(89)                         // b32=00 0 wait states other
 103 ;ledtst.j(90)                         // b10=xx reserved
 104 ;ledtst.j(91)   output(WDTCR, 0x00);  //Block writing to system ctrl registers
 105 ;ledtst.j(92)                         // XOR     A
 106 ;ledtst.j(93)                         // OUT0    (WDTCR),A
 107 ;ledtst.j(94) */
 108 ;ledtst.j(95)   //Einde device initialisatie
 109 ;ledtst.j(96) 
 110 ;ledtst.j(97) /*
 111 ;ledtst.j(98)             JR      LedErr
 112 ;ledtst.j(99) ;
 113 ;ledtst.j(100) ;LedOK
 114 ;ledtst.j(101) ;Blink LED on/off in a XXxxXXxx rythm
 115 ;ledtst.j(102) LedOK:      LD      DE,500
 116 ;ledtst.j(103) LedOK2:     CALL    TOGGLE
 117 ;ledtst.j(104)             CALL    WAIT
 118 ;ledtst.j(105)             JR      LedOK2
 119 ;ledtst.j(106) ;LedErr
 120 ;ledtst.j(107) ;Blink LED on/off in a XxXxxxxx rythm
 121 ;ledtst.j(108) LedErr:     CALL    TOGGLE
 122 ;ledtst.j(109)             LD      DE,170
 123 ;ledtst.j(110)             CALL    WAIT
 124 ;ledtst.j(111)             CALL    TOGGLE
 125 ;ledtst.j(112)             CALL    WAIT
 126 ;ledtst.j(113)             CALL    TOGGLE
 127 ;ledtst.j(114)             CALL    WAIT
 128 ;ledtst.j(115)             CALL    TOGGLE
 129 ;ledtst.j(116)             LD      DE,500
 130 ;ledtst.j(117)             CALL    WAIT
 131 ;ledtst.j(118)             JR      LedErr
 132 ;ledtst.j(119) ;TOGGLE
 133 ;ledtst.j(120) ;Switches off/on the LED connected to the PWRSWTCH output.
 134 ;ledtst.j(121) ;LED is connected to VCC, so the output must be driven low
 135 ;ledtst.j(122) ;in order to switch on the LED.
 136 ;ledtst.j(123) TOGGLE:     PUSH    AF
 137 ;ledtst.j(124)             LD      A,00BH      ;enable writing to PCR
 138 ;ledtst.j(125)             OUT0    (WDTCR),A
 139 ;ledtst.j(126)             IN0     A,(PCR)     ;toggle LED at PWR_SW
 140 ;ledtst.j(127)             XOR     A,020H
 141 ;ledtst.j(128)             OUT0    (PCR),A
 142 ;ledtst.j(129)             XOR     A,A         ;disable writing to PCR
 143 ;ledtst.j(130)             OUT0    (WDTCR),A
 144 ;ledtst.j(131)             POP     AF
 145 ;ledtst.j(132)             RET
 146 ;ledtst.j(133) ;WAIT
 147 ;ledtst.j(134) ;Wait DE * 1 msec @ 18,432 MHz
 148 ;ledtst.j(135) WAIT:       PUSH    DE
 149 ;ledtst.j(136)             PUSH    AF
 150 ;ledtst.j(137) WAIT1:      CALL    WAIT1M     ;Wait 1 msec
 151 ;ledtst.j(138)             DEC     DE
 152 ;ledtst.j(139)             LD      A,D
 153 ;ledtst.j(140)             OR      A,E
 154 ;ledtst.j(141)             JR      NZ,WAIT1
 155 ;ledtst.j(142)             POP     AF
 156 ;ledtst.j(143)             POP     DE
 157 ;ledtst.j(144)             RET
 158 ;ledtst.j(145) ;WAIT1M
 159 ;ledtst.j(146) ;wait 1 msec at 18,432 MHz with no wait states
 160 ;ledtst.j(147) ;The routine requires 56+n*22 states, so that with n=834
 161 ;ledtst.j(148) ;28  clock cycles remain left.   Cycles, States (cumulative)
 162 ;ledtst.j(149) WAIT1M:     PUSH    HL          ;5      11 (11)
 163 ;ledtst.j(150)                                 ;       3 opcode
 164 ;ledtst.j(151)                                 ;       3 mem write
 165 ;ledtst.j(152)                                 ;       1 inc SP
 166 ;ledtst.j(153)                                 ;       3 mem write
 167 ;ledtst.j(154)                                 ;       1 inc SP
 168 ;ledtst.j(155)             PUSH    AF          ;5      11 (22)
 169 ;ledtst.j(156)                                 ;       3 opcode
 170 ;ledtst.j(157)                                 ;       3 mem write
 171 ;ledtst.j(158)                                 ;       1 inc SP
 172 ;ledtst.j(159)                                 ;       3 mem write
 173 ;ledtst.j(160)                                 ;       1 inc SP
 174 ;ledtst.j(161)             LD      HL, 834     ;3      9 (31)
 175 ;ledtst.j(162)                                 ;       3 opcode
 176 ;ledtst.j(163)                                 ;       3 mem read
 177 ;ledtst.j(164)                                 ;       3 mem read
 178 ;ledtst.j(165) WAIT1M2:    DEC     HL          ;2      4 (31+n*4)
 179 ;ledtst.j(166)                                 ;       3 opcode
 180 ;ledtst.j(167)                                 ;       1 execute
 181 ;ledtst.j(168)             LD	A,H			    ;2      6 (31+n*10)
 182 ;ledtst.j(169)                                 ;       3 opcode
 183 ;ledtst.j(170)                                 ;       3 execute
 184 ;ledtst.j(171)             OR	A,L			    ;2      4 (31+n*14)
 185 ;ledtst.j(172)                                 ;       3 opcode
 186 ;ledtst.j(173)                                 ;       1 execute
 187 ;ledtst.j(174)             JR	NZ,WAIT1M2	    ;4      8 (31+n*22) if NZ
 188 ;ledtst.j(175)                                 ;       3 opcode
 189 ;ledtst.j(176)                                 ;       3 mem read 
 190 ;ledtst.j(177)                                 ;       1 execute
 191 ;ledtst.j(178)                                 ;       1 execute
 192 ;ledtst.j(179)                                 ;2      6 (29+n*22) if not NZ
 193 ;ledtst.j(180)                                 ;       3 opcode
 194 ;ledtst.j(181)                                 ;       3 mem read
 195 ;ledtst.j(182)             POP	AF			    ;3      9 (38+n*22)
 196 ;ledtst.j(183)                                 ;       3 opcode
 197 ;ledtst.j(184)                                 ;       3 mem read
 198 ;ledtst.j(185)                                 ;       3 mem read
 199 ;ledtst.j(186)             POP	HL			    ;3      9 (47+n*22)
 200 ;ledtst.j(187)                                 ;       3 opcode   
 201 ;ledtst.j(188)                                 ;       3 mem read
 202 ;ledtst.j(189)                                 ;       3 mem read
 203 ;ledtst.j(190)             RET				    ;3      9 (56+n*22)
 204 ;ledtst.j(191)                                 ;       3 opcode
 205 ;ledtst.j(192)                                 ;       3 mem read
 206 ;ledtst.j(193)                                 ;       3 mem read
 207 ;ledtst.j(194)   */
 208 ;ledtst.j(195) }
 209 stop
