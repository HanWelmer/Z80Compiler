/* Program to test branch instructions */
class TestBranches {
  word i = 2000;
  word i1 = 1000;
  word i3 = 3000;
  byte b = 20;
  byte b1 = 10;
  byte b3 = 30;

  /*Possible operand types: 
   * constant, acc, var, stack8, stack16
   *Possible datatype combinations:
   * byte - byte
   * byte - integer
   * integer - byte
   * integer - integer
  */

  println(0);

  /************************/
  // constant - constant
  // byte - byte
  if (1 == 1) println(1); else println(999);
  if (1 != 0) println(2); else println(999);
  if (1 >  0) println(3); else println(999);
  if (1 >= 0) println(4); else println(999);
  if (1 >= 1) println(5); else println(999);
  if (1 <  2) println(6); else println(999);
  if (1 <= 2) println(7); else println(999);
  if (1 <= 1) println(8); else println(999);
  println(9);

  // constant - constant
  // byte - integer
  if (1 == 1000) println(999); else println(10);
  if (1 != 1000) println(11);  else println(999);
  if (1 >  1000) println(999); else println(12);
  if (1 >= 1000) println(999); else println(13);
  if (1 >= 1000) println(999); else println(14);
  if (1 <  2000) println(15);  else println(999);
  if (1 <= 2000) println(16);  else println(999);
  if (1 <= 1000) println(17);  else println(999);
  println(18);
  println(19);

  // constant - constant
  // integer - byte
  if (1000 == 1) println(999); else println(20);
  if (1000 != 0) println(21);  else println(999);
  if (1000 >  0) println(22);  else println(999);
  if (1000 >= 0) println(23);  else println(999);
  if (1000 >= 1) println(24);  else println(999);
  if (1 <  2000) println(25);  else println(999);
  if (1 <= 2000) println(26);  else println(999);
  if (1 <= 1000) println(27);  else println(999);
  println(28);
  println(29);

  // constant - constant
  // integer - integer
  if (1000 == 1000) println(30); else println(999);
  if (1000 != 2000) println(31); else println(999);
  if (2000 >  1000) println(32); else println(999);
  if (2000 >= 1000) println(33); else println(999);
  if (1000 >= 1000) println(34); else println(999);
  if (1000 <  2000) println(35); else println(999);
  if (1000 <= 2000) println(36); else println(999);
  if (1000 <= 1000) println(37); else println(999);
  println(38);
  println(39);

  /************************/
  // constant - acc
  // byte - byte
  if (1 > 0+0) println(40); else println(999);
  if (1 < 2+0) println(41); else println(999);
  // constant - acc
  // byte - integer
  if (1 > 1000+0) println(999); else println(42);
  if (1 < 1000+0) println(43);  else println(999);
  // constant - acc
  // integer - byte
  if (1000 > 0+0) println(44);  else println(999);
  if (1000 < 0+0) println(999); else println(45);
  // constant - acc
  // integer - integer
  if (2000 > 1000+0) println(46); else println(999);
  if (1000 < 2000+0) println(47); else println(999);
  println(48);
  println(49);

  /************************/
  // constant - var
  // byte - byte
  if (30 > b) println(50); else println(999);
  if (10 < b) println(51); else println(999);
  // constant - var
  // byte - integer
  if (30 > i) println(999); else println(52);
  if (10 < i) println(53); else println(999);
  // constant - var
  // integer - byte
  if (3000 > b) println(54); else println(999);
  if (1000 < b) println(999); else println(55);
  // constant - var
  // integer - integer
  if (3000 > i) println(56); else println(999);
  if (1000 < i) println(57); else println(999);
  println(58);
  println(59);

  /************************/
  // constant - stack8
  // byte - byte
  println(60);
  println(61);
  // constant - stack8
  // byte - integer
  println(62);
  println(63);
  // constant - stack8
  // integer - byte
  println(64);
  println(65);
  // constant - stack8
  // integer - integer
  println(66);
  println(67);
  println(68);
  println(69);

  /************************/
  // constant - stack16
  // byte - byte
  println(70);
  println(71);
  // constant - stack16
  // byte - integer
  println(72);
  println(73);
  // constant - stack16
  // integer - byte
  println(74);
  println(75);
  // constant - stack16
  // integer - integer
  println(76);
  println(77);
  println(78);
  println(79);

