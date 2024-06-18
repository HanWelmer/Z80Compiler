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
import java.util.EnumSet;

public class Variable {

  private String name;
  private IdentifierType identifierType;
  private DataType dataType;
  private EnumSet<LexemeType> modifiers;
  private ArrayList<FormalParameter> formalParameters;
  private int intValue = 0;
  private int address;

  // constructor
  public Variable(String name) {
    this.name = name;
    this.address = 0;
    this.formalParameters = new ArrayList<FormalParameter>();
  }

  public String getName() {
    return name;
  }

  public void setIdentifierType(IdentifierType identifierType) {
    this.identifierType = identifierType;
  }

  public IdentifierType getIdentifierType() {
    return identifierType;
  }

  public void setDatatype(DataType dataType) {
    this.dataType = dataType;
  }

  public DataType getDataType() {
    return dataType;
  }

  public void setModifiers(EnumSet<LexemeType> modifiers) {
    this.modifiers = modifiers;
  }

  public EnumSet<LexemeType> getModifiers() {
    return modifiers;
  }

  public void addFormalParameter(FormalParameter parameter) {
    formalParameters.add(parameter);
  }

  public FormalParameter getFormalParameter(int index) throws FatalError {
    if (index < 0 || index >= formalParameters.size()) {
      throw new FatalError(39);
    }
    return formalParameters.get(index);
  }

  public ArrayList<FormalParameter> getFormalParameters() {
    return formalParameters;
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

  public boolean isFinal() {
    return modifiers.contains(LexemeType.finalLexeme);
  }

  public String toString() {
    String result = "var(" + name;
    result += ", identifierType=" + identifierType;
    result += ", dataType=" + dataType;
    result += ", modifiers=" + modifiers;
    result += ", intValue=" + intValue;
    result += ", address=" + address;
    if (identifierType == IdentifierType.METHOD) {
      result += ", formalParameters=" + formalParameters;
    }
    result += ")";
    return result;
  }

}
