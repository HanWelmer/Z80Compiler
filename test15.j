/* Program to test bitwise operators and, or and xor. */
class TestBitwiseOperators {
  println(0);
  
  // Possible operand types: constant, acc, var, final var, stack8, stack16.
  // Possible data types: byt, word.

  //constant byte/constant byte
  if (0x07 & 0x1C == 0x04) println (1); else println (999); //0000.0111 & 0001.1100 = 0000.0100
  if (0x07 | 0x1C == 0x1F) println (2); else println (999); //0000.0111 | 0001.1100 = 0001.1111
  if (0x07 ^ 0x1C == 0x1B) println (3); else println (999); //0000.0111 ^ 0001.1100 = 0001.1011
  //constant word/constant word
  if (0x1234 & 0x032C == 0x0224) println (4); else println (999);
  //0001.0010.0011.0100 & 0000.0011.0010.1100 = 0000.0010.0010.0100
  if (0x1234 | 0x032C == 0x133C) println (5); else println (999);
  //0001.0010.0011.0100 | 0000.0011.0010.1100 = 0001.0011.0011.1100
  if (0x1234 ^ 0x032C == 0x1118) println (6); else println (999);
  //0001.0010.0011.0100 ^ 0000.0011.0010.1100 = 0001.0001.0001.1000
  //constant byt/constant word
  if (0x1C & 0x1234 == 0x0014) println (7); else println (999); //0001.1100 & 0001.0010.0011.0100 = 0000.0000.0001.0100
  if (0x1C | 0x1234 == 0x123C) println (8); else println (999); //0001.1100 | 0001.0010.0011.0100 = 0001.0010.0011.1100
  if (0x1C ^ 0x1234 == 0x1228) println (9); else println (999); //0001.1100 ^ 0001.0010.0011.0100 = 0001.0010.0010.1000
  //constant word/constant byt
  if (0x1234 & 0x1C == 0x0014) println (10); else println (999); //0001.0010.0011.0100 & 0001.1100 = 0000.0000.0001.0100
  if (0x1234 | 0x1C == 0x123C) println (11); else println (999); //0001.0010.0011.0100 | 0001.1100 = 0001.0010.0011.1100
  if (0x1234 ^ 0x1C == 0x1228) println (12); else println (999); //0001.0010.0011.0100 ^ 0001.1100 = 0001.0010.0010.1000

  println("Klaar");
}