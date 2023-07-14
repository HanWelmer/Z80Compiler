import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Map;
import java.util.TreeMap;

/**
 * Command line fascade for the miniJava programming language compiler, based on the Programming language as described 
   in Compiler Engineering Using Pascal by P.C. Capon and P.J. Jinks.
 * See usage() for a functional description.
 */
public class Z80Compiler {

  /**
  * The main method for the compiler.
  * See usage() for a functional description.
  * @param args the argument list.
  */
  public static void main(String[] args) {

  /* process command line options */
    boolean z80 = false;
    boolean binary = false;
    boolean debugMode = false;
    boolean runMode = false;
    boolean verboseMode = false;
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
        } else if ("-v".equals(args[i])) {
          verboseMode = true;
        } else if ("-z".equals(args[i])) {
          z80 = true;
        } else {
          usage();
        }
      }
    }
    
    /* Get filename of source code file from arg list */
    String fileName = args[args.length-1];
    if (fileName.startsWith("-")) {
      usage();
    }

    /*
    * Force file extension to lower case j.
    * Compile the file with miniJava source code.
    * Generated intermediate code goes to default system output.
    */
    LexemeReader lexemeReader = new LexemeReader();
    pCompiler pCompiler = new pCompiler(debugMode, verboseMode);
    fileName = fileName.replace(".J", ".j");
    ArrayList<Instruction> instructions = null;
    if (lexemeReader.init(debugMode, fileName)) {
      try {
        deleteOldOutput(fileName);
        instructions = pCompiler.compile(fileName, lexemeReader);

        if (!instructions.isEmpty()) {
          /* List compiled code for the M machine */
          writeListing(fileName, instructions, verboseMode);
          if (z80) {
            /* transcode M-code to Z80S180 assembler code */
            if (verboseMode) System.out.println("Generating Z80 assembler code ...");
            Transcoder transcoder = new Transcoder(debugMode, binary);
            ArrayList<AssemblyInstruction> z80Instructions = transcoder.transcode(instructions);

            writeZ80Assembler(fileName, z80Instructions, verboseMode);

            if (binary) {
              writeZ80toIntelHex(fileName, z80Instructions, verboseMode);
              writeZ80toListing(fileName, z80Instructions, transcoder.labels, transcoder.labelReferences, verboseMode);
            }
          }
          
          /* start interpreter */
          if (runMode) {
            /* input for the interpreter*/
            String inputString = "2 3 4 5 6 7 8 0";
            String[] inputParts = inputString.split(" ");
            System.out.println("\nRunning compiled code ...\n");
            Interpreter interpreter = new Interpreter(debugMode, instructions, inputParts);
            boolean stop = false;
            do {
              stop = interpreter.step();
            } while (!stop);
          }
        }
      } catch (RuntimeException e) {
        System.out.println();
        System.out.println(e.getMessage());
        System.out.println();
        e.printStackTrace();
        System.exit(1);
      }
    } else {
      System.exit(1);
    }
  }
  
  private static void usage() {
    System.out.println("Usage: Z80Compiler [-Z80] [-b] [-d] source.j");
    System.out.println(" where -b generate binary output (M-code or Z80 assembler)");
    System.out.println("       -d issue debug messages during compilation");
    System.out.println("       -r run the compiled code using the built-in interpreter");
    System.out.println("       -v verbose: issue feedback messages during compilation");
    System.out.println("       -z generate Z80 assembler output");
    System.out.println("       source.j input sourcecode file in miniJava programming language.");
    System.exit(1);
  }

  private static void deleteOldOutput(String fileName) {
    String outputFilename = fileName.replace(".j", ".m");
    try {
      Files.deleteIfExists(Paths.get(outputFilename));
      outputFilename = fileName.replace(".j", ".asm");
      Files.deleteIfExists(Paths.get(outputFilename));
      outputFilename = fileName.replace(".j", ".lst");
      Files.deleteIfExists(Paths.get(outputFilename));
      outputFilename = fileName.replace(".j", ".hex");
      Files.deleteIfExists(Paths.get(outputFilename));
    } catch (IOException x) {
        // File permission problems are caught here.
        System.err.println("Failed to delete " + outputFilename);
        System.exit(1);
    }
  }
  
  private static void writeListing(String fileName, ArrayList<Instruction> instructions, boolean verboseMode) {
    /* write M assembly code to an *.m file */
    String outputFilename = fileName.replace(".j", ".m");
    if (verboseMode) System.out.println("Writing M code to " + outputFilename);
    BufferedWriter writer = null;
    try {
        writer = new BufferedWriter(new FileWriter(outputFilename));
        int pos=0;
        for (Instruction instruction: instructions) {
          writer.write(String.format("%4d %s\n", pos++, instruction.toString()));
        }
    } catch (IOException e) {
        System.out.println("\nException " + e.getMessage());
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
  
  private static void writeZ80Assembler(String fileName, ArrayList<AssemblyInstruction> z80Instructions, boolean verboseMode) {
    /* write Z80S180 assembly code to an asm file */
    String outputFilename = fileName.replace(".j", ".asm");
    if (verboseMode) System.out.println("Writing Z80 assembler code to " + outputFilename);
    BufferedWriter writer = null;
    try {
        writer = new BufferedWriter(new FileWriter(outputFilename));
        for (AssemblyInstruction instruction : z80Instructions) {
          writer.write(instruction.getCode());
          writer.write("\n");
        }
    } catch (IOException e) {
        System.out.println("\nException " + e.getMessage());
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
  
  private static void writeZ80toListing(String fileName
      , ArrayList<AssemblyInstruction> z80Instructions
      , Map<String, Integer> labels
      , Map<String, ArrayList<Integer>> labelReferences
      , boolean verboseMode) {
    /* write Z80S180 assembly and binary code to a Listing file */
    String outputFilename = fileName.replace(".j", ".lst");
    if (verboseMode) System.out.println("Writing Z80 assembler and binary code to listing file " + outputFilename);
    BufferedWriter writer = null;
    try {
        writer = new BufferedWriter(new FileWriter(outputFilename));
        for (AssemblyInstruction instruction : z80Instructions) {
          writer.write(String.format("%04X", instruction.getAddress()));
          int nr = 0;
          if (instruction.getBytes() != null) {
            for (Byte oneByte : instruction.getBytes()) {
              if (nr == 4) {
                writer.write("\n    ");
                nr = 0;
              }
              writer.write(String.format(" %02X", oneByte));
              nr++;
            }
          }
          while (nr < 4) {
            writer.write("   ");
            nr++;
          }
          writer.write(String.format(" %s\n", instruction.getCode()));
        }

        //assembler error: undefined label
        boolean spacerNeeded = true;
        for (String key : labelReferences.keySet()) {
          if (labels.get(key) == null) {
            if (spacerNeeded) {
              writer.write("\n");
              spacerNeeded = false;
            }
            writer.write("Error: undefined label: " + key + "\n");
            System.out.println("Error: undefined label: " + key);
          }
        }
        
        //dump label cross reference list
        writer.write("\n");
        writer.write("Labels and cross references:\n");
        Map<String, Integer> sortedLabels = new TreeMap<String, Integer>(labels);
        for (Map.Entry<String, Integer> entry : sortedLabels.entrySet()) {
          writer.write(String.format("%8s = %04X :", entry.getKey(), entry.getValue()));
          if (labelReferences.get(entry.getKey()) != null) {
            int refCount = 0;
            for (Integer address : labelReferences.get(entry.getKey())) {
              writer.write(String.format(" %04X", address));
              if (refCount==11) {
                writer.write(String.format("\n%16s:", " "));
                refCount = 0;
              } else {
                refCount++;
              }
            }
          }
          writer.write("\n");
        }        
    } catch (IOException e) {
        System.out.println("\nException " + e.getMessage());
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
  
  private static void writeLabel(BufferedWriter writer, String label, Integer value) {
    try {
      writer.write(String.format("%04X : %s\n", value, label));
    } catch (IOException e) {
      System.out.println("\nException " + e.getMessage());
    }
  }
  
  private static void writeZ80toIntelHex(String fileName, ArrayList<AssemblyInstruction> z80Instructions, boolean verboseMode) {
    /* write binary Z80S180 code to Intel hex file */
    String outputFilename = fileName.replace(".j", ".hex");
    if (verboseMode) System.out.println("Writing Z80 binary code to Intel hex file " + outputFilename);
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