/**
 * Enumeration for the pCompiler.
 * This class defines the lexemes of the P language. 
 * Used in lexical analysis, semantic analysis and code generation phases of the compiler.
 */
public enum Datatype {
  clazz("class", 0),
  byt("byte", 1),
  word("word", 2),
  string("string", 2);

  private String value;
  private int size;
  
  private Datatype (String value, int size) {
    this.value = value;
    this.size = size;
  }
  
  public String getValue() {
    return value;
  }

  public int getSize() {
    return size;
  }

};
