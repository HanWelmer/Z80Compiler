/* Program to test generated Z80 assembler code */
class TestWhile {
  int a = 9;
  while (a >= 7) {
    write(a);
    a = a - 1;
  }
  do {
    write(a);
    a = a - 1;
  } while (a > 5);
  for(int b = 4; b!=2; b--) {
    write(b);
  }
  a = 2;
  for(int b = 0; b<=2; b++) {
    write(a);
    a--;
  }
}