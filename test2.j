/* Program to test branch instructions */
class TestBranches {
  int i = 2000;
  int i1 = 1000;
  int i3 = 3000;
  byte b = 20;
  byte b1 = 10;
  byte b3 = 30;
    /*Possible operand types: 
     * leftOperand:  constant, acc, var, stack16, stack8
     * rightOperand: constant, acc, var, stack16, stack8
     *Possible datatype combinations:
     * integer - integer
     * integer - byte
     * byte - integer
     * byte - byte
    */

  /************************/
  // stack16 - constant
  // stack16 - acc
  // stack16 - var
  // stack16 - stack16
  // stack16 - stack8

  /************************/
  // stack8 - constant
  // stack8 - acc
  // stack8 - var
  // stack8 - stack16
  // stack8 - stack8

  /************************/
  // var - stack8
  // integer - integer

  // var - stack8
  // integer - byte 

  // var - stack8
  // byte - integer

  // var - stack8
  // byte - byte

  /************************/
  // var - stack16
  // integer - integer

  // var - stack16
  // integer - byte

  // var - stack16
  // byte - integer

  // var - stack16
  // byte - byte

  /************************/
  // var - var
  // integer - integer
  write(159);
  write(158);
  if (i > i1) write(157);
  if (i < i3) write(156);
  // var - var
  // integer - byte
  if (i > i1) write(155);
  if (i < i3) write(154);
  // var - var
  // byte - integer
  if (b > i1) write(999); else write(153);
  if (b < i3) write(152);
  // var - var
  // byte - byte
  if (b > b1) write(151);
  if (b < b3) write(150);

  /************************/
  // var - acc
  // integer - integer
  write(149);
  write(148);
  if (i > 1000+0) write(147);
  if (i < 3000+0) write(146);
  // var - acc
  // integer - byte
  if (i > 1000+0) write(145);
  if (i < 3000+0) write(144);
  // var - acc
  // byte - integer
  if (b > 1000+0) write(999); else write(143);
  if (b < 1000+0) write(142);
  // var - acc
  // byte - byte
  if (b > 10+0) write(141);
  if (b < 30+0) write(140);

  /************************/
  // var - constant
  // integer - integer
  write(139);
  write(138);
  if (i > 1000) write(137);
  if (i < 3000) write(136);
  // var - constant
  // integer - byte
  if (i > 1000) write(135);
  if (i < 3000) write(134);
  // var - constant
  // byte - integer
  if (b > 1000) write(999); else write(133);
  if (b < 1000) write(132);
  // var - constant
  // byte - byte
  if (b > 10) write(131);
  if (b < 30) write(130);

  /************************/
  // acc - stack8
  // integer - integer
  write(129);
  write(128);
  write(127);
  write(126);
  // acc - stack8
  // integer - byte
  write(125);
  write(124);
  // acc - stack8
  // byte - integer
  write(123);
  write(122);
  // acc - stack8
  // byte - byte
  write(121);
  write(120);

  /************************/
  // acc - stack16
  // integer - integer
  write(119);
  write(118);
  write(117);
  write(116);
  // acc - stack16
  // integer - byte
  write(115);
  write(114);
  // acc - stack16
  // byte - integer
  write(113);
  write(112);
  // acc - stack16
  // byte - byte
  write(111);
  write(110);

  /************************/
  // acc - var
  // integer - integer
  write(109);
  write(108);
  if (3000+0 > i) write(107);
  if (1000+0 < i) write(106);
  // acc - var
  // integer - byte
  if (3000+0 > b) write(105);
  if (1000+0 < b) write(999); else write(104);
  // acc - var
  // byte - integer
  if (30+0 > i) write(999); else write(103);
  if (10+0 < i) write(102);
  // acc - var
  // byte - byte
  if (30+0 > b) write(101);
  if (10+0 < b) write(100);

  /************************/
  // acc - acc
  // integer - integer
  write(99);
  write(98);
  if (3000+0 > 2000+0) write(97);
  if (1000+0 < 2000+0) write(96);
  // acc - acc
  // integer - byte
  if (3000+0 > 20+0) write(95);
  if (1000+0 < 20+0) write(999); else write(94);
  // acc - acc
  // byte - integer
  if (30+0 > 2000+0) write(999); else write(93);
  if (10+0 < 2000+0) write(92);
  // acc - acc
  // byte - byte
  if (30+0 > 20+0) write(91);
  if (10+0 < 20+0) write(90);

