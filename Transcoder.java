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
      String prefix = String.format("%-8s;", label + ":");
      if (instruction.linesOfCode != null) {
        for (String sourceCode : instruction.linesOfCode) {
          z80Instructions.add(new AssemblyInstruction(byteAddress, prefix + sourceCode));
          prefix = String.format("%-8s;", " ");
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
      asm = new AssemblyInstruction(byteAddress, INDENT + "JP    0x0171      ;Jump to Zilog Z80183 Monitor.", 0xC3, 0x71, 0x01);
      debug("\n.." + asm.getCode());
    } else if (function == FunctionType.call) {
      if (callValue == CallType.read) {
        asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  read", 0xCD, 0x03, 0x00);
      } else if (callValue == CallType.write) {
        putLabelReference("write", byteAddress);
        asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  write", 0xCD, 0, 0);
      } else {
        putLabelReference(word, byteAddress);
        asm = new AssemblyInstruction(byteAddress, String.format(INDENT + "CALL  0x%04X", word), 0xCD, word % 256, word / 256);
        throw new RuntimeException("untested CALL  nnnn");
      }
    } else if (function == FunctionType.accStore) {
      switch(opType) {
        case var: 
          asmCode = String.format(INDENT + "LD    (0x%04X),HL", memAddress);
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x22, memAddress % 256, memAddress / 256);
          break;
        case stack:
          asm = new AssemblyInstruction(byteAddress, INDENT + "PUSH  HL", 0xE5);
          break;
      }
    } else if (function == FunctionType.accLoad || function == FunctionType.stackAccLoad) {
      if (function == FunctionType.stackAccLoad) {
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "PUSH  HL", 0xE5));
      }
      if (opType == OperandType.stack && function == FunctionType.stackAccLoad) {
        throw new RuntimeException("illegal M-code instruction: stackAccLoad unstack");
      }
      asm = operandToHL(instruction);
    } else if (function == FunctionType.accPlus) {
      asm = operandToDE(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();

      asmCode = INDENT + "ADD   HL,DE";
      asm = new AssemblyInstruction(byteAddress, asmCode, 0x19);
    } else if ((function == FunctionType.accMinus) || (function == FunctionType.minusAcc) || (function == FunctionType.accCompare)) {
      asm = operandToDE(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();
      
      if (function == FunctionType.minusAcc) {
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "EX    DE,HL", 0xEB));
      }

      result.add(new AssemblyInstruction(byteAddress++, INDENT + "OR    A", 0xB7));
      asm = new AssemblyInstruction(byteAddress, INDENT + "SBC   HL,DE", 0xED, 0x52);
    } else if (function == FunctionType.accTimes) {
      asm = operandToDE(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();
      putLabelReference("mul16", byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  mul16", 0xCD, 0x00, 0x00);
    } else if ((function == FunctionType.accDiv) || (function == FunctionType.divAcc)) {
      asm = operandToDE(instruction);
      result.add(asm);
      byteAddress += asm.getBytes().size();

      if (function == FunctionType.divAcc) {
        result.add(new AssemblyInstruction(byteAddress++, INDENT + "EX    DE,HL", 0xEB));
      }
      putLabelReference("div16", byteAddress);
      asm = new AssemblyInstruction(byteAddress, INDENT + "CALL  div16", 0xCD, 0x00, 0x00);
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
        asmCode = String.format(INDENT + "LD    HL,(0x%04X)", memAddress);
        asm = new AssemblyInstruction(byteAddress, asmCode, 0x2A, memAddress % 256, memAddress / 256);
        break;
      case constant: 
        asmCode = INDENT + "LD    HL," + instruction.word;
        asm = new AssemblyInstruction(byteAddress, asmCode, 0x21, instruction.word % 256, instruction.word / 256);
        break;
      case stack:
        asmCode = INDENT + "POP   HL";
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
        asmCode = String.format(INDENT + "LD    DE,(0x%04X)", memAddress);
        asm = new AssemblyInstruction(byteAddress, asmCode, 0xED, 0x5B, memAddress % 256, memAddress / 256);
        break;
      case constant: 
        asmCode = INDENT + "LD    DE," + instruction.word;
        asm = new AssemblyInstruction(byteAddress, asmCode, 0x11, instruction.word % 256, instruction.word / 256);
        break;
      case stack:
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
    result.add(new AssemblyInstruction(byteAddress, "start:"));
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
    putLabelReference("WAIT1M", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  WAIT1M", 0xCD, 0, 0));    //Wait 1 msec
    result.add(plantAssemblyInstruction(INDENT + "DEC   DE", 0x1B));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,D", 0x7A));
    result.add(plantAssemblyInstruction(INDENT + "OR    A,E", 0xB3));
    result.add(plantAssemblyInstruction(INDENT + "JR    NZ,$-6", 0x20, 0xF8));
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
    result.add(plantAssemblyInstruction(INDENT + "PUSH  HL", 0xE5));                    //11 (11)
                                                                                        //       3 opcode
                                                                                        //       3 mem write
                                                                                        //       1 inc SP
                                                                                        //       3 mem write
                                                                                        //       1 inc SP
    result.add(plantAssemblyInstruction(INDENT + "PUSH    AF", 0xF5));                  //11 (22)
                                                                                        //       3 opcode
                                                                                        //       3 mem write
                                                                                        //       1 inc SP
                                                                                        //       3 mem write
                                                                                        //       1 inc SP
    result.add(plantAssemblyInstruction(INDENT + "LD      HL, 834", 0x21, 0x42, 0x03)); //3      9 (31)
                                                                                        //       3 opcode
                                                                                        //       3 mem read
                                                                                        //       3 mem read
    result.add(plantAssemblyInstruction(INDENT + "DEC     HL", 0x2B));                  //2      4 (31+n*4)
                                                                                        //       3 opcode
                                                                                        //       1 execute
    result.add(plantAssemblyInstruction(INDENT + "LD	A,H", 0x7C));                     //2      6 (31+n*10)
                                                                                        //       3 opcode
                                                                                        //       3 execute
    result.add(plantAssemblyInstruction(INDENT + "OR	A,L", 0xB5));                     //2      4 (31+n*14)
                                                                                        //       3 opcode
                                                                                        //       1 execute
    result.add(plantAssemblyInstruction(INDENT + "JR	NZ,WAIT1M2", 0x20, 0xFB));        //4      8 (31+n*22) if NZ
                                                                                        //       3 opcode
                                                                                        //       3 mem read 
                                                                                        //       1 execute
                                                                                        //       1 execute
                                                                                        //2      6 (29+n*22) if not NZ
                                                                                        //       3 opcode
                                                                                        //       3 mem read
    result.add(plantAssemblyInstruction(INDENT + "POP	AF", 0xF1));                      //3      9 (38+n*22)
                                                                                        //       3 opcode
                                                                                        //       3 mem read
                                                                                        //       3 mem read
    result.add(plantAssemblyInstruction(INDENT + "POP	HL", 0xE1));                      //3      9 (47+n*22)
                                                                                        //       3 opcode   
                                                                                        //       3 mem read
                                                                                        //       3 mem read
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));                         //3      9 (56+n*22)
                                                                                        //       3 opcode
                                                                                        //       3 mem read
                                                                                        //       3 mem read
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
    result.add(plantAssemblyInstruction(INDENT + "IN0   A,(STAT0)", 0xED, 0x38, 0x04));   //read ASCI0 status
    result.add(plantAssemblyInstruction(INDENT + "BIT   OVERRUN,A", 0xCB, 0x77));         //check if ASCIO OVERRUN bit is set
    //end of module chario.asm
    result.add(plantAssemblyInstruction(INDENT + "JR    NZ,$+9", 0x20, 0x07));            //-yes: reset error flags
    result.add(plantAssemblyInstruction(INDENT + "BIT   RDRF,A", 0xCB, 0x7F));            //check if ASCIO RDRF bit is set
    result.add(plantAssemblyInstruction(INDENT + "RET   Z", 0xC8));                       //-no: return without a character
    result.add(plantAssemblyInstruction(INDENT + "IN0   A,(RDR0)", 0xED, 0x38, 0x08));    //-yes:read ASCIO Rx data register
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));
    result.add(plantAssemblyInstruction(INDENT + "IN0   A,(CNTLA0)", 0xED, 0x38, 0x00));  //read ASCI0 control register
    result.add(plantAssemblyInstruction(INDENT + "RES   ERROR,A", 0xCB, 0x9F));           //reset OVRN,FE,PE,BRK flags
    result.add(plantAssemblyInstruction(INDENT + "OUT0  (CNTLA0),A", 0xED, 0x39, 0x00));  //write back to ASCI0 CTRL
    result.add(plantAssemblyInstruction(INDENT + "XOR   A", 0xAF));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));    //return without a character

    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putMsg"));
    result.add(new AssemblyInstruction(byteAddress, ";Print via ASCI0 a zero terminated string, starting at the return address on the stack."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  none."));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:none."));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putMsg", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putMsg:"));
    result.add(plantAssemblyInstruction(INDENT + "EX    (SP),HL", 0xE3));             //save HL and load return address into HL.
    putLabelReference("putStr", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putStr", 0xCD, 0x1B, 0x21));
    result.add(plantAssemblyInstruction(INDENT + "EX    (SP),HL", 0xE3));             //put return address onto stack and restore HL.
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
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));              //save registers
    labels.put("putStr1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putStr1:"));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,(HL)", 0x7E));          //get next character
    result.add(plantAssemblyInstruction(INDENT + "INC   HL", 0x23));
    result.add(plantAssemblyInstruction(INDENT + "OR    A,A", 0xB7));             //is it zer0?
    putLabelReference("putStr2", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    Z,putStr2", 0x28, 0x05)); //yes ->return
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0, 0));   //no->put it to ASCI0
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
    result.add(plantAssemblyInstruction(INDENT + "LD    A,' '", 0x3E, 0x20)); //load space and continue with putChar.
    
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";putChar"));
    result.add(new AssemblyInstruction(byteAddress, ";Send one character to ASCI0."));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  A = character"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none."));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:AF"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("putChar", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putChar:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));                    //send the character via ASCI0
    labels.put("putChar1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putChar1:"));
    result.add(plantAssemblyInstruction(INDENT + "IN0   A,(STAT0)", 0xED, 0x38, 0x04)); //read ASCI0 status register
    result.add(plantAssemblyInstruction(INDENT + "BIT   TDRE,A", 0xCB, 0x4F));          //wait until TDRE <> 0
    putLabelReference("putChar1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    Z,putChar1", 0x28, 0xF9));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));                    //restore AF registers
    result.add(plantAssemblyInstruction(INDENT + "OUT0  (TDR0),A", 0xED, 0x39, 0x06));  //write character to ASCI0
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
    result.add(plantAssemblyInstruction(INDENT + "LD    A,'\\r'", 0x3E, 0x0D)); //print carriage return
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,'\\n'", 0x3E, 0x0A)); //print line feed
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
    result.add(plantAssemblyInstruction(INDENT + "LD    A,'\\b'", 0x3E, 0x08));   //print backspace
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0, 0));
    putLabelReference("putSpace", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putSpace", 0xCD, 0, 0));  //print space (erase character)
    result.add(plantAssemblyInstruction(INDENT + "LD    A,'\\b'", 0x3E, 0x08));   //print backspace
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
    result.add(plantAssemblyInstruction(INDENT + "LD    A,07", 0x3E, 0x07));   //ring the bell at ASCI0
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
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));            //save used registers
    result.add(plantAssemblyInstruction(INDENT + "LD    A,H", 0x7C));           //print H as 2 hex digits
    putLabelReference("putHexA", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putHexA", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,L", 0x7D));           //print L as 2 hex digits
    putLabelReference("putHexA", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putHexA", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));          //restore used registers
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
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));              //save input
    result.add(plantAssemblyInstruction(INDENT + "RRA", 0x1F));                   //shift upper nibble to the right
    result.add(plantAssemblyInstruction(INDENT + "RRA", 0x1F));
    result.add(plantAssemblyInstruction(INDENT + "RRA", 0x1F));
    result.add(plantAssemblyInstruction(INDENT + "RRA", 0x1F));
    putLabelReference("putHexA1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putHexA1", 0xCD, 0, 0));  //print upper nibble
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));              //restore input & print lower nibble
    labels.put("putHexA1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putHexA1:"));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));              //save input
    result.add(plantAssemblyInstruction(INDENT + "AND   A,0x0F", 0xE6, 0x0F));    //mask lower nibble
    result.add(plantAssemblyInstruction(INDENT + "ADD   A,'0'", 0xC6, 0x30));     //convert to hex digit
    result.add(plantAssemblyInstruction(INDENT + "CP    A,'9'+1", 0xFE, 0x3A));
    putLabelReference("putHexA2", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    C,putHexA2", 0x38, 0x02));
    result.add(plantAssemblyInstruction(INDENT + "ADD   A,07", 0xC6, 0x07));
    labels.put("putHexA2", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "putHexA2:"));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));              //restore input
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));                   //and return
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
    result.add(plantAssemblyInstruction(INDENT + "PUSH  BC", 0xC5));        //11  11 save BC
    result.add(plantAssemblyInstruction(INDENT + "LD    B,H", 0x44));       // 4  15 copy HL to BC
    result.add(plantAssemblyInstruction(INDENT + "LD    C,L", 0x4D));       // 4  19
    result.add(plantAssemblyInstruction(INDENT + "LD    H,E", 0x63));       // 4  23 HL contains EL
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL", 0xED,0x6C));   //17  40
    result.add(plantAssemblyInstruction(INDENT + "PUSH  HL", 0xE5));        //11  51
    result.add(plantAssemblyInstruction(INDENT + "LD    H,E", 0x63));       // 4  55 HL contains EH aka EB
    result.add(plantAssemblyInstruction(INDENT + "LD    L,B", 0x68));       // 4  59
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL", 0xED, 0x6C));  //17  76
    result.add(plantAssemblyInstruction(INDENT + "LD    B,L", 0x45));       // 4  80 save EHlow in B
    result.add(plantAssemblyInstruction(INDENT + "LD    H,D", 0x62));       // 4  84 HL contains DL aka DC
    result.add(plantAssemblyInstruction(INDENT + "LD    L,C", 0x69));       // 4  88
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL", 0xED, 0x6C));  //17 105
    result.add(plantAssemblyInstruction(INDENT + "LD    D,L", 0x55));       // 4 109 DLlow into DE
    result.add(plantAssemblyInstruction(INDENT + "LD    E,0", 0x1E, 0x00)); // 6 115
    result.add(plantAssemblyInstruction(INDENT + "POP   HL", 0xE1));        // 9 124 add EL+DElow
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,DE", 0x19));     // 7 131
    result.add(plantAssemblyInstruction(INDENT + "LD    D,B", 0x50));       // 4 135 add EL+DElow+EHlow
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,DE", 0x19));     // 7 142
    result.add(plantAssemblyInstruction(INDENT + "POP   BC", 0xC1));        // 9 151 restore BC
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));             // 9 160


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
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));            //11  11 save AF
    result.add(plantAssemblyInstruction(INDENT + "PUSH  BC", 0xC5));            //11  22 save BC
    result.add(plantAssemblyInstruction(INDENT + "LD    B,H", 0x44));           // 4  26
    result.add(plantAssemblyInstruction(INDENT + "LD    C,L", 0x4D));           // 4  30
    result.add(plantAssemblyInstruction(INDENT + "LD    H,D ", 0x62));          // 4  34 HL contains DH aka DB
    result.add(plantAssemblyInstruction(INDENT + "LD    L,B", 0x68));           // 4  38
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL", 0xED, 0x6C));       //17  55
    result.add(plantAssemblyInstruction(INDENT + "PUSH  HL", 0xE5));            //11  66
    result.add(plantAssemblyInstruction(INDENT + "LD    H,D", 0x62));           // 4  70 HL contains DL aka DC
    result.add(plantAssemblyInstruction(INDENT + "LD    L,C", 0x69));           // 4  74
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL", 0xED, 0x6C));      //17  91
    result.add(plantAssemblyInstruction(INDENT + "PUSH  HL", 0xE5));            //11 102
    result.add(plantAssemblyInstruction(INDENT + "LD    H,E", 0x63));           // 4 106 HL contains EH aka EB
    result.add(plantAssemblyInstruction(INDENT + "LD    L,B", 0x68));           // 4 110
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL", 0xED, 0x6C));      //17 127
    result.add(plantAssemblyInstruction(INDENT + "PUSH  HL", 0xE5));            //11 138
    result.add(plantAssemblyInstruction(INDENT + "LD    H,E", 0x63));           // 4 142 HL contains EL aka EC
    result.add(plantAssemblyInstruction(INDENT + "LD    L,C", 0x69));           // 4 146
    result.add(plantAssemblyInstruction(INDENT + "MLT   HL", 0xED, 0x6C));      //17 163
    result.add(plantAssemblyInstruction(INDENT + "POP   DE", 0xD1));            // 9 172 calculate RS=EL+EH0
    result.add(plantAssemblyInstruction(INDENT + "LD    B,0", 0x06, 0x00));     // 6 178
    result.add(plantAssemblyInstruction(INDENT + "LD    C,D", 0x4A));           // 4 182 ..C=EHhigh
    result.add(plantAssemblyInstruction(INDENT + "LD    D,E", 0x53));           // 4 186 ..D=EHlow
    result.add(plantAssemblyInstruction(INDENT + "LD    E,0", 0x1E, 0x00));     // 6 192
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,DE", 0x19));         // 7 199
    result.add(plantAssemblyInstruction(INDENT + "JR    NC,$+3", 0x30, 0x01));  // 8 207 | 6 205 add carry to PQ
    result.add(plantAssemblyInstruction(INDENT + "INC   BC", 0x03));            //         4 209
    result.add(plantAssemblyInstruction(INDENT + "POP   DE", 0xD1));            // 9 209 | 211 calculate RS=EL+EH0+DL0
    result.add(plantAssemblyInstruction(INDENT + "LD    A,D", 0x7A));           // 4 220 | 222 ..A=DLhigh
    result.add(plantAssemblyInstruction(INDENT + "LD    D,E", 0x53));           // 4 224 | 226 ..D=DLlow
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,DE", 0x19));         // 7 231 | 233
    result.add(plantAssemblyInstruction(INDENT + "JR    NC,$+3", 0x30, 0x01));  // 8 239 | 6 239 add carry to PQ
    result.add(plantAssemblyInstruction(INDENT + "INC   BC", 0x03));            //         4 243
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";HL=RS=EL+EH0+DL0"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";C=EHhigh"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";A=DLhigh"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";E=0"));
    result.add(plantAssemblyInstruction(INDENT + "EX    DE,HL", 0xEB));         // 3 242 | 246
    result.add(plantAssemblyInstruction(INDENT + "LD    H,L", 0x65));           // 4 246 | 250 ..E was 0, so H=L=0
    result.add(plantAssemblyInstruction(INDENT + "LD    L,A", 0x6F));           // 4 250 | 254 ..HL=DLhigh
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,BC", 0x09));         // 7 257 | 261 PQ=EHhigh+DLhigh+DH
    result.add(plantAssemblyInstruction(INDENT + "POP   BC", 0xC1));            // 9 266 | 270
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,BC", 0x09));         // 7 273 | 277
    result.add(plantAssemblyInstruction(INDENT + "EX    DE,HL", 0xEB));         // 3 276 | 280
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";D=P=DHhigh"));   //
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";E=Q=DHlow+EHhigh+DLhigh"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";H=R=ELhigh+EHlow+DLlow"));
    result.add(new AssemblyInstruction(byteAddress, INDENT + ";L=S=ELlow"));
    result.add(plantAssemblyInstruction(INDENT + "POP   BC", 0xC1));            // 9 285 | 289 restore BC
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));            // 9 294 | 298 restore AF
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));                 // 9 303 | 307

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
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));                //11  11 save AF
    result.add(plantAssemblyInstruction(INDENT + "PUSH  BC", 0xC5));                //11  22 save BC
    result.add(plantAssemblyInstruction(INDENT + "LD    B,H", 0x44));               // 4  26
    result.add(plantAssemblyInstruction(INDENT + "LD    C,L", 0x4D));               // 4  30
    result.add(plantAssemblyInstruction(INDENT + "LD    HL,0", 0x21, 0, 0));        // 9  39
    result.add(plantAssemblyInstruction(INDENT + "LD    A,16", 0x3E, 0x10));           // 6  45
    labels.put("mul16S1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "mul16S1:"));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,HL", 0x29));             //16*7=112 157
    result.add(plantAssemblyInstruction(INDENT + "RL    E", 0xCB, 0x13));           //16*7=112 269
    result.add(plantAssemblyInstruction(INDENT + "RL    D", 0xCB, 0x12));           //16*7=112 381
    putLabelReference("mul16S2", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    NC,mul16S2", 0x30, 0x04));  //16*8=128 509 16*6= 96 477
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,BC", 0x09));             //             16*7=112 589
    putLabelReference("mul16S2", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    NC,mul16S2", 0x30, 0x01));  //             16*8=128 717 16*6=96 685
    result.add(plantAssemblyInstruction(INDENT + "INC   DE", 0x13));                //             16*4= 64 781 16*4=64 749 This instruction (with the jump) is like an "ADC DE,0"
    labels.put("mul16S2", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "mul16S2:"));
    result.add(plantAssemblyInstruction(INDENT + "DEC   A", 0x3D));                 //16*4=64    573 | 845 | 813
    putLabelReference("mul16S1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    NZ,mul16S1", 0x20, 0xF2));  //15*8+6=126 699 | 971 | 939
    result.add(plantAssemblyInstruction(INDENT + "POP   BC", 0xC1));                // 9         708 | 980 | 948 restore BC
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));                // 9         717 | 989 | 957 restore AF
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));                     // 9         726 | 998 | 966
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
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));                //11  11 save registers used
    result.add(plantAssemblyInstruction(INDENT + "PUSH  BC", 0xC5));                //11  22
    result.add(plantAssemblyInstruction(INDENT + "LD    C,L", 0x4D));               // 4  26 T(AC) = teller from input (HL)
    result.add(plantAssemblyInstruction(INDENT + "LD    A,H", 0x7C));               // 4  30 D(DE) = deler from input  (DE)
    result.add(plantAssemblyInstruction(INDENT + "LD    HL,0", 0x21, 0x00, 0x00));  // 9  39 R(HL) = restant; Q(AC) = quotient
    result.add(plantAssemblyInstruction(INDENT + "LD    B,16", 0x06, 0x10));        // 6  45 for (i=16; i>0; i--)
    labels.put("div16_1", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_1:"));
    result.add(plantAssemblyInstruction(INDENT + "SLA   C", 0xCB, 0x21));           //16* 7=112 157   T = T * 2 (remember MSB in carry)
    result.add(plantAssemblyInstruction(INDENT + "RL    A", 0xCB, 0x17));           //16* 7=112 269   Q = Q * 2
    result.add(plantAssemblyInstruction(INDENT + "ADC   HL,HL", 0xED, 0x6A));       //16*10=160 429   R = R * 2 + carry
    result.add(plantAssemblyInstruction(INDENT + "OR    A", 0xB7));                 //16* 4= 64 493   if (R >= D) {
    result.add(plantAssemblyInstruction(INDENT + "SBC   HL,DE", 0xED, 0x52));       //16*10=160 653
    putLabelReference("div16_2", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    C,div16_2", 0x38, 0x03));   //16* 8=128 781 16*6= 96 749   R = R - D
    result.add(plantAssemblyInstruction(INDENT + "INC   C", 0x0C));                 //              16*4= 64 813   Q++
    putLabelReference("div16_3", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    div16_3", 0x18, 0x01));     //              16*8=128 941
    labels.put("div16_2", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_2:"));                   //
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,DE", 0x19));             //16* 7=112 893  (compensate comparison)
    labels.put("div16_3", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_3:"));
    putLabelReference("div16_1", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "DJNZ  div16_1", 0x10, 0xEF));     //15*9+7=142 1035 | 1083 }
    result.add(plantAssemblyInstruction(INDENT + "EX    DE,HL", 0xEB));             // 3 1038 | 1086 swap remainder (HL) into DE
    result.add(plantAssemblyInstruction(INDENT + "LD    H,A", 0x67));               // 4 1042 | 1090 move quotient (AC) into HL
    result.add(plantAssemblyInstruction(INDENT + "LD    L,C", 0x69));               // 4 1046 | 1094
    result.add(plantAssemblyInstruction(INDENT + "POP   BC", 0xC1));                // 9 1055 | 1103
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));                // 9 1064 | 1112
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));                     // 9 1073 | 1121

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
    result.add(plantAssemblyInstruction(INDENT + "PUSH  BC", 0xC5));                //11  11 save registers used
    result.add(plantAssemblyInstruction(INDENT + "LD    B,16", 0x06, 0x10));                // 6 17 the length of the dividend (16 bits)
    result.add(plantAssemblyInstruction(INDENT + "LD    C,A", 0x4F));                // 4 21 move divisor to C
    result.add(plantAssemblyInstruction(INDENT + "XOR   A", 0xAF));                // 4 25 clear upper 8 bits of AHL
    labels.put("div16_82", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_82:"));
    result.add(plantAssemblyInstruction(INDENT + "ADD   HL,HL", 0x29));                //16*7=112 137 advance dividend (HL) into selected bits (A)
    result.add(plantAssemblyInstruction(INDENT + "RL    A", 0xCB, 0x17));                //16*7=112 249
    result.add(plantAssemblyInstruction(INDENT + "CP    C ", 0xB9));                //16*4= 64 313 check if divisor (E) <= selected digits (A)
    putLabelReference("div16_83", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "JR    C,div16_83", 0x38, 0));                //16*8=128 441 16*6=96 409 if not, advance without subtraction
    result.add(plantAssemblyInstruction(INDENT + "SUB   C", 0x91));                //             16*4=64 473 subtract the divisor
    result.add(plantAssemblyInstruction(INDENT + "INC   L", 0x2C));                //             16*4=64 537 and set the next digit of the quotient
    labels.put("div16_83", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "div16_83:"));
    putLabelReference("div16_82", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "DJNZ  div16_82", 0x10, 0));                //15*9+7=142 583 679
    result.add(plantAssemblyInstruction(INDENT + "POP   BC", 0xC1));                //9 592 688
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));                //9 601 697
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
    result.add(plantAssemblyInstruction(INDENT + "PUSH  DE", 0xD5));
    result.add(plantAssemblyInstruction(INDENT + "LD    HL,0", 0x21, 0, 0));    //result = 0;
    putLabelReference("getChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  getChar", 0xCD, 0, 0)); //check if a character is available.
    result.add(plantAssemblyInstruction(INDENT + "JR    Z,$-3", 0x28, 0xFB));    //-no: wait for it.
    result.add(plantAssemblyInstruction(INDENT + "CP    '\r'", 0xFE, 0x0D));       //return if char == Carriage Return
    result.add(plantAssemblyInstruction(INDENT + "JR    Z,$+17", 0x28, 0x0F));
    result.add(plantAssemblyInstruction(INDENT + "LD    DE,10", 0x11, 0x0A, 0x00));
    putLabelReference("mul16", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  mul16", 0xCD, 0, 0));   //result *= 10;
    result.add(plantAssemblyInstruction(INDENT + "SUB   A,'0'", 0xD6, 0x30));      //digit = char - "0";
    result.add(plantAssemblyInstruction(INDENT + "ADD   A,L", 0x85));           //result += digit;
    result.add(plantAssemblyInstruction(INDENT + "LD    L,A", 0x6F));
    result.add(plantAssemblyInstruction(INDENT + "JR    NC,$-19", 0x30, 0xEB));   //get next character
    result.add(plantAssemblyInstruction(INDENT + "INC   H", 0x24));
    result.add(plantAssemblyInstruction(INDENT + "JR    $-22", 0x18, 0xE8));      //get next character
    result.add(plantAssemblyInstruction(INDENT + "POP   DE", 0xD1));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));
    
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    result.add(new AssemblyInstruction(byteAddress, ";write"));
    result.add(new AssemblyInstruction(byteAddress, ";write a 16 bit unsigned number to the output"));
    result.add(new AssemblyInstruction(byteAddress, ";  IN:  TOS   = return address"));
    result.add(new AssemblyInstruction(byteAddress, ";       TOS+2 = 16 bit unsigned number"));
    result.add(new AssemblyInstruction(byteAddress, ";  OUT: none"));
    result.add(new AssemblyInstruction(byteAddress, ";  USES:HL"));
    result.add(new AssemblyInstruction(byteAddress, ";****************"));
    labels.put("write", byteAddress);
    result.add(new AssemblyInstruction(byteAddress, "write:"));
    result.add(plantAssemblyInstruction(INDENT + "POP   HL", 0xE1));        //return address into HL
    result.add(plantAssemblyInstruction(INDENT + "EX    (SP),HL", 0xE3));   //uint in HL; return address on stack
    result.add(plantAssemblyInstruction(INDENT + "PUSH  BC", 0xC5));        //save registers used
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "LD    B,0", 0x06, 0x00)); //number of digits on stack
    result.add(plantAssemblyInstruction(INDENT + "LD    A,H", 0x7C));       //is HL=0?
    result.add(plantAssemblyInstruction(INDENT + "OR    L", 0xB5));
    result.add(plantAssemblyInstruction(INDENT + "JR    NZ,$+5", 0x20, 0x03));
    result.add(plantAssemblyInstruction(INDENT + "INC   B", 0x04));         //write a single digit 0
    result.add(plantAssemblyInstruction(INDENT + "JR    $+14", 0x18, 0x0C));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,10", 0x3E, 0x0A));//divide HL by 10
    putLabelReference("div16_8", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  div16_8", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "PUSH  AF", 0xF5));        //put remainder on stack
    result.add(plantAssemblyInstruction(INDENT + "INC   B", 0x04));
    result.add(plantAssemblyInstruction(INDENT + "LD    A,H", 0x7C));       //is quotient 0?
    result.add(plantAssemblyInstruction(INDENT + "OR    L", 0xB5));
    result.add(plantAssemblyInstruction(INDENT + "JR    NZ,$-9", 0x20, 0xF5));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));        //write digit
    result.add(plantAssemblyInstruction(INDENT + "ADD   A,'0'", 0xC6, 0x30));
    putLabelReference("putChar", byteAddress);
    result.add(plantAssemblyInstruction(INDENT + "CALL  putChar", 0xCD, 0, 0));
    result.add(plantAssemblyInstruction(INDENT + "DJNZ  $-6", 0x10, 0xF8));
    result.add(plantAssemblyInstruction(INDENT + "POP   AF", 0xF1));        //restore registers used
    result.add(plantAssemblyInstruction(INDENT + "POP   BC", 0xC1));
    result.add(plantAssemblyInstruction(INDENT + "RET", 0xC9));
    
    return result;
  }
}