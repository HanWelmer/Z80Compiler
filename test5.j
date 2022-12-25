/*
 * A small program in the miniJava language.
 * Test comparisons
 */
class TestIf {
  write (134);
  /************************/
  // global variable within if scope
  byte b = 133;
  if (b>132) {
    int j = 1001;
    byte c = b;
    byte d = c;
    b--;
    write (c);
  } else {
    write(0);
  }
  /************************/
  int zero = 0;
  int one = 1;
  int three = 3;
  int four = 4;
  int five = 5;
  int twelve = 12;
  byte byteOne = 1;
  byte byteSix = 262;
  if (4 == zero + twelve/(1+2)) write(132);
  if (four == 0 + 12/(one + 2)) write(131);
  if (four == 0 + 12/(byteOne + 2)) write(130);
  if (four == 0 + 12/(1 + 2)) write(129);
  if (four == 0 + 12/(1 + 2)) write(128);
  //stack level 2
  if (5 >= twelve/(one+2)) write(127);
  if (4 >= twelve/(one+2)) write(126);
  if (4 <= twelve/(one+2)) write(125);
  if (3 <= twelve/(one+2)) write(124);
  if (5 > twelve/(one+2)) write(123);
  if (2 < twelve/(one+2)) write(122);
  if (3 != twelve/(one+2)) write(121);
  if (4 == twelve/(one+2)) write(120);
  if (5 >= 12/(1+2)) write(119);
  if (4 >= 12/(1+2)) write(118);
  if (4 <= 12/(1+2)) write(117);
  if (3 <= 12/(1+2)) write(116);
  if (5 > 12/(1+2)) write(115);
  if (3 < 12/(1+2)) write(114);
  if (3 != 12/(1+2)) write(113);
  if (4 == 12/(1+2)) write(112);
  if (1+4 >= twelve/(one+2)) write(111);
  if (1+3 >= twelve/(one+2)) write(110);
  if (1+3 <= twelve/(one+2)) write(109);
  if (1+2 <= twelve/(one+2)) write(108);
  if (1+4 > twelve/(one+2)) write(107);
  if (1+2 < twelve/(one+2)) write(106);
  if (1+2 != twelve/(one+2)) write(105);
  if (1+3 == twelve/(one+2)) write(104);
  if (1+4 >= 12/(1+2)) write(103);
  if (1+3 >= 12/(1+2)) write(102);
  if (1+3 <= 12/(1+2)) write(101);
  if (1+2 <= 12/(1+2)) write(100);
  if (1+4 > 12/(1+2)) write(99);
  if (1+2 < 12/(1+2)) write(98);
  if (1+2 != 12/(1+2)) write(97);
  if (1+3 == 12/(1+2)) write(96);
  if (twelve >= twelve/(one+2)) write(95);
  if (four >= twelve/(one+2)) write(94);
  if (three <= twelve/(one+2)) write(93);
  if (four <= twelve/(one+2)) write(92);
  if (twelve > twelve/(one+2)) write(91);
  if (three < twelve/(one+2)) write(90);
  if (three != twelve/(one+2)) write(89);
  if (four == twelve/(one+2)) write(88);
  if (twelve >= 12/(1+2)) write(87);
  if (four >= 12/(1+2)) write(86);
  if (three <= 12/(1+2)) write(85);
  if (four <= 12/(1+2)) write(84);
  if (twelve > 12/(1+2)) write(83);
  if (three < 12/(1+2)) write(82);
  if (three != 12/(1+2)) write(81);
  if (four == 12/(1+2)) write(80);
  if (one+four >= twelve/(one+2)) write(79);
  if (one+three >= twelve/(one+2)) write(78);
  if (one+three <= twelve/(one+2)) write(77);
  if (one+one <= twelve/(one+2)) write(76);
  if (one+four > twelve/(one+2)) write(75);
  if (one+one < twelve/(one+2)) write(74);
  if (one+four  != twelve/(one+2)) write(73);
  if (one+three == twelve/(one+2)) write(72);
  if (one+four >= 12/(1+2)) write(71);
  if (one+three >= 12/(1+2)) write(70);
  if (one+three <= 12/(1+2)) write(69);
  if (one+one <= 12/(1+2)) write(68);
  if (one+four > 12/(1+2)) write(67);
  if (one+one < 12/(1+2)) write(66);
  if (one+four  != 12/(1+2)) write(65);
  if (one+three == 12/(1+2)) write(64);
  //stack level 1
  //integer-byte
  if (four >= 4) write(63);
  if (four >= 12/(1+2)) write(62);
  if (five >= 4) write(61);
  if (five >= 12/(1+2)) write(60);
  if (four <= 4) write(59);
  if (four <= 12/(1+2)) write(58);
  if (three <= 4) write(57);
  if (three <= 12/(1+2)) write(56);
  if (five > 4) write(55);
  if (five > 12/(1+2)) write(54);
  if (three < 4) write(53);
  if (three < 12/(1+2)) write(52);
  if (three != 4) write(51);
  if (three != 12/(1+2)) write(50);
  if (four == 4) write(49);
  if (four == 12/(1+2)) write(48);
  //byte-integer
  if (4 >= four) write(47);
  if (4 >= twelve/(1+2)) write(46);
  if (5 >= four) write(45);
  if (5 >= twelve/(1+2)) write(44);
  if (4 <= four) write(43);
  if (4 <= twelve/(1+2)) write(42);
  if (3 <= four) write(41);
  if (3 <= twelve/(1+2)) write(40);
  if (5 > four) write(39);
  if (5 > twelve/(1+2)) write(38);
  if (3 < four) write(37);
  if (3 < twelve/(1+2)) write(36);
  if (3 != four) write(35);
  if (3 != twelve/(1+2)) write(34);
  if (4 == four) write(33);
  if (4 == twelve/(1+2)) write(32);
  //integer-integer
  if (400 >= 400) write(31);
  if (400 >= 1200/(1+2)) write(30);
  if (500 >= 400) write(29);
  if (500 >= 1200/(1+2)) write(28);
  if (400 <= 400) write(27);
  if (400 <= 1200/(1+2)) write(26);
  if (300 <= 400) write(25);
  if (300 <= 1200/(1+2)) write(24);
  if (500 > 400) write(23);
  if (500 > 1200/(1+2)) write(22);
  if (300 < 400) write(21);
  if (300 < 1200/(1+2)) write(20);
  if (300 != 400) write(19);
  if (300 != 1200/(1+2)) write(18);
  if (400 == 400) write(17);
  if (400 == 1200/(1+2)) write(16);
  //byte-byte
  if (4 >= 4) write(15);
  if (4 >= 12/(1+2)) write(14);
  if (5 >= 4) write(13);
  if (5 >= 12/(1+2)) write(12);
  if (4 <= 4) write(11);
  if (4 <= 12/(1+2)) write(10);
  if (3 <= 4) write(9);
  if (3 <= 12/(1+2)) write(8);
  if (5 > 4) write(7);
  if (5 > 12/(1+2)) write(6);
  if (3 < 4) write(5);
  if (3 < 12/(1+2)) write(4);
  if (3 != 4) write(3);
  if (3 != 12/(1+2)) write(2);
  if (4 == 4) write(1);
  if (4 == 12/(1+2)) write(0);
}
//comment after final }.
