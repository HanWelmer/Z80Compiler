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
  period("."),
  comma(","),
  assign("="),
  semicolon(";"),
  lbracket("("),
  rbracket(")"),
  // Lexeme types for operators are enumerated in order of increasing precedence.
  bitwiseOrOp("|"),
  bitwiseXorOp("^"),
  bitwiseAndOp("&"),
  relop("<!=>"),
  addop("+ or -"),
  mulop("* or /"),
  //from here until unknown are the keywords...
  beginLexeme("{"),
  packageLexeme("package"),
  importLexeme("import"),
  publicLexeme("public"),
  classLexeme("class"),
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

