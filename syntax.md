# Syntax and semantics of the miniJava language.

## Extended BNF
The syntax is defined in extended BNF.

- A non-terminal is a plain text identifier, starting with a character, followed by charactors or digits.
- Terminal symbols are between qutotes (')  or double quotes (").
- The optional appearance of a single construct (terminal or non-terminal) X is written as X?.
- The optional appearance (zero or one instance) of the sequence of constructs X and Y is written [ X Y ].
- The iterative appearance (zero or more instances) of the sequence of constructs X and Y is written { X Y }.
- Possible characters and digits are defined individually, such as "0", or as a range, such as "(1-9)".

## Limitations and extensions
Compared to an [original but not official Java syntax](https://cs.au.dk/~amoeller/RegAut/JavaBNF.html), 
a copy of which is available in JAVA_BNF_Rules.txt, the syntax of miniJava has 
the following limitations have been imposed:
- typeDeclaration:      no interfaceDeclaration or ";".
- classDeclaration      fixed single classModifier.
- classDeclaration:     no super? or interfaces?.
- classModifier:        no "abstract" or "final".
- classBodyDeclaration: no constructorDeclaration.
- fieldModifier         no "protected", "static", "transient" or "volatile".
- variableDeclaratorId  no arrays (sequence of: variableDeclaratorId "[" "]").
- variableInitializer   no arrayInitializer.
- methodHeader          no throws?.
- methodModifier        no "protected", "static", "abstract", "final", "synchronized" or "native".
- type                  no referenceType.
- primitiveType         no "boolean".
- numericType           no floatingPointType.
- integralType          no "short", "int", "long" or "char".
- statement             no labeledStatement.
- statementWithoutTrailingSubstatement 
                        no switchStatement, breakStatement, continueStatement, synchronizedStatement, throwsStatements or tryStatement.
- statementExpression   no classInstanceCreationExpression.
- leftHandSide          no fieldAccess or arrayAccess.
- relationalExpression  no "instanceof" referenceType.
- castPrefix            no "(" referenceType ")".
- primary               no arrayCreationExpression.
- primaryNoNewArray     no classInstanceCreationExpression or arrayAccess.
- fieldAccess           no "super" "." identifier.
- methodInvocation      no primary "." identifier "(" argumentList? ")" or "super" "." identifier "(" argumentList? ")".
- literal               no floatingPointLiteral, booleanLiteral or nullLiteral.
- decimalIntegerLiteral no integerTypeSuffix.
- hexIntegerLiteral     no integerTypeSuffix.
- octalIntegerLiteral   no integerTypeSuffix.

Compared to an original but not official Java syntax, the syntax of miniJava has the following extensions:
- compilationUnit       mandatory single typeDeclaration instead of optional sequence ( {...} ).
- integralType          added "word".

Additionally, in order to avoid ambiguity and at the same time make the sytax LL(1), the 'then' substatement of an
if statement, the substatement of a whileStatement and the substatement of a forStatement may be
a block of statements or a single statement, but in the latter case not an if-statement.
As a consequence the 'NoShortIf' variants from the original Java syntax are no longer needed.

As a consequence, for example, the following Java code is not allowed:
'if (x > 0)
  if (x < 10)
    flag = true;
  else
    flag = false;'

An alternative is to use a block instead of a single statement:
'if (x > 0) {
    if (x < 10)
      flag = true;
    else
      flag = false;
};'

The shorter version:
'if (x > 0)
    if (x < 10)
      flag = true;'

could be replaced by either:
'if (x > 0) {
    if (x < 10)
      flag = true;
};'

or:
'if (x > 0 && x < 10)
  flag = true;
};'

## Questions:
1. Can a class be something else than puclic, abstract or final, e.g. protected or private?
2. classBodyDeclaration with or without staticInitializer?

## Synxtax definition

### Programs
'compilationUnit                      = packageDeclaration? { importDeclaration } typeDeclaration.'

### Declarations
'packageDeclaration                   = "package" packageName ";".
importDeclaration                    = "import" packageName "." importType ";".
importType                           = identifier | "*".
typeDeclaration                      = classDeclaration.
classDeclaration                     = classModifier "class" identifier classBody.
classModifier                        = "public".
classBody                            = "{" { classBodyDeclaration } "}".
classBodyDeclaration                 = classMemberDeclaration | staticInitializer.
classMemberDeclaration               = fieldDeclaration | methodDeclaration.
staticInitializer                    = "static" block.
fieldDeclaration                     = { fieldModifier } type variableDeclarators ";".
fieldModifier                        = "public" | "private" | "final".
methodDeclaration                    = methodHeader methodBody.
methodHeader                         = { methodModifier } resultType methodDeclarator.
methodModifier                       = "public" | "private".
resultType                           = type | "void".
methodDeclarator                     = identifier "(" formalParameterList? ")".
formalParameterList                  = formalParameter {"," formalParameter}.
formalParameter                      = type variableDeclaratorId.
methodBody                           = block | ";".'

