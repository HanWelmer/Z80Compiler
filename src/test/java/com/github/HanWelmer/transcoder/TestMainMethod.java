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

    assertTrue(code.size() == 768);

    assertTrue(code.get(30).getCode().equals("L11:"));
    assertTrue(code.get(31).getCode().equals("        LD    HL,L36"));
    assertTrue(code.get(31).getBytes().size() == 3);
    assertTrue(code.get(31).getBytes().get(0) == 0x21);
    assertTrue(code.get(31).getBytes().get(1) == 0x42);
    assertTrue(code.get(31).getBytes().get(2) == 0x20);

    assertTrue(code.get(65).getCode().equals("L27:"));
    assertTrue(code.get(66).getCode().equals("        CALL  L6"));
    assertTrue(code.get(66).getBytes().size() == 3);
    assertTrue(code.get(66).getBytes().get(0) == (byte) 0xCD);
    assertTrue(code.get(66).getBytes().get(1) == 0x09);
    assertTrue(code.get(66).getBytes().get(2) == 0x20);

    assertTrue(code.get(69).getCode().equals("L29:"));
    assertTrue(code.get(70).getCode().equals("        LD    HL,L38"));
    assertTrue(code.get(70).getBytes().size() == 3);
    assertTrue(code.get(70).getBytes().get(0) == 0x21);
    assertTrue(code.get(70).getBytes().get(1) == 0x49);
    assertTrue(code.get(70).getBytes().get(2) == 0x20);
  }
}
