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

    assertTrue(code.size() == 849);
    assertTrue(code.get(777).toString().equals("21d4 L6:"));
    assertTrue(code.get(778).toString().equals("21d4         ;method doIt [private, static] void ()"));
    assertTrue(code.get(779).toString().equals("21d4 L7:"));
    assertTrue(code.get(780).toString().equals("21d4         PUSH  IX dd e5"));
    assertTrue(code.get(781).toString().equals("21d6 L8:"));
    assertTrue(code.get(782).toString().equals("21d6         LD    IX,0x0000 dd 21 00 00"));
    assertTrue(code.get(783).toString().equals("21da         ADD   IX,SP dd 39"));
    assertTrue(code.get(784).toString().equals("21dc L9:"));

    assertTrue(code.get(823).toString().equals("21ff L26:"));
    assertTrue(code.get(824).toString().equals("21ff         ;;TestNoParameters.j(8)     doIt();"));
    assertTrue(code.get(825).toString().equals("21ff L27:"));
    assertTrue(code.get(826).toString().equals("21ff         CALL  L6 cd d4 21"));
    assertTrue(code.get(827).toString().equals("2202 L28:"));
  }

  @Test
  public void TestWordParameter() {
    String path = "methodInvocation";
    String fileName = "TestWordParameter.m";
    String inputString = "";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 852);
    assertTrue(code.get(775).toString().equals("21d4 L5:"));
    assertTrue(code.get(776).toString().equals("21d4         ;;TestWordParameter.j(2)   private static void doIt(word w) {"));
    assertTrue(code.get(777).toString().equals("21d4 L6:"));
    assertTrue(code.get(778).toString().equals("21d4         ;method doIt [private, static] void (word w {bp+0})"));
    assertTrue(code.get(779).toString().equals("21d4 L7:"));
    assertTrue(code.get(780).toString().equals("21d4         PUSH  IX dd e5"));
    assertTrue(code.get(781).toString().equals("21d6 L8:"));
    assertTrue(code.get(782).toString().equals("21d6         LD    IX,0x0000 dd 21 00 00"));
    assertTrue(code.get(783).toString().equals("21da         ADD   IX,SP dd 39"));
    assertTrue(code.get(784).toString().equals("21dc L9:"));

    assertTrue(code.get(788).toString().equals("21e1 L10:"));
    assertTrue(code.get(789).toString().equals("21e1         ;;TestWordParameter.j(3)     println(w);"));
    assertTrue(code.get(790).toString().equals("21e1 L11:"));
    assertTrue(code.get(791).toString().equals("21e1         LD    L,(IX + 4) dd 6e 04"));
    assertTrue(code.get(792).toString().equals("21e4         LD    H,(IX + 5) dd 66 05"));
    assertTrue(code.get(793).toString().equals("21e7 L12:"));
    assertTrue(code.get(794).toString().equals("21e7         CALL  writeLineHL cd 96 21"));
    assertTrue(code.get(795).toString().equals("21ea L13:"));
    assertTrue(code.get(796).toString().equals("21ea         ;;TestWordParameter.j(4)   }"));

    assertTrue(code.get(824).toString().equals("2202 L26:"));
    assertTrue(code.get(825).toString().equals("2202         ;;TestWordParameter.j(8)     doIt(257);"));
    assertTrue(code.get(826).toString().equals("2202 L27:"));
    assertTrue(code.get(827).toString().equals("2202         LD    HL,257 21 01 01"));
    assertTrue(code.get(828).toString().equals("2205 L28:"));
    assertTrue(code.get(829).toString().equals("2205         PUSH HL e5"));
    assertTrue(code.get(830).toString().equals("2206 L29:"));
    assertTrue(code.get(831).toString().equals("2206         CALL  L6 cd d4 21"));
  }

}
