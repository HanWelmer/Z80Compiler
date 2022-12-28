/* Program to test multiplication */
class TestMultiply {
  byte b = 9;
  word i = 6561;
  if (i * 1 > b * 1) write (21); else write (0);
  if (b * 1 < i * 1) write (20); else write (0);
  if (i * 1 > b) write (19); else write (0);
  if (b * 1 < i) write (18); else write (0);
  if (i > b * 1) write (17); else write (0);
  if (b < i * 1) write (16); else write (0);
  if (3 * 3 < i) write (15); else write (0);
  if (6561 * 1 > b) write (14); else write (0);
  if (i > 3 * 3) write (13); else write (0);
  if (b < 6561 * 1) write (12); else write (0);
  if (i > b) write (11); else write (0);
  if (b < i) write (10); else write (0);

  if (3 * 3 < 6561 * 1) write (9); else write (0);
  if (6561 * 1 > 3 * 3) write (8); else write (0);
  if (9 < 6561 * 1) write (7); else write (0);
  if (6561 * 1 > 9) write (6); else write (0);
  if (6561 > 3 * 3) write (5); else write (0);
  if (3 * 3 < 6561) write (4); else write (0);
  if (9 < 6561) write (3); else write (0);
  if (6561 > 9) write (2); else write (0);
  write(1);
  write(0);
}