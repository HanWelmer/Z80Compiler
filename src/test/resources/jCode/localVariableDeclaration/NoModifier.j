/*
 * A small program in the miniJava language.
 * Test final modifier in a local variable declaration.
 */
class NoModifier {
  public static void doByte() {
    byte b = 1;
    println(b);
  }
  public static void doByteWord() {
    byte b = 2;
    word w = 3333;
    println(b);
    println(w);
  }
  public static void doWordByte() {
    word w = 5555;
    byte b = 4;
    println(b);
    println(w);
  }
  public static void doString() {
    String str = "Hallo Wereld";
    println(str);
  }
  public static void main() {
    byte b = 0;
    println(b);
    doString();
    doByte();
    doByteWord();
    doWordByte();
    println("klaar");
  }
}
