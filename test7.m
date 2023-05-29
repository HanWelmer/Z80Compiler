   0 ;test7.j(0) /*
   1 ;test7.j(1)  * A small program in the miniJava language.
   2 ;test7.j(2)  * Test 8-bit and 16-bit expressions.
   3 ;test7.j(3)  */
   4 ;test7.j(4) class Test8And16BitExpressions {
   5 ;test7.j(5)   write(0);
   6 acc8= constant 0
   7 call writeAcc8
   8 ;test7.j(6) 
   9 ;test7.j(7)   /**************************/
  10 ;test7.j(8)   /* Single term read: byte */
  11 ;test7.j(9)   /**************************/
  12 ;test7.j(10)   write(1);          // 1
  13 acc8= constant 1
  14 call writeAcc8
  15 ;test7.j(11) 
  16 ;test7.j(12)   write("\nType 2, 3, 4 etc");
  17 acc16= constant 286
  18 writeString
  19 ;test7.j(13)   write(read);       // 2
  20 call read
  21 call writeAcc16
  22 ;test7.j(14)   byte b = read;
  23 call read
  24 acc16=> variable 0
  25 ;test7.j(15)   write(b);       // 3
  26 acc8= variable 0
  27 call writeAcc8
  28 ;test7.j(16) 
  29 ;test7.j(17)   /**********************************/
  30 ;test7.j(18)   /* Dual term read: byte constants */
  31 ;test7.j(19)   /**********************************/
  32 ;test7.j(20)   write(read + 0);   // 4 + 0 = 4
  33 call read
  34 acc16+ constant 0
  35 call writeAcc16
  36 ;test7.j(21)   write(0 + read);   // 0 + 5 = 5
  37 acc8= constant 0
  38 call read
  39 acc16+ acc8
  40 call writeAcc16
  41 ;test7.j(22)   write(read - 0);   // 6 - 0 = 6
  42 call read
  43 acc16- constant 0
  44 call writeAcc16
  45 ;test7.j(23)   write(14 - read);  // 14 - 7 = 7
  46 acc8= constant 14
  47 call read
  48 -acc16 acc8
  49 call writeAcc16
  50 ;test7.j(24)   write(read * 1);   // 8 * 1 = 8
  51 call read
  52 acc16* constant 1
  53 call writeAcc16
  54 ;test7.j(25)   write(1 * read);   // 1 * 9 = 9
  55 acc8= constant 1
  56 call read
  57 acc16* acc8
  58 call writeAcc16
  59 ;test7.j(26)   write(read / 1);   // 10 / 1 = 10
  60 call read
  61 acc16/ constant 1
  62 call writeAcc16
  63 ;test7.j(27)   write(121 / read); // 121 / 11 = 11
  64 acc8= constant 121
  65 call read
  66 /acc16 acc8
  67 call writeAcc16
  68 ;test7.j(28)   
  69 ;test7.j(29)   write("\nType 1048 etc");
  70 acc16= constant 287
  71 writeString
  72 ;test7.j(30)   /**************************/
  73 ;test7.j(31)   /* Single term read: word */
  74 ;test7.j(32)   /**************************/
  75 ;test7.j(33)   write(read);      // 1048
  76 call read
  77 call writeAcc16
  78 ;test7.j(34)   word i = read;
  79 call read
  80 acc16=> variable 1
  81 ;test7.j(35)   write(i);         // 1049
  82 acc16= variable 1
  83 call writeAcc16
  84 ;test7.j(36) 
  85 ;test7.j(37)   /**********************************/
  86 ;test7.j(38)   /* Dual term read: word constants */
  87 ;test7.j(39)   /**********************************/
  88 ;test7.j(40)   write("\nType 1050 expect 2050");
  89 acc16= constant 288
  90 writeString
  91 ;test7.j(41)   write(read + 1000);   // 1050 + 1000 = 2050
  92 call read
  93 acc16+ constant 1000
  94 call writeAcc16
  95 ;test7.j(42)   write("\nType 1051 expect 2051");
  96 acc16= constant 289
  97 writeString
  98 ;test7.j(43)   write(1000 + read);   // 1000 + 1051 = 2051
  99 acc16= constant 1000
 100 <acc16
 101 call read
 102 acc16+ unstack16
 103 call writeAcc16
 104 ;test7.j(44)   write("\nType 1052 expect 52");
 105 acc16= constant 290
 106 writeString
 107 ;test7.j(45)   write(read - 1000);   // 1052 - 1000 =   52
 108 call read
 109 acc16- constant 1000
 110 call writeAcc16
 111 ;test7.j(46)   write("\nType 1053 expect 1053");
 112 acc16= constant 291
 113 writeString
 114 ;test7.j(47)   write(2106 - read);   // 2106 - 1053 = 1053
 115 acc16= constant 2106
 116 <acc16
 117 call read
 118 -acc16 unstack16
 119 call writeAcc16
 120 ;test7.j(48)   write("\nType 1054 expect 5254");
 121 acc16= constant 292
 122 writeString
 123 ;test7.j(49)   write(read * 1000);   // 1054 * 1000 = 5254
 124 call read
 125 acc16* constant 1000
 126 call writeAcc16
 127 ;test7.j(50)   write("\nType 1055 expect 6424");
 128 acc16= constant 293
 129 writeString
 130 ;test7.j(51)   write(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
 131 acc16= constant 1000
 132 <acc16
 133 call read
 134 acc16* unstack16
 135 call writeAcc16
 136 ;test7.j(52)   write("\nType 1056 expect 1");
 137 acc16= constant 294
 138 writeString
 139 ;test7.j(53)   write(read / 1000);   // 1056 / 1000 = 1
 140 call read
 141 acc16/ constant 1000
 142 call writeAcc16
 143 ;test7.j(54)   write("\nType 1057 expect 2");
 144 acc16= constant 295
 145 writeString
 146 ;test7.j(55)   write(2114 / read);   // 2114 / 1057 = 2
 147 acc16= constant 2114
 148 <acc16
 149 call read
 150 /acc16 unstack16
 151 call writeAcc16
 152 ;test7.j(56)   
 153 ;test7.j(57)   /****************************************/
 154 ;test7.j(58)   /* Dual term read: word + byte variable */
 155 ;test7.j(59)   /****************************************/
 156 ;test7.j(60)   write("\nType 1058 etc");
 157 acc16= constant 296
 158 writeString
 159 ;test7.j(61)   b = 0;
 160 acc8= constant 0
 161 acc8=> variable 0
 162 ;test7.j(62)   write(read + b);   // 1058 + 0 = 1058
 163 call read
 164 acc16+ variable 0
 165 call writeAcc16
 166 ;test7.j(63)   write(b + read);   // 0 + 1059 = 1059
 167 acc8= variable 0
 168 call read
 169 acc16+ acc8
 170 call writeAcc16
 171 ;test7.j(64)   write(read - b);   // 1060 - 0 = 1060
 172 call read
 173 acc16- variable 0
 174 call writeAcc16
 175 ;test7.j(65)   write("\nType 1061 expect -1061");
 176 acc16= constant 297
 177 writeString
 178 ;test7.j(66)   write(b - read);   // 0 - 1061 = -1061
 179 acc8= variable 0
 180 call read
 181 -acc16 acc8
 182 call writeAcc16
 183 ;test7.j(67)   b = 1;
 184 acc8= constant 1
 185 acc8=> variable 0
 186 ;test7.j(68)   write("\nType 1062 etc");
 187 acc16= constant 298
 188 writeString
 189 ;test7.j(69)   write(read * b);   // 1062 * 1 = 1062
 190 call read
 191 acc16* variable 0
 192 call writeAcc16
 193 ;test7.j(70)   write(b * read);   // 1 * 1063 = 1063
 194 acc8= variable 0
 195 call read
 196 acc16* acc8
 197 call writeAcc16
 198 ;test7.j(71)   write(read / b);   // 1064 / 1 = 1064
 199 call read
 200 acc16/ variable 0
 201 call writeAcc16
 202 ;test7.j(72)   b = 12;
 203 acc8= constant 12
 204 acc8=> variable 0
 205 ;test7.j(73)   write("\nType 3 expect 4");
 206 acc16= constant 299
 207 writeString
 208 ;test7.j(74)   write(3);
 209 acc8= constant 3
 210 call writeAcc8
 211 ;test7.j(75)   write(b / read);   // 12 / 3 = 4
 212 acc8= variable 0
 213 call read
 214 /acc16 acc8
 215 call writeAcc16
 216 ;test7.j(76)   
 217 ;test7.j(77)   /****************************************/
 218 ;test7.j(78)   /* Dual term read: word + word variable */
 219 ;test7.j(79)   /****************************************/
 220 ;test7.j(80)   i = 0;
 221 acc8= constant 0
 222 acc8=> variable 1
 223 ;test7.j(81)   write("\nType 1066 etc");
 224 acc16= constant 300
 225 writeString
 226 ;test7.j(82)   write(read + i);   // 1066 + 0 = 1066
 227 call read
 228 acc16+ variable 1
 229 call writeAcc16
 230 ;test7.j(83)   write(i + read);   // 0 + 1067 = 1067
 231 acc16= variable 1
 232 <acc16
 233 call read
 234 acc16+ unstack16
 235 call writeAcc16
 236 ;test7.j(84)   write(read - i);   // 1068 - 0 = 1068
 237 call read
 238 acc16- variable 1
 239 call writeAcc16
 240 ;test7.j(85)   write("\nType 1069 expect -1069");
 241 acc16= constant 301
 242 writeString
 243 ;test7.j(86)   write(i - read);   // 0 - 1069 = -1069
 244 acc16= variable 1
 245 <acc16
 246 call read
 247 -acc16 unstack16
 248 call writeAcc16
 249 ;test7.j(87)   i = 1;
 250 acc8= constant 1
 251 acc8=> variable 1
 252 ;test7.j(88)   write("\nType 1070 etc");
 253 acc16= constant 302
 254 writeString
 255 ;test7.j(89)   write(read * i);   // 1070 * 1 = 1070
 256 call read
 257 acc16* variable 1
 258 call writeAcc16
 259 ;test7.j(90)   write(i * read);   // 1 * 1071 = 1071
 260 acc16= variable 1
 261 <acc16
 262 call read
 263 acc16* unstack16
 264 call writeAcc16
 265 ;test7.j(91)   write(read / i);   // 1072 / 1 = 1072
 266 call read
 267 acc16/ variable 1
 268 call writeAcc16
 269 ;test7.j(92)   i = 3219;
 270 acc16= constant 3219
 271 acc16=> variable 1
 272 ;test7.j(93)   write("\nType 3 expect 1073");
 273 acc16= constant 303
 274 writeString
 275 ;test7.j(94)   write(i / read);   // 3219 / 3 = 1073  
 276 acc16= variable 1
 277 <acc16
 278 call read
 279 /acc16 unstack16
 280 call writeAcc16
 281 ;test7.j(95)   write("Klaar");
 282 acc16= constant 304
 283 writeString
 284 ;test7.j(96) }
 285 stop
 286 stringConstant 0 = "
Type 2, 3, 4 etc"
 287 stringConstant 1 = "
Type 1048 etc"
 288 stringConstant 2 = "
Type 1050 expect 2050"
 289 stringConstant 3 = "
Type 1051 expect 2051"
 290 stringConstant 4 = "
Type 1052 expect 52"
 291 stringConstant 5 = "
Type 1053 expect 1053"
 292 stringConstant 6 = "
Type 1054 expect 5254"
 293 stringConstant 7 = "
Type 1055 expect 6424"
 294 stringConstant 8 = "
Type 1056 expect 1"
 295 stringConstant 9 = "
Type 1057 expect 2"
 296 stringConstant 10 = "
Type 1058 etc"
 297 stringConstant 11 = "
Type 1061 expect -1061"
 298 stringConstant 12 = "
Type 1062 etc"
 299 stringConstant 13 = "
Type 3 expect 4"
 300 stringConstant 14 = "
Type 1066 etc"
 301 stringConstant 15 = "
Type 1069 expect -1069"
 302 stringConstant 16 = "
Type 1070 etc"
 303 stringConstant 17 = "
Type 3 expect 1073"
 304 stringConstant 18 = "Klaar"
