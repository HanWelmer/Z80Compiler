package com.github.hanwelmer;

import java.util.EnumSet;

class Symbol {
  public int address = 0;
  public String packageName = "";
  public String name = "";
  public ResultType resultType;
  public EnumSet<LexemeType> modifiers = EnumSet.noneOf(LexemeType.class);

  public String toString() {
    String result = "";
    if (packageName.length() > 0) {
      result = packageName + "." + name;
    } else {
      result = name;
    }
    result += " " + modifiers;
    result += " " + resultType.getType();
    // TODO add formal parameters.
    result += " ()";
    return result;
  }
}
