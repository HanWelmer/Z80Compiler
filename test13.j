/* Program to test generated Z80 assembler code */
class TestOutputInput {

  println(0);
  
  // Possible operand types: constant, acc, var, stack8.
  
  //constant + decimal constant
  output(2, 1);
  println(3);

  //final variable + hexadecimal constant
  final byte port = 0x05;
  output(port, 0x04);
  println(6);

  println("Klaar");
}