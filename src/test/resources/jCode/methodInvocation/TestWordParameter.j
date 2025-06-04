public class TestWordParameter {
  
  private static void doIt(word w) {
    println(w);
    word wv = 1002;
    println(wv);
  }

  public static void main() {
    println("Verwacht 1000..1002");
    println(1000);
    doIt(1001);
    println("Klaar");
  }
}