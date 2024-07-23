
/* Z80S183 program that tests switching on/off the LED at the PWRSWTCH  output. */
/* Transcribed from LEDTest.asm to ledtest.j */

class Thread {

  /**
   * Wait 1 msec at 18,432 MHz with no wait states.
   * 
   * Assumes that code can be run from internal RAM with 1 wait state.
   * Assumes data can be read/written to internal RAM with 1 wait state.
   * Assumes the Z80S183 is driven by an 18.432 MHz clock at the XTAL pin
   * 
   * With b=255 the routine requires 108 + b * 71 = 18213 T-states, 
   * which is 219 T-states or 11,8 microseconds short of 1 millisecond.
   * 
   * Duplicating the for loop with a total of 257 for b and c 
   * requires 132 + (b + c) * 71 = 18379 T-states,
   * which is 53 T-states or 2,8 microseconds short of 1 millisecond.
   */
  private static void sleepOneMillisecond() {
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

}
