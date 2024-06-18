# Syntax and semantics of the miniJava language.

## Extended BNF
The syntax is defined in extended BNF.
- A non-terminal is a plain text identifier, starting with a character, followed by characters or digits.
- Terminal symbols are between quotes (') or double quotes (").
- The optional appearance (zero or one instance) of a single construct X is written as X?.
- The optional appearance (zero or one instance) of the sequence of constructs X and Y is written [ X Y ].
- The iterative appearance (zero or more instances) of a single construct X is written as X*.
- The iterative appearance (zero or more instances) of the sequence of constructs X and Y is written { X Y }.
- Possible characters and digits are defined individually, such as "0", or as a range, such as "(1-9)".

## Limitations and extensions
Compared to an [original but not official Java syntax](see https://javacc.github.io/javacc/documentation/bnf.html),
the syntax of miniJava has the following limitations:
- CompilationUnit       single TypeDeclaration
- typeDeclaration:      no interface declaration or ";".
- classDeclaration:     no super?, interfaces?, extends?, TypeParameters? or implements?.
- modifiers:            no "abstract", "protected", "strictfp" or Annotation.
- EnumDeclaration       no ImplementsList?.
- EnumBody              no ( "," )?
- EnumConstant          no Modifiers, no ClassBody?
- ClassBodyDeclaration  no Initializer, no ClassDeclaration, no EnumDeclaration, no ConstructorDeclaration, no ";".
- ArrayInitializer      no ( "," )?.
- FieldDeclaration      static final is treated as compile time constant.
- FieldDeclaration      VariableDeclarator in a static final field must be a compile time resolvable constant expression.
- MethodDeclaration     no const in ResultType.
- MethodDeclaration     no empty block.
- MethodDeclaration     no TypeParameters, no "throws".
- MethodDeclarator      no [].
- FormalParameter       no "&", "*" or "...". 
- FormalParameter       possible modifiers: "final"?.
- ResultType            no "*" or "&"
- ReferenceType         no ClassOrInterfaceType.
- PrimitiveType         no "char" | "byte" | "short" | "int" | "long"
- PrimitiveType:        added "word" | "string"
- Statement             no LabeledStatement, AssertStatement, SwitchStatement, BreakStatement, ContinueStatement, ThrowStatement, SynchronizedStatement or TryStatement.
- LocalVarDecl					possible modifiers: "final"? "volatile"?.
- ForStatement          no for-each loop: for (type variableName : arrayName) {...}.
- PrimaryExpression     (as part of statementExpression) limited to Name | ( Name Arguments ) | ( Name { "[" Expression "]" } )

TODO:
- statementExpression:  no classInstanceCreationExpression.
- leftHandSide:         no fieldAccess or arrayAccess.
- relationalExpression: no "instanceof" referenceType.
- castPrefix:           no "(" referenceType ")".
- primary:              no arrayCreationExpression.
- primaryNoNewArray:    no classInstanceCreationExpression or arrayAccess.
- fieldAccess:          no "super" "." identifier.
- methodInvocation:     no primary "." identifier "(" argumentList? ")" or "super" "." identifier "(" argumentList? ")".
- literal:              no floatingPointLiteral, booleanLiteral or nullLiteral.
- decimalIntegerLiteral:no integerTypeSuffix.
- hexIntegerLiteral:    no integerTypeSuffix.
- octalIntegerLiteral:  no integerTypeSuffix.

## Syntax definition

### Programs
`compilationUnit      ::= packageDeclaration? importDeclaration* typeDeclaration.`

### Declarations
`packageDeclaration   ::= "package" name ";".`

`importDeclaration    ::= "import" "static"? name ["." "*"] ";".`

`typeDeclaration      ::= ";" | modifiers ( classDeclaration | enumDeclaration ).`

`classDeclaration     ::= "class" javaIdentifier classBody.`

`enumDeclaration      ::= "enum" javaIdentifier enumBody.`

###Modifiers
`modifiers            ::= "public"? "private"? "static"? "final"? "synchronized"? "native"? "transient"? "volatile"?.`

###Enum body
`enumBody             ::= "{" enumConstant { "," enumConstant } [ ";" classBodyDeclaration* ] "}".`

`enumConstant         ::= javaIdentifier arguments?.`

###Class body
`classBody            ::= "{" classBodyDeclaration* "}".`

`classBodyDeclaration ::= modifiers ( fieldDeclaration | methodDeclaration ).`

`fieldDeclaration     ::= type variableDeclarator { "," variableDeclarator } ";".`

`variableDeclarator   ::= variableDeclaratorId [ "=" variableInitializer ].`

`variableDeclaratorId ::= javaIdentifier { "[" "]" }.`

`variableInitializer  ::= arrayInitializer | expression.`

`arrayInitializer     ::= "{" [ variableInitializer { "," variableInitializer } ] "}".`

`methodDeclaration    ::= resultType methodDeclarator block.`

`methodDeclarator     ::= javaIdentifier formalParameters.`

`formalParameters     ::= "(" [ formalParameter { "," formalParameter } ] ")".`

`formalParameter      ::= modifiers type variableDeclaratorId.`

### Types
`resultType           ::= "void" | type.`

`type                 ::= referenceType | primitiveType.`

`referenceType        ::= primitiveType ( "[" "]" )+.`

`primitiveType        ::= "char" | "string" | "byte" | "word" | "short" | "int" | "long".`

`name                 ::= javaIdentifier { "." javaIdentifier }.`

##Statements

`block                    ::= "{" { blockStatement } "}".`

`blockStatement           ::= localVariableStatement | statement.`

`localVariableStatement   ::= localVariableDeclaration ";".`

`localVariableDeclaration ::= modifiers type variableDeclarator { "," variableDeclarator }.`

`statement                ::= ifStatement | statementExceptIf.`

`ifStatement              ::= "if" "(" expression ")" statementExceptIf ["else" statement].`

`statementExceptIf        ::= block | emptyStatement | whileStatement | doStatement | forStatement | returnStatement | expressionStatement.`

`emptyStatement           ::= ";".`

`whileStatement           ::= "while" "(" expression ")" statementExceptIf.`

`doStatement              ::= "do" statement "while" "(" expression ")" ";".`

`forStatement             ::= "for" "(" forInit? ";" expression? ";" forUpdate? ")" statementExceptIf.`
`forInit                  ::= localVariableDeclaration | statementExpressionList.`
`forUpdate                ::= statementExpressionList.`
`statementExpressionList  ::= statementExpression { "," statementExpression }.`

`returnStatement          ::= "return" expression? ";".`

`expressionStatement      ::= statementExpression ";".`

##Expressions

`statementExpression  ::= preincrementExpression | predecrementExpression | postincrementExpression | postdecrementExpression | methodInvocation | arraySelector | assignment.`

`preincrementExpression			::= "++" name.`

`predecrementExpression    ::= "--" name.`

`postincrementExpression   ::= name "++".`

`postdecrementExpression   ::= name "--".`

`methodInvocation          ::= name arguments.`

`arguments                 ::= "(" argumentList? ")".`

`argumentList              ::= expression { "," expression }.`

TODO
``

`arraySelector             ::= name { "[" Expression "]" }.`
`assignment                ::= name assignmentOperator expression.`

`constantExpression                   = expression.`

`JavaIdentifier                       = identifier.`

TODO
Expression

### Expressions

`expression                           = assignmentExpression.`

`assignmentExpression                 = assignment | conditionalExpression.`

`assignment                           = leftHandSide assignmentOperator assignmentExpression.`

`leftHandSide                         = expressionName.`

`assignmentOperator                   = "=" | "*=" | "/=" | "%=" | "+=" | "-=" | "<<=" | ">>=" | ">>>=" | "&=" | "^=" | "|=".`

`conditionalExpression                = conditionalOrExpression [ "?" expression ":" conditionalExpression ].`

`conditionalOrExpression              = conditionalAndExpression { "||" conditionalAndExpression }.`

`conditionalAndExpression             = inclusiveOrExpression { "&&" inclusiveOrExpression }.`

`inclusiveOrExpression                = exclusiveOrExpression { "|" exclusiveOrExpression }.`

`exclusiveOrExpression                = andExpression { "^" andExpression }.`

`andExpression                        = equalityExpression { "&" equalityExpression }.`

`equalityExpression                   = relationalExpression [ equalityOperator equalityExpression ].`

`equalityOperator                     = "==" | "!=".`

`relationalExpression                 = shiftExpression [ relationalOperator shiftExpression ].`

`relationalOperator                   = ">" | ">=" | "<" | "<=".`

`shiftExpression                      = additiveExpression [ shiftOperator additiveExpression].`

`shiftOperator                        = "<<" | ">>" | ">>>".`

`additiveExpression                   = multiplicativeExpression [ additiveOperator multiplicativeExpression ].`

`additiveOperator                     = "+" | "-".`

`multiplicativeExpression             = unaryExpression [ multiplicativeOperator unaryExpression ].`

`multiplicativeOperator               = "*" | "/" | "%".`

`unaryExpression                      = {unaryOperator} postfixExpression.`

`unaryOperator                        = "++" | "--" | "+" | "-" | "~" | "!" | castPrefix.`

`castPrefix                           = "(" primitiveType ")".`

`postfixExpression                    = postincrementExpression | postdecrementExpression | primary | expressionName.`

`postincrementExpression              = postfixExpression "++".`

`postdecrementExpression              = postfixExpression "--".`

`primary                              = primaryNoNewArray.`

`primaryNoNewArray                    = literal | "this" | "(" expression ")" | fieldAccess | methodInvocation.`

`fieldAccess                          = primary "." identifier.`

### Tokens
`packageName                          = identifier { "." identifier }.`

`expressionName                       = [ ambiguousName "." ] identifier.`

`methodName                           = [ ambiguousName "." ] identifier.`

`ambiguousName                        = identifier { "." identifier }.`

`literal                              = integerLiteral | characterLiteral | stringLiteral.`

`integerLiteral                       = decimalIntegerLiteral | hexIntegerLiteral | octalIntegerLiteral.`

`decimalIntegerLiteral                = decimalNumeral.`

`hexIntegerLiteral                    = hexNumeral.`

`octalIntegerLiteral                  = octalNumeral.`

`decimalNumeral                       = "0" | nonZeroDigit { digit }.`

`digit                                = "0" | nonZeroDigit.`

`nonZeroDigit                         = "(1-9)".`

`hexNumeral                           = "0x" hexDigit { hexDigit } | "0X" hexDigit { hexDigit }.`

`hexDigit                             = "(0-9a-fAF)".`

`octalNumeral                         = "0" octalDigit { octalDigit }.`

`octalDigit                           = "(0-7)".`

`characterLiteral                     = "'" singleCharacter "'" | "'" escapeSequence "'".`

`singleCharacter                      = inputCharacter - ("'" | "\" ).`

`stringLiteral                        = '"' { stringCharacter } '"'.`

`stringCharacter                      = escapeSequence | inputCharacter - ( '"' or '\').`

`escapeSequence                       = "\\" | "\'" | "\"" | "\n" | "\r" | "\t" | "\b" | "\f" | "\a".`

`keyword                              = "abstract" | "boolean" | "break" | "byte" | "case" | "catch" | "char" | "class"`

`                                     | "const" | "continue" | "default" | "do" | "double" | "else" | "extends"`

`                                     | "final" | "finally" | "float" | "for" | "goto" | "if" | "implements" | "import"`

`                                     | "instanceof" | "int" | "interface" | "long" | "native" | "new" | "package"`

`                                     | "private" | "protected" | "public" | "return" | "short" | "static" | "super"`

`                                     | "switch" | "synchronized" | "this" | "throw" | "throws" | "transient" | "try"`

`                                     | "void" | "volatile" | "while".`

### miscellaneous
This BNF definition does not describe whitespace and comments, which my be inserted between any terminal.

Java style end of line comment:` //... comment`

Java style multi-line comment:`  /*... comment ...*/`

The character set for miniJava is standard 7-bit ASCII character set. This is the set denoted by *inputCharacter*.

An *inputCharacter* is a letter if the method Character.isJavaLetter returns true. 

An *inputCharacter* is digit if the method Character.isJaveDigit returns true. 

An *inputCharacter* is letter-or-digit if the method Character.isJaveLetterOrDigit returns true. 

An <identifier> may not be any of the keywords given above - these are reserved words in miniJava.

## Built in methods
`builtInMethods     = printlnStatement | outputStatement | sleepStatement | read | input.`

`printlnStatement   = "println" "(" expression ")".`

`outputStatement    = "output" "(" constantExpression "," expression ")".`

`sleepStatement     = "sleep" "(" expression ")".`

`read               = "read".`

`input              = "input" "(" constantExpression ")".`

## Semantics

### Comments
Multi-line comment may contain end of line comment.

Multi-line comment may not be nested.

### Package
Modifiers in a package declaration are not supported (their purpose could not be found).

The identifiers in a packageName must be lowerCamelCase.

### Import
Modifiers in an import statement may only be: "static"?.

### Class
Modifiers in a class declaration may only be: "public". Default is none, i.e. the class is only accessible by classes or enums in the same package.

No inheritance, so no abstract or final modifier.

Class name must be UpperCamelCase and equal to the filename (except for the file extension).

No inheritance, so no extends.

No interfaces, so no implements.

No class instantiation, so no ConstructorDeclaration.

An executable class (program or application) must contain a "void main()" method.

### Enum
Modifiers in an enum declaration may only be: "public". Default is none, i.e. the enum is only accessible by classes or enums in the same package.

### Fields (member variables)
Modifier "static" is mandatory (no class instantiation).

Modifiers in a field declaration may be: "public", "private", "final" or "volatile".

### Methods
Modifier "static" is mandatory (no class instantiation).

Modifiers in a method declaration may be: "public", "private" or "synchronized".

Method name must be lowerCamelCase.

TODO: reorder according to syntax definition above. 

A field must be declared before it is used.

A method must be declared before it is used.

A declaration is valid within the scope within which it is defined (class, for statement, statement block) and it's sub-scopes.

The name of a valid declaration may only be declared once within its scope (overloading is not supported).

A variable declaration must include the datatype.

A variable of type byte takes one byte (8 bit) in memory.

A variable of type word takes two bytes (16 bit) in memory.

A variable of type byte is an unsigned integer number with a range from 0 to 255.

A variable of type word is an unsigned integer number with a range from 0 to 65535.

An expression is initially evaluated in the type of the first (left most) factor.

A constant has a type byte if the value is between 0 and 255.

A byte expression is promoted to a word expression if a right-hand factor requires so.

The read() function returns a word value.

The type of the lefthand operand of an addop, mulop or relop is changed from byte to word if the type of the righthand operand is a word.

In an assignment the value of a byte expression can be assigned to a word variable.

In an assignment the value of a word expression, assigned to a byte variable, will be truncated.

In an assignment a byte or word variable can be a (mutable) variable or a final variable (constant).

In an assignment a string variable is always implicitly a final variable (constant).

A string constant is enclosed between double quotes.

A string constant consists of a sequence of characters and/or escape sequences.
All ASCII printable characters are allowed, except \ (backslash) and " (double quote).

In a string constant the \ symbol is the escape token. Supported characters in escape sequences are:
- \\\\ backslash
- \\' single quote
- \\" double quote
- \n new line
- \r carriage return
- \t horizontal tab
- \b backspace
- \f form feed/new page
- \a alert/bell

The println statement makes a distinction between a string expression and an algorithmic expression.
-  An expression is a string expression if the leftmost operand is a string constant or a string variable; otherwise it is an algorithmic expression.
-  In a println statement with a string expression, the subsequent operands may be added (concatenated); other operators are not allowed.
-  However, subexpressions (expression between left ( and right ) parenthesis, may be string expressions or algorithmic expressions.
-  Operands in a string expression, including results of subexpressions, are converted to string and then concatenated (printed).

The outputStatement accepts 2 byte value expressions, the port number and the value to be written to the port respectively.

The sleep statement lets the target program sleep for N milliseconds.

A sub-statement may be a block of statements or a single statement but not an if-statement in case of:  
* the 'then' sub-statement of an if statement,
* the sub-statement of a whileStatement,
* the sub-statement of a forStatement.
As a consequence the 'NoShortIf' variants from the original Java syntax are not supported.

As a consequence, for example, the following Java code is not allowed:
`if (x > 0) if (x < 10) flag = true; else flag = false;`

An alternative is to use a block instead of a single statement:
`if (x > 0) { if (x < 10) flag = true else flag = false; };`

The shorter version:
`if (x > 0) if (x < 10) flag = true;`

could be replaced by either:
`if (x > 0) { if (x < 10) flag = true; };`

or:
`if (x > 0 && x < 10) flag = true; };`

## Open issues:
1. classBodyDeclaration with or without staticInitializer?
