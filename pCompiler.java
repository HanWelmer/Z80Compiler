import java.util.ArrayList;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

//TODO Add built-in function: output(port, value). See ledtest.j.
//TODO Add 'constant' qualifier. See ledtest.j.
//TODO Generate constant in Z80 code in hex notation if the constant was written in hex notation in J-code. See ledtest.j.
//TODO Add logical AND.
//TODO Add logical OR.
//TODO Add logical NOT.
//TODO Add logical XOR.
//TODO Add function (parameter less; no global/local variables).
//TODO Add glocal variable to function.
//TODO Add local variable to function.
//TODO Add local parameter to function.
//TODO Add import
//TODO Introduce built in function malloc() (see test1, test5, test10, test11).
//TODO Refactor StringConstants.
//TODO Fix runtime error: too many variables

/**
 * Compiler for the miniJava programming language.
 * Inspired by the book Compiler Engineering Using Pascal by P.C. Capon and P.J. Jinks
 * and of course Java as developed by Sun.
 *
 * program          = "class" identifier "{" statements "}".
 * identifier       = "(_A-Za-z)(_A-Za-z0-9)+".
 * statements       = (statement)*.
 * statement        = assignment | printlnStatement | ifStatement | forStatement | doStatement | whileStatement.
 * assignment       = [datatype] update ";".
 * datatype         = "byte" | "word" | "String".
 * update           = identifier++ | identifier-- | identifier "=" expression.
 * printlnStatement = "println" "(" expression ")" ";".
 * ifStatement      = "if" "(" comparison ")" block [ "else" block].
 * forStatement     = "for" "(" initialization ";" comparison ";" update ")" block.
 * initialization   = "word" identifier "=" expression.
 * doStatement      = "do" block "while" "(" comparison ")" ";".
 * whileStatement   = "while" "(" comparison ")" block.
 * block            = statement | "{" statements "}".
 * comparison       = expression relop expression.
 * expression       = term {addop term}.
 * term             = factor {mulop factor}.
 * factor           = identifier | constant | stringConstant | "read" | "(" expression ")".
 * addop            = "+" | "-".
 * mulop            = "*" | "/".
 * relop            = "==" | "!=" | ">" | ">=" | "<" | "<=".
 * constant         = decimalConstant | hexadecimalConstant.
 * decimalConstant  = "(0-9)*".
 * hexadecimalConstant = "(0-9)x(A-F0-()*".
 * stringConstant   = "\"" ((char - ["\"\\"]) | ("\\" ["\\\'\"nrtbfa"]))* "\"".
 *
 * Java style end of line comment.
 * Java style multi-line comment.
 * Multi-line comment may contain end of line comment.
 * Multi-line comment may not be nested.
 * A variable must be declared before it is used.
 * A declaration is valid within the scope within which it is defined (class, for statement, statement block) and it's sub-scopes.
 * The name of a valid declaration may only be declared once within its scope (overloading is not supported).
 * A variable declaration must include the datatype.
 * A variable of type byte takes one byte (8 bit).
 * A variable of type word takes two bytes (16 bit).
 * A variable of type byte has a range from 0 to 255.
 * A variable of type word has a range from 0 to 65535.
 * An expression is initially evaluated in the type of the first (left most) factor.
 * A constant has a type byte if the value is between 0 and 255.
 * A byte expression is promoted to a word expression if a right-hand factor requires so.
 * The read() function returns a word value.
 * In an addop, mulop or relop the type of the lefthand operand and the right hand operand must be the same.
 * The value of the lefthand operand of an addop, mulop or relop is changed from byte to word if the type of the righthand operand is a word.
 * In an assignment the value of a byte expression can be assigned to a word variable.
 * In an assignment the value of a word expression assigned to a byte variable will be truncated.
 * A string constant is enclosed between double quotes.
 * A string constant consists of a sequence of characters and/or escape sequences.
 * All ASCII printable characters are allowed, except \ (backslash) and " (double quote).
 * In a string constant the \ symbol is the escape token. Supported characters in escape sequences are:
 * - \\ backslash
 * - \' single quote
 * - \" double quote
 * - \n new line
 * - \r carriage return
 * - \t horizontal tab
 * - \b backspace
 * - \f form feed/new page
 * - \a alert/bell
 * The println statement makes a distinction between a string expression and an algorithmic expression.
 * An expression is a string expression if the leftmost operand is a string constant or the identifier of a string variable, otherwise it is an algorithmic expression.
 * In a println statement with a string expression, the subsequent operands may be added; other operators are not allowed.
 * However, subexpressions (expression between left ( and right ) parenthesis, may be string expressions or algorithmic expressions.
 * Operands in a string expression, including results of subexpressions, are converted to string and then printed.
 */
public class pCompiler {
  /* global variables used by the constructor or the interface functions */
  private static boolean debugMode;
  private static boolean verboseMode;
  private static String fileName;
  private static LexemeReader lexemeReader;
  private ArrayList<Instruction> instructions = new ArrayList<Instruction>();

  //constructor
  public pCompiler(boolean debugMode, boolean verboseMode) {
    this.debugMode = debugMode;
    this.verboseMode = verboseMode;
  }
  
