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
  // TODO enable regression test
  // @Test
  public void testComparison() {
    assertTrue(singleTest("test5.j"));
  }

  // TODO enable regression test
  // @Test
  public void test6() {
    assertTrue(singleTest("test6.j"));
  }

  // TODO enable regression test
  // @Test
  public void test7() {
    assertTrue(singleTest("test7.j"));
  }

  // TODO enable regression test
  // @Test
  public void test8() {
    assertTrue(singleTest("test8.j"));
  }

  // TODO enable regression test
  // @Test
  public void test9() {
    assertTrue(singleTest("test9.j"));
  }

  // TODO enable regression test
  // @Test
  public void test10() {
    assertTrue(singleTest("test10.j"));
  }

  // TODO enable regression test
  // @Test
  public void test11() {
    assertTrue(singleTest("test11.j"));
  }

  // TODO enable regression test
  // @Test
  public void test12() {
    assertTrue(singleTest("test12.j"));
  }

  // TODO enable regression test
  // @Test
  public void test13() {
    // TODO enable test on output() with port number as constant expression
    assertTrue(singleTest("test13.j"));
  }

  // TODO enable regression test
  // @Test
  public void test14() {
    assertTrue(singleTest("test14.j"));
  }

  // TODO enable regression test
  // @Test
  public void test15() {
    assertTrue(singleTest("test15.j"));
  }

}
