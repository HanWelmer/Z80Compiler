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

    assertTrue(code.size() == 769);
    assertTrue(code.get(697).toString().equals("21b5 L6:"));
    assertTrue(code.get(698).toString().equals("21b5         ;method doIt [private, static] void ()"));
    assertTrue(code.get(699).toString().equals("21b5 L7:"));
    assertTrue(code.get(700).toString().equals("21b5         PUSH  IX dd e5"));
    assertTrue(code.get(701).toString().equals("21b7 L8:"));
    assertTrue(code.get(702).toString().equals("21b7         LD    IX,0x0000 dd 21 00 00"));
    assertTrue(code.get(703).toString().equals("21bb         ADD   IX,SP dd 39"));
    assertTrue(code.get(704).toString().equals("21bd L9:"));

    assertTrue(code.get(743).toString().equals("21e0 L26:"));
    assertTrue(code.get(744).toString().equals("21e0         ;;TestNoParameters.j(8)     doIt();"));
    assertTrue(code.get(745).toString().equals("21e0 L27:"));
    assertTrue(code.get(746).toString().equals("21e0         CALL  L6 cd b5 21"));
    assertTrue(code.get(747).toString().equals("21e3 L28:"));
  }

  @Test
  public void TestWordParameter() {
    String path = "methodInvocation";
    String fileName = "TestWordParameter.m";
    String inputString = "";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 772);
    assertTrue(code.get(695).toString().equals("21b5 L5:"));
    assertTrue(code.get(696).toString().equals("21b5         ;;TestWordParameter.j(2)   private static void doIt(word w) {"));
    assertTrue(code.get(697).toString().equals("21b5 L6:"));
    assertTrue(code.get(698).toString().equals("21b5         ;method doIt [private, static] void (word w {bp+0})"));
    assertTrue(code.get(699).toString().equals("21b5 L7:"));
    assertTrue(code.get(700).toString().equals("21b5         PUSH  IX dd e5"));
    assertTrue(code.get(701).toString().equals("21b7 L8:"));
    assertTrue(code.get(702).toString().equals("21b7         LD    IX,0x0000 dd 21 00 00"));
    assertTrue(code.get(703).toString().equals("21bb         ADD   IX,SP dd 39"));
    assertTrue(code.get(704).toString().equals("21bd L9:"));

    assertTrue(code.get(708).toString().equals("21c2 L10:"));
    assertTrue(code.get(709).toString().equals("21c2         ;;TestWordParameter.j(3)     println(w);"));
    assertTrue(code.get(710).toString().equals("21c2 L11:"));
    assertTrue(code.get(711).toString().equals("21c2         LD    L,(IX + 4) dd 6e 04"));
    assertTrue(code.get(712).toString().equals("21c5         LD    H,(IX + 5) dd 66 05"));
    assertTrue(code.get(713).toString().equals("21c8 L12:"));
    assertTrue(code.get(714).toString().equals("21c8         CALL  writeLineHL cd 77 21"));
    assertTrue(code.get(715).toString().equals("21cb L13:"));
    assertTrue(code.get(716).toString().equals("21cb         ;;TestWordParameter.j(4)   }"));

    assertTrue(code.get(744).toString().equals("21e3 L26:"));
    assertTrue(code.get(745).toString().equals("21e3         ;;TestWordParameter.j(8)     doIt(257);"));
    assertTrue(code.get(746).toString().equals("21e3 L27:"));
    assertTrue(code.get(747).toString().equals("21e3         LD    HL,257 21 01 01"));
    assertTrue(code.get(748).toString().equals("21e6 L28:"));
    assertTrue(code.get(749).toString().equals("21e6         PUSH HL e5"));
    assertTrue(code.get(750).toString().equals("21e7 L29:"));
    assertTrue(code.get(751).toString().equals("21e7         CALL  L6 cd b5 21"));
  }

}
