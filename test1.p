/* Program to test generated Z80 assembler code */
class TestWhile {
  int a := 9;
  while (a >= 0) {
    write(a);
    a := a - 1;
  }
}