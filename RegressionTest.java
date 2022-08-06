import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.ArrayList;

/**
 * Class for the regression test of the compiler for the P programming language compiler.
 */
public class RegressionTest {

  /**
  * The main method for the regression test.
  * command line options:
  * -z verify Z80 output as well as M-code output.
  * -d debugmode.
  * -v verbose debugmode.
  */
  public static void main(String[] args) {
    //Process command line options.
    boolean debugMode = false;
    boolean verboseMode = false;
    boolean z80 = false;
    boolean binary = false;
    String filename = "RegressionTest.txt";
    if (args.length > 0) {
      for (int i=0; i<args.length; i++) {
        if ("-b".equals(args[i])) {
          binary = true;
        } else if ("-h".equals(args[i])) {
          usage();
        } else if ("-d".equals(args[i])) {
          debugMode = true;
        } else if ("-v".equals(args[i])) {
          verboseMode = true;
        } else if ("-z".equals(args[i])) {
          z80 = true;
        } else if ("?".equals(args[i])) {
          usage();
        } else if ("help".equals(args[i])) {
          usage();
        } else if (args[i].length() >= 3) {
          filename = args[i];
        } else {
          usage();
        }
      }
    }
    
    //Do the tests.
    int error = 0;
    try {
      test(debugMode, verboseMode, z80, binary, filename);
    } catch (RuntimeException e) {
      System.out.println(e.getMessage());
      System.out.println();
      e.printStackTrace();
      error = 1;
    }
    System.exit(error);
  }
  
  private static void usage() {
    System.out.println("Usage: java RegressionTest [-b] [-d] [-h] [-v] [-z] [?] | [help] [filename]");
    System.out.println(" where -b generate binary output (M-code or Z80 assembler).");
    System.out.println("       -d issue debug messages during compilation and verification.");
    System.out.println("       -h show this help message.");
    System.out.println("       -v verbose: issue verbode debug messages during compilation.");
    System.out.println("       -z generate and verify Z80 assembler output.");
    System.out.println("       ? show this help message.");
    System.out.println("       help show this help message.");
    System.out.println("       filename (default: RegressionTest.txt) each line a *.j file which will be compiled and the output compared with *.exp.");
    System.exit(1);
  }

  /*
  * Run the regression tests.
  */
  private static void test(boolean debugMode, boolean verboseMode, boolean z80, boolean binary, String testSuite) {
    LexemeReader lexemeReader = new LexemeReader();
    pCompiler pCompiler = new pCompiler(debugMode, verboseMode);
    
    //Open de test suite file.
    FileReader testSuiteFileReader; 
    BufferedReader testSuiteBufferedReader;
    try {
      testSuiteFileReader = new FileReader(testSuite); 
      testSuiteBufferedReader = new BufferedReader(testSuiteFileReader);

      //Read filenames from the testsuite.
      while (testSuiteBufferedReader.ready()) {
        //miniJava-Code to be tested.
        String fileName = testSuiteBufferedReader.readLine();

        //Run the test.
        System.out.println(singleTest(debugMode, lexemeReader, pCompiler, fileName));
      }
    } catch (FileNotFoundException e) {
      System.out.println(e.getMessage());
      return;
    } catch (IOException e) {
      System.out.println(e.getMessage());
      return;
    }
  }

  /*
  * Run a single test in the regression test suite.
  */
  private static String singleTest(boolean debugMode, LexemeReader lexemeReader, pCompiler pCompiler, String fileName) {
    // Compile miniJava-code to M-code instructions.
    fileName.replace(".J", ".j");
    lexemeReader.init(debugMode, fileName);
    ArrayList<Instruction> instructions = pCompiler.compile(fileName, lexemeReader);

    // Compare M-code from compiler against expected M-code.
    FileReader fr; 
    BufferedReader br;
    String result;
    try {
      int pos=0;
      fr = new FileReader(fileName.replace(".j", ".exp")); 
      br = new BufferedReader(fr);
      String actual = "";
      String expected = "";
      while (br.ready() && pos < instructions.size()) {
        //actual M-Code.
        actual = String.format("%4d %s", pos, instructions.get(pos).toString());

        //expected M-Code.expected
        expected = br.readLine();

        //compared
        if (actual.equals(expected)) {
          pos++;
        } else {
          return String.format("Error : %s(%d)\n  received: %s\n  expected: %s", fileName, pos, actual, expected);
        }
      }
     String error = "Error : %s(%d) received %d lines, which is %s than expected; first %s line: %4d :%s";
     if (!br.ready() && pos == instructions.size()) {
        result = "OK : " + fileName;
     } else if (pos == instructions.size()) {
        result = String.format(error, fileName, pos, pos, "less", "missing", pos, expected);
     } else {
        result = String.format(error, fileName, pos, instructions.size(), "more", "superfluous", pos, actual);
     }
    } catch (FileNotFoundException e) {
      result = "Error : " + fileName + " : " + e.getMessage();
    } catch (IOException e) {
      System.out.println(e.getMessage());
      result = "Error : " + fileName + " : " + e.getMessage();
    }
    
    return result;
  } //singleTest
}