  /************************/
  // acc - constant
  // byte - byte
  if (30+0 > 20) println(80); else println(999);
  if (10+0 < 20) println(81); else println(999);
  // acc - constant
  // byte - integer
  if (30+0 > 2000) println(999); else println(82);
  if (10+0 < 2000) println(83); else println(999);
  // acc - constant
  // integer - byte
  if (3000+0 > 20) println(84); else println(999);
  if (1000+0 < 20) println(999); else println(85);
  // acc - constant
  // integer - integer
  if (3000+0 > 2000) println(86); else println(999);
  if (1000+0 < 2000) println(87); else println(999);
  println(88);
  println(89);

  /************************/
  // acc - acc
  // byte - byte
  if (30+0 > 20+0) println(90); else println(999);
  if (10+0 < 20+0) println(91); else println(999);
  // acc - acc
  // byte - integer
  if (30+0 > 2000+0) println(999); else println(92);
  if (10+0 < 2000+0) println(93); else println(999);
  // acc - acc
  // integer - byte
  if (3000+0 > 20+0) println(94); else println(999);
  if (1000+0 < 20+0) println(999); else println(95);
  // acc - acc
  // integer - integer
  if (3000+0 > 2000+0) println(96); else println(999);
  if (1000+0 < 2000+0) println(97); else println(999);
  println(98);
  println(99);

  /************************/
  // acc - var
  // byte - byte
  if (30+0 > b) println(100); else println(999);
  if (10+0 < b) println(101); else println(999);
  // acc - var
  // byte - integer
  if (30+0 > i) println(999); else println(102);
  if (10+0 < i) println(103); else println(999);
  // acc - var
  // integer - byte
  if (3000+0 > b) println(104); else println(999);
  if (1000+0 < b) println(999); else println(105);
  // acc - var
  // integer - integer
  if (3000+0 > i) println(106); else println(999);
  if (1000+0 < i) println(107); else println(999);
  println(108);
  println(109);

  /************************/
  // acc - stack8
  // byte - byte
  println(110);
  println(111);
  // acc - stack8
  // byte - integer
  println(112);
  println(113);
  // acc - stack8
  // integer - byte
  println(114);
  println(115);
  // acc - stack8
  // integer - integer
  println(116);
  println(117);
  println(118);
  println(119);

  /************************/
  // acc - stack16
  // byte - byte
  println(120);
  println(121);
  // acc - stack16
  // byte - integer
  println(122);
  println(123);
  // acc - stack16
  // integer - byte
  println(124);
  println(125);
  // acc - stack16
  // integer - integer
  println(126);
  println(127);
  println(128);
  println(129);

  /************************/
  // var - constant
  // byte - byte
  if (b > 10) println(130); else println(999);
  if (b < 30) println(131); else println(999);
  // var - constant
  // byte - integer
  if (b > 1000) println(999); else println(132);
  if (b < 1000) println(133); else println(999);
  // var - constant
  // integer - byte
  if (i > 1000) println(134); else println(999);
  if (i < 3000) println(135); else println(999);
  // var - constant
  // integer - integer
  if (i > 1000) println(136); else println(999);
  if (i < 3000) println(137); else println(999);
  println(138);
  println(139);

  /************************/
  // var - acc
  // byte - byte
  if (b > 10+0) println(140); else println(999);
  if (b < 30+0) println(141); else println(999);
  // var - acc
  // byte - integer
  if (b > 1000+0) println(999); else println(142);
  if (b < 1000+0) println(143); else println(999);
  // var - acc
  // integer - byte
  if (i > 1000+0) println(144); else println(999);
  if (i < 3000+0) println(145); else println(999);
  // var - acc
  // integer - integer
  if (i > 1000+0) println(146); else println(999);
  if (i < 3000+0) println(147); else println(999);
  println(148);
  println(149);

  /************************/
  // var - var
  // byte - byte
  if (b > b1) println(150);
  if (b < b3) println(151);
  // var - var
  // byte - integer
  if (b > i1) println(999); else println(152);
  if (b < i3) println(153);
  // var - var
  // integer - byte
  if (i > i1) println(154);
  if (i < i3) println(155);
  // var - var
  // integer - integer
  if (i > i1) println(156);
  if (i < i3) println(157);
  println(158);
  println(159);

  /************************/
  // var - stack8
  // byte - byte

  // var - stack8
  // byte - integer

  // var - stack8
  // integer - byte 

  // var - stack8
  // integer - integer

  /************************/
  // var - stack16
  // byte - byte

  // var - stack16
  // byte - integer

  // var - stack16
  // integer - byte

  // var - stack16
  // integer - integer

  /************************/
  // stack8 - constant
  // stack8 - acc
  // stack8 - var
  // stack8 - stack8
  // stack8 - stack16

  /************************/
  // stack16 - constant
  // stack16 - acc
  // stack16 - var
  // stack16 - stack8
  // stack16 - stack16

  println("Klaar");
}