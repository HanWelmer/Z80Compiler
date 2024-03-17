package com.github.HanWelmer.interpreter;

import org.junit.Test;

public class TestLocalVariableDeclaration extends AbstractCompilerTest {

  static final String INPUT_STRING = "2 3 4 5 6 7 8 0";

  @Test
  public void TestFinalModifier() {
    String path = "localVariableDeclaration";
    String fileName = "FinalModifier.m";

    singleTest(path, fileName, INPUT_STRING.split(" "));
  }

  @Test
  public void TestNoModifier() {
    String path = "localVariableDeclaration";
    String fileName = "NoModifier.m";

    singleTest(path, fileName, INPUT_STRING.split(" "));
  }

}
