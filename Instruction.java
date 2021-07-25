import java.util.ArrayList;
/**
 * This class defines an instruction for the M machine as generated by the P language.
 * Used in the code generation phase of the compiler.
 */
public class Instruction {
  public FunctionType function;
  public Operand operand;
  
  public Instruction(FunctionType fn) {
    function = fn;
    
    //error detection (internal compiler errors):
    if (function != FunctionType.stop
      && function != FunctionType.read
      && function != FunctionType.writeAcc8
      && function != FunctionType.writeAcc16
      && function != FunctionType.acc16CompareAcc8
      && function != FunctionType.acc8ToAcc16
      && function != FunctionType.acc16ToAcc8
      && function != FunctionType.stackAcc8ToAcc16
      && function != FunctionType.stackAcc16ToAcc8) {
      throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
    }
  }

  public Instruction(FunctionType fn, Operand operand) {
    function = fn;
    
    //error detection (internal compiler errors):
    switch (function) {
      case stop:
      case read:
      case writeAcc8:
      case writeAcc16:
      case acc8ToAcc16:
      case acc16ToAcc8:
      case stackAcc16ToAcc8:
      case stackAcc8ToAcc16:
        throw new RuntimeException("Internal compiler error: functionType " + fn + " expects no operand.");
        //break;
      case call:
        throw new RuntimeException("Internal compiler error: functionType " + fn + " not yet implemented.");
        //break;
      case comment:
        if (operand == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
        };
        if (operand.opType != OperandType.constant) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects a constant operand.");
        };
        if (operand.datatype != Datatype.string || operand.strValue == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects a string constant operand.");
        };
        break;
      case acc16Store:
      case acc8Store:
        if (operand == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
        }
        if (operand.opType != OperandType.stack && operand.opType != OperandType.var ) {
          throw new RuntimeException("Internal compiler error: illegal operand type " + operand.opType + " for functionType " + fn + ".");
        }
        if (operand.opType == OperandType.var && operand.intValue == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an address for its variable operand.");
        }
        break;
      case stackAcc16Load:
      case stackAcc8Load:
        if (operand != null && operand.opType == OperandType.stack) {
          throw new RuntimeException("Internal compiler error: illegal stack operand for functionType " + fn + ".");
        }
        //ga verder met controles voor non-stack load.
      case acc16Load:
      case acc8Load:
        if (operand == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
        }
        if (operand.opType == OperandType.stack) {
          // no error.
        } else if (operand.opType == OperandType.constant && operand.intValue != null) {
          // no error.
        } else if (operand.opType == OperandType.var && operand.intValue != null) {
          // no error.
        } else if (operand.opType == OperandType.acc && (operand.datatype == Datatype.byt || operand.datatype == Datatype.integer)) {
          // no error.
        } else {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " with " + operand + ".");
        }
        break;
      case acc16Plus:
      case acc16Minus:
      case minusAcc16:
      case acc16Times:
      case acc16Div:
      case divAcc16:
      case acc16Compare: //normal compare
      case compareAcc16: //reverse compare
        if (operand == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
        }
        switch(operand.opType) {
          case stack:
            break;
          case constant:
            if (operand.datatype != Datatype.byt && operand.datatype != Datatype.integer) {
              throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an integer or byte datatype for its constant operand.");
            }
            if (operand.intValue == null) {
              throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an integer value for its constant operand.");
            }
            break;
          case var:
            if (operand.intValue == null) {
              throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an address for its variable operand.");
            }
            break;
          case acc:
            if (operand.datatype == Datatype.byt) {
              // no error.
            } else {
              throw new RuntimeException("Internal compiler error: functionType " + fn + " with " + operand + ".");
            }
            break;
          default:
            new RuntimeException("unknown operand type");
        }
        break;
      case acc8Plus:
      case acc8Minus:
      case minusAcc8:
      case acc8Times:
      case acc8Div:
      case divAcc8:
      case acc8Compare:
      case compareAcc8:
        if (operand == null) {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an operand.");
        }
        switch(operand.opType) {
          case stack:
            break;
          case constant:
            if (operand.datatype != Datatype.byt && operand.datatype != Datatype.integer) {
              throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an integer or byte datatype for its constant operand.");
            }
            if (operand.intValue == null) {
              throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an integer value for its constant operand.");
            }
            break;
          case var:
            if (operand.intValue == null) {
              throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an address for its variable operand.");
            }
            break;
          case acc:
            if (operand.datatype == Datatype.integer) {
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
        if (operand != null && operand.opType == OperandType.var) {
          if (operand.intValue == null) {
            throw new RuntimeException("Internal compiler error: functionType " + fn + " expects an address for its variable operand.");
          }
        } else {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects a variable as operand.");
        };
        break;
      case br:
      case brEq:
      case brNe:
      case brLt:
      case brLe:
      case brGt:
      case brGe:
        if (operand != null && operand.opType == OperandType.label) {
          if (operand.intValue == null) {
            throw new RuntimeException("Internal compiler error: functionType " + fn + " expects the address of a label to jump to.");
          }
        } else {
          throw new RuntimeException("Internal compiler error: functionType " + fn + " expects a label to jump to.");
        };
        break;
      default :
        throw new RuntimeException("Internal compiler error: unknown functionType " + fn);
    }
    
    //deep copy of operand, otherwise a reference to the mutable object operand is copied into the Instruction.
    if (operand.datatype == Datatype.integer || operand.datatype == Datatype.byt) {
      this.operand = new Operand(operand.opType, operand.datatype, operand.intValue);
    } else {
      this.operand = new Operand(operand.opType, operand.datatype, operand.strValue);
    }
  }
  
