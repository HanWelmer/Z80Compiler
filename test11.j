/* Program to test generated Z80 assembler code */
class TestFor {
  byte b1 = 115;
  
  /************************/
  // global variable within for scope
  write (b1);
  b1--;
  do {
    word j = 1001;
    byte c = b1;
    byte d = c;
    b1--;
    write (c);
  } while (b1>112);

  /************************/
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
  b2 = 111;
  for (byte b = 112; b2 <= b; b--) { write (b); }
  // byte - integer
  b2 = 109;
  for(word i = 110; b2 <= i; i--) { write(i); }
  // integer - byte
  i2=107;
  for (byte b = 108; i2 <= b; b--) { write (b); }
  // integer - integer
  i2=105;
  for(word i = 106; i2 <= i; i--) { write(i); }

  /************************/
  // var - acc
  // byte - byte
  i2=104;
  for (byte b = 104; b <= 105+0; b++) { write (i2); i2--; }
  // byte - integer
  i2=103;
  for (byte b = 102; b <= i2+0; b--) { write (b); i2=i2-2; }
  // integer - byte
  b2=100;
  for(word i = 100; i <= 101+0; i++) { write(b2); b2--; }
  // integer - integer
  for(word i = 1098; i <= 1099+0; i++) { write(b2); b2--; }

  /************************/
  // var - constant
  // byte - byte
  i2=96;
  for (byte b = 96; b <= 97; b++) { write (i2); i2--; }
  // byte - integer
  //not relevant
  write(94);
  write(93);
  // integer - byte
  b2=92;
  for(word i = 92; i <= 93; i++) { write(b2); b2--; }
  // integer - integer
  for(word i = 1090; i <= 1091; i++) { write(b2); b2--; }

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
  for (byte b = 72; 71+0 <= b; b--) { write (b); }
  // byte - integer
  for(word i = 70; 69+0 <= i; i--) { write(i); }
  // integer - byte
  i2=67;
  for (byte b = 68; i2+0 <= b; b--) { write (b); }
  // integer - integer
  b2 = 66;
  for(word i = 1066; 1000+65 <= i; i--) { write (b2); b2--; }

  /************************/
  // acc - acc
  // byte - byte
  for (byte b = 64; 63+0 <= b+0; b--) { write (b); }
  // byte - integer
  for(word i = 62; 61+0 <= i+0; i--) { write(i); }
  // integer - byte
  i2=59;
  for (byte b = 60; i2+0 <= b+0; b--) { write (b); }
  // integer - integer
  b2=58;
  for(word i = 1058; 1000+57 <= i+0; i--) { write(b2); b2--; }

  /************************/
  // acc - constant
  // byte - byte
  i2=56;
  for (byte b = 56; b+0 <= 57; b++) { write (i2); i2--; }
  // byte - integer
  //not relevant
  // integer - byte
  b2=54;
  for (word i = 54; i+0 <= 55; i++) { write (b2); b2--;}
  // integer - integer
  b2=52;
  for(word i = 1052; i+0 <= 1053; i++) { write(b2); b2--; }

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
  for (byte b = 42; 41 <= b; b--) { write (b); }
  // constant - var
  // byte - integer
  for(word i = 40; 39 <= i; i--) { write(i); }
  // constant - var
  // integer - byte
  // not relevant
  // constant - var
  // integer - integer
  b2=38;
  for(word i = 1038; 1037 <= i; i--) { write(b2); b2--; }

  /************************/
  // constant - acc
  // byte - byte
  for (byte b = 36; 136 == b+100; b--) { write (b); }
  for (byte b = 35; 132 != b+100; b--) { write (b); }
  b2=32;
  for (byte b = 32; 134 > b+100; b++) { write (b2); b2--; }
  for (byte b = 34; 135 >= b+100; b++) { write (b2); b2--; }
  for (byte b = 28; 126 <  b+100; b--) { write (b); }
  for (byte b = 26; 125 <= b+100; b--) { write (b); }
  // constant - acc
  // byte - integer
  for(word i = 24; 24 == i+0; i--) { write(i); }
  for(word i = 23; 120 != i+100; i--) { write(i); }
  b2=20;
  for(word i = 20; 122 > i+100; i++) { write (b2); b2--; }
  for(word i = 22; 123 >= i+100; i++) { write (b2); b2--; }
  for(word i = 16; 114 <  i+100; i--) { write(i); }
  for(word i = 14; 113 <= i+100; i--) { write(i); }
  // constant - acc
  // integer - byte
  // not relevant

  // constant - acc
  // integer - integer
  for(word i = 12; 1012 == i+1000; i--) { write(i); }
  for(word i = 11; 1008 != i+1000; i--) { write(i); }
  b2=8;
  for(word i = 8; 1010 > i+1000; i++) { write (b2); b2--; }
  for(word i = 10; 1011 >= i+1000; i++) { write (b2); b2--; }
  for(word i = 4; 1002 <  i+1000; i--) { write(i); }
  for(word i = 2; 1001 <= i+1000; i--) { write(i); }
  write("Klaar.");
}