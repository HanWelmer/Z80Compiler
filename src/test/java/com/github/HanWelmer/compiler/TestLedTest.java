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
    final String testName = "ledtest/5_ImportThread";
    // Override default configuration values.
    jCodeLocation = "/src/test/resources/jCode/" + testName + "/";
    mCodeLocation = "/src/test/resources/jCode/" + testName + "/";
    expectedLocation = "/src/test/resources/expected/" + testName + "/";
    debugMode = false;
    verboseMode = false;
  }

  @Test
  public void test5_ImportThread() {
    assertTrue(singleTest("ledtst.j"));
  }

}
