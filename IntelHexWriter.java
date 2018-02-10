import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;

public class IntelHexWriter extends BufferedWriter {
  
  /* This class writes output in Intel-HEX format.
   * 
   * In A record (line of text) consists of six fields that appear in order from left to right:
   * - Start code, one character, an ASCII colon ':'.
   * - Byte count, two hex digits, indicating the number of bytes (hex digit pairs) in the data field.
   *   The maximum byte count is 255 (0xFF). 16 (0x10) and 32 (0x20) are commonly used byte counts.
   * - Address, four hex digits, representing the 16-bit beginning memory address offset of the data.
   *   The physical address of the data is computed by adding this offset to a previously established 
   *   base address, thus allowing memory addressing beyond the 64 kilobyte limit of 16-bit addresses. 
   *   The base address, which defaults to zero, can be changed by various types of records. Base 
   *   addresses and address offsets are always expressed as big endian values.
   * - Record type (see record types below), two hex digits, 00 to 05, defining the meaning of the data field.
   * - Data, a sequence of n bytes of data, represented by 2n hex digits. Some records omit this field
   *   (in equals zero). The meaning and interpretation of data bytes depends on the application.
   * - Checksum, two hex digits, a computed value that can be used to verify the record has no errors.
   *   A record's checksum byte is the two's complement of the sum of all decoded byte values in the record 
   *   preceding the checksum. In other words, it is computed by summing all bytes, extracting the LSB of 
   *   the sum, inverting its bits and adding one.
   *   For example, in the case of the record :0300300002337A1E, the sum of the decoded byte values is 
   *   03 + 00 + 30 + 00 + 02 + 33 + 7A = E2. The two's complement of E2 is 1E, the last byte of the record.
   *   The validity of a record can be checked by computing the sum of all byte — including the record's
   *   checksum — and verifying that the LSB of the sum is zero.
   *
   * An Intel HEX record is terminated by one or more ASCII line termination characters so that each record 
   * appears alone on a text line. This enhances legibility by visually delimiting the records and it 
   * also provides padding between records that can be used to improve machine parsing efficiency.
   * Programs that create HEX records typically use line termination characters that conform to the 
   * conventions of their operating systems. For example, Linux programs use a single LF (line feed, 
   * hex value 0A) character to terminate lines, whereas Windows programs use a CR (carriage return, 
   * hex value 0D) followed by a LF.
   *
   * This class supports the I8HEX subset, which uses record types:
   * 00 Data	      Contains data and a 16-bit starting address for the data. The byte count 
                    specifies number of data bytes in the record. The example shown to the right 
                    has 0B (decimal 11) data bytes (61, 64, 64, 72, 65, 73, 73, 20, 67, 61, 70) 
                    located at consecutive addresses beginning at address 0010.
                    Example: :0B0010006164647265737320676170A7
   * 01 End Of File	Must occur exactly once per file in the last line of the file. The data field 
                    is empty (thus byte count is 00) and the address field is typically 0000.
                    Example: :00000001FF
   *
   * This file example has four data records followed by an end-of-file record:
   * Start code   Byte count   Address   Record type   Data   Checksum
   * :10010000214601360121470136007EFE09D2190140
   * :100110002146017E17C20001FF5F16002148011928
   * :10012000194E79234623965778239EDA3F01B2CAA7
   * :100130003F0156702B5E712B722B732146013421C7
   * :00000001FF
   */
  
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
    write(":00000001FF\n");
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
  
  private void flushLine() throws IOException {
    /*
     * Intel hex record format:
     * - Start code  1 character :
     * - Byte count  1 byte
     * - Address     2 bytes, MSB first
     * - Record type 00 = data record
     * - Data        n bytes
     * - Checksum    1 byte, 2-s complement of sum of all preceding bytes in the record
     * Example:
     * :10200000CD0300E5CD0600CD0300220040210200F3
     */
    if (line.size() > 0) {
      write(String.format(":%02X%04X00", line.size(), startAddress));
      int msb = (int) (startAddress / 256);
      int lsb = (int) (startAddress % 256);
      int sum = line.size() + msb + lsb;
      if (sum >= 256) sum = sum % 256; 
      startAddress += line.size();
      for (byte oneByte : line) {
        write(String.format("%02X", oneByte));
        sum += oneByte;
        if (sum >= 256) sum -= 256;
      }
      write(String.format("%02X\n", (256 - sum) % 256));
      line.clear();
    }
  }

}
