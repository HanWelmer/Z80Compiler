   0 ;test8.j(0) /*
   1 ;test8.j(1)  * A small program in the miniJava language.
   2 ;test8.j(2)  * Test 8-bit and 16-bit expressions.
   3 ;test8.j(3)  */
   4 ;test8.j(4) class Test8And16BitExpressions {
   5 ;test8.j(5)   /*************************/
   6 ;test8.j(6)   /* reverse subtract byte */
   7 ;test8.j(7)   /*************************/
   8 ;test8.j(8)   write(10 - 3*3);         // 1
   9 acc8= constant 10
  10 <acc8= constant 3
  11 acc8* constant 3
  12 -acc8 unstack8
  13 call writeAcc8
  14 ;test8.j(9)   byte b = 11;
  15 acc8= constant 11
  16 acc8=> variable 0
  17 ;test8.j(10)   write(b - 3*3);          // 2
  18 acc8= variable 0
  19 <acc8= constant 3
  20 acc8* constant 3
  21 -acc8 unstack8
  22 call writeAcc8
  23 ;test8.j(11)   byte c = 3;
  24 acc8= constant 3
  25 acc8=> variable 1
  26 ;test8.j(12)   byte d = 3;
  27 acc8= constant 3
  28 acc8=> variable 2
  29 ;test8.j(13)   write(12 - c*d);         // 3
  30 acc8= constant 12
  31 <acc8= variable 1
  32 acc8* variable 2
  33 -acc8 unstack8
  34 call writeAcc8
  35 ;test8.j(14)   b = 13;
  36 acc8= constant 13
  37 acc8=> variable 0
  38 ;test8.j(15)   write(b - c*d);          // 4
  39 acc8= variable 0
  40 <acc8= variable 1
  41 acc8* variable 2
  42 -acc8 unstack8
  43 call writeAcc8
  44 ;test8.j(16) 
  45 ;test8.j(17)   /**************************/
  46 ;test8.j(18)   /* reverse subtract word  */
  47 ;test8.j(19)   /**************************/
  48 ;test8.j(20)   write(1005 - 1000*1);    // 5
  49 acc16= constant 1005
  50 <acc16= constant 1000
  51 acc16* constant 1
  52 -acc16 unstack16
  53 call writeAcc16
  54 ;test8.j(21)   word i = 1006;
  55 acc16= constant 1006
  56 acc16=> variable 3
  57 ;test8.j(22)   write(i - 1000*1);       // 6
  58 acc16= variable 3
  59 <acc16= constant 1000
  60 acc16* constant 1
  61 -acc16 unstack16
  62 call writeAcc16
  63 ;test8.j(23)   word j = 1000;
  64 acc16= constant 1000
  65 acc16=> variable 5
  66 ;test8.j(24)   word k = 1;
  67 acc8= constant 1
  68 acc8=> variable 7
  69 ;test8.j(25)   write(1007 - j*k);       // 7
  70 acc16= constant 1007
  71 <acc16= variable 5
  72 acc16* variable 7
  73 -acc16 unstack16
  74 call writeAcc16
  75 ;test8.j(26)   i = 1008;
  76 acc16= constant 1008
  77 acc16=> variable 3
  78 ;test8.j(27)   write(i - j*k);          // 8
  79 acc16= variable 3
  80 <acc16= variable 5
  81 acc16* variable 7
  82 -acc16 unstack16
  83 call writeAcc16
  84 ;test8.j(28) 
  85 ;test8.j(29)   /***********************/
  86 ;test8.j(30)   /* reverse divide byte */
  87 ;test8.j(31)   /***********************/
  88 ;test8.j(32)   write(36 / (4*1));     // 9
  89 acc8= constant 36
  90 <acc8= constant 4
  91 acc8* constant 1
  92 /acc8 unstack8
  93 call writeAcc8
  94 ;test8.j(33)   b = 40;
  95 acc8= constant 40
  96 acc8=> variable 0
  97 ;test8.j(34)   write(b / (4*1));      // 10
  98 acc8= variable 0
  99 <acc8= constant 4
 100 acc8* constant 1
 101 /acc8 unstack8
 102 call writeAcc8
 103 ;test8.j(35)   c = 4;
 104 acc8= constant 4
 105 acc8=> variable 1
 106 ;test8.j(36)   d = 1;
 107 acc8= constant 1
 108 acc8=> variable 2
 109 ;test8.j(37)   write(44 / (c*d));     // 11
 110 acc8= constant 44
 111 <acc8= variable 1
 112 acc8* variable 2
 113 /acc8 unstack8
 114 call writeAcc8
 115 ;test8.j(38)   b = 48;
 116 acc8= constant 48
 117 acc8=> variable 0
 118 ;test8.j(39)   write(b / (c*d));      // 12
 119 acc8= variable 0
 120 <acc8= variable 1
 121 acc8* variable 2
 122 /acc8 unstack8
 123 call writeAcc8
 124 ;test8.j(40) 
 125 ;test8.j(41)   /************************/
 126 ;test8.j(42)   /* reverse divide word  */
 127 ;test8.j(43)   /************************/
 128 ;test8.j(44)   write(3900 / (300*1)); // 13
 129 acc16= constant 3900
 130 <acc16= constant 300
 131 acc16* constant 1
 132 /acc16 unstack16
 133 call writeAcc16
 134 ;test8.j(45)   i = 4200;
 135 acc16= constant 4200
 136 acc16=> variable 3
 137 ;test8.j(46)   write(i / (300*1));    // 14
 138 acc16= variable 3
 139 <acc16= constant 300
 140 acc16* constant 1
 141 /acc16 unstack16
 142 call writeAcc16
 143 ;test8.j(47)   j = 300;
 144 acc16= constant 300
 145 acc16=> variable 5
 146 ;test8.j(48)   k = 1;
 147 acc8= constant 1
 148 acc8=> variable 7
 149 ;test8.j(49)   write(4500 / (j*k));   // 15
 150 acc16= constant 4500
 151 <acc16= variable 5
 152 acc16* variable 7
 153 /acc16 unstack16
 154 call writeAcc16
 155 ;test8.j(50)   i = 4800;
 156 acc16= constant 4800
 157 acc16=> variable 3
 158 ;test8.j(51)   write(i / (j*k));      // 16
 159 acc16= variable 3
 160 <acc16= variable 5
 161 acc16* variable 7
 162 /acc16 unstack16
 163 call writeAcc16
 164 ;test8.j(52) 
 165 ;test8.j(53)   /**************************/
 166 ;test8.j(54)   /* reverse subtract mixed */
 167 ;test8.j(55)   /**************************/
 168 ;test8.j(56)   i = 21;
 169 acc8= constant 21
 170 acc8=> variable 3
 171 ;test8.j(57)   c = 4;
 172 acc8= constant 4
 173 acc8=> variable 1
 174 ;test8.j(58)   d = 1;
 175 acc8= constant 1
 176 acc8=> variable 2
 177 ;test8.j(59)   write(i - c*d);           // 17
 178 acc16= variable 3
 179 acc8= variable 1
 180 acc8* variable 2
 181 acc16- acc8
 182 call writeAcc16
 183 ;test8.j(60)   b = 22;
 184 acc8= constant 22
 185 acc8=> variable 0
 186 ;test8.j(61)   j = 4;
 187 acc8= constant 4
 188 acc8=> variable 5
 189 ;test8.j(62)   k = 1;
 190 acc8= constant 1
 191 acc8=> variable 7
 192 ;test8.j(63)   write(b - j*k);           // 18
 193 acc8= variable 0
 194 acc16= variable 5
 195 acc16* variable 7
 196 -acc16 acc8
 197 call writeAcc16
 198 ;test8.j(64) 
 199 ;test8.j(65)   /**************************/
 200 ;test8.j(66)   /* reverse divide mixed   */
 201 ;test8.j(67)   /**************************/
 202 ;test8.j(68) 
 203 ;test8.j(69)   /**************************/
 204 ;test8.j(70)   /* forward divide mixed   */
 205 ;test8.j(71)   /**************************/
 206 ;test8.j(72)   i = 19;
 207 acc8= constant 19
 208 acc8=> variable 3
 209 ;test8.j(73)   write(i / (1+0));         // 19
 210 acc16= variable 3
 211 acc8= constant 1
 212 acc8+ constant 0
 213 acc16/ acc8
 214 call writeAcc16
 215 ;test8.j(74)   
 216 ;test8.j(75)   write(i + 1);             // 20
 217 acc16= variable 3
 218 acc16+ constant 1
 219 call writeAcc16
 220 ;test8.j(76)   write(2 + i);             // 21
 221 acc8= constant 2
 222 acc8ToAcc16
 223 acc16+ variable 3
 224 call writeAcc16
 225 ;test8.j(77)   write("Klaar");
 226 acc16= constant 230
 227 writeString
 228 ;test8.j(78) }
 229 stop
 230 stringConstant 0 = "Klaar"
