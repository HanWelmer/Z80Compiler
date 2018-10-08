/**
 * Enumeration for the pCompiler.
 * This class defines the lexemes of the P language. 
 * Used in lexical analysis, semantic analysis and code generation phases of the compiler.
 */
public enum Datatype {
  integer("int"),
  unknown("?");

  private String value;
  
  private Datatype (String value) {
    this.value = value;
  }
  
  public String getValue() {
    return value;
  }

};
