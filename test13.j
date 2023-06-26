/* Program to test generated Z80 assembler code for output and input statements*/
class TestOutputInput {

  println(0);

  // Possible port operand types:  constant, final var.
  // Possible value operand types: constant, acc, var, final var, stack8.

  /**********/
  /* Output */
  /**********/

  //port as decimal constant + value as decimal constant
  output(2, 1);
  println(3);

  //port as decimal constant
  println("Enter 5");
  byte value = input(4);
  //IN0     A,(4)
  println(value);
  println(6);

  //port as final variable + value as hexadecimal constant
  final byte port = 0x08;
  output(port, 0x07);
  println(9);

  /*

  //port as decimal constant + value as acc8
  println("Enter 12");
  output(11, input(10));
  println(13);

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