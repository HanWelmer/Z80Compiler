import java.util.ArrayList;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map;

//TODO merge LexemeReader en LexemeFileReader.
//TODO check test1.m 86 :<acc8= variable 4
//TODO check test1.m 80 :<acc8= variable 3.
//TODO check test2.m brne 15.
//TODO check test3.m 26 :<acc16= acc16. vergelijk test9.m regel 57.
//TODO check test9.m 11 :<acc16= acc16. vergelijk test9.m regel 57.
//TODO check test9.m 24 :<acc8= acc8. vergelijk test9.m regel 57.
//TODO check test1.m 122://  } \n123 ://  write(a);\n124 :br 111 aan het einde van een for loop.
//TODO check test1.m 34 :br 16 aan het einde van een while loop.
//TODO test5.p uitbreiden met patroon n / (x + y) etc.
//TODO test1.p opslitsen: while, do, for.
//TODO make test for doStatement (see test1.p).
//TODO check stack usage/clear irt <acc8= en <acc16= etc.
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
public class PCompiler {
  /* global variables used by the constructor or the interface functions */
  private static boolean debugMode;
  private static boolean verboseMode;
  private static String fileName;
  private static LexemeReader lexemeReader;
  private ArrayList<Instruction> storeInstruction = new ArrayList<Instruction>();

