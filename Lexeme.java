import java.util.Map;

/**
 * This class defines the type and value for a lexeme in the p Language.
 * Used in lexical analysis, semantic analysis and code generation phases of the compiler.
 */
public class Lexeme {
  protected LexemeType type;
  protected Integer constVal;
  protected String stringVal;
  protected Datatype datatype;
  protected String idVal;
  protected OperatorType operator;
  //Line number of source code leading up to and including this lexeme.
  public int sourceLineNr = 0;
  
  public Lexeme (LexemeType type) {
    this.type = type;
  }

  public String makeString(Variable variable) {
    if (type == null) {
      throw new RuntimeException("lexeme type is null");
    }
    String result = type.getValue();
    switch (type) {
      case constant:
        result += " ";
        result += datatype.getValue();
        result += " ";
        result += constVal;
        break;
      case stringConstant:
        result += " \"";
        result += stringVal;
        result += "\"";
        break;
      case identifier: 
        result += " " + idVal;
        if ((variable != null) && (variable.getAddress() >=0)) {
          result += "{";
          result += variable.getDatatype().getValue();
          result += "}@";
          result += variable.getAddress();
        }
        break;
      case addop:
      case mulop:
      case relop:
        result += " " + operator;
        break;
    }
    return result;
  }
}
