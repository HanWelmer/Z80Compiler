/* Program to test generated Z80 assembler code */
class TestEmptyBlock {

  public static void main() {
    println(1);
    {
      ;
    }
    println(2);
    println("Klaar.");
  }
}