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

  // In this Java based interpreter the stack grows up (index increases). This
  // is reverse to a usual stack, which grows down (stack pointer decreases).
  //
  // The following figures tries to explain the stack structure in the JAVA
  // based interpreter, assuming a call to a function with an int return value,
  // a byte parameter and a word parameter and a byte local variable and a word
  // local variable: public int f(byte b, word w) { byte bb; word ww;}
  //
  // Logically BP points to the saved value of the previous BP.
  // But because the JAVA stack uses a zero based index, BP points to the first
  // byte reserved for local variables.
  // ............... index
  // +----------+
  // | ........ |
  // | ........ | <- 0
  // +----------+
  // |byte par. | <- BP - 9
  // +----------+
  // |word par H| <- BP - 8
  // |word par L| <- BP - 7
  // +----------+
  // |ret val H | <- BP - 6
  // |ret val L | <- BP - 5
  // +----------+
  // |ret addr H| <- BP - 4
  // |ret addr L| <- BP - 3
  // +----------+
  // |prev BP H | <- BP - 2
  // |prev BP L | <- BP - 1
  // +----------+
  // |byte var. | <- BP
  // +----------+
  // |word var H| <- BP + 1
  // |word var L| <- BP + 2
  // +----------+
  // | ........ | <- machineStack.size()
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

    if (pc == 744) {
      // breakpoint
      pc++;
      pc--;
    }

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
            stackIndex = basePointer + instr.operand.intValue;
            // compensate for zero-based index.
            stackIndex--;
            if (instr.operand.dataType == DataType.word || instr.operand.dataType == DataType.string) {
              pokeWord(stackIndex, acc16);
            } else if (instr.operand.dataType == DataType.byt) {
              pokeByte(stackIndex, acc16 % 256);
            } else {
              runError("incompatible dataType between assignment variable and expression");
            }
            break;
          case STACK16:
            pushWord(acc16);
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
            stackIndex = basePointer + instr.operand.intValue;
            // compensate for zero-based index.
            stackIndex--;
            pokeWord(stackIndex, peekWord(stackIndex) - 1);
            if (peekWord(stackIndex) < -32768) {
              pokeWord(stackIndex, 32767);
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
            stackIndex = basePointer + instr.operand.intValue;
            // compensate for zero-based index.
            stackIndex--;
            pokeWord(stackIndex, peekWord(stackIndex) + 1);
            if (peekWord(stackIndex) > 32767) {
              pokeWord(stackIndex, -32768);
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
        if (instr.operand.opType == OperandType.STACK8) {
          debug("" + peekByte(machineStack.size() - 1) + "\n");
        } else if (instr.operand.opType == OperandType.STACK16) {
          debug("" + peekWord(machineStack.size() - 1) + "\n");
        } else {
          debug("" + getOp(instr.operand) + "\n");
        }
        branchSet = compare(acc16, getOp(instr.operand));
        break;
      case stackAcc16:
        pushWord(acc16);
        break;
      case stackAcc16Load:
        pushWord(acc16);
        acc16 = getOp(instr.operand);
        break;
      case stackAcc16ToAcc8:
        pushByte(acc8);
        acc8 = acc16 % 256;
        break;
      case stackBasePointer:
        pushWord(basePointer);
        break;
      case stackPointerLoad:
        newValue = getOp(instr.operand);
        while (newValue > machineStack.size()) {
          pushByte(0);
        }
        while (newValue < machineStack.size()) {
          popByte();
        }
        break;
      case stackPointerPlus:
        newValue = machineStack.size() + getOp(instr.operand);
        while (newValue > machineStack.size()) {
          pushByte(0);
        }
        while (newValue < machineStack.size()) {
          popByte();
        }
        break;
      case unstackAcc16:
        acc16 = popWord();
        break;
      case unstackBasePointer:
        basePointer = popWord();
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
            stackIndex = basePointer + instr.operand.intValue;
            // compensate for zero-based index.
            stackIndex--;
            pokeByte(stackIndex, acc8);
            break;
          case STACK8:
            pushByte(acc8);
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
            stackIndex = basePointer + instr.operand.intValue;
            // compensate for zero-based index.
            stackIndex--;
            pokeByte(stackIndex, peekByte(stackIndex) - 1);
            if (peekByte(stackIndex) < 0) {
              pokeByte(stackIndex, 255);
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
            stackIndex = basePointer + instr.operand.intValue;
            // compensate for zero-based index.
            stackIndex--;
            pokeByte(stackIndex, peekByte(stackIndex) + 1);
            if (peekByte(stackIndex) > 255) {
              pokeByte(stackIndex, 0);
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
        if (instr.operand.opType == OperandType.STACK8) {
          debug("" + peekByte(machineStack.size() - 1) + "\n");
        } else if (instr.operand.opType == OperandType.STACK16) {
          debug("" + peekWord(machineStack.size() - 1) + "\n");
        } else {
          debug("" + getOp(instr.operand) + "\n");
        }
        branchSet = compare(acc8, getOp(instr.operand));
        break;
      case stackAcc8:
        pushByte(acc8);
        break;
      case stackAcc8Load:
        pushByte(acc8);
        acc8 = getOp(instr.operand);
        break;
      case stackAcc8ToAcc16:
        pushWord(acc16);
        acc16 = acc8;
        break;
      case unstackAcc8:
        acc8 = popByte();
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
        pushWord(pc);
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
        pc = popWord();
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
  } // step()

  private void debug(String message) {
    if (debugMode) {
      System.out.print(message);
    }
  } // debug()

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
  } // runError()

  private void pushByte(int data) {
    if (machineStack.size() == MAX_STACK) {
      runError("stack overflow");
    }
    machineStack.push(data % 256);
  }

  private void pushWord(int data) {
    // high byte
    pushByte(data / 256);
    // low byte
    pushByte(data);
  }

  private int popByte() {
    if (machineStack.size() == 0) {
      runError("stack underflow");
    }
    return machineStack.pop();
  }

  private int popWord() {
    int lowByte = popByte();
    int highByte = popByte();
    return highByte * 256 + lowByte;
  }

  private int peekByte(int index) {
    if (index < 0) {
      runError("stack underflow");
    }
    if (index >= machineStack.size()) {
      runError("stack overflow");
    }
    return machineStack.get(index);
  }

  private int peekWord(int index) {
    int lowByte = peekByte(index);
    int highByte = peekByte(index - 1);
    return highByte * 256 + lowByte;
  }

  private void pokeByte(int index, int value) {
    if (index >= machineStack.size()) {
      runError("stack underflow");
    }
    machineStack.set(index, value % 256);
  }

  private void pokeWord(int index, int value) {
    // low byte
    pokeByte(index, value);
    // high byte
    pokeByte(index - 1, value / 256);
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
        stackIndex = basePointer + operand.intValue;
        // compensate for zero-based index.
        stackIndex--;
        if (operand.isFinal) {
          debug("pc=" + pc + " final var " + operand.strValue + " = " + operand.intValue + "\n");
          result = operand.intValue;
        } else {
          if (operand.dataType == DataType.byt) {
            result = peekByte(stackIndex);
          } else {
            result = peekWord(stackIndex);
          }

          debug("pc=" + pc + " stack[" + basePointer);
          if (operand.intValue >= 0) {
            debug(" - " + operand.intValue);
          } else {
            debug(" + " + (-operand.intValue));
          }
          debug("] = " + result + "\n");
        }
        break;
      case STACK16:
        result = popWord();
        break;
      case STACK8:
        result = popByte();
        break;
      case STACK_POINTER:
        result = machineStack.size();
        break;
      default:
        runError("unknown operand type: " + operand.opType);
    }
    return result;
  } // getOp()

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
  } // compare()

}
