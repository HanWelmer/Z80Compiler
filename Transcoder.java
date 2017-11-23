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
    
    FunctionType function = instruction.function;
    OperandType opType = instruction.opType;
    CallType callValue = instruction.callValue;
    int word = instruction.word;
    int memAddress = MEM_START + word * 2;
    AssemblyInstruction asm = null;
    debug("\n..function:" + function);

    if (function == FunctionType.stop) {
      asm = new AssemblyInstruction(byteAddress, "JP 0x0171", 0xC3, 0x71, 0x01);
      debug("\n.." + asm.getCode());
/*
    } else if (function == FunctionType.call) {
      if (callValue == CallType.read) {
        storeString[z80PosLine++] = "CALL read";
      } else if (callValue == CallType.write) {
        storeString[z80PosLine++] = "CALL write";
      } else {
        storeString[z80PosLine++] = String.format("CALL 0x%04X", word);
      }
    } else if (brFunctions.contains(function)) {
      if (function == FunctionType.br) {
        storeString[z80PosLine++] = String.format("JP L" + word);
      } else if (function == FunctionType.brEq) {
        storeString[z80PosLine++] = String.format("JP Z,L" + word);
      } else if (function == FunctionType.brNe) {
        storeString[z80PosLine++] = String.format("JP NZ,L" + word);
      } else if (function == FunctionType.brLt) {
        storeString[z80PosLine++] = String.format("JP NC,L" + word);
      } else if (function == FunctionType.brLe) {
        storeString[z80PosLine++] = String.format("JP NC,L" + word);
        storeString[z80PosLine++] = String.format("JP Z,L" + word);
      } else if (function == FunctionType.brGt) {
        storeString[z80PosLine++] = "JR   Z,$+5";
        storeString[z80PosLine++] = String.format("JP C,L" + word);
      } else if (function == FunctionType.brGe) {
        storeString[z80PosLine++] = String.format("JP C,L" + word);
      }
    } else if (function == FunctionType.accLoad) {
      switch(opType) {
        case var: 
          storeString[z80PosLine++] = "LD   HL,(" + memAddress + ")";
          break;
        case constant: 
          storeString[z80PosLine++] = "LD   HL," + word;
          break;
        case stack:
          storeString[z80PosLine++] = "POP HL";
          break;
      };
    } else if (function == FunctionType.accStore) {
      switch(opType) {
        case var: 
          storeString[z80PosLine++] = "LD   (" + memAddress + "),HL";
          break;
        case stack:
          storeString[z80PosLine++] = "PUSH HL";
          break;
      };
    } else if (function == FunctionType.stackAccLoad) {
      storeString[z80PosLine++] = "PUSH HL";
      switch(opType) {
        case var: 
          storeString[z80PosLine++] = "LD   HL,(" + memAddress + ")";
          break;
        case constant: 
          storeString[z80PosLine++] = "LD   HL," + word;
          break;
      };
    } else if (function == FunctionType.accPlus) {
      switch(opType) {
        case var: 
          storeString[z80PosLine++] = "LD   DE,(" + memAddress + ")";
          break;
        case constant: 
          storeString[z80PosLine++] = "LD   DE," + word;
          break;
        case stack:
          storeString[z80PosLine++] = "POP DE";
          break;
      };
      storeString[z80PosLine++] = "ADD   HL,DE";
    } else if ((function == FunctionType.accMinus) || (function == FunctionType.minusAcc) || (function == FunctionType.accCompare)) {
      switch(opType) {
        case var: 
          storeString[z80PosLine++] = "LD   DE,(" + memAddress + ")";
          break;
        case constant: 
          storeString[z80PosLine++] = "LD   DE," + word;
          break;
        case stack:
          storeString[z80PosLine++] = "POP DE";
          break;
      };
      if (function == FunctionType.accCompare) {
        storeString[z80PosLine++] = "PUSH  HL";
      }
      if (function == FunctionType.minusAcc) {
        storeString[z80PosLine++] = "EX    DE,HL";
      }
      storeString[z80PosLine++] = "SCF";
      storeString[z80PosLine++] = "CCF";
      storeString[z80PosLine++] = "SBC   HL,DE";
      if (function == FunctionType.accCompare) {
        storeString[z80PosLine++] = "POP   HL";
      }
    } else if (function == FunctionType.accTimes) {
      switch(opType) {
        case var: 
          storeString[z80PosLine++] = "LD   DE,(" + memAddress + ")";
          break;
        case constant: 
          storeString[z80PosLine++] = "LD   DE," + word;
          break;
        case stack:
          storeString[z80PosLine++] = "POP DE";
          break;
      };
      storeString[z80PosLine++] = "CALL mul16";
    } else if ((function == FunctionType.accDiv) || (function == FunctionType.divAcc)) {
      switch(opType) {
        case var: 
          storeString[z80PosLine++] = "LD   DE,(" + memAddress + ")";
          break;
        case constant: 
          storeString[z80PosLine++] = "LD   DE," + word;
          break;
        case stack:
          storeString[z80PosLine++] = "POP DE";
          break;
      };
      if (function == FunctionType.divAcc) {
        storeString[z80PosLine++] = "EX    DE,HL";
      }
      storeString[z80PosLine++] = "CALL div16";
*/
    }

    /* add assembly code to output and update byte address */
    result.add(asm);
    byteAddress += asm.getBytes().size();

    return result;
  }

  private void plantZ80Bin(Instruction instruction) {
  /*
    FunctionType function = instruction.function;
    OperandType opType = instruction.opType;
    CallType callValue = instruction.callValue;
    int word = instruction.word;
    int memAddress = MEM_START + word * 2;

    if (function == FunctionType.call) {
      storeBytes[z80PosByte++] = 0xCD; // CALL
      if (callValue == CallType.read) {
        storeBytes[z80PosByte++] = 0x03;
        storeBytes[z80PosByte++] = 0x00;
      } else if (callValue == CallType.write) {
        storeBytes[z80PosByte++] = 0x06;
        storeBytes[z80PosByte++] = 0x00;
      } else {
        storeBytes[z80PosByte++] = word % 256;
        storeBytes[z80PosByte++] = word / 256;
      }
    } else if (brFunctions.contains(function)) {
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
    } else if (function == FunctionType.accLoad) {
      switch(opType) {
        case var: 
          storeBytes[z80PosByte++] = 0x2A; // LD   HL,(memAddress)
          storeBytes[z80PosByte++] = memAddress % 256;
          storeBytes[z80PosByte++] = memAddress / 256;
          break;
        case constant: 
          storeBytes[z80PosByte++] = 0x21; // LD   HL,word
          storeBytes[z80PosByte++] = word % 256;
          storeBytes[z80PosByte++] = word / 256;
          break;
        case stack:
          storeBytes[z80PosByte++] = 0xE1; // POP HL
          break;
      };
    } else if (function == FunctionType.accStore) {
      switch(opType) {
        case var: 
          storeBytes[z80PosByte++] = 0x22; // LD   (memAddress),HL
          storeBytes[z80PosByte++] = memAddress % 256;
          storeBytes[z80PosByte++] = memAddress / 256;
          break;
        case stack:
          storeBytes[z80PosByte++] = 0xE5; // PUSH HL
          break;
      };
    } else if (function == FunctionType.stackAccLoad) {
      storeBytes[z80PosByte++] = 0xE5; // PUSH HL
      switch(opType) {
        case var: 
          storeBytes[z80PosByte++] = 0x2A; // LD   HL,(" + memAddress + ")
          storeBytes[z80PosByte++] = memAddress % 256;
          storeBytes[z80PosByte++] = memAddress / 256;
          break;
        case constant: 
          storeBytes[z80PosByte++] = 0x21; // LD   HL,word;
          storeBytes[z80PosByte++] = word % 256;
          storeBytes[z80PosByte++] = word / 256;
          break;
      };
    } else if (function == FunctionType.accPlus) {
      switch(opType) {
        case var: 
          storeBytes[z80PosByte++] = 0xED; // LD   DE,(memAddress)
          storeBytes[z80PosByte++] = 0x5B;
          storeBytes[z80PosByte++] = memAddress % 256;
          storeBytes[z80PosByte++] = memAddress / 256;
          break;
        case constant: 
          storeBytes[z80PosByte++] = 0x11; // LD   DE,word
          storeBytes[z80PosByte++] = word % 256;
          storeBytes[z80PosByte++] = word / 256;
          break;
        case stack:
          storeBytes[z80PosByte++] = 0xD1; // POP DE
          break;
      };
      storeBytes[z80PosByte++] = 0x19; // ADD   HL,DE
    } else if ((function == FunctionType.accMinus) || (function == FunctionType.minusAcc) || (function == FunctionType.accCompare)) {
      switch(opType) {
        case var: 
          storeBytes[z80PosByte++] = 0xED; // LD   DE,(memAddress)
          storeBytes[z80PosByte++] = 0x5B;
          storeBytes[z80PosByte++] = memAddress % 256;
          storeBytes[z80PosByte++] = memAddress / 256;
          break;
        case constant: 
          storeBytes[z80PosByte++] = 0x11; // LD   DE,word
          storeBytes[z80PosByte++] = word % 256;
          storeBytes[z80PosByte++] = word / 256;
          break;
        case stack:
          storeBytes[z80PosByte++] = 0xD1; // POP DE
          break;
      };
      if (function == FunctionType.accCompare) {
        storeBytes[z80PosByte++] = 0xE5; // PUSH  HL
      }
      if (function == FunctionType.minusAcc) {
        storeBytes[z80PosByte++] = 0xEB; // EX    DE,HL
      }
      storeBytes[z80PosByte++] = 0x37; // SCF
      storeBytes[z80PosByte++] = 0x3F; // CCF
      storeBytes[z80PosByte++] = 0xED; // SBC   HL,DE
      storeBytes[z80PosByte++] = 0x52;
      if (function == FunctionType.accCompare) {
        storeBytes[z80PosByte++] = 0xE1; // POP   HL
      }
    } else if (function == FunctionType.accTimes) {
      switch(opType) {
        case var: 
          storeBytes[z80PosByte++] = 0xED; // LD   DE,(memAddress)
          storeBytes[z80PosByte++] = 0x5B;
          storeBytes[z80PosByte++] = memAddress % 256;
          storeBytes[z80PosByte++] = memAddress / 256;
          break;
        case constant: 
          storeBytes[z80PosByte++] = 0x11; // LD   DE,word
          storeBytes[z80PosByte++] = word % 256;
          storeBytes[z80PosByte++] = word / 256;
          break;
        case stack:
          storeBytes[z80PosByte++] = 0xD1; // POP DE
          break;
      };
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
      switch(opType) {
        case var: 
          storeBytes[z80PosByte++] = 0xED; // LD   DE,(memAddress)
          storeBytes[z80PosByte++] = 0x5B;
          storeBytes[z80PosByte++] = memAddress % 256;
          storeBytes[z80PosByte++] = memAddress / 256;
          break;
        case constant: 
          storeBytes[z80PosByte++] = 0x11;  // LD   DE,word
          storeBytes[z80PosByte++] = word % 256;
          storeBytes[z80PosByte++] = word / 256;
          break;
        case stack:
          storeBytes[z80PosByte++] = 0xD1; // POP DE
          break;
      };
      if (function == FunctionType.divAcc) {
        storeBytes[z80PosByte++] = 0xEB; // EX    DE,HL
      }
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
    storeString[z80PosLine++] = "JP main";

    storeString[z80PosLine++] = "mul16:";
    // DEHL = HL * DE
    storeString[z80PosLine++] = "push bc";
    storeString[z80PosLine++] = "ld b,h";
    storeString[z80PosLine++] = "ld c,l";
    storeString[z80PosLine++] = "ld hl,0";
    storeString[z80PosLine++] = "ld a,16";
    storeString[z80PosLine++] = "mul16_1:";
    storeString[z80PosLine++] = "add hl,hl";
    storeString[z80PosLine++] = "rl e";
    storeString[z80PosLine++] = "rl d";
    storeString[z80PosLine++] = "jr nc,mul16_2";
    storeString[z80PosLine++] = "add hl,bc";
    storeString[z80PosLine++] = "jr nc, mul16_2";
    storeString[z80PosLine++] = "inc de";
    storeString[z80PosLine++] = "mul16_2:";
    storeString[z80PosLine++] = "dec a";
    storeString[z80PosLine++] = "jr nz, mul16_1";
    storeString[z80PosLine++] = "pop bc";
    storeString[z80PosLine++] = "ret";

    storeString[z80PosLine++] = "div16:";
    // teller in HL; deler in DE -> quotient in HL; restant in DE
    storeString[z80PosLine++] = "LD   A,D"; // als DE=0, error div by zero
    storeString[z80PosLine++] = "OR   E";
    storeString[z80PosLine++] = "JR   Z,ERROR";
    storeString[z80PosLine++] = "LD   B,H"; // kopie teller in BC
    storeString[z80PosLine++] = "LD   C,L";
    storeString[z80PosLine++] = "LD   HL,0"; // result = 0
    storeString[z80PosLine++] = "LD   A,B"; // deler High
    storeString[z80PosLine++] = "LD   B,16D";
    storeString[z80PosLine++] = "TRIALSB:";
    storeString[z80PosLine++] = "RL   C"; // roteer links result + ACC
    storeString[z80PosLine++] = "RLA";
    storeString[z80PosLine++] = "ADC  HL,HL"; // schuif links; carry wordt niet beïnvloed
    storeString[z80PosLine++] = "SBC  HL,DE"; // teller eraftrekken
    storeString[z80PosLine++] = "NULL:";
    storeString[z80PosLine++] = "CCF"; // result bit
    storeString[z80PosLine++] = "JR   NC,NGV"; // Acc negatief?
    storeString[z80PosLine++] = "PTV:";
    storeString[z80PosLine++] = "DJNZ TRIALSB";
    storeString[z80PosLine++] = "JP   DONE";
    storeString[z80PosLine++] = "RESTOR:";
    storeString[z80PosLine++] = "RL   C"; // roteer links result + acc
    storeString[z80PosLine++] = "RLA";
    storeString[z80PosLine++] = "ADC  HL,HL"; // schuif links; carry wordt niet beïnvloed
    storeString[z80PosLine++] = "AND  A"; // carry op nul zetten
    storeString[z80PosLine++] = "ADC  HL,DE"; // herstel door deler erbij te tellen
    storeString[z80PosLine++] = "JR   C,PTV"; // resultaat positief
    storeString[z80PosLine++] = "JR   Z,NULL"; // resultaat nul
    storeString[z80PosLine++] = "NGV:";
    storeString[z80PosLine++] = "DJNZ RESTOR";
    storeString[z80PosLine++] = "DONE:";
    storeString[z80PosLine++] = "RL   C"; // resultaat bit inschuiven
    storeString[z80PosLine++] = "RLA";
    storeString[z80PosLine++] = "LD   B,A"; // quotient in BC
    storeString[z80PosLine++] = "LD   A,H"; // restant High negatief?
    storeString[z80PosLine++] = "OR   A";
    storeString[z80PosLine++] = "JP   P,PREM";
    storeString[z80PosLine++] = "ADD  HL,DE"; // corrigeer negatief restant
    storeString[z80PosLine++] = "PREM:";
    storeString[z80PosLine++] = "RET";
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
     storeString[z80PosLine++] = "main:";
    */
  }
}