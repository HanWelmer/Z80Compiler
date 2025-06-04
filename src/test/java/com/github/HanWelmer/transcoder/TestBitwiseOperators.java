package com.github.HanWelmer.transcoder;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Test;

import com.github.hanwelmer.AssemblyInstruction;
import com.github.hanwelmer.DataType;
import com.github.hanwelmer.FunctionType;
import com.github.hanwelmer.Instruction;
import com.github.hanwelmer.Operand;
import com.github.hanwelmer.OperandType;
import com.github.hanwelmer.Transcoder;

public class TestBitwiseOperators extends AbstractTranscoderTest {

  @Test
  public void testBitwiseOperators() {
    String path = "";
    String fileName = "testBitwiseOperators.m";
    String inputString = "2 3 4 5 6 7 8 0";

    ArrayList<AssemblyInstruction> code = singleTest(path, fileName, inputString.split(" "));

    assertTrue(code.size() == 6702);

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

    // L425: 0x1234 & b1
    assertTrue(code.get(1093).getCode().equals("L425:"));
    assertTrue(code.get(1094).getCode().equals("        LD    E,A"));
    assertTrue(code.get(1095).getCode().equals("        LD    A,(05000H)"));
    assertTrue(code.get(1096).getCode().equals("        AND   A,L"));
    assertTrue(code.get(1097).getCode().equals("        LD    L,A"));
    assertTrue(code.get(1098).getCode().equals("        LD    A,E"));
    assertTrue(code.get(1099).getCode().equals("        LD    H,0"));

    // 1286 acc16And constant 28
    assertTrue(code.get(3372).getCode().equals("L1286:"));
    assertTrue(code.get(3373).getCode().equals("        LD    E,A"));
    assertTrue(code.get(3374).getCode().equals("        LD    A,28"));
    assertTrue(code.get(3375).getCode().equals("        AND   A,L"));
    assertTrue(code.get(3376).getCode().equals("        LD    L,A"));
    assertTrue(code.get(3377).getCode().equals("        LD    A,E"));
    assertTrue(code.get(3378).getCode().equals("        LD    H,0"));

  }

