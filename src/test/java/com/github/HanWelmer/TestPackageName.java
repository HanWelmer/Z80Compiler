package com.github.HanWelmer;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestPackageName extends pCompiler {

  // constructor
  public TestPackageName() {
    super(true, true);
  }

  @Test
  public void TestPackageNameMe() {
    assertTrue(validPackageName("me"));
  }

  @Test
  public void TestPackageName_MeTo() {
    assertTrue(validPackageName("_me.to"));
  }

  @Test
  public void TestPackageName__MeTo() {
    assertTrue(validPackageName("__me.to"));
  }

  @Test
  public void TestPackageName$MeTo() {
    assertTrue(validPackageName("$me.to"));
  }

  @Test
  public void TestPackageName$$MeTo() {
    assertTrue(validPackageName("$$me.to"));
  }

  @Test
  public void TestPackageNameMeTo() {
    assertTrue(validPackageName("me.to"));
  }

  @Test
  public void TestPackageNameUcc1() {
    assertFalse(validPackageName("Me"));
  }

  @Test
  public void TestPackageNameUcc2() {
    assertFalse(validPackageName("me.To"));
  }

  @Test
  public void TestPackageNameWildcard1() {
    assertFalse(validPackageName("*"));
  }

  @Test
  public void TestPackageNameWildcard2() {
    assertFalse(validPackageName("me.*"));
  }

  @Test
  public void TestPackageNameKeyword() {
    assertFalse(validPackageName("if"));
  }

}
