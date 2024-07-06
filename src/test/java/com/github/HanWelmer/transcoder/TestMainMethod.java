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

    assertTrue(code.size() == 769);

    assertTrue(code.get(711).getCode().equals("        LD    HL,L36"));
    assertTrue(code.get(711).getBytes().size() == 3);
    assertTrue(code.get(711).getBytes().get(0) == 0x21);
    assertTrue(code.get(711).getBytes().get(1) == (byte) 0xEE);
    assertTrue(code.get(711).getBytes().get(2) == 0x21);

    assertTrue(code.get(746).getCode().equals("        CALL  L6"));
    assertTrue(code.get(746).getBytes().size() == 3);
    assertTrue(code.get(746).getBytes().get(0) == (byte) 0xCD);
    assertTrue(code.get(746).getBytes().get(1) == (byte) 0xB5);
    assertTrue(code.get(746).getBytes().get(2) == 0x21);

    assertTrue(code.get(750).getCode().equals("        LD    HL,L38"));
    assertTrue(code.get(750).getBytes().size() == 3);
    assertTrue(code.get(750).getBytes().get(0) == 0x21);
    assertTrue(code.get(750).getBytes().get(1) == (byte) 0xF5);
    assertTrue(code.get(750).getBytes().get(2) == 0x21);
  }
}
