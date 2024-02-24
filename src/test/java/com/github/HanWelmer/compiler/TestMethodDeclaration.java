package com.github.HanWelmer.compiler;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestMethodDeclaration extends AbstactRegressionTest {

  protected void init() {
    final String testName = "methodDeclaration";
    // Override default configuration values.
    jCodeLocation = "/src/test/resources/jCode/" + testName + "/";
    mCodeLocation = "/src/test/resources/mCode/" + testName + "/";
    expectedLocation = "/src/test/resources/expected/" + testName + "/";
    debugMode = false;
    verboseMode = false;
  }

  @Test
  public void TestPublicStaticMain() {
    assertTrue(singleTest("PublicStaticMain.j"));
  }

  @Test
  public void TestStaticMain() {
    assertTrue(singleTest("StaticMain.j"));
  }

  @Test
  public void TestNoMain() {
    String testOutput = testWithRedirectedSystemOut("NoMain.j");
    System.out.println(testOutput);
    String[] lines = testOutput.split("\n");
    assertTrue(lines.length == 4);
    assertTrue("symbol not found: main\r".equals(lines[1]));
    assertTrue("1 error.\r".equals(lines[3]));
    System.out.println("As expected.\n");
  }

  @Test
  public void Test2Methods() {
    assertTrue(singleTest("TwoMethods.j"));
  }

  @Test
  public void TestStaticPublicMain() {
    assertFalse(singleTest("StaticPublicMain.j"));
  }

  @Test
  public void TestFinalMain() {
    assertFalse(singleTest("FinalMain.j"));
  }

  @Test
  public void TestPublicMain() {
    assertFalse(singleTest("PublicMain.j"));
  }

}
