/*
 * A small program in the miniJava language.
 * Test something
 */
class TestWrite {
  word zero = 0;
  byte one = 1;
  println(zero);
  println(one);
  println(2);
  println("3  Drie keer.");
  println("3  Drie keer.");
  println("3  Drie keer.");
  println("4  Hier klinkt een bel\a en dan gaan we door.");
  println("5  Dit is pagina 1.\f   En dit is pagina 2.");
  println("6  Dit is gu\boed.");
  println("7  Getal na een tab\t1.");
  println("8  Dit zie je niet\r8  Dit zie je wel.");
  println("9  Dit is regel 1.\n   En dit regel 2.");
  println("10 Hier komt een dubbele quote \".");
  println("11 Hier komt een single quote \'.");
  println("12 Hier komt een backslash \\.");
  String str = "13 Hallo wereld.";
  println(str);
  println(7 * 2);
  println(7 + 2 * 4);
  println(2 * 6 + 4);
  println(9 + 2 * (1 + 3));
  println("18 Hallo" + " wereld.");
  println("19 Nog" + " een" + " bericht.");
  println("12 + 8 = " + 20);
  println("7 * 3 = " + (7 * 3));
  println("10 + 12 = " + (10 + 12) + ".");
  println("Klaar");
}
