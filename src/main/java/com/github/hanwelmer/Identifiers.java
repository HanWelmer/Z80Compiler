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

import java.util.EnumSet;
import java.util.Iterator;
import java.util.Stack;

public class Identifiers {

  // Scope with member fields (class variables) for semantic analysis.
  private Scope classVariables = new Scope();
  // Stack of scopes with local variables for semantic analysis.
  private Stack<Scope> localVariables = new Stack<>();
  private int maxScopeSize = 0;

  /**
   * Initialize the table with identifiers. Method is used during semantic
   * analysis phase.
   */
  public void init() {
    classVariables.setAddress(0);
    localVariables.clear();
    maxScopeSize = 0;
  }

  // Start a new declaration scope.
  public void newScope() {
    Scope newScope = new Scope();
    if (localVariables.size() == 0) {
      newScope.setAddress(0);
    } else {
      newScope.setAddress(localVariables.peek().getAddress());
    }
    localVariables.push(newScope);
  } // newScope

  // Close the top level scope.
  public void closeScope() {
    // update maximum scope size.
    // Note that local variable indices are negative but maxScopeSie is
    // positive.
    if (maxScopeSize < -localVariables.peek().getAddress()) {
      maxScopeSize = -localVariables.peek().getAddress();
    }
    localVariables.pop();
  } // closeScope

  public void resetScopeSize() {
    maxScopeSize = 0;
  }

  public int getScopeSize() {
    return maxScopeSize;
  }

  /**
   * Get a variable by its name. Method is used during semantic analysis phase.
   * 
   * Param name : name of the variable for which its address is sought.
   * 
   * Returns null if no variable with that name is not found; the variable if a
   * variable with that name has been declared.
   */
  public Variable getId(String name) {
    Variable variable = classVariables.getVariable(name);
    Iterator<Scope> iterator = localVariables.iterator();
    while ((variable == null) && iterator.hasNext()) {
      Scope scope = iterator.next();
      variable = scope.getVariable(name);
    }
    return variable;
  } // getId

  /**
   * Declare an identifier. Method is used during semantic analysis phase.
   *
   * @param identifier:
   *          this identifier will be declared
   * @param identifierType:
   *          type of identifier.
   * @param dataType:
   *          dataType of variable.
   * @param modifiers
   * @return true if OK; false if such an identifier already declared.
   */
  public boolean declareId(String identifier, IdentifierType identifierType, LexemeType datatype, EnumSet<LexemeType> modifiers) {
    // Check if variable (class or local) with that name already exists.
    if (getId(identifier) != null)
      return false;

    // Depending on the identifierType, add the identifier (fully qualified
    // name) to a global scope or to a stack of local scopes (local name).
    Scope scope = identifierType == IdentifierType.LOCAL_VARIABLE ? localVariables.peek() : classVariables;

    // Create and get a variable with the required identifier.
    scope.addVariable(identifier);
    Variable var = scope.getVariable(identifier);

    // set type of identifier
    var.setIdentifierType(identifierType);

    // set dataType
    if (datatype == LexemeType.classLexeme) {
      var.setDatatype(DataType.clazz);
    } else if (datatype == LexemeType.byteLexeme) {
      var.setDatatype(DataType.byt);
    } else if (datatype == LexemeType.wordLexeme) {
      var.setDatatype(DataType.word);
    } else if (datatype == LexemeType.stringLexeme) {
      var.setDatatype(DataType.string);
    } else if (datatype == LexemeType.voidLexeme) {
      var.setDatatype(DataType.voidd);
    } else {
      throw new RuntimeException("Internal compiler error in Identifiers.declareId(): unknown dataType " + datatype);
    }

    // set modifiers
    var.setModifiers(modifiers);

    // Allocate an address for a class or local variable.
    if (identifierType == IdentifierType.CLASS_VARIABLE) {
      // Allocate class variable (field) in memory at an absolute address.
      // This scheme assumes memory is allocated from low to high memory
      // addresses and that the current value is the first
      // available address.
      int address = classVariables.getAddress();
      var.setAddress(address);
      classVariables.setAddress(address + var.getDataType().getSize());
    } else if (identifierType == IdentifierType.LOCAL_VARIABLE) {
      // Allocate a local variable on the stack, with a negative index relative
      // to the base pointer:
      // BP - 1,2 for first word.
      // BP - 1 for first byte.
      // This scheme assumes that memory allocation can only occur in the
      // current top level scope.
      // This scheme assumes that the stack grows downwards (from high to low
      // memory addresses) and that the current value is just above the first
      // available address.
      int address = localVariables.peek().getAddress();
      address = address - var.getDataType().getSize();
      var.setAddress(address);
      localVariables.peek().setAddress(address);
    } else if (identifierType == IdentifierType.FORMAL_PARAMETER) {
      // Allocate a formal parameter on the stack, with a positive index
      // relative to the base pointer:
      // BP + 0,1 is saved value for the old base pointer.
      // BP + 2,3 is the return address.
      // BP + 4,5 is the first word; BP + 4 is the first byte.
      // This scheme assumes that memory allocation can only occur in the
      // current top level scope.
      // This scheme assumes that the stack grows downwards (from high to low
      // memory addresses) and that the current value is just above the first
      // available address.
      int address = 4;
      // TODO calculate address when there are more than 1 formal parameters.
      var.setAddress(address);
      localVariables.peek().setAddress(address);
    } else if (identifierType == IdentifierType.CLAZZ || identifierType == IdentifierType.METHOD) {
      ; // no address assigned.
    } else {
      throw new RuntimeException("Internal compiler error in Identifiers.declareId(): unknown identifier type " + identifierType);
    }

    return true;
  } // declareId

}
