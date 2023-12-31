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

/**
 * This class defines the type and value for a lexeme in the p Language. Used in
 * lexical analysis, semantic analysis and code generation phases of the
 * compiler.
 */
public class Lexeme {
  protected LexemeType type;
  protected Integer constVal;
  protected String stringVal;
  protected Datatype datatype;
  protected String idVal;
  protected OperatorType operator;
  // Line number of source code leading up to and including this lexeme.
  public int sourceLineNr = 0;

  public Lexeme(LexemeType type) {
    this.type = type;
  }

  public String makeString(Variable variable) {
    if (type == null) {
      throw new RuntimeException("lexeme type is null");
    }
    String result = type.getValue();
    switch (type) {
      case voidLexeme:
        result += " void ";
        break;
      case constant:
        result += " ";
        result += datatype.getValue();
        result += " ";
        result += constVal;
        break;
      case stringConstant:
        result += " \"";
        result += stringVal;
        result += "\"";
        break;
      case identifier:
        result += " " + idVal;
        if ((variable != null) && (variable.getAddress() >= 0)) {
          result += "{";
          result += variable.getDatatype().getValue();
          result += "}@";
          result += variable.getAddress();
        }
        break;
      case addop:
      case mulop:
      case relop:
        result += " " + operator;
        break;
      case comma:
      case period:
      case semicolon:
      case packageLexeme:
      case importLexeme:
      case publicLexeme:
      case privateLexeme:
      case staticLexeme:
      case finalLexeme:
      case synchronizedLexeme:
      case nativeLexeme:
      case transientLexeme:
      case volatileLexeme:
      case classLexeme:
      case enumLexeme:
      case byteLexeme:
      case wordLexeme:
      case stringLexeme:
      case assign:
      case beginLexeme:
      case endLexeme:
      case forLexeme:
      case ifLexeme:
      case elseLexeme:
      case whileLexeme:
      case doLexeme:
      case lbracket:
      case rbracket:
      case bitwiseAndOp:
      case bitwiseOrOp:
      case bitwiseXorOp:
      case inputLexeme:
      case outputLexeme:
      case readLexeme:
      case printlnLexeme:
      case sleepLexeme:
      case eof:
      case unknown:
        // nothing todo
        break;
    }
    return result;
  }
}
