/*
Copyright © 2023 Han Welmer.

This file is part of Z80Compiler.

Z80Compiler is free software: you can redistribute it and/or modify it under 
the terms of the GNU General Public License as published by the Free Software 
Foundation, either version 3 of the License, or (at your option) any later 
version.

Z80Compiler is distributed in the hope that it will be useful, but WITHOUT 
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with 
Z80Compiler. If not, see <https://www.gnu.org/licenses/>.
*/

package com.github.HanWelmer;

import java.util.ArrayList;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

//TODO implement importDeclaration
//TODO implement typeDeclaration
//TODO implement classDeclaration
//TODO implement semantic analysis of packageDeclaration
//TODO implement semantic analysis of importDeclaration
//TODO implement void methodDeclaration (parameter less; no global/local variables).
//TODO implement void methodDeclaration (no global/local variables).
//TODO Add global variable to function.
//TODO Add local variable to function.
//TODO Add 'static' qualifier to global variables.
//TODO Add non-constant port value to output/input (IN0 A,(C); OUT0 (C),A).
//TODO Introduce built in function malloc() (see test1, test5, test10, test11).
//TODO Refactor StringConstants.
//TODO Fix runtime error: too many variables
//TODO Add support for input data (see Z80Compiler.class; call to Interpreter).
//TODO Merge comparison with expression.
//TODO Add bitwise NOT.
//TODO Add logical OR, XOR and AND.
//TODO Add logical NOT.
//TODO Implement constantExpression.
//TODO Allow algorithmic expression as value for 'final' qualifier. See test13.j.
//TODO Test various expressions for output(byte port, byte value). See ledtest.j.
//TODO Generate constant in Z80 code in hex notation if the constant was written in hex notation in J-code. See ledtest.j.

/* comments to be distributed over the parser methods.
 *
 * classBody                            = "{" { classBodyDeclaration } "}".
 * classBodyDeclaration                 = classMemberDeclaration | staticInitializer.
 * classMemberDeclaration               = fieldDeclaration | methodDeclaration.
 * staticInitializer                    = "static" block.
 * fieldDeclaration                     = { fieldModifier } type variableDeclarators ";".
 * fieldModifier                        = "public" | "private" | "final".
 * methodDeclaration                    = methodHeader methodBody.
 * methodHeader                         = { methodModifier } resultType methodDeclarator.
 * methodModifier                       = "public" | "private".
 * resultType                           = type | "void".
 * methodDeclarator                     = identifier "(" formalParameterList? ")".
 * formalParameterList                  = formalParameter {"," formalParameter}.
 * formalParameter                      = type variableDeclaratorId.
 * methodBody                           = block | ";".
 * block                                = "{" { blockStatement } "}".
 * blockStatement                       = localVariableDeclarationStatement | statement.
 * localVariableDeclarationStatement    = localVariableDeclaration ";".
 * localVariableDeclaration             = type variableDeclarators.
 * type                                 = primitiveType.
 * primitiveType                        = numericType.
 * numericType                          = integralType.
 * integralType                         = "byte" | "word".
 * variableDeclarators                  = variableDeclarator {"," variableDeclarator}.
 * variableDeclarator                   = variableDeclaratorId ["=" variableInitializer].
 * variableDeclaratorId                 = identifier.
 * variableInitializer                  = expression.
 * statement                            = statementExceptIf | ifStatement
 * statementExceptIf                    = statementWithoutTrailingSubstatement | whileStatement | forStatement.
 * statementWithoutTrailingSubstatement = block | emptyStatement | expressionStatement | doStatement | returnStatement.
 * emptyStatement                       = ";".
 * expressionStatement                  = statementExpression ";".
 * statementExpression                  = assignment | preincrementExpression | postincrementExpression | predecrementExpression | postdecrementExpression | methodInvocation.
 * preincrementExpression               = "++" unaryExpression.
 * predecrementExpression               = "--" unaryExpression.
 * doStatement                          = "do" statement "while" "(" expression ")" ";".
 * returnStatement                      = "return" expression? ";".
 * whileStatement                       = "while" "(" expression ")" statementExceptIf.
 * forStatement                         = "for" "(" forInit? ";" expression? ";" forUpdate? ")" statementExceptIf.
 * forInit                              = statementExpressionList | localVariableDeclaration.
 * forUpdate                            = statementExpressionList.
 * statementExpressionList              = statementExpression {"," statementExpression}.
 * ifStatement                          = "if" "(" expression ")" statementExceptIf ["else" statement].
 * constantExpression                   = expression.
 * expression                           = assignmentExpression.
 * assignmentExpression                 = assignment | conditionalExpression.
 * assignment                           = leftHandSide assignmentOperator assignmentExpression.
 * leftHandSide                         = expressionName.
 * assignmentOperator                   = "=" | "*=" | "/=" | "%=" | "+=" | "-=" | "<<=" | ">>=" | ">>>=" | "&=" | "^=" | "|=".
 * conditionalExpression                = conditionalOrExpression [ "?" expression ":" conditionalExpression ].
 * conditionalOrExpression              = conditionalAndExpression { "||" conditionalAndExpression }.
 * conditionalAndExpression             = inclusiveOrExpression { "&&" inclusiveOrExpression }.
 * inclusiveOrExpression                = exclusiveOrExpression { "|" exclusiveOrExpression }.
 * exclusiveOrExpression                = andExpression { "^" andExpression }.
 * andExpression                        = equalityExpression { "&" equalityExpression }.
 * equalityExpression                   = relationalExpression [ equalityOperator equalityExpression ].
 * equalityOperator                     = "==" | "!=".
 * relationalExpression                 = shiftExpression [ relationalOperator shiftExpression ].
 * relationalOperator                   = ">" | ">=" | "<" | "<=".
 * shiftExpression                      = additiveExpression [ shiftOperator additiveExpression].
 * shiftOperator                        = "<<" | ">>" | ">>>".
 * additiveExpression                   = multiplicativeExpression [ additiveOperator multiplicativeExpression ].
 * additiveOperator                     = "+" | "-".
 * multiplicativeExpression             = unaryExpression [ multiplicativeOperator unaryExpression ].
 * multiplicativeOperator               = "*" | "/" | "%".
 * unaryExpression                      = {unaryOperator} postfixExpression.
 * unaryOperator                        = "++" | "--" | "+" | "-" | "~" | "!" | castPrefix.
 * castPrefix                           = "(" primitiveType ")".
 * postfixExpression                    = postincrementExpression | postdecrementExpression | primary | expressionName.
 * postincrementExpression              = postfixExpression "++".
 * postdecrementExpression              = postfixExpression "--".
 * primary                              = primaryNoNewArray.
 * primaryNoNewArray                    = literal | "this" | "(" expression ")" | fieldAccess | methodInvocation.
 * fieldAccess                          = primary "." identifier.
 * methodInvocation                     = methodName "(" argumentList? ")".
 * argumentList                         = expression { "," expression }.
 * expressionName                       = [ ambiguousName "." ] identifier.
 * methodName                           = [ ambiguousName "." ] identifier.
 * ambiguousName                        = identifier { "." identifier }.
 * literal                              = integerLiteral | characterLiteral | stringLiteral.
 * integerLiteral                       = decimalIntegerLiteral | hexIntegerLiteral | octalIntegerLiteral.
 * decimalIntegerLiteral                = decimalNumeral.
 * hexIntegerLiteral                    = hexNumeral.
 * octalIntegerLiteral                  = octalNumeral.
 * decimalNumeral                       = "0" | nonZeroDigit { digit }.
 * digit                                = "0" | nonZeroDigit.
 * nonZeroDigit                         = "(1-9)".
 * hexNumeral                           = "0x" hexDigit { hexDigit } | "0X" hexDigit { hexDigit }.
 * hexDigit                             = "(0-9a-fAF)".
 * octalNumeral                         = "0" octalDigit { octalDigit }.
 * octalDigit                           = "(0-7)".
 * characterLiteral                     = "'" singleCharacter "'" | "'" escapeSequence "'".
 * singleCharacter                      = inputCharacter - ("'" | "\" ).
 * stringLiteral                        = '"' { stringCharacter } '"'.
 * stringCharacter                      = escapeSequence | inputCharacter - ( '"' or '\').
 * escapeSequence                       = "\\" | "\'" | "\"" | "\n" | "\r" | "\t" | "\b" | "\f" | "\a".
 * keyword                              = "abstract" | "boolean" | "break" | "byte" | "case" | "catch" | "char" | "class" | "const" | "continue"
                                        | "default" | "do" | "double" | "else" | "extends" | "final" | "finally" | "float" | "for" | "goto"
                                        | "if" | "implements" | "import" | "instanceof" | "int" | "interface" | "long" | "native" | "new"
                                        | "package" | "private" | "protected" | "public" | "return" | "short" | "static" | "super" | "switch" | "synchronized"
                                        | "this" | "throw" | "throws" | "transient" | "try" | "void" | "volatile" | "while".
 */

/*
* pCompiler; main class for the recursive descent miniJava compiler.
*
* Inspired by the book Compiler Engineering Using Pascal by P.C. Capon and P.J. Jinks
* and of course Java as developed by Sun.
*
* The currently supported syntax may deviate from the intended definition in syntax.md, 
* as can be seen in the comment lines before any each parser method.
*/
public class pCompiler {
  /* global variables used by the constructor or the interface functions */
  private boolean debugMode;
  private boolean verboseMode;
  private LexemeReader lexemeReader;
  private ArrayList<Instruction> instructions = new ArrayList<Instruction>();

  // constructor
  public pCompiler(boolean debugMode, boolean verboseMode) {
    this.debugMode = debugMode;
    this.verboseMode = verboseMode;
  }

