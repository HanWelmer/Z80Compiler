   0 ;test7.j(0) /*
   1 ;test7.j(1)  * A small program in the miniJava language.
   2 ;test7.j(2)  * Test 8-bit and 16-bit expressions.
   3 ;test7.j(3)  */
   4 ;test7.j(4) class TestRead {
   5 ;test7.j(5)   private static byte b;
   6 ;test7.j(6)   private static word i;
   7 ;test7.j(7) 
   8 ;test7.j(8)   public static void main() {
   9 ;test7.j(9)     println(0);
  10 acc8= constant 0
  11 call writeLineAcc8
  12 ;test7.j(10)   
  13 ;test7.j(11)     /**************************/
  14 ;test7.j(12)     /* Single term read: byte */
  15 ;test7.j(13)     /**************************/
  16 ;test7.j(14)     println(1);          // 1
  17 acc8= constant 1
  18 call writeLineAcc8
  19 ;test7.j(15)   
  20 ;test7.j(16)     println("\nType 2, 3, 4 etc");
  21 acc16= constant 291
  22 writeLineString
  23 ;test7.j(17)     println(read);       // 2
  24 call read
  25 call writeLineAcc16
  26 ;test7.j(18)     b = read;
  27 call read
  28 acc16=> variable 0
  29 ;test7.j(19)     println(b);       // 3
  30 acc8= variable 0
  31 call writeLineAcc8
  32 ;test7.j(20)   
  33 ;test7.j(21)     /**********************************/
  34 ;test7.j(22)     /* Dual term read: byte constants */
  35 ;test7.j(23)     /**********************************/
  36 ;test7.j(24)     println(read + 0);   // 4 + 0 = 4
  37 call read
  38 acc16+ constant 0
  39 call writeLineAcc16
  40 ;test7.j(25)     println(0 + read);   // 0 + 5 = 5
  41 acc8= constant 0
  42 call read
  43 acc16+ acc8
  44 call writeLineAcc16
  45 ;test7.j(26)     println(read - 0);   // 6 - 0 = 6
  46 call read
  47 acc16- constant 0
  48 call writeLineAcc16
  49 ;test7.j(27)     println(14 - read);  // 14 - 7 = 7
  50 acc8= constant 14
  51 call read
  52 -acc16 acc8
  53 call writeLineAcc16
  54 ;test7.j(28)     println(read * 1);   // 8 * 1 = 8
  55 call read
  56 acc16* constant 1
  57 call writeLineAcc16
  58 ;test7.j(29)     println(1 * read);   // 1 * 9 = 9
  59 acc8= constant 1
  60 call read
  61 acc16* acc8
  62 call writeLineAcc16
  63 ;test7.j(30)     println(read / 1);   // 10 / 1 = 10
  64 call read
  65 acc16/ constant 1
  66 call writeLineAcc16
  67 ;test7.j(31)     println(121 / read); // 121 / 11 = 11
  68 acc8= constant 121
  69 call read
  70 /acc16 acc8
  71 call writeLineAcc16
  72 ;test7.j(32)     
  73 ;test7.j(33)     println("\nType 1048 etc");
  74 acc16= constant 292
  75 writeLineString
  76 ;test7.j(34)     /**************************/
  77 ;test7.j(35)     /* Single term read: word */
  78 ;test7.j(36)     /**************************/
  79 ;test7.j(37)     println(read);      // 1048
  80 call read
  81 call writeLineAcc16
  82 ;test7.j(38)     i = read;
  83 call read
  84 acc16=> variable 1
  85 ;test7.j(39)     println(i);         // 1049
  86 acc16= variable 1
  87 call writeLineAcc16
  88 ;test7.j(40)   
  89 ;test7.j(41)     /**********************************/
  90 ;test7.j(42)     /* Dual term read: word constants */
  91 ;test7.j(43)     /**********************************/
  92 ;test7.j(44)     println("\nType 1050 expect 2050");
  93 acc16= constant 293
  94 writeLineString
  95 ;test7.j(45)     println(read + 1000);   // 1050 + 1000 = 2050
  96 call read
  97 acc16+ constant 1000
  98 call writeLineAcc16
  99 ;test7.j(46)     println("\nType 1051 expect 2051");
 100 acc16= constant 294
 101 writeLineString
 102 ;test7.j(47)     println(1000 + read);   // 1000 + 1051 = 2051
 103 acc16= constant 1000
 104 <acc16
 105 call read
 106 acc16+ unstack16
 107 call writeLineAcc16
 108 ;test7.j(48)     println("\nType 1052 expect 52");
 109 acc16= constant 295
 110 writeLineString
 111 ;test7.j(49)     println(read - 1000);   // 1052 - 1000 =   52
 112 call read
 113 acc16- constant 1000
 114 call writeLineAcc16
 115 ;test7.j(50)     println("\nType 1053 expect 1053");
 116 acc16= constant 296
 117 writeLineString
 118 ;test7.j(51)     println(2106 - read);   // 2106 - 1053 = 1053
 119 acc16= constant 2106
 120 <acc16
 121 call read
 122 -acc16 unstack16
 123 call writeLineAcc16
 124 ;test7.j(52)     println("\nType 1054 expect 5254");
 125 acc16= constant 297
 126 writeLineString
 127 ;test7.j(53)     println(read * 1000);   // 1054 * 1000 = 5254
 128 call read
 129 acc16* constant 1000
 130 call writeLineAcc16
 131 ;test7.j(54)     println("\nType 1055 expect 6424");
 132 acc16= constant 298
 133 writeLineString
 134 ;test7.j(55)     println(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
 135 acc16= constant 1000
 136 <acc16
 137 call read
 138 acc16* unstack16
 139 call writeLineAcc16
 140 ;test7.j(56)     println("\nType 1056 expect 1");
 141 acc16= constant 299
 142 writeLineString
 143 ;test7.j(57)     println(read / 1000);   // 1056 / 1000 = 1
 144 call read
 145 acc16/ constant 1000
 146 call writeLineAcc16
 147 ;test7.j(58)     println("\nType 1057 expect 2");
 148 acc16= constant 300
 149 writeLineString
 150 ;test7.j(59)     println(2114 / read);   // 2114 / 1057 = 2
 151 acc16= constant 2114
 152 <acc16
 153 call read
 154 /acc16 unstack16
 155 call writeLineAcc16
 156 ;test7.j(60)     
 157 ;test7.j(61)     /****************************************/
 158 ;test7.j(62)     /* Dual term read: word + byte variable */
 159 ;test7.j(63)     /****************************************/
 160 ;test7.j(64)     println("\nType 1058 etc");
 161 acc16= constant 301
 162 writeLineString
 163 ;test7.j(65)     b = 0;
 164 acc8= constant 0
 165 acc8=> variable 0
 166 ;test7.j(66)     println(read + b);   // 1058 + 0 = 1058
 167 call read
 168 acc16+ variable 0
 169 call writeLineAcc16
 170 ;test7.j(67)     println(b + read);   // 0 + 1059 = 1059
 171 acc8= variable 0
 172 call read
 173 acc16+ acc8
 174 call writeLineAcc16
 175 ;test7.j(68)     println(read - b);   // 1060 - 0 = 1060
 176 call read
 177 acc16- variable 0
 178 call writeLineAcc16
 179 ;test7.j(69)     println("\nType 1061 expect -1061");
 180 acc16= constant 302
 181 writeLineString
 182 ;test7.j(70)     println(b - read);   // 0 - 1061 = -1061
 183 acc8= variable 0
 184 call read
 185 -acc16 acc8
 186 call writeLineAcc16
 187 ;test7.j(71)     b = 1;
 188 acc8= constant 1
 189 acc8=> variable 0
 190 ;test7.j(72)     println("\nType 1062 etc");
 191 acc16= constant 303
 192 writeLineString
 193 ;test7.j(73)     println(read * b);   // 1062 * 1 = 1062
 194 call read
 195 acc16* variable 0
 196 call writeLineAcc16
 197 ;test7.j(74)     println(b * read);   // 1 * 1063 = 1063
 198 acc8= variable 0
 199 call read
 200 acc16* acc8
 201 call writeLineAcc16
 202 ;test7.j(75)     println(read / b);   // 1064 / 1 = 1064
 203 call read
 204 acc16/ variable 0
 205 call writeLineAcc16
 206 ;test7.j(76)     b = 12;
 207 acc8= constant 12
 208 acc8=> variable 0
 209 ;test7.j(77)     println("\nType 3 expect 4");
 210 acc16= constant 304
 211 writeLineString
 212 ;test7.j(78)     println(3);
 213 acc8= constant 3
 214 call writeLineAcc8
 215 ;test7.j(79)     println(b / read);   // 12 / 3 = 4
 216 acc8= variable 0
 217 call read
 218 /acc16 acc8
 219 call writeLineAcc16
 220 ;test7.j(80)     
 221 ;test7.j(81)     /****************************************/
 222 ;test7.j(82)     /* Dual term read: word + word variable */
 223 ;test7.j(83)     /****************************************/
 224 ;test7.j(84)     i = 0;
 225 acc8= constant 0
 226 acc8=> variable 1
 227 ;test7.j(85)     println("\nType 1066 etc");
 228 acc16= constant 305
 229 writeLineString
 230 ;test7.j(86)     println(read + i);   // 1066 + 0 = 1066
 231 call read
 232 acc16+ variable 1
 233 call writeLineAcc16
 234 ;test7.j(87)     println(i + read);   // 0 + 1067 = 1067
 235 acc16= variable 1
 236 <acc16
 237 call read
 238 acc16+ unstack16
 239 call writeLineAcc16
 240 ;test7.j(88)     println(read - i);   // 1068 - 0 = 1068
 241 call read
 242 acc16- variable 1
 243 call writeLineAcc16
 244 ;test7.j(89)     println("\nType 1069 expect -1069");
 245 acc16= constant 306
 246 writeLineString
 247 ;test7.j(90)     println(i - read);   // 0 - 1069 = -1069
 248 acc16= variable 1
 249 <acc16
 250 call read
 251 -acc16 unstack16
 252 call writeLineAcc16
 253 ;test7.j(91)     i = 1;
 254 acc8= constant 1
 255 acc8=> variable 1
 256 ;test7.j(92)     println("\nType 1070 etc");
 257 acc16= constant 307
 258 writeLineString
 259 ;test7.j(93)     println(read * i);   // 1070 * 1 = 1070
 260 call read
 261 acc16* variable 1
 262 call writeLineAcc16
 263 ;test7.j(94)     println(i * read);   // 1 * 1071 = 1071
 264 acc16= variable 1
 265 <acc16
 266 call read
 267 acc16* unstack16
 268 call writeLineAcc16
 269 ;test7.j(95)     println(read / i);   // 1072 / 1 = 1072
 270 call read
 271 acc16/ variable 1
 272 call writeLineAcc16
 273 ;test7.j(96)     i = 3219;
 274 acc16= constant 3219
 275 acc16=> variable 1
 276 ;test7.j(97)     println("\nType 3 expect 1073");
 277 acc16= constant 308
 278 writeLineString
 279 ;test7.j(98)     println(i / read);   // 3219 / 3 = 1073  
 280 acc16= variable 1
 281 <acc16
 282 call read
 283 /acc16 unstack16
 284 call writeLineAcc16
 285 ;test7.j(99)     println("Klaar");
 286 acc16= constant 309
 287 writeLineString
 288 ;test7.j(100)   }
 289 ;test7.j(101) }
 290 stop
 291 stringConstant 0 = "
Type 2, 3, 4 etc"
 292 stringConstant 1 = "
Type 1048 etc"
 293 stringConstant 2 = "
Type 1050 expect 2050"
 294 stringConstant 3 = "
Type 1051 expect 2051"
 295 stringConstant 4 = "
Type 1052 expect 52"
 296 stringConstant 5 = "
Type 1053 expect 1053"
 297 stringConstant 6 = "
Type 1054 expect 5254"
 298 stringConstant 7 = "
Type 1055 expect 6424"
 299 stringConstant 8 = "
Type 1056 expect 1"
 300 stringConstant 9 = "
Type 1057 expect 2"
 301 stringConstant 10 = "
Type 1058 etc"
 302 stringConstant 11 = "
Type 1061 expect -1061"
 303 stringConstant 12 = "
Type 1062 etc"
 304 stringConstant 13 = "
Type 3 expect 4"
 305 stringConstant 14 = "
Type 1066 etc"
 306 stringConstant 15 = "
Type 1069 expect -1069"
 307 stringConstant 16 = "
Type 1070 etc"
 308 stringConstant 17 = "
Type 3 expect 1073"
 309 stringConstant 18 = "Klaar"
