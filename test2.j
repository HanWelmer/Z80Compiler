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

  write(0);

  /************************/
  // constant - constant
  // byte - byte
  if (1 == 1) write(1); else write(999);
  if (1 != 0) write(2); else write(999);
  if (1 >  0) write(3); else write(999);
  if (1 >= 0) write(4); else write(999);
  if (1 >= 1) write(5); else write(999);
  if (1 <  2) write(6); else write(999);
  if (1 <= 2) write(7); else write(999);
  if (1 <= 1) write(8); else write(999);
  write(9);

  // constant - constant
  // byte - integer
  if (1 == 1000) write(999); else write(10);
  if (1 != 1000) write(11);  else write(999);
  if (1 >  1000) write(999); else write(12);
  if (1 >= 1000) write(999); else write(13);
  if (1 >= 1000) write(999); else write(14);
  if (1 <  2000) write(15);  else write(999);
  if (1 <= 2000) write(16);  else write(999);
  if (1 <= 1000) write(17);  else write(999);
  write(18);
  write(19);

  // constant - constant
  // integer - byte
  if (1000 == 1) write(999); else write(20);
  if (1000 != 0) write(21);  else write(999);
  if (1000 >  0) write(22);  else write(999);
  if (1000 >= 0) write(23);  else write(999);
  if (1000 >= 1) write(24);  else write(999);
  if (1 <  2000) write(25);  else write(999);
  if (1 <= 2000) write(26);  else write(999);
  if (1 <= 1000) write(27);  else write(999);
  write(28);
  write(29);

  // constant - constant
  // integer - integer
  if (1000 == 1000) write(30); else write(999);
  if (1000 != 2000) write(31); else write(999);
  if (2000 >  1000) write(32); else write(999);
  if (2000 >= 1000) write(33); else write(999);
  if (1000 >= 1000) write(34); else write(999);
  if (1000 <  2000) write(35); else write(999);
  if (1000 <= 2000) write(36); else write(999);
  if (1000 <= 1000) write(37); else write(999);
  write(38);
  write(39);

  /************************/
  // constant - acc
  // byte - byte
  if (1 > 0+0) write(40); else write(999);
  if (1 < 2+0) write(41); else write(999);
  // constant - acc
  // byte - integer
  if (1 > 1000+0) write(999); else write(42);
  if (1 < 1000+0) write(43);  else write(999);
  // constant - acc
  // integer - byte
  if (1000 > 0+0) write(44);  else write(999);
  if (1000 < 0+0) write(999); else write(45);
  // constant - acc
  // integer - integer
  if (2000 > 1000+0) write(46); else write(999);
  if (1000 < 2000+0) write(47); else write(999);
  write(48);
  write(49);

  /************************/
  // constant - var
  // byte - byte
  if (30 > b) write(50); else write(999);
  if (10 < b) write(51); else write(999);
  // constant - var
  // byte - integer
  if (30 > i) write(999); else write(52);
  if (10 < i) write(53); else write(999);
  // constant - var
  // integer - byte
  if (3000 > b) write(54); else write(999);
  if (1000 < b) write(999); else write(55);
  // constant - var
  // integer - integer
  if (3000 > i) write(56); else write(999);
  if (1000 < i) write(57); else write(999);
  write(58);
  write(59);

  /************************/
  // constant - stack8
  // byte - byte
  write(60);
  write(61);
  // constant - stack8
  // byte - integer
  write(62);
  write(63);
  // constant - stack8
  // integer - byte
  write(64);
  write(65);
  // constant - stack8
  // integer - integer
  write(66);
  write(67);
  write(68);
  write(69);

  /************************/
  // constant - stack16
  // byte - byte
  write(70);
  write(71);
  // constant - stack16
  // byte - integer
  write(72);
  write(73);
  // constant - stack16
  // integer - byte
  write(74);
  write(75);
  // constant - stack16
  // integer - integer
  write(76);
  write(77);
  write(78);
  write(79);

  /************************/
  // acc - constant
  // byte - byte
  if (30+0 > 20) write(80); else write(999);
  if (10+0 < 20) write(81); else write(999);
  // acc - constant
  // byte - integer
  if (30+0 > 2000) write(999); else write(82);
  if (10+0 < 2000) write(83); else write(999);
  // acc - constant
  // integer - byte
  if (3000+0 > 20) write(84); else write(999);
  if (1000+0 < 20) write(999); else write(85);
  // acc - constant
  // integer - integer
  if (3000+0 > 2000) write(86); else write(999);
  if (1000+0 < 2000) write(87); else write(999);
  write(88);
  write(89);

  /************************/
  // acc - acc
  // byte - byte
  if (30+0 > 20+0) write(90); else write(999);
  if (10+0 < 20+0) write(91); else write(999);
  // acc - acc
  // byte - integer
  if (30+0 > 2000+0) write(999); else write(92);
  if (10+0 < 2000+0) write(93); else write(999);
  // acc - acc
  // integer - byte
  if (3000+0 > 20+0) write(94); else write(999);
  if (1000+0 < 20+0) write(999); else write(95);
  // acc - acc
  // integer - integer
  if (3000+0 > 2000+0) write(96); else write(999);
  if (1000+0 < 2000+0) write(97); else write(999);
  write(98);
  write(99);

  /************************/
  // acc - var
  // byte - byte
  if (30+0 > b) write(100); else write(999);
  if (10+0 < b) write(101); else write(999);
  // acc - var
  // byte - integer
  if (30+0 > i) write(999); else write(102);
  if (10+0 < i) write(103); else write(999);
  // acc - var
  // integer - byte
  if (3000+0 > b) write(104); else write(999);
  if (1000+0 < b) write(999); else write(105);
  // acc - var
  // integer - integer
  if (3000+0 > i) write(106); else write(999);
  if (1000+0 < i) write(107); else write(999);
  write(108);
  write(109);

  /************************/
  // acc - stack8
  // byte - byte
  write(110);
  write(111);
  // acc - stack8
  // byte - integer
  write(112);
  write(113);
  // acc - stack8
  // integer - byte
  write(114);
  write(115);
  // acc - stack8
  // integer - integer
  write(116);
  write(117);
  write(118);
  write(119);

  /************************/
  // acc - stack16
  // byte - byte
  write(120);
  write(121);
  // acc - stack16
  // byte - integer
  write(122);
  write(123);
  // acc - stack16
  // integer - byte
  write(124);
  write(125);
  // acc - stack16
  // integer - integer
  write(126);
  write(127);
  write(128);
  write(129);

  /************************/
  // var - constant
  // byte - byte
  if (b > 10) write(130); else write(999);
  if (b < 30) write(131); else write(999);
  // var - constant
  // byte - integer
  if (b > 1000) write(999); else write(132);
  if (b < 1000) write(133); else write(999);
  // var - constant
  // integer - byte
  if (i > 1000) write(134); else write(999);
  if (i < 3000) write(135); else write(999);
  // var - constant
  // integer - integer
  if (i > 1000) write(136); else write(999);
  if (i < 3000) write(137); else write(999);
  write(138);
  write(139);

  /************************/
  // var - acc
  // byte - byte
  if (b > 10+0) write(140); else write(999);
  if (b < 30+0) write(141); else write(999);
  // var - acc
  // byte - integer
  if (b > 1000+0) write(999); else write(142);
  if (b < 1000+0) write(143); else write(999);
  // var - acc
  // integer - byte
  if (i > 1000+0) write(144); else write(999);
  if (i < 3000+0) write(145); else write(999);
  // var - acc
  // integer - integer
  if (i > 1000+0) write(146); else write(999);
  if (i < 3000+0) write(147); else write(999);
  write(148);
  write(149);

  /************************/
  // var - var
  // byte - byte
  if (b > b1) write(150);
  if (b < b3) write(151);
  // var - var
  // byte - integer
  if (b > i1) write(999); else write(152);
  if (b < i3) write(153);
  // var - var
  // integer - byte
  if (i > i1) write(154);
  if (i < i3) write(155);
  // var - var
  // integer - integer
  if (i > i1) write(156);
  if (i < i3) write(157);
  write(158);
  write(159);

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

  write("Klaar");
}