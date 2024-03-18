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
  16 method main [public, static] void ()
  17 <basePointer
  18 basePointer= stackPointer
  19 stackPointer+ constant 0
  20 ;test8.j(13)     println(0);
  21 acc8= constant 0
  22 writeLineAcc8
  23 ;test8.j(14)     /*************************/
  24 ;test8.j(15)     /* reverse subtract byte */
  25 ;test8.j(16)     /*************************/
  26 ;test8.j(17)     println(10 - 3*3);         // 1
  27 acc8= constant 10
  28 <acc8= constant 3
  29 acc8* constant 3
  30 -acc8 unstack8
  31 writeLineAcc8
  32 ;test8.j(18)     b = 11;
  33 acc8= constant 11
  34 acc8=> variable 0
  35 ;test8.j(19)     println(b - 3*3);          // 2
  36 acc8= variable 0
  37 <acc8= constant 3
  38 acc8* constant 3
  39 -acc8 unstack8
  40 writeLineAcc8
  41 ;test8.j(20)     c = 3;
  42 acc8= constant 3
  43 acc8=> variable 1
  44 ;test8.j(21)     d = 3;
  45 acc8= constant 3
  46 acc8=> variable 2
  47 ;test8.j(22)     println(12 - c*d);         // 3
  48 acc8= constant 12
  49 <acc8= variable 1
  50 acc8* variable 2
  51 -acc8 unstack8
  52 writeLineAcc8
  53 ;test8.j(23)     b = 13;
  54 acc8= constant 13
  55 acc8=> variable 0
  56 ;test8.j(24)     println(b - c*d);          // 4
  57 acc8= variable 0
  58 <acc8= variable 1
  59 acc8* variable 2
  60 -acc8 unstack8
  61 writeLineAcc8
  62 ;test8.j(25)   
  63 ;test8.j(26)     /**************************/
  64 ;test8.j(27)     /* reverse subtract word  */
  65 ;test8.j(28)     /**************************/
  66 ;test8.j(29)     println(1005 - 1000*1);    // 5
  67 acc16= constant 1005
  68 <acc16= constant 1000
  69 acc16* constant 1
  70 -acc16 unstack16
  71 writeLineAcc16
  72 ;test8.j(30)     i = 1006;
  73 acc16= constant 1006
  74 acc16=> variable 3
  75 ;test8.j(31)     println(i - 1000*1);       // 6
  76 acc16= variable 3
  77 <acc16= constant 1000
  78 acc16* constant 1
  79 -acc16 unstack16
  80 writeLineAcc16
  81 ;test8.j(32)     j = 1000;
  82 acc16= constant 1000
  83 acc16=> variable 5
  84 ;test8.j(33)     k = 1;
  85 acc8= constant 1
  86 acc8=> variable 7
  87 ;test8.j(34)     println(1007 - j*k);       // 7
  88 acc16= constant 1007
  89 <acc16= variable 5
  90 acc16* variable 7
  91 -acc16 unstack16
  92 writeLineAcc16
  93 ;test8.j(35)     i = 1008;
  94 acc16= constant 1008
  95 acc16=> variable 3
  96 ;test8.j(36)     println(i - j*k);          // 8
  97 acc16= variable 3
  98 <acc16= variable 5
  99 acc16* variable 7
 100 -acc16 unstack16
 101 writeLineAcc16
 102 ;test8.j(37)   
 103 ;test8.j(38)     /***********************/
 104 ;test8.j(39)     /* reverse divide byte */
 105 ;test8.j(40)     /***********************/
 106 ;test8.j(41)     println(36 / (4*1));     // 9
 107 acc8= constant 36
 108 <acc8= constant 4
 109 acc8* constant 1
 110 /acc8 unstack8
 111 writeLineAcc8
 112 ;test8.j(42)     b = 40;
 113 acc8= constant 40
 114 acc8=> variable 0
 115 ;test8.j(43)     println(b / (4*1));      // 10
 116 acc8= variable 0
 117 <acc8= constant 4
 118 acc8* constant 1
 119 /acc8 unstack8
 120 writeLineAcc8
 121 ;test8.j(44)     c = 4;
 122 acc8= constant 4
 123 acc8=> variable 1
 124 ;test8.j(45)     d = 1;
 125 acc8= constant 1
 126 acc8=> variable 2
 127 ;test8.j(46)     println(44 / (c*d));     // 11
 128 acc8= constant 44
 129 <acc8= variable 1
 130 acc8* variable 2
 131 /acc8 unstack8
 132 writeLineAcc8
 133 ;test8.j(47)     b = 48;
 134 acc8= constant 48
 135 acc8=> variable 0
 136 ;test8.j(48)     println(b / (c*d));      // 12
 137 acc8= variable 0
 138 <acc8= variable 1
 139 acc8* variable 2
 140 /acc8 unstack8
 141 writeLineAcc8
 142 ;test8.j(49)   
 143 ;test8.j(50)     /************************/
 144 ;test8.j(51)     /* reverse divide word  */
 145 ;test8.j(52)     /************************/
 146 ;test8.j(53)     println(3900 / (300*1)); // 13
 147 acc16= constant 3900
 148 <acc16= constant 300
 149 acc16* constant 1
 150 /acc16 unstack16
 151 writeLineAcc16
 152 ;test8.j(54)     i = 4200;
 153 acc16= constant 4200
 154 acc16=> variable 3
 155 ;test8.j(55)     println(i / (300*1));    // 14
 156 acc16= variable 3
 157 <acc16= constant 300
 158 acc16* constant 1
 159 /acc16 unstack16
 160 writeLineAcc16
 161 ;test8.j(56)     j = 300;
 162 acc16= constant 300
 163 acc16=> variable 5
 164 ;test8.j(57)     k = 1;
 165 acc8= constant 1
 166 acc8=> variable 7
 167 ;test8.j(58)     println(4500 / (j*k));   // 15
 168 acc16= constant 4500
 169 <acc16= variable 5
 170 acc16* variable 7
 171 /acc16 unstack16
 172 writeLineAcc16
 173 ;test8.j(59)     i = 4800;
 174 acc16= constant 4800
 175 acc16=> variable 3
 176 ;test8.j(60)     println(i / (j*k));      // 16
 177 acc16= variable 3
 178 <acc16= variable 5
 179 acc16* variable 7
 180 /acc16 unstack16
 181 writeLineAcc16
 182 ;test8.j(61)   
 183 ;test8.j(62)     /**************************/
 184 ;test8.j(63)     /* reverse subtract mixed */
 185 ;test8.j(64)     /**************************/
 186 ;test8.j(65)     i = 21;
 187 acc8= constant 21
 188 acc8=> variable 3
 189 ;test8.j(66)     c = 4;
 190 acc8= constant 4
 191 acc8=> variable 1
 192 ;test8.j(67)     d = 1;
 193 acc8= constant 1
 194 acc8=> variable 2
 195 ;test8.j(68)     println(i - c*d);           // 17
 196 acc16= variable 3
 197 acc8= variable 1
 198 acc8* variable 2
 199 acc16- acc8
 200 writeLineAcc16
 201 ;test8.j(69)     b = 22;
 202 acc8= constant 22
 203 acc8=> variable 0
 204 ;test8.j(70)     j = 4;
 205 acc8= constant 4
 206 acc8=> variable 5
 207 ;test8.j(71)     k = 1;
 208 acc8= constant 1
 209 acc8=> variable 7
 210 ;test8.j(72)     println(b - j*k);           // 18
 211 acc8= variable 0
 212 acc16= variable 5
 213 acc16* variable 7
 214 -acc16 acc8
 215 writeLineAcc16
 216 ;test8.j(73)   
 217 ;test8.j(74)     /**************************/
 218 ;test8.j(75)     /* reverse divide mixed   */
 219 ;test8.j(76)     /**************************/
 220 ;test8.j(77)   
 221 ;test8.j(78)     /**************************/
 222 ;test8.j(79)     /* forward divide mixed   */
 223 ;test8.j(80)     /**************************/
 224 ;test8.j(81)     i = 19;
 225 acc8= constant 19
 226 acc8=> variable 3
 227 ;test8.j(82)     println(i / (1+0));         // 19
 228 acc16= variable 3
 229 acc8= constant 1
 230 acc8+ constant 0
 231 acc16/ acc8
 232 writeLineAcc16
 233 ;test8.j(83)     
 234 ;test8.j(84)     println(i + 1);             // 20
 235 acc16= variable 3
 236 acc16+ constant 1
 237 writeLineAcc16
 238 ;test8.j(85)     println(2 + i);             // 21
 239 acc8= constant 2
 240 acc8ToAcc16
 241 acc16+ variable 3
 242 writeLineAcc16
 243 ;test8.j(86)     println(2*5+3*4);           // 22
 244 acc8= constant 2
 245 acc8* constant 5
 246 <acc8= constant 3
 247 acc8* constant 4
 248 acc8+ unstack8
 249 writeLineAcc8
 250 ;test8.j(87)     println(120/4-(3+8/2));     // 23
 251 acc8= constant 120
 252 acc8/ constant 4
 253 <acc8= constant 3
 254 <acc8= constant 8
 255 acc8/ constant 2
 256 acc8+ unstack8
 257 -acc8 unstack8
 258 writeLineAcc8
 259 ;test8.j(88)     println("Klaar");
 260 acc16= stringconstant 267
 261 writeLineString
 262 stackPointer= basePointer
 263 basePointer<
 264 return
 265 ;test8.j(89)   }
 266 ;test8.j(90) }
 267 stringConstant 0 = "Klaar"
