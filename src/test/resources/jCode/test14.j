/* Program to test generated Z80 assembler code for output and input statements*/
class TestSleep {

  println(0);

  println("sleeping 0.25 second:");
  sleep(250);
  println("sleeping 10 second:");
  sleep(10000);
  println("sleeping 0.25 second:");
  byte value = 200;
  sleep(value);
  println("sleeping 10 second:");
  word bigValue = 10000;
  sleep(bigValue);

  println("Klaar");
}
