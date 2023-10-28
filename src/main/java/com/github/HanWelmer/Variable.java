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

public class Variable {

  private String name;
  private Datatype datatype;
  private boolean isFinal = false;
  private int intValue = 0;
  private int address;

  // constructor
  public Variable(String name) {
    this.name = name;
    this.address = 0;
  }

  public String getName() {
    return name;
  }

  public void setDatatype(Datatype datatype) {
    this.datatype = datatype;
  }

  public Datatype getDatatype() {
    return datatype;
  }

  public void setFinal(boolean isFinal) {
    this.isFinal = isFinal;
  }

  public boolean isFinal() {
    return isFinal;
  }

  public void setIntValue(int intValue) {
    this.intValue = intValue;
  }

  public int getIntValue() {
    return intValue;
  }

  public void setAddress(int address) {
    this.address = address;
  }

  public int getAddress() {
    return address;
  }

  public String toString() {
    String result = "var(" + name + ", datatype=" + datatype;
    result += ", isFinal=" + isFinal;
    result += ", intValue=" + intValue;
    result += ", address=" + address;
    result += ")";
    return result;
  }

}