  /**************************************
   *
   * lexical analysis and support methods
   *
   *************************************/

  public ArrayList<Instruction> compile(LexemeReader lexemeReader) {
    this.lexemeReader = lexemeReader;
    if (verboseMode)
      System.out.println("compiling in debugMode = " + debugMode);

    try {
      init();
      compilationUnit();
      plant(new Instruction(FunctionType.stop));
      debug("\n");
      optimize();
      updateReferencesToStringConstants(instructions.size());
      plantStringConstants();
    } catch (FatalError e) {
      error(e.getErrorNumber());
      System.exit(1);
    }

    if (errors != 0) {
      instructions.clear();
    }
    if (verboseMode || (errors != 0)) {
      System.out.println();
      System.out.print(errors);
      if (errors == 1) {
        System.out.println(" error.");
      } else {
        System.out.println(" errors.");
      }
    }
    return instructions;
  }

  private void debug(String message) {
    if (debugMode) {
      System.out.print(message);
    }
  }

  /*
   * variable containing the branch instructions known by the M machine as
   * generated by the P language. variable used during the code generation
   * phase.
   */
  public EnumSet<FunctionType> brFunctions = EnumSet.of(FunctionType.br, FunctionType.brEq, FunctionType.brNe, FunctionType.brLt,
      FunctionType.brLe, FunctionType.brGt, FunctionType.brGe);

  /* Constants and class member variables for lexical analysis phase */
  private ArrayList<String> sourceCode;
  private int lastSourceLineNr = 0;
  private Lexeme lexeme;
  // Lexeme types in an expression in increasing order of precedence.
  private LexemeType[] lexemeTypeAtLevel = { LexemeType.bitwiseOrOp, LexemeType.bitwiseXorOp, LexemeType.bitwiseAndOp,
      LexemeType.addop, LexemeType.mulop };
  private int errors;

  /* Constants and class member variables for syntax analysis phase */
  private EnumSet<LexemeType> startStatement = EnumSet.of(LexemeType.finalLexeme, LexemeType.identifier, LexemeType.byteLexeme,
      LexemeType.wordLexeme, LexemeType.stringLexeme, LexemeType.printlnLexeme, LexemeType.ifLexeme, LexemeType.forLexeme,
      LexemeType.doLexeme, LexemeType.whileLexeme, LexemeType.outputLexeme, LexemeType.sleepLexeme);
  private EnumSet<LexemeType> startAssignment = EnumSet.of(LexemeType.finalLexeme, LexemeType.identifier, LexemeType.byteLexeme,
      LexemeType.wordLexeme, LexemeType.stringLexeme);
  private EnumSet<LexemeType> startExp = EnumSet.of(LexemeType.lbracket, LexemeType.identifier, LexemeType.constant,
      LexemeType.stringConstant, LexemeType.inputLexeme, LexemeType.readLexeme);

  /* Constants and class member variables for semantic analysis phase */
  private String packageName;
  private Identifiers identifiers = new Identifiers();
  private StringConstants stringConstants = new StringConstants();

  /* Constants and class member variables for code generation phase */
  private static final String LINE_NR_FORMAT = "%4d ";
  private static final int MAX_M_CODE = 10000;
  private Accumulator acc16 = new Accumulator();
  private Accumulator acc8 = new Accumulator();
  private Stack<Datatype> stackedDatatypes = new Stack<Datatype>();

  private Map<OperatorType, FunctionType> forwardOperation16 = new HashMap<OperatorType, FunctionType>();
  private Map<OperatorType, FunctionType> reverseOperation16 = new HashMap<OperatorType, FunctionType>();
  private Map<OperatorType, FunctionType> forwardOperation8 = new HashMap<OperatorType, FunctionType>();
  private Map<OperatorType, FunctionType> reverseOperation8 = new HashMap<OperatorType, FunctionType>();

  private Map<OperatorType, FunctionType> normalSkip = new HashMap<OperatorType, FunctionType>();
  private Map<OperatorType, FunctionType> reverseSkip = new HashMap<OperatorType, FunctionType>();

  /* Class member methods for all phases */
  private void init() {
    /* initialisation of lexical analysis variables */
    sourceCode = new ArrayList<String>();
    lastSourceLineNr = 0;
    errors = 0;
    lexeme = new Lexeme(LexemeType.unknown);

    /* initialisation of syntax analysis variables */

    /* initialisation of semantic analysis variables */
    packageName = "";
    identifiers.init();
    stringConstants.init();

    /* initialisation of code generation variables */
    acc16.clear();
    acc8.clear();
    stackedDatatypes.clear();

    forwardOperation16.clear();
    reverseOperation16.clear();

    forwardOperation8.clear();
    reverseOperation8.clear();

    normalSkip.clear();
    reverseSkip.clear();
    instructions.clear();

    forwardOperation16.put(OperatorType.bitwiseOr, FunctionType.acc16Or);
    forwardOperation16.put(OperatorType.bitwiseXor, FunctionType.acc16Xor);
    forwardOperation16.put(OperatorType.bitwiseAnd, FunctionType.acc16And);
    forwardOperation16.put(OperatorType.add, FunctionType.acc16Plus);
    forwardOperation16.put(OperatorType.sub, FunctionType.acc16Minus);
    forwardOperation16.put(OperatorType.mul, FunctionType.acc16Times);
    forwardOperation16.put(OperatorType.div, FunctionType.acc16Div);

    reverseOperation16.put(OperatorType.bitwiseOr, FunctionType.acc16Or);
    reverseOperation16.put(OperatorType.bitwiseXor, FunctionType.acc16Xor);
    reverseOperation16.put(OperatorType.bitwiseAnd, FunctionType.acc16And);
    reverseOperation16.put(OperatorType.add, FunctionType.acc16Plus);
    reverseOperation16.put(OperatorType.sub, FunctionType.minusAcc16);
    reverseOperation16.put(OperatorType.mul, FunctionType.acc16Times);
    reverseOperation16.put(OperatorType.div, FunctionType.divAcc16);

    forwardOperation8.put(OperatorType.bitwiseOr, FunctionType.acc8Or);
    forwardOperation8.put(OperatorType.bitwiseXor, FunctionType.acc8Xor);
    forwardOperation8.put(OperatorType.bitwiseAnd, FunctionType.acc8And);
    forwardOperation8.put(OperatorType.add, FunctionType.acc8Plus);
    forwardOperation8.put(OperatorType.sub, FunctionType.acc8Minus);
    forwardOperation8.put(OperatorType.mul, FunctionType.acc8Times);
    forwardOperation8.put(OperatorType.div, FunctionType.acc8Div);

    reverseOperation8.put(OperatorType.bitwiseOr, FunctionType.acc8Or);
    reverseOperation8.put(OperatorType.bitwiseXor, FunctionType.acc8Xor);
    reverseOperation8.put(OperatorType.bitwiseAnd, FunctionType.acc8And);
    reverseOperation8.put(OperatorType.add, FunctionType.acc8Plus);
    reverseOperation8.put(OperatorType.sub, FunctionType.minusAcc8);
    reverseOperation8.put(OperatorType.mul, FunctionType.acc8Times);
    reverseOperation8.put(OperatorType.div, FunctionType.divAcc8);

    normalSkip.put(OperatorType.eq, FunctionType.brNe);
    normalSkip.put(OperatorType.ne, FunctionType.brEq);
    normalSkip.put(OperatorType.gt, FunctionType.brLe);
    normalSkip.put(OperatorType.lt, FunctionType.brGe);
    normalSkip.put(OperatorType.ge, FunctionType.brLt);
    normalSkip.put(OperatorType.le, FunctionType.brGt);
    reverseSkip.put(OperatorType.eq, FunctionType.brNe);
    reverseSkip.put(OperatorType.ne, FunctionType.brEq);
    reverseSkip.put(OperatorType.gt, FunctionType.brGe);
    reverseSkip.put(OperatorType.lt, FunctionType.brLe);
    reverseSkip.put(OperatorType.ge, FunctionType.brGt);
    reverseSkip.put(OperatorType.le, FunctionType.brLt);
  }

  private void error() {
    errors++;
    lexemeReader.error();
  }

  private void error(int n) {
    error();
    switch (n) {
      case 0:
        System.out.println("error opening source code file");
        break;
      case 1:
        System.out.println("end of input encountered");
        break;
      case 2:
        System.out.println("line too long");
        break;
      case 3:
        System.out.print("unexpected symbol;");
        break;
      case 4:
        System.out.println("unknown character");
        break;
      case 5:
        System.out.println("'=' expected after '=' or '!' ");
        break;
      case 6:
        System.out.print("unknown keyword : ");
        break;
      case 7:
        System.out.println("lexeme skipped after error");
        break;
      case 8:
        System.out.println("variable already declared");
        break;
      case 9:
        System.out.println("variable not declared");
        break;
      case 10:
        System.out.println("code overflow");
        break;
      case 11:
        System.out.println("lexemetype is null");
        break;
      case 12:
        System.out.println("internal compiler error during code generation");
        break;
      case 13:
        System.out.println("constant too big");
        break;
      case 14:
        System.out.println("incompatible datatype between assignment variable and expression");
        break;
      case 15:
        System.out.println("incompatible datatype in println statement");
        break;
      case 16:
        System.out.println("port expression must be a constant or a final variable");
        break;
      case 17:
        System.out.println("final variable must be a byte or a word");
        break;
      case 18:
        System.out.println("datatype must be byte or word");
        break;
      case 19:
        System.out.println("source code file is not located in path defined by package name");
        break;
    }
  }

  /*************************
   *
   * syntax analysis methods
   *
   ************************/

