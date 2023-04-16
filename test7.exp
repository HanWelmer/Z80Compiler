   0 ;test7.j(0) /*
   1 ;test7.j(1)  * A small program in the miniJava language.
   2 ;test7.j(2)  * Test 8-bit and 16-bit expressions.
   3 ;test7.j(3)  */
   4 ;test7.j(4) class Test8And16BitExpressions {
   5 ;test7.j(5)   /**************************/
   6 ;test7.j(6)   /* Single term read: byte */
   7 ;test7.j(7)   /**************************/
   8 ;test7.j(8)   write(1);          // 1
   9 acc8= constant 1
  10 call writeAcc8
  11 ;test7.j(9) 
  12 ;test7.j(10)   write("Type 2, 3, 4 etc");
  13 acc16= constant 243
  14 writeString
  15 ;test7.j(11)   write(read);       // 2
  16 call read
  17 call writeAcc16
  18 ;test7.j(12)   byte b = read;
  19 call read
  20 acc16=> variable 0
  21 ;test7.j(13)   write(b);       // 3
  22 acc8= variable 0
  23 call writeAcc8
  24 ;test7.j(14) 
  25 ;test7.j(15)   /**********************************/
  26 ;test7.j(16)   /* Dual term read: byte constants */
  27 ;test7.j(17)   /**********************************/
  28 ;test7.j(18)   write(read + 0);   // 4 + 0 = 4
  29 call read
  30 acc16+ constant 0
  31 call writeAcc16
  32 ;test7.j(19)   write(0 + read);   // 0 + 5 = 5
  33 acc8= constant 0
  34 call read
  35 acc16+ acc8
  36 call writeAcc16
  37 ;test7.j(20)   write(read - 0);   // 6 - 0 = 6
  38 call read
  39 acc16- constant 0
  40 call writeAcc16
  41 ;test7.j(21)   write(14 - read);  // 14 - 7 = 7
  42 acc8= constant 14
  43 call read
  44 -acc16 acc8
  45 call writeAcc16
  46 ;test7.j(22)   write(read * 1);   // 8 * 1 = 8
  47 call read
  48 acc16* constant 1
  49 call writeAcc16
  50 ;test7.j(23)   write(1 * read);   // 1 * 9 = 9
  51 acc8= constant 1
  52 call read
  53 acc16* acc8
  54 call writeAcc16
  55 ;test7.j(24)   write(read / 1);   // 10 / 1 = 10
  56 call read
  57 acc16/ constant 1
  58 call writeAcc16
  59 ;test7.j(25)   write(121 / read); // 121 / 11 = 11
  60 acc8= constant 121
  61 call read
  62 /acc16 acc8
  63 call writeAcc16
  64 ;test7.j(26)   
  65 ;test7.j(27)   write("Type 1048 etc");
  66 acc16= constant 244
  67 writeString
  68 ;test7.j(28)   /**************************/
  69 ;test7.j(29)   /* Single term read: word */
  70 ;test7.j(30)   /**************************/
  71 ;test7.j(31)   write(read);      // 1048
  72 call read
  73 call writeAcc16
  74 ;test7.j(32)   word i = read;
  75 call read
  76 acc16=> variable 1
  77 ;test7.j(33)   write(i);         // 1049
  78 acc16= variable 1
  79 call writeAcc16
  80 ;test7.j(34) 
  81 ;test7.j(35)   /**********************************/
  82 ;test7.j(36)   /* Dual term read: word constants */
  83 ;test7.j(37)   /**********************************/
  84 ;test7.j(38)   write(read + 1000);   // 1050 + 1000 = 2050
  85 call read
  86 acc16+ constant 1000
  87 call writeAcc16
  88 ;test7.j(39)   write(1000 + read);   // 1000 + 1051 = 2051
  89 acc16= constant 1000
  90 <acc16
  91 call read
  92 acc16+ unstack16
  93 call writeAcc16
  94 ;test7.j(40)   write(read - 1000);   // 1052 - 1000 =   52
  95 call read
  96 acc16- constant 1000
  97 call writeAcc16
  98 ;test7.j(41)   write(2106 - read);   // 2106 - 1053 = 1053
  99 acc16= constant 2106
 100 <acc16
 101 call read
 102 -acc16 unstack16
 103 call writeAcc16
 104 ;test7.j(42)   write(read * 1000);   // 1054 * 1000 = 5254
 105 call read
 106 acc16* constant 1000
 107 call writeAcc16
 108 ;test7.j(43)   write(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
 109 acc16= constant 1000
 110 <acc16
 111 call read
 112 acc16* unstack16
 113 call writeAcc16
 114 ;test7.j(44)   write(read / 1000);   // 1056 / 1000 = 1
 115 call read
 116 acc16/ constant 1000
 117 call writeAcc16
 118 ;test7.j(45)   write(2114 / read);   // 2114 / 1057 = 2
 119 acc16= constant 2114
 120 <acc16
 121 call read
 122 /acc16 unstack16
 123 call writeAcc16
 124 ;test7.j(46)   
 125 ;test7.j(47)   /****************************************/
 126 ;test7.j(48)   /* Dual term read: word + byte variable */
 127 ;test7.j(49)   /****************************************/
 128 ;test7.j(50)   b = 0;
 129 acc8= constant 0
 130 acc8=> variable 0
 131 ;test7.j(51)   write(read + b);   // 1058 + 0 = 1058
 132 call read
 133 acc16+ variable 0
 134 call writeAcc16
 135 ;test7.j(52)   write(b + read);   // 0 + 1059 = 1059
 136 acc8= variable 0
 137 call read
 138 acc16+ acc8
 139 call writeAcc16
 140 ;test7.j(53)   write(read - b);   // 1060 - 0 = 1060
 141 call read
 142 acc16- variable 0
 143 call writeAcc16
 144 ;test7.j(54)   write(b - read);   // 0 - 1061 = -1061
 145 acc8= variable 0
 146 call read
 147 -acc16 acc8
 148 call writeAcc16
 149 ;test7.j(55)   b = 1;
 150 acc8= constant 1
 151 acc8=> variable 0
 152 ;test7.j(56)   write(read * b);   // 1062 * 1 = 1062
 153 call read
 154 acc16* variable 0
 155 call writeAcc16
 156 ;test7.j(57)   write(b * read);   // 1 * 1063 = 1063
 157 acc8= variable 0
 158 call read
 159 acc16* acc8
 160 call writeAcc16
 161 ;test7.j(58)   write(read / b);   // 1064 / 1 = 1064
 162 call read
 163 acc16/ variable 0
 164 call writeAcc16
 165 ;test7.j(59)   b = 12;
 166 acc8= constant 12
 167 acc8=> variable 0
 168 ;test7.j(60)   write("Type 3 etc");
 169 acc16= constant 245
 170 writeString
 171 ;test7.j(61)   write(3);
 172 acc8= constant 3
 173 call writeAcc8
 174 ;test7.j(62)   write(b / read);   // 12 / 3 = 4
 175 acc8= variable 0
 176 call read
 177 /acc16 acc8
 178 call writeAcc16
 179 ;test7.j(63)   
 180 ;test7.j(64)   /****************************************/
 181 ;test7.j(65)   /* Dual term read: word + word variable */
 182 ;test7.j(66)   /****************************************/
 183 ;test7.j(67)   i = 0;
 184 acc8= constant 0
 185 acc8=> variable 1
 186 ;test7.j(68)   write("Type 1066 etc");
 187 acc16= constant 246
 188 writeString
 189 ;test7.j(69)   write(read + i);   // 1066 + 0 = 1066
 190 call read
 191 acc16+ variable 1
 192 call writeAcc16
 193 ;test7.j(70)   write(i + read);   // 0 + 1067 = 1067
 194 acc16= variable 1
 195 <acc16
 196 call read
 197 acc16+ unstack16
 198 call writeAcc16
 199 ;test7.j(71)   write(read - i);   // 1068 - 0 = 1068
 200 call read
 201 acc16- variable 1
 202 call writeAcc16
 203 ;test7.j(72)   write(i - read);   // 0 - 1069 = -1069
 204 acc16= variable 1
 205 <acc16
 206 call read
 207 -acc16 unstack16
 208 call writeAcc16
 209 ;test7.j(73)   i = 1;
 210 acc8= constant 1
 211 acc8=> variable 1
 212 ;test7.j(74)   write(read * i);   // 1070 * 1 = 1070
 213 call read
 214 acc16* variable 1
 215 call writeAcc16
 216 ;test7.j(75)   write(i * read);   // 1 * 1071 = 1071
 217 acc16= variable 1
 218 <acc16
 219 call read
 220 acc16* unstack16
 221 call writeAcc16
 222 ;test7.j(76)   write(read / i);   // 1072 / 1 = 1072
 223 call read
 224 acc16/ variable 1
 225 call writeAcc16
 226 ;test7.j(77)   i = 3219;
 227 acc16= constant 3219
 228 acc16=> variable 1
 229 ;test7.j(78)   write("Type 3");
 230 acc16= constant 247
 231 writeString
 232 ;test7.j(79)   write(i / read);   // 3219 / 3 = 1073  
 233 acc16= variable 1
 234 <acc16
 235 call read
 236 /acc16 unstack16
 237 call writeAcc16
 238 ;test7.j(80)   write("Klaar");
 239 acc16= constant 248
 240 writeString
 241 ;test7.j(81) }
 242 stop
 243 stringConstant 0 = "Type 2, 3, 4 etc"
 244 stringConstant 1 = "Type 1048 etc"
 245 stringConstant 2 = "Type 3 etc"
 246 stringConstant 3 = "Type 1066 etc"
 247 stringConstant 4 = "Type 3"
 248 stringConstant 5 = "Klaar"
