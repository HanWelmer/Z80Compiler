package com.github.HanWelmer.interpreter;

import org.junit.Test;

public class TestDo extends AbstractCompilerTest {

  static final String INPUT_STRING = "2 3 4 5 6 7 8 0";

  @Test
  public void testDo() {
    String path = "";
    String fileName = "testDo.m";

    singleTest(path, fileName, INPUT_STRING.split(" "));
  }

}
