/*
 * A small program in the miniJava language.
 * Test something
 */
import me.to.ImportedClass;

class TestImportMeToUndeclaredMethod {
  public static void main() {
    println("TestImportMeToUndeclaredMethod calling undeclared importedFunction3");
    me.to.ImportedClass.importedFunction1();
    ImportedClass.importedFunction2();
    ImportedClass.importedFunction3();
    println("TestImportMeToUndeclaredMethod Klaar");
  }
}
