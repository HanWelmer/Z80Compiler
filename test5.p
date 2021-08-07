/*
 * A small program in the miniJava language.
 * Test comparisons
 */
class TestIf {
  int three = 3;
  int four = 4;
  int five = 5;
  int twelve = 12;
  //byte-integer
  /*
  if (4 >= four) write(63);
  if (4 >= (twelve/(1+2))) write(62);
  if (5 >= four) write(61);
  if (5 >= (twelve/(1+2))) write(60);
  if (4 <= four) write(59);
  if (4 <= (twelve/(1+2))) write(58);
  if (3 <= four) write(57);
  if (3 <= (twelve/(1+2))) write(56);
  if (5 > four) write(55);
  if (5 > (twelve/(1+2))) write(54);
  if (3 < four) write(53);
  if (3 < (twelve/(1+2))) write(52);
  if (3 != four) write(51);
  if (3 != (twelve/(1+2))) write(50);
  */
  if (4 == four) write(49);
  if (4 == (twelve/(1+2))) write(48);
  //integer-byte
  if (four >= 4) write(47);
  if (four >= (12/(1+2))) write(46);
  if (five >= 4) write(45);
  if (five >= (12/(1+2))) write(44);
  if (four <= 4) write(43);
  if (four <= (12/(1+2))) write(42);
  if (three <= 4) write(41);
  if (three <= (12/(1+2))) write(40);
  if (five > 4) write(39);
  if (five > (12/(1+2))) write(38);
  if (three < 4) write(37);
  if (three < (12/(1+2))) write(36);
  if (three != 4) write(35);
  if (three != (12/(1+2))) write(34);
  if (four == 4) write(33);
  if (four == (12/(1+2))) write(32);
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
