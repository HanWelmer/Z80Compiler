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
 * Enumeration of lexeme types for the compiler. Used in lexical analysis,
 * semantic analysis and code generation phases of the compiler.
 */
public enum LexemeType {
  // special lexemeTypes.
  identifier("identifier"), constant("constant"), stringConstant("stringConstant"),
  // from here until beginlexeme are the special characters...
  period("."), comma(","), assign("="), semicolon(";"), lbracket("("), rbracket(")"),
  // Lexeme types for operators in order of increasing precedence.
  bitwiseOrOp("|"), bitwiseXorOp("^"), bitwiseAndOp("&"), relop("<!=>"), addop("+ or -"), mulop("* or /"),
  // from here until unknown are the keywords...
  beginLexeme("{"), packageLexeme("package"), importLexeme("import"),
  // modifiers
  publicLexeme("public"), privateLexeme("private"), staticLexeme("static"), finalLexeme("final"), synchronizedLexeme(
      "synchronized"), nativeLexeme("native"), transientLexeme("transient"), volatileLexeme("volatile"),
  // declaration
  classLexeme("class"),
  // datatypes
  voidLexeme("void"), byteLexeme("byte"), wordLexeme("word"),
  // shortLexeme("short"), intLexeme("int"),
  stringLexeme("String"),
  // IO
  readLexeme("read"), printlnLexeme("println"), inputLexeme("input"), outputLexeme("output"),
  // conditional
  ifLexeme("if"), elseLexeme("else"),
  // loops
  forLexeme("for"), doLexeme("do"), whileLexeme("while"),
  // miscellaneous
  sleepLexeme("sleep"), endLexeme("}"),
  // unknown is a special lexemeType.
  unknown("?");

  private String value;
  private static LexemeType[] vals = values();

  private LexemeType(String value) {
    this.value = value;
  }

  public String getValue() {
    return value;
  }

  public LexemeType next() {
    return vals[(this.ordinal() + 1) % vals.length];
  }

  public static boolean isLexemeType(String str) {
    boolean found = false;
    for (LexemeType val : vals) {
      found |= val.getValue().equals(str);
    }
    return found;
  }
};
