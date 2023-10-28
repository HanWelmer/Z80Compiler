/*
 * A small program in the miniJava language.
 * Test 8-bit and 16-bit expressions.
 */
class Test8And16BitExpressions {
  println(0);         // 0
  //LD    A,0
  //CALL  writeA
  //OK

  /*********************/
  /* Single term 8-bit */
  /*********************/
  byte b = 1;
  byte c = 4;
  println(b);         // 1
  //LD    A,1
  //LD    (04000H),A
  //LD    A,(04000H)
  //CALL  writeA
  //OK

  /************************/
  /* Dual term addition   */
  /************************/
  println(0 + 2);     // 2
  println(b + 2);     // 3
  println(3 + b);     // 4
  println(b + c);     // 5

  c = 4 + 2;
  println(c);         // 6
  c = b + 6;
  println(c);         // 7
  c = 7 + b;
  println(c);         // 8
  c = b + c;
  println(c);         // 9


  word i = 10;
  println(i);         // 10
  //LD    A,10
  //LD    L,A
  //LD    H,0
  //LD    (04004H),HL
  //OK
  
  println(i + 1);     // 11
  println(2 + i);     // 12
  b = 3;
  println(i + b);     // 13
  b++; //4
  println(b + i);     // 14

  word j = i + 5;    // 15
  println(j);
  j = 6 + i;        // 16
  println(j);
  j = 7;
  j = i + j;        // 17
  println(j);

  /*************************/
  /* Dual term subtraction */
  /*************************/
  b = 33;
  c = 12;
  println(19 - 1);    // 18
  println(b - 14);    // 19
  println(53 - b);    // 20
  println(b - c);     // 21

  c = 24 - 2;
  println(c);         // 22
  c = b - 10;
  println(c);         // 23
  c = 57 - b;
  println(c);         // 24
  c = 8;
  c = b - c;
  println(c);         // 25

  i = 40;
  println(i - 14);    // 26
  println(67 - i);    // 27
  b = 12;
  println(i - b);     // 28
  b = 69;
  println(b - i);     // 29

  j = i - 10;
  println(j);         // 30
  j = 71 - i;
  println(j);         // 31
  j = 8;
  j = i - j;
  println(j);         // 32
  
  /****************************/
  /* Dual term multiplication */
  /****************************/
  println(3 * 11);    // 33
  b = 17;
  println(b * 2);     // 34
  b = 7;
  println(5 * b);     // 35
  b = 2;
  c = 18;
  println(b * c);     // 36
  
  c = 37 * 1;
  println(c);         // 37
  b = 2;
  c = b * 19;
  println(c);         // 38
  b = 3;
  c = 13 * b;
  println(c);         // 39
  b = 5;
  c = 8;
  c = b * c;
  println(c);         // 40

  /**********************/
  /* Dual term division */
  /**********************/
  println(123 / 3);   // 41
  b = 126;
  println(b / 3);     // 42
  b = 3;
  println(129 / b);   // 43
  b = 132;
  c = 3;
  println(b / c);     // 44
  
  c = 135 / 3;
  println(c);         // 45
  b = 138;
  c = b / 3;
  println(c);         // 46
  b = 3;
  c = 141 / b;
  println(c);         // 47
  b = 144;
  c = 3;
  c = b / c;
  println(c);         // 48

  /*************************/
  /* possible loss of data */
  /*************************/
  println("Nu komen 251 en 252");
  b = 507;
  println(b);         // 251
  i = 508;
  b = i;
  println(b);         // 252

  println("Nu komen -253 en -254");
  b = b - 505;
  println(b);         // 252 - 505 = -253
  i = i + 5;
  b = b - i;
  println(b);         // -233 - 11 = -254
  
  println("Nu komen 255 en 256");
  b = 255;
  println(b);         // 255
  //LD    A,255
  //LD    (04001H),A
  //LD    A,(04001H)
  //CALL  writeA
  //OK

  /**********************/
  /* Single term 16-bit */
  /**********************/
  i = 256;
  println(i);         // 256
  //LD    HL,256
  //LD    (04006H),HL
  //LD    HL,(04006H)
  //CALL  writeHL
  //OK

  println("Nu komen 1000..1047");
  println(1000);      // 1000
  j = 1001;
  println(j);         // 1001

  /************************/
  /* Dual term addition   */
  /************************/
  println(1000 + 2);  // 1002
  println(3 + 1000);  // 1003
  println(500 + 504); // 1004
  i = 1000 + 5;
  println(i);         // 1005
  i = 6 + 1000;
  println(i);         // 1006
  i = 500 + 507;
  println(i);         // 1007
  
  j = 1000;
  b = 10;
  i = 514;
  println(j + 8);     // 1008
  println(9 + j);     // 1009
  println(j + b);     // 1010
  b++;
  println(b + j);     // 1011
  j = 500;
  println(j + 512);   // 1012
  println(513 + j);   // 1013
  println(i + j);     // 1014
  
  j = 1000;
  b = 17;
  i = j + 15;
  println(i);         // 1015
  i = 16 + j;
  println(i);         // 1016
  i = j + b;
  println(i);         // 1017
  b++;
  i = b + j;
  println(i);         // 1018
  j = 500;
  i = j + 519;
  println(i);         // 1019
  i = 520 + j;
  println(i);         // 1020
  i = 521;
  i = i + j;
  println(i);         // 1021
  
  /*************************/
  /* Dual term subtraction */
  /*************************/
  println(1024 - 2);  // 1022
  println(1523 - 500);// 1023
  i = 1030 - 6;
  println(i);         // 1024
  i = 1525 - 500;
  println(i);         // 1025
  
  j = 1040;
  b = 13;
  i = 3030;
  println(j - 14);    // 1026
  println(j - b);     // 1027
  j = 2000;
  println(j - 972);   // 1028
  println(3029 - j);  // 1029
  println(i - j);     // 1030
  
  j = 1050;
  b = 18;
  i = j - 19;
  println(i);         // 1031
  i = j - b;
  println(i);         // 1032
  j = 2000;
  i = j - 967;
  println(i);         // 1033
  i = 3034 - j;
  println(i);         // 1034
  i = 3035;
  i = i - j;
  println(i);         // 1035
  
  /****************************/
  /* Dual term multiplication */
  /****************************/
  println(518 * 2);   // 1036
  println(1 * 1037);  // 1037
  println(500 * 504 - 54354); // 1038 = 55392 - 54354

  i = 1039 * 1;
  println(i);         // 1039
  i = 2 * 520;
  println(i);         // 1040

  i = 1041;
  println(i * 1);     // 1041
  i = 521;
  println(2 * i);     // 1042

  i = 1043;
  i = i * 1;
  println(i);         // 1043
  i = 522;
  i = 2 * i;
  println(i);         // 1044

  i = 500 * 504 - 54347; // 1045 = 55392 - 54347
  println(i);         // 1045
  i = 500;
  i = i * 504 - 54346;
  println(i);         // 1046
  i = 504;
  i = 500 * i - 54345;
  println(i);         // 1047
  
  /************/
  /* Overflow */
  /************/
  println("Nu komen 24.764 en 25.064");
  println(300 * 301); // 90.300 % 65536 = 24.764
  i = 300 * 302;
  println(i);         // 90.600 % 65536 = 25.064

  /***************************/
  /* hex noatation constants */
  /***************************/
  println("hex notation constants");
  byte byteHex = 0x41;
  println(byteHex);
  word wordHex = 0x042A;
  println(wordHex);

  println("Klaar");
}
