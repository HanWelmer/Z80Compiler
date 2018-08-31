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
  int _Average := 0;
  if (NUMBER_OF_NUMBERS <> 0) _Average := sum / NUMBER_OF_NUMBERS;
  write(_Average);
  //comment after final }.
}
