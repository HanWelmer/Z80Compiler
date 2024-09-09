/*
 * A small program in the miniJava language.
 * Test something
 */
import ImportLevel1Class1;
import ImportLevel1Class2;

class TestNestedImport {
  public static void main() {
    ImportLevel1Class1.doIt();
    ImportLevel1Class2.doIt();
    println("TestNestedImport Klaar");
  }
}
