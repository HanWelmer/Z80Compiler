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
public class TestClassDeclaration extends AbstactRegressionTest {

  protected void init() {
    final String testName = "classDeclaration";
    // Override default configuration values.
    jCodeLocation = "/src/test/resources/jCode/" + testName + "/";
    mCodeLocation = "/src/test/resources/mCode/" + testName + "/";
    expectedLocation = "/src/test/resources/expected/" + testName + "/";
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
    String testOutput = testWithRedirectedSystemOut("TestClassModifierFinal.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 5);
    assertTrue("          ^unexpected modifier in class or enum declaration.\r".equals(lines[2]));
    assertTrue("1 error.\r".equals(lines[4]));
    System.out.println("As expected.\n");
  }

  @Test
  public void TestClassModifierNative() {
    String testOutput = testWithRedirectedSystemOut("TestClassModifierNative.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 5);
    assertTrue("           ^unexpected modifier in class or enum declaration.\r".equals(lines[2]));
    assertTrue("1 error.\r".equals(lines[4]));
    System.out.println("As expected.\n");
  }

  @Test
  public void TestClassModifierPrivate() {
    String testOutput = testWithRedirectedSystemOut("TestClassModifierPrivate.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 5);
    assertTrue("            ^unexpected modifier in class or enum declaration.\r".equals(lines[2]));
    assertTrue("1 error.\r".equals(lines[4]));
    System.out.println("As expected.\n");
  }

  @Test
  public void TestClassModifierStatic() {
    String testOutput = testWithRedirectedSystemOut("TestClassModifierStatic.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 5);
    assertTrue("           ^unexpected modifier in class or enum declaration.\r".equals(lines[2]));
    assertTrue("1 error.\r".equals(lines[4]));
    System.out.println("As expected.\n");
  }

  @Test
  public void TestClassModifierTransient() {
    String testOutput = testWithRedirectedSystemOut("TestClassModifierTransient.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 5);
    assertTrue("              ^unexpected modifier in class or enum declaration.\r".equals(lines[2]));
    assertTrue("1 error.\r".equals(lines[4]));
    System.out.println("As expected.\n");
  }

  @Test
  public void TestClassModifierVolatile() {
    String testOutput = testWithRedirectedSystemOut("TestClassModifierVolatile.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 5);
    assertTrue("             ^unexpected modifier in class or enum declaration.\r".equals(lines[2]));
    assertTrue("1 error.\r".equals(lines[4]));
    System.out.println("As expected.\n");
  }

  @Test
  public void TestClassModifierPrivatePublic() {
    String testOutput = testWithRedirectedSystemOut("TestClassModifierPrivatePublic.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 11);
    assertTrue("             ^unexpected modifier in class or enum declaration.\r".equals(lines[2]));
    assertTrue("4 errors.\r".equals(lines[10]));
    System.out.println("As expected.\n");
  }

  @Test
  public void TestClassModifierPublicPrivate() {
    String testOutput = testWithRedirectedSystemOut("TestClassModifierPublicPrivate.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 5);
    assertTrue("                   ^too many modifers in class or enum declaration.\r".equals(lines[2]));
    assertTrue("1 error.\r".equals(lines[4]));
    System.out.println("As expected.\n");
  }

  @Test
  public void TestClassModifierPublicPublic() {
    String testOutput = testWithRedirectedSystemOut("TestClassModifierPublicPublic.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 9);
    assertTrue("            ^unexpected symbol; found public, expected [class]\r".equals(lines[2]));
    assertTrue("3 errors.\r".equals(lines[8]));
    System.out.println("As expected.\n");
  }

  @Test
  public void TestClassAllModifiers() {
    String testOutput = testWithRedirectedSystemOut("TestClassAllModifiers.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 5);
    assertTrue(lines[2].contains("^too many modifers in class or enum declaration.\r"));
    assertTrue("1 error.\r".equals(lines[4]));
    System.out.println("As expected.\n");
  }

}
