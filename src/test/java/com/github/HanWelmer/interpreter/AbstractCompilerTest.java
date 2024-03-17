package com.github.HanWelmer.interpreter;

import java.io.File;
import java.util.ArrayList;

import com.github.hanwelmer.FunctionType;
import com.github.hanwelmer.Instruction;
import com.github.hanwelmer.Interpreter;
import com.github.hanwelmer.MachineCodeParser;

public abstract class AbstractCompilerTest {

  protected static final String EXPECTED_LOCATION = "\\src\\test\\resources\\expected\\";

  /**
   * Test the interpreter against a file with machine code and an optional set
   * of input strings.
   * 
   * @param path
   *          optional path for the file to be executed.
   * @param fileName
   *          of a file with machine code (*.m) to be executed by the
   *          interpreter.
   * @param inputParts
   *          optional set of Strings, that can be used as input by the read()
   *          function.
   */
  protected void singleTest(String path, String fileName, String[] inputParts) {
    boolean debugMode = true;
    System.out.println("\nRunning compiled code ...");

    // determine the full qualified file name.
    String qualifiedFileName = System.getProperty("user.dir") + EXPECTED_LOCATION;
    if (path != null) {
      if (!path.endsWith(File.separator)) {
        path += File.separator;
      }
      qualifiedFileName += path;
    }
    qualifiedFileName += fileName;

    // Read the file with M-code instructions.
    MachineCodeParser parser = new MachineCodeParser();
    ArrayList<Instruction> instructions = parser.readMachineCode(qualifiedFileName);

    // Create and run the interpreter, starting with the main() function.
    Interpreter interpreter = new Interpreter(debugMode, instructions, inputParts);
    int pc = 0;
    while (pc < instructions.size() && instructions.get(pc).function != FunctionType.stop) {
      pc = interpreter.step(pc);
    }
  }

}
