import java.util.HashMap;
//import java.util.Iterator;
import java.util.Map;
//import java.util.Stack;

public class Scope {

  /* Constants and class member variables for semantic analysis phase */
  private Map<String, Variable> variables = new HashMap<String, Variable>();
  private int nextAddress = 0;

  public int getAddress() {
    return nextAddress;
  }
  
  public void setAddress(int address) {
    this.nextAddress = address;
  }
  
  public Variable getVariable(String name) {
    return variables.get(name);
  }
  
  public void addVariable(String name) {
    variables.put(name, new Variable(name));
  }
}
