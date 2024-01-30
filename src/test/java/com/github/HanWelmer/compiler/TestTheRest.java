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
  public void testPrint() {
    assertTrue(singleTest("test0.j"));
  }

  // Note: has local variables!
  @Test
  public void testWhile() {
    assertTrue(singleTest("test1.j"));
  }

  @Test
  public void testMultiply() {
    assertTrue(singleTest("test3.j"));
  }

  @Test
  public void testDivide() {
    assertTrue(singleTest("test4.j"));
  }

  @Test
  public void testIf() {
    assertTrue(singleTest("test2.j"));
  }

  // Note: has local variables!
  @Test
  public void testComparison() {
    assertTrue(singleTest("test5.j"));
  }

  @Test
  public void testExpression() {
    assertTrue(singleTest("test6.j"));
  }

  @Test
  public void testRead() {
    assertTrue(singleTest("test7.j"));
  }

  @Test
  public void testReverseSubtractDivision() {
    assertTrue(singleTest("test8.j"));
  }

  @Test
  public void testMultiplyComparison() {
    assertTrue(singleTest("test9.j"));
  }

  // Note: has local variables!
  @Test
  public void testDo() {
    assertTrue(singleTest("test10.j"));
  }

  // Note: has local variables!
  @Test
  public void testFor() {
    assertTrue(singleTest("test11.j"));
  }

  @Test
  public void testWrite() {
    assertTrue(singleTest("test12.j"));
  }

  @Test
  public void testOutputInput() {
    // TODO enable test on output() with port number as constant expression
    assertTrue(singleTest("test13.j"));
  }

  @Test
  public void testSleep() {
    assertTrue(singleTest("test14.j"));
  }

  @Test
  public void testBitwiseOperators() {
    assertTrue(singleTest("test15.j"));
  }

}
