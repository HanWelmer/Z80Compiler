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
 * This class defines an accumulator.
 * Used during code generation to keep track of the contents of an accumulator.
 */
public class Accumulator {
  
  private boolean inUse = false;
  private Operand operand;
  
  public void clear() {
    inUse = false;
    operand = null;
  }

  public boolean inUse() {
    return this.inUse;
  }
  
  public Operand operand() {
    return this.operand;
  }

  public void setOperand(Operand value) {
    this.operand = value;
    inUse = true;
  }

};
