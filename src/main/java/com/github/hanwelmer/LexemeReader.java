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

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class LexemeReader {

  /* Class member variables for lexical analysis phase */
  private String jCodePath;
  private String fileName;
  private FileReader fr;
  private BufferedReader input;
  protected boolean debugMode = false;
  private int lastLinePrinted;
  protected int lineNumber;
  protected String line;
  protected int linePos;
  protected int lineSize;
  protected Map<String, LexemeType> keywords = new HashMap<String, LexemeType>();

  /* Constants for lexical analysis phase */
  protected static final char EOF = '\u001a';
  protected static final int MAX_LINE_WIDTH = 128;
  protected static final int MAX_IDENTIFIER_LENGTH = MAX_LINE_WIDTH;
  protected static final int MAX_BYT_CONSTANT = 255; // 8 bit constant
  protected static final int MAX_INT_CONSTANT = 65535; // 16 bit constant
  protected static final String VALID_IDENTIFIER_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_";
  protected static final String VALID_DECIMAL_DIGITS = "0123456789";
  protected static final String VALID_HEXADECIMAL_DIGITS = "ABCDEF0123456789";

  /**
   * return true if opening the file as lexeme reader is successfull, false
   * otherwise.
   **/
  public boolean init(boolean debugMode, String jCodePath, String fileName) {
    this.debugMode = debugMode;
    this.jCodePath = jCodePath;
    this.fileName = fileName;

    lastLinePrinted = 0;
    lineNumber = 0;
    linePos = 0;
    lineSize = 0;

    keywords.clear();
    for (LexemeType lexemeType = LexemeType.beginLexeme; lexemeType != LexemeType.unknown; lexemeType = lexemeType.next()) {
      keywords.put(lexemeType.getValue(), lexemeType);
    }

    boolean result = false;
    try {
      this.fr = new FileReader(jCodePath + fileName);
      this.input = new BufferedReader(fr);
      result = true;
    } catch (FileNotFoundException e) {
      System.out.println(e.getMessage());
    }

    return result;
  }

  protected String getLine() throws FatalError {
    String line;
    try {
      line = input.readLine();
    } catch (IOException e) {
      System.out.println();
      System.out.println(e.getMessage());
      System.out.println();
      e.printStackTrace();
      throw new FatalError(4); // unknown character
    }
    return line;
  }

  protected char nextChar(ArrayList<String> sourceCode) throws FatalError {
    if (linePos >= lineSize) {
      line = getLine();
      if (line == null) {
        return EOF; // end of file encountered
      }

      // when in debug mode, make sure the echoed source code starts on a new
      // line.
      if (debugMode) {
        System.out.println();
        System.out.print("<-");
        System.out.print(line);
      }
      sourceCode.add(String.format("%s(%d) %s", fileName, lineNumber, line));

      lineSize = line.length();
      if (lineSize > MAX_LINE_WIDTH) {
        throw new FatalError(2); // line too long
      }
      line += "\n";
      lineSize++;
      lineNumber++;
      linePos = 0;
    }
    return line.charAt(linePos);
  } // nextChar()

  protected char getChar(ArrayList<String> sourceCode) throws FatalError {
    char result = nextChar(sourceCode);
    linePos++;
    return result;
  } // getChar()

  public void error() {
    if (lastLinePrinted != lineNumber) {
      // when in debug mode, make sure error message starts at a new line
      if (debugMode)
        System.out.println();
      System.out.println(fileName + ":" + jCodePath + lineNumber);
      System.out.print(line); // when line of source code was read, it was
                              // extended with a linefeed.
      lastLinePrinted = lineNumber;
    }
    for (int i = 0; i < linePos - 1; i++) {
      System.out.print(' ');
    }
    System.out.print('^');
  }

  protected int toDecimalDigit(char ch) {
    return (int) ch - (int) '0';
  }

  protected int toHexadecimalDigit(char ch) {
    int digit = 0;
    if (Character.isDigit(ch)) {
      digit = (int) ch - (int) '0';
    } else if (ch >= 'A' && ch <= 'F') {
      digit = 10 + (int) ch - (int) 'A';
    }
    return digit;
  }

  public String getPath() {
    return jCodePath;
  }

  public String getFileName() {
    return fileName;
  }

  /**
   * Return the next lexeme from the lexeme reader.
   * 
   * @param sourceCode:
   *          this list will be extended by any lines of source code that have
   *          been read while getting the next lexeme.
   * @return next lexeme.
   * @throws FatalError
   **/
  public Lexeme getLexeme(ArrayList<String> sourceCode) throws FatalError {
    Lexeme lexeme = new Lexeme(LexemeType.unknown);
    char ch = skipWhiteSpace(sourceCode);

    if (ch == EOF) {
      lexeme.type = LexemeType.eof;
    } else if (ch >= '0' && ch <= '9') {
      // try to recognise a constant.
      // constant = decimalConstant | hexadecimalConstant.
      // decimalConstant = "(0-9)*".
      // hexadecimalConstant = "(0-9)x(A-F0-()*".
      lexeme.type = LexemeType.constant;
      lexeme.constVal = (int) ch - (int) '0';
      boolean error = false;
      boolean isHexadecimal = (nextChar(sourceCode) == 'x');
      if (isHexadecimal) {
        // eat the 'x' character.
        ch = getChar(sourceCode);
        while (VALID_HEXADECIMAL_DIGITS.contains("" + nextChar(sourceCode)) && !error) {
          ch = getChar(sourceCode);
          lexeme.constVal = lexeme.constVal * 16 + toHexadecimalDigit(ch);
          // assumption: lexeme.constVal can be larger than MAX_INT_CONSTANT.
          if (lexeme.constVal > MAX_INT_CONSTANT) {
            error = true;
          }
        }
      } else {
        while (VALID_DECIMAL_DIGITS.contains("" + nextChar(sourceCode)) && !error) {
          ch = getChar(sourceCode);
          lexeme.constVal = lexeme.constVal * 10 + toDecimalDigit(ch);
          // assumption: lexeme.constVal can be larger than MAX_INT_CONSTANT.
          if (lexeme.constVal > MAX_INT_CONSTANT) {
            error = true;
          }
        }
      }
      if (error) {
        error();
        System.out.println("constant too big");
        /* eat up remainder of constant */
        while (ch >= '0' && ch <= '9') {
          ch = getChar(sourceCode);
        }
      }
      lexeme.datatype = (lexeme.constVal <= MAX_BYT_CONSTANT) ? Datatype.byt : Datatype.word;
    } else if (ch == '"') {
      /* try to recognise a string constant */
      lexeme.type = LexemeType.stringConstant;
      lexeme.datatype = Datatype.string;
      lexeme.stringVal = "";
      while (nextChar(sourceCode) != '"' && nextChar(sourceCode) != EOF) {
        ch = getChar(sourceCode);
        // handle escape sequences
        if (ch == EOF) {
          error();
          System.out.println("End of file encountered while reading string constant: \"" + lexeme.stringVal);
        } else if (ch != '\\') {
          lexeme.stringVal += ch;
        } else {
          switch (nextChar(sourceCode)) {
            case '\\':
              lexeme.stringVal += '\\';
              ch = getChar(sourceCode);
              break; // backslash
            case '\'':
              lexeme.stringVal += '\'';
              ch = getChar(sourceCode);
              break; // single quote
            case '"':
              lexeme.stringVal += '\"';
              ch = getChar(sourceCode);
              break; // double quotes
            case 'n':
              lexeme.stringVal += '\n';
              ch = getChar(sourceCode);
              break; // newline
            case 'r':
              lexeme.stringVal += '\r';
              ch = getChar(sourceCode);
              break; // carriage return
            case 't':
              lexeme.stringVal += '\t';
              ch = getChar(sourceCode);
              break; // horizondal tab
            case 'b':
              lexeme.stringVal += '\b';
              ch = getChar(sourceCode);
              break; // backspace
            case 'f':
              lexeme.stringVal += '\012';
              ch = getChar(sourceCode);
              break; // form feed
            case 'a':
              lexeme.stringVal += '\007';
              ch = getChar(sourceCode);
              break; // alert/bell
            default:
              error();
              System.out.println("illegal character " + nextChar(sourceCode) + " after escape character '\'.");
          }
        }
      }
      /* eat up closing " of string constant */
      ch = getChar(sourceCode);
    } else if (ch == '{') {
      lexeme.type = LexemeType.beginLexeme;
    } else if (ch == '}') {
      lexeme.type = LexemeType.endLexeme;
    } else if (VALID_IDENTIFIER_CHARACTERS.contains("" + ch)) {
      /* try to recognise an identifier or a keyword */
      String name = String.valueOf(ch);
      int charno = 0;
      while (VALID_IDENTIFIER_CHARACTERS.contains("" + nextChar(sourceCode)) && charno <= MAX_IDENTIFIER_LENGTH) {
        if (charno <= MAX_IDENTIFIER_LENGTH) {
          name += String.valueOf(getChar(sourceCode));
          charno++;
        } else {
          ch = getChar(sourceCode);
        }
      }
      /* separate identifiers from keywords */
      LexemeType keyword = keywords.get(name);
      if (keyword == null) {
        lexeme.type = LexemeType.identifier;
      } else {
        lexeme.type = keyword;
      }
      lexeme.idVal = name;
    } else {
      /*
       * try to recognise keywords or symbols . , ; | ^ & == != < <= > >= + - *
       * / ( )
       */
      switch (ch) {
        case '.':
          lexeme.type = LexemeType.period;
          break;
        case ',':
          lexeme.type = LexemeType.comma;
          break;
        case ';':
          lexeme.type = LexemeType.semicolon;
          break;
        case '|':
          lexeme.type = LexemeType.bitwiseOrOp;
          lexeme.operator = OperatorType.bitwiseOr;
          break;
        case '^':
          lexeme.type = LexemeType.bitwiseXorOp;
          lexeme.operator = OperatorType.bitwiseXor;
          break;
        case '&':
          lexeme.type = LexemeType.bitwiseAndOp;
          lexeme.operator = OperatorType.bitwiseAnd;
          break;
        case '=':
          if (nextChar(sourceCode) == '=') {
            ch = getChar(sourceCode);
            lexeme.type = LexemeType.relop;
            lexeme.operator = OperatorType.eq;
          } else {
            lexeme.type = LexemeType.assign;
          }
          break;
        case '!':
          if (nextChar(sourceCode) == '=') {
            ch = getChar(sourceCode);
            lexeme.type = LexemeType.relop;
            lexeme.operator = OperatorType.ne;
          } else {
            lexeme.type = LexemeType.unknown;
            error();
            System.out.println("! not followed by = ");
          }
          break;
        case '<':
          lexeme.type = LexemeType.relop;
          if (nextChar(sourceCode) == '=') {
            ch = getChar(sourceCode);
            lexeme.operator = OperatorType.le;
          } else {
            lexeme.operator = OperatorType.lt;
          }
          break;
        case '>':
          lexeme.type = LexemeType.relop;
          if (nextChar(sourceCode) == '=') {
            ch = getChar(sourceCode);
            lexeme.operator = OperatorType.ge;
          } else {
            lexeme.operator = OperatorType.gt;
          }
          break;
        case '+':
          if (nextChar(sourceCode) == '+') {
            ch = getChar(sourceCode);
            lexeme.type = LexemeType.increment;
          } else {
            lexeme.type = LexemeType.addop;
            lexeme.operator = OperatorType.add;
          }
          break;
        case '-':
          if (nextChar(sourceCode) == '-') {
            ch = getChar(sourceCode);
            lexeme.type = LexemeType.decrement;
          } else {
            lexeme.type = LexemeType.addop;
            lexeme.operator = OperatorType.sub;
          }
          break;
        case '*':
          lexeme.type = LexemeType.mulop;
          lexeme.operator = OperatorType.mul;
          break;
        case '/':
          lexeme.type = LexemeType.mulop;
          lexeme.operator = OperatorType.div;
          break;
        case '(':
          lexeme.type = LexemeType.LPAREN;
          break;
        case ')':
          lexeme.type = LexemeType.RPAREN;
          break;
        default:
          lexeme.type = LexemeType.unknown;
          error();
          System.out.println("unknown character");
      }
    }
    if (debugMode) {
      System.out.println("\ngetLexeme=" + lexeme.makeString(null) + ", sourceLineNr=" + lineNumber);
    }
    lexeme.sourceLineNr = lineNumber;
    return lexeme;
  } // getLexeme()

  /**
   * Read next char and skip white space.
   * 
   * @param sourceCode:
   *          array of source code lines that have been read so far.
   * @return first next char which is not white space.
   * @throws FatalError
   */
  protected char skipWhiteSpace(ArrayList<String> sourceCode) throws FatalError {
    char ch = getChar(sourceCode);
    while (ch == ' ' || ch == '\t' || ch == '\n' || (ch == '/' && (nextChar(sourceCode) == '*' || nextChar(sourceCode) == '/'))) {
      if (ch == '/' && nextChar(sourceCode) == '*') {
        ch = getChar(sourceCode);
        ch = getChar(sourceCode);
        while (ch != '*' || nextChar(sourceCode) != '/') {
          ch = getChar(sourceCode);
        }
        ch = getChar(sourceCode);
      } else if (ch == '/' && nextChar(sourceCode) == '/') {
        ch = getChar(sourceCode);
        while (nextChar(sourceCode) != '\n') {
          ch = getChar(sourceCode);
        }
      }
      ch = getChar(sourceCode);
    }
    return ch;
  }

  public Lexeme skipAfterError(ArrayList<String> sourceCode) throws FatalError {
    error();
    System.out.println("lexeme skipped after error.");
    return getLexeme(sourceCode);
  }

}