/* Program to test generated Z80 assembler code for output and input statements*/
class TestSleep {
  byte value = 200;
  word bigValue = 10000;
  public static void main() {
    println(0);
  
    println("sleeping 0.25 second:");
    sleep(250);
    println("sleeping 10 second:");
    sleep(10000);
    println("sleeping 0.25 second:");
    value = 200;
    sleep(value);
    println("sleeping 10 second:");
    bigValue = 10000;
    sleep(bigValue);
  
    println("Klaar");
  }
}
