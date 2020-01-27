  0 :///*
  1 :// * A small program in the miniJava language.
  2 :// * Test 8-bit and 16-bit operations
  3 :// */
  4 ://class TestComparison {
  5 ://  write(0);
  6 ://  //LD    A,0
  7 ://  //CALL  writeA
  8 ://  //OK
  9 ://
 10 ://  byte c = 1;
 11 :acc8= constant 0
 12 :call writeAcc8
 13 :acc8= constant 1
 14 :acc8=> variable 0
 15 ://  //LD    A,1
 16 ://  //LD    (04000H),A
 17 ://  //OK
 18 ://
 19 ://  write(c);
 20 ://  //LD    A,(04000H)
 21 ://  //CALL  writeA
 22 ://  //OK
 23 ://
 24 ://  byte b = 0 + 2;
 25 :acc8= variable 0
 26 :call writeAcc8
 27 :acc8= constant 0
 28 :acc8+ constant 2
 29 :acc8=> variable 1
 30 ://  //LD    A,0
 31 ://  //ADD   A,2
 32 ://  //LD    (04001H),A
 33 ://  //OK
 34 ://
 35 ://  write(b);
 36 ://  //LD    A,(04001H)
 37 ://  //CALL  writeA
 38 ://  //OK
 39 ://
 40 ://  byte e = 2;
 41 :acc8= variable 1
 42 :call writeAcc8
 43 :acc8= constant 2
 44 :acc8=> variable 2
 45 ://  //LD    A,2
 46 ://  //LD    (04002H),A
 47 ://  //OK
 48 ://
 49 ://  byte d = 1;
 50 :acc8= constant 1
 51 :acc8=> variable 3
 52 ://  //LD    A,1
 53 ://  //LD    (04003H),A
 54 ://  //OK
 55 ://
 56 ://  write(d + e);
 57 :acc8= variable 3
 58 :acc8+ variable 2
 59 ://  //LD    A,(04003H)
 60 ://  //LD    B,A
 61 ://  //LD    A,(04002H)
 62 ://  //ADD   A,B
 63 ://  //CALL  writeA
 64 ://  //OK
 65 ://
 66 ://  write(2 + e);
 67 :call writeAcc8
 68 :acc8= constant 2
 69 :acc8+ variable 2
 70 ://  //LD    A,2
 71 ://  //LD    B,A
 72 ://  //LD    A,(04002H)
 73 ://  //ADD   A,B
 74 ://  //CALL  writeA
 75 ://  //OK
 76 ://
 77 ://  write(d + 4);
 78 :call writeAcc8
 79 :acc8= variable 3
 80 :acc8+ constant 4
 81 ://  //LD    A,(04003H)
 82 ://  //ADD   A,4
 83 ://  //CALL  writeA
 84 ://  //OK
 85 ://
 86 ://  int j = 5;
 87 :call writeAcc8
 88 :acc8= constant 5
 89 :acc8ToAcc16
 90 :acc16=> variable 4
 91 ://  //LD    A,5
 92 ://  //LD    L,A
 93 ://  //LD    H,0
 94 ://  //LD    (04004H),HL
 95 ://  //OK
 96 ://
 97 ://  b = 255;
 98 :acc8= constant 255
 99 :acc8=> variable 1
100 ://  //LD    A,255
101 ://  //LD    (04001H),A
102 ://  //OK
103 ://
104 ://  write(b);
105 ://  //LD    A,(04001H)
106 ://  //CALL  writeA
107 ://  //OK
108 ://
109 ://  int i = 256;
110 :acc8= variable 1
111 :call writeAcc8
112 :acc16= constant 256
113 :acc16=> variable 6
114 ://  //LD    HL,256
115 ://  //LD    (04006H),HL
116 ://  //OK
117 ://
118 ://  write(i);
119 ://  //LD    HL,(04006H)
120 ://  //CALL  writeHL
121 ://  //OK
122 ://
123 ://  write(257);
124 :acc16= variable 6
125 :call writeAcc16
126 ://  //LD    HL,257
127 ://  //CALL  writeHL
128 ://  //OK
129 ://
130 ://  write(j + 1001);
131 :acc16= constant 257
132 :call writeAcc16
133 :acc16= variable 4
134 :acc16+ constant 1001
135 ://  //LD    HL,(04004H)
136 ://  //LD    DE,1001
137 ://  //ADD   HL,DE
138 ://  //CALL  writeHL
139 ://  //OK
140 ://
141 ://  write(1002 + j);
142 :call writeAcc16
143 :acc16= constant 1002
144 :acc16+ variable 4
145 ://  //LD    HL,1002
146 ://  //LD    DE,(04004H)
147 ://  //ADD   HL,DE
148 ://  //CALL  writeHL
149 ://  //OK
150 ://
151 ://}
152 :call writeAcc16
153 :stop
