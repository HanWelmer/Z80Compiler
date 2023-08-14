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

import java.util.Iterator;
import java.util.Stack;

public class Identifiers {

  /* Constants and class member variables for semantic analysis phase */
  private Stack<Scope> stackOfScopes = new Stack<>();

  /**
   * Initialize the table with identifiers.
   * Method is used during semantic analysis phase.
   */
  public void init() {
    stackOfScopes.clear();
  }
  
  private void debug(String message) {
    //System.out.println(message);
  }

  //Start a new declaration scope.
  public void newScope() {
    Scope newScope = new Scope();
    if (stackOfScopes.size() == 0) {
      newScope.setAddress(0);
    } else {
      newScope.setAddress(stackOfScopes.peek().getAddress());
    }
    stackOfScopes.push(newScope);
  }

  //Close the top level scope.
  public void closeScope() {
    //avoid a run-time error.
    if (stackOfScopes.size() > 0) {
      stackOfScopes.pop();
    }
  }

  /**
   * Get a variable by its name.
   * Method is used during semantic analysis phase.
   * Param: name : name of the variable for which its address is sought.
   * Returns : null if no variable with that name is not found; -1 if a variable with that name is used but not yet declared; integer >= 0 if variable with that name has been declared.
   */
  public Variable getId(String name) {
    Variable variable = null;
    Iterator<Scope> iterator = stackOfScopes.iterator();
    while ((variable == null) && iterator.hasNext()) {
      Scope scope = iterator.next();
      variable = scope.getVariable(name);
    }
    return variable;
  }
  
  /**
   * Check if an identifier with that value has already been declared.
   * Method is used during semantic analysis phase.
   * Param: identifier : check if an identifier with this value already exists.
   * Returns : true if declared; false if not declared.
   */
  public boolean checkId(String identifier) {
    boolean found = getId(identifier) != null;

    if (!found) {
      stackOfScopes.peek().addVariable(identifier);
    }
    debug(String.format("\ncheckId(" + identifier + ") returns " + found + "."));

    return found;
  }

  /**
   * Declare an identifier.
   * Method is used during semantic analysis phase.
   * Param lexeme : for the idVal of this lexeme an indentifier will be declared.
   * Param datatype : datatype of variable.
   * Returns : true if OK; false if such an identifier already declared.
   */
  public boolean declareId(Lexeme lexeme, LexemeType datatype) {
    return declareId(lexeme, datatype, false);
  }

  /**
   * Declare an identifier.
   * Method is used during semantic analysis phase.
   * Param lexeme : for the idVal of this lexeme an indentifier will be declared.
   * Param datatype : datatype of variable.
   * Param isFinale : true if the identifier is a final variable.
   * Returns : true if OK; false if such an identifier already declared.
   */
  public boolean declareId(Lexeme lexeme, LexemeType datatype, boolean isFinal) {
    boolean result = true;
    //make sure the variable is declared.
    debug("\ndeclareId() calling checkId(");
    checkId(lexeme.idVal);

    //If it wasn't declared yet, override default datatype and set other properties.
    Variable var = getId(lexeme.idVal);
    if (var.getDatatype() == null) {
      debug(String.format("declareId() overriding default datatype and other properties."));
      //set datatype
      if (datatype == LexemeType.byteLexeme) {
        var.setDatatype(Datatype.byt);
      } else if (datatype == LexemeType.wordLexeme) {
        var.setDatatype(Datatype.word);
      } else if (datatype == LexemeType.stringLexeme) {
        var.setDatatype(Datatype.string);
      } else if (datatype == LexemeType.classLexeme) {
        var.setDatatype(Datatype.clazz);
      } else {
        result = false;
      }
      //set isFinal
      var.setFinal(isFinal);
      //this scheme assumes that memory allocation can only occur in the current top level scope.
      int address = stackOfScopes.peek().getAddress();
      var.setAddress(address);
      stackOfScopes.peek().setAddress(address + var.getDatatype().getSize());
    }
    return result;
  }
}
