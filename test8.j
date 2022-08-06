/*
 * A small program in the miniJava language.
 * Test 8-bit and 16-bit expressions.
 */
class Test8And16BitExpressions {
  /*************************/
  /* reverse subtract byte */
  /*************************/
  write(10 - 3*3);         // 1
  byte b = 11;
  write(b - 3*3);          // 2
  byte c = 3;
  byte d = 3;
  write(12 - c*d);         // 3
  b = 13;
  write(b - c*d);          // 4

  /*************************/
  /* reverse subtract int  */
  /*************************/
  write(1005 - 1000*1);    // 5
  int i = 1006;
  write(i - 1000*1);       // 6
  int j = 1000;
  int k = 1;
  write(1007 - j*k);       // 7
  i = 1008;
  write(i - j*k);          // 8

  /***********************/
  /* reverse divide byte */
  /***********************/
  write(36 / (4*1));     // 9
  b = 40;
  write(b / (4*1));      // 10
  c = 4;
  d = 1;
  write(44 / (c*d));     // 11
  b = 48;
  write(b / (c*d));      // 12

  /***********************/
  /* reverse divide int  */
  /***********************/
  write(3900 / (300*1)); // 13
  i = 4200;
  write(i / (300*1));    // 14
  j = 300;
  k = 1;
  write(4500 / (j*k));   // 15
  i = 4800;
  write(i / (j*k));      // 16

  /**************************/
  /* reverse subtract mixed */
  /**************************/
  i = 21;
  c = 4;
  d = 1;
  write(i - c*d);           // 17
  b = 22;
  j = 4;
  k = 1;
  write(b - j*k);           // 18

  /**************************/
  /* reverse divide mixed   */
  /**************************/

  /**************************/
  /* forward divide mixed   */
  /**************************/
  i = 19;
  write(i / (1+0));         // 19
  
  write(i + 1);             // 20
  write(2 + i);             // 21
}