  //constructor
  public PCompiler(boolean debugMode, boolean verboseMode) {
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
  private static final int MAX_M_CODE = 1000;
  private boolean acc16InUse;
  private boolean acc8InUse;

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

  /*Class member methods for all phases */
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
    acc16InUse = false;
    acc8InUse = false;

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
  private Operand factor(EnumSet<LexemeType> stopSet, Operand operand) throws FatalError {
    operand.opType = OperandType.unknown;
    debug("\nfactor 1: " + operand + ", acc16InUse = " + acc16InUse + ", acc8InUse = " + acc8InUse);
    if (checkOrSkip(startExp, stopSet)) {
      if (lexeme.type == LexemeType.identifier) {
        /* part of semantic analysis */
        if (!identifiers.checkId(lexeme.idVal)) error(9); /* variable not declared */
        /* part of code generation */
        operand.opType = OperandType.var;
        Variable var = identifiers.getId(lexeme.idVal);
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
        if (acc16InUse) {
          operand.opType = OperandType.stack;
          plant(new Instruction(FunctionType.acc16Store, operand));
        }
        operand.opType = OperandType.acc;
        operand.datatype = Datatype.integer;
        plant(new Instruction(FunctionType.read));
        acc16InUse = true;
      } else if (lexeme.type == LexemeType.lbracket) {
        //skip left bracket.
        lexeme = lexemeReader.getLexeme(sourceCode);
        EnumSet<LexemeType> stopSetCopy = stopSet.clone();
        stopSetCopy.add(LexemeType.rbracket);
        operand = expression(stopSetCopy, operand);
        //skip right bracket.
        if (checkOrSkip(EnumSet.of(LexemeType.rbracket), stopSet)) {
          lexeme = lexemeReader.getLexeme(sourceCode);
        }
      }
    }

    //consistency check.
    debug("\nfactor: end: " + operand + ", acc16InUse = " + acc16InUse + ", acc8InUse = " + acc8InUse);
    if (operand.opType == OperandType.unknown) {
      throw new FatalError(12);
    }

    return operand;
  } //factor()
  
  //term = factor {mulop factor}.
  private Operand term(EnumSet<LexemeType> stopSet, Operand operand) throws FatalError {
    /* part of code generation */
    MulValType operator;
    Operand rOperand = new Operand(OperandType.unknown);

    /* part of lexical analysis */
    EnumSet<LexemeType> followSet = stopSet.clone();
    followSet.add(LexemeType.mulop);
    operand = factor(followSet, operand);
    debug("\nterm: " + operand + ", acc16InUse = " + acc16InUse + ", acc8InUse = " + acc8InUse);
    while (lexeme.type == LexemeType.mulop) {
      operator = lexeme.mulVal;

      /* part of code generation */
      if (operand.opType != OperandType.acc) {
        plantAccLoad(operand);
      }
      operand.opType = OperandType.acc;
      
      /* part of lexical analysis */
      lexeme = lexemeReader.getLexeme(sourceCode);
      rOperand = factor(followSet, rOperand);

      /* part of code generation */
      debug("\nterm loop: lOperand=" + operand + ", rOperand=" + rOperand + ", acc16InUse = " + acc16InUse + ", acc8InUse = " + acc8InUse);
      // acc-acc
      // lOperand=operand(acc, type=byt, intValue=36), rOperand=operand(acc, type=byt, intValue=4), acc16InUse = false, acc8InUse = true
      // lOperand=operand(acc, type=integer, intValue=3900), rOperand=operand(acc, type=integer, intValue=300), acc16InUse = true, acc8InUse = false
      // lOperand=operand(acc, type=integer, intValue=3), rOperand=operand(acc, type=byt, intValue=1), acc16InUse = true, acc8InUse = true
      // lOperand=operand(acc, type=byt, intValue=1), rOperand=operand(acc, type=integer), acc16InUse = true, acc8InUse = true
      // not acc-acc
      // lOperand=operand(acc, type=byt, intValue=3), rOperand=operand(constant, type=byt, intValue=3), acc16InUse = false, acc8InUse = true
      // lOperand=operand(acc, type=integer, intValue=5), rOperand=operand(var, type=integer, intValue=7), acc16InUse = true, acc8InUse = false
      // lOperand=operand(acc, type=integer, intValue=1000), rOperand=operand(constant, type=byt, intValue=1), acc16InUse = true, acc8InUse = false
      // ?
      // lOperand=operand(acc, type=byt, intValue=1), rOperand=operand(constant, type=integer, intValue=1037), acc16InUse = false, acc8InUse = true
      if (operand.opType == OperandType.acc && rOperand.opType == OperandType.acc) {
        if (operand.datatype == rOperand.datatype) {
          //left operand has been pushed onto the stack
          operand.opType = OperandType.stack;
          if (operand.datatype == Datatype.byt) {
            plant(new Instruction(reverseMul8.get(operator), operand));
          } else {
            plant(new Instruction(reverseMul16.get(operator), operand));
          }
        } else if (operand.datatype == Datatype.integer && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardMul16.get(operator), rOperand));
        } else if (operand.datatype == Datatype.byt && rOperand.datatype == Datatype.integer) {
          plant(new Instruction(reverseMul16.get(operator), operand));
          operand.datatype = Datatype.integer;
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if (operand.datatype == Datatype.byt && rOperand.datatype == Datatype.byt) {
        plant(new Instruction(forwardMul8.get(operator), rOperand));
      } else if (operand.datatype == Datatype.integer && rOperand.datatype == Datatype.integer) {
        plant(new Instruction(forwardMul16.get(operator), rOperand));
      } else if (operand.datatype == Datatype.integer && rOperand.datatype == Datatype.byt) {
        plant(new Instruction(forwardMul16.get(operator), rOperand));
      } else if (operand.datatype == Datatype.byt && rOperand.datatype == Datatype.integer) {
        if (rOperand.opType == OperandType.acc) {
          plant(new Instruction(FunctionType.stackAcc8ToAcc16));
          throw new RuntimeException("Internal compiler error: abort.");
        } else {
          plant(new Instruction(FunctionType.acc8ToAcc16));
        }
        plant(new Instruction(forwardMul16.get(operator), rOperand));
        operand.datatype = Datatype.integer;
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    }
    debug("\nterm: end: " + operand + ", acc16InUse = " + acc16InUse + ", acc8InUse = " + acc8InUse);
    return operand;
  } //term()
  
  //expression = term {addop term}.
  private Operand expression(EnumSet<LexemeType> stopSet, Operand operand) throws FatalError {
    debug("\nexpression: start with stopSet = " + stopSet);
    /* part of lexical analysis */
    AddValType operator;
    Operand rOperand = new Operand(OperandType.unknown);
    
    /* part of lexical analysis */
    EnumSet<LexemeType> followSet = stopSet.clone();
    followSet.add(LexemeType.addop);
    operand = term(followSet, operand);
    debug("\nexpression: " + operand + ", acc16InUse = " + acc16InUse + ", acc8InUse = " + acc8InUse);
    while (lexeme.type == LexemeType.addop) {
      operator = lexeme.addVal;

      /* part of code generation */
      if (operand.opType != OperandType.acc) {
        plantAccLoad(operand);
      }
      operand.opType = OperandType.acc;
      
      /* part of lexical analysis */
      lexeme = lexemeReader.getLexeme(sourceCode);
      rOperand = term(followSet, rOperand);
      
      /* part of code generation */
      debug("\nexpression loop: lOperand=" + operand + ", rOperand=" + rOperand + ", acc16InUse = " + acc16InUse + ", acc8InUse = " + acc8InUse);
      // acc-acc
      // lOperand=operand(acc, type=byt, intValue=10), rOperand=operand(acc, type=byt, intValue=3), acc16InUse = false, acc8InUse = true
      // lOperand=operand(acc, type=integer, intValue=1000), rOperand=operand(acc, type=integer), acc16InUse = true, acc8InUse = false
      // lOperand=operand(acc, type=integer, intValue=3), rOperand=operand(acc, type=byt, intValue=1), acc16InUse = true, acc8InUse = true
      // lOperand=operand(acc, type=byt, intValue=0), rOperand=operand(acc, type=integer), acc16InUse = true, acc8InUse = true
      // not acc-acc
      // lOperand=operand(acc, type=byt, intValue=0), rOperand=operand(constant, type=byt, intValue=2), acc16InUse = false, acc8InUse = true
      // lOperand=operand(acc, type=integer), rOperand=operand(constant, type=integer, intValue=1000), acc16InUse = true, acc8InUse = false
      // lOperand=operand(acc, type=integer), rOperand=operand(constant, type=byt, intValue=0), acc16InUse = true, acc8InUse = false
      // ?
      // lOperand=operand(acc, type=byt, intValue=2), rOperand=operand(var, type=integer, intValue=3), acc16InUse = false, acc8InUse = true
      if (operand.opType == OperandType.acc && rOperand.opType == OperandType.acc) {
        if (operand.datatype == rOperand.datatype) {
          //left operand has been pushed onto the stack
          operand.opType = OperandType.stack;
          if (operand.datatype == Datatype.byt) {
            plant(new Instruction(reverseAdd8.get(operator), operand));
          } else {
            plant(new Instruction(reverseAdd16.get(operator), operand));
          }
        } else if (operand.datatype == Datatype.integer && rOperand.datatype == Datatype.byt) {
          plant(new Instruction(forwardAdd16.get(operator), rOperand));
        } else if (operand.datatype == Datatype.byt && rOperand.datatype == Datatype.integer) {
          plant(new Instruction(reverseAdd16.get(operator), operand));
          operand.datatype = Datatype.integer;
        } else {
          throw new RuntimeException("Internal compiler error: abort.");
        }
      } else if (operand.datatype == Datatype.byt && rOperand.datatype == Datatype.byt) {
        plant(new Instruction(forwardAdd8.get(operator), rOperand));
      } else if (operand.datatype == Datatype.integer && rOperand.datatype == Datatype.integer) {
        plant(new Instruction(forwardAdd16.get(operator), rOperand));
      } else if (operand.datatype == Datatype.integer && rOperand.datatype == Datatype.byt) {
        plant(new Instruction(forwardAdd16.get(operator), rOperand));
      } else if (operand.datatype == Datatype.byt && rOperand.datatype == Datatype.integer) {
        if (rOperand.opType == OperandType.acc) {
          plant(new Instruction(FunctionType.stackAcc8ToAcc16));
          throw new RuntimeException("Internal compiler error: abort.");
        } else {
          plant(new Instruction(FunctionType.acc8ToAcc16));
        }
        plant(new Instruction(forwardAdd16.get(operator), rOperand));
        operand.datatype = Datatype.integer;
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    }
    debug("\nexpression: end: " + operand + ", acc16InUse = " + acc16InUse + ", acc8InUse = " + acc8InUse);
    return operand;
  } //expression()
  
  //parse a comparison, and return the address of the jump instruction to be filled with the label at the end of the control statement block.
  //comparison = expression relop expression
  private int comparison(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\ncomparison: start with stopSet = " + stopSet);

    /* part of code generation */
    int ifLabel;
    
    /* part of lexical analysis */
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.relop);
    Operand leftOperand = expression(localSet, new Operand(OperandType.unknown));

    /* part of code generation */
    plantAccLoad(leftOperand);
    leftOperand.opType = OperandType.acc;

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
    Operand rightOperand = expression(localSet, new Operand(OperandType.unknown));

    /* part of code generation */
    debug("\ncomparison: leftOperand=" + leftOperand + ", rightOperand=" + rightOperand + ", acc16InUse = " + acc16InUse + ", acc8InUse = " + acc8InUse);
    // acc-acc; integer-byt
    // acc-acc; byt-integer
    // not acc-acc; byt-byt
    // not acc-acc; integer-integer
    // not acc-acc; integer-byt
    // not acc-acc; byt-integer
    if (leftOperand.opType == OperandType.acc && rightOperand.opType == OperandType.acc) {
      if (leftOperand.datatype == Datatype.integer && rightOperand.datatype == Datatype.byt) {
        plant(new Instruction(FunctionType.acc16Compare, rightOperand));
      } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.integer) {
        plant(new Instruction(FunctionType.acc16CompareAcc8));
        leftOperand.datatype = Datatype.integer;
      } else {
        throw new RuntimeException("Internal compiler error: abort.");
      }
    } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.byt) {
      plant(new Instruction(FunctionType.acc8Compare, rightOperand));
    } else if (leftOperand.datatype == Datatype.integer && rightOperand.datatype == Datatype.integer) {
      plant(new Instruction(FunctionType.acc16Compare, rightOperand));
    } else if (leftOperand.datatype == Datatype.integer && rightOperand.datatype == Datatype.byt) {
      plant(new Instruction(FunctionType.acc16Compare, rightOperand));
    } else if (leftOperand.datatype == Datatype.byt && rightOperand.datatype == Datatype.integer) {
      if (rightOperand.opType == OperandType.acc) {
        plant(new Instruction(FunctionType.stackAcc8ToAcc16));
        throw new RuntimeException("Internal compiler error: abort.");
      } else {
        plant(new Instruction(FunctionType.acc8ToAcc16));
      }
      plant(new Instruction(FunctionType.acc16Compare, rightOperand));
    } else {
      throw new RuntimeException("Internal compiler error: abort.");
    }
    ifLabel = saveForwardLabel();
    Operand labelOperand = new Operand(OperandType.label, Datatype.integer, 0);
    if (rightOperand.opType != OperandType.stack) {
      plant(new Instruction(normalSkip.get(compareOp), labelOperand));
    } else {
      plant(new Instruction(reverseSkip.get(compareOp), labelOperand));
    }

    debug("\ncomparison: end");
    return ifLabel;
  } //comparison(stopSet)
  
