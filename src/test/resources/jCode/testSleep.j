/* Program to test generated Z80 assembler code for output and input statements*/
class TestSleep {
  private static final byte VALUE = 200;
  private static final word BIG_VALUE = 10000;
  private static byte globalByte = 250;
  private static word globalWord = 10000;

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

  public static void main() {
    println(0);
  
    byte localByte = 250;
    word localWord = 10000;

    //println("sleeping 0.25 second:");
    //sleep(250);
    println("sleeping 10 second:");
    sleep(10000);
    //println("sleeping 0.25 second:");
    //sleep(VALUE);
    println("sleeping 10 second:");
    sleep(BIG_VALUE);
    //println("sleeping 0.25 second:");
    //sleep(localByte);
    println("sleeping 10 second:");
    sleep(localWord);
    //println("sleeping 0.25 second:");
    //sleep(globalByte);
    println("sleeping 10 second:");
    sleep(globalWord);
  
    println("Klaar");
  }

}
