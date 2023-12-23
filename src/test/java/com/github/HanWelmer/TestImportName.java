package com.github.HanWelmer;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

import com.github.hanwelmer.pCompiler;

public class TestImportName extends pCompiler {

  // constructor
  public TestImportName() {
    super(true, true);
  }

  @Test
  public void TestImport() {
    assertTrue(validImport("TestImport"));
  }

  @Test
  public void TestImportMeAll() {
    assertTrue(validImport("me.*"));
  }

  @Test
  public void TestMeImportMe() {
    assertTrue(validImport("me.TestImportMe"));
  }

  @Test
  public void TestMeToAll() {
    assertTrue(validImport("me.to.*"));
  }

  @Test
  public void TestMeToImportMeTo() {
    assertTrue(validImport("me.to.TestImportMeTo"));
  }

  @Test
  public void TestImportClassALl() {
    assertFalse(validImport("TestImport.*"));
  }

  @Test
  public void TestImportMeClassALl() {
    assertFalse(validImport("me.TestImport.*"));
  }

  @Test
  public void TestImportMeToClassALl() {
    assertFalse(validImport("me.to.TestImport.*"));
  }

  @Test
  public void TestImportKeyword() {
    assertFalse(validImport("if"));
  }

  @Test
  public void TestImportKeywordAll() {
    assertFalse(validImport("if.*"));
  }

  @Test
  public void TestImportMeKeyword() {
    assertFalse(validImport("me.if"));
  }

  @Test
  public void TestImportMeKeywordAll() {
    assertFalse(validImport("me.if.*"));
  }

  @Test
  public void TestImportMeToKeyword() {
    assertFalse(validImport("me.to.if"));
  }

  @Test
  public void TestImportMeToKeywordAll() {
    assertFalse(validImport("me.to.if.*"));
  }

}
