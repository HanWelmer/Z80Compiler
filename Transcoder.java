import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
/*
* This class realizes a transcoder. 
* It translates an array with M-code instruction
* to an array with Z80S180 assembler instructions.
*/
public class Transcoder {
  
  /* constants */
  private static final int MAX_ASM_CODE = 0x3000; /* max Z80 assembler lines of code */
  private static final int MEM_START = 0x5000;    /* lowest address for global variables */
  private static final int MIN_BIN = 0x2000; /* Z80 assembled bytes start at 2000 */
  private static final int MAX_BIN = 0x5000; /* max Z80 assembled bytes */
  private static final String INDENT = "        ";
  private static final Set<Byte> LONG_JUMP_INSTRUCTIONS = new HashSet<Byte>(18) {{
    add((byte)0xC2); //JP NZ
    add((byte)0xD2); //JP NC
    add((byte)0xE2); //JP PO
    add((byte)0xF2); //JP P

    add((byte)0xC3); //JP

    add((byte)0xC4); //CALL NZ
    add((byte)0xD4); //CALL NC
    add((byte)0xE4); //CALL PO
    add((byte)0xF4); //CALL P

    add((byte)0xCA); //JP Z
    add((byte)0xDA); //JP C
    add((byte)0xEA); //JP PE
    add((byte)0xFA); //JP M

    add((byte)0xCC); //CALL Z
    add((byte)0xDC); //CALL C
    add((byte)0xEC); //CALL PE
    add((byte)0xFC); //CALL M

    add((byte)0xCD); //CALL
  }};
  private static final Set<Byte> RELATIVE_JUMP_INSTRUCTIONS = new HashSet<Byte>(6) {{
    add((byte)0x10); //DJNZ
    add((byte)0x18); //JR
    add((byte)0x20); //JR NZ
    add((byte)0x28); //JR Z
    add((byte)0x30); //JR NC
    add((byte)0x38); //JR C
  }};

  /* global variables */
  private boolean debugMode = false;
  private boolean generateBinary = false;
  private long byteAddress = MIN_BIN;
  public Map<String, Long> labels = new HashMap<String, Long>();
  public Map<String, ArrayList<Long>> labelReferences = new HashMap<String, ArrayList<Long>>();
  
  /* constructor */
  public Transcoder(boolean debugMode, boolean binary) {
    this.debugMode = debugMode;
    this.generateBinary = binary;
  }

  private void debug(String message) {
    if (debugMode) {
      System.out.print(message);
    }
  }

  /* transcode the array with M-code instruction to an array with Z80S180 assembler instructions. */
  public ArrayList<AssemblyInstruction> transcode(ArrayList<Instruction> instructions){
    //initialisation
    ArrayList<AssemblyInstruction> z80Instructions = new ArrayList<AssemblyInstruction>();
    labels.clear();
    for (String key : labelReferences.keySet()) {
      labelReferences.get(key).clear();
    }
    labelReferences.clear();

    z80Instructions.addAll(plantZ80Runtime());

    labels.put("main", byteAddress);
    z80Instructions.add(new AssemblyInstruction(byteAddress, "main:"));
    for (Instruction instruction: instructions) {
      //add label and address to map with labels.
      String label = "L" + instructions.indexOf(instruction);
      labels.put(label, byteAddress);

      z80Instructions.addAll(transcode(instruction));

      if (z80Instructions.size() > MAX_ASM_CODE) {
        throw new RuntimeException("Z80 code overflow while generating Z80 assembler code");
      }
    }
    
    resolveLabelReferences(z80Instructions);
    return z80Instructions;
  }
  
  private void resolveLabelReferences(ArrayList<AssemblyInstruction> z80Instructions) {
    for (String key : labelReferences.keySet()) {
      Long address = labels.get(key);
      if (address != null) {
        for (long reference : labelReferences.get(key)) {
          updateLabelReference(z80Instructions, (int)reference, key, (int)((long)address));
        }
      }
    }
  }
  
  private void updateLabelReference(ArrayList<AssemblyInstruction> instructions, int reference, String key, int address) {
    //no code, so nothing to do
    if (instructions.size() == 0) {
      return;
    }
    
    //look up instruction that references the label
    int index = 0;
    AssemblyInstruction instruction = instructions.get(index);
    while (index < instructions.size() && !(instruction.getAddress() == reference && instruction.getBytes() != null)
      ) {
      index++;
      instruction = instructions.get(index);
    }
    
    //referring instruction not found
    if (index == instructions.size()) {
      return;
    }
    
    //update address part of the instruction
    if (instruction.getBytes().size() == 3 && LONG_JUMP_INSTRUCTIONS.contains(instruction.getBytes().get(0))) {
      //long jump or call
      instruction.getBytes().set((int)(reference - instruction.getAddress() + 1), (byte)(address % 256));
      instruction.getBytes().set((int)(reference - instruction.getAddress() + 2), (byte)((address / 256) % 256));
    } else if (instruction.getBytes().size() == 2 && RELATIVE_JUMP_INSTRUCTIONS.contains(instruction.getBytes().get(0))) {
      long offset = address - instruction.getAddress() - 2L;
      if (offset > 127 || offset < -128) {
        throw new RuntimeException(String.format("relative jump to label %s from address %04X (index %d) by instruction %s reaches too far."
          , key, reference, index, instruction.getCode()));
      }
      instruction.getBytes().set((int)(reference - instruction.getAddress() + 1), (byte)(offset));
    } else {
      throw new RuntimeException(String.format("illegal reference to label %s from address %04X (index %d) by instruction %s"
        , key, reference, index, instruction.getCode()));
    }
  }
  
