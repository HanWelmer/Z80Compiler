/*
 * A small program in the miniJava language.
 * Boek: Rachel Kushner: Club mars.
 */
class Average {
  private static word sum = 0;
  private static word NUMBER_OF_NUMBERS = 0;
  
  public static void main() {
    //read a new number and echo number to output
    println("Enter some numbers, 0 to finish:");
    word number = read; 
    println(number);
    while (number >= 1) /* not end of file */ {
      sum = sum + number;
      NUMBER_OF_NUMBERS = NUMBER_OF_NUMBERS + 1;
      //read a new number and echo number to output
      number = read;
      println(number);
    }
    /* multi line comment
     * with nested // end of line comment
     * is allowed.
     */
    println("number = " + NUMBER_OF_NUMBERS);
    println("total  = " + sum);
    word average;
    if (NUMBER_OF_NUMBERS == 0) {
      average = 0;
    } else {
      average = sum / NUMBER_OF_NUMBERS;
    }
    println("average = " + average);
  }
}
//comment after final }.
