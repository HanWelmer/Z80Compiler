package com.github.HanWelmer.transcoder;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Test;

import com.github.hanwelmer.AssemblyInstruction;

public class TestComparison extends AbstractTranscoderTest {

  @Test
  public void testComparison() {
    String path = "";
    String fileName = "testComparison.m";
    String inputString = "2 3 4 5 6 7 8 0";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 2697);

    assertTrue(code.get(265).getCode().equals("L124:"));
    assertTrue(code.get(266).getCode().equals("        LD    HL,(05000H)"));
    assertTrue(code.get(267).getCode().equals("        INC   (HL)"));
    assertTrue(code.get(267).getBytes().size() == 1);
    assertTrue(code.get(267).getBytes().get(0) == (byte) 0x34);

    assertTrue(code.get(595).getCode().equals("L273:"));
    assertTrue(code.get(596).getCode().equals("        LD    A,3"));
    assertTrue(code.get(597).getCode().equals("L274:"));
    assertTrue(code.get(598).getCode().equals("        LD    B,A"));
    assertTrue(code.get(599).getCode().equals("        LD    C,11"));
    assertTrue(code.get(600).getCode().equals("        MLT   BC"));
    assertTrue(code.get(601).getCode().equals("        LD    A,C"));

    assertTrue(code.get(769).getCode().equals("L346:"));
    assertTrue(code.get(770).getCode().equals("        LD    A,123"));
    assertTrue(code.get(771).getCode().equals("L347:"));
    assertTrue(code.get(772).getCode().equals("        LD    C,3"));
    assertTrue(code.get(773).getCode().equals("        CALL  div8"));

    assertTrue(code.get(1690).getCode().equals("L765:"));
    assertTrue(code.get(1691).getCode().equals("        LD    HL,518"));
    assertTrue(code.get(1692).getCode().equals("L766:"));
    assertTrue(code.get(1693).getCode().equals("        LD    DE,2"));
    assertTrue(code.get(1694).getCode().equals("        CALL  mul16"));
  }
}
