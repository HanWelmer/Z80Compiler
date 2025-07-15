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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Scope {

  // Constants and class member variables for semantic analysis phase,
  // identified by their fully qualified name.
  private Map<String, Variable> variables = new HashMap<String, Variable>();
  private int nextAddress = 0;

  public int getAddress() {
    return nextAddress;
  }

  public void setAddress(int address) {
    nextAddress = address;
  }

  public Variable getVariable(String fullyQualifiedName) {
    return variables.get(fullyQualifiedName);
  }

  /**
   * Extend the name to a fully qualified name by looking up the name in the
   * list of imported methods and variables.
   * 
   * @param name
   *          partially qualified name of a method or variable.
   * @return fully qualified name of the method or variable.
   * @throws SyntaxException
   */
  public Variable getVariableByPartiallyQualifiedName(String name) throws SyntaxException {
    Variable variable = null;
    // look up possible matches
    ArrayList<String> fullyQualifiedNamesFound = new ArrayList<String>();
    for (String key : variables.keySet()) {
      if (key.endsWith(name)) {
        fullyQualifiedNamesFound.add(key);
      }
    }
    // check for exactly one match
    if (fullyQualifiedNamesFound.size() == 0) {
      throw new SyntaxException("no class variable or method found that matches partially qualified name: " + name);
    } else if (fullyQualifiedNamesFound.size() > 1) {
      throw new SyntaxException("ambiguous partially qualified name: " + name);
    }
    // lookup variable
    variable = variables.get(fullyQualifiedNamesFound.get(0));
    return variable;
  }

  public void addVariable(String fullyQualifiedName) {
    variables.put(fullyQualifiedName, new Variable(fullyQualifiedName));
  }
}
