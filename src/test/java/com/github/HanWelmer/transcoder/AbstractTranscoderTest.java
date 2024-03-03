package com.github.HanWelmer.transcoder;

import java.io.File;
import java.util.ArrayList;

import com.github.hanwelmer.AssemblyInstruction;
import com.github.hanwelmer.Instruction;
import com.github.hanwelmer.MachineCodeParser;
import com.github.hanwelmer.Transcoder;

public abstract class AbstractTranscoderTest {

  protected static final String SOURCE_LOCATION = "\\src\\test\\resources\\expected\\";
  protected static final String TARGET_LOCATION = "\\src\\test\\resources\\z180\\";

  /**
   * Run a single test with the transcoder.
   * 
   * @param path
   *          optional path for the file with M-code to be transcoded.
   * @param fileName
   *          of a file with M-code (*.m) to be transcoded by the transcoder.
   * @param inputParts
   *          optional set of Strings, that can be used as input by the read()
   *          function.
   * @returns Array of Z180 assembly instructions.
   */
  protected ArrayList<AssemblyInstruction> singleTest(String path, String fileName, String[] inputParts) {
    boolean debugMode = false;
    System.out.println("\nRunning compiled code ...");

    // Read the file with M-code instructions.
    MachineCodeParser parser = new MachineCodeParser();
    String sourceFileName = determineSourceFileName(path, fileName);
    ArrayList<Instruction> instructions = parser.readMachineCode(sourceFileName);

    // Transcode M-code to Z80S180 assembler code.
    Transcoder transcoder = new Transcoder(debugMode);
    ArrayList<AssemblyInstruction> z80Instructions = transcoder.transcode(instructions);

    // As a side effect, generate assembler, listing and hex files.
    String targetFileName = determineTargetFileName(path, fileName);
    transcoder.writeZ80Assembler(targetFileName.replace(".m", ".asm"), z80Instructions, false);
    transcoder.writeZ80toListing(targetFileName.replace(".m", ".lst"), z80Instructions, false);
    transcoder.writeZ80toIntelHex(targetFileName.replace(".m", ".hex"), z80Instructions, false);

    return z80Instructions;
  }

  /**
   * Determine the full qualified path and file name for the source file, given
   * just the file name.
   * 
   * @param path
   *          location of source files within the user directory.
   * @param fileName
   *          local file name of the source file
   * @return qualified file name.
   */
  protected String determineSourceFileName(String path, String fileName) {
    String qualifiedFileName = System.getProperty("user.dir") + SOURCE_LOCATION;
    if (path != null) {
      if (!path.endsWith(File.separator)) {
        path += File.separator;
      }
      qualifiedFileName += path;
    }
    qualifiedFileName += fileName;
    return qualifiedFileName;
  }

  /**
   * Determine the full qualified path and file name for the source file, given
   * just the file name.
   * 
   * @param path
   *          location of source files within the user directory.
   * @param fileName
   *          local file name of the source file
   * @return qualified file name.
   */
  protected String determineTargetFileName(String path, String fileName) {
    String qualifiedFileName = System.getProperty("user.dir") + TARGET_LOCATION;
    if (path != null) {
      if (!path.endsWith(File.separator)) {
        path += File.separator;
      }
      qualifiedFileName += path;
    }
    qualifiedFileName += fileName;
    return qualifiedFileName;
  }

}
