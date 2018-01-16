import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;

public class IntelHexWriter extends BufferedWriter {
  
  private static final int MAX_BYTES = 16;
  private ArrayList<Byte> line = new ArrayList<Byte>();
  private Long startAddress = 0L;
  
  //avoid use of this constructor
  private IntelHexWriter(Writer writer) {
    super(writer);
  }
  
  //avoid use of this constructor
  private IntelHexWriter(Writer writer, int length) {
    super(writer, length);
  }
  
  //constructor
  public IntelHexWriter(String fileName) throws IOException {
    super(new FileWriter(fileName));
  }
  
  public void close() throws IOException {
    flushLine();
    super.close();
  }
  
  public void write(Long address, ArrayList<Byte> bytes) throws IOException {
    if (bytes != null) {
      //start a new line if address does not follow current address 
      if (!address.equals(startAddress + line.size())) {
        flushLine();
        startAddress = address;
      }
      
      //add bytes to current line
      for (byte oneByte : bytes) {
        line.add(oneByte);
        if (line.size() == MAX_BYTES) {
          flushLine();
        }
      }
    }
  }
  
  //TODO : implement the actual Intel hex format.
  private void flushLine() throws IOException {
    if (line.size() > 0) {
      write(String.format("%04X", startAddress));
      startAddress += line.size();
      for (byte oneByte : line) {
        write(String.format("%02X", oneByte));
      }
      write("\n");
      line.clear();
    }
  }

}
