/* Program to test bitwise operators and, or and xor. */
class TestBitwiseOperators {
  println(0);
  
  // Possible operand types: constant, acc, var, final var, stack8, stack16.
  // Possible data types: byt, word.

  byte b1 = 0x1C;
  byte b2 = 0x07;
  word w1 = 0x032C;
  word w2 = 0x1234;
  final byte fb1 = 0x1C;
  final byte fb2 = 0x07;
  final word fw1 = 0x032C;
  final word fw2 = 0x1234;

  //constant/constant
  //*****************
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

  //constant/acc
  //************
  //constant byte/acc byte
  if (0x07 & (0x10 + 0x0C) == 0x04) println (13); else println (999);
  if (0x07 | (0x10 + 0x0C) == 0x1F) println (14); else println (999);
  if (0x07 ^ (0x10 + 0x0C) == 0x1B) println (15); else println (999);
  //constant word/acc word
  if (0x1234 & 0x0100 + 0x022C == 0x0224) println (16); else println (999);
  if (0x1234 | 0x0100 + 0x022C == 0x133C) println (17); else println (999);
  if (0x1234 ^ 0x0100 + 0x022C == 0x1118) println (18); else println (999);
  //constant byt/acc word
  if (0x1C & 0x1000 + 0x0234 == 0x0014) println (19); else println (999);
  if (0x1C | 0x1000 + 0x0234 == 0x123C) println (20); else println (999);
  if (0x1C ^ 0x1000 + 0x0234 == 0x1228) println (21); else println (999);
  //constant word/acc byt
  if (0x1234 & 0x10 + 0x0C == 0x0014) println (22); else println (999);
  if (0x1234 | 0x10 + 0x0C == 0x123C) println (23); else println (999);
  if (0x1234 ^ 0x10 + 0x0C == 0x1228) println (24); else println (999);

  //constant/var
  //*****************
  //constant byte/var byte
  if (0x07 & b1 == 0x04) println (25); else println (999);
  if (0x07 | b1 == 0x1F) println (26); else println (999);
  if (0x07 ^ b1 == 0x1B) println (27); else println (999);
  //constant word/var word
  if (0x1234 & w1 == 0x0224) println (28); else println (999);
  if (0x1234 | w1 == 0x133C) println (29); else println (999);
  if (0x1234 ^ w1 == 0x1118) println (30); else println (999);
  //constant byt/var word
  if (0x1C & w2 == 0x0014) println (31); else println (999);
  if (0x1C | w2 == 0x123C) println (32); else println (999);
  if (0x1C ^ w2 == 0x1228) println (33); else println (999);
  //constant word/var byt
  if (0x1234 & b1 == 0x0014) println (34); else println (999);
  if (0x1234 | b1 == 0x123C) println (35); else println (999);
  if (0x1234 ^ b1 == 0x1228) println (36); else println (999);

  //constant/final var
  //*****************
  //constant byte/final var byte
  if (0x07 & fb1 == 0x04) println (37); else println (999);
  if (0x07 | fb1 == 0x1F) println (38); else println (999);
  if (0x07 ^ fb1 == 0x1B) println (39); else println (999);
  //constant word/final var word
  if (0x1234 & fw1 == 0x0224) println (40); else println (999);
  if (0x1234 | fw1 == 0x133C) println (41); else println (999);
  if (0x1234 ^ fw1 == 0x1118) println (42); else println (999);
  //constant byt/final var word
  if (0x1C & fw2 == 0x0014) println (43); else println (999);
  if (0x1C | fw2 == 0x123C) println (44); else println (999);
  if (0x1C ^ fw2 == 0x1228) println (45); else println (999);
  //constant word/final var byt
  if (0x1234 & fb1 == 0x0014) println (46); else println (999);
  if (0x1234 | fb1 == 0x123C) println (47); else println (999);
  if (0x1234 ^ fb1 == 0x1228) println (48); else println (999);

