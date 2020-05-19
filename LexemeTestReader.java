import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;

public class LexemeTestReader extends LexemeReader {
  
  private ArrayList<String> sourceCode;

  /**
  * return true if opening the file as lexeme reader is successfull, false otherwise.
  **/
  public boolean init(boolean debugMode, String testName, ArrayList<String> sourceCode) {
    super.init(debugMode, testName);
    this.sourceCode = sourceCode;
    return true;
  }
  
  protected String getLine() {
    if (lineNumber == sourceCode.size()) {
      return null;
    }
    
    return sourceCode.get(lineNumber);
  }
  

}