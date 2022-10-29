/* Program to test generated Z80 assembler code */
class TestDo {
  int i = 12;
  int p = 12;
  byte b = 24;

  /************************/
  // stack8 - constant
  // stack8 - acc
  // stack8 - var
  // stack8 - stack8
  // stack8 - stack16
  //TODO

  /************************/
  // stack16 - constant
  // stack16 - acc
  // stack16 - var
  // stack16 - stack8
  // stack16 - stack16
  //TODO

  /************************/
  // var - stack16
  // byte - byte
  // byte - integer
  // integer - byte
  // integer - integer
  //TODO

  /************************/
  // var - stack8
  // byte - byte
  // byte - integer
  // integer - byte
  // integer - integer
  //TODO

  /************************/
  // var - var
  // byte - byte
  b=112;
  byte b2 = 111;
  do { write (b); b--; } while (b2 <= b);
  // byte - integer
  i=110;
  b2 = 109;
  do { write (i); i--; } while (b2 <= i);
  // integer - byte
  b=108;
  i=107;
  do { write (b); b--; } while (i <= b);
  // integer - integer
  i=106;
  int i2 = 105;
  do { write (i); i--; } while (i2 <= i);

  /************************/
  // var - acc
  // byte - byte
  i=104;
  b=104;
  do { write (i); i--; b++; } while (b <= 105+0);
  // byte - integer
  //not relevant
  i=103;
  b=102;
  do { write (b); b--; i=i-2; } while (b <= i+0);
  // integer - byte
  i=100;
  do { write (b); b--; i++; } while (i <= 101+0);
  // integer - integer
  i=1098;
  do { write (b); b--; i++; } while (i <= 1099+0);

  /************************/
  // var - constant
  // byte - byte
  i=96;
  b=96;
  do { write (i); i--; b++; } while (b <= 97);
  // byte - integer
  //not relevant
  write(94);
  write(93);
  // integer - byte
  i=92;
  b=92;
  do { write (b); b--; i++; } while (i <= 93);
  // integer - integer
  i=1090;
  do { write (b); b--; i++; } while (i <= 1091);

  /************************/
  // acc - stack8
  // byte - byte
  //TODO
  write(88);
  write(87);
  // byte - integer
  //TODO
  write(86);
  write(85);
  // integer - byte
  //TODO
  write(84);
  write(83);
  // integer - integer
  //TODO
  write(82);
  write(81);

  /************************/
  // acc - stack16
  // byte - byte
  //TODO
  write(80);
  write(79);
  // byte - integer
  //TODO
  write(78);
  write(77);
  // integer - byte
  //TODO
  write(76);
  write(75);
  // integer - integer
  //TODO
  write(74);
  write(73);

  /************************/
  // acc - var
  // byte - byte
  b=72;
  do { write (b); b--; } while (71+0 <= b);
  // byte - integer
  i=70;
  do { write (i); i--; } while (69+0 <= i);
  // integer - byte
  i=67;
  b=68;
  do { write (b); b--; } while (i+0 <= b);
  // integer - integer
  i=1066;
  do { write (b); b--; i--; } while (1000+65 <= i);

  /************************/
  // acc - acc
  // byte - byte
  b=64;
  do { write (b); b--; } while (63+0 <= b+0);
  // byte - integer
  i=62;
  do { write (i); i--; } while (61+0 <= i+0);
  // integer - byte
  i=59;
  b=60;
  do { write (b); b--; } while (i+0 <= b+0);
  // integer - integer
  i=1058;
  do { write (b); b--; i--; } while (1000+57 <= i+0);

  /************************/
  // acc - constant
  // byte - byte
  i=56;
  b=56;
  do { write (i); i--; b++; } while (b+0 <= 57);
  // byte - integer
  //not relevant
  // integer - byte
  i=54;
  b=54;
  do { write (b); b--; i++; } while (i+0 <= 55);
  i=1052;
  // integer - integer
  do { write (b); b--; i++; } while (i+0 <= 1053);

  /************************/
  // constant - stack8
  // byte - byte
  //TODO
  write(50);
  // constant - stack8
  // byte - integer
  //TODO
  write(49);
  // constant - stack8
  // integer - byte
  //TODO
  write(48);
  // constant - stack88
  // integer - integer
  //TODO
  write(47);

  /************************/
  // constant - stack16
  // byte - byte
  //TODO
  write(46);
  // constant - stack16
  // byte - integer
  //TODO
  write(45);
  // constant - stack16
  // integer - byte
  //TODO
  write(44);
  // constant - stack16
  // integer - integer
  //TODO
  write(43);

  /************************/
  // constant - var
  // byte - byte
  b=42;
  do { write (b); b--; } while (41 <= b);

  // constant - var
  // byte - integer
  i=40;
  do { write (i); i--; } while (39 <= i);

  // constant - var
  // integer - byte
  // not relevant

  // constant - var
  // integer - integer
  i=1038;
  b=38;
  do { write (b); b--; i--; } while (1037 <= i);

  /************************/
  // constant - acc
  // byte - byte
  b=36;
  do { write (b); b--; } while (135 == b+100);
  do { write (b); b--; } while (132 != b+100);
  p=32;
  do { write (p); p--; b++; } while (134 > b+100);
  do { write (p); p--; b++; } while (135 >= b+100);
  b=28;
  do { write (b); b--; } while (126 <  b+100);
  do { write (b); b--; } while (125 <= b+100);
  // constant - acc
  // byte - integer
  i=24;
  b=23;
  do { write (i); i--; } while (23 == i+0);
  do { write (i); i--; } while (120 != i+100);
  p=20;
  do { write (p); p--; i++; } while (122 > i+100);
  do { write (p); p--; i++; } while (123 >= i+100);
  i=16;
  do { write (i); i--; } while (114 <  i+100);
  do { write (i); i--; } while (113 <= i+100);
  // constant - acc
  // integer - byte
  // not relevant

  // constant - acc
  // integer - integer
  i=12;
  do { write (i); i--; } while (1011 == i+1000);
  //i=10
  do { write (i); i--; } while (1008 != i+1000);
  //i=8
  p=8;
  do { write (p); p--; i++; } while (1010 > i+1000);
  //i=10; p=6
  do { write (p); p--; i++; } while (1011 >= i+1000);
  i=4;
  do { write (i); i--; } while (1002 <  i+1000);
  //i=2;
  do { write (i); i--; } while (1001 <= i+1000);

  /************************/
  // constant - constant
  // not relevant
  write(0);
}