package com.github.HanWelmer;

import java.util.ArrayList;

import org.junit.Test;

import com.github.hanwelmer.FunctionType;
import com.github.hanwelmer.Instruction;
import com.github.hanwelmer.Interpreter;
import com.github.hanwelmer.MachineCodeParser;

public class TestInterpreter {

  protected static final String EXPECTED_LOCATION = "/src/test/resources/expected/";

  @Test
  public void TestPublicStaticMain() {
    String fileName = "methodDeclaration/TwoMethods.m";
    boolean debugMode = false;

    String qualifiedFileName = System.getProperty("user.dir") + EXPECTED_LOCATION + fileName;
    MachineCodeParser parser = new MachineCodeParser();
    ArrayList<Instruction> instructions = parser.readMachineCode(qualifiedFileName);

    String inputString = "2 3 4 5 6 7 8 0";
    String[] inputParts = inputString.split(" ");
    System.out.println("\nRunning compiled code ...\n");

    Interpreter interpreter = new Interpreter(debugMode, instructions, inputParts);
    int pc = interpreter.findMainMethod();
    while (pc < instructions.size() && instructions.get(pc).function != FunctionType.stop) {
      pc = interpreter.step(pc);
    }
  }
}
