/* Program to test generated Z80 assembler code */
class TestDo {
  byte b = 1;
  word i = 12;
  word p = 12;

  println(0);

  /************************/
  // global variable within do scope
  println (b);
  b++;
  do {
    word j = 1001;
    byte c = b;
    byte d = c;
    b++;
    println (c);
  } while (b<2);

  /************************/
  // constant - constant
  // not relevant

  /************************/
  // constant - acc
  // byte - byte
  do { println (b); b++; } while (103 == b+100);
  do { println (b); b++; } while (106 != b+100);
  do { println (b); b++; } while (108 >  b+100);
  do { println (b); b++; } while (109 >= b+100);
  p=10;
  do { println (p); p++; b--; } while (108 <  b+100);
  do { println (p); p++; b--; } while (107 <= b+100);

  // constant - acc
  // byte - integer
  i=14;
  do { println (i); i++; } while (15 == i+0);
  do { println (i); i++; } while (18 != i+0);
  do { println (i); i++; } while (20 >  i+0);
  do { println (i); i++; } while (21 >= i+0);
  p=22;
  do { println (p); p++; i--; } while (20 <  i+0);
  do { println (p); p++; i--; } while (19 <= i+0);

  // constant - acc
  // integer - byte
  // not relevant

  // constant - acc
  // integer - integer
  i=p;
  do { println (i); i++; } while (1027 == i+1000);
  do { println (i); i++; } while (1029 != i+1000);
  do { println (i); i++; } while (1031 >  i+1000);
  do { println (i); i++; } while (1032 >= i+1000);
  p=i;
  do { println (p); p++; i--; } while (1031 <  i+1000);
  do { println (p); p++; i--; } while (1030 <= i+1000);

  /************************/
  // constant - var
  // byte - byte
  b=37;
  do { println (b); b++; } while (38 >= b);
  // byte - integer
  i=39;
  do { println (i); i++; } while (40 >= i);
  // integer - byte
  // not relevant
  // integer - integer
  i=1038;
  b=41;
  do { println (b); b++; i--; } while (1037 <= i);

  /************************/
  // constant - stack8
  // byte - byte
  //TODO
  println(43);
  // constant - stack8
  // byte - integer
  //TODO
  println(44);
  // constant - stack8
  // integer - byte
  //TODO
  println(45);
  // constant - stack88
  // integer - integer
  //TODO
  println(46);

  /************************/
  // constant - stack16
  // byte - byte
  //TODO
  println(47);
  // constant - stack16
  // byte - integer
  //TODO
  println(48);
  // constant - stack16
  // integer - byte
  //TODO
  println(49);
  // constant - stack16
  // integer - integer
  //TODO
  println(50);

  /************************/
  // acc - constant
  // byte - byte
  b=51;
  do { println (b); b++; } while (b+0 <= 52);
  // byte - integer
  //not relevant
  // integer - byte
  i=53;
  do { println (i); i++; } while (i+0 <= 54);

  b=55;
  i=1055;
  // integer - integer
  do { println (b); b++; i++; } while (i+0 <= 1056);

  /************************/
  // acc - acc
  // byte - byte
  b=57;
  do { println (b); b++; } while (b+0 <= 58+0);
  // byte - integer
  i=61;
  do { println (b); b++; i--; } while (60+0 <= i+0);
  // integer - byte
  i=61;
  b=62;
  do { println (i); i++; } while (i+0 <= b+0);
  // integer - integer
  b=63;
  i=1063;
  do { println (b); b++; i--; } while (1000+62 <= i+0);

  /************************/
  // acc - var
  // byte - byte
  b=65;
  i=65;
  do { println (i); i++; b--; } while (64+0 <= b);
  // byte - integer
  b=67;
  i=67;
  do { println (b); b++; i--; } while (66+0 <= i);
  // integer - byte
  i=69;
  b=69;
  do { println (i); i++; b--; } while (1000+68 <= b);
  // integer - integer
  i=1071;
  b=70;
  do { println (b); b++; i--; } while (1000+70 <= i);

  /************************/
  // acc - stack16
  // byte - byte
  //TODO
  println(72);
  println(73);
  // byte - integer
  //TODO
  println(74);
  println(75);
  // integer - byte
  //TODO
  println(76);
  println(77);
  // integer - integer
  //TODO
  println(78);
  println(79);

  /************************/
  // acc - stack8
  // byte - byte
  //TODO
  println(80);
  println(81);
  // byte - integer
  //TODO
  println(82);
  println(83);
  // integer - byte
  //TODO
  println(84);
  println(85);
  // integer - integer
  //TODO
  println(86);
  println(87);

  /************************/
  // var - constant
  // byte - byte
  b=88;
  do { println (b); b++; } while (b <= 89);
  // byte - integer
  //not relevant
  println(90);
  println(91);
  // integer - byte
  i=92;
  do { println (i); i++; } while (i <= 93);
  // integer - integer
  i=1094;
  b=94;
  do { println (b); b++; i++; } while (i <= 1095  );

  /************************/
  // var - acc
  // byte - byte
  do { println (b); b++; } while (b <= 97+0);
  // byte - integer
  //not relevant
  i=99;
  do { println (b); b++; } while (b <= i+0);
  // integer - byte
  i=100;
  do { println (i); i++; } while (i <= 101+0);
  // integer - integer
  i=1102;
  b=102;
  do { println (b); b++; i++; } while (i <= 1103+0);

  /************************/
  // var - var
  // byte - byte
  byte b2 = 105;
  do { println (b); b++; } while (b <= b2);
  // byte - integer
  i=107;
  do { println (b); b++; } while (b <= i);
  // integer - byte
  i=b;
  b=109;
  do { println (i); i++; } while (i <= b);
  // integer - integer
  word i2 = 111;
  do { println (i); i++; } while (i <= i2);

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

  println("Klaar");
}