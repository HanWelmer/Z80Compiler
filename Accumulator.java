/**
 * This class defines an accumulator.
 * Used during code generation to keep track of the contents of an accumulator.
 */
public class Accumulator {
  
  private boolean inUse = false;
  private Operand operand;
  
  public void clear() {
    inUse = false;
    operand = null;
  }

  public boolean inUse() {
    return this.inUse;
  }
  
  public Operand operand() {
    return this.operand;
  }

  public void setOperand(Operand value) {
    this.operand = value;
    inUse = true;
  }

};
