  0 :///*
  1 :// * A small program in the miniJava language.
  2 :// * Test comparisons
  3 :// */
  4 ://class TestComparison {
  5 ://  write(13);              //13
  6 ://  if (1 == 1) write(12);  //12
  7 :acc8= constant 13
  8 :call writeAcc8
  9 :acc8= constant 1
 10 :accom8 constant 1
 11 :brne 15
 12 ://  if (1 == 1) { 
 13 :acc8= constant 12
 14 :call writeAcc8
 15 :acc8= constant 1
 16 :accom8 constant 1
 17 :brne 23
 18 ://    write(11);            //11
 19 ://  } else { 
 20 :acc8= constant 11
 21 :call writeAcc8
 22 :br 28
 23 ://    write (0);
 24 ://  }
 25 :acc8= constant 0
 26 :call writeAcc8
 27 ://  if (1 == 0) { 
 28 :acc8= constant 1
 29 :accom8 constant 0
 30 :brne 36
 31 ://    write(0);
 32 ://  } else { 
 33 :acc8= constant 0
 34 :call writeAcc8
 35 :br 41
 36 ://    write (10);           //10
 37 ://  }
 38 :acc8= constant 10
 39 :call writeAcc8
 40 ://  if (1 != 0) write(9);   //9
 41 :acc8= constant 1
 42 :accom8 constant 0
 43 :breq 47
 44 ://  if (1 != 0) { 
 45 :acc8= constant 9
 46 :call writeAcc8
 47 :acc8= constant 1
 48 :accom8 constant 0
 49 :breq 55
 50 ://    write(8);             //8
 51 ://  } else { 
 52 :acc8= constant 8
 53 :call writeAcc8
 54 :br 60
 55 ://    write (0);
 56 ://  }
 57 :acc8= constant 0
 58 :call writeAcc8
 59 ://  if (1 != 1) { 
 60 :acc8= constant 1
 61 :accom8 constant 1
 62 :breq 68
 63 ://    write(0);
 64 ://  } else { 
 65 :acc8= constant 0
 66 :call writeAcc8
 67 :br 73
 68 ://    write (7);            //7
 69 ://  }
 70 :acc8= constant 7
 71 :call writeAcc8
 72 ://  if (1 > 0) write(6);    //6
 73 :acc8= constant 1
 74 :accom8 constant 0
 75 :brle 79
 76 ://  if (1 >= 0) write(5);   //5
 77 :acc8= constant 6
 78 :call writeAcc8
 79 :acc8= constant 1
 80 :accom8 constant 0
 81 :brlt 85
 82 ://  if (1 >= 1) write(4);   //4
 83 :acc8= constant 5
 84 :call writeAcc8
 85 :acc8= constant 1
 86 :accom8 constant 1
 87 :brlt 91
 88 ://  if (0 < 1) write(3);    //3
 89 :acc8= constant 4
 90 :call writeAcc8
 91 :acc8= constant 0
 92 :accom8 constant 1
 93 :brge 97
 94 ://  if (0 <= 1) write(2);   //2
 95 :acc8= constant 3
 96 :call writeAcc8
 97 :acc8= constant 0
 98 :accom8 constant 1
 99 :brgt 103
100 ://  if (1 <= 1) write(1);   //1
101 :acc8= constant 2
102 :call writeAcc8
103 :acc8= constant 1
104 :accom8 constant 1
105 :brgt 109
106 ://  write(0);               //0
107 :acc8= constant 1
108 :call writeAcc8
109 ://}
110 :acc8= constant 0
111 :call writeAcc8
112 :stop
