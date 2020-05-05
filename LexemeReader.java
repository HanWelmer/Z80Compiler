import java.io.BufferedReader;
import java.io.IOException;

public interface LexemeReader {

    /**
    * return true if opening the file as lexeme reader is successfull, false otherwise.
    **/
    public boolean init(boolean debugMode, String fileName);
    
    /**
    * return the next lexeme from the lexeme reader.
    **/
    public Lexeme getLexeme() throws FatalError;
    
    /**
    * ?
    **/
    public void error();
}