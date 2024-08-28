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

/**
 * This class defines an instruction for the M machine as generated by the P
 * language. Used in the code generation phase of the compiler.
 */
public class Instruction {
  public FunctionType function;
  public Operand operand;
  public Operand operand2;
  public EnumSet<LexemeType> modifiers;
  public ResultType resultType;
  public ArrayList<FormalParameter> formalParameters;

  private EnumSet<FunctionType> noOperand = EnumSet.of(
      // special instructions:
      FunctionType.stop, FunctionType.returnFunction
      // Input and output instructions:
      , FunctionType.read, FunctionType.writeAcc8, FunctionType.writeAcc16, FunctionType.writeString, FunctionType.writeLineAcc8,
      FunctionType.writeLineAcc16, FunctionType.writeLineString
      // 8-bit instructions:
      , FunctionType.acc8CompareAcc16 // reverse compare
      // 16-bit instructions:
      , FunctionType.acc16CompareAcc8 // normal compare
      // 16/8-bit conversion:
      , FunctionType.acc8ToAcc16, FunctionType.acc16ToAcc8, FunctionType.stackAcc8ToAcc16, FunctionType.stackAcc16ToAcc8
      // stack instructions:
      , FunctionType.stackAcc8, FunctionType.stackAcc16, FunctionType.stackBasePointer, FunctionType.unstackAcc8,
      FunctionType.unstackAcc16, FunctionType.unstackBasePointer);

  private EnumSet<FunctionType> oneOperand = EnumSet.of(
      // special instructions:
      FunctionType.stringConstant, FunctionType.comment, FunctionType.call
      // Input and output instructions:
      , FunctionType.input
      // 8-bit instructions:
      , FunctionType.acc8Store, FunctionType.acc8Load, FunctionType.stackAcc8Load, FunctionType.acc8Or, FunctionType.acc8Xor,
      FunctionType.acc8And, FunctionType.acc8Plus, FunctionType.acc8Minus, FunctionType.minusAcc8, FunctionType.acc8Times,
      FunctionType.acc8Div, FunctionType.divAcc8, FunctionType.increment8, FunctionType.decrement8
      // normal 8 bit compare
      , FunctionType.acc8Compare
      // reverse 8 bit compare
      , FunctionType.revAcc8Compare
      // 16-bit instructions:
      , FunctionType.acc16Store, FunctionType.acc16Load, FunctionType.stackAcc16Load, FunctionType.acc16Or, FunctionType.acc16Xor,
      FunctionType.acc16And, FunctionType.acc16Plus, FunctionType.acc16Minus, FunctionType.minusAcc16, FunctionType.acc16Times,
      FunctionType.acc16Div, FunctionType.divAcc16, FunctionType.increment16, FunctionType.decrement16
      // normal 16 bit compare
      , FunctionType.acc16Compare
      // reverse 16 bit compare
      , FunctionType.revAcc16Compare
      // stack and base pointer
      , FunctionType.basePointerLoad, FunctionType.stackPointerLoad, FunctionType.stackPointerPlus

      // branch instructions:
      , FunctionType.br, FunctionType.brEq, FunctionType.brNe, FunctionType.brLt, FunctionType.brLe, FunctionType.brGt,
      FunctionType.brGe);

  private EnumSet<FunctionType> twoOperands = EnumSet.of(
      // Input and output instructions:
      FunctionType.output);

  private EnumSet<FunctionType> labelFunctions = EnumSet.of(FunctionType.packageFunction, FunctionType.importFunction,
      FunctionType.classFunction, FunctionType.method);

  public Instruction(FunctionType fn) {
    function = fn;

    // error detection (internal compiler errors):
    if (oneOperand.contains(function)) {
      throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
    }
    if (twoOperands.contains(function)) {
      throw new RuntimeException("Internal compiler error: functionType " + fn + " expects two operands.");
    }
  } // Instruction(FunctionType fn)

