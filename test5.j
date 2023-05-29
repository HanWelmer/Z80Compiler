/*
 * A small program in the miniJava language.
 * Test comparisons
 */
class TestIf {
  word zero = 0;
  word one = 1;
  word three = 3;
  word four = 4;
  word five = 5;
  word twelve = 12;
  byte byteOne = 1;
  byte byteSix = 262;

  //stack level 1
  //byte-byte
  if (4 == 12/(1+2)) write(0);
  if (4 == 4) write(1);
  if (3 != 12/(1+2)) write(2);
  if (3 != 4) write(3);
  if (3 < 12/(1+2)) write(4);
  if (3 < 4) write(5);
  if (5 > 12/(1+2)) write(6);
  if (5 > 4) write(7);
  if (3 <= 12/(1+2)) write(8);
  if (3 <= 4) write(9);
  if (4 <= 12/(1+2)) write(10);
  if (4 <= 4) write(11);
  if (5 >= 12/(1+2)) write(12);
  if (5 >= 4) write(13);
  if (4 >= 12/(1+2)) write(14);
  if (4 >= 4) write(15);
  //stack level 1
  //byte-integer
  if (4 == twelve/(1+2)) write(16);
  if (4 == four) write(17);
  if (3 != twelve/(1+2)) write(18);
  if (3 != four) write(19);
  if (3 < twelve/(1+2)) write(20);
  if (3 < four) write(21);
  if (5 > twelve/(1+2)) write(22);
  if (5 > four) write(23);
  if (3 <= twelve/(1+2)) write(24);
  if (3 <= four) write(25);
  if (4 <= twelve/(1+2)) write(26);
  if (4 <= four) write(27);
  if (5 >= twelve/(1+2)) write(28);
  if (5 >= four) write(29);
  if (4 >= twelve/(1+2)) write(30);
  if (4 >= four) write(31);
  //stack level 1
  //integer-byte
  if (four == 12/(1+2)) write(32);
  if (four == 4) write(33);
  if (three != 12/(1+2)) write(34);
  if (three != 4) write(35);
  if (three < 12/(1+2)) write(36);
  if (three < 4) write(37);
  if (five > 12/(1+2)) write(38);
  if (five > 4) write(39);
  if (three <= 12/(1+2)) write(40);
  if (three <= 4) write(41);
  if (four <= 12/(1+2)) write(42);
  if (four <= 4) write(43);
  if (five >= 12/(1+2)) write(44);
  if (five >= 4) write(45);
  if (four >= 12/(1+2)) write(46);
  if (four >= 4) write(47);
  //stack level 1
  //integer-integer
  if (400 == 1200/(1+2)) write(48);
  if (400 == 400) write(49);
  if (300 != 1200/(1+2)) write(50);
  if (300 != 400) write(51);
  if (300 < 1200/(1+2)) write(52);
  if (300 < 400) write(53);
  if (500 > 1200/(1+2)) write(54);
  if (500 > 400) write(55);
  if (300 <= 1200/(1+2)) write(56);
  if (300 <= 400) write(57);
  if (400 <= 1200/(1+2)) write(58);
  if (400 <= 400) write(59);
  if (500 >= 1200/(1+2)) write(60);
  if (500 >= 400) write(61);
  if (400 >= 1200/(1+2)) write(62);
  if (400 >= 400) write(63);

  //stack level 2
  if (one+three == 12/(1+2)) write(64);
  if (one+four  != 12/(1+2)) write(65);
  if (one+one < 12/(1+2)) write(66);
  if (one+four > 12/(1+2)) write(67);
  if (one+one <= 12/(1+2)) write(68);
  if (one+three <= 12/(1+2)) write(69);
  if (one+three >= 12/(1+2)) write(70);
  if (one+four >= 12/(1+2)) write(71);
  if (one+three == twelve/(one+2)) write(72);
  if (one+four  != twelve/(one+2)) write(73);
  if (one+one < twelve/(one+2)) write(74);
  if (one+four > twelve/(one+2)) write(75);
  if (one+one <= twelve/(one+2)) write(76);
  if (one+three <= twelve/(one+2)) write(77);
  if (one+three >= twelve/(one+2)) write(78);
  if (one+four >= twelve/(one+2)) write(79);
  if (four == 12/(1+2)) write(80);
  if (three != 12/(1+2)) write(81);
  if (three < 12/(1+2)) write(82);
  if (twelve > 12/(1+2)) write(83);
  if (four <= 12/(1+2)) write(84);
  if (three <= 12/(1+2)) write(85);
  if (four >= 12/(1+2)) write(86);
  if (twelve >= 12/(1+2)) write(87);
  if (four == twelve/(one+2)) write(88);
  if (three != twelve/(one+2)) write(89);
  if (three < twelve/(one+2)) write(90);
  if (twelve > twelve/(one+2)) write(91);
  if (four <= twelve/(one+2)) write(92);
  if (three <= twelve/(one+2)) write(93);
  if (four >= twelve/(one+2)) write(94);
  if (twelve >= twelve/(one+2)) write(95);
  if (1+3 == 12/(1+2)) write(96);
  if (1+2 != 12/(1+2)) write(97);
  if (1+2 < 12/(1+2)) write(98);
  if (1+4 > 12/(1+2)) write(99);
  if (1+2 <= 12/(1+2)) write(100);
  if (1+3 <= 12/(1+2)) write(101);
  if (1+3 >= 12/(1+2)) write(102);
  if (1+4 >= 12/(1+2)) write(103);
  if (1+3 == twelve/(one+2)) write(104);
  if (1+2 != twelve/(one+2)) write(105);
  if (1+2 < twelve/(one+2)) write(106);
  if (1+4 > twelve/(one+2)) write(107);
  if (1+2 <= twelve/(one+2)) write(108);
  if (1+3 <= twelve/(one+2)) write(109);
  if (1+3 >= twelve/(one+2)) write(110);
  if (1+4 >= twelve/(one+2)) write(111);
  if (4 == 12/(1+2)) write(112);
  if (3 != 12/(1+2)) write(113);
  if (3 < 12/(1+2)) write(114);
  if (5 > 12/(1+2)) write(115);
  if (3 <= 12/(1+2)) write(116);
  if (4 <= 12/(1+2)) write(117);
  if (4 >= 12/(1+2)) write(118);
  if (5 >= 12/(1+2)) write(119);
  if (4 == twelve/(one+2)) write(120);
  if (3 != twelve/(one+2)) write(121);
  if (2 < twelve/(one+2)) write(122);
  if (5 > twelve/(one+2)) write(123);
  if (3 <= twelve/(one+2)) write(124);
  if (4 <= twelve/(one+2)) write(125);
  if (4 >= twelve/(one+2)) write(126);
  if (5 >= twelve/(one+2)) write(127);
  if (four == 0 + 12/(1 + 2)) write(128);
  if (four == 0 + 12/(1 + 2)) write(129);
  if (four == 0 + 12/(byteOne + 2)) write(130);
  if (four == 0 + 12/(one + 2)) write(131);
  if (4 == zero + twelve/(1+2)) write(132);

  /************************/
  // global variable within if scope
  byte b = 133;
  if (b>132) {
    word j = 1001;
    byte c = b;
    byte d = c;
    b--;
    write (c);
  } else {
    write(999);
  }

  /************************/
  write (134);
  write("Klaar");
}
//comment after final }.
