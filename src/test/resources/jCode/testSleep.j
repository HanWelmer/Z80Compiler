/* Program to test generated Z80 assembler code for output and input statements*/
class TestSleep {
  private static byte value = 200;
  private static word bigValue = 10000;

  public static void main() {
    println(0);
  
    println("sleeping 0.25 second:");
    sleep(250);
    println("sleeping 10 second:");
    sleep(10000);
    println("sleeping 0.25 second:");
    sleep(value);
    println("sleeping 10 second:");
    sleep(bigValue);
  
    println("Klaar");
  }
}