  public Instruction(FunctionType fn, Operand operand) {
    if (noOperand.contains(function)) {
      throw new RuntimeException("Internal compiler error: functionType " + fn + " expects no operands.");
    }
    if (twoOperands.contains(function)) {
      throw new RuntimeException("Internal compiler error: functionType " + fn + " expects two operands.");
    }

    // error detection (internal compiler errors):
    switch (fn) {
      case input:
        if ((operand == null) || (operand.opType != OperandType.CONSTANT) || (operand.dataType != DataType.byt)) {
          throw new RuntimeException(
              "Internal compiler error: functionType " + fn + " expects constant byte value for port parameter.");
        }
        break;
      case comment:
        if (operand == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
        }
        ;
        if (operand.opType != OperandType.CONSTANT) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects a constant operand.");
        }
        ;
        if (operand.dataType != DataType.string || operand.strValue == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects a string constant operand.");
        }
        ;
        break;
      case stringConstant:
        if (operand == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
        }
        ;
        if (operand.intValue == null) {
          throw new RuntimeException("Internal compiler error: " + fn + " needs an intValue.");
        }
        ;
        if (operand.strValue == null) {
          throw new RuntimeException("Internal compiler error: " + fn + " needs an strValue.");
        }
        ;
        break;
      case acc16Store:
        if (operand == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
        }
        if (operand.opType != OperandType.STACK16 && operand.opType != OperandType.GLOBAL_VAR
            && operand.opType != OperandType.LOCAL_VAR) {
          throw new RuntimeException(
              "Internal compiler error: illegal operand type " + operand.opType + " for functionType " + fn + ".");
        }
        if (operand.opType == OperandType.GLOBAL_VAR && operand.intValue == null) {
          throw new RuntimeException(
              "Internal compiler error: functionType " + fn + " expects an address for its global variable operand.");
        }
        if (operand.opType == OperandType.LOCAL_VAR && operand.intValue == null) {
          throw new RuntimeException(
              "Internal compiler error: functionType " + fn + " expects an index for its local variable operand.");
        }
        break;
      case acc8Store:
        if (operand == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
        }
        if (operand.opType != OperandType.STACK8 && operand.opType != OperandType.GLOBAL_VAR
            && operand.opType != OperandType.LOCAL_VAR) {
          throw new RuntimeException(
              "Internal compiler error: illegal operand type " + operand.opType + " for functionType " + fn + ".");
        }
        if (operand.opType == OperandType.GLOBAL_VAR && operand.intValue == null) {
          throw new RuntimeException(
              "Internal compiler error: functionType " + fn + " expects an address for its global variable operand.");
        }
        if (operand.opType == OperandType.LOCAL_VAR && operand.intValue == null) {
          throw new RuntimeException(
              "Internal compiler error: functionType " + fn + " expects an index for its local variable operand.");
        }
        break;
      case stackAcc16Load:
        if (operand != null && operand.opType == OperandType.STACK16) {
          throw new RuntimeException("Internal compiler error: illegal stack operand for functionType " + fn + ".");
        }
        // ga verder met controles voor non-stack load.
      case acc16Load:
        if (operand == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
        }
        if (operand.opType == OperandType.STACK16) {
          // no error.
        } else if (operand.opType == OperandType.CONSTANT && operand.intValue != null) {
          // no error.
        } else if (operand.opType == OperandType.GLOBAL_VAR && operand.intValue != null) {
          // no error.
        } else if (operand.opType == OperandType.LOCAL_VAR && operand.intValue != null) {
          // no error.
        } else if (operand.opType == OperandType.ACC && operand.dataType == DataType.word) {
          // no error.
        } else {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " with " + operand + ".");
        }
        break;
      case stackAcc8Load:
        if (operand != null && operand.opType == OperandType.STACK8) {
          throw new RuntimeException("Internal compiler error: illegal stack operand for functionType " + fn + ".");
        }
        // ga verder met controles voor non-stack load.
      case acc8Load:
        if (operand == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
        }
        if (operand.opType == OperandType.STACK8) {
          // no error.
        } else if (operand.opType == OperandType.CONSTANT && operand.intValue != null) {
          // no error.
        } else if (operand.opType == OperandType.GLOBAL_VAR && operand.intValue != null) {
          // no error.
        } else if (operand.opType == OperandType.LOCAL_VAR && operand.intValue != null) {
          // no error.
        } else if (operand.opType == OperandType.ACC && operand.dataType == DataType.byt) {
          // no error.
        } else {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " with " + operand + ".");
        }
        break;
      case acc16Or:
      case acc16Xor:
      case acc16And:
      case acc16Plus:
      case acc16Minus:
      case minusAcc16:
      case acc16Times:
      case acc16Div:
      case divAcc16:
      case acc16Compare: // normal compare
      case revAcc16Compare: // reverse compare
      case acc8Or:
      case acc8Xor:
      case acc8And:
      case acc8Plus:
      case acc8Minus:
      case minusAcc8:
      case acc8Times:
      case acc8Div:
      case divAcc8:
      case acc8Compare:
      case revAcc8Compare:
        if (operand == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
        }
        switch (operand.opType) {
          case STACK8:
            break;
          case STACK16:
            break;
          case CONSTANT:
            if (operand.dataType != DataType.byt && operand.dataType != DataType.word) {
              throw new RuntimeException(
                  "Internal compiler error: functionType " + fn + " expects an word or byte dataType for its constant operand.");
            }
            if (operand.intValue == null) {
              throw new RuntimeException(
                  "Internal compiler error: functionType " + fn + " expects an word value for its constant operand.");
            }
            break;
          case GLOBAL_VAR:
            if (operand.intValue == null) {
              throw new RuntimeException(
                  "Internal compiler error: functionType " + fn + " expects an address for its global variable operand.");
            }
            break;
          case LOCAL_VAR:
            if (operand.intValue == null) {
              throw new RuntimeException(
                  "Internal compiler error: functionType " + fn + " expects an index for its local variable operand.");
            }
            break;
          case ACC:
            if (operand.dataType == DataType.byt || operand.dataType == DataType.word) {
              // no error.
            } else {
              throw new RuntimeException("Internal compiler error: functionType " + fn + " with " + operand + ".");
            }
            break;
          default:
            new RuntimeException("unknown operand type");
        }
        break;
      case increment16:
      case decrement16:
      case increment8:
      case decrement8:
        if (operand == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects a variable as operand.");
        }
        if (operand.opType == OperandType.GLOBAL_VAR && operand.intValue == null) {
          throw new RuntimeException(
              "Internal compiler error: functionType " + fn + " expects an address for its global variable operand.");
        }
        if (operand.opType == OperandType.LOCAL_VAR && operand.intValue == null) {
          throw new RuntimeException(
              "Internal compiler error: functionType " + fn + " expects an index for its local variable operand.");
        }
        break;
      case stackPointerPlus:
        if ((operand == null) || (operand.opType != OperandType.CONSTANT) || (operand.dataType != DataType.word)) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects constant word value as operand.");
        }
        break;
      case basePointerLoad:
        if ((operand == null) || operand.opType != OperandType.STACK_POINTER) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects stack pointer as operand.");
        }
        break;
      case stackPointerLoad:
        if ((operand == null) || operand.opType != OperandType.BASE_POINTER) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects base pointer as operand.");
        }
        break;
      case br:
      case brEq:
      case brNe:
      case brLt:
      case brLe:
      case brGt:
      case brGe:
      case call:
        if (operand != null && operand.opType == OperandType.LABEL) {
          if (operand.intValue == null) {
            throw new RuntimeException(
                "Internal compiler error: functionType " + fn + " expects the address of a label to jump to.");
          }
        } else {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects a label to jump to.");
        }
        ;
        break;
      default:
        throw new RuntimeException("Internal compiler error: unknown functionType " + fn);
    }

    // copy parameter fn to member function.
    function = fn;
    // deep copy of parameter operand to member operand, otherwise a reference
    // to the mutable object operand is copied into the Instruction.
    this.operand = deepCopy(operand);
  } // Instruction(FunctionType fn, Operand operand)

  public Instruction(FunctionType fn, Operand operand1, Operand operand2) {
    // error detection (internal compiler errors):
    if (noOperand.contains(function)) {
      throw new RuntimeException("Internal compiler error: functionType " + fn + " expects no operands.");
    }
    if (oneOperand.contains(function)) {
      throw new RuntimeException("Internal compiler error: functionType " + fn + " expects one operands.");
    }

    if (fn == FunctionType.output) {
      // Instruction(FunctionType.output, port, value)
      if ((operand1 == null) || (operand1.dataType != DataType.byt)) {
        throw new RuntimeException("Internal compiler error: functionType " + fn + " expects byte value for port parameter.");
      }
      if ((operand2 == null) || (operand2.dataType != DataType.byt)) {
        throw new RuntimeException("Internal compiler error: functionType " + fn + " expects byte value for value parameter.");
      }
    } else {
      throw new RuntimeException("Internal compiler error: functionType " + fn + " doesn't expect two operand.");
    }

    // copy parameter fn to member function.
    function = fn;
    // deep copy of parameter operand to member operand, otherwise a reference
    // to the mutable object operand is copied into the Instruction.
    this.operand = deepCopy(operand1);
    this.operand2 = deepCopy(operand2);
  } // Instruction(FunctionType fn, Operand operand1, Operand operand2)

  public Instruction(FunctionType fn, String identifier, EnumSet<LexemeType> modifiers, ResultType resultType) {
    // copy parameter fn to member function.
    function = fn;

    if (!labelFunctions.contains(function)) {
      throw new RuntimeException("Internal compiler error: functionType " + fn + " is not a label function.");
    }

    // operand contains name of the method.
    operand = new Operand(OperandType.CONSTANT, DataType.string, identifier);
    // copy parameter modifiers and resultType to member fields.
    function = fn;
    this.modifiers = modifiers;
    this.resultType = resultType;
  } // Instruction(fn, identifier, modifiers, resultType)

  protected Operand deepCopy(Operand operand) {
    Operand newOperand;
    if (operand.opType == OperandType.LABEL || operand.dataType == DataType.string) {
      newOperand = new Operand(operand.opType, operand.dataType, operand.intValue);
      newOperand.strValue = operand.strValue;
    } else if (operand.dataType == DataType.word || operand.dataType == DataType.byt) {
      newOperand = new Operand(operand.opType, operand.dataType, operand.intValue);
    } else {
      newOperand = new Operand(operand.opType, operand.dataType, operand.strValue);
    }
    newOperand.isFinal = operand.isFinal;
    return newOperand;
  } // deepCopy

  public String toString() {
    String result = function.getValue();

    if (noOperand.contains(function)) {
      switch (function) {
        case read:
          result = "read";
          break;
        case writeAcc8:
          result = "writeAcc8";
          break;
        case writeAcc16:
          result = "writeAcc16";
          break;
        case writeString:
          result = "writeString";
          break;
        case writeLineAcc8:
          result = "writeLineAcc8";
          break;
        case writeLineAcc16:
          result = "writeLineAcc16";
          break;
        case writeLineString:
          result = "writeLineString";
          break;
        default:
          break;
      }
      return result;
    }

    switch (function) {
      case comment:
        result += operand.strValue;
        break;
      case packageFunction:
      case importFunction:
        // package|import name
        result += " " + operand.strValue;
        break;
      case classFunction:
        // class identifier [public]
        result += " " + operand.strValue + " " + modifiers;
        break;
      case method:
        // method identifier [modifiers] returnType (formalParameters)
        result += " " + operand.strValue + " " + modifiers + " " + resultType.getType();
        result += " (";
        for (FormalParameter formalParameter : formalParameters) {
          result += formalParameter;
        }
        result += ")";
        break;
      case stringConstant:
        result += " " + operand.intValue + " = \"" + operand.strValue + "\"";
        break;
      case acc16Store:
      case acc8Store:
        switch (operand.opType) {
          case GLOBAL_VAR:
            result += " variable " + operand.intValue;
            break;
          case LOCAL_VAR:
            result += String.format(" (basePointer + %d)", operand.intValue);
            break;
          case STACK16:
          case STACK8:
            result += " " + operand.opType;
            break;
          default:
            throw new RuntimeException("accStore with unsupported operandType");
        }
        ;
        break;
      case acc16Load:
      case stackAcc16Load:
      case acc16Or:
      case acc16Xor:
      case acc16And:
      case acc16Plus:
      case acc16Minus:
      case minusAcc16:
      case acc16Times:
      case acc16Div:
      case divAcc16:
      case acc16Compare: // normal compare
      case revAcc16Compare: // reverse compare
      case basePointerLoad:
      case stackPointerLoad:
      case stackPointerPlus:
      case acc8Load:
      case stackAcc8Load:
      case acc8Or:
      case acc8Xor:
      case acc8And:
      case acc8Plus:
      case acc8Minus:
      case minusAcc8:
      case acc8Times:
      case acc8Div:
      case divAcc8:
      case acc8Compare: // normal compare
      case revAcc8Compare: // reverse compare
        switch (operand.opType) {
          case GLOBAL_VAR:
            result += " variable " + operand.intValue;
            break;
          case LOCAL_VAR:
            result += String.format(" (basePointer + %d)", operand.intValue);
            break;
          case CONSTANT:
            if (operand.dataType == DataType.string) {

              // error detection
              if (operand.intValue == null) {
                throw new RuntimeException(
                    String.format("operand.intValue is null at instruction: %s operand: %s", function, operand));
              }
              result += " stringconstant " + operand.intValue;
            } else {
              result += " constant " + operand.intValue;
            }
            break;
          case STACK16:
          case STACK8:
            if (operand.dataType == DataType.byt) {
              result += " unstack8";
            } else if (operand.dataType == DataType.word) {
              result += " unstack16";
            }
            break;
          case ACC:
            if (operand.dataType == DataType.byt) {
              result += " acc8";
            } else if (operand.dataType == DataType.word) {
              result += " acc16";
            }
            break;
          case BASE_POINTER:
            result += " basePointer";
            break;
          case STACK_POINTER:
            result += " stackPointer";
            break;
          default:
            throw new RuntimeException("accu related instruction with unsupported operandType");
        }
        ;
        break;
      case increment16:
      case decrement16:
      case increment8:
      case decrement8:
        switch (operand.opType) {
          case GLOBAL_VAR:
            result += " variable " + operand.intValue;
            break;
          case LOCAL_VAR:
            result += String.format(" (basePointer + %d)", operand.intValue);
            break;
          default:
            throw new RuntimeException(result + " instruction with non-var operandType");
        }
        ;
        break;
      case br:
      case brNe:
      case brEq:
      case brLt:
      case brLe:
      case brGe:
      case brGt:
      case call:
        result += " " + operand.intValue;
        break;
      case input:
        // input: port = operand.
        // Template Z80S180 code:
        // IN0 A,(port)
        switch (operand.opType) {
          case CONSTANT:
            result += String.format(" port 0x%1$02X", operand.intValue);
            break;
          // case var:
          // result += " port variable " + operand.intValue;
          // break;
          // case stack8:
          // result += " port " + operand.opType;
          // break;
          default:
            throw new RuntimeException("input with unsupported operandType for port operand");
        }
        ;
        break;
      case output:
        // output: port = operand, value = operand2.
        // Template Z80S180 code:
        // LD A,value
        // OUT0 (port),A
        switch (operand.opType) {
          case CONSTANT:
            result += String.format(" port 0x%1$02X", operand.intValue);
            break;
          // case var:
          // result += " port variable " + operand.intValue;
          // break;
          // case stack8:
          // result += " port " + operand.opType;
          // break;
          default:
            throw new RuntimeException("output with unsupported operandType for port operand");
        }
        ;
        switch (operand2.opType) {
          case CONSTANT:
            result += String.format(" value 0x%1$02X", operand2.intValue);
            break;
          case ACC:
            if (operand2.dataType == DataType.byt) {
              result += " value acc8";
            } else {
              throw new RuntimeException("output with unsupported dataType for value operand");
            }
            break;
          case GLOBAL_VAR:
            result += ", value variable " + operand2.intValue;
            break;
          case LOCAL_VAR:
            result += String.format(" (basePointer + %d)", operand.intValue);
            break;
          case STACK8:
            result += ", value " + operand2.opType;
            break;
          default:
            throw new RuntimeException("output with unsupported operandType for value operand");
        }
        ;
        break;
      default:
        throw new RuntimeException("unsupported instruction");
    }
    return result;
  } // toString
}
