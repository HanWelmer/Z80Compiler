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

import java.io.File;

import org.junit.Test;

/**
 * Regression test for the Z80Compiler.
 */
public class TestImportDeclaration extends AbstactRegressionTest {

  protected void init() {
    // Accept default configuration values.
  }

  @Test
  public void TestImport() {
    assertTrue(singleTest("TestImport.j"));
  }

  // @Test
  public void TestImportMe() {
    assertTrue(singleTest("TestImportMe.j"));
  }

  // @Test
  public void TestImportMeTo() {
    assertTrue(singleTest("TestImportMeTo.j"));
  }

  // @Test
  public void TestMeImportMe() {
    assertTrue(singleTest("me" + File.separator + "TestImportMe.j"));
  }

  // @Test
  public void TestImportNotFound() {
    assertTrue(singleTest("TestImportNotFound.j"));
  }

  @Test
  public void test0() {
    assertTrue(singleTest("test0.j"));
  }

  @Test
  public void test1() {
    assertTrue(singleTest("test1.j"));
  }

  @Test
  public void test2() {
    assertTrue(singleTest("test2.j"));
  }

  @Test
  public void test3() {
    assertTrue(singleTest("test3.j"));
  }

  @Test
  public void test4() {
    assertTrue(singleTest("test4.j"));
  }

  @Test
  public void test5() {
    assertTrue(singleTest("test5.j"));
  }

  @Test
  public void test6() {
    assertTrue(singleTest("test6.j"));
  }

  @Test
  public void test7() {
    assertTrue(singleTest("test7.j"));
  }

  @Test
  public void test8() {
    assertTrue(singleTest("test8.j"));
  }

  @Test
  public void test9() {
    assertTrue(singleTest("test9.j"));
  }

  @Test
  public void test10() {
    assertTrue(singleTest("test10.j"));
  }

  @Test
  public void test11() {
    assertTrue(singleTest("test11.j"));
  }

  @Test
  public void test12() {
    assertTrue(singleTest("test12.j"));
  }

  @Test
  public void test13() {
    // TODO enable test on output() with port number as constant expression
    assertTrue(singleTest("test13.j"));
  }

  @Test
  public void test14() {
    assertTrue(singleTest("test14.j"));
  }

  @Test
  public void test15() {
    assertTrue(singleTest("test15.j"));
  }

}
