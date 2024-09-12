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

    assertTrue(code.size() == 4083);

    assertTrue(code.get(373).getCode().equals("L168:"));
    assertTrue(code.get(374).getCode().equals("        CALL  div16_8"));

    assertTrue(code.get(1632).getCode().equals("L673:"));
    assertTrue(code.get(1633).getCode().equals("        POP   DE"));
    assertTrue(code.get(1634).getCode().equals("        EX    DE,HL"));
    assertTrue(code.get(1635).getCode().equals("        CALL  div16"));

    assertTrue(code.get(186).getCode().equals("L84:"));
    assertTrue(code.get(187).getCode().equals("        JP    NC,L88"));
    assertTrue(code.get(187).getBytes().size() == 3);
    assertTrue(code.get(187).getBytes().get(0) == (byte)0xd2);

    assertTrue(code.get(252).getCode().equals("L114:"));
    assertTrue(code.get(253).getCode().equals("        JR    Z,$+5"));
    assertTrue(code.get(253).getBytes().size() == 2);
    assertTrue(code.get(253).getBytes().get(0) == (byte)0x28);
    assertTrue(code.get(254).getCode().equals("        JP    C,L118"));
    assertTrue(code.get(254).getBytes().size() == 3);
    assertTrue(code.get(254).getBytes().get(0) == (byte)0xda);

    assertTrue(code.get(174).getCode().equals("L78:"));
    assertTrue(code.get(175).getCode().equals("        JP    Z,L82"));
    assertTrue(code.get(175).getBytes().size() == 3);
    assertTrue(code.get(175).getBytes().get(0) == (byte)0xca);

    assertTrue(code.get(240).getCode().equals("L108:"));
    assertTrue(code.get(241).getCode().equals("        JP    C,L112"));
    assertTrue(code.get(241).getBytes().size() == 3);
    assertTrue(code.get(241).getBytes().get(0) == (byte)0xda);

    assertTrue(code.get(1632).getCode().equals("L673:"));
    assertTrue(code.get(1633).getCode().equals("        POP   DE"));
    assertTrue(code.get(1634).getCode().equals("        EX    DE,HL"));
    assertTrue(code.get(1635).getCode().equals("        CALL  div16"));

    assertTrue(code.get(102).getCode().equals("L46:"));
    assertTrue(code.get(103).getCode().equals("        LD    C,A"));
    assertTrue(code.get(104).getCode().equals("        POP   AF"));
    assertTrue(code.get(105).getCode().equals("        CALL  div8"));
  }
}
