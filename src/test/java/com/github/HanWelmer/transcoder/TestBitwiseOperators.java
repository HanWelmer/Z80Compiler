package com.github.HanWelmer.transcoder;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Test;

import com.github.hanwelmer.AssemblyInstruction;

public class TestBitwiseOperators extends AbstractTranscoderTest {

  @Test
  public void testBitwiseOperators() {
    String path = "";
    String fileName = "testBitwiseOperators.m";
    String inputString = "2 3 4 5 6 7 8 0";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 6890);

    assertTrue(code.get(85).getCode().equals("L40:"));
    assertTrue(code.get(86).getCode().equals("        AND   A,28"));
    assertTrue(code.get(86).getBytes().size() == 2);
    assertTrue(code.get(86).getBytes().get(0) == (byte) 0xe6);
    assertTrue(code.get(86).getBytes().get(1) == (byte) 0x1c);

    assertTrue(code.get(105).getCode().equals("L50:"));
    assertTrue(code.get(106).getCode().equals("        OR    A,28"));
    assertTrue(code.get(106).getBytes().size() == 2);
    assertTrue(code.get(106).getBytes().get(0) == (byte) 0xf6);
    assertTrue(code.get(106).getBytes().get(1) == (byte) 0x1c);

    assertTrue(code.get(125).getCode().equals("L60:"));
    assertTrue(code.get(126).getCode().equals("        XOR   A,28"));
    assertTrue(code.get(126).getBytes().size() == 2);
    assertTrue(code.get(126).getBytes().get(0) == (byte) 0xee);
    assertTrue(code.get(126).getBytes().get(1) == (byte) 0x1c);

    // 1286 acc16And constant 28
    assertTrue(code.get(3474).getCode().equals("L1286:"));
    assertTrue(code.get(3475).getCode().equals("        LD    E,A"));
    assertTrue(code.get(3476).getCode().equals("        LD    A,28"));
    assertTrue(code.get(3477).getCode().equals("        AND   A,L"));
    assertTrue(code.get(3478).getCode().equals("        LD    L,A"));
    assertTrue(code.get(3479).getCode().equals("        LD    A,E"));
    assertTrue(code.get(3480).getCode().equals("        LD    H,0"));

  }

}
