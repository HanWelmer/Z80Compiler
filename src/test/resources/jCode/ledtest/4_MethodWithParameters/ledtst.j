/* Z80S183 program that tests switching on/off the LED at the PWRSWTCH  output. */
/* Transcribed from LEDTest.asm to ledtest.j */
class LEDTest {
  /*******************************
  To compile this class and generate Z80 asm, listing and hex files:
  - cd src\test\resources\jCode\ledtest\localVariableNoParameter
  - java -jar ..\..\..\..\..\..\target\z80Compiler-1.0-SNAPSHOT.jar -z -b ledtst.j
  Assumes that code can be run from internal RAM with 1 wait state.
  Assumes data can be read/written to internal RAM with 1 wait state.
  Assumes the Z80S183 is driven by an 18.432 MHz clock at the XTAL pin
  Assumes that an active-low LED is available at the PWRSWTCH pin:
   - connect anode of low-current (2 mA) LED to VCC
   - connect cathode of low-current LED to 1k8 resistor
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
   -  D 2000 32
  Run program
   -  G 2000
   - The LED should blink at a rate of 1Hz.
  *******************************/

  // Definition of on-chip Z80S183 registers
  //                Name  Address  Description
  //                ====  =======  =========
  static final byte WDTCR = 0x65;  //Watchdog Timer Control Register
  static final byte SCR   = 0x7F;  //System Configuration Register P91
  static final byte CCR   = 0x1F;  //CPU Control Register P84
  static final byte DCNTL = 0x32;  //DMA/Wait Control Register P121
  static final byte WSGCR = 0x6B;  //Wait State Generator Control Register P96
  static final byte PCR   = 0x7E;  //Power Control Register

  //Device initialisation
  public static void init() {
    // Enable writing to system ctrl registers
    output(WDTCR, 0x00);
    // LD      A,00BH
    // OUT0    (WDTCR),A

    // System configuration Register P91
    // b7 = 0 on-chip ROM disabled
    // b6 = 1 on-chip RAM enabled
    // b5 = 0 on-chip RAM at xF800H-xFFFFH
    // b4 = 1 ROMCS enabled/disabled
    // b3 = 1 RAMCS enabled/disabled
    // b2 = 1 IOCS  enabled/disabled
    // b10=00 PHI = EXTAL clock
    output(SCR, 0x5C);
    // LD      A,05CH
    // OUT0    (SCR),A
  
    // CPU Control Register P84
    // b7 = 1 PHI = XTAL / 1
    // b63=00 SLP instruction enters sleep mode
    // b5 = 0 BREQ in standby ignored
    // b4 = 0 PHI low noise disabled
    // b2 = x reserved
    // b1 = 0 IORD/IOWR low noise disabled
    // b0 = 0 A19-0/D7-0 low noise disabled
    output(CCR, 0x80);    
    // LD      A,080H
    // OUT0    (CCR),A

    
    // DMA/Wait Control Register P121
    // b76=00 0 wait state CPU memory cycle
    // b54=00 0 wait state CPU I/O cycle
    // b3 = 0 level detect on DMA1 Request
    // b2 = 0 level detect on DMA0 Request
    // b1 = 0 DMA from memory to I/O 
    // b0 = 0 DMA increasing memory address
    output(DCNTL, 0x00);
    // XOR      A
    // OUT0    (DCNTL),A

    // Wait State Generator Control Register P96
    // b76=00 0 wait states CSROM
    // b54=00 0 wait states CSRAM
    // b32=00 0 wait states other
    // b10=xx reserved
    output(WSGCR, 0x00);
    // OUT0    (WSGCR),A

    // Block writing to system ctrl registers
    output(WDTCR, 0x00);
    // XOR     A
    // OUT0    (WDTCR),A
  }

  public static void toggle() {
    // Enable writing to PCR
    output(WDTCR, 0x0B);
    //LD      A,00BH
    //OUT0    (WDTCR),A

    // Toggle LED at PWR_SW
    output(PCR, input(PCR) ^ 0x20);
    //IN0     A,(PCR)
    //XOR     A,020H
    //OUT0    (PCR),A

    // Disable writing to PCR
    output(WDTCR, 0x00);
    //XOR     A,A
    //OUT0    (WDTCR),A
  }

  /**
   * Wait 1 msec at 18,432 MHz with no wait states.
   * 
   * With n=255 the routine requires 108 + n * 71 = 18213 T-states, 
   * which is 219 T-states or 11,8 microseconds short of 1 millisecond.
   * 
   * Duplicating the for loop with a total of 257 for n and m 
   * requires 132 + (n + m) * 71 = 18379 T-states,
   * which is 53 T-states or 2,8 microseconds short of 1 millisecond.
   */
  public static void sleepOneMillisecond() {
    for (byte b = 255; b!=0; b--) ;
  }

  /**
   * sleep for n miliseconds.
   */
  public static void sleep(word n) {
    while (n != 0) {
      sleepOneMillisecond();
      n--;
    }
  }

  // Blink LED on/off in a XXxxXXxx pattern at 1 Hz.
  public static void main() {
    init();
    while (1==1) {
      toggle();
      //Thread.sleep(500); // Sleep for 500 miliseconds.
      sleep(500); // Sleep for 500 miliseconds.
    }
  }
}