  //acc/constant
  //************
  //acc byte/constant byte
  if ((0x04 + 0x03) & 0x1C == 0x04) println (49); else println (999);
  if ((0x04 + 0x03) | 0x1C == 0x1F) println (50); else println (999);
  if ((0x04 + 0x03) ^ 0x1C == 0x1B) println (51); else println (999);
  //acc word/constant word
  if (0x1000 + 0x0234 & 0x032C == 0x0224) println (52); else println (999);
  if (0x1000 + 0x0234 | 0x032C == 0x133C) println (53); else println (999);
  if (0x1000 + 0x0234 ^ 0x032C == 0x1118) println (54); else println (999);
  //acc byt/constant word
  if (0x10 + 0x0C & 0x1234 == 0x0014) println (55); else println (999);
  if (0x10 + 0x0C | 0x1234 == 0x123C) println (56); else println (999);
  if (0x10 + 0x0C ^ 0x1234 == 0x1228) println (57); else println (999);
  //acc word/constant byt
  if (0x1000 + 0x0234 & 0x1C == 0x0014) println (58); else println (999);
  if (0x1000 + 0x0234 | 0x1C == 0x123C) println (59); else println (999);
  if (0x1000 + 0x0234 ^ 0x1C == 0x1228) println (60); else println (999);

  //acc/acc
  //*******
  //acc byte/acc byte
  if (0x04 + 0x03 & 0x10 + 0x0C == 0x04) println (61); else println (999);
  if (0x04 + 0x03 | 0x10 + 0x0C == 0x1F) println (62); else println (999);
  if (0x04 + 0x03 ^ 0x10 + 0x0C == 0x1B) println (63); else println (999);
  //acc word/acc word
  if (0x1000 + 0x0234 & 0x0100 + 0x022C == 0x0224) println (64); else println (999);
  if (0x1000 + 0x0234 | 0x0100 + 0x022C == 0x133C) println (65); else println (999);
  if (0x1000 + 0x0234 ^ 0x0100 + 0x022C == 0x1118) println (66); else println (999);
  //acc byt/acc word
  if (0x10 + 0x0C & 0x1000 + 0x0234 == 0x0014) println (67); else println (999);
  if (0x10 + 0x0C | 0x1000 + 0x0234 == 0x123C) println (68); else println (999);
  if (0x10 + 0x0C ^ 0x1000 + 0x0234 == 0x1228) println (69); else println (999);
  //acc word/acc byt
  if (0x1000 + 0x0234 & 0x10 + 0x0C == 0x0014) println (70); else println (999);
  if (0x1000 + 0x0234 | 0x10 + 0x0C == 0x123C) println (71); else println (999);
  if (0x1000 + 0x0234 ^ 0x10 + 0x0C == 0x1228) println (72); else println (999);

  //acc/var
  //*******
  //acc byte/var byte
  if (0x04 + 0x03 & b1 == 0x04) println (73); else println (999);
  if (0x04 + 0x03 | b1 == 0x1F) println (74); else println (999);
  if (0x04 + 0x03 ^ b1 == 0x1B) println (75); else println (999);
  //acc word/var word
  if (0x1000 + 0x0234 & w1 == 0x0224) println (76); else println (999);
  if (0x1000 + 0x0234 | w1 == 0x133C) println (77); else println (999);
  if (0x1000 + 0x0234 ^ w1 == 0x1118) println (78); else println (999);
  //acc byt/var word
  if (0x10 + 0x0C & w2 == 0x0014) println (79); else println (999);
  if (0x10 + 0x0C | w2 == 0x123C) println (80); else println (999);
  if (0x10 + 0x0C ^ w2 == 0x1228) println (81); else println (999);
  //acc word/var byt
  if (0x1000 + 0x0234 & b1 == 0x0014) println (82); else println (999);
  if (0x1000 + 0x0234 | b1 == 0x123C) println (83); else println (999);
  if (0x1000 + 0x0234 ^ b1 == 0x1228) println (84); else println (999);

  //acc/final var
  //*************
  //acc byte/final var byte
  if (0x04 + 0x03 & fb1 == 0x04) println (85); else println (999);
  if (0x04 + 0x03 | fb1 == 0x1F) println (86); else println (999);
  if (0x04 + 0x03 ^ fb1 == 0x1B) println (87); else println (999);
  //acc word/final var word
  if (0x1000 + 0x0234 & fw1 == 0x0224) println (88); else println (999);
  if (0x1000 + 0x0234 | fw1 == 0x133C) println (89); else println (999);
  if (0x1000 + 0x0234 ^ fw1 == 0x1118) println (90); else println (999);
  //acc byt/final var word
  if (0x10 + 0x0C & fw2 == 0x0014) println (91); else println (999);
  if (0x10 + 0x0C | fw2 == 0x123C) println (92); else println (999);
  if (0x10 + 0x0C ^ fw2 == 0x1228) println (93); else println (999);
  //acc word/final var byt
  if (0x1000 + 0x0234 & fb1 == 0x0014) println (94); else println (999);
  if (0x1000 + 0x0234 | fb1 == 0x123C) println (95); else println (999);
  if (0x1000 + 0x0234 ^ fb1 == 0x1228) println (96); else println (999);

