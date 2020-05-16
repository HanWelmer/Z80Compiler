import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class LexemeFileReader implements LexemeReader {

  /* Constants for lexical analysis phase */
  private static final int MAX_LINE_WIDTH = 128;
  private static final int MAX_IDENTIFIER_LENGTH = MAX_LINE_WIDTH;
  private static final int MAX_BYT_CONSTANT = 255; //8 bit constant
  private static final int MAX_INT_CONSTANT = 65535; //16 bit constant
  private static final String VALID_IDENTIFIER_CHARACTERS ="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_";

  /* Class member variables for lexical analysis phase */
  private boolean debugMode = false;
  private String fileName;
  private FileReader fr; 
  private BufferedReader input;
  private Map<String, LexemeType> keywords = new HashMap<String, LexemeType>();
  private int lastLinePrinted;
  private String line;
  private int lineNumber;
  private int linePos;
  private int lineSize;
  
  public boolean init(boolean debugMode, String fileName) {
    this.debugMode = debugMode;
    this.fileName = fileName;

    lastLinePrinted = 0;
    lineNumber = 0;
    lineSize = 0;
    linePos = 0;

    keywords.clear();
    for (LexemeType lexemeType = LexemeType.beginlexeme; lexemeType != LexemeType.unknown; lexemeType = lexemeType.next()) {
      keywords.put(lexemeType.getValue(), lexemeType);
    }
    
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
  
  public void error() {
    if (lastLinePrinted != lineNumber) {
      //when in debug mode, make sure error message starts at a new line
      if (debugMode) System.out.println();
      System.out.println(fileName + ":" + lineNumber);
      System.out.print(line); //when line of source code was read, it was extended with a linefeed.
      lastLinePrinted = lineNumber;
    }
    for (int i=0; i<linePos-1; i++) {
      System.out.print(' ');
    }
    System.out.print('^');
  }

  /**
  * return the next lexeme from the lexeme reader.
  * parm sourceCode: this list will be extended by any lines of source code that have been read while getting the next lexeme.
  **/
  public Lexeme getLexeme(ArrayList<String> sourceCode) throws FatalError {
    Lexeme lexeme = new Lexeme(LexemeType.unknown);
    char ch;
    //ignore white space and comments
    ch = getChar(sourceCode);
    while (ch == ' ' || ch == '\t' || ch == '\n' || (ch == '/' && (nextChar(sourceCode) == '*' || nextChar(sourceCode) == '/'))) {
      if (ch == '/' && nextChar(sourceCode) == '*') {
        ch = getChar(sourceCode);
        ch = getChar(sourceCode);
        while (ch != '*' || nextChar(sourceCode) != '/') {
          ch = getChar(sourceCode);
        }
        ch = getChar(sourceCode);
      } else if (ch == '/' && nextChar(sourceCode) == '/') {
        ch = getChar(sourceCode);
        while (nextChar(sourceCode) != '\n') {
          ch = getChar(sourceCode);
        }
      }
      ch = getChar(sourceCode);
    }

    if (ch >= '0' && ch <= '9') {
      /* try to recognise a constant */
      lexeme.type = LexemeType.constant;
      lexeme.constVal = (int)ch - (int)'0';
      boolean error = false;
      while (nextChar(sourceCode) >= '0' && nextChar(sourceCode) <= '9' && !error) {
        ch = getChar(sourceCode);
        lexeme.constVal = lexeme.constVal * 10 + ((int)ch - (int)'0');
        //assumption: lexeme.constVal can be larger than MAX_INT_CONSTANT.
        if (lexeme.constVal > MAX_INT_CONSTANT) {
          error = true;
        }
      }
      if (error) {
        error();
        System.out.println("constant too big");
        /* eat up remainder of constant */
        while (ch >= '0' && ch <= '9') {
          ch = getChar(sourceCode);
        }
      }
      lexeme.datatype = (lexeme.constVal <= MAX_BYT_CONSTANT) ? Datatype.byt : Datatype.integer;
    } else if (ch == '{') {
      lexeme.type = LexemeType.beginlexeme;
    } else if (ch == '}') {
      lexeme.type = LexemeType.endlexeme;
    }else if (VALID_IDENTIFIER_CHARACTERS.contains("" + ch)){
      /* try to recognise an identifier or a keyword */
      String name = String.valueOf(ch);
      int charno = 0;
      while ( VALID_IDENTIFIER_CHARACTERS.contains("" + nextChar(sourceCode)) && charno <= MAX_IDENTIFIER_LENGTH) {
        if (charno <= MAX_IDENTIFIER_LENGTH) {
          name += String.valueOf(getChar(sourceCode));
          charno++;
        } else {
          ch = getChar(sourceCode);
        }
      }
      /* separate identifiers from keywords */
      LexemeType keyword = keywords.get(name);
      if (keyword == null) {
        lexeme.type = LexemeType.identifier;
      }
      else {
        lexeme.type = keyword;
      }
      lexeme.idVal = name;
    } else {
      /* try to recognise keywords or , ; = ( ) + - * / <!=> */
      switch (ch) {
        case ',' : lexeme.type = LexemeType.comma; break;
        case ';' : lexeme.type = LexemeType.semicolon; break;
        case '(' : lexeme.type = LexemeType.lbracket; break;
        case ')' : lexeme.type = LexemeType.rbracket; break;
        case '+' :
          lexeme.type = LexemeType.addop;
          lexeme.addVal = AddValType.add;
          break;
        case '-' :
          lexeme.type = LexemeType.addop;
          lexeme.addVal = AddValType.sub;
          break;
        case '*' :
          lexeme.type = LexemeType.mulop;
          lexeme.mulVal = MulValType.muld;
          break;
        case '/' :
          lexeme.type = LexemeType.mulop;
          lexeme.mulVal = MulValType.divd;
          break;
        case '=' :
          if (nextChar(sourceCode) == '=') {
            ch = getChar(sourceCode);
            lexeme.type = LexemeType.relop;
            lexeme.relVal = RelValType.eq;
          } else {
            lexeme.type = LexemeType.assign;
          }
          break;
        case '!' :
          if (nextChar(sourceCode) == '=') {
            ch = getChar(sourceCode);
            lexeme.type = LexemeType.relop;
            lexeme.relVal = RelValType.ne;
          } else {
            lexeme.type = LexemeType.unknown;
            error();
            System.out.println("! not followed by = ");
          }
          break;
        case '>' :
          lexeme.type = LexemeType.relop;
          if (nextChar(sourceCode) == '=') {
            ch = getChar(sourceCode);
            lexeme.relVal = RelValType.ge;
          } else {
            lexeme.relVal = RelValType.gt;
          }
          break;
        case '<' :
          lexeme.type = LexemeType.relop;
          if (nextChar(sourceCode) == '=') {
            ch = getChar(sourceCode);
            lexeme.relVal = RelValType.le;
          } else {
            lexeme.relVal = RelValType.lt;
          }
          break;
        default :
          lexeme.type = LexemeType.unknown;
          error();
          System.out.println("unknown character");
      }
    }
    if (debugMode) {
      //System.out.println("\ngetLexeme: " + lexeme.makeString(identifiers.getId(lexeme.idVal)));
      System.out.println("\ngetLexeme: " + lexeme.makeString(null));
    }
    return lexeme;
  } //getLexeme()

  private char getChar(ArrayList<String> sourceCode) throws FatalError {
    char result = nextChar(sourceCode);
    linePos++;
    return result;
  } //getChar()
  
  private char nextChar(ArrayList<String> sourceCode) throws FatalError {
    if (linePos >= lineSize) {
      try {
        line = input.readLine();
      } catch (IOException e) {
        System.out.println();
        System.out.println(e.getMessage());
        System.out.println();
        e.printStackTrace();
        throw new FatalError(4); //unknown character
      }
      
      if (line == null) {
        throw new FatalError(1); //end of file encountered
      };
      
      //when in debug mode, make sure the echoed source code starts on a new line.
      if (debugMode) {
        System.out.println();
        System.out.print(line);
      }
      sourceCode.add(line);
 
      lineSize = line.length();
      if (lineSize > MAX_LINE_WIDTH) {
        throw new FatalError(2); //line too long
      }
      line += "\n";
      lineSize++;
      lineNumber++;
      linePos = 0;
    }
    return line.charAt(linePos);
  } //nextChar()

}