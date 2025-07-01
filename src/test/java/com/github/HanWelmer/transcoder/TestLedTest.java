package com.github.HanWelmer.transcoder;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Test;

import com.github.hanwelmer.AssemblyInstruction;

public class TestLedTest extends AbstractTranscoderTest {

  @Test
  public void Test5_ImportThread() {
    String path = "ledtest/5_ImportThread";
    String fileName = "ledtst.m";
    String inputString = "";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 1195);
  }

}
