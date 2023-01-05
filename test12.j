/*
 * A small program in the miniJava language.
 * Test something
 */
class TestWrite {
  word zero = 0;
  byte one = 1;
  write(13);
  write("12 Hier komt een backslash \\");
  write("11 Hier komt een single quote \'");
  write("10 Hier komt een dubbele quote \"");
  write("9  Dit is regel 1.\n   En dit regel 2.");
  write("8  Dit zie je niet\r8  Dit zie je wel.");
  write("7  Getal na een tab\t1");
  write("6  Dit is gu\boed.");
  write("5  Dit is pagina 1.\f   En dit is pagina 2.");
  write("4  Hier klinkt een bel\a en dan gaan we door.");
  write("3 Drie keer.");
  write("3 Drie keer.");
  write("3 Drie keer.");
  write(2);
  write(one);
  write(zero);
}
