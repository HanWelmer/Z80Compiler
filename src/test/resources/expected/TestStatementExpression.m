   0 ;TestStatementExpression.j(0) public class TestStatementExpression {
   1 class TestStatementExpression [public]
   2 ;TestStatementExpression.j(1)   
   3 ;TestStatementExpression.j(2)   private static byte b;
   4 ;TestStatementExpression.j(3)   
   5 ;TestStatementExpression.j(4)   public static void mein() {
   6 method mein [public, static] void
   7 ;TestStatementExpression.j(5)     // assignment: Name AssignmentOperator Expression
   8 ;TestStatementExpression.j(6)     b = 1;
   9 acc8= constant 1
  10 acc8=> variable 0
  11 ;TestStatementExpression.j(7)     // ImportedClass.b = 2;
  12 ;TestStatementExpression.j(8)     // packageName.ImportedClass.b = 3;
  13 ;TestStatementExpression.j(9)     /*
  14 ;TestStatementExpression.j(10)     b *= 2;
  15 ;TestStatementExpression.j(11)     b /= 2;
  16 ;TestStatementExpression.j(12)     b %= 2;
  17 ;TestStatementExpression.j(13)     b += 2;
  18 ;TestStatementExpression.j(14)     b -= 2;
  19 ;TestStatementExpression.j(15)     b <<= 2;
  20 ;TestStatementExpression.j(16)     b >>= 2;
  21 ;TestStatementExpression.j(17)     b >>>= 2;
  22 ;TestStatementExpression.j(18)     b &= 2;
  23 ;TestStatementExpression.j(19)     b ^= 2;
  24 ;TestStatementExpression.j(20)     b |= 2;
  25 ;TestStatementExpression.j(21)     */
  26 ;TestStatementExpression.j(22)     // preincrementExpression
  27 ;TestStatementExpression.j(23)     ++b;
  28 incr8 variable 0
  29 ;TestStatementExpression.j(24)     // predecrementExpression
  30 ;TestStatementExpression.j(25)     --b;
  31 decr8 variable 0
  32 ;TestStatementExpression.j(26)     // postincrementExpression
  33 ;TestStatementExpression.j(27)     b++;
  34 incr8 variable 0
  35 ;TestStatementExpression.j(28)     // postdecrementExpression
  36 ;TestStatementExpression.j(29)     b--;
  37 decr8 variable 0
  38 ;TestStatementExpression.j(30)     // methodInvocation
  39 ;TestStatementExpression.j(31)     //doIt()
  40 ;TestStatementExpression.j(32)   }
  41 ;TestStatementExpression.j(33) }
  42 stop
