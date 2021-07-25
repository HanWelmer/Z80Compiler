/*
 * A small program in the miniJava language.
 * Test comparisons
 */
class TestIf {
  //integer-integer
  if (400 >= 400) write(31);
  if (400 >= (1200/(1+2))) write(30);
  if (500 >= 400) write(29);
  if (500 >= (1200/(1+2))) write(28);
  if (400 <= 400) write(27);
  if (400 <= (1200/(1+2))) write(26);
  if (300 <= 400) write(25);
  if (300 <= (1200/(1+2))) write(24);
  if (500 > 400) write(23);
  if (500 > (1200/(1+2))) write(22);
  if (300 < 400) write(21);
  if (300 < (1200/(1+2))) write(20);
  if (300 != 400) write(19);
  if (300 != (1200/(1+2))) write(18);
  if (400 == 400) write(17);
  if (400 == (1200/(1+2))) write(16);
  //byte-byte
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
//comment after final }.
