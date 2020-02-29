/*
 * A small program in the miniJava language.
 * Test 8-bit and 16-bit expressions.
 */
class Test8And16BitExpressions {
  write(0);         // 0
  //LD    A,0
  //CALL  writeA
  //OK

  /*********************/
  /* Single term 8-bit */
  /*********************/
  byte b = 1;
  byte c = 4;
  write(b);         // 1
  //LD    A,1
  //LD    (04000H),A
  //LD    A,(04000H)
  //CALL  writeA
  //OK

  /************************/
  /* Dual term addition   */
  /************************/
  write(0 + 2);     // 2
  write(b + 2);     // 3
  write(3 + b);     // 4
  write(b + c);     // 5

  c = 4 + 2;
  write(c);         // 6
  c = b + 6;
  write(c);         // 7
  c = 7 + b;
  write(c);         // 8
  c = b + c;
  write(c);         // 9


  int i = 10;
  write(i);         // 10
  //LD    A,10
  //LD    L,A
  //LD    H,0
  //LD    (04004H),HL
  //OK
  
  write(i + 1);     // 11
  write(2 + i);     // 12
  b = 3;
  write(i + b);     // 13
  b++; //4
  write(b + i);     // 14

  int j = i + 5;    // 15
  write(j);
  j = 6 + i;        // 16
  write(j);
  j = 7;
  j = i + j;        // 17
  write(j);

  /*************************/
  /* Dual term subtraction */
  /*************************/
  b = 33;
  c = 12;
  write(19 - 1);    // 18
  write(b - 14);    // 19
  write(53 - b);    // 20
  write(b - c);     // 21

  c = 24 - 2;
  write(c);         // 22
  c = b - 10;
  write(c);         // 23
  c = 57 - b;
  write(c);         // 24
  c = 8;
  c = b - c;
  write(c);         // 25

  i = 40;
  write(i - 14);    // 26
  write(67 - i);    // 27
  b = 12;
  write(i - b);     // 28
  b = 69;
  write(b - i);     // 29

  j = i - 10;
  write(j);         // 30
  j = 71 - i;
  write(j);         // 31
  j = 8;
  j = i - j;
  write(j);         // 32
  
  /****************************/
  /* Dual term multiplication */
  /****************************/
  write(3 * 11);    // 33
  b = 17;
  write(b * 2);     // 34
  b = 7;
  write(5 * b);     // 35
  b = 2;
  c = 18;
  write(b * c);     // 36
  
  c = 37 * 1;
  write(c);         // 37
  b = 2;
  c = b * 19;
  write(c);         // 38
  b = 3;
  c = 13 * b;
  write(c);         // 39
  b = 5;
  c = 8;
  c = b * c;
  write(c);         // 40

  /**********************/
  /* Dual term division */
  /**********************/
  write(123 / 3);   // 41
  b = 126;
  write(b / 3);     // 42
  b = 3;
  write(129 / b);   // 43
  b = 132;
  c = 3;
  write(b / c);     // 44
  
  c = 135 / 3;
  write(c);         // 45
  b = 138;
  c = b / 3;
  write(c);         // 46
  b = 3;
  c = 141 / b;
  write(c);         // 47
  b = 144;
  c = 3;
  c = b / c;
  write(c);         // 48

  /**********************/
  /* Single term read   */
  /**********************/
  write(read);      // 49
  b = read;
  write(b);         // 50

  /**********************/
  /* Dual term read     */
  /**********************/
  write(read + 1);  // 50 + 1 = 51
  write(2 + read);  // 2 + 50 = 52
  write(read - 2);  // 55 - 2 = 53
  write(109 - read);  // 109 - 55 = 54
  write(read * 1);  // 55 * 1 = 55
  write(2 * read);  // 2 * 55 = 110
  write(read / 2);  // 110 / 2 = 55
  write(12 / read);  // 12 / 3 = 4

  /*************************/
  /* possible loss of data */
  /*************************/
  b = 507;
  write(b);         // 251
  i = 508;
  b = i;
  write(b);         // 252

  b = b - 505;
  write(b);         // 252 - 505 = -253
  i = i + 5;
  b = b - i;
  write(b);         // -233 - 11 = -254
  
  b = 255;
  write(b);         // 255
  //LD    A,255
  //LD    (04001H),A
  //LD    A,(04001H)
  //CALL  writeA
  //OK

  /**********************/
  /* Single term 16-bit */
  /**********************/
  i = 256;
  write(i);         // 256
  //LD    HL,256
  //LD    (04006H),HL
  //LD    HL,(04006H)
  //CALL  writeHL
  //OK

  write(1000);      // 1000
  j = 1001;
  write(j);         // 1001

  /************************/
  /* Dual term addition   */
  /************************/
  write(1000 + 2);  // 1002
  write(3 + 1000);  // 1003
  write(500 + 504); // 1004
  i = 1000 + 5;
  write(i);         // 1005
  i = 6 + 1000;
  write(i);         // 1006
  i = 500 + 507;
  write(i);         // 1007
  
  j = 1000;
  b = 10;
  i = 514;
  write(j + 8);     // 1008
  write(9 + j);     // 1009
  write(j + b);     // 1010
  b++;
  write(b + j);     // 1011
  j = 500;
  write(j + 512);   // 1012
  write(513 + j);   // 1013
  write(i + j);     // 1014
  
  j = 1000;
  b = 17;
  i = j + 15;
  write(i);         // 1015
  i = 16 + j;
  write(i);         // 1016
  i = j + b;
  write(i);         // 1017
  b++;
  i = b + j;
  write(i);         // 1018
  j = 500;
  i = j + 519;
  write(i);         // 1019
  i = 520 + j;
  write(i);         // 1020
  i = 521;
  i = i + j;
  write(i);         // 1021
  
  /*************************/
  /* Dual term subtraction */
  /*************************/
  write(1024 - 2);  // 1022
  write(1523 - 500);// 1023
  i = 1030 - 6;
  write(i);         // 1024
  i = 1525 - 500;
  write(i);         // 1025
  
  j = 1040;
  b = 13;
  i = 3030;
  write(j - 14);    // 1026
  write(j - b);     // 1027
  j = 2000;
  write(j - 972);   // 1028
  write(3029 - j);  // 1029
  write(i - j);     // 1030
  
  j = 1050;
  b = 18;
  i = j - 19;
  write(i);         // 1031
  i = j - b;
  write(i);         // 1032
  j = 2000;
  i = j - 967;
  write(i);         // 1033
  i = 3034 - j;
  write(i);         // 1034
  i = 3035;
  i = i - j;
  write(i);         // 1035
  
  /****************************/
  /* Dual term multiplication */
  /****************************/
  write(518 * 2);   // 1036
  write(1 * 1037);  // 1037
  write(500 * 504 - 54354); // 1038 = 55392 - 54354

  i = 1039 * 1;
  write(i);         // 1039
  i = 2 * 520;
  write(i);         // 1040

  i = 1041;
  write(i * 1);     // 1041
  i = 521;
  write(2 * i);     // 1042

  i = 1043;
  i = i * 1;
  write(i);         // 1043
  i = 522;
  i = 2 * i;
  write(i);         // 1044

  i = 500 * 504 - 54347; // 1045 = 55392 - 54347
  write(i);         // 1045
  i = 500;
  i = i * 504 - 54346;
  write(i);         // 1046
  i = 504;
  i = 500 * i - 54345;
  write(i);         // 1047
  /************/
  /* Overflow */
  /************/
  write(300 * 301); // 90.300 % 65536 = 24.764
  i = 300 * 302;
  write(i);         // 90.600 % 65536 = 25.064

}
