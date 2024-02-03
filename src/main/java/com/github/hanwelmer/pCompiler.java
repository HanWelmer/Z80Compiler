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

package com.github.hanwelmer;

import java.io.File;
import java.util.ArrayList;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

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
  // global variables used by the constructor or the interface functions.
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
      System.out.println("compilation aborted.");
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

  // Constant with branch instructions.
  private static final EnumSet<FunctionType> BRANCH_FUNCTIONS = EnumSet.of(FunctionType.br, FunctionType.brEq, FunctionType.brNe,
      FunctionType.brLt, FunctionType.brLe, FunctionType.brGt, FunctionType.brGe);

  // Constant with instructions that may take a stringConstant as operand.
  private static final EnumSet<FunctionType> STRING_CONSTANT_FUNCTIONS = EnumSet.of(FunctionType.acc16Load);

  // Constants for lexical analysis phase
  // Lexemes that start a class body declaration.
  private static final EnumSet<LexemeType> CLASS_BODY_START_SET = EnumSet.of(LexemeType.publicLexeme, LexemeType.privateLexeme,
      LexemeType.staticLexeme, LexemeType.finalLexeme, LexemeType.synchronizedLexeme, LexemeType.volatileLexeme,
      LexemeType.voidLexeme, LexemeType.byteLexeme, LexemeType.wordLexeme, LexemeType.stringLexeme, LexemeType.identifier);
  // Possible modifiers for fields.
  private static final EnumSet<LexemeType> FIELD_MODIFIERS = EnumSet.of(LexemeType.publicLexeme, LexemeType.privateLexeme,
      LexemeType.staticLexeme, LexemeType.finalLexeme, LexemeType.volatileLexeme);
  // Possible modifiers for methods.
  private static final EnumSet<LexemeType> METHOD_MODIFIERS = EnumSet.of(LexemeType.publicLexeme, LexemeType.privateLexeme,
      LexemeType.staticLexeme, LexemeType.synchronizedLexeme);
  // Possible lexeme types in ResultType.
  private static final EnumSet<LexemeType> RESULT_TYPE_LEXEME_TYPES = EnumSet.of(LexemeType.voidLexeme, LexemeType.byteLexeme,
      LexemeType.wordLexeme);
  // Lexeme types in an expression in increasing order of precedence.
  private static final LexemeType[] LEXEME_TYPE_AT_LEVEL = { LexemeType.bitwiseOrOp, LexemeType.bitwiseXorOp,
      LexemeType.bitwiseAndOp, LexemeType.addop, LexemeType.mulop };
  // Lexeme types that start a statement.
  private static final EnumSet<LexemeType> START_STATEMENT = EnumSet.of(LexemeType.finalLexeme, LexemeType.identifier,
      LexemeType.byteLexeme, LexemeType.wordLexeme, LexemeType.stringLexeme, LexemeType.printlnLexeme, LexemeType.ifLexeme,
      LexemeType.forLexeme, LexemeType.doLexeme, LexemeType.whileLexeme, LexemeType.outputLexeme, LexemeType.sleepLexeme);
  // Lexeme types that start an assignmenr.
  private static final EnumSet<LexemeType> START_ASSIGNMENT = EnumSet.of(LexemeType.finalLexeme, LexemeType.identifier,
      LexemeType.byteLexeme, LexemeType.wordLexeme, LexemeType.stringLexeme);
  // Lexeme types that start an expression.
  private static final EnumSet<LexemeType> START_EXPRESSION = EnumSet.of(LexemeType.LPAREN, LexemeType.identifier,
      LexemeType.constant, LexemeType.stringConstant, LexemeType.inputLexeme, LexemeType.readLexeme);

  // Class variables for lexical analysis phase.
  private ArrayList<String> sourceCode;
  private int lastSourceLineNr = 0;
  private Lexeme lexeme;
  private int errors;

  // Constants and class variables for semantic analysis phase.
  private String packageName;
  private Identifiers identifiers = new Identifiers();
  private StringConstants stringConstants = new StringConstants();

  // Constants and class variables for code generation phase.
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

  // Class methods for all phases.
  private void init() {
    // initialisation of lexical analysis variables.
    sourceCode = new ArrayList<String>();
    lastSourceLineNr = 0;
    errors = 0;
    lexeme = new Lexeme(LexemeType.unknown);

    // initialisation of syntax analysis variables.

    // initialisation of semantic analysis variables.
    packageName = "";
    identifiers.init();
    stringConstants.init();

    // initialisation of code generation variables.
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

  private void errorUnexpectedSymbol(String message) {
    error(3);
    System.out.println(message);
  }

  // TODO Fix runtime error: too many variables
  private void error(int n) {
    error();
    switch (n) {
      case 0:
        System.out.println("error opening source code file.");
        break;
      case 1:
        System.out.println("end of file encountered.");
        break;
      case 2:
        System.out.println("line too long.");
        break;
      case 3:
        System.out.print("unexpected symbol; ");
        break;
      case 4:
        System.out.println("unknown character.");
        break;
      case 5:
        System.out.println("'=' expected after '=' or '!' .");
        break;
      case 6:
        System.out.print("unknown keyword : .");
        break;
      case 8:
        System.out.println("variable already declared.");
        break;
      case 9:
        System.out.println("variable not declared.");
        break;
      case 10:
        System.out.println("code overflow.");
        break;
      case 11:
        System.out.println("lexemetype is null.");
        break;
      case 12:
        System.out.println("internal compiler error during code generation.");
        break;
      case 13:
        System.out.println("constant too big.");
        break;
      case 14:
        System.out.println("incompatible datatype between assignment variable and expression.");
        break;
      case 15:
        System.out.println("incompatible datatype in println statement.");
        break;
      case 16:
        System.out.println("port expression must be a constant or a static final variable.");
        break;
      case 17:
        System.out.println("static final variable must be a byte or a word.");
        break;
      case 18:
        System.out.println("datatype must be byte or word.");
        break;
      case 19:
        System.out.println("packageName identifiers must be lowerCamelCase.");
        break;
      case 20:
        System.out.println("package name does not match path of source code file.");
        break;
      case 21:
        System.out.println("import must consist of optional package name followed by either * or class name.");
        break;
      case 22:
        System.out.println("illegal modifer in class or enum declaration.");
        break;
      case 23:
        System.out.println("too many modifers in class or enum declaration.");
        break;
      case 24:
        System.out.println("unexpected modifier in class or enum declaration.");
        break;
      case 25:
        System.out.println("static modifier is mandatory for methods.");
        break;
      case 26:
        System.out.println("unexpected modifier in method declaration.");
        break;
      case 27:
        System.out.println("type missing.");
        break;
      case 30:
        System.out.println("static modifier is mandatory for fields.");
        break;
      case 31:
        System.out.println("unexpected modifier in field declaration.");
        break;
      case 32:
        System.out.println("unexpected type in field declaration.");
        break;
      case 33:
        System.out.println("superfluous text between end of type declaration and end of file.");
        break;
    }
  }

  /*************************
   *
   * syntax analysis methods
   *
   ************************/

  /**
   * return true if current lexeme is in okSet, otherwise skip until current
   * lexeme is in stopSet and return false.
   */
  private boolean checkOrSkip(EnumSet<LexemeType> okSet, EnumSet<LexemeType> stopSet) throws FatalError {
    boolean result = false;
    if (okSet.contains(lexeme.type)) {
      result = true;
    } else {
      errorUnexpectedSymbol("found " + lexeme.type + ", expected " + okSet);
      stopSet.add(LexemeType.eof);
      while (!stopSet.contains(lexeme.type)) {
        lexeme = lexemeReader.skipAfterError(sourceCode);
      }
    }
    return result;
  }

  // return true if all identifiers in the packageName are lowerCamelCase.
  protected boolean validPackageName(String packageName) {
    boolean result = true;
    for (String identifier : packageName.split("\\.")) {
      result &= validLowerCamelCaseIdentifier(identifier);
    }
    return result;
  }

  /*
   * The syntax category <identifier> consists of strings that must start with a
   * letter - including underscore (_) and dollar sign ($) - followed by any
   * number of letters and digits. Characters of numerous international
   * languages are recognized as "letters" in Java. A Java letter is a character
   * for which the method Character.isJavaLetter returns true. A Java
   * letter-or-digit is a character for which the method
   * Character.isJaveLetterOrDigit returns true. Also, <identifier> includes
   * none of the keywords given above - these are reserved words in Java.
   */
  private boolean validLowerCamelCaseIdentifier(String identifier) {
    // not a valid identifier if it is a keyword.
    if (LexemeType.isLexemeType(identifier)) {
      return false;
    }

    // valid identifier if it matches the regular expression.
    // return identifier.matches("\\p{javaLowerCase}*");
    return identifier.matches("^(_|\\$)*[a-z][a-zA-Z0-9]*$");
  }

  // return true if all identifiers in the packageName are lowerCamelCase and
  // importType is either * or UpperCamelCase.
  protected boolean validImport(String importPackageName) {
    String[] identifiers = importPackageName.split("\\.");
    boolean result = true;
    int index = 0;
    while (result && index < identifiers.length - 1) {
      result = validLowerCamelCaseIdentifier(identifiers[index++]);
    }
    if (index == identifiers.length - 1) {
      result &= validImportType(identifiers[index]);
    }
    return result;
  }

  // importType = identifier | "*".
  // Note: importType identifier is UpperCamelCase.
  private boolean validImportType(String identifier) {
    // * is a valid import type.
    if ("*".equals(identifier)) {
      return true;
    }
    // not a valid identifier if it is a keyword.
    if (LexemeType.isLexemeType(identifier)) {
      return false;
    }

    // valid identifier if it matches the regular expression.
    // return identifier.matches("\\p{javaUpperCase}*");
    return identifier.matches("^(_|\\$)*[A-z][a-zA-Z0-9]*$");
  }

  /*************************
   * 
   * Syntax parsing methods.
   * 
   *************************/

  /*************************
   * 
   * ### CompilationUnit
   * 
   *************************/
  // compilationUnit ::= packageDeclaration? importDeclaration* typeDeclaration.
  private void compilationUnit() throws FatalError {
    debug("\ncompilationUnit: start");

    // recognize an optional package declaration.
    lexeme = lexemeReader.getLexeme(sourceCode);
    EnumSet<LexemeType> stopSet = EnumSet.of(LexemeType.importLexeme, LexemeType.publicLexeme, LexemeType.classLexeme,
        LexemeType.enumLexeme);
    if (lexeme.type == LexemeType.packageLexeme) {
      packageDeclaration(stopSet);
    }

    // recognize an optional list of import declaration.
    while (lexeme.type == LexemeType.importLexeme) {
      importDeclaration(stopSet);
    }

    // recognize the mandatory single type declaration.
    stopSet.remove(LexemeType.importLexeme);
    typeDeclaration(stopSet);

    // check we are at the end of the file, barring comments and white space.
    if (lexeme.type != LexemeType.eof) {
      error(33);
    }

    debug("\ncompilationUnit: end");
  } // compilationUnit

  /*************************
   * 
   * ### Declarations
   * 
   *************************/

  // packageDeclaration ::= "package" name ";".
  private void packageDeclaration(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\npackageDeclaration: start");

    // skip "package".
    lexeme = lexemeReader.getLexeme(sourceCode);

    // recognize name.
    packageName = name(stopSet);
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      // semantic analysis: packageName identifiers are lowerCamelCase.
      if (!validPackageName(packageName)) {
        error(19);
      }

      // semantic analysis: source file path must equal packageName.
      if (!lexemeReader.getFileName().startsWith(packageName.replace(".", File.separator))) {
        error(20);
        debug("\npackage: " + packageName);
        debug("\nexpected: " + packageName.replace(".", File.separator));
        debug("\nfound: " + lexemeReader.getFileName());
      }

      // part of code generation
      plant(new Instruction(FunctionType.packageFunction, packageName, null, null));

      // TODO implement semantics for package declaration.

      // skip ";"
      lexeme = lexemeReader.getLexeme(sourceCode);
      debug("\npackageDeclaration: packageName=" + packageName);
    }

    debug("\npackageDeclaration: end; package name=" + packageName);
  } // packageDeclaration

  // importDeclaration ::= "import" "static"? name [ "." "*" ] ";".
  //
  // TODO implement "static"? in importDeclaration.
  // TODO change implementation from:
  // ....importDeclaration ::= "import" name "." importType ";".
  // to:
  // ... "import" "static"? name [ "." "*" ] ";".
  //
  // packageName = identifier { "." identifier }.
  // importType = identifier | "*".
  //
  // Note: packageName identifiers are lowerCamelCase.
  // Note: importType identifier is UpperCamelCase.
  //
  // TODO implement semantic analysis of importDeclaration
  private void importDeclaration(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nimportDeclaration: start");

    // skip "import"
    lexeme = lexemeReader.getLexeme(sourceCode);

    // recognize name.
    String importPackageName = name(stopSet);
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      // semantic analysis: packageName identifiers are lowerCamelCase and
      // importType is either * or UpperCamelCase.
      if (!validImport(importPackageName)) {
        error(21);
      }

      // part of code generation
      plant(new Instruction(FunctionType.importFunction, importPackageName, null, null));

      // TODO: import single class or all classes in the package.

      // skip ";"
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    debug("\nimportDeclaration: end; importPackageName=" + importPackageName);
  } // importDeclaration

  // typeDeclaration ::= ";" | ( modifiers ( classDecl | enumDecl ) ).
  //
  // TODO implement enumDecl in typeDeclaration.
  private void typeDeclaration(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\ntypeDeclaration: start");

    if (lexeme.type == LexemeType.semicolon) {
      // skip ";".
      lexeme = lexemeReader.getLexeme(sourceCode);
    } else {
      EnumSet<LexemeType> modifiers = modifiers();

      // Semantic analysis: modifiers in a class/enum declaration must be
      // none or "public". Default is none, i.e. the class is only
      // accessible by classes or enums in the same package.
      boolean isPublic = modifiers.contains(LexemeType.publicLexeme);
      // valid: modifiers.size() == 0 || (modifiers.size() == 1 && isPublic)
      if (!((modifiers.size() == 0) || ((modifiers.size() == 1) && isPublic))) {
        if (modifiers.size() > 1) {
          error(23);
        } else if (!isPublic) {
          error(24);
        }
      }

      classDecl(isPublic, stopSet);
    }

    debug("\ntypeDeclaration: end");
  } // typeDeclaration

  // classDecl ::= "class" javaIdentifier classBody.
  private void classDecl(boolean isPublic, EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nclassDecl: " + (isPublic ? "public" : ""));
    EnumSet<LexemeType> modifiers = EnumSet.noneOf(LexemeType.class);
    if (isPublic) {
      modifiers.add(LexemeType.publicLexeme);
    }

    // recognize a class definition.
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.identifier);
    localSet.add(LexemeType.beginLexeme);
    if (checkOrSkip(EnumSet.of(LexemeType.classLexeme), localSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);

      // part of semantic analysis: start a new class level declaration scope.
      identifiers.newScope();

      localSet = stopSet.clone();
      localSet.add(LexemeType.beginLexeme);
      if (checkOrSkip(EnumSet.of(LexemeType.identifier), localSet)) {
        // semantic analysis.
        String identifier = lexeme.idVal;
        if (identifiers.checkId(identifier)) {
          error();
          System.out.println("variable " + identifier + " already declared.");
        } else if (identifiers.declareId(identifier, IdentifierType.clazz, LexemeType.classLexeme, modifiers)) {
          debug("\nclassDecl: " + (isPublic ? "public " : "") + "class declared: " + identifier);
        } else {
          error();
          System.out.println("Error declaring identifier " + identifier + " as a class.");
        }

        // part of code generation
        plant(new Instruction(FunctionType.classFunction, identifier, modifiers, null));

        classBody(stopSet);
      }

      // part of semantic analysis: close the class level declaration scope.
      identifiers.closeScope();
    }
    debug("\nclassDecl: end");
  } // classDecl

  // enumDecl ::= "enum" javaIdentifier enumBody.
  //
  // TODO implement enumDecl.
  private void enumDecl() throws FatalError {
    debug("\nenumDecl: start");
    debug("\nenumDecl: end");
  }

  /*************************
   * 
   * ### Modifiers
   * 
   *************************/

  // modifiers ::= "public"? "private"? "static"? "final"? "native"?
  // "transient"? "volatile"?.
  protected EnumSet<LexemeType> modifiers() throws FatalError {
    EnumSet<LexemeType> result = EnumSet.noneOf(LexemeType.class);

    // "public"?
    if (lexeme.type == LexemeType.publicLexeme) {
      result.add(LexemeType.publicLexeme);
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    // "private"?
    if (lexeme.type == LexemeType.privateLexeme) {
      result.add(LexemeType.privateLexeme);
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    // "static"?
    if (lexeme.type == LexemeType.staticLexeme) {
      result.add(LexemeType.staticLexeme);
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    // "final"?
    if (lexeme.type == LexemeType.finalLexeme) {
      result.add(LexemeType.finalLexeme);
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    // "native"?
    if (lexeme.type == LexemeType.nativeLexeme) {
      result.add(LexemeType.nativeLexeme);
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    // "transient"?
    if (lexeme.type == LexemeType.transientLexeme) {
      result.add(LexemeType.transientLexeme);
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    // "volatile"?
    if (lexeme.type == LexemeType.volatileLexeme) {
      result.add(LexemeType.volatileLexeme);
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    return result;
  }

  /*************************
   * 
   * ### EnumBody
   * 
   *************************/

  // enumBody ::= "{" enumConstant { "," enumConstant } [ ";"
  // classBodyDeclaration* ] "}".
  //
  // TODO implement enumBody.

  // enumConstant ::= javaIdentifier arguments?.
  //
  // TODO implement enumConstant.

  /*************************
   * 
   * ### ClassBody
   * 
   *************************/

  // classBody ::= "{" classBodyDeclaration* "}".
  private void classBody(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nclassBody: start");

    lexeme = lexemeReader.getLexeme(sourceCode);
    EnumSet<LexemeType> classBodyStopSet = stopSet.clone();
    classBodyStopSet.addAll(CLASS_BODY_START_SET);
    classBodyStopSet.add(LexemeType.endLexeme);
    EnumSet<LexemeType> classDeclStopSet = stopSet.clone();
    classDeclStopSet.add(LexemeType.endLexeme);
    if (checkOrSkip(EnumSet.of(LexemeType.beginLexeme), classBodyStopSet)) {
      // skip beginLexeme
      lexeme = lexemeReader.getLexeme(sourceCode);

      while (CLASS_BODY_START_SET.contains(lexeme.type)) {
        classBodyDeclaration(classDeclStopSet);
      }

      // skip end lexeme
      if (checkOrSkip(EnumSet.of(LexemeType.endLexeme), stopSet)) {
        // skip endLexeme
        lexeme = lexemeReader.getLexeme(sourceCode);
      }
    }

    debug("\nclassBody: end");
  }

  // classBodyDeclaration ::= modifiers ( methodDeclaration | fieldDeclaration
  // ).
  // methodDeclaration ::= resultType methodDeclarator block.
  // resultType ::= "void" | type.
  // methodDeclarator ::= javaIdentifier formalParameters.
  // fieldDeclaration ::= type variableDeclarators ";".
  // variableDeclarators ::= variableDeclarator { "," variableDeclarator }.
  // variableDeclarator ::= variableDeclaratorId [ "=" variableInitializer ].
  // variableDeclaratorId ::= javaIdentifier { "[" "]" }.
  //
  // In order to avoid look ahead, this can be rewritten as:
  // classBodyDeclaration ::= modifiers resultType javaIdentifier ( ( "("
  // restOfMethodDeclarator ) | restOfVariableDeclarator ).
  //
  // restOfMethodDeclarator ::= ( formalParameters* )? ")" block.
  //
  // formalParameters ::= ( formalParameter { "," formalParameter } )?.
  // restOfVariableDeclarator ::= { "[" "]" } [ "=" variableInitializer ] {
  // "," variableDeclarator } ";".
  //
  // variableDeclarator ::= javaIdentifier { "[" "]" } [ "="
  // variableInitializer ].
  //
  // with semantic constraints:
  // - Method modifiers ::= "public"? "private"? "static"? "synchronized"?.
  // - Field modifiers ::= "public"? "private"? "static" "final"? "volatile"?.
  // - Method resultType ::= "void" | type.
  // - Field resultType ::= type.
  private void classBodyDeclaration(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nclassBodyDeclaration: start");

    EnumSet<LexemeType> modifiers = modifiers();
    EnumSet<LexemeType> resultTypeStopSet = stopSet.clone();
    resultTypeStopSet.add(LexemeType.identifier);
    ResultType resultType = resultType(resultTypeStopSet);

    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.LPAREN);
    localSet.add(LexemeType.beginLexeme);
    localSet.add(LexemeType.LBRACKET);
    localSet.add(LexemeType.assign);
    if (checkOrSkip(EnumSet.of(LexemeType.identifier), localSet)) {
      String identifier = lexeme.idVal;
      lexeme = lexemeReader.getLexeme(sourceCode);
      if (lexeme.type == LexemeType.LPAREN) {
        EnumSet<LexemeType> methodStopSet = stopSet.clone();
        methodStopSet.add(LexemeType.semicolon);
        methodStopSet.add(LexemeType.RPAREN);
        restOfMethodDeclaration(modifiers, resultType, identifier, methodStopSet);
      } else {
        EnumSet<LexemeType> fieldStopSet = stopSet.clone();
        fieldStopSet.add(LexemeType.semicolon);
        restOfVariableDeclarator(modifiers, resultType, identifier, fieldStopSet);
      }
    } else {
      // extend error reporting, using lexeme types in localSet as a guidance.
      errorUnexpectedSymbol("expected an identifier");
    }

    debug("\nclassBodyDeclaration: end");
  }

  /**
   * Parse the rest of variable declarator after the modifiers, type and the
   * identifier of the first variable declarator have already been read. Global
   * variable lexeme holds the first lexeme after the first identifier.
   * 
   * @param modifiers
   * @param type
   *          holds the resultType as the type of the list of variables, where
   *          the value void is not allowed.
   * @param firstIdentifier
   * @param stopSet
   * @throws FatalError
   */
  // restOfVariableDeclarator ::= { "[" "]" } [ "=" variableInitializer ] {
  // "," variableDeclarator } ";".
  //
  // variableInitializer ::= arrayInitializer | expression.
  //
  // For now only:
  // restOfVariableDeclarator ::= [ "=" expression ] { ","
  // variableDeclarator } ";".
  //
  // field modifiers ::= "public", "private", "static", "final" or "volatile".
  //
  // TODO Support list of variable declarators, i.e. support { ","
  // variableDeclarator }.
  //
  // TODO Add array declarators { "[" "]" } to restOfVariableDeclarator.
  // TODO Add arrayInitializer to restOfVariableDeclarator.
  // TODO implement stopSet in restOfVariableDeclarator.
  private void restOfVariableDeclarator(EnumSet<LexemeType> modifiers, ResultType type, String firstIdentifier,
      EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nfieldDeclaration: start " + firstIdentifier);

    // semantic analysis of modifiers:
    // - modifier "static" is mandatory (no class instantiation).
    // - modifiers may be: "public", "private", "static", "final" or "volatile"
    if (!modifiers.contains(LexemeType.staticLexeme)) {
      error(30);
    }
    EnumSet<LexemeType> temp = modifiers.clone();
    temp.removeAll(FIELD_MODIFIERS);
    if (!temp.isEmpty()) {
      error(31);
    }

    // semantic analysis of field type:
    if (type.getType() == LexemeType.unknown) {
      error(27);
    } else if (type.getType() == LexemeType.voidLexeme) {
      error(32);
    }

    // semantic analysis of identifier:
    if (identifiers.checkId(firstIdentifier)) {
      error();
      System.out.println("variable " + firstIdentifier + " already declared.");
    } else if (identifiers.declareId(firstIdentifier, IdentifierType.field, type.getType(), modifiers)) {
      debug("\nFieldDeclaration: " + modifiers + " " + type.getType() + " " + firstIdentifier);
    } else {
      error();
      System.out.println("Error declaring identifier " + firstIdentifier + " as a field.");
    }

    // semicolon indicates single primitive variable declarator without
    // initializer.
    if (lexeme.type == LexemeType.semicolon) {
      // skip semicolon
      lexeme = lexemeReader.getLexeme(sourceCode);
    } else {
      // Add array declarators here...
      int numberOfDimensions = 0;

      // parse ( "=" VariableInitializer )?
      if (checkOrSkip(EnumSet.of(LexemeType.assign), stopSet)) {
        // skip assignment sign
        lexeme = lexemeReader.getLexeme(sourceCode);

        /*
         */
        if (numberOfDimensions == 0) {
          // EnumSet<LexemeType> localSet = stopSet.clone();
          // localSet.add(LexemeType.semicolon);
          EnumSet<LexemeType> localSet = EnumSet.of(LexemeType.semicolon);

          // part of semantic analysis.
          Variable var = identifiers.getId(firstIdentifier);
          Operand leftOperand = new Operand(OperandType.var, var.getDatatype(), var.getAddress());
          leftOperand.isFinal = var.isFinal();
          debug("\nFieldDeclaration: leftOperand = " + leftOperand);

          if (modifiers.contains(LexemeType.staticLexeme) && modifiers.contains(LexemeType.finalLexeme)) {
            // static final field is treated as compile time constant.
            // VariableDeclarator must be a compile time resolvable constant
            // expression.

            // read constant expression.
            // TODO support constant expression, not just a constant, for static
            // final fields.
            Operand rightOperand = constantExpression(localSet);

            // part of semantic analysis.
            // no assignment but constant definition.
            if (var.getDatatype() != rightOperand.datatype) {
              error(14);
            } else if (rightOperand.opType == OperandType.constant) {
              var.setIntValue(rightOperand.intValue);
              debug("\nFieldDeclaration: static final " + var.getName() + " = " + var.getIntValue());
            } else {
              error(17);
            }
          } else {
            // read expression.
            Operand rightOperand = expression(localSet);

            // part of code generation.
            generateAssignment(leftOperand, rightOperand);
            debug("\nFieldDeclaration: " + var.getName() + " = " + rightOperand);
          }

          // part of syntax analysis.
          if (checkOrSkip(EnumSet.of(LexemeType.semicolon), localSet)) {
            // skip semicolon
            lexeme = lexemeReader.getLexeme(sourceCode);
          }
        } else {
          throw new RuntimeException("Internal compiler error in restOfVariableDeclarator(): abort.");
        }
      }
    }

    debug("\nfieldDeclaration: end");
  }

  /**
   * Parse a method declaration, given that the modifiers, result type and
   * identifier have already been read. Global variable lexeme holds the left
   * bracket.
   * 
   * @param modifiers
   * @param resultType
   * @param identifier
   * @param stopSet
   * @throws FatalError
   */
  // methodDeclaration ::= resultType javaIdentifier formalParameters block.
  //
  // method modifiers ::= "public", "private", "static" or "synchronized".
  //
  // TODO implement semantic analysis of modifiers in methodDeclaration.
  // TODO implement stopSet in methodDeclaration.
  private void restOfMethodDeclaration(EnumSet<LexemeType> modifiers, ResultType resultType, String identifier,
      EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nmethodDeclaration: start " + identifier);

    // semantic analysis of modifiers:
    // - modifier "static" is mandatory (no class instantiation).
    // - modifiers may be: "public", "private", "static" or "synchronized".
    if (!modifiers.contains(LexemeType.staticLexeme)) {
      error(25);
    }
    EnumSet<LexemeType> temp = modifiers.clone();
    temp.removeAll(METHOD_MODIFIERS);
    if (!temp.isEmpty()) {
      error(26);
    }

    // semantic analysis of method return type:
    if (resultType.getType() == LexemeType.unknown) {
      error(27); // return type missing.
    }

    // semantic analysis of identifier:
    if (identifiers.checkId(identifier)) {
      error();
      System.out.println("variable " + identifier + " already declared.");
    } else if (identifiers.declareId(identifier, IdentifierType.method, resultType.getType(), modifiers)) {
      debug("\nmethodDeclaration: " + modifiers + " " + identifier + "(...)");
    } else {
      error();
      System.out.println("Error declaring identifier " + identifier + " as a method.");
    }
    // skip left bracket
    lexeme = lexemeReader.getLexeme(sourceCode);

    formalParameters();

    // part of code generation
    plant(new Instruction(FunctionType.method, identifier, modifiers, resultType));

    // part of syntax analysis
    block();

    debug("\nmethodDeclaration: end");
  } // restOfMethodDeclaration()

  // formalParameters ::= "(" [ formalParameter { "," formalParameter } ] ")".
  //
  // Global variable lexeme holds the lexeme after the left bracket.
  // TODO implement formalParameters.
  private void formalParameters() throws FatalError {
    debug("\nformalParameters: start");

    // ignore formal parameters for now;
    if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), EnumSet.of(LexemeType.semicolon, LexemeType.beginLexeme))) {
      // skip right bracket
      lexeme = lexemeReader.getLexeme(sourceCode);

      // This may be the place to set the frame pointer.
    }

    debug("\nformalParameters: end");
  } // formalParameters()

  // formalParameter ::= modifiers type variableDeclaratorId.
  //
  // TODO implement formalParameter.

  /*************************
   * 
   * ### Types
   * 
   *************************/

  // resultType ::= "void" | type.
  // type ::= referenceType | primitiveType.
  // referenceType ::= primitiveType ( "[" "]" )+.
  // primitiveType ::= "char" | "string" | "byte" | "word" | "short" | "int" |
  // "long".
  //
  // TODO implement referenceType as possible resultType.
  // TODO implement char, string, short, int or long as possible ResultType.
  private ResultType resultType(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nresultType: start");
    ResultType result = new ResultType();

    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.semicolon);
    localSet.add(LexemeType.RPAREN);
    localSet.add(LexemeType.beginLexeme);
    if (checkOrSkip(RESULT_TYPE_LEXEME_TYPES, localSet)) {
      result.setType(lexeme.type);
      // skip void or type lexeme.
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\nresultType: end; type=" + result.getType());
    return result;
  } // resultType()

  // name ::= javaIdentifier { "." javaIdentifier }.
  //
  // TODO change implementation from:
  // ...name ::= identifier {"." identifier} ["." importType]
  // to:
  // ...name ::= javaIdentifier {"." javaIdentifier}.
  private String name(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nname: start");
    String result = "";

    // recognize identifier.
    if (checkOrSkip(EnumSet.of(LexemeType.identifier), stopSet)) {
      result = lexeme.idVal;

      // recognize { "." identifier }.
      lexeme = lexemeReader.getLexeme(sourceCode);
      while (lexeme.type == LexemeType.period) {
        // skip another ".".
        result += ".";
        lexeme = lexemeReader.getLexeme(sourceCode);

        // recognize another identifier or "*" (import type).
        if (lexeme.type == LexemeType.identifier) {
          result += lexeme.idVal;
          lexeme = lexemeReader.getLexeme(sourceCode);
        } else if (lexeme.type == LexemeType.mulop && lexeme.operator == OperatorType.mul) {
          result += "*";
          lexeme = lexemeReader.getLexeme(sourceCode);
        } else {
          errorUnexpectedSymbol("found " + lexeme.type + ", expected identifer or '*'");
          while (!stopSet.contains(lexeme.type)) {
            lexeme = lexemeReader.skipAfterError(sourceCode);
          }
        }
      }
    }

    debug("\nname: end; name=" + result);
    return result;
  }

  /*************************
   * 
   * ### Statements
   * 
   *************************/

  // block ::= "{" { blockStatement } "}".
  // TODO refactor block look elsewhere; there is another block() method).
  private void block() throws FatalError {
    debug("\nblock: start");

    // skip begin lexeme
    lexeme = lexemeReader.getLexeme(sourceCode);
    statements(EnumSet.of(LexemeType.endLexeme));
    // skip end lexeme
    lexeme = lexemeReader.getLexeme(sourceCode);

    debug("\nblock: end");
  }

  // blockStatement ::= localVarDeclSttmnt | statement.`
  // TODO implement blockStatement.

  // localVarDeclSttmnt ::= localVariableDeclaration ";".`
  // TODO implement localVarDeclSttmnt.

  // localVariableDeclaration ::= modifiers type variableDeclarator {","
  // variableDeclarator}.
  // Possible modifiers: "final"? "volatile"?.
  // TODO implement localVariableDeclaration.

  // statement ::= ifStatement | statementExceptIf.
  //
  // TODO refactor statement.
  private int statement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nstatement: start with stopSet = " + stopSet);
    int firstAddress = 0;
    // part of code generation.
    acc16.clear();
    acc8.clear();

    // part of lexical analysis.
    EnumSet<LexemeType> startSet = stopSet.clone();
    startSet.addAll(START_STATEMENT);
    if (checkOrSkip(startSet, stopSet)) {
      firstAddress = saveLabel();
      if (START_ASSIGNMENT.contains(lexeme.type)) {
        statementExpression(stopSet);
        if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
          lexeme = lexemeReader.getLexeme(sourceCode);
        }
      } else if (lexeme.type == LexemeType.ifLexeme) {
        ifStatement(stopSet);
      } else if (lexeme.type == LexemeType.whileLexeme) {
        whileStatement(stopSet);
      } else if (lexeme.type == LexemeType.doLexeme) {
        doStatement(stopSet);
      } else if (lexeme.type == LexemeType.forLexeme) {
        forStatement(stopSet);
      } else if (lexeme.type == LexemeType.printlnLexeme) {
        printlnStatement(stopSet);
      } else if (lexeme.type == LexemeType.outputLexeme) {
        outputStatement(stopSet);
      } else if (lexeme.type == LexemeType.sleepLexeme) {
        sleepStatement(stopSet);
      }
    }
    debug("\nstatement: end, firstAddress = " + firstAddress);
    return firstAddress;
  } // statement

  /*********************************************
   * 
   * Old syntax parsing methods to be refactored.
   * 
   *********************************************/

  // TODO refactor syntax parsing methods below.

  // constantExpression = constant | {addop constant}.
  // TODO Implement constantExpression.
  // TODO Allow algorithmic expression as value for 'final' qualifier. See
  // test13.j.
  // TODO Generate constant in Z80 code in hex notation if the constant was
  // written in hex notation in J-code. See ledtest.j.
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
  // TODO Add support for input data (see Z80Compiler.class; call to
  // Interpreter).
  private Operand inputFactor(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\ninputFactor: start with stopSet = " + stopSet);

    // part of lexical analysis.
    // skip input symbol.
    lexeme = lexemeReader.getLexeme(sourceCode);

    EnumSet<LexemeType> stopInputSet = stopSet.clone();
    stopInputSet.addAll(START_EXPRESSION);
    stopInputSet.add(LexemeType.RPAREN);
    stopInputSet.add(LexemeType.semicolon);

    // skip left bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.LPAREN), stopInputSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // part of code generation.
    if (acc8.inUse()) {
      plant(new Instruction(FunctionType.stackAcc8));
    }

    // read constant expression.
    Operand port = constantExpression(stopInputSet);

    // skip right bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), stopInputSet)) {
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
  // TODO Introduce built in function malloc() (see test1, test5, test10,
  // test11).
  // TODO Refactor StringConstants.
  private Operand factor(EnumSet<LexemeType> stopSet) throws FatalError {
    Operand operand = new Operand(OperandType.unknown);
    debug("\nfactor 1: acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    if (checkOrSkip(START_EXPRESSION, stopSet)) {
      if (lexeme.type == LexemeType.identifier) {
        // part of semantic analysis.
        if (identifiers.checkId(lexeme.idVal)) {
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
        } else {
          throw new FatalError(9); // variable not declared.
        }
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
      } else if (lexeme.type == LexemeType.LPAREN) {
        // skip left bracket.
        lexeme = lexemeReader.getLexeme(sourceCode);
        EnumSet<LexemeType> stopSetCopy = stopSet.clone();
        stopSetCopy.add(LexemeType.RPAREN);
        operand = expression(stopSetCopy);
        // skip right bracket.
        if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), stopSet)) {
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
    followSet.add(LEXEME_TYPE_AT_LEVEL[level]);
    Operand leftOperand = (level == LEXEME_TYPE_AT_LEVEL.length - 1) ? factor(followSet) : term(level + 1, followSet);

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
    if (level < LEXEME_TYPE_AT_LEVEL.length - 1 && lexeme.type.ordinal() > LEXEME_TYPE_AT_LEVEL[level].ordinal()) {
      leftOperand = termWithOperand(level + 1, leftOperand, followSet);
    }

    // part of code generation.
    OperatorType operator;
    boolean leftOperandNotLoaded = true;
    while (lexeme.type == LEXEME_TYPE_AT_LEVEL[level]) {
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
      Operand rOperand = (level == LEXEME_TYPE_AT_LEVEL.length - 1) ? factor(followSet) : term(level + 1, followSet);

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
  // TODO Merge comparison with expression.
  private int comparison(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\ncomparison: start with stopSet = " + stopSet);

    // part of lexical analysis.
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.relop);
    Operand leftOperand = expression(localSet);
    debug("\ncomparison: leftOperand=" + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());

    // part of code generation.
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

    // part of lexical analysis.
    localSet = stopSet.clone();
    localSet.addAll(START_EXPRESSION);
    OperatorType compareOp;
    if (checkOrSkip(EnumSet.of(LexemeType.relop), localSet)) {
      // part of code generation.
      compareOp = lexeme.operator;
      // part of lexical analysis.
      lexeme = lexemeReader.getLexeme(sourceCode);
    } else {
      // part of code generation.
      compareOp = OperatorType.eq;
    }

    // part of lexical analysis.
    localSet = stopSet.clone();
    localSet.addAll(START_STATEMENT);
    localSet.remove(LexemeType.identifier);
    Operand rightOperand = expression(localSet);

    // part of code generation.
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
  } // comparison

  // parse a comparison, jump back to the label if the comparison yields true.
  // comparison = expression relop expression
  private void comparisonInDoStatement(EnumSet<LexemeType> stopSet, int doLabel) throws FatalError {
    debug("\ncomparisonInDoStatement: start with stopSet = " + stopSet);

    // part of lexical analysis.
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.relop);
    Operand leftOperand = expression(localSet);

    // part of code generation.
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

    // part of lexical analysis.
    localSet = stopSet.clone();
    localSet.addAll(START_EXPRESSION);
    OperatorType compareOp;
    if (checkOrSkip(EnumSet.of(LexemeType.relop), localSet)) {
      // part of code generation.
      compareOp = lexeme.operator;
      // part of lexical analysis.
      lexeme = lexemeReader.getLexeme(sourceCode);
    } else {
      // part of code generation.
      compareOp = OperatorType.eq;
    }

    // part of lexical analysis.
    localSet = stopSet.clone();
    localSet.addAll(START_STATEMENT);
    localSet.remove(LexemeType.identifier);
    Operand rightOperand = expression(localSet);

    // part of code generation.
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

    // part of lexical analysis.
    EnumSet<LexemeType> startSet = stopSet.clone();
    startSet.addAll(START_STATEMENT);
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

    // part of lexical analysis: "for" "(" initialization ";".
    lexeme = lexemeReader.getLexeme(sourceCode);
    EnumSet<LexemeType> stopForSet = stopSet.clone();
    stopForSet.add(LexemeType.RPAREN);
    if (checkOrSkip(EnumSet.of(LexemeType.LPAREN), stopForSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    EnumSet<LexemeType> stopInitializationSet = stopForSet.clone();
    stopInitializationSet.add(LexemeType.semicolon);
    // in the initialization part a new variable must be declared.
    String variable = statementExpression(stopInitializationSet);
    if (variable == null) {
      error();
      System.out.println("Loop variable must be declared in for statement; for (word variable; .. ; ..) {..} expected.");
    }
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    // release acc after initialization part.
    acc16.clear();
    acc8.clear();

    // part of lexical analysis: comparison ";".
    stopInitializationSet.addAll(START_STATEMENT);
    stopInitializationSet.remove(LexemeType.identifier);
    int forLabel = saveLabel();
    int gotoEnd = comparison(stopInitializationSet);
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopInitializationSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    // order of steps in p-sourcecode: comparison - update - block.
    // order of steps during execution: comparison - block - update.

    // part of code generation: skip update and jump forward to block.
    int gotoBlock = saveLabel();
    plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.word, 0)));
    int updateLabel = saveLabel();

    // release acc after comparison part.
    acc16.clear();
    acc8.clear();

    // part of lexical analysis: update.
    stopForSet.add(LexemeType.beginLexeme);
    update(stopForSet);

    // part of code generation: jump back to comparison.
    plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.word, forLabel)));

    // part of lexical analysis: ")".
    stopForSet = stopSet.clone();
    stopForSet.addAll(START_STATEMENT);
    if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), stopForSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // part of code generation: start of block.
    plantForwardLabel(gotoBlock, saveLabel());

    // part of lexical analysis: block.
    block(stopSet);

    // part of code generation; jump back to update.
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

    // part of code generation.
    int doLabel = saveLabel();

    // part of lexical analysis.
    // expect block, terminated by "while".
    EnumSet<LexemeType> stopDoSet = stopSet.clone();
    stopDoSet.add(LexemeType.whileLexeme);
    block(stopSet);

    // expect "while" followed by "(".
    EnumSet<LexemeType> stopWhileSet = stopSet.clone();
    stopWhileSet.add(LexemeType.RPAREN);
    if (checkOrSkip(EnumSet.of(LexemeType.whileLexeme), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    if (checkOrSkip(EnumSet.of(LexemeType.LPAREN), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // release acc after block part.
    acc16.clear();
    acc8.clear();

    // expect comparison, terminated by ")"
    stopWhileSet.addAll(START_STATEMENT);
    stopWhileSet.remove(LexemeType.identifier);
    comparisonInDoStatement(stopWhileSet, doLabel);

    // expect ")" ";"
    stopWhileSet = stopSet.clone();
    stopWhileSet.add(LexemeType.semicolon);
    if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), stopSet)) {
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

    // part of code generation.
    int whileLabel = saveLabel();

    // part of lexical analysis.
    EnumSet<LexemeType> stopWhileSet = stopSet.clone();
    stopWhileSet.add(LexemeType.RPAREN);
    if (checkOrSkip(EnumSet.of(LexemeType.LPAREN), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // part of lexical analysis.
    stopWhileSet.addAll(START_STATEMENT);
    stopWhileSet.remove(LexemeType.identifier);
    int endLabel = comparison(stopWhileSet);

    stopWhileSet = stopSet.clone();
    stopWhileSet.addAll(START_STATEMENT);
    if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    block(stopSet);

    // part of code generation.
    plantThenSource(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.word, whileLabel)));
    plantForwardLabel(endLabel, saveLabel());
    debug("\nwhileStatement: end");
  } // whileStatement()

  // outputStatement = "output" "(" constantExpression "," expression ")".
  // TODO Add non-constant port value to output/input (IN0 A,(C); OUT0 (C),A).
  // TODO Test various expressions for output(byte port, byte value). See
  // ledtest.j.
  private void outputStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\noutputStatement: start with stopSet = " + stopSet);

    // part of lexical analysis.
    // skip output symbol.
    lexeme = lexemeReader.getLexeme(sourceCode);

    EnumSet<LexemeType> stopOutputSet = stopSet.clone();
    stopOutputSet.addAll(START_EXPRESSION);
    stopOutputSet.add(LexemeType.comma);
    stopOutputSet.add(LexemeType.RPAREN);
    stopOutputSet.add(LexemeType.semicolon);

    // skip left bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.LPAREN), stopOutputSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    EnumSet<LexemeType> stopExpressionSet = stopSet.clone();
    stopExpressionSet.add(LexemeType.comma);
    stopExpressionSet.add(LexemeType.RPAREN);
    stopExpressionSet.add(LexemeType.semicolon);

    // read constant expression.
    Operand port = constantExpression(stopExpressionSet);

    // part of lexical analysis.
    stopOutputSet = stopSet.clone();
    stopOutputSet.addAll(START_EXPRESSION);
    stopOutputSet.add(LexemeType.RPAREN);
    stopOutputSet.add(LexemeType.semicolon);

    // skip comma.
    if (checkOrSkip(EnumSet.of(LexemeType.comma), stopOutputSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    stopExpressionSet = stopSet.clone();
    stopExpressionSet.add(LexemeType.RPAREN);
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
    if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), stopExpressionSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // skip semicolon.
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\noutput: end");
  } // outputStatement

  // sleepStatement = "sleep" "(" expression ")".
  private void sleepStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nsleep: start with stopSet = " + stopSet);

    // part of lexical analysis.
    // skip sleep symbol.
    lexeme = lexemeReader.getLexeme(sourceCode);

    EnumSet<LexemeType> stopSleepSet = stopSet.clone();
    stopSleepSet.addAll(START_EXPRESSION);
    stopSleepSet.add(LexemeType.RPAREN);
    stopSleepSet.add(LexemeType.semicolon);

    // skip left bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.LPAREN), stopSleepSet)) {
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
    if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // skip semicolon.
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\nsleep: end");
  } // sleepStatement

  // ifStatement = "if" "(" comparison ")" block [ "else" block ].
  private void ifStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nifStatement: start with stopSet = " + stopSet);

    lexeme = lexemeReader.getLexeme(sourceCode);

    // expect (
    EnumSet<LexemeType> stopSetIf = stopSet.clone();
    stopSetIf.add(LexemeType.RPAREN);
    if (checkOrSkip(EnumSet.of(LexemeType.LPAREN), stopSetIf)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // expect comparison
    stopSetIf = stopSet.clone();
    stopSetIf.add(LexemeType.RPAREN);
    stopSetIf.addAll(START_STATEMENT);
    stopSetIf.remove(LexemeType.identifier);
    int ifLabel = comparison(stopSetIf);
    debug("\nifStatement: ifLabel = " + ifLabel);

    // expect )
    stopSetIf = stopSet.clone();
    stopSetIf.addAll(START_STATEMENT);
    if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), stopSetIf)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // expect statement block
    EnumSet<LexemeType> stopSetElse = stopSet.clone();
    stopSetElse.add(LexemeType.elseLexeme);
    block(stopSetElse);

    if (lexeme.type == LexemeType.elseLexeme) {
      // expect else
      checkOrSkip(EnumSet.of(LexemeType.elseLexeme), stopSetElse);

      // part of code generation.
      int elseLabel = saveLabel();
      plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.word, 0)));
      debug("\nifStatement: elselabel=" + elseLabel);
      debug("\nifStatement: plantForwardLabel(" + ifLabel + ")");

      // part of lexical analysis.
      // expect statement block
      lexeme = lexemeReader.getLexeme(sourceCode);
      plantForwardLabel(ifLabel, block(stopSet));

      // part of code generation.
      plantForwardLabel(elseLabel, saveLabel());
    } else {
      // part of code generation.
      debug("\nifStatement: plantForwardLabel(" + ifLabel + ")");
      plantForwardLabel(ifLabel, saveLabel());
    }
    debug("\nifStatement: end");
  } // ifStatement()

  // statementExpression ::= assignment | preincrementExpression |
  // postincrementExpression | predecrementExpression | postdecrementExpression
  // | methodInvocation.
  //
  // is:
  // statementExpression = [declaration] update ";".
  // declaration = [qualifier] datatype.
  // qualifier = "final".
  // datatype = "byte" | "word" | "String".
  //
  // TODO implement isPublic
  private String statementExpression(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nstatementExpression: start with stopSet = " + stopSet + "; lexeme.type=" + lexeme.type);

    EnumSet<LexemeType> stopAssignmentSet = stopSet.clone();
    stopAssignmentSet.addAll(START_EXPRESSION);
    stopAssignmentSet.add(LexemeType.semicolon);

    // part of lexical analysis.
    EnumSet<LexemeType> modifiers = EnumSet.noneOf(LexemeType.class);
    if (lexeme.type == LexemeType.finalLexeme) {
      modifiers.add(lexeme.type);
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
          error();
          System.out.println("variable " + lexeme.idVal + " already declared.");
        } else if (identifiers.declareId(lexeme.idVal, IdentifierType.variable, datatype, modifiers)) {
          debug("\nstatementExpression: " + modifiers + lexeme.makeString(identifiers.getId(lexeme.idVal)));
          variable = lexeme.idVal;
        } else {
          error();
          System.out.println("Error declaring identifier " + lexeme.idVal + " of type " + datatype + " as a variable");
        }
      }
    } else {
      checkOrSkip(EnumSet.of(LexemeType.identifier), stopAssignmentSet);

      // part of semantic analysis.
      if (!identifiers.checkId(lexeme.idVal))
        error(9); // variable not declared.
    }

    update(stopSet);

    debug("\nstatementExpression: end");
    return variable;
  } // statementExpression()

  // update = identifier++ | identifier-- | identifier "=" expression
  private void update(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nupdate: start with stopSet = " + stopSet);

    EnumSet<LexemeType> stopAssignmentSet = stopSet.clone();
    stopAssignmentSet.addAll(START_EXPRESSION);
    stopAssignmentSet.add(LexemeType.semicolon);

    // part of semantic analysis.
    Variable var = identifiers.getId(lexeme.idVal);
    Operand leftOperand = new Operand(OperandType.var, var.getDatatype(), var.getAddress());
    leftOperand.isFinal = var.isFinal();
    debug("\nupdate: leftOperand = " + leftOperand);

    // part of lexical analysis.
    lexeme = lexemeReader.getLexeme(sourceCode);
    if (lexeme.type == LexemeType.addop && lexeme.operator == OperatorType.sub) {
      // identifier--
      lexeme = lexemeReader.getLexeme(sourceCode);
      if (lexeme.type == LexemeType.addop && lexeme.operator == OperatorType.sub) {
        lexeme = lexemeReader.getLexeme(sourceCode);

        // part of code generation.
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

        // part of code generation.
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
      Operand rightOperand = expression(stopSet);

      // part of code generation.
      if (var.isFinal()) {
        // no assignment but constant definition.
        if (var.getDatatype() != rightOperand.datatype) {
          error(14);
        } else if (rightOperand.opType == OperandType.constant) {
          var.setIntValue(rightOperand.intValue);
          debug("\nupdate: final var [" + var.getName() + "] = " + var.getIntValue());
        } else {
          error(17);
        }
      } else {
        generateAssignment(leftOperand, rightOperand);
      }
    }

    debug("\nupdate: end");
  } // update()

  /**
   * Generate M-code for an assignment.
   * 
   * @param leftOperand
   * @param rightOperand
   */
  private void generateAssignment(Operand leftOperand, Operand rightOperand) {
    // part of code generation.
    debug("\ngenerateAssignment: leftOperand = " + leftOperand + ", operand = " + rightOperand);
    // operand to accu.
    if (rightOperand.opType != OperandType.acc) {
      plantAccLoad(rightOperand);
    }
    // actual assignment.
    if (rightOperand.datatype == Datatype.word || rightOperand.datatype == Datatype.string) {
      plant(new Instruction(FunctionType.acc16Store, leftOperand));
    } else if (rightOperand.datatype == Datatype.byt) {
      plant(new Instruction(FunctionType.acc8Store, leftOperand));
    } else {
      error(12);
    }
    // clear acc
    if (acc8.inUse()) {
      acc8.clear();
    } else if (acc16.inUse()) {
      acc16.clear();
    }
  }

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
    stopWriteSet.addAll(START_EXPRESSION);
    stopWriteSet.add(LexemeType.RPAREN);
    stopWriteSet.add(LexemeType.semicolon);

    // skip left bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.LPAREN), stopWriteSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // read first operand.
    EnumSet<LexemeType> stopExpressionSet = stopSet.clone();
    stopExpressionSet.add(LexemeType.RPAREN);
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
        } else if (lexeme.type != LexemeType.RPAREN) {
          // part of lexical analysis.
          // only + symbol allowed between terms in string expression.
          errorUnexpectedSymbol(" " + lexeme.makeString(null));
          // skip unexpected symbol.
          if (checkOrSkip(EnumSet.of(lexeme.type), stopWriteSet)) {
            lexeme = lexemeReader.getLexeme(sourceCode);
          }
        }
      } while (lexeme.type != LexemeType.RPAREN);

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
    if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), stopExpressionSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // skip semicolon.
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\nprintlnStatement: end");
  } // printlnStatement

  // parse a sequence of statements, and return the address of the first object
  // code in the sequence of statements.
  // statements = statement*.
  private int statements(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nstatements: start with stopSet = " + stopSet);
    int firstAddress = 0;

    // while (checkOrSkip(START_STATEMENT, stopSet)) {
    while (START_STATEMENT.contains(lexeme.type)) {
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

  private void plant(Instruction instruction) {
    // for debugging purposes.
    debug("\n->plant (acc8InUse=" + acc8.inUse() + ", acc16InUse=" + acc16.inUse() + ", lastSourceLineNr=" + lastSourceLineNr
        + ", sourceLineNr=" + lexeme.sourceLineNr + ", linesOfSourceCode=" + sourceCode.size() + "):");
    plantSource();
    plantCode(instruction);
  } // plant

  private void plantThenSource(Instruction instruction) {
    // for debugging purposes.
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

    // for debugging purposes.
    debug("\n" + String.format(LINE_NR_FORMAT, instructions.size()) + instruction.toString());
    debug(" ;" + instruction.function);
    if (instruction.operand != null) {
      debug(" " + instruction.operand);
    }

    // insert M-code (virtual machine code) into memory.
    instructions.add(instruction);

    // update accumulator metadata.
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

    // update stack metadata.
    if (instruction.function == FunctionType.unstackAcc8) {
      popStackedDatatype(Datatype.byt);
    } else if (instruction.function == FunctionType.unstackAcc16) {
      popStackedDatatype(Datatype.word);
    } else if (instruction.operand != null && instruction.operand.opType == OperandType.stack8) {
      popStackedDatatype(Datatype.byt);
    } else if (instruction.operand != null && instruction.operand.opType == OperandType.stack16) {
      popStackedDatatype(Datatype.word);
    }

    // for debugging purposes.
    debug(" ;" + " stackedDatatypes=" + stackedDatatypes);
  } // plantCode

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
  } // plantPrintln

  private void plantForwardLabel(int pos, int address) {
    // skip original source code that has been added as comment before the
    // branch instruction.
    while (instructions.get(pos).function == FunctionType.comment) {
      pos++;
    }

    instructions.get(pos).operand.intValue = address;

    // for debugging purposes.
    debug("\nplantForwardLabel instruction[" + pos + "]=" + address);
  } // plantForwardLabel

  private int saveLabel() {
    // address of next object code.
    int address = instructions.size();

    // compensate address for original source code that will be added as comment
    // before the next instruction.
    int compensatedAddress = address + sourceCode.size();

    // for debugging purposes.
    debug("\nlabel: address = " + address + ", compensated for comments = " + compensatedAddress);

    return compensatedAddress;
  } // saveLabel

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
  } // plantStringConstants

  private void updateReferencesToStringConstants(int offset) {
    Map<Integer, ArrayList<Integer>> stringReferences = new HashMap<Integer, ArrayList<Integer>>();
    int lineNumber = 0;
    Instruction instruction;
    do {
      instruction = instructions.get(lineNumber);
      if (STRING_CONSTANT_FUNCTIONS.contains(instruction.function) && instruction.operand != null
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
  } // updateReferencesToStringConstants

  /*****************************
   *
   * Code optimization methods
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
      if (BRANCH_FUNCTIONS.contains(instruction.function) && (instruction.operand.intValue > pos)) {
        instruction.operand.intValue -= number;
      }
    } while (instruction.function != FunctionType.stop);
  } // relocate

}