  @Test
  public void testOrWordByte() {
    // Preoare M-code source code instructions.
    ArrayList<Instruction> instructions = new ArrayList<Instruction>();

    // private static byte b1 = 0x1C;
    // acc8= constant 28
    // acc8=> variable 0
    instructions.add(new Instruction(FunctionType.acc8Load, new Operand(OperandType.CONSTANT, DataType.byt, 28)));
    instructions.add(new Instruction(FunctionType.acc8Store, new Operand(OperandType.GLOBAL_VAR, DataType.byt, 0)));

    // private static word w1 = 0x0000;
    // acc16= constant 0
    // acc16=> variable 1
    instructions.add(new Instruction(FunctionType.acc16Load, new Operand(OperandType.CONSTANT, DataType.word, 0)));
    instructions.add(new Instruction(FunctionType.acc16Store, new Operand(OperandType.GLOBAL_VAR, DataType.word, 1)));

    // w1 = 0x1234 & b1;
    // acc16= constant 4660
    // acc16And variable 0
    // acc16=> variable 1
    instructions.add(new Instruction(FunctionType.acc16Load, new Operand(OperandType.CONSTANT, DataType.word, 0x1234)));
    instructions.add(new Instruction(FunctionType.acc16And, new Operand(OperandType.GLOBAL_VAR, DataType.byt, 0)));
    instructions.add(new Instruction(FunctionType.acc16Store, new Operand(OperandType.GLOBAL_VAR, DataType.word, 1)));

    // Transcode M-code to Z80S180 assembler code.
    boolean debugMode = false;
    Transcoder transcoder = new Transcoder(debugMode);
    ArrayList<AssemblyInstruction> code = transcoder.transcode(instructions);

    // Verify result.
    assertTrue(code.get(6).getCode().equals("        LD    A,28"));
    assertTrue(code.get(6).getBytes().size() == 2);
    assertTrue(code.get(6).getBytes().get(0).equals((byte) 0x3E));
    assertTrue(code.get(6).getBytes().get(1).equals((byte) 0x1C));

    assertTrue(code.get(8).getCode().equals("        LD    (05000H),A"));
    assertTrue(code.get(8).getBytes().size() == 3);
    assertTrue(code.get(8).getBytes().get(0).equals((byte) 0x32));
    assertTrue(code.get(8).getBytes().get(1).equals((byte) 0x00));
    assertTrue(code.get(8).getBytes().get(2).equals((byte) 0x50));

    assertTrue(code.get(10).getCode().equals("        LD    HL,0"));
    assertTrue(code.get(10).getBytes().size() == 3);
    assertTrue(code.get(10).getBytes().get(0).equals((byte) 0x21));
    assertTrue(code.get(10).getBytes().get(1).equals((byte) 0x00));
    assertTrue(code.get(10).getBytes().get(2).equals((byte) 0x00));

    assertTrue(code.get(12).getCode().equals("        LD    (05001H),HL"));
    assertTrue(code.get(12).getBytes().size() == 3);
    assertTrue(code.get(12).getBytes().get(0).equals((byte) 0x22));
    assertTrue(code.get(12).getBytes().get(1).equals((byte) 0x01));
    assertTrue(code.get(12).getBytes().get(2).equals((byte) 0x50));

    assertTrue(code.get(14).getCode().equals("        LD    HL,4660"));
    assertTrue(code.get(14).getBytes().size() == 3);
    assertTrue(code.get(14).getBytes().get(0).equals((byte) 0x21));
    assertTrue(code.get(14).getBytes().get(1).equals((byte) 0x34));
    assertTrue(code.get(14).getBytes().get(2).equals((byte) 0x12));

    assertTrue(code.get(16).getCode().equals("        LD    E,A"));
    assertTrue(code.get(16).getBytes().size() == 1);
    assertTrue(code.get(16).getBytes().get(0).equals((byte) 0x5F));

    assertTrue(code.get(17).getCode().equals("        LD    A,(05000H)"));
    assertTrue(code.get(17).getBytes().size() == 3);
    assertTrue(code.get(17).getBytes().get(0).equals((byte) 0x3A));
    assertTrue(code.get(17).getBytes().get(1).equals((byte) 0x00));
    assertTrue(code.get(17).getBytes().get(2).equals((byte) 0x50));

    assertTrue(code.get(18).getCode().equals("        AND   A,L"));
    assertTrue(code.get(18).getBytes().size() == 1);
    assertTrue(code.get(18).getBytes().get(0).equals((byte) 0xA5));

    assertTrue(code.get(19).getCode().equals("        LD    L,A"));
    assertTrue(code.get(19).getBytes().size() == 1);
    assertTrue(code.get(19).getBytes().get(0).equals((byte) 0x6F));

    assertTrue(code.get(20).getCode().equals("        LD    A,E"));
    assertTrue(code.get(20).getBytes().size() == 1);
    assertTrue(code.get(20).getBytes().get(0).equals((byte) 0x7B));

    assertTrue(code.get(21).getCode().equals("        LD    H,0"));
    assertTrue(code.get(21).getBytes().size() == 2);
    assertTrue(code.get(21).getBytes().get(0).equals((byte) 0x26));
    assertTrue(code.get(21).getBytes().get(1).equals((byte) 0x00));

    assertTrue(code.get(23).getCode().equals("        LD    (05001H),HL"));
    assertTrue(code.get(23).getBytes().size() == 3);
    assertTrue(code.get(23).getBytes().get(0).equals((byte) 0x22));
    assertTrue(code.get(23).getBytes().get(1).equals((byte) 0x01));
    assertTrue(code.get(23).getBytes().get(2).equals((byte) 0x50));

  }
}
