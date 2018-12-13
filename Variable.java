import java.util.HashMap;
import java.util.Map;

public class Variable {

  private String name;
  private Datatype datatype;
  private int address;

  //constructor
  public Variable(String name) {
    this.name = name;
    this.datatype = Datatype.unknown;
    this.address = 0;
  }
  
  public void setDatatype(Datatype datatype) {
    this.datatype = datatype;
  }
  
  public Datatype getDatatype() {
    return datatype;
  }
  
  public void setAddress(int address) {
    this.address = address;
  }
  
  public int getAddress() {
    return address;
  }
  
}
