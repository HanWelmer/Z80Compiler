//import java.io.BufferedReader;
//import java.io.BufferedWriter;
//import java.io.FileWriter;
//import java.io.IOException;
//import java.io.FileNotFoundException;
//import java.nio.file.Files;
//import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
//import java.util.Map;

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
        } else {
          usage();
        }
      }
    }
    
    //Do the tests.
    int error = 0;
    try {
      test(debugMode, verboseMode, z80, binary);
    } catch (RuntimeException e) {
      System.out.println(e.getMessage());
      System.out.println();
      e.printStackTrace();
      error = 1;
    }
    System.exit(error);
  }
  
  private static void usage() {
    System.out.println("Usage: java RegressionTest [-b] [-d] [-h] [-v] [-z] [?] | [help]");
    System.out.println(" where -b generate binary output (M-code or Z80 assembler).");
    System.out.println("       -d issue debug messages during compilation and verification.");
    System.out.println("       -h show this help message.");
    System.out.println("       -v verbose: issue verbode debug messages during compilation.");
    System.out.println("       -z generate and verify Z80 assembler output.");
    System.out.println("       ? show this help message.");
    System.out.println("       help show this help message.");
    System.exit(1);
  }

  /*
  * Run the regression tests.
  */
  private static void test(boolean debugMode, boolean verboseMode, boolean z80, boolean binary) {
    LexemeTestReader lexemeReader = new LexemeTestReader();
    PCompiler pCompiler = new PCompiler(debugMode, verboseMode);
    
    //P-Code to be tested.
    String testName = "Test8And16BitExpressionsReverseSubtractByte";

    ArrayList<String> sourceCode = new ArrayList<String>(
      Arrays.asList(
      "class Test8And16BitExpressionsReverseSubtractByte {"
      , "  write(10 - 3*3);"
      , "}"
      )
    );

    //Expected M-Code.
    ArrayList<String> expectedMachineCode = new ArrayList<String>(
      Arrays.asList(
      "  0 ://class Test8And16BitExpressionsReverseSubtractByte {"
      , "  1 ://  write(10 - 3*3);"
      , "  2 :acc8= constant 10"
      , "  3 :<acc8= constant 3"
      , "  4 :acc8* constant 3"
      , "  5 :-acc8 unstack"
      , "  6 ://}"
      , "  7 :call writeAcc8"
      //, "  8 :stop"
      )
    );
    //Expected Z80-Code.
    //TODO

    System.out.println(singleTest(debugMode, lexemeReader, pCompiler, testName, sourceCode, expectedMachineCode));
  }

  /*
  * Run a single test in the regression test suite.
  */
  private static String singleTest(boolean debugMode, LexemeTestReader lexemeReader, PCompiler pCompiler, String testName, ArrayList<String> sourceCode, ArrayList<String> expectedMachineCode) {
    lexemeReader.init(debugMode, testName, sourceCode);
    ArrayList<Instruction> instructions = pCompiler.compile(testName, lexemeReader);

    String result = null;
    // Compare M-code from compiler against expected M-code.
    int pos=0;
    boolean comparing = true;
    while (comparing) {
      if (pos < expectedMachineCode.size() && pos < instructions.size()) {
        if (expectedMachineCode.get(pos).equals(String.format("%3d :%s", pos, instructions.get(pos).toString()))) {
          pos++;
        } else {
          comparing = false;
        }
      } else {
        comparing = false;
      }
    }

    if (pos < expectedMachineCode.size() && pos == instructions.size()) {
      result = String.format("Error : %s(%d) received %d lines, which is less than %d; first missing line: %s", testName, pos, pos, expectedMachineCode.size(), expectedMachineCode.get(pos));
    } else if (pos < instructions.size() && pos == expectedMachineCode.size()) {
      result = String.format("Error : %s(%d) received %d lines, which is more than %d; first superfluous line: %3d :%s", testName, pos, instructions.size(), pos, pos, instructions.get(pos).toString());
    } else if (pos < expectedMachineCode.size() && pos < instructions.size()) {
      result = String.format("Error : %s(%d)\n  received: %s\n  expected: %s", testName, pos, String.format("%3d :%s", pos, instructions.get(pos).toString()), expectedMachineCode.get(pos));
    }

    // if (z80) {
      // Transcode M-code to Z80S180 assembler code.
      // if (verboseMode) System.out.println("Generating Z80 assembler code ...");
      // Transcoder transcoder = new Transcoder(debugMode, binary);
      // ArrayList<AssemblyInstruction> z80Instructions = transcoder.transcode(instructions);

      // Compare Z80-code from transcoder against expected Z80-code.
      // writeZ80Assembler(fileName, z80Instructions, verboseMode);
    // }

    if (result == null) {
      result = "OK : " + testName;
    }
    return result;
  }
  
  // private static void writeZ80Assembler(String fileName, ArrayList<AssemblyInstruction> z80Instructions, boolean verboseMode) {
    // /* write Z80S180 assembly code to an asm file */
    // String outputFilename = fileName.replace(".p", ".asm");
    // if (verboseMode) System.out.println("Writing Z80 assembler code to " + outputFilename);
    // BufferedWriter writer = null;
    // try {
        // writer = new BufferedWriter(new FileWriter(outputFilename));
        // for (AssemblyInstruction instruction : z80Instructions) {
          // writer.write(instruction.getCode());
          // writer.write("\n");
        // }
    // } catch (IOException e) {
        // System.out.println("\nException " + e.getMessage());
    // } finally {
      // if (writer != null) {
        // try {
          // writer.close();
        // } catch (IOException ee) {
          // System.out.println("\nException while closing: " + ee.getMessage());
        // }
      // }
    // }
  // }
  
  // private static void writeZ80toListing(String fileName
      // , ArrayList<AssemblyInstruction> z80Instructions
      // , Map<String, Long> labels
      // , Map<String, ArrayList<Long>> labelReferences
      // , boolean verboseMode) {
    // /* write Z80S180 assembly and binary code to a Listing file */
    // String outputFilename = fileName.replace(".p", ".lst");
    // if (verboseMode) System.out.println("Writing Z80 assembler and binary code to listing file " + outputFilename);
    // BufferedWriter writer = null;
    // try {
        // writer = new BufferedWriter(new FileWriter(outputFilename));
        // for (AssemblyInstruction instruction : z80Instructions) {
          // writer.write(String.format("%04X", instruction.getAddress()));
          // int nr = 0;
          // if (instruction.getBytes() != null) {
            // for (Byte oneByte : instruction.getBytes()) {
              // if (nr == 4) {
                // writer.write("\n    ");
                // nr = 0;
              // }
              // writer.write(String.format(" %02X", oneByte));
              // nr++;
            // }
          // }
          // while (nr < 4) {
            // writer.write("   ");
            // nr++;
          // }
          // writer.write(String.format(" %s\n", instruction.getCode()));
        // }

        ////assembler error: undefined label
        // boolean spacerNeeded = true;
        // for (String key : labelReferences.keySet()) {
          // if (labels.get(key) == null) {
            // if (spacerNeeded) {
              // writer.write("\n");
              // spacerNeeded = false;
            // }
            // writer.write("Error: undefined label: " + key + "\n");
            // System.out.println("Error: undefined label: " + key);
          // }
        // }
        
        ////dump label list
        // writer.write("\n");
        // writer.write("Labels:\n");
        // for (String key : labels.keySet()) {
          // writer.write(String.format("%04X : %s\n", labels.get(key), key));
        // }

        ////dump label cross reference list
        // writer.write("\n");
        // writer.write("Cross references:\n");
        // for (String key : labelReferences.keySet()) {
          // writer.write(String.format("%8s = %04X :", key, labels.get(key)));
          // for (Long address : labelReferences.get(key)) {
            // writer.write(String.format(" %04X", address));
          // }
          // writer.write("\n");
        // }
    // } catch (IOException e) {
        // System.out.println("\nException " + e.getMessage());
    // } finally {
      // if (writer != null) {
        // try {
          // writer.close();
        // } catch (IOException ee) {
          // System.out.println("\nException while closing: " + ee.getMessage());
        // }
      // }
    // }
  // }
  
  // private static void writeZ80toIntelHex(String fileName, ArrayList<AssemblyInstruction> z80Instructions, boolean verboseMode) {
    // /* write binary Z80S180 code to Intel hex file */
    // String outputFilename = fileName.replace(".p", ".hex");
    // if (verboseMode) System.out.println("Writing Z80 binary code to Intel hex file " + outputFilename);
    // IntelHexWriter writer = null;
    // try {
      // writer = new IntelHexWriter(outputFilename);
      // for (AssemblyInstruction instruction : z80Instructions) {
        // writer.write(instruction.getAddress(), instruction.getBytes());
      // }
    // } catch (IOException e) {
        // System.out.println("\nException: " + e.getMessage());
    // } finally {
      // if (writer != null) {
        // try {
          // writer.close();
        // } catch (IOException ee) {
          // System.out.println("\nException while closing: " + ee.getMessage());
        // }
      // }
    // }
  // }

}
