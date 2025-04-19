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

    assertTrue(code.size() == 4113);

    // case brGe:
    // 84 brge 88
    assertTrue(code.get(200).getCode().equals("L84:"));
    assertTrue(code.get(201).getCode().equals("        JP    NC,L88"));
    assertTrue(code.get(201).getBytes().size() == 3);
    assertTrue(code.get(201).getBytes().get(0) == (byte) 0xd2);

    // case brGt:
    // 114 brgt 118
    assertTrue(code.get(267).getCode().equals("L114:"));
    assertTrue(code.get(268).getCode().equals("        JR    Z,$+3"));
    assertTrue(code.get(268).getBytes().size() == 2);
    assertTrue(code.get(268).getBytes().get(0) == (byte) 0x28);
    assertTrue(code.get(268).getBytes().get(1) == (byte) 0x03);

    // case brLe:
    // 78 brle 82
    assertTrue(code.get(187).getCode().equals("L78:"));
    assertTrue(code.get(188).getCode().equals("        JP    C,L82"));
    assertTrue(code.get(188).getBytes().size() == 3);
    assertTrue(code.get(188).getBytes().get(0) == (byte) 0xda);
    assertTrue(code.get(189).getCode().equals("        JP    Z,L82"));
    assertTrue(code.get(189).getBytes().size() == 3);
    assertTrue(code.get(189).getBytes().get(0) == (byte) 0xca);

    // case brLt:
    // 108 brlt 112
    assertTrue(code.get(255).getCode().equals("L108:"));
    assertTrue(code.get(256).getCode().equals("        JP    C,L112"));
    assertTrue(code.get(256).getBytes().size() == 3);
    assertTrue(code.get(256).getBytes().get(0) == (byte) 0xda);

    // case acc16Div:
    // 168 acc16/ acc8
    assertTrue(code.get(388).getCode().equals("L168:"));
    assertTrue(code.get(389).getCode().equals("        CALL  div16_8"));

    // case divAcc16:
    // 673 /acc16 unstack16
    assertTrue(code.get(1654).getCode().equals("L673:"));
    assertTrue(code.get(1655).getCode().equals("        POP   DE"));
    assertTrue(code.get(1655).getBytes().size() == 1);
    assertTrue(code.get(1655).getBytes().get(0) == (byte) 0xd1);
    assertTrue(code.get(1656).getCode().equals("        EX    DE,HL"));
    assertTrue(code.get(1656).getBytes().size() == 1);
    assertTrue(code.get(1656).getBytes().get(0) == (byte) 0xeb);
    assertTrue(code.get(1657).getCode().equals("        CALL  div16"));

    // case divAcc8:
    // 42 ;testComparison.j(18) if (4 == 12/(1+2)) println(0);
    // 43 acc8= constant 12
    // 44 <acc8= constant 1
    // 45 acc8+ constant 2
    // 46 /acc8 unstack8
    // 47 acc8Comp constant 4
    assertTrue(code.get(115).getCode().equals("L46:"));
    assertTrue(code.get(116).getCode().equals("        LD    C,A"));
    assertTrue(code.get(116).getBytes().size() == 1);
    assertTrue(code.get(116).getBytes().get(0) == (byte) 0x4f);
    assertTrue(code.get(117).getCode().equals("        POP   AF"));
    assertTrue(code.get(117).getBytes().size() == 1);
    assertTrue(code.get(117).getBytes().get(0) == (byte) 0xf1);
    assertTrue(code.get(118).getCode().equals("        CALL  div8"));
    assertTrue(code.get(119).getCode().equals("L47:"));
    assertTrue(code.get(120).getCode().equals("        SUB   A,4"));
    assertTrue(code.get(120).getBytes().size() == 2);
    assertTrue(code.get(120).getBytes().get(0) == (byte) 0xd6);
    assertTrue(code.get(120).getBytes().get(1) == (byte) 0x04);

    // case revAcc16Compare:
    // 674 revAcc16Comp unstack16
    assertTrue(code.get(1658).getCode().equals("L674:"));
    assertTrue(code.get(1659).getCode().equals("        POP   DE"));
    assertTrue(code.get(1659).getBytes().size() == 1);
    assertTrue(code.get(1659).getBytes().get(0) == (byte) 0xd1);
    assertTrue(code.get(1660).getCode().equals("        OR    A"));
    assertTrue(code.get(1660).getBytes().size() == 1);
    assertTrue(code.get(1660).getBytes().get(0) == (byte) 0xb7);
    assertTrue(code.get(1661).getCode().equals("        SBC   HL,DE"));
    assertTrue(code.get(1661).getBytes().size() == 2);
    assertTrue(code.get(1661).getBytes().get(0) == (byte) 0xed);
    assertTrue(code.get(1661).getBytes().get(1) == (byte) 0x52);

    // case revAcc8Compare:
    // 922 revAcc8Comp unstack8
    assertTrue(code.get(2321).getCode().equals("L922:"));
    assertTrue(code.get(2322).getCode().equals("        POP   BC"));
    assertTrue(code.get(2322).getBytes().size() == 1);
    assertTrue(code.get(2322).getBytes().get(0) == (byte) 0xc1);
    assertTrue(code.get(2323).getCode().equals("        SUB   A,B"));
    assertTrue(code.get(2323).getBytes().size() == 1);
    assertTrue(code.get(2323).getBytes().get(0) == (byte) 0x90);

  }
}
