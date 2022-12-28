/**
 * Enumeration for the pCompiler.
 * This class defines the lexemes of the P language. 
 * Used in lexical analysis, semantic analysis and code generation phases of the compiler.
 */
public enum LexemeType {
  //identifier is a special lexemeType.
  identifier("identifier"),
  //from here until beginlexeme are the special characters...
  comma(","),
  assign("="),
  semicolon(";"),
  lbracket("("),
  rbracket(")"),
  addop("+ or -"),
  mulop("* or /"),
  relop("<!=>"),
  //from here until unknown are the keywords...
  beginlexeme("{"),
  constant("constant"),
  bytelexeme("byte"),
  wordlexeme("word"),
  //shortlexeme("short"),
  //intlexeme("int"),
  readlexeme("read"),
  writelexeme("write"),
  iflexeme("if"),
  elselexeme("else"),
  forlexeme("for"),
  dolexeme("do"),
  whilelexeme("while"),
  classlexeme("class"),
  endlexeme("}"),
  //unknown is a special lexemeType.
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

