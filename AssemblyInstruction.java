import java.util.ArrayList;
/*
* This class implements a single line of assembly code
*/
public class AssemblyInstruction {
  
  private Long address;           /* start address of the assembled instruction. */
  private ArrayList<Byte> bytes;  /* assembler instruction coded as an array of bytes. */

  public Long getAddress() {
    return address;
  }
  
  public ArrayList<Byte> getBytes() {
    return bytes;
  }
  
  public String getAssemblyCode() {
    return "AssemblyInstruction.getAssemblyCode() to be implemented";
  }

}