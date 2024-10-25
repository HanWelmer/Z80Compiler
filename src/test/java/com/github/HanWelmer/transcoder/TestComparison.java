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

    // case brGe:
    // 84 brge 88
    assertTrue(code.get(186).getCode().equals("L84:"));
    assertTrue(code.get(187).getCode().equals("        JP    NC,L88"));
    assertTrue(code.get(187).getBytes().size() == 3);
    assertTrue(code.get(187).getBytes().get(0) == (byte) 0xd2);
    assertTrue(code.get(187).getBytes().get(1) == (byte) 0xa7);
    assertTrue(code.get(187).getBytes().get(2) == (byte) 0x20);

    // case brGt:
    // 114 brgt 118
    assertTrue(code.get(252).getCode().equals("L114:"));
    assertTrue(code.get(253).getCode().equals("        JR    Z,$+5"));
    assertTrue(code.get(253).getBytes().size() == 2);
    assertTrue(code.get(253).getBytes().get(0) == (byte) 0x28);
    assertTrue(code.get(253).getBytes().get(1) == (byte) 0x03);

    // case brLe:
    // 78 brle 82
    assertTrue(code.get(174).getCode().equals("L78:"));
    assertTrue(code.get(175).getCode().equals("        JP    Z,L82"));
    assertTrue(code.get(175).getBytes().size() == 3);
    assertTrue(code.get(175).getBytes().get(0) == (byte) 0xca);
    assertTrue(code.get(175).getBytes().get(1) == (byte) 0x9b);
    assertTrue(code.get(175).getBytes().get(2) == (byte) 0x20);

    // case brLt:
    // 108 brlt 112
    assertTrue(code.get(240).getCode().equals("L108:"));
    assertTrue(code.get(241).getCode().equals("        JP    C,L112"));
    assertTrue(code.get(241).getBytes().size() == 3);
    assertTrue(code.get(241).getBytes().get(0) == (byte) 0xda);
    assertTrue(code.get(241).getBytes().get(1) == (byte) 0xdf);
    assertTrue(code.get(241).getBytes().get(2) == (byte) 0x20);

    // case acc16Div:
    // 168 acc16/ acc8
    assertTrue(code.get(373).getCode().equals("L168:"));
    assertTrue(code.get(374).getCode().equals("        CALL  div16_8"));
    assertTrue(code.get(374).getBytes().size() == 3);
    assertTrue(code.get(374).getBytes().get(0) == (byte) 0xcd);
    assertTrue(code.get(374).getBytes().get(1) == (byte) 0xc7);
    assertTrue(code.get(374).getBytes().get(2) == (byte) 0x2f);

    // case divAcc16:
    // 673 /acc16 unstack16
    assertTrue(code.get(1632).getCode().equals("L673:"));
    assertTrue(code.get(1633).getCode().equals("        POP   DE"));
    assertTrue(code.get(1633).getBytes().size() == 1);
    assertTrue(code.get(1633).getBytes().get(0) == (byte) 0xd1);
    assertTrue(code.get(1634).getCode().equals("        EX    DE,HL"));
    assertTrue(code.get(1634).getBytes().size() == 1);
    assertTrue(code.get(1634).getBytes().get(0) == (byte) 0xeb);
    assertTrue(code.get(1635).getCode().equals("        CALL  div16"));
    assertTrue(code.get(1635).getBytes().size() == 3);
    assertTrue(code.get(1635).getBytes().get(0) == (byte) 0xcd);
    assertTrue(code.get(1635).getBytes().get(1) == (byte) 0xa7);
    assertTrue(code.get(1635).getBytes().get(2) == (byte) 0x2f);

    // case divAcc8:
    // 42 ;testComparison.j(18) if (4 == 12/(1+2)) println(0);
    // 43 acc8= constant 12
    // 44 <acc8= constant 1
    // 45 acc8+ constant 2
    // 46 /acc8 unstack8
    // 47 acc8Comp constant 4
    assertTrue(code.get(102).getCode().equals("L46:"));
    assertTrue(code.get(103).getCode().equals("        LD    C,A"));
    assertTrue(code.get(104).getCode().equals("        POP   AF"));
    assertTrue(code.get(105).getCode().equals("        CALL  div8"));
    assertTrue(code.get(106).getCode().equals("L47:"));
    assertTrue(code.get(107).getCode().equals("        SUB   A,4"));
    assertTrue(code.get(103).getBytes().size() == 1);
    assertTrue(code.get(103).getBytes().get(0) == (byte) 0x4f);
    assertTrue(code.get(104).getBytes().size() == 1);
    assertTrue(code.get(104).getBytes().get(0) == (byte) 0xf1);
    assertTrue(code.get(105).getBytes().size() == 3);
    assertTrue(code.get(105).getBytes().get(0) == (byte) 0xcd);
    assertTrue(code.get(105).getBytes().get(1) == (byte) 0xd8);
    assertTrue(code.get(105).getBytes().get(2) == (byte) 0x2f);
    assertTrue(code.get(107).getBytes().size() == 2);
    assertTrue(code.get(107).getBytes().get(0) == (byte) 0xd6);
    assertTrue(code.get(107).getBytes().get(1) == (byte) 0x04);

    // case revAcc16Compare:
    // 674 revAcc16Comp unstack16
    assertTrue(code.get(1636).getCode().equals("L674:"));
    assertTrue(code.get(1637).getCode().equals("        POP   DE"));
    assertTrue(code.get(1637).getBytes().size() == 1);
    assertTrue(code.get(1637).getBytes().get(0) == (byte) 0xd1);
    assertTrue(code.get(1638).getCode().equals("        OR    A"));
    assertTrue(code.get(1638).getBytes().size() == 1);
    assertTrue(code.get(1638).getBytes().get(0) == (byte) 0xb7);
    assertTrue(code.get(1639).getCode().equals("        SBC   HL,DE"));
    assertTrue(code.get(1639).getBytes().size() == 2);
    assertTrue(code.get(1639).getBytes().get(0) == (byte) 0xed);
    assertTrue(code.get(1639).getBytes().get(1) == (byte) 0x52);

    // case revAcc8Compare:
    // 922 revAcc8Comp unstack8
    assertTrue(code.get(2296).getCode().equals("L922:"));
    assertTrue(code.get(2297).getCode().equals("        POP   BC"));
    assertTrue(code.get(2297).getBytes().size() == 1);
    assertTrue(code.get(2297).getBytes().get(0) == (byte) 0xc1);
    assertTrue(code.get(2298).getCode().equals("        SUB   A,B"));
    assertTrue(code.get(2298).getBytes().size() == 1);
    assertTrue(code.get(2298).getBytes().get(0) == (byte) 0x90);

  }
}