  /* Class member methods for lexical analysis phase */
  public ArrayList<Instruction> compile(String fileName, LexemeReader lexemeReader) {
    this.fileName = fileName;
    this.lexemeReader = lexemeReader;
    if (verboseMode) System.out.println("compiling " + fileName + " in debugMode = " + debugMode);

    try {
      init();
      prog();
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
    if (verboseMode || (errors != 0) ) {
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
   * variable containing the branch instructions known by the M machine as generated by the P language.
   * variable used during the code generation phase.
   */
  public EnumSet<FunctionType> brFunctions = EnumSet.of(
    FunctionType.br
    , FunctionType.brEq
    , FunctionType.brNe
    , FunctionType.brLt
    , FunctionType.brLe
    , FunctionType.brGt
    , FunctionType.brGe
    );

  /* Constants and class member variables for lexical analysis phase */
  private ArrayList<String> sourceCode;
  private int lastSourceLineNr = 0;
  private Lexeme lexeme;
  private int errors;

  /* Constants and class member variables for syntax analysis phase */
  private EnumSet<LexemeType> startStatement = EnumSet.of(
      LexemeType.identifier
    , LexemeType.bytelexeme
    , LexemeType.wordlexeme
    , LexemeType.stringlexeme
    , LexemeType.printlnlexeme
    , LexemeType.iflexeme
    , LexemeType.forlexeme
    , LexemeType.dolexeme
    , LexemeType.whilelexeme
  );
  private EnumSet<LexemeType> startAssignment = EnumSet.of(
      LexemeType.identifier
    , LexemeType.bytelexeme
    , LexemeType.wordlexeme
    , LexemeType.stringlexeme
  );
  private EnumSet<LexemeType> startExp = EnumSet.of(
      LexemeType.lbracket
    , LexemeType.identifier
    , LexemeType.constant
    , LexemeType.stringConstant
    , LexemeType.readlexeme
  );

  /* Constants and class member variables for semantic analysis phase */
  private Identifiers identifiers = new Identifiers();
  private StringConstants stringConstants = new StringConstants();
 
  /* Constants and class member variables for code generation phase */
  private static final String LINE_NR_FORMAT = "%4d ";
  private static final int NULL_OP = 0;
  private static final int MAX_M_CODE = 10000;
  private Accumulator acc16 = new Accumulator();
  private Accumulator acc8 = new Accumulator();
  private Stack<Datatype> stackedDatatypes = new Stack<Datatype>();

  private Map<AddValType, FunctionType> forwardAdd16 = new HashMap<AddValType, FunctionType>();
  private Map<AddValType, FunctionType> reverseAdd16 = new HashMap<AddValType, FunctionType>();
  private Map<MulValType, FunctionType> forwardMul16 = new HashMap<MulValType, FunctionType>();
  private Map<MulValType, FunctionType> reverseMul16 = new HashMap<MulValType, FunctionType>();

  private Map<AddValType, FunctionType> forwardAdd8 = new HashMap<AddValType, FunctionType>();
  private Map<AddValType, FunctionType> reverseAdd8 = new HashMap<AddValType, FunctionType>();
  private Map<MulValType, FunctionType> forwardMul8 = new HashMap<MulValType, FunctionType>();
  private Map<MulValType, FunctionType> reverseMul8 = new HashMap<MulValType, FunctionType>();

  private Map<RelValType, FunctionType> normalSkip = new HashMap<RelValType, FunctionType>();
  private Map<RelValType, FunctionType> reverseSkip = new HashMap<RelValType, FunctionType>();

  /* Class member methods for all phases */
  private void init() {
    /* initialisation of lexical analysis variables */
    sourceCode = new ArrayList<String>();
    lastSourceLineNr = 0;
    errors = 0;
    lexeme = new Lexeme(LexemeType.unknown);

    /* initialisation of syntax analysis variables */

    /* initialisation of semantic analysis variables */
    identifiers.init();
    stringConstants.init();

    /* initialisation of code generation variables */
    acc16.clear();
    acc8.clear();
    stackedDatatypes.clear();

    forwardAdd16.clear();
    reverseAdd16.clear();
    forwardMul16.clear();
    reverseMul16.clear();

    forwardAdd8.clear();
    reverseAdd8.clear();
    forwardMul8.clear();
    reverseMul8.clear();

    normalSkip.clear();
    reverseSkip.clear();
    instructions.clear();

    forwardAdd16.put(AddValType.add, FunctionType.acc16Plus);
    forwardAdd16.put(AddValType.sub, FunctionType.acc16Minus);
    reverseAdd16.put(AddValType.add, FunctionType.acc16Plus);
    reverseAdd16.put(AddValType.sub, FunctionType.minusAcc16);

    forwardAdd8.put(AddValType.add, FunctionType.acc8Plus);
    forwardAdd8.put(AddValType.sub, FunctionType.acc8Minus);
    reverseAdd8.put(AddValType.add, FunctionType.acc8Plus);
    reverseAdd8.put(AddValType.sub, FunctionType.minusAcc8);

    forwardMul16.put(MulValType.mul, FunctionType.acc16Times);
    forwardMul16.put(MulValType.div, FunctionType.acc16Div);
    reverseMul16.put(MulValType.mul, FunctionType.acc16Times);
    reverseMul16.put(MulValType.div, FunctionType.divAcc16);

    forwardMul8.put(MulValType.mul, FunctionType.acc8Times);
    forwardMul8.put(MulValType.div, FunctionType.acc8Div);
    reverseMul8.put(MulValType.mul, FunctionType.acc8Times);
    reverseMul8.put(MulValType.div, FunctionType.divAcc8);

    normalSkip.put(RelValType.eq, FunctionType.brNe);
    normalSkip.put(RelValType.ne, FunctionType.brEq);
    normalSkip.put(RelValType.gt, FunctionType.brLe);
    normalSkip.put(RelValType.lt, FunctionType.brGe);
    normalSkip.put(RelValType.ge, FunctionType.brLt);
    normalSkip.put(RelValType.le, FunctionType.brGt);
    reverseSkip.put(RelValType.eq, FunctionType.brNe);
    reverseSkip.put(RelValType.ne, FunctionType.brEq);
    reverseSkip.put(RelValType.gt, FunctionType.brGe);
    reverseSkip.put(RelValType.lt, FunctionType.brLe);
    reverseSkip.put(RelValType.ge, FunctionType.brGt);
    reverseSkip.put(RelValType.le, FunctionType.brLt);
  }
  
  private void error() {
    errors++;
    lexemeReader.error();
  }
  
  private void error(int n) {
    error();
    switch (n) {
      case 0 : System.out.println("error opening file " + fileName);break;
      case 1 : System.out.println("end of input encountered");break;
      case 2 : System.out.println("line too long");break;
      case 3 : System.out.print("unexpected symbol;");break;
      case 4 : System.out.println("unknown character");break;
      case 5 : System.out.println("'=' expected after '=' or '!' ");break;
      case 6 : System.out.print("unknown keyword : ");break;
      case 7 : System.out.println("lexeme skipped after error");break;
      case 8 : System.out.println("variable already declared");break;
      case 9 : System.out.println("variable not declared");break;
      case 10 : System.out.println("code overflow");break;
      case 11 : System.out.println("lexemetype is null");break;
      case 12 : System.out.println("internal compiler error during code generation");break;
      case 13 : System.out.println("constant too big"); break;
      case 14 : System.out.println("incompatible datatype between assignment variable and expression"); break;
      case 15 : System.out.println("incompatible datatype in println statement"); break;
    }
  }
  
  /*Class member methods for syntax analysis phase */
  private boolean checkOrSkip(EnumSet<LexemeType> okSet, EnumSet<LexemeType> stopSet) throws FatalError {
    //debug("\ncheckOrSkip: start");
    boolean result = false;
    if (okSet.contains(lexeme.type)) {
      //debug("\ncheckOrSkip: lexeme \"" + lexeme.type + "\" in okSet " + okSet);
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
    //debug("\ncheckOrSkip: end");
    return result;
  }
  
  //factor = identifier | constant | stringConstant | "read" | "(" expression ")".
  private Operand factor(EnumSet<LexemeType> stopSet) throws FatalError {
    Operand operand = new Operand(OperandType.unknown);
    debug("\nfactor 1: acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    if (checkOrSkip(startExp, stopSet)) {
      if (lexeme.type == LexemeType.identifier) {
        /* part of semantic analysis */
        if (!identifiers.checkId(lexeme.idVal)) error(9); /* variable not declared */
        /* part of code generation */
        Variable var = identifiers.getId(lexeme.idVal);
        operand.opType = OperandType.var;
        operand.datatype = var.getDatatype();
        operand.intValue = var.getAddress();
        /* part of lexical analysis */
        lexeme = lexemeReader.getLexeme(sourceCode);
      } else if (lexeme.type == LexemeType.constant) {
        /* part of code generation */
        operand.opType = OperandType.constant;
        operand.datatype = lexeme.datatype;
        operand.intValue = lexeme.constVal;
        /* part of lexical analysis */
        lexeme = lexemeReader.getLexeme(sourceCode);
      } else if (lexeme.type == LexemeType.stringConstant) {
        debug("\nlexeme = " + lexeme.makeString(null));
        /* part of semantic analysis */
        int constantId = stringConstants.add(lexeme.stringVal, instructions.size() + 1);
        debug("\nfactor: string constant " + constantId + " = \"" + lexeme.stringVal + "\"");
        /* part of code generation */
        operand.opType = OperandType.constant;
        operand.datatype = Datatype.string;
        operand.strValue = lexeme.stringVal;
        operand.intValue = constantId;
        /* part of lexical analysis */
        lexeme = lexemeReader.getLexeme(sourceCode);
        debug("\nlexeme = " + lexeme.makeString(null));
      } else if (lexeme.type == LexemeType.readlexeme) {
        lexeme = lexemeReader.getLexeme(sourceCode);
        /* 
         * Part of code generation.
         * The read() function always returns a word value.
         */
        if (acc16.inUse()) {
          plant(new Instruction(FunctionType.stackAcc16));
        }
        plant(new Instruction(FunctionType.read));
        operand.opType = OperandType.acc;
        operand.datatype = Datatype.word;
        acc16.setOperand(operand);
      } else if (lexeme.type == LexemeType.lbracket) {
        //skip left bracket.
        lexeme = lexemeReader.getLexeme(sourceCode);
        EnumSet<LexemeType> stopSetCopy = stopSet.clone();
        stopSetCopy.add(LexemeType.rbracket);
        operand = expression(stopSetCopy);
        //skip right bracket.
        if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopSet)) {
          lexeme = lexemeReader.getLexeme(sourceCode);
        }
      }
    }

    //consistency check.
    debug("\nfactor: end: " + operand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    if (operand.opType == OperandType.unknown) {
      throw new FatalError(12);
    }

    return operand;
  } //factor()
  
  //term = factor {mulop factor}.
  private Operand term(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nterm: start with stopSet = " + stopSet);

    /* part of lexical analysis */
    EnumSet<LexemeType> followSet = stopSet.clone();
    followSet.add(LexemeType.mulop);
    Operand leftOperand = factor(followSet);

    leftOperand = termWithOperand(leftOperand, stopSet);
    debug("\nterm: end");
    return leftOperand;
  }//term
  
  private Operand termWithOperand(Operand leftOperand, EnumSet<LexemeType> followSet) throws FatalError {
    debug("\ntermWithOperand: start with followSet = " + followSet);
    debug("\nterm: " + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());

    /* part of code generation */
    boolean leftOperandNotLoaded = true;
    MulValType operator;
    while (lexeme.type == LexemeType.mulop) {

      /* part of code generation */
      operator = lexeme.mulVal;
      if (leftOperandNotLoaded) {
        if (leftOperand.opType != OperandType.acc) {
          debug("\ntermWithOperand: calling plantAccLoad");
          plantAccLoad(leftOperand);
        }
        leftOperandNotLoaded = false;
      }
      
      /* part of lexical analysis */
      lexeme = lexemeReader.getLexeme(sourceCode);
      Operand rOperand = factor(followSet);

      /* part of code generation */
      debug("\ntermWithOperand loop: lOperand=" + leftOperand + ", rOperand=" + rOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
      /* leftOperand:  constant, acc, var, stack16, stack8
       * rOperand:     constant, acc, var, stack16, stack8
       */
      if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.constant)) {
        if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.word) {
          plant(new Instruction(forwardMul16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardMul16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardMul8.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.word) {
          plant(new Instruction(FunctionType.acc8ToAcc16));
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
          acc8.clear();
          plant(new Instruction(forwardMul16.get(operator), rOperand));
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.acc)) {
        if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardMul16.get(operator), rOperand));
          acc8.clear();
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.word) {
          plant(new Instruction(reverseMul16.get(operator), leftOperand));
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
          acc8.clear();
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.var)) {
        if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.word) {
          plant(new Instruction(forwardMul16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardMul16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardMul8.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.word) {
          plant(new Instruction(FunctionType.acc8ToAcc16));
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
          acc8.clear();
          plant(new Instruction(forwardMul16.get(operator), rOperand));
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.stack16) && (rOperand.opType == OperandType.acc)) {
        if (rOperand.datatype == Datatype.word) {
          plant(new Instruction(reverseMul16.get(operator), leftOperand));
          leftOperand.opType = OperandType.acc;
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.stack8) && (rOperand.opType == OperandType.acc)) {
        if (rOperand.datatype == Datatype.byt) {
          plant(new Instruction(reverseMul8.get(operator), leftOperand));
          leftOperand.opType = OperandType.acc;
          acc8.setOperand(leftOperand);
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    }
    debug("\ntermWithOperand: end: " + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    return leftOperand;
  } //termWithOperand
  
  //expression = term {addop term}.
  private Operand expression(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nexpression: start with stopSet = " + stopSet);

    /* part of lexical analysis */
    EnumSet<LexemeType> followSet = stopSet.clone();
    followSet.add(LexemeType.addop);
    Operand leftOperand = term(followSet);

    leftOperand = expressionWithOperand(leftOperand, followSet);
    debug("\nexpression: end");
    return leftOperand;
  } //expression()
  
  private Operand expressionWithOperand(Operand leftOperand, EnumSet<LexemeType> followSet) throws FatalError {
    debug("\nexpressionWithOperand: start with followSet = " + followSet);

    boolean leftOperandNotLoaded = true;
    debug("\nexpressionWithOperand: " + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    
    AddValType operator;
    while (lexeme.type == LexemeType.addop) {
      operator = lexeme.addVal;

      /* part of code generation */
      if (leftOperandNotLoaded) {
        if (leftOperand.opType != OperandType.acc) {
          plantAccLoad(leftOperand);
        }
        leftOperandNotLoaded = false;
      }
      
      /* part of lexical analysis */
      lexeme = lexemeReader.getLexeme(sourceCode);
      Operand rOperand = term(followSet);
      
      /* part of code generation */
      debug("\nexpressionWithOperand loop: lOperand=" + leftOperand + ", rOperand=" + rOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
      /* leftOperand:  constant, acc, var, stack16, stack8
       * rOperand:     constant, acc, var, stack16, stack8
       */
      if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.constant)) {
        if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.word) {
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardAdd8.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.word) {
          plant(new Instruction(FunctionType.acc8ToAcc16));
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
          acc8.clear();
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.acc)) {
        if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
          acc8.clear();
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.word) {
          plant(new Instruction(reverseAdd16.get(operator), leftOperand));
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
          acc8.clear();
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.var)) {
        if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.word) {
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.word && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardAdd8.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.word) {
          plant(new Instruction(FunctionType.acc8ToAcc16));
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
          acc8.clear();
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.stack16) && (rOperand.opType == OperandType.acc)) {
        if (rOperand.datatype == Datatype.word) {
          plant(new Instruction(reverseAdd16.get(operator), leftOperand));
          leftOperand.opType = OperandType.acc;
          leftOperand.datatype = Datatype.word;
          acc16.setOperand(leftOperand);
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.stack8) && (rOperand.opType == OperandType.acc)) {
        if (rOperand.datatype == Datatype.byt) {
          plant(new Instruction(reverseAdd8.get(operator), leftOperand));
          leftOperand.opType = OperandType.acc;
          acc8.setOperand(leftOperand);
        } else if (rOperand.datatype == Datatype.word) {
          plant(new Instruction(reverseAdd16.get(operator), leftOperand));
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
    debug("\nexpressionWithOperand: end: " + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    return leftOperand;
  } //expressionWithOperand()
  
  //parse a comparison, and return the address of the jump instruction to be filled with the label at the end of the control statement block.
  //comparison = expression relop expression
  private int comparison(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\ncomparison: start with stopSet = " + stopSet);

    /* part of lexical analysis */
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.relop);
    Operand leftOperand = expression(localSet);
    debug("\ncomparison: leftOperand=" + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());

    /* part of code generation */
    if (leftOperand.opType == OperandType.acc) {
      debug("\ncomparison: push leftOperand to the stack; " + leftOperand );
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
    RelValType compareOp;
    if (checkOrSkip(EnumSet.of(LexemeType.relop), localSet)) {
      /* part of code generation */
      compareOp = lexeme.relVal;
      /* part of lexical analysis */
      lexeme = lexemeReader.getLexeme(sourceCode);
    } else {
      /* part of code generation */
      compareOp = RelValType.eq;
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
  } //comparison(stopSet)
  
  //parse a comparison, jump back to the label if the comparison yields true.
  //comparison = expression relop expression
  private void comparisonInDoStatement(EnumSet<LexemeType> stopSet, int doLabel) throws FatalError {
    debug("\ncomparisonInDoStatement: start with stopSet = " + stopSet);

    /* part of lexical analysis */
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.relop);
    Operand leftOperand = expression(localSet);

    /* part of code generation */
    if (leftOperand.opType == OperandType.acc) {
      debug("\ncomparisonInDoStatement: push leftOperand to the stack; " + leftOperand );
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
    RelValType compareOp;
    if (checkOrSkip(EnumSet.of(LexemeType.relop), localSet)) {
      /* part of code generation */
      compareOp = lexeme.relVal;
      /* part of lexical analysis */
      lexeme = lexemeReader.getLexeme(sourceCode);
    } else {
      /* part of code generation */
      compareOp = RelValType.eq;
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
      if (compareOp == RelValType.eq) {
        plant(new Instruction(FunctionType.brEq, labelOperand));
      } else if (compareOp == RelValType.ne) {
        plant(new Instruction(FunctionType.brNe, labelOperand));
      } else if (compareOp == RelValType.gt) {
        plant(new Instruction(FunctionType.brLt, labelOperand));
      } else if (compareOp == RelValType.lt) {
        plant(new Instruction(FunctionType.brGt, labelOperand));
      } else if (compareOp == RelValType.ge) {
        plant(new Instruction(FunctionType.brLe, labelOperand));
      } else if (compareOp == RelValType.le) {
        plant(new Instruction(FunctionType.brGe, labelOperand));
      }
    } else {
      if (compareOp == RelValType.eq) {
        plant(new Instruction(FunctionType.brEq, labelOperand));
      } else if (compareOp == RelValType.ne) {
        plant(new Instruction(FunctionType.brNe, labelOperand));
      } else if (compareOp == RelValType.gt) {
        plant(new Instruction(FunctionType.brGt, labelOperand));
      } else if (compareOp == RelValType.lt) {
        plant(new Instruction(FunctionType.brLt, labelOperand));
      } else if (compareOp == RelValType.ge) {
        plant(new Instruction(FunctionType.brGe, labelOperand));
      } else if (compareOp == RelValType.le) {
        plant(new Instruction(FunctionType.brLe, labelOperand));
      }
    }

    debug("\ncomparisonInDoStatement: end");
  } //comparisonInDoStatement(stopSet, doLabel)

  private boolean plantComparisonCode(Operand leftOperand, Operand rightOperand) {
    debug("\nplantComparisonCode: leftOperand=" + leftOperand + ", rightOperand=" + rightOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    /*Possible operand types: 
     * leftOperand:  constant, acc, var, stack16, stack8; NB: var is loaded into acc and acc is pushed onto stack prior to evaluating right hand expression into rightOperand.
     * rightOperand: constant, acc, var, stack16, stack8
    */

    boolean reverseCompare = false;
    //plant(new Instruction(FunctionType.acc16Compare, rightOperand));
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
    } else if ((leftOperand.opType == OperandType.constant) && (rightOperand.opType == OperandType.stack8)) {
      if (leftOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.unstackAcc8));
        plant(new Instruction(FunctionType.acc8Compare, leftOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
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
      }else if (rightOperand.datatype == Datatype.byt) {
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
  } //plantComparisonCode()
  
  //parse a block of statements, and return the address of the first object code in the block of statements.
  //block = statement | "{" statements "}".
  private int block(EnumSet<LexemeType> stopSet) throws FatalError {
    int firstAddress = 0;
    debug("\nblock: start with stopSet = " + stopSet);
      
    //part of semantic analysis: start a new class level declaration scope for the statement block.
    identifiers.newScope();

    /* part of lexical analysis */
    EnumSet<LexemeType> startSet = stopSet.clone();
    startSet.addAll(startStatement);
    startSet.add(LexemeType.beginlexeme);

    EnumSet<LexemeType> stopBlockSet = startSet.clone();
    stopBlockSet.add(LexemeType.semicolon);
    stopBlockSet.add(LexemeType.endlexeme);

    checkOrSkip(startSet, stopBlockSet);
    if (lexeme.type == LexemeType.beginlexeme) {
      lexeme = lexemeReader.getLexeme(sourceCode);
      firstAddress = statements(EnumSet.of(LexemeType.endlexeme));
      if (checkOrSkip(EnumSet.of(LexemeType.endlexeme), EnumSet.noneOf(LexemeType.class))) {
		  lexeme = lexemeReader.getLexeme(sourceCode);
	  }
    } else {
      firstAddress = statement(stopSet);
    }
      
    //part of semantic analysis: close the declaration scope of the statement block.
    identifiers.closeScope();

    debug("\nblock: end, firstAddress = " + firstAddress);
    return firstAddress;
  } //block
  
  //forStatement = "for" "(" initialization ";" comparison ";" update ")" block.
  private void forStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nforStatement: start with stopSet = " + stopSet);
    
    //part of semantic analysis: start a new declaration scope for the for statement.
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
    //in the initialization part a new variable must be declared.
    String variable = assignment(stopInitializationSet);
    if (variable == null) {
      error();
      System.out.println("Loop variable must be declared in for statement; for (word variable; .. ; ..) {..} expected.");
    }
    
    //release acc after initialization part.
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
    
    //order of steps in p-sourcecode:  comparison - update - block.
    //order of steps during execution: comparison - block - update.

    /* part of code generation: skip update and jump forward to block */
    int gotoBlock = saveLabel();
    plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.word, 0)));
    int updateLabel = saveLabel();

    //release acc after comparison part.
    acc16.clear();
    acc8.clear();
    
    /* part of lexical analysis: update */
    stopForSet.add(LexemeType.beginlexeme);
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
    
    //todo: getLexeme na bovenstaande code generatie.
    
    //part of semantic analysis: close the declaration scope of the for statement.
    identifiers.closeScope();
    debug("\nforStatement: end");
  } //forStatement()

  //doStatement    = "do" block "while" "(" comparison ")" ";".
  private void doStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\ndoStatement: start with stopSet = " + stopSet);
    lexeme = lexemeReader.getLexeme(sourceCode);

    /* part of code generation */
    int doLabel = saveLabel();

    /* part of lexical analysis */
    //expect block, terminated by "while".
    EnumSet<LexemeType> stopDoSet = stopSet.clone();
    stopDoSet.add(LexemeType.whilelexeme);
    block(stopSet);
    
    //expect "while" followed by "(".
    EnumSet<LexemeType> stopWhileSet = stopSet.clone();
    stopWhileSet.add(LexemeType.rbracket);
    if (checkOrSkip(EnumSet.of(LexemeType.whilelexeme), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    if (checkOrSkip(EnumSet.of(LexemeType.lbracket), stopWhileSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    //release acc after block part.
    acc16.clear();
    acc8.clear();
    
    //expect comparison, terminated by ")"
    stopWhileSet.addAll(startStatement);
    stopWhileSet.remove(LexemeType.identifier);
    comparisonInDoStatement(stopWhileSet, doLabel);
    
    //expect ")" ";"
    stopWhileSet = stopSet.clone();
    stopWhileSet.add(LexemeType.semicolon);
    if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    
    debug("\ndoStatement: end");
  } //doStatement()

  //whileStatement = "while" "(" comparison ")" block.
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
  } //whileStatement()

  // ifStatement = "if" "(" comparison ")" block [ "else" block ].
  private void ifStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nifStatement: start with stopSet = " + stopSet);

    lexeme = lexemeReader.getLexeme(sourceCode);
    
    //expect (
    EnumSet<LexemeType> stopSetIf = stopSet.clone();
    stopSetIf.add(LexemeType.rbracket);
    if (checkOrSkip(EnumSet.of(LexemeType.lbracket), stopSetIf)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    //expect comparison
    stopSetIf = stopSet.clone();
    stopSetIf.add(LexemeType.rbracket);
    stopSetIf.addAll(startStatement);
    stopSetIf.remove(LexemeType.identifier);
    int ifLabel = comparison(stopSetIf);
    debug("\nifStatement: ifLabel = " + ifLabel);
    
    //expect )
    stopSetIf = stopSet.clone();
    stopSetIf.addAll(startStatement);
    if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopSetIf)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    //expect statement block
    EnumSet<LexemeType> stopSetElse = stopSet.clone();
    stopSetElse.add(LexemeType.elselexeme);
    block(stopSetElse);

    if (lexeme.type == LexemeType.elselexeme) {
      //expect else
      checkOrSkip(EnumSet.of(LexemeType.elselexeme), stopSetElse);

      /* part of code generation */
      int elseLabel = saveLabel();
      plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.word, 0)));
      debug("\nifStatement: elselabel=" + elseLabel);
      debug("\nifStatement: plantForwardLabel(" + ifLabel + ")");

      /* part of lexical analysis */
      //expect statement block
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
  } //ifStatement()
  
  //assignment = [datatype] update ";".
  //datatype   = "byte" | "word" | "String".
  private String assignment(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nassignment: start with stopSet = " + stopSet + "; lexeme.type=" + lexeme.type);

    EnumSet<LexemeType> stopAssignmentSet = stopSet.clone();
    stopAssignmentSet.addAll(startExp);
    stopAssignmentSet.add(LexemeType.semicolon);

    String variable = null;
    if (lexeme.type == LexemeType.bytelexeme || lexeme.type == LexemeType.wordlexeme || lexeme.type == LexemeType.stringlexeme) {
      /* part of lexical analysis */
      LexemeType datatype = lexeme.type;
      lexeme = lexemeReader.getLexeme(sourceCode);
      if (checkOrSkip(EnumSet.of(LexemeType.identifier), stopAssignmentSet)) {

        // part of semantic analysis.
        if (identifiers.checkId(lexeme.idVal) && identifiers.getId(lexeme.idVal).getDatatype() != null) {
         error(8); /* variable already declared */
        } else if (identifiers.declareId(lexeme, datatype)) {
          debug("\nassignment: var declared: " + lexeme.makeString(identifiers.getId(lexeme.idVal)));
          variable = lexeme.idVal;
        } else {
          error();
          System.out.println("Error declaring variable " + lexeme.idVal + " of type " + datatype);
        }
      }
    } else {
      /* part of lexical analysis */
      checkOrSkip(EnumSet.of(LexemeType.identifier), stopAssignmentSet);

      /* part of semantic analysis */
      if (!identifiers.checkId(lexeme.idVal)) error(9); /* variable not declared */
    }
    
    update(stopSet);

    /* part of lexical analysis */
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\nassignment: end");
    return variable;
  } //assignment()

  //update = identifier++ | identifier-- | identifier "=" expression
  private void update(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nupdate: start with stopSet = " + stopSet);

    EnumSet<LexemeType> stopAssignmentSet = stopSet.clone();
    stopAssignmentSet.addAll(startExp);
    stopAssignmentSet.add(LexemeType.semicolon);

    /* part of semantic analysis. */
    Variable var = identifiers.getId(lexeme.idVal);
    int varAddress = var.getAddress();
    Datatype varDatatype = var.getDatatype();

    /* part of lexical analysis */
    lexeme = lexemeReader.getLexeme(sourceCode);
    if (lexeme.type == LexemeType.addop && lexeme.addVal == AddValType.sub) {
      //identifier--
      lexeme = lexemeReader.getLexeme(sourceCode);
      if (lexeme.type == LexemeType.addop && lexeme.addVal == AddValType.sub) {
        lexeme = lexemeReader.getLexeme(sourceCode);

        /* part of code generation */
        if (varDatatype == Datatype.word) {
          plant(new Instruction(FunctionType.decrement16, new Operand(OperandType.var, Datatype.word, varAddress)));
        } else if (varDatatype == Datatype.byt) {
          plant(new Instruction(FunctionType.decrement8, new Operand(OperandType.var, Datatype.byt, varAddress)));
        } else {
          error(12);
        }
      }
    } else if (lexeme.type == LexemeType.addop && lexeme.addVal == AddValType.add) {
      //identifier++
      lexeme = lexemeReader.getLexeme(sourceCode);
      if (lexeme.type == LexemeType.addop && lexeme.addVal == AddValType.add) {
        lexeme = lexemeReader.getLexeme(sourceCode);

        /* part of code generation */
        if (varDatatype == Datatype.word) {
          plant(new Instruction(FunctionType.increment16, new Operand(OperandType.var, Datatype.word, varAddress)));
        } else if (varDatatype == Datatype.byt) {
          plant(new Instruction(FunctionType.increment8, new Operand(OperandType.var, Datatype.byt, varAddress)));
        } else {
          error(12); 
        }
      }
    } else if (checkOrSkip(EnumSet.of(LexemeType.assign), stopAssignmentSet)) {
      //identifier "=" expression
      lexeme = lexemeReader.getLexeme(sourceCode);
      Operand operand = expression(stopSet);
      debug("\nupdate: " + operand);

      /* part of code generation */
      //assignment via accu.
      if (operand.opType != OperandType.acc) {
        plantAccLoad(operand);
      }
      //actual assignment.
      if (operand.datatype == Datatype.word || operand.datatype == Datatype.string) {
        plant(new Instruction(FunctionType.acc16Store, new Operand(OperandType.var, varDatatype, varAddress)));
      } else if (operand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.acc8Store, new Operand(OperandType.var, varDatatype, varAddress)));
      } else {
        error(12);
      }
    }

    debug("\nupdate: end");
  } //update()

  // printlnStatement = "println" "(" expression ")" ";".
  // The println statement makes a distinction between a string expression and an algorithmic expression.
  // An expression is a string expression if the first operand is a string constant or the identifier of a string variable, otherwise it is an algorithmic expression.
  // In a println statement with a string expression, the subsequent operands may be added; other operators are not allowed.
  // However, sub expressions (expression between left ( and right ) parenthesis, may be string expressions or algorithmic expressions.
  // Operands in a string expression, including results of subexpressions, are converted to string and then printed.
  private void printlnStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nprintlnStatement: start with stopSet = " + stopSet);

    //part of lexical analysis.
    //skip println symbol.
    lexeme = lexemeReader.getLexeme(sourceCode);

    EnumSet<LexemeType> stopWriteSet = stopSet.clone();
    stopWriteSet.addAll(startExp);
    stopWriteSet.add(LexemeType.rbracket);
    stopWriteSet.add(LexemeType.semicolon);

    //skip left bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.lbracket), stopWriteSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    
    //read first operand.
    EnumSet<LexemeType> stopExpressionSet = stopSet.clone();
    stopExpressionSet.add(LexemeType.rbracket);
    stopExpressionSet.add(LexemeType.semicolon);
    Operand operand = factor(stopExpressionSet);
    EnumSet<LexemeType> startExpressionSet = stopExpressionSet.clone();
    startExpressionSet.add(LexemeType.addop);
    
    //handle string expression or algorithmic expression.
    if (operand.datatype == Datatype.string) {
      //string expression.
      do {
        //part of lexical analysis.
        if ((lexeme.type == LexemeType.addop) && (lexeme.addVal == AddValType.add)) {
          debug("\nprintlnStatement: " + operand + ", lexeme=" + lexeme.makeString(null));
          //part of code generation.
          plantPrintln(operand, false);

          //part of lexical analysis.
          //skip addop symbol.
          lexeme = lexemeReader.getLexeme(sourceCode);

          //read next factor.
          operand = factor(startExpressionSet);
        } else if (lexeme.type != LexemeType.rbracket) {
          //part of lexical analysis.
          error(3); //only + symbol allowed between terms in string expression.
          System.out.println(" " + lexeme.makeString(null));
          //skip unexpected symbol.
          if (checkOrSkip(EnumSet.of(lexeme.type), stopWriteSet)) {
            lexeme = lexemeReader.getLexeme(sourceCode);
          }
        }
      } while (lexeme.type != LexemeType.rbracket);

      debug("\nprintlnStatement: " + operand + ", lexeme=" + lexeme.makeString(null));
      //part of code generation.
      plantPrintln(operand, true);
    } else {
      //algorithmic expression.
      //if the first operand is a factor in a multiplication or division, finish the first term before finishing the expression .
      if (lexeme.type == LexemeType.mulop) {
        operand = termWithOperand(operand, startExpressionSet);
      }
      operand = expressionWithOperand(operand, startExpressionSet);
      debug("\nprintlnStatement: " + operand);

      //part of code generation.
      plantPrintln(operand, true);
    }

    //part of lexical analysis.
    if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopExpressionSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    //skip right bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\nprintlnStatement: end");
  }

