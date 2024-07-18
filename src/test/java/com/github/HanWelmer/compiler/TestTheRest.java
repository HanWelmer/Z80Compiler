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
public class TestTheRest extends AbstactRegressionTest {

  protected void init() {
    // Accept default configuration values.
  }

  @Test
  public void testBitwiseOperators() {
    assertTrue(singleTest("testBitwiseOperators.j"));
  }

  // Note: has local variables!
  @Test
  public void testComparison() {
    assertTrue(singleTest("testComparison.j"));
  }

  @Test
  public void testDivide() {
    assertTrue(singleTest("testDivide.j"));
  }

  // Note: has local variables!
  @Test
  public void testDo() {
    assertTrue(singleTest("testDo.j"));
  }

  @Test
  public void testExpression() {
    assertTrue(singleTest("testExpression.j"));
  }

  // Note: has local variables!
  @Test
  public void testFor() {
    assertTrue(singleTest("testFor.j"));
  }

  @Test
  public void testIf() {
    assertTrue(singleTest("testIf.j"));
  }

  @Test
  public void testMultiply() {
    assertTrue(singleTest("testMultiply.j"));
  }

  @Test
  public void testMultiplyComparison() {
    assertTrue(singleTest("testMultiplyComparison.j"));
  }

  @Test
  public void testOutputInput() {
    // TODO enable test on output() with port number as constant expression
    assertTrue(singleTest("testOutputInput.j"));
  }

  @Test
  public void testPrint() {
    assertTrue(singleTest("testPrint.j"));
  }

  @Test
  public void testRead() {
    assertTrue(singleTest("testRead.j"));
  }

  @Test
  public void testReverseSubtractDivision() {
    assertTrue(singleTest("testReverseSubtractDivision.j"));
  }

  @Test
  public void testSleep() {
    assertTrue(singleTest("testSleep.j"));
  }

  @Test
  public void testStatementExpression() {
    assertTrue(singleTest("TestStatementExpression.j"));
  }

  // Note: has local variables!
  @Test
  public void testWhile() {
    assertTrue(singleTest("testWhile.j"));
  }

  @Test
  public void testWrite() {
    assertTrue(singleTest("testWrite.j"));
  }

}
