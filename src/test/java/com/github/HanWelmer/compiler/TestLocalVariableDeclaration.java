package com.github.HanWelmer.compiler;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestLocalVariableDeclaration extends AbstactRegressionTest {

  protected void init() {
    final String testName = "localVariableDeclaration";
    // Override default configuration values.
    jCodeLocation = "/src/test/resources/jCode/" + testName + "/";
    mCodeLocation = "/src/test/resources/mCode/" + testName + "/";
    expectedLocation = "/src/test/resources/expected/" + testName + "/";
    debugMode = false;
    verboseMode = false;
  }

  @Test
  public void TestNoModifier() {
    assertTrue(singleTest("NoModifier.j"));
  }

  @Test
  public void TestFinalModifier() {
    assertTrue(singleTest("FinalModifier.j"));
  }

  @Test
  public void TestVolatileModifier() {
    assertTrue(singleTest("VolatileModifier.j"));
  }

  @Test
  public void TestFinalVolatileModifier() {
    String testOutput = testWithRedirectedSystemOut("FinalVolatileModifier.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 5);
    assertTrue("                      ^combination of final and volatile modifiers not allowed\r".equals(lines[2]));
    assertTrue("1 error.\r".equals(lines[4]));
    System.out.println("As expected.\n");
  }

  @Test
  public void TestPublicModifier() {
    String testOutput = testWithRedirectedSystemOut("PublicModifier.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 5);
    assertTrue("              ^unexpected modifier.\r".equals(lines[2]));
    assertTrue("1 error.\r".equals(lines[4]));
    System.out.println("As expected.\n");
  }

}
