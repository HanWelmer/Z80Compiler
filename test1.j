/* Program to test generated Z80 assembler code */
class TestWhile {
  byte b = 115;
  
  /************************/
  // global variable within while scope
  write (b);
  b--;
  while (b>112) {
    word j = 1001;
    byte c = b;
    byte d = c;
    b--;
    write (c);
  }

  word i = 110;
  word i2 = 105;
  word p = 12;
  byte b2 = 111;

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
  while (b2 <= b) { write (b); b--; }
  // byte - integer
  b2 = 109;
  while (b2 <= i) { write (i); i--; }
  // integer - byte
  b=108;
  i=107;
  while (i <= b) { write (b); b--; }
  // integer - integer
  i=106;
  while (i2 <= i) { write (i); i--; }

  /************************/
  // var - acc
  // byte - byte
  i=104;
  b=104;
  while (b <= 105+0) { write (i); i--; b++; }
  // byte - integer
  i=103;
  b=102;
  while (b <= i+0) { write (b); b--; i=i-2; }
  // integer - byte
  i=100;
  while (i <= 101+0) { write (b); b--; i++; }
  // integer - integer
  i=1098;
  while (i <= 1099+0) { write (b); b--; i++; }

  /************************/
  // var - constant
  // byte - byte
  i=96;
  b=96;
  while (b <= 97) { write (i); i--; b++; }
  // byte - integer
  //not relevant
  write(94);
  write(93);
  // integer - byte
  i=92;
  b=92;
  while (i <= 93) { write (b); b--; i++; }
  // integer - integer
  i=1090;
  while (i <= 1091) { write (b); b--; i++; }

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
  while (71+0 <= b) { write (b); b--; }
  // byte - integer
  i=70;
  while (69+0 <= i) { write (i); i--; }
  // integer - byte
  i=67;
  b=68;
  while (i+0 <= b) { write (b); b--; } 
  // integer - integer
  i=1066;
  while (1000+65 <= i) { write (b); b--; i--; }

  /************************/
  // acc - acc
  // byte - byte
  b=64;
  while (63+0 <= b+0) { write (b); b--; }
  // byte - integer
  i=62;
  while (61+0 <= i+0) { write (i); i--; }
  // integer - byte
  i=59;
  b=60;
  while (i+0 <= b+0) { write (b); b--; }
  // integer - integer
  i=1058;
  while (1000+57 <= i+0) { write (b); b--; i--; }

  /************************/
  // acc - constant
  // byte - byte
  i=56;
  b=56;
  while (b+0 <= 57) { write (i); i--; b++; }
  // byte - integer
  //not relevant
  // integer - byte
  i=54;
  b=54;
  while (i+0 <= 55) { write (b); b--; i++; }
  i=1052;
  // integer - integer
  while (i+0 <= 1053) { write (b); b--; i++; }

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
  while (41 <= b) { write (b); b--; }

  // constant - var
  // byte - integer
  i=40;
  while (39 <= i) { write (i); i--; }

  // constant - var
  // integer - byte
  // not relevant

  // constant - var
  // integer - integer
  i=1038;
  b=38;
  while (1037 <= i) { write (b); b--; i--; }

  /************************/
  // constant - acc
  // byte - byte
  b=36;
  while (135 == b+100) { write (b); b--; }
  while (132 != b+100) { write (b); b--; }
  p=32;
  while (134 > b+100) { write (p); p--; b++; }
  while (135 >= b+100) { write (p); p--; b++; }
  b=28;
  while (126 <  b+100) { write (b); b--; }
  while (125 <= b+100) { write (b); b--; }
  // constant - acc
  // byte - integer
  i=24;
  b=23;
  while (23 == i+0) { write (i); i--; }
  while (120 != i+100) { write (i); i--; }
  p=20;
  while (122 > i+100) { write (p); p--; i++; }
  while (123 >= i+100) { write (p); p--; i++; }
  i=16;
  while (114 <  i+100) { write (i); i--; }
  while (113 <= i+100) { write (i); i--; }
  // constant - acc
  // integer - byte
  // not relevant

  // constant - acc
  // integer - integer
  i=12;
  while (1011 == i+1000) { write (i); i--; }
  //i=10
  while (1008 != i+1000) { write (i); i--; }
  //i=8
  p=8;
  while (1010 > i+1000) { write (p); p--; i++; }
  //i=10; p=6
  while (1011 >= i+1000) { write (p); p--; i++; }
  i=4;
  while (1002 <  i+1000) { write (i); i--; }
  //i=2;
  while (1001 <= i+1000) { write (i); i--; }

  /************************/
  // constant - constant
  // not relevant
  write(0);
}