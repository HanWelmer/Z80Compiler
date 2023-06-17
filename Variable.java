import java.util.HashMap;
import java.util.Map;

public class Variable {

  private String name;
  private Datatype datatype;
  private boolean isFinal = false;
  private int intValue = 0;
  private int address;

  //constructor
  public Variable(String name) {
    this.name = name;
    this.address = 0;
  }
  
  public String getName() {
    return name;
  }
  
  public void setDatatype(Datatype datatype) {
    this.datatype = datatype;
  }
  
  public Datatype getDatatype() {
    return datatype;
  }
  
  public void setFinal(boolean isFinal) {
    this.isFinal = isFinal;
  }
  
  public boolean isFinal() {
    return isFinal;
  }
  
  public void setIntValue(int intValue) {
    this.intValue = intValue;
  }
  
  public int getIntValue() {
    return intValue;
  }
  
  public void setAddress(int address) {
    this.address = address;
  }
  
  public int getAddress() {
    return address;
  }
  
  public String toString() {
    String result = "var(" + name + ", datatype=" + datatype;
    result += ", isFinal=" + isFinal;
    result += ", intValue=" + intValue;
    result += ", address=" + address;
    result += ")";
    return result;
  }
  
}
