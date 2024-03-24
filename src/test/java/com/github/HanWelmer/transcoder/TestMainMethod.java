package com.github.HanWelmer.transcoder;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Test;

import com.github.hanwelmer.AssemblyInstruction;

public class TestMainMethod extends AbstractTranscoderTest {

  @Test
  public void TestPublicStaticMain() {
    String path = "methodInvocation";
    String fileName = "TestNoParameters.m";
    String inputString = "2 3 4 5 6 7 8 0";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 849);

    assertTrue("        LD    HL,L36".equals(code.get(791).getCode()));
    assertTrue(code.get(791).getBytes().size() == 3);
    assertTrue(code.get(791).getBytes().get(0) == 0x21);
    assertTrue(code.get(791).getBytes().get(1) == (byte) 0x0d);
    assertTrue(code.get(791).getBytes().get(2) == 0x22);

    assertTrue("        CALL  L6".equals(code.get(826).getCode()));
    assertTrue(code.get(826).getBytes().size() == 3);
    assertTrue(code.get(826).getBytes().get(0) == (byte) 0xCD);
    assertTrue(code.get(826).getBytes().get(1) == (byte) 0xD4);
    assertTrue(code.get(826).getBytes().get(2) == 0x21);

    assertTrue("        LD    HL,L38".equals(code.get(830).getCode()));
    assertTrue(code.get(830).getBytes().size() == 3);
    assertTrue(code.get(830).getBytes().get(0) == 0x21);
    assertTrue(code.get(830).getBytes().get(1) == (byte) 0x14);
    assertTrue(code.get(830).getBytes().get(2) == 0x22);
  }
}
