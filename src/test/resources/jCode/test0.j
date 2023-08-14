/* Program to test generated Z80 assembler code */
class TestPrint {
  word i = 1;
  byte b = 2;
  println(0);
  println(i);
  println(b);
  println("Hallo" + " wereld.");
  println("Nog" + " een" + " bericht.");
  println("3 + 2 = " + 5);
  println("3 + 3 = " + (2 * 3));
  println("3 + 4 = " + (2 + 5) + ".");
  println("Klaar.");
}