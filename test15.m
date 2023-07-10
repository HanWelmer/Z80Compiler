   0 ;test15.j(0) /* Program to test bitwise operators and, or and xor. */
   1 ;test15.j(1) class TestBitwiseOperators {
   2 ;test15.j(2)   println(0);
   3 acc8= constant 0
   4 call writeLineAcc8
   5 ;test15.j(3)   
   6 ;test15.j(4)   // Possible operand types: constant, acc, var, final var, stack8, stack16.
   7 ;test15.j(5)   // Possible data types: byt, word.
   8 ;test15.j(6) 
   9 ;test15.j(7)   //constant byte/constant byte
  10 ;test15.j(8)   if (0x07 & 0x1C == 0x04) println (1); else println (999); //0000.0111 & 0001.1100 = 0000.0100
  11 acc8= constant 7
  12 acc8And constant 28
  13 acc8Comp constant 4
  14 brne 18
  15 acc8= constant 1
  16 call writeLineAcc8
  17 br 21
  18 acc16= constant 999
  19 call writeLineAcc16
  20 ;test15.j(9)   if (0x07 | 0x1C == 0x1F) println (2); else println (999); //0000.0111 | 0001.1100 = 0001.1111
  21 acc8= constant 7
  22 acc8Or constant 28
  23 acc8Comp constant 31
  24 brne 28
  25 acc8= constant 2
  26 call writeLineAcc8
  27 br 31
  28 acc16= constant 999
  29 call writeLineAcc16
  30 ;test15.j(10)   if (0x07 ^ 0x1C == 0x1B) println (3); else println (999); //0000.0111 ^ 0001.1100 = 0001.1011
  31 acc8= constant 7
  32 acc8Xor constant 28
  33 acc8Comp constant 27
  34 brne 38
  35 acc8= constant 3
  36 call writeLineAcc8
  37 br 42
  38 acc16= constant 999
  39 call writeLineAcc16
  40 ;test15.j(11)   //constant word/constant word
  41 ;test15.j(12)   if (0x1234 & 0x032C == 0x0224) println (4); else println (999);
  42 acc16= constant 4660
  43 acc16And constant 812
  44 acc16Comp constant 548
  45 brne 49
  46 acc8= constant 4
  47 call writeLineAcc8
  48 br 53
  49 acc16= constant 999
  50 call writeLineAcc16
  51 ;test15.j(13)   //0001.0010.0011.0100 & 0000.0011.0010.1100 = 0000.0010.0010.0100
  52 ;test15.j(14)   if (0x1234 | 0x032C == 0x133C) println (5); else println (999);
  53 acc16= constant 4660
  54 acc16Or constant 812
  55 acc16Comp constant 4924
  56 brne 60
  57 acc8= constant 5
  58 call writeLineAcc8
  59 br 64
  60 acc16= constant 999
  61 call writeLineAcc16
  62 ;test15.j(15)   //0001.0010.0011.0100 | 0000.0011.0010.1100 = 0001.0011.0011.1100
  63 ;test15.j(16)   if (0x1234 ^ 0x032C == 0x1118) println (6); else println (999);
  64 acc16= constant 4660
  65 acc16Xor constant 812
  66 acc16Comp constant 4376
  67 brne 71
  68 acc8= constant 6
  69 call writeLineAcc8
  70 br 76
  71 acc16= constant 999
  72 call writeLineAcc16
  73 ;test15.j(17)   //0001.0010.0011.0100 ^ 0000.0011.0010.1100 = 0001.0001.0001.1000
  74 ;test15.j(18)   //constant byt/constant word
  75 ;test15.j(19)   if (0x1C & 0x1234 == 0x0014) println (7); else println (999); //0001.1100 & 0001.0010.0011.0100 = 0000.0000.0001.0100
  76 acc8= constant 28
  77 acc8ToAcc16
  78 acc16And constant 4660
  79 acc8= constant 20
  80 acc16CompareAcc8
  81 brne 85
  82 acc8= constant 7
  83 call writeLineAcc8
  84 br 88
  85 acc16= constant 999
  86 call writeLineAcc16
  87 ;test15.j(20)   if (0x1C | 0x1234 == 0x123C) println (8); else println (999); //0001.1100 | 0001.0010.0011.0100 = 0001.0010.0011.1100
  88 acc8= constant 28
  89 acc8ToAcc16
  90 acc16Or constant 4660
  91 acc16Comp constant 4668
  92 brne 96
  93 acc8= constant 8
  94 call writeLineAcc8
  95 br 99
  96 acc16= constant 999
  97 call writeLineAcc16
  98 ;test15.j(21)   if (0x1C ^ 0x1234 == 0x1228) println (9); else println (999); //0001.1100 ^ 0001.0010.0011.0100 = 0001.0010.0010.1000
  99 acc8= constant 28
 100 acc8ToAcc16
 101 acc16Xor constant 4660
 102 acc16Comp constant 4648
 103 brne 107
 104 acc8= constant 9
 105 call writeLineAcc8
 106 br 111
 107 acc16= constant 999
 108 call writeLineAcc16
 109 ;test15.j(22)   //constant word/constant byt
 110 ;test15.j(23)   if (0x1234 & 0x1C == 0x0014) println (10); else println (999); //0001.0010.0011.0100 & 0001.1100 = 0000.0000.0001.0100
 111 acc16= constant 4660
 112 acc16And constant 28
 113 acc8= constant 20
 114 acc16CompareAcc8
 115 brne 119
 116 acc8= constant 10
 117 call writeLineAcc8
 118 br 122
 119 acc16= constant 999
 120 call writeLineAcc16
 121 ;test15.j(24)   if (0x1234 | 0x1C == 0x123C) println (11); else println (999); //0001.0010.0011.0100 | 0001.1100 = 0001.0010.0011.1100
 122 acc16= constant 4660
 123 acc16Or constant 28
 124 acc16Comp constant 4668
 125 brne 129
 126 acc8= constant 11
 127 call writeLineAcc8
 128 br 132
 129 acc16= constant 999
 130 call writeLineAcc16
 131 ;test15.j(25)   if (0x1234 ^ 0x1C == 0x1228) println (12); else println (999); //0001.0010.0011.0100 ^ 0001.1100 = 0001.0010.0010.1000
 132 acc16= constant 4660
 133 acc16Xor constant 28
 134 acc16Comp constant 4648
 135 brne 139
 136 acc8= constant 12
 137 call writeLineAcc8
 138 br 143
 139 acc16= constant 999
 140 call writeLineAcc16
 141 ;test15.j(26) 
 142 ;test15.j(27)   println("Klaar");
 143 acc16= constant 147
 144 writeLineString
 145 ;test15.j(28) }
 146 stop
 147 stringConstant 0 = "Klaar"
