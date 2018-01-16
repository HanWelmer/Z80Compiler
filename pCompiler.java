import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

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
    boolean runMode = false;
    if (args.length == 0) {
      usage();
    } else if (args.length > 1) {
      for (int i=0; i<args.length-1; i++) {
        if ("-b".equals(args[i])) {
          binary = true;
        } else if ("-d".equals(args[i])) {
          debugMode = true;
        } else if ("-r".equals(args[i])) {
          runMode = true;
        } else if ("-z".equals(args[i])) {
          z80 = true;
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
    ArrayList<Instruction> instructions = null;
    try (FileReader fr = new FileReader(fileName); BufferedReader bufr = new BufferedReader(fr);) { 
      Compiler compiler = new Compiler(debugMode);
      instructions = compiler.compile(fileName, bufr);
    } catch (IOException e) {
      e.printStackTrace();
      System.exit(1);
    }
    
    if (instructions != null) { 
      /* List compiled code for the M machine */
      listing(instructions);
      if (z80) {
        /* transcode M-code to Z80S180 assembler code */
        ArrayList<AssemblyInstruction> z80Instructions = transcodeZ80(fileName, instructions, binary);
        if (binary) {
          /* write binary Z80S180 code to Intel hex file */
          writeZ80toIntelHex(fileName, z80Instructions);
        }
      }
      
      /* start interpreter */
      if (runMode) {
        /* input for the interpreter*/
        String inputString = "2 3 4 5 6 7 8 0";
        String[] inputParts = inputString.split(" ");
        System.out.println("Running compiled code ...");
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
    System.out.println(" where -b generate binary output (M-code or Z80 assembler");
    System.out.println("       -d issue debug messages during compilation");
    System.out.println("       -r run the compiled code using the built-in interpreter");
    System.out.println("       -z generate Z80 assembler output");
    System.out.println("       source.p input sourcecode file in P programming language.");
    System.exit(1);
  }

  private static void listing(ArrayList<Instruction> instructions) {
    System.out.println();
    System.out.println("Assembly listing of compiled code:");
    System.out.println("----------------------------------");
    int pos=0;
    for (Instruction instruction: instructions) {
      //TODO : add pos as lineNr to Instruction
      System.out.println(String.format("%3d :", pos++) + instruction.toString());
    }
    System.out.println();
  }
  
  /* transcode M-code to Z80S180 assembler code */
  private static ArrayList<AssemblyInstruction> transcodeZ80(String fileName, ArrayList<Instruction> instructions, boolean binary) {
    System.out.println("Generating Z80 assembler code ...");
    Transcoder transcoder = new Transcoder(binary);
    ArrayList<AssemblyInstruction> z80Instructions = transcoder.transcode(instructions);

    /* write Z80 assembly code */
    String outputFilename = fileName.replace(".p", ".asm");
    System.out.println("Writing Z80 assembler code to " + outputFilename);
    try {
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFilename));
        for (AssemblyInstruction instruction : z80Instructions) {
          out.write(instruction.getCode());
          out.write("\n");
        }
        out.close();
    } catch (IOException e) {
        System.out.println("\nException " + e.getMessage());
    }
    return z80Instructions;
  }
  
  private static void writeZ80toIntelHex(String fileName, ArrayList<AssemblyInstruction> z80Instructions) {
    /* write binary Z80S180 code to Intel hex file */
    String outputFilename = fileName.replace(".p", ".hex");
    System.out.println("Writing Z80 binary code to Intel hex file " + outputFilename);
    IntelHexWriter writer = null;
    try {
      writer = new IntelHexWriter(outputFilename);
      for (AssemblyInstruction instruction : z80Instructions) {
        writer.write(instruction.getAddress(), instruction.getBytes());
      }
    } catch (IOException e) {
        System.out.println("\nException: " + e.getMessage());
    } finally {
      if (writer != null) {
        try {
          writer.close();
        } catch (IOException ee) {
          System.out.println("\nException while closing: " + ee.getMessage());
        }
      }
    }
  }

}