  //var/constant
  //************
  //var byte/constant byte
  if (b2 & 0x1C == 0x04) println (97); else println (999);
  if (b2 | 0x1C == 0x1F) println (98); else println (999);
  if (b2 ^ 0x1C == 0x1B) println (99); else println (999);
  //var word/constant word
  if (w2 & 0x032C == 0x0224) println (100); else println (999);
  if (w2 | 0x032C == 0x133C) println (101); else println (999);
  if (w2 ^ 0x032C == 0x1118) println (102); else println (999);
  //var byt/constant word
  if (b1 & 0x1234 == 0x0014) println (103); else println (999);
  if (b1 | 0x1234 == 0x123C) println (104); else println (999);
  if (b1 ^ 0x1234 == 0x1228) println (105); else println (999);
  //var word/constant byt
  if (w2 & 0x1C == 0x0014) println (106); else println (999);
  if (w2 | 0x1C == 0x123C) println (107); else println (999);
  if (w2 ^ 0x1C == 0x1228) println (108); else println (999);

  //var/acc
  //*******
  //var byte/acc byte
  if (b2 & (0x10 + 0x0C) == 0x04) println (109); else println (999);
  if (b2 | (0x10 + 0x0C) == 0x1F) println (110); else println (999);
  if (b2 ^ (0x10 + 0x0C) == 0x1B) println (111); else println (999);
  //var word/acc word
  if (w2 & 0x0100 + 0x022C == 0x0224) println (112); else println (999);
  if (w2 | 0x0100 + 0x022C == 0x133C) println (113); else println (999);
  if (w2 ^ 0x0100 + 0x022C == 0x1118) println (114); else println (999);
  //var byt/acc word
  if (b1 & 0x1000 + 0x0234 == 0x0014) println (115); else println (999);
  if (b1 | 0x1000 + 0x0234 == 0x123C) println (116); else println (999);
  if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (117); else println (999);
  //var word/acc byt
  if (w2 & 0x10 + 0x0C == 0x0014) println (118); else println (999);
  if (w2 | 0x10 + 0x0C == 0x123C) println (119); else println (999);
  if (w2 ^ 0x10 + 0x0C == 0x1228) println (120); else println (999);

  //var/var
  //*******
  //var byte/var byte
  if (b2 & b1 == 0x04) println (121); else println (999);
  if (b2 | b1 == 0x1F) println (122); else println (999);
  if (b2 ^ b1 == 0x1B) println (123); else println (999);
  //var word/var word
  if (w2 & w1 == 0x0224) println (124); else println (999);
  if (w2 | w1 == 0x133C) println (125); else println (999);
  if (w2 ^ w1 == 0x1118) println (126); else println (999);
  //var byt/var word
  if (b1 & w2 == 0x0014) println (127); else println (999);
  if (b1 | w2 == 0x123C) println (128); else println (999);
  if (b1 ^ w2 == 0x1228) println (129); else println (999);
  //var word/var byt
  if (w2 & b1 == 0x0014) println (130); else println (999);
  if (w2 | b1 == 0x123C) println (131); else println (999);
  if (w2 ^ b1 == 0x1228) println (132); else println (999);

  //var/final var
  //*************
  //var byte/final var byte
  if (b2 & fb1 == 0x04) println (133); else println (999);
  if (b2 | fb1 == 0x1F) println (134); else println (999);
  if (b2 ^ fb1 == 0x1B) println (135); else println (999);
  //var word/final var word
  if (w2 & fw1 == 0x0224) println (136); else println (999);
  if (w2 | fw1 == 0x133C) println (137); else println (999);
  if (w2 ^ fw1 == 0x1118) println (138); else println (999);
  //var byt/final var word
  if (b1 & fw2 == 0x0014) println (139); else println (999);
  if (b1 | fw2 == 0x123C) println (140); else println (999);
  if (b1 ^ fw2 == 0x1228) println (141); else println (999);
  //var word/final var byt
  if (w2 & fb1 == 0x0014) println (142); else println (999);
  if (w2 | fb1 == 0x123C) println (143); else println (999);
  if (w2 ^ fb1 == 0x1228) println (144); else println (999);

