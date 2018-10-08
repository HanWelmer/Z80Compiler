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

  /**
   * Declare an identifier.
   * Method is used during semantic analysis phase.
   * Param identifier : for this an indentifier will be declared.
   * Param datatype : datatype of variable.
   * Returns : true if OK; false if such an identifier already declared.
   */
  public boolean declareId(String identifier, Datatype datatype) {
    Variable var = variables.get(identifier);
    if (var != null && var.getAddress() != null) {
      return false; // Variable already declared.
    }

    if (var != null ) {
      var.setAddress(nextAddress);
      var.setDatatype(datatype);
    } else {
      var = new Variable(identifier, datatype, nextAddress);
      variables.put(identifier, var);
      nextAddress++;
    }
    return true; // variable added
  }
  
  /**
   * Check if an identifier with that value has already been declared.
   * Method is used during semantic analysis phase.
   * Param: identifier : check if an identifier with this value already exists.
   * Returns : true if declared; false if not declared.
   */
  public boolean checkId(String identifier) {
    Variable var = variables.get(identifier);
    if (var == null) {
      // Prevent further error messages.
      var = new Variable(identifier, null, null);
      variables.put(identifier, var);
    }
    return var.getAddress() != null && var.getAddress() != -1;
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
  public Integer getId(String name) {
    Integer result = null;
    Variable var = variables.get(name);
    if (var != null) {
      result = var.getAddress();
    }
      
    return result;
  }
}
