package com.github.HanWelmer.transcoder;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Test;

import com.github.hanwelmer.AssemblyInstruction;

public class TestMethodInvocation extends AbstractTranscoderTest {

  @Test
  public void testNoParameters() {
    String path = "methodInvocation";
    String fileName = "TestNoParameters.m";
    String inputString = "";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 762);
    assertTrue(code.get(17).toString().equals("2009 L6:"));
    assertTrue(code.get(18).toString().equals("2009         ;method TestStatementExpression.doIt [private, static] void ()"));
    assertTrue(code.get(19).toString().equals("2009 L7:"));
    assertTrue(code.get(20).toString().equals("2009         PUSH  IX dd e5"));
    assertTrue(code.get(21).toString().equals("200b L8:"));
    assertTrue(code.get(22).toString().equals("200b         LD    IX,0x0000 dd 21 00 00"));
    assertTrue(code.get(23).toString().equals("200f         ADD   IX,SP dd 39"));
    assertTrue(code.get(24).toString().equals("2011 L9:"));
    assertTrue(code.get(25).toString().equals("2011 L10:"));

    assertTrue(code.get(57).toString().equals("202a L26:"));
    assertTrue(code.get(58).toString().equals("202a         ;;TestNoParameters.j(8)     doIt();"));
    assertTrue(code.get(59).toString().equals("202a L27:"));
    assertTrue(code.get(60).toString().equals("202a         CALL  L6 cd 09 20"));
    assertTrue(code.get(61).toString().equals("202d L28:"));
  }

  @Test
  public void testWordParameter() {
    String path = "methodInvocation";
    String fileName = "TestWordParameter.m";
    String inputString = "";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 790);
    assertTrue(code.get(15).toString().equals("2009 L5:"));
    assertTrue(code.get(16).toString().equals("2009         ;;TestWordParameter.j(2)   private static void doIt(word w) {"));
    assertTrue(code.get(17).toString().equals("2009 L6:"));
    assertTrue(
        code.get(18).toString().equals("2009         ;method TestWordParameter.doIt [private, static] void (word w {bp+0})"));
    assertTrue(code.get(19).toString().equals("2009 L7:"));
    assertTrue(code.get(20).toString().equals("2009         PUSH  IX dd e5"));
    assertTrue(code.get(21).toString().equals("200b L8:"));
    assertTrue(code.get(22).toString().equals("200b         LD    IX,0x0000 dd 21 00 00"));
    assertTrue(code.get(23).toString().equals("200f         ADD   IX,SP dd 39"));
    assertTrue(code.get(24).toString().equals("2011 L9:"));
    assertTrue(code.get(25).toString().equals("2011         DEC   SP 3b"));
    assertTrue(code.get(26).toString().equals("2012         DEC   SP 3b"));
    assertTrue(code.get(27).toString().equals("2013 L10:"));
    assertTrue(code.get(28).toString().equals("2013         ;;TestWordParameter.j(3)     println(w);"));
    assertTrue(code.get(29).toString().equals("2013 L11:"));
    assertTrue(code.get(30).toString().equals("2013         LD    L,(IX + 4) dd 6e 04"));
    assertTrue(code.get(31).toString().equals("2016         LD    H,(IX + 5) dd 66 05"));
    assertTrue(code.get(32).toString().equals("2019 L12:"));
    assertTrue(code.get(33).toString().equals("2019         CALL  writeLineHL cd e6 21"));
    assertTrue(code.get(34).toString().equals("201c L13:"));
    assertTrue(code.get(35).toString().equals("201c         ;;TestWordParameter.j(4)     word wv = 1002;"));
    assertTrue(code.get(36).toString().equals("201c L14:"));
    assertTrue(code.get(37).toString().equals("201c         LD    HL,1002 21 ea 03"));
    assertTrue(code.get(38).toString().equals("201f L15:"));
    assertTrue(code.get(39).toString().equals("201f         LD    (IX - 2),L dd 75 fe"));
    assertTrue(code.get(40).toString().equals("2022         LD    (IX - 1),H dd 74 ff"));
    assertTrue(code.get(41).toString().equals("2025 L16:"));
    assertTrue(code.get(42).toString().equals("2025         ;;TestWordParameter.j(5)     println(wv);"));
    assertTrue(code.get(43).toString().equals("2025 L17:"));
    assertTrue(code.get(44).toString().equals("2025         LD    L,(IX - 2) dd 6e fe"));
    assertTrue(code.get(45).toString().equals("2028         LD    H,(IX - 1) dd 66 ff"));
    assertTrue(code.get(46).toString().equals("202b L18:"));
    assertTrue(code.get(47).toString().equals("202b         CALL  writeLineHL cd e6 21"));
    assertTrue(code.get(48).toString().equals("202e L19:"));
    assertTrue(code.get(49).toString().equals("202e         ;;TestWordParameter.j(6)   }"));

    assertTrue(code.get(80).toString().equals("2047 L35:"));
    assertTrue(code.get(81).toString().equals("2047         ;;TestWordParameter.j(11)     doIt(1001);"));
    assertTrue(code.get(82).toString().equals("2047 L36:"));
    assertTrue(code.get(83).toString().equals("2047         LD    HL,1001 21 e9 03"));
    assertTrue(code.get(84).toString().equals("204a L37:"));
    assertTrue(code.get(85).toString().equals("204a         PUSH HL e5"));
    assertTrue(code.get(86).toString().equals("204b L38:"));
    assertTrue(code.get(87).toString().equals("204b         CALL  L6 cd 09 20"));
    assertTrue(code.get(88).toString().equals("204e L39:"));
    assertTrue(code.get(89).toString().equals("204e         INC   SP 33"));
    assertTrue(code.get(90).toString().equals("204f         INC   SP 33"));
    assertTrue(code.get(91).toString().equals("2050 L40:"));
  }

}