  /************************/
  // acc - constant
  // integer - integer
  write(89);
  write(88);
  if (3000+0 > 2000) write(87);
  if (1000+0 < 2000) write(86);
  // acc - constant
  // integer - byte
  if (3000+0 > 20) write(85);
  if (1000+0 < 20) write(999); else write(84);
  // acc - constant
  // byte - integer
  if (30+0 > 2000) write(999); else write(83);
  if (10+0 < 2000) write(82);
  // acc - constant
  // byte - byte
  if (30+0 > 20) write(81);
  if (10+0 < 20) write(80);

  /************************/
  // constant - stack8
  // byte - byte
  write(79);
  write(78);
  write(77);
  write(76);
  // constant - stack8
  // byte - integer
  write(75);
  write(74);
  // constant - stack8
  // integer - byte
  write(73);
  write(72);
  // constant - stack8
  // integer - integer
  write(71);
  write(70);


  /************************/
  // constant - stack16
  // byte - byte
  write(69);
  write(68);
  write(67);
  write(66);
  // constant - stack16
  // byte - integer
  write(65);
  write(64);
  // constant - stack16
  // integer - byte
  write(63);
  write(62);
  // constant - stack16
  // integer - integer
  write(61);
  write(60);


  /************************/
  // constant - var
  // byte - byte
  write(59);
  write(58);
  if (30 > b) write(57);
  if (10 < b) write(56);
  // constant - var
  // byte - integer
  if (30 > i) write(999); else write(55);
  if (10 < i) write(54);
  // constant - var
  // integer - byte
  if (3000 > b) write(53);
  if (1000 < b) write(999); else write(52);
  // constant - var
  // integer - integer
  if (3000 > i) write(51);
  if (1000 < i) write(50);

  /************************/
  // constant - acc
  // byte - byte
  write(49);
  write(48);
  if (1 > 0+0) write(47);
  if (1 < 2+0) write(46);
  // constant - acc
  // byte - integer
  if (1 > 1000+0) write(999); else write(45);
  if (1 < 1000+0) write(44);
  // constant - acc
  // integer - byte
  if (1000 > 0+0) write(43);
  if (1000 < 0+0) write(999); else write(42);
  // constant - acc
  // integer - integer
  if (2000 > 1000+0) write(41);
  if (1000 < 2000+0) write(40);

  /************************/
  // constant - constant
  // byte - byte
  write(39);
  if (1 == 1) write(38);
  if (1 != 0) write(37);
  if (1 > 0) write(36);
  if (1 >= 0) write(35);
  if (1 >= 1) write(34);
  if (1 < 2) write(33);
  if (1 <= 2) write(32);
  if (1 <= 1) write(31);
  write(30);
  // constant - constant
  // byte - integer
  write(29);
  if (1 == 1000) write(999); else write(28);
  if (1 != 1000) write(27);
  if (1 > 1000) write(999); else write(26);
  if (1 >= 1000) write(999); write(25);
  if (1 >= 1000) write(999); write(24);
  if (1 < 2000) write(23);
  if (1 <= 2000) write(22);
  if (1 <= 1000) write(21);
  write(20);
  // constant - constant
  // integer - byte
  write(19);
  if (1000 == 1) { write(999); } else { write(18); }
  if (1000 != 0) write(17);
  if (1000 > 0) write(16);
  if (1000 >= 0) write(15);
  if (1000 >= 1) write(14);
  if (1 < 2000) write(13);
  if (1 <= 2000) write(12);
  if (1 <= 1000) write(11);
  write(10);
  // constant - constant
  // integer - integer
  write(9);
  if (1000 == 1000) write(8);
  if (1000 != 2000) write(7);
  if (2000 > 1000) write(6);
  if (2000 >= 1000) write(5);
  if (1000 >= 1000) write(4);
  if (1000 < 2000) write(3);
  if (1000 <= 2000) write(2);
  if (1000 <= 1000) write(1);

  write(0);
}