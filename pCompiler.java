import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

/**
 * Command line fascade for the P programming language Compiler, as described in Compiler Engineering Using Pascal by P.C. Capon and P.J. Jinks.
 * See usage() for a functional description.
 */
public class pCompiler {

  /**
  * The main method for the pCompiler.
  * See usage() for a functional description.
  * @param args the argument list.
  */
  public static void main(String[] args) {

  /* process command line options */
    boolean z80 = false;
    boolean binary = false;
    boolean debugMode = false;
    if (args.length > 1) {
      for (int i=0; i<args.length-1; i++) {
        if ("-Z80".equals(args[i])) {
          z80 = true;
        } else if ("-b".equals(args[i])) {
          binary = true;
        } else if ("-d".equals(args[i])) {
          debugMode = true;
        } else {
          usage();
        }
      }
    }
    
    /* get filename of source code file from arg list */
    String fileName = args[args.length-1];
    if (fileName.startsWith("-")) {
      usage();
    }

    /*
    * Compile the file with p source code.
    * Generated intermediate code goes to default system output.
    */
    Instruction[] instructions = null;
    try (FileReader fr = new FileReader(fileName); BufferedReader bufr = new BufferedReader(fr);) { 
      Compiler compiler = new Compiler(debugMode, z80, binary);
      instructions = compiler.compile(fileName, bufr);
    } catch (IOException e) {
      e.printStackTrace();
      System.exit(1);
    }
    
    /* Generate output */
    if (instructions != null) { 
      if (z80) {
        String[] storeString = null;
        int[] storeBytes = null;
        listZ80(fileName, binary, storeString, storeBytes);
      } else {
        listing(instructions);
        /* input for the interpreter*/
        String inputString = "2 3 4 5 6 7 8 0";
        String[] inputParts = inputString.split(" ");

        /* start interpreter */
        System.out.println("Running compiled code...");
        Interpreter interpreter = new Interpreter(instructions, inputParts);
        boolean stop = false;
        do {
          stop = interpreter.step(debugMode);
        } while (!stop);
      }
    }
  }
  
  private static void usage() {
    System.out.println("Usage: pCompiler [-Z80] [-b] [-d] source.p");
    System.out.println(" where -Z80 generate Z80 assembler output");
    System.out.println("       -b generate binary output (M-code or Z80 assembler");
    System.out.println("       -d issue debug messages during compilation");
    System.out.println("       source.p input sourcecode file in P programming language.");
    System.exit(1);
  }

  private static void listing(Instruction[] instructions) {
    System.out.println();
    System.out.println("Assembly listing of compiled code:");
    System.out.println("----------------------------------");
    int pos=0;
    while (pos < instructions.length && instructions[pos] != null) {
      System.out.println(String.format("%3d :", pos) + instructions[pos].toString());
      pos++;
    }
    System.out.println();
  }
  
  private static void listZ80(String fileName, boolean binary, String[] storeString, int[] storeBytes) {
    if (binary) {
      /* write assembled Z80 bytes */
      String outputFilename = fileName.replace(".p", ".obj");
      try {
          BufferedWriter out = new BufferedWriter(new FileWriter(outputFilename));
          for (int pos=0; pos < storeBytes.length;pos++) {
            //out.write(storeBytes[pos] + "\n");
            out.write(String.format("%02X\n", storeBytes[pos]));
          }
          out.close();
      } catch (IOException e)
      {
          System.out.println("\nException " + e.getMessage());
      }
    } else {
      /* write Z80 assembly code */
      String outputFilename = fileName.replace(".p", ".asm");
      try {
          BufferedWriter out = new BufferedWriter(new FileWriter(outputFilename));
          for (int pos=0; pos < storeString.length;pos++) {
            out.write(storeString[pos] + "\n");
          }
          out.close();
      } catch (IOException e)
      {
          System.out.println("\nException " + e.getMessage());
      }
    }
  } //listZ80

}
