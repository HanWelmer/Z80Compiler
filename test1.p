/* Program to test generated Z80 assembler code */
class TestWhile {
  write(11);
  int b = 10;
  write(b);
  byte a = 9;
  while (a >= 7) {
    write(a);
    a = a - 1;
  }
  do {
    write(a);
    a = a - 1;
  } while (a > 5);
  for(int i = 3; i<=4; i++) {
    write(a);
    a--;
  }
  for(int i = 2; i!=0; i--) {
    write(i);
    a--;
  }
  write(a);
}