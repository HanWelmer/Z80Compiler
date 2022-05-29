/*
 * A small program in the miniJava language.
 * Test comparisons
 */
class TestIf {
  int zero = 0;
  int one = 1;
  int four = 4;
  int twelve = 12;
  byte byteOne = 1;
  write(6);
  /*
  if (4 == (zero + twelve/(1+2))) write(2);
  //gewenste code voor regel 26: if (four == (0 + 12/(one+2))) write(1);
  //                            acc8  acc16 F   stack
  // 44 acc16= variable 4       -     4         []
  // 45 <acc16                  0     4         [int4]
  // 46 acc8= constant 0        0     4         [int4]
  // 47 <acc8= constant 12      12    4         [int4, b0]
  // 48 acc16= variable 2       12    1         [int4, b0]
  // 49 acc16+ constant 2       12    3         [int4, b0]
  // 50 /acc16 acc8             12    4         [int4, b0]
  // 51 acc16+ unstack8         12    4         [int4]
  // 52 revAcc16Comp unstack16  12    4     Z   []
  // 53 brne 57
  */
  //if (four == (0 + 12/(one+2))) write(2);
  if (four == (0 + 12/(one + 2))) write(5);
  if (four == (0 + 12/(byteOne + 2))) write(4);
  if (four == (0 + 12/(1 + 2))) write(3);
  if (four == 0 + 12/(1 + 2)) write(2);
  write(one);
  write(zero);
}
