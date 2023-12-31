/* Program to test generated Z80 assembler code for output and input statements*/
class TestOutputInput {
  byte value;
  final static byte OUTPUT_PORT = 0x08;
  final static byte INPUT_PORT = 10;
  final static byte FINAL_VALUE = 20;
  public static void main() {
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
    value = input(4);
    println(value);
    println(6);
  
    //port as final variable + value as hexadecimal constant
    output(OUTPUT_PORT, 0x07);
    println(9);
  
    //port as final variable + value as acc8
    println("Enter 11");
    output(12, input(INPUT_PORT));
    println(13);
  
    //constant + byte expression
    output(15, 4 + 2 * 5);
    println(16);
   
    //constant + byte variable
    value = 17;
    output(0x12, value);
    println(19);
  
    //constant + final variable
    output(21, FINAL_VALUE);
    println(22);
    
    //TODO enable test on output() with port number as constant expression
    /*
    //byte constant expression + decimal constant
    output(4 * 5 + 4, 23);
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
}
