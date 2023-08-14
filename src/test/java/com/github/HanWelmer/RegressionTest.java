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
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

/**
 * Regression test for the Z80Compiler.
 */
public class RegressionTest
{
  private final static String jCodeLocation = "/src/test/resources/jCode/";
  private final static String expectedLocation = "/src/test/resources/expected/";
  private final static boolean debugMode = false;
  private final static boolean verboseMode = false;

  @Test
  public void test() { assertTrue( singleTest("test.j") ); }

  @Test
  public void test0() { assertTrue( singleTest("test0.j") ); }

  @Test
  public void test1() { assertTrue( singleTest("test1.j") ); }

  @Test
  public void test2() { assertTrue( singleTest("test2.j") ); }

  @Test
  public void test3() { assertTrue( singleTest("test3.j") ); }

  @Test
  public void test4() { assertTrue( singleTest("test4.j") ); }

  @Test
  public void test5() { assertTrue( singleTest("test5.j") ); }

  @Test
  public void test6() { assertTrue( singleTest("test6.j") ); }

  @Test
  public void test7() { assertTrue( singleTest("test7.j") ); }

  @Test
  public void test8() { assertTrue( singleTest("test8.j") ); }

  @Test
  public void test9() { assertTrue( singleTest("test9.j") ); }

  @Test
  public void test10() { assertTrue( singleTest("test10.j") ); }

  @Test
  public void test11() { assertTrue( singleTest("test11.j") ); }

  @Test
  public void test12() { assertTrue( singleTest("test12.j") ); }

  @Test
  public void test13() { assertTrue( singleTest("test13.j") ); }

  @Test
  public void test14() { assertTrue( singleTest("test14.j") ); }

  @Test
  public void test15() { assertTrue( singleTest("test15.j") ); }

  /*
  * Run a single test in the regression test suite.
  */
  private boolean singleTest(String fileName) {
    // Compile miniJava-code to M-code instructions.
    LexemeReader lexemeReader = new LexemeReader();
    pCompiler pCompiler = new pCompiler(debugMode, verboseMode);

    assertTrue(fileName != null);
    assertTrue(lexemeReader != null);
    assertTrue(pCompiler != null);

    fileName.replace(".J", ".j");
    lexemeReader.init(debugMode, System.getProperty("user.dir") + jCodeLocation, fileName);
    ArrayList<Instruction> instructions = pCompiler.compile(lexemeReader);

    // Compare M-code from compiler against expected M-code.
    FileReader fr; 
    BufferedReader br;
    boolean result = false;
    try {
      int pos=0;
      fr = new FileReader(System.getProperty("user.dir") + expectedLocation + fileName.replace(".j", ".exp")); 
      br = new BufferedReader(fr);
      String actual = "";
      String expected = "";
      while (br.ready() && pos < instructions.size()) {
        //actual M-Code.
        actual = String.format("%4d %s", pos, instructions.get(pos).toString());

        //expected M-Code.expected
        expected = br.readLine();
        
        //for debugging purposes
        //System.out.println("actual   " + actual);
        //System.out.println("expected " + expected);

        //compared
        if (actual.equals(expected)) {
          pos++;
        //special cases for string comparisons
        } else if (actual.contains("\r")) {
          List<String> actualLines = Arrays.asList(actual.split("\r", -1));
          // for debugging purposes
          //System.out.println("actual contains carriage return.");
          //for (int i = 0; i<actualLines.size(); i++) {
          //  System.out.println(i + " " + actualLines.get(i));
          //}
          // compare string sequences
          //System.out.println("actual 0 " + actualLines.get(0));
          //System.out.println("expected " + expected);
          if (!actualLines.get(0).equals(expected)) {
            System.out.println(String.format("Error : %s(%d)\n  received: 0 %s\n  expected: %s", fileName, pos, actualLines.get(0), expected));
            return false;
          }
          expected = br.readLine();
          //System.out.println("actual 1 " + actualLines.get(1));
          //System.out.println("expected " + expected);
          if (!actualLines.get(1).equals(expected)) {
            System.out.println(String.format("Error : %s(%d)\n  received: 1 %s\n  expected: %s", fileName, pos, actualLines.get(1), expected));
            return false;
          } else {
            pos++;
          }
        } else if (actual.contains("\n")) {
          List<String> actualLines = Arrays.asList(actual.split("\n", -1));
          // for debugging purposes
          //System.out.println("actual contains linefeed.");
          //for (int i = 0; i<actualLines.size(); i++) {
          //  System.out.println(i + " " + actualLines.get(i));
          //}
          // compare string sequences
          //System.out.println("actual 0 " + actualLines.get(0));
          //System.out.println("expected " + expected);
          if (!actualLines.get(0).equals(expected)) {
            System.out.println(String.format("Error : %s(%d)\n  received: 0 %s\n  expected: %s", fileName, pos, actualLines.get(0), expected));
            return false;
          }
          expected = br.readLine();
          //System.out.println("actual 1 " + actualLines.get(1));
          //System.out.println("expected " + expected);
          if (!actualLines.get(1).equals(expected)) {
            System.out.println(String.format("Error : %s(%d)\n  received: 1 %s\n  expected: %s", fileName, pos, actualLines.get(1), expected));
            return false;
          } else {
            pos++;
          }
        } else {
          System.out.println(String.format("Error : %s(%d)\n  received: %s\n  expected: %s", fileName, pos, actual, expected));
          return false;
        }
      }
     String error = "Error : %s(%d) received %d lines, which is %s than expected; first %s line: %4d :%s";
     if (!br.ready() && pos == instructions.size()) {
        result = true;
     } else if (pos == instructions.size()) {
        System.out.println(String.format(error, fileName, pos, pos, "less", "missing", pos, expected));
     } else {
        System.out.println(String.format(error, fileName, pos, instructions.size(), "more", "superfluous", pos, actual));
     }
    } catch (FileNotFoundException e) {
      System.out.println("Error : " + fileName + " : " + e.getMessage());
    } catch (IOException e) {
      System.out.println(e.getMessage());
      System.out.println("Error : " + fileName + " : " + e.getMessage());
    }
    
    return result;
  } //singleTest
}
