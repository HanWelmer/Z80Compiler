import java.util.ArrayList;
import java.util.EnumSet;
import java.util.Stack;

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
  private Stack<Integer> machineStack;
  private int[] vars;
  private int pc;
  private int acc16;
  private int acc8;

  //constructor
  public Interpreter(boolean debugMode, ArrayList<Instruction> instructions, String[] inputParts) {
    this.debugMode = debugMode;
    this.instructions = instructions;
    this.inputParts = inputParts;
    
    /* initialize interpreter*/
    machineStack = new Stack<Integer>();

    vars = new int[MAX_VARS];
    branchSet.clear();
    pc = 0;
    acc16 = 0;
    acc8 = 0;
  }

  /* interface method: execute a single instruction */
  public boolean step() {
    boolean stopRun = false;

    //get next instruction
    Instruction instr = instructions.get(pc);
    //execute instruction
    int operand;
    switch(instr.function){
      // single line comment
      case comment : break;
      // 16-bit arithmetic:
      case acc16Load: acc16 = getOp(); break;
      case stackAcc16Load:
        push(acc16);
        acc16 = getOp();
        break;
      case acc16Plus: acc16 += getOp(); break;
      case acc16Minus: acc16 -= getOp(); break;
      case minusAcc16: acc16 = getOp() - acc16; break;
      case acc16Times: acc16 *= getOp(); break;
      case acc16Div:
        operand = getOp();
        if (operand == 0) {
          runError("division by zero");
        }
        acc16 = acc16 / operand;
        break;
      case divAcc16:
        if (acc16 == 0) {
          runError("division by zero");
        }
        acc16 = getOp() / acc16;
        break;
      case acc16Store:
        switch(instr.operand.opType) {
          case constant:
            runError("illegal operand");
            break;
          case var:
            if ((instr.operand.intValue < 0) || (instr.operand.intValue >= vars.length)) {
              runError("too many variables");
            }
            if (instr.operand.datatype == Datatype.word) {
              vars[instr.operand.intValue] = acc16;
            } else if (instr.operand.datatype == Datatype.byt) {
              vars[instr.operand.intValue] = acc16 % 256;
            } else {
              runError("incompatible datatype between assignment variable and expression");
            }
            break;
          case stack16:
            push(acc16);
            break;
          default:
            runError("unknown operand type");
        } // switch(instr.operand.opType)
        break;
      case increment16:
        switch(instr.operand.opType) {
          case var:
            if ((instr.operand.intValue < 0) || (instr.operand.intValue >= vars.length)) {
              runError("too many variables");
            }
            vars[instr.operand.intValue] = vars[instr.operand.intValue] + 1;
            if (vars[instr.operand.intValue] > 32767) {
              vars[instr.operand.intValue] = -32768;
            }
            break;
          default:
            runError("invalid operand type for decrement instruction");
        } // switch(instr.operand.opType)
        break;
      case decrement16:
        switch(instr.operand.opType) {
          case var:
            if ((instr.operand.intValue < 0) || (instr.operand.intValue >= vars.length)) {
              runError("too many variables");
            }
            vars[instr.operand.intValue] = vars[instr.operand.intValue] - 1;
            if (vars[instr.operand.intValue] < -32768) {
              vars[instr.operand.intValue] = 32767;
            }
            break;
          default:
            runError("invalid operand type for decrement instruction");
        } // switch(instr.operand.opType)
        break;
      case acc16Compare: //normal compare
        debug("        acc16=" + acc16 + ", operand=" + getOp() + "\n");
        branchSet = compare(acc16, getOp());
        break;
      case revAcc16Compare: //reverse compare
        debug(" acc16=" + acc16 + ", operand=");
        if (getOpType() == OperandType.stack16 || getOpType() == OperandType.stack8) {
          debug("" + peek() + "\n");
        } else {
          debug("" + getOp() + "\n");
        }
        branchSet = compare(acc16, getOp());
        break;
      case acc16CompareAcc8: //normal compare
        debug(" acc16=" + acc16 + ", acc8=" + acc8 + "\n");
        branchSet = compare(acc16, acc8);
        break;
      case acc8CompareAcc16: //reverse compare
        debug(" acc8=" + acc8 + ", acc16=" + acc16 + "\n");
        branchSet = compare(acc8, acc16);
        break;
      // 8-bit arithmetic:
      case acc8Load: acc8 = getOp(); break;
      case stackAcc8Load:
        push(acc8);
        acc8 = getOp();
        break;
      case acc8Plus: acc8 += getOp(); break;
      case acc8Minus: acc8 -= getOp(); break;
      case minusAcc8: acc8 = getOp() - acc8; break;
      case acc8Times: acc8 *= getOp(); break;
      case acc8Div:
        operand = getOp();
        if (operand == 0) {
          runError("division by zero");
        }
        acc8 = acc8 / operand;
        break;
      case divAcc8:
        if (acc8 == 0) {
          runError("division by zero");
        }
        acc8 = getOp() / acc8;
        break;
      case acc8Store:
        switch(instr.operand.opType) {
          case constant:
            runError("illegal operand");
            break;
          case var:
            if ((instr.operand.intValue < 0) || (instr.operand.intValue >= vars.length)) {
              runError("too many variables");
            }
            vars[instr.operand.intValue] = acc8;
            break;
          case stack8:
            push(acc8);
            break;
          default:
            runError("unknown operand type");
        } // switch(instr.operand.opType)
        break;
      case increment8:
        switch(instr.operand.opType) {
          case var:
            if ((instr.operand.intValue < 0) || (instr.operand.intValue >= vars.length)) {
              runError("too many variables");
            }
            vars[instr.operand.intValue] = vars[instr.operand.intValue] + 1;
            if (vars[instr.operand.intValue] > 255) {
              vars[instr.operand.intValue] = 0;
            }
            break;
          default:
            runError("invalid operand type for decrement instruction");
        } // switch(instr.operand.opType)
        break;
      case decrement8:
        switch(instr.operand.opType) {
          case var:
            if ((instr.operand.intValue < 0) || (instr.operand.intValue >= vars.length)) {
              runError("too many variables");
            }
            vars[instr.operand.intValue] = vars[instr.operand.intValue] - 1;
            if (vars[instr.operand.intValue] < 0) {
              vars[instr.operand.intValue] = 255;
            }
            break;
          default:
            runError("invalid operand type for decrement instruction");
        } // switch(instr.operand.opType)
        break;
      case acc8Compare: //normal compare
        debug(" acc8=" + acc8 + ", operand=" + getOp() + "\n");
        branchSet = compare(acc8, getOp());
        break;
      case revAcc8Compare: //reverse compare
        debug(" acc8=" + acc8 + ", operand=");
        if (getOpType() == OperandType.stack16 || getOpType() == OperandType.stack8) {
          debug("" + peek() + "\n");
        } else {
          debug("" + getOp() + "\n");
        }
        branchSet = compare(acc8, getOp());
        break;
      case acc8ToAcc16:
        acc16 = acc8;
        break;
      case acc16ToAcc8:
        acc8 = acc16 % 256;
        break;
      case stackAcc8ToAcc16:
        push(acc16);
        acc16 = acc8;
        break;
      case stackAcc16ToAcc8:
        push(acc8);
        acc8 = acc16 % 256;
        break;
      case stackAcc16:
        push(acc16);
        break;
      case stackAcc8:
        push(acc8);
        break;
      case unstackAcc16:
        acc16 = pop();
        break;
      case unstackAcc8:
        acc8 = pop();
        break;
      // branch instructions:
      case br: 
          pc = instr.operand.intValue - 1;
        break;
      case brEq:
      case brNe:
      case brLt:
      case brLe:
      case brGt:
      case brGe:
        debug(" branch=" + instr.function + " branchSet=" + branchSet + "\n");
        if (branchSet.contains(instr.function)) {
          pc = instr.operand.intValue - 1;
        }
        break;
      // special instructions:
      case call:
        pc = instr.operand.intValue - 1;
        break;
      case read:
          System.out.print("\nread:");
          boolean consoleInput = true;
          if (consoleInput) {
            try {
              String str =  System.console().readLine();
              acc16 = Integer.parseInt(str);
            } catch (RuntimeException e) {
              runError("read exception:" + e.getMessage());
              acc16 = 0;
              stopRun = true;
            }
          } else {
            if (inputIndex >= inputParts.length) {
              runError("read beyond input");
              acc16 = 0;
              stopRun = true;
            }
            acc16 = Integer.parseInt(inputParts[inputIndex++]);
          }
          break;
      case writeAcc8:
          if (debugMode) {
            debug(acc8 + "\n");
          } else {
            System.out.println(acc8);
          }
          break;
      case writeAcc16:
          if (debugMode) {
            debug(acc16 + "\n");
          } else {
            System.out.println(acc16);
          }
          break;
      case writeString:
          if (debugMode) {
            debug(instr.operand.strValue + "\n");
          } else {
            System.out.println(instr.operand.strValue);
          }
          break;
      case stop:
        stopRun = true;
        break;
      default:
        runError("unknown function " + instr.function);
        break;
    } // switch(instr.function)
    
    //truncate 8=bit and 16-bit accumulator
    acc8 %= 256;
    while (acc16 > 32767) {
      acc16 -= 65536;
    }
    while (acc16 < -32768) {
      acc16 += 65536;
    }

    //log pc, instruction and registers (latter after executing the instruction).
    debug(String.format("pc= %4d %-80s sp=%4d acc16=%5d acc8=%3d stack=%s", 
      pc, instr.toString().substring(0, Math.min(instr.toString().length(), 80)), 
      machineStack.size(), acc16, acc8, machineStack));

    //proceed to next instruction
    pc++;

    //return true if Stop instruction has been executed or if a fatal error occurred.
    debug("\n");
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
    System.out.println(String.format("accumulator 16-bit= " + acc16));
    System.out.println(String.format("accumulator  8-bit= " + acc8));
    System.out.println(String.format("stackpointer      = " + machineStack.size()));
    System.out.println();

    /* dump variables */
    for (int i = 0; i < vars.length; i++) {
      System.out.println("variable " + String.format("%2d", i) + " = " + vars[i]);
    }
    System.out.println();

    /* dump stack */
    int spDigits = (int)(java.lang.Math.log(machineStack.size()) / java.lang.Math.log(10)) + 1;
    String spFormat = "%" + spDigits + "d";
    for (int i = 0; i<machineStack.size(); i++) {
      System.out.println("stack item " + String.format(spFormat, i) + " = " + machineStack.get(i));
    }
    System.out.println();

    System.exit(1);
  }
  
  private void push(int data) {
    if (machineStack.size() == MAX_STACK) {
      runError("stack overflow");
    }
    machineStack.push(data);
  }
  
  private int pop() {
    if (machineStack.size() == 0) {
      runError("stack underflow");
    }
    return machineStack.pop();
  }
  
  private int peek() {
    if (machineStack.size() == 0) {
      runError("stack underflow");
    }
    return machineStack.get(machineStack.size() - 1);
  }
  
  private OperandType getOpType() {
    return instructions.get(pc).operand.opType;
  }
  
  private int getOp() {
    Instruction instr = instructions.get(pc);
    int result = 0;
    switch(instr.operand.opType) {
      case stack8:
      case stack16:
        result = pop();
        break;
      case constant: result = instr.operand.intValue; break;
      case var:
        if (instr.operand.intValue < vars.length) {
          debug("pc=" + pc + " vars[" + instr.operand.intValue + "] = " + vars[instr.operand.intValue] + "\n");
          result = vars[instr.operand.intValue];
        } else {
          runError("undefined variable");
        }
        break;
      case acc:
        if (instr.operand.datatype == Datatype.byt) {
          result = acc8;
        } else if (instr.operand.datatype == Datatype.word) {
          result = acc16;
        }
        break;
      default:
        runError("unknown operand type");
    }
    return result;
  }
  
  private EnumSet<FunctionType> compare(int accu, int operand) {
    EnumSet<FunctionType> result = EnumSet.noneOf(FunctionType.class);
    if (accu == operand) {
      result = EnumSet.of(FunctionType.brEq);
    } else {
      result = EnumSet.of(FunctionType.brNe);
    }

    if (accu < operand) {
      result.add(FunctionType.brLt);
    } else {
      result.add(FunctionType.brGe);
    }

    if (accu <= operand) {
      result.add(FunctionType.brLe);
    } else {
      result.add(FunctionType.brGt);
    }
    return result;
  }
  
}
