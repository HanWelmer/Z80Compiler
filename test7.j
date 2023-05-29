/*
 * A small program in the miniJava language.
 * Test 8-bit and 16-bit expressions.
 */
class Test8And16BitExpressions {
  write(0);

  /**************************/
  /* Single term read: byte */
  /**************************/
  write(1);          // 1

  write("\nType 2, 3, 4 etc");
  write(read);       // 2
  byte b = read;
  write(b);       // 3

  /**********************************/
  /* Dual term read: byte constants */
  /**********************************/
  write(read + 0);   // 4 + 0 = 4
  write(0 + read);   // 0 + 5 = 5
  write(read - 0);   // 6 - 0 = 6
  write(14 - read);  // 14 - 7 = 7
  write(read * 1);   // 8 * 1 = 8
  write(1 * read);   // 1 * 9 = 9
  write(read / 1);   // 10 / 1 = 10
  write(121 / read); // 121 / 11 = 11
  
  write("\nType 1048 etc");
  /**************************/
  /* Single term read: word */
  /**************************/
  write(read);      // 1048
  word i = read;
  write(i);         // 1049

  /**********************************/
  /* Dual term read: word constants */
  /**********************************/
  write("\nType 1050 expect 2050");
  write(read + 1000);   // 1050 + 1000 = 2050
  write("\nType 1051 expect 2051");
  write(1000 + read);   // 1000 + 1051 = 2051
  write("\nType 1052 expect 52");
  write(read - 1000);   // 1052 - 1000 =   52
  write("\nType 1053 expect 1053");
  write(2106 - read);   // 2106 - 1053 = 1053
  write("\nType 1054 expect 5254");
  write(read * 1000);   // 1054 * 1000 = 5254
  write("\nType 1055 expect 6424");
  write(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
  write("\nType 1056 expect 1");
  write(read / 1000);   // 1056 / 1000 = 1
  write("\nType 1057 expect 2");
  write(2114 / read);   // 2114 / 1057 = 2
  
  /****************************************/
  /* Dual term read: word + byte variable */
  /****************************************/
  write("\nType 1058 etc");
  b = 0;
  write(read + b);   // 1058 + 0 = 1058
  write(b + read);   // 0 + 1059 = 1059
  write(read - b);   // 1060 - 0 = 1060
  write("\nType 1061 expect -1061");
  write(b - read);   // 0 - 1061 = -1061
  b = 1;
  write("\nType 1062 etc");
  write(read * b);   // 1062 * 1 = 1062
  write(b * read);   // 1 * 1063 = 1063
  write(read / b);   // 1064 / 1 = 1064
  b = 12;
  write("\nType 3 expect 4");
  write(3);
  write(b / read);   // 12 / 3 = 4
  
  /****************************************/
  /* Dual term read: word + word variable */
  /****************************************/
  i = 0;
  write("\nType 1066 etc");
  write(read + i);   // 1066 + 0 = 1066
  write(i + read);   // 0 + 1067 = 1067
  write(read - i);   // 1068 - 0 = 1068
  write("\nType 1069 expect -1069");
  write(i - read);   // 0 - 1069 = -1069
  i = 1;
  write("\nType 1070 etc");
  write(read * i);   // 1070 * 1 = 1070
  write(i * read);   // 1 * 1071 = 1071
  write(read / i);   // 1072 / 1 = 1072
  i = 3219;
  write("\nType 3 expect 1073");
  write(i / read);   // 3219 / 3 = 1073  
  write("Klaar");
}
