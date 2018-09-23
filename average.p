/*
 * A small program in the miniJava language.
 * Boek: Rachel Kushner: Club mars.
 */
class Average {
  int sum := 0;
  int NUMBER_OF_NUMBERS := 0;
  //read a new number and echo number to output
  int number := read; 
  write(number);
  while (number <> 0) /* not end of file */ {
    sum := sum + number;
    NUMBER_OF_NUMBERS := NUMBER_OF_NUMBERS + 1;
    //read a new number and echo number to output
    number := read;
    write(number);
  }
  /* multi line comment
   * with nested // end of line comment
   * is allowed.
   */
  write(NUMBER_OF_NUMBERS);
  write(sum);
  int average := 99;
  if (NUMBER_OF_NUMBERS <> 0) {
    average := sum / NUMBER_OF_NUMBERS;
  } else {
    average := 0;
  }
  write(average);
}
//comment after final }.
