   0 call 9
   1 stop
   2 ;TestClassModifierPublic.j(0) /*
   3 ;TestClassModifierPublic.j(1)  * A small program in the miniJava language.
   4 ;TestClassModifierPublic.j(2)  * Test ClassDeclaration with public modifier.
   5 ;TestClassModifierPublic.j(3)  */
   6 ;TestClassModifierPublic.j(4) public class TestClassModifierPublic {
   7 class TestClassModifierPublic [public]
   8 ;TestClassModifierPublic.j(5)   public static void main() {
   9 method main [public, static] void
  10 ;TestClassModifierPublic.j(6)     println("Klaar");
  11 acc16= stringconstant 16
  12 writeLineString
  13 return
  14 ;TestClassModifierPublic.j(7)   }
  15 ;TestClassModifierPublic.j(8) }
  16 stringConstant 0 = "Klaar"
