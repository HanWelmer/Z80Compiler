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
public class TestLedTest extends AbstactRegressionTest {

  protected void init() {
    debugMode = false;
    verboseMode = false;
  }

  protected void setConfig(String testName) {
    // Override default configuration values.
    jCodeLocation = "/src/test/resources/jCode/" + testName + "/";
    mCodeLocation = "/src/test/resources/jCode/" + testName + "/";
    expectedLocation = "/src/test/resources/expected/" + testName + "/";
  }

  // @Test obsolete as sleep() is no longer a built-in method in the runtime
  // software.
  public void test1() {
    setConfig("ledtest/1_OneMethod");
    assertTrue(singleTest("ledtst.j"));
  }

  // @Test obsolete as sleep() is no longer a built-in method in the runtime
  // software.
  public void test2() {
    setConfig("ledtest/2_ParameterLessMethods");
    assertTrue(singleTest("ledtst.j"));
  }

  @Test
  public void test3() {
    setConfig("ledtest/3_LocalVariableNoParameter");
    assertTrue(singleTest("ledtst.j"));
  }

  @Test
  public void test4() {
    setConfig("ledtest/4_MethodWithParameters");
    assertTrue(singleTest("ledtst.j"));
  }

  @Test
  public void test5() {
    setConfig("ledtest/5_ImportThread");
    assertTrue(singleTest("ledtst.j"));
  }

}
