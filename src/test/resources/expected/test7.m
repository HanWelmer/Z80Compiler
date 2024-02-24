   0 call 12
   1 stop
   2 ;test7.j(0) /*
   3 ;test7.j(1)  * A small program in the miniJava language.
   4 ;test7.j(2)  * Test 8-bit and 16-bit expressions.
   5 ;test7.j(3)  */
   6 ;test7.j(4) class TestRead {
   7 class TestRead []
   8 ;test7.j(5)   private static byte b;
   9 ;test7.j(6)   private static word i;
  10 ;test7.j(7) 
  11 ;test7.j(8)   public static void main() {
  12 method main [public, static] void
  13 ;test7.j(9)     println(0);
  14 acc8= constant 0
  15 call writeLineAcc8
  16 ;test7.j(10)   
  17 ;test7.j(11)     /**************************/
  18 ;test7.j(12)     /* Single term read: byte */
  19 ;test7.j(13)     /**************************/
  20 ;test7.j(14)     println(1);          // 1
  21 acc8= constant 1
  22 call writeLineAcc8
  23 ;test7.j(15)   
  24 ;test7.j(16)     println("\nType 2, 3, 4 etc");
  25 acc16= constant 295
  26 writeLineString
  27 ;test7.j(17)     println(read);       // 2
  28 call read
  29 call writeLineAcc16
  30 ;test7.j(18)     b = read;
  31 call read
  32 acc16=> variable 0
  33 ;test7.j(19)     println(b);       // 3
  34 acc8= variable 0
  35 call writeLineAcc8
  36 ;test7.j(20)   
  37 ;test7.j(21)     /**********************************/
  38 ;test7.j(22)     /* Dual term read: byte constants */
  39 ;test7.j(23)     /**********************************/
  40 ;test7.j(24)     println(read + 0);   // 4 + 0 = 4
  41 call read
  42 acc16+ constant 0
  43 call writeLineAcc16
  44 ;test7.j(25)     println(0 + read);   // 0 + 5 = 5
  45 acc8= constant 0
  46 call read
  47 acc16+ acc8
  48 call writeLineAcc16
  49 ;test7.j(26)     println(read - 0);   // 6 - 0 = 6
  50 call read
  51 acc16- constant 0
  52 call writeLineAcc16
  53 ;test7.j(27)     println(14 - read);  // 14 - 7 = 7
  54 acc8= constant 14
  55 call read
  56 -acc16 acc8
  57 call writeLineAcc16
  58 ;test7.j(28)     println(read * 1);   // 8 * 1 = 8
  59 call read
  60 acc16* constant 1
  61 call writeLineAcc16
  62 ;test7.j(29)     println(1 * read);   // 1 * 9 = 9
  63 acc8= constant 1
  64 call read
  65 acc16* acc8
  66 call writeLineAcc16
  67 ;test7.j(30)     println(read / 1);   // 10 / 1 = 10
  68 call read
  69 acc16/ constant 1
  70 call writeLineAcc16
  71 ;test7.j(31)     println(121 / read); // 121 / 11 = 11
  72 acc8= constant 121
  73 call read
  74 /acc16 acc8
  75 call writeLineAcc16
  76 ;test7.j(32)     
  77 ;test7.j(33)     println("\nType 1048 etc");
  78 acc16= constant 296
  79 writeLineString
  80 ;test7.j(34)     /**************************/
  81 ;test7.j(35)     /* Single term read: word */
  82 ;test7.j(36)     /**************************/
  83 ;test7.j(37)     println(read);      // 1048
  84 call read
  85 call writeLineAcc16
  86 ;test7.j(38)     i = read;
  87 call read
  88 acc16=> variable 1
  89 ;test7.j(39)     println(i);         // 1049
  90 acc16= variable 1
  91 call writeLineAcc16
  92 ;test7.j(40)   
  93 ;test7.j(41)     /**********************************/
  94 ;test7.j(42)     /* Dual term read: word constants */
  95 ;test7.j(43)     /**********************************/
  96 ;test7.j(44)     println("\nType 1050 expect 2050");
  97 acc16= constant 297
  98 writeLineString
  99 ;test7.j(45)     println(read + 1000);   // 1050 + 1000 = 2050
 100 call read
 101 acc16+ constant 1000
 102 call writeLineAcc16
 103 ;test7.j(46)     println("\nType 1051 expect 2051");
 104 acc16= constant 298
 105 writeLineString
 106 ;test7.j(47)     println(1000 + read);   // 1000 + 1051 = 2051
 107 acc16= constant 1000
 108 <acc16
 109 call read
 110 acc16+ unstack16
 111 call writeLineAcc16
 112 ;test7.j(48)     println("\nType 1052 expect 52");
 113 acc16= constant 299
 114 writeLineString
 115 ;test7.j(49)     println(read - 1000);   // 1052 - 1000 =   52
 116 call read
 117 acc16- constant 1000
 118 call writeLineAcc16
 119 ;test7.j(50)     println("\nType 1053 expect 1053");
 120 acc16= constant 300
 121 writeLineString
 122 ;test7.j(51)     println(2106 - read);   // 2106 - 1053 = 1053
 123 acc16= constant 2106
 124 <acc16
 125 call read
 126 -acc16 unstack16
 127 call writeLineAcc16
 128 ;test7.j(52)     println("\nType 1054 expect 5254");
 129 acc16= constant 301
 130 writeLineString
 131 ;test7.j(53)     println(read * 1000);   // 1054 * 1000 = 5254
 132 call read
 133 acc16* constant 1000
 134 call writeLineAcc16
 135 ;test7.j(54)     println("\nType 1055 expect 6424");
 136 acc16= constant 302
 137 writeLineString
 138 ;test7.j(55)     println(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
 139 acc16= constant 1000
 140 <acc16
 141 call read
 142 acc16* unstack16
 143 call writeLineAcc16
 144 ;test7.j(56)     println("\nType 1056 expect 1");
 145 acc16= constant 303
 146 writeLineString
 147 ;test7.j(57)     println(read / 1000);   // 1056 / 1000 = 1
 148 call read
 149 acc16/ constant 1000
 150 call writeLineAcc16
 151 ;test7.j(58)     println("\nType 1057 expect 2");
 152 acc16= constant 304
 153 writeLineString
 154 ;test7.j(59)     println(2114 / read);   // 2114 / 1057 = 2
 155 acc16= constant 2114
 156 <acc16
 157 call read
 158 /acc16 unstack16
 159 call writeLineAcc16
 160 ;test7.j(60)     
 161 ;test7.j(61)     /****************************************/
 162 ;test7.j(62)     /* Dual term read: word + byte variable */
 163 ;test7.j(63)     /****************************************/
 164 ;test7.j(64)     println("\nType 1058 etc");
 165 acc16= constant 305
 166 writeLineString
 167 ;test7.j(65)     b = 0;
 168 acc8= constant 0
 169 acc8=> variable 0
 170 ;test7.j(66)     println(read + b);   // 1058 + 0 = 1058
 171 call read
 172 acc16+ variable 0
 173 call writeLineAcc16
 174 ;test7.j(67)     println(b + read);   // 0 + 1059 = 1059
 175 acc8= variable 0
 176 call read
 177 acc16+ acc8
 178 call writeLineAcc16
 179 ;test7.j(68)     println(read - b);   // 1060 - 0 = 1060
 180 call read
 181 acc16- variable 0
 182 call writeLineAcc16
 183 ;test7.j(69)     println("\nType 1061 expect -1061");
 184 acc16= constant 306
 185 writeLineString
 186 ;test7.j(70)     println(b - read);   // 0 - 1061 = -1061
 187 acc8= variable 0
 188 call read
 189 -acc16 acc8
 190 call writeLineAcc16
 191 ;test7.j(71)     b = 1;
 192 acc8= constant 1
 193 acc8=> variable 0
 194 ;test7.j(72)     println("\nType 1062 etc");
 195 acc16= constant 307
 196 writeLineString
 197 ;test7.j(73)     println(read * b);   // 1062 * 1 = 1062
 198 call read
 199 acc16* variable 0
 200 call writeLineAcc16
 201 ;test7.j(74)     println(b * read);   // 1 * 1063 = 1063
 202 acc8= variable 0
 203 call read
 204 acc16* acc8
 205 call writeLineAcc16
 206 ;test7.j(75)     println(read / b);   // 1064 / 1 = 1064
 207 call read
 208 acc16/ variable 0
 209 call writeLineAcc16
 210 ;test7.j(76)     b = 12;
 211 acc8= constant 12
 212 acc8=> variable 0
 213 ;test7.j(77)     println("\nType 3 expect 4");
 214 acc16= constant 308
 215 writeLineString
 216 ;test7.j(78)     println(3);
 217 acc8= constant 3
 218 call writeLineAcc8
 219 ;test7.j(79)     println(b / read);   // 12 / 3 = 4
 220 acc8= variable 0
 221 call read
 222 /acc16 acc8
 223 call writeLineAcc16
 224 ;test7.j(80)     
 225 ;test7.j(81)     /****************************************/
 226 ;test7.j(82)     /* Dual term read: word + word variable */
 227 ;test7.j(83)     /****************************************/
 228 ;test7.j(84)     i = 0;
 229 acc8= constant 0
 230 acc8=> variable 1
 231 ;test7.j(85)     println("\nType 1066 etc");
 232 acc16= constant 309
 233 writeLineString
 234 ;test7.j(86)     println(read + i);   // 1066 + 0 = 1066
 235 call read
 236 acc16+ variable 1
 237 call writeLineAcc16
 238 ;test7.j(87)     println(i + read);   // 0 + 1067 = 1067
 239 acc16= variable 1
 240 <acc16
 241 call read
 242 acc16+ unstack16
 243 call writeLineAcc16
 244 ;test7.j(88)     println(read - i);   // 1068 - 0 = 1068
 245 call read
 246 acc16- variable 1
 247 call writeLineAcc16
 248 ;test7.j(89)     println("\nType 1069 expect -1069");
 249 acc16= constant 310
 250 writeLineString
 251 ;test7.j(90)     println(i - read);   // 0 - 1069 = -1069
 252 acc16= variable 1
 253 <acc16
 254 call read
 255 -acc16 unstack16
 256 call writeLineAcc16
 257 ;test7.j(91)     i = 1;
 258 acc8= constant 1
 259 acc8=> variable 1
 260 ;test7.j(92)     println("\nType 1070 etc");
 261 acc16= constant 311
 262 writeLineString
 263 ;test7.j(93)     println(read * i);   // 1070 * 1 = 1070
 264 call read
 265 acc16* variable 1
 266 call writeLineAcc16
 267 ;test7.j(94)     println(i * read);   // 1 * 1071 = 1071
 268 acc16= variable 1
 269 <acc16
 270 call read
 271 acc16* unstack16
 272 call writeLineAcc16
 273 ;test7.j(95)     println(read / i);   // 1072 / 1 = 1072
 274 call read
 275 acc16/ variable 1
 276 call writeLineAcc16
 277 ;test7.j(96)     i = 3219;
 278 acc16= constant 3219
 279 acc16=> variable 1
 280 ;test7.j(97)     println("\nType 3 expect 1073");
 281 acc16= constant 312
 282 writeLineString
 283 ;test7.j(98)     println(i / read);   // 3219 / 3 = 1073  
 284 acc16= variable 1
 285 <acc16
 286 call read
 287 /acc16 unstack16
 288 call writeLineAcc16
 289 ;test7.j(99)     println("Klaar");
 290 acc16= constant 313
 291 writeLineString
 292 return
 293 ;test7.j(100)   }
 294 ;test7.j(101) }
 295 stringConstant 0 = "
Type 2, 3, 4 etc"
 296 stringConstant 1 = "
Type 1048 etc"
 297 stringConstant 2 = "
Type 1050 expect 2050"
 298 stringConstant 3 = "
Type 1051 expect 2051"
 299 stringConstant 4 = "
Type 1052 expect 52"
 300 stringConstant 5 = "
Type 1053 expect 1053"
 301 stringConstant 6 = "
Type 1054 expect 5254"
 302 stringConstant 7 = "
Type 1055 expect 6424"
 303 stringConstant 8 = "
Type 1056 expect 1"
 304 stringConstant 9 = "
Type 1057 expect 2"
 305 stringConstant 10 = "
Type 1058 etc"
 306 stringConstant 11 = "
Type 1061 expect -1061"
 307 stringConstant 12 = "
Type 1062 etc"
 308 stringConstant 13 = "
Type 3 expect 4"
 309 stringConstant 14 = "
Type 1066 etc"
 310 stringConstant 15 = "
Type 1069 expect -1069"
 311 stringConstant 16 = "
Type 1070 etc"
 312 stringConstant 17 = "
Type 3 expect 1073"
 313 stringConstant 18 = "Klaar"
