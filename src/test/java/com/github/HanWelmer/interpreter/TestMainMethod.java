package com.github.HanWelmer.interpreter;

import org.junit.Test;

public class TestMainMethod extends AbstractCompilerTest {

  @Test
  public void TestPublicStaticMain() {
    String path = "methodDeclaration";
    String fileName = "TwoMethods.m";
    String inputString = "2 3 4 5 6 7 8 0";

    singleTest(path, fileName, inputString.split(" "));
  }

}
