   0 call 16
   1 stop
   2 ;TestStatementExpression.j(0) public class TestStatementExpression {
   3 class TestStatementExpression [public]
   4 ;TestStatementExpression.j(1)   
   5 ;TestStatementExpression.j(2)   private static byte b;
   6 ;TestStatementExpression.j(3) 
   7 ;TestStatementExpression.j(4)   private static void doIt() {
   8 method doIt [private, static] void
   9 ;TestStatementExpression.j(5)     println("doIt");
  10 acc16= stringconstant 54
  11 writeLineString
  12 return
  13 ;TestStatementExpression.j(6)   }
  14 ;TestStatementExpression.j(7) 
  15 ;TestStatementExpression.j(8)   public static void main() {
  16 method main [public, static] void
  17 ;TestStatementExpression.j(9)     // assignment: Name AssignmentOperator Expression
  18 ;TestStatementExpression.j(10)     b = 1;
  19 acc8= constant 1
  20 acc8=> variable 0
  21 ;TestStatementExpression.j(11)     // ImportedClass.b = 2;
  22 ;TestStatementExpression.j(12)     // packageName.ImportedClass.b = 3;
  23 ;TestStatementExpression.j(13)     /*
  24 ;TestStatementExpression.j(14)     b *= 2;
  25 ;TestStatementExpression.j(15)     b /= 2;
  26 ;TestStatementExpression.j(16)     b %= 2;
  27 ;TestStatementExpression.j(17)     b += 2;
  28 ;TestStatementExpression.j(18)     b -= 2;
  29 ;TestStatementExpression.j(19)     b <<= 2;
  30 ;TestStatementExpression.j(20)     b >>= 2;
  31 ;TestStatementExpression.j(21)     b >>>= 2;
  32 ;TestStatementExpression.j(22)     b &= 2;
  33 ;TestStatementExpression.j(23)     b ^= 2;
  34 ;TestStatementExpression.j(24)     b |= 2;
  35 ;TestStatementExpression.j(25)     */
  36 ;TestStatementExpression.j(26)     // preincrementExpression
  37 ;TestStatementExpression.j(27)     ++b;
  38 incr8 variable 0
  39 ;TestStatementExpression.j(28)     // predecrementExpression
  40 ;TestStatementExpression.j(29)     --b;
  41 decr8 variable 0
  42 ;TestStatementExpression.j(30)     // postincrementExpression
  43 ;TestStatementExpression.j(31)     b++;
  44 incr8 variable 0
  45 ;TestStatementExpression.j(32)     // postdecrementExpression
  46 ;TestStatementExpression.j(33)     b--;
  47 decr8 variable 0
  48 ;TestStatementExpression.j(34)     // methodInvocation
  49 ;TestStatementExpression.j(35)     doIt();
  50 call 8
  51 return
  52 ;TestStatementExpression.j(36)   }
  53 ;TestStatementExpression.j(37) }
  54 stringConstant 0 = "doIt"
