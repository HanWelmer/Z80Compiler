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

import java.util.ArrayList;
import java.util.EnumSet;
import java.util.Stack;

/**
 * Interpreter for the M machine, as described in Compiler Engineering Using
 * Pascal by P.C. Capon and P.J. Jinks.
 */
public class Interpreter {

  /* global variables set by the constructor */
  private ArrayList<Instruction> instructions;
  private String[] inputParts;

  // constants
  private static final int MAX_STACK = 128;
  private static final int MAX_VARS = 26;

  // stack for method return addresses, actual parameters and local variables.
  private Stack<Integer> machineStack;
  private int basePointer;

  // Stack structure is as follows:
  // Please note that indexes relative to base pointer are reversed to what one
  // would expect.
  // +----------+
  // | ........ | index 0
  // | ........ |
  // +----------+
  // |byte par. | <-BASE_POINTER - 7 (optional)
  // +----------+
  // |word par H|
  // |word par L| <-BASE_POINTER - 6 (optional)
  // +----------+
  // |ret val H |
  // |ret val L | <-BASE_POINTER - 4 (optional)
  // +----------+
  // |ret addr H|
  // |ret addr L| <-BASE_POINTER - 2
  // +----------+
  // |prev BP H |
  // |prev BP L | <-BASE_POINTER
  // +----------+
  // |byte var. | <-BASE_POINTER + 1 (optional)
  // +----------+
  // |word var H|
  // |word var L| <-BASE_POINTER + 3 (optional)
  // +----------+
  // | stack... | index (machineStack.size() - 1)
  // +----------+

  /* global variables */
  private boolean debugMode = false;
  private EnumSet<FunctionType> branchSet = EnumSet.noneOf(FunctionType.class);
  private int inputIndex = 0;
  private int[] vars;
  private int pc;
  private int acc16;
  private int acc8;

  // constructor
  public Interpreter(boolean debugMode, ArrayList<Instruction> instructions, String[] inputParts) {
    this.debugMode = debugMode;
    this.instructions = instructions;
    this.inputParts = inputParts;

    /* initialize interpreter */
    machineStack = new Stack<Integer>();
    vars = new int[MAX_VARS];
    branchSet.clear();
    acc16 = 0;
    acc8 = 0;
    pc = 0;
    basePointer = 0;
  }

