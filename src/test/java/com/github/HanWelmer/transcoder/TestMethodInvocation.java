package com.github.HanWelmer.transcoder;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Test;

import com.github.hanwelmer.AssemblyInstruction;

public class TestMethodInvocation extends AbstractTranscoderTest {

  @Test
  public void TestNoParameters() {
    String path = "methodInvocation";
    String fileName = "TestNoParameters.m";
    String inputString = "";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 768);
    assertTrue(code.get(17).toString().equals("2009 L6:"));
    assertTrue(code.get(18).toString().equals("2009         ;method TestStatementExpression.doIt [private, static] void ()"));
    assertTrue(code.get(19).toString().equals("2009 L7:"));
    assertTrue(code.get(20).toString().equals("2009         PUSH  IX dd e5"));
    assertTrue(code.get(21).toString().equals("200b L8:"));
    assertTrue(code.get(22).toString().equals("200b         LD    IX,0x0000 dd 21 00 00"));
    assertTrue(code.get(23).toString().equals("200f         ADD   IX,SP dd 39"));
    assertTrue(code.get(24).toString().equals("2011 L9:"));

    assertTrue(code.get(63).toString().equals("2034 L26:"));
    assertTrue(code.get(64).toString().equals("2034         ;;TestNoParameters.j(8)     doIt();"));
    assertTrue(code.get(65).toString().equals("2034 L27:"));
    assertTrue(code.get(66).toString().equals("2034         CALL  L6 cd 09 20"));
    assertTrue(code.get(67).toString().equals("2037 L28:"));
  }

  @Test
  public void TestWordParameter() {
    String path = "methodInvocation";
    String fileName = "TestWordParameter.m";
    String inputString = "";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 775);
    assertTrue(code.get(15).toString().equals("2009 L5:"));
    assertTrue(code.get(16).toString().equals("2009         ;;TestWordParameter.j(2)   private static void doIt(word w) {"));
    assertTrue(code.get(17).toString().equals("2009 L6:"));
    assertTrue(
        code.get(18).toString().equals("2009         ;method TestStatementExpression.doIt [private, static] void (word w {bp+0})"));
    assertTrue(code.get(19).toString().equals("2009 L7:"));
    assertTrue(code.get(20).toString().equals("2009         PUSH  IX dd e5"));
    assertTrue(code.get(21).toString().equals("200b L8:"));
    assertTrue(code.get(22).toString().equals("200b         LD    IX,0x0000 dd 21 00 00"));
    assertTrue(code.get(23).toString().equals("200f         ADD   IX,SP dd 39"));
    assertTrue(code.get(24).toString().equals("2011 L9:"));

    assertTrue(code.get(28).toString().equals("2016 L10:"));
    assertTrue(code.get(29).toString().equals("2016         ;;TestWordParameter.j(3)     println(w);"));
    assertTrue(code.get(30).toString().equals("2016 L11:"));
    assertTrue(code.get(31).toString().equals("2016         LD    L,(IX + 4) dd 6e 04"));
    assertTrue(code.get(32).toString().equals("2019         LD    H,(IX + 5) dd 66 05"));
    assertTrue(code.get(33).toString().equals("201c L12:"));
    assertTrue(code.get(34).toString().equals("201c         CALL  writeLineHL cd ce 21"));
    assertTrue(code.get(35).toString().equals("201f L13:"));
    assertTrue(code.get(36).toString().equals("201f         ;;TestWordParameter.j(4)   }"));

    assertTrue(code.get(64).toString().equals("2037 L26:"));
    assertTrue(code.get(65).toString().equals("2037         ;;TestWordParameter.j(8)     doIt(257);"));
    assertTrue(code.get(66).toString().equals("2037 L27:"));
    assertTrue(code.get(67).toString().equals("2037         LD    HL,257 21 01 01"));
    assertTrue(code.get(68).toString().equals("203a L28:"));
    assertTrue(code.get(69).toString().equals("203a         PUSH HL e5"));
    assertTrue(code.get(70).toString().equals("203b L29:"));
    assertTrue(code.get(71).toString().equals("203b         CALL  L6 cd 09 20"));
    assertTrue(code.get(72).toString().equals("203e L30:"));
    assertTrue(code.get(73).toString().equals("203e         LD    HL,2 21 02 00"));
    assertTrue(code.get(74).toString().equals("2041         ADD   HL,SP 39"));
    assertTrue(code.get(75).toString().equals("2042         LD    SP,HL f9"));
  }

}
