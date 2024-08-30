package com.github.HanWelmer.transcoder;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Test;

import com.github.hanwelmer.AssemblyInstruction;

public class TestLocalVariableDeclaration extends AbstractTranscoderTest {

  @Test
  public void TestNoModifier() {
    String path = "localVariableDeclaration";
    String fileName = "NoModifier.m";
    String inputString = "2 3 4 5 6 7 8 0";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 918);
  }

}
