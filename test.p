/*
 * A small program in the miniJava language.
 * Test comparisons
 */
class TestIf {
  write(16);
  if (4 >= 4) write(15);
  if (4 >= (12/(1+2))) write(14);
  if (5 >= 4) write(13);
  if (5 >= (12/(1+2))) write(12);
  if (4 <= 4) write(11);
  if (4 <= (12/(1+2))) write(10);
  if (3 <= 4) write(9);
  if (3 <= (12/(1+2))) write(8);
  if (5 > 4) write(7);
  if (5 > (12/(1+2))) write(6);
  if (3 < 4) write(5);
  if (3 < (12/(1+2))) write(4);
  if (3 != 4) write(3);
  if (3 != (12/(1+2))) write(2);
  if (4 == 4) write(1);
  if (4 == (12/(1+2))) write(0);
}
