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
  private static final int MAX_ASM_CODE = 0x2000; /* max Z80 assembler lines of code */
  private static final int MEM_START = 0x4000;    /* lowest address for global variables */
  private static final int MIN_BIN = 0x2000; /* Z80 assembled bytes start at 2000 */
  private static final int MAX_BIN = 0x4000; /* max Z80 assembled bytes */
  private static final String INDENT = "        ";
  private static final Set<Byte> JUMP_INSTRUCTIONS = new HashSet<Byte>(18) {{
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

  /* global variables */
  private boolean debug = false;
  private boolean generateBinary = false;
  private long byteAddress = MIN_BIN;
  public Map<String, Long> labels = new HashMap<String, Long>();
  public Map<String, ArrayList<Long>> labelReferences = new HashMap<String, ArrayList<Long>>();
  
  /* constructor */
  public Transcoder(boolean binary) {
    generateBinary = binary;
  }

  private void debug(String message) {
    if (debug) {
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

      //add line nr as a label and original source code as assembler comment
      String prefix = label + ":;";
      if (instruction.linesOfCode != null) {
        for (String sourceCode : instruction.linesOfCode) {
          z80Instructions.add(new AssemblyInstruction(byteAddress, prefix + sourceCode));
          prefix = "     ;";
        }
      }
      
      //add original M-code instruction as assembler comment
      if (debug) {
        z80Instructions.add(new AssemblyInstruction(byteAddress, ";" + instruction.toString()));
      }

      z80Instructions.addAll(transcode(instruction));

      if (z80Instructions.size() > MAX_ASM_CODE) {
        throw new RuntimeException("code overflow while generating Z80 assembler code");
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
    
    //check instruction is jump or call
    if (instruction.getBytes().size() != 3 && !JUMP_INSTRUCTIONS.contains(instruction.getBytes().get(0))) {
      throw new RuntimeException(String.format("illegal reference to label %s from address %04X (index %d) by instruction %s"
        , key, reference, index, instruction.getCode()));
    }
    
    //update address part of the instruction
    instruction.getBytes().set((int)(reference - instruction.getAddress() + 1), (byte)(address % 256));
    instruction.getBytes().set((int)(reference - instruction.getAddress() + 2), (byte)((address / 256) % 256));
  }
  
  /* transcode a single M-code instruction to one or more Z80S180 assembler instruction */
  private ArrayList<AssemblyInstruction> transcode(Instruction instruction){
    ArrayList<AssemblyInstruction> result = new ArrayList<AssemblyInstruction>();

    debug("\ntranscoding to Z80: " + instruction.toString());
    
    FunctionType function = instruction.function;
    OperandType opType = instruction.opType;
    CallType callValue = instruction.callValue;
    int word = instruction.word;
    int memAddress = MEM_START + word * 2;
    AssemblyInstruction asm = null;
    debug("\n..function:" + function);

    String asmCode = null;
    if (function == FunctionType.stop) {
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP   0x0171", 0xC3, 0x71, 0x01);
      debug("\n.." + asm.getCode());
    } else if (function == FunctionType.call) {
      if (callValue == CallType.read) {
        asm = new AssemblyInstruction(byteAddress, INDENT + "CALL read", 0xCD, 0x03, 0x00);
      } else if (callValue == CallType.write) {
        putLabelReference("write", byteAddress);
        asm = new AssemblyInstruction(byteAddress, INDENT + "CALL write", 0xCD, 0, 0);
      } else {
        putLabelReference(word, byteAddress);
        asm = new AssemblyInstruction(byteAddress, String.format(INDENT + "CALL 0x%04X", word), 0xCD, word % 256, word / 256);
        throw new RuntimeException("untested CALL nnnn");
      }
    } else if (function == FunctionType.accStore) {
      switch(opType) {
        case var: 
          asmCode = String.format(INDENT + "LD   (0x%04X),HL", memAddress);
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x22, memAddress % 256, memAddress / 256);
          break;
        case stack:
          asm = new AssemblyInstruction(byteAddress, INDENT + "PUSH HL", 0xE5);
          break;
      }
    } else if (function == FunctionType.accLoad || function == FunctionType.stackAccLoad) {
      if (function == FunctionType.stackAccLoad) {
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "PUSH HL", 0xE5));
      }
      if (opType == OperandType.stack && function == FunctionType.stackAccLoad) {
        throw new RuntimeException("illegal M-code instruction: stackAccLoad unstack");
      }
      asm = operandToHL(instruction);
    } else if (function == FunctionType.accPlus) {
      asm = operandToDE(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();

      asmCode = INDENT + "ADD  HL,DE";
      asm = new AssemblyInstruction(byteAddress, asmCode, 0x19);
    } else if ((function == FunctionType.accMinus) || (function == FunctionType.minusAcc) || (function == FunctionType.accCompare)) {
      asm = operandToDE(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();
      
      if (function == FunctionType.minusAcc) {
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "EX   DE,HL", 0xEB));
      }

      result.add(new AssemblyInstruction(byteAddress++, INDENT + "OR   A", 0xB7));
      asm = new AssemblyInstruction(byteAddress, INDENT + "SBC  HL,DE", 0xED, 0x52);
    } else if (function == FunctionType.accTimes) {
      asm = operandToDE(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();
      putLabelReference("mul16", byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "CALL mul16", 0xCD, 0x00, 0x00);
    } else if ((function == FunctionType.accDiv) || (function == FunctionType.divAcc)) {
      asm = operandToDE(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();

      if (function == FunctionType.divAcc) {
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "EX   DE,HL", 0xEB));
      }
      putLabelReference("div16", byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "CALL div16", 0xCD, 0x00, 0x00);
    } else if (function == FunctionType.br) {
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP   L" + word, 0xC3, word % 256, word / 256);
    } else if (function == FunctionType.brEq) {
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP   Z,L" + word, 0xCA, word % 256, word / 256);
    } else if (function == FunctionType.brNe) {
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP   NZ,L" + word, 0xC2, word % 256, word / 256);
    } else if (function == FunctionType.brLt) {
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP   C,L" + word, 0xDA, word % 256, word / 256);
    } else if (function == FunctionType.brLe) {
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP   Z,L" + word, 0xCA, word % 256, word / 256);
    } else if (function == FunctionType.brGt) {
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP   Z,$+5", 0x28, 3);
      result.add(asm);
      byteAddress += asm.getBytes().size();
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP   C,L" + word, 0xDA, word % 256, word / 256);
    } else if (function == FunctionType.brGe) {
      putLabelReference(word, byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP   NC,L" + word, 0xD2, word % 256, word / 256);
    }

    /* add assembly code to output and update byte address */
    result.add(asm);
    if (asm == null) {
      throw new RuntimeException("asm is null transcoding instruction " + instruction.toString());
    }
    if (asm.getBytes() != null) {
      byteAddress += asm.getBytes().size();
    }

    return result;
  }
  
  private AssemblyInstruction operandToHL(Instruction instruction) {
    String asmCode = null;
    AssemblyInstruction asm = null;
    switch(instruction.opType) {
      case var: 
        int memAddress = MEM_START + instruction.word * 2;
        asmCode = String.format(INDENT + "LD   HL,(0x%04X)", memAddress);
        asm = new AssemblyInstruction(byteAddress, asmCode, 0x2A, memAddress % 256, memAddress / 256);
        break;
      case constant: 
        asmCode = INDENT + "LD   HL," + instruction.word;
        asm = new AssemblyInstruction(byteAddress, asmCode, 0x21, instruction.word % 256, instruction.word / 256);
        break;
      case stack:
        asmCode = INDENT + "POP  HL";
        asm = new AssemblyInstruction(byteAddress, asmCode, 0xE1);
        break;
    };
    return asm;
  }

  private AssemblyInstruction operandToDE(Instruction instruction) {
    String asmCode = null;
    AssemblyInstruction asm = null;
    switch(instruction.opType) {
      case var: 
        int memAddress = MEM_START + instruction.word * 2;
        asmCode = String.format(INDENT + "LD   DE,(0x%04X)", memAddress);
        asm = new AssemblyInstruction(byteAddress, asmCode, 0xED, 0x5B, memAddress % 256, memAddress / 256);
        break;
      case constant: 
        asmCode = INDENT + "LD   DE," + instruction.word;
        asm = new AssemblyInstruction(byteAddress, asmCode, 0x11, instruction.word % 256, instruction.word / 256);
        break;
      case stack:
        asmCode = INDENT + "POP  DE";
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
    result.add(new AssemblyInstruction(byteAddress, "start:"));
    putLabelReference("main", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JP   main", 0xC3, 0, 0));
    
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";write"));
    result.add(new AssemblyInstruction(byteAddress, ";write a 16 bit unsigned number to the output"));
    result.add(new AssemblyInstruction(byteAddress, ";Input: TOS   = return address"));
    result.add(new AssemblyInstruction(byteAddress, ";       TOS+2 = 16 bit unsigned number"));
    result.add(new AssemblyInstruction(byteAddress, ";Output:none"));
    result.add(new AssemblyInstruction(byteAddress, ";Uses:  HL, AF"));
    result.add(new AssemblyInstruction(byteAddress, ";voorlopige code: schrijft getal als 4 hex digits."));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("write", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "write:"));
    result.add(plantAssemblyInstruction(INDENT + "POP  HL", 0xE1));     //return address into HL
    result.add(plantAssemblyInstruction(INDENT + "EX   (SP),HL", 0xE3));//uint in HL; return address on stack
    putLabelReference("putHexHL", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL putHexHL", 0xCD, 0, 0));
    putLabelReference("putCRLF", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putCRLF", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putHexHL"));
    result.add(new AssemblyInstruction(byteAddress, ";Print HL register pair as 4 hex digits"));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  HL = word to be printed."));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:AF"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putHexHL", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putHexHL:"));
    result.add(plantAssemblyInstruction(INDENT + "LD   A,H", 0x7C));
    putLabelReference("putHexA", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL putHexA", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "LD   A,L", 0x7D));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";fall through to routine putHexA"));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putHexA"));
    result.add(new AssemblyInstruction(byteAddress, ";Print A register as 2 hex digits"));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  A = byte to be printed"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:none."));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putHexA", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putHexA:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "RRA", 0x1F));
    result.add(plantAssemblyInstruction(INDENT + "RRA", 0x1F));
    result.add(plantAssemblyInstruction(INDENT + "RRA", 0x1F));
    result.add(plantAssemblyInstruction(INDENT + "RRA", 0x1F));
    putLabelReference("putHexA1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putHexA1", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));
    labels.put("putHexA1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putHexA1:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "AND   A,0x0F", 0xE6, 0x0F));
    result.add(plantAssemblyInstruction(INDENT + "ADD   A,'0'", 0xC6, 0x30));
    result.add(plantAssemblyInstruction(INDENT + "CP    A,'9'+1", 0xFE, 0x3A));
    result.add(plantAssemblyInstruction(INDENT + "JR    C,$+4", 0x38, 0x02));
    result.add(plantAssemblyInstruction(INDENT + "ADD   A,07", 0xC6, 0x07));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));
    
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putMsg"));
    result.add(new AssemblyInstruction(byteAddress, ";Print a string, following the return address and zero terminated, via ASCI0."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  none."));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:none."));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putMsg", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putMsg:"));
    result.add(plantAssemblyInstruction(INDENT + "EX      (SP),HL     ;save HL and load return address into HL.", 0xE3));
    putLabelReference("putStr", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL    putStr", 0xCD, 0x1B, 0x21));
    result.add(plantAssemblyInstruction(INDENT + "EX      (SP),HL     ;put return address onto stack and restore HL.", 0xE3));
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
    result.add(plantAssemblyInstruction(INDENT + "LD    A,'\r'", 0x3E, 0x0D));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,'\n'", 0x3E, 0x0A));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putStr"));
    result.add(new AssemblyInstruction(byteAddress, ";Print a string, pointed to by HL and zero terminated, via ASCI0."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  HL:address of zero terminated string to be printed."));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:HL:points to byte after zero terminated string."));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putStr", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putStr:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF            ;save registers", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "JR    $+5", 0x18, 0x03));
    labels.put("putStr0", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putStr0:"));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0x2A, 0x21));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,(HL)        ;get next character", 0x7E));
    result.add(plantAssemblyInstruction(INDENT + "INC   HL", 0x23));
    result.add(plantAssemblyInstruction(INDENT + "OR    A,A           ;is it zer0?", 0xB7));
    result.add(plantAssemblyInstruction(INDENT + "JR    NZ,putStr0    ;no ->put it to ASCI0", 0x20, 0xF8));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF            ;yes->return", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));
    
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putChar"));
    result.add(new AssemblyInstruction(byteAddress, ";Send one character to ASCI0."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  A = character"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:AF"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putChar", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putChar:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF                ;save the character to be send", 0xF5));
    labels.put("putChar1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putChar1:"));
    result.add(plantAssemblyInstruction(INDENT + "IN0   A,(STAT0)         ;read ASCI0 status register", 0xED, 0x38, 0x04));
    result.add(plantAssemblyInstruction(INDENT + "BIT   TDRE,A            ;wait until TDRE <> 0", 0xCB, 0x4F));
    result.add(plantAssemblyInstruction(INDENT + "JR    Z,putChar1", 0x28, 0xF9));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF                ;restore character to be send", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "OUT0  (TDR0),A          ;write character to ASCI0", 0xED, 0x39, 0x06));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";mul16"));
    result.add(new AssemblyInstruction(byteAddress, ";16 bit unsigned multiplication"));
    result.add(new AssemblyInstruction(byteAddress, ";Input: HL"));
    result.add(new AssemblyInstruction(byteAddress, ";       DE"));
    result.add(new AssemblyInstruction(byteAddress, ";Output HL = HL * DE low part"));
    result.add(new AssemblyInstruction(byteAddress, ";       DE = HL * DE high part"));
    result.add(new AssemblyInstruction(byteAddress, ";Uses   -"));
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
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";    DH  0  0"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + "; -----------+"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";  P  Q  R  S"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";S = ELlow"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";R = ELhigh+EHlow+DLlow"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";Q = DHlow+EHhigh+DLhigh"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";P = DHhigh"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH    BC      ;save BC", 0xC5));
    result.add(plantAssemblyInstruction(INDENT + "LD      B,H", 0x44));
    result.add(plantAssemblyInstruction(INDENT + "LD      C,L", 0x4D));
    result.add(plantAssemblyInstruction(INDENT + "LD      H,D     ;DH aka DB", 0x62));
    result.add(plantAssemblyInstruction(INDENT + "LD      L,B", 0x68));
    result.add(plantAssemblyInstruction(INDENT + "MLT     HL", 0xED,0x6C));
    result.add(plantAssemblyInstruction(INDENT + "PUSH    HL", 0xE5));
    result.add(plantAssemblyInstruction(INDENT + "LD      H,D     ;DL aka DC", 0x62));
    result.add(plantAssemblyInstruction(INDENT + "LD      L,C", 0x69));
    result.add(plantAssemblyInstruction(INDENT + "MLT     HL", 0xED, 0x6C));
    result.add(plantAssemblyInstruction(INDENT + "PUSH    HL", 0xE5));
    result.add(plantAssemblyInstruction(INDENT + "LD      H,E     ;EH aka EB", 0x63));
    result.add(plantAssemblyInstruction(INDENT + "LD      L,B", 0x68));
    result.add(plantAssemblyInstruction(INDENT + "MLT     HL", 0xED, 0x6C));
    result.add(plantAssemblyInstruction(INDENT + "PUSH    HL", 0xE5));
    result.add(plantAssemblyInstruction(INDENT + "LD      H,E     ;EL aka EC", 0x63));
    result.add(plantAssemblyInstruction(INDENT + "LD      L,C", 0x69));
    result.add(plantAssemblyInstruction(INDENT + "MLT     HL", 0xED, 0x6C));
    result.add(plantAssemblyInstruction(INDENT + "POP     DE      ;RS=EL+EH0", 0xD1));
    result.add(plantAssemblyInstruction(INDENT + "LD      B,0", 0x06, 0x00));
    result.add(plantAssemblyInstruction(INDENT + "LD      C,D     ;..C=EHhigh", 0x4A));
    result.add(plantAssemblyInstruction(INDENT + "LD      D,E     ;..D=EHlow", 0x53));
    result.add(plantAssemblyInstruction(INDENT + "LD      E,0", 0x1E, 0x00));
    result.add(plantAssemblyInstruction(INDENT + "ADD     HL,DE", 0x19));
    result.add(plantAssemblyInstruction(INDENT + "JR      NC,$+3  ;add carry to PQ", 0x30, 0x01));
    result.add(plantAssemblyInstruction(INDENT + "INC     BC", 0x03));
    result.add(plantAssemblyInstruction(INDENT + "POP     DE      ;RS=EL+EH0+DL0", 0xD1));
    result.add(plantAssemblyInstruction(INDENT + "LD      A,D     ;..A=DLhigh", 0x7A));
    result.add(plantAssemblyInstruction(INDENT + "LD      D,E     ;..D=DLlow", 0x53));
    result.add(plantAssemblyInstruction(INDENT + "ADD     HL,DE", 0x19));
    result.add(plantAssemblyInstruction(INDENT + "JR      NC,$+3  ;add carry to PQ", 0x30, 0x01));
    result.add(plantAssemblyInstruction(INDENT + "INC     BC", 0x03));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";HL=RS=EL+EH0+DL0"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";C=EHhigh"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";A=DLhigh"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";E=0"));
    result.add(plantAssemblyInstruction(INDENT + "EX      DE,HL", 0xEB));
    result.add(plantAssemblyInstruction(INDENT + "LD      H,L     ;..E was 0, so H=L=0", 0x65));
    result.add(plantAssemblyInstruction(INDENT + "LD      L,A     ;..HL=DLhigh", 0x6F));
    result.add(plantAssemblyInstruction(INDENT + "ADD     HL,BC   ;PQ=EHhigh+DLhigh+DH", 0x09));
    result.add(plantAssemblyInstruction(INDENT + "POP     BC", 0xC1));
    result.add(plantAssemblyInstruction(INDENT + "ADD     HL,BC", 0x09));
    result.add(plantAssemblyInstruction(INDENT + "EX      DE,HL", 0xEB));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";D=P=DHhigh"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";E=Q=DHlow+EHhigh+DLhigh"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";H=R=ELhigh+EHlow+DLlow"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";L=S=ELlow"));
    result.add(plantAssemblyInstruction(INDENT + "POP     BC      ;restore BC", 0xC1));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));
    /* the following code (which doesn't use the MLT instruction) takes appr. 980 cycles i.s.o. appr. 280 cycles
     * C5                    PUSH    BC
     * 44                    LD      B,H
     * 4D                    LD      C,L
     * 21 00 00              LD      HL,0
     * 3E 10                 LD      A,16
     *             mul16_1:
     * 29                    ADD     HL,HL
     * CB 13                 RL      E
     * CB 12                 RL      D
     * 30 04                 JR      NC,mul16_2
     * 09                    ADD     HL,BC
     * 30 01                 JR      NC, mul16_2
     * 13                    INC     DE
     *             mul16_2:
     * 3D                    DEC     A
     * 20 F2                 JR      NZ, mul16_1
     * C1                    POP     BC
     * C9                    RET
     */

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";div16"));
    result.add(new AssemblyInstruction(byteAddress, ";16 bit unsigned division"));
    result.add(new AssemblyInstruction(byteAddress, ";Input: HL = dividend"));
    result.add(new AssemblyInstruction(byteAddress, ";       DE = divisor"));
    result.add(new AssemblyInstruction(byteAddress, ";Output HL = quotient"));
    result.add(new AssemblyInstruction(byteAddress, ";       DE = remainder"));
    result.add(new AssemblyInstruction(byteAddress, ";Uses   -"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
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
    result.add(new AssemblyInstruction(byteAddress, ";for (i=8; i>0; i--) {"));
    result.add(new AssemblyInstruction(byteAddress, ";  T = T * 2 (remember MSB in carry)"));
    result.add(new AssemblyInstruction(byteAddress, ";  R = R * 2 + carry"));
    result.add(new AssemblyInstruction(byteAddress, ";  Q = Q * 2"));
    result.add(new AssemblyInstruction(byteAddress, ";  if (R >= D) {"));
    result.add(new AssemblyInstruction(byteAddress, ";    R = R - D;"));
    result.add(new AssemblyInstruction(byteAddress, ";    Q++;"));
    result.add(new AssemblyInstruction(byteAddress, ";  }"));
    result.add(new AssemblyInstruction(byteAddress, ";}"));
    result.add(new AssemblyInstruction(byteAddress, ";return Q,R (in HL,DE)"));
    labels.put("div16", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH    AF", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "LD      A,D", 0x7A));
    result.add(plantAssemblyInstruction(INDENT + "OR      E", 0xB3));
    result.add(plantAssemblyInstruction(INDENT + "JR      NZ,div16_1", 0x20, 0x22));
    result.add(plantAssemblyInstruction(INDENT + "POP     AF", 0xF1));
    putLabelReference("putMsg", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL    putMsg", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + ".ASCIZ  \"\b\r\nDivide by zero error.\r\n\"", 0x08, 0x0D, 0x0A, 0x44, 0x69, 0x76, 0x69, 0x64, 0x65, 0x20, 0x62, 0x79, 0x20, 0x7A, 0x65, 0x72, 0x6F, 0x20, 0x65, 0x72, 0x72, 0x6F, 0x72, 0x2E, 0x0D, 0x0A, 0x00));
    result.add(plantAssemblyInstruction(INDENT + "JP      0", 0xC3, 0x00, 0x00));
    labels.put("div16_1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_1:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH    BC", 0xC5));
    result.add(plantAssemblyInstruction(INDENT + "PUSH    IY", 0xFD, 0xE5));
    result.add(plantAssemblyInstruction(INDENT + "LD      C,L     ;T(AC) = teller from input (HL)", 0x4D));
    result.add(plantAssemblyInstruction(INDENT + "LD      A,H     ;D(DE) = deler from input  (DE)", 0x7C));
    result.add(plantAssemblyInstruction(INDENT + "LD      IY,0    ;Q(IY) = quotient", 0xFD, 0x21, 0x00, 0x00));
    result.add(plantAssemblyInstruction(INDENT + "LD      HL,0    ;R(HL) = restant", 0x21, 0x00, 0x00));
    result.add(plantAssemblyInstruction(INDENT + "LD      B,16    ;for (i=8; i>0; i--)", 0x06, 0x10));
    labels.put("div16_2", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_2:"));
    result.add(plantAssemblyInstruction(INDENT + "SLA     C       ;  T = T * 2 (remember MSB in carry)", 0xCB, 0x21));
    result.add(plantAssemblyInstruction(INDENT + "RL      A", 0xCB, 0x17));
    result.add(plantAssemblyInstruction(INDENT + "RL      L       ;  R = R * 2 + carry", 0xCB, 0x15));
    result.add(plantAssemblyInstruction(INDENT + "RL      H", 0xCB, 0x14));
    result.add(plantAssemblyInstruction(INDENT + "ADD     IY,IY   ;  Q = Q * 2", 0xFD, 0x29));
    result.add(plantAssemblyInstruction(INDENT + "OR      A       ;  if (R >= D) {", 0xB7));
    result.add(plantAssemblyInstruction(INDENT + "SBC     HL,DE", 0xED, 0x52));
    result.add(plantAssemblyInstruction(INDENT + "JR      C,div16_3 ;    R = R - D", 0x38, 0x06));
    result.add(plantAssemblyInstruction(INDENT + "INC     IY      ;    Q++", 0xFD, 0x23));
    result.add(plantAssemblyInstruction(INDENT + "DJNZ    div16_2 ;  }", 0x10, 0xED));
    result.add(plantAssemblyInstruction(INDENT + "JR      div16_4", 0x18, 0x03));
    labels.put("div16_3", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_3:"));
    result.add(plantAssemblyInstruction(INDENT + "ADD     HL,DE   ;compensate comparison", 0x19));
    result.add(plantAssemblyInstruction(INDENT + "DJNZ    div16_2 ;}", 0x10, 0xE8));
    labels.put("div16_4", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_4:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH    IY      ;copy IY (quotient) into DE", 0xFD, 0xE5));
    result.add(plantAssemblyInstruction(INDENT + "POP     DE", 0xD1));
    result.add(plantAssemblyInstruction(INDENT + "EX      DE,HL   ;swap DE and HL; HL = quotient; DE = rest", 0xEB));
    result.add(plantAssemblyInstruction(INDENT + "POP     IY", 0xFD, 0xE1));
    result.add(plantAssemblyInstruction(INDENT + "POP     BC", 0xC1));
    result.add(plantAssemblyInstruction(INDENT + "POP     AF", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));
     /*
    // teller in HL; deler in DE -> quotient in HL; restant in DE
    asmCode = "LD   A,D"; // als DE=0, error div by zero
    asmCode = "OR   E";
    asmCode = "JR   Z,ERROR";
    asmCode = "LD   B,H"; // kopie teller in BC
    asmCode = "LD   C,L";
    asmCode = "LD   HL,0"; // result = 0
    asmCode = "LD   A,B"; // deler High
    asmCode = "LD   B,16D";
    asmCode = "TRIALSB:";
    asmCode = "RL   C"; // roteer links result + ACC
    asmCode = "RLA";
    asmCode = "ADC  HL,HL"; // schuif links; carry wordt niet beïnvloed
    asmCode = "SBC  HL,DE"; // teller eraftrekken
    asmCode = "NULL:";
    asmCode = "CCF"; // result bit
    asmCode = "JR   NC,NGV"; // Acc negatief?
    asmCode = "PTV:";
    asmCode = "DJNZ TRIALSB";
    asmCode = "JP   DONE";
    asmCode = "RESTOR:";
    asmCode = "RL   C"; // roteer links result + acc
    asmCode = "RLA";
    asmCode = "ADC  HL,HL"; // schuif links; carry wordt niet beïnvloed
    asmCode = "AND  A"; // carry op nul zetten
    asmCode = "ADC  HL,DE"; // herstel door deler erbij te tellen
    asmCode = "JR   C,PTV"; // resultaat positief
    asmCode = "JR   Z,NULL"; // resultaat nul
    asmCode = "NGV:";
    asmCode = "DJNZ RESTOR";
    asmCode = "DONE:";
    asmCode = "RL   C"; // resultaat bit inschuiven
    asmCode = "RLA";
    asmCode = "LD   B,A"; // quotient in BC
    asmCode = "LD   A,H"; // restant High negatief?
    asmCode = "OR   A";
    asmCode = "JP   P,PREM";
    asmCode = "ADD  HL,DE"; // corrigeer negatief restant
    asmCode = "PREM:";
    asmCode = "RET";
    //
    //This divides DE by BC, storing the result in DE, remainder in HL
    //
    //DE_Div_BC:         ;1281-2x, x is at most 16
    //     ld a,16       ;7
    //     ld hl,0       ;10
    //     jp $+5        ;10
    //DivLoop:
    //     add hl,bc     ;--
    //     dec a         ;64
    //     ret z         ;86
    //     sla e         ;128
    //     rl d          ;128
    //     adc hl,hl     ;240
    //     sbc hl,bc     ;240
    //     jr nc,DivLoop ;23|21
    //     inc e         ;--
    //     jp DivLoop+1
    //
    */
    return result;
  }
}