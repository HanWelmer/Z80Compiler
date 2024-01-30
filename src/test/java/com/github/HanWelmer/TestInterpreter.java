package com.github.HanWelmer;

import java.io.File;
import java.util.ArrayList;

import org.junit.Test;

import com.github.hanwelmer.FunctionType;
import com.github.hanwelmer.Instruction;
import com.github.hanwelmer.Interpreter;
import com.github.hanwelmer.MachineCodeParser;

public class TestInterpreter {

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
    boolean debugMode = false;
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
    int pc = interpreter.findMainMethod();
    while (pc < instructions.size() && instructions.get(pc).function != FunctionType.stop) {
      pc = interpreter.step(pc);
    }
  }

  @Test
  public void TestPublicStaticMain() {
    String path = "methodDeclaration";
    String fileName = "TwoMethods.m";
    String inputString = "2 3 4 5 6 7 8 0";

    singleTest(path, fileName, inputString.split(" "));
  }

  @Test
  public void TestNoMain() {
    String path = "methodDeclaration";
    String fileName = "NoMain.m";
    String inputString = "2 3 4 5 6 7 8 0";

    try {
      singleTest(path, fileName, inputString.split(" "));
    } catch (RuntimeException e) {
      if ("Class does not contain a main method.".equals(e.getMessage())) {
        System.out.println("This is an expected error.");
      } else {
        throw e;
      }
    }
  }
}
