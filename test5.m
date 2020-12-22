  0 ;test5.p(0) /*
  1 ;test5.p(1)  * A small program in the miniJava language.
  2 ;test5.p(2)  * Test comparisons
  3 ;test5.p(3)  */
  4 ;test5.p(4) class TestComparison {
  5 ;test5.p(5)   write(15);              //15
  6 acc8= constant 15
  7 call writeAcc8
  8 ;test5.p(6)   write(1400);            //1400
  9 acc16= constant 1400
 10 call writeAcc16
 11 ;test5.p(7)   if (1 == 1) write(13);  //13
 12 acc8= constant 1
 13 accom8 constant 1
 14 brne 18
 15 acc8= constant 13
 16 call writeAcc8
 17 ;test5.p(8)   if (1000 == 1000) write(1200);  //1200
 18 acc16= constant 1000
 19 accom16 constant 1000
 20 brne 24
 21 acc16= constant 1200
 22 call writeAcc16
 23 ;test5.p(9)   if (1 == 1) { 
 24 acc8= constant 1
 25 accom8 constant 1
 26 brne 33
 27 ;test5.p(10)     write(11);            //11
 28 acc8= constant 11
 29 call writeAcc8
 30 ;test5.p(11)   } else { 
 31 br 37
 32 ;test5.p(12)     write (0);
 33 acc8= constant 0
 34 call writeAcc8
 35 ;test5.p(13)   }
 36 ;test5.p(14)   if (1 == 0) { 
 37 acc8= constant 1
 38 accom8 constant 0
 39 brne 46
 40 ;test5.p(15)     write(0);
 41 acc8= constant 0
 42 call writeAcc8
 43 ;test5.p(16)   } else { 
 44 br 50
 45 ;test5.p(17)     write (10);           //10
 46 acc8= constant 10
 47 call writeAcc8
 48 ;test5.p(18)   }
 49 ;test5.p(19)   if (1 != 0) write(9);   //9
 50 acc8= constant 1
 51 accom8 constant 0
 52 breq 56
 53 acc8= constant 9
 54 call writeAcc8
 55 ;test5.p(20)   if (1 != 0) { 
 56 acc8= constant 1
 57 accom8 constant 0
 58 breq 65
 59 ;test5.p(21)     write(8);             //8
 60 acc8= constant 8
 61 call writeAcc8
 62 ;test5.p(22)   } else { 
 63 br 69
 64 ;test5.p(23)     write (0);
 65 acc8= constant 0
 66 call writeAcc8
 67 ;test5.p(24)   }
 68 ;test5.p(25)   if (1 != 1) { 
 69 acc8= constant 1
 70 accom8 constant 1
 71 breq 78
 72 ;test5.p(26)     write(0);
 73 acc8= constant 0
 74 call writeAcc8
 75 ;test5.p(27)   } else { 
 76 br 82
 77 ;test5.p(28)     write (7);            //7
 78 acc8= constant 7
 79 call writeAcc8
 80 ;test5.p(29)   }
 81 ;test5.p(30)   if (1 > 0) write(6);    //6
 82 acc8= constant 1
 83 accom8 constant 0
 84 brle 88
 85 acc8= constant 6
 86 call writeAcc8
 87 ;test5.p(31)   if (1 >= 0) write(5);   //5
 88 acc8= constant 1
 89 accom8 constant 0
 90 brlt 94
 91 acc8= constant 5
 92 call writeAcc8
 93 ;test5.p(32)   if (1 >= 1) write(4);   //4
 94 acc8= constant 1
 95 accom8 constant 1
 96 brlt 100
 97 acc8= constant 4
 98 call writeAcc8
 99 ;test5.p(33)   if (0 < 1) write(3);    //3
100 acc8= constant 0
101 accom8 constant 1
102 brge 106
103 acc8= constant 3
104 call writeAcc8
105 ;test5.p(34)   if (0 <= 1) write(2);   //2
106 acc8= constant 0
107 accom8 constant 1
108 brgt 112
109 acc8= constant 2
110 call writeAcc8
111 ;test5.p(35)   if (1 <= 1) write(1);   //1
112 acc8= constant 1
113 accom8 constant 1
114 brgt 118
115 acc8= constant 1
116 call writeAcc8
117 ;test5.p(36)   write(0);               //0
118 acc8= constant 0
119 call writeAcc8
120 ;test5.p(37) }
121 stop
