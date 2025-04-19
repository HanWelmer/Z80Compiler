package com.github.HanWelmer.transcoder;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Test;

import com.github.hanwelmer.AssemblyInstruction;

public class TestExpression extends AbstractTranscoderTest {

  @Test
  public void testExpression() {
    String path = "";
    String fileName = "testExpression.m";
    String inputString = "2 3 4 5 6 7 8 0";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 2733);

    assertTrue(code.get(271).getCode().equals("L124:"));
    assertTrue(code.get(272).getCode().equals("        LD    HL,05000H"));
    assertTrue(code.get(273).getCode().equals("        INC   (HL)"));
    assertTrue(code.get(273).getBytes().size() == 1);
    assertTrue(code.get(273).getBytes().get(0) == (byte) 0x34);

    assertTrue(code.get(611).getCode().equals("L273:"));
    assertTrue(code.get(612).getCode().equals("        LD    A,3"));
    assertTrue(code.get(613).getCode().equals("L274:"));
    assertTrue(code.get(614).getCode().equals("        LD    B,A"));
    assertTrue(code.get(615).getCode().equals("        LD    C,11"));
    assertTrue(code.get(616).getCode().equals("        MLT   BC"));
    assertTrue(code.get(617).getCode().equals("        LD    A,C"));

    assertTrue(code.get(785).getCode().equals("L346:"));
    assertTrue(code.get(786).getCode().equals("        LD    A,123"));
    assertTrue(code.get(787).getCode().equals("L347:"));
    assertTrue(code.get(788).getCode().equals("        LD    C,3"));
    assertTrue(code.get(789).getCode().equals("        CALL  div8"));

    assertTrue(code.get(1726).getCode().equals("L765:"));
    assertTrue(code.get(1727).getCode().equals("        LD    HL,518"));
    assertTrue(code.get(1728).getCode().equals("L766:"));
    assertTrue(code.get(1729).getCode().equals("        LD    DE,2"));
    assertTrue(code.get(1730).getCode().equals("        CALL  mul16"));
  }
}
