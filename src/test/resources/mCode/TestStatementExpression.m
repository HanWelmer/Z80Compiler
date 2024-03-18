   0 call 21
   1 stop
   2 ;TestStatementExpression.j(0) public class TestStatementExpression {
   3 class TestStatementExpression [public]
   4 ;TestStatementExpression.j(1)   
   5 ;TestStatementExpression.j(2)   private static byte b;
   6 ;TestStatementExpression.j(3) 
   7 ;TestStatementExpression.j(4)   private static void doIt() {
   8 method doIt [private, static] void ()
   9 <basePointer
  10 basePointer= stackPointer
  11 stackPointer+ constant 0
  12 ;TestStatementExpression.j(5)     println("doIt");
  13 acc16= stringconstant 64
  14 writeLineString
  15 stackPointer= basePointer
  16 basePointer<
  17 return
  18 ;TestStatementExpression.j(6)   }
  19 ;TestStatementExpression.j(7) 
  20 ;TestStatementExpression.j(8)   public static void main() {
  21 method main [public, static] void ()
  22 <basePointer
  23 basePointer= stackPointer
  24 stackPointer+ constant 0
  25 ;TestStatementExpression.j(9)     // assignment: Name AssignmentOperator Expression
  26 ;TestStatementExpression.j(10)     b = 1;
  27 acc8= constant 1
  28 acc8=> variable 0
  29 ;TestStatementExpression.j(11)     // ImportedClass.b = 2;
  30 ;TestStatementExpression.j(12)     // packageName.ImportedClass.b = 3;
  31 ;TestStatementExpression.j(13)     /*
  32 ;TestStatementExpression.j(14)     b *= 2;
  33 ;TestStatementExpression.j(15)     b /= 2;
  34 ;TestStatementExpression.j(16)     b %= 2;
  35 ;TestStatementExpression.j(17)     b += 2;
  36 ;TestStatementExpression.j(18)     b -= 2;
  37 ;TestStatementExpression.j(19)     b <<= 2;
  38 ;TestStatementExpression.j(20)     b >>= 2;
  39 ;TestStatementExpression.j(21)     b >>>= 2;
  40 ;TestStatementExpression.j(22)     b &= 2;
  41 ;TestStatementExpression.j(23)     b ^= 2;
  42 ;TestStatementExpression.j(24)     b |= 2;
  43 ;TestStatementExpression.j(25)     */
  44 ;TestStatementExpression.j(26)     // preincrementExpression
  45 ;TestStatementExpression.j(27)     ++b;
  46 incr8 variable 0
  47 ;TestStatementExpression.j(28)     // predecrementExpression
  48 ;TestStatementExpression.j(29)     --b;
  49 decr8 variable 0
  50 ;TestStatementExpression.j(30)     // postincrementExpression
  51 ;TestStatementExpression.j(31)     b++;
  52 incr8 variable 0
  53 ;TestStatementExpression.j(32)     // postdecrementExpression
  54 ;TestStatementExpression.j(33)     b--;
  55 decr8 variable 0
  56 ;TestStatementExpression.j(34)     // methodInvocation
  57 ;TestStatementExpression.j(35)     doIt();
  58 call 8
  59 stackPointer= basePointer
  60 basePointer<
  61 return
  62 ;TestStatementExpression.j(36)   }
  63 ;TestStatementExpression.j(37) }
  64 stringConstant 0 = "doIt"
