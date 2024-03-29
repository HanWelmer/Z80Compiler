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

      // code generation.
      plant(new Instruction(FunctionType.call, new Operand("main", 0)));
      plant(new Instruction(FunctionType.stop));

      // lexical analysis, semantic analysis and code generation.
      compilationUnit();
      debug("\n");

      // post processing.
      optimize();
      updateReferencesToMethods();
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
  // Possible lexeme types in Type.
  private static final EnumSet<LexemeType> TYPE_LEXEME_TYPES = EnumSet.of(LexemeType.byteLexeme, LexemeType.wordLexeme,
      LexemeType.stringLexeme);
  // Possible lexeme types in ResultType.
  private static final EnumSet<LexemeType> RESULT_TYPE_LEXEME_TYPES = EnumSet.of(LexemeType.voidLexeme, LexemeType.byteLexeme,
      LexemeType.wordLexeme, LexemeType.stringLexeme);
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
  // Possible lexeme types as local variable modifiers.
  private static final EnumSet<LexemeType> LOCAL_VARIABLE_MODIFIERS = EnumSet.of(LexemeType.finalLexeme, LexemeType.volatileLexeme);
  // Lexeme types in an expression in increasing order of precedence.
  private static final LexemeType[] LEXEME_TYPE_AT_LEVEL = { LexemeType.bitwiseOrOp, LexemeType.bitwiseXorOp,
      LexemeType.bitwiseAndOp, LexemeType.addop, LexemeType.mulop };
  // Lexeme types that start a statement.
  private static final EnumSet<LexemeType> START_STATEMENT = EnumSet.of(LexemeType.beginLexeme, LexemeType.semicolon,
      LexemeType.finalLexeme, LexemeType.identifier, LexemeType.byteLexeme, LexemeType.wordLexeme, LexemeType.stringLexeme,
      LexemeType.ifLexeme, LexemeType.whileLexeme, LexemeType.doLexeme, LexemeType.forLexeme, LexemeType.returnLexeme,
      LexemeType.printlnLexeme, LexemeType.outputLexeme, LexemeType.sleepLexeme);
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
  private ArrayList<Symbol> methodSymbolTable = new ArrayList<Symbol>();
  Map<String, ArrayList<Integer>> methodReferences = new HashMap<String, ArrayList<Integer>>();
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

    // initialisation of lexical analysis variables.

    // initialisation of semantic analysis variables.
    packageName = "";
    identifiers.init();
    stringConstants.init();

    // initialisation of code generation variables.
    clearRegisters();
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

  /**
   * Clear runtime registers.
   */
  protected void clearRegisters() {
    acc16.clear();
    acc8.clear();
  }

  private void error() {
    errors++;
    lexemeReader.error();
  }

  private void error(int n, String message) {
    error(n);
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
        System.out.println("unexpected type in field or local variable declaration.");
        break;
      case 33:
        System.out.println("superfluous text between end of type declaration and end of file.");
        break;
      case 34:
        System.out.println("assignment to a final variable.");
        break;
      case 35:
        System.out.println("unexpected modifier in local variable declaration.");
        break;
      case 36:
        System.out.println("method not declared.");
        break;
      case 37:
        System.out.println("incompatible return type.");
        break;
      case 38:
        System.out.print("symbol not found: ");
        break;
      case 39:
        System.out.print("number of actual parameters does not match number of formal parameters.");
        break;
      case 40:
        System.out.println("combination of final and volatile modifiers not allowed");
        break;
    }
  } // error

  /*************************
   *
   * lexical analysis methods
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
      error(3, "found " + lexeme.type + ", expected " + okSet);
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
   * lexical parsing methods.
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

      // code generation
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

      // code generation
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

      if (lexeme.type == LexemeType.classLexeme) {
        classDecl(isPublic, stopSet);
      } else if (lexeme.type == LexemeType.enumLexeme) {
        enumDecl();
      } else {
        error(3, lexeme.makeString(null));
      }
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

    // syntax analysis.
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.identifier);
    localSet.add(LexemeType.beginLexeme);
    if (checkOrSkip(EnumSet.of(LexemeType.classLexeme), localSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);

      localSet = stopSet.clone();
      localSet.add(LexemeType.beginLexeme);
      if (checkOrSkip(EnumSet.of(LexemeType.identifier), localSet)) {
        // semantic analysis.
        String identifier = lexeme.idVal;
        if (identifiers.declareId(identifier, IdentifierType.CLAZZ, LexemeType.classLexeme, modifiers)) {
          debug("\nclassDecl: " + (isPublic ? "public " : "") + "class declared: " + identifier);
        } else {
          error();
          System.out.println("Class identifier " + identifier + " already declared.");
        }

        // code generation
        plant(new Instruction(FunctionType.classFunction, identifier, modifiers, null));

        // syntax analysis
        classBody(stopSet);
      }
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

    EnumSet<LexemeType> localStopSet = stopSet.clone();
    localStopSet.add(LexemeType.LPAREN);
    localStopSet.add(LexemeType.beginLexeme);
    localStopSet.add(LexemeType.LBRACKET);
    localStopSet.add(LexemeType.assign);
    localStopSet.add(LexemeType.comma);
    if (checkOrSkip(EnumSet.of(LexemeType.identifier), localStopSet)) {
      String identifier = lexeme.idVal;
      lexeme = lexemeReader.getLexeme(sourceCode);
      if (lexeme.type == LexemeType.LPAREN) {
        EnumSet<LexemeType> methodStopSet = stopSet.clone();
        methodStopSet.add(LexemeType.semicolon);
        methodStopSet.add(LexemeType.RPAREN);
        restOfMethodDeclaration(modifiers, resultType, identifier, methodStopSet);
      } else {
        // semantic analysis
        checkFieldModifiers(modifiers);

        // semantic analysis
        if (resultType.getType() == LexemeType.unknown) {
          error(27);
        } else if (resultType.getType() == LexemeType.voidLexeme) {
          error(32);
        }

        // lexical analysis
        EnumSet<LexemeType> fieldStopSet = localStopSet.clone();
        fieldStopSet.add(LexemeType.semicolon);
        restOfVariableDeclarator(modifiers, resultType, identifier, IdentifierType.CLASS_VARIABLE, fieldStopSet);

        if (checkOrSkip(EnumSet.of(LexemeType.semicolon), localStopSet)) {
          // skip semicolon
          lexeme = lexemeReader.getLexeme(sourceCode);
        }
      }
    } else {
      // extend error reporting, using lexeme types in localSet as a guidance.
      error(3, "expected an identifier");
    }

    debug("\nclassBodyDeclaration: end");
  }

  protected void checkFieldModifiers(EnumSet<LexemeType> modifiers) {
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
  }

  /**
   * restOfVariableDeclarator ::= { "[" "]" } [ "=" variableInitializer ] { ","
   * variableDeclarator }.
   * 
   * Parse the rest of variable declarator after the modifiers, type and the
   * identifier of the first variable declarator have been read. Global variable
   * lexeme holds the first lexeme after the first identifier.
   * 
   * @param modifiers
   *          holds the list of modifiers, i.e. public, private, static, final
   *          and/or volatile.
   * @param type
   *          holds the resultType as the type of the list of variables, where
   *          the value void is not allowed.
   * @param firstIdentifier
   *          name of the first identifier in the list of field or variable
   *          declaration.
   * @param identifierType
   *          indicates if the identifiers are class variables (fields) or local
   *          variables (variables).
   * @param stopSet
   * @throws FatalError
   */
  // variableDeclarator ::= variableDeclaratorId [ "=" variableInitializer ].
  // variableDeclaratorId ::= javaIdentifier { "[" "]" }.
  // variableInitializer ::= arrayInitializer | expression.
  //
  // For now only:
  // restOfVariableDeclarator ::= [ "=" expression ].
  //
  // TODO Support list of variable declarators, i.e. support { ","
  // variableDeclarator }.
  // TODO Add array declarators { "[" "]" } to restOfVariableDeclarator.
  // TODO Add arrayInitializer to restOfVariableDeclarator.
  // TODO implement stopSet in restOfVariableDeclarator.
  private void restOfVariableDeclarator(EnumSet<LexemeType> modifiers, ResultType type, String firstIdentifier,
      IdentifierType identifierType, EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nfieldDeclaration: start " + firstIdentifier);

    // semantic analysis
    if (identifiers.declareId(firstIdentifier, identifierType, type.getType(), modifiers)) {
      debug(String.format("\n%s declaration: $s %s %s", identifierType, modifiers, type.getType(), firstIdentifier));
    } else {
      error();
      System.out.println("variable " + firstIdentifier + " already declared.");
    }

    // semicolon indicates single primitive variable declarator without
    // initializer.
    if (lexeme.type == LexemeType.semicolon) {
      // skip semicolon
      // lexeme = lexemeReader.getLexeme(sourceCode);
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

          // semantic analysis.
          Variable var = identifiers.getId(firstIdentifier);
          Operand leftOperand = new Operand(var.getIdentifierType(), var.getDatatype(), var.getAddress());
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

            // semantic analysis.
            // no assignment but constant definition.
            if (var.getDatatype() != rightOperand.datatype) {
              error(14);
            } else if (rightOperand.opType == OperandType.CONSTANT) {
              var.setIntValue(rightOperand.intValue);
              debug("\nFieldDeclaration: static final " + var.getName() + " = " + var.getIntValue());
            } else {
              error(17);
            }
          } else {
            // read expression.
            Operand rightOperand = expression(localSet);

            // code generation.
            generateAssignment(leftOperand, rightOperand);
            debug("\nFieldDeclaration: " + var.getName() + " = " + rightOperand);
          }
        } else {
          throw new RuntimeException("Internal compiler error in restOfVariableDeclarator(): abort.");
        }

        // code generation.
        clearRegisters();
      }
    }

    debug("\nfieldDeclaration: end");
  }

  /**
   * methodDeclaration ::= resultType javaIdentifier formalParameters block.
   * 
   * method modifiers ::= "public", "private", "static" or "synchronized".
   * 
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
  // restOfMethodDeclarator ::= ( formalParameters* )? ")" block.
  //
  // formalParameters ::= ( formalParameter { "," formalParameter } )?.
  //
  // TODO implement semantic analysis of modifiers in methodDeclaration.
  // TODO implement stopSet in methodDeclaration.
  // TODO implement code generation for less than trivial return statement.
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
    if (identifiers.declareId(identifier, IdentifierType.METHOD, resultType.getType(), modifiers)) {
      debug("\nmethodDeclaration: " + modifiers + " " + identifier + "(...)");
    } else {
      error();
      System.out.println("identifier " + identifier + " already declared.");
    }
    // skip left bracket
    lexeme = lexemeReader.getLexeme(sourceCode);

    formalParameters();

    // code generation
    int methodAddress = saveLabel();
    plant(new Instruction(FunctionType.method, identifier, modifiers, resultType));
    // set start address for this method.
    identifiers.getId(identifier).setIntValue(methodAddress);
    // add method to symbol table.
    Symbol newSymbol = new Symbol();
    newSymbol.address = methodAddress;
    newSymbol.packageName = packageName;
    newSymbol.name = identifier;
    newSymbol.resultType = resultType;
    newSymbol.modifiers = modifiers;
    methodSymbolTable.add(newSymbol);
    // save current base pointer
    plant(new Instruction(FunctionType.stackBasePointer));
    // allocate space on stack for local variables.
    plant(new Instruction(FunctionType.basePointerLoad, new Operand(OperandType.STACK_POINTER)));
    int moveStackPointerAddress = saveLabel();
    plant(new Instruction(FunctionType.stackPointerPlus, new Operand(OperandType.CONSTANT, Datatype.word, 0)));

    // semantic analysis: start a new method level declaration scope.
    identifiers.newScope();
    identifiers.resetScopeSize();

    // lexical analysis
    block(stopSet);

    // code generation
    setScopeSize(moveStackPointerAddress, identifiers.getScopeSize());
    // release space on stack for local variables.
    plantCode(new Instruction(FunctionType.stackPointerLoad, new Operand(OperandType.BASE_POINTER)));
    // reset base pointer and return to caller
    plantCode(new Instruction(FunctionType.unstackBasePointer));
    plantThenSource(new Instruction(FunctionType.returnFunction));

    // semantic analysis: close the method level declaration scope.
    identifiers.closeScope();

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
          error(3, "found " + lexeme.type + ", expected identifer or '*'");
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
  //
  // parse a block of statements, and return the address of the first object
  // code in the block of statements.
  private int block(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nblock: start with stopSet = " + stopSet);

    // semantic analysis: address of next object code instruction.
    int firstAddress = saveLabel();

    // lexical analysis.
    EnumSet<LexemeType> stopBlockSet = stopSet.clone();
    stopBlockSet.add(LexemeType.semicolon);
    stopBlockSet.add(LexemeType.endLexeme);
    if (checkOrSkip(EnumSet.of(LexemeType.beginLexeme), stopBlockSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);

      // semantic analysis: start a new declaration scope.
      identifiers.newScope();

      // lexical analysis.
      while (lexeme.type != LexemeType.endLexeme) {
        blockStatement(EnumSet.of(LexemeType.endLexeme));
      }

      // semantic analysis: close the declaration scope.
      identifiers.closeScope();

      // lexical analysis: skip endLexeme
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\nblock: end, firstAddress = " + firstAddress);
    return firstAddress;
  } // block

  // blockStatement ::= localVariableStatement | statement.
  private void blockStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nblockStatement: start with stopSet = " + stopSet);

    // lexical analysis.
    if (TYPE_LEXEME_TYPES.contains(lexeme.type) || FIELD_MODIFIERS.contains(lexeme.type)) {
      localVariableStatement(stopSet);
    } else {
      statement(stopSet);
    }

    debug("\nblockStatement");
  }// blockStatement

  // localVariableStatement ::= localVariableDeclaration ";".
  private void localVariableStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    EnumSet<LexemeType> localStopSet = stopSet.clone();
    localStopSet.add(LexemeType.semicolon);
    localVariableDeclaration(localStopSet);
    checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet);
  }

  // localVariableDeclaration ::= modifiers type variableDeclarators.
  // variableDeclarators ::= variableDeclarator { "," variableDeclarator }.
  // variableDeclarator ::= variableDeclaratorId [ "=" variableInitializer ].
  // variableDeclaratorId ::= javaIdentifier { "[" "]" }.
  //
  // In order to reuse restOfVariableDeclarator() as called by
  // classBodyDeclaration(), this is rewritten as:
  //
  // localVariableDeclaration ::= modifiers resultType javaIdentifier
  // restOfVariableDeclarator.
  //
  // with semantic constraints:
  // - Variable modifiers ::= "final"? "volatile"?.
  // - Variable resultType ::= type.
  private void localVariableDeclaration(EnumSet<LexemeType> stopSet) throws FatalError {
    // lexical analysis
    EnumSet<LexemeType> modifiers = modifiers();

    // semantic analysis
    // Possible modifiers for a local variable: "final"? "volatile"?.
    EnumSet<LexemeType> temp = modifiers.clone();
    temp.removeAll(LOCAL_VARIABLE_MODIFIERS);
    if (!temp.isEmpty()) {
      error(35);
    } else if (modifiers.contains(LexemeType.finalLexeme) && modifiers.contains(LexemeType.volatileLexeme)) {
      error(40);
    }

    // lexical analysis
    EnumSet<LexemeType> localStopSet = stopSet.clone();
    localStopSet.add(LexemeType.identifier);
    ResultType type = resultType(localStopSet);

    // semantic analysis
    if (type.getType() == LexemeType.unknown) {
      error(27);
    } else if (type.getType() == LexemeType.voidLexeme) {
      error(32);
    }

    // lexical analysis
    localStopSet = stopSet.clone();
    localStopSet.add(LexemeType.LBRACKET);
    localStopSet.add(LexemeType.assign);
    localStopSet.add(LexemeType.comma);
    if (checkOrSkip(EnumSet.of(LexemeType.identifier), localStopSet)) {
      String identifier = lexeme.idVal;
      lexeme = lexemeReader.getLexeme(sourceCode);

      localStopSet.add(LexemeType.semicolon);
      restOfVariableDeclarator(modifiers, type, identifier, IdentifierType.LOCAL_VARIABLE, localStopSet);
    } else {
      // extend error reporting, using lexeme types in localSet as a guidance.
      error(3, "expected an identifier");
    }

    // code generation.
    clearRegisters();
  } // localVariableDeclaration

  // statement ::= ifStatement | statementExceptIf.
  private int statement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nstatement: start with stopSet = " + stopSet);
    int firstAddress = saveLabel();

    if (lexeme.type == LexemeType.ifLexeme) {
      ifStatement(stopSet);
    } else {
      statementExceptIf(stopSet);
    }

    debug("\nstatement: end, firstAddress = " + firstAddress);
    return firstAddress;
  }// statement

  // ifStatement ::= "if" "(" expression ")" statementExceptIf ["else"
  // statement].
  //
  // TODO refactor ifStatement
  // ifStatement = "if" "(" comparison ")" block [ "else" block ].
  //
  // TODO optimize branch instruction in ifStatement
  // See test5.j 163: if (b>132) {
  // 1326 acc8= variable 14
  // 1327 acc8Comp constant 132
  // 1328 brle 1345
  // received: 1328 brle 1345
  // expected: 1328 brle 1346
  private void ifStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nifStatement: start with stopSet = " + stopSet);

    // lexical analysis.
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

    // code generation.
    clearRegisters();

    // expect any statement or block, but not an if statement.
    EnumSet<LexemeType> stopSetElse = stopSet.clone();
    stopSetElse.add(LexemeType.elseLexeme);
    statementExceptIf(stopSetElse);

    if (lexeme.type == LexemeType.elseLexeme) {
      // expect else
      checkOrSkip(EnumSet.of(LexemeType.elseLexeme), stopSetElse);

      // code generation.
      int elseLabel = saveLabel();
      plant(new Instruction(FunctionType.br, new Operand(OperandType.LABEL, Datatype.word, 0)));
      debug("\nifStatement: elselabel=" + elseLabel);
      debug("\nifStatement: plantForwardLabel(" + ifLabel + ")");

      // lexical analysis.
      // expect statement block
      lexeme = lexemeReader.getLexeme(sourceCode);
      plantForwardLabel(ifLabel, statement(stopSet));

      // code generation.
      plantForwardLabel(elseLabel, saveLabel());
    } else {
      // code generation.
      debug("\nifStatement: plantForwardLabel(" + ifLabel + ")");
      plantForwardLabel(ifLabel, saveLabel());
    }
    debug("\nifStatement: end");
  } // ifStatement()

  // statementExceptIf ::= block | emptyStatement | whileStatement | doStatement
  // | forStatement | returnStatement | printlnStatement |
  // outputStatement | sleepStatement | expressionStatement.
  private int statementExceptIf(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nstatementExceptIf: start with stopSet = " + stopSet);

    // code generation.
    int firstAddress = saveLabel();

    // lexical analysis.
    switch (lexeme.type) {
      case beginLexeme:
        block(stopSet);
        break;
      case semicolon:
        emptyStatement(stopSet);
        break;
      case whileLexeme:
        whileStatement(stopSet);
        break;
      case doLexeme:
        doStatement(stopSet);
        break;
      case forLexeme:
        forStatement(stopSet);
        break;
      case returnLexeme:
        returnStatement(stopSet);
        break;
      case printlnLexeme:
        printlnStatement(stopSet);
        break;
      case outputLexeme:
        outputStatement(stopSet);
        break;
      case sleepLexeme:
        sleepStatement(stopSet);
        break;
      default:
        expressionStatement(stopSet);
    }

    // code generation.
    clearRegisters();

    debug("\nstatementExceptIf: end, firstAddress = " + firstAddress);
    return firstAddress;
  } // statementExceptIf

  // emptyStatement ::= ";".
  private void emptyStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nemptyStatement: start with stopSet = " + stopSet);
    // lexeme.type is ";". Add it to m-code output and Skip it.
    plantSource();
    lexeme = lexemeReader.getLexeme(sourceCode);
    debug("\nemptyStatement: end");
  }

  // whileStatement ::= "while" "(" expression ")" statementExceptIf.
  //
  // TODO refactor whileStatement.
  // whileStatement = "while" "(" comparison ")" block.
  private void whileStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nwhileStatement: start with stopSet = " + stopSet);
    lexeme = lexemeReader.getLexeme(sourceCode);

    // code generation.
    int whileLabel = saveLabel();

    // lexical analysis.
    EnumSet<LexemeType> stopWhileSet = stopSet.clone();
    stopWhileSet.add(LexemeType.RPAREN);
    if (checkOrSkip(EnumSet.of(LexemeType.LPAREN), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // lexical analysis.
    stopWhileSet.addAll(START_STATEMENT);
    stopWhileSet.remove(LexemeType.identifier);
    int endLabel = comparison(stopWhileSet);

    // code generation.
    clearRegisters();

    // lexical analysis.
    stopWhileSet = stopSet.clone();
    stopWhileSet.addAll(START_STATEMENT);
    if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    // block(stopSet);
    statementExceptIf(stopSet);

    // code generation.
    plantThenSource(new Instruction(FunctionType.br, new Operand(OperandType.LABEL, Datatype.word, whileLabel)));
    plantForwardLabel(endLabel, saveLabel());
    debug("\nwhileStatement: end");
  } // whileStatement()

  // doStatement ::= "do" statement "while" "(" expression ")" ";".
  //
  // TODO refactor doStatement
  // doStatement = "do" block "while" "(" comparison ")" ";".
  private void doStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\ndoStatement: start with stopSet = " + stopSet);
    lexeme = lexemeReader.getLexeme(sourceCode);

    // code generation.
    int doLabel = saveLabel();

    // lexical analysis.
    // expect block, terminated by "while".
    EnumSet<LexemeType> stopDoSet = stopSet.clone();
    stopDoSet.add(LexemeType.whileLexeme);
    statement(stopSet);

    // expect "while" followed by "(".
    EnumSet<LexemeType> stopWhileSet = stopSet.clone();
    stopWhileSet.add(LexemeType.RPAREN);
    if (checkOrSkip(EnumSet.of(LexemeType.whileLexeme), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    if (checkOrSkip(EnumSet.of(LexemeType.LPAREN), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // code generation.
    clearRegisters();

    // expect comparison, terminated by ")"
    stopWhileSet.addAll(START_STATEMENT);
    stopWhileSet.remove(LexemeType.identifier);
    comparisonInDoStatement(stopWhileSet, doLabel);

    // code generation.
    clearRegisters();

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

  // forStatement ::= "for" "(" forInit? ";" expression? ";" forUpdate? ")"
  // statementExceptIf.
  //
  // forInit ::= localVariableDeclaration | statementExpressionList.
  // forUpdate ::= statementExpressionList.
  // statementExpressionList ::= statementExpression {"," statementExpression}.
  //
  // TODO refactor forStatement
  // forStatement = "for" "(" initialization ";" comparison ";" update ")"
  // block.
  private void forStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nforStatement: start with stopSet = " + stopSet);

    // semantic analysis: start a new declaration scope for the for
    // statement.
    identifiers.newScope();

    // lexical analysis: "for" "(" initialization ";".
    lexeme = lexemeReader.getLexeme(sourceCode);
    EnumSet<LexemeType> stopForSet = stopSet.clone();
    stopForSet.add(LexemeType.RPAREN);
    if (checkOrSkip(EnumSet.of(LexemeType.LPAREN), stopForSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // In the initialization part a new variable must be declared.
    EnumSet<LexemeType> stopInitializationSet = stopForSet.clone();
    stopInitializationSet.add(LexemeType.semicolon);
    String variable = assignment(stopInitializationSet);
    if (variable == null) {
      error();
      System.out.println("Loop variable must be declared in for statement; for (word variable; .. ; ..) {..} expected.");
    }
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    // code generation.
    clearRegisters();

    // lexical analysis: comparison ";".
    stopInitializationSet.addAll(START_STATEMENT);
    stopInitializationSet.remove(LexemeType.identifier);
    int forLabel = saveLabel();
    int gotoEnd = comparison(stopInitializationSet);
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopInitializationSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    // order of steps in p-sourcecode: comparison - update - block.
    // order of steps during execution: comparison - block - update.

    // code generation: skip update and jump forward to block.
    int gotoBlock = saveLabel();
    plant(new Instruction(FunctionType.br, new Operand(OperandType.LABEL, Datatype.word, 0)));
    int updateLabel = saveLabel();

    // code generation.
    clearRegisters();

    // lexical analysis: update.
    stopForSet.add(LexemeType.beginLexeme);
    if (lexeme.type != LexemeType.RPAREN) {
      update(stopForSet);
    }

    // code generation: jump back to comparison.
    plant(new Instruction(FunctionType.br, new Operand(OperandType.LABEL, Datatype.word, forLabel)));

    // code generation.
    clearRegisters();

    // lexical analysis: ")".
    stopForSet = stopSet.clone();
    stopForSet.addAll(START_STATEMENT);
    if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), stopForSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // code generation: start of block.
    plantForwardLabel(gotoBlock, saveLabel());

    // lexical analysis: block.
    // block(stopSet);
    statementExceptIf(stopSet);

    // code generation; jump back to update.
    plantThenSource(new Instruction(FunctionType.br, new Operand(OperandType.LABEL, Datatype.word, updateLabel)));
    plantForwardLabel(gotoEnd, saveLabel());

    // todo: getLexeme na bovenstaande code generatie.

    // semantic analysis: close the declaration scope of the for
    // statement.
    identifiers.closeScope();
    debug("\nforStatement: end");
  } // forStatement()

  // returnStatement ::= "return" expression? ";".
  private void returnStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nreturnStatement: start with stopSet = " + stopSet);

    // TODO implement returnStatement.
    while (lexeme.type != LexemeType.semicolon) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    lexeme = lexemeReader.getLexeme(sourceCode);

    debug("\nreturnStatement: end");
  }

  // printlnStatement = "println" "(" expression ")" ";".
  //
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

    // lexical analysis.
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
        // lexical analysis.
        if ((lexeme.type == LexemeType.addop) && (lexeme.operator == OperatorType.add)) {
          debug("\nprintlnStatement: " + operand + ", lexeme=" + lexeme.makeString(null));
          // code generation.
          plantPrintln(operand, false);

          // lexical analysis.
          // skip addop symbol.
          lexeme = lexemeReader.getLexeme(sourceCode);

          // read next factor.
          operand = factor(startExpressionSet);
        } else if (lexeme.type != LexemeType.RPAREN) {
          // lexical analysis.
          // only + symbol allowed between terms in string expression.
          error(3, " " + lexeme.makeString(null));
          // skip unexpected symbol.
          if (checkOrSkip(EnumSet.of(lexeme.type), stopWriteSet)) {
            lexeme = lexemeReader.getLexeme(sourceCode);
          }
        }
      } while (lexeme.type != LexemeType.RPAREN);

      debug("\nprintlnStatement: " + operand + ", lexeme=" + lexeme.makeString(null));
      // code generation.
      plantPrintln(operand, true);
    } else {
      // algorithmic expression.
      operand = termWithOperand(0, operand, startExpressionSet);
      debug("\nprintlnStatement: " + operand);

      // code generation.
      plantPrintln(operand, true);
    }

    // lexical analysis.
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

  // outputStatement = "output" "(" constantExpression "," expression ")".
  // TODO Add non-constant port value to output/input (IN0 A,(C); OUT0 (C),A).
  // TODO Test various expressions for output(byte port, byte value). See
  // ledtest.j.
  private void outputStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\noutputStatement: start with stopSet = " + stopSet);

    // lexical analysis.
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

    // lexical analysis.
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

    // semantic analysis.
    debug("\noutputStatement: value = " + value + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    // TODO check value is a byte expression.

    // code generation.
    plant(new Instruction(FunctionType.output, port, value));

    // lexical analysis.
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

    // lexical analysis.
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

    // semantic analysis.
    debug("\nsleep: value = " + value + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    // check value has type byte or word.
    if (value.datatype != Datatype.byt && value.datatype != Datatype.word) {
      error(18);
    }

    // code generation.
    plant(new Instruction(FunctionType.sleep, value));

    // lexical analysis.
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

  // expressionStatement ::= statementExpression ";".
  private void expressionStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nexpressionStatement: start with stopSet = " + stopSet + "; lexeme.type=" + lexeme.type);
    statementExpression(stopSet);
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    debug("\nexpressionStatement: end");
  }

  /*************************
   * 
   * ### Expressions
   * 
   *************************/

  // statementExpression ::= preincrementExpression | predecrementExpression |
  // postincrementExpression | postdecrementExpression | methodInvocation |
  // arraySelector | assignment.
  //
  // TODO implement methodInvocation.
  // TODO implement arraySelector.
  private void statementExpression(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nstatementExpression: start with stopSet = " + stopSet + "; lexeme.type=" + lexeme.type);
    if (lexeme.type == LexemeType.increment) {
      preincrementExpression(stopSet);
    } else if (lexeme.type == LexemeType.decrement) {
      predecrementExpression(stopSet);
    } else if (lexeme.type == LexemeType.identifier) {
      // Semantic analysis.
      // TODO support fully qualified name instead of just an identifier.
      String name = lexeme.idVal;

      // lexical analysis.
      lexeme = lexemeReader.getLexeme(sourceCode);
      if (lexeme.type == LexemeType.increment) {
        postincrementExpression(name, stopSet);
      } else if (lexeme.type == LexemeType.decrement) {
        postdecrementExpression(name, stopSet);
      } else if (lexeme.type == LexemeType.LPAREN) {
        methodInvocation(name, stopSet);
      } else {
        assignment(name, stopSet);
      }
    } else {
      error(3, " " + lexeme.makeString(null));
      // skip unexpected symbol.
      if (checkOrSkip(EnumSet.of(lexeme.type), stopSet)) {
        lexeme = lexemeReader.getLexeme(sourceCode);
      }
    }

    debug("\nstatementExpression: end");
  } // statementExpression

  // preincrementExpression ::= "++" name.
  private void preincrementExpression(EnumSet<LexemeType> stopSet) throws FatalError {
    if (checkOrSkip(EnumSet.of(LexemeType.increment), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);

      // TODO support fully qualified name instead of just an identifier.
      if (checkOrSkip(EnumSet.of(LexemeType.identifier), stopSet)) {
        // semantic analysis.
        Variable var = identifiers.getId(lexeme.idVal);
        Operand leftOperand = new Operand(var.getIdentifierType(), var.getDatatype(), var.getAddress());
        leftOperand.isFinal = var.isFinal();
        debug("\nupdate: leftOperand = " + leftOperand);

        // code generation.
        if (var.getDatatype() == Datatype.word) {
          plant(new Instruction(FunctionType.increment16, leftOperand));
        } else if (var.getDatatype() == Datatype.byt) {
          plant(new Instruction(FunctionType.increment8, leftOperand));
        } else {
          error(12);
        }

        // lexical analysis.
        lexeme = lexemeReader.getLexeme(sourceCode);
      }
    }
  } // preincrementExpression

  // predecrementExpression ::= "--" name.
  private void predecrementExpression(EnumSet<LexemeType> stopSet) throws FatalError {
    if (checkOrSkip(EnumSet.of(LexemeType.decrement), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);

      // TODO support fully qualified name instead of just an identifier.
      if (checkOrSkip(EnumSet.of(LexemeType.identifier), stopSet)) {
        // semantic analysis.
        Variable var = identifiers.getId(lexeme.idVal);
        Operand leftOperand = new Operand(var.getIdentifierType(), var.getDatatype(), var.getAddress());
        leftOperand.isFinal = var.isFinal();
        debug("\nupdate: leftOperand = " + leftOperand);

        // code generation.
        if (var.getDatatype() == Datatype.word) {
          plant(new Instruction(FunctionType.decrement16, leftOperand));
        } else if (var.getDatatype() == Datatype.byt) {
          plant(new Instruction(FunctionType.decrement8, leftOperand));
        } else {
          error(12);
        }

        // lexical analysis.
        lexeme = lexemeReader.getLexeme(sourceCode);
      }
    }
  } // predecrementExpression

  // postincrementExpression ::= name "++".
  private void postincrementExpression(String name, EnumSet<LexemeType> stopSet) throws FatalError {
    // semantic analysis.
    Variable var = identifiers.getId(name);
    if (var == null) {
      error(9); // variable not declared.
    } else {
      debug("\nassignment: variable = " + var);

      // lexical analysis.
      if (checkOrSkip(EnumSet.of(LexemeType.increment), stopSet)) {
        lexeme = lexemeReader.getLexeme(sourceCode);

        // semantic analysis.
        Operand leftOperand = new Operand(var.getIdentifierType(), var.getDatatype(), var.getAddress());
        leftOperand.isFinal = var.isFinal();
        debug("\npostincrementExpression: leftOperand = " + leftOperand);

        // code generation.
        if (var.getDatatype() == Datatype.word) {
          plant(new Instruction(FunctionType.increment16, leftOperand));
        } else if (var.getDatatype() == Datatype.byt) {
          plant(new Instruction(FunctionType.increment8, leftOperand));
        } else {
          error(12);
        }
      }
    }
  } // postincrementExpression

  // postdecrementExpression ::= name "--".
  private void postdecrementExpression(String name, EnumSet<LexemeType> stopSet) throws FatalError {
    // semantic analysis.
    Variable var = identifiers.getId(name);
    if (var == null) {
      error(9); // variable not declared.
    } else {
      debug("\nassignment: variable = " + var);

      // lexical analysis.
      if (checkOrSkip(EnumSet.of(LexemeType.decrement), stopSet)) {
        lexeme = lexemeReader.getLexeme(sourceCode);

        // semantic analysis.
        Operand leftOperand = new Operand(var.getIdentifierType(), var.getDatatype(), var.getAddress());
        leftOperand.isFinal = var.isFinal();
        debug("\npostdecrementExpression: leftOperand = " + leftOperand);

        // code generation.
        if (var.getDatatype() == Datatype.word) {
          plant(new Instruction(FunctionType.decrement16, leftOperand));
        } else if (var.getDatatype() == Datatype.byt) {
          plant(new Instruction(FunctionType.decrement8, leftOperand));
        } else {
          error(12);
        }
      }
    }
  } // postdecrementExpression

  // methodInvocation ::= name arguments.
  private void methodInvocation(String name, EnumSet<LexemeType> stopSet) throws FatalError {
    // semantic analysis.
    Variable method = identifiers.getId(name);
    if (method == null) {
      error(36); // method not declared.
    } else {
      // TODO support method call before method declaration.
      // get the method signature from the list of identifiers.
      debug("\nmethod invocation: " + method);

      // lexical analysis.
      // get the optional list of actual parameters.
      ArrayList<Datatype> arguments = arguments(stopSet);

      // semantic analysis: check actual parameters against formal parameters.
      // TODO add check of actual parameters against formal parameters.
      if (arguments.size() != 0) {
        error(39);
      }

      // semantic analysis: check return type.
      // TODO add check of return type.
      if (method.getDatatype() != Datatype.voidd) {
        error(37); // incompatible return type.
      }

      // code generation.
      // TODO support method arguments (actual parameters).
      plant(new Instruction(FunctionType.call, new Operand(name, method.getIntValue())));
    }
  } // methodInvocation

  // TODO refactor assignment.
  private void assignment(String name, EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nassignment: start with stopSet = " + stopSet + "; variable e=" + name);

    // semantic analysis.
    Variable var = identifiers.getId(name);
    if (var == null) {
      error(9); // variable not declared.
    } else {
      debug("\nassignment: variable = " + var);
      Operand leftOperand = new Operand(var.getIdentifierType(), var.getDatatype(), var.getAddress());
      leftOperand.isFinal = var.isFinal();
      debug("\nassignment: leftOperand = " + leftOperand);

      // lexical analysis.
      EnumSet<LexemeType> stopAssignmentSet = stopSet.clone();
      stopAssignmentSet.addAll(START_EXPRESSION);
      stopAssignmentSet.add(LexemeType.semicolon);
      if (checkOrSkip(EnumSet.of(LexemeType.assign), stopAssignmentSet)) {
        // identifier "=" expression
        lexeme = lexemeReader.getLexeme(sourceCode);
        Operand rightOperand = expression(stopSet);

        // lexical analysis.
        if (var.isFinal()) {
          // assignment to a final variable.
          error(34);
        } else {
          // code generation.
          generateAssignment(leftOperand, rightOperand);
        }
      }
    }

    debug("\nassignment: end");
  } // assignment()

  // arguments ::= "(" argumentList? ")".
  private ArrayList<Datatype> arguments(EnumSet<LexemeType> stopSet) throws FatalError {
    ArrayList<Datatype> result = new ArrayList<Datatype>();
    if (checkOrSkip(EnumSet.of(LexemeType.LPAREN), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);

      // TODO implement argumentList.

      // skip closing right parenthesis.
      if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), stopSet)) {
        lexeme = lexemeReader.getLexeme(sourceCode);
      }
    }
    return result;
  } // arguments

  /*********************************************
   * 
   * Old lexical parsing methods to be refactored.
   * 
   *********************************************/

  // TODO refactor lexical parsing methods below.

  // constantExpression = constant | {addop constant}.
  // TODO Implement constantExpression.
  // TODO Allow algorithmic expression as value for 'final' qualifier. See
  // test13.j.
  // TODO Generate constant in Z80 code in hex notation if the constant was
  // written in hex notation in J-code. See ledtest.j.
  private Operand constantExpression(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nconstantExpression: start with stopSet = " + stopSet);

    // lexical analysis.
    Operand port = factor(stopSet);

    // semantic analysis.
    debug("\nconstantExpression: port = " + port + ", final = " + port.isFinal + ", acc16InUse = " + acc16.inUse()
        + ", acc8InUse = " + acc8.inUse());
    // port must be a constant or a final variable
    // convert port operand from final var to constant.
    if ((port.opType == OperandType.GLOBAL_VAR || port.opType == OperandType.LOCAL_VAR) && port.isFinal) {
      port = new Operand(OperandType.CONSTANT, port.datatype, identifiers.getId(port.strValue).getIntValue());
    }
    if (port.opType != OperandType.CONSTANT) {
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

    // lexical analysis.
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

    // code generation.
    if (acc8.inUse()) {
      plant(new Instruction(FunctionType.stackAcc8));
    }

    // read constant expression.
    Operand port = constantExpression(stopInputSet);

    // skip right bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.RPAREN), stopInputSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // semantic analysis.
    debug("\ninputFactor: port = " + port + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());

    // code generation.
    plant(new Instruction(FunctionType.input, port));
    // The input() function always returns a byte value.
    Operand operand = new Operand(OperandType.ACC);
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
    Operand operand = new Operand(OperandType.UNKNOWN);
    debug("\nfactor 1: acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    if (checkOrSkip(START_EXPRESSION, stopSet)) {
      if (lexeme.type == LexemeType.identifier) {
        // semantic analysis.
        Variable var = identifiers.getId(lexeme.idVal);
        if (var == null) {
          throw new FatalError(9); // variable not declared.
        } else {
          operand = new Operand(var.getIdentifierType(), var.getDatatype(), var.getAddress());
          // treat final var as a constant
          if (var.isFinal()) {
            operand.opType = OperandType.CONSTANT;
            operand.intValue = var.getIntValue();
          }
          operand.isFinal = var.isFinal();
          operand.strValue = lexeme.idVal;
        }
        // lexical analysis.
        lexeme = lexemeReader.getLexeme(sourceCode);
      } else if (lexeme.type == LexemeType.constant) {
        // code generation.
        operand.opType = OperandType.CONSTANT;
        operand.datatype = lexeme.datatype;
        operand.intValue = lexeme.constVal;
        // lexical analysis.
        lexeme = lexemeReader.getLexeme(sourceCode);
      } else if (lexeme.type == LexemeType.stringConstant) {
        debug("\nlexeme = " + lexeme.makeString(null));
        // semantic analysis.
        int constantId = stringConstants.add(lexeme.stringVal, instructions.size() + 1);
        debug("\nfactor: string constant " + constantId + " = \"" + lexeme.stringVal + "\"");
        // code generation.
        operand.opType = OperandType.CONSTANT;
        operand.datatype = Datatype.string;
        operand.strValue = lexeme.stringVal;
        operand.intValue = constantId;
        // lexical analysis.
        lexeme = lexemeReader.getLexeme(sourceCode);
        debug("\nlexeme = " + lexeme.makeString(null));
      } else if (lexeme.type == LexemeType.readLexeme) {
        lexeme = lexemeReader.getLexeme(sourceCode);
        // code generation.
        // The read() function always returns a word value.
        if (acc16.inUse()) {
          plant(new Instruction(FunctionType.stackAcc16));
        }
        plant(new Instruction(FunctionType.read));
        operand.opType = OperandType.ACC;
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
    if (operand.opType == OperandType.UNKNOWN) {
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

    // lexical analysis.
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

    // lexical analysis.
    // process the first operand at the next level if it is followed by an
    // operator with higher precedence.
    if (level < LEXEME_TYPE_AT_LEVEL.length - 1 && lexeme.type.ordinal() > LEXEME_TYPE_AT_LEVEL[level].ordinal()) {
      leftOperand = termWithOperand(level + 1, leftOperand, followSet);
    }

    // code generation.
    OperatorType operator;
    boolean leftOperandNotLoaded = true;
    while (lexeme.type == LEXEME_TYPE_AT_LEVEL[level]) {
      // lexical analysis.
      operator = lexeme.operator;

      // code generation.
      if (leftOperandNotLoaded) {
        if (leftOperand.opType != OperandType.ACC) {
          plantAccLoad(leftOperand);
        }
        leftOperandNotLoaded = false;
      }

      // lexical analysis.
      lexeme = lexemeReader.getLexeme(sourceCode);
      // process the right hand operand and subsequent operators/operands at the
      // next level, ultimately parsing a factor.
      Operand rOperand = (level == LEXEME_TYPE_AT_LEVEL.length - 1) ? factor(followSet) : term(level + 1, followSet);

      // code generation.
      debug("\ntermWithOperand loop: level = " + level + ", leftOperand=" + leftOperand + ", rightOperand=" + rOperand
          + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
      /*
       * leftOperand: constant, acc, var, stack16, stack8 rOperand: constant,
       * acc, var, stack16, stack8
       */
      if ((leftOperand.opType == OperandType.ACC) && (rOperand.opType == OperandType.CONSTANT)) {
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
      } else if ((leftOperand.opType == OperandType.ACC) && (rOperand.opType == OperandType.ACC)) {
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
      } else if ((leftOperand.opType == OperandType.ACC)
          && (rOperand.opType == OperandType.GLOBAL_VAR || rOperand.opType == OperandType.LOCAL_VAR)) {
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
      } else if ((leftOperand.opType == OperandType.STACK16) && (rOperand.opType == OperandType.ACC)) {
        if (rOperand.datatype == Datatype.word) {
          plant(new Instruction(reverseOperation16.get(operator), leftOperand));
          leftOperand.opType = OperandType.ACC;
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.STACK8) && (rOperand.opType == OperandType.ACC)) {
        if (rOperand.datatype == Datatype.byt) {
          plant(new Instruction(reverseOperation8.get(operator), leftOperand));
          leftOperand.opType = OperandType.ACC;
          acc8.setOperand(leftOperand);
        } else if (rOperand.datatype == Datatype.word) {
          plant(new Instruction(reverseOperation16.get(operator), leftOperand));
          leftOperand.opType = OperandType.ACC;
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

    // lexical analysis.
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.relop);
    Operand leftOperand = expression(localSet);
    debug("\ncomparison: leftOperand=" + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());

    // code generation.
    if (leftOperand.opType == OperandType.ACC) {
      debug("\ncomparison: push leftOperand to the stack; " + leftOperand);
      if (leftOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.stackAcc16));
      } else if (leftOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.stackAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    }

    // lexical analysis.
    localSet = stopSet.clone();
    localSet.addAll(START_EXPRESSION);
    OperatorType compareOp;
    if (checkOrSkip(EnumSet.of(LexemeType.relop), localSet)) {
      // code generation.
      compareOp = lexeme.operator;
      // lexical analysis.
      lexeme = lexemeReader.getLexeme(sourceCode);
    } else {
      // code generation.
      compareOp = OperatorType.eq;
    }

    // lexical analysis.
    localSet = stopSet.clone();
    localSet.addAll(START_STATEMENT);
    localSet.remove(LexemeType.identifier);
    Operand rightOperand = expression(localSet);

    // code generation.
    boolean reverseCompare = plantComparisonCode(leftOperand, rightOperand);
    int ifLabel = saveLabel();
    Operand labelOperand = new Operand(OperandType.LABEL, Datatype.word, 0);
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

    // lexical analysis.
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.relop);
    Operand leftOperand = expression(localSet);

    // code generation.
    if (leftOperand.opType == OperandType.ACC) {
      debug("\ncomparisonInDoStatement: push leftOperand to the stack; " + leftOperand);
      if (leftOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.stackAcc16));
      } else if (leftOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.stackAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    }

    // lexical analysis.
    localSet = stopSet.clone();
    localSet.addAll(START_EXPRESSION);
    OperatorType compareOp;
    if (checkOrSkip(EnumSet.of(LexemeType.relop), localSet)) {
      // code generation.
      compareOp = lexeme.operator;
      // lexical analysis.
      lexeme = lexemeReader.getLexeme(sourceCode);
    } else {
      // code generation.
      compareOp = OperatorType.eq;
    }

    // lexical analysis.
    localSet = stopSet.clone();
    localSet.addAll(START_STATEMENT);
    localSet.remove(LexemeType.identifier);
    Operand rightOperand = expression(localSet);

    // code generation.
    boolean reverseCompare = plantComparisonCode(leftOperand, rightOperand);
    Operand labelOperand = new Operand(OperandType.LABEL, Datatype.word, doLabel);
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

  // assigment = [declaration] update ";".
  // declaration = [qualifier] datatype.
  // qualifier = "final".
  // datatype = "byte" | "word" | "String".
  //
  // TODO implement isPublic
  private String assignment(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nstatementExpression: start with stopSet = " + stopSet + "; lexeme.type=" + lexeme.type);

    EnumSet<LexemeType> stopAssignmentSet = stopSet.clone();
    stopAssignmentSet.addAll(START_EXPRESSION);
    stopAssignmentSet.add(LexemeType.semicolon);

    // lexical analysis.
    EnumSet<LexemeType> modifiers = EnumSet.noneOf(LexemeType.class);
    if (lexeme.type == LexemeType.finalLexeme) {
      modifiers.add(lexeme.type);
      // skip final lexeme.
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    // lexical analysis.
    String variable = null;
    if (lexeme.type == LexemeType.byteLexeme || lexeme.type == LexemeType.wordLexeme || lexeme.type == LexemeType.stringLexeme) {
      LexemeType datatype = lexeme.type;
      lexeme = lexemeReader.getLexeme(sourceCode);
      if (checkOrSkip(EnumSet.of(LexemeType.identifier), stopAssignmentSet)) {

        // semantic analysis.
        if (identifiers.declareId(lexeme.idVal, IdentifierType.LOCAL_VARIABLE, datatype, modifiers)) {
          debug("\nstatementExpression: " + modifiers + lexeme.makeString(identifiers.getId(lexeme.idVal)));
          variable = lexeme.idVal;
        } else {
          error();
          System.out.println("variable " + lexeme.idVal + " already declared.");
        }
      }
    } else {
      checkOrSkip(EnumSet.of(LexemeType.identifier), stopAssignmentSet);

      // semantic analysis.
      if (identifiers.getId(lexeme.idVal) == null)
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

    // semantic analysis.
    Variable var = identifiers.getId(lexeme.idVal);
    Operand leftOperand = new Operand(var.getIdentifierType(), var.getDatatype(), var.getAddress());
    leftOperand.isFinal = var.isFinal();
    debug("\nupdate: leftOperand = " + leftOperand);

    // lexical analysis.
    lexeme = lexemeReader.getLexeme(sourceCode);
    if (lexeme.type == LexemeType.increment) {
      // identifier++
      lexeme = lexemeReader.getLexeme(sourceCode);

      // code generation.
      if (var.getDatatype() == Datatype.word) {
        plant(new Instruction(FunctionType.increment16, leftOperand));
      } else if (var.getDatatype() == Datatype.byt) {
        plant(new Instruction(FunctionType.increment8, leftOperand));
      } else {
        error(12);
      }
    } else if (lexeme.type == LexemeType.decrement) {
      // identifier--
      lexeme = lexemeReader.getLexeme(sourceCode);

      // code generation.
      if (var.getDatatype() == Datatype.word) {
        plant(new Instruction(FunctionType.decrement16, leftOperand));
      } else if (var.getDatatype() == Datatype.byt) {
        plant(new Instruction(FunctionType.decrement8, leftOperand));
      } else {
        error(12);
      }
    } else if (checkOrSkip(EnumSet.of(LexemeType.assign), stopAssignmentSet)) {
      // identifier "=" expression
      lexeme = lexemeReader.getLexeme(sourceCode);
      Operand rightOperand = expression(stopSet);

      // code generation.
      if (var.isFinal()) {
        // no assignment but constant definition.
        if (var.getDatatype() != rightOperand.datatype) {
          error(14);
        } else if (rightOperand.opType == OperandType.CONSTANT) {
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
    // code generation.
    debug("\ngenerateAssignment: leftOperand = " + leftOperand + ", operand = " + rightOperand);
    // operand to accu.
    if (rightOperand.opType != OperandType.ACC) {
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
  }

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
      instructions.add(new Instruction(FunctionType.comment, new Operand(OperandType.CONSTANT, Datatype.string, line)));
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

    // update references to method symbols.
    if (instruction.function == FunctionType.call) {
      String name = instruction.operand.strValue;
      if (methodReferences.get(name) == null) {
        methodReferences.put(name, new ArrayList<Integer>());
      }
      methodReferences.get(name).add(instructions.size());
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
      acc16.operand().opType = OperandType.STACK16;
    } else if (instruction.function == FunctionType.stackAcc8Load) {
      stackedDatatypes.push(Datatype.byt);
      acc8.operand().opType = OperandType.STACK8;
    } else if (instruction.function == FunctionType.stackAcc16ToAcc8) {
      stackedDatatypes.push(Datatype.byt);
      acc8.operand().opType = OperandType.STACK8;
      acc16.clear();
    } else if (instruction.function == FunctionType.stackAcc8ToAcc16) {
      stackedDatatypes.push(Datatype.word);
      acc16.operand().opType = OperandType.STACK16;
      acc8.clear();
    } else if (instruction.function == FunctionType.stackAcc16) {
      stackedDatatypes.push(Datatype.word);
      acc16.operand().opType = OperandType.STACK16;
      acc16.clear();
    } else if (instruction.function == FunctionType.stackAcc8) {
      stackedDatatypes.push(Datatype.byt);
      acc8.operand().opType = OperandType.STACK8;
      acc8.clear();
    }

    // update stack metadata.
    if (instruction.function == FunctionType.unstackAcc8) {
      popStackedDatatype(Datatype.byt);
    } else if (instruction.function == FunctionType.unstackAcc16) {
      popStackedDatatype(Datatype.word);
    } else if (instruction.operand != null && instruction.operand.opType == OperandType.STACK8) {
      popStackedDatatype(Datatype.byt);
    } else if (instruction.operand != null && instruction.operand.opType == OperandType.STACK16) {
      popStackedDatatype(Datatype.word);
    }

    // for debugging purposes.
    debug(" ;" + " stackedDatatypes=" + stackedDatatypes);
  } // plantCode

  private void setScopeSize(int methodAddress, int scopeSize) {
    Instruction instruction = instructions.get(methodAddress);
    instruction.operand.intValue = scopeSize;
  }

  private int findSymbol(String name) {
    int address = 0;
    for (Symbol symbol : methodSymbolTable) {
      // TODO add package name, return type and modifiers to the search
      // condition.
      if (name.equals(symbol.name)) {
        address = symbol.address;
        break;
      }
    }
    return address;
  }

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
    if ((leftOperand.opType == OperandType.CONSTANT) && (rightOperand.opType == OperandType.CONSTANT)) {
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
    } else if ((leftOperand.opType == OperandType.CONSTANT) && (rightOperand.opType == OperandType.ACC)) {
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
    } else if ((leftOperand.opType == OperandType.CONSTANT)
        && (rightOperand.opType == OperandType.GLOBAL_VAR || rightOperand.opType == OperandType.LOCAL_VAR)) {
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
    } else if ((leftOperand.opType == OperandType.GLOBAL_VAR || leftOperand.opType == OperandType.LOCAL_VAR)
        && (rightOperand.opType == OperandType.CONSTANT)) {
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
    } else if ((leftOperand.opType == OperandType.GLOBAL_VAR || leftOperand.opType == OperandType.LOCAL_VAR)
        && (rightOperand.opType == OperandType.ACC)) {
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
    } else if ((leftOperand.opType == OperandType.GLOBAL_VAR || leftOperand.opType == OperandType.LOCAL_VAR)
        && (rightOperand.opType == OperandType.GLOBAL_VAR || rightOperand.opType == OperandType.LOCAL_VAR)) {
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
    } else if ((leftOperand.opType == OperandType.STACK16) && (rightOperand.opType == OperandType.CONSTANT)) {
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
    } else if ((leftOperand.opType == OperandType.STACK16) && (rightOperand.opType == OperandType.ACC)) {
      if (rightOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.revAcc16Compare, leftOperand));
        reverseCompare = true;
      } else if (rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.unstackAcc16));
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.STACK16)
        && (rightOperand.opType == OperandType.GLOBAL_VAR || rightOperand.opType == OperandType.LOCAL_VAR)) {
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
    } else if ((leftOperand.opType == OperandType.STACK8) && (rightOperand.opType == OperandType.CONSTANT)) {
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
    } else if ((leftOperand.opType == OperandType.STACK8) && (rightOperand.opType == OperandType.ACC)) {
      if (rightOperand.datatype == Datatype.word) {
        plant(new Instruction(FunctionType.unstackAcc8));
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else if (rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.revAcc8Compare, leftOperand));
        reverseCompare = true;
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.STACK8)
        && (rightOperand.opType == OperandType.GLOBAL_VAR || rightOperand.opType == OperandType.LOCAL_VAR)) {
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
      if (operand.opType != OperandType.STACK16) {
        if (acc16.inUse()) {
          plant(new Instruction(FunctionType.stackAcc16Load, operand));
        } else {
          plant(new Instruction(FunctionType.acc16Load, operand));
        }
        operand.opType = OperandType.ACC;
        acc16.setOperand(operand);
      }
    } else if (operand.datatype == Datatype.byt) {
      if (operand.opType != OperandType.STACK8) {
        if (acc8.inUse()) {
          plant(new Instruction(FunctionType.stackAcc8Load, operand));
        } else {
          plant(new Instruction(FunctionType.acc8Load, operand));
        }
        operand.opType = OperandType.ACC;
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
    // code generation.
    if (operand.opType != OperandType.ACC) {
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
      Operand operand = new Operand(OperandType.CONSTANT, Datatype.string, stringConstants.get(id));
      operand.intValue = id;
      instructions.add(new Instruction(FunctionType.stringConstant, operand));
    }
  } // plantStringConstants

  private void updateReferencesToMethods() {
    methodReferences.forEach((name, references) -> {
      int address = findSymbol(name);
      if (address == 0) {
        error(38, name);
      }
      // update references to label <name>.
      for (Integer reference : references) {
        Instruction instruction = instructions.get(reference);
        if (instruction.function != FunctionType.call) {
          throw new RuntimeException(String.format("One of the instructions to symbol %s is not a call function", name));
        } else if (instruction.operand == null) {
          throw new RuntimeException(String.format("One of the instructions to symbol %s does not have an operand", name));
        } else if (instruction.operand.opType != OperandType.LABEL) {
          throw new RuntimeException(String.format("One of the instructions to symbol %s does not have a label operand", name));
        } else if (instruction.operand.intValue == 0) {
          instruction.operand.intValue = address;
        } else if (instruction.operand.intValue != address) {
          throw new RuntimeException(String.format(
              "One of the instructions to symbol %s already has %d as address which is different from expected value %d", name,
              instruction.operand.intValue, address));
        }
      }
    });
  }

  private void updateReferencesToStringConstants(int offset) {
    Map<Integer, ArrayList<Integer>> stringReferences = new HashMap<Integer, ArrayList<Integer>>();
    int lineNumber = 0;
    for (Instruction instruction : instructions) {
      lineNumber++;
      if (STRING_CONSTANT_FUNCTIONS.contains(instruction.function) && instruction.operand != null
          && instruction.operand.opType == OperandType.CONSTANT && instruction.operand.datatype == Datatype.string) {

        // error detection
        if (instruction.operand.intValue == null) {
          throw new RuntimeException(String.format("operand.intValue is null at instruction %d: instruction: %s operand: %s",
              +lineNumber, instruction, instruction.operand));
        }

        // update reference to string constant.
        int oldAddress = instruction.operand.intValue;
        int newAddress = instruction.operand.intValue + offset;
        debug("\nUpdating reference to string constant at " + lineNumber + " from " + oldAddress + " to " + newAddress);
        instruction.operand.intValue = newAddress;

        // add reference to the list of references to the string constant.
        if (debugMode) {
          // add index of string constant to the cross references list.
          if (stringReferences.get(newAddress) == null) {
            stringReferences.put(newAddress, new ArrayList<Integer>());
          }
          stringReferences.get(newAddress).add(lineNumber);
        }
      }
    }

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
