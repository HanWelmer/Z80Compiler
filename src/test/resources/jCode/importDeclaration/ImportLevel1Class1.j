import ImportLevel2Class1;
import ImportLevel2Class2;

class ImportLevel1Class1 {
  private static String str = "Level 1 class 1";
  
  public static void doIt() {
    println(str);
    ImportLevel2Class1.doIt();
    ImportLevel2Class2.doIt();
  }
}