  /* interface method: execute a single instruction */
  public int step(int pc) {
    boolean consoleInput = !debugMode;

    // get next instruction
    Instruction instr = instructions.get(pc);

    // log pc and instruction to be executed.
    debug(String.format("pc= %4d %-80s", pc, instr.toString().substring(0, Math.min(instr.toString().length(), 80))));

    // by default move PC to next instruction.
    pc++;

    // execute instruction
    int operand;
    int portNumber;
    int stackIndex;
    int newValue;
    String str;
    switch (instr.function) {
      /***********************
       * single line comment:
       ***********************/
      case comment:
        break;
      /***********************
       * declarations:
       ***********************/
      case packageFunction:
      case importFunction:
      case classFunction:
      case method:
        // ignore declaration functions during execution phase.
        break;
      /***********************
       * 16-bit arithmetic:
       ***********************/
      case acc16And:
        acc16 &= getOp(instr.operand);
        break;
      case acc16Compare: // normal compare
        debug("        acc16=" + acc16 + ", operand=" + getOp(instr.operand) + "\n");
        branchSet = compare(acc16, getOp(instr.operand));
        break;
      case acc16CompareAcc8: // normal compare
        debug(" acc16=" + acc16 + ", acc8=" + acc8 + "\n");
        branchSet = compare(acc16, acc8);
        break;
      case acc8CompareAcc16: // reverse compare
        debug(" acc8=" + acc8 + ", acc16=" + acc16 + "\n");
        branchSet = compare(acc8, acc16);
        break;
      case acc16Div:
        operand = getOp(instr.operand);
        if (operand == 0) {
          runError("division by zero");
        }
        acc16 = acc16 / operand;
        break;
      case acc16Load:
        acc16 = getOp(instr.operand);
        break;
      case acc16Minus:
        acc16 -= getOp(instr.operand);
        break;
      case acc16Or:
        acc16 |= getOp(instr.operand);
        break;
      case acc16Plus:
        acc16 += getOp(instr.operand);
        break;
      case acc16Store:
        switch (instr.operand.opType) {
          case CONSTANT:
            runError("illegal operand");
            break;
          case GLOBAL_VAR:
            if ((instr.operand.intValue < 0) || (instr.operand.intValue >= vars.length)) {
              runError("too many variables");
            }
            if (instr.operand.dataType == DataType.word || instr.operand.dataType == DataType.string) {
              vars[instr.operand.intValue] = acc16;
            } else if (instr.operand.dataType == DataType.byt) {
              vars[instr.operand.intValue] = acc16 % 256;
            } else {
              runError("incompatible dataType between assignment variable and expression");
            }
            break;
          case LOCAL_VAR:
            stackIndex = basePointer - instr.operand.intValue;
            if (stackIndex < 0) {
              runError(String.format("stack error: basePointer=%d, index=%d", basePointer, instr.operand.intValue));
            }
            if (instr.operand.dataType == DataType.word || instr.operand.dataType == DataType.string) {
              machineStack.set(stackIndex - 1, acc16);
            } else if (instr.operand.dataType == DataType.byt) {
              machineStack.set(stackIndex - 1, acc16 % 256);
            } else {
              runError("incompatible dataType between assignment variable and expression");
            }
            break;
          case STACK16:
            push(acc16);
            break;
          default:
            runError("unknown operand type");
        } // switch(instr.operand.opType)
        break;
      case acc16Times:
        acc16 *= getOp(instr.operand);
        break;
      case acc16ToAcc8:
        acc8 = acc16 % 256;
        break;
      case acc16Xor:
        acc16 ^= getOp(instr.operand);
        break;
      case basePointerLoad:
        basePointer = getOp(instr.operand);
        break;
      case decrement16:
        switch (instr.operand.opType) {
          case GLOBAL_VAR:
            if ((instr.operand.intValue < 0) || (instr.operand.intValue >= vars.length)) {
              runError("too many variables");
            }
            vars[instr.operand.intValue] = vars[instr.operand.intValue] - 1;
            if (vars[instr.operand.intValue] < -32768) {
              vars[instr.operand.intValue] = 32767;
            }
            break;
          case LOCAL_VAR:
            stackIndex = basePointer - instr.operand.intValue;
            if (stackIndex < 0) {
              runError(String.format("stack error: basePointer=%d, index=%d", basePointer, instr.operand.intValue));
            }
            machineStack.set(stackIndex - 1, machineStack.get(stackIndex - 1) - 1);
            if (machineStack.get(stackIndex - 1) < -32768) {
              machineStack.set(stackIndex - 1, 32767);
            }
            break;
          default:
            runError("invalid operand type for decrement instruction");
        } // switch(instr.operand.opType)
        break;
      case divAcc16:
        if (acc16 == 0) {
          runError("division by zero");
        }
        acc16 = getOp(instr.operand) / acc16;
        break;
      case increment16:
        switch (instr.operand.opType) {
          case GLOBAL_VAR:
            if ((instr.operand.intValue < 0) || (instr.operand.intValue >= vars.length)) {
              runError("too many variables");
            }
            vars[instr.operand.intValue] = vars[instr.operand.intValue] + 1;
            if (vars[instr.operand.intValue] > 32767) {
              vars[instr.operand.intValue] = -32768;
            }
            break;
          case LOCAL_VAR:
            stackIndex = basePointer - instr.operand.intValue;
            if (stackIndex < 0) {
              runError(String.format("stack error: basePointer=%d, index=%d", basePointer, instr.operand.intValue));
            }
            machineStack.set(stackIndex - 1, machineStack.get(stackIndex - 1) + 1);
            if (machineStack.get(stackIndex - 1) > 32767) {
              machineStack.set(stackIndex - 1, -32768);
            }
            break;
          default:
            runError("invalid operand type for decrement instruction");
        } // switch(instr.operand.opType)
        break;
      case minusAcc16:
        acc16 = getOp(instr.operand) - acc16;
        break;
      case revAcc16Compare: // reverse compare
        debug(" acc16=" + acc16 + ", operand=");
        if (instr.operand.opType == OperandType.STACK16 || instr.operand.opType == OperandType.STACK8) {
          debug("" + peek() + "\n");
        } else {
          debug("" + getOp(instr.operand) + "\n");
        }
        branchSet = compare(acc16, getOp(instr.operand));
        break;
      case stackAcc16:
        push(acc16);
        break;
      case stackAcc16Load:
        push(acc16);
        acc16 = getOp(instr.operand);
        break;
      case stackAcc16ToAcc8:
        push(acc8);
        acc8 = acc16 % 256;
        break;
      case stackBasePointer:
        push(basePointer);
        break;
      case stackPointerLoad:
        newValue = getOp(instr.operand);
        while (newValue > machineStack.size()) {
          push(0);
        }
        while (newValue < machineStack.size()) {
          pop();
        }
        break;
      case stackPointerPlus:
        newValue = machineStack.size() + getOp(instr.operand);
        while (newValue > machineStack.size()) {
          push(0);
        }
        while (newValue < machineStack.size()) {
          pop();
        }
        break;
      case unstackAcc16:
        acc16 = pop();
        break;
      case unstackBasePointer:
        basePointer = pop();
        break;
      /***********************
       * 8-bit arithmetic:
       ***********************/
      case acc8And:
        acc8 &= getOp(instr.operand);
        break;
      case acc8Compare: // normal compare
        debug(" acc8=" + acc8 + ", operand=" + getOp(instr.operand) + "\n");
        branchSet = compare(acc8, getOp(instr.operand));
        break;
      case acc8Div:
        operand = getOp(instr.operand);
        if (operand == 0) {
          runError("division by zero");
        }
        acc8 = acc8 / operand;
        break;
      case acc8Load:
        acc8 = getOp(instr.operand);
        break;
      case acc8Minus:
        acc8 -= getOp(instr.operand);
        break;
      case acc8Or:
        acc8 |= getOp(instr.operand);
        break;
      case acc8Plus:
        acc8 += getOp(instr.operand);
        break;
      case acc8Store:
        switch (instr.operand.opType) {
          case CONSTANT:
            runError("illegal operand");
            break;
          case GLOBAL_VAR:
            if ((instr.operand.intValue < 0) || (instr.operand.intValue >= vars.length)) {
              runError("too many variables");
            }
            vars[instr.operand.intValue] = acc8;
            break;
          case LOCAL_VAR:
            stackIndex = basePointer - instr.operand.intValue;
            if (stackIndex < 0) {
              runError(String.format("stack error: basePointer=%d, index=%d", basePointer, instr.operand.intValue));
            }
            machineStack.set(stackIndex - 1, acc8);
            break;
          case STACK8:
            push(acc8);
            break;
          default:
            runError("unknown operand type");
        } // switch(instr.operand.opType)
        break;
      case acc8Times:
        acc8 *= getOp(instr.operand);
        break;
      case acc8ToAcc16:
        acc16 = acc8;
        break;
      case acc8Xor:
        acc8 ^= getOp(instr.operand);
        break;
      case decrement8:
        switch (instr.operand.opType) {
          case GLOBAL_VAR:
            if ((instr.operand.intValue < 0) || (instr.operand.intValue >= vars.length)) {
              runError("too many variables");
            }
            vars[instr.operand.intValue] = vars[instr.operand.intValue] - 1;
            if (vars[instr.operand.intValue] < 0) {
              vars[instr.operand.intValue] = 255;
            }
            break;
          case LOCAL_VAR:
            stackIndex = basePointer - instr.operand.intValue;
            if (stackIndex < 0) {
              runError(String.format("stack error: basePointer=%d, index=%d", basePointer, instr.operand.intValue));
            }
            machineStack.set(stackIndex - 1, machineStack.get(stackIndex - 1) - 1);
            if (machineStack.get(stackIndex - 1) < 0) {
              machineStack.set(stackIndex - 1, 255);
            }
            break;
          default:
            runError("invalid operand type for decrement instruction");
        } // switch(instr.operand.opType)
        break;
      case divAcc8:
        if (acc8 == 0) {
          runError("division by zero");
        }
        acc8 = getOp(instr.operand) / acc8;
        break;
      case increment8:
        switch (instr.operand.opType) {
          case GLOBAL_VAR:
            if ((instr.operand.intValue < 0) || (instr.operand.intValue >= vars.length)) {
              runError("too many variables");
            }
            vars[instr.operand.intValue] = vars[instr.operand.intValue] + 1;
            if (vars[instr.operand.intValue] > 255) {
              vars[instr.operand.intValue] = 0;
            }
            break;
          case LOCAL_VAR:
            stackIndex = basePointer - instr.operand.intValue;
            if (stackIndex < 0) {
              runError(String.format("stack error: basePointer=%d, index=%d", basePointer, instr.operand.intValue));
            }
            machineStack.set(stackIndex - 1, machineStack.get(stackIndex - 1) + 1);
            if (machineStack.get(stackIndex - 1) > 255) {
              machineStack.set(stackIndex - 1, 0);
            }
            break;
          default:
            runError("invalid operand type for decrement instruction");
        } // switch(instr.operand.opType)
        break;
      case minusAcc8:
        acc8 = getOp(instr.operand) - acc8;
        break;
      case revAcc8Compare: // reverse compare
        debug(" acc8=" + acc8 + ", operand=");
        if (instr.operand.opType == OperandType.STACK16 || instr.operand.opType == OperandType.STACK8) {
          debug("" + peek() + "\n");
        } else {
          debug("" + getOp(instr.operand) + "\n");
        }
        branchSet = compare(acc8, getOp(instr.operand));
        break;
      case stackAcc8:
        push(acc8);
        break;
      case stackAcc8Load:
        push(acc8);
        acc8 = getOp(instr.operand);
        break;
      case stackAcc8ToAcc16:
        push(acc16);
        acc16 = acc8;
        break;
      case unstackAcc8:
        acc8 = pop();
        break;
      /***********************
       * branch instructions:
       ***********************/
      case br:
        pc = instr.operand.intValue;
        break;
      case brEq:
      case brNe:
      case brLt:
      case brLe:
      case brGt:
      case brGe:
        debug(" branch=" + instr.function + " branchSet=" + branchSet + "\n");
        if (branchSet.contains(instr.function)) {
          pc = instr.operand.intValue;
        }
        break;
      /***********************
       * special instructions:
       ***********************/
      case call:
        if (instr.operand.intValue == 0) {
          runError("runtime error: call to address 0 at " + pc);
        }
        push(pc);
        pc = instr.operand.intValue;
        break;
      // Input and output instructions:
      case input:
        // port must be a constant or a final variable
        portNumber = getOp(instr.operand);
        System.out.print(String.format("\ninput from port 0x%1$02X: ", portNumber));
        if (consoleInput) {
          try {
            acc8 = Integer.parseInt(System.console().readLine());
          } catch (RuntimeException e) {
            runError("read exception:" + e.getMessage());
            acc8 = 0;
          }
        } else {
          if (inputIndex >= inputParts.length) {
            runError("read beyond input");
            acc8 = 0;
          } else {
            acc8 = Integer.parseInt(inputParts[inputIndex++]);
          }
        }
        break;
      case output:
        // port must be a constant or a final variable
        portNumber = getOp(instr.operand);
        str = String.format("\noutput 0x%1$02X to port 0x%2$02X", getOp(instr.operand2), portNumber);
        if (consoleInput) {
          System.out.print(str);
          System.out.print(" Press enter to confirm:");
          System.console().readLine();
        } else {
          debug(str);
        }
        break;
      case read:
        System.out.print("\nread:");
        if (consoleInput) {
          try {
            acc16 = Integer.parseInt(System.console().readLine());
          } catch (RuntimeException e) {
            runError("read exception:" + e.getMessage());
            acc16 = 0;
          }
        } else {
          if (inputIndex >= inputParts.length) {
            runError("read beyond input");
            acc16 = 0;
          } else {
            acc16 = Integer.parseInt(inputParts[inputIndex++]);
          }
        }
        break;
      case returnFunction:
        pc = pop();
        break;
      case stop:
        pc = instructions.size();
        System.out.println("stop");
        break;
      case writeAcc16:
        if (debugMode) {
          debug("" + acc16);
        } else {
          System.out.print(acc16);
        }
        break;
      case writeAcc8:
        if (debugMode) {
          debug("" + acc8);
        } else {
          System.out.print(acc8);
        }
        break;
      case writeLineAcc16:
        if (debugMode) {
          debug(acc16 + "\n");
        } else {
          System.out.println(acc16);
        }
        break;
      case writeLineAcc8:
        if (debugMode) {
          debug(acc8 + "\n");
        } else {
          System.out.println(acc8);
        }
        break;
      case writeLineString:
        str = instructions.get(acc16).operand.strValue;
        if (debugMode) {
          debug(str + "\n");
        } else {
          System.out.println(str);
        }
        break;
      case writeString:
        str = instructions.get(acc16).operand.strValue;
        if (debugMode) {
          debug(str);
        } else {
          System.out.print(str);
        }
        break;
      default:
        runError("unknown function " + instr.function);
        break;
    } // switch(instr.function)

    // truncate 8=bit and 16-bit accumulator
    acc8 %= 256;
    while (acc16 > 32767) {
      acc16 -= 65536;
    }
    while (acc16 < -32768) {
      acc16 += 65536;
    }

    // log registers after instruction has been executed.
    debug(String.format(" sp=%4d bp= %4d acc16=%5d acc8=%3d stack=%s\n", machineStack.size(), basePointer, acc16, acc8,
        machineStack));
    return pc;
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
    int spDigits = (int) (java.lang.Math.log(machineStack.size()) / java.lang.Math.log(10)) + 1;
    String spFormat = "%" + spDigits + "d";
    for (int i = 0; i < machineStack.size(); i++) {
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

  private int getOp(Operand operand) {
    int stackIndex;
    int result = 0;
    switch (operand.opType) {
      case ACC:
        if (operand.dataType == DataType.byt) {
          result = acc8;
        } else if (operand.dataType == DataType.word) {
          result = acc16;
        }
        break;
      case BASE_POINTER:
        result = basePointer;
        break;
      case CONSTANT:
        result = operand.intValue;
        break;
      case GLOBAL_VAR:
        if (operand.isFinal) {
          debug("pc=" + pc + " final var " + operand.strValue + " = " + operand.intValue + "\n");
          result = operand.intValue;
        } else if (operand.intValue < vars.length) {
          debug("pc=" + pc + " vars[" + operand.intValue + "] = " + vars[operand.intValue] + "\n");
          result = vars[operand.intValue];
        } else {
          runError("undefined variable");
        }
        break;
      case LOCAL_VAR:
        stackIndex = basePointer - operand.intValue;
        if (stackIndex < 0) {
          runError(String.format("stack error: basePointer=%d, index=%d", basePointer, operand.intValue));
        }
        if (operand.isFinal) {
          debug("pc=" + pc + " final var " + operand.strValue + " = " + operand.intValue + "\n");
          result = operand.intValue;
        } else if (stackIndex >= 0) {
          debug("pc=" + pc + " stack[" + basePointer);
          if (operand.intValue >= 0) {
            debug(" - " + operand.intValue);
          } else {
            debug(" + " + (-operand.intValue));
          }
          debug("] = " + machineStack.get(stackIndex - 1) + "\n");
          result = machineStack.get(stackIndex - 1);
        } else {
          runError("undefined variable");
        }
        break;
      case STACK8:
      case STACK16:
        result = pop();
        break;
      case STACK_POINTER:
        result = machineStack.size();
        break;
      default:
        runError("unknown operand type: " + operand.opType);
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
