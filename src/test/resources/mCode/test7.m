   0 ;test7.j(0) /*
   1 ;test7.j(1)  * A small program in the miniJava language.
   2 ;test7.j(2)  * Test 8-bit and 16-bit expressions.
   3 ;test7.j(3)  */
   4 ;test7.j(4) class TestRead {
   5 ;test7.j(5)   private static byte b;
   6 ;test7.j(6)   private static word i;
   7 ;test7.j(7) 
   8 ;test7.j(8)   public static void main() {
   9 method main [publicLexeme, staticLexeme] voidLexeme
  10 ;test7.j(9)     println(0);
  11 acc8= constant 0
  12 call writeLineAcc8
  13 ;test7.j(10)   
  14 ;test7.j(11)     /**************************/
  15 ;test7.j(12)     /* Single term read: byte */
  16 ;test7.j(13)     /**************************/
  17 ;test7.j(14)     println(1);          // 1
  18 acc8= constant 1
  19 call writeLineAcc8
  20 ;test7.j(15)   
  21 ;test7.j(16)     println("\nType 2, 3, 4 etc");
  22 acc16= constant 292
  23 writeLineString
  24 ;test7.j(17)     println(read);       // 2
  25 call read
  26 call writeLineAcc16
  27 ;test7.j(18)     b = read;
  28 call read
  29 acc16=> variable 0
  30 ;test7.j(19)     println(b);       // 3
  31 acc8= variable 0
  32 call writeLineAcc8
  33 ;test7.j(20)   
  34 ;test7.j(21)     /**********************************/
  35 ;test7.j(22)     /* Dual term read: byte constants */
  36 ;test7.j(23)     /**********************************/
  37 ;test7.j(24)     println(read + 0);   // 4 + 0 = 4
  38 call read
  39 acc16+ constant 0
  40 call writeLineAcc16
  41 ;test7.j(25)     println(0 + read);   // 0 + 5 = 5
  42 acc8= constant 0
  43 call read
  44 acc16+ acc8
  45 call writeLineAcc16
  46 ;test7.j(26)     println(read - 0);   // 6 - 0 = 6
  47 call read
  48 acc16- constant 0
  49 call writeLineAcc16
  50 ;test7.j(27)     println(14 - read);  // 14 - 7 = 7
  51 acc8= constant 14
  52 call read
  53 -acc16 acc8
  54 call writeLineAcc16
  55 ;test7.j(28)     println(read * 1);   // 8 * 1 = 8
  56 call read
  57 acc16* constant 1
  58 call writeLineAcc16
  59 ;test7.j(29)     println(1 * read);   // 1 * 9 = 9
  60 acc8= constant 1
  61 call read
  62 acc16* acc8
  63 call writeLineAcc16
  64 ;test7.j(30)     println(read / 1);   // 10 / 1 = 10
  65 call read
  66 acc16/ constant 1
  67 call writeLineAcc16
  68 ;test7.j(31)     println(121 / read); // 121 / 11 = 11
  69 acc8= constant 121
  70 call read
  71 /acc16 acc8
  72 call writeLineAcc16
  73 ;test7.j(32)     
  74 ;test7.j(33)     println("\nType 1048 etc");
  75 acc16= constant 293
  76 writeLineString
  77 ;test7.j(34)     /**************************/
  78 ;test7.j(35)     /* Single term read: word */
  79 ;test7.j(36)     /**************************/
  80 ;test7.j(37)     println(read);      // 1048
  81 call read
  82 call writeLineAcc16
  83 ;test7.j(38)     i = read;
  84 call read
  85 acc16=> variable 1
  86 ;test7.j(39)     println(i);         // 1049
  87 acc16= variable 1
  88 call writeLineAcc16
  89 ;test7.j(40)   
  90 ;test7.j(41)     /**********************************/
  91 ;test7.j(42)     /* Dual term read: word constants */
  92 ;test7.j(43)     /**********************************/
  93 ;test7.j(44)     println("\nType 1050 expect 2050");
  94 acc16= constant 294
  95 writeLineString
  96 ;test7.j(45)     println(read + 1000);   // 1050 + 1000 = 2050
  97 call read
  98 acc16+ constant 1000
  99 call writeLineAcc16
 100 ;test7.j(46)     println("\nType 1051 expect 2051");
 101 acc16= constant 295
 102 writeLineString
 103 ;test7.j(47)     println(1000 + read);   // 1000 + 1051 = 2051
 104 acc16= constant 1000
 105 <acc16
 106 call read
 107 acc16+ unstack16
 108 call writeLineAcc16
 109 ;test7.j(48)     println("\nType 1052 expect 52");
 110 acc16= constant 296
 111 writeLineString
 112 ;test7.j(49)     println(read - 1000);   // 1052 - 1000 =   52
 113 call read
 114 acc16- constant 1000
 115 call writeLineAcc16
 116 ;test7.j(50)     println("\nType 1053 expect 1053");
 117 acc16= constant 297
 118 writeLineString
 119 ;test7.j(51)     println(2106 - read);   // 2106 - 1053 = 1053
 120 acc16= constant 2106
 121 <acc16
 122 call read
 123 -acc16 unstack16
 124 call writeLineAcc16
 125 ;test7.j(52)     println("\nType 1054 expect 5254");
 126 acc16= constant 298
 127 writeLineString
 128 ;test7.j(53)     println(read * 1000);   // 1054 * 1000 = 5254
 129 call read
 130 acc16* constant 1000
 131 call writeLineAcc16
 132 ;test7.j(54)     println("\nType 1055 expect 6424");
 133 acc16= constant 299
 134 writeLineString
 135 ;test7.j(55)     println(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
 136 acc16= constant 1000
 137 <acc16
 138 call read
 139 acc16* unstack16
 140 call writeLineAcc16
 141 ;test7.j(56)     println("\nType 1056 expect 1");
 142 acc16= constant 300
 143 writeLineString
 144 ;test7.j(57)     println(read / 1000);   // 1056 / 1000 = 1
 145 call read
 146 acc16/ constant 1000
 147 call writeLineAcc16
 148 ;test7.j(58)     println("\nType 1057 expect 2");
 149 acc16= constant 301
 150 writeLineString
 151 ;test7.j(59)     println(2114 / read);   // 2114 / 1057 = 2
 152 acc16= constant 2114
 153 <acc16
 154 call read
 155 /acc16 unstack16
 156 call writeLineAcc16
 157 ;test7.j(60)     
 158 ;test7.j(61)     /****************************************/
 159 ;test7.j(62)     /* Dual term read: word + byte variable */
 160 ;test7.j(63)     /****************************************/
 161 ;test7.j(64)     println("\nType 1058 etc");
 162 acc16= constant 302
 163 writeLineString
 164 ;test7.j(65)     b = 0;
 165 acc8= constant 0
 166 acc8=> variable 0
 167 ;test7.j(66)     println(read + b);   // 1058 + 0 = 1058
 168 call read
 169 acc16+ variable 0
 170 call writeLineAcc16
 171 ;test7.j(67)     println(b + read);   // 0 + 1059 = 1059
 172 acc8= variable 0
 173 call read
 174 acc16+ acc8
 175 call writeLineAcc16
 176 ;test7.j(68)     println(read - b);   // 1060 - 0 = 1060
 177 call read
 178 acc16- variable 0
 179 call writeLineAcc16
 180 ;test7.j(69)     println("\nType 1061 expect -1061");
 181 acc16= constant 303
 182 writeLineString
 183 ;test7.j(70)     println(b - read);   // 0 - 1061 = -1061
 184 acc8= variable 0
 185 call read
 186 -acc16 acc8
 187 call writeLineAcc16
 188 ;test7.j(71)     b = 1;
 189 acc8= constant 1
 190 acc8=> variable 0
 191 ;test7.j(72)     println("\nType 1062 etc");
 192 acc16= constant 304
 193 writeLineString
 194 ;test7.j(73)     println(read * b);   // 1062 * 1 = 1062
 195 call read
 196 acc16* variable 0
 197 call writeLineAcc16
 198 ;test7.j(74)     println(b * read);   // 1 * 1063 = 1063
 199 acc8= variable 0
 200 call read
 201 acc16* acc8
 202 call writeLineAcc16
 203 ;test7.j(75)     println(read / b);   // 1064 / 1 = 1064
 204 call read
 205 acc16/ variable 0
 206 call writeLineAcc16
 207 ;test7.j(76)     b = 12;
 208 acc8= constant 12
 209 acc8=> variable 0
 210 ;test7.j(77)     println("\nType 3 expect 4");
 211 acc16= constant 305
 212 writeLineString
 213 ;test7.j(78)     println(3);
 214 acc8= constant 3
 215 call writeLineAcc8
 216 ;test7.j(79)     println(b / read);   // 12 / 3 = 4
 217 acc8= variable 0
 218 call read
 219 /acc16 acc8
 220 call writeLineAcc16
 221 ;test7.j(80)     
 222 ;test7.j(81)     /****************************************/
 223 ;test7.j(82)     /* Dual term read: word + word variable */
 224 ;test7.j(83)     /****************************************/
 225 ;test7.j(84)     i = 0;
 226 acc8= constant 0
 227 acc8=> variable 1
 228 ;test7.j(85)     println("\nType 1066 etc");
 229 acc16= constant 306
 230 writeLineString
 231 ;test7.j(86)     println(read + i);   // 1066 + 0 = 1066
 232 call read
 233 acc16+ variable 1
 234 call writeLineAcc16
 235 ;test7.j(87)     println(i + read);   // 0 + 1067 = 1067
 236 acc16= variable 1
 237 <acc16
 238 call read
 239 acc16+ unstack16
 240 call writeLineAcc16
 241 ;test7.j(88)     println(read - i);   // 1068 - 0 = 1068
 242 call read
 243 acc16- variable 1
 244 call writeLineAcc16
 245 ;test7.j(89)     println("\nType 1069 expect -1069");
 246 acc16= constant 307
 247 writeLineString
 248 ;test7.j(90)     println(i - read);   // 0 - 1069 = -1069
 249 acc16= variable 1
 250 <acc16
 251 call read
 252 -acc16 unstack16
 253 call writeLineAcc16
 254 ;test7.j(91)     i = 1;
 255 acc8= constant 1
 256 acc8=> variable 1
 257 ;test7.j(92)     println("\nType 1070 etc");
 258 acc16= constant 308
 259 writeLineString
 260 ;test7.j(93)     println(read * i);   // 1070 * 1 = 1070
 261 call read
 262 acc16* variable 1
 263 call writeLineAcc16
 264 ;test7.j(94)     println(i * read);   // 1 * 1071 = 1071
 265 acc16= variable 1
 266 <acc16
 267 call read
 268 acc16* unstack16
 269 call writeLineAcc16
 270 ;test7.j(95)     println(read / i);   // 1072 / 1 = 1072
 271 call read
 272 acc16/ variable 1
 273 call writeLineAcc16
 274 ;test7.j(96)     i = 3219;
 275 acc16= constant 3219
 276 acc16=> variable 1
 277 ;test7.j(97)     println("\nType 3 expect 1073");
 278 acc16= constant 309
 279 writeLineString
 280 ;test7.j(98)     println(i / read);   // 3219 / 3 = 1073  
 281 acc16= variable 1
 282 <acc16
 283 call read
 284 /acc16 unstack16
 285 call writeLineAcc16
 286 ;test7.j(99)     println("Klaar");
 287 acc16= constant 310
 288 writeLineString
 289 ;test7.j(100)   }
 290 ;test7.j(101) }
 291 stop
 292 stringConstant 0 = "
Type 2, 3, 4 etc"
 293 stringConstant 1 = "
Type 1048 etc"
 294 stringConstant 2 = "
Type 1050 expect 2050"
 295 stringConstant 3 = "
Type 1051 expect 2051"
 296 stringConstant 4 = "
Type 1052 expect 52"
 297 stringConstant 5 = "
Type 1053 expect 1053"
 298 stringConstant 6 = "
Type 1054 expect 5254"
 299 stringConstant 7 = "
Type 1055 expect 6424"
 300 stringConstant 8 = "
Type 1056 expect 1"
 301 stringConstant 9 = "
Type 1057 expect 2"
 302 stringConstant 10 = "
Type 1058 etc"
 303 stringConstant 11 = "
Type 1061 expect -1061"
 304 stringConstant 12 = "
Type 1062 etc"
 305 stringConstant 13 = "
Type 3 expect 4"
 306 stringConstant 14 = "
Type 1066 etc"
 307 stringConstant 15 = "
Type 1069 expect -1069"
 308 stringConstant 16 = "
Type 1070 etc"
 309 stringConstant 17 = "
Type 3 expect 1073"
 310 stringConstant 18 = "Klaar"