  //parse a statement, and return the address of the first object code in the statement.
  //statement = assignment | printlnStatement | ifStatement | forStatement | doStatement | whileStatement.
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
      } else if (lexeme.type == LexemeType.printlnlexeme) {
        printlnStatement(stopSet);
      } else if (lexeme.type == LexemeType.iflexeme) {
        ifStatement(stopSet);
      } else if (lexeme.type == LexemeType.forlexeme) {
        forStatement(stopSet);
      } else if (lexeme.type == LexemeType.dolexeme) {
        doStatement(stopSet);
      } else if (lexeme.type == LexemeType.whilelexeme) {
        whileStatement(stopSet);
      }
    }
    debug("\nstatement: end, firstAddress = " + firstAddress);
    return firstAddress;
  } //statement
  
  //parse a sequence of statements, and return the address of the first object code in the sequence of statements.
  //statements = (statement)*.
  private int statements(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nstatements: start with stopSet = " + stopSet);
    int firstAddress = 0;
    
    //while (checkOrSkip(startStatement, stopSet)) {
    while (startStatement.contains(lexeme.type)) {
      int nextAddress = statement(stopSet);
      if (firstAddress == 0) firstAddress = nextAddress;
      //lexeme = lexemeReader.getLexeme(sourceCode);
    }
    debug("\nstatements: end, firstAddress = " + firstAddress);
    
    //first source } as comment, then branch, then next source as comment.
    if (lexeme.type == LexemeType.endlexeme) {
      plantSource();
    }
    return firstAddress;
  } //statements
  
  //program = "class" identifier "{" statements "}".
  private void prog() throws FatalError {
    debug("\nprog: start");
    /* recognise a class definition */
    lexeme = lexemeReader.getLexeme(sourceCode);
    if (checkOrSkip(EnumSet.of(LexemeType.classlexeme), EnumSet.of(LexemeType.identifier, LexemeType.beginlexeme))) {
      lexeme = lexemeReader.getLexeme(sourceCode);
      
      //part of semantic analysis: start a new class level declaration scope.
      identifiers.newScope();

      if (checkOrSkip(EnumSet.of(LexemeType.identifier), EnumSet.of(LexemeType.beginlexeme))) {
        /* next line + debug message is part of semantic analysis */
        if (identifiers.checkId(lexeme.idVal)) {
          error(8); /* variable already declared */
        } else if (identifiers.declareId(lexeme, LexemeType.classlexeme)) {
          debug("\nprog: class declared: " + lexeme.idVal);
        } else {
          error();
          System.out.println("Error declaring variable " + lexeme.idVal + " as a class.");
        }

        lexeme = lexemeReader.getLexeme(sourceCode);
        checkOrSkip(EnumSet.of(LexemeType.beginlexeme), EnumSet.noneOf(LexemeType.class));

        lexeme = lexemeReader.getLexeme(sourceCode);
        statements(EnumSet.of(LexemeType.endlexeme));

        //lexeme = lexemeReader.getLexeme(sourceCode);
        checkOrSkip(EnumSet.of(LexemeType.endlexeme), EnumSet.noneOf(LexemeType.class));
      }
      
      //part of semantic analysis: close the class level declaration scope.
      identifiers.closeScope();
    }
    debug("\nprog: end");
  }
  
  private void optimize() {
    debug("\noptimize: start m-code optimization. Number of instructions before optimization = " + instructions.size());
    int pos = 0;
    while (pos < instructions.size()-2) {
      if ((instructions.get(pos).function == FunctionType.stackAcc16) && (instructions.get(pos+1).function == FunctionType.unstackAcc16)) {
        //remove tuple { <acc16; acc16= unstack16 }
        debug(String.format("\noptimize: removing tuple { <acc16; acc16= unstack16 } at %d-%d", pos, pos+1));
        relocate(pos, 2);
      } else if ((instructions.get(pos).function == FunctionType.stackAcc8) && (instructions.get(pos+1).function == FunctionType.unstackAcc8)) {
        //remove tuple { <acc8; acc8= unstack8 }
        debug(String.format("\noptimize: removing tuple { <acc8; acc8= unstack8 } at %d-%d", pos, pos+1));
        relocate(pos, 2);
      }
      pos++;
    }
    debug("\noptimize: end. Number of instructions after optimization = " + instructions.size());
    debug("\n");
  } //optimize
  
  // remove 'number' instructions, starting at position 'pos', and relocate branch addresses and references to string constants.
  private void relocate(int pos, int number) {
    //remove #number instructions.
    for (int i = 0; i<number; i++) {
      instructions.remove(pos);
    }

    //adjust branch instructions.
    int idx = 0;
    Instruction instruction;
    do {
      instruction = instructions.get(idx++);
      if (brFunctions.contains(instruction.function) && (instruction.operand.intValue > pos)) {
        instruction.operand.intValue -= number;
      }
    } while (instruction.function != FunctionType.stop);
  } //relocate
  
  /*Class member methods for code generation phase */
  private void plantAccLoad(Operand operand) {
    //load acc with operand.
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
    debug("\n->plant (acc8InUse=" + acc8.inUse() + ", acc16InUse=" + acc16.inUse() + ", lastSourceLineNr=" + lastSourceLineNr + ", sourceLineNr=" + lexeme.sourceLineNr + ", linesOfSourceCode=" + sourceCode.size() + "):");
    
    plantSource();
    plantCode(instruction);
  } //plant
  
  private void plantThenSource(Instruction instruction) {
    /* for debugging purposes */
    debug("\n->plantThenSource (acc8InUse=" + acc8.inUse() + ", acc16InUse=" + acc16.inUse() + ", lastSourceLineNr=" + lastSourceLineNr + ", sourceLineNr=" + lexeme.sourceLineNr + ", linesOfSourceCode=" + sourceCode.size() + "):");
    
    plantCode(instruction);
    plantSource();
  } //plantThenSource
  
  private void plantSource() {
    for(String line : sourceCode) {
      if (debugMode) {
        debug("\n" + String.format(LINE_NR_FORMAT, instructions.size()) + FunctionType.comment.getValue() + line);
      }
      instructions.add(new Instruction(FunctionType.comment, new Operand(OperandType.constant, Datatype.string, line)));
    }
    sourceCode.clear();
  } //plantSource

  private void plantCode(Instruction instruction) {
    /* clear memory if number of M-code (virtual machine codes) exceeds memory size. */
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
  } //plantCode

  private void plantForwardLabel(int pos, int address) {
    //skip original source code that has been added as comment before the branch instruction.
    while (instructions.get(pos).function == FunctionType.comment) {
      pos++;
    }

    instructions.get(pos).operand.intValue = address;

    /* for debugging purposes */
    debug("\nplantForwardLabel instruction[" + pos + "]=" + address);
  } //plantForwardLabel(pos, address)

  private void plantStringConstants() {
    for (int id = 0; id < stringConstants.size(); id++) {
      //plant string constant.
      Operand operand = new Operand(OperandType.constant, Datatype.string, stringConstants.get(id));
      operand.intValue = id;
      instructions.add(new Instruction(FunctionType.stringConstant, operand));
    }
  }

  private void plantPrintln(Operand operand, boolean withCarriageReturn) {
    //part of code generation.
    if (operand.opType != OperandType.acc) {
      plantAccLoad(operand);
    }
    switch (operand.datatype) {
      case word :
        plant(new Instruction(withCarriageReturn ? FunctionType.writeLineAcc16 : FunctionType.writeAcc16));
        break;
      case byt :
        plant(new Instruction(withCarriageReturn ? FunctionType.writeLineAcc8 : FunctionType.writeAcc8));
        break;
      case string :
        plant(new Instruction(withCarriageReturn ? FunctionType.writeLineString : FunctionType.writeString));
        break;
      default: error(15);
    }
  }

  
  private void updateReferencesToStringConstants(int offset) {
    Map<Integer, ArrayList<Integer>> stringReferences = new HashMap<Integer, ArrayList<Integer>>();
    int lineNumber = 0;
    Instruction instruction;
    do {
      instruction = instructions.get(lineNumber);
      if (instruction.function != FunctionType.comment
       && instruction.operand != null 
       && instruction.operand.opType == OperandType.constant 
       && instruction.operand.datatype == Datatype.string) {
        if (instruction.operand.intValue == null) {
          throw new RuntimeException(String.format("operand.intValue is null at instruction %d: instruction: %s operand: %s", + lineNumber, instruction, instruction.operand));
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
      for(Map.Entry entry: stringReferences.entrySet()){
          debug(entry.getKey() + " : " + entry.getValue() + "\n");
      }
    }
  }
  
  private int saveLabel() {
    //address of next object code.
    int address = instructions.size();
    
    //compensate address for original source code that will be added as comment before the next instruction.
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
        debug("\npopStackedDatatype: unexpected data type popped from stack: popped " + datatype + "; expected "+ expectedDataType);
        throw new RuntimeException("Internal compiler error: abort.");
    }
  } //popStackedDatatype()

}