  //final var/constant
  //******************
  //final var byte/constant byte
  if (b2 & 0x1C == 0x04) println (145); else println (999);
  if (b2 | 0x1C == 0x1F) println (146); else println (999);
  if (b2 ^ 0x1C == 0x1B) println (147); else println (999);
  //final var word/constant word
  if (w2 & 0x032C == 0x0224) println (148); else println (999);
  if (w2 | 0x032C == 0x133C) println (149); else println (999);
  if (w2 ^ 0x032C == 0x1118) println (150); else println (999);
  //final var byt/constant word
  if (b1 & 0x1234 == 0x0014) println (151); else println (999);
  if (b1 | 0x1234 == 0x123C) println (152); else println (999);
  if (b1 ^ 0x1234 == 0x1228) println (153); else println (999);
  //final var word/constant byt
  if (w2 & 0x1C == 0x0014) println (154); else println (999);
  if (w2 | 0x1C == 0x123C) println (155); else println (999);
  if (w2 ^ 0x1C == 0x1228) println (156); else println (999);

  //final var/acc
  //*************
  //final var byte/acc byte
  if (b2 & (0x10 + 0x0C) == 0x04) println (157); else println (999);
  if (b2 | (0x10 + 0x0C) == 0x1F) println (158); else println (999);
  if (b2 ^ (0x10 + 0x0C) == 0x1B) println (159); else println (999);
  //final var word/acc word
  if (w2 & 0x0100 + 0x022C == 0x0224) println (160); else println (999);
  if (w2 | 0x0100 + 0x022C == 0x133C) println (161); else println (999);
  if (w2 ^ 0x0100 + 0x022C == 0x1118) println (162); else println (999);
  //final var byt/acc word
  if (b1 & 0x1000 + 0x0234 == 0x0014) println (163); else println (999);
  if (b1 | 0x1000 + 0x0234 == 0x123C) println (164); else println (999);
  if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (165); else println (999);
  //final var word/acc byt
  if (w2 & 0x10 + 0x0C == 0x0014) println (166); else println (999);
  if (w2 | 0x10 + 0x0C == 0x123C) println (167); else println (999);
  if (w2 ^ 0x10 + 0x0C == 0x1228) println (168); else println (999);

  //final var/var
  //*************
  //final var byte/var byte
  if (b2 & b1 == 0x04) println (169); else println (999);
  if (b2 | b1 == 0x1F) println (170); else println (999);
  if (b2 ^ b1 == 0x1B) println (171); else println (999);
  //final var word/var word
  if (w2 & w1 == 0x0224) println (172); else println (999);
  if (w2 | w1 == 0x133C) println (173); else println (999);
  if (w2 ^ w1 == 0x1118) println (174); else println (999);
  //final var byt/var word
  if (b1 & w2 == 0x0014) println (175); else println (999);
  if (b1 | w2 == 0x123C) println (176); else println (999);
  if (b1 ^ w2 == 0x1228) println (177); else println (999);
  //final var word/var byt
  if (w2 & b1 == 0x0014) println (178); else println (999);
  if (w2 | b1 == 0x123C) println (179); else println (999);
  if (w2 ^ b1 == 0x1228) println (180); else println (999);

  //final var/final var
  //*******************
  //final var byte/final var byte
  if (fb2 & fb1 == 0x04) println (181); else println (999);
  if (fb2 | fb1 == 0x1F) println (182); else println (999);
  if (fb2 ^ fb1 == 0x1B) println (183); else println (999);
  //final var word/final var word
  if (fw2 & fw1 == 0x0224) println (184); else println (999);
  if (fw2 | fw1 == 0x133C) println (185); else println (999);
  if (fw2 ^ fw1 == 0x1118) println (186); else println (999);
  //final var byt/final var word
  if (fb1 & fw2 == 0x0014) println (187); else println (999);
  if (fb1 | fw2 == 0x123C) println (188); else println (999);
  if (fb1 ^ fw2 == 0x1228) println (189); else println (999);
  //final var word/final var byt
  if (fw2 & fb1 == 0x0014) println (190); else println (999);
  if (fw2 | fb1 == 0x123C) println (191); else println (999);
  if (fw2 ^ fb1 == 0x1228) println (192); else println (999);

  println("Klaar");
}