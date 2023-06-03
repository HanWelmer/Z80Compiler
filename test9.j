/* Program to test multiplication */
class TestMultiply {
  byte b = 9;
  word i = 6561;

  println(0);
  println(1);
  if (6561 > 9) println (2); else println (999);
  if (9 < 6561) println (3); else println (999);
  if (3 * 3 < 6561) println (4); else println (999);
  if (6561 > 3 * 3) println (5); else println (999);
  if (6561 * 1 > 9) println (6); else println (999);
  if (9 < 6561 * 1) println (7); else println (999);
  if (6561 * 1 > 3 * 3) println (8); else println (999);
  if (3 * 3 < 6561 * 1) println (9); else println (999);

  if (b < i) println (10); else println (999);
  if (i > b) println (11); else println (999);
  if (b < 6561 * 1) println (12); else println (999);
  if (i > 3 * 3) println (13); else println (999);
  if (6561 * 1 > b) println (14); else println (999);
  if (3 * 3 < i) println (15); else println (999);
  if (b < i * 1) println (16); else println (999);
  if (i > b * 1) println (17); else println (999);
  if (b * 1 < i) println (18); else println (999);
  if (i * 1 > b) println (19); else println (999);
  if (b * 1 < i * 1) println (20); else println (999);
  if (i * 1 > b * 1) println (21); else println (999);

  println("Klaar");
}