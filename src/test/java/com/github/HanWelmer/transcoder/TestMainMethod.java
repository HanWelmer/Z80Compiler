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

    assertTrue(code.size() == 823);

    assertTrue("        LD    HL,L26".equals(code.get(782).getCode()));
    assertTrue(code.get(782).getBytes().size() == 3);
    assertTrue(code.get(782).getBytes().get(0) == 0x21);
    assertTrue(code.get(782).getBytes().get(1) == (byte) 0xEB);
    assertTrue(code.get(782).getBytes().get(2) == 0x21);

    assertTrue("        CALL  L6".equals(code.get(804).getCode()));
    assertTrue(code.get(804).getBytes().size() == 3);
    assertTrue(code.get(804).getBytes().get(0) == (byte) 0xCD);
    assertTrue(code.get(804).getBytes().get(1) == (byte) 0xD4);
    assertTrue(code.get(804).getBytes().get(2) == 0x21);

    assertTrue("        LD    HL,L28".equals(code.get(808).getCode()));
    assertTrue(code.get(808).getBytes().size() == 3);
    assertTrue(code.get(808).getBytes().get(0) == 0x21);
    assertTrue(code.get(808).getBytes().get(1) == (byte) 0xF2);
    assertTrue(code.get(808).getBytes().get(2) == 0x21);
  }

}