  public String toString() {
    String result = function.getValue();
    switch (function) {
      case comment: result += operand.strValue; break;
      case acc16Store:
      case acc8Store:
        switch(operand.opType) {
          case var: result += " variable " + operand.intValue; break;
          case stack: result += " stack"; break;
          default: throw new RuntimeException("accStore with unsupported operandType");
        };
        break;
      case acc16Load:
      case stackAcc16Load:
      case acc16Plus:
      case acc16Minus:
      case minusAcc16:
      case acc16Times:
      case acc16Div:
      case divAcc16:
      case acc16Compare: //normal compare
      case compareAcc16: //reverse compare
      case acc8Load:
      case stackAcc8Load:
      case acc8Plus:
      case acc8Minus:
      case minusAcc8:
      case acc8Times:
      case acc8Div:
      case divAcc8:
      case acc8Compare: //normal compare
      case compareAcc8: //reverse compare
        switch(operand.opType) {
          case var: result += " variable " + operand.intValue; break;
          case constant: result += " constant " + operand.intValue; break;
          case stack: result += " unstack"; break;
          case acc: 
            if (operand.datatype == Datatype.byt) {
              result += " acc8";
            } else if (operand.datatype == Datatype.integer) {
              result += " acc16";
            }
            break;
          default: throw new RuntimeException("accu related instruction with unsupported operandType");
        };
        break;
      case increment16:
      case decrement16:
      case increment8:
      case decrement8:
        switch(operand.opType) {
          case var: result += " variable " + operand.intValue; break;
          default: throw new RuntimeException(result + " instruction with non-var operandType");
        };
        break;
      case acc16ToAcc8: break;
      case acc8ToAcc16: break;
      case stackAcc16ToAcc8: break;
      case stackAcc8ToAcc16: break;
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
      case read:
        result = "call read";
        break;
      case writeAcc8:
        result = "call writeAcc8";
        break;
      case writeAcc16:
        result = "call writeAcc16";
        break;
      case acc16CompareAcc8:
      case stop: 
        break;
      default: throw new RuntimeException("unsupported instruction");
    }
    return result;
  }
}
