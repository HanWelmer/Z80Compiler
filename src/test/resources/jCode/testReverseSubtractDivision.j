/*
 * A small program in the miniJava language.
 * Test 8-bit and 16-bit expressions.
 */
class TestReverseSubtractDivision {
  private static byte b;
  private static byte c;
  private static byte d;
  private static word i;
  private static word j;
  private static word k;

  public static void main() {
    println(0);
    /*************************/
    /* reverse subtract byte */
    /*************************/
    println(10 - 3*3);         // 1
    b = 11;
    println(b - 3*3);          // 2
    c = 3;
    d = 3;
    println(12 - c*d);         // 3
    b = 13;
    println(b - c*d);          // 4
  
    /**************************/
    /* reverse subtract word  */
    /**************************/
    println(1005 - 1000*1);    // 5
    i = 1006;
    println(i - 1000*1);       // 6
    j = 1000;
    k = 1;
    println(1007 - j*k);       // 7
    i = 1008;
    println(i - j*k);          // 8
  
    /***********************/
    /* reverse divide byte */
    /***********************/
    println(36 / (4*1));     // 9
    b = 40;
    println(b / (4*1));      // 10
    c = 4;
    d = 1;
    println(44 / (c*d));     // 11
    b = 48;
    println(b / (c*d));      // 12
  
    /************************/
    /* reverse divide word  */
    /************************/
    println(3900 / (300*1)); // 13
    i = 4200;
    println(i / (300*1));    // 14
    j = 300;
    k = 1;
    println(4500 / (j*k));   // 15
    i = 4800;
    println(i / (j*k));      // 16
  
    /**************************/
    /* reverse subtract mixed */
    /**************************/
    i = 21;
    c = 4;
    d = 1;
    println(i - c*d);           // 17
    b = 22;
    j = 4;
    k = 1;
    println(b - j*k);           // 18
  
    /**************************/
    /* reverse divide mixed   */
    /**************************/
  
    /**************************/
    /* forward divide mixed   */
    /**************************/
    i = 19;
    println(i / (1+0));         // 19
    
    println(i + 1);             // 20
    println(2 + i);             // 21
    println(2*5+3*4);           // 22
    println(120/4-(3+8/2));     // 23
    println("Klaar");
  }
}
