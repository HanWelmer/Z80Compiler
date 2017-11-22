import java.util.EnumSet;

/**
 * Interpreter for the M machine, as described in Compiler Engineering Using Pascal by P.C. Capon and P.J. Jinks.
 */
public class Interpreter {
  
  private Instruction[] instructions;
  private int[] vars;
  private String[] inputParts;
  private boolean debug = false;

  private static final int MAX_STACK = 128;
  private static final int MAX_VARS = 26;
  private EnumSet<FunctionType> branchSet = EnumSet.noneOf(FunctionType.class);
  private int inputIndex = 0;
  private int[] machineStack;
  private int pc, acc, sf;

  //constructor
  public Interpreter(Instruction[] instructions, String[] inputParts) {
    this.instructions = instructions;
    this.inputParts = inputParts;
    
    /* initialize interpreter*/
    machineStack = new int[MAX_STACK];
    vars = new int[MAX_VARS];
    branchSet.clear();
    pc = 0;
    sf = 0;
    acc = 0;
  }
  
  private void debug(String message) {
    if (debug) {
      System.out.print(message);
    }
  }

  /* execute a single instruction */
  public boolean step(boolean debugMode) {
    this.debug = debugMode;
    boolean stopRun = false;

    //get next instruction
    Instruction instr = instructions[pc];
    debug("\npc=" + pc + " : " + instr.toString());
    //execute instruction
    int operand;
    switch(instr.function){
      case accLoad: acc = getOp(); break;
      case stackAccLoad:
        push(acc);
        acc = getOp();
        break;
      case accPlus: acc += getOp(); break;
      case accMinus: acc -= getOp(); break;
      case minusAcc: acc = getOp() - acc; break;
      case accTimes: acc *= getOp(); break;
      case accDiv:
        operand = getOp();
        if (operand == 0) {
          runError("division by zero");
        }
        acc = acc / operand;
        break;
      case divAcc:
        if (acc == 0) {
          runError("division by zero");
        }
        acc = getOp() / acc;
        break;
      case accStore:
        switch(instr.opType) {
          case constant:
            runError("illegal operand");
            break;
          case var:
            if ((instr.word < 0) || (instr.word >= vars.length)) {
              runError("division by zero");
            }
            vars[instr.word] = acc;
            break;
          case stack:
            push(acc);
            break;
          default:
            runError("unknown operand type");
        } // switch(instr.opType)
        break;
      case accCompare:
        operand = getOp();
        if (acc == operand) {
          branchSet = EnumSet.of(FunctionType.brEq);
        } else {
          branchSet = EnumSet.of(FunctionType.brNe);
        }

        if (acc < operand) {
          branchSet.add(FunctionType.brLt);
        } else {
          branchSet.add(FunctionType.brGe);
        }

        if (acc <= operand) {
          branchSet.add(FunctionType.brLe);
        } else {
          branchSet.add(FunctionType.brGt);
        }
        break;
      case brEq:
      case brNe:
      case brLt:
      case brLe:
      case brGt:
      case brGe:
        if (branchSet.contains(instr.function)) {
          pc = instr.word - 1;
        }
        break;
      case br:
        pc = instr.word - 1;
        break;
      case call:
        if (instr.callValue == CallType.read) {
          System.out.print("read:");
          boolean consoleInput = true;
          if (consoleInput) {
            try {
              String str =  System.console().readLine();;
              acc = Integer.parseInt(str);
            } catch (RuntimeException e) {
              runError("read exception:" + e.getMessage());
              acc = 0;
              stopRun = true;
            }
          } else {
            if (inputIndex >= inputParts.length) {
              runError("read beyond input");
              acc = 0;
              stopRun = true;
            }
            acc = Integer.parseInt(inputParts[inputIndex++]);
          }
        } else if (instr.callValue == CallType.write) {
          System.out.println(pop());
        } else {
          runError("unknown call operand");
        }
        break;
      case stop:
        stopRun = true;
        break;
    } // switch(instr.function)
    
    //proceed to next instruction
    pc++;
    
    //return true if Stop instruction has been executed or if a fatal error occurred.
    return stopRun;
  } // interpret()

  /*Class member methods for interpreter */
  private void runError(String message) {
    System.out.println();
    System.out.println("*** runtime error: " + message);
    System.out.println("pc=" + pc + " : " + instructions[pc].toString());
    System.out.println();
    for (int i = 0; i < vars.length; i++) {
      System.out.println("variable " + i + " = " + vars[i]);
    }
    System.out.println();
    System.out.println("accumulator = " + acc);
    System.out.println("stackpointer= " + sf);
    System.out.println();
    for (int i = 0; i<sf; i++) {
      System.out.println("stack item " + i + " = " + machineStack[i]);
    }
    System.out.println();
    System.exit(1);
  }
  
  private void push(int data) {
    if (sf == MAX_STACK) {
      runError("stack overflow");
    }
    machineStack[sf] = data;
    sf++;
  }
  
  private int pop() {
    if (sf == 0) {
      runError("stack underflow");
    }
    sf--;
    return machineStack[sf];
  }
  
  private int getOp() {
    Instruction instr = instructions[pc];
    int result = 0;
    switch(instr.opType) {
      case stack:
        result = pop();
        break;
      case constant: result = instr.word; break;
      case var:
        if (instr.word < vars.length) {
          debug("\npc=" + pc + " vars[" + instr.word + "]");
          result = vars[instr.word];
        } else {
          runError("undefined variable");
        }
        break;
      default:
        runError("unknown operand type");
    }
    return result;
  }
  
}