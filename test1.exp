  0 :///* Program to test generated Z80 assembler code */
  1 ://class TestWhile {
  2 ://  write(14);
  3 ://  int b = 13;
  4 :acc8= constant 14
  5 :call writeAcc8
  6 :acc8= constant 13
  7 :acc8ToAcc16
  8 :acc16=> variable 0
  9 ://  write(b);
 10 ://  //start a new scope
 11 ://  byte p = 12;
 12 :acc16= variable 0
 13 :call writeAcc16
 14 :acc8= constant 12
 15 :acc8=> variable 2
 16 ://  while (p > 11) {
 17 :acc8= variable 2
 18 :accom8 constant 11
 19 :brle 35
 20 ://    int test = 1;
 21 :acc8= constant 1
 22 :acc8ToAcc16
 23 :acc16=> variable 3
 24 ://    write(p);
 25 ://    p = p - 1;
 26 :acc8= variable 2
 27 :call writeAcc8
 28 :acc8= variable 2
 29 :acc8- constant 1
 30 :acc8=> variable 2
 31 ://  }
 32 ://  //start a new scope
 33 ://  while (p > 9) {
 34 :br 16
 35 :acc8= variable 2
 36 :accom8 constant 9
 37 :brle 52
 38 ://    int test = 2;
 39 :acc8= constant 2
 40 :acc8ToAcc16
 41 :acc16=> variable 3
 42 ://    write(p);
 43 ://    p = p - 1;
 44 :acc8= variable 2
 45 :call writeAcc8
 46 :acc8= variable 2
 47 :acc8- constant 1
 48 :acc8=> variable 2
 49 ://  }
 50 ://  byte a = 9;
 51 :br 35
 52 :acc8= constant 9
 53 :acc8=> variable 3
 54 ://  while (a >= 7) {
 55 :acc8= variable 3
 56 :accom8 constant 7
 57 :brlt 68
 58 ://    write(a);
 59 ://    a = a - 1;
 60 :acc8= variable 3
 61 :call writeAcc8
 62 :acc8= variable 3
 63 :acc8- constant 1
 64 :acc8=> variable 3
 65 ://  }
 66 ://  do {
 67 :br 54
 68 ://    int test = 1;
 69 :acc8= constant 1
 70 :acc8ToAcc16
 71 :acc16=> variable 4
 72 ://    write(a);
 73 ://    a = a - 1;
 74 :acc8= variable 3
 75 :call writeAcc8
 76 :acc8= variable 3
 77 :acc8- constant 1
 78 :acc8=> variable 3
 79 ://  } while (a > 5);
 80 :<acc8= variable 3
 81 :accom16 constant 5
 82 :brge 68
 83 ://  for(byte i = 3; i<=4; i++) {
 84 :acc8= constant 3
 85 :acc8=> variable 4
 86 :<acc8= variable 4
 87 :accom8 constant 4
 88 :brgt 104
 89 :br 92
 90 :incr8 variable 4
 91 :br 86
 92 ://    int test = 1;
 93 :acc8= constant 1
 94 :acc8ToAcc16
 95 :acc16=> variable 5
 96 ://    write(a);
 97 ://    a--;
 98 :acc8= variable 3
 99 :call writeAcc8
100 :decr8 variable 3
101 ://  }
102 ://  for(int i = 3; i!=0; i--) {
103 :br 90
104 :acc8= constant 3
105 :acc8ToAcc16
106 :acc16=> variable 4
107 :<acc16= variable 4
108 :accom16 constant 0
109 :breq 125
110 :br 113
111 :decr16 variable 4
112 :br 107
113 ://    int test = 1;
114 :acc8= constant 1
115 :acc8ToAcc16
116 :acc16=> variable 6
117 ://    write(i);
118 ://    a--;
119 :acc16= variable 4
120 :call writeAcc16
121 :decr8 variable 3
122 ://  }
123 ://  write(a);
124 :br 111
125 ://}
126 :acc8= variable 3
127 :call writeAcc8
128 :stop
