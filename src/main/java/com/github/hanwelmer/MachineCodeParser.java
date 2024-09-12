package com.github.hanwelmer;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.EnumSet;

public class MachineCodeParser {
  private int pos;

  public MachineCodeParser() {
  }

  public ArrayList<Instruction> readMachineCode(String qualifiedFileName) {
    ArrayList<Instruction> result = new ArrayList<Instruction>();
    try {
      FileReader fr = new FileReader(qualifiedFileName);
      BufferedReader br = new BufferedReader(fr);

      try {
        String line = br.readLine();
        while (line != null) {
          pos = 0;
          result.add(parseLine(line));
          line = br.readLine();
        }
      } catch (IOException e) {
        System.out.println(e.getMessage());
      } finally {
        try {
          br.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
      }

    } catch (FileNotFoundException e) {
      e.printStackTrace();
    }
    return result;
  }

  protected Instruction parseLine(String line) {
    Instruction result = new Instruction(FunctionType.stop);

    // ignore whitespace and line number
    skipSpaces(line);
    int lineNumber = parseNumber(line);
    skipSpaces(line);

    if (pos < line.length() && line.charAt(pos) == ';') {
      pos++;
      if (pos == line.length()) {
        result = new Instruction(FunctionType.comment, new Operand(OperandType.CONSTANT, DataType.string, ""));
      } else {
        result = new Instruction(FunctionType.comment, new Operand(OperandType.CONSTANT, DataType.string, line.substring(pos)));
      }
    } else {
      String keyword = parseKeyword(line);
      FunctionType functionType = FunctionType.valueFor(keyword);
      switch (functionType) {
        /*******************************
         * instructions without operands.
         */
        case acc16CompareAcc8:
        case acc16ToAcc8:
        case acc8CompareAcc16:
        case acc8ToAcc16:
        case read:
        case returnFunction:
        case stackAcc16:
        case stackAcc16ToAcc8:
        case stackAcc8:
        case stackAcc8ToAcc16:
        case stackBasePointer:
        case stop:
        case unstackAcc16:
        case unstackAcc8:
        case unstackBasePointer:
        case writeAcc16:
        case writeAcc8:
        case writeLineAcc16:
        case writeLineAcc8:
        case writeLineString:
        case writeString:
          result = new Instruction(functionType);
          break;
        /*******************************
         * instructions with address operand.
         */
        case br:
        case brEq:
        case brNe:
        case call:
          result = parseCallFunction(line, functionType);
          break;
        /*******************************
         * instructions with one byte operand.
         */
        case acc8And:
        case acc8Compare:
        case acc8Div:
        case acc8Load:
        case acc8Minus:
        case acc8Or:
        case acc8Plus:
        case acc8Store:
        case acc8Times:
        case acc8Xor:
        case decrement8:
        case increment8:
        case stackAcc8Load:
          result = parseFunctionWithByteOperand(line, functionType);
          break;
        /*******************************
         * instructions with one word operand.
         */
        case acc16And:
        case acc16Compare:
        case acc16Load:
        case acc16Minus:
        case acc16Or:
        case acc16Plus:
        case acc16Store:
        case acc16Times:
        case acc16Xor:
        case basePointerLoad:
        case decrement16:
        case stackAcc16Load:
        case stackPointerLoad:
        case stackPointerPlus:
          result = parseFunctionWithWordOperand(line, functionType);
          break;
        /*******************************
         * other instructions with one or more operands.
         */
        case importFunction:
          result = parsePackageOrImportFunction(line, functionType);
          break;
        case input:
          result = parseInputFunction(line);
          break;
        case classFunction:
          result = parseClassFunction(line, functionType);
          break;
        case method:
          result = parseMethod(line, functionType);
          break;
        case output:
          result = parseOutputFunction(line);
          break;
        case packageFunction:
          result = parsePackageOrImportFunction(line, functionType);
          break;
        case stringConstant:
          result = parseStringConstant(line, lineNumber);
          break;
        /*******************************
         * TODO.
         */
        case acc16Div:
        case brGe:
        case brGt:
        case brLe:
        case brLt:
        case divAcc16:
        case divAcc8:
        case increment16:
        case minusAcc16:
        case minusAcc8:
        case revAcc16Compare:
        case revAcc8Compare:
          throw new RuntimeException("Internal error; functionType not implemented yet: " + keyword);
        default:
          throw new RuntimeException("Internal error; not supported functionType: " + keyword);
      }
      skipSpaces(line);
    }
    return result;

  }

  // Parse call n.
  private Instruction parseCallFunction(String line, FunctionType functionType) {
    skipSpaces(line);
    int value = parseNumber(line);
    Operand label = new Operand(OperandType.LABEL, DataType.word, value);
    if (value == 0) {
      label.strValue = parseKeyword(line);
    }
    return new Instruction(functionType, label);
  }

  /**
   * Parse: output port operand1 value operand2
   * 
   * @param line
   *          with M-code. eg 129 output port 0x65 value 0x00
   *          01234567890123456789012345678901 00000000001111111111222222222233
   * @return parsed M-code instruction.
   */
  private Instruction parseOutputFunction(String line) {
    // keyword output has already been read. Read the port and value operands.
    Operand port = parseOperand(line, DataType.byt);
    Operand value = parseOperand(line, DataType.byt);
    return new Instruction(FunctionType.output, port, value);
  }

  /**
   * Parse: input port operand1
   * 
   * @param line
   *          with M-code. eg 204 input port 0x7E 01234567890123456789012
   *          00000000001111111111222
   * @return parsed M-code instruction.
   */
  private Instruction parseInputFunction(String line) {
    // keyword input has already been read. Read the port operand.
    Operand port = parseOperand(line, DataType.byt);
    return new Instruction(FunctionType.input, port);
  }

  private Instruction parseStringConstant(String line, int lineNumber) {
    // stringConstant 0 = "TestImport Klaar"
    skipSpaces(line);
    // skip string ID.
    parseNumber(line);
    skipUntil(line, '"');
    // skip ".
    pos++;

    String string = "";
    while (pos < line.length() && line.charAt(pos) != '"') {
      string += line.charAt(pos++);
    }

    Operand operand = new Operand(OperandType.CONSTANT, DataType.string, string);
    operand.intValue = lineNumber;
    return new Instruction(FunctionType.stringConstant, operand);
  }

  /**
   * Parse acc8= operand function.
   * 
   * @param line
   * @param functionType
   * @return
   */
  private Instruction parseFunctionWithByteOperand(String line, FunctionType functionType) {
    Instruction result;
    skipSpaces(line);
    Operand operand = parseOperand(line, DataType.byt);
    result = new Instruction(functionType, operand);
    return result;
  }

  /**
   * Parse acc16= operand function.
   * 
   * @param line
   * @param functionType
   * @return
   */
  private Instruction parseFunctionWithWordOperand(String line, FunctionType functionType) {
    Instruction result;
    skipSpaces(line);
    Operand operand = parseOperand(line, DataType.word);
    result = new Instruction(functionType, operand);
    return result;
  }

  /**
   * @param line
   * @param functionType
   * @return
   */
  protected Instruction parsePackageOrImportFunction(String line, FunctionType functionType) {
    Instruction result;
    skipSpaces(line);
    String name = skipUntil(line, ';');
    result = new Instruction(functionType, name, null, null);
    return result;
  }

  /**
   * Parse operand.
   * 
   * @param line
   * @return
   */
  private Operand parseOperand(String line, DataType datatype) {
    Operand result;
    skipSpaces(line);
    String keyword = parseKeyword(line);
    if ("acc8".equals(keyword)) {
      result = new Operand(OperandType.ACC, DataType.byt);
    } else if ("basePointer".equals(keyword)) {
      result = new Operand(OperandType.BASE_POINTER);
    } else if ("(basePointer".equals(keyword)) {
      skipUntil(line, '+');
      pos++;
      skipSpaces(line);
      int value = parseNumber(line);
      skipUntil(line, ')');
      pos++;
      result = new Operand(IdentifierType.LOCAL_VARIABLE, datatype, value);
    } else if ("constant".equals(keyword)) {
      skipSpaces(line);
      int value = parseNumber(line);
      result = new Operand(OperandType.CONSTANT, datatype, value);
    } else if ("port".equals(keyword)) {
      // port 0x65
      skipSpaces(line);
      int value = parseNumber(line);
      result = new Operand(OperandType.CONSTANT, datatype, value);
    } else if ("stackPointer".equals(keyword)) {
      result = new Operand(OperandType.STACK_POINTER);
    } else if ("stringconstant".equals(keyword)) {
      skipSpaces(line);
      int value = parseNumber(line);
      result = new Operand(OperandType.CONSTANT, DataType.string, value);
    } else if ("unstack16".equals(keyword)) {
      result = new Operand(OperandType.STACK16);
    } else if ("unstack8".equals(keyword)) {
      result = new Operand(OperandType.STACK8);
    } else if ("value".equals(keyword)) {
      // value 0x00 or value acc8
      skipSpaces(line);
      int value = parseNumber(line);
      if (value == 0 && "acc8".equals(parseKeyword(line))) {
        result = new Operand(OperandType.ACC, datatype, value);
      } else {
        result = new Operand(OperandType.CONSTANT, datatype, value);
      }
    } else if ("variable".equals(keyword)) {
      skipSpaces(line);
      int address = parseNumber(line);
      result = new Operand(OperandType.GLOBAL_VAR, datatype, address);
    } else {
      throw new RuntimeException("Internal error; not supported operand " + line.substring(pos));
    }

    return result;
  }

  /**
   * @param line
   * @param functionType
   * @return
   */
  protected Instruction parseMethod(String line, FunctionType functionType) {
    String identifier = parseKeyword(line);
    skipSpaces(line);
    EnumSet<LexemeType> modifiers = parseModifiers(line);
    ResultType resultType = new ResultType();
    // resultType
    String temp = parseKeyword(line);
    resultType.setType(LexemeType.valueFor(temp.trim()));
    Instruction result = new Instruction(functionType, identifier, modifiers, resultType);
    // formal parameters
    skipUntil(line, '(');
    result.formalParameters = parseFormalParameters(line);
    return result;
  }

  /**
   * @param line
   * @param functionType
   * @return
   */
  protected Instruction parseClassFunction(String line, FunctionType functionType) {
    Instruction result;
    EnumSet<LexemeType> modifiers;
    String identifier;
    skipSpaces(line);
    identifier = parseKeyword(line);
    skipSpaces(line);
    modifiers = parseModifiers(line);
    result = new Instruction(functionType, identifier, modifiers, null);
    return result;
  }

  protected EnumSet<LexemeType> parseModifiers(String line) {
    EnumSet<LexemeType> result = EnumSet.noneOf(LexemeType.class);
    skipUntil(line, '[');
    pos++;
    String modifiers = skipUntil(line, ']');
    if (modifiers.length() > 0) {
      for (String modifier : modifiers.split(",")) {
        result.add(LexemeType.valueFor(modifier.trim()));
      }
    }
    pos++;
    return result;
  }

  // FormalParameter := '(' FormalParameterList? ')'.
  // FormalParameterList := FormalParameter (', ' FormalParameter)*.
  // FormalParameter := modifiers type identifier "{bp+" index '}'.
  // modifiers := "final"?.
  // example: (word w {bp+4})
  private ArrayList<FormalParameter> parseFormalParameters(String line) {
    ArrayList<FormalParameter> result = new ArrayList<FormalParameter>();
    // skip opening (.
    pos++;
    while (pos < line.length() && line.charAt(pos) != ')') {
      String temp = parseKeyword(line).trim();
      // optional modifier
      LexemeType lexeme = LexemeType.valueFor(temp);
      EnumSet<LexemeType> modifiers = EnumSet.noneOf(LexemeType.class);
      if (lexeme == LexemeType.finalLexeme) {
        modifiers.add(lexeme);
        skipSpaces(line);
        temp = parseKeyword(line).trim();
        lexeme = LexemeType.valueFor(temp);
      }
      // data type
      DataType dataType = DataType.dataTypeFromLexemeType(lexeme);
      // identifier
      skipSpaces(line);
      String name = parseKeyword(line).trim();
      // skip base pointer index and closing } .
      skipUntil(line, '}');
      pos++;
      result.add(new FormalParameter(name, modifiers, dataType));
    }
    // skip closing (.
    pos++;
    return result;
  }

  protected String parseKeyword(String line) {
    skipSpaces(line);
    String result = "";
    while (pos < line.length() && !Character.isWhitespace(line.charAt(pos))) {
      result += line.charAt(pos);
      pos++;
    }
    return result;
  }

  protected int parseNumber(String line) {
    int result = 0;
    int radix = 10;
    int sign = 1;
    if ('-' == line.charAt(pos)) {
      pos++;
      sign = -1;
    }
    if (pos + 1 < line.length() && line.charAt(pos) == '0' && line.charAt(pos + 1) == 'x') {
      radix = 16;
      pos++;
      pos++;
    }
    while (pos < line.length() && isValidDigit(radix, line.charAt(pos))) {
      result = result * radix + digitValue(radix, line.charAt(pos));
      pos++;
    }
    return sign * result;
  }

  private boolean isValidDigit(int radix, char charAt) {
    if (radix == 10) {
      return Character.isDigit(charAt);
    } else if (radix == 16) {
      return Character.isDigit(charAt) || Character.toUpperCase(charAt) >= 'A' && Character.toUpperCase(charAt) <= 'F';
    } else {
      throw new RuntimeException("Internal error; not supported radix " + radix);
    }
  }

  private int digitValue(int radix, char charAt) {
    if (Character.isDigit(charAt)) {
      return (int) charAt - (int) '0';
    } else if (Character.toUpperCase(charAt) >= 'A' && Character.toUpperCase(charAt) <= 'F') {
      return (int) 10 + charAt - 'A';
    } else {
      throw new RuntimeException("Internal error; invalid digit " + charAt + " for radix " + radix);
    }
  }

  protected String skipUntil(String line, char stopChar) {
    String result = "";
    while (pos < line.length() && line.charAt(pos) != stopChar) {
      result += line.charAt(pos);
      pos++;
    }
    return result;
  }

  protected int skipSpaces(String line) {
    while (pos < line.length() && Character.isWhitespace(line.charAt(pos))) {
      pos++;
    }
    return pos;
  }
}