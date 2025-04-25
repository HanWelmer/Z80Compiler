package com.github.HanWelmer.transcoder;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Test;

import com.github.hanwelmer.AssemblyInstruction;

public class TestNestedImport extends AbstractTranscoderTest {

  @Test
  public void TestPublicStaticMain() {
    String path = "importDeclaration";
    String fileName = "TestNestedImport.m";
    String inputString = "2 3 4 5 6 7 8 0";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 1028);

    assertTrue(code.get(27).getCode().equals("L12:"));
    assertTrue(
        code.get(28).getCode().equals("        ;;ImportLevel2Class1.j(1)   private static String str = \"Level 2 class 1\";"));
    assertTrue(code.get(29).getCode().equals("L13:"));
    assertTrue(code.get(30).getCode().equals("        LD    HL,L168"));
    assertTrue(code.get(30).getBytes().size() == 3);
    assertTrue(code.get(30).getBytes().get(0) == 0x21);
    assertTrue(code.get(30).getBytes().get(1) == (0xd6 - 256));
    assertTrue(code.get(30).getBytes().get(2) == 0x20);

    assertTrue(code.get(70).getCode().equals("L34:"));
    assertTrue(
        code.get(71).getCode().equals("        ;;ImportLevel2Class2.j(1)   private static String str = \"Level 2 class 2\";"));
    assertTrue(code.get(72).getCode().equals("L35:"));
    assertTrue(code.get(73).getCode().equals("        LD    HL,L169"));
    assertTrue(code.get(73).getBytes().size() == 3);
    assertTrue(code.get(73).getBytes().get(0) == 0x21);
    assertTrue(code.get(73).getBytes().get(1) == (0xe6 - 256));
    assertTrue(code.get(73).getBytes().get(2) == 0x20);

    assertTrue(code.get(112).getCode().equals("L55:"));
    assertTrue(
        code.get(113).getCode().equals("        ;;ImportLevel1Class1.j(4)   private static String str = \"Level 1 class 1\";"));
    assertTrue(code.get(114).getCode().equals("L56:"));
    assertTrue(code.get(115).getCode().equals("        LD    HL,L170"));
    assertTrue(code.get(115).getBytes().size() == 3);
    assertTrue(code.get(115).getBytes().get(0) == 0x21);
    assertTrue(code.get(115).getBytes().get(1) == (0xf6 - 256));
    assertTrue(code.get(115).getBytes().get(2) == 0x20);

    assertTrue(code.get(166).getCode().equals("L83:"));
    assertTrue(
        code.get(167).getCode().equals("        ;;ImportLevel2Class3.j(1)   private static String str = \"Level 2 class 3\";"));
    assertTrue(code.get(168).getCode().equals("L84:"));
    assertTrue(code.get(169).getCode().equals("        LD    HL,L171"));
    assertTrue(code.get(169).getBytes().size() == 3);
    assertTrue(code.get(169).getBytes().get(0) == 0x21);
    assertTrue(code.get(169).getBytes().get(1) == (0x06));
    assertTrue(code.get(169).getBytes().get(2) == 0x21);

    assertTrue(code.get(209).getCode().equals("L105:"));
    assertTrue(
        code.get(210).getCode().equals("        ;;ImportLevel2Class4.j(1)   private static String str = \"Level 2 class 4\";"));
    assertTrue(code.get(211).getCode().equals("L106:"));
    assertTrue(code.get(212).getCode().equals("        LD    HL,L172"));
    assertTrue(code.get(212).getBytes().size() == 3);
    assertTrue(code.get(212).getBytes().get(0) == 0x21);
    assertTrue(code.get(212).getBytes().get(1) == (0x16));
    assertTrue(code.get(212).getBytes().get(2) == 0x21);

    assertTrue(code.get(251).getCode().equals("L126:"));
    assertTrue(
        code.get(252).getCode().equals("        ;;ImportLevel1Class2.j(4)   private static String str = \"Level 1 class 2\";"));
    assertTrue(code.get(253).getCode().equals("L127:"));
    assertTrue(code.get(254).getCode().equals("        LD    HL,L173"));
    assertTrue(code.get(254).getBytes().size() == 3);
    assertTrue(code.get(254).getBytes().get(0) == 0x21);
    assertTrue(code.get(254).getBytes().get(1) == (0x26));
    assertTrue(code.get(254).getBytes().get(2) == 0x21);

    assertTrue(code.get(319).getCode().equals("L160:"));
    assertTrue(code.get(320).getCode().equals("        ;;TestNestedImport.j(11)     println(\"TestNestedImport Klaar\");"));
    assertTrue(code.get(321).getCode().equals("L161:"));
    assertTrue(code.get(322).getCode().equals("        LD    HL,L174"));
    assertTrue(code.get(322).getBytes().size() == 3);
    assertTrue(code.get(322).getBytes().get(0) == 0x21);
    assertTrue(code.get(322).getBytes().get(1) == (0x36));
    assertTrue(code.get(322).getBytes().get(2) == 0x21);
  }
}
