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

  /**
   * Initialize the table with identifiers. Method is used during semantic
   * analysis phase.
   */
  public void init() {
    classVariables.setAddress(0);
    localVariables.clear();
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
    // update maximum size of sub-scopes of parent of current scope.
    if (localVariables.size() > 1) {
      int currentScopeSize = getScopeSize();
      localVariables.get(localVariables.size() - 2).updateMaxSubScopeSize(currentScopeSize);
    }
    // remove current scope.
    localVariables.pop();
  } // closeScope

  public int getScopeSize() {
    // calculate size of current scope plus maximum of it's sub-scopes
    int currentScopeSize = localVariables.peek().getAddress() < 0 ? 0 : localVariables.peek().getAddress();
    currentScopeSize += localVariables.peek().getMaxSubScopeSize();
    return currentScopeSize;
  }

  /**
   * Get a variable by its name. Method is used during semantic analysis phase.
   * 
   * Param name : name of the variable.
   * 
   * Returns null if no variable with that name is found; the variable if a
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
   * Get a variable by its name and optionally its class name and optionally its
   * package name. Method is used during semantic analysis phase.
   * 
   * Param packageName : name of the package in which the class is declared.
   * Param className : name of the class in which the variable is declared.
   * Param name : name of the variable.
   * 
   * Returns null if no variable with that name, class name and package name is
   * found; the variable if a variable with that name has been declared.
   */
  public Variable getId(String packageName, String className, String name) {
    // check if the name identifies a class variable or method.
    Variable variable = classVariables.getVariable(name);
    if (variable == null) {
      variable = classVariables.getVariable(className + "." + name);
    }
    if (variable == null && packageName != null && !packageName.isEmpty()) {
      variable = classVariables.getVariable(packageName + "." + className + "." + name);
    }

    // check if the name identifies a local variable defined within a method.
    Iterator<Scope> iterator = localVariables.iterator();
    while ((variable == null) && iterator.hasNext()) {
      Scope scope = iterator.next();
      variable = scope.getVariable(name);
    }
    if (variable == null) {
      iterator = localVariables.iterator();
      while ((variable == null) && iterator.hasNext()) {
        Scope scope = iterator.next();
        variable = scope.getVariable(className + "." + name);
      }
    }
    if (variable == null && packageName != null && !packageName.isEmpty()) {
      iterator = localVariables.iterator();
      while ((variable == null) && iterator.hasNext()) {
        Scope scope = iterator.next();
        variable = scope.getVariable(packageName + "." + className + "." + name);
      }
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
    var.setDatatype(DataType.dataTypeFromLexemeType(datatype));

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
      // Allocate a local variable on the stack, with a positive index relative
      // to the base pointer:
      // BP - 2,3 hold the return address.
      // BP - 0,1 hold saved value for the old base pointer.
      // BP + 1 for first byte local variable.
      // BP + 1 (high byte), BP + 2 (low byte) for first word local variable.
      // This scheme assumes that memory allocation can only occur in the
      // current top level scope.
      // This scheme assumes that the stack grows upwards (zero based index).
      // This scheme assumes that BP points to saved old BP (just below first
      // memory address on the stack to be allocated to local variables).
      int address = localVariables.peek().getAddress();
      // override last allocated address if this is the first local variable
      // within current scope.
      if (address < 0) {
        address = 0;
      }
      // allocate space for current local variable.
      address = address + var.getDataType().getSize();
      // assign next address to current formal parameter.
      var.setAddress(address);
      // update last allocated address for local variables within current scope.
      localVariables.peek().setAddress(address);
    } else if (identifierType == IdentifierType.FORMAL_PARAMETER) {
      // Allocate a formal parameter on the stack, with a negative index
      // relative to the base pointer:
      // BP - 0,1 hold saved value for the old base pointer.
      // BP - 2,3 hold the return address.
      // BP - 4 is for the first byte parameter.
      // BP - 4,5 is for the first word parameter.
      // This scheme assumes that memory allocation can only occur in the
      // current top level scope.
      // This scheme assumes that the stack grows upwards (zero based index).
      // This scheme assumes that BP points to saved old BP (just below first
      // memory address on the stack to be allocated to local variables).
      int address = localVariables.peek().getAddress();
      // override default next address if this is the first formal parameter
      // within current scope.
      if (address == 0) {
        address = -4;
      }
      // assign next address to current formal parameter.
      var.setAddress(address);
      // allocate space for current formal parameter.
      address = address - var.getDataType().getSize();
      // update next address for next formal parameter within current scope.
      localVariables.peek().setAddress(address);
    } else if (identifierType == IdentifierType.CLAZZ || identifierType == IdentifierType.METHOD) {
      ; // no address assigned.
    } else {
      throw new RuntimeException("Internal compiler error in Identifiers.declareId(): unknown identifier type " + identifierType);
    }

    return true;
  } // declareId

}