  // return true if current lexeme is in okSet, otherwise skip lexemes until
  // current lexeme is in stopSet and return false.
  private boolean checkOrSkip(EnumSet<LexemeType> okSet, EnumSet<LexemeType> stopSet) throws FatalError {
    // debug("\ncheckOrSkip: start");
    boolean result = false;
    if (okSet.contains(lexeme.type)) {
      // debug("\ncheckOrSkip: lexeme \"" + lexeme.type + "\" in okSet " +
      // okSet);
      result = true;
    } else {
      error(3); /* okset expected */
      System.out.println(" found " + lexeme.type + ", expected " + okSet);
      if (stopSet.size() > 0) {
        while (!stopSet.contains(lexeme.type)) {
          error(7); /* lexeme skipped after error */
          lexeme = lexemeReader.getLexeme(sourceCode);
        }
      }
    }
    // debug("\ncheckOrSkip: end");
    return result;
  }

  // compilationUnit = packageDeclaration? { importDeclaration }
  // typeDeclaration.
  private void compilationUnit() throws FatalError {
    debug("\ncompilationUnit: start");

    // recognise an optional package declaration.
    lexeme = lexemeReader.getLexeme(sourceCode);
    if (lexeme.type == LexemeType.packageLexeme) {
      packageDeclaration();
    }

    // recognise an optional list of import declaration.
    if (lexeme.type == LexemeType.importLexeme) {
      importDeclaration();
    }

    // recognise the mandatory single type declaration.
    typeDeclaration();

    debug("\ncompilationUnit: end");
  } // compilationUnit

