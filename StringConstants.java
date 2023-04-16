import java.util.ArrayList;

public class StringConstants {

  /* Constants and class member variables for semantic analysis phase */
  private ArrayList<String> stringConstants = new ArrayList<String>();

  /**
   * Initialize the table with stringConstants.
   * Method is used during semantic analysis phase.
   */
  public void init() {
    stringConstants.clear();
  }
  
  private void debug(String message) {
    System.out.println(message);
  }

  /**
   * Get a string constant by its id.
   * Method is used during semantic analysis phase.
   * Param: id : unique identifier of the string constant.
   * Returns : null if no string constant with that id is found; String with the string constant if a string constant with that id is found.
   */
  public String get(int id) {
    return stringConstants.get(id);
  }
  
  /**
   * Add a string constant to the table with string constants. Duplicate values are avoided.
   * Method is used during semantic analysis phase.
   * Param: value : value of the string constant.
   * Returns : id (int) as a unique identification of te string constant.
   */
  public int add(String value, int lineNumber) {
    // add new string constant to list of string constants.
    if (!stringConstants.contains(value)) {
      stringConstants.add(value);
    }
    return stringConstants.indexOf(value);
  }
  
  public int size() {
    return stringConstants.size();
  }
}
