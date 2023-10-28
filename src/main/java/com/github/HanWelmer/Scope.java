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

import java.util.HashMap;
//import java.util.Iterator;
import java.util.Map;
//import java.util.Stack;

public class Scope {

  /* Constants and class member variables for semantic analysis phase */
  private Map<String, Variable> variables = new HashMap<String, Variable>();
  private int nextAddress = 0;

  public int getAddress() {
    return nextAddress;
  }
  
  public void setAddress(int address) {
    this.nextAddress = address;
  }
  
  public Variable getVariable(String name) {
    return variables.get(name);
  }
  
  public void addVariable(String name) {
    variables.put(name, new Variable(name));
  }
}