### Blocks and Commands
'block                                = "{" { blockStatement } "}".
blockStatement                       = localVariableDeclarationStatement | statement.
localVariableDeclarationStatement    = localVariableDeclaration ";".
localVariableDeclaration             = type variableDeclarators.'

### Types
'type                                 = primitiveType.
primitiveType                        = numericType.
numericType                          = integralType.
integralType                         = "byte" | "word".
variableDeclarators                  = variableDeclarator {"," variableDeclarator}.
variableDeclarator                   = variableDeclaratorId ["=" variableInitializer].
variableDeclaratorId                 = identifier.
variableInitializer                  = expression.
statement                            = statementExceptIf | ifStatement
statementExceptIf                    = statementWithoutTrailingSubstatement | whileStatement | forStatement.
statementWithoutTrailingSubstatement = block | emptyStatement | expressionStatement | doStatement | returnStatement.
emptyStatement                       = ";".
expressionStatement                  = statementExpression ";".
statementExpression                  = assignment | preincrementExpression | postincrementExpression | predecrementExpression | postdecrementExpression | methodInvocation.
preincrementExpression               = "++" unaryExpression.
predecrementExpression               = "--" unaryExpression.
doStatement                          = "do" statement "while" "(" expression ")" ";".
returnStatement                      = "return" expression? ";".
whileStatement                       = "while" "(" expression ")" statementExceptIf.
forStatement                         = "for" "(" forInit? ";" expression? ";" forUpdate? ")" statementExceptIf.
forInit                              = statementExpressionList | localVariableDeclaration.
forUpdate                            = statementExpressionList.
statementExpressionList              = statementExpression {"," statementExpression}.
ifStatement                          = "if" "(" expression ")" statementExceptIf ["else" statement].
constantExpression                   = expression.'

### Expressions
'expression                           = assignmentExpression.
assignmentExpression                 = assignment | conditionalExpression.
assignment                           = leftHandSide assignmentOperator assignmentExpression.
leftHandSide                         = expressionName.
assignmentOperator                   = "=" | "*=" | "/=" | "%=" | "+=" | "-=" | "<<=" | ">>=" | ">>>=" | "&=" | "^=" | "|=".
conditionalExpression                = conditionalOrExpression [ "?" expression ":" conditionalExpression ].
conditionalOrExpression              = conditionalAndExpression { "||" conditionalAndExpression }.
conditionalAndExpression             = inclusiveOrExpression { "&&" inclusiveOrExpression }.
inclusiveOrExpression                = exclusiveOrExpression { "|" exclusiveOrExpression }.
exclusiveOrExpression                = andExpression { "^" andExpression }.
andExpression                        = equalityExpression { "&" equalityExpression }.
equalityExpression                   = relationalExpression [ equalityOperator equalityExpression ].
equalityOperator                     = "==" | "!=".
relationalExpression                 = shiftExpression [ relationalOperator shiftExpression ].
relationalOperator                   = ">" | ">=" | "<" | "<=".
shiftExpression                      = additiveExpression [ shiftOperator additiveExpression].
shiftOperator                        = "<<" | ">>" | ">>>".
additiveExpression                   = multiplicativeExpression [ additiveOperator multiplicativeExpression ].
additiveOperator                     = "+" | "-".
multiplicativeExpression             = unaryExpression [ multiplicativeOperator unaryExpression ].
multiplicativeOperator               = "*" | "/" | "%".
unaryExpression                      = {unaryOperator} postfixExpression.
unaryOperator                        = "++" | "--" | "+" | "-" | "~" | "!" | castPrefix.
castPrefix                           = "(" primitiveType ")".
postfixExpression                    = postincrementExpression | postdecrementExpression | primary | expressionName.
postincrementExpression              = postfixExpression "++".
postdecrementExpression              = postfixExpression "--".
primary                              = primaryNoNewArray.
primaryNoNewArray                    = literal | "this" | "(" expression ")" | fieldAccess | methodInvocation.
fieldAccess                          = primary "." identifier.
methodInvocation                     = methodName "(" argumentList? ")".
argumentList                         = expression { "," expression }.'

