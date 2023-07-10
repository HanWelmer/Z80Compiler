/**
 * Enumeration for the pCompiler.
 * This class defines the operation types for an expression in the P language. 
 * Used in lexical analysis, semantic analysis and code generation phases of the compiler.
 *
 * Operators are enumerated in order of increasing precedence.
 */
public enum OperatorType {
  bitwiseOr,
  bitwiseXor,
  bitwiseAnd,
  eq,
  ne,
  lt,
  le,
  gt,
  ge,
  add,
  sub,
  mul,
  div
};

/* Java operator precedence:
Precedence	Operator	Type	                    Associativity
15	        ()        Parentheses               Left to Right
            []        Array subscript
            .         Member selection
14	        ++	      Unary post-increment
            --        Unary post-decrement	    Left to Right
13	        ++	      Unary pre-increment
            --        Unary pre-decrement
            +         Unary plus
            -         Unary minus
            !         Unary logical negation
            ~         Unary bitwise complement
            ( type )  Unary type cast	          Right to left
12	        *	        Multiplication
            /         Division
            %         Modulus	                  Left to right
11	        +	        Addition
            -         Subtraction	              Left to right
10	        <<	      Bitwise left shift
            >>        Bitwise right shift 
                      with sign extension
            >>>       Bitwise right shift
                      with zero extension	      Left to right
9	          <         less than
            <=        less than or equal
            >         greater than
            >=        greater than or equal     Left to right
8	          ==	      Relational equal
            !=        Relational not equal      Left to right
7	          &         Bitwise AND               Left to right
6           ^         Bitwise exclusive OR      Left to right
5           |         Bitwise inclusive OR      Left to right
4           &&        Logical AND               Left to right
3           ||        Logical OR                Left to right
2           ? :       Ternary conditional       Right to left
1           =         Assignment
            +=        Addition assignment
            -=        Subtraction assignment
            *=        Multiplication assignment
            /=        Division assignment
            %=        Modulus assignment	      Right to left
*/
