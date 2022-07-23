import java.util.ArrayList;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

//TODO compiler optimalisatie, zie test3.p: <acc16; acc16= unstack16
//TODO compiler optimalisatie, zie test3.p: <acc8; acc8= unstack8
//TODO test5.p lijkt overbodige haakjes te moeten hebben.
//TODO add test cases for whileStatement (see test2.p and test5.p).
//TODO add test cases for doStatement (see test2.p and test5.p).
//TODO add test cases for forStatement (see test2.p and test5.p).
//TODO add test cases for whileStatement (see test1.p en test5.p).
//TODO add test cases for doStatement (see test10.p en test5.p).
//TODO add test cases for forStatement (see test11.p en test5.p).

//TODO check stack usage/clear m.b.t. <acc8= en <acc16= etc.
//TODO check memory usage in scope hierarchy (root, for, while, if blocks).

/**
 * Compiler for the miniJava programming language.
 * Inspired by the book Compiler Engineering Using Pascal by P.C. Capon and P.J. Jinks
 * and of course Java as developed by Sun.
 *
 * program        = "class" identifier "{" statements "}".
 * identifier     = "(_A-Za-z)(_A-Za-z0-9)+".
 * statements     = (statement)*.
 * statement      = assignment | writeStatement | ifStatement | forStatement | doStatement | whileStatement.
 * assignment     = [datatype] update ";".
 * datatype       = "byte" | "int".
 * update         = identifier++ | identifier-- | identifier "=" expression
 * writeStatement = "write" "(" expression ")" ";".
 * ifStatement    = "if" "(" comparison ")" block [ "else" block].
 * forStatement   = "for" "(" initialization ";" comparison ";" update ")" block.
 * initialization = "int" identifier "=" expression.
 * doStatement    = "do" block "while" "(" comparison ")" ";".
 * whileStatement = "while" "(" comparison ")" block.
 * block          = statement | "{" statements "}".
 * comparison     = expression relop expression.
 * expression     = term {addop term}.
 * term           = factor {mulop factor}.
 * factor         = identifier | constant | "read" | "(" expression ")".
 * addop          = "+" | "-".
 * mulop          = "*" | "/".
 * relop          = "==" | "!=" | ">" | ">=" | "<" | "<=".
 * constant       = "(0-9)*".
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
 * A variable of type int takes two bytes (16 bit).
 * A variable of type byte has a range from 0 to 255.
 * A variable of type int has a range from -32768 to 32767.
 * An expression is initially evaluated in the type of the first (left most) factor.
 * A constant has a type byte if the value is between 0 and 255.
 * A byte expression is promoted to an int expression if a right-hand factor requires so.
 * The read() function returns an int value.
 * In an addop, mulop or relop the type of the lefthand operand and the right hand operand must be the same.
 * The value of the lefthand operand of an addop, mulop or relop is changed from byte to int if the type of the righthand operand is an int.
 * In an assignment the value of a byte expression can be assigned to an int variable.
 * In an assignment the value of a int expression assigned to a byte variable will be truncated.
 */
