package com.github.hanwelmer;

import java.util.EnumSet;

public class FormalParameter {

  private String name;
  private EnumSet<LexemeType> modifiers;
  private DataType dataType;
  private int basePointerOffset;

  public FormalParameter(String name, EnumSet<LexemeType> modifiers, DataType dataType) {
    super();
    this.name = name;
    this.modifiers = modifiers;
    this.dataType = dataType;
  }

  public void setBasePointerOffset(int basePointerOffset) {
    this.basePointerOffset = basePointerOffset;
  }

  public String getName() {
    return name;
  }

  public EnumSet<LexemeType> getModifiers() {
    return modifiers;
  }

  public DataType getDataType() {
    return dataType;
  }

  public int getBasePointerOffset() {
    return basePointerOffset;
  }

  public String toString() {
    String result = "";
    // for (LexemeType modifier : modifiers) {
    // result += modifier + " ";
    // }
    result += dataType + " ";
    result += name;
    result += " {bp+" + basePointerOffset + "}";
    return result;
  }

}
