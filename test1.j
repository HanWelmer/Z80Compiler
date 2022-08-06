/* Program to test generated Z80 assembler code */
class TestWhile {
  byte b = 6;
  int p = 1;
  while (b > 4) {
    int test = 1;
    write(b);
    b = b - p;
  }
  p = 4;
  while (p > 2) {
    int test = 2;
    write(p);
    p = p - 1;
  }
  byte a = 2;
  while (a >= 1) {
    write(a);
    a = a - 1;
  }
  write(0);
}