public class pCompiler {
  /* global variables used by the constructor or the interface functions */
  private static boolean debugMode;
  private static boolean verboseMode;
  private static String fileName;
  private static LexemeReader lexemeReader;
  private ArrayList<Instruction> storeInstruction = new ArrayList<Instruction>();

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
    } catch (FatalError e) {
      error(e.getErrorNumber());
      System.exit(1);
    }
    
    if (errors != 0) { 
      storeInstruction.clear();
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
    return storeInstruction;
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
    , LexemeType.intlexeme
    , LexemeType.writelexeme
    , LexemeType.iflexeme
    , LexemeType.forlexeme
    , LexemeType.dolexeme
    , LexemeType.whilelexeme
  );
  private EnumSet<LexemeType> startAssignment = EnumSet.of(
      LexemeType.identifier
    , LexemeType.bytelexeme
    , LexemeType.intlexeme
  );
  private EnumSet<LexemeType> startExp = EnumSet.of(
      LexemeType.lbracket
    , LexemeType.identifier
    , LexemeType.constant
    , LexemeType.readlexeme
  );

  /* Constants and class member variables for semantic analysis phase */
  private Identifiers identifiers = new Identifiers();
 
  /* Constants and class member variables for code generation phase */
  private static final int NULL_OP = 0;
  private static final int MAX_M_CODE = 10000;
  private static final String LINE_NR_FORMAT = "%4d ";
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
    storeInstruction.clear();

    forwardAdd16.put(AddValType.add, FunctionType.acc16Plus);
    forwardAdd16.put(AddValType.sub, FunctionType.acc16Minus);
    reverseAdd16.put(AddValType.add, FunctionType.acc16Plus);
    reverseAdd16.put(AddValType.sub, FunctionType.minusAcc16);

    forwardAdd8.put(AddValType.add, FunctionType.acc8Plus);
    forwardAdd8.put(AddValType.sub, FunctionType.acc8Minus);
    reverseAdd8.put(AddValType.add, FunctionType.acc8Plus);
    reverseAdd8.put(AddValType.sub, FunctionType.minusAcc8);

    forwardMul16.put(MulValType.muld, FunctionType.acc16Times);
    forwardMul16.put(MulValType.divd, FunctionType.acc16Div);
    reverseMul16.put(MulValType.muld, FunctionType.acc16Times);
    reverseMul16.put(MulValType.divd, FunctionType.divAcc16);

    forwardMul8.put(MulValType.muld, FunctionType.acc8Times);
    forwardMul8.put(MulValType.divd, FunctionType.acc8Div);
    reverseMul8.put(MulValType.muld, FunctionType.acc8Times);
    reverseMul8.put(MulValType.divd, FunctionType.divAcc8);

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
      case 15 : System.out.println("incompatible datatype in write statement"); break;
    }
  }
  
  /*Class member methods for syntax analysis phase */
  private boolean checkOrSkip(EnumSet<LexemeType> okSet, EnumSet<LexemeType> stopSet) throws FatalError {
    //debug("\ncheckOrSkip: start");
    boolean orFlag = false;
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
  
  //factor = identifier | constant | "read" | "(" expression ")".
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
        operand.intValue = var.getAddress();
        operand.datatype = var.getDatatype();
        /* part of lexical analysis */
        lexeme = lexemeReader.getLexeme(sourceCode);
      } else if (lexeme.type == LexemeType.constant) {
        /* part of code generation */
        operand.opType = OperandType.constant;
        operand.intValue = lexeme.constVal;
        operand.datatype = lexeme.datatype;
        /* part of lexical analysis */
        lexeme = lexemeReader.getLexeme(sourceCode);
      } else if (lexeme.type == LexemeType.readlexeme) {
        lexeme = lexemeReader.getLexeme(sourceCode);
        /* 
         * Part of code generation.
         * The read() function always returns an int value.
         */
        if (acc16.inUse()) {
          plant(new Instruction(FunctionType.stackAcc16));
        }
        plant(new Instruction(FunctionType.read));
        operand.opType = OperandType.acc;
        operand.datatype = Datatype.integer;
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
    /* part of code generation */
    MulValType operator;

    /* part of lexical analysis */
    EnumSet<LexemeType> followSet = stopSet.clone();
    followSet.add(LexemeType.mulop);
    Operand leftOperand = factor(followSet);
    boolean leftOperandNotLoaded = true;

    debug("\nterm: " + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    while (lexeme.type == LexemeType.mulop) {

      /* part of code generation */
      operator = lexeme.mulVal;
      if (leftOperandNotLoaded) {
        if (leftOperand.opType != OperandType.acc) {
          debug("\nterm: calling plantAccLoad");
          plantAccLoad(leftOperand);
        }
        leftOperandNotLoaded = false;
      }
      
      /* part of lexical analysis */
      lexeme = lexemeReader.getLexeme(sourceCode);
      Operand rOperand = factor(followSet);

      /* part of code generation */
      debug("\nterm loop: lOperand=" + leftOperand + ", rOperand=" + rOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
      /* leftOperand:  constant, acc, var, stack16, stack8
       * rOperand:     constant, acc, var, stack16, stack8
       *
       * term loop: lOperand=operand(acc, type=integer),             rOperand=operand(constant, type=integer, ...), acc16InUse = true, acc8InUse = false
       * term loop: lOperand=operand(acc, type=integer, intValue=1), rOperand=operand(constant, type=byt, intValue=1), acc16InUse = true, acc8InUse = false
       * term loop: lOperand=operand(acc, type=byt, intValue=12),    rOperand=operand(constant, type=byt, intValue=1), acc16InUse = false, acc8InUse = true
       * term loop: lOperand=operand(acc, type=byt, intValue=1),     rOperand=operand(constant, type=integer, ...), acc16InUse = false, acc8InUse = true
       * term loop: lOperand=operand(acc, type=integer, intValue=3), rOperand=operand(acc, type=byt, intValue=1), acc16InUse = true, acc8InUse = true
       * term loop: lOperand=operand(acc, type=byt, intValue=12),    rOperand=operand(acc, type=integer, intValue=2), acc16InUse = true, acc8InUse = true
       * term loop: lOperand=operand(acc, type=integer, intValue=5), rOperand=operand(var, type=integer, intValue=7), acc16InUse = true, acc8InUse = false
       * term loop: lOperand=operand(acc, type=integer),             rOperand=operand(var, type=byt, intValue=0), acc16InUse = true, acc8InUse = false
       * term loop: lOperand=operand(acc, type=byt, intValue=1),     rOperand=operand(var, type=byt, intValue=2), acc16InUse = false, acc8InUse = true
       * term loop: lOperand=operand(acc, type=byt, intValue=2),     rOperand=operand(var, type=integer, intValue=2), acc16InUse = false, acc8InUse = true
       * term loop: lOperand=operand(stack16, type=integer, ...),    rOperand=operand(acc, type=integer, ...), acc16InUse = true, acc8InUse = false
       * term loop: lOperand=operand(stack8, type=byt, intValue=12), rOperand=operand(acc, type=byt, intValue=1), acc16InUse = false, acc8InUse = true
       */
      if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.constant)) {
        if (leftOperand.datatype == Datatype.integer && rOperand.datatype == Datatype.integer) {
          plant(new Instruction(forwardMul16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.integer && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardMul16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardMul8.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.integer) {
          plant(new Instruction(FunctionType.acc8ToAcc16));
          leftOperand.datatype = Datatype.integer;
          acc16.setOperand(leftOperand);
          acc8.clear();
          plant(new Instruction(forwardMul16.get(operator), rOperand));
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.acc)) {
        if (leftOperand.datatype == Datatype.integer && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardMul16.get(operator), rOperand));
          acc8.clear();
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.integer) {
          plant(new Instruction(reverseMul16.get(operator), leftOperand));
          leftOperand.datatype = Datatype.integer;
          acc16.setOperand(leftOperand);
          acc8.clear();
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.var)) {
        if (leftOperand.datatype == Datatype.integer && rOperand.datatype == Datatype.integer) {
          plant(new Instruction(forwardMul16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.integer && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardMul16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardMul8.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.integer) {
          plant(new Instruction(FunctionType.acc8ToAcc16));
          leftOperand.datatype = Datatype.integer;
          acc16.setOperand(leftOperand);
          acc8.clear();
          plant(new Instruction(forwardMul16.get(operator), rOperand));
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.stack16) && (rOperand.opType == OperandType.acc)) {
        if (rOperand.datatype == Datatype.integer) {
          plant(new Instruction(reverseMul16.get(operator), leftOperand));
          leftOperand.opType = OperandType.acc;
          leftOperand.datatype = Datatype.integer;
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
    debug("\nterm: end: " + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    return leftOperand;
  } //term()
  
  //expression = term {addop term}.
  private Operand expression(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nexpression: start with stopSet = " + stopSet);
    /* part of lexical analysis */
    AddValType operator;
    
    /* part of lexical analysis */
    EnumSet<LexemeType> followSet = stopSet.clone();
    followSet.add(LexemeType.addop);
    Operand leftOperand = term(followSet);
    boolean leftOperandNotLoaded = true;
    
    debug("\nexpression: " + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
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
      debug("\nexpression loop: lOperand=" + leftOperand + ", rOperand=" + rOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
      /* leftOperand:  constant, acc, var, stack16, stack8
       * rOperand:     constant, acc, var, stack16, stack8
       */
      if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.constant)) {
        if (leftOperand.datatype == Datatype.integer && rOperand.datatype == Datatype.integer) {
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.integer && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardAdd8.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.integer) {
          plant(new Instruction(FunctionType.acc8ToAcc16));
          leftOperand.datatype = Datatype.integer;
          acc16.setOperand(leftOperand);
          acc8.clear();
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.acc)) {
        if (leftOperand.datatype == Datatype.integer && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
          acc8.clear();
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.integer) {
          plant(new Instruction(reverseAdd16.get(operator), leftOperand));
          leftOperand.datatype = Datatype.integer;
          acc16.setOperand(leftOperand);
          acc8.clear();
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.acc) && (rOperand.opType == OperandType.var)) {
        if (leftOperand.datatype == Datatype.integer && rOperand.datatype == Datatype.integer) {
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.integer && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardAdd8.get(operator), rOperand));
        } else if (leftOperand.datatype == Datatype.byt && rOperand.datatype == Datatype.integer) {
          plant(new Instruction(FunctionType.acc8ToAcc16));
          leftOperand.datatype = Datatype.integer;
          acc16.setOperand(leftOperand);
          acc8.clear();
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.stack16) && (rOperand.opType == OperandType.acc)) {
        if (rOperand.datatype == Datatype.integer) {
          plant(new Instruction(reverseAdd16.get(operator), leftOperand));
          leftOperand.opType = OperandType.acc;
          leftOperand.datatype = Datatype.integer;
          acc16.setOperand(leftOperand);
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if ((leftOperand.opType == OperandType.stack8) && (rOperand.opType == OperandType.acc)) {
        if (rOperand.datatype == Datatype.byt) {
          plant(new Instruction(reverseAdd8.get(operator), leftOperand));
          leftOperand.opType = OperandType.acc;
          acc8.setOperand(leftOperand);
        } else if (rOperand.datatype == Datatype.integer) {
          plant(new Instruction(reverseAdd16.get(operator), leftOperand));
          leftOperand.opType = OperandType.acc;
          leftOperand.datatype = Datatype.integer;
          acc16.setOperand(leftOperand);
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    }
    debug("\nexpression: end: " + leftOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    return leftOperand;
  } //expression()
  
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
    if (leftOperand.opType == OperandType.var) {
      plantAccLoad(leftOperand);
      debug("\ncomparison: plantAccLoad(leftOperand), acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
      leftOperand.opType = OperandType.acc;
    }
    /* part of code generation */
    if (leftOperand.opType == OperandType.acc) {
      debug("\ncomparison: push leftOperand to the stack; " + leftOperand );
      if (leftOperand.datatype == Datatype.integer) {
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

    /* part of lexical analysis */
    Operand rightOperand = expression(localSet);

    /* part of code generation */
    debug("\ncomparison: leftOperand=" + leftOperand + ", rightOperand=" + rightOperand + ", acc16InUse = " + acc16.inUse() + ", acc8InUse = " + acc8.inUse());
    /*Possible operand types: 
     * leftOperand:  constant, acc, var, stack16, stack8
     * rightOperand: constant, acc, var, stack16, stack8
    */
    boolean reverseCompare = false;
    if ((leftOperand.opType == OperandType.constant) && (rightOperand.opType == OperandType.constant)) {
      plantAccLoad(leftOperand);
      if (leftOperand.datatype == Datatype.integer && rightOperand.datatype == Datatype.integer) {
        plant(new Instruction(FunctionType.acc16Compare, rightOperand));
      } else if (leftOperand.datatype == Datatype.integer && rightOperand.datatype == Datatype.byt) {
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.integer) {
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.acc8Compare, rightOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.constant) && (rightOperand.opType == OperandType.acc)) {
      if (leftOperand.datatype == Datatype.integer && rightOperand.datatype == Datatype.integer) {
        reverseCompare = true;
        plant(new Instruction(FunctionType.acc16Compare, leftOperand));
      } else if (leftOperand.datatype == Datatype.integer && rightOperand.datatype == Datatype.byt) {
        plantAccLoad(leftOperand);
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.integer) {
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
      if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.integer) {
        plantAccLoad(leftOperand);
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.constant) && (rightOperand.opType == OperandType.stack8)) {
      if (leftOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.unstackAcc8));
        plant(new Instruction(FunctionType.acc8Compare, leftOperand));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.stack16) && (rightOperand.opType == OperandType.constant)) {
      if (rightOperand.datatype == Datatype.integer) { 
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
      if (rightOperand.datatype == Datatype.integer) {
        plant(new Instruction(FunctionType.revAcc16Compare, leftOperand));
        reverseCompare = true;
      } else if (rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.unstackAcc16));
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.stack16) && (rightOperand.opType == OperandType.var)) {
      if (rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.unstackAcc16));
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc16CompareAcc8));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.stack8) && (rightOperand.opType == OperandType.constant)) {
      if (rightOperand.datatype == Datatype.integer) {
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
      if (rightOperand.datatype == Datatype.integer) {
        plant(new Instruction(FunctionType.unstackAcc8));
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else if (rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.revAcc8Compare, leftOperand));
        reverseCompare = true;
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if ((leftOperand.opType == OperandType.stack8) && (rightOperand.opType == OperandType.var)) {
      if (rightOperand.datatype == Datatype.integer) {
        plant(new Instruction(FunctionType.unstackAcc8));
        plantAccLoad(rightOperand);
        plant(new Instruction(FunctionType.acc8CompareAcc16));
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else {
      throw new RuntimeException("Internal compiler error: abort.");
    }
      
    int ifLabel = saveLabel();
    Operand labelOperand = new Operand(OperandType.label, Datatype.integer, 0);
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
    debug("\ncomparison: start with stopSet = " + stopSet);

    /* part of lexical analysis */
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.relop);
    Operand leftOperand = expression(localSet);

    /* part of code generation */
    plantAccLoad(leftOperand);

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
    plant(new Instruction(FunctionType.acc16Compare, rightOperand));
    Operand labelOperand = new Operand(OperandType.label, Datatype.integer, doLabel);
    if (rightOperand.opType == OperandType.stack16) {
      plant(new Instruction(normalSkip.get(compareOp), labelOperand));
    } else {
      plant(new Instruction(reverseSkip.get(compareOp), labelOperand));
    }

    debug("\ncomparison: end");
  } //comparisonInDoStatement(stopSet, doLabel)

  
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
      System.out.println("Loop variable must be declared in for statement; for (int variable; .. ; ..) {..} expected.");
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
    plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.integer, 0)));
    int updateLabel = saveLabel();

    //release acc after comparison part.
    acc16.clear();
    acc8.clear();
    
    /* part of lexical analysis: update */
    stopForSet.add(LexemeType.beginlexeme);
    update(stopForSet);

    /* part of code generation: jump back to comparison */
    plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.integer, forLabel)));

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
    plantThenSource(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.integer, updateLabel)));
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
    plantThenSource(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.integer, whileLabel)));
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
      plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.integer, 0)));
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
  //datatype   = "byte" | "int".
  private String assignment(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nassignment: start with stopSet = " + stopSet + "; lexeme.type=" + lexeme.type);

    EnumSet<LexemeType> stopAssignmentSet = stopSet.clone();
    stopAssignmentSet.addAll(startExp);
    stopAssignmentSet.add(LexemeType.semicolon);

    String variable = null;
    if (lexeme.type == LexemeType.bytelexeme || lexeme.type == LexemeType.intlexeme) {
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
        if (varDatatype == Datatype.integer) {
          plant(new Instruction(FunctionType.decrement16, new Operand(OperandType.var, Datatype.integer, varAddress)));
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
        if (varDatatype == Datatype.integer) {
          plant(new Instruction(FunctionType.increment16, new Operand(OperandType.var, Datatype.integer, varAddress)));
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
      if (operand.datatype == Datatype.integer) {
        plant(new Instruction(FunctionType.acc16Store, new Operand(OperandType.var, varDatatype, varAddress)));
      } else if (operand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.acc8Store, new Operand(OperandType.var, varDatatype, varAddress)));
      } else {
        error(12);
      }
    }

    debug("\nupdate: end");
  } //update()

  // writeStatement = "write" "(" expression ")" ";".
  private void writeStatement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nwriteStatement: start with stopSet = " + stopSet);
    //skip write symbol.
    lexeme = lexemeReader.getLexeme(sourceCode);

    EnumSet<LexemeType> stopWriteSet = stopSet.clone();
    stopWriteSet.addAll(startExp);
    stopWriteSet.add(LexemeType.rbracket);
    stopWriteSet.add(LexemeType.semicolon);
    //skip left bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.lbracket), stopWriteSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    
    EnumSet<LexemeType> stopExpressionSet = stopSet.clone();
    stopExpressionSet.add(LexemeType.rbracket);
    stopExpressionSet.add(LexemeType.semicolon);
    Operand operand = expression(stopExpressionSet);
    debug("\nwriteStatement: " + operand);
    
    /* part of code generation */
    if (operand.opType != OperandType.acc) {
      plantAccLoad(operand);
    }
    if (operand.datatype == Datatype.integer) {
      plant(new Instruction(FunctionType.writeAcc16));
    } else if (operand.datatype == Datatype.byt) {
      plant(new Instruction(FunctionType.writeAcc8));
    } else {
      error(15);
    }

    /* part of lexical analysis */
    if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopExpressionSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    //skip right bracket.
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }

    debug("\nwriteStatement: end");
  }

  //parse a statement, and return the address of the first object code in the statement.
  //statement = assignment | writeStatement | ifStatement | forStatement | doStatement | whileStatement.
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
      } else if (lexeme.type == LexemeType.writelexeme) {
        writeStatement(stopSet);
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
  
  /*Class member methods for code generation phase */
  private void plantAccLoad(Operand operand) {
    //load acc with operand.
    if (operand.datatype == Datatype.integer) {
      if (operand.opType != OperandType.stack16) {
        if (acc16.inUse()) {
            plant(new Instruction(FunctionType.stackAcc16Load, operand));
          } else {
            plant(new Instruction(FunctionType.acc16Load, operand));
        }
        operand.opType = OperandType.acc;
        acc16.setOperand(operand);
      }
    } else { //operand.datatype == Datatype.byt
      if (operand.opType != OperandType.stack8) {
        if (acc8.inUse()) {
            plant(new Instruction(FunctionType.stackAcc8Load, operand));
          } else {
            plant(new Instruction(FunctionType.acc8Load, operand));
        }
        operand.opType = OperandType.acc;
        acc8.setOperand(operand);
      }
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
        debug("\n" + String.format(LINE_NR_FORMAT, storeInstruction.size()) + FunctionType.comment.getValue() + line);
      }
      storeInstruction.add(new Instruction(FunctionType.comment, new Operand(OperandType.constant, Datatype.string, line)));
    }
    sourceCode.clear();
  } //plantSource

  private void plantCode(Instruction instruction) {
    /* insert M (virtual machine) code into memory */
    if (storeInstruction.size() >= MAX_M_CODE) {
      error(10);
      storeInstruction.clear();
    }

    /* for debugging purposes */
    debug("\n" + String.format(LINE_NR_FORMAT, storeInstruction.size()) + instruction.toString());
    debug(" ;" + instruction.function + " " + instruction.operand);

    storeInstruction.add(instruction);
    if (instruction.function == FunctionType.acc8ToAcc16) {
      acc16.setOperand(acc8.operand());
      acc8.clear();
    } else if (instruction.function == FunctionType.stackAcc8) {
      stackedDatatypes.push(Datatype.byt);
      acc8.operand().opType = OperandType.stack8;
      acc8.clear();
    } else if (instruction.function == FunctionType.stackAcc16) {
      stackedDatatypes.push(Datatype.integer);
      acc16.operand().opType = OperandType.stack16;
      acc16.clear();
    } else if (instruction.function == FunctionType.stackAcc8Load) {
      stackedDatatypes.push(Datatype.byt);
      acc8.operand().opType = OperandType.stack8;
    } else if (instruction.function == FunctionType.stackAcc16Load) {
      stackedDatatypes.push(Datatype.integer);
      acc16.operand().opType = OperandType.stack16;
    } else if (instruction.function == FunctionType.stackAcc16ToAcc8) {
      stackedDatatypes.push(Datatype.byt);
      acc8.operand().opType = OperandType.stack8;
      acc16.clear();
    } else if (instruction.function == FunctionType.stackAcc8ToAcc16) {
      stackedDatatypes.push(Datatype.integer);
      acc16.operand().opType = OperandType.stack16;
      acc8.clear();
    }
    debug(" ;" + " stackedDatatypes=" + stackedDatatypes);
  } //plantCode

  private void plantForwardLabel(int pos, int address) {
    //skip original source code that has been added as comment before the branch instruction.
    while (storeInstruction.get(pos).function == FunctionType.comment) {
      pos++;
    }

    storeInstruction.get(pos).operand.intValue = address;

    /* for debugging purposes */
    debug("\nplantForwardLabel instruction[" + pos + "]=" + address);
  } //plantForwardLabel(pos, address)

  private int saveLabel() {
    //address of next object code.
    int address = storeInstruction.size();
    
    //compensate address for original source code that will be added as comment before the next instruction.
    int compensatedAddress = address + sourceCode.size();

    /* for debugging purposes */
    debug("\nlabel: address = " + address + ", compensated for comments = " + compensatedAddress);

    return compensatedAddress;
  }

  private OperandType popStackedDatatype() {
    Datatype datatype = stackedDatatypes.pop();
    if (datatype == Datatype.byt) {
      return OperandType.stack8;
    } else if (datatype == Datatype.integer) {
      return OperandType.stack16;
    } else {
        throw new RuntimeException("Internal compiler error: abort.");
    }
  } //popStackedDatatype()
}
