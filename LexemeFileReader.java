import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.ArrayList;

public class LexemeFileReader extends LexemeReader {

  /* Class member variables for lexical analysis phase */
  private FileReader fr; 
  private BufferedReader input;
  
  public boolean init(boolean debugMode, String fileName) {
    super.init(debugMode, fileName);

    boolean result = false;
    try {
      this.fr = new FileReader(fileName); 
      this.input = new BufferedReader(fr);
      result = true;
    } catch (FileNotFoundException e) {
      System.out.println(e.getMessage());
    }

    return result;
  }
  
  protected String getLine() throws FatalError {
    String line;
    try {
      line = input.readLine();
    } catch (IOException e) {
      System.out.println();
      System.out.println(e.getMessage());
      System.out.println();
      e.printStackTrace();
      throw new FatalError(4); //unknown character
    }
    return line;
  }
  
}