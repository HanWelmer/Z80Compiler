/**
 * This class defines the fatal exception thrown within the compiler of the P language. 
 * Used in lexical analysis, semantic analysis and code generation phases of the compiler.
 */
public class FatalError extends Exception {
   private int errorNumber;
   
   public FatalError(int error) {
    super();
    errorNumber = error;
  }
   
   public int getErrorNumber() {
      return errorNumber;
   }
};