  //parse a comparison, jump back to the label if the comparison yields true.
  //comparison = expression relop expression
  private void comparison(EnumSet<LexemeType> stopSet, int doLabel) throws FatalError {
    debug("\ncomparison: start with stopSet = " + stopSet);

    /* part of lexical analysis */
    EnumSet<LexemeType> localSet = stopSet.clone();
    localSet.add(LexemeType.relop);
    Operand leftOperand = expression(localSet, new Operand(OperandType.unknown));

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
    Operand rightOperand = expression(localSet, new Operand(OperandType.unknown));

    /* part of code generation */
    plant(new Instruction(FunctionType.acc16Compare, rightOperand));
    Operand labelOperand = new Operand(OperandType.label, Datatype.integer, doLabel);
    if (rightOperand.opType == OperandType.stack) {
      plant(new Instruction(normalSkip.get(compareOp), labelOperand));
    } else {
      plant(new Instruction(reverseSkip.get(compareOp), labelOperand));
    }

    debug("\ncomparison: end");
  } //comparison(stopSet, doLabel)

  
  // block = statement | "{" statements "}".
  private void block(EnumSet<LexemeType> stopSet) throws FatalError {
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
      statements(EnumSet.of(LexemeType.endlexeme));
      if (checkOrSkip(EnumSet.of(LexemeType.endlexeme), EnumSet.noneOf(LexemeType.class))) {
		  lexeme = lexemeReader.getLexeme(sourceCode);
	  }
    } else {
      statement(stopSet);
    }
      
