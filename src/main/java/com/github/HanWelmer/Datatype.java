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

package com.github.HanWelmer;

/**
 * Enumeration for the pCompiler.
 * This class defines the lexemes of the P language. 
 * Used in lexical analysis, semantic analysis and code generation phases of the compiler.
 */
public enum Datatype {
  clazz("class", 0),
  byt("byte", 1),
  word("word", 2),
  string("String", 2);

  private String value;
  private int size;
  
  private Datatype (String value, int size) {
    this.value = value;
    this.size = size;
  }
  
  public String getValue() {
    return value;
  }

  public int getSize() {
    return size;
  }

};
