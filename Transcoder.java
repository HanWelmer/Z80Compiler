import java.util.ArrayList;
/*
* This class realises a transcoder. 
* It translates an array with M-code instruction to an array with Z80S180 assembler instructions.
*/
public class Transcoder {
  
  private boolean generateBinary = false;
  
  /* constructor */
  public Transcoder(boolean binary) {
    generateBinary = binary;
  }

  /* transcode the array with M-code instruction to an array with Z80S180 assembler instructions. */
  public ArrayList<AssemblyInstruction> transcode(ArrayList<Instruction> instructions){
    ArrayList<AssemblyInstruction> z80Instructions = new ArrayList<AssemblyInstruction>();
    for (Instruction instruction: instructions) {
      z80Instructions.addAll(transcode(instruction));
    }
    return z80Instructions;
  }
  
  /* transcode a sinle M-code instruction to one or more Z80S180 assembler instruction */
  public ArrayList<AssemblyInstruction> transcode(Instruction instruction){
    ArrayList<AssemblyInstruction> result = new ArrayList<AssemblyInstruction>();
    // TODO : implement transcoder.
    // TODO : implement generation of binary code (generateBinary == true).
    return result;
  }

}