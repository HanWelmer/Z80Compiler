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

package com.github.HanWelmer;

import static org.junit.Assert.assertTrue;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.github.hanwelmer.Instruction;
import com.github.hanwelmer.LexemeReader;
import com.github.hanwelmer.pCompiler;

/**
 * Regression test for the Z80Compiler.
 */
public abstract class AbstactRegressionTest {
  // Configuration values.
  protected String jCodeLocation = "/src/test/resources/jCode/";
  protected String mCodeLocation = "/src/test/resources/mCode/";
  protected String expectedLocation = "/src/test/resources/expected/";
  protected boolean debugMode = false;
  protected boolean verboseMode = false;

  // Optionally override default configuration values.
  protected abstract void init();

  /*
   * Run a single test in the regression test suite.
   */
  protected boolean singleTest(String fileName) {
    // Optionally override default configuration values.
    init();
    // Compile miniJava-code to M-code instructions.
    LexemeReader lexemeReader = new LexemeReader();
    pCompiler pCompiler = new pCompiler(debugMode, verboseMode);

    assertTrue(fileName != null);
    assertTrue(lexemeReader != null);
    assertTrue(pCompiler != null);

    fileName.replace(".J", ".j");
    lexemeReader.init(debugMode, System.getProperty("user.dir") + jCodeLocation, fileName);
    ArrayList<Instruction> instructions = pCompiler.compile(lexemeReader);

    // List compiled code for the M machine.
    if (!instructions.isEmpty()) {
      writeListing(fileName, instructions, verboseMode);
    }

    // Compare M-code from compiler against expected M-code.
    FileReader fr;
    BufferedReader br;
    boolean result = false;
    try {
      int pos = 0;
      fr = new FileReader(System.getProperty("user.dir") + expectedLocation + fileName.replace(".j", ".exp"));
      br = new BufferedReader(fr);
      String actual = "";
      String expected = "";
      boolean proceed = true;
      while (br.ready() && pos < instructions.size() && proceed) {
        // actual M-Code.
        actual = String.format("%4d %s", pos, instructions.get(pos).toString());

        // expected M-Code.expected
        expected = br.readLine();

        // for debugging purposes
        // System.out.println("actual " + actual);
        // System.out.println("expected " + expected);

        // compared
        if (actual.equals(expected)) {
          pos++;
          // special cases for string comparisons
        } else if (actual.contains("\r")) {
          List<String> actualLines = Arrays.asList(actual.split("\r", -1));
          // for debugging purposes
          // System.out.println("actual contains carriage return.");
          // for (int i = 0; i<actualLines.size(); i++) {
          // System.out.println(i + " " + actualLines.get(i));
          // }
          // compare string sequences
          // System.out.println("actual 0 " + actualLines.get(0));
          // System.out.println("expected " + expected);
          if (!actualLines.get(0).equals(expected)) {
            System.out.println(
                String.format("Error : %s(%d)\n  received: 0 %s\n  expected: %s", fileName, pos, actualLines.get(0), expected));
            result = false;
            proceed = false;
          }
          expected = br.readLine();
          // System.out.println("actual 1 " + actualLines.get(1));
          // System.out.println("expected " + expected);
          if (!actualLines.get(1).equals(expected)) {
            System.out.println(
                String.format("Error : %s(%d)\n  received: 1 %s\n  expected: %s", fileName, pos, actualLines.get(1), expected));
            result = false;
            proceed = false;
          } else {
            pos++;
          }
        } else if (actual.contains("\n")) {
          List<String> actualLines = Arrays.asList(actual.split("\n", -1));
          // for debugging purposes
          // System.out.println("actual contains linefeed.");
          // for (int i = 0; i<actualLines.size(); i++) {
          // System.out.println(i + " " + actualLines.get(i));
          // }
          // compare string sequences
          // System.out.println("actual 0 " + actualLines.get(0));
          // System.out.println("expected " + expected);
          if (!actualLines.get(0).equals(expected)) {
            System.out.println(
                String.format("Error : %s(%d)\n  received: 0 %s\n  expected: %s", fileName, pos, actualLines.get(0), expected));
            result = false;
            proceed = false;
          }
          expected = br.readLine();
          // System.out.println("actual 1 " + actualLines.get(1));
          // System.out.println("expected " + expected);
          if (!actualLines.get(1).equals(expected)) {
            System.out.println(
                String.format("Error : %s(%d)\n  received: 1 %s\n  expected: %s", fileName, pos, actualLines.get(1), expected));
            result = false;
            proceed = false;
          } else {
            pos++;
          }
        } else {
          System.out.println(String.format("Error : %s(%d)\n  received: %s\n  expected: %s", fileName, pos, actual, expected));
          result = false;
          proceed = false;
        }
      }
      String error = "Error : %s(%d) received %d lines, which is %s than expected; first %s line: %4d :%s";
      if (!br.ready() && pos == instructions.size()) {
        result = true;
      } else if (pos == instructions.size()) {
        System.out.println(String.format(error, fileName, pos, pos, "less", "missing", pos, expected));
        result = false;
      } else {
        System.out.println(String.format(error, fileName, pos, instructions.size(), "more", "superfluous", pos, actual));
        result = false;
      }
      br.close();
    } catch (FileNotFoundException e) {
      System.out.println("Error : " + fileName + " : " + e.getMessage());
    } catch (IOException e) {
      System.out.println(e.getMessage());
      System.out.println("Error : " + fileName + " : " + e.getMessage());
    }

    return result;
  } // singleTest

  private void writeListing(String fileName, ArrayList<Instruction> instructions, boolean verboseMode) {
    /* write M assembly code to an *.m file */
    String outputFilename = System.getProperty("user.dir") + mCodeLocation + fileName.replace(".j", ".m");
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
  } // writeListing

}
