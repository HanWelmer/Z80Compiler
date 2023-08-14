/* Program to test generated Z80 assembler code */
class TestFor {
  byte b1 = 1;
  byte b2 = 1;
  word i2 = 1;
  word p = 1;

  println(0);

  /************************/
  // global variable within for scope
  for (byte b = 1; b <= 2; b++) {
    byte c = b1;
    println (c);
    b1++;
  }

  /************************/
  // constant - constant
  // not relevant

  /************************/
  // constant - acc
  // byte - byte
  for (byte b = 3; 103 == b+100; b++) { println (b); }
  for (byte b = 4; 105 != b+100; b++) { println (b); }
  b2=5;
  for (byte b = 32; 134 > b+100; b++) { println (b2); b2++; }
  for (byte b = 34; 135 >= b+100; b++) { println (b2); b2++; }
  for (byte b = 28; 126 <  b+100; b--) { println (b2); b2++; }
  for (byte b = 26; 125 <= b+100; b--) { println (b2); b2++; }
  // byte - integer
  for(word i = 24; 24  == i+0; i--) { println (b2); b2++; }
  for(word i = 23; 120 != i+100; i--) { println (b2); b2++; }
  for(word i = 20; 122 > i+100; i++) { println (b2); b2++; }
  for(word i = 22; 123 >= i+100; i++) { println (b2); b2++; }
  for(word i = 16; 114 <  i+100; i--) { println (b2); b2++; }
  for(word i = 14; 113 <= i+100; i--) { println (b2); b2++; }
  // integer - byte
  // not relevant
  // integer - integer
  for(word i = 12; 1012 == i+1000; i--) { println (b2); b2++; }
  for(word i = 11; 1008 != i+1000; i--) { println (b2); b2++; }
  for(word i = 8; 1010 > i+1000; i++) { println (b2); b2++; }
  for(word i = 10; 1011 >= i+1000; i++) { println (b2); b2++; }
  for(word i = 4; 1002 <  i+1000; i--) { println (b2); b2++; }
  for(word i = 2; 1001 <= i+1000; i--) { println (b2); b2++; }

  /************************/
  // constant - var
  // byte - byte
  for (byte b = 42; 41 <= b; b--) { println (b2); b2++; }
  // byte - integer
  for(word i = 40; 39 <= i; i--) { println (b2); b2++; }
  // integer - byte
  // not relevant
  // integer - integer
  for(word i = 1038; 1037 <= i; i--) { println (b2); b2++; }

  /************************/
  // constant - stack8
  // byte - byte
  //TODO
  println(43);
  println(44);
  // constant - stack8
  // byte - integer
  //TODO
  println(45);
  println(46);
  // constant - stack8
  // integer - byte
  //TODO
  println(47);
  println(48);
  // constant - stack88
  // integer - integer
  //TODO
  println(49);
  println(50);

  /************************/
  // constant - stack16
  // byte - byte
  //TODO
  println(51);
  println(52);
  // constant - stack16
  // byte - integer
  //TODO
  println(53);
  println(54);
  // constant - stack16
  // integer - byte
  //TODO
  println(55);
  println(56);
  // constant - stack16
  // integer - integer
  //TODO
  println(57);
  println(58);

  /************************/
  // acc - constant
  // byte - byte
  b2 = 59;
  for (byte b = 56; b+0 <= 57; b++) { println (b2); b2++; }
  // byte - integer
  //not relevant
  // integer - byte
  for (word i = 54; i+0 <= 55; i++) { println (b2); b2++;}
  // integer - integer
  for(word i = 1052; i+0 <= 1053; i++) { println (b2); b2++; }

  /************************/
  // acc - acc
  // byte - byte
  for (byte b = 64; 63+0 <= b+0; b--) { println (b2); b2++; }
  // byte - integer
  for(word i = 62; 61+0 <= i+0; i--) { println (b2); b2++; }
  // integer - byte
  i2=59;
  for (byte b = 60; i2+0 <= b+0; b--) { println (b2); b2++; }
  // integer - integer
  for(word i = 1058; 1000+57 <= i+0; i--) { println (b2); b2++; }

  /************************/
  // acc - var
  // byte - byte
  for (byte b = 72; 71+0 <= b; b--) { println (b2); b2++; }
  // byte - integer
  for(word i = 70; 69+0 <= i; i--) { println (b2); b2++; }
  // integer - byte
  i2=67;
  for (byte b = 68; i2+0 <= b; b--) { println (b2); b2++; }
  // integer - integer
  for(word i = 1066; 1000+65 <= i; i--) { println (b2); b2++; }

  /************************/
  // acc - stack8
  // byte - byte
  //TODO
  println(81);
  println(82);
  // byte - integer
  //TODO
  println(83);
  println(84);
  // integer - byte
  //TODO
  println(85);
  println(86);
  // integer - integer
  //TODO
  println(87);
  println(88);

  /************************/
  // acc - stack16
  // byte - byte
  //TODO
  println(89);
  println(90);
  // byte - integer
  //TODO
  println(91);
  println(92);
  // integer - byte
  //TODO
  println(93);
  println(94);
  // integer - integer
  //TODO
  println(95);
  println(96);

  /************************/
  // var - constant
  // byte - byte
  b2=97;
  for (byte b = 96; b <= 97; b++) { println (b2); b2++; }
  // byte - integer
  //not relevant
  // integer - byte
  for(word i = 92; i <= 93; i++) { println (b2); b2++; }
  // integer - integer
  for(word i = 1090; i <= 1091; i++) { println (b2); b2++; }

  /************************/
  // var - acc
  // byte - byte
  for (byte b = 104; b <= 105+0; b++) { println (b2); b2++; }
  // byte - integer
  i2=103;
  for (byte b = 102; b <= i2+0; b++) { println (b2); b2++; }
  // integer - byte
  for(word i = 100; i <= 101+0; i++) { println (b2); b2++; }
  // integer - integer
  for(word i = 1098; i <= 1099+0; i++) { println (b2); b2++; }

  /************************/
  // var - var
  // byte - byte
  for (byte b = 112; b2 <= b; b--) { println (b2); b2++; }
  // byte - integer
  for(word i = 116; b2 <= i; i--) { println (b2); b2++; }
  // integer - byte
  i2=b2;
  for (byte b = 118; i2 <= b; b--) { println (b2); b2++; }
  // integer - integer
  i2=120;
  for(word i = b2+4; i2 <= i; i--) { println (b2); b2++; }

  /************************/
  // var - stack8
  // byte - byte
  // byte - integer
  // integer - byte
  // integer - integer
  //TODO

  /************************/
  // var - stack16
  // byte - byte
  // byte - integer
  // integer - byte
  // integer - integer
  //TODO

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

  println("Klaar.");
}