  // packageDeclaration = "package" packageName ";".
  // packageName = identifier { "." identifier }.
  private void packageDeclaration() throws FatalError {
    debug("\npackageDeclaration: start");

    // skip "package".
    lexeme = lexemeReader.getLexeme(sourceCode);

    // recognise identifier.
    EnumSet<LexemeType> stopSet = EnumSet.of(LexemeType.semicolon, LexemeType.importLexeme, LexemeType.publicLexeme,
        LexemeType.classLexeme);
    if (checkOrSkip(EnumSet.of(LexemeType.identifier), stopSet)) {
      String temp = lexeme.idVal;
      lexeme = lexemeReader.getLexeme(sourceCode);

      // recognise { "." identifier }.
      while (lexeme.type == LexemeType.period) {
        // skip ".".
        lexeme = lexemeReader.getLexeme(sourceCode);
        temp += ".";

        // recognise the identifier lexeme.
        if (checkOrSkip(EnumSet.of(LexemeType.identifier), stopSet)) {
          temp += lexeme.idVal;
          lexeme = lexemeReader.getLexeme(sourceCode);
        }
      }

      if (lexeme.type == LexemeType.semicolon) {
        packageName = temp;
        debug("\npackageDeclaration: packageName=" + packageName);

        // semantic analysis: source file must reside in folder (tree) defined
        // by packageName.
        /*
         * TODO: add semantic analysis if
         * (!lexemeReader.getPath().endsWith(temp.replace(".", "/"))) {
         * error(19); }
         */
      }
    }

    // recognise the semicolon lexeme.
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon),
        EnumSet.of(LexemeType.importLexeme, LexemeType.publicLexeme, LexemeType.classLexeme))) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\npackageDeclaration: end; packageName=" + packageName);
  } // packageDeclaration

  // importDeclaration = "import" packageName "." importType ";".
  // packageName = identifier { "." identifier }.
  private void importDeclaration() throws FatalError {
    debug("\nimportDeclaration: start");

    // skip "import"
    lexeme = lexemeReader.getLexeme(sourceCode);

    debug("\nimportDeclaration: end");
  } // importDeclaration

  /*
   * TODO complete me // importType = identifier | "*". private void
   * importType() throws FatalError { debug("\nimportType: start");
   * debug("\nimportType: end"); } //importType
   */

  // typeDeclaration = classDeclaration.
  private void typeDeclaration() throws FatalError {
    debug("\ntypeDeclaration: start");

    classDeclaration();

    debug("\ntypeDeclaration: end");
  } // typeDeclaration

  // TODO reorder methods below.

  // classDeclaration = classModifier "class" identifier classBody.
  // classModifier = "public".
  // TODO old: program = "class" identifier "{" statements "}".
  private void classDeclaration() throws FatalError {
    debug("\nclassDeclaration: start");

    // recognise a class definition.
    if (checkOrSkip(EnumSet.of(LexemeType.classLexeme), EnumSet.of(LexemeType.identifier, LexemeType.beginLexeme))) {
      lexeme = lexemeReader.getLexeme(sourceCode);

      // part of semantic analysis: start a new class level declaration scope.
      identifiers.newScope();

      if (checkOrSkip(EnumSet.of(LexemeType.identifier), EnumSet.of(LexemeType.beginLexeme))) {
        /* next line + debug message is part of semantic analysis */
        if (identifiers.checkId(lexeme.idVal)) {
          error(8); /* variable already declared */
        } else if (identifiers.declareId(lexeme, LexemeType.classLexeme)) {
          debug("\nclassDeclaration: class declared: " + lexeme.idVal);
        } else {
          error();
          System.out.println("Error declaring variable " + lexeme.idVal + " as a class.");
        }

        lexeme = lexemeReader.getLexeme(sourceCode);
        checkOrSkip(EnumSet.of(LexemeType.beginLexeme), EnumSet.noneOf(LexemeType.class));

        lexeme = lexemeReader.getLexeme(sourceCode);
        statements(EnumSet.of(LexemeType.endLexeme));

        // lexeme = lexemeReader.getLexeme(sourceCode);
        checkOrSkip(EnumSet.of(LexemeType.endLexeme), EnumSet.noneOf(LexemeType.class));
      }

      // part of semantic analysis: close the class level declaration scope.
      identifiers.closeScope();
    }
    debug("\nclassDeclaration: end");
  } // classDeclaration

  // constantExpression = constant | {addop constant}.
  private Operand constantExpression(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nconstantExpression: start with stopSet = " + stopSet);

    // part of lexical analysis.
    Operand port = factor(stopSet);

    // part of semantic analysis.
    debug("\nconstantExpression: port = " + port + ", final = " + port.isFinal + ", acc16InUse = " + acc16.inUse()
        + ", acc8InUse = " + acc8.inUse());
    // port must be a constant or a final variable
    // convert port operand from final var to constant.
    if (port.opType == OperandType.var && port.isFinal) {
      port = new Operand(OperandType.constant, port.datatype, identifiers.getId(port.strValue).getIntValue());
    }
    if (port.opType != OperandType.constant) {
      error(16);
    }

    debug("\nconstantExpression: end");
    return port;
  } // constantExpression()

  // inputFactor = "input" "(" constantExpression ")".
  private Operand inputFactor(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\ninputFactor: start with stopSet = " + stopSet);

    // part of lexical analysis.
    // skip input symbol.
    lexeme = lexemeReader.getLexeme(sourceCode);

    EnumSet<LexemeType> stopInputSet = stopSet.clone();
    stopInputSet.addAll(startExp);
    stopInputSet.add(LexemeType.rbracket);
    stopInputSet.add(LexemeType.semicolon);

    // skip left bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.lbracket), stopInputSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // part of code generation.
    if (acc8.inUse()) {
      plant(new Instruction(FunctionType.stackAcc8));
    }

    // read constant expression.
    Operand port = constantExpression(stopInputSet);

    // skip right bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopInputSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // part of semantic analysis.
    debug("\ninputFactor: port = " + port + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());

    // part of code generation.
    plant(new Instruction(FunctionType.input, port));
    // The input() function always returns a byte value.
    Operand operand = new Operand(OperandType.acc);
    operand.datatype = Datatype.byt;
    acc8.setOperand(operand);

    debug("\ninputFactor: end");
    return operand;
  } // inputFactor

  // factor = identifier | constant | stringConstant | "read" | "inputFactor" |
  // "(" expression ")".
  private Operand factor(EnumSet<LexemeType> stopSet) throws FatalError {
    Operand operand = new Operand(OperandType.unknown);
    debug("\nfactor 1: acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    if (checkOrSkip(startExp, stopSet)) {
      if (lexeme.type == LexemeType.identifier) {
        // part of semantic analysis.
        if (!identifiers.checkId(lexeme.idVal))
          error(9); /* variable not declared */
        // part of code generation.
        Variable var = identifiers.getId(lexeme.idVal);
        // treat final var as a constant
        if (var.isFinal()) {
          operand.opType = OperandType.constant;
          operand.intValue = var.getIntValue();
        } else {
          operand.opType = OperandType.var;
          operand.intValue = var.getAddress();
        }
        operand.datatype = var.getDatatype();
        operand.isFinal = var.isFinal();
        operand.strValue = lexeme.idVal;
        // part of lexical analysis.
        lexeme = lexemeReader.getLexeme(sourceCode);
      } else if (lexeme.type == LexemeType.constant) {
        // part of code generation.
        operand.opType = OperandType.constant;
        operand.datatype = lexeme.datatype;
        operand.intValue = lexeme.constVal;
        // part of lexical analysis.
        lexeme = lexemeReader.getLexeme(sourceCode);
      } else if (lexeme.type == LexemeType.stringConstant) {
        debug("\nlexeme = " + lexeme.makeString(null));
        // part of semantic analysis.
        int constantId = stringConstants.add(lexeme.stringVal, instructions.size() + 1);
        debug("\nfactor: string constant " + constantId + " = \"" + lexeme.stringVal + "\"");
        // part of code generation.
        operand.opType = OperandType.constant;
        operand.datatype = Datatype.string;
        operand.strValue = lexeme.stringVal;
        operand.intValue = constantId;
        // part of lexical analysis.
        lexeme = lexemeReader.getLexeme(sourceCode);
        debug("\nlexeme = " + lexeme.makeString(null));
      } else if (lexeme.type == LexemeType.readLexeme) {
        lexeme = lexemeReader.getLexeme(sourceCode);
        // part of code generation.
        // The read() function always returns a word value.
        if (acc16.inUse()) {
          plant(new Instruction(FunctionType.stackAcc16));
        }
        plant(new Instruction(FunctionType.read));
        operand.opType = OperandType.acc;
        operand.datatype = Datatype.word;
        acc16.setOperand(operand);
      } else if (lexeme.type == LexemeType.inputLexeme) {
        operand = inputFactor(stopSet);
      } else if (lexeme.type == LexemeType.lbracket) {
        // skip left bracket.
        lexeme = lexemeReader.getLexeme(sourceCode);
        EnumSet<LexemeType> stopSetCopy = stopSet.clone();
        stopSetCopy.add(LexemeType.rbracket);
        operand = expression(stopSetCopy);
        // skip right bracket.
        if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopSet)) {
          lexeme = lexemeReader.getLexeme(sourceCode);
        }
      }
    }

    // consistency check.
    debug("\nfactor: end: " + operand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    if (operand.opType == OperandType.unknown) {
      throw new FatalError(12);
    }

    return operand;
  } // factor()

  // expression = xorTerm {bitwiseOrOp xorTerm}.
  // xorTerm = andTerm {bitwiseXorOp andTerm}
  // andTerm = addTerm {bitwiseAndOp addTerm}.
  // addTerm = term {addop term}.
  // term = factor {mulop factor}.
  private Operand expression(EnumSet<LexemeType> stopSet) throws FatalError {
    // start with lexeme type of lowest precedence.
    return term(0, stopSet);
  }

  // Parse a term, as part of an expression, at a given precendence level.
  private Operand term(int level, EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nterm start: level = " + level + ", stopSet = " + stopSet);

    // part of lexical analysis.
    EnumSet<LexemeType> followSet = stopSet.clone();
    followSet.add(lexemeTypeAtLevel[level]);
    Operand leftOperand = (level == lexemeTypeAtLevel.length - 1) ? factor(followSet) : term(level + 1, followSet);

    leftOperand = termWithOperand(level, leftOperand, followSet);
    debug("\nterm: end");
    return leftOperand;
  } // term()

  // Parse a term, as part of an expression, at a given precendence level, given
  // an already parsed left operand.
  private Operand termWithOperand(int level, Operand leftOperand, EnumSet<LexemeType> followSet) throws FatalError {
    debug("\ntermWithOperand start: level = " + level + ", lexeme = " + lexeme + ", followSet = " + followSet);
    debug("\ntermWithOperand: " + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());

    // part of lexical analysis.
    // process the first operand at the next level if it is followed by an
    // operator with higher precedence.
    if (level < lexemeTypeAtLevel.length - 1 && lexeme.type.ordinal() > lexemeTypeAtLevel[level].ordinal()) {
      leftOperand = termWithOperand(level + 1, leftOperand, followSet);
    }

    // part of code generation.
    OperatorType operator;
    boolean leftOperandNotLoaded = true;
    while (lexeme.type == lexemeTypeAtLevel[level]) {
      // part of lexical analysis.
      operator = lexeme.operator;

      // part of code generation.
      if (leftOperandNotLoaded) {
        if (leftOperand.opType != OperandType.acc) {
          plantAccLoad(leftOperand);
        }
        leftOperandNotLoaded = false;
      }

      // part of lexical analysis.
      lexeme = lexemeReader.getLexeme(sourceCode);
      // process the right hand operand and subsequent operators/operands at the
      // next level, ultimately parsing a factor.
      Operand rOperand = (level == lexemeTypeAtLevel.length - 1) ? factor(followSet) : term(level + 1, followSet);

      // part of code generation.
      debug("\ntermWithOperand loop: level = " + level + ", leftOperand=" + leftOperand + ", rightOperand=" + rOperand
          + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
      /*
       * leftOperand: constant, acc, var, stack16, stack8 rOperand: constant,
       * acc, var, stack16, stack8
       */
      if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.constant)) {
        if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.word) {
          plant(new Instruction(forwardOperation16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardOperation16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardOperation8.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.word) {
          plant(new Instruction(FunctionType.acc8ToAcc16));
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
          acc8.clear();
          plant(new Instruction(forwardOperation16.get(operator), rOperand));
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.acc)) {
        if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardOperation16.get(operator), rOperand));
          acc8.clear();
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.word) {
          plant(new Instruction(reverseOperation16.get(operator), leftOperand));
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
          acc8.clear();
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.var)) {
        if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.word) {
          plant(new Instruction(forwardOperation16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardOperation16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardOperation8.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.word) {
          plant(new Instruction(FunctionType.acc8ToAcc16));
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
          acc8.clear();
          plant(new Instruction(forwardOperation16.get(operator), rOperand));
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.stack16) && (rOperand.opType == OperandType.acc)) {
        if (rOperand.datatype == Datatype.word) {
          plant(new Instruction(reverseOperation16.get(operator), leftOperand));
          leftOperand.opType = OperandType.acc;
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.stack8) && (rOperand.opType == OperandType.acc)) {
        if (rOperand.datatype == Datatype.byt) {
          plant(new Instruction(reverseOperation8.get(operator), leftOperand));
          leftOperand.opType = OperandType.acc;
          acc8.setOperand(leftOperand);
        } else if (rOperand.datatype == Datatype.word) {
          plant(new Instruction(reverseOperation16.get(operator), leftOperand));
          leftOperand.opType = OperandType.acc;
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    }
    debug("\ntermWithOperand: end: level = " + level + ", " + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = "
        + acc8.inUse());
    return leftOperand;
  } // termWithOperand()

  // parse a comparison, and return the address of the jump instruction to be
  // filled with the label at the end of the control statement block.
  // comparison = expression relop expression
  private int comparison(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\ncomparison: start with stopSet = " + stopSet);

    /* part of lexical analysis */
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.relop);
    Operand leftOperand = expression(localSet);
    debug("\ncomparison: leftOperand=" + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());

    /* part of code generation */
    if (leftOperand.opType == OperandType.acc) {
      debug("\ncomparison: push leftOperand to the stack; " + leftOperand);
      if (leftOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.stackAcc16));
      } else if (leftOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.stackAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    }

    /* part of lexical analysis */
    localSet = stopSet.clone();
    localSet.addAll(startExp);
    OperatorType compareOp;
    if (checkOrSkip(EnumSet.of(LexemeType.relop), localSet)) {
      /* part of code generation */
      compareOp = lexeme.operator;
      /* part of lexical analysis */
      lexeme = lexemeReader.getLexeme(sourceCode);
    } else {
      /* part of code generation */
      compareOp = OperatorType.eq;
    }

    /* part of lexical analysis */
    localSet = stopSet.clone();
    localSet.addAll(startStatement);
    localSet.remove(LexemeType.identifier);
    Operand rightOperand = expression(localSet);

    /* part of code generation */
    boolean reverseCompare = plantComparisonCode(leftOperand, rightOperand);
    int ifLabel = saveLabel();
    Operand labelOperand = new Operand(OperandType.label, Datatype.word, 0);
    if (reverseCompare) {
      debug(", reverseCompare");
      plant(new Instruction(reverseSkip.get(compareOp), labelOperand));
    } else {
      plant(new Instruction(normalSkip.get(compareOp), labelOperand));
    }

    debug("\ncomparison: end");
    return ifLabel;
  } // comparison(stopSet)

  // parse a comparison, jump back to the label if the comparison yields true.
  // comparison = expression relop expression
  private void comparisonInDoStatement(EnumSet<LexemeType> stopSet, int doLabel) throws FatalError {
    debug("\ncomparisonInDoStatement: start with stopSet = " + stopSet);

    /* part of lexical analysis */
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.relop);
    Operand leftOperand = expression(localSet);

    /* part of code generation */
    if (leftOperand.opType == OperandType.acc) {
      debug("\ncomparisonInDoStatement: push leftOperand to the stack; " + leftOperand);
      if (leftOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.stackAcc16));
      } else if (leftOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.stackAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    }

    /* part of lexical analysis */
    localSet = stopSet.clone();
    localSet.addAll(startExp);
    OperatorType compareOp;
    if (checkOrSkip(EnumSet.of(LexemeType.relop), localSet)) {
      /* part of code generation */
      compareOp = lexeme.operator;
      /* part of lexical analysis */
      lexeme = lexemeReader.getLexeme(sourceCode);
    } else {
      /* part of code generation */
      compareOp = OperatorType.eq;
    }

    /* part of lexical analysis */
    localSet = stopSet.clone();
    localSet.addAll(startStatement);
    localSet.remove(LexemeType.identifier);
    Operand rightOperand = expression(localSet);

    /* part of code generation */
    boolean reverseCompare = plantComparisonCode(leftOperand, rightOperand);
    Operand labelOperand = new Operand(OperandType.label, Datatype.word, doLabel);
    if (reverseCompare) {
      debug(", reverseCompare");
      if (compareOp == OperatorType.eq) {
        plant(new Instruction(FunctionType.brEq, labelOperand));
      } else if (compareOp == OperatorType.ne) {
        plant(new Instruction(FunctionType.brNe, labelOperand));
      } else if (compareOp == OperatorType.gt) {
        plant(new Instruction(FunctionType.brLt, labelOperand));
      } else if (compareOp == OperatorType.lt) {
        plant(new Instruction(FunctionType.brGt, labelOperand));
      } else if (compareOp == OperatorType.ge) {
        plant(new Instruction(FunctionType.brLe, labelOperand));
      } else if (compareOp == OperatorType.le) {
        plant(new Instruction(FunctionType.brGe, labelOperand));
      }
    } else {
      if (compareOp == OperatorType.eq) {
        plant(new Instruction(FunctionType.brEq, labelOperand));
      } else if (compareOp == OperatorType.ne) {
        plant(new Instruction(FunctionType.brNe, labelOperand));
      } else if (compareOp == OperatorType.gt) {
        plant(new Instruction(FunctionType.brGt, labelOperand));
      } else if (compareOp == OperatorType.lt) {
        plant(new Instruction(FunctionType.brLt, labelOperand));
      } else if (compareOp == OperatorType.ge) {
        plant(new Instruction(FunctionType.brGe, labelOperand));
      } else if (compareOp == OperatorType.le) {
        plant(new Instruction(FunctionType.brLe, labelOperand));
      }
    }

    debug("\ncomparisonInDoStatement: end");
  } // comparisonInDoStatement(stopSet, doLabel)

  // parse a block of statements, and return the address of the first object
  // code in the block of statements.
  // block = statement | "{" statements "}".
  private int block(EnumSet<LexemeType> stopSet) throws FatalError {
    int firstAddress = 0;
    debug("\nblock: start with stopSet = " + stopSet);

    // part of semantic analysis: start a new class level declaration scope for
    // the statement block.
    identifiers.newScope();

    /* part of lexical analysis */
    EnumSet<LexemeType> startSet = stopSet.clone();
    startSet.addAll(startStatement);
    startSet.add(LexemeType.beginLexeme);

    EnumSet<LexemeType> stopBlockSet = startSet.clone();
    stopBlockSet.add(LexemeType.semicolon);
    stopBlockSet.add(LexemeType.endLexeme);

    checkOrSkip(startSet, stopBlockSet);
    if (lexeme.type == LexemeType.beginLexeme) {
      lexeme = lexemeReader.getLexeme(sourceCode);
      firstAddress = statements(EnumSet.of(LexemeType.endLexeme));
      if (checkOrSkip(EnumSet.of(LexemeType.endLexeme), EnumSet.noneOf(LexemeType.class))) {
        lexeme = lexemeReader.getLexeme(sourceCode);
      }
    } else {
      firstAddress = statement(stopSet);
    }

    // part of semantic analysis: close the declaration scope of the statement
    // block.
    identifiers.closeScope();

    debug("\nblock: end, firstAddress = " + firstAddress);
    return firstAddress;
  } // block

  // forStatement = "for" "(" initialization ";" comparison ";" update ")"
  // block.
  private void forStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nforStatement: start with stopSet = " + stopSet);

    // part of semantic analysis: start a new declaration scope for the for
    // statement.
    identifiers.newScope();

    /* part of lexical analysis: "for" "(" initialization ";" */
    lexeme = lexemeReader.getLexeme(sourceCode);
    EnumSet<LexemeType> stopForSet = stopSet.clone();
    stopForSet.add(LexemeType.rbracket);
    if (checkOrSkip(EnumSet.of(LexemeType.lbracket), stopForSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    EnumSet<LexemeType> stopInitializationSet = stopForSet.clone();
    stopInitializationSet.add(LexemeType.semicolon);
    // in the initialization part a new variable must be declared.
    String variable = assignment(stopInitializationSet);
    if (variable == null) {
      error();
      System.out.println("Loop variable must be declared in for statement; for (word variable; .. ; ..) {..} expected.");
    }

    // release acc after initialization part.
    acc16.clear();
    acc8.clear();

    /* part of lexical analysis: comparison ";" */
    stopInitializationSet.addAll(startStatement);
    stopInitializationSet.remove(LexemeType.identifier);
    int forLabel = saveLabel();
    int gotoEnd = comparison(stopInitializationSet);
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopInitializationSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // order of steps in p-sourcecode: comparison - update - block.
    // order of steps during execution: comparison - block - update.

    /* part of code generation: skip update and jump forward to block */
    int gotoBlock = saveLabel();
    plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.word, 0)));
    int updateLabel = saveLabel();

    // release acc after comparison part.
    acc16.clear();
    acc8.clear();

    /* part of lexical analysis: update */
    stopForSet.add(LexemeType.beginLexeme);
    update(stopForSet);

    /* part of code generation: jump back to comparison */
    plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.word, forLabel)));

    /* part of lexical analysis: ")" */
    stopForSet = stopSet.clone();
    stopForSet.addAll(startStatement);
    if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopForSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    /* part of code generation: start of block */
    plantForwardLabel(gotoBlock, saveLabel());

    /* part of lexical analysis: block */
    block(stopSet);

    /* part of code generation; jump back to update */
    plantThenSource(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.word, updateLabel)));
    plantForwardLabel(gotoEnd, saveLabel());

    // todo: getLexeme na bovenstaande code generatie.

    // part of semantic analysis: close the declaration scope of the for
    // statement.
    identifiers.closeScope();
    debug("\nforStatement: end");
  } // forStatement()

  // doStatement = "do" block "while" "(" comparison ")" ";".
  private void doStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\ndoStatement: start with stopSet = " + stopSet);
    lexeme = lexemeReader.getLexeme(sourceCode);

    /* part of code generation */
    int doLabel = saveLabel();

    /* part of lexical analysis */
    // expect block, terminated by "while".
    EnumSet<LexemeType> stopDoSet = stopSet.clone();
    stopDoSet.add(LexemeType.whileLexeme);
    block(stopSet);

    // expect "while" followed by "(".
    EnumSet<LexemeType> stopWhileSet = stopSet.clone();
    stopWhileSet.add(LexemeType.rbracket);
    if (checkOrSkip(EnumSet.of(LexemeType.whileLexeme), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    if (checkOrSkip(EnumSet.of(LexemeType.lbracket), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // release acc after block part.
    acc16.clear();
    acc8.clear();

    // expect comparison, terminated by ")"
    stopWhileSet.addAll(startStatement);
    stopWhileSet.remove(LexemeType.identifier);
    comparisonInDoStatement(stopWhileSet, doLabel);

    // expect ")" ";"
    stopWhileSet = stopSet.clone();
    stopWhileSet.add(LexemeType.semicolon);
    if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\ndoStatement: end");
  } // doStatement()

  // whileStatement = "while" "(" comparison ")" block.
  private void whileStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nwhileStatement: start with stopSet = " + stopSet);
    lexeme = lexemeReader.getLexeme(sourceCode);

    /* part of code generation */
    int whileLabel = saveLabel();

    /* part of lexical analysis */
    EnumSet<LexemeType> stopWhileSet = stopSet.clone();
    stopWhileSet.add(LexemeType.rbracket);
    if (checkOrSkip(EnumSet.of(LexemeType.lbracket), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    /* part of lexical analysis */
    stopWhileSet.addAll(startStatement);
    stopWhileSet.remove(LexemeType.identifier);
    int endLabel = comparison(stopWhileSet);

    stopWhileSet = stopSet.clone();
    stopWhileSet.addAll(startStatement);
    if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    block(stopSet);

    /* part of code generation */
    plantThenSource(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.word, whileLabel)));
    plantForwardLabel(endLabel, saveLabel());
    debug("\nwhileStatement: end");
  } // whileStatement()

  // outputStatement = "output" "(" constantExpression "," expression ")".
  private void outputStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\noutputStatement: start with stopSet = " + stopSet);

    // part of lexical analysis.
    // skip output symbol.
    lexeme = lexemeReader.getLexeme(sourceCode);

    EnumSet<LexemeType> stopOutputSet = stopSet.clone();
    stopOutputSet.addAll(startExp);
    stopOutputSet.add(LexemeType.comma);
    stopOutputSet.add(LexemeType.rbracket);
    stopOutputSet.add(LexemeType.semicolon);

    // skip left bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.lbracket), stopOutputSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    EnumSet<LexemeType> stopExpressionSet = stopSet.clone();
    stopExpressionSet.add(LexemeType.comma);
    stopExpressionSet.add(LexemeType.rbracket);
    stopExpressionSet.add(LexemeType.semicolon);

    // read constant expression.
    Operand port = constantExpression(stopExpressionSet);

    // part of lexical analysis.
    stopOutputSet = stopSet.clone();
    stopOutputSet.addAll(startExp);
    stopOutputSet.add(LexemeType.rbracket);
    stopOutputSet.add(LexemeType.semicolon);

    // skip comma.
    if (checkOrSkip(EnumSet.of(LexemeType.comma), stopOutputSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    stopExpressionSet = stopSet.clone();
    stopExpressionSet.add(LexemeType.rbracket);
    stopExpressionSet.add(LexemeType.semicolon);

    // read second expression.
    Operand value = expression(stopExpressionSet);

    // part of semantic analysis.
    debug("\noutputStatement: value = " + value + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    // TODO check value is a byte expression.

    // part of code generation.
    plant(new Instruction(FunctionType.output, port, value));

    // part of lexical analysis.
    // skip right bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopExpressionSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // skip semicolon.
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\noutput: end");
  }

  // sleepStatement = "sleep" "(" expression ")".
  private void sleepStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nsleep: start with stopSet = " + stopSet);

    // part of lexical analysis.
    // skip sleep symbol.
    lexeme = lexemeReader.getLexeme(sourceCode);

    EnumSet<LexemeType> stopSleepSet = stopSet.clone();
    stopSleepSet.addAll(startExp);
    stopSleepSet.add(LexemeType.rbracket);
    stopSleepSet.add(LexemeType.semicolon);

    // skip left bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.lbracket), stopSleepSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // read second expression.
    Operand value = expression(stopSleepSet);

    // part of semantic analysis.
    debug("\nsleep: value = " + value + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    // check value has type byte or word.
    if (value.datatype != Datatype.byt && value.datatype != Datatype.word) {
      error(18);
    }

    // part of code generation.
    plant(new Instruction(FunctionType.sleep, value));

    // part of lexical analysis.
    // skip right bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // skip semicolon.
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\nsleep: end");
  }

  // ifStatement = "if" "(" comparison ")" block [ "else" block ].
  private void ifStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nifStatement: start with stopSet = " + stopSet);

    lexeme = lexemeReader.getLexeme(sourceCode);

    // expect (
    EnumSet<LexemeType> stopSetIf = stopSet.clone();
    stopSetIf.add(LexemeType.rbracket);
    if (checkOrSkip(EnumSet.of(LexemeType.lbracket), stopSetIf)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // expect comparison
    stopSetIf = stopSet.clone();
    stopSetIf.add(LexemeType.rbracket);
    stopSetIf.addAll(startStatement);
    stopSetIf.remove(LexemeType.identifier);
    int ifLabel = comparison(stopSetIf);
    debug("\nifStatement: ifLabel = " + ifLabel);

    // expect )
    stopSetIf = stopSet.clone();
    stopSetIf.addAll(startStatement);
    if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopSetIf)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // expect statement block
    EnumSet<LexemeType> stopSetElse = stopSet.clone();
    stopSetElse.add(LexemeType.elseLexeme);
    block(stopSetElse);

    if (lexeme.type == LexemeType.elseLexeme) {
      // expect else
      checkOrSkip(EnumSet.of(LexemeType.elseLexeme), stopSetElse);

      /* part of code generation */
      int elseLabel = saveLabel();
      plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.word, 0)));
      debug("\nifStatement: elselabel=" + elseLabel);
      debug("\nifStatement: plantForwardLabel(" + ifLabel + ")");

      /* part of lexical analysis */
      // expect statement block
      lexeme = lexemeReader.getLexeme(sourceCode);
      plantForwardLabel(ifLabel, block(stopSet));

      /* part of code generation */
      plantForwardLabel(elseLabel, saveLabel());
    } else {
      /* part of code generation */
      debug("\nifStatement: plantForwardLabel(" + ifLabel + ")");
      plantForwardLabel(ifLabel, saveLabel());
    }
    debug("\nifStatement: end");
  } // ifStatement()

  // assignment = [declaration] update ";".
  // declaration = [qualifier] datatype.
  // qualifier = "final".
  // datatype = "byte" | "word" | "String".
  private String assignment(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nassignment: start with stopSet = " + stopSet + "; lexeme.type=" + lexeme.type);

    EnumSet<LexemeType> stopAssignmentSet = stopSet.clone();
    stopAssignmentSet.addAll(startExp);
    stopAssignmentSet.add(LexemeType.semicolon);

    // part of lexical analysis.
    boolean isFinal = false;
    if (lexeme.type == LexemeType.finalLexeme) {
      isFinal = true;
      // skip final lexeme.
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // part of lexical analysis.
    String variable = null;
    if (lexeme.type == LexemeType.byteLexeme || lexeme.type == LexemeType.wordLexeme || lexeme.type == LexemeType.stringLexeme) {
      LexemeType datatype = lexeme.type;
      lexeme = lexemeReader.getLexeme(sourceCode);
      if (checkOrSkip(EnumSet.of(LexemeType.identifier), stopAssignmentSet)) {

        // part of semantic analysis.
        if (identifiers.checkId(lexeme.idVal) && identifiers.getId(lexeme.idVal).getDatatype() != null) {
          error(8); // variable already declared.
        } else if (identifiers.declareId(lexeme, datatype, isFinal)) {
          debug("\nassignment: ");
          if (isFinal)
            debug("final ");
          debug(lexeme.makeString(identifiers.getId(lexeme.idVal)));
          variable = lexeme.idVal;
        } else {
          error();
          System.out.println("Error declaring variable " + lexeme.idVal + " of type " + datatype);
        }
      }
    } else {
      checkOrSkip(EnumSet.of(LexemeType.identifier), stopAssignmentSet);

      // part of semantic analysis.
      if (!identifiers.checkId(lexeme.idVal))
        error(9); /* variable not declared */
    }

    update(stopSet);

    // part of lexical analysis.
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\nassignment: end");
    return variable;
  } // assignment()

  // update = identifier++ | identifier-- | identifier "=" expression
  private void update(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nupdate: start with stopSet = " + stopSet);

    EnumSet<LexemeType> stopAssignmentSet = stopSet.clone();
    stopAssignmentSet.addAll(startExp);
    stopAssignmentSet.add(LexemeType.semicolon);

    /* part of semantic analysis. */
    Variable var = identifiers.getId(lexeme.idVal);
    Operand leftOperand = new Operand(OperandType.var, var.getDatatype(), var.getAddress());
    leftOperand.isFinal = var.isFinal();
    debug("\nupdate: leftOperand = " + leftOperand);

    /* part of lexical analysis */
    lexeme = lexemeReader.getLexeme(sourceCode);
    if (lexeme.type == LexemeType.addop && lexeme.operator == OperatorType.sub) {
      // identifier--
      lexeme = lexemeReader.getLexeme(sourceCode);
      if (lexeme.type == LexemeType.addop && lexeme.operator == OperatorType.sub) {
        lexeme = lexemeReader.getLexeme(sourceCode);

        /* part of code generation */
        if (var.getDatatype() == Datatype.word) {
          plant(new Instruction(FunctionType.decrement16, leftOperand));
        } else if (var.getDatatype() == Datatype.byt) {
          plant(new Instruction(FunctionType.decrement8, leftOperand));
        } else {
          error(12);
        }
      }
    } else if (lexeme.type == LexemeType.addop && lexeme.operator == OperatorType.add) {
      // identifier++
      lexeme = lexemeReader.getLexeme(sourceCode);
      if (lexeme.type == LexemeType.addop && lexeme.operator == OperatorType.add) {
        lexeme = lexemeReader.getLexeme(sourceCode);

        /* part of code generation */
        if (var.getDatatype() == Datatype.word) {
          plant(new Instruction(FunctionType.increment16, leftOperand));
        } else if (var.getDatatype() == Datatype.byt) {
          plant(new Instruction(FunctionType.increment8, leftOperand));
        } else {
          error(12);
        }
      }
    } else if (checkOrSkip(EnumSet.of(LexemeType.assign), stopAssignmentSet)) {
      // identifier "=" expression
      lexeme = lexemeReader.getLexeme(sourceCode);
      Operand operand = expression(stopSet);

      /* part of code generation */
      debug("\nupdate assignment: var = " + var + ", operand = " + operand);
      if (var.isFinal()) {
        // no assignment but constant definition.
        if (var.getDatatype() != operand.datatype) {
          error(14);
        } else if (operand.opType == OperandType.constant) {
          var.setIntValue(operand.intValue);
          debug("\nupdate: final var [" + var.getName() + "] = " + var.getIntValue());
        } else {
          error(17);
        }
      } else {
        // operand to accu.
        if (operand.opType != OperandType.acc) {
          plantAccLoad(operand);
        }
        // actual assignment.
        if (operand.datatype == Datatype.word || operand.datatype == Datatype.string) {
          plant(new Instruction(FunctionType.acc16Store, leftOperand));
        } else if (operand.datatype == Datatype.byt) {
          plant(new Instruction(FunctionType.acc8Store, leftOperand));
        } else {
          error(12);
        }
      }
    }

    debug("\nupdate: end");
  } // update()

  // printlnStatement = "println" "(" expression ")" ";".
  // The println statement makes a distinction between a string expression and
  // an algorithmic expression.
  // An expression is a string expression if the first operand is a string
  // constant or the identifier of a string variable, otherwise it is an
  // algorithmic expression.
  // In a println statement with a string expression, the subsequent operands
  // may be added; other operators are not allowed.
  // However, sub expressions (expression between left ( and right )
  // parenthesis, may be string expressions or algorithmic expressions.
  // Operands in a string expression, including results of subexpressions, are
  // converted to string and then printed.
  private void printlnStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nprintlnStatement: start with stopSet = " + stopSet);

    // part of lexical analysis.
    // skip println symbol.
    lexeme = lexemeReader.getLexeme(sourceCode);

    EnumSet<LexemeType> stopWriteSet = stopSet.clone();
    stopWriteSet.addAll(startExp);
    stopWriteSet.add(LexemeType.rbracket);
    stopWriteSet.add(LexemeType.semicolon);

    // skip left bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.lbracket), stopWriteSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // read first operand.
    EnumSet<LexemeType> stopExpressionSet = stopSet.clone();
    stopExpressionSet.add(LexemeType.rbracket);
    stopExpressionSet.add(LexemeType.semicolon);
    Operand operand = factor(stopExpressionSet);
    EnumSet<LexemeType> startExpressionSet = stopExpressionSet.clone();
    startExpressionSet.add(LexemeType.addop);

    // handle string expression or algorithmic expression.
    if (operand.datatype == Datatype.string) {
      // string expression.
      do {
        // part of lexical analysis.
        if ((lexeme.type == LexemeType.addop) && (lexeme.operator == OperatorType.add)) {
          debug("\nprintlnStatement: " + operand + ", lexeme=" + lexeme.makeString(null));
          // part of code generation.
          plantPrintln(operand, false);

          // part of lexical analysis.
          // skip addop symbol.
          lexeme = lexemeReader.getLexeme(sourceCode);

          // read next factor.
          operand = factor(startExpressionSet);
        } else if (lexeme.type != LexemeType.rbracket) {
          // part of lexical analysis.
          error(3); // only + symbol allowed between terms in string expression.
          System.out.println(" " + lexeme.makeString(null));
          // skip unexpected symbol.
          if (checkOrSkip(EnumSet.of(lexeme.type), stopWriteSet)) {
            lexeme = lexemeReader.getLexeme(sourceCode);
          }
        }
      } while (lexeme.type != LexemeType.rbracket);

      debug("\nprintlnStatement: " + operand + ", lexeme=" + lexeme.makeString(null));
      // part of code generation.
      plantPrintln(operand, true);
    } else {
      // algorithmic expression.
      operand = termWithOperand(0, operand, startExpressionSet);
      debug("\nprintlnStatement: " + operand);

      // part of code generation.
      plantPrintln(operand, true);
    }

    // part of lexical analysis.
    // skip right bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopExpressionSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // skip semicolon.
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\nprintlnStatement: end");
  } // printlnStatement

  // parse a statement, and return the address of the first object code in the
  // statement.
  // statement = assignment | printlnStatement | ifStatement | forStatement |
  // doStatement | whileStatement | outputStatement | sleepStatement.
  private int statement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nstatement: start with stopSet = " + stopSet);
    int firstAddress = 0;
    /* part of code generation */
    acc16.clear();
    acc8.clear();

    /* part of lexical analysis */
    EnumSet<LexemeType> startSet = stopSet.clone();
    startSet.addAll(startStatement);
    if (checkOrSkip(startSet, stopSet)) {
      firstAddress = saveLabel();
      if (startAssignment.contains(lexeme.type)) {
        assignment(stopSet);
      } else if (lexeme.type == LexemeType.printlnLexeme) {
        printlnStatement(stopSet);
      } else if (lexeme.type == LexemeType.ifLexeme) {
        ifStatement(stopSet);
      } else if (lexeme.type == LexemeType.forLexeme) {
        forStatement(stopSet);
      } else if (lexeme.type == LexemeType.doLexeme) {
        doStatement(stopSet);
      } else if (lexeme.type == LexemeType.whileLexeme) {
        whileStatement(stopSet);
      } else if (lexeme.type == LexemeType.outputLexeme) {
        outputStatement(stopSet);
      } else if (lexeme.type == LexemeType.sleepLexeme) {
        sleepStatement(stopSet);
      }
    }
    debug("\nstatement: end, firstAddress = " + firstAddress);
    return firstAddress;
  } // statement

  // parse a sequence of statements, and return the address of the first object
  // code in the sequence of statements.
  // statements = (statement)*.
  private int statements(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nstatements: start with stopSet = " + stopSet);
    int firstAddress = 0;

    // while (checkOrSkip(startStatement, stopSet)) {
    while (startStatement.contains(lexeme.type)) {
      int nextAddress = statement(stopSet);
      if (firstAddress == 0)
        firstAddress = nextAddress;
      // lexeme = lexemeReader.getLexeme(sourceCode);
    }
    debug("\nstatements: end, firstAddress = " + firstAddress);

    // first source } as comment, then branch, then next source as comment.
    if (lexeme.type == LexemeType.endLexeme) {
      plantSource();
    }
    return firstAddress;
  } // statements

  /*****************************
   *
   * Code generation methods
   *
   ****************************/

  private boolean plantComparisonCode(Operand leftOperand, Operand rightOperand) {
    debug("\nplantComparisonCode: leftOperand=" + leftOperand + ", rightOperand=" + rightOperand + ", acc16InUse = " + acc16.inUse()
        + ", acc8InUse = " + acc8.inUse());
    /*
     * Possible operand types: leftOperand: constant, acc, var, stack16, stack8;
     * NB: var is loaded into acc and acc is pushed onto stack prior to
     * evaluating right hand expression into rightOperand. rightOperand:
     * constant, acc, var, stack16, stack8
     */

    boolean reverseCompare = false;
    // plant(new Instruction(FunctionType.acc16Compare, rightOperand));
    if ((leftOperand.opType == OperandType.constant) && (rightOperand.opType == OperandType.constant)) {
      plantAccLoad(leftOperand);
      if (leftOperand.datatype == Datatype.word && rightOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.acc16Compare, rightOperand));
      } else if (leftOperand.datatype == Datatype.word && rightOperand.datatype == Datatype.byt) {
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.word) {
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.acc8Compare, rightOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.constant) && (rightOperand.opType == OperandType.acc)) {
      if (leftOperand.datatype == Datatype.word && rightOperand.datatype == Datatype.word) {
        reverseCompare = true;
        plant(new Instruction(FunctionType.acc16Compare, leftOperand));
      } else if (leftOperand.datatype == Datatype.word && rightOperand.datatype == Datatype.byt) {
        plantAccLoad(leftOperand);
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.word) {
        plantAccLoad(leftOperand);
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.byt) {
        reverseCompare = true;
        plant(new Instruction(FunctionType.acc8Compare, leftOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.constant) && (rightOperand.opType == OperandType.var)) {
      plantAccLoad(rightOperand);
      if (leftOperand.datatype == Datatype.word && rightOperand.datatype == Datatype.word) {
        reverseCompare = true;
        plant(new Instruction(FunctionType.acc16Compare, leftOperand));
      } else if (leftOperand.datatype == Datatype.word && rightOperand.datatype == Datatype.byt) {
        plantAccLoad(leftOperand);
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.word) {
        plantAccLoad(leftOperand);
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.byt) {
        reverseCompare = true;
        plant(new Instruction(FunctionType.acc8Compare, leftOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
      /*
       * } else if ((leftOperand.opType == OperandType.constant) &&
       * (rightOperand.opType == OperandType.stack8)) { if (leftOperand.datatype
       * == Datatype.byt) { plant(new Instruction(FunctionType.unstackAcc8));
       * plant(new Instruction(FunctionType.acc8Compare, leftOperand)); } else {
       * throw new RuntimeException("Internal compiler error: abort."); }
       */
    } else if ((leftOperand.opType == OperandType.var) && (rightOperand.opType == OperandType.constant)) {
      plantAccLoad(leftOperand);
      if (leftOperand.datatype == Datatype.word && rightOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.acc16Compare, rightOperand));
      } else if (leftOperand.datatype == Datatype.word && rightOperand.datatype == Datatype.byt) {
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.word) {
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.acc8Compare, rightOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.var) && (rightOperand.opType == OperandType.acc)) {
      if (leftOperand.datatype == Datatype.word && rightOperand.datatype == Datatype.word) {
        reverseCompare = true;
        plant(new Instruction(FunctionType.acc16Compare, leftOperand));
      } else if (leftOperand.datatype == Datatype.word && rightOperand.datatype == Datatype.byt) {
        plantAccLoad(leftOperand);
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.word) {
        plantAccLoad(leftOperand);
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.byt) {
        reverseCompare = true;
        plant(new Instruction(FunctionType.acc8Compare, leftOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.var) && (rightOperand.opType == OperandType.var)) {
      plantAccLoad(leftOperand);
      if (leftOperand.datatype == Datatype.word && rightOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.acc16Compare, rightOperand));
      } else if (leftOperand.datatype == Datatype.word && rightOperand.datatype == Datatype.byt) {
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.word) {
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.acc8Compare, rightOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.stack16) && (rightOperand.opType == OperandType.constant)) {
      if (rightOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.unstackAcc16));
        plant(new Instruction(FunctionType.acc16Compare, rightOperand));
      } else if (rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.unstackAcc16));
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.stack16) && (rightOperand.opType == OperandType.acc)) {
      if (rightOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.revAcc16Compare, leftOperand));
        reverseCompare = true;
      } else if (rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.unstackAcc16));
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.stack16) && (rightOperand.opType == OperandType.var)) {
      if (rightOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.unstackAcc16));
        plant(new Instruction(FunctionType.acc16Compare, rightOperand));
      } else if (rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.unstackAcc16));
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.stack8) && (rightOperand.opType == OperandType.constant)) {
      if (rightOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.unstackAcc8));
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else if (rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.unstackAcc8));
        plant(new Instruction(FunctionType.acc8Compare, rightOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.stack8) && (rightOperand.opType == OperandType.acc)) {
      if (rightOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.unstackAcc8));
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else if (rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.revAcc8Compare, leftOperand));
        reverseCompare = true;
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.stack8) && (rightOperand.opType == OperandType.var)) {
      if (rightOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.unstackAcc8));
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else if (rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.unstackAcc8));
        plant(new Instruction(FunctionType.acc8Compare, rightOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else {
      throw new RuntimeException("Internal compiler error: abort.");
    }
    debug("\nplantComparisonCode: end");
    return reverseCompare;
  } // plantComparisonCode()

  private void plantAccLoad(Operand operand) {
    // load acc with operand.
    if (operand.datatype == Datatype.word) {
      if (operand.opType != OperandType.stack16) {
        if (acc16.inUse()) {
          plant(new Instruction(FunctionType.stackAcc16Load, operand));
        } else {
          plant(new Instruction(FunctionType.acc16Load, operand));
        }
        operand.opType = OperandType.acc;
        acc16.setOperand(operand);
      }
    } else if (operand.datatype == Datatype.byt) {
      if (operand.opType != OperandType.stack8) {
        if (acc8.inUse()) {
          plant(new Instruction(FunctionType.stackAcc8Load, operand));
        } else {
          plant(new Instruction(FunctionType.acc8Load, operand));
        }
        operand.opType = OperandType.acc;
        acc8.setOperand(operand);
      }
    } else if (operand.datatype == Datatype.string) {
      if (acc16.inUse()) {
        throw new RuntimeException("Compiler error; acc16 is in use unexpectedly.");
      }
      plant(new Instruction(FunctionType.acc16Load, operand));
    } else {
      throw new RuntimeException("Unsupported operand " + operand);
    }
  }

  private void plant(Instruction instruction) {
    /* for debugging purposes */
    debug("\n->plant (acc8InUse=" + acc8.inUse() + ", acc16InUse=" + acc16.inUse() + ", lastSourceLineNr=" + lastSourceLineNr
        + ", sourceLineNr=" + lexeme.sourceLineNr + ", linesOfSourceCode=" + sourceCode.size() + "):");
    plantSource();
    plantCode(instruction);
  } // plant

  private void plantThenSource(Instruction instruction) {
    /* for debugging purposes */
    debug("\n->plantThenSource (acc8InUse=" + acc8.inUse() + ", acc16InUse=" + acc16.inUse() + ", lastSourceLineNr="
        + lastSourceLineNr + ", sourceLineNr=" + lexeme.sourceLineNr + ", linesOfSourceCode=" + sourceCode.size() + "):");

    plantCode(instruction);
    plantSource();
  } // plantThenSource

  private void plantSource() {
    for (String line : sourceCode) {
      if (debugMode) {
        debug("\n" + String.format(LINE_NR_FORMAT, instructions.size()) + FunctionType.comment.getValue() + line);
      }
      instructions.add(new Instruction(FunctionType.comment, new Operand(OperandType.constant, Datatype.string, line)));
    }
    sourceCode.clear();
  } // plantSource

  private void plantCode(Instruction instruction) {
    /*
     * clear memory if number of M-code (virtual machine codes) exceeds memory
     * size.
     */
    if (instructions.size() >= MAX_M_CODE) {
      error(10);
      instructions.clear();
    }

    /* for debugging purposes */
    debug("\n" + String.format(LINE_NR_FORMAT, instructions.size()) + instruction.toString());
    debug(" ;" + instruction.function);
    if (instruction.operand != null) {
      debug(" " + instruction.operand);
    }

    /* insert M-code (virtual machine code) into memory */
    instructions.add(instruction);

    /* update accumulator metadata */
    if (instruction.function == FunctionType.acc16ToAcc8) {
      acc8.setOperand(acc16.operand());
      acc16.clear();
    } else if (instruction.function == FunctionType.acc8ToAcc16) {
      acc16.setOperand(acc8.operand());
      acc8.clear();
    } else if (instruction.function == FunctionType.stackAcc16Load) {
      stackedDatatypes.push(Datatype.word);
      acc16.operand().opType = OperandType.stack16;
    } else if (instruction.function == FunctionType.stackAcc8Load) {
      stackedDatatypes.push(Datatype.byt);
      acc8.operand().opType = OperandType.stack8;
    } else if (instruction.function == FunctionType.stackAcc16ToAcc8) {
      stackedDatatypes.push(Datatype.byt);
      acc8.operand().opType = OperandType.stack8;
      acc16.clear();
    } else if (instruction.function == FunctionType.stackAcc8ToAcc16) {
      stackedDatatypes.push(Datatype.word);
      acc16.operand().opType = OperandType.stack16;
      acc8.clear();
    } else if (instruction.function == FunctionType.stackAcc16) {
      stackedDatatypes.push(Datatype.word);
      acc16.operand().opType = OperandType.stack16;
      acc16.clear();
    } else if (instruction.function == FunctionType.stackAcc8) {
      stackedDatatypes.push(Datatype.byt);
      acc8.operand().opType = OperandType.stack8;
      acc8.clear();
    }

    /* update stack metadata */
    if (instruction.function == FunctionType.unstackAcc8) {
      popStackedDatatype(Datatype.byt);
    } else if (instruction.function == FunctionType.unstackAcc16) {
      popStackedDatatype(Datatype.word);
    } else if (instruction.operand != null && instruction.operand.opType == OperandType.stack8) {
      popStackedDatatype(Datatype.byt);
    } else if (instruction.operand != null && instruction.operand.opType == OperandType.stack16) {
      popStackedDatatype(Datatype.word);
    }

    /* for debugging purposes */
    debug(" ;" + " stackedDatatypes=" + stackedDatatypes);
  } // plantCode

  private void plantForwardLabel(int pos, int address) {
    // skip original source code that has been added as comment before the
    // branch instruction.
    while (instructions.get(pos).function == FunctionType.comment) {
      pos++;
    }

    instructions.get(pos).operand.intValue = address;

    /* for debugging purposes */
    debug("\nplantForwardLabel instruction[" + pos + "]=" + address);
  } // plantForwardLabel(pos, address)

  private void plantPrintln(Operand operand, boolean withCarriageReturn) {
    // part of code generation.
    if (operand.opType != OperandType.acc) {
      plantAccLoad(operand);
    }
    switch (operand.datatype) {
      case word:
        plant(new Instruction(withCarriageReturn ? FunctionType.writeLineAcc16 : FunctionType.writeAcc16));
        break;
      case byt:
        plant(new Instruction(withCarriageReturn ? FunctionType.writeLineAcc8 : FunctionType.writeAcc8));
        break;
      case string:
        plant(new Instruction(withCarriageReturn ? FunctionType.writeLineString : FunctionType.writeString));
        break;
      default:
        error(15);
    }
  }

  private int saveLabel() {
    // address of next object code.
    int address = instructions.size();

    // compensate address for original source code that will be added as comment
    // before the next instruction.
    int compensatedAddress = address + sourceCode.size();

    /* for debugging purposes */
    debug("\nlabel: address = " + address + ", compensated for comments = " + compensatedAddress);

    return compensatedAddress;
  }

  private void popStackedDatatype(Datatype expectedDataType) {
    Datatype datatype = stackedDatatypes.pop();
    if (!(datatype == Datatype.byt || datatype == Datatype.word)) {
      debug("\npopStackedDatatype: unsupported data type popped from stack: " + datatype);
      throw new RuntimeException("Internal compiler error: abort.");
    }

    if (datatype != expectedDataType) {
      debug("\npopStackedDatatype: unexpected data type popped from stack: popped " + datatype + "; expected " + expectedDataType);
      throw new RuntimeException("Internal compiler error: abort.");
    }
  } // popStackedDatatype()

  private void plantStringConstants() {
    for (int id = 0; id < stringConstants.size(); id++) {
      // plant string constant.
      Operand operand = new Operand(OperandType.constant, Datatype.string, stringConstants.get(id));
      operand.intValue = id;
      instructions.add(new Instruction(FunctionType.stringConstant, operand));
    }
  }

  private void updateReferencesToStringConstants(int offset) {
    Map<Integer, ArrayList<Integer>> stringReferences = new HashMap<Integer, ArrayList<Integer>>();
    int lineNumber = 0;
    Instruction instruction;
    do {
      instruction = instructions.get(lineNumber);
      if (instruction.function != FunctionType.comment && instruction.operand != null
          && instruction.operand.opType == OperandType.constant && instruction.operand.datatype == Datatype.string) {
        if (instruction.operand.intValue == null) {
          throw new RuntimeException(String.format("operand.intValue is null at instruction %d: instruction: %s operand: %s",
              +lineNumber, instruction, instruction.operand));
        }
        int oldAddress = instruction.operand.intValue;
        int newAddress = instruction.operand.intValue + offset;
        debug("\nUpdating reference to string constant at " + lineNumber + " from " + oldAddress + " to " + newAddress);
        instruction.operand.intValue = newAddress;
        if (debugMode) {
          // add index of string constant to the cross references list.
          if (stringReferences.get(newAddress) == null) {
            stringReferences.put(newAddress, new ArrayList<Integer>());
          }
          // add reference to the list of references to the string constant.
          stringReferences.get(newAddress).add(lineNumber);
        }
      }
      lineNumber++;
    } while (instruction.function != FunctionType.stop);

    // log string constants and references to them.
    if (debugMode) {
      debug("\n\nString constants cross reference list:\n");
      for (Map.Entry<Integer, ArrayList<Integer>> entry : stringReferences.entrySet()) {
        debug(entry.getKey() + " : " + entry.getValue() + "\n");
      }
    }
  }

  /*****************************
   *
   * Code generation methods
   *
   ****************************/

  private void optimize() {
    debug("\noptimize: start m-code optimization. Number of instructions before optimization = " + instructions.size());
    int pos = 0;
    while (pos < instructions.size() - 2) {
      if ((instructions.get(pos).function == FunctionType.stackAcc16)
          && (instructions.get(pos + 1).function == FunctionType.unstackAcc16)) {
        // remove tuple { <acc16; acc16= unstack16 }
        debug(String.format("\noptimize: removing tuple { <acc16; acc16= unstack16 } at %d-%d", pos, pos + 1));
        relocate(pos, 2);
      } else if ((instructions.get(pos).function == FunctionType.stackAcc8)
          && (instructions.get(pos + 1).function == FunctionType.unstackAcc8)) {
        // remove tuple { <acc8; acc8= unstack8 }
        debug(String.format("\noptimize: removing tuple { <acc8; acc8= unstack8 } at %d-%d", pos, pos + 1));
        relocate(pos, 2);
      }
      pos++;
    }
    debug("\noptimize: end. Number of instructions after optimization = " + instructions.size());
    debug("\n");
  } // optimize

  // remove 'number' instructions, starting at position 'pos', and relocate
  // branch addresses and references to string constants.
  private void relocate(int pos, int number) {
    // remove #number instructions.
    for (int i = 0; i < number; i++) {
      instructions.remove(pos);
    }

    // adjust branch instructions.
    int idx = 0;
    Instruction instruction;
    do {
      instruction = instructions.get(idx++);
      if (brFunctions.contains(instruction.function) && (instruction.operand.intValue > pos)) {
        instruction.operand.intValue -= number;
      }
    } while (instruction.function != FunctionType.stop);
  } // relocate

}