import java.util.ArrayList;
/*
* This class realises a transcoder. 
* It translates an array with M-code instruction to an array with Z80S180 assembler instructions.
*/
public class Transcoder {
  
  /* constants */
  private static final int MAX_ASM_CODE = 2000; /* max Z80 assembler lines of code */
  private static final int MEM_START = 4000;    /* lowest address for global variables */
  private static final int MIN_BIN = 2000; /* Z80 assembled bytes start at 2000 */
  private static final int MAX_BIN = 4000; /* max Z80 assembled bytes */

  /* global variables */
  private boolean debug = false;
  private boolean generateBinary = false;
  private long byteAddress = MIN_BIN;
  
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
    ArrayList<AssemblyInstruction> z80Instructions = new ArrayList<AssemblyInstruction>();

    plantZ80Runtime();

    for (Instruction instruction: instructions) {
      z80Instructions.addAll(transcode(instruction));
      if (z80Instructions.size() > MAX_ASM_CODE) {
        throw new RuntimeException("code overflow while generating Z80 assembler code");
      }
    }
    return z80Instructions;
  }
  
  /* transcode a single M-code instruction to one or more Z80S180 assembler instruction */
  public ArrayList<AssemblyInstruction> transcode(Instruction instruction){
    ArrayList<AssemblyInstruction> result = new ArrayList<AssemblyInstruction>();

    // TODO : implement transcoder.
    debug("\ntranscoding to Z80: " + instruction.toString());
    
    //add original source code as assembler comment
    if (instruction.linesOfCode != null) {
      for (String sourceCode : instruction.linesOfCode) {
        result.add(new AssemblyInstruction(byteAddress, "     ;" + sourceCode));
      }
    }
    
    //add original M-code instruction as assembler comment
    if (debug) {
      result.add(new AssemblyInstruction(byteAddress, ";" + instruction.toString()));
    }
    
    FunctionType function = instruction.function;
    OperandType opType = instruction.opType;
    CallType callValue = instruction.callValue;
    int word = instruction.word;
    int memAddress = MEM_START + word * 2;
    AssemblyInstruction asm = null;
    debug("\n..function:" + function);

    String asmCode = null;
    if (function == FunctionType.stop) {
      asm = new AssemblyInstruction(byteAddress, "JP   0x0171", 0xC3, 0x71, 0x01);
      debug("\n.." + asm.getCode());
    } else if (function == FunctionType.call) {
      if (callValue == CallType.read) {
        asm = new AssemblyInstruction(byteAddress, "CALL read", 0xCD, 0x03, 0x00);
      } else if (callValue == CallType.write) {
        asm = new AssemblyInstruction(byteAddress, "CALL write", 0xCD, 0x06, 0x00);
      } else {
        asm = new AssemblyInstruction(byteAddress, String.format("CALL 0x%04X", word), 0xCD, word % 256, word / 256);
        throw new RuntimeException("untested CALL nnnn");
      }
    } else if (function == FunctionType.accStore) {
      switch(opType) {
        case var: 
          asmCode = "LD   (" + memAddress + "),HL";
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x22, memAddress % 256, memAddress / 256);
          break;
        case stack:
          asm = new AssemblyInstruction(byteAddress, "PUSH HL", 0xE5);
          break;
      }
    } else if (function == FunctionType.accLoad || function == FunctionType.stackAccLoad) {
      if (function == FunctionType.stackAccLoad) {
        result.add(new AssemblyInstruction(byteAddress++, "PUSH HL", 0xE5));
      }
      switch(opType) {
        case var: 
          asmCode = "LD   HL,(" + memAddress + ")";
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x2A, memAddress % 256, memAddress / 256);
          break;
        case constant: 
          asmCode = "LD   HL," + word;
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x21, word % 256, word / 256);
          break;
        case stack:
          if (function == FunctionType.stackAccLoad) {
            throw new RuntimeException("illegal M-code instruction: stackAccLoad unstack");
          }
          asmCode = "POP  HL";
          asm = new AssemblyInstruction(byteAddress, asmCode, 0xE1);
          throw new RuntimeException("untested accLoad unstack");
          //break;
      }
    } else if (function == FunctionType.accPlus) {
      switch(opType) {
        case var: 
          asmCode = "LD   DE,(" + memAddress + ")";
          asm = new AssemblyInstruction(byteAddress, asmCode, 0xED, 0x5B, memAddress % 256, memAddress / 256);
          break;
        case constant: 
          asmCode = "LD   DE," + word;
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x11, word % 256, word / 256);
          break;
        case stack:
          asmCode = "POP  DE";
          asm = new AssemblyInstruction(byteAddress, asmCode, 0xD1);
          break;
      }
      result.add(asm);
      byteAddress += asm.getBytes().size();
      asmCode = "ADD  HL,DE";
      asm = new AssemblyInstruction(byteAddress, asmCode, 0x19);
    } else if ((function == FunctionType.accMinus) || (function == FunctionType.minusAcc) || (function == FunctionType.accCompare)) {
      switch(opType) {
        case var: 
          asmCode = "LD   DE,(" + memAddress + ")";
          asm = new AssemblyInstruction(byteAddress, asmCode, 0xED, 0x5B, memAddress % 256, memAddress / 256);
          break;
        case constant: 
          asmCode = "LD   DE," + word;
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x11, word % 256, word / 256);
          break;
        case stack:
          asmCode = "POP  DE";
          asm = new AssemblyInstruction(byteAddress, asmCode, 0xD1);
          break;
      };
      result.add(asm);
      byteAddress += asm.getBytes().size();
      
      if (function == FunctionType.accCompare) {
        result.add(new AssemblyInstruction(byteAddress++, "PUSH  HL", 0xE5));
        throw new RuntimeException("untested accCompare");
      }
      
      if (function == FunctionType.minusAcc) {
        result.add(new AssemblyInstruction(byteAddress++, "EX   DE,HL", 0xEB));
      }

      result.add(new AssemblyInstruction(byteAddress++, "OR   A", 0xB7));
      asm = new AssemblyInstruction(byteAddress, "SBC  HL,DE", 0xED, 0x52);
      
      if (function == FunctionType.accCompare) {
        result.add(asm);
        byteAddress += 4;
        asm = new AssemblyInstruction(byteAddress, "POP  HL", 0xE1);
        throw new RuntimeException("untested accCompare");
      }
    } else if (function == FunctionType.accTimes) {
      switch(opType) {
        case var: 
          asmCode = "LD   DE,(" + memAddress + ")";
          result.add(new AssemblyInstruction(byteAddress, asmCode, 0xED, 0x5B, memAddress % 256, memAddress / 256));
          break;
        case constant: 
          asmCode = "LD   DE," + word;
          result.add(new AssemblyInstruction(byteAddress, asmCode, 0x11, word % 256, word / 256));
          break;
        case stack:
          asmCode = "POP  DE";
          result.add(new AssemblyInstruction(byteAddress, asmCode, 0xD1));
          break;
      };
      asm = new AssemblyInstruction(byteAddress, "CALL mul16", 0xCD, 0x06, 0x00);
    } else if ((function == FunctionType.accDiv) || (function == FunctionType.divAcc)) {
      switch(opType) {
        case var: 
          asmCode = "LD   DE,(" + memAddress + ")";
          asm = new AssemblyInstruction(byteAddress, asmCode, 0xED, 0x5B, memAddress % 256, memAddress / 256);
          break;
        case constant: 
          asmCode = "LD   DE," + word;
          asm = new AssemblyInstruction(byteAddress, asmCode, 0x11, word % 256, word / 256);
          break;
        case stack:
          asmCode = "POP DE";
          asm = new AssemblyInstruction(byteAddress, asmCode, 0xD1);
          break;
      };
      result.add(asm);
      byteAddress += asm.getBytes().size();

      if (function == FunctionType.divAcc) {
        result.add(new AssemblyInstruction(byteAddress++, "EX   DE,HL", 0xEB));
      }
      asm = new AssemblyInstruction(byteAddress, "CALL div16", 0xCD, 0x09, 0x00);
/*
    } else if (brFunctions.contains(function)) {
      if (function == FunctionType.br) {
        asmCode = String.format("JP L" + word);
      } else if (function == FunctionType.brEq) {
        asmCode = String.format("JP Z,L" + word);
      } else if (function == FunctionType.brNe) {
        asmCode = String.format("JP NZ,L" + word);
      } else if (function == FunctionType.brLt) {
        asmCode = String.format("JP NC,L" + word);
      } else if (function == FunctionType.brLe) {
        asmCode = String.format("JP NC,L" + word);
        asmCode = String.format("JP Z,L" + word);
      } else if (function == FunctionType.brGt) {
        asmCode = "JR   Z,$+5";
        asmCode = String.format("JP C,L" + word);
      } else if (function == FunctionType.brGe) {
        asmCode = String.format("JP C,L" + word);
      }
*/
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

  private void plantZ80Bin(Instruction instruction) {
  /*
    if (brFunctions.contains(function)) {
      if (function == FunctionType.br) {
        storeBytes[z80PosByte++] = 0xC3; // JP nnnn
      } else if (function == FunctionType.brEq) {
        storeBytes[z80PosByte++] = 0xCA; // JP   Z,nnnn
      } else if (function == FunctionType.brNe) {
        storeBytes[z80PosByte++] = 0xC2; // JP   NZ,nnnn
      } else if (function == FunctionType.brLt) {
        storeBytes[z80PosByte++] = 0xD2; // JP   NC,nnnn
      } else if (function == FunctionType.brLe) {
        storeBytes[z80PosByte++] = 0xD2; // JP   NC,nnnn
        storeBytes[z80PosByte++] = word % 256;
        storeBytes[z80PosByte++] = word / 256;
        storeBytes[z80PosByte++] = 0xCA; // JP   Z,nnnn
      } else if (function == FunctionType.brGt) {
        storeBytes[z80PosByte++] = 0x28; // JR   Z,$+5
        storeBytes[z80PosByte++] = 3;
        storeBytes[z80PosByte++] = 0xDA; // JP   C,nnnn
      } else if (function == FunctionType.brGe) {
        storeBytes[z80PosByte++] = 0xDA; // JP   C,nnnn
      }
      storeBytes[z80PosByte++] = word / 256;
      storeBytes[z80PosByte++] = word % 256;
      //HL := HL * DE
      //       H  L
      //       D  E
      //   --------*
      //         EL
      //      EH  0
      //      DL  0
      //   DH  0  0
      //-----------+
      // P  Q  R  S
      //S=ELlow
      //R=ELhigh+EHlow+DLlow
      //Q=DHlow+EHhigh+DLhigh
      //P=DHhigh
      //
      storeBytes[z80PosByte++] = 0x63; // LD   H,E
      storeBytes[z80PosByte++] = 0xED; // MLT  HL
      storeBytes[z80PosByte++] = 0x6C;
      //
//DE_Times_BC:
//;Inputs:
//;     DE and HL are factors
//;Outputs:
//;     A is 0
//;     BC is not changed
//;     DEHL is the product
//;
//  push bc
//  ld b,h
//  ld c,l
//  ld hl,0
//  ld a,16
//Mul_Loop_1:
//  add hl,hl
//  rl e
//  rl d
//  jr nc,Mul_Loop_2
//    add hl,bc
//    jr nc,Mul_Loop_2
//    inc de
//Mul_Loop_2:
//  dec a
//  jr nz,Mul_Loop_1
//  pop bc
//  ret
    } else if ((function == FunctionType.accDiv) || (function == FunctionType.divAcc)) {
      // teller in HL; deler in DE -> quotient in HL; restant in DE
      // LD   A,D */ /* als DE=0, error div by zero
      // OR   E
      // JR   Z,ERROR
      // LD   B,H // kopie teller in BC
      // LD   C,L
      // LD   HL,0 // result = 0
      // LD   A,B // deler High
      // LD   B,16D
      // TRIALSB:
      // RL   C // roteer links result + ACC
      // RLA
      // ADC  HL,HL // schuif links; carry wordt niet beïnvloed
      // SBC  HL,DE // teller eraftrekken
      // NULL:
      // CCF // result bit
      // JR   NC,NGV // Acc negatief?
      // PTV:
      // DJNZ TRIALSB
      // JP   DONE
      // RESTOR:
      // RL   C // roteer links result + acc
      // RLA
      // ADC  HL,HL // schuif links; carry wordt niet beïnvloed
      // AND  A // carry op nul zetten
      // ADC  HL,DE // herstel door deler erbij te tellen
      // JR   C,PTV // resultaat positief
      // JR   Z,NULL // resultaat nul
      // NGV:
      // DJNZ RESTOR
      // DONE:
      // RL   C // resultaat bit inschuiven
      // RLA
      // LD   B,A // quotient in BC
      // LD   A,H // restant High negatief?
      // OR   A
      // JP   P,PREM
      // ADD  HL,DE // corrigeer negatief restant
      // PREM:
      // RET
      storeBytes[z80PosByte++] = 0x00;
//
//This divides DE by BC, storing the result in DE, remainder in HL
//
//DE_Div_BC:          ;1281-2x, x is at most 16
//     ld a,16        ;7
//     ld hl,0        ;10
//     jp $+5         ;10
//DivLoop:
//       add hl,bc    ;--
//       dec a        ;64
//       ret z        ;86
//       sla e        ;128
//       rl d         ;128
//       adc hl,hl    ;240
//       sbc hl,bc    ;240
//       jr nc,DivLoop ;23|21
//       inc e        ;--
//       jp DivLoop+1
//       */
//    }
  }
  
  private void plantZ80Runtime() {
    /*
    asmCode = "JP main";

    asmCode = "mul16:";
    // DEHL = HL * DE
    asmCode = "push bc";
    asmCode = "ld b,h";
    asmCode = "ld c,l";
    asmCode = "ld hl,0";
    asmCode = "ld a,16";
    asmCode = "mul16_1:";
    asmCode = "add hl,hl";
    asmCode = "rl e";
    asmCode = "rl d";
    asmCode = "jr nc,mul16_2";
    asmCode = "add hl,bc";
    asmCode = "jr nc, mul16_2";
    asmCode = "inc de";
    asmCode = "mul16_2:";
    asmCode = "dec a";
    asmCode = "jr nz, mul16_1";
    asmCode = "pop bc";
    asmCode = "ret";

    asmCode = "div16:";
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
//DE_Div_BC:          ;1281-2x, x is at most 16
//     ld a,16        ;7
//     ld hl,0        ;10
//     jp $+5         ;10
//DivLoop:
//       add hl,bc    ;--
//       dec a        ;64
//       ret z        ;86
//       sla e        ;128
//       rl d         ;128
//       adc hl,hl    ;240
//       sbc hl,bc    ;240
//       jr nc,DivLoop ;23|21
//       inc e        ;--
//       jp DivLoop+1
//
     asmCode = "main:";
    */
  }
}