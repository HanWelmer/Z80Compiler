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

    assertTrue(code.size() == 4129);

    // case brGe:
    // 84 brge 88
    assertTrue(code.get(200).getCode().equals("L84:"));
    assertTrue(code.get(201).getCode().equals("        JP    NC,L88"));
    assertTrue(code.get(202).getCode().equals("        JP    Z,L88"));

    // case brGt:
    // 114 brgt 118
    assertTrue(code.get(269).getCode().equals("L114:"));
    assertTrue(code.get(270).getCode().equals("        JR    Z,$+3"));
    assertTrue(code.get(270).getBytes().size() == 2);
    assertTrue(code.get(270).getBytes().get(0) == (byte) 0x28);
    assertTrue(code.get(270).getBytes().get(1) == (byte) 0x03);
    assertTrue(code.get(271).getCode().equals("        JP    NC,L118"));

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
    assertTrue(code.get(257).getCode().equals("L108:"));
    assertTrue(code.get(258).getCode().equals("        JP    C,L112"));
    assertTrue(code.get(258).getBytes().size() == 3);
    assertTrue(code.get(258).getBytes().get(0) == (byte) 0xda);

    // case acc16Div:
    // 168 acc16/ acc8
    assertTrue(code.get(390).getCode().equals("L168:"));
    assertTrue(code.get(391).getCode().equals("        CALL  div16_8"));

    // case divAcc16:
    // 673 /acc16 unstack16
    assertTrue(code.get(1663).getCode().equals("L673:"));
    assertTrue(code.get(1664).getCode().equals("        POP   DE"));
    assertTrue(code.get(1664).getBytes().size() == 1);
    assertTrue(code.get(1664).getBytes().get(0) == (byte) 0xd1);
    assertTrue(code.get(1665).getCode().equals("        EX    DE,HL"));
    assertTrue(code.get(1665).getBytes().size() == 1);
    assertTrue(code.get(1665).getBytes().get(0) == (byte) 0xeb);
    assertTrue(code.get(1666).getCode().equals("        CALL  div16"));

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
    assertTrue(code.get(1667).getCode().equals("L674:"));
    assertTrue(code.get(1668).getCode().equals("        POP   DE"));
    assertTrue(code.get(1668).getBytes().size() == 1);
    assertTrue(code.get(1668).getBytes().get(0) == (byte) 0xd1);
    assertTrue(code.get(1669).getCode().equals("        OR    A"));
    assertTrue(code.get(1669).getBytes().size() == 1);
    assertTrue(code.get(1669).getBytes().get(0) == (byte) 0xb7);
    assertTrue(code.get(1670).getCode().equals("        SBC   HL,DE"));
    assertTrue(code.get(1670).getBytes().size() == 2);
    assertTrue(code.get(1670).getBytes().get(0) == (byte) 0xed);
    assertTrue(code.get(1670).getBytes().get(1) == (byte) 0x52);

    // case revAcc8Compare:
    // 922 revAcc8Comp unstack8
    assertTrue(code.get(2333).getCode().equals("L922:"));
    assertTrue(code.get(2334).getCode().equals("        POP   BC"));
    assertTrue(code.get(2334).getBytes().size() == 1);
    assertTrue(code.get(2334).getBytes().get(0) == (byte) 0xc1);
    assertTrue(code.get(2335).getCode().equals("        SUB   A,B"));
    assertTrue(code.get(2335).getBytes().size() == 1);
    assertTrue(code.get(2335).getBytes().get(0) == (byte) 0x90);

  }
}
