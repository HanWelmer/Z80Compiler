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
  } while (a > 6);
  for(int b = 5; b!=0; b--) {
    write(b);
  }
  write(0);
  for(int c = 0; c<=9; c++) {
    write(c);
  }
}