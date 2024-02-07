/* Program to test generated Z80 assembler code */
class TestWhile {

  public static void main() {
    println(1);
    while (1==0) {
      ;
    }
    println(2);
    while (1==0) ;
    println(3);
    println("Klaar.");
  }
}