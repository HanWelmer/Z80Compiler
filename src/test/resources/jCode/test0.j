/* Program to test generated Z80 assembler code */
class TestPrint {
  private static final word i = 1;
  private static final byte b = 2;
  public static void main() {
    println(0);
    println(i);
    println(b);
    println("Hallo" + " wereld.");
    println("Nog" + " een" + " bericht.");
    println("3 + 2 = " + 5);
    println("3 + 3 = " + (2 * 3));
    println("3 + 4 = " + (2 + 5) + ".");
    println("Klaar.");
  }
}