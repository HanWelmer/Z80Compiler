public class TestStatementExpression {
  
  private static byte b;
  
  public static void mein() {
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
    //doIt()
  }
}