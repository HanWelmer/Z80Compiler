/*
 * A small program in the miniJava language.
 * Test comparisons
 */
class TestIf {
  int zero = 0;
  int one = 1;
  int four = 4;
  int twelve = 12;
  write(2);
  /*
  if (4 == (zero + twelve/(1+2))) write(2);
  //gewenste code voor regel 26: if (four == (0 + 12/(one+2))) write(1);
  //                            acc8  acc16 F   stack
  // 40 acc16= variable 4       -     4         []
  // 41 <acc16                  0     4         [int4]
  // 42 acc8= constant 0        0     4         [int4]
  // 43 <acc8= constant 12      12    4         [int4, b0]
  // 44 acc16= variable 2       12    1         [int4, b0]
  // 45 acc16+ constant 2       12    3         [int4, b0]
  // 46 /acc16 acc8             12    4         [int4, b0]
  // 47 acc16+ unstack8         12    4         [int4]
  // 48 revAcc16Comp unstack16  12    4     Z   []
  // 49 brne 53
  */
  if (four == (0 + 12/(one+2))) write(1);
  write(0);
}
