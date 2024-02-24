   0 call 16
   1 stop
   2 ;test8.j(0) /*
   3 ;test8.j(1)  * A small program in the miniJava language.
   4 ;test8.j(2)  * Test 8-bit and 16-bit expressions.
   5 ;test8.j(3)  */
   6 ;test8.j(4) class TestReverseSubtractDivision {
   7 class TestReverseSubtractDivision []
   8 ;test8.j(5)   private static byte b;
   9 ;test8.j(6)   private static byte c;
  10 ;test8.j(7)   private static byte d;
  11 ;test8.j(8)   private static word i;
  12 ;test8.j(9)   private static word j;
  13 ;test8.j(10)   private static word k;
  14 ;test8.j(11) 
  15 ;test8.j(12)   public static void main() {
  16 method main [public, static] void
  17 ;test8.j(13)     println(0);
  18 acc8= constant 0
  19 call writeLineAcc8
  20 ;test8.j(14)     /*************************/
  21 ;test8.j(15)     /* reverse subtract byte */
  22 ;test8.j(16)     /*************************/
  23 ;test8.j(17)     println(10 - 3*3);         // 1
  24 acc8= constant 10
  25 <acc8= constant 3
  26 acc8* constant 3
  27 -acc8 unstack8
  28 call writeLineAcc8
  29 ;test8.j(18)     b = 11;
  30 acc8= constant 11
  31 acc8=> variable 0
  32 ;test8.j(19)     println(b - 3*3);          // 2
  33 acc8= variable 0
  34 <acc8= constant 3
  35 acc8* constant 3
  36 -acc8 unstack8
  37 call writeLineAcc8
  38 ;test8.j(20)     c = 3;
  39 acc8= constant 3
  40 acc8=> variable 1
  41 ;test8.j(21)     d = 3;
  42 acc8= constant 3
  43 acc8=> variable 2
  44 ;test8.j(22)     println(12 - c*d);         // 3
  45 acc8= constant 12
  46 <acc8= variable 1
  47 acc8* variable 2
  48 -acc8 unstack8
  49 call writeLineAcc8
  50 ;test8.j(23)     b = 13;
  51 acc8= constant 13
  52 acc8=> variable 0
  53 ;test8.j(24)     println(b - c*d);          // 4
  54 acc8= variable 0
  55 <acc8= variable 1
  56 acc8* variable 2
  57 -acc8 unstack8
  58 call writeLineAcc8
  59 ;test8.j(25)   
  60 ;test8.j(26)     /**************************/
  61 ;test8.j(27)     /* reverse subtract word  */
  62 ;test8.j(28)     /**************************/
  63 ;test8.j(29)     println(1005 - 1000*1);    // 5
  64 acc16= constant 1005
  65 <acc16= constant 1000
  66 acc16* constant 1
  67 -acc16 unstack16
  68 call writeLineAcc16
  69 ;test8.j(30)     i = 1006;
  70 acc16= constant 1006
  71 acc16=> variable 3
  72 ;test8.j(31)     println(i - 1000*1);       // 6
  73 acc16= variable 3
  74 <acc16= constant 1000
  75 acc16* constant 1
  76 -acc16 unstack16
  77 call writeLineAcc16
  78 ;test8.j(32)     j = 1000;
  79 acc16= constant 1000
  80 acc16=> variable 5
  81 ;test8.j(33)     k = 1;
  82 acc8= constant 1
  83 acc8=> variable 7
  84 ;test8.j(34)     println(1007 - j*k);       // 7
  85 acc16= constant 1007
  86 <acc16= variable 5
  87 acc16* variable 7
  88 -acc16 unstack16
  89 call writeLineAcc16
  90 ;test8.j(35)     i = 1008;
  91 acc16= constant 1008
  92 acc16=> variable 3
  93 ;test8.j(36)     println(i - j*k);          // 8
  94 acc16= variable 3
  95 <acc16= variable 5
  96 acc16* variable 7
  97 -acc16 unstack16
  98 call writeLineAcc16
  99 ;test8.j(37)   
 100 ;test8.j(38)     /***********************/
 101 ;test8.j(39)     /* reverse divide byte */
 102 ;test8.j(40)     /***********************/
 103 ;test8.j(41)     println(36 / (4*1));     // 9
 104 acc8= constant 36
 105 <acc8= constant 4
 106 acc8* constant 1
 107 /acc8 unstack8
 108 call writeLineAcc8
 109 ;test8.j(42)     b = 40;
 110 acc8= constant 40
 111 acc8=> variable 0
 112 ;test8.j(43)     println(b / (4*1));      // 10
 113 acc8= variable 0
 114 <acc8= constant 4
 115 acc8* constant 1
 116 /acc8 unstack8
 117 call writeLineAcc8
 118 ;test8.j(44)     c = 4;
 119 acc8= constant 4
 120 acc8=> variable 1
 121 ;test8.j(45)     d = 1;
 122 acc8= constant 1
 123 acc8=> variable 2
 124 ;test8.j(46)     println(44 / (c*d));     // 11
 125 acc8= constant 44
 126 <acc8= variable 1
 127 acc8* variable 2
 128 /acc8 unstack8
 129 call writeLineAcc8
 130 ;test8.j(47)     b = 48;
 131 acc8= constant 48
 132 acc8=> variable 0
 133 ;test8.j(48)     println(b / (c*d));      // 12
 134 acc8= variable 0
 135 <acc8= variable 1
 136 acc8* variable 2
 137 /acc8 unstack8
 138 call writeLineAcc8
 139 ;test8.j(49)   
 140 ;test8.j(50)     /************************/
 141 ;test8.j(51)     /* reverse divide word  */
 142 ;test8.j(52)     /************************/
 143 ;test8.j(53)     println(3900 / (300*1)); // 13
 144 acc16= constant 3900
 145 <acc16= constant 300
 146 acc16* constant 1
 147 /acc16 unstack16
 148 call writeLineAcc16
 149 ;test8.j(54)     i = 4200;
 150 acc16= constant 4200
 151 acc16=> variable 3
 152 ;test8.j(55)     println(i / (300*1));    // 14
 153 acc16= variable 3
 154 <acc16= constant 300
 155 acc16* constant 1
 156 /acc16 unstack16
 157 call writeLineAcc16
 158 ;test8.j(56)     j = 300;
 159 acc16= constant 300
 160 acc16=> variable 5
 161 ;test8.j(57)     k = 1;
 162 acc8= constant 1
 163 acc8=> variable 7
 164 ;test8.j(58)     println(4500 / (j*k));   // 15
 165 acc16= constant 4500
 166 <acc16= variable 5
 167 acc16* variable 7
 168 /acc16 unstack16
 169 call writeLineAcc16
 170 ;test8.j(59)     i = 4800;
 171 acc16= constant 4800
 172 acc16=> variable 3
 173 ;test8.j(60)     println(i / (j*k));      // 16
 174 acc16= variable 3
 175 <acc16= variable 5
 176 acc16* variable 7
 177 /acc16 unstack16
 178 call writeLineAcc16
 179 ;test8.j(61)   
 180 ;test8.j(62)     /**************************/
 181 ;test8.j(63)     /* reverse subtract mixed */
 182 ;test8.j(64)     /**************************/
 183 ;test8.j(65)     i = 21;
 184 acc8= constant 21
 185 acc8=> variable 3
 186 ;test8.j(66)     c = 4;
 187 acc8= constant 4
 188 acc8=> variable 1
 189 ;test8.j(67)     d = 1;
 190 acc8= constant 1
 191 acc8=> variable 2
 192 ;test8.j(68)     println(i - c*d);           // 17
 193 acc16= variable 3
 194 acc8= variable 1
 195 acc8* variable 2
 196 acc16- acc8
 197 call writeLineAcc16
 198 ;test8.j(69)     b = 22;
 199 acc8= constant 22
 200 acc8=> variable 0
 201 ;test8.j(70)     j = 4;
 202 acc8= constant 4
 203 acc8=> variable 5
 204 ;test8.j(71)     k = 1;
 205 acc8= constant 1
 206 acc8=> variable 7
 207 ;test8.j(72)     println(b - j*k);           // 18
 208 acc8= variable 0
 209 acc16= variable 5
 210 acc16* variable 7
 211 -acc16 acc8
 212 call writeLineAcc16
 213 ;test8.j(73)   
 214 ;test8.j(74)     /**************************/
 215 ;test8.j(75)     /* reverse divide mixed   */
 216 ;test8.j(76)     /**************************/
 217 ;test8.j(77)   
 218 ;test8.j(78)     /**************************/
 219 ;test8.j(79)     /* forward divide mixed   */
 220 ;test8.j(80)     /**************************/
 221 ;test8.j(81)     i = 19;
 222 acc8= constant 19
 223 acc8=> variable 3
 224 ;test8.j(82)     println(i / (1+0));         // 19
 225 acc16= variable 3
 226 acc8= constant 1
 227 acc8+ constant 0
 228 acc16/ acc8
 229 call writeLineAcc16
 230 ;test8.j(83)     
 231 ;test8.j(84)     println(i + 1);             // 20
 232 acc16= variable 3
 233 acc16+ constant 1
 234 call writeLineAcc16
 235 ;test8.j(85)     println(2 + i);             // 21
 236 acc8= constant 2
 237 acc8ToAcc16
 238 acc16+ variable 3
 239 call writeLineAcc16
 240 ;test8.j(86)     println(2*5+3*4);           // 22
 241 acc8= constant 2
 242 acc8* constant 5
 243 <acc8= constant 3
 244 acc8* constant 4
 245 acc8+ unstack8
 246 call writeLineAcc8
 247 ;test8.j(87)     println(120/4-(3+8/2));     // 23
 248 acc8= constant 120
 249 acc8/ constant 4
 250 <acc8= constant 3
 251 <acc8= constant 8
 252 acc8/ constant 2
 253 acc8+ unstack8
 254 -acc8 unstack8
 255 call writeLineAcc8
 256 ;test8.j(88)     println("Klaar");
 257 acc16= constant 262
 258 writeLineString
 259 return
 260 ;test8.j(89)   }
 261 ;test8.j(90) }
 262 stringConstant 0 = "Klaar"
