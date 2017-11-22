/**
 * Enumeration for the pCompiler.
 * This class defines the lexemes of the P language. 
 * Used in lexical analysis, semantic analysis and code generation phases of the compiler.
 */
public enum LexemeType {
  dot("."),
  constant("digit"),
  identifier("name"),
  comma(","),
  assign(":="),
  semicolon(";"),
  lbracket("("),
  rbracket(")"),
  addop("+ or -"),
  mulop("* or /"),
  relop("<=>"),
  beginlexeme("BEGIN"),
  readlexeme("READ"),
  writelexeme("WRITE"),
  iflexeme("IF"),
  thenlexeme("THEN"),
  whilelexeme("WHILE"),
  dolexeme("DO"),
  varlexeme("VAR"),
  endlexeme("END"),
  unknown("?");

  private String value;
  private static LexemeType[] vals = values();
  
  private LexemeType (String value) {
    this.value = value;
  }
  
  public String getValue() {
    return value;
  }
  
  public LexemeType next() {
      return vals[(this.ordinal()+1) % vals.length];
  }
};

