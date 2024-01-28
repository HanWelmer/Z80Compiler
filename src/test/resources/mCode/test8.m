   0 ;test8.j(0) /*
   1 ;test8.j(1)  * A small program in the miniJava language.
   2 ;test8.j(2)  * Test 8-bit and 16-bit expressions.
   3 ;test8.j(3)  */
   4 ;test8.j(4) class TestReverseSubtractDivision {
   5 ;test8.j(5)   private static byte b;
   6 ;test8.j(6)   private static byte c;
   7 ;test8.j(7)   private static byte d;
   8 ;test8.j(8)   private static word i;
   9 ;test8.j(9)   private static word j;
  10 ;test8.j(10)   private static word k;
  11 ;test8.j(11) 
  12 ;test8.j(12)   public static void main() {
  13 method main [publicLexeme, staticLexeme] voidLexeme
  14 ;test8.j(13)     println(0);
  15 acc8= constant 0
  16 call writeLineAcc8
  17 ;test8.j(14)     /*************************/
  18 ;test8.j(15)     /* reverse subtract byte */
  19 ;test8.j(16)     /*************************/
  20 ;test8.j(17)     println(10 - 3*3);         // 1
  21 acc8= constant 10
  22 <acc8= constant 3
  23 acc8* constant 3
  24 -acc8 unstack8
  25 call writeLineAcc8
  26 ;test8.j(18)     b = 11;
  27 acc8= constant 11
  28 acc8=> variable 0
  29 ;test8.j(19)     println(b - 3*3);          // 2
  30 acc8= variable 0
  31 <acc8= constant 3
  32 acc8* constant 3
  33 -acc8 unstack8
  34 call writeLineAcc8
  35 ;test8.j(20)     c = 3;
  36 acc8= constant 3
  37 acc8=> variable 1
  38 ;test8.j(21)     d = 3;
  39 acc8= constant 3
  40 acc8=> variable 2
  41 ;test8.j(22)     println(12 - c*d);         // 3
  42 acc8= constant 12
  43 <acc8= variable 1
  44 acc8* variable 2
  45 -acc8 unstack8
  46 call writeLineAcc8
  47 ;test8.j(23)     b = 13;
  48 acc8= constant 13
  49 acc8=> variable 0
  50 ;test8.j(24)     println(b - c*d);          // 4
  51 acc8= variable 0
  52 <acc8= variable 1
  53 acc8* variable 2
  54 -acc8 unstack8
  55 call writeLineAcc8
  56 ;test8.j(25)   
  57 ;test8.j(26)     /**************************/
  58 ;test8.j(27)     /* reverse subtract word  */
  59 ;test8.j(28)     /**************************/
  60 ;test8.j(29)     println(1005 - 1000*1);    // 5
  61 acc16= constant 1005
  62 <acc16= constant 1000
  63 acc16* constant 1
  64 -acc16 unstack16
  65 call writeLineAcc16
  66 ;test8.j(30)     i = 1006;
  67 acc16= constant 1006
  68 acc16=> variable 3
  69 ;test8.j(31)     println(i - 1000*1);       // 6
  70 acc16= variable 3
  71 <acc16= constant 1000
  72 acc16* constant 1
  73 -acc16 unstack16
  74 call writeLineAcc16
  75 ;test8.j(32)     j = 1000;
  76 acc16= constant 1000
  77 acc16=> variable 5
  78 ;test8.j(33)     k = 1;
  79 acc8= constant 1
  80 acc8=> variable 7
  81 ;test8.j(34)     println(1007 - j*k);       // 7
  82 acc16= constant 1007
  83 <acc16= variable 5
  84 acc16* variable 7
  85 -acc16 unstack16
  86 call writeLineAcc16
  87 ;test8.j(35)     i = 1008;
  88 acc16= constant 1008
  89 acc16=> variable 3
  90 ;test8.j(36)     println(i - j*k);          // 8
  91 acc16= variable 3
  92 <acc16= variable 5
  93 acc16* variable 7
  94 -acc16 unstack16
  95 call writeLineAcc16
  96 ;test8.j(37)   
  97 ;test8.j(38)     /***********************/
  98 ;test8.j(39)     /* reverse divide byte */
  99 ;test8.j(40)     /***********************/
 100 ;test8.j(41)     println(36 / (4*1));     // 9
 101 acc8= constant 36
 102 <acc8= constant 4
 103 acc8* constant 1
 104 /acc8 unstack8
 105 call writeLineAcc8
 106 ;test8.j(42)     b = 40;
 107 acc8= constant 40
 108 acc8=> variable 0
 109 ;test8.j(43)     println(b / (4*1));      // 10
 110 acc8= variable 0
 111 <acc8= constant 4
 112 acc8* constant 1
 113 /acc8 unstack8
 114 call writeLineAcc8
 115 ;test8.j(44)     c = 4;
 116 acc8= constant 4
 117 acc8=> variable 1
 118 ;test8.j(45)     d = 1;
 119 acc8= constant 1
 120 acc8=> variable 2
 121 ;test8.j(46)     println(44 / (c*d));     // 11
 122 acc8= constant 44
 123 <acc8= variable 1
 124 acc8* variable 2
 125 /acc8 unstack8
 126 call writeLineAcc8
 127 ;test8.j(47)     b = 48;
 128 acc8= constant 48
 129 acc8=> variable 0
 130 ;test8.j(48)     println(b / (c*d));      // 12
 131 acc8= variable 0
 132 <acc8= variable 1
 133 acc8* variable 2
 134 /acc8 unstack8
 135 call writeLineAcc8
 136 ;test8.j(49)   
 137 ;test8.j(50)     /************************/
 138 ;test8.j(51)     /* reverse divide word  */
 139 ;test8.j(52)     /************************/
 140 ;test8.j(53)     println(3900 / (300*1)); // 13
 141 acc16= constant 3900
 142 <acc16= constant 300
 143 acc16* constant 1
 144 /acc16 unstack16
 145 call writeLineAcc16
 146 ;test8.j(54)     i = 4200;
 147 acc16= constant 4200
 148 acc16=> variable 3
 149 ;test8.j(55)     println(i / (300*1));    // 14
 150 acc16= variable 3
 151 <acc16= constant 300
 152 acc16* constant 1
 153 /acc16 unstack16
 154 call writeLineAcc16
 155 ;test8.j(56)     j = 300;
 156 acc16= constant 300
 157 acc16=> variable 5
 158 ;test8.j(57)     k = 1;
 159 acc8= constant 1
 160 acc8=> variable 7
 161 ;test8.j(58)     println(4500 / (j*k));   // 15
 162 acc16= constant 4500
 163 <acc16= variable 5
 164 acc16* variable 7
 165 /acc16 unstack16
 166 call writeLineAcc16
 167 ;test8.j(59)     i = 4800;
 168 acc16= constant 4800
 169 acc16=> variable 3
 170 ;test8.j(60)     println(i / (j*k));      // 16
 171 acc16= variable 3
 172 <acc16= variable 5
 173 acc16* variable 7
 174 /acc16 unstack16
 175 call writeLineAcc16
 176 ;test8.j(61)   
 177 ;test8.j(62)     /**************************/
 178 ;test8.j(63)     /* reverse subtract mixed */
 179 ;test8.j(64)     /**************************/
 180 ;test8.j(65)     i = 21;
 181 acc8= constant 21
 182 acc8=> variable 3
 183 ;test8.j(66)     c = 4;
 184 acc8= constant 4
 185 acc8=> variable 1
 186 ;test8.j(67)     d = 1;
 187 acc8= constant 1
 188 acc8=> variable 2
 189 ;test8.j(68)     println(i - c*d);           // 17
 190 acc16= variable 3
 191 acc8= variable 1
 192 acc8* variable 2
 193 acc16- acc8
 194 call writeLineAcc16
 195 ;test8.j(69)     b = 22;
 196 acc8= constant 22
 197 acc8=> variable 0
 198 ;test8.j(70)     j = 4;
 199 acc8= constant 4
 200 acc8=> variable 5
 201 ;test8.j(71)     k = 1;
 202 acc8= constant 1
 203 acc8=> variable 7
 204 ;test8.j(72)     println(b - j*k);           // 18
 205 acc8= variable 0
 206 acc16= variable 5
 207 acc16* variable 7
 208 -acc16 acc8
 209 call writeLineAcc16
 210 ;test8.j(73)   
 211 ;test8.j(74)     /**************************/
 212 ;test8.j(75)     /* reverse divide mixed   */
 213 ;test8.j(76)     /**************************/
 214 ;test8.j(77)   
 215 ;test8.j(78)     /**************************/
 216 ;test8.j(79)     /* forward divide mixed   */
 217 ;test8.j(80)     /**************************/
 218 ;test8.j(81)     i = 19;
 219 acc8= constant 19
 220 acc8=> variable 3
 221 ;test8.j(82)     println(i / (1+0));         // 19
 222 acc16= variable 3
 223 acc8= constant 1
 224 acc8+ constant 0
 225 acc16/ acc8
 226 call writeLineAcc16
 227 ;test8.j(83)     
 228 ;test8.j(84)     println(i + 1);             // 20
 229 acc16= variable 3
 230 acc16+ constant 1
 231 call writeLineAcc16
 232 ;test8.j(85)     println(2 + i);             // 21
 233 acc8= constant 2
 234 acc8ToAcc16
 235 acc16+ variable 3
 236 call writeLineAcc16
 237 ;test8.j(86)     println(2*5+3*4);           // 22
 238 acc8= constant 2
 239 acc8* constant 5
 240 <acc8= constant 3
 241 acc8* constant 4
 242 acc8+ unstack8
 243 call writeLineAcc8
 244 ;test8.j(87)     println(120/4-(3+8/2));     // 23
 245 acc8= constant 120
 246 acc8/ constant 4
 247 <acc8= constant 3
 248 <acc8= constant 8
 249 acc8/ constant 2
 250 acc8+ unstack8
 251 -acc8 unstack8
 252 call writeLineAcc8
 253 ;test8.j(88)     println("Klaar");
 254 acc16= constant 259
 255 writeLineString
 256 ;test8.j(89)   }
 257 ;test8.j(90) }
 258 stop
 259 stringConstant 0 = "Klaar"
