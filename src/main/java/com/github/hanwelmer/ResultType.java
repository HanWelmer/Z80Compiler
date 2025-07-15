package com.github.hanwelmer;

public class ResultType {
  private LexemeType type = LexemeType.unknown;

  public LexemeType getType() {
    return type;
  }

  public DataType getDataType() throws FatalError {
    DataType result;
    switch (this.type) {
      case byteLexeme:
        result = DataType.byt;
        break;
      case wordLexeme:
        result = DataType.word;
        break;
      case stringLexeme:
        result = DataType.string;
        break;
      default:
        throw new FatalError("unexpected type.");
    }
    return result;
  }

  public void setType(LexemeType value) {
    this.type = value;
  }
}