    //part of semantic analysis: close the declaration scope of the statement block.
    identifiers.closeScope();

    debug("\nblock: end");
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
      System.out.println("Loop variable must be declared in for statement; (int variable; .. ; ..) {..} expected.");
    }
    
    //order of steps during execution: comparison - block - update.

    /* part of lexical analysis: comparison ";" */
    stopInitializationSet.addAll(startStatement);
    stopInitializationSet.remove(LexemeType.identifier);
    int forLabel = saveLabel();
    int gotoEnd = comparison(stopInitializationSet);
    if (checkOrSkip(EnumSet.of(LexemeType.semicolon), stopInitializationSet)) {
      lexeme = lexemeReader.getLexeme(sourceCode);
    }
    
    /* part of code generation: skip update and jump forward to block */
    int gotoBlock = saveLabel();
    plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.integer, 0)));
    int updateLabel = saveLabel();

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
    plantForwardLabel(gotoBlock);

    /* part of lexical analysis: block */
    block(stopSet);
    
    /* part of code generation; jump back to update */
    plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.integer, updateLabel)));
    plantForwardLabel(gotoEnd);
    
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

    //expect comparison, terminated by ")"
    stopWhileSet.addAll(startStatement);
    stopWhileSet.remove(LexemeType.identifier);
    comparison(stopWhileSet, doLabel);
    
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
    plant(new Instruction(FunctionType.br, new Operand(OperandType.label, Datatype.integer, whileLabel)));
    plantForwardLabel(endLabel);
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
      plantForwardLabel(ifLabel);

      /* part of lexical analysis */
      //expect statement block
      lexeme = lexemeReader.getLexeme(sourceCode);
      block(stopSet);
      
      /* part of code generation */
      plantForwardLabel(elseLabel);
    } else {
      /* part of code generation */
      debug("\nifStatement: plantForwardLabel(" + ifLabel + ")");
      plantForwardLabel(ifLabel);
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
      Operand operand = expression(stopSet, new Operand(OperandType.unknown));
      debug("\nupdate: " + operand);

      /* part of code generation */
      if (operand.opType != OperandType.acc) {
        plantAccLoad(operand);
      }
      if (varDatatype == Datatype.byt) {
        if (operand.datatype == Datatype.byt) {
          plant(new Instruction(FunctionType.acc8Store, new Operand(OperandType.var, Datatype.byt, varAddress)));
        } else if (operand.datatype == Datatype.integer) {
          plant(new Instruction(FunctionType.acc16ToAcc8));
          plant(new Instruction(FunctionType.acc8Store, new Operand(OperandType.var, Datatype.byt, varAddress)));
        } else {
          error(14);
        }
      } else if (varDatatype == Datatype.integer) {
        if (operand.datatype == Datatype.integer) {
          plant(new Instruction(FunctionType.acc16Store, new Operand(OperandType.var, Datatype.integer, varAddress)));
        } else if (operand.datatype == Datatype.byt) {
          plant(new Instruction(FunctionType.acc8ToAcc16));
          plant(new Instruction(FunctionType.acc16Store, new Operand(OperandType.var, Datatype.integer, varAddress)));
        } else {
          error(14);
        }
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
    Operand operand = expression(stopExpressionSet, new Operand(OperandType.unknown));
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

  //statement = assignment | writeStatement | ifStatement | forStatement | doStatement | whileStatement.
  private void statement(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nstatement: start with stopSet = " + stopSet);
    /* part of code generation */
    acc16InUse = false;
    acc8InUse = false;

    /* part of lexical analysis */
    EnumSet<LexemeType> startSet = stopSet.clone();
    startSet.addAll(startStatement);
    if (checkOrSkip(startSet, stopSet)) {
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
    debug("\nstatement: end");
  }
  
  //statements = (statement)*.
  private void statements(EnumSet<LexemeType> stopSet) throws FatalError {
    debug("\nstatements: start with stopSet = " + stopSet);
    
    //while (checkOrSkip(startStatement, stopSet)) {
    while (startStatement.contains(lexeme.type)) {
      statement(stopSet);
      //lexeme = lexemeReader.getLexeme(sourceCode);
    }
    debug("\nstatements: end");
  }
  
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
    if (operand.datatype == Datatype.integer) {
      if (operand.opType != OperandType.stack) {
        if (acc16InUse) {
            plant(new Instruction(FunctionType.stackAcc16Load, operand));
          } else {
            plant(new Instruction(FunctionType.acc16Load, operand));
        }
      }
      acc16InUse = true;
    } else { //operand.datatype == Datatype.byt
      if (operand.opType != OperandType.stack) {
        if (acc8InUse) {
            plant(new Instruction(FunctionType.stackAcc8Load, operand));
          } else {
            plant(new Instruction(FunctionType.acc8Load, operand));
        }
      }
      acc8InUse = true;
    }
  }

  private void plant(Instruction instruction) {
    /* for debugging purposes */
    debug("\n->plant (acc8InUse=" + acc8InUse + ", acc16InUse=" + acc16InUse + ", lastSourceLineNr=" + lastSourceLineNr + ", sourceLineNr=" + lexeme.sourceLineNr + ", linesOfSourceCode=" + sourceCode.size() + "):");
    
    /* add original source code */
    if (!sourceCode.isEmpty()) {
      for(String line : sourceCode) {
        if (debugMode) {
          debug("\n" + String.format("%3d ://", storeInstruction.size()) + line);
        }
        storeInstruction.add(new Instruction(FunctionType.comment, new Operand(OperandType.constant, Datatype.string, line)));
      }
      sourceCode.clear();
    }

    /* insert M (virtual machine) code into memory */
    if (storeInstruction.size() >= MAX_M_CODE) {
      error(10);
      storeInstruction.clear();
    }

    /* for debugging purposes */
    debug("\n" + String.format("%3d :", storeInstruction.size()) + instruction.toString());

    storeInstruction.add(instruction);
    if (instruction.function == FunctionType.acc8ToAcc16) {
      acc16InUse = true;
      acc8InUse = false;
    }
  }; //plant
  
  private void plantForwardLabel(int pos) {
    //skip original source code that has been added as comment before the branch instruction.
    while (storeInstruction.get(pos).function == FunctionType.comment) {
      pos++;
    }
    debug("\nplantForwardLabel " + storeInstruction.size() + " at position: " + pos);
    /*
    debug("\ninstruction(pos)=" + storeInstruction.get(pos));
    debug("\ninstruction(pos).operand=" + storeInstruction.get(pos).operand);
    debug("\ninstruction(pos).operand.intValue=" + storeInstruction.get(pos).operand.intValue);
    debug(".");
    debug(".");
    */
    storeInstruction.get(pos).operand.intValue = storeInstruction.size();
    /* for debugging purposes */
    debug("\nplantForwardLabel instruction(" + pos + ")=" + storeInstruction.get(pos));
  }

  private int saveForwardLabel() {
    /* for debugging purposes */
    debug("\nlabel used");

    return storeInstruction.size();
  }

  private int saveLabel() {
    /* for debugging purposes */
    debug("\nlabel:");

    return storeInstruction.size();
  }

}
