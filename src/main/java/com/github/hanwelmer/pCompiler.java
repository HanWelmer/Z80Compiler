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
import java.io.IOException;
import java.nio.file.DirectoryIteratorException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
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
  private ArrayList<Instruction> instructions = new ArrayList<Instruction>();

  // global variables used by the constructor or the interface functions.
  private class CompilationUnitContext {
    public LexemeReader lexemeReader;
    public String packageName = "";
    public String className = "";
    public int jumpFrom = 0;
    public boolean doingMemberInitializer = false;

    // constructor
    public CompilationUnitContext(LexemeReader lexemeReader) {
      this.lexemeReader = lexemeReader;
    }
  }

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
  // Possible lexeme types for formal parameter modifiers.
  private static final EnumSet<LexemeType> FORMAL_PARAMETER_MODIFIERS = EnumSet.of(LexemeType.finalLexeme);
  // Possible lexeme types as local variable modifiers.
  private static final EnumSet<LexemeType> LOCAL_VARIABLE_MODIFIERS = EnumSet.of(LexemeType.finalLexeme, LexemeType.volatileLexeme);
  // Lexeme types in an expression in increasing order of precedence.
  private static final LexemeType[] LEXEME_TYPE_AT_LEVEL = { LexemeType.bitwiseOrOp, LexemeType.bitwiseXorOp,
      LexemeType.bitwiseAndOp, LexemeType.addop, LexemeType.mulop };
  // Lexeme types that start a statement.
  private static final EnumSet<LexemeType> START_STATEMENT = EnumSet.of(LexemeType.beginLexeme, LexemeType.semicolon,
      LexemeType.finalLexeme, LexemeType.identifier, LexemeType.byteLexeme, LexemeType.wordLexeme, LexemeType.stringLexeme,
      LexemeType.ifLexeme, LexemeType.whileLexeme, LexemeType.doLexeme, LexemeType.forLexeme, LexemeType.returnLexeme,
      LexemeType.printlnLexeme, LexemeType.outputLexeme);
  // Lexeme types that start an expression.
  private static final EnumSet<LexemeType> START_EXPRESSION = EnumSet.of(LexemeType.LPAREN, LexemeType.identifier,
      LexemeType.constant, LexemeType.stringConstant, LexemeType.inputLexeme, LexemeType.readLexeme);

  // Class variables for lexical analysis phase.
  private ArrayList<String> sourceCode;
  private int lastSourceLineNr = 0;
  private Lexeme lexeme;
  private int errors;

  // Constants and class variables for semantic analysis phase.
  private ArrayList<Symbol> methodSymbolTable = new ArrayList<Symbol>();
  Map<String, ArrayList<Integer>> methodReferences = new HashMap<String, ArrayList<Integer>>();
  private Identifiers identifiers = new Identifiers();
  private StringConstants stringConstants = new StringConstants();

  // Constants and class variables for code generation phase.
  private static final String LINE_NR_FORMAT = "%4d ";
  private static final int MAX_M_CODE = 10000;
  private Accumulator acc16 = new Accumulator();
  private Accumulator acc8 = new Accumulator();
  private Stack<DataType> stackedDatatypes = new Stack<DataType>();

  @SuppressWarnings("serial")
  private static final Map<OperatorType, FunctionType> FORWARD_OPERATION_16 = new HashMap<OperatorType, FunctionType>() {
    {
      put(OperatorType.bitwiseOr, FunctionType.acc16Or);
      put(OperatorType.bitwiseXor, FunctionType.acc16Xor);
      put(OperatorType.bitwiseAnd, FunctionType.acc16And);
      put(OperatorType.add, FunctionType.acc16Plus);
      put(OperatorType.sub, FunctionType.acc16Minus);
      put(OperatorType.mul, FunctionType.acc16Times);
      put(OperatorType.div, FunctionType.acc16Div);
    }
  };
  @SuppressWarnings("serial")
  private static final Map<OperatorType, FunctionType> REVERSE_OPERATION_16 = new HashMap<OperatorType, FunctionType>() {
    {
      put(OperatorType.bitwiseOr, FunctionType.acc16Or);
      put(OperatorType.bitwiseXor, FunctionType.acc16Xor);
      put(OperatorType.bitwiseAnd, FunctionType.acc16And);
      put(OperatorType.add, FunctionType.acc16Plus);
      put(OperatorType.sub, FunctionType.minusAcc16);
      put(OperatorType.mul, FunctionType.acc16Times);
      put(OperatorType.div, FunctionType.divAcc16);
    }
  };
  @SuppressWarnings("serial")
  private static final Map<OperatorType, FunctionType> FORWARD_OPERATION_8 = new HashMap<OperatorType, FunctionType>() {
    {
      put(OperatorType.bitwiseOr, FunctionType.acc8Or);
      put(OperatorType.bitwiseXor, FunctionType.acc8Xor);
      put(OperatorType.bitwiseAnd, FunctionType.acc8And);
      put(OperatorType.add, FunctionType.acc8Plus);
      put(OperatorType.sub, FunctionType.acc8Minus);
      put(OperatorType.mul, FunctionType.acc8Times);
      put(OperatorType.div, FunctionType.acc8Div);
    }
  };
  @SuppressWarnings("serial")
  private static final Map<OperatorType, FunctionType> REVERSE_OPERATION_8 = new HashMap<OperatorType, FunctionType>() {
    {
      put(OperatorType.bitwiseOr, FunctionType.acc8Or);
      put(OperatorType.bitwiseXor, FunctionType.acc8Xor);
      put(OperatorType.bitwiseAnd, FunctionType.acc8And);
      put(OperatorType.add, FunctionType.acc8Plus);
      put(OperatorType.sub, FunctionType.minusAcc8);
      put(OperatorType.mul, FunctionType.acc8Times);
      put(OperatorType.div, FunctionType.divAcc8);
    }
  };

  @SuppressWarnings("serial")
  private static final Map<OperatorType, FunctionType> NORMAL_SKIP = new HashMap<OperatorType, FunctionType>() {
    {
      put(OperatorType.eq, FunctionType.brNe);
      put(OperatorType.ne, FunctionType.brEq);
      put(OperatorType.gt, FunctionType.brLe);
      put(OperatorType.lt, FunctionType.brGe);
      put(OperatorType.ge, FunctionType.brLt);
      put(OperatorType.le, FunctionType.brGt);
    }
  };
  @SuppressWarnings("serial")
  private static final Map<OperatorType, FunctionType> REVERSE_SKIP = new HashMap<OperatorType, FunctionType>() {
    {
      put(OperatorType.eq, FunctionType.brNe);
      put(OperatorType.ne, FunctionType.brEq);
      put(OperatorType.gt, FunctionType.brGe);
      put(OperatorType.lt, FunctionType.brLe);
      put(OperatorType.ge, FunctionType.brGt);
      put(OperatorType.le, FunctionType.brLt);
    }
  };

  // Class methods for all phases.
  private void init() {
    // initialisation of lexical analysis variables.
    sourceCode = new ArrayList<String>();
    lastSourceLineNr = 0;
    errors = 0;
    lexeme = new Lexeme(LexemeType.unknown);

    // initialisation of semantic analysis variables.
    identifiers.init();
    stringConstants.init();

    // initialisation of code generation variables.
    clearRegisters();
    stackedDatatypes.clear();
    instructions.clear();
  }

  /**
   * Clear runtime registers.
   */
  protected void clearRegisters() {
    acc16.clear();
    acc8.clear();
  }

  private void error(LexemeReader lexemeReader) {
    errors++;
    lexemeReader.error();
  }

  private void error(LexemeReader lexemeReader, String message) {
    error(lexemeReader);
    System.out.println(message);
  }

  private void error(LexemeReader lexemeReader, int n, String message) {
    error(lexemeReader, n);
    System.out.println(message);
  }

  // FIXME Fix runtime error: too many variables
  private void error(LexemeReader lexemeReader, int n) {
    error(lexemeReader);
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
        System.out.println("incompatible data type between assignment variable and expression.");
        break;
      case 15:
        System.out.println("incompatible data type in println statement.");
        break;
      case 16:
        System.out.println("port expression must be a constant or a static final variable.");
        break;
      case 17:
        System.out.println("static final variable must be a byte or a word.");
        break;
      case 18:
        System.out.println("data type must be byte or word.");
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
        System.out.println("unexpected type in field, formal parameter or local variable declaration.");
        break;
      case 33:
        System.out.println("superfluous text between end of type declaration and end of file.");
        break;
      case 34:
        System.out.println("assignment to a final variable.");
        break;
      case 35:
        System.out.println("unexpected modifier.");
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
        System.out.print("number of arguments does not match number of formal parameters.");
        break;
      case 40:
        System.out.println("combination of final and volatile modifiers not allowed");
        break;
      case 41:
        System.out.println("incompatible data type between argument and formal parameter.");
        break;
      case 42:
        System.out.print("could not find imported file ");
        break;
      case 43:
        System.out.print("no importable files found in package ");
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
  private boolean checkOrSkip(LexemeReader lexemeReader, EnumSet<LexemeType> okSet, EnumSet<LexemeType> stopSet) throws FatalError {
    boolean result = false;
    if (okSet.contains(lexeme.type)) {
      result = true;
    } else {
      error(lexemeReader, 3, "found " + lexeme.type + ", expected " + okSet);
      skipUntilStopSet(lexemeReader, stopSet);
    }
    return result;
  }

  /**
   * skip until current lexeme is in stopSet.
   */
  private void skipUntilStopSet(LexemeReader lexemeReader, EnumSet<LexemeType> stopSet) throws FatalError {
    EnumSet<LexemeType> localStopSet = stopSet.clone();
    localStopSet.add(LexemeType.eof);
    while (!localStopSet.contains(lexeme.type)) {
      lexeme = lexemeReader.skipAfterError(sourceCode);
    }
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

  public ArrayList<Instruction> compile(LexemeReader lexemeReader) {
    if (verboseMode)
      System.out.println("compiling in debugMode = " + debugMode);

    try {
      init();

      // code generation.
      plant(lexemeReader, new Instruction(FunctionType.call, new Operand("main", 0)));
      plant(lexemeReader, new Instruction(FunctionType.stop));

      // lexical analysis, semantic analysis and code generation.
      CompilationUnitContext cuc = new CompilationUnitContext(lexemeReader);
      compilationUnit(cuc);
      // last jump instruction in list of static member initializers jumps to
      // main function.
      String main = getFullyQualifiedName(cuc, "main");
      instructions.get(cuc.jumpFrom).operand.strValue = main;

      // replace "main" by fully qualified name for main.
      methodReferences.remove("main");
      methodReferences.put(main, new ArrayList<Integer>());
      methodReferences.get(main).add(new Integer(cuc.jumpFrom));
      debug("\n");

      // post processing.
      optimize();
      updateReferencesToMethods(lexemeReader);
      updateReferencesToStringConstants(instructions.size());
      plantStringConstants();
    } catch (FatalError e) {
      error(lexemeReader, e.getMessage());
      System.out.println("compilation aborted.");
      System.exit(1);
    } catch (SyntaxError e) {
      // FIXME replace syntax errors by exceptions and catch them as local as
      // possible
      error(lexemeReader, e.getMessage());
      // skip until stop set.
      // if (checkOrSkip(cuc.lexemeReader, EnumSet.of(lexeme.type), stopSet)) {
      // lexeme = cuc.lexemeReader.getLexeme(sourceCode);
      // }
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

  /*************************
   * 
   * ### CompilationUnit
   * 
   * @throws SyntaxError
   * 
   *************************/
  // compilationUnit ::= packageDeclaration? importDeclaration* typeDeclaration.
  private void compilationUnit(CompilationUnitContext cuc) throws FatalError, SyntaxError {
    debug("\ncompilationUnit: start");

    // recognize an optional package declaration.
    lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    EnumSet<LexemeType> stopSet = EnumSet.of(LexemeType.importLexeme, LexemeType.publicLexeme, LexemeType.classLexeme,
        LexemeType.enumLexeme);
    if (lexeme.type == LexemeType.packageLexeme) {
      packageDeclaration(cuc, stopSet);
    }

    // recognize an optional list of import declaration.
    while (lexeme.type == LexemeType.importLexeme) {
      importDeclaration(cuc, stopSet);
    }

    // recognize the mandatory single type declaration.
    stopSet.remove(LexemeType.importLexeme);
    typeDeclaration(cuc, stopSet);

    // check we are at the end of the file, barring comments and white space.
    if (lexeme.type != LexemeType.eof) {
      error(cuc.lexemeReader, 33);
    }

    debug("\ncompilationUnit: end");
  } // compilationUnit

  /*************************
   * 
   * ### Declarations
   * 
   *************************/

  // packageDeclaration ::= "package" name ";".
  private void packageDeclaration(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\npackageDeclaration: start");

    // skip "package".
    lexeme = cuc.lexemeReader.getLexeme(sourceCode);

    // recognize name.
    cuc.packageName = name(cuc.lexemeReader, stopSet);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.semicolon), stopSet)) {
      // semantic analysis: packageName identifiers are lowerCamelCase.
      if (!validPackageName(cuc.packageName)) {
        error(cuc.lexemeReader, 19);
      }

      // semantic analysis: source file path must equal packageName.
      if (!cuc.lexemeReader.getFileName().startsWith(cuc.packageName.replace(".", File.separator))) {
        error(cuc.lexemeReader, 20);
        debug("\npackage: " + cuc.packageName);
        debug("\nexpected: " + cuc.packageName.replace(".", File.separator));
        debug("\nfound: " + cuc.lexemeReader.getFileName());
      }

      // code generation
      plant(cuc.lexemeReader, new Instruction(FunctionType.packageFunction, cuc.packageName, null, null));

      // TODO implement semantics for package declaration.

      // skip ";"
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
      debug("\npackageDeclaration: packageName=" + cuc.packageName);
    }

    debug("\npackageDeclaration: end; package name=" + cuc.packageName);
  } // packageDeclaration

  // importDeclaration ::= "import" name [ "." "*" ] ";".
  // Note: identifiers in the package name are lowerCamelCase.
  // Note: identifier as import type (class name) is UpperCamelCase.
  private void importDeclaration(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nimportDeclaration: start");

    // skip "import"
    lexeme = cuc.lexemeReader.getLexeme(sourceCode);

    // recognize name.
    String importName = name(cuc.lexemeReader, stopSet);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.semicolon), stopSet)) {
      // package names are lowerCamelCase and importType is either * or
      // UpperCamelCase.
      if (!validImport(importName)) {
        error(cuc.lexemeReader, 21);
      }

      if (importName.endsWith(".*")) {
        // import all classes in a folder.
        importFolder(cuc, importName.substring(0, importName.length() - 2));
      } else {
        // import single class.
        String fileName = importName.replace(".", File.separator) + ".j";
        importFile(cuc, importName, fileName);
      }

      // skip ";"
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }
    debug("\nimportDeclaration: end; importPackageName=" + importName);
  } // importDeclaration

  private void importFile(CompilationUnitContext cuc, String importName, String fileName) throws FatalError, SyntaxError {
    LexemeReader localLexemeReader = new LexemeReader();
    if (localLexemeReader.init(debugMode, cuc.lexemeReader.getPath(), fileName)) {
      // code generation
      plant(cuc.lexemeReader, new Instruction(FunctionType.importFunction, importName, null, null));

      CompilationUnitContext localCuc = new CompilationUnitContext(localLexemeReader);
      localCuc.jumpFrom = cuc.jumpFrom;
      localCuc.doingMemberInitializer = cuc.doingMemberInitializer;
      compilationUnit(localCuc);
      cuc.jumpFrom = localCuc.jumpFrom;
      cuc.doingMemberInitializer = localCuc.doingMemberInitializer;
    } else {
      error(cuc.lexemeReader, 42, fileName);
    }
  } // importFile().

  // import all classes in the folder.
  private void importFolder(CompilationUnitContext cuc, String packageName) throws FatalError, SyntaxError {
    String folderName = cuc.lexemeReader.getPath() + packageName.replace(".", File.separator);
    Path dir = Paths.get(folderName);
    try (DirectoryStream<Path> stream = Files.newDirectoryStream(dir, "*.j")) {
      for (Path entry : stream) {
        String fileName = entry.getFileName().toString();
        String importName = packageName + "." + fileName.substring(0, fileName.length() - 2);
        String fullName = importName.replace(".", File.separator) + ".j";
        importFile(cuc, importName, fullName);
      }
    } catch (NoSuchFileException e) {
      error(cuc.lexemeReader, 42, e.getMessage());
    } catch (IOException | DirectoryIteratorException e) {
      error(cuc.lexemeReader, 43, folderName);
    }
  }// importFolder

  // typeDeclaration ::= ";" | ( modifiers ( classDecl | enumDecl ) ).
  //
  // TODO implement enumDecl in typeDeclaration.
  private void typeDeclaration(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\ntypeDeclaration: start");

    if (lexeme.type == LexemeType.semicolon) {
      // skip ";".
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    } else {
      EnumSet<LexemeType> modifiers = modifiers(cuc.lexemeReader);

      // Semantic analysis: modifiers in a class/enum declaration must be
      // none or "public". Default is none, i.e. the class is only
      // accessible by classes or enums in the same package.
      boolean isPublic = modifiers.contains(LexemeType.publicLexeme);
      // valid: modifiers.size() == 0 || (modifiers.size() == 1 && isPublic)
      if (!((modifiers.size() == 0) || ((modifiers.size() == 1) && isPublic))) {
        if (modifiers.size() > 1) {
          error(cuc.lexemeReader, 23);
        } else if (!isPublic) {
          error(cuc.lexemeReader, 24);
        }
      }

      if (lexeme.type == LexemeType.classLexeme) {
        classDecl(cuc, isPublic, stopSet);
      } else if (lexeme.type == LexemeType.enumLexeme) {
        enumDecl(cuc);
      } else {
        error(cuc.lexemeReader, 3, lexeme.makeString(null));
      }
    }

    debug("\ntypeDeclaration: end");
  } // typeDeclaration

  // classDecl ::= "class" javaIdentifier classBody.
  private void classDecl(CompilationUnitContext cuc, boolean isPublic, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nclassDecl: " + (isPublic ? "public" : ""));
    EnumSet<LexemeType> modifiers = EnumSet.noneOf(LexemeType.class);
    if (isPublic) {
      modifiers.add(LexemeType.publicLexeme);
    }

    // syntax analysis.
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.identifier);
    localSet.add(LexemeType.beginLexeme);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.classLexeme), localSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);

      localSet = stopSet.clone();
      localSet.add(LexemeType.beginLexeme);
      if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.identifier), localSet)) {
        // semantic analysis.
        cuc.className = lexeme.idVal;
        String fullyQualifiedClassName = getFullyQualifiedName(cuc, "");
        if (identifiers.declareId(fullyQualifiedClassName, IdentifierType.CLAZZ, LexemeType.classLexeme, modifiers)) {
          debug("\nclassDecl: " + (isPublic ? "public " : "") + "class declared: " + fullyQualifiedClassName);
        } else {
          error(cuc.lexemeReader, "Class identifier " + fullyQualifiedClassName + " already declared.");
        }

        // code generation
        plant(cuc.lexemeReader, new Instruction(FunctionType.classFunction, fullyQualifiedClassName, modifiers, null));

        // syntax analysis
        classBody(cuc, stopSet);
      }
    }
    debug("\nclassDecl: end");
  } // classDecl

  // enumDecl ::= "enum" javaIdentifier enumBody.
  //
  // TODO implement enumDecl.
  private void enumDecl(CompilationUnitContext cuc) throws FatalError {
    debug("\nenumDecl: start");
    debug("\nenumDecl: end");
  } // enumDecl

  /*************************
   * 
   * ### Modifiers
   * 
   *************************/

  // modifiers ::= "public"? "private"? "static"? "final"? "native"?
  // "transient"? "volatile"?.
  protected EnumSet<LexemeType> modifiers(LexemeReader lexemeReader) throws FatalError {
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
  } // modifiers

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
   * @throws SyntaxError
   * 
   *************************/

  // classBody ::= "{" classBodyDeclaration* "}".
  private void classBody(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nclassBody: start");

    lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    EnumSet<LexemeType> classBodyStopSet = stopSet.clone();
    classBodyStopSet.addAll(CLASS_BODY_START_SET);
    classBodyStopSet.add(LexemeType.endLexeme);
    EnumSet<LexemeType> classDeclStopSet = stopSet.clone();
    classDeclStopSet.add(LexemeType.endLexeme);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.beginLexeme), classBodyStopSet)) {
      // skip beginLexeme
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);

      while (CLASS_BODY_START_SET.contains(lexeme.type)) {
        classBodyDeclaration(cuc, classDeclStopSet);
      }

      // skip end lexeme
      if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.endLexeme), stopSet)) {
        // skip endLexeme
        lexeme = cuc.lexemeReader.getLexeme(sourceCode);
      }
    }

    debug("\nclassBody: end");
  } // classBody

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
  private void classBodyDeclaration(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nclassBodyDeclaration: start");

    // Semantic analysis
    EnumSet<LexemeType> modifiers = modifiers(cuc.lexemeReader);
    EnumSet<LexemeType> resultTypeStopSet = stopSet.clone();
    resultTypeStopSet.add(LexemeType.identifier);
    ResultType resultType = resultType(cuc.lexemeReader, resultTypeStopSet);

    EnumSet<LexemeType> localStopSet = stopSet.clone();
    localStopSet.add(LexemeType.LPAREN);
    localStopSet.add(LexemeType.beginLexeme);
    localStopSet.add(LexemeType.LBRACKET);
    localStopSet.add(LexemeType.assign);
    localStopSet.add(LexemeType.COMMA);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.identifier), localStopSet)) {
      String identifier = lexeme.idVal;
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
      if (lexeme.type == LexemeType.LPAREN) {
        // method declaration

        // Code generation
        if (cuc.doingMemberInitializer && instructions.get(cuc.jumpFrom).operand.intValue != 0) {
          cuc.jumpFrom = instructions.size();
          plantThenSource(cuc.lexemeReader, new Instruction(FunctionType.br, new Operand(OperandType.LABEL, DataType.word, 0)));
          cuc.doingMemberInitializer = false;
        }

        // Semantic analysis
        EnumSet<LexemeType> methodStopSet = stopSet.clone();
        methodStopSet.add(LexemeType.semicolon);
        methodStopSet.add(LexemeType.RPAREN);
        restOfMethodDeclaration(cuc, modifiers, resultType, identifier, methodStopSet);
      } else {
        // variable declaration

        // semantic analysis
        checkFieldModifiers(cuc.lexemeReader, modifiers);

        // semantic analysis
        if (resultType.getType() == LexemeType.unknown) {
          error(cuc.lexemeReader, 27);
        } else if (resultType.getType() == LexemeType.voidLexeme) {
          error(cuc.lexemeReader, 32);
        }

        // lexical analysis
        EnumSet<LexemeType> fieldStopSet = localStopSet.clone();
        fieldStopSet.add(LexemeType.semicolon);
        restOfVariableDeclarator(cuc, modifiers, resultType, identifier, IdentifierType.CLASS_VARIABLE, fieldStopSet);

        if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.semicolon), localStopSet)) {
          // skip semicolon
          lexeme = cuc.lexemeReader.getLexeme(sourceCode);
        }
      }
    } else {
      // extend error reporting, using lexeme types in localSet as a guidance.
      error(cuc.lexemeReader, 3, "expected an identifier");
    }

    debug("\nclassBodyDeclaration: end");
  } // classBodyDeclaration

  protected void checkFieldModifiers(LexemeReader lexemeReader, EnumSet<LexemeType> modifiers) {
    // semantic analysis of modifiers:
    // - modifier "static" is mandatory (no class instantiation).
    // - modifiers may be: "public", "private", "static", "final" or "volatile"
    if (!modifiers.contains(LexemeType.staticLexeme)) {
      error(lexemeReader, 30);
    }
    EnumSet<LexemeType> temp = modifiers.clone();
    temp.removeAll(FIELD_MODIFIERS);
    if (!temp.isEmpty()) {
      error(lexemeReader, 31);
    }
  } // checkFieldModifiers

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
   * @throws SyntaxError
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
  private void restOfVariableDeclarator(CompilationUnitContext cuc, EnumSet<LexemeType> modifiers, ResultType type,
      String firstIdentifier, IdentifierType identifierType, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nfieldDeclaration: start " + firstIdentifier);

    // semantic analysis
    String fullyQualifiedName = getFullyQualifiedName(cuc, firstIdentifier);
    if (identifiers.declareId(fullyQualifiedName, identifierType, type.getType(), modifiers)) {
      debug(String.format("\n%s declaration: $s %s %s", identifierType, modifiers, type.getType(), fullyQualifiedName));
    } else {
      error(cuc.lexemeReader, "variable " + fullyQualifiedName + " already declared.");
    }

    // semicolon indicates single primitive declarator without initializer.
    if (lexeme.type == LexemeType.semicolon) {
      // skip semicolon
      // lexeme = lexemeReader.getLexeme(sourceCode);
    } else {
      // Add array declarators here...
      int numberOfDimensions = 0;

      // parse ( "=" VariableInitializer )?
      if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.assign), stopSet)) {
        // skip assignment sign
        lexeme = cuc.lexemeReader.getLexeme(sourceCode);

        if (numberOfDimensions == 0) {
          // EnumSet<LexemeType> localSet = stopSet.clone();
          // localSet.add(LexemeType.semicolon);
          EnumSet<LexemeType> localSet = EnumSet.of(LexemeType.semicolon);

          Variable var = identifiers.getId(fullyQualifiedName);
          Operand leftOperand = new Operand(var.getIdentifierType(), var.getDataType(), var.getAddress());
          leftOperand.isFinal = var.isFinal();
          debug("\nFieldDeclaration: leftOperand = " + leftOperand);

          if (modifiers.contains(LexemeType.staticLexeme) && modifiers.contains(LexemeType.finalLexeme)) {
            // Static final field is treated as compile-time constant.
            // Therefore, initializer must be a compile-time constant
            // expression.

            // Parse constant expression.
            // TODO support constant expression, not just a constant.
            Operand rightOperand = constantExpression(cuc, localSet);

            // no assignment but constant definition.
            if (var.getDataType() != rightOperand.dataType) {
              error(cuc.lexemeReader, 14);
            } else if (rightOperand.opType == OperandType.CONSTANT) {
              var.setIntValue(rightOperand.intValue);
              debug("\nFieldDeclaration: static final " + var.getFullyQualifiedName() + " = " + var.getIntValue());
            } else {
              error(cuc.lexemeReader, 17);
            }
          } else {
            // Proper run-time initializer.

            // Code generation
            Operand jumpingTo = instructions.get(cuc.jumpFrom).operand;
            if (identifierType == IdentifierType.CLASS_VARIABLE) {
              if (jumpingTo.intValue == 0) {
                plantSource();
                jumpingTo.intValue = instructions.size();
              }
              cuc.doingMemberInitializer = true;
            }

            // Semantic analysis
            // Parse expression.
            Operand rightOperand = expression(cuc, localSet);

            // Code generation.
            generateAssignment(cuc.lexemeReader, leftOperand, rightOperand);
            debug("\nFieldDeclaration: " + var.getFullyQualifiedName() + " = " + rightOperand);
          }
        } else {
          throw new RuntimeException("Internal compiler error in restOfVariableDeclarator(): abort.");
        }

        // code generation.
        clearRegisters();
      }
    }

    debug("\nfieldDeclaration: end");
  } // restOfVariableDeclarator

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
   * @throws SyntaxError
   */
  // restOfMethodDeclarator ::= ( formalParameters* )? ")" block.
  //
  // FIXME avoid stackPointer+ constant 0 if identifiers.getScopeSize()==0.
  // TODO implement semantic analysis of modifiers in methodDeclaration.
  // TODO implement stopSet in methodDeclaration.
  // TODO implement code generation for less than trivial return statement.
  private void restOfMethodDeclaration(CompilationUnitContext cuc, EnumSet<LexemeType> modifiers, ResultType resultType,
      String methodName, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nmethodDeclaration: start " + methodName);

    // semantic analysis of modifiers:
    // - modifier "static" is mandatory (no class instantiation).
    // - modifiers may be: "public", "private", "static" or "synchronized".
    if (!modifiers.contains(LexemeType.staticLexeme)) {
      error(cuc.lexemeReader, 25);
    }
    EnumSet<LexemeType> temp = modifiers.clone();
    temp.removeAll(METHOD_MODIFIERS);
    if (!temp.isEmpty()) {
      error(cuc.lexemeReader, 26);
    }

    // semantic analysis of method return type:
    if (resultType.getType() == LexemeType.unknown) {
      error(cuc.lexemeReader, 27); // return type missing.
    }

    // semantic analysis of identifier:
    String fullyQualifiedMethodName = getFullyQualifiedName(cuc, methodName);
    if (identifiers.declareId(fullyQualifiedMethodName, IdentifierType.METHOD, resultType.getType(), modifiers)) {
      debug("\nmethodDeclaration: " + modifiers + " " + fullyQualifiedMethodName + "(...)");
    } else {
      error(cuc.lexemeReader, "identifier " + fullyQualifiedMethodName + " already declared.");
    }
    // skip left bracket
    lexeme = cuc.lexemeReader.getLexeme(sourceCode);

    // semantic analysis: start a new method level declaration scope.
    identifiers.newScope();

    // lexical analysis
    Variable method = identifiers.getId(fullyQualifiedMethodName);
    formalParameters(cuc.lexemeReader, method);

    // code generation
    int methodAddress = saveLabel();
    Instruction methodInstruction = new Instruction(FunctionType.method, fullyQualifiedMethodName, modifiers, resultType);
    methodInstruction.formalParameters = method.getFormalParameters();
    plant(cuc.lexemeReader, methodInstruction);
    // set start address for this method.
    method.setIntValue(methodAddress);
    // add method to symbol table.
    Symbol newSymbol = new Symbol();
    newSymbol.address = methodAddress;
    newSymbol.name = fullyQualifiedMethodName;
    newSymbol.resultType = resultType;
    newSymbol.modifiers = modifiers;
    methodSymbolTable.add(newSymbol);
    // save current base pointer
    plant(cuc.lexemeReader, new Instruction(FunctionType.stackBasePointer));
    // allocate space on stack for local variables.
    plant(cuc.lexemeReader, new Instruction(FunctionType.basePointerLoad, new Operand(OperandType.STACK_POINTER)));
    int claimStackSpaceAddress = saveLabel();
    plant(cuc.lexemeReader, new Instruction(FunctionType.stackPointerPlus, new Operand(OperandType.CONSTANT, DataType.word, 0)));

    // lexical analysis
    block(cuc, stopSet);

    // code generation
    setScopeSize(claimStackSpaceAddress, identifiers.getMaxScopeSize());
    generateReturnStatement(cuc.lexemeReader);

    // semantic analysis: close the method level declaration scope.
    identifiers.closeScope();

    debug("\nmethodDeclaration: end");
  } // restOfMethodDeclaration()

  // formalParameters ::= [ formalParameter { "," formalParameter } ] ")".
  private void formalParameters(LexemeReader lexemeReader, Variable method) throws FatalError {
    // Global variable lexeme holds the lexeme after the left bracket.
    debug("\nformalParameters: start");

    // process formal parameters until closing parenthesis or stop set.
    EnumSet<LexemeType> stopSet = EnumSet.of(LexemeType.RPAREN, LexemeType.semicolon, LexemeType.beginLexeme);
    while (!stopSet.contains(lexeme.type)) {
      formalParameter(lexemeReader, method, stopSet);

      if (lexeme.type == LexemeType.COMMA) {
        // skip right bracket
        lexeme = lexemeReader.getLexeme(sourceCode);
      }
    }

    // process closing parenthesis.
    if (checkOrSkip(lexemeReader, EnumSet.of(LexemeType.RPAREN), EnumSet.of(LexemeType.semicolon, LexemeType.beginLexeme))) {
      // skip right bracket
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\nformalParameters: end");
  } // formalParameters()

  // formalParameter ::= modifiers type variableDeclaratorId.
  //
  // with semantic constraints:
  // - Formal parameter modifiers ::= "final"?
  private void formalParameter(LexemeReader lexemeReader, Variable method, EnumSet<LexemeType> stopSet) throws FatalError {
    EnumSet<LexemeType> modifiers = formalParameterModifiers(lexemeReader);
    ResultType type = type(lexemeReader, stopSet);

    if (checkOrSkip(lexemeReader, EnumSet.of(LexemeType.identifier), stopSet)) {
      String identifier = lexeme.idVal;
      lexeme = lexemeReader.getLexeme(sourceCode);

      // semantic analysis
      if (identifiers.declareId(identifier, IdentifierType.FORMAL_PARAMETER, type.getType(), modifiers)) {
        Variable var = identifiers.getId(identifier);
        debug(String.format("\n%s declaration: $s %s %s", identifier, modifiers, type.getType(), identifier));
        FormalParameter parameter = new FormalParameter(identifier, modifiers, type.getDataType(), var.getAddress());
        method.addFormalParameter(parameter);
      } else {
        error(lexemeReader, "formal parameter " + identifier + " already declared.");
      }
    } else {
      // extend error reporting, using lexeme types in localSet as a guidance.
      error(lexemeReader, 3, "expected an identifier");
    }
  } // formalParameter

  private EnumSet<LexemeType> formalParameterModifiers(LexemeReader lexemeReader) throws FatalError {
    // lexical analysis
    EnumSet<LexemeType> modifiers = modifiers(lexemeReader);

    // semantic analysis: check for possible modifiers.
    EnumSet<LexemeType> temp = modifiers.clone();
    temp.removeAll(FORMAL_PARAMETER_MODIFIERS);
    if (!temp.isEmpty()) {
      error(lexemeReader, 35);
    }
    return modifiers;
  }

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
  private ResultType resultType(LexemeReader lexemeReader, EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nresultType: start");
    ResultType result = new ResultType();

    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.semicolon);
    localSet.add(LexemeType.RPAREN);
    localSet.add(LexemeType.beginLexeme);
    if (checkOrSkip(lexemeReader, RESULT_TYPE_LEXEME_TYPES, localSet)) {
      result.setType(lexeme.type);
      // skip void or type lexeme.
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\nresultType: end; type=" + result.getType());
    return result;
  } // resultType()

  // name ::= javaIdentifier { "." javaIdentifier }.
  private String name(LexemeReader lexemeReader, EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nname: start");
    String result = "";

    // recognize identifier.
    if (checkOrSkip(lexemeReader, EnumSet.of(LexemeType.identifier), stopSet)) {
      result = lexeme.idVal;

      // recognize { "." identifier }.
      lexeme = lexemeReader.getLexeme(sourceCode);
      while (lexeme.type == LexemeType.period) {
        // skip the period
        lexeme = lexemeReader.getLexeme(sourceCode);

        // recognize another identifier.
        if (lexeme.type == LexemeType.identifier) {
          result += "." + lexeme.idVal;
          lexeme = lexemeReader.getLexeme(sourceCode);
        } else if (lexeme.type == LexemeType.mulop && lexeme.operator == OperatorType.mul) {
          result += ".*";
          lexeme = lexemeReader.getLexeme(sourceCode);
        } else {
          error(lexemeReader, 3, "found " + lexeme.type + ", expected identifer or '*'");
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
   * @throws SyntaxError
   * 
   *************************/

  // block ::= "{" { blockStatement } "}".
  //
  // parse a block of statements, and return the address of the first object
  // code in the block of statements.
  private int block(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nblock: start with stopSet = " + stopSet);

    // semantic analysis: address of next object code instruction.
    int firstAddress = saveLabel();

    // lexical analysis.
    EnumSet<LexemeType> stopBlockSet = stopSet.clone();
    stopBlockSet.add(LexemeType.semicolon);
    stopBlockSet.add(LexemeType.endLexeme);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.beginLexeme), stopBlockSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);

      // semantic analysis: start a new declaration scope.
      identifiers.newScope();

      // lexical analysis.
      while (lexeme.type != LexemeType.endLexeme) {
        blockStatement(cuc, EnumSet.of(LexemeType.endLexeme));
      }

      // semantic analysis: close the declaration scope.
      identifiers.closeScope();

      // lexical analysis: skip endLexeme
      plantSource();
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    debug("\nblock: end, firstAddress = " + firstAddress);
    return firstAddress;
  } // block

  // blockStatement ::= localVariableStatement | statement.
  private void blockStatement(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nblockStatement: start with stopSet = " + stopSet);

    // lexical analysis.
    if (TYPE_LEXEME_TYPES.contains(lexeme.type) || FIELD_MODIFIERS.contains(lexeme.type)) {
      localVariableStatement(cuc, stopSet);
    } else {
      statement(cuc, stopSet);
    }

    debug("\nblockStatement");
  }// blockStatement

  // localVariableStatement ::= localVariableDeclaration ";".
  private void localVariableStatement(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    EnumSet<LexemeType> localStopSet = stopSet.clone();
    localStopSet.add(LexemeType.semicolon);
    localVariableDeclaration(cuc, localStopSet);
    checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.semicolon), stopSet);
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
  private void localVariableDeclaration(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    EnumSet<LexemeType> modifiers = localVariableModifiers(cuc.lexemeReader);
    ResultType type = type(cuc.lexemeReader, stopSet);

    // lexical analysis
    EnumSet<LexemeType> localStopSet = stopSet.clone();
    localStopSet.add(LexemeType.LBRACKET);
    localStopSet.add(LexemeType.assign);
    localStopSet.add(LexemeType.COMMA);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.identifier), localStopSet)) {
      String identifier = lexeme.idVal;
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);

      localStopSet.add(LexemeType.semicolon);
      restOfVariableDeclarator(cuc, modifiers, type, identifier, IdentifierType.LOCAL_VARIABLE, localStopSet);
    } else {
      // extend error reporting, using lexeme types in localSet as a guidance.
      error(cuc.lexemeReader, 3, "expected an identifier");
    }

    // code generation.
    clearRegisters();
  } // localVariableDeclaration

  private ResultType type(LexemeReader lexemeReader, EnumSet<LexemeType> stopSet) throws FatalError {
    // lexical analysis
    EnumSet<LexemeType> localStopSet = stopSet.clone();
    localStopSet.add(LexemeType.identifier);
    ResultType type = resultType(lexemeReader, localStopSet);

    // semantic analysis
    if (type.getType() == LexemeType.unknown) {
      error(lexemeReader, 27);
    } else if (type.getType() == LexemeType.voidLexeme) {
      error(lexemeReader, 32);
    }

    return type;
  }

  private EnumSet<LexemeType> localVariableModifiers(LexemeReader lexemeReader) throws FatalError {
    // lexical analysis
    EnumSet<LexemeType> modifiers = modifiers(lexemeReader);

    // semantic analysis
    // Possible modifiers for a local variable: "final"? "volatile"?.
    EnumSet<LexemeType> temp = modifiers.clone();
    temp.removeAll(LOCAL_VARIABLE_MODIFIERS);
    if (!temp.isEmpty()) {
      error(lexemeReader, 35);
    } else if (modifiers.contains(LexemeType.finalLexeme) && modifiers.contains(LexemeType.volatileLexeme)) {
      error(lexemeReader, 40);
    }

    return modifiers;
  }

  // statement ::= ifStatement | statementExceptIf.
  private int statement(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nstatement: start with stopSet = " + stopSet);
    int firstAddress = saveLabel();

    if (lexeme.type == LexemeType.ifLexeme) {
      ifStatement(cuc, stopSet);
    } else {
      statementExceptIf(cuc, stopSet);
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
  // FIXME optimize branch instruction in ifStatement
  // See test5.j 163: if (b>132) {
  // 1326 acc8= variable 14
  // 1327 acc8Comp constant 132
  // 1328 brle 1345
  // received: 1328 brle 1345
  // expected: 1328 brle 1346
  private void ifStatement(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nifStatement: start with stopSet = " + stopSet);

    // lexical analysis.
    lexeme = cuc.lexemeReader.getLexeme(sourceCode);

    // expect (
    EnumSet<LexemeType> stopSetIf = stopSet.clone();
    stopSetIf.add(LexemeType.RPAREN);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.LPAREN), stopSetIf)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    // expect comparison
    stopSetIf = stopSet.clone();
    stopSetIf.add(LexemeType.RPAREN);
    stopSetIf.addAll(START_STATEMENT);
    stopSetIf.remove(LexemeType.identifier);
    int ifLabel = comparison(cuc, stopSetIf);
    debug("\nifStatement: ifLabel = " + ifLabel);

    // expect )
    stopSetIf = stopSet.clone();
    stopSetIf.addAll(START_STATEMENT);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.RPAREN), stopSetIf)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    // code generation.
    clearRegisters();

    // expect any statement or block, but not an if statement.
    EnumSet<LexemeType> stopSetElse = stopSet.clone();
    stopSetElse.add(LexemeType.elseLexeme);
    statementExceptIf(cuc, stopSetElse);

    if (lexeme.type == LexemeType.elseLexeme) {
      // expect else
      checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.elseLexeme), stopSetElse);

      // code generation.
      int elseLabel = saveLabel();
      plant(cuc.lexemeReader, new Instruction(FunctionType.br, new Operand(OperandType.LABEL, DataType.word, 0)));
      debug("\nifStatement: elselabel=" + elseLabel);
      debug("\nifStatement: plantForwardLabel(" + ifLabel + ")");

      // lexical analysis.
      // expect statement block
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
      plantForwardLabel(ifLabel, statement(cuc, stopSet));

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
  // outputStatement | expressionStatement.
  private int statementExceptIf(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nstatementExceptIf: start with stopSet = " + stopSet);

    // code generation.
    int firstAddress = saveLabel();

    // lexical analysis.
    switch (lexeme.type) {
      case beginLexeme:
        block(cuc, stopSet);
        break;
      case semicolon:
        emptyStatement(cuc.lexemeReader, stopSet);
        break;
      case whileLexeme:
        whileStatement(cuc, stopSet);
        break;
      case doLexeme:
        doStatement(cuc, stopSet);
        break;
      case forLexeme:
        forStatement(cuc, stopSet);
        break;
      case returnLexeme:
        returnStatement(cuc.lexemeReader, stopSet);
        break;
      case printlnLexeme:
        printlnStatement(cuc, stopSet);
        break;
      case outputLexeme:
        outputStatement(cuc, stopSet);
        break;
      default:
        expressionStatement(cuc, stopSet);
    }

    // code generation.
    clearRegisters();

    debug("\nstatementExceptIf: end, firstAddress = " + firstAddress);
    return firstAddress;
  } // statementExceptIf

  // emptyStatement ::= ";".
  private void emptyStatement(LexemeReader lexemeReader, EnumSet<LexemeType> stopSet) throws FatalError {
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
  private void whileStatement(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nwhileStatement: start with stopSet = " + stopSet);
    lexeme = cuc.lexemeReader.getLexeme(sourceCode);

    // code generation.
    int whileLabel = saveLabel();

    // lexical analysis.
    EnumSet<LexemeType> stopWhileSet = stopSet.clone();
    stopWhileSet.add(LexemeType.RPAREN);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.LPAREN), stopWhileSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    // lexical analysis.
    stopWhileSet.addAll(START_STATEMENT);
    stopWhileSet.remove(LexemeType.identifier);
    int endLabel = comparison(cuc, stopWhileSet);

    // code generation.
    clearRegisters();

    // lexical analysis.
    stopWhileSet = stopSet.clone();
    stopWhileSet.addAll(START_STATEMENT);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.RPAREN), stopWhileSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }
    // block(stopSet);
    statementExceptIf(cuc, stopSet);

    // code generation.
    plantThenSource(cuc.lexemeReader, new Instruction(FunctionType.br, new Operand(OperandType.LABEL, DataType.word, whileLabel)));
    plantForwardLabel(endLabel, saveLabel());
    debug("\nwhileStatement: end");
  } // whileStatement()

  // doStatement ::= "do" statement "while" "(" expression ")" ";".
  //
  // TODO refactor doStatement
  // doStatement = "do" block "while" "(" comparison ")" ";".
  private void doStatement(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\ndoStatement: start with stopSet = " + stopSet);
    lexeme = cuc.lexemeReader.getLexeme(sourceCode);

    // code generation.
    int doLabel = saveLabel();

    // lexical analysis.
    // expect block, terminated by "while".
    EnumSet<LexemeType> stopDoSet = stopSet.clone();
    stopDoSet.add(LexemeType.whileLexeme);
    statement(cuc, stopSet);

    // expect "while" followed by "(".
    EnumSet<LexemeType> stopWhileSet = stopSet.clone();
    stopWhileSet.add(LexemeType.RPAREN);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.whileLexeme), stopWhileSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.LPAREN), stopWhileSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    // code generation.
    clearRegisters();

    // expect comparison, terminated by ")"
    stopWhileSet.addAll(START_STATEMENT);
    stopWhileSet.remove(LexemeType.identifier);
    comparisonInDoStatement(cuc, stopWhileSet, doLabel);

    // code generation.
    clearRegisters();

    // expect ")" ";"
    stopWhileSet = stopSet.clone();
    stopWhileSet.add(LexemeType.semicolon);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.RPAREN), stopSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
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
  private void forStatement(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nforStatement: start with stopSet = " + stopSet);

    // semantic analysis: start a new declaration scope for the for
    // statement.
    identifiers.newScope();

    // lexical analysis: "for" "(" initialization ";".
    lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    EnumSet<LexemeType> stopForSet = stopSet.clone();
    stopForSet.add(LexemeType.RPAREN);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.LPAREN), stopForSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    // In the initialization part a new variable must be declared.
    EnumSet<LexemeType> stopInitializationSet = stopForSet.clone();
    stopInitializationSet.add(LexemeType.semicolon);
    String variable = assignment(cuc, stopInitializationSet);
    if (variable == null) {
      error(cuc.lexemeReader, "Loop variable must be declared in for statement; for (word variable; .. ; ..) {..} expected.");
    }
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }
    // code generation.
    clearRegisters();

    // lexical analysis: comparison ";".
    stopInitializationSet.addAll(START_STATEMENT);
    stopInitializationSet.remove(LexemeType.identifier);
    int forLabel = saveLabel();
    int gotoEnd = comparison(cuc, stopInitializationSet);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.semicolon), stopInitializationSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }
    // order of steps in p-sourcecode: comparison - update - block.
    // order of steps during execution: comparison - block - update.

    // code generation: skip update and jump forward to block.
    int gotoBlock = saveLabel();
    plant(cuc.lexemeReader, new Instruction(FunctionType.br, new Operand(OperandType.LABEL, DataType.word, 0)));
    int updateLabel = saveLabel();

    // code generation.
    clearRegisters();

    // lexical analysis: update.
    stopForSet.add(LexemeType.beginLexeme);
    if (lexeme.type != LexemeType.RPAREN) {
      update(cuc, stopForSet);
    }

    // code generation: jump back to comparison.
    plant(cuc.lexemeReader, new Instruction(FunctionType.br, new Operand(OperandType.LABEL, DataType.word, forLabel)));

    // code generation.
    clearRegisters();

    // lexical analysis: ")".
    stopForSet = stopSet.clone();
    stopForSet.addAll(START_STATEMENT);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.RPAREN), stopForSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    // code generation: start of block.
    plantForwardLabel(gotoBlock, saveLabel());

    // lexical analysis: block.
    // block(stopSet);
    statementExceptIf(cuc, stopSet);

    // code generation; jump back to update.
    plantThenSource(cuc.lexemeReader, new Instruction(FunctionType.br, new Operand(OperandType.LABEL, DataType.word, updateLabel)));
    plantForwardLabel(gotoEnd, saveLabel());

    // todo: getLexeme na bovenstaande code generatie.

    // semantic analysis: close the declaration scope of the for
    // statement.
    identifiers.closeScope();
    debug("\nforStatement: end");
  } // forStatement()

  // returnStatement ::= "return" expression? ";".
  private void returnStatement(LexemeReader lexemeReader, EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nreturnStatement: start with stopSet = " + stopSet);

    // Skip return lexeme.
    lexeme = lexemeReader.getLexeme(sourceCode);

    // TODO implement returnStatement.
    // For now, accept only empty return statement.
    if (checkOrSkip(lexemeReader, EnumSet.of(LexemeType.semicolon), stopSet)) {
      // code generation
      plantSource();
      generateReturnStatement(lexemeReader);
    } else {
      error(lexemeReader, " Return statement with return value not supported.");
    }

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
  private void printlnStatement(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nprintlnStatement: start with stopSet = " + stopSet);

    // lexical analysis.
    // skip println symbol.
    lexeme = cuc.lexemeReader.getLexeme(sourceCode);

    EnumSet<LexemeType> stopWriteSet = stopSet.clone();
    stopWriteSet.addAll(START_EXPRESSION);
    stopWriteSet.add(LexemeType.RPAREN);
    stopWriteSet.add(LexemeType.semicolon);

    // skip left bracket.
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.LPAREN), stopWriteSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    // read first operand.
    EnumSet<LexemeType> stopExpressionSet = stopSet.clone();
    stopExpressionSet.add(LexemeType.RPAREN);
    stopExpressionSet.add(LexemeType.semicolon);
    Operand operand = factor(cuc, stopExpressionSet);
    EnumSet<LexemeType> startExpressionSet = stopExpressionSet.clone();
    startExpressionSet.add(LexemeType.addop);

    // handle string expression or algorithmic expression.
    if (operand.dataType == DataType.string) {
      // string expression.
      do {
        // lexical analysis.
        if ((lexeme.type == LexemeType.addop) && (lexeme.operator == OperatorType.add)) {
          debug("\nprintlnStatement: " + operand + ", lexeme=" + lexeme.makeString(null));
          // code generation.
          plantPrintln(cuc.lexemeReader, operand, false);

          // lexical analysis.
          // skip addop symbol.
          lexeme = cuc.lexemeReader.getLexeme(sourceCode);

          // read next factor.
          operand = factor(cuc, startExpressionSet);
        } else if (lexeme.type != LexemeType.RPAREN) {
          // lexical analysis.
          // only + symbol allowed between terms in string expression.
          error(cuc.lexemeReader, 3, " " + lexeme.makeString(null));
          // skip unexpected symbol.
          if (checkOrSkip(cuc.lexemeReader, EnumSet.of(lexeme.type), stopWriteSet)) {
            lexeme = cuc.lexemeReader.getLexeme(sourceCode);
          }
        }
      } while (lexeme.type != LexemeType.RPAREN);

      debug("\nprintlnStatement: " + operand + ", lexeme=" + lexeme.makeString(null));
      // code generation.
      plantPrintln(cuc.lexemeReader, operand, true);
    } else {
      // algorithmic expression.
      operand = termWithOperand(cuc, 0, operand, startExpressionSet);
      debug("\nprintlnStatement: " + operand);

      // code generation.
      plantPrintln(cuc.lexemeReader, operand, true);
    }

    // lexical analysis.
    // skip right bracket.
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.RPAREN), stopExpressionSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    // skip semicolon.
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    debug("\nprintlnStatement: end");
  } // printlnStatement

  // outputStatement = "output" "(" constantExpression "," expression ")".
  // TODO Add non-constant port value to output/input (IN0 A,(C); OUT0 (C),A).
  // TODO Test various expressions for output(byte port, byte value). See
  // ledtest.j.
  private void outputStatement(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\noutputStatement: start with stopSet = " + stopSet);

    // lexical analysis.
    // skip output symbol.
    lexeme = cuc.lexemeReader.getLexeme(sourceCode);

    EnumSet<LexemeType> stopOutputSet = stopSet.clone();
    stopOutputSet.addAll(START_EXPRESSION);
    stopOutputSet.add(LexemeType.COMMA);
    stopOutputSet.add(LexemeType.RPAREN);
    stopOutputSet.add(LexemeType.semicolon);

    // skip left bracket.
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.LPAREN), stopOutputSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    EnumSet<LexemeType> stopExpressionSet = stopSet.clone();
    stopExpressionSet.add(LexemeType.COMMA);
    stopExpressionSet.add(LexemeType.RPAREN);
    stopExpressionSet.add(LexemeType.semicolon);

    // read constant expression.
    Operand port = constantExpression(cuc, stopExpressionSet);

    // lexical analysis.
    stopOutputSet = stopSet.clone();
    stopOutputSet.addAll(START_EXPRESSION);
    stopOutputSet.add(LexemeType.RPAREN);
    stopOutputSet.add(LexemeType.semicolon);

    // skip COMMA.
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.COMMA), stopOutputSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    stopExpressionSet = stopSet.clone();
    stopExpressionSet.add(LexemeType.RPAREN);
    stopExpressionSet.add(LexemeType.semicolon);

    // read second expression.
    Operand value = expression(cuc, stopExpressionSet);

    // semantic analysis.
    debug("\noutputStatement: value = " + value + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    // FIXME check value is a byte expression.

    // code generation.
    plant(cuc.lexemeReader, new Instruction(FunctionType.output, port, value));

    // lexical analysis.
    // skip right bracket.
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.RPAREN), stopExpressionSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    // skip semicolon.
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    debug("\noutput: end");
  } // outputStatement

  // expressionStatement ::= statementExpression ";".
  private void expressionStatement(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nexpressionStatement: start with stopSet = " + stopSet + "; lexeme.type=" + lexeme.type);

    EnumSet<LexemeType> expressionStatement = stopSet.clone();
    expressionStatement.add(LexemeType.semicolon);

    statementExpression(cuc, expressionStatement);
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
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
  // TODO implement arraySelector.
  private void statementExpression(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nstatementExpression: start with stopSet = " + stopSet + "; lexeme.type=" + lexeme.type);
    try {
      if (lexeme.type == LexemeType.increment) {
        preincrementExpression(cuc, stopSet);
      } else if (lexeme.type == LexemeType.decrement) {
        predecrementExpression(cuc, stopSet);
      } else if (lexeme.type == LexemeType.identifier) {
        String name = name(cuc.lexemeReader, stopSet);

        // semantic analysis.
        Variable method = identifiers.getId(cuc.packageName, cuc.className, name);
        // FIXME check visibility of name:
        // - within current class.
        // - within same package and public or protected.
        // - anywhere else and public.

        // Syntax analysis.
        if (lexeme.type == LexemeType.increment) {
          postincrementExpression(cuc, name, stopSet);
        } else if (lexeme.type == LexemeType.decrement) {
          postdecrementExpression(cuc, name, stopSet);
        } else if (lexeme.type == LexemeType.LPAREN) {
          methodInvocation(cuc, method, stopSet);
        } else {
          assignment(cuc, name, stopSet);
        }
      } else {
        throw new SyntaxError("unexpected symbol; " + lexeme.makeString(null));
      }
    } catch (SyntaxError e) {
      error(cuc.lexemeReader, e.getMessage());
      skipUntilStopSet(cuc.lexemeReader, stopSet);
    }

    debug("\nstatementExpression: end");
  } // statementExpression

  // preincrementExpression ::= "++" name.
  private void preincrementExpression(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.increment), stopSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);

      // TODO support fully qualified name instead of just an identifier.
      if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.identifier), stopSet)) {
        // semantic analysis.
        Variable var = identifiers.getId(cuc.packageName, cuc.className, lexeme.idVal);
        Operand leftOperand = new Operand(var.getIdentifierType(), var.getDataType(), var.getAddress());
        leftOperand.isFinal = var.isFinal();
        debug("\nupdate: leftOperand = " + leftOperand);

        // code generation.
        if (var.getDataType() == DataType.word) {
          plant(cuc.lexemeReader, new Instruction(FunctionType.increment16, leftOperand));
        } else if (var.getDataType() == DataType.byt) {
          plant(cuc.lexemeReader, new Instruction(FunctionType.increment8, leftOperand));
        } else {
          throw new FatalError("internal compiler error during code generation.");
        }

        // lexical analysis.
        lexeme = cuc.lexemeReader.getLexeme(sourceCode);
      }
    }
  } // preincrementExpression

  // predecrementExpression ::= "--" name.
  private void predecrementExpression(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.decrement), stopSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);

      // TODO support fully qualified name instead of just an identifier.
      if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.identifier), stopSet)) {
        // semantic analysis.
        Variable var = identifiers.getId(cuc.packageName, cuc.className, lexeme.idVal);
        Operand leftOperand = new Operand(var.getIdentifierType(), var.getDataType(), var.getAddress());
        leftOperand.isFinal = var.isFinal();
        debug("\nupdate: leftOperand = " + leftOperand);

        // code generation.
        if (var.getDataType() == DataType.word) {
          plant(cuc.lexemeReader, new Instruction(FunctionType.decrement16, leftOperand));
        } else if (var.getDataType() == DataType.byt) {
          plant(cuc.lexemeReader, new Instruction(FunctionType.decrement8, leftOperand));
        } else {
          throw new FatalError("internal compiler error during code generation.");
        }

        // lexical analysis.
        lexeme = cuc.lexemeReader.getLexeme(sourceCode);
      }
    }
  } // predecrementExpression

  // postincrementExpression ::= name "++".
  private void postincrementExpression(CompilationUnitContext cuc, String name, EnumSet<LexemeType> stopSet) throws FatalError {
    try {
      // semantic analysis.
      Variable var = identifiers.getId(cuc.packageName, cuc.className, name);
      debug("\nassignment: variable = " + var);

      // lexical analysis.
      if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.increment), stopSet)) {
        lexeme = cuc.lexemeReader.getLexeme(sourceCode);

        // semantic analysis.
        Operand leftOperand = new Operand(var.getIdentifierType(), var.getDataType(), var.getAddress());
        leftOperand.isFinal = var.isFinal();
        debug("\npostincrementExpression: leftOperand = " + leftOperand);

        // code generation.
        if (var.getDataType() == DataType.word) {
          plant(cuc.lexemeReader, new Instruction(FunctionType.increment16, leftOperand));
        } else if (var.getDataType() == DataType.byt) {
          plant(cuc.lexemeReader, new Instruction(FunctionType.increment8, leftOperand));
        } else {
          throw new FatalError("internal compiler error during code generation.");
        }
      }
    } catch (SyntaxError e) {
      error(cuc.lexemeReader, e.getMessage());
      skipUntilStopSet(cuc.lexemeReader, stopSet);
    }
  } // postincrementExpression

  // postdecrementExpression ::= name "--".
  private void postdecrementExpression(CompilationUnitContext cuc, String name, EnumSet<LexemeType> stopSet) throws FatalError {
    try {
      // semantic analysis.
      Variable var = identifiers.getId(cuc.packageName, cuc.className, name);
      debug("\nassignment: variable = " + var);

      // lexical analysis.
      if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.decrement), stopSet)) {
        lexeme = cuc.lexemeReader.getLexeme(sourceCode);

        // semantic analysis.
        Operand leftOperand = new Operand(var.getIdentifierType(), var.getDataType(), var.getAddress());
        leftOperand.isFinal = var.isFinal();
        debug("\npostdecrementExpression: leftOperand = " + leftOperand);

        // code generation.
        if (var.getDataType() == DataType.word) {
          plant(cuc.lexemeReader, new Instruction(FunctionType.decrement16, leftOperand));
        } else if (var.getDataType() == DataType.byt) {
          plant(cuc.lexemeReader, new Instruction(FunctionType.decrement8, leftOperand));
        } else {
          throw new FatalError("internal compiler error during code generation.");
        }
      }
    } catch (SyntaxError e) {
      error(cuc.lexemeReader, e.getMessage());
      skipUntilStopSet(cuc.lexemeReader, stopSet);
    }
  } // postdecrementExpression

  // methodInvocation ::= name arguments.
  private void methodInvocation(CompilationUnitContext cuc, Variable method, EnumSet<LexemeType> stopSet)
      throws FatalError, SyntaxError {
    // FIXME support method call before method declaration.
    // get the method signature from the list of identifiers.
    debug("\nmethod invocation: " + method);

    // lexical and semantic analysis.
    // Get the optional list of actual parameters
    // and check if they match the formal parameters in the method definition.
    // Return value is the number of bytes needed on the stack for the
    // arguments.
    int stackSize = arguments(cuc, method, stopSet);

    // semantic analysis: check return type.
    // TODO add check of return type.
    if (method.getDataType() != DataType.voidd) {
      error(cuc.lexemeReader, 37); // incompatible return type.
    }

    // code generation.
    plant(cuc.lexemeReader, new Instruction(FunctionType.call, new Operand(method.getFullyQualifiedName(), method.getIntValue())));
    if (stackSize > 0) {
      plant(cuc.lexemeReader,
          new Instruction(FunctionType.stackPointerPlus, new Operand(OperandType.CONSTANT, DataType.word, -stackSize)));
    }
  } // methodInvocation

  // TODO refactor assignment.
  private void assignment(CompilationUnitContext cuc, String name, EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nassignment: start with stopSet = " + stopSet + "; variable e=" + name);

    try {
      // semantic analysis.
      Variable var = identifiers.getId(cuc.packageName, cuc.className, name);
      debug("\nassignment: variable = " + var);
      Operand leftOperand = new Operand(var.getIdentifierType(), var.getDataType(), var.getAddress());
      leftOperand.isFinal = var.isFinal();
      debug("\nassignment: leftOperand = " + leftOperand);

      // lexical analysis.
      EnumSet<LexemeType> stopAssignmentSet = stopSet.clone();
      stopAssignmentSet.addAll(START_EXPRESSION);
      stopAssignmentSet.add(LexemeType.semicolon);
      if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.assign), stopAssignmentSet)) {
        // identifier "=" expression
        lexeme = cuc.lexemeReader.getLexeme(sourceCode);
        Operand rightOperand = expression(cuc, stopSet);

        // lexical analysis.
        if (var.isFinal()) {
          // assignment to a final variable.
          error(cuc.lexemeReader, 34);
        } else {
          // code generation.
          generateAssignment(cuc.lexemeReader, leftOperand, rightOperand);
        }
      }
    } catch (SyntaxError e) {
      error(cuc.lexemeReader, e.getMessage());
      skipUntilStopSet(cuc.lexemeReader, stopSet);
    }

    debug("\nassignment: end");
  } // assignment()

  /**
   * Get the optional list of actual parameters and check if they match the
   * formal parameters in the method definition.
   * 
   * arguments ::= "(" argumentList? ")".
   * 
   * @param method:
   *          method definition containing the formal parameters for which the
   *          arguments will be substituted.
   * @param stopSet:
   *          skip until lexeme in this set is found in case of a lexicographic
   *          error.
   * @returns number of bytes needed on the stack for the arguments.
   * @throws FatalError
   * @throws SyntaxError
   */
  private int arguments(CompilationUnitContext cuc, Variable method, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\narguments: start with stopSet = " + stopSet);
    int stackSize = 0;

    EnumSet<LexemeType> localStopSet = stopSet.clone();
    localStopSet.add(LexemeType.RPAREN);

    // skip opening left parenthesis.
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.LPAREN), localStopSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);

      if (lexeme.type != LexemeType.RPAREN) {
        stackSize = argumentList(cuc, method, localStopSet);
      } else if (method.getFormalParameters().size() != 0) {
        error(cuc.lexemeReader, 39); // nr of arguments does not match nr of
                                     // formal
        // parameters.
      }

      // skip closing right parenthesis.
      if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.RPAREN), localStopSet)) {
        lexeme = cuc.lexemeReader.getLexeme(sourceCode);
      } else {
        if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.RPAREN), localStopSet)) {
          lexeme = cuc.lexemeReader.getLexeme(sourceCode);
        }
      }
    }

    debug("\narguments: end; stack size=" + stackSize);
    return stackSize;
  } // arguments

  /**
   * Get the list of actual parameters and check if they match the formal
   * parameters in the method definition.
   * 
   * argumentList ::= expression { "," expression }.
   * 
   * @param method:
   *          method definition containing the formal parameters for which the
   *          arguments will be substituted.
   * @param stopSet:
   *          skip until lexeme in this set is found in case of a lexicographic
   *          error.
   * @returns number of bytes needed on the stack for the arguments.
   * @throws FatalError
   * @throws SyntaxError
   */
  private int argumentList(CompilationUnitContext cuc, Variable method, EnumSet<LexemeType> stopSet)
      throws FatalError, SyntaxError {
    debug("\nargumentList: start with stopSet = " + stopSet);
    int stackSize = 0;

    // process expression until closing parenthesis or other lexeme in stop set.
    EnumSet<LexemeType> localStopSet = stopSet.clone();
    localStopSet.add(LexemeType.COMMA);
    int parameterIndex = 0;
    while (!stopSet.contains(lexeme.type)) {
      Operand expression = expression(cuc, localStopSet);

      // semantic analysis.
      if (parameterIndex >= method.getFormalParameters().size()) {
        error(cuc.lexemeReader, 39); // number of arguments does not match
                                     // number of
        // formal
        // parameters.
      } else {
        FormalParameter parameter = method.getFormalParameter(parameterIndex);
        if (parameter.getDataType() != expression.dataType) {
          error(cuc.lexemeReader, 41); // incompatible data type between
                                       // argument
          // and formal
          // parameter.
        }
      }

      // code generation.
      stackSize += generateArgument(cuc.lexemeReader, expression);

      // lexical analysis.
      if (lexeme.type == LexemeType.COMMA) {
        // skip comma separating expressions in the argument list
        lexeme = cuc.lexemeReader.getLexeme(sourceCode);
      }
    }

    debug("\nargumentList: end");
    return stackSize;
  } // argumentList

  /*********************************************
   * 
   * Old lexical parsing methods to be refactored.
   * 
   * @throws SyntaxError
   * 
   *********************************************/

  // TODO refactor lexical parsing methods below.

  // constantExpression = constant | {addop constant}.
  // TODO Implement constantExpression.
  // TODO Allow algorithmic expression as value for 'final' qualifier. See
  // test13.j.
  // TODO Generate constant in Z80 code in hex notation if the constant was
  // written in hex notation in J-code. See ledtest.j.
  private Operand constantExpression(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nconstantExpression: start with stopSet = " + stopSet);

    // lexical analysis.
    Operand port = factor(cuc, stopSet);

    // semantic analysis.
    debug("\nconstantExpression: port = " + port + ", final = " + port.isFinal + ", acc16InUse = " + acc16.inUse()
        + ", acc8InUse = " + acc8.inUse());
    // port must be a constant or a final variable
    // convert port operand from final var to constant.
    if ((port.opType == OperandType.GLOBAL_VAR || port.opType == OperandType.LOCAL_VAR) && port.isFinal) {
      port = new Operand(OperandType.CONSTANT, port.dataType, identifiers.getId(port.strValue).getIntValue());
    }
    if (port.opType != OperandType.CONSTANT) {
      error(cuc.lexemeReader, 16);
    }

    debug("\nconstantExpression: end");
    return port;
  } // constantExpression()

  // inputFactor = "input" "(" constantExpression ")".
  // TODO Add support for input data (see Z80Compiler.class; call to
  // Interpreter).
  private Operand inputFactor(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\ninputFactor: start with stopSet = " + stopSet);

    // lexical analysis.
    // skip input symbol.
    lexeme = cuc.lexemeReader.getLexeme(sourceCode);

    EnumSet<LexemeType> stopInputSet = stopSet.clone();
    stopInputSet.addAll(START_EXPRESSION);
    stopInputSet.add(LexemeType.RPAREN);
    stopInputSet.add(LexemeType.semicolon);

    // skip left bracket.
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.LPAREN), stopInputSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    // code generation.
    if (acc8.inUse()) {
      plant(cuc.lexemeReader, new Instruction(FunctionType.stackAcc8));
    }

    // read constant expression.
    Operand port = constantExpression(cuc, stopInputSet);

    // skip right bracket.
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.RPAREN), stopInputSet)) {
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    // semantic analysis.
    debug("\ninputFactor: port = " + port + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());

    // code generation.
    plant(cuc.lexemeReader, new Instruction(FunctionType.input, port));
    // The input() function always returns a byte value.
    Operand operand = new Operand(OperandType.ACC);
    operand.dataType = DataType.byt;
    acc8.setOperand(operand);

    debug("\ninputFactor: end");
    return operand;
  } // inputFactor

  // factor = identifier | constant | stringConstant | "read" | "inputFactor" |
  // "(" expression ")".
  // TODO Introduce built in function malloc() (see test1, test5, test10,
  // test11).
  // TODO Refactor StringConstants.
  private Operand factor(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError {
    Operand operand = new Operand(OperandType.UNKNOWN);
    debug("\nfactor 1: acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    try {
      if (checkOrSkip(cuc.lexemeReader, START_EXPRESSION, stopSet)) {
        if (lexeme.type == LexemeType.identifier) {
          // semantic analysis.
          Variable var = identifiers.getId(cuc.packageName, cuc.className, lexeme.idVal);
          operand = new Operand(var.getIdentifierType(), var.getDataType(), var.getAddress());
          // treat final var as a constant
          if (var.isFinal()) {
            operand.opType = OperandType.CONSTANT;
            operand.intValue = var.getIntValue();
          }
          operand.isFinal = var.isFinal();
          operand.strValue = lexeme.idVal;

          // lexical analysis.
          lexeme = cuc.lexemeReader.getLexeme(sourceCode);
        } else if (lexeme.type == LexemeType.constant) {
          // code generation.
          operand.opType = OperandType.CONSTANT;
          operand.dataType = lexeme.dataType;
          operand.intValue = lexeme.constVal;
          // lexical analysis.
          lexeme = cuc.lexemeReader.getLexeme(sourceCode);
        } else if (lexeme.type == LexemeType.stringConstant) {
          debug("\nlexeme = " + lexeme.makeString(null));
          // semantic analysis.
          int constantId = stringConstants.add(lexeme.stringVal, instructions.size() + 1);
          debug("\nfactor: string constant " + constantId + " = \"" + lexeme.stringVal + "\"");
          // code generation.
          operand.opType = OperandType.CONSTANT;
          operand.dataType = DataType.string;
          operand.strValue = lexeme.stringVal;
          operand.intValue = constantId;
          // lexical analysis.
          lexeme = cuc.lexemeReader.getLexeme(sourceCode);
          debug("\nlexeme = " + lexeme.makeString(null));
        } else if (lexeme.type == LexemeType.readLexeme) {
          lexeme = cuc.lexemeReader.getLexeme(sourceCode);
          // code generation.
          // The read() function always returns a word value.
          if (acc16.inUse()) {
            plant(cuc.lexemeReader, new Instruction(FunctionType.stackAcc16));
          }
          plant(cuc.lexemeReader, new Instruction(FunctionType.read));
          operand.opType = OperandType.ACC;
          operand.dataType = DataType.word;
          acc16.setOperand(operand);
        } else if (lexeme.type == LexemeType.inputLexeme) {
          operand = inputFactor(cuc, stopSet);
        } else if (lexeme.type == LexemeType.LPAREN) {
          // skip left bracket.
          lexeme = cuc.lexemeReader.getLexeme(sourceCode);
          EnumSet<LexemeType> stopSetCopy = stopSet.clone();
          stopSetCopy.add(LexemeType.RPAREN);
          operand = expression(cuc, stopSetCopy);
          // skip right bracket.
          if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.RPAREN), stopSet)) {
            lexeme = cuc.lexemeReader.getLexeme(sourceCode);
          }
        }
      }
    } catch (SyntaxError e) {
      error(cuc.lexemeReader, e.getMessage());
      skipUntilStopSet(cuc.lexemeReader, stopSet);
    }

    // consistency check.
    debug("\nfactor: end: " + operand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    if (operand.opType == OperandType.UNKNOWN) {
      throw new FatalError("internal compiler error during code generation.");
    }

    return operand;
  } // factor()

  // expression = xorTerm {bitwiseOrOp xorTerm}.
  // xorTerm = andTerm {bitwiseXorOp andTerm}
  // andTerm = addTerm {bitwiseAndOp addTerm}.
  // addTerm = term {addop term}.
  // term = factor {mulop factor}.
  private Operand expression(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    // start with lexeme type of lowest precedence.
    return term(cuc, 0, stopSet);
  }

  // Parse a term, as part of an expression, at a given precendence level.
  private Operand term(CompilationUnitContext cuc, int level, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nterm start: level = " + level + ", stopSet = " + stopSet);

    // lexical analysis.
    EnumSet<LexemeType> followSet = stopSet.clone();
    followSet.add(LEXEME_TYPE_AT_LEVEL[level]);
    Operand leftOperand = (level == LEXEME_TYPE_AT_LEVEL.length - 1) ? factor(cuc, followSet) : term(cuc, level + 1, followSet);

    leftOperand = termWithOperand(cuc, level, leftOperand, followSet);
    debug("\nterm: end");
    return leftOperand;
  } // term()

  // Parse a term, as part of an expression, at a given precendence level, given
  // an already parsed left operand.
  private Operand termWithOperand(CompilationUnitContext cuc, int level, Operand leftOperand, EnumSet<LexemeType> followSet)
      throws FatalError, SyntaxError {
    debug("\ntermWithOperand start: level = " + level + ", lexeme = " + lexeme + ", followSet = " + followSet);
    debug("\ntermWithOperand: " + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());

    // lexical analysis.
    // process the first operand at the next level if it is followed by an
    // operator with higher precedence.
    if (level < LEXEME_TYPE_AT_LEVEL.length - 1 && lexeme.type.ordinal() > LEXEME_TYPE_AT_LEVEL[level].ordinal()) {
      leftOperand = termWithOperand(cuc, level + 1, leftOperand, followSet);
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
          plantAccLoad(cuc.lexemeReader, leftOperand);
        }
        leftOperandNotLoaded = false;
      }

      // lexical analysis.
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
      // process the right hand operand and subsequent operators/operands at the
      // next level, ultimately parsing a factor.
      Operand rOperand = (level == LEXEME_TYPE_AT_LEVEL.length - 1) ? factor(cuc, followSet) : term(cuc, level + 1, followSet);

      // code generation.
      debug("\ntermWithOperand loop: level = " + level + ", leftOperand=" + leftOperand + ", rightOperand=" + rOperand
          + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
      // leftOperand: constant, acc, var, stack16, stack8.
      // rOperand: constant, acc, var, stack16, stack8.
      // TODO bitwiseAnd with byte operand (either side) gives a byte result.
      if ((leftOperand.opType == OperandType.ACC) && (rOperand.opType == OperandType.CONSTANT)) {
        if (leftOperand.dataType == DataType.word && rOperand.dataType == DataType.word) {
          plant(cuc.lexemeReader, new Instruction(FORWARD_OPERATION_16.get(operator), rOperand));
        } else if (leftOperand.dataType == DataType.word && rOperand.dataType == DataType.byt) {
          plant(cuc.lexemeReader, new Instruction(FORWARD_OPERATION_16.get(operator), rOperand));
        } else if (leftOperand.dataType == DataType.byt && rOperand.dataType == DataType.byt) {
          plant(cuc.lexemeReader, new Instruction(FORWARD_OPERATION_8.get(operator), rOperand));
        } else if (leftOperand.dataType == DataType.byt && rOperand.dataType == DataType.word) {
          plant(cuc.lexemeReader, new Instruction(FunctionType.acc8ToAcc16));
          leftOperand.dataType = DataType.word;
          acc16.setOperand(leftOperand);
          acc8.clear();
          plant(cuc.lexemeReader, new Instruction(FORWARD_OPERATION_16.get(operator), rOperand));
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.ACC) && (rOperand.opType == OperandType.ACC)) {
        if (leftOperand.dataType == DataType.word && rOperand.dataType == DataType.byt) {
          plant(cuc.lexemeReader, new Instruction(FORWARD_OPERATION_16.get(operator), rOperand));
          acc8.clear();
        } else if (leftOperand.dataType == DataType.byt && rOperand.dataType == DataType.word) {
          plant(cuc.lexemeReader, new Instruction(REVERSE_OPERATION_16.get(operator), leftOperand));
          leftOperand.dataType = DataType.word;
          acc16.setOperand(leftOperand);
          acc8.clear();
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.ACC)
          && (rOperand.opType == OperandType.GLOBAL_VAR || rOperand.opType == OperandType.LOCAL_VAR)) {
        if (leftOperand.dataType == DataType.word && rOperand.dataType == DataType.word) {
          plant(cuc.lexemeReader, new Instruction(FORWARD_OPERATION_16.get(operator), rOperand));
        } else if (leftOperand.dataType == DataType.word && rOperand.dataType == DataType.byt) {
          plant(cuc.lexemeReader, new Instruction(FORWARD_OPERATION_16.get(operator), rOperand));
        } else if (leftOperand.dataType == DataType.byt && rOperand.dataType == DataType.byt) {
          plant(cuc.lexemeReader, new Instruction(FORWARD_OPERATION_8.get(operator), rOperand));
        } else if (leftOperand.dataType == DataType.byt && rOperand.dataType == DataType.word) {
          plant(cuc.lexemeReader, new Instruction(FunctionType.acc8ToAcc16));
          leftOperand.dataType = DataType.word;
          acc16.setOperand(leftOperand);
          acc8.clear();
          plant(cuc.lexemeReader, new Instruction(FORWARD_OPERATION_16.get(operator), rOperand));
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.STACK16) && (rOperand.opType == OperandType.ACC)) {
        if (rOperand.dataType == DataType.word) {
          plant(cuc.lexemeReader, new Instruction(REVERSE_OPERATION_16.get(operator), leftOperand));
          leftOperand.opType = OperandType.ACC;
          leftOperand.dataType = DataType.word;
          acc16.setOperand(leftOperand);
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.STACK8) && (rOperand.opType == OperandType.ACC)) {
        if (rOperand.dataType == DataType.byt) {
          plant(cuc.lexemeReader, new Instruction(REVERSE_OPERATION_8.get(operator), leftOperand));
          leftOperand.opType = OperandType.ACC;
          acc8.setOperand(leftOperand);
        } else if (rOperand.dataType == DataType.word) {
          plant(cuc.lexemeReader, new Instruction(REVERSE_OPERATION_16.get(operator), leftOperand));
          leftOperand.opType = OperandType.ACC;
          leftOperand.dataType = DataType.word;
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
  private int comparison(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\ncomparison: start with stopSet = " + stopSet);

    // lexical analysis.
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.relop);
    Operand leftOperand = expression(cuc, localSet);
    debug("\ncomparison: leftOperand=" + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());

    // code generation.
    if (leftOperand.opType == OperandType.ACC) {
      debug("\ncomparison: push leftOperand to the stack; " + leftOperand);
      if (leftOperand.dataType == DataType.word) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.stackAcc16));
      } else if (leftOperand.dataType == DataType.byt) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.stackAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    }

    // lexical analysis.
    localSet = stopSet.clone();
    localSet.addAll(START_EXPRESSION);
    OperatorType compareOp;
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.relop), localSet)) {
      // code generation.
      compareOp = lexeme.operator;
      // lexical analysis.
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    } else {
      // code generation.
      compareOp = OperatorType.eq;
    }

    // lexical analysis.
    localSet = stopSet.clone();
    localSet.addAll(START_STATEMENT);
    localSet.remove(LexemeType.identifier);
    Operand rightOperand = expression(cuc, localSet);

    // code generation.
    boolean reverseCompare = plantComparisonCode(cuc.lexemeReader, leftOperand, rightOperand);
    int ifLabel = saveLabel();
    Operand labelOperand = new Operand(OperandType.LABEL, DataType.word, 0);
    if (reverseCompare) {
      debug(", reverseCompare");
      plant(cuc.lexemeReader, new Instruction(REVERSE_SKIP.get(compareOp), labelOperand));
    } else {
      plant(cuc.lexemeReader, new Instruction(NORMAL_SKIP.get(compareOp), labelOperand));
    }

    debug("\ncomparison: end");
    return ifLabel;
  } // comparison

  // parse a comparison, jump back to the label if the comparison yields true.
  // comparison = expression relop expression
  private void comparisonInDoStatement(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet, int doLabel)
      throws FatalError, SyntaxError {
    debug("\ncomparisonInDoStatement: start with stopSet = " + stopSet);

    // lexical analysis.
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.relop);
    Operand leftOperand = expression(cuc, localSet);

    // code generation.
    if (leftOperand.opType == OperandType.ACC) {
      debug("\ncomparisonInDoStatement: push leftOperand to the stack; " + leftOperand);
      if (leftOperand.dataType == DataType.word) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.stackAcc16));
      } else if (leftOperand.dataType == DataType.byt) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.stackAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    }

    // lexical analysis.
    localSet = stopSet.clone();
    localSet.addAll(START_EXPRESSION);
    OperatorType compareOp;
    if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.relop), localSet)) {
      // code generation.
      compareOp = lexeme.operator;
      // lexical analysis.
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    } else {
      // code generation.
      compareOp = OperatorType.eq;
    }

    // lexical analysis.
    localSet = stopSet.clone();
    localSet.addAll(START_STATEMENT);
    localSet.remove(LexemeType.identifier);
    Operand rightOperand = expression(cuc, localSet);

    // code generation.
    boolean reverseCompare = plantComparisonCode(cuc.lexemeReader, leftOperand, rightOperand);
    Operand labelOperand = new Operand(OperandType.LABEL, DataType.word, doLabel);
    if (reverseCompare) {
      debug(", reverseCompare");
      if (compareOp == OperatorType.eq) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.brEq, labelOperand));
      } else if (compareOp == OperatorType.ne) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.brNe, labelOperand));
      } else if (compareOp == OperatorType.gt) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.brLt, labelOperand));
      } else if (compareOp == OperatorType.lt) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.brGt, labelOperand));
      } else if (compareOp == OperatorType.ge) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.brLe, labelOperand));
      } else if (compareOp == OperatorType.le) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.brGe, labelOperand));
      }
    } else {
      if (compareOp == OperatorType.eq) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.brEq, labelOperand));
      } else if (compareOp == OperatorType.ne) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.brNe, labelOperand));
      } else if (compareOp == OperatorType.gt) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.brGt, labelOperand));
      } else if (compareOp == OperatorType.lt) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.brLt, labelOperand));
      } else if (compareOp == OperatorType.ge) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.brGe, labelOperand));
      } else if (compareOp == OperatorType.le) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.brLe, labelOperand));
      }
    }

    debug("\ncomparisonInDoStatement: end");
  } // comparisonInDoStatement(stopSet, doLabel)

  // assigment = [declaration] update ";".
  // declaration = [qualifier] dataType.
  // qualifier = "final".
  // dataType = "byte" | "word" | "String".
  //
  // TODO implement isPublic
  private String assignment(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nstatementExpression: start with stopSet = " + stopSet + "; lexeme.type=" + lexeme.type);

    EnumSet<LexemeType> stopAssignmentSet = stopSet.clone();
    stopAssignmentSet.addAll(START_EXPRESSION);
    stopAssignmentSet.add(LexemeType.semicolon);

    // lexical analysis.
    EnumSet<LexemeType> modifiers = EnumSet.noneOf(LexemeType.class);
    if (lexeme.type == LexemeType.finalLexeme) {
      modifiers.add(lexeme.type);
      // skip final lexeme.
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    }

    // lexical analysis.
    String variable = null;
    if (lexeme.type == LexemeType.byteLexeme || lexeme.type == LexemeType.wordLexeme || lexeme.type == LexemeType.stringLexeme) {
      LexemeType dataType = lexeme.type;
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
      if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.identifier), stopAssignmentSet)) {

        // semantic analysis.
        if (identifiers.declareId(lexeme.idVal, IdentifierType.LOCAL_VARIABLE, dataType, modifiers)) {
          debug("\nstatementExpression: " + modifiers + lexeme.makeString(identifiers.getId(lexeme.idVal)));
          variable = lexeme.idVal;
        } else {
          error(cuc.lexemeReader, "variable " + lexeme.idVal + " already declared.");
        }
      }
    } else {
      checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.identifier), stopAssignmentSet);

      // semantic analysis.
      if (identifiers.getId(lexeme.idVal) == null)
        error(cuc.lexemeReader, 9); // variable not declared.
    }

    update(cuc, stopSet);

    debug("\nstatementExpression: end");
    return variable;
  } // statementExpression()

  // update = identifier++ | identifier-- | identifier "=" expression
  private void update(CompilationUnitContext cuc, EnumSet<LexemeType> stopSet) throws FatalError, SyntaxError {
    debug("\nupdate: start with stopSet = " + stopSet);

    EnumSet<LexemeType> stopAssignmentSet = stopSet.clone();
    stopAssignmentSet.addAll(START_EXPRESSION);
    stopAssignmentSet.add(LexemeType.semicolon);

    // semantic analysis.
    Variable var = identifiers.getId(lexeme.idVal);
    Operand leftOperand = new Operand(var.getIdentifierType(), var.getDataType(), var.getAddress());
    leftOperand.isFinal = var.isFinal();
    debug("\nupdate: leftOperand = " + leftOperand);

    // lexical analysis.
    lexeme = cuc.lexemeReader.getLexeme(sourceCode);
    if (lexeme.type == LexemeType.increment) {
      // identifier++
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);

      // code generation.
      if (var.getDataType() == DataType.word) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.increment16, leftOperand));
      } else if (var.getDataType() == DataType.byt) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.increment8, leftOperand));
      } else {
        throw new FatalError("internal compiler error during code generation.");
      }
    } else if (lexeme.type == LexemeType.decrement) {
      // identifier--
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);

      // code generation.
      if (var.getDataType() == DataType.word) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.decrement16, leftOperand));
      } else if (var.getDataType() == DataType.byt) {
        plant(cuc.lexemeReader, new Instruction(FunctionType.decrement8, leftOperand));
      } else {
        throw new FatalError("internal compiler error during code generation.");
      }
    } else if (checkOrSkip(cuc.lexemeReader, EnumSet.of(LexemeType.assign), stopAssignmentSet)) {
      // identifier "=" expression
      lexeme = cuc.lexemeReader.getLexeme(sourceCode);
      Operand rightOperand = expression(cuc, stopSet);

      // code generation.
      if (var.isFinal()) {
        // no assignment but constant definition.
        if (var.getDataType() != rightOperand.dataType) {
          error(cuc.lexemeReader, 14);
        } else if (rightOperand.opType == OperandType.CONSTANT) {
          var.setIntValue(rightOperand.intValue);
          debug("\nupdate: final var [" + var.getFullyQualifiedName() + "] = " + var.getIntValue());
        } else {
          error(cuc.lexemeReader, 17);
        }
      } else {
        generateAssignment(cuc.lexemeReader, leftOperand, rightOperand);
      }
    }

    debug("\nupdate: end");
  } // update()

  /*****************************
   *
   * Code generation methods
   *
   ****************************/

  /**
   * Generate M-code for a return statement.
   */
  private void generateReturnStatement(LexemeReader lexemeReader) {
    // code generation

    // do nothing, except logging processed source code lines, if previously
    // generated statement is a return statement.
    if (instructions.get(instructions.size() - 2).function == FunctionType.returnFunction) {
      plantSource();
    } else {
      // release space on stack for local variables.
      plantCode(lexemeReader, new Instruction(FunctionType.stackPointerLoad, new Operand(OperandType.BASE_POINTER)));
      // reset base pointer and return to caller
      plantCode(lexemeReader, new Instruction(FunctionType.unstackBasePointer));
      plantThenSource(lexemeReader, new Instruction(FunctionType.returnFunction));
    }
  } // generateReturnStatement

  /**
   * Generate M-code for an assignment.
   * 
   * @param leftOperand
   * @param rightOperand
   * @throws FatalError
   */
  private void generateAssignment(LexemeReader lexemeReader, Operand leftOperand, Operand rightOperand) throws FatalError {
    // code generation.
    debug("\ngenerateAssignment: leftOperand = " + leftOperand + ", operand = " + rightOperand);
    // operand to accu.
    if (rightOperand.opType != OperandType.ACC) {
      plantAccLoad(lexemeReader, rightOperand);
    }
    // actual assignment.
    if (rightOperand.dataType == DataType.word || rightOperand.dataType == DataType.string) {
      plant(lexemeReader, new Instruction(FunctionType.acc16Store, leftOperand));
    } else if (rightOperand.dataType == DataType.byt) {
      plant(lexemeReader, new Instruction(FunctionType.acc8Store, leftOperand));
    } else {
      throw new FatalError("internal compiler error during code generation.");
    }
  } // generateAssignment

  /**
   * Generate M-code for a stack based argument in a method invocation.
   * 
   * @param argument
   * @throws FatalError
   * @returns number of bytes needed on the stack for the argument.
   */
  private int generateArgument(LexemeReader lexemeReader, Operand argument) throws FatalError {
    // code generation.
    debug("\ngenerateArgument: argument = " + argument);
    int stackSize = 0;

    // operand to accu.
    if (argument.opType != OperandType.ACC) {
      plantAccLoad(lexemeReader, argument);
    }

    // put accu on the stack.
    if (acc16.inUse()) {
      plant(lexemeReader, new Instruction(FunctionType.stackAcc16));
      stackSize = 2;
    } else if (acc8.inUse()) {
      plant(lexemeReader, new Instruction(FunctionType.stackAcc8));
      stackSize = 1;
    } else {
      throw new FatalError("internal compiler error during code generation.");
    }
    return stackSize;
  } // generateArgument

  private void plant(LexemeReader lexemeReader, Instruction instruction) {
    // for debugging purposes.
    debug("\n->plant (acc8InUse=" + acc8.inUse() + ", acc16InUse=" + acc16.inUse() + ", lastSourceLineNr=" + lastSourceLineNr
        + ", sourceLineNr=" + lexeme.sourceLineNr + ", linesOfSourceCode=" + sourceCode.size() + "):");
    plantSource();
    plantCode(lexemeReader, instruction);
  } // plant

  private void plantThenSource(LexemeReader lexemeReader, Instruction instruction) {
    // for debugging purposes.
    debug("\n->plantThenSource (acc8InUse=" + acc8.inUse() + ", acc16InUse=" + acc16.inUse() + ", lastSourceLineNr="
        + lastSourceLineNr + ", sourceLineNr=" + lexeme.sourceLineNr + ", linesOfSourceCode=" + sourceCode.size() + "):");

    plantCode(lexemeReader, instruction);
    plantSource();
  } // plantThenSource

  private void plantSource() {
    for (String line : sourceCode) {
      if (debugMode) {
        debug("\n" + String.format(LINE_NR_FORMAT, instructions.size()) + FunctionType.comment.getValue() + line);
      }
      instructions.add(new Instruction(FunctionType.comment, new Operand(OperandType.CONSTANT, DataType.string, line)));
    }
    sourceCode.clear();
  } // plantSource

  private void plantCode(LexemeReader lexemeReader, Instruction instruction) {
    /*
     * clear memory if number of M-code (virtual machine codes) exceeds memory
     * size.
     */
    if (instructions.size() >= MAX_M_CODE) {
      error(lexemeReader, 10);
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
      stackedDatatypes.push(DataType.word);
      acc16.operand().opType = OperandType.STACK16;
    } else if (instruction.function == FunctionType.stackAcc8Load) {
      stackedDatatypes.push(DataType.byt);
      acc8.operand().opType = OperandType.STACK8;
    } else if (instruction.function == FunctionType.stackAcc16ToAcc8) {
      stackedDatatypes.push(DataType.byt);
      acc8.operand().opType = OperandType.STACK8;
      acc16.clear();
    } else if (instruction.function == FunctionType.stackAcc8ToAcc16) {
      stackedDatatypes.push(DataType.word);
      acc16.operand().opType = OperandType.STACK16;
      acc8.clear();
    } else if (instruction.function == FunctionType.stackAcc16) {
      stackedDatatypes.push(DataType.word);
      acc16.operand().opType = OperandType.STACK16;
      acc16.clear();
    } else if (instruction.function == FunctionType.stackAcc8) {
      stackedDatatypes.push(DataType.byt);
      acc8.operand().opType = OperandType.STACK8;
      acc8.clear();
    }

    // update stack metadata.
    if (instruction.function == FunctionType.unstackAcc8) {
      popStackedDatatype(DataType.byt);
    } else if (instruction.function == FunctionType.unstackAcc16) {
      popStackedDatatype(DataType.word);
    } else if (instruction.operand != null && instruction.operand.opType == OperandType.STACK8) {
      popStackedDatatype(DataType.byt);
    } else if (instruction.operand != null && instruction.operand.opType == OperandType.STACK16) {
      popStackedDatatype(DataType.word);
    }

    // for debugging purposes.
    debug(" ;" + " stackedDatatypes=" + stackedDatatypes);
  } // plantCode

  private boolean plantComparisonCode(LexemeReader lexemeReader, Operand leftOperand, Operand rightOperand) {
    debug("\nplantComparisonCode: leftOperand=" + leftOperand + ", rightOperand=" + rightOperand + ", acc16InUse = " + acc16.inUse()
        + ", acc8InUse = " + acc8.inUse());
    /*
     * Possible operand types: leftOperand: constant, acc, var, stack16, stack8;
     * NB: var is loaded into acc and acc is pushed onto stack prior to
     * evaluating right hand expression into rightOperand. rightOperand:
     * constant, acc, var, stack16, stack8
     */

    boolean reverseCompare = false;
    // plant(lexemeReader, new Instruction(FunctionType.acc16Compare,
    // rightOperand));
    if ((leftOperand.opType == OperandType.CONSTANT) && (rightOperand.opType == OperandType.CONSTANT)) {
      plantAccLoad(lexemeReader, leftOperand);
      if (leftOperand.dataType == DataType.word && rightOperand.dataType == DataType.word) {
        plant(lexemeReader, new Instruction(FunctionType.acc16Compare, rightOperand));
      } else if (leftOperand.dataType == DataType.word && rightOperand.dataType == DataType.byt) {
        plantAccLoad(lexemeReader, rightOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.dataType == DataType.byt && rightOperand.dataType == DataType.word) {
        plantAccLoad(lexemeReader, rightOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc8CompareAcc16));
      } else if (leftOperand.dataType == DataType.byt && rightOperand.dataType == DataType.byt) {
        plant(lexemeReader, new Instruction(FunctionType.acc8Compare, rightOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.CONSTANT) && (rightOperand.opType == OperandType.ACC)) {
      if (leftOperand.dataType == DataType.word && rightOperand.dataType == DataType.word) {
        reverseCompare = true;
        plant(lexemeReader, new Instruction(FunctionType.revAcc16Compare, leftOperand));
      } else if (leftOperand.dataType == DataType.word && rightOperand.dataType == DataType.byt) {
        plantAccLoad(lexemeReader, leftOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.dataType == DataType.byt && rightOperand.dataType == DataType.word) {
        plantAccLoad(lexemeReader, leftOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc8CompareAcc16));
      } else if (leftOperand.dataType == DataType.byt && rightOperand.dataType == DataType.byt) {
        reverseCompare = true;
        plant(lexemeReader, new Instruction(FunctionType.revAcc8Compare, leftOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.CONSTANT)
        && (rightOperand.opType == OperandType.GLOBAL_VAR || rightOperand.opType == OperandType.LOCAL_VAR)) {
      plantAccLoad(lexemeReader, rightOperand);
      if (leftOperand.dataType == DataType.word && rightOperand.dataType == DataType.word) {
        reverseCompare = true;
        plant(lexemeReader, new Instruction(FunctionType.revAcc16Compare, leftOperand));
      } else if (leftOperand.dataType == DataType.word && rightOperand.dataType == DataType.byt) {
        plantAccLoad(lexemeReader, leftOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.dataType == DataType.byt && rightOperand.dataType == DataType.word) {
        plantAccLoad(lexemeReader, leftOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc8CompareAcc16));
      } else if (leftOperand.dataType == DataType.byt && rightOperand.dataType == DataType.byt) {
        reverseCompare = true;
        plant(lexemeReader, new Instruction(FunctionType.revAcc8Compare, leftOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
      /*
       * } else if ((leftOperand.opType == OperandType.constant) &&
       * (rightOperand.opType == OperandType.stack8)) { if (leftOperand.dataType
       * == DataType.byt) { plant(new Instruction(FunctionType.unstackAcc8));
       * plant(new Instruction(FunctionType.acc8Compare, leftOperand)); } else {
       * throw new RuntimeException("Internal compiler error: abort."); }
       */
    } else if ((leftOperand.opType == OperandType.GLOBAL_VAR || leftOperand.opType == OperandType.LOCAL_VAR)
        && (rightOperand.opType == OperandType.CONSTANT)) {
      plantAccLoad(lexemeReader, leftOperand);
      if (leftOperand.dataType == DataType.word && rightOperand.dataType == DataType.word) {
        plant(lexemeReader, new Instruction(FunctionType.acc16Compare, rightOperand));
      } else if (leftOperand.dataType == DataType.word && rightOperand.dataType == DataType.byt) {
        plantAccLoad(lexemeReader, rightOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.dataType == DataType.byt && rightOperand.dataType == DataType.word) {
        plantAccLoad(lexemeReader, rightOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc8CompareAcc16));
      } else if (leftOperand.dataType == DataType.byt && rightOperand.dataType == DataType.byt) {
        plant(lexemeReader, new Instruction(FunctionType.acc8Compare, rightOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.GLOBAL_VAR || leftOperand.opType == OperandType.LOCAL_VAR)
        && (rightOperand.opType == OperandType.ACC)) {
      if (leftOperand.dataType == DataType.word && rightOperand.dataType == DataType.word) {
        reverseCompare = true;
        plant(lexemeReader, new Instruction(FunctionType.revAcc16Compare, leftOperand));
      } else if (leftOperand.dataType == DataType.word && rightOperand.dataType == DataType.byt) {
        plantAccLoad(lexemeReader, leftOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.dataType == DataType.byt && rightOperand.dataType == DataType.word) {
        plantAccLoad(lexemeReader, leftOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc8CompareAcc16));
      } else if (leftOperand.dataType == DataType.byt && rightOperand.dataType == DataType.byt) {
        reverseCompare = true;
        plant(lexemeReader, new Instruction(FunctionType.revAcc8Compare, leftOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.GLOBAL_VAR || leftOperand.opType == OperandType.LOCAL_VAR)
        && (rightOperand.opType == OperandType.GLOBAL_VAR || rightOperand.opType == OperandType.LOCAL_VAR)) {
      plantAccLoad(lexemeReader, leftOperand);
      if (leftOperand.dataType == DataType.word && rightOperand.dataType == DataType.word) {
        plant(lexemeReader, new Instruction(FunctionType.acc16Compare, rightOperand));
      } else if (leftOperand.dataType == DataType.word && rightOperand.dataType == DataType.byt) {
        plantAccLoad(lexemeReader, rightOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.dataType == DataType.byt && rightOperand.dataType == DataType.word) {
        plantAccLoad(lexemeReader, rightOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc8CompareAcc16));
      } else if (leftOperand.dataType == DataType.byt && rightOperand.dataType == DataType.byt) {
        plant(lexemeReader, new Instruction(FunctionType.acc8Compare, rightOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.STACK16) && (rightOperand.opType == OperandType.CONSTANT)) {
      if (rightOperand.dataType == DataType.word) {
        plant(lexemeReader, new Instruction(FunctionType.unstackAcc16));
        plant(lexemeReader, new Instruction(FunctionType.acc16Compare, rightOperand));
      } else if (rightOperand.dataType == DataType.byt) {
        plant(lexemeReader, new Instruction(FunctionType.unstackAcc16));
        plantAccLoad(lexemeReader, rightOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc16CompareAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.STACK16) && (rightOperand.opType == OperandType.ACC)) {
      if (rightOperand.dataType == DataType.word) {
        reverseCompare = true;
        plant(lexemeReader, new Instruction(FunctionType.revAcc16Compare, leftOperand));
      } else if (rightOperand.dataType == DataType.byt) {
        plant(lexemeReader, new Instruction(FunctionType.unstackAcc16));
        plant(lexemeReader, new Instruction(FunctionType.acc16CompareAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.STACK16)
        && (rightOperand.opType == OperandType.GLOBAL_VAR || rightOperand.opType == OperandType.LOCAL_VAR)) {
      if (rightOperand.dataType == DataType.word) {
        plant(lexemeReader, new Instruction(FunctionType.unstackAcc16));
        plant(lexemeReader, new Instruction(FunctionType.acc16Compare, rightOperand));
      } else if (rightOperand.dataType == DataType.byt) {
        plant(lexemeReader, new Instruction(FunctionType.unstackAcc16));
        plantAccLoad(lexemeReader, rightOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc16CompareAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.STACK8) && (rightOperand.opType == OperandType.CONSTANT)) {
      if (rightOperand.dataType == DataType.word) {
        plant(lexemeReader, new Instruction(FunctionType.unstackAcc8));
        plantAccLoad(lexemeReader, rightOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc8CompareAcc16));
      } else if (rightOperand.dataType == DataType.byt) {
        plant(lexemeReader, new Instruction(FunctionType.unstackAcc8));
        plant(lexemeReader, new Instruction(FunctionType.acc8Compare, rightOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.STACK8) && (rightOperand.opType == OperandType.ACC)) {
      if (rightOperand.dataType == DataType.word) {
        plant(lexemeReader, new Instruction(FunctionType.unstackAcc8));
        plant(lexemeReader, new Instruction(FunctionType.acc8CompareAcc16));
      } else if (rightOperand.dataType == DataType.byt) {
        reverseCompare = true;
        plant(lexemeReader, new Instruction(FunctionType.revAcc8Compare, leftOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.STACK8)
        && (rightOperand.opType == OperandType.GLOBAL_VAR || rightOperand.opType == OperandType.LOCAL_VAR)) {
      if (rightOperand.dataType == DataType.word) {
        plant(lexemeReader, new Instruction(FunctionType.unstackAcc8));
        plantAccLoad(lexemeReader, rightOperand);
        plant(lexemeReader, new Instruction(FunctionType.acc8CompareAcc16));
      } else if (rightOperand.dataType == DataType.byt) {
        plant(lexemeReader, new Instruction(FunctionType.unstackAcc8));
        plant(lexemeReader, new Instruction(FunctionType.acc8Compare, rightOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else {
      throw new RuntimeException("Internal compiler error: abort.");
    }
    debug("\nplantComparisonCode: end");
    return reverseCompare;
  } // plantComparisonCode()

  private void plantAccLoad(LexemeReader lexemeReader, Operand operand) {
    // load acc with operand.
    if (operand.dataType == DataType.word) {
      if (operand.opType != OperandType.STACK16) {
        if (acc16.inUse()) {
          plant(lexemeReader, new Instruction(FunctionType.stackAcc16Load, operand));
        } else {
          plant(lexemeReader, new Instruction(FunctionType.acc16Load, operand));
        }
        operand.opType = OperandType.ACC;
        acc16.setOperand(operand);
      }
    } else if (operand.dataType == DataType.byt) {
      if (operand.opType != OperandType.STACK8) {
        if (acc8.inUse()) {
          plant(lexemeReader, new Instruction(FunctionType.stackAcc8Load, operand));
        } else {
          plant(lexemeReader, new Instruction(FunctionType.acc8Load, operand));
        }
        operand.opType = OperandType.ACC;
        acc8.setOperand(operand);
      }
    } else if (operand.dataType == DataType.string) {
      if (acc16.inUse()) {
        throw new RuntimeException("Compiler error; acc16 is in use unexpectedly.");
      }
      plant(lexemeReader, new Instruction(FunctionType.acc16Load, operand));
    } else {
      throw new RuntimeException("Unsupported operand " + operand);
    }
  }

  private void plantPrintln(LexemeReader lexemeReader, Operand operand, boolean withCarriageReturn) {
    // code generation.
    if (operand.opType != OperandType.ACC) {
      plantAccLoad(lexemeReader, operand);
    }
    switch (operand.dataType) {
      case word:
        plant(lexemeReader, new Instruction(withCarriageReturn ? FunctionType.writeLineAcc16 : FunctionType.writeAcc16));
        break;
      case byt:
        plant(lexemeReader, new Instruction(withCarriageReturn ? FunctionType.writeLineAcc8 : FunctionType.writeAcc8));
        break;
      case string:
        plant(lexemeReader, new Instruction(withCarriageReturn ? FunctionType.writeLineString : FunctionType.writeString));
        break;
      default:
        error(lexemeReader, 15);
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

  private void popStackedDatatype(DataType expectedDataType) {
    DataType dataType = stackedDatatypes.pop();
    if (!(dataType == DataType.byt || dataType == DataType.word)) {
      debug("\npopStackedDatatype: unsupported data type popped from stack: " + dataType);
      throw new RuntimeException("Internal compiler error: abort.");
    }

    if (dataType != expectedDataType) {
      debug("\npopStackedDatatype: unexpected data type popped from stack: popped " + dataType + "; expected " + expectedDataType);
      throw new RuntimeException("Internal compiler error: abort.");
    }
  } // popStackedDatatype()

  private void plantStringConstants() {
    for (int id = 0; id < stringConstants.size(); id++) {
      // plant string constant.
      Operand operand = new Operand(OperandType.CONSTANT, DataType.string, stringConstants.get(id));
      operand.intValue = id;
      instructions.add(new Instruction(FunctionType.stringConstant, operand));
    }
  } // plantStringConstants

  private void setScopeSize(int claimStackSpaceAddress, int scopeSize) {
    Instruction instruction = instructions.get(claimStackSpaceAddress);
    instruction.operand.intValue = scopeSize;
  } // setScopeSize

  private String getFullyQualifiedName(CompilationUnitContext cuc, String name) {
    String result = "";
    if (cuc.packageName.length() > 0) {
      result += cuc.packageName;
    }
    if (cuc.className.length() > 0) {
      result += (result.length() > 0) ? "." : "";
      result += cuc.className;
    }
    if (name.length() > 0) {
      result += (result.length() > 0) ? "." : "";
      result += name;
    }
    return result;
  } // getFullyQualifiedName

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
  } // findSymbol

  private void updateReferencesToMethods(LexemeReader lexemeReader) {
    methodReferences.forEach((fullyQualifiedName, references) -> {
      int address = findSymbol(fullyQualifiedName);
      if (address == 0) {
        error(lexemeReader, 38, fullyQualifiedName);
      } else {
        // update references to label <name>.
        for (Integer reference : references) {
          Instruction instruction = instructions.get(reference);
          if (instruction.function != FunctionType.call && instruction.function != FunctionType.br) {
            throw new RuntimeException(
                String.format("One of the instructions to symbol %s is neither a call nor a branch function", fullyQualifiedName));
          } else if (instruction.operand == null) {
            throw new RuntimeException(
                String.format("One of the instructions to symbol %s does not have an operand", fullyQualifiedName));
          } else if (instruction.operand.opType != OperandType.LABEL) {
            throw new RuntimeException(
                String.format("One of the instructions to symbol %s does not have a label operand", fullyQualifiedName));
          } else if (instruction.operand.intValue == 0) {
            instruction.operand.intValue = address;
            // } else if (instruction.operand.intValue != address) {
            // throw new RuntimeException(String.format(
            // "One of the instructions to symbol %s already has %d as address
            // which is different from expected value %d",
            // fullyQualifiedName, instruction.operand.intValue, address));
          }
        }
      }
    });
  } // updateReferencesToMethods

  private void updateReferencesToStringConstants(int offset) {
    Map<Integer, ArrayList<Integer>> stringReferences = new HashMap<Integer, ArrayList<Integer>>();
    int lineNumber = 0;
    for (Instruction instruction : instructions) {
      lineNumber++;
      if (STRING_CONSTANT_FUNCTIONS.contains(instruction.function) && instruction.operand != null
          && instruction.operand.opType == OperandType.CONSTANT && instruction.operand.dataType == DataType.string) {

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
    instructions.forEach((instruction) -> updateBranchInstruction(instruction, pos, number));
  } // relocate

  private Object updateBranchInstruction(Instruction instruction, int pos, int number) {
    if (BRANCH_FUNCTIONS.contains(instruction.function) && (instruction.operand.intValue > pos)) {
      instruction.operand.intValue -= number;
    }
    return instruction;
  }

}
