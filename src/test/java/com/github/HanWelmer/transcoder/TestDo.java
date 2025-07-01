package com.github.HanWelmer.transcoder;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Test;

import com.github.hanwelmer.AssemblyInstruction;

public class TestDo extends AbstractTranscoderTest {

  @Test
  public void testDo() {
    String path = "";
    String fileName = "testDo.m";
    String inputString = "2 3 4 5 6 7 8 0";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 2555);

    // 66 breq 60
    assertTrue(code.get(149).getCode().equals("L66:"));
    assertTrue(code.get(150).getCode().equals("        JP    Z,L60"));

    // 74 brne 68
    assertTrue(code.get(166).getCode().equals("L74:"));
    assertTrue(code.get(167).getCode().equals("        JP    NZ,L68"));

    // 82 brlt 76
    assertTrue(code.get(183).getCode().equals("L82:"));
    assertTrue(code.get(184).getCode().equals("        JP    C,L76"));

    // 90 brle 84
    assertTrue(code.get(200).getCode().equals("L90:"));
    assertTrue(code.get(201).getCode().equals("        JP    C,L84"));
    assertTrue(code.get(202).getCode().equals("        JP    Z,L84"));

    // 102 brgt 95
    assertTrue(code.get(230).getCode().equals("L102:"));
    assertTrue(code.get(231).getCode().equals("        JR    Z,$+3"));
    assertTrue(code.get(232).getCode().equals("        JP    NC,L95"));

    // 111 brge 104
    assertTrue(code.get(252).getCode().equals("L111:"));
    assertTrue(code.get(253).getCode().equals("        JP    NC,L104"));
    assertTrue(code.get(254).getCode().equals("        JP    Z,L104"));

  }
}
