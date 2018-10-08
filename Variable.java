import java.util.HashMap;
import java.util.Map;

public class Variable {

  /* variables: -1: not declared; >=0: memory address allocated */
  private String name;
  private Datatype datatype;
  private Integer address = -1;

  //constructor
  public Variable(String name, Datatype datatype, Integer address) {
    this.name = name;
    this.datatype = datatype;
    this.address = address;
  }
  
  public void setDatatype(Datatype datatype) {
    this.datatype = datatype;
  }
  
  public Datatype getDatatype() {
    return datatype;
  }
  
  public void setAddress(Integer address) {
    this.address = address;
  }
  
  public Integer getAddress() {
    return address;
  }
  
}
