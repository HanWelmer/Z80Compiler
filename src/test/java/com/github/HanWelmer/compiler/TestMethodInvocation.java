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

package com.github.HanWelmer.compiler;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

/**
 * Regression test for the Z80Compiler.
 */
public class TestMethodInvocation extends AbstactRegressionTest {

  protected void init() {
    final String testName = "methodInvocation";
    // Override default configuration values.
    jCodeLocation = "/src/test/resources/jCode/" + testName + "/";
    mCodeLocation = "/src/test/resources/mCode/" + testName + "/";
    expectedLocation = "/src/test/resources/expected/" + testName + "/";
    debugMode = false;
    verboseMode = false;
  }

  @Test
  public void testNoParameters() {
    assertTrue(singleTest("TestNoParameters.j"));
  }

  @Test
  public void testOneParameterIsoNone() {
    String testOutput = testWithRedirectedSystemOut("TestOneParameterIsoNone.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 4);
    assertTrue("           ^number of arguments does not match number of formal parameters.\r".equals(lines[2]));
    assertTrue("1 error.\r".equals(lines[3]));
    System.out.println("As expected.\n");
  }

  @Test
  public void testByteParameter() {
    assertTrue(singleTest("TestByteParameter.j"));
  }

  @Test
  public void testWordParameter() {
    assertTrue(singleTest("TestWordParameter.j"));
  }

  @Test
  public void testImportLocalClass() {
    assertTrue(singleTest("TestImportLocalClass.j"));
  }

}
