   0 call 12
   1 stop
   2 ;testRead.j(0) /*
   3 ;testRead.j(1)  * A small program in the miniJava language.
   4 ;testRead.j(2)  * Test 8-bit and 16-bit expressions.
   5 ;testRead.j(3)  */
   6 ;testRead.j(4) class TestRead {
   7 class TestRead []
   8 ;testRead.j(5)   private static byte b;
   9 ;testRead.j(6)   private static word i;
  10 ;testRead.j(7) 
  11 ;testRead.j(8)   public static void main() {
  12 method main [public, static] void ()
  13 <basePointer
  14 basePointer= stackPointer
  15 stackPointer+ constant 0
  16 ;testRead.j(9)     println(0);
  17 acc8= constant 0
  18 writeLineAcc8
  19 ;testRead.j(10)   
  20 ;testRead.j(11)     /**************************/
  21 ;testRead.j(12)     /* Single term read: byte */
  22 ;testRead.j(13)     /**************************/
  23 ;testRead.j(14)     println(1);          // 1
  24 acc8= constant 1
  25 writeLineAcc8
  26 ;testRead.j(15)   
  27 ;testRead.j(16)     println("\nType 2, 3, 4 etc");
  28 acc16= stringconstant 300
  29 writeLineString
  30 ;testRead.j(17)     println(read);       // 2
  31 read
  32 writeLineAcc16
  33 ;testRead.j(18)     b = read;
  34 read
  35 acc16=> variable 0
  36 ;testRead.j(19)     println(b);       // 3
  37 acc8= variable 0
  38 writeLineAcc8
  39 ;testRead.j(20)   
  40 ;testRead.j(21)     /**********************************/
  41 ;testRead.j(22)     /* Dual term read: byte constants */
  42 ;testRead.j(23)     /**********************************/
  43 ;testRead.j(24)     println(read + 0);   // 4 + 0 = 4
  44 read
  45 acc16+ constant 0
  46 writeLineAcc16
  47 ;testRead.j(25)     println(0 + read);   // 0 + 5 = 5
  48 acc8= constant 0
  49 read
  50 acc16+ acc8
  51 writeLineAcc16
  52 ;testRead.j(26)     println(read - 0);   // 6 - 0 = 6
  53 read
  54 acc16- constant 0
  55 writeLineAcc16
  56 ;testRead.j(27)     println(14 - read);  // 14 - 7 = 7
  57 acc8= constant 14
  58 read
  59 -acc16 acc8
  60 writeLineAcc16
  61 ;testRead.j(28)     println(read * 1);   // 8 * 1 = 8
  62 read
  63 acc16* constant 1
  64 writeLineAcc16
  65 ;testRead.j(29)     println(1 * read);   // 1 * 9 = 9
  66 acc8= constant 1
  67 read
  68 acc16* acc8
  69 writeLineAcc16
  70 ;testRead.j(30)     println(read / 1);   // 10 / 1 = 10
  71 read
  72 acc16/ constant 1
  73 writeLineAcc16
  74 ;testRead.j(31)     println(121 / read); // 121 / 11 = 11
  75 acc8= constant 121
  76 read
  77 /acc16 acc8
  78 writeLineAcc16
  79 ;testRead.j(32)     
  80 ;testRead.j(33)     println("\nType 1048 etc");
  81 acc16= stringconstant 301
  82 writeLineString
  83 ;testRead.j(34)     /**************************/
  84 ;testRead.j(35)     /* Single term read: word */
  85 ;testRead.j(36)     /**************************/
  86 ;testRead.j(37)     println(read);      // 1048
  87 read
  88 writeLineAcc16
  89 ;testRead.j(38)     i = read;
  90 read
  91 acc16=> variable 1
  92 ;testRead.j(39)     println(i);         // 1049
  93 acc16= variable 1
  94 writeLineAcc16
  95 ;testRead.j(40)   
  96 ;testRead.j(41)     /**********************************/
  97 ;testRead.j(42)     /* Dual term read: word constants */
  98 ;testRead.j(43)     /**********************************/
  99 ;testRead.j(44)     println("\nType 1050 expect 2050");
 100 acc16= stringconstant 302
 101 writeLineString
 102 ;testRead.j(45)     println(read + 1000);   // 1050 + 1000 = 2050
 103 read
 104 acc16+ constant 1000
 105 writeLineAcc16
 106 ;testRead.j(46)     println("\nType 1051 expect 2051");
 107 acc16= stringconstant 303
 108 writeLineString
 109 ;testRead.j(47)     println(1000 + read);   // 1000 + 1051 = 2051
 110 acc16= constant 1000
 111 <acc16
 112 read
 113 acc16+ unstack16
 114 writeLineAcc16
 115 ;testRead.j(48)     println("\nType 1052 expect 52");
 116 acc16= stringconstant 304
 117 writeLineString
 118 ;testRead.j(49)     println(read - 1000);   // 1052 - 1000 =   52
 119 read
 120 acc16- constant 1000
 121 writeLineAcc16
 122 ;testRead.j(50)     println("\nType 1053 expect 1053");
 123 acc16= stringconstant 305
 124 writeLineString
 125 ;testRead.j(51)     println(2106 - read);   // 2106 - 1053 = 1053
 126 acc16= constant 2106
 127 <acc16
 128 read
 129 -acc16 unstack16
 130 writeLineAcc16
 131 ;testRead.j(52)     println("\nType 1054 expect 5254");
 132 acc16= stringconstant 306
 133 writeLineString
 134 ;testRead.j(53)     println(read * 1000);   // 1054 * 1000 = 5254
 135 read
 136 acc16* constant 1000
 137 writeLineAcc16
 138 ;testRead.j(54)     println("\nType 1055 expect 6424");
 139 acc16= stringconstant 307
 140 writeLineString
 141 ;testRead.j(55)     println(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
 142 acc16= constant 1000
 143 <acc16
 144 read
 145 acc16* unstack16
 146 writeLineAcc16
 147 ;testRead.j(56)     println("\nType 1056 expect 1");
 148 acc16= stringconstant 308
 149 writeLineString
 150 ;testRead.j(57)     println(read / 1000);   // 1056 / 1000 = 1
 151 read
 152 acc16/ constant 1000
 153 writeLineAcc16
 154 ;testRead.j(58)     println("\nType 1057 expect 2");
 155 acc16= stringconstant 309
 156 writeLineString
 157 ;testRead.j(59)     println(2114 / read);   // 2114 / 1057 = 2
 158 acc16= constant 2114
 159 <acc16
 160 read
 161 /acc16 unstack16
 162 writeLineAcc16
 163 ;testRead.j(60)     
 164 ;testRead.j(61)     /****************************************/
 165 ;testRead.j(62)     /* Dual term read: word + byte variable */
 166 ;testRead.j(63)     /****************************************/
 167 ;testRead.j(64)     println("\nType 1058 etc");
 168 acc16= stringconstant 310
 169 writeLineString
 170 ;testRead.j(65)     b = 0;
 171 acc8= constant 0
 172 acc8=> variable 0
 173 ;testRead.j(66)     println(read + b);   // 1058 + 0 = 1058
 174 read
 175 acc16+ variable 0
 176 writeLineAcc16
 177 ;testRead.j(67)     println(b + read);   // 0 + 1059 = 1059
 178 acc8= variable 0
 179 read
 180 acc16+ acc8
 181 writeLineAcc16
 182 ;testRead.j(68)     println(read - b);   // 1060 - 0 = 1060
 183 read
 184 acc16- variable 0
 185 writeLineAcc16
 186 ;testRead.j(69)     println("\nType 1061 expect -1061");
 187 acc16= stringconstant 311
 188 writeLineString
 189 ;testRead.j(70)     println(b - read);   // 0 - 1061 = -1061
 190 acc8= variable 0
 191 read
 192 -acc16 acc8
 193 writeLineAcc16
 194 ;testRead.j(71)     b = 1;
 195 acc8= constant 1
 196 acc8=> variable 0
 197 ;testRead.j(72)     println("\nType 1062 etc");
 198 acc16= stringconstant 312
 199 writeLineString
 200 ;testRead.j(73)     println(read * b);   // 1062 * 1 = 1062
 201 read
 202 acc16* variable 0
 203 writeLineAcc16
 204 ;testRead.j(74)     println(b * read);   // 1 * 1063 = 1063
 205 acc8= variable 0
 206 read
 207 acc16* acc8
 208 writeLineAcc16
 209 ;testRead.j(75)     println(read / b);   // 1064 / 1 = 1064
 210 read
 211 acc16/ variable 0
 212 writeLineAcc16
 213 ;testRead.j(76)     b = 12;
 214 acc8= constant 12
 215 acc8=> variable 0
 216 ;testRead.j(77)     println("\nType 3 expect 4");
 217 acc16= stringconstant 313
 218 writeLineString
 219 ;testRead.j(78)     println(3);
 220 acc8= constant 3
 221 writeLineAcc8
 222 ;testRead.j(79)     println(b / read);   // 12 / 3 = 4
 223 acc8= variable 0
 224 read
 225 /acc16 acc8
 226 writeLineAcc16
 227 ;testRead.j(80)     
 228 ;testRead.j(81)     /****************************************/
 229 ;testRead.j(82)     /* Dual term read: word + word variable */
 230 ;testRead.j(83)     /****************************************/
 231 ;testRead.j(84)     i = 0;
 232 acc8= constant 0
 233 acc8=> variable 1
 234 ;testRead.j(85)     println("\nType 1066 etc");
 235 acc16= stringconstant 314
 236 writeLineString
 237 ;testRead.j(86)     println(read + i);   // 1066 + 0 = 1066
 238 read
 239 acc16+ variable 1
 240 writeLineAcc16
 241 ;testRead.j(87)     println(i + read);   // 0 + 1067 = 1067
 242 acc16= variable 1
 243 <acc16
 244 read
 245 acc16+ unstack16
 246 writeLineAcc16
 247 ;testRead.j(88)     println(read - i);   // 1068 - 0 = 1068
 248 read
 249 acc16- variable 1
 250 writeLineAcc16
 251 ;testRead.j(89)     println("\nType 1069 expect -1069");
 252 acc16= stringconstant 315
 253 writeLineString
 254 ;testRead.j(90)     println(i - read);   // 0 - 1069 = -1069
 255 acc16= variable 1
 256 <acc16
 257 read
 258 -acc16 unstack16
 259 writeLineAcc16
 260 ;testRead.j(91)     i = 1;
 261 acc8= constant 1
 262 acc8=> variable 1
 263 ;testRead.j(92)     println("\nType 1070 etc");
 264 acc16= stringconstant 316
 265 writeLineString
 266 ;testRead.j(93)     println(read * i);   // 1070 * 1 = 1070
 267 read
 268 acc16* variable 1
 269 writeLineAcc16
 270 ;testRead.j(94)     println(i * read);   // 1 * 1071 = 1071
 271 acc16= variable 1
 272 <acc16
 273 read
 274 acc16* unstack16
 275 writeLineAcc16
 276 ;testRead.j(95)     println(read / i);   // 1072 / 1 = 1072
 277 read
 278 acc16/ variable 1
 279 writeLineAcc16
 280 ;testRead.j(96)     i = 3219;
 281 acc16= constant 3219
 282 acc16=> variable 1
 283 ;testRead.j(97)     println("\nType 3 expect 1073");
 284 acc16= stringconstant 317
 285 writeLineString
 286 ;testRead.j(98)     println(i / read);   // 3219 / 3 = 1073  
 287 acc16= variable 1
 288 <acc16
 289 read
 290 /acc16 unstack16
 291 writeLineAcc16
 292 ;testRead.j(99)     println("Klaar");
 293 acc16= stringconstant 318
 294 writeLineString
 295 ;testRead.j(100)   }
 296 stackPointer= basePointer
 297 basePointer<
 298 return
 299 ;testRead.j(101) }
 300 stringConstant 0 = "
Type 2, 3, 4 etc"
 301 stringConstant 1 = "
Type 1048 etc"
 302 stringConstant 2 = "
Type 1050 expect 2050"
 303 stringConstant 3 = "
Type 1051 expect 2051"
 304 stringConstant 4 = "
Type 1052 expect 52"
 305 stringConstant 5 = "
Type 1053 expect 1053"
 306 stringConstant 6 = "
Type 1054 expect 5254"
 307 stringConstant 7 = "
Type 1055 expect 6424"
 308 stringConstant 8 = "
Type 1056 expect 1"
 309 stringConstant 9 = "
Type 1057 expect 2"
 310 stringConstant 10 = "
Type 1058 etc"
 311 stringConstant 11 = "
Type 1061 expect -1061"
 312 stringConstant 12 = "
Type 1062 etc"
 313 stringConstant 13 = "
Type 3 expect 4"
 314 stringConstant 14 = "
Type 1066 etc"
 315 stringConstant 15 = "
Type 1069 expect -1069"
 316 stringConstant 16 = "
Type 1070 etc"
 317 stringConstant 17 = "
Type 3 expect 1073"
 318 stringConstant 18 = "Klaar"
