import ImportLevel2Class3;
import ImportLevel2Class4;

class ImportLevel1Class2 {
  private static String str = "Level 1 class 2";

  public static void doIt() {
    println(str);
    ImportLevel2Class3.doIt();
    ImportLevel2Class4.doIt();
  }
}
