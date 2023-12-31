/* Program to test generated Z80 assembler code */
class TestWhile {
  byte b = 0;
  byte b2 = 32;
  word i = 110;
  word i2 = 105;
  word p = 12;
  public static void main() {
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
    // global variable within while scope
    b++;
    println (b);
    while (b < 2) {
      b++;
      word j = 1001;
      byte c = b;
      byte d = c;
      println (c);
    }
  
    /************************/
    // constant - constant
    // not relevant
  
    /************************/
    // constant - acc
    // byte - byte
    b = 3;
    while (3 == b+0) { println (b); b++; }
    while (4 != b+0) { println (b); b++; }
    while (6 > b+0) { println (b); b++; }
    while (7 >= b+0) { println (b); b++; }
    p=8;
    while (6 <  b+0) { println (p); p++; b--; }
    while (5 <= b+0) { println (p); p++; b--; }
    
    // constant - acc
    // byte - integer
    i=12;
    while (12 == i+0) { println (i); i++; }
    while (15 != i+0) { println (i); i++; }
    while (17 > i+0) { println (i); i++; }
    while (18 >= i+0) { println (i); i++; }
    p=i;
    while (17 <  i+0) { println (p); i--; p++; }
    while (16 <= i+0) { println (p); i--; p++; }
  
    // constant - acc
    // integer - byte
    // not relevant
  
    // constant - acc
    // integer - integer
    i=23;
    while (23 == i+0) { println (i); i++; }
    while (26 != i+0) { println (i); i++; }
    while (28 > i+0) { println (i); i++; }
    while (29 >= i+0) { println (i); i++; }
    p=i;
    while (28 <  i+0) { println (p); p++; i--; }
    while (27 <= i+0) { println (p); p++; i--; }
  
    /************************/
    // constant - var
    // byte - byte
    b=35;
    while (33 <= b) { println (p); p++; b--; }
    // constant - var
    // byte - integer
    i=37;
    while (36 <= i) { println (p); p++; i--; }
    // constant - var
    // integer - byte
    // not relevant
  
    // constant - var
    // integer - integer
    while (34 <= i) { println (p); p++; i--; }
  
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
    b=33;
    while (b2 <= b) { println (p); p++; b--; }
    // byte - integer
    i = 33;
    while (b2 <= i) { println (p); p++; i--; }
    // integer - byte
    b=33;
    i=b2;
    while (i <= b) { println (p); p++; b--; }
    // integer - integer
    i=33;
    i2=b2;
    while (i2 <= i) { println (p); p++; i--; }
  
    /************************/
    // var - acc
    // byte - byte
    b=49;
    while (b <= 50+0) { println (b); b++; }
    // byte - integer
    i=52;
    while (b <= i+0) { println (b); b++; }
    // integer - byte
    i=b;
    while (i <= 54+0) { println (i); i++; }
    // integer - integer
    b=i;
    i=1098;
    while (i <= 1099+0) { println (b); b++; i++; }
  
    /************************/
    // var - constant
    // byte - byte
    while (b <= 58) { println (b); b++; }
    // byte - integer
    //not relevant
  
    // integer - byte
    i=b;
    while (i <= 60) { println (i); i++; }
    // integer - integer
    i2=1090;
    while (i2 <= 1091) { println (i); i++; i2++; }
  
    /************************/
    // acc - stack8
    // byte - byte
    //TODO
    println(63);
    println(64);
    // byte - integer
    //TODO
    println(65);
    println(66);
    // integer - byte
    //TODO
    println(67);
    println(68);
    // integer - integer
    //TODO
    println(69);
    println(70);
  
    /************************/
    // acc - stack16
    // byte - byte
    //TODO
    println(71);
    println(72);
    // byte - integer
    //TODO
    println(73);
    println(74);
    // integer - byte
    //TODO
    println(75);
    println(76);
    // integer - integer
    //TODO
    println(77);
    println(78);
  
    /************************/
    // acc - var
    // byte - byte
    b=79;
    b2=79;
    while (78+0 <= b2) { println (b); b++; b2--; }
    // byte - integer
    i=79;
    while (78+0 <= i) { println (b); b++; i--; }
    // integer - byte
    i=78;
    b2=79;
    while (i+0 <= b2) { println (b); b++; b2--; } 
    // integer - integer
    i=1066;
    while (1000+65 <= i) { println (b); b++; i--; }
  
    /************************/
    // acc - acc
    // byte - byte
    b=87;
    b2=64;
    while (63+0 <= b2+0) { println (b); b++; b2--; }
    // byte - integer
    i=62;
    while (61+0 <= i+0) { println (b); b++; i--; }
    // integer - byte
    i=59;
    b2=60;
    while (i+0 <= b2+0) { println (b); b++; b2--; }
    // integer - integer
    i=1058;
    while (1000+57 <= i+0) { println (b); b++; i--; }
  
    /************************/
    // acc - constant
    // byte - byte
    while (b+0 <= 96) { println (b); b++; }
    // byte - integer
    //not relevant
    // integer - byte
    i=b;
    while (i+0 <= 98) { println (i); i++; }
    b=i;
    i=1052;
    // integer - integer
    while (i+0 <= 1053) { println (b); b++; i++; }
  
    /************************/
    // constant - stack8
    // byte - byte
    //TODO
    println(101);
    println(102);
    // constant - stack8
    // byte - integer
    //TODO
    println(103);
    println(104);
    // constant - stack8
    // integer - byte
    //TODO
    println(105);
    println(106);
    // constant - stack88
    // integer - integer
    //TODO
    println(107);
    println(108);
  
    /************************/
    // constant - stack16
    // byte - byte
    //TODO
    println(109);
    println(110);
    // constant - stack16
    // byte - integer
    //TODO
    println(111);
    println(112);
    // constant - stack16
    // integer - byte
    //TODO
    println(113);
    println(114);
    // constant - stack16
    // integer - integer
    //TODO
    println(115);
    println(116);
  
    println("Klaar");
  }
}