package com.github.HanWelmer;

import static org.junit.Assert.assertFalse;

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
  public void TestPackageMe() {
    assertFalse(singleTest("FinalMain.j"));
  }

}
