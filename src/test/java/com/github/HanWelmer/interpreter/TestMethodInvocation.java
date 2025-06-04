package com.github.HanWelmer.interpreter;

import org.junit.Test;

public class TestMethodInvocation extends AbstractCompilerTest {

  static final String INPUT_STRING = "2 3 4 5 6 7 8 0";

  @Test
  public void testByteParameter() {
    String path = "methodInvocation";
    String fileName = "TestByteParameter.m";

    singleTest(path, fileName, INPUT_STRING.split(" "));
  }

  @Test
  public void testWordParameter() {
    String path = "methodInvocation";
    String fileName = "TestWordParameter.m";

    singleTest(path, fileName, INPUT_STRING.split(" "));
  }

}
