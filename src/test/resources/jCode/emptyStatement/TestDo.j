/* Program to test generated Z80 assembler code */
class TestDo {

  public static void main() {
    println(1);
    do
    {
      ;
    }
    while (1==0);
    println(2);
    do
      ;
    while (1==0);
    println(3);
    println("Klaar.");
  }
}