/*
Copyright © 2023 Han Welmer.

This file is part of Z80Compiler.

Z80Compiler is free software: you can redistribute it and/or modify it under 
the terms of the GNU General Public License as published by the Free Software 
Foundation, either version 3 of the License, or (at your option) any later 
version.

Z80Compiler is distributed in the hope that it will be useful, but WITHOUT 
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with 
Z80Compiler. If not, see <https://www.gnu.org/licenses/>.
*/

package com.github.hanwelmer;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;

/**
 * Command line fascade for the miniJava programming language compiler, based on
 * the Programming language as described in Compiler Engineering Using Pascal by
 * P.C. Capon and P.J. Jinks. See usage() for a functional description.
 */
public class Z80Compiler {

  /**
   * The main method for the compiler. See usage() for a functional description.
   * 
   * @param args
   *          the argument list.
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
      for (int i = 0; i < args.length - 1; i++) {
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
    String fileName = args[args.length - 1];
    if (fileName.startsWith("-")) {
      usage();
    }

    /*
     * Force file extension to lower case j. Compile the file with miniJava
     * source code. Generated intermediate code goes to default system output.
     */
    LexemeReader lexemeReader = new LexemeReader();
    pCompiler pCompiler = new pCompiler(debugMode, verboseMode);
    fileName = fileName.replace(".J", ".j");
    ArrayList<Instruction> instructions = null;
    if (lexemeReader.init(debugMode, "./", fileName)) {
      try {
        deleteOldOutput(fileName);
        instructions = pCompiler.compile(lexemeReader);

        if (!instructions.isEmpty()) {
          // List compiled code for the M machine.
          writeListing(fileName, instructions, verboseMode);
          if (z80) {
            // Transcode M-code to Z80S180 assembler code.
            if (verboseMode)
              System.out.println("Generating Z80 assembler code ...");
            Transcoder transcoder = new Transcoder(debugMode);
            ArrayList<AssemblyInstruction> z80Instructions = transcoder.transcode(instructions);
            transcoder.writeZ80Assembler(fileName.replace(".j", ".asm"), z80Instructions, verboseMode);

            if (binary) {
              transcoder.writeZ80toListing(fileName.replace(".j", ".lst"), z80Instructions, verboseMode);
              transcoder.writeZ80toIntelHex(fileName.replace(".j", ".hex"), z80Instructions, verboseMode);
            }
          }

          // Start interpreter.
          if (runMode) {
            // Input for the interpreter.
            // TODO refactor: use input file per test*.j test file.
            String inputString = "2 3 4 5 6 7 8 0";
            String[] inputParts = inputString.split(" ");
            System.out.println("\nRunning compiled code ...\n");
            Interpreter interpreter = new Interpreter(debugMode, instructions, inputParts);
            int pc = 0;
            while (pc < instructions.size() && instructions.get(pc).function != FunctionType.stop) {
              pc = interpreter.step(pc);
            }
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
    if (verboseMode)
      System.out.println("Writing M code to " + outputFilename);
    BufferedWriter writer = null;
    try {
      writer = new BufferedWriter(new FileWriter(outputFilename));
      int pos = 0;
      for (Instruction instruction : instructions) {
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

}
