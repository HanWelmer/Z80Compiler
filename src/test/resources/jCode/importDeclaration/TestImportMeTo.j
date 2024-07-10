/*
 * A small program in the miniJava language.
 * Test something
 */
import me.to.ImportedClass;

class TestImportMeTo {
  public static void main() {
    println("TestImportMeTo importing ImportedClass");
    ImportedClass.importedFunction();
    println("TestImportMeTo Klaar");
  }
}
