/**
 * This class defines the instructions  
 * Used in the code generation phase of the compiler.known by the M machine as generated by the P language.
 */
public enum FunctionType {
  //special instructions:
  stringConstant("stringConstant"),
  comment(";"),
  stop("stop"),
  call("call"),
  //Input and output instructions:
  output("output"),
  input("input"),
  read("read"),
  writeAcc16("writeAcc16"),
  writeAcc8("writeAcc8"),
  writeString("writeString"),
  writeLineAcc16("writeLineAcc16"),
  writeLineAcc8("writeLineAcc8"),
  writeLineString("writeLineString"),
  //16-bit instructions:
  acc16Store("acc16=>"),
  acc16Load("acc16="),
  stackAcc16Load("<acc16="),
  acc16Plus("acc16+"),
  acc16Minus("acc16-"),
  minusAcc16("-acc16"),
  acc16Compare("acc16Comp"), //normal compare
  revAcc16Compare ("revAcc16Comp"), //reverse compare
  acc16CompareAcc8("acc16CompareAcc8"), //normal compare
  acc16Times("acc16*"),
  acc16Div("acc16/"),
  divAcc16("/acc16"),
  increment16("incr16"),
  decrement16("decr16"),
  //8-bit instructions:
  acc8Store("acc8=>"),
  acc8Load("acc8="),
  stackAcc8Load("<acc8="),
  acc8Plus("acc8+"),
  acc8Minus("acc8-"),
  minusAcc8("-acc8"),
  acc8Compare("acc8Comp"),  //normal compare
  revAcc8Compare("revAcc8Comp"), //reverse compare
  acc8CompareAcc16("acc8CompareAcc16"), //reverse compare
  acc8Times("acc8*"),
  acc8Div("acc8/"),
  divAcc8("/acc8"),
  increment8("incr8"),
  decrement8("decr8"),
  //16/8-bit conversion:
  acc16ToAcc8("acc16ToAcc8"),
  acc8ToAcc16("acc8ToAcc16"),
  stackAcc16ToAcc8("<acc16ToAcc8"),
  stackAcc8ToAcc16("<acc8ToAcc16"),
  //stack instructions:
  stackAcc16("<acc16"),
  stackAcc8("<acc8"),
  unstackAcc16("acc16= unstack16"),
  unstackAcc8("acc8= unstack8"),
  //branch instructions:
  br("br"),
  brEq("breq"),
  brNe("brne"),
  brLt("brlt"),
  brLe("brle"),
  brGt("brgt"),
  brGe("brge");
  
  private String value;

  private FunctionType (String value) {
    this.value = value;
  }
  
  public String getValue() {
    return value;
  }
};
