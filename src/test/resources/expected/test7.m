   0 ;test7.j(0) /*
   1 ;test7.j(1)  * A small program in the miniJava language.
   2 ;test7.j(2)  * Test 8-bit and 16-bit expressions.
   3 ;test7.j(3)  */
   4 ;test7.j(4) class TestRead {
   5 class TestRead []
   6 ;test7.j(5)   private static byte b;
   7 ;test7.j(6)   private static word i;
   8 ;test7.j(7) 
   9 ;test7.j(8)   public static void main() {
  10 method main [public, static] void
  11 ;test7.j(9)     println(0);
  12 acc8= constant 0
  13 call writeLineAcc8
  14 ;test7.j(10)   
  15 ;test7.j(11)     /**************************/
  16 ;test7.j(12)     /* Single term read: byte */
  17 ;test7.j(13)     /**************************/
  18 ;test7.j(14)     println(1);          // 1
  19 acc8= constant 1
  20 call writeLineAcc8
  21 ;test7.j(15)   
  22 ;test7.j(16)     println("\nType 2, 3, 4 etc");
  23 acc16= constant 293
  24 writeLineString
  25 ;test7.j(17)     println(read);       // 2
  26 call read
  27 call writeLineAcc16
  28 ;test7.j(18)     b = read;
  29 call read
  30 acc16=> variable 0
  31 ;test7.j(19)     println(b);       // 3
  32 acc8= variable 0
  33 call writeLineAcc8
  34 ;test7.j(20)   
  35 ;test7.j(21)     /**********************************/
  36 ;test7.j(22)     /* Dual term read: byte constants */
  37 ;test7.j(23)     /**********************************/
  38 ;test7.j(24)     println(read + 0);   // 4 + 0 = 4
  39 call read
  40 acc16+ constant 0
  41 call writeLineAcc16
  42 ;test7.j(25)     println(0 + read);   // 0 + 5 = 5
  43 acc8= constant 0
  44 call read
  45 acc16+ acc8
  46 call writeLineAcc16
  47 ;test7.j(26)     println(read - 0);   // 6 - 0 = 6
  48 call read
  49 acc16- constant 0
  50 call writeLineAcc16
  51 ;test7.j(27)     println(14 - read);  // 14 - 7 = 7
  52 acc8= constant 14
  53 call read
  54 -acc16 acc8
  55 call writeLineAcc16
  56 ;test7.j(28)     println(read * 1);   // 8 * 1 = 8
  57 call read
  58 acc16* constant 1
  59 call writeLineAcc16
  60 ;test7.j(29)     println(1 * read);   // 1 * 9 = 9
  61 acc8= constant 1
  62 call read
  63 acc16* acc8
  64 call writeLineAcc16
  65 ;test7.j(30)     println(read / 1);   // 10 / 1 = 10
  66 call read
  67 acc16/ constant 1
  68 call writeLineAcc16
  69 ;test7.j(31)     println(121 / read); // 121 / 11 = 11
  70 acc8= constant 121
  71 call read
  72 /acc16 acc8
  73 call writeLineAcc16
  74 ;test7.j(32)     
  75 ;test7.j(33)     println("\nType 1048 etc");
  76 acc16= constant 294
  77 writeLineString
  78 ;test7.j(34)     /**************************/
  79 ;test7.j(35)     /* Single term read: word */
  80 ;test7.j(36)     /**************************/
  81 ;test7.j(37)     println(read);      // 1048
  82 call read
  83 call writeLineAcc16
  84 ;test7.j(38)     i = read;
  85 call read
  86 acc16=> variable 1
  87 ;test7.j(39)     println(i);         // 1049
  88 acc16= variable 1
  89 call writeLineAcc16
  90 ;test7.j(40)   
  91 ;test7.j(41)     /**********************************/
  92 ;test7.j(42)     /* Dual term read: word constants */
  93 ;test7.j(43)     /**********************************/
  94 ;test7.j(44)     println("\nType 1050 expect 2050");
  95 acc16= constant 295
  96 writeLineString
  97 ;test7.j(45)     println(read + 1000);   // 1050 + 1000 = 2050
  98 call read
  99 acc16+ constant 1000
 100 call writeLineAcc16
 101 ;test7.j(46)     println("\nType 1051 expect 2051");
 102 acc16= constant 296
 103 writeLineString
 104 ;test7.j(47)     println(1000 + read);   // 1000 + 1051 = 2051
 105 acc16= constant 1000
 106 <acc16
 107 call read
 108 acc16+ unstack16
 109 call writeLineAcc16
 110 ;test7.j(48)     println("\nType 1052 expect 52");
 111 acc16= constant 297
 112 writeLineString
 113 ;test7.j(49)     println(read - 1000);   // 1052 - 1000 =   52
 114 call read
 115 acc16- constant 1000
 116 call writeLineAcc16
 117 ;test7.j(50)     println("\nType 1053 expect 1053");
 118 acc16= constant 298
 119 writeLineString
 120 ;test7.j(51)     println(2106 - read);   // 2106 - 1053 = 1053
 121 acc16= constant 2106
 122 <acc16
 123 call read
 124 -acc16 unstack16
 125 call writeLineAcc16
 126 ;test7.j(52)     println("\nType 1054 expect 5254");
 127 acc16= constant 299
 128 writeLineString
 129 ;test7.j(53)     println(read * 1000);   // 1054 * 1000 = 5254
 130 call read
 131 acc16* constant 1000
 132 call writeLineAcc16
 133 ;test7.j(54)     println("\nType 1055 expect 6424");
 134 acc16= constant 300
 135 writeLineString
 136 ;test7.j(55)     println(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
 137 acc16= constant 1000
 138 <acc16
 139 call read
 140 acc16* unstack16
 141 call writeLineAcc16
 142 ;test7.j(56)     println("\nType 1056 expect 1");
 143 acc16= constant 301
 144 writeLineString
 145 ;test7.j(57)     println(read / 1000);   // 1056 / 1000 = 1
 146 call read
 147 acc16/ constant 1000
 148 call writeLineAcc16
 149 ;test7.j(58)     println("\nType 1057 expect 2");
 150 acc16= constant 302
 151 writeLineString
 152 ;test7.j(59)     println(2114 / read);   // 2114 / 1057 = 2
 153 acc16= constant 2114
 154 <acc16
 155 call read
 156 /acc16 unstack16
 157 call writeLineAcc16
 158 ;test7.j(60)     
 159 ;test7.j(61)     /****************************************/
 160 ;test7.j(62)     /* Dual term read: word + byte variable */
 161 ;test7.j(63)     /****************************************/
 162 ;test7.j(64)     println("\nType 1058 etc");
 163 acc16= constant 303
 164 writeLineString
 165 ;test7.j(65)     b = 0;
 166 acc8= constant 0
 167 acc8=> variable 0
 168 ;test7.j(66)     println(read + b);   // 1058 + 0 = 1058
 169 call read
 170 acc16+ variable 0
 171 call writeLineAcc16
 172 ;test7.j(67)     println(b + read);   // 0 + 1059 = 1059
 173 acc8= variable 0
 174 call read
 175 acc16+ acc8
 176 call writeLineAcc16
 177 ;test7.j(68)     println(read - b);   // 1060 - 0 = 1060
 178 call read
 179 acc16- variable 0
 180 call writeLineAcc16
 181 ;test7.j(69)     println("\nType 1061 expect -1061");
 182 acc16= constant 304
 183 writeLineString
 184 ;test7.j(70)     println(b - read);   // 0 - 1061 = -1061
 185 acc8= variable 0
 186 call read
 187 -acc16 acc8
 188 call writeLineAcc16
 189 ;test7.j(71)     b = 1;
 190 acc8= constant 1
 191 acc8=> variable 0
 192 ;test7.j(72)     println("\nType 1062 etc");
 193 acc16= constant 305
 194 writeLineString
 195 ;test7.j(73)     println(read * b);   // 1062 * 1 = 1062
 196 call read
 197 acc16* variable 0
 198 call writeLineAcc16
 199 ;test7.j(74)     println(b * read);   // 1 * 1063 = 1063
 200 acc8= variable 0
 201 call read
 202 acc16* acc8
 203 call writeLineAcc16
 204 ;test7.j(75)     println(read / b);   // 1064 / 1 = 1064
 205 call read
 206 acc16/ variable 0
 207 call writeLineAcc16
 208 ;test7.j(76)     b = 12;
 209 acc8= constant 12
 210 acc8=> variable 0
 211 ;test7.j(77)     println("\nType 3 expect 4");
 212 acc16= constant 306
 213 writeLineString
 214 ;test7.j(78)     println(3);
 215 acc8= constant 3
 216 call writeLineAcc8
 217 ;test7.j(79)     println(b / read);   // 12 / 3 = 4
 218 acc8= variable 0
 219 call read
 220 /acc16 acc8
 221 call writeLineAcc16
 222 ;test7.j(80)     
 223 ;test7.j(81)     /****************************************/
 224 ;test7.j(82)     /* Dual term read: word + word variable */
 225 ;test7.j(83)     /****************************************/
 226 ;test7.j(84)     i = 0;
 227 acc8= constant 0
 228 acc8=> variable 1
 229 ;test7.j(85)     println("\nType 1066 etc");
 230 acc16= constant 307
 231 writeLineString
 232 ;test7.j(86)     println(read + i);   // 1066 + 0 = 1066
 233 call read
 234 acc16+ variable 1
 235 call writeLineAcc16
 236 ;test7.j(87)     println(i + read);   // 0 + 1067 = 1067
 237 acc16= variable 1
 238 <acc16
 239 call read
 240 acc16+ unstack16
 241 call writeLineAcc16
 242 ;test7.j(88)     println(read - i);   // 1068 - 0 = 1068
 243 call read
 244 acc16- variable 1
 245 call writeLineAcc16
 246 ;test7.j(89)     println("\nType 1069 expect -1069");
 247 acc16= constant 308
 248 writeLineString
 249 ;test7.j(90)     println(i - read);   // 0 - 1069 = -1069
 250 acc16= variable 1
 251 <acc16
 252 call read
 253 -acc16 unstack16
 254 call writeLineAcc16
 255 ;test7.j(91)     i = 1;
 256 acc8= constant 1
 257 acc8=> variable 1
 258 ;test7.j(92)     println("\nType 1070 etc");
 259 acc16= constant 309
 260 writeLineString
 261 ;test7.j(93)     println(read * i);   // 1070 * 1 = 1070
 262 call read
 263 acc16* variable 1
 264 call writeLineAcc16
 265 ;test7.j(94)     println(i * read);   // 1 * 1071 = 1071
 266 acc16= variable 1
 267 <acc16
 268 call read
 269 acc16* unstack16
 270 call writeLineAcc16
 271 ;test7.j(95)     println(read / i);   // 1072 / 1 = 1072
 272 call read
 273 acc16/ variable 1
 274 call writeLineAcc16
 275 ;test7.j(96)     i = 3219;
 276 acc16= constant 3219
 277 acc16=> variable 1
 278 ;test7.j(97)     println("\nType 3 expect 1073");
 279 acc16= constant 310
 280 writeLineString
 281 ;test7.j(98)     println(i / read);   // 3219 / 3 = 1073  
 282 acc16= variable 1
 283 <acc16
 284 call read
 285 /acc16 unstack16
 286 call writeLineAcc16
 287 ;test7.j(99)     println("Klaar");
 288 acc16= constant 311
 289 writeLineString
 290 ;test7.j(100)   }
 291 ;test7.j(101) }
 292 stop
 293 stringConstant 0 = "
Type 2, 3, 4 etc"
 294 stringConstant 1 = "
Type 1048 etc"
 295 stringConstant 2 = "
Type 1050 expect 2050"
 296 stringConstant 3 = "
Type 1051 expect 2051"
 297 stringConstant 4 = "
Type 1052 expect 52"
 298 stringConstant 5 = "
Type 1053 expect 1053"
 299 stringConstant 6 = "
Type 1054 expect 5254"
 300 stringConstant 7 = "
Type 1055 expect 6424"
 301 stringConstant 8 = "
Type 1056 expect 1"
 302 stringConstant 9 = "
Type 1057 expect 2"
 303 stringConstant 10 = "
Type 1058 etc"
 304 stringConstant 11 = "
Type 1061 expect -1061"
 305 stringConstant 12 = "
Type 1062 etc"
 306 stringConstant 13 = "
Type 3 expect 4"
 307 stringConstant 14 = "
Type 1066 etc"
 308 stringConstant 15 = "
Type 1069 expect -1069"
 309 stringConstant 16 = "
Type 1070 etc"
 310 stringConstant 17 = "
Type 3 expect 1073"
 311 stringConstant 18 = "Klaar"
