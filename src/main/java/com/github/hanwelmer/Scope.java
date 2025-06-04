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

  public Variable getVariable(String packageName, String className, String name) {
    Variable variable = variables.get(name);
    if (variable == null) {
      name = className + "." + name;
      variable = variables.get(name);
    }
    if (variable == null && packageName != null && packageName.isEmpty()) {
      name = packageName + "." + name;
      variable = variables.get(name);
    }
    return variable;
  }

  public void addVariable(String fullyQualifiedName) {
    variables.put(fullyQualifiedName, new Variable(fullyQualifiedName));
  }
}
