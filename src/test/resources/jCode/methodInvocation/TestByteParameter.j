public class TestByteParameter {
  
  private static void doIt(byte b) {
    println(b);
    byte bv = 2;
    println(bv);
  }

  public static void main() {
    println("Verwacht 0..2");
    println(0);
    doIt(1);
    println("Klaar");
  }
}