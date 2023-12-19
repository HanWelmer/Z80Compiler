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

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.io.File;

import org.junit.Test;

/**
 * Regression test for the Z80Compiler.
 */
public class TestClassDeclaration extends AbstactRegressionTest {

  protected void init() {
    // Override default configuration values.
    jCodeLocation = "/src/test/resources/jCode/ClassDeclaration/";
    mCodeLocation = "/src/test/resources/mCode/ClassDeclaration/";
    expectedLocation = "/src/test/resources/expected/ClassDeclaration/";
    debugMode = false;
    verboseMode = false;
  }

  @Test
  public void TestClassModifierDefault() {
    assertTrue(singleTest("TestClassModifierDefault.j"));
  }

  @Test
  public void TestClassModifierPublic() {
    assertTrue(singleTest("TestClassModifierPublic.j"));
  }

  @Test
  public void TestClassModifierFinal() {
    assertFalse(singleTest("TestClassModifierFinal.j"));
  }

  @Test
  public void TestClassModifierNative() {
    assertFalse(singleTest("TestClassModifierNative.j"));
  }

  @Test
  public void TestClassModifierPrivate() {
    assertFalse(singleTest("TestClassModifierPrivate.j"));
  }

  @Test
  public void TestClassModifierStatic() {
    assertFalse(singleTest("TestClassModifierStatic.j"));
  }

  @Test
  public void TestClassModifierTransient() {
    assertFalse(singleTest("TestClassModifierTransient.j"));
  }

  @Test
  public void TestClassModifierVolatile() {
    assertFalse(singleTest("TestClassModifierVolatile.j"));
  }

  @Test
  public void TestClassModifierPrivatePublic() {
    assertFalse(singleTest("TestClassModifierPrivatePublic.j"));
  }

  @Test
  public void TestClassModifierPublicPrivate() {
    assertFalse(singleTest("TestClassModifierPublicPrivate.j"));
  }

  @Test
  public void TestClassModifierPublicPublic() {
    assertFalse(singleTest("TestClassModifierPublicPublic.j"));
  }

  @Test
  public void TestClassAllModifiers() {
    assertFalse(singleTest("TestClassAllModifiers.j"));
  }

}
