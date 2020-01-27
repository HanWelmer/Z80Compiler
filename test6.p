/*
 * A small program in the miniJava language.
 * Test 8-bit and 16-bit operations
 */
class TestComparison {
  write(0);
  //LD    A,0
  //CALL  writeA
  //OK

  byte c = 1;
  //LD    A,1
  //LD    (04000H),A
  //OK

  write(c);
  //LD    A,(04000H)
  //CALL  writeA
  //OK

  byte b = 0 + 2;
  //LD    A,0
  //ADD   A,2
  //LD    (04001H),A
  //OK

  write(b);
  //LD    A,(04001H)
  //CALL  writeA
  //OK

  byte e = 2;
  //LD    A,2
  //LD    (04002H),A
  //OK

  byte d = 1;
  //LD    A,1
  //LD    (04003H),A
  //OK

  write(d + e);
  //LD    A,(04003H)
  //LD    B,A
  //LD    A,(04002H)
  //ADD   A,B
  //CALL  writeA
  //OK

  write(2 + e);
  //LD    A,2
  //LD    B,A
  //LD    A,(04002H)
  //ADD   A,B
  //CALL  writeA
  //OK

  write(d + 4);
  //LD    A,(04003H)
  //ADD   A,4
  //CALL  writeA
  //OK

  int j = 5;
  //LD    A,5
  //LD    L,A
  //LD    H,0
  //LD    (04004H),HL
  //OK
  
  write(j + 1);
  write(j + e);
  e++;
  write(e + j);

  d = e + 6;
  write(d);
  d = 7 + e;
  write(d);
  e = d + c;
  write(e);

  b = 255;
  //LD    A,255
  //LD    (04001H),A
  //OK

  write(b);
  //LD    A,(04001H)
  //CALL  writeA
  //OK

  int i = 256;
  //LD    HL,256
  //LD    (04006H),HL
  //OK

  write(i);
  //LD    HL,(04006H)
  //CALL  writeHL
  //OK

  write(257);
  //LD    HL,257
  //CALL  writeHL
  //OK

  write(j + 1001);
  //LD    HL,(04004H)
  //LD    DE,1001
  //ADD   HL,DE
  //CALL  writeHL
  //OK

  write(1002 + j);
  //LD    HL,1002
  //LD    DE,(04004H)
  //ADD   HL,DE
  //CALL  writeHL
  //OK

}
