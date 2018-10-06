import java.util.HashMap;
import java.util.Map;

public class Identifiers {

  /* Constants and class member variables for semantic analysis phase */
  /* variables: -1: not declared, >=0: memory address allocated */
  private Map<String, Integer> variables = new HashMap<String, Integer>();
  private int address = 0;

  /**
   * Initialize the table with identifiers.
   * Method is used during semantic analysis phase.
   */
  public void init() {
    variables.clear();
    address = 0;
  }

  /**
   * Declare an identifier.
   * Method is used during semantic analysis phase.
   * Param: identifier : for this an indentifier will be declared.
   * Returns : true if OK; false if such an identifier already declared.
   */
  public boolean declareId(String identifier) {
    if (variables.get(identifier) != null) {
      return false; // Variable already declared.
    }

    variables.put(identifier, address);
    address++;
    return true; // OK.
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
   * Check if an identifier with that value has already been declared.
   * Method is used during semantic analysis phase.
   * Param: identifier : check if an identifier with this value already exists.
   * Returns : true if declared; false if not declared.
   */
  public boolean checkId(String identifier) {
    Integer varAddress = variables.get(identifier);
    if (varAddress == null) {
      // Prevent further error messages.
      variables.put(identifier, -1);
      varAddress = -1;
    }
    return varAddress != -1;
  }

  /**
   * Get the memory address of an identifier.
   * Method is used during semantic analysis phase.
   * Param: identifier : identifier for which its address is sought.
   * Returns : null if identifier is not found; -1 if identifier is used but not yet declared; integer >= 0 if identifier has been declared.
   */
  public Integer getId(String identifier) {
    return variables.get(identifier);
  }
}
