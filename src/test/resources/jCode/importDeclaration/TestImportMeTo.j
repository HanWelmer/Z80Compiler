/*
 * A small program in the miniJava language.
 * Test something
 */
import me.to.ImportedClass;

class TestImportMeTo {
  public static void main() {
    println("TestImportMeTo importing 2 functions from ImportedClass");
    me.to.ImportedClass.importedFunction1();
    me.to.ImportedClass.importedFunction2();
    println("TestImportMeTo Klaar");
  }
}
