import java.util.ArrayList;
import java.util.EnumSet;

/**
 * Interpreter for the M machine, as described in Compiler Engineering Using Pascal by P.C. Capon and P.J. Jinks.
 */
public class Interpreter {
  
  /* global variables set by the constructor */
  private ArrayList<Instruction> instructions;
  private String[] inputParts;

  /* constants */
  private static final int MAX_STACK = 128;
  private static final int MAX_VARS = 26;
  
  /* global variables */
  private EnumSet<FunctionType> branchSet = EnumSet.noneOf(FunctionType.class);
  private boolean debugMode = false;
  private int inputIndex = 0;
  private int[] machineStack;
  private int[] vars;
  private int pc, acc, sf;

  //constructor
  public Interpreter(ArrayList<Instruction> instructions, String[] inputParts) {
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

  /* interface method: execute a single instruction */
  public boolean step(boolean debugMode) {
    this.debugMode = debugMode;
    boolean stopRun = false;

    //get next instruction
    Instruction instr = instructions.get(pc);
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
              runError("too many variables");
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
      case call:
        pc = instr.word - 1;
        break;
      case read:
          System.out.print("\nread:");
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
          break;
      case write:
          System.out.println(pop());
          break;
      case stop:
        stopRun = true;
        break;
    } // switch(instr.function)
    
    //proceed to next instruction
    pc++;

    //log stackpointer value
    debug("\nsf = " + sf);

    //return true if Stop instruction has been executed or if a fatal error occurred.
    return stopRun;
  } // interpret()

  private void debug(String message) {
    if (debugMode) {
      System.out.print(message);
    }
  }

  private void runError(String message) {
    System.out.println();
    System.out.println("*** runtime error: " + message);
    System.out.println("pc=" + pc + " : " + instructions.get(pc).toString());
    System.out.println(String.format("accumulator = " + acc));
    System.out.println(String.format("stackpointer= " + sf));
    System.out.println();

    /* dump variables */
    for (int i = 0; i < vars.length; i++) {
      System.out.println("variable " + String.format("%2d", i) + " = " + vars[i]);
    }
    System.out.println();

    /* dump stack */
    int sfDigits = (int)(java.lang.Math.log(sf) / java.lang.Math.log(10)) + 1;
    String sfFormat = "%" + sfDigits + "d";
    for (int i = 0; i<sf; i++) {
      System.out.println("stack item " + String.format(sfFormat, i) + " = " + machineStack[i]);
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
    Instruction instr = instructions.get(pc);
    int result = 0;
    switch(instr.opType) {
      case stack:
        result = pop();
        break;
      case constant: result = instr.word; break;
      case var:
        if (instr.word < vars.length) {
          debug("\npc=" + pc + " vars[" + instr.word + "] = " + vars[instr.word]);
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
