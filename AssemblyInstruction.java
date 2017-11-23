import java.util.ArrayList;
import java.util.Arrays;
/*
* This class implements a single line of assembly code
*/
public class AssemblyInstruction {
  
  private String code;            /* assembler code */
  private long address;           /* start address of the assembled instruction. */
  private ArrayList<Byte> bytes;  /* assembler instruction coded as an array of bytes. */

  /* constructor */
  public AssemblyInstruction(long address, String code, int... bytes) {
    this.address = address;
    this.code = code;
    if (bytes != null && bytes.length > 0) {
      this.bytes = new ArrayList<Byte>(bytes.length);
    }
    for (int newByte: bytes) {
      this.bytes.add((byte)newByte);
    }
  }
  
  public String getCode() {
    return code;
  }

  public Long getAddress() {
    return address;
  }
  
  public ArrayList<Byte> getBytes() {
    return bytes;
  }
  
}