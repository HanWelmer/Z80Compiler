/* Program to test generated Z80 assembler code */
class TestPrint {
  word i = 1;
  byte b = 2;
  write(0);
  write(i);
  write(b);
  write("Hallo" + "Wereld.");
  write("Nog" + " een" + " bericht.");
  write("Klaar.");
}