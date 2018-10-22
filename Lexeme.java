import java.util.Map;

/**
 * This class defines the type and value for a lexeme in the p Language.
 * Used in lexical analysis, semantic analysis and code generation phases of the compiler.
 */
public class Lexeme {
  protected LexemeType type;
  protected Integer constVal;
  protected String idVal;
  protected AddValType addVal;
  protected MulValType mulVal;
  protected RelValType relVal;
  
  public Lexeme (LexemeType type) {
    this.type = type;
  }

  public String makeString(Variable variable) {
    if (type == null) {
      throw new RuntimeException("lexeme type is null");
    }
    String result = type.getValue();
    switch (type) {
      case constant: result += " " + constVal; break;
      case identifier: 
        result += " " + idVal;
        if ((variable != null) && (variable.getAddress() >=0)) {
          result += "@" + variable.getAddress();
        }
        break;
      case addop: result += " " + addVal; break;
      case mulop: result += " " + mulVal; break;
      case relop: result += " " + relVal; break;
    }
    return result;
  }
}
