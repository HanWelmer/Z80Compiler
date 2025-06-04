package com.github.HanWelmer.interpreter;

public class TestSleep extends AbstractCompilerTest {

  static final String INPUT_STRING = "2 3 4 5 6 7 8 0";

  // @Test
  public void testSleep() {
    String path = "";
    String fileName = "testSleep.m";

    singleTest(path, fileName, INPUT_STRING.split(" "));
  }

}
