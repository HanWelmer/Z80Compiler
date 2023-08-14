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
  if (4 == 12/(1+2)) println(0);
  if (4 == 4) println(1);
  if (3 != 12/(1+2)) println(2);
  if (3 != 4) println(3);
  if (3 < 12/(1+2)) println(4);
  if (3 < 4) println(5);
  if (5 > 12/(1+2)) println(6);
  if (5 > 4) println(7);
  if (3 <= 12/(1+2)) println(8);
  if (3 <= 4) println(9);
  if (4 <= 12/(1+2)) println(10);
  if (4 <= 4) println(11);
  if (5 >= 12/(1+2)) println(12);
  if (5 >= 4) println(13);
  if (4 >= 12/(1+2)) println(14);
  if (4 >= 4) println(15);
  //stack level 1
  //byte-integer
  if (4 == twelve/(1+2)) println(16);
  if (4 == four) println(17);
  if (3 != twelve/(1+2)) println(18);
  if (3 != four) println(19);
  if (3 < twelve/(1+2)) println(20);
  if (3 < four) println(21);
  if (5 > twelve/(1+2)) println(22);
  if (5 > four) println(23);
  if (3 <= twelve/(1+2)) println(24);
  if (3 <= four) println(25);
  if (4 <= twelve/(1+2)) println(26);
  if (4 <= four) println(27);
  if (5 >= twelve/(1+2)) println(28);
  if (5 >= four) println(29);
  if (4 >= twelve/(1+2)) println(30);
  if (4 >= four) println(31);
  //stack level 1
  //integer-byte
  if (four == 12/(1+2)) println(32);
  if (four == 4) println(33);
  if (three != 12/(1+2)) println(34);
  if (three != 4) println(35);
  if (three < 12/(1+2)) println(36);
  if (three < 4) println(37);
  if (five > 12/(1+2)) println(38);
  if (five > 4) println(39);
  if (three <= 12/(1+2)) println(40);
  if (three <= 4) println(41);
  if (four <= 12/(1+2)) println(42);
  if (four <= 4) println(43);
  if (five >= 12/(1+2)) println(44);
  if (five >= 4) println(45);
  if (four >= 12/(1+2)) println(46);
  if (four >= 4) println(47);
  //stack level 1
  //integer-integer
  if (400 == 1200/(1+2)) println(48);
  if (400 == 400) println(49);
  if (300 != 1200/(1+2)) println(50);
  if (300 != 400) println(51);
  if (300 < 1200/(1+2)) println(52);
  if (300 < 400) println(53);
  if (500 > 1200/(1+2)) println(54);
  if (500 > 400) println(55);
  if (300 <= 1200/(1+2)) println(56);
  if (300 <= 400) println(57);
  if (400 <= 1200/(1+2)) println(58);
  if (400 <= 400) println(59);
  if (500 >= 1200/(1+2)) println(60);
  if (500 >= 400) println(61);
  if (400 >= 1200/(1+2)) println(62);
  if (400 >= 400) println(63);

  //stack level 2
  if (one+three == 12/(1+2)) println(64);
  if (one+four  != 12/(1+2)) println(65);
  if (one+one < 12/(1+2)) println(66);
  if (one+four > 12/(1+2)) println(67);
  if (one+one <= 12/(1+2)) println(68);
  if (one+three <= 12/(1+2)) println(69);
  if (one+three >= 12/(1+2)) println(70);
  if (one+four >= 12/(1+2)) println(71);
  if (one+three == twelve/(one+2)) println(72);
  if (one+four  != twelve/(one+2)) println(73);
  if (one+one < twelve/(one+2)) println(74);
  if (one+four > twelve/(one+2)) println(75);
  if (one+one <= twelve/(one+2)) println(76);
  if (one+three <= twelve/(one+2)) println(77);
  if (one+three >= twelve/(one+2)) println(78);
  if (one+four >= twelve/(one+2)) println(79);
  if (four == 12/(1+2)) println(80);
  if (three != 12/(1+2)) println(81);
  if (three < 12/(1+2)) println(82);
  if (twelve > 12/(1+2)) println(83);
  if (four <= 12/(1+2)) println(84);
  if (three <= 12/(1+2)) println(85);
  if (four >= 12/(1+2)) println(86);
  if (twelve >= 12/(1+2)) println(87);
  if (four == twelve/(one+2)) println(88);
  if (three != twelve/(one+2)) println(89);
  if (three < twelve/(one+2)) println(90);
  if (twelve > twelve/(one+2)) println(91);
  if (four <= twelve/(one+2)) println(92);
  if (three <= twelve/(one+2)) println(93);
  if (four >= twelve/(one+2)) println(94);
  if (twelve >= twelve/(one+2)) println(95);
  if (1+3 == 12/(1+2)) println(96);
  if (1+2 != 12/(1+2)) println(97);
  if (1+2 < 12/(1+2)) println(98);
  if (1+4 > 12/(1+2)) println(99);
  if (1+2 <= 12/(1+2)) println(100);
  if (1+3 <= 12/(1+2)) println(101);
  if (1+3 >= 12/(1+2)) println(102);
  if (1+4 >= 12/(1+2)) println(103);
  if (1+3 == twelve/(one+2)) println(104);
  if (1+2 != twelve/(one+2)) println(105);
  if (1+2 < twelve/(one+2)) println(106);
  if (1+4 > twelve/(one+2)) println(107);
  if (1+2 <= twelve/(one+2)) println(108);
  if (1+3 <= twelve/(one+2)) println(109);
  if (1+3 >= twelve/(one+2)) println(110);
  if (1+4 >= twelve/(one+2)) println(111);
  if (4 == 12/(1+2)) println(112);
  if (3 != 12/(1+2)) println(113);
  if (3 < 12/(1+2)) println(114);
  if (5 > 12/(1+2)) println(115);
  if (3 <= 12/(1+2)) println(116);
  if (4 <= 12/(1+2)) println(117);
  if (4 >= 12/(1+2)) println(118);
  if (5 >= 12/(1+2)) println(119);
  if (4 == twelve/(one+2)) println(120);
  if (3 != twelve/(one+2)) println(121);
  if (2 < twelve/(one+2)) println(122);
  if (5 > twelve/(one+2)) println(123);
  if (3 <= twelve/(one+2)) println(124);
  if (4 <= twelve/(one+2)) println(125);
  if (4 >= twelve/(one+2)) println(126);
  if (5 >= twelve/(one+2)) println(127);
  if (four == 0 + 12/(1 + 2)) println(128);
  if (four == 0 + 12/(1 + 2)) println(129);
  if (four == 0 + 12/(byteOne + 2)) println(130);
  if (four == 0 + 12/(one + 2)) println(131);
  if (4 == zero + twelve/(1+2)) println(132);

  /************************/
  // global variable within if scope
  byte b = 133;
  if (b>132) {
    word j = 1001;
    byte c = b;
    byte d = c;
    b--;
    println (c);
  } else {
    println(999);
  }

  /************************/
  println (134);
  println("Klaar");
}
//comment after final }.
