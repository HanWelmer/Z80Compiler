/* Program to test generated Z80 assembler code for output and input statements*/
class TestOutputInput {

  println(0);

  // Possible operand types: constant, acc, var, stack8.

  /**********/
  /* Output */
  /**********/

  //constant + decimal constant
  output(2, 1);
  println(3);

  //final variable + hexadecimal constant
  final byte port = 0x05;
  output(port, 0x04);
  println(6);

  /*
  // Possible port operand types:  constant, final var.
  // Possible value operand types: constant, acc, var, final var, stack8.
  
  //constant + decimal constant
  output(2, 1);
  println(3);

  //decimal constant
  println("Enter 4");
  byte value = input(5);
  //IN0     A,(5)
  println(value);
  println(6);

  println("Enter 7");
  output(2, input(8));
  println(9);

  //final variable + hexadecimal constant
  final byte port = 0x0A;
  output(port, 0x0B);
  println(12);

  println("Enter 13");
  output(0x0F, input(0xE));
  println(16);

  println("Enter 17");
  output(0x13, input(0x12));
  println(0x14);
  */

  //final variable + byte constant expression
  /*
  output(8, 3 + 2 * 2);
  println(9);
 
  //final variable + byte variable
  byte value = 10;
  output(0x0B, value);
  println(12);

  //byte constant expression + decimal constant
  output(2 * 5 + 4, 13);
  println(15);
  
  */

/*
  //hexadecimal constant
  //IN0     A,(0x13)
  println("Enter 16");
  value = input(0x0F);
  println(value);

  //byte constant expression
  println("Enter 18");
  value = input(7 + 5 * 2);
  println(value);

  //final variable
  //IN0     A,(0x13)
  port = 0x11;
  println("Enter 20");
  value = input(port);
  println(value);
*/

  println("Klaar");
}