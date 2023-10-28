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

import java.util.ArrayList;

public class StringConstants {

  /* Constants and class member variables for semantic analysis phase */
  private ArrayList<String> stringConstants = new ArrayList<String>();

  /**
   * Initialize the table with stringConstants. Method is used during semantic
   * analysis phase.
   */
  public void init() {
    stringConstants.clear();
  }

  /**
   * Get a string constant by its id. Method is used during semantic analysis
   * phase. Param: id : unique identifier of the string constant. Returns : null
   * if no string constant with that id is found; String with the string
   * constant if a string constant with that id is found.
   */
  public String get(int id) {
    return stringConstants.get(id);
  }

  /**
   * Add a string constant to the table with string constants. Duplicate values
   * are avoided. Method is used during semantic analysis phase. Param: value :
   * value of the string constant. Returns : id (int) as a unique identification
   * of te string constant.
   */
  public int add(String value, int lineNumber) {
    // add new string constant to list of string constants.
    if (!stringConstants.contains(value)) {
      stringConstants.add(value);
    }
    return stringConstants.indexOf(value);
  }

  public int size() {
    return stringConstants.size();
  }
}
