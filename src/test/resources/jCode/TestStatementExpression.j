public class TestStatementExpression {
  
  private static byte b;

  private static void doIt() {
    println("doIt");
  }

  public static void main() {
    // assignment: Name AssignmentOperator Expression
    b = 1;
    // ImportedClass.b = 2;
    // packageName.ImportedClass.b = 3;
    /*
    b *= 2;
    b /= 2;
    b %= 2;
    b += 2;
    b -= 2;
    b <<= 2;
    b >>= 2;
    b >>>= 2;
    b &= 2;
    b ^= 2;
    b |= 2;
    */
    // preincrementExpression
    ++b;
    // predecrementExpression
    --b;
    // postincrementExpression
    b++;
    // postdecrementExpression
    b--;
    // methodInvocation
    doIt();
  }
}