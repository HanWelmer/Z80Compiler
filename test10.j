/* Program to test generated Z80 assembler code */
class TestDo {
  byte a = 2;
  do {
    int i = 1;
    write(a);
    a = a - i;
  } while (a > 1);
  write(0);
}