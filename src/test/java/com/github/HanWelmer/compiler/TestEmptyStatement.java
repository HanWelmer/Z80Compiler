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
public class TestEmptyStatement extends AbstactRegressionTest {

  protected void init() {
    final String testName = "emptyStatement";
    // Override default configuration values.
    jCodeLocation = "/src/test/resources/jCode/" + testName + "/";
    mCodeLocation = "/src/test/resources/mCode/" + testName + "/";
    expectedLocation = "/src/test/resources/expected/" + testName + "/";
    debugMode = false;
    verboseMode = false;
  }

  @Test
  public void TestEmptyClass() {
    assertTrue(singleTest("TestEmptyClass.j"));
  }

  @Test
  public void TestEmptyBlock() {
    assertTrue(singleTest("TestEmptyBlock.j"));
  }

  // whileStatement | doStatement | forStatement | returnStatement.

  @Test
  public void TestTwoEmptyStatements() {
    assertTrue(singleTest("TestEmptyBlock.j"));
  }

  @Test
  public void TestExpression() {
    assertTrue(singleTest("TestExpression.j"));
  }

  @Test
  public void TestWhile() {
    assertTrue(singleTest("TestWhile.j"));
  }

  @Test
  public void TestDo() {
    assertTrue(singleTest("TestDo.j"));
  }

  @Test
  public void TestFor() {
    assertTrue(singleTest("TestFor.j"));
  }

  // TODO enable regression test TestReturn().
  @Test
  public void TestReturn() {
    assertTrue(singleTest("TestReturn.j"));
  }

}
