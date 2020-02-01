/*
 * A small program in the miniJava language.
 * Test 8-bit and 16-bit expressions.
 */
class Test8And16BitExpressions {
  write(0);         // 0
  //LD    A,0
  //CALL  writeA
  //OK

  byte b = 1;
  byte c = 4;
  write(b);         // 1
  //LD    A,1
  //LD    (04000H),A
  //LD    A,(04000H)
  //CALL  writeA
  //OK

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

  b = 255;
  write(b);         // 255
  //LD    A,255
  //LD    (04001H),A
  //LD    A,(04001H)
  //CALL  writeA
  //OK

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
}
