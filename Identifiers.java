import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Stack;

public class Identifiers {

  /* Constants and class member variables for semantic analysis phase */
  private Stack<Map<String, Variable>> stackOfScopes = new Stack<>();
  //TODO: memory allocation per scope (stack level).
  private int nextAddress = 0;

  /**
   * Initialize the table with identifiers.
   * Method is used during semantic analysis phase.
   */
  public void init() {
    stackOfScopes.clear();
    nextAddress = 0;
  }
  
  private void debug(String message) {
    //System.out.println(message);
  }

  //Start a new declaration scope.
  public void newScope() {
    stackOfScopes.push(new HashMap<String, Variable>());
  }

  //Close the top level scope.
  public void closeScope() {
    //avoid a run-time error.
    if (stackOfScopes.size() > 0) {
      stackOfScopes.pop();
    }
  }

  /**
   * Get a variable by its name.
   * Method is used during semantic analysis phase.
   * Param: name : name of the variable for which its address is sought.
   * Returns : null if no variable with that name is not found; -1 if a variable with that name is used but not yet declared; integer >= 0 if variable with that name has been declared.
   */
  public Variable getId(String name) {
    Variable variable = null;
    Iterator<Map<String, Variable>> scopeIterator = stackOfScopes.iterator();
    while ((variable == null) && scopeIterator.hasNext()) {
      Map<String, Variable> variables = scopeIterator.next();
      variable = variables.get(name);
    }
    return variable;
  }
  
  /**
   * Check if an identifier with that value has already been declared.
   * Method is used during semantic analysis phase.
   * Param: identifier : check if an identifier with this value already exists.
   * Returns : true if declared; false if not declared.
   */
  public boolean checkId(String identifier) {
    boolean found = getId(identifier) != null;

    if (!found) {
      stackOfScopes.peek().put(identifier, new Variable(identifier));
    }
    debug(String.format("\ncheckId(" + identifier + ") returns " + found + "."));

    return found;
  }

  /**
   * Declare an identifier.
   * Method is used during semantic analysis phase.
   * Param identifier : for this an indentifier will be declared.
   * Param datatype : datatype of variable.
   * Returns : true if OK; false if such an identifier already declared.
   */
  public boolean declareId(Lexeme lexeme, LexemeType datatype) {
    boolean result = true;
    //make sure the variable is declared.
    debug("\ndeclareId() calling checkId(");
    checkId(lexeme.idVal);

    //If it wasn't declared yet, override default datatype and set other properties.
    Variable var = getId(lexeme.idVal);
    if (var.getDatatype() == Datatype._unknown) {
      debug(String.format("declareId() overriding default datatype and other properties."));
      if (datatype == LexemeType.bytelexeme) {
        var.setDatatype(Datatype._byte);
      } else if (datatype == LexemeType.intlexeme) {
        var.setDatatype(Datatype._integer);
      } else if (datatype == LexemeType.classlexeme) {
        var.setDatatype(Datatype._class);
      } else {
        result = false;
      }
      var.setAddress(nextAddress);
      nextAddress += var.getDatatype().getSize();
    }
    return result;
  }
}
