/* Program to test generated Z80 assembler code */
class TestFor {
  for(byte b = 4; b>2; b--) {
    write(b);
  }
  for(int i = 2; i>0; i--) {
    write(i);
  }
  write(0);
}