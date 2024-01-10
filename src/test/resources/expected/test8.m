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
  13 ;test8.j(13)     println(0);
  14 acc8= constant 0
  15 call writeLineAcc8
  16 ;test8.j(14)     /*************************/
  17 ;test8.j(15)     /* reverse subtract byte */
  18 ;test8.j(16)     /*************************/
  19 ;test8.j(17)     println(10 - 3*3);         // 1
  20 acc8= constant 10
  21 <acc8= constant 3
  22 acc8* constant 3
  23 -acc8 unstack8
  24 call writeLineAcc8
  25 ;test8.j(18)     b = 11;
  26 acc8= constant 11
  27 acc8=> variable 0
  28 ;test8.j(19)     println(b - 3*3);          // 2
  29 acc8= variable 0
  30 <acc8= constant 3
  31 acc8* constant 3
  32 -acc8 unstack8
  33 call writeLineAcc8
  34 ;test8.j(20)     c = 3;
  35 acc8= constant 3
  36 acc8=> variable 1
  37 ;test8.j(21)     d = 3;
  38 acc8= constant 3
  39 acc8=> variable 2
  40 ;test8.j(22)     println(12 - c*d);         // 3
  41 acc8= constant 12
  42 <acc8= variable 1
  43 acc8* variable 2
  44 -acc8 unstack8
  45 call writeLineAcc8
  46 ;test8.j(23)     b = 13;
  47 acc8= constant 13
  48 acc8=> variable 0
  49 ;test8.j(24)     println(b - c*d);          // 4
  50 acc8= variable 0
  51 <acc8= variable 1
  52 acc8* variable 2
  53 -acc8 unstack8
  54 call writeLineAcc8
  55 ;test8.j(25)   
  56 ;test8.j(26)     /**************************/
  57 ;test8.j(27)     /* reverse subtract word  */
  58 ;test8.j(28)     /**************************/
  59 ;test8.j(29)     println(1005 - 1000*1);    // 5
  60 acc16= constant 1005
  61 <acc16= constant 1000
  62 acc16* constant 1
  63 -acc16 unstack16
  64 call writeLineAcc16
  65 ;test8.j(30)     i = 1006;
  66 acc16= constant 1006
  67 acc16=> variable 3
  68 ;test8.j(31)     println(i - 1000*1);       // 6
  69 acc16= variable 3
  70 <acc16= constant 1000
  71 acc16* constant 1
  72 -acc16 unstack16
  73 call writeLineAcc16
  74 ;test8.j(32)     j = 1000;
  75 acc16= constant 1000
  76 acc16=> variable 5
  77 ;test8.j(33)     k = 1;
  78 acc8= constant 1
  79 acc8=> variable 7
  80 ;test8.j(34)     println(1007 - j*k);       // 7
  81 acc16= constant 1007
  82 <acc16= variable 5
  83 acc16* variable 7
  84 -acc16 unstack16
  85 call writeLineAcc16
  86 ;test8.j(35)     i = 1008;
  87 acc16= constant 1008
  88 acc16=> variable 3
  89 ;test8.j(36)     println(i - j*k);          // 8
  90 acc16= variable 3
  91 <acc16= variable 5
  92 acc16* variable 7
  93 -acc16 unstack16
  94 call writeLineAcc16
  95 ;test8.j(37)   
  96 ;test8.j(38)     /***********************/
  97 ;test8.j(39)     /* reverse divide byte */
  98 ;test8.j(40)     /***********************/
  99 ;test8.j(41)     println(36 / (4*1));     // 9
 100 acc8= constant 36
 101 <acc8= constant 4
 102 acc8* constant 1
 103 /acc8 unstack8
 104 call writeLineAcc8
 105 ;test8.j(42)     b = 40;
 106 acc8= constant 40
 107 acc8=> variable 0
 108 ;test8.j(43)     println(b / (4*1));      // 10
 109 acc8= variable 0
 110 <acc8= constant 4
 111 acc8* constant 1
 112 /acc8 unstack8
 113 call writeLineAcc8
 114 ;test8.j(44)     c = 4;
 115 acc8= constant 4
 116 acc8=> variable 1
 117 ;test8.j(45)     d = 1;
 118 acc8= constant 1
 119 acc8=> variable 2
 120 ;test8.j(46)     println(44 / (c*d));     // 11
 121 acc8= constant 44
 122 <acc8= variable 1
 123 acc8* variable 2
 124 /acc8 unstack8
 125 call writeLineAcc8
 126 ;test8.j(47)     b = 48;
 127 acc8= constant 48
 128 acc8=> variable 0
 129 ;test8.j(48)     println(b / (c*d));      // 12
 130 acc8= variable 0
 131 <acc8= variable 1
 132 acc8* variable 2
 133 /acc8 unstack8
 134 call writeLineAcc8
 135 ;test8.j(49)   
 136 ;test8.j(50)     /************************/
 137 ;test8.j(51)     /* reverse divide word  */
 138 ;test8.j(52)     /************************/
 139 ;test8.j(53)     println(3900 / (300*1)); // 13
 140 acc16= constant 3900
 141 <acc16= constant 300
 142 acc16* constant 1
 143 /acc16 unstack16
 144 call writeLineAcc16
 145 ;test8.j(54)     i = 4200;
 146 acc16= constant 4200
 147 acc16=> variable 3
 148 ;test8.j(55)     println(i / (300*1));    // 14
 149 acc16= variable 3
 150 <acc16= constant 300
 151 acc16* constant 1
 152 /acc16 unstack16
 153 call writeLineAcc16
 154 ;test8.j(56)     j = 300;
 155 acc16= constant 300
 156 acc16=> variable 5
 157 ;test8.j(57)     k = 1;
 158 acc8= constant 1
 159 acc8=> variable 7
 160 ;test8.j(58)     println(4500 / (j*k));   // 15
 161 acc16= constant 4500
 162 <acc16= variable 5
 163 acc16* variable 7
 164 /acc16 unstack16
 165 call writeLineAcc16
 166 ;test8.j(59)     i = 4800;
 167 acc16= constant 4800
 168 acc16=> variable 3
 169 ;test8.j(60)     println(i / (j*k));      // 16
 170 acc16= variable 3
 171 <acc16= variable 5
 172 acc16* variable 7
 173 /acc16 unstack16
 174 call writeLineAcc16
 175 ;test8.j(61)   
 176 ;test8.j(62)     /**************************/
 177 ;test8.j(63)     /* reverse subtract mixed */
 178 ;test8.j(64)     /**************************/
 179 ;test8.j(65)     i = 21;
 180 acc8= constant 21
 181 acc8=> variable 3
 182 ;test8.j(66)     c = 4;
 183 acc8= constant 4
 184 acc8=> variable 1
 185 ;test8.j(67)     d = 1;
 186 acc8= constant 1
 187 acc8=> variable 2
 188 ;test8.j(68)     println(i - c*d);           // 17
 189 acc16= variable 3
 190 acc8= variable 1
 191 acc8* variable 2
 192 acc16- acc8
 193 call writeLineAcc16
 194 ;test8.j(69)     b = 22;
 195 acc8= constant 22
 196 acc8=> variable 0
 197 ;test8.j(70)     j = 4;
 198 acc8= constant 4
 199 acc8=> variable 5
 200 ;test8.j(71)     k = 1;
 201 acc8= constant 1
 202 acc8=> variable 7
 203 ;test8.j(72)     println(b - j*k);           // 18
 204 acc8= variable 0
 205 acc16= variable 5
 206 acc16* variable 7
 207 -acc16 acc8
 208 call writeLineAcc16
 209 ;test8.j(73)   
 210 ;test8.j(74)     /**************************/
 211 ;test8.j(75)     /* reverse divide mixed   */
 212 ;test8.j(76)     /**************************/
 213 ;test8.j(77)   
 214 ;test8.j(78)     /**************************/
 215 ;test8.j(79)     /* forward divide mixed   */
 216 ;test8.j(80)     /**************************/
 217 ;test8.j(81)     i = 19;
 218 acc8= constant 19
 219 acc8=> variable 3
 220 ;test8.j(82)     println(i / (1+0));         // 19
 221 acc16= variable 3
 222 acc8= constant 1
 223 acc8+ constant 0
 224 acc16/ acc8
 225 call writeLineAcc16
 226 ;test8.j(83)     
 227 ;test8.j(84)     println(i + 1);             // 20
 228 acc16= variable 3
 229 acc16+ constant 1
 230 call writeLineAcc16
 231 ;test8.j(85)     println(2 + i);             // 21
 232 acc8= constant 2
 233 acc8ToAcc16
 234 acc16+ variable 3
 235 call writeLineAcc16
 236 ;test8.j(86)     println(2*5+3*4);           // 22
 237 acc8= constant 2
 238 acc8* constant 5
 239 <acc8= constant 3
 240 acc8* constant 4
 241 acc8+ unstack8
 242 call writeLineAcc8
 243 ;test8.j(87)     println(120/4-(3+8/2));     // 23
 244 acc8= constant 120
 245 acc8/ constant 4
 246 <acc8= constant 3
 247 <acc8= constant 8
 248 acc8/ constant 2
 249 acc8+ unstack8
 250 -acc8 unstack8
 251 call writeLineAcc8
 252 ;test8.j(88)     println("Klaar");
 253 acc16= constant 258
 254 writeLineString
 255 ;test8.j(89)   }
 256 ;test8.j(90) }
 257 stop
 258 stringConstant 0 = "Klaar"
