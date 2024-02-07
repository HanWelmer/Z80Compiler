/* Program to test generated Z80 assembler code */
class TestFor {

  public static void main() {
    println(1);
    for (byte b = 1; b < 2; b++) {
      ;
    }
    println(2);
    for (byte b = 1; b < 2; b++) ;
    println(3);
    for (byte b = 1; b < 2;) {
      println(4);
      b++;
    }
    println(5);
    println("Klaar.");
  }
}