### Tokens
'packageName                          = identifier { "." identifier }.
expressionName                       = [ ambiguousName "." ] identifier.
methodName                           = [ ambiguousName "." ] identifier.
ambiguousName                        = identifier { "." identifier }.
literal                              = integerLiteral | characterLiteral | stringLiteral.
integerLiteral                       = decimalIntegerLiteral | hexIntegerLiteral | octalIntegerLiteral.
decimalIntegerLiteral                = decimalNumeral.
hexIntegerLiteral                    = hexNumeral.
octalIntegerLiteral                  = octalNumeral.
decimalNumeral                       = "0" | nonZeroDigit { digit }.
digit                                = "0" | nonZeroDigit.
nonZeroDigit                         = "(1-9)".
hexNumeral                           = "0x" hexDigit { hexDigit } | "0X" hexDigit { hexDigit }.
hexDigit                             = "(0-9a-fAF)".
octalNumeral                         = "0" octalDigit { octalDigit }.
octalDigit                           = "(0-7)".
characterLiteral                     = "'" singleCharacter "'" | "'" escapeSequence "'".
singleCharacter                      = inputCharacter - ("'" | "\" ).
stringLiteral                        = '"' { stringCharacter } '"'.
stringCharacter                      = escapeSequence | inputCharacter - ( '"' or '\').
escapeSequence                       = "\\" | "\'" | "\"" | "\n" | "\r" | "\t" | "\b" | "\f" | "\a".
keyword                              = "abstract" | "boolean" | "break" | "byte" | "case" | "catch" | "char" | "class" | "const" | "continue"
                                     | "default" | "do" | "double" | "else" | "extends" | "final" | "finally" | "float" | "for" | "goto"
                                     | "if" | "implements" | "import" | "instanceof" | "int" | "interface" | "long" | "native" | "new"
                                     | "package" | "private" | "protected" | "public" | "return" | "short" | "static" | "super" | "switch" | "synchronized"
                                     | "this" | "throw" | "throws" | "transient" | "try" | "void" | "volatile" | "while".'

### miscellaneous
This BNF definition does not describe whitespace and comments, which my be inserted between any terminal.

Java style end of line comment: //... comment
Java style multi-line comment: /*... comment ...*/

The character set for miniJava is standard 7-bit ASCII character set. This is the set denoted by *inputCharacter*.

An *inputCharacter* is a letter if the method Character.isJavaLetter returns true. 
An *inputCharacter* is digit if the method Character.isJaveDigit returns true. 
An *inputCharacter* is letter-or-digit if the method Character.isJaveLetterOrDigit returns true. 

An <identifier> may not be any of the keywords given above - these are reserved words in miniJava.

## Built in methods
'builtInMethods     = printlnStatement | outputStatement | sleepStatement | read | input.
printlnStatement   = "println" "(" expression ")".
outputStatement    = "output" "(" constantExpression "," expression ")".
sleepStatement     = "sleep" "(" expression ")".
read               = "read".
input              = "input" "(" constantExpression ")".'

## Semantics 
Multi-line comment may contain end of line comment.
Multi-line comment may not be nested.
The identifiers in a packageName must be in lower case.
TODO: reorder according to syntax definition above. 
A variable must be declared before it is used.
A function must be declared before it is used.
An executable program must contain a "void main()" function.
A declaration is valid within the scope within which it is defined (class, for statement, statement block) and it's sub-scopes.
The name of a valid declaration may only be declared once within its scope (overloading is not supported).
A variable declaration must include the datatype.
A variable of type byte takes one byte (8 bit).
A variable of type word takes two bytes (16 bit).
A variable of type byte has a range from 0 to 255.
A variable of type word has a range from 0 to 65535.
An expression is initially evaluated in the type of the first (left most) factor.
A constant has a type byte if the value is between 0 and 255.
A byte expression is promoted to a word expression if a right-hand factor requires so.
The read() function returns a word value.
In an addop, mulop or relop the type of the lefthand operand and the right hand operand must be the same.
The value of the lefthand operand of an addop, mulop or relop is changed from byte to word if the type of the righthand operand is a word.
In an assignment the value of a byte expression can be assigned to a word variable.
In an assignment the value of a word expression, assigned to a byte variable, will be truncated.
In an assignment a byte or word variable can be a (mutable) variable or a final variable (constant).
In an assignment a string variable is always implicitly a final variable (constant).
A string constant is enclosed between double quotes.
A string constant consists of a sequence of characters and/or escape sequences.
All ASCII printable characters are allowed, except \ (backslash) and " (double quote).
In a string constant the \ symbol is the escape token. Supported characters in escape sequences are:
- \\ backslash
- \' single quote
- \" double quote
- \n new line
- \r carriage return
- \t horizontal tab
- \b backspace
- \f form feed/new page
- \a alert/bell
The println statement makes a distinction between a string expression and an algorithmic expression.
-  An expression is a string expression if the leftmost operand is a string constant or the identifier of a string variable, otherwise it is an algorithmic expression.
-  In a println statement with a string expression, the subsequent operands may be added; other operators are not allowed.
-  However, subexpressions (expression between left ( and right ) parenthesis, may be string expressions or algorithmic expressions.
-  Operands in a string expression, including results of subexpressions, are converted to string and then printed.
The outputStatement accepts 2 byte value expressions, the port number and the value to be written to the port respectively.
The sleep statement lets the target program sleep for N milliseconds.
