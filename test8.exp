   0 ;test8.j(0) /*
   1 ;test8.j(1)  * A small program in the miniJava language.
   2 ;test8.j(2)  * Test 8-bit and 16-bit expressions.
   3 ;test8.j(3)  */
   4 ;test8.j(4) class Test8And16BitExpressions {
   5 ;test8.j(5)   println(0);
   6 acc8= constant 0
   7 call writeAcc8
   8 ;test8.j(6)   /*************************/
   9 ;test8.j(7)   /* reverse subtract byte */
  10 ;test8.j(8)   /*************************/
  11 ;test8.j(9)   println(10 - 3*3);         // 1
  12 acc8= constant 10
  13 <acc8= constant 3
  14 acc8* constant 3
  15 -acc8 unstack8
  16 call writeAcc8
  17 ;test8.j(10)   byte b = 11;
  18 acc8= constant 11
  19 acc8=> variable 0
  20 ;test8.j(11)   println(b - 3*3);          // 2
  21 acc8= variable 0
  22 <acc8= constant 3
  23 acc8* constant 3
  24 -acc8 unstack8
  25 call writeAcc8
  26 ;test8.j(12)   byte c = 3;
  27 acc8= constant 3
  28 acc8=> variable 1
  29 ;test8.j(13)   byte d = 3;
  30 acc8= constant 3
  31 acc8=> variable 2
  32 ;test8.j(14)   println(12 - c*d);         // 3
  33 acc8= constant 12
  34 <acc8= variable 1
  35 acc8* variable 2
  36 -acc8 unstack8
  37 call writeAcc8
  38 ;test8.j(15)   b = 13;
  39 acc8= constant 13
  40 acc8=> variable 0
  41 ;test8.j(16)   println(b - c*d);          // 4
  42 acc8= variable 0
  43 <acc8= variable 1
  44 acc8* variable 2
  45 -acc8 unstack8
  46 call writeAcc8
  47 ;test8.j(17) 
  48 ;test8.j(18)   /**************************/
  49 ;test8.j(19)   /* reverse subtract word  */
  50 ;test8.j(20)   /**************************/
  51 ;test8.j(21)   println(1005 - 1000*1);    // 5
  52 acc16= constant 1005
  53 <acc16= constant 1000
  54 acc16* constant 1
  55 -acc16 unstack16
  56 call writeAcc16
  57 ;test8.j(22)   word i = 1006;
  58 acc16= constant 1006
  59 acc16=> variable 3
  60 ;test8.j(23)   println(i - 1000*1);       // 6
  61 acc16= variable 3
  62 <acc16= constant 1000
  63 acc16* constant 1
  64 -acc16 unstack16
  65 call writeAcc16
  66 ;test8.j(24)   word j = 1000;
  67 acc16= constant 1000
  68 acc16=> variable 5
  69 ;test8.j(25)   word k = 1;
  70 acc8= constant 1
  71 acc8=> variable 7
  72 ;test8.j(26)   println(1007 - j*k);       // 7
  73 acc16= constant 1007
  74 <acc16= variable 5
  75 acc16* variable 7
  76 -acc16 unstack16
  77 call writeAcc16
  78 ;test8.j(27)   i = 1008;
  79 acc16= constant 1008
  80 acc16=> variable 3
  81 ;test8.j(28)   println(i - j*k);          // 8
  82 acc16= variable 3
  83 <acc16= variable 5
  84 acc16* variable 7
  85 -acc16 unstack16
  86 call writeAcc16
  87 ;test8.j(29) 
  88 ;test8.j(30)   /***********************/
  89 ;test8.j(31)   /* reverse divide byte */
  90 ;test8.j(32)   /***********************/
  91 ;test8.j(33)   println(36 / (4*1));     // 9
  92 acc8= constant 36
  93 <acc8= constant 4
  94 acc8* constant 1
  95 /acc8 unstack8
  96 call writeAcc8
  97 ;test8.j(34)   b = 40;
  98 acc8= constant 40
  99 acc8=> variable 0
 100 ;test8.j(35)   println(b / (4*1));      // 10
 101 acc8= variable 0
 102 <acc8= constant 4
 103 acc8* constant 1
 104 /acc8 unstack8
 105 call writeAcc8
 106 ;test8.j(36)   c = 4;
 107 acc8= constant 4
 108 acc8=> variable 1
 109 ;test8.j(37)   d = 1;
 110 acc8= constant 1
 111 acc8=> variable 2
 112 ;test8.j(38)   println(44 / (c*d));     // 11
 113 acc8= constant 44
 114 <acc8= variable 1
 115 acc8* variable 2
 116 /acc8 unstack8
 117 call writeAcc8
 118 ;test8.j(39)   b = 48;
 119 acc8= constant 48
 120 acc8=> variable 0
 121 ;test8.j(40)   println(b / (c*d));      // 12
 122 acc8= variable 0
 123 <acc8= variable 1
 124 acc8* variable 2
 125 /acc8 unstack8
 126 call writeAcc8
 127 ;test8.j(41) 
 128 ;test8.j(42)   /************************/
 129 ;test8.j(43)   /* reverse divide word  */
 130 ;test8.j(44)   /************************/
 131 ;test8.j(45)   println(3900 / (300*1)); // 13
 132 acc16= constant 3900
 133 <acc16= constant 300
 134 acc16* constant 1
 135 /acc16 unstack16
 136 call writeAcc16
 137 ;test8.j(46)   i = 4200;
 138 acc16= constant 4200
 139 acc16=> variable 3
 140 ;test8.j(47)   println(i / (300*1));    // 14
 141 acc16= variable 3
 142 <acc16= constant 300
 143 acc16* constant 1
 144 /acc16 unstack16
 145 call writeAcc16
 146 ;test8.j(48)   j = 300;
 147 acc16= constant 300
 148 acc16=> variable 5
 149 ;test8.j(49)   k = 1;
 150 acc8= constant 1
 151 acc8=> variable 7
 152 ;test8.j(50)   println(4500 / (j*k));   // 15
 153 acc16= constant 4500
 154 <acc16= variable 5
 155 acc16* variable 7
 156 /acc16 unstack16
 157 call writeAcc16
 158 ;test8.j(51)   i = 4800;
 159 acc16= constant 4800
 160 acc16=> variable 3
 161 ;test8.j(52)   println(i / (j*k));      // 16
 162 acc16= variable 3
 163 <acc16= variable 5
 164 acc16* variable 7
 165 /acc16 unstack16
 166 call writeAcc16
 167 ;test8.j(53) 
 168 ;test8.j(54)   /**************************/
 169 ;test8.j(55)   /* reverse subtract mixed */
 170 ;test8.j(56)   /**************************/
 171 ;test8.j(57)   i = 21;
 172 acc8= constant 21
 173 acc8=> variable 3
 174 ;test8.j(58)   c = 4;
 175 acc8= constant 4
 176 acc8=> variable 1
 177 ;test8.j(59)   d = 1;
 178 acc8= constant 1
 179 acc8=> variable 2
 180 ;test8.j(60)   println(i - c*d);           // 17
 181 acc16= variable 3
 182 acc8= variable 1
 183 acc8* variable 2
 184 acc16- acc8
 185 call writeAcc16
 186 ;test8.j(61)   b = 22;
 187 acc8= constant 22
 188 acc8=> variable 0
 189 ;test8.j(62)   j = 4;
 190 acc8= constant 4
 191 acc8=> variable 5
 192 ;test8.j(63)   k = 1;
 193 acc8= constant 1
 194 acc8=> variable 7
 195 ;test8.j(64)   println(b - j*k);           // 18
 196 acc8= variable 0
 197 acc16= variable 5
 198 acc16* variable 7
 199 -acc16 acc8
 200 call writeAcc16
 201 ;test8.j(65) 
 202 ;test8.j(66)   /**************************/
 203 ;test8.j(67)   /* reverse divide mixed   */
 204 ;test8.j(68)   /**************************/
 205 ;test8.j(69) 
 206 ;test8.j(70)   /**************************/
 207 ;test8.j(71)   /* forward divide mixed   */
 208 ;test8.j(72)   /**************************/
 209 ;test8.j(73)   i = 19;
 210 acc8= constant 19
 211 acc8=> variable 3
 212 ;test8.j(74)   println(i / (1+0));         // 19
 213 acc16= variable 3
 214 acc8= constant 1
 215 acc8+ constant 0
 216 acc16/ acc8
 217 call writeAcc16
 218 ;test8.j(75)   
 219 ;test8.j(76)   println(i + 1);             // 20
 220 acc16= variable 3
 221 acc16+ constant 1
 222 call writeAcc16
 223 ;test8.j(77)   println(2 + i);             // 21
 224 acc8= constant 2
 225 acc8ToAcc16
 226 acc16+ variable 3
 227 call writeAcc16
 228 ;test8.j(78)   println("Klaar");
 229 acc16= constant 233
 230 writeString
 231 ;test8.j(79) }
 232 stop
 233 stringConstant 0 = "Klaar"
