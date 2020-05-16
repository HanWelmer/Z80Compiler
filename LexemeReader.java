import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;

public interface LexemeReader {

    /**
    * return true if opening the file as lexeme reader is successfull, false otherwise.
    **/
    public boolean init(boolean debugMode, String fileName);
    
    /**
    * return the next lexeme from the lexeme reader.
    * parm sourceCode: this list will be extended by any lines of source code that have been read while getting the next lexeme.
    **/
    public Lexeme getLexeme(ArrayList<String> sourceCode) throws FatalError;
    
    /**
    * ?
    **/
    public void error();
}