   0 ;test8.j(0) /*
   1 ;test8.j(1)  * A small program in the miniJava language.
   2 ;test8.j(2)  * Test 8-bit and 16-bit expressions.
   3 ;test8.j(3)  */
   4 ;test8.j(4) class TestReverseSubtractDivision {
   5 class TestReverseSubtractDivision []
   6 ;test8.j(5)   private static byte b;
   7 ;test8.j(6)   private static byte c;
   8 ;test8.j(7)   private static byte d;
   9 ;test8.j(8)   private static word i;
  10 ;test8.j(9)   private static word j;
  11 ;test8.j(10)   private static word k;
  12 ;test8.j(11) 
  13 ;test8.j(12)   public static void main() {
  14 method main [public, static] void
  15 ;test8.j(13)     println(0);
  16 acc8= constant 0
  17 call writeLineAcc8
  18 ;test8.j(14)     /*************************/
  19 ;test8.j(15)     /* reverse subtract byte */
  20 ;test8.j(16)     /*************************/
  21 ;test8.j(17)     println(10 - 3*3);         // 1
  22 acc8= constant 10
  23 <acc8= constant 3
  24 acc8* constant 3
  25 -acc8 unstack8
  26 call writeLineAcc8
  27 ;test8.j(18)     b = 11;
  28 acc8= constant 11
  29 acc8=> variable 0
  30 ;test8.j(19)     println(b - 3*3);          // 2
  31 acc8= variable 0
  32 <acc8= constant 3
  33 acc8* constant 3
  34 -acc8 unstack8
  35 call writeLineAcc8
  36 ;test8.j(20)     c = 3;
  37 acc8= constant 3
  38 acc8=> variable 1
  39 ;test8.j(21)     d = 3;
  40 acc8= constant 3
  41 acc8=> variable 2
  42 ;test8.j(22)     println(12 - c*d);         // 3
  43 acc8= constant 12
  44 <acc8= variable 1
  45 acc8* variable 2
  46 -acc8 unstack8
  47 call writeLineAcc8
  48 ;test8.j(23)     b = 13;
  49 acc8= constant 13
  50 acc8=> variable 0
  51 ;test8.j(24)     println(b - c*d);          // 4
  52 acc8= variable 0
  53 <acc8= variable 1
  54 acc8* variable 2
  55 -acc8 unstack8
  56 call writeLineAcc8
  57 ;test8.j(25)   
  58 ;test8.j(26)     /**************************/
  59 ;test8.j(27)     /* reverse subtract word  */
  60 ;test8.j(28)     /**************************/
  61 ;test8.j(29)     println(1005 - 1000*1);    // 5
  62 acc16= constant 1005
  63 <acc16= constant 1000
  64 acc16* constant 1
  65 -acc16 unstack16
  66 call writeLineAcc16
  67 ;test8.j(30)     i = 1006;
  68 acc16= constant 1006
  69 acc16=> variable 3
  70 ;test8.j(31)     println(i - 1000*1);       // 6
  71 acc16= variable 3
  72 <acc16= constant 1000
  73 acc16* constant 1
  74 -acc16 unstack16
  75 call writeLineAcc16
  76 ;test8.j(32)     j = 1000;
  77 acc16= constant 1000
  78 acc16=> variable 5
  79 ;test8.j(33)     k = 1;
  80 acc8= constant 1
  81 acc8=> variable 7
  82 ;test8.j(34)     println(1007 - j*k);       // 7
  83 acc16= constant 1007
  84 <acc16= variable 5
  85 acc16* variable 7
  86 -acc16 unstack16
  87 call writeLineAcc16
  88 ;test8.j(35)     i = 1008;
  89 acc16= constant 1008
  90 acc16=> variable 3
  91 ;test8.j(36)     println(i - j*k);          // 8
  92 acc16= variable 3
  93 <acc16= variable 5
  94 acc16* variable 7
  95 -acc16 unstack16
  96 call writeLineAcc16
  97 ;test8.j(37)   
  98 ;test8.j(38)     /***********************/
  99 ;test8.j(39)     /* reverse divide byte */
 100 ;test8.j(40)     /***********************/
 101 ;test8.j(41)     println(36 / (4*1));     // 9
 102 acc8= constant 36
 103 <acc8= constant 4
 104 acc8* constant 1
 105 /acc8 unstack8
 106 call writeLineAcc8
 107 ;test8.j(42)     b = 40;
 108 acc8= constant 40
 109 acc8=> variable 0
 110 ;test8.j(43)     println(b / (4*1));      // 10
 111 acc8= variable 0
 112 <acc8= constant 4
 113 acc8* constant 1
 114 /acc8 unstack8
 115 call writeLineAcc8
 116 ;test8.j(44)     c = 4;
 117 acc8= constant 4
 118 acc8=> variable 1
 119 ;test8.j(45)     d = 1;
 120 acc8= constant 1
 121 acc8=> variable 2
 122 ;test8.j(46)     println(44 / (c*d));     // 11
 123 acc8= constant 44
 124 <acc8= variable 1
 125 acc8* variable 2
 126 /acc8 unstack8
 127 call writeLineAcc8
 128 ;test8.j(47)     b = 48;
 129 acc8= constant 48
 130 acc8=> variable 0
 131 ;test8.j(48)     println(b / (c*d));      // 12
 132 acc8= variable 0
 133 <acc8= variable 1
 134 acc8* variable 2
 135 /acc8 unstack8
 136 call writeLineAcc8
 137 ;test8.j(49)   
 138 ;test8.j(50)     /************************/
 139 ;test8.j(51)     /* reverse divide word  */
 140 ;test8.j(52)     /************************/
 141 ;test8.j(53)     println(3900 / (300*1)); // 13
 142 acc16= constant 3900
 143 <acc16= constant 300
 144 acc16* constant 1
 145 /acc16 unstack16
 146 call writeLineAcc16
 147 ;test8.j(54)     i = 4200;
 148 acc16= constant 4200
 149 acc16=> variable 3
 150 ;test8.j(55)     println(i / (300*1));    // 14
 151 acc16= variable 3
 152 <acc16= constant 300
 153 acc16* constant 1
 154 /acc16 unstack16
 155 call writeLineAcc16
 156 ;test8.j(56)     j = 300;
 157 acc16= constant 300
 158 acc16=> variable 5
 159 ;test8.j(57)     k = 1;
 160 acc8= constant 1
 161 acc8=> variable 7
 162 ;test8.j(58)     println(4500 / (j*k));   // 15
 163 acc16= constant 4500
 164 <acc16= variable 5
 165 acc16* variable 7
 166 /acc16 unstack16
 167 call writeLineAcc16
 168 ;test8.j(59)     i = 4800;
 169 acc16= constant 4800
 170 acc16=> variable 3
 171 ;test8.j(60)     println(i / (j*k));      // 16
 172 acc16= variable 3
 173 <acc16= variable 5
 174 acc16* variable 7
 175 /acc16 unstack16
 176 call writeLineAcc16
 177 ;test8.j(61)   
 178 ;test8.j(62)     /**************************/
 179 ;test8.j(63)     /* reverse subtract mixed */
 180 ;test8.j(64)     /**************************/
 181 ;test8.j(65)     i = 21;
 182 acc8= constant 21
 183 acc8=> variable 3
 184 ;test8.j(66)     c = 4;
 185 acc8= constant 4
 186 acc8=> variable 1
 187 ;test8.j(67)     d = 1;
 188 acc8= constant 1
 189 acc8=> variable 2
 190 ;test8.j(68)     println(i - c*d);           // 17
 191 acc16= variable 3
 192 acc8= variable 1
 193 acc8* variable 2
 194 acc16- acc8
 195 call writeLineAcc16
 196 ;test8.j(69)     b = 22;
 197 acc8= constant 22
 198 acc8=> variable 0
 199 ;test8.j(70)     j = 4;
 200 acc8= constant 4
 201 acc8=> variable 5
 202 ;test8.j(71)     k = 1;
 203 acc8= constant 1
 204 acc8=> variable 7
 205 ;test8.j(72)     println(b - j*k);           // 18
 206 acc8= variable 0
 207 acc16= variable 5
 208 acc16* variable 7
 209 -acc16 acc8
 210 call writeLineAcc16
 211 ;test8.j(73)   
 212 ;test8.j(74)     /**************************/
 213 ;test8.j(75)     /* reverse divide mixed   */
 214 ;test8.j(76)     /**************************/
 215 ;test8.j(77)   
 216 ;test8.j(78)     /**************************/
 217 ;test8.j(79)     /* forward divide mixed   */
 218 ;test8.j(80)     /**************************/
 219 ;test8.j(81)     i = 19;
 220 acc8= constant 19
 221 acc8=> variable 3
 222 ;test8.j(82)     println(i / (1+0));         // 19
 223 acc16= variable 3
 224 acc8= constant 1
 225 acc8+ constant 0
 226 acc16/ acc8
 227 call writeLineAcc16
 228 ;test8.j(83)     
 229 ;test8.j(84)     println(i + 1);             // 20
 230 acc16= variable 3
 231 acc16+ constant 1
 232 call writeLineAcc16
 233 ;test8.j(85)     println(2 + i);             // 21
 234 acc8= constant 2
 235 acc8ToAcc16
 236 acc16+ variable 3
 237 call writeLineAcc16
 238 ;test8.j(86)     println(2*5+3*4);           // 22
 239 acc8= constant 2
 240 acc8* constant 5
 241 <acc8= constant 3
 242 acc8* constant 4
 243 acc8+ unstack8
 244 call writeLineAcc8
 245 ;test8.j(87)     println(120/4-(3+8/2));     // 23
 246 acc8= constant 120
 247 acc8/ constant 4
 248 <acc8= constant 3
 249 <acc8= constant 8
 250 acc8/ constant 2
 251 acc8+ unstack8
 252 -acc8 unstack8
 253 call writeLineAcc8
 254 ;test8.j(88)     println("Klaar");
 255 acc16= constant 260
 256 writeLineString
 257 ;test8.j(89)   }
 258 ;test8.j(90) }
 259 stop
 260 stringConstant 0 = "Klaar"
