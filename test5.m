  0 :///*
  1 :// * A small program in the miniJava language.
  2 :// * Test comparisons
  3 :// */
  4 ://class TestComparison {
  5 ://  write(1300);            //13
  6 ://  write(13);              //13
  7 :acc16= constant 1300
  8 :call writeAcc16
  9 ://  if (1000 == 1000) write(1200);  //12
 10 :acc8= constant 13
 11 :call writeAcc8
 12 :acc16= constant 1000
 13 :accom16 constant 1000
 14 :brne 18
 15 ://  if (1 == 1) write(12);  //12
 16 :acc16= constant 1200
 17 :call writeAcc16
 18 :acc8= constant 1
 19 :accom8 constant 1
 20 :brne 24
 21 ://  if (1 == 1) { 
 22 :acc8= constant 12
 23 :call writeAcc8
 24 :acc8= constant 1
 25 :accom8 constant 1
 26 :brne 32
 27 ://    write(11);            //11
 28 ://  } else { 
 29 :acc8= constant 11
 30 :call writeAcc8
 31 :br 36
 32 ://    write (0);
 33 ://  }
 34 :acc8= constant 0
 35 :call writeAcc8
 36 ://  if (1 == 0) { 
 37 :acc8= constant 1
 38 :accom8 constant 0
 39 :brne 45
 40 ://    write(0);
 41 ://  } else { 
 42 :acc8= constant 0
 43 :call writeAcc8
 44 :br 49
 45 ://    write (10);           //10
 46 ://  }
 47 :acc8= constant 10
 48 :call writeAcc8
 49 ://  if (1 != 0) write(9);   //9
 50 :acc8= constant 1
 51 :accom8 constant 0
 52 :breq 56
 53 ://  if (1 != 0) { 
 54 :acc8= constant 9
 55 :call writeAcc8
 56 :acc8= constant 1
 57 :accom8 constant 0
 58 :breq 64
 59 ://    write(8);             //8
 60 ://  } else { 
 61 :acc8= constant 8
 62 :call writeAcc8
 63 :br 68
 64 ://    write (0);
 65 ://  }
 66 :acc8= constant 0
 67 :call writeAcc8
 68 ://  if (1 != 1) { 
 69 :acc8= constant 1
 70 :accom8 constant 1
 71 :breq 77
 72 ://    write(0);
 73 ://  } else { 
 74 :acc8= constant 0
 75 :call writeAcc8
 76 :br 81
 77 ://    write (7);            //7
 78 ://  }
 79 :acc8= constant 7
 80 :call writeAcc8
 81 ://  if (1 > 0) write(6);    //6
 82 :acc8= constant 1
 83 :accom8 constant 0
 84 :brle 88
 85 ://  if (1 >= 0) write(5);   //5
 86 :acc8= constant 6
 87 :call writeAcc8
 88 :acc8= constant 1
 89 :accom8 constant 0
 90 :brlt 94
 91 ://  if (1 >= 1) write(4);   //4
 92 :acc8= constant 5
 93 :call writeAcc8
 94 :acc8= constant 1
 95 :accom8 constant 1
 96 :brlt 100
 97 ://  if (0 < 1) write(3);    //3
 98 :acc8= constant 4
 99 :call writeAcc8
100 :acc8= constant 0
101 :accom8 constant 1
102 :brge 106
103 ://  if (0 <= 1) write(2);   //2
104 :acc8= constant 3
105 :call writeAcc8
106 :acc8= constant 0
107 :accom8 constant 1
108 :brgt 112
109 ://  if (1 <= 1) write(1);   //1
110 :acc8= constant 2
111 :call writeAcc8
112 :acc8= constant 1
113 :accom8 constant 1
114 :brgt 118
115 ://  write(0);               //0
116 :acc8= constant 1
117 :call writeAcc8
118 ://}
119 :acc8= constant 0
120 :call writeAcc8
121 :stop
