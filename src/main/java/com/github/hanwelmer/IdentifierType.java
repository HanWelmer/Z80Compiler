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
 * Enumeration for the pCompiler. This class defines the types of identifiers in
 * the P language. Used in lexical analysis, semantic analysis and code
 * generation phases of the compiler.
 */
public enum IdentifierType {
  CLAZZ("class"), METHOD("method"), CLASS_VARIABLE("field"), LOCAL_VARIABLE("variable"), FORMAL_PARAMETER("parameter");

  private String value;

  private IdentifierType(String value) {
    this.value = value;
  }

  public String getValue() {
    return value;
  }
};
