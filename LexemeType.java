/**
 * Enumeration for the pCompiler.
 * This class defines the lexemes of the P language. 
 * Used in lexical analysis, semantic analysis and code generation phases of the compiler.
 */
public enum LexemeType {
  //special lexemeTypes.
  identifier("identifier"),
  constant("constant"),
  stringConstant("stringConstant"),
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
  beginLexeme("{"),
  finalLexeme("final"),
  byteLexeme("byte"),
  wordLexeme("word"),
  //shortLexeme("short"),
  //intLexeme("int"),
  stringLexeme("String"),
  readLexeme("read"),
  inputLexeme("input"),
  printlnLexeme("println"),
  ifLexeme("if"),
  elseLexeme("else"),
  forLexeme("for"),
  doLexeme("do"),
  whileLexeme("while"),
  outputLexeme("output"),
  sleepLexeme("sleep"),
  classLexeme("class"),
  endLexeme("}"),
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

