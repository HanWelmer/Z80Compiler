/* Z80S183 program that tests switching on/off the LED at the PWRSWTCH  output. */
/* Transcribed from LEDTest.asm to ledtest.j */
class LEDTest {
  /*******************************
  Assumes that code can be run from internal RAM with 1 wait state.
  Assumes data can be read/written to internal RAM with 1 wait state.
  Assumes the Z80S183 is driven by an 18.432 MHz clock at the XTAL pin
  Assumes that an active-low LED is available at the PWRSWTCH pin:
   - connect anode of low-current LED to VCC
   - connect cathode of low-currebt LED to 1k8 resistor
   - connect other end of resistor to PWR_SW (pin 13 of J23).
  
  Connect Z80S183 evaluation board via DB9 (male-female) cable to RS232 of host computer.
  Start hyperterminal or TeraTerm:
   - Select serial communication using COM1
   - Set up | Serial port
     * COM1
     * 57600
     * 8N2
     * no flow control
   - connect 9V DC adapter to Z80S183 evaluation board.
   - Press RESET on Z80S183 evaluation board
     The text Zilog Z80183 Monitor Version 2.8 should appear.
  Upload Intel hex file ledtst.hex:
   -  type L
   -  File | Send file
      * Browse to file ledtst.hex and select OK
      * The text 10(10) records in Hex file should appear
  Check memory contents:
   -  D f800 32
  Run program
   -  G f800
   - The LED should blink at a rate of 1Hz.
  
  The program switches on and off the LED at a rate of 1 Hz.
  *******************************/

  //Definition of on-chip Z80S183 registers
  //   Name  Address  Description
  //   ====  =======  =========
  byte WDTCR = 0x65;  //Watchdog Timer Control Register
  byte PCR   = 0x7E;  //Power Control Register
  byte SCR   = 0x7F;  //System Configuration Register P91
  byte CCR   = 0x1F;  //CPU Control Register P84
  byte WSGCR = 0x6B;  //Wait State Generator Control Register P96
  byte DCNTL = 0x32;  //DMA/Wait Control Register P121

  //Device initialisation
  output(WDTCR, 0x00);  //Enable writing to system ctrl registers
                        // LD      A,00BH
                        // OUT0    (WDTCR),A
  output(SCR, 0x5C);    //System configuration Register P91
                        // LD      A,05CH
                        // OUT0    (SCR),A
                        // b7 = 0 on-chip ROM disabled
                        // b6 = 1 on-chip RAM enabled
                        // b5 = 0 on-chip RAM at xF800H-xFFFFH
                        // b4 = 1 ROMCS enabled/disabled
                        // b3 = 1 RAMCS enabled/disabled
                        // b2 = 1 IOCS  enabled/disabled
                        // b10=00 PHI = EXTAL clock

  output(CCR, 0x80);    //CPU Control Register P84
                        // LD      A,080H
                        // OUT0    (CCR),A
                        // b7 = 1 PHI = XTAL / 1
                        // b63=00 SLP instruction enters sleep mode
                        // b5 = 0 BREQ in standby ignored
                        // b4 = 0 PHI low noise disabled
                        // b2 = x reserved
                        // b1 = 0 IORD/IOWR low noise disabled
                        // b0 = 0 A19-0/D7-0 low noise disabled
  output(DCNTL, 0x00);  //DMA/Wait Control Register P121
                        // XOR      A
                        // OUT0    (DCNTL),A
                        // b76=00 0 wait state CPU memory cycle
                        // b54=00 0 wait state CPU I/O cycle
                        // b3 = 0 level detect on DMA1 Request
                        // b2 = 0 level detect on DMA0 Request
                        // b1 = 0 DMA from memory to I/O 
                        // b0 = 0 DMA increasing memory address
  output(WSGCR, 0x00);  //Wait State Generator Control Register P96
                        // OUT0    (WSGCR),A
                        // b76=00 0 wait states CSROM
                        // b54=00 0 wait states CSRAM
                        // b32=00 0 wait states other
                        // b10=xx reserved
  output(WDTCR, 0x00);  //Block writing to system ctrl registers
                        // XOR     A
                        // OUT0    (WDTCR),A
  //Einde device initialisatie

/*
            JR      LedErr
;
;LedOK
;Blink LED on/off in a XXxxXXxx rythm
LedOK:      LD      DE,500
LedOK2:     CALL    TOGGLE
            CALL    WAIT
            JR      LedOK2
;LedErr
;Blink LED on/off in a XxXxxxxx rythm
LedErr:     CALL    TOGGLE
            LD      DE,170
            CALL    WAIT
            CALL    TOGGLE
            CALL    WAIT
            CALL    TOGGLE
            CALL    WAIT
            CALL    TOGGLE
            LD      DE,500
            CALL    WAIT
            JR      LedErr
;TOGGLE
;Switches off/on the LED connected to the PWRSWTCH output.
;LED is connected to VCC, so the output must be driven low
;in order to switch on the LED.
TOGGLE:     PUSH    AF
            LD      A,00BH      ;enable writing to PCR
            OUT0    (WDTCR),A
            IN0     A,(PCR)     ;toggle LED at PWR_SW
            XOR     A,020H
            OUT0    (PCR),A
            XOR     A,A         ;disable writing to PCR
            OUT0    (WDTCR),A
            POP     AF
            RET
;WAIT
;Wait DE * 1 msec @ 18,432 MHz
WAIT:       PUSH    DE
            PUSH    AF
WAIT1:      CALL    WAIT1M     ;Wait 1 msec
            DEC     DE
            LD      A,D
            OR      A,E
            JR      NZ,WAIT1
            POP     AF
            POP     DE
            RET
;WAIT1M
;wait 1 msec at 18,432 MHz with no wait states
;The routine requires 56+n*22 states, so that with n=834
;28  clock cycles remain left.   Cycles, States (cumulative)
WAIT1M:     PUSH    HL          ;5      11 (11)
                                ;       3 opcode
                                ;       3 mem write
                                ;       1 inc SP
                                ;       3 mem write
                                ;       1 inc SP
            PUSH    AF          ;5      11 (22)
                                ;       3 opcode
                                ;       3 mem write
                                ;       1 inc SP
                                ;       3 mem write
                                ;       1 inc SP
            LD      HL, 834     ;3      9 (31)
                                ;       3 opcode
                                ;       3 mem read
                                ;       3 mem read
WAIT1M2:    DEC     HL          ;2      4 (31+n*4)
                                ;       3 opcode
                                ;       1 execute
            LD	A,H			    ;2      6 (31+n*10)
                                ;       3 opcode
                                ;       3 execute
            OR	A,L			    ;2      4 (31+n*14)
                                ;       3 opcode
                                ;       1 execute
            JR	NZ,WAIT1M2	    ;4      8 (31+n*22) if NZ
                                ;       3 opcode
                                ;       3 mem read 
                                ;       1 execute
                                ;       1 execute
                                ;2      6 (29+n*22) if not NZ
                                ;       3 opcode
                                ;       3 mem read
            POP	AF			    ;3      9 (38+n*22)
                                ;       3 opcode
                                ;       3 mem read
                                ;       3 mem read
            POP	HL			    ;3      9 (47+n*22)
                                ;       3 opcode   
                                ;       3 mem read
                                ;       3 mem read
            RET				    ;3      9 (56+n*22)
                                ;       3 opcode
                                ;       3 mem read
                                ;       3 mem read
  */
}