  /* Transcode a single M-code instruction to one or more Z80S180 assembler instruction.
   * The transcoder uses the SP stackpointer and the PC program counter.
   * The arithmetic functions (accPlus, accMinus, minusAcc, accTimes, accDiv, divAcc, accCompare) 
   * use HL as a 16-bit accumulator, DE for the second 16-bit operand and the flags (in AF) as result indicators.
   * The conditional branch instructions use the flags (in AF) for the conditional jumps.
   * The runtime (see method plantZ80Runtime) uses DE, BC and AF temporarily (for the duration of an M-instruction) without preserving their current content.
   */
  private ArrayList<AssemblyInstruction> transcode(Instruction instruction){
    ArrayList<AssemblyInstruction> result = new ArrayList<AssemblyInstruction>();

    debug("\ntranscoding to Z80: " + instruction.toString());
    
    FunctionType function = instruction.function;
    if (function == FunctionType.comment) {
      result.add(new AssemblyInstruction(byteAddress, INDENT + ';' + instruction));
      return result;
    }
    
    //add original M-code instruction as assembler comment
    if (debugMode) {
      result.add(new AssemblyInstruction(byteAddress, INDENT + ';' + instruction));
    }

    int word = 0;
    int byt = 0;
    String str = "";
    if (instruction != null && instruction.operand != null && instruction.operand.intValue != null) {
      word = instruction.operand.intValue;
    }
    if (instruction != null && instruction.operand != null && instruction.operand.strValue != null) {
      str = instruction.operand.strValue;
    }
    int memAddress = MEM_START + word;
    AssemblyInstruction asm = null;
    debug("\n..function:" + function);

    //TODO refactor by removing asmCode.
    String asmCode = null;
    /*
     * special instructions:
     */
    if (function == FunctionType.stop) {
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP    00171H      ;Jump to Zilog Z80183 Monitor.", 0xC3, 0x71, 0x01);
      debug("\n.." + asm.getCode());
    } else if (function == FunctionType.call) {
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, String.format(INDENT + "CALL  0%04XH", word), 0xCD, word % 256, word / 256);
    } else if (function == FunctionType.read) {
      putLabelReference("read", byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  read", 0xCD, 0, 0);
    } else if (function == FunctionType.writeAcc8) {
      putLabelReference("writeA", byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  writeA", 0xCD, 0, 0);
    } else if (function == FunctionType.writeAcc16) {
      putLabelReference("writeHL", byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  writeHL", 0xCD, 0, 0);
    /*
     * 16-bit instructions:
     */
    } else if (function == FunctionType.acc16Store) {
      if (instruction.operand.opType == OperandType.stack16) {
          asm = new AssemblyInstruction(byteAddress, INDENT + "PUSH  HL", 0xE5);
      } else if ((instruction.operand.opType == OperandType.var) && (instruction.operand.datatype == Datatype.integer)) {
          asmCode = String.format(INDENT + "LD    (0%04XH),HL", memAddress);
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x22, memAddress % 256, memAddress / 256);
      } else if ((instruction.operand.opType == OperandType.var) && (instruction.operand.datatype == Datatype.byt)) {
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    A,L", 0x7D));
          asmCode = String.format(INDENT + "LD    (0%04XH),A", memAddress);
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x32, memAddress % 256, memAddress / 256);
      } else {
        throw new RuntimeException("illegal M-code instruction: " + instruction);
      }
    } else if (function == FunctionType.acc16Load) {
      asm = operandToHL(instruction);
    } else if (function == FunctionType.stackAcc16Load) {
      result.add(new AssemblyInstruction(byteAddress++, INDENT + "PUSH  HL", 0xE6));
      if (instruction.operand.opType == OperandType.stack16) {
        throw new RuntimeException("illegal M-code instruction: stackAccLoad unstack");
      }
      asm = operandToHL(instruction);
    } else if (function == FunctionType.acc16Plus) {
      if (instruction.operand.opType == OperandType.acc && instruction.operand.datatype == Datatype.byt) {
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    E,A", 0x5F));
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    D,0", 0x16, 0x00));
        byteAddress++;
      } else if (instruction.operand.opType == OperandType.stack8) {
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "POP   DE", 0xD1));
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    D,0", 0x16, 0x00));
        byteAddress++;
      } else {
        asm = operandToDE(instruction);
        result.add(asm);
        byteAddress += asm.getBytes().size();
      }
      asm = new AssemblyInstruction(byteAddress, INDENT + "ADD   HL,DE", 0x19);
    } else if ((function == FunctionType.acc16Minus)
      || (function == FunctionType.minusAcc16)
      || (function == FunctionType.acc16Compare)
      || (function == FunctionType.revAcc16Compare)
      || (function == FunctionType.acc16CompareAcc8)
      || (function == FunctionType.acc8CompareAcc16)) {
      if ((function == FunctionType.acc16CompareAcc8) || 
          (function == FunctionType.acc8CompareAcc16) || 
          (instruction.operand.opType == OperandType.acc && instruction.operand.datatype == Datatype.byt)) {
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    E,A", 0x5F));
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    D,0", 0x16, 0x00));
        byteAddress++;
      } else if (instruction.operand.opType == OperandType.stack8) {
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "POP   DE", 0xD1));
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    D,0", 0x16, 0x00));
        byteAddress++;
      } else {
        asm = operandToDE(instruction);
        result.add(asm);
        byteAddress += asm.getBytes().size();
      }
      
      if ((function == FunctionType.minusAcc16) || (function == FunctionType.acc16CompareAcc8)) {
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "EX    DE,HL", 0xEB));
      }

      result.add(new AssemblyInstruction(byteAddress++, INDENT + "OR    A", 0xB7));
      asm = new AssemblyInstruction(byteAddress, INDENT + "SBC   HL,DE", 0xED, 0x52);
    } else if (function == FunctionType.acc16Times) {
      if (instruction.operand.opType == OperandType.acc && instruction.operand.datatype == Datatype.byt) {
        putLabelReference("mul16_8", byteAddress);
        asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  mul16_8", 0xCD, 0x00, 0x00);
      } else {
        asm = operandToDE(instruction);
        result.add(asm);
        byteAddress += asm.getBytes().size();
        putLabelReference("mul16", byteAddress);
        asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  mul16", 0xCD, 0x00, 0x00);
      }
    } else if ((function == FunctionType.acc16Div) || (function == FunctionType.divAcc16)) {
      if (instruction.operand.opType == OperandType.acc && instruction.operand.datatype == Datatype.byt) {
        if (function == FunctionType.divAcc16) {
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "EX    DE,HL", 0xEB));
          putLabelReference("div8_16", byteAddress);
          asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  div8_16", 0xCD, 0x00, 0x00);
        } else {
          putLabelReference("div16_8", byteAddress);
          asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  div16_8", 0xCD, 0x00, 0x00);
        }
      } else {
        asm = operandToDE(instruction);
        result.add(asm);
        byteAddress += asm.getBytes().size();

        if (function == FunctionType.divAcc16) {
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "EX    DE,HL", 0xEB));
        }
        putLabelReference("div16", byteAddress);
        asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  div16", 0xCD, 0x00, 0x00);
      }
    } else if (function == FunctionType.increment16 && instruction.operand.opType == OperandType.var) {
      asm = operandToHL(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();
      result.add(new AssemblyInstruction(byteAddress++, INDENT + "INC   HL", 0x23));
      asmCode = String.format(INDENT + "LD    (0%04XH),HL", memAddress);
      asm = new AssemblyInstruction(byteAddress, asmCode, 0x22, memAddress % 256, memAddress / 256);
    } else if (function == FunctionType.decrement16 && instruction.operand.opType == OperandType.var) {
      asm = operandToHL(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();
      result.add(new AssemblyInstruction(byteAddress++, INDENT + "DEC   HL", 0x2B));
      asmCode = String.format(INDENT + "LD    (0%04XH),HL", memAddress);
      asm = new AssemblyInstruction(byteAddress, asmCode, 0x22, memAddress % 256, memAddress / 256);
    } else if (function == FunctionType.increment16 && instruction.operand.opType == OperandType.var) {
      asm = operandToHL(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();
      result.add(new AssemblyInstruction(byteAddress++, INDENT + "INC   HL", 0x23));
      asmCode = String.format(INDENT + "LD    (0%04XH),HL", memAddress);
      asm = new AssemblyInstruction(byteAddress, asmCode, 0x22, memAddress % 256, memAddress / 256);
    } else if (function == FunctionType.decrement16 && instruction.operand.opType == OperandType.var) {
      asm = operandToHL(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();
      result.add(new AssemblyInstruction(byteAddress++, INDENT + "DEC   HL", 0x2B));
      asmCode = String.format(INDENT + "LD    (0%04XH),HL", memAddress);
      asm = new AssemblyInstruction(byteAddress, asmCode, 0x22, memAddress % 256, memAddress / 256);
    /*
     * 8-bit instructions:
     */
    } else if (function == FunctionType.acc8Store) {
      if (instruction.operand.opType == OperandType.stack8) {
        asm = new AssemblyInstruction(byteAddress, INDENT + "PUSH  AF", 0xF5);
      } else if ((instruction.operand.opType == OperandType.var) && (instruction.operand.datatype == Datatype.byt)) {
        asmCode = String.format(INDENT + "LD    (0%04XH),A", memAddress);
        asm = new AssemblyInstruction(byteAddress, asmCode, 0x32, memAddress % 256, memAddress / 256);
      } else if ((instruction.operand.opType == OperandType.var) && (instruction.operand.datatype == Datatype.integer)) {
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    L,A", 0x6F));
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    H,0", 0x26, 0));
        byteAddress++;
        asmCode = String.format(INDENT + "LD    (0%04XH),HL", memAddress);
        asm = new AssemblyInstruction(byteAddress, asmCode, 0x22, memAddress % 256, memAddress / 256);
      } else {
        throw new RuntimeException("illegal M-code instruction: " + instruction);
      }
    } else if (function == FunctionType.acc8Load) {
      asm = operandToA(instruction);
    } else if (function == FunctionType.stackAcc8Load) {
      result.add(new AssemblyInstruction(byteAddress++, INDENT + "PUSH  AF", 0xF5));
      if (instruction.operand.opType == OperandType.stack8) {
        throw new RuntimeException("illegal M-code instruction: stackAccLoad unstack");
      }
      asm = operandToA(instruction);
    } else if (function == FunctionType.acc8Plus) {
      switch(instruction.operand.opType) {
        case var:
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    B,A", 0x47));

          memAddress = MEM_START + instruction.operand.intValue;
          asmCode = String.format(INDENT + "LD    A,(0%04XH)", memAddress);
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x3A, memAddress % 256, memAddress / 256);
          result.add(asm);
          byteAddress += asm.getBytes().size();
          
          asmCode = INDENT + "ADD   A,B";
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x80);
          break;
        case constant: 
          byt = instruction.operand.intValue % 256;
          asmCode = INDENT + "ADD   A," + byt;
          asm = new AssemblyInstruction(byteAddress, asmCode, 0xC6, byt);
          break;
        case stack8:
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "POP   BC", 0xC1));
          asmCode = INDENT + "ADD   A,B";
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x80);
          break;
      };
    } else if ((function == FunctionType.acc8Minus) ||
               (function == FunctionType.minusAcc8) ||
               (function == FunctionType.acc8Compare) ||
               (function == FunctionType.revAcc8Compare)) {
      switch(instruction.operand.opType) {
        case var:
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    B,A", 0x47));

          memAddress = MEM_START + instruction.operand.intValue;
          asmCode = String.format(INDENT + "LD    A,(0%04XH)", memAddress);
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x3A, memAddress % 256, memAddress / 256);
          result.add(asm);
          byteAddress += asm.getBytes().size();
          
          asmCode = INDENT + "SUB   A,B";
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x90);
          break;
        case constant: 
          byt = instruction.operand.intValue % 256;
          asmCode = INDENT + "SUB   A," + byt;
          asm = new AssemblyInstruction(byteAddress, asmCode, 0xD6, byt);
          break;
        case stack8:
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "POP   BC", 0xC1));
          asmCode = INDENT + "SUB   A,B";
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x90);
          break;
      };
      if (function == FunctionType.minusAcc8) {
        result.add(asm);
        byteAddress += asm.getBytes().size();
        asm = new AssemblyInstruction(byteAddress, INDENT + "NEG", 0xED, 0x44);
      }
    } else if (function == FunctionType.acc8Times) {
      switch(instruction.operand.opType) {
        case var:
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    B,A", 0x47));

          memAddress = MEM_START + instruction.operand.intValue;
          asmCode = String.format(INDENT + "LD    A,(0%04XH)", memAddress);
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x3A, memAddress % 256, memAddress / 256);
          result.add(asm);
          byteAddress += asm.getBytes().size();

          result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    C,A", 0x4F));
          break;
        case constant: 
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    B,A", 0x47));

          byt = instruction.operand.intValue % 256;
          asmCode = INDENT + "LD    C," + byt;
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x0E, byt);
          result.add(asm);
          byteAddress += asm.getBytes().size();
          break;
        case stack8:
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "POP   BC", 0xC1));
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    B,A", 0x47));
          break;
      };
      asm = new AssemblyInstruction(byteAddress, INDENT + "MLT   BC", 0xED, 0x4C);
      result.add(asm);
      byteAddress += asm.getBytes().size();

      asm = new AssemblyInstruction(byteAddress, INDENT + "LD    A,C", 0x79);
    } else if (function == FunctionType.divAcc8) {
      result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    C,A", 0x4F));
      switch(instruction.operand.opType) {
        case var:
          memAddress = MEM_START + instruction.operand.intValue;
          asmCode = String.format(INDENT + "LD    A,(0%04XH)", memAddress);
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x3A, memAddress % 256, memAddress / 256);
          result.add(asm);
          byteAddress += asm.getBytes().size();
          break;
        case constant:
          byt = instruction.operand.intValue % 256;
          asmCode = INDENT + "LD    A," + byt;
          result.add(new AssemblyInstruction(byteAddress++, asmCode, 0x3E, byt));
          byteAddress++;
          break;
        case stack8:
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "POP   AF", 0xF1));
          break;
      };
      // divide C by A.
      putLabelReference("div8", byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  div8", 0xCD, 0x00, 0x00);
    } else if (function == FunctionType.acc8Div) {
      switch(instruction.operand.opType) {
        case var:
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    B,A", 0x4F));

          memAddress = MEM_START + instruction.operand.intValue;
          asmCode = String.format(INDENT + "LD    A,(0%04XH)", memAddress);
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x3A, memAddress % 256, memAddress / 256);
          result.add(asm);
          byteAddress += asm.getBytes().size();

          result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    C,A", 0x4F));
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    A,B", 0x78));
          break;
        case constant: 
          byt = instruction.operand.intValue % 256;
          asmCode = INDENT + "LD    C," + byt;
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x0E, byt);
          result.add(asm);
          byteAddress += asm.getBytes().size();
          break;
        case stack8:
          result.add(new AssemblyInstruction(byteAddress++, INDENT + "POP   BC", 0xC1));
          break;
      };
      // divide C by A.
      putLabelReference("div8", byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  div8", 0xCD, 0x00, 0x00);
    } else if (function == FunctionType.increment8 && instruction.operand.opType == OperandType.var) {
      asm = operandToHL(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();
      asm = new AssemblyInstruction(byteAddress, INDENT + "INC   (HL)", 0x34);
    } else if (function == FunctionType.decrement8 && instruction.operand.opType == OperandType.var) {
      asm = operandToHL(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();
      asm = new AssemblyInstruction(byteAddress, INDENT + "DEC   (HL)", 0x35);
    /*
     * 16/8-bit conversion:
     */
    } else if (function == FunctionType.acc8ToAcc16) {
      result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    L,A", 0x6F));
      asm = new AssemblyInstruction(byteAddress, INDENT + "LD    H,0", 0x26, 0x00);
    } else if (function == FunctionType.acc16ToAcc8) {
      asm = new AssemblyInstruction(byteAddress, INDENT + "LD    A,L", 0x7D);
    } else if (function == FunctionType.stackAcc16ToAcc8) {
      result.add(new AssemblyInstruction(byteAddress++, INDENT + "PUSH  AF", 0xF5));
      asm = new AssemblyInstruction(byteAddress, INDENT + "LD    A,L", 0x7D);
    } else if (function == FunctionType.stackAcc8ToAcc16) {
      result.add(new AssemblyInstruction(byteAddress++, INDENT + "PUSH  HL", 0xE5));
      result.add(new AssemblyInstruction(byteAddress++, INDENT + "LD    L,A", 0x6F));
      asm = new AssemblyInstruction(byteAddress, INDENT + "LD    H,0", 0x26, 0x00);
    /*
     * stack instructions:
     */
    } else if (function == FunctionType.stackAcc16) {
      asm = new AssemblyInstruction(byteAddress, INDENT + "PUSH HL", 0xE6);
    } else if (function == FunctionType.stackAcc8) {
      asm = new AssemblyInstruction(byteAddress, INDENT + "PUSH AF", 0xF6);
    } else if (function == FunctionType.unstackAcc16) {
      asm = new AssemblyInstruction(byteAddress, INDENT + "POP  HL", 0xE1);
    } else if (function == FunctionType.unstackAcc8) {
      asm = new AssemblyInstruction(byteAddress, INDENT + "POP  AF", 0xF1);
    /*
     * branch instructions:
     */
    } else if (function == FunctionType.br) {
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP    L" + word, 0xC3, word % 256, word / 256);
    } else if (function == FunctionType.brEq) {
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP    Z,L" + word, 0xCA, word % 256, word / 256);
    } else if (function == FunctionType.brNe) {
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP    NZ,L" + word, 0xC2, word % 256, word / 256);
    } else if (function == FunctionType.brLt) {
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP    C,L" + word, 0xDA, word % 256, word / 256);
    } else if (function == FunctionType.brLe) {
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP    Z,L" + word, 0xCA, word % 256, word / 256);
    } else if (function == FunctionType.brGt) {
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP    Z,$+5", 0x28, 3);
      result.add(asm);
      byteAddress += asm.getBytes().size();
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP    C,L" + word, 0xDA, word % 256, word / 256);
    } else if (function == FunctionType.brGe) {
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP    NC,L" + word, 0xD2, word % 256, word / 256);
    }

    /*
     * add assembly code to output and update byte address.
     */
    result.add(asm);
    if (asm == null) {
      throw new RuntimeException("asm is null transcoding instruction " + instruction.toString());
    }
    if (asm.getBytes() != null) {
      byteAddress += asm.getBytes().size();
    }

    return result;
  }
  
  private AssemblyInstruction operandToA(Instruction instruction) {
    String asmCode = null;
    AssemblyInstruction asm = null;
    switch(instruction.operand.opType) {
      case var: 
        int memAddress = MEM_START + instruction.operand.intValue;
        asmCode = String.format(INDENT + "LD    A,(0%04XH)", memAddress);
        asm = new AssemblyInstruction(byteAddress, asmCode, 0x3A, memAddress % 256, memAddress / 256);
        break;
      case constant: 
        asmCode = INDENT + "LD    A," + instruction.operand.intValue;
        asm = new AssemblyInstruction(byteAddress, asmCode, 0x3E, instruction.operand.intValue % 256);
        break;
      case stack8:
        asmCode = INDENT + "POP   AF";
        asm = new AssemblyInstruction(byteAddress, asmCode, 0xF1);
        break;
    };
    return asm;
  }

  private AssemblyInstruction operandToHL(Instruction instruction) {
    String asmCode = null;
    AssemblyInstruction asm = null;
    switch(instruction.operand.opType) {
      case var: 
        int memAddress = MEM_START + instruction.operand.intValue;
        asmCode = String.format(INDENT + "LD    HL,(0%04XH)", memAddress);
        asm = new AssemblyInstruction(byteAddress, asmCode, 0x2A, memAddress % 256, memAddress / 256);
        break;
      case constant: 
        asmCode = INDENT + "LD    HL," + instruction.operand.intValue;
        asm = new AssemblyInstruction(byteAddress, asmCode, 0x21, instruction.operand.intValue % 256, instruction.operand.intValue / 256);
        break;
      case stack16:
        asmCode = INDENT + "POP   HL";
        asm = new AssemblyInstruction(byteAddress, asmCode, 0xE1);
        break;
    };
    return asm;
  }

  private AssemblyInstruction operandToDE(Instruction instruction) {
    String asmCode = null;
    AssemblyInstruction asm = null;
    switch(instruction.operand.opType) {
      case var: 
        int memAddress = MEM_START + instruction.operand.intValue;
        asmCode = String.format(INDENT + "LD    DE,(0%04XH)", memAddress);
        asm = new AssemblyInstruction(byteAddress, asmCode, 0xED, 0x5B, memAddress % 256, memAddress / 256);
        break;
      case constant: 
        asmCode = INDENT + "LD    DE," + instruction.operand.intValue;
        asm = new AssemblyInstruction(byteAddress, asmCode, 0x11, instruction.operand.intValue % 256, instruction.operand.intValue / 256);
        break;
      case stack16:
        asmCode = INDENT + "POP   DE";
        asm = new AssemblyInstruction(byteAddress, asmCode, 0xD1);
        break;
    };
    return asm;
  }

  private void putLabelReference(int value, long reference) {
    String label = "L" + value;
    putLabelReference(label, reference);
  }
  
  private void putLabelReference(String label, long reference) {
    if (labelReferences.get(label) == null) {
      labelReferences.put(label, new ArrayList<Long>());
    }
    labelReferences.get(label).add(reference);
  }
  
  private AssemblyInstruction plantAssemblyInstruction(String code, int... bytes) {
    AssemblyInstruction asm = new AssemblyInstruction(byteAddress, code, bytes);
    byteAddress += asm.getBytes().size();
    return asm;
  }
  
  private ArrayList<AssemblyInstruction> plantZ80Runtime() {
    ArrayList<AssemblyInstruction> result = new ArrayList<AssemblyInstruction>();
    labels.put("start", byteAddress);
    //hardware related constants
    result.add(new AssemblyInstruction(byteAddress,  "TOS     equ 0FD00H        ;User stack grows before user global data."));
    //on-chip registers
    result.add(new AssemblyInstruction(byteAddress,  "CNTLA0  equ 000H          ;144 ASCI0 Control Register A."));
    result.add(new AssemblyInstruction(byteAddress,  "STAT0   equ 004H          ;147 ASCI0 Status register."));
    result.add(new AssemblyInstruction(byteAddress,  "TDR0    equ 006H          ;148 ASCI0 Transmit Data Register."));
    result.add(new AssemblyInstruction(byteAddress,  "RDR0    equ 008H          ;149 ASCI0 Receive Data Register."));
    //bits within on-chip registers
    result.add(new AssemblyInstruction(byteAddress,  "ERROR   equ 3             ;CNTLA0->OVRN,FE,PE,BRK error flags."));
    result.add(new AssemblyInstruction(byteAddress,  "TDRE    equ 1             ;STAT0->Tx data register empty bit."));
    result.add(new AssemblyInstruction(byteAddress,  "OVERRUN equ 6             ;STAT0->OVERRUN bit."));
    result.add(new AssemblyInstruction(byteAddress,  "RDRF    equ 7             ;STAT0->Rx data register full bit."));
    
    //start up code
    result.add(new AssemblyInstruction(byteAddress, INDENT + ".ORG  02000H      ;lowest external RAM address."));
    result.add(new AssemblyInstruction(byteAddress, "start:"));
    result.add(plantAssemblyInstruction(INDENT + "LD    SP,TOS", 0x31, 0x00, 0xFD));
    putLabelReference("main", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JP    main", 0xC3, 0, 0));
    
    //start of module wait.asm
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";WAIT - Wait DE * 1 msec @ 18,432 MHz with no wait states"));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  DE number of msec to wait"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none"));
    result.add(new AssemblyInstruction(byteAddress, ";  USES: 4 bytes on stack"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("WAIT", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "WAIT:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  DE", 0xD5));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));
    labels.put("WAIT1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "WAIT1:"));
    putLabelReference("WAIT1M", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  WAIT1M      ;Wait 1 msec", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "DEC   DE", 0x1B));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,D", 0x7A));
    result.add(plantAssemblyInstruction(INDENT + "OR    A,E", 0xB3));
    putLabelReference("WAIT1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    NZ,WAIT1", 0x20, 0));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "POP   DE", 0xD1));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";WAIT1M"));
    result.add(new AssemblyInstruction(byteAddress, ";wait 1 msec at 18,432 MHz with no wait states"));
    result.add(new AssemblyInstruction(byteAddress, ";The routine requires 56+n*22 states, so that with n=834"));
    result.add(new AssemblyInstruction(byteAddress, ";28  clock cycles remain left."));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("WAIT1M", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "WAIT1M:"));
    result.add(plantAssemblyInstruction(            INDENT + "PUSH  HL          ;5      11 (11)", 0xE5));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 opcode"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem write"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       1 inc SP"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem write"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       1 inc SP"));
    result.add(plantAssemblyInstruction(            INDENT + "PUSH  AF          ;5      11 (22)", 0xF5));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 opcode"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem write"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       1 inc SP"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem write"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       1 inc SP"));
    result.add(plantAssemblyInstruction(            INDENT + "LD    HL, 834     ;3      9 (31)", 0x21, 0x42, 0x03));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 opcode"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem read"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem read"));
    labels.put("WAIT1M2", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "WAIT1M2:"));
    result.add(plantAssemblyInstruction(            INDENT + "DEC   HL          ;2      4 (31+n*4)", 0x2B));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 opcode"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       1 execute"));
    result.add(plantAssemblyInstruction(            INDENT + "LD    A,H         ;2      6 (31+n*10)", 0x7C));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 opcode"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 execute"));
    result.add(plantAssemblyInstruction(            INDENT + "OR    A,L         ;2      4 (31+n*14)", 0xB5));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 opcode"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       1 execute"));
    putLabelReference("WAIT1M2", byteAddress);
    result.add(plantAssemblyInstruction(            INDENT + "JR    NZ,WAIT1M2  ;4      8 (31+n*22) if NZ", 0x20, 0));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 opcode"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem read"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       1 execute"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       1 execute"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;2      6 (29+n*22) if not NZ"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 opcode"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem read"));
    result.add(plantAssemblyInstruction(            INDENT + "POP   AF          ;3      9 (38+n*22)", 0xF1));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 opcode"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem read"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem read"));
    result.add(plantAssemblyInstruction(            INDENT + "POP   HL          ;3      9 (47+n*22)", 0xE1));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 opcode"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem read"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem read"));
    result.add(plantAssemblyInstruction(            INDENT + "RET               ;3      9 (56+n*22)", 0xC9));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 opcode"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem read"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;       3 mem read"));
    //end of module wait.asm
    
    //start of module chario.asm
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";getChar"));
    result.add(new AssemblyInstruction(byteAddress, ";Check if an input character from ASCI0 is available."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  none"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: F: ZERO flag set if no character is available."));
    result.add(new AssemblyInstruction(byteAddress, ";          ZERO flag reset if a character is available."));
    result.add(new AssemblyInstruction(byteAddress, ";       A : character from ASCI0, if available."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:AF"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("getChar", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "getChar:"));
    result.add(plantAssemblyInstruction(INDENT + "IN0   A,(STAT0)   ;read ASCI0 status", 0xED, 0x38, 0x04));
    result.add(plantAssemblyInstruction(INDENT + "BIT   OVERRUN,A   ;check if ASCIO OVERRUN bit is set", 0xCB, 0x77));
    putLabelReference("getChar1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    NZ,getChar1 ;-yes: reset error flags", 0x20, 0));
    result.add(plantAssemblyInstruction(INDENT + "BIT   RDRF,A      ;check if ASCIO RDRF bit is set", 0xCB, 0x7F));
    result.add(plantAssemblyInstruction(INDENT + "RET   Z           ;-no: return without a character", 0xC8));
    result.add(plantAssemblyInstruction(INDENT + "IN0   A,(RDR0)    ;-yes:read ASCIO Rx data register", 0xED, 0x38, 0x08));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));
    labels.put("getChar1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "getChar1:"));
    result.add(plantAssemblyInstruction(INDENT + "IN0   A,(CNTLA0)  ;read ASCI0 control register", 0xED, 0x38, 0x00));
    result.add(plantAssemblyInstruction(INDENT + "RES   ERROR,A     ;reset OVRN,FE,PE,BRK flags", 0xCB, 0x9F));
    result.add(plantAssemblyInstruction(INDENT + "OUT0  (CNTLA0),A  ;write back to ASCI0 CTRL", 0xED, 0x39, 0x00));
    result.add(plantAssemblyInstruction(INDENT + "XOR   A", 0xAF));
    result.add(plantAssemblyInstruction(INDENT + "RET               ;return without a character", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putMsg"));
    result.add(new AssemblyInstruction(byteAddress, ";Print via ASCI0 a zero terminated string, starting at the return address on the stack."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  none."));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:none."));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putMsg", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putMsg:"));
    result.add(plantAssemblyInstruction(INDENT + "EX    (SP),HL     ;save HL and load return address into HL.", 0xE3));
    putLabelReference("putStr", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putStr", 0xCD, 0x1B, 0x21));
    result.add(plantAssemblyInstruction(INDENT + "EX    (SP),HL     ;put return address onto stack and restore HL.", 0xE3));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putStr"));
    result.add(new AssemblyInstruction(byteAddress, ";Print via ASCI0 a zero terminated string, pointed to by HL."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  HL:address of zero terminated string to be printed."));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:HL (point to byte after zero terminated string)"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putStr", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putStr:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF          ;save registers", 0xF5));
    labels.put("putStr1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putStr1:"));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,(HL)      ;get next character", 0x7E));
    result.add(plantAssemblyInstruction(INDENT + "INC   HL", 0x23));
    result.add(plantAssemblyInstruction(INDENT + "OR    A,A         ;is it zer0?", 0xB7));
    putLabelReference("putStr2", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    Z,putStr2   ;yes ->return", 0x28, 0x05));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar     ;no->put it to ASCI0", 0xCD, 0, 0));
    putLabelReference("putStr1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    putStr1", 0x18, 0xF6));
    labels.put("putStr2", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putStr2:"));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putSpace"));
    result.add(new AssemblyInstruction(byteAddress, ";Send a space character to ASCI0"));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  none."));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:AF"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putSpace", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putSpace:"));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,' '       ;load space and continue with putChar.", 0x3E, 0x20));
    
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putChar"));
    result.add(new AssemblyInstruction(byteAddress, ";Send one character to ASCI0."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  A = character"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:AF"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putChar", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putChar:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF          ;send the character via ASCI0", 0xF5));
    labels.put("putChar1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putChar1:"));
    result.add(plantAssemblyInstruction(INDENT + "IN0   A,(STAT0)   ;read ASCI0 status register", 0xED, 0x38, 0x04));
    result.add(plantAssemblyInstruction(INDENT + "BIT   TDRE,A      ;wait until TDRE <> 0", 0xCB, 0x4F));
    putLabelReference("putChar1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    Z,putChar1", 0x28, 0xF9));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF          ;restore AF registers", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "OUT0  (TDR0),A    ;write character to ASCI0", 0xED, 0x39, 0x06));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putCRLF"));
    result.add(new AssemblyInstruction(byteAddress, ";Send CR and LF to ASCI0"));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  none."));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:none."));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putCRLF", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putCRLF:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,'\\r'       ;print carriage return", 0x3E, 0x0D));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,'\\n'       ;print line feed", 0x3E, 0x0A));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putErase"));
    result.add(new AssemblyInstruction(byteAddress, ";Erase the latest character at ASCI0"));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  none."));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:AF"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putErase", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putErase:"));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,'\\b'       ;print backspace", 0x3E, 0x08));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0, 0));
    putLabelReference("putSpace", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putSpace    ;print space (erase character)", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,'\\b'      ;print backspace", 0x3E, 0x08));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    putChar", 0x18, 0xDA));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putBell"));
    result.add(new AssemblyInstruction(byteAddress, ";Send a Bell character to ASCI0"));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  none."));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:AF"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putBell", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putBell:"));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,07        ;ring the bell at ASCI0", 0x3E, 0x07));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    putChar", 0x18, 0xD6));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putHexHL"));
    result.add(new AssemblyInstruction(byteAddress, ";Print HL register pair as 4 hex digits"));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  HL = word to be printed."));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:none."));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putHexHL", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putHexHL:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF          ;save used registers", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,H         ;print H as 2 hex digits", 0x7C));
    putLabelReference("putHexA", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putHexA", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,L         ;print L as 2 hex digits", 0x7D));
    putLabelReference("putHexA", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putHexA", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF          ;restore used registers", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putHexA"));
    result.add(new AssemblyInstruction(byteAddress, ";Print A register as 2 hex digits"));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  A = byte to be printed"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:none."));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putHexA", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putHexA:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF          ;save input", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "RRA               ;shift upper nibble to the right", 0x1F));
    result.add(plantAssemblyInstruction(INDENT + "RRA", 0x1F));
    result.add(plantAssemblyInstruction(INDENT + "RRA", 0x1F));
    result.add(plantAssemblyInstruction(INDENT + "RRA", 0x1F));
    putLabelReference("putHexA1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putHexA1    ;print upper nibble", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF          ;restore input & print lower nibble", 0xF1));
    labels.put("putHexA1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putHexA1:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF          ;save input", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "AND   A,00FH      ;mask lower nibble", 0xE6, 0x0F));
    result.add(plantAssemblyInstruction(INDENT + "ADD   A,'0'       ;convert to hex digit", 0xC6, 0x30));
    result.add(plantAssemblyInstruction(INDENT + "CP    A,'9'+1", 0xFE, 0x3A));
    putLabelReference("putHexA2", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    C,putHexA2", 0x38, 0x02));
    result.add(plantAssemblyInstruction(INDENT + "ADD   A,07", 0xC6, 0x07));
    labels.put("putHexA2", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putHexA2:"));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF          ;restore input", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "RET               ;and return", 0xC9));
    //end of module chario.asm
    
    //start of module mul.asm
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";mul16"));
    result.add(new AssemblyInstruction(byteAddress, ";16 by 16 bit unsigned multiplication with 16 bit result."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  HL = operand 1"));
    result.add(new AssemblyInstruction(byteAddress, ";       DE = operand 2"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: HL = HL * DE low part"));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:DE"));
    result.add(new AssemblyInstruction(byteAddress, ";  Size   25 bytes"));
    result.add(new AssemblyInstruction(byteAddress, ";  Time  160 cycles"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("mul16", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "mul16:"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";HL = HL * DE"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";        H  L"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";        D  E"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";    --------*"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";          EL"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";       EH  0"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";       DL  0"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "; -----------+"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";        R  S"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";S = ELlow"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";R = ELhigh+EHlow+DLlow"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  BC          ;11  11 save BC", 0xC5));
    result.add(plantAssemblyInstruction(INDENT + "LD    B,H         ; 4  15 copy HL to BC", 0x44));
    result.add(plantAssemblyInstruction(INDENT + "LD    C,L         ; 4  19", 0x4D));
    result.add(plantAssemblyInstruction(INDENT + "LD    H,E         ; 4  23 HL contains EL", 0x63));
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL          ;17  40", 0xED,0x6C));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  HL          ;11  51", 0xE5));
    result.add(plantAssemblyInstruction(INDENT + "LD    H,E         ; 4  55 HL contains EH aka EB", 0x63));
    result.add(plantAssemblyInstruction(INDENT + "LD    L,B         ; 4  59", 0x68));
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL          ;17  76", 0xED, 0x6C));
    result.add(plantAssemblyInstruction(INDENT + "LD    B,L         ; 4  80 save EHlow in B", 0x45));
    result.add(plantAssemblyInstruction(INDENT + "LD    H,D         ; 4  84 HL contains DL aka DC", 0x62));
    result.add(plantAssemblyInstruction(INDENT + "LD    L,C         ; 4  88", 0x69));
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL          ;17 105", 0xED, 0x6C));
    result.add(plantAssemblyInstruction(INDENT + "LD    D,L         ; 4 109 DLlow into DE", 0x55));
    result.add(plantAssemblyInstruction(INDENT + "LD    E,0         ; 6 115", 0x1E, 0x00));
    result.add(plantAssemblyInstruction(INDENT + "POP   HL          ; 9 124 add EL+DElow", 0xE1));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,DE       ; 7 131", 0x19));
    result.add(plantAssemblyInstruction(INDENT + "LD    D,B         ; 4 135 add EL+DElow+EHlow", 0x50));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,DE       ; 7 142", 0x19));
    result.add(plantAssemblyInstruction(INDENT + "POP   BC          ; 9 151 restore BC", 0xC1));
    result.add(plantAssemblyInstruction(INDENT + "RET               ; 9 160", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";mul16_10"));
    result.add(new AssemblyInstruction(byteAddress, ";multiply a 16 bit unsigned number by 10 with a 16 bit result."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  HL = operand"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: HL = HL * 10; low part"));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:Flags"));
    result.add(new AssemblyInstruction(byteAddress, ";  Size   9 bytes"));
    result.add(new AssemblyInstruction(byteAddress, ";  Time   65 cycles"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("mul16_10", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "mul16_10:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  DE          ;11 11", 0xD5));
    result.add(plantAssemblyInstruction(INDENT + "LD    D,H         ; 4 15", 0x54));
    result.add(plantAssemblyInstruction(INDENT + "LD    E,L         ; 4 19", 0x5D));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,HL       ; 7 26 times 2", 0x29));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,HL       ; 7 33 times 4", 0x29));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,DE       ; 7 40 times 5", 0x19));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,HL       ; 7 47 times 10", 0x29));
    result.add(plantAssemblyInstruction(INDENT + "POP   DE          ; 9 56", 0xD1));
    result.add(plantAssemblyInstruction(INDENT + "RET               ; 9 65", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";mul16_8"));
    result.add(new AssemblyInstruction(byteAddress, ";16 by 8 bit unsigned multiplication with 16 bit result."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  HL = operand 1"));
    result.add(new AssemblyInstruction(byteAddress, ";        A = operand 2"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: HL = HL * A low part"));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:AF"));
    result.add(new AssemblyInstruction(byteAddress, ";  Size   .. bytes"));
    result.add(new AssemblyInstruction(byteAddress, ";  Time  ... cycles"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("mul16_8", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "mul16_8:"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";HL = HL * A"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";        H  L"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";           A"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";    --------*"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";          AL"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";       AH  0"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "; -----------+"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";        R  S"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";S = ALlow"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";R = ALhigh+AHlow"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  BC          ;11  11 save BC", 0xC5));
    result.add(plantAssemblyInstruction(INDENT + "LD    B,H         ; 4  15", 0x44));
    result.add(plantAssemblyInstruction(INDENT + "LD    C,A         ; 4  19", 0x47));
    result.add(plantAssemblyInstruction(INDENT + "LD    H,A         ; 4  23", 0x67));
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL          ;17  40 HL = AL", 0xED, 0x6C));
    result.add(plantAssemblyInstruction(INDENT + "MLT   BC          ;17  57 BC = AH", 0xED, 0x4C));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,H         ; 4  61 A = S = ALhigh+AHlow", 0x7C));
    result.add(plantAssemblyInstruction(INDENT + "ADD   A,C         ; 4  65", 0x81));
    result.add(plantAssemblyInstruction(INDENT + "LD    H,A         ; 4  69", 0x67));
    result.add(plantAssemblyInstruction(INDENT + "POP   BC          ; 9  78 | 289 restore BC", 0xC1));
    result.add(plantAssemblyInstruction(INDENT + "RET               ; 9  87 | 307", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";mul1632"));
    result.add(new AssemblyInstruction(byteAddress, ";16 by 16 bit unsigned multiplication with 32 bit result."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  HL = operand 1"));
    result.add(new AssemblyInstruction(byteAddress, ";       DE = operand 2"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: HL = HL * DE low part"));
    result.add(new AssemblyInstruction(byteAddress, ";       DE = HL * DE high part"));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:-"));
    result.add(new AssemblyInstruction(byteAddress, ";  Size 49 bytes"));
    result.add(new AssemblyInstruction(byteAddress, ";  Time between 303 en 307 cycles"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("mul1632", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "mul1632:"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";HL = HL * DE"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";        H  L"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";        D  E"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";    --------*"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";          EL"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";       EH  0"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";       DL  0"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";    DH  0  0"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "; -----------+"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";  P  Q  R  S"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";S = ELlow"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";R = ELhigh+EHlow+DLlow"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";Q = DHlow+EHhigh+DLhigh"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";P = DHhigh"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF          ;11  11 save AF", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  BC          ;11  22 save BC", 0xC5));
    result.add(plantAssemblyInstruction(INDENT + "LD    B,H         ; 4  26", 0x44));
    result.add(plantAssemblyInstruction(INDENT + "LD    C,L         ; 4  30", 0x4D));
    result.add(plantAssemblyInstruction(INDENT + "LD    H,D         ; 4  34 HL contains DH aka DB", 0x62));
    result.add(plantAssemblyInstruction(INDENT + "LD    L,B         ; 4  38", 0x68));
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL          ;17  55", 0xED, 0x6C));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  HL          ;11  66", 0xE5));
    result.add(plantAssemblyInstruction(INDENT + "LD    H,D         ; 4  70 HL contains DL aka DC", 0x62));
    result.add(plantAssemblyInstruction(INDENT + "LD    L,C         ; 4  74", 0x69));
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL          ;17  91", 0xED, 0x6C));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  HL          ;11 102", 0xE5));
    result.add(plantAssemblyInstruction(INDENT + "LD    H,E         ; 4 106 HL contains EH aka EB", 0x63));
    result.add(plantAssemblyInstruction(INDENT + "LD    L,B         ; 4 110", 0x68));
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL          ;17 127", 0xED, 0x6C));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  HL          ;11 138", 0xE5));
    result.add(plantAssemblyInstruction(INDENT + "LD    H,E         ; 4 142 HL contains EL aka EC", 0x63));
    result.add(plantAssemblyInstruction(INDENT + "LD    L,C         ; 4 146", 0x69));
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL          ;17 163", 0xED, 0x6C));
    result.add(plantAssemblyInstruction(INDENT + "POP   DE          ; 9 172 calculate RS=EL+EH0", 0xD1));
    result.add(plantAssemblyInstruction(INDENT + "LD    B,0         ; 6 178", 0x06, 0x00));
    result.add(plantAssemblyInstruction(INDENT + "LD    C,D         ; 4 182 ..C=EHhigh", 0x4A));
    result.add(plantAssemblyInstruction(INDENT + "LD    D,E         ; 4 186 ..D=EHlow", 0x53));
    result.add(plantAssemblyInstruction(INDENT + "LD    E,0         ; 6 192", 0x1E, 0x00));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,DE       ; 7 199", 0x19));
    putLabelReference("mul16321", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    NC,mul16321 ; 8 207 | 6 205 add carry to PQ", 0x30, 0x01));
    result.add(plantAssemblyInstruction(INDENT + "INC   BC          ;         4 209", 0x03));
    labels.put("mul16321", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "mul16321:"));
    result.add(plantAssemblyInstruction(INDENT + "POP   DE          ; 9 209 | 211 calculate RS=EL+EH0+DL0", 0xD1));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,D         ; 4 220 | 222 ..A=DLhigh", 0x7A));
    result.add(plantAssemblyInstruction(INDENT + "LD    D,E         ; 4 224 | 226 ..D=DLlow", 0x53));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,DE       ; 7 231 | 233", 0x19));
    putLabelReference("mul16322", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    NC,mul16322 ; 8 239 | 6 239 add carry to PQ", 0x30, 0x01));
    result.add(plantAssemblyInstruction(INDENT + "INC   BC          ;         4 243", 0x03));
    labels.put("mul16322", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "mul16322:"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;HL=RS=EL+EH0+DL0"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;C=EHhigh"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;A=DLhigh"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;E=0"));
    result.add(plantAssemblyInstruction(INDENT + "EX    DE,HL       ; 3 242 | 246", 0xEB));
    result.add(plantAssemblyInstruction(INDENT + "LD    H,L         ; 4 246 | 250 ..E was 0, so H=L=0", 0x65));
    result.add(plantAssemblyInstruction(INDENT + "LD    L,A         ; 4 250 | 254 ..HL=DLhigh", 0x6F));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,BC       ; 7 257 | 261 PQ=EHhigh+DLhigh+DH", 0x09));
    result.add(plantAssemblyInstruction(INDENT + "POP   BC          ; 9 266 | 270", 0xC1));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,BC       ; 7 273 | 277", 0x09));
    result.add(plantAssemblyInstruction(INDENT + "EX    DE,HL       ; 3 276 | 280", 0xEB));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;D=P=DHhigh"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;E=Q=DHlow+EHhigh+DLhigh"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;H=R=ELhigh+EHlow+DLlow"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "                  ;L=S=ELlow"));
    result.add(plantAssemblyInstruction(INDENT + "POP   BC          ; 9 285 | 289 restore BC", 0xC1));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF          ; 9 294 | 298 restore AF", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "RET               ; 9 303 | 307", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";mul16S"));
    result.add(new AssemblyInstruction(byteAddress, ";16 by 16 bit slow unsigned multiplication with 32 bit result."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  HL = operand 1"));
    result.add(new AssemblyInstruction(byteAddress, ";       DE = operand 2"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: DE = HL * DE high part"));
    result.add(new AssemblyInstruction(byteAddress, ";       HL = HL * DE low part"));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:none."));
    result.add(new AssemblyInstruction(byteAddress, ";  Size 26 bytes"));
    result.add(new AssemblyInstruction(byteAddress, ";  Time between 726 en 998 cycles"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("mul16S", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "mul16S:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF          ;11  11 save AF", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  BC          ;11  22 save BC", 0xC5));
    result.add(plantAssemblyInstruction(INDENT + "LD    B,H         ; 4  26", 0x44));
    result.add(plantAssemblyInstruction(INDENT + "LD    C,L         ; 4  30", 0x4D));
    result.add(plantAssemblyInstruction(INDENT + "LD    HL,0        ; 9  39", 0x21, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,16        ; 6  45", 0x3E, 0x10));
    labels.put("mul16S1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "mul16S1:"));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,HL       ;16*7=112 157", 0x29));
    result.add(plantAssemblyInstruction(INDENT + "RL    E           ;16*7=112 269", 0xCB, 0x13));
    result.add(plantAssemblyInstruction(INDENT + "RL    D           ;16*7=112 381", 0xCB, 0x12));
    putLabelReference("mul16S2", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    NC,mul16S2  ;16*8=128 509 16*6= 96 477", 0x30, 0x04));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,BC       ;             16*7=112 589", 0x09));
    putLabelReference("mul16S2", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    NC,mul16S2  ;             16*8=128 717 16*6=96 685", 0x30, 0x01));
    result.add(plantAssemblyInstruction(INDENT + "INC   DE          ;             16*4= 64 781 16*4=64 749 This instruction (with the jump) is like an \"ADC DE,0\"", 0x13));
    labels.put("mul16S2", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "mul16S2:"));
    result.add(plantAssemblyInstruction(INDENT + "DEC   A           ;16*4=64    573 | 845 | 813", 0x3D));
    putLabelReference("mul16S1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    NZ,mul16S1  ;15*8+6=126 699 | 971 | 939", 0x20, 0xF2));
    result.add(plantAssemblyInstruction(INDENT + "POP   BC          ; 9         708 | 980 | 948 restore BC", 0xC1));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF          ; 9         717 | 989 | 957 restore AF", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "RET               ; 9         726 | 998 | 966", 0xC9));
    //end of module mul.asm
    
    //start of module div.asm
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";div16"));
    result.add(new AssemblyInstruction(byteAddress, ";16 by 16 bit unsigned division."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  HL = dividend"));
    result.add(new AssemblyInstruction(byteAddress, ";       DE = divisor"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: HL = quotient"));
    result.add(new AssemblyInstruction(byteAddress, ";       DE = remainder"));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:-"));
    result.add(new AssemblyInstruction(byteAddress, ";  Size   32 bytes"));
    result.add(new AssemblyInstruction(byteAddress, ";  Time   between 1073 en 1121 cycles"));
    result.add(new AssemblyInstruction(byteAddress, ";pseudo code:"));
    result.add(new AssemblyInstruction(byteAddress, ";T = dividend"));
    result.add(new AssemblyInstruction(byteAddress, ";D = divisor"));
    result.add(new AssemblyInstruction(byteAddress, ";Q = quotient = 0"));
    result.add(new AssemblyInstruction(byteAddress, ";R = remainder = 0"));
    result.add(new AssemblyInstruction(byteAddress, ";invariante betrekking:"));
    result.add(new AssemblyInstruction(byteAddress, "; D/T\\Q     "));
    result.add(new AssemblyInstruction(byteAddress, ";   R       "));
    result.add(new AssemblyInstruction(byteAddress, "; T = QD + R"));
    result.add(new AssemblyInstruction(byteAddress, "; T <= 2^N  "));
    result.add(new AssemblyInstruction(byteAddress, ";"));
    result.add(new AssemblyInstruction(byteAddress, "; D/T'.RT\\Q'        "));
    result.add(new AssemblyInstruction(byteAddress, ";   R'              "));
    result.add(new AssemblyInstruction(byteAddress, "; RT <= 2^N         "));
    result.add(new AssemblyInstruction(byteAddress, "; 0<=k<=N           "));
    result.add(new AssemblyInstruction(byteAddress, "; RT = T % 10^k     "));
    result.add(new AssemblyInstruction(byteAddress, "; T' = (T-RT) / 10^k"));
    result.add(new AssemblyInstruction(byteAddress, "; Q' = T' / D       "));
    result.add(new AssemblyInstruction(byteAddress, "; R' = T' % D       "));
    result.add(new AssemblyInstruction(byteAddress, ";"));
    result.add(new AssemblyInstruction(byteAddress, ";for (i=16; i>0; i--) {"));
    result.add(new AssemblyInstruction(byteAddress, ";  T = T * 2 (remember MSB in carry)"));
    result.add(new AssemblyInstruction(byteAddress, ";  R = R * 2 + carry"));
    result.add(new AssemblyInstruction(byteAddress, ";  Q = Q * 2"));
    result.add(new AssemblyInstruction(byteAddress, ";  if (R >= D) {"));
    result.add(new AssemblyInstruction(byteAddress, ";    R = R - D;"));
    result.add(new AssemblyInstruction(byteAddress, ";    Q++;"));
    result.add(new AssemblyInstruction(byteAddress, ";  }"));
    result.add(new AssemblyInstruction(byteAddress, ";}"));
    result.add(new AssemblyInstruction(byteAddress, ";return Q (in HL) and R (in DE)"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("div16", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF          ;11  11 save registers used", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  BC          ;11  22", 0xC5));
    result.add(plantAssemblyInstruction(INDENT + "LD    C,L         ; 4  26 T(AC) = teller from input (HL)", 0x4D));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,H         ; 4  30 D(DE) = deler from input  (DE)", 0x7C));
    result.add(plantAssemblyInstruction(INDENT + "LD    HL,0        ; 9  39 R(HL) = restant; Q(AC) = quotient", 0x21, 0x00, 0x00));
    result.add(plantAssemblyInstruction(INDENT + "LD    B,16        ; 6  45 for (i=16; i>0; i--)", 0x06, 0x10));
    labels.put("div16_1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_1:"));
    result.add(plantAssemblyInstruction(INDENT + "SLA   C           ;16* 7=112 157   T = T * 2 (remember MSB in carry)", 0xCB, 0x21));
    result.add(plantAssemblyInstruction(INDENT + "RL    A           ;16* 7=112 269   Q = Q * 2", 0xCB, 0x17));
    result.add(plantAssemblyInstruction(INDENT + "ADC   HL,HL       ;16*10=160 429   R = R * 2 + carry", 0xED, 0x6A));
    result.add(plantAssemblyInstruction(INDENT + "OR    A           ;16* 4= 64 493   if (R >= D) {", 0xB7));
    result.add(plantAssemblyInstruction(INDENT + "SBC   HL,DE       ;16*10=160 653", 0xED, 0x52));
    putLabelReference("div16_2", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    C,div16_2   ;16* 8=128 781 16*6= 96 749   R = R - D", 0x38, 0x03));
    result.add(plantAssemblyInstruction(INDENT + "INC   C           ;              16*4= 64 813   Q++", 0x0C));
    putLabelReference("div16_3", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    div16_3     ;              16*8=128 941", 0x18, 0x01));
    labels.put("div16_2", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_2:"));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,DE       ;16* 7=112 893  (compensate comparison)", 0x19));
    labels.put("div16_3", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_3:"));
    putLabelReference("div16_1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "DJNZ  div16_1     ;15*9+7=142 1035 | 1083 }", 0x10, 0xEF));
    result.add(plantAssemblyInstruction(INDENT + "EX    DE,HL       ; 3 1038 | 1086 swap remainder (HL) into DE", 0xEB));
    result.add(plantAssemblyInstruction(INDENT + "LD    H,A         ; 4 1042 | 1090 move quotient (AC) into HL", 0x67));
    result.add(plantAssemblyInstruction(INDENT + "LD    L,C         ; 4 1046 | 1094", 0x69));
    result.add(plantAssemblyInstruction(INDENT + "POP   BC          ; 9 1055 | 1103", 0xC1));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF          ; 9 1064 | 1112", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "RET               ; 9 1073 | 1121", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";div16_8"));
    result.add(new AssemblyInstruction(byteAddress, ";16 by 8 bit unsigned division."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  HL = dividend"));
    result.add(new AssemblyInstruction(byteAddress, ";       A  = divisor"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: HL = quotient"));
    result.add(new AssemblyInstruction(byteAddress, ";       A  = remainder"));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:F(lags)"));
    result.add(new AssemblyInstruction(byteAddress, ";  Size 18 bytes"));
    result.add(new AssemblyInstruction(byteAddress, ";  Time between 601 en 697 cycles"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("div16_8", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_8:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  BC          ;11  11 save registers used", 0xC5));
    result.add(plantAssemblyInstruction(INDENT + "LD    B,16        ; 6 17 the length of the dividend (16 bits)", 0x06, 0x10));
    result.add(plantAssemblyInstruction(INDENT + "LD    C,A         ; 4 21 move divisor to C", 0x4F));
    result.add(plantAssemblyInstruction(INDENT + "XOR   A           ; 4 25 clear upper 8 bits of AHL", 0xAF));
    labels.put("div16_82", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_82:"));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,HL       ;16*7=112 137 advance dividend (HL) into selected bits (A)", 0x29));
    result.add(plantAssemblyInstruction(INDENT + "RL    A           ;16*7=112 249", 0xCB, 0x17));
    result.add(plantAssemblyInstruction(INDENT + "CP    C           ;16*4= 64 313 check if divisor (E) <= selected digits (A)", 0xB9));
    putLabelReference("div16_83", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    C,div16_83  ;16*8=128 441 16*6=96 409 if not, advance without subtraction", 0x38, 0));
    result.add(plantAssemblyInstruction(INDENT + "SUB   C           ;             16*4=64 473 subtract the divisor", 0x91));
    result.add(plantAssemblyInstruction(INDENT + "INC   L           ;             16*4=64 537 and set the next digit of the quotient", 0x2C));
    labels.put("div16_83", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_83:"));
    putLabelReference("div16_82", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "DJNZ  div16_82    ;15*9+7=142 583 679", 0x10, 0));
    result.add(plantAssemblyInstruction(INDENT + "POP   BC          ;9 592 688", 0xC1));
    result.add(plantAssemblyInstruction(INDENT + "RET               ;9 601 697", 0xC9));
    //end of module div.asm

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";read"));
    result.add(new AssemblyInstruction(byteAddress, ";read a 16 bit unsigned number from the input"));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  none"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: HL = 16 bit unsigned number"));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:-"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("read", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "read:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "LD    HL,0        ;result = 0;", 0x21, 0, 0));
    labels.put("read1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "read1:"));
    putLabelReference("getChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  getChar     ;check if a character is available.", 0xCD, 0, 0));
    putLabelReference("read1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    Z,read1     ;-no: wait for it.", 0x28, 0xFB));
    result.add(plantAssemblyInstruction(INDENT + "CP    '\\r'        ;return if char == Carriage Return", 0xFE, 0x0D));
    putLabelReference("read2", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    Z,read2", 0x28, 0x0F));
    putLabelReference("mul16_10", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  mul16_10    ;result *= 10;", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "SUB   A,'0'       ;digit = char - '0';", 0xD6, 0x30));
    result.add(plantAssemblyInstruction(INDENT + "ADD   A,L         ;result += digit;", 0x85));
    result.add(plantAssemblyInstruction(INDENT + "LD    L,A", 0x6F));
    putLabelReference("read1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    NC,read1     ;get next character", 0x30, 0xEB));
    result.add(plantAssemblyInstruction(INDENT + "INC   H", 0x24));
    putLabelReference("read1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    read1        ;get next character", 0x18, 0xE8));
    labels.put("read2", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "read2:"));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));
    
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";writeHL"));
    result.add(new AssemblyInstruction(byteAddress, ";write a 16 bit unsigned number to the output"));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  HL = 16 bit unsigned number"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none"));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:HL"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("writeHL", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "writeHL:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  BC          ;save registers used", 0xC5));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "LD    B,0         ;number of digits on stack", 0x06, 0x00));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,H         ;is HL=0?", 0x7C));
    result.add(plantAssemblyInstruction(INDENT + "OR    L", 0xB5));
    putLabelReference("writeHL1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    NZ,writeHL1", 0x20, 0x03));
    result.add(plantAssemblyInstruction(INDENT + "INC   B           ;write a single digit 0", 0x04));
    putLabelReference("writeHL3", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    writeHL3", 0x18, 0x0C));
    labels.put("writeHL1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "writeHL1:"));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,10        ;divide HL by 10", 0x3E, 0x0A));
    putLabelReference("div16_8", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  div16_8", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF          ;put remainder on stack", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "INC   B", 0x04));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,H         ;is quotient 0?", 0x7C));
    result.add(plantAssemblyInstruction(INDENT + "OR    L", 0xB5));
    putLabelReference("writeHL1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    NZ,writeHL1", 0x20, 0xF5));
    labels.put("writeHL2", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "writeHL2:"));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF          ;write digit", 0xF1));
    labels.put("writeHL3", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "writeHL3:"));
    result.add(plantAssemblyInstruction(INDENT + "ADD   A,'0'", 0xC6, 0x30));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0, 0));
    putLabelReference("writeHL2", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "DJNZ  writeHL2", 0x10, 0xF8));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF          ;restore registers used", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "POP   BC", 0xC1));
    putLabelReference("putCRLF", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putCRLF", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));
    
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";writeA"));
    result.add(new AssemblyInstruction(byteAddress, ";write an 8-bit unsigned number to the output"));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  A = 8-bit unsigned number"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none"));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:none"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("writeA", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "writeA:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  HL          ;save registers used", 0xE5));
    result.add(plantAssemblyInstruction(INDENT + "LD    H,0", 0x26, 0x00));
    result.add(plantAssemblyInstruction(INDENT + "LD    L,A", 0x6F));
    putLabelReference("writeHL", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  writeHL", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "POP   HL", 0xE1));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));

    return result;
  }
}