/* Program to test generated Z80 assembler code */
class TestWhile {
  write(14);
  int b = 13;
  write(b);
  //start a new scope
  byte p = 12;
  while (p > 11) {
    int test = 1;
    write(p);
    p = p - 1;
  }
  //start a new scope
  while (p > 9) {
    int test = 2;
    write(p);
    p = p - 1;
  }
  byte a = 9;
  while (a >= 7) {
    write(a);
    a = a - 1;
  }
  do {
    int test = 1;
    write(a);
    a = a - 1;
  } while (a > 5);
  for(byte i = 3; i<=4; i++) {
    int test = 1;
    write(a);
    a--;
  }
  for(int i = 3; i!=0; i--) {
    int test = 1;
    write(i);
    a--;
  }
  write(a);
}