import java.util.HashMap;
import java.util.Map;

public class Identifiers {

  /* Constants and class member variables for semantic analysis phase */
  private Map<String, Variable> variables = new HashMap<String, Variable>();
  private int nextAddress = 0;

  /**
   * Initialize the table with identifiers.
   * Method is used during semantic analysis phase.
   */
  public void init() {
    variables.clear();
    nextAddress = 0;
  }
  
  private void debug(String message) {
    //System.out.println(message);
  }

  /**
   * Declare an identifier.
   * Method is used during semantic analysis phase.
   * Param identifier : for this an indentifier will be declared.
   * Param datatype : datatype of variable.
   * Returns : true if OK; false if such an identifier already declared.
   */
  public void declareId(String identifier, Datatype datatype) {
    //make sure the variable is declared.
    debug("\ndeclareId() calling checkId(");
    checkId(identifier);

    //If it wasn't declared yet, override default datatype and set other properties.
    Variable var = variables.get(identifier);
    if (var.getDatatype() == Datatype._unknown) {
      debug(String.format("declareId() overriding default datatype and other properties."));
      var.setDatatype(datatype);
      var.setAddress(nextAddress);
      nextAddress += datatype.getSize();
    }
  }
  
  /**
   * Check if an identifier with that value has already been declared.
   * Method is used during semantic analysis phase.
   * Param: identifier : check if an identifier with this value already exists.
   * Returns : true if declared; false if not declared.
   */
  public boolean checkId(String identifier) {
    if (variables.containsKey(identifier)) {
      debug(String.format("\ncheckId(" + identifier + ") returns true."));
      return true;
    }
    
    variables.put(identifier, new Variable(identifier));
    debug(String.format("\ncheckId(" + identifier + ") returns false."));
    return false;
  }

  /**
   * Undeclare an identifier.
   * Param: identifier : this identifier will be removed from the list of declared identifiers.
   */
  public void remove(String variable) {
    variables.remove(variable);
    //TODO reallocate memory address.
  }

  /**
   * Get the memory address of a variable.
   * Method is used during semantic analysis phase.
   * Param: name : name of the variable for which its address is sought.
   * Returns : null if no variable with that name is not found; -1 if a variable with that name is used but not yet declared; integer >= 0 if variable with that name has been declared.
   */
  public Variable getId(String name) {
    return variables.get(name);
  }
}
